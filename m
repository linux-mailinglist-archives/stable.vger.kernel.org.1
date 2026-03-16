Return-Path: <stable+bounces-225653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGqvLi5KuGlTbgEAu9opvQ
	(envelope-from <stable+bounces-225653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:21:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9B29EF75
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F01B6302C753
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B693DB626;
	Mon, 16 Mar 2026 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkYmDUex"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC33DA7E1;
	Mon, 16 Mar 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685281; cv=fail; b=JJloAEDbbYc38UCEmvfhMumkLizf6ubKs2DHMPmiqTGBiavyFVn3eGi55fpn5zm7Z8/yjZ8bLHfkUh9OrfR49do9TMDnt/hdKUEZhlwMGMATGqZU03rxWZx9gUJkQhhJWa7NuVKi0JwoYKdpLSGSt06enIUYYlctI6ssIALv/To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685281; c=relaxed/simple;
	bh=HG71p2B/zHaFD3EX5OxvzPtSNls14F9W13UScveAkJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtF/SjX54t6hC83/fBe7ekZReqfWTCiYGwmaQdwMYXk8sHUQOV9yVwLDFMSWX1Nz0B4rBlZzIkCaHiklkRzmOwk8ZUvAC7SpKRusvEf8U0ywd04I2aYtA5tdawov/AHb5QLicS9eDyB99JrHx+Ddv0mizZob83i5+8FfJDwjWq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkYmDUex; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLxLidbuRVApcMPfU1IbByuezvqqL+uWRFUDlfv6IGDcxYjHrCh1mKsTEWNzYLRcDEVU73g76nPi8UVFdjgq+7orLyxYBFSIC3cIYS1gUZ+/4wdQWijc0Nx6wpQxuMRhhQ6tTKN7PmKZB3u+/EnkNhr1RQe88XpzLUEigpQOF7G7pu94/LVmexGJm23wYiSWeaZPWt15Q0fghCNZF0+PBvpLUMO5grtzSgYJnV2tH679Z3lxlJiwL/26V8iaj5qVMziSSUpxp9D10i9CgG/fmuFK0tFWPCIGrVhGOE4pBXfTg7lmrxakvoBZn4sJUOa9f2EcZ07BBMiNTGdfAgvFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCSACYY0ysJpzB+6G8iEyJzdjtiN7fklKKXTb636ZZ8=;
 b=aIasLsH15Bn2o2Peqk0EEWXX0+ZaNXwQ++IIR1dwroG+9aQyg0Sr2T4yIvfvdA4Zf5PT1ZpWPztuRYss/N3G9ytvSBEOL3wXXVwz3LOZkkzD7S6ZKowJ4EZ2uRHb2lCr1UNo1PgYhfVntUJsuvmlesCUJMlPprcB4q1QkMN6YbHMKf14aDvxNe2XX9iKZGcvpq77XCw9Sct03SeIOjbJ5RwNQiExiOiDJoUhOEzDZHwEXOR5aPqYEQlKWACFzE/pEE12D7H5G2H6WsUaycAvsewmKNVpeBNz5ayWUGqtIfyAVam3wo3jfIDpfSwUnYM4ubAhnbJ9nEE+CHjUnfjeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCSACYY0ysJpzB+6G8iEyJzdjtiN7fklKKXTb636ZZ8=;
 b=SkYmDUexBNEDEl+EWYws3u3g5Fa6ZeWc98UNz996uU2GVQm7Q64377ONoYZnSnYouRzDZbYCVOJaayXNoaiX2UOXW877ZEm6bJw4+7jEZuYo0AcMaowNjRE6wGH6ZfiQYEFfoVYL6P3PNnToVlTq6knwslR8KiSPyD1O8OYsqZedj4MmrHC/vG4Q07WCTHK3YA2nxnkQqY2q4txIdXimLk/pd7a5/2UJymK6sn3M1WFNQP152SA062Nz2raXtctQJvr4zSNa7Az4zXU8SbSnBlmf/98quMQKbqbhLH26oGARpuPCV+UEM2kVMrGFFMOe5SOm+IAzzF1lYXH4H1XMNQ==
Received: from DS7P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::25) by
 LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 18:21:04 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:223:cafe::eb) by DS7P220CA0031.outlook.office365.com
 (2603:10b6:8:223::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:21:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 11:20:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 11:20:39 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 11:20:36 -0700
From: <mhonap@nvidia.com>
To: <dmatlack@google.com>, <alwilliamson@nvidia.com>, <dave.jiang@intel.com>,
	<ankita@nvidia.com>
CC: <kjaju@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <mhonap@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] selftests/vfio: Fix VLA initialisation in vfio_pci_irq_set()
Date: Mon, 16 Mar 2026 23:50:25 +0530
Message-ID: <20260316182025.3383443-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: b25c3b34-51b8-4f55-e612-08de8388c7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZbTRMX1pvOtb4LSy3/MN+tXgVow5SoQGUn0jGeFmxbvE4pRkkDbyeL9A6Flhq69766azl+J+6hUtPnTEzqgZXy0VdYH6Zn2M0qos/RjbuxavO1++owhNZmnewOAavbcJMnA46dj34kVRSrUNNnd4RqaltyKmdPGqqCUNT6K5xvFwqtTnRr+dkXycRz8eN9ZRftJeTZlQDX/J3uYQ9gk87YNYGKFfTjzfynbBL5f8igHbLufqRaDK9iAH5/qC4j5drWredllNxsI1sK9/5DluQORhLhAaHZ7PkTrHl1L1VRYPtzvlL9UyFLU30y2xGS4v/78HZ5rlN51A7MuhVnrNkibBjL+SM4/Fz6U7OtLWrtGpAGwSqll8NmQy98l2f/gqy8vtIPXPpn8z8Cn/YT6sfncWNLVEUP4YXEV4Ik1+C8HVC63uSG7rLN5tkG4trkPVoAarF02CXgUAU4j5P9FlXCEYWZVAS1sf32Z4so+rMaD94levHTm637/60rVCViqgir0CvIjcDZ0MBOxcarauJLMY1pSM8EQwo0/Qo1rudB5OXN+kI7uhvBcVf2nrVzVNs0V9H9Y11qGsms+dNEl9TMJA1oiOtlmRtkFxKRW4bjeNXsKqay9qb9EjjVHXq0x6I5Ut/zsw/yL1ggB+L7tVQWYNm0vh3JxQRksOOMSgWN9LhP92yNTI0B9qmFPpPocs9lKsGCfMCZgai/PkRa1WxbiQWeQbRlNQJold2MUB1DYNX1HA0F7iOiGzdoMjv/FdRjZunuAvKDgAP2HQ0KVWHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mICpesmhsM8DzuVyddZSo5uyy06COJJ53B1tj4QwQo3w/xX7eNj0Keg+47ZltlQfIMOqox79I1pv4DRseBf8DHG83MQqDhtaQfhvKexHZWv6Pd2ZotY6vkaOWTZXGlLKGhas9O7DVYFgBGQxim+W6pZHI9EbIqANzEIbJRDzhGJqrWHNvv+80r36rjC3KDEu3WXMAOYgibI4ti1JMZOL9vj9nF3YRoq9nEdjUa6H6NPVDLq6vB1YOgGfEiFDAkAULIsncWvFqwfBIYi7DesmO6QMS5flIUNzDcWgSUJRy3NmMvFNz4uGZQRbh5qSTnDPHat9aDUDLaet9PgrgqDp96P9oeJr7O9JwR4B+aizQiVd065sUe0zJt3mV8CGHmu/RCb5IAomLJUmtjU2svJx4ZMCk6jnfhnYCGftJPWSRbzfvUqy2/YyacOXpmhC6wDi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:21:02.5320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25c3b34-51b8-4f55-e612-08de8388c7f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-225653-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhonap@nvidia.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6FD9B29EF75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manish Honap <mhonap@nvidia.com>

C does not permit an initialiser expression on a variable-length array
(C99 Section 6.7.9 constraint: "The type of the entity to be initialized
shall not be a variable length array type").

vfio_pci_irq_set() declared:

      u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};

where `count` is a runtime function parameter, making `buf` a VLA.

GCC rejects this with (tried with GCC-9.4.0):

      error: variable-sized object may not be initialized

Fix by removing the `= {}` initialiser and inserting an explicit
memset() immediately after the declaration.  memset() on a VLA is
perfectly legal and achieves the same zero-initialisation on all
conforming C implementations.

This fix is self-contained: it touches only the existing vfio selftest
helper library and carries no dependency on any other patch.  It was
originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
RFC series [1] but belongs on the vfio list independently, as noted by
Dave Jiang.

[1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com/

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Cc: stable@vger.kernel.org
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>

---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fac4c0ecadef..3258e814f450 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -26,8 +26,10 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
+	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
 	struct vfio_irq_set *irq = (void *)&buf;
+
+	memset(buf, 0, sizeof(buf));
 	int *irq_fds = (void *)&irq->data;

 	irq->argsz = sizeof(buf);
--
2.25.1


