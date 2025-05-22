Return-Path: <stable+bounces-146069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC96FAC098C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC1D3BCDBA
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF4288C03;
	Thu, 22 May 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="svP685j2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8l/rmVdx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQk9PPjZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13aXx17F"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FB2882BF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908842; cv=none; b=Wuwi1aU4LAM4rX86nbFsQFcW13m4Iw53nK5xnmghNmRCfZXtCa2l+437NPacHNo45F1nzSP52x9wAdDE9WO41vTpSCRsjwAFLpfHvf7OSO1oSrSASwDMMWBPPJ5kG2JTQX6664FUCAUKqo2zZwWVcFSdHEY3KC84tg5aPsbTGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908842; c=relaxed/simple;
	bh=mU+1lrLV/UCuvsDQ9kNhrLKhkDT2B/4yK5q5d22eY44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRjsPHc8KI92SnOErbmzOQMuAS14IP5ueLYemnxe+DtqWwysDu9rSx+RVI4F0SLlO64UL08x99wmAjlpNX72OK/8ozxY8toozVj/4I9rsl4/WIc+DunvAs96El+9o0g1da4eYr276n3FdkLr5y7pcDtCsLkO+WMhrjvhjduGJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=svP685j2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8l/rmVdx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQk9PPjZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=13aXx17F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4C64219AF;
	Thu, 22 May 2025 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747908839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTj530S0+pt4TB23fjg5olxByY/4NarPybW7KGHkyhc=;
	b=svP685j2KPgsEpvtXT51KJY5WgnxyyO+0y1IG00r8tOBeCBFrcTJdWQJx9PeMBaYFl31ic
	JWLFLU+Hrlau5TgTIWfO7ymgliTXfxy6eB0VZ0UtjwEAI90zICTxxkWrvBt3MLMho9Qe1h
	cwTL9TiFTEPoQ9ARW91GP6+TdEGCXJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747908839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTj530S0+pt4TB23fjg5olxByY/4NarPybW7KGHkyhc=;
	b=8l/rmVdxqLqueF90g4p+EwikrOPcb1Y/TGbkPU80Tlvfgzo4NCjkURkda/+8hLceyXhMXw
	ArfTvlGtz8e+4zDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CQk9PPjZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=13aXx17F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747908838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTj530S0+pt4TB23fjg5olxByY/4NarPybW7KGHkyhc=;
	b=CQk9PPjZlFADxCr7gK9SEIWJiU+uc1WV6fdhK3OD3y/ufSpu1cAEcbe71na17dMBBZZ2q2
	UUBF0DBNvVXfxMcEzS1ISCbGnfGQvKv/o6lmVlcfklx08GKmM8gcNIc/ztPKMIqbzmrcE5
	MGeuNfW6YemilOI2ZceRmyB2Fxn4MoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747908838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTj530S0+pt4TB23fjg5olxByY/4NarPybW7KGHkyhc=;
	b=13aXx17FFBz1wfQvf8jdKLSxkc/F4/CE32sBzuuseWCidgW3Y0yEwwOQrquIczXobEx7Br
	hZHWF93PHkHdmHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F50137B8;
	Thu, 22 May 2025 10:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gxzxJ+b4LmhAPwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 22 May 2025 10:13:58 +0000
Date: Thu, 22 May 2025 12:13:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <muchun.song@linux.dev>
Cc: yangge1116@126.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
Message-ID: <aC745T00Ft3g7e7G@localhost.localdomain>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <065093C4-3599-456F-84B7-EDCC1A3E8AFC@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065093C4-3599-456F-84B7-EDCC1A3E8AFC@linux.dev>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: E4C64219AF
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[126.com,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,redhat.com,linux.alibaba.com,hygon.cn];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On Thu, May 22, 2025 at 03:13:31PM +0800, Muchun Song wrote:
> 
> 
> > On May 22, 2025, at 13:34, Oscar Salvador <osalvador@suse.de> wrote:
> > 
> > On Thu, May 22, 2025 at 11:47:05AM +0800, Muchun Song wrote:
> >> Thanks for fixing this problem. BTW, in order to catch future similar problem,
> >> it is better to add WARN_ON into folio_hstate() to assert if hugetlb_lock
> >> is not held when folio's reference count is zero. For this fix, LGTM.
> > 
> > Why cannot we put all the burden in alloc_and_dissolve_hugetlb_folio(),
> > which will again check things under the lock?
> 
> I've also considered about this choice, because there is another similar
> case in isolate_or_dissolve_huge_page() which could benefit from this
> change. I am fine with both approaches. Anyway, adding an assertion into
> folio_hstate() is an improvement for capturing invalid users in the future.
> Because any user of folio_hstate() should hold a reference to folio or
> hold the hugetlb_lock to make sure it returns a valid hstate for a hugetlb
> folio.

Yes, I am not arguing about that, it makes perfect sense to me, but I am
just kinda against these micro-optimizations for taking the lock to check
things when we are calling in a function that will again the lock to
check things.

Actually, I think that the folio_test_hugetlb() check in
replace_free_hugepage_folios() was put there to try tro be smart and save cycles in
case we were not dealing with a hugetlb page (so freed under us).
Now that we learnt that we cannot do that without 1) taking a refcount
2) or holding the lock, that becomes superfluos, so I would just wipe that
out.

 

-- 
Oscar Salvador
SUSE Labs

