Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2B6FAB2C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEHLK1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjEHLKB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C92BCFD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67BF62B27
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D45C4339B;
        Mon,  8 May 2023 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544194;
        bh=rix6UicrSFSuwNlTAyAjtW4dtJE6YI4DzhI9eWvV56Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdz8x5VowbJjNwbfdJxIxIMUM+imWyXbqvjEo6C/dbe8eCMyh/QIpfSAmIJ7YZgi5
         rXpoXO8u2MJ9shHFDNUkpUx+D1JI3q1ZFnWLEpAElNfZlWz5TEpErRxq/+UiY9KoQA
         6uSTYospLfKVb48DeiVNW8bICsUclefCNTilQmvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cong Liu <liucong2@kylinos.cn>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 314/694] drm/i915: Fix memory leaks in i915 selftests
Date:   Mon,  8 May 2023 11:42:29 +0200
Message-Id: <20230508094442.492782459@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cong Liu <liucong2@kylinos.cn>

[ Upstream commit 803033c148f754f32da1b93926c49c22731ec485 ]

This patch fixes memory leaks on error escapes in function fake_get_pages

Fixes: c3bfba9a2225 ("drm/i915: Check for integer truncation on scatterlist creation")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230414224109.1051922-1-andi.shyti@linux.intel.com
(cherry picked from commit 8bfbdadce85c4c51689da10f39c805a7106d4567)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 01e75160a84ab..22890acd47b78 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -69,8 +69,10 @@ static int fake_get_pages(struct drm_i915_gem_object *obj)
 
 	rem = round_up(obj->base.size, BIT(31)) >> 31;
 	/* restricted by sg_alloc_table */
-	if (overflows_type(rem, unsigned int))
+	if (overflows_type(rem, unsigned int)) {
+		kfree(pages);
 		return -E2BIG;
+	}
 
 	if (sg_alloc_table(pages, rem, GFP)) {
 		kfree(pages);
-- 
2.39.2



