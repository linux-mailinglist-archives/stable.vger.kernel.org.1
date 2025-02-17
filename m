Return-Path: <stable+bounces-116578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA560A382F1
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D9318966D4
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE621A43B;
	Mon, 17 Feb 2025 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AolZ5ruY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6e4C5VDq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AolZ5ruY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6e4C5VDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FD218842
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795112; cv=none; b=MskUlPJs6iGxkBk+9Yxfy3uJBArtij446a4Tqhw0I4Ncp01zZJYRo2RNfhSErFQc+izP3MC9qeoiQDo5cnG05IIbylmldlMpSLpPH1vi+hJZpA3TKaCBU6Ic+4TELyuV5HbXEpmpsDtQ7yNp8Ht3tvWI4MN2ALkIahZGWgjA+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795112; c=relaxed/simple;
	bh=+t0qGxxtqzrYtFCipvBO32Mt9CH1ALgwJrpUjWHROEw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUn1a922CaVgiFOKvvu5+ycSaVGeXdVzmvg7sPjsGXH0jmqA4lfapTmsG6Udfh5ZBBUcPeKF3BHLgRJrodEi/h6DUzQNy41p9UTB0LfR4yYwJ8GstsmcQItTWwDG5523yFMn7MQy0WwLDhR3vHAVHIJJ5JZT+se0C1mBVjHjFME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AolZ5ruY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6e4C5VDq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AolZ5ruY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6e4C5VDq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2F681F769;
	Mon, 17 Feb 2025 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739795108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78WiRqFhSM4GpKTwMR+ZuF2fUlXZGPW6X27NqjQyaFU=;
	b=AolZ5ruYI/Gg+2xxK5lQxUMpN4duKCuobf2o786Hsfp/b/MYteQHvbNmpILiEfIL59PbSo
	rcwH2UJ/IfrafHRFgYjXRXOEmDeZpot8RO2xVQplMZMm+8SoOElTSyS0eVoaTjXjV3oPcM
	eNt8RawrTAxA7MtsAxUgPs4EY6VqvEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739795108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78WiRqFhSM4GpKTwMR+ZuF2fUlXZGPW6X27NqjQyaFU=;
	b=6e4C5VDqP8VL5p+IpFghpJVYtoZ7WsUuZjiBHgxtOfuFvFjhik35lu99d4La9WtSMGHs7U
	GM/Zk5wEGJ5iekCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AolZ5ruY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6e4C5VDq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739795108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78WiRqFhSM4GpKTwMR+ZuF2fUlXZGPW6X27NqjQyaFU=;
	b=AolZ5ruYI/Gg+2xxK5lQxUMpN4duKCuobf2o786Hsfp/b/MYteQHvbNmpILiEfIL59PbSo
	rcwH2UJ/IfrafHRFgYjXRXOEmDeZpot8RO2xVQplMZMm+8SoOElTSyS0eVoaTjXjV3oPcM
	eNt8RawrTAxA7MtsAxUgPs4EY6VqvEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739795108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78WiRqFhSM4GpKTwMR+ZuF2fUlXZGPW6X27NqjQyaFU=;
	b=6e4C5VDqP8VL5p+IpFghpJVYtoZ7WsUuZjiBHgxtOfuFvFjhik35lu99d4La9WtSMGHs7U
	GM/Zk5wEGJ5iekCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39DF8133F9;
	Mon, 17 Feb 2025 12:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7WKhCqQqs2efdwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Feb 2025 12:25:08 +0000
Date: Mon, 17 Feb 2025 13:25:03 +0100
Message-ID: <877c5o92sg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Veness <john-linux@pelago.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED
In-Reply-To: <2fb55d48-6991-4a42-b591-4c78f2fad8d7@pelago.org.uk>
References: <2fb55d48-6991-4a42-b591-4c78f2fad8d7@pelago.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B2F681F769
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pelago.org.uk:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 17 Feb 2025 13:15:50 +0100,
John Veness wrote:
> 
> Allows the LED on the dedicated mute button on the HP ProBook 450 G4
> laptop to change colour correctly.
> 
> Signed-off-by: John Veness <john-linux@pelago.org.uk>
> ---
> Re-submitted with correct tabs (I hope!)

Now the patch is cleanly applicable, so I took now.
But, the Cc-to-stable should have been put in the patch itself (around
your Signed-off-by line).  I put it locally.


thanks,

Takashi

> 
>  sound/pci/hda/patch_conexant.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 4985e72b9..34874039a 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -1090,6 +1090,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
>  	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
>  	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
> +	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
>  	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
>  	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
> -- 
> 2.48.1

