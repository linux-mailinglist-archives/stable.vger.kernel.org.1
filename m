Return-Path: <stable+bounces-62618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA294002F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C2E1C212A0
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5418C324;
	Mon, 29 Jul 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dkgT5sfa"
X-Original-To: stable@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FD18C35F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287446; cv=none; b=NHsQa7tFL2FC25dBDRVAFrMzQm+Lb5n4CmDw1RGLgkIrAmVN/NWzdgUV2WAG7rCDr061vuswPDf7t+Nse2aGcea58MgvR/PnHYB88xq2ng9bW6SpT1jHFkRNO+U1x/D6CQEPvdkmDeB2ZYRtnEqQTr65FadkQ2M/eJAjo/qD1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287446; c=relaxed/simple;
	bh=yRwttLVnCbGv+EaWNEn53RVQvpUMZ1hdRbs/Bciab/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHMn4oxov7PFqEftkw6nc/dCVuvLrw5Fb4fO8NJoJDO4AGftoGTV+hoZ3atwCYM2AGR8SiFWKt100s/RRkXtcCVQsrjYBxDzCUQWt/mJnI/MTqfI2jH1ACGVqgFzczJckQSN8zv+D9Qr0q5tJuPhK4d6Ika2tHGiJQ8qXPOYnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=dkgT5sfa; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722287436; x=1722546636;
	bh=yRwttLVnCbGv+EaWNEn53RVQvpUMZ1hdRbs/Bciab/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dkgT5sfaPpLFQhTkUCkbc7slMz5ag8eXO5GLaIgZ5AIGv8CjjpGsWDSNL+aH0EApC
	 1QGjr9hyYOb41aYqjh8QiDMefcepxXwvy/Z4HAWSBFcGR0OHznW5SIp4CWleXTkv8N
	 KsVZxNBmTK+6LXfpl36JihUTncrvUaczBjyQcLhcGL1AwmMYz2lhdEYYY0yXsEMniF
	 BnEM8X8uwfSNvWNG3D5D0KivtvMHvgUBQsgbCjl5ccY8sqdwa3G6Q7zJYBh5/n+nWJ
	 Lf/I7wDnkopEbnpXicqLOZpeJJX3Zr7InaeWek90Fa9PXgy5UmNiWIhGIFi+rtx7NB
	 8ZaRF+rP1Xgkg==
Date: Mon, 29 Jul 2024 21:10:32 +0000
To: edmund.raile@protonmail.com
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH v3 3/3] ALSA: firewire-lib: amdtp-stream work queue inline description
Message-ID: <20240729211020.752203-4-edmund.raile@protonmail.com>
In-Reply-To: <20240729211020.752203-1-edmund.raile@protonmail.com>
References: <20240729211020.752203-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 7d4a0704176130d475a5d901b8ac62aabdd86dac
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



