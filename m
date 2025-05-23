Return-Path: <stable+bounces-146183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD5AC1FC4
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904BB1BC67AB
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388B7222582;
	Fri, 23 May 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gIf0guRx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H91dvBPY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534820FA84;
	Fri, 23 May 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992725; cv=fail; b=cdWXu6v6ye7oKF3PgW6nbcxyKrBxWnCE83++q/PzTjXQG1256IV71/lfLbQmGBuV7/Mlr+LGSk8RIuxiOjqsTTtJ3mSAVco7Dx3YwVCv2qmvItV1z8s3ecCgeAL42M8Jc3/GmNrFRXck4AxIqtptD+9aICEiyLlwYzA2sN43kuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992725; c=relaxed/simple;
	bh=tJtVNqzOSjNUzFWiwkU48+qvaPZCz+gjXEnJJVGtdqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mxk/hbXonLlgFaqNdLr1KXd3td2O6Lc1aznpGP1nX+Si2wTLwaCIUEuC0JbiFPIv+ce/P3uQ8TnoDzdjiz1tNXWKT+GE6Akoo4v4I1Uc/qwP6xKpDkHfBPmSowjhMpDaIz9WsB7wx0fQtOq7hptZDdSJFWpPJTKu8nacmSovbLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gIf0guRx; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H91dvBPY reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9Sh9u011907;
	Fri, 23 May 2025 09:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uRBaBREIwZ/MA8wQ5JWFY0XVLGGSvyVMwKO3tMic1yY=; b=
	gIf0guRxb6v0GiCaI2FKXX6wHkTwPaPWlt1jaCd2a8tcVwkH+JusafeWmL/6eKXt
	bNQE/FUxBG0VwPOGiFQFCxnsDuqgVw+2FeusqKIb9Ub2IlMY8kPQnkpk+la9oFJj
	e00eWftEL0mC+mNaJQMxe0PxEY6Lx0BwucKmYslpr0ckjzDsaRTpq2O1i4iK+f+M
	Rb/AT1b4oCucJmne00hIezXYP01ut60xnjGNJ6UslWrqbcXqLbVU9I2uuMJl2J9t
	jAxsJYidADfgXxQofT98274Lf0UEluo3lwe0DvyIxjVOk29mTeq/r0VghukGmag7
	feMxsPx6Oh9H2QDS3IxCuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tpdx0053-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 09:31:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54N8jKWG011351;
	Fri, 23 May 2025 09:31:30 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweqg9mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 09:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec1TH2jC1Bk5RYRXb/AmD4mqvq0zfZTwjhHoE2hteRRplWTyoA+ocMFILa6rJzp0oReEIyENL/FeQ8d2HUsFrvleEb6D+79DSE+Fc4Doigse7bvLoBIYM/KOfH2jhodOtZ9KkV87lF60soWJoiTV0f/rBckZ4HxAgv8azeZVOOm0u7R3xvJyDh7JqOWZp1o7b0U13JCA3kVza9Bvinxs/JbX7P5aXcrgF+9KQkRud8SY8QhR5EkEU2puIGE55IHcrwHeinkEEe+zyocuycJrOM/BTZ5Yj6RfDgNuLFw1R0clyNyN96v7Y3m4dBqd3TKy99qSn7dDzivQmu87MUdLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWx8Wp4hrhZIKEnbrxrdNIPRI0CrG7ryBm1sOcan9vg=;
 b=CZPykOKpPL3QdxqMocDloCbNh9oaWHLqDCaA/Ib6udXbnk+XwObywjSgj4m4VCgyM6O7SbjIx3+Y2u2l5VUcz1Oy8NCrZO9Mho3aFnVFhp3m11MVy0Af5qbHQpdEby6O08InAMLKWvYqBjNoFjsbkVINYB6Huc+p65GGDyNBl9zrBX6yiEIYglWLux6lX50Ok6C/04XWo/Cr74Q3N3hzehyQRbjTbThVZYdF6Q0d4ndk6myv6saftFpJBi4CNM+VD3jwgBbAs0cWXFGB3SyLlPb/cf1zqll+5MR3tUsTVg8gXT1DtXT+7mjYufM8hWM8IfTdpz3UbZsGffHLlR6hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWx8Wp4hrhZIKEnbrxrdNIPRI0CrG7ryBm1sOcan9vg=;
 b=H91dvBPYoveTVU2shJrsKWo/13oL3K25fB68VO83tNpaV14GJyNB5tSnRqH19tIzMsMF+ez69nxJpMPaU7EIOWhW8o72bW0PHe5TkgWTdt4lD8jpizbX6x8cMUg98VHAPzYtcwOfYB5kK5eSv+Kh70LGyNYj4rvd5PgOtxXKWAc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6657.namprd10.prod.outlook.com (2603:10b6:930:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 09:31:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 09:31:27 +0000
Date: Fri, 23 May 2025 10:31:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, revest@google.com,
        kernel-dev@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Message-ID: <0cd43180-e7a9-4f2b-8cd1-4b58e8acc93d@lucifer.local>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
 <aDA3wBqriEEp_kWT@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDA3wBqriEEp_kWT@localhost.localdomain>
X-ClientProxiedBy: LO4P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 45839329-4a97-4c07-6a24-08dd99dc9791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?e0qB3tXaRRqAjsjROWtFJSpIjKyYnIEkpsTR4hOSyVJ+oyffUN7PzyjT1t?=
 =?iso-8859-1?Q?FbamHd0bVz89eQ3fR9hU0Ojd1EMycXsz+p2mQLUKeafLJ24/AIJoPb/Ged?=
 =?iso-8859-1?Q?s0ETRDEkLG3Gx5QVYBswcWfS5bbCI5tVE2jcXYWHj8Ei82VRFsV9Z23AcO?=
 =?iso-8859-1?Q?BbYHf5WfP1yyANQ8ErhIPZUxCg9cVwPnOW8WsH31jrGSbkUGsIE605BHnh?=
 =?iso-8859-1?Q?9j3Qb0dOHuNRRAMKyplq42qazlLvgec1Q73+hHXt2qKqAOD5eIK+h1IhDX?=
 =?iso-8859-1?Q?I/Cj6YuVKXctxpW0u218S1Pzxq3eKf/s4clVklR8z8pIxqx7TJq5gUoi+3?=
 =?iso-8859-1?Q?BnfVK55GN2WSxlEvhhpHOeycajwwFc61rDavr45Hi84C9LHqmOaYNJnlXK?=
 =?iso-8859-1?Q?IdQ6dWf+H+EQHvtx5qt7/fUUmpAJPhSFgkqIhknUivZAZmZWeqdKP1tAB3?=
 =?iso-8859-1?Q?k+jvorJ/hZqkBn2GY5cxzYAdzhvcJjrygPxTnEL1XHVK9VPCMPFk2XnS9r?=
 =?iso-8859-1?Q?IbsnWZNVl5vDTfFlsFFbCbS9Y8hNTjgtin4d/gGww1aBnlzbaOV97Q3i3c?=
 =?iso-8859-1?Q?3YUVDaVCtH+Ij7GTCTNGRgRySWpdF6+z32jxBIvBFkF8J9Rnha20kTdFSq?=
 =?iso-8859-1?Q?uXLtA8MGrBgprHGeN9N/IZM5GMHgG/WQvsP7D1+4iCa2IQA+VxUBckhSef?=
 =?iso-8859-1?Q?BUl0MxPe8aIzXU595YlOaWhg8BrNC0VrA2DghJZJgYLItgxlUu+dvoq1Be?=
 =?iso-8859-1?Q?PnVlpnWPp/U1pQshQCWD0C+5AoUgiydNXkaEEscCpTFgeycs9jt5zR9x6r?=
 =?iso-8859-1?Q?oOuY5nEOtgE2I3NL6i2Qlp1A8AHnVPWLEEfw0UM6DcrnNmActTrK36Yxyv?=
 =?iso-8859-1?Q?fWWOrB4ynpYf40PNRQe7Ylc3x5JCToePQ5J+xk7lOWZkAlGwHKn2B66aKY?=
 =?iso-8859-1?Q?vI9H5Ih/Br9CVoCaMmWHI2nvqX1V2FkFSQz26NW3pidXVKq/RC9vgsEeMH?=
 =?iso-8859-1?Q?KMT4fKPZqnRD32FfOf9nFaN/0n3n1ACp3AjaeV1GaVvIIDnwYET4wLzpUA?=
 =?iso-8859-1?Q?ntFW+pm5qN3OqTRKlWno+XQsH7Goo6E9I2zOZVJKhtXU1eKXLff2GbTJ87?=
 =?iso-8859-1?Q?yGeyl2+W4/66ynvJR0n9b/iVPCzsLVM7p2/P4Q2T3MkdGSNJLh/jba+p/x?=
 =?iso-8859-1?Q?QmQMKHURZj5M81gFEVQJ2909dH16PNQrnlTzckXIWnxEgOfnvNsvNQrwPk?=
 =?iso-8859-1?Q?pE0qWem1m4Ub8Jixe+SadAV7i1mug7/wvt9ognOX8Cb9bKzB/Yxe0wviJF?=
 =?iso-8859-1?Q?YCCkcjqmoBI2Eu6YJ+Nxac9M5sVfaAQs2mEI3Mzbz0FqiGxihfahMHHdYr?=
 =?iso-8859-1?Q?7TczJdMSau3SXpJKQmW7ZbJJCdmgR23UP1oPjdwcF5Tk1yd7r8QlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?FQDnqUDsjv6thvbQSOdUPuWN0PjK/ue90N8Ootvs2deFQ27WFKnVKo43Lg?=
 =?iso-8859-1?Q?EbF0Avo7hB0cEUvP2BOfLRGAGmVwbLvQjqxYnFRGVG57+V3ui+xIqV5js+?=
 =?iso-8859-1?Q?6x0N2gVvIPZO4xpFdUmJ8l7k4iKQ9wlkQ83JdzVxNfaNVibN59OoeUY0dg?=
 =?iso-8859-1?Q?fC8sxjtRcg/UOi7OqDsucNOFEsrvgkCZsC/oAnkr6oLGHYAF5h3gcmj8JM?=
 =?iso-8859-1?Q?fy3oXd0sSyjh4ObfYACkaJAXOM9vUh7mZ66sbHp3RghGAz8VHmiacMS9Q8?=
 =?iso-8859-1?Q?CnLakhBUQHGGKr6/jblzMk9wjxsWsvF3aO+B356l4tl2ljLgzZWdQ/rKju?=
 =?iso-8859-1?Q?HWrl14B1tsw8vmps1GaPcVaI0Y56nyBO0n212y0rO8+FmuaybKmGlYKbzz?=
 =?iso-8859-1?Q?MgN6aFp9+BGi2EeHxAlT5gsJyd9dfFSf6yH6F2GQ8z1OVVYweCsRhuYQ6A?=
 =?iso-8859-1?Q?4S+NzhlpDBlBOegg5Oak0C4EQg8H0NLvaDHQn8zgs97vRpd4AsEfAL9vah?=
 =?iso-8859-1?Q?+Q2w8pIKo6mYEkhMjDRzCJUTp6pDfvi++GfNhmbMsY7H2kVlLpqvfwfyOD?=
 =?iso-8859-1?Q?s94uTX5VOGTnP04voDmkD+69HXzcSQhSka/lVk/DXRPJNHdcXJH+iB0UF2?=
 =?iso-8859-1?Q?H2yxXUEuMGuLc0nbQW/Aelq3LqkXVAZAFOYwyyChHgA43d+UuZY/TXTd6F?=
 =?iso-8859-1?Q?CFjn+WGIUvgO605rFl2hlAiIQnFFDo5RLtDUaBCleASnOZcpGVy8pcKQYF?=
 =?iso-8859-1?Q?TN0bGW0fUn1gRmZrbpg766TR7v3rtBnXUYbBH/gj34mbzFIxJO2MuQBpF+?=
 =?iso-8859-1?Q?3DI1lteWtTF7j9jVVq/8BFY9tuDyZbdEa8Px0XFON9F7Mp4lBOHwTrzkyt?=
 =?iso-8859-1?Q?s+Nlg46T2tFbdw4s0isbuJFZnnpWMnhD33SDvS0MNP38cJ+DfSTB3ynb1u?=
 =?iso-8859-1?Q?iX1Mr9DplqNRNeTMVl/+nrh5RgPQpp1xc0P/nRH1d6KMK8TzCMLndKWwBg?=
 =?iso-8859-1?Q?CGxuTnlYzasvPqQ4jo447w1AH3DJSPB3jmASphZfYOyCGvd8dNjot955DC?=
 =?iso-8859-1?Q?3n1RgIbf5u9Mt6zt2hnwNtHdJHFXMsI2S/nfxXsyM9iQuZxLvAhpm/fTA0?=
 =?iso-8859-1?Q?0BKh2Uo+JLq+pTT2aHXrF5NoZx5PKx/Dy+Vjl2X1nucR8fHII1rQDmHnwu?=
 =?iso-8859-1?Q?j2iTvJPm+CS8t0fqGznUw9V37I3gxT9QsZ3cQf/AdDWTSfEiPLWZrpyqnp?=
 =?iso-8859-1?Q?IAl/grPD+ro/I4rlscHVX8Cn7zHYgTjuu+U/amwMIZJlnLK3Nurz5Rh6LZ?=
 =?iso-8859-1?Q?bPYP+m+YaEN4IPvrC4DcQPtxqf+pPDdPM6YvPlLfg5q0imL7o7zNqwOb0l?=
 =?iso-8859-1?Q?XPolOO3gmXE6sDVGolx/BM3No4KqO/Oz//Xk8jObeA7fDJCECyuLCrveUK?=
 =?iso-8859-1?Q?17cb1pb1YEPm1cx0j/r65skDdqjMp+HVJ3VBaLPHLjPHjMX0QjTSo9l5uR?=
 =?iso-8859-1?Q?hT5hKCzxbQHP96awdUNj+8MLPObjXTUhEyN9fnAf42EUnA2HLhVbn5FoN5?=
 =?iso-8859-1?Q?ShcoUAGG9CD395CCBl3PjJdTNS2ZzgPHmPmRUMJPJAvUXScqTFhQ7PwvG7?=
 =?iso-8859-1?Q?RIFSfjPu0/vEf5PRNUU2myzZ5GMI78GgDB2bMo45rsVYK2jW5Mxnau7Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8CHRT1V7mLt6xiw9TcVEIXGglCiZhJ2bBQ1kqCVBpL3jFAX7p8a5+ZRh5Fx33stLt9fHkoDPMZj3a8OxS7yk9b+IvLgzQMB4H5lVAzmm4tm+6zJB28NTLA1Z1uToq1q1rUlysWzP/rri3eWgpAZyBkqLqSqXamP65CE4ya2A/0cV1SmMPqTLfaZNnKa8sjSBXLn7DiF5DiyeRcS/n4MUNqH6/Rqls+po9P2mdJSpt/KgC7fwX4G4TdzQsffUTFmZNnkb/y71UKaBVtUIiP6LQZU0gftXU9EFfM0zXiBq2HLoLpO3RrRc3poldQKaBzkJSFx3FIrnr05w/riuMuxl2V4cPIT2/XIG6SZ6LahELQxLu/xdDuwcpgsS9VADhTauhZGX9lwounXCfYU0tnPccrzOxuRgGg9J77eVYGc6IQ+P/ixhWEr+u4eXYTssM8v5ixBez5UldS2Ac0y4xScOOskkWPDebUG2jJ//C2QH06DyJ0Se4j6s4YVWzR2kDup0084Z3BH/uo81ERZ0pB4V+oLubAXFWEgt16sIP7Np0vtmK1sciKOChXwEd2ZRH9673Sf3V/cX8rDBIIheisAXfWi7oc1lGhpHDKLlQ0/gqGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45839329-4a97-4c07-6a24-08dd99dc9791
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 09:31:27.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHE5LHUMYfMd2X6QEbrAyCCkBjDUchLBh8yxaC4DBg8GCoQdWB41UeCqEf2tOvdHrp9jWdm7Xbn5tgkaovZ+zQbK2IleZUPUUjovTA8R0yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA4MyBTYWx0ZWRfX81IXiFQ1yaeU DjIt9mVkrDfEx1ssOz/gt/1+dlhqYP6Trb//GqRJXjWmmPC3JrmrXIcPsx2FITPrDmDor3m8P5W d5Xyqh88M9K8dTBzLAqxRVHYip/kxUsRt7qu7cNTskG/QsvdhdprmyHl4mlDgcrFOedJrZd9nHB
 tN8uTwvSq6NgpDgnMANBcTyVWbhHhV04s0fBhxgr3ffPW5Ep48T3p2sRH6TSHIcHzYl08mpeSRt YpTpBvqc7uwG291SNanMkSYnb97z3VeFIWLBpqhXJ9XOH0lMk0TMd6Uz0wa5UPHrXELFIUXtW5Z Crzj7mUYGPWZk+NXGmyBVnT2TOW4c8H7jc7VyWM94k1dH4NeO+QP829B0kcOeP50bFKcXzJzoy5
 4qcZlrCk0nYiF9z/riCLV4SDt3wHT9FMNEw/J7zBo7gVlMH9Nvbra96aU0tOvF5DVeaj5NUJ
X-Authority-Analysis: v=2.4 cv=f4RIBPyM c=1 sm=1 tr=0 ts=68304073 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=V2sgnzSHAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=matUwKGk54S7C4_kW-oA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Z31ocT7rh6aUJxSkT1EX:22 cc=ntf awl=host:14714
X-Proofpoint-GUID: BDLNWaw48hTti6ie4_GA3sW7Axv3JNBx
X-Proofpoint-ORIG-GUID: BDLNWaw48hTti6ie4_GA3sW7Axv3JNBx

On Fri, May 23, 2025 at 10:54:24AM +0200, Oscar Salvador wrote:
> On Fri, May 23, 2025 at 09:56:18AM +0200, Ricardo Cañuelo Navarro wrote:
> > If, during a mremap() operation for a hugetlb-backed memory mapping,
> > copy_vma() fails after the source vma has been duplicated and
> > opened (ie. vma_link() fails), the error is handled by closing the new
> > vma. This updates the hugetlbfs reservation counter of the reservation
> > map which at this point is referenced by both the source vma and the new
> > copy. As a result, once the new vma has been freed and copy_vma()
> > returns, the reservation counter for the source vma will be incorrect.
> >
> > This patch addresses this corner case by clearing the hugetlb private
> > page reservation reference for the new vma and decrementing the
> > reference before closing the vma, so that vma_close() won't update the
> > reservation counter.
> >
> > The issue was reported by a private syzbot instance, see the error
> > report log [1] and reproducer [2]. Possible duplicate of public syzbot
> > report [3].
> >
> > Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> > Cc: stable@vger.kernel.org # 6.12+
> > Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel.txt [1]
> > Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [2]
> > Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [3]
> > ---
> >  mm/vma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 839d12f02c885d3338d8d233583eb302d82bb80b..9d9f699ace977c9c869e5da5f88f12be183adcfb 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1834,6 +1834,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	return new_vma;
> >
> >  out_vma_link:
> > +	if (is_vm_hugetlb_page(new_vma))
> > +		clear_vma_resv_huge_pages(new_vma);
> >  	vma_close(new_vma);
> >
> >  	if (new_vma->vm_file)
>
> Sigh, I do not think Lorenzo will be happy about having yet another
> hugetlb check around vma code :-).

NAAAA... nah only joking ;)

But you do know me well sir, and indeed I hate doing this here.

> Maybe this is good as is as a quick fix, but we really need to
> re-assest this situation

Yes. We really need to find a way to avoid arbitrarily putting in branches like:

if ([hugetlb/uffd/dax/blah blah])
	some_seemingly_random_thing_that_is_an_implementation_detail();

> .
> I will have a look once I managed to finish a couple of other things.

Thanks.

>
>
>
> --
> Oscar Salvador
> SUSE Labs

Let me have a look at this fix-wise as obviously that's a priority here and we
might need to live with some ugliness for that reason.

But I want to make sure this is correct (I mean it kind of rings true).

Can you confirm at least on the theoretical side this makes sense? I was
actually going to cc you if you weren't already (hadn't checked yet :)

Cheers, Lorenzo

