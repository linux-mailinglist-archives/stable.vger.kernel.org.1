Return-Path: <stable+bounces-24425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9E86946C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E89C1C23FD8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA6145FEE;
	Tue, 27 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWgEYFbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C7145FE1;
	Tue, 27 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041964; cv=none; b=iS1ScZA1O71q39JmLtiY3okbQksXYgjdAgleM2UBXuclVdhr8i29ib7Usa5aRMCrBjBeiY0TdTJefsWGPLs+dHlmBAncGQcgaFf0A+h7ut+t2QZceW9EXhgFHYqC2LyU0/RgeGmw5JGbOkPJq6DMUwJqiOiKhotefMQ20vaPjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041964; c=relaxed/simple;
	bh=5wkpnkJv3754w+CEWX8zvgd/bOLm+Xb0mAdTaXW7r2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBaXM0GNpbNxsC3+++a7+C6Fqdc33At4qh9uH98465VVwmAX4qBw/0xjtMxDzki1vigmfkeXRvUe5BxholOzgAXR3AEim3bng+hqmendgwHhIVRucpTM3Lvj4N07JY1lADI2/N/TgrrTBUySGJ/idR90C4Srt9Gbp5s/4vtKIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWgEYFbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B69C433A6;
	Tue, 27 Feb 2024 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041964;
	bh=5wkpnkJv3754w+CEWX8zvgd/bOLm+Xb0mAdTaXW7r2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWgEYFbLLgRLdm6OaZTOjwTOrgZBJk23wX73RSMty4FORYPv9bVBF8GSWBLgNNlQ5
	 lIwxVVOISu5FqUmAQ8DQoEx0aRkgquM9dDotaiMSrMA1pV0G3q/ywpFD4Aet7+lVcX
	 SQgPU9PTA96u3ITYLC9ARVUPjMNrRSiKwD4LOc+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maximilian Heyne <mheyne@amazon.de>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Andrew Panyakin <apanyaki@amazon.com>
Subject: [PATCH 6.6 132/299] xen/events: close evtchn after mapping cleanup
Date: Tue, 27 Feb 2024 14:24:03 +0100
Message-ID: <20240227131630.107456549@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Maximilian Heyne <mheyne@amazon.de>

[ Upstream commit fa765c4b4aed2d64266b694520ecb025c862c5a9 ]

shutdown_pirq and startup_pirq are not taking the
irq_mapping_update_lock because they can't due to lock inversion. Both
are called with the irq_desc->lock being taking. The lock order,
however, is first irq_mapping_update_lock and then irq_desc->lock.

This opens multiple races:
- shutdown_pirq can be interrupted by a function that allocates an event
  channel:

  CPU0                        CPU1
  shutdown_pirq {
    xen_evtchn_close(e)
                              __startup_pirq {
                                EVTCHNOP_bind_pirq
                                  -> returns just freed evtchn e
                                set_evtchn_to_irq(e, irq)
                              }
    xen_irq_info_cleanup() {
      set_evtchn_to_irq(e, -1)
    }
  }

  Assume here event channel e refers here to the same event channel
  number.
  After this race the evtchn_to_irq mapping for e is invalid (-1).

- __startup_pirq races with __unbind_from_irq in a similar way. Because
  __startup_pirq doesn't take irq_mapping_update_lock it can grab the
  evtchn that __unbind_from_irq is currently freeing and cleaning up. In
  this case even though the event channel is allocated, its mapping can
  be unset in evtchn_to_irq.

The fix is to first cleanup the mappings and then close the event
channel. In this way, when an event channel gets allocated it's
potential previous evtchn_to_irq mappings are guaranteed to be unset already.
This is also the reverse order of the allocation where first the event
channel is allocated and then the mappings are setup.

On a 5.10 kernel prior to commit 3fcdaf3d7634 ("xen/events: modify internal
[un]bind interfaces"), we hit a BUG like the following during probing of NVMe
devices. The issue is that during nvme_setup_io_queues, pci_free_irq
is called for every device which results in a call to shutdown_pirq.
With many nvme devices it's therefore likely to hit this race during
boot because there will be multiple calls to shutdown_pirq and
startup_pirq are running potentially in parallel.

  ------------[ cut here ]------------
  blkfront: xvda: barrier or flush: disabled; persistent grants: enabled; indirect descriptors: enabled; bounce buffer: enabled
  kernel BUG at drivers/xen/events/events_base.c:499!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 44 PID: 375 Comm: kworker/u257:23 Not tainted 5.10.201-191.748.amzn2.x86_64 #1
  Hardware name: Xen HVM domU, BIOS 4.11.amazon 08/24/2006
  Workqueue: nvme-reset-wq nvme_reset_work
  RIP: 0010:bind_evtchn_to_cpu+0xdf/0xf0
  Code: 5d 41 5e c3 cc cc cc cc 44 89 f7 e8 2b 55 ad ff 49 89 c5 48 85 c0 0f 84 64 ff ff ff 4c 8b 68 30 41 83 fe ff 0f 85 60 ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00
  RSP: 0000:ffffc9000d533b08 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
  RDX: 0000000000000028 RSI: 00000000ffffffff RDI: 00000000ffffffff
  RBP: ffff888107419680 R08: 0000000000000000 R09: ffffffff82d72b00
  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000001ed
  R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000002
  FS:  0000000000000000(0000) GS:ffff88bc8b500000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000002610001 CR4: 00000000001706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   ? show_trace_log_lvl+0x1c1/0x2d9
   ? show_trace_log_lvl+0x1c1/0x2d9
   ? set_affinity_irq+0xdc/0x1c0
   ? __die_body.cold+0x8/0xd
   ? die+0x2b/0x50
   ? do_trap+0x90/0x110
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? do_error_trap+0x65/0x80
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? exc_invalid_op+0x4e/0x70
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? asm_exc_invalid_op+0x12/0x20
   ? bind_evtchn_to_cpu+0xdf/0xf0
   ? bind_evtchn_to_cpu+0xc5/0xf0
   set_affinity_irq+0xdc/0x1c0
   irq_do_set_affinity+0x1d7/0x1f0
   irq_setup_affinity+0xd6/0x1a0
   irq_startup+0x8a/0xf0
   __setup_irq+0x639/0x6d0
   ? nvme_suspend+0x150/0x150
   request_threaded_irq+0x10c/0x180
   ? nvme_suspend+0x150/0x150
   pci_request_irq+0xa8/0xf0
   ? __blk_mq_free_request+0x74/0xa0
   queue_request_irq+0x6f/0x80
   nvme_create_queue+0x1af/0x200
   nvme_create_io_queues+0xbd/0xf0
   nvme_setup_io_queues+0x246/0x320
   ? nvme_irq_check+0x30/0x30
   nvme_reset_work+0x1c8/0x400
   process_one_work+0x1b0/0x350
   worker_thread+0x49/0x310
   ? process_one_work+0x350/0x350
   kthread+0x11b/0x140
   ? __kthread_bind_mask+0x60/0x60
   ret_from_fork+0x22/0x30
  Modules linked in:
  ---[ end trace a11715de1eee1873 ]---

Fixes: d46a78b05c0e ("xen: implement pirq type event channels")
Cc: stable@vger.kernel.org
Co-debugged-by: Andrew Panyakin <apanyaki@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240124163130.31324-1-mheyne@amazon.de
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/events/events_base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6f57ef78f5507..36ba3ef6ef01e 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -908,8 +908,8 @@ static void shutdown_pirq(struct irq_data *data)
 		return;
 
 	do_mask(info, EVT_MASK_REASON_EXPLICIT);
-	xen_evtchn_close(evtchn);
 	xen_irq_info_cleanup(info);
+	xen_evtchn_close(evtchn);
 }
 
 static void enable_pirq(struct irq_data *data)
@@ -941,6 +941,7 @@ EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 {
 	evtchn_port_t evtchn;
+	bool close_evtchn = false;
 
 	if (!info) {
 		xen_irq_free_desc(irq);
@@ -960,7 +961,7 @@ static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 		struct xenbus_device *dev;
 
 		if (!info->is_static)
-			xen_evtchn_close(evtchn);
+			close_evtchn = true;
 
 		switch (info->type) {
 		case IRQT_VIRQ:
@@ -980,6 +981,9 @@ static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 		}
 
 		xen_irq_info_cleanup(info);
+
+		if (close_evtchn)
+			xen_evtchn_close(evtchn);
 	}
 
 	xen_free_irq(info);
-- 
2.43.0




