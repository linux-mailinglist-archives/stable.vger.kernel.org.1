Return-Path: <stable+bounces-255979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD/mB5inGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE415F926F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73EC5303F83F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86432AAD6;
	Thu, 28 May 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAlWK6wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D29223328;
	Thu, 28 May 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000414; cv=none; b=QKtlqcxnOu/Q956yYPZVWvq/d/H5++ZRK3Suh54kadzscpNDcPLUMs6Jkz4fO00STmQljsX8/wZZFCiJP96XUfrX/2qhzP0ScJdGxjTeLlvb4CVJv6SNtzWhpJlzRZiSu9Sd3J0LcsDJO6tSs7GxPLTYROwM2K/Y1qshpQEdm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000414; c=relaxed/simple;
	bh=MRyGqomhweGIY68ABxui6jcEbmloSeTQDATHMseNmYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlHDe2SnWoMlWeCT6IAzqf3XOCrdy4MmsQady/gD7Z7+uAmdkYVwP0gMsHGW82u3wYlrAAwHrv20VTBXrDQ4LGcitbg6IFhdO5QPLZxEplb4BT10I/B7/R8h7T+zk4wTdT17NV9ksUCtM6LYQ+sCLdS/G2OvN2izpa7G8V4HKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LAlWK6wN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E771F000E9;
	Thu, 28 May 2026 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000413;
	bh=pSOWgaFNMUtAhCmU+TQ5EqhUxs+KiZJg4R6aBsjTfrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAlWK6wN+Ho/2S8prhMGGRKD8oDWhn2ZT+28muvXfcjtYVw9JtVN3uGDRZ/WEOMyY
	 Ketc6pXKr0JSz91qimtIX5zbksve2pcf9M2NzDwBkJ0ntmvQiIkz1YfgNP0ijt/msU
	 +gTToX9W/vF4v/5wbWktF+qQL6MNrWWl2yGRyy6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Gyokhan Kochmarla <gyokhan@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 036/272] iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set
Date: Thu, 28 May 2026 21:46:50 +0200
Message-ID: <20260528194630.395140168@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255979-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amazon.de:email,suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFE415F926F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit cf08ca81d08a04b3b304e8fb4e052f323a09783d upstream.

When a device uses a PASID for SVA (Shared Virtual Address), it's possible
that the PASID entry is marked as non-present and FPD bit set before the
device flushes all ongoing DMA requests and removes the SVA domain. This
can occur when an exception happens and the process terminates before the
device driver stops DMA and calls the iommu driver to unbind the PASID.

There's no need to drain the PRQ in the mm release path. Instead, the PRQ
will be drained in the SVA unbind path. But in such case,
intel_pasid_tear_down_entry() only checks the presence of the pasid entry
and returns directly.

Add the code to clear the FPD bit and drain the PRQ.

Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from RID")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241217024240.139615-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/pasid.c | 22 +++++++++++++++++++++-
 drivers/iommu/intel/pasid.h |  6 ++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3d1d43675bf22..74be6b547fc0c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -245,11 +245,31 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+	if (WARN_ON(!pte)) {
 		spin_unlock(&iommu->lock);
 		return;
 	}
 
+	if (!pasid_pte_is_present(pte)) {
+		if (!pasid_pte_is_fault_disabled(pte)) {
+			WARN_ON(READ_ONCE(pte->val[0]) != 0);
+			spin_unlock(&iommu->lock);
+			return;
+		}
+
+		/*
+		 * When a PASID is used for SVA by a device, it's possible
+		 * that the pasid entry is non-present with the Fault
+		 * Processing Disabled bit set. Clear the pasid entry and
+		 * drain the PRQ for the PASID before return.
+		 */
+		pasid_clear_entry(pte);
+		spin_unlock(&iommu->lock);
+		intel_iommu_drain_pasid_prq(dev, pasid);
+
+		return;
+	}
+
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
 	pasid_clear_present(pte);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 55cad7bfa294e..8ffb01163f0e6 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -80,6 +80,12 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
+/* Get FPD(Fault Processing Disable) bit of a PASID table entry */
+static inline bool pasid_pte_is_fault_disabled(struct pasid_entry *pte)
+{
+	return READ_ONCE(pte->val[0]) & PASID_PTE_FPD;
+}
+
 /* Get PGTT field of a PASID table entry */
 static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
 {
-- 
2.53.0




