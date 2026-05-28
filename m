Return-Path: <stable+bounces-255880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPL6BLWmGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64ED5F8F8F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16B7B305B63C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F94330650;
	Thu, 28 May 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8Q5XBFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A890301472;
	Thu, 28 May 2026 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000136; cv=none; b=OPSoGCDiPX2rXjaQDJuWV9pkHHpcET2Pnwz7e9+Hn6et5QcO/Cec5dman158pQCUBHCBeHtcwEB3TqpE2zbQXvf0V7VsqdJwyl8P52Pn8rvixI2hhSF5EcDUcZf8EnhHfXwk0lRcWipBUsgf0a0bxhvXljjwPEXwwrRaWXf16Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000136; c=relaxed/simple;
	bh=IqOeDBAuKERLiQ4YLNci/oYeJVUsQ8Ik8tEJ0FrF7fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnJ8zCfsQfrLJYc4sWPtVNeEBSHL6fhvHj+XO14VIrPBxkNKoKalwWiJLw0LA0Zi+T1w5GU5XBhkn+w1b74t7gxDjXbZBOCiX+W+v7abNI/wMbyfKVQmVfloedBOO4cEc9UiKIfEAOcZ32E4cxyrR9wmGI1L6aplqT2Ljr6uMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8Q5XBFz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40F41F000E9;
	Thu, 28 May 2026 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000135;
	bh=sU1gpgELlApdovt07wRDP/vav2hJEbZCcdbzzVNtqrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8Q5XBFz43UXaqUJxhe2etUAgCd3lg8tRPyZ44lNPJnTt0xcK3bRHHMTuukoHUdd5
	 OD4ytyZIHdhsWnciHSe7ZBXB2gxx3/oOzaaSZXbRNfF7UQ6OjqxF+ErbOX0fQokwtK
	 WiSjTHNfVfWzowvf+OjNDYN4tJ4ToB240lnhFiZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 278/377] drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN
Date: Thu, 28 May 2026 21:48:36 +0200
Message-ID: <20260528194646.407037204@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255880-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,nvidia.com:server fail,patchwork.freedesktop.org:server fail,qualcomm.com:server fail,sto.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,patchwork.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C64ED5F8F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index a188617653e85..82a172f21a3ec 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -677,7 +677,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 			 int prot)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	size_t ret;
+	ssize_t ret;
 
 	WARN_ON(off != 0);
 
@@ -686,7 +686,8 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 		iova |= GENMASK_ULL(63, 49);
 
 	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
-	WARN_ON(!ret);
+	if (ret < 0)
+		return ret;
 
 	return (ret == len) ? 0 : -EINVAL;
 }
-- 
2.53.0




