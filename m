Return-Path: <stable+bounces-272440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N9Y9ElcSTWprugEAu9opvQ
	(envelope-from <stable+bounces-272440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 16:51:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C371CD99
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 16:51:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0sJYxCis;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0YMMt6+q;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pFiHrJS3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rjWJtHFj;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272440-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272440-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBF930EEBE8
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64D42A15E;
	Tue,  7 Jul 2026 14:35:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9F4252A2
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:35:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434904; cv=none; b=qHJN+jgbIKg8Z9pnM8ShpPkx1ESgqSYrhR/MwdQtO+XfiTrEGsgJs/oTqAVGDI5JIc10+MsIPTn+AkHQmkEUVfuGtJECD7Z5EqCUjxzsOGFnXjRGZ8bZ0MP3+xV2ibJk6668GIFLx/pMb6BToG3Gtpat8WIhH5ng4gUHXoSm/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434904; c=relaxed/simple;
	bh=nyF2vOsXxB4vbdjfJf9HiOfpFFrAc5XBX8bxWrx+bGc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhCQHJyR6HaTLGObdB9d3bmSaFyNnTkThdW1vEsBrIHSmxuELv1FSezhlQZcwvVXkKF/fthYZQeMAwpNvz4j2WVYeGuFa22G/prnUi/P1TU4sCHfmyeiQMfV1er2sCRo93l8fCcnAwreDRoJnjuToIJIKMjFPCRCSbziJWtjMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0sJYxCis; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0YMMt6+q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pFiHrJS3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rjWJtHFj; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E880B75A1D;
	Tue,  7 Jul 2026 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783434901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=0sJYxCisd+QGzcmbynYzVIH9QDSypDTlczoLv8e6HfkvUhPjhwxcE0giV6WHAgD/01PWcE
	mG1aot+mOL0ltPu3i79cA0SeG5QJZH9YEe86gAyojQtAcqdWm3OTLcIEAP2GnpTKN9l4Kj
	1v8aexAM8mqhgpBd5XWV1dcst9TNTFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783434901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=0YMMt6+q0roI62YaJkFhIKcd/5sR1lB4f63W4LkxB1l4C4GWAr4avfeGhBdUDrzEMkPHTP
	QBy+CvWj/ZIoPdBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783434900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=pFiHrJS3/x1MiogWNjVG/0lpNaodhqfYBQ8yTddlr7y46Wy6oLAyjxBD9eZl6O407byz60
	P4uLRUrYmXy6/VDrL17/3ue2Xap2UJvnrq1xyeeyC9ecgd0eryMecO7HynErViW0xSP44s
	BzYV99g+Cb1TsXSAUsCfv9aivphujt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783434900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=rjWJtHFjiNbTlUVGQRVIlnI+Vm3O6GfV/iBXzoEl8CCu2gv8rSpE8ET8sN5JnCs8XrsIXZ
	A8RXHcxxuWIVqiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4426779AE;
	Tue,  7 Jul 2026 14:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okBDL5QOTWpVcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Jul 2026 14:35:00 +0000
Date: Tue, 07 Jul 2026 16:35:00 +0200
Message-ID: <87y0fm6f6z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@baylibre.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ALSA: via82xx: Remove unreachable branch in  snd_via686_pcm_pointer()
In-Reply-To: <20260706131638.15311-1-evg28bur@yandex.ru>
References: <20260706131638.15311-1-evg28bur@yandex.ru>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272440-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:evg28bur@yandex.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:perex@perex.cz,m:tiwai@suse.com,m:u.kleine-koenig@baylibre.com,m:kees@kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:from_mime,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD9C371CD99

On Mon, 06 Jul 2026 15:16:34 +0200,
Evgenii Burenchev wrote:
> 
> The condition
> 
> 	if (count && size < count)
> 
> can never evaluate to true.
> 
> The VIA DMA count register is masked with 0x00ffffff before use, while
> the DMA buffer size is limited to 0x00fffffe bytes. As a result, 'count'
> can never exceed 'size', making the condition permanently false.
> 
> This branch has therefore been unreachable since the driver was
> introduced. Remove the unreachable branch without changing runtime
> behavior.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Applied now.  Thanks.


Takashi

