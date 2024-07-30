Return-Path: <stable+bounces-64661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C79420F7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 21:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AB8285F00
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E40189904;
	Tue, 30 Jul 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AhNbvkx0"
X-Original-To: stable@vger.kernel.org
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AF3FE4
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368853; cv=none; b=QSaigJxW76ubqjM/g03BXQfSjY5LLqpemYnB+Rw/R0n74XdC2N6zzxjSw/R17WE405Uq6ghjAcNMXupIID8WB9MRQLlThKztfFsPui0/rGeruIuFmLB+r5fFXXlkJ5Aa13EzyTxRPnb3RxC69BaMoM+ERTJSlpkBBG335rIb/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368853; c=relaxed/simple;
	bh=7t2pb5/6Q/LkGZmrG+ccU7x8AQ7CkBLsXiBJgc4OsqY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3Dj4D3dPYaI/6c9TOxmZ66DTYp933VhIMiliMD5GLwiFPMXmNq9TU0nB12j3NmVcl/orvsdicCOqaftNq+oue2vAups1/bV/UEpdPNjmZ+SR3RSjQEzMetWyQtwlYpweYbovWVZuMjAIi/mlKZMAXImi5DEiHm3cZBZUya0MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AhNbvkx0; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722368843; x=1722628043;
	bh=jywWkedUWZsQUoqanntjxmq0rUgTqu6frKuhe/bbf+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AhNbvkx04DOqsY8jwUxwm2lujrXYmcnXUIjacpvp1XgPfs+uzJfNsI/DwQnt398qj
	 S0ZJCR53/3l53N+qagJqcsR3/dSwG68dMGZ0p306i3njGIn5S2zfIeluqb/EKGq/MJ
	 kZTJjQ2ys5TKE7pk1cIejDclc1JR/FdO0Nk22aRpv/zric4x6yZsGpg3xwK8vwKD41
	 oXjn5ZtXidcldl8JenO7biDQ5ALK0QMr5Q3upHY5YMH/rSeIapLZNVKD+1btlxmua6
	 9B47Bfidhh64/FFDmMqx22lKN+ejlgWG7C7P0s6sPILM7jEFnF8q7Hsx0OF9YXwO4H
	 OLAFg0lQlS4sw==
Date: Tue, 30 Jul 2024 19:47:19 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org, "edmund . raile" <edmund.raile@proton.me>
Subject: [PATCH v4 2/2] Revert "ALSA: firewire-lib: operate for period elapse event in process context"
Message-ID: <20240730194703.869145-3-edmund.raile@protonmail.com>
In-Reply-To: <20240730194703.869145-1-edmund.raile@protonmail.com>
References: <20240730194703.869145-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 6edd1feee5612c13749cb27dd9ec8f897572cfe8
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



