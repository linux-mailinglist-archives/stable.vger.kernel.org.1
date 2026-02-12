Return-Path: <stable+bounces-215963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aANqOcHZjWkw8AAAu9opvQ
	(envelope-from <stable+bounces-215963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:46:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C941A12DEEB
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20865300B9F6
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E2284672;
	Thu, 12 Feb 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ChW6nw4a"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945EEEAB;
	Thu, 12 Feb 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903996; cv=fail; b=OdVT04YRel94po45ki6wBJVItWAOno+vOiSo5ikC4e2QGfqBhKrun0FslUIMiPGbkdB69psGwZ7+w4GAPQNMkDu2l33l4ehmRZmxAMScikW/lqnQnkINGaUu44WUn9fBmPvNRGUVhMdOINUeos1od7uu66mVqwgwrZromN2nyqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903996; c=relaxed/simple;
	bh=CxpzYclZwqLcqMX1xNfMr50Pz7T4LuXp5wFs2XmYLd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RtPkrWghWR1HoWJ3uRb+lrgWRcMTLrfIXXKGkXhVb2XS7XsdBFcJNMSq5udt1M38qN3owWZWDk1yDpTNFBtrQPMUCL83qUR6wnC79o5tnzLwGkLqWD1dKvzpv4VwIgzc/jhaRRO4Rg64cRmtFGEhUgW5aa+wlVzHhi0hDg01lFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ChW6nw4a; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ2pmBnyaTfpYiWp49QfA33RyHKrteEM5ZJ8bpMONCxIuoK8tuFDVn0RdSIYF/c8CenfbSQTzOpK2PX1Pig31Dhn1tBRNGMOOYT4pYyGCaYl8ffvWZOhCAzfdpnzztdqYLwhVFq+00e8K9PpUwkWx7vamh/QlvNHTreYQj5v0gTbzNHo5TNOdJ2SLDvplHL1NqCwAGPl6KgU/KL8lPzlLiVNbC/iqPjo/V9teclPhFwZsTixk1gXz1LMC7FwgI+jfbbCpxxSQsFhoQhequog/xWttOYrG5yB5yL88w9f1AQou7J2SUdqUQOR3vuUT3TCFsIDydb6FgEuq5ha3Lb8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM0Cm80Ir9qmvA/M0YYdzH8JuGYDz0KEi0GFUvUrx4w=;
 b=v/u8/jaf3m3eww93prhitxEMhKk17X4X4277SbK3qAI2+hchbxzY3G16oPjZH1lOZV5PPPeMqPBYBJWtlEglJPSGFbDwjeundqA8U0l1b2aj4oMmdyZbNqPuf+HNrquUcDl97S36pTe1L5cQ2d3i3NU0920pQm0KYP8SBu3/JNpU23y96vKvWL8+QIgSqqVqCy6M3bMNu4hvgHHPjoETFwc0YY0R8ro3X2a+ECiXFC3L414t219tM/+mrrhG7JTjY7vhuCVAHP5myrY0/NlpFcWEFQsGQA0mZnJCAHHstM4XrSICZINvCiKG3oYHCqYtpqFBhWLSSuAl2L3jpzePug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM0Cm80Ir9qmvA/M0YYdzH8JuGYDz0KEi0GFUvUrx4w=;
 b=ChW6nw4ayDOfjBo0QarGtsLEC59A/lX/ub0h95tqRNUhFufkfe2UjLI25tgiFp/p8q4KJYH4cYPKNwQ0ud8OEhYLCYEQmQwjwy16AszvY9BPsYnsBKli23pUFfUNYD09WCayMuWt6LSIuTNEdL1/e6WUYMnEQNRO4JXmgatNr30=
Received: from PH3PEPF00004099.namprd05.prod.outlook.com (2603:10b6:518:1::45)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 12 Feb
 2026 13:46:31 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH3PEPF00004099.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 12 Feb 2026 13:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 13:46:30 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 07:46:29 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 07:46:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 07:46:28 -0600
Received: from [10.249.145.65] ([10.249.145.65])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CDkNDC3154025;
	Thu, 12 Feb 2026 07:46:24 -0600
Message-ID: <e9820b38-768c-45fb-a719-7a1db7a7a795@ti.com>
Date: Thu, 12 Feb 2026 19:16:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
To: Niklas Cassel <cassel@kernel.org>
CC: Manikanta Maddireddy <mmaddireddy@nvidia.com>, <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, <stable@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Rob
 Herring" <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com> <aYonDJyd_dbV0GBK@ryzen>
 <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com> <aYsDDOZA18BBeOsd@ryzen>
 <aYsKzBjmGEi1z0am@ryzen> <8d85409e-2f07-4e4b-831b-68c17a341a60@ti.com>
 <aY3FhZUhb7RL80Fp@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aY3FhZUhb7RL80Fp@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR10MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb6094a-70cd-4884-4c72-08de6a3d206a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U21hRUI2S0NtQ3hWYUZMYStOaWsxRHM4OWQxQnZiQURaQVZyM0xndG1uTHBH?=
 =?utf-8?B?dEFLOEZxSlNaWGMrRmdBNDlTWVJVWGZpSERkbnBRK25laDJxc1FydmVuNlRh?=
 =?utf-8?B?bmtTamppTy91QlF3aVFsTkttamg5em1meFRYb0FycEpyVm9UV0NmVFBvRGhS?=
 =?utf-8?B?ay9GQXB1VFh4OVVIWnR0QTNENFRFOTdNRFlWVkQ1MVExbCt4K0hxZ2FiZHhR?=
 =?utf-8?B?MjlPczRpeWdwREloK0M5K3JlZkk3elViUDRYZ3ErRlpuSTB0ZHVjOVJ4MWV5?=
 =?utf-8?B?SE1OUmZpQ0ZyY2d6RFQrR2JNZ0NsUGN2aktNOEY2WS94ZlZ0WWVrVjZzNUVB?=
 =?utf-8?B?akhFdTRiTUhDYzhsTFdMcTVnY0lxeTVybmNQUnNKRWRjZjRhSkZOUG95cGx2?=
 =?utf-8?B?cTRRYmtZMHdUaG9VeVk4QU95cGlUVTFLWFg4blRxSW1lenYwZHJGZml0aVVu?=
 =?utf-8?B?R3oxUEpWb25RL2tMZnFCZWpYbkdJUUJLM1R1WTlYb1dGL1RIRVIyc2ZlWXlB?=
 =?utf-8?B?QktaTTk0bGN2ams2dzlPenp4c05pWVRGandOZ3pEanFUZHVVTFlNRXNHV1JP?=
 =?utf-8?B?dUFPZFBPU1lueTdXWlFRMUROOWhSZDYxdHBGYkJTa2FDSk9kLzBmM05oMDJz?=
 =?utf-8?B?UGJRMGJGaWszOThSWFdZRGNnbDQzeDhBYVNTWkFkeVhxNkpncW1DRjBCNWZV?=
 =?utf-8?B?TEdkbko2L3A4UGFZTDdmbG1pOTZzT2Yzckx4dC96SWxoYnRJVkEzajFGYmxG?=
 =?utf-8?B?WHE5bFpweXQ0VTlvSERVZHZKWUtvNFVRMUZoaDJCTHYzNkNCa0s3ZCtHUTJI?=
 =?utf-8?B?UFhqWUZ3aGk3VTZTSWtsa0RyMHZCNWhQT0p5TUFHZGhYYUpVcUUvVVFoeEhq?=
 =?utf-8?B?dE9Wci81ZUQ1UTNDL040YUx0THJ3UjMxaGRhUDYrTm1aY3FrbGgxSE82SW9v?=
 =?utf-8?B?QktyU2Y0Ti9HNVlwZERSaWtUNnhlRmhNV2xVUzZPTExRMUM0QTZFZzF5blRv?=
 =?utf-8?B?MXBWTUVTQUp1YUZUWW5TQU9WS1V5eTc4eFJEdmNpQndYWHF1NUx6MGkyZXl1?=
 =?utf-8?B?UFNLckR5Q1RRVUdVNmFkS0t3YjdhSGJ5L1A1ZWpoQnpYOG9UTzJKQTJmUUE2?=
 =?utf-8?B?bjBCeU9jbnFLTHoyemJ1aUlEZlh1Q2UvcUE2SWNCdmJsdEFJemV4S2ZOTXlp?=
 =?utf-8?B?YnAwZG96M1ZUNE5VOWFlWE9uVU5DNC9NcE83Z1JpRy9OcS9QSXJ5bXpxTkp3?=
 =?utf-8?B?bE5Ib3htZG9xa2UvdEYySkd3NCt4T1FpcE9jWFJNVk5XaGJGRW50OVBWSEFJ?=
 =?utf-8?B?MkJPVXVyUzZ5d2xvZzlDVUlhNGVhZGVPTkR6OWNCeDBrT1FneWJucmk3Um9o?=
 =?utf-8?B?NUYxbmxBWFFtTzljWHdNZXc4QUowckJtMnZVb0xEcHg1OUtUMzFQNGE2dUt1?=
 =?utf-8?B?ZzJ6bkNxQ1c3Q0FHbFpFaTdYNklmY1hUcE5MMENsc0h1RnhlaEFaUTE3NXl5?=
 =?utf-8?B?NXFKdU5pK2sxOFdxZjZRZEYxRkxTclM3UVNEWXg0Sm93emF3UWJ4WUQzOTRa?=
 =?utf-8?B?Vkt3ZkpJTU5pS2FWRlJMZXZpTy9yeXBKK3hWaUlueGNBcEdHbTQwcXRCd1g3?=
 =?utf-8?B?eWUwQktyYnBjUmlJZkI3L050WlZxbGkyaFRQWDQ0RFEvQUxEMGMxSnRxSUhh?=
 =?utf-8?B?dG95SkpYK1c0bkFyVHMrZitZd1RVRStubFB1UUx2ZE1OTlJtNGo0VmdnOU9U?=
 =?utf-8?B?YThoUEJhMEVJTFFsclJtK0tja1h6ODF6UVFDaFB1UktWTGtCUldMQjB4TXVv?=
 =?utf-8?B?YUNCVnJaRUphd0pRUWpycS9pU1JhS0VlVUlvOGFOVHlwQ21rQ2tUQ0RTdEZQ?=
 =?utf-8?B?SEVkbnpnTC9Ob1NlWXp0UmtZQUFqdlJIVTd5cXNudGJ3MHUrbjVEVm12OEZX?=
 =?utf-8?B?ZElmaWVWQnpJZU56M2lBc3ZQblZFOE5TQlRFLytmdWZHcXk5VElrRUZvR0Nq?=
 =?utf-8?B?V2E3NXFhNmVzNFVHbE8vWjB5OHJ3cytvZzhWZ0VhNWtFSFA3U25ST1VIUG9w?=
 =?utf-8?B?WFdqdlprcGozTTRWTCtjNFltWElhMDBKdlBsT0xHcENYSHVocDRkOVFDQVhU?=
 =?utf-8?B?RVhYRkt1RHFjV1JsMzgyUm5abDZWdUdsNmI4OTJxSElZb20vYnNaUmtreFVT?=
 =?utf-8?B?QW8zZ3lqU3F4K29DU21JS2VqZW5wc1l1Y1V6WkVaSHJWWklQRTZjdXlNOTBo?=
 =?utf-8?B?MFloODdxdXRZOW1TZWZIRnIweE9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1hS5GH05AQE+hzO8+q4tn7P1m0tPvzjVV3A79OHrJ8BKUZawbzFveB3DXDJcH3/CY0nvdIb4A9zlvrjGd/eTChKHGsbKf2Ukid6RIkCW8309pw+qPZpsCkdfDDMS1Jliun9Sww6xSYYoXVwgfHGZBMxM2dupk5tF8pp8cCz352S3ZrK3hnwrAjqNJpW8Hn9gnnL7AZ33siOmRELSqeNDMNNiKKgXq/bApgS2JXhbc6We6F1ZynbMHalxxI0qOyOFwaMmPkKRNvJyRxuo4RVwd270Gl+GXtgiE7Ceim2bv2W24xo7YXbBJ1BG3jyOD4ectUucmEyHnwbnv59lIuzMgxpGS/zTGK2iGZT7lzcJVEJBYvZB90/kkRQ4TRnEZKl6LHNErQyiA0wwbP/IqK4jpqukEQ1BdsnoaVMQqxehsiK39dGBzc1KeLJOci5JI1NJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:46:30.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb6094a-70cd-4884-4c72-08de6a3d206a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215963-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,wdc.com,vger.kernel.org,google.com,gmail.com];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a-garg7@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C941A12DEEB
X-Rspamd-Action: no action



On 2/12/2026 5:50 PM, Niklas Cassel wrote:
> On Thu, Feb 12, 2026 at 05:40:59PM +0530, Aksh Garg wrote:
>> > since you have a @ti.com email, perhaps you can explain how pci-keystone.c
>> > can pass all the pci-epf-test test cases, considering that this is the only
>> > driver that has BARs (BAR0 and BAR1) marked as BAR_RESERVED but do not also
>> > disable the BARs (using dw_pcie_ep_reset_bar()) in the init() callback.
>> > 
>> > Or, perhaps the simple answer is that pci-keystone.c does not pass all
>> > pci-epf-test test cases?
>> 
>> Hi Niklas,
>> 
>> I just joined the organization and have no context on why the
>> pci-keystone.c have BAR0 and BAR1 as reserved, without disabling the
>> bars using dw_pcie_ep_reset_bar() in the .init() callback. Because the
>> AM65 do not use any BARs for any purpose like Tegra194 does (ATU
>> registers or eDMA registers exposed in BAR4 for example), there would
>> be no issue if the BAR0 and BAR1 are overwritten.
>> 
>> This was introduced in the driver the time the EP support was added to
>> the driver by Kishon in commit 23284ad677a9 ("PCI: keystone: Add support
>> for PCIe EP in AM654x Platforms"), where no context is provided in the
>> comments or commit message why the BAR0/1 are marked as reserved in the
>> features. Perhaps Kishon can provide a better insight over this.
> 
> It is extra confusing, since the older driver from TI:
> pci-dra7xx.c does have the dw_pcie_ep_reset_bar() calls in init()
> (git blame shows added by Kishon), so it is a bit surprising that
> the newer driver (pci-keystone.c) does not.
> 
> (And like I explained, currently all DWC drivers except keystone and
> pcie-keembay.c do have the dw_pcie_ep_reset_bar() calls in init().)
> 

Yes, true. I tried to backtrace why this is so for pci-keystone.c, but
couldn't find anything on this.

> Kind regards,
> Niklas
> 


