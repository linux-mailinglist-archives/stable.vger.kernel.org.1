Return-Path: <stable+bounces-259860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMW1HrsZH2oQfwAAu9opvQ
	(envelope-from <stable+bounces-259860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 19:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D5630E5D
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 19:58:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EEyDlwlh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qXhKCi2j;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ze3PPXkR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RUAAcjtK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259860-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-259860-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44C683004637
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA93FD973;
	Tue,  2 Jun 2026 17:45:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CA3FC5AF
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 17:45:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422322; cv=none; b=r0xtuDvdIzB3YVbIIgl8XhvbILKIrpNvvgiCA95bzdGgLMalnTLTxYa+YFG81TiMIXF8N/A8wiI+LLJxWVu6ag8y/F57oOTs4652dWfyH+j2J4R6qI4RiK2H2PPlWsT9Sex4Qu2wGJlYmPRAZK5+HWlcDP3hQe3GxYTfsaI8mgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422322; c=relaxed/simple;
	bh=xts6qQ534694Mm/S4A1BHBCd21Jsj+ab9M4kr0sTKIY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgFiJTqHGoVqW2CswsNaNJcJ5LOlE0lsTOLW75XYREXVteGAewbKV71ONH3lgyDeyy51iDWkFhtgWFw17+LFim7ag8HmEl8j9F3u4vpsSaE6TygplDTcvrqBfpcxPCHknokOvrNvamSLHmItedsCdp217EVgQxtcc9WDGSudRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EEyDlwlh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXhKCi2j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ze3PPXkR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RUAAcjtK; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDA976C009;
	Tue,  2 Jun 2026 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780422313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu4UfJ/uxJdMYzOhZ1NYp7qD1lKEW76JZx60l7/sK4s=;
	b=EEyDlwlhGRvG66ZJ+71nKOi4fgg53huF/vLT6gNAAJ6/urwXTSqlwy660R4bcirBOMIprx
	lt6Ksf9el5Khb4dr2lQA1/it5z/tpShIbiyjZO8CuXPe1MhJuP1eQRpM2X3M+pl7oMxuv2
	ogtVGdh2xLJYkTq20JjXONNCFUPbPhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780422313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu4UfJ/uxJdMYzOhZ1NYp7qD1lKEW76JZx60l7/sK4s=;
	b=qXhKCi2jM6o++1h7BocoQCByvoUy9F1tFVCrRhXE7nI89lVLSTm0Vyorx4cqUvnAQ2IvXs
	TZKbqGSTuh25IABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780422312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu4UfJ/uxJdMYzOhZ1NYp7qD1lKEW76JZx60l7/sK4s=;
	b=Ze3PPXkR6RVjekLzy+QxL15Rumtx/D5omtpOR/2evHMkXFf2EAOTZR9A/qw1MVlt1TG03A
	zQIxdwT0/f3/itVEeoXTT6c2dIN3ButzuktSZfKxEQFHE9b1e8Av9BkhzFBf/la4aFiTZc
	+ISCiIrhGA/dTrnigCC6D0jjRiUKeD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780422312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu4UfJ/uxJdMYzOhZ1NYp7qD1lKEW76JZx60l7/sK4s=;
	b=RUAAcjtKnb3rnFMOUQSIkywATnSX0wnFlPLdmVVps312lJuVhQaQStWlKKctPoxWQarMrw
	slI6CphqsSdb2mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B306A779A7;
	Tue,  2 Jun 2026 17:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2hRlKqgWH2qiMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Jun 2026 17:45:12 +0000
Date: Tue, 02 Jun 2026 19:45:12 +0200
Message-ID: <87wlwgygyf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mike Karcic <mikekarcic@protonmail.com>,
	Sean Rhodes <sean@starlabs.systems>,
	"stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
In-Reply-To: <833d600fdebd4aaeab6706185ce854e6@realtek.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
	<87eciwukvy.wl-tiwai@suse.de>
	<RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
	<87mrxjsk52.wl-tiwai@suse.de>
	<bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
	<87cxyfs2vm.wl-tiwai@suse.de>
	<833d600fdebd4aaeab6706185ce854e6@realtek.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.de,protonmail.com,starlabs.systems,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-259860-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kailang@realtek.com,m:tiwai@suse.de,m:mikekarcic@protonmail.com,m:sean@starlabs.systems,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,vger.kernel.org:from_smtp,suse.de:mid,suse.de:dkim,suse.de:from_mime,suse.de:email,protonmail.com:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A21D5630E5D

On Tue, 02 Jun 2026 08:14:14 +0200,
Kailang wrote:
> 
> 
> There were the same SSID for two different symptoms.
> But this project was from 2025. This machine maybe didn't in our site.

Aha, that can explain the difference of the behavior, then.
Do both of them have the same codec ID and SSID, too?


Takashi

> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de> 
> Sent: Friday, May 29, 2026 4:20 AM
> To: Mike Karcic <mikekarcic@protonmail.com>
> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Sean Rhodes <sean@starlabs.systems>; stable@vger.kernel.org; regressions@lists.linux.dev; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
> 
> 
> External mail : This email originated from outside the organization. Do not reply, click links, or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On Thu, 28 May 2026 20:27:30 +0200,
> Mike Karcic wrote:
> >
> > Yes, I can confirm the patched kernel is running, and commenting out that line fixes the problem completely.
> >
> > Below is output with the added debug lines as requested:
> >
> > $ uname -r
> > 6.12.90-debug-no-discoefs
> >
> > $ sudo dmesg | grep -i "alc287_alc1318"
> > [  453.823528] snd_hda_codec_realtek ehdaudio0D0: 
> > alc287_alc1318_playback_pcm_hook called action=0 [  453.871577] 
> > snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook 
> > called action=1 [  459.605379] snd_hda_codec_realtek ehdaudio0D0: 
> > alc287_alc1318_playback_pcm_hook called action=2 [  459.605497] 
> > snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook 
> > called action=3
> >
> > $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/patch_realtek.c
> > 7918-           return;
> > 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
> > 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented out for testing */
> > 7921-   alc_process_coef_fw(codec, coefs);
> > 7922-   spec->power_hook = alc287_s4_power_gpio3_default;
> > 7923-   spec->gen.pcm_playback_hook = alc287_alc1318_playback_pcm_hook;
> > 7924-}
> 
> Hm, then the previous fix doesn't seem working, obviously.
> Kailang, could you check this in your side?
> 
> Maybe we should apply the AMP-silence-detection disablement conditionally to certain models?
> 
> 
> thanks,
> 
> Takashi
> 
> >
> >
> >
> > Sent with Proton Mail secure email.
> >
> > On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Thu, 28 May 2026 15:38:54 +0200,
> > > Mike Karcic wrote:
> > > >
> > > > I did test 46c862f5419e on 6.12.90. Chirp still present.
> > > >
> > > > I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e), 
> > > > same as the original reporter. The fix resolved it for them but 
> > > > not for me.
> > > >
> > > > Only a full revert of 630fbc6e870e resolves the issue.
> > > >
> > > > Verification on the running kernel:
> > > >
> > > >   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
> > > >   2
> > > >
> > > >   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
> > > >   0
> > > >
> > > >   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda/patch_realtek.c
> > > >   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream *hinfo,
> > > >                                      struct hda_codec *codec,
> > > >                                      struct snd_pcm_substream *substream,
> > > >                                      int action)
> > > >   {
> > > >           switch (action) {
> > > >           case HDA_GEN_PCM_ACT_OPEN:
> > > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
> > > >                   break;
> > > >           case HDA_GEN_PCM_ACT_CLOSE:
> > > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
> > > >                   break;
> > > >           }
> > > >   }
> > > >
> > > > Happy to test further patches.
> > >
> > > Just to be sure, could you verify that you've tested really the 
> > > patched kernel, e.g. by adding a debug print, etc?
> > > If yes and the problem is seen even with the patch, try to comment out
> > >   alc_process_coef_fw(codec, dis_coefs); and confirm that this fixes 
> > > the problem.
> > >
> > >
> > > Takashi
> > >

