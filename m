Return-Path: <stable+bounces-132759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E698AA8A2D6
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B01D3A887C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167D29A3F2;
	Tue, 15 Apr 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDAabWjG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9D2DFA29
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731160; cv=none; b=VOBUfcge7kB2QWgxZZ0gHr62FeeMGOn7p8P3EKA+ThQVv+l92fdCD6FpIcpLCJNJrXRSqB2KEhxDIwmUjwxf9viQolL7LGTt7FWBNAKmO4CB9BkNLiz0HqPU41Zby1fctxeA+/cfGJs+ffk59cFvT04OTyR8ENU/QD98BlwVZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731160; c=relaxed/simple;
	bh=R6nb1WtwqXXDQ3ClWsF6yGGhXHStpqBbxtkHC5WZgPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjZEuy3B9h73XbxGj0HI+96nei6jYLDMNkzMtd0eKgYUagETUjPVVSenL99NUUP25XFefyLFMZtAAEcCavxuhCkE4GaO7TZr+P07678Mgz3V8+SDURIclMowx2pldomoM5GuCuMeGzSOGZU6/Y0qjX7NXbb3XNGqWazxfgIeTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDAabWjG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744731157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLkZ5gholN7KlxjnLx3i2hbL4WFISW/okrptF23XIxk=;
	b=bDAabWjG27oivJFDPJQO4t3Cia6ZQ0eRwhROStZa2aZ/J5if5Ezc96WfMX80v4EgGUxXMn
	ip2Cqpt8Nz8Ye5ExTwOZjMA2LAAgC5QSSA/fxsZldHWgD0jtJYlQAcc8/BXzKCi4gjtZgU
	2kXHiBmtgIpwbBYW0bDAOc6RnR9F6cY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-5hNqwdIiPh2S7LsRL7MTdg-1; Tue, 15 Apr 2025 11:32:35 -0400
X-MC-Unique: 5hNqwdIiPh2S7LsRL7MTdg-1
X-Mimecast-MFC-AGG-ID: 5hNqwdIiPh2S7LsRL7MTdg_1744731154
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so45536515e9.3
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 08:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744731154; x=1745335954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLkZ5gholN7KlxjnLx3i2hbL4WFISW/okrptF23XIxk=;
        b=oeU029TTmfYJyFxZfSLYbIpFnkA0O2N6fPQ8Nch//hHRL7hVxXS11qDYLZTpEud6Hy
         t6IH4UVIo7t2ZVN2+CZyJ1ene8BQgtnJP+n+wxeC9HKa+lLjDRGTLEIEHk2N8O30qXhv
         7XD8R4FcL+aSwVDECX7oYjr7hoPU4rfK9pqUPuaVAVGB5KYdL2QqWThmNQVZYn/GgtLg
         CRDwIEOljJh0k3OU96H+C8hmucY+9HaYUhfJo/warW9eRIvn3DWigDo3DwOsCzjhJc9e
         l0RrHNSTuuK1M8BCuxTMoGBw4BZ+pZJ2BIFlkkD1PDKN2mnbLSLCtfOqBh0x0p/KkKU3
         DHWw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9sGk0m5C4LgdMiVY9UoPxadpgajdRnEH/IsUF4/cfgda+J0BcVjhJk0IQW+kad1s9HIpvNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtz1hSeUdq6iazl3VL6gw16f3bbUhzYH8AMDbiaUioXjzmRtq
	VtGz0dL+ZSM6B5Evd92RiwpQJCpX0URykluDiZL1qutF3zlRK1DhR0QSXaMLYSM3gJULQgZwcKY
	ifZrYD5AuB8yEqOi0FCipkYoqNK9M/RIStzCaAnY0hCYgQWXr3Nqa
X-Gm-Gg: ASbGnctmIMS5fFBT5fl8q4/Bbrja8CioM2npYp/aQusQIpP/54AItF8+r4WEj8Mf1/J
	N2ZwnPuafI3nvL2o1eRiojZAflH1Q4cEb8eCqnINE5spiiUo28JhLRdhKsc8hSEmFkVVrb41hFM
	n1WaAVWEO1GwpBL+xlH5yCnQRwIv2KXKr1/BBiGAJSu3TezSPz77Q+jXZ9xavlOMRfMMhhovJ9N
	SQ4O11gelFRqPnOMVubMYnk1wXDnetB5fFPW88FGFuBBoXQZ6kkLeJ0I9pb6M6+LMwc7zWr693x
	mljE0Z0=
X-Received: by 2002:a05:600c:5107:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43f3a9ab43dmr120467065e9.25.1744731154379;
        Tue, 15 Apr 2025 08:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRjeC2kuGKTaahnlrFEdz75Knh/1d9p/NZOXVLHXeVVZL6e2q4QqFnMwGpFsfU6hWzkN7f1g==
X-Received: by 2002:a05:600c:5107:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43f3a9ab43dmr120466645e9.25.1744731153917;
        Tue, 15 Apr 2025 08:32:33 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c81f6sm209710005e9.20.2025.04.15.08.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:32:33 -0700 (PDT)
Message-ID: <183cb732-3c52-4057-97a7-632941c7a8f3@redhat.com>
Date: Tue, 15 Apr 2025 17:32:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>,
 stable@vger.kernel.org
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
 <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>
 <gaebflcrzdszes6febvrf43dgllpemg3ghcgbwmd2klfaj7p4t@cmg2los3ahla>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <gaebflcrzdszes6febvrf43dgllpemg3ghcgbwmd2klfaj7p4t@cmg2los3ahla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/25 11:30, Shung-Hsi Yu wrote:
> On Mon, Apr 14, 2025 at 06:59:31AM +0200, Viktor Malik wrote:
>> On 4/11/25 18:22, Andrii Nakryiko wrote:
>>> On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
>>>> file such that arbitrary BPF instructions are loaded by libbpf. This can
>>>> be done by setting a symbol (BPF program) section offset to a large
>>>> (unsigned) number such that <section start + symbol offset> overflows
>>>> and points before the section data in the memory.
> ...
>>>> Cc: stable@vger.kernel.org
>>>
>>> Libbpf is packaged and consumed from Github mirror, which is produced
>>> from latest bpf-next and bpf trees, so there is no point in
>>> backporting fixes like this to stable kernel branches. Please drop the
>>> CC: stable in the next revision.
>>
>> Ack, will drop it.
> 
> Sorry for blindly suggesting the CC. I'll keep that in mind.
> 
>>>> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
>>>> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>>>> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
>>>
>>> libbpf is meant to load BPF programs under root. It's a
>>> highly-privileged operation, and libbpf is not meant, designed, and
>>> actually explicitly discouraged from loading untrusted ELF files. As
>>> such, this is just a normal bug fix, like lots of others. So let's
>>> drop the CVE link as well.
>>>
>>> Again, no one in their sane mind should be passing untrusted ELF files
>>> into libbpf while running under root. Period.
>>>
>>> All production use cases load ELF that they generated and control
>>> (usually embedded into their memory through BPF skeleton header). And
>>> if that ELF file is corrupted, you have problems somewhere else,
>>> libbpf is not a culprit.
>>
>> While I couldn't agree more, I'm a bit on the fence here. On one hand,
>> unless the CVE is revoked (see the other thread), people may still run
>> across it and, without sufficient knowledge of libbpf, think that they
>> are vulnerable. Having a CVE reference in the patch could help them
>> recognize that they are using a patched version of libbpf or at least
>> read an explanation why the vulnerability is not real.
>>
>> On the other hand, since it's just a bug, I agree that it doesn't make
>> much sense to reference a CVE from it. So, I'm ok both ways. I can
>> reference the CVE and provide some better explanation why this should
>> not be considered a vulnerability.
> 
> While I also see other colleagues that reference CVE number in the
> commit message in other subsystems, personally I would drop CVE
> reference here. This CVE entry doesn't have techinical detail in itself
> beside mentioning that the issue being buffer overflow, and is
> disputed/on the way to being rejected as far as this thread is
> concerned.

Good point, I agree that dropping the reference is probably the best
approach here. It will allow us to merge this fix while we discuss the
next steps wrt. the CVE in the other thread.

I'll send a new version.

Thanks.
Viktor

> 
> ...
> 


