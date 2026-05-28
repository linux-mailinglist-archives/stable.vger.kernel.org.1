Return-Path: <stable+bounces-256359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAThKx+tGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC95FA124
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C9B3048ACC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1A330B32;
	Thu, 28 May 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdQ5Y02u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9302F260C;
	Thu, 28 May 2026 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001480; cv=none; b=Jh2J0Y8eTBjucIX05A+2dWgR6hcswHBeOz4qPO3uWwT0qd7RQbXRoYJSR/XkDT97Qs4GHKnBvwmzDBfk4znv2MV7FcH9jeOF9j6P2+MFrdIZmvNL3vKT24IozrdHaivFyPdnVLKhK0U/iCGEs+4NB1dqidNx5TH2LsrvR+WKu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001480; c=relaxed/simple;
	bh=3hyf3K5ELfbbfNuV1w2s6d9KjQEFnzGOSxnSb1px4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSiYirBRMadYYIquWIMcfi+O0zMhlj42/xZSg1rY4GjBS4828NfQiE4lxkPsk43Kybw71uBEGM17qbxMvBHe6h+AqtIpgsOmSgXXMQI/OmXC/grMp8v5PmDZbOQZwJnW2i+Q8kjiPT/B7MW7Kk+HF/rtyzzEViXPKW1zZe7AiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdQ5Y02u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7873C1F000E9;
	Thu, 28 May 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001479;
	bh=3zNIXbL9z0qlhjllyJhFkVMu3R1mXhKBC6ypAvOB7uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdQ5Y02uAsWXK5+T0PHh39DSXfj65pHde8bR0imow2anu66InehqX9fTCik/kuadp
	 tcUthN450bEaX3/OsnpXz10HxkBCzKW621y12XdIpVSDsdziRnECnJDbiObWUs4LHK
	 RcdwSFGL7WTsl+Xipx9BLOSoiwLQ4/CdwQiYxcos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 141/186] drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN
Date: Thu, 28 May 2026 21:50:21 +0200
Message-ID: <20260528194932.758133636@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256359-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,patchwork.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0CBC95FA124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikko Perttunen <mperttunen@nvidia.com>

[ Upstream commit 55e0f0d1c1a4ee1e46da7da4d443eb3044fb3851 ]

Commit "iommu: return full error code from iommu_map_sg[_atomic]()"
changed iommu_map_sgtable() to return an ssize_t and negative values
in error cases, rather than a size_t and a zero.

Store the return value in the appropriate type and in case of error,
return it rather than WARNing.

Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Patchwork: https://patchwork.freedesktop.org/patch/719685/
Message-ID: <20260421-iommu_map_sgtable-return-v1-3-fb484c07d2a1@nvidia.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index d5512037c38bc..10d068fdfebd0 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -362,14 +362,15 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 		struct sg_table *sgt, size_t len, int prot)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	size_t ret;
+	ssize_t ret;
 
 	/* The arm-smmu driver expects the addresses to be sign extended */
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
 	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
-	WARN_ON(!ret);
+	if (ret < 0)
+		return ret;
 
 	return (ret == len) ? 0 : -EINVAL;
 }
-- 
2.53.0




