Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44B879B79E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377494AbjIKW0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbjIKON3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98ADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D0BC433C7;
        Mon, 11 Sep 2023 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441604;
        bh=DBw4hxpdAQwaDF7Vs6exqp4HTlT/LL7Z2lNIymlye9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAyXCatERQZNFk7RZ91t+jDLacV/iTGX96LHmN5iMp3ozFFn4KdD8Jjq/NB2cUqBA
         RDDxHqDFNuA8uasUqO+9WtgpTxaLyi5HEbGBsBCteAf8Rtp2Jd8q0MvHTjPSyYsIH9
         CQZp0n1Y6rTI1RAaf9Q4A5cFnUoQgJplpBD0QI40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 472/739] media: amphion: fix REVERSE_INULL issues reported by coverity
Date:   Mon, 11 Sep 2023 15:44:31 +0200
Message-ID: <20230911134704.328940244@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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



