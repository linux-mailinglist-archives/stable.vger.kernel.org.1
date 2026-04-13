Return-Path: <stable+bounces-235907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPDFBESA3GlQSAkAu9opvQ
	(envelope-from <stable+bounces-235907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9873E77F0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 826E730055B2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448C313E38;
	Mon, 13 Apr 2026 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pI30No/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo+kfPqR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pI30No/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo+kfPqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DC335BA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058423; cv=none; b=S5G1Dum/+phtt2POkylOu/02mTLm4QPIto2iL71triXvkZV794g7phFo4WHlbeUca9RAZC1gIh2i4KZREqEb0WGgWAIbfe449NBKfaW72OxV60nYVlU/ISlfWE2N91k+6PSkR9UDG0pHf2PHeQQ5DY/heLBp4+FQrZx+rxHB0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058423; c=relaxed/simple;
	bh=A0nu626TADKLfjtCgXkRbKcHACBoyiqg060ZCo71ypc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/xWXY3ZuropyliWAPNRjQKqPKyNd4wKjoNefwuE2WDkqVQdjIFTlA1TNzaTkUTtjpMhlNU2Tl9gmtuI4jCccO7/TeLaIhFCZdU35tNXf28xntvR93caxT/o7hW6RqF00w/QPpNIE6CVzCR0y6GNbsinIMr5//EcQG5agIN8nnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pI30No/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo+kfPqR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pI30No/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo+kfPqR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38FA16A83A;
	Mon, 13 Apr 2026 05:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776058419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5niuR9q35mIjdDEZmcnXmS9rJJpAvPyQ4QlYSqcgfw=;
	b=pI30No/lsPoZOHRpMR/SOD2NRVqB/8f+hMHVJIA47ZaZQ6l/25vHiFF2MjnjqV4K+X2zLe
	8nyr7D29UgVixLKIzDfE19S/OsTU3g9t3xAVkois57wXSB71excQwMyQh91y59j02gdVZj
	Cx3akdDgXYL1NIlOtXs4qmM1GBfbPD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776058419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5niuR9q35mIjdDEZmcnXmS9rJJpAvPyQ4QlYSqcgfw=;
	b=Qo+kfPqRM0UWHGBdIXjoRerQqnBr3TjDro6K3HHCpogx1iWhGntjgkibsFECKFGqJNasPt
	Jf7V8rdGaS1RaxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776058419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5niuR9q35mIjdDEZmcnXmS9rJJpAvPyQ4QlYSqcgfw=;
	b=pI30No/lsPoZOHRpMR/SOD2NRVqB/8f+hMHVJIA47ZaZQ6l/25vHiFF2MjnjqV4K+X2zLe
	8nyr7D29UgVixLKIzDfE19S/OsTU3g9t3xAVkois57wXSB71excQwMyQh91y59j02gdVZj
	Cx3akdDgXYL1NIlOtXs4qmM1GBfbPD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776058419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5niuR9q35mIjdDEZmcnXmS9rJJpAvPyQ4QlYSqcgfw=;
	b=Qo+kfPqRM0UWHGBdIXjoRerQqnBr3TjDro6K3HHCpogx1iWhGntjgkibsFECKFGqJNasPt
	Jf7V8rdGaS1RaxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC0384AD0A;
	Mon, 13 Apr 2026 05:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tvFSNzKA3GkiXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Apr 2026 05:33:38 +0000
Date: Mon, 13 Apr 2026 07:33:38 +0200
Message-ID: <87mrz7whjh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: zonque@gmail.com,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreyknvl@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: caiaq: take a reference on the USB device in create_card()
In-Reply-To: <20260413034941.1131465-3-berkcgoksel@gmail.com>
References: <20260413034941.1131465-1-berkcgoksel@gmail.com>
	<20260413034941.1131465-3-berkcgoksel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,perex.cz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235907-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 9D9873E77F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 05:49:41 +0200,
Berk Cem Goksel wrote:
> 
> The caiaq driver stores a pointer to the parent USB device in
> cdev->chip.dev but never takes a reference on it. The card's
> private_free callback, snd_usb_caiaq_card_free(), can run
> asynchronously via snd_card_free_when_closed() after the USB
> device has already been disconnected and freed, so any access to
> cdev->chip.dev in that path dereferences a freed usb_device.
> 
> On top of the refcounting issue, the current card_free implementation
> calls usb_reset_device(cdev->chip.dev). A reset in a free callback
> is inappropriate: the device is going away, the call takes the
> device lock in a teardown context, and the reset races with the
> disconnect path that the callback is already cleaning up after.
> 
> Take a reference on the USB device in create_card() with
> usb_get_dev(), drop it with usb_put_dev() in the free callback,
> and remove the usb_reset_device() call.
> 
> Fixes: b04dcbb7f7b1 ("ALSA: caiaq: Use snd_card_free_when_closed() at disconnection")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
> ---
> v2:
>  - Correct "Fixes:" tag
>  - Remove null check before the usb_put_dev() call in card_free()

Applied now.  Thanks.


Takashi

