Return-Path: <stable+bounces-181833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338CBA6900
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 08:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1807AE65F
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF227EFFE;
	Sun, 28 Sep 2025 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MLE98Rh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dU/mDHKD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MLE98Rh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dU/mDHKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1C1DE2C2
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041085; cv=none; b=AT+NqDIz4g/W+AJEm1gtp60ze+AM8QPa+ZTWa4NtXBo9hy5g1EuSaj4aJq8qiaH+vaDqOrjDHB0NRGy43K98HjnO0A4xXLBSwdcXJXUfXeLtWb/TK/KEgs+ij/BbQi0Ge3MltLnankJuo4tpZ26MtY/dioDytIbuJekaqpDmYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041085; c=relaxed/simple;
	bh=80MlwsJNMskvEtHDASa7mcrqS4cVzZ2KnHqkalR9g6M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqGfTgRMJKkRPTaue5eQXG1GZG8TG671hokUvFT4UGQI316/3hppaL7frrts+zGrakcGcJq4UyKEf7c3iQKc1k7Im3Bym4KVBtO2b+VpNGuscd0pJe0kLdanKXmFkei12Vo3NYZCz+KVZp5nScpDSGbwjui31qXJQESWjQjdvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MLE98Rh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dU/mDHKD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MLE98Rh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dU/mDHKD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EF7C4ED00;
	Sun, 28 Sep 2025 06:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759041081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nt7XRgS7wny7GLFezjGOgP212mj4Cp8kNuN5m7MFAo=;
	b=MLE98Rh7ejyD58pkGIB2EQ1mziIhSNzlLPef+aYGZj+OP/YgL86/rQBLquzkNleseq6ZhH
	QXxRfQI2V6ZakpnT4VVVO1BC7MFyHtiAflodXy07PdDISIFZx+02L0mlnT4vy7zegOqWtj
	kNk6dI3ClxafGymRBui4GWluLnOYIPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759041081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nt7XRgS7wny7GLFezjGOgP212mj4Cp8kNuN5m7MFAo=;
	b=dU/mDHKD0dpwwDW9TVOa75Bdhx7NJlCf5Vnmd+ryIXZ1PRmUJQLbGckxOVjFC9dOooA3qv
	XCTR/5/+axeXw4Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759041081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nt7XRgS7wny7GLFezjGOgP212mj4Cp8kNuN5m7MFAo=;
	b=MLE98Rh7ejyD58pkGIB2EQ1mziIhSNzlLPef+aYGZj+OP/YgL86/rQBLquzkNleseq6ZhH
	QXxRfQI2V6ZakpnT4VVVO1BC7MFyHtiAflodXy07PdDISIFZx+02L0mlnT4vy7zegOqWtj
	kNk6dI3ClxafGymRBui4GWluLnOYIPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759041081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nt7XRgS7wny7GLFezjGOgP212mj4Cp8kNuN5m7MFAo=;
	b=dU/mDHKD0dpwwDW9TVOa75Bdhx7NJlCf5Vnmd+ryIXZ1PRmUJQLbGckxOVjFC9dOooA3qv
	XCTR/5/+axeXw4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCDC913A3F;
	Sun, 28 Sep 2025 06:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ukTEMDjW2GiUGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Sep 2025 06:31:20 +0000
Date: Sun, 28 Sep 2025 08:31:20 +0200
Message-ID: <875xd39jgn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	hdanton@sina.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
In-Reply-To: <20250927173924.889234-1-aha310510@gmail.com>
References: <20250927173924.889234-1-aha310510@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[f02665daa2abeef4a947];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ladisch.de,perex.cz,suse.com,sina.com,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Sat, 27 Sep 2025 19:39:24 +0200,
Jeongjun Park wrote:
> 
> The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
> removal") patched a UAF issue caused by the error timer.
> 
> However, because the error timer kill added in this patch occurs after the
> endpoint delete, a race condition to UAF still occurs, albeit rarely.
> 
> Additionally, since kill-cleanup for urb is also missing, freed memory can
> be accessed in interrupt context related to urb, which can cause UAF.
> 
> Therefore, to prevent this, error timer and urb must be killed before
> freeing the heap memory.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
> Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Thanks, applied now.


Takashi

