Return-Path: <stable+bounces-178964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC1B49B31
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1918848E8
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39E22A4EA;
	Mon,  8 Sep 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzFDyg/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA271798F
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364394; cv=none; b=C386IeUIJLOed5UkmOGMZmh7YqY2FZmH17QwHUR88qrU3YsEfx4sMFd6xbtju9JZm/yQ0CV8GaEZ6aX0K2v4CzmW3bNHjo03TQuHjReOG9o/Vzzfuz22ImSlsP0xb0hRYl4sCidDzLiheumPhaBtpjA6jjG4A83yGFHH1imjBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364394; c=relaxed/simple;
	bh=i/tDzTds1v48cZiEkN7laH9dGdFx8PNlqIXD4YiNf10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY1g88oCSzMczaTN85cuHwtxK8sT4KpnB2eN5w4Y0BwXp0TqPJFvrTVQzkJX+7cjwKoiHGftiF4ST1MKN+Nkm25VATaGRnWNuCbanUL0Ti3XMZSTYOrZ5W2fnyxJzWFX/i6Kvr+WUS9lAJyntbFSvF6czfaXlCe6FZYqrM7k+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzFDyg/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6703EC4CEF1;
	Mon,  8 Sep 2025 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757364394;
	bh=i/tDzTds1v48cZiEkN7laH9dGdFx8PNlqIXD4YiNf10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzFDyg/DDvxreShVkDmKPyB4tonGLlao5DtDn8Tnu18mEmfWl8fCKmVFww90lCMHF
	 LsbVdrMDZNFw05o1yva+XbB6AWa4nUgyqKQM3886pnODiTHxpc2KajOiV1ESp3QCtq
	 D34Zlrq4wWnWV+T9a9qNUex80al9CMoYpspDGghado08XNGhnJUhve/vJufUu33NRS
	 WEn8Sp8IzgdnXuioLvIBwBzxIniHnw/2raFINKlFM4II7KGMV2d0csvSpS4Yr83qJh
	 8hUATb0CDXxcMShMy7G6KuM1sPYbMafnXX29Yj232q2ZMB4sN9C1IMh04Nt6K3qfTf
	 Jy56FqM/GVYHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexandre Courbot <acourbot@google.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning
Date: Mon,  8 Sep 2025 16:46:31 -0400
Message-ID: <20250908204631.2336472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041751-dimple-antiquely-856c@gregkh>
References: <2025041751-dimple-antiquely-856c@gregkh>
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
[ Adjust file paths ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 13c4f860fa69c..dc35ec7f9c049 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -611,7 +611,11 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 
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


