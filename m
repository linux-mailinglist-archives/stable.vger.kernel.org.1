Return-Path: <stable+bounces-198087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA7C9B83F
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5F074E3319
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7EF3128C2;
	Tue,  2 Dec 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sfvTCYR2"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013230EF88
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679595; cv=none; b=Yw4g+PH6BsR4l51qRblewzCnNEqC8qjUBj1Fsw4EGIhAkNw9qsXzwVkcv1j9kC7nVrKPo/NI8SHETU9n5yPDRsMD4gHmZTFSewYpgNnXI+w3KmaxKPWC+8YOmIZQWfVidD81P12hEWdE8VZq8y+Ckipv1v3iKAqmYsKBEk+3tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679595; c=relaxed/simple;
	bh=bJnIvT20G9GOLNBa2XvOknjXHz9/pB1+QBrowudu6sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUQnwAq49KqRYZkCcaR5CpZ6SAN+VFb6cBey2OQFWhBqKd8qwj47Br9YmQITsDqnAVnvcHhdde+XvJJ8T7gQNwVuCZin17Xe0i/WAlyyEiKVYxTIFsUnQBdj2ICasnSswQ9hL8JwYaaTu5zN55h49J9AqiQ08QKSkdvIuh6mLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sfvTCYR2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764679589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P17xNwt1rtshfrZ7Ai2OzQdOG3L6gJqvRw2RRd5OaZA=;
	b=sfvTCYR2/JN/p+cv4ap9oljFFXsUev+xrq0RNNqXD16o0+Mql5ZQoKuhr2JqlIPS+38U3J
	5DHKr1NBRhtXBwC9H8/EMqn9AcnxHrbMIPTxM4VaGLIosN+F6pfKFz/63Nu6T7w4jRIj1h
	2R1pOc2OHbsBxlr86MBYm+dZYBfD3eI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Devarsh Thakkar <devarsht@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	David Huang <d-huang@ti.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: imagination: Fix value clamping in calculate_qp_tables
Date: Tue,  2 Dec 2025 13:45:55 +0100
Message-ID: <20251202124555.418319-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'val' was never clamped to 1 or 255 because the
return value of clamp() was not used. Fix this by assigning the clamped
value back to 'val'.

Cc: stable@vger.kernel.org
Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index c4e0097cb8b7..a36a2acc896c 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -175,12 +175,12 @@ static void calculate_qp_tables(struct e5010_context *ctx)
 		long long delta = v4l2_jpeg_ref_table_chroma_qt[i] * contrast + luminosity;
 		int val = (int)(v4l2_jpeg_ref_table_chroma_qt[i] + delta);
 
-		clamp(val, 1, 255);
+		val = clamp(val, 1, 255);
 		ctx->chroma_qp[i] = quality == -50 ? 1 : val;
 
 		delta = v4l2_jpeg_ref_table_luma_qt[i] * contrast + luminosity;
 		val = (int)(v4l2_jpeg_ref_table_luma_qt[i] + delta);
-		clamp(val, 1, 255);
+		val = clamp(val, 1, 255);
 		ctx->luma_qp[i] = quality == -50 ? 1 : val;
 	}
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


