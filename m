Return-Path: <stable+bounces-163490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE9B0B9C6
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 03:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9907A7CB8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECEDA923;
	Mon, 21 Jul 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcTrItwr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4113B284
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753061434; cv=none; b=VsmByeADVmQhBfK+Y+H2Egw5vORhvIaNwW5I1+E81igYJN3+BbVewWShN6OzY3Z32SyiOAEe3mvWSBJ2QUcNUGcqnt1ahXdIRFMF433Ohv6gmfz117ckZ8EoKWE72NrMJWOZEgwU1esaq5Rfj8Fe6i4GVBF+n7IwJgzi7Gbgcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753061434; c=relaxed/simple;
	bh=o27m1NRPrP2Yp5M3IZ4sa/1jaSYIB+O/LADFhhMDomE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVLbke/l69zuDAQuOWlLaCgqdxoXLzMvAOBvSQ7HnWAb5LfqLt+RGrGzXdNja2pEkImfi5Q/IBSAHYrVWIMJLG6Q7Xr4/S/rN76pgsIQAF+DgAYRTjWhYeaRgYS/25Q6k3Y+LPre+GmMv9XTxZl44sQhPNeldEBcYCY8p0lAujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcTrItwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5CFC4CEE7;
	Mon, 21 Jul 2025 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753061433;
	bh=o27m1NRPrP2Yp5M3IZ4sa/1jaSYIB+O/LADFhhMDomE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcTrItwr/tyZ5vI3vDPJySPFJpz8ywYnhIkZcQ3b10kmFwyXnsog0YSzfa8uWyqWj
	 DSJ+Oh6oFKOSnTiGZt45bMRKI4Oei5WgX8sjoD4lNQ5ROXDhpJRQILK1XBqYm8tRfU
	 t8lFbzWA3rxm8OqyE8+wVAwGUqPfqv6+HHe87rhJQiFRlWqO1w5AZmxMuKMv9lrsJY
	 nieBbN9SoVmNO3WSAGP1tTZxwQmq1sWfrLh6Fb6o0jbt3f9jte1kAWwbFZGWkJFP8n
	 /xR/2DIz1HxKofc0c5R11RxHJ/WgUedRoBH1KN+va/XDtslO/EJ0X2EcoogoDIYcqZ
	 2U1WpBM4DibPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] platform/x86: think-lmi: Fix kobject cleanup
Date: Sun, 20 Jul 2025 21:30:26 -0400
Message-Id: <20250721013026.777897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070812-scorpion-thicken-4f6f@gregkh>
References: <2025070812-scorpion-thicken-4f6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit 9110056fe10b0519529bdbbac37311a5037ea0c2 ]

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
[ Adapted kobject cleanup to only pwd_admin and pwd_power password types present in 5.15. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 36ff64a7b6847..dde7bb7e28226 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -765,25 +765,31 @@ static struct kobj_attribute debug_cmd = __ATTR_WO(debug_cmd);
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
 	if (tlmi_priv.can_debug_cmd && debug_support)
 		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
+
+	list_for_each_entry_safe(pos, n, &tlmi_priv.attribute_kset->list, entry)
+		kobject_put(pos);
+
 	kset_unregister(tlmi_priv.attribute_kset);
 
 	/* Authentication structures */
 	sysfs_remove_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_admin->kobj);
 	sysfs_remove_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_power->kobj);
+
+	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)
+		kobject_put(pos);
+
 	kset_unregister(tlmi_priv.authentication_kset);
 }
 
@@ -851,8 +857,8 @@ static int tlmi_sysfs_init(void)
 
 		/* Build attribute */
 		tlmi_priv.setting[i]->kobj.kset = tlmi_priv.attribute_kset;
-		ret = kobject_add(&tlmi_priv.setting[i]->kobj, NULL,
-				  "%s", tlmi_priv.setting[i]->display_name);
+		ret = kobject_init_and_add(&tlmi_priv.setting[i]->kobj, &tlmi_attr_setting_ktype,
+					   NULL, "%s", tlmi_priv.setting[i]->display_name);
 		if (ret)
 			goto fail_create_attr;
 
@@ -872,7 +878,8 @@ static int tlmi_sysfs_init(void)
 	}
 	/* Create authentication entries */
 	tlmi_priv.pwd_admin->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_admin->kobj, NULL, "%s", "Admin");
+	ret = kobject_init_and_add(&tlmi_priv.pwd_admin->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Admin");
 	if (ret)
 		goto fail_create_attr;
 
@@ -881,7 +888,8 @@ static int tlmi_sysfs_init(void)
 		goto fail_create_attr;
 
 	tlmi_priv.pwd_power->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_power->kobj, NULL, "%s", "System");
+	ret = kobject_init_and_add(&tlmi_priv.pwd_power->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Power-on");
 	if (ret)
 		goto fail_create_attr;
 
@@ -995,7 +1003,6 @@ static int tlmi_analyze(void)
 		if (setting->possible_values)
 			strreplace(setting->possible_values, ',', ';');
 
-		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
 		tlmi_priv.setting[i] = setting;
 		kfree(item);
 	}
@@ -1021,8 +1028,6 @@ static int tlmi_analyze(void)
 	if (pwdcfg.password_state & TLMI_PAP_PWD)
 		tlmi_priv.pwd_admin->valid = true;
 
-	kobject_init(&tlmi_priv.pwd_admin->kobj, &tlmi_pwd_setting_ktype);
-
 	tlmi_priv.pwd_power = kzalloc(sizeof(struct tlmi_pwd_setting), GFP_KERNEL);
 	if (!tlmi_priv.pwd_power) {
 		ret = -ENOMEM;
@@ -1038,8 +1043,6 @@ static int tlmi_analyze(void)
 	if (pwdcfg.password_state & TLMI_POP_PWD)
 		tlmi_priv.pwd_power->valid = true;
 
-	kobject_init(&tlmi_priv.pwd_power->kobj, &tlmi_pwd_setting_ktype);
-
 	return 0;
 
 fail_free_pwd_admin:
-- 
2.39.5


