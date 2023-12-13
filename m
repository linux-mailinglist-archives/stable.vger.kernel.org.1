Return-Path: <stable+bounces-5862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4F880D78D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BB81F21BBF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FDF54F98;
	Mon, 11 Dec 2023 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zvj9O8cP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3853E0A;
	Mon, 11 Dec 2023 18:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594E8C433C8;
	Mon, 11 Dec 2023 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319867;
	bh=0OW3qCUu0bqrgsUoLVfAnVhYnTgk1nO5sP//wdTm5r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zvj9O8cPIYm+L2VzuEANjMuSdCvdeuS6IqDyZq5ZzxFG3GttQzYfMYmxxy+tkeqRc
	 U+bpV7+QXBvMnM/Aq6Du/zcoXYsF5AmeEDiK2CW4CaDiIrdfWYkLQDjXhECmN2g0gZ
	 lotK6k0oc/ixIsOnZ43uCkFXhubozqiJhNw0Ul1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Rowand <frowand.list@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 18/97] of: Fix kerneldoc output formatting
Date: Mon, 11 Dec 2023 19:21:21 +0100
Message-ID: <20231211182020.581183786@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 62f026f082e4d762a47b43ea693b38f025122332 ]

The indentation of the kerneldoc comments affects the output formatting.
Leading tabs in particular don't work, sections need to be indented
under the section header, and several code blocks are reformatted.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Link: https://lore.kernel.org/r/20210326192606.3702739-1-robh@kernel.org
Stable-dep-of: d79972789d17 ("of: dynamic: Fix of_reconfig_get_state_change() return value documentation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c | 275 +++++++++++++++++++++++-----------------------
 drivers/of/fdt.c  |   9 +-
 2 files changed, 141 insertions(+), 143 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index fa45a681267cd..85a55cfd00f11 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -651,11 +651,11 @@ bool of_device_is_big_endian(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_big_endian);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
+ * of_get_parent - Get a node's parent if any
+ * @node:	Node to get parent
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -673,15 +673,15 @@ struct device_node *of_get_parent(const struct device_node *node)
 EXPORT_SYMBOL(of_get_parent);
 
 /**
- *	of_get_next_parent - Iterate to a node's parent
- *	@node:	Node to get parent of
+ * of_get_next_parent - Iterate to a node's parent
+ * @node:	Node to get parent of
  *
- *	This is like of_get_parent() except that it drops the
- *	refcount on the passed node, making it suitable for iterating
- *	through a node's parents.
+ * This is like of_get_parent() except that it drops the
+ * refcount on the passed node, making it suitable for iterating
+ * through a node's parents.
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_next_parent(struct device_node *node)
 {
@@ -719,13 +719,13 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
 	     child = __of_get_next_child(parent, child))
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_child - Iterate a node childs
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *	Returns a node pointer with refcount incremented, use of_node_put() on
- *	it when done. Returns NULL when prev is the last child. Decrements the
- *	refcount of prev.
+ * Return: A node pointer with refcount incremented, use of_node_put() on
+ * it when done. Returns NULL when prev is the last child. Decrements the
+ * refcount of prev.
  */
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
@@ -741,12 +741,12 @@ struct device_node *of_get_next_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_child);
 
 /**
- *	of_get_next_available_child - Find the next available child node
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_available_child - Find the next available child node
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *      This function is like of_get_next_child(), except that it
- *      automatically skips any disabled nodes (i.e. status = "disabled").
+ * This function is like of_get_next_child(), except that it
+ * automatically skips any disabled nodes (i.e. status = "disabled").
  */
 struct device_node *of_get_next_available_child(const struct device_node *node,
 	struct device_node *prev)
@@ -772,12 +772,12 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
- *	of_get_next_cpu_node - Iterate on cpu nodes
- *	@prev:	previous child of the /cpus node, or NULL to get first
+ * of_get_next_cpu_node - Iterate on cpu nodes
+ * @prev:	previous child of the /cpus node, or NULL to get first
  *
- *	Returns a cpu node pointer with refcount incremented, use of_node_put()
- *	on it when done. Returns NULL when prev is the last child. Decrements
- *	the refcount of prev.
+ * Return: A cpu node pointer with refcount incremented, use of_node_put()
+ * on it when done. Returns NULL when prev is the last child. Decrements
+ * the refcount of prev.
  */
 struct device_node *of_get_next_cpu_node(struct device_node *prev)
 {
@@ -834,15 +834,15 @@ struct device_node *of_get_compatible_child(const struct device_node *parent,
 EXPORT_SYMBOL(of_get_compatible_child);
 
 /**
- *	of_get_child_by_name - Find the child node by name for a given parent
- *	@node:	parent node
- *	@name:	child name to look for.
+ * of_get_child_by_name - Find the child node by name for a given parent
+ * @node:	parent node
+ * @name:	child name to look for.
  *
- *      This function looks for child node for given matching name
+ * This function looks for child node for given matching name
  *
- *	Returns a node pointer if found, with refcount incremented, use
- *	of_node_put() on it when done.
- *	Returns NULL if node is not found.
+ * Return: A node pointer if found, with refcount incremented, use
+ * of_node_put() on it when done.
+ * Returns NULL if node is not found.
  */
 struct device_node *of_get_child_by_name(const struct device_node *node,
 				const char *name)
@@ -893,22 +893,22 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 }
 
 /**
- *	of_find_node_opts_by_path - Find a node matching a full OF path
- *	@path: Either the full path to match, or if the path does not
- *	       start with '/', the name of a property of the /aliases
- *	       node (an alias).  In the case of an alias, the node
- *	       matching the alias' value will be returned.
- *	@opts: Address of a pointer into which to store the start of
- *	       an options string appended to the end of the path with
- *	       a ':' separator.
- *
- *	Valid paths:
- *		/foo/bar	Full path
- *		foo		Valid alias
- *		foo/bar		Valid alias + relative path
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_opts_by_path - Find a node matching a full OF path
+ * @path: Either the full path to match, or if the path does not
+ *       start with '/', the name of a property of the /aliases
+ *       node (an alias).  In the case of an alias, the node
+ *       matching the alias' value will be returned.
+ * @opts: Address of a pointer into which to store the start of
+ *       an options string appended to the end of the path with
+ *       a ':' separator.
+ *
+ * Valid paths:
+ *  * /foo/bar	Full path
+ *  * foo	Valid alias
+ *  * foo/bar	Valid alias + relative path
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
 {
@@ -958,15 +958,15 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 EXPORT_SYMBOL(of_find_node_opts_by_path);
 
 /**
- *	of_find_node_by_name - Find a node by its "name" property
- *	@from:	The node to start searching from or NULL; the node
+ * of_find_node_by_name - Find a node by its "name" property
+ * @from:	The node to start searching from or NULL; the node
  *		you pass will not be searched, only the next one
  *		will. Typically, you pass what the previous call
  *		returned. of_node_put() will be called on @from.
- *	@name:	The name string to match against
+ * @name:	The name string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -985,16 +985,16 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_name);
 
 /**
- *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from, or NULL to start searching
+ * of_find_node_by_type - Find a node by its "device_type" property
+ * @from:	The node to start searching from, or NULL to start searching
  *		the entire device tree. The node you pass will not be
  *		searched, only the next one will; typically, you pass
  *		what the previous call returned. of_node_put() will be
  *		called on from for you.
- *	@type:	The type string to match against
+ * @type:	The type string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_type(struct device_node *from,
 	const char *type)
@@ -1013,18 +1013,18 @@ struct device_node *of_find_node_by_type(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_type);
 
 /**
- *	of_find_compatible_node - Find a node based on type and one of the
+ * of_find_compatible_node - Find a node based on type and one of the
  *                                tokens in its "compatible" property
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@type:		The type string to match "device_type" or NULL to ignore
- *	@compatible:	The string to match to one of the tokens in the device
- *			"compatible" list.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @type:	The type string to match "device_type" or NULL to ignore
+ * @compatible:	The string to match to one of the tokens in the device
+ *		"compatible" list.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_compatible_node(struct device_node *from,
 	const char *type, const char *compatible)
@@ -1044,16 +1044,16 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 EXPORT_SYMBOL(of_find_compatible_node);
 
 /**
- *	of_find_node_with_property - Find a node which has a property with
- *                                   the given name.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@prop_name:	The name of the property to look for.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_with_property - Find a node which has a property with
+ *                              the given name.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @prop_name:	The name of the property to look for.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
@@ -1102,10 +1102,10 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- *	@matches:	array of of device match structures to search in
- *	@node:		the of device structure to match against
+ * @matches:	array of of device match structures to search in
+ * @node:	the of device structure to match against
  *
- *	Low level utility function used by device matching.
+ * Low level utility function used by device matching.
  */
 const struct of_device_id *of_match_node(const struct of_device_id *matches,
 					 const struct device_node *node)
@@ -1121,17 +1121,17 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 EXPORT_SYMBOL(of_match_node);
 
 /**
- *	of_find_matching_node_and_match - Find a node based on an of_device_id
- *					  match table.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@matches:	array of of device match structures to search in
- *	@match:		Updated to point at the matches entry which matched
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_matching_node_and_match - Find a node based on an of_device_id
+ *				     match table.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @matches:	array of of device match structures to search in
+ * @match:	Updated to point at the matches entry which matched
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_matching_node_and_match(struct device_node *from,
 					const struct of_device_id *matches,
@@ -1465,21 +1465,21 @@ EXPORT_SYMBOL(of_parse_phandle);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
+ *  phandle1: node1 {
  *	#list-cells = <2>;
- * }
+ *  };
  *
- * phandle2: node2 {
+ *  phandle2: node2 {
  *	#list-cells = <1>;
- * }
+ *  };
  *
- * node3 {
+ *  node3 {
  *	list = <&phandle1 1 2 &phandle2 3>;
- * }
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
@@ -1517,29 +1517,29 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- *	#list-cells = <2>;
- * }
+ *  phandle1: node1 {
+ *  	#list-cells = <2>;
+ *  };
  *
- * phandle2: node2 {
- *	#list-cells = <1>;
- * }
+ *  phandle2: node2 {
+ *  	#list-cells = <1>;
+ *  };
  *
- * phandle3: node3 {
- * 	#list-cells = <1>;
- * 	list-map = <0 &phandle2 3>,
- * 		   <1 &phandle2 2>,
- * 		   <2 &phandle1 5 1>;
- *	list-map-mask = <0x3>;
- * };
+ *  phandle3: node3 {
+ *  	#list-cells = <1>;
+ *  	list-map = <0 &phandle2 3>,
+ *  		   <1 &phandle2 2>,
+ *  		   <2 &phandle1 5 1>;
+ *  	list-map-mask = <0x3>;
+ *  };
  *
- * node4 {
- *	list = <&phandle1 1 2 &phandle3 0>;
- * }
+ *  node4 {
+ *  	list = <&phandle1 1 2 &phandle3 0>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
  */
 int of_parse_phandle_with_args_map(const struct device_node *np,
@@ -1699,19 +1699,19 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- * }
+ *  phandle1: node1 {
+ *  };
  *
- * phandle2: node2 {
- * }
+ *  phandle2: node2 {
+ *  };
  *
- * node3 {
- *	list = <&phandle1 0 2 &phandle2 2 3>;
- * }
+ *  node3 {
+ *  	list = <&phandle1 0 2 &phandle2 2 3>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
@@ -1957,13 +1957,12 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 
 /**
  * of_alias_scan - Scan all properties of the 'aliases' node
+ * @dt_alloc:	An allocator that provides a virtual address to memory
+ *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
  * the global lookup table with the properties.  It returns the
  * number of alias properties found, or an error code in case of failure.
- *
- * @dt_alloc:	An allocator that provides a virtual address to memory
- *		for storing the resulting tree
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
@@ -2158,12 +2157,12 @@ bool of_console_check(struct device_node *dn, char *name, int index)
 EXPORT_SYMBOL_GPL(of_console_check);
 
 /**
- *	of_find_next_cache_node - Find a node's subsidiary cache
- *	@np:	node of type "cpu" or "cache"
+ * of_find_next_cache_node - Find a node's subsidiary cache
+ * @np:	node of type "cpu" or "cache"
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.  Caller should hold a reference
- *	to np.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.  Caller should hold a reference
+ * to np.
  */
 struct device_node *of_find_next_cache_node(const struct device_node *np)
 {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 5a1b8688b4605..81e03bd896751 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -349,11 +349,6 @@ static int unflatten_dt_nodes(const void *blob,
 
 /**
  * __unflatten_device_tree - create tree of device_nodes from flat blob
- *
- * unflattens a device-tree, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used.
  * @blob: The blob to expand
  * @dad: Parent device node
  * @mynodes: The device_node tree created by the call
@@ -361,6 +356,10 @@ static int unflatten_dt_nodes(const void *blob,
  * for the resulting tree
  * @detached: if true set OF_DETACHED on @mynodes
  *
+ * unflattens a device-tree, creating the tree of struct device_node. It also
+ * fills the "name" and "type" pointers of the nodes so the normal device-tree
+ * walking functions can be used.
+ *
  * Returns NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
-- 
2.42.0




