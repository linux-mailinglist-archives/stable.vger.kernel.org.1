Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596379BBAF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbjIKU40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjIKOty (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772C125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AABC433C8;
        Mon, 11 Sep 2023 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443790;
        bh=XQQIqQAKoIu8RmJVZm/0Sa1lDhjuLsZcalGkV0M1sJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/n79MpZ/+xBWJctgVH+4hHGRuahyLiy5Q10G4c54Tq7Y2Her+th4D/w/EXPB1scb
         KNbfAnvbjftcBhq+kmSb5zAKi6ZFEq9mqZw+q0fZTOQSh+UsZTyABF9eHZ85jzJtas
         eG3GmkFP4rWJwHr7ScUDnoKrGVdU2ux5TVgJ8r+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 502/737] media: amphion: fix REVERSE_INULL issues reported by coverity
Date:   Mon, 11 Sep 2023 15:46:01 +0200
Message-ID: <20230911134704.594601346@linuxfoundation.org>
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

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 79d3bafaecc13bccab1ebbd28a15e669c5a4cdaf ]

null-checking of a pointor is suggested before dereferencing it

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/venc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 58480e2755ec4..4eb57d793a9c0 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -268,7 +268,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 
 	if (!parm)
 		return -EINVAL;
@@ -279,6 +279,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
 	parm->parm.capture.readbuffers = 0;
 	timeperframe->numerator = venc->params.frame_rate.numerator;
@@ -291,7 +292,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 	unsigned long n, d;
 
 	if (!parm)
@@ -303,6 +304,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	if (!timeperframe->numerator)
 		timeperframe->numerator = venc->params.frame_rate.numerator;
 	if (!timeperframe->denominator)
-- 
2.40.1



