Return-Path: <stable+bounces-230990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP/kNfrfyWn83AUAu9opvQ
	(envelope-from <stable+bounces-230990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C4354CC7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C94A300E38D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD6391E58;
	Mon, 30 Mar 2026 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M24Nnnng"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668C391E72
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837680; cv=none; b=QGmqmCvJbJWzBkyauE86QiVEUvJFGId4WS/gc9Xa+cFAk+SLyyYAiWIIurnshRRhtq/l37V4N6RM5/sykwhok3r9kv6PJ+Fr7Dk+nGQOiU9l2uifIYG7lxnW2cMuLzJ7vdtY+O3UDw/4LJK2Ij/qFPvsQ0dqq6gsQIgVLGKFgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837680; c=relaxed/simple;
	bh=QDf16Y7vyxJr6CaPRWRkq0hvjTb2t+Mwk/4kS11e5G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swiY7vkNd6Th30mf62n2d1eM1qt/qUaS4/yH73x6W1NqZOgEwDPv+glwUBnQBdXSTvmPV8UgyrZ80Sij3VyqnBr6jB0dc60HTDInbUZYG8dij4kNrhC06PzGSCOpBHl6JVcipFBVnbXqaz7Wd3D90ISRGuo6yGUo50oiB16FLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M24Nnnng; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c66eafc1easo554284eec.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837678; x=1775442478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=M24NnnngCdbbWFRJIAXGs9rOMgU9vpwJHy6eKIx7wetLpAmVu97WfCeBGQSj0oiOwa
         VRlu2L8M/6hZRgOyWxjhFPdH3LLfi5wNZjUSJU1v7mCckHdUv+cuQyg16u8ebFKavgyv
         4zFRKIlsTE/BdWm3XtfnrtwyUo+KCj+00hAstxj6+OjrqOYUCw8cAudl3YNmqY2OgL14
         UscTACGTOijvzFvKpPkQyVbXa8PP0COB1V1Rzi9JzloLlA1EpAw5qLxNNGtTe5b5xbEj
         1ngpbViPsQRal7NbA+dJub6KUFsDN5SPM8AKCXLsEa+2gLtH4Q44In8Gm4DLh+TaXsJC
         eN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837678; x=1775442478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=A/O7Z4Q7H55QQEjko1J0dzyYdZC/4AozW3WW4+s80+uXQx86ZoqnB7STW/pId1x9IP
         z+Wsnd5AJ6BEUa8XRunTDrfDCYsaLgHuGmONTIGNpX2fnT2lrUEM9b49mr25SeAkdjGj
         LJVDY0G8trcuvobY/mT71QYHnPig8xy/SbHd7o+H+ibrQ7V4dnghV9yXhOyPPT8ZlkbR
         QCKzmlC40Zmz3e1JG1Pdw5TUqsP4wObdZepDByfKMoVu7Qcx5bcxSMJya0KLIbNXLaws
         xHbLnTcD8NHJrFlvXa/0nWzSW9Qr6kCvwmRM8fl4omCgs3JZY4Y5xOOGAosIeHiQi67d
         axOw==
X-Forwarded-Encrypted: i=1; AJvYcCUETPKWExRVB57ootAL0VWWyRvTRFg2lwhCk+pqD0gSYNEWVTb2QF4ljZYDUtkUVI7Oo30dLnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIup+oI/tzJcIFbOZW+niIckiVrzUWTzaMbgmdK0ZviNCYFRL
	OLb4DoMuZ0xyTwV75rmY43ASoEHnukMC55GVuaTfSy+wSpq5fzDance7
X-Gm-Gg: ATEYQzxkzA8b+dAcoR69P4fJUjPwu8rsa6f1gT/DbZgiKzPWaAaXm5Dv4+r469hbnL/
	ZQjNoiDYwQsa8pbZ+QO+dX4G9n+Fj9v2apzOIJfYCWLM5iyoO1Wq+HQgIDDWBhzLcYuip/sTTPI
	jLv0ztR9viZERBsQnHob4mLlev82A3cb65UIkddwMQlxKKJ88xgYt0cuxsNrSwkBT9kbxKsg8/Y
	Y5fDW5u/S1OZ1WOhw/WhPoqp/HdS4vHVg1mQ4FlYrg0sDqK1M1IYa8PvXw+wDnot52eQIwoSMUO
	AKEHUwsX0Jspm4CPaMShPJKTbeplXTBjAn+PzfAZ7coD5oMaVvUndiEgBA7KAzpAvyqR7FrekHy
	bBEUL0cOWPEMizRj1KSmDwjrCsFvM9nLthFtVuXhKwBXOGHMLOaCMlaiOoSYTsZRDMQIAHmPbDr
	rn2EUehvPNsAMhg3KMbk096xaGJq65Ud1IySAGza+S7f8aK+50A9ruubOmBoqOS0nuT5lK761kq
	7Xq63/jOfSq1hM=
X-Received: by 2002:a05:7300:3b1a:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2c5b23e4f48mr1555198eec.23.1774837677943;
        Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 19:27:48 -0700
Subject: [PATCH v2 1/4] x86/geode: fix on-stack property data usage
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
In-Reply-To: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6826
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230990-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linuxfoundation.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 813C4354CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
creates a temporary software_node_ref_args structure on the stack
when used in a runtime assignment. This results in the property
pointing to data that is invalid once the function returns.

Fix this by ensuring the GPIO reference data is not stored on stack and
using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
reference data.

Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to software properties")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
index 05189c5f7d2a..1843ae385e2d 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -28,8 +28,10 @@ static const struct software_node geode_gpio_keys_node = {
 	.properties = geode_gpio_keys_props,
 };
 
-static struct property_entry geode_restart_key_props[] = {
-	{ /* Placeholder for GPIO property */ },
+static struct software_node_ref_args geode_restart_gpio_ref;
+
+static const struct property_entry geode_restart_key_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &geode_restart_gpio_ref, 1),
 	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
 	PROPERTY_ENTRY_STRING("label", "Reset button"),
 	PROPERTY_ENTRY_U32("debounce-interval", 100),
@@ -64,8 +66,7 @@ int __init geode_create_restart_key(unsigned int pin)
 	struct platform_device *pd;
 	int err;
 
-	geode_restart_key_props[0] = PROPERTY_ENTRY_GPIO("gpios",
-							 &geode_gpiochip_node,
+	geode_restart_gpio_ref = SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
 							 pin, GPIO_ACTIVE_LOW);
 
 	err = software_node_register_node_group(geode_gpio_keys_swnodes);
@@ -99,6 +100,7 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 	const struct software_node *group[MAX_LEDS + 2] = { 0 };
 	struct software_node *swnodes;
 	struct property_entry *props;
+	struct software_node_ref_args *gpio_refs;
 	struct platform_device_info led_info = {
 		.name	= "leds-gpio",
 		.id	= PLATFORM_DEVID_NONE,
@@ -127,6 +129,12 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 		goto err_free_swnodes;
 	}
 
+	gpio_refs = kzalloc_objs(*gpio_refs, n_leds);
+	if (!gpio_refs) {
+		err = -ENOMEM;
+		goto err_free_props;
+	}
+
 	group[0] = &geode_gpio_leds_node;
 	for (i = 0; i < n_leds; i++) {
 		node_name = kasprintf(GFP_KERNEL, "%s:%d", label, i);
@@ -135,9 +143,11 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 			goto err_free_names;
 		}
 
+		gpio_refs[i] = SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
+						       leds[i].pin,
+						       GPIO_ACTIVE_LOW);
 		props[i * 3 + 0] =
-			PROPERTY_ENTRY_GPIO("gpios", &geode_gpiochip_node,
-					    leds[i].pin, GPIO_ACTIVE_LOW);
+			PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &gpio_refs[i], 1);
 		props[i * 3 + 1] =
 			PROPERTY_ENTRY_STRING("linux,default-trigger",
 					      leds[i].default_on ?
@@ -171,6 +181,8 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 err_free_names:
 	while (--i >= 0)
 		kfree(swnodes[i].name);
+	kfree(gpio_refs);
+err_free_props:
 	kfree(props);
 err_free_swnodes:
 	kfree(swnodes);

-- 
2.53.0.1018.g2bb0e51243-goog


