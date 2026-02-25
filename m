Return-Path: <stable+bounces-219025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ66CJlYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4C190783
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B974B3129CF1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D92701D9;
	Wed, 25 Feb 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OWuUbnhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7626F46F;
	Wed, 25 Feb 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983939; cv=none; b=Dj03W+XT0QcFKhDSRSaKhdT5MsH8yDrJakY3JjUhPOanWMnGRyGip8jvmCOfdYxcrJNFpgwK76Q9CZJpWtZYCra20HWAKR+zB8LiYfM/j/lSwl90D1DMGUaAmQlhLHgU/HzS8c2W/tH9Wfu72H/yv7FgaGmCeaLDMeAbrnGgxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983939; c=relaxed/simple;
	bh=mZeFuT55887nhBL7CAVYqAT5Mj4iFTwWB9HJl4y+YEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKGzlGA5rJzX5FOIZ6tqTeQ41P/fNDFiqp9LS/sdNAa8a+t2/UGS1Q116zHjfP9RaWjCIgLbseqbyTFSlmC6oGttQqM2WFpE/evNiFu3jEi1qAzy2QnR7ogUoCYfawjyBLng45huMo3EpYbshDknxG4ESe+BkWfh88rZdKenmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OWuUbnhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1007AC116D0;
	Wed, 25 Feb 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983939;
	bh=mZeFuT55887nhBL7CAVYqAT5Mj4iFTwWB9HJl4y+YEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWuUbnhzwbhJFqFTXOml7lVh9J3VeuOUfw+Ry5/pdimtMAt9SQsyeCNI578NOkXWY
	 0qpO91uWgL2m9IXZPrcLX0Sez1ctim/47zNRXSmI2LgniiPPAAqIptVE9NsSIWzcs2
	 SoW9FcCGQ3NUg55CRu7qVEx748iKmZWg0s8bKtLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 203/641] drm/msm/a2xx: fix pixel shader start on A225
Date: Tue, 24 Feb 2026 17:18:49 -0800
Message-ID: <20260225012353.887407589@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219025-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 53F4C190783
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 6a7b0a670ba4d283285d76d45233cbecc5af5e40 ]

A225 has a different PixelShader start address, write correct address
while initializing GPU.

Fixes: 21af872cd8c6 ("drm/msm/adreno: add a2xx")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/689906/
Message-ID: <20251121-a225-v1-1-a1bab651d186@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 963c0f669ee50..e67ed58aa3d8f 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -77,7 +77,10 @@ static bool a2xx_me_init(struct msm_gpu *gpu)
 
 	/* Vertex and Pixel Shader Start Addresses in instructions
 	 * (3 DWORDS per instruction) */
-	OUT_RING(ring, 0x80000180);
+	if (adreno_is_a225(adreno_gpu))
+		OUT_RING(ring, 0x80000300);
+	else
+		OUT_RING(ring, 0x80000180);
 	/* Maximum Contexts */
 	OUT_RING(ring, 0x00000001);
 	/* Write Confirm Interval and The CP will wait the
-- 
2.51.0




