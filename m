Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A37ED144
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbjKOUA2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbjKOUA1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD22B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EE2C433C7;
        Wed, 15 Nov 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078424;
        bh=rdodwSIpuNBtE4WR76+E59mJjolxBXBc1f43iukISRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUWEBJK+Hf2saGeTOfuCwD4HJHguzEcSsPGvKliSXilK3XwSUK/GwFhC5DG4S7Gi5
         0nAqSWv9WOiEU+OLLzXIvnwXCuZ3PdDSlNkVEAFEJDsVCCHVle5+WQRwy7g7ti8ETa
         r9KL/rmxzFrBAbP/O+A5l9zBXTG53S308zw00MyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 315/379] media: verisilicon: Do not enable G2 postproc downscale if source is narrower than destination
Date:   Wed, 15 Nov 2023 14:26:30 -0500
Message-ID: <20231115192703.789081483@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 6e481d52d363218a3e6feb31694da74b38b30fad ]

In case of encoded input VP9 data width that is not multiple of macroblock
size, which is 16 (e.g. 1080x1920 frames, where 1080 is multiple of 8), the
width is padded to be a multiple of macroblock size (for 1080x1920 frames,
that is 1088x1920).

The hantro_postproc_g2_enable() checks whether the encoded data width is
equal to decoded frame width, and if not, enables down-scale mode. For a
frame where input is 1080x1920 and output is 1088x1920, this is incorrect
as no down-scale happens, the frame is only padded. Enabling the down-scale
mode in this case results in corrupted frames.

Fix this by adjusting the check to test whether encoded data width is
greater than decoded frame width, and only in that case enable the
down-scale mode.

To generate input test data to trigger this bug, use e.g.:
$ gst-launch-1.0 videotestsrc ! video/x-raw,width=272,height=256,format=I420 ! \
                 vp9enc ! matroskamux ! filesink location=/tmp/test.vp9
To trigger the bug upon decoding (note that the NV12 must be forced, as
that assures the output data would pass the G2 postproc):
$ gst-launch-1.0 filesrc location=/tmp/test.vp9 ! matroskademux ! vp9parse ! \
                 v4l2slvp9dec ! video/x-raw,format=NV12 ! videoconvert ! fbdevsink

Fixes: 79c987de8b35 ("media: hantro: Use post processor scaling capacities")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 09d8cf9426895..708095cf09fe2 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -103,7 +103,7 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
 
 static int down_scale_factor(struct hantro_ctx *ctx)
 {
-	if (ctx->src_fmt.width == ctx->dst_fmt.width)
+	if (ctx->src_fmt.width <= ctx->dst_fmt.width)
 		return 0;
 
 	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);
-- 
2.42.0



