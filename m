Return-Path: <stable+bounces-95947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C2C9DFD4D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A3D28061B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2E1F943E;
	Mon,  2 Dec 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NUb3mVkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1A22331
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132216; cv=none; b=LLI8jLltUeDKJcCelDJGWu2UhvbH8nMRMDiP5yKNdw9gPrRWBOlep567ta4UlUhDolhP2nVdr+2CMQShGTchkxR4iSO7J8aD4dGDXfhPjnL96AY7dxmR/vOALwyAovKh+5K5Q5qQ2nSqqo7sWc4lTZvFaSzU0l11cbLH2r2xwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132216; c=relaxed/simple;
	bh=nxFCrNYKks5ziXpnqV+WtT4PHRQKzNDliJ/rasdiNi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UujoydiZS6eNCciaXJiBgBjvAsjTngL2wv/gz+aFBpO+51d+s4OTfkyE/TZdyeRfsjuxOG4sl+auiKB0Md/cttghkNYtO2PsUdawzj55jCgSAwK2/hxMhyz304qPkHb9paRLASCiicu16x7RJFuhpXsw3AZ0WAbvbbkUOoaQp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUb3mVkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D38C4CED2;
	Mon,  2 Dec 2024 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733132215;
	bh=nxFCrNYKks5ziXpnqV+WtT4PHRQKzNDliJ/rasdiNi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUb3mVkXRqLNmPPKPzbOtwCBdtGl2jeCVoqQszSRjg4vvmZfW+vMqacf4TipT7u2J
	 1YVp1AoDpQGHydVmAzul7J6LknW7AynRev63irBBHJGigAB8JbUqLpcF78UvYP3uQr
	 1jqeM23vzHwpjM1R5A+tWWG9OjSjozbIVryxh1EM=
Date: Mon, 2 Dec 2024 10:36:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: mingli.yu@eng.windriver.com
Cc: stable@vger.kernel.org, xialonglong@kylinos.cn
Subject: Re: [PATCH v2 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Message-ID: <2024120226-motion-dole-53a4@gregkh>
References: <20241128084730.430060-1-mingli.yu@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128084730.430060-1-mingli.yu@eng.windriver.com>

On Thu, Nov 28, 2024 at 04:47:30PM +0800, mingli.yu@eng.windriver.com wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> commit 9462f4ca56e7d2430fdb6dcc8498244acbfc4489 upstream.
> 
> BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
> drivers/tty/n_gsm.c:3160 [n_gsm]
> Read of size 8 at addr ffff88815fe99c00 by task poc/3379
> CPU: 0 UID: 0 PID: 3379 Comm: poc Not tainted 6.11.0+ #56
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX
> Desktop Reference Platform, BIOS 6.00 11/12/2020
> Call Trace:
>  <TASK>
>  gsm_cleanup_mux+0x77b/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
>  __pfx_gsm_cleanup_mux+0x10/0x10 drivers/tty/n_gsm.c:3124 [n_gsm]
>  __pfx_sched_clock_cpu+0x10/0x10 kernel/sched/clock.c:389
>  update_load_avg+0x1c1/0x27b0 kernel/sched/fair.c:4500
>  __pfx_min_vruntime_cb_rotate+0x10/0x10 kernel/sched/fair.c:846
>  __rb_insert_augmented+0x492/0xbf0 lib/rbtree.c:161
>  gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
>  _raw_spin_lock_irqsave+0x92/0xf0 arch/x86/include/asm/atomic.h:107
>  __pfx_gsmld_ioctl+0x10/0x10 drivers/tty/n_gsm.c:3822 [n_gsm]
>  ktime_get+0x5e/0x140 kernel/time/timekeeping.c:195
>  ldsem_down_read+0x94/0x4e0 arch/x86/include/asm/atomic64_64.h:79
>  __pfx_ldsem_down_read+0x10/0x10 drivers/tty/tty_ldsem.c:338
>  __pfx_do_vfs_ioctl+0x10/0x10 fs/ioctl.c:805
>  tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818
> 
> Allocated by task 65:
>  gsm_data_alloc.constprop.0+0x27/0x190 drivers/tty/n_gsm.c:926 [n_gsm]
>  gsm_send+0x2c/0x580 drivers/tty/n_gsm.c:819 [n_gsm]
>  gsm1_receive+0x547/0xad0 drivers/tty/n_gsm.c:3038 [n_gsm]
>  gsmld_receive_buf+0x176/0x280 drivers/tty/n_gsm.c:3609 [n_gsm]
>  tty_ldisc_receive_buf+0x101/0x1e0 drivers/tty/tty_buffer.c:391
>  tty_port_default_receive_buf+0x61/0xa0 drivers/tty/tty_port.c:39
>  flush_to_ldisc+0x1b0/0x750 drivers/tty/tty_buffer.c:445
>  process_scheduled_works+0x2b0/0x10d0 kernel/workqueue.c:3229
>  worker_thread+0x3dc/0x950 kernel/workqueue.c:3391
>  kthread+0x2a3/0x370 kernel/kthread.c:389
>  ret_from_fork+0x2d/0x70 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:257
> 
> Freed by task 3367:
>  kfree+0x126/0x420 mm/slub.c:4580
>  gsm_cleanup_mux+0x36c/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
>  gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
>  tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818
> 
> [Analysis]
> gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
> can be freed by multi threads through ioctl,which leads
> to the occurrence of uaf. Protect it by gsm tx lock.
> 
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> Cc: stable <stable@kernel.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/r/20240926130213.531959-1-xialonglong@kylinos.cn
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Mingli: Backport to fix CVE-2024-50073, no guard macro defined resolution]
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  drivers/tty/n_gsm.c | 4 ++++
>  1 file changed, 4 insertions(+)

What differed from v1?

Please submit a v3 that says what has changed here.

thanks,

greg k-h

