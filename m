Return-Path: <stable+bounces-169340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80747B242F9
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AF66243C4
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8DF2DE6E4;
	Wed, 13 Aug 2025 07:42:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7A2D3204
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070952; cv=none; b=rsSfxyGr2YTkldhfXSxnK+ewfhLJ9cq68oScgkdVd1rPekd+U0n/K+qmZO0oJ1uxxn0QWXK35sCxCpf+AUPxUdOIWSmC57WgSg51OP2v3QcumpVAh8WK+ZGT4lUHqKV3ke3BipTH3Isy/w5HwGWi6poWt4BYIhY2vePUzbZ0OpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070952; c=relaxed/simple;
	bh=HdN0XMRFktS6aaDUEEo85Pl2LmbyxkiHp3apivFUIDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhWxvz4LezqAWIR0hIzfJUDDm9r9YYkCDPV+/QbJoMdPC6tbzusm2YGGVtlROfoPC2LQ0ZhqW2PqlZN0jJxULft5x6UVJ9naGrRshUcoWFe8iMFEvAmmeku7GOJUaLBUxWvBsqrVPpRP0zfVPus6bK26PKNpG4kJj/IgnswaLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73de140046eso463884b3a.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 00:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070950; x=1755675750;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpiYdySHhrFSLFvt+ZXWlE3IvVelgPZB7slyigr8p3I=;
        b=Omazhgc8XZ/huK65PO/VrhAaar4XvBxKwyV2gbrwJ/Yo8AxBr8nC6+l2Eda5NkbmMR
         Juis8A3lzOTQMFXcFkt0wBIns6oWnjaswZI1BPwIW9JiJmLF50VTmevNCR3jLD91905m
         XLjxxhqxuo84I4JiqsUPxk9KOQCPbnfQLI85qsMJsgj3fDQ2JW4DvLD7Gv2QetnVwg+n
         HsOnsbYQ9XOreGI5UBcxkCulaX3l5dq33Y2dxPA2aXx2XI99L9srQkFT2izq7UTk0GSX
         dczgKB1TSMzwd2VrP81dP81YZbcOz5eKwUxp1vLT0syBgdUpedTO8KTDmTOeSX2VvstD
         zkoA==
X-Forwarded-Encrypted: i=1; AJvYcCWpV213TfLSb9WLQsNaxsQSc2dPda6xEK4Ye829ZayUo9geyY958JDhWc7kKvA+HJvyetjSqug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpArcIJ1kOEpbvaTKCn4UCExbt31i2+EOu6vhiUg91diyV/Udz
	2HW5JDE6Y2weJ2DsHZGuZZAdg7vSIF9qqdT7oVtqOSIafsBZU3wwurdQ
X-Gm-Gg: ASbGncv3onfn/xGr5yMi/iccXPHLnGdHRSZibb5Wos3+pIDEyMAm74aSXnDXQtBLrQX
	74W6V0VMTDM4QXBLu5FuoB7ANzxnXo+7/M7NHlH7k9wG1qNM+2eByFtHvAxSzMGjqgz8GOlONeq
	MLvhA3+WrUIf2w8Nz9RF8GDPonFTx6i6UNjkwAvTilDxU7iVMB9kS1JnrrMDXTltvF/wms5OsrZ
	UddpwCDETN+HwXu2CkyTlpNevNQPgi0eLjxcWBGZEo0OuxMAj4jR3Q/Qg74+JYTpzahI9WIJ50I
	iOKqh801ZJ3tcv107OjJDJHYd5cBZdNxlJNR3b9+eRx/p8C2/gwapU8VqDaAjngRAeJsWrkByc6
	uQ+JCH4fGKSVPskHE3b7cnCjtphsb/CLT
X-Google-Smtp-Source: AGHT+IFyRulOk2yEiytouE8c1ifGVIrW23F74ZO8AVJB/Bv0ruH/ZKMqF0l+0q/T60XygCbCXcCjWw==
X-Received: by 2002:a17:90b:224f:b0:31f:23f0:2df8 with SMTP id 98e67ed59e1d1-321d0ecb6aamr1294794a91.6.1755070950304;
        Wed, 13 Aug 2025 00:42:30 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b429920ab6dsm11951099a12.58.2025.08.13.00.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 00:42:29 -0700 (PDT)
Message-ID: <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
Date: Wed, 13 Aug 2025 16:42:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Austin Kim <austindh.kim@gmail.com>,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 stable@vger.kernel.org
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
 <aJw3L7B7u5qAPOMz@e129823.arm.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <aJw3L7B7u5qAPOMz@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yeoreum,

Thank you for pointing it!

On 8/13/25 3:56 PM, Yeoreum Yun wrote:
> Hi Yunseong,
> 
>>
>> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
>> | preempt_count: 1, expected: 0
>> | RCU nest depth: 0, expected: 0
>> | Preemption disabled at:
>> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
>> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
>> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
>> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
>> | Call trace:
>> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
>> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
>> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
>> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
>> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
>> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
>> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
>> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
>> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
>> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
>> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
>> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
>> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
>> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
>> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
>>
>>
>> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
>> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
>> removed code that previously avoided sleeping context issues when handling
>> debug exceptions:
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587
> 
> No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
> solves your splat since el0_brk64() doesn't call debug_exception_enter()
> by spliting el0/el1 brk64 entry exception entry.
> 
> Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
> and it calls debug_exception_enter() disabling preemption and this makes
> your splat while handling brk excepttion from el0.
> 

Do you think a fix is necessary if this issue also affects the LTS kernel
before 6.17-rc1? As far as I know, most production RT kernels are still
based on the existing LTS versions.

> 
> --
> Sincerely,
> Yeoreum Yun

Thank you,
Yunseong


