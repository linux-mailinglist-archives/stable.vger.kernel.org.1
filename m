Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5F74C323
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjGIL2s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGIL2r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278E13D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B5160BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4856C433C9;
        Sun,  9 Jul 2023 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902126;
        bh=7AK7hLIocVtFyxnPHY8/QIce8fh/Z4Jjwn0UOZwpTF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb/dG2LxBO80o7ojBZMA1uftkb7kYKYTlOGJINfQKvvD1dfhPfOwo1r4DXITZlb24
         ej5QRYbJxxegykHWObjmyA9pBQIyMbpeRAV9Lu0mAilN2XuSDdqqiUm7VFtiGfxl0a
         j7mwDxqbJdcyjSOT/AkHBw4nqb4JQ0cjmm8azLeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 264/431] drm/msm/dpu: always clear every individual pending flush mask
Date:   Sun,  9 Jul 2023 13:13:32 +0200
Message-ID: <20230709111457.338099071@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuogee Hsieh <quic_khsieh@quicinc.com>

[ Upstream commit 625cbb077007698060b12d0ae5657a4d8411b153 ]

There are two tiers of pending flush control, top level and
individual hardware block. Currently only the top level of
flush mask is reset to 0 but the individual pending flush masks
of particular hardware blocks are left at their previous values,
eventually accumulating all possible bit values and typically
flushing more than necessary.
Reset all individual hardware block flush masks to 0 to avoid
accidentally flushing them.

Changes in V13:
-- rewording commit text
-- add an empty space line as suggested

Changes in V14:
-- add Fixes tag

Fixes: 73bfb790ac78 ("msm:disp:dpu1: setup display datapath for SC7180 target")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Patchwork: https://patchwork.freedesktop.org/patch/539508/
Link: https://lore.kernel.org/r/1685036458-22683-8-git-send-email-quic_khsieh@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 3ef2e37b41087..4072638c37918 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -115,6 +115,9 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
 	trace_dpu_hw_ctl_clear_pending_flush(ctx->pending_flush_mask,
 				     dpu_hw_ctl_get_flush_register(ctx));
 	ctx->pending_flush_mask = 0x0;
+	ctx->pending_intf_flush_mask = 0;
+	ctx->pending_wb_flush_mask = 0;
+	ctx->pending_merge_3d_flush_mask = 0;
 }
 
 static inline void dpu_hw_ctl_update_pending_flush(struct dpu_hw_ctl *ctx,
-- 
2.39.2



