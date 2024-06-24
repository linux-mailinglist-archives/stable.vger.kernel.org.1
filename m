Return-Path: <stable+bounces-55050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95D9152F5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E4D282409
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79019D88D;
	Mon, 24 Jun 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tbrou/gf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901D19B5B3
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244547; cv=none; b=ShJ2bbGA26FLfRuCeMIyJkJlZx3ewn3mCOTZ/VFffJ5hd9/o1HSZd/7ubLltkPyZQLpK5TmckEI+bDURIGJdYICduuz3p1dpx4yhnrxEknqFGil9Dko0if4YC+nh+PN/trYuQfjMKixYwLEZgwIl6hOFtBIFfCrDEu0T0qA1HUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244547; c=relaxed/simple;
	bh=M13v60wz03/RaENqixMvn59Tbe/Ob34ITxVwJmLNoP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkxv884OEFhbSBA1zZ4UAQ5I87vdnqvOiopCV5e5LFrtZRDIvFMBstJ2KA3i86phZnwnpX8vReNZRNPa68G/FkS3nLDGQVUnsIbWVY1Tkm3ZViz4ByopiToqo2ZZevmETXsew/+0jz1hM3DAe+0zTjg2HHlHfxVMBR10bFgxTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tbrou/gf; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7180308e90bso1873006a12.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1719244544; x=1719849344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSa60CmCQJ4dl4BmMG72cFcv8f2vUWrGLsTo+sMDqyo=;
        b=tbrou/gfJy4mxRgTOWHf1YFOXdvRAEh63UnUxdfMbatcaVP1XDZ+Sg8LtW4WM4r635
         kkPlSo55v5XVpa+qyFgfHy/RuCUEHKQ+eew+fSZhcbczhYCMd+2VuJdKFwVmbnscKC6U
         YUYKZzLYmIUyGzqQ6rJ47BbzykGXtIcO+14UPsZnJRl1b3RuqsqWPetLnXS6xflcJ93t
         S+ATXMQrrzb19btEGhrvPEVNT9nI8N0Uy93ZQlttOFQ5El6HbGduOJbTNiWBO+/yHbgX
         QQGVAWzlPVk+49BitrFuN3NUlbbjbGMkSOKWuwU8shH+siMV+GTqM8d/fWJAg3zcZApS
         p/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244544; x=1719849344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSa60CmCQJ4dl4BmMG72cFcv8f2vUWrGLsTo+sMDqyo=;
        b=wAS5PVdu0+TZPxFfdvWGqkT2lp7sAwb07Jc6fymXxIIYKLKvaqAl7BN2yazJJAJRLX
         PZZh2EWCNPAwalLXy/fNDiTT0HdVRZcN5NyDP6c4nFXegK+Hg64I88uYBULPi5AhX0wa
         K0+p9v2CARbbupdadNLQae+krZEdXyWw/Sc8pJ5hf94HgtMV+cJSOvwc5sp1aYIu+oeU
         DiguX88+hy/tohln4zYT+02G3dJzqrkfWlP0Ay/ahfIgZh1rbqcbKur03BMaykzdip71
         Cw3Su/DHYQpyoYTIZlQFs2WectMbOfMgbH+oZbebyoifVwACb4KrdVhkBFoc4UJxNXYt
         5fTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHAoGOjf3qRGLShoFFPWfa0UdGMWhDfqrNwWkB29pJxRcBiXwYrtvC0GC9A4PGnLTSSFJvtoapctd7Yytxx2AyKtsm18d2
X-Gm-Message-State: AOJu0YyzSDMxdYQhHanu07mdeoTvXYMpjnWPKQZQWbcXHhWCD4dPwNM6
	hBuYTHMyAkSFnCT9JP8hqyCoyXYBE6gVWPJUfUk8uvG+5OwernOyBo4UZZLaUA==
X-Google-Smtp-Source: AGHT+IGWSqKXeWAS7XC2r6DZ5qQGQVJpW37u25YfreTKY+aF5FXyufWBMeynMiFDhYNumhLeHetYBg==
X-Received: by 2002:a17:90b:4a82:b0:2c7:af6f:5e52 with SMTP id 98e67ed59e1d1-2c86124cbd9mr3414266a91.19.1719244543965;
        Mon, 24 Jun 2024 08:55:43 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:8ef6:cdff:1677:b083? ([2804:14d:5c5e:44fb:8ef6:cdff:1677:b083])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff8dcasm8999645a91.1.2024.06.24.08.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 08:55:43 -0700 (PDT)
Message-ID: <06d0ea61-47ee-4e54-9dfa-a711c5bc07d0@mojatatu.com>
Date: Mon, 24 Jun 2024 12:55:35 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Yunseong Kim <yskelg@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ppbuk5246@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20240622045701.8152-2-yskelg@gmail.com>
 <fa8e452b-ad37-482b-8d9b-bc8b4cad0ff9@mojatatu.com>
 <d7b67e36-adee-4abc-b4c4-0548333ac90a@gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <d7b67e36-adee-4abc-b4c4-0548333ac90a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/06/2024 12:43, Yunseong Kim wrote:
> Hi Pedro,
> 
> On 6/25/24 12:12 오전, Pedro Tammela wrote:
>> On 22/06/2024 01:57, yskelg@gmail.com wrote:
>>> From: Yunseong Kim <yskelg@gmail.com>
>>>
>>> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>>>
>>>    qdisc->dev_queue->dev <NULL> ->name
>>>
>>> [ 5301.595872] KASAN: null-ptr-deref in range
>>> [0x0000000000000130-0x0000000000000137]
>>> [ 5301.595877] Mem abort info:
>>> [ 5301.595881]   ESR = 0x0000000096000006
>>> [ 5301.595885]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [ 5301.595889]   SET = 0, FnV = 0
>>> [ 5301.595893]   EA = 0, S1PTW = 0
>>> [ 5301.595896]   FSC = 0x06: level 2 translation fault
>>> [ 5301.595900] Data abort info:
>>> [ 5301.595903]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>>> [ 5301.595907]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [ 5301.595911]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [ 5301.595915] [dfff800000000026] address between user and kernel
>>> address ranges
>>> [ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
>>> Link:
>>> https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
>>> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save
>>> qdisc_dev() as a string")
>>> Cc: netdev@vger.kernel.org
>>> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
>>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>>> ---
>>>    include/trace/events/qdisc.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
>>> index f1b5e816e7e5..170b51fbe47a 100644
>>> --- a/include/trace/events/qdisc.h
>>> +++ b/include/trace/events/qdisc.h
>>> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>>>        TP_ARGS(q),
>>>          TP_STRUCT__entry(
>>> -        __string(    dev,        qdisc_dev(q)->name    )
>>> +        __string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_queue")
>>>            __string(    kind,        q->ops->id        )
>>>            __field(    u32,        parent            )
>>>            __field(    u32,        handle            )
>>
>> You missed the __assign_str portion (see below). Also let's just say
>> "(null)" as it's the correct device name. "noop_queue" could be misleading.
> 
> Thanks for the code review Pedro, I agree your advice.
> 
>> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
>> index 1f4258308b96..f54e0b4dbcf4 100644
>> --- a/include/trace/events/qdisc.h
>> +++ b/include/trace/events/qdisc.h
>> @@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
>>          TP_ARGS(q),
>>
>>          TP_STRUCT__entry(
>> -               __string(       dev,            qdisc_dev(q)->name      )
>> +               __string(       dev,            qdisc_dev(q) ?
>> qdisc_dev(q)->name : "(null)"    )
>>                  __string(       kind,           q->ops->id              )
>>                  __field(        u32,            parent                  )
>>                  __field(        u32,            handle                  )
>>          ),
> 
> It looks better to align the name with the current convention.
> 
> Link:
> https://lore.kernel.org/linux-trace-kernel/20240222211442.634192653@goodmis.org/
> 
>>          TP_fast_assign(
>> -               __assign_str(dev, qdisc_dev(q)->name);
>> +               __assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name :
>> "(null)");
>>                  __assign_str(kind, q->ops->id);
>>                  __entry->parent = q->parent;
>>                  __entry->handle = q->handle;
>>
>>
> 
> The second part you mentioned, Steve recently worked on it and changed it.
> 
> Link:
> https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/

Oh!

> 
> If it hadn't, I don't think I would have been able to prevent the panic
> by just applying my patch.

But you must be careful with the backports.

In any case, perhaps send another patch to net-next updating the new 
conventions there and use the 'old convention' for the bug fix?

