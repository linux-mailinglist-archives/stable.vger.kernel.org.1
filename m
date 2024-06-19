Return-Path: <stable+bounces-54528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B59C90EEAA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A78286E59
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266DE1422B8;
	Wed, 19 Jun 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FlSQc6mt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936C3C0B;
	Wed, 19 Jun 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803845; cv=none; b=GNPQEUg74N2gS2+ztHJamDK1Lc0C1hsfCVHN7jGhQxW96l0pscHFb8VhgmZObi+TFAMXd3obwEeJZiAv6P+2ZkPsRf8hCRsWnD1b5Ec0dDJ6UGYu56EdDbIYyuc4EPpZlaNk6XcivCA8FGk/DqD9Yt+d9XhMpA2PZIcHHmxMaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803845; c=relaxed/simple;
	bh=HxfdcwhK+hugaqUH/01ZGZWln7RAgpmvTPOyqjoNvYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIRn/Xvq+j3Lrhek0i0ifgOgut2DZK093KkycxeWd6qaCqyJ+L850/ZrlDYAnuJbMKBe2IujK2GMngmKjlyG0KUAnG02/+qsr7uPiP1jMATqUNDAcHyiUOZHMXaZFxJ5vKD7BxS+J1ZqbpLeFjfrf+dxMU5OVJHvBsPjGOY35+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FlSQc6mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60678C2BBFC;
	Wed, 19 Jun 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803845;
	bh=HxfdcwhK+hugaqUH/01ZGZWln7RAgpmvTPOyqjoNvYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlSQc6mthMkr2UfB1D/tIUpvHTt+0nbVVYA4s6ERVR4+zqxB8wN512EQcqUAmsx6h
	 UdsAiXT4fOeF3zGWAwFxNF+0sEG8hFSypNOJcfC0TLVbi9TBMdIdVMPhWWAYsMEi1E
	 JEx6RtgE0Z0ClVaFEhcwzx/7/VVdVyL3S5rdgegg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/217] platform/x86: dell-smbios: Fix wrong token data in sysfs
Date: Wed, 19 Jun 2024 14:56:06 +0200
Message-ID: <20240619125601.435578445@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 1981b296f858010eae409548fd297659b2cc570e ]

When reading token data from sysfs on my Inspiron 3505, the token
locations and values are wrong. This happens because match_attribute()
blindly assumes that all entries in da_tokens have an associated
entry in token_attrs.

This however is not true as soon as da_tokens[] contains zeroed
token entries. Those entries are being skipped when initialising
token_attrs, breaking the core assumption of match_attribute().

Fix this by defining an extra struct for each pair of token attributes
and use container_of() to retrieve token information.

Tested on a Dell Inspiron 3050.

Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240528204903.445546-1-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 92 ++++++++------------
 1 file changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index e61bfaf8b5c48..86b95206cb1bd 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/container_of.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/capability.h>
@@ -25,11 +26,16 @@ static u32 da_supported_commands;
 static int da_num_tokens;
 static struct platform_device *platform_device;
 static struct calling_interface_token *da_tokens;
-static struct device_attribute *token_location_attrs;
-static struct device_attribute *token_value_attrs;
+static struct token_sysfs_data *token_entries;
 static struct attribute **token_attrs;
 static DEFINE_MUTEX(smbios_mutex);
 
+struct token_sysfs_data {
+	struct device_attribute location_attr;
+	struct device_attribute value_attr;
+	struct calling_interface_token *token;
+};
+
 struct smbios_device {
 	struct list_head list;
 	struct device *device;
@@ -416,47 +422,26 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-static int match_attribute(struct device *dev,
-			   struct device_attribute *attr)
-{
-	int i;
-
-	for (i = 0; i < da_num_tokens * 2; i++) {
-		if (!token_attrs[i])
-			continue;
-		if (strcmp(token_attrs[i]->name, attr->attr.name) == 0)
-			return i/2;
-	}
-	dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
-	return -EINVAL;
-}
-
 static ssize_t location_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int i;
+	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, location_attr);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	i = match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].location);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->location);
 }
 
 static ssize_t value_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	int i;
+	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, value_attr);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	i = match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].value);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->value);
 }
 
 static struct attribute_group smbios_attribute_group = {
@@ -473,22 +458,15 @@ static int build_tokens_sysfs(struct platform_device *dev)
 {
 	char *location_name;
 	char *value_name;
-	size_t size;
 	int ret;
 	int i, j;
 
-	/* (number of tokens  + 1 for null terminated */
-	size = sizeof(struct device_attribute) * (da_num_tokens + 1);
-	token_location_attrs = kzalloc(size, GFP_KERNEL);
-	if (!token_location_attrs)
+	token_entries = kcalloc(da_num_tokens, sizeof(*token_entries), GFP_KERNEL);
+	if (!token_entries)
 		return -ENOMEM;
-	token_value_attrs = kzalloc(size, GFP_KERNEL);
-	if (!token_value_attrs)
-		goto out_allocate_value;
 
 	/* need to store both location and value + terminator*/
-	size = sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
-	token_attrs = kzalloc(size, GFP_KERNEL);
+	token_attrs = kcalloc((2 * da_num_tokens) + 1, sizeof(*token_attrs), GFP_KERNEL);
 	if (!token_attrs)
 		goto out_allocate_attrs;
 
@@ -496,27 +474,32 @@ static int build_tokens_sysfs(struct platform_device *dev)
 		/* skip empty */
 		if (da_tokens[i].tokenID == 0)
 			continue;
+
+		token_entries[i].token = &da_tokens[i];
+
 		/* add location */
 		location_name = kasprintf(GFP_KERNEL, "%04x_location",
 					  da_tokens[i].tokenID);
 		if (location_name == NULL)
 			goto out_unwind_strings;
-		sysfs_attr_init(&token_location_attrs[i].attr);
-		token_location_attrs[i].attr.name = location_name;
-		token_location_attrs[i].attr.mode = 0444;
-		token_location_attrs[i].show = location_show;
-		token_attrs[j++] = &token_location_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].location_attr.attr);
+		token_entries[i].location_attr.attr.name = location_name;
+		token_entries[i].location_attr.attr.mode = 0444;
+		token_entries[i].location_attr.show = location_show;
+		token_attrs[j++] = &token_entries[i].location_attr.attr;
 
 		/* add value */
 		value_name = kasprintf(GFP_KERNEL, "%04x_value",
 				       da_tokens[i].tokenID);
 		if (value_name == NULL)
 			goto loop_fail_create_value;
-		sysfs_attr_init(&token_value_attrs[i].attr);
-		token_value_attrs[i].attr.name = value_name;
-		token_value_attrs[i].attr.mode = 0444;
-		token_value_attrs[i].show = value_show;
-		token_attrs[j++] = &token_value_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].value_attr.attr);
+		token_entries[i].value_attr.attr.name = value_name;
+		token_entries[i].value_attr.attr.mode = 0444;
+		token_entries[i].value_attr.show = value_show;
+		token_attrs[j++] = &token_entries[i].value_attr.attr;
 		continue;
 
 loop_fail_create_value:
@@ -532,14 +515,12 @@ static int build_tokens_sysfs(struct platform_device *dev)
 
 out_unwind_strings:
 	while (i--) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
 out_allocate_attrs:
-	kfree(token_value_attrs);
-out_allocate_value:
-	kfree(token_location_attrs);
+	kfree(token_entries);
 
 	return -ENOMEM;
 }
@@ -551,12 +532,11 @@ static void free_group(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj,
 				&smbios_attribute_group);
 	for (i = 0; i < da_num_tokens; i++) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
-	kfree(token_value_attrs);
-	kfree(token_location_attrs);
+	kfree(token_entries);
 }
 
 static int __init dell_smbios_init(void)
-- 
2.43.0




