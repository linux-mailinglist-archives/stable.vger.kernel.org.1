Return-Path: <stable+bounces-169696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F2AB27622
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D102D188F1BB
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146C29B205;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLXljyPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694929ACCB;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225270; cv=none; b=KP9mimc9xxO8iUK/qPWJrhC1iqzKkaugqTYP7IUgmL1VSHGBXINLApHpb1ZdlB+VGoJ8w2BdarFUHcb0w4W1reXpzRuZe+1rpLWtWoIlKj06bSg4VmErnftpDISOz70ibwhASPocSIKNRdgCmnX5akWk9fO085SiplJBuM6euEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225270; c=relaxed/simple;
	bh=i46X2Vu3ICA1wgpjSmUzAN53kjb5EYnYdux85kuTvC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jk0SJKisiXuPTqsfiFUL3/Bw48S/rtXP4cKiemp/Yctmal+mWp5xYPNTl0Sq+cokduZpDmfFAY/w/Y0OBfzm67sA7gD3U3sc11j/f6RlXXYnAxQs1WeXAEWnet/d6QkCxMFqHmW5Kcjxhu/U0qahrZ6pCSH0JQQXKfGYA2Mr8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLXljyPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 086A4C4CEF6;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755225270;
	bh=i46X2Vu3ICA1wgpjSmUzAN53kjb5EYnYdux85kuTvC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LLXljyPwFmUJ639H+i5acCiMmd4rRSQ4qY3aNw5x9QgKAKYPwxFWJnvqP7Tw91Zzb
	 zWvRzZneqWuGZFbFy9J1enltV+7T93RfDn3Lwpoa1Jcv/9YFNJJZ7mSeiCv0WfvbSE
	 rsAmlhz0oHwHd9gVW7gtiSNmTtLTgv/5dPM7TRZiHlb0fwDmAKHEnBnUg3rCj8rIuF
	 HZOQpInLHTjUpKx6RNtHe1uT0LsGzKi/bsmbhqWsKINAPpMvcAKq0WLvb/8d0QBQDm
	 AGLdSkiB0scN5dWRXpu7/YSLKi68iuLKpOUi4Tw4ysu98onh9OYEmykfwb6snbk7sx
	 u4+bPN7/aQa4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B9CA0EE8;
	Fri, 15 Aug 2025 02:34:29 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 14 Aug 2025 19:34:10 -0700
Subject: [PATCH 2/2] usb: typec: maxim_contaminant: re-enable cc toggle if
 cc is open and port is clean
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-fix-upstream-contaminant-v1-2-801ce8089031@google.com>
References: <20250814-fix-upstream-contaminant-v1-0-801ce8089031@google.com>
In-Reply-To: <20250814-fix-upstream-contaminant-v1-0-801ce8089031@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755225269; l=3823;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=qAcTOGcQuyAV3AKhTOrWCDa/cZQDsDqaLED5LXbnmns=;
 b=uN5nu7i+AgvcuGYzFt9VC00M6KcrPBoShLVXmu6Xub4fDgbxH0MhWFD9dXMeteRBN3IAzdj6b
 6gQnGTBpS9RCW4HvLyQ6Uux0X+St0RstsIuhQ4ogTQR3tLAloi5UGEF
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



