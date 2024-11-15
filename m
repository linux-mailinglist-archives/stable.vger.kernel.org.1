Return-Path: <stable+bounces-93531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36D9CDE70
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1267B1F229A7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483EF1BD012;
	Fri, 15 Nov 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXXWT8eu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7DvoeeV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88B1BC9F4;
	Fri, 15 Nov 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674445; cv=fail; b=KBX9rMr1xzapm1yZvP8Z9XlBftaNxBIngP1lzhEDcWkrOR8d/sqa0mq1WYtsfk4cpgqGqD7XMLEEaqjrDjhT+Eij625Wc1kwMYPWVWFHbn3ofpzgdxoqn0QbkKVwCLW+jsq11H9imz3Q+0l3IRWFe/eC30AOJ8PH0sMgFxdkDlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674445; c=relaxed/simple;
	bh=rMgzYDuGzwEGx9C3I4Iw+T/QnZblXTcyHcZv6bj9U+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DeXqmsVzsiTQYtToWE0cY40Epojjlhj9HYKY/3E6FSVcb2U0mKfHDWfBT3h28gPX+bLMKDgMbXWCfY5iWnhVqFCiQNsitpAeWL/FYKHzfXYxjAPP0khMt+AHAwFN8V4p3WKRo2eUlCaC9y/d++pTYxmKh/SEAoEVXyMJxQ/uXnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXXWT8eu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7DvoeeV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHLAN011157;
	Fri, 15 Nov 2024 12:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=; b=
	JXXWT8euhxvgEBmCmW0g6JJ6mj6CRnmpy16oBqwWBnV4qRGwxanF+q2hx6Dyj6m2
	htfOwvLGAQghZzEgqc7oIi/bmwwmfMQtTb2BLF0xxolm1BK5WZ7L/mnDT5Dx93J5
	5bPWjPweNC7j/BkFwNikIsjwCey2sRFWVu8tSZ8eloT5VhWf9ZlaRQ1gs9Qwr8xw
	7t16tzeyhkN+ca8JQBq6PV1X4tf0xGS6lOJZ+oTV8d1TFolevLuSbVbQEZC/Yb3I
	l2yiABL/zV4fb3favHDGc08OamX5RFnGjpqhjwpPvUrCHVuiUxtVT+MaoVWTMXHH
	KbMoh5953gf/Q/aFQO6Emw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3dda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCdZAI022819;
	Fri, 15 Nov 2024 12:40:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mrm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIyQig9iUHcjRaorryJbTcCWY9+F3vmQQzbH6iimWbZ/8Vxbc2aWqyWjghFDPFjZpmuy2cUNezXrKB7ytQdVVJtqkWHxhdkfrrW2myMmAlDluNXMu18FLAO0OViWs1bK9MNij3e0FI4jOf5RjquZ2OJfLovE54k+mqCi3GurtNXNIDXo8cLfsVDafMEFINgJMhDbUkMp5XVfjvWp5J4m33oYR4C/GkRmybdNkIpjLzWFgLJ7LzMWDwycWuc9XzlxkTElijrgOGNN8UlXWS3Pzq52k/QSX9149lajJG0NNT+kOcVBVfwYFcB5OTPQXNlRM4OyJm7HBERFu3qJK04bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=;
 b=c2bQ9PVYtqffzQawDBg7mHSkYa4jdT+s0vZ9gmUcJFlPIRI9Zr54kyTXSxcATkJBP1FmVKw49MMBVOmuYORdRLp9nRGRc/zNQR6QKya71CpF3MyEZ+4bX/9xUK6b1cD6waMmAZQ2uRv4AEOfTpIvLVrN8K3nEyVs9iHlS6jnHh1cb4PCMZvQpVuV9BmTJN6aGFmUg+rOp18WsnG0kvaTYBU5aH0V1/WeXfvsiREDGh87yezSs3VNTfpUqmcLycnw/z/w/esinwewKpDJPHHmhIR0aGjVtoNFqeWHyu+zKZEblFgoAbdldbi1HHG2Xt6Q4i9jU4T1GdOsgUJOsznIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=;
 b=x7DvoeeVCIwFO/tUej76OXgxl/ACnGelXRYwOKTpsbgbb5qu7zR9Bsl/dD+Yr+LnofhSYHKcp17hAPucQiV5ssIr8mnaePyFhOUTrMmlOLTyRhB1Mh7R6WbzSqtc6udrFz1OaFEtqWSqEord7ybFkRidmSUw1T4QBdeAWDNL6E0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:40:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:40:18 +0000
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
Subject: [PATCH 6.1.y 1/4] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Fri, 15 Nov 2024 12:40:07 +0000
Message-ID: <b38c87d7943528704795b6a8717daa44eed0e785.1731671441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c9dc38-2c61-41a2-05a8-08dd0572a925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2i5T+jhegnfc9Og6bvbdciDCTF16DEKb/d70nyDuGD3SnzpjIrwpRbw+inIf?=
 =?us-ascii?Q?c9rNBrm5xLyGSj6VgJHRWJ03w0tP8zjecQ6FVHAu9P+Z5QJIWpodJ6gDm84Z?=
 =?us-ascii?Q?kPA285wkDrXJXMHeb3bGh6SyTAGgCIR5ymufFEvsRrkFEP39XgE7l+NmR4Jy?=
 =?us-ascii?Q?wbYEloHq4izvS3GTZaDnrlHf8AXF7QaDOjIcFRkzIoMkKPKUEDsgMd7ENOlP?=
 =?us-ascii?Q?iXW8Nbcu8jB3H8G4EyUgyJ8kwm+WoHL6a33kgCK5rtdPtAKhBzkL52Xjt7Ff?=
 =?us-ascii?Q?bvxePUuozWMkhjs6K+eLBUNKqZAZvIgbd+lWKNJjQQ0lDCYP0n5nlXc4uHjQ?=
 =?us-ascii?Q?7+aNeELEvBDvjNcxMJMP2eLYkpUC8/lipnXwtvm6s2DwBJofKuOmlCZdv835?=
 =?us-ascii?Q?xKwHWfcFMoZ+WWheDhThrsE4bXNPP3ZzDWQh9WBNkcV6KODjZyee900Zoe38?=
 =?us-ascii?Q?hcJ1B1RzIs4TA/MdOVNKd2JzDwYHMszKOcy0VTWGeMdg/Zzo5vYJMKTaMw8z?=
 =?us-ascii?Q?KU0ZFnqsmvwYzi58EVROqdqSS5R4Kdl3XV/ps5Qj0VT68l5UEcgxgSPzCxtR?=
 =?us-ascii?Q?PzoA+21zQGg99lbr0nnjzJeyfDnyGLDGHSvwoUEY1RWB5CS3qD4zk+Zqp2P2?=
 =?us-ascii?Q?g/xJA0qrDBiigq2EENfX7BGAlLcnEEQGVQKyHRkdgwWL9Oqr3MLSKDOa7VAm?=
 =?us-ascii?Q?xk89dP/y7JQUVe4H+A1U6ekv3fpPzhvuq8/Zi94EEXDrTIa3VuM89emmKNgJ?=
 =?us-ascii?Q?9xEgZ4w4ZPPRSSRlSZ0zE0DM0HBtw+LcsCapofHdUAf/u8Q5grqMRchWnMxQ?=
 =?us-ascii?Q?oph3SJmqooUE2L64LLl6l9Oryfcyeul7cP3d3hcGXehuGLNa6ZZEJRVVGVWc?=
 =?us-ascii?Q?kEdbHbebZez078bzRjm7u/o7kiF0TlD2CPil4MP+H7vpvUcc1IszGmCcScam?=
 =?us-ascii?Q?i9EOnW8rI7dkoeDeH2TrJOCbhtwGlS9RlLn/Jfbk5+f1DtjgEbbbzqPUkIq0?=
 =?us-ascii?Q?iuV3K8JARrtVlUojJwRlobPBnDSB9y65G/uRAeEDFnF0UyLjTESvR4PodiC3?=
 =?us-ascii?Q?RRrCqu2xi0okBE0FxM47JckqJKbYipYri2jAU73Z3oGFh4qdR6qWmmTkDqFk?=
 =?us-ascii?Q?lCTnvFdN6HSo/rU34NwR+HBbxRvak25ktF1cJQJMyyDFY9UDDrd+h/LaX3r0?=
 =?us-ascii?Q?Z+8R6Th3uKeCO01N1Fw3OXmUi4pr1P941bdPt5WCWkZFD39PJy+B/7pZ3xSo?=
 =?us-ascii?Q?GvfZpuJct8dz8m9ibWxl2mA9fGryz4Aqu9ZiJekcbqoRxZsnkpf0OLMx4Nkn?=
 =?us-ascii?Q?ZapG7DHxH4m9XAt7FGlvr6EO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGSF2azYbFTLcjpOhafXSpQfrkzcAx0lLf37yAJbmUHfvznJXgcv+lHDETj8?=
 =?us-ascii?Q?knkZwX1lY0r8ddL3AMsGvxrzYpJN7a1OMvKd6BcF0kltGY9DS55+oyzPLfzX?=
 =?us-ascii?Q?uc3AAVyPn/A/jUFO3cxbqI+G2dpfh20UIxrB/2+GyivxiQ2mxE4BGAmuyvMm?=
 =?us-ascii?Q?0Gg9g0+Qfau0UTJFoBfb3Qh6Bdx0dJPii7TaLzjRK2DxG0kmLR2mI++bbkku?=
 =?us-ascii?Q?DYbzgJXNzG97OTT8iYXSd2kj9o8No6IKP3bOd5gq0ZnnrP4gQaSx3BEwEx/Y?=
 =?us-ascii?Q?MZj9KZeiyRXtzu6CnhpjOqrdruy02DYqyjmIQPVRNGeoDRjArF61zBrqtUsZ?=
 =?us-ascii?Q?8KcFb1GbFCSrhSsbT1ZI/6nkiZO7uqQJLwkt9Z+NDMkmpd+MK4bkMkA9+RXO?=
 =?us-ascii?Q?qJAL98nz5/pOnCT5FvgQ38gKtvpviIW4B1pKrLVGG5GPglSnkNwKXHZnI687?=
 =?us-ascii?Q?qyDsICkVvqdGSJGaXOBCKTOsQ/WERspMOXsbiIHnL117trvlo2U8m7IkZXbX?=
 =?us-ascii?Q?+SAvCxTXELnZ/tOjXbBoQUI6pxN9OiFteNfbfSqZHF6bdegnDTulEtW0TJ6b?=
 =?us-ascii?Q?awpf4909/mAymuYi0bANI8YElFWUpnoIEPW+mmkVYwT1hwY59Ov3SavwUWF/?=
 =?us-ascii?Q?nifoR1qCKSlwvi5CfiV1gMV7x0EKv0kpQXV2Wc/024IdTpuq9O6EyZE7DHJQ?=
 =?us-ascii?Q?1xyUmQyo3DSrTLVA61kLKrg0BqAFU0wo767u/9/zmKjsaZ4w7A2R2upz9v6G?=
 =?us-ascii?Q?utjysVbvOUuTZ3cglsWloF3YjprkqyHGcmoxpteE0T6/5IkyVJNVoM8tI3Z8?=
 =?us-ascii?Q?ENaslH5HJLuZ8t5xr5l6WJoYWdMpbBW0LFGEllhOMykGZipW+mfYRBkvkFRW?=
 =?us-ascii?Q?uFCMWwJcuGPabBew+vsJRAkU990Bd9sdbvLiMA5Rnsnzq0zUCOvpCwWhFwRL?=
 =?us-ascii?Q?HnDRGvcdzrbsRHjuHipTTAcXRcKkx0q0uQwhZyEItfCng66k9Q6MJ5JQ+yXG?=
 =?us-ascii?Q?gn7ua9r/cRPceHDsSq37S86ahmpjbgPydXNfORPYzYGBZckdgehjnPs+k3mi?=
 =?us-ascii?Q?ybw+OGKlefvRCuOlmj1ZvmbUf+fwSc7/D0t7tTLPQhF+U3AwZsz/nNAmnAuF?=
 =?us-ascii?Q?OB321CaG0GGKtB9mErQLuTp9ixE6r/e1vwj2kGKkO107aGVtAyBSKdy5w8iu?=
 =?us-ascii?Q?fLM3DPMP03fnFDNWP17+B/BPwa8sOw4BWVXBStwK6f9sgGfBvcsbtYfOj4/S?=
 =?us-ascii?Q?QstYjjINHdxgNq5xTUtzyd2vRIsC0czyzAuzwJnIOqRq5cAaTsnlCPk2sTyB?=
 =?us-ascii?Q?FfkiWz5YWUB7IUAqLQTwgB+ahprJvO/6HDAjVdyjDZd0LJ9PKyGxxb9rAeXr?=
 =?us-ascii?Q?q0lkrUkDigkayWhywCKD8QENzT66VgKjn+ujrCREFWeVTJ6NiqcSrrGShv9U?=
 =?us-ascii?Q?1fOPu1c1fZkocMcTqZ0mRhC1aVj6GpGkZLbpABxy4CE+Uhyj9vmfQIZZbbn8?=
 =?us-ascii?Q?ztVN4NQE5ualqa3Mxh9CZWaqIwfqlAKCN3z+JjZZYn5n+WyzNwB94Gbtewc3?=
 =?us-ascii?Q?HK8jAU0fYq7aPGOdv4KY+WxjmdeNuUwnwjWOCjXDnQ+ak7NWDQAwD8BSHSVD?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w0uLqw8IJnUpg9jf49YCtd1fPc2nyP1LyZx7zW+lChJKt1lhN0iNY2MvSYF0wpvBcHgWFz83yJraZhiaJfm4UsZIsFRpiA4n26H8XcAB530uO6bHrv+c/nWYP2BV47KmUZEyKXy0WpFL7zfyQUHe5zbqZ30XeTW5D11DaIvlJRur+/FemYH3jztZkI/78KnGSpmrdcrAWDpL56JqLX3I776Fx4i5juVc83qhazwgIndNy0l1icW+X7TTxTb48BQ+lj0t76+o3uBJcXasJ+QPztCUr++HYCrsfAFnkr7/zDr4+ZHkHFFUsEMMhx3zWatG+bT7871I21PJr3Q2PoMxKhCsV1gIkRktYhz/MWqXlMYlNNUCcGVDCRHxBNSzNTNlOkIDtfgX6eH+FbhIXCMXHNQJtk31wkMK6CggYI3qWRBQs97XgaeXcVQu/FfVN8qNYmy55la/A2WqlyJAOYWYGDkn1BZWjG2wmGZ4CTRoSSvwk4YMYEkGOK+WduRrZtX+f1WhMBXAqG5tIkXwS1TE+jlP4g0VZR7gBm6E9BU2nWoNPFWwyU8s7WeXz6yiMzl84/nkMPuMUYwoz9Wf205zMxU5rQNgdzf0zRT3vjNkIzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c9dc38-2c61-41a2-05a8-08dd0572a925
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:40:18.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbFZWYuruv+f5sgYZxWztO5qH1n0oAejy4WAMKoFlbCsobGepJ2GVglKQ62eOTXWBY9taoMdOApSjm67ksr6lFKZH/lznc4zkWLXJG/vYUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-GUID: x5k1YAtNbc21heM-ZQhUXpgV84gTzH1d
X-Proofpoint-ORIG-GUID: x5k1YAtNbc21heM-ZQhUXpgV84gTzH1d

[ Upstream commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf ]

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
    function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
                            -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a50bc08337d2..85ac9c6a1393 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -52,6 +52,18 @@ struct folio_batch;
 
 void page_writeback_init(void);
 
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
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index c0f9575493de..bf2f1ca87bef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2760,7 +2760,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -2775,7 +2775,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_reset(&mas);
 
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 8e8fe491d914..f09e798a4416 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -939,7 +939,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -970,7 +970,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index 94fff247831b..15f1970da665 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1103,6 +1103,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
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
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


