Return-Path: <stable+bounces-62142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D593E513
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE68E1C20BB1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FC46450;
	Sun, 28 Jul 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="m42Dw/u7"
X-Original-To: stable@vger.kernel.org
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBD383AC;
	Sun, 28 Jul 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722169863; cv=none; b=qjfBGyrIZso3b9pmEUPKNwwzeC7eoGEde4R5Z6KtIp87D23y/0C6nH1z1BKkSONFhgrj3fO8+dTliNKt8P688tef7oQcZlufpXSWY8+AR96sZA6PsIW5x0wmyZ4jl/avaHE08/Xt4McOeZnT5V4GfswAJkZ0MOrhotRPXSZ2FQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722169863; c=relaxed/simple;
	bh=DJ0+aZtEj0tlvzzOMHpKTswqeirhVvMiNDMLCWc88r4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbseVy79qj7wbU6ki7h9iaI1jnqSLmJNeIRA8QKMgX9nWHnBuGUy6B2O4gpnNblLOPOfyF2yvoKxBtllkD8RRE8+dWsWQk/DIhwWMg8VNMZybtQQ0JAIuPhH/i5ZUO4a1kobzDW0poM6ZLl2fcFd2f6ecEHclYpicP/p4zpfI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=m42Dw/u7; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722169860; x=1722429060;
	bh=Q6ujAQ2rqdbruPutUk79q/5IjtuZzJ+fzsg6fKKzv+8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m42Dw/u7Urz+pXrO7pgznBTTpCFn5Twt/QUlrUJSpHkuI44zUA+VoGiTyBGPpdVKF
	 Q4ZXYe5Prj3XWgQB3gLQLycN0c83wDoIxe7PUQLp19J2NhINBgO0FhGez6pO6x6e5T
	 GGQvcpljULF/A8z4SL0WVV77fsUB4TFICqIeV9tAJenNnFKSeP3kVCC2eYq/Q9h7eo
	 eBGkjsPvfl8gY+vkbZw3/FMhGThmzlOIsWfsMYG0dkVeyWLxUbTYK3JILW4yf+gd9K
	 d1BkCUX7gaRida4Ndff1UoqVxKaGDDhI4PebbRzegdExTvioEdLYtttbS5hhAKOhDe
	 XfLMH6us46Xhw==
Date: Sun, 28 Jul 2024 12:30:55 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, edmund.raile@protonmail.com, stable@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <20240728123041.330216-2-edmund.raile@protonmail.com>
In-Reply-To: <20240728123041.330216-1-edmund.raile@protonmail.com>
References: <20240728123041.330216-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: cac6802b9d6e3d2461bf4a2b8402fc3fc133ff58
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

prepare resolution of deadlock between process context and softIRQ
context:
restore workqueue previously used for process context:
revert commit b5b519965c4c ("ALSA: firewire-lib: obsolete workqueue
for period update")

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hze=
o4simnl@jn3eo7pe642q/
Reported-by: edmund.raile <edmund.raile@proton.me>
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 sound/firewire/amdtp-stream.c | 15 +++++++++++++++
 sound/firewire/amdtp-stream.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index d35d0a420ee0..31201d506a21 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -77,6 +77,8 @@
 // overrun. Actual device can skip more, then this module stops the packet=
 streaming.
 #define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES=095
=20
+static void pcm_period_work(struct work_struct *work);
+
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -105,6 +107,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw=
_unit *unit,
 =09s->flags =3D flags;
 =09s->context =3D ERR_PTR(-1);
 =09mutex_init(&s->mutex);
+=09INIT_WORK(&s->period_work, pcm_period_work);
 =09s->packet_index =3D 0;
=20
 =09init_waitqueue_head(&s->ready_wait);
@@ -347,6 +350,7 @@ EXPORT_SYMBOL(amdtp_stream_get_max_payload);
  */
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
+=09cancel_work_sync(&s->period_work);
 =09s->pcm_buffer_pointer =3D 0;
 =09s->pcm_period_pointer =3D 0;
 }
@@ -624,6 +628,16 @@ static void update_pcm_pointers(struct amdtp_stream *s=
,
 =09}
 }
=20
+static void pcm_period_work(struct work_struct *work)
+{
+=09struct amdtp_stream *s =3D container_of(work, struct amdtp_stream,
+=09=09=09=09=09      period_work);
+=09struct snd_pcm_substream *pcm =3D READ_ONCE(s->pcm);
+
+=09if (pcm)
+=09=09snd_pcm_period_elapsed(pcm);
+}
+
 static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *para=
ms,
 =09=09=09bool sched_irq)
 {
@@ -1910,6 +1924,7 @@ static void amdtp_stream_stop(struct amdtp_stream *s)
 =09=09return;
 =09}
=20
+=09cancel_work_sync(&s->period_work);
 =09fw_iso_context_stop(s->context);
 =09fw_iso_context_destroy(s->context);
 =09s->context =3D ERR_PTR(-1);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index a1ed2e80f91a..775db3fc4959 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -191,5 +191,6 @@ struct amdtp_stream {
=20
 =09/* For a PCM substream processing. */
 =09struct snd_pcm_substream *pcm;
+=09struct work_struct period_work;
 =09snd_pcm_uframes_t pcm_buffer_pointer;
 =09unsigned int pcm_period_pointer;
--=20
2.45.2



