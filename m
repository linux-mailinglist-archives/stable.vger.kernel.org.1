Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F787E2347
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjKFNKk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjKFNKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:10:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353A91
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:10:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA197C433C7;
        Mon,  6 Nov 2023 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276235;
        bh=UM7klJgDCJIu5jLATHXek8xLCntmiWefqT6tLQ2xAz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrCuXtdvQa7qR0B/X6UYn6M4X5tbNLMCKJbbbdb87SIYr2I4fLIdlcRsOMGW8uv8D
         8bt6Bf/zz5gdCUyxh9kINcWnPFF8sTNQpealAf9rajLlOa6evoQv90gCOqmRdeLrrG
         HwOklybAKEHVuol+X/oKIXGihRVAAAZrgm10ZovE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Hai <wanghai38@huawei.com>,
        Oleksandr Tymoshenko <ovt@google.com>
Subject: [PATCH 4.19 28/61] kobject: Fix slab-out-of-bounds in fill_kobj_path()
Date:   Mon,  6 Nov 2023 14:03:24 +0100
Message-ID: <20231106130300.582472255@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Hai <wanghai38@huawei.com>

commit 3bb2a01caa813d3a1845d378bbe4169ef280d394 upstream.

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
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kobject.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -135,7 +135,7 @@ static int get_kobj_path_length(struct k
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject *parent;
 
@@ -144,12 +144,16 @@ static void fill_kobj_path(struct kobjec
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
@@ -165,13 +169,17 @@ char *kobject_get_path(struct kobject *k
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


