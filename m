Return-Path: <stable+bounces-269365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ego+Ga90P2pzTgkAu9opvQ
	(envelope-from <stable+bounces-269365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:58:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7466D15E4
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mIKjcWkp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269365-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269365-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CAA3041A7D
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80838D3E4;
	Sat, 27 Jun 2026 06:57:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAB37C103
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 06:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543454; cv=none; b=VNAzEndd911fMsAsyOshWsSfcL/P3dpb2AWABDU6sWIHhG3CUKjgUzimWSlF2LYL0Cq+QWabwf/euuYf+ZMGy4UZCUnGwkGCZw98q0P8TGuJC8XcUEh2OgjsObHk79GYhlMZ6p71knj3LoLxqcaCg5P5PX7bAM26PP7VF+MoiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543454; c=relaxed/simple;
	bh=UViHE7El+llJt2SvZFHiYmDEZrpzSBqQ5B6s57rJRos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhgHEV3DghDcThz8S6nc9OZcSCLdT2GkhQsA6QtUhnarCuSiSju0dE8qWKkwNJd43QHCofakogGNZvvztK/rLTl2ZWt9BZxnqSxXdopVcGSOgRitnzKcLeaBm5iT4cDv5f0idBTrXu7LjiOn3onkJAr+HXZ9Kef4PfMXyuycTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mIKjcWkp; arc=none smtp.client-ip=95.215.58.178
Message-ID: <fba044ed-43c7-428c-89e9-89f35b789dab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782543448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mXf9uzTDMtYNiYQq1kgu0qq3btevTgKJtXOPMqdv7s=;
	b=mIKjcWkpmuPo2qiO2D12sMuwXdhxvyAlAzEDqAl0qeA9PgmtgnOZ6k2wn5iHzMQPefoS35
	dHgpNPzCs6W8+WARZb/MIRrHt0uZ6i1bjxbAbuGGiLAHLaVPo4C6MEKTyx+UI3D3okabRG
	uRQ4ADOtOgHOvyg0Vw9jqilKXKNM058=
Date: Sat, 27 Jun 2026 14:57:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Harry Yoo <harry@kernel.org>,
 akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn,
 mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
 <aj5I7JAXWlTHRyEW@cmpxchg.org>
 <57c18afd-e2a3-4b37-90b6-f2a4c758e8aa@linux.dev> <aj6xzyqtwd4it0kZ@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aj6xzyqtwd4it0kZ@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D7466D15E4



On 6/27/26 1:08 AM, Shakeel Butt wrote:
> On Fri, Jun 26, 2026 at 07:21:28PM +0800, Qi Zheng wrote:
>>
>>
>> On 6/26/26 5:39 PM, Johannes Weiner wrote:
>>> On Fri, Jun 26, 2026 at 03:04:17PM +0800, Qi Zheng wrote:
>>>> On 6/26/26 2:48 PM, Harry Yoo wrote:
>>>>> On 6/26/26 3:24 PM, Qi Zheng wrote:
>>>>>> On 6/26/26 12:59 PM, Harry Yoo wrote:
>>>>>>> Observing a dying cgroup should be rare anyway, it's worth focusing
>>>>>>> more on readability?
>>>>>>
>>>>>> While it's rare to encounter consecutive dying memcgs, it can still
>>>>>> happen, right?
>>>>>
>>>>> But is worth saving a few instruction in a basic block that is
>>>>> unlikely() to be executed?
>>>>
>>>> I don't have a strong opinion here. Hi Johannes, I'll leave the decision
>>>> up to you. If necessary, I can send out the v4.
>>>
>>> Yes, I was thinking what Harry actually bothered to spell out ;)
>>>
>>> The race is rare, multiple levels even rarer, and even *then*
>>> mem_cgroup_lruvec() is a quick inline.
>>>
>>> This way you have one block to handle that one rare race
>>> condition. One place to put the comment. No labels, no goto.
>>>
>>> Simplicity wins :)
>>
>> Okay, I will update it as you suggested and send out the v4.
>>
>> Hi Shakeel, do we really need to move lock_batch_lruvec() to
>> memcontrol.h? It's currently only used by reset_batch_size().
> 
> This function is very specific to memcg therefore I asked it move to
> memcontrol.h and not to keep in vmscan.c but we can always do the cleanup later,
> so proceed however you want.

Got it. I'll keep lock_batch_lruvec() in vmscan.c for now. Once there is
a second caller, we can clean it up and move it to memcontrol.h.

Thanks,
Qi

> 


