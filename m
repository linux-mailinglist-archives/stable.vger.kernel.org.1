Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BA74C3A7
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGILeo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjGILen (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8418F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89DFB60BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B13C433C8;
        Sun,  9 Jul 2023 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902481;
        bh=i9LECIh5CVhsss1UjbHzW4V7tGoX1gPjVLyuYAmd2j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tF+FAYlZ5iBH9Tnxot2eGiq6OhKWZVLAsjjlw02n31Ae9xSlOXIw2KMItUbCGA3jA
         EtKrLAnFia2/NOVurUk/lIQqxA0Seb7q9baM0UQr0a86PcovvmV1HJ2O7q1aLnMxNV
         JZqhbgU0hDG59uKeJifiQcT9pHkjd1w37VO6dtc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 364/431] platform/x86: think-lmi: mutex protection around multiple WMI calls
Date:   Sun,  9 Jul 2023 13:15:12 +0200
Message-ID: <20230709111459.702952694@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit c41e0121a1221894a1a9c4666156db9e1def4d6c ]

When an attribute is being changed if the Admin account is enabled, or if
a password is being updated then multiple WMI calls are needed.
Add mutex protection to ensure no race conditions are introduced.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230601200552.4396-1-mpearson-lenovo@squebb.ca
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 78dc82bda4dde..7a145f578ef49 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
@@ -195,6 +196,7 @@ static const char * const level_options[] = {
 };
 static struct think_lmi tlmi_priv;
 static struct class *fw_attr_class;
+static DEFINE_MUTEX(tlmi_mutex);
 
 /* ------ Utility functions ------------*/
 /* Strip out CR if one is present */
@@ -437,6 +439,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 	/* Strip out CR if one is present, setting password won't work if it is present */
 	strip_cr(new_pwd);
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	pwdlen = strlen(new_pwd);
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen))) {
@@ -493,6 +498,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 		kfree(auth_str);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(new_pwd);
 	return ret ?: count;
 }
@@ -982,6 +988,9 @@ static ssize_t current_value_store(struct kobject *kobj,
 	/* Strip out CR if one is present */
 	strip_cr(new_setting);
 
+	/* Use lock in case multiple WMI operations needed */
+	mutex_lock(&tlmi_mutex);
+
 	/* Check if certificate authentication is enabled and active */
 	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
 		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
@@ -1040,6 +1049,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
 	}
 out:
+	mutex_unlock(&tlmi_mutex);
 	kfree(auth_str);
 	kfree(set_str);
 	kfree(new_setting);
-- 
2.39.2



