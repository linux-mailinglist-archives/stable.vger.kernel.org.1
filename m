Return-Path: <stable+bounces-152002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D1AD19A4
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA1D168F3E
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AE2820B8;
	Mon,  9 Jun 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BGn7ZFT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QF2DlXvY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LqcjU+6W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p6+PURz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067E28134A
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456745; cv=none; b=QBEfaN0S57SgKE034w24YNCGti/N4u+C3W0HW14osY6h2+qQmbTKur9H+SxdZTRjb/UuT3IuB+aUKULb3qf+2kg0y3S+gAbX7Zum2cF3aMhMySY6cGCEPMX3iWc6NTrUZGJlXSqUJdFwMSgwfps7LoagLGiXUY3Uh8OyC1vwgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456745; c=relaxed/simple;
	bh=L4rAP6SdBVbNSBl3MVYKzpNbkOmsL9wtDH3qpLbcozo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9XX3ULOgAC0IuVH1WUw4mCRLjTowXPUXTU9WO11bKvs5naPT6PTRUbw8fk5wVLFOaA8PKT2FuP/PS4wIESk+bdMqKTe/XxVXkmtwr6nXcE87hP0xRQFfGDVkRMh8bihFGTOYEMpYy0mbLZ3WV3WFQThuV/vNglFTwiZwv2r3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BGn7ZFT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QF2DlXvY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LqcjU+6W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p6+PURz+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D82E21190;
	Mon,  9 Jun 2025 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749456740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaHhrqhrGiZ5nN1aA61UZ7LzTdcCfkGG5DBpOnVpU+k=;
	b=0BGn7ZFTmX9/afoUxuXgYj1U9MYYFmVV6qXbCreUuXC9zfTDIhT1e2svgyEw2ve7Tchjp9
	hOOUYGnhomCO0ABOjEMFxGsMckwIgUhb0T3We033Ph0ZVIHWEFpnFDC835P8E6Rpk+Ye1+
	nuWT7rMINws+3gfJAvFTbl7xP+pmOoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749456740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaHhrqhrGiZ5nN1aA61UZ7LzTdcCfkGG5DBpOnVpU+k=;
	b=QF2DlXvYuaKiVgdZbFpeJH1ofA2S8QRxoH8Wcm18NinWc9YLfgOTF6N7cXQbVJ1Cp2E+cb
	nDo7/CfJgNU3GPCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LqcjU+6W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p6+PURz+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749456739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaHhrqhrGiZ5nN1aA61UZ7LzTdcCfkGG5DBpOnVpU+k=;
	b=LqcjU+6WbIEMwPUO5qSRn46C7xDprgaZmIyMl6RVSeTcAIUa/rznNFcKQdAqq3HWblSTCD
	0KAOiTUWHSXZNdq9lvn4ns3p5uu6t3EWrfZHyr2VfQd1X1A2kO7asL6T2Px1zxZKxY6TFM
	HSn99q46FmGoQN1tFcs0KBS3f9VaCEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749456739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaHhrqhrGiZ5nN1aA61UZ7LzTdcCfkGG5DBpOnVpU+k=;
	b=p6+PURz+n39OA+fcq6ZKHYjmyTjuTNt0rjZ/IrRM7S8kvtevs8xSKEFlqeYJL0wQ+RLvEz
	zNC57tVm7YVYSUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3795613A1D;
	Mon,  9 Jun 2025 08:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CtCfC2OXRmhNBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Jun 2025 08:12:19 +0000
Date: Mon, 09 Jun 2025 10:12:18 +0200
Message-ID: <87wm9l72ql.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: edip@medip.dev
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek - Add mute LED support for HP Victus 16-s1xxx and HP Victus 15-fa1xxx
In-Reply-To: <20250609075943.13934-2-edip@medip.dev>
References: <20250609075943.13934-2-edip@medip.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medip.dev:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6D82E21190
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.51

On Mon, 09 Jun 2025 09:59:44 +0200,
edip@medip.dev wrote:
> 
> From: Edip Hazuri <edip@medip.dev>
> 
> The mute led on those laptops is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the devices.
> 
> Tested on my Victus 16-s1011nt Laptop and my friend's Victus 15-fa1xxx. The LED behaviour works as intended.
> 
> v2:
> - add new entries according to (PCI) SSID order
> - link to v1: https://lore.kernel.org/linux-sound/20250607105051.41162-1-edip@medip.dev/#R
> 
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>

Applied now.  Thanks.


Takashi

