Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD96FAB11
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjEHLJH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjEHLIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682A1B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF11B62B02
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BEBC433EF;
        Mon,  8 May 2023 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544113;
        bh=VXDgDRPaXFJnjVtytghjh/juy7EXzf6f2L6oSo/T/Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaZw6JTJPpRJ8R6FlnJAT2PA7d6YtfhcEeFMt2jbRslomiJYKyYwsbOz7HhqItvjX
         pLNID7SgPZPH1n26LWt10aYb4UIhE///z6PjNNyx93cHPlICjmiyIiEqGr3t9oRYfx
         t+cvRxT28Wa/0Orb+UJL8yV5Ul98I83GH0UG5eIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 305/694] media: venus: dec: Fix capture formats enumeration order
Date:   Mon,  8 May 2023 11:42:20 +0200
Message-Id: <20230508094442.185479217@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit a9d45ec74c8e68aaafe90191928eddbf79f4644f ]

Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
compressed format") added support for the QC08C and QC10C compressed
formats respectively.

But these also caused a regression, because the new formats where added
at the beginning of the vdec_formats[] array and the vdec_inst_init()
function sets the default format output and capture using fixed indexes
of that array:

static void vdec_inst_init(struct venus_inst *inst)
{
...
	inst->fmt_out = &vdec_formats[8];
	inst->fmt_cap = &vdec_formats[0];
...
}

Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
the default capture format is not set to that as it was done before.

Both commits changed the first index to keep inst->fmt_out default format
set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
default format set to V4L2_PIX_FMT_NV12.

Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
let's reorder the entries so that this format is the first entry again.

This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
with an index 0 as it did before the QC08C and QC10C formats were added.

Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 9d26587716bf6..1a52c2ea2da5b 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -31,15 +31,15 @@
  */
 static const struct venus_format vdec_formats[] = {
 	{
-		.pixfmt = V4L2_PIX_FMT_QC08C,
+		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
-		.pixfmt = V4L2_PIX_FMT_QC10C,
+		.pixfmt = V4L2_PIX_FMT_QC08C,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-	},{
-		.pixfmt = V4L2_PIX_FMT_NV12,
+	}, {
+		.pixfmt = V4L2_PIX_FMT_QC10C,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
-- 
2.39.2



