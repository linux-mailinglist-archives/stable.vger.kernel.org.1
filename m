Return-Path: <stable+bounces-166822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E451B1E3FE
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 10:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307B7565B8A
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44823F40A;
	Fri,  8 Aug 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhU3L+cs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86D2236EB
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640137; cv=none; b=DdN+Pcm4JkCGLeaPojJSmDG2ARu3ICjHMRGzhm1v7II83g1dX579y8b7fOUQkqoX1oELf84hxA0+3Ibd9JMEUAdO0PY3G39Pz2/80b1zsZFV/8LBLQAm/JsGvaZe7p+mABlltzZfZncgqrjpOwAyWiQw9Egb4zq02SdrPT8+ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640137; c=relaxed/simple;
	bh=jMSpEBEGrlHFEXytlN1Vqldbpo66hRZEypVpxIN5KOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDC0inH2qwllSN83Y4AZjdTMh7kI1Jv6YcBMVksZurcvDXgIrAeQslWHdP7BVGpgbVh3610fOqPqYfOcLvAe6O3eI7+72MicLGTiyGzkDaF0wJJkK+i4MOkuIxmU+YHaUArfs0OBy+2ozLWftEQW6wVUfVWpw7doh+F2PCW6L3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhU3L+cs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754640135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BAno96tpxFYMgcAPgmjun2K1NToihw19tP0g9bAlXR0=;
	b=DhU3L+cs20EatGgmoHS98zCNpLhmWN3jyCppMbwlGztL0XKXCu8d1u6LYQx17TUJvTGHqi
	Wjg5IAMLNrvMP5hZvHphyVXlNm0uXSA9K4/Fb1oGpvtdys2v/1E5sbgnmX+CZxrs5Vynrv
	ieDGc9Tc6M6Qsjz9S1+S0J0bMhuO1Vg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-J1s7d6kwO2mAvtw5wldHog-1; Fri, 08 Aug 2025 04:02:13 -0400
X-MC-Unique: J1s7d6kwO2mAvtw5wldHog-1
X-Mimecast-MFC-AGG-ID: J1s7d6kwO2mAvtw5wldHog_1754640132
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458de4731b1so10064275e9.3
        for <stable@vger.kernel.org>; Fri, 08 Aug 2025 01:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754640132; x=1755244932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAno96tpxFYMgcAPgmjun2K1NToihw19tP0g9bAlXR0=;
        b=jhw4AVh3S2Ub5RTtvBjjHBeFupgw+sVdNua7vESwh7t+UIeJQdptKg5iLWyDuBEDa/
         g5E4E6Esj+ShkC45RiAYXz/q4+Ky9PJS+Vab0crMhnL6akN1InoltlCQ8tnIWs++8kJk
         FcbuRo/E0iSz8aruEbUFh+VsnV6oAq9iAZkO+8fttQmDbgE7SrakDCHTmXrd7sWw4r4I
         kvZPGk2t8j4EnjmJ72RhphZbXNrasJ75r2VpR0ENAyWnEDn3rZJHJuRDkGur8wf0AG3k
         Kc/0Zqgo4Ke3dZcGKmdLa9AT4w5quks5HCVX+8eTZgMziP1EZ/9wKNsh4UIVkTw1nPHO
         tbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSGG27FyrACyDrWzFMKpDuC+6sN3mhdCDPBO7V3zil2UqJNC5W48h3skkkrrIv/1BDtbTTvg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjqKKqE8JEg8AtJuaRR4mOpTP7cqzf7KJzk7pCuht+DaB9XI/
	OIC5ffrq8+XwZYJmGWTjWU5TODJBtbLPQ1ZIBZ//uu6zobq8d7bNgBOwm38BzLym93B5N9EQZds
	vXAYwmuwo6Ih46DvNmbJnS5vVk3rXwAefc+J3zROwLQ+3BCSx5DJj6yYNRA==
X-Gm-Gg: ASbGncvkUX+B44c6diud70XI0hkCuq6nliz74PbHOQB/KQ48gDeJNQ/edZgaWdyaTz2
	dkETFNNKnHzr/bC522C2XdHRXR9w8x2/Rm4fOyJOe6i2lIRzHI1DWAS060CWcsI2Wx2FfWpl89q
	zJ85ZW5Fi3JwtMTwxy5cZtt34FF6K7GmJjbe61AO/Fqonv97sp/7myu9x6F9VIGWAsLX9KIlGa+
	r0Q0HT4NNry5/Is4cVdZmRyLe3uOgBsT0xOvnOTVz1cBVxgSBOItajp8DJAnWxvKfYIwzrj/UE0
	3dUXQUuuMV4ArEzs3BvhXkKE4Ak9q2Fhun4hEKyVWqoyKHetd18OJgitY4RjR8WtnnhCSFE=
X-Received: by 2002:a05:600c:3b0c:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-459f4f2d990mr13934535e9.32.1754640131832;
        Fri, 08 Aug 2025 01:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgZzUg3wr1SifXE4t4yhDMq7cAU5j7L/vtRZVGMfKFh0NEsEhGPcGUTafUnKO5iZcAXqC1uw==
X-Received: by 2002:a05:600c:3b0c:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-459f4f2d990mr13934055e9.32.1754640131356;
        Fri, 08 Aug 2025 01:02:11 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a580.dip0.t-ipconnect.de. [87.161.165.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862be7sm133209415e9.15.2025.08.08.01.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 01:02:10 -0700 (PDT)
Message-ID: <5b9c775c-35a1-4cd6-8387-00198e768b9a@redhat.com>
Date: Fri, 8 Aug 2025 10:02:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com> <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com> <aIzPPWTaf_88i8-a@lappy>
 <aJUDqqjCycGDn1Wg@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJUDqqjCycGDn1Wg@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 21:51, Sasha Levin wrote:
> On Fri, Aug 01, 2025 at 10:29:17AM -0400, Sasha Levin wrote:
>> On Fri, Aug 01, 2025 at 04:06:14PM +0200, David Hildenbrand wrote:
>>> Sure, if it's prechecked by you no problem.
>>
>> Yup. Though I definitely learned a thing or two about Coccinelle patches
>> during this experiment.
> 
> Appologies if it isn't the case, but the two patches were attached to
> the previous mail and I suspect they might have been missed :)

Whoop's not used to reviewing attachments. I'll focus on the loongarch patch.

 From a547687db03ecfe13ddc74e452357df78f880255 Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 1 Aug 2025 09:17:04 -0400
Subject: [PATCH 2/2] LoongArch: fix kmap_local_page() LIFO ordering in
  copy_user_highpage()

The current implementation violates kmap_local_page()'s LIFO ordering
requirement by unmapping the pages in the same order they were mapped.

This was introduced by commit 477a0ebec101 ("LoongArch: Replace
kmap_atomic() with kmap_local_page() in copy_user_highpage()") when
converting from kmap_atomic() to kmap_local_page(). The original code
correctly unmapped in reverse order, but the conversion swapped the
mapping order while keeping the unmapping order unchanged, resulting
in a LIFO violation.

kmap_local_page() requires unmapping to be done in reverse order
(Last-In-First-Out). Currently we map vfrom and then vto, but unmap
vfrom and then vto, which is incorrect. This patch corrects it to
unmap vto first, then vfrom.

This issue was detected by the kmap_local_lifo.cocci semantic patch.

Fixes: 477a0ebec101 ("LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()")
Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
  arch/loongarch/mm/init.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c3e4586a7975..01c43f455486 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -47,8 +47,8 @@ void copy_user_highpage(struct page *to, struct page *from,
  	vfrom = kmap_local_page(from);
  	vto = kmap_local_page(to);
  	copy_page(vto, vfrom);
-	kunmap_local(vfrom);
  	kunmap_local(vto);
+	kunmap_local(vfrom);
  	/* Make sure this page is cleared on other CPU's too before using it */
  	smp_wmb();
  }
-- 
2.39.5


So, loongarch neither supports

a) Highmem

nor

b) ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP, disabling DEBUG_KMAP_LOCAL_FORCE_MAP

Consequently __kmap_local_page_prot() will not do anything:

	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
		return page_address(page);


So there isn't anything to fix here and the whole patch subject+description should be
rewritten to focus on this being purely a cleanup -- unless I am missing
something important.

Also, please reduce the description to the absolute minimum, nobody wants to read the
same thing 4 times using slightly different words.

"LIFO ordering", "LIFO ordering", "unmapped in reverse order ... LIFO violation" ...
"reverse order (Last-In-First-Out)"


More importantly: is the LIFO semantics clearly documented somewhere? I read
Documentation/mm/highmem.rst

   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
   because the map implementation is stack based. See kmap_local_page() kdocs
   (included in the "Functions" section) for details on how to manage nested
   mappings.

and that kind-of spells that out (strictly order -> stack based). I think one could
have clarified that a bit further.

Also, I would expect this to be mentioned in the docs of the relevant kmap functions,
and the pte map / unmap functions.

Did I miss that part or could we extend the function docs to spell that out?

-- 
Cheers,

David / dhildenb


