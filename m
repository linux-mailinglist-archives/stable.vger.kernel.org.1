Return-Path: <stable+bounces-92192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDC9C4CF7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 04:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6A1F22664
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEE208207;
	Tue, 12 Nov 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GaGLh1uD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AA41C79
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380425; cv=none; b=FAywWI+y4SbZ7QxaK43WFE3np/4p0eYWgiz73NSL+OjRlHKOP6hcjDV1wnLMtkT4PGxxl6cBR95A/aX2/UGQhU41mA9DiY4ZVcUKXEWr6WAYY/z4H9NQcI++KvjNVfjPl0s8YUV4tga/zgJG/rRQxaNRRuQwerTry+E2tsdFYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380425; c=relaxed/simple;
	bh=6GsdMoVa3LUEHK2wF1+xPRNzhsPIrBU+Al5MIohrZVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDsB8/lzqU4S/k0MipAEvuejs8hkkstQPUchLp9KzmqfB0ws8y3+w/b/YgBBUuOOMxRgXYPREl5SLvY8cV4qPJRP33C8kyPZU7ocfQKdYrlOxo2HctCrYB9L7I9/EhOFDYrpDlTe//1crZOip/zNQ1re4/YYI8V6rW0vONpxMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GaGLh1uD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso4720252b3a.2
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 19:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731380422; x=1731985222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQIeU+qvnYSU4ZedZcP14zpaC7KKw5Tkc9gQ0PjM+Bc=;
        b=GaGLh1uDy6yrPT7/JvWRyBNScV4jPPLI8J+3oaJZVAQ0M7esWw7UDGr6yzaS+DTORH
         hMXaehPRqAEVuI1BP9k6+L9AkQmGByW+zuGBmXwM5pMRrl0ipSOeGR+Vkjp904O0vhOG
         N0SnZEBj6XViTq6SJu3vvc6ZCYOUjcXqrAz1KIHqvDkCdc3h3fe2v69tO0Ua1m4oQ8O6
         tmYXjw4FfOgOXBZMASheYcZCZjLL8fJSFDVGi6jo6LKt5XfvfQD3XflL8HhFfsMABUJ0
         OE/N6YMbYbWqUE6dwQmXHHCtTBIbJLUdb3rqgJsNGnELDWqfv+9pZjQLurZmP4fhvcx6
         PK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731380422; x=1731985222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQIeU+qvnYSU4ZedZcP14zpaC7KKw5Tkc9gQ0PjM+Bc=;
        b=ecEmN1sJxD+EShamKbtUsBCGq85v1dTXRMGaskq1mvofuBY5o3xjz+tv2OuGhqOMdl
         MhQDTNZwLLdBb60FQAUaQsHyiSXFGQwEAp/9DWRSb4nwR77uMTsHP5QvahE20fLvf1EH
         N8rrqXbPvJe9WEjR2tFkgchlHn6+e92lkvPvsBGfGh+JmaKPt9mWvDJQgTfBs3bIujBf
         71JhsXUtogw2H+RisdtBbh2YZ9a88aX3WdYUKJy1CIhoWZqz2E+S4dr4kBYAXGy054w7
         WnoqB8yiO48OVAnPE0xRwnPPcTvKpQx/9pQDSPBP6Mk/g3BVJqPvx33fykLIGP4fwplp
         hPcw==
X-Forwarded-Encrypted: i=1; AJvYcCWgdvf+lLkg+37+8HPdM5jktUDkc6UDmRYrrnCB8EpQXZGG7s32UuWXD7b7Rq9bgjkMc0qqQ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dCnoRwX+mUcM9130A3ozXd6meOIvEpJquO3RfzDqIU0zUQJQ
	XdSlbxKvwOqjTopq2G/zi6vy5wBweS0coNBi0ki3vpq5OTIpujHf3MiiWRaRUUM=
X-Google-Smtp-Source: AGHT+IECmebCe0C3eC5A89IqXoc7u6j1btXfcCdhzi51PjOOnZyDiBoBbSOx7e5oxo+FNUP7RqUJeA==
X-Received: by 2002:a05:6a00:114f:b0:71e:768b:700a with SMTP id d2e1a72fcca58-72413368f1dmr21094787b3a.23.1731380421646;
        Mon, 11 Nov 2024 19:00:21 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571ccsm9841488b3a.196.2024.11.11.19.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 19:00:21 -0800 (PST)
Message-ID: <9d1a9d6c-5c3d-401f-8646-828bb9c282cd@bytedance.com>
Date: Tue, 12 Nov 2024 11:00:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix address wraparound in move_page_tables()
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 03:34, Jann Horn wrote:
> On 32-bit platforms, it is possible for the expression
> `len + old_addr < old_end` to be false-positive if `len + old_addr` wraps
> around. `old_addr` is the cursor in the old range up to which page table
> entries have been moved; so if the operation succeeded, `old_addr` is the
> *end* of the old region, and adding `len` to it can wrap.
> 
> The overflow causes mremap() to mistakenly believe that PTEs have been
> copied; the consequence is that mremap() bails out, but doesn't move the
> PTEs back before the new VMA is unmapped, causing anonymous pages in the
> region to be lost. So basically if userspace tries to mremap() a
> private-anon region and hits this bug, mremap() will return an error and
> the private-anon region's contents appear to have been zeroed.
> 
> The idea of this check is that `old_end - len` is the original start
> address, and writing the check that way also makes it easier to read; so
> fix the check by rearranging the comparison accordingly.
> 
> (An alternate fix would be to refactor this function by introducing an
> "orig_old_start" variable or such.)
> 
> Cc: stable@vger.kernel.org
> Fixes: af8ca1c14906 ("mm/mremap: optimize the start addresses in move_page_tables()")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!

