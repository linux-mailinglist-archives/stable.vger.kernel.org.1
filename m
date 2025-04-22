Return-Path: <stable+bounces-135041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCF9A95F03
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940ED1887E08
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CB22F167;
	Tue, 22 Apr 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIkR8bCZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xcRyKQdJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIkR8bCZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xcRyKQdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A396CA64
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305858; cv=none; b=Ok824a7omEROok5Q5VT8wIIm2gcso2ZihxLl1YOo5hyZ0ONATmpLiUi7HOpxI+RTgvA/XPfACsB5bCM5cC6D57lm/zJ8QMqkYrQPB9fNweEGTWKvdf/XejJg9vWXepH+9jhf2+24rqOFvSVkLrYs9Lb3j//CUAZo3MseVOwpW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305858; c=relaxed/simple;
	bh=wE0p8qL7EoSQb+6BZCxumSQY/14KqFPPb98hPDDwGA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkb0Do1+pxhUSarLAS4isUItVNbYtfVtivZVchUSSBiFHH8ABkA9IJ8hq+lcL3K2Hnbi7CwfqhajhuZ/beAbqiPP1bPQ9NHxeJazV/xRZYwNG8uPxLm+hsXLwsGfzj4Ka3QOE2tqUoE/c6Rxbvt/zJa53OvWitqTYf/GJFdGkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIkR8bCZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xcRyKQdJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIkR8bCZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xcRyKQdJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88EA521180;
	Tue, 22 Apr 2025 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745305854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3Ak9TZl3KNC2bPW1og4esnB7Pyo179OZKtLkCOfiYE=;
	b=AIkR8bCZSArLLT7smXMgXeDqrq3vOuabF6Zh/oTjekbgCz51z5FgZLtXdMvfV8oRfeobke
	vOefLn2+GcWOuq4ta+TenlQC6WpM1VPEcseHyRoPW2eF/Pv87LdZPanLsULFBQ1CEsL8SE
	ITQaNeeyF41Nhb+ZiApG5B1FSbFfXos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745305854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3Ak9TZl3KNC2bPW1og4esnB7Pyo179OZKtLkCOfiYE=;
	b=xcRyKQdJAeu+ZlD+07ouLrNQlIQ8X4OyuLh6/RodyWzd4Z7+bbRD2SjMzP961Y0k638Qmb
	OBAABe87AoEOBTDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745305854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3Ak9TZl3KNC2bPW1og4esnB7Pyo179OZKtLkCOfiYE=;
	b=AIkR8bCZSArLLT7smXMgXeDqrq3vOuabF6Zh/oTjekbgCz51z5FgZLtXdMvfV8oRfeobke
	vOefLn2+GcWOuq4ta+TenlQC6WpM1VPEcseHyRoPW2eF/Pv87LdZPanLsULFBQ1CEsL8SE
	ITQaNeeyF41Nhb+ZiApG5B1FSbFfXos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745305854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3Ak9TZl3KNC2bPW1og4esnB7Pyo179OZKtLkCOfiYE=;
	b=xcRyKQdJAeu+ZlD+07ouLrNQlIQ8X4OyuLh6/RodyWzd4Z7+bbRD2SjMzP961Y0k638Qmb
	OBAABe87AoEOBTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6523C137CF;
	Tue, 22 Apr 2025 07:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W6FUGP5AB2jmNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Apr 2025 07:10:54 +0000
Message-ID: <6a2b474c-764e-434c-be23-2f366b81c839@suse.cz>
Date: Tue, 22 Apr 2025 09:10:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: cl@linux.com, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, pasha.tatashin@soleen.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
 <CAJuCfpGwspnceQ5oq_ovViHnawcVCkM1pKawJGckfKsvK1s_Aw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGwspnceQ5oq_ovViHnawcVCkM1pKawJGckfKsvK1s_Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/21/25 18:02, Suren Baghdasaryan wrote:
> On Mon, Apr 21, 2025 at 12:52 AM Zhenhua Huang
> <quic_zhenhuah@quicinc.com> wrote:
>>
>> When memory allocation profiling is disabled at runtime or due to an
>> error, shutdown_mem_profiling() is called: slab->obj_exts which
>> previously allocated remains.
>> It won't be cleared by unaccount_slab() because of
>> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
>> should always be cleaned up in unaccount_slab() to avoid following error:
>>
>> [...]BUG: Bad page state in process...
>> ..
>> [...]page dumped because: page still charged to cgroup
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object extensions")
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>> Tested-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> 
>> ---
>>  mm/slub.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 566eb8b8282d..a98ce1426076 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2028,8 +2028,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>         return 0;
>>  }
>>
>> -/* Should be called only if mem_alloc_profiling_enabled() */
>> -static noinline void free_slab_obj_exts(struct slab *slab)
>> +/* Free only if slab_obj_exts(slab) */
> 
> nit: the above comment is unnecessary. It's quite obvious from the code.

Agreed, I've removed it locally and added the patch to slab/for-next-fixes
Thanks!

>> +static inline void free_slab_obj_exts(struct slab *slab)
>>  {
>>         struct slabobj_ext *obj_exts;
>>
>> @@ -2601,8 +2601,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
>>  static __always_inline void unaccount_slab(struct slab *slab, int order,
>>                                            struct kmem_cache *s)
>>  {
>> -       if (memcg_kmem_online() || need_slab_obj_ext())
>> -               free_slab_obj_exts(slab);
>> +       /*
>> +        * The slab object extensions should now be freed regardless of
>> +        * whether mem_alloc_profiling_enabled() or not because profiling
>> +        * might have been disabled after slab->obj_exts got allocated.
>> +        */
>> +       free_slab_obj_exts(slab);
>>
>>         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>>                             -(PAGE_SIZE << order));
>> --
>> 2.34.1
>>


