Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA637553F1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGPUYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD59F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19CA960DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D9BC433C8;
        Sun, 16 Jul 2023 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539083;
        bh=JYMdX+FjnYWvL3DpBpxUt/OcuqecO4ZzHWLddzt6qyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e66f/ERvuK73yrlJX3rLkjrp5PvOEFZF8m6YR7SMUkO+0zun7n9PUpv/1Hnugnx9z
         drfl77PdHRSHUqzDNAp92PdzoUrfNDnMhSK0K6AUSpH829L3iFdVhakcvEh04a4x+V
         vxbqgjpgRBkOyDN3EKK3SWG30KBQEN9JscFZ7Nco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filip Hejsek <filip.hejsek@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 681/800] drm/amd: Dont try to enable secure display TA multiple times
Date:   Sun, 16 Jul 2023 21:48:54 +0200
Message-ID: <20230716195004.943236832@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
index a150b7a4b4aae..e4757a2807d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1947,6 +1947,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
 			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+		/* don't try again */
+		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
 	}
 
 	return 0;
-- 
2.39.2



