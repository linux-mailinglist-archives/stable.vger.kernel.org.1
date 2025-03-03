Return-Path: <stable+bounces-120365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB7A4EA9F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F112177B8A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9E27C14D;
	Tue,  4 Mar 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn4QNugr"
X-Original-To: stable@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64544277817
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110130; cv=pass; b=pxvx5Aa2OJskdlkBpHsVClUQ1lh+NoX/UUo2aHIz5so3+rMsrehRDfG/YlbFiDz2bAVvg96mvIVAlP1qC6lIL+iJnnrfZhusp0aE4tRYxkmqfozpBQLn67gtkTGEJbV6RNLXuxrcelkE18cqFc2Wy9pRA8JaHFxcwHfWym3UyA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110130; c=relaxed/simple;
	bh=HKeC4SDub9d5vfwCMzMHjqXbSSwontRIFOdhyF5j0eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDKgQL7HhK1E0Yj1ZV1v7i0tXv70S1RIQm3LnQBExnJWsghsdUXk4OXBYVpESwdxnORutnVnxtv+sN/53EC/wnXdiUHpsayTq4JQu5U7JNt8bqoPH1qHFOlWsqa5N3BnMyZWfia4lecwnOS2xT42jWiirAln0Ic0BpGo2/JL/VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn4QNugr; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id D250240D1F46
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 20:42:06 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qn4QNugr
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fs16cwtzG0rd
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:35:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id BDE0341898; Tue,  4 Mar 2025 18:35:21 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn4QNugr
X-Envelope-From: <linux-kernel+bounces-541330-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn4QNugr
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 7FE0E42CFF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:02:03 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 58C773064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:02:03 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A55188CABF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DE1E7C0B;
	Mon,  3 Mar 2025 10:01:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358B1F0E34
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996093; cv=none; b=XcVik8E4E+c/C46o0lB3uDGrY1kuJ5qjKtlZwTLWb9GPGYUlW7Lq/SlHatxZn1iGgYqOxil5VCf0UyCknkWow+JoIv6DhEZwl+peJ0eoGQNd84c7L5IRTwmOmuMoclNOq3fTVQRnhvoRWErpF8D+v2Ksqa8uSgBInCfQaxy77Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996093; c=relaxed/simple;
	bh=HKeC4SDub9d5vfwCMzMHjqXbSSwontRIFOdhyF5j0eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCToM0pn4RV79wBtxwMQw8FnuDMqgFoh+2uxhrp9s/JkcJ4GNAg+9YBsYbKSY96Sl9AVjnH7R9qt2uPIX33Qp5lAV2ALGSiKd3KSIPchfGsoZDgun5hYbsbmo/XDVVH4yAF+/tiAv4/s/jhLnW1TN0rKZefDWpyHdKYI1qW7JFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn4QNugr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740996090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XPMg8qYY6woJwUtyf2x+IAiV5yepPU5ZWaNNfhk/IJY=;
	b=Qn4QNugr99vvQVT+m1LFe/tRN4Hv0hYLKeVsQnoJdw4uYDJjmYSP58RaF5Lw75KG2OscBY
	X7oaA071I08uUO6xXYjGTFb09vrPz8i/Y+JosTLEib/16esDvncuYQOLC4jrnIE/+70nEC
	GQFE/STTk1nhTW0qBoQ4ut5LZ91emqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-JCtK81dCM5KuCLwP4ayBaA-1; Mon, 03 Mar 2025 05:01:28 -0500
X-MC-Unique: JCtK81dCM5KuCLwP4ayBaA-1
X-Mimecast-MFC-AGG-ID: JCtK81dCM5KuCLwP4ayBaA_1740996087
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so22241145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996087; x=1741600887;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XPMg8qYY6woJwUtyf2x+IAiV5yepPU5ZWaNNfhk/IJY=;
        b=Op8pwo3j6RCPSIsHihTuqNrpen7tMETFUgibDDI3mWMG8gMSFwjz585X2VlE8lsexF
         n019HjEIDp1AtMmCQLGQC5IKm2fqxMe4sraMScgA9U2PclaIivVOZVvujtGLyqlmBlPY
         eTmpuoFB6R3m+b4qpjxW6GHczy5e0DhdFC+uhtm9S373l0nTWZQAX5I31rmBMRR73qeG
         o6FFsofyv5O1bjyWK/1cQWorwAPp98fmnUjkfCj3TsDFgssmLX+8llUd+90GUX6u3mg0
         /VKnByzZePRl+qi+hWMMKj4QOBrpPR2VVCyG8GsW45QBhgwNkz1hXJ5dhQ0cjWNRFl04
         eJiw==
X-Forwarded-Encrypted: i=1; AJvYcCV1kEuATmoxICKnRY3hJpAhYuJHjqsb3aOVOKnqpeYit5Z8n6F4qPG6hcrOw0rl2IMLUZ/BoZ8TV/IrE84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8142nxopXWmi6XUGEYr+xVdaIZSBZTfHmwyLTjHZaL+bIs+i
	sFvh4FLRsNEnT7U/6ERcbgYJJ4Z7fMoPY9XxZCe6lcjeU//r3gOFxf1pRb2CuOZ1cPZB9RNPvFi
	/+vZVYoDeItgW3X+3aUbULdJze2ak/3LGGVp7xrN5kYNw34e1I+MxJ7IuXtN9luGT74j9Gn2e
X-Gm-Gg: ASbGncuyta/ZtvRhddkNS+vZ6O4TLzDbVUjzNJcIG9UVkbxeIHs26sIXzoGn6T0A7I/
	UPw2ZON4hb6z3Ub4tiSB07KR9JLEH4EaR7/8EvWZVWj6jArIk4jJDfMDDAmUo8Lr6z8KSNlblhh
	CeU4Ptf718pRo+92/LISFewkzM1Rn8RUk0uv1Ohco6Zl4xtxwT22ia4thUpiJF18EUSCjNr93KR
	L3rG0ouTw56OSboUym2O6QofjGR+gxVLlgUewTbSFo3xh1OEAjELWASDGFdtVizcH9MRVBXlypv
	x6VTUq0+cUGgadEhNy1J6YNncWhyqwinCFT+GU0+xElUTyT60ZW378V7oUwgEqz6vUp7qxfcefp
	xE299kINIp5jTnwQO/zVBs0eJsrUEp095SRcyJpWcX54=
X-Received: by 2002:a5d:59a2:0:b0:390:ff84:532b with SMTP id ffacd0b85a97d-390ff845589mr3552466f8f.7.1740996087023;
        Mon, 03 Mar 2025 02:01:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXZqIa1M7mGR2dYNXiAZ4lWYbl7hOIdDdeUw6ofOE6vBxI8shgA38Lt8+iwmpijQWMi3sT/g==
X-Received: by 2002:a5d:59a2:0:b0:390:ff84:532b with SMTP id ffacd0b85a97d-390ff845589mr3552443f8f.7.1740996086689;
        Mon, 03 Mar 2025 02:01:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b737043aasm152241565e9.14.2025.03.03.02.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:01:25 -0800 (PST)
Message-ID: <78d55e35-6cda-4f5e-8e52-0a54b1e64592@redhat.com>
Date: Mon, 3 Mar 2025 11:01:24 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 catalin.marinas@arm.com
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250219084001.1272445-1-quic_zhenhuah@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250219084001.1272445-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fs16cwtzG0rd
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714817.24139@cMKZm8uXqOZP4BL3buRdAA
X-ITU-MailScanner-SpamCheck: not spam

On 19.02.25 09:40, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> The first problem is that if start or end is not aligned to a section
> boundary, such as when a subsection is hot added, populating the entire
> section is wasteful.
> 
> The next problem is if we hotplug something that spans part of 128 MiB
> section (subsections, let's call it memblock1), and then hotplug something
> that spans another part of a 128 MiB section(subsections, let's call it
> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
> the entire PMD entry which also supports memblock2 even though memblock2
> is still active.
> 
> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
> fix similar to x86-64: populate to pages levels if start/end is not aligned
> with section boundary.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
> Hi Catalin and David,
> Following our latest discussion, I've updated the patch for your review.
> I also removed Catalin's review tag since I've made significant modifications.
>   arch/arm64/mm/mmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b4df5bc5b1b8..de05ccf47f21 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1177,8 +1177,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   		struct vmem_altmap *altmap)
>   {
>   	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> +	/* [start, end] should be within one section */
> +	WARN_ON(end - start > PAGES_PER_SECTION * sizeof(struct page));
>   
> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
> +		(end - start < PAGES_PER_SECTION * sizeof(struct page)))

Indentation should be

	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))


Acked-by: David Hildenbrand <david@redhat.com>


Thanks!

-- 
Cheers,

David / dhildenb



