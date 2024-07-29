Return-Path: <stable+bounces-62615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD294002C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F931C20321
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3C18C324;
	Mon, 29 Jul 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XJD87gVm"
X-Original-To: stable@vger.kernel.org
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734B13A88D
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287441; cv=none; b=NJbCM3njuH+H6kswL7cBj3keF9yu0m7mCbKQBDPBghF1xV1h6xDy+xtJBJF4EgSjcW6SetMiSguD1pjxDt6JLTJ4l7+nBQX4GkfLlkhmpJFIPQorpIzjiWcOMAIVTioxtidzRPjQgLxfqTdO+pdn+HIMwyik8+A4VFk5gawnbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287441; c=relaxed/simple;
	bh=7qJtw/UvlNXcAPicePSmEwYf5d2bgVGEcAntS/y13O8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gtxju6lxj9Cw5XqoRkjg/Fd58et6WIkmuDT+9WdbD7cP4xBaDP2d2ZE2nSNLW5euwc8gY3Mp6xL0KPK+e8ToAqu0LanTmi78UyZUry0EvvqzQ3hIeE/YVWcHwV8qekOUg8cS/9ZRlwWYvZ8sFjmcJhqqX8eE3yaz4BxGazHaTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XJD87gVm; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722287430; x=1722546630;
	bh=HEq22jk5NAJ4QPno+5COoC2Tm/I0lDMtAHj74ZnsIdE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XJD87gVmAnozhtLuYkrL2wRdboYM5EGM61nDq+e8q+e5yhrAuqxZ2mS1eWit8Co0p
	 gbm6D0UiQ6Y8zBbqVfDOtyPnhVvR9H7l0KQ0+VLmeLq5e0GbggaY5uJynS21V4iWBz
	 6XaOQJpShqfIrNTJ50Ih1UAVpo16rHm2wcKkHGnX/1oyNrFv53TV5B+8HwK4Z+u0aM
	 Ozf1ld/OYt+QlmUzG6Cltu+Uak3bSymGWy3cgIXs1lXRUKKoKdiue+SgJm7r6w7TxY
	 XEhJr0kyCHC3xRZkIUintAQ5GFIb+bCSAW+OgPC/kehfnqN99ASwjrTprqKnLWrJFt
	 lIqJbbgke3lyg==
Date: Mon, 29 Jul 2024 21:10:25 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH v3 0/3] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <20240729211020.752203-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: f59714484037c49b6ba1efe0b61eced3b617840e
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



