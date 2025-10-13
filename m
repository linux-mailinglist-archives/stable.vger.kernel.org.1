Return-Path: <stable+bounces-185148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F273BD5125
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CE91562B49
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39595309F10;
	Mon, 13 Oct 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUQi77q9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CDE30AAC0;
	Mon, 13 Oct 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369470; cv=none; b=qqHqY23v1mMVe5juDufuR5NX+Xo7rN2ya6ymrSC/CvHX5/jLBRBB+SbBxBGgYJOnDnw7g32J8/lnWoUm0kvSze5Pyz7/i2kgaQq4EQ+ZvZSlu+s0pRe9LpV5iIyyhk+1osSyl4M5pRjYAKYTgVq1Dp/CU5L4+ao+hO6kuUmLQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369470; c=relaxed/simple;
	bh=td3/PoSQATC12nR6t7ymnPxLhZV/RPHlJ2DqLMjeeq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJunFsHQvEFeZDYsX1ez8Rkliftih6j2w2eiutBasXOOxbeIPgV4ezaZsOJB1LhOn+UqtyekC3IkMDqQOO0uZxWwd85crzNx/yUaUbQ5p2Xc4Fn1k5DiNiGYTjUvIJKCqGFDen23nFHYKW6VotK1Rr6N9goFq5W48GbZgIB/APo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUQi77q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BB1C4CEE7;
	Mon, 13 Oct 2025 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369469;
	bh=td3/PoSQATC12nR6t7ymnPxLhZV/RPHlJ2DqLMjeeq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUQi77q9FZBetcThA7SGX2PQlgNrJuryb/n6xb6rV9Q9u+0/FlrowULXHI76q0r4U
	 naw6AyNTb4Am4jroo6pC8EFO/+Kk9TPDuZrodIVlItFtgB0+ywPOOquH54Aqe42g7d
	 zH1opd3Eni5qbcOPc+rLIn/2Qew9PJvsGHZPZjmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 257/563] crypto: octeontx2 - Call strscpy() with correct size argument
Date: Mon, 13 Oct 2025 16:41:58 +0200
Message-ID: <20251013144420.589810038@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 361fa7f813e7056cecdb24f3582ab0ad4a088e4e ]

In otx2_cpt_dl_custom_egrp_create(), strscpy() is called with the length
of the source string rather than the size of the destination buffer.

This is fine as long as the destination buffer is larger than the source
string, but we should still use the destination buffer size instead to
call strscpy() as intended. And since 'tmp_buf' is a fixed-size buffer,
we can safely omit the size argument and let strscpy() infer it using
sizeof().

Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index cc47e361089a0..ebdf4efa09d4d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1615,7 +1615,7 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		return -EINVAL;
 	}
 	err_msg = "Invalid engine group format";
-	strscpy(tmp_buf, ctx->val.vstr, strlen(ctx->val.vstr) + 1);
+	strscpy(tmp_buf, ctx->val.vstr);
 	start = tmp_buf;
 
 	has_se = has_ie = has_ae = false;
-- 
2.51.0




