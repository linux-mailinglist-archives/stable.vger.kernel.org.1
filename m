Return-Path: <stable+bounces-95413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACC9D8958
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F73282C7E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E21B3934;
	Mon, 25 Nov 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/SIgu2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8FBfrOwm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/SIgu2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8FBfrOwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09002195390;
	Mon, 25 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548492; cv=none; b=CjsYBo6Nk5T/7ORsmnDTvddmsyH4jZmiGaYM0mBvBnbOfSXSxcEshqB7f0RIa9P8MqJlk0Lli4mRhQmVJfCtT6amaDu41aNyfisF2aU6nYbPblwD3cA2WROBmH8Tdg+yeeemE4m2rsm2jIqSw0bMLf7oXgW5BbNgDTQcH5xI3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548492; c=relaxed/simple;
	bh=c4UBsCk/bTZ25+r9/W1hG65cmRH35pO7wv6zElwDRMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8SSRAfbrR7JO1+8OnRS/2gWgv18SOHbcsXvZoajVx6dreWBWgOgOh3untkvOhpNs9r9D3/VxNOsClE9AJk5bB+pc+op4XvvXfqmHSn6PMT1iOXrFeTufp4TfnSdkjEM42huzdOVfwGjVoXkPAtSOy53oJWon/9J2+RmhSIN1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/SIgu2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8FBfrOwm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/SIgu2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8FBfrOwm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16AEE1F44E;
	Mon, 25 Nov 2024 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9KkrFmxvAZk1Rs1JZjgXU4+kHt/tNWeqhQeXdQeSI4I=;
	b=p/SIgu2kCw0aX4s3Qyc7y8CjXir8dI56nDELJVXI9tiUAEQp/YpwX+2eo6wJ1fYj2jsQY8
	r32vJNua96vFznPtgnYGGjHoJXqVwgyGYyTCglItYfejCOeGkI13h+8Ns5MMMtsp+iSZWS
	5dxhSac54YFsn4+T2gjRvoxwYNf5yHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9KkrFmxvAZk1Rs1JZjgXU4+kHt/tNWeqhQeXdQeSI4I=;
	b=8FBfrOwmIGcG9rpu9chvreWMRiX2lpVtyFhOBcmEQPLL09KezCIBRZQfQfn12XEdpb5X28
	D5uu4hqP0CogPwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9KkrFmxvAZk1Rs1JZjgXU4+kHt/tNWeqhQeXdQeSI4I=;
	b=p/SIgu2kCw0aX4s3Qyc7y8CjXir8dI56nDELJVXI9tiUAEQp/YpwX+2eo6wJ1fYj2jsQY8
	r32vJNua96vFznPtgnYGGjHoJXqVwgyGYyTCglItYfejCOeGkI13h+8Ns5MMMtsp+iSZWS
	5dxhSac54YFsn4+T2gjRvoxwYNf5yHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9KkrFmxvAZk1Rs1JZjgXU4+kHt/tNWeqhQeXdQeSI4I=;
	b=8FBfrOwmIGcG9rpu9chvreWMRiX2lpVtyFhOBcmEQPLL09KezCIBRZQfQfn12XEdpb5X28
	D5uu4hqP0CogPwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E75F013890;
	Mon, 25 Nov 2024 15:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLUYOIiXRGd+XQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Nov 2024 15:28:08 +0000
Message-ID: <87259367-a81d-4e08-8d5e-6db8a540afdb@suse.cz>
Date: Mon, 25 Nov 2024 16:28:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 0/4] fix error handling in mmap_region() and
 refactor (hotfixes)
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,google.com,vger.kernel.org,kvack.org,redhat.com,arm.com,kernel.org,davemloft.net,gaisler.com,HansenPartnership.com,gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/15/24 13:36, Lorenzo Stoakes wrote:
> Critical fixes for mmap_region(), backported to 5.10.y.
> 
> Some notes on differences from upstream:
> 
> * We do NOT take commit 0fb4a7ad270b ("mm: refactor
>   map_deny_write_exec()"), as this refactors code only introduced in 6.2.
> 
> * We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
>   handling" to parisc, but the referenced functionality does not exist in
>   this kernel.
> 
> * In this kernel is_shared_maywrite() does not exist and the code uses
>   VM_SHARED to determine whether mapping_map_writable() /
>   mapping_unmap_writable() should be invoked. This backport therefore
>   follows suit.
> 
> * The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
>   use a local static variable in mmap_file() and vma_close().
> 
> * Each version of these series is confronted by a slightly different
>   mmap_region(), so we must adapt the change for each stable version. The
>   approach remains the same throughout, however, and we correctly avoid
>   closing the VMA part way through any __mmap_region() operation.
> 
> * In 5.10 we must handle VM_DENYWRITE. Since this is done at the top of the
>   file-backed VMA handling logic, and importantly before mmap_file() invocation,
>   this does not imply any additional difficult error handling on partial
>   completion of mapping so has no significant impact.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> Lorenzo Stoakes (4):
>   mm: avoid unsafe VMA hook invocation when error arises on mmap hook
>   mm: unconditionally close VMAs on error
>   mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
>   mm: resolve faulty mmap_region() error path behaviour
> 
>  arch/arm64/include/asm/mman.h | 10 +++--
>  include/linux/mman.h          |  7 +--
>  mm/internal.h                 | 19 ++++++++
>  mm/mmap.c                     | 82 +++++++++++++++++++++--------------
>  mm/nommu.c                    |  9 ++--
>  mm/shmem.c                    |  3 --
>  mm/util.c                     | 33 ++++++++++++++
>  7 files changed, 117 insertions(+), 46 deletions(-)
> 
> --
> 2.47.0


