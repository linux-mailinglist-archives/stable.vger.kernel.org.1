Return-Path: <stable+bounces-56006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3357191B23C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 00:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6534283390
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2C1A2561;
	Thu, 27 Jun 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfVyvA2C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B9F50297;
	Thu, 27 Jun 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527585; cv=none; b=gzvpncykvNJ+rXrY96BYAJOcHgO9WjtIxUPv/xRfK4QqtI+5/w2wEAzj3tjXV1K9Y7NpaUaynPuGcll6DUKEFXJNhGbFNChnViMRC+t8f5AEnlsAsb26N31BSvnK4u+LSzDIm3GIXyJBCMtgLcDNiiIWVTcLJVdvuY4PRdlNnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527585; c=relaxed/simple;
	bh=i6m5qwwX44sa7BWWoVglfdkp0zY2C3NrwRGhJeG3J1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy/9AKKF+i7E/6vdqkTONTVtb+St4Za1aA5K6RAd/47mqtjQ+/prDRler7nvUz8Zv5EpSot5IVk3MeEjSye2KPBLEk/Z1LRX/xUpWJ5+FFbe1BHEzwAHoZAFvUSeKeE99RE7rTg6YAikW/1DPj966HZdkQ7t2Cg5AYnM49n1+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfVyvA2C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so27221a91.0;
        Thu, 27 Jun 2024 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719527583; x=1720132383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiKUQ7+sVtO2XmAIs87R1jV/vY8NV05dNAtCxHrW3FQ=;
        b=QfVyvA2CMt2/n2RVz1nbS3m/EjLBA0+itFeF5BcX/UwpVckpRzvoOxDPf0xN+DYAfn
         uMCzsOsyrobuC8hJxhGzocwncDGrfvG0VTSIKCO7LnmP+IPBMREsNKHkbq0P75mXMJDr
         vYx60B8J16Rs+KvPsR+O96D0EJEymIllWqsDso4SQXGs3gACtN7ykOpZh0dzUBF73Toz
         SWzfNzK7BVhS0nPAHCVp1DorTxmHbjTqFO2AnGs10Xw16tdgXRxbQxIYhd90n2sB9Jfz
         rlGuY8xHREmItboPi0Ndmcb+WvmBe50iPo7v6JO92jBPLdR0/nn8fkYCqMgblEfNc3jb
         1WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527583; x=1720132383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiKUQ7+sVtO2XmAIs87R1jV/vY8NV05dNAtCxHrW3FQ=;
        b=TxStxpurZYbH5ue59nX/kTe+948PtcpiPoptItoyegSs31oTw74icxa3kXk8snUTNj
         /IsQkX/fMHa8+TSk6Ytv3hXXyt82gHZRrNg3pgM07ApPgLLdPEqoxIsrloDnBPC2p1O1
         +L4TyUbWKhB863hGFu41GY2SHvn4cfDP7lDx++W+QU670v73FdCppJdTyEWeL0IJAoRS
         By8fHQNE069YGQLZBt7wxHXoKvr7YgHFkER02ciUiGP4jMjhMG9nXJqu+xY5bwdcqCDG
         iuOUrnefLSxBRs5a2mjS+xG5Mpd8zDrQcduzLteDpsetT6uyKxnlevhdItgWQYuoUOi3
         zKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQfEI4xmdAnXEdJ7dQC24LKLP0GCO9Mmm/Asg25PIQ8Lf65R/5R4/wunKwWchsiVErbjrW7JuBLa+y//7QrvC4iUzrDex/1vxJPxM7FLR/dmn/lzT4+UWUr96yyn6PKeINk5uMhjB7PeiDjfm2/V8yoZF2By1ft68pVkLnUnx2zubRLhphAZUo/QVf12X31hp1uGV8iQAV0LZPWRIWJrfK
X-Gm-Message-State: AOJu0YyzuHFpCjL6cfaxtLKjzHhim7OL2bLLhYG9wzOxu9pbaGKGz3aq
	bfIdhkAmvNpOhtvbO9dmf5DvbqRIO2+8eoWJTlaEZM1nu2Sj48MW
X-Google-Smtp-Source: AGHT+IFaeTR6OuM/ChfneRPlABRb7o1Rkppac9PHNFclCGSFGfgtKxOIouXSfXFtNY4qpLJgc+OWjw==
X-Received: by 2002:a17:90a:b115:b0:2c8:5129:417b with SMTP id 98e67ed59e1d1-2c8613e7a41mr15161268a91.31.1719527583209;
        Thu, 27 Jun 2024 15:33:03 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17c1bsm316559a91.5.2024.06.27.15.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 15:33:02 -0700 (PDT)
Message-ID: <85e47c59-4f57-4840-8e4d-24f27919e73d@gmail.com>
Date: Fri, 28 Jun 2024 07:32:56 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>,
 Austin Kim <austindh.kim@gmail.com>, MichelleJin <shjy180909@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pbuk5246@gmail.com, stable@vger.kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240624173320.24945-4-yskelg@gmail.com>
 <5ce3076ba0989a062f8e46e54a073b393ad22810.camel@redhat.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <5ce3076ba0989a062f8e46e54a073b393ad22810.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 6/27/24 6:14 오후, Paolo Abeni wrote:
> On Tue, 2024-06-25 at 02:33 +0900, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>>
>>  qdisc->dev_queue->dev <NULL> ->name
>>
>> This situation simulated from bunch of veths and Bluetooth disconnection
>> and reconnection.
>>
>> During qdisc initialization, qdisc was being set to noop_queue.
>> In veth_init_queue, the initial tx_num was reduced back to one,
>> causing the qdisc reset to be called with noop, which led to the kernel
>> panic.
>>
>> I've attached the GitHub gist link that C converted syz-execprogram
>> source code and 3 log of reproduced vmcore-dmesg.
>>
>>  https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740
>>
>> Yeoreum and I use two fuzzing tool simultaneously.
>>
>> One process with syz-executor : https://github.com/google/syzkaller
>>
>>  $ ./syz-execprog -executor=./syz-executor -repeat=1 -sandbox=setuid \
>>     -enable=none -collide=false log1
>>
>> The other process with perf fuzzer:
>>  https://github.com/deater/perf_event_tests/tree/master/fuzzer
>>
>>  $ perf_event_tests/fuzzer/perf_fuzzer
>>
>> I think this will happen on the kernel version.
>>
>>  Linux kernel version +v6.7.10, +v6.8, +v6.9 and it could happen in v6.10.
>>
>> This occurred from 51270d573a8d. I think this patch is absolutely
>> necessary. Previously, It was showing not intended string value of name.
>>
>> I've reproduced 3 time from my fedora 40 Debug Kernel with any other module
>> or patched.
>>
>>  version: 6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug
>>

>> [ 5301.595872] KASAN: null-ptr-deref in range [0x0000000000000130-0x0000000000000137]
>> [ 5301.595877] Mem abort info:
>> [ 5301.595881]   ESR = 0x0000000096000006
>> [ 5301.595885]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [ 5301.595889]   SET = 0, FnV = 0
>> [ 5301.595893]   EA = 0, S1PTW = 0
>> [ 5301.595896]   FSC = 0x06: level 2 translation fault
>> [ 5301.595900] Data abort info:
>> [ 5301.595903]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>> [ 5301.595907]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [ 5301.595911]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [ 5301.595915] [dfff800000000026] address between user and kernel address ranges
>> [ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
>> …
>> [ 5301.596076] CPU: 2 PID: 102769 Comm:
>> syz-executor.3 Kdump: loaded Tainted:
>>  G        W         -------  ---  6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug #1
>> [ 5301.596080] Hardware name: VMware, Inc. VMware20,1/VBSA,
>>  BIOS VMW201.00V.21805430.BA64.2305221830 05/22/2023
>> [ 5301.596082] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>> [ 5301.596085] pc : strnlen+0x40/0x88
>> [ 5301.596114] lr : trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
>> [ 5301.596124] sp : ffff8000beef6b40
>> [ 5301.596126] x29: ffff8000beef6b40 x28: dfff800000000000 x27: 0000000000000001
>> [ 5301.596131] x26: 6de1800082c62bd0 x25: 1ffff000110aa9e0 x24: ffff800088554f00
>> [ 5301.596136] x23: ffff800088554ec0 x22: 0000000000000130 x21: 0000000000000140
>> [ 5301.596140] x20: dfff800000000000 x19: ffff8000beef6c60 x18: ffff7000115106d8
>> [ 5301.596143] x17: ffff800121bad000 x16: ffff800080020000 x15: 0000000000000006
>> [ 5301.596147] x14: 0000000000000002 x13: ffff0001f3ed8d14 x12: ffff700017ddeda5
>> [ 5301.596151] x11: 1ffff00017ddeda4 x10: ffff700017ddeda4 x9 : ffff800082cc5eec
>> [ 5301.596155] x8 : 0000000000000004 x7 : 00000000f1f1f1f1 x6 : 00000000f2f2f200
>> [ 5301.596158] x5 : 00000000f3f3f3f3 x4 : ffff700017dded80 x3 : 00000000f204f1f1
>> [ 5301.596162] x2 : 0000000000000026 x1 : 0000000000000000 x0 : 0000000000000130
>> [ 5301.596166] Call trace:
>> [ 5301.596175]  strnlen+0x40/0x88
>> [ 5301.596179]  trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
>> [ 5301.596182]  perf_trace_qdisc_reset+0xb0/0x538
>> [ 5301.596184]  __traceiter_qdisc_reset+0x68/0xc0
>> [ 5301.596188]  qdisc_reset+0x43c/0x5e8
>> [ 5301.596190]  netif_set_real_num_tx_queues+0x288/0x770
>> [ 5301.596194]  veth_init_queues+0xfc/0x130 [veth]
>> [ 5301.596198]  veth_newlink+0x45c/0x850 [veth]
>> [ 5301.596202]  rtnl_newlink_create+0x2c8/0x798
>> [ 5301.596205]  __rtnl_newlink+0x92c/0xb60
>> [ 5301.596208]  rtnl_newlink+0xd8/0x130
>> [ 5301.596211]  rtnetlink_rcv_msg+0x2e0/0x890
>> [ 5301.596214]  netlink_rcv_skb+0x1c4/0x380
>> [ 5301.596225]  rtnetlink_rcv+0x20/0x38
>> [ 5301.596227]  netlink_unicast+0x3c8/0x640
>> [ 5301.596231]  netlink_sendmsg+0x658/0xa60
>> [ 5301.596234]  __sock_sendmsg+0xd0/0x180
>> [ 5301.596243]  __sys_sendto+0x1c0/0x280
>> [ 5301.596246]  __arm64_sys_sendto+0xc8/0x150
>> [ 5301.596249]  invoke_syscall+0xdc/0x268
>> [ 5301.596256]  el0_svc_common.constprop.0+0x16c/0x240
>> [ 5301.596259]  do_el0_svc+0x48/0x68
>> [ 5301.596261]  el0_svc+0x50/0x188
>> [ 5301.596265]  el0t_64_sync_handler+0x120/0x130
>> [ 5301.596268]  el0t_64_sync+0x194/0x198
>> [ 5301.596272] Code: eb15001f 54000120 d343fc02 12000801 (38f46842)
>> [ 5301.596285] SMP: stopping secondary CPUs
>> [ 5301.597053] Starting crashdump kernel...
>> [ 5301.597057] Bye!
>>
>> After applying our patch, I didn't find any kernel panic errors.
>>
>> We've found a simple reproducer
>>
>>  # echo 1 > /sys/kernel/debug/tracing/events/qdisc/qdisc_reset/enable
>>
>>  # ip link add veth0 type veth peer name veth1
>>
>>  Error: Unknown device type.

>>
>> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string")
>> Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
>> Cc: netdev@vger.kernel.org
>> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
>> Tested-by: Yunseong Kim <yskelg@gmail.com>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> I took the liberty of dropping the stable tag when applying, because as
> noted from Petro this patch will not address the issue on v6.7.10 nor
> on +v6.8, as they lack the upstream commit 2c92ca849fcc
> ("tracing/treewide: Remove second parameter of __assign_str()") and a
> we need slightly different fix on such trees, including the
> TP_fast_assign() chunk.
> 
> Could you please take care of such backport?
> 
> Thanks,
> 
> Paolo

Thank you Paolo for your hard work.

Yes, I'll try Pedro's review for +v6.7.10, test it and submit a backport
patch.

Link:
https://lore.kernel.org/all/06d0ea61-47ee-4e54-9dfa-a711c5bc07d0@mojatatu.com/


Warm regards,
Yunseong Kim


