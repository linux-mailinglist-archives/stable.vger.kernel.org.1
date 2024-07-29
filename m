Return-Path: <stable+bounces-62620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7D940089
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB3282895
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9B18D4D3;
	Mon, 29 Jul 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pIjcGNld"
X-Original-To: stable@vger.kernel.org
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B618C326
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289340; cv=none; b=g2q/C8PviwNDhDroHzjO7ElByDK5WjZuaUq0pOPhPSvpvVH4SiK9rGwxO1/YOqdFZjajHPCBjCmW4pZmOMFIFEhjluqMGuvRimnqSpLi7FMZK+4Ru2sjBfOPaUvdGP+NsJ0s2R/UUfKxR/5pZzaqETWfa1GAcdl+cgaKpHChbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289340; c=relaxed/simple;
	bh=7qJtw/UvlNXcAPicePSmEwYf5d2bgVGEcAntS/y13O8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jVf4F/TN0MR3yWSYF7l9Zv3oECjBKEVKZsgRxx3xyf+wFP0P9pfAsdzogfhCf6GacTVA/3G6WN7V79rV2JEfdXHDZmSIeICUPO0yy9bMfFBtQNCREV1lfMTZrzNA7e5WrEyFgkgM3a5KJxc0l1lzwxLFAemBtWdcp/ulwVs3QbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pIjcGNld; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722289330; x=1722548530;
	bh=HEq22jk5NAJ4QPno+5COoC2Tm/I0lDMtAHj74ZnsIdE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pIjcGNld7NYClv7ZkFK1RuWiP9F1tpLvRoLP8rGTifQhaNbE2GBiEKfS0E9Jz6V3r
	 ZE/ufTRFm8PSvOFbj3yOq9mQl9/LsEqa9KxZp/YQuto/+FM3YQQ16vr6F0riraSr+h
	 NAzivbXI8mDlQUbyUH353eQpXGee2TEwDXDDdOKlil81qMa8S6moLYkV68FpFFTYrA
	 6rVNtlcx3J2DvFV1h7efmOZJLADUI76I2QLzr3j3eQyBg4TQZ2fw+/2+dzxQqGM41U
	 t0l9gXkouECBB9mLpiNuJS5r+p4SE33xepLyX0rGuNSn6JD9oKSilei51kWXrASaDD
	 /0+iXpQ1Phnlg==
Date: Mon, 29 Jul 2024 21:42:02 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 0/3] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <20240729214149.752663-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: e00f443d75923ea0f965957ed92a6031714d5273
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patchset serves to prevent an AB/BA deadlock:

thread 0:
    * (lock A) acquire substream lock by
=09snd_pcm_stream_lock_irq() in
=09snd_pcm_status64()
    * (lock B) wait for tasklet to finish by calling
    =09tasklet_unlock_spin_wait() in
=09tasklet_disable_in_atomic() in
=09ohci_flush_iso_completions() of ohci.c

thread 1:
    * (lock B) enter tasklet
    * (lock A) attempt to acquire substream lock,
    =09waiting for it to be released:
=09snd_pcm_stream_lock_irqsave() in
    =09snd_pcm_period_elapsed() in
=09update_pcm_pointers() in
=09process_ctx_payloads() in
=09process_rx_packets() of amdtp-stream.c

? tasklet_unlock_spin_wait
 </NMI>
 <TASK>
ohci_flush_iso_completions firewire_ohci
amdtp_domain_stream_pcm_pointer snd_firewire_lib
snd_pcm_update_hw_ptr0 snd_pcm
snd_pcm_status64 snd_pcm

? native_queued_spin_lock_slowpath
 </NMI>
 <IRQ>
_raw_spin_lock_irqsave
snd_pcm_period_elapsed snd_pcm
process_rx_packets snd_firewire_lib
irq_target_callback snd_firewire_lib
handle_it_packet firewire_ohci
context_tasklet firewire_ohci

The issue has been reported as a regression of kernel 5.14:
Link: https://lore.kernel.org/regressions/kwryofzdmjvzkuw6j3clftsxmoolynljz=
txqwg76hzeo4simnl@jn3eo7pe642q/T/#u
("[REGRESSION] ALSA: firewire-lib: snd_pcm_period_elapsed deadlock with
Fireface 800")

Commit 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event
in process context") removed the process context workqueue from
amdtp_domain_stream_pcm_pointer() and update_pcm_pointers() to remove
its overhead.
Commit b5b519965c4c ("ALSA: firewire-lib: obsolete workqueue for period
update") belongs to the same patch series and removed
the now-unused workqueue entirely.

Though being observed on RME Fireface 800, this issue would affect all
Firewire audio interfaces using ohci amdtp + pcm streaming.

ALSA streaming, especially under intensive CPU load will reveal this issue
the soonest due to issuing more hardIRQs, with time to occurrence ranging
from 2 secons to 30 minutes after starting playback.

to reproduce the issue:
direct ALSA playback to the device:
  mpv --audio-device=3Dalsa/sysdefault:CARD=3DFireface800 Spor-Ignition.fla=
c
Time to occurrence: 2s to 30m
Likelihood increased by:
  - high CPU load
    stress --cpu $(nproc)
  - switching between applications via workspaces
    tested with i915 in Xfce
PulsaAudio / PipeWire conceal the issue as they run PCM substream
without period wakeup mode, issuing less hardIRQs.

Cc: stable@vger.kernel.org
Backport note:
Also applies to and fixes on (tested):
6.10.2, 6.9.12, 6.6.43, 6.1.102, 5.15.164

Edmund Raile (3):
  Revert "ALSA: firewire-lib: obsolete workqueue for period update"
  Revert "ALSA: firewire-lib: operate for period elapse event in process
    context"
  ALSA: firewire-lib: amdtp-stream work queue inline description

 sound/firewire/amdtp-stream.c | 38 ++++++++++++++++++++++-------------
 sound/firewire/amdtp-stream.h |  1 +
 2 files changed, 25 insertions(+), 14 deletions(-)

--=20
2.45.2



