Return-Path: <stable+bounces-107312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C0A02B43
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673921885BB7
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB11DC991;
	Mon,  6 Jan 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bz/M2rXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFF156237;
	Mon,  6 Jan 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178088; cv=none; b=oneuuPQwic8FK+pyBwfjYcTLb/eXIB6aDaK/hXjkE/VSOeS6peQNbFUpBTMe1zwXtBvml6y0hiSJf7cP6HN57xQwGFH9RGhT0i/dvLUZyCFu8DIsZqGmbBXkBxpYbpI/9RaOmw+Heq4T9kI/jVTkGxiwL+QB8HvOQDOuH/CcAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178088; c=relaxed/simple;
	bh=TQEpTvZvth+umgw9UDKmAbTnbZ2l0dYbiYg3pcvD59A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShbUK3UXhDPuA3M7PQl4IBfmPGP9oh4dV7H8bU42BVNFWV81FwZ0Ax8DDFoKPZF9jfPzFySaG5SE+OiA2mtyPpisDc9eW7Yo+MkfnS1/+Ps/tFrtQYYkmnnGd3uaYazTa083uSgv+9593oc9H23Ked1osALwMWJvZtCbf4N/jNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bz/M2rXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ED8C4CED6;
	Mon,  6 Jan 2025 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178088;
	bh=TQEpTvZvth+umgw9UDKmAbTnbZ2l0dYbiYg3pcvD59A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bz/M2rXmfHbEyRLi+ypAXKk4tqqeT1jS+Ho18rThAdG4/fEf3CO7bBdD39bpNX/dl
	 1leJLaWDxQ845YVJZgys8ToZvPtkYjDO2HdyzQik6qRRjU9ZprXKEpeWsW8DDvA5Z2
	 3MdvF623Kw2utpqkwRDg0lZfckXSp9oRaZMmfXKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Carminati <acarmina@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Eric Chanudet <echanude@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 150/156] mm/kmemleak: fix sleeping function called from invalid context at print message
Date: Mon,  6 Jan 2025 16:17:16 +0100
Message-ID: <20250106151147.380803464@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alessandro Carminati <acarmina@redhat.com>

commit cddc76b165161a02ff14c4d84d0f5266d9d32b9e upstream.

Address a bug in the kernel that triggers a "sleeping function called from
invalid context" warning when /sys/kernel/debug/kmemleak is printed under
specific conditions:
- CONFIG_PREEMPT_RT=y
- Set SELinux as the LSM for the system
- Set kptr_restrict to 1
- kmemleak buffer contains at least one item

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
preempt_count: 1, expected: 0
RCU nest depth: 2, expected: 2
6 locks held by cat/136:
 #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0xe30
 #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+0x34/0x128
 #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_show+0x3c/0x1e0
 #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x8/0x1b0
 #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4/0x3d0
irq event stamp: 136660
hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlock_irqrestore+0xa8/0xd8
hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock_irqsave+0x8c/0xb0
softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8/0x3df8
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt7+ #34
Tainted: [E]=UNSIGNED_MODULE
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0xa0/0x128
 show_stack+0x1c/0x30
 dump_stack_lvl+0xe8/0x198
 dump_stack+0x18/0x20
 rt_spin_lock+0x8c/0x1a8
 avc_perm_nonode+0xa0/0x150
 cred_has_capability.isra.0+0x118/0x218
 selinux_capable+0x50/0x80
 security_capable+0x7c/0xd0
 has_ns_capability_noaudit+0x94/0x1b0
 has_capability_noaudit+0x20/0x30
 restricted_pointer+0x21c/0x4b0
 pointer+0x298/0x760
 vsnprintf+0x330/0xf70
 seq_printf+0x178/0x218
 print_unreferenced+0x1a4/0x2d0
 kmemleak_seq_show+0xd0/0x1e0
 seq_read_iter+0x354/0xe30
 seq_read+0x250/0x378
 full_proxy_read+0xd8/0x148
 vfs_read+0x190/0x918
 ksys_read+0xf0/0x1e0
 __arm64_sys_read+0x70/0xa8
 invoke_syscall.constprop.0+0xd4/0x1d8
 el0_svc+0x50/0x158
 el0t_64_sync+0x17c/0x180

%pS and %pK, in the same back trace line, are redundant, and %pS can void
%pK service in certain contexts.

%pS alone already provides the necessary information, and if it cannot
resolve the symbol, it falls back to printing the raw address voiding
the original intent behind the %pK.

Additionally, %pK requires a privilege check CAP_SYSLOG enforced through
the LSM, which can trigger a "sleeping function called from invalid
context" warning under RT_PREEMPT kernels when the check occurs in an
atomic context. This issue may also affect other LSMs.

This change avoids the unnecessary privilege check and resolves the
sleeping function warning without any loss of information.

Link: https://lkml.kernel.org/r/20241217142032.55793-1-acarmina@redhat.com
Fixes: 3a6f33d86baa ("mm/kmemleak: use %pK to display kernel pointers in backtrace")
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Clément Léger <clement.leger@bootlin.com>
Cc: Alessandro Carminati <acarmina@redhat.com>
Cc: Eric Chanudet <echanude@redhat.com>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -373,7 +373,7 @@ static void print_unreferenced(struct se
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
-		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
+		warn_or_seq_printf(seq, "    %pS\n", ptr);
 	}
 }
 



