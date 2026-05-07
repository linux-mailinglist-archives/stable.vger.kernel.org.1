Return-Path: <stable+bounces-244640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOAjJJP//GmxVwAAu9opvQ
	(envelope-from <stable+bounces-244640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:09:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C294EF207
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA91300C0FC
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AAE330D50;
	Thu,  7 May 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="FR90nUBP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCnmOBa2"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B02C0F81;
	Thu,  7 May 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188173; cv=none; b=FVZsFq5r8Int3F1HcHomt9i+gVLumby3WEgFDAVVJ5Kk/c3L4aUiTtyMrV9w3vwoFbwE/muzYCKJQbNhqlzYodYOHsX9rGe6yGmVRMVCJMALlfwl1uX7+jofcx/MBNRNa+7ZC4eo4YRvQszO7dQ8x/qQ4fk+iddNx7BTua0sLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188173; c=relaxed/simple;
	bh=Md0iZenqALnfrYUoZIoxKeiMqdfNuTrVs/uy9p+FnO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfdL+NF+wFtGHdZKyyxS+UshhUFbR8L99ZJnFnF0emWS28IUOeQrPkPzQfAaspkt6Gk5pNsy0d4TJX/mMB9gmuc+gkA6Cv4CkojlARhT2XFcJPN40bx80p/OORh5qziOxVpUBsWCoMPN5tAHqWPtYv3XRc0HeKvt2xj9QYZ0oZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=FR90nUBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCnmOBa2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B820E140014B;
	Thu,  7 May 2026 17:09:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 17:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778188168;
	 x=1778274568; bh=QF+qFyFGOyNEQ6REEJHK4AG1uL4TjH3keTHPubIon2M=; b=
	FR90nUBP7nupQEghoqlJh8AK2xfProbtuUaQ3OoCncZsT2NlNNret74gJ9W5CRsR
	K+WsyUUW7dyQuc4l/cf0EN0rJ6viB/4ehV7hRYcp3cA2mWHvcCUCFVXllJ14u4E3
	coBVDOjI5eWlG1HZ27cNj624RuCWgJuRh/WydtGMm8I7QYeWUTj/8hlrfYzeByQc
	iDFZTpjoqgTDs0Xkyh3/BM820WUg2yUNa77FiO+VT525z/g49fIqFZXxPoSmCfA8
	F8zW4zlsXfNz8AqxoxN5vVc6MFwC7SqqcFFGUxusDA3r1gJMAN98L09Xcm0hS5Ec
	qPGtxQBg+hSY2VSl18aYZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778188168; x=
	1778274568; bh=QF+qFyFGOyNEQ6REEJHK4AG1uL4TjH3keTHPubIon2M=; b=V
	CnmOBa24D0ozL6kiKssoLBvWRww8ey2cQ6pesydlIwlZuhGQNWcfN3L58c4vjmne
	r1ld9kzodstdjJI2n487iVs6sSMaQd2LTIFXNVUvj+0Og8WhAjD7RSBsoZqbE5q+
	paBI+nrayD2U0wiay1/YNvakzanUapZoWm1S3AT+F/s7sIrZBDFwiwAZwL4x+a2y
	tSX8SlAp13NLttejpbZvJ94UJRqJ7hQTUniipFgtM9t8KWnwauTfktOZfP/L1Gmj
	Z1AfIvmoma/qCWqHOEC6YsdNMFDCfwKGEpL074ZvAioux+y5xNXVsQVtgfb+6aQN
	o9tKKPlR5/WeLnAFnZ6mw==
X-ME-Sender: <xms:iP_8aXQa_5BVDX58qyckZ_4Fp5RmyfR1PnU1CCHrbnvaUpp2CrzTlg>
    <xme:iP_8aZMx9PqKNY4pt2OczRwgXlQNlrxxmlmuysXeAd-70Krbk9imUBRpjBTT44hJB
    w-kmwWrPxE7QLb-389KbBJ4QvFj5W4xrSC9wBru5EMepBJOwsT-TA>
X-ME-Received: <xmr:iP_8adgpDjWCbjj2MidT8L71yOchJ1TXRF-F5XkEmLhEVKoSfUPsysQ0QuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepughmrghtlhgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehvihhpihhnshhhsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehjrhhhihhlkhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehk
    vhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrd
    horhhg
X-ME-Proxy: <xmx:iP_8aenHi6vYA_DwaYph_YXZGEYlx2Lv1SUnY93CUh2gQSVVLl53Ew>
    <xmx:iP_8aRitkWyaJvg3e0jKLmC-Pxogl-wDbLbj0psp61nTvP4VBFN6jw>
    <xmx:iP_8aZFEH65NgNeyS_ZCbWtAty2em_si3OlzQQ7u0elJLfGWxKPMJg>
    <xmx:iP_8abtPtIozEJqtFqX4EVT-6OsgATfiI3rH6Tq8v-e33vABsc6j9A>
    <xmx:iP_8acOYuI1_oqBqzWo3D2t7_Hpkm4GV4WWZ_1iUZY3_lFowlWhAhV0D>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 17:09:27 -0400 (EDT)
Date: Thu, 7 May 2026 15:09:25 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
 Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Use a private flag to prevent power state
 change with VFs
Message-ID: <20260507150925.11e9681e@shazbot.org>
In-Reply-To: <20260504224142.1041477-1-rananta@google.com>
References: <20260504224142.1041477-1-rananta@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8C294EF207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244640-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon,  4 May 2026 22:41:42 +0000
Raghavendra Rao Ananta <rananta@google.com> wrote:

> The current implementation uses pci_num_vf() while holding the
> memory_lock to prevent changing the power state of a PF when
> VFs are enabled. This creates a lockdep circular dependency
> warning in because memory_lock is held during device probing.

s/in// ?
 
> [  286.997167] ======================================================
> [  287.003363] WARNING: possible circular locking dependency detected
> [  287.009562] 7.0.0-dbg-DEV #3 Tainted: G S
> [  287.015074] ------------------------------------------------------
> [  287.021270] vfio_pci_sriov_/18636 is trying to acquire lock:
> [  287.026942] ff45bea2294d4968 (&vdev->memory_lock){+.+.}-{4:4}, at:
> vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.036530]
> [  287.036530] but task is already holding lock:
> [  287.042383] ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4}, at:
> vfio_group_fops_unl_ioctl+0x44d/0x7b0
> [  287.051879]
> [  287.051879] which lock already depends on the new lock.
> [  287.051879]
> [  287.060070]
> [  287.060070] the existing dependency chain (in reverse order) is:
> [  287.067568]
> [  287.067568] -> #2 (&new_dev_set->lock){+.+.}-{4:4}:
> [  287.073941]        __mutex_lock+0x92/0xb80
> [  287.078058]        vfio_assign_device_set+0x66/0x1b0
> [  287.083042]        vfio_pci_core_register_device+0xd1/0x2a0
> [  287.088638]        vfio_pci_probe+0xd2/0x100
> [  287.092933]        local_pci_probe_callback+0x4d/0xa0
> [  287.098001]        process_scheduled_works+0x2ca/0x680
> [  287.103158]        worker_thread+0x1e8/0x2f0
> [  287.107452]        kthread+0x10c/0x140
> [  287.111230]        ret_from_fork+0x18e/0x360
> [  287.115519]        ret_from_fork_asm+0x1a/0x30
> [  287.119983]
> [  287.119983] -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
> [  287.127219]        __flush_work+0x345/0x490
> [  287.131429]        pci_device_probe+0x2e3/0x490
> [  287.135979]        really_probe+0x1f9/0x4e0
> [  287.140180]        __driver_probe_device+0x77/0x100
> [  287.145079]        driver_probe_device+0x1e/0x110
> [  287.149803]        __device_attach_driver+0xe3/0x170
> [  287.154789]        bus_for_each_drv+0x125/0x150
> [  287.159346]        __device_attach+0xca/0x1a0
> [  287.163720]        device_initial_probe+0x34/0x50
> [  287.168445]        pci_bus_add_device+0x6e/0x90
> [  287.172995]        pci_iov_add_virtfn+0x3c9/0x3e0
> [  287.177719]        sriov_add_vfs+0x2c/0x60
> [  287.181838]        sriov_enable+0x306/0x4a0
> [  287.186038]        vfio_pci_core_sriov_configure+0x184/0x220
> [  287.191715]        sriov_numvfs_store+0xd9/0x1c0
> [  287.196351]        kernfs_fop_write_iter+0x13f/0x1d0
> [  287.201338]        vfs_write+0x2be/0x3b0
> [  287.205286]        ksys_write+0x73/0x100
> [  287.209233]        do_syscall_64+0x14d/0x750
> [  287.213529]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  287.219120]
> [  287.219120] -> #0 (&vdev->memory_lock){+.+.}-{4:4}:
> [  287.225491]        __lock_acquire+0x14c6/0x2800
> [  287.230048]        lock_acquire+0xd3/0x2f0
> [  287.234168]        down_write+0x3a/0xc0
> [  287.238019]        vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.243436]        __rpm_callback+0x8c/0x310
> [  287.247730]        rpm_resume+0x529/0x6f0
> [  287.251765]        __pm_runtime_resume+0x68/0x90
> [  287.256402]        vfio_pci_core_enable+0x44/0x310
> [  287.261216]        vfio_pci_open_device+0x1c/0x80
> [  287.265947]        vfio_df_open+0x10f/0x150
> [  287.270148]        vfio_group_fops_unl_ioctl+0x4a4/0x7b0
> [  287.275476]        __se_sys_ioctl+0x71/0xc0
> [  287.279679]        do_syscall_64+0x14d/0x750
> [  287.283975]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  287.289559]
> [  287.289559] other info that might help us debug this:
> [  287.289559]
> [  287.297582] Chain exists of:
> [  287.297582]   &vdev->memory_lock --> (work_completion)(&arg.work)
> --> &new_dev_set->lock  
> [  287.297582]
> [  287.310023]  Possible unsafe locking scenario:
> [  287.310023]
> [  287.315961]        CPU0                    CPU1
> [  287.320510]        ----                    ----
> [  287.325059]   lock(&new_dev_set->lock);
> [  287.328917]
> lock((work_completion)(&arg.work));
> [  287.336153]                                lock(&new_dev_set->lock);
> [  287.342523]   lock(&vdev->memory_lock);
> [  287.346382]
> [  287.346382]  *** DEADLOCK ***
> [  287.346382]
> [  287.352315] 2 locks held by vfio_pci_sriov_/18636:
> [  287.357125]  #0: ff45bea208ed3e18 (&group->group_lock){+.+.}-{4:4},
> at: vfio_group_fops_unl_ioctl+0x3e3/0x7b0
> [  287.367048]  #1: ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4},
> at: vfio_group_fops_unl_ioctl+0x44d/0x7b0
> [  287.376976]
> [  287.376976] stack backtrace:
> [  287.381353] CPU: 191 UID: 0 PID: 18636 Comm: vfio_pci_sriov_
> Tainted: G S                  7.0.0-dbg-DEV #3 PREEMPTLAZY
> [  287.381355] Tainted: [S]=CPU_OUT_OF_SPEC
> [  287.381356] Call Trace:
> [  287.381357]  <TASK>
> [  287.381358]  dump_stack_lvl+0x54/0x70
> [  287.381361]  print_circular_bug+0x2e1/0x300
> [  287.381363]  check_noncircular+0xf9/0x120
> [  287.381364]  ? __lock_acquire+0x5b4/0x2800
> [  287.381366]  __lock_acquire+0x14c6/0x2800
> [  287.381368]  ? pci_mmcfg_read+0x4f/0x220
> [  287.381370]  ? pci_mmcfg_write+0x57/0x220
> [  287.381371]  ? lock_acquire+0xd3/0x2f0
> [  287.381373]  ? pci_mmcfg_write+0x57/0x220
> [  287.381374]  ? lock_release+0xef/0x360
> [  287.381376]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.381377]  lock_acquire+0xd3/0x2f0
> [  287.381378]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.381379]  ? lock_is_held_type+0x76/0x100
> [  287.381382]  down_write+0x3a/0xc0
> [  287.381382]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.381383]  vfio_pci_core_runtime_resume+0x1f/0xa0
> [  287.381384]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> [  287.381385]  __rpm_callback+0x8c/0x310
> [  287.381386]  ? ktime_get_mono_fast_ns+0x3d/0xb0
> [  287.381389]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> [  287.381390]  rpm_resume+0x529/0x6f0
> [  287.381392]  ? lock_is_held_type+0x76/0x100
> [  287.381394]  __pm_runtime_resume+0x68/0x90
> [  287.381396]  vfio_pci_core_enable+0x44/0x310
> [  287.381398]  vfio_pci_open_device+0x1c/0x80
> [  287.381399]  vfio_df_open+0x10f/0x150
> [  287.381401]  vfio_group_fops_unl_ioctl+0x4a4/0x7b0
> [  287.381402]  __se_sys_ioctl+0x71/0xc0
> [  287.381404]  do_syscall_64+0x14d/0x750
> [  287.381405]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  287.381406]  ? trace_irq_disable+0x25/0xd0
> [  287.381409]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Introduce a private flag 'sriov_pwr_active' in the vfio_pci_core_device
> struct. This  allows the driver to track the SR-IOV power state requirement
> without  relying on pci_num_vf() while holding the memory_lock. The lock is
> now  only held to set the flag and ensure the device is in D0, after which
> pci_enable_sriov() can be called without the lock.
> 
> Fixes: f4162eb1e2fc ("vfio/pci: Change the PF power state to D0 before enabling VFs")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
>  include/linux/vfio_pci_core.h    | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8a..0e4a73e541d3a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -271,7 +271,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>  	int ret;
>  
>  	/* Prevent changing power state for PFs with VFs enabled */
> -	if (pci_num_vf(pdev) && state > PCI_D0)
> +	if (vdev->sriov_pwr_active && state > PCI_D0)
>  		return -EBUSY;

AIUI, clearing the flag in the out_del: below can be lockless because
at worst we'll deny a low power transition, but I think the test here
for any state >PCI_D0 does expect memory_lock, right?  Maybe this
should be something like:

	if (state > PCI_D0) {
		lockdep_assert_held_write(&vdev->memory_lock);
		if (vdev->sriov_pwr_active)
			return -EBUSY;
	}

>  
>  	if (vdev->needs_pm_restore) {
> @@ -2292,8 +2292,9 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  
>  		down_write(&vdev->memory_lock);
>  		vfio_pci_set_power_state(vdev, PCI_D0);
> -		ret = pci_enable_sriov(pdev, nr_virtfn);
> +		vdev->sriov_pwr_active = true;
>  		up_write(&vdev->memory_lock);
> +		ret = pci_enable_sriov(pdev, nr_virtfn);
>  		if (ret) {
>  			pm_runtime_put(&pdev->dev);
>  			goto out_del;
> @@ -2307,6 +2308,7 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  	}
>  
>  out_del:
> +	vdev->sriov_pwr_active = false;

A comment that this is intentionally lockless would be useful.

>  	mutex_lock(&vfio_pci_sriov_pfs_mutex);
>  	list_del_init(&vdev->sriov_pfs_item);
>  out_unlock:
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f7..9a39a13a65766 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
>  	bool			needs_pm_restore:1;
>  	bool			pm_intx_masked:1;
>  	bool			pm_runtime_engaged:1;
> +	bool			sriov_pwr_active:1;

Just 'sriov_active'?  Adding 'pwr' into it implies the use case rather
than the state it represents.  Thanks,

Alex

>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731


