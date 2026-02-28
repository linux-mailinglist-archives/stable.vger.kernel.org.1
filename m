Return-Path: <stable+bounces-220054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLEnCAqnomkK4wQAu9opvQ
	(envelope-from <stable+bounces-220054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 09:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0061C15A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7959A3044B6E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB103D9033;
	Sat, 28 Feb 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HLK5WUr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RTsXL4w2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HLK5WUr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RTsXL4w2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC063D7D65
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772267268; cv=none; b=jQ8Gs68K6A/+9oqrlv9NqWPflbBK0CbbUH/D+/nVGx4GFqxohmgeuqsglKnup65G5al8uGDejsoCo2BE4U/z4fr8u/r8miSjEK1/vqRIH6njRmTmQFCY+ReNtKXRqVQOF0/EmBp67/lry20uYJYIAP1dklYYMCtTedbRGUGDGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772267268; c=relaxed/simple;
	bh=rAVqKBXUyATXHXYqdciIbxa07jIlbsajqAPxLONw8IM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXX3Mgqun+gs7fwUHe294UtJOWJFwCTyUyvxQkPByclGezgvdqC8CoFDM+9EIzW91VCBgklOy0oUTU/5ZsCtDOT9TyJr5fEo50swVxomwcmFwyS7iYy8PYa4rqGgj7WhU3gg0nyKiIetxSAdjB6p4UWFFotZXr5t9dRQvVpWhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HLK5WUr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RTsXL4w2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HLK5WUr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RTsXL4w2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 488823F7F2;
	Sat, 28 Feb 2026 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772267265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O6fdXnVf6PXf3fD07T2JXzON6HpB6F1ZqkRMA8D/78=;
	b=HLK5WUr39rrhTuvVecwyN4jOumReCD11EaBvQL5yQIvqO+j1nmpFp1iTEhU82Q03qjzDwL
	MWI6l0TxVdTqgFP6oNlvzODBeAwA2Qt3KjGeucKy75rjYjUbY/k4BjYpcg7QgRmlT5cVzo
	WqmAuT4WI7g/uV12FJW99rkESgS0HAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772267265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O6fdXnVf6PXf3fD07T2JXzON6HpB6F1ZqkRMA8D/78=;
	b=RTsXL4w20LBwyGXrDqnyIo31aIzHX0K6J0SS0s2Rx2b+9gGmLzx/oU2IMUljFrLZ0CCuX9
	G/7cjha0NM3svzAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772267265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O6fdXnVf6PXf3fD07T2JXzON6HpB6F1ZqkRMA8D/78=;
	b=HLK5WUr39rrhTuvVecwyN4jOumReCD11EaBvQL5yQIvqO+j1nmpFp1iTEhU82Q03qjzDwL
	MWI6l0TxVdTqgFP6oNlvzODBeAwA2Qt3KjGeucKy75rjYjUbY/k4BjYpcg7QgRmlT5cVzo
	WqmAuT4WI7g/uV12FJW99rkESgS0HAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772267265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O6fdXnVf6PXf3fD07T2JXzON6HpB6F1ZqkRMA8D/78=;
	b=RTsXL4w20LBwyGXrDqnyIo31aIzHX0K6J0SS0s2Rx2b+9gGmLzx/oU2IMUljFrLZ0CCuX9
	G/7cjha0NM3svzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD8F3EA65;
	Sat, 28 Feb 2026 08:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ja9dAQGnomllRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 28 Feb 2026 08:27:45 +0000
Date: Sat, 28 Feb 2026 09:27:44 +0100
Message-ID: <87fr6l6znj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Pavilion 15-eh1xxx to enable mute LED
In-Reply-To: <20260227121327.3751341-1-zhangheng@kylinos.cn>
References: <20260227121327.3751341-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220054-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 7A0061C15A9
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 13:13:27 +0100,
Zhang Heng wrote:
> 
> The HP Pavilion 15-eh1xxx series uses the HP mainboard 88D1 with ALC245
> and needs the ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT quirk to make the
> mute led working.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215978
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Thanks, applied now.


Takashi

