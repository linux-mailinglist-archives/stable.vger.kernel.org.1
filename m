Return-Path: <stable+bounces-73899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAA5970761
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53371B2147C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7E15ECE7;
	Sun,  8 Sep 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMqpvCIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD83156668
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798229; cv=none; b=a7pwWeWYp+fG9igTBA4hrYxXVl3YavERuPNJucBSn/E9PK2eQQ5xxGZW9l71KD7+pGCjDWUNKcnlJ5vE9yIfeiqoBjY0omutiQVKT8c1TdDnilKa/ZjmhdnnwFoKHQxOFV34MG4Aa73OowA7VrnuH4Dr2sWAbZoSdQ03V9W53Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798229; c=relaxed/simple;
	bh=NwR+Nbk01fWcfrONkFV4RKEexI8ZbrQypTL4tRfgi0Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RYyrU0X28cODFFLvDysvxBthgVCTzHItMuulOTBFc48ZaeWPJnL3DryqB0SUJNsXfxs9rfXERggzJbheQHtIYpmPe7XlOC/kz62TFFqATzZkzda1fCnQ3efHJ+YmKUlxkTSCRSv1wl2KSmbo9vUrCknFbIL9fo3l6LaNWvGyHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xMqpvCIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F3AC4CEC3;
	Sun,  8 Sep 2024 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725798228;
	bh=NwR+Nbk01fWcfrONkFV4RKEexI8ZbrQypTL4tRfgi0Q=;
	h=Subject:To:Cc:From:Date:From;
	b=xMqpvCIfG+aVvjqu6bqKvODxSOuEygkHPiDvC1cMLHjnYBaFl9BJfvqIgPb12Zkwl
	 xRcJHIG1MbiBVBbgg16lZ53PxrBHkajP0MAm+6DLKP40akZcInaV0R85Qd6NnW1SgG
	 tpQ6tWESsyT+0p9LTL+ITjZXcuqiq0R4RwOWeAT0=
Subject: FAILED: patch "[PATCH] fscache: delete fscache_cookie_lru_timer when fscache exits" failed to apply to 6.1-stable tree
To: libaokun1@huawei.com,brauner@kernel.org,dhowells@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:23:39 +0200
Message-ID: <2024090838-thus-fiftieth-f4f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090838-thus-fiftieth-f4f7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

72a6e22c604c ("fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Mon, 26 Aug 2024 19:20:56 +0800
Subject: [PATCH] fscache: delete fscache_cookie_lru_timer when fscache exits
 to avoid UAF

The fscache_cookie_lru_timer is initialized when the fscache module
is inserted, but is not deleted when the fscache module is removed.
If timer_reduce() is called before removing the fscache module,
the fscache_cookie_lru_timer will be added to the timer list of
the current cpu. Afterwards, a use-after-free will be triggered
in the softIRQ after removing the fscache module, as follows:

==================================================================
BUG: unable to handle page fault for address: fffffbfff803c9e9
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 21ffea067 P4D 21ffea067 PUD 21ffe6067 PMD 110a7c067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G W 6.11.0-rc3 #855
Tainted: [W]=WARN
RIP: 0010:__run_timer_base.part.0+0x254/0x8a0
Call Trace:
 <IRQ>
 tmigr_handle_remote_up+0x627/0x810
 __walk_groups.isra.0+0x47/0x140
 tmigr_handle_remote+0x1fa/0x2f0
 handle_softirqs+0x180/0x590
 irq_exit_rcu+0x84/0xb0
 sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:default_idle+0xf/0x20
 default_idle_call+0x38/0x60
 do_idle+0x2b5/0x300
 cpu_startup_entry+0x54/0x60
 start_secondary+0x20d/0x280
 common_startup_64+0x13e/0x148
 </TASK>
Modules linked in: [last unloaded: netfs]
==================================================================

Therefore delete fscache_cookie_lru_timer when removing the fscahe module.

Fixes: 12bb21a29c19 ("fscache: Implement cookie user counting and resource pinning")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240826112056.2458299-1-libaokun@huaweicloud.com
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
index 42e98bb523e3..49849005eb7c 100644
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -103,6 +103,7 @@ void __exit fscache_exit(void)
 
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
+	timer_shutdown_sync(&fscache_cookie_lru_timer);
 	destroy_workqueue(fscache_wq);
 	pr_notice("FS-Cache unloaded\n");
 }


