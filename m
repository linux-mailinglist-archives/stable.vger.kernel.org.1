Return-Path: <stable+bounces-206345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A9D0309E
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16BBC3032563
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBA44DB74;
	Thu,  8 Jan 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jOheDtZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jl6ccoMn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eed7TkAk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Had/9hcw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00844D01F
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877731; cv=none; b=oThIxHrDmXndoaogSp73wzPkKlP9N8iD4/fH4cVAqI/0E+Qmtj/y87peASSfvHVaEMap2kBUTOt+5ivDL3MOcEWuX80mkEO7rnt3RybSWdMlTtK+/u0LS0WiDpXb4zAwG8qtqwRKsPbMfoSauQ3Z1ekUoRvFEBBHdVZ3X7xhVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877731; c=relaxed/simple;
	bh=M5fkXb4jpJ8rj1F6FZ1XsOrkGaAmCzEFGh29iEjHbpM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu7HJEE90hXz/e+H90i7RsZT+PsqvceXIVTDdeyk0uFr1gsrvnw7/1kKOiHUsl+yrKFhrd4zCpzGTvj0514sRfFIPxrzJGsqP8WzMXdp+0YHvM4MLExPelgDeJmXLTJksG4SrWTPmPGkMxZJshfsayaeN3W0Nfm/DD8QJoDdHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jOheDtZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jl6ccoMn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eed7TkAk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Had/9hcw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5C034104;
	Thu,  8 Jan 2026 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767877727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+a5tqjnZEI1VmpIcUvU6Rry+vbHsGeFSZUrNaUm0IE=;
	b=jOheDtZtct9louNYw4VKaxhVhROY8LltWQFWWpukipwcC1fibpGwZRnLfakN1ecdkaK7Li
	xsi/IznJvq1k7JupIXZMQOlkLv3vyNWlfL9ojjKinLmMUX9JwZ7OS+f+RkbHcG8tsQDKX0
	3YB4QRf65CuQ7s2xfqHAmcEGVjQt/3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767877727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+a5tqjnZEI1VmpIcUvU6Rry+vbHsGeFSZUrNaUm0IE=;
	b=jl6ccoMnzIWKD7MDZMXKJMT/TL/u3E6S0YXsyWZSM9grVtWLuYd4KqrhRxeLpzsAz5f82K
	t0cZPh8tXWb2SbDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eed7TkAk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Had/9hcw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767877726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+a5tqjnZEI1VmpIcUvU6Rry+vbHsGeFSZUrNaUm0IE=;
	b=Eed7TkAkYzobll2CqwmTLgy6kSftqG5jqk0QD3XLb0lWZezGa+TTZwRkUjmWTIqsdQ/xSH
	K6TO0JQHrd4qKhBP3mPvQnoGveitN/FFZGp5EszcYRCgNrgKu3YepxOWPZUU/w1/2atGIq
	8/2clkMi8cjQCoI2MrHsZZSFPQPiZDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767877726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+a5tqjnZEI1VmpIcUvU6Rry+vbHsGeFSZUrNaUm0IE=;
	b=Had/9hcwhEm5yQM3ZxkIM+v3TZ4KYtRX8vS6wLANG3DESnSRGU4+VmqBSDeCdltsrc/HbR
	HaA09aDH33OIwkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F6D53EA63;
	Thu,  8 Jan 2026 13:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YRSAGl6sX2kUdAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Jan 2026 13:08:46 +0000
Date: Thu, 08 Jan 2026 14:08:46 +0100
Message-ID: <871pk0gskh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG Xbox Ally X
In-Reply-To: <20260108093650.1142176-1-matthew.schwartz@linux.dev>
References: <20260108093650.1142176-1-matthew.schwartz@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,linux.dev:email,ti.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 8C5C034104
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Thu, 08 Jan 2026 10:36:50 +0100,
Matthew Schwartz wrote:
> 
> There is currently an issue with UEFI calibration data parsing for some
> TAS devices, like the ASUS ROG Xbox Ally X (RC73XA), that causes audio
> quality issues such as gaps in playback. Until the issue is root caused
> and fixed, add a quirk to skip using the UEFI calibration data and fall
> back to using the calibration data provided by the DSP firmware, which
> restores full speaker functionality on affected devices.
> 
> Cc: stable@vger.kernel.org # 6.18
> Link: https://lore.kernel.org/all/160aef32646c4d5498cbfd624fd683cc@ti.com/
> Closes: https://lore.kernel.org/all/0ba100d0-9b6f-4a3b-bffa-61abe1b46cd5@linux.dev/
> Suggested-by: Baojun Xu <baojun.xu@ti.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> v1->v2: drop wrong Fixes tag, amend commit to clarify suspected root cause
> and workaround being used.

Applied now.  Thanks.


Takashi

