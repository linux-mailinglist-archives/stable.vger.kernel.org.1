Return-Path: <stable+bounces-230610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3dUbIYZQxmnrIgUAu9opvQ
	(envelope-from <stable+bounces-230610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:40:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6B341E48
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E67C53072B93
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317593D6689;
	Fri, 27 Mar 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OEBKXaog";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jS7dupU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OEBKXaog";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jS7dupU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55F3D647C
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604368; cv=none; b=uwWlMpJlqxGPGdlf42VWdNu6+BqLJydktd3BvNm/zn4sEBsBWWW/npOZwl2fXIUhdmlZuxqP1CDmLxcQsswMG8Lx0JO+cxZe6RVx1/adHH6bTKXcUMeuKBlW+Amei/NZno1jTzjzUns71gwyZ27lBEUmv+EpmifqRVChCLk9lsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604368; c=relaxed/simple;
	bh=pwTR0QqbwReZc1SbAd5F2Xp4iDIRC6btaRbRLlbbKS4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyQaUCKuLGf1iXli1yN8c6kQFu8eTKG2HtIABsNzbdbp2VRmSZmAg0i87D4zmGk5kJnF8XtKrMLqn6+5E3CZ3tiaWak4ccathANgWGYDe45jUjJR+tRjhueBC6YDa7Iq/XFg65ZbKVDqMXbXsJPAZEc2F9+Qxra7Rwn8gow0ROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OEBKXaog; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1jS7dupU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OEBKXaog; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1jS7dupU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78AAB5BCEC;
	Fri, 27 Mar 2026 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774604363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50G9CEqPsLiumlGVBbxUdK9qRhfJiXO51L5OmkxkXnA=;
	b=OEBKXaogOgFQq9jfDk9JmIF5Ex7pm63fm9Lxp770AqHnkTo0oU+08HIn6jgbII+pePS6GI
	GCar2J/zOmE3A7Y7gC3eMK/1JJL9mTXhhZaLJwW9dATjNXcBbBe4MtHuAiklEa13ciAXlv
	4eHcuEsVpe//98+Cq5A+/SOWWW7oBzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774604363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50G9CEqPsLiumlGVBbxUdK9qRhfJiXO51L5OmkxkXnA=;
	b=1jS7dupUs5lyvCzGNmFOqUClGtxmOoqnJ4ERhnHNZ1linpeHcAPupEPiXOkEYAWaKUh05D
	49HIVG9LyT7oEgCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OEBKXaog;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1jS7dupU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774604363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50G9CEqPsLiumlGVBbxUdK9qRhfJiXO51L5OmkxkXnA=;
	b=OEBKXaogOgFQq9jfDk9JmIF5Ex7pm63fm9Lxp770AqHnkTo0oU+08HIn6jgbII+pePS6GI
	GCar2J/zOmE3A7Y7gC3eMK/1JJL9mTXhhZaLJwW9dATjNXcBbBe4MtHuAiklEa13ciAXlv
	4eHcuEsVpe//98+Cq5A+/SOWWW7oBzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774604363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50G9CEqPsLiumlGVBbxUdK9qRhfJiXO51L5OmkxkXnA=;
	b=1jS7dupUs5lyvCzGNmFOqUClGtxmOoqnJ4ERhnHNZ1linpeHcAPupEPiXOkEYAWaKUh05D
	49HIVG9LyT7oEgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342154A0A2;
	Fri, 27 Mar 2026 09:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xhiCC0tQxmlIKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:39:23 +0000
Date: Fri, 27 Mar 2026 10:39:22 +0100
Message-ID: <87ikahsjat.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	chris.chiu@canonical.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Artem S . Tashkinov" <aros@gmx.com>
Subject: Re: [PATCH] ALSA: hda/realtek: add new quirk for HP OmniBook 7 Laptop 16-bh0xxx
In-Reply-To: <e2ae2b1f-b058-47d0-9bb6-889044f2af16@kylinos.cn>
References: <20260323030503.3988941-1-zhangheng@kylinos.cn>
	<e2ae2b1f-b058-47d0-9bb6-889044f2af16@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,canonical.com,realtek.com,opensource.cirrus.com,vger.kernel.org,gmx.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-230610-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20C6B341E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 04:13:01 +0100,
Zhang Heng wrote:
> 
> Please help me check whether it is more appropriate to add a new quirk
> or replace the existing one:
> 
> SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2)
> 
> with
> 
> SND_PCI_QUIRK(0x103c, 0x8e60, "HP OmniBook 7 Laptop 16-bh0xxx",
> ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED)
> 
> Both the PCI subsystem ID and the HDA subsystem ID are 0x103c8e60.

I believe we can replace it as it seems using the same Cirrus s-codec
and setup.  So I skip this one for now and expect you'll submit a new
one instead.


thanks,

Takashi

