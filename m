Return-Path: <stable+bounces-267843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYveDl3oOWrMywcAu9opvQ
	(envelope-from <stable+bounces-267843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:58:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E26B3762
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=nVU9jaYf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267843-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267843-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEFD8301E7EE
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8513859F0;
	Tue, 23 Jun 2026 01:58:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFF371048
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:58:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179913; cv=none; b=lQrADGATRAEikiC/ODDtmIBTrqStHX1/7cTYR8yt0Raaow6hYFfY6fRNamM/NErPtLNS+b+rwUxQnMMqTuZeQEhHYcs8tNietDNx9bCb4awwktGidzYCGkHBrgDFT8J+KGYYEdN9Tk+jywbW/cIKEvEVW3FtbFJlJSqmVKSQ3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179913; c=relaxed/simple;
	bh=xHgdRTGgN9tAEW0PV0VYjqTIedXY7cD35mOQAD1AFCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UflAJYwezGbpKU1EzWa90gxhtKuMjW7D33wCPWQOIYw/a6X8BbLHO50AtEAocw+2jNSAoKlaxlXVGIvTqZIfsfPFcuPv+VSEhb0pVceWyD+oaiIzmM/2Wyr8DfNc66XZkPxhMGCyByrnypURztB3H2i65gZgCCtpA//R1d/yeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nVU9jaYf; arc=none smtp.client-ip=95.215.58.172
Message-ID: <19710ee5-8e1c-4b13-812b-4b03ca34260d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782179900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vB3i4adRYFyfJdlhTLJBnXcY+A/xZ4fOjEV+12UNO30=;
	b=nVU9jaYfAdR3Kg5OdpQ8NdQY8lYzn36Pa3qWCV2kxePiO7/Kl01rM+fWGrhc/stxijbqL+
	qCXr20ySoNM4fnI20ayBDDhONqwbZZhvZHnPGSp2kMbEJoGjxoGqwfEvixF1W6C43KNP6F
	+W/8gm0/04WNK50L6P01p7mNDgll41Y=
Date: Tue, 23 Jun 2026 09:57:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
 <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:baohua@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-267843-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nju.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,bytedance.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 994E26B3762

Hi Barry,

On 6/23/26 6:52 AM, Barry Song wrote:
> On Mon, Jun 22, 2026 at 3:38 PM Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The mglru page table walker batches per-generation size deltas in
>> walk->nr_pages while walking page tables without holding the lruvec lock.
>> The reset_batch_size() later folds those deltas into walk->lruvec under
>> the lruvec lock.
>>
>> The page table walker can run concurrently with the memcg reparenting path
>> as follows:
>>
>> CPU0                           CPU1
>> ====                           ====
>>
>> walk_mm
>> --> walk_page_range
>>      --> update_batch_size
>>          --> walk->nr_pages += delta
>>
>>                                mem_cgroup_css_offline
>>                                --> memcg_reparent_objcgs
>>                                    --> lock lruvec
>>                                        lru_gen_reparent_memcg
>>                                        --> reparent child folios to parent
>>                                        unlock lruvec
>>
>>      lock lruvec
>>      reset_batch_size
>>      --> child lrugen->nr_pages += delta
>>
>> This can trigger the following warning:
>>
>> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300
>> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
> 
> I can't find 5867; instead, I can find 5828:
> 
> VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>    sizeof(lruvec->lrugen.nr_pages)));
> 
> Is this the warning?

Yes, I just copy-pasted the warning log from Peiyang's report.

Maybe the description should be changed to:

This will trigger the following warning in lru_gen_exit_memcg():

	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
					   sizeof(lruvec->lrugen.nr_pages)));

> 
>> Call Trace:
>>    <TASK>
>>    mem_cgroup_free mm/memcontrol.c:3972 [inline]
>>    mem_cgroup_css_free+0x76/0xb0 mm/memcontrol.c:4241
>>    css_free_rwork_fn+0x125/0x1260 kernel/cgroup/cgroup.c:5575
>>    process_one_work+0xa0d/0x1c30 kernel/workqueue.c:3314
>>    process_scheduled_works kernel/workqueue.c:3397 [inline]
>>    worker_thread+0x645/0xe80 kernel/workqueue.c:3478
>>    kthread+0x367/0x480 kernel/kthread.c:436
>>    ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>    </TASK>
>>
>> To fix it, add lrugen->reparented to remember the new owner of a
>> reparented lruvec, and make reset_batch_size() charge pending deltas to
>> that owner.
>>
>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Looks reasonable to me.
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks!




