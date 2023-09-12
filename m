Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4399F79B333
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379363AbjIKWnk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjIKPEu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:04:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8619125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C01AC433C7;
        Mon, 11 Sep 2023 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444685;
        bh=1m/PqfjixadJZ7stxRHVUJXRbO6KZj+sR/10bi/IMqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXtYl7iMU5uM+B3B20ASh+uwAcw8Buy7IuEM2CVEy2jznyixtwDKjMRFqcbev164U
         DTRKow3uBXkitdYN50/8meKJmqHS9yTaVmQrrra6A3XqpE5FDdqnlxbkvrbpOIjtUx
         Fv94yH3YT+Up4myEw87BXuJUcqF1tIyoD9GjynJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Adam Ford <aford173@gmail.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 6.1 078/600] of: property: Simplify of_link_to_phandle()
Date:   Mon, 11 Sep 2023 15:41:51 +0200
Message-ID: <20230911134635.916151126@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saravana Kannan <saravanak@google.com>

commit 4a032827daa89350365166b19d14d82fe8219128 upstream.

The driver core now:
- Has the parent device of a supplier pick up the consumers if the
  supplier never has a device created for it.
- Ignores a supplier if the supplier has no parent device and will never
  be probed by a driver

And already prevents creating a device link with the consumer as a
supplier of a parent.

So, we no longer need to find the "compatible" node of the supplier or
do any other checks in of_link_to_phandle(). We simply need to make sure
that the supplier is available in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcom/sm7225-fairphone-fp4
Link: https://lore.kernel.org/r/20230207014207.1678715-10-saravanak@google.com
Fixes: eaf9b5612a47 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Signed-off-by:  Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/property.c |   84 +++++++-------------------------------------------
 1 file changed, 13 insertions(+), 71 deletions(-)

--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1062,20 +1062,6 @@ of_fwnode_device_get_match_data(const st
 	return of_device_get_match_data(dev);
 }
 
-static bool of_is_ancestor_of(struct device_node *test_ancestor,
-			      struct device_node *child)
-{
-	of_node_get(child);
-	while (child) {
-		if (child == test_ancestor) {
-			of_node_put(child);
-			return true;
-		}
-		child = of_get_next_parent(child);
-	}
-	return false;
-}
-
 static struct device_node *of_get_compat_node(struct device_node *np)
 {
 	of_node_get(np);
@@ -1106,71 +1092,27 @@ static struct device_node *of_get_compat
 	return node;
 }
 
-/**
- * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
- * @con_np: consumer device tree node
- * @sup_np: supplier device tree node
- *
- * Given a phandle to a supplier device tree node (@sup_np), this function
- * finds the device that owns the supplier device tree node and creates a
- * device link from @dev consumer device to the supplier device. This function
- * doesn't create device links for invalid scenarios such as trying to create a
- * link with a parent device as the consumer of its child device. In such
- * cases, it returns an error.
- *
- * Returns:
- * - 0 if fwnode link successfully created to supplier
- * - -EINVAL if the supplier link is invalid and should not be created
- * - -ENODEV if struct device will never be create for supplier
- */
-static int of_link_to_phandle(struct device_node *con_np,
+static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np)
 {
-	struct device *sup_dev;
-	struct device_node *tmp_np = sup_np;
+	struct device_node *tmp_np = of_node_get(sup_np);
 
-	/*
-	 * Find the device node that contains the supplier phandle.  It may be
-	 * @sup_np or it may be an ancestor of @sup_np.
-	 */
-	sup_np = of_get_compat_node(sup_np);
-	if (!sup_np) {
-		pr_debug("Not linking %pOFP to %pOFP - No device\n",
-			 con_np, tmp_np);
-		return -ENODEV;
-	}
+	/* Check that sup_np and its ancestors are available. */
+	while (tmp_np) {
+		if (of_fwnode_handle(tmp_np)->dev) {
+			of_node_put(tmp_np);
+			break;
+		}
 
-	/*
-	 * Don't allow linking a device node as a consumer of one of its
-	 * descendant nodes. By definition, a child node can't be a functional
-	 * dependency for the parent node.
-	 */
-	if (of_is_ancestor_of(con_np, sup_np)) {
-		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -EINVAL;
-	}
+		if (!of_device_is_available(tmp_np)) {
+			of_node_put(tmp_np);
+			return;
+		}
 
-	/*
-	 * Don't create links to "early devices" that won't have struct devices
-	 * created for them.
-	 */
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	if (!sup_dev &&
-	    (of_node_check_flag(sup_np, OF_POPULATED) ||
-	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
-		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -ENODEV;
+		tmp_np = of_get_next_parent(tmp_np);
 	}
-	put_device(sup_dev);
 
 	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
-	of_node_put(sup_np);
-
-	return 0;
 }
 
 /**


