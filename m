Return-Path: <stable+bounces-165527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF49B16294
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1042356749A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8B2D6417;
	Wed, 30 Jul 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rSXKThE1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j+uQQVlY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CB86347
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885322; cv=fail; b=o9DBIDK+TKtdGHnLDIfbZo6MKFyELBrV0ZZMjNaYUVJeCSMwPFE6QG81H4axPa11TrGepG4uFtrZhBfzbdsktk2+s81cpdl9Sjh/8vGaN+TVMON2flx+K9zoy7kZ1/mLX+497J/b21DO78jncyw66ICxtPeBOc6Ih0M8/Z1hPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885322; c=relaxed/simple;
	bh=+LI9m8aT6sYbZzUS0GQOdAhWnMKf4sV7munWSQnm8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzAko2wOH0zRBV9BZiN/nFzlPxQAM81XP+NS+lSqtp9HBdTFf8+FVjFlOepSN3sR+fqzWOxKuzICg2Zkt/wvW17Mdt9TvfTlXDpei1KmmiY/wnlycAxJzmU+bgDvxz0uM2HdUFxH79NzxMPRp3WwJWBDW8G8jHT5iHc6SCspFKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rSXKThE1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j+uQQVlY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UDMrDQ012110;
	Wed, 30 Jul 2025 14:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5TUJHthvkwYu8EN3Di
	cLjtebf0sVbe0CPM2saHsxwGc=; b=rSXKThE1E404wHbntk6ClTEVF82X2lPtdM
	5zaJIVAg9erqa2uJWgcAYMP07CNOLLI17QK206EKlyVnEwRE5zm01Cgy48nj8xsd
	M6NXM288t0+hNgbmyim+aoJhYdvwCIZbo3qY/TyEZSorzoZ/XQxd2iQBn3MvFdD8
	sRu0e2Mft8Ik1Pp3vl/6Ja8ZJg+/5aEP2vsjml1C4/l8mFbe7yLjjWauIc9Iin/M
	3Sj2Yuc+Jh/xMo6kS9MdCk8keltMszt5eGGT83GNEYiQeNywXQHZOJgdOmWsgQIi
	WAe6Z3TcOlf7Tgaf6u0iNV9OAMmuquPxKcudiOKOE++BVE/Sx8Sg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e27ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 14:21:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UDg8Fc020392;
	Wed, 30 Jul 2025 14:21:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfhjmh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 14:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmkVXgb5n5ULd5tsbISGcWGFAnTws29RpzAjyM7qCw5/+QWYd6gFVrEAJjfeV45eCzGmiEq7dzO4C9UKEn3dPaXPkf+fHlmmbZiCefHFh5TD21liPq4PKoFpT3QCoBWcfzj1KGQ0JtC0cJywPu1SCCv2Jj3A7o3FErVssU7KLjvhIb3Ra1DZJSYL/UCa/+ItriEEbhXPXTZbe/9mRDczRG0bG8Zl+pwxANZ7BCS9/35czltPJY7ojd63sqG68zsjOD6cM5Vqw7u5XNBY1rqpWqFlQVoiAaI7yGkohZ47Wo3BWfdIfwPYps7KiSJvRI2m3rPJ62gtqbb3KTQqPb2H9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TUJHthvkwYu8EN3DicLjtebf0sVbe0CPM2saHsxwGc=;
 b=Bd5LE6iszI8aHRpvif8PAN0xYB508KAyBQXS6fkhlunIMs3B8qnJGW7bYPtdwSFwNjRta3f4Ib9zpedTWElD7ykHn8ETjRV+w0anzpHqLWfzwCoxIfQn3QQ0pp3AY3MKZ4V/iQoO2tZYG0vfz34xtQKKaJwKUbRwmjLHYusE+z5ExX1tW7YIUdf3ENFuL6kIPvr55qqEShGL3NVf3cE0D0eHJ4ARbBhZTyRFcfqf6C0fg703B6b8jM4TeqI8R/WOA38OOkn0vM25EDVevszJtjfcTo8cpT0I9ulS0MpbmXW0T0CrL1uCh2fBPuIvZhi2s80/TdiwHrlWCqEJh68PNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TUJHthvkwYu8EN3DicLjtebf0sVbe0CPM2saHsxwGc=;
 b=j+uQQVlYKBVTRg49uOAqLZW3qgll6tzhuNIHBDi3pmvOqTSOsDL0sxGevysHJEt0S9+Z8el4e5xr13uSJ+i1iPRN65inAWIC+wEgpCUK5qbCo2T6lLetQ8GP4Bb0lWHrJ0xvZX7P9kpGw41zZkgv+VUYhZk51ywbvRMQVZmuDCI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 30 Jul
 2025 14:21:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 14:21:51 +0000
Date: Wed, 30 Jul 2025 15:21:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: gregkh@linuxfoundation.org, aliceryhl@google.com, surenb@google.com,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730015406.32569-1-isaacmanjarres@google.com>
X-ClientProxiedBy: MM0P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d27dbf0-d6d7-45cb-7b05-08ddcf746d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzhVRN5GjtOVjC/kPENdRkIjjXOL6+1rbGWl1crWHqhUrsWwT3uz3ypQyO3y?=
 =?us-ascii?Q?IJ2pX40tjMIXE0ub15gP/V0fGiubJZa3amSbMnknjqP7PC3ZLuFiRl7FPiys?=
 =?us-ascii?Q?GgudnJdhl9n84mtReLepOhbDhnpuWRgi6xNoALRZhixSQSR6H+5qunmpoSf6?=
 =?us-ascii?Q?36QfnkUF1fOAqFSyfQYsuQ8mIc1lt3sQLuretrUv719ta2MkrJw3HGRd15t5?=
 =?us-ascii?Q?sLMxPptkHiglHQowuTOJwbVHtE/0RUL7A6FVNdMJn3EMxCbh5UE4GqCuPrkc?=
 =?us-ascii?Q?J5mI4dMwGU06x8ZrmqpZ9acBdlbZQFQ8WWI0YXxOXcwBLsKt+pND86G3pCGt?=
 =?us-ascii?Q?rmrD/ygqmDWF6laZof3KPilSVowvE9fBJ6cY3zqf8Gf7QcgiyTnXtGuTXTtr?=
 =?us-ascii?Q?G/fsxUc0LCocq1GQ2j7/Y4AaBvH5U47Lyom/7V6DFaIxoH94IYrWgo7EEnqk?=
 =?us-ascii?Q?VBWm3s+/Aasb3jJEWveH7q8Nqvmdh20d8msM+rNixqNeXY9YyujsDR9FDhtf?=
 =?us-ascii?Q?ZIRWu+vsA15LrJQnnXCEOncfbCuTghqI1IJK7Kp5xhznUlYE1lt9sRvGCVgc?=
 =?us-ascii?Q?3w20ZlThO9KF8J8pTBZbTDE4gf7MFRimGWzURmM542EsaveGopXnkrWo6lac?=
 =?us-ascii?Q?u9qT9tfST/Kg6N+aWdPq5+kMaRt0Po50zjhemHJRHRMnGijM+P5SQlN57tPW?=
 =?us-ascii?Q?VwA0Yhibb2qEfV2g6Hht8pISwKy3fQHBqHvrqcGjgqB3KuP7tWzFM9Ypsrq5?=
 =?us-ascii?Q?PVC0Xn4cjiiyw/AouCIz53n/VAzKOH+PQHApRSCYBEuTR01eD+5qIkHk1TqQ?=
 =?us-ascii?Q?hAU3QcslkyXfCbLzjBhWW0Kj78BXJiO6Tgd/Bfi2Kf5Q/CnaMvIywOaz3XYV?=
 =?us-ascii?Q?a8xnF7kQJAAEWXjAIIx6+gfaAaUx09sbKRzvBQN67SaftnoMjXXQQBcwuQMs?=
 =?us-ascii?Q?mGd++ZyUSDAH5OdOT9QSSkRIZsVGBjoKY9cs+U+yWQvSy0bg3WY7oWoxC7j/?=
 =?us-ascii?Q?hK1rp33qvxj8f1mGeWfk1tb397NNlTqudOvrNqUsjCwidNY1jTIbKug6Kt3M?=
 =?us-ascii?Q?IxNkFc32pSOZij1bKF3lEIjDvxqyltPoXDAHQq9tmYUCsaRK+R7MxYSo05ju?=
 =?us-ascii?Q?dTsdtf7BvECESZW1KZWryw7+cMiIrUBEwZCPc3IFtq55BRBkIXJ1xMvBkg4U?=
 =?us-ascii?Q?8m0YbwQ0CL8gjEalVJk+HnKL5LHoRXw/GOTX5XkI+IfekVyXynWAvF1/PYPK?=
 =?us-ascii?Q?WjZef5yGh/egJUXAUJ77AWyw/Vqk7+z7UFt3fzo48bYU2qlell6C52tL4+ok?=
 =?us-ascii?Q?ug2GLjDR9bOLHDlK2Ljksz0wrda8NeonSjqjPhHbSvKUt4eZtL1EfvtVW34i?=
 =?us-ascii?Q?T6/bJEegy3f/GwjEo6r0NeTTEWvK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQud5FXpmJq6Gmxg28wdIEBkjUTvt33UhIxNW4BMOCDA2E9tDmMwDVHKbNtY?=
 =?us-ascii?Q?tKXRLpsLZ+0LQPNc/XNIe+8bAYc1V1eZto48uIVgj11MtuG8Fn6Tja9LSizq?=
 =?us-ascii?Q?EYffg4Kdt/jGFvHrIPw2RwlsIT6chqOz1grPHDOjdpmlWy9lRy/Aamh8I8se?=
 =?us-ascii?Q?f8PPLN0Mr7quHkQAYxgiSfWSQpLbbhhKiC5Up/TIml7EA0WSFLGaquEJFNGX?=
 =?us-ascii?Q?QpRNKx+8oCSI5oR6bKipZIQffWYlN7sKV+P4VwNKgLqqPXSUrTtMbaOn+pqu?=
 =?us-ascii?Q?DTB/NwR3MWygq76pMN1JoHwlADdR4Xia82u0kX8ObpXg3kM1yEIzyohVpSkp?=
 =?us-ascii?Q?4Jphv1w/3xjIRfUnZSHMScRxxvSLlWneyy92ORH3uwOcE52JW4bC6A6GXYEE?=
 =?us-ascii?Q?5x+6aoUJJ1kw7TXFTeE8fBWvoM17BKnMU3TQyvV05lUl4BQqKcKUzfSIWftP?=
 =?us-ascii?Q?7T4op0+kCzBpLSgXKV63kJqR/c1G/gt4vThlqczyWgBIIpyw2l5Jv7ujKc4s?=
 =?us-ascii?Q?rQ9yoCHlCF7rM1SD+zR+4wI25B4f1lO9UoFRADhuFoD8HwlFQsplwtaJ9Vo5?=
 =?us-ascii?Q?508pNJC172X+w9mnwBgo5ZwetpixCtl87JHJBjI957PIBa+KNtK2Tfh2gUPk?=
 =?us-ascii?Q?mOR3i5fDNPATqPo74DuCNHVD0Tjherosv3U+wdBUXkv1dG4/nbCUq6sfJ/kN?=
 =?us-ascii?Q?3JxDzH1WX0fLtiQpgPxpBTLvU6TTJmSPb1qVWeMURh/mqdT1CBW4uVwHOOVT?=
 =?us-ascii?Q?RTWg2vXUnOjWS/S1gBtx1lpY0UqKFxagYbQQK+xQkD7AjkRKD9iNBfv1AbTN?=
 =?us-ascii?Q?i74XFYAEKSP7H+wpdlLTFd6r7fhuTE/LesZp0IiM35IZtCvIJjcB2f5fDyZZ?=
 =?us-ascii?Q?giVHvQXt4KSrEYNJ1mCoqMB20hs6qxJw8YjH/frEtHPUjguv0yu4bqV4UQQq?=
 =?us-ascii?Q?o/2wnZLMqxw80gkLK7MC35LxAimROb2DllM+u0wDAA3YCIdTLQy26JP7qEdX?=
 =?us-ascii?Q?5VOYtlzQ7geVXYbe+AHJ/ih8396IwNepWHivFLxHjAhSOWqBcLfvkEp+H8SL?=
 =?us-ascii?Q?2Sx2FDmIbQo1NiZqcfkqH6Or+3dt8Y073ExLOyQ31/DkKEosHe7K4y2AJzJA?=
 =?us-ascii?Q?bfQsgaqBCqLFlzJOOfoEARgt+coyidilVQP9vY//fMdd0U5dlwUfZn9Wc/js?=
 =?us-ascii?Q?Mjc+FAftzj+G51vgTyrrgbHuvVKsxdD3g3LOA7RxrQy4/VJxANCE7cfj+oDM?=
 =?us-ascii?Q?NWwh1EPyvwKHfDSKong9v88QUa7xlCT0UwoMR2gma8molH+AFjGz8Z1KwZw+?=
 =?us-ascii?Q?gUWFfEroa+ZYYKi9LyiUBceiYnVXMBNuld6zo6/yHux7Ojgb5404A+AhzIDe?=
 =?us-ascii?Q?mt4znZpIR8nW3RfTJvAwHAK/WZ9dBIecpr87RvhRacRymiqzA4hAXziUYd5r?=
 =?us-ascii?Q?y9S+otwHbv/tXVGoPY68HFNNSveWY8Dcf+OnQx1utqYAFoLs6LH64iDMVRm9?=
 =?us-ascii?Q?T+M6qLLBb2XyXQpTlDz0YLSU80107w4FBWr1ywVlZqclgysKuFrxBac62aNS?=
 =?us-ascii?Q?W8i35/t4xSTEtc1FhgKgffQCpN9b9CoXlO545CCf+uk7z2ZjOXFJIliuzLK7?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zaF0aJHFMseLI6lTuislO+VnIZ/RDwREM+5tzHftIGC5gTvxLpUl+sVuZRAPFZOqpgd7TTAjSz4pLACpebVmj2ztn9q2IYyXH6F7trnDDzFMLCuczljYvqdcVwUvb/2IeMT0ePxZWkVdZ1MbO5108JUmvGhrQL49+9fwDIEy8SvIt3Ba9JOR3MPtgAGXdUA5VyvYWgmNixnm0g57SFiFfGSrpFr7cYwrlPC8Sxiwz+h+xTE2huIyHtDTksm7/O/08SFKSF0OdWLg/gr1pDK0dnbwaP68Bv3wGEzBohKdxU1YgmvQcorL/mqBhUTNHRiJzGJpMEx6fCvWjv5N6z/RJYO9oYJNcSb+26U5uZvPoPMZ5wbWBrSVTLOD414EgYuX1zJCXMXrDJv5rp9TgSXlRM6q6hPGmZ2IjE6jQ3ijUC/xx9SXX0RezxuTVOI36gI/GfLP1mRJP/8pD9HLaipj+MtS3Jf7qnXZqejAQlTG4/PE2cn+exTS26bFRmKsNjqasxE/2EwQLaK8IXHwtfC3l5sBV3ELCl/vt+pgerA8ccMBvWXlMC2twyHQNHkqDayDpk65VuYP8Q9h+BbDLRIeKualf+GxM6uAZLlqsDycEfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d27dbf0-d6d7-45cb-7b05-08ddcf746d4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:21:51.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1VdadIzq6jHFNgYHkcsdRHx18spbo+kXhxWTHMxGLKzpmHcGhBek4dZE14IOyzlYMCt2fLWDfdFbRKwTiepjUEPpKRU+lSF9b2fC3SbGBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300103
X-Proofpoint-GUID: 7xAo96DATtdSUL2Z9THvoZQCSHuqblKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEwNCBTYWx0ZWRfX3JAO/iWFc/Iy
 0eRKlPLPcin0SOKsCrIU74Zwy5uuaBW+Qgo+6KPjHmynqQbqtYGWowTxiYd0/A0r7oxiWfQRJxV
 NJ/AV4LA6oRbLa5khTud3LmwyUkhG/6Fu8jLpO5qzSUP3HcFtIHK0qZFetPuPttxN0fRMRUKdnC
 fxcwaRm4pR4ELiMCeAyR68qbDvtH+NBT9Hrz6YXGQFNnxAvsKOH51UmGSy06bmwdUSDgBwrPMpN
 wUT0W/t++pP3O4e/tsE3m6NqWigDlq/WtcmC5JU13lS0O1IEF8BJUs2BpgIf8YU4/qWh94pTYyR
 1PU+MBd/RZP15/3gTpwVnZBjOo4Uh70B+pV6iMgkT4pM4MN6RsOz19dyqEwMQ1Su2W6TBWJwiQ9
 FMEW0tNZirN0SdpAAZ1gGicUfMolIvW/9Vr7MLGvI4/Lsf+O535uCXLWubwgaxfMIOXnpduY
X-Proofpoint-ORIG-GUID: 7xAo96DATtdSUL2Z9THvoZQCSHuqblKs
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688a2a85 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=GcyzOjIWAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=7ZOkIcBEdGmyberj03cA:9 a=CjuIK1q_8ugA:10
 a=VEoQTXh6AjkA:10 a=hQL3dl6oAZ8NdCsdz28n:22 cc=ntf awl=host:12071

Hi Isaac,

Thanks very much for all your hard work on this!

I'll respond to this one, but this is a general comment for all the
backports.

I just wonder if this is what backporting is for - really this is a new
feature, yes the documentation is incorrect, which is why I made the
change, but it's sort of debatable if that's a bug or a new feature.

Having said that, I'm not against you doing this, just wondering about
that.

Also - what kind of testing have you do on these series?

Cheers, Lorenzo

On Tue, Jul 29, 2025 at 06:53:58PM -0700, Isaac J. Manjarres wrote:
> Hello,
>
> Until kernel version 6.7, a write-sealed memfd could not be mapped as
> shared and read-only. This was clearly a bug, and was not inline with
> the description of F_SEAL_WRITE in the man page for fcntl()[1].
>
> Lorenzo's series [2] fixed that issue and was merged in kernel version
> 6.7, but was not backported to older kernels. So, this issue is still
> present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.
>
> This series consists of backports of two of Lorenzo's series [2] and
> [3].
>
> Note: for [2], I dropped the last patch in that series, since it
> wouldn't make sense to apply it due to [4] being part of this tree. In
> lieu of that, I backported [3] to ultimately allow write-sealed memfds
> to be mapped as read-only.
>
> [1] https://man7.org/linux/man-pages/man2/fcntl.2.html
> [2] https://lore.kernel.org/all/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com/T/#m28fbfb0d5727e5693e54a7fb2e0c9ac30e95eca5
> [3] https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
> [4] https://lore.kernel.org/all/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com/T/#u
>
> Lorenzo Stoakes (4):
>   mm: drop the assumption that VM_SHARED always implies writable
>   mm: update memfd seal write check to include F_SEAL_WRITE
>   mm: reinstate ability to map write-sealed memfd mappings read-only
>   selftests/memfd: add test for mapping write-sealed memfd read-only
>
>  fs/hugetlbfs/inode.c                       |  2 +-
>  include/linux/fs.h                         |  4 +-
>  include/linux/memfd.h                      | 14 ++++
>  include/linux/mm.h                         | 80 +++++++++++++++-------
>  kernel/fork.c                              |  2 +-
>  mm/filemap.c                               |  2 +-
>  mm/madvise.c                               |  2 +-
>  mm/memfd.c                                 |  2 +-
>  mm/mmap.c                                  | 10 ++-
>  mm/shmem.c                                 |  2 +-
>  tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++
>  11 files changed, 129 insertions(+), 34 deletions(-)
>
> --
> 2.50.1.552.g942d659e1b-goog
>

