Return-Path: <stable+bounces-206086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A91CFBD65
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6FDF3077662
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A723EAAF;
	Wed,  7 Jan 2026 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h1mZBgDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e6xe+H24"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75A264609
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756392; cv=fail; b=dZ1MTxFttqdDDcLO4KyUqS2BC+MBRwsH4jNVYPmPdht/kHeX7gYjSCQ46PUKrr+r9nohm810mxpBt545AxokxWbU7Toqhm/G6FNksVWMb7ZPatLoMFRvThhtbCYOGwOfPekCTKYjj7txqXZ9q90fTpvEAcwGu1Z1yhvspkHQZiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756392; c=relaxed/simple;
	bh=8mXgloM79memsPqtZ4X0a1dOVM7P/8PHm2w8ZXjjAW0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nip9hAuRYDB/brGLhJgAoF19L0excRyLIixp71WKH8EcN1/Q2XfJTBFkt5w5H29U95NQNj3PZCLPbqZ3zL9QNS9KMKGQZujl6+48G4agtgF2U6QkhOJt1XRkCDlF50Hzhcr8uJE1qNnBfUaMqvlNZFy/mIPIMD4iBGvJdqQXH9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h1mZBgDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e6xe+H24; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NQTMM689241;
	Wed, 7 Jan 2026 03:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=lofkRKiRHqc4V7EV
	QHFXsEBHDJAkMWclxcMRe8Lotks=; b=h1mZBgDUzvnu/QRoBrpxlhxqG+XgSxdQ
	WdpB7hn3+duAT502twEYDMKu/vghL00erogqXdGKqUpd6wC4KT1CjjyzllRH3p3B
	zeiEWY1R8Y1ZskPEGQ3qHxYLtf8GyN2tQ5p3itzsXtCJFtS1wquH0ArzZiEL4HYY
	P0LdsgbnEk0uSXxOfqr0WFWq+hm/Z4HSgsnsuYMcUreie+So/WdCZgBnx9F3i+p0
	D6cma70jSa4k5/BPRsGNNJtL+PFVqZiNuKsqv5LYHTArcKCNMRtFmGGG5FE00ZIw
	gXj2BiziAF6JMjidOWbsDKm71f8T1EUt6uxVhYygoVLGTja+vW8e8Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhc2fr5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6072IKD3026435;
	Wed, 7 Jan 2026 03:26:06 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjkm6pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwr3iPy2eB5jLNmhICrZ2qIyPITuy3CVWVEuP5rSdacCVUrqApoRRbSZaWKfv8ZuKCi68kK6RgRKMOixuYziRiTgbMMH9YHuMXADeRhj/Kyv7BQbajZw/eff89PhnqzrOchW56LpMr9DzttHCJzpHvpqSj3VlQm2I0JX/7ha5qeb80e2mUSOkiJLp91a25Y2+uBKKR4VYBiAVnTjy5MExO5d67a9W7g15TDBtlS+8AOHNTapnrYy/eGtO6hPAbjHsyuSJUw2jDEniT04Ro9HNudJwBU+FRaIA8WaaO4zeQFarCxKhVSWv/LS0VMzwErOLgsU4StMey6L32RT2xrfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lofkRKiRHqc4V7EVQHFXsEBHDJAkMWclxcMRe8Lotks=;
 b=RCNV8GoLcTiDVedygcp3QVw3+N0UXbnzMQuqJNbZ8OcX9EXuiCIuFKjVk2kKtQ40FS26L/VKoUQMa5BLvyr/WZZ1M/znKh7JBbxJnyusK+m2+10tvtRSaGniL8DCMbaCkTP5kta9g9xN/P/MVoB8Y/CTIn1PIAhE9uq3uEVm2svQr3nHW1FvQo48qz6jBIwB1agGlLyQaSlFJZt+wNKb71DmaXuvLVuZ++8vXoqAzKo47A2V3JVg4Z0Cd0FhjBpZ6vUvSS6FsKzi38pxSGI4zTI/LYPaWZejnYMI4QjzAcw8lHEwprOoFfHC7MCoqhyzZf3j2dJNI1G5KpkuC3ihpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lofkRKiRHqc4V7EVQHFXsEBHDJAkMWclxcMRe8Lotks=;
 b=e6xe+H24TCwwIUz/p7+ShO220SklViKacQReZdI2i4PF6lZLL0QS5b9rHsHpr5iiIrmIMR7jy//TnmW1ekUN8L3apk0d/wsiUos21Moh3MRciR6un1rpJ5g692bsS2gW6DWlWoZ26xe3Wn2J93P5X/U+KPuDgb5yBlfTbJSYTjw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 03:26:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:26:03 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.4.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Wed,  7 Jan 2026 12:25:57 +0900
Message-ID: <20260107032559.589977-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6763f6-a7cb-466d-8d88-08de4d9c7cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnhSTHBDSm5sU1J2THZrbmhjalByQ1ZnMTd0WDVmTzF6UVArcFhPMG5kUHlu?=
 =?utf-8?B?TG8yUXFEY09oSitHc2t5V2x3ZUpxVXFJWlpHV1dNV3IzMmVsMHZrUVpMRTkv?=
 =?utf-8?B?d0lMNUpjcHcwL0h5ODBWd1Jtd2VUTHllY1BDQnZHdWVNQXV4Yld5aWU2VnNq?=
 =?utf-8?B?VXFNN3o1aEp2cFNzZXh2UlBodEFWYmZZVVhZMFlVTy90UHpRT25hb3Nvc3Js?=
 =?utf-8?B?N0FQUW1nY0tRSGRwajh6U3IxeXkvK0lJTlhISmpJYkxtNlhrOFNiQm9nOGZF?=
 =?utf-8?B?RVFDUWxzZjVhVTQrbE5tZTJCb0FrSnVrNW5vcjUyTHR6OVVFRVpwQXd6Q1Nn?=
 =?utf-8?B?VTZRWG5GMUhWSDBuaTd3MnplNy96UThZVEROMy9DTG1qc2NVa09YZ3N4S2hJ?=
 =?utf-8?B?TXFoK2RDN3QxU0RlUHdpZFpLd2N2Zk12cmVrNVdCWnFadDRzeWIwSk00Wjh5?=
 =?utf-8?B?NTlRczZmRXVpMXd5aWljbVlZeDRYZXAwK1p5dCsvbit4aUNOTXlVNUtPTTdT?=
 =?utf-8?B?TS9OMkQycVB3dUZMaWpvdi9XbExDN2lUelN2WVhDL01CWlUwdGtYa0VyZWRr?=
 =?utf-8?B?MGhTWG9jR0FKVHI2NGdxUi8zOXQ1Z3J2UElnZXJxMU1lVVBCSUg0aGVkZ0pw?=
 =?utf-8?B?NUpFL0N1cFZ2cG83bnI2WDNUV2p4TUlMRHlhTmttRnRxSFkvN1pXUWZza2xJ?=
 =?utf-8?B?eW1XQjZRUUlzdmNVNmVaeHRpZjZQa1h0OE14eFI2S2hqK3pwSklCd1FGY1pV?=
 =?utf-8?B?REpDQUdKU3p6L0k3RUdMa2JaekZ3ejBBdUYwaW10ODBPcHlVcHB1VUM0VEtH?=
 =?utf-8?B?RDV5ZkhzUjIwMEdZSjJmVElUa255Z2czSE5URUJjR29lbzJ5VlBQd015OUlu?=
 =?utf-8?B?N2ZVWjBZOEZIZ0pIMm8yKys4UUVJRDlEbURiQmZIbldBTGVaOXFObm13d1J5?=
 =?utf-8?B?aGE4L0FJUUMyQi8zMnprRTlhTzBTWmhGVFFlWGdpZ2tQOEpYQTR4NXl1eksz?=
 =?utf-8?B?UUVXMG1TT1U3NFZxQ3p6VmF5OWVSS3ltQnBJSi8rdGhsZjNmVWtzai9MMzYv?=
 =?utf-8?B?ZUR4OGhmRE9YMkNRN3dyZ0NpMmE2MGlacmNvVGlwbFdpRG5kWGRudG0vak10?=
 =?utf-8?B?V0crUWNFYTNHVVNGb1pTdGM4VzNLbXc2dS9pSjRFei9HTklUTSt0TDBoRlp0?=
 =?utf-8?B?b2NuTGNBQmpSdWpIYWJUZy9FRVZjVWd3eFBzbU1IK2xZelBHZTZ4R00zMlRG?=
 =?utf-8?B?ZjJRNmgxRXB5S296Ymx1bnRUaC9IWmRQaUNyS084V2k4czZYbHNGRC92YmUx?=
 =?utf-8?B?N1FwNjJEZUZRN2lrUm5MdUNwSWxpOE1OS1dLeEFOc2RpV3drRHdWN2R3Wm9M?=
 =?utf-8?B?QWtSNWZvNERsbEFTT0xrUjZSV0FiWXRMR0IyZkkvMTlucS9RaDVSNGJpRkdT?=
 =?utf-8?B?aTg2VUJiK2QrQWFpUWxRaGh4YmhLV0NyZ21tYS84VGdKcmFIYytpQWYrQkxj?=
 =?utf-8?B?NlU5cTIxYVRxNEhsSXJGL2U2WXBRcnFoMlEzT2tPbVp2S09XaVZGb0hWTWMw?=
 =?utf-8?B?bE9nTjF3ZGt0ZmQvV2RYZ2J5eThGaEx5SjNBUXNSTXBiWFZHNzFVZ1dHbzZC?=
 =?utf-8?B?OC9qVmVROGlwdU9NdE9rbkpqMVp0NVBoUjZDTGs2SStDdmF0eURObkJvWUNo?=
 =?utf-8?B?SElPaVU4QjUyWWZySXQwZXNJOFJ4VzRtck4zQTVIUGUvVHBOdHZWbkJuZHNW?=
 =?utf-8?B?aXpqZHM1MEtFL21UYWtaVWEyTnd5dXZBTXY4WUtmUGVVbkJUNlR2TWtLWVpx?=
 =?utf-8?B?bEJRV2E5NzJDa092QmN4SVV0RFZjQTZDQzVUb2FVaGNVUjYwV08wR2tiM2JO?=
 =?utf-8?B?Z2pGak16S2RSMThiV2NUcDRBNzdXTUxzMGJNTEZ5djNQWFJRWWJpM3lDYjhC?=
 =?utf-8?B?Q2VWMGdTU1pNMytvUG56cU8rdzc3SzNhcVBRbEtSNTNubFIxWGpvd0JDK0xk?=
 =?utf-8?B?SVVMWktoSmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2RzRXBZRysvc1BZQTc5QkwwbVFhQURJR0owbVFENWRqeHRIY1RYY3ppelVl?=
 =?utf-8?B?eUdWS2pibDZLc09iUEZ5aGFKU0xhLzJzbnF2cUJKeVczVGk3TStqN2lULzV1?=
 =?utf-8?B?MzBqK1REelp5V1Z3ZWh3SHZwS1N1elE0MkJRLy9aRjYxdHl0K1hmV2ZyczVD?=
 =?utf-8?B?ODMzRDdaUjVPUjNrSVpSdEUyU0FKVHpOZjJhc2twanZ5VUMvTHhyUlN0MEhX?=
 =?utf-8?B?NDBTZ1lEb0ZaN1lqb3BtNXdDbTRPWnV1ZG1DWWxINkxCUGlTK0pLTnJPRTdo?=
 =?utf-8?B?VjZxOGJMbmRsMTl1amxpNUxIU0Y3Vm1CTmRYOC91VHJRZm5YQkVnWE9reXFk?=
 =?utf-8?B?WVh3UWVHZWNwRkFteCtlK3ZFdGVqcjNhMjlZVFJ0YzY2QzV4bjBVOUlQcXND?=
 =?utf-8?B?V2hrNTZySFVsNlBoSk8wdXBjc3ZEdmJsaWFXSkw0UFFhL0diUWRPNGlNazBy?=
 =?utf-8?B?OXViNFh6TXNwQUROcEtWRHFaRzgvYndNM2t2MFZhcG5PbEsxRWZkU1N3dGVJ?=
 =?utf-8?B?UDFWLzZVb0o4ZGl0VUlUaExobUVSMzd2WlhoWGNSWEM0V3lGUDVPOWtUSzRF?=
 =?utf-8?B?YXhJbTRwUElkVUJKMUVmejQ4WEN1K2R6V2taMExxZW9EN1NBRWkwTzY0WXhv?=
 =?utf-8?B?R3dwdm5TdkQwMzF4d0wxTjhSQVZYeUNMaHJwVDFUbmJ3Z1Iza3pzeCtldElt?=
 =?utf-8?B?SkwwTUZwbFpkNU9hOHJlTFh0ZDBtUDdnTXJCdnhxcnFQNk8vRWxWNEllejVD?=
 =?utf-8?B?YXhQNGZ2d2FEaGpuN2RJVEVSdWRIa1BOM1RHRHZyaGIwR3hrSW5oOFo4azQ0?=
 =?utf-8?B?Nm9sak8vWnFSenp1UEExQ1VwczJ3V29mbUtBQXREZndYQjJHV2hFSDgzSXNR?=
 =?utf-8?B?cjNxQWZuaXE1T3ZRRC9nZ1pQQWNidHJOdVVyOGVRRTNLYStTam1zWGw0UlZz?=
 =?utf-8?B?Z3NLQWNDeWRKYmJCYWdkY0dIRmQrQldNWElBemFkbGNYVHlPV3FyNVlJM2xN?=
 =?utf-8?B?WWdvY2hZeXgrQ2pNRCtVcWZFeTljNkdLVHhPWlRLaVBEN3U2K0Z3T0M1YUt4?=
 =?utf-8?B?Y2V2ZCtVUFBiRkRiTVkrWGl2V0tjL3NtbEZSWCszM2pQT2NNNkVLZ2RJbGhG?=
 =?utf-8?B?SUVlSloxb2JqaFFEaWIvanEwM2tYYlFhM1N2VmdQUmtVTUhKOUVIWXF1bFFw?=
 =?utf-8?B?czN0VnpRMHNob09VSXRjNG01bUFQY0dFVkhzRURUT2s1Z21PcXEvZEtRQU9F?=
 =?utf-8?B?Tk1GeWRQbUJ3VW1JZnNrQVFzWW0wbWlWK1BxczZPSjlhVTZmQWJZLzJ1Q1lV?=
 =?utf-8?B?MGFHQ0VXcFVaS2x2ZE1RVzNXdXJyYVREWnhSQ0FwVWo5SWlqREdEZmRZUU9W?=
 =?utf-8?B?YzMrNWlTMFRTUUkveE43aWRqK2trREY2K3ZBM091WDNpWnNLR0E4ZWNxRUJo?=
 =?utf-8?B?ZjJFSkRQcXQ3UHpoUXFHU0RFQkNiRXRQdTBKb1NPLzhWUWo4ZlM2ZGpwb1VP?=
 =?utf-8?B?amJ1RnRmRnY2T0owMm5yekt2Q2NiWnhaYnUyaTA0MGxNTnMxRjBWZEIyeVJT?=
 =?utf-8?B?bTBwL3Z6ZVRiUWVRUTB5NFZSRWVCL3ZPV3h2OXpwb3h3ZjlzcXoxMzFTdzRa?=
 =?utf-8?B?andaVVQvNmZWdnI0OEc1eWcyUkthL1J1NmNQWXJHUThjQTlXRXV2eWd5VHB4?=
 =?utf-8?B?TVdwamtUQ2pIK1FvblJqU1B5ZndYa25IWTZqL3B0ZmFqbkJNZlROZ2dOOTZW?=
 =?utf-8?B?aENtdy9SMVNPZ0JZRnJvUFlLaTZHbElDYnlOVUxxSVYwbVExMUJyc3B0d3ow?=
 =?utf-8?B?bnNZZjNqajNrdlJvVW9CbmhnSVBXWEdyY0pwTENkSit3NjYzL1E1ZFp3Mis0?=
 =?utf-8?B?Ry9tMWlrb1dIeG1hdTU1M0J4OVFaTzNRQkdJOEY5SGRqWVZQREhXQkZtTjJn?=
 =?utf-8?B?YkYrYlcrTGo2RDl6ZXNFSEdaL3paQ3dWQkpPQnArRnNTSlJaWCtlL0w3N04r?=
 =?utf-8?B?LzV0R2dOTWxaR25xcVRQVURkbHY5c1lpaTRyZW44cVF6S3VvT1dibFg1eWpU?=
 =?utf-8?B?NjNmR0hYNGlzTDhCUkh3RVFRUDBKdGNSWkNLcXJmYlZWaVdJZWUyRUJLVTBj?=
 =?utf-8?B?U21WTVhkUGMwc0phWEt1STN5OGIzTm4weGVzclFFaXVDSkxHN215RExHVzdm?=
 =?utf-8?B?TUt3aVdITEkwc3l4VnN3SkxyVDBBakEwVHlPL1REQ1Q5TUIzeStyNU94VjlJ?=
 =?utf-8?B?RGdjZTZIQUNqVFEwVGxkZ29tNUIyY0ZUb05yelNDb0RzbFBOQSsyTTIyYS95?=
 =?utf-8?B?WklPYXF2RE5MdWQ1My9NQWlLUlVsYklEaldnbTMzSU1XNkZPcWVwZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FeB2qI6EP4XcUWSUXrouI7vDyQwZIhPjApHGEDBJoud96mbdPaSvF1KZCfXJa3PjPvwr0Yw8ji2KN/LffnukGn/5gGIQXPXQ7Dm/LO791pTp5EoH9VoQ0mLrv52I2dM9R5r3TYXXMZWPEeNxkC6j5DvZiJFP01DdWnILbkUAR8fdgij+dAis2Z7MgM5+ojrLLBjSMXp6yxfivAsdJUlIntgcUTGLb4zQFZ6bQ4HZ4dPQIWE/3uCV9n5IfCVP3hIfCS4dHlM56Jaq2ZUCRM2T22k+RDt6d6/QGB0ClpLIEhKqiaaj7R6X2BT1IHnMdCU57Hl6NluXnmQnW+irzcqFIohQ7RYmB4mkMipL0HOEDThtNV8LCgjSycXFbZXQtwPCs1odU8TtZxLrTnpQVvMcb/SRBmyEONrh5uxJURU/FhXRVpUkHhzyhQM+FmtlRF0ceeH8HKLA++6vRpMf4OAkGGmdc7m/2t1WJ18mc1ogSyciamygNbui4Mkbjl3oT0USL8vXiqwoWaQ4Ero8dnYbQj/W7VUbqaJyUCO4/EBv+2njdAQHZHVlpGOhdGVBpKDMovJrkdGVYGZQn3cU+D84xpq+987kYN7HCZo6fnTqt80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6763f6-a7cb-466d-8d88-08de4d9c7cb8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:26:03.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkDgIjpn9fr5hRmocmXwkgZE/3WYORNgptjQjG8wjsNEM6LAd2wK6V2EVBLcDxdld1iJC8aM1Hzs0P0jzQGA7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070025
X-Proofpoint-GUID: L-n_XQMEJt4F5qy5dm_hLV48owESlVYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNiBTYWx0ZWRfXwZUhBboTqyjY
 jA4dN9RQxSESlVomcckqQSn6bE4TZ+KJ9PvBsZTJvwUS6dswfbkbvglyNNTlEljSyIz039POOy+
 amh31I4adiQ0sURHiGSs29KUT3dczpcBmzDp81vdEKw4D0oZRthE+xMczKzWno2MhjKrq6dS3Ns
 JdQdcW0jLDxLjFzFWlFnxv0kdM2YdYkeEetSY9T21dWnxdX8ANY4/oIdgIX7g0Axd6aFS45nxyt
 tDqqTMk5eQQ7h3L4Lqf022DP7sSYAlRomdT2E3kwXyWVOdR9oFe9R6w5Wv7LmX0HtR8avhjYAVN
 acRIUfyGx1B3w99Ch6NqRVgA1fvG74N0oZ0XZeuRyiSC+Thkzcee+38zZm8Qa/F36q2KbjG8cea
 aM0EYWW+08f4aZeL+TOF/28vC6P2K3eoNuU71wtKitTyRfPyW+j7S+GX5vwYEz7Sy0FJ9QYGQ1W
 1QOuRgf3OmLxPJgC7BJVBy1KGLSVRsJcThODJubE=
X-Authority-Analysis: v=2.4 cv=KtVAGGWN c=1 sm=1 tr=0 ts=695dd24f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tRLCnyKIFssYOeyxpVgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: L-n_XQMEJt4F5qy5dm_hLV48owESlVYH

V1 -> V2:
  - Because `pmd_val` variable broke ppc builds due to its name,
    renamed it to `_pmd`. see [1].
    [1] https://lore.kernel.org/stable/aS7lPZPYuChOTdXU@hyeyoo

  - Added David Hildenbrand's Acked-by [2], thanks a lot!
    [2] https://lore.kernel.org/linux-mm/ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org/

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.
Since the code looks bit different due to different semantics of
pte_map_offset_lock(), it'd be best to get this reviewed by MM folks.

# Testing

I verified that the bug described below is not reproduced anymore
(on a downstream kernel) after applying this patch series. It used to
trigger in few days of intensive numa balancing testing, but it survived
2 weeks with this applied.

# Bug Description

It was reported that a bad pmd is seen when automatic NUMA
balancing is marking page table entries as prot_numa:
    
  [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
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

The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
by checking is_swap_pmd() and pmd_trans_huge() atomically.

# Backporting note

commit a79390f5d6a7 ("mm/mprotect: use long for page accountings and retval")
is backported to return an error code (negative value) in
change_pte_range().

Unlike the mainline, pte_offset_map_lock() does not check if the pmd
entry is a migration entry or a hugepage; acquires PTL unconditionally
instead of returning failure. Therefore, it is necessary to keep the
!is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() checks in
change_pmd_range() before acquiring the PTL.

After acquiring the lock, open-code the semantics of
pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
if the pmd value has changed. This requires adding pmd_old parameter
(pmd_t value that is read before calling the function) to
change_pte_range().

Hugh Dickins (1):
  mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()

Peter Xu (1):
  mm/mprotect: use long for page accountings and retval

 include/linux/hugetlb.h |   4 +-
 include/linux/mm.h      |   2 +-
 mm/hugetlb.c            |   4 +-
 mm/mempolicy.c          |   2 +-
 mm/mprotect.c           | 124 +++++++++++++++++-----------------------
 5 files changed, 60 insertions(+), 76 deletions(-)

-- 
2.43.0


