Return-Path: <stable+bounces-183003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9CBB24A5
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 03:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B84189A376
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D446B5;
	Thu,  2 Oct 2025 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvKW1Ghi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE63C33
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369570; cv=none; b=LKV4Y6zpOuh/eBjh+sc4jsUlXmax3tDL243DNzXBvgehXmUv7wQrJ006M6kLecLg7YSzjV+speZ0EoS7vP8TrqQCegPrlqc6sNk6MpsZMLN9U4VhDp/wR8DDvQWJShSqwtl9o2QipIrLHU0sAikbLiOWqUH3qh+MpQh2MCaCdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369570; c=relaxed/simple;
	bh=up/T6Dc7mr8fc3iJMDUkN2JSekxIApz4YRizv7qxyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL/tp8grUNl4pJOyge+/+FKOLdDpIhQ18fZxbbFJplBnpwjLrFsO2OuhRx02F60ul5B2fO4LwIjtJ/+/rUE41vS/Gb/SBNo8lZs1uOaShIpG/bQBzpeRR6EDlT7FpoR12KxEUT/jVMb3RtXTEhTk6TUsBoLpdk9kIKU6qlTHpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvKW1Ghi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1076456a12.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759369565; x=1759974365; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xHe/BzI7Wn0nREN3sG+EtbX3FgeLXjNJMls3Nfj1NQ=;
        b=cvKW1Ghi0bjg1Mk3tgETbxIeiGPUvF6xdwVvNhXw3pcwZhGEIAJFIxYKz2Fm8huqft
         83y0Tfe7ZrinGBx2NOp3OC0kRv4hZ0rrVvC7Y2hTykTJ9QwJ7TQ83T7/Zxd7n2ABBAfO
         Smi3tVvRxMFQgKQdrqt63J/C1fmjWEMYdPFLHee9pvtmTuck5+Ol50R5VOGlO05w1zv0
         XpGXe0RMJ0AbR26ih1cfgPqGJp8Guzb5NvP5B0pW4eg2WRStdQvHg2xu3F03TWzRwwtS
         O0/K7QwhynzKrHy3yL3M7u09RebA4v6g9ckyPI8XiegsC+LthNvjo4i4RufpKEG/NSXP
         sjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369565; x=1759974365;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xHe/BzI7Wn0nREN3sG+EtbX3FgeLXjNJMls3Nfj1NQ=;
        b=o1lULoHL5f9116XVdCixKvVi2mhqRI/Dd5RXsNdwaKydsJo66htWXgswi/YpLY3R7h
         C9ITsT1wb4RJNTqkDl7jicQj5+vmFBmEXr7OTrcmJUoYJKBj75erZE5KTTXJtUgIr9Iv
         nevmkDm1MmEjz7+djFs2ta9b44SUPvlnwExMkX331n4A/xcHvUTUx/dLCZFdrW5I7WCM
         81PLGXBTYwKGEXUP/FIHTkSak0X35FxM4zemGsFu7OcoYyoohB5FOfSneRnTNLZNRG6k
         4bk5SCzpmbIPghuF1824eagdB2ej+b/HYYWmc5FriUp0Wd/Mm6rP/51hsqC4MzQKqAx0
         +bxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyeDq8lNIpeK0gFxGiOLIncsqV2/KDQsLgPGQ9HGX8CoXEbNGw45QSqzR3rfJVc9Jt+ZXStL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KdCPK30CarDL0F3eg7xR97CvTe+NNAtvRbNq1pknOsPawUDr
	4bLtsND2BcKO+HLMjM5OtJ9hfrX5/gLXxcNuZK4y5ix7BoY/ZS81kADu
X-Gm-Gg: ASbGnctALkS0AFMm9KujwN2zSs7rTsG6W6Nl91vZ/WuyAbmKCArrJJBpF+KLR4BVcj0
	GMSEV+3WoRQljaHkCY7/EvHLwiqpVRfC3igU8zh7CAzVaumQki4EjdNL+/kZIIKrWh2VwVQRf4w
	3NS141+Ni8cV85EPJXIvnRg/bztzy68gyTL6CaVtK0bMuSq0FL/w1F3WAShFMkuXYNP5N4ofZXT
	e1eK2MdlSFp9qlsSWUuMtPnRGTGVkEHCzuJiMjRt9YBnqePhyBTkQOmShqCDa9SIHloPxk9lpsV
	Tf2g7ksgNjbjsJfrdeCVWl6qviNOm/Mh8sXQZH4vcoTchYIDc2PiB8aLgjcA74gG7rGyYs1Inm/
	EtrjQp/Bs2td+uQeoXUwg2ISmquE1DP6NArqKFq9eoh7I8GG6lg==
X-Google-Smtp-Source: AGHT+IGRgLhCs6G3HsEK2WLx4hBYdgbS142jXanEuUtlsvPi9RCUlq5c5Mm2HncdU0tePK8y2sKKTw==
X-Received: by 2002:a17:906:68cd:b0:b48:70a3:d45a with SMTP id a640c23a62f3a-b4870a3d69amr97232966b.64.1759369565026;
        Wed, 01 Oct 2025 18:46:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm88540266b.7.2025.10.01.18.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 18:46:04 -0700 (PDT)
Date: Thu, 2 Oct 2025 01:46:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	wangkefeng.wang@huawei.com, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Message-ID: <20251002014604.d2ryohvtrdfn7mvf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 02, 2025 at 01:38:25AM +0000, Wei Yang wrote:
>We add pmd folio into ds_queue on the first page fault in
>__do_huge_pmd_anonymous_page(), so that we can split it in case of
>memory pressure. This should be the same for a pmd folio during wp
>page fault.
>
>Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>to add it to ds_queue, which means system may not reclaim enough memory
>in case of memory pressure even the pmd folio is under used.
>
>Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>folio installation consistent.
>

Since we move deferred_split_folio() into map_anon_folio_pmd(), I am thinking
about whether we can consolidate the process in collapse_huge_page().

Use map_anon_folio_pmd() in collapse_huge_page(), but skip those statistic
adjustment.

>Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Lance Yang <lance.yang@linux.dev>
>Cc: Dev Jain <dev.jain@arm.com>
>Cc: <stable@vger.kernel.org>
>

-- 
Wei Yang
Help you, Help me

