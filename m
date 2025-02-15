Return-Path: <stable+bounces-116472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB379A36B0E
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 02:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4B188CCA1
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACF199B9;
	Sat, 15 Feb 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2bO3H0m"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE2E56C
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583342; cv=none; b=NyuCci+LMgSPWIyP5F4O/HhH2ALqfZbNhNkhpsMAfwftlNfZo2trr32FFM/cwd/6GQpRcT6zSYT6o1ym8agDuJdBTm6uxxgg1K8HRZhHPXaRYpxBt03E1pkiMIsPO3qA8w8LVXCKe79dHEQ7z6mcQEguJ11I8MJcPSMEZEZEARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583342; c=relaxed/simple;
	bh=rrrYIsvK1t4Pblkv3GqWFewzyhu2sE3Y4U+JEd5nfSQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=stkrGV5voo3m6gDWpTtyHf+EzEDrjZizw/FNFXI0pU8RCNWdz67z+IeTYIcTlso4DZxW0qLWox4Je3hz92UWcUguHAZmyDAd5CmbwugQplS6CQIOWLoDO2sOr+jGPzOAOQcPU0KR0vY/qyFxyHgYKj4Ggo+bZMWKXemgcLAiakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2bO3H0m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739583339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4I0rwfZHwcPpR+qf3O5xEePzbj+NfVT6EWuEfGdlliw=;
	b=J2bO3H0mC5WmHaHf3K9ZZBMMR0gTPiWMbdKcp1pzu5OEPJO60NlBlpx5RliLu8T4rNHFQK
	KUi+MJATYb3hhENS5MJBpg2NU3xKXCHJD+qLDv2nLcWnNl2sVCn+8GpBHHlYJ0cIgGJ9d8
	dcz5Eb7O/aYX4EJIX6kVChybtPi6fvs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-x2VfbB0JNBucs4lrNbRCyg-1; Fri, 14 Feb 2025 20:35:37 -0500
X-MC-Unique: x2VfbB0JNBucs4lrNbRCyg-1
X-Mimecast-MFC-AGG-ID: x2VfbB0JNBucs4lrNbRCyg_1739583337
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e48a052ad6so52363206d6.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739583337; x=1740188137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4I0rwfZHwcPpR+qf3O5xEePzbj+NfVT6EWuEfGdlliw=;
        b=Cb5yLDoyA5A5HqD+9wfHAKKgIrt2xw/aOZ8s3PNy1n1OxPx8TxYuhcfFqdPG0BKJtw
         uv7mwi0g7BbHKyz1la84mvrd7cI3mAUhI++iamFfjou7WqGc0XObZmZNcs+vY1t9WwNt
         NyGhSbsw0WBsOEALKBCmZnMqxphffjeGXeGyAxz+5dO07DBhbXBeBNqmEZ13OlFn8Tew
         GH0q5teRwCVXV0f+lEuSFwotxRQLyTjaVMA0kQcn2FpRuUlyTefltP13Kr8fXaJM1PXz
         PvjrYLQEo0K2Rmj7s+2ckoQDBwVVxc/A3BDA44/r5edvWO6HG6+G0O+rROV+CpMnIPmN
         /uYg==
X-Forwarded-Encrypted: i=1; AJvYcCUpj2JEGrXPwTAYqR4ZuI0L4tceFRfXObnxtYADZlj8D5WZYvZ4C0defwqE+51mfa0kO9bhpCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQSa8Lp9Ha410R8ug1O+wKcCVBaELvsDJsTEwvME5W+0TlQq7
	IPGUNgsTBDIom7/J2XSEvz519XsjWtI9qdbA1GgX+vMP2WWpH10HtJjBveRtsu/8rzIndqQodr0
	0cvqqb3QuzC9Gxt2SojmTewvT8bQMS13DLMdkMaEj9ulMWIuo9PpPLQ==
X-Gm-Gg: ASbGncsJlZr3imu5YoLIJXktxov5V81+lCKz1v+b5CPDp3bDGKzyH8nVJU8wrjM8eAg
	dqS0llw41AeKdxtE8k6/4fINN+nDvn81qjyQn3fYsWwW8DIZmz7Ylcn3gveRNM8H8OxirqGOdY6
	SreKdRQwK4aDDpukFlLTF7ipRs2Jai+waHJM7VN/KBkE5+fe/iNJWHORH+Vix3KIccV7cigLniJ
	xGtrI2rOWOIb5uOh9r6TvRuoB5KhMx8e6FwFhN68IgSNXmA2YrLvr8dhxH5hjbuPL5DSN2317gp
	DPEsWE6hxkFRXgukt31R1hsYuNQPrMtEPUvMjOi0Qi+rooHH
X-Received: by 2002:a05:6214:212b:b0:6e6:65df:557a with SMTP id 6a1803df08f44-6e66ccf1537mr22424016d6.31.1739583337413;
        Fri, 14 Feb 2025 17:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6JG8c6UEDIvB8D1wU5rIKkaCu84iCJwWhJV9mm9OivMDlNn94xQnlrCLjtcpeJERi9ao9xQ==
X-Received: by 2002:a05:6214:212b:b0:6e6:65df:557a with SMTP id 6a1803df08f44-6e66ccf1537mr22423816d6.31.1739583337027;
        Fri, 14 Feb 2025 17:35:37 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d786020sm27166016d6.46.2025.02.14.17.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 17:35:36 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <012c4a3a-ead8-4bba-8ec9-5d5297bbd60c@redhat.com>
Date: Fri, 14 Feb 2025 20:35:34 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suspend failures (was Re: [PATCH 6.13 000/443] 6.13.3-rc1 review)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Phil Auld <pauld@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/25 6:18 PM, Linus Torvalds wrote:
> Adding more people: Peter / Phil / Waiman. Juri was already on the list earlier.
>
> On Fri, 14 Feb 2025 at 02:12, Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>> Whoop! Whoop! The sound of da police!
>>
>> 2ce2a62881abcd379b714bf41aa671ad7657bdd2 is the first bad commit
>> commit 2ce2a62881abcd379b714bf41aa671ad7657bdd2 (HEAD)
>> Author: Juri Lelli <juri.lelli@redhat.com>
>> Date:   Fri Nov 15 11:48:29 2024 +0000
>>
>>       sched/deadline: Check bandwidth overflow earlier for hotplug
>>
>>       [ Upstream commit 53916d5fd3c0b658de3463439dd2b7ce765072cb ]
>>
>> With this reverted it reliably suspends again.
> Can you check that it works (or - more likely - doesn't work) in upstream?
>
> That commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> earlier for hotplug") got merged during the current merge window, so
> it would be lovely if you can check whether current -git (or just the
> latest 6.14-rc) works for you, or has the same breakage.
>
> Background for new people on the participants list: original report at
>
>    https://lore.kernel.org/all/e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com/
>
> which says
>
>>> Common symptom on all machines seems to be
>>>
>>> [  +0.000134] Disabling non-boot CPUs ...
>>> [  +0.000072] Error taking CPU15 down: -16
>>> [  +0.000002] Non-boot CPUs are not disabled
> and this bisection result is from
>
>    https://lore.kernel.org/all/9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com/
>
> and if it breaks in 6.13 -stable, I would expect the same in the
> current tree. Unless there's some non-obvious interaction with
> something else ?

Commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier 
for hotplug") is the last patch of the 3 patch series.

  1) commit 41d4200b7103 ("sched/deadline: Restore dl_server bandwidth 
on non-destructive root domain changes")
  2) commit d4742f6ed7ea ("sched/deadline: Correctly account for 
allocated bandwidth during hotplug")
  3) commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow 
earlier for hotplug")

It looks like 6.13.3-rc1 has patches 2 and 3, but not patch 1. It is 
possible that patch 3 has a dependency on patch 1. My suggestion is to 
either take patch 1 as well or none of them.

Cheers,
Longman



