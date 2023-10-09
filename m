Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3B87BE0C0
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377398AbjJINnf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377397AbjJINnf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:43:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6F9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81763C433CA;
        Mon,  9 Oct 2023 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859013;
        bh=tZL6ot9i2uj7VkQTsBfHt5YHNraTwZf/UmVWHDrKJ2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1FognMkyDKvCbGzpJSAhXy3y+DvlMnBTNPJmALWjn3fivl2HqqGn5FI9Mp7F6iyv
         2e7fOAMOJyIuljMF0PpJ5HO1RVTGpBvoIQwUpAKCt3JN6DUdsdYqeLMerkwYW3yPCE
         8D7b6FKMjnaMhWhzu4q9Xx38GDPSs3WKM7nD/cfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10 171/226] drm/mediatek: Fix backport issue in mtk_drm_gem_prime_vmap()
Date:   Mon,  9 Oct 2023 15:02:12 +0200
Message-ID: <20231009130131.123904096@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

When building with clang:

  drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'void *' [-Wint-conversion]
    255 |                 return -ENOMEM;
        |                        ^~~~~~~
  1 error generated.

GCC reports the same issue as a warning, rather than an error.

Prior to commit 7e542ff8b463 ("drm/mediatek: Use struct dma_buf_map in
GEM vmap ops"), this function returned a pointer rather than an integer.
This function is indirectly called in drm_gem_vmap(), which treats NULL
as -ENOMEM through an error pointer. Return NULL in this block to
resolve the warning but keep the same end result.

Fixes: 43f561e809aa ("drm/mediatek: Fix potential memory leak if vmap() fail")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -252,7 +252,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_
 	if (!mtk_gem->kvaddr) {
 		kfree(sgt);
 		kfree(mtk_gem->pages);
-		return -ENOMEM;
+		return NULL;
 	}
 out:
 	kfree(sgt);


