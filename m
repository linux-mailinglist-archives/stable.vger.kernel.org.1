Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90770C8B8
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjEVTlS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEVTlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF0E7E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15AA062A10
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21011C433D2;
        Mon, 22 May 2023 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784434;
        bh=uFEzZbX4LfvZqXu7IrmCsuQyBM9CZ/XPyVzc2wUM2GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcCb9yrHLym/T4ly6cW1gxzHjwMwa5u0/ntEldW4Vc5BDz/MSNkfKxoBGnCp9mIns
         WSReeENTXl7TcNVTBRphH4+NjUAb6XvyNflSta6Z9IuG6Dw9UJbjx5EbysUqJXsnig
         zDbJQ90gXsPlPeNddU6vtIMhHBB7cTWpxw0GLBlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lyndonli <Lyndon.Li@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 082/364] drm/amdgpu: Fix sdma v4 sw fini error
Date:   Mon, 22 May 2023 20:06:27 +0100
Message-Id: <20230522190414.817884653@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: lyndonli <Lyndon.Li@amd.com>

[ Upstream commit 5e08e9c742a00384e5abe74bd40cf4dc15cb3a2e ]

Fix sdma v4 sw fini error for sdma 4.2.2 to
solve the following general protection fault

[  +0.108196] general protection fault, probably for non-canonical
address 0xd5e5a4ae79d24a32: 0000 [#1] PREEMPT SMP PTI
[  +0.000018] RIP: 0010:free_fw_priv+0xd/0x70
[  +0.000022] Call Trace:
[  +0.000012]  <TASK>
[  +0.000011]  release_firmware+0x55/0x80
[  +0.000021]  amdgpu_ucode_release+0x11/0x20 [amdgpu]
[  +0.000415]  amdgpu_sdma_destroy_inst_ctx+0x4f/0x90 [amdgpu]
[  +0.000360]  sdma_v4_0_sw_fini+0xce/0x110 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8b8ddf0502661..a4d84e3fe9381 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1870,7 +1870,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
-	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
-- 
2.39.2



