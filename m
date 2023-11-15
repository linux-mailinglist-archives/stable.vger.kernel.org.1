Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC47ECD4F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjKOTfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjKOTfn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A7219D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CEDC433C9;
        Wed, 15 Nov 2023 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076940;
        bh=A5zO0YEg5xXK+bH9CRqr02fBDuHTBx/qb+HE0OoRItI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yUuy7yuSHJ/xqJi4tAhxplJ/bo0mvUqyYyCsWL5kgHsZX/f+cvdwv7exbZfCe67+e
         Q6rLAQGAeMfdMMXwTi9+m4lGs1TPP8vNQn8Wvvsc0jeli5+yVCh4Y0skvpH6hn1uS0
         nh5ubGQxC8cahGLi+qXAXsiLp2HYI2bsDHXnLdic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 471/550] media: imx-jpeg: initiate a drain of the capture queue in dynamic resolution change
Date:   Wed, 15 Nov 2023 14:17:35 -0500
Message-ID: <20231115191633.513852543@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 1c2786632e20c8f0fd4004fae3b3490276e5e5da ]

The last buffer from before the change must be marked,
with the V4L2_BUF_FLAG_LAST flag,
similarly to the Drain sequence above.

Meanwhile if V4L2_DEC_CMD_STOP is sent before
the source change triggered,
we need to restore the is_draing flag after
the draining in dynamic resolution change.

Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 9512c0a619667..9ef0cb20f63be 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1322,6 +1322,20 @@ static bool mxc_jpeg_compare_format(const struct mxc_jpeg_fmt *fmt1,
 	return false;
 }
 
+static void mxc_jpeg_set_last_buffer(struct mxc_jpeg_ctx *ctx)
+{
+	struct vb2_v4l2_buffer *next_dst_buf;
+
+	next_dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	if (!next_dst_buf) {
+		ctx->fh.m2m_ctx->is_draining = true;
+		ctx->fh.m2m_ctx->next_buf_last = true;
+		return;
+	}
+
+	v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, next_dst_buf);
+}
+
 static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				   struct mxc_jpeg_src_buf *jpeg_src_buf)
 {
@@ -1378,6 +1392,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		mxc_jpeg_sizeimage(q_data_cap);
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
+		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
+			mxc_jpeg_set_last_buffer(ctx);
 	}
 
 	return ctx->source_change ? true : false;
@@ -1638,8 +1654,13 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 
-	if (V4L2_TYPE_IS_OUTPUT(q->type) || !ctx->source_change)
-		v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	/* if V4L2_DEC_CMD_STOP is sent before the source change triggered,
+	 * restore the is_draining flag
+	 */
+	if (V4L2_TYPE_IS_CAPTURE(q->type) && ctx->source_change && ctx->fh.m2m_ctx->last_src_buf)
+		ctx->fh.m2m_ctx->is_draining = true;
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx)) {
 		notify_eos(ctx);
@@ -1916,7 +1937,7 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 		return -EINVAL;
 	for (i = 0; i < q_data->fmt->mem_planes; i++) {
 		sizeimage = mxc_jpeg_get_plane_size(q_data, i);
-		if (vb2_plane_size(vb, i) < sizeimage) {
+		if (!ctx->source_change && vb2_plane_size(vb, i) < sizeimage) {
 			dev_err(dev, "plane %d too small (%lu < %lu)",
 				i, vb2_plane_size(vb, i), sizeimage);
 			return -EINVAL;
-- 
2.42.0



