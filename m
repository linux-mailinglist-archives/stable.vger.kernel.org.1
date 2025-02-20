Return-Path: <stable+bounces-118405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E367FA3D551
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D87116EC59
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23591F03E6;
	Thu, 20 Feb 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnJi34hl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297E1F03C0
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044821; cv=none; b=KN2Kym3sXLdminlu7Q76rJ2WOwyT46uzOSg2NmrPq8lIID7nV8haSdzMFLMHqmNFX3JcKGjM44lBtyBxguykvBsyzRhyhB58dZdm4u+iCVBBZP1FRe9HWv/6HnEPOwageB1UjqVdcWxuZrNFRWBh5ncZcSEDULbpdQbE94e4MHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044821; c=relaxed/simple;
	bh=kkVteqQ6jBOv0vAADwoo5K/CUAU2/E8vAYFZqRS/wjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS83E3G5EpNfagJ8rGSnXrCs9pbkKrGylIAZ/Z+WY8yz2mpfiW4PUwgycu86SmBzKqO1yohJ1w35Syfi0xood2FRdXcX6XuTX/VqmYMEuemE8qBS+u/Ed7bc/2L8SXQY8Vap2fZw2A+N7NiOuO4BJvhuuuCBsSrvMMwEtGNPUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnJi34hl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740044818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PX22VEXfQDXd+bwnNlrTtmX8mtS/mt0KdUlITs6VwOo=;
	b=DnJi34hlJia8pEtzuVxV8IkvEGB2G0fl1BUMC/UTN22bQuuDGcCzgzFrhrwJXKQJXJvpSp
	l6urzL86Xa6n4pxgtPrbRNZ15t33URduabtJ4T1GYuPFRZ9PdqeUBr7g5aa5Lm25frmz0s
	PuKh9JqarW/BMYtDI2z8CAU6Zw8OARg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-CEUgT-VyOJSj8zz-rj3dGA-1; Thu, 20 Feb 2025 04:46:57 -0500
X-MC-Unique: CEUgT-VyOJSj8zz-rj3dGA-1
X-Mimecast-MFC-AGG-ID: CEUgT-VyOJSj8zz-rj3dGA_1740044816
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so3454675e9.2
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 01:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044816; x=1740649616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PX22VEXfQDXd+bwnNlrTtmX8mtS/mt0KdUlITs6VwOo=;
        b=e13Y5P9oipo6xxcM0X+okkIqqdF5mAg/M/OvsJa84m3eGvf89zD9Gzg4tckH1Rkz4x
         W0fT5jIx+gyWuhD4t4P3LUmtoAN5E28fcadYplkQ1TftJyj4pzozCtvdFOS6BBLHTGBi
         WL8F+VGPrMjKnrlsH/WlIZyf9pUljeMzrinWVciGG8Hu5k6jBruUglf7S/k1EKPSllwR
         4rexXdW6w0TXv4YQ6zvY09Eckbp8jyLZ4FF+bNUdNIlWGbV6Dd73ThxViPgHBps8hJ+w
         PsGonR+DGZGuTSnMSg2eT3X+WH0nQ72BUgRGiJO9p1P2jxQ+mdre4OPUI4jwoV3eUTqV
         RZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVoQWKM9o9ntpRnh02sFGzNT1Vcz2f/WKgX/9IdOgAEqMNQw3UPkt/Q/reT3nzvKYtvknspUT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykU7QnMYh5lLeXcMFX6YDnDMPu+CMlzFZ1qdhZ4h8qX+n2p1mL
	QmWzqABclGiVx65DAUD6FUCfN8xzMlnyEUyxvCPP6KRnbCjKQ8LwI4lU56jbOKVOy127TBG9nN1
	mEPTX6JwjbQ3Ksbv4yZ1M1kbkDpCkBj4R66KEQ3GzNm+CioiGLWbubw==
X-Gm-Gg: ASbGncufJgqDAf2nXpoi5C+kreiqoZAAEERajj2Nd19Tveb+FaN6DXjxW0YK35naXdk
	whFacQnhPCwWgExQu1cpXZbqYllUYeCym3pzS8PMMghWk4DVERv99zHV6ae2rhgEVijYnTIuW9x
	y3O1RC5E2gmLLWCtNQN1f8Xn6ficz57Yf8tgiat9+bwL+q0unKklNfT5J81jJERWm0sB+clLzql
	dT8RaZgi6Ti88/6PWwVYcir7g24nSJAtXubAPWC2BvkqjRL+d/LT4UNBLGCAn4qzXM5q2EZiWzc
	axGAyjothPUSX1OdhAuJwO1W5IadQS0dPABqnBNZgVSM2m2r7alXHtFGMrnETCsKYzEq6Wgl4tu
	1Bj/2mkKaJJISYB28N0E4559tY06LiQ==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-4399828c66fmr77074625e9.23.1740044815937;
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2lnBXjzmd2luEL2KmwPE7DBRRL11fu5mryKSuYWczGhlzvE+nz+8CZ6DwwD2xPJQGQpOxWw==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-4399828c66fmr77074175e9.23.1740044815564;
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399558f8d1sm69276755e9.19.2025.02.20.01.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
Message-ID: <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
Date: Thu, 20 Feb 2025 10:46:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-2-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217140419.1702389-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 15:04, Ryan Roberts wrote:
> In order to fix a bug, arm64 needs to be told the size of the huge page
> for which the huge_pte is being set in huge_ptep_get_and_clear().

s/set/cleared/ ?

> Provide for this by adding an `unsigned long sz` parameter to the
> function. This follows the same pattern as huge_pte_clear() and
> set_huge_pte_at().
> 
> This commit makes the required interface modifications to the core mm as
> well as all arches that implement this function (arm64, loongarch, mips,
> parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
> in a separate commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


