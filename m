Return-Path: <stable+bounces-197066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA0C8CC24
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD13F4E14D1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7F2BE7A1;
	Thu, 27 Nov 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKSetwv3"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099979DA;
	Thu, 27 Nov 2025 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214564; cv=fail; b=Hf1H6W9U/LJp1et86DMLr2vaUiEX8neNe7m9cSjdAVc2ZWRfz57CnvCIn216bJDPlU0vxV3NbyTKH7BiZ4CEOBGFYm0bHBIhKxPgin81iMVf+1RMX3/3ziQkVTT3oEjJxziTVc03egSM9RKm5RJfvnJDtAReRgy69AaLBS0q3Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214564; c=relaxed/simple;
	bh=8aC4zbpaH6JIn7q5bXpCx3vyuGV4yKyngwv+6rbEvLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpH0v2rReKU5LQakGes0wK8+kAyFptrIWHV1E3kp6rt1QQpza7ov2AzuPEei4RjVsPFhVslJACS+n5Ba+T0SbHifnFPF6T8d6hHwZMOXcCBshUtXddeAss4Ij9dinVemggfFEeeE9QTKZdtEkMOIy+3UpuPEfLQVQ5SMWtrKEb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKSetwv3; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe939/mNP8BGSd+p1BguyiU01v4K8chDEyi2GKI910KSSLdtLN6W3z+tw9EMmULr/i/8aDRaBCyHy1o6cr3grzCXZXbOkywIBrnn53ZIr5HLxQTELPUqBjXm0sojTyL8VrT5ey2TBsFhwJK/KJbXrzB6b1xCFyOoQCmaZ4nvD0YLzP+ny+lUb5U7zibZCC6E+D2STOt7oazpMlRMPci4xB5IelhA0a04RwjpCd0W6YsUR12nlY4LKt8G2H/GMeIUdPXBo3LANpEYsl24Xued2fFq9Wpm0mFsDTuYmfWN1Ga8xDdfqsu89qJKLB64MI3oTR9rwWnBIJcKQmMtBEBUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma/C5vESKLnklSY+rofulKJgvH8Ah1zR3fhJj+rUp70=;
 b=TH2875WsG9TV0zlS9awSctueZVjf+wTQrE7LKY/J+8unRWMG0XkPQL7SjyQgVDTcJF2K5HESs4Nq7ZyOX7JK/pY/KOf514f2xi2x14iurUhK3VyEIw5pHL6ZFI0s38XQm3c3utHl1ZLQYzgwCWGLm6WsQyZ847U/KkhKHCtyP0dQhl3rmZlxldJqF39uTVm8lwrsAat3s0wMlQ7iwKW7kxPhVn5J7pGBM1cFzaVg4MJBdxVt/SnM6n7hncRl6cd3/EDhObo6f9qB1DKv5HlpIDDySa1XFsPqrkbT3qZHtmRb7bgwfofd8kypm3fZGeMC5ugKcOQ5MLITCr3KJPlkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma/C5vESKLnklSY+rofulKJgvH8Ah1zR3fhJj+rUp70=;
 b=dKSetwv3hrqdXLkkE8sZrNOJTsJbBzRaxdpKPBqSyc+rFRdS6ajQ/0dIRFP4tw/G5LrsXQu4EU0VhHaJjl8nMVHZm4uc2abexZ76Kp18OaC47yzfAMhJ6Jq3NAz5OjuxrIDHIcUu+Tpmitz41SiaUXkfoDWPePoL5Sio8o6LtSSDFUIuOkYJ4oRYZs8uxZ0WzE4hUk4K7uinywHPt/GAu73Y+OT858Cxjxky3X1fisJwZ+XVvNVYMg46NqKHJRup10Nf/hjZIbEUt0BP8WvjEuz7wvwHb1PHYbd7bpzm3LUpRB8447FF1KezCSy0lPjucF9+hy4hLx3Ta0MrkiSuug==
Received: from SA1PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:2ce::29)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 03:35:59 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::bc) by SA1PR04CA0020.outlook.office365.com
 (2603:10b6:806:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Thu,
 27 Nov 2025 03:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 03:35:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 19:35:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 19:35:44 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 26 Nov 2025 19:35:42 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <waynec@nvidia.com>, <haotienh@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/1] usb: gadget: tegra-xudc: Always reinitialize data toggle when clear halt
Date: Thu, 27 Nov 2025 11:35:40 +0800
Message-ID: <20251127033540.2287517-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4572b3-a6ac-486d-2fad-08de2d66152a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1X0Ghttq8zevgOnfHxaysxeBbtKukFJWsdA51tVxgjztlGDSQBM7txHXYXBs?=
 =?us-ascii?Q?QwSP2kvj7r3m0j9mFka8Kxa179N9LUiYmp81saEhpIux5FcxEz98fsurr50X?=
 =?us-ascii?Q?1JCuBhixS7pBKGpK7oF/1ongcFTR2Y8Y5MMZWIuobr97IJX78G3CZHvBth2I?=
 =?us-ascii?Q?IkCSAse4PxM1yCKc9RUlCVQqbpUmpmkXs9IQTG0D+QfRoZmpdqv06knSUdKp?=
 =?us-ascii?Q?YrAIykcBwAVmBh6NebT6QZpqUel8XOsN80I1m1SaaznMfrlzt1eGA3+2wfH0?=
 =?us-ascii?Q?xXUarX+bI5DjQkd4aY5ut4xJX+X1o+qlJYvu4DZvH2L84wCIID2Ot/3kPmNH?=
 =?us-ascii?Q?uvmG+KUnGXdkfyItBIjqoL228qcq70APqXaAER0Cm+SYwSTSIl/CZQDbnpdL?=
 =?us-ascii?Q?a8VWNHwcL8tYVe7lpcLVhKXVpDaeGbHI6eO2ThjK4Jm6w3fAQXcmWZks0tEW?=
 =?us-ascii?Q?6KGYpaX1lfJWbHLa82sRVGNvDjAY0/eSPC14/EhVAQNmfLjl90CtU1trvPZ/?=
 =?us-ascii?Q?+rZFxvEUn1W04LUiaZ2cmP6c4QEGKpbPilr5X9n2NAl71S8CnGHG3hKqzL3u?=
 =?us-ascii?Q?7NiVcMPowPK3pkRuNoIKR9IavfL/9C4ltY/V1MAVXMHllVZHC1YMRD4MyvXi?=
 =?us-ascii?Q?pYU3WrUaASOVfAOEZkHiMJcG4xNj/JS2Sl48xmFs6VNtlQ/6LGjY9YrO3l10?=
 =?us-ascii?Q?BWs1Ux2OP6l5QQw7bOTt/sUrgYYdOcZM85S7phLS1VOCuEFsskbCSXHLO7Re?=
 =?us-ascii?Q?dKHkn/MsXvZtWHEd91c/0RZUKQEym84rMWoUZ+2gaNjk7fpTAzzr5KcAekKi?=
 =?us-ascii?Q?vf1+PPblB40YJQ7EdTgn2l4BOJr7MyRzL+qrB6XAj5MUh6jlrVwQwPZYZrCj?=
 =?us-ascii?Q?ma/jfMYOOUuvaD+Rwa1neR9lFYNrWgwNixd7ytXWzU+Urf3qIuZ9tpfAI0GN?=
 =?us-ascii?Q?TRbPWWHzNF3WPT9w0k5es+wKc+8gWdSYuL3Y9cjhUyQ6iS5hDHVBHw8Zps+Y?=
 =?us-ascii?Q?M3aPjJcRSARaWJCvXqGxrD2F1IMj7mQ52WXng4LBdx6VULtMGQLtmmUGL28R?=
 =?us-ascii?Q?I+q0kMvq2q9JPeZAXS0+RhMmVFB80RXlAt6XyqH1d7bsRoZWI8OHPdQ1tCTp?=
 =?us-ascii?Q?FUnpzuMPIDSrcMHXBYaW6l4qFOsbWXSs4uBw4XH1gnMAo9LU4G60U1tNUech?=
 =?us-ascii?Q?5h5vtPakUisaY/H4ZAldMMC7/5c4U7jBYDhrrpseCFc4DCilWNSOSAzDMqWV?=
 =?us-ascii?Q?2gZ4TzskJ7TpeaTv3/OiCeRNUN/sf0/MQj5dk07by+g11lzaLmNY8Ct9IlBH?=
 =?us-ascii?Q?T/f/pmosdG3JenvkU1gU5V8bcVfIN3CZR5Thain1pabgN8MISzzUfI7OHbvi?=
 =?us-ascii?Q?uQ538FMNtV4kYAjw73k0GgGhSsZ1WVg3dx89reGDpcaJ5IRq9cSiqcTsFR8s?=
 =?us-ascii?Q?ZO5zdQdzB+GB7DnTN9JhagKP9wciGTWNfX3JBuKACwBHnJvQbtdc9rAyu5RK?=
 =?us-ascii?Q?/ZMh6iK0nc1WI/77Wy+rHPa4MqiFnTV5ivYRBH9gFT42x1cXL/tb/Q7TlsZW?=
 =?us-ascii?Q?5JyLX88diUdrKUAA7QM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 03:35:59.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4572b3-a6ac-486d-2fad-08de2d66152a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

From: Haotien Hsu <haotienh@nvidia.com>

The driver previously skipped handling ClearFeature(ENDPOINT_HALT)
when the endpoint was already not halted. This prevented the
controller from resetting the data sequence number and reinitializing
the endpoint state.

According to USB 3.2 specification Rev. 1.1, section 9.4.5,
ClearFeature(ENDPOINT_HALT) must always reset the data sequence and
set the stream state machine to Disabled, regardless of whether the
endpoint was halted.

Remove the early return so that ClearFeature(ENDPOINT_HALT) always
resets the endpoint sequence state as required by the specification.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable@vger.kernel.org
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 0c38fc37b6e6..9d2007f448c0 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1558,12 +1558,6 @@ static int __tegra_xudc_ep_set_halt(struct tegra_xudc_ep *ep, bool halt)
 		return -ENOTSUPP;
 	}
 
-	if (!!(xudc_readl(xudc, EP_HALT) & BIT(ep->index)) == halt) {
-		dev_dbg(xudc->dev, "EP %u already %s\n", ep->index,
-			halt ? "halted" : "not halted");
-		return 0;
-	}
-
 	if (halt) {
 		ep_halt(xudc, ep->index);
 	} else {
-- 
2.25.1


