Return-Path: <stable+bounces-111194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFEA221E4
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446763A30AC
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E31DE8AD;
	Wed, 29 Jan 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztR+5l8G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="br4DU8Kf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztR+5l8G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="br4DU8Kf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE062FB6;
	Wed, 29 Jan 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168808; cv=none; b=pVQ0KKXwFF4tewopy8AMhc88SkB5mfeHCRk8G66gHCXLSbdHYeJLvpxk4jocEfQYglnIv/2aOOPHnREJmbl54chVMwOL9JM8wfPFY6jZWbWWzNG5GmauYc46OXiGqRjic+bRwpi1cp1Axozw6ohYo9FKhU9hF/z3WAfaJrewIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168808; c=relaxed/simple;
	bh=MnUEOgegCz6U8wUuh36lSaq+5+tmtDZenlvefYwpL4A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C09iJfwinb30teeAL2jyXRdfEMWI0L8pKFoTFwD8gCS+Df5nzxvH/1/6c19hI8B5kFvqdoulCgitlFw/IW1z2juvlCkD0TzllV+Z9pIxdoEx4xvgIl9gzaakWzvwAD5LhB8d96Lb3RxAzusiBzI/eUPB9g483rnltXVZ40BmHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztR+5l8G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=br4DU8Kf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztR+5l8G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=br4DU8Kf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B05621F383;
	Wed, 29 Jan 2025 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738168804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9rYHt8TLqvyqM2twnKirOe1ax3bJCcWtDx3u+1OAS8=;
	b=ztR+5l8GkzH59tC0L/EHfmHu1aFHdw6f3gCGZtoOIxHPlwJ5SYC/PlNmKsoKMifnrvP+RS
	Si3jQBR17SzBwPkW/dKD3zaYYq3L89kxIz/PRL4+IxAqjphwk2QUy8WE2uHFXZroGrC0HQ
	dRqfMLhhacgVcebMVX7LsK2Znp4Nwk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738168804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9rYHt8TLqvyqM2twnKirOe1ax3bJCcWtDx3u+1OAS8=;
	b=br4DU8KffG7YpZatMcZC3FBuJ6Q5BA86CnSqoincqRYS7jGloYDKXZ1oq6HahGmlWR2Pl/
	PLrG/LjfBxR94iAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738168804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9rYHt8TLqvyqM2twnKirOe1ax3bJCcWtDx3u+1OAS8=;
	b=ztR+5l8GkzH59tC0L/EHfmHu1aFHdw6f3gCGZtoOIxHPlwJ5SYC/PlNmKsoKMifnrvP+RS
	Si3jQBR17SzBwPkW/dKD3zaYYq3L89kxIz/PRL4+IxAqjphwk2QUy8WE2uHFXZroGrC0HQ
	dRqfMLhhacgVcebMVX7LsK2Znp4Nwk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738168804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9rYHt8TLqvyqM2twnKirOe1ax3bJCcWtDx3u+1OAS8=;
	b=br4DU8KffG7YpZatMcZC3FBuJ6Q5BA86CnSqoincqRYS7jGloYDKXZ1oq6HahGmlWR2Pl/
	PLrG/LjfBxR94iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663C2137D2;
	Wed, 29 Jan 2025 16:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwnIF+RZmmcPGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 16:40:04 +0000
Date: Wed, 29 Jan 2025 17:40:04 +0100
Message-ID: <871pwl7evv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Abdul Rahim <abdul.rahim@myyahoo.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Felipe Balbi <balbi@ti.com>,
	Daniel Mack <zonque@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
In-Reply-To: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,kernel.org,myyahoo.com,pengutronix.de,quicinc.com,ti.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 29 Jan 2025 17:05:19 +0100,
John Keeping wrote:
> 
> In the two loops before setting the MIDIStreaming descriptors,
> ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> But the counts and lengths are set the other way round in the
> descriptors.
> 
> Fix the descriptors so that the bNumEmbMIDIJack values and the
> descriptor lengths match the number of entries populated in the trailing
> arrays.

Are you sure that it's a correct change?

IIUC, the in_ports and out_ports parameters are for external IN and
OUT jacks, where an external OUT jack is connected to an embedded IN
jack, and an external IN jack is connected to an embedded OUT jack.


thanks,

Takashi

> 
> Cc: stable@vger.kernel.org
> Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3840f..6cc3d86cb4774 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  	}
>  
>  	/* configure the endpoint descriptors ... */
> -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
>  
> -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
>  
>  	/* ... and add them to the list */
>  	endpoint_descriptor_index = i;
> -- 
> 2.48.1
> 
> 

