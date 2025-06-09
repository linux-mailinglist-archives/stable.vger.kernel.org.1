Return-Path: <stable+bounces-151996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C7AD193C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E12C1887F83
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720D28030D;
	Mon,  9 Jun 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BrPXUiE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LL4ukOCX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BrPXUiE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LL4ukOCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1B13957E
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455273; cv=none; b=RQ8xrPftZ6CjXBEN49bysz1TGU4zzrisS+QiByxryby6/u2ojSAmhS+0e5EhIy7GhnKikRW/HMnPPTmYs0TaNPQWwgXhzurd89nXmVDca47Q3S26SR6yPDKdbjgRCDTRZW1zTUbF4ZdDqclKeog7sF7B26QMhsr0260kLgSI7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455273; c=relaxed/simple;
	bh=DVZmFDRN34wedu9EopZdzBpF92Y8lkbGctIbaZuk0UM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKcDSob8C8a461izyTK5Y6yq8X/xNOqcenxf26/3M/QYbCkz/IoZ3S1SPY/Cw7uD9r5z6EUi5hiWd3WGrVrRzCyLtFFG1F5xJekFNwYhw3PQTgdzTdR4bZau8UIrx9rMiPF7UMxAr6hpHDbGpS9SsU7eTu6JFu6WsZLxa+B1XF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BrPXUiE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LL4ukOCX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BrPXUiE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LL4ukOCX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77ED81F38D;
	Mon,  9 Jun 2025 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749455270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKTHDnHNUm56SfYdpRWGsl0y8TWAmzpz6qTvuBz+E8=;
	b=BrPXUiE2ZDlzzcO8GIfGdgRktHmmm4U95gf5NNNebOERxII3YYYtFeN6+puyLkTZjB9ref
	PEB6ihKicW8ZVxMWofPN9QY5VprICkLbXfZzVbxeU+Zo7iO+c0sVkQFBLKak5p6k/3I12J
	skgmO/P4H/V57Rvp9UCT9INLoTGWMkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749455270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKTHDnHNUm56SfYdpRWGsl0y8TWAmzpz6qTvuBz+E8=;
	b=LL4ukOCXDCfg4mu6OsN7GaZ25PI7qrDMaE3vhNcAsGgaTy3SkSjBtvFDYepNvLWLZU1keT
	lFULLJa2qPBHf4Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BrPXUiE2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LL4ukOCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749455270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKTHDnHNUm56SfYdpRWGsl0y8TWAmzpz6qTvuBz+E8=;
	b=BrPXUiE2ZDlzzcO8GIfGdgRktHmmm4U95gf5NNNebOERxII3YYYtFeN6+puyLkTZjB9ref
	PEB6ihKicW8ZVxMWofPN9QY5VprICkLbXfZzVbxeU+Zo7iO+c0sVkQFBLKak5p6k/3I12J
	skgmO/P4H/V57Rvp9UCT9INLoTGWMkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749455270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKTHDnHNUm56SfYdpRWGsl0y8TWAmzpz6qTvuBz+E8=;
	b=LL4ukOCXDCfg4mu6OsN7GaZ25PI7qrDMaE3vhNcAsGgaTy3SkSjBtvFDYepNvLWLZU1keT
	lFULLJa2qPBHf4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 450C913A1D;
	Mon,  9 Jun 2025 07:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sTwLD6aRRmhCfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Jun 2025 07:47:50 +0000
Date: Mon, 09 Jun 2025 09:47:49 +0200
Message-ID: <87bjqx8ifu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 16-s1xxx and HP Victus 15-fa1xxx
In-Reply-To: <20250607105051.41162-1-edip@medip.dev>
References: <20250607105051.41162-1-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 77ED81F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.51

On Sat, 07 Jun 2025 12:50:51 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on those laptops is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the devices.
> 
> Tested on my Victus 16-s1011nt Laptop and my friend's Victus 15-fa1xxx. The LED behaviour works as intended.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>
> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index cd0d7ba73..1e07da9c6 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10733,6 +10733,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
> +	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
>  	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),

The table entries are sorted in (PCI) SSID order.
Could you try to put the new item at the right position?


> @@ -10805,6 +10806,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre x360 2-in-1 Laptop 16-aa0xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX),
>  	SND_PCI_QUIRK(0x103c, 0x8c17, "HP Spectre 16", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x103c, 0x8c21, "HP Pavilion Plus Laptop 14-ey0XXX", ALC245_FIXUP_HP_X360_MUTE_LEDS),
> +	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),

Ditto.


thanks,

Takashi

