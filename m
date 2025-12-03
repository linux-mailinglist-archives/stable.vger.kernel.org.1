Return-Path: <stable+bounces-198180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4DC9E673
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 10:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74F294E404D
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850502D73BA;
	Wed,  3 Dec 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EqByOCv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pRNfg0NC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnkZOsRi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jn5u6PTh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52946271A6D
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752747; cv=none; b=Az26mOoFOogoLBRvDMl7MK16GODyKxjY/4XtnlzPuh2FOP22gS9cW9GaaAR3mO5V8aiUejktjdeZh+VKeJIH8khp5v5TXpVWW/Z2ZbbauZedjdowfZQFMAIzEFnOGjQEksWJnj3MgpQqePDqCMuFVW2EWCKivwO0LjyAWcuR9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752747; c=relaxed/simple;
	bh=DAGI9Ioi6ztnAypdp2kIkMM3QStjyaeB7xdHgEhFtmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLule+732Dq0bcOozvYGdUino1LNHJ2ams2lc4TTdIaX4uRy1p+COJJV4RO3ue6YImmhzY8r8EGLnpjoVy34odDjZUrTDWp6tBpDWq3L1PmvfQ34zmFKxOQ5EaDqxVJmiO0ucOIDaXx5ecjpCzvGJyrptV4zYAqdRWFX5CNmBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EqByOCv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pRNfg0NC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnkZOsRi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jn5u6PTh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 534CB5BD11;
	Wed,  3 Dec 2025 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764752743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9i0uZEXfryYmRDOj1tZU5zIDdqToxJZuStlSqSA5Cu4=;
	b=EqByOCv5f6xy2S5L3nmbUhfHb1PDE9/T2M63l4dNR358xxSx+4cMvQqWBdtYELnVlkx0et
	xZh4XsitXv/TJFhSnY0bt/bJzosaLFyd1qChRJ8Q0uu1CTNCKtOAqk8FHD2MbVGfQ4S2+b
	tvZhcaEePRrDw3EksA3FAseZdXC14c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764752743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9i0uZEXfryYmRDOj1tZU5zIDdqToxJZuStlSqSA5Cu4=;
	b=pRNfg0NCClqR+Ks+uF00wQEcqN8zgB1pK4nu2/hFdWLhYfeoWYS9QWNtO/PzvazxMLEfvl
	aaVQWbWToe3ww7CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764752742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9i0uZEXfryYmRDOj1tZU5zIDdqToxJZuStlSqSA5Cu4=;
	b=ZnkZOsRicBnc60fjMWdIUpX/KxMGC0G6ddqckLYAkqaqjo1xqTQpPZMljxXKKtN5UITZes
	/B6BkUcwT2MM7Y2Rv3asaQh9Dr6lTpvX1y3gPP9pAJaQUYK2TR/72ZV//Mx2xeXE5wAvjw
	gvyA1bBAF8q/u5baMzxjIl5F7fnbvLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764752742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9i0uZEXfryYmRDOj1tZU5zIDdqToxJZuStlSqSA5Cu4=;
	b=jn5u6PTh1tGUmJtSPjtvrIfSBOZnYustDCUnYNpSflvPBy2xcc+kU4TKnc89flxFNmcIb9
	6e3TPQCYikwfoOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 247F13EA63;
	Wed,  3 Dec 2025 09:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZUyyB2b9L2nOdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Dec 2025 09:05:42 +0000
Message-ID: <acd1a9db-6da6-4168-9493-3e9a920e6ede@suse.cz>
Date: Wed, 3 Dec 2025 10:05:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
To: Harry Yoo <harry.yoo@oracle.com>
Cc: surenb@google.com, Liam.Howlett@oracle.com, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 sidhartha.kumar@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 atomlin@atomlin.com, lucas.demarchi@intel.com, akpm@linux-foundation.org,
 jonathanh@nvidia.com, stable@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>
References: <20251202101626.783736-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251202101626.783736-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,kernel.org,suse.com,atomlin.com,intel.com,linux-foundation.org,nvidia.com,samsung.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email]

On 12/2/25 11:16, Harry Yoo wrote:
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary; only the RCU
> sheaves belonging to the cache being destroyed need to be flushed.
> 
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache.
> 
> Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
> call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().
> 
> Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
> cache destruction.
> 
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
> 
> Before:
>   Total calls: 19
>   Average latency (us): 18127
>   Total time (us): 344414
> 
> After:
>   Total calls: 19
>   Average latency (us): 10066
>   Total time (us): 191264
> 
> Two performance regression have been reported:
>   - stress module loader test's runtime increases by 50-60% (Daniel)
>   - internal graphics test's runtime on Tegra23 increases by 35% (Jon)
> 
> They are fixed by this change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
> Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Thanks a lot! Added to slab/for-next-fixes


