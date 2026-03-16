Return-Path: <stable+bounces-225627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8La1L4I5uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212329DDC7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6282B304BDBD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73D3CF66B;
	Mon, 16 Mar 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vgv7s/ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gjcEdIt8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vgv7s/ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gjcEdIt8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2933CF04A
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680711; cv=none; b=msPie8Tsx550CJPZbr/RhDjCs7/VYLGgTDiWKkMFL4SctNKXd3VbS/ARzCsmpLnSth3rbc1cbMVT/HG81WfmwoE4PNcv58rY54wZE130J3JiWdVMik/vu5W56wyGXmpNSVoIouPrmWhTNttj/TBC3Cx00YNQ5Zd7cEqK0CiiKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680711; c=relaxed/simple;
	bh=GzL7TYK1oURajQyS0LjB8/8I45o9SdSJlFmd9VwbCok=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIuvaZ7k7xdKQNs5XG/kuytNzvLmDhhXlBivLOuvjw9mFBaSoatKmalnS4ruc/wGjtMYW3AiLHMEOahRMlI+0dIMjKBIGHvvys9NNqjIebjtyD5ecNix4ofXL4i4YdLE/JoN0EBbX2yAS5MCFPnU2fSn4d1PyvuUblFkm6heCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vgv7s/ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gjcEdIt8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vgv7s/ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gjcEdIt8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 954464D2FA;
	Mon, 16 Mar 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773680707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQr5TAuKOLuQF5KTq3GmDGN6Xpm1CTrnFL2vIuagGds=;
	b=Vgv7s/niHK/dpC8lrB+Ew/q6GhB4HqJa+BDYazfgQ176TwwZcHfYw4a6YS5zB/PL23C3KQ
	RRVJcCMzh7TX0d7oKCuWwhw2o+fm/8AsrFKhxIP5sQ+OPcPpwti3nfUVYjSLKQyjcLiYbY
	ma9oBiFEO6+snXRe7pIDwgfmT0YicGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773680707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQr5TAuKOLuQF5KTq3GmDGN6Xpm1CTrnFL2vIuagGds=;
	b=gjcEdIt8qnQUUDZ49rQrgeV6mnuGmh+IzJRV9SiMjgNfpozoU25WT+hLQXrp76uIHOBiQv
	8Th5xnp797DQI9Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Vgv7s/ni";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gjcEdIt8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773680707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQr5TAuKOLuQF5KTq3GmDGN6Xpm1CTrnFL2vIuagGds=;
	b=Vgv7s/niHK/dpC8lrB+Ew/q6GhB4HqJa+BDYazfgQ176TwwZcHfYw4a6YS5zB/PL23C3KQ
	RRVJcCMzh7TX0d7oKCuWwhw2o+fm/8AsrFKhxIP5sQ+OPcPpwti3nfUVYjSLKQyjcLiYbY
	ma9oBiFEO6+snXRe7pIDwgfmT0YicGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773680707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQr5TAuKOLuQF5KTq3GmDGN6Xpm1CTrnFL2vIuagGds=;
	b=gjcEdIt8qnQUUDZ49rQrgeV6mnuGmh+IzJRV9SiMjgNfpozoU25WT+hLQXrp76uIHOBiQv
	8Th5xnp797DQI9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47E524273B;
	Mon, 16 Mar 2026 17:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ts5HEEM4uGkgQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Mar 2026 17:05:07 +0000
Date: Mon, 16 Mar 2026 18:05:06 +0100
Message-ID: <87o6kn7lj1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	chris.chiu@canonical.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	danYc_LG@outlook.com,
	baojun.xu@ti.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: add quirk for ASUS Strix G16 G615JMR
In-Reply-To: <20260316022843.2809968-1-zhangheng@kylinos.cn>
References: <20260316022843.2809968-1-zhangheng@kylinos.cn>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,canonical.com,realtek.com,opensource.cirrus.com,outlook.com,ti.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-225627-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0212329DDC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 03:28:43 +0100,
Zhang Heng wrote:
> 
> The machine is equipped with ALC294 and requires the
> ALC287_FIXUP_TXNW2781_I2C_ASUS quirk for the amplifier to work properly.
> Since the machine's PCI SSID is also 1043:1204, HDA_CODEC_QUIRK is
> used to retain the previous quirk.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221173
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

