Return-Path: <stable+bounces-158832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C4AECBE8
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39621892ADD
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF220A5EC;
	Sun, 29 Jun 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xid0a7gu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FnDIJaXZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xid0a7gu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FnDIJaXZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D621E47BA
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751188652; cv=none; b=N2yrJpy6kChAeGlf6w5CT7VoVAVraunzBz5d3kW1LqXSTMbOxsQkNhusZEXnStw77Y9OgET5wtr5qL4GYFb0ocLOfx0/fcwlmFYFoA6KA2UdaqpQOdYtMLrSVrp4tciUL++pZ7cfZhX41qvuVURNJzExMvSF1EFwGsQ2lWCFGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751188652; c=relaxed/simple;
	bh=H39y6eiNUr9SIFzTuggli9zP9WqaRa8Po57M2Wt9E7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTML5uQ0CoSjh7+vwZUW0WqVVr4MJziYbsaP/FsG5t1f3gB0/t8iMroKtb+skBuK+Iw7U4MioAZYx6UAkthP+lnLB5J9Eg/5sCYbhnmh+Tcx/2FyVWoWKHCWvfMdZSh7aIzr92y0R2HbDsOr2EWwwTySMSGR5LxTrSrK/fVaE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xid0a7gu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FnDIJaXZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xid0a7gu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FnDIJaXZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2351F388;
	Sun, 29 Jun 2025 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751188648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxGRCoBDUVqEpVBQf6YKThvQ73kyAd3cE5zHM9WRLfQ=;
	b=Xid0a7guMs8W3B3jlDGzq26YgpOfl+HxGMGTyjUcN1sO8AT+Ru+FUV/t9EJZeuJPe7OquH
	Cq4UIGgG7/+s4d5yyBdaypaKLyBjcxyoUShqF45hd8BYd18yfQm/JiSQwe6RVBLgogapfU
	QmsXkp8T0Oxyale4SsRHZ3axC5pzi6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751188648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxGRCoBDUVqEpVBQf6YKThvQ73kyAd3cE5zHM9WRLfQ=;
	b=FnDIJaXZ9jV3nrGVGF4Kwf8kogHOVYE6JV7nR2OiGq3cZt/DBOayc6qn6MWiWJtKIGzkU5
	esv3EOJV+fNUOABA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751188648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxGRCoBDUVqEpVBQf6YKThvQ73kyAd3cE5zHM9WRLfQ=;
	b=Xid0a7guMs8W3B3jlDGzq26YgpOfl+HxGMGTyjUcN1sO8AT+Ru+FUV/t9EJZeuJPe7OquH
	Cq4UIGgG7/+s4d5yyBdaypaKLyBjcxyoUShqF45hd8BYd18yfQm/JiSQwe6RVBLgogapfU
	QmsXkp8T0Oxyale4SsRHZ3axC5pzi6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751188648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxGRCoBDUVqEpVBQf6YKThvQ73kyAd3cE5zHM9WRLfQ=;
	b=FnDIJaXZ9jV3nrGVGF4Kwf8kogHOVYE6JV7nR2OiGq3cZt/DBOayc6qn6MWiWJtKIGzkU5
	esv3EOJV+fNUOABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0EE31379A;
	Sun, 29 Jun 2025 09:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w2W6NacEYWitMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 29 Jun 2025 09:17:27 +0000
Date: Sun, 29 Jun 2025 11:17:27 +0200
Message-ID: <87ikkegb4o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fb2xxx
In-Reply-To: <20250627203415.56785-2-edip@medip.dev>
References: <20250627203415.56785-2-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medip.dev:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 27 Jun 2025 22:34:16 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
> 
> Tested on my friend's Victus 15-fb2xxx Laptop. The LED behaviour works as intended.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Applied now.  Thanks.


Takashi

