Return-Path: <stable+bounces-169695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F909B27629
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4FA72197F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23D29ACDE;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfOvH3dx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CA29AB18;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225270; cv=none; b=qSuTNfukTjY88TkoQ/hhj8sQNz7tZP7Mf90jH503Vj5osY4iQlQAv5/LKqrpwpsraXcSxpn394OcfK1+Q5tO7zvtgJN8LxG6tS+mPed5Hq+2ehnmiZod7yInqLPteqcVcVwrRoMjzTkt2Oa9GtajM8WnSKh6Gq949fV3HeiGoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225270; c=relaxed/simple;
	bh=iNZwS3cWXpBb0gBkOzimRRnhkZpZdKX3Lops1X+pEwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWtGDnmFsizMAFe05n9dlVIx6dI22cSYsfQcGY07/xvYSkiQHHQNVzs6HAde9MGIPuh/ms0KLjGOp3LrERUysXYp3z8Llbr7N5YP/8/EwydAIPUtUkLN5NkTgMPZGSPDqOb7WmlEQ5yTRX4SD5kqgGtpD0O1r3lTtu0okR4zDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfOvH3dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE918C4CEED;
	Fri, 15 Aug 2025 02:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755225270;
	bh=iNZwS3cWXpBb0gBkOzimRRnhkZpZdKX3Lops1X+pEwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OfOvH3dxPsZ8VI0iDl0zzrVzTkspcge/XbddjFpKlWN6VB7Ur1nD8oMV+65zeTx8q
	 DLjAqdmyiZ8/KzIXz9Sr+HR/xe9yYKTa95C84ohDDISr23BeswonvChyv+86uWQp5V
	 I69RwWXJNFo9C8asbSuYJ0c24k+w5OGtLuLMlOk23u0cf/9L52Y2kZrzDRcb0UpPxi
	 luH8AwxRAal2iSlN+3pzwuDM0N/IVnWeNWe/mmkXGr0j1uMFNKFBbE2Me2lXuZGI5y
	 A05MHRztPUvP3GdvfTjYisfzGrEdD50oQnzs+i/M4JqGVN+MHjFhnrM1uDBRWRHxzV
	 2Ad8Z7ZVHt5jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB9CA0EDC;
	Fri, 15 Aug 2025 02:34:29 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 14 Aug 2025 19:34:09 -0700
Subject: [PATCH 1/2] usb: typec: maxim_contaminant: disable low power mode
 when reading comparator values
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-fix-upstream-contaminant-v1-1-801ce8089031@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755225269; l=2298;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=IsDjcaTu0txvpO4BMMBaJgeRGe/D8aQMvWNWtW/9v68=;
 b=DhXf9G2VfVomiDbAtZDudyhA2IH0NYdVz0VlTPrYYAa+m4E0Jf4y6NSnhPTR5aANuZB0In+OX
 6t5MMxblL7QDvAY5ouWpewTNaYy7s3O9RwfbTYXUbt8xfinDe0v5vPx
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Low power mode is enabled when reading CC resistance as part of
`max_contaminant_read_resistance_kohm()` and left in that state.
However, it's supposed to work with 1uA current source. To read CC
comparator values current source is changed to 80uA. This causes a storm
of CC interrupts as it (falsely) detects a potential contaminant. To
prevent this, disable low power mode current sourcing before reading
comparator values.

Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 5 +++++
 drivers/usb/typec/tcpm/tcpci_maxim.h       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 0cdda06592fd3cc34e2179ccd49ef677f8ec9792..818cfe226ac7716de2fcbce205c67ea16acba592 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -188,6 +188,11 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	if (ret < 0)
 		return ret;
 
+	/* Disable low power mode */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+
 	/* Sleep to allow comparators settle */
 	usleep_range(5000, 6000);
 	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 76270d5c283880dc49b13cabe7d682f2c2bf15fe..b33540a42a953dc6d8197790ee4af3b6f52791ce 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -21,6 +21,7 @@
 #define CCOVPDIS                                BIT(6)
 #define SBURPCTRL                               BIT(5)
 #define CCLPMODESEL                             GENMASK(4, 3)
+#define LOW_POWER_MODE_DISABLE                  0
 #define ULTRA_LOW_POWER_MODE                    1
 #define CCRPCTRL                                GENMASK(2, 0)
 #define UA_1_SRC                                1

-- 
2.51.0.rc1.167.g924127e9c0-goog



