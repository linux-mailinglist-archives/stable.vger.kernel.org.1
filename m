Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9172C08E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjFLKxW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbjFLKw7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE63A5FA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F986612B4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CAC433D2;
        Mon, 12 Jun 2023 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566254;
        bh=6i98zcX98iJ7802TKFS8HOTqN/ZpuIisJE/+9DmZbRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECIh8aK4jcyh64mQ/OqJkRvowPijonieQrAJJYs4mH6A30yiCowMQhrN8uLmtqr4h
         wW3j22TMHZstWmOaYGTz1FTQ8UIwy1GUsc0AYwS5tzV4uSEzRkazcv0YQhx6N8AZUI
         XTyr/g/8SoVrHZI5Lnlcjq85FZgA1bMutiPc2+ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 5.15 54/91] drm/i915/gt: Use the correct error value when kernel_context() fails
Date:   Mon, 12 Jun 2023 12:26:43 +0200
Message-ID: <20230612101704.316316071@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Andi Shyti <andi.shyti@linux.intel.com>

commit 40023959dbab3c6ad56fa7213770e63d197b69fb upstream.

kernel_context() returns an error pointer. Use pointer-error
conversion functions to evaluate its return value, rather than
checking for a '0' return.

Fixes: eb5c10cbbc2f ("drm/i915: Remove I915_USER_PRIORITY_SHIFT")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: <stable@vger.kernel.org> # v5.13+
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Acked-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230526124138.2006110-1-andi.shyti@linux.intel.com
(cherry picked from commit edad9ee94f17adc75d3b13ab51bbe3d615ce1e7e)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1531,8 +1531,8 @@ static int live_busywait_preempt(void *a
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	enum intel_engine_id id;
-	int err = -ENOMEM;
 	u32 *map;
+	int err;
 
 	/*
 	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we can
@@ -1540,13 +1540,17 @@ static int live_busywait_preempt(void *a
 	 */
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
+
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
+
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);


