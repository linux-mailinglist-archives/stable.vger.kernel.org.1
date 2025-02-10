Return-Path: <stable+bounces-114603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96846A2EF8C
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3723C166ADF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BA237717;
	Mon, 10 Feb 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrvd6kN5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zx5hVCXM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF959238724
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197201; cv=fail; b=NiuX+BWwIAhKha5MDxAk3QSy1/nGhRhpYJ5lqMpeQSJyvQsZpMhTkjn9Ae/HEhxgAPN00ZIeVuX6kMsZqsdajVvCTeQN0A6eYUhaBmsLt/eDtlfLVBtdgr7C8DR36Vv9PcOPrhYp1MFRNnf9jk9j7UI1UNzkZftaaSFm5/iW+hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197201; c=relaxed/simple;
	bh=v65v4Xr1RDFQGPrA5X1eraqKj9bYWgEyPHKVBZM1tko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LeCF788zTBQu9jjykWzUwpgsa+1UQZa3qYu2F1yv9sGHsZnfv0Ir6Bnt4MZ9jB1MMPNcj9un+qeaKssKxVW5u+TvNvOz0Mn0va6lT7iMXz/4pzElnEn6FbVt02jiEMJFfNjXezERHilVw/pW4o4glP4hDBQYkZEayAFSQ+e6DX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrvd6kN5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zx5hVCXM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7tpOQ006224;
	Mon, 10 Feb 2025 14:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vZWwHZGyoZB2l+LhJP
	XhmWhbk6avZprlF0GcL+Ggk40=; b=jrvd6kN5ggPcaTJrKnaYXcYhI+YBRoN6d+
	xg7QXFFBIQefIeKdYsmv0y9A3kfPuYtlD/vW/a/ch+NMO9cD4FM8jI1N0UcMLkyG
	ylkTOCI2w5khCg2NTOJ+/LeFSGYUtFurfq2RSlW2rZc/QlH/RyfzxBpO6wG9K03i
	3nmo2AW6/SqsGTEZJCYRgQJJi2pifH7bU2sza7a/6d4mZet0suWQWfZyqmUl6JJJ
	8no0mPoqoIxRwEmMrxP3Gf95k6+dCi0aHjOLUtuwkNja+9N71967eai8+8GqRwKe
	OHP+VdJOVb6/lkK3S0gPcVKSr5I6l+nmXTX7c3N4Kr77v/TDMBhw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s3u1d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:19:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ADV4Ce030546;
	Mon, 10 Feb 2025 14:19:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p62wwhbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jshYjTBcyb7lK7Evv/o0l6wJRVMvFEYgX/wCT1VvViU8hobE4nEaGlHpOk7pPypaaauap93SpCWcQeY709Zv3qJycjVShcXiF8khzKSpzotHiqnU6cZm8+okXUX8Lp6hl2Ko7+Ft2+XOYRsa1+tY2KCHa5O07X2bGTmdxnfrRLECPhy8fnWLM7NatRy8tYNgruVS8+7WkkpWcPTewTE9r0XAF4Ky0C28M5tM2WR/BbaJW5FkDuW+azaZy/YSaTRbMSr6QxeM13yiafYRmotLCAFn/rY+ByXHSJ1PdIYZaKMo1kskoYPqBDLgMiWoG6Vpls8m6/2Y5Dmwo6t1xbcF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZWwHZGyoZB2l+LhJPXhmWhbk6avZprlF0GcL+Ggk40=;
 b=YMNOuy0yQw/ZTn/XpD+v8WG3ifgxJJ9TMY+Po43N1ybcHIpgrDP6TV8ylHh+5MSiws8zIERovBecJDpB0fOgC6/nTqU86OTv5MKgjCBgfEaPtcfoGLgTss9FIKCH3di13/qT0cmxQCOrDBMQifec20ryPBImIj6ZQ01f60Vi2jUF2EQ4ExIxdWCz6AkS0ntyJak+FUHyCGk6hzx6u+rrMJRT+Gp7CfAVAkGJOr6391Yfpnz6UNlXKNasStAv7xdP7M+VpYcnKEGod40u1Ej8AgokWos/0nHXCwiKrFRjy3cs40884eGkAJLzLa2u+IyqtlVpDfcoyXn2FLNVcPB2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZWwHZGyoZB2l+LhJPXhmWhbk6avZprlF0GcL+Ggk40=;
 b=Zx5hVCXM+t4U5GUsvbVt6uq4gGwyv5BiTxFCumY0k60EaorrrM7lK5YpQjYTgvSyGZ94JL53saRydaqWpq35zbA5egL5K9ONmXSzfItimtXURo1E5mDWzuePTJU7Kcx8mnKHTxhvzAvR98b7tPzQZNWGfG6qtPk9vjhMRYvp0LE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 14:19:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:19:48 +0000
Date: Mon, 10 Feb 2025 09:19:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] maple_tree: may miss to set node dead on destroy
Message-ID: <42meyihs3gnp3bbvn5o76tzh6h2txwquqdfur5yfpfu36gapha@rtb73qgdvfag>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
 <20250208011852.31434-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208011852.31434-2-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0420.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: f454318e-3113-4c15-209c-08dd49ddf9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JaV/eDK09Lz9LEy2mDha0AAtciRGkG/P2uR0OSvga5HTv35J7LYpLQ+cvGQ?=
 =?us-ascii?Q?CAn1gzI5Z6yfQR2iGwpSDnSJNa87s5MXg6AtRXpNTswOQJcZNTiyGI5hyqEa?=
 =?us-ascii?Q?5NiFsB13jmURW0Q8s6mNtubQHa7rR/FpCPsZ5htQQdVM6JXi3FY1efUp6HFs?=
 =?us-ascii?Q?lgYfGiaJu2RF/pvf4NCT6VqLcs1UJGY2tiCbCraL1jaT1NftzUvBMRAOHUsS?=
 =?us-ascii?Q?6eVc3NgllMTFH80WbW0sUFJpABixmMvBeF8yUPcrJOslIzrUr3QGV0bl70w5?=
 =?us-ascii?Q?3o6lyU80NehXcb83CkssLptGpKB2r86hJmonzvwUx4XsHinLFAkjAPEN1UqP?=
 =?us-ascii?Q?HhAxnOGR/1fwFzLyPakjMIV+34dX2L1cAYpqYDDWjqMqGfWoTdEv5BGaomCo?=
 =?us-ascii?Q?FWe0iQwqiJiUGKaQ2gashRR59mpNbZoRZMfcFJvOjBhNK09nA+HYCETTdpwj?=
 =?us-ascii?Q?Kn4RlVc1NWziSkqwLxibvPFiPwdEhhTFXlhMwDeWAC+ssXH39jV0uytj777J?=
 =?us-ascii?Q?zkJY27OQCKlO7+Vf7N356CCULxp+CIUhhWUQLXY45VC1fzwDLfWmoUoOccSI?=
 =?us-ascii?Q?L7owxJsW12qchcwtuJYkhcdvTLb1CJ4OY6sAUQeG/Rh0H1fovJaiqIyT40OU?=
 =?us-ascii?Q?Ysf1Vh4zHVopYKxWmBeV9/mTQcgFBKs+PA5bca84QpCKse1weh0enLKBctyF?=
 =?us-ascii?Q?e5xD9mFPkloZ9fj3quG1y2YPX7bpLvdI9ecxJFOCcfUoEf1EZ4wLZEm1Bo/y?=
 =?us-ascii?Q?ZdJZYEo5msLvcC0h3fXXFlAEXuAiwGZFUKov8E99RMlQ4MRPMzCVKQOJBqXT?=
 =?us-ascii?Q?/DNVR4AS+Cqmh4AaE0CwBNKsXqLORDbaelbJhS3Bnn6FiZkIt40xJj6kdMQ5?=
 =?us-ascii?Q?gk0NRIMz5nxlP55NUz8yb/5lPBq9gLP5pMVpA879n3dLNfjWhGmB1feW0tKs?=
 =?us-ascii?Q?SOGMZ6AKn6R/V7q0McZchz3GpGi1L58rYz2SmkzPUy3SHA6tT4yJnWBYQ5dP?=
 =?us-ascii?Q?a/4x51WNC3Aj15VQlkU3qmpLBIRB04pDUnJ3gm64/QgMrSvasC6OvkFH4DYQ?=
 =?us-ascii?Q?MSh8RaNLhI5W+hP94+6cQq+0VIYuMrBgMNKZpjyVijvHgKXolU+MGONUn7Mq?=
 =?us-ascii?Q?bc3yz2b+gCoBgoDyYdSP0Yd2/yvqS6FaF/f62SA7anhBNQhGhPbKn4YEQCar?=
 =?us-ascii?Q?Zon+qBRPQ65lo5LzsjnXuOIMbwWqjWLFX3grao/23N6zQguLQWyLCc9OyiSj?=
 =?us-ascii?Q?1DsKRrbtCWipRRjR2PgHWWMaSkPbyPP8qmS3dyovh0ho6kLoULQApae4DuXr?=
 =?us-ascii?Q?mbPNkQTN6imD70sKHtddAbwv2+9YRFsp+QSpg/X/IHuBIqCyzc91p1U8SM0C?=
 =?us-ascii?Q?W/Fd58EYhtmB4HlkzVe5++/wDoOp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PP+Yzn6p0iEO7e2ah9BkQLwHADVNqBs3348ZWV6JvhnTiiM4hLeKjCNbmMww?=
 =?us-ascii?Q?dIXZEjfh5gULk3oEG5ffqyVX3deOTUaZ+32p+O3qihw7Doi925cGtD0IjO3G?=
 =?us-ascii?Q?u2+7T7LENp8dR1BKhemCMqeJsfEF3I0NXrci+xFyeDDpvEO/UiNVyVgNfpVD?=
 =?us-ascii?Q?MhU3LUyy9RaxX0jZXLrgQ2T8Jh5W6fLmwEqTetbvUpaPQfku+XVwFOgVk8sY?=
 =?us-ascii?Q?PMZNLqineLUPf76ZxbngW5gtidEDc4Boo4L48LDBXfzcp6CKKdJ79b0nR5+7?=
 =?us-ascii?Q?LTAZrhKmILmaLeHv2z5MXGH0/DGx/q2VUs40K8ORyQ6Mg5lwfjO5a9ffR2lB?=
 =?us-ascii?Q?gV4e/aSGTbInQ5XOKXV21M1SDd3JL+zUGrDGoMO0wV9LayMxmmeBkd+izBKP?=
 =?us-ascii?Q?F01InkENKfQMzZNXNEzh9qbkf5IQTZFsRh6lD2K2fuVVsJO/wi5+bvLO6YD2?=
 =?us-ascii?Q?BXqhc3M30E+AoqKyxYoCm+PzcPB2D8BjLw/p4SneGvHvQGAQZW4W0cfuzwIg?=
 =?us-ascii?Q?4vVsYvfpGQY8rJvETayizBBQzoH30/d73tiZGSu1bnU0mgEhaYVbAGukUDde?=
 =?us-ascii?Q?0N1hSDbf0rzxLYz3hUvuupnzY7nDvW/wq7wb6yyLSnZghGB5XCbO+nh6MNIB?=
 =?us-ascii?Q?kFqMWKXNqAlI2zfvV2YdW39dRfLwlRxV+9ER3djFc9n9LKCIe52+S9sRsrAd?=
 =?us-ascii?Q?hxHOjaFaC8ZhIcoB6qMDSVPWMT++zNhF5aadRpUOVslcSKpdpg52fUEj6H9L?=
 =?us-ascii?Q?1tPeh+5E2b7slM3aEC1M6GIJk9IDj2tEkD3eQO62baXz37vfs0nErZWTqOUv?=
 =?us-ascii?Q?g0Tyh/S+2lQ1yDzQKAgX/jgH26/JYBEi3Qkk1fp2Vq21DjepswB3eESohbgA?=
 =?us-ascii?Q?cky4ov31RSQW8mgZztZ98S105ADXH9lUvdrVWtRDJ1jK4ijHYJVCcerVFVQU?=
 =?us-ascii?Q?oRupl3dpd7Lk8UDGwiNB2s3dpcDKkBaoHYNQ+UDYTmM0mUQH8l23eeVyKpgU?=
 =?us-ascii?Q?Janvt/v5oV4VawrSnZOU5DFAabWjQkgqVdjvdA0QNyk/Q691+0BKEA9o7xMU?=
 =?us-ascii?Q?+p4FoqfOD3WdtpegSECjE8j/+8GCtg/hp7q8h+iur7orI5qS8qBzv0UutCh6?=
 =?us-ascii?Q?28VcE1woIv5fEx5njkdOJCl8pDVvpqKloimX+YFeIlEqHSQok75dBDDx4Ia7?=
 =?us-ascii?Q?uIoTayt8OCha3u7sbmUS2Sn/VviCApeDHcfmYh0SSw4IX8zNbM0gRMwkKOV8?=
 =?us-ascii?Q?spAvImj45PKEXQUQvsg7Y/YwWBCjSZ6ky4tc7ZxvWN0X1cx5djateeEDoYUL?=
 =?us-ascii?Q?Wzb5mHTMyPmnhgLT5SALw3uzOdSAaFOTvz+nvOWUvlCH/YxRKfi3Q7CvCgEP?=
 =?us-ascii?Q?MS2B9X6qWbMdBY3OIjIwQ80Oz/j33Y9aZivFxzacUNziVWtvs51iQDAIYr6x?=
 =?us-ascii?Q?0/HbwJ9oL4EGi8oq/8+BFvbIs4FK2B0coaaG9ZnOGuxT6aZA5GS3O29vuX3H?=
 =?us-ascii?Q?ywjUNtCy2U/NjGM+IKoLMH419saC2BVA9WdBjzRxDWZwxe3SC82pmJWqRuTB?=
 =?us-ascii?Q?U3lVV95X4HEXvBv8uYudP14F3M9ATJMoTym2xSOu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5EGO7epa4znZcn4wWD3DIu5K6yN0icML8QfXtK0UDL8uK9to4//tD1PHDe9sdON5z7CgHXWO9PcRQRLzwj4dOgfEKzbFe3g5xBTAeGUiBHQL9RHBt0WtiyZruWAhCAX8pMvy5X5LoCRxDBDJLzSMhroZmbbtxkcwJ0j/qNo4kFLJg8Jf1oqtZLs4MOkFpX/QjXJngM3HVDA4yqzZf7nGDUgO/atgN6chmXr0jHRNF2LTZhQhhVcH/t+xMozLABS32FCdZoWZtAL14y+v+ZC7T9c6zbITvjsXYEneBXphhH3Qb5zM513XzPDjbAYtKyC28obR8yR8S4Wd3zYeFXQUR+uE3pULTOMF+pPWD5zu0Uyh5kO4D/4MZT3jY6UWmdtTKGdgpfqz4Mr+bhkT7oGjZdGw5sUWEJ+1vxXh66nWNLHrQic3rWZ55F0YFxVXGFOLMshVJ9Yr/sc/4GQJJc6njzsqvgIwK7vsEIUSbB/FVelh9UWTbQPTt1q1HD6y6vGwhqvrx8gB8nzALaF8Rb1DPuIrb09jc4gTC6iu3P8Qu74bvupeWIse9F35zmWYLANnlgi0jd7CCeOTWK4MhfGHGygNCVjQLlDX3duAWTHxCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f454318e-3113-4c15-209c-08dd49ddf9ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:19:48.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB/b3WXFqG8cxWddZIR/LYg59h3hW/5Y81DzjKYY+zKU7Sf/vz5bk4k3Ndt4zsXavPov2SqvJ38DQMtYw8Egaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100119
X-Proofpoint-GUID: jsaz7kTeVLZLfEuBnuOmsxO-QbIdORzM
X-Proofpoint-ORIG-GUID: jsaz7kTeVLZLfEuBnuOmsxO-QbIdORzM

* Wei Yang <richard.weiyang@gmail.com> [250207 20:26]:
> On destroy, we should set each node dead. But current code miss this
> when the maple tree has only the root node.
> 
> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
> node dead, but this is skipped since the only root node is a leaf.
> 
> This patch fixes this by setting the root dead before mt_destroy_walk().
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  lib/maple_tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 198c14dd3377..d31f0a2858f7 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5347,6 +5347,8 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>  {
>  	struct maple_node *node = mte_to_node(enode);
>  
> +	mte_set_node_dead(enode);
> +

This belongs in mt_destroy_walk().

>  	if (mt_in_rcu(mt)) {
>  		mt_destroy_walk(enode, mt, false);
>  		call_rcu(&node->rcu, mt_free_walk);
> -- 
> 2.34.1
> 

