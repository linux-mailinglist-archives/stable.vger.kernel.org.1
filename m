Return-Path: <stable+bounces-253365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBHPNsEJDmru5gUAu9opvQ
	(envelope-from <stable+bounces-253365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:21:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB02598306
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A0139FEA60
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11B342CB3;
	Wed, 20 May 2026 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="oiifBTtB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRl2o1FL"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B1318ED6;
	Wed, 20 May 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303242; cv=none; b=oJefeaIT2PSjxV8YtgM/cu0hPTJe53Kc3pmbvVIdI3lnwKGucytdfQeX/ZT/FfaozJ1c9UyLUx99KxMy3PO+gB50e8kiJHl2Fd47+oTWeSM3971AhJoLHnGrb7TZundyedl4GXaPtWLnK+7h0HZOp7atiVEO+zSS+lEvaFLEu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303242; c=relaxed/simple;
	bh=O7bk/p5xxJij8SY/tXxCYR60LXo7CFl6+XP/lhcyShE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zxn06V46QFT1JH6PMk3Taj2d999t+6w1De0YOYdixzt/pftH1ggakcaNRl3xiUMUGGdyzaa0Ci9B1GIczVoe4HVauTXQXlD4r5VrtsyCjtMDZjUid3PcLvcHUjNW8IsIQR4HG6S+DrozGCRu0N71o+HFk42xWCoFo67vCbmry7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=oiifBTtB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRl2o1FL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 316E37A0069;
	Wed, 20 May 2026 14:53:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 20 May 2026 14:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779303237;
	 x=1779389637; bh=MTpz+peHYiecvc6XYTPMZbwBhAdBOsmpXC4f3tmOEGk=; b=
	oiifBTtBkGW7NnJEX0WN68jTtE/nE/um9QvvAzm8jeUdD2pBMyIquGroBygksJwq
	QrjxEGZtyuhk5VDdqOTdIga61UDFgHkwX0mkXzEa8hT1u9RgFnIStCSIqKQ5M2Qy
	yQe6dKfpaDdVyNSZpZPLPMgNumzTFY7ZbY+9eeHH5d1UXB3+hvEzs/bZys771G9F
	mB9tBkrgsA8N+d2A3ZwWy5HIMiwHglZYUXxh1oYgILAeICiLggtO5D/rypqpsRLR
	+JycVcdu4bddDZ2uABjlBfnIWdTmLurOSc+1E92s3+c4nHZ63VlEXk/kAsnEQZc/
	0Gma50A5roiVaULnvaUngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779303237; x=
	1779389637; bh=MTpz+peHYiecvc6XYTPMZbwBhAdBOsmpXC4f3tmOEGk=; b=S
	Rl2o1FL0kn9l3fMsK3iRhx2xs5hWwjpmzK54/2vjfiZng0LItxws1U2HHLcBwLr8
	6diDIAEQQ7Cp5UMzFg86pO2Em2Hx6Q8XcXyArBhfqIqcasXreWw6xlkk8Xuju8r9
	oAKRpXeUUw5JTXgRE+yfFuTFdODWpZFBRQs9iHNkQmjq1BPU6Q7elgZmdyFzykpk
	E8/46seEcntYJU+IJ5YYstNNN2xNC3MiPu4UoEQtf3NpaXjf9u7rXBti27d91RJ3
	76iZnsOZVyOQoIc4IWTnrCZ+qZasR7c91uCYnuNOSJ/H3IOK8uA0C8laW0BFPKYR
	cLkwDNLLc7F+BFjW/lnnA==
X-ME-Sender: <xms:RQMOavLdZoTjLHGDXoeXZcgrFwhKuKja18ySo8L2yv1431uJovkeug>
    <xme:RQMOajmi7VOD4XlWr8iP4YX4u4_NaL4yR4SimDr6OlQGGYEvmHwrCCGMu-BvPMwLX
    Hd0_Ifbu7d4ds7PTGYUzQBoA2axfe5DfOl36Ux0JeutEHRL_zOX>
X-ME-Received: <xmr:RQMOaoZEgP_qJyGQnTL6l5Wg8ObXJI6u8ojCSokQnnlkylwVPKvdvWRUohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehvihhp
    ihhnshhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrhhhihhlkhgvsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrd
    horhhg
X-ME-Proxy: <xmx:RQMOav93gd7vOiTgTCyw6pWA2WsOdz7_V9OpG2V5vEIRztYB-3nh_A>
    <xmx:RQMOanZqqUPU5nrQ5nykVOqGbymUvo3IIjU1cPjQ8zi9cL054rsHnA>
    <xmx:RQMOapdZBa7GTewQhGya1zgrq2cPQRWBxZpchDgr1RV8Yvd_fuBTMg>
    <xmx:RQMOakmnFszqFGOUyb_ESL836ZLS9qPyG2HchI7z9Sa88caL367_DQ>
    <xmx:RQMOanlMmmEB_ijbtg-nWDcqpuS0_M7T3s8rSz6zoE4wStHjuW7Ov6rH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 14:53:56 -0400 (EDT)
Date: Wed, 20 May 2026 12:53:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>,
 Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jason Gunthorpe
 <jgg@ziepe.ca>, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/pci: Use a private flag to prevent power state
 change with VFs
Message-ID: <20260520125354.2e028b46@shazbot.org>
In-Reply-To: <20260514173449.3282188-1-rananta@google.com>
References: <20260514173449.3282188-1-rananta@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-253365-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ziepe.ca:email]
X-Rspamd-Queue-Id: 5CB02598306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 17:34:49 +0000
Raghavendra Rao Ananta <rananta@google.com> wrote:

> The current implementation uses pci_num_vf() while holding the
> memory_lock to prevent changing the power state of a PF when
> VFs are enabled. This creates a lockdep circular dependency
> warning because memory_lock is held during device probing.
> 
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
> Introduce a private flag 'sriov_active' in the vfio_pci_core_device
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
>  drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++++---
>  include/linux/vfio_pci_core.h    |  1 +
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8a..2fb95f54a1e26 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -271,8 +271,11 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>  	int ret;
>  
>  	/* Prevent changing power state for PFs with VFs enabled */
> -	if (pci_num_vf(pdev) && state > PCI_D0)
> -		return -EBUSY;
> +	if (state > PCI_D0) {
> +		lockdep_assert_held_write(&vdev->memory_lock);
> +		if (vdev->sriov_active)
> +			return -EBUSY;
> +	}
>  
>  	if (vdev->needs_pm_restore) {
>  		if (pdev->current_state < PCI_D3hot && state >= PCI_D3hot) {
> @@ -2292,8 +2295,9 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  
>  		down_write(&vdev->memory_lock);
>  		vfio_pci_set_power_state(vdev, PCI_D0);
> -		ret = pci_enable_sriov(pdev, nr_virtfn);
> +		vdev->sriov_active = true;
>  		up_write(&vdev->memory_lock);
> +		ret = pci_enable_sriov(pdev, nr_virtfn);
>  		if (ret) {
>  			pm_runtime_put(&pdev->dev);
>  			goto out_del;
> @@ -2307,6 +2311,13 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  	}
>  
>  out_del:
> +	/*
> +	 * Avoid taking the memory_lock intentionally. A race with a power
> +	 * state transition would at most result in an -EBUSY, leaving the
> +	 * device in PCI_D0.
> +	 */
> +	vdev->sriov_active = false;
> +
>  	mutex_lock(&vfio_pci_sriov_pfs_mutex);
>  	list_del_init(&vdev->sriov_pfs_item);
>  out_unlock:
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f7..f1451ee4744ac 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
>  	bool			needs_pm_restore:1;
>  	bool			pm_intx_masked:1;
>  	bool			pm_runtime_engaged:1;
> +	bool			sriov_active:1;

We should drop the bitfield use.  I still need to respin my patches to
cleanup bitfield races in general, but this looks like a runtime
updated bitfield without any explicit locking convention with other
flags in the same storage unit, so should therefore be its own bool.

If we agree, I can do the s/:1// change on commit.  Thanks,

Alex


>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731


