Return-Path: <stable+bounces-254658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJcFOo1JF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40C5E99AA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D383F3035B44
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580B38A73C;
	Wed, 27 May 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="JjH+3Pdc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013A314D18
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911049; cv=pass; b=iz3mwodUkTRnZpld5BfFJp91UfaP6SVHA+D6UVga7RGysu84nmi8Ve1KbYS4wkg58nAqvWyt1moI4UH3OQOwdXKa4Llniboo2oMX641gVKSykKMUPFByLZbHMFqocGq4fWR8gqPLRcphYX/n2aDKw6TdJyZEQ+BdhMa0JYBkHN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911049; c=relaxed/simple;
	bh=14VuuczbbbJJzvas9wgl1DbntX0aiuRCU3bNBOwDiiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2F407HIRbNzJjqBHpzJ3gD2kzqNBhN8XX2pyRxdRVPHus4xyMKsUHcQ3kFUf5PCVWHraK1iejnyKTSM2uElZklfPBE8Ns1BV1A3Xxyc6lGM8idSGLUKzpXLMYgDKhOghN8ITv+z6rWnfz9dTd6Ady1B7MEuTDXm4/k0wu9h7/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=JjH+3Pdc; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bdf83185bbso120006197b3.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779911046; cv=none;
        d=google.com; s=arc-20240605;
        b=h9CJ2czRBGfSpORFBdlqXF/gOWWkCC9Pb+v4lJhlM9hB5P6CwWmBRIvBE0oM0yvfHM
         ICXQQB74zK9qC5qCzvJeaiQm/VfBr5t3Pxfxs2/6Cweszl/FPiEoJYVScnIA2qB85Li2
         CQQ75NEl1PVn6g5qmsjH/jwfOSi0XY2vAuw8Y/sPHxPHp9uyphmgyqIM/bXJ8cwOMa+A
         8C+z/iybE/buDxStjyjKe2Ek7dLHtfG8/lrRV1Bicjz/5GpY70GomeRQqPMT0Xu+G5To
         U/Jh3NPdFS18OUzaGmNMF5hPQer9p480e+mz6CWkShKU5RB5CAVcM4NRZKIUCkQe5Vtr
         oiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FX5Hf9gPxUMFpP1qebZLUIn5OeRCY5lA9+CMYbnXhBs=;
        fh=qBCU2xij2srw/meVsoSUa7wn3YYV4eGPR7cyw7G7Rtc=;
        b=K/KFueSm79EoiPNyhJCiUVmaOnRwdsT1MorpLlBxYQ783N9Aj+HjobUc4qmnRTE2/n
         MW8ecerm1Br5FukZamBtxiEzkhcw0KA3aZc5SqeGIBFTZwlEaszVfF+wHfp/zc2WmeYR
         9CT4nIn8Qq9TVJl8c704tTmfQvlHMRpd6xlq2Z4Dlxyi6bA/seZ4Wg5+AP2sNBQS3nyJ
         Rv8xcXNXdOAZvRXPBoHRsjXj9cGZppI5HpBPQPXgHsDfxunCfSMYxR5Y3atunAWlK/bj
         x7FpMC/Ko8VKmyvE6dA+op859sbRokYLm/73O3goGcB2ZelPplO23SyQcc7dW0RfYqIN
         cTmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1779911046; x=1780515846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FX5Hf9gPxUMFpP1qebZLUIn5OeRCY5lA9+CMYbnXhBs=;
        b=JjH+3PdczhqNq+4D6+roi5vz2xZf4XRLw8jxJa4Ntaj5nq2p3HcRjU5dxC6cz2Z9Xo
         C6wxLaggFNgzfpVa4WuolEKrw1Or0lpwXkO4fRzQI+r7+ka+XwVBakoC+eKoJA5a8cdf
         GUhbx/CZkmqKXASowWnJn5znSxsmX9fBXKRIrfdNy/X6/99y3zfpdXJNZURe39yHmeUe
         BXeAFcNProum98blgHKD6AR1EiX1hEXNMWthcOluYKSAOg32k9x/+svhVIX4L08vWbKf
         rHNKYfQW8+Gb9KjZOZNk8I+CXDb+Ci2o/olbYFG27N9dr1rU8PRxT4HHvrlMnMQS6Vuv
         9kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911046; x=1780515846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX5Hf9gPxUMFpP1qebZLUIn5OeRCY5lA9+CMYbnXhBs=;
        b=jf6pLjIENAM3lgdNTPqDARwIbMkz6oDu9EM462I+TiM7hNMp+bJgZwmBpdoNmBhJcL
         lV8vil34Q4XX2oGVFtHCuvnjMxxFq25n0vhv0TPGMRNvSjmb5ygdFcyS0NyrnbK3vXFA
         M6l6h2REtB6sDVLGaTdXoLqboEVRp/K5MXgYkfbpvAOQ4t3s7JVPHfs2A7BSJXxsgROP
         Lbo3wsH0BPuO+fIpNnOvSLaTalK/+rCCR0hhMyyKmZRe16R8s/PRXbjGCI1qenjBqie4
         YBq907/JqVyDqx+t2imjijkJbJphBDwbyLxSuZZzTE4q3B3ZWsYrcVHZB2st4LYCo72T
         F+Rg==
X-Gm-Message-State: AOJu0Yz53woJqNX6OpyUNGrzJ7ab0FvN4emUcqHxOzZy1ZmtdfhecVSl
	SdXj2VAjNZYS358MZiC+a8XYzMZAl3eeZ2dUurSU1fUoGAgYr4SLbSQVUz1ko2y5fguc2bu20y7
	1tQVAvl5AbCGngTmtFpbpfy4LcPYxHn79sri2lv+Y
X-Gm-Gg: Acq92OFu5Roce7FqjVf16irxg3JrEZTVUXFygzkEAECoL+k5brtYEFCLhf9NB7C5/rD
	WfFt7x3Rqm5fHYdnwh8yOEOTYg+uT4sa6oZGL7GgYxLpQZj3V1XX7chxiDvCdKq1K+/s8xT7FdI
	cXiGW9GH2/kN2pvWDeIp5U+N6ncqMzWP+Ds9Kn/rm/Gz5yQuoxjVwIZlhRBtFijdp+2q7YblVa1
	YeT/Czk7WGMnJPU6sRxLhzWxnEskE6YOIc770htLPrsgAdVapw1qd9daZjbMaxeoKA04hWNNuYk
	jixzyMDZBrXVd08uYobYUHc7zvkJQaZWR1dIIWo2vPzLbX6E
X-Received: by 2002:a05:690c:67c5:b0:7db:f1b4:15e5 with SMTP id
 00721157ae682-7dbf1b41890mr21136197b3.4.1779911045555; Wed, 27 May 2026
 12:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
In-Reply-To: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 27 May 2026 20:43:54 +0100
X-Gm-Features: AVHnY4KcMXIIodDKjDBrd3BWymN4LQ43bArzZMANNcnK7-IF5wv-P0tsligTKF0
Message-ID: <CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
To: Mike Karcic <mikekarcic@protonmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[starlabs-systems.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[starlabs.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[protonmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[starlabs-systems.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean@starlabs.systems,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254658-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B40C5E99AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

What about 630fbc6e870e? If so, 46c862f5419e looks relevant.

On Wed, 27 May 2026 at 15:25, Mike Karcic <mikekarcic@protonmail.com> wrote:
>
> Speaker pop/chirp regression on a Lenovo ThinkPad with Meteor Lake and
> Realtek ALC287 (subsystem ID 17aa:231e). The chirp occurs on speaker
> power state transitions when audio starts or stops. It is not present
> on kernel 6.12.73 and is present on 6.12.85. A desktop with ALC897
> (subsystem ID 1f660202) on kernel 6.19.14 is unaffected, so this is
> codec/fixup-specific.
>
> Tested on the same LMDE (Debian 13) installation with multiple kernels
> selectable from GRUB. All userspace, firmware, and configuration are
> identical between tests. Cold boot between kernel switches is required,
> as warm reboot can carry codec register state forward. The kernel is
> not tainted on any tested version.
>
> Bisection results (Debian package versions):
>   6.12.48  -- no chirp
>   6.12.73  -- no chirp
>   6.12.85  -- chirp present
>   6.12.86  -- chirp present
>   6.12.90  -- chirp present
>
> Also broken: 6.19.14-101.fc44.x86_64 (Fedora/Aurora 44)
>
> The regression window (6.12.73 to 6.12.85) includes two commits
> targeting speaker pop on the Star Labs StarFighter (ALC233, SSID
> 7017:2014) that touch patch_realtek.c:
>
>   1cb3c20688fc ("ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter")
>   Fixes commit ("ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter")
>
> These are quirk-gated to SSID 7017:2014 and should not run on
> 17aa:231e, but they are the most prominent sound changes in the
> regression window. The actual culprit may be a different commit
> in the 6.12.74-6.12.85 range. I was unable to narrow further as
> Debian does not publish intermediate point-release packages.
>
> I can build and test vanilla kernels for a proper bisection if
> guided, and I can test proposed fixes.
>
> Hardware:
>   Lenovo ThinkPad, Meteor Lake
>   Codec: Realtek ALC287
>   Subsystem ID: 17aa:231e
>   PCI: 0000:00:1f.3
>   Machine driver: skl_hda_dsp_generic
>   Codec fixup: "ALC287: picked fixup for PCI SSID 17aa:231e"
>
> Unaffected hardware (same 6.19.14 kernel, no chirp):
>   Desktop, Realtek ALC897, Subsystem ID: 1f660202
>
> Controlled variables (identical across all tested 6.12 kernels):
>   SOF firmware: 2.12.0.1 (firmware-sof-signed 2025.01-1)
>   Topology: intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
>   Topology ABI: 3:29:1 (Kernel ABI: 3:23:1 on all tested)
>   ALSA UCM: alsa-ucm-conf 1.2.14-1
>   PipeWire: 1.4.2, WirePlumber: 0.5.8
>   power_save: 10, hda_model: (null)
>   Desktop: KDE Plasma 6 (Wayland)
>
> Eliminated causes:
>   - Topology files in sof-ipc4-tplg/ and sof-ace-tplg/ are
>     byte-identical (confirmed via binary diff). Path irrelevant.
>   - SOF firmware version (same 2.12.0.1 on all tested kernels).
>   - Topology ABI mismatch (3:29:1 vs 3:23:1 present on working
>     kernel too).
>   - power_save (10 on all kernels).
>   - PipeWire/WirePlumber (identical versions on all kernels).
>   - Desktop environment (KDE on all; a KDE install triggered a
>     kernel update which was the actual cause of the regression
>     appearing).
>
> dmesg (6.12.48, working):
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/mtl/sof-mtl.ri
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-lib/mtl
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.12.0.1
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
>   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
>   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
>
> dmesg (6.19.14, affected):
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
>   sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
>   sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
>   sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware paths/files for ipc type 1:
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/mtl/sof-mtl.ri
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-lib/mtl
>   sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:     intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware version: 2.14.1.1
>   sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
>   snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup for PCI SSID 17aa:231e
>   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
>
> Note: The kernel is not tainted on any tested version.

