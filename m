Return-Path: <stable+bounces-88137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CE9AFFCF
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911BB1F250D3
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EED1D9324;
	Fri, 25 Oct 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AN96QTd/"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAA1D47C7
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851280; cv=none; b=JWEY6wSx6pLeMSF9rsSwCufOubxnCoFL9F8N9+CBPBtR1l6hSoNGuxHNdUqbCxNyfVksUmKAM4N4wZcQCaaUmlXFyjfWhXCreUUzfh31joHRhLf9Gc6ueU2CR+9kss1/TAJnB8RkFOX2T0A+6JoGShSrjIUkIJItEZbM/RJxWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851280; c=relaxed/simple;
	bh=7dpLDTiOti2gkdi3/Z2irtgSl/ub1h64zik0tJaS42Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WIbojvvUSPQuGSj80vN2jbaju/Zf6qMYOzX6cHhj1+ynbjOQPTBqRShETEoEJNumWsljGgd0p+q/gzoNvm+NlJX3waysfpuH6qw9CrhG2Rl4XgrCYQ/o1DIsapWHMeOrFhFjoluICJRq42vQ5EgqJyZEACRBcDns3J7GROemWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AN96QTd/; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6oAjO006920;
	Fri, 25 Oct 2024 11:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/NjitP+EsJbsLPMXwvV3a07N9NXtXF6fLkWZSKiMJ6I=; b=AN96QTd/vW0OhgK4
	QsrEbqTS3o5TTmnXPGIOIqPwbG2TzZBBcothvJKSkSiL9YU1Ztt8Ap9L2DbhZ4sJ
	tBoRoRz4i9oFbjj3IOStRJsscbpB6cb2FxpXSZ1JnWE49msWiWszL9uFJcnYcJzX
	XtW9PB74Zm1uSIhSAVxydnW5HH/F2gopfQuGescjig7qnXX8jwzWjsxmeO+7gRGa
	GwK7QFZZ9Dvy9VQT9Xar9PCN+pYnyUjzLcRN+16TqFYq8g0cl2OfN6BbO2Ygha3f
	27SMGQKN4VMGQqlTGo8VJNbUGk2nEOerMszkIbfjJp6u1snt0b2UtwkxCmJj58kY
	WJLv8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42em4cn7ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 11:27:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 344E24002D;
	Fri, 25 Oct 2024 11:25:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 136B225F1B4;
	Fri, 25 Oct 2024 11:24:35 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 25 Oct
 2024 11:24:34 +0200
Message-ID: <f3856158-10e6-4ee8-b4d5-b7f2fe6d1097@foss.st.com>
Date: Fri, 25 Oct 2024 11:24:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Linus Walleij <linus.walleij@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
CC: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko
	<glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov
	<dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Antonio Borneo
	<antonio.borneo@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com>
 <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
 <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/24/24 23:58, Linus Walleij wrote:
> Hi Clement,
> 
> I saw I missed to look closer at the new bug found in ext4
> on the STM32:
> 
> On Mon, Oct 21, 2024 at 2:12 PM Clement LE GOFFIC
> <clement.legoffic@foss.st.com> wrote:
> 
>> Perhaps not related with this topic but as in the backtrace I am getting
>> some keyword from our start exchange, I dump the crash below.
>> If this backtrace is somehow related with our issue, please have a look.
> (...)
>> [ 1439.351945] PC is at __read_once_word_nocheck+0x0/0x8
>> [ 1439.356965] LR is at unwind_exec_insn+0x364/0x658
> (...)
>> [ 1440.333183]  __read_once_word_nocheck from unwind_exec_insn+0x364/0x658
>> [ 1440.339726]  unwind_exec_insn from unwind_frame+0x270/0x618
>> [ 1440.345352]  unwind_frame from arch_stack_walk+0x6c/0xe0
>> [ 1440.350674]  arch_stack_walk from stack_trace_save+0x90/0xc0
>> [ 1440.356308]  stack_trace_save from kasan_save_stack+0x30/0x4c
>> [ 1440.362042]  kasan_save_stack from __kasan_record_aux_stack+0x84/0x8c
>> [ 1440.368473]  __kasan_record_aux_stack from task_work_add+0x90/0x210
>> [ 1440.374706]  task_work_add from scheduler_tick+0x18c/0x250
>> [ 1440.380245]  scheduler_tick from update_process_times+0x124/0x148
>> [ 1440.386287]  update_process_times from tick_sched_handle+0x64/0x88
>> [ 1440.392521]  tick_sched_handle from tick_sched_timer+0x60/0xcc
>> [ 1440.398341]  tick_sched_timer from __hrtimer_run_queues+0x2c4/0x59c
>> [ 1440.404572]  __hrtimer_run_queues from hrtimer_interrupt+0x1bc/0x3a0
>> [ 1440.411009]  hrtimer_interrupt from arch_timer_handler_virt+0x34/0x3c
>> [ 1440.417447]  arch_timer_handler_virt from
>> handle_percpu_devid_irq+0xf4/0x368
>> [ 1440.424480]  handle_percpu_devid_irq from
>> generic_handle_domain_irq+0x38/0x48
>> [ 1440.431618]  generic_handle_domain_irq from gic_handle_irq+0x90/0xa8
>> [ 1440.437953]  gic_handle_irq from generic_handle_arch_irq+0x30/0x40
>> [ 1440.444094]  generic_handle_arch_irq from __irq_svc+0x88/0xc8
>> [ 1440.449920] Exception stack(0xde803a30 to 0xde803a78)
>> [ 1440.454914] 3a20:                                     de803b00
>> 00000000 00000001 000000c0
>> [ 1440.463141] 3a40: e5333f40 de803ba0 de803bd0 00000001 e5333f40
>> de803b00 c1241d90 bad0075c
>> [ 1440.471262] 3a60: c20584b8 de803a7c c0114114 c0113850 200f0013 ffffffff
>> [ 1440.477959]  __irq_svc from unwind_exec_insn+0x4/0x658
>> [ 1440.483078]  unwind_exec_insn from call_with_stack+0x18/0x20
> 
> This is hard to analyze without being able to reproduce it, but it talks
> about the stack and Kasan and unwinding, so could it (also) be related to the
> VMAP:ed stack?
> 
> Did you try to revert (or check out the commit before and after)
> b6506981f880 ARM: unwind: support unwinding across multiple stacks
> to see if this is again fixing the issue?
I Linus,

Yes, I've tried to revert this particular commit on top of your last 
patches but I have some conflicts inside arch/arm/kernel/unwind.c

