Return-Path: <stable+bounces-203286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2FCD8A08
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D1383053B36
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB92DEA78;
	Tue, 23 Dec 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cs3L+Tcn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q55W66tg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K3o23JPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OWwYcDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE4328B79
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483067; cv=none; b=Cg7spiQLSKsBRWp3odJh9KIzaSzHwY1nxD0GU36l9/r3XzyfpXb5p7M9Ivi9xS/2MKjd5fJyrgxKpSTqnRpY8JtStE2hpqBGDXtdvE152sFyFQk2P6pseBe7e0Ip6EHA97gCV+lQ3dQNmDNjic50LXdRFSo8DaP9JXWGvlZJNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483067; c=relaxed/simple;
	bh=hyqKqLKYrhhRb+iZ7HA2ifsFD63meib3IShgRJi+43w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXd1QEJt3tlYamcP6vBXzXmSd2rcNKoYMEg8zFUbEYOAKCFk7A52t7mdlpFTQCwGnWeTI9AZXP1EvSOxe5pgkGyPnKMp/OvIo6lbKyTcycbA/DwRkLNAGbPzpMl1+LHtbWyb0bYlQh0SkO9rR3fQTR7W2yJwxh+uNifnfrY2lNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cs3L+Tcn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q55W66tg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K3o23JPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OWwYcDR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F5BF336A0;
	Tue, 23 Dec 2025 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766483062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSLJBDAPSfb3msP2C66IWohWd4oOrB6SRphHJh3DKaA=;
	b=cs3L+TcnMHtpb5Pk6LTvsu5k6LKflCDxwRUJdLAd6DoD1oA9I6eFHQkkKOkktZdsPy/2t3
	9CgBEUyNuctHgijKUzWe9ZRZmJFh7UoLhgcdG7xw6lygQaE+P9FMwnEp9B/OfndLRH+HEA
	91E7E9EgdXfT3PB3f/tz+yhbeYCkqRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766483062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSLJBDAPSfb3msP2C66IWohWd4oOrB6SRphHJh3DKaA=;
	b=Q55W66tgMD5cYBb+ZJkEnQPLRMByyjixlB3jLB8OVP/g5wchHu+3xW1IfjcWvDjvpWuVat
	MkyEGuioiQb0VsCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K3o23JPZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0OWwYcDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766483061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSLJBDAPSfb3msP2C66IWohWd4oOrB6SRphHJh3DKaA=;
	b=K3o23JPZjZXF1Ymxn3ZGzVbO6A8Q/N0ehGtYfs450VxKqfyYr8XEVTtI/JwPJYczYi98k+
	RZWHji5MKhDDnALjtLOQTQWXpnB3j6pQ1FYqgx40e5wTdLMCilulz5R8aMSrJy4NyO14DV
	OMZ+TlL7U6CQ13efvEJ4JPMH8+5cdWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766483061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSLJBDAPSfb3msP2C66IWohWd4oOrB6SRphHJh3DKaA=;
	b=0OWwYcDRuM2D0xgiz7vLFRnRCSMKeRWChg9oPBjl3zlM3oFqr2OI1V6g4/X66uBlW3OxBm
	NC02RM9qBeuy0IAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943683EA63;
	Tue, 23 Dec 2025 09:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7HEYIXRkSmmFOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Dec 2025 09:44:20 +0000
Date: Tue, 23 Dec 2025 10:44:04 +0100
Message-ID: <87qzslilcr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	robert.jarzmik@free.fr,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ac97: fix a double free in snd_ac97_controller_register()
In-Reply-To: <20251219162845.657525-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251219162845.657525-1-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[free.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,free.fr,kernel.org,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,iscas.ac.cn:email,suse.de:dkim,suse.de:mid];
	URIBL_BLOCKED(0.00)[iscas.ac.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 2F5BF336A0
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Fri, 19 Dec 2025 17:28:45 +0100,
Haoxiang Li wrote:
> 
> If ac97_add_adapter() fails, put_device() is the correct way to drop
> the device reference. kfree() is not required.
> Add kfree() if idr_alloc() fails and in ac97_adapter_release() to do
> the cleanup.
> 
> Found by code review.
> 
> Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Thanks, applied now.


Takashi

