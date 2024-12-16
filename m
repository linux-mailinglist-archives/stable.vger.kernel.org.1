Return-Path: <stable+bounces-104317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845A9F2C09
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7081882772
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842B1F709A;
	Mon, 16 Dec 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MQtUW3cH"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18F1C3318
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338167; cv=none; b=WzKXSIw3Ji+lWztuST0wtNoU3vK8aKvbdgD8B5aPVzey7XteO2AO6q3RiwfokTIgVeV2mJhOK7VJgR19b+1gJfmi+pkzUR+Qpzkfu9y9OOW71X5hxWIH0ZW1BmTIVK/YY61OyF656butHC6O4gran+UaDvD9Ro0ttBSiLyQVch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338167; c=relaxed/simple;
	bh=wbI0mKMWdKJTpHoGI+h2MBkSNibVAgdQ8V1iBKzfkQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sTgHIA4TBwYVRsi2+3XTA8Vl9uVdH/qsa42gJ8Z8nzT79877WVyqN75gcza1p0d2VVoTvIAM41v6k9D05D1wu42OuzW+NYU8oQ4YAQBWLPD7sOJHMj4CfIsHAhqq+5whe2ZhoOVFjaNwGEGtkPt0JRPK/X58GDNBJ5S/V8Y2+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MQtUW3cH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1C0D22042FCC; Mon, 16 Dec 2024 00:36:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C0D22042FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734338165;
	bh=rohi30jQued/musal8jVbkH2QFLeJasEFrkrbds2La4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQtUW3cHAr3DkX3DYyJOCUpU7fkAICC+VmC2agMIyDPCpy0M2o1ZuXgMX8MHPSr9W
	 eGbp7WDrKJ6wso//rNgLwg0gCeie9lOUgmV2fs/FlyKlM/YliLEPGz4++/mOhemGhu
	 34p7Ilwx+ISxvTCzf/y9fcawJdyqg6rKSwotiz6k=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: ernis@microsoft.com
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Date: Mon, 16 Dec 2024 00:35:59 -0800
Message-Id: <1734338161-12466-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1734338161-12466-1-git-send-email-ernis@linux.microsoft.com>
References: <1734338161-12466-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This change is specific to Hyper-V VM user.
If the Virtual Machine Connection window is focused,
a Hyper-V VM user can unintentionally touch the keyboard/mouse
when the VM is hibernating or resuming, and consequently the
hibernation or resume operation can be aborted unexpectedly.
Fix the issue by no longer registering the keyboard/mouse as
wakeup devices (see the other two patches for the
changes to drivers/input/serio/hyperv-keyboard.c and
drivers/hid/hid-hyperv.c).

The keyboard/mouse were registered as wakeup devices because the
VM needs to be woken up from the Suspend-to-Idle state after
a user runs "echo freeze > /sys/power/state". It seems like
the Suspend-to-Idle feature has no real users in practice, so
let's no longer support that by returning -EOPNOTSUPP if a
user tries to use that.

Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>>
---
Changes in v4:
* No change

Changes in v3:
* Add "Cc: stable@vger.kernel.org" in sign-off area.

Changes in v2:
* Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not 
  enabled.
---
 drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6d89d37b069a..4df6b12bf6a1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * vmbus_freeze - Suspend-to-Idle
+ */
+static int vmbus_freeze(struct device *child_device)
+{
+/*
+ * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
+ * that would require registering the Hyper-V synthetic mouse/keyboard
+ * devices as wakeup devices, which can abort hibernation/resume unexpectedly.
+ */
+	return -EOPNOTSUPP;
+}
+
 /*
  * vmbus_suspend - Suspend a vmbus device
  */
@@ -938,6 +951,7 @@ static int vmbus_resume(struct device *child_device)
 	return drv->resume(dev);
 }
 #else
+#define vmbus_freeze NULL
 #define vmbus_suspend NULL
 #define vmbus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
@@ -969,7 +983,7 @@ static void vmbus_device_release(struct device *device)
  */
 
 static const struct dev_pm_ops vmbus_pm = {
-	.suspend_noirq	= NULL,
+	.suspend_noirq  = vmbus_freeze,
 	.resume_noirq	= NULL,
 	.freeze_noirq	= vmbus_suspend,
 	.thaw_noirq	= vmbus_resume,
-- 
2.34.1


