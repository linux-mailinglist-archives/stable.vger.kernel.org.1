Return-Path: <stable+bounces-184505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB5BD409F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FD3188553B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7651C309EF2;
	Mon, 13 Oct 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIlHs5ET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115F24A06A;
	Mon, 13 Oct 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367630; cv=none; b=KQDcsTYLBLX0JVgETLsNTDc2nkA2vTS7Y43av0TjP9Ms16p29RBar+NsFVNki27gCaCUc4qr5gpqOxA1VHW2iVbUplsHV/A1sS2+YKCxMmL992YSE/KzW8LOJcSp8odEJjOkaBPCTX7PCIHkHeuXUV8v+HA1aousveX3UeLykgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367630; c=relaxed/simple;
	bh=qqKmCwLv+cvuT/Mk6evSTsJG5itwFLmt64tB9MDEcKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku+vcIlZ6pG2fnrIavRoQZ5ie4yqOq5uTfKiECYyB5DN8s1b/xMBkR2+1XHQCgc+mfAj7ySGmxKpdeIabWonxbHuqE2/ASFE2l8Enj9+t/U+IVgRBrmt5EZ7iONxGuIGR6zkmpQvrZ8sEhCkLmDQiju+NlSEJXM7q3b/BPh7F1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIlHs5ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0328C4CEE7;
	Mon, 13 Oct 2025 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367630;
	bh=qqKmCwLv+cvuT/Mk6evSTsJG5itwFLmt64tB9MDEcKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIlHs5ETi3BCxN5QLmRY3xVzdX1e7Pj9bXEjRjAx19p6TUoPlPAifhqSdEF4zx0d9
	 mk/Zz07VZ8qz1hPWqxkm7vQ8stxfond3KWEHczFektqm8AA9HfDB31wcke8E+eXHDQ
	 fCJvu/3iNz17xzhW97CEwUgAhvZuz62Sf0XOahNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/196] media: st-delta: avoid excessive stack usage
Date: Mon, 13 Oct 2025 16:44:30 +0200
Message-ID: <20251013144318.174574005@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 5954ad7d1af92cb6244c5f31216e43af55febbb7 ]

Building with a reduced stack warning limit shows that delta_mjpeg_decode()
copies a giant structure to the stack each time but only uses three of
its members:

drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c: In function 'delta_mjpeg_decode':
drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c:427:1: error: the frame size of 1296 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Open-code the passing of the structure members that are actually used here.

Fixes: 433ff5b4a29b ("[media] st-delta: add mjpeg support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/st/sti/delta/delta-mjpeg-dec.c   | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c b/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
index 0533d4a083d24..a078f1107300e 100644
--- a/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
+++ b/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
@@ -239,7 +239,7 @@ static int delta_mjpeg_ipc_open(struct delta_ctx *pctx)
 	return 0;
 }
 
-static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, struct delta_au *au)
+static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, dma_addr_t pstart, dma_addr_t pend)
 {
 	struct delta_dev *delta = pctx->dev;
 	struct delta_mjpeg_ctx *ctx = to_ctx(pctx);
@@ -256,8 +256,8 @@ static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, struct delta_au *au)
 
 	memset(params, 0, sizeof(*params));
 
-	params->picture_start_addr_p = (u32)(au->paddr);
-	params->picture_end_addr_p = (u32)(au->paddr + au->size - 1);
+	params->picture_start_addr_p = pstart;
+	params->picture_end_addr_p = pend;
 
 	/*
 	 * !WARNING!
@@ -374,12 +374,14 @@ static int delta_mjpeg_decode(struct delta_ctx *pctx, struct delta_au *pau)
 	struct delta_dev *delta = pctx->dev;
 	struct delta_mjpeg_ctx *ctx = to_ctx(pctx);
 	int ret;
-	struct delta_au au = *pau;
+	void *au_vaddr = pau->vaddr;
+	dma_addr_t au_dma = pau->paddr;
+	size_t au_size = pau->size;
 	unsigned int data_offset = 0;
 	struct mjpeg_header *header = &ctx->header_struct;
 
 	if (!ctx->header) {
-		ret = delta_mjpeg_read_header(pctx, au.vaddr, au.size,
+		ret = delta_mjpeg_read_header(pctx, au_vaddr, au_size,
 					      header, &data_offset);
 		if (ret) {
 			pctx->stream_errors++;
@@ -405,17 +407,17 @@ static int delta_mjpeg_decode(struct delta_ctx *pctx, struct delta_au *pau)
 			goto err;
 	}
 
-	ret = delta_mjpeg_read_header(pctx, au.vaddr, au.size,
+	ret = delta_mjpeg_read_header(pctx, au_vaddr, au_size,
 				      ctx->header, &data_offset);
 	if (ret) {
 		pctx->stream_errors++;
 		goto err;
 	}
 
-	au.paddr += data_offset;
-	au.vaddr += data_offset;
+	au_dma += data_offset;
+	au_vaddr += data_offset;
 
-	ret = delta_mjpeg_ipc_decode(pctx, &au);
+	ret = delta_mjpeg_ipc_decode(pctx, au_dma, au_dma + au_size - 1);
 	if (ret)
 		goto err;
 
-- 
2.51.0




