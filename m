Return-Path: <stable+bounces-222848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F6gCYC1pmk7TAAAu9opvQ
	(envelope-from <stable+bounces-222848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:18:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE21EC917
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D8E5300B461
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FD398904;
	Tue,  3 Mar 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZcnR62i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KVN6iNGT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AE38CFE1
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533091; cv=fail; b=RsoGJb4T/qp/KMRqLyiy73RWVWhZfaPgLMmusE4VnAVdryisiJQWlvEOSd/cNmaAUSqV0kC4R4juFnyHACCputm5oXFFOfV+Odsd+0wSDiLnwgXO936fH7NDdMHPtDWwsDzVqVTx5JmaBYYOaIwH8z8+4O86SVqry/1r92KlGhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533091; c=relaxed/simple;
	bh=Rq69SveZPozgxxSMCE22zNWb0gfavq7T6Wd3ZFKRC0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbPLUQzVbZcglT8rgCi647k0ueK7y1PXbB3euT7gnoodyrF9tD2FvLzDxZMXMGt5xRNIRzEX30geIBFsFrDzldhNGwqihPCcFkNl5z1pSJmbgYuJ6RiVXv0yiqD4gnGP7qPHhQMYD1khAvlpxqqHLwgzsPycPg5CoY1Dd0ov9Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZcnR62i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KVN6iNGT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623A2Pl53791621;
	Tue, 3 Mar 2026 10:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J/T+1McXlIrNg1U/y5
	6z68gDjz+8kCUMVpM+QAsiSQ4=; b=oZcnR62i8XpW2EXAK/2e8ennUFseRuf3MI
	QjDwEHmWXz1d5um787DMPvferMiDGPW6Zpx09v5AnTj5bKKXxmQ3smljbOX09bUK
	Fq7iGj6T404ZMYKYLCvmUMqoWz1vP+3K1tGNPF2jVKP8m32FuZvrTxDDNXImu8VY
	If7nj/f/bKWHwm3WUyXau3wJG61xNIZdDFHlQCm8o6K6fvSfg34NRPeY2gJkh/3B
	4f4XUZxzjiECgKJVljzGjy3MQUiNwUmqtBuPFG4z+3DxlVEe1/Lz4i5M0MzJHg66
	ZEMXJVfWiiJEMF/V7FGi9N+GNcskvhK39juUdWmfUQTJGnydMKDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnwhpg0q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:12:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6237tptF029674;
	Tue, 3 Mar 2026 10:12:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpta4p1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb8qhgVq0dNMfvJibCgpKodaznfloFbdz0jCdzu86fUeIT+W981N989YbnCE+LG0zIrEWvRC4CmgYI10o+RZPBdWzP8CdotRNgCrQRNXH7Y/uI0e1e7If80HLcZ3KsVvrHJMBAWS8k4xu/dC2wY01MHy3ppIHV3nrMzPgSFaEv4dG4OCoYm4YfPfKvsUXg6ZnvDEswD3mt27hjX20N8qBmx23iQOzhOU7ELdDc3EL9q0UwotcTorDqF9zE/h+zRHjPWa/92yaulnBBeOmNlxYV+P2Pl1X0uHhFoA/T/lurrI8IBMB8x84EKOMZKmdU0iHAhdrmxRRCCEpqfI+c4K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/T+1McXlIrNg1U/y56z68gDjz+8kCUMVpM+QAsiSQ4=;
 b=vRWweMR0/9uSH712O/yaSi8Fc4mmBm0VfLldI4wBFnhHbhF+pEyj++zsd1O42ldEitYE1euJvk4YgPFJq2ov9wP3EzJVXTXQhJYoF99TxSvK4sLFvLxU/C59pPrsUSiGOSZhtVGVSHFfubDcPSvXNH28b4PYPbIOWY0m/rtmqtvKxid5GZMzMemd/uxvCfm7m/BkQQyHnnx3aznJumhFLK2UOlCD72OQfQgMJtblexpvXU8UvCHqFf4ENx8aGD6Jxh7VTs5g/EjokuZiu01IXnYmCBJoWVVDrjhyP4sByKWWoXLSQ36ryjc8SiHLYpZB6Mp8s8DkD32CG2NXxVEl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/T+1McXlIrNg1U/y56z68gDjz+8kCUMVpM+QAsiSQ4=;
 b=KVN6iNGTpvGYhCt80PFz/DIbsWq5/KdskG6pIqKRdvVENevCteWCzYczujuKsIYxNcYfu9UmL93EtM3hwtKXaPoeB6KowhxZ6VDwGsVOdjVlWDptE9rCjR972pGUKRNPkpYfl8kNc4ZQ9F6gqsnp8rpiL5orEzuOZy7/p1l9uuM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:12:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 10:12:38 +0000
Date: Tue, 3 Mar 2026 10:12:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
        jannh@google.com, gavinguo@igalia.com, baolin.wang@linux.alibaba.com,
        ziy@nvidia.com, linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
        stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <c820d6a1-4283-46a5-a639-04f6849e4e73@lucifer.local>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
 <20260210032304.j4k5izweewouabqb@master>
 <20260213132027.wm75sh6trz7n24kd@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213132027.wm75sh6trz7n24kd@master>
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: cbedfa5e-f2da-4870-5846-08de790d659c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	+54uQkjj/xrqxuGowokPmQwnSEJ0yM0EELFUeML6CFTCTRVKvvBsw5MMFkVX2l328hfUBl5dkPkxEZPouXvvoS82grQglvSWv8+k8s+txtPO8euf7awQwIon5/d4qci2qCRikQFWK7dWQnRl2iHFgXLcFtamKruDjrzdrc8uuILW5lF2LH6+jLx4XRTa+IjWN/3ah8gbOKuT4MimdKtbaui7uRGYogByIurcSXCFgm+yEzrpRr3q/bmFBvpBSLPeFgxkKPZXsPVzwD7Kup36q6d5uBEF615+4BwzgNsFMBrk0h4j+cP3FzxzwR7xE6UjVkLcedAntetjF2bKU4sOp8yYNgaEeFF/wGPFlWAKwUkhFSpjzJCw9yi5wgipnjLVe9fF/A4bHy3KFHOyKqqcrVsmOXQj8vuZELXX7yQABQC0pK4zLOKRDMxWdjXdaT5B6wwhxS0Kw1zGtraAg6k2pEiLe/KYmmdK0lWnP4/M4H2DeCH5AhA6T1F35BerXbSH1Mh8yfoxyQQu5hYfbJM2RBzgLD11UsPbXKau0f9QbjoaXEAGZAovJHAVxztYP/zIhs6zGGQTWJ9X8mtl2WHxdixMbPMgMm6ys0OT1qjpIX7JbY01Ar215OLndAX1DE4XUUSoTm64+i8dNFyzf1iFCcmiGhdEyRuPoo7jA6fz39zqdJ+lUidLSn5jV06B1IamLHApcDpwxzfzv23D9WL2pffmH3oewC2Uabu9eLDneCWN49rsli/UrHkuUC0JhIDC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vasdfAMbkNCjTWMHMDX+0SuSv+uA5lnxPaFyoptL4GJldDs2rtYzBs2KQUp?=
 =?us-ascii?Q?4koPeP60AmByQLjRKoh5ip+95oVYHfifGePQHSE+WHTcL5s4cid4Y10IujYS?=
 =?us-ascii?Q?GstQg6CkNXNynRIQ4CRKlH9Z5X8k0pfnsBYYxB7Od9KFXvlyH2/kmkOYI/p2?=
 =?us-ascii?Q?8dqASJHTuVHQoVO5KsaBbps4mzgIpFlsuoIYB1frrthzRgkSC5jRq6iH8EZC?=
 =?us-ascii?Q?oY5gzzkG+9rM//grskZlgxdxrF98tRsxmA//KCvqLCF5Qrew3NEldPPwsE0y?=
 =?us-ascii?Q?p48AGfAN8rlbN0Uq1TTlAcZ6xQ8qegpowulExP+Ca8NmCGJkB6akGthHbatf?=
 =?us-ascii?Q?oPJ3PsznQYc6XeVgfna7MLdfOgB2qJN5C0wtbhC47ZgmhTju+BhGk90uPPKl?=
 =?us-ascii?Q?3/64/QnfV8Q/z09otYPm9Rxpe0AWpfrWva282lNjXtqNezAxjXCf+2wTAzDk?=
 =?us-ascii?Q?pOL/zBbg4TXKsRvDLJQyhYcyf4TpsSOZzimQqn3Ax7ehjv0+p7vkOmvoYi1F?=
 =?us-ascii?Q?ViD5Pui0A9DxaRkGcQC0qs/6AiThexR1/z/OwHZ2E7y3Dvq0dgiWr6aRQiSO?=
 =?us-ascii?Q?gBHTU5679zcMcYG2dZxo+29uJZ8qRQHNrl8INWREOkaSSXJ48D4cTpm4HCh6?=
 =?us-ascii?Q?K9gRRJp8hzEREHwxpEkCv5rAegCcRcf3usMwHBvdRFOayT9VyH23lSG2vRm5?=
 =?us-ascii?Q?qUEZ9tVfOPUUkRaIfnns5pcR8HMLx4UVuQYpgJIr8UUdldL50p/hoRvSSd6s?=
 =?us-ascii?Q?91fslg+26TLy+EXzsYsu9e7uXEeFNhXCx33xcf59FZQxJat8VXv1LbaVTek4?=
 =?us-ascii?Q?raq3Nml2p+8Pp0fziBLmBae8gnFFfTn9kSON03JdVEYORLzKbQtoTGv9lZXg?=
 =?us-ascii?Q?3WdK10H0AbAdUCchijYZ7Ir7xPWAGhk8q/iNHRmijTeooG8J2Q0fDwXxGlBF?=
 =?us-ascii?Q?ibLyUCSLEBUJAZMRaIsIo6vNFDgZ7FMUuYIqqbVyOHf/ufdQffE8RQCPwrtS?=
 =?us-ascii?Q?HBfAEdQX3EZSedRu1GQrQahbSKVq+EWyiBnaEABMrO4ugt7yyyKxQWwkxIqO?=
 =?us-ascii?Q?D28/9cZTFBIqLV7dwLtybsn6YfpAjjjrOCCWymef+JQhmgL2X1RBJEHljRoD?=
 =?us-ascii?Q?3/0jhd0d/ffpcKgjsP9luN/sbrXe26x+kGn0o5DTe1FdA6d9zg64mLnwc7as?=
 =?us-ascii?Q?8rkQ2+NSkfxcOrEnk989HMYrGR3C8E7yv48X61wkmAgFXwPmcOgUZsq6YKtF?=
 =?us-ascii?Q?4gfUYHwN3iogShacRHnCctX8CTjj9D78scgG4mZ30Lxn6skaxYA+Ayyp4Orx?=
 =?us-ascii?Q?TKvWRHOtQPQuANKHz5YKFOiEonRUsrdad+1+SZvUlgR365uJhGdK8EC5sUD0?=
 =?us-ascii?Q?a2jJoni6jO1bOsuBVtIr3bVyNYtSLZVat8oZNWluFYVQdz1lcJFycJrGJet8?=
 =?us-ascii?Q?w/CgPDbtBcqDR2sjfLnazr7NzDw2jBMBaaWKJyvs9s+hrsmzxOV8w/dGUUnF?=
 =?us-ascii?Q?V75ckIWI7J6KdneF3c07t365S5VvEQibJdjNO8Gb/CDSIzgIHQN94ygMrNH2?=
 =?us-ascii?Q?ukQkkgeL/eQuIhlX0xg8THxfDzMgYAEEqEEq05JvZSzK0+wGqRjztajyqjQU?=
 =?us-ascii?Q?1qxoibzXHnmdTtej3RcKpYjdQm+xmsKwcRpU0wqpmqxpjj0QxsQgpGMWJw6e?=
 =?us-ascii?Q?Y9uqR0hz64mDp1SQeb9gXx2nGYpR4SVFgK0R5sZlMXSviiG/gz+DeRB6rKM3?=
 =?us-ascii?Q?9sixBxC8U9MyWErZEVK4FjuqvRJmwsM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wPDYwffInd03lfce238jmhMQNhvz6lnviEsE6w35jO4/zKXKABAn2yI0ZrxImg6q8/0lo5vkJ5S8kgC0ov1RbUnZ58YcmOFm/jBemPdbFwpqgoDCgnPRq9L4pmBYV18vO33hs+LUPsWaUrpmUZFwKvPxQKCDRCOrvHtDvTAj2+B/oE3mNB/90Ywnl1SCQVZehiPVD8ZNybw3aRAyplUTZpfd0vMU2L4WJ99R99+a2V50TL2UH4o4YjAzVHCL9cSfPQGP4beYACovx36Pxv6wVnqetPRGadQ0i88mMEBKvjlO51IvJSnIMggCLMzNeguNtdxdb7BK04g3RJ7lGATbyANMD2QAo9P6LpgYSLPRZLgVuWCBe7299dCSXct+I41MexiUufVZ65LHkOuzkBW2t0uDyCF7kyjaceOqr13FeITxTr21h5h6DzZNuNjpdXiimpD5rzMwsUa1hC+yL8lwTJVe2iIbKc2HVMNbY4rPSpU3E/+iZNZoRJONA0mfMclov2tCgZaujCCJrospOdCs6MEJGZfkL6KJlZ5MOdKOlp8U79RlHLL/oxWq9fhepueYfTljl0YpU5TI2YbLx7NDLO+YNsHXYkzeE1gfish8DVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbedfa5e-f2da-4870-5846-08de790d659c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:12:38.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKpqP2AeIP4tQb4+ECaQGGpppwc70X5yx8nueZ+GgLuyazUXyLdlUwF0lnpflomNf9glcgS9I/p7AwEJjg32wz+6qQcHeDxQ55YaUppTS4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NyBTYWx0ZWRfX6nW/Q1e/lsNZ
 fOZ5juqPmUJv1Hb3WpArjjxKlshTQm3a4x0COwHhh/XdrVttrCWjYCzNXpUfIxAIwTFapSbcnSk
 jEl3On9uckJUGYdd86D4F0QJU1+OVhwFg8dX3sfCh8W1xOvK2Fup95Quqkh5F4YH/Om0iHIu+F0
 eQ4mJ1E5kHNJc/rP1z5tyW1ftXffk13Y0QZyb9sf/4Eom9xKyl7mJvfDKo3uD/XTmzGYqpTiJOa
 3OIVlAhKl2ADNjBcS1wLYdUutZ8BQUQoUf/ktN8BHIujlT8PjiDNXf9LSxfmfH8RjxUXihPMUJN
 D+oY6E92mbw+QWn6stZwEJFCKlITVzMtBCavAUsy86sc0F/Q2AHArGzxA7R6KeKBem3/x0jgpqR
 tqo5Wv52j3pVAO4jr8a0P/dgeXAjsHADCf6hoQ4u7Fdd9ydl77qzxoeh06apil2qv6o7t0eHzEJ
 VTZIhujVuWCs3XsvSZw==
X-Proofpoint-ORIG-GUID: a5insEfyiaEEWw7HE09TkMhpt3pvJ7XP
X-Proofpoint-GUID: a5insEfyiaEEWw7HE09TkMhpt3pvJ7XP
X-Authority-Analysis: v=2.4 cv=R+UO2NRX c=1 sm=1 tr=0 ts=69a6b41c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=V2sgnzSHAAAA:8
 a=Z17YVkThqmQES5oVzNkA:9 a=CjuIK1q_8ugA:10 a=Z31ocT7rh6aUJxSkT1EX:22
X-Rspamd-Queue-Id: 10DE21EC917
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222848-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,lucifer.local:mid,oracle.onmicrosoft.com:dkim,igalia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,alibaba.com:email,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:20:27PM +0000, Wei Yang wrote:
> On Tue, Feb 10, 2026 at 03:23:04AM +0000, Wei Yang wrote:
> >On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
> >>On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
> >>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
> >>> split_huge_pmd_locked()") return false unconditionally after
> >>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
> >>> shared thp. This will lead to unexpected folio split failure.
> >>
> >>I think this could be put more clearly. 'When splitting a PMD THP migration
> >>entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
> >
> >split_huge_pmd_locked() could split a PMD THP migration entry, but here we
> >expect a PMD THP normal entry.
> >
> >>TTU_SPLIT_HUGE_PMD is specified.' or something like that.
> >>
> >>>
> >>> One way to reproduce:
> >>>
> >>>     Create an anonymous thp range and fork 512 children, so we have a
> >>>     thp shared mapped in 513 processes. Then trigger folio split with
> >>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
> >>>     order 0.
> >>
> >>I think you should explain the issue before the repro. This is just confusing
> >>things. Mention the repro _afterwards_.
> >>
> >
> >OK, will move afterwards.
> >
> >>>
> >>> Without the above commit, we can successfully split to order 0.
> >>> With the above commit, the folio is still a large folio.
> >>>
> >>> The reason is the above commit return false after split pmd
> >>
> >>This sentence doesn't really make sense. Returns false where? And under what
> >>circumstances?
> >>
> >>I'm having to look through 60fbb14396d5 to understand this which isn't a good
> >>sign.
> >>
> >>'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
> >
> >I am afraid the original intention of commit 60fbb14396d5 is not just for
> >migration entry.
> >
> >>entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
> >>unmap_folio()), exit the walk and return false unconditionally'.
> >>
> >>> unconditionally in the first process and break try_to_migrate().
> >>>
> >>> On memory pressure or failure, we would try to reclaim unused memory or
> >>> limit bad memory after folio split. If failed to split it, we will leave
> >>
> >>Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
> >>something like that.
> >>
> >
> >What I want to mean is in memory_failure() we use try_to_split_thp_page() and
> >the PG_has_hwpoisoned bit is only set in the after-split folio contains
> >@split_at.

I mean is this the case you're asserting in your repro or is it the only one in
which the issue can arise?

You should make this clear with reference to the actual functions where this
happens in the commit msg.

> >
> >>> some more memory unusable than expected.
> >>
> >>'We will leave some more memory unusable than expected' is super unclear.
> >>
> >>You mean we will fail to migrate THP entries at the PTE level?
> >>
> >
> >No.
> >
> >Hmm... I would like to clarify before continue.
> >
> >This fix is not to fix migration case. This is to fix folio split for a shared
> >mapped PMD THP. Current folio split leverage migration entry during split
> >anonymous folio. So the action here is not to migrate it.
> >
> >I am a little lost here.
> >
> >>Can we say this instead please?
> >>
>
> Hi, Lorenzo
>
> I am not sure understand you correctly. If not, please let me know.
>
> >>>
> >>> The tricky thing in above reproduce method is current debugfs interface
> >>> leverage function split_huge_pages_pid(), which will iterate the whole
> >>> pmd range and do folio split on each base page address. This means it
> >>> will try 512 times, and each time split one pmd from pmd mapped to pte
> >>> mapped thp. If there are less than 512 shared mapped process,
> >>> the folio is still split successfully at last. But in real world, we
> >>> usually try it for once.
> >>
> >>This whole sentence could be dropped I think I don't think it adds anything.
> >>
> >>And you're really confusing the issue by dwelling on this I think.
> >>
>
> It is intended to explain why the reproduce method should fork 512 child. In
> case it is not helpful, I will drop it.

Yeah it's not too helpful I don't think. You could say 'forking many children'
or something.

>
> >>You need to restart the walk in this case in order for the PTEs to be correctly
> >>handled right?
> >>
> >>Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
> >>the bit that did this change?
>
> Commit 60fbb14396d5 removed some duplicated check covered by
> page_vma_mapped_walk(), so just reverting it may not good?
>
> You mean a sentence like above is preferred in commit msg?

I mean you need to explain why you're not just reverting it, saying why in
the commit msg would be helpful yes, thanks!

>
> >>
> >>Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
> >>that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
> >>mention the commit msg.
> >>
>
> Currently there are two core users of TTU_SPLIT_HUGE_PMD:
>
>   * try_to_unmap_one()
>   * try_to_migrate_one()
>
> And another two indirect user by calling try_to_unmap():
>
>   * try_folio_split_or_unmap()
>   * shrink_folio_list()
>
> try_to_unmap_one() doesn't fail early, so only try_to_migrate_one() is
> affected.
>
> So you prefer some description like above to be added in commit msg?

Yes please! Thanks.

>
> >>
> >>>
> >>> This patch fixes this by restart page_vma_mapped_walk() after
> >>> split_huge_pmd_locked(). We cannot simply return "true" to fix the
> >>> problem, as that would affect another case:
> >>
> >>I mean how would it fix the problem to incorrectly have it return true when the
> >>walk had not in fact completed?
> >>
> >>I'm not sure why you're dwelling on this idea in the commit msg?
> >>
> >>> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
> >>> leave the folio mapped through PTEs; we would return "true" from
> >>> try_to_migrate_one() in that case as well. While that is mostly
> >>> harmless, we could end up walking the rmap, wasting some cycles.
> >>
> >>I mean I think we can just drop this whole paragraph no?
> >>
>
> I had an original explanation in [1], which is not clear.
> Then David proposed this version in [2], which looks good to me. So I took it
> in v3.
>
> If this is not necessary, I am ok to drop it.

Hmm :P well I don't want to contradict David, his suggestions are usually
excellent, but I think that paragraph needs rework at the very least. It's
useful to mention functions explicitly, I think something like:

'when invoking folio_try_share_anon_rmap_pmd() from split_huge_pmd_locked(), the
latter can fail and leave a large folio mapped using PTEs, in which case we
ought to return true from try_to_migrate_one(). This might result in unnecesary
walking of the rmap but is relatively harmless'

Might work better?

>
> [1]: http://lkml.kernel.org/r/20260204004219.6524-1-richard.weiyang@gmail.com
> [2]: http://lkml.kernel.org/r/df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org
>
> >>You might think I'm being picky about the commit msg here, but as is I find it
> >>pretty much incomprehensible and that's not helpful if we have to go back and
> >>read this in future.
> >>
> >
> >Never mind.
> >
> >A clearer and comprehensive change log is helpful for all. And my English is
> >not native language, so your suggestion helps a lot.
> >
> >>>
> >>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
> >>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >>> Tested-by: Lance Yang <lance.yang@linux.dev>
> >>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> >>> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
> >>> Acked-by: David Hildenbrand (arm) <david@kernel.org>
> >>> Cc: Gavin Guo <gavinguo@igalia.com>
> >>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> >>> Cc: Zi Yan <ziy@nvidia.com>
> >>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Cc: Lance Yang <lance.yang@linux.dev>
> >>> Cc: <stable@vger.kernel.org>
> >>>
> >>> ---
> >>> v3:
> >>>   * gather RB
> >>>   * adjust the commit log and comment per David
> >>
> >>Clearly not enough :)
> >>
> >>>   * add userspace-visible runtime effect in change log
> >>
> >>Which one was that?
> >>
> >>> v2:
> >>>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
> >>> ---
> >>>  mm/rmap.c | 12 +++++++++---
> >>>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 618df3385c8b..1041a64b8e6b 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
> >>>  			__maybe_unused pmd_t pmdval;
> >>>
> >>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
> >>> +				/*
> >>> +				 * split_huge_pmd_locked() might leave the
> >>> +				 * folio mapped through PTEs. Retry the walk
> >>> +				 * so we can detect this scenario and properly
> >>> +				 * abort the walk.
> >>> +				 */
> >>
> >>This comment is a lot clearer than the commit msg :)
> >>
> >>>  				split_huge_pmd_locked(vma, pvmw.address,
> >>>  						      pvmw.pmd, true);
> >>> -				ret = false;
> >>> -				page_vma_mapped_walk_done(&pvmw);
> >>> -				break;
> >>> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> >>> +				page_vma_mapped_walk_restart(&pvmw);
> >>> +				continue;
> >>
> >>This logic does lok reasonable.
> >>
> >>>  			}
> >>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>>  			pmdval = pmdp_get(pvmw.pmd);
> >>> --
> >>> 2.34.1
> >>>
> >>
> >>Cheers, Lorenzo
> >
> >--
> >Wei Yang
> >Help you, Help me
>
> --
> Wei Yang
> Help you, Help me

Cheers, Lorenzo

