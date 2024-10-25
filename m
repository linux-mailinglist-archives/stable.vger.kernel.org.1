Return-Path: <stable+bounces-88129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C69AFAD1
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354D21F221FA
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746E1925B0;
	Fri, 25 Oct 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yt/p041I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqObzizw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="enGozTGP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+eMjhXH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E4156F30;
	Fri, 25 Oct 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840570; cv=none; b=Wqn4LVnjRL8GoZaei8xVubDw9u4BkbMPK9d50sWEukJOTDydw3SplPL69/MWlfdxTZpdN/icJs+u1FfOCZftJqXUa0iMw9PIGd5TFYl/x4X5Q42JYWBvUv6XKkEx9fBZNtAaE+uM4QnbpF1SdKwqKe4qMEEbupJhli9jlNYomEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840570; c=relaxed/simple;
	bh=3lvE9ux1Cc1yNsqWJaYnNMwfbxLoFmkzaQwAUYT2beA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkAlyZdhcbROA7tKOLP8AxDkBf/U+/oCMhYRk38bDqWLeuy9h/+Re1Syxb8HvXCMBrSz24tQLtEV+VRiGcx9OpS9S1hYb80piLK5E8CcsCnuQQN/HlcP1iNuvSiIiMohnjaYR66L3NTfFwBKLQJsS5hvWeuntXIom3UeapuLGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yt/p041I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqObzizw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=enGozTGP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+eMjhXH5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7323B1F7EF;
	Fri, 25 Oct 2024 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729840566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1h6EqeiW4j4oOK0o11J6e6gn42Ge73Pfofx6zOLK6Y=;
	b=yt/p041IsGR3/4sfo2tIfvpbz6P1zwta/zNh5ZEuWo0VgB8PenpATqEJja9gDG7PKqp6Q7
	4HtwIepbkEHG0Os4SpZWGUrF9QNbqacoVoX58dxvEbY9PEMOWIn6//QdnV885Yleo1k+yR
	SwWw1XU7XL4lzKn5ZsQproc+Qjh7074=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729840566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1h6EqeiW4j4oOK0o11J6e6gn42Ge73Pfofx6zOLK6Y=;
	b=WqObzizwHZHVs8rv32XV9DElf0mHNcR7VlAFg9/OnfgN6wt23L5HuKJLiNLNGo+JMO/dtc
	vsOvulKu9rVvxjBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729840565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1h6EqeiW4j4oOK0o11J6e6gn42Ge73Pfofx6zOLK6Y=;
	b=enGozTGPyfj/D2d06PAn2NnDD5JUyeoMUeRC8/GNPfwEjbsmlPZVe7iOdL9bGdR3qjk/wo
	WZHqc5l/hyMSNjlT/gNzBaAQWOuSThzFzqJyW0CDpyOPFxzsc8SVEDUAim83nW4DsF6ZS3
	g6FLlDZjwEGCeqmQLnk71u+QKPmqaSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729840565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1h6EqeiW4j4oOK0o11J6e6gn42Ge73Pfofx6zOLK6Y=;
	b=+eMjhXH5sdl3INFyTtsskvwxpbxsXnS6pvZAgdYVRDhIczRfQW1b8lD8UdoynZJYxX3GjZ
	Yv55IB2ofiBFt6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D21136F5;
	Fri, 25 Oct 2024 07:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rZhPC7VFG2d0SQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 25 Oct 2024 07:16:05 +0000
Date: Fri, 25 Oct 2024 09:17:06 +0200
Message-ID: <87ldyctzwt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: Kailang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
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
	<87h6956dgu.wl-tiwai@suse.de>
	<c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
	<CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.990];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Fri, 25 Oct 2024 03:22:38 +0200,
Dean Matthew Menezes wrote:
> 
> I get the same values for both
> 
> axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> 0x5a SET_COEF_INDEX 0x00
> nid = 0x5a, verb = 0x500, param = 0x0
> value = 0x0

Here OK, but...

> axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> 0x5a SET_PROC_COEF 0x00

... here run GET_PROC_COEF instead, i.e. to read the value.


thanks,

Takashi

