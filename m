Return-Path: <stable+bounces-111279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5ECA22CE0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7411889589
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5D1DD0C7;
	Thu, 30 Jan 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bVLr0rz9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sz8gwfPi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bVLr0rz9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sz8gwfPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE08B660;
	Thu, 30 Jan 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738239483; cv=none; b=icjfhvtRd5LKV3yE2qrGA+fAfKetNEfyHPtcKbAMFhaevvsgeBgCF4ayTXUBmIX52ZwmHA/b/gbyjYf+VvPULLhFVUqcF4Xg/gqTchHVVzVGTmfLysd3bF3hF2WvZGc9JeS/ZkR8seRfSNRiCTFXwB95DXh1YYGpwsnOILvaBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738239483; c=relaxed/simple;
	bh=eBCumglt0TetpjNL+UrfdO72Yn3p3DcyzzclBolwRGM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNbHDZQVH1j5B/Kcfkg0E0XhH5Lv56Md5gSY7BvtE6jU6gqaZhrQXHTQGNHVTXzL8heAba2fa4Oo85qTSXQH6q65U3cRQDWl7a2ukOQhOlxFilhjyF8tn9vJpV2DFk0QD9HexEuf/31ccP5cXh80UEWA9MqXUTUUkcTU5+gQa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bVLr0rz9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sz8gwfPi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bVLr0rz9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sz8gwfPi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F18D1F38D;
	Thu, 30 Jan 2025 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738239479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sejUYlrrTXsI0gc02PpSYznxXIlwOmNfaWPSCJziZWw=;
	b=bVLr0rz9p+67XUXjRU/hLAYzXwBbcc+tMP/rP+UuwQJq+BZSonv5w7TBODpH/vJLuNpKC/
	pyGRJTJ9omy7C29h1d8bXZaV7bSJscDn4tKYdzhJIZBfIq4IkVHg8LXPUavB9d5bghA3RP
	ULIE9LwAZ8WXK9r8q6uUxgBc4fybmQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738239479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sejUYlrrTXsI0gc02PpSYznxXIlwOmNfaWPSCJziZWw=;
	b=sz8gwfPitXjG2z6+a8vcWZe2+aiKsVU/ETikaJXIO2rFTHVxLMX1LOJmZXHwN+U61/CT2/
	BYWOiUwv0uNRKJCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bVLr0rz9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sz8gwfPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738239479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sejUYlrrTXsI0gc02PpSYznxXIlwOmNfaWPSCJziZWw=;
	b=bVLr0rz9p+67XUXjRU/hLAYzXwBbcc+tMP/rP+UuwQJq+BZSonv5w7TBODpH/vJLuNpKC/
	pyGRJTJ9omy7C29h1d8bXZaV7bSJscDn4tKYdzhJIZBfIq4IkVHg8LXPUavB9d5bghA3RP
	ULIE9LwAZ8WXK9r8q6uUxgBc4fybmQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738239479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sejUYlrrTXsI0gc02PpSYznxXIlwOmNfaWPSCJziZWw=;
	b=sz8gwfPitXjG2z6+a8vcWZe2+aiKsVU/ETikaJXIO2rFTHVxLMX1LOJmZXHwN+U61/CT2/
	BYWOiUwv0uNRKJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5991F1396E;
	Thu, 30 Jan 2025 12:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tPFWFfdtm2c+SQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jan 2025 12:17:59 +0000
Date: Thu, 30 Jan 2025 13:17:59 +0100
Message-ID: <87o6zo5wco.wl-tiwai@suse.de>
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
In-Reply-To: <Z5tbealYSvl7S72l-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
	<871pwl7evv.wl-tiwai@suse.de>
	<Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
	<87sep060f4.wl-tiwai@suse.de>
	<Z5tbealYSvl7S72l-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7F18D1F38D
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,linuxfoundation.org,kernel.org,myyahoo.com,pengutronix.de,quicinc.com,ti.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 30 Jan 2025 11:59:05 +0100,
John Keeping wrote:
> 
> On Thu, Jan 30, 2025 at 11:50:07AM +0100, Takashi Iwai wrote:
> > On Wed, 29 Jan 2025 18:31:35 +0100,
> > John Keeping wrote:
> > > 
> > > On Wed, Jan 29, 2025 at 05:40:04PM +0100, Takashi Iwai wrote:
> > > > On Wed, 29 Jan 2025 17:05:19 +0100,
> > > > John Keeping wrote:
> > > > > 
> > > > > In the two loops before setting the MIDIStreaming descriptors,
> > > > > ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> > > > > ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> > > > > But the counts and lengths are set the other way round in the
> > > > > descriptors.
> > > > > 
> > > > > Fix the descriptors so that the bNumEmbMIDIJack values and the
> > > > > descriptor lengths match the number of entries populated in the trailing
> > > > > arrays.
> > > > 
> > > > Are you sure that it's a correct change?
> > > > 
> > > > IIUC, the in_ports and out_ports parameters are for external IN and
> > > > OUT jacks, where an external OUT jack is connected to an embedded IN
> > > > jack, and an external IN jack is connected to an embedded OUT jack.
> > > 
> > > I think it depends how the in_ports and out_ports values in configfs are
> > > interpreted.  However, the case where in_ports != out_ports has been
> > > broken since these files were added!
> > > 
> > > Without this change, setting in_ports=4 out_ports=2 we end up with:
> > > 
> > >       Endpoint Descriptor:
> > >         [...]
> > >         bEndpointAddress     0x01  EP 1 OUT
> > >         [...]
> > >         MIDIStreaming Endpoint Descriptor:
> > >           bLength                 8
> > >           bDescriptorType        37
> > >           bDescriptorSubtype      1 (Invalid)
> > >           bNumEmbMIDIJack         4
> > >           baAssocJackID( 0)       9
> > >           baAssocJackID( 1)      11
> > >           baAssocJackID( 2)       9
> > >           baAssocJackID( 3)       0
> > >       Endpoint Descriptor:
> > >         [...]
> > >         bEndpointAddress     0x81  EP 1 IN
> > >         [...]
> > >         MIDIStreaming Endpoint Descriptor:
> > >           bLength                 6
> > >           bDescriptorType        37
> > >           bDescriptorSubtype      1 (Invalid)
> > >           bNumEmbMIDIJack         2
> > >           baAssocJackID( 0)       2
> > >           baAssocJackID( 1)       4
> > > 
> > > Note that baAssocJackID values 2 and 3 on the OUT endpoint are wrong.
> > > 
> > > From the same config, the jack definitions are:
> > > 
> > > 	1:  IN  External
> > > 	2:  OUT Embedded, source 1
> > > 	3:  IN  External
> > > 	4:  OUT Embedded, source 3
> > > 	5:  IN  External
> > > 	6:  OUT Embedded, source 5
> > > 	7:  IN  External
> > > 	8:  OUT Embedded, source 7
> > > 
> > > 	9:  IN  Embedded
> > > 	10: OUT External, source 9
> > > 	11: IN  Embedded
> > > 	12: OUT External, source 11
> > > 
> > > So it seems that the first 2 entries in each endpoint list are correct.
> > > For the OUT endpoint, jacks 9 and 11 are embedded IN jacks and for the
> > > IN endpoint, jacks 2 and 4 are embedded OUT jacks.
> > > 
> > > The problem is that the OUT endpoint lists two extra invalid jack IDs
> > > and the IN endpoint should list jacks 6 and 8 but does not.
> > > 
> > > After applying this patch, the endpoint descriptors for the same config
> > > are:
> > > 
> > >       Endpoint Descriptor:
> > >         [...]
> > >         bEndpointAddress     0x01  EP 1 OUT
> > >         [...]
> > >         MIDIStreaming Endpoint Descriptor:
> > >           bLength                 6
> > >           bDescriptorType        37
> > >           bDescriptorSubtype      1 (Invalid)
> > >           bNumEmbMIDIJack         2
> > >           baAssocJackID( 0)       9
> > >           baAssocJackID( 1)      11
> > >       Endpoint Descriptor:
> > >         [...]
> > >         bEndpointAddress     0x81  EP 1 IN
> > >         [...]
> > >         MIDIStreaming Endpoint Descriptor:
> > >           bLength                 8
> > >           bDescriptorType        37
> > >           bDescriptorSubtype      1 (Invalid)
> > >           bNumEmbMIDIJack         4
> > >           baAssocJackID( 0)       2
> > >           baAssocJackID( 1)       4
> > >           baAssocJackID( 2)       6
> > >           baAssocJackID( 3)       8
> > > 
> > > Which lists all the jack IDs where they should be.
> > 
> > Hmm, I don't get your point.  The embedded IN is paired with the
> > external OUT.  That's the intended behavior, no?
> 
> Yes, all the endpoint assignments are correct - when they appear in the
> lists!
> 
> The issue is setting bNumEmbMIDIJack and bLength in the MIDIStreaming
> Endpoint Descriptors.  Without this patch these are set the wrong way
> round so either some ports do not appear or there are bogus entries
> containing uninitialized stack memory.

OK, now point taken.  The main problem here is the definition of
in_port and out_ports aren't really clear.  If in_ports really
corresponds to external IN jacks, then we may correct rather like:

--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -968,7 +968,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 		midi_function[i++] = (struct usb_descriptor_header *) out_emb;
 
 		/* link it to the endpoint */
-		ms_in_desc.baAssocJackID[n] = out_emb->bJackID;
+		ms_out_desc.baAssocJackID[n] = out_emb->bJackID;
 	}
 
 	/* configure the external OUT jacks, each linked to an embedded IN jack */
@@ -996,7 +996,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 		midi_function[i++] = (struct usb_descriptor_header *) out_ext;
 
 		/* link it to the endpoint */
-		ms_out_desc.baAssocJackID[n] = in_emb->bJackID;
+		ms_in_desc.baAssocJackID[n] = in_emb->bJackID;
 	}
 
 	/* configure the endpoint descriptors ... */

OTOH, the current code will make the actual appearance other way
round, likely more confusing.  So I believe your fix makes sense.

But it'd be helpful to extend the description a bit more to clarify
this confusion.  I guess this confusion came from the association
between the embedded and external jacks, and the patch corrects it.


thanks,

Takashi

> 
> 
> 
> Regards,
> John
> 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> > > > > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> > > > > ---
> > > > >  drivers/usb/gadget/function/f_midi.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > > > > index 837fcdfa3840f..6cc3d86cb4774 100644
> > > > > --- a/drivers/usb/gadget/function/f_midi.c
> > > > > +++ b/drivers/usb/gadget/function/f_midi.c
> > > > > @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
> > > > >  	}
> > > > >  
> > > > >  	/* configure the endpoint descriptors ... */
> > > > > -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > > -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> > > > > +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > > +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
> > > > >  
> > > > > -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > > -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> > > > > +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > > +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
> > > > >  
> > > > >  	/* ... and add them to the list */
> > > > >  	endpoint_descriptor_index = i;
> > > > > -- 
> > > > > 2.48.1
> > > > > 
> > > > > 

