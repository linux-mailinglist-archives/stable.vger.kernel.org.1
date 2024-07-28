Return-Path: <stable+bounces-62143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63C93E515
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A7281960
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0589F4174C;
	Sun, 28 Jul 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="a1KjOzNc"
X-Original-To: stable@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822C5103F
	for <stable@vger.kernel.org>; Sun, 28 Jul 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722169875; cv=none; b=YyvokBT+Q3NPVj4xEjOkIORf1DpOL80XuHdjf4dl4gaCmJunSmzOfEKkN99zsO8sXAV5vsnfRDtwt+atwn9V4vdyNHf+fR9eNiRwkdD7UBgd/ort4ErhsFKZC964oqQpAgcExBMQkpvzWps+tsi9DH/hic3+ml3mgsERrP7dnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722169875; c=relaxed/simple;
	bh=zYeI0RXOOsfL8/wFCi+vO2omAPFQKXW51I6FzL+Chhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpwUci0Y30vHAiEQqRPzrrVfq2FRHjVt6Yhc9LLiyd87h5UNmu61YIBT/SNc0esJEj9HfK0m6LkC9cd6Lkx3kdcQEg6x2uJTaDKwSe18IgBSWRCZcAJnhbi0CBtqTOGoCzGZpUNwpzxDuCjzS2OWQ+uxSP7hob2z2OYkuvO3Ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=a1KjOzNc; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722169867; x=1722429067;
	bh=KBafj0W+hLUSbIhjE/xmSCOMhfBOVKrA7riUOgwT7ls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a1KjOzNcElvwgZR+zofIEb5MYjjMzwqyPOZl0LHgc9yPH3JVWDU238enBD++qXpNi
	 OTXQHGgqoPmOJr48llF0f1pJsHbon+M0sF8YUnHjhW5uaGqxlQ3DVcWrUXM4IATro9
	 n2DLow+7vrkx3HqthV9IemMBBKmVUJQu9TnkzPMcIhgLFVlcCLgy2L4JhAa7Cg1fsk
	 wxl7zp0TTjNYaMwe8Xu7A3Zckg7U1WjzVi34ECZPFW4kpW+fb9ysoV6EzK/OhnZEtb
	 3FETPM8X8DvuSdrhlDcPurtEUmTdgJ3PInl4VX4nxp/s6GAjSVFuUFs5IZCqDBAT24
	 KyiZInE5KhP6w==
Date: Sun, 28 Jul 2024 12:31:03 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, edmund.raile@protonmail.com, stable@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <20240728123041.330216-3-edmund.raile@protonmail.com>
In-Reply-To: <20240728123041.330216-1-edmund.raile@protonmail.com>
References: <20240728123041.330216-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 5e1ed2a306242a75e68ed5c02831d4a3f6f0a481
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

With RME Fireface 800, this lead to a regression since Kernels 5.14.0,
causing a deadlock with eventual system freeze under ALSA operation:

A. In the process context
    * (lock A) Acquiring spin_lock by snd_pcm_stream_lock_irq() in
=09snd_pcm_status64()
    * (lock B) Then attempt to enter tasklet

B. In the softIRQ context
    * (lock B) Enter tasklet
    * (lock A) Attempt to acquire spin_lock by
=09snd_pcm_stream_lock_irqsave() in snd_pcm_period_elapsed()

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
between ALSA substream process context spin_lock of
snd_pcm_stream_lock_irq() in snd_pcm_status64()
and OHCI 1394 IT softIRQ context spin_lock of
snd_pcm_stream_lock_irqsave() in snd_pcm_period_elapsed().

Cc: stable@vger.kernel.org
Fixes: 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event i=
n process context")
Link: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hze=
o4simnl@jn3eo7pe642q/
Reported-by: edmund.raile <edmund.raile@proton.me>
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 sound/firewire/amdtp-stream.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 31201d506a21..c037d7de1fdc 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -615,16 +615,9 @@ static void update_pcm_pointers(struct amdtp_stream *s=
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
+=09=09=09// wq used with amdtp_domain_stream_pcm_pointer() to prevent dead=
lock
+=09=09=09queue_work(system_highpri_wq, &s->period_work);
 =09}
 }
=20
@@ -1866,9 +1859,11 @@ unsigned long amdtp_domain_stream_pcm_pointer(struct=
 amdtp_domain *d,
=20
 =09// Process isochronous packets queued till recent isochronous cycle to =
handle PCM frames.
 =09if (irq_target && amdtp_stream_running(irq_target)) {
-=09=09// In software IRQ context, the call causes dead-lock to disable the=
 tasklet
-=09=09// synchronously.
-=09=09if (!in_softirq())
+=09=09// use wq to prevent deadlock between process context spin_lock
+=09=09// of snd_pcm_stream_lock_irq() in snd_pcm_status64() and
+=09=09// softIRQ context spin_lock of snd_pcm_stream_lock_irqsave()
+=09=09// in snd_pcm_period_elapsed()
+=09=09if ((!in_softirq()) && (current_work() !=3D &s->period_work))
 =09=09=09fw_iso_context_flush_completions(irq_target->context);
 =09}
=20
--=20
2.45.2



