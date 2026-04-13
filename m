Return-Path: <stable+bounces-235906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BhAOb193GmyRwkAu9opvQ
	(envelope-from <stable+bounces-235906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:23:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B73E7728
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E179730097F1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26F382281;
	Mon, 13 Apr 2026 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGppmQKt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CGTz+Rko";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGppmQKt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CGTz+Rko"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B11226863
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776057775; cv=none; b=YQeVmgxJV6cgL6Pa2rqD98BsMvjri+Xl1vRb8m0zAHK1PkMwbektLDOQrh2KlBN8L1BuiVppjHMPzjsBdKzH4By+EdVR87qE2OFS24waPdwcJ/e1pSg/a6pElq1aoKa8335e++gcG3UwEm8ssYqszA+3aLUYsrrvjmvA9V9PSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776057775; c=relaxed/simple;
	bh=PjdpxQhBQcaNzD+3z9ET0HzaenMqgnRbZKOJWeay1nA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CP9w2WPgAsggJVsz5a82yJlU4dmYwaPoNt/PqzG6KaANYmJ0f6V1rcAZnj19Qw5vWp9TER6pDa/sXjLdsnwcL2cDGpkyG660sm/P2NYirG2GZqO7WU8KnhILsnLwS9Q3bnE8yr6zkWfuOdPPxoWtEAVP3RPZcDL8l63vz3R1KoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGppmQKt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CGTz+Rko; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGppmQKt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CGTz+Rko; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 154BD5BCE2;
	Mon, 13 Apr 2026 05:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776057766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KuaP+JiBTRM7YgF0L8XdTCIlrYai176tDE/omznCcE=;
	b=UGppmQKtNQWrpHqauaXTK81z1TI4fd+m/+hZ+1AFRfuwozc9LrzemATzW0xrTpYqAcjyOy
	GrtBI+4+qNzTKw7EH/GCBTxwcx/tugC4WPWVPYW38+DMRQviA0MdYPEgR/MPi7BefcxiO5
	uazIvOUEDRHHWVUfDeizaodGJAw3vvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776057766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KuaP+JiBTRM7YgF0L8XdTCIlrYai176tDE/omznCcE=;
	b=CGTz+RkoJKf4ftZ7BSMpd1lM2CiRf7ZnBwCQ+o6niTQaHjCMI7MmvWccuK/6XjsrulRCoQ
	5xLLxDI9ddNdkGAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UGppmQKt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CGTz+Rko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776057766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KuaP+JiBTRM7YgF0L8XdTCIlrYai176tDE/omznCcE=;
	b=UGppmQKtNQWrpHqauaXTK81z1TI4fd+m/+hZ+1AFRfuwozc9LrzemATzW0xrTpYqAcjyOy
	GrtBI+4+qNzTKw7EH/GCBTxwcx/tugC4WPWVPYW38+DMRQviA0MdYPEgR/MPi7BefcxiO5
	uazIvOUEDRHHWVUfDeizaodGJAw3vvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776057766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KuaP+JiBTRM7YgF0L8XdTCIlrYai176tDE/omznCcE=;
	b=CGTz+RkoJKf4ftZ7BSMpd1lM2CiRf7ZnBwCQ+o6niTQaHjCMI7MmvWccuK/6XjsrulRCoQ
	5xLLxDI9ddNdkGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C91914AD00;
	Mon, 13 Apr 2026 05:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CeVbL6V93GkGVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Apr 2026 05:22:45 +0000
Date: Mon, 13 Apr 2026 07:22:45 +0200
Message-ID: <87qzojwi1m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hwdep: fix NULL dereference on error path
In-Reply-To: <20260412174529.2597250-1-lgs201920130244@gmail.com>
References: <20260412174529.2597250-1-lgs201920130244@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-235906-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591B73E7728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 19:45:29 +0200,
Guangshuo Li wrote:
> 
> snd_hwdep_new() allocates a hwdep instance first and then allocates
> hwdep->dev via snd_device_alloc().
> 
> When snd_device_alloc() fails, hwdep->dev remains NULL, because
> snd_device_alloc() clears *dev_p before attempting to allocate the
> device object. The error path then calls snd_hwdep_free(), which
> unconditionally invokes put_device(hwdep->dev).
> 
> This may lead to a NULL pointer dereference in put_device().

put_device() has a NULL check by itself, so it's safe to pass NULL
there.


thanks,

Takashi

