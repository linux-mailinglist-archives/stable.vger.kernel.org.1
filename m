Return-Path: <stable+bounces-93599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEDF9CF583
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 21:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DEF1F21001
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46831E1049;
	Fri, 15 Nov 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UeEA46Gy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+jt/MQp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA61DA23;
	Fri, 15 Nov 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701438; cv=fail; b=bKfyD0UTiWn3f1RTTmAa86watjdoLHo5qnYoVYMBiQgnQ3Y4LytmANJ5KQDCQSkJ/M3cytTeo2zT1eNTLvFDeRtyWQm44yeA+090lC+ZSO9tJYqA9O/op4OaJgbgmXtQu5E+cYMlPIyo63zAGKKpVT2APWMiDiCKkK/kt5df6dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701438; c=relaxed/simple;
	bh=evwjr+uCAZN4dFOANLkwx+bSAztrWXgaAvMWaJh3D8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZuKV/Ft7GGO3tuvl8pvCNVsN7yxilQTbN8mfCWdbVAAExfSI3WIquma4uG2HBHxCaATEHMB+7Vg8KMmZ7pHUQZIGtooc/Fk3UrKTUf3Xz4o5UMsbDVHbq9YNv89RFK9MpsB+A1AjQFefFAgfpqCpqkvabMN4upc6wcSD9ufFLhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UeEA46Gy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y+jt/MQp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMawY012264;
	Fri, 15 Nov 2024 20:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FKzaKz3E0875KAn2wt
	YgjhpWJLoT1BW1CUyD3l+K53g=; b=UeEA46Gy4I8qYAKAi7V7+ka/WG372li0a/
	kx767HnmQps7yPMsjqGFOK1cGgLdM6HNHSYBHOEQvAeIPlyUOjQw441L8L6kFTl8
	XcSLAUkDV08pHdYx3D80hfGF1TynRshOad0H1VAwkYMhsPHVNXYNznbScJ1BLTAe
	phg3VVLarbea2DD+KGxnduVeWCVkAgTKRnw2Qud8FcfUxbEMvnvICRBkPWc3ZOqn
	MTATXfazPJzbkT3AcvV0yQcOPfpHHOaeuWJ83jCcLCqbSWavy/h1W9zX654qHREf
	oHcTRUx7qa3Rw1EEn7tX4IuMuuc956Bpg8N7fG/ZFjDcQA4cWkzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc4857-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:10:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFJTMMR005701;
	Fri, 15 Nov 2024 20:10:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6d4737-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3pk6qBZEB8daEeTC922aTZ6nVm/Dm0k5Htf3W1Ez/bwdzn7SuUxOvu19vwl++hWPuXbPOzl4LWeROPMY/+LlNond0d65A07jAD/eaD3ubV9ICmlP2EwI4b1FM7VLznTgTFJzDhdhbUVPgoZnBQXUy+gydeqrEO/yNh91yap1n1m9eay3A2BUEZ5aFpeaptx5tY592K50UT19zhPiE+0tad0WQVLybZVVG08nA8eBwEWFmY37q5eMXwMA5dDaOFkZ0VjKXGbrMxv6RZtKd8ry1GhTckgCh/KHiorc03xD2MwOuXUdEErh5ZwEQngUS/cJEFXK+WLLdQt6ODX1vZGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKzaKz3E0875KAn2wtYgjhpWJLoT1BW1CUyD3l+K53g=;
 b=nzpfbFOARfDW3030F39zWsGDpNU/wxtNsieIUuIfhDVUJSTuKpT68ZTmM2a+sGKN0w7lmhqeOMy+YWpIxSspnoifOSDd+vNbA/cXsgdT+SatUWrSVDOmG+g/aIpME1w33NSAdfsfqkn4j8xHW0180ODqZmfjMSygEc7XTN+VjAqr+fHy7sMZwP833qjeZ9ll+NtQx5/n9szceivbFn+RWMcR5Zn2xlidtG8gt1vJ80jcjRaSgSiE549waOUJCgQ0ofNsmfMVhUVg0vr5QH/4OZsExWX17dhBgY8h+D+D9dqeC1dMXgPFQtGEJIt8ujKYQZFwzwDTxlQD1VhX+Xrb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKzaKz3E0875KAn2wtYgjhpWJLoT1BW1CUyD3l+K53g=;
 b=y+jt/MQp6iEriBG7mTod4eyXPrAFmu/nHoOxsLnJ+r33hzM9Gwa/hQfmXY8bAFEut1dsqPrr958ZA4nhxJVor4RoXsK/uzzuBvTfaV7LHmLhowWKM3mMONfYmhzY4XITMRkix1lpMXHL3LF2p1VK82wPQscttlXg+F5w7C14yRg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 20:10:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 20:10:04 +0000
Date: Fri, 15 Nov 2024 15:09:59 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1.y 0/4] fix error handling in mmap_region() and
 refactor (hotfixes)
Message-ID: <iwvyuktzedc4njk52czcp7hndzhg4uucmvmlctjsxk5l5hncop@rhb4k6ekz2hw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f2b23d-6ddc-40cf-6f7f-08dd05b17e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uQssVzaCuLlHIqvjbiKMgpn6GnPqY4dhta3XxFyzkrxPjtjSWIGaUh/mml5j?=
 =?us-ascii?Q?NLUXKaROVQyOD2lz9oSAygJBOkebXKyiGNLeWs2CZoHKJum2F4JphW/GVkYr?=
 =?us-ascii?Q?misBoFH0AN3JkJ7XozXon20LSJS/mSYByl77unl4gy78ZY0h2gh6U1PDDTB+?=
 =?us-ascii?Q?8z8MO/XSmTv3yGjBKbHq8OdGqHC2yf7fKO11ZBQ74nDuL2ySPZXRwyY7b9Qn?=
 =?us-ascii?Q?6oKFXASf9gQwvZxP5UWJcD/eL5VETWIceVLGQlcM9PM+QbSNOlLBv/MscNta?=
 =?us-ascii?Q?1TiSwWVT2qu7XZbXmZ20uFCO18VEO0Danfa6c9szToicz3S0ZVt3PEB2a6YO?=
 =?us-ascii?Q?QxYtOnTItvHzbjdBalTZDwK6waenHRbCmAHM9PeIvK4mrkoo8t7WieFCeV/c?=
 =?us-ascii?Q?DvVDXBmvGL5iS3uCt3vYHkHMhc1IOp7DFYXrcMeak4B139EkLjahujXY24EY?=
 =?us-ascii?Q?DbbxVOKC1J9aN0bOxVTvMPbU2ErH05YPrYZcglTOm9rlEhlc+eV3soe1voiL?=
 =?us-ascii?Q?TcKI5a9h/yd7ITMqyWh4HF0HMJy7TqSGAsMrtGqDOBJyqHhwwXFTsrKrcbYv?=
 =?us-ascii?Q?6dz0mF/ZsLDtz5sNactXpsES5Apy4Fn1hWF95ukUxOk5vMN6KDSXV0f9kuxb?=
 =?us-ascii?Q?g6yX3zZBkgJZx+bA12w8QhS22Jd+Iw8wU9N1jR9BGgBxwRt+hqeA7aey7NFy?=
 =?us-ascii?Q?LipO5E/0MGMBZhv1lIjTPxb2VJ7hXEJ6D0jqgRET2qjpCnL1Rupz/Ia/4kLk?=
 =?us-ascii?Q?lXVpSsmS7JWs0ZN/8DPUb+okrb7Xb2awvs/aZ4kWwxEjlmRx66lCy0ljqa14?=
 =?us-ascii?Q?DSuprC8J7YyyLk9h1kdnRdTpFVIb0fcQGhFWxvvJF5N900PIrswQ4FOZAgwr?=
 =?us-ascii?Q?0G/A6XIm6zhvhptg00NjYQQZfC3tVXP65uKk7AXvJoN7rQbTbvTEDsBnqBC0?=
 =?us-ascii?Q?PBRLoF11MzOfCQHP2GXR6Ov6GdzMhXLuMpc0TdwgRfKmeFCbGL/wv+fJmdXF?=
 =?us-ascii?Q?L1QpQ7p2Lrx32/3KbCZJQSIM31GccCl9xg0YRFsMCl12PbEF6bJQNpt61uIU?=
 =?us-ascii?Q?UBD79dU0ved23deAc9gdb0gwhPHNUsqElZNNjr4ExPWjM1W4Rsl42U6MKlCA?=
 =?us-ascii?Q?lEYXTxMK2lHiYUO4hFjQAMn5LAgh43PBQnwaD4rN4IgCWpu044ZGlvCpug4i?=
 =?us-ascii?Q?/m7Int5gvXEyaTZuT/F1RVXfGSoUlVrB9vmZyagTngCfFKH7Sc092XIU2vT8?=
 =?us-ascii?Q?i4QWQGLYLVuzXVcYakl1lEvJFrova1gZbvZLhafIwfKCoQLGOekLUPXiM28e?=
 =?us-ascii?Q?t4GuGODaPJW7Ldq+IaMogkeS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?49k03122rx4YIAJthvCbfQpn998Hk8zY3EHkFBgbqbNFa1LbRaz3y94DqUGe?=
 =?us-ascii?Q?RRt6vwlfZlfvHwkT1ZvutlxheATvetX8oQp+OTF+FHn4IlYykb5l4trwGIKY?=
 =?us-ascii?Q?DqxhS5z6qqPyR2b4HlQUcIDAA0q7/Ppk15d7l35tsaP6EI/7kIP6/WLEhtYc?=
 =?us-ascii?Q?apBM4LnX85hrvT0sc7GJls8ONuCZrOO+utDjnJoeEAArAuj/5jfIwzL8pEAW?=
 =?us-ascii?Q?mhOnw58ZZGLmQXi2nUc7d1M9rOiiBWbp7iOkPfQ8J+ejaA6VXAinNlslitWp?=
 =?us-ascii?Q?b/ZO7alMEQlWBNuB6Nm8V5l3xpVulkzqnHLFg5L2+Ou26tGvOCNRRbfGJke0?=
 =?us-ascii?Q?01Z4Kj5XDeUkus91Je4gutdnd7jQ0IpPeWhgev8/vnelC/iOFiXlYEbwQtn4?=
 =?us-ascii?Q?1HhefIvfySaDWWjHKJsRZ5c9ZXFEYHTGgWnMEr9FDaIsv2fskzbCkXUW/cWP?=
 =?us-ascii?Q?NGOQRPsdmHuLoLobhpbT54nOkdi8gNme4tAuIMrPaVa31/W1FNMju9rjiczo?=
 =?us-ascii?Q?xk9XXGFwuJZPCskjFjJ8VaCamSwuJkzyZlLRcdgpZbZwztYYri4AySyolM4P?=
 =?us-ascii?Q?Hk7mpbaxQj48HjG2D/wterdC2rluwZHU+Pq0YFovHca0ZS+ccp4SnP2eOL2K?=
 =?us-ascii?Q?wZzeseh9zIRpUOMEnqalOOUxyjPxhCsSOpoi/Bxl4Kl/NZi4elO6x9lmtbsX?=
 =?us-ascii?Q?/Gmhk4WnPLsYeWOkKn1zWlyl5AZLgSmzv2EthIlqcVQFVnq0lkX28eC9k/v2?=
 =?us-ascii?Q?jLonW+NRomzWEwUtFpMPpXbozrIqtMwod5pu6jjZbXR9Hu0ZjRLQmb9KXdS1?=
 =?us-ascii?Q?w4p2OxGpcuyi/ZVWKISNP3T6BqLRSxBp2kM+Icr268CPSV63yDs0mp7cPPUW?=
 =?us-ascii?Q?S4W8MnIjTJMbfcQEJjfPZiueXVqaaZ0FuzVeT/DimEotRCklHGRxaiKanrYQ?=
 =?us-ascii?Q?apuHy5UXDpGc1CM9MQpnlFhYCBqyfySICowgmTNqgTlfN0e/G7CJ0UPhPlsk?=
 =?us-ascii?Q?XcyXg+x9vpEWAdcEC/RU70QmEpXOWX/TbRS92BUg0noEn0bTIyovvC0Q1j7t?=
 =?us-ascii?Q?f/mLCdnO4jyHRe59vSABNuqwbLUHyv/4niNOTp0uCdnO6JgRLKssqED/drGz?=
 =?us-ascii?Q?f1LF4t3SKmPyyqmuVSusaRjqdlYqyXyBakdVsA8CG4YHMM/HQd1bc6pE5T03?=
 =?us-ascii?Q?hdUlJvfkCfJTn2ZIt4NX6fHIMn6OxuyyUKFhlhV/upKHH4ED2jx/clEbthnh?=
 =?us-ascii?Q?W4jSAtbcKNpbHY13S/b3WUe2bcd8xe0og97FjTUx3XOUmTwMqT6SAia5pKgA?=
 =?us-ascii?Q?QYsWBfzO7jUak+Jf6U2QxL8c0JIr0wGmwfyU2uSEetwPm5ccbb2q/rihL2fr?=
 =?us-ascii?Q?A/+CMbTvX92+fBJGnLidJ+E0dF3XSlGNt646YxQRRy8beSAInKk5sl2FP5Jx?=
 =?us-ascii?Q?4bZ/hVvLtHykUMXbMhdlQTwxNQ5vZsh0Hr3OTzMVWSCjpVMEfoHpDdFNvbQC?=
 =?us-ascii?Q?7OfSv3hUOLlnSJsyYV/ar9wfvA8TWaBUZNp905NcsZvFFqSHtqvbEemV94/n?=
 =?us-ascii?Q?ndgSoBIZTNZPPSphkkIZQY7bRdfZFxw97wfcaPP4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2R+uVvDmlbMkBCIYX8K17CU+5fGMDwP7mDf6DOIjQjbZURm15UrQypaAd/SmHORI+9cvWYAAcq1AZj9YTX/CsGK3ywErovZCWLeOoLMHgp4Zy2GYM6zdh7+paN4ay+pQFZYFRQJGNBMf+Ho6nDrIEdPHpr3EIHUEI6GhS38J15bf1AjDXenYu7wJoBgY/MGiXXPpXSPsDGBSDR+HwS4Ce0u3LpsMybvCOa3FSoaCVqaGknWxq4JQ9lA7s/PaN8KvbDfYBJDG7ndE1RmdMLrK0NAdYC2+uVAnY7NmsMrd2eVfv+YzxVnQV2Ojg0qRbWy4MCIQtwHc8wOeRiiVqbxfEbabJrS04KqmF13t/4aKQQkL3dvuY8Vfgus9K9c07PCtZNApaJUKF2VHPukVGBnAKUP05kXL8ZXlR3K3uugGQKtKjEBa3nGfg+rAXyBElSz20XpPNlPJQD0XQQiNUgKQPtHxiqniCXwdzdc/PhJu35sDPx+h5O71ms6cGlVJVosOgufJn1UG3sPnoccvcjih6eVX26a9L2Qpw11Yp7i8muyVNDx+/Mx4rm0cxfSwSMNRBGquoAOByWnOybz+R2YXUV9g8E3tQ449Qxd10Fcu0ZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f2b23d-6ddc-40cf-6f7f-08dd05b17e49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:10:04.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byiCODpcdZgipN/sISdyNIBjQXC3kGgF2CFhrdudL9iGHTofthq/4+Mgzkx/UX5kz5pAHXliNwV46pkElyjpoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=937 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150169
X-Proofpoint-GUID: FgWtkyJZTNvaMhg_ZJyYiKncHfRwA7Cd
X-Proofpoint-ORIG-GUID: FgWtkyJZTNvaMhg_ZJyYiKncHfRwA7Cd

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241115 07:40]:
> Critical fixes for mmap_region(), backported to 6.1.y.
> 
> Some notes on differences from upstream:
> 
> * We do NOT take commit 0fb4a7ad270b ("mm: refactor
>   map_deny_write_exec()"), as this refactors code only introduced in 6.2.
> 
> * We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
>   handling" to parisc, but the referenced functionality does not exist in
>   this kernel.
> 
> * In this kernel is_shared_maywrite() does not exist and the code uses
>   VM_SHARED to determine whether mapping_map_writable() /
>   mapping_unmap_writable() should be invoked. This backport therefore
>   follows suit.
> 
> * The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
>   use a local static variable in mmap_file() and vma_close().
> 
> * Each version of these series is confronted by a slightly different
>   mmap_region(), so we must adapt the change for each stable version. The
>   approach remains the same throughout, however, and we correctly avoid
>   closing the VMA part way through any __mmap_region() operation.
> 
> * This version of the kernel uses mas_preallocate() rather than the
>   vma_iter_prealloc() wrapper and mas_destroy() rather than the
>   vma_iter_free() wrapper, however the logic of rearranging the positioning
>   of these remains the same, as well as avoiding the iterator leak we
>   previously had on some error paths.
> 

Besides that one line fix (thanks Vlastimil!), these look good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Lorenzo Stoakes (4):
>   mm: avoid unsafe VMA hook invocation when error arises on mmap hook
>   mm: unconditionally close VMAs on error
>   mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
>   mm: resolve faulty mmap_region() error path behaviour
> 
>  arch/arm64/include/asm/mman.h |  10 ++-
>  include/linux/mman.h          |   7 +-
>  mm/internal.h                 |  19 ++++++
>  mm/mmap.c                     | 119 ++++++++++++++++++----------------
>  mm/nommu.c                    |   9 ++-
>  mm/shmem.c                    |   3 -
>  mm/util.c                     |  33 ++++++++++
>  7 files changed, 129 insertions(+), 71 deletions(-)
> 
> --
> 2.47.0

