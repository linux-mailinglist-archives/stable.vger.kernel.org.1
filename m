Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3D75CEED
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjGUQZ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjGUQZi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F63030C1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 742BE61D32
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86009C433CA;
        Fri, 21 Jul 2023 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956495;
        bh=87cetG0UIiVPLQJMh2i7MQAWKPVMeVdZFJMa9ES1B+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhFZwMBf5DIHRnpwo4khiQVrp8Bt6SvnEnCMvChrN/yt3Fg7sRj9MQdT/OJ4Poxdh
         JLvyl1XYXUvGvYvBVpHMXASSqVIn3cV50U5dSImRGLRbQIq9tgkVePNNCNAe+jenO0
         HqVd3Rsk6u7b0NQWeXGZMzCbMxOpHquxaSRyHxWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH 6.4 212/292] drm/ttm: Dont leak a resource on swapout move error
Date:   Fri, 21 Jul 2023 18:05:21 +0200
Message-ID: <20230721160537.983415194@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit a590f03d8de7c4cb7ce4916dc7f2fd10711faabe upstream.

If moving the bo to system for swapout failed, we were leaking
a resource. Fix.

Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
Cc: Christian König <christian.koenig@amd.com>
Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.14+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230626091450.14757-5-thomas.hellstrom@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1167,6 +1167,7 @@ int ttm_bo_swapout(struct ttm_buffer_obj
 		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, &ctx, &hop);
 		if (unlikely(ret != 0)) {
 			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
+			ttm_resource_free(bo, &evict_mem);
 			goto out;
 		}
 	}


