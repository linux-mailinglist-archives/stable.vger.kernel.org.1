Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C2713CF0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjE1TUN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE1TUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1EA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1B261AA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48900C433D2;
        Sun, 28 May 2023 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301610;
        bh=+LCOnBj3keaLcR+E+3OYLG9rfTfm8+9kpyV63StUHrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxE21etgeFXl2sN6C9b/opDbFB2t06Mq0O1cl+0btHBv7AagG8+YxYnO3loyMADad
         ra+71WD096gxqhr7nLDiYEI1BvILsm/pxIHZbNUfkRwYx10y8L8J6qM4cii4iAG9sE
         I3MCUlBeDD1R5sgchQHN33qw8atwzH8BAU3H/BHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Konrad=20Gr=C3=A4fe?= <k.graefe@gateware.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/132] usb: gadget: u_ether: Fix host MAC address case
Date:   Sun, 28 May 2023 20:10:37 +0100
Message-Id: <20230528190836.651384328@linuxfoundation.org>
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

From: Konrad Gräfe <k.graefe@gateware.de>

[ Upstream commit 3c0f4f09c063e143822393d99cb2b19a85451c07 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_ether.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 561a090ced6de..7d9a551c47f98 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/string_helpers.h>
 #include <linux/usb/composite.h>
 
 #include "u_ether.h"
@@ -940,6 +941,8 @@ int gether_get_host_addr_cdc(struct net_device *net, char *host_addr, int len)
 	dev = netdev_priv(net);
 	snprintf(host_addr, len, "%pm", dev->host_mac);
 
+	string_upper(host_addr, host_addr);
+
 	return strlen(host_addr);
 }
 EXPORT_SYMBOL_GPL(gether_get_host_addr_cdc);
-- 
2.39.2



