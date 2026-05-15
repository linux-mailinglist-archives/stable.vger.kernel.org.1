Return-Path: <stable+bounces-247409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEi5NBXIBmrjnwIAu9opvQ
	(envelope-from <stable+bounces-247409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:15:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3254A675
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A5930A9435
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322143E3C76;
	Fri, 15 May 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XSbyoXho";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ow/aKMKl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bw0zTaQw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vKq6LRjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BF3E3C74
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828941; cv=none; b=Z/9VFpsGRPlznKSl89PoiwU68PtlXktsN4hs8ia6LY++heQDUGP7E/4TDDFG5hc758nwuzauFRKOgPoqGl2u8msiXA9WRRSFAA4GTeRXYx7qqnZt+g6ASpiC4Keu+Q6/d6mQlFFT2jwgbbAzqW6texRgx47wxvDTKJCQamMEPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828941; c=relaxed/simple;
	bh=86ejFq3rb9bRbylZXChI7VBwk4nDY5IeLVwBUg+x87A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/+48HxoFQfEyuWSLx8A0u6zbm736+OonG+aaKXCkDaASxendFTsJGAXyllAnmd1AVUXzXildMrf6p9CEXQaep+zhsQBhj5dzSKkydPFab+J7O4g/4mJuq5+2rd2omLfbXTPEZsX4ujBM+DClFC9peDseIs3aLscvtMjoQLPGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XSbyoXho; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ow/aKMKl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bw0zTaQw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vKq6LRjY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B817A6AF0C;
	Fri, 15 May 2026 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778828937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=XSbyoXhoTD2zqvyno7XbSRNy5dGMoEsrEcVqxEiI9mHw1dZFWDlWclipuAkTDiCYHq4ug6
	8bMjulMmTfr4n3Vlci/ZpBOhmQtwKBjo9AN1gbLG3clcAh86z6rfbPUUNWqISGnVpN/Ms7
	9nqGiPl98KZSudUZFpayFjmKQXIXEZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=ow/aKMKlv9+2fp/MeV4nKppFKc+WelwY4yx6MlVTPDZ7fA+eGYICMXHivAwj756yyG+Okw
	ODeRs74X9+rCuBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778828936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=bw0zTaQwtyCTyGMkqI5ZHJo+xj2muo/YioTXbLqPW8tZZq+UwWIyGTpnuVH22LO1adHGLb
	FbWC5i1x90y4h+MOQcrGxmODzMpTK24ZdANgqYkQD3pGuExYhJyBkxqnSzeJJf7sSv1iek
	3lZtQN6ncPcWYJtTIAI4dhcIU7ze3SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=vKq6LRjYj359aJBWCCX4Y+FTmEodd2NsSavfhTUkEzpWoyxLA0Pjjk5mEI8Olzfcy2A5RP
	Tn42bYH2+JVfnxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A35593A9;
	Fri, 15 May 2026 07:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id doyJHojGBmoLYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 07:08:56 +0000
Date: Fri, 15 May 2026 09:08:56 +0200
Message-ID: <871pfdup2v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Markus Kramer <linux@markus-kramer.de>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book5 360 headphone
In-Reply-To: <20260513222818.14351-1-linux@markus-kramer.de>
References: <20260513222818.14351-1-linux@markus-kramer.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Rspamd-Queue-Id: 64B3254A675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247409-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,markus-kramer.de:email]
X-Rspamd-Action: no action

On Thu, 14 May 2026 00:28:18 +0200,
Markus Kramer wrote:
> 
> The Samsung Galaxy Book5 360 (NP750QHA, PCI subsystem ID 0x144d:0xc902)
> has severe audio distortion on the 3.5mm headphone jack. Applying
> ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET corrects the output path
> configuration, consistent with fixes already applied to other Samsung
> Galaxy Book models using the same ALC256 codec.
> 
> Cc: stable@vger.kernel.org
> Link: https://github.com/thesofproject/linux/issues/5648
> Signed-off-by: Markus Kramer <linux@markus-kramer.de>

Applied now.  Thanks.


Takashi

