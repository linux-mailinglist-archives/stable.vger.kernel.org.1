Return-Path: <stable+bounces-146079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E996AC0ACC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D391DA242A2
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8023E320;
	Thu, 22 May 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="irwFkRwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qIw0Zecc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="irwFkRwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qIw0Zecc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA223C8D5
	for <stable@vger.kernel.org>; Thu, 22 May 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914651; cv=none; b=B7aa3kdD5Sc4/6rkS67+xwQ+X18kKP4UDlhSlFQ0hFhWW7GRw3PGbw8KorcrFTY4cNAkRnxhQ+xzlIY3m5aiaJgL08zmSp3RoJCKDW0dCawvZ+ePTUgX0k2qcp2uh/7u9pKMJ1MqhzFzT1QVrmFIQhBH0D+ciK3p9NQEMoO4Nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914651; c=relaxed/simple;
	bh=FBTTavlraf/ZwANWkyI3BTSLcPAEcO0frlp/GeE2pVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYhu3L9LFKVjGhOyg1nCvzc3IuG8yFReJqr1ZhW8JORuTCG8lW0+joKjfGWJP2+jqN844Q/HLuGthyzs6Rk1XK7fgXl+4GxXtiaEBrQSvUVwCJ0TNHSXFgGxTrTdA+eZEonN9DPDhxiADSoU2JaKlLy4X2fxJZx4CXt8lwpoGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=irwFkRwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qIw0Zecc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=irwFkRwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qIw0Zecc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B41221747;
	Thu, 22 May 2025 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747914648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqfFb7aK5wWv+PjAW7cUNT1XItHnqm9XAvP8CT8uiFI=;
	b=irwFkRwR78YdAdBzJhnPdhCYe4TwWr4Zd6Q39WUs0NGaRcgybXIGFSlQtjIE9xzvGvsKeN
	bOdxhYYj9kqnrzkRF910A60PkCgsgX/d3iMx9BPxjrgRZ5bHNhvX9eWw0EzEPyBK7BlWVj
	VmwA3ipshvx/3UIXy1S4YG4hcS9TpOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747914648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqfFb7aK5wWv+PjAW7cUNT1XItHnqm9XAvP8CT8uiFI=;
	b=qIw0ZeccYt35p1CAYOgTazsYXc7LIbDJLJqYHRfL0f/CiyGjYfLRZvpnhE3nA9rWAHS/6E
	p5jcztEBttJ6x3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=irwFkRwR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qIw0Zecc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747914648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqfFb7aK5wWv+PjAW7cUNT1XItHnqm9XAvP8CT8uiFI=;
	b=irwFkRwR78YdAdBzJhnPdhCYe4TwWr4Zd6Q39WUs0NGaRcgybXIGFSlQtjIE9xzvGvsKeN
	bOdxhYYj9kqnrzkRF910A60PkCgsgX/d3iMx9BPxjrgRZ5bHNhvX9eWw0EzEPyBK7BlWVj
	VmwA3ipshvx/3UIXy1S4YG4hcS9TpOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747914648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqfFb7aK5wWv+PjAW7cUNT1XItHnqm9XAvP8CT8uiFI=;
	b=qIw0ZeccYt35p1CAYOgTazsYXc7LIbDJLJqYHRfL0f/CiyGjYfLRZvpnhE3nA9rWAHS/6E
	p5jcztEBttJ6x3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21507137B8;
	Thu, 22 May 2025 11:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p+hqB5gPL2izYwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 22 May 2025 11:50:48 +0000
Date: Thu, 22 May 2025 13:50:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
Message-ID: <aC8Pls7jidHCOMJq@localhost.localdomain>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747884137-26685-1-git-send-email-yangge1116@126.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com];
	FREEMAIL_TO(0.00)[126.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,redhat.com,linux.alibaba.com,linux.dev,hygon.cn];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 4B41221747
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, May 22, 2025 at 11:22:17AM +0800, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> A kernel crash was observed when replacing free hugetlb folios:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000028
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 28 UID: 0 PID: 29639 Comm: test_cma.sh Tainted 6.15.0-rc6-zp #41 PREEMPT(voluntary)
> RIP: 0010:alloc_and_dissolve_hugetlb_folio+0x1d/0x1f0
> RSP: 0018:ffffc9000b30fa90 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000342cca RCX: ffffea0043000000
> RDX: ffffc9000b30fb08 RSI: ffffea0043000000 RDI: 0000000000000000
> RBP: ffffc9000b30fb20 R08: 0000000000001000 R09: 0000000000000000
> R10: ffff88886f92eb00 R11: 0000000000000000 R12: ffffea0043000000
> R13: 0000000000000000 R14: 00000000010c0200 R15: 0000000000000004
> FS:  00007fcda5f14740(0000) GS:ffff8888ec1d8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000391402000 CR4: 0000000000350ef0
> Call Trace:
> <TASK>
>  replace_free_hugepage_folios+0xb6/0x100
>  alloc_contig_range_noprof+0x18a/0x590
>  ? srso_return_thunk+0x5/0x5f
>  ? down_read+0x12/0xa0
>  ? srso_return_thunk+0x5/0x5f
>  cma_range_alloc.constprop.0+0x131/0x290
>  __cma_alloc+0xcf/0x2c0
>  cma_alloc_write+0x43/0xb0
>  simple_attr_write_xsigned.constprop.0.isra.0+0xb2/0x110
>  debugfs_attr_write+0x46/0x70
>  full_proxy_write+0x62/0xa0
>  vfs_write+0xf8/0x420
>  ? srso_return_thunk+0x5/0x5f
>  ? filp_flush+0x86/0xa0
>  ? srso_return_thunk+0x5/0x5f
>  ? filp_close+0x1f/0x30
>  ? srso_return_thunk+0x5/0x5f
>  ? do_dup2+0xaf/0x160
>  ? srso_return_thunk+0x5/0x5f
>  ksys_write+0x65/0xe0
>  do_syscall_64+0x64/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> There is a potential race between __update_and_free_hugetlb_folio()
> and replace_free_hugepage_folios():
> 
> CPU1                              CPU2
> __update_and_free_hugetlb_folio   replace_free_hugepage_folios
>                                     folio_test_hugetlb(folio)
>                                     -- It's still hugetlb folio.
> 
>   __folio_clear_hugetlb(folio)
>   hugetlb_free_folio(folio)
>                                     h = folio_hstate(folio)
>                                     -- Here, h is NULL pointer
> 
> When the above race condition occurs, folio_hstate(folio) returns
> NULL, and subsequent access to this NULL pointer will cause the
> system to crash. To resolve this issue, execute folio_hstate(folio)
> under the protection of the hugetlb_lock lock, ensuring that
> folio_hstate(folio) does not return NULL.
> 
> Fixes: 04f13d241b8b ("mm: replace free hugepage folios after migration")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

