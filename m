Return-Path: <stable+bounces-64663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6C942119
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 21:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7F1C22E93
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AD18CC0A;
	Tue, 30 Jul 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VNOFhtsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF918CBE1;
	Tue, 30 Jul 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369221; cv=none; b=QMcmthRd2UPKDc5TuzJ6ANyE82zGA5UIh+cBw4tYDAQqNWBYShFwtDY16e0YAA+mJ+SxDCphp8dHcebZN++SXWSQ3W7W5kEjp/vcC590cMZvBaIcV033V+mq3mnvny7JLxej8EDWlQE1ZkG0ogL7fP+cfprnisO7qrmhfpyMEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369221; c=relaxed/simple;
	bh=7t2pb5/6Q/LkGZmrG+ccU7x8AQ7CkBLsXiBJgc4OsqY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXsE3DuVG/sf7NC38HZtuaYd08JMCQB0RjTg8jIlJUNBaViWyKFi2mO6s+izH23T0KpTx2BX8c8C82iZA4Uq2XG7UmqoNF1FDIYOr+q3N0Fg+iEoe0CeW1d0R3QwZ6UVGZ6NhYpRZ3wIvUadJSxCPDhDh5omk2xbVPVV9u4FrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VNOFhtsG; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722369211; x=1722628411;
	bh=jywWkedUWZsQUoqanntjxmq0rUgTqu6frKuhe/bbf+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VNOFhtsGfwXJInt2Au4rVPgZxoMEG5asE978MEg4iNvPRB3rp4pvsEp8+vfEWT5rn
	 nHbSJ0AOwcldCFHQo9UAivw+hkoaw6AqZMUIq2IpSJZazo8A1MIJvOZLPtV8BPTEO9
	 9NaXQsPk9VdVjb3Uq0rwYqdTrazThIEZqaam6rCidKU73Gj9rPYPwEM/5YhcgkpeDe
	 a6dDyQ5UuZ8m0XgotsZqQL2nvTeegP4QkgTzwLjUxou7Qnt/kcKbbw96FiEHNqKguP
	 YZ1C1VYO50l2Fv0r1tDB8vTOtFQmH+SHkvOStfjgrguq+jjmT2xYe7nX7FEQ8oJHpc
	 TroRmWsf5mqMg==
Date: Tue, 30 Jul 2024 19:53:29 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v4 2/2] Revert "ALSA: firewire-lib: operate for period elapse event in process context"
Message-ID: <20240730195318.869840-3-edmund.raile@protonmail.com>
In-Reply-To: <20240730195318.869840-1-edmund.raile@protonmail.com>
References: <20240730195318.869840-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: ae12f90033d54c69dac6f2fe2a36cdef77a7bfee
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event
in process context") removed the process context workqueue from
amdtp_domain_stream_pcm_pointer() and update_pcm_pointers() to remove
its overhead.

With RME Fireface 800, this lead to a regression since
Kernels 5.14.0, causing an AB/BA deadlock competition for the
substream lock with eventual system freeze under ALSA operation:

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

Restore the process context work queue to prevent deadlock
AB/BA deadlock competition for ALSA substream lock of
snd_pcm_stream_lock_irq() in snd_pcm_status64()
and snd_pcm_stream_lock_irqsave() in snd_pcm_period_elapsed().

revert commit 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period
elapse event in process context")

Replace inline description to prevent future deadlock.

Cc: stable@vger.kernel.org
Fixes: 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event i=
n process context")
Reported-by: edmund.raile <edmund.raile@proton.me>
Closes: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76h=
zeo4simnl@jn3eo7pe642q/
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 sound/firewire/amdtp-stream.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 31201d506a21..7438999e0510 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -615,16 +615,8 @@ static void update_pcm_pointers(struct amdtp_stream *s=
,
 =09=09// The program in user process should periodically check the status =
of intermediate
 =09=09// buffer associated to PCM substream to process PCM frames in the b=
uffer, instead
 =09=09// of receiving notification of period elapsed by poll wait.
-=09=09if (!pcm->runtime->no_period_wakeup) {
-=09=09=09if (in_softirq()) {
-=09=09=09=09// In software IRQ context for 1394 OHCI.
-=09=09=09=09snd_pcm_period_elapsed(pcm);
-=09=09=09} else {
-=09=09=09=09// In process context of ALSA PCM application under acquired l=
ock of
-=09=09=09=09// PCM substream.
-=09=09=09=09snd_pcm_period_elapsed_under_stream_lock(pcm);
-=09=09=09}
-=09=09}
+=09=09if (!pcm->runtime->no_period_wakeup)
+=09=09=09queue_work(system_highpri_wq, &s->period_work);
 =09}
 }
=20
@@ -1864,11 +1856,14 @@ unsigned long amdtp_domain_stream_pcm_pointer(struc=
t amdtp_domain *d,
 {
 =09struct amdtp_stream *irq_target =3D d->irq_target;
=20
-=09// Process isochronous packets queued till recent isochronous cycle to =
handle PCM frames.
 =09if (irq_target && amdtp_stream_running(irq_target)) {
-=09=09// In software IRQ context, the call causes dead-lock to disable the=
 tasklet
-=09=09// synchronously.
-=09=09if (!in_softirq())
+=09=09// use wq to prevent AB/BA deadlock competition for
+=09=09// substream lock:
+=09=09// fw_iso_context_flush_completions() acquires
+=09=09// lock by ohci_flush_iso_completions(),
+=09=09// amdtp-stream process_rx_packets() attempts to
+=09=09// acquire same lock by snd_pcm_elapsed()
+=09=09if (current_work() !=3D &s->period_work)
 =09=09=09fw_iso_context_flush_completions(irq_target->context);
 =09}
=20
--=20
2.45.2



