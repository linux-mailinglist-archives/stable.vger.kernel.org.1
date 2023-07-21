Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3A75CEF5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGUQ0N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjGUQ0A (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620946A5
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9987361D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F8C433C8;
        Fri, 21 Jul 2023 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956493;
        bh=3JP2PPgNam4Rbk6weOxxRG79dW7F7oiC6ZvU1qqU8iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bCxYAp8rRmcW0ePe3hIeOXIFPPXLl+Ywx6tCoIDVyohhu/GF/XNmc0RqKNfo4D+k
         lrxPSVWaC2boKAnSgHFSEJuRTQYuge3ImVy0tQZpDFWYu8Gi4e/OgKsDqAn3oL4bhr
         d3+Ia+BI3rPPGH8GubVg09YC2wHxINeIoPO9MTdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 6.4 211/292] drm/ttm: Dont leak a resource on eviction error
Date:   Fri, 21 Jul 2023 18:05:20 +0200
Message-ID: <20230721160537.940301209@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit e8188c461ee015ba0b9ab2fc82dbd5ebca5a5532 upstream.

On eviction errors other than -EMULTIHOP we were leaking a resource.
Fix.

v2:
- Avoid yet another goto (Andi Shyti)

Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> #v1
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230626091450.14757-4-thomas.hellstrom@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -458,18 +458,18 @@ static int ttm_bo_evict(struct ttm_buffe
 		goto out;
 	}
 
-bounce:
-	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
-	if (ret == -EMULTIHOP) {
+	do {
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
+		if (ret != -EMULTIHOP)
+			break;
+
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
-		if (ret) {
-			if (ret != -ERESTARTSYS && ret != -EINTR)
-				pr_err("Buffer eviction failed\n");
-			ttm_resource_free(bo, &evict_mem);
-			goto out;
-		}
-		/* try and move to final place now. */
-		goto bounce;
+	} while (!ret);
+
+	if (ret) {
+		ttm_resource_free(bo, &evict_mem);
+		if (ret != -ERESTARTSYS && ret != -EINTR)
+			pr_err("Buffer eviction failed\n");
 	}
 out:
 	return ret;


