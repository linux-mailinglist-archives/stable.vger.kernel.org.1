Return-Path: <stable+bounces-178972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B503B49B91
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 23:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54647A6B6B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891E2DCF61;
	Mon,  8 Sep 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDPw6/la"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718047F4A
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365857; cv=none; b=C6tnnNHrjgNvDBoDbiAZe7lwU+TcP/lZ2LtUtK/KRgyy4nynEC12D2ezNeyuLlY3AMV66VUvC1S3RpyR55kpUzyKN232soEz3NYcFGTBo+w6R7DX2kRxpWDH9ecb5AbATF+jrboSkt5TyxIPbSk9L2aq2WaDrtAjGJB+NEHJcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365857; c=relaxed/simple;
	bh=4sC2KbBI3ayiLkgTJYedDXF7MLDMV8qLrOYLLtjooPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik/4SiYZRfNZoni1kbthIxVYvYb0Epw33fgzodReCYbabMuT6XvmoVYaG7CpzBT9Yke1z0tq4xPo4RaZRUCK8pXkGVh52sASUWYn+WhkFsjxZ1yvaEUjBerzOVpQ7kapTQ3DZiUSCcUY1SPKm5ys/XsFYXg+WiP3obTfjWhRD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDPw6/la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D0C4CEF1;
	Mon,  8 Sep 2025 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757365857;
	bh=4sC2KbBI3ayiLkgTJYedDXF7MLDMV8qLrOYLLtjooPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDPw6/lauL4guH0InD0GevsPeAakCysKGFrrkT+YsoNcHn7A7NOzrQskFh8Y7YQ+h
	 Zk21eige5X1nO6lAuoBdjOn0VvF1UKZIKM9PEz8iicxvxSItRGit9pHMnmESR1ipTW
	 nQesFdZlhRbBKybvY9mvHIW0PIiIJq74BdXpqfaZUYFtBeDfwbxGODDbAKClRq/YyN
	 J7wcUVaXdWTb7uLchwE+IvgTRkNaXWahJP18axXbvtLusAm7bH2u/Bss8TPyCmn+i6
	 nBki8LIkMKQ8AxL1EFdThVkw4eqBF3Vcs9BWPlEUjrmNZcCzc/DPotJgAK2XKSNfjw
	 AcFtqwlDDCowg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexandre Courbot <acourbot@google.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning
Date: Mon,  8 Sep 2025 17:10:54 -0400
Message-ID: <20250908211054.2351463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041752-utensil-affront-c113@gregkh>
References: <2025041752-utensil-affront-c113@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 07df4f23ef3ffe6fee697cd2e03623ad27108843 ]

This is one of three clang warnings about incompatible enum types
in a conditional expression:

drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c:597:29: error: conditional expression between different enumeration types ('enum scp_ipi_id' and 'enum ipi_id') [-Werror,-Wenum-compare-conditional]
  597 |         inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
      |                                    ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~~

The code is correct, so just rework it to avoid the warning.

Fixes: 0dc4b3286125 ("media: mtk-vcodec: venc: support SCP firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@google.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ Adapted file path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index b6a4f2074fa57..97c9fa0b7ff13 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -513,7 +513,11 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
-	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
+	if (is_ext)
+		inst->vpu_inst.id = SCP_IPI_VENC_H264;
+	else
+		inst->vpu_inst.id = IPI_VENC_H264;
+
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
-- 
2.51.0


