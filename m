Return-Path: <stable+bounces-241009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H9TFv6k62nIPgAAu9opvQ
	(envelope-from <stable+bounces-241009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:14:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D9461B71
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595683021E95
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669A33C195;
	Fri, 24 Apr 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4z5HDBX"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300B33BBCD;
	Fri, 24 Apr 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049973; cv=fail; b=NvHIISL+O4v93xFAI5JyPIpzFUqziDiGv6I+TwFDrwHAxXXH5aGN3jP0CVHy9u5b4cTCRA/ZVq2mrYZcYOs7gYJHBvMgDTDpUHwxk6G+K5LdGrJghrT2Ee0Sz7GUIFq9aAV0V4ObdmxV9rfcnwMGwa0n4E8m6LktLrp5kPOy0Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049973; c=relaxed/simple;
	bh=+qAVxxQby5elM5dUVCoDwg1ypCVobMx38b8f8ziPB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PGzZLYx8AhFxsMEwhDUvdE3oqpznHws57p7MzLPzu4O2iB0PyjHmUlMB7cFjqqOo6y/bZsfK5N4yTZin2YYh1ygLNdkAR2l3l3xOIvb74HzWYaWl2AvMSfl7gXpRLV6cDBIKNQjc1+vPXiumO/KUvTndmGrXyWo6FddFaIwPnD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4z5HDBX; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFgZ+n+Pw7ecEGOZs8YOZpKE91rxVW/HXBCIooKABDw85tBy2lbJQoT20E/eQBGjPY47ExOJEdNhf2coiinFxsKO4xVdpIDBTq2eibYlY1uY6kXLZNXi83wsdlxLu12L+4pMuto6dKMalQjnieaOPsXQJgwZkg2N0IJxeyjNVj1qMvFYotfWZZAmFEeIkUfoBeUt8nxaq6r5to+hKc0IPtnjTjUdH4M7l+2JZCVz8VOqBfrUFU8cpnpdIoVq6+ceFtc4cmhB4H+gnVDUsbaTIr2Ekef2MSW1rNaGdmGB4WC4q4GPhUUFOsLXR0kTF6AxC+tJ79Tr5bepWdGsFAXr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OSshV25VRuxTYhlhQfnNq227Z5gMoiSkhRFHnQ3BE8=;
 b=FqIx4/J3jeH8ro+J5roJ4WikaoWgQgduyutxDVae4+TfCT89P4TdcUrjxlGKLscucYNk0fCgqj1SnW9JpWZAYX1hIFiUTj6pak+q+dQZRIdBsor4Lb8IDh1FAgyfggkXApbr4MDevPpmxpInipMDqlK+Dt8oPMSi4KPCKnacupYK16G409cQ77HpEWmcxI+PE4Ul/QMsW/yk+SIH5up7WNopLa4d8/OI4R19U/6/sN3Wz2EYbLujJ3vF8ymdUUpyfAp6bQTT/lenB7og+kNI9onTK49X2JBL14Z9FWHw0W8c6NlJwY4AeBA03eOFHRUaOgZNy/ZTmqySKjYP5/HrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OSshV25VRuxTYhlhQfnNq227Z5gMoiSkhRFHnQ3BE8=;
 b=a4z5HDBXOKwI+Zfc7ZJu3fA33o4vcrcuSCzi0Wb516OQEQ3yNsX6489eUsiabputG8cVYkg0nFvlylbUn0Y+Z0y4z1kTW3c+o6j2s2pFDGIxcshVe4P6J6J9I7nw+Mtfr6j5i7rA2eJ0zzQsWH931Dgk7dWDmObV2QSh9k3bmSPNlGk2178XFLKj/c6Jk1oibzO/LGHBnkfm62P2GnN0tCvcuRpDS8yQdOLRjgRwwu0IDt25YQqMWSZm+/6xJIkNButOQ1L5wLxr0rsiuIiUtzq6EGBMAhH7zBtTNKXJRsFe1lFyCjdl7kjrQ2M20hkUfZh+6MZo9/4WDQlnhP0IKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 16:59:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 16:59:29 +0000
Date: Fri, 24 Apr 2026 13:59:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v2 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <20260424165927.GD3444440@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 050e695f-6e53-42b4-a791-08dea222d924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uiW54GpT7lK/zsTN/bcb/1u1dnj70i3bWZgUu1aUMBe3MQ5WHqnHFqDcW1aQFiRL1IW9gZU4T/BdeRw72PyIIPl5SvZeouWAR+NtXKJfc3t+BjpDVqWEW0OBdVezYNyc4GAy6dv6fYjoXET1cfpRgwjLtOCptxuMVFmS3JqSgyJdnX53/gpKhZ1FRqV0E8CEzDg4utiVJSmUjvECHuOa/a42qs9cso0kezjoAe79KkhNaFjtNmgj+bFbmFTVqzL+/VrwZ2xT2lQt6T/+o2W3e7TQXJkBdAP0ulwAwithy5wr1w+uXtZZA8rwlHY7xoY8fxMWUVKoa4BIIB/tsEQhAs2OEuZd9hnw4d9NmV+2USZIS6Clez1UYWRlohhrcuZbehPwH2OwpJ+N9XRWyDThNhCE9JTNKgG2rNgqksQK0QktdiX1iWOiwE0ylr6p/yF4n3b0/+dNnIm+GBaR6JLW074oRyfPn5k4+p4QVjsUXxFRyoxpkzgB0uaMMilZSe6/Rr0BdppiXI6dKdCnKKj1/QG6hGmRXFDmPH+ckYb0Iu+pGn0ftvcYEIJm1mvStgI28ZezPyXTMqB7flr/ooUMYXGbQVagkHTC6ENBdx7sTgw+1I9zPiSHqf5rCfbtGeIJyoqCih4edRHGAZ4/HEeEd2B7g5Iq9xXFzVRRHycnXPgUM4wt1AMTqg7AOrFQr5Xe45JStBprhDbBLdT1DpjXXRaYW++ieCDEkSor3/yk/2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?061LsEciZjaqKkNSSpHwL/kQklUTazjLq6FxnTZOtVIeINlcg0fdTv67/DMw?=
 =?us-ascii?Q?IWae3OyCuW/WuQwhGAFots/V+5TxmLa22QqO2li2Jtwv/sNBYk+S95BeL6/g?=
 =?us-ascii?Q?FKhoVt7U7zpj3sN2oV0Kl/ni8neHhsqVt5mg1NtpvIUbP46rp5BXMIieqHSh?=
 =?us-ascii?Q?CCakS8nvNZi3/ECcb1W7gsAa/bxRze1IFs8fP0dKexe0ZZ9ScBTN2YbEYc2H?=
 =?us-ascii?Q?e3o0Z2bdZVuOn5v9obI/i/rjfS5JBqk3QmVbSuyTOtAAYrYFcLTORkWYF0Fy?=
 =?us-ascii?Q?1c7xL1mWtSFzYRIEuY+h8TkZbIT00BA00kLV2a/rYMDxMrnMlHDHO/LBgWZz?=
 =?us-ascii?Q?gWHhN40mzvh8Ibmgc1eLPFLOaLR8VbIdHmtkZ50n86nTzC6fTe3ra+pvYIW+?=
 =?us-ascii?Q?p32A64TRuELjKFkSDJPJqQspu3rZCmuHQEhZEDy5Efy7Tbf3hRjXMNXRQU+r?=
 =?us-ascii?Q?XwHHcrcpiy4DXp9GDos9NzVQ06Z4opiFax1GCxY9b6W1Vc4rIpyr/84iz/ya?=
 =?us-ascii?Q?dyw3NMmhlzgtNe19zdrBGcXwEC/Rsv+A6seIq/WMw6D7lJW6owSOXfkGid7E?=
 =?us-ascii?Q?dBn1dZ83HFuxmbdHa4s0Zo0u5CfbeRqXwwsa1XX1SjW7E4sTz1AmxZZv7scH?=
 =?us-ascii?Q?BgeXyDLp8b5c2/DyD1fsP5aQRxz0w4tTWlu2EYyKvGW598NNrYPskkIDdAxp?=
 =?us-ascii?Q?QpGKJNFWb50w76q+2V4dvjLZfMyopxPb9LbyHpkD2iyGRFmhHzJGwGuX5aaS?=
 =?us-ascii?Q?UBxjNU3QlZRtK5VYnngme5ciqthGfyMjTe9CSUyI2OcBY6Qjl34SMR5Vyn9O?=
 =?us-ascii?Q?I4QJENFhZaw7PrBbVZtl+Jdk6vhd18GUlQnr3lKgdP4HtnKtaQ0XSruorVQp?=
 =?us-ascii?Q?FFqBQ8dLIZ294FZvgawYTkp/rUbP/Bffy6PEyGcdQd+BDan1N+q+XP7CgiIt?=
 =?us-ascii?Q?C6d2YfCoET1vfJALOUbrmom0d800nVZJDdNLJLkVQMW9RdBnIDhqN+OrI4Zh?=
 =?us-ascii?Q?M7IcZA4u8RSwEjY6ISX1aMN3b/oFh2ZlrKKeKh+AYKk6QW3cGQToDhrDJPku?=
 =?us-ascii?Q?f9WBF5yU/pNKYuEvECf/N8MIXuiRlH6ZiLXXU6u/8CDY/nnWt7PrwqHrcKQ/?=
 =?us-ascii?Q?UfFteAxTC7+Wste6ZDsK+NMUvorGQY+oxwwEACIpB+3H3P4x28tBu8FbxUPX?=
 =?us-ascii?Q?F51aKGS1qgfnI9sULVulDcUosg54zymFCF9tQF40VMu8AAqINpw7newb//1+?=
 =?us-ascii?Q?Sa+La7IS+ivFV6Eqm6mx2SV9gPYsHlWIi7QxT736u59NxGTyhqaW8WePvk9I?=
 =?us-ascii?Q?KYy4JWoW+xUSHQ54xhfSNfi+Khn4AC6qqI1tLm9QR6JnLtH8+sJNt/lVb+BI?=
 =?us-ascii?Q?46aRlrU/hySkMpwGtvTSMHTG6Tru9RFdlFobwj1lv1dZ9FfQHcIsJXOmdOQ3?=
 =?us-ascii?Q?bbkv/sQp2SKS8WgJ9Vx9tP9ke+PCItVho7LIXlLnJ8IEAV4HjV/Ea3GWTYgK?=
 =?us-ascii?Q?AW+PmNMHC8LmaszG3B1LT+2O8+94HXQShOn/R2uGSIqsOkQ5xEg12+wkeRp8?=
 =?us-ascii?Q?ObhpLuEjb1bSqjQkodPsnZ92dfAUS+RkbSGfog3vulXzFEjhCCM8zTip7zfO?=
 =?us-ascii?Q?88fQ1+Ryq+6MwkE3STj093S7fPuIqxSSHtJ2mWTbr/BpRsq9jT21Q5X0S7nw?=
 =?us-ascii?Q?AaX8Ys5hpkFnHbIoqlZERhcK4qeETBq1RA6ToOjZLjExz5Ke?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e695f-6e53-42b4-a791-08dea222d924
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:59:29.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPv7ZgzuvnGFKcnZ0FlyOlqSYt9D+DTcx2/wAkxQ00L1/fCgHC+9OHfWaB3hou4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-Rspamd-Queue-Id: D79D9461B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241009-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]

On Wed, Apr 15, 2026 at 02:17:37PM -0700, Nicolin Chen wrote:
> +static bool arm_smmu_is_attach_deferred(struct device *dev)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
> +	int i;
> +
> +	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
> +		return false;
> +
> +	for (i = 0; i < master->num_streams; i++) {
> +		u32 sid = master->streams[i].id;
> +		struct arm_smmu_ste *step;
> +
> +		/* Guard against unpopulated L2 entries in the adopted table */
> +		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
> +		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
> +			continue;

This can probably just call arm_smmu_init_sid_strtab()

I think it is OK to allocate another level 2 here and it also has
protections for SID out of range..

Jason

