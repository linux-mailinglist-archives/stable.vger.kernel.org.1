Return-Path: <stable+bounces-62135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF293E504
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FDB1C20C68
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC82383A5;
	Sun, 28 Jul 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mTvcPoiJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255C37147
	for <stable@vger.kernel.org>; Sun, 28 Jul 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722168579; cv=none; b=ZSEkdO5MLUBmaOUNa9x/Q7uZ8NfqE6PoMbBRKVdE2IWfgeHMLUI3f4tl+hti4EEjLV2rz7XShzty+C8OpTmP5g7TDQM/j87PuvLwDIOIOlxVYAFmoDAZoa77AiDvRJTyFMc+ZvcyuDFAsN1Kq5VB1IrjRVkmZaa7SrGRQ/sy/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722168579; c=relaxed/simple;
	bh=zYeI0RXOOsfL8/wFCi+vO2omAPFQKXW51I6FzL+Chhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diFcCTCRoXGyNxlZQlDPXPwnbvieqdsYkKce7xCHqwzZXD4hZWZ1FCIHOOt7ufkeS29wYFBn4DwiusoNoBDeGsz7D6cksb7pXjqyQXPO4SfNV/UmgVFJ6COija8lScpgcrs3hrZng1+gHrGBrRcIlKixV0cUkZQ/J/xu6WmXpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mTvcPoiJ; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722168570; x=1722427770;
	bh=KBafj0W+hLUSbIhjE/xmSCOMhfBOVKrA7riUOgwT7ls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mTvcPoiJjpuUAmp3M4gVrv34gxbpG4RBCAFKW9oPC9kLXu2EqE46sHq/UxNd+In7u
	 jHf/YZEpccCRJybdABS1lMOWgl6kgHn4/0J2mi5tPxHJQBDr7/9kYYRUsLNDSgLwwU
	 yel+iVdvE4nz+2BLPhYHX7f3IokgA2fQgajniCqokxqOEYDEdXSmfeyGHGXhU33yxM
	 cHxkwl0R58ADdXS94pklivYPpo1Jf97RJeVD1aNB70viBQeOoKZoAcLgXh9ECl2K3z
	 iGt0HOCtB5xwA65a+UhYab1P4KIu1gwqxW8vI1Bxdrbq41RDbNujpSIxcE2EJUTv0O
	 U+wMpk8YUBxYA==
Date: Sun, 28 Jul 2024 12:09:24 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org, "edmund . raile" <edmund.raile@proton.me>
Subject: [PATCH v2 2/2] ALSA: firewire-lib: prevent deadlock between process and softIRQ context
Message-ID: <20240728120900.328835-3-edmund.raile@protonmail.com>
In-Reply-To: <20240728120900.328835-1-edmund.raile@protonmail.com>
References: <20240728120900.328835-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: fc7ef45879cce1ada83da9d59a5a8ec8dd049af7
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



