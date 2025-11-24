Return-Path: <stable+bounces-196746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE19C80E07
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43BAF4E2F30
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428930BF68;
	Mon, 24 Nov 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDIpPF/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8730BF67
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992688; cv=none; b=vB2kBSRy3/ruypZQ5PaPkVmXR6rN3bBTKNAn6AgafEONCm64+nFICUKdaHupCUGsPNWBRh2RduHPcGa1P+B2kMwq6moN+09mAzy4NoHLvhwHLwzpDAGi5eHsRfUNghLZhw67esaji6bax71LRuJc2ePx/L+jX2FGWVjW3I+cBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992688; c=relaxed/simple;
	bh=jH2AxFvj9FK1wwbRSCm+4BWILbLVHHZ1oPWZAimqbi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLMHkeuH/s+y5TPgGwHqsi8X0M8LeL9O2Nob/M2x8MXOJ5ZxDXH9b/Uf9V4FNq+3p8eiGVZHOTNo/ogcn2Vvkth+kkwUs6gVRBowy5Nz447QKLg3S3k/xOQsrbCl9lzpYZF/d0jeF0QAsX9UzZfsBx9+AFpTX8X7r9uL6GdjxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDIpPF/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DC4C4CEF1;
	Mon, 24 Nov 2025 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763992687;
	bh=jH2AxFvj9FK1wwbRSCm+4BWILbLVHHZ1oPWZAimqbi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WDIpPF/jSgYmeTCYWbDH96GOkZoH4aHDi9ZHJdRTIms9WCI4RAwHdEacNBVWkDfFu
	 ivVgSfYkPwfo08jrEXObIqWrerwrryN0F/Q4T4EWDx6DUgJ//ScZNH5o3S20HqCQnf
	 sNC18iXSU+i6ush87zA5Ai2FbGDBiRhNmBmO9oIhGMNc3ieYsTMgB4fl/KVhZtZokR
	 +xoVaj/XtY/K0hStlQxhMqKnnsNZCZrlDBc87Drp8cCf5VC2UniBLvlmHMVjieGY9U
	 MleuU0mNtfJxN2RFctHFTqEOrkBfFzUK9Y8hCbZtcZSpeu9ENTIa63JNs1yGGmB1td
	 FAkHnxIK9IEIQ==
Message-ID: <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org>
Date: Mon, 24 Nov 2025 14:58:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com>
 <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/25 22:20, Joanne Koong wrote:
> On Thu, Nov 20, 2025 at 12:23 PM David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
>>
>> On 11/20/25 19:42, Joanne Koong wrote:
>>> During superblock writeback waiting, skip inodes where writeback may
>>> take an indefinite amount of time or hang, as denoted by the
>>> AS_WRITEBACK_MAY_HANG mapping flag.
>>>
>>> Currently, fuse is the only filesystem with this flag set. For a
>>> properly functioning fuse server, writeback requests are completed and
>>> there is no issue. However, if there is a bug in the fuse server and it
>>> hangs on writeback, then without this change, wait_sb_inodes() will wait
>>> forever.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
>>> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
>>> ---
>>>    fs/fs-writeback.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>>> index 2b35e80037fe..eb246e9fbf3d 100644
>>> --- a/fs/fs-writeback.c
>>> +++ b/fs/fs-writeback.c
>>> @@ -2733,6 +2733,9 @@ static void wait_sb_inodes(struct super_block *sb)
>>>                if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>>>                        continue;
>>>
>>> +             if (mapping_writeback_may_hang(mapping))
>>> +                     continue;
>>
>> I think I raised it in the past, but simply because it could happen, why
>> would we unconditionally want to do that for all fuse mounts? That just
>> seems wrong :(
> 
> I think it's considered a userspace regression if we don't revert the
> program behavior back to its previous version, even if it is from the
> program being incorrectly written, as per the conversation in [1].
> 
> [1] https://lore.kernel.org/regressions/CAJnrk1Yh4GtF-wxWo_2ffbr90R44u0WDmMAEn9vr9pFgU0Nc6w@mail.gmail.com/T/#m73cf4b4828d51553caad3209a5ac92bca78e15d2
> 
>>
>> To phrase it in a different way, if any writeback could theoretically
>> hang, why are we even waiting on writeback in the first place?
>>
> 
> I think it's because on other filesystems, something has to go
> seriously wrong for writeback to hang, but on fuse a server can easily
> make writeback hang and as it turns out, there are already existing
> userspace programs that do this accidentally.

Sorry, I only found the time to reply now. I wanted to reply in more 
detail why what you propose here does not make sense to me.

I understand that it might make one of the weird fuse scenarios (buggy 
fuse server) work again, but it sounds like we are adding more hacks on 
top of broken semantics. If we want to tackle the writeback problem, we 
should find a proper way to deal with that for good.


(1) AS_WRITEBACK_MAY_HANG semantics

As discussed in the past, writeeback of pretty much any filesystem might 
hang forever on I/O errors.

On network filesystems apparently as well fairly easily.

It's completely unclear when to set AS_WRITEBACK_MAY_HANG.

So as writeback on any filesystem may hang, AS_WRITEBACK_MAY_HANG would 
theoretically have to be set on any mapping out there.

The semantics don't make sense to me, unfortuantely.


(2) AS_WRITEBACK_MAY_HANG usage

It's unclear in which scenarios we would not want to wait for writeback, 
and what the effects of that are.

For example, wait_sb_inodes() documents "Data integrity sync. Must wait 
for all pages under writeback, because there may have been pages dirtied 
before our sync call ...".

It's completely unclear why it might be okay to skip that simply because 
a mapping indicated that waiting for writeback is maybe more sketchy 
than on other filesystems.

But what concerns me more is what we do about other 
folio_wait_writeback() callers. Throwing in AS_WRITEBACK_MAY_HANG 
wherever somebody reproduced a hang is not a good approach.

We need something more robust where we can just not break the kernel in 
weird ways because user space is buggy or malicious.


(3) Other operations

If my memory serves me right, there are similar issues on readahead. It 
wouldn't surprise me if there are yet other operations where fuse Et al 
can trick the kernel into hanging forever.

So I'm wondering if there is more to this than just "writeback may hang".



Obviously, getting the kernel to hang, controlled by user space that 
easily, is extremely unpleasant and probably the thing that I really 
dislike about fuse. Amir mentioned that maybe the iomap changes from 
Darrick might improve the situation in the long run, I would hope it 
would allow for de-nastifying fuse in that sense, at least in some 
scenarios.


I cannot really say what would be better here (maybe aborting writeback 
after a short timeout), but AS_WRITEBACK_MAY_HANG to then just skip 
selected waits for writeback is certainly something that does not make 
sense to me.


Regarding the patch here, is there a good reason why fuse does not have 
to wait for the "Data integrity sync. Must wait for all pages under 
writeback ..."?

IOW, is the documented "must" not a "must" for fuse? In that case, 
having a flag that states something like that that 
"AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we would want 
to add to avoid waiting for writeback with clear semantics why it is ok 
in that specific scenario.

Hope that helps, and happy to be convinced why AS_WRITEBACK_MAY_HANG is 
the right thing to do in this way proposed here.

-- 
Cheers

David

