Return-Path: <stable+bounces-217609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFU7B5P1mGkaOgMAu9opvQ
	(envelope-from <stable+bounces-217609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:00:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551F16B7A4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D09930530C5
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCE3164C8;
	Fri, 20 Feb 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR4LKg6D"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8631282A
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631997; cv=pass; b=gkFjngN6kjStKKUPCY8nyzmLIXijYuiDvoxL/bYgK7Nw/EghHDt8LYNtoxrLWE4Z6SihG22oSbSoOqQsYXJfHEznWawHStOUftyrGg/9ceLp4HgkSRe9erBfizjk+KPdY3Ql9obQJqE4kKnwy8S5UOCDgMF+sPid9orckEmftOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631997; c=relaxed/simple;
	bh=VyJ51nvldcOjba54gfvYaCWLkwe2rVqmswtI06TBvPs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9GNq6QtMs9ZbPcbFs5RDnOwOozQagUukHEX59yjnE8Jin1nd3bxYte3z5ieUsifbdFkUqCuvWCB11DusmMWIiqRopwAon4/UBZK5oXt3ab9aweXu4F/FPfQJRpCLHMZVckd+2CM7wW3A20PBEM85gAkqK+SfC6ApD/+C1Nh6NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR4LKg6D; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5673fd077b4so1252601e0c.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 15:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771631993; cv=none;
        d=google.com; s=arc-20240605;
        b=IVeUVI+Dba6Gs2N0yIWbnNNbsHfviA4W/47vgZtccaudSrLa3XBpkzfRUHgSVr6RkT
         wROqK5UFZN84r+OeOW5Q40nTatUG+0g9N8QnjmFqc5bMxsg4/NOBgwmSuPaYRIvF08SN
         sdfFkpEPLKlLRD8WdXRP0S6eqd3fhZ+R3os2KNjQgVvRQ0BU+B59cohhskpmEiuG8Oaq
         SUK6w2Qlyhm8KEfVvW5WGFDrA4jOUBq5NaeRMg8Dfnbu6p5qLpvU0YQpGkQAwWVXvTaL
         6PVstlaQ/D5RsFfPXLeHcShIp/yxaYS+vSk85XhypRUO4V/o/gmAIH9Es2fHH1g/035G
         QoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+f0CcQxmI0koMDUEbyqFOb1QILsoY/SYqmL6D7Q+4cE=;
        fh=kcZBbIvZIyDXUVTy7AnKC+P9pi8m/QmbfR1YF/WP4OA=;
        b=W2jNay3WuOBNWLAtoljfBYvcM6x5vn/VVQPA8Q0LaxAw5TveieYOHPJ8wIVwDPPUN9
         wSqrBe0AAMVjaZH2OHMv9qkGzJRbGkRG/NdHyf7TizLa2j+V3Rq7hS6S3yk1RRuULrIV
         i9HNbNbpFW4wKk4K9OXk7p5cMTmPUUTYSUwM4kzQz5ftKDu+ILP6BgYbKWFnif3RsuUM
         qVLaOZg7DenT0DdZeba8ZYhAxdMLrVXzcQHNovj5zQawJG+KoVDhLpJkD5MrKyB4PFRo
         2SmVHHNzF/L0kXLwciyAhd+yDA3CX+Rq1zlhnWb4/FxwKps+Wc/I7C4wXPcVKqzOO4vB
         oo6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771631993; x=1772236793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+f0CcQxmI0koMDUEbyqFOb1QILsoY/SYqmL6D7Q+4cE=;
        b=XR4LKg6D/gGGvzXgOsfsIBAJrDcsMcXhjNtNNwfnEr6i9g0J1AyDZn6AVkqSvxQXhS
         fJAOqO3YTEXr4q9yR1463W4EfqKu3j5WDxPGhQ9ICKL/tKbWXWpea3htap0LOBnXvz1N
         Mz9PsmXPPIzL2iTCAGXb4v4zl/WTMnbg8l+RQzmrbzQLeNsCGxGWSWlqhkSckiBIHS43
         NGNWbAuPfgb/e5NspKFzZZCh8sF2hopWh+ygjitdJ9YRGBdJEjrvdgwpweg4rvFDHm3R
         X2gSmBBllt4lRx2cuLyEQZDKXGUzTG9sV+nWu1mc43p2XKGi1jyd3LbrQCEsEQ9Gsxno
         YyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771631993; x=1772236793;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f0CcQxmI0koMDUEbyqFOb1QILsoY/SYqmL6D7Q+4cE=;
        b=Zvn0t8uwvHnIDZdeYzofyE5Vc4h/HhPFlaREMlUl+4J8z8q9j8sfLiExU9+OHK4tUX
         ZwXq6p984ryjikRslpHjFypmoAx4GwWXL8P3xDRHhB93FtqAxhkRKyVx1JJarj3e8rNA
         cVLqZ9D1C2eePhhcuvQAXPR3+5LWMZAY9ccxrkynhdRpCs+nxOUFIkrWHcjLX14/BMnW
         IbahaNZxF7UA1YOlf0Pp2SdkZGeWU1yntWVcQsR+cg92bV66fhuHUwdbl6QwGkWyUTlG
         mdhQPOSMFW8p0jJn08Mh43OwiIc2Fo6QxpMNUauSN/JSwZ9aE8emEJ0iMPHfZd1hTXc9
         zqRA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzau2H0ZFwCoLyzVREUHs2rue7k+k8dg/iAkYJf8B1u8p24YTFspP1r9T/cDeqYOzpR/GfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxt4/FRJ5GBVIXlJhbyd9uVVow6FD6yt000FtCsM7gKCj8BxS
	SUuTAs+38E1sNgfhPhRAGadUBNysw3vfeTN3zR2+jauZcTu0HXIUcvQNJcGtz9YW+4wUJvzeXBP
	S4NczIRNJeRFBxUh5HsDe8F6214H6bUsqkdKmW3pW
X-Gm-Gg: AZuq6aLtHUIhLSZvXBpUFssMrchM9t/1ifritxRTTvoK/S+V459DE2ziQLmyGyIpUKD
	73je0aCxAmLwAgFs/j4pwvVahgzFIn4kQiAU9GBAcv9SpIABl+fYSoaQx+1MEJsDBEaWjpBtN4N
	WRUt8js0RhjZ0NlbBt1drzWEUbaxj1T+Zfk7D+l2LWzYmG55BbOO5fmH/SyR+3vJKgSqSltfW3Q
	bJsLWS+kqFfA/60JQN13ceqLSszGP1S4Zgr3sFb10Jex1P3wLKZYmNrmk+bTpfHWeKJPcQvE6Ql
	7/9SbZUpg3dPUMprcrmx+U5wenT54JSWr5Fs0xtKPw==
X-Received: by 2002:a05:6102:358d:b0:5db:3bbf:8e62 with SMTP id
 ada2fe7eead31-5feb2e60d7dmr725313137.1.1771631992819; Fri, 20 Feb 2026
 15:59:52 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 15:59:51 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 15:59:51 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aZSGD-EGSR3Z5Qyi@google.com>
References: <20260214001535.435626-1-kartikey406@gmail.com>
 <20260217014402.2554832-1-ackerleytng@google.com> <aZSGD-EGSR3Z5Qyi@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Feb 2026 15:59:51 -0800
X-Gm-Features: AaiRm50KSzR4QWeR2pY6q56NWZqd8e8f9tXSjFga3oRJAj_7AZ0rMRT-3FKVTjc
Message-ID: <CAEvNRgHQZzdy8+rbsH2EibpCo8ddinXMSSef5h1_r3mK74q-xg@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Test MADV_COLLAPSE on GUEST_MEMFD
To: Sean Christopherson <seanjc@google.com>
Cc: kartikey406@gmail.com, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, vannapurve@google.com, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com, 
	i@maskray.me, lance.yang@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, stable@vger.kernel.org, 
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217609-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,vger.kernel.org,google.com,oracle.com,linux-foundation.org,linux.alibaba.com,arm.com,maskray.me,linux.dev,kvack.org,syzkaller.appspotmail.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7551F16B7A4
X-Rspamd-Action: no action

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Feb 17, 2026, Ackerley Tng wrote:
>>
>> [...snip...]
>>
>> +
>> +	/*
>> +	 * Use aligned address so that MADV_COLLAPSE will not be
>> +	 * filtered out early in the collapsing routine.
>
> Please elaborate, the value below is way more magical than just being aligned.
>
>> +	 */
>> +#define ALIGNED_ADDRESS ((void *)0x4000000000UL)
>
> Use a "const void *" instead of #define inside a function.  And use one of the
> appropriate size macros, e.g.
>
> 	const void *ALIGNED_ADDRESS = (void *)(SZ_1G * <some magic value>);
>
> But why hardcode a virtual address in the first place?  If you a specific
> alignment, just allocate enough virtual memory to be able to meet those alignment
> requirements.
>
>> +	mem = mmap(ALIGNED_ADDRESS, pmd_size, PROT_READ | PROT_WRITE,
>> +		   MAP_FIXED | MAP_SHARED, fd, 0);
>>
>> [...snip...]
>>
>> @@ -370,6 +441,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
>>  			gmem_test(mmap_supported, vm, flags);
>>  			gmem_test(fault_overflow, vm, flags);
>>  			gmem_test(numa_allocation, vm, flags);
>> +			test_collapse(vm, flags);
>
> Why diverge from everything else?  Yeah, the size is different, but that's easy
> enough to handle.  And presumably the THP query needs to be able to fail gracefully,
> so something like this?
>
>
> [...snip...]
>

Addressed your comments in a v2 [*], thanks for reviewing!

[*] https://lore.kernel.org/all/cover.1771630983.git.ackerleytng@google.com/T/

