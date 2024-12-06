Return-Path: <stable+bounces-98999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F489E6C35
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BE18887CF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206711FA254;
	Fri,  6 Dec 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9d4FEWS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091681D47A2
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480644; cv=none; b=VHLWAOHmInzqGLMeXYYcfrpCZDfRXTuhA4bzhoHxsecXzLL/gU1E1H+gCSemx0kKhpYbSq0Iwc6e24iNICUkM2Tru2/MuUkev8ciU2jNW69Octp2rLsBKgEHmAgI6kuK7L83qfjKZv15c4nAAGMlGMbsv6dnBLAT24Si8ft46dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480644; c=relaxed/simple;
	bh=Esap0BFWLjwr3lb6wD5Bi3a/tO1AxEzL+dmnkp+oVT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BA3nxYjfzi7CnBkm7MvnGFTUGyujkxHDeHtwThjLSyaXb3amcMeg8CdHnGWQxw9IlB7SG5VttAO3stFWKz1MNMD8xssg866NoHmQbCe/HS5o8sbFGnh5kvpNs1Bb41LTax/pmf+kR4AOVeeVjTU8/nLKkPMyni9wcjQaDto3hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9d4FEWS; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa6225fbc52so151923466b.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733480641; x=1734085441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ9dvy26w3ha8/zA1bxAQDeunJypghJCiCYHw1i0WAI=;
        b=P9d4FEWSlbQBOqShsjLTLKRs+bvudAoW8tObmiL4E0BFKq5MovDQlFB0TSnktkC+/Z
         UlC0Zbx+9tVAUwTKSZcUtdC1jxognOEgMvrb2akR5glyaqFAl/9K2qITA72TOeftwFba
         XNtlPOEP0EZ2FXW5slifXDkdPGhZ6kwZqsq8MHNKjBLuOUt9hF5B90c7P38fKUpiOruM
         vR+NZBjaR+B4MHnwRvrdvXPMLV7LGp0Mrj86qCYRYelubEY/ig5JN2lmP5n3yMfqUsQd
         ph/o3gtSGpy4JToisq3WCMqc/rwYspqQBoysdoDEzW+lmmEeRH6tcDQuKJbE1Zngqjwx
         ef1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733480641; x=1734085441;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ9dvy26w3ha8/zA1bxAQDeunJypghJCiCYHw1i0WAI=;
        b=Jw64QzFvmOKa2F9ynr/8c4yxkhfVafRaZOKqkv9d0PFrZ4BG6kRpn4dFSYZTN4kocg
         xGJNeUzRJAzcmQVR1MZbEQjnkPeYnW4q2FKrWCYYPAzSyZRkc5qBpT5L8iU66mG0GIFS
         Nwvmyz2vCTfKZ21hNBMlObZYJY/BIPtU7kZLgnsqArM6TUr7AA7FmnciXwpSA6OcwAV2
         1qGJ7nlfQnOxdIFl4KcpQqa/zS+oF98AtEywz8+uPvvfosZ9UpitlXpRcRCIS4jUX5Me
         XAcVZmfdOzx17Hc2z5EDL82vl6lThZxtXcjD1aT0KDk496wWKY5oLofcnkzci9S28T3b
         w9Xg==
X-Gm-Message-State: AOJu0YzG3sYhOoh4IgmJ9nlbg2UFHKm7VRFVfL9sQkjUwrSDrhGeVhYc
	+nReLIZnlQAxJUD+/nTGy5/JsILKpkyYOa1mJNY3r0Xn5cK8EdlqfAFi52ObFv/Q0TnMQrHEYL9
	hyVhWsVXI4PHE3S7m7XQoToFuhMFliAEaIoi5OV4P1h3tT32RvZ6LicVjN0Tw4BVCSdeVkj6Mmz
	F1tMkmtaXvIvyf66vgJPr4hvJBvKM9ygiZCWSCNA==
X-Google-Smtp-Source: AGHT+IGuxIfveKPgaUNlNfjIdXnxvkH3PZFFGbsVkK+OSCM4Dd5cZPtoYepjlqtU3r+LOFwmbinYLcq+38vC
X-Received: from edqd19.prod.google.com ([2002:a50:fb13:0:b0:5d1:ad08:19da])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:32d2:b0:aa6:3f03:7ab4
 with SMTP id a640c23a62f3a-aa63f038759mr121519866b.46.1733480641383; Fri, 06
 Dec 2024 02:24:01 -0800 (PST)
Date: Fri,  6 Dec 2024 10:23:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206102357.1259610-1-bsevens@google.com>
Subject: [PATCH 5.10.y v3] ALSA: usb-audio: Fix out of bounds reads when
 finding clock sources
From: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Takashi Iwai <tiwai@suse.de>

Upstream commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6

The current USB-audio driver code doesn't check bLength of each
descriptor at traversing for clock descriptors.  That is, when a
device provides a bogus descriptor with a shorter bLength, the driver
might hit out-of-bounds reads.

For addressing it, this patch adds sanity checks to the validator
functions for the clock descriptor traversal.  When the descriptor
length is shorter than expected, it's skipped in the loop.

For the clock source and clock multiplier descriptors, we can just
check bLength against the sizeof() of each descriptor type.
OTOH, the clock selector descriptor of UAC2 and UAC3 has an array
of bNrInPins elements and two more fields at its tail, hence those
have to be checked in addition to the sizeof() check.

This patch ports the upstream commit a3dd4d63eeb4 ("ALSA: usb-audio: Fix
out of bounds reads when finding clock sources") to trees that do not
include the refactoring commit 9ec730052fa2 ("ALSA: usb-audio:
Refactoring UAC2/3 clock setup code"). That commit provides union
objects for pointing both UAC2 and UAC3 objects and unifies the clock
source, selector and multiplier helper functions. This means we need to
perform the check in each version specific helper function, but on the
other hand do not need to do version specific union dereferencing in the
macros and helper functions.

Reported-by: Beno=C3=AEt Sevens <bsevens@google.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/20241121140613.3651-1-bsevens@google.com
Link: https://patch.msgid.link/20241125144629.20757-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6)
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
Changes in v3:
- add patch changelog=20

Changes in v2:
- provide better changelog description of how the upstream patch is
  backported

 sound/usb/clock.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 3d1c0ec11753..58902275c815 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -21,6 +21,10 @@
 #include "clock.h"
 #include "quirks.h"
=20
+/* check whether the descriptor bLength has the minimal length */
+#define DESC_LENGTH_CHECK(p) \
+	 (p->bLength >=3D sizeof(*p))
+
 static void *find_uac_clock_desc(struct usb_host_interface *iface, int id,
 				 bool (*validator)(void *, int), u8 type)
 {
@@ -38,36 +42,60 @@ static void *find_uac_clock_desc(struct usb_host_interf=
ace *iface, int id,
 static bool validate_clock_source_v2(void *p, int id)
 {
 	struct uac_clock_source_descriptor *cs =3D p;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
 	return cs->bClockID =3D=3D id;
 }
=20
 static bool validate_clock_source_v3(void *p, int id)
 {
 	struct uac3_clock_source_descriptor *cs =3D p;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
 	return cs->bClockID =3D=3D id;
 }
=20
 static bool validate_clock_selector_v2(void *p, int id)
 {
 	struct uac_clock_selector_descriptor *cs =3D p;
-	return cs->bClockID =3D=3D id;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
+	if (cs->bClockID !=3D id)
+		return false;
+	/* additional length check for baCSourceID array (in bNrInPins size)
+	 * and two more fields (which sizes depend on the protocol)
+	 */
+	return cs->bLength >=3D sizeof(*cs) + cs->bNrInPins +
+		1 /* bmControls */ + 1 /* iClockSelector */;
 }
=20
 static bool validate_clock_selector_v3(void *p, int id)
 {
 	struct uac3_clock_selector_descriptor *cs =3D p;
-	return cs->bClockID =3D=3D id;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
+	if (cs->bClockID !=3D id)
+		return false;
+	/* additional length check for baCSourceID array (in bNrInPins size)
+	 * and two more fields (which sizes depend on the protocol)
+	 */
+	return cs->bLength >=3D sizeof(*cs) + cs->bNrInPins +
+		4 /* bmControls */ + 2 /* wCSelectorDescrStr */;
 }
=20
 static bool validate_clock_multiplier_v2(void *p, int id)
 {
 	struct uac_clock_multiplier_descriptor *cs =3D p;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
 	return cs->bClockID =3D=3D id;
 }
=20
 static bool validate_clock_multiplier_v3(void *p, int id)
 {
 	struct uac3_clock_multiplier_descriptor *cs =3D p;
+	if (!DESC_LENGTH_CHECK(cs))
+		return false;
 	return cs->bClockID =3D=3D id;
 }
=20
--=20
2.47.0.338.g60cca15819-goog


