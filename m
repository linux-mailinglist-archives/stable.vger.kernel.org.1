Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550087696B9
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGaMsF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjGaMrt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:47:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AE1FC1
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:47:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3174aac120aso4119597f8f.2
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690807650; x=1691412450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEm/V4J7LWxR2zjSd1IelpVanmWUvN1+Pm23WdRCgYE=;
        b=i5tgh2EVgDX+OWct7mKUbkvSLMEQq7S3SJLsuZyClIHKANepyAqk98gPyp3JvuXC5K
         ipS2PevsrPH0geC/LDBnboShLrEeC8NH1es6JjlrtdYs9I17H5UcDHD1pgZf3ROsvar5
         Z4KAObKy6DisQvbZottqQNLTzw1jSH+7eCXkJ+Um1oYA0S7LDREiWzq1N3U7+PJuCRDd
         W+87PBNYD2TFk6vxXRUhSE69Q1Ia7rTsXYETNR5QwsfSGbJezHWeq6//kW1jTjZYzd3b
         1r/GDlgLUqk/jSc1YYhyVi6R/yG0pwqP2EqJLJnyqilHr2pnGUmf7BMszVBnDSim1UwO
         wqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807650; x=1691412450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEm/V4J7LWxR2zjSd1IelpVanmWUvN1+Pm23WdRCgYE=;
        b=ShePR79UWGUtX3u3qFNus8iX8vmBrUA92WhDNds1uJeWRUzRch7KGPaY1F3AguK4hZ
         k/TtlYm4JgmO7M+OwkSXcWyXPCfcBwq7cmxQEdDgkOlB3S4N3KGJqKIDaTWl4AuhDxyo
         yse2ogfzO95dqp9cIiiHVAGYFdZzKGvNO/yMf5vABuPzWJ5lqFZk6KIJ9HlhdaKxyFmr
         QVspAZXLJGKgbc5/SMjv89soqJotJcGSlOXOY3R4VKnVUA04NK5DxAAVuDsP3K1k1PkM
         ewMaUM1EE0vhRbnNx7U/2DX3nLQBeDhrmqMOoIlYSyXV+chwxV3Q6LYwEarF9wLWVgQF
         XViQ==
X-Gm-Message-State: ABy/qLY21FcgJvOJuQYh3WPbD1ILHpEdcVH4rfKyEFjx2u1mI5GfYCXx
        lPXcuycuAB7DBC3INmqrKVW5PJVNYFQ=
X-Google-Smtp-Source: APBJJlFgkwwaAZdns6ySDDoFsEcZrZtX85nJwm2uHNzcC6cMY66wWKM7vdTlOwjIAH0Uy1/+zNTPXA==
X-Received: by 2002:a5d:548b:0:b0:313:f862:6e3e with SMTP id h11-20020a5d548b000000b00313f8626e3emr6418325wrv.40.1690807650432;
        Mon, 31 Jul 2023 05:47:30 -0700 (PDT)
Received: from EliteBook.fritz.box ([2a00:e180:14f0:a600:1aab:7a9b:5a44:2e77])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003142c85fbcdsm12995655wru.11.2023.07.31.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:47:30 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     stable@vger.kernel.org
Cc:     juan.hao@nxp.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH] dma-buf: keep the signaling time of merged fences v3
Date:   Mon, 31 Jul 2023 14:47:26 +0200
Message-Id: <20230731124726.480878-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Some Android CTS is testing if the signaling time keeps consistent
during merges.

v2: use the current time if the fence is still in the signaling path and
the timestamp not yet available.
v3: improve comment, fix one more case to use the correct timestamp

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230630120041.109216-1-christian.koenig@amd.com
Cc: <stable@vger.kernel.org> # v6.0+
---
 drivers/dma-buf/dma-fence-unwrap.c | 26 ++++++++++++++++++++++----
 drivers/dma-buf/dma-fence.c        |  5 +++--
 drivers/gpu/drm/drm_syncobj.c      |  2 +-
 include/linux/dma-fence.h          |  2 +-
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 7002bca792ff..c625bb2b5d56 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -66,18 +66,36 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
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
-			if (!dma_fence_is_signaled(tmp))
+		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
+			if (!dma_fence_is_signaled(tmp)) {
 				++count;
+			} else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+					    &tmp->flags)) {
+				if (ktime_after(tmp->timestamp, timestamp))
+					timestamp = tmp->timestamp;
+			} else {
+				/*
+				 * Use the current time if the fence is
+				 * currently signaling.
+				 */
+				timestamp = ktime_get();
+			}
+		}
 	}
 
+	/*
+	 * If we couldn't find a pending fence just return a private signaled
+	 * fence with the timestamp of the last signaled one.
+	 */
 	if (count == 0)
-		return dma_fence_get_stub();
+		return dma_fence_allocate_private_stub(timestamp);
 
 	array = kmalloc_array(count, sizeof(*array), GFP_KERNEL);
 	if (!array)
@@ -138,7 +156,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 	} while (tmp);
 
 	if (count == 0) {
-		tmp = dma_fence_get_stub();
+		tmp = dma_fence_allocate_private_stub(ktime_get());
 		goto return_tmp;
 	}
 
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

