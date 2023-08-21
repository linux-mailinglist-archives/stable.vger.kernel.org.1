Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4832782F03
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjHURDw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 13:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjHURDv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 13:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F0EC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A300A63F71
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 17:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B141FC433C8;
        Mon, 21 Aug 2023 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692637429;
        bh=jPf58vaKEwbsoQsz8KPDOKbyFA1CZYq8pAAMPon3/0A=;
        h=Subject:To:Cc:From:Date:From;
        b=EE9WoQGi5VOEAmdr5bup4ipDe/BzudC9KRJA5BkVOd28ZpKUo+zh1a3Dm4Pk6k5JT
         XT1wWWVbEhwUPOxomDoeZjk8gjvcKinAbvsqKZOti2vDCLdoZVtLbKfvgicLBz2KSo
         q7E4/rokZhHbAI3RvTyCAmR4V4jA5BbtxRQ4F4wo=
Subject: FAILED: patch "[PATCH] drm/nouveau/disp: fix use-after-free in error handling of" failed to apply to 6.1-stable tree
To:     kherbst@redhat.com, lyude@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 19:03:46 +0200
Message-ID: <2023082146-oxidation-equate-185a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1b254b791d7b7dea6e8adc887fbbd51746d8bb27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082146-oxidation-equate-185a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1b254b791d7b ("drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create")
773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
ffd2664114c8 ("drm/nouveau/disp: expose head event class")
1d4dce284164 ("drm/nouveau/disp: switch vblank semaphore release to nvkm_event_ntfy")
f43e47c090dc ("drm/nouveau/nvkm: add a replacement for nvkm_notify")
361863ceab1e ("drm/nouveau/disp: move head scanoutpos method")
a2b7eadfef59 ("drm/nouveau/disp: add head class")
8c7d980da9ba ("drm/nouveau/disp: move DP MST payload config method")
8bb30c882334 ("drm/nouveau/disp: add method to trigger DP link retrain")
016dacb60e6d ("drm/nouveau/kms: pass event mask to hpd handler")
d62f8e982cb8 ("drm/nouveau/kms: switch hpd_lock from mutex to spinlock")
a62b74939063 ("drm/nouveau/disp: add method to control DPAUX pad power")
813443721331 ("drm/nouveau/disp: move DP link config into acquire")
a9f5d7721923 ("drm/nouveau/disp: move HDA ELD method")
f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")
9793083f1dd9 ("drm/nouveau/disp: move LVDS protocol information into acquire")
ea6143a86c67 ("drm/nouveau/disp: move and extend the role of outp acquire/release methods")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b254b791d7b7dea6e8adc887fbbd51746d8bb27 Mon Sep 17 00:00:00 2001
From: Karol Herbst <kherbst@redhat.com>
Date: Mon, 14 Aug 2023 16:49:32 +0200
Subject: [PATCH] drm/nouveau/disp: fix use-after-free in error handling of
 nouveau_connector_create

We can't simply free the connector after calling drm_connector_init on it.
We need to clean up the drm side first.

It might not fix all regressions from commit 2b5d1c29f6c4
("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"),
but at least it fixes a memory corruption in error handling related to
that commit.

Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/
Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230814144933.3956959-1-kherbst@redhat.com

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index a2e0033e8a26..622f6eb9a8bf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1408,8 +1408,7 @@ nouveau_connector_create(struct drm_device *dev,
 		ret = nvif_conn_ctor(&disp->disp, nv_connector->base.name, nv_connector->index,
 				     &nv_connector->conn);
 		if (ret) {
-			kfree(nv_connector);
-			return ERR_PTR(ret);
+			goto drm_conn_err;
 		}
 
 		ret = nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",
@@ -1426,8 +1425,7 @@ nouveau_connector_create(struct drm_device *dev,
 			if (ret) {
 				nvif_event_dtor(&nv_connector->hpd);
 				nvif_conn_dtor(&nv_connector->conn);
-				kfree(nv_connector);
-				return ERR_PTR(ret);
+				goto drm_conn_err;
 			}
 		}
 	}
@@ -1475,4 +1473,9 @@ nouveau_connector_create(struct drm_device *dev,
 
 	drm_connector_register(connector);
 	return connector;
+
+drm_conn_err:
+	drm_connector_cleanup(connector);
+	kfree(nv_connector);
+	return ERR_PTR(ret);
 }

