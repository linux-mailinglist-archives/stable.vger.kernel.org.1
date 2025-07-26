Return-Path: <stable+bounces-164825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44BB1293A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693017B0BF8
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F505204680;
	Sat, 26 Jul 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z4FAtJ2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71D128819;
	Sat, 26 Jul 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511801; cv=none; b=kpRrTeZx0yLOqi+LajCYdDLsIDqPkb9uDGB5kJEkXQso5+CcODZXWGQahxGkePv+uWjXgNWf0oC5ulQCaaJH4usQN9NNoJFP6/yWXu2wemBbtO17FGQeYNoonZo6S3gF8x9H7PSe4Z869nRe+0fxABTX75HUJYhcnleyEnYLVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511801; c=relaxed/simple;
	bh=5vwqn6VniSu+7gYJT+ma+sD+AePMl3SSq5Xjl7bcOCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmIG4h1fIKzGP3r7GPV35+xjM2alQZybc2I7Fe8GqUaK4vZm6DGDLD+lnDM7r5KwanNdKABkF8AMWk2zqTjYBrt8huLqadWDvE6aeZhkdHitcpRX0aN5CZIuFCP70jSh9yxRAU9VL16VMOrJ2VHVQVFQ+Q3y3eOIjkG+IYUCHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z4FAtJ2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B37C4CEEF;
	Sat, 26 Jul 2025 06:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753511800;
	bh=5vwqn6VniSu+7gYJT+ma+sD+AePMl3SSq5Xjl7bcOCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4FAtJ2RhA5fhEX0nzzCnRKaNYzpE2Y6tuFBTbs8p1u0vvJJu1fnggHciIAL8lqoa
	 qi/5tg2w01WA025v9e+AZfLGyz/VJt58Af/gDj9CjUpI7qyN3xTvRq2VlgUp0bofXR
	 Q8KtJ1rrtAIePcM0PSUlTZAZWRzv3kGKxkGPKouM=
Date: Sat, 26 Jul 2025 08:36:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org, kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
Message-ID: <2025072615-espresso-grandson-d510@gregkh>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725201400.1078395-2-ysk@kzalloc.com>

On Fri, Jul 25, 2025 at 08:14:01PM +0000, Yunseong Kim wrote:
> When fuzzing USB with syzkaller on a PREEMPT_RT enabled kernel, following
> bug is triggered in the ksoftirqd context.
> 
> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> | in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
> | preempt_count: 0, expected: 0
> | RCU nest depth: 2, expected: 2
> | CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-rc1-rt1 #11 PREEMPT_RT
> | Tainted: [W]=WARN
> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> | Call trace:
> |  show_stack+0x2c/0x3c (C)
> |  __dump_stack+0x30/0x40
> |  dump_stack_lvl+0x148/0x1d8
> |  dump_stack+0x1c/0x3c
> |  __might_resched+0x2e4/0x52c
> |  rt_spin_lock+0xa8/0x1bc
> |  kcov_remote_start+0xb0/0x490
> |  __usb_hcd_giveback_urb+0x2d0/0x5e8
> |  usb_giveback_urb_bh+0x234/0x3c4
> |  process_scheduled_works+0x678/0xd18
> |  bh_worker+0x2f0/0x59c
> |  workqueue_softirq_action+0x104/0x14c
> |  tasklet_action+0x18/0x8c
> |  handle_softirqs+0x208/0x63c
> |  run_ksoftirqd+0x64/0x264
> |  smpboot_thread_fn+0x4ac/0x908
> |  kthread+0x5e8/0x734
> |  ret_from_fork+0x10/0x20

Why is this only a USB thing?  What is unique about it to trigger this
issue?

thanks,

greg k-h

