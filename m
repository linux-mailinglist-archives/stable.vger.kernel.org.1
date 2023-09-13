Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCF79F1AF
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjIMTFE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIMTFE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:05:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43F0170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:05:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66C2C433C7;
        Wed, 13 Sep 2023 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631900;
        bh=PDqAgxHe91exLodXejC4vCoLF9Kc+8zaafUjftEeBtM=;
        h=Subject:To:Cc:From:Date:From;
        b=MaFjwJPazRwhbVmhP6CN+bTp6vVEftp+hI9mRO3MyhdGmo4cKxKLn/PTpgDktxqPc
         Kd0gII1j6taO/S0o5o2ZBaJ8FvPfJwI6WUc0W5vEzD7CmzLldGW+sEEG0wUgE+mniN
         kqv331yKXQG1ZDSAvcTE92JOL2/gRR3nG8nSxCOw=
Subject: FAILED: patch "[PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys" failed to apply to 6.1-stable tree
To:     alealexpro100@ya.ru, ansuelsmth@gmail.com,
        florian.fainelli@broadcom.com, rafal@milecki.pl
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:04:56 +0200
Message-ID: <2023091356-hangnail-unmovable-37c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 91994e59079dcb455783d3f9ea338eea6f671af3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091356-hangnail-unmovable-37c8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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

