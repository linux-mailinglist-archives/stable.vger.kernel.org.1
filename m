Return-Path: <stable+bounces-146191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24716AC21DF
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 13:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EDB169FBD
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4A227B88;
	Fri, 23 May 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGtg+vLK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yNQ0uGYg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3820328;
	Fri, 23 May 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999175; cv=fail; b=mFE6biVFNXMd6XAzjIT0VuU8+7PO+fvyZrzI0HyvHjzStKwTmPd/TMUx64Gtw5uvb6volpxkTRNRuhSotvgN/bPnFFmrFq8lbtkSXa1Dx9LYUcvA62B9AgqGcj4xMLwVNUlz2sMQ082uliWX68TCyB9Rf0O+m+d415RS+BXMKag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999175; c=relaxed/simple;
	bh=IRgMHcPiJgVCYfK4JudWuWH2XTqvSSFUJ1ubpECtFVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rabojbJ9QSeEcREjhXoZ0gzH8/nx1fTeTNTTFw4DljgcZMiHmH9dH/XKRFW3AlZ3ivQm171KJbrRL1xnTGgo2JGLfBymbxaoLBqvBajrC0G74P1/sYJ7vlgyy6r6FUQiF5Rf3J9LJGoeiBbaiODUhlcrqVCfl6PMe+8xmeSf93Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGtg+vLK; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yNQ0uGYg reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBDcrW013723;
	Fri, 23 May 2025 11:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nPhfZd6EV3W0u2h+oDJhMpLfApmlcwtuT0NcxgNWt7E=; b=
	DGtg+vLKyOIp71kvL1fr0MbvIFGx+bT036mLDUTh6ejiMbi7FpgrSt0DiQROY/Bp
	fWUt1CFND+YIVDfxwncbhy0bb94Mqctu/Ad341rbGhk9gYlKjorHnqWpdDVxcYK4
	UH8jCVm6IUmjSpmLwinIPTA14tAkh5aCtE+kfBYmlfqFVxXFjJjfX3pw74MTpnBT
	6uLlbAWrHU/T6cO7S9O9plexm57QA8szQOoX9RgepdqLHFYG4CI3I/wMMjfYTqYI
	txT1skOA8d1EOTa5Nsvnm9qpEHz85oRfMuIruY+WOwF9Tog8BInFX2SabdSLi4I8
	B7pLEsyqEbnSqwlikwwv6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tpx8r3tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 11:19:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54NAV2Z7011335;
	Fri, 23 May 2025 11:19:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweqkcve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 11:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8WEO/W70qroAN83uT3RUG+vaou1DcEhpeGzfWiUMsoC45vqIe5t5EPxyj1qoRKBrburQV6btvkFe5gKuVMO2Hg5CY9w7+xT0TVa+P1LpeW+Yp9j7ToeCS8GdD0fBT0D6wzQG+KVYN6zwqRQPHke/r93OdYrNZBNqNu84dZ3ApzqbagYV6J6r8fjBLcBqOWZZ9t+e37+/sZ8vANs5mFWh9vP4sj/xxPkAYZJmwHPfpZLYDeQ6NySr18fokyexc6byIOPSD9niwnVzDn8asOqtdhMvMc2YPH/qWwNKZu+JQdtKwkpJeWwfoFL8OkbhKVzSXJfvuGmhtkntdUQ5q8lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNJ2NmAPAUuuk5U1bRz+vaarMvlhAHLVX0bK4ipOwgc=;
 b=WM3gq3Lf1NJp7Ip8mFRLgbwP698dZ/8v8155tncq96+SwxX4LsnzyWrnwmgaItQhMaDqcdSW8Jzazng8n+Gz+6x9exfK2GNbsv258tjRPpHktKJQ6X7OsUN83/nzPzj66Vb5ZZREnfnaBoojuooY/dqxwPlfS7ewkBbU1GLE10MAl39B/qepzuLiOia7bNIm5aKpw1wggFUcA88fspPUH5mcNo9CKfZ1zvarmEgbjPcrmJWPItPCKam9R9FDRojUxVSSe7Lm+6MzJgxwRSaCor+Z7JlxGvHQuxWV0d2wdNjDa2mGYWgqf1NCL0EuDyDqzPZw48527gNKl04XeqVe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNJ2NmAPAUuuk5U1bRz+vaarMvlhAHLVX0bK4ipOwgc=;
 b=yNQ0uGYgXPm59OnExCDaljxNLoNcSrnJ7vaOxBRdJ286VleDGhjIrjf9gdTWfvRZwlQ6jZcW/omvx+EwK+UGcOQHnbj4xb7W7/rWDbqYHqgOZYqeijcSC9WT1dh6+VK9NkmEOcpCbcD11UwkNgIgK10nXfjSpl+DW1ZozLZywIc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8185.namprd10.prod.outlook.com (2603:10b6:208:509::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Fri, 23 May
 2025 11:19:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 11:19:06 +0000
Date: Fri, 23 May 2025 12:19:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, revest@google.com,
        kernel-dev@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Message-ID: <0b2a5a80-0709-452f-9815-018cc1cd14fb@lucifer.local>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
 <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
 <87iklrbo8f.fsf@igalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87iklrbo8f.fsf@igalia.com>
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bbbe61-db26-44dd-aa3c-08dd99eba1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?BobR/lROnET+P8NLJyvoJXC7HuGw8UPMBD8zMgXesPiUyKmUp2xrHqzQBV?=
 =?iso-8859-1?Q?BlQNyV+KQ6xkyBCurgOh+39qw3WNLzrZjVgnsBzZv+Ef+VRCnkrlUfiDZa?=
 =?iso-8859-1?Q?TPxjhuUEaBmCzBH9TNEucrRNCjr76wJLIhwQXSDOmQnIESys+YBPW3yyBu?=
 =?iso-8859-1?Q?dLLh1l5Z0+Tss/2UiALrtpGHtbStPKylWQHg+n/HjmehVsIsU8Hq3AkT8s?=
 =?iso-8859-1?Q?1Ts36fwmO5O/eoa8Kp6Ld7DArW16gRbZyQwvD0ogIx5OXEorWrRe3ik5sp?=
 =?iso-8859-1?Q?+0jXVJiL/QvtGJihkQXGotrZmirm46RCoH6UwfHWfYU4+GcTWr84ZgN146?=
 =?iso-8859-1?Q?DcXHtgbD6fEV72pb1K/mvP9tLuMPRMXgBtMV7CSJQHAki1RYbQdxhUFKkR?=
 =?iso-8859-1?Q?DuioVDPM1xl0ulfaDFxdE3AQxzpwgBfijF4sO+8vTw7sG9xWHawv5hU5LC?=
 =?iso-8859-1?Q?kC/TJKKorH72jS9hJFKHOg0XEeGwRdynpItH6HQ0g720XEUdiXC8asUVjx?=
 =?iso-8859-1?Q?Q22EbgG4/nf7XUtcUOcrafecIHF0ExeDV+DcE3RmYBO7vYr4rP3Lu3UUF9?=
 =?iso-8859-1?Q?aUxc/Ty9QHqsGjebxfCTBFrR/JNpGVgBfNK1nh+ErwEdez0JZW1i+wS0ed?=
 =?iso-8859-1?Q?QCO3nIktR3DuAejEVYUin1bHyk9qafxQpdLonasDZLZEtlXGIjq6uVpVWP?=
 =?iso-8859-1?Q?tvwSfSQSVJNaDhBdvt/zSQ2mscjUxnzVfZtF/gP9j7gYAZpgkSWr5tEeR9?=
 =?iso-8859-1?Q?8/fiQi1TvWMnJ7RAvoIx0nJ3uy+zpgTroM0IwO+mwISLEP8WfrzSyVxhjN?=
 =?iso-8859-1?Q?ldpBdX3Z9bUtuxnQL5M1vKwkg6FSBKDSVojU6DROxxAQxu30S3T/P5qx+J?=
 =?iso-8859-1?Q?Hg6tlWPxa/1T+QXLGzaZyjowKsrD+SvFaGiCMiK9cBZ+gLwHER0gpfvqKh?=
 =?iso-8859-1?Q?k9DsHhX2ZfXOaFoIT5P7BpUQPYIw2Cr99IHB18s7uuTKBa7EOglutVYDJ8?=
 =?iso-8859-1?Q?y5a83yKt1N70/PC2vG2ThzPX6M4T5gUSM/Hv7Jb0ZWiX+rES4V6LRipoyT?=
 =?iso-8859-1?Q?NyjoisMwnAPgsg7PRAXEaiOm4+TUpxGWOrU8urkW0IAx+p/TOSM27IcFXt?=
 =?iso-8859-1?Q?sHPl5cApDJ4JjEh0Hc2mlHNatvQUcRT3qKkAEr15UlqhU1DJ5DANWslR0q?=
 =?iso-8859-1?Q?pKPmtPpYhJ2MThiFwYVWkSDMCF4BfvUgWPtqS6Qzav59/10olfCsenPiqo?=
 =?iso-8859-1?Q?swflXVatG5KTJzMHt3tbRGrbAsjHrXC+l06BnSjUXaBfnZJ+slGWPTzrvk?=
 =?iso-8859-1?Q?pq1I7BSuTPdTPMYvR5J4QrazqKguklwNwk/bQ49xutMEM1v9rowdfXmq6f?=
 =?iso-8859-1?Q?rKZJoQcdn+r/P3JDi6b/2zWmWBaCHnC2EMdK1w4IsCofPaYMxWfOnLnnME?=
 =?iso-8859-1?Q?0qaCZZmWu7sFbqYHYHnBJwDwljI4KOE7fYBNuR46zHy+UKwwHN0wG5nauw?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?gW9yAU2OpOo9stRppNeNukR8RZ5vxPla/csP8LtKLpo2eX6vxr/MyvEIZm?=
 =?iso-8859-1?Q?Ofv9KCvE9fN0zOzMkK1vkvdtyp/s2HPqA6Lm4FrCrupaEanCvD6VIwiDkk?=
 =?iso-8859-1?Q?aCz0bw5dcuCf57HjwQX+Sdp/+nEXljYynPreeX2aHHnQNxqmcYeuuClxAe?=
 =?iso-8859-1?Q?8DfJNiK4cb00L3e68ZyGSL3g5KtEVxms17TaHbT4n5wUsHkiLaj7N83MsS?=
 =?iso-8859-1?Q?8VY4p+8YhIwhvBJ9Ag9g2l/Xjz/S5iV+cg6Ag6yFol2C76AlPEe+eP+S6J?=
 =?iso-8859-1?Q?FCvQfgN1ROHKqp1YiV5jHhIKlQBt0fE96FnlbZH3w++/RdcRYQvOocKNxN?=
 =?iso-8859-1?Q?VwAeDl1R3EYg3pN3BBGHm94v1OFVXk1jOV1mWKMm2W6n/oBSba2nVGyt5H?=
 =?iso-8859-1?Q?M39X8vqPns6EaoEAZ1WeQDVkCTGyVLQ04uAI9NuOpO+m+MxD7bUDHOnxFB?=
 =?iso-8859-1?Q?jgqHbXqdnWR0NMQfh0IR9dY9vY+58aoQSpQlxOtenvEnBIZ5w5nSgtKEin?=
 =?iso-8859-1?Q?FDwy3AHKpvZ0z4hyF+CRGUenlvEJDw97qt6baX/MVSN1288MzOMF82jyjb?=
 =?iso-8859-1?Q?mp2KAHacGYfGo1P/TUXJB+oGyiSEID/hpBDnW7bBTRyRv7oKw42uagJh83?=
 =?iso-8859-1?Q?5ItvSufDAnSH6XJQVTaAwzNtbp1JZshPBIHGz+r8zWPW7ah5j1eIWG+e8r?=
 =?iso-8859-1?Q?xFBUNjAAn0DrgIR9gOWqakLILcBIEhQFnxQeivqyVdInJHoLYtbPH9Kas5?=
 =?iso-8859-1?Q?aXZGr25fFSKNNaU36b9+Ey0Esg6rVZdfC/NwhDkVyUzCx9m+6ZvJlEC0cQ?=
 =?iso-8859-1?Q?aKZtbOX8oQrtLuMjbo2DI548KWCWYPtzFzBRL510HZu6jwS0Gs2GjZBOPF?=
 =?iso-8859-1?Q?+0zc7byXFG+XRYl/lLTVtAmjp4UkPNqD0vdxzajx1MKVFOoKxtW3mIe017?=
 =?iso-8859-1?Q?dG2Zq90/aQuU2UAfupuzuhcXpgzyJkfq8UORFLgpq0DihwVbxy/HIqGHkS?=
 =?iso-8859-1?Q?SCGC7uY1HkO4fEv6HRhFA059FPPIkjBepZsfu522d4vb41MVSSKM5SS2G+?=
 =?iso-8859-1?Q?zAubyzei9wAQYcjwS3/+4aF/6oOYHeswfEQ0c0UEpPr8a416H8WNQYa6po?=
 =?iso-8859-1?Q?6LV2dCev+B0cK4SW8ylYTYEv7KS583qWFNiVp4GNgCItE4BGicLYuLhk37?=
 =?iso-8859-1?Q?+4RF5NnBxBz/43PVRs1vrZY46XXewQvLuOXCzZ3CS65njnSr6aRf3v18ew?=
 =?iso-8859-1?Q?E14U5oSmD65ZtLmdhfCyH9IOIxMXtgtd5myS9QQxZDY/46vLexogzfvIB6?=
 =?iso-8859-1?Q?Nhk6n4lclLrRD7PJObJXFS/JjGOebNEaVpBAu5pQmJCUMTsZEpHFIcZDsw?=
 =?iso-8859-1?Q?P1s2XEF4VPtwKp0bbaIut5fRVuke2a26Lo5hezpcIt5U56wNOhAX8XTA10?=
 =?iso-8859-1?Q?Qz/5JllnnWKWSuai/KL1XzfgZ0hqLUlV0aKsW0uuNiG/5m9utUs05XlHFy?=
 =?iso-8859-1?Q?rFbrJcIPP0YtzuDogHdl9qXs+Hf4nCSMwe7PsQQ7s+MBzNbpoTiQ0Zw2uU?=
 =?iso-8859-1?Q?wQJypwNMXHXPW0KQXuoCj1akoMFzt18v1JgdCXkH6Z1a7BxNMx49PauQw7?=
 =?iso-8859-1?Q?rO4qX0j6RgfSmdLYBUDKvlZuzyw6iVSgvVJm1qW9G9+Gmx1h5Oa+jkUQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FgVBJLnybEwYC0EjTGJt/EOC24Ah5x5Okl8rbu5xUyzRWlKW2ywKkEsps8Vh9t1+fzuh2jAvhHhe4UHl4JUH4JzFTpSXnwQbPM0XGyiVBgtlbeHMEM/wJEc/WZjEtK281keY18LFdxjTKqH7P/rlSV4iScr9scT0MLvqNpLCseCbFyFn+AvDvwZq+PnmYqYnmJeJ7WwHWjeT4UP2R526V2Ca97NsM3cdpFyDC3AL2XtlsWRZXH10BUd+VaRNwM5JqruDIV1BHsDJLiyhlnxZzox5IYJ+paLP3sy/G/nciK88alFA9Lka5AZUr9EqsKRVfTKaLcF4YoiHxQxNiS2JLz8jW4yUJ/1X2Csy484sdfwAtbYFvsPG5qOhi9TDCAMc7W2s9AOu4oCuwpxoqhC1jp7RlX/6rF9lC1nxwBw5mO6RW5m+skkn4aNmoABc6oqETBKX+s3gUMbJhCRTcLHgrIMnUFzw6ud7N/e22pYR6FPXsjeEKlE1OXd260l2knV1ERpIp55jw8mRTIkq6N9N50dsH4SFP/Vi81t1OL9xTBaiDS6lRvMnI9RLj7QU0q5tFr0T5ifWIuNDTL4WYQxPpQYkwG/TN34iI/E2M58I+2o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bbbe61-db26-44dd-aa3c-08dd99eba1bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:19:06.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd8ctCq7e6+teL/73H1t1D7IpI2OUcM95MB6WQpoC9EDlSCgDSgAlmBB9TohNvKYsr7ksXhMqP06eUYGCEmNl8I4cDH2IBFVeEUwmH1GK4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230099
X-Proofpoint-GUID: KKsQGcnlnNJ9G6JTjVCKHJi2U3uNN-xb
X-Authority-Analysis: v=2.4 cv=IssecK/g c=1 sm=1 tr=0 ts=683059af b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Dz3Odsm8meDqoBusy1oA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: KKsQGcnlnNJ9G6JTjVCKHJi2U3uNN-xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA5OSBTYWx0ZWRfXyEbM4L0avTmm ITRxs3nIq2WFFqhbaiB6kVXk3/+kHJJAL+CD4po8OHCXyu7NsaMetowqj5ivYFnPC9bpD4nlccx VUctL5nH/PvDGvJbd9eG1DWvhp4LcYfXP1omjw7IgYCkKOWYe9sqW3A2mG2FjBLZafUuob3sEPU
 8M+lQEhibwdHq62Zj0XUsQrZESwGiyG1xjjXxMUBkguNQERcXsheBV/hDAE5Rc76aIMbzokLrN7 s48TKycPxJ8peoTbe6BVLOyQ+wdq8zJKRJi+owX4QSyx+NjfKwIzyBehO004lWKgikmvLzPbY4H o9b2gypjxR9ActrB6dJEjEZTNQsQd/Kfm9Rro9qa48CryeH8KeAoZsz6d9ubJY2vUSttT/zSSVu
 nknWbxAsyWRE0ED59SWy/7K1ZsJcXl01wGdLhQTH9sUjRJISDo9rMkivIdgyeU8RYMC9P6mX

On Fri, May 23, 2025 at 12:44:32PM +0200, Ricardo Cañuelo Navarro wrote:
> Hi Lorenzo,
>
> Thanks for the in-depth review! answers below:
>
> On Fri, May 23 2025 at 11:00:40, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > OK so really it is _only_ when vma_link() fails?
>
> AFAICT yes, since copy_vma() only calls vma_close() if vma_link()
> fails. A failure in any of the other helpers in copy_vma() before it is
> handled by simply freeing the allocated resources.
>
> > Ordinarily 'private syzbot instance' makes me nervous, but you've made your case
> > here logically.
>
> I understand your qualms with that but, although that instance is mostly
> concerned with downstream code, in this case there's nothing unusual, as
> it was able to find the issue in mainline with a common reproducer. The
> closest public report I found was the one I linked in [3], although I
> couldn't reproduce the issue with the repro provided there.

Yeah as I said in this case we're good :)

The issue has really been instances where people are running modified copies
that are giving what appear to be spurious reports.

This is not the case here!

>
>
> > Hm, do we have a Fixes?
>
> I couldn't find a single commit to point as a "Fixes". The actual commit
> that introduces that close_vma() call there is
> 4080ef1579b2 ("mm: unconditionally close VMAs on error")
> although I wouldn't say that's the culprit. As you said, the problem
> with vma_close() seems to be more involved. If you want me to add that
> one in the "Fixes" tag so we can keep track of the context, let me know,
> that's fine by me.

Yeah, fair enough.

I don't think that commit is the culprit, as it still does essentially the same
logic, it just also updates vma->vm_ops to prevent any risk of double-closing.

I suspect this has been a 'long term' bug, but one again that really is unlikely
to be triggered in reality.

So probably no Fixes really makes sense here.

>
> > Why 6.12+? It seems this bug has been around for... a while.
>
> Because in stable versions lower than that (6.6) the code to patch is in
> mm/mmap.c instead, so I'd rather have this one merged first and then
> submit the appropriate backport for 6.6.

You can backport everything manually. Stable side of things won't affect this
being merged upstream.

Also you're going to (probably) hit merge conflicts anyway pre my refactoring of
mremap.c.

So if you feel this should get fixed everywhere, then you can always do # >=
5.4.293 or something and fix things up as you go with manual backports.

But again, I'm not sure this is really worth backporting _at all_ or at least
_that far back_ given how it is more or less impossible to hit in reality.

I think under the kind of memory pressure that would result in this bug (which
I'm not sure can even actually happen, unless a fatal signal arose at the same
time, perhaps), hugetlb reservation miscount would be the absolute least of your
concern.

So my recommendation would really to avoid a backport here,
>
> > Thanks for links, though it's better to please provide this information here
> > even if in succinct form. This is because commit messages are a permanent
> > record, and these links (other than lore) are ephemeral.
>
> True but, as you said, it's a bit of a pain to try to fit all the info
> in the commit message, and the repro will still be living somewhere else.

Right, but then we have more information. It's a trade-off obviously.

>
> > So, can we please copy/paste the splat from [1] and drop this link, maybe just
> > keep link [2] as it's not so important (I'm guessing this takes a while to repro
> > so the failure injection hits the right point?) and of course keep [3].
>
> Sure, I'll make the changes for v2. FWIW, in my tests the repro could
> trigger this in a matter of seconds.

Interesting :) I can't repro in qemu at least. I may be misconfiguring this
somehow, however.

>
> > So,
> >
> > Could you implement this slightly differently please? We're duplicating
> > this code now, so I think this should be in its own function with a copious
> > comment.
> >
> > Something like:
> >
> > static void fixup_hugetlb_reservations(struct vm_area_struct *vma)
> > {
> > 	if (is_vm_hugetlb_page(new_vma))
> > 		clear_vma_resv_huge_pages(new_vma);
> > }
> >
> > And call this from here and also in copy_vma_and_data().
> >
> > Could you also please update the comment in clear_vma_resv_huge_pages():
> >
> > /*
> >  * Reset and decrement one ref on hugepage private reservation.
> >  * Called with mm->mmap_lock writer semaphore held.
> >  * This function should be only used by move_vma() and operate on
> >  * same sized vma. It should never come here with last ref on the
> >  * reservation.
> >  */
> >
> > Drop the mention of the specific function (which is now wrong, but
> > mentioning _any_ function is asking for bit rot anyway) and replace with
> > something like 'This function should only be used by mremap and...'
>
> Ack, thanks for the suggestions!

Thanks again for reporting this :)

>
> Cheers,
> Ricardo

