Return-Path: <stable+bounces-136885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD4A9F0A4
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9651A821A2
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947EC269D18;
	Mon, 28 Apr 2025 12:28:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E70269AE7;
	Mon, 28 Apr 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843307; cv=none; b=KH1SC/MKMzWprh/jxNAwuRNws4cREFyhqpuMwVdXSJVFaaL3mY86tek5/e9SdD/PnKSSTXWhkO+zAtKmEluzUlQPu4MNm1LRoi5P0oF8dWMMIr1LDjZIO1fJjiB0fM4YACapy5mt7VdTCFCqs4YtgtaFUJxnuOBFJ8PYXQILzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843307; c=relaxed/simple;
	bh=hYE/FFn1Zx/Bkgve92oN5dvvbZLRI9e7+gvkZnj8Ys4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Dc5PYZEJ8GrV5cPZu5yzZb6dzRVIcKc8+Ip0zs6oj+RfvmbbadnKR0+LDvtE0qwSrIt4T6b/LvQSNT2P/xgB0nSMY23I3b0He7msiuVZsxtwLWfIHNoxH8Qp91ong9J7hsqOsW9f+Moqb5skZDwOtoC3EPNiCSevoFm6+029YAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id E1214103765;
	Mon, 28 Apr 2025 14:28:14 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 919566018BE80;
	Mon, 28 Apr 2025 14:28:14 +0200 (CEST)
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, Jamal Hadi Salim <jhs@mojatatu.com>,
 regressions@lists.linux.dev, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 stable@vger.kernel.org
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <2025042831-professor-crazy-ad07@gregkh>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <c8110ec8-a868-b531-a230-f4b645f5ac73@applied-asynchrony.com>
Date: Mon, 28 Apr 2025 14:28:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025042831-professor-crazy-ad07@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-04-28 13:45, Greg KH wrote:
> On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffstätte wrote:
>> (cc: Greg KH)
>>
>> On 2025-04-22 18:51, Alan J. Wylie wrote:
>>> On Mon, 21 Apr 2025 21:09:27 +0100
>>> "Alan J. Wylie" <alan@wylie.me.uk> wrote:
>>>
>>>> On Mon, 21 Apr 2025 21:47:44 +0200
>>>> Holger Hoffstätte <holger@applied-asynchrony.com> wrote:
>>>>
>>>>>> I'm afraid that didn't help. Same panic.
>>>>>
>>>>> Bummer :-(
>>>>>
>>>>> Might be something else missing then - so for now the only other
>>>>> thing I'd suggest is to revert the removal of the qlen check in
>>>>> fq_codel.
>>>>
>>>> Like this?
>>>>
>>>> $ git diff  sch_fq_codel.c
>>>> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>>>> index 6c9029f71e88..4fdf317b82ec 100644
>>>> --- a/net/sched/sch_fq_codel.c
>>>> +++ b/net/sched/sch_fq_codel.c
>>>> @@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct
>>>> Qdisc *sch) qdisc_bstats_update(sch, skb);
>>>>           flow->deficit -= qdisc_pkt_len(skb);
>>>> -       if (q->cstats.drop_count) {
>>>> +       if (q->cstats.drop_count && sch->q.qlen) {
>>>>                   qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
>>>>                                             q->cstats.drop_len);
>>>>                   q->cstats.drop_count = 0;
>>>> $
>>>>
>>>
>>> It's been about 21 hours and no crash yet. I had an excellent day down
>>> a cave, so there's not been as much Internet traffic as usual, but
>>> there's a good chance the above patch as at least worked around, if not
>>> fixed the issue.
>>
>> Thought so .. \o/
>>
>> I guess now the question is what to do about it. IIUC the fix series [1]
>> addressed some kind of UAF problem, but obviously was not applied
>> correctly or is missing follow-ups. It's also a bit mysterious why
>> adding the HTB patch didn't work.
>>
>> Maybe Cong Wang can advise what to do here?
>>
>> So unless someone else has any ideas: Greg, please revert:
>>
>> 6.14.y/a57fe60ef4cf96bfbb6b58397ec28bdb5a5c6b31
>> ("codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()")
>>
>> and probably from 6.12 as well.
> 
> Why only those 2 branches?  What about all others, and mainline?

All branches that received upstream 342debc12183 aka
"codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()"
should be reverted for now. I previously didn't check them all.

It was part of a series, and the rest of the series is missing (not
picked by autosel). Luckily that does not matter because mainline
is apparently also buggy, so applying the rest of the series
would not help. This is currently still being debugged/worked on.

Just reverting this one commit provably fixes the crash for people
using -stable in e.g. gateway/router setups, with a htb->fq_codel chain.
The crash does not affect people using fq_codel as root qdisc.

Reverting is not the greatest solution since it reintroduces a potential
UAF, which has been there since fq_codel was first committed.
IIUC this potential UAF can only be induced with admin privileges.

I don't know how to explain this any better; all I did was try to
help Alan. :-(

-h

