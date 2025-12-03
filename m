Return-Path: <stable+bounces-199922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6064CA195E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E03E33019B99
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C92D3233;
	Wed,  3 Dec 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wd9ZTfyO"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF782D24BC;
	Wed,  3 Dec 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794736; cv=fail; b=klOlWJjaVClrUpxSZJyUI3qVK+PkFw3tAoCVWcg3tw2S9QFnDpjI7JFTsWpTmIRTKdMuJO6TUSVVFidy5WzPqRmfpmOqdFIBtNr/wtQakEphbAGCD1DMqe2QIz/I0OW5XOBWiFW346VpOcQVd9TLmtfPBMWxqaq48ValK0rT0Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794736; c=relaxed/simple;
	bh=SkGdpFHc9MWns/OItJMW0iSx6Nebrbls9tTQSmdNpbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GY8w+1SVRGTssgJJJISZd2gGlHrIsnVhbTye+47N1+rrFv3lP8f5b8Z7a+sEHH8RtMk/klSAV+07rne4YlY1t7DKORAUravaMGqrqNHziFyb9dNXZO53uqFa5iHWTY+Gocb/SA+gMiDqZNXBEE1LsaJoeFLPwaSWTZLxJTrZ00s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wd9ZTfyO; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU73C9anZPrbBRrNkdmH28FaC/onavCEc8jmXmWyphS0/yxz8WJdxjh0pZLEe88IZjKNMSf9StT2RZDH5vhdUm3SyuOB4wyIULyqH1yoxGf78kqtVkNkq1IEmqEYeTAZR57bOWmQbCN8Ly7bKCpExgEyrLktdiawc1ULPojovEwOxO8hR0EiSPfH8f3kkysWoS69RdtQf74CyC3SGrkOXgbN4+YSu4gcz8EpPW9pbVjmD+pp76lPA4RotkMJPjjISCwYeW1D+lUyoe/NTAAJo736+LSbQC6bQ8WBtdOqDQbulBxoDB0xSIY9lGmmOTWg7BPwh+L4B9bCiF638YqXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9UkupVlbgujq02IOQIjOjMkjiO/EVjBf4zHKjijDLk=;
 b=GzCsXmXh1/1hxEHWRF2z/NjqnXyizaxGXNsFnWdMDocr1PuH+QR5Iu6XERwG4eztf7vSUdWf19UH9SbxRdEtNUFX3oC+cfxeSg8K8d1o/w6cjTlb5UYw9JrmvxVo9rKZGNdlWKVUzi6XOmDNYgs2gOsw4CZk6Qop97ouWqSEWFQ0BMVTDMXkasj7uW/W4l5kZ0kOcGJJoyIPfHBPNbm8tgagKt8aLVlmTPpSWG3g0UqEca1M7g5lzElgX+pkZ0u+BEZKHmRqu3eKMlb/ilaWVdEcXPQF97ZhXI8hREQz66rWFNtBOxw87R0wBeib9ZkFR9pg5sFiKKy+NMBgRykmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9UkupVlbgujq02IOQIjOjMkjiO/EVjBf4zHKjijDLk=;
 b=wd9ZTfyO/OwaJuv2HKHnF60/0ehp0gvS/c/aLc2bbk39ASgfHC+sG2xzEIr0os5HnmR7hEwOsG2QcpgC8sKRtyd6JhJbTEBV9n0zrDHrKoYbJwW6T1IZBK1uFVEmvLs7Ukex+VvizaJQbKrKmTvbwgI8LLRXvFoYBPiksmf3nUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 20:45:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 20:45:29 +0000
Date: Wed, 3 Dec 2025 15:45:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Steven Noonan <steven@uplinklabs.net>
Cc: linux-kernel@vger.kernel.org, Ariadne Conill <ariadne@ariadne.space>,
	x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <20251203204519.GA741246@yaz-khff2.amd.com>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114195730.1503879-1-steven@uplinklabs.net>
X-ClientProxiedBy: BN1PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:408:e3::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ea070c-3e5b-4b46-be9e-08de32ace53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/POx3AF7uTsDarBU+qfBtJi0KRw0nKnucKedBWi6deanWetlBPGoh78UOAP?=
 =?us-ascii?Q?wVJieTCgWOt58X20pzH5NqlxWiGYE+eBjctj2g9BNRA25r6dx/6GCo3yjrcD?=
 =?us-ascii?Q?4ChEN04eeNdKNZeSZ+tLQ8sy+nlnjGc6y0eWBkJ6b42xmzkMHBBVjszQFay1?=
 =?us-ascii?Q?9nYcPeQ39GbgUCjaadNb1cX9PdzKo9zeKPtcnqQUZhUbLWCqFK8uIyIZ49zk?=
 =?us-ascii?Q?UXUL3V41vP1TURDvk1ayP6GdgnOyW2y6nd3hzRlsLBldUERRt+BzOvHd/Znh?=
 =?us-ascii?Q?S9m4efz0YMdt4F7kW6UFbHFP94fnT/irik5rB1CdtoW7HjkCZx3LtbRwKakb?=
 =?us-ascii?Q?ln1cZdWMDRkO/uc1aKocRfLqj8YmNsvXzMOhr6d4MA47joguDk+mPPAKU0+z?=
 =?us-ascii?Q?iwB8h1usqa6VXeWlA/1M9wnd8POMrjwMKiSKrtoD8e2hnisUD5xFD4CVPFA3?=
 =?us-ascii?Q?qF6zo2+z4XfoD17IS+lUFbkow85zUH5h6W2xR2mpVIFR1ddeEe9Xur36WDDn?=
 =?us-ascii?Q?lYD50pbQhrgQ04rO1nSVczr27NxfsNi9fKpXGQFjSXLEu16K4zjSlk7fYebL?=
 =?us-ascii?Q?CuFjq09tS84MbFL9Wz/hJFm24mz/hrh8pmOBo/Uu7Im6mUjIvZJVOFUIebXB?=
 =?us-ascii?Q?laKClflcTvzWEAW0ns16xg+2O8W7ZZMNMKlyWY2HjELSYG0MYr+vJAhnmTSC?=
 =?us-ascii?Q?SHAGHYbmIBk9mHEHagAYwdhrSJUl4RsDUWQCQlZPLdJ4RtKaULIeV7LLy/mr?=
 =?us-ascii?Q?dT8swGwpujav5CbDU6WIUIuEob7CWOaWmwJqpb4e3VX6hVoxP1brWs9yvWN/?=
 =?us-ascii?Q?09LANx9wU30RsqnI3uAqoCPh+HFvnccUxR89yqQB5ydy664Je3GvYdH8U2gJ?=
 =?us-ascii?Q?kDzKteJQj3vyYLgjpj+FeRoxVkFcUHnPlVHoK+0K2d7rLLamuojQLZ1M8b1+?=
 =?us-ascii?Q?KPaSnMbzkTTwPtVUDSUMmJ5k+F80E2xtlWVFGG2kySNqa5/x12d2mFnyP1MK?=
 =?us-ascii?Q?wlDkWoBEvqKwC3/0moKm+PPXEwnSngg1z6Suz3GV5yYTUePyf+3m9f6emIxs?=
 =?us-ascii?Q?mi2e79dO5hQrIyF9WURVOoAWtcHdj4Gohuo0VpZLwFP7SPjIar3MW6dK+hhx?=
 =?us-ascii?Q?6wla4NSy/Zd9aWmW+yxEep5IKL8uvwqa8yl6funpOC9S8xt4xuLk97BsRqBf?=
 =?us-ascii?Q?2MiT0qtAyyLSpV/nPDbjUSMWi0NKKHbixtmEOfvOVrd6KE1Vq2ydXPpFPnv+?=
 =?us-ascii?Q?mMS/fNa6lKsmSPBSEUdSoi37YFuEDEH2rnN0TGeKS51KoiTnLNV6mot1IN6d?=
 =?us-ascii?Q?ffbYWT51EXqv5LSDD6FoWge3bS4wYAmpGV337wyG5exLdNs1B/7UR5ApI3Nv?=
 =?us-ascii?Q?IGT4kThJVYttpF4ULBkCN96TSJ2lzcWt9YbJtU3R3g2ZqJv36IBU0uzK/xCZ?=
 =?us-ascii?Q?k+XJ5paxqsHGj9NHuCCLsdbQ6tHWbiJG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?te+xQnbWZeE2pdT8smwkb6TaN7cT/+nP81gpqBqlq/gaipkr56xRYNPXPfW9?=
 =?us-ascii?Q?0By+yLeRVe1qFst9TxNETJcSTIyspgDWiFlEbAAZiItrSWt8YEftYBUiYC/Z?=
 =?us-ascii?Q?vm9NNDP8WQ9mIOOTLAF9FFVbpDOlnfdzet27nZSpjAeV+Kt2KlUgUcIDK08y?=
 =?us-ascii?Q?pEmYqqMPRhW6qFM8rFxgAYkBzARGMuFB6xdMAPdm3WuMnryjIuaMUdwS/ZWq?=
 =?us-ascii?Q?oznJ/Ih9j7r5KUKwVlCnNtSLxf6h08bjCdFferNbJUxBnayy+y+DqBinqu4j?=
 =?us-ascii?Q?JkSMPnXV9S5NsHAM56677fgfw5O84g4QX2B5CJdWmnQ27JcAQNxY+8BOsExv?=
 =?us-ascii?Q?4LYHFxr1BEJ3AGGbStPz82A9LTu9mZUEsV3e8gPCahbznu0SC/XL1HDOliSA?=
 =?us-ascii?Q?B7Nl1sefPHrHFmpT3d9I2dQm1ecAzkdHNTadNFYaK4DR6IEe3R8hLiCd5mb/?=
 =?us-ascii?Q?IDvSTVaD+RIkGbHbRPPpRoeSNbPYVodoQKzthrXgqf1tHC8vjoOt1JtK9XZf?=
 =?us-ascii?Q?SsiZgwPx+9L5DbTNXzbTTkB8UFoxP2eFe/9KxHrTGSAVHJFoE4rHzzY6fzIA?=
 =?us-ascii?Q?63qyl7YRDjedmYMACkfPy1VCGGYA7UVU85ord+jhA4JpLdETF357Lp+4pkVa?=
 =?us-ascii?Q?GFfPLhUrqCzGVFD5OoZenbJXb407DqeHWfy03KN7A2PBHg4lCDJ/VUXiY9A0?=
 =?us-ascii?Q?CCj4lnup9YeWQANUSAi9+fZWHAtTy/gNebOx1O0QUk2RSqNmr58B09heSVAJ?=
 =?us-ascii?Q?ieUbei97DEtcIuSSEH/VZthWrP0EKNgy5Jr11WJJyVwxl885py35Ccgpi9qh?=
 =?us-ascii?Q?qyclUuRWAIw1HMm71irNll96k84AXZPYzDL1Udca89ltyIPLxup/LuAVwvgB?=
 =?us-ascii?Q?xklCrRTL++knEVD9zfKYjLfbpMvXnmuj41X5f4tuNrVoi3ZEY02LAZOIwyIU?=
 =?us-ascii?Q?HPNz+19kkphMcU9JJcwrXV9kcJJgq6z6YrR81TOrYeX+eQk2iH9KkGsvxtnW?=
 =?us-ascii?Q?LB/UrZKM6Vs4WuPuqJfc/AcTg6AUoaO2mGbj6fXFk7msFJFck7rXryXvVuZp?=
 =?us-ascii?Q?Qn469v4w20PMoucZ/Lmvdk15A7xAbzgHBp5BGd+Kk/A6QAAys4AjcWyu36MX?=
 =?us-ascii?Q?+JvO79mN3leAoLBGeeqJxiM0ar5J9Kx/1MTeneqxtMmmCKho0Z5QFmcmymAJ?=
 =?us-ascii?Q?lTDAR9fEvrfB8NBC4rAU8RKnrPKIJwuPqUWTjEzBBJjruYi0CZNYM5AthpYm?=
 =?us-ascii?Q?xrNwW4JQo2W6PXaFQkwoh1F67ACTUTRbT5KVBi9O5buV5zvATTZs5VHnazAY?=
 =?us-ascii?Q?GhqfSpvypBx+646e2d/LOtEW45zYdZzVFIYZ5qnLYBR4Oh6wfTTQOVee3/0L?=
 =?us-ascii?Q?baVnkO3/+w4v6P+lcyYmmoPnlIvEyj3jmoUxTqP2WbByHM0/l8RgxA+Slxdl?=
 =?us-ascii?Q?eQ3AwUcIVtbgAveNk8wRnJRlisupin2bvjn04XCortARqBLYSaPjEHFH05F6?=
 =?us-ascii?Q?fC/sCuisln1ZYieLRJDSNB1PTtHkgJVnyOasZQcPKfAMSMCfH/vT9p6Mxo2R?=
 =?us-ascii?Q?GHCBAxwv82PoqKPzc9rNrROVW9Cz06ym34mQy0oo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ea070c-3e5b-4b46-be9e-08de32ace53d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 20:45:29.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib3Xb+5wxbYvuZPxZrtPs7UqRuIunVuUFM+X7a8ZFtxiCUIuh4SLVBusGJARag7ZR9HurdWObp8Qb32z5zcHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

On Fri, Nov 14, 2025 at 07:57:35PM +0000, Steven Noonan wrote:

Thanks Steven for the patch.

> On a Xen dom0 boot, this feature does not behave, and we end up
> calculating:
> 
>     num_roots = 1
>     num_nodes = 2
>     roots_per_node = 0
> 
> This causes a divide-by-zero in the modulus inside the loop.

Can you please share more details of the system topology?

I think the list of PCI devices is a good start.

> 
> This change adds a couple of guards for invalid states where we might
> get a divide-by-zero.

This statement should be imperative, ex. "Add a couple of guards...".

Also, the commit message should generally be in a passive voice (no
"we"), ex. "...where a divide-by-zero may result."

> 
> Signed-off-by: Steven Noonan <steven@uplinklabs.net>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>

The Signed-off-by lines should be in the order of handling. If you are
sending the patch, then your line should be last. If there are other
contributors, then they should have a Co-developed-by tag in addition to
Signed-off-by.

> CC: Yazen Ghannam <yazen.ghannam@amd.com>
> CC: x86@vger.kernel.org
> CC: stable@vger.kernel.org

There should be a Fixes tag along with "Cc: stable", if possible.

> ---
>  arch/x86/kernel/amd_node.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 3d0a4768d603c..cdc6ba224d4ad 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -282,6 +282,17 @@ static int __init amd_smn_init(void)
>  		return -ENODEV;
>  
>  	num_nodes = amd_num_nodes();
> +
> +	if (!num_nodes)
> +		return -ENODEV;

This is generally a good check. But I think it is unnecessary in this
case, since the minimum value is '1'. The topology init code initializes
the factors used in amd_num_nodes() to '1' before trying to find the
true values from CPUID, etc.

> +
> +	/* Possibly a virtualized environment (e.g. Xen) where we wi

Multi-line comments should start on the next line according to kernel
coding style.

	/*
	 * Comment
	 * Info
	 */

> ll get
> +	 * roots_per_node=0 if the number of roots is fewer than number of
> +	 * nodes
> +	 */
> +	if (num_roots < num_nodes)
> +		return -ENODEV;

I think this is a fair check. But I'd like to understand how the
topology looks in this case.

Thanks,
Yazen

