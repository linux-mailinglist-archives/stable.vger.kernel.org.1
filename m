Return-Path: <stable+bounces-244335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFHeD2/0+mn/UgMAu9opvQ
	(envelope-from <stable+bounces-244335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:57:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA54D7818
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E92CA300CBE5
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CB3E022A;
	Wed,  6 May 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TjqOMWbF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FuTHgeqO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eo+gMNq8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IO8qH1k8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15D309EE2
	for <stable@vger.kernel.org>; Wed,  6 May 2026 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054249; cv=none; b=ZKmcf6Vbub7LypgIkOpLfJ3317d56T8hP1327x+h39zbYzWs21zCkWdTqy+J4ckzz8adOJ3jb4iOn0HvJ29ypoPLa9ldsWRtvscPJ+zVd72LsScPjNMcpz9kTHGUQBMEv2ZkYWddNUh1+9IjLyM8jWO1/xY3FJSKXMNwbda6luU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054249; c=relaxed/simple;
	bh=+4rMlMnAeQiawkruVO6udzT6RFeb1t/Jnokuo6RBkgc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vrc1TkbVAkg4TVS+CYIdedPBiK7UBXVNcblOn20MuqbypbxQlrLZTL1NxZ9AREm/95+ojZmPDM3f7w43MjP+3Mhs3KFlBWr2XYCdlgw1Qrq5+xRCptRRm54UJ+sf1vh8XY6XJN6gK7FgmWln5U1mdVMcql98k0cv6LN7nwcW8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TjqOMWbF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FuTHgeqO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eo+gMNq8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IO8qH1k8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9855C12D;
	Wed,  6 May 2026 07:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CDHrcD4WbnljOwo9rsyC3aE/a1ZRwMsaHYTDJs/k8=;
	b=TjqOMWbFKAQxNsK9qRX3ljBjSzxQZOfKSPBhxy8c3wnMKtMVG2851l/YR+TS0EZNZiXitp
	61pFuy5Gb9aIju93zUgR5F1PvkV51rcW7y9inK9zBnETQf9nw1gMG9tVt0ps/iH0+EQds/
	gvrPpUIxSs3mlabQaiIxZNwsvwUP9Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CDHrcD4WbnljOwo9rsyC3aE/a1ZRwMsaHYTDJs/k8=;
	b=FuTHgeqO/SjzL/LjVagI6v1Qlrm0hQ2CZN5pnXyLISu6qotdE7iKgqLL+on++KgJpLDIxg
	mDS5GAFj1xp2iMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eo+gMNq8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IO8qH1k8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CDHrcD4WbnljOwo9rsyC3aE/a1ZRwMsaHYTDJs/k8=;
	b=eo+gMNq8ls7U8f3F09RuQqq67ZzbjcSv03Ez8mJDteMR5Qlt7FafmQ1dDpSVUObE+AM7Yf
	66boI0cdAV2K41thYu1wNKErkBAq4y8r8rC7PuCol8AE3+q3E24iOjqYc+3yRQ68fNILA7
	Whv8zD76PaakQyTxmNiSXFQNFLJOFSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CDHrcD4WbnljOwo9rsyC3aE/a1ZRwMsaHYTDJs/k8=;
	b=IO8qH1k8sUTENF8Ml20oDnDGbrSbzOQ3DgWMmUBFVAFN97TK9jnxke3nz9kNxWBy4XDnPo
	Q5eF1bxqcp74FEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BECF593A3;
	Wed,  6 May 2026 07:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kh5kCWX0+mkpIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 May 2026 07:57:25 +0000
Date: Wed, 06 May 2026 09:57:24 +0200
Message-ID: <877bpht1gb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq: Fix UMP group 16 filtering
In-Reply-To: <20260506-alsa-seq-ump-group16-filter-v1-1-b75160bf6993@gmail.com>
References: <20260506-alsa-seq-ump-group16-filter-v1-1-b75160bf6993@gmail.com>
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
X-Rspamd-Queue-Id: 41CA54D7818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244335-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On Wed, 06 May 2026 05:15:48 +0200,
Cássio Gabriel wrote:
> 
> The sequencer UAPI defines group_filter as an unsigned int bitmap.
> Bit 0 filters groupless messages and bits 1-16 filter UMP groups 1-16.
> 
> The internal snd_seq_client storage is only unsigned short, so bit 16
> is truncated when userspace sets the filter. The same truncation affects
> the automatic UMP client filter used to avoid delivery to inactive
> groups, so events for group 16 cannot be filtered.
> 
> Store the internal bitmap as unsigned int and keep both userspace-provided
> and automatically generated values limited to the defined UAPI bits.
> 
> Fixes: d2b706077792 ("ALSA: seq: Add UMP group filter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

A good catch!  Applied now.


thanks,

Takashi

