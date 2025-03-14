Return-Path: <stable+bounces-124401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190FA60750
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 03:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B747AC768
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8517588;
	Fri, 14 Mar 2025 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk0PK8VK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939374400
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741917837; cv=none; b=PQYR4yfd3TPki5DFWAotZAvNQ5kfkLRGv1opVcxDNGQ+RIoOITVo8KvwLGJQ9PsZH90OkcSuoJVcfIsV24EgMeG7Yn/A+yPmHmDxmC7ylOa+nDBDBZMtCLXqkONALjENvjOXschSJbotNuRimJswjV8G5poXcRpEPkdd1JZl5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741917837; c=relaxed/simple;
	bh=DwnAe936WNFHE56hSPpmECMfcvpUnaIiV2GMiclU0fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT++Sq60J8O5w3VBYRsZZBsJYEFPC8Fe24b7EyspCrLgRBQ7OW9cUylVPDuc2zGDp7qENv9ne/KQhourNifg6emdCfoi/majkhO2K3XryXm6OOSQhudGmJtjs1ylrHZRpsxXyELnFP1iJTdyENLfbnenSvLJFfe1D08TeabH3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk0PK8VK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso313397266b.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741917834; x=1742522634; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9nzqhOs6/BKnKTP8r2tL1HYa8XPeB9VU/fRQe2zQtY=;
        b=Jk0PK8VKVj7aRKfPID8vCRmfAY0xJ65nxoKeANp/kI4PY+mqmZ1p3y16/5KWkfTpbp
         ZF+VXYptay2JzCrjxeUYsjT1qHRCTp+sdXkQh9og7SimwMkWKN6zRrOffQCrE9JL2Els
         c+rRfN0fNvQn2S+D6+k9FUOCbzUpQ9GctD4L0U7gkC5m1ZBnkd4EP5gFjWDr+sZteItO
         /QrqCHx8vtD7QbVH9HZySehCS9Ow6VEuD1Ma7I374boH+uRTsIMCPQj39tiz+UDNWBJz
         OeJdpZhYjL9bnBq7/9Dss39TU1h5cuh6OAvjuTz2dP1PQKzP8UzXbaUUO7s+WnlgiEH9
         woBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741917834; x=1742522634;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9nzqhOs6/BKnKTP8r2tL1HYa8XPeB9VU/fRQe2zQtY=;
        b=qPaHKkQUKX8q2QoRU0lUti1qPy8scgUgXsftmgQCHscYqXEDVJtNVi8+1egHkWcO6N
         WZBALXc+GfN57JUH1zsD1QAwgdy//09vGS5aaMX76748gIY/hiI/DPQIcQZZI6KpyOTR
         4iFoVsbyvi7xMBFsqogXwko51G22qCHvv8yKpfcxrCDL+I0Gu062KdbPHPcirioBGw+N
         U02xQK33eltqynqgZFPyFovOM9PI+59al1u+N9me1+z+jzvDdpMMq4dhGw7j3JIn8F9P
         OZFVC4dxi0bpkFxUaTZ6o9QfB01WhoOt/iRtbAGq0Q+xfLgpZSCwwZEFqwb4YR8X0MZk
         0xRA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6OxtBcBt60r2GptVWQPnYuRIh+ljARWfGQdA0oQKLwyK5y/6qVoBvQilg0I0ZtpNfzphCCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0cfF1/A21eQCh69UKiCiqUAoDA5NgE6JaWr085CnXxEq7Clb
	idtJ8WO7rIL9345cxcnYZhFu8Mgnd1wM7GnYdwK/WjkPbUW48MOS
X-Gm-Gg: ASbGncvT6XdshJspiXHuxk6nTtssfKiaOa1URqiQ2xmOwKHkaYWhijdbyflL15NwB0u
	/1z5pyyuUSLrXPr4wipV7kMwggyf50Q77diswddzTMM6n0ZI/XOtP61pP1xU4vB1m7fV9/jnkEX
	pY3RDIy2ibN8KRxll60Lp6BTTy9VLigYMIUy31XzWRxvCludzJ2zU1reoDXWLVTEJDXJMUh/Nae
	gvFRce/nE4xXacd/0kSauTCfGSRbfOaogSlG/pI9QE2iRWsipyTQsL3WC+8+T9ncoX0LcudplsA
	4guSY9mHnsThuSnbcsvTshN95Ekbc4BWTZLxQm3VrNxS
X-Google-Smtp-Source: AGHT+IGNkXV0HoLuhIBynWg2XSX8uwSHfvFnIHdrebc7kQOopUuWC6IbyA1ceGrcZeHOhxwZZrVtFQ==
X-Received: by 2002:a17:907:3f9f:b0:abf:78b6:c565 with SMTP id a640c23a62f3a-ac330105aa3mr56107066b.4.1741917833593;
        Thu, 13 Mar 2025 19:03:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0cd3sm153836266b.70.2025.03.13.19.03.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Mar 2025 19:03:52 -0700 (PDT)
Date: Fri, 14 Mar 2025 02:03:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, Yajun Deng <yajun.deng@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memblock: repeat setting reserved region nid if
 array is doubled
Message-ID: <20250314020351.bgdjmdjqnobu77s7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
 <20250312130728.1117-3-richard.weiyang@gmail.com>
 <Z9L0z6CNZjh3V8A7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9L0z6CNZjh3V8A7@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Mar 13, 2025 at 05:07:59PM +0200, Mike Rapoport wrote:
>Hi Wei,
>
>On Wed, Mar 12, 2025 at 01:07:27PM +0000, Wei Yang wrote:
>> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
>> a way to set nid to all reserved region.
>> 
>> But there is a corner case it will leave some region with invalid nid.
>> When memblock_set_node() doubles the array of memblock.reserved, it may
>> lead to a new reserved region before current position. The new region
>> will be left with an invalid node id.
>> 
>> Repeat the process when detecting it.
>> 
>> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Mike Rapoport <rppt@kernel.org>
>> CC: Yajun Deng <yajun.deng@linux.dev>
>> CC: <stable@vger.kernel.org>
>> ---
>>  mm/memblock.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 85442f1b7f14..302dd7bc622d 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2184,7 +2184,10 @@ static void __init memmap_init_reserved_pages(void)
>>  	 * set nid on all reserved pages and also treat struct
>>  	 * pages for the NOMAP regions as PageReserved
>>  	 */
>> +repeat:
>>  	for_each_mem_region(region) {
>> +		unsigned long max = memblock.reserved.max;
>> +
>>  		nid = memblock_get_region_node(region);
>>  		start = region->base;
>>  		end = start + region->size;
>> @@ -2193,6 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
>>  			reserve_bootmem_region(start, end, nid);
>>  
>>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
>> +
>> +		/*
>> +		 * 'max' is changed means memblock.reserved has been doubled
>> +		 * its array, which may result a new reserved region before
>> +		 * current 'start'. Now we should repeat the procedure to set
>> +		 * its node id.
>> +		 */
>> +		if (max != memblock.reserved.max)
>> +			goto repeat;
>
>This check can be moved outside the loop, can't it?
>

We can. You mean something like this?

diff --git a/mm/memblock.c b/mm/memblock.c
index 85442f1b7f14..67fd1695cce4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2179,11 +2179,14 @@ static void __init memmap_init_reserved_pages(void)
 	struct memblock_region *region;
 	phys_addr_t start, end;
 	int nid;
+	unsigned long max;
 
 	/*
 	 * set nid on all reserved pages and also treat struct
 	 * pages for the NOMAP regions as PageReserved
 	 */
+repeat:
+	max = memblock.reserved.max;
 	for_each_mem_region(region) {
 		nid = memblock_get_region_node(region);
 		start = region->base;
@@ -2194,6 +2197,13 @@ static void __init memmap_init_reserved_pages(void)
 
 		memblock_set_node(start, region->size, &memblock.reserved, nid);
 	}
+	/*
+	 * 'max' is changed means memblock.reserved has been doubled its
+	 * array, which may result a new reserved region before current
+	 * 'start'. Now we should repeat the procedure to set its node id.
+	 */
+	if (max != memblock.reserved.max)
+		goto repeat;
 
 	/*
 	 * initialize struct pages for reserved regions that don't have
-- 
Wei Yang
Help you, Help me

