Return-Path: <stable+bounces-160502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A2AFCEDE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F521628BF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E92DECA8;
	Tue,  8 Jul 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/fid4Gj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4E2E0B6E
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987896; cv=none; b=HoHHYFzeLmoVYC5DEiNL95hHfqDGXwsNWR3S8bRaBiSAQH9SvBbr4MI7wO0kJud7w+6SOJy6DgUOLso3borqud4z+C8Rjfr4BFuSf5xPzXNTtwOz8I/6HQYgpwAmHCOWyduPoaCHdkeG7tL9SW2FBdKLNg9f/M/1KchFD/wOUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987896; c=relaxed/simple;
	bh=uVWkjPFD9Z2d6tiChKd4L4qb0hbi+kwZ8Bx7rOVoO84=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eIZ/iw34cVENNKDteRufRz7qOi3o8nmJGFiX+DdYPG73e9tL35j6tWtGp+orM+9ZI2AKBz9aurCSpi1y2ywIuYQWikhIwPl8qwG9Kvc4ajP2BAo5ctXnmwyBITtSBWLJhGZyx8Kc3sg06/q7cXtEBMUDovQU3//9JR0ie4Y0dOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/fid4Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AC6C4CEED;
	Tue,  8 Jul 2025 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751987896;
	bh=uVWkjPFD9Z2d6tiChKd4L4qb0hbi+kwZ8Bx7rOVoO84=;
	h=Subject:To:Cc:From:Date:From;
	b=Y/fid4GjE5GCLpD4h3qeaR8VyETsgZDdpYu2eF9i3Zf2hdcTbb9lFolvWSPdFOWVc
	 1ll4ElXRqDxnuSGI9tm7oEGMRvfLv3G9J1fTFzZpOBjw33iuiCkS0a0mR7zljV9w98
	 HDUSMG2TUBioaJ1kMs9vhr0/3IijI2IOyUj042fU=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix kobject cleanup" failed to apply to 5.15-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:18:12 +0200
Message-ID: <2025070812-scorpion-thicken-4f6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9110056fe10b0519529bdbbac37311a5037ea0c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070812-scorpion-thicken-4f6f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9110056fe10b0519529bdbbac37311a5037ea0c2 Mon Sep 17 00:00:00 2001
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 30 Jun 2025 14:31:20 -0300
Subject: [PATCH] platform/x86: think-lmi: Fix kobject cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In tlmi_analyze(), allocated structs with an embedded kobject are freed
in error paths after the they were already initialized.

Fix this by first by avoiding the initialization of kobjects in
tlmi_analyze() and then by correctly cleaning them up in
tlmi_release_attr() using their kset's kobject list.

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Fixes: 30e78435d3bf ("platform/x86: think-lmi: Split kobject_init() and kobject_add() calls")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-2-ce4f81c9c481@gmail.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 39306951f234..69f361f21f0f 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1380,13 +1380,13 @@ static struct kobj_attribute debug_cmd = __ATTR_WO(debug_cmd);
 /* ---- Initialisation --------------------------------------------------------- */
 static void tlmi_release_attr(void)
 {
+	struct kobject *pos, *n;
 	int i;
 
 	/* Attribute structures */
 	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
 		if (tlmi_priv.setting[i]) {
 			sysfs_remove_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
-			kobject_put(&tlmi_priv.setting[i]->kobj);
 		}
 	}
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
@@ -1395,6 +1395,9 @@ static void tlmi_release_attr(void)
 	if (tlmi_priv.can_debug_cmd && debug_support)
 		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
 
+	list_for_each_entry_safe(pos, n, &tlmi_priv.attribute_kset->list, entry)
+		kobject_put(pos);
+
 	kset_unregister(tlmi_priv.attribute_kset);
 
 	/* Free up any saved signatures */
@@ -1403,19 +1406,17 @@ static void tlmi_release_attr(void)
 
 	/* Authentication structures */
 	sysfs_remove_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_admin->kobj);
 	sysfs_remove_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_power->kobj);
 
 	if (tlmi_priv.opcode_support) {
 		sysfs_remove_group(&tlmi_priv.pwd_system->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_system->kobj);
 		sysfs_remove_group(&tlmi_priv.pwd_hdd->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_hdd->kobj);
 		sysfs_remove_group(&tlmi_priv.pwd_nvme->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_nvme->kobj);
 	}
 
+	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)
+		kobject_put(pos);
+
 	kset_unregister(tlmi_priv.authentication_kset);
 }
 
@@ -1479,8 +1480,8 @@ static int tlmi_sysfs_init(void)
 
 		/* Build attribute */
 		tlmi_priv.setting[i]->kobj.kset = tlmi_priv.attribute_kset;
-		ret = kobject_add(&tlmi_priv.setting[i]->kobj, NULL,
-				  "%s", tlmi_priv.setting[i]->display_name);
+		ret = kobject_init_and_add(&tlmi_priv.setting[i]->kobj, &tlmi_attr_setting_ktype,
+					   NULL, "%s", tlmi_priv.setting[i]->display_name);
 		if (ret)
 			goto fail_create_attr;
 
@@ -1505,7 +1506,8 @@ static int tlmi_sysfs_init(void)
 
 	/* Create authentication entries */
 	tlmi_priv.pwd_admin->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_admin->kobj, NULL, "%s", "Admin");
+	ret = kobject_init_and_add(&tlmi_priv.pwd_admin->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Admin");
 	if (ret)
 		goto fail_create_attr;
 
@@ -1514,7 +1516,8 @@ static int tlmi_sysfs_init(void)
 		goto fail_create_attr;
 
 	tlmi_priv.pwd_power->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_power->kobj, NULL, "%s", "Power-on");
+	ret = kobject_init_and_add(&tlmi_priv.pwd_power->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Power-on");
 	if (ret)
 		goto fail_create_attr;
 
@@ -1524,7 +1527,8 @@ static int tlmi_sysfs_init(void)
 
 	if (tlmi_priv.opcode_support) {
 		tlmi_priv.pwd_system->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_system->kobj, NULL, "%s", "System");
+		ret = kobject_init_and_add(&tlmi_priv.pwd_system->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "System");
 		if (ret)
 			goto fail_create_attr;
 
@@ -1533,7 +1537,8 @@ static int tlmi_sysfs_init(void)
 			goto fail_create_attr;
 
 		tlmi_priv.pwd_hdd->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_hdd->kobj, NULL, "%s", "HDD");
+		ret = kobject_init_and_add(&tlmi_priv.pwd_hdd->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "HDD");
 		if (ret)
 			goto fail_create_attr;
 
@@ -1542,7 +1547,8 @@ static int tlmi_sysfs_init(void)
 			goto fail_create_attr;
 
 		tlmi_priv.pwd_nvme->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_nvme->kobj, NULL, "%s", "NVMe");
+		ret = kobject_init_and_add(&tlmi_priv.pwd_nvme->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "NVMe");
 		if (ret)
 			goto fail_create_attr;
 
@@ -1579,8 +1585,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
 	new_pwd->maxlen = tlmi_priv.pwdcfg.core.max_length;
 	new_pwd->index = 0;
 
-	kobject_init(&new_pwd->kobj, &tlmi_pwd_setting_ktype);
-
 	return new_pwd;
 }
 
@@ -1685,7 +1689,6 @@ static int tlmi_analyze(struct wmi_device *wdev)
 		if (setting->possible_values)
 			strreplace(setting->possible_values, ',', ';');
 
-		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
 		tlmi_priv.setting[i] = setting;
 		kfree(item);
 	}


