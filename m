Return-Path: <stable+bounces-61769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18E93C6F7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757A21F219D6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0019CD00;
	Thu, 25 Jul 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fifzCLgw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TjAouLif";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fifzCLgw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TjAouLif"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D212B7F
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923643; cv=none; b=Qy4arlflatww+Vc17UwlEsC2BP+JWeki6UFQTXvCUhcFFA8ApkhiycnqBTvpuVdsD2Q855hgzXSDzsuq5gzelaKyK8dNBrxijrlm9EGIilkKCetXVffFaHqmUMO4uTFZPb1WecL3BAsLYQpLtla7pEqJ5mzd+iso9WUrZbZyeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923643; c=relaxed/simple;
	bh=1H9E9nYkwDO+iULon3P9RTiXgO9I5YRvVtl3WAHU7do=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSN2Av2uss5BE0ot5w0vHca+ORpFP8vXMB+8VaWOiWkMsyjyBPKlLsi3OZAazs048rXIXCS0AtGX7S9SUtWKqSAfzEcoiNf0+L/DnU6KM5L8b3KzYTweb3C9QO/u4Zw1UIWQArDUEgXqj8LdHbTSTNejcex/0dD2Tp64u8MGDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fifzCLgw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TjAouLif; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fifzCLgw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TjAouLif; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8EE621ABA;
	Thu, 25 Jul 2024 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EngxVbHglzTiaIevXoPrerfngKFY6EQcQXieKN7PBg=;
	b=fifzCLgwCYq/uUkTu4rdmEAcOGAlEUrWU8v+eeAoa3qbAmCamunI6mnG4sJ9eLj+J9MvRq
	iDCgZg9y4AXFeq8h9Q0Dv2KnBs22Irca5beRafFr/uxdDTaN561jAwzlFW/M/NLn2YsAx3
	ckTMATOZjCxHk5sQhi1jbhVWjGPdSgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EngxVbHglzTiaIevXoPrerfngKFY6EQcQXieKN7PBg=;
	b=TjAouLifSA/crrQ66TkZ410QfETYmw3E3oYpNia+iyk9cojsL661tD5Ib09SwhMUCyQQeh
	OpIdxNzA7fVFRTBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EngxVbHglzTiaIevXoPrerfngKFY6EQcQXieKN7PBg=;
	b=fifzCLgwCYq/uUkTu4rdmEAcOGAlEUrWU8v+eeAoa3qbAmCamunI6mnG4sJ9eLj+J9MvRq
	iDCgZg9y4AXFeq8h9Q0Dv2KnBs22Irca5beRafFr/uxdDTaN561jAwzlFW/M/NLn2YsAx3
	ckTMATOZjCxHk5sQhi1jbhVWjGPdSgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EngxVbHglzTiaIevXoPrerfngKFY6EQcQXieKN7PBg=;
	b=TjAouLifSA/crrQ66TkZ410QfETYmw3E3oYpNia+iyk9cojsL661tD5Ib09SwhMUCyQQeh
	OpIdxNzA7fVFRTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FCBB1368A;
	Thu, 25 Jul 2024 16:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RRfuITd4omZQNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jul 2024 16:07:19 +0000
Date: Thu, 25 Jul 2024 18:07:54 +0200
Message-ID: <87a5i5ihet.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de,
	gustavo@embeddedor.com,
	stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case
In-Reply-To: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Thu, 25 Jul 2024 17:56:40 +0200,
Takashi Sakamoto wrote:
> 
> In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
> -Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
> handle variable length of array for header field in struct fw_iso_packet
> structure. The usage of macro has a side effect that the designated
> initializer assigns the count of array to the given field. Therefore
> CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
> while the original designated initializer assigns zero to all fields.
> 
> With CIP_NO_HEADER flag, the change causes invalid length of header in
> isochronous packet for 1394 OHCI IT context. This bug affects all of
> devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
> and 802.
> 
> This commit fixes the bug by replacing it with the alternative version of
> macro which corresponds no initializer.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
> Reported-by: Edmund Raile <edmund.raile@proton.me>
> Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks, applied now.


Takashi

