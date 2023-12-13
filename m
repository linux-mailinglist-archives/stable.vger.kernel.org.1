Return-Path: <stable+bounces-5738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E480D632
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE58A1C21598
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6CFBE1;
	Mon, 11 Dec 2023 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q1XaGhA3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CCC2D0;
	Mon, 11 Dec 2023 18:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC31C433C8;
	Mon, 11 Dec 2023 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319533;
	bh=YSW8eta0Hdz3iLuPOLeAMx3CyV5ev3zB4yEOWdlU0zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1XaGhA3Rqyh4D3MnqlFhFmGoj1CfC8VwgiNfKjjgZgjW7aiXDZoX8wLCcV0YiHV0
	 AubA2DU10+SflfR7h2fG5fW2TFQMJ7CMMD0RMXEkag3VxIkuPe1Xzxa+gU5hwwEwX0
	 DAFawwl6+O/4J3o5D274kXLkdg7b/RBORIG3nkf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ismail, Mustafa" <mustafa.ismail@intel.com>,
	Shifeng Li <lishifeng@sangfor.com.cn>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/244] RDMA/irdma: Avoid free the non-cqp_request scratch
Date: Mon, 11 Dec 2023 19:20:04 +0100
Message-ID: <20231211182050.767418591@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shifeng Li <lishifeng@sangfor.com.cn>

[ Upstream commit e3e82fcb79eeb3f1a88a89f676831773caff514a ]

When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as a
cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when
removing the irdma driver or unplugging its aux device, cqp.sc_cqp will be
dereferenced as wrong struct in irdma_free_pending_cqp_request().

  PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
   #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
   #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
   #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
   #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
   #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
      [exception RIP: native_queued_spin_lock_slowpath+1291]
      RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
      RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
      RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
      RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
      R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
      R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
  -- <NMI exception stack> --
   #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e72b
   #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
   #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
   #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc [irdma]
   #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469 [irdma]
   #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
   #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
   #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
   #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e6
   #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
   #15 [ffff88aa841efb88] device_del at ffffffff82179d23
   #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
   #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
   #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
   #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
   #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
   #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Link: https://lore.kernel.org/r/20231130081415.891006-1-lishifeng@sangfor.com.cn
Suggested-by: "Ismail, Mustafa" <mustafa.ismail@intel.com>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index db3829ff922b5..564c9188e1f84 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1184,7 +1184,6 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	int status;
 	struct irdma_ceq_init_info info = {};
 	struct irdma_sc_dev *dev = &rf->sc_dev;
-	u64 scratch;
 	u32 ceq_size;
 
 	info.ceq_id = ceq_id;
@@ -1205,14 +1204,13 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	iwceq->sc_ceq.ceq_id = ceq_id;
 	info.dev = dev;
 	info.vsi = vsi;
-	scratch = (uintptr_t)&rf->cqp.sc_cqp;
 	status = irdma_sc_ceq_init(&iwceq->sc_ceq, &info);
 	if (!status) {
 		if (dev->ceq_valid)
 			status = irdma_cqp_ceq_cmd(&rf->sc_dev, &iwceq->sc_ceq,
 						   IRDMA_OP_CEQ_CREATE);
 		else
-			status = irdma_sc_cceq_create(&iwceq->sc_ceq, scratch);
+			status = irdma_sc_cceq_create(&iwceq->sc_ceq, 0);
 	}
 
 	if (status) {
-- 
2.42.0




