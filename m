Return-Path: <stable+bounces-160770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD99AFD1C5
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D8F1C25505
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793221773D;
	Tue,  8 Jul 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+9MosiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702D2E0411;
	Tue,  8 Jul 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992638; cv=none; b=aHcEdk/UAZd4UbLGUU3NN2nkr/6678vQSgqAjx5mngyHGsky1L3PL9XEMLTsUJ1GZbyvnftvmwUyLzngQ55Kk5xa8NPA7CwbLi5wTAWtBGM1+pmM+KwlMye8qsSddHOTkGwFpCPmxpAoFPx3mGXQniWW9uMPuUMrRHpcpRhKJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992638; c=relaxed/simple;
	bh=+0iqOl/mpfx8ff7YBc39jydO9U9C7qfoxUFN8HSX+cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/DsYmqti8TCv/KrGAuv6zcFT8MqFIK1JKkUhcQXlj+GtkA7xMch6v758BT7rhMRMLBX9k8w/f6Nu224crl6GkiE9KGJamSC4W9xlBdvQEeUvT/Fi9KMnbSonLLCAD7Djtkrw/HTOqun8qWJzFGQAMLOsUeqkkxI31LC/7vNHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+9MosiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56672C4CEED;
	Tue,  8 Jul 2025 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992638;
	bh=+0iqOl/mpfx8ff7YBc39jydO9U9C7qfoxUFN8HSX+cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+9MosiV4LaTUsiuV32+WRv60F2ZLaN19ldEYIqPU/cMU8LG0jI71IpXs88LK7W+0
	 vBE3VLJySz3fo5pth7oThCe2jokDqcXLkenaEVNMXPsSY5/zUilj8QlSjw5bs3yzjt
	 OaOoDkTyrL4XVY/z3TJQAE+T2lN1HHCte6LV+KIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/232] firmware: arm_ffa: Add support for {un,}registration of framework notifications
Date: Tue,  8 Jul 2025 18:20:25 +0200
Message-ID: <20250708162242.198209294@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit c10debfe7f028c11f7a501a0f8e937c9be9e5327 ]

Framework notifications are doorbells that are rung by the partition
managers to signal common events to an endpoint. These doorbells cannot
be rung by an endpoint directly. A partition manager can signal a
Framework notification in response to an FF-A ABI invocation by an
endpoint.

Two additional notify_ops interface is being added for any FF-A device/
driver to register and unregister for such a framework notifications.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <20250217-ffa_updates-v3-16-bd1d9de615e7@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Stable-dep-of: 27e850c88df0 ("firmware: arm_ffa: Move memory allocation outside the mutex locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 113 ++++++++++++++++++++++++------
 include/linux/arm_ffa.h           |   5 ++
 2 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f0c7f417d7524..f19b142645cc5 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1079,6 +1079,7 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 struct notifier_cb_info {
 	struct hlist_node hnode;
 	struct ffa_device *dev;
+	ffa_fwk_notifier_cb fwk_cb;
 	ffa_notifier_cb cb;
 	void *cb_data;
 };
@@ -1142,28 +1143,61 @@ static enum notify_type ffa_notify_type_get(u16 vm_id)
 		return NON_SECURE_VM;
 }
 
-/* Should be called while the notify_lock is taken */
+/* notifier_hnode_get* should be called with notify_lock held */
 static struct notifier_cb_info *
-notifier_hash_node_get(u16 notify_id, enum notify_type type)
+notifier_hnode_get_by_vmid(u16 notify_id, int vmid)
 {
 	struct notifier_cb_info *node;
 
 	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
-		if (type == ffa_notify_type_get(node->dev->vm_id))
+		if (node->fwk_cb && vmid == node->dev->vm_id)
+			return node;
+
+	return NULL;
+}
+
+static struct notifier_cb_info *
+notifier_hnode_get_by_vmid_uuid(u16 notify_id, int vmid, const uuid_t *uuid)
+{
+	struct notifier_cb_info *node;
+
+	if (uuid_is_null(uuid))
+		return notifier_hnode_get_by_vmid(notify_id, vmid);
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (node->fwk_cb && vmid == node->dev->vm_id &&
+		    uuid_equal(&node->dev->uuid, uuid))
+			return node;
+
+	return NULL;
+}
+
+static struct notifier_cb_info *
+notifier_hnode_get_by_type(u16 notify_id, enum notify_type type)
+{
+	struct notifier_cb_info *node;
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (node->cb && type == ffa_notify_type_get(node->dev->vm_id))
 			return node;
 
 	return NULL;
 }
 
 static int
-update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
-		   void *cb_data, bool is_registration)
+update_notifier_cb(struct ffa_device *dev, int notify_id, void *cb,
+		   void *cb_data, bool is_registration, bool is_framework)
 {
 	struct notifier_cb_info *cb_info = NULL;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 	bool cb_found;
 
-	cb_info = notifier_hash_node_get(notify_id, type);
+	if (is_framework)
+		cb_info = notifier_hnode_get_by_vmid_uuid(notify_id, dev->vm_id,
+							  &dev->uuid);
+	else
+		cb_info = notifier_hnode_get_by_type(notify_id, type);
+
 	cb_found = !!cb_info;
 
 	if (!(is_registration ^ cb_found))
@@ -1175,8 +1209,11 @@ update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
 			return -ENOMEM;
 
 		cb_info->dev = dev;
-		cb_info->cb = cb;
 		cb_info->cb_data = cb_data;
+		if (is_framework)
+			cb_info->fwk_cb = cb;
+		else
+			cb_info->cb = cb;
 
 		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
 	} else {
@@ -1187,7 +1224,8 @@ update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
 	return 0;
 }
 
-static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+static int __ffa_notify_relinquish(struct ffa_device *dev, int notify_id,
+				   bool is_framework)
 {
 	int rc;
 
@@ -1199,22 +1237,35 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 
 	mutex_lock(&drv_info->notify_lock);
 
-	rc = update_notifier_cb(dev, notify_id, NULL, NULL, false);
+	rc = update_notifier_cb(dev, notify_id, NULL, NULL, false,
+				is_framework);
 	if (rc) {
 		pr_err("Could not unregister notification callback\n");
 		mutex_unlock(&drv_info->notify_lock);
 		return rc;
 	}
 
-	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+	if (!is_framework)
+		rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 
 	mutex_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
 
-static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
-			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	return __ffa_notify_relinquish(dev, notify_id, false);
+}
+
+static int ffa_fwk_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	return __ffa_notify_relinquish(dev, notify_id, true);
+}
+
+static int __ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+				void *cb, void *cb_data,
+				int notify_id, bool is_framework)
 {
 	int rc;
 	u32 flags = 0;
@@ -1227,26 +1278,44 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 
 	mutex_lock(&drv_info->notify_lock);
 
-	if (is_per_vcpu)
-		flags = PER_VCPU_NOTIFICATION_FLAG;
+	if (!is_framework) {
+		if (is_per_vcpu)
+			flags = PER_VCPU_NOTIFICATION_FLAG;
 
-	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
-	if (rc) {
-		mutex_unlock(&drv_info->notify_lock);
-		return rc;
+		rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
+		if (rc) {
+			mutex_unlock(&drv_info->notify_lock);
+			return rc;
+		}
 	}
 
-	rc = update_notifier_cb(dev, notify_id, cb, cb_data, true);
+	rc = update_notifier_cb(dev, notify_id, cb, cb_data, true,
+				is_framework);
 	if (rc) {
 		pr_err("Failed to register callback for %d - %d\n",
 		       notify_id, rc);
-		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+		if (!is_framework)
+			ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 	}
 	mutex_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
 
+static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+{
+	return __ffa_notify_request(dev, is_per_vcpu, cb, cb_data, notify_id,
+				    false);
+}
+
+static int
+ffa_fwk_notify_request(struct ffa_device *dev, ffa_fwk_notifier_cb cb,
+		       void *cb_data, int notify_id)
+{
+	return __ffa_notify_request(dev, false, cb, cb_data, notify_id, true);
+}
+
 static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 			   bool is_per_vcpu, u16 vcpu)
 {
@@ -1276,7 +1345,7 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 			continue;
 
 		mutex_lock(&drv_info->notify_lock);
-		cb_info = notifier_hash_node_get(notify_id, type);
+		cb_info = notifier_hnode_get_by_type(notify_id, type);
 		mutex_unlock(&drv_info->notify_lock);
 
 		if (cb_info && cb_info->cb)
@@ -1349,6 +1418,8 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
 	.notify_request = ffa_notify_request,
 	.notify_relinquish = ffa_notify_relinquish,
+	.fwk_notify_request = ffa_fwk_notify_request,
+	.fwk_notify_relinquish = ffa_fwk_notify_relinquish,
 	.notify_send = ffa_notify_send,
 };
 
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 74169dd0f6594..5e2530f23b793 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -455,6 +455,7 @@ struct ffa_cpu_ops {
 
 typedef void (*ffa_sched_recv_cb)(u16 vcpu, bool is_per_vcpu, void *cb_data);
 typedef void (*ffa_notifier_cb)(int notify_id, void *cb_data);
+typedef void (*ffa_fwk_notifier_cb)(int notify_id, void *cb_data, void *buf);
 
 struct ffa_notifier_ops {
 	int (*sched_recv_cb_register)(struct ffa_device *dev,
@@ -463,6 +464,10 @@ struct ffa_notifier_ops {
 	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
 			      ffa_notifier_cb cb, void *cb_data, int notify_id);
 	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
+	int (*fwk_notify_request)(struct ffa_device *dev,
+				  ffa_fwk_notifier_cb cb, void *cb_data,
+				  int notify_id);
+	int (*fwk_notify_relinquish)(struct ffa_device *dev, int notify_id);
 	int (*notify_send)(struct ffa_device *dev, int notify_id, bool per_vcpu,
 			   u16 vcpu);
 };
-- 
2.39.5




