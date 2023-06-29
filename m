Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAB742C66
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjF2SsV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjF2SsU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D692D55
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6AAE615DC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9DC433C0;
        Thu, 29 Jun 2023 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064498;
        bh=u8kq7XpHg+QojxXK4JsUWNoBh1GBdmXfSwRG+qMdz1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKUL5Gu1G7WQ6DfFv4Mj8j8hTXh7r/4Ptfnr+5CoMAO+wrAx6giKiQLU0ju+Jf9UF
         cCSIm/c4MEtu+iIgVwVoTBjHkjj8OeqgP+9pIfwb9cN9GxFc2R6tv7GUoO6JD1TxiH
         qtCfokmVUsXAgh17VXTqqF7qGY6nVbZFtipY1d5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.4 22/28] HID: wacom: Use ktime_t rather than int when dealing with timestamps
Date:   Thu, 29 Jun 2023 20:44:10 +0200
Message-ID: <20230629184152.764470714@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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

From: Jason Gerecke <jason.gerecke@wacom.com>

commit 9a6c0e28e215535b2938c61ded54603b4e5814c5 upstream.

Code which interacts with timestamps needs to use the ktime_t type
returned by functions like ktime_get. The int type does not offer
enough space to store these values, and attempting to use it is a
recipe for problems. In this particular case, overflows would occur
when calculating/storing timestamps leading to incorrect values being
reported to userspace. In some cases these bad timestamps cause input
handling in userspace to appear hung.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetooth (BT) events")
CC: stable@vger.kernel.org
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Link: https://lore.kernel.org/r/20230608213828.2108-1-jason.gerecke@wacom.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    6 +++---
 drivers/hid/wacom_wac.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(str
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int number_of_valid_frames = 0;
-	int time_interval = 15000000;
+	ktime_t time_interval = 15000000;
 	ktime_t time_packet_received = ktime_get();
 	int i;
 
@@ -1348,7 +1348,7 @@ static void wacom_intuos_pro2_bt_pen(str
 	if (number_of_valid_frames) {
 		if (wacom->hid_data.time_delayed)
 			time_interval = ktime_get() - wacom->hid_data.time_delayed;
-		time_interval /= number_of_valid_frames;
+		time_interval = div_u64(time_interval, number_of_valid_frames);
 		wacom->hid_data.time_delayed = time_packet_received;
 	}
 
@@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(str
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
 		int frames_number_reversed = number_of_valid_frames - i - 1;
-		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
+		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int ps_connected;
 	bool pad_input_event_flag;
 	unsigned short sequence_number;
-	int time_delayed;
+	ktime_t time_delayed;
 };
 
 struct wacom_remote_data {


