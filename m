Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA879E8AE
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbjIMNIF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbjIMNID (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 09:08:03 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B019B9
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 06:07:58 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qgPb2-003iXm-PK; Wed, 13 Sep 2023 13:07:56 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Wed, 23 Aug 2023 07:56:08 +0000
Subject: [git:media_stage/master] media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        Wei Chen <harperchen1110@gmail.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qgPb2-003iXm-PK@www.linuxtv.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
Author:  Wei Chen <harperchen1110@gmail.com>
Date:    Thu Aug 10 08:23:33 2023 +0000

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
 1 file changed, 2 insertions(+)

---

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 9ff439a50f53..315e97a2450e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
