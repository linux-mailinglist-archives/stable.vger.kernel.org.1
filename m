Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C697DAC66
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjJ2MWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2MWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Oct 2023 08:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212691
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 05:22:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92BC433C7;
        Sun, 29 Oct 2023 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698582124;
        bh=dY0OypJP1icgt3SikbmKw4UoKpzrR1+qabS2/QLfQ0Y=;
        h=Subject:To:Cc:From:Date:From;
        b=QUtgfvXnVLY+gPmpQYQlAZneqpkIt03NyQ/kvoN+mmP84FoGCaG0mdVf+9S889Zwb
         i9oJDYQ5ua2A7amQpwwetImWmFoE8nNlXBnTVc1ddSeev0Lmy10hgKni6xBmB3WjRZ
         //+HZZFDSwF9W0+Zo04CNBTbEy7BezaIOx1K0+hg=
Subject: FAILED: patch "[PATCH] nvmem: imx: correct nregs for i.MX6UL" failed to apply to 4.14-stable tree
To:     peng.fan@nxp.com, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:21:59 +0100
Message-ID: <2023102958-citizen-phosphate-154f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
git cherry-pick -x 7d6e10f5d254681983b53d979422c8de3fadbefb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102958-citizen-phosphate-154f@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d6e10f5d254681983b53d979422c8de3fadbefb Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 13 Oct 2023 13:49:03 +0100
Subject: [PATCH] nvmem: imx: correct nregs for i.MX6UL

The nregs for i.MX6UL should be 144 per fuse map, correct it.

Fixes: 4aa2b4802046 ("nvmem: octop: Add support for imx6ul")
Cc: Stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013124904.175782-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7302f25b14a1..921afe114a2c 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -512,7 +512,7 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

