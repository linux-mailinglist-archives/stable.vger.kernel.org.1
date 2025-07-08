Return-Path: <stable+bounces-161350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7CAFD750
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308D5482BED
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB1225397;
	Tue,  8 Jul 2025 19:42:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DE92248BA
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003755; cv=none; b=uKkhd7iurNYiFijPlOW+AzSBna99dpjRqWgfioPFEHE+zGNIGTTZwYz7tKNNZZHN9p7oCzWjD//WEtbB/LsTn31XIFEuj/XKrot6udGhRw2oYg4KqlOK8+77YzaLp8BOX/aEKCOON12MpRIvMKyzJS1xO7I7p9Z8NGhhVigLnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003755; c=relaxed/simple;
	bh=DBFmFiYB9lulGbuBOZkEYD5XG9xgS/d+lvhvBh0X+QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4igbPX33k/HcOk4Q2X8lkn9BbV6/IKeUeYvfUtTGBTK/LeSl5RnizfIfErBIdmUq8FX/G+v8ziqICC4MXkeYf9oOVB7rktYdVeAhzDp9xGCPWoXbGQ7QQLcoXeW9Xesq3laTlV3TeshXocIB60AWYzOvr2CYczU5nB/D4zUclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B143153B;
	Tue,  8 Jul 2025 12:42:21 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63D1D3F66E;
	Tue,  8 Jul 2025 12:42:32 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [BACKPORT][PATCH 6.12.y 1/2] firmware: arm_ffa: Move memory allocation outside the mutex locking
Date: Tue,  8 Jul 2025 20:42:22 +0100
Message-Id: <20250708194223.937108-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 27e850c88df0e25474a8caeb2903e2e90b62c1dc ]

The notifier callback node allocation is currently done while holding
the notify_lock mutex. While this is safe even if memory allocation may
sleep, we need to move the allocation outside the locked region in
preparation to move from using muxtes to rwlocks.

Move the memory allocation to avoid potential sleeping in atomic context
once the locks are moved from mutex to rwlocks.

Fixes: e0573444edbf ("firmware: arm_ffa: Add interfaces to request notification callbacks")
Message-Id: <20250528-ffa_notif_fix-v1-2-5ed7bc7f8437@arm.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 40 ++++++++++++++++---------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c0f3b7cdb6ed..b0d92f411334 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1141,12 +1141,11 @@ notifier_hash_node_get(u16 notify_id, enum notify_type type)
 	return NULL;
 }
 
-static int
-update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
-		   void *cb_data, bool is_registration)
+static int update_notifier_cb(int notify_id, enum notify_type type,
+			      struct notifier_cb_info *cb)
 {
 	struct notifier_cb_info *cb_info = NULL;
-	bool cb_found;
+	bool cb_found, is_registration = !!cb;
 
 	cb_info = notifier_hash_node_get(notify_id, type);
 	cb_found = !!cb_info;
@@ -1155,15 +1154,7 @@ update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
 		return -EINVAL;
 
 	if (is_registration) {
-		cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
-		if (!cb_info)
-			return -ENOMEM;
-
-		cb_info->type = type;
-		cb_info->cb = cb;
-		cb_info->cb_data = cb_data;
-
-		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
+		hash_add(drv_info->notifier_hash, &cb->hnode, notify_id);
 	} else {
 		hash_del(&cb_info->hnode);
 		kfree(cb_info);
@@ -1193,7 +1184,7 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 
 	mutex_lock(&drv_info->notify_lock);
 
-	rc = update_notifier_cb(notify_id, type, NULL, NULL, false);
+	rc = update_notifier_cb(notify_id, type, NULL);
 	if (rc) {
 		pr_err("Could not unregister notification callback\n");
 		mutex_unlock(&drv_info->notify_lock);
@@ -1212,6 +1203,7 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 {
 	int rc;
 	u32 flags = 0;
+	struct notifier_cb_info *cb_info = NULL;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 
 	if (ffa_notifications_disabled())
@@ -1220,24 +1212,34 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
+	cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
+	if (!cb_info)
+		return -ENOMEM;
+
+	cb_info->type = type;
+	cb_info->cb_data = cb_data;
+	cb_info->cb = cb;
+
 	mutex_lock(&drv_info->notify_lock);
 
 	if (is_per_vcpu)
 		flags = PER_VCPU_NOTIFICATION_FLAG;
 
 	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
-	if (rc) {
-		mutex_unlock(&drv_info->notify_lock);
-		return rc;
-	}
+	if (rc)
+		goto out_unlock_free;
 
-	rc = update_notifier_cb(notify_id, type, cb, cb_data, true);
+	rc = update_notifier_cb(notify_id, type, cb_info);
 	if (rc) {
 		pr_err("Failed to register callback for %d - %d\n",
 		       notify_id, rc);
 		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 	}
+
+out_unlock_free:
 	mutex_unlock(&drv_info->notify_lock);
+	if (rc)
+		kfree(cb_info);
 
 	return rc;
 }
-- 
2.34.1


