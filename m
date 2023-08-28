Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93878AC84
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjH1Kki (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjH1KkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392593
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB926402B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B171AC433C7;
        Mon, 28 Aug 2023 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219221;
        bh=VLC6lG1Cu4egGOG27iKqEbgISXxsVILGFNWE8VuyDRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5zBBDhTGpw3pNon+ekqF4qLL6dG+wuLE43b3XCuM9SmH/tc+SlBl/V0Dcd1IbFox
         ISbmimqM0NN2LC3Fh2695VBnZGx9bQfj/S5OX783CO25VoA3e4FsKcNlv18e1T3Ubt
         NJ6x8LB/UEuYg3/wpsANx+0TnYjpD2qi3usFKkkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <Jun.Lei@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 116/158] drm/amd/display: do not wait for mpc idle if tg is disabled
Date:   Mon, 28 Aug 2023 12:13:33 +0200
Message-ID: <20230828101201.234646694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josip Pavic <Josip.Pavic@amd.com>

[ Upstream commit 2513ed4f937999c0446fd824f7564f76b697d722 ]

[Why]
When booting, the driver waits for the MPC idle bit to be set as part of
pipe initialization. However, on some systems this occurs before OTG is
enabled, and since the MPC idle bit won't be set until the vupdate
signal occurs (which requires OTG to be enabled), this never happens and
the wait times out. This can add hundreds of milliseconds to the boot
time.

[How]
Do not wait for mpc idle if tg is disabled

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 5a25cefc0920 ("drm/amd/display: check TG is non-null before checking if enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index fa3acf60e7bd2..16b87af6f6628 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2902,7 +2902,8 @@ static void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
+			if (pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
 		}
-- 
2.40.1



