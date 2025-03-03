Return-Path: <stable+bounces-120031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0973A4B5A2
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 01:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D51D18908E6
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A227462;
	Mon,  3 Mar 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pJkhxuEo"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED61754B;
	Mon,  3 Mar 2025 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961929; cv=none; b=K/mhtEpm++VLkevi3ajIQ7Ye9Ob3jJWf8jcB0hqwroD4pqW0eUkHEdGSP1wEj87bMVskQPJbYoGDpAnAiMGsSQZEtt4CmOIEr4n/NUjwZjJu1gYzpNbVVAtb4ctZdO1hmULNdinXnz6oKH0L2zeEJXIpY61QtklFTRNHsfpg2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961929; c=relaxed/simple;
	bh=DKm7MvEuMKo/94yBF8ecxj1RCJQJ1fbpjV3NSPQ3Hhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy5KbiIZFIKCTWmHiiGVTmbJm/8jhMcyF7QxF3/zk06984CWiQlYEqIUYJbMAcNLMMBiZ/G2PTDaRfDS4JN8c//HcBoqUPN2NImz1Jj9Q7mwQaj8UlBOlyCfl/oX6KCgYmcuFxowp1bWid63RH3Gyvgp7e6gBmRaG/tKD5fMZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pJkhxuEo; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740961916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vWRFE5MRPeFedN8U4K/7JNMCa/lHFzfHJwZRS5nIybA=;
	b=pJkhxuEouvzJBRuqFe3JYbpp9tEunZOQtdMUPrHzWtgh1fKJIQbqrLkjGxTw5PQf44/euc3R70O41FQUrtUZIHclsjGGG/RQMmj3nYCfRFPxFobgrOnE6GkGCaPpQO0QsjqPyK57sS1x0XopqdAQ/FjY7pdoO8FmAMr0EVcyjA8=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQWCbQv_1740961904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 08:31:54 +0800
Message-ID: <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
Date: Mon, 3 Mar 2025 08:31:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Alexey Panov <apanov@astralinux.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org,
 syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,
 syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
 Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>,
 syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/3 02:13, Fedor Pchelkin wrote:
> On Mon, 03. Mar 01:41, Gao Xiang wrote:
>>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>>> index 94e9e0bf3bbd..ac01c0ede7f7 100644
>>>
>>> I'm looking at the diff of upstream commit and the first thing it does
>>> is to remove zeroing out the folio/page private field here:
>>>
>>>     // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>>     @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>>              * file-backed folios will be used instead.
>>>              */
>>>             if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
>>>     -               folio->private = 0;
>>>                     tocache = true;
>>>                     goto out_tocache;
>>>             }
>>>
>>> while in 6.1.129 the corresponding fragment seems untouched with the
>>> backport patch. Is it intended?
>>
>> Yes, because it was added in
>> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
>> and dropped again.
>>
>> But for Linux 6.6.y and 6.1.y, we don't need to backport
>> 2080ca1ed3e4.
> 
> Thanks for overall clarification, Gao!
> 
> My concern was that in 6.1 and 6.6 there is still a pattern at that
> place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
> `struct z_erofs_bvec`"):
> 
> 1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
> 2. zeroing out ->private if the previous check holds true
> 
> // 6.1/6.6 fragment
> 
> 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
> 		set_page_private(page, 0);
> 		tocache = true;
> 		goto out_tocache;
> 	}
> 
> while the upstream patch changed the situation. If it's okay then no
> remarks from me. Sorry for the noise..

Yeah, yet as I mentioned `set_page_private(page, 0);`
seems redundant from the codebase, I'm fine with either
way.

Thanks,
Gao Xiang

