Return-Path: <stable+bounces-138195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4BAA16F2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04824A61C7
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE7251793;
	Tue, 29 Apr 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kVp9vrwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BB1917E3;
	Tue, 29 Apr 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948471; cv=none; b=raHTTsounAboYr+o3dswhdAtT5uRRSIqiazaxMj3wUY7lJYfsWJk8xcGK2fjyookTJU2k3q1zIN7093ih41yjhMce5bzRveG/ej+RxthbiizxkiVM5ymVuAZqErK31E4WwYuSW7fQLp85p2A3N1wX1iVwfQVR0fPTEFrLM8rHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948471; c=relaxed/simple;
	bh=JmGLY825Cs6ruOeo0S75gTuethjCAngzeimSI4k2dFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWEWye024MsjgAzLVs2+GNhBAgRu9Uj4n0u5MU0dPZ6/53uMneLrzDrPQ25kQDwEC8fhgi8EfHRz0jh9YkLAoDY4OK/blIKyZUQAAhDYM5fIZDim6syweIGSa43HAAa7d20HXvr2GEUcP1aFfi5H67IUsFGzqt3ylH3lxcxlLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kVp9vrwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5960EC4CEE3;
	Tue, 29 Apr 2025 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948470;
	bh=JmGLY825Cs6ruOeo0S75gTuethjCAngzeimSI4k2dFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVp9vrwSVaYLjntnv/qnP8qj6VbbI5EIMwgwWEnLn7xV1FI6fvdqvxNPu4bEtUMwT
	 nD/GNcEHZ/XcBfC4rPisGKJYae9zEbExgMpA+CYczviM9NLo7AQ1T7eO9IpgiXQRrs
	 Ac/hKewiqAU98/sQo4ybrPB9+wov0D434Ik2mw5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>,
	Paul Dino Jones <paul@spacefreak18.xyz>,
	=?UTF-8?q?Crist=C3=B3ferson=20Bueno?= <cbueno81@gmail.com>,
	Pablo Cisneros <patchkez@protonmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/373] HID: pidff: Do not send effect envelope if its empty
Date: Tue, 29 Apr 2025 18:38:15 +0200
Message-ID: <20250429161123.882663401@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 8876fc1884f5b39550c8387ff3176396c988541d ]

Envelope struct is always initialized, but the envelope itself is
optional as described in USB PID Device class definition 1.0.

5.1.1.1 Type Specific Block Offsets
...
4) Effects that do not use Condition Blocks use 1 Parameter Block and
an *optional* Envelope Block.

Sending out "empty" envelope breaks force feedback on some devices with
games that use SINE effect + offset to emulate constant force effect, as
well as generally breaking Constant/Periodic effects. One of the affected
brands is Moza Racing.

This change prevents the envelope from being sent if it contains all
0 values while keeping the old behavior of only sending it, if it differs
from the old one.

Changes in v6:
- Simplify the checks to make them clearer
- Fix possible null pointer dereference while calling
  pidff_needs_set_envelope

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Michał Kopeć <michal@nozomi.space>
Reviewed-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Cristóferson Bueno <cbueno81@gmail.com>
Tested-by: Pablo Cisneros <patchkez@protonmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 42 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 5fe4422bb5bad..a01c1b2ab2f4c 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -262,10 +262,22 @@ static void pidff_set_envelope_report(struct pidff_device *pidff,
 static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
 {
-	return envelope->attack_level != old->attack_level ||
-	       envelope->fade_level != old->fade_level ||
+	bool needs_new_envelope;
+	needs_new_envelope = envelope->attack_level  != 0 ||
+			     envelope->fade_level    != 0 ||
+			     envelope->attack_length != 0 ||
+			     envelope->fade_length   != 0;
+
+	if (!needs_new_envelope)
+		return false;
+
+	if (!old)
+		return needs_new_envelope;
+
+	return envelope->attack_level  != old->attack_level  ||
+	       envelope->fade_level    != old->fade_level    ||
 	       envelope->attack_length != old->attack_length ||
-	       envelope->fade_length != old->fade_length;
+	       envelope->fade_length   != old->fade_length;
 }
 
 /*
@@ -580,11 +592,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_constant(effect, old))
 			pidff_set_constant_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.constant.envelope,
-					&old->u.constant.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.constant.envelope);
+		if (pidff_needs_set_envelope(&effect->u.constant.envelope,
+					old ? &old->u.constant.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.constant.envelope);
 		break;
 
 	case FF_PERIODIC:
@@ -619,11 +629,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_periodic(effect, old))
 			pidff_set_periodic_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.periodic.envelope,
-					&old->u.periodic.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.periodic.envelope);
+		if (pidff_needs_set_envelope(&effect->u.periodic.envelope,
+					old ? &old->u.periodic.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.periodic.envelope);
 		break;
 
 	case FF_RAMP:
@@ -637,11 +645,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_ramp(effect, old))
 			pidff_set_ramp_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.ramp.envelope,
-					&old->u.ramp.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.ramp.envelope);
+		if (pidff_needs_set_envelope(&effect->u.ramp.envelope,
+					old ? &old->u.ramp.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.ramp.envelope);
 		break;
 
 	case FF_SPRING:
-- 
2.39.5




