Return-Path: <stable+bounces-105553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351F9FA4B2
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 09:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7462A166A93
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C516BE3A;
	Sun, 22 Dec 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buWx6i7B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H7lqMEmi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buWx6i7B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H7lqMEmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73535290F;
	Sun, 22 Dec 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734856052; cv=none; b=oam6zjt21mNEBK+hXSlJlezEUwFJjb7fk9a+pcUz05udxx14aAY2W/NpdWmdnf2Wxq18FLyOANs/6u6LiA2HjOwue1X5KbFpc3dotChBjNTMm6oHATpgnVFzFbhlZ1bzCox3ewtRzC8hUufeTnPPfNU6fYz1u7/LD01RJX9ReME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734856052; c=relaxed/simple;
	bh=P0y6YF7geAMX3Zs7WLZL+7DfTM1U/RAuwLkx93wvwVQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeH+17LM/MksKYvtPiMzty7gvo5xYzNZtv3aDUfbxpX5+0qJRy3TZumKSpjD5GWh0MXGtjcTe2q9mz53miOiKN/1logeppslnDmdJNWzVCPV+4G4q0ilD4qNbw8QObwFxwcNO2y6wljbXtAeDzJkc+1+bVo4Acgd0C2dW/paxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buWx6i7B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H7lqMEmi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buWx6i7B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H7lqMEmi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF37C1F37E;
	Sun, 22 Dec 2024 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734856042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVrI9i3WvxuE/DEox1m2Wwb87x1cqqrB/RdP1vFefzc=;
	b=buWx6i7B5aAqPEeWIHLuWZhAPoaDLKodRchLIIAP4LMo6ElaEt6pMjPZ6hqd+az4E6Doow
	2Ixbj78GXC0iVlao4QLjDVrUC/NOG5zFrxopgq/wr+mieIbCdfQBIxMVCrBplPYJ/qsuDD
	i7GOZERD9wNvtf7IPBq7NE/vk5Fbp2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734856042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVrI9i3WvxuE/DEox1m2Wwb87x1cqqrB/RdP1vFefzc=;
	b=H7lqMEmilmtLci57ltWPweg7Y65geCD4KZO7cU/xGlC271sPFydFsEr61zVsJ/WnAu5BAM
	4qHTksWlAIrzrbAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=buWx6i7B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H7lqMEmi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734856042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVrI9i3WvxuE/DEox1m2Wwb87x1cqqrB/RdP1vFefzc=;
	b=buWx6i7B5aAqPEeWIHLuWZhAPoaDLKodRchLIIAP4LMo6ElaEt6pMjPZ6hqd+az4E6Doow
	2Ixbj78GXC0iVlao4QLjDVrUC/NOG5zFrxopgq/wr+mieIbCdfQBIxMVCrBplPYJ/qsuDD
	i7GOZERD9wNvtf7IPBq7NE/vk5Fbp2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734856042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVrI9i3WvxuE/DEox1m2Wwb87x1cqqrB/RdP1vFefzc=;
	b=H7lqMEmilmtLci57ltWPweg7Y65geCD4KZO7cU/xGlC271sPFydFsEr61zVsJ/WnAu5BAM
	4qHTksWlAIrzrbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 268A213A6D;
	Sun, 22 Dec 2024 08:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EKWaBWrNZ2ewCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 22 Dec 2024 08:27:22 +0000
Date: Sun, 22 Dec 2024 09:27:17 +0100
Message-ID: <87ldw89l7e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgeny Kapun <abacabadabacaba@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Kailang Yang <kailang@realtek.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions Mailing List <regressions@lists.linux.dev>,
	Linux Stable Mailing List <stable@vger.kernel.org>
Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
In-Reply-To: <57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
	<8734ijwru5.wl-tiwai@suse.de>
	<57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: AF37C1F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,alsa-info.sh:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Sun, 22 Dec 2024 08:37:27 +0100,
Evgeny Kapun wrote:
> 
> On 12/19/24 18:38, Takashi Iwai wrote:
> > Could you give alsa-info.sh output with broken and working (reverted)
> > states?  Run the script with --no-upload option and attach the
> > outputs.
> 
> Hi,
> 
> I already posted alsa-info output in a previous message:
> 
> Broken, kernel version 6.12.5:
> https://lore.kernel.org/linux-sound/0625722b-5404-406a-b571-ff79693fe980@gmail.com/3-alsa-info-6.12.5.txt
> Working, kernel version 6.7.11:
> https://lore.kernel.org/linux-sound/0625722b-5404-406a-b571-ff79693fe980@gmail.com/2-alsa-info-6.7.11.txt
> 
> Or do you need alsa-info with a new kernel, but with the offending
> commit reverted?

Yes, that'll be the best for eliminating other possible artifacts.


thanks,

Takashi

