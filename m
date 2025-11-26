Return-Path: <stable+bounces-196999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55494C89672
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81EF3AA8D5
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC066314B6E;
	Wed, 26 Nov 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obh8NNkv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E42FB990
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154545; cv=none; b=EDv7Ifkw3zf0vA7HAkDYrD6dBaSfOXPJ3oX0Ax+7Y4OIxPYqnSvjcO8BQlsGEukK84+vRaDx0+1NO9f8do4F2MWlXebmtZ5z/pmJq1KK5oOd8o2leM4wQzUIf2CIt1qbtnl7AGmzxc6qloItOvLj/DF6Cl/dhzQakGA7uW0lDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154545; c=relaxed/simple;
	bh=oGNv4DyKpHq5ZR78KiElZqO4gwYu9D3vDwjUdT9pq4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajcDcRw/Z+izls8pCXZCZj93S8f0HZi8/SGe908aqjeGykGKIwNI9QdMvb0ON8/zbcPwGslDiMeGI9IniyY2fiaUOKvsmjA3VixP+DKw2GBISqbvKonzDSszMIoj7xAAQfs/y5xGNgLIHR45gAfG203JUnuL7xBf/GqME8JL4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obh8NNkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF45C113D0;
	Wed, 26 Nov 2025 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764154545;
	bh=oGNv4DyKpHq5ZR78KiElZqO4gwYu9D3vDwjUdT9pq4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obh8NNkvbnfnbdcrZ9WUzAGHtyjtQpfYmwSR1TeSgzK2uJBxa4nvsvz8jiLzUIUfA
	 eYEvXMSwhOPd6YZtGUgV72mBMwt7290qj7Xzk+3SXVW5Iqed3Jqso/eWEFPFIXJsNQ
	 VzN+Y3P0UJw0FZR6eMuQbZjMCXXzzFm9NFuKTa+mTzele1pE64fjfWd1JRLrxbQqwH
	 uW84X0lpriczaGFeSOeDBb9XTLF0a83pEhS1E+1RzL+FF+vU/7K+qzoFZzNvPu8q+0
	 wvtTxWum6Z20RmJv+PNQYQT74koy/BaPeEWvmQbX2YsNE3o4uNQGEhiJl2s1/N0HwD
	 s1/+Aq7G5/P1w==
Message-ID: <504d100d-b8f3-475b-b575-3adfd17627b5@kernel.org>
Date: Wed, 26 Nov 2025 11:55:42 +0100
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
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org>
 <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I understand that it might make one of the weird fuse scenarios (buggy
>> fuse server) work again, but it sounds like we are adding more hacks on
>> top of broken semantics. If we want to tackle the writeback problem, we
>> should find a proper way to deal with that for good.
> 
> I agree that this doesn't solve the underlying problem that folios
> belonging to a malfunctioning fuse server may be stuck in writeback
> state forever. To properly and comprehensively address that and the
> other issues (which you alluded to a bit in section 3 below) would I
> think be a much larger effort, but as I understand it, a userspace
> regression needs to be resolved more immediately. 

Right, and that should have be spelled out more clearly in the patch 
description.

The "Currently, fuse is the only filesystem with this flag set. For a
properly functioning fuse server, writeback requests are completed and
there is no issue." part doesn't emphasis that there is no need to wait 
for a different reason: there are no data integrity guarantees with 
fuse, and trying to provide them is currently shaky.

> I wasn't aware that
> if the regression is caused by a faulty userspace program, that rule
> still holds, but I was made aware of that.

Yeah, that is weird though. But I don't understand the details there. 
Hanging the kernel in any case is beyond nasty.

> Even though there are other
> ways that sync could be held up by a faulty/malicious userspace
> program prior to the changes that were added in commit 0c58a97f919c
> ("fuse: remove tmp folio for writebacks and internal rb tree"), I
> think the issue is that that commit gives malfunctioning servers
> another way, which may be a way that some well-intended but buggy
> servers could trigger, which is considered a regression. If it's
> acceptable to delay addressing this until the actual solution that
> addresses the entire problem, then I agree that this patchset is
> unnecessary and we should just wait for the more comprehensive
> solution.
> 
>>
>>
>> (1) AS_WRITEBACK_MAY_HANG semantics
>>
>> As discussed in the past, writeeback of pretty much any filesystem might
>> hang forever on I/O errors.
>>
>> On network filesystems apparently as well fairly easily.
>>
>> It's completely unclear when to set AS_WRITEBACK_MAY_HANG.
>>
>> So as writeback on any filesystem may hang, AS_WRITEBACK_MAY_HANG would
>> theoretically have to be set on any mapping out there.
>>
>> The semantics don't make sense to me, unfortuantely.
> 
> I'm not sure what a better name here would be unfortunately. I
> considered AS_WRITEBACK_UNRELIABLE and AS_WRITEBACK_UNSTABLE but I
> think those run into the same issue where that could technically be
> true of any filesystem (eg the block layer may fail the writeback, so
> it's not completely reliable/stable).

See below, I think this here is really about "no data integrity 
guarantees, so no need to wait even if writeback would be working 
perfectly".

The reproduced hang is rather a symptom of us now trying to achieve data 
integrity when it was never guaranteed.

At least that's my understanding after reading Miklos reply.

> 
>>
>>
>> (2) AS_WRITEBACK_MAY_HANG usage
>>
>> It's unclear in which scenarios we would not want to wait for writeback,
>> and what the effects of that are.
>>
>> For example, wait_sb_inodes() documents "Data integrity sync. Must wait
>> for all pages under writeback, because there may have been pages dirtied
>> before our sync call ...".
>>
>> It's completely unclear why it might be okay to skip that simply because
>> a mapping indicated that waiting for writeback is maybe more sketchy
>> than on other filesystems.
>>
>> But what concerns me more is what we do about other
>> folio_wait_writeback() callers. Throwing in AS_WRITEBACK_MAY_HANG
>> wherever somebody reproduced a hang is not a good approach.
> 
> If I'm recalling this correctly (I'm looking back at this patchset [1]
> to trigger my memory), there were 3 cases where folio_wait_writeback()
> callers run into issues: reclaim, sync, and migration. 

I suspect there are others where we could hang forever, but maybe 
limited to operations where an operation would be stuck forever. Or new 
ones would simply be added in the future.

For example, memory_failure() calls folio_wait_writeback() and I don't 
immediately see why that one would not be able to hit fuse.

So my concern remains. We try to fix the fallout while we really need a 
long term plan of how to deal with that mess.

Sorry that you are the poor soul that opened this can of worms,

[...]

>>
>> Regarding the patch here, is there a good reason why fuse does not have
>> to wait for the "Data integrity sync. Must wait for all pages under
>> writeback ..."?
>>
>> IOW, is the documented "must" not a "must" for fuse? In that case,
> 
> Prior to the changes added in commit 0c58a97f919c ("fuse: remove tmp
> folio for writebacks and internal rb tree"), fuse didn't ensure that
> data was written back for sync. The folio was marked as not under
> writeback anymore, even if it was still under writeback.

Okay, so this really is a fuse special thing.

> 
>> having a flag that states something like that that
>> "AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we would want
>> to add to avoid waiting for writeback with clear semantics why it is ok
>> in that specific scenario.
> 
> Having a separate AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC mapping flag
> sounds reasonable to me and I agree is more clearer semantically.

Good. Then it's clear that we are not waiting because writeback is 
shaky, but because even if it would be working, because we don't have to 
because there are no such guarantees.

Maybe

AS_NO_DATA_INTEGRITY

or similar would be cleaner, I'll have to leave that to you and Miklos 
to decide what exactly the semantics are that fuse currently doesn't 
provide.


-- 
Cheers

David

