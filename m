Return-Path: <stable+bounces-254601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA69F7n/FmoJ0QcAu9opvQ
	(envelope-from <stable+bounces-254601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA75E5E06
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDDE93076798
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8840F8F4;
	Wed, 27 May 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="e91tYMgM"
X-Original-To: stable@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DC2580CF;
	Wed, 27 May 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891939; cv=none; b=dEI6iqE8jFNGPhkcBKwmU6sJgHeYg4uywFk5UnkREwjpSCV5w8Od8LdX7a/lxYhfEJsFKYfioiiqQCY9/uBLVFX0T51S0Rkuy/jpSUiNSUkZ5CJXeyITioIJ9QBlxY3k6E+9lF1XzlULC4m+cx+wq5KAN/Lv95kvNat3kgYovIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891939; c=relaxed/simple;
	bh=IlgOu6xrPBhYrYI23sQNAMauo+PA/NjtRQd/dG2lkTs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NC2byxSQNm4mtbRIrYpywpdmXM36cZhfjmmK6Dk1KS+hn5OAOeabm32JLVGOkLcfW7K6+3K7TjLjZgx8zY5pS2s+NPBhpXvK7nr3MCbOpmVLVvpWGoc8EYokGBG693HO6SBS/ebfwXvhNtUPNXwPymREGMox80dTY/6wGI64b+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=e91tYMgM; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779891926; x=1780151126;
	bh=GyV73PTYgpNpcT481vcJDYNK3HIZIfi/Inhd+Iv0V6w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=e91tYMgMaAKxQKH3RZV3KLy7feofz6Hj51cNEe4x3XsctcJpj/S/TDGt2M8ZZ0+sr
	 LyMzxsbclOChgAGQ0OsT1+PeQLoPhRpHS9BD6dqKR77zFYqeY8W/YtrIexiLGwzaZX
	 WIOc82nsjojUi/yC5eOS0jADp1190Vjp9Z+dmSdPwuD+ntoF9CvkCIG84WD7skOWVv
	 iGPiftjIYNVziuLaExAe4ZuAfAoK7gAVtaxYTsIgZyj1PeXY0GFqvYGLI1eYvhlz29
	 TgjrppCD72xc2wLGLpyyjd9NqniwDeuW+/QVeJ+FwxKXteCEtQSIwvc8R+BUgA/3iK
	 kN15ZAMsxXnrg==
Date: Wed, 27 May 2026 14:25:22 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mike Karcic <mikekarcic@protonmail.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "sean@starlabs.systems" <sean@starlabs.systems>
Subject: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
Message-ID: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
Feedback-ID: 22946815:user:proton
X-Pm-Message-ID: ac78335ef8d0016c6d3ca9ce8e876c7b91f605c8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikekarcic@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: EDEA75E5E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Speaker pop/chirp regression on a Lenovo ThinkPad with Meteor Lake and
Realtek ALC287 (subsystem ID 17aa:231e). The chirp occurs on speaker
power state transitions when audio starts or stops. It is not present
on kernel 6.12.73 and is present on 6.12.85. A desktop with ALC897
(subsystem ID 1f660202) on kernel 6.19.14 is unaffected, so this is
codec/fixup-specific.

Tested on the same LMDE (Debian 13) installation with multiple kernels
selectable from GRUB. All userspace, firmware, and configuration are
identical between tests. Cold boot between kernel switches is required,
as warm reboot can carry codec register state forward. The kernel is
not tainted on any tested version.

Bisection results (Debian package versions):
  6.12.48  -- no chirp
  6.12.73  -- no chirp
  6.12.85  -- chirp present
  6.12.86  -- chirp present
  6.12.90  -- chirp present

Also broken: 6.19.14-101.fc44.x86_64 (Fedora/Aurora 44)

The regression window (6.12.73 to 6.12.85) includes two commits
targeting speaker pop on the Star Labs StarFighter (ALC233, SSID
7017:2014) that touch patch_realtek.c:

  1cb3c20688fc ("ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighte=
r")
  Fixes commit ("ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter=
")

These are quirk-gated to SSID 7017:2014 and should not run on
17aa:231e, but they are the most prominent sound changes in the
regression window. The actual culprit may be a different commit
in the 6.12.74-6.12.85 range. I was unable to narrow further as
Debian does not publish intermediate point-release packages.

I can build and test vanilla kernels for a proper bisection if
guided, and I can test proposed fixes.

Hardware:
  Lenovo ThinkPad, Meteor Lake
  Codec: Realtek ALC287
  Subsystem ID: 17aa:231e
  PCI: 0000:00:1f.3
  Machine driver: skl_hda_dsp_generic
  Codec fixup: "ALC287: picked fixup for PCI SSID 17aa:231e"

Unaffected hardware (same 6.19.14 kernel, no chirp):
  Desktop, Realtek ALC897, Subsystem ID: 1f660202

Controlled variables (identical across all tested 6.12 kernels):
  SOF firmware: 2.12.0.1 (firmware-sof-signed 2025.01-1)
  Topology: intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
  Topology ABI: 3:29:1 (Kernel ABI: 3:23:1 on all tested)
  ALSA UCM: alsa-ucm-conf 1.2.14-1
  PipeWire: 1.4.2, WirePlumber: 0.5.8
  power_save: 10, hda_model: (null)
  Desktop: KDE Plasma 6 (Wayland)

Eliminated causes:
  - Topology files in sof-ipc4-tplg/ and sof-ace-tplg/ are
    byte-identical (confirmed via binary diff). Path irrelevant.
  - SOF firmware version (same 2.12.0.1 on all tested kernels).
  - Topology ABI mismatch (3:29:1 vs 3:23:1 present on working
    kernel too).
  - power_save (10 on all kernels).
  - PipeWire/WirePlumber (identical versions on all kernels).
  - Desktop environment (KDE on all; a KDE install triggered a
    kernel update which was the actual cause of the regression
    appearing).

dmesg (6.12.48, working):
  sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1=
:
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/=
mtl/sof-mtl.ri
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-=
lib/mtl
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ace-t=
plg/sof-hda-generic-2ch.tplg
  sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.12.0.1
  sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:2=
3:1
  snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:=
231e
  snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=3D1 (0=
x17/0x0/0x0/0x0/0x0) type:speaker

dmesg (6.19.14, affected):
  sof-audio-pci-intel-mtl 0000:00:1f.3: Digital mics found on Skylake+ plat=
form, using SOF driver
  sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with PCI class/subclas=
s/prog-if 0x040380
  sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
  sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver skl_hda_ds=
p_generic now
  sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1=
:
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/=
mtl/sof-mtl.ri
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-=
lib/mtl
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ipc4-=
tplg/sof-hda-generic-2ch.tplg
  sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.14.1.1
  sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:2=
3:1
  snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:=
231e
  snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=3D1 (0=
x17/0x0/0x0/0x0/0x0) type:speaker

Note: The kernel is not tainted on any tested version.

