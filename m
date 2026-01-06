Return-Path: <stable+bounces-205045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A42CF74C8
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 09:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AD8F30074BB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2AD23EA86;
	Tue,  6 Jan 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNYnzVxe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7zaTXcK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNYnzVxe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7zaTXcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7279AD24
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767688113; cv=none; b=q/W7cdkS7uURMvwGs+qiCFMHer7s2dZYiUxlH7MdXAsr3FqpdGug1okVUJ3/zxfCNOu9KERiIv+xzyPQMECAXNst6IANTxJy1pl3lmeMikbaY5qgu2fDPo0vpZUechsZlfk4pfmB5oZs/xtAgGhTJBHyLAVra5T9hSFGyMF7l0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767688113; c=relaxed/simple;
	bh=/JkOEcc/UOgWKttC28XtNlDDzqgtqouXzNtbKsMmcsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOh/eE2/jI6uTd+wbTlT3ZWGdcn/9q1Hb+XeNO0qd3zdgqyh1rMXA76NWhQhMVU0DDOyEvbhJAF/wZgtX/tfCMsz4/tQyn6ca6OuXv+tMKM9q+KJkCkem7Gqc4nXcQfp2qD0Zx768+8KcCYo3A/ne2HgwvmZY+W3KAFoG2AQS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNYnzVxe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7zaTXcK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNYnzVxe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7zaTXcK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2463C33919;
	Tue,  6 Jan 2026 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767688110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tvKwPH/bBOdM6Vqgx5KzmOB0oEuOsw5gHG+7gbN9Y54=;
	b=sNYnzVxeR/bZ8vGV0nF5yiqdoV5vZLHCsj3otCOF21QQUn9V2IFuwJa1ycg0tQvZPcLbPq
	SWJvv4OOTXAa/nlqMFmpudHhyxOFA4u4zo0CrrnmrYnU5argXvc5Ho5iVL9Rl6GI/DzDCk
	iySBvlZo9CBil6x55fkSsLqy12UIBX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767688110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tvKwPH/bBOdM6Vqgx5KzmOB0oEuOsw5gHG+7gbN9Y54=;
	b=K7zaTXcKE77J8MZVHMPM7QPEoYqCKgmmSe9vrlh5JsxeDyl/Tr6M50jLEZq3/Dds9tWhB6
	QY5EQZjxqazkKvDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767688110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tvKwPH/bBOdM6Vqgx5KzmOB0oEuOsw5gHG+7gbN9Y54=;
	b=sNYnzVxeR/bZ8vGV0nF5yiqdoV5vZLHCsj3otCOF21QQUn9V2IFuwJa1ycg0tQvZPcLbPq
	SWJvv4OOTXAa/nlqMFmpudHhyxOFA4u4zo0CrrnmrYnU5argXvc5Ho5iVL9Rl6GI/DzDCk
	iySBvlZo9CBil6x55fkSsLqy12UIBX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767688110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tvKwPH/bBOdM6Vqgx5KzmOB0oEuOsw5gHG+7gbN9Y54=;
	b=K7zaTXcKE77J8MZVHMPM7QPEoYqCKgmmSe9vrlh5JsxeDyl/Tr6M50jLEZq3/Dds9tWhB6
	QY5EQZjxqazkKvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0704E3EA63;
	Tue,  6 Jan 2026 08:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DCpeAa7HXGmVNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Jan 2026 08:28:30 +0000
Message-ID: <04624b16-40ea-42c6-b687-4013796e4779@suse.cz>
Date: Tue, 6 Jan 2026 09:28:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes] mm/page_alloc: prevent pcp corruption with
 SMP=n
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
 <20260105164036.32a22c2e@gandalf.local.home>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260105164036.32a22c2e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.26
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.821];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 1/5/26 22:40, Steven Rostedt wrote:
> On Mon, 05 Jan 2026 16:08:56 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> +++ b/mm/page_alloc.c
>> @@ -167,6 +167,31 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
>>  	pcp_trylock_finish(UP_flags);					\
>>  })
>>  
>> +/*
>> + * With the UP spinlock implementation, when we spin_lock(&pcp->lock) (for i.e.
>> + * a potentially remote cpu drain) and get interrupted by an operation that
>> + * attempts pcp_spin_trylock(), we can't rely on the trylock failure due to UP
>> + * spinlock assumptions making the trylock a no-op. So we have to turn that
>> + * spin_lock() to a spin_lock_irqsave(). This works because on UP there are no
>> + * remote cpu's so we can only be locking the only existing local one.
>> + */
>> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
>> +static inline void __flags_noop(unsigned long *flags) { }
>> +#define spin_lock_maybe_irqsave(lock, flags)		\
>> +({							\
>> +	 __flags_noop(&(flags));			\
>> +	 spin_lock(lock);				\
>> +})
>> +#define spin_unlock_maybe_irqrestore(lock, flags)	\
>> +({							\
>> +	 spin_unlock(lock);				\
>> +	 __flags_noop(&(flags));			\
>> +})
>> +#else
>> +#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
>> +#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
>> +#endif
>> +
> 
> These are very generic looking names for something specific for
> page_alloc.c. Could you add a prefix of some kind to make it easy to see
> that these are specific to the mm code?
> 
>  mm_spin_lock_maybe_irqsave() ?
OK, I think it's best like this:

----8<----
From a6da5d9e3db005a2f44f3196814d7253dce21d3e Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 6 Jan 2026 09:23:37 +0100
Subject: [PATCH] mm/page_alloc: prevent pcp corruption with SMP=n - fix

Add pcp_ prefix to the spin_lock_irqsave wrappers, per Steven.
With that make them also take pcp pointer and reference the lock
field themselves, to be like the existing pcp trylock wrappers.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ec3551d56cde..dd72ff39da8c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -177,19 +177,21 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
  */
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 static inline void __flags_noop(unsigned long *flags) { }
-#define spin_lock_maybe_irqsave(lock, flags)		\
+#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
 ({							\
 	 __flags_noop(&(flags));			\
-	 spin_lock(lock);				\
+	 spin_lock(&(ptr)->lock);			\
 })
-#define spin_unlock_maybe_irqrestore(lock, flags)	\
+#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
 ({							\
-	 spin_unlock(lock);				\
+	 spin_unlock(&(ptr)->lock);			\
 	 __flags_noop(&(flags));			\
 })
 #else
-#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
-#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
+#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
+		spin_lock_irqsave(&(ptr)->lock, flags)
+#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
+		spin_unlock_irqrestore(&(ptr)->lock, flags)
 #endif
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
@@ -2601,9 +2603,9 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	to_drain = pcp->count - pcp->high;
 	while (to_drain > 0) {
 		to_drain_batched = min(to_drain, batch);
-		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
-		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 		todo = true;
 
 		to_drain -= to_drain_batched;
@@ -2626,9 +2628,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 	}
 }
 #endif
@@ -2643,7 +2645,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	int count;
 
 	do {
-		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
@@ -2652,7 +2654,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
 		}
-		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 	} while (count);
 }
 
@@ -6148,12 +6150,12 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 	 * This can reduce zone lock contention without hurting
 	 * cache-hot pages sharing.
 	 */
-	spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
+	pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 	if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
 		pcp->flags |= PCPF_FREE_HIGH_BATCH;
 	else
 		pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
-	spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
+	pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 }
 
 void setup_pcp_cacheinfo(unsigned int cpu)
-- 
2.52.0



