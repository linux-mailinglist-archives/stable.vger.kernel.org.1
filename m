Return-Path: <stable+bounces-254600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFVpN+n+FmoJ0QcAu9opvQ
	(envelope-from <stable+bounces-254600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7B5E5D4A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E205F30CBE98
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362F3E63BB;
	Wed, 27 May 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l96sxyZj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046B3451B3
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891725; cv=pass; b=F0uQrHeQTNBcPjfzT8wzHyfL3maBfe2ABvd3QgG9I5yk+k2dJ0tzPmOWeUAOItAR/sOLoBKIS+QrpldnPvmxVPctRGp+8TGALuWXDir2X+9A15b16o8X/phd3Uu/nVw+p0ne+xxihqDCkmUxxZiwxU5wmXjLpS/wPs3j2ZVLEZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891725; c=relaxed/simple;
	bh=WcTlXfqRK5RW6BJC/bAhY3JoNVwWC/yTt3liQYXXDDc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CuHc9DKhNu92uAj5MgZCETrpXGh2IuBQH+9TqUBsLnHCr7Zh6FsSkhzVzPyNAztll+7c/225OaZIEpoPJUIOHkpnX9uKB0wmj140OcswaeORI0jk2g89ep7g/jyPn7UANzwG8iBuvP0FuyF4CwZNMkWbKRNyDfAJeKjiph11vpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l96sxyZj; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2167986366b.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 07:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779891723; cv=none;
        d=google.com; s=arc-20240605;
        b=SzADHh5G3aTySoX87V2+1uPECxg4xov56fbhVMr8WvgWqIXErWVJeTiZZK5UEa8Pdu
         AKwhGoNk9SuleopYGQNtdSdbe+coAH9dQsgVQcOOT6+lyUfkokJRqs64hhzPFKgvBPiK
         0Tf3XcN4hGXILGqaEQi3X6F9Dd8/w4Z4dh7+bo9E+J69jMmZ7Jp7CFoTyrZgipOJB0KU
         WodVwJRcdy2mO+Ns93+7AfbXKG9sHocr+YM6NnbYO7fbHBumG6unXHggc1FDDrKwrFSs
         ZHTW57TAcomTuHlIyljpS3VN6Kzyxaw5UKUfmXrRXFUyco5YxLOIvfU/f/TXhZ3jYtP5
         sL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9CzZZCAsqPbmn/gI5Pp7Effwu8mfteaHKh9x+3bqRV8=;
        fh=xJAbtg6WzK8VIgI1vhUgZbVBXGg2K1Kn7DohJedtoXI=;
        b=Jhcx4RsG7CUIuQIicjX/AGRDDB6sQC+RYo/DuDnD1PwNQ0CrJJ7yT7bZggv13Kv8yX
         iDWfroWdG7/+61NaseMYUJ4fqYThy1vYpTN5F7W4GMezJCzBXEhMpAD7ZBNJe3DHClVd
         3AlGtHHH6EeGQEo2XlmJidGwb3GguJuO8tU1k4TFCKtyktJMX/3xKxb8CvjSplC0TEeJ
         2VPW0l/aBFBqPPwz+uZf6j98CugzIGFBOsHkHl+PsIPw16iEyehjItZX9nOn2HF0CyMi
         mgIqC+m1aYT9IgmoejznzUdKTklGdhfB3xjUwThYBz0P+uhf+UH5cu7waylX1Hn/gVaK
         m1bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891722; x=1780496522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CzZZCAsqPbmn/gI5Pp7Effwu8mfteaHKh9x+3bqRV8=;
        b=l96sxyZjGaHLoMmbiOZGBiynnFdj8dK2t5t9X/nn6HH+SfKew/Cxm0WfXdyvKCmBrk
         H8EijgZ3qkh8PqfuS+7WOTcUv47sXIvIrG3UcAOOLnLpkZ74w7mvP1ginZhlpyI4t0lV
         /TN+a2YVmmNKlpntCbpGpTQjd/DZ5+pvVHN0vVelFVHxkm8g74cU39gFDaymsViCbMxm
         GIJ7INZrxXDPg64a6JjiK0hN7hf9oXk0fcF3yHHV0LcLTXNsDHspX82RNuVDBvZ7EQnM
         zHlpBGYBzXug2sScK0SgVi98SJS1eyb/3SaSNkHxnVxOkyvpwAKzGkGfuWE4SbhZtUgb
         d1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891722; x=1780496522;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CzZZCAsqPbmn/gI5Pp7Effwu8mfteaHKh9x+3bqRV8=;
        b=Fx0tgMD1KHLFOC+IE3hkxdvJA+u9kIhDcij4udy53sjX0YKDun/NND1j65s/RJ++mz
         JzCgMo0zA3p5ONxC1oNnFfmDNIbgpkEflcN2wcr0OV734cfdtKKV9OgDTJkkVztB0jVm
         R94s0242KZLWWzRc5vh6VyF/VX6QTPTpFKor6tVmC7esplvCrE+8XALcRgsZxBCrLTR9
         0s3EmhEopyfwjto+Z0X0h319hBBd3r65DpY08aU9iilbQldB3hO0oUh4pcuKYxpHnEE9
         8WyfnCbPLAjBrRwA+OhM70xAzHJ7dzlsmONLtzZhgG7wESc/tyUidwfBfdAXnvVAVc1C
         CBvA==
X-Gm-Message-State: AOJu0Yz7+upLo3FkmKGRKITaMQbvzx8uqTNIG6cQzi80CeTzfzKJE74H
	dH/R5yiDFj/57Fm4jND1//xFLfOJ5gPLBSMdUCaK6VojedGww96JlG2cpIgA1ywl7sL1B6UBDTC
	uV0BLxbS6PLBFgdatOmBTgmI9xSceVwXQXRfN0enp/HIi
X-Gm-Gg: Acq92OHE6cibAYdGnCMGKl5MwJMgG0jxwIonmx0iJCPPFOh0Cte3uOEHRSs7fyIIYow
	rbT/PpBthWUtbTYUcePG+RRfj09dCCxc62TdpTErTMbDzLNzHROysB7/d3+mnnGBu3EIZV6xP30
	nq2JJLxhp3nh96wkJJLGu52NMlaNghEnBC53AtZDesKVsymjJlW9GB8D+SxeIRVxFqL/9yHT3DQ
	F6/ZXedOv7oitqGwTpqjLalWdB2qmn1kXYL+3HrGEVnbuSaB0yzBZV1But8iELoTKm33ClmYAV8
	zZKXR8RuAwtBsrMgP0iMGRc9Q2XEfjOdLyte92h80cm5HIRD9a/TH9Sa6DhQs3BTNCf44UvA08m
	MrEFfhEYdxlD5+iNi7A3PRBrsqjtuUIRhLf5PzjEYYoRBKQ==
X-Received: by 2002:a17:907:96a2:b0:be3:dfa6:3117 with SMTP id
 a640c23a62f3a-be3dfa63318mr287280866b.3.1779891722268; Wed, 27 May 2026
 07:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Karcic <michael.karcic@gmail.com>
Date: Wed, 27 May 2026 10:21:51 -0400
X-Gm-Features: AVHnY4JMU58f0tW3VUtvrfWsoB9CpFh_PJZlZqsSlBulZc4gOKinzyQTx0qz0Pw
Message-ID: <CABfQdu8QYU8ox2LRCc+Q7sBUWFAZtSom7V93wsNhU1N2BJNXXQ@mail.gmail.com>
Subject: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) --
 6.12.73 to 6.12.85
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tiwai@suse.de, sean@starlabs.systems
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254600-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelkarcic@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7CF7B5E5D4A
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

  1cb3c20688fc ("ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter")
  Fixes commit ("ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter")

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
  sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:
intel/sof-ipc4/mtl/sof-mtl.ri
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path:
intel/sof-ipc4-lib/mtl
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:
intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
  sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.12.0.1
  sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
  snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
  snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1
(0x17/0x0/0x0/0x0/0x0) type:speaker

dmesg (6.19.14, affected):
  sof-audio-pci-intel-mtl 0000:00:1f.3: Digital mics found on Skylake+
platform, using SOF driver
  sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if 0x040380
  sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
  sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver
skl_hda_dsp_generic now
  sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:
intel/sof-ipc4/mtl/sof-mtl.ri
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path:
intel/sof-ipc4-lib/mtl
  sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:
intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg
  sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.14.1.1
  sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
  snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
  snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1
(0x17/0x0/0x0/0x0/0x0) type:speaker

Note: The kernel is not tainted on any tested version.

-- 
Mike

