Return-Path: <stable+bounces-176453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD3B379B3
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C89C7B10E4
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 05:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA442C237C;
	Wed, 27 Aug 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l13hb3wc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gRqI5z+p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8592264A7;
	Wed, 27 Aug 2025 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756271884; cv=fail; b=OMbX2eo9QZVsLhi3ayvWv6TQyG4qgXwMCFQF4MkU/s04SHO0EEBTzVDtfERD0tPTM8YkHEsJxUtJ7wVe7dOZYz0xqmFbIsRoZJJAd8lLyzj9byiRy/y9GTV40CUQRzkhP78WfRPlffWvCCjPjS6CcGLlHEhXEeZ6VMczFujm5ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756271884; c=relaxed/simple;
	bh=sv7BU3fTMZ/x+xk21POz2/IBs0iDUMF2dffZvi4JroQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyfgzlIrrix2Fswha/BsU+uu0pVFNdf4XrZNADIXR6+5zEV5Vtc3R25QayWReXuFlRjiwuL47Bc/J1ncK6HEaQhbX2hTjS9Kb94UOZJd+E/v0zv9gegQ55I5+95hjpFgOskeDGpmhuTmtuuO7kyrxMvHbw7F8X2LnNYHUKfKNFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l13hb3wc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gRqI5z+p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R2Sebx019972;
	Wed, 27 Aug 2025 05:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZnRpKVuSGpN70J/T0E
	B2y1XXnoACJypokzLR+DsUQMU=; b=l13hb3wctgMrtjmFpIKJWPlDl1KSeiKvPk
	SdRIB2t5F4KavpAZrUhUQot14JTwT28FMOqk5YMsStlBMxavHCdz8/Puz98u0EIN
	olsqvM4Y1cEYcUlRrlbo0fu/46HdxcJC44XdHExmruFj3TMdelVSt3WH7HHtX64K
	tPgMTdcm3cgs+cbqDteIBUb/FoyQrM4yT8xhL7HXyWNEPl/BCt54CwT5h28khgz1
	gWIxkzMhC6IaTvWlpgCfxa/OVtrUC1cy9/fac75scvyyPUdHzfSPrfzEp0Ell1t7
	CQ21e/5GHCKCAF9A7FPF/zs0IurrzRQeoBdJ5zYUYDTXTuH/lKFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e25ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 05:17:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R4PTIB004995;
	Wed, 27 Aug 2025 05:17:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43aggpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 05:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUBAK71cn5v7979PIqJP6hAmeTsNzpVcrW6pjN7mjqGLcsXZnJkyDtTpmGwZs49/+PpFr/SZccNeMzBPlmkVWa5oX1ydiuZZ45lx6sF79PmD34yQX86d4KUwdrXQGo4QSjDykGBuQ8fZ//iFvIeaOANucLt9OBezlHlVm7JTmpeSsOkeF6XHYXPSYg/czV3/HQWCcvHNBF0byyBKFL/6+mOotzc78FGDcKFm5y0vYEh8K99rcniTeiLg/O18bFIWZC7kTzH71MAPCgzFw65IWaJl2phskkpcaqKs/siFU9Hoixqrae8vC7zZJAHbmM6TnalQHs2Al4nFtKnbKjKivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnRpKVuSGpN70J/T0EB2y1XXnoACJypokzLR+DsUQMU=;
 b=Sr36vH7tn9O8Tz9e5A/PSWfBkcuFR/AqOiOz9VtH3aQc7B7T1QH14eZt5kqFxGVtSiJ0p1B7ta2kHvQ2PZjLsrnPFdkcIF+nfznLeA7Xr9P3omYwlP39Jz8IpA8Uvxba+FKpkBXtR2T49/90xiLYnKprGS528M/7Rs35CZ7VpiLrpUEy3i6/hnnqCN8akTH1V/o1PMpBKI4pB97FkEqK1aXngi70sIoNXGKkwhlHH66yQ24Dphesyzi9EPa8fzvzF99Q3tI1QjKJK72CEUkc2j2oKsX0YL33jj5cRU1q5ewbq0Bbcl5uTCWzE4kF/mMyQo/yy1rSk1ixf8EPJoaz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnRpKVuSGpN70J/T0EB2y1XXnoACJypokzLR+DsUQMU=;
 b=gRqI5z+pq9G68YU5oZCe1oFK+BUweOJEEO8Mc//wcSNrB1GNmiTBiLYWjwnn2ssBc7n4sHglqwnFTDh0ZkwNOxRldbOdohqbpoRfTyB/1GS/RJXwEUFUXaK9XN425UhgddWpcI3uzWAsSnUYCT9Blf6Dfjb78g3qjrGRPbmbKYc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 27 Aug
 2025 05:17:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:17:37 +0000
Date: Wed, 27 Aug 2025 14:17:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, yangshiguang1011@163.com,
        akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com,
        roman.gushchin@linux.dev, glittao@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: slub: avoid wake up kswapd in set_track_prepare
Message-ID: <aK6U61xNpJS0qs15@hyeyoo>
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
 <aKxZp_GgYVzp8Uvt@casper.infradead.org>
 <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz>
X-ClientProxiedBy: SEWP216CA0057.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: ae620362-4830-4afa-897a-08dde52909c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ya89C0s6YYNwDq3Yob1SUf4CihaoFqSCfBev3m13FGNP9KgYyqCO4qdBJ4wX?=
 =?us-ascii?Q?pAcYfMRNp/OirPvlbVQTjeZtYy+MN/uw+ldKs7CAAB0tY/jCRFWNqAGTfkwT?=
 =?us-ascii?Q?bBO1zEWPTWvOjPSnxn7mbc4QGcfO3nou0mCdO8t2BTXy/Biepq6NG4dS5l2S?=
 =?us-ascii?Q?Zx3c6PeEtn/jHchLfkFPwlW9RjIDd1h3ePsHGMPc+j3jIoznIuTJU2lJ58UO?=
 =?us-ascii?Q?NawkWcCy/EKABeYxgV5YuhO16lIKeJmhM2XHD5wHYoppMHP8hKh1l3TKrmDf?=
 =?us-ascii?Q?eP3DX2uxGSyQYsPP6jd3hc0ODxASUwYnFzTdJ4tCIQIf9iRzS3mMR7BPnZjH?=
 =?us-ascii?Q?q5+xlxBnKef0roMyrXurTAdjtup4BUIhjcLav44hHw+TWeMQIXypL3vkvZmA?=
 =?us-ascii?Q?t2StZmqWv36NlQx4Boo6tmsmXveZzZR1f65UPIRmIbgXygnBYxN7aaOHkdm+?=
 =?us-ascii?Q?Xp2CxHkeG3F04hq5WQVIhocPPwgvRlxW/krwRExx2ELP40g1eYn/689dqhW+?=
 =?us-ascii?Q?oJ2tppY9pMcWlAC8i1jy9MALjGZ2r987v6JPXIQ0xnwRuSWfpHT3Mf4xIV+6?=
 =?us-ascii?Q?GvBsmSWyPfcbrqQJlO+GIRIS+yYi4Q7EWDhk2XG4SPWnrhTBalq1vl8+FGav?=
 =?us-ascii?Q?cqSkqTSWvSrkBe9gLH68UFF5ALls6Pq4jwvVI97mUvj3mMKMCsd8DkVbXiN3?=
 =?us-ascii?Q?uE0iMtXOgpHkCT1ka/bbS3Wb54U49DrPKs6E6FHWNDT1LA+kzhwzyb+f7KFa?=
 =?us-ascii?Q?71VbdTBzY7MUg4H1y2VgVJsTjwHurchDD4J60NdTpWUHmMhYxzJrpII6KdbK?=
 =?us-ascii?Q?JI25OKPg34B1lQKPLlljmJWbCT+1KKwGBghW8Yb8/7DIIexxKr3b7Duoogy0?=
 =?us-ascii?Q?sx0w7xZ8rdmKOnaa2CRbYBiGP23ool2ghmt+EU+XuxqtLXxcXcecKUj42EFv?=
 =?us-ascii?Q?IyYky8Jjd4+8yrJl3ktkABld3QNmmXMEVymfrxlhqggEcuuXuinVE2OAnNQP?=
 =?us-ascii?Q?pFF67BhS6W97QYCVSqExs+/hihc3sAkszJHXy33kPAqu9EsaXWEGAEjE26ZO?=
 =?us-ascii?Q?BbRh7VOxJRkSNy5Rcfwl2Kuv4JKafZrrPacTsy3X7nv/Q2Kh+GM2ay9h582f?=
 =?us-ascii?Q?sqcETYLl7k+p4TaIpp/4UY3IYaTcSDn93WgUdQX6+ACD2nnaqRnpIyxIn1GV?=
 =?us-ascii?Q?szGFdLHFLr1YglYcsTDkg8o02kGaf9/J476/yysG3zeo7SJplBtlXi29F3XD?=
 =?us-ascii?Q?lB2TWtmniZnxNJ79Wo5PgCtnacYKB7pIh6KQZxtmWqZrD1w3KkmiuR82vSN+?=
 =?us-ascii?Q?+2hw/A5EvM9x+UFB4qvJ8hMwkX66DPbcYP5SQisCydF2rrEi4AvCviGqBQq6?=
 =?us-ascii?Q?yUAKhjiBjaNVTfT83aYiWQx7LPjO9YfLLAs27Ex/6CPpa494ZYsPKeIRihPa?=
 =?us-ascii?Q?DmCzOgBl+AI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pBYSKduhkfkatMsyCEAbBpxPeDMMmEtaTt6h7UtAcFBujgYwz02/H8P6EsB?=
 =?us-ascii?Q?8c15+LMW0NDNCtJCusUyR1eWNW59i4rY9BHpbNRS2gvJ7jv800qdECT6yTrw?=
 =?us-ascii?Q?afhaTvz2l/2UFsWPTYiLB77s0AxWbyx+P+b07c+MsNB3wRfSaDLdRvIQ88cn?=
 =?us-ascii?Q?1QXaVoV7WPDNwujpkCGei0tgrDyearsYbhHReCrGCSIvFOOSUYL514bSsd+k?=
 =?us-ascii?Q?fYcKUyIE+rXQuL9mUyjNpk7+FydzEa084HQ6y5sL/GLE7C+iL0DjElLvjlPR?=
 =?us-ascii?Q?bkLqwWzJLFntOiT5CrDVzyfyQ4oQlZcIjelnC5MQqx0+7MouvYSPKhAouWdk?=
 =?us-ascii?Q?haK2axoqGboCPBwhqZ1/ClgRRGWNFDxX03Rf/dfnQPTQdagSdBTLa7zcjtG6?=
 =?us-ascii?Q?hbvshT5nr7UYPD2cta5uWu9NCXLwWeZOCFgqklPmYrSSW2JzmAVzzKouYfxu?=
 =?us-ascii?Q?W/JrSo7DbHtfFTYaa3aZNiWhRQkoJcuNpXgIXuT5JDrb9ZeQ5XNAQAa1e+w8?=
 =?us-ascii?Q?vpilxrhjW8ISM0KUqc3j1YhNxQOTGvEquw5Q2QBkiLH/fJgrCmwPTQ5j9NcH?=
 =?us-ascii?Q?G8ceaZAhC/fpsogC13dyCzikR2zMFxr2ihR6s1M1boRkoiN2/xI9K/sSg90z?=
 =?us-ascii?Q?1cyRcycbuVuSUEyiLIJLpXxZwWNKW4z5OvSIDFLR6CtE6tp3OMA8ghXML0OG?=
 =?us-ascii?Q?Z0WBXOxHzuH5ghGLuk/NFkODJ2XIAbEo7rzxMgtGzVulrV3+ot99YJBjN8Mm?=
 =?us-ascii?Q?0D2oeeMZxnRaDnE2hmJKxRgIvhfndWtMy/dGPdRGy6AUdaZAHq5FB3k0Fhcl?=
 =?us-ascii?Q?k3PoI8uxZvrqqxfnKWwlx6usWsINZ6oWNVMthRhZy2Bq6yK9Dy4plUbVDSI3?=
 =?us-ascii?Q?BS/cnJKdbjxo/X81fUOaXJPgY0xS33YOMq0FU8A/vXymzkC8qTaUq9BFIYOd?=
 =?us-ascii?Q?ZpF27gU7e51TQ+u626BXbJIqXHZqiIOT/2ITcgpCN49sWRqtLxmIiZa/CaN6?=
 =?us-ascii?Q?9Yyhu6RRDZySkFCh4epYpbN002rsJRg4w6tLC9DdEgTTMUhDFkabyyo/LE2E?=
 =?us-ascii?Q?aM2jQEtQvDF6YYjW0yKnBmF159/JttXYrnb9J633mT00a3nHDsjZ2uH2pV+M?=
 =?us-ascii?Q?xb+qmJpSzvr6NXCGopBPoBPQwkJjbZFkVAGWGo8mDNZGNRmA7ymfw0e1t3wD?=
 =?us-ascii?Q?RUwmvzW5Phlw//+evyxaG6+0K7bi2sZSv+0ouSUV5raMm13N2cX8ygAxE1Y9?=
 =?us-ascii?Q?ip5dhcFsRVNr2/7eDF5L6THGo/SpBP7BB6VS6nNu7c7IIAFOG3uLdo03NgC7?=
 =?us-ascii?Q?Ni6GmFF/pXOiylBdH0RcyVsuNCxJfIxNidl9mF/UP85m1vQsVchfCWOXHYzn?=
 =?us-ascii?Q?0iW/LLcZCMfaaP8CWGfwji3vyZimmnTH8RrVElvBy1Gkx9qwJAFPIZa2TDID?=
 =?us-ascii?Q?abd7JrGxNVlGfidMn8MXedLAgb4BGFbk5gJMFfZOXqVQhOV4xXuhX/zhR/FV?=
 =?us-ascii?Q?MlQ4uJwSrpG1zteGRZ5AY8Lz7IlyJbp2qCh6OMi5HdUZy5MzCBzSwjeJKXZE?=
 =?us-ascii?Q?+XIyNNoKUOzdMnYiRgPzTR46f7pqSapcc/bYMUL/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a1NeL+iDHVI26UDAM0cD15++U9L9MkS3qucPJYWHunEago9NZ3s3yTuDqem2y0VvKEWjGhSbnvT4Gpluq86bOsLbI9HgGw5wuCan3Y5DabBt77qdYOvebZLjT2yNXDOYR3WOhzzdD0AO0OAzBjLAj9N5a/a5sAMGAecEQGbOsl6TPz29HQIaRH3Rs59GP2RhD+bDvpqysndbUze3e+4bzaQMgYkeOl5sD7oP/PSz6ltCg+ofBh0b0Op+1J85/7z7os4z7MfZ/u2ZkqwLbJT1MMuTuCiYE9hMzyGPaCYm41xj+kKcAmpCr8hoD254TaD8KyRX2RlrfXqxBR9LD9sbL5GJQ552MdfKM5X2IWq4YeOIKLfTbRom/Mz1lDxLGXtwjiyF7mU10aNjlXPkAN/nNlxDIDCQF5+FCPJKwT/NIZaIwYYKqGJd7ZkD3v+zvVC29E7SVR/Aiw3vaenEjh9/Y5qxDDIjwbV6je5G9iJgvGzfBJqWRhuezS27SeunpYgbmlkiUXB49FTESuQ+TTKf4J/Ga9bgx6PI3zRopR4vQawgo8k5wExn/N8YWjbCAUq2hHiA83/ZZkHhlQlaY9oGUcFhYmglNgLP/oXt+/gsDX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae620362-4830-4afa-897a-08dde52909c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:17:37.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYX1kltMF+Yd/qYlcWy3v16WqDPILOe5Uqy5yiR1T/BfFJpeQf/FOzPpAjdbhA0IH2yhym+kIyGqXietFhUwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX9fA5G9dv+lCT
 /5AGMZmXZlJ2PWfXg+sqX/JB/pqct66ynQOk90Ny844eRAtroYe7oO0qXd/1Mycweeg0JbNKjQ2
 yXtvZ6kDC+1oE284cL6UoNJRooqi68QvN0VVF8Ut8Xcy+aop23eSCi7BYBYrilJjf+obK1tCW/z
 mHe1NchR3lmDlbNTQcKB4rDz4wkcBtNorZ8E7LkxZUk8n+aHI3t59FPLh/j6NF0rJDh2b5cNf7o
 uEfkzBYPLE5V2VvL2KqbmrB4j2BmWETD/d+DZ4/B6a0E1H0Z4FARycmfgawzOH2dKRDYYZDqw0I
 y2lphpRRpZWxxSsM193l2GHw7kXARqAJ+jopzW4FvmJMsxJ5ibNURmcpxz3Too9EK8a8CWNErbs
 rwtwNJms
X-Proofpoint-ORIG-GUID: eLtVcjy1Mdyb_zEebLvPtPB_smTcEKOc
X-Proofpoint-GUID: eLtVcjy1Mdyb_zEebLvPtPB_smTcEKOc
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ae94f5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=5uEwqaEwbxy_zblP9AYA:9 a=CjuIK1q_8ugA:10

On Mon, Aug 25, 2025 at 05:42:52PM +0200, Vlastimil Babka wrote:
> On 8/25/25 14:40, Matthew Wilcox wrote:
> > On Mon, Aug 25, 2025 at 08:17:37PM +0800, yangshiguang1011@163.com wrote:
> >> Avoid deadlock caused by implicitly waking up kswapd by
> >> passing in allocation flags.
> > [...]
> >> +	/* Preemption is disabled in ___slab_alloc() */
> >> +	gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
> > 
> > If you don't mean __GFP_KSWAPD_RECLAIM here, the explanation needs to
> > be better.
> 
> It was suggested by Harry here:
> https://lore.kernel.org/all/aKKhUoUkRNDkFYYb@harry
> 
> I think the comment is enough? Disabling preemption means we can't direct
> reclaim, but we can wake up kswapd. If the slab caller context is such that
> we can't, __GFP_KSWAPD_RECLAIM already won't be in the gfp_flags.

To make it a little bit more verbose, this ^^ explanation can be added to the
changelog?

> But I think we should mask our also __GFP_NOFAIL and add __GFP_NOWARN?

That sounds good.

> (we should get some common helpers for these kinds of gfp flag manipulations
> already)

Any ideas for its name?

gfp_dont_try_too_hard(),
gfp_adjust_lightweight(),
gfp_adjust_mayfail(),
...

I'm not good at naming :/

-- 
Cheers,
Harry / Hyeonggon

