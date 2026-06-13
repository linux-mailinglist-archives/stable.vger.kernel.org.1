Return-Path: <stable+bounces-262997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7RUSE2NCLWqVeQQAu9opvQ
	(envelope-from <stable+bounces-262997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 13:43:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65D67E7D7
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 13:43:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=KBNfIV+v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262997-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262997-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEAF3034DDB
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817EB3AEF34;
	Sat, 13 Jun 2026 11:43:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041C38AC8D
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 11:43:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350986; cv=none; b=qx1zVSLJv0C7zg4T8vUHUTuydbgpvPvhppVUwnDPg/weu77Qi+xDn95WcgQMPScxzWkbh1SYKKOOfon/90jSM+qeHiDD4hzOt5Up4/1DGHcXUFJChOZQBEpRdfhnh8C0QOmhPUlJIthlUXYxjqCmuX2aBRF/eYr2CyEHqENgSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350986; c=relaxed/simple;
	bh=qoJzUjkWZBkktwE2sHSK2VT2WQt7562L/w8R+jSAFBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb8zKhF2KRBJJ7Ld41M3tML6Bm0CmRY/DOGemGiHCPRXKC+Q68Bf5B2QJ61lOTvQA8Hf5IhGEaYfcbt+myTfUtd2BqTKJYNsWZrVlWkHOGByVxTXUIwzq5Z/hJ6/jVqh2fjzmMLvk4/rp3+hOsjBssHa5QXRshHP/ciRBu5IIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBNfIV+v; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781350972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTqTZlrXJGkzf6DKatFJDe6iI2I80SbiVoeN8MMMcZs=;
	b=KBNfIV+ven/Hd5kC64cB1Q5mvlExwdROUuOqN0XZYN+fs9JzDcYq3NL4cJB3IoVKF5dur+
	myZfGDawrF97O+d9K6sS1hTrqdaluLRn59/0+b1I6iJsRaCXPL1g0pjAE1PVbiaJgUlyl+
	gA9m126aYTcFhQZyW1U6Oc9Y30LQbsI=
From: Lance Yang <lance.yang@linux.dev>
To: oleg@redhat.com
Cc: leitao@debian.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	dave@stgolabs.net,
	cai@lca.pw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Sat, 13 Jun 2026 19:42:37 +0800
Message-Id: <20260613114237.6463-1-lance.yang@linux.dev>
In-Reply-To: <ai00wD4ICs1nk4zf@redhat.com>
References: <ai00wD4ICs1nk4zf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262997-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:leitao@debian.org,m:catalin.marinas@arm.com,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:cai@lca.pw,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D65D67E7D7


On Sat, Jun 13, 2026 at 12:45:20PM +0200, Oleg Nesterov wrote:
>To avoid the confusion, I see nothing wrong in this patch, but see
>the question at the end.
>
>On 06/12, Breno Leitao wrote:
>>
>> +/*
>> + * Briefly drop the RCU read lock to reschedule during the task stack scan.
>> + * Both cursors are pinned across the gap; return false if either one was
>> + * unhashed meanwhile, so the caller stops this round instead of walking a
>> + * stale list.
>> + */
>> +static bool kmemleak_stack_scan_break(struct task_struct *g,
>> +				      struct task_struct *p)
>> +{
>> +	bool can_cont;
>> +
>> +	get_task_struct(g);
>> +	get_task_struct(p);
>> +
>> +	rcu_read_unlock();
>> +	cond_resched();
>> +	rcu_read_lock();
>> +
>> +	can_cont = pid_alive(g) && pid_alive(p);
>> +
>> +	put_task_struct(p);
>> +	put_task_struct(g);
>> +
>> +	return can_cont;
>> +}
>
>Perhaps we can rename and export rcu_lock_break() to avoid the duplication...
>
>And, this is slightly off-topic, please ignore, but this reminds me about
>[PATCH 1/2] introduce for_each_process_thread_break() and for_each_process_thread_continue()
>https://lore.kernel.org/all/20180912163335.GA18748@redhat.com/
>
>> @@ -1890,11 +1917,21 @@ static void kmemleak_scan(void)
>>  		rcu_read_lock();
>>  		for_each_process_thread(g, p) {
>>  			void *stack = try_get_task_stack(p);
>> +
>>  			if (stack) {
>>  				scan_block(stack, stack + THREAD_SIZE, NULL);
>>  				put_task_stack(p);
>>  			}
>> +			/*
>> +			 * This is an expensive loop, we must to call the
>> +			 * scheduler to avoid lockups
>> +			 */
>> +			if (need_resched() && !kmemleak_stack_scan_break(g, p)) {
>> +				aborted = true;
>> +				goto unlock;
>
>Can this need_resched() check actually help if CONFIG_PREEMPTION &&
>CONFIG_PREEMPT_RCU ?

Well spotted.

>In this case (lets ignore PREEMPT_DYNAMIC to simplify) rcu_read_lock()
>doesn't disable preemption and cond_resched() is nop, need_resched() is
>(almost) never true. Right?
>
>I guess even in this case it makes sense to not abuse rcu_read_lock()
>"too much", but perhaps we need something more clever than need_resched() ?
>
>Note that check_hung_uninterruptible_tasks() uses time_after()...

Ouch, right, I missed that ...

Would be better trigger the break from time_after(), not need_resched().
need_resched() may not buy much on PREEMPT_RCU ...

So yeah, a time-based check should address your concern, right?

Cheers, Lance

