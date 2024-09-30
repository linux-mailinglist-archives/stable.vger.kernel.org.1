Return-Path: <stable+bounces-78241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CA989F81
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96B21C22507
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA418A954;
	Mon, 30 Sep 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnHz5wNO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jdctg/1/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnHz5wNO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jdctg/1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50957189B98;
	Mon, 30 Sep 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692547; cv=none; b=We+dSA2+YNkd+fTDWn27Jt0Mzzi3vMetT8gwVs7Kne45lW2nsUVE0EHYuZjwXEMUc7OC3wWovYWyeBEuWnSlXrFTiKh6/C5x/04e5UjpvV9PqgtXdP272tV5+uG7oWypysUbLZBlZEAo/ZQ8SpbVOeJUBLjAliip/khhGColvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692547; c=relaxed/simple;
	bh=K2KYdsOr0X5H4XjzzrhlyKfrWbeb2sW3IDbTJRqI184=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHCgGpNzVWSpakkQA2q6bQXfrax6sO2lhRSewwZwt47ZuS4CQn5Qtv+7NPxgh52RGSbpdZQZwDZ8tCVAmsL/vsoCnTRjqDAeuYHnDBMGM53uBfNNhfHKolqNn7bxDYHp+UNC6C6cIe1Hw7JcUz0LDKg3o2gNi7j6TYeeuCh8pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnHz5wNO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jdctg/1/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnHz5wNO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jdctg/1/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 672D01FB9C;
	Mon, 30 Sep 2024 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727692543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qxx1UQrE80LFqs8p40hza8Wbc1XUKLK21rskYeGfvxI=;
	b=HnHz5wNOEyPG0ycQ0L+fBMoy10bAEJzuvNlg80cSdMiE2C0oba8KzMXGnzxf6K2PTFK+KM
	yZJqIt1Xl2EA8Wq+cQBGrCrt+X0LZcCmF6lnX2tB+O0zsEK94hIjdnLHs7XvWKhDg+epJA
	HJXA52JzRKdR02CqrkxnYvuox5eHu7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727692543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qxx1UQrE80LFqs8p40hza8Wbc1XUKLK21rskYeGfvxI=;
	b=Jdctg/1/e5myV/nqw5H4J0L93YcdniIxpHTLbJCuvaedjWoKrrWEd3aGLQpFM7t1u2MSHU
	2UrfERVGyBM7mnCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HnHz5wNO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Jdctg/1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727692543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qxx1UQrE80LFqs8p40hza8Wbc1XUKLK21rskYeGfvxI=;
	b=HnHz5wNOEyPG0ycQ0L+fBMoy10bAEJzuvNlg80cSdMiE2C0oba8KzMXGnzxf6K2PTFK+KM
	yZJqIt1Xl2EA8Wq+cQBGrCrt+X0LZcCmF6lnX2tB+O0zsEK94hIjdnLHs7XvWKhDg+epJA
	HJXA52JzRKdR02CqrkxnYvuox5eHu7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727692543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qxx1UQrE80LFqs8p40hza8Wbc1XUKLK21rskYeGfvxI=;
	b=Jdctg/1/e5myV/nqw5H4J0L93YcdniIxpHTLbJCuvaedjWoKrrWEd3aGLQpFM7t1u2MSHU
	2UrfERVGyBM7mnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2028413A8B;
	Mon, 30 Sep 2024 10:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tU4tBv9++mbaQwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 10:35:43 +0000
Date: Mon, 30 Sep 2024 12:36:36 +0200
Message-ID: <87ed51ig23.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
	linux-kernel@vger.kernel.org,
	stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [regression] Regular "cracks" in HDMI sound during playback since backport to 6.1.y for 92afcc310038 ("ALSA: hda: Conditionally use snooping for AMD HDMI")
In-Reply-To: <ZvgCdYfKgwHpJXGE@eldamar.lan>
References: <ZvgCdYfKgwHpJXGE@eldamar.lan>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 672D01FB9C
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 28 Sep 2024 15:19:49 +0200,
Salvatore Bonaccorso wrote:
> 
> Hi
> 
> In downstream Debian we got a report from  Eric Degenetais, in
> https://bugs.debian.org/1081833 that after the update to the 6.1.106
> based version, there were regular cracks in HDMI sound during
> playback.
> 
> Eric was able to bisec the issue down to
> 92afcc310038ebe5d66c689bb0bf418f5451201c in the v6.1.y series which
> got applied in 6.1.104.
> 
> Cf. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081833#47
> 
> #regzbot introduced: 92afcc310038ebe5d66c689bb0bf418f5451201c
> #regzbot link: https://bugs.debian.org/1081833
> 
> It should be noted that Eric as well tried more recent stable series
> as well, in particular did test as well 6.10.6 based version back on
> 20th september, and the issue was reproducible there as well.
> 
> Is there anything else we can try to provide?

Could you check 6.12-rc1 kernel whether the problem still appears?
If yes, check with snd_hda_intel.snoop=0 boot option. 

I guess we should revert the patch in anyway; for 6.12, it's no longer
correct to check with get_dma_ops(), and if this causes a problem on
the older releases, the assumption isn't correct, either.


thanks,

Takashi

