Return-Path: <stable+bounces-134882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A11A956E0
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF541894AC8
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38D1EB1AC;
	Mon, 21 Apr 2025 19:47:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098D2E401;
	Mon, 21 Apr 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745264871; cv=none; b=rxHLr/WQF0n+U7rff7lj8WkSc95HSGShAybavJOyizi8QNVhZFfcyWcMHbzcbR2Ro4pe4lBgosNQJ2AypHfe/Qt/0ryzLcnCs9LHnj/zzFjZAWfoTj5tDtl4ewvo+3ZJlw3Oknhdmp5Fa3snmQ8yLUmerzcxZsD/LLNYcHw2Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745264871; c=relaxed/simple;
	bh=10zB3zWNYiSJJwL/V/fxIicMAY2mD0WAywQ+9NZAld8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LabJ+bgSnYei+uxdEiJiiZQKGSRd7qsXt8Bc++XPxCTN4+cpnlmxiNQaaLv1Wg9GgecRJxWK7r50CT544aaX3eAS9Twif5fd4SwtA9j4zKSCDwYprTBzFvUEs1OZ/OEgnS+JwPmRQcQ8CukGJZXdNNnWIPXdbuvT4tXqEmsU0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id A88E31255FA;
	Mon, 21 Apr 2025 21:47:44 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 41D7E601893B6;
	Mon, 21 Apr 2025 21:47:44 +0200 (CEST)
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Octavian Purdila <tavip@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, stable@vger.kernel.org
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
Date: Mon, 21 Apr 2025 21:47:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-04-21 21:06, Alan J. Wylie wrote:
> On Mon, 21 Apr 2025 13:10:00 +0100
> "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> 
>> On Mon, 21 Apr 2025 13:50:52 +0200
>> Holger Hoffstätte <holger@applied-asynchrony.com> wrote:
> 
>>> If so, try either reverting the above or adding:
>>> "sch_htb: make htb_qlen_notify() idempotent" aka
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ba8b837b522d7051ef81bacf3d95383ff8edce5
>>>
>>> which was successfully not added to 6.14.3, along with the rest of
>>> the series:
>>> https://lore.kernel.org/all/20250403211033.166059-2-xiyou.wangcong@gmail.com/
>>
>> "successfully not added"?
>>
>> $ git cherry-pick  5ba8b837b522d7051ef81bacf3d95383ff8edce5
>> [linux-6.14.y 2285c724bf7d] sch_htb: make htb_qlen_notify() idempotent
>>   Author: Cong Wang <xiyou.wangcong@gmail.com>
>>   Date: Thu Apr 3 14:10:23 2025 -0700
>>   1 file changed, 2 insertions(+)
>>
>> It will take a while (perhaps days?) before I can confirm success.
> 
> I'm afraid that didn't help. Same panic.

Bummer :-(

Might be something else missing then - so for now the only other thing
I'd suggest is to revert the removal of the qlen check in fq_codel.

Holger

