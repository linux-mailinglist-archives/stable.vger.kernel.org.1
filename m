Return-Path: <stable+bounces-235574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B8yDj2a2GkgfggAu9opvQ
	(envelope-from <stable+bounces-235574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:35:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1D3D2D42
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75271300CC99
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F06387363;
	Fri, 10 Apr 2026 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0nGBxodj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zmZgCbpS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0nGBxodj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zmZgCbpS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89B27603D
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802938; cv=none; b=ezotvusu3+Tf5QZ5FQlKfEO2JRrMkUm3MBUsbn5E17lcVknhN+U32B/1aXSokJDvFbwn7VtrfJtGUIjx8DcPjK0Ml3hyWXy3TzgLCj3S377ecT8HIsIm9zK88I8X1V2WntLskRYoebsbaKNEqaxr0rIvXrDgOqHv5VdPJm5YckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802938; c=relaxed/simple;
	bh=J3034AfyNbZ3qjQlKiiFnKCLDPBHYG5YwVgJ7D0jiRQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqLOWAbUb8eryznicw8f4iOUTcUngi2rCXwsMamBu3mGOMkDvz6S+hGr9EWFCsuG+i8aKb/88NVJRMDFGHwNHw262A7O3d8b2fbSuDWEDf1JoFVrurQvidrteMsAf+dUJgeURWIgEXTPBDsweU3jQLh0Lkj0dshD/7Lfw/qzc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0nGBxodj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zmZgCbpS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0nGBxodj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zmZgCbpS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 136F76A7CE;
	Fri, 10 Apr 2026 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775802935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXYiZrb7MkAlrINtyItjhsk6N0mkpQNi47JzM89a7mA=;
	b=0nGBxodjUXpWMbJmF0P8sqeZ8/CWEpHmlJguawCmc4zOFk35gvrCNmPCz71XsrrLc6IcUK
	wrs9AYKQG27oXCqqUdsnje8ujZE5poEVsmuXAPiV4yObcrZN5uUIH6STTZ8N9EdrJ2CGQQ
	VYJ2DnjDky29ZJeiu214QlhrEZLnMvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775802935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXYiZrb7MkAlrINtyItjhsk6N0mkpQNi47JzM89a7mA=;
	b=zmZgCbpSszC237zeyQfyUE9IilC5wM2CnkqGHHnHB6WyGDPwztbc9MNVJlmXfjSYxHTun0
	YFzixgVkkxv438Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0nGBxodj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zmZgCbpS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775802935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXYiZrb7MkAlrINtyItjhsk6N0mkpQNi47JzM89a7mA=;
	b=0nGBxodjUXpWMbJmF0P8sqeZ8/CWEpHmlJguawCmc4zOFk35gvrCNmPCz71XsrrLc6IcUK
	wrs9AYKQG27oXCqqUdsnje8ujZE5poEVsmuXAPiV4yObcrZN5uUIH6STTZ8N9EdrJ2CGQQ
	VYJ2DnjDky29ZJeiu214QlhrEZLnMvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775802935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXYiZrb7MkAlrINtyItjhsk6N0mkpQNi47JzM89a7mA=;
	b=zmZgCbpSszC237zeyQfyUE9IilC5wM2CnkqGHHnHB6WyGDPwztbc9MNVJlmXfjSYxHTun0
	YFzixgVkkxv438Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9904A0B2;
	Fri, 10 Apr 2026 06:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 16qpMDaa2GnNEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 10 Apr 2026 06:35:34 +0000
Date: Fri, 10 Apr 2026 08:35:34 +0200
Message-ID: <87se93gw5l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: 6fire: fix use-after-free on disconnect
In-Reply-To: <20260410051341.1069716-1-berkcgoksel@gmail.com>
References: <20260410051341.1069716-1-berkcgoksel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235574-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: B8A1D3D2D42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 07:13:41 +0200,
Berk Cem Goksel wrote:
> 
> In usb6fire_chip_abort(), the chip struct is allocated as the card's
> private data (via snd_card_new with sizeof(struct sfire_chip)).  When
> snd_card_free_when_closed() is called and no file handles are open, the
> card and embedded chip are freed synchronously.  The subsequent
> chip->card = NULL write then hits freed slab memory.
> 
> Call trace:
>   usb6fire_chip_abort sound/usb/6fire/chip.c:59 [inline]
>   usb6fire_chip_disconnect+0x348/0x358 sound/usb/6fire/chip.c:182
>   usb_unbind_interface+0x1a8/0x88c drivers/usb/core/driver.c:458
>   ...
>   hub_event+0x1a04/0x4518 drivers/usb/core/hub.c:5953
> 
> Fix by moving the card lifecycle out of usb6fire_chip_abort() and into
> usb6fire_chip_disconnect().  The card pointer is saved in a local
> before any teardown, snd_card_disconnect() is called first to prevent
> new opens, URBs are aborted while chip is still valid, and
> snd_card_free_when_closed() is called last so chip is never accessed
> after the card may be freed.
> 
> Fixes: a0810c3d6dd2 ("ALSA: 6fire: Release resources at card release")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>

Applied now.  Thanks.


Takashi

