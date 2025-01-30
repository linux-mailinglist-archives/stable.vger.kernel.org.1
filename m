Return-Path: <stable+bounces-111272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C1A22BEE
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1823A2FF8
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6A1BD9CD;
	Thu, 30 Jan 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hXebBeIl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hD7VuTgr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hXebBeIl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hD7VuTgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A51BBBFD;
	Thu, 30 Jan 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234220; cv=none; b=J24FgV64a/6761qKeL+LKwvP9iWzaXLSkz1HFS3iPn6FnBzwPpM6BQiGuiKZN6JbSBosVg48ltH17FC0EAnvtv5Igm01cMBH5PQqboVnha8lhreQuvi81Kzmys69NSnpFMx8+9d9Lxcj0RzB38GdEL4XG0NQJhjTQvJicHpWyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234220; c=relaxed/simple;
	bh=9tnIPb79lowIP2B4WO5y3JY64yOb0cXO4zNmsAdvlvI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca5wc1afZT/hrEsBm7SE08b7X8ITNx3zmfnChq0BzJZDF5odyjlXuXsLmLFKU8p1cOm34ouiXmXMaK5jFACJOaDKqpNXjp9ugcV8y2qeQLLI6SNyT9inyOAV1h7jBKSrRIrQF2LFif3enqrk18xFhta7Cx1zd2cnazJQrWmsZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hXebBeIl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hD7VuTgr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hXebBeIl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hD7VuTgr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE571F80F;
	Thu, 30 Jan 2025 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738234216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHG1Iw+GcqY7foqXFAxe0roPovyvY6qgmMssLYHu2O8=;
	b=hXebBeIl7+ccSi3XVKW8u6zZVFR1Eq7ZPxCqDB2msFR3r816BRw9YvqajD/pc3bFLSRULT
	7MhER/TQSN6AMfMbkymILFhwo5aSt5Vz5KWiMAkUdPMYgnNVf08bsId7iamm2sjGzQ57uN
	5QH9WDMNk4K5fUD1BZB50PxHF1Xlx7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738234216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHG1Iw+GcqY7foqXFAxe0roPovyvY6qgmMssLYHu2O8=;
	b=hD7VuTgr45ZEiBWSmw3eKnHPoNqh6HYievTH8r01AXKuNHZQjmq/8An/ujI30FRi9is4XG
	9aP4TWrsr1mkiKDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738234216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHG1Iw+GcqY7foqXFAxe0roPovyvY6qgmMssLYHu2O8=;
	b=hXebBeIl7+ccSi3XVKW8u6zZVFR1Eq7ZPxCqDB2msFR3r816BRw9YvqajD/pc3bFLSRULT
	7MhER/TQSN6AMfMbkymILFhwo5aSt5Vz5KWiMAkUdPMYgnNVf08bsId7iamm2sjGzQ57uN
	5QH9WDMNk4K5fUD1BZB50PxHF1Xlx7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738234216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHG1Iw+GcqY7foqXFAxe0roPovyvY6qgmMssLYHu2O8=;
	b=hD7VuTgr45ZEiBWSmw3eKnHPoNqh6HYievTH8r01AXKuNHZQjmq/8An/ujI30FRi9is4XG
	9aP4TWrsr1mkiKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42EF91364B;
	Thu, 30 Jan 2025 10:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZAW/D2hZm2fCMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jan 2025 10:50:16 +0000
Date: Thu, 30 Jan 2025 11:50:07 +0100
Message-ID: <87sep060f4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-usb@vger.kernel.org,
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
In-Reply-To: <Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
	<871pwl7evv.wl-tiwai@suse.de>
	<Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,linuxfoundation.org,kernel.org,myyahoo.com,pengutronix.de,quicinc.com,ti.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 29 Jan 2025 18:31:35 +0100,
John Keeping wrote:
> 
> On Wed, Jan 29, 2025 at 05:40:04PM +0100, Takashi Iwai wrote:
> > On Wed, 29 Jan 2025 17:05:19 +0100,
> > John Keeping wrote:
> > > 
> > > In the two loops before setting the MIDIStreaming descriptors,
> > > ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> > > ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> > > But the counts and lengths are set the other way round in the
> > > descriptors.
> > > 
> > > Fix the descriptors so that the bNumEmbMIDIJack values and the
> > > descriptor lengths match the number of entries populated in the trailing
> > > arrays.
> > 
> > Are you sure that it's a correct change?
> > 
> > IIUC, the in_ports and out_ports parameters are for external IN and
> > OUT jacks, where an external OUT jack is connected to an embedded IN
> > jack, and an external IN jack is connected to an embedded OUT jack.
> 
> I think it depends how the in_ports and out_ports values in configfs are
> interpreted.  However, the case where in_ports != out_ports has been
> broken since these files were added!
> 
> Without this change, setting in_ports=4 out_ports=2 we end up with:
> 
>       Endpoint Descriptor:
>         [...]
>         bEndpointAddress     0x01  EP 1 OUT
>         [...]
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (Invalid)
>           bNumEmbMIDIJack         4
>           baAssocJackID( 0)       9
>           baAssocJackID( 1)      11
>           baAssocJackID( 2)       9
>           baAssocJackID( 3)       0
>       Endpoint Descriptor:
>         [...]
>         bEndpointAddress     0x81  EP 1 IN
>         [...]
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 6
>           bDescriptorType        37
>           bDescriptorSubtype      1 (Invalid)
>           bNumEmbMIDIJack         2
>           baAssocJackID( 0)       2
>           baAssocJackID( 1)       4
> 
> Note that baAssocJackID values 2 and 3 on the OUT endpoint are wrong.
> 
> From the same config, the jack definitions are:
> 
> 	1:  IN  External
> 	2:  OUT Embedded, source 1
> 	3:  IN  External
> 	4:  OUT Embedded, source 3
> 	5:  IN  External
> 	6:  OUT Embedded, source 5
> 	7:  IN  External
> 	8:  OUT Embedded, source 7
> 
> 	9:  IN  Embedded
> 	10: OUT External, source 9
> 	11: IN  Embedded
> 	12: OUT External, source 11
> 
> So it seems that the first 2 entries in each endpoint list are correct.
> For the OUT endpoint, jacks 9 and 11 are embedded IN jacks and for the
> IN endpoint, jacks 2 and 4 are embedded OUT jacks.
> 
> The problem is that the OUT endpoint lists two extra invalid jack IDs
> and the IN endpoint should list jacks 6 and 8 but does not.
> 
> After applying this patch, the endpoint descriptors for the same config
> are:
> 
>       Endpoint Descriptor:
>         [...]
>         bEndpointAddress     0x01  EP 1 OUT
>         [...]
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 6
>           bDescriptorType        37
>           bDescriptorSubtype      1 (Invalid)
>           bNumEmbMIDIJack         2
>           baAssocJackID( 0)       9
>           baAssocJackID( 1)      11
>       Endpoint Descriptor:
>         [...]
>         bEndpointAddress     0x81  EP 1 IN
>         [...]
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 8
>           bDescriptorType        37
>           bDescriptorSubtype      1 (Invalid)
>           bNumEmbMIDIJack         4
>           baAssocJackID( 0)       2
>           baAssocJackID( 1)       4
>           baAssocJackID( 2)       6
>           baAssocJackID( 3)       8
> 
> Which lists all the jack IDs where they should be.

Hmm, I don't get your point.  The embedded IN is paired with the
external OUT.  That's the intended behavior, no?


Takashi

> 
> 
> Regards,
> John
> 
> > > Cc: stable@vger.kernel.org
> > > Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> > > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> > > ---
> > >  drivers/usb/gadget/function/f_midi.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > > index 837fcdfa3840f..6cc3d86cb4774 100644
> > > --- a/drivers/usb/gadget/function/f_midi.c
> > > +++ b/drivers/usb/gadget/function/f_midi.c
> > > @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
> > >  	}
> > >  
> > >  	/* configure the endpoint descriptors ... */
> > > -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> > > +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
> > >  
> > > -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> > > +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
> > >  
> > >  	/* ... and add them to the list */
> > >  	endpoint_descriptor_index = i;
> > > -- 
> > > 2.48.1
> > > 
> > > 

