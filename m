Return-Path: <stable+bounces-86998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A019A5C95
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AB1C214D2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F41D14E2;
	Mon, 21 Oct 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LW9od1VK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGSwbEta";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LW9od1VK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGSwbEta"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418481CF285;
	Mon, 21 Oct 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495224; cv=none; b=B/1v5x96DzIsa/pCgdtDZA/F5MSeizo5nh+GTZk1Glh9vozePwKjypEVFpgL8AlT4Nqo2uC5nmSZalsu/OrAT+QG3i9IrT+aR6G5IIqyVDSd/5Bz0pcT2JwQIqYz7I2E09GOzWiiWpnjeRWeOYkyrdJW++n9lbgwVOqRwvsA+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495224; c=relaxed/simple;
	bh=wC1KE+BmfRoc/3npPs9DVHlDh8wxgRu8yANTxtXabEo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgzOHbG/qN3c89wPDe12AKrslR64watyPgnSkyNYkJwdW5TnPGsnFYFc3PPkwQdXY0aD7CFUkIyj2l1PbKwTfX2Z2CNG+bF2ixWLl6aUSBV97JYGY0ZsAdJmifVcG5FaWLY61X2QuILA3CflqMiuzA28EFEO7lF1e/G//HQQ7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LW9od1VK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGSwbEta; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LW9od1VK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGSwbEta; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 648F721E2E;
	Mon, 21 Oct 2024 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729495220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHnRN1DzmuclfrqOMoAAY9QeUZqGutV4OgwLzgWBYjU=;
	b=LW9od1VK1lku1MA9YvKx4bUPLavrkP72WhGLN0Pjv5uqaRIfECv7BpqtZcmHHOV6MfZOq0
	48opNFBCItkEe6Rmcy2/73R4jeMl6J1QhigWEr4jCw5rBiC3s5/FqIsvp6k/rw/Fm5iimN
	Ha5MXJHLtSHzQiBV8ZKeaWXN+QKx6tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729495220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHnRN1DzmuclfrqOMoAAY9QeUZqGutV4OgwLzgWBYjU=;
	b=MGSwbEtatXq4UJhNEHlnvlWFGyO0pQcPnOmxO1POtWmv52Up3miujCSkBXtqS/SluLYjaX
	b6QkAzidc3CaSsCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729495220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHnRN1DzmuclfrqOMoAAY9QeUZqGutV4OgwLzgWBYjU=;
	b=LW9od1VK1lku1MA9YvKx4bUPLavrkP72WhGLN0Pjv5uqaRIfECv7BpqtZcmHHOV6MfZOq0
	48opNFBCItkEe6Rmcy2/73R4jeMl6J1QhigWEr4jCw5rBiC3s5/FqIsvp6k/rw/Fm5iimN
	Ha5MXJHLtSHzQiBV8ZKeaWXN+QKx6tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729495220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHnRN1DzmuclfrqOMoAAY9QeUZqGutV4OgwLzgWBYjU=;
	b=MGSwbEtatXq4UJhNEHlnvlWFGyO0pQcPnOmxO1POtWmv52Up3miujCSkBXtqS/SluLYjaX
	b6QkAzidc3CaSsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2130D136DC;
	Mon, 21 Oct 2024 07:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o/jTBrQAFmdoTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 07:20:20 +0000
Date: Mon, 21 Oct 2024 09:21:20 +0200
Message-ID: <87zfmxj4zz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE
In-Reply-To: <20241020175624.7095-1-ebiggers@kernel.org>
References: <20241020175624.7095-1-ebiggers@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 20 Oct 2024 19:56:24 +0200,
Eric Biggers wrote:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix the kconfig option for the tas2781 HDA driver to select CRC32 rather
> than CRC32_SARWATE.  CRC32_SARWATE is an option from the kconfig
> 'choice' that selects the specific CRC32 implementation.  Selecting a
> 'choice' option seems to have no effect, but even if it did work, it
> would be incorrect for a random driver to override the user's choice.
> CRC32 is the correct option to select for crc32() to be available.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied now.


Takashi

