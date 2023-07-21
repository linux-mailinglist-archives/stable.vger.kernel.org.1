Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7266775D456
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGUTUE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGUTUD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369730ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD7961D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C7C433C7;
        Fri, 21 Jul 2023 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967198;
        bh=q+Ws4PAFV8sYpOcCyQlFS5KnAD83jj/hcI08letAsaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pb6dOg37gkSef3fJE2PN4gRksvGzfI6cdtfopygkFi7/h2FW3JTOdzI6RJO0A/aC
         KQ8Dr2FcjfeiWnqnXQT4xd34yRHo26AtjZsoTEa64FdisZlN3IZfwoQmmb5gRl/s2F
         RA8zAakm/uGWhdFd+kVafakHlG8tcIg79E/tGqzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/223] drm/i915: Fix one wrong caching mode enum usage
Date:   Fri, 21 Jul 2023 18:05:03 +0200
Message-ID: <20230721160522.990341162@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

[ Upstream commit 113899c2669dff148b2a5bea4780123811aecc13 ]

Commit a4d86249c773 ("drm/i915/gt: Provide a utility to create a scratch
buffer") mistakenly passed in uapi I915_CACHING_CACHED as argument to
i915_gem_object_set_cache_coherency(), which actually takes internal
enum i915_cache_level.

No functional issue since the value matches I915_CACHE_LLC (1 == 1), which
is the intended caching mode, but lets clean it up nevertheless.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: a4d86249c773 ("drm/i915/gt: Provide a utility to create a scratch buffer")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230707125503.3965817-1-tvrtko.ursulin@linux.intel.com
(cherry picked from commit 49c60b2f0867ac36fd54d513882a48431aeccae7)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 2eaeba14319e9..f4879f437bfa3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -611,7 +611,7 @@ __vm_create_scratch_for_read(struct i915_address_space *vm, unsigned long size)
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
-	i915_gem_object_set_cache_coherency(obj, I915_CACHING_CACHED);
+	i915_gem_object_set_cache_coherency(obj, I915_CACHE_LLC);
 
 	vma = i915_vma_instance(obj, vm, NULL);
 	if (IS_ERR(vma)) {
-- 
2.39.2



