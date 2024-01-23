Return-Path: <stable+bounces-15490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0148389FF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21501F23A51
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F457892;
	Tue, 23 Jan 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0x1Ak+4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYC6YHnA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0x1Ak+4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYC6YHnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6857311
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001048; cv=none; b=qSzrx6Eip9UWI3xl6Z//yc/WnsSCSKYW+MPIEuJ+7RXHde4o5DVF83gEcufn9ii6qL3h5DoyxNrHXnc1S1jEJSFd9oVF1CXFPYnOEEDV6+JdTwvDTROmmPc/Wm9MhtXkZOf/Pq5l1EJKgBZjOydykaVjpHxcYCKsh6ySxvJlyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001048; c=relaxed/simple;
	bh=bNFdOL02CBO0C44RvehTzLxd9AZl2fYVPseevYUViPQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9DcSTpLdP9WIvA7Wvrb0PZNQbWqUyIuS4fdQd+WRHzvM7/y7xoaYY37v+jHBcqylibEIrqHh/xbclOk/Ta9nrYnEnkLXulRW0j0XqNT9aD6glMVUX7FyCHktG+zSAmOSEUSzi+PewajGCeEbF6NoMy20ZmTF9imtZrhJGOOyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0x1Ak+4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYC6YHnA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0x1Ak+4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYC6YHnA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0558921F85;
	Tue, 23 Jan 2024 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706001044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC3VW3QBC1l58sfwYheFxzzmmh18eRd63H9zA1NV1w=;
	b=D0x1Ak+4hF433f08BKxC9mPEzCwmmKzbEIVh5p6iazDYIFDdgQBYUzEaNIKpmklwLnpfH6
	GvRTyKkIXa8WeApq8h5q0aiXPyJiE8Ywi4jnlCed1sKEsrTpHVeNdbI8U/RWr3qwfTOSWo
	QoH6zjOyNVavnXZ3n5TDs5TNA2tjkFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706001044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC3VW3QBC1l58sfwYheFxzzmmh18eRd63H9zA1NV1w=;
	b=IYC6YHnAMSOBN27RdukcOOlGiZ9so+T0b6UWzaeVDQTna0NhSSN8qxi2waUBYo/L/od8aP
	nE5HTN+yVGxtd1Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706001044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC3VW3QBC1l58sfwYheFxzzmmh18eRd63H9zA1NV1w=;
	b=D0x1Ak+4hF433f08BKxC9mPEzCwmmKzbEIVh5p6iazDYIFDdgQBYUzEaNIKpmklwLnpfH6
	GvRTyKkIXa8WeApq8h5q0aiXPyJiE8Ywi4jnlCed1sKEsrTpHVeNdbI8U/RWr3qwfTOSWo
	QoH6zjOyNVavnXZ3n5TDs5TNA2tjkFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706001044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC3VW3QBC1l58sfwYheFxzzmmh18eRd63H9zA1NV1w=;
	b=IYC6YHnAMSOBN27RdukcOOlGiZ9so+T0b6UWzaeVDQTna0NhSSN8qxi2waUBYo/L/od8aP
	nE5HTN+yVGxtd1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B6C136A4;
	Tue, 23 Jan 2024 09:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KWadK5OCr2U3fgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Jan 2024 09:10:43 +0000
Date: Tue, 23 Jan 2024 10:10:43 +0100
Message-ID: <87msswmn3g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Julian Sikorski <belegdol@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	Julian Sikorski <belegdol+github@gmail.com>
Subject: Re: [PATCH] Add a quirk for Yamaha YIT-W12TX transmitter
In-Reply-To: <20240123084935.2745-1-belegdol+github@gmail.com>
References: <20240123084935.2745-1-belegdol+github@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D0x1Ak+4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IYC6YHnA
X-Spamd-Result: default: False [-1.34 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.53)[91.89%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[github];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0558921F85
X-Spam-Level: 
X-Spam-Score: -1.34
X-Spam-Flag: NO

On Tue, 23 Jan 2024 09:49:35 +0100,
Julian Sikorski wrote:
> 
> The device fails to initialize otherwise, giving the following error:
> [ 3676.671641] usb 2-1.1: 1:1: cannot get freq at ep 0x1
> 
> Signed-off-by: Julian Sikorski <belegdol+github@gmail.com>

Thanks, I applied now.

But at the next time, try to check the following:

- Use a proper subject prefix; each subsystem has an own one, and this
  case would be "ALSA: usb-audio: Add a quirk..."

- Use the same mail address for both author and sign-off
  
- Put Cc-to-stable in the patch description instead of actually
  sending to it now


Takashi

