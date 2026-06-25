Return-Path: <stable+bounces-268366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RHX9KMQWPWqEwwgAu9opvQ
	(envelope-from <stable+bounces-268366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:53:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8316C548B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Abwx7VKl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A5jb2rbm;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1zjJX7qc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pNthpy5O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268366-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268366-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9942630184DE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823963CD8AC;
	Thu, 25 Jun 2026 11:53:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E713DDDA1
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:53:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388384; cv=none; b=i3Br/u0HUULo24FALHnbt8RjU/dJ/tpUS5wtdUmwe1OemQfX1KDeDg7i+s9fbWUaptaFwbw3NsIT1Ec1CjpgspLFNwLg31TshjGJ4WLQFSaOOL/cEYFMuWg6AFQLq73xCP3znM1rBfbjbbjQcysVdz4CThVaA0t4Z1bw402WOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388384; c=relaxed/simple;
	bh=jrBCAYYtFmZ59LxFcrWWQftFhm4twriePx+2/nHbRvY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+W51rvTdsRwCNw/xeBKBBdUwFfLtTi8Go/owZCveYDlh4XSpbffE12oI6ueylPQoeswS//GBBzVwoJV/8PSa+FZL7rLB3a4iSiqQSnTdTfyHXJigvCg721riuTs/1vwgOyr7vKSCYQ5f/LDAYR+91nBkKc88vv2i1XLTDC0/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Abwx7VKl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A5jb2rbm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1zjJX7qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNthpy5O; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DD8771AFE;
	Thu, 25 Jun 2026 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=Abwx7VKli0TOUE8e7fbEGMfDUknqyuV4Z8Hq/FJv60rTFV7jcbBmgtAUricn+cXuTsyTCR
	IFHOeJG8SbLBn+1svtObLLzsFR4GiPkRjW5Pvx0Xsg0wjIGEYtMYoeKSah+KeGA6Pzj67v
	NoSdaMpdCrXucLNG5H8ujFMS876lQbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=A5jb2rbmWS8KXOmI2r8+8K/O6IPGwmPNrkC4MbFwwdAcv5GXQBqZMO/tc9BQRHV606F4jF
	VdOZUfpEYVwVsbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=1zjJX7qcsfvfvTAgm9KkAAHgp70MqWuKqPxspaviiZRDo6zFu8qwUi7hm0FYhZuOnRQOrh
	i0lRq3QdxVh3n0Tof+BSDvcUETQwxXTXCo4b6phmdYbqg6pyc42azbw3oh+raEZGrjZ5cP
	BB8uLzgch6HLE41zc4yvHM1/DqB13Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=pNthpy5ObKYWHMkrlBvDvLM05U9T0BlN6vPTCR056lVAm0yqsBnvoQEotunxxd6QX7tZLA
	Lut9c/XZX06NiYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E99779A8;
	Thu, 25 Jun 2026 11:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISVSD5oWPWpUfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jun 2026 11:52:58 +0000
Date: Thu, 25 Jun 2026 13:52:53 +0200
Message-ID: <87bjcyvnu2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Darvell Long <contact@darvell.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: avoid kobject path lookup in DualSense match
In-Reply-To: <20260624143723.2986353-1-contact@darvell.me>
References: <20260624143723.2986353-1-contact@darvell.me>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268366-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:contact@darvell.me,m:perex@perex.cz,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA8316C548B

On Wed, 24 Jun 2026 16:37:23 +0200,
Darvell Long wrote:
> 
> The DualSense jack-detection input handler verifies that a matching input
> device belongs to the same physical controller by building kobject path
> strings for both the input device and the USB audio device, then comparing
> the path prefix.
> 
> This was observed when a weak physical connection caused the controller
> to rapidly disconnect and reconnect. During that repeated hotplug,
> snd_dualsense_ih_match() can run while the controller's USB device is
> being disconnected. kobject_get_path() walks ancestor kobjects and
> dereferences their names; if the USB device kobject name is no longer
> valid, this can fault in strlen():
> 
>   RIP: 0010:strlen+0x10/0x30
>   Call Trace:
>    kobject_get_path+0x34/0x150
>    snd_dualsense_ih_match+0x49/0xd0 [snd_usb_audio]
>    input_register_device+0x566/0x6a0
>    ps_probe+0xb89/0x1590 [hid_playstation]
> 
> The same ownership check can be done without building kobject path
> strings. The input device is parented below the HID device, USB interface
> and USB device, so walking the input device parent chain and comparing
> against the mixer USB device preserves the check without dereferencing
> kobject names during disconnect.
> 
> Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Cute:gpt-5.5
> Signed-off-by: Darvell Long <contact@darvell.me>

Thanks, applied now.


Takashi

