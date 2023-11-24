Return-Path: <stable+bounces-1374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0E7F7F58
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E096B21A6D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9222E858;
	Fri, 24 Nov 2023 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMDujDsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E4321AD;
	Fri, 24 Nov 2023 18:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45FC433C9;
	Fri, 24 Nov 2023 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851239;
	bh=0E6/P+oQZhavo2g35vyY1HSQVU7QFqYhzBBgFeuZCIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMDujDsXzKNTXgPjRSive0KBZ/LatGKpU5ValzGXQp1NguKSzIlh7S3fsklNATsoS
	 TxPf96uWOpO2pQ6P3SBEQ8JPTIJ10clNYu+wqWwm+F4lSBHkow5N3vJhNJ6DK+ftqp
	 ms4fd/BhMZXtWW6v3MDidlRheEJkDBA7p9Tg1i6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 369/491] of: dynamic: Add interfaces for creating device node dynamically
Date: Fri, 24 Nov 2023 17:50:05 +0000
Message-ID: <20231124172035.663205241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit b544fc2b8606d718d0cc788ff2ea2492871df488 ]

of_changeset_create_node() creates device node dynamically and attaches
the newly created node to a changeset.

Expand of_changeset APIs to handle specific types of properties.
    of_changeset_add_prop_string()
    of_changeset_add_prop_string_array()
    of_changeset_add_prop_u32_array()

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://lore.kernel.org/r/1692120000-46900-2-git-send-email-lizhi.hou@amd.com
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: c9260693aa0c ("PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/dynamic.c  | 164 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/unittest.c |  19 ++++-
 include/linux/of.h    |  23 ++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f7bb73cf821e6..cdad63ecb9023 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -486,6 +486,38 @@ struct device_node *__of_node_dup(const struct device_node *np,
 	return NULL;
 }
 
+/**
+ * of_changeset_create_node - Dynamically create a device node and attach to
+ * a given changeset.
+ *
+ * @ocs: Pointer to changeset
+ * @parent: Pointer to parent device node
+ * @full_name: Node full name
+ *
+ * Return: Pointer to the created device node or NULL in case of an error.
+ */
+struct device_node *of_changeset_create_node(struct of_changeset *ocs,
+					     struct device_node *parent,
+					     const char *full_name)
+{
+	struct device_node *np;
+	int ret;
+
+	np = __of_node_dup(NULL, full_name);
+	if (!np)
+		return NULL;
+	np->parent = parent;
+
+	ret = of_changeset_attach_node(ocs, np);
+	if (ret) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+EXPORT_SYMBOL(of_changeset_create_node);
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
@@ -947,3 +979,135 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_changeset_action);
+
+static int of_changeset_add_prop_helper(struct of_changeset *ocs,
+					struct device_node *np,
+					const struct property *pp)
+{
+	struct property *new_pp;
+	int ret;
+
+	new_pp = __of_prop_dup(pp, GFP_KERNEL);
+	if (!new_pp)
+		return -ENOMEM;
+
+	ret = of_changeset_add_property(ocs, np, new_pp);
+	if (ret) {
+		kfree(new_pp->name);
+		kfree(new_pp->value);
+		kfree(new_pp);
+	}
+
+	return ret;
+}
+
+/**
+ * of_changeset_add_prop_string - Add a string property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str:	pointer to null terminated string
+ *
+ * Create a string property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = strlen(str) + 1;
+	prop.value = (void *)str;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string);
+
+/**
+ * of_changeset_add_prop_string_array - Add a string list property to
+ * a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str_array:	pointer to an array of null terminated strings
+ * @sz:		number of string array elements
+ *
+ * Create a string list property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz)
+{
+	struct property prop;
+	int i, ret;
+	char *vp;
+
+	prop.name = (char *)prop_name;
+
+	prop.length = 0;
+	for (i = 0; i < sz; i++)
+		prop.length += strlen(str_array[i]) + 1;
+
+	prop.value = kmalloc(prop.length, GFP_KERNEL);
+	if (!prop.value)
+		return -ENOMEM;
+
+	vp = prop.value;
+	for (i = 0; i < sz; i++) {
+		vp += snprintf(vp, (char *)prop.value + prop.length - vp, "%s",
+			       str_array[i]) + 1;
+	}
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(prop.value);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string_array);
+
+/**
+ * of_changeset_add_prop_u32_array - Add a property of 32 bit integers
+ * property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @array:	pointer to an array of 32 bit integers
+ * @sz:		number of array elements
+ *
+ * Create a property of 32 bit integers and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz)
+{
+	struct property prop;
+	__be32 *val;
+	int i, ret;
+
+	val = kcalloc(sz, sizeof(__be32), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	for (i = 0; i < sz; i++)
+		val[i] = cpu_to_be32(array[i]);
+	prop.name = (char *)prop_name;
+	prop.length = sizeof(u32) * sz;
+	prop.value = (void *)val;
+
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f6784cce8369b..68e58b085c3db 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -802,7 +802,9 @@ static void __init of_unittest_changeset(void)
 	struct property *ppname_n21, pname_n21 = { .name = "name", .length = 3, .value = "n21" };
 	struct property *ppupdate, pupdate = { .name = "prop-update", .length = 5, .value = "abcd" };
 	struct property *ppremove;
-	struct device_node *n1, *n2, *n21, *nchangeset, *nremove, *parent, *np;
+	struct device_node *n1, *n2, *n21, *n22, *nchangeset, *nremove, *parent, *np;
+	static const char * const str_array[] = { "str1", "str2", "str3" };
+	const u32 u32_array[] = { 1, 2, 3 };
 	struct of_changeset chgset;
 
 	n1 = __of_node_dup(NULL, "n1");
@@ -857,6 +859,17 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop prop-add\n");
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
+	n22 = of_changeset_create_node(&chgset, n2, "n22");
+	unittest(n22, "fail create n22\n");
+	unittest(!of_changeset_add_prop_string(&chgset, n22, "prop-str", "abcd"),
+		 "fail add prop prop-str");
+	unittest(!of_changeset_add_prop_string_array(&chgset, n22, "prop-str-array",
+						     (const char **)str_array,
+						     ARRAY_SIZE(str_array)),
+		 "fail add prop prop-str-array");
+	unittest(!of_changeset_add_prop_u32_array(&chgset, n22, "prop-u32-array",
+						  u32_array, ARRAY_SIZE(u32_array)),
+		 "fail add prop prop-u32-array");
 
 	unittest(!of_changeset_apply(&chgset), "apply failed\n");
 
@@ -866,6 +879,9 @@ static void __init of_unittest_changeset(void)
 	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n21")),
 		 "'%pOF' not added\n", n21);
 	of_node_put(np);
+	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n22")),
+		 "'%pOF' not added\n", n22);
+	of_node_put(np);
 
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
@@ -874,6 +890,7 @@ static void __init of_unittest_changeset(void)
 	of_node_put(n1);
 	of_node_put(n2);
 	of_node_put(n21);
+	of_node_put(n22);
 #endif
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 6ecde0515677d..9b82a6b0f3f55 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1580,6 +1580,29 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_changeset_create_node(struct of_changeset *ocs,
+					     struct device_node *parent,
+					     const char *full_name);
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str);
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz);
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz);
+static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
+					    struct device_node *np,
+					    const char *prop_name,
+					    const u32 val)
+{
+	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
+}
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
-- 
2.42.0




