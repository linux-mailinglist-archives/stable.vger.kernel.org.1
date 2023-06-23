Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411773B382
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjFWJ13 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFWJ10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC5BA
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E452A619C2
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F232DC433C0;
        Fri, 23 Jun 2023 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512444;
        bh=21VpoT8jufwxtYVj/O+/uELZ2gaMOPXO532rVjahVCA=;
        h=Subject:To:Cc:From:Date:From;
        b=o8ho6xTQSfQ6qEbQz6sTTVEEKmwxGTPyj+l03XTHSxKGVm0e/F/StmgrxjzssUmNP
         DwCqWWPBHEaXs+88Y9wZv+Z/E3NtTmbmhjWPm2Afx3cwYbjEykP/VAxPso4XTqt+7T
         wUlYfjNIjhCmYTy3RM9zuAT2t9qPdqj6mpAVxr1Y=
Subject: FAILED: patch "[PATCH] PCI: hv: Fix a race condition bug in hv_pci_query_relations()" failed to apply to 4.14-stable tree
To:     decui@microsoft.com, lpieralisi@kernel.org, mikelley@microsoft.com,
        wei.liu@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:27:21 +0200
Message-ID: <2023062321-recreate-donation-85c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 440b5e3663271b0ffbd4908115044a6a51fb938b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062321-recreate-donation-85c8@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 440b5e3663271b0ffbd4908115044a6a51fb938b Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 14 Jun 2023 21:44:47 -0700
Subject: [PATCH] PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Since day 1 of the driver, there has been a race between
hv_pci_query_relations() and survey_child_resources(): during fast
device hotplug, hv_pci_query_relations() may error out due to
device-remove and the stack variable 'comp' is no longer valid;
however, pci_devices_present_work() -> survey_child_resources() ->
complete() may be running on another CPU and accessing the no-longer-valid
'comp'. Fix the race by flushing the workqueue before we exit from
hv_pci_query_relations().

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-2-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bc32662c6bb7..ea8862e656b6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3401,6 +3401,24 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 

