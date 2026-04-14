Return-Path: <stable+bounces-237783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM+UI2YY3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:35:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60E3F8C8D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21B730D06F8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25833D6CB3;
	Tue, 14 Apr 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QqpOztPH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0BTKcRHG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QqpOztPH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0BTKcRHG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD393CAE8A
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162628; cv=none; b=Wzq7Nta/DGg3NGxiKQBvDkTdlBR+RewAdEn1B2BRTCaQ7Z8RZqAu9nl/jxXoK7187IBdtHsua1IZMJrYYwO1EjcMwaZoExI03Kb0O/F2N+gBcrK1atxfLmBcKuaNCIej5gZcwJUX/xNBz/DSU5oC2TEpITXhFMVFQs1fgo4OkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162628; c=relaxed/simple;
	bh=TuY/NdoZ51nsBzxKZhEQY6Kg5GEPlAKcdsCRXJhpW2Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWkouq2hVvDjmY1sdvDIAa0sqkB0OIG1/1w2kznGnWicvNKLeMsUMAp6i/3mE1W3EmMxCIrDTdnMBp9DusDpdVYDLuWq4AXIvPlfy11/jW1asWipaEid2K1T3OGWT4ViGL0gMdCyHvufPQyt5ajfwcUe8rdtbBNlsz01Fj5Q3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QqpOztPH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0BTKcRHG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QqpOztPH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0BTKcRHG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2176A5BDC2;
	Tue, 14 Apr 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776162621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m/ufPaX9NglbyVHrUPxFloxtGGzG8kAQ5DijRtpYxA=;
	b=QqpOztPHYfDjHJSbl4P4BeNISNk+1/y/qT9BNmxWXDnBsmSC6ZDoOZT/r4X7o9n5ehwiV4
	9ITkBtQbWaRIcLiyVJC8xWcjFT+4t8gXbiDKNMSA75SkhenvFEYfIvJwRrxbD2jNja4VEX
	EDsGDPhF3RLmSZeXkZsH+IwRXJxKRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776162621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m/ufPaX9NglbyVHrUPxFloxtGGzG8kAQ5DijRtpYxA=;
	b=0BTKcRHGkvNx0V9E/3+ub5cCI5Koe/UMKlAfyCDugaHMDWjtQtFiRMD2GlvC4jrMJrHtB9
	wJynCLs9BrnlrbCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QqpOztPH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0BTKcRHG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776162621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m/ufPaX9NglbyVHrUPxFloxtGGzG8kAQ5DijRtpYxA=;
	b=QqpOztPHYfDjHJSbl4P4BeNISNk+1/y/qT9BNmxWXDnBsmSC6ZDoOZT/r4X7o9n5ehwiV4
	9ITkBtQbWaRIcLiyVJC8xWcjFT+4t8gXbiDKNMSA75SkhenvFEYfIvJwRrxbD2jNja4VEX
	EDsGDPhF3RLmSZeXkZsH+IwRXJxKRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776162621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m/ufPaX9NglbyVHrUPxFloxtGGzG8kAQ5DijRtpYxA=;
	b=0BTKcRHGkvNx0V9E/3+ub5cCI5Koe/UMKlAfyCDugaHMDWjtQtFiRMD2GlvC4jrMJrHtB9
	wJynCLs9BrnlrbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21CE4B3CC;
	Tue, 14 Apr 2026 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w2z2NTwX3mlCDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Apr 2026 10:30:20 +0000
Date: Tue, 14 Apr 2026 12:30:20 +0200
Message-ID: <87ik9tsukj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ziqing Chen <chenziqing@xiaomi.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
In-Reply-To: <177616141245.165602.4944737214352244015@xiaomi.com>
References: <20260414090542.151447-1-chenziqing@xiaomi.com>
	<177616141245.165602.4944737214352244015@xiaomi.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237783-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: DE60E3F8C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 12:10:12 +0200,
Ziqing Chen wrote:
> 
> On Tue, 15 Apr 2026, Takashi Iwai wrote:
> > Having a zero buf_len check is good, per se, but it doesn't have to be
> > at this late place.  It can be checked at the very beginning even
> > before the allocation (where we have already an upper bound check),
> > instead.
> 
> Thanks for the review.
> 
> The crash I hit is not caused by buf_len being zero at entry -- it
> occurs when buf_len is decremented to zero *during* the loop after
> successfully parsing earlier items. For example, a userspace caller
> can craft an ioctl payload where buf_len is just large enough for
> the first N-1 names but leaves exactly zero bytes for the Nth item.
> 
> An early check (buf_len == 0 before allocation) would catch the
> degenerate case where the caller passes a zero-length buffer, which
> is a good idea on its own, but it would not prevent the mid-loop
> exhaustion that triggers the FORTIFY_SOURCE panic.
> 
> The issue was originally caught during fuzz testing via ioctl on an
> arm64 (MT6993) device with CONFIG_FORTIFY_SOURCE and Clang. We have
> not been able to reproduce it since, which is consistent with it
> depending on Clang's __builtin_dynamic_object_size() heuristic for
> the loop-incremented pointer -- the evaluation can vary across
> compiler versions and optimization levels.
> 
> Here is the crash stack from the original hit:
> 
>   Unexpected kernel BRK exception at EL1
>   Internal error: BRK handler: 00000000f2000001 1 PREEMPT SMP
>   pc : snd_ctl_elem_init_enum_names+0x244/0x24c
>   lr : snd_ctl_elem_init_enum_names+0x244/0x24c
>   Call trace:
>    snd_ctl_elem_init_enum_names+0x244/0x24c
>    snd_ctl_elem_add+0x4bc/0x7b0
>    snd_ctl_elem_add_user+0x128/0x26c
>    snd_ctl_ioctl+0x9a4/0x1a68
>    __arm64_sys_ioctl+0x110/0x18c
>    invoke_syscall+0x9c/0x210
>    el0_svc_common+0xe4/0x1b0
>    do_el0_svc+0x34/0x44
>    el0_svc+0x38/0x84
>    el0t_64_sync_handler+0x70/0xbc
> 
> The BRK is from the fortified strnlen() -- when Clang loses track of
> the dynamic object size for the repeatedly incremented pointer p
> inside the loop, __builtin_dynamic_object_size() evaluates to 0,
> causing the FORTIFY check to fire before strnlen() even returns.
> 
> Would you prefer a v2 that adds both checks -- a buf_len == 0 guard
> at the function entry (next to the existing upper bound check) and
> the loop-level guard? Or do you think the loop check alone is
> sufficient?

OK, thanks for clarification, now it's clearer.

But your posted patch doesn't seem applicable because your mailer
broke tabs with spaces.  Could you try to fix your mailer setup and
resubmit?


thanks,

Takashi

