Return-Path: <stable+bounces-182853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA895BAE31A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8480F3AC416
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840D1F5434;
	Tue, 30 Sep 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b="NA5kwX0m";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EkGY2UdE"
X-Original-To: stable@vger.kernel.org
Received: from a8-83.smtp-out.amazonses.com (a8-83.smtp-out.amazonses.com [54.240.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A418BBAE
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253502; cv=none; b=spZ32NKuIBrBuSB7osy15T4oz9n/I2JC7LtCEpQBfl+TTdPgK+2HFxI95b+ZoMvQV/FbpeFWk8J3q3Jex/TcuCUPoKgI9pMdn39TzzswrEGSSaYtaoYfYcGDRJ2LM+Dh1nSu2YCiGepx9uIkQj6reu+rxgqycmW+OwnxfEFP5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253502; c=relaxed/simple;
	bh=mrJ/ZQYqKE4cT6lTBvckUQj1x2hcVTevKOZJdKtO/YA=;
	h=From:Content-Type:Mime-Version:Subject:Message-ID:Date:Cc:To; b=SlJcL4/YeKbCAWY4b0AW3fpqrmhQg/8VoRK0Pu1dIlyGMIukNH1SqRclJMIbLT6Jd0TDADKe/y4gesDF9wKEAxU2tP652Ila2cEoc1rMMVYGL23sPsgwxiIOY+jFIy8LMVhWfr+jRlOWtT1bA8Qp3D7O4VFBdGd0A4Io44pyWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvanals.org; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b=NA5kwX0m; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EkGY2UdE; arc=none smtp.client-ip=54.240.8.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvanals.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=xojwidlurxakxokupknu2uvuxvz4uggf; d=kvanals.org; t=1759253498;
	h=From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:Cc:To;
	bh=mrJ/ZQYqKE4cT6lTBvckUQj1x2hcVTevKOZJdKtO/YA=;
	b=NA5kwX0muIsKzjQ6KptfNhWaAegj5sDHVEAGqr05/VoStItaGc6E83955RY/5nOG
	15xJa3L+q1tEVT5Y0v5bcidxN6kDV41GL4AronaCx6vNs8Odpy0vSQA4io/0wQsClOq
	z2L+dMybKE5kiNucAY2SdRA0LiaOCxcpRTcHxsZLBzNsXfEBpAQF//uWAKt11ok3BIc
	LPSOvtVGxRVSjFBqb4Ae1VAuyeb+c8B34byvHg5XhBE9/xmdMj0b7Wh4ihd9yl+6y3K
	EpvPsZYzPduYEyqGbhHXBdeTnbp2cHpl7SU32bQKSJMgCvdtWMgHFZsQb5JQbGGg8yS
	0ZZDoq4vQg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1759253498;
	h=From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:Cc:To:Feedback-ID;
	bh=mrJ/ZQYqKE4cT6lTBvckUQj1x2hcVTevKOZJdKtO/YA=;
	b=EkGY2UdEtWoWsUGdpBsa4EhUKScgiiyLSRPUNRfurJNblm319wA1CgXL6p0te2Hf
	cNIyWaNGnKz8iB2XrbVPBB7uoexyYK2tQ9Vi+hLM+XYzsLIJRSjlRkgimQOSnAt9VFC
	2sBoNltszsrV5PZfWM34dJg0h5kGw2rsDcpXRc+g=
From: Kenneth Van Alstyne <kvanals@kvanals.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: KVM: arm64: Regression in at least linux-6.1.y tree with recent
 FPSIMD/SVE/SME fix 
Message-ID: <010001999bae0958-4d80d25d-8dda-4006-a6b9-798f3e774f6c-000000@email.amazonses.com>
Date: Tue, 30 Sep 2025 17:31:38 +0000
Cc: regressions@lists.linux.dev, will@kernel.org, catalin.marinas@arm.com
To: stable@vger.kernel.org
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (olympus.kvanals.org [IPv6:2600:1f18:42d5:300:0:0:0:ffff]); Tue, 30 Sep 2025 17:31:38 +0000 (UTC)
Feedback-ID: ::1.us-east-1.5jHMwTu/Jzmoolk7Ak3w+RKcSxXCCShHRX8XGxXgrSs=:AmazonSES
X-SES-Outgoing: 2025.09.30-54.240.8.83

Greetings:

Sending via plain text email -- apologies if you receive this twice.

If this isn't the process for reporting a regression in a LTS kernel per =
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html, =
I'm happy to follow another process.

Kernel 6.1.149 introduced a regression, at least on our ARM Cortex =
A57-based platforms, via commit 8f4dc4e54eed4bebb18390305eb1f721c00457e1 =
in arch/arm64/kernel/fpsimd.c where booting KVM VMs eventually leads to =
a spinlock recursion BUG and crash of the box.

Reverting that commit via the below reverts to the old (working) =
behavior:

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 837d1937300a57..bc42163a7fd1f0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1851,10 +1851,10 @@ void fpsimd_save_and_flush_cpu_state(void)
  if (!system_supports_fpsimd())
  return;
  WARN_ON(preemptible());
- get_cpu_fpsimd_context();
+ __get_cpu_fpsimd_context();
  fpsimd_save();
  fpsimd_flush_cpu_state();
- put_cpu_fpsimd_context();
+ __put_cpu_fpsimd_context();
 }
  #ifdef CONFIG_KERNEL_MODE_NEON

It's not entirely clear to me if this is specific to our firmware, =
specific to ARM Cortex A57, or more systemic as we lack sufficiently =
differentiated hardware to know.  I've tested on the latest 6.1 kernel =
in addition to the one in the log below and have also tested a number of =
firmware versions available for these boxes.

Steps to reproduce:

Boot VM in qemu-system-aarch64 with "-accel kvm" and "-cpu host" flags =
set -- no other arguments seem to matter
Generate CPU load in VM

Kernel log:

[sjc1] root@si-compute-kvm-e0fff70016b4:/# [  805.905413] BUG: spinlock =
recursion on CPU#7, CPU 3/KVM/57616
[  805.905452]  lock: 0xffff3045ef850240, .magic: dead4ead, .owner: CPU =
3/KVM/57616, .owner_cpu: 7
[  805.905477] CPU: 7 PID: 57616 Comm: CPU 3/KVM Tainted: G           O  =
     6.1.152 #1
[  805.905495] Hardware name: SoftIron SoftIron Platform =
Mainboard/SoftIron Platform Mainboard, BIOS 1.31 May 11 2023
[  805.905516] Call trace:
[  805.905524]  dump_backtrace+0xe4/0x110
[  805.905538]  show_stack+0x20/0x30
[  805.905548]  dump_stack_lvl+0x6c/0x88
[  805.905561]  dump_stack+0x18/0x34
[  805.905571]  spin_dump+0x98/0xac
[  805.905583]  do_raw_spin_lock+0x70/0x128
[  805.905596]  _raw_spin_lock+0x18/0x28
[  805.905607]  raw_spin_rq_lock_nested+0x18/0x28
[  805.905620]  update_blocked_averages+0x70/0x550
[  805.905634]  run_rebalance_domains+0x50/0x70
[  805.905645]  handle_softirqs+0x198/0x328
[  805.905659]  __do_softirq+0x1c/0x28
[  805.905669]  ____do_softirq+0x18/0x28
[  805.905680]  call_on_irq_stack+0x30/0x48
[  805.905691]  do_softirq_own_stack+0x24/0x30
[  805.905703]  do_softirq+0x74/0x90
[  805.905714]  __local_bh_enable_ip+0x64/0x80
[  805.905727]  fpsimd_save_and_flush_cpu_state+0x5c/0x68
[  805.905740]  kvm_arch_vcpu_put_fp+0x4c/0x88
[  805.905752]  kvm_arch_vcpu_put+0x28/0x88
[  805.905764]  kvm_sched_out+0x38/0x58
[  805.905774]  __schedule+0x55c/0x6c8
[  805.905786]  schedule+0x60/0xa8
[  805.905796]  kvm_vcpu_block+0x5c/0x90
[  805.905807]  kvm_vcpu_halt+0x440/0x468
[  805.905818]  kvm_vcpu_wfi+0x3c/0x70
[  805.905828]  kvm_handle_wfx+0x18c/0x1f0
[  805.905840]  handle_exit+0xb8/0x148
[  805.905851]  kvm_arch_vcpu_ioctl_run+0x6c4/0x7b0
[  805.905863]  kvm_vcpu_ioctl+0x1d0/0x8b8
[  805.905874]  __arm64_sys_ioctl+0x9c/0xe0
[  805.905886]  invoke_syscall+0x78/0x108
[  805.905899]  el0_svc_common.constprop.3+0xb4/0xf8
[  805.905912]  do_el0_svc+0x78/0x88
[  805.905922]  el0_svc+0x48/0x78
[  805.905932]  el0t_64_sync_handler+0x40/0xc0
[  805.905943]  el0t_64_sync+0x18c/0x190
[  806.048300] hrtimer: interrupt took 2976 ns
[  826.924613] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
SoC 0 became not ready
SoC 0 became ready

Thanks,

--
Kenneth Van Alstyne, Jr.


