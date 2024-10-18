Return-Path: <stable+bounces-86888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00D9A4950
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EFD1F22A73
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456818FC9F;
	Fri, 18 Oct 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFiVNI9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6SR0CAZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjxGLlP7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="stLj9048"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29618E354
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288622; cv=none; b=iKuCDyafmzTp/KcqEW8CkJz8sNgziouw6H+ffuJdI2Nt5RMn3DtGXJA1gSy9sgxf9B6l5o5hEWSqrSaCqFt05K5EJShJyUMSekNjOHTwyUXMd4e0eLl0IFQNdLmo3Ve0xGaUvbECVbyFUpb4xFRNeWh8KHIMxnAJnymiNSCyJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288622; c=relaxed/simple;
	bh=j0ni7WwqM/Te6JXvtjuEO8ncaHHsBb0jV1hdDg22ImU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1DM9ytk3dHkB+UsIxdZG5CXKt62VZvZhzztCIDMRKzjgNijdH1ZD+1V1yaa8VNvvpHxdngt5S13QIjsRUg5fJKj+i2LcP+l9FtmFFRCT7Ae0TKlqy9CgYr8nVhFmcCH5KC72TWTdX25j4Q/3y3fsacCMzI489CALIfMymfOWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFiVNI9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6SR0CAZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjxGLlP7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=stLj9048; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBEAD21E63;
	Fri, 18 Oct 2024 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729288618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybQxx6Ok20w/0cFuj9fGq4A2uA8alamK9p6O5aCSgmc=;
	b=UFiVNI9sd69jt9KxWiIR/JJHIhDeNhdsPGXxtxqZOrnKYdfi742zGgd8S4ze7mWsgpf0fd
	k4CQ71Mssr3kf9W1dfbPfhbO8CnsOSy93Ckfem+HyPeDVRYg8kTJUpPpzKTJ42Iw06wxXx
	DdhvCyKA4FZ865Yzw5lq9BUnmLTxgSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729288618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybQxx6Ok20w/0cFuj9fGq4A2uA8alamK9p6O5aCSgmc=;
	b=A6SR0CAZcmYFY3MddJmSTbAurOTWnTqa3mbXTfzBuFUiyUSys7wj7g3hlwoaWN4ObLcJPo
	syfgKSkSCHf3WgCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rjxGLlP7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=stLj9048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729288617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybQxx6Ok20w/0cFuj9fGq4A2uA8alamK9p6O5aCSgmc=;
	b=rjxGLlP7BA8ELdcYON87cDnP4m2VZ85M/ToMj4LSjKIVyloIVokxOIvKDOr/ueDz8baLRL
	27B30Ktr67qcaKXVI9+KpkhRbvZsqNMUsMENBqA/w87SOiSz1tW1zceno5gY4fAvEfGFRs
	MdbYQBiou/RrABF5j02W+GWNkoboYxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729288617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybQxx6Ok20w/0cFuj9fGq4A2uA8alamK9p6O5aCSgmc=;
	b=stLj9048sLq8oJESThVJIQ4pPKgK1l/sEcy4jenwFRiIR3+n4I1tcIZHvzMMkAIXdGrrs5
	OgsC8+T2Y9DhHaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB9F513680;
	Fri, 18 Oct 2024 21:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XBPrMKnZEmc3KQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 18 Oct 2024 21:56:57 +0000
Message-ID: <3d7865c0-f269-413f-bb9d-54f46acbe489@suse.cz>
Date: Fri, 18 Oct 2024 23:59:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11.y v2 0/3] Yu Zhao's memory fix backport
To: chrisl@kernel.org, stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Muchun Song
 <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 kernel test robot <oliver.sang@intel.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EBEAD21E63
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/18/24 7:27 PM, chrisl@kernel.org wrote:
> A few commits from Yu Zhao have been merged into 6.12.
> They need to be backported to 6.11.

But aside from adding the s-o-b, you still didn't say why?

> - c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")

Especially for this one.

> - 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
> - e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")

And those are marked already, but actually Kent wanted to hold off in
response to your v1, due to suspecting them to cause problems?

Vlastimil

> ---
> Changes in v2:
> - Add signed off tag
> - Link to v1: https://lore.kernel.org/r/20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org
> 
> ---
> Yu Zhao (3):
>       mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO
>       mm/codetag: fix pgalloc_tag_split()
>       mm/codetag: add pgalloc_tag_copy()
> 
>  include/linux/alloc_tag.h   | 24 ++++++++-----------
>  include/linux/mm.h          | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pgalloc_tag.h | 31 ------------------------
>  mm/huge_memory.c            |  2 +-
>  mm/hugetlb_vmemmap.c        | 40 +++++++++++++++----------------
>  mm/migrate.c                |  1 +
>  mm/page_alloc.c             |  4 ++--
>  7 files changed, 91 insertions(+), 68 deletions(-)
> ---
> base-commit: 8e24a758d14c0b1cd42ab0aea980a1030eea811f
> change-id: 20241016-stable-yuzhao-7779910482e8
> 
> Best regards,

