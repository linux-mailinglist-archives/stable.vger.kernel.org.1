Return-Path: <stable+bounces-187724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9CFBEC000
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3A1AA66E2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595492641FB;
	Fri, 17 Oct 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmO8ihAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185EF1A2C11
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743919; cv=none; b=G24Spk1752D6/ekeSUf2WJUXQamDrHAJ68F+qVmYwRkE5225rd+x0gePrKT63Z620aZFWTHPtGNLAC5iX/muIKXItXqCwBGazxH1OzlQemB+0Nu8vZogmjt+fKydLge31ydXc5b/aQBEZyMSCSKK+a3WZxo3QE8uJpKDSKqqS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743919; c=relaxed/simple;
	bh=rjZVahl/FurQuaLCu1kd5FtuwSNJhD3WW9K5+WQO6GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O65Q4X5J/SyloEUn6Jkw6LC8U2su/rOMdZvgcJAYSwRecH6xkIFa+IRmThRN67FTSoxjjzS8dPBMZUCkW/pdFwH/ZkrLKBICrOauouwPSxn6BC7eiqazxuR7Lro08BfDsLaZulMZZv9mhJNyWfVrKhsD+uZ5URjBSn89sU/t854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmO8ihAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF0C4CEE7;
	Fri, 17 Oct 2025 23:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743918;
	bh=rjZVahl/FurQuaLCu1kd5FtuwSNJhD3WW9K5+WQO6GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmO8ihAbpi/gDqZJ4rIQXT+9HivxDzETwhIZkjvwWonoich/tUiXUZeK/TpOOAFSC
	 2ZP8T9JdgsS17UVmHt+nl+PYw2CyHMDOlTmH7ZPA0TQmnzwBwQCm0TnpLK/g7Hz91Q
	 R+Qo3VQgG/csY8ucE5hlMKFmGVtDpAj017/zKiq6mw5R0DaONrLjRSw7rATHP3l5bL
	 1mcWg1VVZnaJ7W7X3CX2RErA+kUSUr9/f7mGKvIAXkPJ9iNUh7467qWtqeGmBiNJRV
	 AQmLi24hpkLIZ3KCikQRiapJRg/Cc4dRDWWJJfMT8HRhxk6uc8ZHGbS6J/uf3rH6ah
	 4ZctFME+xQuTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Frank Li <Frank.Li@nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] media: nxp: imx8-isi: Drop unused argument to mxc_isi_channel_chain()
Date: Fri, 17 Oct 2025 19:31:54 -0400
Message-ID: <20251017233155.38054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101655-yelling-unclothed-72ea@gregkh>
References: <2025101655-yelling-unclothed-72ea@gregkh>
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
index 19e80b95ffeaa..ece352171b936 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -589,7 +589,7 @@ void mxc_isi_channel_release(struct mxc_isi_pipe *pipe)
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
index 65d20e9bae69d..483523327c025 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
@@ -851,7 +851,7 @@ int mxc_isi_pipe_acquire(struct mxc_isi_pipe *pipe,
 
 	/* Chain the channel if needed for wide resolutions. */
 	if (sink_fmt->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(pipe, bypass);
+		ret = mxc_isi_channel_chain(pipe);
 		if (ret)
 			mxc_isi_channel_release(pipe);
 	}
-- 
2.51.0


