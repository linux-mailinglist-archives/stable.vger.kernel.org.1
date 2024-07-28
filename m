Return-Path: <stable+bounces-62141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387A93E511
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E292811CF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A915374C3;
	Sun, 28 Jul 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="IWZxJ5YD"
X-Original-To: stable@vger.kernel.org
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEE208C4
	for <stable@vger.kernel.org>; Sun, 28 Jul 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722169855; cv=none; b=jZlRDS/V3nzpI+NU6od9QRnG6M03XrCkOVc+a0fI/rpTp8AJ/ovA74+oMISDnbKt3cwx46JcPFLPWCUZjZyQSD3VeIrVxu3pe1w5GkR3XY7OOPba6JVo+PXrAFIYRyrTqFzFwe3o16rNxvXsztC+kAuF4iZxrfbQTwHi7i9Eki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722169855; c=relaxed/simple;
	bh=MAxeEGmgS9693J0PQhUIRbfqko2MsleF4u/sBRGsb4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nWfCBFWL6Ri1/eAnZOBsf6ZrHfl7tDK8kwRenHEnaKTRcBcCLm9Yoao6feiVOkczj9ZeJYaaqAVYpyjZvyve5myU6fuWoSRMJtR6ZlAsPlpPZVn7IOmgeiPPwItJV4QEBlhdZtGkLU9KzIjxXZtXhWe5fnFd/L/6cjkxZ3eXa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=IWZxJ5YD; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722169851; x=1722429051;
	bh=74jrJoeOKYDJalJmIabOoA19hszvpDADNvzc31C/j48=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IWZxJ5YDL7Ce7juBsEy5OSPMznmEIgaAgmvapHjDzlImwKLcHLrrEoKzBgIfW5YdN
	 V48cfG23FDwCwzrrPZs8aHZxPNLAAIHBBMZ03ku7C5e66JU/JSJSwJcTgUC4GsvUuQ
	 ECTwsEbg6yRqJ5uab6snoarybnTc2J4y+Gby7YqzaoJ54hS6gVjREBAiNImL7wXFwS
	 sapSzAjo1CrL1D7EcFaF7hxSeCSKU/Tr/y9l2LQrSPJVIwYTaiYR8Kt61lyo1bch6K
	 /bTfUhPAyUbp29TSk+TQNpbGabhyTolAQHPQngciNHCYjrl2YcaAGQHfV2bg63cmHX
	 Nsm5/QJa8zkLA==
Date: Sun, 28 Jul 2024 12:30:47 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, edmund.raile@protonmail.com, stable@vger.kernel.org
Subject: [PATCH v2 0/2] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <20240728123041.330216-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 500a5c58425b9882f4a46ffd67423ae483b9ae31
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patchset serves to prevent a deadlock between
process context and softIRQ context:

A. In the process context
    * (lock A) Acquiring spin_lock by snd_pcm_stream_lock_irq() in
               snd_pcm_status64()
    * (lock B) Then attempt to enter tasklet

B. In the softIRQ context
    * (lock B) Enter tasklet
    * (lock A) Attempt to acquire spin_lock by snd_pcm_stream_lock_irqsave(=
) in
               snd_pcm_period_elapsed()

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

Backport note:
Also applies to and fixes on (tested):
6.10.2, 6.9.12, 6.6.43, 6.1.102, 5.15.164

Edmund Raile (2):
  ALSA: firewire-lib: restore workqueue for process context
  ALSA: firewire-lib: prevent deadlock between process and softIRQ
    context

 sound/firewire/amdtp-stream.c | 36 ++++++++++++++++++++++-------------
 sound/firewire/amdtp-stream.h |  1 +
 2 files changed, 24 insertions(+), 13 deletions(-)

--=20
2.45.2



