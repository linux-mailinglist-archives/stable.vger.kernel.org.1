Return-Path: <stable+bounces-109560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA21A16F29
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AC3A4892
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4F1E3784;
	Mon, 20 Jan 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gq49EMBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLmk9XdW"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85918FDC8
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386424; cv=none; b=fOYDi3FqWdYk4CXf+1IbLPyUHiKPwkCT3fqBsMxtIRIEx9D0j7lIgWPUuEwim4aePFiuRIZSUdz5BVP9mqN/aj6EucQrNgMPxA1Vo29Pmm0TGLq1eM9CmAPfgxiMoxMqO6YgBiAfZ8AgPzrI7fngz8mRVopQh5+e/AOdUwHZqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386424; c=relaxed/simple;
	bh=lvogoECED2ImFAqGnDukzxT72LNOSJBAm9/4wJvRWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHP6b+l/68WXvoh84y4nYRqtskOWIGwz5Ap+5JGB4Gp/Mj3GWEdktUOOOmQAAw9N+DQiG3cd6rFevohuFfIKMYaKy8CzV4vjQzsl2NyMv3Z/4GMyJ1HuQPU3gRWFPY3cP/ueW/gv8un0ByPyMnmquG5mBE0yd82VrQViNJabWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gq49EMBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLmk9XdW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 80A98114018E;
	Mon, 20 Jan 2025 10:20:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737386420;
	 x=1737472820; bh=skl+rGDGxm1k+Zt7Rjay6Gg6H0BQpFdY9tAYgdSAICQ=; b=
	gq49EMBs8U/8SA+ysmiNS4kAbTd+e8AxLVa+ibolh9TDkeXKqHu/JGHNpdlCvuSX
	eQ+Z1PgbnXavNiaJSNWjBdQE5IjzUjpOQnatsc2AA08Cjmn2luE6Gq3tKWeusEuC
	ktNeTjQT8G0yEtXI9G6uUpSdI5MNnAZpU8n8JwjR+o/cG2c8UU9lGCZW7rZL0JeG
	FH+bFU0PBdkvqU4AI/HGVEI5Wa+aocPmFYKjD/apJou9s6XuuEFXg5GFiVi31rHs
	OCJIzDHNn+5AeXh5ktxpz3Ujx2jRBh9t5JzwH5RGBUXYHF6+BwteQ2QdIM1X+TzC
	v7ceApgVFV4UXl6HeIG92Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737386420; x=
	1737472820; bh=skl+rGDGxm1k+Zt7Rjay6Gg6H0BQpFdY9tAYgdSAICQ=; b=o
	Lmk9XdWz0TD6GEB3zFqtXKS9i7MaYQgFV8AaO3XGrCixPXZ954sqwsa3lJE2a0dv
	E7iS+Nm3QXncJnf52fIswKTAvcjjahSSE7OyMVDTOEMFAaZ8JIoPWlnGAf5CnePz
	jnqz0TaIO0dORI2jyyNqeZ6/KhoLH0eu/1PTga/3Cx/PlKz0qZcr8tF8VgVeUyi2
	kUYi6ppjU+KvYTbwpuINkOT7vbh3Jz0/8K+Jm3V2UVchX8C4gpPIj6AL5mpqjbKt
	f14i0ImU/ew3ykfevIn4cgfnX3dteMFNTciBeu4wIMCkIVxSZHApfnL0UIW6hq3n
	yxzBUH02V7g5+sWovXKiA==
X-ME-Sender: <xms:tGmOZ9EfbUseDmiJ6YJR-KRr_KDY1e3B5UKjDuM8Zz2MIzIVTHwNtg>
    <xme:tGmOZyVurgKODo8yNP-IOQoQ_x6JKBMWnjgXoJ1rvt1GlDYbkhIiY3ZWkKmZZpwvq
    nRaevgQCfZftw>
X-ME-Received: <xmr:tGmOZ_J7tnIWNJvo5yr2Ln-pW96VZv5jjAtGjE3-6ZG7f-YrqJMXhaUdxUKJnb9eaxccHJkr_bo33MKM_IeexHq4Z30XAWlQPBw2mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeelheehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteei
    uedtkeekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhhvrghlrghnleesfhhogihmrghilhdrtghomh
    dprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehvihhtrghlhidrphhrohhshigrkhesrghmugdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopegrlhgvgigr
    nhguvghrrdguvghutghhvghrsegrmhgurdgtohhm
X-ME-Proxy: <xmx:tGmOZzGeCS8kEZnnXBGCSXysG_QCoM95sCtFGKcFIiXNre4dJCpKsg>
    <xmx:tGmOZzUlqDqzgZhrux3u8GwNrBP9EkbhZhqx5iRduqFHZvNiseH_lQ>
    <xmx:tGmOZ-MRyM4UwD6rDqtTUM3d2B5Q5cS0Dqtp1reBOH1vnEw1XT4amQ>
    <xmx:tGmOZy0hI5V9-ksdjwwIf-cP4VBIUO8p6jfG6OHgH5-VAWkBJESKbA>
    <xmx:tGmOZ8NuZoGTXH1B9VDHms8Me7uZBtVfWDXkbS1olxoZsV35Y2Lngu-o>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 10:20:19 -0500 (EST)
Date: Mon, 20 Jan 2025 16:20:18 +0100
From: Greg KH <greg@kroah.com>
To: alvalan9@foxmail.com
Cc: stable@vger.kernel.org, Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu: fix usage slab after free
Message-ID: <2025012055-voting-aground-c939@gregkh>
References: <tencent_3C6A983FEE24F5AC197086612E1A8E692309@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3C6A983FEE24F5AC197086612E1A8E692309@qq.com>

On Fri, Jan 17, 2025 at 05:15:58PM +0800, alvalan9@foxmail.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> commit b61badd20b443eabe132314669bb51a263982e5c upstream.
> 
> [  +0.000021] BUG: KASAN: slab-use-after-free in drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
> [  +0.000027] Read of size 8 at addr ffff8881b8605f88 by task amd_pci_unplug/2147
> 
> [  +0.000023] CPU: 6 PID: 2147 Comm: amd_pci_unplug Not tainted 6.10.0+ #1
> [  +0.000016] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
> [  +0.000016] Call Trace:
> [  +0.000008]  <TASK>
> [  +0.000009]  dump_stack_lvl+0x76/0xa0
> [  +0.000017]  print_report+0xce/0x5f0
> [  +0.000017]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
> [  +0.000019]  ? srso_return_thunk+0x5/0x5f
> [  +0.000015]  ? kasan_complete_mode_report_info+0x72/0x200
> [  +0.000016]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
> [  +0.000019]  kasan_report+0xbe/0x110
> [  +0.000015]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
> [  +0.000023]  __asan_report_load8_noabort+0x14/0x30
> [  +0.000014]  drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
> [  +0.000020]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? __kasan_check_write+0x14/0x30
> [  +0.000016]  ? __pfx_drm_sched_entity_flush+0x10/0x10 [gpu_sched]
> [  +0.000020]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? __kasan_check_write+0x14/0x30
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? enable_work+0x124/0x220
> [  +0.000015]  ? __pfx_enable_work+0x10/0x10
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? free_large_kmalloc+0x85/0xf0
> [  +0.000016]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
> [  +0.000020]  amdgpu_vce_sw_fini+0x55/0x170 [amdgpu]
> [  +0.000735]  ? __kasan_check_read+0x11/0x20
> [  +0.000016]  vce_v4_0_sw_fini+0x80/0x110 [amdgpu]
> [  +0.000726]  amdgpu_device_fini_sw+0x331/0xfc0 [amdgpu]
> [  +0.000679]  ? mutex_unlock+0x80/0xe0
> [  +0.000017]  ? __pfx_amdgpu_device_fini_sw+0x10/0x10 [amdgpu]
> [  +0.000662]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? __kasan_check_write+0x14/0x30
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? mutex_unlock+0x80/0xe0
> [  +0.000016]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
> [  +0.000663]  drm_minor_release+0xc9/0x140 [drm]
> [  +0.000081]  drm_release+0x1fd/0x390 [drm]
> [  +0.000082]  __fput+0x36c/0xad0
> [  +0.000018]  __fput_sync+0x3c/0x50
> [  +0.000014]  __x64_sys_close+0x7d/0xe0
> [  +0.000014]  x64_sys_call+0x1bc6/0x2680
> [  +0.000014]  do_syscall_64+0x70/0x130
> [  +0.000014]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? irqentry_exit_to_user_mode+0x60/0x190
> [  +0.000015]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? irqentry_exit+0x43/0x50
> [  +0.000012]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? exc_page_fault+0x7c/0x110
> [  +0.000015]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000014] RIP: 0033:0x7ffff7b14f67
> [  +0.000013] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
> [  +0.000026] RSP: 002b:00007fffffffe378 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [  +0.000019] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
> [  +0.000014] RDX: 0000000000000000 RSI: 00007ffff7f6f47a RDI: 0000000000000003
> [  +0.000014] RBP: 00007fffffffe3a0 R08: 0000555555569890 R09: 0000000000000000
> [  +0.000014] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
> [  +0.000013] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
> [  +0.000020]  </TASK>
> 
> [  +0.000016] Allocated by task 383 on cpu 7 at 26.880319s:
> [  +0.000014]  kasan_save_stack+0x28/0x60
> [  +0.000008]  kasan_save_track+0x18/0x70
> [  +0.000007]  kasan_save_alloc_info+0x38/0x60
> [  +0.000007]  __kasan_kmalloc+0xc1/0xd0
> [  +0.000007]  kmalloc_trace_noprof+0x180/0x380
> [  +0.000007]  drm_sched_init+0x411/0xec0 [gpu_sched]
> [  +0.000012]  amdgpu_device_init+0x695f/0xa610 [amdgpu]
> [  +0.000658]  amdgpu_driver_load_kms+0x1a/0x120 [amdgpu]
> [  +0.000662]  amdgpu_pci_probe+0x361/0xf30 [amdgpu]
> [  +0.000651]  local_pci_probe+0xe7/0x1b0
> [  +0.000009]  pci_device_probe+0x248/0x890
> [  +0.000008]  really_probe+0x1fd/0x950
> [  +0.000008]  __driver_probe_device+0x307/0x410
> [  +0.000007]  driver_probe_device+0x4e/0x150
> [  +0.000007]  __driver_attach+0x223/0x510
> [  +0.000006]  bus_for_each_dev+0x102/0x1a0
> [  +0.000007]  driver_attach+0x3d/0x60
> [  +0.000006]  bus_add_driver+0x2ac/0x5f0
> [  +0.000006]  driver_register+0x13d/0x490
> [  +0.000008]  __pci_register_driver+0x1ee/0x2b0
> [  +0.000007]  llc_sap_close+0xb0/0x160 [llc]
> [  +0.000009]  do_one_initcall+0x9c/0x3e0
> [  +0.000008]  do_init_module+0x241/0x760
> [  +0.000008]  load_module+0x51ac/0x6c30
> [  +0.000006]  __do_sys_init_module+0x234/0x270
> [  +0.000007]  __x64_sys_init_module+0x73/0xc0
> [  +0.000006]  x64_sys_call+0xe3/0x2680
> [  +0.000006]  do_syscall_64+0x70/0x130
> [  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  +0.000015] Freed by task 2147 on cpu 6 at 160.507651s:
> [  +0.000013]  kasan_save_stack+0x28/0x60
> [  +0.000007]  kasan_save_track+0x18/0x70
> [  +0.000007]  kasan_save_free_info+0x3b/0x60
> [  +0.000007]  poison_slab_object+0x115/0x1c0
> [  +0.000007]  __kasan_slab_free+0x34/0x60
> [  +0.000007]  kfree+0xfa/0x2f0
> [  +0.000007]  drm_sched_fini+0x19d/0x410 [gpu_sched]
> [  +0.000012]  amdgpu_fence_driver_sw_fini+0xc4/0x2f0 [amdgpu]
> [  +0.000662]  amdgpu_device_fini_sw+0x77/0xfc0 [amdgpu]
> [  +0.000653]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
> [  +0.000655]  drm_minor_release+0xc9/0x140 [drm]
> [  +0.000071]  drm_release+0x1fd/0x390 [drm]
> [  +0.000071]  __fput+0x36c/0xad0
> [  +0.000008]  __fput_sync+0x3c/0x50
> [  +0.000007]  __x64_sys_close+0x7d/0xe0
> [  +0.000007]  x64_sys_call+0x1bc6/0x2680
> [  +0.000007]  do_syscall_64+0x70/0x130
> [  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  +0.000014] The buggy address belongs to the object at ffff8881b8605f80
>                which belongs to the cache kmalloc-64 of size 64
> [  +0.000020] The buggy address is located 8 bytes inside of
>                freed 64-byte region [ffff8881b8605f80, ffff8881b8605fc0)
> 
> [  +0.000028] The buggy address belongs to the physical page:
> [  +0.000011] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b8605
> [  +0.000008] anon flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [  +0.000007] page_type: 0xffffefff(slab)
> [  +0.000009] raw: 0017ffffc0000000 ffff8881000428c0 0000000000000000 dead000000000001
> [  +0.000006] raw: 0000000000000000 0000000000200020 00000001ffffefff 0000000000000000
> [  +0.000006] page dumped because: kasan: bad access detected
> 
> [  +0.000012] Memory state around the buggy address:
> [  +0.000011]  ffff8881b8605e80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  +0.000015]  ffff8881b8605f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> [  +0.000015] >ffff8881b8605f80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  +0.000013]                       ^
> [  +0.000011]  ffff8881b8606000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
> [  +0.000014]  ffff8881b8606080: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
> [  +0.000013] ==================================================================
> 
> The issue reproduced on VG20 during the IGT pci_unplug test.
> The root cause of the issue is that the function drm_sched_fini is called before drm_sched_entity_kill.
> In drm_sched_fini, the drm_sched_rq structure is freed, but this structure is later accessed by
> each entity within the run queue, leading to invalid memory access.
> To resolve this, the order of cleanup calls is updated:
> 
>     Before:
>         amdgpu_fence_driver_sw_fini
>         amdgpu_device_ip_fini
> 
>     After:
>         amdgpu_device_ip_fini
>         amdgpu_fence_driver_sw_fini
> 
> This updated order ensures that all entities in the IPs are cleaned up first, followed by proper
> cleanup of the schedulers.
> 
> Additional Investigation:
> 
> During debugging, another issue was identified in the amdgpu_vce_sw_fini function. The vce.vcpu_bo
> buffer must be freed only as the final step in the cleanup process to prevent any premature
> access during earlier cleanup stages.
> 
> v2: Using Christian suggestion call drm_sched_entity_destroy before drm_sched_fini.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0b2a27806bec..bd98d08b66c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4131,8 +4131,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	int idx;
>  	bool px;
>  
> -	amdgpu_fence_driver_sw_fini(adev);
>  	amdgpu_device_ip_fini(adev);
> +	amdgpu_fence_driver_sw_fini(adev);
>  	release_firmware(adev->firmware.gpu_info_fw);
>  	adev->firmware.gpu_info_fw = NULL;
>  	adev->accel_working = false;
> @@ -6129,7 +6129,7 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
>  {
>  	return atomic_read(&adev->reset_domain->in_gpu_reset);
>  	}
> -	
> +
>  /**
>   * amdgpu_device_halt() - bring hardware to some kind of halt state
>   *

Why the extra whitespace change that is not part of the original commit?

Please be more careful.

greg k-h

