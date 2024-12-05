Return-Path: <stable+bounces-98766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DBF9E5156
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2366D164013
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C471D54E9;
	Thu,  5 Dec 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP477gJM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4A1D5AB5
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391009; cv=none; b=aUufFwD/j8SEUU5c2qBS24dP13VNGgxAeO03yCHuiPOFTwL6fmfqJghOvzCrwnoZnPanFqV1xJmd3wbVdndUWoHywg2Gp8nDKl86Q2540yZcdDKVJ4gUKcGlqjy9eHE2FIkM8FN+mdlwn62gRjSCUA13wfUlXJ6zmgqUTgRPZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391009; c=relaxed/simple;
	bh=B2VAzJMW6jxQdtMRAn0+xFO3730QI68d7skpVrv7U+U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MX+jix/sV7r6xgRP/fNVKxw25bJyyqziv7YQM6+O3FlmKkC1s94yAKLyduEiKnfwnKOjFt7LORwokLy6eGQ/sNe61QYCacAvPx6lQzkYn/tz1IGS/fdv7VM1fzNFuIrmp439TAJqRT5kl+tF+9FQYb6Fg/KIjABbFWH9w1e3Kgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP477gJM; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0bde5e90fso707363a12.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 01:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733391006; x=1733995806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qp2Wye+ZOuOC/pdwbNGLi9vrmSs7S7O9uX+AxCwdI4=;
        b=MP477gJMhEguttQFHQijcuzQ574ur5SexHzMSZX4GXf5EBV+Z3YuZjIxtYNo2FJfw5
         AEpe5uHRn834z/zz7AvZ0yqFujNcsBq4a6G+kTmJyOPadjyGfCb+OSsBb7nJoGz1UOEF
         hZnNRNNUce0FYP+nVI6sBOAXV8jnFMR4y/HmM5NOQIlEefZTjOvfm1qgF6jfgSxS8RnH
         bDw1SpAjBonIJIbl29s65YXHJAhlNvRtxgxXHoDvk9CXxHL0MlDpov2llGwS24T+sA75
         3+hU+jV+MZsX+MZgwPNZF8MIMc4EhJUF658lEPyCcwQ1ty93oo/SyF+cK7f6/p3wYm8R
         a5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391006; x=1733995806;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qp2Wye+ZOuOC/pdwbNGLi9vrmSs7S7O9uX+AxCwdI4=;
        b=nSs8+RLdKtvY7qIXQ8giCInIO0Pmid+BPnHOsPjyHuB3Km7hTTUJ9gZVpuClQTFVUt
         gNPOeU5SdWSGh3dwOMPafJMLck1VGsASlnfHcyvaT2m3Oli7Y5giWRTSP+hztxpLmWJo
         wtv7AOC5JjGsvp32WhO/0oXBdhmS+pcjuTrvVHgCN7jHCYMiWZX0VIKahf/Ag+GMlZZx
         u7pAQ9KTI2sGO0x2v+/px1HDlKvmWvkZzQBx6+Y97OKn7uNEhvAq0nz6UtysuXwWTEKL
         TMIRFvSm1aC4c4GVW/2F+0nRojnLIfmDzVA/wXm/xsxXXHmTszKm+JW2YZwvHBMi/NOl
         YTEg==
X-Gm-Message-State: AOJu0Yxh5zhu12D16tqPRpxnjjCgqmYVON+1R1HVLIAwdZpobyi8R13l
	m6iuIJDzbr4WdM+348DYqnHTcG5sfckwj+vRLUdJVEIybznLWRqJpHywchICCkplk/gHZut1/yX
	/XUQbHk5aYj9l3HkfZGo8kj1SHflrNwaN0iOVUAx2j6w5Tlq31VJQnkkt/j5XOGO3cYT6r01skF
	0RB7oufyZKqUP2SiI1g/aMtR2zTJ/PSY4zoxoGbA==
X-Google-Smtp-Source: AGHT+IGWwL9xHt2EqLVuVTPEbn8JDriogHwhvM4EPF3HumfJy12fKZ5+Lc6GUu8/oh+M5s74scV65JKmF2ww
X-Received: from edwb6.prod.google.com ([2002:aa7:cd06:0:b0:5d2:fa64:ea7c])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:c507:0:b0:5d1:23c8:f4cd
 with SMTP id 4fb4d7f45d1cf-5d123c8f8efmr2498666a12.11.1733391006530; Thu, 05
 Dec 2024 01:30:06 -0800 (PST)
Date: Thu,  5 Dec 2024 09:29:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205092925.922510-1-bsevens@google.com>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Fix out of bounds reads when finding
 clock sources
From: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Takashi Iwai <tiwai@suse.de>

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
index 514d18a3e07a..197a6b7d8ad6 100644
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


