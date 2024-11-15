Return-Path: <stable+bounces-93528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA29CDE6C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1701F21A20
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8A1C07E7;
	Fri, 15 Nov 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dGCFj9Ea";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HICE8gzk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA11BC07E;
	Fri, 15 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674353; cv=fail; b=Uh2EGOamCTvVRiwDYSYtCXrrjKgfwPod/7FnXNrUdofi2xefOLTfBWc3BA8/GOgfDSm+WFTZAb6ESwR/KKbrB+R5KN2wWxb71gX9hvevQvCQedi0j7ND/uClUB98mdRLAQe+HDRdy1dWMCpfE1krGYmKSG6r+8GfQMKm7sri+4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674353; c=relaxed/simple;
	bh=o/2flovik/z0yUaXkz0y5sobawqIjNYQ0dcvGKorQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHFNYvTM0oyohzMEKpka98biTFFAp1huUd7OYKuHdjju+i5MdPSewKJDWeib2I+fTNw6un20LfDIuFuhTNLXd4QRN5ptTyryTrBovb0i0fBvpeBOojtm49sPmn4q6L+AxrUeL+M8diNkjbTaiQZ4EKaX7d6fNT05+R2LHnHY7sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dGCFj9Ea; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HICE8gzk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHAGc014379;
	Fri, 15 Nov 2024 12:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wSSFsDJKNEnL2Ec93aXMbwQXwjo0SGvX0HMoMi4GdeI=; b=
	dGCFj9Eanr0yGHt4VxkQ1iqtT3dIzpkMsusb/gegyjtrY0SihgFmGZdcq5QMvTeF
	Iit7Az8zeRttXJ3prCSufVcONJe2kvNJdjyGWkj3X59jf8iS9/waPcn10lfVod0b
	iuXaMKwe+UCF13Ab98TOU3yKwiW/OH+0ApEpRMWWhqdNOfcQbQmO1B5rnOpbSoan
	dsWJYc7PeZsat4PIRK1jkeao3cZiaMGqXtkqGj2pSHhQuUt0YMwWnKlabZTJYg4A
	nOle1mKZUhC0VNgRXOLU9GynpYolx3S/oL9Ycru72yD4k7yV1mpm0mpoXV4h37vw
	A/1fnfUgmrA++pxsinYvSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2b9fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBQQPT022877;
	Fri, 15 Nov 2024 12:38:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mq3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3I9u4HA281oswvX/PdmZYHAHKKTjqzKNFizhRgDBQRA8xooPfMC2FejuKsLs9tjmpT2IxXdBPUGJZY+nK6vOFqgc9C5z6WeToRnjnCeRRmGhiAqHkDYpCrvle/98Pp0KfqZr7wyBIWYwgkmcHCuYjH3uBG3ulsHh/T5ustqfQ9GSFg1orpU2lgMKbdAo4RF2xUwoYPPGO9K0OIg1R8y2gee9/DQGd/p0qmQWP8cxkafW8XSoM0vBxthR9wSjqyJKaDBXRpK5GOMKUQdP0rxTJc7XiTCDW1C31B2iPCwoOt5inQGAhjHc86vfly7ib5Dfm9nyZ2nDkCsB5fZN6+RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSSFsDJKNEnL2Ec93aXMbwQXwjo0SGvX0HMoMi4GdeI=;
 b=LMhnpdTmUyZkCJrofxGZaPCC2Vu2oLMizYmUeIzCW1Z3zBsBf3PloP++NiKYqTlhJA8oSGrL6HuR4EcIeuHrCzVlZKp6NiQ3VU70zLy2hIQVyb8Brij+rtsYyWUH4oSwTEnVDXLLQ3YcU4hEU43icm9IVlV45JIMeniGU0N8Q8ylwMxUf93tZn3aqJdIRzAhtFZPOJhNVIXKb3rHFF828OKTqzzsYqiZinm/Cvnnj34mJNpggB28K7bSow7nw8TTc6mEyMSjXJkpjr/gRxlizyqTZIeFnIC7cIdWa+LXoK1drN6gymG/rOjB5z3exTS9Fegp4n7X3AcOInAyIV78eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSSFsDJKNEnL2Ec93aXMbwQXwjo0SGvX0HMoMi4GdeI=;
 b=HICE8gzkLcl71zT+fEiEuL4FbBqoowOyaLUiPyG5iAueKOErowPqVSGGsB072mHZak9tMbl8KNPUgAjoI6d615os6VGOfWMGKu62xoSq2yj1/f/voShDFe8okC0J3qZ4CHOQP4x3gtnVnaw9MUPtIIAENpAu16RtU6FL3YGjdYs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:38:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:38:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15.y 4/4] mm: resolve faulty mmap_region() error path behaviour
Date: Fri, 15 Nov 2024 12:38:16 +0000
Message-ID: <03d88781b023104684f07a920a3e3b205461e419.1731667436.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
References: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fa5182-2064-4ac1-c58d-08dd0572727a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFQTBR+AWM5L8MbdO77BT1RAuyq6E0TAe/eOr7XYtA2sO5GYVbMBblAI0UbC?=
 =?us-ascii?Q?pOtFDnfpljZOTBU1B0Sxo31Yzih9er2GmA2Z7+sbFNnPoJwZMMiiv6VSqfIe?=
 =?us-ascii?Q?udKh4LrbsjjpbOGNx5ym04JQp5qAc66jJHhRa1OIgakCoBbIWbyo/A295mAI?=
 =?us-ascii?Q?RjrY3RgyGOwBEnw5eOzgGH7KIZFKQFjoXJ8nP4bT5QjNktO/af5CpJBMU78E?=
 =?us-ascii?Q?DdiUTmZYza9Ker6rwZFePuC3NMmq/Ipd1jASFP8zjgs0NQSnKznnK+eNcxhE?=
 =?us-ascii?Q?mhfrMgdLiQMm275g2RCDk6ohanTdhj69XDRIy9OLaQmOpq1nF8arxyZwMeKa?=
 =?us-ascii?Q?pvjbt1TTqn/H98fWGgmScIvT+LwDHolrbox+q8j6LdjT3UIe1E6qvkmDqSdP?=
 =?us-ascii?Q?aiA52IsOYWMvDtPAcgKAf38Rt+Jen6oeVM+OoKinQBEw5+xtZIj1WZExQWoR?=
 =?us-ascii?Q?5So5858ZvOOfLbeuzDIBcfHbb1IxPYduEJp0g3v9nAmK1NxTKRqTbK4oykKE?=
 =?us-ascii?Q?rpWhmii237WiymWlAVibiJCE8b3EPUsOl+HVsvhxXVEp/eLHFH9kRAshsrlR?=
 =?us-ascii?Q?Yv/G6anOlRooIxxiaxaFAB6re+rfwOOr6K8psPsH1jn6oIycWE6vB9eFSisk?=
 =?us-ascii?Q?HyQYReg4QLGW3986gJmgxvTghMi6LGT0iV3BfAgh66XUKZwqrARCn2vcRIGX?=
 =?us-ascii?Q?pcA5xTnTa1fGel0TshaJ9DTruOsrNlMg1gwRFYXTWlmJTPFz/XMMBKGkU16I?=
 =?us-ascii?Q?sLc5C2AUGrtPO4RCPt+04AevmVKx+Sp0UZWr1GCAQJseTI+XJSHB8x+RfUGu?=
 =?us-ascii?Q?Ysf3Zhe3NTsDZZYf3BA+uzzoo/o/EZLgA+UkEukNpvK/FwDv9irfv2ngwiMF?=
 =?us-ascii?Q?xPPFVv6l7Jhm6aQ+NhrmwkCpS9SLTig9H7j5X4JzsqalJJwFmYRq9RG0KwWF?=
 =?us-ascii?Q?W8BXK/FyDnql6DgP/0HgAfYrsSchczIslcgagw8tIfrky4Su32E2KjhdjrnD?=
 =?us-ascii?Q?bJs5Ou60xNxdUTtH+nI5oaDlXMZbAWXeZW4IaCVgboHGXg8JSycb6WgCnYbs?=
 =?us-ascii?Q?G2pZKYlKdvuIN9Qxf7uawmeR/A0ay2LRzeeqPAb8ymOyw6RqKg/d2ukJzaEM?=
 =?us-ascii?Q?994VJrCJLdY77JnHdl/Cg7xW+PztgyVQaWWWxCqu8DZjZO2pocwJ2doop8xD?=
 =?us-ascii?Q?+BqEiGykTL0pGliGu9iAo+61KjUxKXNUSQOKJZuiChX/fvNdHEd+/e5qJ+H3?=
 =?us-ascii?Q?s9VZ1uUb7DgkqbKHpC0iJxXYFu97Q/MK+i+pel3YnsrU97nimmVABFNzasOa?=
 =?us-ascii?Q?+CBVVTY/DTmV9R1vh6JAPg+v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3uisKQgjNeybK7ds6dmgipOZznrAQoUoejotMjp4pz2yyyTbPcfcv3OB4E4?=
 =?us-ascii?Q?FDoBD4+wv2JevNAZLXAGuCm7a3JK1XtE6P3RJbv/sdi75KHlPd/dlwxOZXT7?=
 =?us-ascii?Q?iGd0qWWjpyIvGztptdNOTp+LgTFYtA7DNuhpK3px8nwHtQmfMY7a274A9HPG?=
 =?us-ascii?Q?Ejj48X3z8YNVUhEgJEc4XjaBA1iFTjqkRwLqLZ1IH32QjNEkjAWNPvlx+r2U?=
 =?us-ascii?Q?IDmzjCa0XSqF5m1H9ajtVV/1kMzsoBMOsZy+IdZOwmNyX2w1JcztdP2LDZlN?=
 =?us-ascii?Q?26hqvjYy6r/VgMR6A4HRZkY29RT5tgaYnOzuqgIodfT79Bu/y3rY2cBBpfAj?=
 =?us-ascii?Q?DdwT7/aO3PPywFMqxqJbc9hn3dRbJVPi2/JlGhyw1yUwLJdsXDctlUtXYnnz?=
 =?us-ascii?Q?3DjtBywLj3J61ou+hWfQ/WWTWRGY+xb2kffCsBCexgtoxddcneJ3NR3h/nO7?=
 =?us-ascii?Q?DEZf6ROMtZJM6GNygXUlfxdv9H5DScPVXN7NqDK5IDpkh4GGNPTZcz9T7acr?=
 =?us-ascii?Q?rXJ8qSINkdB5EcLsflY8F331iznOX0k5AUMm0lPd/jfy1w2IuqyDL26gBzXw?=
 =?us-ascii?Q?fQkVLOtywPe4p6I8eHBnMB3Unx5bkiiGMX8sK2TjCYiYlKfiqgu1fziA88D5?=
 =?us-ascii?Q?UHXOWsf2a7/B6X2vQCavjdVpqeCq5Bzlagu8/av/NC4+jSbzdyMnlwUIapks?=
 =?us-ascii?Q?S/sF6ArgpmjyyqzTzue+GEbHK973oIH5D/+B/vis7GkBtMPwCFq7YmLR/jxZ?=
 =?us-ascii?Q?P6q2xtLlA6VgV/gXe0bw6QKIkRWYFdAa5ItcGXiGzRG0U8MH1lajOZD+UKup?=
 =?us-ascii?Q?ua19HKLflBjlwK2CnAojDabnbI5OEYv4lXcSy2ADv3MFLJIrHSAG09tRUxcy?=
 =?us-ascii?Q?MG2lBiZmxLqqf+wwXv236NuxcCzIK70a+Ymff/sGPUJ3yMgJ/N++Uu1liepo?=
 =?us-ascii?Q?iy0l8Eht4hkLVijrgqPRrmEfQAZ289ZEa/UtHTLRBTVAykpCfBzNTJUGRwEA?=
 =?us-ascii?Q?WBOd78qk8+n8pU4xhf9XoeI3TaScwLXNfkn0ZJGk94AWnebTCNMMIMmLmd0P?=
 =?us-ascii?Q?A6gqDPKI3Un5q/oF43pWA4KxK/nQqoTMI/4CsO3TXP24XTnsKRFm3JEQtVly?=
 =?us-ascii?Q?dDoP0/6Ym+ss68Vhjtuzcf449IXi8I5ZNJwrp9JkUub/Piq7Si7trcVAee8p?=
 =?us-ascii?Q?y2f2kFvoJulf/tLczMIA2hufSnOyk2HjGZjuY5fVXp467XASs+z3jVX5IBJn?=
 =?us-ascii?Q?CJcR0I93LbhbbA5Ur6cc96w+5Sj5DjusxOTHoKVc0dOpzB78hC/x2gI9YLdh?=
 =?us-ascii?Q?E0rnlfxa8+4uDm/1cvZgSekP5JzVS2e1umlbxsQIO7hmED3wnLZAftpbUWvu?=
 =?us-ascii?Q?O34mGiTbZJYkmgoW9bmEW9SLY6q/gjLuhD2UBBkiA4f8uC/MsrHacZEPGG9s?=
 =?us-ascii?Q?4FYcg5ZbRflaQOllBU+edDWDhmjX7VaUlb01WGzUSCru+qNgLkwpw0KCujJL?=
 =?us-ascii?Q?2ArRXgURRxVIor3Bku/2FjIlPNCdouQ+22pCYTzSYAkBiZ2sFO5Sqi96wR16?=
 =?us-ascii?Q?zv9UJJyH7nfIJde6O/S/xUlrDOaRukI4CrkF/KxzEuToY6J7On0GpK5+qE16?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W4UkWlZ0k57EQha/BFUsp8l8s9ResBKQi5KTXK52w5B1XaPxvJhIHHBVvRSmzpYzQSRUQSm6htMKXgz53cPwQXZuqhu+6TDqPfzpnKKkzJOveIIMAf/wivEcDh2Mo3EzpGsbIlPlrMLnae0vmx9MOwCi71DVyokG3fGP6hbMHjjkF4KaG+adwmtpdG99wZFR4pGJV3tie55GUrDUCjWuXpXY9Uh2T3m4iRxtFblpnVrOdkYLIoqh1+B3+HG8tQnrqCNeOJanO2oQKnrwXn+nmWjXzpDMoUQKqz46wDElEQicja+eeozCcux5CQqvf5pI+4bacTjPWvv23NRSRum40LBj64RP4H7Wdt+Is22Dr1gXSPSPCxbPVrquKd3JA2d+LpvjVCmAhYktTJ5gBaJS5hdmk1jNTot1l46ldBWYEeeESpX2XVVc0zMlqNnAaIIU0Ip6sno+v+T88QxMve/s8g4JARzmllhjMHcy3WeqOQk0p44kzcFm4RuWQhSbF0Y6qnspy859o4Du+lz+xK1N1O8HRed+SH5TBH9l/DMRTwRKgSbYbexiVySiwHjLfPJ0yB6zFvDXxjJ7bCdHValx7lQVpR7oWq4kHVO9svNATM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fa5182-2064-4ac1-c58d-08dd0572727a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:38:46.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBxiwkzia9itGhMMAXhDwnUT4S8YP+kgwA/m4+xq8tLjaF8zba6dtJwefKqPpgQKGe7o8SLpGdrmWSuhB7wTT8ojaV5NCqQebzPAnS9hOMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: w87bDAH_fk5vjFbiXSmyj2LX9qoRCoGr
X-Proofpoint-GUID: w87bDAH_fk5vjFbiXSmyj2LX9qoRCoGr

[ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 73 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a766b1c1af32..f8a2f15fc5a2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1716,7 +1716,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -1780,16 +1780,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
 		/* Can addr have changed??
 		 *
@@ -1800,6 +1794,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		addr = vma->vm_start;
 
 		/* If vm_flags changed after mmap_file(), we should try merge vma again
@@ -1818,7 +1820,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}
 
@@ -1831,20 +1833,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 out:
 	perf_event_mmap(vma);
@@ -1875,16 +1870,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -2907,6 +2898,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
-- 
2.47.0


