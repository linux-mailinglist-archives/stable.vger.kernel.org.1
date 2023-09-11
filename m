Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B379BFFB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbjIKU56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbjIKPQz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:16:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:16:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB879C433C7;
        Mon, 11 Sep 2023 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445410;
        bh=0CuxGKHs2pjK+xD40JpGNxYv0G6imNDuxcCJ7kobijY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJKEhL+SJkGAtdEc6aj0JcXUZ2tiAUhNT5pk+BMDpnuF4wS/JrBQ87DaqwzzVZrsx
         ZmkjKMpSdme4BPD7mAL++OVxGK5zQGe2/HMXU1n2AQWwDCmItTGGu6F1Q1KXOcIZnM
         CqPlwDgm011k2h4NIV/mPoLddXOf7n4+9fmetQBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 338/600] PCI/DOE: Fix destroy_work_on_stack() race
Date:   Mon, 11 Sep 2023 15:46:11 +0200
Message-ID: <20230911134643.668118999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ira Weiny <ira.weiny@intel.com>

[ Upstream commit e3a3a097eaebaf234a482b4d2f9f18fe989208c1 ]

The following debug object splat was observed in testing:

  ODEBUG: free active (active state 0) object: 0000000097d23782 object type: work_struct hint: doe_statemachine_work+0x0/0x510
  WARNING: CPU: 1 PID: 71 at lib/debugobjects.c:514 debug_print_object+0x7d/0xb0
  ...
  Workqueue: pci 0000:36:00.0 DOE [1 doe_statemachine_work
  RIP: 0010:debug_print_object+0x7d/0xb0
  ...
  Call Trace:
   ? debug_print_object+0x7d/0xb0
   ? __pfx_doe_statemachine_work+0x10/0x10
   debug_object_free.part.0+0x11b/0x150
   doe_statemachine_work+0x45e/0x510
   process_one_work+0x1d4/0x3c0

This occurs because destroy_work_on_stack() was called after signaling
the completion in the calling thread.  This creates a race between
destroy_work_on_stack() and the task->work struct going out of scope in
pci_doe().

Signal the work complete after destroying the work struct.  This is safe
because signal_task_complete() is the final thing the work item does and
the workqueue code is careful not to access the work struct after.

Fixes: abf04be0e707 ("PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y")
Link: https://lore.kernel.org/r/20230726-doe-fix-v1-1-af07e614d4dd@intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/doe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e5e9b287b9766..c1776f82b7fce 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -223,8 +223,8 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 static void signal_task_complete(struct pci_doe_task *task, int rv)
 {
 	task->rv = rv;
-	task->complete(task);
 	destroy_work_on_stack(&task->work);
+	task->complete(task);
 }
 
 static void signal_task_abort(struct pci_doe_task *task, int rv)
-- 
2.40.1



