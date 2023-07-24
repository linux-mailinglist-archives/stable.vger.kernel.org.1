Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6F75F4E3
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 13:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGXL0S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGXL0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 07:26:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41A5E4E
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 04:26:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F22F66607033;
        Mon, 24 Jul 2023 12:26:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690197974;
        bh=FPzsokEq60QB6Lq1genijHT7LF37FBTgPWRm/+4nsuE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ga8jaWgB+NGUZHu4RL6KXDwhNU0oK/06Jvv3v7J5z0maoLVTMvA2oDsp7hJQkH8Ci
         pz2y3H1oNVccDKzt0TxIbuMiNfaRFtCupsnaMezxxSzFgv6R9awOEDekQidW64qrq1
         mpzMjvy2BMZUV4vf9i/EG33/rMDnp1zn8Ks4hU1zZFn5RmZEKfvEqKFvOFGi0SaH8F
         Jy6aKXSfwmDt0S8ejvJcdRnZwKZ8pNO15zSsQrFyGYaVn7uyCblxEUo5LSWBRSRlmz
         6NG1U/I131tskiNqFGsUpOT/6BCDkhz1NZDaqhRPsRSeArX7Cq6dceH/4VU7IPV1BN
         gp2oh5TdYlQuA==
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
Date:   Mon, 24 Jul 2023 13:26:10 +0200
Message-ID: <20230724112610.60974-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The dma-buf backend is supposed to provide its own vm_ops, but some
implementation just have nothing special to do and leave vm_ops
untouched, probably expecting this field to be zero initialized (this
is the case with the system_heap implementation for instance).
Let's reset vma->vm_ops to NULL to keep things working with these
implementations.

Fixes: 26d3ac3cb04d ("drm/shmem-helpers: Redirect mmap for imported dma-buf")
Cc: <stable@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reported-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4ea6507a77e5..baaf0e0feb06 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -623,7 +623,13 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 	int ret;
 
 	if (obj->import_attach) {
+		/* Reset both vm_ops and vm_private_data, so we don't end up with
+		 * vm_ops pointing to our implementation if the dma-buf backend
+		 * doesn't set those fields.
+		 */
 		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+
 		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
 
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
-- 
2.41.0

