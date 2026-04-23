Return-Path: <stable+bounces-240536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uImpCg976mmqzwIAu9opvQ
	(envelope-from <stable+bounces-240536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:03:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B74571B5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422F4302FAA9
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF22C08C8;
	Thu, 23 Apr 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PXy6Iyrb"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0F41C6A;
	Thu, 23 Apr 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974600; cv=fail; b=idV4Ck4F3MtmICliIiU2HT9BPcNFF8HPFvEr8BkvDrNaJNODJp3rm679nvB3xi7iNlFdhF+3X9ObVSdyr7Sdf4nV6W+z8rHVnMwAQROy6uZcg2qYX4I6KwWEQrX4J92BaIcrHUYAtffw1VIMADcKUB2qeATgpxnV/lygqHs3+sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974600; c=relaxed/simple;
	bh=yrkqsBJpfKJazeeUubogDtAmLqWcWCo/LSdwUQew9l0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG+MhHt7Wp+XCyS9tZCK/Q9z/vRDTpPErKMdaKb6Tscv1IjU9xuk1zkxaTSLSd2LiKGwqGAE3bJOcSw6eHtdZ6QImezT4WRbr4uxNPAqXd42gM8xXb57kSzVw5QB65ybxHhzmxnHcdJBlX3P/HLnEOp7SV7Cv5VKL7lljzvut98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PXy6Iyrb; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRrxQUfkUVpHvtRnQVn7IKY0uec0C3JChQrNxm8zNjm5J9w71aiBsJcONf3POWmOz7SDA+r8eLrLj7gahM5kc+OTXhaTUJj2X9SKicHmmrzJz0Fvx3tnnOpFKNEGrMBbtrPXm4e1U2/yNiEaOCUF2jH6X3yH2JhWyQbJxV+LzkQsey8aP2LWxjAoOpih+Ls7bGN/QvfOxe2zSGUDYe2/HWAGkMn1gLzqzXCsRGEoLyQOBjb1T6tsO8mKJWWqW7xVaypBb7eR5/RHx0NvJv3IpGGJHZCx477oCUKMZddXKiLAXgsjeIwozYlnYLbgOaz20kF4ckafndkrxNvGoqAYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L66LUNwoDrC8v+fLcz/2laZfBAffYNs40TcmMe7nvug=;
 b=MpOfg3c8/OJ9aL4kBRCnYCIvmM/Krz/MuAJInbI9Zyb0a80xrq1KPXpxLcJD5vnF0fg0VovAsDFi+f0cfthVw2ithcmLt8mwhA/qOics/LHjCvivDMlFXMvik7dUWLFvMK/nR3Mp5LBLncVddmtTu7Hruf/sZltUwq/LomxbaXVcVQT5NZuaN2b5roa7y65T4ia56mtOiMYrbiKFAH9JkPTL9t0AoKA8GM8QoqpWpmBcRSfOn7beL0fppumOp7Qvts/K7fHRhvimbd0mHiKo4cWkrkD7Y6TvxbXOxYdzGCBbq6bgl6TNsrj15coVBsykljmtcdiSSLtmQTEznqpC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L66LUNwoDrC8v+fLcz/2laZfBAffYNs40TcmMe7nvug=;
 b=PXy6Iyrb6gw/YTX6RNITj6BytF9N55ykx1wWiSrdUJRuM4fEM6pIQJhpSdUIiMy2XAwvJLzCcV5z+ez65yS98gOII50DKoPIGfY+grixqlrNOpXzvBqDm2eRNR05JjvuuJEweK6b5yD4oY0nm83yRMKZJATVssWf28xxb5PCWQZ+10XVFdcF5XvV+loBc2iZ+OEog4NTZPCTFtimZ/cC1s4OUMn1wHTXmOZOOehdhqUmwnSVEcOKqQTPSuf/19ZNkFUjXKmNmUfV3RFfzo6xrEzTa5HHBs3cBQZmh2+cJQQvH1EXnA+R9oAepbw6PWnuA6v1XI0A9k8q0ZRRS4tfxg==
Received: from BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::8)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 20:03:09 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::19) by BL1P221CA0027.outlook.office365.com
 (2603:10b6:208:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 20:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 20:03:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 13:03:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 13:02:59 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 13:02:59 -0700
Date: Thu, 23 Apr 2026 13:02:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <aep68esJlQjaG1XE@Asurada-Nvidia>
References: <cover.1776286352.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1776286352.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d8c663-6020-43a0-1d37-08dea1735713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Bz7W/8hCAoY9yzCBrB5dhMpHnPPBfw9m1oDeHo7+a4j6KRadkjMTsEhA5QPZLy71lxjhySP4Q4wBK5ZptQ971cZ1gHm2/aJlInn9rJ1qyJj2XsHWQfhf2SvIAOXBPr7i5FKLIEZf57U5FJ0UOs4e1sTQ4SeYGh1DskRPX1y+YV9Ao5NjZPQp+plKfsa8lYdp6igO9NULplhRo8IBlEG1LAJtuCJFvZFoj2DoXFt8M9le2ftNsSxsm0OayMiHCd8a9l8XoQMNYLm7MCvgPcGyFYQIeGrQiji/ZCXKwvpTxgoT3pfV8qfeV9mUMPm3gLfiQXxYL6AGDuAlzp9DlopceH7hHZvg6EPrOb1qpQN3K2C6boS7M5AsqqAtgE7gMDSekHQbVxWhWAQZJjUC9GC0fED4/BP+fttmOtst9RLscERdAT6ds1XQxBco0ZO8bNiGHsGOdsj+AVMJ9Eu0/qgAiFctbicJ4PwjW1PK++01WXIsYdM9nm0r5sKlFDgNKVK+ts8mURqIgzzLauIGBqkqC7P6/lwW2ar+gqXaqOjSqxsICK5IbPo0JjpX3XQY4zkIW10QmowNhJ82Y9EIclFSMysrEN1wYlqObqYyefnUMWXmFPPz1/imPsbb4BiRBWn4VnIagdtEBGljEnDF6R4Q46y93HMZE5cTzMqbXceTbRHhSz/jmszZx2wUjtMU/Q4NRQ0GB9t7PoNUBqr74g5qhVwpmcJEVaFxzTyHx822RuZJsho2b43Z/lpjC+ewqW7Z7vofYw+NZIchowqtuTt3YA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S9675W9krBpqA9cb2pqkNaVXb2mI2m1afwOD2YaXYzbqYWMq867KCjc792EgiXhWukUccq9yBydkzs53Mg9SlM+PRyVjKTT7Q4gv+RGNOD6ojYQ8KG2MXk0g71XjgSkm5NlGKf814vxjWSZ8T1HWGDuppJStp9+9VV9QlD/3677rMrorN02sv7zyw1fcGe1ErqttYz28TkgJAT81K8WRFlehb/ymQfO6b+CyfVHTSFbbsAgeYVjjYcsS80k1adfWou96ySWw9QJ30lGOVVuNbCpQ7Y48eRWKPLg2Qznqvyw1azYkOXa8UI8ODY0/QMKfvO+l0SDtWnTxIU9gZRozA/YMa1Cjz5QEqU0fZuib/9tiVxabMComtfKaX/rw+bDh6BSYppafy1V+c1kwmd27ecObM2HwRXYMR/CXTkLpoYT3cfsgewjVj0SNOPqgk49g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:03:08.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d8c663-6020-43a0-1d37-08dea1735713
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240536-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 653B74571B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 02:17:35PM -0700, Nicolin Chen wrote:
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v2
> 
> Changelog
> v2
>  * Add warning in non-coherent SMMU cases
>  * Keep eventq/priq disabled v.s. enabling-and-disabling-later
>  * Check KDUMP option in the beginning of arm_smmu_device_reset()
>  * Validate STRTAB format matches HW capability instead of forcing flags

https://sashiko.dev/#/patchset/cover.1776286352.git.nicolinc%40nvidia.com

Sashiko posted a few comments, mostly valid.

I am fixing them with a v3.

Thanks
Nicolin

