Return-Path: <stable+bounces-72846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074796A3A2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D6B272C9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14E189915;
	Tue,  3 Sep 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RCdcEOGG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R744gflG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RCdcEOGG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R744gflG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018129CEC;
	Tue,  3 Sep 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379685; cv=none; b=tAUSefgvamx/Iq1T6hSZj6unoNN5n+gWRBFR3zQAkrrxxtvdg3C19r0PO2WIcPpizfklL764wnZTeeFSOmNPccFVqSvDrH8JiHfzgHXy1msIGCDIbgSxBCt38ws67p69jcEjBpFIWMZuv5ww5boFxe1xGE9ImWgIa9X+mwWN5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379685; c=relaxed/simple;
	bh=TpWWIJWTY9beWg7Xjx5OcTe4x0uY2HxOpAhUcR/ZONU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNj44cNFMSjSRE56APThT8+rj3k9hE8QZOXVqQJsOfYHupU80oPGJQGsEqNrMt4aMRXs0uEpzdLRzEry4hw6hjzj3dYm/QjTdQoLbSalHRHqr5nXjtL9s7UerTklo34num93yp+3RMrZ7/aqb56DbfmITxQzNjcocSsD0wu+RBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RCdcEOGG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R744gflG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RCdcEOGG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R744gflG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF083219B0;
	Tue,  3 Sep 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnWA+n1AbPlu9NaOAxqyjK1mRJw/IrIjO8WVXc62zs4=;
	b=RCdcEOGGGJohC9Dgm7PFil4GTzV7QBxaGWhGBn79adepkrWh3sUHpW0w9zlIMZjV1+T+09
	YhctxmC7O3etsIFu+LFJYfC9LvTbffTvpvdQrU7Kdcpx/AAgfvZSUX7HrPR+GOjSuVxOgc
	z1T18PwFseJ8r1nZP7l19lD2KixzkT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnWA+n1AbPlu9NaOAxqyjK1mRJw/IrIjO8WVXc62zs4=;
	b=R744gflGW2fcnPX3smOBIVOP2k+/7U48LYY52Hq5T4FqF+vTmJEsfgWcjvzVMim4luvHm+
	JfSTLopivuy69ZBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnWA+n1AbPlu9NaOAxqyjK1mRJw/IrIjO8WVXc62zs4=;
	b=RCdcEOGGGJohC9Dgm7PFil4GTzV7QBxaGWhGBn79adepkrWh3sUHpW0w9zlIMZjV1+T+09
	YhctxmC7O3etsIFu+LFJYfC9LvTbffTvpvdQrU7Kdcpx/AAgfvZSUX7HrPR+GOjSuVxOgc
	z1T18PwFseJ8r1nZP7l19lD2KixzkT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnWA+n1AbPlu9NaOAxqyjK1mRJw/IrIjO8WVXc62zs4=;
	b=R744gflGW2fcnPX3smOBIVOP2k+/7U48LYY52Hq5T4FqF+vTmJEsfgWcjvzVMim4luvHm+
	JfSTLopivuy69ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59FFA13A52;
	Tue,  3 Sep 2024 16:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3u/FGE012YaewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Sep 2024 16:08:01 +0000
Date: Tue, 03 Sep 2024 18:08:47 +0200
Message-ID: <87mskok9dc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Marek =?ISO-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: linux-kernel@vger.kernel.org,	stable@vger.kernel.org,	=?ISO-8859-2?Q?M?=
 =?ISO-8859-2?Q?icha=B3_Kope=E6?= <michal.kopec@3mdeb.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Kailang Yang
 <kailang@realtek.com>,	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,	Athaariq Ardhiansyah
 <foss@athaariq.my.id>,	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org (open list:SOUND)
Subject: Re: [PATCH] ALSA: hda/realtek: extend quirks for Clevo V5[46]0
In-Reply-To: <20240903124939.6213-1-marmarek@invisiblethingslab.com>
References: <20240903124939.6213-1-marmarek@invisiblethingslab.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 03 Sep 2024 14:49:31 +0200,
Marek Marczykowski-Górecki wrote:
> 
> The mic in those laptops suffers too high gain resulting in mostly (fan
> or else) noise being recorded. In addition to the existing fixup about
> mic detection, apply also limiting its boost. While at it, extend the
> quirk to also V5[46]0TNE models, which have the same issue.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Cc: <stable@vger.kernel.org>

Thanks, applied now.


Takashi

