Return-Path: <stable+bounces-230612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNO8DkxUxmkkIwUAu9opvQ
	(envelope-from <stable+bounces-230612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:56:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E034210C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D851A30460B6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDEE3DD523;
	Fri, 27 Mar 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GrBUNfvK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N2R2qa93";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GrBUNfvK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N2R2qa93"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E953DC4CF
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605222; cv=none; b=QYoKIBgyLzSHNf9f0ixD2QqAcwP2fAbMmtSkmAfS5UPD66mUidurTXCTAELR5W9+fLZaZ3v8reqX0rY/J0887PUSlkwcx4Q6fVQXFPJzg7Dplo6dbOnwLYFSy9Owu6vekQdySo9BDmt20OUf9a5TwzCjSo7ZNsbgMsAVnu8BBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605222; c=relaxed/simple;
	bh=XLtQzIbC/76Sc8SqFtXo2f9nurdfq4NY4odmhochFXc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKEPZThEvQhjwXgneAb8prG4XrVE45BrOAsAsi5ApUFwnCyF+VKFZDBqlC2R1PdfHNAjgHu30b1N9GoqswjBz+j3nHRAxIT1JTooVd1EZL1xOwM6PhU64Ppmv/6vDKrznb7erC2kAVD0cUUYxPquMEIN45zkvNIbPUZzy61s1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GrBUNfvK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N2R2qa93; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GrBUNfvK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N2R2qa93; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D4F34D250;
	Fri, 27 Mar 2026 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774605217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLk/95zehhjlx7OT4urvcq3KzHamMIvpNEYxK5bdS0A=;
	b=GrBUNfvKkK/v0ABSqZGx8UMvs5VcJW11IcPj4WSxtKfJr4Fhj+IY+nLPSMZYhRrA1LpXQx
	yLnuyyQ1MXgPKvzWSF7rSIdPzW4XFo0UvhiNk4Gzbz68MEy7IBqs89fRgwCv8cjnNB/4/d
	ZBMwkc+u6bbSWU5gyqkPen3OQTzQNFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLk/95zehhjlx7OT4urvcq3KzHamMIvpNEYxK5bdS0A=;
	b=N2R2qa93TSlCwkzt6bTwoMfeTJAWQQ8yv2FS+N6fkcPrgFK7NS7vKHCrOpFS4epBLXKgTS
	VEUC5CoPjUNo8jAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GrBUNfvK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N2R2qa93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774605217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLk/95zehhjlx7OT4urvcq3KzHamMIvpNEYxK5bdS0A=;
	b=GrBUNfvKkK/v0ABSqZGx8UMvs5VcJW11IcPj4WSxtKfJr4Fhj+IY+nLPSMZYhRrA1LpXQx
	yLnuyyQ1MXgPKvzWSF7rSIdPzW4XFo0UvhiNk4Gzbz68MEy7IBqs89fRgwCv8cjnNB/4/d
	ZBMwkc+u6bbSWU5gyqkPen3OQTzQNFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLk/95zehhjlx7OT4urvcq3KzHamMIvpNEYxK5bdS0A=;
	b=N2R2qa93TSlCwkzt6bTwoMfeTJAWQQ8yv2FS+N6fkcPrgFK7NS7vKHCrOpFS4epBLXKgTS
	VEUC5CoPjUNo8jAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0981F4A0A2;
	Fri, 27 Mar 2026 09:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v3ciAaFTxmnbNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:53:37 +0000
Date: Fri, 27 Mar 2026 10:53:36 +0100
Message-ID: <877bqxsin3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: NonameBlank007 <nonameblank007@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] ALSA: hda/realtek: add quirk for HP Victus 15-fb0xxx
In-Reply-To: <20260326134409.15230-1-nonameblank007@gmail.com>
References: <20260326134409.15230-1-nonameblank007@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230612-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: A69E034210C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 14:43:24 +0100,
NonameBlank007 wrote:
> 
> This adds a mute led quirck for HP Victus 15-fb0xxx (103c:8a3d) model
> 
> - As it used 0x8(full bright)/0x7f(little dim) for mute led on and other values as 0ff (0x0, 0x4, ...)
> 
> - So, use ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT insted for safer approach
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: NonameBlank007 <nonameblank007@gmail.com>

Please use a real name or a known identity for Signed-off-by line as
it's a legal requirement.


thanks,

Takashi

