Return-Path: <stable+bounces-195055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556AC67CBA
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 07:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 72E652A0ED
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10172F363C;
	Tue, 18 Nov 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sMez2GVZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sknn3cwv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q8WEubMx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tKOXpuVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698002F39BF
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448899; cv=none; b=uY523OYGN5PsSBct+o8BIDRFG6saE6sQ68Y3OpwAcZWyrh+uf6+OEba8WQ8EjAcCHHidYSFfUDWvxXWc25qcoO9gcxvgYgSepFgUAqd7x6N1tJAwuS7/AWbBj7zdfWt/Scb2zTOMGCTgaOQEKQCcWBJuhZRR31F8Jy2Qxcb3ZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448899; c=relaxed/simple;
	bh=JzQYKbXQykWVAd99rlNThimtGoL0vJmGeBtwpzIb158=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfvWTvNgikxsfduw3WiwhynAJj+3eDzc3RWf1HLdHA6ZfCoHQ4aUyYdP5Jat39eJlWB0hY3mk/mnnTX+QcqKs5SyA3owZ9Xg8TgVpSAqzC48d5sY+Xmel1jgsIxqUHx/tGVuVow1LwE3iCUAKrNGulWWhGWE+v97QFcKw+5nBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sMez2GVZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sknn3cwv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q8WEubMx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tKOXpuVM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7B631FB50;
	Tue, 18 Nov 2025 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763448892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmdKTA1r+cUjswdtx3/+AM1Md098WqIGmZOn8DVBZLo=;
	b=sMez2GVZDDn8qjQMCzlIpfFfNaLbxJdPKUwadLGjk8O4CptW85ChMSwF7QJlMZTQDqvrhu
	UZclVCkX50wcVNj576TS9Y6RbiUg8o7ObXAaKZMbP8c6cJMwPH938Rn0Q9Qh9eB3Qk2aer
	TueaMqez7IgEBE3VYd20Qb1VF/MJgpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763448892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmdKTA1r+cUjswdtx3/+AM1Md098WqIGmZOn8DVBZLo=;
	b=sknn3cwv+i4+b/RS67KElxKiNb8H/Q0jZ7+Ak8RhWLwyahVQIwwPEEcZBdQdo+g3D6Tnpc
	Raqs1AF3yM2L0EAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q8WEubMx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tKOXpuVM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763448891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmdKTA1r+cUjswdtx3/+AM1Md098WqIGmZOn8DVBZLo=;
	b=Q8WEubMxD0yIMa/nLAEHMcibgiJB5hOlB0/Er9rMqmIWNnqipwnifec3/K3ySNAAHEGMhS
	9S8J0bkXcII6l3OFyYzJuPAZHR4Ff8s66Nsk6TmAWwWnn/EuH/Du91rdsm9sGqJAWp4D05
	nJNBUnc2+t/lU9P4O3OZuuFXsl5AjvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763448891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmdKTA1r+cUjswdtx3/+AM1Md098WqIGmZOn8DVBZLo=;
	b=tKOXpuVMxM0o4SPV/nzmxxOalzohKUsQFzrexIMHoBXEWQzfm8CWvMvVfPLWWOxap1A9bc
	j9mxoeoh9UyvqpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 845F63EA61;
	Tue, 18 Nov 2025 06:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0X0wHzsYHGmXQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Nov 2025 06:54:51 +0000
Date: Tue, 18 Nov 2025 07:54:51 +0100
Message-ID: <87zf8jesp0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	"Ding, Shenghao"
	<shenghao-ding@ti.com>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id retrieval for multiple probes
In-Reply-To: <7c0d8c96c51c4265aa150ed8c4d785c7@ti.com>
References: <20251026191635.2447593-1-lkml@antheas.dev>
	<7c0d8c96c51c4265aa150ed8c4d785c7@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B7B631FB50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Tue, 18 Nov 2025 03:31:32 +0100,
Xu, Baojun wrote:
> 
> > 
> > ________________________________________
> > From: Antheas Kapenekakis <lkml@antheas.dev>
> > Sent: 27 October 2025 03:16
> > To: Ding, Shenghao; Xu, Baojun
> > Cc: Takashi Iwai; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; Antheas Kapenekakis; stable@vger.kernel.org
> > Subject: [EXTERNAL] [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id retrieval for multiple probes
> > 
> > Currently, on ASUS projects, the TAS2781 codec attaches the speaker GPIO
> > to the first tasdevice_priv instance using devm. This causes
> > tas2781_read_acpi to fail on subsequent probes since the GPIO is already
> > managed by the first device. This causes a failure on Xbox Ally X,
> > because it has two amplifiers, and prevents us from quirking both the
> > Xbox Ally and Xbox Ally X in the realtek codec driver.
> > 
> > It is unnecessary to attach the GPIO to a device as it is static.
> > Therefore, instead of attaching it and then reading it when loading the
> > firmware, read its value directly in tas2781_read_acpi and store it in
> > the private data structure. Then, make reading the value non-fatal so
> > that ASUS projects that miss a speaker pin can still work, perhaps using
> > fallback firmware.
> > 
> > Fixes: 4e7035a75da9 ("ALSA: hda/tas2781: Add speaker id check for ASUS projects")
> > Cc: stable@vger.kernel.org # 6.17
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  include/sound/tas2781.h                       |  2 +-
> >  .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 44 +++++++++++--------
> >  2 files changed, 26 insertions(+), 20 deletions(-)
> > 
> Reviewed-by: Baojun Xu <baojun.xu@ti.com>

OK, I applied both patches to for-next branch now.

For the remaining issues, let's fix on the top.


thanks,

Takashi

