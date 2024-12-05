Return-Path: <stable+bounces-98803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15639E5631
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB512844A1
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F717BD6;
	Thu,  5 Dec 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMabNc1i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2816417BA0
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404085; cv=none; b=Rhh688scwL9bQK1MJQBkwJSgIs1UsDdC7hMFR5EeYQn+xyEEM95J7rfraDy1vkU1t4Wp4lZiviLgIcevebzgoLSF/0SxZ0Ku5Ot5WZOUpCgJon8LP3xLvCIID57/fVoS4H4mjecmx2RKMRfm1tPUtL4lSv8thTNHXYCG1ShJLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404085; c=relaxed/simple;
	bh=1F+fAV7OUTyUnpVJVq3bM96jf4mZZ61lIRTq+ohl+Kg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T6+07aMyy7gvsZEiZkMvzjM+5HPYS9j4g2L6lR9N5UGR9UI+FRdxB81+UaV5IzDtnjogplnouj9Pjf/kk0HGLFciD42Ijgh2k6NYhoKurdK2DZmURiKBxfNPsahgtYWIo4FEj5h33sUEyQyx06Gtr9g4wxyt3Zh+K7mSGWXBq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMabNc1i; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d34c8fbca7so198399a12.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733404082; x=1734008882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCq0c9M1CQwj31IIaLCTjD0TbcdtQtiywqq2Ye41BD0=;
        b=HMabNc1il7DheDh08bItSDH0Bk/T0qhO6olNHA6k2scnEocjtBP0nmRfZLTpJwSBPP
         dHfVN96VDRSY/WQjvuydu54mjIgM6Vy2jifivHP7/Mxpy6QkcRSoMI8DjTBdB1iSjHN1
         loccWFV07KhzU22q9emZOaoiwbGsFtmdt/8qRdw5oBISBi/2IN+Kiv4WcyNeaep2Z4gr
         Mxy4DfHntcU5WRwHw9MjwB23ngd8Tys7NMka3/pFfoIvQUTIQq5nIqi68OziKCqfBGR7
         GqxucgGlsAtAjrpxmnFclS2ZXGamznNRepn/cTpjmsoyZEbCvrj0Tfmpm/7uJWNZszBW
         AUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733404082; x=1734008882;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCq0c9M1CQwj31IIaLCTjD0TbcdtQtiywqq2Ye41BD0=;
        b=QgPdmf28I68F2nvOLjIVTkFmiMyaAQKbUePtOtKXsD+b7sR5nOvLCceq3J+bhv5Dv3
         7i4EPo/LXHjkeroe+GycrQSS8d83mMQFmRMowLPKE0cm5IG1e18OXkTvSnJgIyl7ISLa
         yjuffv3dQ0TeOdJywi/6xUQtciSYLTrKCyFlJpz9UzIkFRJINnGbTDqER75alSsQn760
         +XQC9qlBX1w4yoBVYYNbRoNNaUftEGrEc6ikkh0pfzkqH+sI/pHTIldz10OWYx2vvIVd
         RluGa1F4Z4MkfqRWTnrDfr4xwDNIvJTMOsLOmoLvwKgtLT0p/D0iNiNkGz7e9Fhn6qom
         LakQ==
X-Gm-Message-State: AOJu0Yx2Z5JzjSTXtEMc1WDx3stcl2hO4PS59DGaLEIRoeBiWv7l/UWZ
	ekqFpF6pu/n3DJ9s/CmYStOR4WseWjk1wUbuBmjO972ZgAtdoliK3yibc8ve+HzVOJd61FWyDK0
	/PqgU8fSGYCeD5ufJz/fq7LgVr55Kd4p2yvJ3Zd3yFpWWK5UG1ZtX4ni+t4J5jHvfur20drrM1o
	YLQlxq+zoxXbQeiNXB2K1LqLJYdbf8ygzCf2hS6Q==
X-Google-Smtp-Source: AGHT+IF+VaWWQiPWbO+PI9iZyMOUg0+lNQi0oBx+R84Mxnfx66qm55k2qawGsotQpfaTc7VaJYV/abny6e2A
X-Received: from edb11.prod.google.com ([2002:a05:6402:238b:b0:5d0:bdbf:3a3b])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3228:b0:5d0:d087:6d5b
 with SMTP id 4fb4d7f45d1cf-5d113cc7ad3mr8248925a12.18.1733404082437; Thu, 05
 Dec 2024 05:08:02 -0800 (PST)
Date: Thu,  5 Dec 2024 13:07:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205130758.981732-1-bsevens@google.com>
Subject: [PATCH v2 5.10.y] ALSA: usb-audio: Fix out of bounds reads when
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

This patch ports the upstream commit a3dd4d63eeb4 to trees that do not
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


