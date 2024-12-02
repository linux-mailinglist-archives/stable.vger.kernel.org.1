Return-Path: <stable+bounces-96104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D196F9E077F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53110B664D2
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404DC208988;
	Mon,  2 Dec 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wu00HmyT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2q4YbtqJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wu00HmyT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2q4YbtqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F50208977;
	Mon,  2 Dec 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153525; cv=none; b=NxD4zRuJUtgpKYRNoYFLNISjsVrjg//LF+zy+C7M00piK18/mw/AY6+Ln0048KK72H/SEdl+LhGS5aRGb/28mYVH12Tte4guMrLv1h1JOYu/GrMPeKhMXQBgnK+7kD4/BIIoZVCtRY26S5dACIcAT7wtC86AafPXJEsa/qVmO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153525; c=relaxed/simple;
	bh=AL6/W8yKe23vy+X7fWRlbRKOBMwosQZdY7iuK+HII8c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/RVznsd2804M4rBVWnBVfW7tuDnbAoDLj4G3e/voF3nubpK1rKNuz8YiUCRD+dQmVq8I4CRZrychHlfLdDHWWn7pRNTw0BYV4y8msYUl7bY+aBD1oA5OWxINJgr3LI+uvrhdoG8Z0MkFoXElDtZQAS5Ydlz9ToJF5pg1J5WxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wu00HmyT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2q4YbtqJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wu00HmyT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2q4YbtqJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A4F71F396;
	Mon,  2 Dec 2024 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vig0FVnKQoZYt4Lm2U28rO83cnNy0o6si6kHazH11M=;
	b=Wu00HmyTJc/aSSNng36PsNdW9IidXJ8LKiQhfbDaZWqrDPAjP7NsKb/bQdKHIf1pqsttrk
	/xVJNefD+OfUy+4Q74DUiR9G/eLnCcohu3N11XIDK0hzdJDxKxKhj2PWq66rft6oTU22DE
	4pSq+W5yw4/tlfzQpGNobU8gKEig16E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vig0FVnKQoZYt4Lm2U28rO83cnNy0o6si6kHazH11M=;
	b=2q4YbtqJU9xxMOK10yrw2dOq+O9RGLcP1aJxgE0ucqBXEkj8nb/12shIaAzggE2PAcjAeA
	GYEiiO0cYaB5cvBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vig0FVnKQoZYt4Lm2U28rO83cnNy0o6si6kHazH11M=;
	b=Wu00HmyTJc/aSSNng36PsNdW9IidXJ8LKiQhfbDaZWqrDPAjP7NsKb/bQdKHIf1pqsttrk
	/xVJNefD+OfUy+4Q74DUiR9G/eLnCcohu3N11XIDK0hzdJDxKxKhj2PWq66rft6oTU22DE
	4pSq+W5yw4/tlfzQpGNobU8gKEig16E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vig0FVnKQoZYt4Lm2U28rO83cnNy0o6si6kHazH11M=;
	b=2q4YbtqJU9xxMOK10yrw2dOq+O9RGLcP1aJxgE0ucqBXEkj8nb/12shIaAzggE2PAcjAeA
	GYEiiO0cYaB5cvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13AFA139C2;
	Mon,  2 Dec 2024 15:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qSivA/HSTWf3MgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Dec 2024 15:32:01 +0000
Date: Mon, 02 Dec 2024 16:32:00 +0100
Message-ID: <87ed2qummn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Asahi Lina <lina@asahilina.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Heiko Engemann <heikoengemann@gmail.com>,
	Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add extra PID for RME Digiface USB
In-Reply-To: <20241202-rme-digiface-usb-id-v1-1-50f730d7a46e@asahilina.net>
References: <20241202-rme-digiface-usb-id-v1-1-50f730d7a46e@asahilina.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 02 Dec 2024 14:17:15 +0100,
Asahi Lina wrote:
> 
> It seems there is an alternate version of the hardware with a different
> PID. User testing reveals this still works with the same interface as far
> as the kernel is concerned, so just add the extra PID. Thanks to Heiko
> Engemann for testing with this version.
> 
> Due to the way quirks-table.h is structured, that means we have to turn
> the entire quirk struct into a macro to avoid duplicating it...
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Applied now.  Thanks.


Takashi

