Return-Path: <stable+bounces-270151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AG7CH4QARWqR4woAu9opvQ
	(envelope-from <stable+bounces-270151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:56:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31E6ED02A
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:56:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=otTxxeV7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vpGqYG+n;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EhTOw44i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v7YhbTbB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270151-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270151-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748B2301DAFA
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2047F2D6;
	Wed,  1 Jul 2026 11:56:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1E436367
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:56:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906976; cv=none; b=e0Ch0k6fnehoI9ns0Ij6e28oqTjnmcW8bx3EcGQVhCK7cIOs5MakuYr58FvW7ZqMXGw+jf/Kj4ABmqMS5hPr4iiLh/yrDNZ/UqcR4Pzc8V/XfHtfzTpgPPnOYiSkRfQ4y/IAdH3LyYZ4Fy6Fc5NwSjpCDAe/BNiqyOEFrht78ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906976; c=relaxed/simple;
	bh=xdWuBup5ubjAz5buhIS9hoT7rNPTlXU2jJVUJvO5hRk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqOcZItz7X7QGMZ8+CgI2Cv900vjQRzobokpm1Sq3wI7v8YoFrX888S8W/lGBPuxdyKBTt+tsjxhZ2ybLmJJinacwEOzARriZLzIX6U+Rxhlv4ZS30eRii6MxXIG8u13OyzU1oA7F7TzhFl0OUcWPCYU6dVEPpsjN3BIybRl9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=otTxxeV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vpGqYG+n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EhTOw44i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v7YhbTbB; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E7A71A6C;
	Wed,  1 Jul 2026 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782906973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=otTxxeV7JzNN7452Lmbpom542iesBd/JzhUbGaszscgc6HLiPT3V6Qm+vfqjRBm7ebUYsq
	yiL2M5bI6aToSjtsQihXLmUevtB17g0gjhXq0NXK0x1ed/9OzOnOIyByqAte1ckZfzgTVr
	HGyRUKdTSMO/nUOuENMiuQMUhykOjQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782906973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=vpGqYG+njd5BaCoCHSG5jt7yutxiNQT373bfP/w4S+ZpGdFLH/XshFR4S52aVLUP3AuRVo
	N11rKUBwMX1eRJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782906972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=EhTOw44iy8T/1/otd8pQFZcc3RvAFRpy8rIa2QuIUpKR81rQn0x6DaNi4iIKMOvOBsZMpM
	agtG2ClqzpjQNXqwW36XfOWV77XlZVhxTPdBQvw/4Qd3F6J+6l+jwyxCcnbjAhH1lI9dY5
	GwK0FwTgKoRHJkPeA5eyI9eG076/g9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782906972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=v7YhbTbBRoAJwjBqXk2FZ+oAw/uKJo7boI0FD/O9pCpzbk7yma/J+lqn8P1e9c9gBhLnT0
	yHy4TPK8uRuwmZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0C3779AA;
	Wed,  1 Jul 2026 11:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XWLqNFsARWrDKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 Jul 2026 11:56:11 +0000
Date: Wed, 01 Jul 2026 13:56:11 +0200
Message-ID: <8733y2vs84.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,
	=?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usx2y: us144mkii: fix work UAF on disconnect
In-Reply-To: <20260701095231.1020811-1-sammiee5311@gmail.com>
References: <20260701095231.1020811-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270151-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sammiee5311@gmail.com,m:tiwai@suse.com,m:perex@perex.cz,m:ramiserifpersia@gmail.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F31E6ED02A

On Wed, 01 Jul 2026 11:52:31 +0200,
HyeongJun An wrote:
> 
> tascam_disconnect() cancels capture_work and midi_in_work before
> usb_kill_anchored_urbs() kills the capture/MIDI-in URBs.  Those URBs
> self-resubmit, and their completion handlers reschedule the work.
> 
> A URB that completes in the small window between cancel_work_sync() and
> usb_kill_anchored_urbs() therefore re-arms the work after its only
> cancel.  Nothing cancels it again before snd_card_free() frees the
> card-private tascam structure, so the work handler then runs on freed
> memory.
> 
> Kill the anchored URBs before cancelling the work; once the work is
> cancelled no remaining URB can complete to re-arm it.
> 
> Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi

