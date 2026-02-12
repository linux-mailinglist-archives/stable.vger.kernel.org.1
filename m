Return-Path: <stable+bounces-215948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFsWN3HDjWlt6gAAu9opvQ
	(envelope-from <stable+bounces-215948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:11:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4512D540
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C7A3059A8B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A1356A2B;
	Thu, 12 Feb 2026 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P5TzgXl4"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFA34AAF9;
	Thu, 12 Feb 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898276; cv=fail; b=R5GQuGeKtt1JTZcqy0sXTWOEWDuHjyC2+ktTlgU8FzTWrZ3RcWF+ZCSpzCDX/5Px2Nmm1IOxcZ9LGMTMBWCre37Sc+ja5rQpuU4KW8/M/pRP+xy26qV8VnTTtNd4UHfAy3ZDFshfn/3uQxAqZV9JiVciQtSWEJxtGqeDSZWK2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898276; c=relaxed/simple;
	bh=uSe7pid2oTEXEWOJh5QJKg9wyQLUinjDq0PT8DY7wVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=taCMvdbkM0OQbxj1V35WNF8DUBSIe7dRXWQnScaM5degrMuydgbyC+u88RnzKEA/03Ogr9zbn4PukFQfP4CNInKBLolCTGoM+eLldec/GSTPtZM3C2fNEbEW+kKrPJ7wRCfKIFM3M81Fr34TDZR2rfyPcEkQgrcqOE9vz9CUO+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P5TzgXl4; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlvR0/Xw41bFHXNghbG0oBkmhcbV65yJLRTigzzxR7F3Sr2rrzgAEJNke+O++QG9SPvmg4jvg+jwzxmhlcxdAIgfKlk2iCqFNKDBWK5+eTLXleHCImoPVfM1cX8pKnZiAE3Ufs1xOSsmIxbPS+4qOwZziEbUImOXvhLaf6kDH8h4kx56gYowj1Ldu5j3WzDkHwNGCtj6Klw/bpEuu0y0pOqXTUIrnph6PLC0OckobHjDCdpGfeAAh7RmglWs+10v6wKidCTpLSsX+m/A9cq90v6J4IAGR/A0SC1j170FGCdSLPZc/oELgz+2t9NWuq62pZhDT0ZJ9//1BFkXRxVPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlqlkO0keKNXxxE+ZaA1aw44MnHLT1iIi258zk5vpvQ=;
 b=bLULxWIDwvE8yS71lIIKLsg8Vv23LXicZtuwdJfpUWUAsm8MBTMrRzO3P06Bsvr56Tm3TBTh8s39rkczSDhKuPmO1siOsP89m1EF6Ndi9DO7Tle3sBDjH5jyuOVzpZh/D7/+B5iSaUVxi9EdpbJKO/4aBzY12dbSsQhiF/Vms3Tcr5tDMMNdudwXZB1ZnDmNg9mltHYx6WygGil9daxjbviBoBJE2Joyj/jtaJP/XKgcYYRvwADR1hYs13TAP87KHi82ULgJO+1lAgUzIETkI4MiEH03yJDnhkNP4mvC3VCB1DIayxmDMUVUjs+vFNJv01I5VHGcaJRKZMYxQh3tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlqlkO0keKNXxxE+ZaA1aw44MnHLT1iIi258zk5vpvQ=;
 b=P5TzgXl4lVfomaK/M9UTrHUWbHRLHR3hcN2t0+Lm1iHQVbHt4EmRr7VPcawe3nv0/M4kEjOJaWeAXmJFEE8mXxC4vTGYDYM9rVJ35w1zPPb5DKpmGggsL7DpeUKkKgn7kZzlGD531W91khPoGeUFE3IoSQiIWoYRQfhLfC8SUcI=
Received: from BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46) by
 DM3PPFC7DCDCAD9.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 12:11:10 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:71:cafe::6c) by BL0PR01CA0033.outlook.office365.com
 (2603:10b6:208:71::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 12:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 12:11:09 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 06:11:04 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 06:11:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 06:11:04 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CCAx5D3467474;
	Thu, 12 Feb 2026 06:11:00 -0600
Message-ID: <8d85409e-2f07-4e4b-831b-68c17a341a60@ti.com>
Date: Thu, 12 Feb 2026 17:40:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
To: Niklas Cassel <cassel@kernel.org>, Manikanta Maddireddy
	<mmaddireddy@nvidia.com>, <kishon@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
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
 <aYsKzBjmGEi1z0am@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aYsKzBjmGEi1z0am@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM3PPFC7DCDCAD9:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e1ab9-7f2c-472e-6885-08de6a2fce60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1lxaGVhQU5GdFFlTVdhVkZpeSs1NWZIaTBwQlZZRjVRcWlRVW1rUnhheG5k?=
 =?utf-8?B?bWJHRG9BeEx3MzdlbzdaTC9mWndmRThSUnowb0lSZlJWeStvZm1FK05XVCtp?=
 =?utf-8?B?UDk1QUdWQ0UzbmwvQlEwQ05jTDdxTEUxZjFVbWcyaytJeXpWUW16MlNURGV4?=
 =?utf-8?B?RFQxWmw5S2llMkV4VXlDNDByaFh2VGpMMmVZdjBvYW5vZUQySnkzenlmd1ln?=
 =?utf-8?B?aDdZQkpCN1VER3orU2hvZDRhQnRzaDNtdHRwWmppSms1V21kQnRoVEVTenVr?=
 =?utf-8?B?SS9rOStHR2lUMkNDR1ZCVldPWGRkZkJWMlBNaDk3aE1VL2ZRTVVNT2JWTU5s?=
 =?utf-8?B?Q1cxZm55Wkx0YXZjRUdOdTRsQ1N3NXgvbFVyRlpONGg3TVpBTnZxdFVtK1Zr?=
 =?utf-8?B?eFZqNW5IVHRtWTN6UHM3TG5EenZnZklQQWUreFQvQ3R5RE53bFNadzAxOGR6?=
 =?utf-8?B?VFhvazJQdVZ2YS85YjRHR3ZRZWorSWFURmdSdSt3ZngvK083VUk1cyt3OWFF?=
 =?utf-8?B?c25NeTlpMWtxYWFQS280dTdLY1l4NVlnVmhxKzNWclBMK01lRlBSbXBzQzk1?=
 =?utf-8?B?TjlLWmVDVWFGWDUxdE5sWndldW9NMjFDbGhiVVFDdEdWaE9DVFpLdXYvSlp3?=
 =?utf-8?B?WVJnT0tkcXhheUZ2Y01XYmJBaFZ5aTNLbTZXM202MTc3eUtvbVd3b1c3c1Fw?=
 =?utf-8?B?cU5RdnRvT29kVHF2ZTlmMVl5aWpmOWVOaXhOeDdlWXM5Kytic3BINXp3Nnpw?=
 =?utf-8?B?M1hpYUpzRm5OK3RkWnBWYW10MytQb2xSNUNCemppK29BMDBMZnJITkdaR0pH?=
 =?utf-8?B?VEx3czhiRitKOWl5MmI1OVNzL0tSTE1iYTYwUnFpaFJQMUNRa0tMRkI3M09V?=
 =?utf-8?B?TU5ORktXL0NmRWE5SVhqbGJVZXhKdkk1Y3pNQnFSd2xtanBFcTE5VUw2YlFJ?=
 =?utf-8?B?bFBBdDhPekg5UnRoUVpuTFZLU0ZxUjg1UnQxKzErZ1J2SXd6cmxYZC8yY052?=
 =?utf-8?B?L2RRYng2RzlpL2hraWFOYWJWazBIeXRzVFUxVVkxMm42NWV6ZjYzWk1Pa0Qy?=
 =?utf-8?B?R3BrY29IdmVuNHZNdWtjQmpHTTloY1AveDMybG5SN3VWK3R0aFNuSGV2c3Rl?=
 =?utf-8?B?MlJ3c0N1YkM3cFF1dllCU3pEeFJ6aWpwb29oMU9NWDNnMjY2dVVTaVkvNXZx?=
 =?utf-8?B?Qkx6cmYzSWRyYWRBaHUxYzZnS0M3RkFKdVZTNitRZnExVXFOdXFYMkdxRWR4?=
 =?utf-8?B?dWM3VFVmNGRSM3JvcDUyY3g3a0xidG5XRVRLNTlYQkhMMEhzaWFRV1dobTZC?=
 =?utf-8?B?T1Y1WHFFdHIydjRJTXQ0RkkzT1oyWWxmdDZJa3ArTDI2dy9waXdnVFdOR09S?=
 =?utf-8?B?TFNkZGQzV2E4S2tqLzFFcDJtc3dpcGNuT2IvcHBNV0ZBZndKdGVMQjhnVFpa?=
 =?utf-8?B?UHIvUDdZUlE4MmhnbGxrZW9xdHNrdDdmM20wTmN6d3Zic3VWR21wQlJCQzJo?=
 =?utf-8?B?RjgyR2RjMlczVEZTMEg1d1BtaFJHRzlVbDVpR3FlR2JoQU1ZdXdwL0N1aWJH?=
 =?utf-8?B?NXJJOURDVktqZmdSY0hWUFJwanl2d21MVngveDVSL0RER2V0cHB1dGdaWU11?=
 =?utf-8?B?dStGSXg5RXEzWkdVVmkyMTVBdHBLZlFBOWZMeUkwYUZWNFdQVEJRc2pMTHh5?=
 =?utf-8?B?ZU9NOXVuN3F6bjU3VXJ6SW8wL1RUNjV1YXJma1Z6V3lEN25nVlpPTmJ6SnVt?=
 =?utf-8?B?NlRTbUt0SVNSTHpsQy8vTGF6dEFFYXhyZGljM2FnajhHZVRjbUdmK0cxSWt5?=
 =?utf-8?B?Nm5wdGdkVjNTM0hYU2R3M0xPMjRPYWRSWGZvbUZRaDFOYmpSTEdkeTVLYjdY?=
 =?utf-8?B?alFZVVNUZ251SDRWM090N2I5WXlBUCtOMWpZSnU0c1FCSldaNXBTN2xnNkU3?=
 =?utf-8?B?dEkzeFRVb1pLTWowUE9oT2hlYmhJR3JZbWtGSmdZbGlWMWpIelh5NkJyYW5F?=
 =?utf-8?B?MWZFTEdLV25OSGhSY1ljTWFXdUk4Vm9MV3czb0gyOThGUmhYZ0lWYTJ1VkFv?=
 =?utf-8?B?T0ZSR1JkRThRRmF6MC9jVUhPUGZpTC9UUTM1c3NWQUFzbWpmblNKZ2o0OGM0?=
 =?utf-8?B?Q1FJVHV3K3piTUtYNXJHTlhmczhqa0twUkxlQlBYbThmOHZaN3BUNDZnUXRB?=
 =?utf-8?B?UWNkWWR1RWtnWEl5dFFHd1V2Wkpqc1dnN1kzNlV2UDF0eXozYytPWW5mRDJz?=
 =?utf-8?B?RmZWdlZ6MXd5WmpGdFE3cnVjN3JBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B6f2B784SvXo4khbbP4hQYWIR1C87SivlTbrsPkEk+KrQfRaeq3kHq9mNGhSnC+0GvJPFHYLWNt4P1jX+Do0C/tHUvtx9Sihx2d12ij+bxI+wpCuT2kyiyRfK/hXi5wKuGhLCtKj2N64MAFJlrVeTtXnl4LwyCBgybWREJDVrTjnFz6vxfbjEgUF9WavtTCTRTRb1SHUUSLSe+rzu6KjDgvq+GE6BWdOChyFt93pffc0IYaUYIu/ZQshl6yhWIZnvMEjY3xDEcDcrBGFoVGhXXfZA4DvoVc/se5uijVktI7L2FOKmzQ7vPtLf0ALLWSjhsJ0LHK5MWB0GcPcF5SrGiXZG95/DoJwm+1RM6kwMECytkKSAEX6wP5ejlAE7IU3xzL2w31XkQ8vTbgwwsR3FbDJmWe+HpMTlvel0wBsX+tXtMckZu3C8MA6F0gqgIdd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:11:09.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e1ab9-7f2c-472e-6885-08de6a2fce60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC7DCDCAD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215948-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,wdc.com,vger.kernel.org,google.com,gmail.com];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a-garg7@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 83A4512D540
X-Rspamd-Action: no action

+ Kishon

On 10/02/26 16:09, Niklas Cassel wrote:
>> BAR_RESERVED already means disabled, it just assumes that an EPC driver
>> disables all BARs by default, which is the case for:
>> pci-dra7xx.c, pci-imx6.c, pci-layerscape-ep.c, pcie-artpec6.c,
>> pcie-designware-plat.c, pcie-dw-rockchip.c, pcie-qcom-ep.c, pcie-rcar-gen4.c,
>> pcie-stm32-ep.c, pcie-uniphier-ep.c.
>> (All drivers which disables all BARs by default in the init() callback using
>> dw_pcie_ep_reset_bar(). pci-epf-test will later enable all BARs that are not
>> marked as BAR_RESERVED.)
>> 
>> That leaves: pcie-keembay.c, pci-keystone.c, pcie-tegra194.c (before my patch).
>> 
>> For pcie-keembay.c, this is not a problem, because BAR0, BAR2, BAR4 are marked
>> as only_64bit, so pci-epf-test configure these BARs as 64-bit BARs, and thus
>> BAR1, BAR3, and BAR5 will get disabled implicitly.
>> 
>> For pci-keystone.c, this is the only driver that is a bit weird, it marks
>> BAR0 and BAR1 as reserved, but does not disable them in the init() callback.
>> It seems force set BAR0 as a 32-bit BAR in the init() callback.
>> 
>> Thus, for all drivers except for pci-keystone.c, BAR_RESERVED does mean
>> BAR_DISABLED. Feel free to send a patch that renames BAR_RESERVED to
>> BAR_DISABLED.
>> 
>> If you send such a patch, perhaps you also want to modify the PCI endpoint
>> core to call reset_bar() for all BARs marked as BAR_RESERVED/BAR_DISABLED,
>> instead of each EPC driver doing so in the init() callback. I think the main
>> reason why this is not done already is that thare is no reset_bar() op in
>> struct pci_epc_ops epc_ops, there is only clear_bar() which clears an BAR
>> enabled by an EPF driver. (So you would most likely also need to add a
>> .disable_bar() op in struct pci_epc_ops epc_ops.)
> 
> Aksh (on To:),
> 
> since you have a @ti.com email, perhaps you can explain how pci-keystone.c
> can pass all the pci-epf-test test cases, considering that this is the only
> driver that has BARs (BAR0 and BAR1) marked as BAR_RESERVED but do not also
> disable the BARs (using dw_pcie_ep_reset_bar()) in the init() callback.
> 
> Or, perhaps the simple answer is that pci-keystone.c does not pass all
> pci-epf-test test cases?
> 
> 
> Kind regards,
> Niklas

Hi Niklas,

I just joined the organization and have no context on why the
pci-keystone.c have BAR0 and BAR1 as reserved, without disabling the
bars using dw_pcie_ep_reset_bar() in the .init() callback. Because the
AM65 do not use any BARs for any purpose like Tegra194 does (ATU
registers or eDMA registers exposed in BAR4 for example), there would
be no issue if the BAR0 and BAR1 are overwritten.

This was introduced in the driver the time the EP support was added to
the driver by Kishon in commit 23284ad677a9 ("PCI: keystone: Add support
for PCIe EP in AM654x Platforms"), where no context is provided in the
comments or commit message why the BAR0/1 are marked as reserved in the
features. Perhaps Kishon can provide a better insight over this.

Regards,
Aksh Garg

> 


