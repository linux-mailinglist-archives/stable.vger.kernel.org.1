Return-Path: <stable+bounces-238518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA3UCRaY4mls7wAAu9opvQ
	(envelope-from <stable+bounces-238518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:29:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE35B41E7F6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD49730823AD
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03383368B6;
	Fri, 17 Apr 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwIufy23"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C532936C;
	Fri, 17 Apr 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457719; cv=fail; b=ZqHHzPkzPyzZ0kLE5n5Z9YJQR+eBATTphI3y9Q+mvf5KpA1k3yoDXeXKUGVQXNos4/SHQNw17ufhbwTl5wor8hvtfSlNT8Ag3+lM/RzOzNtrd4WyhXT1WQs527DUwGqJHkCg/S8rFaqGkYkqf/B8cvKUiLsqlHk3misA1bDP1E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457719; c=relaxed/simple;
	bh=c6QNrxitQxZkHHHxt1eN1jOgtXMG7ZzRsOsTWI/+wvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlRJppUux8JTA3slBzrF2vx0d3qYaDZ3akYAKA3uQRCszTcZ9MMGyodj5fB6hLsAfKH4tsiVycYk4AuFK/ZZdVih2gwDxM+kji6zjBwplFMd4N1yZAKMF5VYWR3k/QjmoILVkc8GcT7yAO2QdgVmsCIyJ61Lb6GGwjkIbaROcjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwIufy23; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOWm3M3o7FgIF+A/Rz8OHogWeDFsm7LCM/g35sM2Bu3ku1R5ZzSP5/g0r2uhQjml8tOjlAAzdJP+sMCakJrn1OYC7/cy7J8wLIn7BE9j+/A7DHfzJXdvzBlTanasLavTRbp0JGLiD/k8AvPqTgdSY4yxM00BS+AaBRRhHmPjwRddbw/OGxYtuqXjUoPlPeu803fw8xIq+/rJbz49v8h9p2EJixyv36e9BqOH9r6VylfmTXYGN7BZEnb1lmhBxZWpg5Bff4smaIxf9xuaRgBQYFkmcmp3g1L5FzCpvxpza3M+93Dw9EVwbyfcSCUucF5lDyFM2nsrmOV719B699iqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1idMXaQ3Q6yM0MvXb8UUc55UF81pOVko05A7D7A4Oc=;
 b=h98xDIimfJOxeAEZEjodM2nJDEuB/N3JDdtwD4Cg5K/bJnA8r/t40IueVLeIOg2VstsmCg5QGLQu7GIgw7SgCL2a/oXlmE2/bgECwCrw0jJs3R+pxuAtRv4Rw3iOVQ03DEuPCtHsOimCvx403hKyhC6PlgiuMe4ZA7hk6LDBuPNjSR/RYNjM45urY2IKsjW20BX7nzLxEO64mU7O0Em3lUmbRAOTtb88fkN8rdTJ+ea1JpPc9gsXSMnAHsHMcv+g0Hwpt94mkLYrQjXtUV7GLpg87fL5315t+67sfAl7dcPx20PsynJ0VyX07xn064Z+4HjND4U7V63qjLgG5BvbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1idMXaQ3Q6yM0MvXb8UUc55UF81pOVko05A7D7A4Oc=;
 b=jwIufy23KBVHEyOZmWsygp9qpkjrRH6NkJiQXSxiLiMT7SAuZXG7bhDDBqxSxn+NDLRO3YG644v7sV9/dms+cE9unci1ELxwT63Ks50ZCmuMTlflTFV+LZhYZjCytecTn5npvfSHAcPbdUiQD/DpGnFTq9VArgJoHKX7FEmUNbADvsdifSrL7KvJEm+adjt72oTLCqSh3YO9QrNBOxIhmMtMsnfqJgyBIT5CeeTXNqpYJZd0ub8cEsOJ7ob9mRXbS4CmbBhsBCDpcVpEZbsWSfs3rg1H+b5Z6/PLmPSuN0Ith5o5YsDibL4K9WqqnH40yzpdIvXd2pSOE5i7Oxi7QQ==
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:28:33 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::ae) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:28:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 13:28:10 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 13:28:09 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, <nipun.gupta@amd.com>,
	<nikhil.agarwal@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Alex Williamson
	<alex.williamson@nvidia.com>
Subject: [PATCH v2 1/3] vfio/cdx: Fix NULL pointer dereference in interrupt trigger path
Date: Fri, 17 Apr 2026 14:27:56 -0600
Message-ID: <20260417202800.88287-2-alex.williamson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0840b0-6c19-4ea3-bdaf-08de9cbfe549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tg8ZEPP5TyrVp/IUWaFpABX/Wq9XzxF5o7L+VSF0sqad9A+iU/yYpGHWCTBLOeAtF6d7xl1Ozi7NZu0RrA/U/VbP/+OJFOaiMd+NjWVYPV4yxOTv/QrhLJ7x1fL3Jx9z0J9iK0gTOSrGkEmxtu31e+S6x/5Qi9XT3VO17IQ+8MkCzHIU9G6vJ1pwWbF4gGRExXJSWGo3aAwJy/Ta8NcTS+JD967ol/aoSxOoxsJTJ0Uc9nTxjmx5Azmu290ChOEwHlQ3J07kNu0XxnDVYMcuH0JcGfypN14yfPgg35i/wah+Yg6Usw4V2bOmvBtJ6ep/vEteFpkSdJk+G3wvNNB0Lfp5vzB7SqEuCjEJ5EvMzznhz3qLLXy1SWCjc+zf4CITS1VUfoStCKNrrQ/id6iBYzOXyaeRWSES43wo1Ay6Z+tvjrZOAuly3GYFwn3hIlx0jueObo6LXgf4638KOqNR2bdLP1xKnQb1OvykE8VJ6NnKOV4sB3WmLNYqJriqgNKjzUnIiUKvEKzbJDVvQv+1Vcl4EfZkTjWldZ/5MV4P3UKzNwJ+Ok1D+pA5M8rJa0ElMq0/KyQPbVyoFHoea1wsfLgXnbrj8h2Q55o3rg9Zb2B8JE60GmJDYlrcuQWs5kRv68fr1qF5O1DRQhINNM4ufEsJcrHSHjrYFAhjV4eWEAXMvbhaOGTjeb8leUwYhl6JEJmy31w4tO+qA6d2sgMXWdgJiGcUeKBNtkceyKB8fTSSK0tvP5gQuouCAGJxb6HlRCfEA/Rlza1rymB2ikeyjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EQKpCSO069XyHAvBU3uF4ssD6cNAN7aL9HQ70HWbSF4GGtoziKY/hHWMeh/XxSbZ/uyylhQLuM77Nhw0JHczedzOymv05I+3WX+4LMEeOV51d7veAvKMOZEsSD39pleyHu8NuiWMTGKrOLkC5IYHQDDUStLc3b9wiVh2gP1QSCOv/B4f/6+Deh3Ujf5J14sZy1169tXO+J4ZfiY6aPXh/HIrgLJ7f1tj2GCDEFnmEOlgPdRaTBhE8mIKvI9bBZoxT2y07SP/aIGptjxoehwb5L3ZluFNzMNhpBVxPimCGzsZ6J/j0V0ozTEh69RUhrz2kmsHuEVngDfIv4Oyb1eslya4TrfD2lYOBMtsXhOGKin1t2KxtHmLAnHu2JQBviOu/w0XMYyk7IBJFWiCVz4Qg1GJHLNnCdabL1Jvwfq6xPQTtOtvjSxJAREY1zRddm2b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:28:33.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0840b0-6c19-4ea3-bdaf-08de9cbfe549
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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
	TAGGED_FROM(0.00)[bounces-238518-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,amd.com:email];
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
X-Rspamd-Queue-Id: AE35B41E7F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Add validation to ensure MSI is configured before accessing cdx_irqs
array in vfio_cdx_set_msi_trigger(). Without this check, userspace
can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.

The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
sets config_msi to 1 only when called through the EVENTFD path. The
trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
done, but there was no enforcement of this call ordering.

This matches the protection used in the PCI VFIO driver where
vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.

Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/cdx/intr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/cdx/intr.c b/drivers/vfio/cdx/intr.c
index 8f4402cec9c5..c0eed065e8ef 100644
--- a/drivers/vfio/cdx/intr.c
+++ b/drivers/vfio/cdx/intr.c
@@ -175,6 +175,10 @@ static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
 		return ret;
 	}
 
+	/* Ensure MSI is configured before accessing cdx_irqs */
+	if (!vdev->config_msi)
+		return -EINVAL;
+
 	for (i = start; i < start + count; i++) {
 		if (!vdev->cdx_irqs[i].trigger)
 			continue;
-- 
2.51.0


