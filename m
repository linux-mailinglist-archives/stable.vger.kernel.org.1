Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9479F1B1
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjIMTFM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIMTFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C07170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:05:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D5BC433C7;
        Wed, 13 Sep 2023 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631908;
        bh=RD9ZoA3PBmGeUbA1o8em3MUiDy2HMK2jn1WkrFc70ls=;
        h=Subject:To:Cc:From:Date:From;
        b=yUgT0sdVcMxq9pacADUXFrCldQciNWaXCqAqGhPOKFI/i8Na6o3LM8W0co1ppnZys
         YTnN+TqPEakWKEhed5hf8TSmyNRJLzuBR4WO8jPDRGjwG/pPGOSlF7o/fT1lRb8EWv
         w8YhwmGrLUlIMREbv9XmP+uJB8qg+Q/gUdJLTx+E=
Subject: FAILED: patch "[PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys" failed to apply to 5.10-stable tree
To:     alealexpro100@ya.ru, ansuelsmth@gmail.com,
        florian.fainelli@broadcom.com, rafal@milecki.pl
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:04:59 +0200
Message-ID: <2023091358-uncoated-stinging-119f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 91994e59079dcb455783d3f9ea338eea6f671af3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091358-uncoated-stinging-119f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

91994e59079d ("ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91994e59079dcb455783d3f9ea338eea6f671af3 Mon Sep 17 00:00:00 2001
From: Aleksey Nasibulin <alealexpro100@ya.ru>
Date: Wed, 12 Jul 2023 03:40:17 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys
 EA6500 V2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linksys ea6500-v2 have 256MB of ram. Currently we only use 128MB.
Expand the definition to use all the available RAM.

Fixes: 03e96644d7a8 ("ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2")
Signed-off-by: Aleksey Nasibulin <alealexpro100@ya.ru>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230712014017.28123-1-ansuelsmth@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

diff --git a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
index f1412ba83def..0454423fe166 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
@@ -19,7 +19,8 @@ chosen {
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
 	};
 
 	gpio-keys {

