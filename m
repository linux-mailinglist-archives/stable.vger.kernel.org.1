Return-Path: <stable+bounces-114604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB9A2EF97
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E71888EEB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E042397A4;
	Mon, 10 Feb 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKQbzT/l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O2ljDnmV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08E252919
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197263; cv=fail; b=tUcGaL5H8qQO2d1zWdyAZ+5bKRtLb8GmslmCifOofuFvCl1YCltsf9g7wYsynkB416oHmjhJu7BEnIswKwz9cDFbLxznL8Koh1gkgfqarGF5OBZRKQCcIAM75qMfXI3HH34zvgGBNHeH5Op5rNp05BgLKRW8VkW47qO+XoTN+/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197263; c=relaxed/simple;
	bh=wXMQYhf1diXCvwbd8+yCnklU9VUpNjNNakm2rGaI04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOCXAz6eGL6NaL4m9v2dhVM8Ko9PElUtpSJHzd2ELLDXA7wER8Y3yt1IvtYiLy3F/9OOZJ22dDa0ICrHlBWkukbrOm6EFOf4ehAenwMi7ssByHOwiITGDB0cpckrNtj3Q4a1Qp6vYLKqGc9IyiNlgXxRYEYbyg/vHKYTsaityWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XKQbzT/l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2ljDnmV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7tX51027437;
	Mon, 10 Feb 2025 14:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Br/fq+0CZd21Z6Kf+9
	NIOdSC07QVfoN83z0Lum/uvWc=; b=XKQbzT/lAnkhAXLFX2n8Nv7S/a2urPn2yh
	EbQ5uwj6GT8pWTnddnzsBMrudSHwAk+enlnFyHb8h4UdtQSiqKBC7SYlsiXRClVt
	ISbWeuDiCtr+EdII3dw1RUN4mR5jLupTBfeV9YQ25UByC5G4Dw+oLf2NBw+1U1Yq
	6kmJIK6SPAGoblwmRDFTVVK4BGMlM6gbN03E+v3ZyWAIRS8Qk9YW7ks3pF+o5Eys
	Ma5y39t5HiB3pxqNjLD3ykeJDHosQkROyuBtkiNbgCly5kyXEBt/U7jJpb9OLDIb
	q9luqe+BAdGfQsdjZ/LHL6hibY95JbojGTdescADPqkWMTCUQYXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg3180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:20:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AE9ILp002589;
	Mon, 10 Feb 2025 14:20:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7eyyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4JUSUB80dYVgLZ3Hop8zwm6vevZc5bl7nlZx7A+cVeBsNW4KXdlLxbELv+Co0yHfTc43nK7oWuiWrzLrBOQ6mOFYiiIGN8QhSPERmVoaXZ1M5Vf5gU/PdzvLMW/INC1StuckRElbKg170R1SAl35/TWH5ap1XFf2RK08u3wY4XCdsajGxD8RAVBbNeiNRU+y8p7v45C1XHAmIbwJFcYROSlybQ4BLEkibB9X9xPJEw3GvROAMhjLHE3JGXYxh2Nqbj3mJ7kWvGP7RdrwpjV0L38CAnbaQZvN7rcgo/WjwZxg6UZzgWlc8j25Y9jJWc993AfnXotkyVntOXOprq7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br/fq+0CZd21Z6Kf+9NIOdSC07QVfoN83z0Lum/uvWc=;
 b=jOMxSOu2sMwTITSe8G3yTr5u7/gvCdD+KE7l+gN8ta7FSVtCgtbApzd7yELFOESEWU6iqRLJFu+g0+UIXQawpdSc7Wi30evMc+tLwKEZHY6JTt9gnNWt4p3+9E71/UAVmxv3eG1vs30pRYpQHhndqv2q9uroG0p0Z/R04NX3ukYN6mc/suHYxtS/zgkl+R3bfo0nK9WU2QcZpTCAF0ryWY/jt+1z4Y2lfgHmze5hQ4HTfuH1eRV57Fk+03AoJYhXOaTcFVQY90YB1avjzeDecMNWUTABlxZrDy2Q4ZJH/4pJpz5/m3sWn+uOEQpUEEQitTqCIG1qBuAs1QRsFg2w8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br/fq+0CZd21Z6Kf+9NIOdSC07QVfoN83z0Lum/uvWc=;
 b=O2ljDnmVWYotPa/Up2qpIvlVCFtdffnKe1hPO9D2fXspAcbh1WiWjn+ghNBr9kfoKPzp9VU4TV/FjHddDVH+iOx8WMjrbx1NCeV9wm+Hhcbwz4lbv37kCsODhUxYR2fmAdztUk2iiH0JQ2p3lqZoOUbxSSueIoTWb+91QvHp2Po=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:20:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:20:48 +0000
Date: Mon, 10 Feb 2025 09:20:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] maple_tree: restart walk on correct status
Message-ID: <eocka6tfszyzfbokaolwkwp7sxec6r7siuxhjydvwwf7lxxadl@gu6ekt26h4pe>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
 <20250208011852.31434-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208011852.31434-3-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: e222263f-cf05-4f51-97fb-08dd49de1db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWu5wtfm6L7uhus/FmcHXSmIpnjhXkO+79/AdJo4IQzNVCiPFoTAk+UHTzEv?=
 =?us-ascii?Q?JsE4kQTaek+88Q0P23W9wo9x+00KQDiALxyZUnIh48kQW9jJauotw23D2Mqk?=
 =?us-ascii?Q?zois+8vLi1i197vC+J7r2kFEH0bCvqwbadJwd0/OJUKMVVFwI5meAfVoqp0T?=
 =?us-ascii?Q?fbz7eggqHBncyUveRQuMx2LUFHo/w1X5q74xHGLQxrUBuTleV+QgCU8rYSl1?=
 =?us-ascii?Q?UcuWxJQaG9G9nTmA8afwcCL5Rk9Q8R48LOn8y8CkZRwPFPIqWa3dDJf9rq6/?=
 =?us-ascii?Q?YY74t9UlLYqHIUhOIqJuebaMpUwUWWuwdmKbgkJHpGNX7ujJDugtj77U5CWW?=
 =?us-ascii?Q?wdlGWZiRxXapAdpgvTwnrzWUThN3YbMNS7P7AkAnYafebirKoKgqnMGj0YKO?=
 =?us-ascii?Q?JfO2X+JgJZeado9Yv+anaZ8JTthgFlrKTfgV9ubHBxKBW+wUnFdKn3EeIGj+?=
 =?us-ascii?Q?qm0kGEfYBIi00sZhiOBoznYRVtnJMYzyd5BxqVAAqBiZofBH5ugs4n1kHvgK?=
 =?us-ascii?Q?vitPlEzMaH+c9UM7mFOon59g2hyE3LDWkSoRf2eKQ+zFvrJXy1OIcJW6QDjy?=
 =?us-ascii?Q?uAUhnmXgYUhHxG0AkANqOqlfXoUwCDf8U3mUg+VPDbo8ObcjOIA4abrNJLZb?=
 =?us-ascii?Q?ce0ED6SU1lhMFA0WWtdPJjpysoKtRnhiBybhQDjBUv8uTiTMTgk42FRUPQlA?=
 =?us-ascii?Q?cy4tJjtNym6P3fYXxeHgvfamixzCRRBNlP44gKNwfCkCUu1lEp1Y4D+dHQB/?=
 =?us-ascii?Q?x+3O9uAR6JeaVOIrLTCdHDoITdJ4SqcRUGePAaX0NCCU/WaWB9CDzTULwWi6?=
 =?us-ascii?Q?UBU/EsTkHcgD2+69K+5Ni3KW2BIcNr6Ccxb7e2ZB+1GaLAehEC0oIsDonY+p?=
 =?us-ascii?Q?SS7gYe5QFCh4+45LWI1tCOVOOUwZ43cqB0LOWsF32h5bBoNvNEypz8onrxs6?=
 =?us-ascii?Q?RkLADkBdAL80j1OpAV1V2zsGClxHrvnDJcWL6WOtjQiSIJDmSTYHNZRETqTD?=
 =?us-ascii?Q?DiRv4U+gHi1Y1nYT3wWpXmtB1z9YDApvhAWMwVEz+blU6SpM4Ksw8syQPLk2?=
 =?us-ascii?Q?xOZjB6hSR6MOOrzTdnzXcZYT1gpTpMs5Fe+ZZ7uKLDq6EP8O6kKFVyWE0BYo?=
 =?us-ascii?Q?VHjgYzu12CvJ8q9G8PcPhdsQlEvRXhOF2y3x1cNdIDNWaJT+HJaQyPbHjDPh?=
 =?us-ascii?Q?FZD5mFLjkMIy+ZX/c/WRJd3nwwPlSXQx1UJdtbino0Gvr02drCHVvIwnJnug?=
 =?us-ascii?Q?bh7SBHSxZl4txdLSQq70C8XFp6+N8C0QnVDM1o2Ml0127wOWhsloa+4x8WmZ?=
 =?us-ascii?Q?JG3/YgGOFh5wDDY1n7I4h8sVErvZNWWD4Vqx8VcMozznnJjM1ZvMqL2noeBR?=
 =?us-ascii?Q?iheQoIAAHcmOR37pmqTNeWHhRigs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFnumGC/4RTr5ivaAROCltFHyAG4XOxzytuyPu+KylSrB0agAQ6OOW1NZGER?=
 =?us-ascii?Q?d6/Bl8oZboRHpQq00mwFRFunQo7B6BbxRkUQcXaGALVIZKxrZUOzvlgsPR/B?=
 =?us-ascii?Q?qK4TKtht1jnJ90t225mLHr4pPXiUQrpDgE8rLgJgDYFkZ1ti83QCScoERbU0?=
 =?us-ascii?Q?zWx+LPpGQjZ0nS6JtQabPRTSvAwiFRGsnxIMcuzmDO4y5jgDHsYJAXN9UjLL?=
 =?us-ascii?Q?P4Hb6K6gS9Cp20eGuBiJoOQYvPmIXo44XtcvxTTWsItLXN+AYWfU4RyfSfMZ?=
 =?us-ascii?Q?iW1qvhhpOGafhb8ZTpiHvaaCd2gZyA5otFFk+q5PB3LPXuGlb/iTv3ws9aht?=
 =?us-ascii?Q?0xT6/A0mMNvlm9ZGSCAxU5aZIb07LySrOUN08h5GBFUwQjFoDycj04QB05N9?=
 =?us-ascii?Q?pUaPZMWWGLX59E0NjEtrJHMzN9WVmYalEIzs4Q/BkHpxeR6+2tDicMQqPxv7?=
 =?us-ascii?Q?BxT2UBGZttRZFb7WZZr/hd4whX52w1ToH2omhqRJicGQS+OSFq3P+4wAbGrZ?=
 =?us-ascii?Q?XaIGJchrXv4NBNCWiDzib1qLAkl/1Ky9MmmBGmW9eWUjac9rt8Ojom7BRTar?=
 =?us-ascii?Q?pt6hNy+sE+0zY8RP3WpkZIo3UqkFrnuMjObySmAdXkUdu7M4EO8ukwPmTTJk?=
 =?us-ascii?Q?uZlSEDeqsNC2pJLbNylD/QaG+kOWh2pEC7gkhoLPpBmVTIJjL+LQGk/7dU9N?=
 =?us-ascii?Q?VvT6hyPKSMFU2SH5VR8YLIGBrJssxJoVuPeaV2exSKvqNAEHd6sYKcNUklTT?=
 =?us-ascii?Q?aa1dp7sabHo90g+hbGQSvft8WDZTdDLih5Sq7ZLcIUgOXSmA88O1+8xtmYSa?=
 =?us-ascii?Q?OIcPAvzwgUGTPFv2jv+nfXhl2hezx2jrY2a18D/yQgXUTqo36AUe0iSsat2a?=
 =?us-ascii?Q?GqFPLCsy1a/uyApTo8JWBtTbRUjyBRimnDySilIULceFwpRnZSxnvOa1ZEFy?=
 =?us-ascii?Q?8q6UJZ6A29HrTt9VDnp2+nelOKuRmMrisItvNHofh7AgexIoASHFfygCKMlJ?=
 =?us-ascii?Q?VP7HyDoqTFhvjhbbVug23nbf3e0iRHTceogRof7qINLX46ObUp1JaDwp3wX0?=
 =?us-ascii?Q?LczmVYNjIxYMmmwVm1bmjui0CVtc7heTwlD815rOBoGPQ6CLZPDJYqDhf9dV?=
 =?us-ascii?Q?Dph28a14A14lNln2C5tgrU8cpg/Bbt2yKvtzfZejAkR5yEwxz84jsfaBdOvK?=
 =?us-ascii?Q?z75QHpgQw9MBYdzETb6KM6a1OPDZuAMZYSMjcvBbfdyQzVMm4BSVablgOkUf?=
 =?us-ascii?Q?ZsXO60R85pLmXHf88oON2SM9NelWM7KQiy1OtVmR7irohyCcppaktTNSA60v?=
 =?us-ascii?Q?ErtsfyQOxWyt2YCZlpuo4KM8US9NaFoWfPsHgkMgTikTGfvRn4DSZTfKIcto?=
 =?us-ascii?Q?MxPm7PPCE6GJCt/szS3Wopeycz/16c3e7T7YZ6NV5qqG3KU77OVjlmgSRkyS?=
 =?us-ascii?Q?B5OLq+T1U5p208bykaws8EcOBdbjvx7g4KCHrvjipnj9/ObyH/eIkhRbRwhN?=
 =?us-ascii?Q?jfIvrCVXDa9O2R3A8+xWfiFi+fVT8lSKRYF7zZaR8nIzSTGsLrZlFheB+cEq?=
 =?us-ascii?Q?ar/7Epm1X+UjWKnJ584sj6eXq76oKxlBiXuRWMNN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VXyejGA44uPdup075RnR8ExDJHlxmudBnEcvtxQvBNDNrWNHKB/b2LTwYhMwS4WSKEZccDneZSUfy6M6PIZzBit21cYJmWsMq8SaftZWIKsWZM8bCP4Qiin62O9ZGmSZIUjPEv2/S/klf4EgDkIViwVLIGhTgqfTbO/J6EYpg5Dmh08PGOh7aMCTMwEDHa4MgCcJ84dq/uFZHTVVagUi47Aqmirn23RtndASx+SO9uVTTvSrm5ZKYDFQJ9il0bHtr5c+wI4me8xlV2XaVufGnXosc5EnCL0C12R7v+s+VahyOxxmnBd+MyVg4LRDBPtNta8xsSIjMxMIvLBAOaWVF/YDEsgTtrQDn4zCF9etQ5ZTSg01OkA2iqcoBVTzlsAZ28kmYwSN5O/JHP7LowwCP5CF7EgzMFdvUoJpfxOxPfz5voLDnpnlzfUUF51A3LAlsCEXfGUpLFjCW9GPvYaZqNzwIAhevKZJsK4ZKU4f6d0+Pyg18VjwYv8qY44MyyLxAd3Zs+Tj7LHjrqjXBxib0p9l8SiiDvFNJlFbx075N1nVamyyK3Vqo8wQ7jC6NzuO72E6a3oAvM7XU/Xqkl0Wd84HlJjk8ZEaTzvf1OhR20M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e222263f-cf05-4f51-97fb-08dd49de1db0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:20:48.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTOR8RY+dN7qncNGJgGOoA2EfVNt3Lxq2LWg9UmXG064drwGkGPxha21F35mAwRe5Qi2KJEPcFW5IRJNdAyEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100119
X-Proofpoint-GUID: bUfr206tLJyZMqie0onuC77XcN7J4Awq
X-Proofpoint-ORIG-GUID: bUfr206tLJyZMqie0onuC77XcN7J4Awq

* Wei Yang <richard.weiyang@gmail.com> [250207 20:26]:
> Commit a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW
> states") adds more status during maple tree walk. But it introduce a
> typo on the status check during walk.
> 
> It expects to mean neither active nor start, we would restart the walk,
> while current code means we would always restart the walk.
> 
> Fixes: a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> CC: <stable@vger.kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d31f0a2858f7..e64ffa5b9970 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4899,7 +4899,7 @@ void *mas_walk(struct ma_state *mas)
>  {
>  	void *entry;
>  
> -	if (!mas_is_active(mas) || !mas_is_start(mas))
> +	if (!mas_is_active(mas) && !mas_is_start(mas))
>  		mas->status = ma_start;
>  retry:
>  	entry = mas_state_walk(mas);
> -- 
> 2.34.1
> 

