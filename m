Return-Path: <stable+bounces-94469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD29D4342
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 21:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5BF28382C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1C1C1ABC;
	Wed, 20 Nov 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2c2bhcg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D514D70E
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135771; cv=none; b=ucyTFLO7DkKrQVY1kaa5hjByjC+rrgmMyI9F/3yPOZTBu7wmjvQug3nryBaJJzqPGrgPM2nmVgngE9w0KdkiY5QT9BuXuH4uzTOhT3vEdzUQDJVp/Bt3biBJKw2FETuUZuBm2MF1oMgJZsvDrEAGXRn7T1cOs3AsagOyIuzAm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135771; c=relaxed/simple;
	bh=49gpMjMK0KbJYgzQGKj8+N5Bcy86akKMXvxuNOX2HfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f+kWvFpN+5CXRq5mFG4CYxZ0jQrbkC9vEedGxWHcOkszz0VQg3ZpN009UitsjZLrumZwQ/6sPFZo+clBKb606BLNqcxkw33013SG2l68Y8wCYYXlDKQXiD4LKlkdj20Ijt+qD76aiqLbK03R3haTv4IuI62f15qNBtzUTpXH/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2c2bhcg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732135767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=65aCN31L2Uzgi8/twZ1wh4L1IUXMovfHxYERMVKuxzY=;
	b=P2c2bhcghk0hPMTKp0ux/BZ5YkfRPiMD6Zlw33XgIsKjLhZIYejebkix2VgSagx29UU+GI
	cmB5a9XCkEsbXms+HQ3Qldcyxb1cws5PmNdjyCUMx8rGrbC/I3Vf7480kRs32Rsc2FeFUS
	5leM6Lj8CEUAydRmPVSFOlsXi7U6gxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-y8LI4KzHPR-tC34wmLc9AQ-1; Wed, 20 Nov 2024 15:49:25 -0500
X-MC-Unique: y8LI4KzHPR-tC34wmLc9AQ-1
X-Mimecast-MFC-AGG-ID: y8LI4KzHPR-tC34wmLc9AQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso720735e9.1
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 12:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732135764; x=1732740564;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65aCN31L2Uzgi8/twZ1wh4L1IUXMovfHxYERMVKuxzY=;
        b=ep/+1ahQAP0NAcusDkesxQ82Ycou/hif1oqc1TW2JZsj0xRuIqVxkH1Y9FXhY5Ngyx
         9pG0yDxNJ6MUVQ8U7C4LtlUlNTUsrtrRq4rvwNQLOpLzJWLELcbXyboYu85hQXHCASXI
         WWYvR99Aor6LZy1ywhKIFgoyiTDUIoB6kqbvKCgFfR7c0bb1pUFy1vOSFA56cwY/bwj/
         VaHY3oTdp3kN88aQ5bKrofX4IjVe80BGpazErAgj/iXW4P9BH+5vhi2YrxhKvyE/7z/7
         HPxFiniu4aEA7GEvaO1y/wnP74jyozIeLuADSait1xfjYzzTFwtd3/mRmgukZcgGkWNY
         PKCA==
X-Forwarded-Encrypted: i=1; AJvYcCWl2ecWkS5r1ZTZOIYvelGhhCGpCi4k2nkMe7bx+rLpOog4Eii7iI4sR2tt/Ss0eF7s3eIRMxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycK3K2r4YzVsCjyXzkCaYQhzt89pcEeflbnvSWgaGW7qmSnsup
	fNl/G7bFwQnTWUPIh5GAuCNqbSrkM6irb0lnlG+CLVXNVTMhX/j85lbJeohPjeZNrDy2cyeGE9/
	W7BKQRj0pzMxBaqwx5z6E4beUUYBln+keaog7W10mh5l3V4Cdt71NUQ==
X-Gm-Gg: ASbGncvcy24a+wgCVSghRg8AWud7ZL7hCT+AlJgbp28uYVCz4HlWdSQtYOOJq3Cgago
	t6hA0VY+AmNh7JIFUc/9NwzJ+UmEAJoMaScbGEWtgOEK58wrYvT0xUIB9kjbDW3xW0VWBiJFejM
	qGdLhZr3BE9TeW67haJRU4cxOPmQwsqeBuGKzazoAtKrNB8TwyApDpi3BrtGO/2p/JB940qldlo
	Pp6k471+OlPH8t71EIxiS1aYMfYvBVxga82FcuEIiRwBupFRKM1Uk6693g6KM1vGU44ojq+CXSt
	UiIV6kzD+uPQsOyF6xPMwg6949QoncRLkBzrOMJL7nhFJrxzlcttuQ8Hlmd9MMnvqZZu2GyW325
	PDA==
X-Received: by 2002:a05:600c:1c09:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-433489869e2mr36177675e9.7.1732135764598;
        Wed, 20 Nov 2024 12:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHvWc7PcAErLlsng6fj5s+LO5P60jHvbcO0WyjMVDPm8mPmUZZtMNo/JM5+oDeir5x70qHsQ==
X-Received: by 2002:a05:600c:1c09:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-433489869e2mr36177535e9.7.1732135764281;
        Wed, 20 Nov 2024 12:49:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46343e7sm30820385e9.33.2024.11.20.12.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:49:22 -0800 (PST)
Message-ID: <652fef9b-116e-426e-98e1-d8b742bbfe85@redhat.com>
Date: Wed, 20 Nov 2024 21:49:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there is
 at least one VMA in a MM
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>
References: <20241120201151.9518-1-david@redhat.com>
 <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 21:27, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [241120 15:12]:
>> We currently assume that there is at least one VMA in a MM, which isn't
>> true.
>>
>> So we might end up having find_vma() return NULL, to then de-reference
>> NULL. So properly handle find_vma() returning NULL.
>>
>> This fixes the report:
>>
>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
>> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
>> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
>> Code: ...
>> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
>> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
>> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
>> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
>> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
>> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
>>   __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
>>   __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
>>   __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Fixes: 39743889aaf7 ("[PATCH] Swap Migration V5: sys_migrate_pages interface")
>> Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/lkml/673d2696.050a0220.3c9d61.012f.GAE@google.com/T/
>> Cc: <stable@vger.kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I hate the extra check because syzbot can cause this as this should
> basically never happen in real life, but it seems we have to add it.

I think the reproducer achieves it by doing an MADV_DONTFORK on all VMAs 
and then fork'ing. Likely it doesn't make sense to have a new MM without 
any VMAs, because it cannot do anything reasonable.

But then, I'm not 100% sure if there are other creative ways to 
obtain/achieve the same.

$ git grep "find_vma(mm, 0)"
mm/mempolicy.c: vma = find_vma(mm, 0);

Apart from that there seems to be
kernel/bpf/task_iter.c where we do
	curr_vma = find_vma(curr_mm, 0);

and properly check for NULL later.

So this one sticks out, and is not on anything that I consider a fast 
path ... easy fix. :)

Thanks!

-- 
Cheers,

David / dhildenb


