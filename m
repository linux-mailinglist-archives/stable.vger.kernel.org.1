Return-Path: <stable+bounces-62826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FDC94144E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925ECB26119
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E45335D3;
	Tue, 30 Jul 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Inq/kNh+"
X-Original-To: stable@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E300D529;
	Tue, 30 Jul 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349601; cv=none; b=DoNZ2QCcKh9ok7VmLy5yPX33e47Lxz3o9GVNdSJ71SCa14C5eTDCNIgZ8pbrhcuUl7uR03WDegKSW9THBJSkGxy1GVCoXgNinBqPmA2LYz2OCjVGfY/Ush0ZqnGtVvSnbFMT02eJbQZ1PtBOgqfLPJhua+zBZ8FmULtQNGmw6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349601; c=relaxed/simple;
	bh=Y/BTsUGgKf7Mhqj9uRQJvsNaHTykMcJX4jhdObr4Jqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eD7+ZrOJEjnZTCZ34M7BzCbnUxGlFuCp/mLZDj2FRjzRJCr1SN1V2gCEpCu1M6sxgX3LToCdiiMyJLeMQsWCl9UrL4PyBU2bVlvUDbUEdsIp+8Y5xLNo6bFQx8qsBre4hpP0UvtP/nQdsqZ2KTFSDZ1qdro67XAwnPeXA3ftc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Inq/kNh+; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+r1GO
	9lXpfV8NuodAhuijwCksvgX5ChGFsu9hFSC2ao=; b=Inq/kNh+gvNjevg3x9EMA
	asfE24h/oSPcIjJG5ayH0+9j8czKKvaTZ7gvoxohVULdPME87rjGDf/6WPmSmELi
	fkRkrk1XIkXxPcBr1fqFDdLD9xFE80OS5xisVSXCb4Rea/rEKu4XMRZYf5m+O10H
	q+3eh0GdktEULtg0nEVXPw=
Received: from localhost.localdomain (unknown [111.35.189.52])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDnN_j196hmrfcYFA--.59262S4;
	Tue, 30 Jul 2024 22:26:05 +0800 (CST)
From: David Wang <00107082@163.com>
To: liaoyu15@huawei.com
Cc: linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	stable@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: [Regression] 6.11.0-rc1: BUG: using smp_processor_id() in preemptible when suspend the system
Date: Tue, 30 Jul 2024 22:25:57 +0800
Message-Id: <20240730142557.4619-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN_j196hmrfcYFA--.59262S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1fZF4DKF4DCF4UGFy7Awb_yoW5WrW3pF
	n5tF1UCF4kJ34jy3WxJ3yjkryUCasrAF15WF97GrySgayUC3W8Xrs3Zr17Wrn5K340gw47
	ZrWqyw4qvw4UtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrGYLUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQ4sqmVOB3V2uAAAs2

Hi,

When I suspend my system, via `systemctl suspend`, kernel BUG shows up in log:

 kernel: [ 1734.412974] smpboot: CPU 2 is now offline
 kernel: [ 1734.414952] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/4619
 kernel: [ 1734.414957] caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0
 kernel: [ 1734.414964] CPU: 0 UID: 0 PID: 4619 Comm: systemd-sleep Tainted: P           OE      6.11.0-rc1-linan-4 #292
 kernel: [ 1734.414968] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 kernel: [ 1734.414969] Hardware name: Micro-Star International Co., Ltd. MS-7B89/B450M MORTAR MAX (MS-7B89), BIOS 2.80 06/10/2020
 kernel: [ 1734.414970] Call Trace:
 kernel: [ 1734.414974]  <TASK>
 kernel: [ 1734.414978]  dump_stack_lvl+0x60/0x80
 kernel: [ 1734.414982]  check_preemption_disabled+0xce/0xe0
 kernel: [ 1734.414987]  hotplug_cpu__broadcast_tick_pull+0x1c/0xc0
 kernel: [ 1734.414992]  ? __pfx_takedown_cpu+0x10/0x10
 kernel: [ 1734.414996]  takedown_cpu+0x97/0x130
 kernel: [ 1734.414999]  cpuhp_invoke_callback+0xf8/0x450
 kernel: [ 1734.415004]  __cpuhp_invoke_callback_range+0x78/0xe0
 kernel: [ 1734.415008]  _cpu_down+0xf4/0x360
 kernel: [ 1734.415012]  freeze_secondary_cpus+0xae/0x290
 kernel: [ 1734.415016]  suspend_devices_and_enter+0x1da/0x920
 kernel: [ 1734.415022]  pm_suspend+0x1fa/0x500
 kernel: [ 1734.415025]  state_store+0x68/0xd0
 kernel: [ 1734.415028]  kernfs_fop_write_iter+0x169/0x1f0
 kernel: [ 1734.415034]  vfs_write+0x269/0x440
 kernel: [ 1734.415041]  ksys_write+0x63/0xe0
 kernel: [ 1734.415044]  do_syscall_64+0x4b/0x110
 kernel: [ 1734.415048]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 kernel: [ 1734.415052] RIP: 0033:0x7fe885cee240
 kernel: [ 1734.415055] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
 kernel: [ 1734.415057] RSP: 002b:00007ffc53ccec58 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 kernel: [ 1734.415060] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe885cee240
 kernel: [ 1734.415062] RDX: 0000000000000004 RSI: 00007ffc53cced40 RDI: 0000000000000004
 kernel: [ 1734.415063] RBP: 00007ffc53cced40 R08: 0000000000000007 R09: 000055f34dde8210
 kernel: [ 1734.415064] R10: 6bccc22257390b18 R11: 0000000000000202 R12: 0000000000000004
 kernel: [ 1734.415066] R13: 000055f34dde42d0 R14: 0000000000000004 R15: 00007fe885dc49e0
 kernel: [ 1734.415071]  </TASK>


I confirmed that this was introduced by commit:
 f7d43dd206e7e18c182f200e67a8db8c209907fa tick/broadcast: Make takeover of broadcast hrtimer reliable
, and revert this commit can fix it.


Thanks
David


