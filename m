Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192D779D5B
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 07:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHLFwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 01:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLFwe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 01:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF972712
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 22:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF496149D
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 05:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C45DC433C8;
        Sat, 12 Aug 2023 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691819551;
        bh=aGL8QAeLVDNp+O6ihOU9SFyaVtjMXtol03f8c2rUFRE=;
        h=Subject:To:Cc:From:Date:From;
        b=PncL40UT7/PnRJNXIcTBGWnD/PdpiREwg6546Xg5olNRBGp1qeRNAGCI+ar2tqpYs
         94t+D+BzJstpmw9j+jJETD4QutwXcTKVWnxzExEK81ot6rC2Rt5ksJDcqgGocmBSuz
         6mNrt1eRZgtQ+gfpvYuNK1vm7U9I1+SqmbmQU+BE=
Subject: FAILED: patch "[PATCH] net: mana: Fix MANA VF unload when hardware is unresponsive" failed to apply to 5.15-stable tree
To:     schakrabarti@linux.microsoft.com, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 07:52:27 +0200
Message-ID: <2023081227-rogue-smasher-f54b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a7dfeda6fdeccab4c7c3dce9a72c4262b9530c80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081227-rogue-smasher-f54b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a7dfeda6fdec ("net: mana: Fix MANA VF unload when hardware is unresponsive")
1566e7d6206f ("net: mana: Add the Linux MANA PF driver")
ed5356b53f07 ("net: mana: Add XDP support")
635096a86edb ("net: mana: Support hibernation and kexec")
62ea8b77ed3b ("net: mana: Improve the HWC error handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7dfeda6fdeccab4c7c3dce9a72c4262b9530c80 Mon Sep 17 00:00:00 2001
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Date: Wed, 9 Aug 2023 03:22:05 -0700
Subject: [PATCH] net: mana: Fix MANA VF unload when hardware is unresponsive

When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
hardware to complete any inflight packets and set the pending send count
to zero. But if the hardware has failed, mana_dealloc_queues()
could wait forever.

Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
which is a somewhat arbitrary value that is more than long enough for
functional hardware to complete any sends.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Link: https://lore.kernel.org/r/1691576525-24271-1-git-send-email-schakrabarti@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a499e460594b..c2ad0921e893 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -8,6 +8,7 @@
 #include <linux/ethtool.h>
 #include <linux/filter.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
@@ -2345,9 +2346,12 @@ int mana_attach(struct net_device *ndev)
 static int mana_dealloc_queues(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
+	unsigned long timeout = jiffies + 120 * HZ;
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_txq *txq;
+	struct sk_buff *skb;
 	int i, err;
+	u32 tsleep;
 
 	if (apc->port_is_up)
 		return -EINVAL;
@@ -2363,15 +2367,40 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 * to false, but it doesn't matter since mana_start_xmit() drops any
 	 * new packets due to apc->port_is_up being false.
 	 *
-	 * Drain all the in-flight TX packets
+	 * Drain all the in-flight TX packets.
+	 * A timeout of 120 seconds for all the queues is used.
+	 * This will break the while loop when h/w is not responding.
+	 * This value of 120 has been decided here considering max
+	 * number of queues.
 	 */
+
 	for (i = 0; i < apc->num_queues; i++) {
 		txq = &apc->tx_qp[i].txq;
-
-		while (atomic_read(&txq->pending_sends) > 0)
-			usleep_range(1000, 2000);
+		tsleep = 1000;
+		while (atomic_read(&txq->pending_sends) > 0 &&
+		       time_before(jiffies, timeout)) {
+			usleep_range(tsleep, tsleep + 1000);
+			tsleep <<= 1;
+		}
+		if (atomic_read(&txq->pending_sends)) {
+			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
+			if (err) {
+				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
+					   err, atomic_read(&txq->pending_sends),
+					   txq->gdma_txq_id);
+			}
+			break;
+		}
 	}
 
+	for (i = 0; i < apc->num_queues; i++) {
+		txq = &apc->tx_qp[i].txq;
+		while ((skb = skb_dequeue(&txq->pending_skbs))) {
+			mana_unmap_skb(skb, apc);
+			dev_kfree_skb_any(skb);
+		}
+		atomic_set(&txq->pending_sends, 0);
+	}
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */

