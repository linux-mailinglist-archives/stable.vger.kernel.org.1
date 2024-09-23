Return-Path: <stable+bounces-76915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1197EE97
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251051F22025
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5419C55E;
	Mon, 23 Sep 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d2YGUQeT"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E779F5;
	Mon, 23 Sep 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106993; cv=fail; b=ZiPNrIkhzL5VCQrvQjxNJRQEShPmTZxQdhGYcneAmTlWYfOjeN1+X0hxRqaiY6h8fKji+orsqTwYz+S5gi/TtiNtdU3pP+iruiK+y2rIYcBBzYpmcKGOJ9Df5LZQumuOrHB0NbkaAazpHJWVz/niIfAWNNkRWFPzSvsXpXETFqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106993; c=relaxed/simple;
	bh=CLuWb5sfSFQNMdEcL/T9ZMvpwPntZQL77ngp/tZzXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovZh2I5SH16tkHweMb4yqzsUX6zqggPkk8KMDVX+dw9xjIOY81ro7uvmY+srz0dm5jPpXetgfqiy7EZ5fC472qW6mpr6xNQ8gSihOQ71IVHJnK7BQX3IZt+sBPqPmXdV9iAPYmc9xE/Vjn3HlhzHk6fXv9bWNWR/ToMUwcw3FRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d2YGUQeT; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEyEYspFe7oF5caUZCZvYT3VoWF28r/otwZCIFLAN+ts0KyBsMPQPLAFS0JpUrOmsmFX1fJSQS2hSeabWJIjRDCfngz7RrcBpcB2bBFCTR93l1IKvdh73vXx710TdSlGzBKr+lM1+IoD3jd1QZUoyojvzrcd18l4Q6SbgCWpK3rcVn5BFdEhfuLp8FnZ2fEYfpQMfxdqS2q4eiH2Qzj5zGBNZU64nIORtif5xf3CbDZDKO8zGAl3HfhzzKlo3All9tsStVaN7EvYaLnT0F27Z4ooV/OPC4wu/mV3GM+B2JUjfAK9/820JdlzNFUnMEIHtbqEVRmCJSoqa+HsZ0wlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBo4zy+4REuPs0wUWnbmD2hpDcKO7pK8GwvAdGoogl4=;
 b=EVUKWN12Ht3I6cr4uopDAkYMAe+QGblG3pWa3nRqf1K/rVEjhiYFSmOHwFH41k+spiLNHeKMscF0syruaKfNwuX51VX+ZDjAFL5uXvuG2KnzUUdeA7PQfcl0cp5q6rIp0ZYKuDxuYkrBYDSzqvI0OwDpzszyyyZuhhx05WTWCx+0i48sEuoteMSCfMnTflDHIXCgpqUnPiVKWUcRW9vJIYxl/V+OGPdO4sOv6E6JkzYy1gP2KDPOEunnwUSQLVF3ApVe7kmJqc9CpsB+nM/NDdA7aKHRKIWexE1Xtw2gCKoZx/vt0HG6buCYeVqC9qB4oA7qr0puXvC87VwVVJVvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBo4zy+4REuPs0wUWnbmD2hpDcKO7pK8GwvAdGoogl4=;
 b=d2YGUQeTFe80lizWG7BSSbos8IBJj4TrsEks6t3rmmyCe95bW9yXPNMSflZSYXRlPeumQnJn/1kdoDfxhY/MT640HMfsTTtrg0QZE8QH0es+WN5/bR367mACBzf+r2+vJDbboc6jZa4i6W6EwPlXSuAxKo8dunOHhR3YCC4v8vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 23 Sep
 2024 15:56:29 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:56:29 +0000
Date: Mon, 23 Sep 2024 10:56:25 -0500
From: John Allen <john.allen@amd.com>
To: bp@alien8.de, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during
 late microcode load
Message-ID: <ZvGPqWckmaEyYBz4@AUSJOHALLEN.amd.com>
References: <20240923154112.26985-1-john.allen@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923154112.26985-1-john.allen@amd.com>
X-ClientProxiedBy: YT4PR01CA0409.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::14) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: bc76d282-86a0-4950-3374-08dcdbe849ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4u2n2BB+giNORA4dm9wN20FuN5hhNCBkFgoTQ5w5F8w9fPH9ZCWn5HYH6Kie?=
 =?us-ascii?Q?pOYhWrQkNEsVShByYCLpcY0/u1WOLJAF3GDW54FDQkScOtosnnZlfFNlYoF5?=
 =?us-ascii?Q?Gljh2o4GjDTIset6e9EWhL3zhH16469zVwUoHI4jM5UwSorzAaZJzICKI0hF?=
 =?us-ascii?Q?okuAqhruO5aFQdYcsrODWeXCZlfhpSj1e2i0NIYPLlq+uUAtw6gC8J4mfRoB?=
 =?us-ascii?Q?mswqovW4yI1EMgP13jM/uMfzVxK6VRDNps4Rv7o0AEiciokieAaifoRBGadA?=
 =?us-ascii?Q?IGlRcBfO7M9CytwWh7Pdn6/A7gtsd54QVUq1Szkjqe3CvHL1d0+yh4OctxNu?=
 =?us-ascii?Q?ocluyW70sC7CdKEOlgMjc53oIeObz61JoKIPWLueSSdEPDw0ZsM4ZZLelupc?=
 =?us-ascii?Q?vqfYu5BBUrxHUlYelx7tk60Af6+9B7UA96hoAz3sxsuG+MG3d+NGiP8RZFGU?=
 =?us-ascii?Q?RTZDoQgD/Qbf0gc4WRRvMx1tGk28DBXkr29dpmTpR+z2/x/kgl6X95l1v0mJ?=
 =?us-ascii?Q?xGE6ZjMe6tOLL9MiEmXY95L7j4l6IexqmS/f8iKJSW8zjOY3032AL0MItQcK?=
 =?us-ascii?Q?tDmOpAouERNdm/yPTRwW2JdbAlJ5CYL95eBXHdlcfZ9Dk9U29l/NZXd3CHHS?=
 =?us-ascii?Q?g7nYWTHNg3w55jse5ATuzkJLsbwTucRA7nnTfWrxpYWOSysbRPfdyNqmxnIC?=
 =?us-ascii?Q?5dc/k2In3bzkhl/jxtNIqVipgYbkDzINToNgC+vyjHeMHj2JVBWFzZBSAtPN?=
 =?us-ascii?Q?k/L0M8zC8nXEAFgWYHgF7PfYV+oQiZhdDdTUA3a2OEs+/xQUcS+0LPVR8si6?=
 =?us-ascii?Q?pASAXPe26NV4JApDKmLt/lv/hgYlOUHqLi6qa42UNKxUNjdt0/pMOcZ4ydQN?=
 =?us-ascii?Q?zM9lAs1alTCvnMZwo7abs/m4YJqEDnAsEQrdAsfxoipZA4ek4j9J6aYR3ut0?=
 =?us-ascii?Q?dcjGwnD1zx67MMe4rfRQuHxsSjqvGhBx+U7iMXvs/Oi6BhPl9ItfoI8eGeLN?=
 =?us-ascii?Q?2R7OnZsvWzwW/H9DPmTTWIbhS0XpNKdWqDPjxgj1QFiVE/zybtVM03gNpdTN?=
 =?us-ascii?Q?U1XUrpxtsZsxGaaTWOBPo6k1WxJkkTCPIt8j5vyufVaRxqA+7bYluKjXUPyD?=
 =?us-ascii?Q?ZxRuS0LJmM3Fb/MyuW1YyWa98e87SID1qir2/1MXGtChXAYrs3m3kr0RsTou?=
 =?us-ascii?Q?XhPwLm4vEl/u1PT97X9dh/nn36fUZunCcU3jCsqM1NHgejYW2rDeFdsJXtu5?=
 =?us-ascii?Q?0K5/I0MIqYaWL+RuqiANkZwzLDA5PdrRvRTiIrhW+bkyGqDjivYe6R0UzvHg?=
 =?us-ascii?Q?+6/VB3pGvq3uAea09q+ZvJeXPtfN7QBb5MaVc/xdjSKL8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPCMZPWtMXvcTCGpCV42aJjSIp6bdvMRETjHfoCUoO3Uc9btH7lKewAvL6Di?=
 =?us-ascii?Q?7Tflr2af6OHH2bYFRGeO4WGxgUHuM3QHj3qACUUcPOO7i257Q/nxvoKzAeiP?=
 =?us-ascii?Q?eMcHRO1tPJ7HvKFvm2di0k79jU7sU97dgbXeRcuWpqU64MP/TcUR9tyW/tNk?=
 =?us-ascii?Q?bpSQlmxGLbd+P0m0eH4MkU5GJHLWS3wWDWb8n1qK71FVzn9iX3r8oKANlA0t?=
 =?us-ascii?Q?qY9uq3kWKwv/SaaFiFMEKh8s8gWerAb736GLL2FVOUgS+nSvXjkfY/guPuKW?=
 =?us-ascii?Q?nAHxsuFuTju+7Jt7xgk014sQ6eqikZkSscESZ4BVl2E3LI7sHqMxFyZQrI1Z?=
 =?us-ascii?Q?tKTN3MGYZSNI9Tdon46D6kysGTQcweHpUh7qoYKVzuXViWgITcx5sZiaqdbD?=
 =?us-ascii?Q?uGo7zPL07/4g2kVYt7aFnHgH16Tel10j5M0IlJ3dmc8HtPSVUAsHBMdOxlje?=
 =?us-ascii?Q?tM+d5CCU6CEe+oFJowhXtnS2J5Xguk3LoGCLNg2ewu0h6M2d+4pZWl7kKjaV?=
 =?us-ascii?Q?dBI4+mtFb96X7tGcF817ownMF/3qY9HNzmHS6AeN3tlwTMZoCi2WAA3CNmUX?=
 =?us-ascii?Q?cJmShoIUGKygxnQmMigCmp+3aMLfJ+DNds3IpQDlUtkVjjhXNqzha7ky7t1e?=
 =?us-ascii?Q?gzdtjL+PWgGPBFKtHeloqVH5+AtVI2fZUHRwxX5gZyJOibnp6+4pzWSYboOC?=
 =?us-ascii?Q?q7hcV73yLmiXncdhDtEUpDOGaxhPDAOuovrrUoQTCkNKjGyCE6xFReNVk5ue?=
 =?us-ascii?Q?zHatUsWOxkrA0pWq+dpCtcoLdlf9V/VWnAIHLev5e1imrJvk3blF6VvB8EbK?=
 =?us-ascii?Q?fbnQjG30vWzam9+/QNQs5MRaABadhfRtNmHa/UZHYqCRWpsVen+2xHS6gdu8?=
 =?us-ascii?Q?uwdvY7LScr2aTZ8sVR2LCRE3SBelVRwWuSJv/4Z02fMj87MMsQjXhOoVPchB?=
 =?us-ascii?Q?pUTvu2TpqBK0eDHvVl8xV4JQJ8xnk5nY7Km/iQtVc+T/25aw325CKh2FHntg?=
 =?us-ascii?Q?yb8l6COlx+f+UGzc7HUyXG3O8Lt1SQ+X/lPrwkuo69TToFXe1KkLYeve/7BW?=
 =?us-ascii?Q?wYa6+ovXsM30wD/fl2A6m4/Qhi7GpR3B/8JSLhqkamo3y0+/It8kzClQyefq?=
 =?us-ascii?Q?wJxt42seccXPTch2w59wBrT4g8OqQPEfCfHabr8tZz6HkAIWy8t0gKkhtMwX?=
 =?us-ascii?Q?kyLYwVa4ZJAA7zJESeo7McnSYRqrK2CkhovFFD7Z7b1NbeTZKRGwAWtZRyPa?=
 =?us-ascii?Q?j6azpVpmO27cXPTSf+XbnTjsNdwx7eGhtpDPQm4uajlJJq8gH9oaslufcWJu?=
 =?us-ascii?Q?2tkodA6QUY1aS2xloTmar4wAXTdDoaY2VEJwIskit4QBFxdownvxx2XUkTcK?=
 =?us-ascii?Q?PL6xhy7mwvIZYJW9dWuFZE3KDvz2KBJFwNxo0p8fHTr1AUYD7UoOfGMyUueg?=
 =?us-ascii?Q?hQmPKuIA0heksTb1K47Zam9J9UpuO8M0bx/rc6MYMCj2x961e/SR+r6aklYq?=
 =?us-ascii?Q?Vi9XeMyjO6VLEpN2eUxT11KInJypvXFaJxpb4MKts6khNUqNn4DntT3p4V33?=
 =?us-ascii?Q?8jExZy0saLziBW9dOUSElU1C5tKi0qKWWDUj6fyf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc76d282-86a0-4950-3374-08dcdbe849ad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:56:29.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WssyO9Q8e8zJusCgMejAORLNxsIMQSkh3ADYF6jgcVss49lakPwV0qtWHT/jVdvmldoXq7vnCT1+9pRF1BIEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

On Mon, Sep 23, 2024 at 03:41:12PM +0000, John Allen wrote:
> A problem was introduced with f69759b ("x86/CPU/AMD: Move Zenbleed check to
> the Zen2 init function") where a bit in the DE_CFG MSR is getting set after
> a microcode late load.
> 
> The problem is that the microcode late load path calls into
> amd_check_microcode and subsequently zen2_zenbleed_check. Since the patch
> removes the cpu_has_amd_erratum check from zen2_zenbleed_check, this will
> cause all non-Zen2 cpus to go through the function and set the bit in the
> DE_CFG MSR.
> 
> Call into the zenbleed fix path on Zen2 cpus only.
> 
> Fixes: f69759be251d ("x86/CPU/AMD: Move Zenbleed check to the Zen2 init function")

Should probably go into stable as well.

Cc: <stable@vger.kernel.org>

> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 015971adadfc..368344e1394b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1202,5 +1202,6 @@ void amd_check_microcode(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return;
>  
> -	on_each_cpu(zenbleed_check_cpu, NULL, 1);
> +	if (boot_cpu_has(X86_FEATURE_ZEN2))
> +		on_each_cpu(zenbleed_check_cpu, NULL, 1);
>  }
> -- 
> 2.34.1
> 

