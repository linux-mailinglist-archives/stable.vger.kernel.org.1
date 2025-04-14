Return-Path: <stable+bounces-132391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63AA8771C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FA116E80F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC119CC0A;
	Mon, 14 Apr 2025 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0akCmwr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D574C6C
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744606782; cv=none; b=BZnx/YTTA91AotqzWyN0uFmZPWYOBIAc9PqoFcqL9cdJ7Y9wrHZGDA9hmfSioKw+Opv0KgLzqa1/BLejPoLlOrrSo/5+1xjiZ0HoSQj1QnB8YA8eR2mQe0r9+YYCCEkWg/yOuV9mJsDOnkemaNsTFvYkzD7bbTGFk2wTwX0HhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744606782; c=relaxed/simple;
	bh=ACWZLJupa25jfFCxMpR9Xs9uVwnapZ24uhwEct9sX20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nft/KbUzn7rc7BmG4XWolAVRBuJ8fXWe1XNgX9+eivjWbMPZ/DlbyjjZ/xPs6dpCwqfXEtcRKHWxQi5++h4Pno31l+gOP3xnhWqNPEXbBGZadTaR4i5aoCG2WzkdsT1zQWWOwvOTzQYnoTjk4EKV6M78CvnvtOgN47cm3+NqEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0akCmwr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744606778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1VnfrOH4OkYtjGJfeu1RCRHY0/ALwH6gZrfWL+zW1w=;
	b=B0akCmwrvy68/dLSYmx1JxAx7VEwEmpZRnO62qOQH/jJdq5GaBJ6A5VAOkAaq73LuYRKge
	DfSfEBz9y6NkUyWCEA3ct2w6W6GQSmy+CUSdTbsMMIPquw01pPXf9YCX9V74GPNIlhcrUC
	NYd4l8yb/MsGXasz9eUuYEqcbyt25C0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TcbSXieCNse5OzvPxhjwbg-1; Mon, 14 Apr 2025 00:59:37 -0400
X-MC-Unique: TcbSXieCNse5OzvPxhjwbg-1
X-Mimecast-MFC-AGG-ID: TcbSXieCNse5OzvPxhjwbg_1744606776
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so293755566b.3
        for <stable@vger.kernel.org>; Sun, 13 Apr 2025 21:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744606774; x=1745211574;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1VnfrOH4OkYtjGJfeu1RCRHY0/ALwH6gZrfWL+zW1w=;
        b=O3OXGiglxVItPdMwJaaVMkPvWKwDBqe80ySA8v0Jz9wZREldiH/CuEh2knShEhYZcc
         vc2A4ilWb00q3V587+hQ9ZxYVEGoDIzOOCVgbcMjgHVGzROyIwORiWL0bUhJyx0+2UlE
         SUMezX0FGbPNZDFHmazTezPw41n0+HcTeId8rGS0+TcKCqbdKI1vva5CwFqXQctGUi1R
         s7E9dCUkTZWrVkIar+9J5/K65vFXrX0UMfUcQWlIto6qiBAWwRuqbXqdqlvrdW147J4u
         pogV/LGLBT7Rfjb4YvYaWw7XetL+AWq7onMzSRRLyL/OmP/pslMJwxYKnV5821A159NH
         Ukpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPDo4JI4+2wzL4vIj6kSjtOmwMcA7Yiyep+6mCa9lpJAt+QxTUhNwgCKG2k5psTPVD/ASuWqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2t6ifm9G6a/zn+HqTyybc4WpSmv5hudacqxVxicAixhfY8UB1
	JmZOpib2ZKyPsNxbQvngfzsxL6BOQRXyR33xiSisbjZZbj1VoAclb9jPFKMnwAuqcaG9bfJzLuo
	03pJ6uSoi1VnfNU6ViR7fWczTyL3NYJL0CxZ+ifFU2VWbbmaQbXlz
X-Gm-Gg: ASbGnctQohCMP2tjeq8ElQYDPWGE1QtWsF+nsLV6utAEE2awfNNm0JHmhXu8RsAvj0T
	llRkbixSD9AWePdz/5tRVVPkJtqbAWDNC5jgKvSJgMIqrd2X+XCqaMDUQSh2jYFGgBZgmip4842
	LlnN77xZtFS8Pztx836p7eTPsi45CGQruLuMnzhIcUAzewkNtS1FM6RdNqvlbYy+pRSOgTRTo5/
	zdW8C0fsME+zHb1fU1frQ73Y5AtJw/Vj3parf78WkfchzTrsjVv7VKXsKfucG8WEaBLissIQjno
	XYNBEsIJc69AD8l0xJQfEY/Y/ScMVU/9RS5EqloQTH251g==
X-Received: by 2002:a17:907:3fa2:b0:ac7:edc4:3d42 with SMTP id a640c23a62f3a-acad349a039mr946481366b.24.1744606774087;
        Sun, 13 Apr 2025 21:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQHfzSeAUj/TqqAU+tVLfI9UaIU4wpXQagNEC/sSIHQzzK1OE7CO/dsuYzuDxtr7NOkU2wVQ==
X-Received: by 2002:a17:907:3fa2:b0:ac7:edc4:3d42 with SMTP id a640c23a62f3a-acad349a039mr946478666b.24.1744606773610;
        Sun, 13 Apr 2025 21:59:33 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4070sm847644766b.102.2025.04.13.21.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 21:59:32 -0700 (PDT)
Message-ID: <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>
Date: Mon, 14 Apr 2025 06:59:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>,
 stable@vger.kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/25 18:22, Andrii Nakryiko wrote:
> On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
>> file such that arbitrary BPF instructions are loaded by libbpf. This can
>> be done by setting a symbol (BPF program) section offset to a large
>> (unsigned) number such that <section start + symbol offset> overflows
>> and points before the section data in the memory.
>>
>> Consider the situation below where:
>> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
>> - prog_end   = prog_start + prog_size
>>
>>     prog_start        sec_start        prog_end        sec_end
>>         |                |                 |              |
>>         v                v                 v              v
>>     .....................|################################|............
>>
>> The CVE report in [1] also provides a corrupted BPF ELF which can be
>> used as a reproducer:
>>
>>     $ readelf -S crash
>>     Section Headers:
>>       [Nr] Name              Type             Address           Offset
>>            Size              EntSize          Flags  Link  Info  Align
>>     ...
>>       [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
>>            0000000000000068  0000000000000000  AX       0     0     8
>>
>>     $ readelf -s crash
>>     Symbol table '.symtab' contains 8 entries:
>>        Num:    Value          Size Type    Bind   Vis      Ndx Name
>>     ...
>>          6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
>>
>> Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
>> point before the actual memory where section 2 is allocated.
>>
>> This is also reported by AddressSanitizer:
>>
>>     =================================================================
>>     ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
>>     READ of size 104 at 0x7c7302fe0000 thread T0
>>         #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
>>         #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
>>         #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
>>         #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
>>         #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
>>         #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
>>         #6 0x000000400c16 in main /poc/poc.c:8
>>         #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
>>         #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
>>         #9 0x000000400b34 in _start (/poc/poc+0x400b34)
>>
>>     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
>>     allocated by thread T0 here:
>>         #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
>>         #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
>>         #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
>>         #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740
>>
>> The problem here is that currently, libbpf only checks that the program
>> end is within the section bounds. There used to be a check
>> `while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
>> removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
>> sections to support overriden weak functions").
>>
>> Put the above condition back to bpf_object__init_prog to make sure that
>> the program start is also within the bounds of the section to avoid the
>> potential buffer overflow.
>>
>> [1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>>
>> Reported-by: lmarch2 <2524158037@qq.com>
>> Cc: stable@vger.kernel.org
> 
> Libbpf is packaged and consumed from Github mirror, which is produced
> from latest bpf-next and bpf trees, so there is no point in
> backporting fixes like this to stable kernel branches. Please drop the
> CC: stable in the next revision.

Ack, will drop it.

> 
>> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
>> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> 
> libbpf is meant to load BPF programs under root. It's a
> highly-privileged operation, and libbpf is not meant, designed, and
> actually explicitly discouraged from loading untrusted ELF files. As
> such, this is just a normal bug fix, like lots of others. So let's
> drop the CVE link as well.
> 
> Again, no one in their sane mind should be passing untrusted ELF files
> into libbpf while running under root. Period.
> 
> All production use cases load ELF that they generated and control
> (usually embedded into their memory through BPF skeleton header). And
> if that ELF file is corrupted, you have problems somewhere else,
> libbpf is not a culprit.

While I couldn't agree more, I'm a bit on the fence here. On one hand,
unless the CVE is revoked (see the other thread), people may still run
across it and, without sufficient knowledge of libbpf, think that they
are vulnerable. Having a CVE reference in the patch could help them
recognize that they are using a patched version of libbpf or at least
read an explanation why the vulnerability is not real.

On the other hand, since it's just a bug, I agree that it doesn't make
much sense to reference a CVE from it. So, I'm ok both ways. I can
reference the CVE and provide some better explanation why this should
not be considered a vulnerability.

>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6b85060f07b3..d0ece3c9618e 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>                         return -LIBBPF_ERRNO__FORMAT;
>>                 }
>>
>> -               if (sec_off + prog_sz > sec_sz) {
>> +               if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
> 
> So the thing we are protecting against is that sec_off + prog_sz can
> overflow and turn out to be < sec_sz (even though the sum is actually
> bigger), right?
> 
> If my understanding is correct, then I'd find it much more obviously
> expressed as:
> 
> 
> if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off)
> 
> We have such an overflow detection checking pattern used in a few
> places already, I believe. WDYT?

Sure, since we're dealing with unsigned numbers, the above is an
equivalent condition. And you're right that it better expresses the
intent so let me use it.

Thanks!
Viktor

> 
> pw-bot: cr
> 
>>                         pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
>>                                 sec_name, sec_off);
>>                         return -LIBBPF_ERRNO__FORMAT;
>> --
>> 2.49.0
>>
> 


