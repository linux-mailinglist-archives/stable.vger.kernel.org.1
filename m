Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6E703689
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbjEORLK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbjEORKu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AFDDA8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5762F62103
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D837C4339B;
        Mon, 15 May 2023 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170538;
        bh=Ij2MPBpicVaoUxHh4iI46HT+B/nAyHsmpx57MDj6Woo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRsREMEp3mOV5LtZ0+/EOQCy8xMrRiyZ52se9SIcEK2lqzbHx9pA+eH7AXQogBcvF
         UlxHgvhr4SgVLTZprSorZ9u4dSHWRTvbiZrIQtsB6OnbfpNtLlxCl2hwtyv8ahJYI0
         /TH7bxLO1xgpewK5X8fQ8DMmw8aurhspkJFh/gu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <Alvin.Lee2@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Samson Tam <Samson.Tam@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 163/239] drm/amd/display: filter out invalid bits in pipe_fuses
Date:   Mon, 15 May 2023 18:27:06 +0200
Message-Id: <20230515161726.562064875@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Samson Tam <Samson.Tam@amd.com>

commit 682439fffad9fa9a38d37dd1b1318e9374232213 upstream.

[Why]
Reading pipe_fuses from register may have invalid bits set, which may
 affect the num_pipes erroneously.

[How]
Add read_pipes_fuses() call and filter bits based on expected number
 of pipes.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   |   10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c |   10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2037,6 +2037,14 @@ static struct resource_funcs dcn32_res_p
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN32 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn32_resource_construct(
 	uint8_t num_virtual_links,
@@ -2079,7 +2087,7 @@ static bool dcn32_resource_construct(
 	pool->base.res_cap = &res_cap_dcn32;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1621,6 +1621,14 @@ static struct resource_funcs dcn321_res_
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN321 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn321_resource_construct(
 	uint8_t num_virtual_links,
@@ -1663,7 +1671,7 @@ static bool dcn321_resource_construct(
 	pool->base.res_cap = &res_cap_dcn321;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)


