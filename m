Return-Path: <stable+bounces-56053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A868991B6C4
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A6D285712
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA164D9FE;
	Fri, 28 Jun 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZyHZqk/X"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A01CF8A;
	Fri, 28 Jun 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555082; cv=none; b=E2nd46cVckZHurzjzMq1dJ+zcT2zFHakwVLUeJzbWF5fwf3Wp0H8VLru9hKUNNFOvOiwf5UyB/r7/kV04mOsjkOUclpMzVyNdmfDl4NhZbvnEPHTvLhUFnAKBtPNMHZ7I/pckMqaaPJZOM+gsZcbhG6+uDeTlLzaD2sJjNfG3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555082; c=relaxed/simple;
	bh=k+xuxjQ6cgAeAEnX34DjIlB9mdycf2+0okpaZfq0K6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CccCjKk1NXFIgskAN3H6t1ZYVIQRsFnscwwL88wmiWKTeOJlW935Ng/fC2/vQlCVBuZTHFeoZjXEfF3u9IuzgRJa1xXZruOG0I2OBK69KWAe9N6y9VyE78ammT4sulm59NPh0B4B+smOiVSOunrWhDcrUdb1D+T4bNJAzerPTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZyHZqk/X; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=9aswm6DR5ZbqBHIZa9TUwuJYXCs6Tm8kQTWEVNsvtH8=;
	b=ZyHZqk/Xz0Y139JAhp1FZTEmo5h+MvrhEpkMqvZAexx53VWQ+zkRm9V4KB7Vpw
	5aiYCMZlybffIQuP+1kohv7DGK6/J9dV9Yx66+UZyqMs3g7+y9D8y35aUsZ00Zpd
	Au5CqSOcKDeHCpD6xWyh4PLghe1X2vVfuscRZ4NhWUkg4=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3X+WJU35m7w_JAA--.17284S2;
	Fri, 28 Jun 2024 14:09:13 +0800 (CST)
Message-ID: <3a2dee50-ca5d-423c-bbf0-5dae8fbb62e3@126.com>
Date: Fri, 28 Jun 2024 14:09:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
To: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
 <Zn3zjKnKIZjCXGrU@x1n>
 <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>
 <Zn35MMS_kq3p0m7q@x1n>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <Zn35MMS_kq3p0m7q@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+WJU35m7w_JAA--.17284S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW5CF48Cw13Ar48Gr1UGFg_yoW5Xr18pF
	y3Ka9xKFWkJr10kws7twn5ZFWFyrZ8JryUXws5Gr1fZa98ua4xWr48X34FkF98W348Ga10
	vFW2y3srXa1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtSdkUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQwMG2VLbBlTrAAAsm



在 2024/6/28 7:43, Peter Xu 写道:
> On Thu, Jun 27, 2024 at 04:32:42PM -0700, Andrew Morton wrote:
>> On Thu, 27 Jun 2024 19:19:40 -0400 Peter Xu <peterx@redhat.com> wrote:
>>
>>> Yang,
>>>
>>> On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
>>>> The try_grab_folio() is supposed to be used in fast path and it elevates
>>>> folio refcount by using add ref unless zero.  We are guaranteed to have
>>>> at least one stable reference in slow path, so the simple atomic add
>>>> could be used.  The performance difference should be trivial, but the
>>>> misuse may be confusing and misleading.
>>>
>>> This first paragraph is IMHO misleading itself..
>>>
>>> I think we should mention upfront the important bit, on the user impact.
>>>
>>> Here IMO the user impact should be: Linux may fail longterm pin in some
>>> releavnt paths when applied over CMA reserved blocks.  And if to extend a
>>> bit, that include not only slow-gup but also the new memfd pinning, because
>>> both of them used try_grab_folio() which used to be only for fast-gup.
>>
>> It's still unclear how users will be affected.  What do the *users*
>> see?  If it's a slight slowdown, do we need to backport this at all?
> 
> The user will see the pin fails, for gpu-slow it further triggers the WARN
> right below that failure (as in the original report):
> 
>          folio = try_grab_folio(page, page_increm - 1,
>                                  foll_flags);
>          if (WARN_ON_ONCE(!folio)) { <------------------------ here
>                  /*
>                          * Release the 1st page ref if the
>                          * folio is problematic, fail hard.
>                          */
>                  gup_put_folio(page_folio(page), 1,
>                                  foll_flags);
>                  ret = -EFAULT;
>                  goto out;
>          }
> 
> For memfd pin and hugepd paths, they should just observe GUP failure on
> those longterm pins, and it'll be the caller context to decide what user
> can see, I think.
> 
>>
>>>
>>> The patch itself looks mostly ok to me.
>>>
>>> There's still some "cleanup" part mangled together, e.g., the real meat
>>> should be avoiding the folio_is_longterm_pinnable() check in relevant
>>> paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add()
>>> not try_get_folio(), and renames) could be good cleanups.
>>>
>>> So a smaller fix might be doable, but again I don't have a strong opinion
>>> here.
>>
>> The smaller the better for backporting, of course.
> 
> I think a smaller version might be yangge's patch, plus Yang's hugepd
> "fast" parameter for the hugepd stack, then hugepd can also use
> try_grab_page().  memfd-pin change can be a separate small patch perhaps
> squashed.

Thanks, new version:
https://lore.kernel.org/all/1719554518-11006-1-git-send-email-yangge1116@126.com/

> 
> I'll leave how to move on to Yang.
> 
> Thanks,
> 


