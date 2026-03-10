Return-Path: <stable+bounces-224513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OcyG8YzsGl2hAIAu9opvQ
	(envelope-from <stable+bounces-224513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:07:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC2252E29
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766BB30244CC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF630B50C;
	Tue, 10 Mar 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gt5oTT6q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0zwAQzE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B8KBkKIG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EnJ+ZysA"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79042C11CB
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155265; cv=none; b=KDlRWb7Tanth8X3qCcEBxbb43QfHbdG7l5TYkIG8I+FQX6WolpOAl/cZ5+UjBDRh3RTiQFxOFoBWcycuptf5aUJEU2I5ZXWXy053EvqwOGGceInIGK8uKZKnVvsNYLQ7284PIc2pkEfTPpnfDStLhsUjSP70i/14awEqz8f8vGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155265; c=relaxed/simple;
	bh=UinGvoENzCKqpay/yZPCI8XGtcpRKy8yOEuG4j2UelA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WO7g6FaPycsDhuPfBcQrPQtOj8toh+HyjcQAqYnPRXLILpC1rKb8SThwAC4KZtH7EIcUV22GmmKR5fpluzHp7AiCW8oFoEyvq2vciuddy3LfM6otrrPI2q5VwveC5Q+AG5EQbJJUFgRa9QAalyKPYoCDWKvsauSMN2bBnr0Ld90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gt5oTT6q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0zwAQzE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B8KBkKIG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EnJ+ZysA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E0835BCFF;
	Tue, 10 Mar 2026 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773155263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=gt5oTT6qwuntLkeowNMdA8iXmLMS5caVPTKEtfsJrUqmq0lhjmdkv063RGZ4r0ZaMe4eBi
	F/iDFTX/re5MLkamm5YhlI20HNlooLD326Mbr8aAVwIq+NtZR2yEgeOIjQBLK/yCB5dr7F
	tU1R5g7v7fAv0WWAChw6snt126YxTgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773155263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=Y0zwAQzENQUhHJU79wwJodOb+PiIZNNMRz2R5nqfW0/nEcFGcHub7Ajv8gTWo9JNIt89lX
	+4eJQ+0TkHaP8PCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B8KBkKIG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EnJ+ZysA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773155262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=B8KBkKIGC1jlMt6mWQXGlSnUURmAa6Fg34C8DnNpPdK8HauOqDCLGkHiI22HqjTDAxocEU
	k4QdOnf6YA5VWwt/8lJqjt8SKKDyu2PJap1VKOv5eDaY5+xYLzgOLvdAdvedqMJ7Ap43kM
	q+uYZMGo1Me4nvIYfZ1T4NJlQM0nC/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773155262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=EnJ+ZysAzSrNqsl0CMa1GmScbFVyqMBTTVBVge6hKFrNiD69EFyZExt/ajsyTn3Yfzjp4W
	odvxkXAtWfhPK8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD723F4FB;
	Tue, 10 Mar 2026 15:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xsiqNL0zsGmmPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 15:07:41 +0000
Date: Tue, 10 Mar 2026 16:07:26 +0100
Message-ID: <878qbzradt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
In-Reply-To: <20260310102921.210109-3-thorsten.blum@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 09EC2252E29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224513-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 11:29:20 +0100,
Thorsten Blum wrote:
> --- a/sound/aoa/soundbus/i2sbus/core.c
> +++ b/sound/aoa/soundbus/i2sbus/core.c
> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
>  	int err, ret = 0;
>  
>  	list_for_each_entry(i2sdev, &control->list, item) {
> +		if (list_empty(&i2sdev->sound.codec_list))
> +			continue;

This can be even outside the loop and immediately return 0, as the
remaining part is also the loop of codec_list.

  	int err, ret = 0;
  
 +	if (list_empty(&i2sdev->sound.codec_list))
 +		return 0;
 +
  	list_for_each_entry(i2sdev, &control->list, item) {
  		/* reset i2s bus format etc. */
  		i2sbus_pcm_prepare_both(i2sdev);


thanks,

Takashi

