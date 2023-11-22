Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F07F509C
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjKVTdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbjKVTdG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB68D72
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:33:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F65C433CB;
        Wed, 22 Nov 2023 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700681580;
        bh=Kdc9Tr1cC5fAywYgx8hm+fV1DfcpFbze3ojsznbARsw=;
        h=Subject:To:Cc:From:Date:From;
        b=wKWTBoL9ySQBkl1dvnlZy9idoeOe2le5H9czVWF7xR6gAbkLIIfv1ASm+i7zAy28B
         lGKLYodf/8vPX1WG/7bE4GF1fUCR1evUoS+4tJVRMXLd2JYRJZj2eMqM27kTpn/r7n
         PnCiY3V9SjD1irEKlYPgQaBEHalII2G7WLOKh3T0=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Make imx pgc power domain also set the fwnode" failed to apply to 6.5-stable tree
To:     pengfei.li_1@nxp.com, emil.kronborg@protonmail.com,
        ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:32:57 +0000
Message-ID: <2023112257-armless-stump-64b8@gregkh>
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 374de39d38f97b0e58cfee88da590b2d056ccf7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112257-armless-stump-64b8@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

374de39d38f9 ("pmdomain: imx: Make imx pgc power domain also set the fwnode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 374de39d38f97b0e58cfee88da590b2d056ccf7f Mon Sep 17 00:00:00 2001
From: Pengfei Li <pengfei.li_1@nxp.com>
Date: Sat, 21 Oct 2023 02:59:49 +0800
Subject: [PATCH] pmdomain: imx: Make imx pgc power domain also set the fwnode

Currently, The imx pgc power domain doesn't set the fwnode
pointer, which results in supply regulator device can't get
consumer imx pgc power domain device from fwnode when creating
a link.

This causes the driver core to instead try to create a link
between the parent gpc device of imx pgc power domain device and
supply regulator device. However, at this point, the gpc device
has already been bound, and the link creation will fail. So adding
the fwnode pointer to the imx pgc power domain device will fix
this issue.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>
Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231020185949.537083-1-pengfei.li_1@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 90a8b2c0676f..419ed15cc10c 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -498,6 +498,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
+			pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

