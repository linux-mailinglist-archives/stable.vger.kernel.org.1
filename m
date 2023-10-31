Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25E7DD529
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376439AbjJaRrt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376459AbjJaRrr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08E121
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:47:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DB5C433C9;
        Tue, 31 Oct 2023 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774459;
        bh=NJFVWUEEvBZcX1pFuqJEPAANT6eOLbO4qBYCcONdSro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1xo5FXb6yLqtZBiuKFt4bdlg2ZQe9nJRT6yga4RAYtbNj0ixAH5OwmufQrGZuZJv
         0I3/Dfw5nhA5doaGuSLpIvE1hGU6H6kTBtV8c2Pilq8VEubXmRmi/xzOSI4+KBUAg1
         c9xEBdkfuG5852oBuJ4rMbAEXz2fxBwgWj9dwYUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 052/112] iavf: initialize waitqueues before starting watchdog_task
Date:   Tue, 31 Oct 2023 18:00:53 +0100
Message-ID: <20231031165902.945231992@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 7db3111043885c146e795c199d39c3f9042d97c0 ]

It is not safe to initialize the waitqueues after queueing the
watchdog_task. It will be using them.

The chance of this causing a real problem is very small, because
there will be some sleeping before any of the waitqueues get used.
I got a crash only after inserting an artificial sleep in iavf_probe.

Queue the watchdog_task as the last step in iavf_probe. Add a comment to
prevent repeating the mistake.

Fixes: fe2647ab0c99 ("i40evf: prevent VF close returning before state transitions to DOWN")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8ea5c0825c3c4..14875cd85a8e3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4982,8 +4982,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
-	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
@@ -4994,6 +4992,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
+	/* Initialization goes on in the work. Do not add more of it below. */
 	return 0;
 
 err_ioremap:
-- 
2.42.0



