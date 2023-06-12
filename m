Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587EC72BF7B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjFLKoh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjFLKoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF530EC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB06622B1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC74C433EF;
        Mon, 12 Jun 2023 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565744;
        bh=fIfSUKasSbEK7r/p2vDVNJFX9RxgSOAR8AcsVL2n4Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERwPLCaHEJy0OomLTz2H2TOYH/zcmIxfGz9oxV7Q5hIzHnOXE1UgUWGx4TYfHnchb
         glFvJ3pRWBqTK4ckQuFsoImdMPj8vx97L3ODfluwKES2C7br4N1MZWmU0/j2HnP+H8
         8p4WBMpJS+fjToHAjp7qIVVetC0jc9SoKcGmx+dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 13/21] Input: psmouse - fix OOB access in Elantech protocol
Date:   Mon, 12 Jun 2023 12:26:08 +0200
Message-ID: <20230612101651.516422683@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
References: <20230612101651.048240731@linuxfoundation.org>
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
@@ -595,10 +595,11 @@ static void process_packet_head_v4(struc
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
@@ -628,7 +629,7 @@ static void process_packet_motion_v4(str
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -649,7 +650,7 @@ static void process_packet_motion_v4(str
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);


