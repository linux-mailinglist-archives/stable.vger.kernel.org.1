Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C27A7FCC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjITMai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjITMae (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BBCE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F765C433C7;
        Wed, 20 Sep 2023 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213027;
        bh=nvUaA3/FWoVEbOq/u+U59kA3h7TGeSDOcAoSMZoDzX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQG/DJbwg2b4KKpwR2lQMu0xt5keoqiU7J135SuP5bhd0wOMomCLKihMiMDOb7Xnq
         R5vuIfFYyhbYHM3Oh7er28vrpAmB3xuMvZLWBxypfHL40qHKH1kdTxuItjYs6zaVD3
         yFKga3j6tcLEaVjbLOyqN7PUnYg+j0iD86sNfY1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 134/367] PCI: Add #defines for Enter Compliance, Transmit Margin
Date:   Wed, 20 Sep 2023 13:28:31 +0200
Message-ID: <20230920112902.167274902@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit bbdb2f5ecdf1e66b2f09710134db3c2e5c43a958 ]

Add definitions for the Enter Compliance and Transmit Margin fields of the
PCIe Link Control 2 register.

Link: https://lore.kernel.org/r/20191112173503.176611-2-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ce7d88110b9e ("drm/amdgpu: Use RMW accessors for changing LNKCTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index b485d8b0d5a79..5d830a95daf20 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -679,6 +679,8 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
+#define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.40.1



