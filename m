Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A670C722
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjEVT0N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjEVT0M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470AA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010786289E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDFBC4339B;
        Mon, 22 May 2023 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783570;
        bh=cv8JJGXNWBr26hY0SkfA4Eso+vQuOnX6tOzJprj6XyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcrtIRHobN2VwRRkluIGfTCmJZHlk3p/xGrG8aTT6Phqxkl4TLKSaLwgbo5i8oEt9
         nbgC1WPJamfaYAda0dYkWe3WPB6BMQChoIu92xURHSnlVyaoUVUw3QWN+2Dc8YyZks
         SzkJvnW52dKr3JsFVMqkkECmwQinvZH1VsXyP0bA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nur Hussein <hussein@unixcat.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/292] drm/tegra: Avoid potential 32-bit integer overflow
Date:   Mon, 22 May 2023 20:06:58 +0100
Message-Id: <20230522190407.473645183@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Nur Hussein <hussein@unixcat.org>

[ Upstream commit 2429b3c529da29d4277d519bd66d034842dcd70c ]

In tegra_sor_compute_config(), the 32-bit value mode->clock is
multiplied by 1000, and assigned to the u64 variable pclk. We can avoid
a potential 32-bit integer overflow by casting mode->clock to u64 before
we do the arithmetic and assignment.

Signed-off-by: Nur Hussein <hussein@unixcat.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/sor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 8af632740673a..77723d5f1d3fd 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1153,7 +1153,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
 				    struct drm_dp_link *link)
 {
 	const u64 f = 100000, link_rate = link->rate * 1000;
-	const u64 pclk = mode->clock * 1000;
+	const u64 pclk = (u64)mode->clock * 1000;
 	u64 input, output, watermark, num;
 	struct tegra_sor_params params;
 	u32 num_syms_per_line;
-- 
2.39.2



