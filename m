Return-Path: <stable+bounces-240199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCcAJSyl52kI+wEAu9opvQ
	(envelope-from <stable+bounces-240199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:26:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1843D531
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4C1306F5D3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB2364038;
	Tue, 21 Apr 2026 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xcg/kDkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K04QsIDd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xcg/kDkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K04QsIDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4029217F33
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788383; cv=none; b=NGLvf7Qb1JmShIP/U5IK5OKzYaenzodt1mvZ4XAo1at1ZngHtS5hSQggesk5EzbZx0DNN8SLVN8197jPbAszJQkWUFvhNVV3NV6Nr92EkmfWX5+9OQbKOJOiJFKTKKTx3TmhISeW5KN80ZCKCUV3DmHKUlYDVCX7uCi7FqxmbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788383; c=relaxed/simple;
	bh=EfjAQQsL27Jojsn1SlZFbwmlWkyQ5b0m56nH4ft7OfI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaQuzENL9VtGynTvjukuDeFrS4qU1ce5btfLPC0n2r4dJ562tF+SNwuhQRE855x3gIPcPJ4G8dH0ljrOA7T2eutUzAUSJSuszmwhe8gpAff0U85lY5G9OUEVfY8nz1EB61Xq5gwGZxL2Qs6EAQrZF0FDUi5u1S5gjMzF/M6BrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xcg/kDkp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K04QsIDd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xcg/kDkp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K04QsIDd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF006A7FE;
	Tue, 21 Apr 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776788380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=xcg/kDkpncOJTXmtwVDFK4VtSJFk9gZOsR5aZnnPMK8nT7WvxOfsNJYgrviC9R030UVKQy
	7oS9iLrdLPHIT/ORyq+nVDetaBpKoYAQT+6kFjObSUU3wbVaF84GTcFi0VhPwgCwsAOIPM
	MEwA285uBcibgMqDO4o3mXcNS/aNJQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=K04QsIDdIuUe//4q5BUGokyblCApHCdNfJfDUERezqUYUwkN7EmssxSqNShG5enX1vDw3F
	9qqF61zhMk99QnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776788380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=xcg/kDkpncOJTXmtwVDFK4VtSJFk9gZOsR5aZnnPMK8nT7WvxOfsNJYgrviC9R030UVKQy
	7oS9iLrdLPHIT/ORyq+nVDetaBpKoYAQT+6kFjObSUU3wbVaF84GTcFi0VhPwgCwsAOIPM
	MEwA285uBcibgMqDO4o3mXcNS/aNJQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=K04QsIDdIuUe//4q5BUGokyblCApHCdNfJfDUERezqUYUwkN7EmssxSqNShG5enX1vDw3F
	9qqF61zhMk99QnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5859593AF;
	Tue, 21 Apr 2026 16:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cP4nLpuj52nbNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Apr 2026 16:19:39 +0000
Date: Tue, 21 Apr 2026 18:19:38 +0200
Message-ID: <87v7dk8ew5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Spencer Payton <spayton681@gmail.com>
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa2xxx
In-Reply-To: <20260421084918.14685-1-spayton681@gmail.com>
References: <20260421084918.14685-1-spayton681@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[195.135.223.130:received,10.150.64.97:received,2a07:de40:b281:106:10:150:64:167:received,100.90.174.1:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 1FF1843D531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 10:49:18 +0200,
Spencer Payton wrote:
> 
> The mute LED on this laptop uses ALC245 but requires a quirk to work.
> This patch enables the existing ALC245_FIXUP_HP_MUTE_LED_COEFBIT
> quirk for the device.
> 
> Tested my Victus 15-fa2xxx (PCI SSID 103c:8dcd).
> The LED behaviour works as intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Spencer Payton <spayton681@gmail.com>

Thanks, applied now.


Takashi

