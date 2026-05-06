Return-Path: <stable+bounces-244338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJZRJQv3+mmlUwMAu9opvQ
	(envelope-from <stable+bounces-244338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:08:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7944D7A43
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7323025AD4
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A413E0258;
	Wed,  6 May 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fwJ+FicX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NZD28I9f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fwJ+FicX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NZD28I9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403623E1233
	for <stable@vger.kernel.org>; Wed,  6 May 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054910; cv=none; b=c6I4pCpP6OAT69s1B/3D7WqXgPG1XJLHBjbEoJF8qXNUPMbFp0VRad9vb9aezXk3ue7omBPsnjAUBYcQGefn+h5Re+GmkU6wehh8zIWhUNTwRUnjReSKCiZxUsSjebOFeMBOfL9EJaqz96oofkwN5cYhFv4u93T3rgcKpKZu4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054910; c=relaxed/simple;
	bh=gEyl16hqhesixVMeiTp2nVanfUrdm9vp/WQiRvupmhQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt6msc+4zxtsUlWVaaCQiYDunKq/ap7n6waGwyp+UsCssf4BfTn33NZTW68SMQbXXtxizW4lUPRZG3NXY2Y8PNsquLZ0mJz5YJvXbZfOiLiw1VW2BN6X8jGFw5WkaXjEMFUKw0dvNipsCi1/iIFFFUYSWjrOEYTSCiirDDMtVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fwJ+FicX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NZD28I9f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fwJ+FicX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NZD28I9f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F20D6B560;
	Wed,  6 May 2026 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtqtT4XAXixsAQa9Vr7kmaosTNtgESlEmzfhfzCcoEI=;
	b=fwJ+FicXV2y6Aq5ZNlAA1Qp9ykBrDEWRG/RU7FSXIX2VkrVFXXrl8YSXftPFsEnZM/9BWC
	9t7pRdckRPexFnnnayyt4sMJ4NEr1pzYD1vfYPbvpWyyxy4kvxWQU/l3pDjDYOe++hIAu7
	tYXpz5BQ9ZoPBrPZnEYcnISDUtSTazQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtqtT4XAXixsAQa9Vr7kmaosTNtgESlEmzfhfzCcoEI=;
	b=NZD28I9firy0+8QOFSC9+FUapdCTQV/U+vosenRnJfG6CC/Rd5Zy03XMUqu7FLM7RrqYSu
	xMLapiDRIrRZh/Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fwJ+FicX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NZD28I9f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtqtT4XAXixsAQa9Vr7kmaosTNtgESlEmzfhfzCcoEI=;
	b=fwJ+FicXV2y6Aq5ZNlAA1Qp9ykBrDEWRG/RU7FSXIX2VkrVFXXrl8YSXftPFsEnZM/9BWC
	9t7pRdckRPexFnnnayyt4sMJ4NEr1pzYD1vfYPbvpWyyxy4kvxWQU/l3pDjDYOe++hIAu7
	tYXpz5BQ9ZoPBrPZnEYcnISDUtSTazQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtqtT4XAXixsAQa9Vr7kmaosTNtgESlEmzfhfzCcoEI=;
	b=NZD28I9firy0+8QOFSC9+FUapdCTQV/U+vosenRnJfG6CC/Rd5Zy03XMUqu7FLM7RrqYSu
	xMLapiDRIrRZh/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E7CE593A3;
	Wed,  6 May 2026 08:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uUbvEfv2+mmbLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 May 2026 08:08:27 +0000
Date: Wed, 06 May 2026 10:08:26 +0200
Message-ID: <873405t0xx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Serialize deferred fasync state checks
In-Reply-To: <20260506-alsa-core-fasync-on-lock-v1-1-ea48c77d6ca4@gmail.com>
References: <20260506-alsa-core-fasync-on-lock-v1-1-ea48c77d6ca4@gmail.com>
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
X-Rspamd-Queue-Id: 3A7944D7A43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244338-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On Wed, 06 May 2026 05:34:47 +0200,
Cássio Gabriel wrote:
> 
> snd_fasync_helper() updates fasync->on under snd_fasync_lock, and
> snd_fasync_work_fn() now also evaluates fasync->on under the same
> lock. snd_kill_fasync() still tests the flag before taking the lock,
> leaving an unsynchronized read against FASYNC enable/disable updates.
> 
> Move the enabled-state check into the locked section.
> 
> Also clear fasync->on under snd_fasync_lock in snd_fasync_free()
> before unlinking the pending entry. Together with the locked sender-side
> check, this publishes teardown before flushing the deferred work and
> prevents a racing sender from requeueing the entry after free has
> started.
> 
> Fixes: ef34a0ae7a26 ("ALSA: core: Add async signal helpers")
> Fixes: 8146cd333d23 ("ALSA: core: Fix potential data race at fasync handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Thanks, applied now.


Takashi

