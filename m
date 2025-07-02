Return-Path: <stable+bounces-159180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246ADAF07F0
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F048F3A3E79
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F415665C;
	Wed,  2 Jul 2025 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nA9zp2rI"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124C2F5E
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419791; cv=none; b=bdOz5JT/D1Lq0a+OGOeNw0NRWpnUUyLlnpLBscDcrcIGodsOkZJPuWVUN1J/4AnCXgcM2bsbctuR4wJvMxxvrHW/i9/pt9CpEpXIFSlNbI7vdNg/bSGjWiwX9Y/YDhXGYPtRE6P21hKfr2F9r99StaHynNqjQ1bL9y3A9rEY71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419791; c=relaxed/simple;
	bh=LDHM7jGxCnd+mr9Ygrzv5SVJP6Dmjk2nPKWQT0VRW/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ6updkPGzrCav9GLmX7QQKcrSk2Rcn1tpWvU+ydJwFA0Fbmh+oEpFUOjA3vlnxPVcUtra/FuzBsq6F5CXwTSDshLwXJVX54vVJjVKgH6nFX0PvRnyXPfA/QLu5T6R54icgt2H4DnrgtpAkSeul99sN8/j81hLry3oRi+/I7kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nA9zp2rI; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47333b7f-2eac-4f57-a9d2-2a7f24c8fa7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751419786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPrS94lVOu7EmI9PYREdDlh0EO6H/zNHIWs+MvCReBI=;
	b=nA9zp2rIDXqL4jzjAR5plfd7uB0j/RUUL+bdMkXsWvyT5PSap3GreV6kZ7o8P0xqNqRSG3
	RzIcf1e9N92AKYdX/uvjqrwzkuME1+dZao9Qp0+McCpbkHZvDe0FWsQk4e5lfn4MPie2qm
	32F5oEnaKg4aRZTbjls//FK0VXFIMAc=
Date: Wed, 2 Jul 2025 09:29:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
 huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 mingzhe.yang@ly.com, stable@vger.kernel.org, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
References: <20250701143100.6970-1-lance.yang@linux.dev>
 <20250701141705.ff1a446e6a25d7970b209c3e@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250701141705.ff1a446e6a25d7970b209c3e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/2 05:17, Andrew Morton wrote:
> On Tue,  1 Jul 2025 22:31:00 +0800 Lance Yang <ioworker0@gmail.com> wrote:
> 
>>   - Add Reported-by + Closes tags (per David)
>>   - Pick RB from Lorenzo - thanks!
>>   - Pick AB from David - thanks!
> 
> It generally isn't necessary to resend a patch to add these
> things - I update the changelog in place as they come in.
> 
> In this case I'll grab that Reported-by: and Closes:, thanks.

Ah, good to know that. Thanks for adding these tags!


