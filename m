Return-Path: <stable+bounces-171089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58962B2A79A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797365876A2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD057335BD4;
	Mon, 18 Aug 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sT5rt3JW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AF335BA7;
	Mon, 18 Aug 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524780; cv=none; b=ipIIaw6mCVNFKgY262yM1TuqbyDBRJ+pxuot4Xg8OMHstSSW4gFFod4wftgldlKCNkQMuRKUbTnMeXM3iZsb+ztjJtqyXcFlaJHNnsB8U5nk7JXKWoznm7lgKGj9ZQaYF3jGy483KPzEpzSikuOHhwnUjdjBqAGAOOKl59F8W6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524780; c=relaxed/simple;
	bh=3nUEpa6KnKIvRoe5ejgx76Y3iBX6wSOzMpdqLCsdMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNAyeqoYNitX/CrT2Y4OW9SX+gtAfPMAuBD0o8olmoSgdSRK2No+lLn//tOFXK0qF/dgnX236/njCt2vTmjbamsCurVCm4jwbjYhLAQ4JoP4uzPyuasV0A3d0tdYcRW91A1e9uJLDExAMgRf3pdcjoE7P3tUVBZf62LNa9/dCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sT5rt3JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E8EC4CEEB;
	Mon, 18 Aug 2025 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524780;
	bh=3nUEpa6KnKIvRoe5ejgx76Y3iBX6wSOzMpdqLCsdMCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT5rt3JWnP0aRPmxb4vWrGGAJJ2G9cYUtpslL3UAWgI9kK6Fiek2Tz3ZPeeqbh29Q
	 30wFffC8SdlQkMUw9I8BHXFmcubwn/H2Bq7yIiX5vJ77wC6OI1oqyVXnHqQXo63fvf
	 8vYTIdjkqXQEj96T5xZJ2WJwVeMl002hjzfwVPkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 059/570] habanalabs: fix UAF in export_dmabuf()
Date: Mon, 18 Aug 2025 14:40:46 +0200
Message-ID: <20250818124508.095635773@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 33927f3d0ecdcff06326d6e4edb6166aed42811c ]

As soon as we'd inserted a file reference into descriptor table, another
thread could close it.  That's fine for the case when all we are doing is
returning that descriptor to userland (it's a race, but it's a userland
race and there's nothing the kernel can do about it).  However, if we
follow fd_install() with any kind of access to objects that would be
destroyed on close (be it the struct file itself or anything destroyed
by its ->release()), we have a UAF.

dma_buf_fd() is a combination of reserving a descriptor and fd_install().
habanalabs export_dmabuf() calls it and then proceeds to access the
objects destroyed on close.  In particular, it grabs an extra reference to
another struct file that will be dropped as part of ->release() for ours;
that "will be" is actually "might have already been".

Fix that by reserving descriptor before anything else and do fd_install()
only when everything had been set up.  As a side benefit, we no longer
have the failure exit with file already created, but reference to
underlying file (as well as ->dmabuf_export_cnt, etc.) not grabbed yet;
unlike dma_buf_fd(), fd_install() can't fail.

Fixes: db1a8dd916aa ("habanalabs: add support for dma-buf exporter")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 601fdbe70179..61472a381904 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1829,9 +1829,6 @@ static void hl_release_dmabuf(struct dma_buf *dmabuf)
 	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
 	struct hl_ctx *ctx;
 
-	if (!hl_dmabuf)
-		return;
-
 	ctx = hl_dmabuf->ctx;
 
 	if (hl_dmabuf->memhash_hnode)
@@ -1859,7 +1856,12 @@ static int export_dmabuf(struct hl_ctx *ctx,
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct hl_device *hdev = ctx->hdev;
-	int rc, fd;
+	CLASS(get_unused_fd, fd)(flags);
+
+	if (fd < 0) {
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
+		return fd;
+	}
 
 	exp_info.ops = &habanalabs_dmabuf_ops;
 	exp_info.size = total_size;
@@ -1872,13 +1874,6 @@ static int export_dmabuf(struct hl_ctx *ctx,
 		return PTR_ERR(hl_dmabuf->dmabuf);
 	}
 
-	fd = dma_buf_fd(hl_dmabuf->dmabuf, flags);
-	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
-		rc = fd;
-		goto err_dma_buf_put;
-	}
-
 	hl_dmabuf->ctx = ctx;
 	hl_ctx_get(hl_dmabuf->ctx);
 	atomic_inc(&ctx->hdev->dmabuf_export_cnt);
@@ -1890,13 +1885,9 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	get_file(ctx->hpriv->file_priv->filp);
 
 	*dmabuf_fd = fd;
+	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
 
 	return 0;
-
-err_dma_buf_put:
-	hl_dmabuf->dmabuf->priv = NULL;
-	dma_buf_put(hl_dmabuf->dmabuf);
-	return rc;
 }
 
 static int validate_export_params_common(struct hl_device *hdev, u64 addr, u64 size, u64 offset)
-- 
2.50.1




