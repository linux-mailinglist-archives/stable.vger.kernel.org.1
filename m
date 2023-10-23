Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7074C7D3086
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjJWK7n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJWK7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:59:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C710C0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:59:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BCCC433C8;
        Mon, 23 Oct 2023 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058780;
        bh=OXfv1tBhPKNFqsCOfXtEWehhdmZxIWEL9fWsyG9bdY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQHI3d1Z7c+DLnnZPm7DvBeTj710dERPBA183f1mG7HLk34nhhgS5m0yLhzXoSqn/
         ozRC9tKD0MePcTvM8diyJflgVk47npB4eX/BX4o3vyq7BqxHnFC8WiudWOQyQ4TdJD
         41lmmUgGgKAI4TZHWkOkUsxZLCt5winazxTd/Y44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH 4.14 06/66] drm/vmwgfx: fix typo of sizeof argument
Date:   Mon, 23 Oct 2023 12:55:56 +0200
Message-ID: <20231023104811.015572102@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

[ Upstream commit 39465cac283702a7d4a507a558db81898029c6d3 ]

Since size of 'header' pointer and '*header' structure is equal on 64-bit
machines issue probably didn't cause any wrong behavior. But anyway,
fixing typo is required.

Fixes: 7a73ba7469cb ("drm/vmwgfx: Use TTM handles instead of SIDs as user-space surface handles.")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230905100203.1716731-1-konstantin.meskhidze@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 996696ad6f988..3bb0a36260c20 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1836,7 +1836,7 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 	} *cmd;
 
 	SVGA3dTextureState *last_state = (SVGA3dTextureState *)
-	  ((unsigned long) header + header->size + sizeof(header));
+	  ((unsigned long) header + header->size + sizeof(*header));
 	SVGA3dTextureState *cur_state = (SVGA3dTextureState *)
 		((unsigned long) header + sizeof(struct vmw_tex_state_cmd));
 	struct vmw_resource_val_node *ctx_node;
-- 
2.40.1



