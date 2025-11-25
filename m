Return-Path: <stable+bounces-196854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A3C835A4
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9A9C34C365
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E972618;
	Tue, 25 Nov 2025 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pmXYKwTO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AZ2LZC+9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78804125A9
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046125; cv=fail; b=SgCXgGCeYHjM+TwnQFesw3LjkTO0CYC3YWyLs1h91pc/RF0oC1k+9EZZmgjkEJF+WV9GuqhgtfJh/YC1CxPH5pN41GYIoh3zrci6lZ5BtDCBC5wn5It+Vjh4tlYHt73CdjlIxFLR3jJHW5h4nkq/5u9IRqmlnHnPjXw/S9//4lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046125; c=relaxed/simple;
	bh=pVFDGM2v0lvkZNQkT5tpG9Vl4FjLXTASZmflyq5Tcdc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oulk3lVPR6ohEOavklZHdabk4UaYkL/t29qHuAmCKNYvs/zm+JH6Nrx7jsYU56VU3KqZVvvulwbA5gVJ07Tb56xHPLR1WheDKwceAG9dH7BcjInHMHB6thm15v98Te0EJOsYTeRD6PBDwGekjTa5aDuQE27OaOgzMVhgRdcsNVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pmXYKwTO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AZ2LZC+9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1Ch5C2432591;
	Tue, 25 Nov 2025 04:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=S19jjA6FKvk3CNNn
	oGHHak8I9OG8ifc0pgGfjyOa0+k=; b=pmXYKwTOFXBpuQHZYViNhew91snSDElv
	wpsJpDcAevGAhfudk5n1uHe2Gz9Hgvi54/XlEGnWCESOZIceq0ZvD2TPBIEQqjOO
	VM7ejnDjtzuW0p1rkV1Aef/ZL9kjQh1taQN90XU8ykRSwLIXz0JaYhhnfhrlReby
	G3mvcxPkiDtAqQ03racXvCEsUl75jQIXgQsU5I7l7BaRs2w9PqvillNyaL4HpeVH
	nQ8SnB1ZOX8OyNjfwWvi5FQHmuOmKVE7CF1eov9cRVMFMiMrdM7jgds4VcbLMu+V
	BtMmsLrghTyKm64pHzgLRGkl3z8PxyZHSa+gsbM3FbNlNZcxDcdqdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycbdt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP4Ta1d022175;
	Tue, 25 Nov 2025 04:47:07 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mcq7rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6EutYzKbeYD567OEVWCkX/UTerV4lRv4nLTWoLGFJnibXrZiiQX8LkqT2GdT2Ja02egjQvQl8e2fknC6028LINg3hUlcLT99xjGowOB6cbGjltshLX7Rq65rb961VtEAMU6aXPQYdP+GjzD4PalhbQF2CiNmiD4MGKoQT+TIM2DjZpY01gy8Bic0z3fGKjmdA+Hjc28KYC91I6UM4YUxSsWR3t6Dmno0EAHP3MmKw/0pa5fp9UoDbsNAgXllFIyk6/jz3Z4RTjzy92dXHQDbucQkaR3Spab1jQw4q2/tbnTSOacC2XQNI8XRkB1Haj8zOypGeEd4L7XpAM+78zohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S19jjA6FKvk3CNNnoGHHak8I9OG8ifc0pgGfjyOa0+k=;
 b=WDnAcPPPgLX2gRRRzlLiVk8pwIQnGaF6h2VJgibwbdA5Pa+TrxmYAeWOCrN3LaA3Fa7GiKlOugBD8mEybJYhF1wfroZSWk/SAWBO7uLQd64UKYG4zSlsl0L5OYRQP+qoeGDni65U/BIkBfgdkKpKdUIKNj9Iintjn4ltWw+8Rbj5RpqDKv6YTmpeqFOHXEbcpG+wivXMcKo7RAYUDHJYheKnkcK0pN7puK+t8aQ+GHXlbQ1uUNRXAYxWUHYWLKSyrB0o64KTCLCEASlzL1LJ2BZTQ1D3hyIXZp3wFQbUsLL8otGvXgm1pZFsqs5tnjP/bHRdawmOR1mRHhcUHn7UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S19jjA6FKvk3CNNnoGHHak8I9OG8ifc0pgGfjyOa0+k=;
 b=AZ2LZC+9ukT2GnjZBOjq+lbYjnK4DL7JOtU+ifK1XxI11QiWSWpKgqQBz+g6+mAE2AY4TaAqDWSIi1VXRwvIhl3pBJdD3SyfRvJixD7kRfzD2+TVWvUgo9ah8RZGo4d49uSM/S7KRxMYX0EauqfKsWJqGnfhIsh6aP+/LLEOm6w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 04:47:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 04:47:04 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 5.15.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Tue, 25 Nov 2025 13:46:44 +0900
Message-ID: <20251125044646.1074524-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: e30c389c-d29f-4f1f-dda5-08de2bddae15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGRORVR0YkJGL1ZPQWxEWWJYVGhydGZ3ZWV2bFlSbmxiNFI0N0MrQXRwUU10?=
 =?utf-8?B?TVJlQ0kzTUpmOVJCMGxmRndtUGgvWlIxWkdsQ2RSUmtSeml0WXZEY0V5bisx?=
 =?utf-8?B?dnNGeEhJbWIwbFlqWVErZnIrVVVUN1JWV1FwRmtnNXZ3Njg0ZmJCL3VxVlh5?=
 =?utf-8?B?YjgySHpBTVlCbDlnNmR4V3hZVlRSRHREZ01uZ2U1RG5TaHV6TTVNbFMrNjBW?=
 =?utf-8?B?c0dTdlQxdjVPQnlETUltZ0pOMjZjWW1qK1kzMFZ5bjRFemp2Snh2R3k2RWpR?=
 =?utf-8?B?ZVQrT0ZsQjQrTExLYTI5NzN6UTlBWElQUExEYmNlNlNORFJVMGVNZ3dmT1V5?=
 =?utf-8?B?ODdHK1hIeGJ0NUJVTUNxcGVQL3V6ZVJDcmllZ2xPRzZ4Mnc5S1hoY1lrUFpT?=
 =?utf-8?B?V3RLY3Q5R1ExbENUbWtlVjhuTDdHVHZ3c3p5aHcxYU5VaTMwUXFzeGtFY3Rw?=
 =?utf-8?B?aFcrRTR4YmJ1TFpwSkk1elFBSHAyV2xRSjhWd1Y4ZlhubFNEWnZrTVgzY2sv?=
 =?utf-8?B?TFJUNWt3VlUzcXl5Mi9VVXhldjBSbTBjeGdtWGxmREtIcS93dDY4VS9aWWJO?=
 =?utf-8?B?K0RkcmMvazdDWTFlZktDRU1rVkNVcVcvMVIxcFpGa1pqQzJYaWtMdjdoMlZn?=
 =?utf-8?B?RmJYdlpvaCtlT3kxb2JEM1R1eWpMRFg2YlhUc3UyOEc1TWl4MWtjT1VPR0JT?=
 =?utf-8?B?V3pXTWYwYjlGZExQTksrK2NDcFpzSE04V0dzZlhnUXlRK1VDT1dnaElQYnRs?=
 =?utf-8?B?SVU5VmhmSTZMYWJVcjZiVXJNdHE0R2dQcVZueC9zY3ptamFnVUtjTkd4cTNn?=
 =?utf-8?B?TS9oVG01cmx4V2I4TTNBV05SbW50eW5XZnBhMlJzL2NJWFQ2dVNJNXV6ajAx?=
 =?utf-8?B?NVhia0xWdnd0Q3A1aTFVakk1N3hEWnhxclR2Ry96czM5OHFKazEvS2pVZkZO?=
 =?utf-8?B?c0ZiTlA0MExFclN3b2VsSStlOTJnVlpwN3lXcjJtTEd6UlYxOCs3TXNKL0tx?=
 =?utf-8?B?cE0rY1ZnN08waEw2aEZoaDF3UG9iZzNrTXc0ektHcW41S1Q4T0JNMGxoeXUv?=
 =?utf-8?B?YklXY3ZMZWpNZVJuSHQ3N084Q1gwQlBETUV0azErVkFmZWU0NGp2U0dCQ3E3?=
 =?utf-8?B?ZkQ3U2M0R2xhNjljcG9HTE1LZHdJQU1FOHJTSUNVTGMxWENmSFVHNmtzODVi?=
 =?utf-8?B?QmNNbFF0VlFyMkhDckk1Q0VCOStmN2cvY0Z0cjFSRVMwRjJXZ3grRTNIVFkv?=
 =?utf-8?B?L0I5N255YXdkRkhFb2drRmZqdGJVTjRDdUhsV0tKTytHaDY5ajVpeTBJMFd1?=
 =?utf-8?B?Y2tYaEZ1M20yVUxqM0NkRldRT29BSEdhVE5yVnNDQnY4VHBiTGorUmp6R3RQ?=
 =?utf-8?B?ak1aTFBmbFNUY0swdFBNZTB3MmtPaUZjaGs4NmZxaEpoaEduTWxlNlRUZWFG?=
 =?utf-8?B?bCswcVdUK0NmQVI1b1lZMXZvRyt0ak1HZno5SlpjNitrVkNHKzJoTTNKM1hw?=
 =?utf-8?B?MlIxY2JCbEo3SWVOMVVBZFAwZ3Q0eGVsS2tlMnNQbitrZFhoS2VnTi92SThQ?=
 =?utf-8?B?aWJNRGEwcmJPaG1LM25aOFhheldWbmI2K0NPa0NOY2RnOTNSVHFINnhPWllt?=
 =?utf-8?B?ekFqdFhtSkZmNm9tTEI3MGFtZmhDcHoycFdXS3dtYVZoZFI3ek5PbWxLWVJo?=
 =?utf-8?B?WldQWXNPdFM4WFZ4NXcwWnZ5ODFkbmdzYklTbTlSTjFHSnNrRDFmc3dwQThy?=
 =?utf-8?B?ME9Cendkc29ibHVnYzZtSGhncHZpa0o5VFVxeGcySkExVW9PTTZ2N1NSajV5?=
 =?utf-8?B?WVRFTlpyOGJZRDYrd1lsN3N0bDZ4SUJRNTZUcXVKcVpKLzYwQWpER2p5M0dC?=
 =?utf-8?B?M2Z2ZHM3eUx2cTVaUWtZNmx5MkNIU0FrOWJOVHRKUjRrMU4yRUVLQW9Vb1hz?=
 =?utf-8?Q?4HaXLsjAN2KNVDxgliTGQfXijmzMGbBE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVJFeTY4T0crNFBVZFlsU2FqQVNoMTBwN1pxUFVkOXJqeUhHSXEyWFVFZ1JG?=
 =?utf-8?B?a0kyMzRTNVBoRzdXcWowRHVtN3pTUy82SEU3UnJWZzNreWM4R2NWKzhyYWxy?=
 =?utf-8?B?ODlGRGo5a01zdEhkL1JMMWtsemRON1Q5OEZPTkx5cExmS3pzQkQ0M2lWazNY?=
 =?utf-8?B?RDhqbkxzck5XU2ZaaTV3RWxQaFBnYjZVMGJtWkQ0TGxzbE9VanlwS0J0bGZV?=
 =?utf-8?B?RFZTcTdSM3V3OU5vOUZ2RkhVNDBNOVJvWnh2aXZQUGtzQlJSd0hLbmJVaHdl?=
 =?utf-8?B?RVdyL1Rldm50VHpOM2FGQkhzOEc2U0xkTlVWdE5wN3BGcXRZc3ltQUgwTlds?=
 =?utf-8?B?ZTQxZldMMWdpN0VOZW90cFczVGZvNkE2NnFwdXN4SkExcTZ1NTZ5ajRQcm5P?=
 =?utf-8?B?eWJhaU5HODM3WU1JbG1wT3VjM050SkxPZDcwWkgwMnN4YVQwano0MkpqTlJ5?=
 =?utf-8?B?ZWpVRUlBUUNteG0wTjVWd0lFT25paU14aGVqNnkwSlpRdEFJYzFKWk1qQ0hE?=
 =?utf-8?B?WkxPZGJ0TVhvR1I4cnJjMTRlSk1nMUtJWFZBeXh3WmM1S3VrN3JLaWlqTk5C?=
 =?utf-8?B?eWhLcWdnUEdEN0JkREZ6a1MvTzl6YTdLcWtPWUpmK2pVR1pZOTVOcG93QldN?=
 =?utf-8?B?U2VlS0pSUFpRMmJqaG9JKzZmWlJEM1hsMmdrblZFTWNFbHBUTXN5ODJaMmdN?=
 =?utf-8?B?NlptWGhnWXJwZ2tjZlo4RE50aHlkb24vQXhaZkxyT1NTOGZFZFFkM2xUMjR1?=
 =?utf-8?B?UFgwVFZnLzc2dkY1TlFXTy9wM0Y0NjFUTTFRUGpWb1FiclNPSTFvczZ0ajF1?=
 =?utf-8?B?OGNVYkhrNjRJaEV6VytTTlVUL21EcnMreWxVRVRDN2Zic1hwWjFuMjN1Q2tZ?=
 =?utf-8?B?eXVTYjloUVVFSU9nalZyMTN5Nk9xdmNUbnA4OG9CV21WOWpTalNpM3A2T00v?=
 =?utf-8?B?cFc4d0NVYlFtbUhCSWdhdlVIcnVwVzl5WWk4ZkZWVEcweTdYWGg5TFV4OW5R?=
 =?utf-8?B?ZmU0UitUbFdOWUM3ZWVBRWY3WG5wTXcyYVY4VEdKNmpkSlExRUF3RGo5R25Y?=
 =?utf-8?B?THh4cnduaW05N05hdG1BVXFtQVM5KzBNLzhpMi9sRW5pKzNva1g4MEQzYzF2?=
 =?utf-8?B?WWV0K1d3clZnV2NJM3FCYU4yVTR4RXprdW1COCttMG85RmlpNXZvRlhDemJh?=
 =?utf-8?B?ZTJsWFpNMVVmeGNxU0RSSG9ya216WmJPK29KZ0NyOFJPZXZxU1JOYWQzTEtT?=
 =?utf-8?B?UnJnRExPVTVjK0czSytJU09kWHNOQjVUUEZ0OTVUcW41M0g1eHNCMjJqdzRC?=
 =?utf-8?B?V1B5d1pTbUhsNFg1eTlPNUhldXFIRE0vTGZuQ3E5anQzczArZFNDRWhsaTN5?=
 =?utf-8?B?K2lwdjBhdGJQZFZBcjRwSUxjM3NOdnR2YXVuaVR2YXlKK0E2U1NEUjhzQWpa?=
 =?utf-8?B?bGE5cDllcERSS3gyOVIySDMxenFudTR4SjYySHh5MzFXYUVIbkRkSGRxNGEz?=
 =?utf-8?B?aWhuODg5SHZEWlpUanBSeGFNU0FtZmxETjltWWk5QVVISStJdUx1b25kRGZE?=
 =?utf-8?B?LzFvYUZQMGZMcGJQUmNGN1FCYlBNWHljOXJDcTA0S0VVWUFCTS83MHMyOVRC?=
 =?utf-8?B?Vk9vSWRYUjJMQW9qWTJaZmdnUTdwZVBLVFJZWkZEa1VhSkIwcDlNR20wNGda?=
 =?utf-8?B?RkNaMERuL1NOZ1dpQ1N2UXJJeHR4WS9LVjRrRzZSbkFuenlpZWZqajFEUU1v?=
 =?utf-8?B?cFYxTCt1TzFENU5xd2FiUzZOa3lIaC9KTGprUi8vTmFIRktNamJjd0xUSkFT?=
 =?utf-8?B?c041WWFHT0FkT01aNlZIV1E3cjk2bVp2dkplU0NYb1R3eGN5MG1vbE8wejAy?=
 =?utf-8?B?QTluYXBKSmhHU0prRzJhaHMxLzNTNGc4bndyQ2FvRldxTW8yV0JRWHYxdEU2?=
 =?utf-8?B?c2l6NytXZk9tdVllY0lUZmIyRFA0K0d2ZmlPRFR2bVNMNGFWMGhObnRmS2ZT?=
 =?utf-8?B?a0pRUGY1OEdaWlZFeDc3R0hiL3Fvd0lzeFhFdCtQOVN2aThFQVg0OVZBcHNi?=
 =?utf-8?B?UG1LNkxUVG15emRzbVYwL05COU5ZV3NERnVxSVlHK0k3NStXaVBQUkRvS20w?=
 =?utf-8?Q?nnWoM/n7UCwA3SQt2wQ+J7eQs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VJiA4LlYPJ4rKsleGTtOFRzbmsrMm8TpEcYqEYFPzZuXZM/w8TkWotCpeVUwY4h1Ziu1a4ecFU1L9tvZuzklV5i5A9lmXGXubW4ZhW68b5n2hn5PjyE3VVxaf/UAGtypgVRhuFlNPNm7IvZFBIPZnFz+ui9XjpkbFkduqnKXJj5YO+yaveQsLrEbf7EqSWwJdoVOTIuE+ihpNLibJGzSgizAqX/6Kte32/1KXfeT0yOJT38fueH+HbTUhkfCN9xixY38hVeFiQdxVLK2raSz7Cvh6AT3eBJXtGFM/tZAtE3ReDpIMoVHiN0OmFiF8COPWwjV3mrvHG1yvrFxBYNEZR3xOX8sX4cRZ25mUO3v/xaOYJLDistjvaL0r/vsDJuljfcn1Zw2KRd+9Bv2x7xq4Exc2cLT3QTT6XjJdIEu7jtUp6OIanVfsbu8gwByZCsnjmzwj795/6sO5NzGKeyTSfCU/Y+0VnIQWccAuIwdeIibjuM6trM+jk4ULMJxG4tV0c870b3kFfNB8FgXfHpT4Sq06eK94XVZA+r0xcTRCvOeK537PufTyTYvd2QktXtpQrWfVoZ2C5JPYlQgNKaFgJEU0jdE6zbxBqINd1So/Iw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30c389c-d29f-4f1f-dda5-08de2bddae15
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:47:04.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehlkb6h3wKZzl8Xwb5oMgUtWdF/0NUJvaO9Ix41dXlFmXkJHRuLhnccofhPwEQuH1tlBUkAg9F3910Y7/ds7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250036
X-Proofpoint-GUID: cB2tGukFVr_qsuHA7YA5LwM6vMvenpY5
X-Proofpoint-ORIG-GUID: cB2tGukFVr_qsuHA7YA5LwM6vMvenpY5
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=692534cc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=S0-RAjllWCc2AOp5NP0A:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzNyBTYWx0ZWRfXzAe1CzB4Yj8z
 w5C6ACmoGKdpj23c7a4HCHj9oRuUHFnOjjCPaRpP9nRLb2pa7ImaeSnrwwc7pK8x0JFEGHZXP61
 IUjxuP3IPLgJA2lftzqRw84WwgNpnpgg2XSm3WHVA+GGqQXi2k8h/Ho9Sed5CyuPD4FihuTN8m9
 oCyFuP3SRtMrpNKbpoFqdX/1Gsaq4+zGsQ33qG3YjPMyqERrwREpp7eUcLMCQcMZtGf/9/D9DG9
 tqqmG+e/GecQy/x/7TWa56l1gy/v87YzKrJdUDMo86MBv/EGBsqFnxpOPKbjeRDe+/lPizdG6Dx
 xT1fugdGGzB5OvKss4TiBN/TFO1RmQ4duLnUSjBTW8ZEVT6TeT08OMPZtwndDG9e3tpJNwM1KeN
 qxxbYWZ0eg7pbeU3WJiLNhGgbCHpKr+Kbv5iZo2fgVeoMBQxGj4=

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.

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
 mm/mprotect.c           | 121 ++++++++++++++++++----------------------
 5 files changed, 59 insertions(+), 74 deletions(-)

-- 
2.43.0


