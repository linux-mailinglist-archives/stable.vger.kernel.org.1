Return-Path: <stable+bounces-176540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5EB3901D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 02:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74757B5E97
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0B1DE3A4;
	Thu, 28 Aug 2025 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hctcPPFZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022041C860C;
	Thu, 28 Aug 2025 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341283; cv=fail; b=iVCfnsQTYhXhnUq22zi3XhWH1RZauMAeNJMz/leRTp6mX3NvmYyu6EH64Dp2fq1SM1bH8Irhrv1NONzCOMZEusTI1yFPLz8DOPZdX5wbjNoCbmKzX18JuDSfnwh3wVjYoSZgG4RtjlJ46QnDC1X03HpZsqGF1coy+/KpTWFwitE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341283; c=relaxed/simple;
	bh=QYXRbPqFoOpDmaP4Q+x3++QXSGZO5Ubv5xg0EhE3SvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuwyGA9G3sU4TfjGzTahVJ+BYXaMC2lid71IwAvrQoRIeyEiUlHbNxhDMB3ZrUAS3ZoFzVKxB5wOm609XI1vznuyF1obLO1SJNt9L7NG+KiLUk6e6Kx5wyk7c3aJiaP3bVvBf0Bc7gDrb6HKA+uhv9Pu/jfxv9zsqIqFNQslntw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hctcPPFZ; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLaKtVP7XF4mQE29CjvSkeTwZTRV00N2FPeSN4Zk1LWqsyWT9Z6APFEjf2dtPI+TWSLjaMa8mqMEZbUZJn1o+OQTQETviTK/thuqV4Ya07nM5Yp01ifjlK0j47z6KUdEjmfex7ntZk3ztuyPt+3l8YNs6Vr/54FSWK3mghf37A3vwiU48dbBwDWqYqIfewuyJfzO3B7ZqCsKE7Sa+oV+zXjE/nizpVnhRu/A/plnPedmvoOabMAkGdR9Jqqi9/WHsfy7H9PYSe9HD41G3ksiRGxc3/XWapFJuvM3YgObsA/6C/70zh7+oOEwYKM2g+pbssGMRlyIzeniIEOiY+827w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkpL+bA00dMgKT7xrwZLxxLo891ByJ0bYLULdHYLwb0=;
 b=hC2Emc2p7rPrxdliq/1zLUqYyZxg2t9s7RJYNWRJe1IoAHXTsGznc8RmJ79lZDXF7reapyNJfJWdpx/ZtNfZOKvacSPoetH5CyP2PlXfQA9kQfIJcVqEpZ6R3Zh8FPO3fPei1CiqzRNCv0ZzGX+hwmBc5H5kwzwEocPI/xwK5p1ckKVmwSeTzoHCJi6wAuR1cfvDxOLqALCuDukdV9HtfN4fgoNJzoVm4Qi5xWXg2x3Y2SYlR6sJgWb/vLsFwGryI7XILHDqC2DT3Q4lF1TTWC5G8rWsJ8fSPjUYbXwnLWlptY1BwZbz4LY6S32j/knvAKL0BOTbhIt3TKMtocH1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkpL+bA00dMgKT7xrwZLxxLo891ByJ0bYLULdHYLwb0=;
 b=hctcPPFZtrcfwWxB+XiCnAeV0qog/4ndjUEjmkTtcZoA60vMD31pCsVgSrCinkPYuvFs2Dve5U7VrkDPjXKdxQiMUNbcn3qPj7LHNXzQup1fynptdw5rjOtUxTUAfv6XUYoymf9nT2ZaMZkIgW1XgN7MkJQ7DLQxh7Wiu/fpQyA=
Received: from CH3P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::16)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 00:34:35 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::7d) by CH3P221CA0017.outlook.office365.com
 (2603:10b6:610:1e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Thu,
 28 Aug 2025 00:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 00:34:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 19:34:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 27 Aug
 2025 17:34:31 -0700
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 27 Aug 2025 19:34:30 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Olaf Hering <olaf@aepfle.de>
CC: Jason Andryuk <jason.andryuk@amd.com>, <stable@vger.kernel.org>, "Jan
 Beulich" <jbeulich@suse.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] xen/events: Cleanup find_virq() return codes
Date: Wed, 27 Aug 2025 20:36:01 -0400
Message-ID: <20250828003604.8949-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828003604.8949-1-jason.andryuk@amd.com>
References: <20250828003604.8949-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1e720b-9986-4dd7-0506-08dde5caa9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1t93Q+90NaHdIU7KpNaVO3ljLm34OvjZ2gNJi0lifo0Yiid65ksAKnaEy2Uc?=
 =?us-ascii?Q?zDXVwMZP8bkpnlKyBMhxtlD3UnvlKu1Q9Edhs6eCJ0ZJsNYf5CP1CGvN8jqz?=
 =?us-ascii?Q?jokpq2TR3qgr9+hqOfHrPzqrhH2cbxXDVSnwySH4QmGzdQpMcQO9zPgI+0I4?=
 =?us-ascii?Q?6IxDQ/w/9I8ibqZaykU1QiEFDKp9uNAixAfpclIR/eNHjVtsBhAFhgxTNidN?=
 =?us-ascii?Q?7BpfvFmTEx06kZtwlOA17mEov30n4lCSaoy759rwmOI96N2HiYkTCFwB/Mhg?=
 =?us-ascii?Q?f3kF/IgDItAQo6ML+7ZyGLxlrwU02VsljE2HjSW+J7yv6C7l9lsY+V3RNWrr?=
 =?us-ascii?Q?nBz1U3m4ak1rE5pztOocJesJdiwndZmkSwLam/JY+ySp69LofwJuTYhM+WpE?=
 =?us-ascii?Q?bw4QwAxhc0TNu6p/5wZNl+BNV1aeHg9SWcN/Mqy6i9zyBK9jI42Qe4eCkB7C?=
 =?us-ascii?Q?1Abp2h3h7PrjPGFOXdCCaJ4d9neg4e5o3eGpind8YWUKTu6YRW3zXhfMX9+o?=
 =?us-ascii?Q?RfmpXVNVtRTr9fOnBjrf/uSetLksifGUVW4r1XEA43QMYjr7JQ0CoKFjRXDB?=
 =?us-ascii?Q?OHbr0dWMi8F2pkcBqu6LAg8F7yr7IZUaxTUhA9CvdzEugOt01pNIwogG1KXk?=
 =?us-ascii?Q?qox8XJveYewNR7mWf1Xeypo0llbL9OQCWYBom6RjA9tXMHE4pXHyeCZ9h31a?=
 =?us-ascii?Q?YgFrMeJHKLYqjSbqgfKaZr/NQ8jj6ZmdWcGNTPvT8fw1ja1AoQon5pg7tuQG?=
 =?us-ascii?Q?rZtj8ZD9XjLVK6zu1EnvkclZQyArRUhk08UUoqOtM7w2pDapDX8nlsaOEdQt?=
 =?us-ascii?Q?MKEml6V/GUKPkv3KxoyXglCwvaajMsFJdhx9hjq3CZu8fCRz4fIhk3ezP4ps?=
 =?us-ascii?Q?icPm0i5WHyiZ8pD45s+ZUioBgwKyijpc1oFPFXygIDuqDULAgs4BYmqh8It4?=
 =?us-ascii?Q?VksxPT+siDBzobaAQpqx+GbYTAOIKbfzgzJDpyCO0nrOePNYz2piDWk1Nm5u?=
 =?us-ascii?Q?5qxUG5sUogqOyDlf8zwtzeTX6RgCzbwhX1Mmtxe2I3/Og+P6legNsJ7edf93?=
 =?us-ascii?Q?ieuqigfFLU4hRRfA0mss0mec3NxJ6NKvPyhS8ZmW5+ipVWdVhleNdjVlnptY?=
 =?us-ascii?Q?fNEQ91ESnU6A3xa96S6OZUDLkLTIsDQUd5svsaJN+tp/MJNBb7QYCzg4zFZk?=
 =?us-ascii?Q?kWiit25mvW2HvF7q1VWdFS5O/AV1qB8GFbfBV85s05uMKvdEr2UbGJqCTObi?=
 =?us-ascii?Q?flM1+hCiYlLYhb9Q3NxQsOOaMnFhTC1gbQoSW1KUcZQrT5LoRZX6TJ11vnFC?=
 =?us-ascii?Q?ndtXWDesRpAQrb8QtNgq06vAMCFqX9lNO8l/Of0hIs3knM1Mqv8kCQBSG++9?=
 =?us-ascii?Q?ALhc19LGrThz6qEktI4t5iAG07MwtOnBiD83aXBSrFOZPZiB71YJxJNIsLyH?=
 =?us-ascii?Q?PSxBCupvzBVTq3k5E9NjLEKbnre/dxj3sHhjJILzpGKTcWudE6GoNQBT7zz1?=
 =?us-ascii?Q?Yx0IWxocg+ytWMspz0ZE8cVFj72/G+6wt4CK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:34:34.8450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e720b-9986-4dd7-0506-08dde5caa9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

rc is overwritten by the evtchn_status hypercall in each iteration, so
the return value will be whatever the last iteration is.  This could
incorrectly return success even if the event channel was not found.
Change to an explicit -ENOENT for an un-found virq and return 0 on a
successful match.

Fixes: 62cc5fc7b2e0 ("xen/pv-on-hvm kexec: rebind virqs to existing eventchannel ports")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
v3:
Reduce rc's scope
Add R-b: Jan
Mention false success in commit message
Add Fixes
Cc: stable
Add R-b: Juergen

v2:
New
---
 drivers/xen/events/events_base.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 41309d38f78c..374231d84e4f 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1318,10 +1318,11 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
-	int rc = -ENOENT;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+		int rc;
+
 		status.dom = DOMID_SELF;
 		status.port = port;
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
@@ -1331,10 +1332,10 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
-			break;
+			return 0;
 		}
 	}
-	return rc;
+	return -ENOENT;
 }
 
 /**
-- 
2.34.1


