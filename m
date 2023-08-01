Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59E76ADB0
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjHAJbj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjHAJbH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266492D71
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A5D614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0EFC433CC;
        Tue,  1 Aug 2023 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882202;
        bh=ze6kmQ3r7UqTDogfJhqBwT2aGGzgxuSSSizaNcVqibU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3yAO+IXbe7m73wvSzS2ZhRceMHdQQYbs6DIfn/YQxIvZ5tqavVklffsC1ULJYbYk
         MNlw81VbJ1Hku67/fBbHG6xOe1c6L42NVEKrGIrIPpK5zIwYRPM+0C7YqOOzRQF2IL
         q/3qcKSvscyAfUD0+FSxqKBM/hJjN81ejnM2sYag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Agustin Gutierrez <agustin.gutierrez@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 005/228] drm/amd/display: Keep PHY active for dp config
Date:   Tue,  1 Aug 2023 11:17:43 +0200
Message-ID: <20230801091923.015668714@linuxfoundation.org>
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

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

commit 2b02d746c1818baf741f4eeeff9b97ab4b81e1cf upstream.

[Why]
Current hotplug sequence causes temporary hang at the re-entry of the
optimized power state.

[How]
Keep a PHY active when detecting DP signal + DPMS active

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -108,6 +108,11 @@ static int dcn314_get_active_display_cnt
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {


