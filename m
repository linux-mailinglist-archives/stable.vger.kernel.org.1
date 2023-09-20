Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA26D7A7DE8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjITMNY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjITMNX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9CDE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC8C433C7;
        Wed, 20 Sep 2023 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211996;
        bh=RprdOrBj+KKDX1p8tLBX4/0t2nNZQU0QCcR5tuD3e1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yz13Z+7LDBT/tdEGL0ezydQJPbbpTjoDwIFZ7fUGs2CVN+4tXZGpi0aFAI+FzFguT
         2mrSugCxutBkLYu3F83gpxT6TNHBw6yYDUEo5Cx0j1Qs9amdfZTXWi7YoZb0ML7we8
         aW5D02t09Qj6V4HM6rrisVevuqLhwpoal1a4AP/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/273] PCI: Cleanup register definition width and whitespace
Date:   Wed, 20 Sep 2023 13:29:12 +0200
Message-ID: <20230920112849.943558123@linuxfoundation.org>
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

[ Upstream commit 35d0a06dad2220d62042fd1a91a216d17744e724 ]

Follow the file conventions of:

  - register offsets not indented
  - fields within a register indented one space
  - field masks use same width as register
  - register field values indented an additional space

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: ce7d88110b9e ("drm/amdgpu: Use RMW accessors for changing LNKCTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/pci_regs.h | 132 +++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4c7aa15b0e2ee..9fd0cb2f9d12d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- *	pci_regs.h
- *
  *	PCI standard defines
  *	Copyright 1994, Drew Eckhardt
  *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
@@ -15,7 +13,7 @@
  *	PCI System Design Guide
  *
  *	For HyperTransport information, please consult the following manuals
- *	from http://www.hypertransport.org
+ *	from http://www.hypertransport.org :
  *
  *	The HyperTransport I/O Link Specification
  */
@@ -300,7 +298,7 @@
 #define  PCI_SID_ESR_FIC	0x20	/* First In Chassis Flag */
 #define PCI_SID_CHASSIS_NR	3	/* Chassis Number */
 
-/* Message Signalled Interrupts registers */
+/* Message Signalled Interrupt registers */
 
 #define PCI_MSI_FLAGS		2	/* Message Control */
 #define  PCI_MSI_FLAGS_ENABLE	0x0001	/* MSI feature enabled */
@@ -318,7 +316,7 @@
 #define PCI_MSI_MASK_64		16	/* Mask bits register for 64-bit devices */
 #define PCI_MSI_PENDING_64	20	/* Pending intrs for 64-bit devices */
 
-/* MSI-X registers */
+/* MSI-X registers (in MSI-X capability) */
 #define PCI_MSIX_FLAGS		2	/* Message Control */
 #define  PCI_MSIX_FLAGS_QSIZE	0x07FF	/* Table size */
 #define  PCI_MSIX_FLAGS_MASKALL	0x4000	/* Mask all vectors for this function */
@@ -332,13 +330,13 @@
 #define PCI_MSIX_FLAGS_BIRMASK	PCI_MSIX_PBA_BIR /* deprecated */
 #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
 
-/* MSI-X Table entry format */
+/* MSI-X Table entry format (in memory mapped by a BAR) */
 #define PCI_MSIX_ENTRY_SIZE		16
-#define  PCI_MSIX_ENTRY_LOWER_ADDR	0
-#define  PCI_MSIX_ENTRY_UPPER_ADDR	4
-#define  PCI_MSIX_ENTRY_DATA		8
-#define  PCI_MSIX_ENTRY_VECTOR_CTRL	12
-#define   PCI_MSIX_ENTRY_CTRL_MASKBIT	1
+#define PCI_MSIX_ENTRY_LOWER_ADDR	0  /* Message Address */
+#define PCI_MSIX_ENTRY_UPPER_ADDR	4  /* Message Upper Address */
+#define PCI_MSIX_ENTRY_DATA		8  /* Message Data */
+#define PCI_MSIX_ENTRY_VECTOR_CTRL	12 /* Vector Control */
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
 
 /* CompactPCI Hotswap Register */
 
@@ -464,19 +462,19 @@
 /* PCI Express capability registers */
 
 #define PCI_EXP_FLAGS		2	/* Capabilities register */
-#define PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
-#define PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
-#define  PCI_EXP_TYPE_ENDPOINT	0x0	/* Express Endpoint */
-#define  PCI_EXP_TYPE_LEG_END	0x1	/* Legacy Endpoint */
-#define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
-#define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
-#define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIe to PCI/PCI-X Bridge */
-#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
-#define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
-#define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
-#define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
-#define PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define  PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
+#define  PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
+#define   PCI_EXP_TYPE_ENDPOINT	   0x0	/* Express Endpoint */
+#define   PCI_EXP_TYPE_LEG_END	   0x1	/* Legacy Endpoint */
+#define   PCI_EXP_TYPE_ROOT_PORT   0x4	/* Root Port */
+#define   PCI_EXP_TYPE_UPSTREAM	   0x5	/* Upstream Port */
+#define   PCI_EXP_TYPE_DOWNSTREAM  0x6	/* Downstream Port */
+#define   PCI_EXP_TYPE_PCI_BRIDGE  0x7	/* PCIe to PCI/PCI-X Bridge */
+#define   PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
+#define   PCI_EXP_TYPE_RC_END	   0x9	/* Root Complex Integrated Endpoint */
+#define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
+#define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
+#define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
 #define PCI_EXP_DEVCAP		4	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
@@ -621,8 +619,8 @@
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
 #define PCI_EXP_RTSTA		32	/* Root Status */
-#define PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
-#define PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
+#define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
+#define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
 /*
  * The Device Capabilities 2, Device Status 2, Device Control 2,
  * Link Capabilities 2, Link Status 2, Link Control 2,
@@ -642,13 +640,13 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
-#define PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
-#define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
-#define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
+#define  PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
+#define  PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
@@ -664,11 +662,11 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
-#define PCI_EXP_LNKCTL2_TLS		0x000f
-#define PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
-#define PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS		0x000f
+#define  PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
@@ -757,18 +755,18 @@
 #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
 #define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
-#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001 /* Correctable Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
 #define PCI_ERR_ROOT_STATUS	48
-#define PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
-#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
-#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
-#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
-#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
-#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
-#define PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
-#define PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
+#define  PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
+#define  PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
+#define  PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
+#define  PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
+#define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
+#define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	52	/* Error Source Identification */
 
 /* Virtual Channel */
@@ -879,12 +877,12 @@
 
 /* Page Request Interface */
 #define PCI_PRI_CTRL		0x04	/* PRI control register */
-#define  PCI_PRI_CTRL_ENABLE	0x01	/* Enable */
-#define  PCI_PRI_CTRL_RESET	0x02	/* Reset */
+#define  PCI_PRI_CTRL_ENABLE	0x0001	/* Enable */
+#define  PCI_PRI_CTRL_RESET	0x0002	/* Reset */
 #define PCI_PRI_STATUS		0x06	/* PRI status register */
-#define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
-#define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
-#define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_RF	0x0001	/* Response Failure */
+#define  PCI_PRI_STATUS_UPRGI	0x0002	/* Unexpected PRG index */
+#define  PCI_PRI_STATUS_STOPPED	0x0100	/* PRI Stopped */
 #define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
@@ -902,16 +900,16 @@
 
 /* Single Root I/O Virtualization */
 #define PCI_SRIOV_CAP		0x04	/* SR-IOV Capabilities */
-#define  PCI_SRIOV_CAP_VFM	0x01	/* VF Migration Capable */
+#define  PCI_SRIOV_CAP_VFM	0x00000001  /* VF Migration Capable */
 #define  PCI_SRIOV_CAP_INTR(x)	((x) >> 21) /* Interrupt Message Number */
 #define PCI_SRIOV_CTRL		0x08	/* SR-IOV Control */
-#define  PCI_SRIOV_CTRL_VFE	0x01	/* VF Enable */
-#define  PCI_SRIOV_CTRL_VFM	0x02	/* VF Migration Enable */
-#define  PCI_SRIOV_CTRL_INTR	0x04	/* VF Migration Interrupt Enable */
-#define  PCI_SRIOV_CTRL_MSE	0x08	/* VF Memory Space Enable */
-#define  PCI_SRIOV_CTRL_ARI	0x10	/* ARI Capable Hierarchy */
+#define  PCI_SRIOV_CTRL_VFE	0x0001	/* VF Enable */
+#define  PCI_SRIOV_CTRL_VFM	0x0002	/* VF Migration Enable */
+#define  PCI_SRIOV_CTRL_INTR	0x0004	/* VF Migration Interrupt Enable */
+#define  PCI_SRIOV_CTRL_MSE	0x0008	/* VF Memory Space Enable */
+#define  PCI_SRIOV_CTRL_ARI	0x0010	/* ARI Capable Hierarchy */
 #define PCI_SRIOV_STATUS	0x0a	/* SR-IOV Status */
-#define  PCI_SRIOV_STATUS_VFM	0x01	/* VF Migration Status */
+#define  PCI_SRIOV_STATUS_VFM	0x0001	/* VF Migration Status */
 #define PCI_SRIOV_INITIAL_VF	0x0c	/* Initial VFs */
 #define PCI_SRIOV_TOTAL_VF	0x0e	/* Total VFs */
 #define PCI_SRIOV_NUM_VF	0x10	/* Number of VFs */
@@ -941,13 +939,13 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
-#define  PCI_ACS_SV		0x01	/* Source Validation */
-#define  PCI_ACS_TB		0x02	/* Translation Blocking */
-#define  PCI_ACS_RR		0x04	/* P2P Request Redirect */
-#define  PCI_ACS_CR		0x08	/* P2P Completion Redirect */
-#define  PCI_ACS_UF		0x10	/* Upstream Forwarding */
-#define  PCI_ACS_EC		0x20	/* P2P Egress Control */
-#define  PCI_ACS_DT		0x40	/* Direct Translated P2P */
+#define  PCI_ACS_SV		0x0001	/* Source Validation */
+#define  PCI_ACS_TB		0x0002	/* Translation Blocking */
+#define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
+#define  PCI_ACS_CR		0x0008	/* P2P Completion Redirect */
+#define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
+#define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
+#define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
@@ -997,9 +995,9 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
-#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
-#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
-#define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_INT_EN		0x0008	/* DPC Interrupt Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
-- 
2.40.1



