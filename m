Return-Path: <stable+bounces-62621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8DA94008C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30E2282A4A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950918E76D;
	Mon, 29 Jul 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rdiI80yt"
X-Original-To: stable@vger.kernel.org
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5018D4C6
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289347; cv=none; b=meU5ewN2VRgg8+ltbb1ZYTMzGWW0kIX+fwYPV7iwZ5u9dnfTc+PAz45uHAi+YXYs+L+bb/dwTXK6moIGnF7Z2+S7OkuhLPXcKSa5RPCzEYjT9Oe8PHgVCHOwuCLNaQJsIip8ls1+c3i29FbuIP0yU8Ivu9kR/KWHGVG7Rs3KElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289347; c=relaxed/simple;
	bh=8iM24PCjxernsCmrbqINdswXHOWozrexHbwMNneqCnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajw/TJtHjQzwsZWlA36QGxYBdZDoWuPZmlpuRW28WFOj2Vw2KVE5lJr88QyLkl5qjYH9L/k4xaG1rwwefxZiHPFgOtwEvLyV9DFb40V+D2SwNOUzIrDHUOquhUV5Hz2udIdnWSp1tZ5Badn+xLDg/a3KNmVehFm0wUwu1YUUXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rdiI80yt; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722289343; x=1722548543;
	bh=ozHc3JMbelPHTptoBAz/6oNgi6Ns5+gebFLiu+Sf76c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rdiI80yt1jkTRytui3ySgkcyyiiE9z16O9rdUOu+B2k7sf5p3VjJxNZ0DDTjLZj3E
	 kQD3aygEjkwWrGcOxme1i7U3lXrk+FHrjAiDEmHdgoCdxnNrrl/dDlcK4sZlxVJRvz
	 O4JJgqYfCK0+S/F8kbptDh3RlTaupfS+2qNVCNea4/AP0uP05nxk0F8ZaQytoCTOIa
	 Xmnk6zOIxTOEDt2zVJ6qg/PFra3dxVmljEcsi1zpqoWWndzx6dWFKcoBpyssAhizQ+
	 Bth8dPfJTrqXxi/TF0EQ3FOuthiZWu3E3gErkwRUiFtguCaG0HArijSdglP2VVOCth
	 c4nAUypyRrusQ==
Date: Mon, 29 Jul 2024 21:42:18 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 2/3] Revert "ALSA: firewire-lib: operate for period elapse event in process context"
Message-ID: <20240729214149.752663-3-edmund.raile@protonmail.com>
In-Reply-To: <20240729214149.752663-1-edmund.raile@protonmail.com>
References: <20240729214149.752663-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 613ccd6c4c053b9a39492559685e3884775e4347
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

commit 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse
event in process context")

Cc: stable@vger.kernel.org
Fixes: 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event i=
n process context")
Link: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hze=
o4simnl@jn3eo7pe642q/
Reported-by: edmund.raile <edmund.raile@proton.me>
Closes: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76h=
zeo4simnl@jn3eo7pe642q/
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 sound/firewire/amdtp-stream.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 31201d506a21..a07b0452267d 100644
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
@@ -1864,11 +1856,22 @@ unsigned long amdtp_domain_stream_pcm_pointer(struc=
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
+=09=09// This function is called in software IRQ context of
+=09=09// period_work or process context.
+=09=09//
+=09=09// When the software IRQ context was scheduled by software IRQ
+=09=09// context of IT contexts, queued packets were already handled.
+=09=09// Therefore, no need to flush the queue in buffer furthermore.
+=09=09//
+=09=09// When the process context reach here, some packets will be
+=09=09// already queued in the buffer. These packets should be handled
+=09=09// immediately to keep better granularity of PCM pointer.
+=09=09//
+=09=09// Later, the process context will sometimes schedules software
+=09=09// IRQ context of the period_work. Then, no need to flush the
+=09=09// queue by the same reason as described in the above
+=09=09if (current_work() !=3D &s->period_work)
 =09=09=09fw_iso_context_flush_completions(irq_target->context);
 =09}
=20
--=20
2.45.2



