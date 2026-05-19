Return-Path: <stable+bounces-249467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAItIub9C2qrTAUAu9opvQ
	(envelope-from <stable+bounces-249467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7827577B96
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2635430151E0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08337A49D;
	Tue, 19 May 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bcSHh00h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OJfd/LGN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLmzUD+3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ccw5YveK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D8379EDC
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170744; cv=none; b=Tv2L0GWl6kLmUnE9YujaC1oKtQx8z4I0HH6rnZ21o3FhA2hZ12YUU9Yg5SDklL4q5erAk4lGnVXRN29RfdL5UtMWwjUwt0SuiFpWOIuOgrJLbszlCmLx+KLJ9OBR8o6eTAY7sP1MKi7l3ijKCWa6p2LWeFpGZfESxKPKmGVdZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170744; c=relaxed/simple;
	bh=7rFrH68U+/7/E7s6F01qt2imZUrGqT/Af7wJNtrBwog=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkxj8VIU8iJeKZMie6EFuakczlPIQfi0gqBrtrxGJlBG7zVzbBilYKnVn/8cz1FfuIjBVwJQ2iMaJrYuEML+PB7L4L4eNwW21EQ5GtEZnbrlQMUOWH1wEjnutswY/i++eqfYvDiilzdP4gBrHTSen9evxGuapdWAr9n2hCjomTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bcSHh00h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OJfd/LGN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLmzUD+3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ccw5YveK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C373467D9C;
	Tue, 19 May 2026 06:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779170740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7B7tfpN7KVnjD31fX/E5ws8Tf7vaiYQY6EaHkLHEFo=;
	b=bcSHh00hMFIBIKry4HzlSJwEp77dhrjmRKeduyPZ+/hfWLdnMQVtEVAByb4NoEbQ8UIQGg
	xDFgJLSID8smHxAC1U5ig2sJas0ptHkZEoN1UlyeMMltUrjs+BAHYupKjONZLq657sUYKS
	BV+zmoym5gH4VIPVkptHPtd1cbET70I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779170740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7B7tfpN7KVnjD31fX/E5ws8Tf7vaiYQY6EaHkLHEFo=;
	b=OJfd/LGNFhlkTXahnmAPf4F/BMi+9fO3+Gxta1g34KeLwPWcHgGcStkEsJukWb7bibhsq6
	9AQp7OCqkSXdOHCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zLmzUD+3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ccw5YveK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779170736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7B7tfpN7KVnjD31fX/E5ws8Tf7vaiYQY6EaHkLHEFo=;
	b=zLmzUD+38dBh+nkUdqsZWeqJEN+UgBK+s3BUcFZnEHJ2V3jacsX77bUmuHiV+4UIse2qhN
	Xm1Uqim5En+O9nDseGNbhr8shVfzWRq19R/isGoUY0lJl0L3VK5wvFrQJ27pJtetaxTe/G
	6mWEhTH/u6vqzL8SEIqgxkTLSnjI794=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779170736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7B7tfpN7KVnjD31fX/E5ws8Tf7vaiYQY6EaHkLHEFo=;
	b=Ccw5YveKegF3GGkCc/mHaAQW48t0mmjsmbCUNtCzZF1uBb96DJI/wASVRQTXNXbd62jrNv
	pOfVqF1k52gC38CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6BC4593A8;
	Tue, 19 May 2026 06:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eOfjJ7D9C2pxfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 May 2026 06:05:36 +0000
Date: Tue, 19 May 2026 08:05:28 +0200
Message-ID: <87bjec3pef.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP 16 Piston OmniBook X
In-Reply-To: <20260519015535.891156-1-zhangheng@kylinos.cn>
References: <20260519015535.891156-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: E7827577B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 03:55:35 +0200,
Zhang Heng wrote:
> 
> The ALC245 sound card on this machine requires the quirk
> `ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX` to fix the mic and mute LED.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221509
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

