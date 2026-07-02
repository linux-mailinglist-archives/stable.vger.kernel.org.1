Return-Path: <stable+bounces-270920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ha2IC6qgRmoEagsAu9opvQ
	(envelope-from <stable+bounces-270920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:32:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60D6FB6C0
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WpWZCSb9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270920-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B89A3229852
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07034751D;
	Thu,  2 Jul 2026 16:36:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746F36215B;
	Thu,  2 Jul 2026 16:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010198; cv=none; b=vFs0aMDbwD/yj/VOrwKNJOk+MCOq6gjEhfPC5cobMnRNdKcEmwrZSsRUVAxvCrkI0wcU5Dx5Kwb/w1LzneEn1E7kWDts/WvjOGnO8k1TDuAA/lI6Bivaiu9iCYCNG97aNYgSsaN4G/mw80OhFWdF6MqJmzJ2GSC4Ac276YPp9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010198; c=relaxed/simple;
	bh=A60A2sBi7HHfgEoo9mV3PTh5tUmmAGAk9ESxC/kYCks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDxNg64cXIuSf5//qZ5Uw8WLZaJusuQqPyGs4PGwltNFT6y71JRTXY3GRIN3xkzp+JdPmn2y+nL6BonTy1xpwm/tpE2MBHFK7uUOwcMnxQsf7ZNSykenzDiSYrbR1OUGwLvH5rL0FyFzabRvUqYgN5OGfGs/vF7+/on27YmY3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpWZCSb9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AAF1F000E9;
	Thu,  2 Jul 2026 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010195;
	bh=CyzrZLuzAY86qV1iIb3aRHMz8KTO9KtqvG1C0JZEuVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpWZCSb9XcID3MK1MujGEh1osDpWOx34MeLwI3LKfDNezGn5Wji5OwJlFxLsrRu9M
	 BK3QSsDRMP9ay+jqyOYra42r53RiXu6PC/p+qk3OQu/Ot++dwai/4cbPcTejykCh4o
	 h6donAfVKmUNmjXQrnHjdHjaFFVhX1qL3QNImVcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 005/204] gpiolib: Extract gpiochip_choose_fwnode() for wider use
Date: Thu,  2 Jul 2026 18:17:42 +0200
Message-ID: <20260702155118.781677897@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270920-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andriy.shevchenko@linux.intel.com,m:linus.walleij@linaro.org,m:mathieu.dubois-briand@bootlin.com,m:bartosz.golaszewski@linaro.org,m:quentin.schulz@cherry.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C60D6FB6C0

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 375790f18396b2ba706e031b150c58cd37b45a11 ]

Extract gpiochip_choose_fwnode() for the future use in another function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Link: https://lore.kernel.org/r/20250213195621.3133406-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 16fdabe143fc ("gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5c8cd816569634..d48a57b899f79c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -883,6 +883,21 @@ void *gpiochip_get_data(struct gpio_chip *gc)
 }
 EXPORT_SYMBOL_GPL(gpiochip_get_data);
 
+/*
+ * If the calling driver provides the specific firmware node,
+ * use it. Otherwise use the one from the parent device, if any.
+ */
+static struct fwnode_handle *gpiochip_choose_fwnode(struct gpio_chip *gc)
+{
+	if (gc->fwnode)
+		return gc->fwnode;
+
+	if (gc->parent)
+		return dev_fwnode(gc->parent);
+
+	return NULL;
+}
+
 int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
 {
 	u32 ngpios = gc->ngpio;
@@ -942,14 +957,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
 
-	/*
-	 * If the calling driver did not initialize firmware node,
-	 * do it here using the parent device, if any.
-	 */
-	if (gc->fwnode)
-		device_set_node(&gdev->dev, gc->fwnode);
-	else if (gc->parent)
-		device_set_node(&gdev->dev, dev_fwnode(gc->parent));
+	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
-- 
2.53.0




