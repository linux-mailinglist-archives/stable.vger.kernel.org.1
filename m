Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13F6F8F4A
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEFGjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEFGjo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D5493E5
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396F461759
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94182C433D2;
        Sat,  6 May 2023 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355181;
        bh=+p18BjOF3QdUXqdE2MDiOh2pFDjdm7JM5qcLQjUE3ro=;
        h=Subject:To:Cc:From:Date:From;
        b=JfRbP4Hj9ablgv03z4zUfVSoRAHMEaOOLxyGymnLtniDh4p9b6Ode5sdmLk2cVEA2
         XlivnKEHBVOG0ThuJoRvsLsk6No6jgH7IvQCgRikOOJ7cTB22z6Eqo6KPOs4pC/wGE
         ic9XWPajC+kc5FSnuf2lau2LsEq5zfyjPkLGdFfY=
Subject: FAILED: patch "[PATCH] crypto: safexcel - Cleanup ring IRQ workqueues on load" failed to apply to 4.19-stable tree
To:     noodles@earth.li, herbert@gondor.apana.org.au
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:27:49 +0900
Message-ID: <2023050649-taps-trimester-6c67@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ca25c00ccbc5f942c63897ed23584cfc66e8ec81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050649-taps-trimester-6c67@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca25c00ccbc5f942c63897ed23584cfc66e8ec81 Mon Sep 17 00:00:00 2001
From: Jonathan McDowell <noodles@earth.li>
Date: Tue, 28 Feb 2023 18:28:58 +0000
Subject: [PATCH] crypto: safexcel - Cleanup ring IRQ workqueues on load
 failure

A failure loading the safexcel driver results in the following warning
on boot, because the IRQ affinity has not been correctly cleaned up.
Ensure we clean up the affinity and workqueues on a failure to load the
driver.

crypto-safexcel: probe of f2800000.crypto failed with error -2
------------[ cut here ]------------
WARNING: CPU: 1 PID: 232 at kernel/irq/manage.c:1913 free_irq+0x300/0x340
Modules linked in: hwmon mdio_i2c crypto_safexcel(+) md5 sha256_generic libsha256 authenc libdes omap_rng rng_core nft_masq nft_nat nft_chain_nat nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink fuse autofs4
CPU: 1 PID: 232 Comm: systemd-udevd Tainted: G        W          6.1.6-00002-g9d4898824677 #3
Hardware name: MikroTik RB5009 (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : free_irq+0x300/0x340
lr : free_irq+0x2e0/0x340
sp : ffff800008fa3890
x29: ffff800008fa3890 x28: 0000000000000000 x27: 0000000000000000
x26: ffff8000008e6dc0 x25: ffff000009034cac x24: ffff000009034d50
x23: 0000000000000000 x22: 000000000000004a x21: ffff0000093e0d80
x20: ffff000009034c00 x19: ffff00000615fc00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 000075f5c1584c5e
x14: 0000000000000017 x13: 0000000000000000 x12: 0000000000000040
x11: ffff000000579b60 x10: ffff000000579b62 x9 : ffff800008bbe370
x8 : ffff000000579dd0 x7 : 0000000000000000 x6 : ffff000000579e18
x5 : ffff000000579da8 x4 : ffff800008ca0000 x3 : ffff800008ca0188
x2 : 0000000013033204 x1 : ffff000009034c00 x0 : ffff8000087eadf0
Call trace:
 free_irq+0x300/0x340
 devm_irq_release+0x14/0x20
 devres_release_all+0xa0/0x100
 device_unbind_cleanup+0x14/0x60
 really_probe+0x198/0x2d4
 __driver_probe_device+0x74/0xdc
 driver_probe_device+0x3c/0x110
 __driver_attach+0x8c/0x190
 bus_for_each_dev+0x6c/0xc0
 driver_attach+0x20/0x30
 bus_add_driver+0x148/0x1fc
 driver_register+0x74/0x120
 __platform_driver_register+0x24/0x30
 safexcel_init+0x48/0x1000 [crypto_safexcel]
 do_one_initcall+0x4c/0x1b0
 do_init_module+0x44/0x1cc
 load_module+0x1724/0x1be4
 __do_sys_finit_module+0xbc/0x110
 __arm64_sys_finit_module+0x1c/0x24
 invoke_syscall+0x44/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x20/0x80
 el0_svc+0x14/0x4c
 el0t_64_sync_handler+0xb0/0xb4
 el0t_64_sync+0x148/0x14c
---[ end trace 0000000000000000 ]---

Fixes: 1b44c5a60c13 ("inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Jonathan McDowell <noodles@earth.li>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 5e10ab24be3b..9ff02b5abc4a 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1628,19 +1628,23 @@ static int safexcel_probe_generic(void *pdev,
 						     &priv->ring[i].rdr);
 		if (ret) {
 			dev_err(dev, "Failed to initialize rings\n");
-			return ret;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].rdr_req = devm_kcalloc(dev,
 			EIP197_DEFAULT_RING_SIZE,
 			sizeof(*priv->ring[i].rdr_req),
 			GFP_KERNEL);
-		if (!priv->ring[i].rdr_req)
-			return -ENOMEM;
+		if (!priv->ring[i].rdr_req) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq = devm_kzalloc(dev, sizeof(*ring_irq), GFP_KERNEL);
-		if (!ring_irq)
-			return -ENOMEM;
+		if (!ring_irq) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq->priv = priv;
 		ring_irq->ring = i;
@@ -1654,7 +1658,8 @@ static int safexcel_probe_generic(void *pdev,
 						ring_irq);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get IRQ ID for ring %d\n", i);
-			return irq;
+			ret = irq;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].irq = irq;
@@ -1666,8 +1671,10 @@ static int safexcel_probe_generic(void *pdev,
 		snprintf(wq_name, 9, "wq_ring%d", i);
 		priv->ring[i].workqueue =
 			create_singlethread_workqueue(wq_name);
-		if (!priv->ring[i].workqueue)
-			return -ENOMEM;
+		if (!priv->ring[i].workqueue) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		priv->ring[i].requests = 0;
 		priv->ring[i].busy = false;
@@ -1684,16 +1691,26 @@ static int safexcel_probe_generic(void *pdev,
 	ret = safexcel_hw_init(priv);
 	if (ret) {
 		dev_err(dev, "HW init failed (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	ret = safexcel_register_algorithms(priv);
 	if (ret) {
 		dev_err(dev, "Failed to register algorithms (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	return 0;
+
+err_cleanup_rings:
+	for (i = 0; i < priv->config.rings; i++) {
+		if (priv->ring[i].irq)
+			irq_set_affinity_hint(priv->ring[i].irq, NULL);
+		if (priv->ring[i].workqueue)
+			destroy_workqueue(priv->ring[i].workqueue);
+	}
+
+	return ret;
 }
 
 static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)

