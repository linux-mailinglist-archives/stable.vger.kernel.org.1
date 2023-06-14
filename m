Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E46726BE7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjFGU3F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjFGU3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6726AF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D043C644B3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0459C433D2;
        Wed,  7 Jun 2023 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169724;
        bh=JGCPjgjaisu6qWwe83OrdvqDtScNdKupDNcXuM3Y+Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZK0wzzY4daR+H/jO6PY/gXY5jyW8kT/yHOF8feBkGSDE60rL1N+3BDrtp+Se1O7UV
         beV3RH/JBpJYa7xJsqarH1vyqdgR2YHzuM0OH0ySHxGC+x5c27R/kJuWdjBRW5yKVo
         WdJ5QZgxaQ/VqYsIE7nbB8ZU1wJToOVjGrVFZOoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aric Cyr <aric.cyr@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 189/286] drm/amd/display: Only wait for blank completion if OTG active
Date:   Wed,  7 Jun 2023 22:14:48 +0200
Message-ID: <20230607200929.444279527@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 82a10aff9428f1d190de55ef7971fdb84303cc7a ]

[why]
If OTG is not active, waiting for blank completion will always fail and
timeout resulting in unnecessary driver delays.

[how]
Check that OTG is enabled before waiting for blank.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d4a1670a54506..f07cba121d010 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1093,7 +1093,8 @@ static void phantom_pipe_blank(
 			otg_active_height,
 			0);
 
-	hws->funcs.wait_for_blank_complete(opp);
+	if (tg->funcs->is_tg_enabled(tg))
+		hws->funcs.wait_for_blank_complete(opp);
 }
 
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
@@ -1156,6 +1157,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
 				if (tg->funcs->enable_crtc) {
 					int main_pipe_width, main_pipe_height;
+
 					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
 					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
 					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
-- 
2.39.2



