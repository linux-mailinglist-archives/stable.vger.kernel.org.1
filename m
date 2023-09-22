Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C97AB543
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjIVPvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjIVPva (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 11:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FD100
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 08:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDD9C433CC;
        Fri, 22 Sep 2023 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695397884;
        bh=gcRAnlPPhzGuwjzkrCHq4S2a/cVRkBflII1JB2lJU+0=;
        h=From:Date:Subject:To:Cc:From;
        b=JHvghhh5aTrdwv45a5aWrV9EtLYm6O/9vhKmFFEfctQNsDIHMy43vZh3lrzOC4WIh
         9HFE4FJJ3rPMTLpeT2Ne64LLEbqnZijZFzjDN1adBAhHACEN+p1QChiQcGa168jMZk
         02mW2ZPTzjQemSkLGUmGoxJTOHEfykzZMqTyF0anhZO3cLHX8KrXayWZt4Z9KRISuI
         gQ2aaXAgrDplyaT5aJymsF3SBBnOZmkGW5IX0jNGegHwlL196tg/i+efdsb8xC5n7K
         9K0yZqnIdgUJKwvjlAf7zHGiPL5YUBOni23pD1Ow9yNWef17/16sJe30Jo2/RdMEfz
         8mY7vNtvTnlsQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Fri, 22 Sep 2023 08:51:17 -0700
Subject: [PATCH 5.10] drm/mediatek: Fix backport issue in
 mtk_drm_gem_prime_vmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-5-10-fix-drm-mediatek-backport-v1-1-912d76cd4a96@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPS3DWUC/x2NzQqDMBAGX0X23C2biIX0VUoPqfnSLuIPG5GC+
 O4GjwPDzE4Fpij0bHYybFp0niq4W0P9L05fsKbK5MW3Erznjp1w1j8nG3lE0rhi4E/sh2W2lQV
 4hNaHjCxUI4uhytfgRd3dCb2P4wS20nRBdgAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gcRAnlPPhzGuwjzkrCHq4S2a/cVRkBflII1JB2lJU+0=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKm82/9EyCus2b75RPjCBPGJ/svrueTihDxcJvx0WpU4a
 VYr19u/HaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAicx8y/PffKfCR9fm5E4Kb
 dj2Sdj+aFXDxn+RT0U+9t5139ee//3KIkeF48J+1P5WjTmz3DE+VPfz6oly/juoqX4cw9/AI3rk
 J//kA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
This is a fix for a 5.10 backport, so it has no upstream relevance but
I've still cc'd the relevant maintainers in case they have any comments
or want to double check my work.
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index fe64bf2176f3..b20ea58907c2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -252,7 +252,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->kvaddr) {
 		kfree(sgt);
 		kfree(mtk_gem->pages);
-		return -ENOMEM;
+		return NULL;
 	}
 out:
 	kfree(sgt);

---
base-commit: ff0bfa8f23eb4c5a65ee6b0d0b7dc2e3439f1063
change-id: 20230922-5-10-fix-drm-mediatek-backport-0ee69329fef0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

