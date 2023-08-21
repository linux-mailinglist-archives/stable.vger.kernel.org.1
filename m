Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8865B7832A3
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHUT71 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjHUT70 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184C183
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E708164712
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D9C433C7;
        Mon, 21 Aug 2023 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647959;
        bh=9uXSArX/wMQHY5M39yUQ5eNMegUNNCd5y+IJ0LCWyV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ru+4aMtF26tY3H+wGqH5prW5ae6l2RdE9jTtPxZPoq9bDXt44HzRBuybuzL+RyTMq
         VcXFglucI0hLXnZUW8mjKm2Q7vstjF2sQR1L0azK03sUVMQj0EMSbTLZ6Ou9AkZZGA
         yDoozjo5NWEiSyNL+6Uv+AWeGNrkIrJg4IcNLKbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6.1 192/194] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
Date:   Mon, 21 Aug 2023 21:42:51 +0200
Message-ID: <20230821194131.144428893@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

commit 1b254b791d7b7dea6e8adc887fbbd51746d8bb27 upstream.

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
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1407,8 +1407,7 @@ nouveau_connector_create(struct drm_devi
 		ret = nvif_conn_ctor(&disp->disp, nv_connector->base.name, nv_connector->index,
 				     &nv_connector->conn);
 		if (ret) {
-			kfree(nv_connector);
-			return ERR_PTR(ret);
+			goto drm_conn_err;
 		}
 	}
 
@@ -1470,4 +1469,9 @@ nouveau_connector_create(struct drm_devi
 
 	drm_connector_register(connector);
 	return connector;
+
+drm_conn_err:
+	drm_connector_cleanup(connector);
+	kfree(nv_connector);
+	return ERR_PTR(ret);
 }


