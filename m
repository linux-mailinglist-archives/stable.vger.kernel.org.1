Return-Path: <stable+bounces-188294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB9BF4CEC
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7112818C5C0F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCED274B2A;
	Tue, 21 Oct 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJUF1Sii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CDFaaZ1U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JRo30k8r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UY6yhdWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488927466D
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030288; cv=none; b=Kt3ptBncZ1N7gEWnp/FxvCSpfkW6rYbT2PEIoq0FlMltnhA8F2hJirKGGUIQQg4dIF6DWIZHfwTN93UMkKIApqgMUobguBW1wGeAxlIKsaa2e151YEpKF+4oj8mhPbQHXH1VQdB31fL7rfj5X9tz0audUSnFbj0N9KohV81Sj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030288; c=relaxed/simple;
	bh=rQ+CUkJdoRT0ozNPnoytiGWj/GejocPZ37c2TUaKIbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hElIcrdYiw2/zissH+Xdj0k+Qx8P9iFXlmuhUPdSGnbxlcXmI6qdyZgMYESI5jlw3MJQ5WIRPH7Pf3ClORJqRlAxN3W/MGKPEo8DRzea96CqL72UjoPsiL3a6wrGm76CAVvzhZ5TIeton1J5iMG0b/ZjlF+jWupEY1Wy9PSCa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJUF1Sii; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CDFaaZ1U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JRo30k8r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UY6yhdWy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 669F6211E9;
	Tue, 21 Oct 2025 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761030279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UKa23txq5VZUcJ3KpkIgUf0mRuHZ2KAGGjulu7Eo99s=;
	b=nJUF1SiiczGXdcJgqVdI10l5W3jAiIMIz/vFLGByHgcgBR1Fb76iL33fLu1/t2yL8DGw2i
	A8oYP5lEGXkxJM/Eddlst0M+/f6CRN/eBvSy2zuPn64/pAUIG9KIyO7N8z80jCASAQsVwV
	z4rzqZOHdJ2+1+fRfF8pzE4nqUsF7Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761030279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UKa23txq5VZUcJ3KpkIgUf0mRuHZ2KAGGjulu7Eo99s=;
	b=CDFaaZ1U4RVA4MONSr3k68hzq23fEQIPc481aV7/8k6aBmmEOlYMOcquhB9mxR5Vl7LSS+
	agiGUBVWJP8mXxCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JRo30k8r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UY6yhdWy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761030275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UKa23txq5VZUcJ3KpkIgUf0mRuHZ2KAGGjulu7Eo99s=;
	b=JRo30k8rYa3bP1bS2eHkjrV16N81bi+ALvbpYx7eVyroiHV+TQBR/s5GvDqmV3CbY9yBb5
	WjjXAXYK/czIxA3raAMTRliYok2qrqzZ9DqUntHjlXCiysMs+zdtrZ+GZopY4Og/kahyY8
	c3Tg/TpZoxmOO12OqQWFl1eknt3OBFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761030275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UKa23txq5VZUcJ3KpkIgUf0mRuHZ2KAGGjulu7Eo99s=;
	b=UY6yhdWykkfCRRy6ZK+k+gNZnRHDbGZoS0fdr/1JW+GyCqSE81lGzy8Qag0A9z1RALUzXW
	6Z7z4QJlNfYtq8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B696139D2;
	Tue, 21 Oct 2025 07:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id owgTEoMw92h/OwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 21 Oct 2025 07:04:35 +0000
Message-ID: <1e1376fd-1d38-4dde-918a-d4e937d4feac@suse.cz>
Date: Tue, 21 Oct 2025 09:04:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slab: Avoid race on slab->obj_exts in
 alloc_slab_obj_exts
To: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 stable@vger.kernel.org
References: <20251021010353.1187193-1-hao.ge@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251021010353.1187193-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 669F6211E9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,kylinos.cn:email];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/21/25 03:03, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> If two competing threads enter alloc_slab_obj_exts() and one of them
> fails to allocate the object extension vector, it might override the
> valid slab->obj_exts allocated by the other thread with
> OBJEXTS_ALLOC_FAIL. This will cause the thread that lost this race and
> expects a valid pointer to dereference a NULL pointer later on.
> 
> Update slab->obj_exts atomically using cmpxchg() to avoid
> slab->obj_exts overrides by racing threads.
> 
> Thanks for Vlastimil and Suren's help with debugging.
> 
> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Added to slab/for-next-fixes, thanks!

> ---
> v3: According to Suren's suggestion, simplify the commit message and the code comments.
>     Thanks for Suren.
> 
> v2: Incorporate handling for the scenario where, if mark_failed_objexts_alloc wins the race,
>     the other process (that previously succeeded in allocation) will lose the race, based on Suren's suggestion.
>     Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slub.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2e4340c75be2..d4403341c9df 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>  
>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>  {
> -	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
> +	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>  }
>  
>  static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> @@ -2136,6 +2136,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  #ifdef CONFIG_MEMCG
>  	new_exts |= MEMCG_DATA_OBJEXTS;
>  #endif
> +retry:
>  	old_exts = READ_ONCE(slab->obj_exts);
>  	handle_failed_objexts_alloc(old_exts, vec, objects);
>  	if (new_slab) {
> @@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		 * be simply assigned.
>  		 */
>  		slab->obj_exts = new_exts;
> -	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> -		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
> +	} else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
>  		/*
>  		 * If the slab is already in use, somebody can allocate and
>  		 * assign slabobj_exts in parallel. In this case the existing
> @@ -2158,6 +2158,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		else
>  			kfree(vec);
>  		return 0;
> +	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
> +		/* Retry if a racing thread changed slab->obj_exts from under us. */
> +		goto retry;
>  	}
>  
>  	if (allow_spin)


