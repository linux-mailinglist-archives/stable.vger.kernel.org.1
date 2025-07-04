Return-Path: <stable+bounces-160147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C58AF886C
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 09:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5622D171DD0
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A06272E74;
	Fri,  4 Jul 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y7zCijDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/iWYUa5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y7zCijDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/iWYUa5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C41271459
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612670; cv=none; b=IuqvCTooCBVbGbTRDXVbTi15bSOt0I1l6phqLA3wkfsE+1x3PVDG7LhVl1XakPpkEU9u6I5DrRljxILJ81pwY7vDTmDs+avmvmmFYreE8ITzXkLrHAnHz++bCCfi5r9oPGJMDwY1vyeYogrLOdBRLxxMjtCA054iQLJM6700s4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612670; c=relaxed/simple;
	bh=q8MGlInxUq2U58uz+13j8IYxo81MxiuX6NHBpDA1BLs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryQ2gqMnNwP76L9OVFM2GP0Zisz77FLGvtKqtyTds2Z+xijPS1l51+O0Bwf892agzjehcrxGveqgFcrrx5089ZfUlkwbUT+W7uILXCnKUR6AH4NtY27nEowNdoEqJ9gliq85Iok0SzhbWl0faO7HDUX09cP1tBQGOUzHhF1cgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y7zCijDd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/iWYUa5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y7zCijDd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/iWYUa5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E0A421199;
	Fri,  4 Jul 2025 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751612666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93zBfA/0tQWTwIrjOguHoRiI0TNTL61A1ryUU7m56i4=;
	b=y7zCijDdKjyRD8m2nfTd0w+pvWpiFBORUEOlFdXtO0+EqeJMeIImhEClChsO5Gg/lDRwTR
	5AGZe0NNvsAQ2K3U307CqdLCC4oTgwsOwvqSboJyCe2UelL4NNVef/K6CfyHyQf2pHW7Ls
	4XXcF/xar2Cb27A1Hf7mvGBR3J9Jq9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751612666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93zBfA/0tQWTwIrjOguHoRiI0TNTL61A1ryUU7m56i4=;
	b=J/iWYUa5THxptx8zdBHU5aKM+dWvFokbWxtcDvxyZ7RZnQLKncHEOML2YthnoSDQqGdvvu
	RCkg3S3TrhQXMgAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751612666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93zBfA/0tQWTwIrjOguHoRiI0TNTL61A1ryUU7m56i4=;
	b=y7zCijDdKjyRD8m2nfTd0w+pvWpiFBORUEOlFdXtO0+EqeJMeIImhEClChsO5Gg/lDRwTR
	5AGZe0NNvsAQ2K3U307CqdLCC4oTgwsOwvqSboJyCe2UelL4NNVef/K6CfyHyQf2pHW7Ls
	4XXcF/xar2Cb27A1Hf7mvGBR3J9Jq9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751612666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93zBfA/0tQWTwIrjOguHoRiI0TNTL61A1ryUU7m56i4=;
	b=J/iWYUa5THxptx8zdBHU5aKM+dWvFokbWxtcDvxyZ7RZnQLKncHEOML2YthnoSDQqGdvvu
	RCkg3S3TrhQXMgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DB2A13757;
	Fri,  4 Jul 2025 07:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aSMxAvp8Z2jhdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Jul 2025 07:04:26 +0000
Date: Fri, 04 Jul 2025 09:04:25 +0200
Message-ID: <87h5zsphc6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_pnp()
In-Reply-To: <20250703200616.304309-2-thorsten.blum@linux.dev>
References: <20250703200616.304309-2-thorsten.blum@linux.dev>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 03 Jul 2025 22:06:13 +0200,
Thorsten Blum wrote:
> 
> Use pr_warn() instead of dev_warn() when 'pdev' is NULL to avoid a
> potential NULL pointer dereference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 20869176d7a7 ("ALSA: ad1816a: Use standard print API")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied now.  Thanks.


Takashi

