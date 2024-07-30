Return-Path: <stable+bounces-62722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0458940DDD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474511F2598A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD31957E7;
	Tue, 30 Jul 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dCKWbzjm"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8D194A71;
	Tue, 30 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332258; cv=none; b=V4r5lL6Qw9vMhZxbZQoS8GAenIoSZRWjUQPsdOfMSIQNfoM6guo0J6KFurDoyJ7OV5yB4azpOM9QgzVUyIQYfieO0zEOKfkIuaC6o8Uv3r9UrfKJt8Mxi/+JdBdPqcbehZh+YQOR9TUZkJUibReXmcg1yL471DIAUCbvcuvbi/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332258; c=relaxed/simple;
	bh=uAoCj342s28bN8WzPF4jxoxE/9JcpYsWneD9ocMbptg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDwVNEHtKrG6Y5IL34sJrz4bg8aK13Ge0z4e6HqoCaQdEQqaw3EKmvNzJEQsf8MYZAHpY3Nq7GfRRs89+Bli7iwuLJMe0SfuyF4YwncAa5HbAaAIuw3yH1Drz4sPBrqTJux4oHZu49GE6RsrI3kOIJ4FNxcufXuaqGgS0WrTovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dCKWbzjm; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=LI6OvfJ54Zf0AJX2niBwJqF6IGU6IH2SW6Hn7PnnAQE=;
	b=dCKWbzjm4s/B0cn6vNywAOFNR/7BabeH/NUdh5xYJvm1H+lpmu3S7O+74OUiko
	lLF426ZfHZpvtZXldAH+s94vZs9jsB29w/f6f6Zeha2wbycpgFThLv5xj95zU7Lm
	DF0mFLsSJU/YWA7Z6tCWVtnVs07V/YHa2RpUwycE9DGqA=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3HxIUtKhmLc8oAw--.11873S2;
	Tue, 30 Jul 2024 17:36:21 +0800 (CST)
Message-ID: <1c5f1582-d6ea-4e27-a966-e6e992cf7c22@126.com>
Date: Tue, 30 Jul 2024 17:36:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
 <79234eac-d7cc-424b-984d-b78861a5e862@126.com>
 <9e018975-8a80-46a6-ab38-f3e2945c8878@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <9e018975-8a80-46a6-ab38-f3e2945c8878@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HxIUtKhmLc8oAw--.11873S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5uFWfKFyfJr4DXrW5Wrg_yoWkZFX_Gr
	48Zws5Gw4jg3ZrJ3Z0yry5JrWkXFWYkr18uFy8Jay3A347Aw48CFn2gr18ZFy7Jw1xAFs0
	9F4DAF4Yvr9xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW5UUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhksG2VEx2GucgAAsP



在 2024/7/30 15:45, David Hildenbrand 写道:
>>> Looking at this in more detail, I wonder if we can turn that to
>>>
>>> if (!folio_test_clear_lru(folio))
>>>       return;
>>> folio_get(folio);
>>>
>>> In all cases? The caller must hold a reference, so this should be fine.
>>>
>>
>> Seems the caller madvise_free_pte_range(...), calling
>> folio_mark_lazyfree(...), doesn't hold a reference on folio.
>>
> 
> If that would be the case and the folio could get freed concurrently, 
> the folio_get(folio) would be completely broken.
> 
> In madvise_free_pte_range() we hold the PTL, so the folio cannot get 
> freed concurrently.
> 

Right.

> folio_get() is only allowed when we are sure the folio cannot get freed 
> concurrently, because we know there is a reference that cannot go away.
> 
> 

When cpu0 runs folio_activate(), and cpu1 runs folio_put() concurrently, 
a possible bad scenario would like:

cpu0                                           cpu1

                                            folio_put_testzero(folio)
if (!folio_test_clear_lru(folio))// Seems folio shouldn't be accessed 

        return;
folio_get(folio);
                                             __folio_put(folio)
                                             __folio_clear_lru(folio)


Seems we should use folio_try_get(folio) instead of folio_get(folio).




