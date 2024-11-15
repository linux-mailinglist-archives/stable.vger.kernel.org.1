Return-Path: <stable+bounces-93525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58C9CDE64
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EA282BDB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C91BC9F4;
	Fri, 15 Nov 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdS7vL8L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h1QGwClw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E111BC07E;
	Fri, 15 Nov 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674344; cv=fail; b=JdJAHIxwSSZdZ2O0TzuG0y/KVsRYASappbMc4I4ndPBMSBuEsgzlnTppri/0cPo5ma/xdF5gSNiRSa7o8dWd916o3lPCHYGp68OR3jZLPZrfm0D+dVAMmAx8IfIFK51/yNizhQKj4TCTNJgyl5kUUoLLRLTWykGPIiytRDnomKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674344; c=relaxed/simple;
	bh=wWWRmAPYqFNpFH1xWAQSId5YVH7Jnmaw3Uc53rAPzvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPrrNOwpFM2Co5xOvEMrxEbKcpFs80Oc2MqspGI7CxcVOSPGAL1JrEb+G5HS6dtnEStNmfk/h+Fmh6fqAi26ogpi3rXGOIj8LrYXAlkPsG+HaaKIygJvA3oUizBvqlA0M4t8EyC2ZVcy5PjqKrdal/dAJvGXDuUu7Ur/3eCtlhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdS7vL8L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h1QGwClw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH04M014153;
	Fri, 15 Nov 2024 12:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lN/v8jAJa6+T87vYqjFs43JvP4ZvGI7KJfkCLwPdhVo=; b=
	WdS7vL8LpfijFgPkKN0TpoKwBcFDOaK2VU8+py82NU6LNiOtFFi7qP734UxMH2sM
	+DOooQ3XUl7pjNFB094+OyJUMLt1TPO5U2yCv+RAlWIh72BsvnAEjUxEymKBA8Cf
	lRjcmo1cPLiwyYFvc521JOb/BmKbKaI8WwNtrBc7yrA5ZM1UtMlrgwrEONIvHlWP
	gDBss1HUgGb/8xlneldmrJ0c84ZMCPxZj+ZDWB6j4AGq5dSUnRbgUpdPVE149lUq
	hAWy3mMm4es2CFkq5h5u/MRUpuuDkYWqcu9YOiVbfO6hCOcW/BK2lBBSYQSU1mmD
	tVtALIuphRir6s7AwLp0zw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5k5td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCYFXU005704;
	Fri, 15 Nov 2024 12:38:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ckrhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgWI0U+OQPFs7uyBIlLwxrFZOnSseSckxhEJm6HtaRGHeDRVyJAeo7RvdVrLZrdsxEWoU6jWgnLVj1GXeJn5UcXoSuI35Vc7wUw6Bv+iJ69TqqrH2wu4qhDJltrlget833o6c8JHddaAz/HOCypE4674SY7LEWYysuXCgxJIPeMIm1giTogctaBJXS/DBBUp+nkTr9T+vnPsRF0FTnR8PsNHvfZ3xjamuUvfeRvN9jadySvHKnqXKxYK11rRJ3ee7bJt0ef6D3yWcjbtILNssrw+VIScByecwFJJaNMr+67qZJG5frUrD4Z4R5bO5eENavsdz9XFFRJpQiXDvx/5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN/v8jAJa6+T87vYqjFs43JvP4ZvGI7KJfkCLwPdhVo=;
 b=ilGwea3wHXX7wAoNivuoIsn94r6gOY/DmXucCX5TM5AtK/NPXxq9GkCLPF+Xsyz0j0K0NiabpQ9b67iKxmyIv615ebNBq/ve8BYt9FFfThbJG9i/FuP4BRpTEI0jQVfvqcoDJP/+Y+XEVDVR1J6bch/RkzujLN8mxxjGC/TdUSsL+M90fn5+7z8jJcCuxpA81awOUnDVsIVckX4TUwcksB+l51BeLSTSgKfHnEiNW9VRaD1WAyjp7+RwBcvLThnbFRATytG1J1pZ/kOHy8DR1AAxnCIZ/UlD0vaNzTILm+SNeYmLxfkt1DxDpHbh3Hm6DAhKe3Cg8qIbj7SRFWY4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN/v8jAJa6+T87vYqjFs43JvP4ZvGI7KJfkCLwPdhVo=;
 b=h1QGwClwwZnPxlXOx1WvxAaPzEgxFEmo1ZXvO390ieBxHflw63inGRYEdBta3e3kRyfTFrmztRCvTQytIpHipkcMhNgw1bI3IxqSfIvSwkl8bCHInoV8eTkXrnbtbO8j+H3McBGTpT4hWxmxR8wkkwVAsYik0YVRy345CsBIoYI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:38:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:38:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15.y 1/4] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Fri, 15 Nov 2024 12:38:13 +0000
Message-ID: <2eb0f68593bf50f79cd346269fefe596cf0a6801.1731667436.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
References: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 675d25c0-f6ee-43c9-c212-08dd05726cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIkdN3OjDLNKNa/xPLz7K3qR7Rqi/83HSDUIWFxg3YUq/HLUuuR2K+3Znly1?=
 =?us-ascii?Q?N71mmSzGEMBBWq5momcK/p4wJLappmAUCSDuhQZjKKDVxRWD8230Z46yk7iZ?=
 =?us-ascii?Q?cFpYb1Hs8iMhWm4gd1y/8Z13NbLmqthGhzFL6G9AjkX1rWEL6KAlmQcGqArt?=
 =?us-ascii?Q?ZUuBeiPm/ZCntUntAYyW4i91ufKeWlkOBxIHQjyjKTU4qGfrflDGAHnZgumv?=
 =?us-ascii?Q?Eb51zM6rNHjLHt45rKk7UdM7tlr7D/1AQHuYq5UuUv/cgN2oHrnVvDK8B6mU?=
 =?us-ascii?Q?8fmXzGiPWZCo+jWhT7B6IR+L39TxlbyuTCCOCKgUUBcnpQ23VThw10+o47Rf?=
 =?us-ascii?Q?fyvghuwWuZYkGLMdsX2ifaZJv81SFLPNMJrV81RT84K3qii8/n/yIP+TMR+M?=
 =?us-ascii?Q?pkNc/GVeb68KMSEmW73W/owd0A3IKbIxEUJ/nhKNJlOHYQ8NSYiEelCc6lAs?=
 =?us-ascii?Q?wiGzVb5liRMQ/dt0t37ksvFkjtnYxfFLJwRyLe0HPpDvNDIJRGdjoz2+4c6n?=
 =?us-ascii?Q?CxgqShzrWVidcCpgJI/2vyICiaXyE6foi5PQWIKqlz+EBF/KMahW9jhUnfLF?=
 =?us-ascii?Q?C+gxqHDLk/BkDL48UhkRhWfYu1jypuJ+nfvYSvhYSknl4BZYVq6U8RzdUlwQ?=
 =?us-ascii?Q?jwUmJX+EMgRq797GtY7bRrYCtZj7QsR5EOQlsm9ohnXwS3UgZUT1GmRvZhUH?=
 =?us-ascii?Q?ftr0X1R5BA14sb90ceizG86Ja7NszNRdqyYZC3Y5dssBU4CGnZ3tk6FaRzjg?=
 =?us-ascii?Q?VbL49I6zDB/PHKmrAfI+9hoGTnz1kxrZDJtJkilHILm7u1SMS5ms8Mk5G3N2?=
 =?us-ascii?Q?Sbfrb53d+qEzo6L3dRT0RYqeOMzXnPgf39TEXV23ofsnGbENnmQreveeTxPQ?=
 =?us-ascii?Q?iy95kw8sl8xgyMhL+/46pRwnKjp9pnVYB+3Cm0aL24PvS4ykUo9wL1QDY4qH?=
 =?us-ascii?Q?E3ONKWPf5nskZ933hbXuDFGK0vCYP5HrZxUOGtn7QD/9Ekgfz746ThW3Z48D?=
 =?us-ascii?Q?VVQtsBZVJTTyzKTXOS4DTQ/TFlAj5lFmTDIgEWSsFn2xNefgUE9Y5AHw/G8p?=
 =?us-ascii?Q?c7v4VFr+n7Uy/zveSpoqrYzzLkhbTJZxB1/dCgKeil59WqbnUhmXPvtnM4bf?=
 =?us-ascii?Q?jw660wX/hyzmLvOWcDfgrze+5RLQ7teJPpZGj/43ste+yvNqPfazajqNU/9g?=
 =?us-ascii?Q?Dv7ymy8tx8NDddp9AEDybwYiiIgJId9lbQ8//p2QbmHAklIFpme9BkRw6fjl?=
 =?us-ascii?Q?WPHB9H97kHrjmkRQPIuf2rRNnV0h7VQp7d4iR5xCkDrqMlCr1z2987Jogink?=
 =?us-ascii?Q?JIp0HfEdi9gP50JCqRygTSjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P6/IOF4+K0Jnnams6Tcn6/xZ9ybPykiwyHP7Yetf90/AibV5xJeKTcIMefJJ?=
 =?us-ascii?Q?kD/O21MtNXvhTs6hUTrzgOHuJ/ptPj9I26hPEYnTa9Jctqd7+gpjgWf5etdt?=
 =?us-ascii?Q?DQ7WFzuZiWosYO6sPS4eg7X8eeTUjU5vxIcl7Ju++45lBmKIa4qQ9LO/CCA2?=
 =?us-ascii?Q?LV3FsmRLScQUvYes24itl4Jx9WQc6yVWj+FGurqZdroSzgleN2haI3TbR8Mc?=
 =?us-ascii?Q?qd5YtW47KDu8QBURjjZALQeiq9UKccvoovp5dW+XQmznkhjT4mrfT8TVrgS2?=
 =?us-ascii?Q?6YqQfvVJKqtQazDWPvqc0Zt8zlgs2J0azfgGE9C+T6hpscoRJOFl9wvt4bLg?=
 =?us-ascii?Q?NgStHiOyWpRsMyhWJvQu1m1CKFMUJnDoKA+M7fU52W2cZF+AK1zbsHnpqCoH?=
 =?us-ascii?Q?6mBQ2jQK00ApHtaaKKEYQjM5GLpIpwLBsqRElBvx443a48NRYFm6pvCCz2mX?=
 =?us-ascii?Q?hJS9ZAPajiGFCjHhLM/IV9ZmPr9STlC7IapA7bvtpn31UDidqCpafdq9Hkal?=
 =?us-ascii?Q?2/21x5bS64qDXBBLewlHvXLOWD5u3bcdLwODVK/W60A2f/8znlZbnULvX6A8?=
 =?us-ascii?Q?gZ4JMpJ8ep34jC9f0itOh2tSz5PZKQT3p/hvbz4iDHKNjZ2JgIR3DD+1h6Fv?=
 =?us-ascii?Q?bXEL6OwSxyXCakyUmvZv0McMhzR094OtRSC238xrpKK+XS1kCph6/jVO83+I?=
 =?us-ascii?Q?ObsjKphwfjKuObEG5+hGh5hVDKgaQrneX3HtzUn2ZIg2DLnFYo8QMrzVVEBj?=
 =?us-ascii?Q?RKp/N9k2oRTff6AYb8NJMj9jkjRroVPJ9G+w5zHLpZGBIkmeBMHZ5/uJhEZp?=
 =?us-ascii?Q?oU5ykrYJqYCiRSRAfqMC3JYpBp6tTjWyHYP4pdZfm0WH+K/uc2zI42Jq2jYE?=
 =?us-ascii?Q?7IoDMgCyMe2RqWQL1EeZBEdIu1A6pBwEVusCacUyiGIzFqldKHgMm2ZNpNxl?=
 =?us-ascii?Q?hIH7k67RGRKm8SnlE8ZHfymGluj0WuqpNvNmUVrHLngC2gCjQedUA/d+I+Fn?=
 =?us-ascii?Q?Q22H818Q22CXL9M3ux6ISswoRtynBmSsUN9fe55D7CB0xb9PyLp5DS1FhPv1?=
 =?us-ascii?Q?5cMnUcPNvHaYAgCkkw+vk/3yFF5DbD9Ttun9iaVYf5nPIwIeVqPKR2jVfEqT?=
 =?us-ascii?Q?4rFeJMmCmxKF3ijmmBybtf8d1S1Z1sx8/suuL40b6EZloSwHaNgc7LRhVmVh?=
 =?us-ascii?Q?Am+G0DPFKvLaG/zvEVxnyGR5YcIVzM94ncySU1H8KEMdI4uk8flBwRVdJMtv?=
 =?us-ascii?Q?WcvYgi2thQv4avt3IxUBcbOa5/SQJ5Sqbqo/aN4/Ccywf1+Pgv2V6V09qAMP?=
 =?us-ascii?Q?d2LY4udN9akRJiiFOhBUPEvQ8D0KiY/8NXdSA224fK7iVynOnGQTy0tegNyI?=
 =?us-ascii?Q?oe32lGvp2WlVcFdFzcg5dn2TL1nFhZSKZl/mqs0JdTi2q0NP3APVvFG5+rfx?=
 =?us-ascii?Q?SyDRfjLgvCBlNS1acWcB1ug28gphqGwIQoMcTylf1kBeURXFgm4mc4k/dQm5?=
 =?us-ascii?Q?07uq57SodAeBnRdmsADs56g3lWjwej+7eHVml61UecI8qOTSx2bnayAXVhjl?=
 =?us-ascii?Q?51uIPdDDYdL+se2B/7Wyr4FtjdL4rtiFikx6tcI7tiXWAqBebwpxjj4PAA8F?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Ct3uqx/dOe24ehSuqGakrWUVplW2Qybhk4XkLN6Y+Qeu7GzT+7lPe7+fiR6Vz0oSb3Jge09zx1H6DX0ExEOdVvSVcSnwgplJkxG0sR64r+sips3tXXblB4T2eaf681rMmpGWZpj7yWdpyKkulQrM1RChDKJQFSkH91tYgIQhdt/2j96MD9Pg5eGwIHpfR038krV24MOUSsu+YR2Wv0XR7z6SLs7MYPdSG5qJ3FuxPcqOgTjdAercJp57IvmE7vJfdBvfF1mjyk80Snahf7vNs6cmTVz+qW8EDwojTAgagl43JCr9LrrhfQy/KIjecWdybFWKmY6l2ZAHDNYwDg20Ifo5FfjTwtzHWXWOnYfjUClYpuHsaGqBzmYrz7LLdtrlU3SIupAc4+RzWfHgfaHlKpDPTrzA4qOemS+4qmWWPKH0qLGk0AvelxP+wSecgbg1LCGvkfjCIrjM42AXXVbJGjDrIUJdHJGJZTaE2Q593DUBuqgEe4NiasZSDjOzBnpy9+7jS8Bj9itx+SbeMhsD2vvJahtSXnm2h9KtUi0WIuCQwN+4gsw8aBvSPSjI/ZIyLRkMVW4VbsKz5wVgbujkFRCwkXCiPr/99HRTfxTJmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675d25c0-f6ee-43c9-c212-08dd05726cdf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:38:36.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn8gEn56I/1ow84ctn5UXB2XnJv1OVyOJxXzqGP3K8J9msacuZ7L2aO6fAxv9fJtustCh/rd8oAeQF3QrosM/bRibZSmrNoVqc8RkHw50Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: cO9S6qe0LT4Un3PmImzeVCGMjSnaU9P3
X-Proofpoint-GUID: cO9S6qe0LT4Un3PmImzeVCGMjSnaU9P3

[ Upstream commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf ]

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
    function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
                            -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd444aa7a10a..4670e97eb694 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index a0a4eadc8779..11d023eab949 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1788,7 +1788,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1803,7 +1803,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		addr = vma->vm_start;
 
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		/* If vm_flags changed after mmap_file(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 02d2427b8f9e..2515c98d4be1 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -942,7 +942,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -973,7 +973,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index 973021847e69..f55d7be982de 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1086,6 +1086,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


