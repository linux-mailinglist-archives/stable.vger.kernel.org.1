Return-Path: <stable+bounces-241303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKDIMpNY72n5AQEAu9opvQ
	(envelope-from <stable+bounces-241303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00E47297B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28E3303EC2E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C313B637A;
	Mon, 27 Apr 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UV6T0DTK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2DLobgKQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UV6T0DTK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2DLobgKQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5B15B998
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293236; cv=none; b=TgFexcjRMxrsbnZSF05EyivkAOXn0Bv9X6yIQ8u3fOSIa+F3MdhXbyUgBiluP3ikUEmQ364BgDn6BzsX2ARjev6CqHtTJ6SX/uSPnovPcuvsKKhSvfPyRE1D1EEsPpJf9u9vq4hWDJk/+Lp1xGoBUoQR8iCiaq5tp5vgYxOtExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293236; c=relaxed/simple;
	bh=I8hWEpOZ56cCyELJi1kwO0i8yd2jFT9ZuvjkkjPTNbk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp7e8fhQ76yDUeHpwHvmhJV2gVOZwd6T7JKbvX7UCYV/cw78rqPoJJstNINNOpz9EzGW9l+F7QTxWDkmXVGmfiCurso66+QNDnDpLP95cutw9jxhZjYEQkGtgTh0ce5bsanVHgSJ+mXfcNfRBPHOckwPNSir8bHHAm9GJ+0R4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UV6T0DTK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2DLobgKQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UV6T0DTK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2DLobgKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 551886A825;
	Mon, 27 Apr 2026 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777293233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMIppM6uI8xYSa9uHlFTqAZEeW3Y/BN+5s1J3J0mmJo=;
	b=UV6T0DTKOUHbmNh4qKM4BUoVlJP7GA3ZFIGqwcfkMH+veW6zOmpJ8aJMXYiQNSws0uaGM1
	yaCx0okYK0rXuXpbi6quivp4ScR4MLp7408hGgpJESOpGhRqwHPpMU+sAj2kF1JrVr580U
	V4spFmOcXBoVSnpvU0BPBpQRKdX8F24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777293233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMIppM6uI8xYSa9uHlFTqAZEeW3Y/BN+5s1J3J0mmJo=;
	b=2DLobgKQ9w+VCPtIvaimfCX4WY8cQNe9NYY9aRfwo0iOsu1FzSbkkzbwx3Jbd8mFoBVnpA
	kdbz6dBmlc2bWtCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UV6T0DTK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2DLobgKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777293233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMIppM6uI8xYSa9uHlFTqAZEeW3Y/BN+5s1J3J0mmJo=;
	b=UV6T0DTKOUHbmNh4qKM4BUoVlJP7GA3ZFIGqwcfkMH+veW6zOmpJ8aJMXYiQNSws0uaGM1
	yaCx0okYK0rXuXpbi6quivp4ScR4MLp7408hGgpJESOpGhRqwHPpMU+sAj2kF1JrVr580U
	V4spFmOcXBoVSnpvU0BPBpQRKdX8F24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777293233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMIppM6uI8xYSa9uHlFTqAZEeW3Y/BN+5s1J3J0mmJo=;
	b=2DLobgKQ9w+VCPtIvaimfCX4WY8cQNe9NYY9aRfwo0iOsu1FzSbkkzbwx3Jbd8mFoBVnpA
	kdbz6dBmlc2bWtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D521593B0;
	Mon, 27 Apr 2026 12:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yHPbAbFX72knHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Apr 2026 12:33:53 +0000
Date: Mon, 27 Apr 2026 14:33:52 +0200
Message-ID: <875x5cziof.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: zonque@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: caiaq: fix usb_dev refcount leak on probe failure
In-Reply-To: <20260426001934.70813-1-kartikey406@gmail.com>
References: <20260426001934.70813-1-kartikey406@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 3E00E47297B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241303-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,2afd7e71155c7e241560];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,suse.de:dkim,suse.de:mid]

On Sun, 26 Apr 2026 02:19:34 +0200,
Deepanshu Kartikey wrote:
> 
> create_card() takes a reference on the USB device with usb_get_dev()
> and stores the matching usb_put_dev() in card_free(), which is
> installed as the snd_card's ->private_free destructor.
> 
> However, ->private_free is only assigned near the end of init_card(),
> after several failure points (usb_set_interface(), EP type checks,
> usb_submit_urb(), the EP1_CMD_GET_DEVICE_INFO exchange, and its
> timeout). When any of those fail, init_card() returns an error to
> snd_probe(), which calls snd_card_free(card). Because ->private_free
> is still NULL, card_free() never runs, the usb_get_dev() reference
> is not dropped, and the struct usb_device leaks along with its
> descriptor allocations and device_private.
> 
> syzbot reproduces this with a malformed UAC3 device whose only valid
> altsetting is 0; init_card()'s usb_set_interface(usb_dev, 0, 1) call
> fails with -EIO and triggers the leak.
> 
> Move the ->private_free assignment into create_card(), immediately
> after usb_get_dev(), so that every error path reaching snd_card_free()
> balances the reference. card_free()'s callees (snd_usb_caiaq_input_free,
> free_urbs, kfree) already tolerate the partially-initialized state
> because the chip private area is zero-initialized by snd_card_new().
> 
> Reported-by: syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2afd7e71155c7e241560
> Tested-by: syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Applied now.  Thanks.


Takashi

