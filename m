Return-Path: <stable+bounces-222810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB9vJ8iNpmnxRAAAu9opvQ
	(envelope-from <stable+bounces-222810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:29:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD71EA2B5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9204B3016156
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C454382288;
	Tue,  3 Mar 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pCwKc+Yh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkRgQEnl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FD2561A7;
	Tue,  3 Mar 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522888; cv=fail; b=pGHxNlIU6iOOldYeeRISnnzD0u/E3/teuFaz6nONcyExHGU5z/IWdShF9VTJIGIg68rCxCGM0BalrnXFYdCAMsE3BJgjmKxkICNXA7m90Mx36ecvQZhShjSGnp2+RIZyftfhhfBeiSAExq/KALW2El8Oud1IZdZRBu2UL1qhqww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522888; c=relaxed/simple;
	bh=jkRcEOYXC09XbR12p8icqH3OmxkAWEhwxGH5pgp783g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=efvz/9p8qV8RQ6i/cYQOthynAPKtiNhcWEXA4k0XMnUaFHnR0uTYmf2yuFikY0fKbrEkfXRd0zd7IhiUsOdUcMwrA40OpgvrqKC6AnwDnUltAKyM0VdG0oal3TfkyT3KB/GVsiFdZQlkZ6o+JY+tOkW1dbG/QnxpXItcMdTG0eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pCwKc+Yh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkRgQEnl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6234lEri3821636;
	Tue, 3 Mar 2026 07:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+UY6ql+hV7z2gsvVzQ
	O6sLjVYdoKWu2VfZ/TxA5ppUY=; b=pCwKc+YheTiIh/WSinm15qYR8poyVtg4C+
	9DpZTPLlz9aK5PR6+bVnSmu73NeIGiD20+5+n7xpSHa/3TQ4AueSUjxQEW1e9MZc
	F2+NWZNBfB1FWouPKluRYXcrnQoVwfoZ+SF08AbpYT/8RvPgKO9R9z/Sadhhn9b2
	Nuod0a4UYHWcLxktNw1LqgaUaSNRlKXUGlTrnm5Z7gbJD9puu/Y7UspgFkvVpBia
	29uU+GVWsu+fr/n+2unASvFV1XDcflr3/BZ5k4XOQa6NueHOsmdTAwSq5vqSBBmg
	eXlwkvW9U5bw0G5rgGNa8XNnEHpQAtVeqPAlI6zHblwm1dgsRtlw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnrx304tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 07:27:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6236lAMh036926;
	Tue, 3 Mar 2026 07:27:51 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt9q6aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 07:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL/6L5OsunhaJgeiR6uxFOAvqwV6Nn1WJ5lQO8+2BdbWqoRY2kT5vleLJ0kS79xIJJKP+CmVD4W6HHGvyc31BsEu2Fbq7pc3N/jRcyk7WAN1GZ0Z9UShrq975lLEPjDcgfi0hB6yryzodLbbE8x/auAL/eMDiZqrj3IaoLBSmd/2eyy7BENGB8CwjhsBAS/sYDQO4alJxpifzz2l59jHSuFJi9pRs6fv5Z6iSTsEHD0zNvjMSySuu6bKnUCt2lVd4ZgyfD80fdsucHBRs49cVPPB9KugatO72r//Wgm3B+rEC0WBXijpw5LT3VSXms1xKQ2pCB09H7G5RhQXtpZwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UY6ql+hV7z2gsvVzQO6sLjVYdoKWu2VfZ/TxA5ppUY=;
 b=smrXpLDsR8hiIzpYPynaXS5xfe8YeVhpyc4K4PXcvs+eQL4FyKBUT/zTBcdEx8Vtt/FZXA3tmMyAX4Xj8f9yHE56bdjLt+hnbd26EpNJrxRXMiozsyZIhj9FsXy68ze6VUOFSqfXZRqIuGnIN1T1pUW+XexlfRUyEH2n7g2SoH0ufqemy1/k8+qNVfxWJebzQBPHZ9kh05gXA33yRm/rAea2itZ2JJYU3D/Er1QdnrZbvFTJhf1DjsHlvnWJK8VhhadiIA5kNAcDkLCNmFUF8ZPJaWTzNzIvfMY3icAt9UEy4WLNnVqqvbPbz+pifRl6HUv3wmz5PnbNIgMOqumcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UY6ql+hV7z2gsvVzQO6sLjVYdoKWu2VfZ/TxA5ppUY=;
 b=EkRgQEnlL9pt8wuWTaB4rskHW7f6pCeoMdpNEcIxd3pbtwXtQD9tGb/tLeDVnLTcATvIumxrcBX6vJ5Ro928wMios5i6Oe/zQ0Llw9NTAe986F2o89wiV8FNc18AUP6f6sUIRpfinC9LolJgTwvt1uvyKUW+ty3aBfU10jRAa5o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 3 Mar
 2026 07:27:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 07:27:47 +0000
Date: Tue, 3 Mar 2026 07:27:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <1cece140-0602-4563-80b6-fc7ab608de2c@lucifer.local>
References: <aaBVz7eb6-VBCvaz@chrisdown.name>
 <842272d9-9e9c-498b-9b11-cbad25f526c9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842272d9-9e9c-498b-9b11-cbad25f526c9@lucifer.local>
X-ClientProxiedBy: LO2P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3301f073-f610-475b-fb05-08de78f65e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	/h7V/EB/YyT7zz8VfdVBrZ7C0weVKp8AddRk3U25ghNCxcv8pi6jWNCvZC8bx5iHHP5F/j7BKgIX7YwV2hm5MhCOqCdnuK6UYLlRIhIHhz74Jch9xX7YuXWyw5aErLE6p9crK+6efDeTz3j/IQtYUiU1WXpFOz/JBEd8r7UGkBy4LjNcCs+Ih7T0xg/tFV6aRewcwTfZtrDJd4r5OONLvkF0nrucUMgltkrNgsxEPyEdRA2jBnEwmCd3C1fYHExWnfVyRDMsOfmxJXvFdpf9RVqq1NitOkdo8KjZKPtGww4XP60sm32I8M0rhpVUWLFncW76aFUucc0N7G95rAZNW8mJQIFgfybbLfS2eA/RafbV/nD6mOF2Rcgwg0yuamyJOFqHSm8gqqYWsvc4seWHeLnf4AXn3tYIBNw5c73wgiwZ13xGU8Slm4tyB/VP9gCJ6iPqB9NDleKSfnmv/iE/GBYlw4uvPgNESMfdhtKaWUEzJ41cmA4HpMhhjXdpGx8VRofygbOBTUPBP6WSQN0iAJ8C4pPkZJw6sZg0fjyKjOVVN4HxLHEq2ADIaJTpBlR5UpSRa7WOSIinlklpxyYIS+N0SKV3cD9EOy8q9c1FZapuW8OdVvI9Fk9Crty34NrSQSyha7Cfd963aMS9nvNU9MliH5vSx9lN5xc3pWt6N5SsO/ku9ZHESDbN/zuGPulqL03y/D4IrDSQNhJQ+dArYbx0Lk5xm/4H7DH1NilOxWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CyP8o4pj4/KZzC1xmQRvXmupDvHEfeAvpLcJaUmpZlhj2mhWUUSpd6tszXi8?=
 =?us-ascii?Q?WaShzRsT1l7EOSVV0jkWVG+sCYj4CTAHvQpTdN6HqQyhyl+AqicGtfmgwaxb?=
 =?us-ascii?Q?F47L/CbSIQpPgamTpiHqs9h2TnKeJA++LLVzb2Zi3Bp5y4soFuyVjN0EGwZl?=
 =?us-ascii?Q?c1nhnA8/AsA60WvP9wCe6SGFKZFQc+MClu9szq4FLL1t6vUPjRJPJuYjRClU?=
 =?us-ascii?Q?nZ/rmJv4jKe/58+9QbK97492/Y/6CgnkQ6Sm2zoQTJkve9ueZrghmAgVr4e7?=
 =?us-ascii?Q?AbmICdZ28aswHSSUodc3K/qhoTvRgAUyy5RzISQPteKoL8BpS2W0UHD8X5FT?=
 =?us-ascii?Q?RKzq7+Bc4lvJ8fn5KGglNg2Vv8OCFzU2csYKctImsyQLXkc3U8w452lnr4ls?=
 =?us-ascii?Q?QnSsXfAyaVejHkg5RKfUBn3NEvMNdSNnMhtww/6re2D1VFszfWiVab8b1DaY?=
 =?us-ascii?Q?r5xoTPCqqzGof8XDKkdC8Da5GClgHjrYpfpz8wngHcQPQa+z5Pqtwv5J15PA?=
 =?us-ascii?Q?mqakAx7it1F4J2BAW6sVXjB6v3xK8uW/mw1ZhrpHQFLR2QVWWRBiyONnDSXa?=
 =?us-ascii?Q?Pory19+N2Em051+FSpCm8Pex0fgcVpWfKf8Z9fkYWA1mLgSkoVL/36LT3LwP?=
 =?us-ascii?Q?SSvYPi6wECRTPHw1Ls3KQJahmRRbpQZcShtbEZ3tswZW5F5VFBbBLzhgefhg?=
 =?us-ascii?Q?AN58t1HX2VKbxPuqdqWuCJbAr64WRX/hsXQK9rjxK+ncayVlPAXZ5wtAvGZF?=
 =?us-ascii?Q?PktbyN94LDTmyetfdNCjhNOKsGtc6b7gl3jTAZGCY4Ch2w2QFOh5cUY7fo9T?=
 =?us-ascii?Q?cV8lvQ/6cD0uRFT0O1z2ifAihRdjjE1jXZumFJHt6DrNboDkvPSJUP7cmXMJ?=
 =?us-ascii?Q?63uzCMft18xZSNL84TMa2b1OOpuENfUgO4XX6A1vdTEJMeScpAmHkh1URur9?=
 =?us-ascii?Q?J0pJHNkLpw6lLt43bFhcNqE0YCQgCymUqTAXsLv5BrUfn7o5pnnZ1NnLAiqO?=
 =?us-ascii?Q?cHh37X0CTDcU5WCmnEkPQ9Y6C2NBCx7WIN+TygXHO2roaImHmtDXmFBmoMoT?=
 =?us-ascii?Q?d3GV2ghG034cCaf3esqUEoloKY+7dv1tSlMxT4E8/WqfvZ+BNF24CN10O1vQ?=
 =?us-ascii?Q?VTCHdjHJVyG8ipjrcs7WTseeh5OMK1h2sWLtyR9lHqwQUZcWM9WgHkfqoQ+6?=
 =?us-ascii?Q?gYQQMknazREHjfkYZT3FUIal9dCF7HAwsmrmmeIdwhF5hfq6HAVu52Hlj0KR?=
 =?us-ascii?Q?p8temSWnlfz8BOtZ7T7DWWqNnOBHGitBE7C9QVcBfQ1DuKFS0SFNVlxNTYLz?=
 =?us-ascii?Q?akyZA+cKTw2RB2zsVP2spCPBTOjTtc2wvFWgS1S8bFi33ulDwHbbsEFs0Xo1?=
 =?us-ascii?Q?PP28qmuAMbKpG046bpDlqGvd/qvWst/MGxEyeBOX+HiLqy2QdDt76Qv1KtnB?=
 =?us-ascii?Q?6a1ZHPdU/rl8ZoTePIRBvCR0TKN1A33KUHwDPR4pYZvM2r3HCPFc2CGfgQHg?=
 =?us-ascii?Q?FNlc78AodyId6zzXulYiLjZ0gpLnk0HC9qOGrEPPPrWfUnpBzaN3Dga/Xqha?=
 =?us-ascii?Q?RkgzHg0oECgUMEqII6pCe7h55VXdFI+rsqWhAwR7mm9/EMHHjh6OtuawxMDi?=
 =?us-ascii?Q?abbw0sTUNUa+SlYgTH8tU7BRRSR4ySCet3vZpwFWmXUVyCQUzrKhG15D7wfw?=
 =?us-ascii?Q?u3zgKSmYAPFp1yw5ngr8O5EpNqul24FyEoyOpHKz5IipJ46CAo15AQTmRhYf?=
 =?us-ascii?Q?lA8iD2T2CvGn3amKG81v/JXoUFthj00=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDg4hQMvDENm+/F1i/BAB8/FtHhf98zW6+6PBwS3qqIEGfV2X1GmMKTBrNwgIvniSXS0WmvTQbSZtVhqWZSwKrrmD1Wb8/ffR6TCKy1fHFn4PUhqo1/RfI6BqtraQdq3BYDrpw7iwxZts7xftMsvYLLW5fG9cgL4TP4JEF9L1xgj+Oy1OnDWCvuaghP6cj8voNzHoZpe7ipSy2+xIz4tcwqPv1InEsCJ5o2zfOoOF8ytPw5wHH25HkdpByIBRD1TxwZbr86OjFrhlvGn8pg82S+oJpIiUAp45ZDPAj1L/LfODL3e+MhiydA5h5/Htlw46IC98ZsCnx11lysGTHgu+7L3uqpVZCC4ms1Wy2Mx14ItLr8vEryzc9XlmKDuP9QcnEOr7rEx/EI41jVqSwDZfHk0wgg/FwCS3zQ/+7z0aHkhM1t17ffroCETYPu4AFJKuKEGL+8wRECu49WzAXqC0DwpoFsPo/hGmMgGv1erO7ZBeIFYnuaMfjV586XqOivOHmOGwlAeosYlb2pcV7iqgaCo3yBWIexH+1CXbPIbVZGiJ+uOKMZcv7SWzkti1lCLWbQHYt4D2fanSMcELVPtR4LV61YO3QqnXVesGPVTKSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3301f073-f610-475b-fb05-08de78f65e80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:27:47.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu+XJqSmaOjVdgYTISNaa+vCTLkv3WAIseVgh7yAUWraZVF+Y8NTEJPDv09rXIpLfymYz7zGR4CbLUIcJ+2d/AmyO6QB0KFn9fkynCXFSKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=675 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030051
X-Proofpoint-ORIG-GUID: 8WDBui7qSxutCJzhwEsdDlEoDh4iiKvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1MiBTYWx0ZWRfX5p8flxquEMI4
 Xfc/qi31culwbXUQT+RnZphe/ERC8CFMVnLVLs5ycol4KpZaOZiLzK2QSBIp2CqZ0iOocHDZGDV
 I7CdLpE7s2QwrO1A2kmssgyGb4gfUjajnRdrAJ1L/MxQMu46BLxhJbEs30G1YyePwV5JUEa3kRE
 9PZRoSD+vnm71/5ENNGYY0+RfakClgSiih6AWC+X8Q8WfHAaTJVPLsVp1O72xb1gPiskc//CKPS
 FyaLoWb3/fN4thC96cOsYoxBo6q0OFEVmyEcVTgT/a4w4C52Nwy7qkvT4n9VeMWPjviCQpIgFJM
 Rxo5mXblhhE9lGWx863y4u9bLQaCKMh/DWyETjmSZCBmcqFDkFr5QBLMJmi5WcavNqf00ud8ODd
 qmr25+a62KZOquOhS6XSHBRu0xqS4YtCwhdfelbJy6YgWGFNFpyMm3ebHVH3+6ZoK0TVx0t4yv5
 QS52kS9DNL33AJzgc3g==
X-Proofpoint-GUID: 8WDBui7qSxutCJzhwEsdDlEoDh4iiKvl
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69a68d78 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=trhokcIYgZiCtuWimPMA:9 a=CjuIK1q_8ugA:10
X-Rspamd-Queue-Id: 99CD71EA2B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222810-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,chrisdown.name:email,lucifer.local:mid];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

TL;DR - To make life easier, I squashed the two patches and asked Andrew to take
it with my R-b,T-b tags attached, hope that's ok with you Chris.

It takes your work, combines commit msgs and the code into one patch with
correct attribution to you.

See https://lore.kernel.org/linux-mm/a1e787dd-b911-474d-8570-f37685357d86@lucifer.local/

Thanks, Lorenzo

On Mon, Mar 02, 2026 at 05:34:47PM +0000, Lorenzo Stoakes wrote:
> On Thu, Feb 26, 2026 at 10:16:47PM +0800, Chris Down wrote:
> > After commit d82d09e48219 ("mm/huge_memory: mark PMD mappings of the
> > huge zero folio special"), moved huge zero PMDs must remain special so
> > vm_normal_page_pmd() continues to treat them as special mappings.
> >
> > move_pages_huge_pmd() currently reconstructs the destination PMD in the
> > huge zero page branch, which drops PMD state such as pmd_special() on
> > architectures with CONFIG_ARCH_HAS_PTE_SPECIAL. As a result,
> > vm_normal_page_pmd() can treat the moved huge zero PMD as a normal page
> > and corrupt its refcount.
> >
> > Instead of reconstructing the PMD from the folio, derive the destination
> > entry from src_pmdval after pmdp_huge_clear_flush(), then handle the PMD
> > metadata the same way move_huge_pmd() does for moved entries by marking
> > it soft-dirty and clearing uffd-wp.
> >
> > Fixes: d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero folio special")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chris Down <chris@chrisdown.name>
> > ---
> >  mm/huge_memory.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index fed57951a7cd..8166b5e871ad 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2794,7 +2794,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
> >  		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> >  	} else {
> >  		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> > -		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
> > +		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
> > +		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);
>
> I'm confused as to what's going on here, it seems like the 2/3 is simply
> updating the 1/3 with a different fixes?
>
> I agree with David that just moving it is probably completely fine, so I think
> this should be the only actual patch you need, and you can just Fixes:
> e3981db444a0 with it? Then make this a v3 series with 2 patches this + the test
> right (but maybe best not backport the test :)?
>
> >  	}
> >  	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
> >
> > --
> > 2.51.2
> >
> >
> >

