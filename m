Return-Path: <stable+bounces-56027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6E91B49D
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 03:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE0C2826AC
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C8D27E;
	Fri, 28 Jun 2024 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Rn3fwgiy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A83C0B;
	Fri, 28 Jun 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538025; cv=none; b=Ki56mVkyhDTOzKru3gbO1jdnxAZkbFFaIpYMYLfgpVJ9exymCJKgwJPGykSbzBvW96hsH8SHd+V8Utj3oaef3Cq6ITJPJoaURizOuPSVbd9WH1cQtkNmEiFZn+xJ7dt7qc42AUr7l26X6irPy6edG/1fT0B6Luj0/MW6V9LNOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538025; c=relaxed/simple;
	bh=V38sFmASQfqGcoseLmQq14vgW3z2xQfKhNYM+Pd/RXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dezlBHKCrL17girD1r011yucgAPGGsMrFjXlYrVaMzLufD3l6uVMYWNpcKv8FqmiE8DYBYwRKhTBskPqaJ8bdA8fRRssmU4Gh4++9KoaSgbCSfxSy7onWEOzl3AGisjC7Il68iAZVqgls8GdvcV7/GeumfKxJn6sf/KKJtWgCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Rn3fwgiy; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=tTOy6Kq3aNVWHj/osQBSoy/9+UEn0MO184Z7Lmt65g4=;
	b=Rn3fwgiy5jx0QWHgKQoup4vLNXxWu8hqTUrCjxxT7XMicWWAgC+NigrX4NebqS
	gLdQ7j41rHMR0rFgFFfVBPCr0HEspsoX3z/M7Rabp1D+tkZrQg+LgEa8Iux26xfP
	RgvQYhCAWfejscynWy7EEiidX+yNHv8IvysoS5geF3SP0=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_9kZEX5m77HCAA--.18751S2;
	Fri, 28 Jun 2024 09:25:48 +0800 (CST)
Message-ID: <4850060d-7fc2-4869-a901-38f11058bd40@126.com>
Date: Fri, 28 Jun 2024 09:25:45 +0800
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
X-CM-TRANSID:_____wDX_9kZEX5m77HCAA--.18751S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW5CF48Cw13Ar48Gr1UGFg_yoW5GF4xpF
	y3Ka9xKFWkJr10kws7tws5XFWFyrZ8JryUXws5Gr1xua98ua4xWr48X34FkF98W348Ga10
	vFW2y3srZa1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jt5rxUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhwMG2VExE332wABs0



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
> 

If needed, I can submit a new version based on Yang's V1 version.

> I'll leave how to move on to Yang.
> 
> Thanks,
> 


