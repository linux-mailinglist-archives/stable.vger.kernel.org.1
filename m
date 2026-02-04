Return-Path: <stable+bounces-213467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHn3EPdbg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE806E75B5
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3A46300F167
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3D274B39;
	Wed,  4 Feb 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/Q5IPfJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474E221F17;
	Wed,  4 Feb 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216436; cv=none; b=E4RqVF9cA0aaeFUXRjKTGKlz3xJz0zqD6NAnh8FDYT0wAglWLs7JkQOgw9edJKME2JYI+BPlwXtuEJL8ZfDwnHlRcKuH7eRWUl/dX3w0mETV7SGx4Yo/KPwldZZDwNfSJmzTl2eUv1U6fOzCwEK0DGauUedgnOEJAMSN8hosHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216436; c=relaxed/simple;
	bh=X8V+J6/68T6cMpFBVMLbGN6Zz6L39+dxPf1FoMDPXDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCI6Hgz1jaXlHjZSFa30U9nu2e0BCqsrPyYrmYGZ9pvlDRFICZlp0tzHkNtGxfxgUQDPrAYFOfbYe7QdTLfGBK83GaLokVaNiCT1o2isjer2xKSpX/EwBvk09RZTlw7AnKoypGF08Z9Kw7GAZxEojbN4wxSBOykP7DLkBQuXmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/Q5IPfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A286C4CEF7;
	Wed,  4 Feb 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216436;
	bh=X8V+J6/68T6cMpFBVMLbGN6Zz6L39+dxPf1FoMDPXDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/Q5IPfJI1k/iiMLX4o68AQVIrQXDGOIOuqds97SbKTsR1nsHLgdm6IDERIg8XfCL
	 RL5NbYvth1J4E4XAPz61oK7vPY6xWHIgVNmh0GUi3q1Az/y+SB3M1sG9r76fCeyHV0
	 4sk6kOqF5mmRjOILKQ9LGYeEEfMa3ttTjYzkDrU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 5.10 087/161] leds: led-class: Only Add LED to leds_list when it is fully ready
Date: Wed,  4 Feb 2026 15:39:10 +0100
Message-ID: <20260204143854.878962379@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213467-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: CE806E75B5
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

commit d1883cefd31752f0504b94c3bcfa1f6d511d6e87 upstream.

Before this change the LED was added to leds_list before led_init_core()
gets called adding it the list before led_classdev.set_brightness_work gets
initialized.

This leaves a window where led_trigger_register() of a LED's default
trigger will call led_trigger_set() which calls led_set_brightness()
which in turn will end up queueing the *uninitialized*
led_classdev.set_brightness_work.

This race gets hit by the lenovo-thinkpad-t14s EC driver which registers
2 LEDs with a default trigger provided by snd_ctl_led.ko in quick
succession. The first led_classdev_register() causes an async modprobe of
snd_ctl_led to run and that async modprobe manages to exactly hit
the window where the second LED is on the leds_list without led_init_core()
being called for it, resulting in:

 ------------[ cut here ]------------
 WARNING: CPU: 11 PID: 5608 at kernel/workqueue.c:4234 __flush_work+0x344/0x390
 Hardware name: LENOVO 21N2S01F0B/21N2S01F0B, BIOS N42ET93W (2.23 ) 09/01/2025
 ...
 Call trace:
  __flush_work+0x344/0x390 (P)
  flush_work+0x2c/0x50
  led_trigger_set+0x1c8/0x340
  led_trigger_register+0x17c/0x1c0
  led_trigger_register_simple+0x84/0xe8
  snd_ctl_led_init+0x40/0xf88 [snd_ctl_led]
  do_one_initcall+0x5c/0x318
  do_init_module+0x9c/0x2b8
  load_module+0x7e0/0x998

Close the race window by moving the adding of the LED to leds_list to
after the led_init_core() call.

Cc: stable@vger.kernel.org
Fixes: d23a22a74fde ("leds: delay led_set_brightness if stopping soft-blink")
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Link: https://patch.msgid.link/20251211163727.366441-1-johannes.goede@oss.qualcomm.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/led-class.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -408,11 +408,6 @@ int led_classdev_register_ext(struct dev
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
 	led_cdev->brightness_hw_changed = -1;
 #endif
-	/* add to the list of leds */
-	down_write(&leds_list_lock);
-	list_add_tail(&led_cdev->node, &leds_list);
-	up_write(&leds_list_lock);
-
 	if (!led_cdev->max_brightness)
 		led_cdev->max_brightness = LED_FULL;
 
@@ -420,6 +415,11 @@ int led_classdev_register_ext(struct dev
 
 	led_init_core(led_cdev);
 
+	/* add to the list of leds */
+	down_write(&leds_list_lock);
+	list_add_tail(&led_cdev->node, &leds_list);
+	up_write(&leds_list_lock);
+
 #ifdef CONFIG_LEDS_TRIGGERS
 	led_trigger_set_default(led_cdev);
 #endif



