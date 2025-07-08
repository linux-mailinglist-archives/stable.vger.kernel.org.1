Return-Path: <stable+bounces-160964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6DAFD2C6
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BC5421A3A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4C21C190;
	Tue,  8 Jul 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+bunXNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFC23DE;
	Tue,  8 Jul 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993204; cv=none; b=iGiaD9AnzjKVqsgBCt9V2pZ4kDMncdERfCVEa04tTSNW0AxjdOxFcmj/GZImCM2+b7FTM3Ge85CNZlwlQbazvlkkPkEbb2o26Gl7s7ukKONutnURdbUERjdjxCcwvoNjsT6cXxbNosScJrF0pdgl0Nafc5wGo/1nAI3zK8EChXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993204; c=relaxed/simple;
	bh=gVLLepaXIbkUho/SP9VRmjje0JKInA4O7GiTWXV3xdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5GviGMYF5ymd2qQQemH6TKRqgTsUS56mnStIqiKwKbLJU4164RHOa0WBzaQEn++SYQYsZzZrydlq4izieLRdPM7+e0BujxiXtUzXldB/DN5HbfuJGUERk5VXstd3VTIRHDmRJ/4Z5Sdd1x9i9sPquNJPXz7n9okISou/RJBKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+bunXNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F841C4CEED;
	Tue,  8 Jul 2025 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993204;
	bh=gVLLepaXIbkUho/SP9VRmjje0JKInA4O7GiTWXV3xdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+bunXNxomi+GhSWS9/2Pe99T20I95rgiAzFZkL+Ef6bImerJqL90DAFLvLnQgqyu
	 dmgA1b/jCzPTdxXnkfgXKEDh2oQNo3ByuUUOD255gXi+RHIFThdDpIxQLt1rNSFMiy
	 aqFwpBtWr/HNVqpmQvKraU/Y+6M4jC5AMUQj6AHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 6.12 223/232] platform/x86: think-lmi: Fix sysfs group cleanup
Date: Tue,  8 Jul 2025 18:23:39 +0200
Message-ID: <20250708162247.266850727@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

commit 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/think-lmi.c |   43 +++------------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -906,6 +906,7 @@ static const struct attribute_group auth
 	.is_visible = auth_attr_is_visible,
 	.attrs = auth_attrs,
 };
+__ATTRIBUTE_GROUPS(auth_attr);
 
 /* ---- Attributes sysfs --------------------------------------------------------- */
 static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1121,6 +1122,7 @@ static const struct attribute_group tlmi
 	.is_visible = attr_is_visible,
 	.attrs = tlmi_attrs,
 };
+__ATTRIBUTE_GROUPS(tlmi_attr);
 
 static void tlmi_attr_setting_release(struct kobject *kobj)
 {
@@ -1140,11 +1142,13 @@ static void tlmi_pwd_setting_release(str
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
@@ -1314,14 +1318,8 @@ static struct kobj_attribute debug_cmd =
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
 
@@ -1338,15 +1336,6 @@ static void tlmi_release_attr(void)
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
 
@@ -1417,10 +1406,6 @@ static int tlmi_sysfs_init(void)
 					   NULL, "%s", tlmi_priv.setting[i]->display_name);
 		if (ret)
 			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
-		if (ret)
-			goto fail_create_attr;
 	}
 
 	ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
@@ -1444,20 +1429,12 @@ static int tlmi_sysfs_init(void)
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
@@ -1465,29 +1442,17 @@ static int tlmi_sysfs_init(void)
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



