Return-Path: <stable+bounces-83228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E26996E79
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2731D286E06
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870A1836D9;
	Wed,  9 Oct 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUtUhPiD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VlHk/kA0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB2127E18;
	Wed,  9 Oct 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485080; cv=fail; b=Ze4DSht93TKSdVzX5kY1D9usU5lCQtFT9FSIb+Jq98mOjjHRs9mpuUCXKK691Cza+cDkbvsI4m0ahbEG2y4Dit3Cx5CCBTFBKs2hvdQVhZpXdP/gZkZTJtSfsiBfQrxt7TLzjPR+oaAQ0MzcEfSQ5tRYxlVKPC0fYslwnY3FFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485080; c=relaxed/simple;
	bh=XL9zomW5Wb8hOB/M6ZQ3u1YegGAIhpdzVgwaUll2iW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fa9SPV4U8An1aMTxbjrO8CUMv5tRq8GQ/aC8CfuBwnwnsJP3dU56FAzUpShfuFYO6sJaL+4z580aIBy3aP8yHFYtZv3rQMccfDQJAewLlECVnMXrIf9/23V1Z2LZG6zqqhm3zGqKpbSFoDB4y06WODqHdUtCdulq2zbFbqX5wRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUtUhPiD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VlHk/kA0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dff3x004887;
	Wed, 9 Oct 2024 14:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xrJLpaFt8slPQ1D4cN
	qhNMR4aWS46vkDdIcpD+sew34=; b=MUtUhPiDAYaSJzuXMYt9CSni3UlqDFfXXR
	2OksbtwID3r36GLQvRQMg02G66fl9KAViIsOHlA2uAe0fq4rCSWJaGH6L/+kMGYY
	OfyKC7K9eL6RIN0q010em4Of+yJOv086a/XsXXc7lw1bWG4NJD4fFyug3XTNssAd
	NNJD5Jb9kbF0zGsa5MZUHMczmNis1H1Lqf/qmjzUh2Fh2z9TRWXE01SRU4y5R4xx
	TmZmUzqJs6g0a8LAI5Lcw/cVvUMtLDa2xz5qdPy94UwdVyHCOoT84oBBmvxKSpYA
	rIknkYPLlok+6UFXj0IhQ0MgLRDdf7nEzpyrpdkVirGWREDz7qow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034rqxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:44:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E1E5c038488;
	Wed, 9 Oct 2024 14:44:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8rf0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4Q83T6uiNrVFvGgp5c/3lQ0iiNPTzzpJ9A8YMYUfeWmnGnH4SyUSDUyabsVh9+6mNt/dSm8UF2Ol/ERDyBWQHF67gQrDL+hVqS9Ubm7gZdkgIEv6BcqQpYw5CQbfmwoaOR4dwc0tYfadpo3diqmo+lRi7LeHkinSfZWVnMzQFMUuTqERg8AJZOzSINz27/rPA6xRR2+1LF1xFxruf9cNUAEC1qq0gI5bM/kY4foYMmSuq60hZ7164KMwQD6CPX0eH9COnUCnflx8ziYnBRkEd2oPQABxY5wgxzBBYIFMDJrxjvOsy6QV0S0vZCtB/bsV4m5YFojk4jDvDEXOJJ4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrJLpaFt8slPQ1D4cNqhNMR4aWS46vkDdIcpD+sew34=;
 b=lAom+CKIPpmm2WOcuJu33T5hJSF7w8fcas5zU0XHILKiw1OvHIqJHMsbXX3FZNKuKlswW3BqiNL+Q9Cv6kOyyIEBU+hgFdLMGJZj6GM2I8dwxp8znYv7W7OOTz1NuPhBsUnjMzXP5KuMSi7fRouHEvtQF2VD+MjyLBmZ+Dysr/BRLnEit1lLKuKhKbhrLd5TkkxM4k5sd6y8vIF6C+c1obb5Xg5ruvr3RBgyfMt8Rb86NxgNqvcEEypi41op1S1gd0sl+N/oMNYy1crx0ftYo3Rzhi2OeM3N47sI7WDC5g7mT6iH/pflq7mpp5hidJUzXKNR+gmdd4xoP6tDNcb26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrJLpaFt8slPQ1D4cNqhNMR4aWS46vkDdIcpD+sew34=;
 b=VlHk/kA0IHoQIRdeCDXANBdzNqYJ7+1+SgzW9IvzTZqQ+7KDeTyIc2MGlebqHquBD8+svL4Yn1JhNBHliB0juThLNRhuazmXbpZVqDVN/7aBVBO4LmdLVqq4hYsKSsEOJBOPHe4HitxBYtjWvA0bTZ2VzqXqfkdHCQNOkpymsS8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 14:44:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:44:16 +0000
Date: Wed, 9 Oct 2024 15:44:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        willy@infradead.org, hughd@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
Message-ID: <fe0591e4-61ec-45cd-8971-dbfdb7253179@lucifer.local>
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e63d17-90b5-4179-b6f1-08dce870d964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plhLLtXUxgU9uwHC7orZvbAz6oLBxg+6DGSQT/YDNwFuJcrGQ1iELVooFCqG?=
 =?us-ascii?Q?Rjxd8/kRbDaf0H1cPwBdB3pSOlmx/TPHTkPVp+/0AVbx5QA/++Yk0aDOoYLh?=
 =?us-ascii?Q?oh9caX/cg5dY+87LeHLRQUsCzwGz3HVWt1yyt8g+RyIefVO/XNraEXoGpo1O?=
 =?us-ascii?Q?8yQtP7p7LsTE3qFCoJY3xNafFrys7+p4//i3jyCJGzPzOoECEcFK6vI0ENnp?=
 =?us-ascii?Q?LnfJ/bNHO78VYUMFtErO7K6Py3j5JcD6URnJRBjhxZLnE1bSenuYhmoiC80b?=
 =?us-ascii?Q?eVikHZoKIAM7I5cnp79u6G8tyIY/60yZ+D/j96DiakIHUAe1yYnZjp8XCJNi?=
 =?us-ascii?Q?yY180gCpEhwEaSrBeKqzcxm1accXDQJsA6R7AdJ2Bj3WKaLxfouyxLqFWnM/?=
 =?us-ascii?Q?nYi0NTLNtnmc42lNThHy4joeF8eZh8FX8LRtQJfw8c4PUzB2xDbccp5y1wc0?=
 =?us-ascii?Q?7qKF3myQrx3HqfWw847bjMBwG8P8HMA0gHdnp+Kuktgr39cHZuVqe0T1DVmC?=
 =?us-ascii?Q?YFtyR3FOKPF4YTkzbbkip4vEf5iB1s0RpvvU5Ccbd2oTxkpXTp718ay4Yq+a?=
 =?us-ascii?Q?zf8hUsLAja0TGr3vSUtOb3CYazSZ3VkvKm4w5zARboMJmcMdIZb0jAUZv0lm?=
 =?us-ascii?Q?CTbRnA25r4CizH8U9WL4utNafbkZKQaXwbFva9wJq3gWb1D8AirrLwWTtDP2?=
 =?us-ascii?Q?Ar0tDYpBSDNC3TTgXEOSG0TyJplViq2FoHe3nHOW8ZPI/f8YOq2PrNRQ3bTj?=
 =?us-ascii?Q?SdtFSqk/MDxQNmKRNB2h0gD/XxxWTlPHaJkYqFdOUc+rEWhWUiR2eHF9E4d0?=
 =?us-ascii?Q?G1f0LlIz9u7pGghVWQ7HwtpWzX1+SJxUXi3rrmbfowLqTmdPhr3QzM7kLuSL?=
 =?us-ascii?Q?Yjb6UwZh2vy+MZD7G55sLG5bgfx07d0CE7BbZ2S5pMKJpAl73Fg4i25nyR1o?=
 =?us-ascii?Q?ZxArXY2dMNuMrSZhz3nKFBOkxomNIJqQXMZGsKuGiZtGx1OAPR88cqS7JhnR?=
 =?us-ascii?Q?QPFrk1O/Wc2CjbNaCMQSDrnqslqjGs55SWllzO0Swq8D2V5bLq1fw1RaZgg9?=
 =?us-ascii?Q?fpZE5xH5COUxPTREvpAvdvZMszHp6JaiRovn+/RlzdDsU5E3cremZKXQTkm3?=
 =?us-ascii?Q?8V7WVCVOageMFj60DTKMOk8T2fkScGYSPTP3aC/uW3qViBwql9L+xwgMCeWK?=
 =?us-ascii?Q?I1HnuzlDM177AhAjCznEaHCzGtjhwKknAMTSYhcswAk7cTX3s1D8MpC/3LgP?=
 =?us-ascii?Q?+mxGi0WP9g1FN2HQRfsJ85i5K//FOZhZfybEuTJajA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExtYF7Y5JtMmQbrL2uH33gkzHV+LWJSsYcb4o2iQ3bAqW2oblXamOh7qDoXp?=
 =?us-ascii?Q?HBiYQ0haGb5Uv6p7f1gW3+VC+0TD/zDIZ6TxqSVBNsyb2y/Jgx6FFulCKtEi?=
 =?us-ascii?Q?GINfDvCE1wu/P/V8QGzvJa4KlO0YKKooR5u07iPSKkp1elLaMH/Vc4VI23yJ?=
 =?us-ascii?Q?kchw0SDtncfIy84ZZhnHZwmxiNpPmO7hurlJ1e2nf7NUQdkrwCs1/GuQOLQA?=
 =?us-ascii?Q?hI9ejzA0SlAnQ153QLTO2jy7I6JiCOdqH71s8JjOV2YtmW8xft59E7OTCkRz?=
 =?us-ascii?Q?VtzVhJvw+au5F4TPL1QxeRCPlkt9cKCOVMq8jLBzusCH6174FM+dzcRkSgVH?=
 =?us-ascii?Q?r1slW1OmrYPVjU6KMzFcmbPrR8GuoXTCepccNAICgRk4t34H/2lfkrOKUcUb?=
 =?us-ascii?Q?tVTwK3Rxip5L+dMHLsw7+QsbYE+WnGM5MEgOgV44wyyY9g042D/19iUpTgL5?=
 =?us-ascii?Q?qEOxaAiB+KdZ+YUkgjMLF27geHF9U+dGloLCvjdl0xR3NHMkPycOazBvTIUb?=
 =?us-ascii?Q?uQOf9KUwQyoO6debnzFMr1LM+MrMXqfNwZfPTJ6hkyXVmCdwh2I4vZLKVsng?=
 =?us-ascii?Q?I5rVdAhZ2QCIa8kWdbSIlGGdv1rFcXBh+vw20d2BWFBOX90HJ+nuikvf2frl?=
 =?us-ascii?Q?gmC2H2iLc19MOfsv6m4fuPu09MWYhDVWGYm2X8vg1Yed1Hphzn8dUzv3c/+C?=
 =?us-ascii?Q?ZeCQdVXQshy9f2Et5p0Ket8o3b4Wpjh6C/4bXXxdUp95FyBs8zPaDOPw9Dl0?=
 =?us-ascii?Q?P1LARtviqs9p79L+vTmLTlGj9bKZ6oP/khuCajMoj3aZb9BEP2IOFGsBDE6N?=
 =?us-ascii?Q?XCmR/Dh3B+DaZ54CMnEeXA4YwwrgoySZy4f2kou2z3DRWbjN0I/4H9BC4k0I?=
 =?us-ascii?Q?mrruq7AR3LDBBJ0sMPO18/Zx3A8F4F7mE2CCGycXgBkNO0AITAKZkWxxGK69?=
 =?us-ascii?Q?LI5Kapfx5pH/ALbP7AyD421OwTVmah7XZqqODzwPKxCI92S6rjMk44dCa5j4?=
 =?us-ascii?Q?wFaQyVO6X3pgT54c8RWS8idSgJiuvguGg6IzuvYM9JMBRA7iKjnZEZXkKRoB?=
 =?us-ascii?Q?DRvL02VaYNu4ASTo+brWCAzAaqN/H2wOZTsG0EZos87TfiIXLd6HUjXW6Sn/?=
 =?us-ascii?Q?ffRbkJkNo1RCo+4fapuQuuUQi5LmXY2u+kCJe8w1skQNnopFfxwnifb0VlgY?=
 =?us-ascii?Q?jLUqgH2liFPBo1Jo9XZTh/hunfRmaj30kMYZrzkTO/Rlvbp8xWWNaXc8i4wZ?=
 =?us-ascii?Q?rs+4uuyv9onAf+V3eUQCWQf0y/tWahDrjQ022LxgI+zMhAnoOTiOvi69gDrF?=
 =?us-ascii?Q?rZefl/ppaMz7WVr5//Kx5SlahXmUXY+wQOIfUvGuBSQKZDLTGUFxmzcUkzmm?=
 =?us-ascii?Q?N4RA5WUsyETB6mF6etielIf0ErIaCJpHtr0K8RzoILORPtdhI3RNtEccAlr4?=
 =?us-ascii?Q?p8Bvr+irJRUbSHUeng4fAmSUF2cW9wzCmQscUwpmwUA1r04EFY+pn8OC8gBe?=
 =?us-ascii?Q?+MMJGVetoQvbpkZBt6oHbM76SH6zJ9oQBtuzsuICx+OlG53A3ZJqKM5i6M+U?=
 =?us-ascii?Q?PtEXRAteFspSqhj45AIo5NZ+LVbHePHEzcwZcP9Rn022F4f35H/VvD0vJttf?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WD0zMwE0G0a0cG5aDScCrWQ4OpHHMpUKapOtjjZFLKnUO/56XQpsRgQk/ETD4VaYzdqRdbF/cTHE5m3jG03u/vypWHzVLZn5Xoio5VlfrCvy8+A/QEkIkMedrEiN2QTauhICkt1veQxHzFy1Gtq6j5LKq0jHPTLfhdQBLOn4XtdTqF4A/Gxy9WF7nTD9iHVKP3MfOlAA1FdyeBd43xReJ4L/oEwk9Gsr2chWYZnNJ2jf8cKoQnvuQDycg+3tXg72ely4HVGb4YzaZvklybhrBDnE1nFV+ElfW6/5RFJ/9xXDbR5NRrOHT2v9OSYO5oiP8N80YKQURI7BHRq11UrWF2KVsnwXx2o6FzcXcxq6LdnKOPv/ZRhd4u5MFe5Va8g29NQpwwEtg0hlJ1YnYsaAA/1T6jtjOnewYbUGHhkpHcAjPzd1t4jswtLPh5nZSINKKiWYn/PJbpMMQww5gMDjnR7wCllCVC4ZVleHyElFUv7RqfZBcxtugWTmzt3JfPVZIKA45QY4g+FivJQ3PJXZDNWyX0w9zWcW8F5mZJrF/qAi8b0e+LLZEeVsYbTUqI4rPDOgigfOgETJusw4HapirARlUatl4QP1FUqXSgVWBEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e63d17-90b5-4179-b6f1-08dce870d964
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:44:16.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQwqol1GB3UpQeuoUjnl27FAegWRFAlOSTsOkNj9vIbjjG+wDKfGGoEOfgz2Q0qPZIMHUucCg+nYcBMrL2j9AqdK1kOJmYelHmDDZ2Y4FrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090091
X-Proofpoint-GUID: Fqsscuyw8Za0zGGT7W_c4Rk3JVJK2_M-
X-Proofpoint-ORIG-GUID: Fqsscuyw8Za0zGGT7W_c4Rk3JVJK2_M-

On Mon, Oct 07, 2024 at 11:42:04PM +0200, Jann Horn wrote:
> In mremap(), move_page_tables() looks at the type of the PMD entry and the
> specified address range to figure out by which method the next chunk of
> page table entries should be moved.
> At that point, the mmap_lock is held in write mode, but no rmap locks are
> held yet. For PMD entries that point to page tables and are fully covered
> by the source address range, move_pgt_entry(NORMAL_PMD, ...) is called,
> which first takes rmap locks, then does move_normal_pmd().
> move_normal_pmd() takes the necessary page table locks at source and
> destination, then moves an entire page table from the source to the
> destination.
>
> The problem is: The rmap locks, which protect against concurrent page table
> removal by retract_page_tables() in the THP code, are only taken after the
> PMD entry has been read and it has been decided how to move it.
> So we can race as follows (with two processes that have mappings of the
> same tmpfs file that is stored on a tmpfs mount with huge=advise); note
> that process A accesses page tables through the MM while process B does it
> through the file rmap:
>
>
> process A                      process B
> =========                      =========
> mremap
>   mremap_to
>     move_vma
>       move_page_tables
>         get_old_pmd
>         alloc_new_pmd
>                       *** PREEMPT ***
>                                madvise(MADV_COLLAPSE)
>                                  do_madvise
>                                    madvise_walk_vmas
>                                      madvise_vma_behavior
>                                        madvise_collapse
>                                          hpage_collapse_scan_file
>                                            collapse_file
>                                              retract_page_tables
>                                                i_mmap_lock_read(mapping)
>                                                pmdp_collapse_flush
>                                                i_mmap_unlock_read(mapping)
>         move_pgt_entry(NORMAL_PMD, ...)
>           take_rmap_locks
>           move_normal_pmd
>           drop_rmap_locks
>
> When this happens, move_normal_pmd() can end up creating bogus PMD entries
> in the line `pmd_populate(mm, new_pmd, pmd_pgtable(pmd))`.
> The effect depends on arch-specific and machine-specific details; on x86,
> you can end up with physical page 0 mapped as a page table, which is likely
> exploitable for user->kernel privilege escalation.
>
>
> Fix the race by letting process B recheck that the PMD still points to a
> page table after the rmap locks have been taken. Otherwise, we bail and let
> the caller fall back to the PTE-level copying path, which will then bail
> immediately at the pmd_none() check.
>
> Bug reachability: Reaching this bug requires that you can create shmem/file
> THP mappings - anonymous THP uses different code that doesn't zap stuff
> under rmap locks. File THP is gated on an experimental config flag
> (CONFIG_READ_ONLY_THP_FOR_FS), so on normal distro kernels you need shmem
> THP to hit this bug. As far as I know, getting shmem THP normally requires
> that you can mount your own tmpfs with the right mount flags, which would
> require creating your own user+mount namespace; though I don't know if some
> distros maybe enable shmem THP by default or something like that.

Any repro?

>
> Bug impact: This issue can likely be used for user->kernel privilege
> escalation when it is reachable.
>
> Cc: stable@vger.kernel.org
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Closes: https://project-zero.issues.chromium.org/371047675
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Ugh man this PMD locking thing is horrid. This is subtle and deeply painful and
I feel like we need some better way of expressing this locking.

Documenting this stuff, or at least VMA side remains on my todo list...

Anyway this patch looks sane:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> @David: please confirm we can add your Signed-off-by to this patch after
> the Co-developed-by.
> (Context: David basically wrote the entire patch except for the commit
> message.)

The fact David did that automatically gives me confidence in this change
from mm side. :)

>
> @akpm: This replaces the previous "[PATCH] mm/mremap: Prevent racing
> change of old pmd type".
> ---
>  mm/mremap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 24712f8dbb6b..dda09e957a5d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  {
>  	spinlock_t *old_ptl, *new_ptl;
>  	struct mm_struct *mm = vma->vm_mm;
> +	bool res = false;
>  	pmd_t pmd;
>
>  	if (!arch_supports_page_table_move())
> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  	if (new_ptl != old_ptl)
>  		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>
> -	/* Clear the pmd */
>  	pmd = *old_pmd;
> +
> +	/* Racing with collapse? */
> +	if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
> +		goto out_unlock;
> +	/* Clear the pmd */
>  	pmd_clear(old_pmd);
> +	res = true;
>
>  	VM_BUG_ON(!pmd_none(*new_pmd));
>
>  	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
>  	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> +out_unlock:
>  	if (new_ptl != old_ptl)
>  		spin_unlock(new_ptl);
>  	spin_unlock(old_ptl);
>
> -	return true;
> +	return res;
>  }
>  #else
>  static inline bool move_normal_pmd(struct vm_area_struct *vma,
>
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241007-move_normal_pmd-vs-collapse-fix-2-387e9a68c7d6
> --
> Jann Horn <jannh@google.com>
>

