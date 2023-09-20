Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D357A7DF1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjITMNq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjITMNp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA3E6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58715C433C7;
        Wed, 20 Sep 2023 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212017;
        bh=+VEVHrE7Sls/9En7ozakCXSsWJ8Vm5lKCblRfF4k5Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJcxuDiQYuruW6po4VIlmpj/gPn+A64ZhLcf2RNf1EY2KAvp0hlGPT9T1YasdI+II
         LMZEiwwtM8BxXbrRG8jhHLDCKtvP5ZyzUlEBYtqu7GQ+gVq2aPOjsbpAWNGVUd0wMa
         kGvE4ibPiuBI4WtMCbcs55/o6BMr9uNCq36RBaYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 119/273] drm/radeon: Correct Transmit Margin masks
Date:   Wed, 20 Sep 2023 13:29:19 +0200
Message-ID: <20230920112850.168870461@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 40bd4be5a652ce56068a8273b68caa38cb0d8f4b ]

Previously we masked PCIe Link Control 2 register values with "7 << 9",
which was apparently intended to be the Transmit Margin field, but instead
was the high order bit of Transmit Margin, the Enter Modified Compliance
bit, and the Compliance SOS bit.

Correct the mask to "7 << 7", which is the Transmit Margin field.

Link: https://lore.kernel.org/r/20191112173503.176611-3-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 7189576e8a82 ("drm/radeon: Use RMW accessors for changing LNKCTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/cik.c | 8 ++++----
 drivers/gpu/drm/radeon/si.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 827d551962d98..bd009d12b1571 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9615,13 +9615,13 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 639f0698f961c..7ed5d7970108c 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7198,13 +7198,13 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
-- 
2.40.1



