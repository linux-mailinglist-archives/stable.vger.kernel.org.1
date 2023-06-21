Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05372737C49
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFUHcY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFUHcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 03:32:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8F1981
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 00:32:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so44687615e9.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687332727; x=1689924727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmvHVXRDKqzFFcrWt+SJPU4Lcp8ha56oKmpqUONLlm8=;
        b=rqJgV+Tgbheh69qxRv9aEo7439O/wiUJqGbfIJbaVnyuECGj8rrnvxmXSLd5R5m2jK
         ZZN095TsDc2DLdcUN+2YPG/8YZ7R1c3oeILqPVOosTj6wQH5h/2tKgS73E1sz3OHaXe0
         D4WsOTDxvAZ6dsmijxyiazQb0/v0ADEKAX/ScAtIY+HXb/RA38aBqqYdtkO2mTBNYR6A
         HFLA46ttDkxbib+qm2wVzhK1So/mWcMTBLKRqAAHElPYfFViK6JOT6mLQCq9vXKDvRSC
         mFABIqGLVC2OcNiAumPHEXiqCUAHjWZ/qiDublIaCyjAOf74940y1C3bnD/JDOumGIny
         xQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687332727; x=1689924727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmvHVXRDKqzFFcrWt+SJPU4Lcp8ha56oKmpqUONLlm8=;
        b=iyVRTZ7Ile1aVRkryzLXPIO+qFTGkvdgPaawpdISG13uLmflQCnX8O6xzyLVwhjWvW
         opwsmWnRE50W1z6F3ULJhzTSp+VK9bOUZR6xVzsmSyfn8tAwCom5BlFEfaHDqWAq3jBt
         Bn/x7vI7j7w1SO8tPC0Ac8W499B6qGCyFE7DhLT1MyLmN/6JNUYq/7QWNaF9qM+kVtLp
         AJ93+p457u7CDeNhMkoLPdWq+gVIXAlx5MLug1A8L7iM1dMreiFhPvDXvh1TSRFY7+qk
         x0up55SjsHzXQSRJM8tvkaev7WiR7hJ8DvhcnkTVpweEVnH3XY69KZ2y7PRBNAI4iNeO
         tpCw==
X-Gm-Message-State: AC+VfDzk7HMj8LKbQeHQt4+EkPhckbDrI04pCWYKRMgvAUYZl/zGSMPZ
        ch/1JEcqvxnDSSQaHm8xnhjvipK6EO0=
X-Google-Smtp-Source: ACHHUZ5DLf5c2uJYNlwVcCvkvAWXLwYzyx1pWgAqAksIZrY6kxe+Ywq7Y9qfv7TMbCLD/lLEHwEfFw==
X-Received: by 2002:a7b:c041:0:b0:3f9:b748:ff3f with SMTP id u1-20020a7bc041000000b003f9b748ff3fmr3730382wmc.1.1687332727066;
        Wed, 21 Jun 2023 00:32:07 -0700 (PDT)
Received: from EliteBook.fritz.box ([2a00:e180:1557:8d00:aed9:fe98:2f71:4615])
        by smtp.gmail.com with ESMTPSA id y12-20020adff6cc000000b0030903d44dbcsm3714608wrp.33.2023.06.21.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:32:06 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     juan.hao@nxp.com, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        stable@vger.kernel.org
Subject: [PATCH] dma-buf: keep the signaling time of merged fences
Date:   Wed, 21 Jun 2023 09:32:04 +0200
Message-Id: <20230621073204.28459-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Some Android CTS is testing for that.

Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/dma-buf/dma-fence-unwrap.c | 11 +++++++++--
 drivers/dma-buf/dma-fence.c        |  5 +++--
 drivers/gpu/drm/drm_syncobj.c      |  2 +-
 include/linux/dma-fence.h          |  2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 7002bca792ff..06eb91306c01 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -66,18 +66,25 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 {
 	struct dma_fence_array *result;
 	struct dma_fence *tmp, **array;
+	ktime_t timestamp;
 	unsigned int i;
 	size_t count;
 
 	count = 0;
+	timestamp = ns_to_ktime(0);
 	for (i = 0; i < num_fences; ++i) {
-		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i])
+		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
 			if (!dma_fence_is_signaled(tmp))
 				++count;
+			else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+					  &tmp->flags) &&
+				 ktime_after(tmp->timestamp, timestamp))
+				timestamp = tmp->timestamp;
+		}
 	}
 
 	if (count == 0)
-		return dma_fence_get_stub();
+		return dma_fence_allocate_private_stub(timestamp);
 
 	array = kmalloc_array(count, sizeof(*array), GFP_KERNEL);
 	if (!array)
diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f177c56269bb..ad076f208760 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -150,10 +150,11 @@ EXPORT_SYMBOL(dma_fence_get_stub);
 
 /**
  * dma_fence_allocate_private_stub - return a private, signaled fence
+ * @timestamp: timestamp when the fence was signaled
  *
  * Return a newly allocated and signaled stub fence.
  */
-struct dma_fence *dma_fence_allocate_private_stub(void)
+struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
 {
 	struct dma_fence *fence;
 
@@ -169,7 +170,7 @@ struct dma_fence *dma_fence_allocate_private_stub(void)
 	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
 		&fence->flags);
 
-	dma_fence_signal(fence);
+	dma_fence_signal_timestamp(fence, timestamp);
 
 	return fence;
 }
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 0c2be8360525..04589a35eb09 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -353,7 +353,7 @@ EXPORT_SYMBOL(drm_syncobj_replace_fence);
  */
 static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
 {
-	struct dma_fence *fence = dma_fence_allocate_private_stub();
+	struct dma_fence *fence = dma_fence_allocate_private_stub(ktime_get());
 
 	if (IS_ERR(fence))
 		return PTR_ERR(fence);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index d54b595a0fe0..0d678e9a7b24 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -606,7 +606,7 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline);
 
 struct dma_fence *dma_fence_get_stub(void);
-struct dma_fence *dma_fence_allocate_private_stub(void);
+struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp);
 u64 dma_fence_context_alloc(unsigned num);
 
 extern const struct dma_fence_ops dma_fence_array_ops;
-- 
2.34.1

