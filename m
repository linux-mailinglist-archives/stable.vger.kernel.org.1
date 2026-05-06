Return-Path: <stable+bounces-244313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNWFMwzB+mnRSQMAu9opvQ
	(envelope-from <stable+bounces-244313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 06:18:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA94D613A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1332301FA46
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 04:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AA2EF652;
	Wed,  6 May 2026 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5zREULc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dziTInwQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5zREULc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dziTInwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C51DF27D
	for <stable@vger.kernel.org>; Wed,  6 May 2026 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041086; cv=none; b=IDLaay7tAn72WRAjEquHUN0q46+AupTDdKcCA7HWJzlGoZejg6DDNs2PwCgrlfIywtxz0NbR1m1AtC7rnEvjYG4X9ZXvkKntFMHu1JWlSKiE/O3NZDio/1j67sjcVhqNpP/clbvqVMcJS1RWbZ4+fGdtb49boOoeyti+WKII6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041086; c=relaxed/simple;
	bh=xZWNLSbsiszE8qsPV1Ann9i/KcrSg5dw4haByHVwYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIBXwFWyl6VwBEWuQ62c6q9OWolQjM5iFWhGrjRfr5ZGkcgXIrRTVO0n9bCAKx+pZtLlOGfIpNIYCfwPizjlSZZj/rhHqtwUVZjwGIccVCzcTQQIsg4m3KO8oz5mfq5f5o72R4p80+KnWRNTZnUAc1zooo1x8RCdEhGolYICzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5zREULc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dziTInwQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5zREULc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dziTInwQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8BDF6B1EA;
	Wed,  6 May 2026 04:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778041081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0r7EBPI79XYcDKO6GsjOBlljdqO0v/WGk5GC7DrDj+4=;
	b=r5zREULcHeUkuvLmZwlYTX2pl1khxfHadGYOEtAC/sacAdf4XrXSK1SsReJW6u6lxLwAQH
	+hUB5PmBHcmfvIcSimlqYuq8aQIH/UcxEs0BydgscXIDtOyuNC7GlPZNnc1K+QzkbqfANS
	wLSRHXq+U6kFs70EvSfVhC1JsblOSeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778041081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0r7EBPI79XYcDKO6GsjOBlljdqO0v/WGk5GC7DrDj+4=;
	b=dziTInwQTMUOcFYHcG1Ue3pXY246daDGNOvW/ZFizFGLKvFU+gVEro7XvG1+3c904oN8Du
	n7SYnvZTCtJVB6AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778041081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0r7EBPI79XYcDKO6GsjOBlljdqO0v/WGk5GC7DrDj+4=;
	b=r5zREULcHeUkuvLmZwlYTX2pl1khxfHadGYOEtAC/sacAdf4XrXSK1SsReJW6u6lxLwAQH
	+hUB5PmBHcmfvIcSimlqYuq8aQIH/UcxEs0BydgscXIDtOyuNC7GlPZNnc1K+QzkbqfANS
	wLSRHXq+U6kFs70EvSfVhC1JsblOSeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778041081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0r7EBPI79XYcDKO6GsjOBlljdqO0v/WGk5GC7DrDj+4=;
	b=dziTInwQTMUOcFYHcG1Ue3pXY246daDGNOvW/ZFizFGLKvFU+gVEro7XvG1+3c904oN8Du
	n7SYnvZTCtJVB6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDC48593A3;
	Wed,  6 May 2026 04:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Z09N/jA+mmlIgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 06 May 2026 04:18:00 +0000
Date: Wed, 6 May 2026 06:17:59 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix __vm_normal_page() to handle missing support for
 pmd_special()/pud_special()
Message-ID: <afrA9_KqCSo1Yb0_@localhost.localdomain>
References: <20260430-pmd_special-v1-1-dbcbcfd72c20@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-pmd_special-v1-1-dbcbcfd72c20@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 37EA94D613A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@suse.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,loongson.cn:email]

On Thu, Apr 30, 2026 at 01:31:22PM +0200, David Hildenbrand (Arm) wrote:
> On x86 32-bit with THP enabled, zap_huge_pmd() is seen to generate a
> "WARNING: mm/memory.c:735 at __vm_normal_page+0x6a/0x7d", from the
> VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn)); followed
> by "BUG: Bad rss-counter state"s, then later "BUG: Bad page state"s
> when reclaim gets to call shrink_huge_zero_folio_scan().
> 
> It's as if the _PAGE_SPECIAL bit never got set in the huge_zero pmd:
> and indeed, whereas pte_special() and pte_mkspecial() are subject to a
> dedicated CONFIG_ARCH_HAS_PTE_SPECIAL, pmd_special() and pmd_mkspecial()
> are subject to CONFIG_ARCH_SUPPORTS_PMD_PFNMAP, which is never enabled
> on any 32-bit architecture.
> 
> While the problem was exposed through commit d80a9cb1a64a ("mm/huge_memory:
> add and use normal_or_softleaf_folio_pmd()"), it was an oversight in commit
> af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
> and would result in other problems:
> * huge zero folio accounted in smaps, pagemap (PAGE_IS_FILE) and
>   numamaps as file-backed THP
> * folio_walk_start() returning the folio even without FW_ZEROPAGE set.
>   Callers seem to tolerate that, though.
> 
> ... and triggering the VM_WARN_ON_ONE(), although never reported so far.
> 
> To fix it, teach vm_normal_page_pmd()/vm_normal_page_pud() to consider
> whether pmd_special/pud_special is actually implemented.
> 
> Fixes: af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
> Reported-by: Hugh Dickins <hughd@google.com>
> Closes: https://lore.kernel.org/r/74a75b59-2e13-3985-ee99-d5521f39df2a@google.com
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Closes: https://lore.kernel.org/r/20260430041121.2839350-1-maobibo@loongson.cn
> Debugged-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Tested-by: Bibo Mao <maobibo@loongson.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

