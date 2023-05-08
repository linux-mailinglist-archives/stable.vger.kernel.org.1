Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639C6FAA84
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjEHLDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjEHLCu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410330E5A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F196562A49
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F375BC433D2;
        Mon,  8 May 2023 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543729;
        bh=0YrKf/beVTk1AI+yMEjg4ld6p9qdHxmCpEpdASI0VX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5RYQG/Fjd/paZYm4Jedc+TNTFxTUHs3zo+MR0Pjw1ae8QTPf55/UMpe1l+hJ7BmP
         NLVpk40V1ehV6qXUex9DTMHICTfSuAr+fp3X6yIG5KPetuS4Xr3uuhQtp99D4gMBcc
         y+lBUcNzfqzH5H4fXH05s0R9m6pYKO3+TCklT7MY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 151/694] drm/rockchip: Drop unbalanced obj unref
Date:   Mon,  8 May 2023 11:39:46 +0200
Message-Id: <20230508094437.336300851@linuxfoundation.org>
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

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 8ee3b0e85f6ccd9e6c527bc50eaba774c3bb18d0 ]

In the error path, rockchip_drm_gem_object_mmap() is dropping an obj
reference that it doesn't own.

Fixes: 41315b793e13 ("drm/rockchip: use drm_gem_mmap helpers")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230119231734.2884543-1-robdclark@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 8ea09d915c3ca..6c0800083aad8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -261,9 +261,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
-- 
2.39.2



