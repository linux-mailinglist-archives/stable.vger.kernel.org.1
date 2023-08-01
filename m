Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D519B76AEC4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHAJlq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjHAJlW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2305581
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B99614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F71C433C7;
        Tue,  1 Aug 2023 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882746;
        bh=mIoDyg6W0uMcmP4ZAvk1kLWEFLfKC+Kga8Vc2WXp9PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l56qWhx61Oc/CPyKDJ7bhKJW4ZuHXn2qab0KBmjqxnKlMXXN90vGSz6q+0IU20fOD
         6Q8n5BzvWA6g0IaImMjyOYoFrn8UOM1GtzFJUGLfkl74M+PXmu8Q+qB45IAafl1CB4
         wStUo7uE6FR6RbNoTlHK0hFLDe1Oem3jXLd9Bj8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Broadworth <mark.broadworth@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 217/228] drm/amd/display: set per pipe dppclk to 0 when dpp is off
Date:   Tue,  1 Aug 2023 11:21:15 +0200
Message-ID: <20230801091930.696770705@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

commit 6609141c49df1b86fbad26a8643d4b4044f28b11 upstream.

The 'commit 52e4fdf09ebc ("drm/amd/display: use low clocks for no plane
configs")' introduced a change that set low clock values for DCN31 and
DCN32. As a result of these changes, DC started to spam the log with the
following warning:

------------[ cut here ]------------
WARNING: CPU: 8 PID: 1486 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dccg.c:58
dccg2_update_dpp_dto+0x3f/0xf0 [amdgpu]
[..]
CPU: 8 PID: 1486 Comm: kms_atomic Tainted: G W 5.18.0+ #1
RIP: 0010:dccg2_update_dpp_dto+0x3f/0xf0 [amdgpu]
RSP: 0018:ffffbbd8025334d0 EFLAGS: 00010206
RAX: 00000000000001ee RBX: ffffa02c87dd3de0 RCX: 00000000000a7f80
RDX: 000000000007dec3 RSI: 0000000000000000 RDI: ffffa02c87dd3de0
RBP: ffffbbd8025334e8 R08: 0000000000000001 R09: 0000000000000005
R10: 00000000000331a0 R11: ffffffffc0b03d80 R12: ffffa02ca576d000
R13: ffffa02cd02c0000 R14: 00000000001453bc R15: ffffa02cdc280000
[..]
dcn20_update_clocks_update_dpp_dto+0x4e/0xa0 [amdgpu]
dcn32_update_clocks+0x5d9/0x650 [amdgpu]
dcn20_prepare_bandwidth+0x49/0x100 [amdgpu]
dcn30_prepare_bandwidth+0x63/0x80 [amdgpu]
dc_commit_state_no_check+0x39d/0x13e0 [amdgpu]
dc_commit_streams+0x1f9/0x3b0 [amdgpu]
dc_commit_state+0x37/0x120 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x5e5/0x2520 [amdgpu]
? _raw_spin_unlock_irqrestore+0x1f/0x40
? down_trylock+0x2c/0x40
? vprintk_emit+0x186/0x2c0
? vprintk_default+0x1d/0x20
? vprintk+0x4e/0x60

We can easily trigger this issue by using a 4k@120 or a 2k@165 and
running some of the kms_atomic tests. This warning is triggered because
the per-pipe clock update is not happening; this commit fixes this issue
by ensuring that DPPCLK is updated when calculating the watermark and
dlg is invoked.

Fixes: 2641c7b78081 ("drm/amd/display: use low clocks for no plane configs")
Reported-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c |    3 +++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -559,6 +559,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream)
+				context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 	}
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1305,7 +1305,10 @@ static void dcn32_calculate_dlg_params(s
 
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		else
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}


