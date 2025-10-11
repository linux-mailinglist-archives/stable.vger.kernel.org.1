Return-Path: <stable+bounces-184068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB2BCF3D5
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C189C4E5D32
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2125DD07;
	Sat, 11 Oct 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TFaeYX/A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1iayqFFX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q8mHV2DB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xN7IR98S"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2702222AB
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179828; cv=none; b=cTI+b1pio8ALmfzLUnkjDSppwBDIEvM3wpVFNYqTnmu8mEA5MvjhjGDWsJ/PevdkxWIrk7s4ry1byt0n+tq8q68b2oosL6aCNjydjyhCKKXW21Ofn3n4kbl33hLljt0DL6hiDssXv8DQSPw3wHqjKJQvu/be7vX7pup8rEzAk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179828; c=relaxed/simple;
	bh=TP2aMMs38+BtH8PUioV+76K5hHwJTWs2vnsaJXi9BcE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEvfVNvdbaxKbGBX65IPDw/pF7moIUkv03jpqSOmTsclYKAOT0UvNoMqOljmT4wLOsKVJUxLVuntjsNtVQ/f6R00TTO5eRoQDBGERZibGeYt/xP/KdtClQlxGADLgIJz68ZJkcHdkEGXOeHTT4WktYQxNRXixAMseF7ayRgNbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TFaeYX/A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1iayqFFX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q8mHV2DB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xN7IR98S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D23501FB3F;
	Sat, 11 Oct 2025 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760179815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxju3duN+V9PRYrNqKbNiqxa8tkGaRGnqfYKQGa+66U=;
	b=TFaeYX/Aey+GHcIRaAWCZ311H74lhbv5lk3v+JiBUVyXW+NlLo12AUWM06EICcEiRJBQhP
	ipRxMB3HFkuktFjTQWM8ttxJgEKCDdTonQPoWys17w/IX7ZJ0GFiuFB3DAumpSKlI+KpwQ
	G61ZuiwN2yJYYiZpscMjr7U7dFdIGSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760179815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxju3duN+V9PRYrNqKbNiqxa8tkGaRGnqfYKQGa+66U=;
	b=1iayqFFXTgToUQnv1J3mrhe8vY5DjH1jnHPx5CCfEPLLCihvxP0RWFdH9pMQp4LhZW8TuI
	+rYeD16o6JnHNyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760179814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxju3duN+V9PRYrNqKbNiqxa8tkGaRGnqfYKQGa+66U=;
	b=Q8mHV2DBg8o43pmfTXK7WYV3ZECLfudtA+Ww0CyQXmVSZlLV0dEOmAT7gSz6G4XsfybXn6
	IaPYSpiCX6JTeSP5HKplnwebKAGkAa3mUMU29msNVu2kYddS10ZeILNhxciCDyXVenRQ9x
	cCSN8KfFlWJepi6cVJt/R5n0MCZkI14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760179814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxju3duN+V9PRYrNqKbNiqxa8tkGaRGnqfYKQGa+66U=;
	b=xN7IR98SbDwBJlkS/6rVoY0LnUg2zco69c6KNOaQKvUMyezGZcjRXYWMEX7weBRnD5ss03
	rr05JKEEbXUCLPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F4413693;
	Sat, 11 Oct 2025 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0G57FmY26mjBegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 11 Oct 2025 10:50:14 +0000
Date: Sat, 11 Oct 2025 12:50:13 +0200
Message-ID: <87ecr9af16.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cryolitia PukNgae <cryolitia@uniontech.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	anguoli@uniontech.com,
	zhaochengyi@uniontech.com,
	fengyuan@uniontech.com
Subject: Re: [PATCH] ALSA: usb-audio: apply quirk for Huawei Technologies Co., Ltd. CM-Q3
In-Reply-To: <20251011-sound_quirk-v1-1-d693738108ee@linux.dev>
References: <20251011-sound_quirk-v1-1-d693738108ee@linux.dev>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sat, 11 Oct 2025 11:51:18 +0200,
Cryolitia PukNgae wrote:
> 
> There're several different actual hardwares sold by Huawei, using the
> same USB ID 12d1:3a07.
> 
> The first one we found, having a volume control named "Headset Playback
> Volume", reports a min value -15360, and will mute iff setting it to
> -15360. It can be simply fixed by quirk flag MIXER_PLAYBACK_MIN_MUTE,
> which we have already submitted previously.[1]
> 
> The second one we found today, having a volume control named "PCM
> Playback Volume", reports its min -11520 and res 256, and will mute
> when less than -11008. Because of the already existing quirk flag, we
> can just set its min to -11264, and the new minimum value will still
> not be available to userspace, so that userspace's minimum will be the
> correct -11008.
> 
> 1. https://lore.kernel.org/all/20250903-sound-v1-3-d4ca777b8512@uniontech.com/
> 
> Tested-by: Guoli An <anguoli@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

Thanks, applied now.


Takashi

