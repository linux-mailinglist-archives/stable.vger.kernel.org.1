Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C37035F5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbjEORFQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbjEOREk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A393DD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA4362A99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF17C433D2;
        Mon, 15 May 2023 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170120;
        bh=dHW02TEX4HRwZjYJpY7MjbGKJ2AYw+w85shl+OROI10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4M3GO8vD7YaMLsHSCQbI4l3KHn36a5QvEjQt8/uoyUzIaNB7Tv8bAD8qev+nFnbU
         zmlSOgRewQ1l8Y2lS//DkyXxvrn1KeOIktOtxVXpu2A61YMSawT5uQq3dR/RlZegTL
         CteEgVqI5qZ7zewGelfL1XnRqppedlr8W+Hbeu3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cruise Hung <Cruise.Hung@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/239] drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset
Date:   Mon, 15 May 2023 18:24:54 +0200
Message-Id: <20230515161722.651645571@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cruise Hung <Cruise.Hung@amd.com>

[ Upstream commit 425afa0ac99a05b39e6cd00704fa0e3e925cee2b ]

[Why & How]
We missed resetting OUTBOX0 mailbox r/w pointer on DMUB reset.
Fix it.

Fixes: 6ecf9773a503 ("drm/amd/display: Fix DMUB outbox trace in S4 (#4465)")
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index a76da0131addd..b0adbf783aae9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -130,6 +130,8 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 }
 
-- 
2.39.2



