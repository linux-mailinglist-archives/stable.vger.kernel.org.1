Return-Path: <stable+bounces-164894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B4B13741
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B6188F1F5
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A83221FD8;
	Mon, 28 Jul 2025 09:09:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 057272153D2;
	Mon, 28 Jul 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693755; cv=none; b=Y42l4Uo/UYvxgWhx+dQrNGDA6gUPy0gf++PUtqcNdqnbBUqE+jBqO1LEfzEWLcQh0k6akn8l/gECObfWCBb5uO2ItO2IB5G3Qyde5LHdgh9WhsE/0K1vppAhwpJ6OCRNoPB1kzAjKEb6ojQAOoS8L6HwWsEPe8jJDTWBP+W5Js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693755; c=relaxed/simple;
	bh=zTwpBlCjv12NPLXvm+OhPgR26zsqq/JSgr70P60hQGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=XCC7SPIvun9yDtwTZkWB8KazNvYgB5msuuSs2WS3H2/t/3gPDzmyaNCGU9w1hu8qHjvYa9fmW0aqABAifC/llWoLzlD3wr0rudmK+wMLzLeHBWUWWUwfYq6bfma1RGvuiXkTJ6tlcvjkpmM4yD7BCs7w/NgFJgB84AHglUMlNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id E6535602A11DF;
	Mon, 28 Jul 2025 17:08:57 +0800 (CST)
Message-ID: <ab080493-10cd-4f3b-8dd3-c67b4955a737@nfschina.com>
Date: Mon, 28 Jul 2025 17:08:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity checks
 if object is invalid
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <aIcJdhoSTQlsdR5r@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/28 13:24, Harry Yoo 写道:
> On Mon, Jul 28, 2025 at 04:29:22AM +0100, Matthew Wilcox wrote:
>> On Mon, Jul 28, 2025 at 10:06:42AM +0800, liqiong wrote:
>>>>> In this case it's an object pointer, not a freelist pointer.
>>>>> Or am I misunderstanding something?
>>>> Actually, in alloc_debug_processing() the pointer came from slab->freelist,
>>>> so I think saying either "invalid freelist pointer" or
>>>> "invalid object pointer" make sense...
>>> free_consistency_checks()  has 
>>>  'slab_err(s, slab, "Invalid object pointer 0x%p", object);'
>>> Maybe  it is better, alloc_consisency_checks() has the same  message.
>> No.  Think about it.
> Haha, since I suggested that change, I feel like I have to rethink it
> and respond... Maybe I'm wrong again, but I love to be proven wrong :)
>
> On second thought,
>
> Unlike free_consistency_checks() where an arbitrary address can be
> passed, alloc_consistency_check() is not passed arbitrary addresses
> but only addresses from the freelist. So if a pointer is invalid
> there, it means the freelist pointer is invalid. And in all other
> parts of slub.c, such cases are described as "Free(list) pointer",
> or "Freechain" being invalid or corrupted.
>
> So to stay consistent "Invalid freelist pointer" would be the right choice :)
> Sorry for the confusion.
>
> Anyway, Li, to make progress on this I think it make sense to start by making
> object_err() resiliant against invalid pointers (as suggested by Matthew)?
> If you go down that path, this patch might no longer be required to fix
> the bug anyway...
>
> And the change would be quite small. Most part of print_trailer() is printing
> metadata and raw content of the object, which is risky when the pointer is
> invalid. In that case we'd only want to print the address of the invalid
> pointer and the information about slab (print_slab_info()) and nothing more.
>

Got it, I will a v3 patch, changing the message, and keep it simple, dropping the comments of object_err(),
just fix the issue.




