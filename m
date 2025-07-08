Return-Path: <stable+bounces-160503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E53AFCEE3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF473ABF38
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479442E0B6C;
	Tue,  8 Jul 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vrhv4zF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802D2E0B72
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987912; cv=none; b=iP+Jybcz95IijSQdq/nmXaoH3BwXiqflgcy+p57TWWBe8Lwttf/EfkVgPJbP+VeJKT/Q2Zb+8zyeZzcWNxTTjOVO6xkVHkWiGN5oM9v4CW20vQ3fn2PQl5+omxQSdpJIWpR3H2orRhGVP0nRsp8R9lMDduRPf3a3/J+2xpz0Rbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987912; c=relaxed/simple;
	bh=e2sO+4OLWL1GDuWW/bWETwFtmghj7wuXcsyBznwqZ8g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CBVpX1E9514Pqx4PvsH+f9PANv6cjmAXRZF+DA5jsFFAeXKZyCbCTWc89HvIDaLiC4Z4jDWqT190ZGY0mXh/UsAPIS++S8TTXMNBg8gC0Keg1MqrUIOyGmSAoU4jQGAZULVNEDcjAEXHKj1Gh77gCQoA/tsX/cCZiQ0Fr4hQqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vrhv4zF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430CBC4CEED;
	Tue,  8 Jul 2025 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751987911;
	bh=e2sO+4OLWL1GDuWW/bWETwFtmghj7wuXcsyBznwqZ8g=;
	h=Subject:To:Cc:From:Date:From;
	b=Vrhv4zF7RZ6Ea7hpZ2fV2mrL2tdtntzSlpAHD3GPCZcsZOnvbl19xka/3zbfiP7SD
	 1yXO7sKZeQnLyWfUH1pRJbVn9+Xa1Y0sR3EHZrUkroAf5IkuJZG7687h1L6q2t3XCN
	 JCAVqQsTcgWbXX43rIV18Ik1QoxxdzBxrMLsbcu8=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix sysfs group cleanup" failed to apply to 6.1-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:18:28 +0200
Message-ID: <2025070828-depose-reaffirm-f1ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070828-depose-reaffirm-f1ea@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a Mon Sep 17 00:00:00 2001
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 30 Jun 2025 14:31:21 -0300
Subject: [PATCH] platform/x86: think-lmi: Fix sysfs group cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Many error paths in tlmi_sysfs_init() lead to sysfs groups being removed
when they were not even created.

Fix this by letting the kobject core manage these groups through their
kobj_type's defult_groups.

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-3-ce4f81c9c481@gmail.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 69f361f21f0f..b73b84fdb15e 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -973,6 +973,7 @@ static const struct attribute_group auth_attr_group = {
 	.is_visible = auth_attr_is_visible,
 	.attrs = auth_attrs,
 };
+__ATTRIBUTE_GROUPS(auth_attr);
 
 /* ---- Attributes sysfs --------------------------------------------------------- */
 static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1188,6 +1189,7 @@ static const struct attribute_group tlmi_attr_group = {
 	.is_visible = attr_is_visible,
 	.attrs = tlmi_attrs,
 };
+__ATTRIBUTE_GROUPS(tlmi_attr);
 
 static void tlmi_attr_setting_release(struct kobject *kobj)
 {
@@ -1207,11 +1209,13 @@ static void tlmi_pwd_setting_release(struct kobject *kobj)
 static const struct kobj_type tlmi_attr_setting_ktype = {
 	.release        = &tlmi_attr_setting_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = tlmi_attr_groups,
 };
 
 static const struct kobj_type tlmi_pwd_setting_ktype = {
 	.release        = &tlmi_pwd_setting_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = auth_attr_groups,
 };
 
 static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1381,14 +1385,8 @@ static struct kobj_attribute debug_cmd = __ATTR_WO(debug_cmd);
 static void tlmi_release_attr(void)
 {
 	struct kobject *pos, *n;
-	int i;
 
 	/* Attribute structures */
-	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
-		if (tlmi_priv.setting[i]) {
-			sysfs_remove_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
-		}
-	}
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
 
@@ -1405,15 +1403,6 @@ static void tlmi_release_attr(void)
 	kfree(tlmi_priv.pwd_admin->save_signature);
 
 	/* Authentication structures */
-	sysfs_remove_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
-	sysfs_remove_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
-
-	if (tlmi_priv.opcode_support) {
-		sysfs_remove_group(&tlmi_priv.pwd_system->kobj, &auth_attr_group);
-		sysfs_remove_group(&tlmi_priv.pwd_hdd->kobj, &auth_attr_group);
-		sysfs_remove_group(&tlmi_priv.pwd_nvme->kobj, &auth_attr_group);
-	}
-
 	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)
 		kobject_put(pos);
 
@@ -1484,10 +1473,6 @@ static int tlmi_sysfs_init(void)
 					   NULL, "%s", tlmi_priv.setting[i]->display_name);
 		if (ret)
 			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
-		if (ret)
-			goto fail_create_attr;
 	}
 
 	ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
@@ -1511,20 +1496,12 @@ static int tlmi_sysfs_init(void)
 	if (ret)
 		goto fail_create_attr;
 
-	ret = sysfs_create_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
-	if (ret)
-		goto fail_create_attr;
-
 	tlmi_priv.pwd_power->kobj.kset = tlmi_priv.authentication_kset;
 	ret = kobject_init_and_add(&tlmi_priv.pwd_power->kobj, &tlmi_pwd_setting_ktype,
 				   NULL, "%s", "Power-on");
 	if (ret)
 		goto fail_create_attr;
 
-	ret = sysfs_create_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
-	if (ret)
-		goto fail_create_attr;
-
 	if (tlmi_priv.opcode_support) {
 		tlmi_priv.pwd_system->kobj.kset = tlmi_priv.authentication_kset;
 		ret = kobject_init_and_add(&tlmi_priv.pwd_system->kobj, &tlmi_pwd_setting_ktype,
@@ -1532,29 +1509,17 @@ static int tlmi_sysfs_init(void)
 		if (ret)
 			goto fail_create_attr;
 
-		ret = sysfs_create_group(&tlmi_priv.pwd_system->kobj, &auth_attr_group);
-		if (ret)
-			goto fail_create_attr;
-
 		tlmi_priv.pwd_hdd->kobj.kset = tlmi_priv.authentication_kset;
 		ret = kobject_init_and_add(&tlmi_priv.pwd_hdd->kobj, &tlmi_pwd_setting_ktype,
 					   NULL, "%s", "HDD");
 		if (ret)
 			goto fail_create_attr;
 
-		ret = sysfs_create_group(&tlmi_priv.pwd_hdd->kobj, &auth_attr_group);
-		if (ret)
-			goto fail_create_attr;
-
 		tlmi_priv.pwd_nvme->kobj.kset = tlmi_priv.authentication_kset;
 		ret = kobject_init_and_add(&tlmi_priv.pwd_nvme->kobj, &tlmi_pwd_setting_ktype,
 					   NULL, "%s", "NVMe");
 		if (ret)
 			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.pwd_nvme->kobj, &auth_attr_group);
-		if (ret)
-			goto fail_create_attr;
 	}
 
 	return ret;


