Return-Path: <stable+bounces-144356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16493AB687A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BA51BA065D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01526FDB0;
	Wed, 14 May 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r4jJSjK2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K4VExY8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r4jJSjK2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K4VExY8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25B21D3F2
	for <stable@vger.kernel.org>; Wed, 14 May 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217654; cv=none; b=F64s9s4riwASEevqiZSjfzrrebKvpBLKKjnzypPMW687Fj/UWhd5hQr497ZCptwsS7H06B0YWKkkcGsC6rTvbTjC1OvpUuHJvwkcuZcOdzLcgtje1fkUMePWGTyjq3Nqhh5v0c6fpz8jdDFsxF86RVcFZUPAwULfjFEGeMWkgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217654; c=relaxed/simple;
	bh=3ztXQE4MkXDtUYJaD+ZaiOi7FWZGY6Vu31hVlu0DjWc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qog4E8/Q5n6KeDD6iTtA1vfglwGZMxrc7YHt0C1Fh3d16nO99Um71EByn0Nsf1GGW6/o00P/k+4iORKahpRFJPTFROiZmTsHLLG+2Zk/lwikGYwpQcsJObn/lpGgsKOYD76ljyssN6NzmgXQzFE2SO5Op5+7MY/D+f//HFiJcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r4jJSjK2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K4VExY8r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r4jJSjK2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K4VExY8r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93A4C21203;
	Wed, 14 May 2025 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747217650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtUFdaL5kz+cWKfdHOIHrY0ZY1xSx9fKzhnfQdH0lTw=;
	b=r4jJSjK2mqAIcTOctdT+ShfYzeqvyysFf6V6Z01jTq9fzQBhJbelgXt5bh4wuC2zAan0AN
	b/qUGd4q59yUlReZtprVbiq1yRI4vvU1M8Kh3f/Sj0OH3UsBWf+bZyO2ePUlqxz/jvzM8N
	7Ta9r9WsWeUdySkhwBplyQ6k8r9MFe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747217650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtUFdaL5kz+cWKfdHOIHrY0ZY1xSx9fKzhnfQdH0lTw=;
	b=K4VExY8rj0LV+NPj8NjHJ7x6CC3ypuVoSqeiOTZzCVctJL7ElWGNRLlppr/TrGATa0j2fF
	f4XVe0xRJr9fssAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r4jJSjK2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K4VExY8r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747217650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtUFdaL5kz+cWKfdHOIHrY0ZY1xSx9fKzhnfQdH0lTw=;
	b=r4jJSjK2mqAIcTOctdT+ShfYzeqvyysFf6V6Z01jTq9fzQBhJbelgXt5bh4wuC2zAan0AN
	b/qUGd4q59yUlReZtprVbiq1yRI4vvU1M8Kh3f/Sj0OH3UsBWf+bZyO2ePUlqxz/jvzM8N
	7Ta9r9WsWeUdySkhwBplyQ6k8r9MFe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747217650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtUFdaL5kz+cWKfdHOIHrY0ZY1xSx9fKzhnfQdH0lTw=;
	b=K4VExY8rj0LV+NPj8NjHJ7x6CC3ypuVoSqeiOTZzCVctJL7ElWGNRLlppr/TrGATa0j2fF
	f4XVe0xRJr9fssAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 650E313306;
	Wed, 14 May 2025 10:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oZ6AF/JsJGjVOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 May 2025 10:14:10 +0000
Date: Wed, 14 May 2025 12:14:10 +0200
Message-ID: <87wmajts7h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()
In-Reply-To: <20250514092444.331-1-vulab@iscas.ac.cn>
References: <20250514092444.331-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 93A4C21203
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action

On Wed, 14 May 2025 11:24:44 +0200,
Wentao Liang wrote:
> 
> The function snd_es1968_capture_open() calls the function
> snd_pcm_hw_constraint_pow2(), but does not check its return
> value. A proper implementation can be found in snd_cx25821_pcm_open().
> 
> Add error handling for snd_pcm_hw_constraint_pow2() and propagate its
> error code.
> 
> Fixes: b942cf815b57 ("[ALSA] es1968 - Fix stuttering capture")
> Cc: stable@vger.kernel.org # v2.6.22
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Thanks, applied now.


Takashi

