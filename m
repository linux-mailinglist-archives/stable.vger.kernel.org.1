Return-Path: <stable+bounces-215563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGOZI+tJimndJAAAu9opvQ
	(envelope-from <stable+bounces-215563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:56:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4846114A3E
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445F2302835C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6A37D120;
	Mon,  9 Feb 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NZTNlsoF"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC233B94B;
	Mon,  9 Feb 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670549; cv=fail; b=ikQly/BQxCBlF7jydfs9GGujXhbpOVkcRkC+A7astGsM/DY0md4M6FkvtmgEQfDQKczLaz/U2vVrC7RJ8Va9TKh7hBijwqWFzGJrPNWhCa46anSCpioVZSm3hBuGdbUU6/pRyUkeittcxQjo41ufjVt0trKVIy5r6Qa9Tv2wpL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670549; c=relaxed/simple;
	bh=i8XFSuhi7yLMTg0wucNUx+U5EvPN3NzavPBf5Kqx9VE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ETKc93fRRwNitx515FlYD0FAZtSEPKRkF2SVTb5ymfsCHarniKG0LrmSOnKoQx1I3+bNhUy2gfwSOgI67D615xiDwynn2MIBx69MG6jAyuR4H+oUGxgJQGwf6gic1H7sYJGEIPZhhe+fF1l9qxsqqiH0j06FRzT489qRCFwSARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NZTNlsoF; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnaSa7A/w0yZpFI1MlqCjlMfTgDaUnL1+MVbrTwT0t2o4ZNGjW8Uhe4BPRd834le7VXcnIA+x8zOe6a78vV2juyAomkG+VpOvHRqYYQJLbuGy6Gg28ZWAo0V19YxAYtxKMTtmq/dLIttyIUzz3YrZ3hmL+uEtiSuXLxSfKoMzKKCyXLyXCE8ritt3tgsM7liQ+fWimIjvKM3MlTNT5yfTAeClhgI7erOAoagBOV8yYNHEHcaTi5x75qOMXnx04l7cbN//w3sQ0NiL3voZSj9G34youCGK3uJ2ypUgbGtQNxu+trH8+6y8PRmAoOcPheCq7VUJeACvALf/UAnGAJLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNa3BFhLo6rkwOYmvAbpCpQNt4ZKB/pBYrj581/Tgys=;
 b=k4r1aReaQidUpVm8oJEhuUvuUEk006ZrEeoDFe/xCgOCtEV3ikZkX8D9N3j/S2ZXyiUaZTsthJRq9zhSmpBBaQU0xo4wgVny4Yqha9DLBsJ3imNIyKz94cwJ9urGf1leMIf23RvvyyrArDm0G4cIRH5vHGE1WYJvtYTdOJc4V2xyQgkbmdzC3cfsHOlQySUXMoPEC1UfcEmrx+jxkrT8qDYQsG89AhymjReyPYgi0DaSB1+MS7f+IgVFXgXsDNpHfem9qFH75zDV/thktca2rnmOIeXVnvhaAV/xkBgB/fN+3camFuDG1grPoGqd5TC9Ag16fWp9QkmWilFNaSwyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNa3BFhLo6rkwOYmvAbpCpQNt4ZKB/pBYrj581/Tgys=;
 b=NZTNlsoFw1WfIyWmzcFh/Sf97fMXr/FBKbIESbIei9j2m1SF2dmaMpTxSQX+s5UEzPQRa7bH2oKUNBqAh0Qaw/9oJOvN6CykRo/n6UiTBUhNb6AirqbPoMrUvlt6k6jF9fXdSj1VjgGCaPBvgTMP8bKmd9BS+8wTqTzldziDE7q6czd3MABroHfsPaOioULzgqbiA12T9q8tk+uneL4AgccKOf1+664UMXlZArOAV3BRPau8BWhJK7x2PAEBq9hgZ4M9b7U7XAWG+CzTSWtbKv37MzbmwtRkSTmr3pAwF7xdR4WMCCsQsBw4wpTLRJNLgeRuxDurjji9BD5GeL60Lg==
Received: from BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 20:55:42 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::c9) by BYAPR04CA0029.outlook.office365.com
 (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 20:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Mon, 9 Feb 2026 20:55:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 12:55:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 12:55:13 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 12:55:12 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@nabladev.com>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/75] 5.15.200-rc1 review
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5832f9ac-a74f-41fc-bb39-da8a64022f39@rnnvmail204.nvidia.com>
Date: Mon, 9 Feb 2026 12:55:12 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: bff3179b-fb67-4670-9515-08de681d962e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUwyclRuRXNyVVBPRkl1aW9VR2JqZEx5L25jdEovajZvejdEVHhjNFVENXNW?=
 =?utf-8?B?Um5pRGhXYkNiSHcwNGVDNVd1R3NKaUp4OEIzRXJaVEFIZHlleEVYSWFXb0U5?=
 =?utf-8?B?YnZnLzFJQkJiSG1Iam84d0p6VnB1UUZJcHhDakdtcU9NVmtRbjVxcDhlMzBL?=
 =?utf-8?B?OFVJLzFuNWY3emFCWjVpUDNoSjdDZVNyWGZteDlmSkxVOXdaV1hWUmQ3SWN6?=
 =?utf-8?B?cVVzRk85SE1XemtNVkZyMDA1WDBmVzlTOHhHYXFlYk5xbms5WTJ2Ym1KdEhw?=
 =?utf-8?B?M0plekZraGxndVgzTmx1WW5MM0JNY1hjejJtRENEOWJ1SG9QOEdWS0t0ZWx2?=
 =?utf-8?B?VzhwVE1lSW9jaTZYUGxleDg2TzRxd0xBV2JzRjJvK2VzV2xOWFY4ay93bEg5?=
 =?utf-8?B?cVdrZXFhdUpJS3NZUkpKcCtodW50TkVWQWtzR080MU1mUVR6WW1WUDdzS1B0?=
 =?utf-8?B?aVhVUGVCdmNORkdnK3BheWhkZ3NTZ2s1Z21YbEpxZjlCYjMwV3ZjNUJsSjhO?=
 =?utf-8?B?Wlh3dmk5OG5wZUxiSVkzYWtnRXBid0hqdlhkUm5DcWJUTnF6dnRlcWxoaWls?=
 =?utf-8?B?bUhIVzhRNlNiMDBlbENEOFZ0L1JjRzZ3WjZrVnVVWFp0eUtFSlpKUDc5Y2Yx?=
 =?utf-8?B?dXk2cEJ1R0VjeUFLS09pdUJNWHl4clpBeXdYNDlXQW9GU0RBQ0kyQ3c3TUNq?=
 =?utf-8?B?c1FQZ1FwRi9qMHplRStNa0dBeTZ6UjlzbmM5TEsyMHcydE04WkdPZER1dE1T?=
 =?utf-8?B?YklDaUg5Sk9hZDh2VmV5ZExtN2ZaM29GZkVESzlBSzY0OG5kdmZjaTFNKzZZ?=
 =?utf-8?B?WXphd1VDMVlURmRmVVRRRUtuQjFrS0JGdEg0Rk1KS1c3RXQ1V1JOaVJYUDJX?=
 =?utf-8?B?cWRGWFY5amhqQTRsM2RPRmhNcDE1WnYwM0FUU3VQcm9BdU5TeEdTTUY4ZVNa?=
 =?utf-8?B?UlRzOXR6RkhRQVBYMnY3bys5R1Y2eTFzaHdxY1lSaENOR1g4SXlJaUt3d1RU?=
 =?utf-8?B?b2liNDBLUEVsRTlBWHNSeWVYckZROFp5Nk03b3NqaHBzNlI5R2I5aHNOTGQw?=
 =?utf-8?B?Y3E3enUybjRiTUZHK05TdCtkcUZjZ21mZE91cHI2eFF2V1NFYXdHdXZ6VVpU?=
 =?utf-8?B?c1kwSXdCK1VsL2pIZXE0TXZPeVgrVU5HaG9jZ0dpOGRINE5JSTBNb2wva1pm?=
 =?utf-8?B?eXpaaHZFU0UvTlMrOUQwN2pjTGF4bHZGZWFDaFBIQ3lWOG5sVzRLU2ErWnBx?=
 =?utf-8?B?Y3l2MGZIVmlickhkLzZ6YlpBTkFUZVZzTVR5TzdUNDlnVXdkNnpKQXRURy9J?=
 =?utf-8?B?WWVKT1VHMDBDbFhzTXFIM29abkhiUlIvN1QxSThJTzlFWWlMdnBZZ01Ub2dp?=
 =?utf-8?B?SDR4WlVGRUMvUExXVklpbUZ4dHRpMkZWUmYzWGdsdGo1UHJLdHdPRTJaQkd5?=
 =?utf-8?B?N2dMTU1xZ3ZGemlNMzI4RjNJOTZsbkZpdHNESlpjeDR6SGNVRTlFb0tMMzcr?=
 =?utf-8?B?UmlGUXlyajR0ZlgxeHJSYzJmTmIxOUdXWEU2UFJKbC8wQXQxRkZyNzZIZ0U4?=
 =?utf-8?B?akUwM1NUZFRraHUrclJxYnRBbXIvM2h4bHNFZ0NhMXdBb0tyb3Jwb281NGNT?=
 =?utf-8?B?K1JPbTMzYkNJc0Z2RGc3QkU5ZXJscUcvQ0NGTmYwUnAzQ2poRS9SK0RVWEVq?=
 =?utf-8?B?bE14TUhEdW44cFpQVGViVGFaaDU1Uy9wbU9qL3E4ZEtqVVJuUDl1RUdWWVBp?=
 =?utf-8?B?anc1cjhrcWFTUW1Td3A5KzVjRUJYYUVLc2JYQVAxNzhPenZiaDI5SG5nT2V1?=
 =?utf-8?B?czR2OWFOcTJZalBLYnhjMVhJZTFyTUV6RUpGQ3hoeUdZcjc0dklJd3dxY1RZ?=
 =?utf-8?B?NW9kRlZ1V0hvNEc5NDg0MUpHODF0UGtZUm5JbmhiRndjNGV0bjJSMTNTcXlD?=
 =?utf-8?B?cU8ydWR6WlBPUmRUOFVLVDROcW9HSGdTdm9mWmNZMHp2T1JvdHFSTEhheW53?=
 =?utf-8?B?QmFLMWdid0VRM0JlamVJOTBLZ2p6YWYwQi8rYnRUMDVFYUZLUkpjZExzVGJr?=
 =?utf-8?B?ZDZvS1NRczd2cFJxcEhhNm1ST0VYaURlcldXMkNzeTRoWXRJUjgxU0NUWVFY?=
 =?utf-8?B?M3NUdjZjdUVkSE8waFZ5Mzl6Z3dGbHZhWTRaaUlWS2JjMDk3UUxTb1pHMzh4?=
 =?utf-8?B?OG1QVTZoN3BHT0NzZVB2UVkxZnNtUlNwR2thQlhKRzBNSFVSRUFRYzBjT2RY?=
 =?utf-8?B?UGFQREJnRFk3MUdNVXZjelh6RGRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jb6/msED1tX/ShUwSW3nMmmOJeI5GFtrn0pogzn6VGRTZcNE+jmKNyjS3SIKO2+DVbqJhAflS84Kq3o7AL+BGNwjTDuiGediG812SpeRz+Pl/2EIGLV7SUiwnGsNQ4w5mhcBmz1wtU/SwehG+rZJrNku4zJenmrkxNcLJ+B6HuR56WoDtTIsu/GptOGrnfCX3UsQ1zX2O0CRP3vawIQZbI7sL9QSaqf3UdU/g/UV0ThqQucxoJIpvYNLjXi4VYjYt9klJLsCaf9ckx2hC3qjEq47Wo/uA7VuLo1iEVa0V8O56h2TFTDcydhjCjk35SCOCrU6R6Hm60XuRV/tVMwbmeNMnxnRhbprwQ0Xzda2WiVi3X15lyOy/2QHxUePluXjxVZHVPYepE1EqQwFI+IMMsI6ZTADjAi0bjTg5PcH/xI/GinRLiEZD+7A41/JISHM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:55:41.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff3179b-fb67-4670-9515-08de681d962e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-215563-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim,rnnvmail204.nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E4846114A3E
X-Rspamd-Action: no action

On Mon, 09 Feb 2026 15:23:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.200 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.200-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    118 tests:	118 pass, 0 fail

Linux version:	5.15.200-rc1-g5a0f6e208cfa
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

