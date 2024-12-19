Return-Path: <stable+bounces-105317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEC9F800A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195E118874A6
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C5226888;
	Thu, 19 Dec 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yulf3/Nl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEqnc657";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yulf3/Nl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEqnc657"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977F224B0C;
	Thu, 19 Dec 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626336; cv=none; b=iIG5YCRUGN4cRv4pJdg9KU/14Mo025dVwnqjjtInR5g9w8qAhcFdQ/VbKbf2uwI7tk8RS8WqQdU/I/9fcOxm2og3Y+dhY6IfWGeK9WmmkdYNHA5cR7uwpIbbqqfPY78CEDnQAM0JZuXjyceNpD5lozh+5yhy0hhiT/75ViT8G04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626336; c=relaxed/simple;
	bh=EY8+TiDFs2YHmBMScnpOaFfGklarvNlKUhTgAj6vxJk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Zr1i+K2VjBaKhbNWnD0B66AJEUCnibuuI/EfsG99nAVl6JXKxm6soJW6Z8xJH9gL+yX7yVAqSRv/vfKx7aXswf1tl3eaHQJGgRgnYekaa006LDKwPyMzd/Q8IKKYYMUUSMKNsPP7aMzA/aB16h1n2J7bnox/gg2GwZryMNjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yulf3/Nl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEqnc657; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yulf3/Nl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEqnc657; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4641E21163;
	Thu, 19 Dec 2024 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734626328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea6KjCB98JJt3pdQ6zxcR8KQ3qdMF42hqqNkPK++uTw=;
	b=Yulf3/NlAEr+29JqZER5fx9MsUqWkd0B8d8MgZbCMx8eVT9EywmB8fAZrH6xpoRmgkc/bP
	HKlJIiDoxKU1hdq3UQlE/mDszFxAWMl8cvrB4y+ndIiSNkkcZhxAi6kZyNCfb7UBrVAtKz
	9l1IUV/WDMT853a+CxH6M8wsBlrxG9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734626328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea6KjCB98JJt3pdQ6zxcR8KQ3qdMF42hqqNkPK++uTw=;
	b=IEqnc657kTq//mqYBXs65x4NAaD2JSJM8c/dcCreNYKmA03gL42k2KdFhT8solNbxDusJZ
	lA9JbxUV2Ry9JyCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734626328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea6KjCB98JJt3pdQ6zxcR8KQ3qdMF42hqqNkPK++uTw=;
	b=Yulf3/NlAEr+29JqZER5fx9MsUqWkd0B8d8MgZbCMx8eVT9EywmB8fAZrH6xpoRmgkc/bP
	HKlJIiDoxKU1hdq3UQlE/mDszFxAWMl8cvrB4y+ndIiSNkkcZhxAi6kZyNCfb7UBrVAtKz
	9l1IUV/WDMT853a+CxH6M8wsBlrxG9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734626328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea6KjCB98JJt3pdQ6zxcR8KQ3qdMF42hqqNkPK++uTw=;
	b=IEqnc657kTq//mqYBXs65x4NAaD2JSJM8c/dcCreNYKmA03gL42k2KdFhT8solNbxDusJZ
	lA9JbxUV2Ry9JyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B096C13A32;
	Thu, 19 Dec 2024 16:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mhiTJxdMZGf2UAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 19 Dec 2024 16:38:47 +0000
Date: Thu, 19 Dec 2024 17:38:42 +0100
Message-ID: <8734ijwru5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgeny Kapun <abacabadabacaba@gmail.com>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions Mailing List <regressions@lists.linux.dev>,
	Linux Stable Mailing List <stable@vger.kernel.org>
Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
In-Reply-To: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 15 Dec 2024 14:06:38 +0100,
Evgeny Kapun wrote:
> 
> I am using an Acer Aspire A115-31 laptop. When running newer kernel
> versions, sound played through headphones is distorted, but when
> running older versions, it is not.
> 
> Kernel version: Linux version 6.12.5 (user@hostname) (gcc (Debian
> 14.2.0-8) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.50.20241210)
> #1 SMP PREEMPT_DYNAMIC Sun Dec 15 05:09:16 IST 2024
> Operating System: Debian GNU/Linux trixie/sid
> 
> No special actions are needed to reproduce the issue. The sound is
> distorted all the time, and it doesn't depend on anything besides
> using an affected kernel version.
> 
> It seems to be caused by commit
> 34ab5bbc6e82214d7f7393eba26d164b303ebb4e (ALSA: hda/realtek - Add
> Headset Mic supported Acer NB platform). Indeed, if I remove the entry
> that this commit adds, the issue disappears.
> 
> lspci output for the device in question:
> 
> 00:0e.0 Multimedia audio controller [0401]: Intel Corporation
> Celeron/Pentium Silver Processor High Definition Audio [8086:3198]
> (rev 06)
>     Subsystem: Acer Incorporated [ALI] Device [1025:1360]
>     Flags: bus master, fast devsel, latency 0, IRQ 130
>     Memory at a1214000 (64-bit, non-prefetchable) [size=16K]
>     Memory at a1000000 (64-bit, non-prefetchable) [size=1M]
>     Capabilities: [50] Power Management version 3
>     Capabilities: [80] Vendor Specific Information: Len=14 <?>
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>     Capabilities: [70] Express Root Complex Integrated Endpoint,
> IntMsgNum 0
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel, snd_soc_avs, snd_sof_pci_intel_apl

Could you give alsa-info.sh output with broken and working (reverted)
states?  Run the script with --no-upload option and attach the
outputs.


thanks,

Takashi


