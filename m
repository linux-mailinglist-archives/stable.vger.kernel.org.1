Return-Path: <stable+bounces-110863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D329A1D5C6
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC501885E8C
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E91FECBA;
	Mon, 27 Jan 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1VMp8My";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MPTdlHR8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F81FC107
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737979716; cv=fail; b=Y1sPrUvaTHRSNZB0NnFewDs/v3B/PLiVmfa0kdU5b8ygnbD3kNJM9bdXa69yY+EzQh2XFReCK/UAFBnDoOZSS3wE9GPFQjibDYTHehgej/vIZLCMbDNZIpxJjbn7+m92QC2ZzubnHyGeFhbUV/gvYg/6+Hsde0CvrxlAwCPEf8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737979716; c=relaxed/simple;
	bh=cWwCHyY0//3qJCDLGFUXluauPPLG9FZpqsY5lk3ud8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl4iGIT6+dCIF/1oMQsUiqRsXIne9fZ1hD90c+V6b8QQn1NUxWmBwLdcXN+XbhFvzisJ02AByagtQ8ASErDnvWc0fZw93nBX+htnkLoyz9SOiF+Cu0oxc7mWOTXu4rIObZmGd77iGTaZf0VViQ5ypb1Szi92Oa42zjpkzf+rrfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B1VMp8My; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MPTdlHR8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RA2HDj005646;
	Mon, 27 Jan 2025 12:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x34uNIhUSnjcVSYlWT
	eXKKz53VecDcyQvebUUgTZA+c=; b=B1VMp8MysXlUUtn1EfG1lmpbUHCqxKvJyq
	X4ZXSauGmrUji5/lynJHiigDE9dwD2kb90dwjBv1o3Tnsbnmj7yw1l6bNicLMtfn
	jnDnJ1qwvFRplyP67LtHdt3+XtjBg3CQdvro8p75J3MnwD8CUy5VC20TLCya1Dvp
	cBaJmHhf4oha9tuD/JIi/N9EipS/du0rO88cEzBzjB3SaarHDUXN+kNIzQXkFv8d
	IgGjcmEwAizvnAnCsGZ1mZ3xesQcD4HR3w5vPjd/y4EU/7z2Hy17mJyh2q6cEeY1
	zElFEfNJyscoEzEK+Pd10u9uSU37ERjvlwuHrME7hNntb2F6stvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cqjsjnc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 12:08:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RC7kwt024257;
	Mon, 27 Jan 2025 12:08:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6vq54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 12:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOwGlAFLkXFm/bbaD1w7X7n8ihWBcNguaiDqqd2/Hf/9bQKNy0YfofQd7TxzvhiMAJsBOkq0cH9n1lsW1CtTYjmAwpkeGNTLYh7c66uwuGgNe/i8my/B74J8R+in5q34MTfh6gDgzt2FIkmDvOSm4qcBXdjt+tjvo7oOTdvDu1h51ehqrWgj4cWNnZlqB6EXm5TaimoF96n7JdOmTFl+KNNw4OzoD94b1I1ImHr37zfx6ZZoVDoqiBbV5I70GxZIaAQ1ubZHn6Eb6iNpmhDVmCUZ9V7j8q04lQjwDPUPXsJ9g35Fh+oVKV0hisUl/hb89rWPzPMvfqdxUEq74PW3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x34uNIhUSnjcVSYlWTeXKKz53VecDcyQvebUUgTZA+c=;
 b=XgmCnPNvV9d4M5ZOANEcg9X5zGqS8ByQghcV6uOSUyD4l592843rKEytDcW7xN+MKhF52fJiHm/NIkPpoGAEoVIE0RmZfxvKI5hVDw1ltIPqxk9MQE9XJUD4TY2NOkb5KD29Nsus5s1JIVAXSp52IQaA9KsKLQwFlrZ4TkRDhCoTgXbZzUJF/ZbieZ+reuzhYORNC2Af48tv7+1E6Z9o1TpuNZDfWzYBEJeQP6SKMpiOhn4ihCzFQYe+tvzJNE0hJC8elrZNPoMH9PX/tvAzU0WonPCR7WaLViT0m6wGe6eC35+cW5jk/hXUd4+ErfVITpK/gYgKXZ4Jvug6Za1hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x34uNIhUSnjcVSYlWTeXKKz53VecDcyQvebUUgTZA+c=;
 b=MPTdlHR8+wV/MUIIT2wPQvXJabQ156gM8xFxNELfhaU5gnt2bezWXOGmX+5eEU9PBJkUGlhXjR/QQfJkfPdth5VYytGZJsMJGyNo2soX7iIXWhJ9jCTMgiTspgv8ddAGDbkXTz50QtJfTuQ2xEykBTcPPR9bp3mCWoAZZpv6d/s=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB5924.namprd10.prod.outlook.com (2603:10b6:208:3d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 12:08:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 12:08:07 +0000
Date: Mon, 27 Jan 2025 12:08:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/vma: fix gap check for unmapped_area with
 VM_GROWSDOWN
Message-ID: <ae776b38-1446-439b-9597-a83c4be096ab@lucifer.local>
References: <20250127075527.16614-1-richard.weiyang@gmail.com>
 <20250127075527.16614-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127075527.16614-2-richard.weiyang@gmail.com>
X-ClientProxiedBy: LNXP265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ad1638-524b-4094-4e87-08dd3ecb4296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opgQ3dnMIimI7GwZdU0pKdYju8MizlWPeZeT+QejQWz5Q/Wv6o3pUt2LS8YL?=
 =?us-ascii?Q?xAQvjmiUumLtdEUfIkjHqQ7mN0ArE4Q7Q5WGCWu8vzPXI3EPowviFgUnWJ23?=
 =?us-ascii?Q?UeL723h0jYjRQ4SwsTZp7mo+ipEF4jx6CKmvsA6F49FEtUAzaN8P3xX8lJwY?=
 =?us-ascii?Q?ru4aSwG4Aj1TAOS3YIdLG5GZCEDuI5+/nvtwpf5jvcMtoj/ZrfZ153souOqY?=
 =?us-ascii?Q?R1xiZDXv6k/BTjBfrY+pGcLlHgXCMi9be7x7XYnZxVzkGzyVJJfmHMyrlWv7?=
 =?us-ascii?Q?nhnaenaUmlR0+t3AN7cgHR8helty75CWCZuiAlgCxaBZ9UK80FrbBJUI/6Na?=
 =?us-ascii?Q?67ZWDNTzWTD+18m7qxp5C6asqEchLRbS9pKV1gtkT4TNWAW9XcDCDondy5FN?=
 =?us-ascii?Q?nCKQ6VcGNrXpzII+7KmRnFXJOtcMEBsiP76mf8Xh2VIcGorePdrek8iXk3DP?=
 =?us-ascii?Q?eo1THwfXqV9qPltq924Wrx/IRCun5L3yq9ctP2vIfbTUegrXhFbBc6MIicQl?=
 =?us-ascii?Q?26qBSW0IRsZ+zvy3hI3Cun9wmR1Yx9sT8aUkP0U3em9i4fYMbYNkVu53K3KW?=
 =?us-ascii?Q?99sbeXfctuirsuEwE5RiwvZcR4NmtNdTPJovKYRZNt+brWxRsbjemYnibvRb?=
 =?us-ascii?Q?BBkknsTlaR/OYSTqQbUbnXwVudui9Y4Tv0ArjJym11900OaXLz8kYrMlojYk?=
 =?us-ascii?Q?QUeE1fSQRs7Exibs4a7PmIG5cP0kQCBxdSmjpAhJLvputuBtLRvqXl8tkSGo?=
 =?us-ascii?Q?0xbDQgvj10U45CsBK1nr5uBI09sbnDO56gniA+lFfpx8K2M+L5FkXZDcOI36?=
 =?us-ascii?Q?KE6R/vTqGJ7oJbkpOLIuG/kbw6Ooonzd1/ZktRZjcbOHXRWp2pNtG5t/mkx2?=
 =?us-ascii?Q?1PX8KdvBAgyYMvTbZ0q3Llwb/LNBZDfbcqkfnttyMq2a+c/Pv56V1bLMM5nR?=
 =?us-ascii?Q?yCCii8Bl5fq3nV7zZkOLy9/OLynQTr/h63N0jmTxcPCFovvExpAIw/x7Z1m4?=
 =?us-ascii?Q?2o2pXxKnGxdJRDdO2aCnStyhsn+kGiS3Pl6JVZflZdNJK2EhEOKO10M8PwlU?=
 =?us-ascii?Q?bjg1j6bH9hlFfDFp1nOme1ScHfoiDbMPYJ3xpQuSoJ1wWi6+W4MxnaQlHVDk?=
 =?us-ascii?Q?0+VLLSG0UlW3Y4/eD8Dc04N35ogtEk/2/IU1HyYswWcpVGVx+MW9278Cy1cj?=
 =?us-ascii?Q?uQyqe2YRdtT+3mRa7rGDqKesAVIwKrBJ+xwMKq/FDwm+tZLgzuQmFEf36lWY?=
 =?us-ascii?Q?6ZyauXurL6B+KzCdsvqw1OmbjJVq4913GbJ09pdefUVnUK+5qWlFg618BdTJ?=
 =?us-ascii?Q?gU66tFvv3U1WY9UXVxY3fYRIQjfGXzqndNo0XCulup0aZYtJye8b5t0fRxg3?=
 =?us-ascii?Q?JgvU6R+5UUdHhEce9fK9FZvzc85A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eY+iUE2fdxxXIrcp0b+VN5DO23SO4welRfE4RgI/BpZeDBp9KANE/W/jhaQx?=
 =?us-ascii?Q?ZBX5oGWnBPJ/LCbmxY+49uOYcjnRRstFtqULqr9T7usmJSJs9Qm+UhjXmiNb?=
 =?us-ascii?Q?yFZdBMIyCbq3/pQ9BWqnaeRtLskfqeZaJPZJR0DJqhDg5jo0N1ues4INWxGz?=
 =?us-ascii?Q?bc51tUYaf6iMQ6+gy2vZiHK6J6F3CMHangBu2FtT1a/ipyqXf37mp1zmDyvi?=
 =?us-ascii?Q?JOfyZ95k3Y7Zays9+P75JdlNXtOP+RhUoBkI+wW3zwW8DLYwhu/x8a/injza?=
 =?us-ascii?Q?OYeEa4SoW1WxInZwB8Lf+YSAxtjcd1UPPHEL1FSvlxHWHJJLE3+sx7OnhBS+?=
 =?us-ascii?Q?inAj8rEfti3kMaEBQyWQtTRfz4yAxBIPhJCQ2RBAL8r/b/Tp80sAkwxgll2k?=
 =?us-ascii?Q?Ez+mw2dqhiB0jLx5LYO2EjHJP0ksjHaOxTNGmdCMrurHejA157B2wxEyYNWN?=
 =?us-ascii?Q?FmCWtjSMlfXRXwdcSmZB2ZSLiD2f0aoXkIfg2lF1Okyry1bOHWfvFU5fHp7R?=
 =?us-ascii?Q?rcUmgJVjj2fA3DdG8IcJUqJr5dUkdrryJ7DJSZ708z9kCqlVEOZhpxet3Kzz?=
 =?us-ascii?Q?GyK/ayaFEImWx1yrm2+2utd+HdS539QjYCnr0LEtAZaZQ3SCJPh1qY0LT7+X?=
 =?us-ascii?Q?LDQzabEPiMJvh7RnGKNgPghCPbWjWsFHkSKloF9eYlpGuR51iA8kUbGc73Xj?=
 =?us-ascii?Q?Auh68Mj7hx0kmuzi1QGo3ZgtRVje7c3DSBJcAkJgy8IWy+UAzIFgYZRZ+RTa?=
 =?us-ascii?Q?hxdPCDC6CsoE2gaoTujtQynk5ls8+OriBsf6aAlZmUpSrJfKqwE/gUDlF92r?=
 =?us-ascii?Q?FN3a70pQtHGethZg68sAeakEbYT+mzWKqUYYhjlvK4C50RAAdbs+1lxf6cIc?=
 =?us-ascii?Q?5oHOYBetaD3UsQBv6C8tmpEQsv5Hk8UZ5WFOcvZ1OFUzluHeAKcc3qs9fxxv?=
 =?us-ascii?Q?ZdoPTAp2ox7KINFM9jnmgwCP/UkXCZlLt/LJKleky2lxjJ0yfgAnfE+ideBB?=
 =?us-ascii?Q?3cWlz2N0iPpejrFoIQxJn7hcj0NzEeLPN9xQByBBcrvA8Utk1C+vyintqb5V?=
 =?us-ascii?Q?/U7rypkj1VhpdJ4a6xBYIr4MitaKPWY4Szo4nUwOqCW09q4dowkNFZk+ylHP?=
 =?us-ascii?Q?mBAV85KNfyV1o5ONYawscYRhZ6+0XOE3wifEhx+BLZnqyg994ySHYgkQbyre?=
 =?us-ascii?Q?Ma9Jg7ao4kEhxMb57/qSCbqmYuDsLPk+aEKdPoWElRYYYbTYnqm0jV1LjagC?=
 =?us-ascii?Q?+mFaC+TkBrbDQx8Uhyp3LOcsdRFtLPVrcl7tb0/kGtGSIGoH3LiojgmPoGFW?=
 =?us-ascii?Q?zn138zdKjc/KiHDdEa9gyU1UHe5WvZ7CQcPrVQmtPgWIJHykzU5r0BkYiat5?=
 =?us-ascii?Q?J8YGDoPsxKBu7Xiek3iSLtxFtVfc8X+iCaCgk8fQD4ifrk/hHlkaO838ADb6?=
 =?us-ascii?Q?/70scXvcUcGZjNxAZcXq++pg9U6pxgIPyr1nGvucUzjkKdtpIL695nnyGA+1?=
 =?us-ascii?Q?lLMOSUs5npjWVk1QbcVT0ZToK66a89AojMGbiifO+Egqp3ZU2vm+iSncailR?=
 =?us-ascii?Q?gzxC156kLK8+3XJ58NoH5958FcjJFvydpoVIM38i9E+1YRcJSuCQ9w85IxpM?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mfn9caOqxSdke5L5zV7B317p19UEardtW24F3wZR5KAZnS2vFeFJrBjqzQELo6IDAsfBTgTv4iv0ayR1XyawEua+adKYq86nnh7suyXmbAYTLcWef9dwtZ26WbptCJ2zqsfA9ILmCwIfeNk+OJBG3AZAF0pxrRPP8+8a/W+9GNf3xFmYa6xK0NNlPqIjnlOGqA0nbiP83fL+TvGj1Tdv89qO8X6ZQaR4CFW/FOTh1Y1fvtJzfM9+1A9dfKM62FYtxuip5Yfei0EnLUABco6wuEFzPx/5fiEB0pkJ4WPb9hl+swRtYumxXDiMyLXhFG3rUk5CVjl6A9os5CDcknRjnldWIpBg6VbpSc3fcHKuAeyoibl5cTxquzxFquacRu/fixQh9VivaIkHpNJQobsH11U1EO/4poHd/iRHnI8olpzgxbIXiEe554lSKTBvllJG0Mpsol4Qnm/4m3x9kpqS4Wb8dI9rYtWxJzUoB8FExxvgMBphXUaZ0vJW9+I1pjq6algxY2MJgKoV+rRgpAQ2NRrF8Pr60LpcCQTy/r/EQBvMsSe8GbE+t7Kjz2TX5bplfJjnF9nkbnnwshyPAJp9qf1Rm6zU8wLiUqA9M5OB40w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ad1638-524b-4094-4e87-08dd3ecb4296
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 12:08:07.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhf811DALk/1N1TNboXtRj/4qH9JAWbpNR5mjD/mdgaQFTTD1Fks9+AcxoqSapeMDi39Rir+vNsjY8yax6n+BSV+VwOIka1sGITBgzJ4a3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_05,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501270098
X-Proofpoint-GUID: KSuvdEfbHLTyWZmjR-AW5_mm1Yb9mTjb
X-Proofpoint-ORIG-GUID: KSuvdEfbHLTyWZmjR-AW5_mm1Yb9mTjb

You have a subject line of 'fix gap check for unmapped_area with
VM_GROWSDOWN'. I'm not sure this is quite accurate.

I don't really have time to do a deep dive (again, this is why it's so
important to give a decent commit message - explaining under what _real
world_ circumstances this will be used etc.).

But anyway, it seems it will only be the case if MMF_TOPDOWN is not set in
the mm flags, which usually requires an mmap compatibility mode to achieve
unless the arch otherwise forces it.

And these arches would be ones where the stack grows UP, right? Or at least
ones where this is possible?

So already we're into specifics - either arches that grow the stack up, or
ones that intentionally use the old mmap compatibility mode are affected.

This happens in:

[ pretty much all unmapped area callers ]
-> vm_unmapped_area()
-> unmapped_area() (if !(info->flags & VM_UNMAPPED_AREA_TOPDOWN)

Where VM_UNMAPPED_AREA_TOPDOWN is only not set in the circumstances
mentioned above.

So, for this issue you claim is the case to happen, you have to:

1. Either be using a stack grows up arch, or enabling an mmap()
compatibility mode.
2. Also set MAP_GROWSDOWN on the mmap() call, which is translated to
VM_GROWSDOWN.

We are already far from 'fix gap check for VM_GROWSDOWN' right? I mean I
don't have the time to absolutely dive into the guts of this, but I assume
this is correct right?

I'm not saying we shouldn't address this, but it's VITAL to clarify what
exactly it is you're tackling.

On Mon, Jan 27, 2025 at 07:55:26AM +0000, Wei Yang wrote:
> Current unmapped_area() may fail to get the available area.
>
> For example, we have a vma range like below:
>
>     0123456789abcdef
>       m  m  A m  m

I don't understand this diagram at all. What is going on here?  What is 'm'
what is 'A' what are these values? page offsets * 0x1000?

is that a page of memory allocated at each 'm'? Is A somehow an address
under consideration?

You _have_ to add a key and explanation here, my mind reading skills are
much diminished in my old age... :P

>
> Let's assume start_gap is 0x2000 and stack_guard_gap is 0x1000. And now
> we are looking for free area with size 0x1000 within [0x2000, 0xd000].

How can start_gap be 0x2000 when it is only ever 0x1000 at most and only
applicable in x86-64 anyway?

>

It'd be good if you'd shown this on the diagram somehow?

Like this:

  <--------->
0123456789abcdef
  m  m  A m  m

But then I'm confused as to what A is once again.

Ideally you'd actually provide what the struct vm_unmapped_area_info fields
actually are with other parameters and _work through_ an example.

Also you're now talking about a stack but you haven't mentioned the word
'stack' anywhere in any part of this series afaict.

'Fix case where the arch grows stacks upwards or we are in legacy mmap mode
but still want to map a grows-down stack' is a LOT more specific than 'fix
unmapped_area()'.

> The unmapped_area_topdown() could find address at 0x8000, while
> unmapped_area() fails.

OK you need to WORK THROUGH why this is. You're putting all the work on me
as a reviewer to go check to see if this is indeed the case. It's not a
fair distribution of work.

>
> In original code before commit 3499a13168da ("mm/mmap: use maple tree
> for unmapped_area{_topdown}"), the logic is:
>
>   * find a gap with total length, including alignment
>   * adjust start address with alignment
>
> What we do now is:
>
>   * find a gap with total length, including alignment
>   * adjust start address with alignment
>   * then compare the left range with total length

What is 'left range'? This explanation is really hard to follow.

>
> This is not necessary to compare with total length again after start
> address adjusted.
>
> Also, it is not correct to minus 1 here. This may not trigger an issue
> in real world, since address are usually aligned with page size.

You aren't saying why.

Also the VMA's start is _always_ page-aligned.

Presumably the minus 1 is intentionally to amke it an inclusive value once
offset by length?

>
> Fixes: 58c5d0d6d522 ("mm/mmap: regression fix for unmapped_area{_topdown}")

Fixes it how?

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Jann Horn <jannh@google.com>
> CC: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 3f45a245e31b..d82fdbc710b0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2668,7 +2668,7 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  	gap += (info->align_offset - gap) & info->align_mask;
>  	tmp = vma_next(&vmi);
>  	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> -		if (vm_start_gap(tmp) < gap + length - 1) {
> +		if (vm_start_gap(tmp) < gap + info->length) {

Have already spent all morning on this :) Sigh.

OK so let's expand this (again - this is the kind of thing you should do
for a tricky change like this).

info->start_gap is set based on stack_guard_placement() and is either
PAGE_SIZE (0x1000) if VM_SHADOW_STACK is set or 0. This is only applicable
in x86-64.

The align mask is likely to be PAGE_SIZE - 1 but can vary.

length = info->length + align_mask + start_gap

This takes into account the worst possible alignment overhead accounting for any following VMA also.

gap is equal to the current start of the range under consideration (via
vma_iter_addr) and as well institutes the appropriate alignment and
accounts for start_gap for any _prior_ VMA.

Then we try to find the vm_start_gap() for a candidate _next_ VMA, which if
a stack, uses stack_guard_gap() to SUBTRACT the stack guard gap from
vma->vm_start or account for the shadow stack.

Then we finally have:

if (next->vm_start - stack gap < start_of_range + [preceeding gap/alignment requirements] + [worst case length] - 1) {
   Try again
}

Or:

start_of_range >= next->vm_start - stack gap + [preceeding gap/alignment requirements] + [worst case length] + 1

start of range
  v
  |[preceeding gap][ VMA, worst length ][following gap]<stack gap>

Surely the + 1 (which is the -1 in the original calculation) is simply
accounting for the fact that the start of the range is _inclusive_?

You're proposing eliminating entirely the after-this-VMA requirements... why?

This just seems incorrect to me?

You really need to argue the case better if this has some validity, otherwise I think it's just wrong?

>  			low_limit = tmp->vm_end;
>  			vma_iter_reset(&vmi);
>  			goto retry;
> --
> 2.34.1
>

