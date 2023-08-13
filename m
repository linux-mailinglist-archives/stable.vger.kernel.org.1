Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206F677ABD4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHMV0L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHMV0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850410DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12536297C
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEECDC433C7;
        Sun, 13 Aug 2023 21:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961972;
        bh=3QppXAd9JBc/wefvgr+cBsDuCfIjuy0/cdV/H1l0A4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBznFvgeRz+uMVXZa3bhb7P4GuJjHuCE4Xu0d6TKZPGDLD6VoOYBrGY851FpODNKo
         FTjhbHh93R3eaVlBGmXCK1H2ljODO9qDT8vHATi9sM5C50a/YSrs7IRBC5cvMW5nwN
         7zffBfWhytWxDS5AQ15v0e43Yf5l6LE4zUepfFrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH 6.4 058/206] accel/ivpu: Add set_pages_array_wc/uc for internal buffers
Date:   Sun, 13 Aug 2023 23:17:08 +0200
Message-ID: <20230813211726.676663559@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Karol Wachowski <karol.wachowski@linux.intel.com>

commit 1963546390ed8b649f529993a755eba0fdeb7aaa upstream.

Buffers mapped with pgprot_writecombined() are not correctly
flushed. This triggers issues on VPU access using random
memory content such as MMU translation faults, invalid context
descriptors being fetched and can lead to VPU FW crashes.

Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Cc: stable@vger.kernel.org # 6.3+
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230802063735.3005291-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 52b339aefadc..9967fcfa27ec 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -173,6 +173,9 @@ static void internal_free_pages_locked(struct ivpu_bo *bo)
 {
 	unsigned int i, npages = bo->base.size >> PAGE_SHIFT;
 
+	if (ivpu_bo_cache_mode(bo) != DRM_IVPU_BO_CACHED)
+		set_pages_array_wb(bo->pages, bo->base.size >> PAGE_SHIFT);
+
 	for (i = 0; i < npages; i++)
 		put_page(bo->pages[i]);
 
@@ -587,6 +590,11 @@ ivpu_bo_alloc_internal(struct ivpu_device *vdev, u64 vpu_addr, u64 size, u32 fla
 	if (ivpu_bo_cache_mode(bo) != DRM_IVPU_BO_CACHED)
 		drm_clflush_pages(bo->pages, bo->base.size >> PAGE_SHIFT);
 
+	if (bo->flags & DRM_IVPU_BO_WC)
+		set_pages_array_wc(bo->pages, bo->base.size >> PAGE_SHIFT);
+	else if (bo->flags & DRM_IVPU_BO_UNCACHED)
+		set_pages_array_uc(bo->pages, bo->base.size >> PAGE_SHIFT);
+
 	prot = ivpu_bo_pgprot(bo, PAGE_KERNEL);
 	bo->kvaddr = vmap(bo->pages, bo->base.size >> PAGE_SHIFT, VM_MAP, prot);
 	if (!bo->kvaddr) {
-- 
2.41.0



