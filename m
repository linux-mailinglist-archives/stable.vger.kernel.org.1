Return-Path: <stable+bounces-219761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBTiDHTqn2mqewQAu9opvQ
	(envelope-from <stable+bounces-219761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:38:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B01A15DA
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF9E3009FB8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280D38A721;
	Thu, 26 Feb 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhdjL5mD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sZLCyv9r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhdjL5mD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sZLCyv9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E772BE64F
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087917; cv=none; b=kJkeUmQgOi5/AsQXCwywWa2c/EAX/WKUA1duhqVKroZEb9mQJIwvTWRxTLldGYPkLwF+Abs4gKCgWrjn6Oz8F+qHXLOJUR26ccEKxFIZUVTRKuTTrbC+en528+M6LfUMP+cUtdvJWDRJjvJ50lFxq7ICC65o9lHkEBbSIuQKEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087917; c=relaxed/simple;
	bh=UIY0kYUyOyPAz4gqVV5uoOkMGIg4Z4TOy9p1aJfnzhM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfqQ7igl0WihRpFf1Gip/qKIi2lXdfhlSmtbNiSxiPjt2qVqvlmcyv9Vfpa0n/Nmyxth3IqKwxiai7k9AMpzpInJZ1jWTCqLez84D6rARo7aTrLaGgIDSxAD9o9CdULeTPMGyjY6LhgVUW5TAhYyHNwETWu+ciR48Sp5XBXSv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhdjL5mD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sZLCyv9r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhdjL5mD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sZLCyv9r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72BE45BF0F;
	Thu, 26 Feb 2026 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772087913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBnHy6Wt6KIMmNtQkTGAQl4rker7iQYbWNqsGDyPpU=;
	b=DhdjL5mD5pZl/Eo1E+xfVy879vCFScHVAsayfvtanGJC5FRjPFZaszhqqIysGrqNFAXkc1
	+IatCbnLyRVFkZ1SPg3HG+D3CF6CSUN7esyWl4gmGrdC6GADJKS22KlIO73LZPn9VfVjDC
	YcXdKISgXTJ+VErmlRrolP6qFzI5CpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772087913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBnHy6Wt6KIMmNtQkTGAQl4rker7iQYbWNqsGDyPpU=;
	b=sZLCyv9rqzZTCma2CuI8noJhiPRpVEg7ApHg0pg2yKN0BSxcudR+YOw/st7ppaCDzd/ei3
	mGGMRwtSzV2/46CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772087913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBnHy6Wt6KIMmNtQkTGAQl4rker7iQYbWNqsGDyPpU=;
	b=DhdjL5mD5pZl/Eo1E+xfVy879vCFScHVAsayfvtanGJC5FRjPFZaszhqqIysGrqNFAXkc1
	+IatCbnLyRVFkZ1SPg3HG+D3CF6CSUN7esyWl4gmGrdC6GADJKS22KlIO73LZPn9VfVjDC
	YcXdKISgXTJ+VErmlRrolP6qFzI5CpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772087913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBnHy6Wt6KIMmNtQkTGAQl4rker7iQYbWNqsGDyPpU=;
	b=sZLCyv9rqzZTCma2CuI8noJhiPRpVEg7ApHg0pg2yKN0BSxcudR+YOw/st7ppaCDzd/ei3
	mGGMRwtSzV2/46CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECA33EA62;
	Thu, 26 Feb 2026 06:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u1tFCWnqn2kTJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Feb 2026 06:38:33 +0000
Date: Thu, 26 Feb 2026 07:38:32 +0100
Message-ID: <87a4wwc8lz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jun Seo <junwoo93s@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jun Seo <jun.seo.93@proton.me>
Subject: Re: [PATCH] ALSA: usb-audio: Use correct version for UAC3 header validation
In-Reply-To: <20260226010820.36529-1-jun.seo.93@proton.me>
References: <20260226010820.36529-1-jun.seo.93@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-219761-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 695B01A15DA
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 02:08:20 +0100,
Jun Seo wrote:
> 
> The entry of the validators table for UAC3 AC header descriptor is
> defined with the wrong protocol version UAC_VERSION_2, while it should
> have been UAC_VERSION_3.  This results in the validator never matching
> for actual UAC3 devices (protocol == UAC_VERSION_3), causing their
> header descriptors to bypass validation entirely.  A malicious USB
> device presenting a truncated UAC3 header could exploit this to cause
> out-of-bounds reads when the driver later accesses unvalidated
> descriptor fields.
> 
> The bug was introduced in the same commit as the recently fixed UAC3
> feature unit sub-type typo, and appears to be from the same copy-paste
> error when the UAC3 section was created from the UAC2 section.
> 
> Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jun Seo <jun.seo.93@proton.me>

Thanks, applied now.


Takashi

