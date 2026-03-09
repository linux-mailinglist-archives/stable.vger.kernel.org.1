Return-Path: <stable+bounces-223623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEkvLsO2rmnMIAIAu9opvQ
	(envelope-from <stable+bounces-223623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:02:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD46C2385D6
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FD65301EA35
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1203A783A;
	Mon,  9 Mar 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qZYEnqzK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iqg9jVsT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qZYEnqzK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iqg9jVsT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F669392C3D
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057599; cv=none; b=bRuRJUqI2fJYHR6LLoDtdtge2loGx4YQJ04h3n6VUmMJyvtW4XVVcozn48cupr2JrcUlL0vIKDNcszS8ZZzRseSV/lfcFF+1gZ2j6fJYPmh7mXP/P9YhBSB4EB0VN4H/V0Pf9rDlJIjv/aoYdIdJ+rPCa5W7w+pLpUghZ25XSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057599; c=relaxed/simple;
	bh=m0xhQ1uZs4z8ceSwq+gGMXe79AXNiGXkw5mule+8kMY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXOlIt6/Oi5tXix6Pr+fH+VdCO1E3EEL9YoQJS1YoIs+y8mmi0ksMyrWIcT8+JHPff+LCoWiLchSImq/HW26j+DtsVjnoEUN9FCFXxwdpXBJgvTGada2rvgkPydHFsp066MMqm68eEIhN4nZv2R5fospZVGHHciMVoE72tauTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qZYEnqzK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iqg9jVsT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qZYEnqzK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iqg9jVsT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72E635BDE4;
	Mon,  9 Mar 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773057596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=qZYEnqzK1ikbR4BBvUHdBv6bvyU7unV1bvQVy1rkjjWBoyibGQGLKF0ThiTVEJYbSpxlfA
	QtdToMFPyvsISRgEJsm3Acdfhd6t98dwveMR4Hm5aRSE08pH2IpAZFuTOT9U2el/8g0hp4
	SCp8Kxu4wGRp+XLhRV12tw39Ro7J8ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773057596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=iqg9jVsTGgYSE3XjbD39+BsLT+VLoJYPcMqfLmN+wW6odLoUsiFSrpWuPIr1BxsKQy55we
	4BWoayVgXwkdC0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773057596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=qZYEnqzK1ikbR4BBvUHdBv6bvyU7unV1bvQVy1rkjjWBoyibGQGLKF0ThiTVEJYbSpxlfA
	QtdToMFPyvsISRgEJsm3Acdfhd6t98dwveMR4Hm5aRSE08pH2IpAZFuTOT9U2el/8g0hp4
	SCp8Kxu4wGRp+XLhRV12tw39Ro7J8ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773057596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=iqg9jVsTGgYSE3XjbD39+BsLT+VLoJYPcMqfLmN+wW6odLoUsiFSrpWuPIr1BxsKQy55we
	4BWoayVgXwkdC0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0E33EEB0;
	Mon,  9 Mar 2026 11:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8bgzCTy2rmkFHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Mar 2026 11:59:56 +0000
Date: Mon, 09 Mar 2026 12:59:55 +0100
Message-ID: <87zf4hmcw4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: Handle empty codec list in i2sbus_pcm_prepare()
In-Reply-To: <20260309114159.765304-3-thorsten.blum@linux.dev>
References: <20260309114159.765304-3-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BD46C2385D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223623-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.924];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On Mon, 09 Mar 2026 12:41:59 +0100,
Thorsten Blum wrote:
> 
> Replace two list_for_each_entry() loops with list_first_entry_or_null()
> in i2sbus_pcm_prepare().

Hmm, I guess both can be simply list_first_entry(), as the codec list
in this code path is guaranteed to be non-empty (it's called after
i2sbus_pcm_open() which has the check of the valid codecs).

> Handle an empty codec list explicitly by returning -ENODEV, which avoids
> using uninitialized 'bi.sysclock_factor' in the 32-bit code path.

Which 32bit code path are you referring to...?


thanks,

Takashi

