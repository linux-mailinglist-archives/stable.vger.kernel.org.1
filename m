Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E2782F11
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjHURGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjHURGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 13:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DE7EC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B98263FD9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 17:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EBDC433C7;
        Mon, 21 Aug 2023 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692637576;
        bh=rkPPsrXPVUCpGsdZn5gVHxLTUOVX7jzk5eX3ixuUAAs=;
        h=Subject:To:Cc:From:Date:From;
        b=j3pMmfDAUJ34BDy0XSne3Ls3b+bBN/l3EQEy2ahaHVghNlMa7kJIkjOCFemHgx043
         KwTiRDbs4HPGKf04UGcG4ttrLkQkkMf3nK478Ed+XaC0tWOOqi8CyNExV7eb+B6d0F
         rBOMYRPHYSo+c2+5NFGujGC/NVhnjAHB0VBW00pc=
Subject: FAILED: patch "[PATCH] qede: fix firmware halt over suspend and resume" failed to apply to 4.14-stable tree
To:     manishc@marvell.com, horms@kernel.org, jmeneghi@redhat.com,
        kuba@kernel.org, palok@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 19:06:05 +0200
Message-ID: <2023082105-decade-shout-4b7c@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 2eb9625a3a32251ecea470cd576659a3a03b4e59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082105-decade-shout-4b7c@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

2eb9625a3a32 ("qede: fix firmware halt over suspend and resume")
731815e720ae ("qede: Add support for handling the pcie errors.")
ccc67ef50b90 ("qede: Error recovery process")
f04e48dbfaf7 ("qede: Update link status only when interface is ready.")
149d3775f108 ("qede: Simplify the usage of qede-flags.")
d25b859ccd61 ("qede: Add support for populating ethernet TLVs.")
91dfd02b2300 ("qede: Fix ref-cnt usage count")
3f2176dd7fe9 ("qede: fix spelling mistake: "registeration" -> "registration"")
bd0b2e7fe611 ("net: xdp: make the stack take care of the tear down")
012bb8a8b5a2 ("nfp: bpf: drop support for cls_bpf with legacy actions")
43b45245e5a6 ("nfp: bpf: fall back to core NIC app if BPF not selected")
2c4197a041df ("nfp: reorganize the app table")
f449657f8353 ("nfp: bpf: reject TC offload if XDP loaded")
3248f77fa3ee ("drivers/net: netronome: Convert timers to use timer_setup()")
ee9133a845fe ("nfp: bpf: add stack write support")
70c78fc138b6 ("nfp: bpf: refactor nfp_bpf_check_ptr()")
90d97315b3e7 ("nfp: bpf: Convert ndo_setup_tc offloads to block callbacks")

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

