Return-Path: <stable+bounces-231355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIWZN9mAy2kKIgYAu9opvQ
	(envelope-from <stable+bounces-231355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47674365C84
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09C230158A8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3B27F754;
	Tue, 31 Mar 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C04IhxkF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WakVopsj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779D3CD8A1;
	Tue, 31 Mar 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944124; cv=none; b=OymJhJN9k7RzkEyyf2zEe33LLQGhERMztDiSYV7xiPafTZ3pHX5WR+0TsAQLOIxZYLz8JUTQQIc1gqJVavR4CM7RJZJc9bz1RS1hD8/gC/JVtRr7FWJo/YNJfE6oN+CSmbX190i0zVIkPOzAIFFc2kXob0noKEl0jo8S2pWdTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944124; c=relaxed/simple;
	bh=Rh9qqJ7ldeE8o9MB/KWzImv9FoRvolm44lPA9vZIulA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dS8T8QGOeJZcsYZ8sU3VyGuinQXl1EZbL1eAMUDGWfOTZlkgnWiwoOlBKAbSwGRzKxh8dlB5I69YVg1c735k0qsV5+K9a6Od/7b+MURmUhwDKlDBhkzZTdFR941UPjoq4o1ogErVfpEy8EcifljEZp2IFbEmT8Kb7rXGxpS6gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C04IhxkF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WakVopsj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 31 Mar 2026 08:01:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774944121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTibQmOVjMVXE7A0Z8v115jNcSm0fDn88/hA8crwr8s=;
	b=C04IhxkFMk+XGcmXz4blNI9fPqIraOPouACIaRKbyMypAsLuiFyXKFJQyjFY8XSsSMcaSw
	f0grLErcNV4rkQSIhjut1qBAtcafwK8iS952COaG0pARWfJ8kOdPRq76dBu4OgoUBmkjJr
	JkJIssynl1iOCkRgSHsP52oGBZvi6xEInylCqQ1AZ/mUBHpS3JTrP/miSBgAh486bZ4K6u
	PGGsu/wFgEyYAQxlpSEYfH2xBGUHMAxaBC6gJ9bkkKkstbK5Qpck6VXNZUoeDA267rD26J
	dlUyh5nlME8anlHDiCCz2IF93yg/8g6sCoIrv7QHWvx1ksJP3C9kxhuV8DKx8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774944121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTibQmOVjMVXE7A0Z8v115jNcSm0fDn88/hA8crwr8s=;
	b=WakVopsjSJTbMdjQkt4irrN/p+LJsE6wU2nMejVI2noEvGhQ8eRBHY3Yam+tHi2HHWMIQ5
	qv3jJmRWN7Th0gCA==
From: "tip-bot2 for Dmitry Torokhov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/geode: Fix on-stack property data
 use-after-return bug
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
References: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177494411962.1647592.2115768580335609111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231355-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 47674365C84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b981e9e94c687b7b19ae8820963f005b842cb2f2
Gitweb:        https://git.kernel.org/tip/b981e9e94c687b7b19ae8820963f005b842=
cb2f2
Author:        Dmitry Torokhov <dmitry.torokhov@gmail.com>
AuthorDate:    Sun, 29 Mar 2026 19:27:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Mar 2026 09:55:26 +02:00

x86/platform/geode: Fix on-stack property data use-after-return bug

The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
creates a temporary software_node_ref_args structure on the stack
when used in a runtime assignment. This results in the property
pointing to data that is invalid once the function returns.

Fix this by ensuring the GPIO reference data is not stored on stack and
using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
reference data.

Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to sof=
tware properties")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260329-property-gpio-fix-v2-1-3cca5ba136d8@g=
mail.com
---
 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode=
/geode-common.c
index 05189c5..1843ae3 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -28,8 +28,10 @@ static const struct software_node geode_gpio_keys_node =3D=
 {
 	.properties =3D geode_gpio_keys_props,
 };
=20
-static struct property_entry geode_restart_key_props[] =3D {
-	{ /* Placeholder for GPIO property */ },
+static struct software_node_ref_args geode_restart_gpio_ref;
+
+static const struct property_entry geode_restart_key_props[] =3D {
+	PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &geode_restart_gpio_ref, 1),
 	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
 	PROPERTY_ENTRY_STRING("label", "Reset button"),
 	PROPERTY_ENTRY_U32("debounce-interval", 100),
@@ -64,8 +66,7 @@ int __init geode_create_restart_key(unsigned int pin)
 	struct platform_device *pd;
 	int err;
=20
-	geode_restart_key_props[0] =3D PROPERTY_ENTRY_GPIO("gpios",
-							 &geode_gpiochip_node,
+	geode_restart_gpio_ref =3D SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
 							 pin, GPIO_ACTIVE_LOW);
=20
 	err =3D software_node_register_node_group(geode_gpio_keys_swnodes);
@@ -99,6 +100,7 @@ int __init geode_create_leds(const char *label, const stru=
ct geode_led *leds,
 	const struct software_node *group[MAX_LEDS + 2] =3D { 0 };
 	struct software_node *swnodes;
 	struct property_entry *props;
+	struct software_node_ref_args *gpio_refs;
 	struct platform_device_info led_info =3D {
 		.name	=3D "leds-gpio",
 		.id	=3D PLATFORM_DEVID_NONE,
@@ -127,6 +129,12 @@ int __init geode_create_leds(const char *label, const st=
ruct geode_led *leds,
 		goto err_free_swnodes;
 	}
=20
+	gpio_refs =3D kzalloc_objs(*gpio_refs, n_leds);
+	if (!gpio_refs) {
+		err =3D -ENOMEM;
+		goto err_free_props;
+	}
+
 	group[0] =3D &geode_gpio_leds_node;
 	for (i =3D 0; i < n_leds; i++) {
 		node_name =3D kasprintf(GFP_KERNEL, "%s:%d", label, i);
@@ -135,9 +143,11 @@ int __init geode_create_leds(const char *label, const st=
ruct geode_led *leds,
 			goto err_free_names;
 		}
=20
+		gpio_refs[i] =3D SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
+						       leds[i].pin,
+						       GPIO_ACTIVE_LOW);
 		props[i * 3 + 0] =3D
-			PROPERTY_ENTRY_GPIO("gpios", &geode_gpiochip_node,
-					    leds[i].pin, GPIO_ACTIVE_LOW);
+			PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &gpio_refs[i], 1);
 		props[i * 3 + 1] =3D
 			PROPERTY_ENTRY_STRING("linux,default-trigger",
 					      leds[i].default_on ?
@@ -171,6 +181,8 @@ err_unregister_group:
 err_free_names:
 	while (--i >=3D 0)
 		kfree(swnodes[i].name);
+	kfree(gpio_refs);
+err_free_props:
 	kfree(props);
 err_free_swnodes:
 	kfree(swnodes);

