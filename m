Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14975D5EC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGUUqS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 16:46:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEA30E2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:46:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b0138963ffso1840032fac.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972374; x=1690577174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uz7EGPZbpFU1X589uUeb+R2wHU3v0uOkhcZB9zMy+NI=;
        b=NGRsse6Bi5WvoKrR63HimrHvbTUWXHl8OXFyOI3NkoYJWloDTn1OP7FFPnY0+dJ++h
         c+NgNJa7NsB0Czk88GZbA3lzWz4pAHdxmAKvPOcG7hPiPz2Q5aWJRNCkRSNm7Jj+e7Bj
         24v1SDbXcxYoDYR135EEMP4ik39dvZTu3Yex2bqgwp8d14jLOctODBPD3X3+xVfUSQFy
         BvP1PQnPE8/xK+9QaO48Pqmj+osWm0AwpIFzI7h7zhZok2SzybuVy/fNdRnPLY9K9rtb
         CQ+l4ECLi2XYgJ6PcPXeJ7exEsW1p22wPsqrOwEsuwtHR3Inf/pCQzRk/JrBT0yvZNLF
         +hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972374; x=1690577174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz7EGPZbpFU1X589uUeb+R2wHU3v0uOkhcZB9zMy+NI=;
        b=VRSLS9NwKxnyVYXYviu1vYXQWkLdjnsfHUoaq0l6AM3u9bh3JwgLxCPK8DIKtDdqY6
         4xNwF+Q2s/AU8eFMiyOkCEuf06zrUatZShGryY/MeRNr4KH4yQ6doiNkEaQz+EyKYsA5
         xmWe0rlu4m5EKHaE88N7uQeuOyir91AwUGZ26pzvWBGF24u6Q3SUTzF6D9rgwbVUhDjL
         JPpx5i/ES86cqmISwZwBsG62vknnl/eDyTLXp1kUJIL0pQUYCqB9ayroBEfv7LvkiGi2
         Jjz4wS4qhAbl6OVnu7I2iK03HvTb2izSbYh0yY62fpsMBX2sr9q0iZhbkleTAiYdvhtJ
         Ya8g==
X-Gm-Message-State: ABy/qLYqBJXai+81T2D6Rtbti61J7VyAL9FrFQgSEaRR0aYo80uJBZ2k
        Q+j6az7mPDInyh+xCDxoRPU=
X-Google-Smtp-Source: APBJJlELSGWfAKajaBOQ8XlteKB1fj7UXselbLIQ4Etqj2uAsrTOOXhT8BGivmNyFX3GsPcaZMLbNw==
X-Received: by 2002:a05:6871:825:b0:1b7:2d92:58d6 with SMTP id q37-20020a056871082500b001b72d9258d6mr3993110oap.32.1689972374169;
        Fri, 21 Jul 2023 13:46:14 -0700 (PDT)
Received: from localhost.localdomain ([97.115.139.81])
        by smtp.gmail.com with ESMTPSA id v29-20020a056870955d00b001b0cad9f72esm1889378oal.18.2023.07.21.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:46:13 -0700 (PDT)
From:   Aaron Armstrong Skomra <skomra@gmail.com>
To:     aaron.skomra@wacom.com
Cc:     Aaron Skomra <skomra@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] HID: wacom: remove the battery when the EKR is off
Date:   Fri, 21 Jul 2023 13:45:58 -0700
Message-Id: <20230721204558.27943-1-skomra@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

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
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 26 ++++++++++++++++++++++----
 drivers/hid/wacom_wac.c |  1 +
 drivers/hid/wacom_wac.h |  1 +
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 4da50e19808e..166a76c9bcad 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -150,6 +150,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 76e5353aca0c..c82e82f21e43 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2523,6 +2523,18 @@ static void wacom_wireless_work(struct work_struct *work)
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
@@ -2537,9 +2549,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2547,7 +2557,6 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2632,6 +2641,9 @@ static int wacom_remote_attach_battery(struct wacom *wacom, int index)
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2647,6 +2659,7 @@ static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2671,8 +2684,13 @@ static void wacom_remote_work(struct work_struct *work)
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		serial = data.remote[i].serial;
+
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 174bf03908d7..6c056f8844e7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1134,6 +1134,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index ee21bb260f22..2e7cc5e7a0cb 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -13,6 +13,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
-- 
2.34.1

