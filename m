Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485FF713CFF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjE1TUv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjE1TUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B97DC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4D661AEF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EE6C433D2;
        Sun, 28 May 2023 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301647;
        bh=e/97fkmAif8R0ArmNISED9pQRoAO98x/oEfPqtOnQpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I25QONOULP+bz1SLaxca1QvJ7nSjAbYw1ZvidlUd8+Le6t29X9f5DHcbkBcV4aYQ5
         e8fD+nbV3Uc5dAuRk3rC1lN7JIKUn5kcTF7tkVsCXKZ2A32q8dKSIG5un5rPmgpXFo
         8u3r+WZBcVDJfg/k4I0ksyYLGyRG+6Y6WM8OE5PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4.19 085/132] HID: wacom: Force pen out of prox if no events have been received in a while
Date:   Sun, 28 May 2023 20:10:24 +0100
Message-Id: <20230528190836.157311176@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gerecke <killertofu@gmail.com>

commit 94b179052f95c294d83e9c9c34f7833cf3cd4305 upstream.

Prox-out events may not be reliably sent by some AES firmware. This can
cause problems for users, particularly due to arbitration logic disabling
touch input while the pen is in prox.

This commit adds a timer which is reset every time a new prox event is
received. When the timer expires we check to see if the pen is still in
prox and force it out if necessary. This is patterend off of the same
solution used by 'hid-letsketch' driver which has a similar problem.

Link: https://github.com/linuxwacom/input-wacom/issues/310
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Cc: Ping Cheng <pinglinux@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom.h     |    3 +++
 drivers/hid/wacom_sys.c |    2 ++
 drivers/hid/wacom_wac.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -94,6 +94,7 @@
 #include <linux/leds.h>
 #include <linux/usb/input.h>
 #include <linux/power_supply.h>
+#include <linux/timer.h>
 #include <asm/unaligned.h>
 
 /*
@@ -170,6 +171,7 @@ struct wacom {
 	struct delayed_work init_work;
 	struct wacom_remote *remote;
 	struct work_struct mode_change_work;
+	struct timer_list idleprox_timer;
 	bool generic_has_leds;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
@@ -242,4 +244,5 @@ struct wacom_led *wacom_led_find(struct
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
 int wacom_initialize_leds(struct wacom *wacom);
+void wacom_idleprox_timeout(struct timer_list *list);
 #endif
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2754,6 +2754,7 @@ static int wacom_probe(struct hid_device
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
 	INIT_WORK(&wacom->mode_change_work, wacom_mode_change_work);
+	timer_setup(&wacom->idleprox_timer, &wacom_idleprox_timeout, TIMER_DEFERRABLE);
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -2802,6 +2803,7 @@ static void wacom_remove(struct hid_devi
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
 	cancel_work_sync(&wacom->mode_change_work);
+	del_timer_sync(&wacom->idleprox_timer);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -15,6 +15,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/jiffies.h>
 
 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -45,6 +46,43 @@ static int wacom_numbered_button_to_key(
 
 static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 			     int group);
+
+static void wacom_force_proxout(struct wacom_wac *wacom_wac)
+{
+	struct input_dev *input = wacom_wac->pen_input;
+
+	wacom_wac->shared->stylus_in_proximity = 0;
+
+	input_report_key(input, BTN_TOUCH, 0);
+	input_report_key(input, BTN_STYLUS, 0);
+	input_report_key(input, BTN_STYLUS2, 0);
+	input_report_key(input, BTN_STYLUS3, 0);
+	input_report_key(input, wacom_wac->tool[0], 0);
+	if (wacom_wac->serial[0]) {
+		input_report_abs(input, ABS_MISC, 0);
+	}
+	input_report_abs(input, ABS_PRESSURE, 0);
+
+	wacom_wac->tool[0] = 0;
+	wacom_wac->id[0] = 0;
+	wacom_wac->serial[0] = 0;
+
+	input_sync(input);
+}
+
+void wacom_idleprox_timeout(struct timer_list *list)
+{
+	struct wacom *wacom = from_timer(wacom, list, idleprox_timer);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	if (!wacom_wac->hid_data.sense_state) {
+		return;
+	}
+
+	hid_warn(wacom->hdev, "%s: tool appears to be hung in-prox. forcing it out.\n", __func__);
+	wacom_force_proxout(wacom_wac);
+}
+
 /*
  * Percent of battery capacity for Graphire.
  * 8th value means AC online and show 100% capacity.
@@ -2255,6 +2293,7 @@ static void wacom_wac_pen_event(struct h
 		value = field->logical_maximum - value;
 		break;
 	case HID_DG_INRANGE:
+		mod_timer(&wacom->idleprox_timer, jiffies + msecs_to_jiffies(100));
 		wacom_wac->hid_data.inrange_state = value;
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;


