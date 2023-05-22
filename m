Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800470C488
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEVRnm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjEVRnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A11107
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D15960F21
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A11C433D2;
        Mon, 22 May 2023 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684777416;
        bh=oL91imYZsKgb/yExzRsr5SjSEsHa1k91EBZxivMg7Ds=;
        h=Subject:To:Cc:From:Date:From;
        b=EzAuHlST/63ImUmZF0CE4hZTcIANkLWIgq1TQheTIgQRHfBss9+dYvpKfSeQBBAvF
         3DOtLql3kltJGGEmqy+/lozyEn6e9Etzv2MuMRDD+RYeqS3HxFKvMyJmjQ9KnBBijN
         E2jffdLTnJ66/M4NsUkVOg0cDgoVLxbRdPJPSPBw=
Subject: FAILED: patch "[PATCH] usb: gadget: u_ether: Fix host MAC address case" failed to apply to 4.14-stable tree
To:     k.graefe@gateware.de, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:43:34 +0100
Message-ID: <2023052234-curfew-scuttle-1090@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 3c0f4f09c063e143822393d99cb2b19a85451c07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052234-curfew-scuttle-1090@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

3c0f4f09c063 ("usb: gadget: u_ether: Fix host MAC address case")
938fc6453176 ("usb: gadget: u_ether: Convert prints to device prints")
508aeb54e4f0 ("usb: gadget: u_ether: Remove duplicated include in u_ether.c")
890d5b40908b ("usb: gadget: u_ether: fix race in setting MAC address in setup phase")
3a37a9636cf3 ("net: dev: Add extack argument to dev_set_mac_address()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c0f4f09c063e143822393d99cb2b19a85451c07 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Konrad=20Gr=C3=A4fe?= <k.graefe@gateware.de>
Date: Fri, 5 May 2023 16:36:40 +0200
Subject: [PATCH] usb: gadget: u_ether: Fix host MAC address case
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CDC-ECM specification [1] requires to send the host MAC address as
an uppercase hexadecimal string in chapter "5.4 Ethernet Networking
Functional Descriptor":
    The Unicode character is chosen from the set of values 30h through
    39h and 41h through 46h (0-9 and A-F).

However, snprintf(.., "%pm", ..) generates a lowercase MAC address
string. While most host drivers are tolerant to this, UsbNcm.sys on
Windows 10 is not. Instead it uses a different MAC address with all
bytes set to zero including and after the first byte containing a
lowercase letter. On Windows 11 Microsoft fixed it, but apparently they
did not backport the fix.

This change fixes the issue by upper-casing the MAC to comply with the
specification.

[1]: https://www.usb.org/document-library/class-definitions-communication-devices-12, file ECM120.pdf

Fixes: bcd4a1c40bee ("usb: gadget: u_ether: construct with default values and add setters/getters")
Cc: stable@vger.kernel.org
Signed-off-by: Konrad Gräfe <k.graefe@gateware.de>
Link: https://lore.kernel.org/r/20230505143640.443014-1-k.graefe@gateware.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 6956ad8ba8dd..a366abb45623 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/string_helpers.h>
 #include <linux/usb/composite.h>
 
 #include "u_ether.h"
@@ -965,6 +966,8 @@ int gether_get_host_addr_cdc(struct net_device *net, char *host_addr, int len)
 	dev = netdev_priv(net);
 	snprintf(host_addr, len, "%pm", dev->host_mac);
 
+	string_upper(host_addr, host_addr);
+
 	return strlen(host_addr);
 }
 EXPORT_SYMBOL_GPL(gether_get_host_addr_cdc);

