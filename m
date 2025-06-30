Return-Path: <stable+bounces-158986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4EAEE5E0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A9D3E0009
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357AF2E54DB;
	Mon, 30 Jun 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncVYymp4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531142E54D9;
	Mon, 30 Jun 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304720; cv=none; b=Z6X1XYKf5/nwVdKgXniT6pv9kEc0Pw8s07VaMtGrSSJP9HmiZRL1jMQN9CCzkGxmBGyalgkrPLmqpqrEVRpGmN/eQm2Kb2WPYZf8Q/XtaQetu23lYAjI85vj6xFPBXoBis0wIQjtMUYIRYg51X6CyaukyTsZRCHbsiker+Ra5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304720; c=relaxed/simple;
	bh=WhrQT0XcjA48So7VV8f3CLepQJj/6oaWUaubJg1pcSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQBAY+oFs0ukpkQMRcp0qMECQM2Y9z29l0gQlh3tdwZojKaEAGSlLQuwqhGwgKTtFymqG1Z4aw+UDqLBUootxLuqNx7bONybUgjKBdHGX3ZYWnEm+ebC+UhClDtuk7qo7QBm06Qa0KCE4vYRbKBEzpyqmBa6UY7Zt90yzUVudX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncVYymp4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a745fc9bafso67137091cf.1;
        Mon, 30 Jun 2025 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304715; x=1751909515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWYXpI/1WvU7LThqEa5N6KoGudK8x9uuTgmTBk7pvaA=;
        b=ncVYymp4wXA/n8XdK4wwNrvzGpuhBqcKFkz4mQSrvk1/95cW2Ovn2JsFpZiiC3sx6O
         0KFGVKJoKclt1bfyl5nY6+Fknmf9jjrVaA9zUUefeKn5Wc/PqZ3/e/RCyGhsgNoM1E7o
         zXRlOqUeaY+JlKVveuoVyqxdBLSQqqJuyQ6VzLZF32tB8HPerROCzfA3A3jXru3q9eqj
         fQAZip++ZOoG+T1GUK7tSe8cqVB7ODjbGD9xP3ccBv5prZhcBSoZpNdVGScSxQEb6BtB
         TLFCerd+36OAB6iRlfadvTKcE5etc6IV7zAWZ9X4HzgIlqqcywsm7rbQa8rWEQIzmilN
         3oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304715; x=1751909515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWYXpI/1WvU7LThqEa5N6KoGudK8x9uuTgmTBk7pvaA=;
        b=jRPxkXgLmOmBKRW/1zL0XtHK6D5rJIs/PXs/WeaOz9RxP110Yf7wz3mj5VvsBl1Y/y
         blz4B0d8yrCsVHiZAVY9FwflcjS7fOYT0eb3MQOv8qbdi+EhwxbCZvTO7uZs3XZYay9d
         gKnFKgvxOMHqQs8RTElieE1ShAxTEYUb/HcbFjyuFBdQ8rBgcbNNlKg1W5ueZhPAnVeR
         iJT3ZvO6vr0eWjCcDt+c6U7EgExS55h3P5g1OxFd9oyRl97LjEa3VX2CwNWM9oPVkfv6
         AX3QtbH58N06OasCCEg6YfNqtZWivgILUGRrPUOJCHPpi7R/7qTj8aHXk6Wh9nWk8c8j
         LuGg==
X-Forwarded-Encrypted: i=1; AJvYcCVfCXqcfFKqBfeZsCrZ+eMb44vLHKrB7YtFEKNgHeU6AOOMMQqetv4ulkTglfq4la/jQEp83Vxh6F5wTxY=@vger.kernel.org, AJvYcCW1EzzIG8zz/ZLoEmE2EQ4l5eyyLnZfFZSSV5Pj4uO6ZA/QO0ueNSaxaeaybL5Im9rNyYpVoBN0@vger.kernel.org
X-Gm-Message-State: AOJu0YxuStcxennxfL2ascMEyYLqDYGFhcUuoWmTdDrGdRxpHwa83wsO
	JQ/N5mN535iUd5Wx7uaKfdw+yxI9S4PwWONJHt4Db57G1j8DeaMTmbF2FMACClpi
X-Gm-Gg: ASbGncvdC1vdQDCDqs8jfB2IBmU++XzKWZrcH32f7EX4gyJKVv94MagXAUZg96B8XrV
	txUmCVZOZZE37pnyvMrOXFgRND7SHeepEL+EjxSLCW8OgD+kmVAF3Qd0s9SDYeyFajiv0GLfEyf
	FFqk0cI/fY/CAccmQJWTOe/UIos45KSFlcpku/IwtIdF0YYfar6bVMyOZL3K0ZA3JNpOfAzWKt0
	mRYVPMMTOrLY2BXTD/dLfCsFRnxpZJXbKQqFmNRtok0ck5OItQlwJo5FDMbuJkRIf72RciRe+ng
	oLs64JFWMZRN2pcoi+jDYc45sk6XWVZMOGA2UJqMtLEuZI6l0L40hxhAPAc/WA==
X-Google-Smtp-Source: AGHT+IG92KzcDWTz7z7ThEbKog2vKx31iUOwDYoOHxc6XaYUqLU4+lxJyyfelJpkUe4vY3ksx8Z/AA==
X-Received: by 2002:a05:622a:5143:b0:4a5:9993:ede8 with SMTP id d75a77b69052e-4a82eaa4ac3mr7688821cf.15.1751304714795;
        Mon, 30 Jun 2025 10:31:54 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fdadb11bsm59784521cf.17.2025.06.30.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:31:54 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 30 Jun 2025 14:31:20 -0300
Subject: [PATCH v3 2/3] platform/x86: think-lmi: Fix kobject cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-lmi-fix-v3-2-ce4f81c9c481@gmail.com>
References: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
In-Reply-To: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5846; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=WhrQT0XcjA48So7VV8f3CLepQJj/6oaWUaubJg1pcSI=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlJp5gLZvWIbDBa37WYl+mkuH++V9ULux0dH55/uXtse
 +cqzTdJHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRLw8Z/ilNld6Vp7F8X/XZ
 mo+aEsUNmZ/n20RoLjHoDrAtLTvw9zLDP1N98d933yc7eNw+m5JiY8YTvtKUdytjQ2joDrvfs5b
 mMwAA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

In tlmi_analyze(), allocated structs with an embedded kobject are freed
in error paths after the they were already initialized.

Fix this by first by avoiding the initialization of kobjects in
tlmi_analyze() and then by correctly cleaning them up in
tlmi_release_attr() using their kset's kobject list.

Cc: stable@vger.kernel.org
Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Fixes: 30e78435d3bf ("platform/x86: think-lmi: Split kobject_init() and kobject_add() calls")
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/think-lmi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 4c10a26e7e5e3471f286136d671606acf68b401e..3e5e6e6031efcefe6b3d31bc144e738599566d98 100644
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

-- 
2.50.0


