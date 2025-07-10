Return-Path: <stable+bounces-161585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D07B00526
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8B67B3D5A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8D273809;
	Thu, 10 Jul 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lt2uq7gy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="THCxeiiY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CuKZNGn6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GGp2+8IX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A7273808
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157465; cv=none; b=QCD8uL9r3ZwCN9e6WJ1V0jMJAtKhxcjVwNilqdebdMhiVQfRi/PCHYjc2FlexB9DG4jwW302QVCK+0Mc+t/AeeZbvI+k/mTuEEnhNEiTmeRFluL3JZ/aFEXfm0QFQvieszzAiyVpc9/RcHYF8Dl9xckxpA8jjkEwOIs0lgRNKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157465; c=relaxed/simple;
	bh=LaSsV2vwq3+LmiMOjvvCtzy5wlKCbPOt7jm2qzUFcSc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkJw0LLJj7wtflCABmSEEcUKLFV3dZ9HAR4Tfg/SFKZlrZLuwMH8cY+LO61f879X02YOITGR1jUtIT3VqBYFgKZsYCfeL/SHeplTOMtB+4VcvgZ+Qh5qM/JXlMez3Sxa+rg3RCLL8GKNajsknUO43qVZfqis1cqJoNnsq3eYDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lt2uq7gy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=THCxeiiY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CuKZNGn6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GGp2+8IX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3086B2174C;
	Thu, 10 Jul 2025 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twGJxQb8UVyUK3S+JiU8TaYBAXe6Ze9h9EkUNVW1Cdc=;
	b=lt2uq7gyHPKbHv6f+nVnTOFCoE+SgJkg8wDd7oXL1eTCuAJHU75vDpW/eAX7eXEqmUj31f
	ayiEA58VQVEfparMwJ8djX5z7FfO7op8blE5IdTuCnoPn9oZMuJqT3t1nUvkrRnDEMCu1G
	UVqmhBHuTrQlpYm0JhSuA8p4kjYT4ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twGJxQb8UVyUK3S+JiU8TaYBAXe6Ze9h9EkUNVW1Cdc=;
	b=THCxeiiYNZ3oNG79YNU4HrrPyUXM7x7MDgZruzS05Y59LS0aP4zsfmIqLd8+h2yz6RUsAv
	Nn2u6+jPnEdhwkAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twGJxQb8UVyUK3S+JiU8TaYBAXe6Ze9h9EkUNVW1Cdc=;
	b=CuKZNGn6hXiqKKjDosfFtpT1RB8+jrEmZ/S4+wFUJAPkF2puzdlCldjp5ATNcF6Elz2jhl
	wmD401J4D53p0zc6YM41frwzIHu28iQLFgUT+M9nhQ97Z3KiBGMOy2Ipc0qiCSQYHEeVMh
	AAUf6sH/ieawwshaefPbf0cJttWxsJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twGJxQb8UVyUK3S+JiU8TaYBAXe6Ze9h9EkUNVW1Cdc=;
	b=GGp2+8IXB4TbDza9S7xfj4WRSrKJkXeft6Q2vw2LCb5xiD8nYAoX8oAPuBizocPzunFq9H
	58MXFAJViUsSxgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 008C7136DC;
	Thu, 10 Jul 2025 14:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kjeKOhTNb2gPMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Jul 2025 14:24:20 +0000
Date: Thu, 10 Jul 2025 16:24:20 +0200
Message-ID: <87wm8gw2cr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx
In-Reply-To: <20250710131812.27509-1-edip@medip.dev>
References: <20250710131812.27509-1-edip@medip.dev>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medip.dev:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 10 Jul 2025 15:18:12 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
> 
> Tested on Victus 16-r0xxx Laptop. The LED behaviour works
> as intended.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Applied now.  Thanks.


Takashi

