Return-Path: <stable+bounces-25469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B931586C3E4
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6521C222E8
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3131F5025C;
	Thu, 29 Feb 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K5eTbb1M"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960042A86;
	Thu, 29 Feb 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196049; cv=none; b=UtUPMOtkIlnvCS8KqpASx5Rp+N6IDKJV7UOQbcJYsQVBQ6vezI4rfZ970JGAs5WDlYIH2B4o5f89niCtgpa/I0/+rl9cVhQDcWnbZtETBChx5gtMDKO74cwCDp5PNW9XuhR0s+Bn/9QRgrRCL/mGi3/8TUQAj0IIhdCZ3Hn9HAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196049; c=relaxed/simple;
	bh=zrTohWqCvznBLwqVZx/sS9IRPJLnHRYP6siw5a3cXps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ql5+blFBtC7Yk+kwVE7fz7O2TAwvcBKbgNRShWGm7IPwRLbMM9hqirHJbbD/I/4OAMbL1itzpGAb9OtD+bp0gR/IQzg9bYNpLSC+Zk3XdgW+akSvUzWUWz7r1ut4kNFZaia8oAQ71jVaio01BuMlBhsvY7DKt8kAwJB37W2D7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K5eTbb1M; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sV748/DK4y7MmA9h53fR2Cke85t+vKAbJkGa/rnZq9s=; t=1709196046;
	x=1709628046; b=K5eTbb1M5Jk8RTk8BVR2k0kbXR+HZHEhoiWGWs1lBSakXQkvdnCszcctvykY8
	YvztZVeNWRdw1gwSQIj2LeQ4KXdIvtcRYdKlzkMCQmSmrhlaLmjVbx4jkR3Ii8jbOqnu5cmdOyJhD
	NWYJtB4I75BydWialRd8plB7DCo0H7qVR+xg0oElnEwv3hFTzPHnJp1GqieseEdShyWGsoRMts9cn
	vF0cB+TzVb9adkSC9bAhyGPvpM9CjW0GO/4XraV4dBisCIcdFWZFjkdrd1EnG7pRa65OI7DuNtZB2
	XOmXcOI26H7zisMPRvK1W9UAndXigt+6RcAJsK+la132LHwXWw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfby7-0006pp-8w; Thu, 29 Feb 2024 09:40:43 +0100
Message-ID: <0a45771f-3fd3-446c-a5eb-dffc9eac53eb@leemhuis.info>
Date: Thu, 29 Feb 2024 09:40:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
Content-Language: en-US, de-DE
To: Simon Kirby <sim@hostway.ca>, linux-bluetooth@vger.kernel.org,
 Hyunwoo Kim <v4bel@theori.io>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20240226213855.GB3202@hostway.ca>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240226213855.GB3202@hostway.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709196046;bfdb80ce;
X-HE-SMSGID: 1rfby7-0006pp-8w

[CCing the bluetooth maintainers]

On 26.02.24 22:38, Simon Kirby wrote:
> 
> I bisected a regression where reading from a Bluetooth device gets stuck
> in recvfrom() calls. The device here is a Wii Balance Board, using
> https://github.com/initialstate/beerfridge/blob/master/wiiboard_test.py;
> this worked fine in v6.6.1 and v6.6.8, but when I tried on a v6.6.14
> build, the script no longer outputs any readings.
> 
> 1d576c3a5af850bf11fbd103f9ba11aa6d6061fb is the first bad commit
> 
> which maps to upstream commit 2e07e8348ea454615e268222ae3fc240421be768:

Could you please check if this problem only occurs with the latest 6.6.y
versions, or also with mainline (6.8-rc8)? That's important to know, as
that in the end determines who and how this needs to be is handled.

Ciao, Thorsten

> Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
> 
> With this commit in place, as also in v6.7 and v6.7.6, the script does
> not output anything _unless_ I strace the process, in which case a bunch
> of recvmsg() syscalls are shown, and then it hangs again. If I ^C the
> strace and run it a few times, eventually the script will get enough data
> and output a reading.
> 
> If I don't strace the script, a hung task warning appears:
> 
> INFO: task kworker/u9:1:121 blocked for more than 30 seconds.
>       Not tainted 6.7.6-lemon #183
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u9:1    state:D stack:0     pid:121   tgid:121   ppid:2      flags:0x00004000
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __schedule+0x37d/0xa00
>  schedule+0x32/0xe0
>  __lock_sock+0x68/0xa0
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  lock_sock_nested+0x43/0x50
>  l2cap_sock_recv_cb+0x21/0xa0
>  l2cap_recv_frame+0x55b/0x30a0
>  ? psi_task_switch+0xeb/0x270
>  ? finish_task_switch.isra.0+0x93/0x2a0
>  hci_rx_work+0x33a/0x3f0               
>  process_one_work+0x13a/0x2f0
>  worker_thread+0x2f0/0x410
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe0/0x110
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> On 6.8-rc6 with lockdep enabled, I get the following output:
> 
> [   22.122337] wlan0: associated
> [ 4547.622339] INFO: task kworker/u9:1:3528 blocked for more than 30 seconds.
> 
> [ 4547.622530] =====================================================
> [ 4547.622531] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> [ 4547.622535] 6.8.0-rc6-lemon #190 Not tainted
> [ 4547.622538] -----------------------------------------------------
> [ 4547.622540] khungtaskd/39 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [ 4547.622546] ffff888101554cf8 ((work_completion)(&(&ops->cursor_work)->work)){+.+.}-{0:0}, at: __flush_work+0x4b/0x3f0
> [ 4547.622569] 
>                and this task is already holding:
> [ 4547.622571] ffffffff8367e600 (console_owner){....}-{0:0}, at: console_flush_all+0x1c9/0x4e0
> [ 4547.622586] which would create a new lock dependency:
> [ 4547.622587]  (console_owner){....}-{0:0} -> ((work_completion)(&(&ops->cursor_work)->work)){+.+.}-{0:0}
> [ 4547.622596] 
>                but this new dependency connects a SOFTIRQ-irq-safe lock:
> [ 4547.622598]  (&trans_pcie->irq_lock){+.-.}-{3:3}
> [ 4547.622601] 
>                ... which became SOFTIRQ-irq-safe at:
> [ 4547.622603]   lock_acquire+0xb0/0x280
> [ 4547.622611]   _raw_spin_lock+0x2b/0x40
> [ 4547.622618]   iwl_pcie_napi_poll+0x7a/0x130
> [ 4547.622627]   __napi_poll.constprop.0+0x23/0x1e0
> [ 4547.622634]   net_rx_action+0x137/0x2a0
> [ 4547.622639]   __do_softirq+0xc7/0x402
> [ 4547.622645]   do_softirq+0x42/0xa0
> [ 4547.622651]   __local_bh_enable_ip+0xb8/0xd0
> [ 4547.622657]   iwl_pcie_irq_handler+0x539/0xb70
> [ 4547.622665]   irq_thread_fn+0x1b/0x60
> [ 4547.622670]   irq_thread+0xe0/0x190
> [ 4547.622675]   kthread+0xe3/0x120
> [ 4547.622679]   ret_from_fork+0x2c/0x50
> [ 4547.622684]   ret_from_fork_asm+0x1b/0x30
> [ 4547.622692] 
>                to a SOFTIRQ-irq-unsafe lock:
> [ 4547.622694]  ((work_completion)(&(&ops->cursor_work)->work)){+.+.}-{0:0}
> [ 4547.622698] 
>                ... which became SOFTIRQ-irq-unsafe at:
> [ 4547.622699] ...
> [ 4547.622700]   lock_acquire+0xb0/0x280
> [ 4547.622706]   process_one_work+0x199/0x480
> [ 4547.622713]   worker_thread+0x1be/0x3b0
> [ 4547.622719]   kthread+0xe3/0x120
> [ 4547.622722]   ret_from_fork+0x2c/0x50
> [ 4547.622725]   ret_from_fork_asm+0x1b/0x30
> [ 4547.622731] 
>                other info that might help us debug this:
> 
> [ 4547.622732] Chain exists of:
>                  &trans_pcie->irq_lock --> console_owner --> (work_completion)(&(&ops->cursor_work)->work)
> 
> [ 4547.622739]  Possible interrupt unsafe locking scenario:
> 
> [ 4547.622741]        CPU0                    CPU1
> [ 4547.622742]        ----                    ----
> [ 4547.622742]   lock((work_completion)(&(&ops->cursor_work)->work));
> [ 4547.622745]                                local_irq_disable();
> [ 4547.622746]                                lock(&trans_pcie->irq_lock);
> [ 4547.622749]                                lock(console_owner);
> [ 4547.622751]   <Interrupt>
> [ 4547.622752]     lock(&trans_pcie->irq_lock);
> [ 4547.622754] 
>                 *** DEADLOCK ***
> 
> [ 4547.622755] 5 locks held by khungtaskd/39:
> [ 4547.622759]  #0: ffffffff836f14e0 (rcu_read_lock){....}-{1:3}, at: watchdog+0xd8/0x7b0
> [ 4547.622778]  #1: ffffffff836ee820 (console_lock){+.+.}-{0:0}, at: _printk+0x47/0x50
> [ 4547.622789]  #2: ffffffff836ee870 (console_srcu){....}-{0:0}, at: console_flush_all+0x74/0x4e0
> [ 4547.622800]  #3: ffffffff8367e600 (console_owner){....}-{0:0}, at: console_flush_all+0x1c9/0x4e0
> [ 4547.622810]  #4: ffffffff837d8758 (printing_lock){....}-{3:3}, at: vt_console_print+0x47/0x430
> [ 4547.622822] 
>                the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
> [ 4547.622824]   -> (&trans_pcie->irq_lock){+.-.}-{3:3} {
> [ 4547.622830]      HARDIRQ-ON-W at:
> [ 4547.622833]                         lock_acquire+0xb0/0x280
> [ 4547.622839]                         _raw_spin_lock_bh+0x33/0x40
> [ 4547.622845]                         iwl_trans_pcie_alloc+0x2fd/0x990
> [ 4547.622853]                         iwl_pci_probe+0x28/0x810
> [ 4547.622859]                         pci_device_probe+0x94/0x120
> [ 4547.622865]                         really_probe+0x15e/0x2f0
> [ 4547.622872]                         __driver_probe_device+0x6e/0x110
> [ 4547.622878]                         driver_probe_device+0x1a/0xe0
> [ 4547.622884]                         __driver_attach+0x87/0x190
> [ 4547.622890]                         bus_for_each_dev+0x66/0xb0
> [ 4547.622894]                         bus_add_driver+0xea/0x1f0
> [ 4547.622898]                         driver_register+0x54/0x100
> [ 4547.622905]                         iwl_pci_register_driver+0x1a/0x40
> [ 4547.622911]                         do_one_initcall+0x50/0x250
> [ 4547.622918]                         kernel_init_freeable+0x243/0x3e0
> [ 4547.622927]                         kernel_init+0x15/0x1a0
> [ 4547.622931]                         ret_from_fork+0x2c/0x50
> [ 4547.622935]                         ret_from_fork_asm+0x1b/0x30
> [ 4547.622941]      IN-SOFTIRQ-W at:
> [ 4547.622943]                         lock_acquire+0xb0/0x280
> [ 4547.622948]                         _raw_spin_lock+0x2b/0x40
> [ 4547.622953]                         iwl_pcie_napi_poll+0x7a/0x130
> [ 4547.622961]                         __napi_poll.constprop.0+0x23/0x1e0
> [ 4547.622966]                         net_rx_action+0x137/0x2a0
> [ 4547.622971]                         __do_softirq+0xc7/0x402
> [ 4547.622978]                         do_softirq+0x42/0xa0
> [ 4547.622983]                         __local_bh_enable_ip+0xb8/0xd0
> [ 4547.622989]                         iwl_pcie_irq_handler+0x539/0xb70
> [ 4547.622996]                         irq_thread_fn+0x1b/0x60
> [ 4547.623002]                         irq_thread+0xe0/0x190
> [ 4547.623006]                         kthread+0xe3/0x120
> [ 4547.623011]                         ret_from_fork+0x2c/0x50
> [ 4547.623014]                         ret_from_fork_asm+0x1b/0x30
> [ 4547.623020]      INITIAL USE at:
> [ 4547.623022]                        lock_acquire+0xb0/0x280
> [ 4547.623027]                        _raw_spin_lock_bh+0x33/0x40
> [ 4547.623032]                        iwl_trans_pcie_alloc+0x2fd/0x990
> [ 4547.623038]                        iwl_pci_probe+0x28/0x810
> [ 4547.623043]                        pci_device_probe+0x94/0x120
> [ 4547.623047]                        really_probe+0x15e/0x2f0
> [ 4547.623053]                        __driver_probe_device+0x6e/0x110
> [ 4547.623059]                        driver_probe_device+0x1a/0xe0
> [ 4547.623064]                        __driver_attach+0x87/0x190
> [ 4547.623070]                        bus_for_each_dev+0x66/0xb0
> [ 4547.623073]                        bus_add_driver+0xea/0x1f0
> [ 4547.623077]                        driver_register+0x54/0x100
> [ 4547.623084]                        iwl_pci_register_driver+0x1a/0x40
> [ 4547.623090]                        do_one_initcall+0x50/0x250
> [ 4547.623096]                        kernel_init_freeable+0x243/0x3e0
> [ 4547.623103]                        kernel_init+0x15/0x1a0
> [ 4547.623107]                        ret_from_fork+0x2c/0x50
> [ 4547.623110]                        ret_from_fork_asm+0x1b/0x30
> [ 4547.623116]    }
> [ 4547.623118]    ... key      at: [<ffffffff8502fe90>] __key.20+0x0/0x10
> [ 4547.623129]  -> (&trans_pcie->reg_lock){+...}-{3:3} {
> [ 4547.623134]     HARDIRQ-ON-W at:
> [ 4547.623137]                       lock_acquire+0xb0/0x280
> [ 4547.623142]                       _raw_spin_lock_bh+0x33/0x40
> [ 4547.623147]                       iwl_trans_pcie_set_bits_mask+0x25/0x60
> [ 4547.623151]                       iwl_pcie_set_hw_ready+0x1e/0xa0
> [ 4547.623160]                       iwl_pcie_prepare_card_hw+0x33/0x100
> [ 4547.623165]                       iwl_pci_probe+0x42/0x810
> [ 4547.623171]                       pci_device_probe+0x94/0x120
> [ 4547.623175]                       really_probe+0x15e/0x2f0
> [ 4547.623181]                       __driver_probe_device+0x6e/0x110
> [ 4547.623186]                       driver_probe_device+0x1a/0xe0
> [ 4547.623192]                       __driver_attach+0x87/0x190
> [ 4547.623197]                       bus_for_each_dev+0x66/0xb0
> [ 4547.623201]                       bus_add_driver+0xea/0x1f0
> [ 4547.623205]                       driver_register+0x54/0x100
> [ 4547.623211]                       iwl_pci_register_driver+0x1a/0x40
> [ 4547.623217]                       do_one_initcall+0x50/0x250
> [ 4547.623223]                       kernel_init_freeable+0x243/0x3e0
> [ 4547.623229]                       kernel_init+0x15/0x1a0
> [ 4547.623233]                       ret_from_fork+0x2c/0x50
> [ 4547.623236]                       ret_from_fork_asm+0x1b/0x30
> [ 4547.623242]     INITIAL USE at:
> [ 4547.623244]                      lock_acquire+0xb0/0x280
> [ 4547.623249]                      _raw_spin_lock_bh+0x33/0x40
> [ 4547.623254]                      iwl_trans_pcie_set_bits_mask+0x25/0x60
> [ 4547.623257]                      iwl_pcie_set_hw_ready+0x1e/0xa0
> [ 4547.623266]                      iwl_pcie_prepare_card_hw+0x33/0x100
> [ 4547.623271]                      iwl_pci_probe+0x42/0x810
> [ 4547.623277]                      pci_device_probe+0x94/0x120
> [ 4547.623281]                      really_probe+0x15e/0x2f0
> [ 4547.623286]                      __driver_probe_device+0x6e/0x110
> [ 4547.623292]                      driver_probe_device+0x1a/0xe0
> [ 4547.623297]                      __driver_attach+0x87/0x190
> [ 4547.623303]                      bus_for_each_dev+0x66/0xb0
> [ 4547.623306]                      bus_add_driver+0xea/0x1f0
> [ 4547.623310]                      driver_register+0x54/0x100
> [ 4547.623316]                      iwl_pci_register_driver+0x1a/0x40
> [ 4547.623323]                      do_one_initcall+0x50/0x250
> [ 4547.623328]                      kernel_init_freeable+0x243/0x3e0
> [ 4547.623334]                      kernel_init+0x15/0x1a0
> [ 4547.623338]                      ret_from_fork+0x2c/0x50
> [ 4547.623342]                      ret_from_fork_asm+0x1b/0x30
> [ 4547.623347]   }
> [ 4547.623348]   ... key      at: [<ffffffff8502fe80>] __key.19+0x0/0x10
> [ 4547.623358]   ... acquired at:
> [ 4547.623359]    _raw_spin_lock_bh+0x33/0x40
> [ 4547.623364]    iwl_trans_pcie_set_bits_mask+0x25/0x60
> [ 4547.623368]    iwl_pcie_apm_init+0x6e/0x1c0
> [ 4547.623372]    iwl_trans_pcie_start_fw+0x224/0x670
> [ 4547.623377]    iwl_mvm_load_ucode_wait_alive+0xd3/0x5a0
> [ 4547.623383]    iwl_run_init_mvm_ucode+0x8c/0x3a0
> [ 4547.623387]    iwl_mvm_start_get_nvm+0x87/0x210
> [ 4547.623393]    iwl_op_mode_mvm_start+0x962/0xb30
> [ 4547.623399]    _iwl_op_mode_start.isra.0+0x72/0xb0
> [ 4547.623403]    iwl_opmode_register+0x6a/0xe0
> [ 4547.623408]    iwl_mvm_init+0x21/0x60
> [ 4547.623413]    do_one_initcall+0x50/0x250
> [ 4547.623419]    kernel_init_freeable+0x243/0x3e0
> [ 4547.623425]    kernel_init+0x15/0x1a0
> [ 4547.623429]    ret_from_fork+0x2c/0x50
> [ 4547.623432]    ret_from_fork_asm+0x1b/0x30
> 
> [ 4547.623441] -> (console_owner){....}-{0:0} {
> [ 4547.623446]    INITIAL USE at:
> [ 4547.623452]                    lock_acquire+0xb0/0x280
> [ 4547.623457]                    console_flush_all+0x1f2/0x4e0
> [ 4547.623463]                    console_unlock+0x33/0x110
> [ 4547.623469]                    vprintk_emit+0x9f/0x320
> [ 4547.623475]                    _printk+0x47/0x50
> [ 4547.623479]                    register_console+0x34b/0x4d0
> [ 4547.623485]                    con_init+0x200/0x270
> [ 4547.623494]                    console_init+0x4a/0x1e0
> [ 4547.623504]                    start_kernel+0x2b9/0x660
> [ 4547.623510]                    x86_64_start_reservations+0x18/0x30
> [ 4547.623517]                    x86_64_start_kernel+0xad/0xc0
> [ 4547.623522]                    secondary_startup_64_no_verify+0x170/0x17b
> [ 4547.623528]  }
> [ 4547.623529]  ... key      at: [<ffffffff8367e600>] console_owner_dep_map+0x0/0x28
> [ 4547.623538]  ... acquired at:
> [ 4547.623540]    console_flush_all+0x1f2/0x4e0
> [ 4547.623545]    console_unlock+0x33/0x110
> [ 4547.623551]    vprintk_emit+0x9f/0x320
> [ 4547.623557]    dev_vprintk_emit+0xce/0x160
> [ 4547.623562]    dev_printk_emit+0x3d/0x50
> [ 4547.623566]    _dev_info+0x5b/0x70
> [ 4547.623572]    __iwl_info+0x58/0x60
> [ 4547.623576]    iwl_pci_probe+0x11c/0x810
> [ 4547.623582]    pci_device_probe+0x94/0x120
> [ 4547.623587]    really_probe+0x15e/0x2f0
> [ 4547.623592]    __driver_probe_device+0x6e/0x110
> [ 4547.623598]    driver_probe_device+0x1a/0xe0
> [ 4547.623603]    __driver_attach+0x87/0x190
> [ 4547.623609]    bus_for_each_dev+0x66/0xb0
> [ 4547.623612]    bus_add_driver+0xea/0x1f0
> [ 4547.623616]    driver_register+0x54/0x100
> [ 4547.623622]    iwl_pci_register_driver+0x1a/0x40
> [ 4547.623629]    do_one_initcall+0x50/0x250
> [ 4547.623634]    kernel_init_freeable+0x243/0x3e0
> [ 4547.623640]    kernel_init+0x15/0x1a0
> [ 4547.623644]    ret_from_fork+0x2c/0x50
> [ 4547.623648]    ret_from_fork_asm+0x1b/0x30
> 
> [ 4547.623654] 
>                the dependencies between the lock to be acquired
> [ 4547.623655]  and SOFTIRQ-irq-unsafe lock:
> [ 4547.623665] -> ((work_completion)(&(&ops->cursor_work)->work)){+.+.}-{0:0} {
> [ 4547.623670]    HARDIRQ-ON-W at:
> [ 4547.623672]                     lock_acquire+0xb0/0x280
> [ 4547.623677]                     process_one_work+0x199/0x480
> [ 4547.623684]                     worker_thread+0x1be/0x3b0
> [ 4547.623690]                     kthread+0xe3/0x120
> [ 4547.623694]                     ret_from_fork+0x2c/0x50
> [ 4547.623698]                     ret_from_fork_asm+0x1b/0x30
> [ 4547.623704]    SOFTIRQ-ON-W at:
> [ 4547.623705]                     lock_acquire+0xb0/0x280
> [ 4547.623710]                     process_one_work+0x199/0x480
> [ 4547.623716]                     worker_thread+0x1be/0x3b0
> [ 4547.623722]                     kthread+0xe3/0x120
> [ 4547.623725]                     ret_from_fork+0x2c/0x50
> [ 4547.623729]                     ret_from_fork_asm+0x1b/0x30
> [ 4547.623734]    INITIAL USE at:
> [ 4547.623736]                    lock_acquire+0xb0/0x280
> [ 4547.623741]                    process_one_work+0x199/0x480
> [ 4547.623747]                    worker_thread+0x1be/0x3b0
> [ 4547.623753]                    kthread+0xe3/0x120
> [ 4547.623757]                    ret_from_fork+0x2c/0x50
> [ 4547.623760]                    ret_from_fork_asm+0x1b/0x30
> [ 4547.623766]  }
> [ 4547.623767]  ... key      at: [<ffffffff850211b0>] __key.1+0x0/0x10
> [ 4547.623775]  ... acquired at:
> [ 4547.623777]    lock_acquire+0xb0/0x280
> [ 4547.623781]    __flush_work+0x56/0x3f0
> [ 4547.623789]    __cancel_work_timer+0xd3/0x160
> [ 4547.623796]    fbcon_cursor+0x138/0x170
> [ 4547.623802]    hide_cursor+0x26/0xc0
> [ 4547.623807]    vt_console_print+0x41e/0x430
> [ 4547.623814]    console_flush_all+0x206/0x4e0
> [ 4547.623820]    console_unlock+0x33/0x110
> [ 4547.623825]    vprintk_emit+0x9f/0x320
> [ 4547.623831]    _printk+0x47/0x50
> [ 4547.623834]    watchdog+0x53a/0x7b0
> [ 4547.623838]    kthread+0xe3/0x120
> [ 4547.623841]    ret_from_fork+0x2c/0x50
> [ 4547.623845]    ret_from_fork_asm+0x1b/0x30
> 
> [ 4547.623851] 
>                stack backtrace:
> [ 4547.623854] CPU: 2 PID: 39 Comm: khungtaskd Not tainted 6.8.0-rc6-lemon #190
> [ 4547.623860] Hardware name: LENOVO 80MK/VIUU4, BIOS C6CN29WW 09/02/2015
> [ 4547.623862] Call Trace:
> [ 4547.623865]  <TASK>
> [ 4547.623867]  dump_stack_lvl+0x4a/0x80
> [ 4547.623879]  check_irq_usage+0x8aa/0xb10
> [ 4547.623886]  ? check_path.constprop.0+0x24/0x50
> [ 4547.623896]  ? check_noncircular+0x6d/0x120
> [ 4547.623902]  ? __lock_acquire+0x146a/0x25c0
> [ 4547.623907]  __lock_acquire+0x146a/0x25c0
> [ 4547.623913]  lock_acquire+0xb0/0x280
> [ 4547.623918]  ? __flush_work+0x4b/0x3f0
> [ 4547.623925]  ? __flush_work+0x4b/0x3f0
> [ 4547.623932]  __flush_work+0x56/0x3f0
> [ 4547.623939]  ? __flush_work+0x4b/0x3f0
> [ 4547.623946]  ? __lock_acquire+0x3ef/0x25c0
> [ 4547.623952]  __cancel_work_timer+0xd3/0x160
> [ 4547.623960]  fbcon_cursor+0x138/0x170
> [ 4547.623965]  hide_cursor+0x26/0xc0
> [ 4547.623971]  vt_console_print+0x41e/0x430
> [ 4547.623977]  ? lock_release+0xb5/0x230
> [ 4547.623982]  ? console_flush_all+0x1c9/0x4e0
> [ 4547.623988]  console_flush_all+0x206/0x4e0
> [ 4547.623994]  ? console_flush_all+0x1c9/0x4e0
> [ 4547.624001]  console_unlock+0x33/0x110
> [ 4547.624007]  vprintk_emit+0x9f/0x320
> [ 4547.624013]  _printk+0x47/0x50
> [ 4547.624017]  watchdog+0x53a/0x7b0
> [ 4547.624021]  ? __pfx_watchdog+0x10/0x10
> [ 4547.624025]  kthread+0xe3/0x120
> [ 4547.624029]  ? __pfx_kthread+0x10/0x10
> [ 4547.624033]  ret_from_fork+0x2c/0x50
> [ 4547.624037]  ? __pfx_kthread+0x10/0x10
> [ 4547.624041]  ret_from_fork_asm+0x1b/0x30
> [ 4547.624049]  </TASK>
> [ 4548.028173]       Not tainted 6.8.0-rc6-lemon #190
> [ 4548.029491] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4548.031047] task:kworker/u9:1    state:D stack:0     pid:3528  tgid:3528  ppid:2      flags:0x00004000
> [ 4548.032620] Workqueue: hci0 hci_rx_work
> [ 4548.034099] Call Trace:
> [ 4548.035572]  <TASK>
> [ 4548.036925]  __schedule+0x427/0xd10
> [ 4548.038382]  ? schedule+0xf7/0x140
> [ 4548.039822]  schedule+0x45/0x140
> [ 4548.041201]  __lock_sock+0x86/0xf0
> [ 4548.042601]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 4548.044030]  lock_sock_nested+0x61/0x70
> [ 4548.045390]  l2cap_sock_recv_cb+0x21/0xa0
> [ 4548.046842]  l2cap_recv_frame+0x5be/0x2e70
> [ 4548.048283]  ? hci_rx_work+0x431/0x830
> [ 4548.049701]  ? lock_release+0xb5/0x230
> [ 4548.051145]  ? __mutex_unlock_slowpath+0x25/0x270
> [ 4548.052524]  hci_rx_work+0x457/0x830
> [ 4548.053945]  ? process_one_work+0x157/0x480
> [ 4548.055460]  process_one_work+0x1ca/0x480
> [ 4548.056862]  worker_thread+0x1be/0x3b0
> [ 4548.058281]  ? __pfx_worker_thread+0x10/0x10
> [ 4548.059783]  kthread+0xe3/0x120
> [ 4548.061141]  ? __pfx_kthread+0x10/0x10
> [ 4548.062600]  ret_from_fork+0x2c/0x50
> [ 4548.064064]  ? __pfx_kthread+0x10/0x10
> [ 4548.065436]  ret_from_fork_asm+0x1b/0x30
> [ 4548.066867]  </TASK>
> [ 4548.068313] INFO: lockdep is turned off.
> 
> # cat /proc/3526/stack
> [<0>] __skb_wait_for_more_packets+0xfa/0x150
> [<0>] __skb_recv_datagram+0x59/0xa0
> [<0>] skb_recv_datagram+0x29/0x40
> [<0>] bt_sock_recvmsg+0x42/0x1c0
> [<0>] l2cap_sock_recvmsg+0x5d/0x170
> [<0>] __sys_recvfrom+0x14e/0x160
> [<0>] __x64_sys_recvfrom+0x1f/0x30
> [<0>] do_syscall_64+0x75/0x150
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> This is on my laptop with iwlwifi, but at first I saw it on my desktop
> with Ethernet (and Intel 9260 Bluetooth). I can get another lockdep
> capture if that would be helpful.
> 
> Simon-
> 
> 

