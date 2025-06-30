Return-Path: <stable+bounces-158987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B7AEE5E5
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADD91BC0BC3
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613F2E6125;
	Mon, 30 Jun 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys7g7dDU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CB19CC29;
	Mon, 30 Jun 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304720; cv=none; b=od4XuG6/bmFdLReBZEKfnU81VmIB0Ku2kd2MFvhvRVOk68hj1av7Yl3hwPngTeccJg/tuaZ2oI8f17hlykTSIReMSOKYsSvv4r8AADn77jKmXHJe74KRg+pfdf36fa7WOE6h27BvUbLvqdWWsOrV1ySDMxNvAH48mNLd5cpihLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304720; c=relaxed/simple;
	bh=ZURlPW2Su3bhWmXhsJ5JPtUvI0sHbLz04Z8qD3gPWwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6J8LFd2TrXSIyiBBO5iAIORJdzRfe38PuFtzg6GBRJNNMGBdxh6IP2oBWglg9wSco2plW5QUQdzWsyO4u1RIT4m4f5PnZUVdH8Qi/nDlxE3gXGPwohbgqdZ5IzkALJu877YJZ52wT8WVEICEpNhedxcZvvPY2YEr5bLexVfbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys7g7dDU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a752944794so55029071cf.3;
        Mon, 30 Jun 2025 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304717; x=1751909517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XyHKWfXiT73L/YJwJtLTidOp8ZtTUUZ7vQ8/O4IC6M=;
        b=Ys7g7dDU8y88S88k0nmzf0CkhRzvf6wGUpwUtNcc7/XZarG57tsu317I72bUwcVo0o
         I8T9YT8AURo+7dX8uZ1brGsxlFZ1g5/NLbWNNSMRDU8EhKSRv839UvaAeCGw8yIgPesQ
         XkUnuBdYZ9bbfgIfyFhRUWE0E7Y85yrRuryyuWNz3vdUJyGawGKDuzSPsH1e1g4xRKAN
         PwK1gTpp055EharZ3iWT/C4yTw9ZA86SS9a0VZThY2jXnqkRaeqXT5PjtFv29rxPXifR
         5OoP0xa90TdUUUR4qsa9UAGSlKwnEv7tWsOIhfPSj7ECxD6runMzJFXDisKUMseIRG1Z
         3/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304717; x=1751909517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XyHKWfXiT73L/YJwJtLTidOp8ZtTUUZ7vQ8/O4IC6M=;
        b=HVE7JfGel61WzizK43puQ4wjcFq+K3JEW2btNYRj7Gwtnlr40DE9fnUx8lT60YSgL+
         eU44o4mNWaBNUg5R0Mpk3whIKTV6hSt6loAbTwbCjHrq3+OONNEmCJuUSqHTt+apadj7
         C0BKN7RI7CoBrDyFRN/RGs/+OgwlWGxQeUA9JGgqdF+B50IBVKftJK7krk8edYNCQ48K
         EEsR0P2bVuftQXUVwAIH0P7uPYwww8RQrAgZJBkeLejJFH49ePp1AhxucmLkvi8iklu4
         TmACMYtq7LuZOLL+gO3KubQXKUh2qaPvYrPuQUOExgFfIMgZdcyjjwoV0TtBJU4CRKBA
         JGiA==
X-Forwarded-Encrypted: i=1; AJvYcCW0WTz16BgxHg64swvdf9YIBSJrAoTuWbBDtRmixX2pHYBYUZngL7RZwc5kftCm1ctxGzttVZppgkAK5AE=@vger.kernel.org, AJvYcCWMBBYyPKSObQiAbxm2E0TbEWdZU4D3A4KurieNmg+buPGwZ8RUnS1OqdmlMO28H1+xBilJC3qv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0otyarWttgsSb9xo48KsFkr0qQdWzt/+40/L4ae6CupCGzUi
	ru2wbk4ccL4u77kNiuFpSCmXgz1f4bm4DiTNSmOhGOu7ZQ9kHvFWfa3kFemPL2nx
X-Gm-Gg: ASbGncv5+9HAZHf6oWFsHeookAVZtPOXTWfLDhPUURT4H9rnwkFxDww4Ozzjlzjj9s6
	+AwecUKpJ6PzJTPgzW0li1o5IIKiSIceFz40G3cuoCLxf+/wAHr6E9HXO05ul+6MqlPuZm1PHVc
	WX1U6BVm7lVY0ON25Cuq5nn/QFe+lZW20JhfVRU1PHZzocVdC1UgrOCjl2VhfzydOxeeDW7c/xS
	1auozeVIAJ9vIeKCBaIu6iZ2sZDVq6sYg4kRnZZh95r41ORY1bRuBaEn1poDZijHNmivEasX8s9
	e/9QWKWrwIt1vRbH/CvXGU3sl7J/Mqx0EVys1m7T9UYsyugA7XXhjZJwaAZtUg==
X-Google-Smtp-Source: AGHT+IGkuOjju5AuPtd/cJ1gTcI5SpsR41Hyu6T1TxW+PRwPKPth4lKNdSMaaT9esOCSEaX3+1gKLw==
X-Received: by 2002:a05:622a:30d:b0:494:a2b8:88f0 with SMTP id d75a77b69052e-4a7fcab19cbmr220357751cf.33.1751304717324;
        Mon, 30 Jun 2025 10:31:57 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fdadb11bsm59784521cf.17.2025.06.30.10.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:31:57 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 30 Jun 2025 14:31:21 -0300
Subject: [PATCH v3 3/3] platform/x86: think-lmi: Fix sysfs group cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-lmi-fix-v3-3-ce4f81c9c481@gmail.com>
References: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
In-Reply-To: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5264; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ZURlPW2Su3bhWmXhsJ5JPtUvI0sHbLz04Z8qD3gPWwA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlJp5jlxSzfsrh8unrZ1V5/499Sru+Cgvdjzh5K7E76O
 2nD3RTGjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIpOmMDDearsq9KU5WeS3w
 xe+Xm/27jo3nLfZemDwv+T9DgT9nbycjw35f74R5XyYGpl7tv2gS3BZnppqg/yRA3ynHgPfjO5l
 4HgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Many error paths in tlmi_sysfs_init() lead to sysfs groups being removed
when they were not even created.

Fix this by letting the kobject core manage these groups through their
kobj_type's defult_groups.

Cc: stable@vger.kernel.org
Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/think-lmi.c | 43 ++++------------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3e5e6e6031efcefe6b3d31bc144e738599566d98..ca8498f8b831ae5d5c1dcb3f0585e748975dd2c7 100644
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

-- 
2.50.0


