Return-Path: <stable+bounces-169811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7FB285D4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8D11CC79E0
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77021421D;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llEhxguw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF9946A;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282736; cv=none; b=D2Y4+1X67QtSBICQbgoPsaU1p1q7qtHX8XFE27gQin7EM1gvGu2mkGQTubUDpx1GB4l9ov7IV9EEXyIi0nvFBJorjMbY6irFawFvbU4OSfwh/uCiquqhyXk4ciWKlLOrGYnx6SX5QNMvd/7TUPlefZAu6CycpB2WtCtqG866SuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282736; c=relaxed/simple;
	bh=k/hVQtPf/YplLXIDsqdhaq22mUPS3WD/l1OuxiARJfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ32JENA+Jt9gFGwUsoseSwLivbcIXeTXQrv4rn76YuYaTN24ItrJeaUoXQmmVfTQv57yye+mRwUYkASMMzYxqDy2uo9+MOT3mCVeiEnQBJyKy03HpMoi2yCUZ/i3imQyKPfuRKdVMSPrA88EhM2++6X5O/okwMw6CGeq9sFBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llEhxguw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3233BC4CEF6;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755282736;
	bh=k/hVQtPf/YplLXIDsqdhaq22mUPS3WD/l1OuxiARJfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=llEhxguwOjaJnGKxqOz7buWLcmS2BPO/DgX2TWj/sN5uiA3n52m60vivhsOwXRCBW
	 dFjhcwuhExDWY1ZkLrHE3DiGClLfjKvWOBizeGN4+D1gS6J4MBlyxBZGZddoNHkijW
	 9KqR2myRCd2iTIznblPxtrziJ4bPS3YSGHOUQOSYTOAA4KRYgxHs3l2C4g2l9UvEw1
	 cLZzQD1G98BrIM1GEyVQ9pd7kv+6tSxkjNlmJ92CJijCkKqng24C2Kt6BL10Q3peK9
	 8zRykc73gg+9PPeYHUnv1af4kHYXsIyWAlGpXV3mRDp2JZq3IONHQqluJbCK8PoviP
	 WbtXhuHDfXCbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275E4CA0ED1;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Fri, 15 Aug 2025 11:31:52 -0700
Subject: [PATCH v2 2/2] usb: typec: maxim_contaminant: re-enable cc toggle
 if cc is open and port is clean
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com>
References: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
In-Reply-To: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755282735; l=3851;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=EWnT1ifJAgl1Osv4yGiXsCaYOzDaaQyWwT/7zjrH7aQ=;
 b=rvbTFbaa4EqrfOIvMfO9ErfjvRxt6r3Sdvwn+i6BHgY7mrPr8wRcqwe4dtWipx1UX8lSKPRhY
 oAlPewPQ5ChCkfnXYhJI4SjTta/ErnBkXDKnVYD43mj5OnenRIoxDNx
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Presently in `max_contaminant_is_contaminant()` if there's no
contaminant detected previously, CC is open & stopped toggling and no
contaminant is currently present, TCPC.RC would be programmed to do DRP
toggling. However, it didn't actively look for a connection. This would
lead to Type-C not detect *any* new connections. Hence, in the above
situation, re-enable toggling & program TCPC to look for a new
connection.

Also, return early if TCPC was looking for connection as this indicates
TCPC has neither detected a potential connection nor a change in
contaminant state.

In addition, once dry detection is complete (port is dry), restart
toggling.

Fixes: 02b332a06397e ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 818cfe226ac7716de2fcbce205c67ea16acba592..af8da6dc60ae0bc5900f6614514d51f41eded8ab 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -329,6 +329,39 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
 	return 0;
 }
 
+static int max_contaminant_enable_toggling(struct max_tcpci_chip *chip)
+{
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
+
+	/* Disable dry detection if enabled. */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCONNDRY, 0);
+	if (ret)
+		return ret;
+
+	ret = max_tcpci_write8(chip, TCPC_ROLE_CTRL, TCPC_ROLE_CTRL_DRP |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+					  TCPC_ROLE_CTRL_CC_RD) |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+					  TCPC_ROLE_CTRL_CC_RD));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT);
+	if (ret)
+		return ret;
+
+	return max_tcpci_write8(chip, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
+}
+
 bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
 				    bool *cc_handled)
 {
@@ -345,6 +378,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 	if (ret < 0)
 		return false;
 
+	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
+		if (chip->contaminant_state == DETECTED)
+			return true;
+		return false;
+	}
+
 	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
 		if (!disconnect_while_debounce)
 			msleep(100);
@@ -377,6 +416,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 				max_contaminant_enable_dry_detection(chip);
 				return true;
 			}
+
+			ret = max_contaminant_enable_toggling(chip);
+			if (ret)
+				dev_err(chip->dev,
+					"Failed to enable toggling, ret=%d",
+					ret);
 		}
 	} else if (chip->contaminant_state == DETECTED) {
 		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
@@ -384,6 +429,14 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 			if (chip->contaminant_state == DETECTED) {
 				max_contaminant_enable_dry_detection(chip);
 				return true;
+			} else {
+				ret = max_contaminant_enable_toggling(chip);
+				if (ret) {
+					dev_err(chip->dev,
+						"Failed to enable toggling, ret=%d",
+						ret);
+					return true;
+				}
 			}
 		}
 	}

-- 
2.51.0.rc1.167.g924127e9c0-goog



