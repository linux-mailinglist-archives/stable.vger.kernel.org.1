Return-Path: <stable+bounces-187720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDEBEBFBB
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48122740E8A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D613AD26;
	Fri, 17 Oct 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdulRHCD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4D354AE7
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743159; cv=none; b=sZgQouKcnBaw0FBbh7JBmUjcdqI6xtLrBQJOOGl4BoGr5NwCs+Z+AWbZM295BKAKmhXLpIL9TrCZJ4OqDZY98+orCY8u2idcnE9p7ENeU9R9Em6zXvSV33syN/KWJurjKjWK4rKZhvuWzkr7J78Dskyww5AmMcR6dUbxYvGPP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743159; c=relaxed/simple;
	bh=R5Ixp8zsXtPYGPC9vWAK15OPaG0DuHqR2Zju7+syLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y28QNpj9NEquhLzVJYCSnElez/cAGBHE61JI87uheetNi5L0eEwyz1y+aBn4Oi6meKVPEeuIpIK+xIAp99oox8d6wt83VVV1vlDGWaAEFUQXwjmIphowjhNnX4PuBuyliy5rgfqbp1/lni/JKxzHJQAKUINf1x1jT5AF+UOgEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdulRHCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2AC4CEE7;
	Fri, 17 Oct 2025 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743158;
	bh=R5Ixp8zsXtPYGPC9vWAK15OPaG0DuHqR2Zju7+syLRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdulRHCD7ZPg4l1s3dDumbuxmdjcJH3dre07KKpMCoH42JshzQ1SdmMjElKxFh+eX
	 hqtMYZl9D5zV9ya1vDLNCqMBq6B8B3vSBil23MMOKxcVncChIzWM1Vy2pERDVZb/6O
	 xJyF42DuSFHBZJVFaAn+My9w4dHp5sMKIY4KW0Ko9FIPvmV4aPwfHFAhVQ8fG5dtta
	 Oa9ZedRW69oXeLl7Ae+AiaVHHHDmR1MKp2/tIFfAubXFZRg2TQqxfffr1XsKhcBkMT
	 on2mZJwhBD8YlY7JosIvPrFH+RgNZMJ3ngDpnlk9H/vb3SutN9Rg/DEAOxnxD5Xm/O
	 zzusJzGsibrCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Frank Li <Frank.Li@nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: nxp: imx8-isi: Drop unused argument to mxc_isi_channel_chain()
Date: Fri, 17 Oct 2025 19:19:13 -0400
Message-ID: <20251017231915.30718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101654-uninstall-elevation-901e@gregkh>
References: <2025101654-uninstall-elevation-901e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 9a21ffeade25cbf310f5db39a1f9932695dd41bb ]

The bypass argument to the mxc_isi_channel_chain() function is unused.
Drop it.

Link: https://lore.kernel.org/r/20250813225501.20762-1-laurent.pinchart@ideasonboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: 178aa3360220 ("media: nxp: imx8-isi: m2m: Fix streaming cleanup on release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  2 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c   |  2 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c  | 11 +++++------
 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c |  2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 2810ebe9b5f75..5a4676d520793 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -361,7 +361,7 @@ void mxc_isi_channel_get(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_put(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_enable(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_disable(struct mxc_isi_pipe *pipe);
-int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe, bool bypass);
+int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_unchain(struct mxc_isi_pipe *pipe);
 
 void mxc_isi_channel_config(struct mxc_isi_pipe *pipe,
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
index 5623914f95e64..9225a7ac1c3ee 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -587,7 +587,7 @@ void mxc_isi_channel_release(struct mxc_isi_pipe *pipe)
  *
  * TODO: Support secondary line buffer for downscaling YUV420 images.
  */
-int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe, bool bypass)
+int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe)
 {
 	/* Channel chaining requires both line and output buffer. */
 	const u8 resources = MXC_ISI_CHANNEL_RES_OUTPUT_BUF
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
index cd6c52e9d158a..7a9bc6fda3f81 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
@@ -493,7 +493,6 @@ static int mxc_isi_m2m_streamon(struct file *file, void *fh,
 	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
 	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
 	struct mxc_isi_m2m *m2m = ctx->m2m;
-	bool bypass;
 	int ret;
 
 	if (q->streaming)
@@ -506,15 +505,15 @@ static int mxc_isi_m2m_streamon(struct file *file, void *fh,
 		goto unlock;
 	}
 
-	bypass = cap_pix->width == out_pix->width &&
-		 cap_pix->height == out_pix->height &&
-		 cap_info->encoding == out_info->encoding;
-
 	/*
 	 * Acquire the pipe and initialize the channel with the first user of
 	 * the M2M device.
 	 */
 	if (m2m->usage_count == 0) {
+		bool bypass = cap_pix->width == out_pix->width &&
+			      cap_pix->height == out_pix->height &&
+			      cap_info->encoding == out_info->encoding;
+
 		ret = mxc_isi_channel_acquire(m2m->pipe,
 					      &mxc_isi_m2m_frame_write_done,
 					      bypass);
@@ -531,7 +530,7 @@ static int mxc_isi_m2m_streamon(struct file *file, void *fh,
 	 * buffer chaining.
 	 */
 	if (!ctx->chained && out_pix->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(m2m->pipe, bypass);
+		ret = mxc_isi_channel_chain(m2m->pipe);
 		if (ret)
 			goto deinit;
 
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
index d76eb58deb096..a41c51dd9ce0f 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
@@ -855,7 +855,7 @@ int mxc_isi_pipe_acquire(struct mxc_isi_pipe *pipe,
 
 	/* Chain the channel if needed for wide resolutions. */
 	if (sink_fmt->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(pipe, bypass);
+		ret = mxc_isi_channel_chain(pipe);
 		if (ret)
 			mxc_isi_channel_release(pipe);
 	}
-- 
2.51.0


