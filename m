Return-Path: <stable+bounces-131820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDEA81300
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400C14A4727
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A3235359;
	Tue,  8 Apr 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIanQ8I0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD66158553;
	Tue,  8 Apr 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131256; cv=fail; b=E7Qe0vdfqkOnuaamiNmUmcf1i2/SV4PjHDyYJT5NEsdLJ6iKrMS5V9flbHGq5mswAzQf525LrnLLCt97qjPKCFbF6I6BJJOYb38S3K8vJHarcjECAbpnaGdDEZsgOymVn2aPryi1K3/ghwOVryLqq3yBr1tUgktdNReMoUZsATs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131256; c=relaxed/simple;
	bh=WjemuMkNhe9Dei5s0pgF+UU2wW1X32JGZwo2YWXmb24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ilf1fWKBitGA0ATvq56f0PEgvGAwvouqafvkI9bgvE495vc7SqcAsSNPPE3pUEWIkDKJwWhYp2VkYc2qm3mh1LfKB8zNCPSKOl5n/lSgwiBNsbd4oKAPIpgfB7OQxXo1WAWdbsz/GTKOpP8aeMuWBD1bnqK9xuGQWcA+XdY3g0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIanQ8I0; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwj/cOAy91TNR81kLi9/jPQrw275fSIRgkAsNsx11cM2cXtDliG5IwJCCX7Z3Oq3WTuYytRCA56j54k2gfuICYCdm1ogHzK19+CC9o7Ghra/bRv35Nh+8zQv5IJAliHS0M2S7VYa7vmZr6SP4+Dh1NQxBnRq768MeFHw5stkn4E7hyekvo1UyFq1wWUB6Qwn2+BGQ4Oz1M6Z2/Qus4eijFX88XhCesphkKuAKNKSTX18RFCuedB09GgSsuarjnaMb6SRCXwKvWVBxnAV1gmrXt5N02aWu/e+8ArOiQYgHGqWWkSw2UMvUfguyMTxaMNzkuGwRvFmLEE2m0HhX1gqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDbae7kVU9rrZTSAPS69ZSrJByCyfGiPhi24q9YnucE=;
 b=cUr/VulRKqS94bLCIb5nL9aRiGmXvRVJDvskknVA82ZSKNRgQJapaQaZJMbp3ctjpMR8b1VfRMbPtM4Fu9DDlcPvFfYd+aSLoQIbhWmsviRDvpCBwinFBdpweOvmwN4sgAzFloenmjg7GPRfHODAskoAIEW2FcsDBrHvme4a2ig5dx0aAxTNngjezWYBH29D1ITyHNPS+NPx3QAuJKGJsAHQh8wDXc58a+vI/sMhBOmVkdIMYYAoKOdgGyUf2N1AvaXTEbnksMLpFE5lAabmSEMpK2LE++kZVhYkUexr2tBuOR4y6Gx0eweVFKOCYL7qWHc5lgZOsT1G/dj74VMoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDbae7kVU9rrZTSAPS69ZSrJByCyfGiPhi24q9YnucE=;
 b=lIanQ8I0xMaa819ZCOCuuqqeT1OK8gS938amEaC62x2Z6uetr4is8SY/qDXsDOd1df9vpPj5hbbTefUaKgTxSo+asjpX0meQu0ZmQWKn5r5kLGXluc+uia8acVCHITlT8O4u2aojUA+6MXggCiPANt2G8FEpnx4rWf133ROW2F8hiIfLrIH9ZZbDbQepbCw+TGS0HhBJ2kn/AQ4YXnSvxsY25YSoRijA6fVir7X/joTANtk5kaXsr3j117e6Tq0Jm9v6i762EcGReUTxG5+JlPMo1nTKwwo/R1i4+RrJ/2aWKqCHHSDCWs335CKFjzZp6ovOBGH5YOzDtZ5QanXEpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 16:54:09 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:54:08 +0000
Date: Tue, 8 Apr 2025 18:53:59 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	stable@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z_VUp2WAx5rUmGRX@gpd3>
References: <20250408-scx-v3-1-159b6c7a680d@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-scx-v3-1-159b6c7a680d@debian.org>
X-ClientProxiedBy: ZR2P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a7ac48-c843-4539-4e05-08dd76bdfaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kUFFFcpWTat5nDSsXAnrM/4ILJbyUukkipenCMl2+kl9jahEAvOPKHi6oI/Z?=
 =?us-ascii?Q?XvV/C+n5GPNcuBwORopCU0e/D1dizoTiRIRzdHZLnfxrxZ6jzZpUdEBgmwx5?=
 =?us-ascii?Q?RC+nsB5Fj6zVbl/mwMXBsR50ugu3PIW4rSe3MG8KpGy2BNRoRGa+qRohfzv/?=
 =?us-ascii?Q?LZECGj384shKAQYZKmouZ9CrRskUUDvub91/fL7G4Kh9bw8/Ktg+txPNtHgT?=
 =?us-ascii?Q?t0R1g41ka7BP64pJCCdgfwi47OD50os5qzLmulgg8kTEr7JhBY+bb8yxphWH?=
 =?us-ascii?Q?BXcD/N+RsLOTijM8lRPqbGk6INKI5i31OulQNRZbatsrn8bda4zXIJBIm3lp?=
 =?us-ascii?Q?EUl2WaF2LZdoPCeo3tbUMLKHVhtPeDQFWb24GjXEc2X36CADcawC3Nce6zer?=
 =?us-ascii?Q?u9Q7hOuX0MkQ74W+CjPbgvrYmps9TvgP+jLS/tU3DTSnIGTioCc2zMVgqA3C?=
 =?us-ascii?Q?4YGV7G0j+wjgLd3+imYoSzCKPz1wgjt1jTDBxxRJjE+jfApegiD8W9RSDgu4?=
 =?us-ascii?Q?KZf3evriXwhDkgDlntWujfFElCQqjjRDlIZadPpCj3o6SHNZrfD1msmTCIKG?=
 =?us-ascii?Q?am/zL4qcaoYhfyVyTuW8SAkk3A45ZFg12zNhkH++/s5k5pmdTeF6xzGfQNG6?=
 =?us-ascii?Q?4sXX9R6Lsfx/eKb2DtSuREKVA/ehhTJnWpvIduG7zHz7E1pvQyQMWWqvigQj?=
 =?us-ascii?Q?cMTck9ScrTiMWqX/O4QgUVswBWPg4uZQrD8qu0GCcDNUbOQ4odgis36yXWGJ?=
 =?us-ascii?Q?6seNLv23vECwZ4VPgl0Dk4cIyKJScQ6mIToevPvnzhqr3vqFbgtnGbmQ9c3S?=
 =?us-ascii?Q?h1WPncNNQmh+7L8gtXhnaM4yOYuXqQUhVjttdzBcjm7nWmLtl3/2CxYvQNVz?=
 =?us-ascii?Q?RCL6oNf657xWjyRw1FHZHF5peWgcICGZK/hSCkt2s6Pp0rUm10ltFyip6MEe?=
 =?us-ascii?Q?4BmTxZYuN2nzXCP+jr6UxOAxRp4EUbxh2APNj7lYb/xRptbYildG2/dz+Mwp?=
 =?us-ascii?Q?yNCgDoTqf9Iq5T+lm2+Z24+47MB5bJnPvRUZn64V39qFqRImAYuYNiEMabjb?=
 =?us-ascii?Q?kbNzGpSqg1wFPTQ5H/gKCrjYXHggz3wMGATZ7+mfiLc8yQMyyPJRfESp4PNY?=
 =?us-ascii?Q?22xRXAto1AJxEc6kIUXH0XmP0rV3GjR/zOB3n8E+tWvasNIWAX5Okj37pZgr?=
 =?us-ascii?Q?1slYOYHrpPPCM8O1FqG9lYe26Ksj/WIm8QKXfTko33Q3c8X44UEekq90RDtI?=
 =?us-ascii?Q?jMTvS82Gs89LRYc8jTBMeUTJedEvAXejjbgyKq36S2sQMq3RkJF25GvHcGPw?=
 =?us-ascii?Q?4Cisc43rJ16M3VVhUgPnt8k9DpHsgpNlolZjLs4f/bGbjf4eyWG9uHe4hShW?=
 =?us-ascii?Q?spqu3g7z/CMqXuRTkaeLThnJmcyEhfiUDd9FZ3o4FyCNcawxpYhIXM9F2dxU?=
 =?us-ascii?Q?ZZygmtPB/FM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UEWeyhAA22ILX4rgSZWP/oCUIZjE1yBJ5IJszANAYUzS88zh58vb/7ajscbP?=
 =?us-ascii?Q?2k8zvt6Nig3J29m+Xe5fFrnny0hm9D/Empo1jocb9YeNETzXUvkBjE9XKXGr?=
 =?us-ascii?Q?/AFUHcsHNQ0tt1nOT8tiaAPcDhJKo9dGL8b0/3vGjhPDGaoRzNdYHQy3xKc4?=
 =?us-ascii?Q?Z8/6XpkNR5w0bimv113ZjnCmnPg8n+T5p0v61JE/go/0rF3wLctNbsusJrkR?=
 =?us-ascii?Q?c5MFIO++MR2tB3G/NuS18U2R2+xxeN1diUhapqxu/CYxa/iIIDhBxK4Yz7um?=
 =?us-ascii?Q?FjUmelBV5GUVEHF6uxqmo5M5e9at1cDPcUazO5BZNqJt/niVwZQfEDPxdign?=
 =?us-ascii?Q?EsHn1YfbP6ZLyV3eO61H8pDKHoeawhhf0ZuP0OQVmwJRfbOHtdfPY6kEBjjY?=
 =?us-ascii?Q?6qP7RVtJExxg6DHwI1xdntXt/zajtF68xRUDvwzH6nSdKbekJ3hE1ZGNR3aD?=
 =?us-ascii?Q?/MC3pnLP+O3w+sxycMGw0c+8ufQ/YalnsCbfXs4WTVman+Iapd2zMARi0Cy0?=
 =?us-ascii?Q?sjpPmPU22aNHs3wcgMQtjweZUeAWx1qxvpeiKYy8nS+se6mT33I4HxeWYIQl?=
 =?us-ascii?Q?Vt89NRT2g/Va/W5aywLpFhhqh2z4NWPCnbV6Yo7e2ov3u+Z5vjMqfr3iFyU1?=
 =?us-ascii?Q?JgT4t9hJEyZcAqN90O7wMWDnCuZb2Y+vMPQjmkVU+zezZRp3sIRIh/YdJQs/?=
 =?us-ascii?Q?ouwNrOzrEKya/jO3LKS21cF61zW1eiZkN/W9X1bvG+OvYt7qj53+cSFbtXA2?=
 =?us-ascii?Q?ETvljZw5W9sf3fj+5NDLABFJuOO/uwY//cHg/E6dNlZ15J9KJ7JCY54kuvoQ?=
 =?us-ascii?Q?7kIuB67K5EQl5g36kagSLIYInWPsGqVzNmgwc5XwuBnJox7dTRvMV0+U000v?=
 =?us-ascii?Q?NLgeUco0VU7lxXNucNSG7dZZ30LhE0XE6u3QKP+k8jY8iMe+Lx0Yqmli8+aW?=
 =?us-ascii?Q?M4/xpt50S8bI4HZbNs6is/0QrZpfqEMr5D23RFa2i0IZiqB/ZLZSapSDpanO?=
 =?us-ascii?Q?/K5tDV+sXIZBF0mA3x8/imQOd/7+kCAfquDWFmLqggEW6MyKugw2DnunVXVX?=
 =?us-ascii?Q?xIWsaPyWE/XWt8HN3gYVjcxGLTr19rz1pAOiBfQ4E6079AdO4l6I6+HTctgO?=
 =?us-ascii?Q?eCb+7cldBwG+uhh5XaqgMC48YyCP9rV4aov4Bd/0pTpwpzN5/JZig20tbyUr?=
 =?us-ascii?Q?nlSm6LlwXQ3khikjLddCB20jGzGii8QpAu4f2kv63/L81XQlwj52ZG+3HL9g?=
 =?us-ascii?Q?6d9BrHXHOhj5VN+2kbRmCBVdkwL/zZvrVssKv8DckXJbXbjxEZNJCJb4Y4pf?=
 =?us-ascii?Q?VIRBBUfxL2vzY8tbedd7lshdbfwQ7kM3CpE+9q/TtVOlxOCoZdGMaBPyGL+N?=
 =?us-ascii?Q?Cags46vEPP72ySvT5K2CRxoZ7a785zwFTdsXHIhAPTNxaGt5zsY5ZH0NiXP2?=
 =?us-ascii?Q?rgULyP0JdpIKjjCZApzT6zdE4jg2kFuweoth8XjqxRs00+rkKoiohgfom4d7?=
 =?us-ascii?Q?BamRLM1NSQFm1ziulhB8sfcIQlA4OWxPq/KcxsOpr/GulmChhpXKDrJaHskL?=
 =?us-ascii?Q?kf3phFAlW62WmwowiCgUpWLo7F9R9qrnYsrd1rji?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a7ac48-c843-4539-4e05-08dd76bdfaf2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:54:08.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCLww3GCtTNKzvAZc8ppowdB+2/8RFKSmCqc99Lz7hzUl8z7HJFyLIPW/MMFT/ax+yRC0C9bVPo0dy2Rx9Cc/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

On Tue, Apr 08, 2025 at 09:50:42AM -0700, Breno Leitao wrote:
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory depending on the implementation.
> This change prevents allocation failures by allowing the system to fall
> back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.

Thanks for updating the description. LGTM!

-Andrea

> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Andrea Righi <arighi@nvidia.com>
> ---
> Changes in v3:
> - Rewording the patch message
> - Link to v2: https://lore.kernel.org/r/20250408-scx-v2-1-1979fc040903@debian.org
> 
> Changes in v2:
> - Use kvfree() on the free path as well.
> - Link to v1: https://lore.kernel.org/r/20250407-scx-v1-1-774ba74a2c17@debian.org
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca1..db9af6a3c04fd 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4623,7 +4623,7 @@ static void scx_ops_bypass(bool bypass)
>  
>  static void free_exit_info(struct scx_exit_info *ei)
>  {
> -	kfree(ei->dump);
> +	kvfree(ei->dump);
>  	kfree(ei->msg);
>  	kfree(ei->bt);
>  	kfree(ei);
> @@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
>  
>  	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
>  	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
> -	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
> +	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
>  
>  	if (!ei->bt || !ei->msg || !ei->dump) {
>  		free_exit_info(ei);
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-scx-11dbf94803c3
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 

