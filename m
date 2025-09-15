Return-Path: <stable+bounces-179635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E1B5801D
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC515172050
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBA31AF1B;
	Mon, 15 Sep 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nYA3LiYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1oZBBOA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nYA3LiYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1oZBBOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D701DE4E5
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949032; cv=none; b=G7TKJGFMGjA1fXFhXht2FKDOjafRFp2K6xPm0rzxuVp5B4XgrH08lMxrvndD1YpPGzeWB3yXL+djCOuMHavQeDr7NrtPv4yxLt9MuN1RqwaGzkHSAoqbEKfmeFVt4usHJqGo7QmqGdstO7gmTj6kc18dhjrr/HQh1RL2uVnA1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949032; c=relaxed/simple;
	bh=oWBK+VvTnjAzoEz2esiyZa/nhCiTJ0VCD86HnUrvP0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC6B1XmPw+kqt03rrMfz2tbTjiCXgZMk/BvC3nz9fsbHm1Jq25uikjJJNH/666Di9dctBPPXMBK5KU/4OxexOu1JHsO0FZMOr2uIoOchdgfnFTh9F9yii9/phoYngfmPt5eruXivBHFT+ZuvEfYg5cFD6hYh9fuGz+C5lLeNSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nYA3LiYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1oZBBOA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nYA3LiYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1oZBBOA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FC89229EB;
	Mon, 15 Sep 2025 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWZZ7k9OLvf13b/4yQCrEs6fKtuikXzi2KfbPh50fyY=;
	b=nYA3LiYdFNDhh+hsdK9+Qw2mtLfc/V17PWr/ki0zTUw7JQmA5+zNbUthbmTyJew55VM+Mo
	ZvqzqwEUlndLPs+V1k37SCpCvhC9xe6rHxNI5iO0f10VMxwwo4kTIFItTm2fIPh1F/82bb
	apGlsgYb61p6hKl7u9qRqdYmg3o5ahc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWZZ7k9OLvf13b/4yQCrEs6fKtuikXzi2KfbPh50fyY=;
	b=b1oZBBOAQvzsnIheW6jCBxNwu1Q8Y65Dgifwgqy/3eJiSSzxJcMIBBGejyi0ECj5lZtvbX
	7EcO8FVPGC9Qu6Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nYA3LiYd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b1oZBBOA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWZZ7k9OLvf13b/4yQCrEs6fKtuikXzi2KfbPh50fyY=;
	b=nYA3LiYdFNDhh+hsdK9+Qw2mtLfc/V17PWr/ki0zTUw7JQmA5+zNbUthbmTyJew55VM+Mo
	ZvqzqwEUlndLPs+V1k37SCpCvhC9xe6rHxNI5iO0f10VMxwwo4kTIFItTm2fIPh1F/82bb
	apGlsgYb61p6hKl7u9qRqdYmg3o5ahc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWZZ7k9OLvf13b/4yQCrEs6fKtuikXzi2KfbPh50fyY=;
	b=b1oZBBOAQvzsnIheW6jCBxNwu1Q8Y65Dgifwgqy/3eJiSSzxJcMIBBGejyi0ECj5lZtvbX
	7EcO8FVPGC9Qu6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F5FC1368D;
	Mon, 15 Sep 2025 15:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lvRvD2QsyGgQcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 15:10:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE431A0A06; Mon, 15 Sep 2025 17:10:19 +0200 (CEST)
Date: Mon, 15 Sep 2025 17:10:19 +0200
From: Jan Kara <jack@suse.cz>
To: skulkarni@mvista.com
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, gianf.trad@gmail.com, 
	jack@suse.cz, stable@vger.kernel.org, shubham.k-mv@celestialsys.com
Subject: Re: Patch "udf: fix uninit-value use in udf_get_fileshortad" missing
 from stable kernel v5.10
Message-ID: <fm4atw4vou7cot6yq3kk322dpepmg5hc4mnjwloibbms2hhipq@s6gnlvld4se7>
References: <20250915143459.450899-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915143459.450899-1-skulkarni@mvista.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,suse.cz,vger.kernel.org,celestialsys.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4FC89229EB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Mon 15-09-25 20:04:59, skulkarni@mvista.com wrote:
> Hi Greg/Sasha/All,
> 
> Patch "udf: fix uninit-value use in udf_get_fileshortad" which is commit 264db9d666ad in the mainline kernel, fixes CVE-2024-50143.
> The patch from mainline was first backported to stable versions 5.15.170, 6.1.115, 6.6.59, 6.11.6. Ref: https://lore.kernel.org/all/2024110743-CVE-2024-50143-4678@gregkh/
> 
> But later on, this patch was backported into v5.4 with https://github.com/gregkh/linux/commit/417bd613bdbe & into v4.19 with https://github.com/gregkh/linux/commit/5eb76fb98b33. 
> But in v5.10, it was missed. When I looked at LKML to find if there were any reported issues which led to dropping this patch in v5.10, I couldn't find any.
> I guess this might have been missed accidentally. 
> 
> Assuming the backport process would be the same as in other cases, I tried to get the backported patch locally from v5.15. The patch gets applied cleanly, but unfortunately, it generates build warnings.
> 
> "
> fs/udf/inode.c: In function ‘udf_current_aext’:
> 
> ./include/linux/overflow.h:70:15: warning: comparison of distinct pointer types lacks a cast
>    70 |  (void) (&__a == &__b);   \
>       |               ^~
> fs/udf/inode.c:2199:7: note: in expansion of macro ‘check_add_overflow’
>  2199 |   if (check_add_overflow(sizeof(struct allocExtDesc),
>       |       ^~~~~~~~~~~~~~~~~~
> ./include/linux/overflow.h:71:15: warning: comparison of distinct pointer types lacks a cast
>    71 |  (void) (&__a == __d);   \
>       |               ^~
> fs/udf/inode.c:2199:7: note: in expansion of macro ‘check_add_overflow’
>  2199 |   if (check_add_overflow(sizeof(struct allocExtDesc),
> "
> 
> I had a look at the nearest stable versions v5.4 & v5.15 to check for any
> dependent patches, but I couldn't find a cleanly applicable dependent
> patch.  I will give it a try to backport this missed patch to v5.10 in
> the background.

I think it was d219d2a9a92e ("overflow: Allow mixed type arguments") that
fixed this. So you either need push that to 5.10 as well or you need to
manually typecast arguments of check_add_overflow() in the backport of the
udf fix...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

