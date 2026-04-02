Return-Path: <stable+bounces-232976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COJHBbxJzmknmgYAu9opvQ
	(envelope-from <stable+bounces-232976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:49:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD9387EC9
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7E1304D146
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5938737A;
	Thu,  2 Apr 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ij9F/BCZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZ12Fua5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ij9F/BCZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZ12Fua5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95824383C68
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126930; cv=none; b=J0EGlX2YdUoN3ftlv9Dp2h9yp/OF+xk1OUDfeqiadmz3AkcpP1O1FYj2IYOPeC36O1P0ig1sopYnEW/dD2GZufhP0c77R0QGIR0ru2pOOPMtdS9mbfMnm2Lz/vDl7NkV8V/KctPwdUddJQrVJHlY+FZqOZNC4zAi2czvcpxt6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126930; c=relaxed/simple;
	bh=+GiowJop7UwN08oH2dRlL1RYykBls6T5BVF7GFzOhrk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHUs9rlsFac0BKzvYoB56tcouOGpWrDMw92fafEIcGpyUb7q/WQn2qbe4FxhxwB9Ew0JKY4x5jvo19HAuOjqzziJ+FRVafXGKNQMAaOkBL7BEEljhX9w0wwSzvnqN0g42SG5Z4yz/ShqIubvMyQfBpI2vDkC5+0pr6ruUCBFTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ij9F/BCZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZ12Fua5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ij9F/BCZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZ12Fua5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71AD54D325;
	Thu,  2 Apr 2026 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775126926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkFi1TrJtj9Q6Z7Vgiipb7scc7gXp3/Mj6TLow5q6I=;
	b=ij9F/BCZbGG+lv4AXFQHSpRHFyaIdsKnYvbppugUq4YDGSs6c8R9djneDw23Fd9dIWwdXr
	648G/DGMPelObcBEsZa5B/p0oqmdHsN4K+uCjxcpRqxd8aOv/4Ei0xoIZnAwKlx3IoiLES
	4BrKH4XAibv6Ci6KqSZC9N9zG27c0Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775126926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkFi1TrJtj9Q6Z7Vgiipb7scc7gXp3/Mj6TLow5q6I=;
	b=QZ12Fua582ViSyswOuiiT33ZE6pdY1GcAgIIgwDiZLzp0grD9atFZZToYiGddCrQRuYUDQ
	03L3Ke1cJzsuASBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ij9F/BCZ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QZ12Fua5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775126926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkFi1TrJtj9Q6Z7Vgiipb7scc7gXp3/Mj6TLow5q6I=;
	b=ij9F/BCZbGG+lv4AXFQHSpRHFyaIdsKnYvbppugUq4YDGSs6c8R9djneDw23Fd9dIWwdXr
	648G/DGMPelObcBEsZa5B/p0oqmdHsN4K+uCjxcpRqxd8aOv/4Ei0xoIZnAwKlx3IoiLES
	4BrKH4XAibv6Ci6KqSZC9N9zG27c0Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775126926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkFi1TrJtj9Q6Z7Vgiipb7scc7gXp3/Mj6TLow5q6I=;
	b=QZ12Fua582ViSyswOuiiT33ZE6pdY1GcAgIIgwDiZLzp0grD9atFZZToYiGddCrQRuYUDQ
	03L3Ke1cJzsuASBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DDC64A0B0;
	Thu,  2 Apr 2026 10:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0M4iAo5JzmmTOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 Apr 2026 10:48:46 +0000
Date: Thu, 02 Apr 2026 12:48:45 +0200
Message-ID: <87qzoxiqnm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,	niecheng1@uniontech.com,	kernel@uniontech.com,
	=?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>,	Kagura <me@mail.kagurach.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: apply quirk for MOONDROP JU Jiu
In-Reply-To: <20260402-syy-v1-1-068d3bc30ddc@linux.dev>
References: <20260402-syy-v1-1-068d3bc30ddc@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232976-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid,kagurach.uk:email,linux.dev:email]
X-Rspamd-Queue-Id: 78CD9387EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 02 Apr 2026 07:36:57 +0200,
Cryolitia PukNgae wrote:
> 
> It(ID 31b2:0111 JU Jiu) reports a MIN value -12800 for volume control, but
> will mute when setting it less than -10880.
> 
> Thanks to my girlfriend Kagura for reporting this issue.
> 
> Cc: Kagura <me@mail.kagurach.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

Applied to for-next branch now.

> ---
> Btw, is it a good idea for turn the volume_control_quirks from
> switch-case to a table and sort it accroding to USB VID&PID?

Yeah, this might be better, indeed.

But the quirk isn't really straightforward for those, maybe we need a
matching of USB id plus kctl id name string, then update the cval
fields conditionally with flags.  Let me cook later...


thanks,

Takashi

