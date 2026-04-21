Return-Path: <stable+bounces-240198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVTI4Wj52nw+QEAu9opvQ
	(envelope-from <stable+bounces-240198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:19:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250C43D3FE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF9143010266
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E4377566;
	Tue, 21 Apr 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hep1bix2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HcFdPr2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hep1bix2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HcFdPr2d"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032232C030E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788354; cv=none; b=OVpRsOac8npzrQ0q2DNXTPzUko+Tv3+2A8ToSSGOtjVd0ja92vlCaEb7EFi68WNQZP+yEY2qW6IQPvA70JnobqjMPlSfge5Dke8LxKV7mA71gRApUH2wU21v8lPoTDVwMWocVhrzIXYCdCAZNNyHk/n2OKt7tz9fBUfOVZALQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788354; c=relaxed/simple;
	bh=qdnY4J3JgYo7Jr7jwvQS1bAzbkOLkEG9ARm/Ah0z1PI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2+/NkSANrSXIJ223vLKWG7uu1nR9sSh2YjtyA1QhaaR8DJCo+jR2/BPEEN4R6lONwliXLmfKTW5fy0H3BYEUT31aencna/u6FYsRZCfTtVrk+hi54GeaRvmvm+1sVKARC/CObUWIt2QV7wc4us8j0L/0d1r/ZM9BTtiYAOn2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hep1bix2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HcFdPr2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hep1bix2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HcFdPr2d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09B255BD14;
	Tue, 21 Apr 2026 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776788350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpOwWQHmOKM78IGa/ZYNGTUn6+hdZ3reixIB0EE2s1s=;
	b=hep1bix2j49ys1YFxJ854vSyXweYY4C6gI1bLK3NvQ0ybt0brGzlCofxJboQhzXmZAnUhG
	RNPtg4i7MkG+mC2qOXhFJ+J71xb36lUx3LxK12/SXYLMsdVO00YXDHtS8H2OPeVIxo4NkN
	BK/UUpC0MQttOzFZ17Ys4CYRC/2IIrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpOwWQHmOKM78IGa/ZYNGTUn6+hdZ3reixIB0EE2s1s=;
	b=HcFdPr2dHqji/q5wsVAnTpsRaA+DbOJ6lZRENdNvIO/dYXfakY1fNR/ivYm1JO2Ua9/7Wl
	6orsDoFOy/PShLBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hep1bix2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HcFdPr2d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776788350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpOwWQHmOKM78IGa/ZYNGTUn6+hdZ3reixIB0EE2s1s=;
	b=hep1bix2j49ys1YFxJ854vSyXweYY4C6gI1bLK3NvQ0ybt0brGzlCofxJboQhzXmZAnUhG
	RNPtg4i7MkG+mC2qOXhFJ+J71xb36lUx3LxK12/SXYLMsdVO00YXDHtS8H2OPeVIxo4NkN
	BK/UUpC0MQttOzFZ17Ys4CYRC/2IIrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpOwWQHmOKM78IGa/ZYNGTUn6+hdZ3reixIB0EE2s1s=;
	b=HcFdPr2dHqji/q5wsVAnTpsRaA+DbOJ6lZRENdNvIO/dYXfakY1fNR/ivYm1JO2Ua9/7Wl
	6orsDoFOy/PShLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D65593AF;
	Tue, 21 Apr 2026 16:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rmQlLX2j52mhNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Apr 2026 16:19:09 +0000
Date: Tue, 21 Apr 2026 18:19:09 +0200
Message-ID: <87wly08ewy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcmtest: Fix resource leaks in module init error paths
In-Reply-To: <20260421-alsa-pcmtest-init-unwind-v1-1-03fe0c423dbb@gmail.com>
References: <20260421-alsa-pcmtest-init-unwind-v1-1-03fe0c423dbb@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,perex.cz,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240198-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 0250C43D3FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 15:03:06 +0200,
Cássio Gabriel wrote:
> 
> pcmtest allocates its pattern buffers and creates its debugfs tree
> before registering the platform device and driver, but mod_init()
> does not release those resources when a later init step fails.
> 
> As a result, a debugfs directory creation failure leaks the pattern
> buffers, while platform_device_register() and
> platform_driver_register() failures leave both the pattern buffers
> and the debugfs tree behind. The recent fix for failed device
> registration only dropped the embedded device reference.
> 
> Add the missing cleanup for the debugfs tree and pattern buffers in
> the remaining module init error paths.
> 
> Fixes: 315a3d57c64c ("ALSA: Implement the new Virtual PCM Test Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Thanks, applied now.


Takashi

