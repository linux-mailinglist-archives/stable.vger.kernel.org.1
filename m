Return-Path: <stable+bounces-135162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BFA9737A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EA3176497
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC797297A63;
	Tue, 22 Apr 2025 17:20:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D229009C;
	Tue, 22 Apr 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342438; cv=none; b=RmK8woXAq9Z5AeaEYkpEfptGRmkrzaCvcyZ+RzxKFY9pvrgCXL7R4td5s87dFwwk8XafInsmqNYmNn5FHsgJW6OQFrzPxcrsrF+j3+kdejID3+Ri48NH9Agbvn821LyBbtzLXnCVqz/LWpQvJsCjlfoSC84PPk+/kl8rbV/ikoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342438; c=relaxed/simple;
	bh=rE7/v/WhlI1/tb/SRLFDYrXPU3x2rQOcXmg7kgr1tIM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NYBtJeM8AhlSdZYjJJcYM+kYkwwGL8k2TbsxBx82wmeywMVzY123EBupScEi/cbsAwxzIiHlZozOBIJwlL4QPWNftsYNyRnSCjtN0jR9GeDknZX7IIqypAGL8fp+NWQmC7wKkb2zuHYn5G14gJThTT5YCEAV7dyG9VG5OkFbxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 8DC351CA1;
	Tue, 22 Apr 2025 19:20:25 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id E516F6017547D;
	Tue, 22 Apr 2025 19:20:24 +0200 (CEST)
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Octavian Purdila <tavip@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, stable@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
Date: Tue, 22 Apr 2025 19:20:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

(cc: Greg KH)

On 2025-04-22 18:51, Alan J. Wylie wrote:
> On Mon, 21 Apr 2025 21:09:27 +0100
> "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> 
>> On Mon, 21 Apr 2025 21:47:44 +0200
>> Holger Hoffstätte <holger@applied-asynchrony.com> wrote:
>>
>>>> I'm afraid that didn't help. Same panic.
>>>
>>> Bummer :-(
>>>
>>> Might be something else missing then - so for now the only other
>>> thing I'd suggest is to revert the removal of the qlen check in
>>> fq_codel.
>>
>> Like this?
>>
>> $ git diff  sch_fq_codel.c
>> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>> index 6c9029f71e88..4fdf317b82ec 100644
>> --- a/net/sched/sch_fq_codel.c
>> +++ b/net/sched/sch_fq_codel.c
>> @@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct
>> Qdisc *sch) qdisc_bstats_update(sch, skb);
>>          flow->deficit -= qdisc_pkt_len(skb);
>>   
>> -       if (q->cstats.drop_count) {
>> +       if (q->cstats.drop_count && sch->q.qlen) {
>>                  qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
>>                                            q->cstats.drop_len);
>>                  q->cstats.drop_count = 0;
>> $
>>
> 
> It's been about 21 hours and no crash yet. I had an excellent day down
> a cave, so there's not been as much Internet traffic as usual, but
> there's a good chance the above patch as at least worked around, if not
> fixed the issue.

Thought so .. \o/

I guess now the question is what to do about it. IIUC the fix series [1]
addressed some kind of UAF problem, but obviously was not applied
correctly or is missing follow-ups. It's also a bit mysterious why
adding the HTB patch didn't work.

Maybe Cong Wang can advise what to do here?

So unless someone else has any ideas: Greg, please revert:

6.14.y/a57fe60ef4cf96bfbb6b58397ec28bdb5a5c6b31
("codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()")

and probably from 6.12 as well.

cheers
Holger

[1] https://lore.kernel.org/all/20250403211033.166059-1-xiyou.wangcong@gmail.com/

