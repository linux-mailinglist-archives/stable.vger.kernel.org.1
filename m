Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB251742C1F
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjF2Srq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjF2Sr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7C03A99
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0327D615E2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B44C433C8;
        Thu, 29 Jun 2023 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064444;
        bh=gY4Tk7R0VRwZcMUrdUuLk8sFAR3TIsakYI6YsOaPSC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4y/b+xPGkZyAUik1TZ+8alKiG1pQJb6JpU+CW4/Q9IL77HMe69Rji2QH3RadEpfj
         YLwUqU+fteDpWlqnDrTXGeo5P4yTwyEL3DD4SIV6+LGlcECZixsh3M70GhGykX8pU1
         //dEwzzTblUA0Kss+mH222OXjukrhWqhaFE93mC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.3 27/29] HID: wacom: Use ktime_t rather than int when dealing with timestamps
Date:   Thu, 29 Jun 2023 20:43:57 +0200
Message-ID: <20230629184152.807843332@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
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
@@ -1309,7 +1309,7 @@ static void wacom_intuos_pro2_bt_pen(str
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int number_of_valid_frames = 0;
-	int time_interval = 15000000;
+	ktime_t time_interval = 15000000;
 	ktime_t time_packet_received = ktime_get();
 	int i;
 
@@ -1343,7 +1343,7 @@ static void wacom_intuos_pro2_bt_pen(str
 	if (number_of_valid_frames) {
 		if (wacom->hid_data.time_delayed)
 			time_interval = ktime_get() - wacom->hid_data.time_delayed;
-		time_interval /= number_of_valid_frames;
+		time_interval = div_u64(time_interval, number_of_valid_frames);
 		wacom->hid_data.time_delayed = time_packet_received;
 	}
 
@@ -1354,7 +1354,7 @@ static void wacom_intuos_pro2_bt_pen(str
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


