Return-Path: <stable+bounces-87025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB89A5E6B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F901B22F02
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C521E1022;
	Mon, 21 Oct 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BC4uTCmn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ut5wPLcl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BC4uTCmn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ut5wPLcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821991E1C02;
	Mon, 21 Oct 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498771; cv=none; b=CFfc+n8ZiVtBaahoeBWsLNxT71AwjqoWjtN4QQ0HwMTh3VgfoSRtnP93avjwS5QtuFxXN1kljgkf9Ovok9+Cnp708hv8Uf4W7deX4sLM7RS2oZoVfyw9FfFpwd6x2y8R21ABBQX2pbgwsxlB0G6tYjn/k+qsLBwo/JEJuKpce8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498771; c=relaxed/simple;
	bh=vZ3bpzFkblWGaWwjbJan36UvIgPEMxcOM/+Rc3CAZPQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/1qCx83USoHPZ/Kqn25cBFlJIAA9IGfkoXkSxiWD8MT6bP1D7y7fovYRxUMTESOs3MILrZSE5vYsWrz5lnSB6/E7gI40uHIq0dZt1WEC5JhxOUJxPb/cPnxSlzHxAKh/z8k9fnJYZKYKv0mN79yI4I52b3wzX86xStCsVibfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BC4uTCmn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ut5wPLcl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BC4uTCmn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ut5wPLcl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80BB021DFF;
	Mon, 21 Oct 2024 08:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729498767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPRZIf9HxynWtv8EN+SFglP1wFbTmjQIxhEX8jNKiQ=;
	b=BC4uTCmn2DrNjoKU5jWdMxE2Zad5GxzX6iYbNC1tqYKvKAYM2LF4fDO/gd1xVLQxaljz2V
	wb3J/D1wUXxCgTanEB+OLKv0r7w7vCqmxVhgx0gmOYuNiLca2fuuVlGNxRtmLB/xvNIcNo
	SPvetAVPnwB1uGZxbQAvjkWQRxY7ifU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729498767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPRZIf9HxynWtv8EN+SFglP1wFbTmjQIxhEX8jNKiQ=;
	b=ut5wPLcl33BKw4sQRYX4xpX+fOxtHbzk5sNk5Hs5KIswxhar+nPKncLJOtKopDKVnyKs9g
	86/MwxvCXdfx6TAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BC4uTCmn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ut5wPLcl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729498767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPRZIf9HxynWtv8EN+SFglP1wFbTmjQIxhEX8jNKiQ=;
	b=BC4uTCmn2DrNjoKU5jWdMxE2Zad5GxzX6iYbNC1tqYKvKAYM2LF4fDO/gd1xVLQxaljz2V
	wb3J/D1wUXxCgTanEB+OLKv0r7w7vCqmxVhgx0gmOYuNiLca2fuuVlGNxRtmLB/xvNIcNo
	SPvetAVPnwB1uGZxbQAvjkWQRxY7ifU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729498767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3lPRZIf9HxynWtv8EN+SFglP1wFbTmjQIxhEX8jNKiQ=;
	b=ut5wPLcl33BKw4sQRYX4xpX+fOxtHbzk5sNk5Hs5KIswxhar+nPKncLJOtKopDKVnyKs9g
	86/MwxvCXdfx6TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 418E4139E0;
	Mon, 21 Oct 2024 08:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xRfGDo8OFmfGYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 08:19:27 +0000
Date: Mon, 21 Oct 2024 10:20:27 +0200
Message-ID: <87o73d6f5g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Dean Matthew Menezes
	<dean.menezes@utexas.edu>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Jaroslav Kysela
	<perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux Sound System
	<linux-sound@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <325719ad24c24f1faee12a4cdceec87b@realtek.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
	<87cyjzrutw.wl-tiwai@suse.de>
	<CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
	<87ttd8jyu3.wl-tiwai@suse.de>
	<CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
	<87h697jl6c.wl-tiwai@suse.de>
	<CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
	<87ed4akd2a.wl-tiwai@suse.de>
	<87bjzekcva.wl-tiwai@suse.de>
	<CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
	<877ca2j60l.wl-tiwai@suse.de>
	<325719ad24c24f1faee12a4cdceec87b@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 80BB021DFF
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 21 Oct 2024 09:56:32 +0200,
Kailang wrote:
> 
> 
> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Monday, October 21, 2024 2:59 PM
> > To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> > Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> > stable@vger.kernel.org; regressions@lists.linux.dev; Jaroslav Kysela
> > <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Linux Sound System
> > <linux-sound@vger.kernel.org>; Greg KH <gregkh@linuxfoundation.org>
> > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > 
> > 
> > External mail.
> > 
> > 
> > 
> > On Mon, 21 Oct 2024 03:30:13 +0200,
> > Dean Matthew Menezes wrote:
> > >
> > > I can confirm that the original fix does not bring back the speaker
> > > output.  I have attached both outputs for alsa-info.sh
> > 
> > Thanks!  This confirms that the only significant difference is the COEF data
> > between working and patched-non-working cases.
> > 
> > Kailang, I guess this model (X1 Carbon Gen 12) isn't with ALC1318, hence your
> > quirk rather influences badly.  Or may the GPIO3 workaround have the similar
> > effect?
> 
> No, I check with our AE. It's ALC1318 include.
> And This fixed was testing with Lenovo.
> 
> > 
> > As of now, the possible fix is to simply remove the quirk entries for ALC1318.
> > But I'd need to know which model was targeted for your original fix in commit
> > 1e707769df07 and whether the regressed model is with ALC1318.
> 
> +	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
> +	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
> 
> Yes, this model include ALC1318.

Thanks for confirmation.  So, from the Realtek side, the current code
looks correct.

Dean, is the BIOS firmware up-to-date on your device?  Just to be
sure.


Takashi

