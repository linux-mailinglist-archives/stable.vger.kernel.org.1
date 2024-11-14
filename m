Return-Path: <stable+bounces-93051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE139C91BF
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB77284032
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F019340B;
	Thu, 14 Nov 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z5mdzJf3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PRPjNwZT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245613D51E
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609399; cv=fail; b=H9+mGXBLBJpmFp14AW66pPhBTrIMmB+t5yAruPYNAciYVSLQK2V9Lut7iLBNyTL1ee7Tua+BZxKv9AF5/kkFtcdhGrba6GbjAsRPa2m6yFjyV/1g7FdOgGunosIch5S/UazyylYyjT9w4e91QqUuP75MiwOwkDpUc2nQU2wJF84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609399; c=relaxed/simple;
	bh=Jz13bf+Kr2lm68dh3MW4blHPziuUNp5MbXoDMZ21c4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eMvTKce0lJA4ucT8R4y/HJKpCJxQ/b/54cVblo+eedcGxNqvXFnMkFHspZrLhEoCecdpkd/eWKFG4XrtYbfdhGXwKy5PgpzOiC3F2w/BRrPE0qjFDkD5qc4CjXP/MDecCN+fDNqDi/jZQW5iw0ooYv2RopGori7VyxlAJTohiXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z5mdzJf3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PRPjNwZT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECSjgm008280;
	Thu, 14 Nov 2024 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Q1BsO4RAuXmnQcuN0ym81jreYsBITDa4yPmzUV3QhrA=; b=
	Z5mdzJf3K+VQqEPHOLrZFISI9U6DDOELuYWAtkabrkc5BTbV4xT8YoJQVWgi1rpo
	EMC8lBWRyq5E137SWyvUZpLpbEKsbMYkiHo1oaGavm7FrzIaPUjfhjfCajntbIva
	e6C8Q0XkBTrSiK4OuOFO5aLM2V4a3tNPktAsPd9oO9Q2BFJoPor4m1shYy6/bOMK
	0Zx3cY4ePQkzMNjX5ysC5DXJ2wZS18fd+iWtNHZVDrAnebKOO+3W7f6b0Md9nKn4
	giDi9RopnL5U+IpJibTQy38m5VguByEHUmo+E5llV44hxyoF2Kf2t0n8JTmHRHqg
	yQBM+ezB9BJfGPC+43W6sA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51x2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEI0NQS025859;
	Thu, 14 Nov 2024 18:36:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b7m2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfCOVm0F/R7YQUwFhquY5VHF89+dGJHaBbZPR1L31EKIG/yVlXgUHcEWwYhrt+lZgDU7xygnGhuH0jrEOplVYJCQXrbnXn9N6MA1bVE60Czg8iCYHaxS8ALXcbHeTSSgIp3Jf+5f+orM3WwVv3bjf2okyK2+5a7Jd2Ub3FF0Jm9754YNkYR7ACDBXbTqElv7J1nOXou4VnpMJWB2a0ZpUu+wULlwOvbZW389pUTWqbOTCmKiJg028ScnBWvZeT6cG6lfh8xjUCX5GUNzNQ1yionLVyr85IRD2IWdtFO5hZkq4d/KWUxbGC0RaXXXob95+8GeefikdOvjXhwIM0Qj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1BsO4RAuXmnQcuN0ym81jreYsBITDa4yPmzUV3QhrA=;
 b=EncNPYype5JDl6ez8F7TKFMHICmv68TN6V+QguvW/yqbuL4dNvS7SfbjENCh4uiAO75k/zbKXydeSAaL95cBboQlxkQy35s9X8bf3NHG+lTxCZxmmv4KC7yX4g8HFI9bJja3CLt/1hr7ldH2g0apppJ2QoCQlsqsObRTJz5V14xB9B/yXDpfaMmgiqB6jBU/mmXaddDMQJufnzA2IktuL/HR4azF4GgSt184Nqh8Z4OmIADnz7MZ9S4z8RwsndCMtB2tEBttOvQMsBhFGoWF8P7QaqJp6y4O+WvZh0CQEfHTYvYjZSPKgMbDrfP7DFoj3czdnpx3V/Gh5b75w3w3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1BsO4RAuXmnQcuN0ym81jreYsBITDa4yPmzUV3QhrA=;
 b=PRPjNwZTI696nT41C7rqH4hyspLRSH6iMU8RnOhsVKCAPfsX5X0gN8E9EXsxMUH4t7LfuMXbiCFkY/d0zEIcNKPR236HO+8ip1lWvys82gs3zmxZIGE24JFGpXwp0uctI0Hrj7FO8drTko/TaD5atN8fnjTy573Nh9ZxvYKauAU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:36:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.6.y] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Thu, 14 Nov 2024 18:36:04 +0000
Message-ID: <20241114183604.849100-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111142-caucasian-bauble-c88c@gregkh>
References: <2024111142-caucasian-bauble-c88c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4057f4a3-7514-4616-2ce1-08dd04db3618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qnec15/bQXeErOvFVfU89zcS+rcrB3OVpjlBgL2Hoq7ct0Z6+CsSigwhDm8j?=
 =?us-ascii?Q?9CVT3Jm6Jb9O/G5fHnzkiT1QHHWQJOxnTsi7RFjSE2gjiO6K7/9lS33fBGyG?=
 =?us-ascii?Q?XJ3Q1VlAjLhpOe9Tl3+UoyKZIpOkHrNIWzw5iTRO1weS6JMrGnjvF/Y9ZwJT?=
 =?us-ascii?Q?Lz6sQ7vgCNozHYdzl/ud+WFIDH1DMp7JwajQyA0oRsvaZMrHWn07YmhLg+hz?=
 =?us-ascii?Q?LbxNpRUU/YQnLeJnKVr6l+ZmNuVfDmcFIT7P7aNWVHM/LHbKctgiqnaq5wKI?=
 =?us-ascii?Q?a7e6ZhACBxnI+mtGOdrVSom1s+lu64exscff6qJQm+/FU345tPcb5qAa/Oa6?=
 =?us-ascii?Q?9RHpndrrYsLgXUod25UtQUJgqH15jmg6SKC3+EWzY/cCR+aXPSmeCQfbjjdp?=
 =?us-ascii?Q?BekSauRc2r+xDUCML3bOK5iR94yocPzl7kw2Fg4dUFbwzTWB/CKKWIyL9ibU?=
 =?us-ascii?Q?dc7sNQqB1LhEHxIZrpBMoPQC58615R6DtYhvT4dOcmzPFsvCTg02QnOGeYyV?=
 =?us-ascii?Q?oTFPsUOlpQyVAhq9BBXQp8xHCdD3CRjRzkkAWpt0Uv307LDUss0khP/aJQV6?=
 =?us-ascii?Q?r9Kgr6sVaRpwSO92PKdNSAH4HmCBcG3fLVH0Wqf8wu/Ix0KmFuizXUFRhHuU?=
 =?us-ascii?Q?wgay50mSjVN1+T0KZDDHNhtxWkJJVU8n5j35YAq5mEgfkygLmqYQ+Nl15CZs?=
 =?us-ascii?Q?PhySS2XxMYf/s4py2Q613sflIcLf+AIF1YB4ipq/OjM5uPOWXdvgaZLPmDE4?=
 =?us-ascii?Q?wNXNK+Hh+wQ8Y2g0bfxATEQc2ZrfDW8Asnj0qlEg/ITAUWjtJjQNw/smpWZo?=
 =?us-ascii?Q?vgcy5bYsQ8+qF0Vd9MqxIhmougIzPW9six1DaDq8QX3/xP28L2LevDHBCBf2?=
 =?us-ascii?Q?99nEpjZlP3TZH909nWpIp0C7SExVPk8sVpOod2tWoL451xL0ywZN+T1znpFH?=
 =?us-ascii?Q?EDsWHKAC+4QoBQ7hWbo8uKYPvsmzUvauCkK2oUI6qKBW2cgujRuQS02XJmcb?=
 =?us-ascii?Q?7MO6GFJNTq0IXpl9m3PQbFDeW/iD64tFigLJ4atZzr/RVzyVRLl4j2x5viVh?=
 =?us-ascii?Q?ud22u1ab0Sf+B+0I74nd15WgJYq+rLFSAd25pcbtPOTAc3nrVBpQB04PtIGn?=
 =?us-ascii?Q?bpxssW+0XYPZ2SDAfa6s0A08/d7pv0kyYx7qGvRUrnR92Pe8NOMPxV0ltMnd?=
 =?us-ascii?Q?kXV7dRagZPFkkCRKIJJ0iqoljeq1hSU4AiwszKkEmpl2fUL+tt7jJj5tzNqx?=
 =?us-ascii?Q?/dCFmct+SQHTGTIgj/52nXFw5TnfxgNUNtQNhYYkD42CvEQbQFDqViCjG7Y0?=
 =?us-ascii?Q?L6NA91zpS7Qbq1tVU7PgI0bf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWL5yd/ZCaBausZjYyg+vohh9qtlImFAWi//JR0s/7NoFt0aP3h8DxDE0Ygu?=
 =?us-ascii?Q?H0oMSDHLUZlHOBQoJ/QgyeyrqLeInjQRzz5+46ovm827hYFNA7OdRFkubJqF?=
 =?us-ascii?Q?VRvkwHj7Rfy32qOIIpxsRbUqjdxJqoS2bPgB685f6rHyI3B0T9Q3ifJD5vZ5?=
 =?us-ascii?Q?R1b+2HhAhcIJV/X4Vb7fbwy7JuIA7PdLE+AvCZMIm3X5DGdVulPuXGiKMXfg?=
 =?us-ascii?Q?O7ZXbcmQjhtAj3XrQl7sp9KuH3ek2yIwS22VXa7Q9L21mgmVUkSvqPp9Yv9R?=
 =?us-ascii?Q?ug7epgGvMPoY0V8D8UWlykbpVm9/owiv6lU8FMxlKh0vNWZ/DisKUDQeXIOu?=
 =?us-ascii?Q?/XdJkXMllb5/xdA3qe3Aoeec4gh6ds8Wr1DDQU38jfe7bnqVtqfx4XEmidMw?=
 =?us-ascii?Q?AHELDnmf2/o6FUkGK66DKvwpHonvd2TgWNIoUa6D4LdUyN7LPi085+9Pd0D8?=
 =?us-ascii?Q?LubQVNYOhrOXw0njsWU2QfuFI2EcJKP6ivu6Fys4dKcObo0IL3Imhn5kp9fc?=
 =?us-ascii?Q?d9Q24LDWlMYg/UYbGRfIN89L2aKxEar3BbFQyHS0BKeooP+9EVePY1uzC7Py?=
 =?us-ascii?Q?kcsP8ZDUvgIAZP0UlPF1LPnwln98zrqiy5GhHVvvJig0aIM63umdsXGH604N?=
 =?us-ascii?Q?GRs6Qf5//ytTVDNtQ4vDJXn57pohf9QHozT0TZm9PLC04SBVI61T0+A4fNdI?=
 =?us-ascii?Q?Gsd2sYjXtVEPM4j8XxfCNezBHwaHmDGaHE8wgV/hGN4uBSf8cORf8p9Adzfh?=
 =?us-ascii?Q?XMZJlWpf40gYh+NfOdnCsSJ8VXmSRDmDIUrPGUJyHzRHims364FkardIJ4LM?=
 =?us-ascii?Q?9VNMnQDkRnklukXoYKj00i3gRVgHsk8qcU6EcpSd3Xf0I3HZZOZ1MOLVVkAL?=
 =?us-ascii?Q?iI52e66z4XDoVXq5gu31sdcKWBBlcvSqoJvcdSoq3olOqxDpcHjzvtRln9C8?=
 =?us-ascii?Q?PFxFS3VZxZkH8oV5YN32aKWbdFiowBTu3B0+zQh2o1tIAyH2Y+dEr07cSx2m?=
 =?us-ascii?Q?tSQXQ8a1uO/cLcDyJxKAhjL1SMJDLEwFNoTg6PyG4nXSRa1iF6WF059B2Vkh?=
 =?us-ascii?Q?AUr1bAepz1qAclvK3kDgm6ia0DepdMdnkJmXeY8XNIU/EE+Ht9xnVW8LGf3d?=
 =?us-ascii?Q?VZvy7Ga6lCrUGduHI7pJ9AgwqIt5rR0ndUBFryv9KEDT0Tnr7wrnPIEFd+iR?=
 =?us-ascii?Q?fjxeZyM69egjENsfoto8DVYY6TuQ2y4Y7zS+sTS+tr5DQ8D8VFUm60sLj37b?=
 =?us-ascii?Q?NSw/SCUCiOzkqsIE1N/qfJI5IpKfD75FqdO6Qjt8Ip99lmw+KbQkWpli0e4S?=
 =?us-ascii?Q?gkKw46mz4klRSFQqZALGQWM63DDzEqrBJvK2ntEBN4FPGUwT7dJFR3jgG5QE?=
 =?us-ascii?Q?n6gqrAYyZIdqK/zntCdBacgnI0oO4zH2lHzMVeb2crOjSZYT9cVqa6lRZifJ?=
 =?us-ascii?Q?GWUCY9iI65msHH/X8KpEVP6zg2mw8U+oj5TYYy2tNfgL7Y2BYqdiLdXdySCO?=
 =?us-ascii?Q?YNQUjFGJAPP6jV5bC/E/f2G4AM5Y5ADNbBJwjKA/IJn5LTrBD4ME9BcKlRR2?=
 =?us-ascii?Q?30mOmig4yqLV5SRce4jnkfFITMpy28gvMA1k5aElY6zdVv0NnhtBN+XM54Rx?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A9FSyXIeWYIjJ2Z/QQ+C+IU5jfbWx+CUUPOCiYnIP7DYB7b8/RB9F4uWzQXmJxLWASUOoSwDwigUIK+843MGkOUMWG85yugg07KQI1cgPJpcHOtB8+B/3fjjdp4Wxk1ULsNlTnUZJdArXU4qDZDHlpMrQRi198CNsAYVUMpoAyacyER1BXBSDDX8F5XbzbBPhelMRt8uWi6r9axIJV8eLrTkdM03/4R+abKvbrohGDtYNAakmFjQnPL8uTYCmK3KnPVcIxQ0DICIVZlgzfM8HfC8zaZLDsDTQmmBctCNSzbnq2E6YjpTVUyTdW1azUGbpUBEdpqxJothaYFob+5RMLLYuH5ff+NRayezDfjFtT3DFkSvMxyN+AmZs1cksRMA0NdlHpw+QiXrsPNSndRkOU0oFMj5cZwMByNfofvqV8fijhmXlVmuqMbjoSi50UD0CYoUDfdvT8oE2XAOQdhNGjcyuKysazbWj85/0VmYHjypq60g/AOCImNBIT3By/R2nz3E4Q9TV+oyax1pQtH1HnmrxEVF72VzgVKB8n7lDkMnQtnXPb8521g+OCgbcexYHXPOvo9UGYmhUNlKvzqQfSCIQo37DNasFpV2zb0LjI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4057f4a3-7514-4616-2ce1-08dd04db3618
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:11.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L2EmOfGt7aa2FTsVuEjuyj9Sd4R/13Y5XQroZJN+ull3gy3g4cJot2qlKho/zydbDRjkR93uEL/Xfd/nbwlxtdBe6Q9c3kdJQWCz8ceGBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-ORIG-GUID: ZnUl_b5R_4GUQHgD3U6xW4XlCxZvFbWu
X-Proofpoint-GUID: ZnUl_b5R_4GUQHgD3U6xW4XlCxZvFbWu

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks. This is currently not enforced, meaning
that we need complicated handling to ensure we do not incorrectly call
these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment that
the file->f_ops->mmap() function reports an error by replacing whatever VMA
operations were installed with a dummy empty set of VMA operations.

We do so through a new helper function internal to mm - mmap_file() - which
is both more logically named than the existing call_mmap() function and
correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn). The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic way
on error, quickly exiting out.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 27 +++++++++++++++++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ef8d787a510c..d52d6b57dafb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,33 @@ static inline void *folio_raw_mapping(struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &vma_dummy_vm_ops;
+
+	return err;
+}
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/mmap.c b/mm/mmap.c
index 6530e9cac458..8a055bae6bdb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2779,7 +2779,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -2793,7 +2793,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_config(&vmi, addr, end);
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..e976c62264c9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -896,7 +896,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -929,7 +929,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * happy.
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		/* shouldn't return success if we're not sharing */
 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
 			ret = -ENOSYS;
-- 
2.47.0


