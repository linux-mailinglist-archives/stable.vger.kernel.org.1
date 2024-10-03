Return-Path: <stable+bounces-80629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F298EA3B
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146D51C224A3
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ABA47F69;
	Thu,  3 Oct 2024 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W1omWeUJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDHfBCfU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aEgMcRKI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rBv+hemK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB451C32;
	Thu,  3 Oct 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939839; cv=none; b=H6AX5Ru1x4wo4+6sxOT55b7Lv5KBv/ZPKfOe3a1hugSsjGG9KYORVl/DnRxfgSlEoORV0skmi82tpQLuPAZPwNrDOrQeGzfVHLiwYgRt8VzkIYy4p5nQ7pNJWG2+kbJW0augUywONUwAu3mceWro1g0yswz1o3Y3Mz68ZtxwyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939839; c=relaxed/simple;
	bh=nJY+p0sPTrxFeABVUAyF8jxM4uABIjpT6dJnDTXGMeo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5498CYBF8JT0MR13Ac3fYMCU1hzwpDS4eloCzgbYs/WYIp1+0XZcg13aO1rxTU+COnjHi3NS2biLgjTNekmxgxH/GpgBMNtsJdQr01lqz8fOUBPyDiSRbwY1OgEzzB06ueQy1raTxgQoZyf1zR16gKw9lz657B30NX6YIYRowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W1omWeUJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDHfBCfU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aEgMcRKI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rBv+hemK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C8E21BA5;
	Thu,  3 Oct 2024 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727939830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62SBnhpEg+jfSGYnvnpjof1XUtMNKEtZvykM1CcBB+k=;
	b=W1omWeUJPaoOjWSQMk5qrlGBbWYop9AF6R4ykeJtfy1qTOSV9k3Ev0FqRnPuDplSqIB/JK
	OgxZyz2an7ALw+D6rOdXg/sgGm1UUIJKJe7wTKZsE2DQVFLHm35XuORmiunz6SjLiKczRo
	Icvy3ZcsoqGdl+LMZ6lhVzzFZHTjrys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727939830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62SBnhpEg+jfSGYnvnpjof1XUtMNKEtZvykM1CcBB+k=;
	b=JDHfBCfU13rGGpOtGK7Ft8j6IMtAtf8gvQ8V060399Qq/P1w7i+zDUqX1D2azl4EETmv/o
	LKy1I+nnANdWSyBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aEgMcRKI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rBv+hemK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727939829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62SBnhpEg+jfSGYnvnpjof1XUtMNKEtZvykM1CcBB+k=;
	b=aEgMcRKIY2YnFVniSLZejsj2rIsGgRRXfTpJ8GV/UoLdWP9lzPLwkl2utFMiiX0UdvoNri
	Nx36jydYT/D8P5DOjVeaFn4fRHTXIJQKZlbxUaVGN9hVUD9ukFJ1IEr09CT7q7q/RildHv
	1qHO/WKmYHM8PnlIdt3ug0uLpSTScps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727939829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62SBnhpEg+jfSGYnvnpjof1XUtMNKEtZvykM1CcBB+k=;
	b=rBv+hemKpkQcx4+OLbd1FPfiG+ZxTau02xj39JwGQ6lxTqkxLY5e9+jfnpd6cCr6/Rst6I
	MDfOZkCkIUiB3MCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7F32139CE;
	Thu,  3 Oct 2024 07:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UA0KN/RE/mZQRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 03 Oct 2024 07:17:08 +0000
Date: Thu, 03 Oct 2024 09:18:02 +0200
Message-ID: <87zfnlk639.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Linux Sound ML <linux-sound@vger.kernel.org>,	Takashi Iwai
 <tiwai@suse.de>,	stable@vger.kernel.org,	=?ISO-8859-1?Q?Barnab=E1s_?=
 =?ISO-8859-2?Q?P=F5cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] ALSA: core: add isascii() check to card ID generator
In-Reply-To: <20241002194649.1944696-1-perex@perex.cz>
References: <20241002194649.1944696-1-perex@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25C8E21BA5
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[protonmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,protonmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 02 Oct 2024 21:46:49 +0200,
Jaroslav Kysela wrote:
> 
> The card identifier should contain only safe ASCII characters. The isalnum()
> returns true also for characters for non-ASCII characters.
> 
> Buglink: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4135
> Link: https://lore.kernel.org/linux-sound/yk3WTvKkwheOon_LzZlJ43PPInz6byYfBzpKkbasww1yzuiMRqn7n6Y8vZcXB-xwFCu_vb8hoNjv7DTNwH5TWjpEuiVsyn9HPCEXqwF4120=@protonmail.com/
> Cc: stable@vger.kernel.org
> Reported-by: Barnabás Põcze <pobrn@protonmail.com>
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Applied now.  Thanks.


Takashi

