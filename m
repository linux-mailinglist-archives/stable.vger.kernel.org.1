Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559D79B927
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjIKUyr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjIKOtk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4407F106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87614C433C8;
        Mon, 11 Sep 2023 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443775;
        bh=4Leo/q9xLGA1/o3SoJ4iIwSxWumZYKVET2QVqkFpNqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0r7/4tKmsyoLnhfyts+SAzSFNmDjQ8E6McfIWyl7V1OGca+osbB4j8E5ciHI0KUqZ
         6tEC5LuygM307DCgGIFk05fM+F3PHXl6SAZkooY6lC/IkfNwpJX0AvE9+nVUWlz7er
         0jhin3103oOhJAb4NHWnEOruh2I6VMZYMoKc2qCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 497/737] media: verisilicon: Fix TRY_FMT on encoder OUTPUT
Date:   Mon, 11 Sep 2023 15:45:56 +0200
Message-ID: <20230911134704.456698559@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Tretter <m.tretter@pengutronix.de>

[ Upstream commit b3b4c9d3cb3bf8725a3ded26f7042b1a37f25333 ]

Commit f100ce3bbd6a ("media: verisilicon: Fix crash when probing
encoder") removed vpu_fmt from hantro_try_fmt(), since it was
initialized from vpu_dst_fmt, which may not be initialized, when TRY_FMT
is called. It was replaced by fmt, which is found using the pixelformat.

For the encoder, this changed the fmt to contain the raw format instead
of the coded format. The format constraints as of fmt->frmsize are only
valid for the coded format and are 0 for the raw formats. Therefore, the
size of a encoder OUTPUT device is constrained to 0 and the
v4l2-compliance tests for G_FMT, TRY_FMT, and SET_FMT fail.

Bring back vpu_fmt to use the coded format on an encoder OUTPUT device,
but initialize it using the currently set pixelformat on dst_fmt, which
is the coded format on an encoder.

Fixes: f100ce3bbd6a ("media: verisilicon: Fix crash when probing encoder")
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 61cfaaf4e927b..e56d58fe28022 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -276,6 +276,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 			  enum v4l2_buf_type type)
 {
 	const struct hantro_fmt *fmt;
+	const struct hantro_fmt *vpu_fmt;
 	bool capture = V4L2_TYPE_IS_CAPTURE(type);
 	bool coded;
 
@@ -295,19 +296,23 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 
 	if (coded) {
 		pix_mp->num_planes = 1;
-	} else if (!ctx->is_encoder) {
+		vpu_fmt = fmt;
+	} else if (ctx->is_encoder) {
+		vpu_fmt = hantro_find_format(ctx, ctx->dst_fmt.pixelformat);
+	} else {
 		/*
 		 * Width/height on the CAPTURE end of a decoder are ignored and
 		 * replaced by the OUTPUT ones.
 		 */
 		pix_mp->width = ctx->src_fmt.width;
 		pix_mp->height = ctx->src_fmt.height;
+		vpu_fmt = fmt;
 	}
 
 	pix_mp->field = V4L2_FIELD_NONE;
 
 	v4l2_apply_frmsize_constraints(&pix_mp->width, &pix_mp->height,
-				       &fmt->frmsize);
+				       &vpu_fmt->frmsize);
 
 	if (!coded) {
 		/* Fill remaining fields */
-- 
2.40.1



