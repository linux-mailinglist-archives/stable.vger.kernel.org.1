Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3262B713E55
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjE1Teg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjE1Tee (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD09BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E7E61DEA
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5167C433EF;
        Sun, 28 May 2023 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302473;
        bh=MXNu0FWdkJAoZoD81XoLIFEPKetyxw5nBcEGpKvSS5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEM1w8tDzRzCNB77h1QiPde8Vu8MszaWBt8OPHp0biEyYuN5y57uAtBxozyi+mmtK
         FXlF8SCooTZeFYU0fobD68bTw2Qg3gDn5JmyCOQoVvBS/06f1cAQd0QO/41XuASfUT
         AcMxb3F3ItRPPeAByYgJiEbd/yuUQUudasCLXDrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Gong, Richard" <richard.gong@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH 6.1 009/119] drm/amd/amdgpu: update mes11 api def
Date:   Sun, 28 May 2023 20:10:09 +0100
Message-Id: <20230528190835.666218139@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jack Xiao <Jack.Xiao@amd.com>

commit 1e7bbdba68baf6af7500dd636f18b6fcce58e945 upstream.

Update the api def of mes11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Tested-and-acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: "Gong, Richard" <richard.gong@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -222,7 +222,11 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t apply_grbm_remote_register_dummy_read_wa : 1;
 				uint32_t second_gfx_pipe_enabled : 1;
 				uint32_t enable_level_process_quantum_check : 1;
-				uint32_t reserved	: 25;
+				uint32_t legacy_sch_mode : 1;
+				uint32_t disable_add_queue_wptr_mc_addr : 1;
+				uint32_t enable_mes_event_int_logging : 1;
+				uint32_t enable_reg_active_poll : 1;
+				uint32_t reserved	: 21;
 			};
 			uint32_t	uint32_t_all;
 		};


