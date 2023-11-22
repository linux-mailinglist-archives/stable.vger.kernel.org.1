Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BC7F50B2
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjKVTff (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344050AbjKVTfe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:35:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B721A4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:35:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD8C433C8;
        Wed, 22 Nov 2023 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700681729;
        bh=LVNhSehA0aWAk+gY/3oLHz0v6/BS3/7JXXnYttaAKmU=;
        h=Subject:To:Cc:From:Date:From;
        b=hVNdTFOHBqE/zrE4BNjQYb8wXFcSrPa7TKT8TavQSGMSoFA0F4wELccUbIypp80vl
         oP4dMpBWsYDumdUbGd2ne2uotViqPEeT7MwKnILKQYoa0fStddOONulY7mNcHrXhrv
         rE5OF/A0m2xmFRW3BWXFcMM+4pLn7fB1vwZDjZzY=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE" failed to apply to 4.19-stable tree
To:     guanwentao@uniontech.com, luiz.von.dentz@intel.com,
        tangmeng@uniontech.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:35:21 +0000
Message-ID: <2023112221-facecloth-annually-92d1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x da06ff1f585ea784c79f80e7fab0e0c4ebb49c1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112221-facecloth-annually-92d1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

da06ff1f585e ("Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE")
02be109d3a40 ("Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables")
069f534247bb ("bluetooth: Add device 13d3:3571 to device tables")
730a1d1a93a3 ("bluetooth: Add device 0bda:887b to device tables")
393b4916b7b5 ("Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559")
33bfd94a05ab ("Bluetooth: btusb: add Realtek 8822CE to usb_device_id table")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da06ff1f585ea784c79f80e7fab0e0c4ebb49c1c Mon Sep 17 00:00:00 2001
From: Guan Wentao <guanwentao@uniontech.com>
Date: Thu, 12 Oct 2023 19:21:17 +0800
Subject: [PATCH] Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Add PID/VID 0bda:b85b for Realtek RTL8852BE USB bluetooth part.
The PID/VID was reported by the patch last year. [1]
Some SBCs like rockpi 5B A8 module contains the device.
And it`s founded in website. [2] [3]

Here is the device tables in /sys/kernel/debug/usb/devices .

T:  Bus=07 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b85b Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Link: https://lore.kernel.org/all/20220420052402.19049-1-tangmeng@uniontech.com/ [1]
Link: https://forum.radxa.com/t/bluetooth-on-ubuntu/13051/4 [2]
Link: https://ubuntuforums.org/showthread.php?t=2489527 [3]

Cc: stable@vger.kernel.org
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Signed-off-by: Guan Wentao <guanwentao@uniontech.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d793dcd06687..b8e9de887b5d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -544,6 +544,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3570), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |

