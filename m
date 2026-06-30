Return-Path: <stable+bounces-270030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ygwoCF0RRGqonwoAu9opvQ
	(envelope-from <stable+bounces-270030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 20:56:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0B6E7567
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 20:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PdIsAADP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270030-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270030-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EFBA302BB9D
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FD24E4C4;
	Tue, 30 Jun 2026 18:56:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98E272816;
	Tue, 30 Jun 2026 18:56:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845781; cv=fail; b=pOGZ5Fi2Jy4HfVJnlGMTHjMGFRU1GejQURDVurg5UmCx8gdsBwOYjCD1dSJbzhXw957heJx43dPnPJpe0OoAnV6fv8CBTfauipMP4Y4duDG77XUz46LX+anu/zDzXeEves29ImidDsMW7JTRIgV9erfS6xg4jzvJaepzSX/KKI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845781; c=relaxed/simple;
	bh=YiJ3EAme58nZW/dmNXqsZWfzRWeOVMWFj//CFENwUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2bRCqBLrVGfCTWo81/DC0NUkMa9EuQNQDtloOXNYq0IdmJIxu93fOUOfe9THoWJckLRWnXuZ7cmrg1BziyaLSdMM/0jjPxjlOtC0xA2qaz3Ai4ZacBpeVihaAVrfBnPSpQiTa0Hy64NyeLmV815L5eJOlkd3pqzaIXvEIw/ehw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdIsAADP; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCj51bhV//46dJXXur0GlDgeWFxG3e5ASilBDCFZFNnUIqnvQCkAA/bYeKu8PAvV4iMwDvIowlivxB3fyhOXWw5dTyvsgOF12dl1Wfl5dmOuKLhbpHlyvkq6qT3185puLXNzwMPVjJldppuMpi/JEY/wCwCT3/TrdXRLFtT4IHmMcOGfqhkKkpHvdrZDfExxAm2L7lrk0iHT8vEHFsJ4Dsmb/rGPZaS+EEA7H+YSIDzOp25ppVPfxU8eQ/JJrzpGO48QvCRuLsT8TPTQ5KC+cn6Oekqd2+YLMz7xvypHgs7pWgXL1CQyXex+7T+MV6cYHbGgd6XmGFYKfnH/WTOeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epyAOUNtIHPYFjtaVP0WgukvzYzz0ZtHwHBolB+5iV4=;
 b=ITMuOBSsebV4fgCjGwp2In9Oe0G1Z1Uft3o7uwOAUdKqmJ5NNZPTBqgoj+7jT0Pl2QvhGNWQD3Ml0AEOgJMLamGUB99rT+uOxIEgoNKORH0w1tZS6OeRVeX3/U5OYnmJb2wDaGpC5043CSEEtafAjZXy7oWF6oQRBoKj7rPYCdIPaZYZi9PIci431Xa6XTwlGrNFBBtsRA11wyIoU3A+ainvsTS8IdPE7pnP0KsfSeFbYqPyvCbhXDGpJbr9Eknd6S2ld19WslOIUrPsKBsIFz+q04fuh01Sc1/Y64xDZVOrYmHwQ3ghRLrWbt4eidcyo7ERr4J6TBUDIZV51ZLHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epyAOUNtIHPYFjtaVP0WgukvzYzz0ZtHwHBolB+5iV4=;
 b=PdIsAADP3lnaoSoyGyn4fGHl1d5a2pRFNgqmwAB4dGXZEGun0msbMaWoFcPK3xOampEikM0EpvBp+FkvgcD1DgG955PbxQHQDLYyo3qhyEFbHEke0aJLZEyKdO+vnWrY+gd2XrZX9KWQoDLxFpyuXEKPLdkJp6hQFKVKbUSo8NZhNixBfUuZf+R/jWTacAzO6zSkG8iaAx7QqIFxbfY48rKLD0WHx2LY0Ccbj25zEG08ouuF5jC36t3Ab5BLzI8bNupnv3hbQ+fn/6b6qtaoMmA4L2iX8NiJef5/sV/d6rpWkpk7Q43xVjJdhYjz/6JwQ4wiDiMlNIwXcxqbk0qJHA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 18:56:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 18:56:11 +0000
Date: Tue, 30 Jun 2026 15:56:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260630185610.GE7481@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPB6l-fuJUcg4a2@google.com>
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5cc589-7e90-4569-ccfc-08ded6d940a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fTpSGDyStESGcj7A4pYLnSBXBKCdkyhhWvE3zwjcIq4jSWSl2GNgrA6x/fMUkfCZEsXCr5cLZp3fbmRb2H0TYgtj++yU5ZbP6zFSBcnG5cWhEqDch1p3s56+Z+zdWd1iXZ6SwzOlx5rWzAwy98KVxwe3ibK/Qxy4ygd6oVUo8lIRI42eH0lwFqIoWGuxzCJFSmPigdkehXIki8wSbiKOO5SCqZ2U/bdM5irPN1FscTEpTWOghmvr6ImXY6+gklwA8QICVwZwzGqkWT8n2vrPT/HKQo6YQvVFp1x5MTAfWv+LkVURpAi5MDhg6F5TMHXUDVcz5BNb1zJfVjQfpxvm3ITI4RYLXqA/IK4m2in+vGMNZepuTev9gUbtyEPI122TG+DUu4wA8t4y8EhDDNLwX8ZwCyUJYy/uolwR18w9PSnZXf+pf6eMXVYoYnVvelh+XHVUoshfSkWnY+oA23MJPD6P8/30loKbzB7ZdwcxNou6Lg3rTCiYB4oio3ESAW+9LARR53pzdDhpsywMsE/sYtM9e0c6b918O9KXuq0UHiIrOG877hjqrJ2W5szsd/hv6IRoW/6BFmgale6OMNbQaQRt8SQqD0Om+nFLY1glPejfyXwQn3R0lH2rKLHr98ftdqd7KogjG2P+FT4ZrA3jGWTKvGaTogcFvMxpBn5dnnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RM1okTjhjiNhU3P8NPiNo1NG61k7TI3OiSj6I4FtzBSk5L1lzeFHdZS+O26m?=
 =?us-ascii?Q?qSxoWymmNLJx4e1Uz5J+FZcfWE+hHo8gqFHoERkT+CudWSS4MMGm2KhU9DkR?=
 =?us-ascii?Q?eez/1BX6uYFF0KCqjqavUkX6Gv4l6Yyi/Z6zkkjL61ZS1YKCw8WhYDaiFeTQ?=
 =?us-ascii?Q?sD1g8QpavfBxhNOF/wYLtAo3BClCM7Hsa4RdehqeTEzBlxCllqyBy3LTQ9kM?=
 =?us-ascii?Q?EawP5i05uDw3i6YhP0/YIj8aAkzv5qQRa62GGSh5FiojzyOtjCBDxGasyfNM?=
 =?us-ascii?Q?/g4oQ0vd/cJSOtybikx2QION5DdeTWQL3aQssO0VK5BO66g8HYLSwo8IZ7aI?=
 =?us-ascii?Q?6CONbLF0sbFW2/ptEoxY6Eswbm0aJ8HUeXx8iqys3/lH32m0Uj3hYeOeADYL?=
 =?us-ascii?Q?/h9pWJHO/nFgHll4F0mi3S/GIWgu9uXB97dqf4l3CvL1HSCETD657D1QVyLp?=
 =?us-ascii?Q?3XwAUP11YJXrDcu7aznBOC+J/RPOEu3yclJWGZevtZ/HPZflvli7ATWcyp8S?=
 =?us-ascii?Q?dQkkp35LzyabvIKaouMhLIt+qw+rvdpdBHhhWivPkkOvdxn9kEc9dsxtkDuW?=
 =?us-ascii?Q?4vMKArTSiK/JbNqcPf6hIT98M7FUrJb9QBDImchzI1aOflw/vi9DkDRHUFhy?=
 =?us-ascii?Q?GWGqK7Mvc330Zo8uFLr2CWOIhkHYldrlJYnqEA+oG1IodJlsNvONdOyxme5o?=
 =?us-ascii?Q?mjC+DI9oHTaYM5PAlsg7udbYI++D0TIUTbGwYCZvTVcU8iQwhNE0pmD7dW5V?=
 =?us-ascii?Q?UzKs+mHDreV2C74P04xygaQmI6Bz5/E0WWxL1j7J+dzrK99tOSAqY0ApDH96?=
 =?us-ascii?Q?VwK4K3G5LShGBKArXkzhMIfmmes3PfBhH0JnRXMbGfVbmIGBDfKWl2/f8P4p?=
 =?us-ascii?Q?rP1/s+U9CjBLHHegqytweCzd3UAKiWM8Tk2/h2kHJJESvdgxp8tbneFMaDye?=
 =?us-ascii?Q?y7vJQu0WlnW2DOvPJ8LBndNVQyNqEltIMs7EHSKkedw7L2B43cjYfJXm1QgV?=
 =?us-ascii?Q?12q6ZAeVPX+zOeOJJXnrMAIMIC/XUtEkJR17FffSaqoxaE8CDn9texHf13wJ?=
 =?us-ascii?Q?aXpXLxJFk+PA9oDDqY7psYJkTuD0soQxKQlpKVqTfmxHM0cc2QUBHBRVZdxW?=
 =?us-ascii?Q?sTwF6Szv9CQrCQTyjxStWibmZLt6tRp9r4lk4e4+W+ZgP9vLyevgDWhT1E6Q?=
 =?us-ascii?Q?wkAWGBmY42DyVXa/UDaBMB0lzU5q2PmiHtYOyBHCznCZmeF64H1s71PVTxdJ?=
 =?us-ascii?Q?8LuT2gomokyR65FYWl0ctiUgxCEyr2saXPetzhfW77ISSVlWFOimQj2wkQ8W?=
 =?us-ascii?Q?NIoxdfXcrhEEEx2ZXZ3rKGD/O+s50kAEzvYlNomiIXNxXFvxyTCFPIdlNEnu?=
 =?us-ascii?Q?a6WI3Nfg7GeClmSKZpvcIrgma/Pl+8GudMiPdAOlYLfjFhBdhX2APMG5rKt2?=
 =?us-ascii?Q?VRRjZAK4QfVHXze6OzMdGEUlN2oiObNzy35J3E2S7RFTzb5RGtslDb0A0OVS?=
 =?us-ascii?Q?h58QhXwLHd5k4T0oa4trV5otz+2AMIwsvnsn3sKKt+u1BrUJkp+GWGUYiTjv?=
 =?us-ascii?Q?7Fj6qiC/qfxLNoiy8+X42hAM6nLY+ky7nhxuoZrFV8XHdrqbCCKl9L+/6ODL?=
 =?us-ascii?Q?hrbF5iqSxagYutOuxMVd/Yf8S7v4y3lsGia0iTQR2VnDubk1t8yIrznGa/PH?=
 =?us-ascii?Q?5zUd2EGbZB0ydiEir84M5g0w3a8VbNFcsafS3722fEWhC7Y0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5cc589-7e90-4569-ccfc-08ded6d940a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:56:11.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us1OkU3oI9N/5dE79f/jJSvRWH9wABt62B2jgveGFMXXUa+xZjMnXlrIGwoManWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270030-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:smostafa@google.com,m:nicolinc@nvidia.com,m:will@kernel.org,m:robin.murphy@arm.com,m:joro@8bytes.org,m:praan@google.com,m:kees@kernel.org,m:baolu.lu@linux.intel.com,m:kevin.tian@intel.com,m:miko.lenczewski@arm.com,m:linux-arm-kernel@lists.infradead.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jamien@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DD0B6E7567

On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:

> In many cases the patches assume that the CDs/STE might be corrupted,
> but still attempt to retrieve them with some validation
> (log2size/split...)
> However, the base address might be broken, TLBs state is unknown...
 
> IMO, although that might improve the status quo, there are still
> heuristics, in addition to noticeable complexity to transition the
> stream tables.

That's basically what kdump is all about, try to improve the chances
that the kdump kernel functions enough to retrieve the dump. There are
many reasons kdump can fail, but nevertheless it works well enough and
often enough to still be highly useful.

So, the cases which are frequent and problematic should be addressed.
On this HW kdump has a high failure rate because of the errors.

Given that non-disruption is exactly what the Intel and AMD drivers
both implement SMMU should also.

Jason

