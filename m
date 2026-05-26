Return-Path: <stable+bounces-254398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCtAA3vPFWrkcAcAu9opvQ
	(envelope-from <stable+bounces-254398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:51:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A165DA18F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B77E4304EC20
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895C3CB91C;
	Tue, 26 May 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2G34wOTo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Phng+Iuj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jVKokxCV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1twmVmzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A23CC7CE
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813757; cv=none; b=pAKA4kn14cefLN6+/ulCi89UDnZpI2C2S1S9zY0AKqXLyEd6I+tzvt8BW7Nc5wBkouQDSUlYzyJie4OtkOv/p5tcsD77eS+Z7QYbNkeU0PTKwRMVmmKIle+3TROglcMc/ZaAM5W6xcajClj55G9UVZbk9e6dAbplRV8orCLK5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813757; c=relaxed/simple;
	bh=Hob40qwKvUWnDU1XH0U6FXT13Xi/0pKs2EI5aCqRit0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtwFZCzW9xcZEnZ6U2mrOub1XEES8daG/z/ZDLP1/Ixf6CMIbmPpaJo7BpjZlCSeiyQTuf1RKYOmHeARNdR95Sh9H/JBiUqrQKyJGzuy4b8HQn0KuocLnVej8GGka3dJkNH90eUg1RUh0pxOGg/WrABTHqywa0MwU55vwyxcp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2G34wOTo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Phng+Iuj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jVKokxCV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1twmVmzp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 594E16B024;
	Tue, 26 May 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779813754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+eCAIvWr7aBkrXJc7ki1VVtMNpUSW/oiHZQLZvx7D3w=;
	b=2G34wOToGbiowbnJxIjwRxBDGpIG1S3cSk7EA5UXqPoeM4Dr931CC+nsaZzV8jv4fQd7BO
	wffkqdL9ShFFBtrlONRm6w0/1p++jKGnSg7wnFElVtjfOZzemAU66rglk9KH2uwpy5LuUi
	QrjTBK7K2MhjYFVHIGYnO2ycyQqL5vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779813754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+eCAIvWr7aBkrXJc7ki1VVtMNpUSW/oiHZQLZvx7D3w=;
	b=Phng+Iuj4dkDX5KUP/XXrco2qtKIL4v24lwNoCgOyNG1wFZCwxQtdP74Gu0WUFJB3KPt7O
	DY205Z9/9kGe1lCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779813750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+eCAIvWr7aBkrXJc7ki1VVtMNpUSW/oiHZQLZvx7D3w=;
	b=jVKokxCVA917BrMcLhzDcqhNo/wmt7mJSB3/1qCq+FRmO4GJ3MK9sfeIIlvhxkyOabpbsW
	oh4ESr3dPlpDeRAGHPbWCT2kApIod+BwzKRz6dSyKYbAuY5dmHqvQ8dh801dfvTqvGE2nT
	2AJd7uLWwle8TNj3FzjXM8xlwqPqyAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779813750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+eCAIvWr7aBkrXJc7ki1VVtMNpUSW/oiHZQLZvx7D3w=;
	b=1twmVmzpu/DAysSARcv+sooyBfpfD2Lnb6NV6Tt9AX1qaOjZsk/Vjy1w1fJUC9Y/VqdLio
	N57di0VBYZNiPLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09ECE5A2DC;
	Tue, 26 May 2026 16:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uzlEAXbNFWrqNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 May 2026 16:42:30 +0000
Date: Tue, 26 May 2026 18:42:29 +0200
Message-ID: <87cxyixgui.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: Re: [PATCH] ALSA: hda/hdmi: Use 'AC_PINSENSE_ELDV' to detect pinsense for Loongson
In-Reply-To: <87pl2ixmxj.wl-tiwai@suse.de>
References: <20260526111940.2347847-1-chenhuacai@loongson.cn>
	<87pl2ixmxj.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:mid,suse.de:dkim,loongson.cn:email]
X-Rspamd-Queue-Id: 21A165DA18F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:31:04 +0200,
Takashi Iwai wrote:
> 
> On Tue, 26 May 2026 13:19:40 +0200,
> Huacai Chen wrote:
> > 
> > Due to a hardware defect, for Loongson PCI HDMI devices with a reversion
> > ID of 2, the pin sense status must be determined via the ELD.
> > 
> > Add a codec flag, eld_jack_detect, to indicate this case, and do special
> > handlings in read_pin_sense().
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> > Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  include/sound/hda_codec.h    | 1 +
> >  sound/hda/codecs/hdmi/hdmi.c | 8 +++++++-
> >  sound/hda/common/jack.c      | 4 ++++
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> > index 24581080e26a..1a1fe7a904c3 100644
> > --- a/include/sound/hda_codec.h
> > +++ b/include/sound/hda_codec.h
> > @@ -259,6 +259,7 @@ struct hda_codec {
> >  	unsigned int forced_resume:1; /* forced resume for jack */
> >  	unsigned int no_stream_clean_at_suspend:1; /* do not clean streams at suspend */
> >  	unsigned int ctl_dev_id:1; /* old control element id build behaviour */
> > +	unsigned int eld_jack_detect:1;	/* Machine jack-detection by ELD */
> >  
> >  	unsigned long power_on_acct;
> >  	unsigned long power_off_acct;
> > diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
> > index f20d1715da62..423cd9f683c6 100644
> > --- a/sound/hda/codecs/hdmi/hdmi.c
> > +++ b/sound/hda/codecs/hdmi/hdmi.c
> > @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_NS_GPL(snd_hda_hdmi_acomp_init, "SND_HDA_CODEC_HDMI");
> >  enum {
> >  	MODEL_GENERIC,
> >  	MODEL_GF,
> > +	MODEL_LOONGSON,
> >  };
> >  
> >  static int generichdmi_probe(struct hda_codec *codec,
> > @@ -2302,6 +2303,11 @@ static int generichdmi_probe(struct hda_codec *codec,
> >  	if (id->driver_data == MODEL_GF)
> >  		codec->no_sticky_stream = 1;
> >  
> > +	if (id->driver_data == MODEL_LOONGSON) {
> > +		if (codec->bus && codec->bus->pci->revision == 0x2)
> > +			codec->eld_jack_detect = 1; /* Jack-detection by ELD */
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2319,7 +2325,7 @@ static const struct hda_codec_ops generichdmi_codec_ops = {
> >  /*
> >   */
> >  static const struct hda_device_id snd_hda_id_generichdmi[] = {
> > -	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_GENERIC),
> > +	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_LOONGSON),
> >  	HDA_CODEC_ID_MODEL(0x10951390, "SiI1390 HDMI",		MODEL_GENERIC),
> >  	HDA_CODEC_ID_MODEL(0x10951392, "SiI1392 HDMI",		MODEL_GENERIC),
> >  	HDA_CODEC_ID_MODEL(0x11069f84, "VX11 HDMI/DP",		MODEL_GENERIC),
> > diff --git a/sound/hda/common/jack.c b/sound/hda/common/jack.c
> > index 98ba1c4d5ba4..1f0ebf9cd151 100644
> > --- a/sound/hda/common/jack.c
> > +++ b/sound/hda/common/jack.c
> > @@ -58,6 +58,10 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid, int dev_id)
> >  				  AC_VERB_GET_PIN_SENSE, dev_id);
> >  	if (codec->inv_jack_detect)
> >  		val ^= AC_PINSENSE_PRESENCE;
> > +	if (codec->eld_jack_detect) {
> > +		val &= ~AC_PINSENSE_PRESENCE;
> > +		val |= !!(val & AC_PINSENSE_ELDV) << 31;
> > +	}
> 
> IMO it's worth for a comment in the above; basically it's faking the
> AC_PINSENSE_PRESENCE from AC_PINSENSE_ELDV bit, which explains the
> magic shift number.

... or an idiomatic form would be even simpler & safer:

		if (val & AC_PINSENSE_ELDV)
			val |= AC_PINSENSE_PRESENCE;
		else
			val &= ~AC_PINSENSE_PRESENCE;


thanks,

Takashi

