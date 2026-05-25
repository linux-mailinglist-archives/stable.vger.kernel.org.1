Return-Path: <stable+bounces-254151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO6rGfRZFGofMwcAu9opvQ
	(envelope-from <stable+bounces-254151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:17:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDF05CBA6D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9793020ABE
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4703845B3;
	Mon, 25 May 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EV+ZZbGV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeUqYKnM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EV+ZZbGV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeUqYKnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E73ACF15
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718439; cv=none; b=Z/I/Xt5gQOq0e5MVltl147PzzEM9apEaCeIR0zK9qD1uhdf+Yu1jH3YMHWhMggFfFRwguVIEAcXOQVCXVTnoZAXw5nD6LR5QqyCTok7NnfqFoJhQyMoFmURuFj/Y/xwnQ5ns/AZipzkQOj6Eoz2OYP4If18sUpUh6jJvbmeTeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718439; c=relaxed/simple;
	bh=nEDN+h1q+9ME/8hpITOtc/SWqb9o8rrHFPNvNSA2bQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy9yn0sTadmH0cJzBGm171UdMFfMyRa2+4vG9V8OUTswBgvCB4Z2GsZi+GBonw5qXpsetWrqgyb0+e1nTYgRnJTj4XGIBshm7Cy2/ZEzpglySbYUEnYUrpLiHZCdvalFCvgIbq8xD6Q4AIeXZ+b9dT46dI3Oe5maxqSrKMpfi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EV+ZZbGV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeUqYKnM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EV+ZZbGV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeUqYKnM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04B266B540;
	Mon, 25 May 2026 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779718433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJQPmGYyB+LWg9Nwgs5ux2tu3Pknk+3tkz/M55a7Gb8=;
	b=EV+ZZbGVwhrIJWQDSxdEYrlcuD0gShExBsg4bemtYr1vYIpRxb4bKY3lkAqxUxXrsW63EL
	N+DFYadFZQkqWNS+RasnKfkiSEVB6pHl/z3fa0YrtnXv/UDmk7DnyX/cldaOkbWt38pjzk
	j72EfEzGQcw2PZuM+vGgEvScnuY9NYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779718433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJQPmGYyB+LWg9Nwgs5ux2tu3Pknk+3tkz/M55a7Gb8=;
	b=eeUqYKnMsLkfAreYeJm0Pslc6QlmbljAb2rpviDB375cUicpaBmo2NealY54q3QS9DVrUD
	x4Ff8RscP59g9XAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EV+ZZbGV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eeUqYKnM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779718433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJQPmGYyB+LWg9Nwgs5ux2tu3Pknk+3tkz/M55a7Gb8=;
	b=EV+ZZbGVwhrIJWQDSxdEYrlcuD0gShExBsg4bemtYr1vYIpRxb4bKY3lkAqxUxXrsW63EL
	N+DFYadFZQkqWNS+RasnKfkiSEVB6pHl/z3fa0YrtnXv/UDmk7DnyX/cldaOkbWt38pjzk
	j72EfEzGQcw2PZuM+vGgEvScnuY9NYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779718433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJQPmGYyB+LWg9Nwgs5ux2tu3Pknk+3tkz/M55a7Gb8=;
	b=eeUqYKnMsLkfAreYeJm0Pslc6QlmbljAb2rpviDB375cUicpaBmo2NealY54q3QS9DVrUD
	x4Ff8RscP59g9XAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DACD759CAA;
	Mon, 25 May 2026 14:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2vDNCBZFGoOJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 May 2026 14:13:52 +0000
Date: Mon, 25 May 2026 16:13:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Werner Kasselman <werner@verivus.ai>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wqu@suse.com" <wqu@suse.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix subpage state mismatch in cow_fixup writeback
 path
Message-ID: <20260525141351.GE12792@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260316105654.710798-1-werner@verivus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316105654.710798-1-werner@verivus.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-254151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,verivus.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AEDF05CBA6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:56:56AM +0000, Werner Kasselman wrote:
> writepage_delalloc() marks all dirty sectors as locked via
> btrfs_folio_set_lock(), setting bits in the subpage locked bitmap and
> incrementing nr_locked.  These are cleaned up by
> btrfs_folio_end_lock_bitmap() at the end of extent_writepage().
> 
> However, when btrfs_writepage_cow_fixup() returns -EAGAIN inside
> extent_writepage_io(), the code calls folio_unlock() directly and
> returns 1, causing extent_writepage() to skip the bitmap cleanup:
> 
>     ret = btrfs_writepage_cow_fixup(folio);
>     if (ret == -EAGAIN) {
>         folio_redirty_for_writepage(bio_ctrl->wbc, folio);
>         folio_unlock(folio);     // doesn't clear locked bitmap
>         return 1;                // caller skips end_lock_bitmap()
>     }
> 
> This leaves the subpage locked bitmap out of sync with the folio lock
> state: the folio is unlocked but its subpage locked bitmap still has
> bits set and nr_locked is elevated.  When writeback retries the folio,
> btrfs_folio_set_lock() hits the ASSERT at subpage.c:746 because the
> bits are still set from the previous attempt.
> 
> The cow_fixup path is largely a legacy path -- the GUP dirty-without-
> informing-fs issue that triggered it has been fixed on the GUP side,
> and experimental builds already catch this case with -EUCLEAN before
> reaching the -EAGAIN return.  However the subpage state mismatch is
> still a correctness issue for non-experimental builds under error
> injection or memory pressure (kzalloc failure in
> btrfs_writepage_cow_fixup()).
> 
> Fix this by replacing folio_unlock() with btrfs_folio_end_lock_bitmap(),
> which properly clears the locked bitmap bits before unlocking.  For
> non-subpage or when nr_locked is 0 (e.g. called from
> extent_write_locked_range()), btrfs_folio_end_lock_bitmap() falls
> through to plain folio_unlock(), so existing behavior is preserved.
> 
> Fixes: d034cdb4cc8a ("btrfs: lock subpage ranges in one go for writepage_delalloc()")
> CC: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>

I'm going through patch backlog, this patch has some relevance. We're
going to remove the fixup worker code in 7.2 completely so it cannot be
applied to the development branch anymore.

The problems are hard to hit or need error injection, I don't know if
it's worth to backport to stable. We've provided a long grace period to
the fixup worker before removal and I'm glad we can delete it and forget
about it. If somebody wants one last fix then I'm OK with that.

