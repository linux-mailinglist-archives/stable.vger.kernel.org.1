Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1F761349
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjGYLJY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjGYLJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8D2D53
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E26176166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E84C433C8;
        Tue, 25 Jul 2023 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283275;
        bh=sAf9qbD3p5QELsfBa9+L+SSF0rD5lxPxrmG35ziB5lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEMD0Go67yrid2Dz1eNthhPm+O/SKeHyV2RBztOF/rhkepkNJy9WpYjs+fffPgggV
         BOHl/eLfLcZADRH9WXMtUFeDF0+NhOnWbLK1LX+ekvxN9+z88XLqfFkycmRRFnQnqh
         KI6mIkGc147XJv+MxFMb8KKBYLZ0C+vFQ9xxRGNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>, Alan Liu <haoping.liu@amd.com>,
        Zhikai Zhai <zhikai.zhai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.15 18/78] drm/amd/display: Disable MPC split by default on special asic
Date:   Tue, 25 Jul 2023 12:46:09 +0200
Message-ID: <20230725104452.042579931@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhikai Zhai <zhikai.zhai@amd.com>

commit a460beefe77d780ac48f19d39333852a7f93ffc1 upstream.

[WHY]
All of pipes will be used when the MPC split enable on the dcn
which just has 2 pipes. Then MPO enter will trigger the minimal
transition which need programe dcn from 2 pipes MPC split to 2
pipes MPO. This action will cause lag if happen frequently.

[HOW]
Disable the MPC split for the platform which dcn resource is limited

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options deb
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,


