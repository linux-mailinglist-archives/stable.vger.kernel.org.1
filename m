Return-Path: <stable+bounces-262009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3AjDDqbJmqSZgIAu9opvQ
	(envelope-from <stable+bounces-262009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 12:36:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EA6552D4
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 12:36:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oLRNX+Gh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ocbJ2jvv;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r3KqMEol;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7uPSINyj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262009-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262009-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23FDC301EE06
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8602E7F0A;
	Mon,  8 Jun 2026 10:22:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53634D3B9
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:22:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914133; cv=none; b=VVmJI5QuzBYVGsnYLXM6kSJl584m5LYPpHK6Q8WDKmePCOTY0Ix+yA9MMfTiGGS15Y079hfWsiIQf33vwZdk1FZnZ0m1pMzMKre2JrUJoD6wNpQUEq1Kzktw41G6/pb+jALjLMLGPB0DDpjXNgFhv/1wxfVSv95e0nP0CPGF/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914133; c=relaxed/simple;
	bh=W6OSEUBRa4vBKaxrxsf5ZA9G54yux7IGEJULOD2G/LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGsod7F9vBLfR3Ruq24/jyeRePAMmej9uBds+/4Dt7Gibxs2d02tKlJrwOhCiGu795zh+FpT+XQjTDeBLx5FKVygwaguKgF4/LhvQbDAoyiWTeuoRxaBQ5B8fTIJ95c4+D2yv2VsWMpSUFNahURgVwwvO7d+cfvqXfpVl/vOZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oLRNX+Gh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ocbJ2jvv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3KqMEol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7uPSINyj; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A75A967645;
	Mon,  8 Jun 2026 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780914130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=oLRNX+GhiibyIthOpZtMczxn6oMFgJVsuw1aJzxVyyLuggOh5u4hDVs4IXac40mdp/+Dkb
	Mm5lCEi25pnpeI+SLwPmMoMIeg+XjSqOrrVXcH4wPgG7WjpSbELH1aCmeac1R7Nzaq+B43
	itkX7yKaEEJb0rFfQZ0QhCE9yQmW6Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780914130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=ocbJ2jvvbMmWg5r4rw8VmtKWB9xoE+Rb9pnlZCeoInX8phABYkhue+8vN2gEYQixWYgk6N
	tUEsTvb/LNWjZ2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780914128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=r3KqMEol5Xo6CPbuZ4EGVbA5rkXX8DPdVFgEyshvQ/z3m/MA7VUv7PB/CooolFE6kGKgyV
	W46UarxzksmPbte0udOVFyiY8BHqqXM4nG+W4B2KkSuijIH06fN2QWU7r8jorS8qkv5EVB
	rm+nrKccyAKmgFJAufRJZ1znoJj7umw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780914128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=7uPSINyj5sF1yyEZSPb0vtKpnWkfra2CW+SMyoKz1SrNjH5+U+EyggwlL+qz11+7WQp50y
	PJ7qqFuTQJHrh6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E95F779A7;
	Mon,  8 Jun 2026 10:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /K61JtCXJmpwPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 10:22:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 449E0A10CB; Mon, 08 Jun 2026 12:22:08 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:22:08 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <vcdwfq5pysuuvj3lnlmsndvwnt643liz22w33ayv2cf2jawetm@7re2y25e6lv7>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
 <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
 <20260602140751.GS2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140751.GS2636677@ZenIV>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262009-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,m:arefev@swemel.ru,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:from_mime,suse.cz:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,7re2y25e6lv7:mid,linux.org.uk:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 781EA6552D4

On Tue 02-06-26 15:07:51, Al Viro wrote:
> On Tue, Jun 02, 2026 at 11:11:11AM +0200, Jan Kara wrote:
> > On Tue 02-06-26 03:04:44, Al Viro wrote:
> > > one should *not* be allowed to mount one of those, new API or not.
> > > 
> > > Reported-by: Denis Arefev <arefev@swemel.ru>
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Won't it make sense to actually check fc->sb_flags before we call
> > vfs_create_mount()? Otherwise it looks good to me.
> 
> Interpretation of fc->sb_flags is up to your ->get_tree().  What matters
> is ->s_flags in the resulting superblock; that's type-independent and
> that's what we ought to check...

Ah, right. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

