Return-Path: <stable+bounces-189224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33DC05771
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FF91B881BB
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA330E0C7;
	Fri, 24 Oct 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UtWC+NeN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKNVSSlX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059830E0CD
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300023; cv=fail; b=JUDKzy30Bq3udFllP1cV51NNYS0cgBEIAoOjp9IcyrUXfjPe23JOJFyhbmH4xBcG2sMaxXnDcG+DieRdd/VOGO7Kl0h2pCoafzkMVbAsPBgpsOGOGB0c63VbWcyxo6pwMLBfuMIF0pFrdY6VQebOabNZRCa4lZg6aS0lK0noDUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300023; c=relaxed/simple;
	bh=8HNai879ittFyaIK7X0844+y204AEgAEoE/iq0gJD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgPfNL5eaVwINbDQOEd2Pljuq81MTZTp8J2+AtWku9go6aEfEnj4LcgTUvhrm3c3saTceg2r6l7Tul0kIHv47ERgDfnILqg5d8CdripIFtr57tDdxIDi5LWU+iNnHb+1WRgeplcprok53wa/a7P2Qvm9NedwEQt++DUhZ12PyiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UtWC+NeN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKNVSSlX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NZCU019283;
	Fri, 24 Oct 2025 09:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8HNai879ittFyaIK7X
	0844+y204AEgAEoE/iq0gJD0U=; b=UtWC+NeNL0kuugWuISZR04apDq4cA8MnWE
	TDhHb8DWpPR0WDhHa6TxmenYQfN9LQUDMqrzvH7+r7Xq+xMKVmFo0BwhcB33Y1wF
	DGwxhZLlZEcibn4zYWS+SPIYMJ82RqE5GRQ6pw/WYGmGWKxVT9fI562giWDj0eXs
	gENBdCO7RFaVJhFhF1FoSRHUacg0Is5Y60R8RC0lqYy1gBkBs7OXkJRaYmbu5JxG
	VwQqyTw6Td+mW6M5zOfxTwvHhmo5IO2/XtXv4ELdDeKbkRpD8Ms89diAKqkeYAyw
	/qoN1dEgd6PWJIctWbK6+4BYikWn3I99gnSQGIWJfxtZ1gTGcC9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw3jvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 09:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9Tmjr027809;
	Fri, 24 Oct 2025 09:59:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfq4jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 09:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN07yswxqp+MKBWOj3p/ZSzWrb+OKiBBk9TFMGTZnUXjJFbAtO7RDJCN6Rf4andUz82tKT8XL21Ye9PZQhuB5MesQNwJUEtj6HnlWQOhXwMgl40uhzYNTuUCwckBpv27tlAflDXQdVO38IzPPIFHK4e0pxtSpbQZTn/nfqBeQ8ivUHZhzLVc0jBQtCQfa7SUdvG8Z7WoZUr8y6YTzX+FIQ8TW3GAgvgMGNj9ybxGA1svrsFmRFm5OQobS11gju3JMKKe+fhmhaFs2DTCwcbJ9w03wBiB7eDk09CxPA9ezdOMO6HA2TCslPjR0fMqWMtLrRyIHuTPTDSeBgx4nBcnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HNai879ittFyaIK7X0844+y204AEgAEoE/iq0gJD0U=;
 b=Nv9gXI2yQ8ZJnUZSR4ssPMwT5sr4Mmea+Yh1CfslqoWTCT5mwGbbu0kWw6p4Kcw/j5WVEJYfym4YhaGcFP7abc/cBcR/r+qmr5nRNmlEb2fnMYCwi89mxQrigytiLiHSwxj2hkmpskWMjsZWBOMuvwQugoZgT6O30IjA/n7esM9XKAInB7OQAonWvRCiPqhEeg7+ZJ5b4pWvnORsx71Hkxf8HgIU+H1k2EzlZRfQMuu2OvsaEQB6Ffjhi/vkaBh7sDfc+j23+kPgRruRXvZAUbH3acVre0zHSzeTw82b9wlgptvtj2NSyfPrkGM3Ewf3rATojZBHnd5Rg7yB/Hc3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HNai879ittFyaIK7X0844+y204AEgAEoE/iq0gJD0U=;
 b=WKNVSSlXNqdIIagv2eJT0cD+qLvF4FDQ3wnF1B1aZ/cdUzJO1WE1Ah5BnLp06j8lfEYMcrVMQaGTpYbyNgvhH5ADeONy/4afPIli6bc4eX1zB4VyOcFYjH1ur+vrbRndIdjomNH3pTC7zRNJLuhLvHAqClRmRAegZtyFjhdQIEE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:59:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:59:45 +0000
Date: Fri, 24 Oct 2025 10:59:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Message-ID: <071533c4-6e16-45b1-a094-1882d4093b67@lucifer.local>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <c81dcb7e-f91c-44e9-b880-0e0188a8ff5b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81dcb7e-f91c-44e9-b880-0e0188a8ff5b@redhat.com>
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 982814cb-2f85-4c91-de87-08de12e40f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q86BVON45Vknq/29GMf+tiDXCbvR1h3ORtSwwkR6saCBmqJMKPjMVMaPASV7?=
 =?us-ascii?Q?ip+aWhkQjTIoNccQuDowLrkBTG/qW4V69vk3MPUQpuF/yjjZ/kxDqkxKsuwS?=
 =?us-ascii?Q?QN7zLGr8ZjSBHg4A0+rI1vKFcKmFOQrDJKnKrdlihDXrSCK2xjv7j7f+KKGg?=
 =?us-ascii?Q?/J8tR/4ECcVq4TxNJDvMZeLVj+nu8n7UfSTuko746+Cs8HqVYTF9wGvEs/2C?=
 =?us-ascii?Q?AASFOYTvVudq7plxXj0Z0AwxkroBSXLejA8RrG5kM5gxN4U6u/pt6TiZAmD4?=
 =?us-ascii?Q?Xu9UfviFgV5HDJ7jUS/fKdXuujtATAU7+bq8GVX58k1M3T4j6QVdCean5Q6M?=
 =?us-ascii?Q?+RCOVEai0XH1o4EjX2ntLV/YSfpnA7cuaAtGxf44HcHoy8Y8KlURm9dAsGLm?=
 =?us-ascii?Q?9jbuwfuU3dtCCwbV21i3LhuQzOf5grMTbCx/SFlu3KxPXPOCBi+1byRdIxNU?=
 =?us-ascii?Q?OK5Q0KMP+6zN3BNtKpOEOZFs1Kyj7/gsRB5wwgLAiRwhi+qQxV68Cs0j+HQ6?=
 =?us-ascii?Q?THxHAeATuFhc7MaWrWHvjR47K989amI9W1FvZJZfsZbyET5vRRAJG9qanU4l?=
 =?us-ascii?Q?Jhx4aAwZQRUSF2vy5r4QmTqlfcOrw1h2bgWWesnSmpfmHV2GIuZYzKAZo0Vk?=
 =?us-ascii?Q?7MGA2UgnPpdQOPmoP4cfoSugTnIUTWX2SzDGt/FIjJGOZUGpHCDq2SJblvrZ?=
 =?us-ascii?Q?oJqY/Ffb4kyLUR4jYI1J4VBqjhyHUtg6vULExcuudGHDQDCEwpSA46jp3u9x?=
 =?us-ascii?Q?/lqJ9M6/OB4f93TlWWIIjAsLmyTuDTVtE7ZPW2I1j7L03nca6hkKdQRiEfUz?=
 =?us-ascii?Q?hz6+FKfIgAZI4Br2weW8LHz3sCg6eeRzQA/0lTDpuIptx1ni9DgEeerYjw4u?=
 =?us-ascii?Q?YpZX7jx0kDVc/bS8bZxlpW399WjzbVKWMja6vkNcTxGIeis40yHInEJ689EI?=
 =?us-ascii?Q?ALH4AE4ibpLks1MmMC5o0H6PiER1mErOLLCPeFwVeAaw6rU/9lzRchTAdR6z?=
 =?us-ascii?Q?RxQbnBDGv2gJQevFkzB9qmUhtc5eYxJTrSkKhkhCffLBPFGRllhxdiKC1Kq3?=
 =?us-ascii?Q?V5uLFQ9akun2+N6ZlPe0S6C1Uapz+abPgP2Sinx7i3T2e/hdPfALWIR6ZR7W?=
 =?us-ascii?Q?IOc7kp6i9O/oZfLDRi5t3QwHyktIbS4aSCpSufMD/cJd5oNfy3GByikIk0k2?=
 =?us-ascii?Q?1L1cUZRLFew3OLNtcb5BnZp09u1vLmqNIBPuE2kL40lmGzxg5nDeqC4FlDAA?=
 =?us-ascii?Q?naLDjllvt26dewDHMOzBwYDk/yU2g/6itSTCLgrDthJP7+Z5HX00AcC2scUd?=
 =?us-ascii?Q?aBj16yItR13WIUse0WqJZ4TZNRdBEZ8VpfWSiDNt5B2lzx1rziMra2E+k3f5?=
 =?us-ascii?Q?nG9+/G5ykAkj8wSeXw8XSA5kjQ6usMwOzNhla/Ne2mSr3dgKFLixkHKWahdM?=
 =?us-ascii?Q?C439RUCm68Gv4J08YVRuthrerT2sRaqQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/omonk6FtwyGLLH7JA8uTeYmHd6EwMeh5hNWToM5mz/L85f8K9SY1GnUOWdY?=
 =?us-ascii?Q?JYFnjT81OqdMjGlXBq+hSZqjGyU4speoIW961XrCdfuGLbImvfUp/BMlN6rU?=
 =?us-ascii?Q?i+TMZOS7OkJYgSWtvJCl8EKqzzU1292UHAmQs2TZeRh5oWGGqufJoRSxjrv8?=
 =?us-ascii?Q?T+T38CGTobi1ET0ziCB/1+TAaVrYiB7rB33zADgEPA7OwOwRvxPMnLjHrNLK?=
 =?us-ascii?Q?komBai9To91TNnOFsMEzCECQcZvZqBTLyT2BwBuRdzMCVhcSAmv3Qhq+EqQh?=
 =?us-ascii?Q?nnrhvaxB7iP63av285B3zOBs3kbVazmRNBZ7ESciC9AHIpyWdfJSINyvBfCS?=
 =?us-ascii?Q?o3SgNrtPiXkhS5M1IMmPK7kPHvoj02K1IUl3KtV6J01fxfs3iVh4lEgR+rUw?=
 =?us-ascii?Q?f8zrG0o0SxX9P/08SOUWOD42jtKvbFcgoG+VJ6YMaK0XSAuz/RmNGYAU54AU?=
 =?us-ascii?Q?iOSHOuzVQVo1Ctj7KONcHraHKcotMygVL6WD66fTAOMLJJEgj4F25ZQup+Fi?=
 =?us-ascii?Q?XIjNOD4dmuUwH/2louvX4QKP/g7ROy1svJD8fM1k8jJDAFdwoQ1KrPnkhvzJ?=
 =?us-ascii?Q?YLx2VwRE6etQYI6mXR59OU9P8rJ6tXQHxhExuAMB0gr2+Be/fLIiqAvXRsLb?=
 =?us-ascii?Q?puysjRs88KzGzW0WMOKJ0K+xbOzDsuLeBVf+yMJpnDu3kDRROBFLQVTf4BIP?=
 =?us-ascii?Q?mCN5qBenLTjWvOMyjMJ+uAGJZzxI2MRVtf47a9gJXyLZaGO/7Vl8kLG96ZAS?=
 =?us-ascii?Q?+sFn9zocQnQiAenwmK6qps8GyQm1MrgzR6zd+le7G9Zl1D2cQhPMU3ChMWzK?=
 =?us-ascii?Q?UzVzs0wvUnjUZa37qEbzPwySRRDvgdrvIOCwh3hD/Rav+uUBhpRIcqvZ9F8C?=
 =?us-ascii?Q?syPWuhycAe79JyrhhF4t9yXPns00V7w/6VXEI+MMiOS3TLFJ+IDSYvunYvVX?=
 =?us-ascii?Q?X0IcV9GQcCToi6Agger7KiKSPjXz+TvOrCJ6f0yKixwA4ERR3LyGmB8WfKLR?=
 =?us-ascii?Q?+d/J1zaZwHB6TPv9UF3O/rmtiHNCJ/+O0jObtTxxSPwIP/+2vJkLdJO2qDgC?=
 =?us-ascii?Q?RNQts1efJGKKe7Vehz1nfvqL2WL8n5+zOq20TyNIB+3TBdpTIcFOgPWO7LgF?=
 =?us-ascii?Q?c0sTJbtS2409WGTD2mBAgq9GRP15vdBmWd0bIPPi2hxc7wYyDusvDx7sZzOw?=
 =?us-ascii?Q?m4xOpUKHibi6hfbCj5GaYVg3qTRq9DxMRq8+kFRBZeLboRJDimkpToDaiFyX?=
 =?us-ascii?Q?QRsqxUofPaPraHG3rlokqw68Quhkt0WPqga2AH8bXhi5Ecec4o0Z2pMjf0AB?=
 =?us-ascii?Q?Zz3D3qr4iWMFxOSvo3zsjp96bAS1zHgkxMD+SAYYMNDUd4pFF2g5XE3h8LCS?=
 =?us-ascii?Q?oSZ6WSO3Vlc5WVa9Oma0nop1jXRZQFFfnudXHu/cc7iOmJGEM3CnljID5OHB?=
 =?us-ascii?Q?kvDPXrq81kBhoHJ0HNSuXtLJGTqgiuwvfqlKXQUJjVnFCUS91jsQkxoTwvPi?=
 =?us-ascii?Q?nbSwhH9u57HWXu5X+wEKO+DyHGk7FIfBJD1nOQwYmnUfzeTPpAPxN6H7qm/I?=
 =?us-ascii?Q?hQipPeuag0cNX20Y6qow9Fk624irlHZUQt7QaQxOVdvSPRODHp8Sww3/8/i5?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dv1ZCdm0erJtbLkw1lKGRggnlVpKfQAslxA953LQu+5TCd9fwhyCd1QaM/Y9+ywOtkjqIK2VYeUnFM4KoFWAbiol+VvOJbOQaKG7W59lAjFu3jFt3fJKpjZRBi1s7UuYsS5/osyp1OXjrxuuN0x6c4tOH0w6BZRnccF1XQtzrQe4UMetGTNfJvvzi5xL8mLW/slobsAULTSSNnu+SPUyZFnd6NTBdJbCLZNafKu9cxBFrN9TCAGrLEdrfLPw19QjY01qoOzpXFv60yu4DPRaTEyRwc6frciUWYpAIfGtu9QEriGsv/l8YTZksXaOgggQBQw0i8ci4m9B5ZxDiE0lT2nvbaDoZHkeziBv5k7cT6WuPJ3Clxi3MB5TOGCcTz2G8avYl7F52bjJ+MT9+AxQxUpdP9iPbiuaCj3pIvR+4fPLaPbdG3UP+24/PfgDxMo+x5kimF/quV7p58f1TUo2pRB6/IKYC9RXFKJEXBiOvwXUDpV5DngQLLjlwibq7RtZmtS8nmTH3LXb8mmY501OJVf/Geyjt3b0nIwjNyOditidLiKKW94Bj6Qb4mTEZCFM1VKQ9e9zV8mTk4lT7KKruJVRKY/YUk867TeRCJCfjZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982814cb-2f85-4c91-de87-08de12e40f4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:59:45.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6uyFx1v3qtEGOnPAAucvLefRq87Aw7gehl+9+PQCAZXTBrIPdSyihEpZrmdvaPCUuA47MFEA3JrZntm4YvqsCXP4Kw5qllJVfErO8q7e8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=811 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxmH4ZGK/bj+0
 R0gO8ZgVNe/0LBYTe2J9N2Wb1NCLu1/2XoO5g2MPVGpKYxyWJiwqLFfpZ6LVyCmLKBDteQ6CDEm
 VbOJrqmVKdYbq4FILWOCFD5p1IqMF4m0p2vbs7YQH5YFPigsMHgBeelcAGENpa5ut2PxqU2+WV+
 NAV7ruGJyKq0Azd5LGWzcT40tlEtoOfB9rM4IqUdPUb7or+NnkolqswYvj1aopDBeRQjvcMoMfu
 sSshm7qfW8spjhXsNPLpydsBo8VPASq6pXKwcSED9kNFbB5IPNTLQiDXXrcassUSoBqWRv6P3iW
 5L1EScg66OlQR0mBrt6vJq/WF0HKA2XFWCwGM5g4aGmbHE8p2j6z336FvGGFOmG/559LdbwrVe8
 eo2oPCBh3XSZATv52wz0+NU5gUt8/A==
X-Proofpoint-ORIG-GUID: 4pe7B8SEIL6IKkFGEMWKRt_9BBCjpMeC
X-Proofpoint-GUID: 4pe7B8SEIL6IKkFGEMWKRt_9BBCjpMeC
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fb4e14 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NhkHRpLaeFYgUjmVBz8A:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

On Mon, Oct 20, 2025 at 07:18:18PM +0200, David Hildenbrand wrote:
>
> > > >
> > > > So in case the page table got reused in the meantime, we should just
> > > > back off and be fine, right?
> > >
> > > The shared page table is mapped with a PUD entry, and we don't check
> > > whether the PUD entry changed here.
> >
> > Could we simply put a PUD check in there sensibly?
>
> A PUD check would only work if we are guaranteed that the page table will
> not get freed in the meantime, otherwise we might be walking garbage, trying
> to interpret garbage as PMDs etc.
>
> That would require RCU freeing of page tables, which we are not guaranteed
> to have IIRC.

Ack. Yeah Suren is working on this :) but don't know when that'll land.

>
> The easiest approach is probably to simply never reuse shared page tables.
>
> If there is consensus on that I can try to see if I can make it fly easily.

That'd be good, I'd like to see that if viable for you to put something
forward :)

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

