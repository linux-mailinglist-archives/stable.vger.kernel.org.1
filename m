Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4154775904
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjHIK4o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjHIK4l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4F1FEA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E71762E4A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60186C433C8;
        Wed,  9 Aug 2023 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578599;
        bh=LlGtfBhE9IZR1o1wo2WVxe0E8PDg39/X2N1pBj8VWnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgucIjFUsdGkh9uJUig5ic0Fe69LzXk+gYvH0vnH8QkB6TDKD/3Ao3V2vtsBDNVbI
         +KTdEwq8un+Iv5sBiD46sxb7SHlChz7uYBUcODdeNmd9F5sErTKhfiRizyBUCph0YZ
         pkQW3051/sN/mSfsXl8RmjW64tsY7Q46U2II9mCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, George Shen <George.Shen@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Peichen Huang <PeiChen.Huang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 118/127] drm/amd/display: skip CLEAR_PAYLOAD_ID_TABLE if device mst_en is 0
Date:   Wed,  9 Aug 2023 12:41:45 +0200
Message-ID: <20230809103640.519019782@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peichen Huang <PeiChen.Huang@amd.com>

commit a1c9a1e27022d13c70a14c4faeab6ce293ad043b upstream.

[Why]
Some dock and mst monitor don't like to receive CLEAR_PAYLOAD_ID_TABLE
when mst_en is set to 0. It doesn't make sense to do so in source
side, either.

[How]
Don't send CLEAR_PAYLOAD_ID_TABLE if mst_en is 0

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ 6.1.y doesn't have the file rename from
  54618888d1ea7 ("drm/amd/display: break down dc_link.c") ]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2092,6 +2092,7 @@ static enum dc_status enable_link_dp_mst
 		struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
+	unsigned char mstm_cntl;
 
 	/* sink signal type after MST branch is MST. Multiple MST sinks
 	 * share one link. Link DP PHY is enable or training only once.
@@ -2100,7 +2101,9 @@ static enum dc_status enable_link_dp_mst
 		return DC_OK;
 
 	/* clear payload table */
-	dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
+	core_link_read_dpcd(link, DP_MSTM_CTRL, &mstm_cntl, 1);
+	if (mstm_cntl & DP_MST_EN)
+		dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
 
 	/* to make sure the pending down rep can be processed
 	 * before enabling the link


