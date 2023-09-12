Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8378479AC8A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376538AbjIKWTy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbjIKORJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:17:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED2DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE333C433C8;
        Mon, 11 Sep 2023 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441825;
        bh=vvtmUvVj502ZIsFJKCxMcHZa9KsdzpCT+U+/LWVXV/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHKSGLYN9YIzA4ABesH0Cg6qvWRjSFxB3s2MKCEn5dLra3Mbq17uCobN6vCNq5mie
         jkpp2kpyGmCSh30LL4ZoB9Hk1DjKzZc4v/cHgXWxlxd55t62GYbokb4WEnPSuPo5IM
         cuPGGvnPdAbhdlcgd+OsahkztuuVPHJpH93C9yCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 523/739] platform/x86: dell-sysman: Fix reference leak
Date:   Mon, 11 Sep 2023 15:45:22 +0200
Message-ID: <20230911134705.722007633@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index b68dd11cb8924..b929b4f824205 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -393,6 +393,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	struct kobject *attr_name_kobj; //individual attribute names
 	union acpi_object *obj = NULL;
 	union acpi_object *elements;
+	struct kobject *duplicate;
 	struct kset *tmp_set;
 	int min_elements;
 
@@ -451,9 +452,11 @@ static int init_bios_attributes(int attr_type, const char *guid)
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



