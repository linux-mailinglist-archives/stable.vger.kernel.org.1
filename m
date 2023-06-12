Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC772C19E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjFLK7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjFLKyo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698191985
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 019E5614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117EBC4339B;
        Mon, 12 Jun 2023 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566472;
        bh=B+BH5zlbMYjdvT+q1uCXJ/zua4sytV2WLsDB9xKTw0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8xJB8iovWYETWvMAxlWk8dxXvCxuS3lixuZ9r4q8LejqY1+ppO8I7UldMhzfItxF
         ckSt79ETycudONw8Trq+TWmMmX2CWGSTmyoK+YHGOs8yuQQFgHzcgYdbn1VRIftmP/
         Gg5Y5ULBfQb4ydc0jTcfpEyPYPJRuk5YGZ/+r/2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 045/132] drm/i915/selftests: Add some missing error propagation
Date:   Mon, 12 Jun 2023 12:26:19 +0200
Message-ID: <20230612101712.318950123@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

[ Upstream commit 79d0150d2d983a4f6efee676cea06027f586fcd0 ]

Add some missing error propagation in live_parallel_switch.

To avoid needlessly burdening the various backport processes, note I am
not marking it as a fix against any patches and not copying stable since
it is debug/selftests only code.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Fixes: 50d16d44cce4 ("drm/i915/selftests: Exercise context switching in parallel")
Fixes: 6407cf533217 ("drm/i915/selftests: Stop using kthread_stop()")
Link: https://patchwork.freedesktop.org/patch/msgid/20230605131135.396854-1-tvrtko.ursulin@linux.intel.com
(cherry picked from commit 412fa1f097f48c8c1321806dd25e46618e0da147)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index d8864444432b7..a4858be12ee76 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -346,8 +346,10 @@ static int live_parallel_switch(void *arg)
 				continue;
 
 			ce = intel_context_create(data[m].ce[0]->engine);
-			if (IS_ERR(ce))
+			if (IS_ERR(ce)) {
+				err = PTR_ERR(ce);
 				goto out;
+			}
 
 			err = intel_context_pin(ce);
 			if (err) {
@@ -367,8 +369,10 @@ static int live_parallel_switch(void *arg)
 
 		worker = kthread_create_worker(0, "igt/parallel:%s",
 					       data[n].ce[0]->engine->name);
-		if (IS_ERR(worker))
+		if (IS_ERR(worker)) {
+			err = PTR_ERR(worker);
 			goto out;
+		}
 
 		data[n].worker = worker;
 	}
@@ -397,8 +401,10 @@ static int live_parallel_switch(void *arg)
 			}
 		}
 
-		if (igt_live_test_end(&t))
-			err = -EIO;
+		if (igt_live_test_end(&t)) {
+			err = err ?: -EIO;
+			break;
+		}
 	}
 
 out:
-- 
2.39.2



