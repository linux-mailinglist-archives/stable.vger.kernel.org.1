Return-Path: <stable+bounces-169361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A2B246CE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0423B5944
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61C2F2918;
	Wed, 13 Aug 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhcG/+dt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DC2F3C05
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079627; cv=none; b=Ypbj51zDFaYB2fBQ3XnCw/16JLqQo87HudV4IFvHAM3FSBzNxmpkwuvDgFRvzzYjyTT/oiSZFY8kzDN+mswq/TnM1TfeYhCzhrEyXV+Ivq6C7lKvUeRxBz1ZNSflo3lFv+9TcJRttPwBZTSgROFv6sPTsfy3jBh8fWeyy97efOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079627; c=relaxed/simple;
	bh=TXDDn5/i/SmAnE96YLwfCG1xHdxhkYLKDx1iFGjVjHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejn8YJ3d0QKK0f7j4eLWhTD5PnWO8YKQSmh9kDXdxAJyDfJrnx9BlFmDCSp1Y9LnY/ThQbVvamU6B/Y2O/B3skhw/6viNcy5BPu14h3OpZBAynKjMMERWli6NW0WHhEN3vdgNhTa3K+6b1/TXitAQwXw3UAQimHy1UsPBOdvOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhcG/+dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755079623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9iqVe+R8c3zfM/uPK79C2n38w+wRWE9/HfoR+oRT0g=;
	b=UhcG/+dt1IlNng20GzplGT0bIoXiL9gozq//JYJgpXGbfCGgiUlDTc6eYrOiX1uaSLf6ne
	iWmvNIc/EQMmY1DsKcYWpU3R+M/f/W+ndyRce3JYa6yRij3dyMUKVZmWi/Ylp5bEkuaMer
	/X0dqTNS0oCYtllqYD/njXUm/K+vf7A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-LBRarVM-PTaDi3FS6q2eaA-1; Wed,
 13 Aug 2025 06:07:00 -0400
X-MC-Unique: LBRarVM-PTaDi3FS6q2eaA-1
X-Mimecast-MFC-AGG-ID: LBRarVM-PTaDi3FS6q2eaA_1755079618
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B6CF1956087;
	Wed, 13 Aug 2025 10:06:57 +0000 (UTC)
Received: from localhost (unknown [10.22.64.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DCA51955F43;
	Wed, 13 Aug 2025 10:06:55 +0000 (UTC)
Date: Wed, 13 Aug 2025 07:06:54 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Yunseong Kim <ysk@kzalloc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Austin Kim <austindh.kim@gmail.com>, linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com, stable@vger.kernel.org
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
Message-ID: <aJxjvh4sAcUOJT2V@uudg.org>
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
 <aJw3L7B7u5qAPOMz@e129823.arm.com>
 <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
 <aJxT2ie1wW2+/OCg@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJxT2ie1wW2+/OCg@e129823.arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Aug 13, 2025 at 09:59:06AM +0100, Yeoreum Yun wrote:
> +Ada Couprie Diaz
> 
> > Hi Yeoreum,
> >
> > Thank you for pointing it!
> >
> > On 8/13/25 3:56 PM, Yeoreum Yun wrote:
> > > Hi Yunseong,
> > >
> > >>
> > >> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > >> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
> > >> | preempt_count: 1, expected: 0
> > >> | RCU nest depth: 0, expected: 0
> > >> | Preemption disabled at:
> > >> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
> > >> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
> > >> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
> > >> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> > >> | Call trace:
> > >> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
> > >> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
> > >> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
> > >> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
> > >> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
> > >> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
> > >> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
> > >> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
> > >> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
> > >> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
> > >> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
> > >> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
> > >> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
> > >> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
> > >> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
> > >> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
> > >> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
> > >> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
> > >>
> > >>
> > >> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
> > >> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
> > >> removed code that previously avoided sleeping context issues when handling
> > >> debug exceptions:
> > >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587
> > >
> > > No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
> > > solves your splat since el0_brk64() doesn't call debug_exception_enter()
> > > by spliting el0/el1 brk64 entry exception entry.
> > >
> > > Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
> > > and it calls debug_exception_enter() disabling preemption and this makes
> > > your splat while handling brk excepttion from el0.
> > >
> >
> > Do you think a fix is necessary if this issue also affects the LTS kernel
> > before 6.17-rc1? As far as I know, most production RT kernels are still
> > based on the existing LTS versions.
> 
> IMHO, I think her patch should be backedported.

I also strongly suggest backporting Ada's patch series, as without them
using anything that resorts to debug exceptions (ptrace, gdb, ...) on
aarch64 with PREEMPT_RT enabled may result in a backtrace or worse.

Luis

> 
> [0]: https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/
> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun
> 
---end quoted text---


