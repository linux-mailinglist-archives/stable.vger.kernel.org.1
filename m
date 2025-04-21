Return-Path: <stable+bounces-134761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A2A94CAB
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5515170B7F
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CE256C93;
	Mon, 21 Apr 2025 06:41:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414F7462
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745217673; cv=none; b=sjWMudRYiq66sdm7vIBOrFODkYi0wbzZUAKGjphmYZCx8KDKKRHdP6/HXHriUHduN8NWHFKYVTAWXUOqRCSG+Dzdb/o7Ae4Y+R65w1sB3RCUZrNJISuS2xOIf5rhpEJCh39/g9NKxl75kJ2XwBnmGRGZeund7I6STiT4gQzrB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745217673; c=relaxed/simple;
	bh=K5TwJ1oEtj2elLGypf5JBsd9l8ofZlSRIOxGsVW/jlE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:CC:
	 In-Reply-To:Content-Type; b=qFco7eYQysGbTI/Lxf0zkb0NYB1PbOiQ0568wgJOh4AEPPa7cqsRIdzaYXKNwraSZBfQYOOsnpAoeHDG8G0evVOvQAh9i5UFw01jgMhkKGK0fpvXGphlufy6ZPdnBlaDfp28tcbhmcBRRF4nR9mEn4PK4ZMuloKbVLx2EHCsrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Zgwjx69rCzsSj9;
	Mon, 21 Apr 2025 14:40:53 +0800 (CST)
Received: from kwepemg100004.china.huawei.com (unknown [7.202.181.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 53EAC140119;
	Mon, 21 Apr 2025 14:41:08 +0800 (CST)
Received: from [10.67.111.137] (10.67.111.137) by
 kwepemg100004.china.huawei.com (7.202.181.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 14:41:07 +0800
Message-ID: <dc1afc3c-2135-441f-a39f-e975cc3204f5@huawei.com>
Date: Mon, 21 Apr 2025 14:41:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: perf hardware breakpoint pc value mismatch
Content-Language: en-US
From: "liaochen (A)" <liaochen4@huawei.com>
To: <stable@vger.kernel.org>
References: <42fa27ef-1807-4fd0-aaf0-1a1ceb1db10e@huawei.com>
CC: <regressions@lists.linux.dev>
In-Reply-To: <42fa27ef-1807-4fd0-aaf0-1a1ceb1db10e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100004.china.huawei.com (7.202.181.21)

On 2025/4/14 19:44, liaochen (A) wrote:
> 
> Hi all,
> 
> We found the following issue with Linux v6.12-rc7 on KunPeng920 
> platform. A very low frequency problem of pc value mismatch occurs when 
> using perf hardware breakpoints to trigger a signal handler and 
> comparing pc from u_context with its desired value.
> 
> Attached please find the reproducer for this issue. It applies perf 
> events to set a hardware breakpoint to an address while binding a signal 
> to the perf event fd. When stepping into the breakpoint address, the 
> signal handler compares pc value copied from signal ucontext with the 
> real breakpoint address and see if there is a mismatch.
> 
> While looking into the flow of execution:
> // normal flow of exe:
>             a.out-19844   [038] d...  8763.348609: 
> hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 0
> // breakpoint exception:
>             a.out-19844   [038] d...  8763.348611: do_debug_exception: 
> ec: 0, pc: 400c6c, pstate: 20001000
>             a.out-19844   [038] d...  8763.348611: breakpoint_handler: 
> perf bp read: 400c6c
> // send signal:
>             a.out-19844   [038] d.h.  8763.348613: send_sigio_to_task 
> <-send_sigio
>             a.out-19844   [038] d.h.  8763.348614: <stack trace>
>   => send_sigio_to_task
>   => send_sigio
>   => kill_fasync_rcu
>   => kill_fasync
>   => perf_event_wakeup
>   => perf_pending_event
>   => irq_work_single
>   => irq_work_run_list
>   => irq_work_run
>   => do_handle_IPI
>   => ipi_handler
>   => handle_percpu_devid_fasteoi_ipi
>   => __handle_domain_irq
>   => gic_handle_irq
>   => el0_irq_naked
>             a.out-19844   [038] d.h.  8763.348614: send_sigio_to_task: 
> step in with signum 38
>             a.out-19844   [038] d.h.  8763.348615: send_sigio_to_task: 
> will do_send_sig_info 38
> // kernel signal handling:
>             a.out-19844   [038] ....  8763.348616: do_notify_resume: 
> thread_flags 2097665, _TIF_SIGPENDING 1, _TIF_NOTIFY_SIGNAL40
>             a.out-19844   [038] ....  8763.348617: setup_sigframe: 
> restore sig: 400c6c
> // single step exception:
>             a.out-19844   [038] d...  8763.348619: do_debug_exception: 
> ec: 1, pc: 400988, pstate: 20001000
>             a.out-19844   [038] d...  8763.348621: 
> hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 1
> 
> // abnormal flow of exe:
>             a.out-19844   [084] d...  8763.782103: 
> hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 0
> // breakpoint exception:
>             a.out-19844   [084] d...  8763.782104: do_debug_exception: 
> ec: 0, pc: 400c6c, pstate: 20001000
> // single step exception:
>             a.out-19844   [084] d...  8763.782105: breakpoint_handler: 
> perf bp read: 400c6c
>             a.out-19844   [084] d...  8763.782107: do_debug_exception: 
> ec: 1, pc: 400c70, pstate: 20001000
> // send signal:
>             a.out-19844   [084] d.h.  8763.782108: send_sigio_to_task 
> <-send_sigio
>             a.out-19844   [084] d.h.  8763.782109: <stack trace>
>   => send_sigio_to_task
>   => send_sigio
>   => kill_fasync_rcu
>   => kill_fasync
>   => perf_event_wakeup
>   => perf_pending_event
>   => irq_work_single
>   => irq_work_run_list
>   => irq_work_run
>   => do_handle_IPI
>   => ipi_handler
>   => handle_percpu_devid_fasteoi_ipi
>   => __handle_domain_irq
>   => gic_handle_irq
>   => el0_irq_naked
>             a.out-19844   [084] d.h.  8763.782110: send_sigio_to_task: 
> step in with signum 38
>             a.out-19844   [084] d.h.  8763.782110: send_sigio_to_task: 
> will do_send_sig_info 38
> // kernel signal handling:
>             a.out-19844   [084] ....  8763.782111: do_notify_resume: 
> thread_flags 513, _TIF_SIGPENDING 1, _TIF_NOTIFY_SIGNAL40
>             a.out-19844   [084] ....  8763.782113: setup_sigframe: 
> restore sig: 400c70
>             a.out-19844   [084] d...  8763.782115: 
> hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 1
> 
> Kernel sends this signal to task through pushing a perf_pending_event 
> (which sends the signal) in irq_work_queue then triggering an IPI to let 
> kernel handle this pended task.
> seems that when mismatch occurs, the IPI does not preempt the breakpoint 
> exception it should preempt, causing no pending signals to be handled. 
> In this way, there is no pending signals in do_notify_resume and kernel 
> will not set up signal frame with correct pc value.
> 
> Thanks,
> Chen
ping

Thanks,
Chen

