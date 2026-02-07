Return-Path: <stable+bounces-214747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD3QGwiVhmkUPAQAu9opvQ
	(envelope-from <stable+bounces-214747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 02:27:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A5104809
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 02:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872E630166C0
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 01:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43902797AC;
	Sat,  7 Feb 2026 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKKo/7Cv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VISedBf3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807E2517AC
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427652; cv=fail; b=n40p3e/3pPqSzJtUA457mXY38cKqw7EdIj1InT6GtF26bo8WQZ6uG26vm+M5HTb+FtWbidbqItI8bnC1fRRVYNRIjD/xsFmq2V+nteUJ65UQ9v7q4mR14WT0PKJ/3dOBXDeg1c4RS81S5VeqAa5EyNtZdWLKqguVAAaTU0Z4yIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427652; c=relaxed/simple;
	bh=KdKeYWZLInPgChMGWjrcUmur5XvS1z2mCmfNSzzcXx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Go+wb2BphzFhoBmp0I9xlCAn0YfEzHwRuuKcuRddoacET3Hjn4xddJz6l1e0B+bwyR0zTMjN/C7/Hft4ZfQpltErZjGO9iCeaCdioFs0mB41T2FxcCbNFyj8+4GHrJ8q/YcKjg/ESS0WWiIf/iBQo3wcQK0+61sCG39vOpGZQXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKKo/7Cv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VISedBf3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616JuGku3928701;
	Sat, 7 Feb 2026 01:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X8hkT7ZAgjhv8XwOMb
	Z94QqHDoePn12oLjx7/JcEyxY=; b=lKKo/7CvjDR419gQ/67VQlcuFVpEPVHf5d
	0R6mkeUK1vlkYOKn240vwXNDqphfhwT9nYWZNq/TC06qnlNzYVEfjNL2iuwery1r
	pudtzu+yOis9YV5V3OzPBQojJ55TDNUoU+/dup+mEOQlWZWd0j6KPZzzNxplVmXA
	u4W5iLOu4kP1EB0/eD4RGjjaRBrAUEmBOXRN4WKiyfWKx4oF0P8k5PAKl7Y3+Lhu
	JMn1HbHkeqeRsM5bpt84zB+lnpI9GcyhkZfqHZEyJvm4zx/CIZXUeIiqmA10XFED
	8kzAL5DTlG7+XXt04rqlVcRaUh73bWaQ8ywcAk1qjGS36t9Ym4+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4dc3urc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Feb 2026 01:27:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616NoNTe034785;
	Sat, 7 Feb 2026 01:27:08 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186f9ynq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Feb 2026 01:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaCL2XOHfYCFmcvtgVFqT+LOevHc7FPwMxHJjAhz3N2nTiLQkUKp0sRqHixOJQY8ahlAT+msi+nR508g/iomyPIKObD8GuqP5lbGr7oTM1+LKE6jw7kUmr5OY8oCea/ZpfK0CsGr6ih6bPy/YVgBdG3UVr+/tyQRRV7xsvJIMTltIhGQZuQiE1lDcEGdV9Vu4CDV7LOHZuobyeqNp4hJ58OY1l0TN/wKfWxRK1Zkr+o55s0fgTjk3NNseSDkzFQZeHohqTBnMBZvwHFvseIJOwFyFMnXZMClBN0VANaOBFtwe1C3TmHytyEMDPaSu9IsP8bCfoV9ZnN6wW2CTR8xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8hkT7ZAgjhv8XwOMbZ94QqHDoePn12oLjx7/JcEyxY=;
 b=yZdPRprIdWpuZNs4YMQBBiNQk8ezLaxdQvB85e0rpeRFwJZAFs+lh0ZcgdJPHrlXW2Yv2jQa3qk/Pwb5ql7AB4J+DHyYoV+UYdD0DvGpPJTE+gjhiralyPVhp4ETxJQw3LpQTMxiBkentaGyqPvRtI3Udyrs2CMKl7rwk0eoDchUZjr5hBmDcEz99NvkthRsgx6Pyqcgh1qb51WvudrLH8wlSkUazMWwRikhcc0tQPJ6umbmkekVFVs3d4gDTiDHJ8Bl6lcUQ1h9IF4HDPfkg4eQF7VY9U0yFDdU5J3TFt9lXFC+n2sPxSxepy6y9sIVGUSJY3PttDeWldjf2sEp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8hkT7ZAgjhv8XwOMbZ94QqHDoePn12oLjx7/JcEyxY=;
 b=VISedBf3krODyOpOKM8DUoZrEdzeUvDPiwrczHAjuyN72qPv54nzCj2FweDYdHTdyw3NkLlP5ZftFVv2Vsfy8O+BYQjdD1vs9vE0CRaeWZeODeOAx9p9PH93qqvVTNSrGuIHhMyazvtD9jP70VG9uLJTOtm3c2wLBojPkUQ16zg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sat, 7 Feb
 2026 01:27:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 01:27:05 +0000
Date: Sat, 7 Feb 2026 10:26:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: skip debug_check_no_{obj,locks}_freed
 with FPI_TRYLOCK
Message-ID: <aYaU4mE1JcrtRact@hyeyoo>
References: <20260206165802.17280-1-harry.yoo@oracle.com>
 <7B9B9CF3-29A6-4271-8C3C-87FF3EB9FA4D@nvidia.com>
 <aYYi3DhceyKbta2Y@hyeyoo>
 <651bd1f9-8971-48da-a0c4-328e235c2eab@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651bd1f9-8971-48da-a0c4-328e235c2eab@suse.cz>
X-ClientProxiedBy: SE2P216CA0126.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 26384c0e-f988-45ed-25a8-08de65e800d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BmY2RLVHYl6GeGbFxWMK7U3HC9mPWzgn/W1QhTkiHyIOj6wbYWFdiuUlrzaC?=
 =?us-ascii?Q?KrAR60N8p6cSwOuU4udWfVdbvw1FiXfT68sXiJpYB951qSPghBaKuHFWvOUy?=
 =?us-ascii?Q?Iyor2GvzsVVeXDrxwphdngCuWehsrS5sim9pmc1JhGLs8CoUzNnvQRs24yT7?=
 =?us-ascii?Q?WDg7jIasmijHc8eujkziu1QMfFrEo3C3rIJg7LuZGwgYAS85V2mh5RJykNwH?=
 =?us-ascii?Q?59UbGaZ1Lr3jTVPj/Xx7mSCkZd3KDo1h+JN7ZxeG/YTXsWMfgw4cAAiv3dFj?=
 =?us-ascii?Q?YfuSSEy8uWKOmyi/sxr1ScbiBJccgZ7pyK+QFjnimuPFCMEg5vdcpjhjeX4z?=
 =?us-ascii?Q?Cjz+Q1aAgTxgUd0D41Wg1aV+ZPa94Byf2k0rINk6zlzoOR9b5v6R+JsPzn+o?=
 =?us-ascii?Q?qTjs5Jfnn4n3e5zkDGms0Q6k9S9BkEMBGAsV9YZ94fdmbRGHTZKL8tTfsIX8?=
 =?us-ascii?Q?uK7bPBfPUkZ5NCmih/HFQUId/GgzBSQL4MouNeRTxrkHpvodyqcMtX4nHDM7?=
 =?us-ascii?Q?ipEcTNbm9CPCMIZrSJfjdSdpxqjHKy4nRwsIlxFoguHi3i1IOxIJSd325IBL?=
 =?us-ascii?Q?82Pp4Vi/s9P4UVtVdkx2fyB8z115lEStau9eN+J7SGy6kOGjfPNlbpz1lruo?=
 =?us-ascii?Q?cvJWxSI76AueZyNUyrp4715wqe1LYNVviBDznHTijDNU9wjtbBvm+PnvQPUw?=
 =?us-ascii?Q?L3P1/YtZ7IiS2kNFOrgc5jwbq66CL17fboN9YXs99M0wzPE4h26ypT6twaRy?=
 =?us-ascii?Q?hiZbOO1jZgwjxwvbEVrDTFiO1CtA1MMIddGqe0j3ut1B1nfXFbM5aH6j/I8d?=
 =?us-ascii?Q?oqkoQxTObOcgqmsX0WPLRKnXMbh4SlasUzAUpM/xrJEStaDAfn7PC1Py8k3K?=
 =?us-ascii?Q?0f1lg23YiMaytXNxFxnq/gny2flL2CzkAVovjmsTMN1XsSvgO+zSZ3MpxZ3S?=
 =?us-ascii?Q?Jk5mGT0uVnR1NWsbIfEbtI6zsJ0dw0aj3Ibjc3GSNlSCONgmfBcb0z41EE3x?=
 =?us-ascii?Q?FAiymBWIqrkVXr1IETQhabk5Ic8Cxs0BxT8FUcWYEhOmybvF374q+Pt8+RVc?=
 =?us-ascii?Q?NOqC9ceWeMrkJH/Jqqtfi7Gg7i4SskP2pFR1V6hCA0R7XGuj0v/BSItc9fFt?=
 =?us-ascii?Q?BPeIoTT8vy0Fzg5stmDq3Ckep/hE7aXYJDfr1Cea8qlmKfu4Iy/qtIo55nWq?=
 =?us-ascii?Q?MyJuDyBGBXVS2tH4SFqqvnQ4g0z6RrHbOzrbVErluMKQBoB+ZhmS5D8AE9s7?=
 =?us-ascii?Q?Y3UOImuyqab1Yr8vGrVMCvM05RaYDdN0Qf365swNeHbT0MgfgXZfOmONByP4?=
 =?us-ascii?Q?Ecxrch/8hlJcW83kET2rDHhj4OyEyWHuD8pffM+9ksc1ZlZ4+72aqxqZ8Mp2?=
 =?us-ascii?Q?eRFEFURSCU4VSx+7xevkwH6Wr6D07pBrVeSdggu3BaUcgKY0k/tVW6rRlOsn?=
 =?us-ascii?Q?+B8ana0KbzGg2sJ3PrKAVJG6PuDVPZ5gqercJE6DHyx45pyQuR7BSHGZ67ic?=
 =?us-ascii?Q?ATTVuVmt2gpkZHAnvYKZHAzwkpmhxv3Bi4EvRJ/6FIv8WEGXK6SQwNdkvGsA?=
 =?us-ascii?Q?I4qIpb4noklu8ZIFjeU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?28RGMEp1sr216wgj2Y/Gdo6zNQdZ7DauVp83x9HTReoKT29nV0jTlmQKQm6U?=
 =?us-ascii?Q?aAlFdzZhADSgkOBTvHVokfgdJeSNC/WUcr/79gf4B2bkoYH8s7kfp70vUoYb?=
 =?us-ascii?Q?Fx89EMfdDFW8wh4w9tKhs2h8j8wYqlcsVnqbbGgb4vqyL3ryCQfSZ9AP+FUL?=
 =?us-ascii?Q?1iRfskIVIeJpktwIS/VLiX9AS0qTcUw5WAmejGFE2wOgh3R3hiw7g1CMnA9r?=
 =?us-ascii?Q?0ksiORPychAwQTTkbm52HZ7gKHeMqirzV0S0itl3TOmTXq/h0eNiEi8DImN7?=
 =?us-ascii?Q?n8Ep13k7TIgyg6fReO2Yuqufek+ieR0m+KYn+bLp09A3dpIWejL7/FOq0KXG?=
 =?us-ascii?Q?M2IUYQrPLKO6o2E8mKl2NR6P1+AhBC+sBlFd1fwg9ZvqiE2Di1eTtYGw7urX?=
 =?us-ascii?Q?3EuFy1GB1vo+/Kve3BovdrwAACvW2pjl5scw8RBYth5NKq1iC0lK9FtLrpmt?=
 =?us-ascii?Q?LbcT4OV8c+BSi2QaN9/VOgPwHB8dRDmzPSb2wQ3hdZrc+gXX45bTzXsyNeoM?=
 =?us-ascii?Q?WVRc+PNAmOK1VK28Q29J1hDYb9MVuJy2Ps/AxY7/6XJvHinVlumcSijqi0mK?=
 =?us-ascii?Q?+M1eQ/9ZMXYLzcFrqfBCN/1P0eFvbFAworQwjEGCIvGcj4nPxZTkZCsXYqRW?=
 =?us-ascii?Q?GG5WuCaMZBw07i9GQaaJInOX2VpmRqk+7hcB72Nvzsv4SZnDsqdhtwNldAs0?=
 =?us-ascii?Q?9N5rO/+swarGYtgpYooaPdUXhxFpGDx5KDL5FSiF9lx4o2fsKb0w3InGMY5r?=
 =?us-ascii?Q?GmPrE3qBdxGVmShIl2vN+uqDOxFEAhgcqqs2hTYK9JxFqU0F6X2xe9mPxZzo?=
 =?us-ascii?Q?r7XDEnxd4rkMXOAUiOK/0+fHK5n/c+4TLh0MKgvU59rwtCTOSTIMEfJYaMCD?=
 =?us-ascii?Q?PDPMQCk5+8XDV9FE/YP9Tu80ISFfzd2pVr4ot9Abz96YPsp1RRoROkam9SXk?=
 =?us-ascii?Q?4SGuS1LqDwrj9xEf13U/rLW4DFTl4tVFVkCJ9jIeosD5gW3kUaK4+uNBWxKJ?=
 =?us-ascii?Q?1miSva93M0Ca0/sFPuonwXMUogdnJC0IBUcGe2fO8QPlQ2T8ZNJrPKQTsK1n?=
 =?us-ascii?Q?IUg/vKNz2S65DzwGoCjQgMDQhGJCBr9gfMG7FCW7q9HSgbMDPmH5vLltn4E/?=
 =?us-ascii?Q?iJ8pVjm6jS9eAe3Qo+LsarXvrdfqDLq2xmUNHV/kAiqHtP3PV117OVppGTQq?=
 =?us-ascii?Q?hW3G1rGimTtQm+LKaPNiPoP/xXs9jLfLqO6CtGg5bHc9xQ5XTw+LfzCyuWPr?=
 =?us-ascii?Q?7wM2Bjy8R1dN2TAp0IGAhOVemCRQe9XwjU+CjrRy1YYbBSbOIWtjYTXKtxLv?=
 =?us-ascii?Q?8nCZTGW5OM+g7m8v63eJDxCh/vLAkmKKmx5/jg9u0O8fSTOQ/tprhorVOnP0?=
 =?us-ascii?Q?ZAtRipjk7LR+HtXv6XV1ZzJo5t0Y8PxruLfoJqoSyVNHXOE1+GUW3694M71s?=
 =?us-ascii?Q?Gd5e4CJlHGiHetUVDQ20SXpi7yym3WzrBSRdM8ELn4RFjaxPIsrbqrVgxWsI?=
 =?us-ascii?Q?0QXtTKNI1ujZhQHXLWLZLbj9dtGITMX7KC6R9jzfRmS7+eJVbW3jb9S6o+rW?=
 =?us-ascii?Q?d0PXXPSfWsaZpqamy6LxMxzi8RH5lEm6UN8FfTePw6cq4ulqb9hjyKlFs5/C?=
 =?us-ascii?Q?a7of0v2apEoHruEkKIGeaXR7loxDDVveYGJ4FN91MJSIulxc8d9axgiamqL5?=
 =?us-ascii?Q?CNroPKO6i+d6iQUoN3TzuJeZRF2uv6dk14/Wp6blaE89n8Ku0hh4uFpnkc2F?=
 =?us-ascii?Q?BtsoxWn14A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5tqreNZ29PUGOZ0/yg8jSvQNU8WzqBYV8m4ZG1o0vxuEYs5O3zcsd6B2uFdKLFxOo/8kb+SDlrglj91tgsnkPhE/hSsVKwsF7T6sRLHEuwqXGZywvLmFJ6llH6loc3OexFdE1cbxcVCd8GNXpf7zpS1s8BXDphse/Fm+7S9hRJdnbyW3QO+oSBfxO2/pJXv2oJLqOdRUtcFvRTHTylVWIbiU7gbpex1oY5HRHAlsogwn2kV0mxc8sUsHZ2ladtvzxc3buC+AcGdTfR3uTUhA5CGlml+n90Gp2skhypqjQiebR9Ah3x1/0Ut8GBdxMQOSF6l1rWYGjIullLsJ1xVyGwaR/2PpRSAEOH4hAJ+iXt/C6A78CZk7QByG2aDH/a4uqn6FgQUrsG2Ip+vfKWLdhjIz1g42rMxinbIN/AzzxUuZBZFsjBHDfjjLKE9g+bZwVFRPtR4EgXbBpxC8QGgMFgsh31PHkNgXTvDnfB+aYdLcblm0+MnU1TeqgV4rCDxgXxRXIbIMirMaYC5XgdI4lj2knI5EhRfym54swR+zTPTVKIeCp8XuEuuUvufmNW0s6b30qa7W09+jLNFIFUhpkf8wOzwrxY+tXyojuanO5Wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26384c0e-f988-45ed-25a8-08de65e800d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 01:27:05.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8G5FiHnsRxk51PXUruwLwtT48L70+cS7emUP2i0+0K9KQrZg0HQMyDZ2hiBO2KL51bdtz4yp3FFklZJX+vZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602070008
X-Authority-Analysis: v=2.4 cv=SMtPlevH c=1 sm=1 tr=0 ts=698694ed b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=0Ok5Ct6fZYEtJvbDS0EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: P5mF_z7faLRMxqHsfPJ4mh9qNk40ez2y
X-Proofpoint-GUID: P5mF_z7faLRMxqHsfPJ4mh9qNk40ez2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDAwOSBTYWx0ZWRfX8oYKRT7cLdbi
 jS+lhn7fOMiZMUpkK4aQ0r/r0N2HSRZcg3Peb1Q+9J0qPg+dm/mDZtoV41QCEoAR7gi0EP04PS4
 fxdP/PIbrobXwvXLqEMHa3OBXQf5gxYuocLAa2NlKDmd6TpYdnohBo51EoWpc+R98OE0cFftY4N
 LTeFwaHs6zIdlszlC18RiObf2CErPlGtwqfc5ti8Iva6i9romFy0dvGzD980aBXUFGweZYFRrw8
 qA+UE90TKMI++D8tHBM6NWFkssX8Zt7ciSEl57mF0w+UHO+u3vAXw3F7GItLwm/i0up4xm6fDqd
 6HMID3sVThBcV0gQdGBHLV1h7C6XAidSiG0VIqf9+0e2I9yRjf+vs1IqJeXicR6hXn1NXrTrwkk
 ynw6YvZRql8aLzDmxMGGPsGV5+WChf66Q4vRY1zE4RX1JGijzxh6mVN7om271xVJFTkQKAsehTs
 W7g/ZhtVhc0q1o8TNUQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214747-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C64A5104809
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:34:25PM +0100, Vlastimil Babka wrote:
> On 2/6/26 18:20, Harry Yoo wrote:
> > On Fri, Feb 06, 2026 at 12:08:04PM -0500, Zi Yan wrote:
> >> On 6 Feb 2026, at 11:58, Harry Yoo wrote:
> >> 
> >> > When CONFIG_DEBUG_OBJECTS_FREE is enabled,
> >> > debug_check_no_{obj,locks}_freed() functions are called.
> >> >
> >> > Since both of them spin on a lock, they are not safe to be called
> >> > if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:
> >> >
> >> >   ================================
> >> >   WARNING: inconsistent lock state
> >> >   6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
> >> >   --------------------------------
> >> >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >> >   kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
> >> >   ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
> >> >   {INITIAL USE} state was registered at:
> >> >     lock_acquire+0xd9/0x2f0
> >> >     _raw_spin_lock_irqsave+0x4c/0x80
> >> >     __debug_object_init+0x9d/0x1f0
> >> >     debug_object_init+0x34/0x50
> >> >     __init_work+0x28/0x40
> >> >     init_cgroup_housekeeping+0x151/0x210
> >> >     init_cgroup_root+0x3d/0x140
> >> >     cgroup_init_early+0x30/0x240
> >> >     start_kernel+0x3e/0xcd0
> >> >     x86_64_start_reservations+0x18/0x30
> >> >     x86_64_start_kernel+0xf3/0x140
> >> >     common_startup_64+0x13e/0x148
> >> >   irq event stamp: 2998
> >> >   hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
> >> >   hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
> >> >   softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
> >> >   softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
> >> >
> >> >   other info that might help us debug this:
> >> >    Possible unsafe locking scenario:
> >> >
> >> >          CPU0
> >> >          ----
> >> >     lock(&obj_hash[i].lock);
> >> >     <Interrupt>
> >> >       lock(&obj_hash[i].lock);
> >> >
> >> >    *** DEADLOCK ***
> >> >
> >> > Fix this by adding an fpi_t parameter to free_pages_prepare() and
> >> > skipping those checks if FPI_TRYLOCK is set. Since mm/compaction.c
> >> > calls free_pages_prepare(), move the fpi_t definition to mm/internal.h.
> >> >
> >> > Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> >> > Cc: <stable@vger.kernel.org>
> >> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> > ---
> >> >  mm/compaction.c |  2 +-
> >> >  mm/internal.h   | 35 ++++++++++++++++++++++++++++++++++-
> >> >  mm/page_alloc.c | 42 ++++++------------------------------------
> >> >  3 files changed, 41 insertions(+), 38 deletions(-)
> >> >
> >> > diff --git a/mm/compaction.c b/mm/compaction.c
> >> > index 1e8f8eca318c..9ffeb7c6d2b0 100644
> >> > --- a/mm/compaction.c
> >> > +++ b/mm/compaction.c
> >> > @@ -1859,7 +1859,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
> >> >  	struct page *page = &dst->page;
> >> >
> >> >  	if (folio_put_testzero(dst)) {
> >> > -		free_pages_prepare(page, order);
> >> > +		free_pages_prepare(page, order, FPI_NONE);
> >> 
> >> Is it OK to add something like free_pages_prepare_fpi_none() for this one
> >> to avoid the FPI flag move?
> > 
> > Yeah, moving FPI flag definition isn't great :)
> > 
> > I'm totally fine with your suggestion,
> > as long as page allocator/compaction folks are fine with it!
> 
> Maybe even like this?
> free_pages_prepare() which calls __free_pages_prepare(FPI_NONE)

Sounds good and will respin v2 soon, thanks!

-- 
Cheers,
Harry / Hyeonggon

