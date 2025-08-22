Return-Path: <stable+bounces-172479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6BB3216B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A27D642A09
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616427815F;
	Fri, 22 Aug 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPIbbjig"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C011279DAB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883209; cv=fail; b=MD+68S8bm410F4zvFtgGLRDyuG+yJdgkTKZ0YZObElh7v07B6vbi8eTwpyiZlijADnmSRPIaISJ5Tg50CZeNJUhhSaFer3f+iiN296YfJEGw7GfFjyolNaR7UVUTx3DWc2Con4D733+Zy2nIX5nazVWzGzsx9/c0CTNxAmT/iA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883209; c=relaxed/simple;
	bh=CiMl0TIeCuTuK5J6K8PzNG8a1/gLZxK8EKhMXTWpqMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXLQOMze+wWniXczQTQaSeUdm2q3XYtlUpSavo/s2TUa4XJTi+I2S0DYForOiank74thigcN2S7w0X7kvddcckhQBoujNJzpUu0ajWDUDsYu5qPlzCJgK0mBRenpIO7JvFGz3H7DyMizFnJucu0zWm8cGc92SRkUyuPT7dN3c/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPIbbjig; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAmGPpsoGDyeUIhkrUCj98aomSjG30Jsm9pzxUuz3nBl0R6HuRJE1SCDnYbxQ4Rc5hfe6PgVFzNLE87Yi50T6d78uiWRg+c2p3TP5cib4SrcOcxx2FNpkWVHygR54ENz+dI3vyz9gheqccgmdC/5mxf7WltC3UrQtsdVBREh2iUkLAPnV8JhFkSxOPdaGK6TQLSKHJMbKYCbww1u3pQ3V6vU+l0xJ+FnTK30zDRhrAe5ULS+c1WqM+unKmb+wYRxQGYxm+Q9lxoggWkyC9xDYNm9fHWONX/bHrf8se18XJ5zn5y1Nt9OXVh+uSqqSl46YifR0fvxrOKkUa61fIxbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miBNx4N7XIpRp4u7yxX43FHd5YEZ/+3DLJDL4W2E1LM=;
 b=cR39DwLYPIvEichDcncoNWzfF7wRuKfE3diHVr8Qzx3N72NirhS02fFJAaxxgIkU0fFEV2xbZDf50EgsiHrxAAJVo6Vq9UetyUKBSjVFNIVR80b57/1eSb9rPcGZ7x0E1DezzeGqqn5fclH9yfKkidN3Qb36l1dBCXAprBW4Z2qJR0+2nvkrX167XOfXgx+gcL8P9weXyJHKZRWHOWlcrl+X6JpJu7ncLeEDUqWuVLBORBOoc5uyYTNMSsosv1VBVQuIIhtM26ucIRX9s8EauT1SxeJD+fhpVCjFdRCKMReKj7AqZlWg1BgzaaRy/ZUILMzE98ZX4End1cZCJYPe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miBNx4N7XIpRp4u7yxX43FHd5YEZ/+3DLJDL4W2E1LM=;
 b=kPIbbjigUk0tYewVKdh9+lcOaUda7AwQKnNVtrNnaD/efCs5JYIsiCjuv6wf85hEVocSUzBlpMYzCSWJhfp4hmvpxQ0UJf2RcjG9uWIxQakE22N8vgJ7vw8ea658w44yi/lvM8sSD1gEHg+cregy3Zf0lCOTRe//uIwGdkhutFKqpQU5UYcv4Ic+KrYJqdwH3mERRIJvFM+zB4+NLTB7ciAhuJWba1lIPTfblzeTvpK3IKG7Z/E91lLkKj6h9acL/XXMHl2S3CiwWgoml4yGflu5ZS/Uj8C3nyZPnuobaAqhSp2CLwliiTSNcD7Bu2hDL2DURqDx7xP5EljZrA2XJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Fri, 22 Aug 2025 17:20:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 17:20:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Date: Fri, 22 Aug 2025 13:19:59 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2D2DDF7D-E914-4273-836C-F08544D381BB@nvidia.com>
In-Reply-To: <20250822063318.11644-1-richard.weiyang@gmail.com>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:408:142::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: b5064501-1415-4cba-ef9a-08dde1a02165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKBwQjlJmHRV79dQwZ8Lr4iv+u1zkp8acPabeDoxVUOMl3Ibr3+43wCGQxQ5?=
 =?us-ascii?Q?n962VoN8MGGx72uNuvMHPok3pxu2b9VOD4LxfFDFUc9l6qUo4TVrX8IJhjzN?=
 =?us-ascii?Q?XJiZ4lZ24xBX52svQbJxjpoBkQfEp8uiEin3AYiLKFTXxeIt7tSHkRt/GJBU?=
 =?us-ascii?Q?XAqR1NiLOFM5MlblW3NIMC8fyfrQ/385moO8W9Y4VTKspBKQCHsGZdunIMd2?=
 =?us-ascii?Q?nrirWKJv9v2gqgkNNVbEL37fsJRGqMry2Bp+KsU3rjI5+UlPetQ+9iMmTIMe?=
 =?us-ascii?Q?w8uD0y0jux7Idi6IrR6qEDDzsD+iV6/dRNTMe69IwWGBjBKPd+IuYL+KP3Ld?=
 =?us-ascii?Q?35Kx8IOdzp80wAeVXBK1k6jL0+EqEE+Fsq1v6WcnI9ck9nm4+A5KgFmZCyxg?=
 =?us-ascii?Q?uXJ1xhYlXbAv5XnfTv8aflzg8DmwvFGkMj6+/e/n37+VOxkEmYGUNsTk1mGh?=
 =?us-ascii?Q?8+Vyhe6pZnv3XWT0XNuH0JzqKgNL5qWnZXj/i73Muv2YpyHBejJu9kes1grs?=
 =?us-ascii?Q?6aPY2VV0KAFlbKvFD44loPpjDrf2dKOucxHFntnfn9l14SHbOV48iH5g7Vhn?=
 =?us-ascii?Q?+atyNncgKRHk65InLrJoTXMsEPNqlSShhMrc1a0LPE1zR+Bbte4fsV1zqsOk?=
 =?us-ascii?Q?ezzOCic77CoKSixPOwZ6drMqWJKdc6EaeY5p+PL7ThejQ4Ymtx4fQRwCUqNE?=
 =?us-ascii?Q?ZNrlBh5gxOF1CgBNMnoEONwenpcMBeaTPgsgARzwd+lsHeRH4rK1x6CmBaFs?=
 =?us-ascii?Q?UbRGrVEB0euM+1lC3bPhY77OjX6Yt1azc4UYbbePn2jXSrYw8ax0vXi30bBa?=
 =?us-ascii?Q?SdhFdql+8MEix+VHj0z4mNMpFxy32kCdDnkE+0uS9j+KKmv0MprohE1DaiZZ?=
 =?us-ascii?Q?x5pvKiqwPfbFdAISNB0uuA6VeCTwSQCx6AjkY2Vq4BqQqj4ZRFxkeCo/de0A?=
 =?us-ascii?Q?8v83eEXMBh7Wy3Sm3AsRQH9P53r2LGarUPSxDI9hqb9sa9tmwz/c9KRIMtZ5?=
 =?us-ascii?Q?nVl55mNTgzBFALch1XfAe+v8/Vn3HvkTiFEYUHt5yb8rdrh2GTf1gxqqn+Ci?=
 =?us-ascii?Q?OiLiTmICOQmhyn+aVGuhfxPY5TYhM30pY+19CZyugzAgxnmAahyj1WciUDd+?=
 =?us-ascii?Q?QY17S+nQfa9zx9HTZMlHdBXqbZi8d8xb0CmbAWGM7/kJX4ApSv9pl42FqgUm?=
 =?us-ascii?Q?2gGNYn7Vg1NhL4/rzi6pSppe9Gc0SSHv6BgAZJH/z+A6d9yY3sBW/I4px+JA?=
 =?us-ascii?Q?57uPHtJ1vTLCOIM/PyHfvtKnIf7sVfqWDwPe5xHiDV0I4Z2T211v/YWQIsRu?=
 =?us-ascii?Q?M2SS91vwjoaV3T6Ojz46fPTzEeaUUbfudQsLYipk7rfT0NtBwKBvo8GkI063?=
 =?us-ascii?Q?P2i1J4E+WvnBqSGNcO43kjp5T+CRJNRygGErNFXH+czX+bfyQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNrZgDPHsCrMUzOnXKM1HEMZ3oC6g9w7jdntvQggB6SfH5cloD7YYjKCdnf5?=
 =?us-ascii?Q?7jqab10h/yENYfsXrcaddQ1ghAa5eLGAtWlB7TDfGE6YIvTDzLZvc9zJNY32?=
 =?us-ascii?Q?LH/K2bAFv66dU+IMng+VcF0mCQCMamStfIi66RM8Z+8yczcJyEwuCCfR28ue?=
 =?us-ascii?Q?gCwflQ/xcl5Rtia1V0wO28+c8DCVhjtclrnU9dpnkxd02oUURUKmaHWfmDku?=
 =?us-ascii?Q?mv1hZuRYQ575F6FcPmkX9L6W4w4lttexekdd3t9XaJ9T/cFQvTrtEjnkm9H5?=
 =?us-ascii?Q?JidZn11BBWz8iW3xiOcmebdvSnATLbGaWHczu/McvvAzC8ma88rd/ZoMeUqk?=
 =?us-ascii?Q?c+hUbRCYQJfteb3cnD1qOBKedmeXy70HesknY7w83eD1HpMXq0i7/YgxME+H?=
 =?us-ascii?Q?qDA8fRzcGQSk3KNBw9ctC6Ndu1zlBPiZ86HKhph3OaNWxaOJsfE1NsLPwbUa?=
 =?us-ascii?Q?BO4ZEZmvJIPup0vgk2/zq9cVB6tnIU+cd51qQLM1uNzoHanRri5C0RNtTygb?=
 =?us-ascii?Q?5I7Yk68g5JSmLzrx+n2sNGb3L/CXIPCPgB0FiYJLto390X1mFG8E1f1uCYRv?=
 =?us-ascii?Q?imfILWz0Usq5TGBJbx/ylccj9TpPotelrD4byYAsRHOPhowiPaXbKnDJm4F6?=
 =?us-ascii?Q?YndpdkTBNhG7wrLYaOA+ht0py5uOQvEIMT48rCZLiFHZjcSYOA9TcHP7fTqP?=
 =?us-ascii?Q?58i1yCa6VJmkR9a5YJkTQekESmxHSz2pezJpNupwxaEQtKOqKxfhXyMAT4rf?=
 =?us-ascii?Q?VB/bYSQf64eEM5A2bQg3TYJBqpWEaae7OWAJI3EapJV7/o3Ut3Ja9AOQsk9u?=
 =?us-ascii?Q?o4gYSAMgolJcAGzgqfLvPaXvcTNW9lWgwHe3AQxlnb5Hb4Q4cUnDjGIeWsQB?=
 =?us-ascii?Q?8D6aBHyFxQyaSkysoRFT9z/VN5r+c9ZHsp5P9QPFWcOps4FZ7P+C4cHGKdtn?=
 =?us-ascii?Q?1qQMRJzndQpPqMVeIjhpxnG07inWQ2vEzZhLJXbnRj6BsI/SFPmgfwbII7Ja?=
 =?us-ascii?Q?rXXRBBWJRbhoexialqojyZ51rzOsRGlCBoNU8UNSw6TYjBbcsxyz2mudkcyl?=
 =?us-ascii?Q?gSuTd2Ouj133asUUpDuaxRkM/ocY6VxaNDjNyaV7YKCH/v9csIdrtybfSoQr?=
 =?us-ascii?Q?Jjbr25xxuXCH+lekJSgg36QTvBViYPI5fSqw2OyQinFfUjY6xzY+dntlym9b?=
 =?us-ascii?Q?0BDX3z3RXxdQzWVv7VDQyQ9j6kjqnC/Esog34+LD4isaoP9E6kPmTWQH9/Kq?=
 =?us-ascii?Q?rW2qyOB+NkEoycSq9PiV9fhpUdAoZ5J3vC6TQqQ3etUx1mVfxJocvFkdARHe?=
 =?us-ascii?Q?dNwDhD9DNh4ElOzqWeXo3sfWfjBpWi/NcUXs9xx8VZdOL2z82IkR9IfI4XTW?=
 =?us-ascii?Q?3asXIBKKOvryE7/NkjRzSO3LbUvOI1s36UemIPnFVXFJmHpIF8czpsxqWlwZ?=
 =?us-ascii?Q?v7+KYKDGvn8aRARtm+MZ1QaovonzUQYNAhgEH4jM6/oaTjMP+IMMJHRtcTs0?=
 =?us-ascii?Q?oOql3D4H1l7Z/KZQJCM8YzAHqbTU8R1rq6Rfcw24vVobgz+0BpkdHAQ9Ro4c?=
 =?us-ascii?Q?DPOckZL0GDHmAvwedRaMWgn/JH/udnoaoelNgzeC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5064501-1415-4cba-ef9a-08dde1a02165
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 17:20:02.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxT28FGf7GefSE3zY8nFiVQnhtCjSPBOVJwYgfZgNfaKTtQbVL4500vfFolMo/jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

On 22 Aug 2025, at 2:33, Wei Yang wrote:

> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
> mmu_notifier_test_young(), but we should pass the address need to test.
> In xxx_scan_pmd(), the actual iteration address is "_address" not
> "address". We seem to misuse the variable on the very beginning.
>
> Change it to the right one.
>
> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> CC: <stable@vger.kernel.org>
>
> ---
> The original commit 8ee53820edfd is at 2011.
> Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
> extract khugepaged from mm/huge_memory.c") in 2022.
> ---
>  mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 24e18a7f8a93..b000942250d1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		if (cc->is_khugepaged &&
>  		    (pte_young(pteval) || folio_test_young(folio) ||
>  		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
> -								     address)))
> +								     _address)))
>  			referenced++;
>  	}
>  	if (!writable) {
> -- 
> 2.34.1

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

