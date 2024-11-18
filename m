Return-Path: <stable+bounces-93799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BBA9D1264
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 14:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAAF1F21F64
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A11A9B2F;
	Mon, 18 Nov 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A59KTjoq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5citjI6q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jlnLQJ+Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3dt8dq7Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3721199EA3;
	Mon, 18 Nov 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937267; cv=none; b=OSZgqhbrI4itGm4iXYQ5j6SiE6TDqd9NlA+hGk8CxZvdNS6+ZvVh+hMUgm7y5aJJaVQShw/n31qdIWlkQgrSx6x39suopsMDctE0256Sm9HI8Ds+s3GdZ6Mp4B4CWHQtV2ZEv5FGt9bO42hf8DatAygZNJLyJ78qHqVUpCtXfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937267; c=relaxed/simple;
	bh=uKE/0a42PrVZhu/VkkIYnHs6rtFBFgty5o6WzC8DIbc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt4bELSZglqFON8tOakqh+VDrS0RoD9NpiJB6pZwPcM/FIA1der4TRst1FVQ6mfk9vagZlBCS1c19eJ3vhyzrBnztoLeELJolSvM1ZpjKTTnO4L8jd5o6w1wT+sWCEWYrp6fSC49XWqvrt6zTXcRO3I+bVOzbfkS8G4args3M0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A59KTjoq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5citjI6q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jlnLQJ+Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3dt8dq7Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B09921151;
	Mon, 18 Nov 2024 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731937264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRvlMHRqPsHvF+Y4rop7W+Ht8NphPpCypBNENGLLC/I=;
	b=A59KTjoqJ52YEpalyBsLvAt5DDQUvVT1zw3mLOCGmUeUWEpdwkZm/+/WNVJyCnZ3WrZWST
	p/m03KtJ7N83qNhjpncBNA/mWbwKNXfD/LtY8RMxV8tzhX/f1Smo94qjyueiDs8cQcFoDK
	IjsmnFpk+FLorhhkNxKP4O686LhVhfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731937264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRvlMHRqPsHvF+Y4rop7W+Ht8NphPpCypBNENGLLC/I=;
	b=5citjI6q1pv2FRPxDSJpfbvRIrE5B0aizTCu4iszUGo6GGpVWWdhD+ZjA8sGL4pzRmr6wT
	YUWEsOOU8Aq8ZXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731937263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRvlMHRqPsHvF+Y4rop7W+Ht8NphPpCypBNENGLLC/I=;
	b=jlnLQJ+ZV5TkzrX0FZRtDFKxpyJDm/7JTRmHiiPGyGIlnvazZtoovlc3g0lqi45AA5KX/m
	jCA2uXaMCD+ZHaHydpO2aI8Pu8iO9ngB/fiiXxL0AyTFgIL14O6kSYd5SLHpwI2wu4FauK
	wiQFpL4jCTZWrTw9x0MKj4y+/KUdpGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731937263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRvlMHRqPsHvF+Y4rop7W+Ht8NphPpCypBNENGLLC/I=;
	b=3dt8dq7YM1dyOm1huS3cAFDmhKjeyK/dBjn87wg+kFMazRt3IoXGh32YZxT4gZpiPBav8w
	ordxHetS65LUtNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF81E134A0;
	Mon, 18 Nov 2024 13:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RIxjMe5DO2cuaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Nov 2024 13:41:02 +0000
Date: Mon, 18 Nov 2024 14:41:02 +0100
Message-ID: <87frno7j81.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Poll jack events for LS7A HD-Audio
In-Reply-To: <20241115150653.2819100-1-chenhuacai@loongson.cn>
References: <20241115150653.2819100-1-chenhuacai@loongson.cn>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Fri, 15 Nov 2024 16:06:53 +0100,
Huacai Chen wrote:
> 
> LS7A HD-Audio disable interrupts and use polling mode due to hardware
> drawbacks. As a result, unsolicited jack events are also unusable. If
> we want to support headphone hotplug, we need to also poll jack events.
> 
> Here we use 1500ms as the poll interval if no module parameter specify
> it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks, applied now.


Takashi

