Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D332F791D4A
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjIDShN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbjIDShN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:37:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87FCCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D0ACB80EF6
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E675C433C7;
        Mon,  4 Sep 2023 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852626;
        bh=a6MsZNOM5uqzNoDcMAfAyZU6iNk9ntEth7BZ3krpBZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJni71CpAo/EgIoU4YuHQmk52TPQyT86wCIDJHUTi17gocqetajkEZCVzobxFE6Sl
         BbwwYPgmGF5IwLK56VCypIKJTaCBeJ+zvaQz3vySdUtN7yI/wL1cgMH2zvOjFYSiwr
         IfcNO00mnhGC4WO8I64OO1tYZXwqDtj+jeIgnp24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Skomra <skomra@gmail.com>,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.15 14/28] HID: wacom: remove the battery when the EKR is off
Date:   Mon,  4 Sep 2023 19:30:45 +0100
Message-ID: <20230904182945.849870284@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

commit 9ac6678b95b0dd9458a7a6869f46e51cd55a1d84 upstream.

Currently the EKR battery remains even after we stop getting information
from the device. This can lead to a stale battery persisting indefinitely
in userspace.

The remote sends a heartbeat every 10 seconds. Delete the battery if we
miss two heartbeats (after 21 seconds). Restore the battery once we see
a heartbeat again.

Signed-off-by: Aaron Skomra <skomra@gmail.com>
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
Fixes: 9f1015d45f62 ("HID: wacom: EKR: attach the power_supply on first connection")
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom.h     |    1 +
 drivers/hid/wacom_sys.c |   25 +++++++++++++++++++++----
 drivers/hid/wacom_wac.c |    1 +
 drivers/hid/wacom_wac.h |    1 +
 4 files changed, 24 insertions(+), 4 deletions(-)

--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -153,6 +153,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2535,6 +2535,18 @@ fail:
 	return;
 }
 
+static void wacom_remote_destroy_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+
+	if (remote->remotes[index].battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+		remote->remotes[index].battery.battery = NULL;
+		remote->remotes[index].active_time = 0;
+	}
+}
+
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
@@ -2549,9 +2561,7 @@ static void wacom_remote_destroy_one(str
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2559,7 +2569,6 @@ static void wacom_remote_destroy_one(str
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2644,6 +2653,9 @@ static int wacom_remote_attach_battery(s
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2659,6 +2671,7 @@ static void wacom_remote_work(struct wor
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2685,6 +2698,10 @@ static void wacom_remote_work(struct wor
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1134,6 +1134,7 @@ static int wacom_remote_irq(struct wacom
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -15,6 +15,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9


