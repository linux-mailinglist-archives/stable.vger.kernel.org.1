Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4779AD53
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbjIKV7l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbjIKO1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8096FF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A5C433C9;
        Mon, 11 Sep 2023 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442419;
        bh=HqJej2VhvL56kTYtMY2/13/oZlQnzCXVjs2DnoDulW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHOvM6SErZN3FrrgVyEXTDfe0cqdD+oIZSsxd0iwszR2ws4PcbP9TKoQ1QOoy1FH1
         eFrgHAceGsB0Zt4wqVbptvEMeSmWAEdwwkQt4BHGI7nix5pSrVVVgAOO5b+LPNUq0k
         bCYYfPq0k9VaTK6tgsb5XCxpz9kceU1TvlhrPS8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Jun Lei <jun.lei@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 002/737] Partially revert "drm/amd/display: Fix possible underflow for displays with large vblank"
Date:   Mon, 11 Sep 2023 15:37:41 +0200
Message-ID: <20230911134650.366330839@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit a99a4ff6ef205d125002fc7e0857074e4e6597b6 ]

This partially reverts commit de231189e7bf ("drm/amd/display: Fix
possible underflow for displays with large vblank").

[Why]
The increased value of VBlankNomDefaultUS causes underflow at the
desktop of an IP KVM setup

[How]
Change the value from 800 back to 668

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index b878effa2129b..b428a343add9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 800,
+	.VBlankNomDefaultUS = 668,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
-- 
2.40.1



