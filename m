Return-Path: <stable+bounces-220738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOxoCJtBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8381C7016
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFBE6312F33B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56219401480;
	Sat, 28 Feb 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdP4ND62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182094014A7;
	Sat, 28 Feb 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300619; cv=none; b=syU4DXWa42k4IwPrAWSDSTxRG/n/+SePC0AXHi0vTTgVtxriXNruFQjb33x5PKlPV9n4YMHiviWzlk+nuhsEAO8JLfziwFHTCIb1xl+p9GGZ1boYSytF1xFSVHtANTqvLcAaOuH6zsD8uTuJpZufqQkx338uOa/z5+zHVbs78vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300619; c=relaxed/simple;
	bh=WuxCK1wydY82CCy7fyUfGoYlroN8zPTI2IvEl3U21/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdI9SRtJDRLGd4Fed4lvF+gnOPB/GUj2YgBCsjV7NZmiJODAKqM1jc44ktNWAox8ZOIVN9XCgUBIGCz+iK9nZK0UCug+9hnNtbr6ep5jzaUXXLjAsk8g+ObeD/fJ++jkqxuH11z6eb/G0mQkXlR6guIYaA0ysm3RHPt8Xmhhr/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdP4ND62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C23C19423;
	Sat, 28 Feb 2026 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300619;
	bh=WuxCK1wydY82CCy7fyUfGoYlroN8zPTI2IvEl3U21/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdP4ND62rV0uC+//Gt2sJE8EhVXDZ1/uAJy8r6MVqy+HydGy8XId+x9RJ3fzck9ZH
	 WJIaikWLHBOowKSeHeG4jVvujNabaEv3soBvIcmKWEOVECzHOgkI1JCx5GIfTLadbC
	 P23HwIZMQ9TWwiGqh6cPeXSeEwX3lKMRNgpAG/eg2hTrOceUAh3skBIGZclR78Fot8
	 MFhd5CKHh0hoFDMZhQlRxJ3+CGSNPgh6cZDTdYuSO+KPJ4C/JwvGH7rOVdvXQaq8i2
	 Mdj2bJA2+um9G33Hr4ZkgD20kLJZTu0b3UNJXI+8q0NaKCa6qgDuDIaKu2SrSxASpd
	 3dyWRLtqFwDdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yi Liu <yi.l.liu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 659/844] iommu/vt-d: Flush piotlb for SVM and Nested domain
Date: Sat, 28 Feb 2026 12:29:32 -0500
Message-ID: <20260228173244.1509663-660-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220738-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: CA8381C7016
X-Rspamd-Action: no action

From: Yi Liu <yi.l.liu@intel.com>

[ Upstream commit 04b1b069f151e793767755f58b51670bff00cbc1 ]

Besides the paging domains that use FS, SVM and Nested domains need to
use piotlb invalidation descriptor as well.

Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each stage")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20251223065824.6164-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/cache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 265e7290256b5..385ae5cfb30d4 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -363,6 +363,13 @@ static void qi_batch_add_pasid_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
 	qi_batch_increment_index(iommu, batch);
 }
 
+static bool intel_domain_use_piotlb(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_SVA ||
+			domain->domain.type == IOMMU_DOMAIN_NESTED ||
+			intel_domain_is_fs_paging(domain);
+}
+
 static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
 				  unsigned long addr, unsigned long pages,
 				  unsigned long mask, int ih)
@@ -370,7 +377,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (intel_domain_is_fs_paging(domain)) {
+	if (intel_domain_use_piotlb(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
-- 
2.51.0


