Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546377556CB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjGPUyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGPUyI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84779E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228DC60E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F91C433C8;
        Sun, 16 Jul 2023 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540846;
        bh=LLKQHnej0ML21gq3UooSclP0rCrTMJhT/RjP/2hTKIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdAx8jick83n9FdgikUfpHPwgVLFspEoSLDxlUbgbXZzGvT6prnKEJpwNjSYh2tNl
         ZB5IguwaiJqiJZlrf1tPE0EMUKG4591+DXhSZ7VcJOHjr75VIE6KqFFul/2o3VMfwN
         mu7PhXA97yhb7hzq1HITLD1XzFCM1Sis4kFchBPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filip Hejsek <filip.hejsek@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 491/591] drm/amd: Dont try to enable secure display TA multiple times
Date:   Sun, 16 Jul 2023 21:50:30 +0200
Message-ID: <20230716194936.593764082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 5c6d52ff4b61e5267b25be714eb5a9ba2a338199 ]

If the securedisplay TA failed to load the first time, it's unlikely
to work again after a suspend/resume cycle or reset cycle and it appears
to be causing problems in futher attempts.

Fixes: e42dfa66d592 ("drm/amdgpu: Add secure display TA load for Renoir")
Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2633
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a3cd816f98a14..0af9fb4098e8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1959,6 +1959,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
 			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+		/* don't try again */
+		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
 	}
 
 	return 0;
-- 
2.39.2



