Return-Path: <stable+bounces-230613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KELHGTxVxmmMIwUAu9opvQ
	(envelope-from <stable+bounces-230613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:00:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA513421A2
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836E330B7A01
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585D3CA4BD;
	Fri, 27 Mar 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyL3gSxH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ODQyZkC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyL3gSxH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ODQyZkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA52E9733
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605269; cv=none; b=OcHTPtjni2HU09W0GKKO3KCQIMzyHNIJK5Zd8b7QgzaYDxdrJHCfzVD/OyZ2xr77rYVmCJdPay7weAl70rVlAEWw1ih5fDRJcDTa1GFXI8/KoPIxM7y2QCHfqYLU7qDAFZki57G28L9kt3iat8LqBNmSi5YPilsMf9eYAbsXpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605269; c=relaxed/simple;
	bh=TgfZnoitjho8aDERPJbU5GW3vwd6G6mhsC3EGIyx9p8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pko2a+tu1dI/vtRFTMKsA6hP3a0gGMKvOhn2v4ivF0PYN/V7kVSey/dT9a6+hlXFN1K/m45EOJpkSXu7HLqt5Qkxxg8zpw8EyyDW5tWeN0alyqHNhwNmghxUgfT7tL5Znfbs7/T7J/biyU/SZTZiZq/1oFHI2Cnn7udBlFtKVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyL3gSxH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ODQyZkC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyL3gSxH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ODQyZkC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20D715BCF9;
	Fri, 27 Mar 2026 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774605266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUDrpAumMhfY4bttJg5k6rcJayzQhKZPoQvqKNPBwyQ=;
	b=xyL3gSxHNwhSQIlMD+P3oUjy5D+l/6ULHPcJPeY87kphscCboAyvs5w5aulpxlcWDSGk52
	tNBfGaXO9HXdGu4gMppZcsnzvfAi7LaZh1slflSPZDB4C7ss6A6okFqzc5tasCU7ObY6XJ
	EuerNyaJsNi6Cu4mbifiz/WAlHvDeLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUDrpAumMhfY4bttJg5k6rcJayzQhKZPoQvqKNPBwyQ=;
	b=2ODQyZkC8K7kLPkYBo+EZWlUIV428klr0+2gfsHWqyESQcWRREF1ipLbZzASzSY7y/y2mE
	ncYP79K8QuPn97Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xyL3gSxH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2ODQyZkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774605266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUDrpAumMhfY4bttJg5k6rcJayzQhKZPoQvqKNPBwyQ=;
	b=xyL3gSxHNwhSQIlMD+P3oUjy5D+l/6ULHPcJPeY87kphscCboAyvs5w5aulpxlcWDSGk52
	tNBfGaXO9HXdGu4gMppZcsnzvfAi7LaZh1slflSPZDB4C7ss6A6okFqzc5tasCU7ObY6XJ
	EuerNyaJsNi6Cu4mbifiz/WAlHvDeLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUDrpAumMhfY4bttJg5k6rcJayzQhKZPoQvqKNPBwyQ=;
	b=2ODQyZkC8K7kLPkYBo+EZWlUIV428klr0+2gfsHWqyESQcWRREF1ipLbZzASzSY7y/y2mE
	ncYP79K8QuPn97Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2E094A0A2;
	Fri, 27 Mar 2026 09:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XlEhNtFTxmmROAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:54:25 +0000
Date: Fri, 27 Mar 2026 10:54:25 +0100
Message-ID: <875x6hsilq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<stable@vger.kernel.org>,
	Juhyun Song <juju6985@outlook.kr>,
	"Stuart Hayhurst" <stuart.a.hayhurst@gmail.com>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] Revert "ALSA: hda/intel: Add MSI X870E Tomahawk to denylist"
In-Reply-To: <20260326190542.524515-1-mario.limonciello@amd.com>
References: <20260326190542.524515-1-mario.limonciello@amd.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,outlook.kr,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230613-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,suse.de:dkim,suse.de:mid,outlook.kr:email]
X-Rspamd-Queue-Id: BBA513421A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 20:05:38 +0100,
Mario Limonciello wrote:
> 
> commit 30b3211aa2416 ("ALSA: hda/intel: Add MSI X870E Tomahawk
> to denylist") was added to silence a warning, but this effectively
> reintroduced commit df42ee7e22f03 ("ALSA: hda: Add ASRock
> X670E Taichi to denylist") which was already reported to cause
> problems and reverted in commit ee8f1613596ad ("Revert "ALSA: hda:
> Add ASRock X670E Taichi to denylist"")
> 
> Revert it yet again.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Juhyun Song <juju6985@outlook.kr>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221274
> Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied now.  Thanks.


Takashi

