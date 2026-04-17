Return-Path: <stable+bounces-238519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPEYJzGY4mls7wAAu9opvQ
	(envelope-from <stable+bounces-238519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:29:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AB241E80E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA6930D5FB5
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7E342509;
	Fri, 17 Apr 2026 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXVOREuN"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F032FA30;
	Fri, 17 Apr 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457720; cv=fail; b=HdEBIww8mHXAw5vldLgex/nEf8tezr44m9Sg7RPoLCjRE2ZNooBMx1YuOboUdQSfP4kxtFnhGs5f0iw1kXczew3UvZ8hJd0u+nzv5bHrQdcI+m2Tqgo1luQpbQXN/8wyv8Ms9rd2nIyOlrndQJr8Cys84FII2okSFy8ZXmO0WkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457720; c=relaxed/simple;
	bh=PcR1hBeVKSLNOXdpS/bbk2VIn96qYE2cFWBGXKTwzXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZwfdOEKhQbWnn2eFP3B8a9Kipx6PtQMEOFGX9KMtotdzXnncJah8EbE5QXYb7TRB0B7yHmv9PjTaPiL3g3PCPEaf1w7DlutLKMBp6ENVvpZeX4c4xbRhCnRd8+mnfS9ANDQOb7eTWtwRXeIlEvmwlMqteHRJkUGQQWK2GsDSL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXVOREuN; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkQUxok9CDlEp9e1RFoittsrh3gsvhPyCBj5iMN/3qZsvsv8cFhBit1HGB/BbiGUMJf5qZMLTx0mL9VNG2he37/9b4cji9g6SEtVfRgcsIPr1kZd79JUDZ/iGg0bVCoTFD3QeFctzD0xxShIBTrxkoL0iCg+MkCELO+ZusjvwqnRQCXDInORqs5tLkJ4BKRSgsCWNhVUS0EPTjrOQvEaFBpRiMDOe8JCA7s7nHrdidCKxdtltwLNQh2EZzFLeyhHwi05P0N5lFtXFiH+/+R6t7Ufw5YFpV5m9aUmTfjC6s4OSlmKnAB9oCVQZdLnn/tloywW3xH/10Wquz9KZKJh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxZ35UH88JZVQ5hX+ApV042cPTmx4yBnCW3Zupc9sBg=;
 b=viaaGFf19xrJ2Ogwhv2lhE2943X69XZ9BI0jC999XYIDjUVBgJOaNJBsoQKG+w22TJn6PPGC/eMna5D7QqyujXPD+TrZmqRSGQ6KlbiWaOg9dJRXz3S27Yvtjbo9mnSYTLorh0WnC4URjmhxkuMADR76fs+syr/BKamvkOJWXi/359+Fx9wh0zxiHt64Rrqvk1p0c2uY0TjCODYRDBeCqoSvubdXuWA3XHQLbpH8B7S63hTt1esBAhd8bGW3lFOKII/7lnCQJETTk+xAjI2YWCcfxw9I6uF31Wj6/aH+i/htAk/d0evbUJ5IFPnSsRfNlH2EfhoXrqg+9KnIDywfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxZ35UH88JZVQ5hX+ApV042cPTmx4yBnCW3Zupc9sBg=;
 b=GXVOREuNpSzFsrcodKdzhTKqGAyWKqurMhqIyeWM0TqaXiWSDhShJ8AGsYIIeoXSnqwIR5WY/3+aS7jV9gwa7/48YXbI/jXcC0D4ZDJ9I3ta3Jx/ytEHWGhMGa7fIo+LkC6FfYCS0CABCBmIt7JxYQ85BLExV6SYBtVLVFbiO/LhDnAX50qPhSJKYbM/kwKO07qCyTuXT1uOWkvKWZXjYbiRqX91EFvIHYqeFCb8KigilSiT/GtkTK7U8IlSpP8fiiByUT6+D43BiQtkMPH2HtHlc9Zva6kf64loxTd4q7BG2sydzRspYKGrbc4I3vAtLB52q453C85DDkC9bX/I7Q==
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:28:34 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::8a) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:28:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 13:28:12 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 13:28:10 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <ptsm@linux.microsoft.com>,
	<nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/3] vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex
Date: Fri, 17 Apr 2026 14:27:57 -0600
Message-ID: <20260417202800.88287-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417202800.88287-1-alex.williamson@nvidia.com>
References: <20260417202800.88287-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0da7f2-c172-4f33-12a0-08de9cbfe5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	33W1r/z0TUGU80wrYs9u4Qa0az5xX8CrAO1VnkVyKb2d+SI01ilhKXKOEbH1036YcgaRmLB8WDXDsQ06bRKRcqZ3fLOYADyfg/+0hKPwmjWv5bnfZMcxg+hlFuh8nZ/uq6+8yfB2WQNC9WqTgdCIA6kmo5jg9hzT+/ZVcuM0+qbTFGX+yrJlfXUuM087NbsrL0wf8QuobvISWZLeMcniaizN70Gfg0SzmvhizgTodnz/4Z5CnbaO8hqn8tW8QOf3p5t2rLD2FDVYj5zMI5A+BiYBSE0nUsiwgRvGauLQ2Mn/SvZttLdnKKHYyH1QA8EOSOtDinJiGHdVnNCpl8aXycpQQTjN1K4+wSD+VNxi9uDpC8s19YP6mzr2WkFSnScZYCDIhp4NHp046qLdFxGMN8VA05QUnYAnjvHr9/5dfdZCBgKwmr5Rh/ePTNYMkAnaNixxhxPRcwb6WN4Xlvm+50SELVq3pmHIPQ7QUfb1OTTIDwI9V1BwvKUJTFh/pePLAdI82aExvpsZZXjs7eoDKfmxuFO0z3ofIu9eZTLZ8w/ZFidgLkIIf8lX298mi39LDzB6FDNWKo9fiyb5wY4tF18VIY+FM5GLNIxwlgaFxHwwQDXCCb3v63GgD6Key05h1MQ832+36LWIz7Pf+bj8WrfzfJg1Pf/9WzECS7W05+MB4DI74QP87spO9S2UyNYsc7QJqwR8u/xg6cImNNIGS86SBfliXirwlG2cS8sQO9JgdJUHsqGTzdHyPbpz69rZalOqblfzDhlnNoFmDDLjng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4KQzKFixKGDSvWhlITvXH3oTeRMbbuMRmgcRMS902M6uH64n9uQLb89+GSgMSkTk0Y2idc/R3F/oLi1T5Vo3svsM7/e18qwxAVCRpC+5voFvjhGfovr7oRcIuaODWoAfQlp6Egl2Wt0jzgAfMZ6VMy78RAFswwwt0tkCxowkFoZJ05Hz4uda7dpv6+mQH4j9BlH9Xbe7h5RF9WGgP1l3w+AFu4A+06WU20Bz/WtJSmHOSUOX9M2S274etnw6TuBhAuWXxn5X0c808LRIaw0hE8usEwDFJnHj2+hVjbzItbi3rXIrb1QAdC43MUaksp0gcVPT2dU735LRwNIhR7KXNVUo1Bbf1qZHNvBD6uCcBdM2rdTP/2tfITJPeyOS7HxU48G1NWAe6mWMowqad9UjNIj2FxwZ3Ia1Kv4zixR2tF6E6vouj7FaIu5HGp9f1EN5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:28:34.0000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0da7f2-c172-4f33-12a0-08de9cbfe5d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238519-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 34AB241E80E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vfio_cdx_set_msi_trigger() reads vdev->config_msi and operates on the
vdev->cdx_irqs array based on its value, but provides no serialization
against concurrent VFIO_DEVICE_SET_IRQS ioctls.  Two callers can race
such that one observes config_msi as set while another clears it and
frees cdx_irqs via vfio_cdx_msi_disable(), resulting in a use-after-free
of the cdx_irqs array.

Add a cdx_irqs_lock mutex to struct vfio_cdx_device and acquire it in
vfio_cdx_set_msi_trigger(), which is the single chokepoint through
which all updates to config_msi, cdx_irqs, and msi_count flow, covering
both the ioctl path and the close-device cleanup path.  This keeps the
test of config_msi atomic with the subsequent enable, disable, or
trigger operations.

Drop the pre-call !cdx_irqs test from vfio_cdx_irqs_cleanup() as part
of this change: the optimization it provided is redundant with the
!config_msi early-return inside vfio_cdx_msi_disable(), and leaving the
test in place would be an unsynchronized read of state the new lock is
meant to protect.

Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/cdx/intr.c    |  9 ++-------
 drivers/vfio/cdx/main.c    | 19 +++++++++++++++++++
 drivers/vfio/cdx/private.h |  3 +++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/cdx/intr.c b/drivers/vfio/cdx/intr.c
index c0eed065e8ef..6dfe0ced3bdd 100644
--- a/drivers/vfio/cdx/intr.c
+++ b/drivers/vfio/cdx/intr.c
@@ -152,6 +152,8 @@ static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
 	if (start + count > cdx_dev->num_msi)
 		return -EINVAL;
 
+	guard(mutex)(&vdev->cdx_irqs_lock);
+
 	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
 		vfio_cdx_msi_disable(vdev);
 		return 0;
@@ -210,12 +212,5 @@ int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
 /* Free All IRQs for the given device */
 void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
 {
-	/*
-	 * Device does not support any interrupt or the interrupts
-	 * were not configured
-	 */
-	if (!vdev->cdx_irqs)
-		return;
-
 	vfio_cdx_set_msi_trigger(vdev, 0, 0, 0, VFIO_IRQ_SET_DATA_NONE, NULL);
 }
diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index 8ab97405b2bd..b31ed4be7bdc 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -8,6 +8,23 @@
 
 #include "private.h"
 
+static int vfio_cdx_init_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+
+	mutex_init(&vdev->cdx_irqs_lock);
+	return 0;
+}
+
+static void vfio_cdx_release_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+
+	mutex_destroy(&vdev->cdx_irqs_lock);
+}
+
 static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 {
 	struct vfio_cdx_device *vdev =
@@ -273,6 +290,8 @@ static int vfio_cdx_mmap(struct vfio_device *core_vdev,
 
 static const struct vfio_device_ops vfio_cdx_ops = {
 	.name		= "vfio-cdx",
+	.init		= vfio_cdx_init_dev,
+	.release	= vfio_cdx_release_dev,
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index 172e48caa3a0..94374b5fc989 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -6,6 +6,8 @@
 #ifndef VFIO_CDX_PRIVATE_H
 #define VFIO_CDX_PRIVATE_H
 
+#include <linux/mutex.h>
+
 #define VFIO_CDX_OFFSET_SHIFT    40
 
 static inline u64 vfio_cdx_index_to_offset(u32 index)
@@ -31,6 +33,7 @@ struct vfio_cdx_region {
 struct vfio_cdx_device {
 	struct vfio_device	vdev;
 	struct vfio_cdx_region	*regions;
+	struct mutex		cdx_irqs_lock;
 	struct vfio_cdx_irq	*cdx_irqs;
 	u32			flags;
 #define BME_SUPPORT BIT(0)
-- 
2.51.0


