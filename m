Return-Path: <stable+bounces-231022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFHWBz4nymnX5gUAu9opvQ
	(envelope-from <stable+bounces-231022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:33:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F303567BD
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF0BE300493F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A53803D4;
	Mon, 30 Mar 2026 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0LxNsyOs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XCTLaD4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rwWAY95O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x050rrf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327E3815FF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855992; cv=none; b=uOb4thjjKB1GYRBa/NJe73f30G6TwO9aBk4WXV6IeKDwnteIEoIkJn9HmDXR7pUAG5pmZTznMEDqt5EgLN6AsoOFDOhrOHRXZd791iCmpRhGFS7VpH/0+HXIJAI33xA2VyBkBRNSFjHJCPCn26FRkvun0n3tQXP1kYEYTRbATaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855992; c=relaxed/simple;
	bh=BH6P+OXYSGy1vOWXVNyV0HUiSpLwRbkoPsglKMoGEI4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK/f11VV05PF3QS6LyKz9iOnfYy/u/UG6eflWBwZtjMgPBVPau1q2D4eXFrKRYW9uhQ7uichspwOHcdiyWtkdwRjATnK0GRhwoffhf198YiVpdZ1pCmkBNKoxDSIPUN/28pltRFkn+IL1e45dXxUF8hxwZGNQMHLVqYYsJOB0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0LxNsyOs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1XCTLaD4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rwWAY95O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x050rrf7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9825C4D1F1;
	Mon, 30 Mar 2026 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774855989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrNJgn8c8oBVTOIi6FKgPr1CbbB/KxUNcFta++4MWWc=;
	b=0LxNsyOsRTEmlQMDaG1Umgs5LOFmZDlyLfp6dDIQR5oALN2kEtPIjNNqN4FvvlmnHdot2O
	RQiGA1cOQJxJ0C+T3f6rrkuRMvkWp2sM3eo72wyV0lt4wxaU1faWpe3Slzoy3/vyxvoNB3
	FSZa6ZDF9vfu919zLjkHWTJFV1x4QuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774855989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrNJgn8c8oBVTOIi6FKgPr1CbbB/KxUNcFta++4MWWc=;
	b=1XCTLaD4xcCfzsDlHq5wkqwaw6+2oYJ5z1iX7F2ADUL80WnxIJlAxNwE7YVS8vkz7l07OE
	eWmtt47Yb+lELiCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rwWAY95O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x050rrf7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774855988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrNJgn8c8oBVTOIi6FKgPr1CbbB/KxUNcFta++4MWWc=;
	b=rwWAY95O7sYOPSxb2uaoLWW+ly3ig0+0NMt04svYTHDry1/K2soc7MXAO4LLFxMIgZ30zF
	d17ZcuoMTmfjcUbD3M0SpgciMMnu56pI90bCNu0JnaYchjT36I+XSJH6RaJL3Ai/qn6V/e
	F+3YrjGVvJlbWr9+AMDdi63yYj7h3KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774855988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrNJgn8c8oBVTOIi6FKgPr1CbbB/KxUNcFta++4MWWc=;
	b=x050rrf7RN4PjmgNW5NZJ6QDODva+6shqAuxP/jFPi7D/pNkqnyaAxM64G3C3kHLOcvkxU
	JBq/hN4UtGhVzdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676C14A0A2;
	Mon, 30 Mar 2026 07:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P37wFzQnymkPJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Mar 2026 07:33:08 +0000
Date: Mon, 30 Mar 2026 09:33:07 +0200
Message-ID: <87se9hu5zg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: zonque@gmail.com,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	andreyknvl@gmail.com
Subject: Re: [PATCH] ALSA: caiaq: fix stack out-of-bounds read in init_card
In-Reply-To: <20260329133825.581585-1-berkcgoksel@gmail.com>
References: <20260329133825.581585-1-berkcgoksel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231022-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 75F303567BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 15:38:25 +0200,
Berk Cem Goksel wrote:
> 
> The loop creates a whitespace-stripped copy of the card shortname
> where `len < sizeof(card->id)` is used for the bounds check. Since
> sizeof(card->id) is 16 and the local id buffer is also 16 bytes,
> writing 16 non-space characters fills the entire buffer,
> overwriting the terminating nullbyte.
> 
> When this non-null-terminated string is later passed to
> snd_card_set_id() -> copy_valid_id_string(), the function scans
> forward with `while (*nid && ...)` and reads past the end of the
> stack buffer, reading the contents of the stack.
> 
> A USB device with a product name containing many non-ASCII, non-space
> characters (e.g. multibyte UTF-8) will reliably trigger this as follows:
> 
>   BUG: KASAN: stack-out-of-bounds in copy_valid_id_string
>        sound/core/init.c:696 [inline]
>   BUG: KASAN: stack-out-of-bounds in snd_card_set_id_no_lock+0x698/0x74c
>        sound/core/init.c:718
> 
> The off-by-one has been present since commit bafeee5b1f8d ("ALSA:
> snd_usb_caiaq: give better shortname") from June 2009 (v2.6.31-rc1),
> which first introduced this whitespace-stripping loop. The original
> code never accounted for the null terminator when bounding the copy.
> 
> Fix this by changing the loop bound to `sizeof(card->id) - 1`,
> ensuring at least one byte remains as the null terminator.
> 
> Fixes: bafeee5b1f8d ("ALSA: snd_usb_caiaq: give better shortname")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Reported-by: Berk Cem Goksel <berkcgoksel@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>

Applied now.  Thanks.


Takashi

