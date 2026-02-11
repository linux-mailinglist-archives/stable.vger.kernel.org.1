Return-Path: <stable+bounces-215772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNLNDxxFjGlxkQAAu9opvQ
	(envelope-from <stable+bounces-215772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:00:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8F1227C4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A081A305BAAD
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725C3542C1;
	Wed, 11 Feb 2026 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wcO+KEF0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bg/hDjcL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w7CfbqGe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jOveW+Io"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936234F46F
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800368; cv=none; b=kQI83pOGMyeSa46+egFdQqtMWsNLl45jpePQv4VLm6AaLnwYcDoeMAakF0LqgoTBQVdooxcu0EdI1+HxKFK1tW7qZfQ+cKVjzuwY1kwmS4smPZXcGy3GUlfg6BlIX2ElHMS9omltUuuk+rbfwxp3deI1v7gBdIJiX+9hz3u8uho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800368; c=relaxed/simple;
	bh=qHX11VB/1T8Ty0UKOdZZF6KrcjhLwv9m+uEvenaTtsM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isN+Cwon1/viBR6GHcQkGt5kuA/e4rIKNEm7Vr49LIle/hfI0NfYotYzEU6qsTlpQ20ax73T4RpsRuPLF0+AKr2Gb+wZwI5+yNQUHWTTJ7ub48LdnCv+84Hqwi9p4ljhSbV4THnQm/QiiUyJEPZiBN+wZ6OYhYci7RMY9kMp3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wcO+KEF0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bg/hDjcL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w7CfbqGe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jOveW+Io; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 894F73E714;
	Wed, 11 Feb 2026 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770800365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQVCPt26Hbc0TLnG7lk2Jsn3DSqX7RHiaQio6RVlIdc=;
	b=wcO+KEF0DlYzFjmiv/ckhWFkG6yxG4ONWPgEqhiMfzDC7dSvXMxXk65MdFg9ZxO3ao4xqT
	Nz1bR1Qd6STzQiV1Tc3Xll9NTuV3h604MURVmfbh93lVxhaWxSah53jkIU3+LnreY5mVEU
	q/lRzkpd9aABz3GRUJF5HbASEKvTYxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770800365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQVCPt26Hbc0TLnG7lk2Jsn3DSqX7RHiaQio6RVlIdc=;
	b=bg/hDjcL0BdnyP9Q9suBEFZiFsGSvmT7Iosnk82+t60pj3scjVfp3gHiwap3St7zCnDTwj
	NX4cBI85hAXOmNDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770800364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQVCPt26Hbc0TLnG7lk2Jsn3DSqX7RHiaQio6RVlIdc=;
	b=w7CfbqGem+hgnF9xCuTl7qG0BSc6FLZVhtV5yoUzjy2iBW5o8HH4NuJdIUj2v4r/yxX6Ud
	h2MzezTNNilXyZNL02feobaxE+45+RWWC/erTNaMLKTxZzykoe5PBhAFQ9gXUStP3rZARJ
	yj54YGa4CcsHcMe21aFG7P3ERYbUr7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770800364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQVCPt26Hbc0TLnG7lk2Jsn3DSqX7RHiaQio6RVlIdc=;
	b=jOveW+IoAV7miQsTyaqwfORR1+cs2HSnZdGSDWTWU57Qs94rNzF91Dw6og07YbXBWTjs3r
	ntqacP1ckD3BOZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ADBE3EA62;
	Wed, 11 Feb 2026 08:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MffzEOxEjGkrZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Feb 2026 08:59:24 +0000
Date: Wed, 11 Feb 2026 09:59:23 +0100
Message-ID: <87o6lvu044.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lewis Mason <mason8110@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	stable@vger.kernel.org,
	Lewis Mason <lewis@ocuru.co.uk>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)
In-Reply-To: <20260210231337.7265-1-lewis@ocuru.co.uk>
References: <20260210231337.7265-1-lewis@ocuru.co.uk>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215772-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,ocuru.co.uk:email]
X-Rspamd-Queue-Id: A5C8F1227C4
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 00:13:37 +0100,
Lewis Mason wrote:
> 
> The Samsung Galaxy Book3 Pro 360 NP965QFG (subsystem ID 0x144d:0xc1cb)
> uses the same Realtek ALC298 codec and amplifier configuration as the
> NP960QFG (0x144d:0xc1ca). Apply the same ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS
> fixup to enable the internal speakers.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lewis Mason <lewis@ocuru.co.uk>

Applied now.  Thanks.


Takashi

