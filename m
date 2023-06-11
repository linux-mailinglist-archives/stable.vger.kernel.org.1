Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A172B1FA
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjFKNL3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjFKNL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 09:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888C10DC
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 06:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166A661921
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 13:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA58C433D2;
        Sun, 11 Jun 2023 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686489086;
        bh=0fGGaQw10WyKy4USQPurocexesfr3rnAJO8mM65sf30=;
        h=Subject:To:Cc:From:Date:From;
        b=1uT3Cu3dmSsCybu/KHo7sJtrtq4GwbrlqjKEF5ahc6RJyTnamRnRjkgy4ZCSWNpYE
         b9+G2NO2JZ/sqwwsiTrqAaBgaIXmp3Bp0LYVZM3kKWi92wrqFmdfoNJRJjz+uYnfMe
         WDp9Lanta5hPKL9Q53MVNzCp5o95NE01njEOADck=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_qca: fix debugfs registration" failed to apply to 5.4-stable tree
To:     johan+linaro@kernel.org, luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 15:11:23 +0200
Message-ID: <2023061123-thesaurus-untaken-5373@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 47c5d829a3e326b7395352a10fc8a6effe7afa15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061123-thesaurus-untaken-5373@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47c5d829a3e326b7395352a10fc8a6effe7afa15 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 31 May 2023 10:57:59 +0200
Subject: [PATCH] Bluetooth: hci_qca: fix debugfs registration

Since commit 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support
during hci down for wcn3990"), the setup callback which registers the
debugfs interface can be called multiple times.

This specifically leads to the following error when powering on the
controller:

	debugfs: Directory 'ibs' with parent 'hci0' already present!

Add a driver flag to avoid trying to register the debugfs interface more
than once.

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")
Cc: stable@vger.kernel.org	# 4.20
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b064504b388..e30c979535b1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,7 +78,8 @@ enum qca_flags {
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
 	QCA_BT_OFF,
-	QCA_ROM_FW
+	QCA_ROM_FW,
+	QCA_DEBUGFS_CREATED,
 };
 
 enum qca_capabilities {
@@ -635,6 +636,9 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return;
 
+	if (test_and_set_bit(QCA_DEBUGFS_CREATED, &qca->flags))
+		return;
+
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
 
 	/* read only */

