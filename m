Return-Path: <stable+bounces-255684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO8UF2qkGGrClggAu9opvQ
	(envelope-from <stable+bounces-255684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64D5F8933
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DE030B8B17
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58C316905;
	Thu, 28 May 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgFkNz3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lHqh/w/V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgFkNz3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lHqh/w/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361F3016E0
	for <stable@vger.kernel.org>; Thu, 28 May 2026 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999601; cv=none; b=gZeL+nVNDIRsWPr1YO76qIs4S17gIkWNmQLk7OEKSrG0imX9aayPuE/mKbj8H7UOzwQRe+WBGDRODJxha5BVDupj9swHT/1OM/0umMgg8qNgBF4CRsqA82gJwsjidWaqivxQPEW/N9S/YhF6vBtObKqaxI4OiHgMtxt9nqm2TL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999601; c=relaxed/simple;
	bh=EyaF5sza5IMpxxJN0yXgScztt2GHZPfz3Y5a8lhsI7Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWQYq8leyVj2MmR08hDXVEcDMoniG4C33bAN4d9mWffIbc9prse9gQ7v6W3taggbnZRyG6gGWFWNRwa5F7EEbXhR4RXc+aqsTp2BYt9Ab7N40jSxjgURPFGJDtf8L5DDePZ+jsoCg6cuxHVA7bCvdoRCyRJcblxRGRLrwwEIVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgFkNz3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lHqh/w/V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgFkNz3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lHqh/w/V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 764876AA02;
	Thu, 28 May 2026 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779999598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5GrZ1dC2WN36VrGiN+f99vKFGciKlAxwcEXaNXFk6g=;
	b=bgFkNz3QCcRD5LWgNWQOuBfDoA/W0BcNp86FV+F40uTLk6BM+DeWqxl3Gr+LNnoAjjyjQI
	j+QV2hk8azHZ7+0hK4SyHBn7GwLg0svMTR2skBrpmgWv78rV32riqeHSjAKeX9gIT6MhvE
	jDnAfPuNEpyhd2Ws76g2F5XNpej1nyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779999598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5GrZ1dC2WN36VrGiN+f99vKFGciKlAxwcEXaNXFk6g=;
	b=lHqh/w/VJcHyyr8A642eJhNJyoI8heQFmxZ6azwIk/lFqvUGNkuSXYfnSnU3/c4mmCnyL3
	ZlvamLy2AqvtklDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bgFkNz3Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="lHqh/w/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779999598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5GrZ1dC2WN36VrGiN+f99vKFGciKlAxwcEXaNXFk6g=;
	b=bgFkNz3QCcRD5LWgNWQOuBfDoA/W0BcNp86FV+F40uTLk6BM+DeWqxl3Gr+LNnoAjjyjQI
	j+QV2hk8azHZ7+0hK4SyHBn7GwLg0svMTR2skBrpmgWv78rV32riqeHSjAKeX9gIT6MhvE
	jDnAfPuNEpyhd2Ws76g2F5XNpej1nyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779999598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5GrZ1dC2WN36VrGiN+f99vKFGciKlAxwcEXaNXFk6g=;
	b=lHqh/w/VJcHyyr8A642eJhNJyoI8heQFmxZ6azwIk/lFqvUGNkuSXYfnSnU3/c4mmCnyL3
	ZlvamLy2AqvtklDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 358DB5AF83;
	Thu, 28 May 2026 20:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r1xZC26jGGrKWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 May 2026 20:19:58 +0000
Date: Thu, 28 May 2026 22:19:57 +0200
Message-ID: <87cxyfs2vm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mike Karcic <mikekarcic@protonmail.com>
Cc: Kailang Yang <kailang@realtek.com>,
    Takashi Iwai <tiwai@suse.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
In-Reply-To: <bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
	<87eciwukvy.wl-tiwai@suse.de>
	<RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
	<87mrxjsk52.wl-tiwai@suse.de>
	<bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255684-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE64D5F8933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 20:27:30 +0200,
Mike Karcic wrote:
> 
> Yes, I can confirm the patched kernel is running, and commenting out that line fixes the problem completely.
> 
> Below is output with the added debug lines as requested:
> 
> $ uname -r
> 6.12.90-debug-no-discoefs
> 
> $ sudo dmesg | grep -i "alc287_alc1318"
> [  453.823528] snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook called action=0
> [  453.871577] snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook called action=1
> [  459.605379] snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook called action=2
> [  459.605497] snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook called action=3
> 
> $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/patch_realtek.c
> 7918-           return;
> 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
> 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented out for testing */
> 7921-   alc_process_coef_fw(codec, coefs);
> 7922-   spec->power_hook = alc287_s4_power_gpio3_default;
> 7923-   spec->gen.pcm_playback_hook = alc287_alc1318_playback_pcm_hook;
> 7924-}

Hm, then the previous fix doesn't seem working, obviously.
Kailang, could you check this in your side?

Maybe we should apply the AMP-silence-detection disablement
conditionally to certain models?


thanks,

Takashi

> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de> wrote:
> 
> > On Thu, 28 May 2026 15:38:54 +0200,
> > Mike Karcic wrote:
> > >
> > > I did test 46c862f5419e on 6.12.90. Chirp still present.
> > >
> > > I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e),
> > > same as the original reporter. The fix resolved it for them but
> > > not for me.
> > >
> > > Only a full revert of 630fbc6e870e resolves the issue.
> > >
> > > Verification on the running kernel:
> > >
> > >   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
> > >   2
> > >
> > >   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
> > >   0
> > >
> > >   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda/patch_realtek.c
> > >   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream *hinfo,
> > >                                      struct hda_codec *codec,
> > >                                      struct snd_pcm_substream *substream,
> > >                                      int action)
> > >   {
> > >           switch (action) {
> > >           case HDA_GEN_PCM_ACT_OPEN:
> > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
> > >                   break;
> > >           case HDA_GEN_PCM_ACT_CLOSE:
> > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
> > >                   break;
> > >           }
> > >   }
> > >
> > > Happy to test further patches.
> > 
> > Just to be sure, could you verify that you've tested really the
> > patched kernel, e.g. by adding a debug print, etc?
> > If yes and the problem is seen even with the patch, try to comment out
> >   alc_process_coef_fw(codec, dis_coefs);
> > and confirm that this fixes the problem.
> > 
> > 
> > Takashi
> >

