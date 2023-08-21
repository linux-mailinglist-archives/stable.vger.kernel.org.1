Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69628782F0D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjHURGK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjHURGJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 13:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E9EC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5B9063FBD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 17:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D4FC433C7;
        Mon, 21 Aug 2023 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692637567;
        bh=E6EGBmhRf+BQJLk9XYQwx11tJPWIxYFRtwa60YRC4IM=;
        h=Subject:To:Cc:From:Date:From;
        b=vDNiAcmXl2g/ojzgp21pM9JqlMK162DJSju+hs5nHrZM75A1zUux90buqOIV9lI1x
         JS47v/1AgTwUtvjWvzjQkeer8Is5eOoLvcnt7PkkehFYUP8ibT/xeBGqygf3fX9kZV
         L0Oh6MlSp7Pjy0DBojV2tcE1x5nvTz9WoPsAmrCc=
Subject: FAILED: patch "[PATCH] qede: fix firmware halt over suspend and resume" failed to apply to 5.10-stable tree
To:     manishc@marvell.com, horms@kernel.org, jmeneghi@redhat.com,
        kuba@kernel.org, palok@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 19:06:02 +0200
Message-ID: <2023082101-till-squealing-7f7d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
git cherry-pick -x 2eb9625a3a32251ecea470cd576659a3a03b4e59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082101-till-squealing-7f7d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2eb9625a3a32 ("qede: fix firmware halt over suspend and resume")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2eb9625a3a32251ecea470cd576659a3a03b4e59 Mon Sep 17 00:00:00 2001
From: Manish Chopra <manishc@marvell.com>
Date: Wed, 16 Aug 2023 20:37:11 +0530
Subject: [PATCH] qede: fix firmware halt over suspend and resume

While performing certain power-off sequences, PCI drivers are
called to suspend and resume their underlying devices through
PCI PM (power management) interface. However this NIC hardware
does not support PCI PM suspend/resume operations so system wide
suspend/resume leads to bad MFW (management firmware) state which
causes various follow-up errors in driver when communicating with
the device/firmware afterwards.

To fix this driver implements PCI PM suspend handler to indicate
unsupported operation to the PCI subsystem explicitly, thus avoiding
system to go into suspended/standby mode.

Without this fix device/firmware does not recover unless system
is power cycled.

Fixes: 2950219d87b0 ("qede: Add basic network device support")
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230816150711.59035-1-manishc@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 4b004a728190..99df00c30b8c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -176,6 +176,15 @@ static int qede_sriov_configure(struct pci_dev *pdev, int num_vfs_param)
 }
 #endif
 
+static int __maybe_unused qede_suspend(struct device *dev)
+{
+	dev_info(dev, "Device does not support suspend operation\n");
+
+	return -EOPNOTSUPP;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qede_pm_ops, qede_suspend, NULL);
+
 static const struct pci_error_handlers qede_err_handler = {
 	.error_detected = qede_io_error_detected,
 };
@@ -190,6 +199,7 @@ static struct pci_driver qede_pci_driver = {
 	.sriov_configure = qede_sriov_configure,
 #endif
 	.err_handler = &qede_err_handler,
+	.driver.pm = &qede_pm_ops,
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {

