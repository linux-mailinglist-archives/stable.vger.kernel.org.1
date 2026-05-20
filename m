Return-Path: <stable+bounces-251517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HXSHZYbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:37:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E0599DB0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C61433E3BC5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08D29D26E;
	Wed, 20 May 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFZJP1T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEA36F421;
	Wed, 20 May 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298187; cv=none; b=nscgp1swBxk22TLSIFu8EoAb+wd4gOiA3kd9qH9RCh8jIW/QSRwmzT8KGhh1ZqvTmaYXonv0jbvy5cBeWvY+T3pKWXjp3YgdvyhZBoZv+zqFnLo6CZPMmOBr5BWUVccr5i41EXZmncqsuW23MPwyyDGDHfNNQdz/8vfe45zEntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298187; c=relaxed/simple;
	bh=0gm7pAPk2xImb9dWXXugM14lywdaHveLZvrmUp3Zw4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCZ3aYKsHrztuR6NLFRgCZsrHezPdFC+A5EhLatzpw4vEqSKXyGHsb9a2iLKh3bHPLhE2CplW0c5Oc/Wc0yluP5Qb/Zzkr0NeStOXMg4dBN25whwEkEdKu03azN4uJCLtuaHd42SY2GOLo7FRQnrWGvyAwE4nGaU2jLdKCGCOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFZJP1T2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22B51F000E9;
	Wed, 20 May 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298186;
	bh=y3C+iyw/7jdz7TH9belvFyLgKww5qe17K/bahnY6xuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFZJP1T2x78t8OVyPIcqH/tjwG3mja0s8mjE6g536MD3EXB2VJQ+FAdD+4WXTsVQ8
	 9REZGvz5GK0gJkXDcD146oYgfS0ZC+gog94FQoVt7iZIcs3bHdoHRCAqImc3gHTb4H
	 zYG3RfsjUMHXFRY39nfV9T72eV5S10/IzArfyKuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Cheng <icheng@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 316/957] PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports
Date: Wed, 20 May 2026 18:13:19 +0200
Message-ID: <20260520162141.385658830@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251517-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wunner.de:email]
X-Rspamd-Queue-Id: EE1E0599DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Cheng <icheng@nvidia.com>

[ Upstream commit 16d021c878dca22532c984668c9e8cf4722d6a49 ]

NPEM registers LED classdevs on PCI endpoint that may be behind
hotplug-capable ports. During hot-removal, led_classdev_unregister() calls
led_set_brightness(LED_OFF) which leads to a PCI config read to a
disconnected device, which fails and returns -ENODEV (topology details in
msgid.link below):

  leds 0003:01:00.0:enclosure:ok: Setting an LED's brightness failed (-19)

The LED core already suppresses this for devices with LED_HW_PLUGGABLE set,
but NPEM never sets it. Add the flag since NPEM LEDs are on hot-pluggable
hardware by nature.

Fixes: 4e893545ef87 ("PCI/NPEM: Add Native PCIe Enclosure Management support")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
Link: https://patch.msgid.link/20260402093850.23075-1-icheng@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/npem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index 97507e0df769b..b5d012edebf35 100644
--- a/drivers/pci/npem.c
+++ b/drivers/pci/npem.c
@@ -504,7 +504,7 @@ static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
 	led->brightness_get = brightness_get;
 	led->max_brightness = 1;
 	led->default_trigger = "none";
-	led->flags = 0;
+	led->flags = LED_HW_PLUGGABLE;
 
 	ret = led_classdev_register(&npem->dev->dev, led);
 	if (ret)
-- 
2.53.0




