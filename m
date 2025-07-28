Return-Path: <stable+bounces-164870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC3B132E2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 04:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF91170726
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F113C3F2;
	Mon, 28 Jul 2025 02:06:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ED9252E62C;
	Mon, 28 Jul 2025 02:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668413; cv=none; b=fPoMBZ9jek5Ka6wVvZbGspgZm8FIoGC2rpWlBjT/CPgEHzOCZ62Zm17jWzsTdKBI6hT9/DUOc/fTeQ433OnJLL9Ktbcc8JFmLXNfW68a058jFsoHIGX83Jf3jz9f8Hl6qCDP5TTX22Bn6jfO2hXLflyJy5nVsNR14nvv3wHIEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668413; c=relaxed/simple;
	bh=KtcrmW5WCqvDoEaHTiCg7QZuxoNla7Wim1WhTTKLCBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=B0WWgAlabWgHCUO3ZR6P9QhWBXzX/jWS9Z/HBYQOmT3/O1XgQZu2Kn6VF25dlyTAqWg+15U0rNRepMy3z+fEUgy4oc9bKnX5vU8oWmFxrPZez/P99UeAqG2WB3NBxv1xcweERnV8ITGXB1zOIcT38YauayYqIYZjE5K82peGQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id C72CA60108C4C;
	Mon, 28 Jul 2025 10:06:42 +0800 (CST)
Message-ID: <e6f14d8a-5d32-473e-ba2d-1064ab8ef8fe@nfschina.com>
Date: Mon, 28 Jul 2025 10:06:42 +0800
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
In-Reply-To: <aIQMhSlOMREOTLyl@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/26 07:00, Harry Yoo 写道:
> On Sat, Jul 26, 2025 at 04:55:06AM +0900, Harry Yoo wrote:
>> On Fri, Jul 25, 2025 at 06:10:51PM +0100, Matthew Wilcox wrote:
>>> On Fri, Jul 25, 2025 at 06:47:01PM +0200, Vlastimil Babka wrote:
>>>> On 7/25/25 08:49, Li Qiong wrote:
>>>>> For debugging, object_err() prints free pointer of the object.
>>>>> However, if check_valid_pointer() returns false for a object,
>>>>> dereferncing `object + s->offset` can lead to a crash. Therefore,
>>>>> print the object's address in such cases.
>>>>>  	if (!check_valid_pointer(s, slab, object)) {
>>>>> -		object_err(s, slab, object, "Freelist Pointer check fails");
>>>>> +		slab_err(s, slab, "Invalid object pointer 0x%p", object);
>>>>>  		return 0;
>>> No, the error message is now wrong.  It's not an object, it's the
>>> freelist pointer.
>> Because it's the object is about to be allocated, it will look like
>> this:
>>
>>   object pointer -> obj: [ garbage ][   freelist pointer   ][ garbage ]
>>
>> SLUB uses check_valid_pointer() to check either 1) freelist pointer of
>> an object is valid (e.g. in check_object()), or 2) an object pointer
>> points to a valid address (e.g. in free_debug_processing()).
>>
>> In this case it's an object pointer, not a freelist pointer.
>> Or am I misunderstanding something?
> Actually, in alloc_debug_processing() the pointer came from slab->freelist,
> so I think saying either "invalid freelist pointer" or
> "invalid object pointer" make sense...

free_consistency_checks()  has 
 'slab_err(s, slab, "Invalid object pointer 0x%p", object);'
Maybe  it is better, alloc_consisency_checks() has the same  message.





>


