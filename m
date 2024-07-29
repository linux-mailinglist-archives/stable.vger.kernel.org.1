Return-Path: <stable+bounces-62359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2263393ECBC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 06:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B85280EAF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825580026;
	Mon, 29 Jul 2024 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VLz7vnJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="82ZFy6vm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VLz7vnJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="82ZFy6vm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB11E49E;
	Mon, 29 Jul 2024 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228710; cv=none; b=RbmXD8FzUbh3dnOiQDjBahr++SoAlUOkQ4y5qtrVVgwQHLqOnmTLIzlRz4xuMb/g6GJ5tTPGheTpEkjL4a8ynRcSfJ2TKKUSbrD6C2ms62srUAgvC1nVfAZ+dGKRDRo8nstEkMClkhLAvcaBtikQ6jj65uWWrTNp5pfIyR/l8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228710; c=relaxed/simple;
	bh=bkVgSJTw00OpQtw2UMcRWNyJPLMipbK6Nhp9clym5C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRObYRwgRFPKb6Gb2NhWQUJLnucnj6SLRGR5EQESEgUUI0hBTSFs7h1FRHIPNTtnYYGc89oEUDy2BEHYKJYXdGpQ4MKCvmEAP0sZ1BpQO6lO+5peJRGj671rhJA/0IrenNkDCnvxBYgb5SqsbvsQ95aT09KYuskGHrz1mC/LrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VLz7vnJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=82ZFy6vm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VLz7vnJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=82ZFy6vm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B78621AFC;
	Mon, 29 Jul 2024 04:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722228706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMAZjehoO29HQoqXjdysHaghsK50aOmzflUJmNQYR/g=;
	b=VLz7vnJIKV0eiJCERYr4DeiQf3TTVYc2ot+aem/eVLPsGzlREl1wPhiqR3xsUsb768sflV
	d21vHXpLyDL3rcsF7viCCe/R41z2ayDc9OEScSezdAsG/uEKCCUCcnyAIH/Jtj5dDwTQ+C
	EPmO5KBni+PyXLToZtG2gn9JhShN2dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722228706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMAZjehoO29HQoqXjdysHaghsK50aOmzflUJmNQYR/g=;
	b=82ZFy6vmLYogQY87I9dVuW6Wip6844LrQ3Io3fy5tzgv3JbOIZzlKpsAKhSPO/zHxvTUR5
	AyW3Fc4d1V/HeaDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VLz7vnJI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=82ZFy6vm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722228706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMAZjehoO29HQoqXjdysHaghsK50aOmzflUJmNQYR/g=;
	b=VLz7vnJIKV0eiJCERYr4DeiQf3TTVYc2ot+aem/eVLPsGzlREl1wPhiqR3xsUsb768sflV
	d21vHXpLyDL3rcsF7viCCe/R41z2ayDc9OEScSezdAsG/uEKCCUCcnyAIH/Jtj5dDwTQ+C
	EPmO5KBni+PyXLToZtG2gn9JhShN2dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722228706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMAZjehoO29HQoqXjdysHaghsK50aOmzflUJmNQYR/g=;
	b=82ZFy6vmLYogQY87I9dVuW6Wip6844LrQ3Io3fy5tzgv3JbOIZzlKpsAKhSPO/zHxvTUR5
	AyW3Fc4d1V/HeaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A2A91368A;
	Mon, 29 Jul 2024 04:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JuF2E+Efp2auPQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 04:51:45 +0000
Date: Mon, 29 Jul 2024 06:51:39 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <Zqcf2-FbDv1VwGfK@localhost.localdomain>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725183955.2268884-3-david@redhat.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5B78621AFC
X-Spam-Score: -4.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, Jul 25, 2024 at 08:39:55PM +0200, David Hildenbrand wrote:
> We recently made GUP's common page table walking code to also walk
> hugetlb VMAs without most hugetlb special-casing, preparing for the
> future of having less hugetlb-specific page table walking code in the
> codebase. Turns out that we missed one page table locking detail: page
> table locking for hugetlb folios that are not mapped using a single
> PMD/PUD.
> 
> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
> page tables, will perform a pte_offset_map_lock() to grab the PTE table
> lock.
> 
> However, hugetlb that concurrently modifies these page tables would
> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
> locks would differ. Something similar can happen right now with hugetlb
> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
> 
> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
> core-mm page table walker would.
> 
> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
> folio being mapped using two PTE page tables. While hugetlb wants to take
> the PMD table lock, core-mm would grab the PTE table lock of one of both
> PTE page tables. In such corner cases, we have to make sure that both
> locks match, which is (fortunately!) currently guaranteed for 8xx as it
> does not support SMP.
> 
> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

