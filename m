Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE95979B66B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjIKWPk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbjIKOx7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6747E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B755C433C7;
        Mon, 11 Sep 2023 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444033;
        bh=OOYRjZXQug16bQQGEUKiZUmf+v+vywx4nqLVEZ2oHHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjGTWoDkvrx9i7Xt5r5gbRIXk9FxCLoot8cAPkdCUuhx2pjbLgsgHRIxpmYiUSjvE
         gaMqw/7bL8mlnN3ev4MsK4AEJVVAc7JsG6EAmRbkFeoaGN9hJ6c86jpA26+jHay50N
         Bd5cjJvv1Cb5RXCg3A66uQU9vREj0MwZhDwEBbrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 548/737] platform/x86: dell-sysman: Fix reference leak
Date:   Mon, 11 Sep 2023 15:46:47 +0200
Message-ID: <20230911134705.867524090@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 7295a996fdab7bf83dc3d4078fa8b139b8e0a1bf ]

If a duplicate attribute is found using kset_find_obj(),
a reference to that attribute is returned. This means
that we need to dispose it accordingly. Use kobject_put()
to dispose the duplicate attribute in such a case.

Compile-tested only.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20230805053610.7106-1-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 0285b47d99d13..1dd5aa37ecc8b 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -396,6 +396,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	struct kobject *attr_name_kobj; //individual attribute names
 	union acpi_object *obj = NULL;
 	union acpi_object *elements;
+	struct kobject *duplicate;
 	struct kset *tmp_set;
 	int min_elements;
 
@@ -454,9 +455,11 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		else
 			tmp_set = wmi_priv.main_dir_kset;
 
-		if (kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer)) {
-			pr_debug("duplicate attribute name found - %s\n",
-				elements[ATTR_NAME].string.pointer);
+		duplicate = kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer);
+		if (duplicate) {
+			pr_debug("Duplicate attribute name found - %s\n",
+				 elements[ATTR_NAME].string.pointer);
+			kobject_put(duplicate);
 			goto nextobj;
 		}
 
-- 
2.40.1



