Return-Path: <stable+bounces-215770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JC+Ks9EjGl+kQAAu9opvQ
	(envelope-from <stable+bounces-215770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:58:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7B122792
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1702B300861A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B366353EC6;
	Wed, 11 Feb 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbWQ2ciE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wtI6Z6GR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbWQ2ciE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wtI6Z6GR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27501BBBE5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800329; cv=none; b=hFzDu6g45NfEtob7i5t+wk9RkDzMJMwwdRWH2yNnhrZkWoGeimIi6unPaNUna/kcZqFlRqWVUCUufRGCSas8KcGpvKGFdxzhzIelJsez5Sle7MoWMOTHcI/1UwKLTl3XbKXD5jmYTJd5vuo9kPwMHDUO6reoYrowApm5eBUTUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800329; c=relaxed/simple;
	bh=VOCTj8CIBobsYBDIb6CWbtQhQ4UI1viaPB+/cJpEJj8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5f9vvnyVOxaR8A9WhnV1ELA00T8S0QwSEFPQxQeoSyc9lsd4rfCTr09GJ41sG1c1qwwFC8bBep51kWIj+0gQEoubR77LmQPbmxogbhtRcs/p0X6frxgVhcvbpsQ7AMwZOV0EJjnbfpc6BA+xkzdn726oLpRYvxqHkzc6Kfz9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbWQ2ciE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wtI6Z6GR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbWQ2ciE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wtI6Z6GR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3284A3E6F2;
	Wed, 11 Feb 2026 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770800326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV71KXvd8W+k5ABKoyXEOmi0wOn0ULwGJ/gDb7KfQmo=;
	b=PbWQ2ciETHYxNOa7JLTBJM6QT3WEdlT5RSRLJd2N/plf7QUsqHC2hUz4IZcpDVKQWz/A0r
	143/XtweN421ETCSif5XXCBmqhGpe6/StZDcE5liCA6OratmBDLOxzpRsNVrTZLoUhYnLd
	mRwnRgyZtHRTgp8hidNZt4xYZG+U63w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770800326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV71KXvd8W+k5ABKoyXEOmi0wOn0ULwGJ/gDb7KfQmo=;
	b=wtI6Z6GR05GsAGxwnQyDY75taRZWPenTIzgV8ooMvHeECAi+i1htirLkmIVpxhltkDbvgI
	CTSMcTsPcsdBnVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770800326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV71KXvd8W+k5ABKoyXEOmi0wOn0ULwGJ/gDb7KfQmo=;
	b=PbWQ2ciETHYxNOa7JLTBJM6QT3WEdlT5RSRLJd2N/plf7QUsqHC2hUz4IZcpDVKQWz/A0r
	143/XtweN421ETCSif5XXCBmqhGpe6/StZDcE5liCA6OratmBDLOxzpRsNVrTZLoUhYnLd
	mRwnRgyZtHRTgp8hidNZt4xYZG+U63w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770800326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV71KXvd8W+k5ABKoyXEOmi0wOn0ULwGJ/gDb7KfQmo=;
	b=wtI6Z6GR05GsAGxwnQyDY75taRZWPenTIzgV8ooMvHeECAi+i1htirLkmIVpxhltkDbvgI
	CTSMcTsPcsdBnVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D96013EA62;
	Wed, 11 Feb 2026 08:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9EyIMMVEjGlyWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Feb 2026 08:58:45 +0000
Date: Wed, 11 Feb 2026 09:58:45 +0100
Message-ID: <87pl6bu056.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Eric Naim <dnaim@cachyos.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)
In-Reply-To: <20260210093403.21514-1-dnaim@cachyos.org>
References: <20260210093403.21514-1-dnaim@cachyos.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,cachyos.org:email]
X-Rspamd-Queue-Id: B1E7B122792
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 10:34:02 +0100,
Eric Naim wrote:
> 
> Fixes microphone detection when a headset is connected to the audio jack
> using the ALC256.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Naim <dnaim@cachyos.org>

Applied now.  Thanks.


Takashi

