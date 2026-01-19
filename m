Return-Path: <stable+bounces-210278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A9D3A174
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529AB3126E0A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903A2737F8;
	Mon, 19 Jan 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nw96OJRd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmn7dPHF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nw96OJRd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmn7dPHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757D33B96B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810764; cv=none; b=TLUj8dVRQFhaH3CbOEYGpHwplULhGj2rlo8EFFpAKFli7orKRkoZmugQNsaa/wmXSZ8HQyTAJSU9GzTQf/kwT8bYKMKbRup9l3erJexxbT86jtol6NByu16Fb5FNw2DcYqfiviOQYoKKP7Bpmq7kx3g3Rdv2d0Gbi3u6uvtmyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810764; c=relaxed/simple;
	bh=iCPfihwEnRCV/y960q9MGy9Q3kSsEIJCPv7v/yROZRE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgyrSIECwa/DMXnxR0AVkr19ZVMnzmSxbHM82Uv9y5MDIFwZAn4SKGTbH+xb46Qq1z5m85dRRNFacbENpwf8ORIalaWJnlcHv4O8cx/+SRqfSEb75Ic7HkrsmT/zEm+Rwzvuala/gUxuJ9OlNayUXzc97MdJqx670mtDJ2xkqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nw96OJRd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmn7dPHF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nw96OJRd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmn7dPHF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8A625BCFD;
	Mon, 19 Jan 2026 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768810757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4gjNsrpe6HGAjN16c9RhgQt92zfS+329VG4t51ViVI=;
	b=Nw96OJRdDpgYbOt11ljd6X0rD+8j5gTrYuhZgydVxG+qs3Q9Y/X4rcg+d0AVpytkLtRHd5
	JExVQyF5LIJ3nNZrnDFpM/ygXOaA6A5YS+xbKzV61LhdBLp4vkNKB6/5vKdCGT+P9HT2Ml
	8Zah1aRdktbSIjCaDG2514+5J8NME1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768810757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4gjNsrpe6HGAjN16c9RhgQt92zfS+329VG4t51ViVI=;
	b=pmn7dPHF3ObMrWrp5v3A88iAkgEs051CY55lnCjmExt5SB2zZNAOpcFRAD0pOEqrmUK9vl
	GqeAvylfjgoqZgDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768810757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4gjNsrpe6HGAjN16c9RhgQt92zfS+329VG4t51ViVI=;
	b=Nw96OJRdDpgYbOt11ljd6X0rD+8j5gTrYuhZgydVxG+qs3Q9Y/X4rcg+d0AVpytkLtRHd5
	JExVQyF5LIJ3nNZrnDFpM/ygXOaA6A5YS+xbKzV61LhdBLp4vkNKB6/5vKdCGT+P9HT2Ml
	8Zah1aRdktbSIjCaDG2514+5J8NME1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768810757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4gjNsrpe6HGAjN16c9RhgQt92zfS+329VG4t51ViVI=;
	b=pmn7dPHF3ObMrWrp5v3A88iAkgEs051CY55lnCjmExt5SB2zZNAOpcFRAD0pOEqrmUK9vl
	GqeAvylfjgoqZgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D0A3EA63;
	Mon, 19 Jan 2026 08:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LvpSEgXpbWlzDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Jan 2026 08:19:17 +0000
Date: Mon, 19 Jan 2026 09:19:16 +0100
Message-ID: <87o6mq816j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Qin Wan <qin.wan@hp.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	chris.chiu@canonical.com,
	edip@medip.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	alexandru.gagniuc@hp.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix micmute led for HP ElitBook 6 G2a
In-Reply-To: <20260119034504.3047301-1-qin.wan@hp.com>
References: <20260119034504.3047301-1-qin.wan@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,realtek.com,canonical.com,medip.dev,vger.kernel.org,hp.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 19 Jan 2026 04:45:04 +0100,
Qin Wan wrote:
> 
> This laptop uses the ALC236 codec, fixed by enabling
> the ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk
> 
> Signed-off-by: Qin Wan <qin.wan@hp.com>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

The patch isn't applicable cleanly at all, as you have lots of
different quirk entries.  Which git tree is it based on?


thanks,

Takashi

> ---
>  sound/hda/codecs/realtek/alc269.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 0bd9fe745807..49590926199e 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6704,6 +6704,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8ed8, "HP Merino16", ALC245_FIXUP_TAS2781_SPI_2),
>  	SND_PCI_QUIRK(0x103c, 0x8ed9, "HP Merino14W", ALC245_FIXUP_TAS2781_SPI_2),
>  	SND_PCI_QUIRK(0x103c, 0x8eda, "HP Merino16W", ALC245_FIXUP_TAS2781_SPI_2),
> +	SND_PCI_QUIRK(0x103c, 0x8f14, "HP EliteBook 6 G2a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8f19, "HP EliteBook 6 G2a 16",  ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8f3c, "HP EliteBook 6 G2a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8f3d, "HP EliteBook 6 G2a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8f40, "HP Lampas14", ALC287_FIXUP_TXNW2781_I2C),
>  	SND_PCI_QUIRK(0x103c, 0x8f41, "HP Lampas16", ALC287_FIXUP_TXNW2781_I2C),
>  	SND_PCI_QUIRK(0x103c, 0x8f42, "HP LampasW14", ALC287_FIXUP_TXNW2781_I2C),
> -- 
> 2.43.0
> 

