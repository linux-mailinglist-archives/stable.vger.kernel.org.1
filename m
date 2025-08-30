Return-Path: <stable+bounces-176738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2ACB3C8D9
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996465E824B
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF627A929;
	Sat, 30 Aug 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zt61LiXM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V/OZoirX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zt61LiXM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V/OZoirX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E05242D72
	for <stable@vger.kernel.org>; Sat, 30 Aug 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539729; cv=none; b=i/2kdmJpD93U2bGfrDYT+lcmXpsELbHLh/K9MOA147zLRzrF2UwY6ZJaB24bL+LH6AmXKH1lJjonsMheCQpRaJaeoTh/wQbYRWLnZ2ZUWrOBSBjVZHgqSfj6ISXDkD7YJ58912yUQgwfOwF3l3R5cEtm6jcv2aa23Qyia/4TbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539729; c=relaxed/simple;
	bh=h3XcFgrNF8Sgup5YIQEI/aLE9bPnfguKvj4TjQMUQac=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myUAp6ztGvfqfGIWu3h6sb+0ehDuhfkUIoh8azpRsWHUqDdr+7sudzKELiy8R1YflkFXKX+8FPF05+1J6jpatUSStnS9SstRhVJ1aP18LjaSNwSzSo8FKcunJy142d4Ybca3tpyc45K6U9sRIaP+Kx9kRvLLtD/ypJ8q5KUrwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zt61LiXM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V/OZoirX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zt61LiXM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V/OZoirX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CA18336BE;
	Sat, 30 Aug 2025 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756539725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPJMcdjKXkKG89xb2emN+RVyypynR6wa9yGi5gvh1Fc=;
	b=Zt61LiXMPjqbd743gCjs8wn2xudd2/dl+D+MzlNAY+bsHIRYaGOhb/cEF6diQudpLooZ4N
	iRkZZLk5SJGRFtcuYIxanahqR9Zdqv2PNMhLU+yYXthfud3yGxtR0+bsA8EdLxwbK4MmrQ
	5Stbm4h4K9oQU86vkpxnYiGocyByIlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756539725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPJMcdjKXkKG89xb2emN+RVyypynR6wa9yGi5gvh1Fc=;
	b=V/OZoirXzHPCISSwrbIwlQGloB3A4w0JPWOnKzX4JI7oYcE0b5hu7Jp+8wX3swlejyEFqZ
	VaAjCbI66jE1Q0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756539725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPJMcdjKXkKG89xb2emN+RVyypynR6wa9yGi5gvh1Fc=;
	b=Zt61LiXMPjqbd743gCjs8wn2xudd2/dl+D+MzlNAY+bsHIRYaGOhb/cEF6diQudpLooZ4N
	iRkZZLk5SJGRFtcuYIxanahqR9Zdqv2PNMhLU+yYXthfud3yGxtR0+bsA8EdLxwbK4MmrQ
	5Stbm4h4K9oQU86vkpxnYiGocyByIlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756539725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPJMcdjKXkKG89xb2emN+RVyypynR6wa9yGi5gvh1Fc=;
	b=V/OZoirXzHPCISSwrbIwlQGloB3A4w0JPWOnKzX4JI7oYcE0b5hu7Jp+8wX3swlejyEFqZ
	VaAjCbI66jE1Q0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 444A4139B1;
	Sat, 30 Aug 2025 07:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wQgTD02rsmg4HQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Aug 2025 07:42:05 +0000
Date: Sat, 30 Aug 2025 09:42:04 +0200
Message-ID: <87tt1pfe7n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda: tas2781: fix tas2563 EFI data endianness
In-Reply-To: <20250829160450.66623-1-soyer@irl.hu>
References: <20250829160450.66623-1-soyer@irl.hu>
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 29 Aug 2025 18:04:49 +0200,
Gergo Koteles wrote:
> 
> Before conversion to unify the calibration data management, the
> tas2563_apply_calib() function performed the big endian conversion and
> wrote the calibration data to the device. The writing is now done by the
> common tasdev_load_calibrated_data() function, but without conversion.
> 
> Put the values into the calibration data buffer with the expected
> endianness.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Applied both patches now.


thanks,

Takashi

