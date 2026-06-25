Return-Path: <stable+bounces-268289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BZ7HIknbPGqjtQgAu9opvQ
	(envelope-from <stable+bounces-268289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:39:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E16C36CE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=kcpOVqU9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268289-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268289-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB57D30488FB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5880C2FF65F;
	Thu, 25 Jun 2026 07:38:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183337F72D
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:38:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373092; cv=none; b=eVoG85EQq1xZ0VOHGt/1kSXRUyi8yiPZdbKHzOkCnPJTZaVqjpSLg+7RmLP7Q+J+PcCl7iAnmH7rDM1ZH2BLnq6jRPtnj9xMrNf1tXInVKAN4TVCWfllD8pjTQAYeNJvS382nLJSoYO9WE8iHFI7bx2xKiKeIPAyeOVIgBTwfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373092; c=relaxed/simple;
	bh=BmXZBlLH/z1WJXQJVlU9kcCs3LgL2oviZiBxwYoXE90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEkvGexxflBaLAmQVsGJT+BqIRuVt832mwI9fEwrdEgCp4uv0f3KpIzBL88bOy90NkZfOjMW2Aht+7dnH+Rc8mOncvdMTw0f6tZJ+T4JlBgoxCxUCdVejXtBFuxxXDWeIMsiEqVOZD8ufGHDK2XMF/XMRa8ujWXa6Gt1NKP04ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kcpOVqU9; arc=none smtp.client-ip=91.218.175.171
Message-ID: <1db11ccc-ae05-4b26-b360-c34ac9f97299@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782373088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBpSi383BAOXXIGxhMDUQBIu/MQh2aj4tFTkWUIvvbw=;
	b=kcpOVqU9mWWYm6usOJNPTC5aT+1FVjw/uAvOceZSTPi3dapZRgCeL1+kbRPd8Ho1pgG97i
	fLpsGnw4FllP3+86/E8tjuxFBLJLiV8OWRSA+zEpyofpHVkwrZQoJEH92sj0PAJckHrU8u
	8vAFzzxSMM3QmMC3jeSJNoFAdUjtNjk=
Date: Thu, 25 Jun 2026 15:37:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
 <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
 <1d78e1c1-0cdb-435e-b278-670bce9148b3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <1d78e1c1-0cdb-435e-b278-670bce9148b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-268289-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: DA8E16C36CE



On 6/25/26 2:32 PM, Harry Yoo wrote:
> 
> 
> On 6/25/26 3:11 PM, Qi Zheng wrote:
>> On 6/25/26 12:16 PM, Harry Yoo wrote:
>>>
>> [...]
>>
>>>
>>>> So lock_batch_lruvec() can be implemented like this:
>>>>
>>>> #ifdef CONFIG_MEMCG
>>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>> {
>>>>       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>>       struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>>>
>>>>       rcu_read_lock();
>>>>
>>>>       /*
>>>>        * The memcg can be NULL when the memory controller is disabled.
>>>>        * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>>>        */
>>>>       if (!memcg || !css_is_dying(&memcg->css))
>>>>           goto lock;
>>>>
>>>>       do {
>>>>           memcg = parent_mem_cgroup(memcg);
>>>>       } while (memcg && css_is_dying(&memcg->css));
>>>>       lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>>
>>>> lock:
>>>>       spin_lock_irq(&lruvec->lru_lock);
>>>>
>>>>       return lruvec;
>>>> }
>>>> #else
>>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>> {
>>>>       lruvec_lock_irq(lruvec);
>>>>
>>>>       return lruvec;
>>>> }
>>>> #endif
>>>>
>>>> Does this make sense?
>>>
>>> Yes, looks good to me!
>>
>> OK, this sync method makes more sense as it doesn't require adding a
>> new lrugen->reparente. I'll go with this method and update v3.
> 
> Thanks!
> 
> Just one thing to clarify...
> 
> So, when we check something that's updated _before_ grace period
> (CSS_DYING), RCU is sufficient.
> 
> But in folio_lruvec_lock*(), that is not the case because reparenting
> is performed in the RCU work, under the lruvec lock. So the check needs
> to be done under RCU and the lruvec lock.
> 
> This is quite subtle :D

Indeed.

And in theory, the l->nr_items check in lock_list_lru_of_memcg() could
also be replaced by the CSS_DYING check.

> 
>> Hi Barry and Baolin, what do you think? Since the sync method has been
>> changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)
> 
> And hopefully Peiyang would kindly double check v3 still not reproduced
> on the machine :)

Yeah!

> 


