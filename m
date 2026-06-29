Return-Path: <stable+bounces-269714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8jArMQxHQmqV3gkAu9opvQ
	(envelope-from <stable+bounces-269714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:21:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 665EB6D8D71
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0m8vXRIM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aBp2k8ul;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0m8vXRIM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aBp2k8ul;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269714-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269714-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D56303A8C1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4C3FADE0;
	Mon, 29 Jun 2026 10:19:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3363EB0F5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:19:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728347; cv=none; b=EfGA4qz2SG5XCSvD06MSQTLjwGAxUTJezksTUdhoHRcnQAz9oQkNgUzpp6UkV84IIWxGpvhBCZE08CM57NZbF68//qAv+0zaTEFqvNSEAYFfw9qUUdOhl+sZh+FCRuHMOQwQ04HgKzbzvsN9CjSPupBgMZZPBoU36E2G++93IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728347; c=relaxed/simple;
	bh=0kreSd55Mg20LS910ypPNq6bivAtOIE+vYsYkASCNnA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVdET5UoCif2zPkZzZQNyGawwaMYkTRmYWtIYKSO1OZdFiWIhqhNXDk5mCNQZlpoWZ7uXPlL8JXzWzpyvh/+xWbmgFLyT13rek3xJfVN1Qoc73gPHHc8jseXnv2o5+LWCF/Lyme1Qt8v/fU++6shS21lNGP7bCgvPjQnddonB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0m8vXRIM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aBp2k8ul; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0m8vXRIM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aBp2k8ul; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1FC75D7C;
	Mon, 29 Jun 2026 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=0m8vXRIMHwzsWseiRDCl5o3zsKtjE6TtqCu0X9nNTsI38Dn0eybO4wWn0pmx12NNVJFQXm
	7aGYrTarULmINJNwradDgHsIIRUeOg/+OsfPP4b4jUjJrjxYm73+A67tsMk83EhqUgpaJy
	G3i8L5mqtaNJ+mFVyCzctcSHP3h3BrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=aBp2k8ulb1s2V8lSl8NU48V/ArNm+l6Dr1s6xfYqOx4dmQ8picGDNempHycAcnM0PvyeED
	of86LIe7WmZOXFAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=0m8vXRIMHwzsWseiRDCl5o3zsKtjE6TtqCu0X9nNTsI38Dn0eybO4wWn0pmx12NNVJFQXm
	7aGYrTarULmINJNwradDgHsIIRUeOg/+OsfPP4b4jUjJrjxYm73+A67tsMk83EhqUgpaJy
	G3i8L5mqtaNJ+mFVyCzctcSHP3h3BrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=aBp2k8ulb1s2V8lSl8NU48V/ArNm+l6Dr1s6xfYqOx4dmQ8picGDNempHycAcnM0PvyeED
	of86LIe7WmZOXFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E89779A8;
	Mon, 29 Jun 2026 10:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fLCKDJdGQmrYEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jun 2026 10:19:03 +0000
Date: Mon, 29 Jun 2026 12:19:02 +0200
Message-ID: <878q7xr6nd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	ramiserifpersia@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: sound/usb/usx2y: capture_urb_complete: redundant usb_anchor_urb corrupts anchor list on each resubmission
In-Reply-To: <20260627042949.61767-1-vulab@iscas.ac.cn>
References: <20260627042949.61767-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:perex@perex.cz,m:tiwai@suse.com,m:ramiserifpersia@gmail.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 665EB6D8D71

On Sat, 27 Jun 2026 06:29:49 +0200,
WenTao Liang wrote:
> 
> In capture_urb_complete(), usb_anchor_urb() is called on every
> completion callback, but the URB is already anchored from the
> initial submission in tascam_trigger_start(). Each redundant call
> corrupts the anchor's doubly-linked list and inflates the URB
> refcount. When usb_kill_anchored_urbs() traverses the list during
> stream stop / suspend / disconnect, the corrupted list leads to
> use-after-free.
> 
> Remove the redundant usb_anchor_urb() from the resubmit path.
> 
> Cc: stable@vger.kernel.org
> Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Applied now.  But, at the next time, please try to adjust the subject
prefix; for sound/usb, it's "ALSA:"


thanks,

Takashi

