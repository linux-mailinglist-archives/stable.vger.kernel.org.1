Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47579BBD7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbjIKWXQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjIKOlf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:41:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD86E6
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:41:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3FC433C7;
        Mon, 11 Sep 2023 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443290;
        bh=9baWlwcoS7h7hN1gD3jsuvWs0pImbr2IQin+4CGGsZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPnWVCkLOVTAKZcH5rkSGVm1nfK6ApslUch9fyUkxb0z9dGRBMz/6+Udjdzzgkc4d
         l4B2RuJ0SBV40obehTZqPo8h88NbqWfGlylkZLt7OVfqmwlvewyd+eIf/0pkR2OHhc
         VBIT94GpT1IDK7Um54jmg4f/TNZUM3RXoaBa/ghA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 325/737] drm/bridge: anx7625: Use common macros for HDCP capabilities
Date:   Mon, 11 Sep 2023 15:43:04 +0200
Message-ID: <20230911134659.629670367@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 41639b3a8b0f1f194dfe0577d99db70613f78626 ]

The DRM DP code has macros for the DP HDCP capabilities. Use them in the
anx7625 driver instead of raw numbers.

Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230710091203.1874317-1-wenst@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 4f1286d948bde..666a2b5c0c5c0 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -873,11 +873,11 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
 	}
 
 	/* Read downstream capability */
-	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, DP_AUX_HDCP_BCAPS, 1, &bcap);
 	if (ret < 0)
 		return ret;
 
-	if (!(bcap & 0x01)) {
+	if (!(bcap & DP_BCAPS_HDCP_CAPABLE)) {
 		pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
 		return 0;
 	}
-- 
2.40.1



