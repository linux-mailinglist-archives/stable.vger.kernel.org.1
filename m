Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40179E8A5
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjIMNH6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbjIMNH5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 09:07:57 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C919B6
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 06:07:53 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qgPay-003iGr-3X; Wed, 13 Sep 2023 13:07:52 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Wed, 13 Sep 2023 13:04:03 +0000
Subject: [git:media_stage/master] media: qcom: camss: Fix csid-gen2 for test pattern generator
To:     linuxtv-commits@linuxtv.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        stable@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qgPay-003iGr-3X@www.linuxtv.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: qcom: camss: Fix csid-gen2 for test pattern generator
Author:  Andrey Konovalov <andrey.konovalov@linaro.org>
Date:    Wed Aug 30 16:16:15 2023 +0100

In the current driver csid Test Pattern Generator (TPG) doesn't work.
This change:
- fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
- fixes the shift by one between test_pattern control value and the
  actual pattern.
- drops fixed VC of 0x0a which testing showed prohibited some test
  patterns in the CSID to produce output.
So that TPG starts working, but with the below limitations:
- only test_pattern=9 works as it should
- test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
- the rest of test_pattern's don't work (yavta doesn't get the data)
- regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
  order is always the same (RGGB for any RAW8 or RAW10P format in
  4608x2592 resolution).

Tested with:

RAW10P format, VC0:
 media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0

RAW10P format, VC1:
 media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1

RAW8 format, VC0:
 media-ctl --reset
 media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

---

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index efc68f8b4de9..23acc387be5f 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -355,9 +355,6 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		u8 dt_id = vc;
 
 		if (tg->enabled) {
-			/* Config Test Generator */
-			vc = 0xa;
-
 			/* configure one DT, infinite frames */
 			val = vc << TPG_VC_CFG0_VC_NUM;
 			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
@@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 
 			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
 
-			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
-			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
+			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
+			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
 
 			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
 
-			val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
+			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
 			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
 			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
