Return-Path: <stable+bounces-62622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F994008E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A11C224B6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F118E77E;
	Mon, 29 Jul 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="r1l45ICv"
X-Original-To: stable@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBFE18E756;
	Mon, 29 Jul 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289353; cv=none; b=f1SG/SHGRcsj8nopj8a+v0ZxN9RbLVZU9hGrrZmqQ14PSk4Gkugrc5Zk0WDVu0+CgEcqKYFX7oUGz/n4Q64mgktJ80sXu0ufH8Hw/ok+Koo/q3Hg3YlUVKHZ8hvbWv0yAFJ7HXMK8gpwHNtVp2eXCLddQMNCR3WDoCioDMgl43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289353; c=relaxed/simple;
	bh=yRwttLVnCbGv+EaWNEn53RVQvpUMZ1hdRbs/Bciab/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+P43aq44nJXNX4N9n1sdqbukuZ2PGYZuyU8IzAHgDVxGklWwtRIidYy54eEhxm+vvR8syK+K+3sH2DF1gTqTjuxkMV57Ecc2jCpkiF+jXWc1Kr0WtjGo57BM+pKi/Rq/VD0or3j+LGMpitZ/3+dwjC433fORaVo9Ori9zetWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=r1l45ICv; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722289349; x=1722548549;
	bh=yRwttLVnCbGv+EaWNEn53RVQvpUMZ1hdRbs/Bciab/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=r1l45ICvIsF9l4qaWTKsGDN7U//lQ6Wzlfv7AI5q3jqSTj4zPz0vLfQZN8DdrnRZ2
	 FJ732EVN2J5pK19ytKvjmHDhKAnjIexFvG76U6acvLPVVAIWLz5pAS8ud6wC2BdDRw
	 C8AYnNOyrmqUEG9IJwmR9WiKjRwGNBqUsHJaQXMJylxItlKKg0cUQptYATGEBp0D+H
	 IPRqiw4BPz8OXcQJpQwbhBjuA8tIpzcLOGZR3spWZZzaUXCN/BKkYNGo8wRIMdIf+3
	 FGdUCL8gBGjSyCU6USjUBxRMhrUoHNu5RYEAuBUi3QjSJEBE57BDYYX4aZodQarO8c
	 6sVxOja8RCQqA==
Date: Mon, 29 Jul 2024 21:42:26 +0000
To: o-takashi@sakamocchi.jp, clemens@ladisch.de
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 3/3] ALSA: firewire-lib: amdtp-stream work queue inline description
Message-ID: <20240729214149.752663-4-edmund.raile@protonmail.com>
In-Reply-To: <20240729214149.752663-1-edmund.raile@protonmail.com>
References: <20240729214149.752663-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: c866ae9e4304cd5c42ed2f9839a224dbc09265d4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace prior inline description to prevent future deadlock.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hze=
o4simnl@jn3eo7pe642q/
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 sound/firewire/amdtp-stream.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a07b0452267d..7438999e0510 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1857,20 +1857,12 @@ unsigned long amdtp_domain_stream_pcm_pointer(struc=
t amdtp_domain *d,
 =09struct amdtp_stream *irq_target =3D d->irq_target;
=20
 =09if (irq_target && amdtp_stream_running(irq_target)) {
-=09=09// This function is called in software IRQ context of
-=09=09// period_work or process context.
-=09=09//
-=09=09// When the software IRQ context was scheduled by software IRQ
-=09=09// context of IT contexts, queued packets were already handled.
-=09=09// Therefore, no need to flush the queue in buffer furthermore.
-=09=09//
-=09=09// When the process context reach here, some packets will be
-=09=09// already queued in the buffer. These packets should be handled
-=09=09// immediately to keep better granularity of PCM pointer.
-=09=09//
-=09=09// Later, the process context will sometimes schedules software
-=09=09// IRQ context of the period_work. Then, no need to flush the
-=09=09// queue by the same reason as described in the above
+=09=09// use wq to prevent AB/BA deadlock competition for
+=09=09// substream lock:
+=09=09// fw_iso_context_flush_completions() acquires
+=09=09// lock by ohci_flush_iso_completions(),
+=09=09// amdtp-stream process_rx_packets() attempts to
+=09=09// acquire same lock by snd_pcm_elapsed()
 =09=09if (current_work() !=3D &s->period_work)
 =09=09=09fw_iso_context_flush_completions(irq_target->context);
 =09}
--=20
2.45.2



