Return-Path: <stable+bounces-262235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8dd8LvPbJ2oh3gIAu9opvQ
	(envelope-from <stable+bounces-262235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A671065E4D1
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262235-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262235-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A78A30C1C10
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773223F1AB6;
	Tue,  9 Jun 2026 09:07:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3752FDC57;
	Tue,  9 Jun 2026 09:07:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996070; cv=none; b=qnn6LYvLJJvXKz6TDb7/gH4I0FUuA3J/LoBx77D1AEVzcNSPlgu//7BUH04+Vk6fLXNjkGRoLdpytLfNqbmwUj2RMxuqyJq9uZHxBXw+4oFOVfHrTRT2HD3Q8JrsMmjHm8varNoLXwsMdzFE8+NX1w9vLBdv5eWiza3J79P4aDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996070; c=relaxed/simple;
	bh=4GKX7Ex9N+3GfI/w4ItbvDUbzRZT2dNXKX1T7SPfp5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFUhtSm2CSZzy56kiWueeS2gohQhaDli1TarPWBNQcVGnVLPRUEEjhTo9+cJ8O8oh6a24nhAukMDuvWrjH8C3Gx0kF6MIRYEW5dzIOIakMtC8JveidWavPFhTclrcQODzOivCdY5tavo/0Zaw4ZdM8kAd6yn7uNBoA5VohHIzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXq87Y1ydqcKvPEg--.154S2;
	Tue, 09 Jun 2026 17:07:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mdio-airoha: fix refcount leak in airoha_mdio_probe()
Date: Tue,  9 Jun 2026 09:07:29 +0000
Message-Id: <20260609090729.219120-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXq87Y1ydqcKvPEg--.154S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrKFy8WF4DXry8Cw48JFb_yoW8JFWkpr
	4jkF1ayayUJrs5Aay8Aa1rZFyFgF13ta4UGFWav39Yvwn3Gr47XrWjvFyqvFyUCFW0qrZ8
	Gr4UJ3WruF4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5o7KDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwNA2onp6StJAACsB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262235-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A671065E4D1

In airoha_mdio_probe(), after calling reset_control_deassert(),
if clk_set_rate() fails, the function returns immediately without
calling reset_control_assert().  This leaves the reset line
deasserted and causes a reference count leak on shared reset
controllers.  The devm cleanup does not assert the reset line, so
the unbalanced deassert persists.

Fix this by adding a reset_control_assert() call on the
clk_set_rate() error path, matching the existing error handling
for devm_of_mdiobus_register().

Cc: stable@vger.kernel.org
Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/mdio-airoha.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
index 52e7475121ea..030482b8318f 100644
--- a/drivers/net/mdio/mdio-airoha.c
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -245,8 +245,10 @@ static int airoha_mdio_probe(struct platform_device *pdev)
 		freq = 2500000;
 
 	ret = clk_set_rate(priv->clk, freq);
-	if (ret)
+	if (ret) {
+		reset_control_assert(priv->reset);
 		return ret;
+	}
 
 	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
 	if (ret) {
-- 
2.34.1


