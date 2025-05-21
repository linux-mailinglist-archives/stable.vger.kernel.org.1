Return-Path: <stable+bounces-145754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E8ABEAE3
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DC34A122F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D791C8630;
	Wed, 21 May 2025 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcT9JFec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463181D554
	for <stable@vger.kernel.org>; Wed, 21 May 2025 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801023; cv=none; b=d4yYqT4kEF2mMYe86zhW1LxCfcyEEeMxgppqDnVjYoDcyhjBiPTx2p2QsKn6WaPMmpKGYLl4LnvlatW+fQIQohb9F02OlpNOcjPWrt7j//k7XOtGRM5SIRfR9yDADZXCR6+Qc9ma8qcZqEnt/QPMrAE3A/3IguqghldjSNmJR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801023; c=relaxed/simple;
	bh=OYXy6sLzHiVj/qljtnhy+ytPkqBQkdOPZIveZFPoCCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOiv+iIVBNgL0ph6IAKY/BQ4USWGYekjI2vEw3F6dfdZleLSSfqgYH6BE4azGG13a73J44CSmx/oqQfuO4RyqAB8wvl7q0lX9vmoMOXGczvv9OvPpYUcNWPxUbMi2QdaHR55HXlJDN3CBoas9I2iCVl+ZhiUtyBNzrG6RSslUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcT9JFec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC72C4CEE4;
	Wed, 21 May 2025 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747801022;
	bh=OYXy6sLzHiVj/qljtnhy+ytPkqBQkdOPZIveZFPoCCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcT9JFecI8sZqzOPJLJvT57oC9gV+8dcPrD7dOhMqiSeZeAf9AD+Ry5Ev3cFsgZ6G
	 VaU1gCgHqdNq6dcBz/MHJ+aCcLz2WZlj3BAxhQgUHwBt0Urxvd9TXWOHYHatYQLc79
	 f9Sa048EPpaVVE00UMB2C/gYYS+gGxY7sIGLq7Pc=
Date: Wed, 21 May 2025 06:16:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@windriver.com
Cc: stable@vger.kernel.org, juri.lelli@redhat.com, wander@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 5.10.y] sched/deadline: Fix warning in migrate_enable for
 boosted tasks
Message-ID: <2025052133-chair-detonator-4ec1@gregkh>
References: <20250521013452.3345001-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521013452.3345001-1-bin.lan.cn@windriver.com>

On Wed, May 21, 2025 at 09:34:52AM +0800, bin.lan.cn@windriver.com wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> [ Upstream commit 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638 ]
> 
> When running the following command:
> 
> while true; do
>     stress-ng --cyclic 30 --timeout 30s --minimize --quiet
> done
> 
> a warning is eventually triggered:
> 
> WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
> setup_new_dl_entity+0x13e/0x180
> ...
> Call Trace:
>  <TASK>
>  ? show_trace_log_lvl+0x1c4/0x2df
>  ? enqueue_dl_entity+0x631/0x6e0
>  ? setup_new_dl_entity+0x13e/0x180
>  ? __warn+0x7e/0xd0
>  ? report_bug+0x11a/0x1a0
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  enqueue_dl_entity+0x631/0x6e0
>  enqueue_task_dl+0x7d/0x120
>  __do_set_cpus_allowed+0xe3/0x280
>  __set_cpus_allowed_ptr_locked+0x140/0x1d0
>  __set_cpus_allowed_ptr+0x54/0xa0
>  migrate_enable+0x7e/0x150
>  rt_spin_unlock+0x1c/0x90
>  group_send_sig_info+0xf7/0x1a0
>  ? kill_pid_info+0x1f/0x1d0
>  kill_pid_info+0x78/0x1d0
>  kill_proc_info+0x5b/0x110
>  __x64_sys_kill+0x93/0xc0
>  do_syscall_64+0x5c/0xf0
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  RIP: 0033:0x7f0dab31f92b
> 
> This warning occurs because set_cpus_allowed dequeues and enqueues tasks
> with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
> is triggered. A boosted task already had its parameters set by
> rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
> hence the WARN_ON call.
> 
> Check if we are requeueing a boosted task and avoid calling
> setup_new_dl_entity if that's the case.
> 
> Fixes: 295d6d5e3736 ("sched/deadline: Fix switching to -deadline")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> Link: https://lore.kernel.org/r/20240724142253.27145-2-wander@redhat.com
> [Minor context change fixed.]
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Build test passed.

Again, sorry, but no, I can't take this until you all fix your
development process as I requested yesterday.

greg k-h

