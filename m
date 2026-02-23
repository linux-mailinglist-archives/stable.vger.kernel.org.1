Return-Path: <stable+bounces-217709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIanDtoVnGkq/gMAu9opvQ
	(envelope-from <stable+bounces-217709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C0173543
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DB9303A6DC
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF334D909;
	Mon, 23 Feb 2026 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IrxT7snw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kgm3zxxU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IrxT7snw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kgm3zxxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26934DB78
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836861; cv=none; b=OY65ZnAgSn+DF3bLEJ0rpmOehjC2Nvrh/49FxQ8u38w4ao3KXGo+fjqNvdOb6vNNyNsyn9tUPfW0Zxg119FqO9CYnQQd86voQ97SAqcnSt4OwJavbkdRXS3K/IJd+FSjEf8KGGYoHcoiJ5eH0rTtJXZ5RL+B1JQWH952mXZL7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836861; c=relaxed/simple;
	bh=ogxN6n1ODyQcDYgeHtJSC/Pv88ShOTQ0TRwpZWHpjBA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Scm9P2Ov0nrrf2B72BLY+nCXRzikLbqqQ2xN/p97YOPCR1XK69ab/URcaz+orA6KCFgppYKcehoZynxZd/CPKSZFI+2/Bq2ok1Px1zN5oTC4ROirxdddHTFEHLNJBUzBXXqjWMk2Yj1QO8XxN+LUZtNFUut+2K2yKANOPwM526w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IrxT7snw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kgm3zxxU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IrxT7snw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kgm3zxxU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A13DD5BD01;
	Mon, 23 Feb 2026 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771836858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl91X3IzBKeDPouMTQHRcAQhhqjeu2Pad47S/POEbDM=;
	b=IrxT7snwZubOuD9mc8UGe9E9e/HO3BU5NzTH6+sPnjFoiLDlF0KWIKkUzZAwMdKnkUwhha
	7mxU12T3EwAcCfrQ1bSAq3qiKwu9Vb5AMpJDVpt2OIgP9OzQ/8X36iMMngGmKvnte5FG8h
	cGAcesANbSWEbkHbpIfU9G7CJlNW1tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771836858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl91X3IzBKeDPouMTQHRcAQhhqjeu2Pad47S/POEbDM=;
	b=kgm3zxxUib24usIRUiUKHcSteCqlWVYSyua/aeudoRdZ7rNGrElHgsZd13h4wUFD8jJSvW
	Hgb2YCT+ACtyiwCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IrxT7snw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kgm3zxxU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771836858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl91X3IzBKeDPouMTQHRcAQhhqjeu2Pad47S/POEbDM=;
	b=IrxT7snwZubOuD9mc8UGe9E9e/HO3BU5NzTH6+sPnjFoiLDlF0KWIKkUzZAwMdKnkUwhha
	7mxU12T3EwAcCfrQ1bSAq3qiKwu9Vb5AMpJDVpt2OIgP9OzQ/8X36iMMngGmKvnte5FG8h
	cGAcesANbSWEbkHbpIfU9G7CJlNW1tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771836858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl91X3IzBKeDPouMTQHRcAQhhqjeu2Pad47S/POEbDM=;
	b=kgm3zxxUib24usIRUiUKHcSteCqlWVYSyua/aeudoRdZ7rNGrElHgsZd13h4wUFD8jJSvW
	Hgb2YCT+ACtyiwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5D23EA68;
	Mon, 23 Feb 2026 08:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IXaHFboVnGlbfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Feb 2026 08:54:18 +0000
Date: Mon, 23 Feb 2026 09:54:18 +0100
Message-ID: <874in7n8lh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Charalampos Mitrodimas <charmitro@posteo.net>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Acer Aspire V3-572G
In-Reply-To: <20260221-fix-detect-mic-v1-1-b6e427b5275d@posteo.net>
References: <20260221-fix-detect-mic-v1-1-b6e427b5275d@posteo.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217709-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 864C0173543
X-Rspamd-Action: no action

On Sat, 21 Feb 2026 20:40:58 +0100,
Panagiotis Foliadis wrote:
> 
> The Acer Aspire V3-572G has a combo jack (ALC283) but the BIOS
> sets pin 0x19 to 0x411111f0 (not connected), so the headset mic
> is not detected.
> 
> Add a quirk to override pin 0x19 as a headset mic and enable
> headset mode.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221075
> Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Thanks, applied now.


Takashi

