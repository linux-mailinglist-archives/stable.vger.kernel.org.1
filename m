Return-Path: <stable+bounces-185635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79FBD8F8B
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E70218A25EE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B52FC860;
	Tue, 14 Oct 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7rZejSs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OeQEfBet"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2F1DFCB;
	Tue, 14 Oct 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440794; cv=fail; b=TNKXykmrZ0C2RvV2EzTrbiDwoLiI35wCQe5J9Sw7qI+UN4v2BmCp/nUprNaIczWg4VKaBwhEbSM69yPuwpwXBvd35K5pRxqXJKxKXSrKcDGdA2jVmJu4cC0ke7HNOhXq8Qxd6rZDHolDyGIs8CSB6Z7c0HOWmAEYNZlh4/cfSqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440794; c=relaxed/simple;
	bh=jX33wVJe+ZInSbC3vwSrPGfJUBM1k95seBRD5ITDUYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVSL7VI2ZqZcDz6vufjgcyenoVyYlr+KG6abMJc3uZj4l/1+eH3k+OBvIxwmbmKatmHolDTLiXAmg9D7ckdddbIT9y6qDEkINxOlvmzHBkiM8qZZtJp0dkDbhVah9b6CrZnZKH5bbvOmngg4sAMTxgR8nDgmUSDGfSD9AK1UN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o7rZejSs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OeQEfBet; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EB9jRi019475;
	Tue, 14 Oct 2025 11:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=suFKQMIfs0Q2QF3DBn
	xAaqLHnV6Il4xSGHFcQn1hmG8=; b=o7rZejSsYT/rUrolSzN4+cIQunz+uh61HJ
	E1QdTR3SSW1yYYZWwQ6FrZs8sNN3eydrnseaHbq2iPWAsI5lR9SlYZoAwBLZjVGl
	AIpRt0/3B94az47hGEuaNsDEzzLv7I1zjE1TpzPt4swsq/6z0jZ0l8QPd9n03Oal
	Eb0Y/YCdPxosHGbj/DqpUg8nUWtRu0v9XQF8rhVYHYI98kA9UOwm2wRvOocBwcd3
	hvXSRQHSHVjwDLFqv5HspzvObL0A1EAOPsTuwWOymztnm3sMNcWjoWHrwBjQYN++
	dZutjdAiAkWRbDwwlO/y+N/zok15LOHdrHBI8T+07P/tE77g5Y3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrv29f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:19:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E92JE2017703;
	Tue, 14 Oct 2025 11:19:17 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8scv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsfOsoy8nRK2W1o9XrA29Vt6zHptCINeAZ4qAGVShu+FB2Sw2igljRrLxqF5AbFzNo33Zi45W05cO5MhmGukFhhde1WuBzONXXRJpu8Ew+SehA8ZhN/eJkOntJBJ1YvVgf0KqfVDPca37QLNANhJTWX5vL9W9rpb1A40C6rG5/UWncKDXkve7ioG+vCAOq+wPiSItfXw7cX73dTo77P7ZaMOu0ipWwnmigzV/SPXYb+lSTSSuqDo8lxKdvLatCC+Szhey2etnbVa8w7+xYwMjl/RMeh+tlSyb1P+QCQdbA9wyE6w+/Brs5yOsEyqRAcp2+qWRRglIEUZDBwVOzWgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suFKQMIfs0Q2QF3DBnxAaqLHnV6Il4xSGHFcQn1hmG8=;
 b=crN9uL81c98MOTu0/ZOm5elgKPv1+B+WOgNpETD9LvzN14JU4GQ8H6u4z7KBkjt8zgexgAqbQLGs4zqLVzigH9CeJsLyOKl+5Cm0a23brqX/joYHW5nTRLhqYDlN9tFwV0zapCW1gblWgDPeLFeP7O4Q/dNnwarTlvtE3cWLC6tCKfwrWoIrqbYJoVH3Ap2vr3YErCOQEbLYa40pxXCAFCuviEm+Yuo3zMf/i0AE35aRo39ZgqNjaL4QZYdu3167ajdXfBK6HAJkAkoExZMPU0E1iRCG6ABiXkIUWTDJQtyQv01lIux31MZGsJtZe6w+SjMhQ9iInFotf7+RleGSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suFKQMIfs0Q2QF3DBnxAaqLHnV6Il4xSGHFcQn1hmG8=;
 b=OeQEfBetfd0zYuVMUC2aEZKXGduNFEhDg5RB2liHRAkldVXDGot8VNNs/y70jwPIbmTDlx8bi1QFbvM0nHQ26HDSOoZ1wueaLMRZQUgPgB3m3cupZSXTs2WG8V3KnBvC6b+BuwqyJu1Wkr2NkCuq8Yu2xnwRfptMIOPcwKPquac=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 11:19:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:19:14 +0000
Date: Tue, 14 Oct 2025 12:19:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
        ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com,
        riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
        joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
        gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
        usamaarif642@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Message-ID: <91c443e1-3d7d-4b95-ab62-b970b047936f@lucifer.local>
References: <20250930081040.80926-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930081040.80926-1-lance.yang@linux.dev>
X-ClientProxiedBy: LO4P123CA0127.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e26513e-f472-4456-5774-08de0b1381e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yk2nBIV4qznzohhJEomHsgwKzAg8aC2qv6BMH1VsF/v+GbnF1VpsaJ7GqPmO?=
 =?us-ascii?Q?qIu4Vk5Dvx73t7jD7QLtVXUGrQLWMJ1iMK1fQglHZCC2YEEc23UrRvcXyQ3K?=
 =?us-ascii?Q?DCWzM2gh0sZPUXGJEGXhnqYsrCNcW3LALgwJLIPpzcLrWI8nibQTCpbX+iKV?=
 =?us-ascii?Q?nhVeeFF0cp7w+aAL2wKLs132kp853e45X84oSBihZb7p8kC+AfcQyIhPJenW?=
 =?us-ascii?Q?b+WOxBWuQScD9nG04IfVj1AdlZg5awzdTCL20NKFX2AvkRW0c/o07SVp94Rv?=
 =?us-ascii?Q?FIwc1h6H0i0GR56l59iFR8jVphFUr+EMLzciFRRked9tYPGDROTftvOTBxcA?=
 =?us-ascii?Q?q7K8TNdx3cL/5y3xWQqoPmyD2GGYUck0Lcc86ngMd8p3NJSqa8ML02/I+Wnd?=
 =?us-ascii?Q?XZLAnhAjSmzJg9A4yXBpoHnUOp+rl4bP0yXvgsOJI5GuUYbr8t8bfZflN0XA?=
 =?us-ascii?Q?Cp8oEhLTy/jAtMeCkhsCQgv5sAtLzp9SJa4nz6OlE7cBWNEo1iorEgmVdo6p?=
 =?us-ascii?Q?s1qhkT1cuK3jHUVKtag9fG54tdCzkNZIcr+aqX/N88aE+CknQTXUTADM0Lcc?=
 =?us-ascii?Q?/gQpibh3zTqhqJN0L5ESrEjsUJKnOxgrU+GUR7mCpI69/7FVtL+GYojyyEBM?=
 =?us-ascii?Q?t6ueQlD1SZBxqxA2VK8qI4itR/0xnheOX8pB7Om+eeJ4niQMemVQT3jLXxKY?=
 =?us-ascii?Q?juIxi5QIDj86iCTPwrHONddwK+w9XU9CSuM+eBEo9V7qej1+fYvF+PVNqN/N?=
 =?us-ascii?Q?TqwyI4/r1qUMymVo6svy4qQcl7+c37l3i58LJ6mVgInEoEmX639R5Wg4RUAm?=
 =?us-ascii?Q?xAHdMRj0qbzilnEB7PNiwP6N9HI1/JUpWmef0AaqI+6xRoeX61lA6x/lSPdT?=
 =?us-ascii?Q?9BwEv5JlMzZOXUXHJq5Mfk+IrWTTaFGQ9zqOw4qrmCm4KYnfTW+iao6m5e4n?=
 =?us-ascii?Q?qHQ8Z32seOiO/05Bbh1eEaHG52OMK5IbsAbRzlU9YpMHaCrkZD9i18Xk4hEo?=
 =?us-ascii?Q?h2WzHXsqvqkdtPB6QVSNd6Cjo7aiqKIuzybsQOgqeJnnzF3xHNSEGjAcpYvH?=
 =?us-ascii?Q?FzHOX16k8M9dA3k6Cj67XrHKm5zqPMWocPx4uoNGzKhKGNGj32AWENsRR/hb?=
 =?us-ascii?Q?A61dZBQJZMMr9U64JCB9bH6SwOvCoWyn4KTr5SD06SgJVOeqXb6pmos2vW0O?=
 =?us-ascii?Q?xuDnAoSQQvomwTn1xm9LY+fsIgRN/FKGyCIwXWKkJMCkKJDyxwOSVG4+mew+?=
 =?us-ascii?Q?Afc465yo97ERxsNKF1OazcI5/fTKrkyUW83isxxjgUiz+vb3dY4+fpTyEWlE?=
 =?us-ascii?Q?oR62e3kZEtnnf7iMFVbq3yVOneLcwEWxDnRBuOaJ58gs8PA9G20G7Xzrnja6?=
 =?us-ascii?Q?BgyG6xPpEcQDAsyCglZaJTQIhvi4/2yqJWqS6CNkzT+qxPO32pl9IVLaWNN+?=
 =?us-ascii?Q?jI1PlT3KFAI8Vk5ddhZX6GXHWuNElCtDBUHcrAG1RYEjYJEYUvsHDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3XIFXy7ej3gwPGg/G6VTDqEWOsch12PG33X5cAIWTkZnYPlUFb6UC/jeyNo?=
 =?us-ascii?Q?mz9+vR3QD8YFVSqMeNYvjLe2ERPMKboxWyA7c/UYH+AsOzHfuDz2oPhr/9hv?=
 =?us-ascii?Q?PL5H2/pndSwQok0hCmeCyDZm67NhNUEbDOQGHNGooBObwM6FHz0bA+gCwTIR?=
 =?us-ascii?Q?16WOoS8eG6fWjjsKV6Em35W1wT0QVaqhZFCrrq4G2z+7PkQv9MGC8fm4feNZ?=
 =?us-ascii?Q?G9/4vqX4onRazjph08QQVhD3vhIaCxhG32I7gHT2CvazQKTBgFiOC6zexJnk?=
 =?us-ascii?Q?m4BB3cOdN+LHlDQJti1/ICXlbnIoJk2l68htdePzyqmeo9yDOcJvfYF3zzqR?=
 =?us-ascii?Q?TaFExre5jGEMiTrM4GvW/GpLtZkp1MoHGVDOmXG/o1QmgY8nf4wkIEjq91eZ?=
 =?us-ascii?Q?vy03e6Mcw6grjzRy0nqtHWx+YJsnDFmk50EIh0GQi9o1FntPsuEJBxELRgrS?=
 =?us-ascii?Q?R8Y/1ulPQiOizL5Qez+h6ckJUK3u6cKig+J5JFEkUTESA8roRgj02cR2D7sA?=
 =?us-ascii?Q?z4EMw66zWH+6b1QopJiQW7XXYlbY/Vbj3QsYpu8g5JGT6grqgTBEOOnmzJ49?=
 =?us-ascii?Q?4SeZWia4ZwElaZ7mZEnTDTFsjx82joB63I1fUCPc+nF3DFDdIbrfmN/xU/a/?=
 =?us-ascii?Q?SgccpBhVXf48H+w4vaj//OrevSACebZWMAZl7KR76n4VchrKX5TsHideR1hN?=
 =?us-ascii?Q?407mKkMV/XJNTmQN6vnz6VAGKz/Vw3S7ctG7twkU5251hfY+WblEt9w5Prcx?=
 =?us-ascii?Q?ZbgHjBWjdYDRrMpugY15oSq+VS0CqUJeNOrfPINm9YMI4J0h4iQ60ns5lU8T?=
 =?us-ascii?Q?e7mECq2oW50Y9cmOB8lynJBtxVSr1fDEpFFffVmjgxyBHb1Mw2weTplApBq/?=
 =?us-ascii?Q?DjTPcdJsVZEKvzXMx9Z32y2BVmlfbinDdP9YOgqgDJmqfB0pPytOM7tkB0tj?=
 =?us-ascii?Q?4EDy2LfbmSeOrBkzGHPI1EyvHweMoBDFpCtYyQ6dPdsnuBaDkOU0NStnetCO?=
 =?us-ascii?Q?zf2Bk6iiWHIm0OpXy8qVQpzmV+QfTgd3ohkjrTwVN12JXex1BLwO6ZeFLQaT?=
 =?us-ascii?Q?QciaJl2eYn0JzDn9mbnfHCAYi0hOZDhY64FbMFBPuFZpKJ3wBYpDzTaUJ534?=
 =?us-ascii?Q?LDi/m9AQjyEFHhp5dysZ4EAFmkGkAJKQIZXdG32sYdS0dZgdCo69DfunTOsP?=
 =?us-ascii?Q?0H4V1Qmpdj6sFy6Pm2f/Qpkt8sxh5J7EnDWcexedsHmVo+D/uGVnJAwAtpWc?=
 =?us-ascii?Q?gxzG+TOOuShfF8KdmLfvCAIvjlU5mY+sRu785lJhmPz2jIZAXV9pUashetg1?=
 =?us-ascii?Q?7697MBtO4P64+RlwIa3AwqIUXCy+Q4JEVJpCBZcB+0g/2KJGIDj0oftSLK7Y?=
 =?us-ascii?Q?6qsSJXmXcFXRBe9bApPyNX/R9VLth55aOQ+lxlpQyzBqi+uPRJyNN24B7X1p?=
 =?us-ascii?Q?6YZt9+7l6VAMdM+DqBI4yJIbKSNTVZk/MdsY2t5pq0DNcSwidtvgrG3jKXbP?=
 =?us-ascii?Q?wwhSuY4SDIY0CqLiNuf3hzs0cmkfz/EfP1DRzxGReqdi31IMz8ckJEKp3a+h?=
 =?us-ascii?Q?YKdJ5oc+eeW3wpAwuvYd0eyyMr8FXMbhVbEmCyu1sVU5PPRP6qr2TWVXPkW0?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e1tTRRcGumZjeuUDoO76B878lBc5R4I08oNWqy/pBFHXtmgn+kCRChoaN6D1YTEKQeUzH9KHWLVDG08SyK1khdhqQIg+9avAHbCillOCg0LxBni4QPOPpyESvzjP9Q2ex+HzXiXWcj41berpe5Jp1aWrDR6sN5RS0AVkXTCNEYwU2ZuLqZrg7WJIVR84whtplx3iUW3g0992wCoev4ZTXQzkXe3EJYyDyWRTN780m5Oz4mhLrGE0g2yYJRrQNUiZmzDdZmMyCH16VgIF0gM3efJ2XhgmAjhBQ6bd6uCL/raQa+qk+bO+arDq5k6us0+OTDXaAFbrDRqR2bHLauDbrxjYCx4v0JV+i5vgVBTffjhxrqRvPFHxt5JUMtcaLgXHaGke7Rda2ODx8r0uF5SJEHTVIRGKly36zZ56gij+4ynw+UijX1DP9FAU/xZ5U0pQ90bCN88DXXRTiagL2fMEAZhDSCXPg7yani60WN9bc/zPsX9KOE5i7+1Ac2hscwb5RgKQhX3jhP+RQX7RSeXd8dxpUEIFi8gp6mCQnoZFX0cZNMP45Mtq48ILmYUDM4nV0eQ6V3X+dxDpQensNTzBA38Al0fh312c0JwqsKJXW8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e26513e-f472-4456-5774-08de0b1381e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:19:14.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkwvyolqsvNN+9ngIiNuHvPoJxX+/lgXRqlE9SDr+lYMiAG+GE57blsBi1H7d587+F5I07Wz0etSpBOC41R1muhiVKdgSZ4wID/EVSRTOjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140089
X-Proofpoint-GUID: 1aGCl2FvqSO2s-5Sr8f2ejICJoGeCbQv
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ee31b6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=ZpJBA3WTnvw9DzHdlOIA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX5ci8lYd9zuDh
 Y45yj17VmCfdZueFldovlnQhWNqX0HhhIFnhSVyGigxVSJKNw4EUKE4ZU/rf23YDjZ2O7V8IVol
 uaifHKvMC3arCuUa2eM16wA4enpX3eTCMSz96Zu6Zas9rNCfcARAzrjARDZ7Or8+c9zHCM79KWk
 jUAMnTQHN5EhO8Eu43fWtdsLe8+6aLVe6S9AF0sfTrWMooBmWOa4MyvODOu6MQgZ23DzKUJSpIP
 1tPA/Iy5hU+XZFbCrG2b3SC4HQgPisGbDV6Mw0x/SEfnlIX0qxn5l9Rp7Yr30z6U/oZTXoXKf13
 30P6o6GmXSiIxbR/z/VWMce4GwVSgx6x9bToFwmyiOIz+Vl/9PHsA1JB9SoLG9tfET6TG2Aoqoh
 IB0KC3dp9tNb0htxVq3yOeoQ3Q8SxQ==
X-Proofpoint-ORIG-GUID: 1aGCl2FvqSO2s-5Sr8f2ejICJoGeCbQv

Feels like the mTHP implementation is hitting up on the buffers of the THP code
being something of a mess... :)

On Tue, Sep 30, 2025 at 04:10:40PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> When splitting an mTHP and replacing a zero-filled subpage with the shared
> zeropage, try_to_map_unused_to_zeropage() currently drops several important
> PTE bits.
>
> For userspace tools like CRIU, which rely on the soft-dirty mechanism for

It's slightly by-the-by, but CRIU in my view - as it relies on kernel
implementation details that can always change to operate - is not actually
something we have to strictly keep working.

HOWEVER, if we can reasonably do so without causing issues for us in the kernel
we ought to do so.

> incremental snapshots, losing the soft-dirty bit means modified pages are
> missed, leading to inconsistent memory state after restore.
>
> As pointed out by David, the more critical uffd-wp bit is also dropped.
> This breaks the userfaultfd write-protection mechanism, causing writes
> to be silently missed by monitoring applications, which can lead to data
> corruption.

Again, uffd-wp is a total mess. We shouldn't be in a position where its state
being correctly retained relies on everybody always getting the subtle,
uncommented, open-coded details right everywhere all the time.

But this is again a general comment... :)

>
> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
> creating the new zeropage mapping to ensure they are correctly tracked.
>
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Overall LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v4 -> v5:
>  - Move ptep_get() call after the !pvmw.pte check, which handles PMD-mapped
>    THP migration entries.
>  - https://lore.kernel.org/linux-mm/20250930071053.36158-1-lance.yang@linux.dev/
>
> v3 -> v4:
>  - Minor formatting tweak in try_to_map_unused_to_zeropage() function
>    signature (per David and Dev)
>  - Collect Reviewed-by from Dev - thanks!
>  - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@linux.dev/
>
> v2 -> v3:
>  - ptep_get() gets called only once per iteration (per Dev)
>  - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/
>
> v1 -> v2:
>  - Avoid calling ptep_get() multiple times (per Dev)
>  - Double-check the uffd-wp bit (per David)
>  - Collect Acked-by from David - thanks!
>  - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/
>
>  mm/migrate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..e3065c9edb55 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>  }
>
>  static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
> -					  struct folio *folio,
> -					  unsigned long idx)
> +		struct folio *folio, pte_t old_pte, unsigned long idx)
>  {
>  	struct page *page = folio_page(folio, idx);
>  	pte_t newpte;
> @@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  		return false;
>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> +	VM_BUG_ON_PAGE(pte_present(old_pte), page);

Kinda ugly that we pass old_pte when it's avaiable via the shared state object,
but probably nothing to really concern ourselves about.

Guess you could argue it both ways :)

It'd be good to convert these VM_BUG_ON_*() to VM_WARN_ON_*() but I guess that's
somewhat out of the scope of the code here and would be inconsistent to change
it for just one condition.

>
>  	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>  	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> @@ -322,6 +321,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>
>  	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>  					pvmw->vma->vm_page_prot));
> +
> +	if (pte_swp_soft_dirty(old_pte))
> +		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_swp_uffd_wp(old_pte))
> +		newpte = pte_mkuffd_wp(newpte);
> +
>  	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>
>  	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> @@ -364,13 +369,13 @@ static bool remove_migration_pte(struct folio *folio,
>  			continue;
>  		}
>  #endif
> +		old_pte = ptep_get(pvmw.pte);
>  		if (rmap_walk_arg->map_unused_to_zeropage &&
> -		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
> +		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
>  			continue;
>
>  		folio_get(folio);
>  		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
> -		old_pte = ptep_get(pvmw.pte);
>
>  		entry = pte_to_swp_entry(old_pte);
>  		if (!is_migration_entry_young(entry))
> --
> 2.49.0
>

