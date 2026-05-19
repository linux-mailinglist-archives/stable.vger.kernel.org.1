Return-Path: <stable+bounces-249657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKxWEeekDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:59:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C2583605
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A7F30107EA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B173E558C;
	Tue, 19 May 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2OMNtrc"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56D191F94;
	Tue, 19 May 2026 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213538; cv=fail; b=T1WkSABt+U7VGF1qljLR+bF7C/i/smceJmDgQF8QR0ZW8RxdBwoErNaz5b+xVfYGltJWdceX50VfUQhkSsVjrivkT2JLECy0i6jlIg+Scxh0pPNmXeZ8hIphUAwJxITfrOnw9sCAvh3z5gy3Ya82dJHiRK1Kk1BUUVz9Lwpq9k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213538; c=relaxed/simple;
	bh=bV1uor1tgO31roCSd61jKPafTwrurVn1AcYc8ZKRhII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tSQau4PNk/qKVCVV52rwMdhWa5RyxelT3vGvY8XUbsylp6vsgfkQ7DsY2ZyUjYeuI5nlHybP8wKcoynkQqdhMS9KsISsEqh9ll89Urrn+T9bFrJQcYX24HtFu3qllsTbdhR3gdBDm/xIBLsNbq2vM/HChO67E7Uvb72F7bf3of0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p2OMNtrc; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWTgPGLlEXSiJ1iJY3+UEHZMdDH6TMe2JDTI5Ac0swtQF+rwpOFKSNNgH3feZ6MvyX8GTX2gEaljSAXpAAH4qO3L3fE49w/oJ4PMo6Rb9e/8w9pG+Qu4+s5oyoQx5gP8Hx1h2QOJoTpjJ1v/pSQapZKKZUIehywhEbwRvLDo3w83v9so9syDKB1aMR6WygIfBGDoSrZj/+944QjL0dQPX6F8L+KK+YvvtqaeH3k46RR0EnYHEFIsqdI15L16Dt5Vx/iRCAtoLJlaoO0gnEoJ4ZSQ7IpCJbowtXW58nflRlWM+OA9KVoMxoG7TP9FhY9m9KENVTv3/8kjtbUZRI7Rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3nGHcP7dGpL4izzlU4mEWeSnrDwYnGZE8qzqZkznIU=;
 b=hwD9Qu8U0yxmuMMQ6se1SHYgCGybX3Sdfz619ZZ1RSz11Pf8jYY3lAKWKTuDfKBSPmkXXQQKoTLAAYfbkYz2pH4TeaQxqlH0BAcrJYHuWq2OYKmKUape0bCnTIKeFM2Y2ndsvuP3PqAo6K/Vae69DPsLlU3bzw7YDX6uZybgwGU6B2gJJBYmC1u7XBmYTQ1tH5duNR/brfzECUF/a5EjLa3kEM8bxE8kMmc57VKQKnIAcbire7LqcLGuv7jum7wjk1Gx4fFGej4na9sD+Q/K2MDYdsFjUTINHOB5CDefm06cfsiT64D4vEW+iNjSxEeUkYCqqRVrBvfQEJZGdoXFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3nGHcP7dGpL4izzlU4mEWeSnrDwYnGZE8qzqZkznIU=;
 b=p2OMNtrc7n7KZshLpPe1HHJllRy3sWBGPjNUo3NplRrmcwz9cfyaOCN1iT1rB04Y6ZZkKIQGBNTEV/TPmlM9LfoKCZ83OgaynVZCM1MFLUFvgkS7xJLFygHR0XMR7esl7+y7mPiIYD/YdX6demWtfEs8/LEYpQlxesTM/WNjzS7f8IlV3c+a3yQ5StVHlizIOYtiJXiepytkDUNp4yFDQdXyd7kxSGrrZ0aKQHd/prrkO2pjlaS0R2k2Vw/Qvt9keOxX31cOStQcV0Ac5wzI/L8zopN3Tz4XYuRrFWKrAHxNYPCT5vH7Nwnv96mnddMbuTCPKrDqThojp5KTBXEIrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 17:58:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:58:51 +0000
Date: Tue, 19 May 2026 14:58:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v5 6/6] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Message-ID: <20260519175850.GH3602937@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <69abcccc388952b2ba0ab4b50c31fcbdac59184a.1778416609.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69abcccc388952b2ba0ab4b50c31fcbdac59184a.1778416609.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:408:ea::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8cdbfb-6a30-4319-46b9-08deb5d048b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|4143699003|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NinhAfJJHYZA1dULMXtMQUa4XBLG0XI438MHpZHoE/diJ7oNNXH86OthI9EY/ZuKUXlK9a+6WkrJJRvpac6jXQC8iYEVl953empCtE2ufDP1QURbUoGAuQIUtXXuQFDFgwTiLCy7YVEPGzJc5/orXeEX0MUovn37VIw7OGG8/myLLqYct5gsKh3I9rL5lfGaDwswY1Ko0dheMfZTGtzx46RTB0I30NFATAbkcfU4c+CeMgp2aupEULNm9P95G6Q08pPvKjplVFx4oMk7hrdlMwq+YnqPwv7GeEuG5uIzoT2XSAFHizFosKKzV6eB4qHg5G6bOD/hQiBdGc9etVOrrF7RHj8OdReFdrf/0M70E44Ws+eEVIPBkJA9HGzCD+yCjktUBAFq8C/h1UdcsxG34adenL5Xzo7CbSi0+7UPEMcv4sQluFwVjW2ONo0ByaOET2ba7zGi6jnMGv10PtRy8RhX5SZZOnR/cLO03yCrJ2P699dv6gxYdbRud1uEloIDKWVYHztYCTCI2TFBHJT5WLdGlDQg0sNY2ijnMheo4DIaj8abAKpNApx7mvpb5lnh1QJLkfMYKf7v/qSZkqu1fvXfpCiQJ0t0yBYZRcd5zoR9lJ97B7X4Kt16c61srECrk3fWzFBaqUcEzQK4m6f3YvHhb9h8VdUKAuBIiVeHOwl0tUUgCNZ1CscFc1PBsee5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(4143699003)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qceiaPaioHAdJ4dmvF68PIDkvMPeZCZpRbGz251dz7Hme3u2nHF2S6yj5ORw?=
 =?us-ascii?Q?6TM+FsezaqzxdEvCnphb1haS7iKaL560czKZKIAmn0e6MUTMAlNyLUiSmgN/?=
 =?us-ascii?Q?cQ1G1GBoqXo2wxuM5KfvMQr4cD7w0z8GglaODPPyCzWlXPun1yRs4WZqbkzW?=
 =?us-ascii?Q?UZxlU/7uMqJt+XF1AZyUSFhjgpDG8isPdojh5yY9D0zV7AzXptffkDSfNc9c?=
 =?us-ascii?Q?BL5sqT8LLVtGdXIhwNV2sqnblxPZwwBpM053QTkwdTVwDxbzJqcl1cHV/yCd?=
 =?us-ascii?Q?P6fbmB+08dRobV3CKL+9WJcVpAaoY7l/Y0gSMxoKJlaRgeZHLl3k7ywx05No?=
 =?us-ascii?Q?w9KhlhS3q9FbaYXgF0EU6c5nWvGhDjO3B6eR/uWQa2WyHd+YlOoivSS2wrAN?=
 =?us-ascii?Q?+wPQovqiB7r8W87YU41EFumqyJUQgGwD2fBumOZD2no5Txg8AnuzYUccSmjQ?=
 =?us-ascii?Q?en2kKjXjoaX6MhsKYcAuvoGiBKfoNQZg4Xidzn3VqW0LybnrtStWV+VBDnxm?=
 =?us-ascii?Q?MG9XCbpxyNVNkU867hAx2LZONh0UMHkOkvQOj8hAECbdAfG2ulNjZ8jfwMKi?=
 =?us-ascii?Q?DPhfdXx1Q46V05WCdcWnIZ+UcBVmnlNkXJDPlwY+3whex2Jo6l/NrQqV5ddc?=
 =?us-ascii?Q?Z5jf12It2WOrDG2jmVTvwAiUvMhaKDs/uXwNlxmXeUb5kSWCLD5nkvPRpTJF?=
 =?us-ascii?Q?oZCpPeumAnpISerka3K9LeQH8f5zT7VJ8w2neAqkmLlCPo5+HaElXPyHxYzU?=
 =?us-ascii?Q?GmLzgCLIH0qL7UyJSGHJfJFAfXtWFgbpg7Tn+7e7vlxqfHQj5z1PwGroI59p?=
 =?us-ascii?Q?uh5VufYmpJcI4C5L6qjVAfxkhRmL823ZR3GsGHpld6u7kpW9D/U0rOAlwoKE?=
 =?us-ascii?Q?8e4FBiQDhfRJKIeznui9v9uGc8+MW/G79IXh18hK9qpKbzJF0B/qnl+Oc9cf?=
 =?us-ascii?Q?0nifnEDbAA4Kr1h8CuOaebqTtRtnLg/CHU9FWzp3IcaKhL81FxYpz81xutUQ?=
 =?us-ascii?Q?A+pTqFz6ek6zBo5N0cendg8k3UciR1NAIHEIdadoHXKXQMC6c4rjrDxg62Rf?=
 =?us-ascii?Q?bl46TaMwbIW3JotqlOM1BRFnYfkSJSuKbEt8emLEl85enH4aJsfh9jsFToCo?=
 =?us-ascii?Q?04ABUm+Pxg8pBh/S3oa7cfswtn+fXhYZ8ujbxaxNxTsPeHkzpBLtDSf4pQ9O?=
 =?us-ascii?Q?o2Lv/WWki4t16aOwSiS0thUnplfe32wIhoXmHRd5fyUsTvVYgXxMoBhVawOd?=
 =?us-ascii?Q?YAjYPAOBYNAEx5G/5PjYAGyXaa43LwiF6G0x+WJyLDaB5LJwZiKKQatdmoD0?=
 =?us-ascii?Q?4BmB5S7bgaB1GZXbR9/+JfBrG9RbpM3D9HxXEn+he2oAd0CuzB0c7tzDcJuP?=
 =?us-ascii?Q?8LKulXyPgupArl4h5PL5Fn6G9TfBBrXNsG35bq82Lq/vUJAKl+3NRYAOXijo?=
 =?us-ascii?Q?zXszqH+sHOyt/pdSn/2mwRaCmUVpDDzwDBcxNXY2xTAhiCRUHGavD5icprn2?=
 =?us-ascii?Q?7ooe3GnCmCTA6Sl5ZPtnWtgXgZIP/Rj8xftMEUWTUy0L8EgHPwy6MK2n24D+?=
 =?us-ascii?Q?QC4WteSxW+5SfqHOu8B/xS+miFb+44ZXReV/E/Le1J0Gbt9xXnlhgVuFNaIP?=
 =?us-ascii?Q?K3HnR8UE3W+NcszzBstQaKH9/Myfo5WpnqB9Y/DEuiQZx8MGT/wz6PAZj8g7?=
 =?us-ascii?Q?6un8JFk6lfGiLRj0mfDAcByuMjPFGtvTDFGAPZFnt8voseIG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8cdbfb-6a30-4319-46b9-08deb5d048b6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:58:51.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTivxGpLfcknArCUiC/XqKIIQuq5ZaB8o09dTwcuH0izbAUgSNHf8/LeIY6XUDfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249657-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: B69C2583605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 02:23:05PM -0700, Nicolin Chen wrote:
> arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
> natural to decide whether the kdump kernel must adopt the crashed kernel's
> stream table.
> 
> Given that memremap is used to adopt the old stream table, set this option
> only on a coherent SMMU.
> 
> And make sure SMMU isn't in Service Failure Mode.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

