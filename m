Return-Path: <stable+bounces-87028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201E9A5E8B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1297282C05
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE791E1C31;
	Mon, 21 Oct 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZnXpi7hD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gbq7Jeww";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZnXpi7hD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gbq7Jeww"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754341E1A29;
	Mon, 21 Oct 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499009; cv=none; b=RLi9IIoC2J6oK6vkxGy0gE+615naR61PyBkFOJX5nxxR2wNTBQPx3kPdQz9Mc+Ary5u6YKBcaYDoVlUNyn49v67BYtemsbdn+U0wFJ7BxzXnLA1SVZppMHHugBdK1S3Ppj2Qdur1J1oKEu1yAD3QQTNJuN085EubKHuEQrW+mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499009; c=relaxed/simple;
	bh=WwNjMFmctKzFXLK8lxWuVafRcUUCsMvb6KjXgmfb3xA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkGIeL5tGk9Ab/1h+igz/1mJ7y6k/zhRkL4TkgIhV9WsFXF/CweDPImnEI7clYqr56gIgi2EOtqzn9o2fbCZlbxJWlR/WGr0Z+lQxWPdrkrzxCTosv78wlwwhuzEXiobw0rkP6nnsXQjWU8Xo1vibvdb2uOLhh1R1j6dhzcBjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZnXpi7hD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gbq7Jeww; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZnXpi7hD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gbq7Jeww; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92CAC1F7D4;
	Mon, 21 Oct 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729499005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebuVgWEAOWnQ8lRVNNZaJvcSVaKgtZtjysbBghRCznM=;
	b=ZnXpi7hDPnGsyrQmEjw+kbnaT1pAgo7ZTwf70D8exzwTPMgwwB0e6Xqd3haZsvK7W+Uae6
	qzKukvbS9du8i0pTjQn1r9wp7JJxY204mJ3GNmGGU+recRbxUjshaW6I8mMzDBU61/3uAn
	MTAADHLMiohD0ivcAlqGzBszKPZRJ3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729499005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebuVgWEAOWnQ8lRVNNZaJvcSVaKgtZtjysbBghRCznM=;
	b=Gbq7JewwP+/EzySZKvT2BpZXmIzezc43t/fczmurt0BfhcbzB3BW/z02Z9cMhfXn/fM9c4
	T1FFU/olZpvMGoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZnXpi7hD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gbq7Jeww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729499005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebuVgWEAOWnQ8lRVNNZaJvcSVaKgtZtjysbBghRCznM=;
	b=ZnXpi7hDPnGsyrQmEjw+kbnaT1pAgo7ZTwf70D8exzwTPMgwwB0e6Xqd3haZsvK7W+Uae6
	qzKukvbS9du8i0pTjQn1r9wp7JJxY204mJ3GNmGGU+recRbxUjshaW6I8mMzDBU61/3uAn
	MTAADHLMiohD0ivcAlqGzBszKPZRJ3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729499005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebuVgWEAOWnQ8lRVNNZaJvcSVaKgtZtjysbBghRCznM=;
	b=Gbq7JewwP+/EzySZKvT2BpZXmIzezc43t/fczmurt0BfhcbzB3BW/z02Z9cMhfXn/fM9c4
	T1FFU/olZpvMGoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43970139E0;
	Mon, 21 Oct 2024 08:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B3HkDn0PFmf4YQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 08:23:25 +0000
Date: Mon, 21 Oct 2024 10:24:25 +0200
Message-ID: <87ldyh6eyu.wl-tiwai@suse.de>
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
In-Reply-To: <43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
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
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 92CAC1F7D4
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 21 Oct 2024 10:19:53 +0200,
Kailang wrote:
> 
> Change to below model. 
> +	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),
> +	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),
> 
> The speaker will have output. Right?

FWIW, that was what I asked in
  https://lore.kernel.org/87h697jl6c.wl-tiwai@suse.de
and Dean replied that the speaker worked with it.
(His reply missed Cc, so it didn't appear in the thread,
unfortunately).


Takashi

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
> > 
> > As of now, the possible fix is to simply remove the quirk entries for ALC1318.
> > But I'd need to know which model was targeted for your original fix in commit
> > 1e707769df07 and whether the regressed model is with ALC1318.
> > 
> > 
> > Takashi

