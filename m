Return-Path: <stable+bounces-150763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E807ACCE13
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB9118941F1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B413AD05;
	Tue,  3 Jun 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvRMfaHe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9C1F78E0
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981877; cv=none; b=ATTRVAl3VZCTG9onbBx/WdlrpIGKsheXS7v4cR1S9bF95eVALN8A632uNvFW5xqgnFgYlLmwT8acl6o9IWcUOvBtv5gjOQVLakc8aCBrTOEdlbEg80xTCQkBjfF+UOhglOS7nIHY38sziJJ8sWvX27d/V8A7tf9WQddWlELo1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981877; c=relaxed/simple;
	bh=d90Ta5+c/WFr0pt5UN2Sds86i7j+Dc1DUW0ZpKhXcks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4uUpuBsuevSk4q7GW5RjvpOhW6BfO6lWee0r3Iru4WCx7n1VQsXio/fmtskLUIRjoC4WfWFCF9bs1bsmBfwistprSxHSwpKcNIDosP67Fu5+nDlY0dO5yiiHmj9Y7ZbaEoLiomjIBahMYRRkYp5oZB6TI9duPtzI7Cdu7iJSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvRMfaHe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748981874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+1RY0HD1hn+NYzthB/zompikE+mEYPZqKqX1tH5KHaY=;
	b=XvRMfaHe1/k9t4zawF1KvhCzQgPVRNwTwMvGmQKY1Mmsu3DeqjcuqvUKM2my/mUvJ59Ry2
	lhMppi07uaBlCB7GUzXSgdjNaUMm1w5s6tSbnvO0f8n1ilojKUU+u5S0qsb+d1SOqm0v4x
	m5Mi7R4VZeGoFB46W2vQmilnxfunXuI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-shMduVCWNOOLx29oQgB8GQ-1; Tue, 03 Jun 2025 16:17:53 -0400
X-MC-Unique: shMduVCWNOOLx29oQgB8GQ-1
X-Mimecast-MFC-AGG-ID: shMduVCWNOOLx29oQgB8GQ_1748981872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so38376555e9.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 13:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748981872; x=1749586672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1RY0HD1hn+NYzthB/zompikE+mEYPZqKqX1tH5KHaY=;
        b=cMAe1+11YzvAMgMFnI1RNtAEdCb6WZdHQSOKVPNVMdRr4+Lnv0/K3uJDB6U2pN2QVg
         2Sm12/7SYHBG8Jdv7BT8jQ6/9zNg5u1YMD4cTBdfhUIXYzKk8rtBy2OrTwCOh+jGfFOk
         zgGM771UmGA/uhw5MsuoJaLi479lKSpfaO5CD42L7NOEIkswhcaRYOqmWIxrO+eFieEy
         mfHEQBOeoq6JAgzPiHXmB6V2gXm20Ihadk8mVXqy/O7KU4Dm0Az89BGKf9+1T3C1b6Ha
         AeIVCzd/s1snAtfhaMPY2zDJgxj+NekvuOQVZM04D4GFiBweAm0E3eAR00kvoIcrSsrK
         jEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvfHSxuly2RuQfkPJNXAZtoUIOO4RnYTRaqUgJYXqcQtA90Drr/RNBoTp4X86NvpSX+yfBVCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsF/gNh/szBz5+l9mraP82RrWFRfqSBl+iW2q0yWHwMfo9Eol
	xW/IVS2jrzI5cJ47dWkVdhuxHoGBUbLZq40vGbvG7NCkcePs2dM5N+iNKYuAedZa/ud4ZyO61Hx
	xA7VCnPQ+TbsrK8FKfnZBVe8MeHssbDVVNB9qCb67pAdYozMCBKxkAjgvxA==
X-Gm-Gg: ASbGncsVFGltNlX+1fKBPOBHGdCguRLoizwukvL9+WBN96wrieEmVZJMCRP4ZiAtztW
	Uq5m+VhN5JE4nXgEPcJFKDayadcxSv95fyn9d3+4f8GsQ2DS+8Xtu6+lw5ktm9kNh0Fr0Sp+ixx
	RTNOADq0nwEL+2bAB/WYc5mv2BxiF2KGKbTB/sK/dAwCy9YVqRXEqwjp7peKwZdsUNOdrCj1qFQ
	J109WiIeRK+fK7Jgc1iKEowPQ6BpsQvmOrM65RdMuywMeQUkehQCVnMX0lJu/uCH2LbyrddCiAj
	AEy4Z5F+tGY8P/QLLszmpAf4qRH9BbN7Vt3PNyG1HDUAjF3SzhPov5a10mNGfn5+0k/DXXhZm3O
	QMOpcTTRTnQxKN0QS/Ow+Xa8lEkKQ7VKnlww0e4Y=
X-Received: by 2002:a05:600c:4e01:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-451f0a64f08mr817185e9.4.1748981872234;
        Tue, 03 Jun 2025 13:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI+PPvXmScqjXvKy8YY53Kw8ucqabBmzAl8IGnjFusqugiTsGUr0vRqgzAeBk4ls8nsgjCCw==
X-Received: by 2002:a05:600c:4e01:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-451f0a64f08mr817025e9.4.1748981871817;
        Tue, 03 Jun 2025 13:17:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0654sm172866835e9.21.2025.06.03.13.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 13:17:51 -0700 (PDT)
Message-ID: <ddad0a93-e9f2-4b3b-afa9-53f0c8315ac1@redhat.com>
Date: Tue, 3 Jun 2025 22:17:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
To: Jann Horn <jannh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
 <aD8--plab38qiQF8@casper.infradead.org>
 <db2268f0-7885-471d-94a3-8ae4641ba2e5@redhat.com>
 <CAG48ez2NX-L0Wq-DQDB2vb3CvOJ1uTmJOqmbMW=FOTtxVoouxg@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAG48ez2NX-L0Wq-DQDB2vb3CvOJ1uTmJOqmbMW=FOTtxVoouxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.06.25 21:09, Jann Horn wrote:
> On Tue, Jun 3, 2025 at 8:37 PM David Hildenbrand <david@redhat.com> wrote:
>> On 03.06.25 20:29, Matthew Wilcox wrote:
>>> On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
>>>> When fork() encounters possibly-pinned pages, those pages are immediately
>>>> copied instead of just marking PTEs to make CoW happen later. If the parent
>>>> is multithreaded, this can cause the child to see memory contents that are
>>>> inconsistent in multiple ways:
>>>>
>>>> 1. We are copying the contents of a page with a memcpy() while userspace
>>>>      may be writing to it. This can cause the resulting data in the child to
>>>>      be inconsistent.
>>>> 2. After we've copied this page, future writes to other pages may
>>>>      continue to be visible to the child while future writes to this page are
>>>>      no longer visible to the child.
>>>>
>>>> This means the child could theoretically see incoherent states where
>>>> allocator freelists point to objects that are actually in use or stuff like
>>>> that. A mitigating factor is that, unless userspace already has a deadlock
>>>> bug, userspace can pretty much only observe such issues when fancy lockless
>>>> data structures are used (because if another thread was in the middle of
>>>> mutating data during fork() and the post-fork child tried to take the mutex
>>>> protecting that data, it might wait forever).
>>>
>>> Um, OK, but isn't that expected behaviour?  POSIX says:
>>>
>>> : A process shall be created with a single thread. If a multi-threaded
>>> : process calls fork(), the new process shall contain a replica of the
>>> : calling thread and its entire address space, possibly including the
>>> : states of mutexes and other resources. Consequently, the application
>>> : shall ensure that the child process only executes async-signal-safe
>>> : operations until such time as one of the exec functions is successful.
>>>
>>> It's always been my understanding that you really, really shouldn't call
>>> fork() from a multithreaded process.
>>
>> I have the same recollection, but rather because of concurrent O_DIRECT
>> and locking (pthread_atfork ...).
>>
>> Using the allocator above example: what makes sure that no other thread
>> is halfway through modifying allocator state? You really have to sync
>> somehow before calling fork() -- e.g., grabbing allocator locks in
>> pthread_atfork().
> 
> Yeah, like what glibc does for its malloc implementation to prevent
> allocator calls from racing with fork(), so that malloc() keeps
> working after fork(), even though POSIX says that the libc doesn't
> have to guarantee that.

I mean, the patch here is simple, and there is already a performance 
penalty when allocating+copying the page, so it's not really the common 
hot path.

Merely a question if this was ever officially supported and warrents a 
"Fixes:".

-- 
Cheers,

David / dhildenb


