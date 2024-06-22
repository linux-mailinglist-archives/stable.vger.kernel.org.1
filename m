Return-Path: <stable+bounces-54858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8B913238
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 08:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AE51C20B8C
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356E14B06B;
	Sat, 22 Jun 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L00B/iYX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36914AD19;
	Sat, 22 Jun 2024 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719036772; cv=none; b=ga+emqN5wLrIP8DMt/aV27xtg6DTyCyx887WvmkCI6p8weV2zoY7Ioe6syDkd95+DhycWdKrQni/3NfaS3pVWQw99231L5l5dqTh68nyWsM7H4orVlqtEi+tC/WRLD5KruhGWTAkspF/Z5ZJf5CJEkbfexwnxrU/sr5zxwO/gGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719036772; c=relaxed/simple;
	bh=p6PDmXigC5hUdyFCozlaD9uz4k5UZDZrhOi7GZpbu7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH7GtcvL7Tu7yER/M9+SWsqdYos0WXyU4vIhX51lLvxxwAs33Je4jCi6sfV0kOrwE6Qbe2Up3s4/MkuFWK1aeQZfkdjjrHm7mzhGIdbZazYy7twd28fG7OHKRxYah+hQV+n2iIBzG+cplZSqG91/yDUr5iPn9Z1j+qSEvhrEPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L00B/iYX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6da06ba24so20057945ad.2;
        Fri, 21 Jun 2024 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719036770; x=1719641570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krjZBqR5YUtpntS8j4/66w89iNnPL3e7qeE0XOy0iWk=;
        b=L00B/iYXcqvCIAvL0UJXvzmDUL37hSthzUI9ffrCM4k28LXlcs2wlwNMU9FrwnrbaX
         y3CtEGIrJ6qXzCDNR53mNCRtNu15HA8UhiRuNaXKQc603sOlmd7jCgG/Ei9HSVrSbLDQ
         b04+2G1/D/NIZunEk7If/BTWOmXDjbMbR3S1SYEC6bRqI65E4ID2laxDLKpDn3z+0t2G
         //MGHQeTE3nGs/BWrEIAEyJU6zI/2kk6fKPAclGYKWGprU0jxH7N0Imvt6ER0f783MwX
         ecRxAa3nk6lxdR/fqlQR6wr08P+yt0faS+ykYg5511wXeXEgErl7BdJ8c9zrsWz9wnTp
         U0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719036770; x=1719641570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krjZBqR5YUtpntS8j4/66w89iNnPL3e7qeE0XOy0iWk=;
        b=horGJeyJT9NHHEn46XenpXTRswxD5+VsaP9EtvGFKvA7u5Lv61I33P7ZQosKjFQ+k8
         qPkMwT+0jvB0rxByo1eZM6TwFF4+VJxnQv+WJMv/Fxbl7UDrqtSaegh/es0SDsKx2Y20
         av5D+vsywgyb8w5HO+R4LWneLMXBJIP2q30QXTW09slp5lcBR9lmc51XVcxNdLV5s64d
         irkNmVaviCRfZXyTTKijei7E/8QSYdha0uNz+mxaxKYDma5dnEY4uPnJb+m/eXMb7k2j
         tM4U9IBZPzBjwB8mbzy2T0QzuciVU+5QAuFhDruxcI5QAGHhOeueD2+kY/NsWd9TtTMo
         yhCw==
X-Forwarded-Encrypted: i=1; AJvYcCUbgLD2keh86SkFlBvt475KKpnkoyj16SS8wTBaOpEp9DUAbN1j+zL9eR6g5rRf/n3GYz8MrhEoHOY/7i20O+VPjTiPbAaylslnXIV6Lo8kzSD2Ua16wtu+pURCx2H0w3YYf2N5gxDuOc/aVDSFBFTWe7X6hF65MA0Lsgd8QV8kmohqOXAzXADNr2RXDuqthKO8LJ84MkbLTAG/bS8pITNA
X-Gm-Message-State: AOJu0Yy+Ql34ohD4u/eDuel4famWtVaXC7ZnXYbIU5QcYUSZdNZuf5ef
	L1x5LUB+E8722DJdhNwWsQU0+HOZ8ocfTqHmb+reZy74S+9XN4W6y2WXFg==
X-Google-Smtp-Source: AGHT+IGB5XwqfWtYBN6crK+WQ07ENNTrZ/be0kujOfF3fjm8luW20woMymDtrUMtTNGlDFm90ozJ4g==
X-Received: by 2002:a17:902:d4c9:b0:1f9:e3e8:456b with SMTP id d9443c01a7336-1f9e3e852cbmr54609045ad.4.1719036770233;
        Fri, 21 Jun 2024 23:12:50 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c608fsm23819705ad.157.2024.06.21.23.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 23:12:49 -0700 (PDT)
Message-ID: <80f28cfb-f287-419b-a448-b5967bc778ae@gmail.com>
Date: Sat, 22 Jun 2024 15:12:43 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ppbuk5246@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>, virtualization@lists.linux.dev
References: <20240622045701.8152-2-yskelg@gmail.com>
 <CAMArcTVgpAq8dC_u8eFE=asMWriWjNfYsmo6KVFi=tpHebdmCA@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAMArcTVgpAq8dC_u8eFE=asMWriWjNfYsmo6KVFi=tpHebdmCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Taehee,

On 6/22/24 2:50 오후, Taehee Yoo wrote:
> On Sat, Jun 22, 2024 at 1:58 PM <yskelg@gmail.com> wrote:
>>
>> From: Yunseong Kim <yskelg@gmail.com>
>>
> 
> Hi Yunseong,
> Thanks a lot for this work!

Thank you Taehee for reviewing our patch. It's greatly appreciated.

>> During qdisc initialization, qdisc was being set to noop_queue.
>> In veth_init_queue, the initial tx_num was reduced back to one,
>> causing the qdisc reset to be called with noop, which led to the kernel panic.
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


> I found a simple reproducer, please use the below command to test this patch.
> 
> echo 1 > /sys/kernel/debug/tracing/events/enable
> ip link add veth0 type veth peer name veth1

The perf event is activated by perf_fuzzer, and it's indeed a similar
environment with veth.

> In my machine, the splat looks like:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000130
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 1207 Comm: ip Not tainted 6.10.0-rc4+ #25
> 362ec22a686962a9936425abea9a73f03b445c0c
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> RIP: 0010:strlen+0x0/0x20
> Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84
> 00 00 00 00 00 90 90 90 90 9c
> RSP: 0018:ffffbed8435c7630 EFLAGS: 00010206
> RAX: ffffffff92d629c0 RBX: ffffa14100185c60 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff92d62840 RDI: 0000000000000130
> RBP: ffffffff92dc4600 R08: 0000000000000fd0 R09: 0000000000000010
> R10: ffffffff92c66c98 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000130 R15: ffffffff92d62840
> FS: 00007f6a94e50b80(0000) GS:ffffa1485f680000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000130 CR3: 0000000103414000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __die+0x20/0x70
> ? page_fault_oops+0x15a/0x460
> ? trace_event_raw_event_x86_exceptions+0x5f/0xa0
> ? exc_page_fault+0x6e/0x180
> ? asm_exc_page_fault+0x22/0x30
> ? __pfx_strlen+0x10/0x10
> trace_event_raw_event_qdisc_reset+0x4d/0x180
> ? synchronize_rcu_expedited+0x215/0x240
> ? __pfx_autoremove_wake_function+0x10/0x10
> qdisc_reset+0x130/0x150
> netif_set_real_num_tx_queues+0xe3/0x1e0
> veth_init_queues+0x44/0x70 [veth 24a9dd1cd1b1b279e1b467ad46d47a753799b428]
> veth_newlink+0x22b/0x440 [veth 24a9dd1cd1b1b279e1b467ad46d47a753799b428]
> __rtnl_newlink+0x718/0x990
> rtnl_newlink+0x44/0x70
> rtnetlink_rcv_msg+0x159/0x410
> ? kmalloc_reserve+0x90/0xf0
> ? trace_event_raw_event_kmem_cache_alloc+0x87/0xe0
> ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> netlink_rcv_skb+0x54/0x100
> netlink_unicast+0x243/0x370
> netlink_sendmsg+0x1bb/0x3e0
> ____sys_sendmsg+0x2bb/0x320
> ? copy_msghdr_from_user+0x6d/0xa0
> ___sys_sendmsg+0x88/0xd0
> 
> Thanks a lot!
> Taehee Yoo

I think this bug might cause inconvenience for developers working on net
devices driver in a virtual machine when they use tracing.

I'm appreciate your effort in reproducing it.

Warm Regards,
Yunseong Kim

