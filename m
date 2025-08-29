Return-Path: <stable+bounces-176706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0FB3BBF0
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C9A3BC794
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F462EB869;
	Fri, 29 Aug 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUPCVKSy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmKTkB2U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUPCVKSy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmKTkB2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E02E2F15
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472942; cv=none; b=JUARFyTZVdO2ldD3gWJOMNPfjHqu712Fxa1k4Hvpdwl3qdk7RQHkj8dQV3mckitPwcb6jt2QrE8T9NyaXx4ZfhGfc9Ag1tIhADMj2SjEii5aUpXJLucmrJGnQ/WkK1IktrjKNAWyrFm7AzYUTVsq6cC2QXOx2Q8UC8DSG477wlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472942; c=relaxed/simple;
	bh=CydeifRpFW8OhJcRHUSI9Ddala1PxiiTJR3GOyT+6HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Icawd/qK6AMGhM8AfSsICXKavO9d7333oRdnCesOSyTmUIiVXZsNiRXch22+9AJETuL+XHehJr1IILtVJnU/bSZO5zWQVo872IbPsJU6S8INHBLW/dwe4H2CJLReObU9xz7ZaZ0xVUSICLmybIOpLVNiCMJUvy2k4IstBnkANSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUPCVKSy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmKTkB2U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUPCVKSy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmKTkB2U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A7805C168;
	Fri, 29 Aug 2025 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756472939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=791NkJ4GQDv4mRfrc+N3Wc0IZX7qUnzbVa1JWAT9NdA=;
	b=dUPCVKSyuHl5iCk0KVUt9VwJRBL7S0tcv5JjPuiE1AD+OE1I4nrXiUVngyx2LjJfX0PZEU
	80RfKupU53P6wWmp9EkrM7vXqJ+qGl9+Rq79pamqLqNHDiWHqzaKFYhutO8LcZmKrjmzpF
	lcLxdI/r/UUe/+Va4N7WgmvqbuhN4b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756472939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=791NkJ4GQDv4mRfrc+N3Wc0IZX7qUnzbVa1JWAT9NdA=;
	b=PmKTkB2UEsLZRa78gTpbp8+liHHmcOmf9Y9ZLHkdCq7hEt4j1cEMZ2+CtVGVRq0H1+iD2y
	wZVj6TxUj+UBL6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756472939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=791NkJ4GQDv4mRfrc+N3Wc0IZX7qUnzbVa1JWAT9NdA=;
	b=dUPCVKSyuHl5iCk0KVUt9VwJRBL7S0tcv5JjPuiE1AD+OE1I4nrXiUVngyx2LjJfX0PZEU
	80RfKupU53P6wWmp9EkrM7vXqJ+qGl9+Rq79pamqLqNHDiWHqzaKFYhutO8LcZmKrjmzpF
	lcLxdI/r/UUe/+Va4N7WgmvqbuhN4b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756472939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=791NkJ4GQDv4mRfrc+N3Wc0IZX7qUnzbVa1JWAT9NdA=;
	b=PmKTkB2UEsLZRa78gTpbp8+liHHmcOmf9Y9ZLHkdCq7hEt4j1cEMZ2+CtVGVRq0H1+iD2y
	wZVj6TxUj+UBL6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32E5B13326;
	Fri, 29 Aug 2025 13:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ozVSC2umsWj7eAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 29 Aug 2025 13:08:59 +0000
Message-ID: <9dbd300c-240b-477f-ba03-8a17c7c2b84b@suse.cz>
Date: Fri, 29 Aug 2025 15:08:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: slub: avoid wake up kswapd in set_track_prepare
To: yangshiguang <yangshiguang1011@163.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Matthew Wilcox <willy@infradead.org>,
 akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com,
 roman.gushchin@linux.dev, glittao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>,
 stable@vger.kernel.org
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
 <aKxZp_GgYVzp8Uvt@casper.infradead.org>
 <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz> <aK6U61xNpJS0qs15@hyeyoo>
 <6e1ab9d8.6595.198ea7d7a78.Coremail.yangshiguang1011@163.com>
 <fc6f7372-efb4-48e3-b217-c8bec0065b97@suse.cz>
 <4d271e7e.6bea.198f596bd15.Coremail.yangshiguang1011@163.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <4d271e7e.6bea.198f596bd15.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,infradead.org,linux-foundation.org,gentwo.org,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,xiaomi.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/29/25 13:29, yangshiguang wrote:
> At 2025-08-27 16:40:21, "Vlastimil Babka" <vbabka@suse.cz> wrote:
> 
>>> 
>>>>
>>> 
>>> How about this? 
>>> 
>>>         /* Preemption is disabled in ___slab_alloc() */
>>> -       gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
>>> +       gfp_flags = (gfp_flags & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL)) |
>>> +                                       __GFP_NOWARN;
>>
>>I'd suggest using gfp_nested_flags() and & ~(__GFP_DIRECT_RECLAIM);
>>
> 
> However, gfp has been processed by gfp_nested_mask() in
> stack_depot_save_flags().

Aha, didn't notice. Good to know!

> Still need to call here?

No then we can indeed just mask out __GFP_DIRECT_RECLAIM.

Maybe the comment could say something like:

/*
 * Preemption is disabled in ___slab_alloc() so we need to disallow
 * blocking. The flags are further adjusted by gfp_nested_mask() in
 * stack_depot itself.
 */
> set_track_prepare()
> ->stack_depot_save_flags()
> 
>>>  >-- 
>>>>Cheers,
>>>>Harry / Hyeonggon


