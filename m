Return-Path: <stable+bounces-62617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE494002E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385651F22009
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101518D4A6;
	Mon, 29 Jul 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="eum2xccz"
X-Original-To: stable@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4613A88D
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287444; cv=none; b=kxtS3CTR3heSIsXsb+RvOFbimKq9xhwP9d0ipW07m/ZpayDpE41lQNEmnoZcZBp8BAoqDRrLh7QaRPAmCLZUY4PAZWKP4XaCsS/mzPOjAw7QbB2wBvBw/4iEL7y/OuYfGepxNMYOeQOdQtqg26C6exnJnB6QiNO7W/JsPlPnUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287444; c=relaxed/simple;
	bh=8iM24PCjxernsCmrbqINdswXHOWozrexHbwMNneqCnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoCOeW56UC9vAoOyFK1nw/VOOiGjJymLaLcz1nVeYu4wqSau4qtmJjBjdZAAybXgP7Aa2moudzB6tMH9MSVgN6M7vCGZ9Sn5r5M6q9J9O09he/my1nIHjwnwzsqeAzzMzQcjNYf1nmYgXEiFSSf5rhveqabLHh5v8LsmkUOvqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=eum2xccz; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722287435; x=1722546635;
	bh=ozHc3JMbelPHTptoBAz/6oNgi6Ns5+gebFLiu+Sf76c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eum2xccz+/hnJwIR9CLuP6J650cNSR5Axg21ToxGXvCypS2Q7Cu15izt3d93CIx00
	 F7mGjz4W/PQUgwQLBrevtkpc5MmZWSJCW1OQc9P6ertS6McNA7l9YReqwTca6nMqcG
	 3GzDw7V0J1ZXMYUBY8OHU+nkCJ8CV67jftzHnDrO9zeoMoQpcy+XWoj8uessf9+qiJ
	 5yitkRxf0nRm5P3PEqcSvHNgsPfmb3Rc5k3enE3woiVznKypySEEBGM3I/sm83aJZU
	 7mmXzi9Wj+bIeTP9XTRRH09TILAzFZ+MefjBBAqJ8NIYOI48hdBmzJry/J9W4louO2
	 io4V4kS5frOXQ==
Date: Mon, 29 Jul 2024 21:10:30 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org, "edmund . raile" <edmund.raile@proton.me>
Subject: [PATCH v3 2/3] Revert "ALSA: firewire-lib: operate for period elapse event in process context"
Message-ID: <20240729211020.752203-3-edmund.raile@protonmail.com>
In-Reply-To: <20240729211020.752203-1-edmund.raile@protonmail.com>
References: <20240729211020.752203-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 8ac0b827d9e34fa2a2c90119161aea6441bd03f0
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



