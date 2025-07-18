Return-Path: <stable+bounces-163363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21089B0A435
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F88189A95D
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79842D979E;
	Fri, 18 Jul 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hsbaPKHy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6KDn2y9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hsbaPKHy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6KDn2y9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6E290DBC
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841689; cv=none; b=t/CrsH+FM2Nv/Mtpgv15A7LKya5yLBq2nBUxKZBb3s73fOIcMAYSpN7FougsAevfy9IZDMuLA/VRN5bAyuqP0BZ+Qvwi0ffcl8WV2zwaftZTo0dBRNaoyO2rtVU9H5UD5DWcoI9OejxFb79Hclg1QJGuWVXcBPdLv07zNR77ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841689; c=relaxed/simple;
	bh=tyW74RQHI+ZbJsfVCapdeM+wqGS/p8JfNEiP5o9Oqp4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJ1EtyJjl1ov/99iLJ2RoOgsgoJW2avchPDvI3o7F/P17nVUhm7uuBxwCB1PNfU2MyO3GvgsdftOWywht2HqBBEk+gqultoXhueWi73I8e7mUiueE2uASVYcvGtw/Ywm2XejqSPz0PpvhAKKINpZIaVv+CNM0PHiSz1zhmLfN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hsbaPKHy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6KDn2y9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hsbaPKHy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6KDn2y9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5ABE51F394;
	Fri, 18 Jul 2025 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTORYoyYHw8Obet7y+W8jwmU4dnA/tse77/zbHKQwW8=;
	b=hsbaPKHyYwi/8yQUyELRdMcRWiQJhkBf5w2IxpP+L+yLpJXxi+/izKlcD8XCQIW2Xt1RVs
	u9HRu+NkQcrS2s7+nmvmqDPM+QlBBx9pxn9F9SOjLPov6B+fo2PWZDyRMHxNWYvvekNuab
	+2YvwuXaKmM1k0VNSUBTNqK+MJKcl0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTORYoyYHw8Obet7y+W8jwmU4dnA/tse77/zbHKQwW8=;
	b=h6KDn2y9e64ba0wTIAznJpO0V2Sns083TkpvNB9vLFz1Fg95WKnZXKlFwEwx7sTYfJbu5w
	pO9tuSHqq0kcLEDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hsbaPKHy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h6KDn2y9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTORYoyYHw8Obet7y+W8jwmU4dnA/tse77/zbHKQwW8=;
	b=hsbaPKHyYwi/8yQUyELRdMcRWiQJhkBf5w2IxpP+L+yLpJXxi+/izKlcD8XCQIW2Xt1RVs
	u9HRu+NkQcrS2s7+nmvmqDPM+QlBBx9pxn9F9SOjLPov6B+fo2PWZDyRMHxNWYvvekNuab
	+2YvwuXaKmM1k0VNSUBTNqK+MJKcl0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTORYoyYHw8Obet7y+W8jwmU4dnA/tse77/zbHKQwW8=;
	b=h6KDn2y9e64ba0wTIAznJpO0V2Sns083TkpvNB9vLFz1Fg95WKnZXKlFwEwx7sTYfJbu5w
	pO9tuSHqq0kcLEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2511313A52;
	Fri, 18 Jul 2025 12:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3sRqB9Y9emiZEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 18 Jul 2025 12:28:06 +0000
Date: Fri, 18 Jul 2025 14:28:05 +0200
Message-ID: <87o6th7kfe.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx
In-Reply-To: <20250717212625.366026-2-edip@medip.dev>
References: <20250717212625.366026-2-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5ABE51F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 17 Jul 2025 23:26:26 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
> 
> Tested on my Victus 15-fa0xxx Laptop. The LED behaviour works
> as intended.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Thanks, applied now.


Takashi

