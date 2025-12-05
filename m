Return-Path: <stable+bounces-200168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3093CA8152
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 16:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A626E3108F41
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70C331A4F;
	Fri,  5 Dec 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BavYT5pI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="36pl2VUE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lwavmR3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G9tkMz9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B13278E63
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944020; cv=none; b=aUGjpSujG4xKG0+4L/G+5VDf5/OpmCoG+uSaF32Hc1Fup95+Qa/96sKOVhMkrfy/sVi+S8RMV2XBoo6M0GK/jK5ijQq11/rpAWeuKoL5TcWfE9G1YkBge0/6fIYHXHhE0juwkSgBDvvSpxcrtPx4O0ITkxIX7E8K+gbVqxBxo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944020; c=relaxed/simple;
	bh=zyAUk64DzyQHKPgainm3wVvn/8VSHwRXmmJiFUdt5e0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7FRzLBmmGjgnLGfsU5f4V1q9r/Tj7wRND9LpFFgJKMVSNR+SN5PqBtJ8sYbaD6MZ8tfkDi0CXJy02SS/t5GJklW67SYEXRUz1TtPxBAqKVPxMm25MZqcJfRVDEo60VhwIlqtnOiMFRG/b+ZHsCZlL59pypkZZdCp+fHAxptZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BavYT5pI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=36pl2VUE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lwavmR3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G9tkMz9K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86FDE5BCD5;
	Fri,  5 Dec 2025 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764944011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XE2nO/abCoDfdAiAU5wh9RMhLOUP5x7k/nb9XNWw0W4=;
	b=BavYT5pIi2KfwLXkHs81vyuD8B1fvXyl/paBYGjasf+F1S0M/LQeSLSAlUGk3GFJzNUiys
	oujJyaqcMJIE0pojDoO2nqlb8g84QGS6EsIiK1AE1xwjHoFhBBKu4Niz4KBMQOEGVpbmvc
	2VXiwypiGLKvapy1oDWoU4S7LdvKFKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764944011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XE2nO/abCoDfdAiAU5wh9RMhLOUP5x7k/nb9XNWw0W4=;
	b=36pl2VUEGNsSEtnXO8TpAt9gH+8rMsztrhraf6LXj2BhfdIBHz7qofSTsfRj3xGHtJKcE5
	NnRDmo4djpe73kCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lwavmR3z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G9tkMz9K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764944010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XE2nO/abCoDfdAiAU5wh9RMhLOUP5x7k/nb9XNWw0W4=;
	b=lwavmR3zE/RTth5YV8xlG2RBiCx/I29Fmy3nhaPfg33kizX+dG0qruWQi7dbqLVMD+iH4e
	nL8g+Gamiy6Pp7yevwHVkiSJTm7dbu23jsIQGzOV0ej6cbRe0uYHGrB/kEyZf6A82JY6A9
	ScTb6CpgYom6IEThYttKxmqZkcDHeyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764944010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XE2nO/abCoDfdAiAU5wh9RMhLOUP5x7k/nb9XNWw0W4=;
	b=G9tkMz9K/6wxelpoad4pksE6BcbRfX8ZfkjJ+sxqW89o8CXbzNRiUkv45l4H1XWhgybc97
	5mu6HGy9U6xGIHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 337B33EA63;
	Fri,  5 Dec 2025 14:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p/BZC4roMmnvdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Dec 2025 14:13:30 +0000
Date: Fri, 05 Dec 2025 15:13:29 +0100
Message-ID: <87sedpvwxi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Arefev <arefev@swemel.ru>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()
In-Reply-To: <20251202101338.11437-1-arefev@swemel.ru>
References: <20251202101338.11437-1-arefev@swemel.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 86FDE5BCD5
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue, 02 Dec 2025 11:13:36 +0100,
Denis Arefev wrote:
> 
> The acpi_get_first_physical_node() function can return NULL, in which
> case the get_device() function also returns NULL, but this value is
> then dereferenced without checking,so add a check to prevent a crash.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Applied now.  Thanks.


Takashi

