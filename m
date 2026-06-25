Return-Path: <stable+bounces-268272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3KDDqfGPGpVrwgAu9opvQ
	(envelope-from <stable+bounces-268272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:11:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C26C2ECD
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:11:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iPGBHwrr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268272-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268272-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C59C300CBDB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0713BA237;
	Thu, 25 Jun 2026 06:11:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000333BED1E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367907; cv=none; b=EvqlRuJrmyamQnyS7WP6LqVjkcuk1i6QZ6e9EnyCVfZKLqPLUNJ7pSIO6fAwZ2+JKWTeqNDXtDGIAGmIt7wAwQjLfWORLs4rEyOcFGGFSQ9lO+3/n13x3r4Uqc8yvZN6uDC+spMKfF6roRvOBpI/0CR466I54Qg8VJGN37YZ3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367907; c=relaxed/simple;
	bh=WgQRdI0Kdq7aEnVKb9c7OASS4yeb0qoaPNVU8f06+4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2w+4hnqPBuunNkxzUMBoOSm6jrMd3EWAjlTd2SkO/wVBEpNxEMIVLM/pGMgU75qC/8r6hIG5xLg8ecf6LsD4XjuclCpJn3orkC0XHVDnFCRbvtB4UnOBaUZKp2kVZw8ukDdWyMAuLOUrDeoNhVFX+Gj4MbhuY2UCUscHmVkj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iPGBHwrr; arc=none smtp.client-ip=91.218.175.172
Message-ID: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782367902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSTBB1mth+fzw/4QWCYM0WAsrU6UvEDP/rElXqwnzw=;
	b=iPGBHwrrH9Djk0Ix8CjAt1/PVSBSALGaCFIEyhK2JpKUjjK5oqL4Kvv49azNzeQj1p7opV
	AvvGRxc4A7tCrGXQeM9eUrYiqoM4c3Oxf9OY2OwHdnLR5DDX1qI4+bWRL0tkPtH6eDuH9m
	urj5++hBAxg8aHMFtF4rsCCPvANwrXM=
Date: Thu, 25 Jun 2026 14:11:22 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-268272-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 141C26C2ECD



On 6/25/26 12:16 PM, Harry Yoo wrote:
> 

[...]

> 
>> So lock_batch_lruvec() can be implemented like this:
>>
>> #ifdef CONFIG_MEMCG
>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> {
>>      struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>      struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>
>>      rcu_read_lock();
>>
>>      /*
>>       * The memcg can be NULL when the memory controller is disabled.
>>       * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>       */
>>      if (!memcg || !css_is_dying(&memcg->css))
>>          goto lock;
>>
>>      do {
>>          memcg = parent_mem_cgroup(memcg);
>>      } while (memcg && css_is_dying(&memcg->css));
>>      lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>
>> lock:
>>      spin_lock_irq(&lruvec->lru_lock);
>>
>>      return lruvec;
>> }
>> #else
>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> {
>>      lruvec_lock_irq(lruvec);
>>
>>      return lruvec;
>> }
>> #endif
>>
>> Does this make sense?
> 
> Yes, looks good to me!

OK, this sync method makes more sense as it doesn't require adding a
new lrugen->reparente. I'll go with this method and update v3.

Hi Barry and Baolin, what do you think? Since the sync method has been
changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)

Thanks,
Qi

> 


