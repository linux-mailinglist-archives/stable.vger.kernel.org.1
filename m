Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2ED75D495
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGUTWq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGUTWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D14189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4C361D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DABC433C7;
        Fri, 21 Jul 2023 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967363;
        bh=Unv47NniIiIeazTAvZLeKaDyGWL5SwOunDtkZdWrpvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZhWH5h6cwNiVngRO9TG+ftB54muQJxQ9M4Itf0bwvJ4R/7Fue+aT7lAmqJ2cdWNf
         7VDu5l3vc9p7Tbpr/FYjXPsOXJ3yCzGc/N90d2/eJMlpOAlcm4GkrSzGhyyIKiar+j
         /YtI8eJoBiuSGTy+ARCJ51Y1k+GzvPVSAYz6Duqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Korsgaard <peter@korsgaard.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH 6.1 136/223] dm init: add dm-mod.waitfor to wait for asynchronously probed block devices
Date:   Fri, 21 Jul 2023 18:06:29 +0200
Message-ID: <20230721160526.674339254@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Korsgaard <peter@korsgaard.com>

commit 035641b01e72af4f6c6cf22a4bdb5d7dfc4e8e8e upstream.

Just calling wait_for_device_probe() is not enough to ensure that
asynchronously probed block devices are available (E.G. mmc, usb), so
add a "dm-mod.waitfor=<device1>[,..,<deviceN>]" parameter to get
dm-init to explicitly wait for specific block devices before
initializing the tables with logic similar to the rootwait logic that
was introduced with commit  cc1ed7542c8c ("init: wait for
asynchronously scanned block devices").

E.G. with dm-verity on mmc using:
dm-mod.waitfor="PARTLABEL=hash-a,PARTLABEL=root-a"

[    0.671671] device-mapper: init: waiting for all devices to be available before creating mapped devices
[    0.671679] device-mapper: init: waiting for device PARTLABEL=hash-a ...
[    0.710695] mmc0: new HS200 MMC card at address 0001
[    0.711158] mmcblk0: mmc0:0001 004GA0 3.69 GiB
[    0.715954] mmcblk0boot0: mmc0:0001 004GA0 partition 1 2.00 MiB
[    0.722085] mmcblk0boot1: mmc0:0001 004GA0 partition 2 2.00 MiB
[    0.728093] mmcblk0rpmb: mmc0:0001 004GA0 partition 3 512 KiB, chardev (249:0)
[    0.738274]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
[    0.751282] device-mapper: init: waiting for device PARTLABEL=root-a ...
[    0.751306] device-mapper: init: all devices available
[    0.751683] device-mapper: verity: sha256 using implementation "sha256-generic"
[    0.759344] device-mapper: ioctl: dm-0 (vroot) is ready
[    0.766540] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/device-mapper/dm-init.rst |    8 +++++++
 drivers/md/dm-init.c                                |   22 +++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -123,3 +123,11 @@ Other examples (per target):
     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
+
+For setups using device-mapper on top of asynchronously probed block
+devices (MMC, USB, ..), it may be necessary to tell dm-init to
+explicitly wait for them to become available before setting up the
+device-mapper tables. This can be done with the "dm-mod.waitfor="
+module parameter, which takes a list of devices to wait for::
+
+  dm-mod.waitfor=<device1>[,..,<deviceN>]
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/device-mapper.h>
 #include <linux/init.h>
@@ -18,12 +19,17 @@
 #define DM_MAX_DEVICES 256
 #define DM_MAX_TARGETS 256
 #define DM_MAX_STR_SIZE 4096
+#define DM_MAX_WAITFOR 256
 
 static char *create;
 
+static char *waitfor[DM_MAX_WAITFOR];
+
 /*
  * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
  * Table format: <start_sector> <num_sectors> <target_type> <target_args>
+ * Block devices to wait for to become available before setting up tables:
+ * dm-mod.waitfor=<device1>[,..,<deviceN>]
  *
  * See Documentation/admin-guide/device-mapper/dm-init.rst for dm-mod.create="..." format
  * details.
@@ -266,7 +272,7 @@ static int __init dm_init_init(void)
 	struct dm_device *dev;
 	LIST_HEAD(devices);
 	char *str;
-	int r;
+	int i, r;
 
 	if (!create)
 		return 0;
@@ -286,6 +292,17 @@ static int __init dm_init_init(void)
 	DMINFO("waiting for all devices to be available before creating mapped devices");
 	wait_for_device_probe();
 
+	for (i = 0; i < ARRAY_SIZE(waitfor); i++) {
+		if (waitfor[i]) {
+			DMINFO("waiting for device %s ...", waitfor[i]);
+			while (!dm_get_dev_t(waitfor[i]))
+				msleep(5);
+		}
+	}
+
+	if (waitfor[0])
+		DMINFO("all devices available");
+
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
 				    dev->target_args_array))
@@ -301,3 +318,6 @@ late_initcall(dm_init_init);
 
 module_param(create, charp, 0);
 MODULE_PARM_DESC(create, "Create a mapped device in early boot");
+
+module_param_array(waitfor, charp, NULL, 0);
+MODULE_PARM_DESC(waitfor, "Devices to wait for before setting up tables");


