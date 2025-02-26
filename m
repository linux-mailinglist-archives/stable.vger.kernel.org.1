Return-Path: <stable+bounces-119678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDCA46189
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723B01668BF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BA221545;
	Wed, 26 Feb 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oawCbxDY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xYg1qcCv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0hJn7xJn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KHuW2BlK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388D221555
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578382; cv=none; b=FVm6T8aPM1fJdBtqX4r+kUjjM91zEK9M7rpmAbJTqo9c7jnU02vJG2sDAzGIaSAqRj0044v4tqgYSeOcGO/R3JBpACI+g7mhJ3FKggtvY/tSs9bHI/N4dZJ6GmRlDZvqzTw97rqFJfgQJkYITIjIQeQZlKnRC4UNIYwfYJFpcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578382; c=relaxed/simple;
	bh=Or1vhAzrLXj8sBtJvVnR3Zqn6OKOqLEBPTIBcNae0+s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Op9naJes5iifoVQC6Cn22/KZevRAmlrp1riiAUV5Fx+lfJcf/j1y30Pex7oQmj7YmEH3UeXfvzPnNvFz7PIFXZVKcuTIYAH0erJt+94HXaw/p5vW2NPQfTU0EGNQPbcaSDtYdTyspVlYooMoe82sAT+6OJ1jEKbnrqrNSrkKMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oawCbxDY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xYg1qcCv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0hJn7xJn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KHuW2BlK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019CD1F387;
	Wed, 26 Feb 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740578379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47WruSlvITW/87soN26JYKTh1c5Xgaylhx0YYHmlUME=;
	b=oawCbxDYOFdTZZh1bHpEQkdkOOMGq+pe9cjU5Jw6jQh03yKsHAMmHjUGJ08zns9n1jOn6e
	dAzMFmgzYPmADruWpUoYLQIDSl3DrCl01r05bES2iLqvrd4dYM02oLESVdoH0j98sh/aHv
	/B9esBgs5F6vcUX0Pns2XMM5tav24HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740578379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47WruSlvITW/87soN26JYKTh1c5Xgaylhx0YYHmlUME=;
	b=xYg1qcCvpmJQWQ1XhMi/UQloO81E/db1iIbqz7wjXb1i/tenB6judPXo9I4Q1YikGu6C64
	MDt+nwygxj/Xp3AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0hJn7xJn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KHuW2BlK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740578378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47WruSlvITW/87soN26JYKTh1c5Xgaylhx0YYHmlUME=;
	b=0hJn7xJnr1L7TmqNBGWX6jLWZePpWzxuT7wVrnQviTodIANGp2tjTI5aY9GzdOLv2VO+R+
	t862Somj7qKpWu/sMS3pmG4h57l5I59bEZfoYSATp40FB/bMFywlXNW4W0Uzj4z9VtrS3K
	Wq/xlnBsVu3sEzHAPFj9BoWjmyRzksA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740578378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47WruSlvITW/87soN26JYKTh1c5Xgaylhx0YYHmlUME=;
	b=KHuW2BlKXeq+Uk0gtrJRPOmZOPvy15mM8P99Us8usZEm8BvRbhcQpx/bdcols9u3eYfjlu
	B5Qkl3R3rcgEX9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD80213A53;
	Wed, 26 Feb 2025 13:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jyFcMUkev2cgOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Feb 2025 13:59:37 +0000
Date: Wed, 26 Feb 2025 14:59:36 +0100
Message-ID: <87o6yo4xiv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adrien =?ISO-8859-1?Q?Verg=E9?= <adrienverge@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix microphone regression on ASUS N705UD
In-Reply-To: <20250226135515.24219-1-adrienverge@gmail.com>
References: <20250226135515.24219-1-adrienverge@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 019CD1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,realtek.com,opensource.cirrus.com,joshuagrisham.com,athaariq.my.id,gmail.com,canonical.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,canonical.com:email,suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 26 Feb 2025 14:55:15 +0100,
Adrien Vergé wrote:
> 
> This fixes a regression introduced a few weeks ago in stable kernels
> 6.12.14 and 6.13.3. The internal microphone on ASUS Vivobook N705UD /
> X705UD laptops is broken: the microphone appears in userspace (e.g.
> Gnome settings) but no sound is detected.
> I bisected it to commit 3b4309546b48 ("ALSA: hda: Fix headset detection
> failure due to unstable sort").
> 
> I figured out the cause:
> 1. The initial pins enabled for the ALC256 driver are:
>        cfg->inputs == {
>          { pin=0x19, type=AUTO_PIN_MIC,
>            is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
>          { pin=0x1a, type=AUTO_PIN_MIC,
>            is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
> 2. Since 2017 and commits c1732ede5e8 ("ALSA: hda/realtek - Fix headset
>    and mic on several ASUS laptops with ALC256") and 28e8af8a163 ("ALSA:
>    hda/realtek: Fix mic and headset jack sense on ASUS X705UD"), the
>    quirk ALC256_FIXUP_ASUS_MIC is also applied to ASUS X705UD / N705UD
>    laptops.
>    This added another internal microphone on pin 0x13:
>        cfg->inputs == {
>          { pin=0x13, type=AUTO_PIN_MIC,
>            is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 },
>          { pin=0x19, type=AUTO_PIN_MIC,
>            is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
>          { pin=0x1a, type=AUTO_PIN_MIC,
>            is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
>    I don't know what this pin 0x13 corresponds to. To the best of my
>    knowledge, these laptops have only one internal microphone.
> 3. Before 2025 and commit 3b4309546b48 ("ALSA: hda: Fix headset
>    detection failure due to unstable sort"), the sort function would let
>    the microphone of pin 0x1a (the working one) *before* the microphone
>    of pin 0x13 (the phantom one).
> 4. After this commit 3b4309546b48, the fixed sort function puts the
>    working microphone (pin 0x1a) *after* the phantom one (pin 0x13). As
>    a result, no sound is detected anymore.
> 
> It looks like the quirk ALC256_FIXUP_ASUS_MIC is not needed anymore for
> ASUS Vivobook X705UD / N705UD laptops. Without it, everything works
> fine:
> - the internal microphone is detected and records actual sound,
> - plugging in a jack headset is detected and can record actual sound
>   with it,
> - unplugging the jack headset makes the system go back to internal
>   microphone and can record actual sound.
> 
> Cc: stable@vger.kernel.org
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Chris Chiu <chris.chiu@canonical.com>
> Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
> Tested-by: Adrien Vergé <adrienverge@gmail.com>
> Signed-off-by: Adrien Vergé <adrienverge@gmail.com>

Thanks, applied now.


Takashi

