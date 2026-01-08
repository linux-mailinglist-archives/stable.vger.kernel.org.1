Return-Path: <stable+bounces-206257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCCD01638
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 08:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5BDD30019C4
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AE33B962;
	Thu,  8 Jan 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1oIsKLmo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSt/2a0u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2h65fjR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xGz7iFgT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50233B946
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856963; cv=none; b=N2vsiyuv9BgrNeF+JcBSb2nWiZTEPkpgT2R4cqFWPIWNnZaEN6Z+QZOBCLUknJ1pxWmReNdPYYLOlcyLsIYfEn0SBV82nuIf88rYiI7FYSA9t8qAA5O5EXjhzUps/jLZjO7i3QIL21EAJbTMl//vmguxljorbks36tLVh8Xpz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856963; c=relaxed/simple;
	bh=C0x9Us3kZSNBZXg1ryEpxMecRoJB/tTZRgsadALeFrs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK1fPTLB8ot4IdjbQYXLIPFo520sYODVcbt7lWmxXuCvq1gqGddUuNZhmjJu4JAvXbWS9FTGWSthKhRCR0JRpzt87MvwyE6ot5xq9G+s+L8Rr96OvVuu5NPUgPSnDNWUoevn7oiaCEKF59deXu6lmBhLrvUj9bsWoqdFulfnh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1oIsKLmo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSt/2a0u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2h65fjR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xGz7iFgT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFC6D5BD4B;
	Thu,  8 Jan 2026 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767856957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15R0s/8wnRrsIExoQFc/IdXdRPV23JX8M6kBTR46dWM=;
	b=1oIsKLmoZuut/WrNY9J8rUlrPWBsIwr+5bBhptcDp/kn9rixg7/L0iAz8XwYP4j3FwWePA
	mA2g+SMhUa0plH5bOLaKXU4+tfiR9Kvb4hE098moWhdvp8xol6ZrNcIxAuTyUUtmls5cnp
	b9lPzMJZjSIlBy0tuOPZgZe3jJ2Z5O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767856957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15R0s/8wnRrsIExoQFc/IdXdRPV23JX8M6kBTR46dWM=;
	b=iSt/2a0ur1hYpf66US+9UqDfP5V+2vh3qUOh0jcC1W4d86d3/RfeVPDu3zyuacS74GGHKS
	aLuFO2ZrRqbFOBCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K2h65fjR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xGz7iFgT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767856955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15R0s/8wnRrsIExoQFc/IdXdRPV23JX8M6kBTR46dWM=;
	b=K2h65fjRfCke3N5ZRZwc3SW1Jw2zJI6OO2obMAxGbjgT3wxmKz79kVeNmoVzGW/JR96OEp
	aofh8wEp4V3qbrd3vrMmbMsm7XP+ZF+T3HTdsw8KvJ+fQ/qx6PBcjo4jJ/3+y6IhWtUMlm
	WoI1gtl8zHEEfbrdW9tDr8xaLJEEfE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767856955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15R0s/8wnRrsIExoQFc/IdXdRPV23JX8M6kBTR46dWM=;
	b=xGz7iFgTxkYTy0G61rp03gkV01VzSFmNOpA8LhrJtrQFMQvjfuCUlcUHX8SjRYSi86xNZf
	z+1mO4W9dQeKVjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B70B23EA63;
	Thu,  8 Jan 2026 07:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PX+MKztbX2mSIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Jan 2026 07:22:35 +0000
Date: Thu, 08 Jan 2026 08:22:35 +0100
Message-ID: <87fr8gh8lg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Linux Sound ML <linux-sound@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer
In-Reply-To: <20260107213642.332954-1-perex@perex.cz>
References: <20260107213642.332954-1-perex@perex.cz>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,perex.cz:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: DFC6D5BD4B
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Wed, 07 Jan 2026 22:36:42 +0100,
Jaroslav Kysela wrote:
> 
> Handle the error code from snd_pcm_buffer_access_lock() in
> snd_pcm_runtime_buffer_set_silence() function.
> 
> Found by Alexandros Panagiotou <apanagio@redhat.com>
> 
> Fixes: 93a81ca06577 ("ALSA: pcm: Fix race of buffer access at PCM OSS layer")
> Cc: stable@vger.kernel.org # 6.15
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Applied now.  Thanks.


Takashi

