Return-Path: <stable+bounces-214900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA05Kji8iWmkBQUAu9opvQ
	(envelope-from <stable+bounces-214900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:51:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5810E600
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EF5A30117B8
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82118367F49;
	Mon,  9 Feb 2026 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D5BLWbaZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYr2yEgi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CglPIfHO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8T5a8tSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944A36606B
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634293; cv=none; b=UDJIX5XTAc4B5n5w4zEgpkUVUqIHKXLbreemapsRDgDdfWfFF45J7NJvghDGMhuPehLyf+0JMu3ps4+eFNrEH0PM0xRGdWfRvgO+VazbG/dzb3G2UY3lKuWZd9bvwnAGxp6AAsNtRErjPt4nu5YFGOYDTrApoF0gHr60o6vUi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634293; c=relaxed/simple;
	bh=LstStMZczcT4m0dWQzXHT5JF5QbzbPAecbu27TkJcnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IexpfIkWgzPFOgl5P4po+eXpF6F3kUiAKmNyEBkIUIfFmE2v9gPl+rtd8Demi2uTod3wb9gcr4osTjJoSXyrDTRUnDt9NdllECXnSyPu485PlTxU1NW7/uY5pBxhs18akiT4eK4qKWrviwOZBXH+2moo45x/MoqEOPlJlf5RIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D5BLWbaZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYr2yEgi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CglPIfHO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8T5a8tSu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAE8D5BD0C;
	Mon,  9 Feb 2026 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770634291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tl9GPRip3rgX2OqDOoiS8dQTWDyvLwz1/dMI6eGzFFE=;
	b=D5BLWbaZKlII/sOXZc2a6C0+5OkIW73vhjG5RqLeBCp6KdYKOnDrZgvLBvX5RBQp2aAh+K
	a2Eaap/FKpm0T5jFbHGmuyxfEVSEgE3c5eAWoS2uf7cwp2LeDAL67H7KhuW11Hr5cHl8mA
	YZDnbJPwg5dMLuvh2GKS3Dymx8cFn7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770634291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tl9GPRip3rgX2OqDOoiS8dQTWDyvLwz1/dMI6eGzFFE=;
	b=cYr2yEgiU1eHJSf/pQ7P5KvmQR9wK+FsWcCorHMmQkk67qKJ8lDKhRT+UUgZmeqklOkYXE
	e+QsITG32pNkskCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770634289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tl9GPRip3rgX2OqDOoiS8dQTWDyvLwz1/dMI6eGzFFE=;
	b=CglPIfHObV7n/enWmPPUs2yFg0dvdh7F1X5BhmH7NuHl8y+oT9NL9YzrW+gIck0qKLf9HR
	8p54+0Z1rLas7yXzR9brrYC0rbrIAW5MJywQ/BNwfGWxb1nxJr2aSN9Rr1GmmTPkLZZiVL
	MJApKEZ9g7T/GglrNJENpjjq21kPhao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770634289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tl9GPRip3rgX2OqDOoiS8dQTWDyvLwz1/dMI6eGzFFE=;
	b=8T5a8tSuhBcQ2x/0EcWspreSTEAUVDgxMKKyAhzKwKkNCCjofilt/uJ4vf/Q3mWsPNepVD
	Gd3s+T+Aji6RR7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD6B53EA63;
	Mon,  9 Feb 2026 10:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9FilKzG8iWmPDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Feb 2026 10:51:29 +0000
Message-ID: <577befda-7f41-40bf-8a44-095ae184a100@suse.cz>
Date: Mon, 9 Feb 2026 11:51:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/page_alloc: skip debug_check_no_{obj,locks}_freed
 with FPI_TRYLOCK
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20260209062639.16577-1-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260209062639.16577-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-214900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20B5810E600
X-Rspamd-Action: no action

On 2/9/26 07:26, Harry Yoo wrote:
> When CONFIG_DEBUG_OBJECTS_FREE is enabled,
> debug_check_no_{obj,locks}_freed() functions are called.
> 
> Since both of them spin on a lock, they are not safe to be called
> if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:
> 
>   ================================
>   WARNING: inconsistent lock state
>   6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
>   --------------------------------
>   inconsistent {INITIAL USE} -> {IN-NMI} usage.
>   kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
>   ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
>   {INITIAL USE} state was registered at:
>     lock_acquire+0xd9/0x2f0
>     _raw_spin_lock_irqsave+0x4c/0x80
>     __debug_object_init+0x9d/0x1f0
>     debug_object_init+0x34/0x50
>     __init_work+0x28/0x40
>     init_cgroup_housekeeping+0x151/0x210
>     init_cgroup_root+0x3d/0x140
>     cgroup_init_early+0x30/0x240
>     start_kernel+0x3e/0xcd0
>     x86_64_start_reservations+0x18/0x30
>     x86_64_start_kernel+0xf3/0x140
>     common_startup_64+0x13e/0x148
>   irq event stamp: 2998
>   hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
>   hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
>   softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
>   softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
> 
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&obj_hash[i].lock);
>     <Interrupt>
>       lock(&obj_hash[i].lock);
> 
>    *** DEADLOCK ***
> 
> Rename free_pages_prepare() to __free_pages_prepare(), add an fpi_t
> parameter, and skip those checks if FPI_TRYLOCK is set. To keep the
> fpi_t definition in mm/page_alloc.c, add a wrapper function
> free_pages_prepare() that always passes FPI_NONE and use it in
> mm/compaction.c.
> 
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

