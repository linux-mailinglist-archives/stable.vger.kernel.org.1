Return-Path: <stable+bounces-20496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE327859E2F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B2F1C217CB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080FB2110B;
	Mon, 19 Feb 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+nlVF1a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lLQF3Clv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+nlVF1a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lLQF3Clv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D320320
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331174; cv=none; b=a9OiHXIdkIb+jJfNtxR2n4a3lz6Mb/aDbziWf/HpOXzLP2M+FdlYTLjuxpxYpfozThu0gkW/ID6kFUe61Ap6XNKGPVqM/Z0EzAkukYejlSeFTsSPRinxr3zOLpHCwsJ6IM+e9mF7O/sEvnFZ18oraiG7SJKwXIHtbaQJYO3Wrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331174; c=relaxed/simple;
	bh=erH4/v2CKMxgJZ8lHD4k+yf1CAwK7bi6Lj8v/IlFaJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/wcCnlopPDow/rBYSvcUvegc7u3m5V2nBc/rNXMLHGBo2bzue5rXUmMSl2Dpjsy0DH8dSQ2WXU50sxHCr14yYEreebW+Kw8ew8R/1XVkAB1d7iqnGA6Rf3f0hV1X2CmoUi81VYOC2LcrqSOgZ8a0wmyDkasWNhdLtx0Zj//YDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+nlVF1a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lLQF3Clv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+nlVF1a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lLQF3Clv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B53921C14;
	Mon, 19 Feb 2024 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1oTvsJEC0RW4pZVI6O3To2ANPqP0P6uuo0vISwSHEE=;
	b=e+nlVF1aepKag0Vwi9L/ims0suRJs/Wu45zHcyeztTbsp1qJy/Yr4+yzX3FKXFRqDcqFug
	baQaITMFbkXebvyYBniaVW6kO9G+My7nTT8oIhRkuVrCegZbM6ob5sqjldmwmHz/L0m22E
	1HlKJqFHbGHV7SKcXxUT2oxTU5WE5EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1oTvsJEC0RW4pZVI6O3To2ANPqP0P6uuo0vISwSHEE=;
	b=lLQF3ClvkZaINHpfiqbOlDeZDJzJQ1UIEofXsSxt8glJKBIQ+3Y40aGieF0XiXEHILWfCR
	Dx91VHYno1TDFZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1oTvsJEC0RW4pZVI6O3To2ANPqP0P6uuo0vISwSHEE=;
	b=e+nlVF1aepKag0Vwi9L/ims0suRJs/Wu45zHcyeztTbsp1qJy/Yr4+yzX3FKXFRqDcqFug
	baQaITMFbkXebvyYBniaVW6kO9G+My7nTT8oIhRkuVrCegZbM6ob5sqjldmwmHz/L0m22E
	1HlKJqFHbGHV7SKcXxUT2oxTU5WE5EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1oTvsJEC0RW4pZVI6O3To2ANPqP0P6uuo0vISwSHEE=;
	b=lLQF3ClvkZaINHpfiqbOlDeZDJzJQ1UIEofXsSxt8glJKBIQ+3Y40aGieF0XiXEHILWfCR
	Dx91VHYno1TDFZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2752D13647;
	Mon, 19 Feb 2024 08:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jfwMCKMQ02U1BQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 08:26:11 +0000
Date: Mon, 19 Feb 2024 09:26:10 +0100
Message-ID: <877cj0q2ql.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire-lib: fix to check cycle continuity
In-Reply-To: <20240218033026.72577-1-o-takashi@sakamocchi.jp>
References: <20240218033026.72577-1-o-takashi@sakamocchi.jp>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e+nlVF1a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lLQF3Clv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.09 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.58)[98.15%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.09
X-Rspamd-Queue-Id: 4B53921C14
X-Spam-Flag: NO

On Sun, 18 Feb 2024 04:30:26 +0100,
Takashi Sakamoto wrote:
> 
> The local helper function to compare the given pair of cycle count
> evaluates them. If the left value is less than the right value, the
> function returns negative value.
> 
> If the safe cycle is less than the current cycle, it is the case of
> cycle lost. However, it is not currently handled properly.
> 
> This commit fixes the bug.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 705794c53b00 ("ALSA: firewire-lib: check cycle continuity")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks, applied.


Takashi

