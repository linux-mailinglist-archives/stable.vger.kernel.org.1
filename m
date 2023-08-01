Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4FC76AD5C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjHAJ2e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjHAJ2O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FCE3C19
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9E5614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E86C433C8;
        Tue,  1 Aug 2023 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882034;
        bh=Gb5iS+1jgOIwCoz0REvbZ3baJd9i9+pTz43a5KMvglA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o31XvTWr8CXYTs88KWgNb9xPDa/11cfMKIhmW16sRA5opQAUeM+tcG4zyGXVq6LqX
         9LZK9wUD7krHUi3ClUg2LPUahP1zyVS34W9EDDDsCyFipidUPHBH+VrWvkBmYb+PTU
         PsNryjVutRnFjzHwIJiyA7VSaTj7tLXgdemcStcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/155] RDMA/irdma: Fix data race on CQP request done
Date:   Tue,  1 Aug 2023 11:19:59 +0200
Message-ID: <20230801091913.284100969@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit f0842bb3d38863777e3454da5653d80b5fde6321 ]

KCSAN detects a data race on cqp_request->request_done memory location
which is accessed locklessly in irdma_handle_cqp_op while being
updated in irdma_cqp_ce_handler.

Annotate lockless intent with READ_ONCE/WRITE_ONCE to avoid any
compiler optimizations like load fusing and/or KCSAN warning.

[222808.417128] BUG: KCSAN: data-race in irdma_cqp_ce_handler [irdma] / irdma_wait_event [irdma]

[222808.417532] write to 0xffff8e44107019dc of 1 bytes by task 29658 on cpu 5:
[222808.417610]  irdma_cqp_ce_handler+0x21e/0x270 [irdma]
[222808.417725]  cqp_compl_worker+0x1b/0x20 [irdma]
[222808.417827]  process_one_work+0x4d1/0xa40
[222808.417835]  worker_thread+0x319/0x700
[222808.417842]  kthread+0x180/0x1b0
[222808.417852]  ret_from_fork+0x22/0x30

[222808.417918] read to 0xffff8e44107019dc of 1 bytes by task 29688 on cpu 1:
[222808.417995]  irdma_wait_event+0x1e2/0x2c0 [irdma]
[222808.418099]  irdma_handle_cqp_op+0xae/0x170 [irdma]
[222808.418202]  irdma_cqp_cq_destroy_cmd+0x70/0x90 [irdma]
[222808.418308]  irdma_puda_dele_rsrc+0x46d/0x4d0 [irdma]
[222808.418411]  irdma_rt_deinit_hw+0x179/0x1d0 [irdma]
[222808.418514]  irdma_ib_dealloc_device+0x11/0x40 [irdma]
[222808.418618]  ib_dealloc_device+0x2a/0x120 [ib_core]
[222808.418823]  __ib_unregister_device+0xde/0x100 [ib_core]
[222808.418981]  ib_unregister_device+0x22/0x40 [ib_core]
[222808.419142]  irdma_ib_unregister_device+0x70/0x90 [irdma]
[222808.419248]  i40iw_close+0x6f/0xc0 [irdma]
[222808.419352]  i40e_client_device_unregister+0x14a/0x180 [i40e]
[222808.419450]  i40iw_remove+0x21/0x30 [irdma]
[222808.419554]  auxiliary_bus_remove+0x31/0x50
[222808.419563]  device_remove+0x69/0xb0
[222808.419572]  device_release_driver_internal+0x293/0x360
[222808.419582]  driver_detach+0x7c/0xf0
[222808.419592]  bus_remove_driver+0x8c/0x150
[222808.419600]  driver_unregister+0x45/0x70
[222808.419610]  auxiliary_driver_unregister+0x16/0x30
[222808.419618]  irdma_exit_module+0x18/0x1e [irdma]
[222808.419733]  __do_sys_delete_module.constprop.0+0x1e2/0x310
[222808.419745]  __x64_sys_delete_module+0x1b/0x30
[222808.419755]  do_syscall_64+0x39/0x90
[222808.419763]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[222808.419829] value changed: 0x01 -> 0x03

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230711175253.1289-4-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/hw.c    | 2 +-
 drivers/infiniband/hw/irdma/main.h  | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 2159470d7f7f4..0221200e16541 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -2084,7 +2084,7 @@ void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq)
 			cqp_request->compl_info.error = info.error;
 
 			if (cqp_request->waiting) {
-				cqp_request->request_done = true;
+				WRITE_ONCE(cqp_request->request_done, true);
 				wake_up(&cqp_request->waitq);
 				irdma_put_cqp_request(&rf->cqp, cqp_request);
 			} else {
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 454b4b370386c..f2e2bc50c6f7b 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -160,8 +160,8 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
+	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
-	bool request_done:1;
 	bool dynamic:1;
 };
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index d96779996e026..a47eedb6df82f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -481,7 +481,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		cqp_request->request_done = false;
+		WRITE_ONCE(cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 
@@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		cqp_request->request_done = true;
+		WRITE_ONCE(cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -571,7 +571,7 @@ static enum irdma_status_code irdma_wait_event(struct irdma_pci_f *rf,
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       cqp_request->request_done,
+				       READ_ONCE(cqp_request->request_done),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
-- 
2.40.1



