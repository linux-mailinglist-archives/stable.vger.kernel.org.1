Return-Path: <stable+bounces-121435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15115A5700B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F6188F96E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FBD23ED6E;
	Fri,  7 Mar 2025 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmH7/XN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0KcdVj4x"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2821D3D6;
	Fri,  7 Mar 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370712; cv=fail; b=tIoYeK2BozzF+BOTMZ+vEHUcfg1f5kWlKkVTKkkuVmHuR3Fcp4u1K8OqNjs9iJSG2zvN/c/sTaf3hzJtyllRHhYnSh3o4yBr4Yeuq508SZk1yju3PyeerRAwRcBGv+O3Rv3xuhexq4xS0smG8hBxdisn7Vm12MzCGSM6WiOCpj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370712; c=relaxed/simple;
	bh=KNBR65dLx2bf4309kJWGDBCDVZOk/QL4EsWp1DQmC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gmU9Q1Kntu3QbSjc/FurNHt2URxJOgFN2XV3LnJ02R0NBOi7uLWvAzXwbLen/UgS/6sWz5FykbIBOpBLUsolGT0U3kY2zMNGQtaA/fCEkyH8Cyfs9CzxVsEE4wSA0PJhsA7n+Hg4G6lmbLpezjrGBedQ6bnfUWoeDKs/62pxGV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmH7/XN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0KcdVj4x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527GfmvK028066;
	Fri, 7 Mar 2025 18:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=MWL14tZATvOhe7I90B
	VXFzhpa4/5FKtkBABOyqDpLfM=; b=QmH7/XN1TdjqsnN75UlDKRKW2idc2H5yra
	uZBv4vWdPSjVXBpeWodlwGwYeyETw7mWCXQqhil4pXWSORG3cqg0OY/riIdKLQ2T
	8iRCYhup1WAECHHH+HCqXZqWz0DS9/rsHhLRv0G2BTjd6snEmLCH7UNIK3RsdQVd
	pNycfGg23NHYh2uun6hlI3TQkAKIFmXEcT+Apc+KGYQFAEgo5G9xRdm4GVj2uYpb
	Q6RDzI2J6lp8YR4MucBmxX4U1Ae/MTWlWLM+4vgCjybPfcE9V/Hz5SNlVvInZPFB
	+jRpYLGs9SK9SMwGKTgulfP+vdM2jO1QGnTw+hwyeGGBLGqlHTsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw4rjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 18:04:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527HiK1s010929;
	Fri, 7 Mar 2025 18:04:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpff0ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 18:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wcy3bYpKp0PxUpjAelW4h/zmZdNHUwvy9mVDLjAwxWAiVD7ySWfmq8mGEXmzBYYjO++Hn6xqXOxqWWotYtwIWR64zDADHTRN8LCfr3mKK3Yar38l4abnd+ZZ6nfegHjWgYvtEx2TYJ/KYsV/3mKQ2zTq1sIt8Pld1ubbfSvrnYT9EmOANq79eDk/XZFR+lK0WUOkt6Nh3hxhlUXVXgQdnQOeDcuMWaB2Od+GTzudg9n0T0n34ndKtAGRa8zWT1IEYsPsrZem3995ksrmHWRJAtiO+qBLBV64xqs3PLQoxPSRP/2CX0Rakb6GwlgMF65U7S9YlbQw+HhfjfBp4XZlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWL14tZATvOhe7I90BVXFzhpa4/5FKtkBABOyqDpLfM=;
 b=ycR670JVuWFLEEBYSFWZ8wOIhBRbiSDIE4+9+UWRg/XUWCNfwCzwu5Zk/LfvdOnUjKrjqSZbBlpujA9qZp2sWH6qgxayS7jBc1g14ef6j6d3RFluf0TAhGMe/KZspixw0KqS9VgFBnKUZ6JybXYsg8vjQ1bmuS6YYjCDB7yvIeCOEPESTRdQ72zBwgvUAMp+8LKa2v2YLFYxFxj9S6SAf97VWf+jzM5yneKChHaeKEaFwZYtwLIBC7eemIUlKUU2BVdWtMJ01cpw4f68QlI6F5KiRbX/cZcOLSSALozwHtSFh8lbPFD/l8yupipKZ2rTKhrDSFEd2Y6W3GAkzWhsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWL14tZATvOhe7I90BVXFzhpa4/5FKtkBABOyqDpLfM=;
 b=0KcdVj4xfTgcsDBLVgAlKDgi2orM/vsKmnmyClSw2cAnAJe4GepHYUITt0BT9IRpvCn57cq66PkufLG4Nn7nhE+ESgrlbTAwhM3oZQPZ3IPm8g47FIsbq7xiRpRWIu4sUct8Kivyq9vsmLGPyMde83ISkcPDQUupxggmVoG6Wcs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH0PR10MB7438.namprd10.prod.outlook.com (2603:10b6:610:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 18:04:52 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 18:04:52 +0000
Date: Fri, 7 Mar 2025 18:04:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Message-ID: <8ebe2e93-fba7-42ef-b64c-850a35432096@lucifer.local>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
 <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
 <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
 <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
 <ba694acd-07b7-4f28-828a-19bf4c803ca0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba694acd-07b7-4f28-828a-19bf4c803ca0@redhat.com>
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH0PR10MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6546cd99-19b9-4e0e-4bbe-08dd5da28ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUMbyMBR9BMLVwgxoMHzqF1xniiQsz3U7vaokOhXGobKj9sCj3ELn0AyBS0X?=
 =?us-ascii?Q?TId9F9QQs3RrCM9K0NhUVja1/FlSdnJhYjolA9sZHRgkivLcc0KO53/Y6kbL?=
 =?us-ascii?Q?v5YzyIImRxcmVPnhaFy+leRTbEjrpCKNxBzGM5+YUeeR37+Y79qjSgnd5GnK?=
 =?us-ascii?Q?sRQXRFrJdAbf3yKtFZu6hUhegR/m3wZYCVJJ9LkGsWZ6eKTAn89xwl76kMQS?=
 =?us-ascii?Q?3Q+tv1e7vys6MYw2hi2ik/eEvKR6T8r57EypuXhjrNA4vgzjppOf3B3zcK/H?=
 =?us-ascii?Q?vOKIr3h5wF4ox2Qlba1W6YAQBHeTaovG6R69Y8pBUDrYYEKVELMVBa34SNYf?=
 =?us-ascii?Q?rNZfmgUEdWXj4GQe4hQRzwYQXgTFB6tXKcPYIqMP45X5OFr5b0AVSlK6X0WB?=
 =?us-ascii?Q?AxC4Y7deNJjLrqPZMIIJwnC3ZRW2vEuVmfDMNhR/vvy84a+T4jZVzbCw5fpq?=
 =?us-ascii?Q?bs1WEm4FBhHUxuM7jK+7i3eFDsAMGg8gufPbmQ9FKAzitY+x0yjIuAewulPH?=
 =?us-ascii?Q?2KkxBEBytzjgcTrhM+mxCodnd7+bPU+Vipt67rT/rtSJywJsBPKboor3A1ue?=
 =?us-ascii?Q?XZ4Se1+HkkPoxnXWxW7fgcy+bpXzoEXxMPTEdf1FrtDPSX8hegiCcMWvmxn8?=
 =?us-ascii?Q?6ya84ZUzk6/nXbSCt7DbyfcC8y9bHGyKA9ES89716gCDtz1S7NtolZXoP232?=
 =?us-ascii?Q?QmHY2wsA8KwBCNb7ZKbwkHe/NhVYKWRTCn4sba+Ro7mqPK1L8ywcFkzauGiS?=
 =?us-ascii?Q?TuQnrjgiSObbh/HOy4NYBsyPfYBkS1Mowg8uZjIqCpI6zt+v0G7UR5wO3Oxy?=
 =?us-ascii?Q?khZ3OAVZhv8cXuPrsRBUv7liQKVsfan5dyJGJXApHaJ8MjcTafgeSxdeOuWY?=
 =?us-ascii?Q?Gl0iFX14GlLZsVc6R3QTdY4AUdOavJuSXZ6AwNbiihoP0t0tLdzNBfv5xKhe?=
 =?us-ascii?Q?o7DH1e5jCfSzDjFr+KFhUULxxuGQl3Z9/98iDCphCgturuiMzL4HS2ZSKKq3?=
 =?us-ascii?Q?Gs5lZkV0ajOEp78G7/oEtPfVClaWpT9aL4vAu76mlybd95uWE01RCOIO6DXj?=
 =?us-ascii?Q?p2OdAmrYow0vszr1yAkn8hBhDtapO52KZ6h+NC6+xKwVt12BUHNy2hHLUAs0?=
 =?us-ascii?Q?YYtFcH2cuqFDg3q6Nswo/MU1iMAZwJbiPO7eSawzUOF84kc6tXbdQBNwaETR?=
 =?us-ascii?Q?4SuMCAkhFClJWET49kR3z3fkK9mKiJORF7kjdWS7hKWEdc3WrZUrV+zS6g8/?=
 =?us-ascii?Q?sJ2WtBJloJRVfcHgBJW4mzXqpe/V6LjXyj0UZrnRzU5b3auZV3iSRrqluEUV?=
 =?us-ascii?Q?GArFHlMKRaSAUhIIyxn4QJO0X1hkYPX2Cw1l2YZcGq5b6M9iNkAvfUKRx2j2?=
 =?us-ascii?Q?ba+A00L/CG3//l6RpFbiSyAUmWgw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQDVQFWCYGd3G8YWVWNqNlPwgvvwbIbdg5JhM6GFuIQU9mE2u2jl7Vrm1NJW?=
 =?us-ascii?Q?aQ78D7Yy0yfIxtY4Yz0EnuKXV9AfkcuooTvKhuSbA55yDN2d6VaPe2OAFfsh?=
 =?us-ascii?Q?3nu6Ofhn5EWcRL1Y8JGomzpZLGP1lnvZ3b8LUKpyi6FDkekcKV+hW/kVNDI4?=
 =?us-ascii?Q?cxfTN3iiCDzMMauIJJuNQbdaSJzwnMZqjDGDLgVUiUAhIXSm2rCw2RnHz3o3?=
 =?us-ascii?Q?xM8zfIMhw9XBABK+5FvseREvZ/UOgxuzoeRrYmufQBwUGCTBJuSZDB2LEAZI?=
 =?us-ascii?Q?T2DAWlNUT3qAZZyv3IgKor9aSM+jnRJMRphKNKG9H18yFwc0F/WUMqWpR4MZ?=
 =?us-ascii?Q?ATDqTAdzKpu1xl0TKzQ20a7wPPuSnO9mRP0aAeDE7Z6Gg50czPVP8qfSlfCf?=
 =?us-ascii?Q?GmsQoCzDWpGwLmyTm+Dgu62a1H5HzLv4DE5KHO5c2P/U8ppWFWeh/yS0AT4b?=
 =?us-ascii?Q?9bfsGPTPsWfjlTWYOgUtZfWsUSAn7N7Whkfm8pISYqOCeck/rKq38BLPX095?=
 =?us-ascii?Q?OZaT+Yq7bXhDvK9ZUpIWQjmNezUMB4Hkogq/ceyBAnMt0dADMa9J1pY37iYG?=
 =?us-ascii?Q?oqifd4dNROYgiJ7+zXW+CGlSXhDS2EZE0Vqqm0WdjNa6bIOvLU/1pm5lJ4Po?=
 =?us-ascii?Q?eHcBx7PNrQjIM6Q4uiIs7u+0V11BZ3ue6Doo6OUF8zJDMUh1UKw0MqZj6/g4?=
 =?us-ascii?Q?xg5ADCQqJ3IcuI+xtYgrMKTuj6jaiOIW129RuUxR+77WOdTeElZB/F0TNRjg?=
 =?us-ascii?Q?X6dlafAQGfn350Ex/jB1iIN9+ZVp0duBAcJ7o5/yt7cv8ffjNJLJSBrZkGwB?=
 =?us-ascii?Q?yKuZWnpF0T0JEV2COFXlrMB6TNzuFdJnwX3tb9FlFurVuGvsPPE0uBX0lfA5?=
 =?us-ascii?Q?vOYCWTahmvOBjRclKaVcy6oaIG6WbwKmOSNvbFY8XG66b8mSOT6tQsVmanjW?=
 =?us-ascii?Q?ZLYRjk9vDU7UPZDurOBtcnrH8WrNKXWkZuBxhGFeilnfW2y/aXFrKtopKKDm?=
 =?us-ascii?Q?UyEf6mT+2OQmzRaXvuZt4lNGhi6LNcqZia+cA184q9h3CRScwenEjisSjTei?=
 =?us-ascii?Q?5rMfr2PgGnei0Nvz6vnWODnS/IMf3LCfpu3tbbRsQsYbeh5Gwp1Fngdks7Ng?=
 =?us-ascii?Q?4i5o9ZNPgwTAeAYrXSnppyzHVHV0AciKsP1y7jJg19RGdALrKTwk5qtmMWIK?=
 =?us-ascii?Q?xUdbgfg4KEi1BTt9gNg9LjYrWTqIbyMbC1huU93I9xNVxhjjJqvkmObVQKms?=
 =?us-ascii?Q?SuCNkIRJ7RZkSEBV29swYXl8RqceShnwSa6yMPUsN2Nsfyp6lf7F1VdvnD9H?=
 =?us-ascii?Q?ZEjtYzOA2ogXlMfuMywMFbAdpuMbGawiW3+C4BiFtNb0MAD3xlUzRsJ7qktO?=
 =?us-ascii?Q?w3hjytmg4i9bCofvA1ykkJOR9F9aKm9KmRH6nWtbBqQoPlamA49/aYoItmua?=
 =?us-ascii?Q?7axmlUYnkQJ+wr+JYBhP+eQcazR0mBYPPKRI0O36oMcZSZJeFs3t9h4fik4i?=
 =?us-ascii?Q?7dzlb9lQU2EgLZ8WuvwjFFMp/j68bNO+ZKy2g8LPnj0F5gRIgSrqZdnzGpQu?=
 =?us-ascii?Q?/3sTUAVBAr+ws9EglFjz+dIxoh+CgjKoqoweklV/zu1w4snkNRgTjg9mBL22?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mxh9K+Wx9iAkBOLEq5KqAVil1T89FnWqPbYfW8RqXMaHXu4i8ZZIThdImgr0ColiL9sJB/bwC4AlbraG+23KzIgJrcVQJd0MGOzUAyDbLvtUA3NMdJxUZ+9okhSJSfMszw1FdbP15tNwoJ4oPyxfP0pcoVDQXeH2ECJIZFJcrEGVu69VFfF38/zSAfkk0JXzsrVmZXUuDLhz4EvmcrgStvHVwpN0Ej9abrCNb7DUJTxNDUp6oWwZ54OUMxyeqX0+HC+rq7eRjMovxmAPpPsXsmWLmxRiR3XYVKDhWFwdHLlooyREizfF9twd/zaIxOASQC97ynJbKQgYZEJbBSc/XYfeEGL7VDkDQZ8QK0+iFLSBG58A2UmRa5djHVpaSUXLIZO2biJHPg7LDWOWNg/pj/vqWaMCTybDtje5xpRlFfCW+wBcz7Nf5k6Q2NeKaOZZ6aoOtFS3QnmF2KrHorM0o8XhhO4WlIBMDlWU1gE9NZsCV0WWPY6QUpynkwjs50qTgVgpRzNr2NLeQmLmKuT7VYzCAc09m+FUtlOMNvSko4GpKsvXCFB/fz9O20bkmcUDFp6QZtgJKmHGfdi+335Z8kBpBobcnV/aAbC8AX9W/54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6546cd99-19b9-4e0e-4bbe-08dd5da28ede
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:04:52.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvHqpcdowqp8+tjWad8YNEaRxDYeROuy0RTb7rNSTR/OlNohZRMgduSKOPQuY638hVbdBVOxaeMqtqtyV0BINF6b32P48W7eG33DWQIGXRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070135
X-Proofpoint-GUID: OEJApvYKctRmzcVIG8uAyfMLGtduFfBG
X-Proofpoint-ORIG-GUID: OEJApvYKctRmzcVIG8uAyfMLGtduFfBG

On Fri, Mar 07, 2025 at 06:43:35PM +0100, David Hildenbrand wrote:
> > > It's certainly not read-only in general. Just having a quick look to verify, the
> > > very first callback I landed on was clear_refs_pte_range(), which implements
> > > .pmd_entry to clear the softdirty and access flags from a leaf pmd or from all
> > > the child ptes.
> >
> > Yup sorry I misspoke, working some long hours atm so forgive me :) what I meant
> > to say is that we either read or modify existing.
> >
> > And yes users do do potentially crazy things and yada yada.
> >
> > David and I have spoken quite a few times about implementing generic page
> > table code that could help abstract a lot of things, and it feels like this
> > logic could all be rejigged in some fashion as to prevent the kind of
> > 'everybody does their own handler' logic.q
>
> Oscar is currently prototyping a new pt walker that will batch entries
> (e.g., folio ranges, pte none ares), and not use indirect calls. The primary
> focus will will read-traversal, but nothing speaks against modifications
> (likely helpers for installing pte_none()->marker could be handy, and just
> creating page tables if we hit pmd_none() etc.).
>
> Not sure yet how many use cases we can cover with the initial approach. But
> the idea is to start with something that works for many cases, to then
> gradually improve it.

Nice! Love it.

>
>
> >
> > I guess I felt it was more _dangerous_ as you are establishing _new_
> > mappings here, with the page tables being constructed for you up to the PTE
> > level.
> >
> > And wanted to 'lock things down' somewhat.
> >
> > But indeed, all this cries out for a need for a more generalised, robust
> > interface that handles some of what the downstream users of this are doing.
> >
> > >
> > > >
> > > > When setting things are a little different, I'd rather not open up things to a
> > > > user being able to do *whatever*, but rather limit to the smallest scope
> > > > possible for installing the PTE.
> > >
> > > Understandable, but personally I think it will lead to potential misunderstandings:
> > >
> > >   - it will get copy/pasted as an example of how to set a pte (which is wrong;
> > > you have to use set_pte_at()/set_ptes()). There is currently only a single other
> > > case of direct dereferencing a pte to set it (in write_protect_page()).
> >
> > Yeah, at least renaming the param could help, as 'ptep' implies you really
> > do have a pointer to the page table entry.
> >
> > If we didn't return an error we could just return the PTE value or
> > something... hm.
> >
> > >
> > >   - new users of .install_pte may assume (like I did) that the passed in ptep is
> > > pointing to the pgtable and they will manipulate it with arch helpers. arm64
> > > arch helpers all assume they are only ever passed pointers into pgtable memory.
> > > It will end horribly if that is not the case.
> >
> > It will end very horribly indeed :P or perhaps with more of a fizzle than
> > anticipated...
>
> Yes, I'm hoping we can avoid new users with the old api ... :)

Well indeed, this one was basically 'what is the least worst smallest churn way
of implementing this thing'. But it's not ideal of course.

>
> >
> > >
> > > >
> > > > And also of course, it allows us to _mandate_ that set_pte_at() is used so we do
> > > > the right thing re: arches :)
> > > >
> > > > I could have named the parameter better though, in guard_install_pte_entry()
> > > > would be better to have called it 'new_pte' or something.
> > >
> > > I'd suggest at least describing this in the documentation in pagewalk.h. Or
> > > better yet, you could make the pte the return value for the function. Then it is
> > > clear because you have no pointer. You'd lose the error code but the only user
> > > of this currently can't fail anyway.
> >
> > Haha and here you make the same point I did above... great minds :)
> >
> > I mean yeah returning a pte would make it clearer what you're doing, but
> > then it makes it different from every other callback... but this already is
> > different :)
> >
> > I do very much want the ability to return an error value to stop the walk
> > (if you return >0 you can indicate to caller that a non-error stop occurred
> > for instance, something I use on the reading side).
> >
> > But we do need to improve this one way or another, at the very least the
> > documentation/comments.
> >
> > David - any thoughts?
>
> Maybe document "don't use this until we have something better" :D

Haha well, sure I can say this :P perhaps something like 'in lieu of a
sophisticated generalised page table walker this is a simple means of
installing PTEs, please note that...' something like this.

A British way of doing it :>)

>
>
> >
> > I'm not necessarily against just making this consitent, but I like this
> > property of us controlling what happens instead of just giving a pointer
> > into the page table - the principle of exposing the least possible.
> >
> > ANWYAY, I will add to my ever expanding whiteboard TODO list [literally the
> > only todo that work for me] to look at this, will definitely improve docs
> > at very least.
>
> Maybe we can talk at LSF/MM about this. I assume Oscar might be partially
> covering that in his hugetlb talk.

Indeed, this is going to be a busy LSF... Ryan will be there also by the
way, so can join us!

>
> --
> Cheers,
>
> David / dhildenb
>

