Return-Path: <stable+bounces-242092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPiYEk5E82kMzAEAu9opvQ
	(envelope-from <stable+bounces-242092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E615D4A27CF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA3E43080AB7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0A3FFACA;
	Thu, 30 Apr 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phgCxWVI"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA0375ABD;
	Thu, 30 Apr 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550128; cv=fail; b=TayAHgFUvh9FC+g1w5vl5ZrR1G4O1ttgJhNXFn/IbZNmojAGQ6IiB6eyMH5NF+hBGGBUy3IOS5sHlIpQm9HO4WvBIMgafq71pQlLE4ga5fk+FFHqJWqv9d9+KtZ16Dz6oBXKCAWv2QOc4XFfFbnDVBdR5OmzDCFDHj9KDQ8tcQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550128; c=relaxed/simple;
	bh=wPWy54fGFlXIfUuRX2Qz10xC9jEph166R1HadhF+D8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=spiWyZJyxhbg8nb9wTggy1OMjBEuMeHCw5EXOhIdtBIZHYbyvOhK2Kim3TA6qEbJZoecqs6QQc9yiaFOWA55Fh53f/3aeUzuoIynISjteaieWh4CbvgFbC+KqgbPFVQAOuF1Wz/mlw8SwvvUly4a4nzxl7f+3/Bk+CVvFpVHItE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phgCxWVI; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwxK9iId+bNtbwQ1CHyntzFwozJHn7Lxhz9G/DQ8du1Cdnf6jyRp76tzgvJNhkTAVpQfjCbZSfurydHgpxKhRQ7XwpdjIJcs2w/UOE9X01PMWIqANv/P+v/TxcgUdpemKKuabY8i51nE39HJjJ89OAORuKKbRI5LozGBdRDCYzB/r7ZWyugLt9Luxj4Lk9Gu6Rdc643BxDYw/DL2/MYOV9wJIh2stN9WY4B8/6Zhva57dfW6oXUg9tXp/CdGdhGZMTL7rTsBAcJOAbO7Bq8SCfu3s+5Meu35iQZoBn83HAw42NGINUk/PqT96A8GDMmXKdX+XuZ41ByIsn4FsZbiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smahzfj9/n3PlEYhLaENrHvsUkPZx5+ExCrwMPMjN8I=;
 b=XsyZ1IgQI3ArQy+6QJFMZ+9yCoBqugkl+2vKnkaRoCbrJNd95E39sbRYUlm5TtbLmSJ252qjzs4JS2kshmFjPynJfUmOqmGMK7pkzkSiWdoQ5G/vDVThSv9TC0kRqFHSL1qFKeJLgiTlBB/P5sQtatZYLUjMFQTTogsvc9UucZFczQdV1rvcWzeNF0oVAg5MyIR/pZ9/zPQpsDeIs/rq1GpDycSR8yw+TjNfFLZBObFwfLdf6O8/ec2G1KdM1TLK3mubVNh0B/jca6n7LBGhQWc6TZFTMZX6zSrAsibsT0BM2klnLOWCBL/7Gj2a1nrn/2hXoK2tI3ykdBwdz8dlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smahzfj9/n3PlEYhLaENrHvsUkPZx5+ExCrwMPMjN8I=;
 b=phgCxWVISiHObHC9gi70/QisdujInbqoqN8uKEpaY2NfG+4xN4aeq4LpnJJUSAAIOPE8jWcoRD0guNRMo1R9S/Sc83TJ2jnmR+G1Tt9peh8ueOqPDWpA07y/Z0OFtzdw6G7ri/VROOq7viTWykJ8AwWtjS+Epo9aIKwE80uKoc4NhNptw0fSqS0/86tQdqlGBpL41aqyt2t4U3Tf3RTpW3C761/NjaAKXM/qcgs19zZ5Xo930ulimQJk7x3iGxB9PCFUFJMzbMFBGY9dUClLyL3UJSoDj8QrssligQbhmkDCD5dhX81FHhuSm+0dnNPM4xwzUkiKwyAN0hvWdRWw2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:55:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 11:55:14 +0000
Date: Thu, 30 Apr 2026 08:55:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v4 1/5] iommu/arm-smmu-v3: Add
 arm_smmu_kdump_adopt_strtab() for kdump
Message-ID: <20260430115513.GG3225388@nvidia.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <edc9df0e05559ee3edfeb833b84d421d9b040dba.1777446969.git.nicolinc@nvidia.com>
 <afJ6Lu0aZyff5TYZ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afJ6Lu0aZyff5TYZ@Asurada-Nvidia>
X-ClientProxiedBy: IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d877f7-7e23-42dc-24aa-08dea6af571f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GXtIq8wgv6UmMAw9Po+59QNma66w7fIM+ME8RZJK8lo15hN+1iFQ9vZALx0xbDlZD4D6nAAFjSYDl768Cn/tD98JV1qu5dxGhcP2IdPzGJX/FIlYQ6PwC/wuI5i2iybu/F0OZ4VFvPULSYaua7Gs3d6runItcS9sEx4tR0fA7KJxUjxh76T6rj7YdCWzybSSolhN9KfbW3ke41ZTv5+S2adbhPmFF8lba4TaLQ/sM+szwCzoiuI3OkAgqo/WuKYG03ZSIkZfOLA3ddYcPPZOTijzJMG4uMbYr5HBrIXTa8HQaydj0xmeUGs4yrQq/bZWA4ZKTzyJDjNe7TSEeDOE5pJc4ZWODWdyau4pMui+pA1/hC1HLMJ69oC4N+ff+jkUXU33M086wjONAmczh5GbSnwKjYZYtk9+zIvMHnXT0CvYLbKZuuKfl3VsmR8RTOY5LFki3zCS3FrD6Cn4Ms+ktwLb20wGiN1yFZ7leWigMMg4se8WPWMhjYWK20OmfMLnSDJ71Nxh8NE4OXj3PTBIZfaQ43WN1J3weKim5KN+fw0DHK6THstIWGlFtZ+PUiP2p+2GzKfFPzHDToE6hjKlNfqg03guSllttI9EDyHt2E/mCMAHdwO3EZ16Mox83e/z2hOMwOu+SyykJ7fNsYCZsRbx2iLEvtvExNoeOou4Jv73fEGyNZOyG9ApjBa6yJH9xc2h+f8DoWdCulw3jPrrpAabOkVJG+U5iLERawsJLaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEZsZFcHucL0VU1I15bAXkqeVTLeqCYz09TbGWw1XExDKFueUSh+JXLUyRvG?=
 =?us-ascii?Q?q7XXR4L/hH4ZWocFijRH4ZGuSBx2szjdfzVekbzwTf/ZAzL/+Q7xOJIhS/oX?=
 =?us-ascii?Q?lCWLS3aKkNzty5Me7M5azu6TCfGMDG4DiItS0vfs6tdGg3HzFaeorDVflSga?=
 =?us-ascii?Q?s3BaMP1Fndkro1paSKR4eYQPrGH6GXq3m9L5K29BQOW5GtQji5wCUanhsLvQ?=
 =?us-ascii?Q?8E9/3UcPGpP1uAKiNRUPyp23NN0BWCcV6c5XQNqus4DExtp+s7lVs0qmVo/F?=
 =?us-ascii?Q?Qi2MqCmXHXdU2KOebUlEcxH9zqjweQ4j5iMWqDWul4CmGMtop79GwzOPVdPH?=
 =?us-ascii?Q?5CXbjrquO97iNu1e7zw8jM+wqLUSgr1ZFUf76o0psyehhQDF6jsWIdrMbJRm?=
 =?us-ascii?Q?TAEIK4nv5eCRYYFGEIHBJttXaoNneToyFMDL3yobNljsCx0Bdd/w1tWOpprr?=
 =?us-ascii?Q?ptn7qFy2KhBNti50a7Mekb25EbrxVH3mh60b4zSq/8gnDK7CnMcEMl9svyoK?=
 =?us-ascii?Q?C/iP+YU8xBqaiy+8HF+EOQpNuJ/pG18O+UQzxfiU7sE48sc6rUQUCn5mSja5?=
 =?us-ascii?Q?Q5lLk30TeO7L3pUzD0xtTk3bRtr4j1vaNPbSU87BngxHDXvp3sHl51LduSRU?=
 =?us-ascii?Q?+LLx6vndjw108Wu8UNp2wpjQ8lnF2BaX2YkVYMe3sA7W+FeI+TqTuqa2FBHw?=
 =?us-ascii?Q?If4al7rRGruLkGePATQ+ckyMyHvlbiweeQK3t2RD2QUJAAAFggVmamorCDNs?=
 =?us-ascii?Q?BPKPvOzNzBCceHJ3FfUqRElG1l9DbBFGnYoKSLWD6XD0DWw3eb1A0qtMGGzQ?=
 =?us-ascii?Q?gCxHwRI65+NA2ZcultCyYgXnkSgGHqnyMrO+1W2dg5XZMUvRjO4coeo0plTv?=
 =?us-ascii?Q?laOX+2YOy+En3OjYpZtGGUskhuNDX9FMUvvrVpqAF131lxnN+nXIBVOp2hQr?=
 =?us-ascii?Q?3wdD9oNQfW6MoQdfs4r0pekrVu5YpFiChdVFxSfqyeCGjf1GfiRN/PfrlRA+?=
 =?us-ascii?Q?LuNAgjwZ0ZL7BfD4n4uQ+CHUqeuVdw89OiMEt/vf7NLbonrfsBud7Fnryqvd?=
 =?us-ascii?Q?+EdHBeec8xSFAmDK7aHo9C/GIUrxydsmK/dZMTOLtRJJCO9JpMXIuYpcTc1d?=
 =?us-ascii?Q?qIFDd9FVEHGkFmLIYEPTKRX1ZvjU7X0sItcWZgZCm9e+aC5Po8ZW80Jq8UwA?=
 =?us-ascii?Q?0xW+WiCa+9+r6daca67YRDOI2wdS8phAET8248JSDUBTxdExrDfmLPuv6aA1?=
 =?us-ascii?Q?UV0aNBV/TzFWwAcNqelQ/7W6ui16PJ6awTe2yyMp3Ka8Q/70zij4jT8vR2WD?=
 =?us-ascii?Q?sC0d44E1IObVClGCvxgCpiUoh2sNwjHxdHfgda2uvrO1zEjDp2Yqq8RqkKo1?=
 =?us-ascii?Q?JVjR6sVOso7kq7TC3Ea5ytZ8o6LWqoVrSLkn2XYX1ZQh6nZxe9yc2vgneB4f?=
 =?us-ascii?Q?QBfRXcIz5UR7kQcNV7xFK1yV+gfz3P5OeY6CGINHZ8Mf7EW3sI0e6ncgOVWw?=
 =?us-ascii?Q?0YYXXo47Ei+Fiv432O9QCDAxCCUJsrdXMzqNlaqbQ44U/2vcZbln8YQPJTTj?=
 =?us-ascii?Q?AihnKILEtDdpVxrrwk+HVdKeW3RTOpwbjZP5EtbTH6CgRus/ZzpLEVu6tIe6?=
 =?us-ascii?Q?F3NljGe+iw+rADIMiU47IN8Juk/PiugLuVQffSP9OW2xeaLRNG23VF/4cFKf?=
 =?us-ascii?Q?kCLgKfqRijO9nuSLgCKLih1hWuhLet1Ru8NAFJb4rFehqS7s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d877f7-7e23-42dc-24aa-08dea6af571f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:55:14.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH/5YEztnuECZMIhQB0lRcwYmzsF/nAcJhxc80Dx/ssfA3brLeD+Ys17sCjHj8wU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797
X-Rspamd-Queue-Id: E615D4A27CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]

On Wed, Apr 29, 2026 at 02:37:50PM -0700, Nicolin Chen wrote:
> On Wed, Apr 29, 2026 at 12:20:49AM -0700, Nicolin Chen wrote:
> 
> > +static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
> > +					    u32 cfg_reg, dma_addr_t dma)
> [...]
> > +	for (i = 0; i < num_l1_ents; i++) {
> > +		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
> 
> Sashiko pointed out a missing READ_ON here.

??

There is no concurrency at this point?

Jason

