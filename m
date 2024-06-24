Return-Path: <stable+bounces-55051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43191532D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CE71C22773
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970419DF5F;
	Mon, 24 Jun 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOh+5xXe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F619DF47;
	Mon, 24 Jun 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245423; cv=none; b=MPr94NQa6jGvM8rDTd4DWoEK0CJKhg79F9VeuNi0h1kemvxUIW5FV9Eue9I4/TpNiiZx/IrwKVGsc+qzK3fhshCtqqBqpJPyfgPBpsDqp4H6gaY1oZMiVpmR009D+JJEVHjadEzVY1HZVg93ITQwcASECw6PDPtpSasVFQJYihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245423; c=relaxed/simple;
	bh=cl4MPGLdmcHEoORjY2x+DVBjrLjLbNFLHu4q6u73Y3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrWfxAxM5pvwPVQiAsmbdmp905+zZHfAtLqXx+r+/HgbM7SdClaTWoZPewqkpXKhCMrsseGGFZirdLCae2BmbAQ7IQlpgAc/sE8wCvFQqjPvKfonEdOWVDLyShbOYTiwqgjRYmpkTZlg30kigm1YtWXdS4bTM3UnKD9fMuJ0b0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOh+5xXe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47f07aceaso35086975ad.0;
        Mon, 24 Jun 2024 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719245421; x=1719850221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttX0yp76l2xnXq8JSAtn3cUDBQPLpo3WhU7vnTaPql0=;
        b=IOh+5xXeep6GqTt8+Bf8TYFebJn6KOwkpQ3T2OmjG83wZWPWQ2FF/mQzg/d3c7W9LJ
         GWuAWDhSSgV5vhF0yhB18c0aU1JzRtfM3aQg0tiSqgwxaLCsMD/Dbs3hBdh0yjOjawsR
         WM5Z35zoThIRxLmBT1LjozK5OQinD2VcNnxN5JaIMQBjsROerBglbQXhCXylmzOrPoXN
         cwZHTa0Nj6bMK77xQMTEdc0lopxRm+eQJ70yZKhnNSRQw+l+ChpeHFfTBFUN1GBx3AnX
         WF1JVPAYvmf9UlYQwjg9WwWGSgSpTi56Hy8npx/k6AC+marrhPnCR3B45IhrcAmS8rT+
         JKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245421; x=1719850221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttX0yp76l2xnXq8JSAtn3cUDBQPLpo3WhU7vnTaPql0=;
        b=oZiQIcfd/D6OWM7PTvJ+VrLp68W3MbwtQpruTzS5wJ6HDF/INNVP0JV2eRPenPx1Xr
         x+7jwN5DuAOKRqc5MdaGPDlLrdumgHHt0KbgENPOieOVE2gPRktXgLYhZ5xxyGuhAcPO
         1wgvDTt6JpYiWOknp05KV8LuPQ2w86zALo5gIHctXxWqyXvq+OhEVRStsSCxLiLCcjRr
         HYYo3xtoFfmP0QLzsHz28fW0VGIk4gDpNF0Wxq1ObvWKcl5E7Poh460Xttplweb+S169
         yQxtINiqyP0TA8e1jTNnE/xmLS4sw9WOhLVNvcL6fH0MU0O4a8iyhdd+rjiNb4nN6CTo
         h+mA==
X-Forwarded-Encrypted: i=1; AJvYcCUGa8y6sYcQYXvHz3u3Z1TrgPnQlROzBcHvhyvEGqfPdGKPcka4FQ21HWQu+E2ekegRUC6VeoiaofVOx1qs/C5vpPx6zIToZLtbF9q4KvPrDSQYiivLASWaTcIKQWGdklu9LtaZJ7UAaGWuNPf+/4ScbxR7GA1jeLVsnJGuNofghICpNs7hy3gf
X-Gm-Message-State: AOJu0YynKu8mYJ5QmBVBpeke5cmPcdIiAc3qpPL4/H2K3gp4WcQ52E7C
	Ocn14S0R2szQ/PrGBYxdlNsiAkT2C20YEz6p3cqSKGpUqahXMVQz
X-Google-Smtp-Source: AGHT+IH/OtHRU1nurIROIfMExtRTyvwaJeKWPLDLQDTrv8mTAiL7uD5HR4vojTvfD+SDzijq49zP+w==
X-Received: by 2002:a17:902:d4c7:b0:1fa:128c:4315 with SMTP id d9443c01a7336-1fa15937ac6mr57783425ad.44.1719245420780;
        Mon, 24 Jun 2024 09:10:20 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9f6e36df3sm59690285ad.17.2024.06.24.09.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 09:10:20 -0700 (PDT)
Message-ID: <2a28004a-161f-4cde-9d1c-7b779333e666@gmail.com>
Date: Tue, 25 Jun 2024 01:10:14 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Pedro Tammela <pctammela@mojatatu.com>
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
 <06d0ea61-47ee-4e54-9dfa-a711c5bc07d0@mojatatu.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <06d0ea61-47ee-4e54-9dfa-a711c5bc07d0@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 6/25/24 12:55 오전, Pedro Tammela wrote:
> On 24/06/2024 12:43, Yunseong Kim wrote:
>> Hi Pedro,
>>
>> On 6/25/24 12:12 오전, Pedro Tammela wrote:
>>> On 22/06/2024 01:57, yskelg@gmail.com wrote:
>>>> From: Yunseong Kim <yskelg@gmail.com>
>>>>
>>>> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>>>>
>>>>    qdisc->dev_queue->dev <NULL> ->name
>>>>
>>>> [ 5301.595872] KASAN: null-ptr-deref in range
>>>> [0x0000000000000130-0x0000000000000137]
>>>> [ 5301.595877] Mem abort info:
>>>> [ 5301.595881]   ESR = 0x0000000096000006
>>>> [ 5301.595885]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [ 5301.595889]   SET = 0, FnV = 0
>>>> [ 5301.595893]   EA = 0, S1PTW = 0
>>>> [ 5301.595896]   FSC = 0x06: level 2 translation fault
>>>> [ 5301.595900] Data abort info:
>>>> [ 5301.595903]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>>>> [ 5301.595907]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>> [ 5301.595911]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>> [ 5301.595915] [dfff800000000026] address between user and kernel
>>>> address ranges
>>>> [ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
>>>> Link:
>>>> https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
>>>> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save
>>>> qdisc_dev() as a string")
>>>> Cc: netdev@vger.kernel.org
>>>> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
>>>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>>>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>>>> ---
>>>>    include/trace/events/qdisc.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/trace/events/qdisc.h
>>>> b/include/trace/events/qdisc.h
>>>> index f1b5e816e7e5..170b51fbe47a 100644
>>>> --- a/include/trace/events/qdisc.h
>>>> +++ b/include/trace/events/qdisc.h
>>>> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>>>>        TP_ARGS(q),
>>>>          TP_STRUCT__entry(
>>>> -        __string(    dev,        qdisc_dev(q)->name    )
>>>> +        __string(dev, qdisc_dev(q) ? qdisc_dev(q)->name :
>>>> "noop_queue")
>>>>            __string(    kind,        q->ops->id        )
>>>>            __field(    u32,        parent            )
>>>>            __field(    u32,        handle            )
>>>
>>> You missed the __assign_str portion (see below). Also let's just say
>>> "(null)" as it's the correct device name. "noop_queue" could be
>>> misleading.
>>
>> Thanks for the code review Pedro, I agree your advice.
>>
>>> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
>>> index 1f4258308b96..f54e0b4dbcf4 100644
>>> --- a/include/trace/events/qdisc.h
>>> +++ b/include/trace/events/qdisc.h
>>> @@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
>>>          TP_ARGS(q),
>>>
>>>          TP_STRUCT__entry(
>>> -               __string(       dev,           
>>> qdisc_dev(q)->name      )
>>> +               __string(       dev,            qdisc_dev(q) ?
>>> qdisc_dev(q)->name : "(null)"    )
>>>                  __string(       kind,          
>>> q->ops->id              )
>>>                  __field(        u32,           
>>> parent                  )
>>>                  __field(        u32,           
>>> handle                  )
>>>          ),
>>
>> It looks better to align the name with the current convention.
>>
>> Link:
>> https://lore.kernel.org/linux-trace-kernel/20240222211442.634192653@goodmis.org/
>>
>>>          TP_fast_assign(
>>> -               __assign_str(dev, qdisc_dev(q)->name);
>>> +               __assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name :
>>> "(null)");
>>>                  __assign_str(kind, q->ops->id);
>>>                  __entry->parent = q->parent;
>>>                  __entry->handle = q->handle;
>>>
>>>
>>
>> The second part you mentioned, Steve recently worked on it and changed
>> it.
>>
>> Link:
>> https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/
> 
> Oh!

Thanks for the double check, Pedro.

>> If it hadn't, I don't think I would have been able to prevent the panic
>> by just applying my patch.
> 
> But you must be careful with the backports.
> 
> In any case, perhaps send another patch to net-next updating the new
> conventions there and use the 'old convention' for the bug fix?

Right, I agree, I'll send a patch for the next version.

Warm regards,
Yunseong Kim

