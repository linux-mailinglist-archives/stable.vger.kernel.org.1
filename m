Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7A79E8A9
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjIMNH7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjIMNH7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 09:07:59 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3293319B1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 06:07:55 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qgPay-003iJV-QD; Wed, 13 Sep 2023 13:07:52 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Wed, 13 Sep 2023 13:04:03 +0000
Subject: [git:media_stage/master] media: qcom: camss: Fix VFE-480 vfe_disable_output()
To:     linuxtv-commits@linuxtv.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qgPay-003iJV-QD@www.linuxtv.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: qcom: camss: Fix VFE-480 vfe_disable_output()
Author:  Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:    Wed Aug 30 16:16:11 2023 +0100

vfe-480 is copied from vfe-17x and has the same racy idle timeout bug as in
17x.

Fix the vfe_disable_output() logic to no longer be racy and to conform
to the 17x way of quiescing and then resetting the VFE.

Fixes: 4edc8eae715c ("media: camss: Add initial support for VFE hardware version Titan 480")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/camss/camss-vfe-480.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

---

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index f70aad2e8c23..8ddb8016434a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2021 Jonathan Marek
  */
 
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -328,35 +327,20 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
 	unsigned long flags;
 	unsigned int i;
-	bool done;
-	int timeout = 0;
-
-	do {
-		spin_lock_irqsave(&vfe->output_lock, flags);
-		done = !output->gen2.active_num;
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		usleep_range(10000, 20000);
-
-		if (timeout++ == 100) {
-			dev_err(vfe->camss->dev, "VFE idle timeout - resetting\n");
-			vfe_reset(vfe);
-			output->gen2.active_num = 0;
-			return 0;
-		}
-	} while (!done);
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 	for (i = 0; i < output->wm_num; i++)
 		vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
-	return 0;
+	vfe_reset(vfe);
 }
 
 /*
