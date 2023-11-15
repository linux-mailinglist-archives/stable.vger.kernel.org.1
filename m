Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C2B7ED299
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjKOUmo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjKOTZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281571AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A4C433C7;
        Wed, 15 Nov 2023 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076346;
        bh=3oUvPTzSQPCA2Dnpx5H3RRXJ4gzbe3tu5kvWOdqWaXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPXzGE6ypTzrCp0kOAAIJcUQ5pwWm6x8c+dMJ7IUXUkXNL0KAbDNVE8Zgrf3qRc27
         mMkjeGAihv6q98GtQLJLZFem/nxkbTgt/RmGQrrT+mSSe0ByXARpTEw9KrVG1dWTOS
         vQpXIyr4W8fR1f0LVVu1oBlZUHPFF1Z2y/6PMyDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cong Liu <liucong2@kylinos.cn>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 234/550] drm/amd/display: Fix null pointer dereference in error message
Date:   Wed, 15 Nov 2023 14:13:38 -0500
Message-ID: <20231115191616.931662814@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Liu <liucong2@kylinos.cn>

[ Upstream commit 0c3601a2fbfb265ce283651480e30c8e60459112 ]

This patch fixes a null pointer dereference in the error message that is
printed when the Display Core (DC) fails to initialize. The original
message includes the DC version number, which is undefined if the DC is
not initialized.

Fixes: 9788d087caff ("drm/amd/display: improve the message printed when loading DC")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9959bd8147db..83d670f0d199b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1690,8 +1690,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
 			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
-		DRM_INFO("Display Core v%s failed to initialize on %s\n", DC_VER,
-			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
+		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
 		goto error;
 	}
 
-- 
2.42.0



