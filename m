Return-Path: <stable+bounces-92976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1C9C83D3
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F35F1F2373F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1D1F26EA;
	Thu, 14 Nov 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DNq9/UtQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z7uc+JA6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DNq9/UtQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z7uc+JA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B351EBFE1;
	Thu, 14 Nov 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568216; cv=none; b=g6IDdrte/5pOio12F9e1MVmL7OAK62dXLrpFhjNHIRH+uOnYNDgCT9hVLzGpgKxU6DQt2/OCtenxNlokQc808xIhtZmSM+XqnkyrffZuoAPndsAR/m1WcCH9+y9TDHY89wmBRiGFemdh/K8WRYmt/paJzyDwc3kCjeVYIDArapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568216; c=relaxed/simple;
	bh=/MC70/yGLRGiAPMGIyUXF4HJjU0ZLatDt65DtIX6yhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYDD0oYmnNOXILoQXNxyRstZpyA9JcEhHH0b93fKxgRdHduIxrPMuh+C6MCNPdqaFF3cuMQr1utbGavdXM11oQwWkzE1Nqr7b0/tJVMMjYEO3bjdLgcaQkjZPOZ4pYdfQlhGVt5bVEVncB3hEZGtUtBjdHlPEVNtQ9mu7crK0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DNq9/UtQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z7uc+JA6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DNq9/UtQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z7uc+JA6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C212121896;
	Thu, 14 Nov 2024 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYZ9EQZ2ozB5YcOlyVuGOdrWSmtrCiQ05fGLgB0I9LM=;
	b=DNq9/UtQzVstRl0NrqIUj6fTy2JniGle6gUk48QFimAOazKOHuRYxxCj2GNNtl1X7S9s9T
	jfMWnlNWqngcOSaQZJyq77plyLBbx9mWcxVjRdV/lRzJelYhY5H+Mvt7tQEclRibXY1GeD
	+3baufFyXEQ8NLrBO+v+8RlaNQ8LYCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYZ9EQZ2ozB5YcOlyVuGOdrWSmtrCiQ05fGLgB0I9LM=;
	b=z7uc+JA6/ga0vbKCiFiF3l0JfsGtzVk1BoxKXhRkZFR2k/qksPomECoQiPWGg6m0nTXxlG
	tGGI5hcJGnfIlxDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DNq9/UtQ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z7uc+JA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYZ9EQZ2ozB5YcOlyVuGOdrWSmtrCiQ05fGLgB0I9LM=;
	b=DNq9/UtQzVstRl0NrqIUj6fTy2JniGle6gUk48QFimAOazKOHuRYxxCj2GNNtl1X7S9s9T
	jfMWnlNWqngcOSaQZJyq77plyLBbx9mWcxVjRdV/lRzJelYhY5H+Mvt7tQEclRibXY1GeD
	+3baufFyXEQ8NLrBO+v+8RlaNQ8LYCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYZ9EQZ2ozB5YcOlyVuGOdrWSmtrCiQ05fGLgB0I9LM=;
	b=z7uc+JA6/ga0vbKCiFiF3l0JfsGtzVk1BoxKXhRkZFR2k/qksPomECoQiPWGg6m0nTXxlG
	tGGI5hcJGnfIlxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E1BB13A17;
	Thu, 14 Nov 2024 07:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oNumHVSiNWdgXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Nov 2024 07:10:12 +0000
Date: Thu, 14 Nov 2024 08:10:12 +0100
Message-ID: <87plmythnv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wade Wang <wade.wang@hp.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	linuxhid@cosmicgizmosystems.com,
	wangdicheng@kylinos.cn,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly Headsets
In-Reply-To: <20241114061553.1699264-1-wade.wang@hp.com>
References: <20241114061553.1699264-1-wade.wang@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C212121896
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,kl.wtf,cosmicgizmosystems.com,kylinos.cn,outlook.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024 07:15:53 +0100,
Wade Wang wrote:
> 
> Add a control name fixer for all headsets with VID 0x047F.
> 
> Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
> Signed-off-by: Wade Wang <wade.wang@hp.com>

Thanks for the patch, but from the description, it's not clear what
this patch actually does.  What's the control name fixer and how it
behaves?

Also, are you sure that this can be applied to all devices of
Plantonics & co?  Including the devices in future.  I thought they had
so many different models.

Last but not least, __build_feature_ctl() is no right place to add the
vendor-specific stuff.  There is already a common place in
mixer_quirks.c, e.g. snd_usb_mixer_fu_apply_quirk().  Please move the
fix-up to the appropriate place.


thanks,

Takashi

> ---
>  sound/usb/mixer.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index bd67027c7677..110d43ace4d8 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1664,6 +1664,33 @@ static void check_no_speaker_on_headset(struct snd_kcontrol *kctl,
>  	snd_ctl_rename(card, kctl, "Headphone");
>  }
>  
> +static void fix_plt_control_name(struct snd_kcontrol *kctl)
> +{
> +	static const char * const names_to_remove[] = {
> +		"Earphone",
> +		"Microphone",
> +		"Receive",
> +		"Transmit",
> +		NULL
> +	};
> +	const char * const *n2r;
> +	char *dst, *src;
> +	size_t len;
> +
> +	for (n2r = names_to_remove; *n2r; ++n2r) {
> +		dst = strstr(kctl->id.name, *n2r);
> +		if (dst != NULL) {
> +			src = dst + strlen(*n2r);
> +			len = strlen(src) + 1;
> +			if ((char *)kctl->id.name != dst && *(dst - 1) == ' ')
> +				--dst;
> +			memmove(dst, src, len);
> +		}
> +	}
> +	if (kctl->id.name[0] == '\0')
> +		strscpy(kctl->id.name, "Headset", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> +}
> +
>  static const struct usb_feature_control_info *get_feature_control_info(int control)
>  {
>  	int i;
> @@ -1780,6 +1807,9 @@ static void __build_feature_ctl(struct usb_mixer_interface *mixer,
>  		if (!mapped_name)
>  			check_no_speaker_on_headset(kctl, mixer->chip->card);
>  
> +		if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f)
> +			fix_plt_control_name(kctl);
> +
>  		/*
>  		 * determine the stream direction:
>  		 * if the connected output is USB stream, then it's likely a
> -- 
> 2.43.0
> 

