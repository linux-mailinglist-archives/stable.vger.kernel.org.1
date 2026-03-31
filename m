Return-Path: <stable+bounces-231430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFttIXvZy2kaMAYAu9opvQ
	(envelope-from <stable+bounces-231430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:26:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43A36AE99
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38F313043EBD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA93FADE1;
	Tue, 31 Mar 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LzI7QhF6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JAEryULn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDkCNBzW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G3dbrkuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7E3D811A
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966938; cv=none; b=Akx7Hto0e/x3xLQe2EFr8LRiginCORJ7GWB4aa25ceAQXbEPIkNcVd7pgL43046Z/dvW6nQGaaD7ReWeudeVyvlQvmuKvCDA51rYctT9EcTh+IRw1kNzyXsKmhaw5wonFTkp7qdMRafdvh0H/sPs6rIHSAFFvjLWCLZmWPcKMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966938; c=relaxed/simple;
	bh=fQINRo9ydVTIGynu6xITCAmN4qQjuHCKXlep3kR4GQY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFoov2ZzsFJjkHSUtTs1DLgzJHRUG7f1RbwuCoUTparLOSE461mKn3r8U0nvu2EFKhwr5sOiLXzDQ3mWL5EvIQ5mj45G4AAhBNI102DEBVbFUCCm2N15slxq/+E9YjRNHO3tI9O8yudkvuMVhpOxE1Bu1zq5t5BGftT2qbHkAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LzI7QhF6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JAEryULn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDkCNBzW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G3dbrkuj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3237B5BEE4;
	Tue, 31 Mar 2026 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774966934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCePN37UxviDEzywWQPI86khS33CCgdBTgtQg3xHhB4=;
	b=LzI7QhF6gGS9mYs82Sl/E5WJzAmbcGjxAylv8BYSd7cWWo2eeokOWqO8IXFOk2OADi28ty
	aIimQNaUyHUR1llhWVAK8IffIA1yXPGKTpNveCcWtsNJhmEPBGp6GMcIY8L7qFSKBFsfWi
	ailFaYva0zO1RKxOEYW7z2/l2p9sGig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774966934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCePN37UxviDEzywWQPI86khS33CCgdBTgtQg3xHhB4=;
	b=JAEryULnDewA33H6+AJ3Np98HJxSWO2RqwfpZLmRuI5v3/jl8EqWb316vuSFi+j6TTg4Jq
	1ZLTKmbVt+3CEGAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XDkCNBzW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G3dbrkuj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774966933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCePN37UxviDEzywWQPI86khS33CCgdBTgtQg3xHhB4=;
	b=XDkCNBzW1IH/BGCN1V83qBHPl5kilplJQiyvTk45g+uR8ha8qNM/I3MJQH6YNOPga7lBxa
	cv7AynJNNCXWVDhYLuhiio9fTfsZQHL0bRrcb9zcOunMYX6ix+1BrsxEysia1S03ZMomEE
	OTfi0DMiR9zxkJeacblZ9aNT6hPYvsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774966933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCePN37UxviDEzywWQPI86khS33CCgdBTgtQg3xHhB4=;
	b=G3dbrkujsdkNB9TfEeNNtUpikB/R/2sNaz3hNP/VKgff6/VJ2OaQFZVvLl1X9BrPgLNA04
	qTGMNH5uyfZyX2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17BB64A0A2;
	Tue, 31 Mar 2026 14:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cjM4BZXYy2mpEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 31 Mar 2026 14:22:13 +0000
Date: Tue, 31 Mar 2026 16:22:04 +0200
Message-ID: <87a4vorsdv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: add quirk for Acer Swift SFG14-73
In-Reply-To: <20260331094614.186063-1-zhangheng@kylinos.cn>
References: <20260331094614.186063-1-zhangheng@kylinos.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231430-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 8D43A36AE99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 11:46:14 +0200,
Zhang Heng wrote:
> 
> fix mute/micmute LEDs and headset microphone for Acer Swift SFG14-73.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220279
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

