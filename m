Return-Path: <stable+bounces-254718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNmXOdHbF2phTQgAu9opvQ
	(envelope-from <stable+bounces-254718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:08:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3A5ED205
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2211302F426
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462732B10C;
	Thu, 28 May 2026 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q6EIsiRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GE3jylvc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q6EIsiRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GE3jylvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A2318EE1
	for <stable@vger.kernel.org>; Thu, 28 May 2026 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948486; cv=none; b=Lc1Pvk3C4+QbNa0ixwObTzQ3JKVepkRXaetECQyZncMIaGmDg365UKHhOv9vNC7auqzbmlAwdc9cBDaBi9EPsu8a/TU1J6+0Tpg73KYOvxenJH0Ir28NJHvU9jaVlMYsm41Nqn8fs8oRflPCRFvJ0KueOqMFx9gcwqFRtnkB5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948486; c=relaxed/simple;
	bh=EDYxvZ6pr8pUS+Jy7TWnHj0bHaMGEIyNztk3TcXM1Hk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVlsH4mgdKP/OTmSEVuzhCNabJR0ee1TPC2CvMHTYANqz6FXo85erA1r2wfR0EexmBGAZinEKrIgjOJDw0Y3baOYKY5WYU6Fn02CCNsradOFhxqi377oUMYHm6j8pacX9Q2WejlBkqY2XYLVoBkG5TL0KLWW/0vq0AehEo88iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q6EIsiRI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GE3jylvc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q6EIsiRI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GE3jylvc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5609467129;
	Thu, 28 May 2026 06:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phFDLr8sYCyOLR/3TBquNKZIZoYYJRcuAIL5ETpAHhg=;
	b=q6EIsiRIO3HookMTzynOUdM4MRMfgVWSuXTQFGxDeg8jFnQ2FK9xt6QKzDuzPwE2GVrlqJ
	rofnZmWmS604mTjSQBlLjJuRLJW1wTkAoHQAjb9AX06YRa5wvkFrjKse3NC4ddw+AvxnVz
	mxmie7NEDywe0tgBKVbzyQMd9HtlnCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phFDLr8sYCyOLR/3TBquNKZIZoYYJRcuAIL5ETpAHhg=;
	b=GE3jylvc6kX4r5qYDmy7FuOv0pC8rPlojqm76WB9u4SEmQAqQZf/pb4sxYJjah/V9nKFxh
	9EzTRTDckOogbSBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q6EIsiRI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GE3jylvc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phFDLr8sYCyOLR/3TBquNKZIZoYYJRcuAIL5ETpAHhg=;
	b=q6EIsiRIO3HookMTzynOUdM4MRMfgVWSuXTQFGxDeg8jFnQ2FK9xt6QKzDuzPwE2GVrlqJ
	rofnZmWmS604mTjSQBlLjJuRLJW1wTkAoHQAjb9AX06YRa5wvkFrjKse3NC4ddw+AvxnVz
	mxmie7NEDywe0tgBKVbzyQMd9HtlnCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phFDLr8sYCyOLR/3TBquNKZIZoYYJRcuAIL5ETpAHhg=;
	b=GE3jylvc6kX4r5qYDmy7FuOv0pC8rPlojqm76WB9u4SEmQAqQZf/pb4sxYJjah/V9nKFxh
	9EzTRTDckOogbSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 138AE5AC2F;
	Thu, 28 May 2026 06:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ieBIA8LbF2oxfAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 May 2026 06:08:02 +0000
Date: Thu, 28 May 2026 08:08:01 +0200
Message-ID: <87eciwukvy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mike Karcic <mikekarcic@protonmail.com>
Cc: Sean Rhodes <sean@starlabs.systems>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tiwai@suse.de" <tiwai@suse.de>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
In-Reply-To: <wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[protonmail.com];
	TAGGED_FROM(0.00)[bounces-254718-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5DF3A5ED205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 01:18:31 +0200,
Mike Karcic wrote:
> 
> I tested both setups on top of Debian's 6.12.90 source tree. 
> 
> 1. I applied the 46c862f5419e patch, but the chirp was still there on every audio transition.
> 2. I did a full revert of 630fbc6e870e, and the chirp is completely gone.

There is a follow-up fix in the upstream, try to apply the commit
46c862f5419e ("ALSA: hda/realtek - fixed speaker no sound update").


thanks,

Takashi


> 
> My hardware is a Lenovo ThinkPad (Meteor Lake), ALC287, subsystem 17aa:231e.
> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Wednesday, May 27th, 2026 at 3:44 PM, Sean Rhodes <sean@starlabs.systems> wrote:
> 
> > What about 630fbc6e870e? If so, 46c862f5419e looks relevant.
> > 
> > On Wed, 27 May 2026 at 15:25, Mike Karcic <mikekarcic@protonmail.com> wrote:
> > >
> > > Speaker pop/chirp regression on a Lenovo ThinkPad with Meteor Lake and
> > > Realtek ALC287 (subsystem ID 17aa:231e). The chirp occurs on speaker
> > > power state transitions when audio starts or stops. It is not present
> > > on kernel 6.12.73 and is present on 6.12.85. A desktop with ALC897
> > > (subsystem ID 1f660202) on kernel 6.19.14 is unaffected, so this is
> > > codec/fixup-specific.
> > >
> > > Tested on the same LMDE (Debian 13) installation with multiple kernels
> > > selectable from GRUB. All userspace, firmware, and configuration are
> > > identical between tests. Cold boot between kernel switches is required,
> > > as warm reboot can carry codec register state forward. The kernel is
> > > not tainted on any tested version.
> > >
> > > Bisection results (Debian package versions):
> > >   6.12.48  -- no chirp
> > >   6.12.73  -- no chirp
> > >   6.12.85  -- chirp present
> > >   6.12.86  -- chirp present
> > >   6.12.90  -- chirp present
> > >
> > > Also broken: 6.19.14-101.fc44.x86_64 (Fedora/Aurora 44)
> > >
> > > The regression window (6.12.73 to 6.12.85) includes two commits
> > > targeting speaker pop on the Star Labs StarFighter (ALC233, SSID
> > > 7017:2014) that touch patch_realtek.c:
> > >
> > >   1cb3c20688fc ("ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter")
> > >   Fixes commit ("ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter")
> > >
> > > These are quirk-gated to SSID 7017:2014 and should not run on
> > > 17aa:231e, but they are the most prominent sound changes in the
> > > regression window. The actual culprit may be a different commit
> > > in the 6.12.74-6.12.85 range. I was unable to narrow further as
> > > Debian does not publish intermediate point-release packages.
> > >
> > > I can build and test vanilla kernels for a proper bisection if
> > > guided, and I can test proposed fixes.
> > >
> > > Hardware:
> > >   Lenovo ThinkPad, Meteor Lake
> > >   Codec: Realtek ALC287
> > >   Subsystem ID: 17aa:231e
> > >   PCI: 0000:00:1f.3
> > >   Machine driver: skl_hda_dsp_generic
> > >   Codec fixup: "ALC287: picked fixup for PCI SSID 17aa:231e"
> > >
> > > Unaffected hardware (same 6.19.14 kernel, no chirp):
> > >   Desktop, Realtek ALC897, Subsystem ID: 1f660202
> > >
> > > Controlled variables (identical across all tested 6.12 kernels):
> > >   SOF firmware: 2.12.0.1 (firmware-sof-signed 2025.01-1)
> > >   Topology: intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
> > >   Topology ABI: 3:29:1 (Kernel ABI: 3:23:1 on all tested)
> > >   ALSA UCM: alsa-ucm-conf 1.2.14-1
> > >   PipeWire: 1.4.2, WirePlumber: 0.5.8
> > >   power_save: 10, hda_model: (null)
> > >   Desktop: KDE Plasma 6 (Wayland)
> > >
> > > Eliminated causes:
> > >   - Topology files in sof-ipc4-tplg/ and sof-ace-tplg/ are
> > >     byte-identical (confirmed via binary diff). Path irrelevant.
> > >   - SOF firmware version (same 2.12.0.1 on all tested kernels).
> > >   - Topology ABI mismatch (3:29:1 vs 3:23:1 present on working
> > >     kernel too).
> > >   - power_save (10 on all kernels).
> > >   - PipeWire/WirePlumber (identical versions on all kernels).
> > >   - Desktop environment (KDE on all; a KDE install triggered a
> > >     kernel update which was the actual cause of the regression
> > >     appearing).
> > >
> > > dmesg (6.12.48, working):
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/mtl/sof-mtl.ri
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-lib/mtl
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.12.0.1
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
> > >   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
> > >   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> > >
> > > dmesg (6.19.14, affected):
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/mtl/sof-mtl.ri
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-lib/mtl
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.14.1.1
> > >   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
> > >   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
> > >   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> > >
> > > Note: The kernel is not tainted on any tested version.
> >

