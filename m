Return-Path: <stable+bounces-235571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ4IJjSY2GkgfggAu9opvQ
	(envelope-from <stable+bounces-235571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:27:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A60813D2C0D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2EF4300E193
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5236F413;
	Fri, 10 Apr 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uzl1z4b/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3R/E+0Z6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uzl1z4b/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3R/E+0Z6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1070226D02
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802413; cv=none; b=aTqnawSosH4DPt4od/I/SU53VoTFIHKl79RASLCUJIZjo6xNFmpCaxM0s5ABFO6jsYQUFsEgBB46d+9LhsMsshBMaPDNRNZuaP+cNRooUVByItNkvpT6P9vQQGq1ngrG1DNaSF5pzUFn3Ef1AcfchzlwA7QtcueoQES27UwXgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802413; c=relaxed/simple;
	bh=axIGjV8i4JSYL/8WOyODYh5BWS7MFM0e9mMxACUryWY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxz9m4jeutxaA6moQI8ipPjVDjJAScqGlvQHJe8fsgxk1zSJ970TDBj7DdISqVI4hghZ7oS2jRuK0Yf66vDE8G+lhZoNQ6OFVIloETyj7p49a+KqYvhoF1CvAT31gTCfdO5/6BaopiPempfUKbiAY/jWkFgoiHNpcgP8NROXwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uzl1z4b/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3R/E+0Z6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uzl1z4b/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3R/E+0Z6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2495D5BCE0;
	Fri, 10 Apr 2026 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775802410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGHbRAaFuL/zTB/EN7a5JMuOJaxnLvmxRjD3i9TZX7M=;
	b=uzl1z4b/N9vC3LSAn1zQ87rIYjDp9A5nNBYtgYNI/txQ1OA0/FbpDiZJSY5tuCr/olL14z
	NSsEDSeAyekSsO4+HVvDWoo/U7nCCzA0wFrfPk+kbTQzgTi+hp52SdDlcfn182Mp3q/yB6
	Yf2TMpE73eEgU57XpHqfTHcQPIqOdiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775802410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGHbRAaFuL/zTB/EN7a5JMuOJaxnLvmxRjD3i9TZX7M=;
	b=3R/E+0Z6qoXLidvPuqRIE/Rs/Ou0s4ds/Gtog6u/h5twaJcQgUIAgc2AY7MqOvwp0miK5w
	unBWK7jYUJZxvGAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uzl1z4b/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3R/E+0Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775802410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGHbRAaFuL/zTB/EN7a5JMuOJaxnLvmxRjD3i9TZX7M=;
	b=uzl1z4b/N9vC3LSAn1zQ87rIYjDp9A5nNBYtgYNI/txQ1OA0/FbpDiZJSY5tuCr/olL14z
	NSsEDSeAyekSsO4+HVvDWoo/U7nCCzA0wFrfPk+kbTQzgTi+hp52SdDlcfn182Mp3q/yB6
	Yf2TMpE73eEgU57XpHqfTHcQPIqOdiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775802410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGHbRAaFuL/zTB/EN7a5JMuOJaxnLvmxRjD3i9TZX7M=;
	b=3R/E+0Z6qoXLidvPuqRIE/Rs/Ou0s4ds/Gtog6u/h5twaJcQgUIAgc2AY7MqOvwp0miK5w
	unBWK7jYUJZxvGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1784A0B2;
	Fri, 10 Apr 2026 06:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cQGVNCmY2GnfCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 10 Apr 2026 06:26:49 +0000
Date: Fri, 10 Apr 2026 08:26:49 +0200
Message-ID: <87v7dzgwk6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: caiaq: fix use-after-free and double-free in setup_card()
In-Reply-To: <20260410045904.1064020-2-berkcgoksel@gmail.com>
References: <20260410045904.1064020-1-berkcgoksel@gmail.com>
	<20260410045904.1064020-2-berkcgoksel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235571-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A60813D2C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 06:59:03 +0200,
Berk Cem Goksel wrote:
> 
> When snd_card_register() fails in setup_card(), snd_card_free() is
> called on the card, but there is no return statement afterwards.
> Execution falls through to snd_usb_caiaq_control_init(cdev), which
> dereferences members of the just-freed card, resulting in a
> use-after-free.
> 
> setup_card() is void and init_card() still returns 0 on this path,
> so snd_probe() leaves the freed card pointer in the USB interface's
> private data via usb_set_intfdata(). When the device is later
> disconnected, snd_usb_caiaq_disconnect() calls
> snd_card_free_when_closed() on that same pointer, producing a
> double-free and slab corruption.
> 
> Add the missing return so a failed snd_card_register() cleanly
> aborts setup without touching freed memory.
> 
> The issue is reachable by any caiaq-compatible USB device whose
> descriptors cause snd_card_register() to fail. It was reproduced
> with raw-gadget + dummy_hcd on 7.0.0-rc5 (arm64, KASAN).
> 
> Fixes: 523f1dce7096 ("ALSA: snd-usb-caiaq: add support for NI Audio Kontrol 1")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>

The code fix itself looks fine, but the Fixes tag above points to a
non-existing commit.  What tree are you using?


thanks,

Takashi


> ---
>  sound/usb/caiaq/device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -369,6 +369,7 @@
>  	if (ret < 0) {
>  		dev_err(dev, "snd_card_register() returned %d\n", ret);
>  		snd_card_free(cdev->chip.card);
> +		return;
>  	}
> 
>  	ret = snd_usb_caiaq_control_init(cdev);

