Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9447F7ECEF0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjKOTpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjKOTpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A759E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB31DC433C8;
        Wed, 15 Nov 2023 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077509;
        bh=GH2b3HyTcvW9HF8u2Rd0Nw83mhDVPIeF3w+O2fjMVOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCEa80DquJCElHFfNpIzXA41zatjRiyMv9LAa5CcyvLZBssd5QgI/V4QuYXtXq0G3
         c73bdtNvi/0nW0ixBwvaTLL61UYEPLTCAj2U/Bx0jez0ZjiWoFsCkAVDbRv1s7ERHm
         qFUuNardBLYyZ4D3WzH940E2f5kwSk2bV3GXhM7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 321/603] memory: tegra: Set BPMP msg flags to reset IPC channels
Date:   Wed, 15 Nov 2023 14:14:26 -0500
Message-ID: <20231115191635.726241670@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit f344675a34383ae26a8230f4b1cd99cbd0defebd ]

Set the 'TEGRA_BPMP_MESSAGE_RESET' bit in newly added 'flags' field
of 'struct tegra_bpmp_message' to request for the reset of BPMP IPC
channels. This is used along with the 'suspended' check in BPMP driver
for handling early bandwidth requests due to the hotplug of CPU's
during system resume before the driver gets resumed.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra234.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 9e5b5dbd9c8df..2845041f32d69 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -986,6 +986,10 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	msg.rx.data = &bwmgr_resp;
 	msg.rx.size = sizeof(bwmgr_resp);
 
+	if (pclient->bpmp_id >= TEGRA_ICC_BPMP_CPU_CLUSTER0 &&
+	    pclient->bpmp_id <= TEGRA_ICC_BPMP_CPU_CLUSTER2)
+		msg.flags = TEGRA_BPMP_MESSAGE_RESET;
+
 	ret = tegra_bpmp_transfer(mc->bpmp, &msg);
 	if (ret < 0) {
 		dev_err(mc->dev, "BPMP transfer failed: %d\n", ret);
-- 
2.42.0



