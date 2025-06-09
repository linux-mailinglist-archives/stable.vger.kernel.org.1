Return-Path: <stable+bounces-152153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E6DAD200F
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001F53B2957
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179ED25A340;
	Mon,  9 Jun 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDIPqqH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2C8F5B;
	Mon,  9 Jun 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476893; cv=none; b=oklp3TYfOq1HID5RjwNAe4I0IueGmjDLnsbnBlhu9qYQVFUaNZ2Q4peXbMbR8rDTad1+zLy3d2EY3byYLEVw6ApVWVT3+YXGk2HVq9szB/EYz/4RYcM7+7Q09PMYOK5WzwgyX/tFFGHZHCXIQ43dkm3EtupI80IVyz4nmIrurXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476893; c=relaxed/simple;
	bh=gWLGSSmgVlgx2oMOjuQ6FvZkzRq6Ipks+KK6rcvDTYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFXaPI2KOrxOh4xEXZyOWphxZ9/5M4Fk0GmBnUXaFhqG5FXZr3hQrAWYaLJ2yTh6+28t36uHG12bIVVhOizHPwBZtC279RP2DwziiIqTXFOn62+4D0yrpcUdpI+ad31uzWHab4lHQEB7bbqrQ+gOnmIQwVtVMme4HTEwTCOK2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDIPqqH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D1C4CEED;
	Mon,  9 Jun 2025 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476893;
	bh=gWLGSSmgVlgx2oMOjuQ6FvZkzRq6Ipks+KK6rcvDTYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDIPqqH9P641CveB1gEH7S4Gvrq5eKp+uER1O8Sam6h8tAJJDTjVV1BNfJ0ggVNsg
	 NVfmj00mfgSXdo9xEj/FvXt86Vi0nQun+GPYMerOOwAsEAjX3N/209zh7hQ58svczk
	 1xc+XqxKj63b6CMicnXyX2bd6QYPYAqhF2DF4HHOkUFT5CrEMG+C0lwemNtFDZ1Upu
	 u08HznYPsQUeXYEM7Zjbpz41lbbg5Cwkc9slYXttRHuennrUT7aUCCtX6zXC9HfDgz
	 /3Q3mdtkME/qcoPR74RKISYK9nPEj718RB+jUKG8DAmFxDooogR72oIGMBlOLqgSEw
	 TcFhBq5muv6iA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chance Yang <chance.yang@kneron.us>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	u.kleine-koenig@baylibre.com,
	sebastian.reichel@collabora.com,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH AUTOSEL 5.15 09/12] usb: common: usb-conn-gpio: use a unique name for usb connector device
Date: Mon,  9 Jun 2025 09:47:52 -0400
Message-Id: <20250609134755.1345286-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134755.1345286-1-sashal@kernel.org>
References: <20250609134755.1345286-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chance Yang <chance.yang@kneron.us>

[ Upstream commit d4e5b10c55627e2f3fc9e5b337a28b4e2f02a55e ]

The current implementation of the usb-conn-gpio driver uses a fixed
"usb-charger" name for all USB connector devices. This causes conflicts
in the power supply subsystem when multiple USB connectors are present,
as duplicate names are not allowed.

Use IDA to manage unique IDs for naming usb connectors (e.g.,
usb-charger-0, usb-charger-1).

Signed-off-by: Chance Yang <chance.yang@kneron.us>
Link: https://lore.kernel.org/r/20250411-work-next-v3-1-7cd9aa80190c@kneron.us
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Analysis

**Critical User-Affecting Issue**: The commit fixes a real bug where
multiple USB connectors cannot coexist on the same system. Without this
fix, when multiple `usb-conn-gpio` devices are present, all would
attempt to register with the same "usb-charger" name in the power supply
subsystem, causing registration failures and rendering additional USB
connectors non-functional.

## Code Changes Analysis

**Minimal and Well-Contained**: The changes are small and focused:

1. **Addition of IDA infrastructure** (lines +21-22):
  ```c
  #include <linux/idr.h>
  static DEFINE_IDA(usb_conn_ida);
  ```

2. **Unique ID allocation** (lines +168-177):
  ```c
  info->conn_id = ida_alloc(&usb_conn_ida, GFP_KERNEL);
  desc->name = devm_kasprintf(dev, GFP_KERNEL, "usb-charger-%d",
  info->conn_id);
  ```

3. **Proper cleanup** (lines +297-299):
  ```c
  if (info->charger)
  ida_free(&usb_conn_ida, info->conn_id);
  ```

## Risk Assessment

**Very Low Risk**:
- Uses well-established IDA pattern found throughout the kernel (similar
  to the USB gadget example in the historical commits)
- No architectural changes
- No new dependencies beyond existing IDA infrastructure
- Proper error handling with cleanup on all failure paths
- Changes only affect internal naming, no API breakage

## Stable Tree Criteria Compliance

**Meets All Stable Criteria**:

1. **Important bugfix**: ✅ Prevents system malfunction with multiple USB
   connectors
2. **Affects real users**: ✅ Common on embedded systems, development
   boards, tablets
3. **Small and contained**: ✅ Only 25 lines of changes in single driver
4. **No major architectural changes**: ✅ Simple naming fix using
   established patterns
5. **Minimal regression risk**: ✅ Well-tested IDA pattern used across
   kernel

## Comparison with Historical Commits

This commit is very similar to historical commit #3 ("USB: gadget: Add
ID numbers to gadget names"), which was marked as **NO** for
backporting. However, there are key differences:

**Why this USB connector commit SHOULD be backported (unlike the gadget
commit)**:

1. **Functional vs. Cosmetic**: The USB connector naming conflict causes
   **actual device failure** and power management issues, whereas the
   gadget naming was more about sysfs organization
2. **Critical subsystem**: Power supply registration failure can affect
   system power management and charging detection
3. **Error severity**: Power supply naming conflicts typically cause
   probe failures, while sysfs naming conflicts may not prevent basic
   functionality
4. **User impact**: USB connector detection is critical for proper power
   management on mobile/embedded devices

## Conclusion

This is an excellent stable tree candidate that fixes a real functional
bug with minimal risk. The change enables proper operation of multi-
connector systems using established kernel patterns, making it both safe
and beneficial for stable tree inclusion.

 drivers/usb/common/usb-conn-gpio.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 521c95935d4c3..9691a1c8d8b0e 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -20,6 +20,9 @@
 #include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/role.h>
+#include <linux/idr.h>
+
+static DEFINE_IDA(usb_conn_ida);
 
 #define USB_GPIO_DEB_MS		20	/* ms */
 #define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
@@ -29,6 +32,7 @@
 
 struct usb_conn_info {
 	struct device *dev;
+	int conn_id; /* store the IDA-allocated ID */
 	struct usb_role_switch *role_sw;
 	enum usb_role last_role;
 	struct regulator *vbus;
@@ -160,7 +164,17 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 		.of_node = dev->of_node,
 	};
 
-	desc->name = "usb-charger";
+	info->conn_id = ida_alloc(&usb_conn_ida, GFP_KERNEL);
+	if (info->conn_id < 0)
+		return info->conn_id;
+
+	desc->name = devm_kasprintf(dev, GFP_KERNEL, "usb-charger-%d",
+				    info->conn_id);
+	if (!desc->name) {
+		ida_free(&usb_conn_ida, info->conn_id);
+		return -ENOMEM;
+	}
+
 	desc->properties = usb_charger_properties;
 	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
 	desc->get_property = usb_charger_get_property;
@@ -168,8 +182,10 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 	cfg.drv_data = info;
 
 	info->charger = devm_power_supply_register(dev, desc, &cfg);
-	if (IS_ERR(info->charger))
-		dev_err(dev, "Unable to register charger\n");
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Unable to register charger %d\n", info->conn_id);
+		ida_free(&usb_conn_ida, info->conn_id);
+	}
 
 	return PTR_ERR_OR_ZERO(info->charger);
 }
@@ -292,6 +308,9 @@ static int usb_conn_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->dw_det);
 
+	if (info->charger)
+		ida_free(&usb_conn_ida, info->conn_id);
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
-- 
2.39.5


