Return-Path: <stable+bounces-165191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA8B15922
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 08:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AB83A82EF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99111F5423;
	Wed, 30 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFeOaYj1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="suk5mr6m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFeOaYj1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="suk5mr6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37A1EFFB4
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858329; cv=none; b=tGLfkKhCelOGcBYzqh8QkvRrzV74273DX2EE/73WKZ4TmSgmLXiOtnKrSX23o7FtJgv5rN7TpouYvLpMAvriyt6EyibR+iuzam+zPxgHRdY1OnaVZXwRue+WLh6prawmbjPFXnzvmsN/qWcn5L7sqShti+GwWrCIpJxGMED8vCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858329; c=relaxed/simple;
	bh=vcomCsS8vGaH9x5JXSKM2sRl5VCMsY+8hq3RZ+ntiLc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3m+FFEDtTLwotmUi+jHs9FWOoB6ibwNnwrR1zCN9+DHnBCf2tIFUeGlxx6kT0vbA2Sw1x0A/LxqQOk9vY6fdW/fi1fU4aE2sd8JE0ReZtGS2hittFNfYOZVju0G08i6z5jk7DMMBBfbasBMXT+uHC4QLa27U2Hz9Wd2nyX5zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFeOaYj1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=suk5mr6m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFeOaYj1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=suk5mr6m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548491F45A;
	Wed, 30 Jul 2025 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753858326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NC/ae93nUOfFJAm7ykrBqKhQrOW+D+LntLOlpAiHbU=;
	b=rFeOaYj1wmgMANPGjYHQ40elAOTfNuJlbhRVfID+eYznUenDHknS96Qhcmx+QjD4sQxQhb
	znMnxdXffFfwAgGfTtGjYI0SItM6pkyKEn2vWnsgzz7tQmRB0CGJ1wWp0M7K2gwrjS64pz
	TxcjxRnKI+AWAxOB0jMwQo0s8A0c17o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753858326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NC/ae93nUOfFJAm7ykrBqKhQrOW+D+LntLOlpAiHbU=;
	b=suk5mr6mUdpg4G2Km101DOwUFKTu+UgIXpz4Uco/pJaa0SG3ydasajEC4wKGNoz0n6eDDa
	8WUh1Lv56eY2XaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753858326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NC/ae93nUOfFJAm7ykrBqKhQrOW+D+LntLOlpAiHbU=;
	b=rFeOaYj1wmgMANPGjYHQ40elAOTfNuJlbhRVfID+eYznUenDHknS96Qhcmx+QjD4sQxQhb
	znMnxdXffFfwAgGfTtGjYI0SItM6pkyKEn2vWnsgzz7tQmRB0CGJ1wWp0M7K2gwrjS64pz
	TxcjxRnKI+AWAxOB0jMwQo0s8A0c17o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753858326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NC/ae93nUOfFJAm7ykrBqKhQrOW+D+LntLOlpAiHbU=;
	b=suk5mr6mUdpg4G2Km101DOwUFKTu+UgIXpz4Uco/pJaa0SG3ydasajEC4wKGNoz0n6eDDa
	8WUh1Lv56eY2XaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242CD1388B;
	Wed, 30 Jul 2025 06:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPudBxbBiWhVOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Jul 2025 06:52:06 +0000
Date: Wed, 30 Jul 2025 08:52:05 +0200
Message-ID: <87y0s6rx0q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
In-Reply-To: <20250729181848.24432-2-edip@medip.dev>
References: <20250729181848.24432-2-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 29 Jul 2025 20:18:48 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
> 
> Tested on Victus 16-S0063NT Laptop. The LED behaviour works
> as intended.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Applied both patches now.  Thanks.


Takashi

