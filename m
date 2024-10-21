Return-Path: <stable+bounces-87032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8939A5F87
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7AC1C2146D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9C1E25EC;
	Mon, 21 Oct 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/sjWRqW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PYOySvM4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rWAIu1+e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWITReUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE218200CD;
	Mon, 21 Oct 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500952; cv=none; b=AHKfAwssWK6o/k3hTknfvtZEsTR+lSp6WF5TRENDr0bXqsKjwbMexj5duNm0ylcbxiyUhGDW4hQFoCqvHbYMkt0wfmaXRfiW435ZN05lMzgphsTsJ8AhV+Rp6S4v6Jh1qOyxL8Op+yDj5H5hgdEGHz+r1eadm7/B7R8XTBrY/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500952; c=relaxed/simple;
	bh=76fz11Oe3oAYmd5xsOC93YnWfyUPM6piti0NZHxWffc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njFV8jzbb5td3qlODeoMLTddquPl/PE2UduSMK/4+NTDAzq7IAQ0jmzxsQOtRvKjxTS7M/1ntV3+XsZeBq7xwmYioB0hdeUpIxSf18JjHIPYc0N5gYCMaXlGCLH0XlBV5Nqfitei1Lw89firtnSUcs1caZleamvKX32mvouDSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/sjWRqW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PYOySvM4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rWAIu1+e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWITReUf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3AE71F832;
	Mon, 21 Oct 2024 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729500949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0UCHS3qdi6CAbkR64+pZQd67AsM6UsTqkrW7M62NZQ=;
	b=J/sjWRqWh2YnAAfj/5MwrCdgBTWswkX5GIwr4vSGXAEnIbZ9pGUF48PvzMWynAAb/urMqU
	aBQDSYSoERpUVU6uqui1czwGtE16ZTsxwhQkO+dKZhBlFiJ0p3d1T0MzbbPTrx+NB0hjsZ
	eul78adF8C2ZjK/MQcjtYor4fSMJrkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729500949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0UCHS3qdi6CAbkR64+pZQd67AsM6UsTqkrW7M62NZQ=;
	b=PYOySvM4lt4LrD9ZyCVBlNTOxIUqDke3TY8QoPUac56IGYOgrEUQbt6m/FIkfd2g5daL7A
	dU89RL3CkgCV9yDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729500948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0UCHS3qdi6CAbkR64+pZQd67AsM6UsTqkrW7M62NZQ=;
	b=rWAIu1+e0IjfvgT96+a1oKasd3fnm21yVFOrdH+gINPcRuUKi0C60bRu5i03/4wOI64DI0
	V3eZgLxasd/8LSz4NdLqBmj+6sTGXCXpz3iFIauMGMZyEazquVjw9xt/SGmKXxi5sUEdxc
	5Tcwwg1UsNrTVK9B4w5+gjNfzjmvoBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729500948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0UCHS3qdi6CAbkR64+pZQd67AsM6UsTqkrW7M62NZQ=;
	b=cWITReUfKTsTkGJSAzYuJxhcx+zlugVS/7WisqdfY7ku8jUi+w6v/iyQuNhNtbST6IrIw2
	MpvL6Ng5CZqJ70Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92748136DC;
	Mon, 21 Oct 2024 08:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FzdWIhQXFmd2bAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 08:55:48 +0000
Date: Mon, 21 Oct 2024 10:56:49 +0200
Message-ID: <87h6956dgu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Dean Matthew Menezes <dean.menezes@utexas.edu>,
	"stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH
	<gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
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
	<43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
	<87ldyh6eyu.wl-tiwai@suse.de>
	<18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 21 Oct 2024 10:38:48 +0200,
Kailang wrote:
> 
> But this platform need to assign model ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318.
> It has a chance to broken amp IC.

Yes, if X1 Carbon Gen 12 is indeed the targeted model of the fix, it
must be applied.  But we seem still missing some small piece...

> But I don't know why it doesn't have output from speaker.

The diff of COEF dump showed at NID 0x20:
(working)    Coeff 0x10: 0x8006
(broken)     Coeff 0x10: 0x8806
(working)    Coeff 0x46: 0x0004
(broken)     Coeff 0x46: 0x0404
It shouldn't be a problem to leave the bit 0x800 to COEF 0x10, I
suppose?

> Maybe could run hda_verb to get COEF value. To get NID 0x5A index 0 value.

Dean, please run hda-verb program (as root) like:
  hda-verb /dev/snd/hwC0D0 0x5a SET_COEF_INDEX 0x00
  hda-verb /dev/snd/hwC0D0 0x5a GET_PROC_COEF 0

and give the outputs on both working and non-working cases.

hda-verb should be included in alsa-utils.


Takashi

> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Monday, October 21, 2024 4:24 PM
> > To: Kailang <kailang@realtek.com>
> > Cc: Takashi Iwai <tiwai@suse.de>; Dean Matthew Menezes
> > <dean.menezes@utexas.edu>; stable@vger.kernel.org;
> > regressions@lists.linux.dev; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> > <tiwai@suse.com>; Linux Sound System <linux-sound@vger.kernel.org>; Greg
> > KH <gregkh@linuxfoundation.org>
> > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > 
> > 
> > External mail.
> > 
> > 
> > 
> > On Mon, 21 Oct 2024 10:19:53 +0200,
> > Kailang wrote:
> > >
> > > Change to below model.
> > > +     SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad",
> > ALC287_FIXUP_THINKPAD_I2S_SPK),
> > > +     SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad",
> > > + ALC287_FIXUP_THINKPAD_I2S_SPK),
> > >
> > > The speaker will have output. Right?
> > 
> > FWIW, that was what I asked in
> >   https://lore.kernel.org/87h697jl6c.wl-tiwai@suse.de
> > and Dean replied that the speaker worked with it.
> > (His reply missed Cc, so it didn't appear in the thread, unfortunately).
> > 
> > 
> > Takashi
> > 
> > > > -----Original Message-----
> > > > From: Takashi Iwai <tiwai@suse.de>
> > > > Sent: Monday, October 21, 2024 2:59 PM
> > > > To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> > > > Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> > > > stable@vger.kernel.org; regressions@lists.linux.dev; Jaroslav Kysela
> > > > <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Linux Sound System
> > > > <linux-sound@vger.kernel.org>; Greg KH <gregkh@linuxfoundation.org>
> > > > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > > >
> > > >
> > > > External mail.
> > > >
> > > >
> > > >
> > > > On Mon, 21 Oct 2024 03:30:13 +0200,
> > > > Dean Matthew Menezes wrote:
> > > > >
> > > > > I can confirm that the original fix does not bring back the
> > > > > speaker output.  I have attached both outputs for alsa-info.sh
> > > >
> > > > Thanks!  This confirms that the only significant difference is the
> > > > COEF data between working and patched-non-working cases.
> > > >
> > > > Kailang, I guess this model (X1 Carbon Gen 12) isn't with ALC1318,
> > > > hence your quirk rather influences badly.  Or may the GPIO3
> > > > workaround have the similar effect?
> > > >
> > > > As of now, the possible fix is to simply remove the quirk entries for
> > ALC1318.
> > > > But I'd need to know which model was targeted for your original fix
> > > > in commit
> > > > 1e707769df07 and whether the regressed model is with ALC1318.
> > > >
> > > >
> > > > Takashi

