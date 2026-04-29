Return-Path: <stable+bounces-241905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEtwDLAh8mm/oAEAu9opvQ
	(envelope-from <stable+bounces-241905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:20:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2F1496B73
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D1F3024131
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388C37754B;
	Wed, 29 Apr 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVl2bCK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9IJtw4h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVl2bCK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9IJtw4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF1376BE2
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475827; cv=none; b=L/fvVo+z0rtt3K7WmN5uExNlDjrpO/VA123sLEyBAft8u/r4qnReEzrAa8L6Tc7V1oQay6lIZtiR2VtJBxadH5e2a0F47f9RlO4Dbktlfczizy03MtGCxGZxA8uDPrraZD8eZ1A5LOhjP5Apn4nB+734scJRRJK6239gPrrSH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475827; c=relaxed/simple;
	bh=F+++xzQp5aVAsyzg6uzYAS1GM5medti3+Yx6VGapZIU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIzd1zn5+Ed91BNQrx9dy+6vnzljjNevq0145I+LnWVO0Sso800FrQveS6vSWWyVprK3PpZXAWZDnwUD5pEdb0KySu50j4u0CyJaVtMhGkp0xIZC3G6pHbpTF8WwIHjzJQyengjm+lKtHki0thmT7TpzYnFbfSAa33fEX4axClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVl2bCK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9IJtw4h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVl2bCK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9IJtw4h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C12966A8AB;
	Wed, 29 Apr 2026 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777475819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JjNaM297TMNmQuIWZ5HbTkm/ljPh5n9huno2uduGE=;
	b=XVl2bCK3bsfie7syT0rQ44iLX8dsz8wNS/PFQ5WQ2rY/25YPFHHoj4ca5EA+IvkVHaN5Cv
	tE7Yt5nH1WoZvtrEJMrwYt406EFmNOD4OaJFVTRSmKiYSRMHRq6TpEGP2Pt4MpUFz3g4t5
	c/YgS6VVmkGIOqaW+ZCKCF4BZciJmMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777475819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JjNaM297TMNmQuIWZ5HbTkm/ljPh5n9huno2uduGE=;
	b=s9IJtw4hB1TyvP/OimSURye4hPifQJlwiG7rzvbSRZhvM2Fiet1oSIPqwf/G5O93d3pshG
	YZozZEqc9A+OY1Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XVl2bCK3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s9IJtw4h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777475819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JjNaM297TMNmQuIWZ5HbTkm/ljPh5n9huno2uduGE=;
	b=XVl2bCK3bsfie7syT0rQ44iLX8dsz8wNS/PFQ5WQ2rY/25YPFHHoj4ca5EA+IvkVHaN5Cv
	tE7Yt5nH1WoZvtrEJMrwYt406EFmNOD4OaJFVTRSmKiYSRMHRq6TpEGP2Pt4MpUFz3g4t5
	c/YgS6VVmkGIOqaW+ZCKCF4BZciJmMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777475819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7JjNaM297TMNmQuIWZ5HbTkm/ljPh5n9huno2uduGE=;
	b=s9IJtw4hB1TyvP/OimSURye4hPifQJlwiG7rzvbSRZhvM2Fiet1oSIPqwf/G5O93d3pshG
	YZozZEqc9A+OY1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C018593B0;
	Wed, 29 Apr 2026 15:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lAdTJesg8mkGGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Apr 2026 15:16:59 +0000
Date: Wed, 29 Apr 2026 17:16:59 +0200
Message-ID: <87tsstokyc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Thomas Ebeling <penguins@bollie.de>,
	Ian Douglas Scott <ian@iandouglasscott.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: usb-audio: Fix stale quirk control caches after write failures
In-Reply-To: <20260429-alsa-usb-quirks-cache-rollback-v1-0-01b35c688b80@gmail.com>
References: <20260429-alsa-usb-quirks-cache-rollback-v1-0-01b35c688b80@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: BC2F1496B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-241905-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On Wed, 29 Apr 2026 15:20:00 +0200,
Cássio Gabriel wrote:
> 
> This series fixes stale software cache handling in several usb-audio
> mixer quirks.
> 
> A number of quirk callbacks update kcontrol->private_value before
> issuing vendor or class writes. When such a write fails, the driver can
> keep reporting and later replaying a value the device never accepted,
> because the corresponding get and resume paths consume the cached state.
> 
> - Patch 1 fixes the simple single-write quirk callbacks by restoring the
>   previous cache on error.
> - Patch 2 fixes the RME Babyface Pro packed-state callbacks by updating
>   the cache only after a successful write, since those helpers already
>   take explicit arguments and do not need private_value to be updated
>   before the USB request.
> 
> The split keeps the generic quirk fixes separate from the Babyface Pro
> packed-state logic and keeps each patch tied to its own introducing bug.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
> Cássio Gabriel (2):
>       ALSA: usb-audio: Roll back quirk control caches on write errors
>       ALSA: usb-audio: Update Babyface Pro control caches only after successful writes

Applied both to for-next branch.  Thanks.


Takashi

