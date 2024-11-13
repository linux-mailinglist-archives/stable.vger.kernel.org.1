Return-Path: <stable+bounces-92895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF909C6A5D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A900B22FBA
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A73189BB1;
	Wed, 13 Nov 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmbw9E1i"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B4189BA3
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485538; cv=none; b=YB3FpAFb1n3ft8bHgp8w7kZ96vgNcl1YRrPkkgaQUvRbyPb2bKiit2cWaRgjea+iAwzU5Ei97HlL1hkZZ2jm+dQlfE4E4hkfxt3MLRuDRMNFM6ARKQEQZGh07dxlhwzsr1kLp6zQvvDMQAha1L3AcqVJbA39uRkCx77yusSGfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485538; c=relaxed/simple;
	bh=Yp+DdTd5tS4y/3kzdSbctUdzP2JXwjxcZJcTy7krPWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0Zw/JeHYl2hNfno8fPpBw/jrXwjh9odtr8LsB0Hjq7InMx0WvVsMImOwvArvloqLNXrAQYrqerdgmp2QE+ttxY/R3hiUrLT6nc/m4xHhs6ZSFEJUERKCJOdStLtP3S4kYiwI+enFGlIwuJjH0DVozZmOSCSRhryPKI6SouBK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jmbw9E1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731485535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f2DFQVsBAGY1m5Kkcs4MSbmZ7EM3cV/eTu8ojWA2Swc=;
	b=Jmbw9E1ifQTpcUI6LeApwyc5Wy4vVdgnPlAJo/EnlU8g1yjfGo7qMm6cInU7XFccDom6hi
	GaUiNjsDUQD1cr9/sx0rHUDXlw3tFnWmvnpc7+kFul4c9J4+zAo3ODC2IZ2vXqffEQT9lW
	gSPCOFxZnBR9AqoS9DVWe7AzX5wrrWQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-X66dIn2vOVSPyoopQro9Cg-1; Wed, 13 Nov 2024 03:12:13 -0500
X-MC-Unique: X66dIn2vOVSPyoopQro9Cg-1
X-Mimecast-MFC-AGG-ID: X66dIn2vOVSPyoopQro9Cg
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539ea3d778dso4826451e87.1
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 00:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485531; x=1732090331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2DFQVsBAGY1m5Kkcs4MSbmZ7EM3cV/eTu8ojWA2Swc=;
        b=vmq18vCxB+TDsXBo3agUV/jkh4dhtXCi8Zq6u6vD4S81jbamdhuUDmQY5OXLKuY8bE
         TO5dNkVoj/VW/ni//Lkgv2D60Vk5GNsOPetgGoqKJ5OGqtvikv0uhAhLC9ZRmYXqoz6G
         /Tv8JNcEL5DHfkjAfjsAaFAzSv8Hg0em0wt4aUPPpYUvuvnyawpG+5O20/75fl2ZDf5k
         rewNbQrzxtd1VhQ5gCF/o0pNKfh7JkU2SxSX7O4Z2S+3YnDjQkqFTnUaGl6pEYOATRgE
         FKUCkDRQBJ4bOqzGBYXUYZhnjLIZXKXfAiJFN8/7gf7dP99EXQCqZewDWiUZQrJikEh/
         wx/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2zQblFxIYmjrz7FttzsdVSa0w7Wht2XKXNERBTCML389JN5emftnp5yv6gOsYJ8I9ajrAvhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZcBoMwQt6M3sVDwlr0AJTxaVRRLTfcTymBT02gnE7HQC8awa
	pA7NZC+FDCE52vIyOk6nB7IxOBgIiP5g6nUnQzsdB1bMN0f7y29E9rTuGrYNdiKTy6tXOwe8VyK
	6HZFJeB0wMLoQAlyLmv7HzkrYhVuBR2f3cGYles1unjcZkaha4epAUC59mtHbDg==
X-Received: by 2002:a05:6512:b09:b0:536:a695:9429 with SMTP id 2adb3069b0e04-53d862cd111mr8395519e87.10.1731485531563;
        Wed, 13 Nov 2024 00:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzJNEVK2riG00OAB1503n2yPauBKRMcHzwQCLTvVXlvyZQBxxt33zmCl8bKNqkYPAPz8FOdQ==
X-Received: by 2002:a05:6512:b09:b0:536:a695:9429 with SMTP id 2adb3069b0e04-53d862cd111mr8395496e87.10.1731485531084;
        Wed, 13 Nov 2024 00:12:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d7d7a223sm556885e9.11.2024.11.13.00.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:12:09 -0800 (PST)
Message-ID: <70c28250-f119-435a-9cbe-778fe80beab0@redhat.com>
Date: Wed, 13 Nov 2024 09:12:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20241108141710.9721-1-laoar.shao@gmail.com>
 <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
 <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
 <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
 <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
 <ZzQo2JrXbGEkpPqb@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzQo2JrXbGEkpPqb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.24 05:19, Matthew Wilcox wrote:
> On Tue, Nov 12, 2024 at 04:19:07PM +0100, David Hildenbrand wrote:
>> Someone configured: "Don't readahead more than 128KiB"
> 
> Did they, though?  I have nothing but contempt for the thousands of
> parameters that we expect sysadmins to configure.  It's ridiculous and
> it needs to stop.  So, we listen to the program that has told us "We
> want 2MB pages" and not to the sysadmin who hasn't changed the value of
> readahead from one that was originally intended for floppy discs.

If something can be achieved using MADV_HUGEPAGE but not using 
auto-tuning (ordinary readahead / no MADV_HUGEPAGE) it's a warning sign 
at least to me ...

FWIW, I agree that the parameters we have are confusing. But selectively 
ignoring them ... I don't know.

If the parameter is effectively useless on some devices (except floppy 
discs?) maybe it should be set to "0=auto" (and modification attempts 
failing/being ignored) or simply ignore for all of readahead.

Anyhow, your call. I'll see if I can make sense of the code and come up 
with a comment that explains the situation.

-- 
Cheers,

David / dhildenb


