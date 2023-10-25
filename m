Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EB7D60D3
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 06:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjJYEWJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 00:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYEWI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 00:22:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9849F
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 21:22:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso5125928276.2
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207725; x=1698812525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFeekiUlvIv+282tzaPcsD3RJioqAEfDcIGIANHuQ7A=;
        b=eYue8O3MPFzRYDDGAuw4Oj9JnOx4vPN8a2CsN4cmdHTI3cIoP6JLFF5f9eux/178ko
         KJY0u1QaRFZNrNLIWBUzxAGMGy5668Gqj8dmY8Lgqqh7A+57n2VAZlLriw+VO4uxsir0
         PPltfTejlLALHkEdvE99hIR4tYYRc2eYauPZDv46u9vj3ziZw41gGFnwdNRVZOJjDtLO
         wh2XswUUUfF5tC9vkACDvMHMdvd+v7Fp77fXUOVTR5KfyghYPDvGq8DIWgysNFBFJwxY
         VXKe5WnRlKdFgjAzqcgctb8QmC15X4m1d9lGm098SuhVSgCXLIZrESN7io8O/Z84Hxe8
         q0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207725; x=1698812525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFeekiUlvIv+282tzaPcsD3RJioqAEfDcIGIANHuQ7A=;
        b=WGpUp2cEKotRKMPtSwliPuPTNhYI2MxFHM1cQlLGUnfJPpGouvHT9uq7woeH7QsMgp
         +cIhfN65NCgbRbfivp9MgL6gKu/J6ayF93XkuqnpgWi1dgTWS1R8PS8VU9LpROKMMl5I
         AC/STarqp6STFBMzjHR/G5a/eQdJsCvQ7N5odF3TuvIlr6el2+lFJrOiRitffgivH2Il
         754jL2SXnDqGaKwr8fRcIzobwjYrVD2mZK7x4qn8isJsazL6jA2lf35vRA96yc7X8dxT
         aVWp+5PgBVWw41BObnNfvaj7FLcJ7+tNPpPRJmZj7UB9w5+Od4/NLYVPXB4T0FX6YJpF
         lSFw==
X-Gm-Message-State: AOJu0YycuAi2a3DtMGlfgDKks27nI5NCzQhIzFfgfIEXiyz0fG61s6fZ
        9v6UePquIxljl9OM/CO5vdfzrP7rbfpxTMIRcfyQu5SQ7HheEPp2phDd+lYMpclTgU4g6LMPk+E
        D+3IBaXzqdLxc8+hLR7clQZfec2EKlYbGjBJesI836lj6f0zLocFkRg==
X-Google-Smtp-Source: AGHT+IHv7lClstarpRirAXwBwFM2yoNteVRetx28rC8jleuQrLefLvxmw5s/5lcjg50hQGY0MBUYjHY=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP id
 v3-20020a056902108300b00d9a47ea69a5mr379537ybu.1.1698207725498; Tue, 24 Oct
 2023 21:22:05 -0700 (PDT)
Date:   Wed, 25 Oct 2023 04:21:44 +0000
In-Reply-To: <20231025042144.2247604-1-ovt@google.com>
Mime-Version: 1.0
References: <20231025042144.2247604-1-ovt@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025042144.2247604-2-ovt@google.com>
Subject: [PATCH 5.10 1/1] kobject: Fix slab-out-of-bounds in fill_kobj_path()
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     stable@vger.kernel.org
Cc:     Wang Hai <wanghai38@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 3bb2a01caa813d3a1845d378bbe4169ef280d394 ]

In kobject_get_path(), if kobj->name is changed between calls
get_kobj_path_length() and fill_kobj_path() and the length becomes
longer, then fill_kobj_path() will have an out-of-bounds bug.

The actual current problem occurs when the ixgbe probe.

In ixgbe_mii_bus_init(), if the length of netdev->dev.kobj.name
length becomes longer, out-of-bounds will occur.

cpu0                                         cpu1
ixgbe_probe
 register_netdev(netdev)
  netdev_register_kobject
   device_add
    kobject_uevent // Sending ADD events
                                             systemd-udevd // rename netdev
                                              dev_change_name
                                               device_rename
                                                kobject_rename
 ixgbe_mii_bus_init                             |
  mdiobus_register                              |
   __mdiobus_register                           |
    device_register                             |
     device_add                                 |
      kobject_uevent                            |
       kobject_get_path                         |
        len = get_kobj_path_length // old name  |
        path = kzalloc(len, gfp_mask);          |
                                                kobj->name = name;
                                                /* name length becomes
                                                 * longer
                                                 */
        fill_kobj_path /* kobj path length is
                        * longer than path,
                        * resulting in out of
                        * bounds when filling path
                        */

This is the kasan report:

==================================================================
BUG: KASAN: slab-out-of-bounds in fill_kobj_path+0x50/0xc0
Write of size 7 at addr ff1100090573d1fd by task kworker/28:1/673

 Workqueue: events work_for_cpu_fn
 Call Trace:
 <TASK>
 dump_stack_lvl+0x34/0x48
 print_address_description.constprop.0+0x86/0x1e7
 print_report+0x36/0x4f
 kasan_report+0xad/0x130
 kasan_check_range+0x35/0x1c0
 memcpy+0x39/0x60
 fill_kobj_path+0x50/0xc0
 kobject_get_path+0x5a/0xc0
 kobject_uevent_env+0x140/0x460
 device_add+0x5c7/0x910
 __mdiobus_register+0x14e/0x490
 ixgbe_probe.cold+0x441/0x574 [ixgbe]
 local_pci_probe+0x78/0xc0
 work_for_cpu_fn+0x26/0x40
 process_one_work+0x3b6/0x6a0
 worker_thread+0x368/0x520
 kthread+0x165/0x1a0
 ret_from_fork+0x1f/0x30

This reproducer triggers that bug:

while:
do
    rmmod ixgbe
    sleep 0.5
    modprobe ixgbe
    sleep 0.5

When calling fill_kobj_path() to fill path, if the name length of
kobj becomes longer, return failure and retry. This fixes the problem.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Link: https://lore.kernel.org/r/20221220012143.52141-1-wanghai38@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 lib/kobject.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index cd3e1a98eff9..73047e847e91 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -144,7 +144,7 @@ static int get_kobj_path_length(struct kobject *kobj)
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject *parent;
 
@@ -153,12 +153,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
+		if (length <= 0)
+			return -EINVAL;
 		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 
 	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
 		 kobj, __func__, path);
+
+	return 0;
 }
 
 /**
@@ -173,13 +177,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
 	char *path;
 	int len;
 
+retry:
 	len = get_kobj_path_length(kobj);
 	if (len == 0)
 		return NULL;
 	path = kzalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
-	fill_kobj_path(kobj, path, len);
+	if (fill_kobj_path(kobj, path, len)) {
+		kfree(path);
+		goto retry;
+	}
 
 	return path;
 }
-- 
2.42.0.758.gaed0368e0e-goog

