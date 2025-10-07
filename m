Return-Path: <stable+bounces-183509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D83BC0C70
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 10:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41C54F143E
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567CA2D5408;
	Tue,  7 Oct 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X68kBMwj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="akWeeBVS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X68kBMwj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="akWeeBVS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C025522B
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826903; cv=none; b=SgT5ChKoQITjPC+kafS1xUmLi2E0MCRu7u36Ahn65E6VPwvcbLrDEBzDOurM1aK6/azW0A32BASQbfQHWK9LY/aNiyZBXKmY95xzMx72L1Rk4zLsYrIbwIwmBHhpQitB/wrmyYouSqILTL9l20kyiqQcOl7rWo80bVq3+vfVzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826903; c=relaxed/simple;
	bh=Ra5kJllAe6qWnfF9tbHEE/A65R1Xm7mxUl5OZX65qYY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjwPRaX7v4VH18crVQ1L7AE0h3YguHuTg7rwJC69FudG+a30FG6E4XkisFxPVNGxFDQeZEA+xWk2PkAjSMFBz+5QyloiTlFUjMbC55TULAn5M/80AlyiuwLI4wUiZ2bOPC+6Q7nsqUWKdYqq/LgKsPcyTsAIo1D5K3RGfqqtz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X68kBMwj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=akWeeBVS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X68kBMwj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=akWeeBVS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E3CB336EA;
	Tue,  7 Oct 2025 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759826898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7+2JOoZhYF3nq9Kqug81vKxVcf5vp9GFV5f82Vr/EA=;
	b=X68kBMwja5Ywi4Y3U+PAHhQUVtlAtQR9zGZVxJC7vvmd26LMgdv3REpNK9rTbk9o7IHGXD
	0o2ltaqbGqPN0mtft7iSkKl8BvG79ggxvLKL0Zp+Blv0QjaNxtiLOlSpv7K+SxW2zbjFfa
	QmKLICXtITFoWioDL3zgBPoBVLXXiI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759826898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7+2JOoZhYF3nq9Kqug81vKxVcf5vp9GFV5f82Vr/EA=;
	b=akWeeBVSqbWvdtdQFBqEHYwqVOdb1y/mUBug3ohwgwZVMAN4ue1Sd053nSXvfc0KjxsOjs
	lAqzl9kx1O25MdCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759826898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7+2JOoZhYF3nq9Kqug81vKxVcf5vp9GFV5f82Vr/EA=;
	b=X68kBMwja5Ywi4Y3U+PAHhQUVtlAtQR9zGZVxJC7vvmd26LMgdv3REpNK9rTbk9o7IHGXD
	0o2ltaqbGqPN0mtft7iSkKl8BvG79ggxvLKL0Zp+Blv0QjaNxtiLOlSpv7K+SxW2zbjFfa
	QmKLICXtITFoWioDL3zgBPoBVLXXiI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759826898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7+2JOoZhYF3nq9Kqug81vKxVcf5vp9GFV5f82Vr/EA=;
	b=akWeeBVSqbWvdtdQFBqEHYwqVOdb1y/mUBug3ohwgwZVMAN4ue1Sd053nSXvfc0KjxsOjs
	lAqzl9kx1O25MdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC33F13AAC;
	Tue,  7 Oct 2025 08:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eg59MNHT5GilQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Oct 2025 08:48:17 +0000
Date: Tue, 07 Oct 2025 10:48:17 +0200
Message-ID: <87tt0bdrn2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Arefev <arefev@swemel.ru>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
In-Reply-To: <20251007083959.7893-1-arefev@swemel.ru>
References: <20251007083959.7893-1-arefev@swemel.ru>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,swemel.ru:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 07 Oct 2025 10:39:57 +0200,
Denis Arefev wrote:
> 
> The __component_match_add function may assign the 'matchptr' pointer
> the value ERR_PTR(-ENOMEM), which will subsequently be dereferenced.
> 
> The call stack leading to the error looks like this: 
> 
> hda_component_manager_init
> |-> component_match_add
>     |-> component_match_add_release
>         |-> __component_match_add ( ... ,**matchptr, ... )
>             |-> *matchptr = ERR_PTR(-ENOMEM);       // assign 
> |-> component_master_add_with_match( ...  match)
>     |-> component_match_realloc(match, match->num); // dereference
> 
> Add IS_ERR() check to prevent the crash.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.          
> 
> Fixes: fd895a74dc1d ("ALSA: hda: realtek: Move hda_component implementation to module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Thanks for the patch.

The Fixes tag isn't 100% correct, though; the given commit just moves
the code into another file, and the lack of the return value from
component_match_add() was present even before that commit, too.


Takashi


> ---
>  sound/hda/codecs/side-codecs/hda_component.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/hda/codecs/side-codecs/hda_component.c b/sound/hda/codecs/side-codecs/hda_component.c
> index 71860e2d6377..84ddbab660e3 100644
> --- a/sound/hda/codecs/side-codecs/hda_component.c
> +++ b/sound/hda/codecs/side-codecs/hda_component.c
> @@ -181,6 +181,8 @@ int hda_component_manager_init(struct hda_codec *cdc,
>  		sm->match_str = match_str;
>  		sm->index = i;
>  		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
> +		if (IS_ERR(match))
> +			return PTR_ERR(match);
>  	}
>  
>  	ret = component_master_add_with_match(dev, ops, match);
> -- 
> 2.43.0
> 

