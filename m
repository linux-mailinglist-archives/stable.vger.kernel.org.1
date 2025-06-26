Return-Path: <stable+bounces-158656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E3AE9598
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B686B4A2716
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253C22541C;
	Thu, 26 Jun 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z1/tsqGK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oK6oB5jU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OrAm86fV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y7yjTydW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C428217F40
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917851; cv=none; b=rGOiHjvbMoYxJuhrvorlnb9WxBd2SYTO/Laenb9dsKBXDOtbEphwOA95VADPGfvOrmapuqH1gc86KgvC0zo89RYPdsqIej2Na4gTrlyqcl4wCe7KynitAoHgHGL+21K/lIFXj2FW9LYCqpLh47Z4tYogdxRoDrtn8EzecfxyodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917851; c=relaxed/simple;
	bh=TZ30w1P6Na99hERk8OGwZ82lYzSmnHWBxcJKkFO9zuc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9CNUdn/yUAOD16cxkIv+6Y95lCM4pELLCHjKon7HYjYkDNZfzeixRHteD8RLV+Y1LOLRj7+boHkb8j4LJWJi877QdW2PQXWzuutItRV4OqvCImEml/LBtR0oMUDhPlebq+uiObXSvGxmV0A1DdhbRx4G+P0NzHwPcX0sE+cCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z1/tsqGK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oK6oB5jU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OrAm86fV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y7yjTydW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E2012116A;
	Thu, 26 Jun 2025 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750917847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuAtZS2bTBWp4kitLMk7kBSEiydumYzBNuegsS4wWEs=;
	b=Z1/tsqGKRLzDE288WiYEPjSME/AK1RCSkZh3v15vS4nkAyIfkKj9OZp+FhkQqQI6njMHdo
	SdYad6gsjv3V6UXu2eUTnQvboI5gtVmVi3yahiAaz9KZLut93yQNCfHCKiEym4MNjU0ffv
	UPQ173ROaPPjbCTZg5iPKC2n40pwHxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750917847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuAtZS2bTBWp4kitLMk7kBSEiydumYzBNuegsS4wWEs=;
	b=oK6oB5jUg82Pp8WZPkJxx6D7RKxAY2trfpFPHV6/ruRXpdRjc6jUcWja4Yqxw1E8v5Mabg
	KZm5VT64/neJvZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OrAm86fV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y7yjTydW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750917846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuAtZS2bTBWp4kitLMk7kBSEiydumYzBNuegsS4wWEs=;
	b=OrAm86fVc3XlVHPHsSKpsNTClxeuX0jb7TggePs+q7n2Ok/CYze+RVTN7NFN8+tDsFBgFA
	Fum5rNNUzAQx2QamzNqFoE7C++oTpynV5y4LTSPUjrIVbArgWZgFXBlOWrFD/iI6t0jrI6
	DFvll07lWwbJ5VU8932AtMkok9DlteU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750917846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuAtZS2bTBWp4kitLMk7kBSEiydumYzBNuegsS4wWEs=;
	b=y7yjTydWgzB/94zQaFKH7mrz/mNEadYCvJ26Ll24AUR0v2VQvRc11vbyR9H7klWCFkl8wD
	PJPPW5q10qOByXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40714138A7;
	Thu, 26 Jun 2025 06:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NCpMDtbiXGgFEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Jun 2025 06:04:06 +0000
Date: Thu, 26 Jun 2025 08:04:05 +0200
Message-ID: <87zfdvght6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Igor =?ISO-8859-1?Q?T=E1mara?= <igor.tamara@gmail.com>,	Takashi Iwai
 <tiwai@suse.de>,	1108069@bugs.debian.org,	stable@vger.kernel.org,	Kuan-Wei
 Chiu <visitorckw@gmail.com>,	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,	regressions@lists.linux.dev
Subject: Re: [regression] Builtin recognized microphone Asus X507UA does not record
In-Reply-To: <aFzLTJg8MN5evbYL@eldamar.lan>
References: <175038697334.5297.17990232291668400728.reportbug@donsam>
	<aFxETAn3YKNZqpXL@eldamar.lan>
	<CADdHDco7_o=4h_epjEAb92Dj-vUz_PoTC2-W9g5ncT2E0NzfeQ@mail.gmail.com>
	<aFzLTJg8MN5evbYL@eldamar.lan>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E2012116A
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,bugs.debian.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alsa-info_alsa-info.sh:url,linuxfoundation.org:email,msgid.link:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Score: -2.01
X-Spam-Level: 

On Thu, 26 Jun 2025 06:23:40 +0200,
Salvatore Bonaccorso wrote:
> 
> Hi Igor,
> 
> On Wed, Jun 25, 2025 at 07:54:42PM -0500, Igor Támara wrote:
> > Hi Salvatore,
> > 
> > 
> > El mié, 25 jun 2025 a las 13:47, Salvatore Bonaccorso
> > (<carnil@debian.org>) escribió:
> > >
> > > Hi Igor,
> > >
> > > [For context, there was a regression report in Debian at
> > > https://bugs.debian.org/1108069]
> > >
> > > On Thu, Jun 19, 2025 at 09:36:13PM -0500, Igor Tamara wrote:
> > > > Package: src:linux
> > > > Version: 6.12.32-1
> > > > Severity: normal
> > > > Tags: a11y
> > > >
> > > > Dear Maintainer,
> > > >
> > > > The builtin microphone on my Asus X507UA does not record, is
> > > > recognized and some time ago it worked on Bookworm with image-6.1.0-31,
> > > > newer images are able to record when appending snd_hda_intel.model=1043:1271
> > > > to the boot as a workaround.
> > > >
> > > > The images that work with the boot option appended are, but not without
> > > > it are:
> > > >
> > > > linux-image-6.15-amd64
> > > > linux-image-6.12.32-amd64
> > > > linux-image-6.1.0-37-amd64
> > > > linux-image-6.1.0-0.a.test-amd64-unsigned_6.1.129-1a~test_amd64.deb
> > > > referenced by https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1100928
> > > > Also compiled from upstream 6.12.22 and 6.1.133 with the same result
> > > >
> > > > The image linux-image-6.1.0-31-amd64 worked properly, the problem was
> > > > introduced in 129 and the result of the bisect was
> > > >
> > > > d26408df0e25f2bd2808d235232ab776e4dd08b9 is the first bad commit
> > > > commit d26408df0e25f2bd2808d235232ab776e4dd08b9
> > > > Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Date:   Wed Jan 29 00:54:15 2025 +0800
> > > >
> > > >     ALSA: hda: Fix headset detection failure due to unstable sort
> > > >
> > > >     commit 3b4309546b48fc167aa615a2d881a09c0a97971f upstream.
> > > >
> > > >     The auto_parser assumed sort() was stable, but the kernel's sort() uses
> > > >     heapsort, which has never been stable. After commit 0e02ca29a563
> > > >     ("lib/sort: optimize heapsort with double-pop variation"), the order of
> > > >     equal elements changed, causing the headset to fail to work.
> > > >
> > > >     Fix the issue by recording the original order of elements before
> > > >     sorting and using it as a tiebreaker for equal elements in the
> > > >     comparison function.
> > > >
> > > >     Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda_auto_parser.c")
> > > >     Reported-by: Austrum <austrum.lab@gmail.com>
> > > >     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219158
> > > >     Tested-by: Austrum <austrum.lab@gmail.com>
> > > >     Cc: stable@vger.kernel.org
> > > >     Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > >     Link: https://patch.msgid.link/20250128165415.643223-1-visitorckw@gmail.com
> > > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > >  sound/pci/hda/hda_auto_parser.c | 8 +++++++-
> > > >  sound/pci/hda/hda_auto_parser.h | 1 +
> > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > I'm attaching the output of alsa-info_alsa-info.sh script
> > > >
> > > > Please let me know if I can provide more information.
> > >
> > > Might you be able to try please the attached patch to see if it fixes
> > > the issue?
> > >
> > 
> > I recompiled and the mic is recording without issues when running on
> > 6.1.133 and 6.12.32
> 
> Thanks for the confirmation! Takashi, can you apply the proposed
> change (slightly improved in attached variant to add Reported-by and
> Closes tags), hopefully getting it into required stable series?

Thanks, applied now.


Takashi

