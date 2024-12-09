Return-Path: <stable+bounces-100154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DE9E91A1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35A7281405
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D30219A9C;
	Mon,  9 Dec 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXIrQiiT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB103217F4E
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742325; cv=none; b=d+Zm/fFaN0nZe8RCk+jbgIxBSiie+sPwD1paj3kdjnxWyx9o0zJT9VAnYk+4AGifmMiMGfXa2psztrLz0lBilB0wr0OzItgtWNslcnDf/5HFFRa2ofsBD0xZ0Fu7WdmQSGsVj0C7vP0+meGvAqaATTOQw0LgyVjFCC2jsD9upWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742325; c=relaxed/simple;
	bh=epidLB7NhL5xTx6DaDSzyC9NSZa6RPmcFUHWHcegxtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtgNqGWfwZzzktUOlV8D8qig7Lj85P1wphAwnKMxTlo+HJH9dwJcv/5fg/Fw+N/Xre3Or0J9vXadpQskTM50/GVb1AiztviYPfXB7tgL0RO/kGW9wJmjm1V3FdJDR9n366N+2O7BkmB5x6zzqhejKpe5ysHBB2PRHMSloSnlyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXIrQiiT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcqFqgXjnmt6G7/7k/hur7z0RAKrnBg+DMT5WyZ4S4w=;
	b=PXIrQiiTZSMKstgkqi7QU4LF7iA8eFbfn4jnpDUaZXE3h38uoWIOajDiYGhB+OheMwy6wH
	JlUY1UGRlEsKVB1ensmULeuSJMVv+5CMoqbfBJTOh+ohNQvAe9UI+D1AgJQWoAzNcb9iIK
	4u8wgvvOqiqs2eHfbT0l+oTmkBeCRxM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-WkISzo0IMyOETEwX5Qf6hw-1; Mon, 09 Dec 2024 06:05:21 -0500
X-MC-Unique: WkISzo0IMyOETEwX5Qf6hw-1
X-Mimecast-MFC-AGG-ID: WkISzo0IMyOETEwX5Qf6hw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa691c09772so52170866b.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742320; x=1734347120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcqFqgXjnmt6G7/7k/hur7z0RAKrnBg+DMT5WyZ4S4w=;
        b=RP2qjJ2CP2KuJptgvT6W/jI77jSncq40zca0Pvy4SPZ0FekR4GCleQSF3AIZx7K7Ld
         klh02z+88G/IwZP82hE2dOClPCx9tnbn/ktCJaom5s+Ew4bX9kZD4CT4hXZURyqOr0ZP
         I4E43LJ+nA1rokjdU1O6V7pzy//lck+WSitz26RIzDPr1IS8FtdBWuaPRAZRnLJevNF2
         dHxsLU1a5L3i6eajJTesDYg/Gntnio02hUciRW/a0p0fbfMwJIRc01HggGfg+TU7eErU
         mY+03Z7/evVIiwSWmcxcZNHNhXBIQvCVCgnM77CwqpiDWyp3g7txIFQlylQI3r0WF/r2
         n9AA==
X-Forwarded-Encrypted: i=1; AJvYcCVeLVp0t/+2NjuEKG6FmM+O2AgaWbJizQV78TLM/1p/Mu3M1wSeVBqmo1xZOIPWwDf4ZblV3BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+gtn1Dflh3fiAy0Uy4JldvM3giAQjrXpbGE5rbcczNyrTkyt
	EgYhbKgs8mbGqO9Fllv7qkSQa//J2r0RU6VnakmlUMtzKTHfbme4z2B9NIbhaQmhVUJLxw8sOUg
	M4nGy6qcLN8gQl8kDVWNYWKA4ijxhtRwnQkErz1pEmmfl9nAZp2IZbg==
X-Gm-Gg: ASbGnctxIpS9vHdynuz9LdjMztTFQBLDkWhTYppumH0BelBhsDencTe+LU9QSqO4rto
	PpeUSIX7uzEMP7tXX2ONuS1r/qTAbslsWJxlcVwplsaYOV+p8HuEH1tZTbdUuJhwWm2ERk9dXUT
	ohqsLex8SnDhFdWewHSnXr7qA5/Hl0N4ERia87sijNjwYQQkHsDYmbsB+rc5TNPzGmMkBjvJV12
	fk1Hiuwmr6cWtymjvoov83Hw6pgRtVS9/eBayaebXcrtzZ0bbGT7g==
X-Received: by 2002:a17:907:7846:b0:aa6:6ca2:b772 with SMTP id a640c23a62f3a-aa66ca2b8e9mr559075366b.10.1733742320158;
        Mon, 09 Dec 2024 03:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEinNFXzpmUfvbOzVGpdNy+v/42bFycLFBNOD3IwdWR5Q+hqMHMYElk8YhkflG1uTj/MaQTQA==
X-Received: by 2002:a17:907:7846:b0:aa6:6ca2:b772 with SMTP id a640c23a62f3a-aa66ca2b8e9mr559063866b.10.1733742318172;
        Mon, 09 Dec 2024 03:05:18 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm165450266b.108.2024.12.09.03.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:05:17 -0800 (PST)
Message-ID: <5f0bb4c4-57f0-4976-a6c2-2419500ffe4d@redhat.com>
Date: Mon, 9 Dec 2024 12:05:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Kalle Valo <kvalo@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
 <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
 <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com> <87ldwpt90g.fsf@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87ldwpt90g.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 12:01 PM, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> Hi,
>>
>> On 9-Dec-24 1:26 AM, Ping-Ke Shih wrote:
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
>>>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>>>>>> except for the following 10, add these to the untested section so they
>>>>>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>>>>>
>>>>>> This fixes these wifi modules not working on distributions which have
>>>>>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>>>>>> like Fedora.
>>>>>>
>>>>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>>>
>>>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>>>
>>>>> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>>>>
>>>> Thank you for merging this, since this is a bugfix patch, see e.g. :
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>>
>>>> I was expecting this patch to show up in 6.13-rc1 but it does
>>>> not appear to be there.
>>>>
>>>> Can you please include this in a fixes-pull-request to the network
>>>> maintainer so that gets added to a 6.13-rc# release soon and then
>>>> can be backported to various stable kernels ?
>>>>
>>>
>>> This patch stays in rtw.git and 6.14 will have it, and then drain to stable
>>> trees. For the redhat users, could you ask the distro maintainer to take this
>>> patch ahead?
>>
>> That is not how things are supposed to work. You are supposed to have a fixes
>> tree/branch and a next tree/branch and fixes should be send out ASAP.
> 
> Please understand that we are more or less volunteers and working with
> limited time.
> 
>> Ideally you would have already send this out as a fixes pull-request for
>> 6.12 but waiting till 6.14 really is not acceptable IMHO.
> 
> If you have an important fix please document that somehow, for example
> "[PATCH wireless]" or "[PATCH v6.13]". If there's nothing like that most
> likely the patch goes to -next, we (in wireless) don't take every fix to

Ok, so how do we move forward with this patch now ?

Regards,

Hans




