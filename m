Return-Path: <stable+bounces-161132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E2AFD390
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06025188C01B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F332E1C74;
	Tue,  8 Jul 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ys5nnzg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123541DB127;
	Tue,  8 Jul 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993688; cv=none; b=J7Dy0zK6/NeOY7q/4NzxdoK2GcdxfAkLl1t2AqkjmHa/FqDW35UqowkbFgmOdVy4z5pjhAKCVkqDwhzhky4xkKUH4tmbX5P37z/Hi+hfF04tqq97OFbU9YmiM0gfRrbKmKYz207YDt5fVrg4gqpy/CtwZpoDMqa8s5LlO78Z/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993688; c=relaxed/simple;
	bh=jMrVoTsG4e38dY/z2J9dSxlVIolTAcH2gWENm6POU8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5neusQabqXZjcUDGjee/wv8H8QmLZX9lZ9GWS6oVuhHL7BpNbBvlc0zM7/3u4BBbQZBo8lwYRjlGyQPpG5txPqcbIPtqoPoJd6wS9jpguouNGeOirspvyzbrkqWVaJNa26FOkFUR0VP/KvEgchTDRqqqcpK4UjH3OV9rDAcZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ys5nnzg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86914C4CEED;
	Tue,  8 Jul 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993687;
	bh=jMrVoTsG4e38dY/z2J9dSxlVIolTAcH2gWENm6POU8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys5nnzg3zcW59bGI11Dvx3bdgFhT9PEgPLXD8PQYwkVNf/YCh75WxUta3EYtsIOnW
	 N0dhXKARo5wCDsdxeHhe7iz3qpPtizEWsXd/OOShbalp6bsCnjkS0DqTIj0wtHKGDu
	 MN3gx1ELq3cAmGDrRZ++B83OMBUBbVf22C54fEis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qasim Ijaz <qasdev00@gmail.com>,
	Aditya Garg <gargaditya08@live.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.15 159/178] HID: appletb-kbd: fix slab use-after-free bug in appletb_kbd_probe
Date: Tue,  8 Jul 2025 18:23:16 +0200
Message-ID: <20250708162240.640999934@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit 38224c472a038fa9ccd4085511dd9f3d6119dbf9 upstream.

In probe appletb_kbd_probe() a "struct appletb_kbd *kbd" is allocated
via devm_kzalloc() to store touch bar keyboard related data.
Later on if backlight_device_get_by_name() finds a backlight device
with name "appletb_backlight" a timer (kbd->inactivity_timer) is setup
with appletb_inactivity_timer() and the timer is armed to run after
appletb_tb_dim_timeout (60) seconds.

A use-after-free is triggered when failure occurs after the timer is
armed. This ultimately means probe failure occurs and as a result the
"struct appletb_kbd *kbd" which is device managed memory is freed.
After 60 seconds the timer will have expired and __run_timers will
attempt to access the timer (kbd->inactivity_timer) however the kdb
structure has been freed causing a use-after free.

[   71.636938] ==================================================================
[   71.637915] BUG: KASAN: slab-use-after-free in __run_timers+0x7ad/0x890
[   71.637915] Write of size 8 at addr ffff8881178c5958 by task swapper/1/0
[   71.637915]
[   71.637915] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.0-rc2-00318-g739a6c93cc75-dirty #12 PREEMPT(voluntary)
[   71.637915] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   71.637915] Call Trace:
[   71.637915]  <IRQ>
[   71.637915]  dump_stack_lvl+0x53/0x70
[   71.637915]  print_report+0xce/0x670
[   71.637915]  ? __run_timers+0x7ad/0x890
[   71.637915]  kasan_report+0xce/0x100
[   71.637915]  ? __run_timers+0x7ad/0x890
[   71.637915]  __run_timers+0x7ad/0x890
[   71.637915]  ? __pfx___run_timers+0x10/0x10
[   71.637915]  ? update_process_times+0xfc/0x190
[   71.637915]  ? __pfx_update_process_times+0x10/0x10
[   71.637915]  ? _raw_spin_lock_irq+0x80/0xe0
[   71.637915]  ? _raw_spin_lock_irq+0x80/0xe0
[   71.637915]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[   71.637915]  run_timer_softirq+0x141/0x240
[   71.637915]  ? __pfx_run_timer_softirq+0x10/0x10
[   71.637915]  ? __pfx___hrtimer_run_queues+0x10/0x10
[   71.637915]  ? kvm_clock_get_cycles+0x18/0x30
[   71.637915]  ? ktime_get+0x60/0x140
[   71.637915]  handle_softirqs+0x1b8/0x5c0
[   71.637915]  ? __pfx_handle_softirqs+0x10/0x10
[   71.637915]  irq_exit_rcu+0xaf/0xe0
[   71.637915]  sysvec_apic_timer_interrupt+0x6c/0x80
[   71.637915]  </IRQ>
[   71.637915]
[   71.637915] Allocated by task 39:
[   71.637915]  kasan_save_stack+0x33/0x60
[   71.637915]  kasan_save_track+0x14/0x30
[   71.637915]  __kasan_kmalloc+0x8f/0xa0
[   71.637915]  __kmalloc_node_track_caller_noprof+0x195/0x420
[   71.637915]  devm_kmalloc+0x74/0x1e0
[   71.637915]  appletb_kbd_probe+0x37/0x3c0
[   71.637915]  hid_device_probe+0x2d1/0x680
[   71.637915]  really_probe+0x1c3/0x690
[   71.637915]  __driver_probe_device+0x247/0x300
[   71.637915]  driver_probe_device+0x49/0x210
[...]
[   71.637915]
[   71.637915] Freed by task 39:
[   71.637915]  kasan_save_stack+0x33/0x60
[   71.637915]  kasan_save_track+0x14/0x30
[   71.637915]  kasan_save_free_info+0x3b/0x60
[   71.637915]  __kasan_slab_free+0x37/0x50
[   71.637915]  kfree+0xcf/0x360
[   71.637915]  devres_release_group+0x1f8/0x3c0
[   71.637915]  hid_device_probe+0x315/0x680
[   71.637915]  really_probe+0x1c3/0x690
[   71.637915]  __driver_probe_device+0x247/0x300
[   71.637915]  driver_probe_device+0x49/0x210
[...]

The root cause of the issue is that the timer is not disarmed
on failure paths leading to it remaining active and accessing
freed memory. To fix this call timer_delete_sync() to deactivate
the timer.

Another small issue is that timer_delete_sync is called
unconditionally in appletb_kbd_remove(), fix this by checking
for a valid kbd->backlight_dev before calling timer_delete_sync.

Fixes: 93a0fc489481 ("HID: hid-appletb-kbd: add support for automatic brightness control while using the touchbar")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reviewed-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-appletb-kbd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -437,8 +437,10 @@ static int appletb_kbd_probe(struct hid_
 unregister_handler:
 	input_unregister_handler(&kbd->inp_handler);
 close_hw:
-	if (kbd->backlight_dev)
+	if (kbd->backlight_dev) {
 		put_device(&kbd->backlight_dev->dev);
+		timer_delete_sync(&kbd->inactivity_timer);
+	}
 	hid_hw_close(hdev);
 stop_hw:
 	hid_hw_stop(hdev);
@@ -452,10 +454,10 @@ static void appletb_kbd_remove(struct hi
 	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
 	input_unregister_handler(&kbd->inp_handler);
-	timer_delete_sync(&kbd->inactivity_timer);
-
-	if (kbd->backlight_dev)
+	if (kbd->backlight_dev) {
 		put_device(&kbd->backlight_dev->dev);
+		timer_delete_sync(&kbd->inactivity_timer);
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);



