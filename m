Return-Path: <stable+bounces-62134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D693E503
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DA281AEF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB438396;
	Sun, 28 Jul 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZYl6qrrx"
X-Original-To: stable@vger.kernel.org
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39460383A5
	for <stable@vger.kernel.org>; Sun, 28 Jul 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722168571; cv=none; b=al83q12JF8TK8ARLJcDFj1vwx/0X8zWhwsVPsFvSKcb4Cvp/Quu3BzwjDJWVkDlx2UwTF12bOunph2wf62s3BP8/LCO1nR8DTsU/qJd9b/fJ6p7VBUdrpdLiLaeIXv8HAuPOKsmohMS6VooZT2EiPGNqm1B1jdp2Vk34ck5nTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722168571; c=relaxed/simple;
	bh=DJ0+aZtEj0tlvzzOMHpKTswqeirhVvMiNDMLCWc88r4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7LLA16B5kXLulF0b6Up+zBRgqPmaTGzZAvNyywHiR8eBAimL7kB3sc3IRTSKk/hkc0+PkB/0+t07wqb9+0rTOIt6YJOj27wKdt77soOiR4CEWUv18W6dWw79OM00zXf2sZSYcfBXyw0BCNWZd3Fe4Y9n47UBpite6ww9GuMmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ZYl6qrrx; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722168563; x=1722427763;
	bh=Q6ujAQ2rqdbruPutUk79q/5IjtuZzJ+fzsg6fKKzv+8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZYl6qrrxFWjz3NlH4vVvapue0mjTDDE3MC5T0d8nlXfKSx+kP9WWe3TRUy+XH5cBf
	 pBVjgO+tafrruK33U2nksEupXw/oEA8gPBc0rQb99aSLx5v1a1Aq5Aj6YqeD2E2h0i
	 o4cpzFYjSUWYrtOvIhwQSAn3FI5zeUAhqIyGB7lUzcLBwYt9FZefJZ6mBvmE6AUMHe
	 1Y4+F9olU4KqEgygZx115Ln6APUg848tAL/G//v20/Ru/arqCsH+TjvB3bqrmi9OmA
	 O8R6ExrBwQbfo5cG9lE2UVnFpB/mV5cKXMGMyBF/dyOmDBFR9VKzsOpVo7XrN3sxKT
	 Oo/AYmu3TBocA==
Date: Sun, 28 Jul 2024 12:09:18 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org, "edmund . raile" <edmund.raile@proton.me>
Subject: [PATCH v2 1/2] ALSA: firewire-lib: restore workqueue for process context
Message-ID: <20240728120900.328835-2-edmund.raile@protonmail.com>
In-Reply-To: <20240728120900.328835-1-edmund.raile@protonmail.com>
References: <20240728120900.328835-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: ea415c7a8553e6b9642b561814b0b0f6a8a8ac8a
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



