Return-Path: <stable+bounces-55049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9239152C5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43092280D39
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A619CD1C;
	Mon, 24 Jun 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp1z7Mx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE319B5B4;
	Mon, 24 Jun 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243841; cv=none; b=ITA+3UjrLTFqr2CcDyid28rcLa2RI2Y+7eGup687xYBQhY0lwzwsuTFqR7hSdLnTfMLjKN3bZ4XH6ApSGLi/FjzHQCWSG5sdSwvUR6jzCwPXdBUnNHSe3u6NQIKGUlCD0S5g86Oo1voZzehj+QTQlm2HVhxN9UCfAiljUw5A9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243841; c=relaxed/simple;
	bh=ODrD+Oe0LziuET37pFz1kRGyUqy38DH7QpRKKG7xZJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPHO52GPgX4hvOXCXdkmnmSugfBbM2EtoTpSyj+ognY0hmmBEioAogKlGzYViExADMAiDXKiH/iRNyvTTf1LvewP7obz0lriSK2bKvmjgG2jlIxDvFCMfsjDHHaqBsxWk45GBX/nWup1BY//ZzLpTl/wsA11sbP6BP+glIBG//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp1z7Mx2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso35218315ad.1;
        Mon, 24 Jun 2024 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243839; x=1719848639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYH0p/HBth55j1ab+0Mqrrba8HhBEOCKxOxkc/mNC7o=;
        b=Yp1z7Mx2EDz8IsIvIM54DbeE5RN6n0hpr7aZ1/bz67DGH+8MaRwkg1IZIHVLG7o4CW
         ydotmqRd2+IMHjqAbxLXM0lC7prTOUz32JYGbqbcQwudZIDL+sLgZCchQLTC4HZfQ86z
         w0PzccpnSHV9OcoHDKv1HyNXfUhe+ZSWto+D1gDNeF4RybIrrJsuIs05IsXMjFGg12ux
         h3+o0Gvxsr8zUmWDKI8rr3W7bRWQ9CxeGfUm2+1CVl9xna7IBOcRNZ5kwmFNuDOdiZkA
         IPLRr9UVLg7KCpkr5JyzFh3spRdmt8bdKRM1phF54v1QOT+t6julcHFeri4S+4q1yyuJ
         Vhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243839; x=1719848639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYH0p/HBth55j1ab+0Mqrrba8HhBEOCKxOxkc/mNC7o=;
        b=IwzsITxm4eQqVF6Y0SyCbN1bMSoCY8aPsOH0DWYKdJ43PRBcCYCq7po9LrJOh6DH2z
         8YZELmqNOL8alfSfTKwvQqQS/nh1zBaLAWXsFV9lv5UIetL1QdmE3zFuPrE+ccbb7D7M
         fB0oTI0q3w15Wph85Koo3w0ryfuJIA8LduOfGz/s+4KqLNvgewG1OMf5x8EC+8jWQHUd
         QKbfkipgdBm9nnrqBPFdV+H6I7P0n83fdnh0/sMXGJ7yf6bhV9XbI3B6gLUXa1JQsuHQ
         rMyGVQSMbzCJN1GDBd0mNSs71TJU9E7+TeYpAAFE3Qfl+ataJijYN6CXganUn2iXAzkz
         aVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYXe2t4+v02+sVEFa9khiWhPkk99k1XE76CODag3v39SP14mosimp9REuW08Tk1yuJVt9hvzXDCRMtWwyh1B3m6QMkYlKKMTP5WBpxcpPQ2UXrpkyxbM0GRwhBjENmXbxlf5FEZa+lf4yaIvKeeEmG4R3pUaYAeclP5q4c1SjNQJwg+866/XGL
X-Gm-Message-State: AOJu0YxGSIYjTZCtFZCy4+SplVocp1AIsHxlicH4DvvbB/x6qUXFwb7v
	M3nSpMzckE9p2t2RzSB+aYA5AwE6U3cJpB7ThN6CpgQg11o+cKsh
X-Google-Smtp-Source: AGHT+IHRwxhZhQGsXlnWT8Fr+3rZ+252/QQVYuuR/7aFxhEqMAkgvbPKarb9ijoNgOkuFJ0YY2eLZw==
X-Received: by 2002:a17:902:d50f:b0:1f9:bece:4a51 with SMTP id d9443c01a7336-1fa23f15c64mr53866305ad.52.1719243838773;
        Mon, 24 Jun 2024 08:43:58 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7d1859sm64206225ad.228.2024.06.24.08.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 08:43:58 -0700 (PDT)
Message-ID: <d7b67e36-adee-4abc-b4c4-0548333ac90a@gmail.com>
Date: Tue, 25 Jun 2024 00:43:51 +0900
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
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <fa8e452b-ad37-482b-8d9b-bc8b4cad0ff9@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 6/25/24 12:12 오전, Pedro Tammela wrote:
> On 22/06/2024 01:57, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>>
>>   qdisc->dev_queue->dev <NULL> ->name
>>
>> [ 5301.595872] KASAN: null-ptr-deref in range
>> [0x0000000000000130-0x0000000000000137]
>> [ 5301.595877] Mem abort info:
>> [ 5301.595881]   ESR = 0x0000000096000006
>> [ 5301.595885]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [ 5301.595889]   SET = 0, FnV = 0
>> [ 5301.595893]   EA = 0, S1PTW = 0
>> [ 5301.595896]   FSC = 0x06: level 2 translation fault
>> [ 5301.595900] Data abort info:
>> [ 5301.595903]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>> [ 5301.595907]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [ 5301.595911]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [ 5301.595915] [dfff800000000026] address between user and kernel
>> address ranges
>> [ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
>> Link:
>> https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
>> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save
>> qdisc_dev() as a string")
>> Cc: netdev@vger.kernel.org
>> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> ---
>>   include/trace/events/qdisc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
>> index f1b5e816e7e5..170b51fbe47a 100644
>> --- a/include/trace/events/qdisc.h
>> +++ b/include/trace/events/qdisc.h
>> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>>       TP_ARGS(q),
>>         TP_STRUCT__entry(
>> -        __string(    dev,        qdisc_dev(q)->name    )
>> +        __string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_queue")
>>           __string(    kind,        q->ops->id        )
>>           __field(    u32,        parent            )
>>           __field(    u32,        handle            )
> 
> You missed the __assign_str portion (see below). Also let's just say
> "(null)" as it's the correct device name. "noop_queue" could be misleading.

Thanks for the code review Pedro, I agree your advice.

> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index 1f4258308b96..f54e0b4dbcf4 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
>         TP_ARGS(q),
> 
>         TP_STRUCT__entry(
> -               __string(       dev,            qdisc_dev(q)->name      )
> +               __string(       dev,            qdisc_dev(q) ?
> qdisc_dev(q)->name : "(null)"    )
>                 __string(       kind,           q->ops->id              )
>                 __field(        u32,            parent                  )
>                 __field(        u32,            handle                  )
>         ),

It looks better to align the name with the current convention.

Link:
https://lore.kernel.org/linux-trace-kernel/20240222211442.634192653@goodmis.org/

>         TP_fast_assign(
> -               __assign_str(dev, qdisc_dev(q)->name);
> +               __assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name :
> "(null)");
>                 __assign_str(kind, q->ops->id);
>                 __entry->parent = q->parent;
>                 __entry->handle = q->handle;
> 
> 

The second part you mentioned, Steve recently worked on it and changed it.

Link:
https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/

If it hadn't, I don't think I would have been able to prevent the panic
by just applying my patch.

Link:
https://lore.kernel.org/all/e2f9da4e-919d-4a98-919d-167726ef6bc7@gmail.com/

Warm Regards,
Yunseong Kim

