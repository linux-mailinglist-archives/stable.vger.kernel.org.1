Return-Path: <stable+bounces-178977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB68DB49C4F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 23:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46154E1046
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356222DECD6;
	Mon,  8 Sep 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmNpmiJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CD20C004
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367841; cv=none; b=jlxKXdlTgXXcR3NVjWWTpoFtV3zuuGoFirpAAShsX+D+gVIW48ThKv0z3+FBM6Q/H5InrQJB0WuIt1AjmlWuhbQIdtS7DvVMUCVoRW7pXdw9naV4axhRpgCEY9aC5ZNfw4EwlKR+6wmwMEI9ITt9emVxVPcHiaK4OGnakyT2GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367841; c=relaxed/simple;
	bh=iN/vvrjlSgGdMEN9GMS7TF9WPtNDQ+bBYx1At+XMbo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH4Fq06RivH3IIcouUL8gw1wpCtJrveM/GJbQ0hgWn4agY6iN4SV6Z5Trz2EyC36NMo2PBlWGATTxaO2rBzv9LGCMUwBEmTcR68hqYoEN2k7Uh73sbEKj7q48roZDYZ85GaFGbcOE8RenG9dEoPQNeqZYHJnP/XfocJ78V8gCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmNpmiJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACBC4CEF1;
	Mon,  8 Sep 2025 21:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757367840;
	bh=iN/vvrjlSgGdMEN9GMS7TF9WPtNDQ+bBYx1At+XMbo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmNpmiJwW0hWosaUu+Za+BxzVEznPk2lC5Tw1An1L7TwfRoRnXCnN61ymssDYfhpc
	 QMSbAyNFMM7/XQggxhi+odEPxhJc6pStJPD3kRUH2XdJ93KWg/5P4U3f8H2Vfbkfi0
	 o06SPREN6GyyIE4le8cmx+wkWlefuoaM75/U7jqMLrj2ZblOik/u5Z1afvWWa3sTYu
	 3j0tbJdjfytrXY1mNuf8wXXmBxNlKltp7Cp8QV35GFqYI+auYNEv0MV6R+MRua5ef+
	 vZHiAO/rjkUt5CaJefJqJP9G8DTNnN9SE4t9TgEwXxOSFnSxwyYmHXyDVSSzI3BNYs
	 jjDF1oqPH0kXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexandre Courbot <acourbot@google.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning
Date: Mon,  8 Sep 2025 17:43:58 -0400
Message-ID: <20250908214358.2431222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041757-suffix-chevron-2444@gregkh>
References: <2025041757-suffix-chevron-2444@gregkh>
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
index d0123dfc5f93d..ea305f6f49ed3 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -509,7 +509,11 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 
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


