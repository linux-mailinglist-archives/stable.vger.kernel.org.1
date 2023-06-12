Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72872BF90
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjFLKpS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjFLKpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9856E8C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35246622B1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47942C433D2;
        Mon, 12 Jun 2023 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565783;
        bh=ne+H5kK/RBzk0gVJvJzy+rp6tw/szX9ZCoqP+MC+HeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnaunzWz2HaVLm2HDASAG46pNmpzwRowfaJ3T1teLjl9m4L+gIKD15fO9ZlmDedmc
         IV6Vr+90a2ZWbp3IDzCqFnjGNavrYEbc7iMsf/CbTmgCnr6QMICZjOp2hImatnl57m
         AwjAMoS3VgtuOu025kzC5QGokl75SAIHc9UJlrvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 14/23] Input: psmouse - fix OOB access in Elantech protocol
Date:   Mon, 12 Jun 2023 12:26:15 +0200
Message-ID: <20230612101651.635322452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 7b63a88bb62ba2ddf5fcd956be85fe46624628b9 upstream.

The kernel only allocate 5 MT slots; check that transmitted slot ID
falls within the acceptable range.

Link: https://lore.kernel.org/r/ZFnEL91nrT789dbG@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elantech.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -590,10 +590,11 @@ static void process_packet_head_v4(struc
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	int id = ((packet[3] & 0xe0) >> 5) - 1;
+	int id;
 	int pres, traces;
 
-	if (id < 0)
+	id = ((packet[3] & 0xe0) >> 5) - 1;
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
@@ -623,7 +624,7 @@ static void process_packet_motion_v4(str
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -644,7 +645,7 @@ static void process_packet_motion_v4(str
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);


