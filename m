Return-Path: <stable+bounces-241976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNQHF/+08mmUtgEAu9opvQ
	(envelope-from <stable+bounces-241976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:48:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A841A49C176
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C505D302F3A3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2028000F;
	Thu, 30 Apr 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYMF3DMT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D09270545
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513715; cv=none; b=oo8PfCWrGpr31wth7mMvC1QG+RIGzRNGG4OpqC1ezlyLqlV6Vpc0e9qxp5fY5CmvKe4km+yLJZQDoPxLHrZNrEAdkJU+ZSSiCvsBlVcWchSl01aMDbrRgXzRwAs9gK/SisGKmq1NqPQCHkI3W+RWd6BzVhBMDyqjJ0JzKo2U9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513715; c=relaxed/simple;
	bh=wRx/kU3uZwooWfGei4X2naH1Azcjgz7Wi7jS46y0HsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZ56S9ynXlnfOVJDwa89Xea+Wx2QqMVfqAs8iBjNH3tUQOCx0FiHdVGUDGIB6uw7w8BXGPjfGILEqbillZ1vOTsaiMDe+I7t7DHqXsReCrnkdivdONu09RAG9gPvlD5mRMoxSzjxw6bCSTjEGMOrFZv415mQQ/wpjUxTOCz8Psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYMF3DMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777513712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M2C/l2zeaxgLw1RCdMR5UPmHAGwhFo2arLdU4oZARDQ=;
	b=XYMF3DMTzFz8++kgz9iTuum/NWtTaDHr+9PeHsNDHFV5AOldGUSOnzJ6wsB/vhi4aYM/PP
	MGAkYr3nItIIXpuocZyMvpqfSo0zhPSDEuuq4MfiG+M+SFs4ET8RXdOPivhHujPrAqBssV
	AnJtVH7UldWtMDLnjdK4U3Rlk/moqBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-TmlbXR7kP_eoh7MLT6CW_g-1; Wed,
 29 Apr 2026 21:48:28 -0400
X-MC-Unique: TmlbXR7kP_eoh7MLT6CW_g-1
X-Mimecast-MFC-AGG-ID: TmlbXR7kP_eoh7MLT6CW_g_1777513707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7CDC195608B;
	Thu, 30 Apr 2026 01:48:27 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9682F1800345;
	Thu, 30 Apr 2026 01:48:24 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com,
	Desnes Nunes <desnesn@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: bound wait command completion to avoid kdump deadlock
Date: Wed, 29 Apr 2026 22:48:17 -0300
Message-ID: <20260430014817.2006885-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: A841A49C176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241976-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[desnesn@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The following deadlock in the usb subsystem can be triggered during kdump:

systemd-udevd[402]: usb3: Worker [419] processing SEQNUM=2194 is taking a long time
dracut-initqueue[432]: Timed out while waiting for udev queue to empty.
systemd-udevd[402]: usb3: Worker [419] processing SEQNUM=2194 killed
systemd-udevd[402]: usb3: Worker [419] terminated by signal 9 (KILL).
...
kdump[720]: saving vmcore complete
...
systemd-shutdown[1]: Rebooting.
INFO: task kworker/0:6:76 blocked for more than 122 seconds.
      Not tainted 6.12.0-223.2443_2475543665.el10.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D stack:0     pid:76    tgid:76    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __schedule+0x2a5/0x630
 schedule+0x27/0x80
 schedule_timeout+0xbf/0x100
 __wait_for_common+0x95/0x1b0
 ? __pfx_schedule_timeout+0x10/0x10
 xhci_alloc_dev+0x9e/0x290
 usb_alloc_dev+0x77/0x3a0
 hub_port_connect+0x293/0x9a0
 hub_port_connect_change+0x94/0x260
 port_event+0x4d1/0x7f0
 hub_event+0x16f/0x480
 process_one_work+0x174/0x330
 worker_thread+0x256/0x3a0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xfa/0x240
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
      Not tainted 6.12.0-223.2443_2475543665.el10.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-shutdow state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x2a5/0x630
 schedule+0x27/0x80
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x497/0x860
 device_shutdown+0xac/0x190
 kernel_restart+0x3a/0x70
 __do_sys_reboot+0x146/0x240
 do_syscall_64+0x7d/0x160
 ? devkmsg_write.cold+0x24/0x4a
 ? update_load_avg+0x7f/0x730
 ? __dequeue_entity+0x3ec/0x4a0
 ? update_load_avg+0x7f/0x730
 ? pick_next_task_fair+0x1e6/0x330
 ? finish_task_switch.isra.0+0x97/0x2a0
 ? rseq_get_rseq_cs+0x1d/0x220
 ? rseq_ip_fixup+0x8d/0x1d0
 ? arch_exit_to_user_mode_prepare.isra.0+0xa5/0xd0
 ? syscall_exit_to_user_mode+0x32/0x190
 ? do_syscall_64+0x89/0x160
 ? handle_mm_fault+0x110/0x370
 ? do_user_addr_fault+0x606/0x830
 ? exc_page_fault+0x7f/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f32517d9917
RSP: 002b:00007ffc018d4fb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f32517d9917
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc018d5130 R08: 0000000000000069 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffc018d5258 R15: 0000000000000000
 </TASK>

During crashkernel's boot, hub_event() takes usb_lock_device(hdev) of the
root hub and keeps it for the whole hub processing loop, since it calls
hub_port_connect() -> usb_alloc_dev() -> xhci_alloc_dev(). If during kdump
another device (e.g., a mis-initialized dGPU) hogs interrupts or DMAs, the
TRB_ENABLE_SLOT command will be blocked from completion in time, moving
the HC to an unstable condition (e.g., HSE in USBSTS). After vmcore gets
captured, init calls device_shutdown() trying to shut down the hub device,
by also trying to take the same lock still held by the hub kworker task.

Avoid the deadlock by adding a 2x timeout for command completion before
calling xhci_hc_died(). This gives enough time before marking the host un-
stable, dying and calling xhci_cleanup_command_queue(); which unblocks the
hub worker into releasing the lock, allowing device_shutdown() to proceed.

Fixes: c311e391a7efd ("xhci: rework command timeout and cancellation,")
Cc: stable@vger.kernel.org
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/usb/host/xhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a54f5b57f205..55250fe814c9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4219,7 +4219,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *vdev;
 	struct xhci_slot_ctx *slot_ctx;
-	unsigned long flags;
+	unsigned long flags, tflags;
 	int ret, slot_id;
 	struct xhci_command *command;
 
@@ -4238,9 +4238,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
-	wait_for_completion(command->completion);
-	slot_id = command->slot_id;
+	if (!wait_for_completion_timeout(command->completion,
+					 msecs_to_jiffies(2 * command->timeout_ms))) {
+		spin_lock_irqsave(&xhci->lock, tflags);
+		xhci_hc_died(xhci);
+		spin_unlock_irqrestore(&xhci->lock, tflags);
+	}
 
+	slot_id = command->slot_id;
 	if (!slot_id || command->status != COMP_SUCCESS) {
 		xhci_err(xhci, "Error while assigning device slot ID: %s\n",
 			 xhci_trb_comp_code_string(command->status));
-- 
2.51.0


