Return-Path: <stable+bounces-120021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91EA4B3E2
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E958169548
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B81E9B22;
	Sun,  2 Mar 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d7bOxsyb"
X-Original-To: stable@vger.kernel.org
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF8C13B;
	Sun,  2 Mar 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740938203; cv=none; b=ZC4qHFMNqYvMUx3XjG8KF1blHGVI99vjRp4CRzmLGG+uph7HJUiZWLuUKce89dOv0mTUqs+szGBtovkKv01Jx/JP5w9E5bUD9eEZtZXcbZ1ujepb2fGdDT6LLg8gwbL4GPwouptZ/8spw6pPox8Il9ZZu5N5advn1jpfg4OR9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740938203; c=relaxed/simple;
	bh=6xeh4z1GWYiTwe66l53zKe3JqYsQcYUK/DFrKO4xKV0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hQsng8QqrUIObmCXTQiUZzMlkYJUZo7qFoGToXKS6zo+zyV/yS6iyta1bGVczW4XZGWdACBZGXh/eRojLorPXNKQoyHgWxptfmIn4nZ78wWon06n1U+DjETVRRwmX/kGUx/lJYiYNqWXqWv8nMdJHYSzECEXy0oPDEGi4mrD6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d7bOxsyb; arc=none smtp.client-ip=47.90.199.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740938181; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=yzXmjFQ4bX2wV3j1beZ3CSsEAZKv6dTZuPoBn8yv2HA=;
	b=d7bOxsybGbbcGmhp+rZUS6BYUoA5M09UtodD0+32JzBCyNwnhFLykuwcFfLfd8AaEPD7ozLzk+yAayRDiWCaziy7nAS+dOfnMkkehAbFKyOgSJObk6zJD3wRU7l9+ffkMpRSZChEp5nIamtvkSTgawcPKCHj/CIChLmysBKX4r8=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQVhkCH_1740938169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 01:56:19 +0800
Message-ID: <131cd204-036d-4d78-ae80-4ff5b8aedb09@linux.alibaba.com>
Date: Mon, 3 Mar 2025 01:56:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Alexey Panov <apanov@astralinux.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
In-Reply-To: <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/3 01:41, Gao Xiang wrote:
> Hi Fedor,
> 
> On 2025/3/2 18:56, Fedor Pchelkin wrote:
>> On Fri, 28. Feb 19:51, Alexey Panov wrote:
>>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.
>>>
>>> syzbot reported a task hang issue due to a deadlock case where it is
>>> waiting for the folio lock of a cached folio that will be used for
>>> cache I/Os.
>>>
>>> After looking into the crafted fuzzed image, I found it's formed with
>>> several overlapped big pclusters as below:
>>>
>>>   Ext:   logical offset   |  length :     physical offset    |  length
>>>     0:        0..   16384 |   16384 :     151552..    167936 |   16384
>>>     1:    16384..   32768 |   16384 :     155648..    172032 |   16384
>>>     2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
>>> ...
>>>
>>> Here, extent 0/1 are physically overlapped although it's entirely
>>> _impossible_ for normal filesystem images generated by mkfs.
>>>
>>> First, managed folios containing compressed data will be marked as
>>> up-to-date and then unlocked immediately (unlike in-place folios) when
>>> compressed I/Os are complete.  If physical blocks are not submitted in
>>> the incremental order, there should be separate BIOs to avoid dependency
>>> issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
>>> and BIO submission which causes unexpected BIO waits.
>>>
>>> Second, managed folios will be connected to their own pclusters for
>>> efficient inter-queries.  However, this is somewhat hard to implement
>>> easily if overlapped big pclusters exist.  Again, these only appear in
>>> fuzzed images so let's simply fall back to temporary short-lived pages
>>> for correctness.
>>>
>>> Additionally, it justifies that referenced managed folios cannot be
>>> truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
>>> up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
>>> difference.
>>>
>>> Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>>> Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
>>> Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
>>> Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
>>> Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
>>> [Alexey: minor fix to resolve merge conflict]
>>
>> Urgh, it doesn't look so minor indeed. Backward struct folio -> struct
>> page conversions can be tricky sometimes. Please see several comments
>> below.
> 
> I manually backported it for Linux 6.6.y, see
> https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=1bf7e414cac303c9aec1be67872e19be8b64980c
> 
> Actually I had a very similiar backport for Linux 6.1.y,
> but I forgot to send it out due to other ongoing stuffs.
> 
> I think this backport patch is all good, but you could
> also mention it follows linux 6.6.y conflict changes
> instead of "minor fix to resolve merge conflict".
> 
>>
>>> Signed-off-by: Alexey Panov <apanov@astralinux.ru>
>>> ---
>>> Backport fix for CVE-2024-47736
>>>
>>>   fs/erofs/zdata.c | 59 +++++++++++++++++++++++++-----------------------
>>>   1 file changed, 31 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index 94e9e0bf3bbd..ac01c0ede7f7 100644
>>
>> I'm looking at the diff of upstream commit and the first thing it does
>> is to remove zeroing out the folio/page private field here:
>>
>>    // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>    @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>             * file-backed folios will be used instead.
>>             */
>>            if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
>>    -               folio->private = 0;
>>                    tocache = true;
>>                    goto out_tocache;
>>            }
>>
>> while in 6.1.129 the corresponding fragment seems untouched with the
>> backport patch. Is it intended?
> 
> Yes, because it was added in
> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
> and dropped again.
> 
> But for Linux 6.6.y and 6.1.y, we don't need to backport
> 2080ca1ed3e4.

Oh, it seems that I missed this part when backporting
for 6.6.y, but it has no actual difference because
`page->private` will be updated in `goto out_tocache`.

so `set_page_private(page, 0);` was actual a redundant
logic, you could follow the upstream to discard
`set_page_private(page, 0);`.

Thanks,
Gao Xiang

