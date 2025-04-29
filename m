Return-Path: <stable+bounces-137983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95837AA1637
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F77986EE4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D522459E1;
	Tue, 29 Apr 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iEqLUWJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B478F58;
	Tue, 29 Apr 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947733; cv=none; b=SE0mGrZ854KYWYb+y0Yd35+mj77jAZF+yD7aBntPcHrFfM5AbC0vz92vwsUC4JlBy/2B2inxHZTCzfh0ik1AkDzdbsFzva74m/psm4R0op7I874fzxTl3nfTvdIts1MonzRN9yUV0ex5jaOobO+UqME3P7smn285xkkOPHQlddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947733; c=relaxed/simple;
	bh=gcno3SQAkTN1zwbLvLIx9huY+K9S6ZxHrm/PGGiJzjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REipOGMKW7Wip69Fq7CedLTEVPHL7crVRDSPIQXk8EuaA9d0/a+0AIK6nNlg0EO4NdwFeeywVE8RbU6olKjFZPOISn3BoNRwXZsMvvVkHbJGbfB31rckEtBSduFu8GiVutxqe8VZA3NrjnYjuFOngwX5T+ITW+DYvuV874wCpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iEqLUWJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6ACC4CEE9;
	Tue, 29 Apr 2025 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947732;
	bh=gcno3SQAkTN1zwbLvLIx9huY+K9S6ZxHrm/PGGiJzjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEqLUWJlhUg7r9+P4p/0pS/XtBue8b2UM/N9lwbwm7ONERJFRS4r/LkHSB4yuto4y
	 bSRofvRBWsChKqeBvwuUZ8ZyjmxJCSK+aGQtqr8R0DzplZwCJK2TU5zcwJrjbLtNi+
	 R0clGpSv9LczSa/xZTMbIZe/cs7Pd9Q/VDXDF5rM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Guan <hao.guan@siflower.com.cn>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/280] net: phy: leds: fix memory leak
Date: Tue, 29 Apr 2025 18:40:12 +0200
Message-ID: <20250429161118.012654747@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

[ Upstream commit b7f0ee992adf601aa00c252418266177eb7ac2bc ]

A network restart test on a router led to an out-of-memory condition,
which was traced to a memory leak in the PHY LED trigger code.

The root cause is misuse of the devm API. The registration function
(phy_led_triggers_register) is called from phy_attach_direct, not
phy_probe, and the unregister function (phy_led_triggers_unregister)
is called from phy_detach, not phy_remove. This means the register and
unregister functions can be called multiple times for the same PHY
device, but devm-allocated memory is not freed until the driver is
unbound.

This also prevents kmemleak from detecting the leak, as the devm API
internally stores the allocated pointer.

Fix this by replacing devm_kzalloc/devm_kcalloc with standard
kzalloc/kcalloc, and add the corresponding kfree calls in the unregister
path.

Fixes: 3928ee6485a3 ("net: phy: leds: Add support for "link" trigger")
Fixes: 2e0bc452f472 ("net: phy: leds: add support for led triggers on phy link state change")
Signed-off-by: Hao Guan <hao.guan@siflower.com.cn>
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250417032557.2929427-1-dqfext@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_led_triggers.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9dae..6f9d8da76c4df 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -91,9 +91,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
-	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
-					     sizeof(*phy->led_link_trigger),
-					     GFP_KERNEL);
+	phy->led_link_trigger = kzalloc(sizeof(*phy->led_link_trigger),
+					GFP_KERNEL);
 	if (!phy->led_link_trigger) {
 		err = -ENOMEM;
 		goto out_clear;
@@ -103,10 +102,9 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (err)
 		goto out_free_link;
 
-	phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
-					    phy->phy_num_led_triggers,
-					    sizeof(struct phy_led_trigger),
-					    GFP_KERNEL);
+	phy->phy_led_triggers = kcalloc(phy->phy_num_led_triggers,
+					sizeof(struct phy_led_trigger),
+					GFP_KERNEL);
 	if (!phy->phy_led_triggers) {
 		err = -ENOMEM;
 		goto out_unreg_link;
@@ -127,11 +125,11 @@ int phy_led_triggers_register(struct phy_device *phy)
 out_unreg:
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
+	kfree(phy->phy_led_triggers);
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
-	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
+	kfree(phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
 	phy->phy_num_led_triggers = 0;
@@ -145,8 +143,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
 	for (i = 0; i < phy->phy_num_led_triggers; i++)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 
-	if (phy->led_link_trigger)
+	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
+		kfree(phy->led_link_trigger);
+		phy->led_link_trigger = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(phy_led_triggers_unregister);
-- 
2.39.5




