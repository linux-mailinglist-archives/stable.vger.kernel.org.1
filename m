Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8173075D37F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGUTLX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGUTLW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617911BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE0B61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6ECC433C8;
        Fri, 21 Jul 2023 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966680;
        bh=TVfaeV+ks4o3miTCbPXHXe1/1XS5YoK7MAOAL3l2Njo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hi6tZAVSsPBusTlDkZ7buqRpxZx3fH9sGy8GDuQGXO4KeB896D4ABXdRaV2V1nNO6
         05OVI1uepS+X203O1GeFK0+r6RhA4aR8KiK187oWolUTFe69muSdIdEwjE4UARctaY
         UBTwGGKOYc5+hXt5+EDFsnyH2+4QIBysQoYRQnE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 429/532] drm/i915: Fix one wrong caching mode enum usage
Date:   Fri, 21 Jul 2023 18:05:33 +0200
Message-ID: <20230721160637.840956454@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index 2d3a979736cc1..f9d4094916e3d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -547,7 +547,7 @@ __vm_create_scratch_for_read(struct i915_address_space *vm, unsigned long size)
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
-	i915_gem_object_set_cache_coherency(obj, I915_CACHING_CACHED);
+	i915_gem_object_set_cache_coherency(obj, I915_CACHE_LLC);
 
 	vma = i915_vma_instance(obj, vm, NULL);
 	if (IS_ERR(vma)) {
-- 
2.39.2



