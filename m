Return-Path: <stable+bounces-230772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBj4BEWgx2m0ZwUAu9opvQ
	(envelope-from <stable+bounces-230772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 10:32:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1334DED9
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312BF30193AA
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAD3750A7;
	Sat, 28 Mar 2026 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWSUZsQ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nMtNNcKB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWSUZsQ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nMtNNcKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275593F9FB
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690362; cv=none; b=t05f6czdM9PDwbAzVgX8uVY+dfELZ/kAHNDbOf+OnTLJ3iLoT02SnYaUJiTGkiCErVi2zqLO/Uw3g7rrQUSQBgVYz49ZUssFutW4wSSUQ/nb6Yf68m/FfeD9aKv2RK2ThyvgBIJYASaZRwvm0aAYUOE1PE4K5+NOTIOs+p7UCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690362; c=relaxed/simple;
	bh=ZoI3ok3infqqt81/XwnosDHc2OMfIQMyCqDoOF7mcNw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2PR4Ca/jNR2gMT4kKmbjPDcW6wmhg74XU/1kbz3929Ke361sUq3kW4J3JqGRsiQOayyqCCYuAHhT61LGSWda3ShMqcHI1Asq93GKrIbNnI5Lmyowqv8Nwm4LRGlwsY2tGJMAzPpkVLkkdu+BlLu6ffFuVqNo62rwB9eW9M4GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWSUZsQ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nMtNNcKB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWSUZsQ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nMtNNcKB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58F284D38A;
	Sat, 28 Mar 2026 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774690359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kShIea1mYya55JriTuvCxwlu2uRqoJHHrqM4Xt/lmE=;
	b=ZWSUZsQ9nSZl+mwZmuxmK8t+cO17/WdM1zdVrqWoq9lZNt27UXOSmmU9lqL2WMPJVBQiYo
	mV/iuEzxGPIrlNV6WaJ1bDJJSi6aE0QU+qfchpVACK7jlL++4o86rAHoq0+nlFMFIocozz
	2OZ0U+r0dtAU32E1d392YyjTvUWfad4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774690359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kShIea1mYya55JriTuvCxwlu2uRqoJHHrqM4Xt/lmE=;
	b=nMtNNcKBrz45P94C3D67DuUJhwW7jsIhLNHLB0ofj69WaQ7vUgeQu3650dNWBRXbaQNS/z
	qdSYwiUChjS+kaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774690359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kShIea1mYya55JriTuvCxwlu2uRqoJHHrqM4Xt/lmE=;
	b=ZWSUZsQ9nSZl+mwZmuxmK8t+cO17/WdM1zdVrqWoq9lZNt27UXOSmmU9lqL2WMPJVBQiYo
	mV/iuEzxGPIrlNV6WaJ1bDJJSi6aE0QU+qfchpVACK7jlL++4o86rAHoq0+nlFMFIocozz
	2OZ0U+r0dtAU32E1d392YyjTvUWfad4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774690359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kShIea1mYya55JriTuvCxwlu2uRqoJHHrqM4Xt/lmE=;
	b=nMtNNcKBrz45P94C3D67DuUJhwW7jsIhLNHLB0ofj69WaQ7vUgeQu3650dNWBRXbaQNS/z
	qdSYwiUChjS+kaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B3874A0A3;
	Sat, 28 Mar 2026 09:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SYRNBTegx2kuMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 28 Mar 2026 09:32:39 +0000
Date: Sat, 28 Mar 2026 10:32:38 +0100
Message-ID: <87bjg8wb7t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Dustin L. Howett" <dustin@howett.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Daniel Schaefer <dhs@frame.work>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux@frame.work
Subject: Re: [PATCH] ALSA: hda/realtek: add quirk for Framework F111:000F
In-Reply-To: <20260327-framework-alsa-000f-v1-1-74013aba1c00@howett.net>
References: <20260327-framework-alsa-000f-v1-1-74013aba1c00@howett.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-230772-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A1334DED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 16:54:40 +0100,
Dustin L. Howett wrote:
> 
> Similar to commit 7b509910b3ad ("ALSA hda/realtek: Add quirk for
> Framework F111:000C") and previous quirks for Framework systems with
> Realtek codecs.
> 
> 000F is another new platform with an ALC285 which needs the same quirk.
> 
> ---
> Signed-off-by: Dustin L. Howett <dustin@howett.net>

Please drop the line "---" above at the next time.  It makes your
sign-off discarded via git-am.

In anyway, applied now.  Thanks.


Takashi

