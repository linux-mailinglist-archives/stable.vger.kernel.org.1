Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9B73527D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjFSKfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFSKfH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADE10F1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19EC560B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B885C433C0;
        Mon, 19 Jun 2023 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170899;
        bh=WBLrPzM4Y0mMUKeL5/0+BVQePUg4SRItKXToj05HItA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BznmfkrmbEGbvmRcjnOh/voPR0Sr5Oy4ijwSCQlqKFXSk/vsMmeHhjU6gITZfefa
         Bwfd2WSGF/HB7rCH4+0fPUAJkENRxdDLVIB5tbZ/EqI4m2agLzJf/zBRzPsSJ9L/mH
         xxAz4kFjeENPraUHdt3p/KC5tdx29PNDepJILA7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 6.3 076/187] nouveau: fix client work fence deletion race
Date:   Mon, 19 Jun 2023 12:28:14 +0200
Message-ID: <20230619102201.305411667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

commit c8a5d5ea3ba6a18958f8d76430e4cd68eea33943 upstream.

This seems to have existed for ever but is now more apparant after
commit 9bff18d13473 ("drm/ttm: use per BO cleanup workers")

My analysis: two threads are running, one in the irq signalling the
fence, in dma_fence_signal_timestamp_locked, it has done the
DMA_FENCE_FLAG_SIGNALLED_BIT setting, but hasn't yet reached the
callbacks.

The second thread in nouveau_cli_work_ready, where it sees the fence is
signalled, so then puts the fence, cleanups the object and frees the
work item, which contains the callback.

Thread one goes again and tries to call the callback and causes the
use-after-free.

Proposed fix: lock the fence signalled check in nouveau_cli_work_ready,
so either the callbacks are done or the memory is freed.

Reviewed-by: Karol Herbst <kherbst@redhat.com>
Fixes: 11e451e74050 ("drm/nouveau: remove fence wait code from deferred client work handler")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://lore.kernel.org/dri-devel/20230615024008.1600281-1-airlied@gmail.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -137,10 +137,16 @@ nouveau_name(struct drm_device *dev)
 static inline bool
 nouveau_cli_work_ready(struct dma_fence *fence)
 {
-	if (!dma_fence_is_signaled(fence))
-		return false;
-	dma_fence_put(fence);
-	return true;
+	bool ret = true;
+
+	spin_lock_irq(fence->lock);
+	if (!dma_fence_is_signaled_locked(fence))
+		ret = false;
+	spin_unlock_irq(fence->lock);
+
+	if (ret == true)
+		dma_fence_put(fence);
+	return ret;
 }
 
 static void


