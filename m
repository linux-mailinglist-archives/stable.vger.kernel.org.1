Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EB7DD3F6
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjJaRGc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjJaRGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA2E4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52EAC433C9;
        Tue, 31 Oct 2023 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771836;
        bh=sybyvJX6f9RTDd4I66HTmH7b4oAKg2Y6v0GKwxDwycU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnFuUUBRDvESn+2/tUhH0T7nzVZymjUjR/DBd+IUM6GZjI8FtBlL3xRLNTMuHsf+9
         5k6ZsceGGMLe89MFxFrHrxzFYvQ4rFVlJSdQoAGaViUns4WDuu/w5f6lnY/4VVgHWa
         WIQ9Li1ipp45ND4+jU0rK8gQIk3hmrblVCCxKn8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 37/86] iavf: initialize waitqueues before starting watchdog_task
Date:   Tue, 31 Oct 2023 18:01:02 +0100
Message-ID: <20231031165919.794321733@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index a39f7f0d6ab0b..1ae90f8f9941f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5020,8 +5020,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
-	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
@@ -5032,6 +5030,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
+	/* Initialization goes on in the work. Do not add more of it below. */
 	return 0;
 
 err_ioremap:
-- 
2.42.0



