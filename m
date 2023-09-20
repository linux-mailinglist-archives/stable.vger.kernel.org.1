Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9647A7AC5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjITLpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjITLpx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:45:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDFCA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:45:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFE7C433C8;
        Wed, 20 Sep 2023 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210347;
        bh=bT1HbCx0z3kEKtWWN71J2EIgJXeoURAogeJaab+iPCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qh76tzH0Y9CfAe19TqJY+5ua/l2m6tblIf3ZyOqdvZ6/+mfqG+xH7s+FYRd/Fl4UQ
         CwF6IF/0hTtfe5EsYlM7pB8yIlCDb65OMcVYWYAybA8jpds01qXUtGE6db8GLPcWrK
         qmS1XazVHEbipM8LDK6j45bRm/0Wun31nNi7jy/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ying Hsu <yinghsu@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 044/211] Bluetooth: Fix hci_suspend_sync crash
Date:   Wed, 20 Sep 2023 13:28:08 +0200
Message-ID: <20230920112847.156406088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ying Hsu <yinghsu@chromium.org>

[ Upstream commit 573ebae162111063eedc6c838a659ba628f66a0f ]

If hci_unregister_dev() frees the hci_dev object but hci_suspend_notifier
may still be accessing it, it can cause the program to crash.
Here's the call trace:
  <4>[102152.653246] Call Trace:
  <4>[102152.653254]  hci_suspend_sync+0x109/0x301 [bluetooth]
  <4>[102152.653259]  hci_suspend_dev+0x78/0xcd [bluetooth]
  <4>[102152.653263]  hci_suspend_notifier+0x42/0x7a [bluetooth]
  <4>[102152.653268]  notifier_call_chain+0x43/0x6b
  <4>[102152.653271]  __blocking_notifier_call_chain+0x48/0x69
  <4>[102152.653273]  __pm_notifier_call_chain+0x22/0x39
  <4>[102152.653276]  pm_suspend+0x287/0x57c
  <4>[102152.653278]  state_store+0xae/0xe5
  <4>[102152.653281]  kernfs_fop_write+0x109/0x173
  <4>[102152.653284]  __vfs_write+0x16f/0x1a2
  <4>[102152.653287]  ? selinux_file_permission+0xca/0x16f
  <4>[102152.653289]  ? security_file_permission+0x36/0x109
  <4>[102152.653291]  vfs_write+0x114/0x21d
  <4>[102152.653293]  __x64_sys_write+0x7b/0xdb
  <4>[102152.653296]  do_syscall_64+0x59/0x194
  <4>[102152.653299]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1

This patch holds the reference count of the hci_dev object while
processing it in hci_suspend_notifier to avoid potential crash
caused by the race condition.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2c845c9a26be0..29ae9b254a34e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2436,6 +2436,9 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return NOTIFY_DONE;
 
+	/* To avoid a potential race with hci_unregister_dev. */
+	hci_dev_hold(hdev);
+
 	if (action == PM_SUSPEND_PREPARE)
 		ret = hci_suspend_dev(hdev);
 	else if (action == PM_POST_SUSPEND)
@@ -2445,6 +2448,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
 			   action, ret);
 
+	hci_dev_put(hdev);
 	return NOTIFY_DONE;
 }
 
-- 
2.40.1



