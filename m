Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5276AF7F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjHAJs2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjHAJrv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AAF449C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FB6614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4235C433C8;
        Tue,  1 Aug 2023 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883174;
        bh=mS7vX7MXhLeVaULGyG6xSt1crhOn4XklG7btJeh8SVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKc7cn+bor1InigwnBfVSr3SBD/KcNWQytLAhkNGqtrqr0HnTpHd/y9jQAWPl43+h
         6UemVFpmkKUk4f5jwA+6gTK8wcHtXDllrZ0yW5kTCWnedWrFP8FyeAbuuIBvQsAlKH
         54haIOaq/F3rBgDjoIvC2RcTOB51C0NauryJisQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 124/239] drm/i915: Fix an error handling path in igt_write_huge()
Date:   Tue,  1 Aug 2023 11:19:48 +0200
Message-ID: <20230801091930.184475133@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e354f67733115b4453268f61e6e072e9b1ea7a2f ]

All error handling paths go to 'out', except this one. Be consistent and
also branch to 'out' here.

Fixes: c10a652e239e ("drm/i915/selftests: Rework context handling in hugepages selftests")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr
(cherry picked from commit 361ecaadb1ce3c5312c7c4c419271326d43899eb)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 99f39a5feca15..e86e75971ec60 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1190,8 +1190,10 @@ static int igt_write_huge(struct drm_i915_private *i915,
 	 * times in succession a possibility by enlarging the permutation array.
 	 */
 	order = i915_random_order(count * count, &prng);
-	if (!order)
-		return -ENOMEM;
+	if (!order) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	max_page_size = rounddown_pow_of_two(obj->mm.page_sizes.sg);
 	max = div_u64(max - size, max_page_size);
-- 
2.40.1



