Return-Path: <stable+bounces-86978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D439A54C0
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FAFB21FFD
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BBA193086;
	Sun, 20 Oct 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+vjrLDt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEdIkwnq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+vjrLDt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEdIkwnq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E93192D6C;
	Sun, 20 Oct 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438369; cv=none; b=XC1SUp5kgJ2tBiy0ew67dId0w9FXJoUiwKX/E2PtJxsKX8KqKMzLfhZ5XlmR2lHBcA+M7+PRR0Wz5d4PxhxUpi4nko3cXauFjyGLhOPivx4T0bhCtLFDIjgrs0EHWvBexhGZchzD+0HiSriXpuFLKs3KFiUhCnxNee0Y1AJaEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438369; c=relaxed/simple;
	bh=mZ0SEbjclymcuyoUxxPvktQzU4T7RIiqTRoKTa4Vneo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBYbRVnLtsdRJWFZIOQx8mf7GkFIB4XPr2wyobUCTvbtGxq/F43MDV6gu+2tal65+awMhSVhe4qP4Zi0X8pm0hZqNtpFXfDlo+FksIIvQ6TwpOZilKm1qYGYiFkt0jAtqP7hm5BKej//9H+aEYyZVRpgRhNWSqxhCuk196cg2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+vjrLDt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEdIkwnq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+vjrLDt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEdIkwnq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA37B1FE26;
	Sun, 20 Oct 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729438365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0ET3vRqvsSgrub7IdjGmo7dZeLudMFhQCHvOZGes+4=;
	b=m+vjrLDt88NVQr/o7K2mShq7mqizZ3yJPmSHnz98XCKaQRcqTyiyVrHOBKpcts4Yuvihcf
	rnJ5DMUIuM+Ql2PfVA2sICo/A2FWU5BHfrMDwqmVWXWYxG1ini5I275jm37CWSVygwjP9H
	Nwmt9oqFQXMeBF8qD2ZjQU0yZZH6M6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729438365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0ET3vRqvsSgrub7IdjGmo7dZeLudMFhQCHvOZGes+4=;
	b=nEdIkwnqa8avc8tS9yZlpozBcjrFgjfxrgRTiE3oh1odbs3FC3Ow0F/mNfBxlKaqCBx0EQ
	L6jJqY7AkH37nqAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729438365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0ET3vRqvsSgrub7IdjGmo7dZeLudMFhQCHvOZGes+4=;
	b=m+vjrLDt88NVQr/o7K2mShq7mqizZ3yJPmSHnz98XCKaQRcqTyiyVrHOBKpcts4Yuvihcf
	rnJ5DMUIuM+Ql2PfVA2sICo/A2FWU5BHfrMDwqmVWXWYxG1ini5I275jm37CWSVygwjP9H
	Nwmt9oqFQXMeBF8qD2ZjQU0yZZH6M6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729438365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0ET3vRqvsSgrub7IdjGmo7dZeLudMFhQCHvOZGes+4=;
	b=nEdIkwnqa8avc8tS9yZlpozBcjrFgjfxrgRTiE3oh1odbs3FC3Ow0F/mNfBxlKaqCBx0EQ
	L6jJqY7AkH37nqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BEAB13894;
	Sun, 20 Oct 2024 15:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EzfDGJ0iFWeVawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 20 Oct 2024 15:32:45 +0000
Date: Sun, 20 Oct 2024 17:33:45 +0200
Message-ID: <87bjzekcva.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang Yang <kailang@realtek.com>
Cc: Dean Matthew Menezes <dean.menezes@utexas.edu>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <87ed4akd2a.wl-tiwai@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Sun, 20 Oct 2024 17:29:33 +0200,
Takashi Iwai wrote:
> 
> On Sun, 20 Oct 2024 17:12:14 +0200,
> Dean Matthew Menezes wrote:
> > 
> > The first change worked to fix the sound from the speaker.
> 
> Then please double-check whether my original fix in
>   https://lore.kernel.org/87cyjzrutw.wl-tiwai@suse.de
> really doesn't bring back the speaker output.
> 
> If it's confirmed to be broken, run as root:
>   echo 1 > /sys/module/snd_hda_codec/parameters/dump_coef
> 
> and get alsa-info.sh outputs from both working and
> patched-but-not-working cases again, but at this time, during the
> playback.
> 
> (Also, please keep Cc.)

... and let's put Kailang to Cc, as the commit 1e707769df07
("ALSA: hda/realtek - Set GPIO3 to default at S4 state for Thinkpad
with ALC1318") is the likely culprit.

Kailang, it seems that your fix with GPIO3 workaround causes the lack
of the speaker output on Lenovo X1 Carbon Gen 12 with 17aa:231e where
ALC287_FIXUP_THINKPAD_I2S_SPK was applied beforehand.


Takashi

