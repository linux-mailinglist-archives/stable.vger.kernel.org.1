Return-Path: <stable+bounces-268813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EGGoBdRgPmpvEwkAu9opvQ
	(envelope-from <stable+bounces-268813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:21:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7056CC5EB
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ShybaEdE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268813-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268813-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED018303659A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9E3EBF33;
	Fri, 26 Jun 2026 11:21:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41183E9287
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472912; cv=none; b=Q+kCk1s/B8nQHrDgOzo7Q6eUIi3XSaKu1g1napYB2VDfx5sVw2f67llnfVuyAfzi7zf0jyEbN/GTTfhIIyTEZIxmVlMXrWGW8dmV9KN2iAXvhK7rVXwQqY9jnoEg7lwj8mUGzeoYeYxWvXj/RaEQLBNCpnaS8naHDyIfysHKRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472912; c=relaxed/simple;
	bh=9spW60n7KVcrvhkMswN0/3I2GFHz+mOsLIJkdth7eHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTOB56rsaxygvYuPAoqbRZzTVtAG7+It9xppblGsLhTO1g/hcqnRR9mJy7q9hsOJl9VDELjj/RtwWFK0ApWUXhko+Rcz4QN5REBslU6fgSLUOKQMQXzyqG3flPHfz12D8mtgKUKMFZHXxrPLR/NUCxv39Lf58TOhhY2yoFFNKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ShybaEdE; arc=none smtp.client-ip=95.215.58.170
Message-ID: <57c18afd-e2a3-4b37-90b6-f2a4c758e8aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782472907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXnGSQ/f8kthQgxhjN/qMHFlHYZPXPOXt+bobY0m7Ck=;
	b=ShybaEdEuvjaq13R1piH2Z+U9a0wSOAEKFD90/s1i7ZE77Vs1RndU1kW6KQ7qUbtW79HcD
	vreqzNqtQaQeE+7AcQ8JQkv+EBQd3thYj97SSBWGmSD22qqs/z7PobV/u8tB2breJGoknE
	My76uAFXDSZY5f+J75MBfMNtqFjnir8=
Date: Fri, 26 Jun 2026 19:21:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev
Cc: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
 <aj5I7JAXWlTHRyEW@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aj5I7JAXWlTHRyEW@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-268813-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F7056CC5EB



On 6/26/26 5:39 PM, Johannes Weiner wrote:
> On Fri, Jun 26, 2026 at 03:04:17PM +0800, Qi Zheng wrote:
>> On 6/26/26 2:48 PM, Harry Yoo wrote:
>>> On 6/26/26 3:24 PM, Qi Zheng wrote:
>>>> On 6/26/26 12:59 PM, Harry Yoo wrote:
>>>>> Observing a dying cgroup should be rare anyway, it's worth focusing
>>>>> more on readability?
>>>>
>>>> While it's rare to encounter consecutive dying memcgs, it can still
>>>> happen, right?
>>>
>>> But is worth saving a few instruction in a basic block that is
>>> unlikely() to be executed?
>>
>> I don't have a strong opinion here. Hi Johannes, I'll leave the decision
>> up to you. If necessary, I can send out the v4.
> 
> Yes, I was thinking what Harry actually bothered to spell out ;)
> 
> The race is rare, multiple levels even rarer, and even *then*
> mem_cgroup_lruvec() is a quick inline.
> 
> This way you have one block to handle that one rare race
> condition. One place to put the comment. No labels, no goto.
> 
> Simplicity wins :)

Okay, I will update it as you suggested and send out the v4.

Hi Shakeel, do we really need to move lock_batch_lruvec() to
memcontrol.h? It's currently only used by reset_batch_size().

Thanks,
Qi


