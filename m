Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3133D73544C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjFSKyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjFSKyQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBB10D9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18B860B36
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BAC433C8;
        Mon, 19 Jun 2023 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171970;
        bh=Q412A8uYul4sfbpdHRXwb45qt7ghnIqfwClbz6rfyF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6344L0MO08xRMTtqDKt2JxVw8AF1pzNf89xbEpIwZuq2KjfoDs1c+WTAus/G9+Ss
         afbfzDwP4q/4Hjiv7Us91gt4q4m7hbe2vclXbMvRU691+KN9JU08DM4ut/Ff8RmMFr
         yvioKhKuxASPCT2XWX70IFcIelZotrs9+6Qdac9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 5.4 28/64] nouveau: fix client work fence deletion race
Date:   Mon, 19 Jun 2023 12:30:24 +0200
Message-ID: <20230619102134.373555440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -123,10 +123,16 @@ nouveau_name(struct drm_device *dev)
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


