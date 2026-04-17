Return-Path: <stable+bounces-238454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKGvCefn4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:57:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB9418450
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A898300DEEC
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F30358372;
	Fri, 17 Apr 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uOtKqEKg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ElttCxlc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uOtKqEKg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ElttCxlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9E35AC0E
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412643; cv=none; b=duLmWbuh9OZgZVEncKXPpSCH9wSWqS7r9gjIm0O2Gj+1CzVNuj0LQlLoLdfT0eYGFFsH/6GmC8JtNGg75jds0I+f1z1mwvpDMxsai96xPdmCZuGU1x44c+Z1djlqXjO3AkXhKqEFNiPs3b0m8Kknr4XhGFB2eN4viJcAMterd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412643; c=relaxed/simple;
	bh=h7V5gRHeUyFMvCWkEJCqp9jf9FaT/CFPhsUjrAEDjFg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhmgBd4GxVJ9i7d2bCgveSoyn9euljX3a6p8I8VSfewCONNWWKH6roU/sywzscAhGPcJ47Kzc2J7/jDMCFJ67FSaH2zzaiWnxMku//kZiNFFra9dmdZ3rQrQzQDnM3EuvPDpHq6Jm9UbS1LoxF/CUFOuoo4ZoeNxdu4OSSDTZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uOtKqEKg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ElttCxlc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uOtKqEKg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ElttCxlc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5E336A98D;
	Fri, 17 Apr 2026 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776412640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dONKJJqrYHVWrPyzvTCLEzVqE1Rbhu06dwqhlHYiL74=;
	b=uOtKqEKgmKfdm/E42q706GhWNJy5Eemhi6eg5BlCNzasST7j7Vq85NxVx+OA2bI3ZbCrPX
	t/azF/GBqvGCaIIMefWCGMWWxm3BYX56x4f8HdU0ie96XlyhRiw4lKqpcXuqKFs5GEhXg1
	lSaVvay+MIaBS5xSw0hCVYOiQe07bh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dONKJJqrYHVWrPyzvTCLEzVqE1Rbhu06dwqhlHYiL74=;
	b=ElttCxlc88ZyxCbjdtiuIbeUGOMD609JQ6QNA3aHae1fd69ZBrCFvWM6dPMqOfqmgO/0Dz
	ZISwa/xBaIZtRQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uOtKqEKg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ElttCxlc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776412640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dONKJJqrYHVWrPyzvTCLEzVqE1Rbhu06dwqhlHYiL74=;
	b=uOtKqEKgmKfdm/E42q706GhWNJy5Eemhi6eg5BlCNzasST7j7Vq85NxVx+OA2bI3ZbCrPX
	t/azF/GBqvGCaIIMefWCGMWWxm3BYX56x4f8HdU0ie96XlyhRiw4lKqpcXuqKFs5GEhXg1
	lSaVvay+MIaBS5xSw0hCVYOiQe07bh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dONKJJqrYHVWrPyzvTCLEzVqE1Rbhu06dwqhlHYiL74=;
	b=ElttCxlc88ZyxCbjdtiuIbeUGOMD609JQ6QNA3aHae1fd69ZBrCFvWM6dPMqOfqmgO/0Dz
	ZISwa/xBaIZtRQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B00DE593AE;
	Fri, 17 Apr 2026 07:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8qbKeDn4WkeHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Apr 2026 07:57:20 +0000
Date: Fri, 17 Apr 2026 09:57:20 +0200
Message-ID: <87h5padnof.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcmtest: fix reference leak on failed device registration
In-Reply-To: <20260415193138.3861297-1-lgs201920130244@gmail.com>
References: <20260415193138.3861297-1-lgs201920130244@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238454-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0FB9418450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 21:31:38 +0200,
Guangshuo Li wrote:
> 
> When platform_device_register() fails in mod_init(), the embedded struct
> device in pcmtst_pdev has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
> 
>   mod_init()
>     -> platform_device_register(&pcmtst_pdev)
>        -> device_initialize(&pcmtst_pdev.dev)
>        -> setup_pdev_dma_masks(&pcmtst_pdev)
>        -> platform_device_add(&pcmtst_pdev)
> 
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 315a3d57c64c5 ("ALSA: Implement the new Virtual PCM Test Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Thanks, applied now.


Takashi

