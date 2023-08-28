Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00078AA9F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjH1KXv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjH1KXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A489C6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD7E639AE
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE7C433C7;
        Mon, 28 Aug 2023 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218198;
        bh=KEzcA3zzAPkg1zCndN9bX2hk+KFD8m8pyxOuZxd8quY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj3Hk/GW+Y4I9WGnUP7M3Dx+6qT7kU3QZ6Bej1b3lyIQb6NvdwHEhds30IAR2cChF
         gRIc4g/ata0bpcFzIUwiLiFmRqYuoAF1ULGaombzFR8VUaqf4Dn1ghDZ6VvrERFGUp
         Dof5fqDaOukqgDNAhgYUMVpwRpJiphwrA7ee/lYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 6.4 104/129] of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
Date:   Mon, 28 Aug 2023 12:13:03 +0200
Message-ID: <20230828101200.825910842@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit 914d9d831e6126a6e7a92e27fcfaa250671be42c upstream.

While originally it was fine to format strings using "%pOF" while
holding devtree_lock, this now causes a deadlock.  Lockdep reports:

    of_get_parent from of_fwnode_get_parent+0x18/0x24
    ^^^^^^^^^^^^^
    of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
    fwnode_count_parents from fwnode_full_name_string+0x18/0xac
    fwnode_full_name_string from device_node_string+0x1a0/0x404
    device_node_string from pointer+0x3c0/0x534
    pointer from vsnprintf+0x248/0x36c
    vsnprintf from vprintk_store+0x130/0x3b4

Fix this by moving the printing in __of_changeset_entry_apply() outside
the lock. As the only difference in the multiple prints is the action
name, use the existing "action_names" to refactor the prints into a
single print.

Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
Cc: stable@vger.kernel.org
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230801-dt-changeset-fixes-v3-2-5f0410e007dd@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/dynamic.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -63,15 +63,14 @@ int of_reconfig_notifier_unregister(stru
 }
 EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
-#ifdef DEBUG
-const char *action_names[] = {
+static const char *action_names[] = {
+	[0] = "INVALID",
 	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
 	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
 	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
 	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
-#endif
 
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
@@ -620,21 +619,9 @@ static int __of_changeset_entry_apply(st
 		}
 
 		ret = __of_add_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: add_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	case OF_RECONFIG_REMOVE_PROPERTY:
 		ret = __of_remove_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: remove_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 
 	case OF_RECONFIG_UPDATE_PROPERTY:
@@ -648,20 +635,17 @@ static int __of_changeset_entry_apply(st
 		}
 
 		ret = __of_update_property(ce->np, ce->prop, &old_prop);
-		if (ret) {
-			pr_err("changeset: update_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	default:
 		ret = -EINVAL;
 	}
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
-	if (ret)
+	if (ret) {
+		pr_err("changeset: apply failed: %-15s %pOF:%s\n",
+		       action_names[ce->action], ce->np, ce->prop->name);
 		return ret;
+	}
 
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
@@ -947,6 +931,9 @@ int of_changeset_action(struct of_change
 	if (!ce)
 		return -ENOMEM;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);


