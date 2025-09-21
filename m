Return-Path: <stable+bounces-180850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D9B8E97A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B984C3BD52E
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062D23F429;
	Sun, 21 Sep 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPw3Njd7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kRb2cLuT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D43EEA8
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497299; cv=fail; b=HwXtwWtcpbHJZbPYLA5x0y8DFTtHIaSwKzbNqHzNsEs0swt92qOb8AF7PpdtgAn8x5zPUz5+ymtpk6MaIiIMBlQD7TLZcgs5aEAib6ikNEjXDh90uQjQ1pcZcXRozn9opn+nSBezxULHau6pK3s0cBBi33A4e7NH71gqm+aOIA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497299; c=relaxed/simple;
	bh=vZ0bFAPMzpFPlyLAIWBfmIjB7EwuhfUWUxMjqCn33TI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W+pqigT2Ty89ByrXuE4XMc6+aWPh3dZUYJ2wMq3f6WKmlEoBt0J+WRZA4pP/LCqZEs4LFrGGGLY9dkCtogcOLqZ96BLG0gwY5i7Gdito4wvFHu43Duc4eJoPKSYNKusiZbf4e4ZpnSD82xwt84gjhw/Ad6mqJmfDUIzTRM8WHYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YPw3Njd7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kRb2cLuT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LFce66022357;
	Sun, 21 Sep 2025 23:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=r5zKAof3rpATamO0
	1lYOK+RlRy9z0l44+QvmN1v2dQ0=; b=YPw3Njd75s9yQbWyRzt+DPGUvQvzcdYy
	UWLA+odJgutSulwjtKQTTAG4+pBdkPBw+3VZl/k3k7yjT+fBNKAZRQ56FrSGTOrl
	KWyq8PKguGGGy1rUVKp7+UYmaRq9V296mXD+vnpJb32Y5y3DGWAPPBVelpw/ltDq
	l69jZU6VK8702fjhhTAu38D3krABu5WoR2mAyRY+zZ2/7NyYAOcQIS/v8N1FTdIR
	cnB8ra1ZomjIhN59RtlSLOas4HVcLD5p1WfsDTtt4cHMHdYITVnxarjWhLqZSNKe
	300xxYuaOlqcvh9qToI6YNQwPCh/TI2zneU4ElyfhsHcTILTWFsuHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdhcse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 23:27:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58LKlR43028164;
	Sun, 21 Sep 2025 23:27:51 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6eg10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 23:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvYqFYPIrKyZlJCGDqWJA0myommxcp/QRHaKNuJsPiPrQ2pv1aTR5lszUyWZAp+aSAlh4S94SD8fWTkfbBU636P/UBC6eKm6CVSbdF46Fp1tnNy9+zDbi4S0owJ1wkH7so++ARFiy99P9PrpEL0k4xScW9RkX3Tho7Ofgcp5rc4amXOrd0RqerzPbUDb4mXcrh4PDZ2KzjSxGTuPWxYFKbDBPhATFI6XCDkL+M9I23bNWwnlfybIBzTXKuCPmJkO3IXRh8e5zzzwC/jOdPhvnZe4kBp2O35pgwLW+2WpEK7iiwBPDPuiKtf3oOIbi49Melc+OaGfiPtVsD/Wn/sNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5zKAof3rpATamO01lYOK+RlRy9z0l44+QvmN1v2dQ0=;
 b=ap2nQhlZazlYbknXM3FNc7GicIZ15FVC1yEFuU59dwP2Fxs9ZX6KrT0830ZWm/em/sdNeM6LDnCXQ9frdzRBGuNklmRWtbkCtESSkoyaO5f8UUF2OjjZKAjPN1ulT2Nl8mUw1KYRHlkmOsxs1fKKrJjblp3Z2cLjCrx6bUnap/X3sRvB6zrpJ33JqtLZXMXnAVfjnD80OOUpYme/hDCKklJlEVCFRzX+SLS6llcBN7JEA4R1TLd79npBmOtm4UlaWVaF1nXo9kpb0bv/6vykQm15Hv9E5b/eHIRsu89tnfOBVW9AVp+6U/p18Gj+/N9RfbYRloocBkfGyfHLPQMyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5zKAof3rpATamO01lYOK+RlRy9z0l44+QvmN1v2dQ0=;
 b=kRb2cLuTluI1WTvhqoSjOYHHLTw4u9EtNKOqfjxOcho7UoHtMtEok8+KVTIINIB8/XRMPPkc/3ieZ14iFdHHr14tUypUyFvMBmF2n9w+/SMBU/BKBSrRIwJjEYLZQhNRdAbjNPSUX/CRrxMpki9zPEkKDNKLUodHXjnpqfpO5NE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4716.namprd10.prod.outlook.com (2603:10b6:806:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 23:27:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.017; Sun, 21 Sep 2025
 23:27:46 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Jane Chu <jane.chu@oracle.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [DISCUSSION] Fixing bad pmd due to a race condition between change_prot_numa() and THP migration in pre-6.5 kernels.
Date: Mon, 22 Sep 2025 08:27:09 +0900
Message-ID: <20250921232709.1608699-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0142.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc88e7a-d65f-4157-5feb-08ddf966788c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVDm2t5hPVHKl1NKUeuNsrifLTJwpqzgDRHKo1a/s2OaYSfmGVQIVo2/nGxD?=
 =?us-ascii?Q?IrU6F9LmOFpVIGeuTtGp1QJJboS4yZP3ent1rSAd1oRxR7anvqDK+fniKJ0U?=
 =?us-ascii?Q?zJaoXt1D6oPpCSCyeKm/sIlhLaAd1c9gBYw841WXg0VLVuuA9vMfCIBHub65?=
 =?us-ascii?Q?RdS+P6HVsBers59fCEFZM0xLkdSR71p2gu89+hiMF2aiA5UhQLt3w4mMLuOk?=
 =?us-ascii?Q?1aiSseT+kPWigWQsvh4yPcAT0/ujMMsXsCEtgerGNu9C9nbjzQZ8G9Uowlzi?=
 =?us-ascii?Q?7uacQJW/BcTFeO+5/0wqOwugiNn2nXDOczbVeZUAcQcFxTZ6OT1qOwZLFLJr?=
 =?us-ascii?Q?8zTkulDFpXNDFAYuYjqDvaeLfijHHe17HsXMMK6hxUwFi62OmRHeWjb0OAOC?=
 =?us-ascii?Q?7RR9oxx5shBXH30AYjFeFnnHMidVhrSRPI4Zng9yzkarXj2B4FP/eSn9hR3h?=
 =?us-ascii?Q?BqgeB4TMFRqKdnW8CCQh4znr0wXGer4a5gO+AVLTPcTRxrgsUn8sU6Y+U1NQ?=
 =?us-ascii?Q?lEb4NFjEmBZgVBvx43nFxtyemsxXmkgi5enrZZPZ4XGfxPLZ5fUgXB6nUyDO?=
 =?us-ascii?Q?AL4kEw13oDX9T/2hVDNRqboi3qx7xkdwYsaLf0kvsjm5bNiSMaErbofU5qgV?=
 =?us-ascii?Q?nBnZfYQYMKC9xweNBClmIenRbaZ5oENGcmkvjHGnQwDRUrqn9WfycQYtgzHk?=
 =?us-ascii?Q?vwGWuGdRyD4SbIZDYikU2+EvPc93NLV9JwLQ8HLyg5tRp9Hwzk6ifZlAPOxa?=
 =?us-ascii?Q?wWhuYyN3KPe8w3R2zJxRb5T0fxB/hJaJLNAl5CeDQviovxprh4poNsywfI7A?=
 =?us-ascii?Q?pjSVEMnnkLGSLax5DlZOMPKwYTzHbX2bSBkP4mu9jx6TONAESe398v/pkGQq?=
 =?us-ascii?Q?GLtxcGrnHNnf4nDG4l1nrc2oO23zCIxY9X23fBnXeg73mCdcx4Cfk/bfT5Y6?=
 =?us-ascii?Q?pKVmBXWICrvgCZfc/KFD3BCmaAwp7srKQbcm7nw/jluElZ1m7uK4KHbOBftp?=
 =?us-ascii?Q?qxRgNXLOZAGbRqjT7trmWig5qGOS9k8uaU0Sr6B0q1kzKhInIWtGKuwR8MRD?=
 =?us-ascii?Q?npCG3jUBVu76jEiH7lMGj6cxrWgJRqVos44dl4b7mgrJsa5mH41qBUKPja+i?=
 =?us-ascii?Q?FIZy7WbNJDuOTHQYC6PliaA2gZAydz6Pg1N4/G23EKCJLuSp+ixTOZgO1r4n?=
 =?us-ascii?Q?yBPmjNbXlSsrcnK57BCkAHT8mQffcFUb0w9+AcJFbUSCZdIwLip8FKxKeTj3?=
 =?us-ascii?Q?fp64RBcMvIvgOQftMbRUzreTMUvrgw3Pdrf1O/YmlF29ha9TqAyNHMJ6NQxK?=
 =?us-ascii?Q?wrmG5Qvk8cfJ8S6UZgW4ZtXUJ6NmZbLPxS/6n2fm5wFMXWahaYUPPn5jalvn?=
 =?us-ascii?Q?hBDPOp3aBAkqSnsmZF2G6hTCSN+0S8bDaAf38PUk6EQG0ys1cETdh4zu+Kv5?=
 =?us-ascii?Q?XoUJKmv1tCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nKYClT81j9OPiBIxkgEUi5+1rCri5eybBciSVFQZ09XtjTG27vrfu8tt7df?=
 =?us-ascii?Q?hrQ+Wv+ba3aNNpWz7jbItOliYDvDbPAHkvZJ6Kqeqr6Iylo5nR5cIb28a6YM?=
 =?us-ascii?Q?0Aj16ne3YwKe0RaFOQB/EfHw1sFbiyZHGiUDXrpxS5BlRtE6XY6cBtSLXQv6?=
 =?us-ascii?Q?HBscBq/o5lmmQjXJZYWN35/l81Rih186vAJhQ36MUHVQbkG1p/SeLupDGr0w?=
 =?us-ascii?Q?Ix0OUgepneN2+VJxcF8fbJR+spVuVfon+EvfYTavRddRffAtEaQVcw5CIT5W?=
 =?us-ascii?Q?HboFa9NIupq9JWK/lnD3pcKeIBK7V2+tygH3LCuvM8uZi8XKGpDNPmhquwV9?=
 =?us-ascii?Q?ov46R5hDgJ9R00tddAQJZbuaq1KisQ45vvteGWDCdOMShFLPjqcPs2uZCEjO?=
 =?us-ascii?Q?rNGtjAp9L370hewXgaipdAcYIK4zvqX7DF432OzxyeVkJOCWJINQfpYyiH8j?=
 =?us-ascii?Q?oLIhjMEYCaLW1SX3vYgZ2wdpFilvL53FuDWmYTb26L0bQpgaGJdQy5sTC8LX?=
 =?us-ascii?Q?Yfc9Wx++yQwuiYTh8rwEYmG+F2RFugs/FjKHB2XswED4E48XB0tccpT6Ya8f?=
 =?us-ascii?Q?ntzLGkfjfUsOcUKBHK6KHY5y8rYTxwtWtGEG/S6xGG9FyqHhPFe8x9ml0Lt7?=
 =?us-ascii?Q?pvRp2ixTpyD4uvt7eYqgpuHBGfKncZ0679VjFHPE2S0KWcL/oJa2xRsHDUIx?=
 =?us-ascii?Q?BwnZS/6q9SaRLy3gRlSb4lcgA4xrjcVp//AKG7Y2rU/KSaLA1PUivJOZkHFn?=
 =?us-ascii?Q?inK75inEtSd3I66CqMvlXHGbroa+pToVbFgkTlCtLQPkkwgfXctfXycX6iXv?=
 =?us-ascii?Q?+SV0pnJej9HxGBEpfsj7KaMyUwVMouuObnz8aPJk+wEwoxyGSEV0vha6tBGB?=
 =?us-ascii?Q?/toA1ErnlPyteDxA1C/dY0ke6Og2y0hGoZJHR0oxKy6EYI2M3jOy+SPlGEiF?=
 =?us-ascii?Q?xaAp9uZmaJ1yL2CUkCsyFw42qHnlPyO12xHm0E/ynWbSDFy9EmNwVCiI3/d1?=
 =?us-ascii?Q?v69xgDNai7RVL0QB/0WUMXqJ4VE+GlEfd6DeDQBcIjGViYLyWw6RSyVjE1pg?=
 =?us-ascii?Q?SJNWehOvN30wW9M1VnXc5blxweTLM2R0IJPAacKWRNvY5vuhJivLa68eLeTw?=
 =?us-ascii?Q?eR6YJAWxSArWV64XRsK9Z434QRpi2oP6W/tro1Vj2uIjinpnONwmKWWmIvdt?=
 =?us-ascii?Q?jIFJtRvGnf0ygl2ydYlL/uOxAaH7st+kRePj6Mmv28e3atypmHIwolRjZqg+?=
 =?us-ascii?Q?mGtStMEbN6xsdrTUz/m/2WOVUjLhHbdim/FSdj/0u0lm1pIRm1sLkgRctix+?=
 =?us-ascii?Q?QN+nYhJ1q7Tg0BKsmb/h7yyya/mX5e+PJFTdAFVXohdDzEjtMc7zYUjmF22+?=
 =?us-ascii?Q?rrrx6jjejiDVlpRandxlWjvK8STFlnOb1WDdmDF7c5vQ/uXHavMjB1VQfSy6?=
 =?us-ascii?Q?rRdCenRbtXHDzz9ZOGfZRWaW+lyp8W56RVl8bDu9uOHjPrFOEKR1IJ2vj84G?=
 =?us-ascii?Q?emlvgzOGLHRMoVHKBe65+OmHgm/w3b8+n89cCz09yPbRmagYZMKsTXH4fmjp?=
 =?us-ascii?Q?Jp5BcyEUxHkOHROY2598ifAL3Pv71NdDp9gx2RBF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dZ1vyjV7IqiZsgSOdLK0Xj1xCXGl2k+VwWgPW56H6RjUdqxCQrQaATFNP6NdlVbMQpcJdvJxev2iUpoODW0cLurz5fe59w7DP9JiP0IrNsX6LA96MYTSRO3c+qKPuFVi5TFWA+u6rQEhGPwUMAhBnq+1NbxABS8u2LA4GhJpJ/k/s43ILNfvxBSCQUK+lO29TmDH/Id1mtjsNTXv9f6cuG+uYznehlV3a0gZcFIzSXTQSyRINFtleM54WRc8oijjkbqKJ9ygY0leRRHXsBS69XWCNWkbbzacCGqWCQFrVqKM0u695dMhtpS6nOi4eKmGtcuHlU0uMQnm8xmJmSjP8Hjux5l9MJAsP7fQ3kHKvKwKQFENPKKBfBjT4IKyTEJ4HyQ+rDKgvaxtEx+uzbmSw3VM7KJtLiGZkdB74Uy/ChxKJhm+tUiVVnYj9KmO/+CHbqmKgXgiH78fXB/a9tMVyNCrVVyd6zmCcQcCVt3eQrXGVQ/TZnuJ9d0e5FqFHHq/5JFZp2eN19vk31/oxBra0zc4Hg1IOkgOlVQ+425Xc/3wmMsAcV3p/mrY1PZ+k17qJVEm/fuUIVphokzVVmKsuj1qGZAhJs/q8xRj4cdFulE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc88e7a-d65f-4157-5feb-08ddf966788c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 23:27:46.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ2cqo/vFt0yypG3PnuRWEh5bufLWFYYKiCN/qvFuYirdHsz90ioSOg9QyWBjnU/rSyUMjLTHw0YPVjid2VdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_09,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509210240
X-Proofpoint-GUID: dTHzbMhBu_vvbIkJWSAJml8MgxzXuo09
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfXwNo74oEyMhPx
 BPHvOydD7UE2XxzAl/hwnKihGCn66jqr2RU7pRbc7stGymeUYTv/xERXxVdFiC0dDFLCszjTMrB
 YiTBG31gSf+fBybvpscYBWeQ8Ajj61/fJdgTv0sJUWpxw/oBLu0XM4qjDABqmZMKUqmPzs+gT2s
 iLozHPI2WRBEiuZxanxAH+y3wq8uB8CfRp7D9Ez9THb86fN+f8eoO2oEZBLD74eSOKZToP73mqA
 b73UyfqklnXnhdSlfX6+cD6TDLhs6rhe5xpi4vDT9GwiTOXA38ZSS46sT/ZOkU4XonkKi8YN6US
 75jOZniEGQ9zzkU1aCCSoyGvc2Kxlln7NWDYeUFoFqwmED68c69X1IMlAbP+MNLF+z0kpBNlP1M
 4JybvmKR
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d089f8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=R_Myd5XaAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=hA1-jdVMoAstThmsgiUA:9
 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Proofpoint-ORIG-GUID: dTHzbMhBu_vvbIkJWSAJml8MgxzXuo09

Hi. This is supposed to be a patch, but I think it's worth discussing
how it should be backported to -stable, so I've labeled it as [DISCUSSION].

The bug described below was unintentionally fixed in v6.5 and not
backported to -stable. So technically I would need to use "Option 3" [A],
but since the original patch [B] did not intend to fix a bug (and it's also
part of a larger patch series), it looks quite different from the patch below,
and I'm not sure what the backport should look like.

I think there are probably two options:

1. Provide the description of the original patch along with a very long,
   detailed explanation of why the patch deviates from the upstream version, or

2. Post the patch below with a clarification that it was fixed upstream
   by commit 670ddd8cdcbd1.

Any thoughts?

[A] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
[B] https://lkml.kernel.org/r/725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com
    (Upstream commit 670ddd8cdcbd1)

In any case, no matter how we backport this, it needs some review and
feedback would be appreciated. The patch applies to v6.1 and v5.15, and
v5.10 but not v5.4.

From cf45867ab8e48b42160b7253390db7bdecef1455 Mon Sep 17 00:00:00 2001
From: Harry Yoo <harry.yoo@oracle.com>
Date: Thu, 11 Sep 2025 20:05:40 +0900
Subject: [PATCH] mm, numa: fix bad pmd by atomically checking is_swap_pmd() in
 change_prot_numa()

It was observed that a bad pmd is seen when automatic NUMA balancing
is marking page table entries as prot_numa:

[2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)

With some kernel modification, the call stack was dumped:

[2437548.235022] Call Trace:
[2437548.238234]  <TASK>
[2437548.241060]  dump_stack_lvl+0x46/0x61
[2437548.245689]  panic+0x106/0x2e5
[2437548.249497]  pmd_clear_bad+0x3c/0x3c
[2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
[2437548.259537]  change_p4d_range+0x156/0x20e
[2437548.264392]  change_protection_range+0x116/0x1a9
[2437548.269976]  change_prot_numa+0x15/0x37
[2437548.274774]  task_numa_work+0x1b8/0x302
[2437548.279512]  task_work_run+0x62/0x95
[2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
[2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
[2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
[2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
[2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

This is due to a race condition between change_prot_numa() and
THP migration because the kernel doesn't check is_swap_pmd() and
pmd_trans_huge() atomically:

change_prot_numa()                      THP migration
======================================================================
- change_pmd_range()
-> is_swap_pmd() returns false,
   meaning it's not a PMD migration
   entry.

				    - do_huge_pmd_numa_page()
				    -> migrate_misplaced_page() sets
				       migration entries for the THP.

- change_pmd_range()
-> pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_none() and pmd_trans_huge() returns false

- pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_bad() returns true for the migration entry!

For the race condition described above to occur:

1) AutoNUMA must be unmapping a range of pages, with at least part of the
range already unmapped by AutoNUMA.

2) While AutoNUMA is in the process of unmapping, a NUMA hinting fault
occurs within that range, specifically when we are about to unmap
the PMD entry, between the is_swap_pmd() and pmd_trans_huge() checks.

So this is a really rare race condition and it's observed that it takes
usually a few days of autonuma-intensive testing to trigger.

A bit of history on a similar race condition in the past:

In fact, a similar race condition caused by not checking pmd_trans_huge()
atomically was reported [1] in 2017. However, instead of the patch [1],
another patch series [3] fixed the problem [2] by not clearing the pmd
entry but invaliding it instead (so that pmd_trans_huge() would still
return true).

Despite patch series [3], the bad pmd error continued to be reported
in mainline. As a result, [1] was resurrected [4] and it landed mainline
in 2020 in a hope that it would resolve the issue. However, now it turns
out that [3] was not sufficient.

Fix this race condition by checking is_swap_pmd() and pmd_trans_huge()
atomically. With that, the kernel should see either
pmd_trans_huge() == true, or is_swap_pmd() == true when another task is
migrating the page concurrently.

This bug was introduced when THP migration support was added. More
specifically, by commit 84c3fc4e9c56 ("mm: thp: check pmd migration entry
in common path")).

It is unintentionally fixed since v6.5 by commit 670ddd8cdcbd1
("mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()") while
removing pmd_none_or_clear_bad_unless_trans_huge() function. But it's not
backported to -stable because it was fixed unintentionally.

Link: https://lore.kernel.org/linux-mm/20170410094825.2yfo5zehn7pchg6a@techsingularity.net [1]
Link: https://lore.kernel.org/linux-mm/8A6309F4-DB76-48FA-BE7F-BF9536A4C4E5@cs.rutgers.edu [2]
Link: https://lore.kernel.org/linux-mm/20170302151034.27829-1-kirill.shutemov@linux.intel.com [3]
Link: https://lore.kernel.org/linux-mm/20200216191800.22423-1-aquini@redhat.com [4]
Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/mprotect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2a..c0e796c0f9b0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -303,7 +303,7 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 
 	if (pmd_none(pmdval))
 		return 1;
-	if (pmd_trans_huge(pmdval))
+	if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval))
 		return 0;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
@@ -373,7 +373,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 		 * Hence, it's necessary to atomically read the PMD value
 		 * for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		if (!pmd_devmap(*pmd) &&
 		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
 			goto next;
 
-- 
2.43.0


