Return-Path: <stable+bounces-228195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMUuGwVRwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A75192F4FAC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F23B0310FEFD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB43BA25F;
	Mon, 23 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xR3161IB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4203BA252;
	Mon, 23 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274412; cv=none; b=QmzSxXWb0EgHFFOjSd6XZ9JVQmyLZEqZZ6Juw5NwGAKbksdRFMyg19neBkyXRXv9asxiSPmo28zHwT/3x/Hzw4czc5FJhYemuiL6RXvuSZ4DXV0tWFnx8ejNYMdsUD0lDrEyL+RZBsopNyuWSLulGRXbz+S2/BobBePNVTh+XIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274412; c=relaxed/simple;
	bh=9ncozbRRlZC1rSgdD1jgslGFXfvZC802+gp4gw5WRnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWc+gyAPOqGpJ2OasjYBTdlDJhJVNnjypQm2+DrwTxgzg4uIGX8etX6WTFkdZLQ9D28wbCNunaJrqP+FIdZKBk5ZXo8dmr4G7N1c0TM5+6m/gRr2jWerK5yNP0pxaDgXTV608sHu3wQYtvOtUxHHeE1oW9A7Bvh/U0LsZhyHHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xR3161IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBBFC2BC9E;
	Mon, 23 Mar 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274412;
	bh=9ncozbRRlZC1rSgdD1jgslGFXfvZC802+gp4gw5WRnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xR3161IBzSpIvcCV+VFTMliO8mzNHCPpMkN16yqCKF3hedmA4svqW5OpWBG6QmhfZ
	 SCNd4VqRzkRWF4gja8Hj9nfe8xIAI9k+GjXr8vGUp0NVWhlPrKYkT3s3ERScsQoQEX
	 Fo7HfqOPwRoBwzIwkimPCl/3Qk2KBiaGIRdtcKfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 207/220] iommu/sva: Fix crash in iommu_sva_unbind_device()
Date: Mon, 23 Mar 2026 14:46:24 +0100
Message-ID: <20260323134511.098960498@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228195-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A75192F4FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 06e14c36e20b48171df13d51b89fe67c594ed07a ]

domain->mm->iommu_mm can be freed by iommu_domain_free():
  iommu_domain_free()
    mmdrop()
      __mmdrop()
        mm_pasid_drop()
After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
dereference a freed mm structure, leading to a crash.

Fix this by moving the code that accesses domain->mm->iommu_mm to before
the call to iommu_domain_free().

Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-sva.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index e1e63c2be82b2..fd735aaae9e3f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -182,13 +182,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
-		iommu_domain_free(domain);
-	}
+		if (list_empty(&iommu_mm->sva_domains)) {
+			list_del(&iommu_mm->mm_list_elm);
+			if (list_empty(&iommu_sva_mms))
+				iommu_sva_present = false;
+		}
 
-	if (list_empty(&iommu_mm->sva_domains)) {
-		list_del(&iommu_mm->mm_list_elm);
-		if (list_empty(&iommu_sva_mms))
-			iommu_sva_present = false;
+		iommu_domain_free(domain);
 	}
 
 	mutex_unlock(&iommu_sva_lock);
-- 
2.51.0




