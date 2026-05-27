Return-Path: <stable+bounces-254691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EoHBeF7F2qqGggAu9opvQ
	(envelope-from <stable+bounces-254691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:18:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107095EAE2F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CFA430396B7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D383BB683;
	Wed, 27 May 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="B2chpYkk"
X-Original-To: stable@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8583C09FA
	for <stable@vger.kernel.org>; Wed, 27 May 2026 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923923; cv=none; b=f8eCpTx6WETTUUd3EkqPv0ZS4RLV/Frsl8ARfnBI4di7/wwEEfW7vVQMqykL1IPaz+0RDPdaGJw4IgAjgfvhowkPKoWIb3IHbQ42U7ukjeemXMkPQCU+L3tcRtj5bt4N6rwDOEoBSaGUHWc4DPS635kQfzI1h+Vu6pzqfj8vQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923923; c=relaxed/simple;
	bh=/Q/o/zW23TiPbktRBBM7635BT37g+sMk3VHH12tV6eA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6P194bV24RikJwG38/308UHVVY0djZPNX5kbiMzeWhWtEmOopJCUmq+NYT7sfOsVd/nSfKH8GvUiTJR7KokMtUfcodRwopTpqNWSW7hNak+LWVbFJ0Osv+OyqXm+RbKruBAHS71qjD48QO/2qyYALeiIHsINJwjfKOg+4qPVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=B2chpYkk; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779923913; x=1780183113;
	bh=Jwsc5dEPJOi+qa9ci7QmSjOiephx+pITZ59I2bJCB6g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B2chpYkkKVpfA2nFzBPq7WTBTly7sG9zwWquyWvpJzrUOgc4TpZceWbM2QA4S5zLj
	 ljqvwmt8JwuWpXrv817DFvNEW4Bfdif7w/5NlFQ/CjXi4ejTvOyIjc0lfMWlbav4Ye
	 NP7n5rswPof0bYinQx6us1YoneDjC8j4YJCyNkIsiMTbFXqo3ANik5X6/tKSA9bhWY
	 veFPCya3dH9MD3iriyljE28nRhvrDo3JkhV2qEf+KcwC8wo1bYW6OZM3jlGtbrLeaQ
	 rs2T04e6N/SOdPDofb4ahYTMke+CWZ6+/veOMr+76wmjH6Q47JUGJ7bWTKCl61/YTP
	 tEHqwUPV+nGJw==
Date: Wed, 27 May 2026 23:18:31 +0000
To: Sean Rhodes <sean@starlabs.systems>
From: Mike Karcic <mikekarcic@protonmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
Message-ID: <wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
In-Reply-To: <CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com> <CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
Feedback-ID: 22946815:user:proton
X-Pm-Message-ID: 7d309daaaa2b996e011461953bac0ff366edef32
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254691-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikekarcic@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,starlabs.systems:email,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 107095EAE2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I tested both setups on top of Debian's 6.12.90 source tree.=20

1. I applied the 46c862f5419e patch, but the chirp was still there on every=
 audio transition.
2. I did a full revert of 630fbc6e870e, and the chirp is completely gone.

My hardware is a Lenovo ThinkPad (Meteor Lake), ALC287, subsystem 17aa:231e=
.



Sent with Proton Mail secure email.

On Wednesday, May 27th, 2026 at 3:44 PM, Sean Rhodes <sean@starlabs.systems=
> wrote:

> What about 630fbc6e870e? If so, 46c862f5419e looks relevant.
>=20
> On Wed, 27 May 2026 at 15:25, Mike Karcic <mikekarcic@protonmail.com> wro=
te:
> >
> > Speaker pop/chirp regression on a Lenovo ThinkPad with Meteor Lake and
> > Realtek ALC287 (subsystem ID 17aa:231e). The chirp occurs on speaker
> > power state transitions when audio starts or stops. It is not present
> > on kernel 6.12.73 and is present on 6.12.85. A desktop with ALC897
> > (subsystem ID 1f660202) on kernel 6.19.14 is unaffected, so this is
> > codec/fixup-specific.
> >
> > Tested on the same LMDE (Debian 13) installation with multiple kernels
> > selectable from GRUB. All userspace, firmware, and configuration are
> > identical between tests. Cold boot between kernel switches is required,
> > as warm reboot can carry codec register state forward. The kernel is
> > not tainted on any tested version.
> >
> > Bisection results (Debian package versions):
> >   6.12.48  -- no chirp
> >   6.12.73  -- no chirp
> >   6.12.85  -- chirp present
> >   6.12.86  -- chirp present
> >   6.12.90  -- chirp present
> >
> > Also broken: 6.19.14-101.fc44.x86_64 (Fedora/Aurora 44)
> >
> > The regression window (6.12.73 to 6.12.85) includes two commits
> > targeting speaker pop on the Star Labs StarFighter (ALC233, SSID
> > 7017:2014) that touch patch_realtek.c:
> >
> >   1cb3c20688fc ("ALSA: hda/realtek: Fix speaker pop on Star Labs StarFi=
ghter")
> >   Fixes commit ("ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFig=
hter")
> >
> > These are quirk-gated to SSID 7017:2014 and should not run on
> > 17aa:231e, but they are the most prominent sound changes in the
> > regression window. The actual culprit may be a different commit
> > in the 6.12.74-6.12.85 range. I was unable to narrow further as
> > Debian does not publish intermediate point-release packages.
> >
> > I can build and test vanilla kernels for a proper bisection if
> > guided, and I can test proposed fixes.
> >
> > Hardware:
> >   Lenovo ThinkPad, Meteor Lake
> >   Codec: Realtek ALC287
> >   Subsystem ID: 17aa:231e
> >   PCI: 0000:00:1f.3
> >   Machine driver: skl_hda_dsp_generic
> >   Codec fixup: "ALC287: picked fixup for PCI SSID 17aa:231e"
> >
> > Unaffected hardware (same 6.19.14 kernel, no chirp):
> >   Desktop, Realtek ALC897, Subsystem ID: 1f660202
> >
> > Controlled variables (identical across all tested 6.12 kernels):
> >   SOF firmware: 2.12.0.1 (firmware-sof-signed 2025.01-1)
> >   Topology: intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
> >   Topology ABI: 3:29:1 (Kernel ABI: 3:23:1 on all tested)
> >   ALSA UCM: alsa-ucm-conf 1.2.14-1
> >   PipeWire: 1.4.2, WirePlumber: 0.5.8
> >   power_save: 10, hda_model: (null)
> >   Desktop: KDE Plasma 6 (Wayland)
> >
> > Eliminated causes:
> >   - Topology files in sof-ipc4-tplg/ and sof-ace-tplg/ are
> >     byte-identical (confirmed via binary diff). Path irrelevant.
> >   - SOF firmware version (same 2.12.0.1 on all tested kernels).
> >   - Topology ABI mismatch (3:29:1 vs 3:23:1 present on working
> >     kernel too).
> >   - power_save (10 on all kernels).
> >   - PipeWire/WirePlumber (identical versions on all kernels).
> >   - Desktop environment (KDE on all; a KDE install triggered a
> >     kernel update which was the actual cause of the regression
> >     appearing).
> >
> > dmesg (6.12.48, working):
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc ty=
pe 1:
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-i=
pc4/mtl/sof-mtl.ri
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-i=
pc4-lib/mtl
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-a=
ce-tplg/sof-hda-generic-2ch.tplg
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.12.0=
.1
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI=
 3:23:1
> >   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 1=
7aa:231e
> >   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=3D=
1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> >
> > dmesg (6.19.14, affected):
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Digital mics found on Skylake+ =
platform, using SOF driver
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with PCI class/sub=
class/prog-if 0x040380
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver skl_hd=
a_dsp_generic now
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc ty=
pe 1:
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-i=
pc4/mtl/sof-mtl.ri
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-i=
pc4-lib/mtl
> >   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-i=
pc4-tplg/sof-hda-generic-2ch.tplg
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.14.1=
.1
> >   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI=
 3:23:1
> >   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 1=
7aa:231e
> >   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=3D=
1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> >
> > Note: The kernel is not tainted on any tested version.
> 

