Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33D703708
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbjEORQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbjEORPx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83652106C5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 185EF62BB9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E67AC433D2;
        Mon, 15 May 2023 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170877;
        bh=D7f9Y9tCw+eV4lrKpXoQ6qRhWOFr7E2ILvqLevZBWm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsUuMcX28NkAxtA8NX4JNKy4P/WBTkR1YksKPE6z9suDOQk9Zr9Rf23sQNAtO+Z7k
         ir27RIRUAmmAGPgAm01hiKu687Utifafc2wJ4hoeWFvUISHwgmeRfYLRZCkLDMOX1E
         87PmaFhWLl94vXiY6Z11tiIi2gQPTcKjXV+0WDF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 029/242] drm/amd/display: Do not clear GPINT register when releasing DMUB from reset
Date:   Mon, 15 May 2023 18:25:55 +0200
Message-Id: <20230515161722.799470281@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit 99d92eaca5d915763b240aae24669f5bf3227ecf ]

[Why & How]
There's no need to clear GPINT register for DMUB
when releasing it from reset. Fix that.

Fixes: ac2e555e0a7f ("drm/amd/display: Add DMCUB source files and changes for DCN32/321")
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index b0adbf783aae9..9c20516be066c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -137,7 +137,6 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub)
 {
-	REG_WRITE(DMCUB_GPINT_DATAIN1, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
-- 
2.39.2



