Return-Path: <stable+bounces-88099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789889AEBAE
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDCAB23744
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2581F76D9;
	Thu, 24 Oct 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SW65nOE6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qk54/eI7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD31F8183;
	Thu, 24 Oct 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786704; cv=fail; b=SvkeOjxArkn8kxtobOWMTl31kZYi/vNCtqpwuRpNwcsDI+VFITRAMlCt1Ry+t+BYVoxx83jJOs4MSRnRfw92Fw0xVc0sHySJF9+lDXz4ku4v0qmLMJnKVZ0S9sCINQcelSxFc8Q2RqQicKhH27tH7xHrZw6aBHuR1hbfp2JK9Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786704; c=relaxed/simple;
	bh=QZLKV9WyP6kQ0zOSKQQwA6qQO5ruy69dNKWgMHOr1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klv6fi4l4SD5lTevkocGYXISN53x5Kgus1zMYI/GLe1MYiTUoj7HlA43Msw/JOicnXzAkGDig7mYwSTi2As/qm+fzl/EaMgamFBSzB1ej6IP2NwvGT5ZwIp7w8JU87jpi6N4igjYHEYoFQHkOimaLrM1G8GKkWq+9sdJ26LNaPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SW65nOE6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qk54/eI7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFtxbs031886;
	Thu, 24 Oct 2024 16:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=B+kgjEc9JTwTsjrmuW
	pDdiSpoJW5p9L/oxpiT1EMVXE=; b=SW65nOE6BMOWuVGJVD/iT9tur68aozezA6
	OJSKKQnwdO6fwYPFnt1byp78jI9VSLa3fprRfMf6Ybvn+aJ4lACGvNRRlfrIsnkB
	03uRl14Hz2ycyQOckdTT1GkL03dX4D2iIB/M8F5hlvmu/euLtEWB2hOFK68T8LOP
	LSP/isnlWvoiwmxRSBZ5lvKnyifesAFLHx843pWKeQ5uuPMVnXSW8s4k2GNc5IhM
	dTaOzyh92yOy6pilgUG5N+HXWgdCPC6vNsk4JIKy7ldINUzqzZBcXWwmm1KyoHrd
	PmS3vB8H1DiPQuck+VWf7sYH2Cf6SbYP49RIEoLbZVHkDj1p2dng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr2bgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:17:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFo24A018493;
	Thu, 24 Oct 2024 16:17:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhm80k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSy2eByqkN1niPLwD2XB1+K/3gAX1IRLks/aAgZNk+RctuEBPN+LJalzFCDdZC4yNZOfWo+587eE+9Q4KfgqxDjwxP+wY/C3+HsI5at6mOEPxp0Xo8AYNm/8YkbwkLZzUB+8MxYV6//AD7FpcnB9v3hnr4Xw95licGCMWj9VOp044E6Vt1yhFd2TQE6uF7LeK68ikTI04uXF9rrwNStx2AnOuJwcf8DwBo2o+SWUKEc0eUrnIEPfwDHhRBQaot+2stbGg6yWJgazcI7MEc9/9IL4M3uO1OqlPk7GjQy3SqMUVbsyLTp0qwVW8E1nrFvOq7sJeYKG23q5lhMtFYg9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+kgjEc9JTwTsjrmuWpDdiSpoJW5p9L/oxpiT1EMVXE=;
 b=hBoeu/rU7ha4HOJ0vkK108ZrY3r+US52uR3Jd3ZL8nKGMJ5iaa073jv934Jz/eIkjPjJ7nCUUE7WjfKR4u3u0ttrnT+coCAaQRFDMHgslRcg3NUZQCI9eiqXyWRzeN5KisZaG11oYRv2G65jbELW9vOZQDaBqwYpkgW+HKtkeFMrBvHHI1xoCHF8IH4PqrTcs0edkEDQ+5D/Kjqv2fqpms3KWV83l6tvx1aK7b9MLwvP6d8mIG6ivWEWGFD863/jwTWvmzS15itlUtDN1jy6x8rofdYN27ZsNqAFYZRAyAeIlcwU4u2AWvvjfaL+sbKSdRz7M0I/Fq1Sp7uZv2W9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+kgjEc9JTwTsjrmuWpDdiSpoJW5p9L/oxpiT1EMVXE=;
 b=Qk54/eI7GORs1euuJzroiVmJIP8FYMNcOMF3Bg0iszHVO6g9rGomHCAIaHpkxaiuYwrfU/TGMXo1VGbztG4zC6d6UbrIkI8201+vsDu3lj/WYJ6rkmuqEN/FYicifQjHuzIRP2+gUTBLUChQc1dF6MW73KnP9cw3IJjq05No9X0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 16:17:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:17:49 +0000
Date: Thu, 24 Oct 2024 17:17:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>,
        Michael Matz <matz@suse.de>,
        Gabriel Krisman Bertazi <gabriel@krisman.be>,
        Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Yang Shi <yang@os.amperecomputing.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
Message-ID: <e423577c-c1b9-4420-9237-271321a9738d@lucifer.local>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <20241024151228.101841-2-vbabka@suse.cz>
 <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
 <5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.cz>
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb185f6-f658-4afa-63c3-08dcf4476711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaML3oYeUo4qR3Kzp7nhKrNbm3PCtZYtOKYSk7YoRYz/syVYS+ghUpwqhqEs?=
 =?us-ascii?Q?hAI2jnBs0hb+Ft+RwHWwqKGynLHeB+kd6E5s5LdGxVQE+25dByzb+IPPsYid?=
 =?us-ascii?Q?PcHS93rF9EQavIEfzd4vzv9Tb1KnpI6Hwr21lfiHqydUjnBPF5M7+3aCPtn1?=
 =?us-ascii?Q?mUt1ACbkcqvVn9ERPzYkVat91KNrfAPjCE0joJsODJsMshilGYXkwZ5Z4T0+?=
 =?us-ascii?Q?EdonvAoEEIb1rjh4WnAYcOzn1IyHCnc9HDjkmaB9fMSAD6fVKtWLlzh+jTgA?=
 =?us-ascii?Q?cdWHtI3xYH/B1dwCNLQXFLT/dwuoZCW0u67DO4h+WAmASfPePiLEHZ0Vq8Vm?=
 =?us-ascii?Q?PohGeu9xLkaD8j9mlXdngLaCxbd+zEXVPEauQeiK3HDAfqVc8y8cLTX807bJ?=
 =?us-ascii?Q?8XHRntqOOnhewa3CHt1Y1BLT+c0a2Fn1ldsajRPJYJ9e4El2fjYbxECTEOBB?=
 =?us-ascii?Q?+ejiEx+AoO14gDXH9jpvLx7CKKBkIrCZshd8XSuuOMCz/tPesIY1a6pS7pRP?=
 =?us-ascii?Q?iDeY0/iGSHZGPxtnlkxpqt5Vc3+VuQ+xHxUqvsxflWaNY7Jw/DPDo5yxgu61?=
 =?us-ascii?Q?NgtNkl1iEAtsBM34/ZA/ZKO5Drezohq93gTlzOnpDXZ2rGZXBJ2ggh4eLu/W?=
 =?us-ascii?Q?7gKoejYOO2Do7L7Q/mdTz4UjUQpfjtuVZLv8tLOgF0fbaztgbd762ODybewJ?=
 =?us-ascii?Q?+Rl7MGxptlgGTTGm4GNPduX4Wc3kxONmVH5i0YygMhlH2Gzq48sfKwkIEKfh?=
 =?us-ascii?Q?o3Fer4N/p75xplvg2TXOG9KV9rV5S41wdfNvNIwXvvwcMVGUgeEgcOS+hWT6?=
 =?us-ascii?Q?katk4ZPy7ipk5BLSm1vqXigACOtNnfdzBmPeTzSfK8KMG1xp3FXYqATfd556?=
 =?us-ascii?Q?RTyEiIuY1/RY4qbRPrvgpbUOoNsubCaGTSVlK7NBhhg5DtoPfL/2HiyWsC3D?=
 =?us-ascii?Q?vkTfru8558lMc4B/O947ny8ah/h+UUTf6bha2fGHlEbsJv6neEaxtLJdQgl8?=
 =?us-ascii?Q?gEUMVFHe836wP4sSU2eejuHg1XqPuGNbv+mgax9u93U2zyXZqEKwxzZAPhYI?=
 =?us-ascii?Q?RNd7rRJWpQ6Q5Vxd3QPTicR5Hndw2cycaQPDH8FZIWOX6hfU+LQyyLrNISv4?=
 =?us-ascii?Q?lDc3iXq1BbhVJ6mYBNgHH0yRrj1m1cHSDAL0XHE7gknTFVBad6gbi2MpTi5k?=
 =?us-ascii?Q?S6fiMv8l9q3kHHojOBtSEtRbJzw92ChTxcFfziYmIhuMHQs8J5/5SU9ES25C?=
 =?us-ascii?Q?HXuyuWGByAAgxqDrIt+N8HLTrnwDE8OH7cok+1ErJOVSaQjl/KHqqQ83EsJa?=
 =?us-ascii?Q?boLyHoXtBAIUGyIRCpQuxqOF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RzyIq0hZyvEfjEa3mT4I3r48ah81TOCEzzgKce8zZkU51rdg1CXmQVQ2PrTx?=
 =?us-ascii?Q?+86pvElMg4cJfuHx77CnSqNX8hPtipIFLUyJjm+PND8FeWR4TX6SoQKnhwaN?=
 =?us-ascii?Q?e8eCqPcUkMQN0C19mBR1HSRkqElWAJezcLWsc9/ejyjVQkhNEuGVUWbwXiXJ?=
 =?us-ascii?Q?ERocaiidgzL6P+VHuxCklAEVjUl03f4MiBZACjrQF1DPQc0hCUT1oVDWgs/D?=
 =?us-ascii?Q?fHnXK+lHVD+sJOIiusNq+oZjofcTkBKNoBZ9ltDhT7HtrP7CuBJUJ+7LgRN2?=
 =?us-ascii?Q?n4s+8S8zT4oNxDhecCL4VS58U7OJjPO1pSJ9jUI1r8UJA6VfAX9CTxmwRvph?=
 =?us-ascii?Q?I8oXHVVm6rjiBdKi0J6q/ANXGaIj2vOY4ODyfRADq8D+NfT4Q03Evl4t1OR8?=
 =?us-ascii?Q?Df2iDgeEzmtQ8241uHn7pJ1kPP7lixgshDN9l023CE8ACO5Q2qZyIPyR8+//?=
 =?us-ascii?Q?8SNMC1FJ1L6sUpedlihDYOEj29a0JA8Q9TuZJWH7AL3dSNzZPgGOQan20h0n?=
 =?us-ascii?Q?WeCGf7ikpAQDKWKE/Wr5GAdYmHFMoacVuCPHwciYQdzUzlF/2tBAU7sTxoFb?=
 =?us-ascii?Q?xzadAR2N/l52eehMhXAKUxBVWTVNIaTmhmrTUPKa8hb/lCKUEO5XeX+6jmAg?=
 =?us-ascii?Q?/k/bEycqgJYGVz/BqNCsQzDTkDpFcDuK6TyoVWXYlb+IbM0m0UwKngAn/lD5?=
 =?us-ascii?Q?fNerTC0i647GuGpAh4E/uLJrt4AgOPh+9cISWTpWYDsIseiz/7AD02dw2nnl?=
 =?us-ascii?Q?m9w26hevSSsMH+UnmQxIotqfh/MViHZp32U1fyoTGvUVnHWDmXL33gALI/LR?=
 =?us-ascii?Q?58LJo7+5pJigXcO34sKc9zDTkx9V+a9T0BYMCPFchr3VgxcYXF5RdCug+MJL?=
 =?us-ascii?Q?pvZw/yAUA1NyOSs9aHCUlZYNcmGDnMeuhfge8bxPZx5PGHCDqO1hzBmEivh4?=
 =?us-ascii?Q?TpisWGsPyeyugA2tBXYe6r/aH03shx0D2m6qXE+1NwdZkyDAedt81nj8TDyP?=
 =?us-ascii?Q?rYi2304/ONIKVuGTtKrbU0BdiexBmQJ6i0PVHsjly9fRDYt22HhQVShpQKlx?=
 =?us-ascii?Q?W4hjdSflNzPmnm/+2zgMpmm4HnR0HCEnfxiDeMUpnaWTzvn/co234I89XjwF?=
 =?us-ascii?Q?pu0jQ+IrNykTEtezDyW2QSTVEC0xvho+ZQgWbgLAQZn05AADy0y045k8xUfo?=
 =?us-ascii?Q?tL2TiHvwgjRf9AoNOuBueBgz1P6kLXaalYAhed8WHwIZitPpv15Bd0HQusKT?=
 =?us-ascii?Q?jgSLlpnhNbGyDl3Zj4lvq0a5efnxpWdCw6XDj4deUU3yxOcczr5JNl/moiKM?=
 =?us-ascii?Q?cnX1KNPZDmfsxhmB2ipCYio13PvuKdimR8pBAyW4QhDoi3y4JRGNxuOGhpBs?=
 =?us-ascii?Q?rjbFCsPDf0tdVhf7mm+cM/fSipM+qgNgfgYWmkfsjIUom3IzxMgupQntxtrq?=
 =?us-ascii?Q?qnv/QGEaLuVqmUt1A36mO/k0rpG3zh4TeYJ/ge2dWkJGFxY0fKnkt6fYngY1?=
 =?us-ascii?Q?/dtNoKOWNy+rJVMPDLi4weGXb0Dic4DsVrq6BmcKGFKnuikf6jMUyy8mMMAu?=
 =?us-ascii?Q?PlVcXtZP2X+RUSoUCR2tlKitfa3onJLMetyM1gIIfjPtFDsMX6vGX29nB5Q3?=
 =?us-ascii?Q?1Lc9PKtmylNnoEKb6pz6WDJ4pckqrrm4kFfc27Ck+9c3eGUhPBLrU9XTxQFz?=
 =?us-ascii?Q?Ar2tbQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	faIV2ave8yshKM2vp8/thoseO5+cPAF1VSUqcVBULrLxcOKnXtm8/kyhGCt5q7cvtY3qCgTK9bqAQTH9IPPpuEZilz9SQUa4STbflJTPDMpA8ubsAIvmQlyPaE6kHDOZYhKuhP6LZx2aoTLiBZ6XpFFbNWLHNyB84VXyyIl6BZN6WA8ozX8fzEYl9AgynS6GLVQVTni1SMLB4xbbe72W0cH9tw+V6GwyyQMfrMvZjwBGrtCTKt4Qn+4wKp/ZtWjaP7jsz6Z+Ww++H8JwUZSlRuieoza18TMciCh4T5r0/IkPoyfo/UrE887hD6hDrBW2/kkBP0OPzbI3ZQFZB2wu/BXIJjpxed1DhYLvPuFdRMFx2q1+4FQ+FyvNRQzApT5UNm8R0yaDxDT+FItITEz8qmHQQA9zR/JRPdR715ALGucjOafsNnJKvEbk4o0lMKo8STeCplaUH1+5+oUKykbs+Xy+XKNq4rjVLCsbEAsMse1cw245W9xIu402Ggf0T4mnx4oM+zCnBZXZPdaj2P4NqUCe8nLYHhdR7u+Su+PLP7avfHMsUVmNyf9BhcnXL+MtpfSoFwMUCzphEC4lMvi3TJyBa0TfDQP3FT6blztBoYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb185f6-f658-4afa-63c3-08dcf4476711
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:17:48.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mHyf6fz8++ABjpZZwgUmRo0mK7chXttatgcUWCCqNP8AQ10s2huyteSTbRaA9m+JUZMmYxtqQa0Xt7soQ9GGpRlXeEluKFcqW38blWVBfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240133
X-Proofpoint-GUID: 0EAuvlRad6kN7ijQ_JXYRhHIBzj8iMje
X-Proofpoint-ORIG-GUID: 0EAuvlRad6kN7ijQ_JXYRhHIBzj8iMje

On Thu, Oct 24, 2024 at 06:04:41PM +0200, Vlastimil Babka wrote:

> Petr suggested the same, but changing  __thp_get_unmapped_area() affects FS
> THP's and the proposed check seemed wrong to me:
>
> https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.cz/
>
> While it could be fixed, I'm still not sure if we want to restrict FS THPs
> the same as anonymous THPs. AFAIU even small mappings of a range from a file
> should be aligned properly to make it possible for a large range from the
> same file (that includes the smaller range) mapped elsewhere to be THP
> backed? I mean we can investigate it further, but for the regression fix to
> backported to stable kernels it seemed more safe to address only the case
> that was changed by commit efa7df3e3bb5 specifically, i.e. anonymous mappings.
>

Ack, yeah totally agreed - sorry I missed the fs usage before, see my 2nd
reply. I had wrongly assumed this was only used in 1 place, where it would
be sensible to move the check, however with fs using it of course it's not.

Gave an R-b tag on other reply so this patch LGTM! :)

Cheers for finding this utterly critical fix!

