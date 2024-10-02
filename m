Return-Path: <stable+bounces-80581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1498DFF9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698BB1F21D4A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D121D0BBE;
	Wed,  2 Oct 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0EKbvEv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xeDNG8X9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0EKbvEv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xeDNG8X9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA31CF5FB;
	Wed,  2 Oct 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884720; cv=none; b=X9aS9ja4uT8KWOmvjpGA1YkmYmvBRqIYoiICBi1UkIpLLiSVrZKOs8KWWWD0tzK/greLXHmuRILJ5fBezWft23DxmyX3rM0bfe2ouf7P7Lam//++Z3K6MsfGoIKnk0QvrXfMZKnEqV41NOwgiFUvW5qjTeQpV29gvq7xWB4lxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884720; c=relaxed/simple;
	bh=IFt1l3WRAd33DVYmb2YGMXAlt8wJczD1SE45A27CeIM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOZoSSv65nQikNQJDmgUMupWGvbuDVVK+CjjBnC3fZM9hqyEnyU2rslsf56tggZGLTAt7iRbJ4t80yVTxdwFnaiZLM0ziqgNejFZLg7ZOfEyu2mCONaS6LIwR2RGAakQbnfyEf71/VeV1fkrfuNmcVxVi1IanXgKfnroMWplJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0EKbvEv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xeDNG8X9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0EKbvEv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xeDNG8X9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFCB61FD65;
	Wed,  2 Oct 2024 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727884714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF2mG5eEs8tWaefGTk6lxFNI2Eew5R2odZGrPfW4ueI=;
	b=p0EKbvEv0XRiP2glhr9CIQfysxmeqIMTTGVHbwuHm/3kRkhH2Gy9ewuR/ZQpqa43RaqjZc
	7O32i2AM8SxWFAHHm4sY4cRuZ31d6aY9QX26QhmyAJHpHiZOfrAH1ff6EjvJ4F/5qa33TA
	ZTCnPTycV/W+WqfHJw3dscMnCfqtGEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727884714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF2mG5eEs8tWaefGTk6lxFNI2Eew5R2odZGrPfW4ueI=;
	b=xeDNG8X9YKoYqX72zALzY/fMel0aDGeaWRXAiXZznF6YTrI3/LrrRrjPqOpfbAIcAyEBWg
	Dx2hIdwnZCk7HPDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p0EKbvEv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xeDNG8X9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727884714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF2mG5eEs8tWaefGTk6lxFNI2Eew5R2odZGrPfW4ueI=;
	b=p0EKbvEv0XRiP2glhr9CIQfysxmeqIMTTGVHbwuHm/3kRkhH2Gy9ewuR/ZQpqa43RaqjZc
	7O32i2AM8SxWFAHHm4sY4cRuZ31d6aY9QX26QhmyAJHpHiZOfrAH1ff6EjvJ4F/5qa33TA
	ZTCnPTycV/W+WqfHJw3dscMnCfqtGEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727884714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF2mG5eEs8tWaefGTk6lxFNI2Eew5R2odZGrPfW4ueI=;
	b=xeDNG8X9YKoYqX72zALzY/fMel0aDGeaWRXAiXZznF6YTrI3/LrrRrjPqOpfbAIcAyEBWg
	Dx2hIdwnZCk7HPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C75E13974;
	Wed,  2 Oct 2024 15:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WD4aHapt/WaDTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Oct 2024 15:58:34 +0000
Date: Wed, 02 Oct 2024 17:59:27 +0200
Message-ID: <87a5fmlcm8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
	linux-kernel@vger.kernel.org,
	stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [regression] Regular "cracks" in HDMI sound during playback since backport to 6.1.y for 92afcc310038 ("ALSA: hda: Conditionally use snooping for AMD HDMI")
In-Reply-To: <87ed51ig23.wl-tiwai@suse.de>
References: <ZvgCdYfKgwHpJXGE@eldamar.lan>
	<87ed51ig23.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BFCB61FD65
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 30 Sep 2024 12:36:36 +0200,
Takashi Iwai wrote:
> 
> On Sat, 28 Sep 2024 15:19:49 +0200,
> Salvatore Bonaccorso wrote:
> > 
> > Hi
> > 
> > In downstream Debian we got a report from  Eric Degenetais, in
> > https://bugs.debian.org/1081833 that after the update to the 6.1.106
> > based version, there were regular cracks in HDMI sound during
> > playback.
> > 
> > Eric was able to bisec the issue down to
> > 92afcc310038ebe5d66c689bb0bf418f5451201c in the v6.1.y series which
> > got applied in 6.1.104.
> > 
> > Cf. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081833#47
> > 
> > #regzbot introduced: 92afcc310038ebe5d66c689bb0bf418f5451201c
> > #regzbot link: https://bugs.debian.org/1081833
> > 
> > It should be noted that Eric as well tried more recent stable series
> > as well, in particular did test as well 6.10.6 based version back on
> > 20th september, and the issue was reproducible there as well.
> > 
> > Is there anything else we can try to provide?
> 
> Could you check 6.12-rc1 kernel whether the problem still appears?
> If yes, check with snd_hda_intel.snoop=0 boot option. 
> 
> I guess we should revert the patch in anyway; for 6.12, it's no longer
> correct to check with get_dma_ops(), and if this causes a problem on
> the older releases, the assumption isn't correct, either.

I decided to revert the commit.  Will submit the patch now.


Takashi

