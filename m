Return-Path: <stable+bounces-20727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4585AB8C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D081C21964
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376047A4D;
	Mon, 19 Feb 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2Xu6jzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CF44C93
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368741; cv=none; b=Ai78R0LCNpT26T3/Os4dwCQmZqXL9qLwkxHoe6jggT3LRSUSpspqM2Z5NKLJHGfPJDTBn2+KQblBePm4NNW7uB3B8jLAK9GdbvqEQxqRtdte/MaKdrqDZ9KtCYMcqsCJGvrk0tPDPKMVA0oNf6o2uCocfbaNNHXWQljgOSq8hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368741; c=relaxed/simple;
	bh=gsCsmZEpSpWv0v39Gj+yzbkZgwp6v6RDiKP7mGyxm/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n+PKlT98AsX9DNIkKLAvVDFBYjjZL2rV65KFrMdT2zZ1CNzHHEirjih6T9cJI0ExB6JZ57uLHgG3S3zGD2z5ZoClJUVo/6TmxUy8GBc49ixv4FhF6CFtyHnKRqZt3yP7gQRenSrJI8CYoNLP+a71gFvYL+qKblzC3vVaOE5cCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2Xu6jzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A5C43394;
	Mon, 19 Feb 2024 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368740;
	bh=gsCsmZEpSpWv0v39Gj+yzbkZgwp6v6RDiKP7mGyxm/M=;
	h=Subject:To:Cc:From:Date:From;
	b=S2Xu6jzHXhj8zw4Mhe9hTyE4E5e9zJ/vnRFk4U1+UzPdUaZpNe5K/S+pdTa5Knv6W
	 ME2jNMqiNv3U+6fftuIxpmTnJXGkBs7SgPieWciX7wIY2AkVZGkOYxALlFe1MoOUo/
	 1Mb+gvhX4JIXtol2fhsXiWbeV9g/M3mgvIFDOuSQ=
Subject: FAILED: patch "[PATCH] xen/events: close evtchn after mapping cleanup" failed to apply to 5.10-stable tree
To: mheyne@amazon.de,apanyaki@amazon.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:52:14 +0100
Message-ID: <2024021914-wackiness-diagnoses-52e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fa765c4b4aed2d64266b694520ecb025c862c5a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021914-wackiness-diagnoses-52e2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

fa765c4b4aed ("xen/events: close evtchn after mapping cleanup")
3fcdaf3d7634 ("xen/events: modify internal [un]bind interfaces")
5dd9ad32d775 ("xen/events: drop xen_allocate_irqs_dynamic()")
3bdb0ac350fe ("xen/events: remove some simple helpers from events_base.c")
686464514fbe ("xen/events: reduce externally visible helper functions")
e64e7c74b99e ("xen/events: avoid using info_for_irq() in xen_send_IPI_one()")
9e90e58c11b7 ("xen: evtchn: Allow shared registration of IRQ handers")
87797fad6cce ("xen/events: replace evtchn_rwlock with RCU")
58f6259b7a08 ("xen/evtchn: Introduce new IOCTL to bind static evtchn")
04d684875b30 ("xen: xen_debug_interrupt prototype to global header")
073352e951f6 ("genirq: Add and use an irq_data_update_affinity helper")
961343d78226 ("genirq: Refactor accessors to use irq_data_get_affinity_mask")
83f877a09516 ("xen/events: remove redundant initialization of variable irq")
3de218ff39b9 ("xen/events: reset active flag for lateeoi events later")
d120198bd5ff ("xen/evtchn: Change irq_info lock to raw_spinlock_t")
b6622798bc50 ("xen/events: avoid handling the same event on two cpus at the same time")
25da4618af24 ("xen/events: don't unmask an event channel when an eoi is pending")
06f45fe96fcd ("xen/events: add per-xenbus device event statistics and settings")
f2fa0e5e9f31 ("xen/events: link interdomain events to associated xenbus device")
88f0a9d06644 ("xen/events: Implement irq distribution")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa765c4b4aed2d64266b694520ecb025c862c5a9 Mon Sep 17 00:00:00 2001
From: Maximilian Heyne <mheyne@amazon.de>
Date: Wed, 24 Jan 2024 16:31:28 +0000
Subject: [PATCH] xen/events: close evtchn after mapping cleanup

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

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b8cfea7812d6..3b9f080109d7 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -923,8 +923,8 @@ static void shutdown_pirq(struct irq_data *data)
 		return;
 
 	do_mask(info, EVT_MASK_REASON_EXPLICIT);
-	xen_evtchn_close(evtchn);
 	xen_irq_info_cleanup(info);
+	xen_evtchn_close(evtchn);
 }
 
 static void enable_pirq(struct irq_data *data)
@@ -956,6 +956,7 @@ EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 {
 	evtchn_port_t evtchn;
+	bool close_evtchn = false;
 
 	if (!info) {
 		xen_irq_free_desc(irq);
@@ -975,7 +976,7 @@ static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 		struct xenbus_device *dev;
 
 		if (!info->is_static)
-			xen_evtchn_close(evtchn);
+			close_evtchn = true;
 
 		switch (info->type) {
 		case IRQT_VIRQ:
@@ -995,6 +996,9 @@ static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 		}
 
 		xen_irq_info_cleanup(info);
+
+		if (close_evtchn)
+			xen_evtchn_close(evtchn);
 	}
 
 	xen_free_irq(info);


