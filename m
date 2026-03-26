Return-Path: <stable+bounces-230503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMORBjppxWl1+AQAu9opvQ
	(envelope-from <stable+bounces-230503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:13:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA9338F78
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2D93023DE6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB86421F0B;
	Thu, 26 Mar 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zg37qVxv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9pi4ixHJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zg37qVxv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9pi4ixHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DF421F03
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544870; cv=none; b=OkyP/7SudR/U4zgbWNOYFWPyNLND4FrDwngr02VaHt4AMqEWLAG2dVBHz6N28b6SPlC4dM3i2LyC3DprK9uPltF0ocOklWV8qnY8a5KfdlgS4uc2A3x2BRLghZQ4HeIMXtC1Y2+aIUmOZFqmMCIUWALWAfiUqLa3vWU8xK1y1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544870; c=relaxed/simple;
	bh=YlivCdc0AZZa/6TKYWEjbDb8Xsrmg/hFfVBnCeM2UKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgVDWZviTW/9a2Q7KRElUqrdJq+b3Y8HmX/mwlrDeBk8yCcpyVdvnRUT24IN9j6ZHSOBf6z4D69JBAZj/lprTkE+sCdFpuG5JY1NTQz94+P+pNxIamcvddwr/4HgxgYNOSWVLi2icdavt86KIHwdXQeWdT/GCIty7bzymiime7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zg37qVxv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9pi4ixHJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zg37qVxv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9pi4ixHJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E9385BD48;
	Thu, 26 Mar 2026 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774544865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7lANbKM3g4gWkcXuxWHlfM6yAtC+tfeO+S+WqbphMc=;
	b=zg37qVxvVtf/OJ7JX8OIaigjrNXHi29BPRjAYFARthZXUp5ZdSah9AdpSgQo6pkzCkj4cv
	Ref2actOg80mQ/pvLdXoFvod6xY/vBnT/HAXMsFzke32EoR8Xt8QC6GtMYFyPYAgpxqyMb
	ssbrNyOiVUH0UCWDEhHkjcv/83448Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774544865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7lANbKM3g4gWkcXuxWHlfM6yAtC+tfeO+S+WqbphMc=;
	b=9pi4ixHJIQLgyKwS3Ij0qKf3OuoYB2rPNP7dYX8e049lBw8FGUPdoWR1u73MnA+0y0HXsM
	04is+Nj+IZmiJeBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774544865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7lANbKM3g4gWkcXuxWHlfM6yAtC+tfeO+S+WqbphMc=;
	b=zg37qVxvVtf/OJ7JX8OIaigjrNXHi29BPRjAYFARthZXUp5ZdSah9AdpSgQo6pkzCkj4cv
	Ref2actOg80mQ/pvLdXoFvod6xY/vBnT/HAXMsFzke32EoR8Xt8QC6GtMYFyPYAgpxqyMb
	ssbrNyOiVUH0UCWDEhHkjcv/83448Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774544865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7lANbKM3g4gWkcXuxWHlfM6yAtC+tfeO+S+WqbphMc=;
	b=9pi4ixHJIQLgyKwS3Ij0qKf3OuoYB2rPNP7dYX8e049lBw8FGUPdoWR1u73MnA+0y0HXsM
	04is+Nj+IZmiJeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C4BF4A0A3;
	Thu, 26 Mar 2026 17:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkxAD+BnxWkFUgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 26 Mar 2026 17:07:44 +0000
Date: Thu, 26 Mar 2026 17:07:42 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com, 
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
References: <20260326162611.693539-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326162611.693539-1-gourry@gourry.net>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230503-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: 89EA9338F78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 11:26:11AM -0500, Gregory Price wrote:
> Inflating a VM's balloon while vhost-user-net fork+exec's a helper
> triggers "still mapped when deleted" on the memfd backing guest RAM:
> 
>   BUG: Bad page cache in process __balloon  pfn:6520704
>   page dumped because: still mapped when deleted
>   ...
>   shmem_undo_range+0x3fa/0x570
>   shmem_fallocate+0x366/0x4d0
>   vfs_fallocate+0x13c/0x310
> 
> This BUG also resulted in guests seeing stale mappings backed by a
> zeroed page, causing guest kernel panics.  I was unable to trace that
> specific interaction, but it appears to be related to THP splitting.
> 
> Two races allow PTEs to be re-installed for a folio that fallocate
> is about to remove from page cache:

Hmm, I don't see how your patch fixes anything.

> 
> Race 1 — fault-around (filemap_map_pages):
> 
>   fallocate              fault-around           fork
>   --------               ------------           ----
>   set i_private
>   unmap_mapping_range()
>   # zaps PTEs
>                        filemap_map_pages()
>                         # re-maps folio!
>                                               dup_mmap()
>                                               # child VMA
>                                               # in tree
>   shmem_undo_range()
>     lock folio
>     unmap_mapping_folio()
	spin_lock(ptl);
>     # child VMA:
>     #   no PTE, skip
	spin_unlock(ptl);
>                                             copy_page_range()
                                               spin_lock(dst_ptl);
					       spin_lock(src_ptl);
						/* does not copy PTE. either
						 * we find a zapped PTE, or unmap_mapping_folio()
						 * finds two mappings instead of one. */
>						# copies PTE
>     # parent VMA:
>     #   zaps PTE
>   filemap_remove_folio()
>     # mapcount=1, BUG!
> 
> filemap_map_pages() is called directly as .map_pages, bypassing
> shmem_fault()'s i_private synchronization.
> 
> Race 2 — shmem_fault TOCTOU:
> 
>   fallocate                   shmem_fault
>   --------                    -----------
>                             check i_private → NULL
>   set i_private
>   unmap_mapping_range()
>   # zaps PTEs
>                             shmem_get_folio_gfp()
>                               # finds folio in cache
>                             finish_fault()
>                               # installs PTE
>   shmem_undo_range()
>     truncate_inode_folio()
	truncate_inode_folio() zaps the PTEs, thus mapcount = 0.
	shmem folio is locked by both truncate and shmem_fault().
>       # mapcount=1, BUG!
> 
> Fix both races with invalidate_lock.
> 

I don't see what you're seeing? Note that both map_pages and fault()
take the folio lock (map_pages does a trylock) to exclude against truncate
as well.

-- 
Pedro

