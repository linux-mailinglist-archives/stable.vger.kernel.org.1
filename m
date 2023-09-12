Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964D279B37C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjIKWJX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbjIKOId (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BACF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6020BC433C7;
        Mon, 11 Sep 2023 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441308;
        bh=sis9pQh5t4m3cTFrdcmtJSPIfRahluuUcxaIqXxa0Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqELKoBveTz9Xk6f0b2v2RFS7nPMkgj/cXJa+VkqfyUE1qpIis+yhormX0MTGC/zZ
         JERBrlZhXX5cpQx/Wim6t2ng4K88CoeOWiiBZZnYFLyWklG9ehHjrBnM+edbVi0n3Q
         hP+9vgmcmMUz2OQ6Jwj2O83G2ASTiOndUVs3S1t0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 367/739] of: overlay: Call of_changeset_init() early
Date:   Mon, 11 Sep 2023 15:42:46 +0200
Message-ID: <20230911134701.407506720@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a9515ff4fb142b690a0d2b58782b15903b990dba ]

When of_overlay_fdt_apply() fails, the changeset may be partially
applied, and the caller is still expected to call of_overlay_remove() to
clean up this partial state.

However, of_overlay_apply() calls of_resolve_phandles() before
init_overlay_changeset().  Hence if the overlay fails to apply due to an
unresolved symbol, the overlay_changeset.cset.entries list is still
uninitialized, and cleanup will crash with a NULL-pointer dereference in
overlay_removal_is_ok().

Fix this by moving the call to of_changeset_init() from
init_overlay_changeset() to of_overlay_fdt_apply(), where all other
early initialization is done.

Fixes: f948d6d8b792bb90 ("of: overlay: avoid race condition between applying multiple overlays")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/4f1d6d74b61cba2599026adb6d1948ae559ce91f.1690533838.git.geert+renesas@glider.be
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/overlay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7feb643f13707..28b479afd506f 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -752,8 +752,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 	if (!of_node_is_root(ovcs->overlay_root))
 		pr_debug("%s() ovcs->overlay_root is not root\n", __func__);
 
-	of_changeset_init(&ovcs->cset);
-
 	cnt = 0;
 
 	/* fragment nodes */
@@ -1013,6 +1011,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
+	of_changeset_init(&ovcs->cset);
 
 	/*
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
-- 
2.40.1



