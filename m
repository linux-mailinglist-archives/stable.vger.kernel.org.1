Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74875567B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjGPUvF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjGPUu5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C69E50
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C14160E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B3C433C8;
        Sun, 16 Jul 2023 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540655;
        bh=lBQ6TJfYY/Y2ncsGVWGMrT4UJaqd9eD6wPPUy3VLTYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJu2kOk68NUOXSotz95Cul1LD3eKyzQMe9gmfWhJuJOInRsbNnHXd5QXl8yu60uuT
         uNs9+sE6PKRiubXDBW8POCVwW4wbCfA4OrC0e92ZYKF2SwgZ/QNottuGZFqdm+xOzO
         x+LpCsxYV9273InNhWZJMuIM2DDaC2KKmyvh8f0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Kaehn <kaehndan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 441/591] device property: Clarify description of returned value in some functions
Date:   Sun, 16 Jul 2023 21:49:40 +0200
Message-ID: <20230716194935.320123022@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 295209ca7b5b3aa6375d6190311b2ae804dbcf65 ]

Some of the functions do not provide Return: section on absence of which
kernel-doc complains. Besides that several functions return the fwnode
handle with incremented reference count. Add a respective note to make sure
that the caller decrements it when it's not needed anymore.

While at it, unify the style of the Return: sections.

Reported-by: Daniel Kaehn <kaehndan@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20230217133344.79278-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 39d422555e43 ("drivers: fwnode: fix fwnode_irq_get[_byname]()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 124 +++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 34 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f2f7829ad36b9..868adeac2a843 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -30,6 +30,8 @@ EXPORT_SYMBOL_GPL(dev_fwnode);
  * @propname: Name of the property
  *
  * Check if property @propname is present in the device firmware description.
+ *
+ * Return: true if property @propname is present. Otherwise, returns false.
  */
 bool device_property_present(struct device *dev, const char *propname)
 {
@@ -41,6 +43,8 @@ EXPORT_SYMBOL_GPL(device_property_present);
  * fwnode_property_present - check if a property of a firmware node is present
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
+ *
+ * Return: true if property @propname is present. Otherwise, returns false.
  */
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname)
@@ -500,10 +504,10 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * Obtain a reference based on a named property in an fwnode, with
  * integer arguments.
  *
- * Caller is responsible to call fwnode_handle_put() on the returned
- * args->fwnode pointer.
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * @args->fwnode pointer.
  *
- * Returns: %0 on success
+ * Return: %0 on success
  *	    %-ENOENT when the index is out of bounds, the index has an empty
  *		     reference or the property was not found
  *	    %-EINVAL on parse error
@@ -539,8 +543,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
  *
  * @index can be used when the named reference holds a table of references.
  *
- * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
- * call fwnode_handle_put() on the returned fwnode pointer.
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: a pointer to the reference fwnode, when found. Otherwise,
+ * returns an error pointer.
  */
 struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
@@ -559,7 +566,7 @@ EXPORT_SYMBOL_GPL(fwnode_find_reference);
  * fwnode_get_name - Return the name of a node
  * @fwnode: The firmware node
  *
- * Returns a pointer to the node name.
+ * Return: a pointer to the node name, or %NULL.
  */
 const char *fwnode_get_name(const struct fwnode_handle *fwnode)
 {
@@ -571,7 +578,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_name);
  * fwnode_get_name_prefix - Return the prefix of node for printing purposes
  * @fwnode: The firmware node
  *
- * Returns the prefix of a node, intended to be printed right before the node.
+ * Return: the prefix of a node, intended to be printed right before the node.
  * The prefix works also as a separator between the nodes.
  */
 const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
@@ -583,7 +590,10 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
- * Return parent firmware node of the given node if possible or %NULL if no
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: parent firmware node of the given node if possible or %NULL if no
  * parent was available.
  */
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
@@ -600,8 +610,12 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
  * on the passed node, making it suitable for iterating through a
  * node's parents.
  *
- * Returns a node pointer with refcount incremented, use
- * fwnode_handle_put() on it when done.
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @fwnode
+ * unconditionally.
+ *
+ * Return: parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
  */
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 {
@@ -621,8 +635,10 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  * firmware node that has a corresponding struct device and returns that struct
  * device.
  *
- * The caller of this function is expected to call put_device() on the returned
- * device when they are done.
+ * The caller is responsible for calling put_device() on the returned device
+ * pointer.
+ *
+ * Return: a pointer to the device of the @fwnode's closest ancestor.
  */
 struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 {
@@ -643,7 +659,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
  *
- * Returns the number of parents a node has.
+ * Return: the number of parents a node has.
  */
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
 {
@@ -662,12 +678,12 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
  * @fwnode: The node the parent of which is requested
  * @depth: Distance of the parent from the node
  *
- * Returns the nth parent of a node. If there is no parent at the requested
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: the nth parent of a node. If there is no parent at the requested
  * @depth, %NULL is returned. If @depth is 0, the functionality is equivalent to
  * fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent() and so on.
- *
- * The caller is responsible for calling fwnode_handle_put() for the returned
- * node.
  */
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 					    unsigned int depth)
@@ -692,7 +708,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
  *
  * A node is considered an ancestor of itself too.
  *
- * Returns true if @ancestor is an ancestor of @child. Otherwise, returns false.
+ * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
  */
 bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
 {
@@ -717,6 +733,10 @@ bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @child
+ * unconditionally.
  */
 struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
@@ -727,10 +747,13 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
- * fwnode_get_next_available_child_node - Return the next
- * available child node handle for a node
+ * fwnode_get_next_available_child_node - Return the next available child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @child
+ * unconditionally.
  */
 struct fwnode_handle *
 fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
@@ -754,7 +777,11 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 /**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
- * @child: Handle to one of the device's child nodes or a null handle.
+ * @child: Handle to one of the device's child nodes or a %NULL handle.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @child
+ * unconditionally.
  */
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child)
@@ -779,6 +806,9 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
  * fwnode_get_named_child_node - Return first matching named child node handle
  * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
  */
 struct fwnode_handle *
 fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
@@ -792,6 +822,9 @@ EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
  * device_get_named_child_node - Return first matching named child node handle
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
  */
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname)
@@ -804,7 +837,10 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  * fwnode_handle_get - Obtain a reference to a device node
  * @fwnode: Pointer to the device node to obtain the reference to.
  *
- * Returns the fwnode handle.
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: the fwnode handle.
  */
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
 {
@@ -833,6 +869,8 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
  *
+ * Return: true if device is available for use. Otherwise, returns false.
+ *
  * For fwnode node types that don't implement the .device_is_available()
  * operation, this function returns true.
  */
@@ -851,6 +889,8 @@ EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 /**
  * device_get_child_node_count - return the number of child nodes for device
  * @dev: Device to cound the child nodes for
+ *
+ * Return: the number of child nodes for a given device.
  */
 unsigned int device_get_child_node_count(struct device *dev)
 {
@@ -926,7 +966,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
  * @fwnode:	Pointer to the firmware node
  * @index:	Index of the IO range
  *
- * Returns a pointer to the mapped memory.
+ * Return: a pointer to the mapped memory.
  */
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 {
@@ -939,8 +979,8 @@ EXPORT_SYMBOL(fwnode_iomap);
  * @fwnode:	Pointer to the firmware node
  * @index:	Zero-based index of the IRQ
  *
- * Returns Linux IRQ number on success. Other values are determined
- * accordingly to acpi_/of_ irq_get() operation.
+ * Return: Linux IRQ number on success. Other values are determined
+ * according to acpi_irq_get() or of_irq_get() operation.
  */
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
@@ -959,8 +999,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
  * number of the IRQ resource corresponding to the index of the matched
  * string.
  *
- * Return:
- * Linux IRQ number on success, or negative errno otherwise.
+ * Return: Linux IRQ number on success, or negative errno otherwise.
  */
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
 {
@@ -982,7 +1021,11 @@ EXPORT_SYMBOL(fwnode_irq_get_byname);
  * @fwnode: Pointer to the parent firmware node
  * @prev: Previous endpoint node or %NULL to get the first
  *
- * Returns an endpoint firmware node pointer or %NULL if no more endpoints
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @prev
+ * unconditionally.
+ *
+ * Return: an endpoint firmware node pointer or %NULL if no more endpoints
  * are available.
  */
 struct fwnode_handle *
@@ -1022,6 +1065,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
  * fwnode_graph_get_port_parent - Return the device fwnode of a port endpoint
  * @endpoint: Endpoint firmware node of the port
  *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
  * Return: the firmware node of the device the @endpoint belongs to.
  */
 struct fwnode_handle *
@@ -1043,6 +1089,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_port_parent);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote device the @fwnode points to.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(const struct fwnode_handle *fwnode)
@@ -1063,6 +1112,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote port the @fwnode points to.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_port(const struct fwnode_handle *fwnode)
@@ -1076,6 +1128,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote endpoint the @fwnode points to.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
@@ -1103,8 +1158,11 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  * @endpoint: identifier of the endpoint node under the port node
  * @flags: fwnode lookup flags
  *
- * Return the fwnode handle of the local endpoint corresponding the port and
- * endpoint IDs or NULL if not found.
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: the fwnode handle of the local endpoint corresponding the port and
+ * endpoint IDs or %NULL if not found.
  *
  * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
  * has not been found, look for the closest endpoint ID greater than the
@@ -1112,9 +1170,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  *
  * Does not return endpoints that belong to disabled devices or endpoints that
  * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
- *
- * The returned endpoint needs to be released by calling fwnode_handle_put() on
- * it when it is not needed any more.
  */
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
@@ -1320,7 +1375,8 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
  * @fwnode and other device nodes. @match will be used to convert the
  * connection description to data the caller is expecting to be returned
  * through the @matches array.
- * If @matches is NULL @matches_len is ignored and the total number of resolved
+ *
+ * If @matches is %NULL @matches_len is ignored and the total number of resolved
  * matches is returned.
  *
  * Return: Number of matches resolved, or negative errno.
-- 
2.39.2



