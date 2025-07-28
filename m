Return-Path: <stable+bounces-164903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F97B138E2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD88F3B6485
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA22472B5;
	Mon, 28 Jul 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DGh2E+Eb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TAstKcIW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XHGQ63LX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9nqtOTCg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5A9478
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698298; cv=none; b=SWBqvBhMx9NFMdBTdMxrGEXRvX+midQ5NYlRhdcD8ohjcQLatH5bTcRAuzew/tArBtTJzPjDj3hBZJSFglxnv/vQTu6oeVMG/aBTR76GV1gkjAiWPQaAEL8xGfL+UNPAHEbEhwauxzls+W7GkZpGEm7pvbzsAJ2XXm13STYnmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698298; c=relaxed/simple;
	bh=7UpPgxs1I1TXCEGFmgdE4wxKMzot2oB6O/sQuVIrtiQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jC0ojrJu8TXSPQQAzfqbxn3X9iBH3ZJufBZuJmlzkMvj0HH1LdncyEwYdYB4Cv/CZXqsi1M/W11Fs5JSfr/Ty1yjzq5RUCv+trlXKyaKvhsU9MylwAGohK5edswbxJfHDIsPjmnh/3O6u2AGGAeGxFmWT3eAxk5f2kswSnJrRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DGh2E+Eb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TAstKcIW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XHGQ63LX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9nqtOTCg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 981792126C;
	Mon, 28 Jul 2025 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753698294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zASefuuTTStfmBz1vDE4KcNGKpBsyQg0O+52IlyS5k=;
	b=DGh2E+Ebxra7G9BlcKou2CHl5uiaIyAFesBYmHmuF9gfdwGpUKTZfRtp4P4uOKtoKW/L/A
	BeDfVQNM0+8bAoSJn1O03kOcVwKiVjNXUna9JkVGfN84wrHmeEJFIBcXh5qG/OsIP6xLGt
	BkUSY4VsTdW3weLbOZeE+vyc4NR0PWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753698294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zASefuuTTStfmBz1vDE4KcNGKpBsyQg0O+52IlyS5k=;
	b=TAstKcIWGpOIQzPTzpFRPhwOxPU7hl6P/6X05mUkoP9SQqpIAYVfxO0EJhzZoUhI8uZ+KV
	DrqHKEGqy5OGyLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753698293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zASefuuTTStfmBz1vDE4KcNGKpBsyQg0O+52IlyS5k=;
	b=XHGQ63LX8b8cPahsvyahbcjzDbLpb6DqzPnE/32hV9kUmZ05cOMorMarZ5C+IMDWbHUDG9
	ZxZNTltBrV1UrevvYdS0iZDaWnk03qqQyAiQoOXx+sDuwU79iBNXVbQgJnCWHHF5PWdcOi
	pC+x7HzyIwqdOfnWZjophz6QT8nRe98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753698293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zASefuuTTStfmBz1vDE4KcNGKpBsyQg0O+52IlyS5k=;
	b=9nqtOTCgbs2V2z0A+mAmk94MhFpL77Pgc7EY8+REk3JejYwaFZmAm9qRKHf51sFPrnrwNq
	jzReVFMI6k/X72CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69949138A5;
	Mon, 28 Jul 2025 10:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDUWGPVPh2jCQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Jul 2025 10:24:53 +0000
Date: Mon, 28 Jul 2025 12:24:52 +0200
Message-ID: <87ecu0vci3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
In-Reply-To: <20250725151436.51543-2-edip@medip.dev>
References: <20250725151436.51543-2-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medip.dev:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 25 Jul 2025 17:14:37 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
> 
> Tested on Victus 16-r1xxx Laptop. The LED behaviour works
> as intended.
> 
> v2:
> - adapt the HD-audio code changes and rebase on for-next branch of tiwai/sound.git
> - link to v1: https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Applied now.  Thanks.


Takashi

