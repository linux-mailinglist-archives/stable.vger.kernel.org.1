Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90872B1F5
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjFKNLL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKNLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 09:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF85710DA
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 06:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FD160D33
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 13:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB37C433D2;
        Sun, 11 Jun 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686489068;
        bh=R5UP9zm0jLNIAKe5QFLEmQgIYCl64EF+3V6QcmfHNVo=;
        h=Subject:To:Cc:From:Date:From;
        b=KbBbFQe0MI1c8/wwnyGhQobDxkYnfEEBMudsCVt1RFQXKn2DtUS3/nACK5lL8WlTs
         0KZCLmCfKVvcLI65PLqHm31KmaMcz/CDvVyX3Uit72IwFfO+kOCj6iY4NFM/Uc+UOe
         4iCH3Znf8dFP4LabOgW2y3QVjqKE+9T4hhCoL1vs=
Subject: FAILED: patch "[PATCH] Bluetooth: fix debugfs registration" failed to apply to 5.15-stable tree
To:     johan+linaro@kernel.org, luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 15:11:05 +0200
Message-ID: <2023061105-backup-cotton-481a@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fe2ccc6c29d53e14d3c8b3ddf8ad965a92e074ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061105-backup-cotton-481a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe2ccc6c29d53e14d3c8b3ddf8ad965a92e074ee Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 31 May 2023 10:57:58 +0200
Subject: [PATCH] Bluetooth: fix debugfs registration

Since commit ec6cef9cd98d ("Bluetooth: Fix SMP channel registration for
unconfigured controllers") the debugfs interface for unconfigured
controllers will be created when the controller is configured.

There is however currently nothing preventing a controller from being
configured multiple time (e.g. setting the device address using btmgmt)
which results in failed attempts to register the already registered
debugfs entries:

	debugfs: File 'features' in directory 'hci0' already present!
	debugfs: File 'manufacturer' in directory 'hci0' already present!
	debugfs: File 'hci_version' in directory 'hci0' already present!
	...
	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!

Add a controller flag to avoid trying to register the debugfs interface
more than once.

Fixes: ec6cef9cd98d ("Bluetooth: Fix SMP channel registration for unconfigured controllers")
Cc: stable@vger.kernel.org      # 4.0
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 07df96c47ef4..872dcb91a540 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -350,6 +350,7 @@ enum {
 enum {
 	HCI_SETUP,
 	HCI_CONFIG,
+	HCI_DEBUGFS_CREATED,
 	HCI_AUTO_OFF,
 	HCI_RFKILLED,
 	HCI_MGMT,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a59695f04c25..804cde43b4e0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4551,6 +4551,9 @@ static int hci_init_sync(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_CONFIG))
 		return 0;
 
+	if (hci_dev_test_and_set_flag(hdev, HCI_DEBUGFS_CREATED))
+		return 0;
+
 	hci_debugfs_create_common(hdev);
 
 	if (lmp_bredr_capable(hdev))

