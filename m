Return-Path: <stable+bounces-112074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989AA2695B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429EB1885D7F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4ED15A868;
	Tue,  4 Feb 2025 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0K9mLaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686612D758;
	Tue,  4 Feb 2025 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631810; cv=none; b=OtGGh254WuDRukNhjIyltyhdPGDwiua0YuWBOgBsDeVN/eHI2HbANvydoa4EyYaT030c8kqb0ztSh3KHvxVHAa4jKrJaj0s3dxWs5BzJG5duvF6eyw+V7963ICom1D2qwf5QXm/1mwu7piDlhDhEW8LgHVq7N1wEN5r1XDjzC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631810; c=relaxed/simple;
	bh=K/4z85s58YJ+HgdW8rRTJolzJXQ4p1WGU3yjVlV5G90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bru5rSIkmYC/XLFArGPSvUlsPb0+Hqn2mn8aVYxP2i5A5nKWkvWAynpPfBPCRuKw/VP0ixhfXje2MBSspwbacvRMW2uweNwDe9HPJwmQx5GVFOM6pD2UOtCpEGBZuji+pSfaLZTYqsX7mcFM55nHqpx2ZadGHCSbRUW/ub+M6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0K9mLaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC201C4CEE0;
	Tue,  4 Feb 2025 01:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631810;
	bh=K/4z85s58YJ+HgdW8rRTJolzJXQ4p1WGU3yjVlV5G90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0K9mLaHE7avdCS2MastLTjTmEZV6p5Mr6GvJuJ8PuVQ9xisdxi/iS7Lpblf0U+Xo
	 979r32tywfQv5/3BnSVXFo1XN33GdmDyGCAZIP84WhS9NxN69FKejoQc99VpCQkp+A
	 il/8/wJkaszGICX7C3zEi9kbCa8VG1vBv33lg3J87Rk0AldssxnWSUSzvb0bS8EVLZ
	 chxxzppkIkHb9kwUm96e0b/FtbTYnYwy0RhRvjQMI6MHMqxEpYXEyg+OTtjZv7HBRK
	 6zw4Iouo+pu+4JN6OCIaR5f38NBTDBF9TPpEGWEEEG+ypzTEQu6Mzc7tSXecBjg/Mj
	 7mZfAome9fh7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maksym Planeta <maksym@exostellar.io>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.12 2/4] Grab mm lock before grabbing pt lock
Date: Mon,  3 Feb 2025 20:16:40 -0500
Message-Id: <20250204011643.2206417-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011643.2206417-1-sashal@kernel.org>
References: <20250204011643.2206417-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.12
Content-Transfer-Encoding: 8bit

From: Maksym Planeta <maksym@exostellar.io>

[ Upstream commit 6d002348789bc16e9203e9818b7a3688787e3b29 ]

Function xen_pin_page calls xen_pte_lock, which in turn grab page
table lock (ptlock). When locking, xen_pte_lock expect mm->page_table_lock
to be held before grabbing ptlock, but this does not happen when pinning
is caused by xen_mm_pin_all.

This commit addresses lockdep warning below, which shows up when
suspending a Xen VM.

[ 3680.658422] Freezing user space processes
[ 3680.660156] Freezing user space processes completed (elapsed 0.001 seconds)
[ 3680.660182] OOM killer disabled.
[ 3680.660192] Freezing remaining freezable tasks
[ 3680.661485] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[ 3680.685254]
[ 3680.685265] ==================================
[ 3680.685269] WARNING: Nested lock was not taken
[ 3680.685274] 6.12.0+ #16 Tainted: G        W
[ 3680.685279] ----------------------------------
[ 3680.685283] migration/0/19 is trying to lock:
[ 3680.685288] ffff88800bac33c0 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: xen_pin_page+0x175/0x1d0
[ 3680.685303]
[ 3680.685303] but this task is not holding:
[ 3680.685308] init_mm.page_table_lock
[ 3680.685311]
[ 3680.685311] stack backtrace:
[ 3680.685316] CPU: 0 UID: 0 PID: 19 Comm: migration/0 Tainted: G        W          6.12.0+ #16
[ 3680.685324] Tainted: [W]=WARN
[ 3680.685328] Stopper: multi_cpu_stop+0x0/0x120 <- __stop_cpus.constprop.0+0x8c/0xd0
[ 3680.685339] Call Trace:
[ 3680.685344]  <TASK>
[ 3680.685347]  dump_stack_lvl+0x77/0xb0
[ 3680.685356]  __lock_acquire+0x917/0x2310
[ 3680.685364]  lock_acquire+0xce/0x2c0
[ 3680.685369]  ? xen_pin_page+0x175/0x1d0
[ 3680.685373]  _raw_spin_lock_nest_lock+0x2f/0x70
[ 3680.685381]  ? xen_pin_page+0x175/0x1d0
[ 3680.685386]  xen_pin_page+0x175/0x1d0
[ 3680.685390]  ? __pfx_xen_pin_page+0x10/0x10
[ 3680.685394]  __xen_pgd_walk+0x233/0x2c0
[ 3680.685401]  ? stop_one_cpu+0x91/0x100
[ 3680.685405]  __xen_pgd_pin+0x5d/0x250
[ 3680.685410]  xen_mm_pin_all+0x70/0xa0
[ 3680.685415]  xen_pv_pre_suspend+0xf/0x280
[ 3680.685420]  xen_suspend+0x57/0x1a0
[ 3680.685428]  multi_cpu_stop+0x6b/0x120
[ 3680.685432]  ? update_cpumasks_hier+0x7c/0xa60
[ 3680.685439]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 3680.685443]  cpu_stopper_thread+0x8c/0x140
[ 3680.685448]  ? smpboot_thread_fn+0x20/0x1f0
[ 3680.685454]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 3680.685458]  smpboot_thread_fn+0xed/0x1f0
[ 3680.685462]  kthread+0xde/0x110
[ 3680.685467]  ? __pfx_kthread+0x10/0x10
[ 3680.685471]  ret_from_fork+0x2f/0x50
[ 3680.685478]  ? __pfx_kthread+0x10/0x10
[ 3680.685482]  ret_from_fork_asm+0x1a/0x30
[ 3680.685489]  </TASK>
[ 3680.685491]
[ 3680.685491] other info that might help us debug this:
[ 3680.685497] 1 lock held by migration/0/19:
[ 3680.685500]  #0: ffffffff8284df38 (pgd_lock){+.+.}-{3:3}, at: xen_mm_pin_all+0x14/0xa0
[ 3680.685512]
[ 3680.685512] stack backtrace:
[ 3680.685518] CPU: 0 UID: 0 PID: 19 Comm: migration/0 Tainted: G        W          6.12.0+ #16
[ 3680.685528] Tainted: [W]=WARN
[ 3680.685531] Stopper: multi_cpu_stop+0x0/0x120 <- __stop_cpus.constprop.0+0x8c/0xd0
[ 3680.685538] Call Trace:
[ 3680.685541]  <TASK>
[ 3680.685544]  dump_stack_lvl+0x77/0xb0
[ 3680.685549]  __lock_acquire+0x93c/0x2310
[ 3680.685554]  lock_acquire+0xce/0x2c0
[ 3680.685558]  ? xen_pin_page+0x175/0x1d0
[ 3680.685562]  _raw_spin_lock_nest_lock+0x2f/0x70
[ 3680.685568]  ? xen_pin_page+0x175/0x1d0
[ 3680.685572]  xen_pin_page+0x175/0x1d0
[ 3680.685578]  ? __pfx_xen_pin_page+0x10/0x10
[ 3680.685582]  __xen_pgd_walk+0x233/0x2c0
[ 3680.685588]  ? stop_one_cpu+0x91/0x100
[ 3680.685592]  __xen_pgd_pin+0x5d/0x250
[ 3680.685596]  xen_mm_pin_all+0x70/0xa0
[ 3680.685600]  xen_pv_pre_suspend+0xf/0x280
[ 3680.685607]  xen_suspend+0x57/0x1a0
[ 3680.685611]  multi_cpu_stop+0x6b/0x120
[ 3680.685615]  ? update_cpumasks_hier+0x7c/0xa60
[ 3680.685620]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 3680.685625]  cpu_stopper_thread+0x8c/0x140
[ 3680.685629]  ? smpboot_thread_fn+0x20/0x1f0
[ 3680.685634]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 3680.685638]  smpboot_thread_fn+0xed/0x1f0
[ 3680.685642]  kthread+0xde/0x110
[ 3680.685645]  ? __pfx_kthread+0x10/0x10
[ 3680.685649]  ret_from_fork+0x2f/0x50
[ 3680.685654]  ? __pfx_kthread+0x10/0x10
[ 3680.685657]  ret_from_fork_asm+0x1a/0x30
[ 3680.685662]  </TASK>
[ 3680.685267] xen:grant_table: Grant tables using version 1 layout
[ 3680.685921] OOM killer enabled.
[ 3680.685934] Restarting tasks ... done.

Signed-off-by: Maksym Planeta <maksym@exostellar.io>
Reviewed-by: Juergen Gross <jgross@suse.com>
Message-ID: <20241204103516.3309112-1-maksym@exostellar.io>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/mmu_pv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04f..2c70cd35e72c5 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -781,6 +781,7 @@ void xen_mm_pin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -791,6 +792,7 @@ void xen_mm_pin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
@@ -887,6 +889,7 @@ void xen_mm_unpin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -898,6 +901,7 @@ void xen_mm_unpin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void xen_enter_mmap(struct mm_struct *mm)
-- 
2.39.5


