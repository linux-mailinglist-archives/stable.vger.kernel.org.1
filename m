Return-Path: <stable+bounces-112026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B71A25B48
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7981F3A1ADA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0DD205AA7;
	Mon,  3 Feb 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chx7e26U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IDLpMoJn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706B2A1A4
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590548; cv=fail; b=aihQrCiGFwLAmqK16LyCpJKxyydEagRC+w3TzaFHI/INHH08LKbjW6ofsh/RsFkfFsVsW5XjUwXJH0MnxYN8mRVftzU4lt7Tbnp1XDdPIgSqJyYb6JxTOwGE0zsRQRk4BaS/CKVsexh0ob8vShpAeJHr9hbd+hhLoHwyCG0+54Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590548; c=relaxed/simple;
	bh=n5dOILniT249OD18MkGNbZ3QBPBUq9FpqneBRSghX2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdUJHT1VTUS2srVQeE1HFdONFtrm9dFQ/iuClugKv6h20WMWuBGrKl7DRb+dLv8KLMAq77p5ogaxgRMww4baYcZgbvO36X+B3IpH5yj+zGmHXfSigPLv5gkCgJFHENsW922TwxE8Mn5Mg76woW96EgcND2g5CopDN5p3dxs/fgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chx7e26U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IDLpMoJn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5138Mi7b029600;
	Mon, 3 Feb 2025 13:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zhqKNRh8eEI+lQzNm42sgh/4uf7HPkuRD0r//jXNx2c=; b=
	chx7e26UwAiePnLPjKlVs/t4PUGyg9bq2zinp6Ka99NJ44iiUKF+bi0OvBBNRceE
	bZGB4fnRGCgOiEHxU6e5NC2+HCq9gf19+xDF/tdc21VWWXh6kbdnhUQ8rYC+hKyI
	s7/zaKTBE7dZJikFpXUL5w112joo+dTj5/QgTX5qhZz8e/4cVTfKsK4wk9QqWhfv
	Dp0wu/82BnKIgB85ZKta6ctffhUVm00BvfdJlPc5wY0myDFl/Xf1/qHwm93GJGym
	GQr9XDS63IHJ7LqBbUuL1Ie9vo5TSOYnZRw0MNgAho2ECnC/UPSzfRI+mrGhsUob
	cngPwd35lPJx9FqG95VBYw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73j8uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 13:48:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513CKxXC030847;
	Mon, 3 Feb 2025 13:48:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8djwe6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 13:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1oVZri9lebyffAjlo7P1KZqdnAoywGr+pD2rTAbta+OXMCHHrzadGbFs9eqOO96CGbBwZ4Wt4eXc4Sq5qw8MbWF2kukpA85UdNve3ojRKduTiXWYnNLv2Ecbcf0V+yjDfV1vT2cFk/+KXnsIezmetvWqjFv0oAhCfAb0Un7+lnPdG10WFQzqY3TXNQlfuBZaZdi9AeLcsM5pkj0ZkpYk5Hz4STHWcYkcL8o3U3AsbTS7Sl6LpSbcsoeRhT+kzZp2xhzqVgFAClrAig4qA1Cm5IgDZAYRDYJAKNn8VhOmWAO05rzgM/uJhZGZTfODBKwYBOpPPJDrfh+XYUTUqjnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhqKNRh8eEI+lQzNm42sgh/4uf7HPkuRD0r//jXNx2c=;
 b=Lb7im3Kr8TSIMIwYLYDrRBbEYVLU0ioHpRpEzOAEw7zHI/cEIHQqHoWwPHgq+gEKU3SAboQAHuYLnusaHB9gkgr+/ocy2m9oqrHc2YBZsljof7aqWxIG7PCAGZDYwXH9JVpKwGY3Um/sWXRmxxzjMPZz6VhysldfaM05Rj+P8P1seT2OL3t8F7hWlJ/L94DqbyiX+QZquVSskCCLYubeaSNj2QY6QXgMjW+6DtFerCr7Waajd1Q+lQl+y5XpDvGwg6U6NPX+bIPbKgi53U8+gm3rSoE4SDLvvVh9NjL9k35YF58gaRMXsdd2n3XH96jarIFqAGlkI44CF4HrZGRMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhqKNRh8eEI+lQzNm42sgh/4uf7HPkuRD0r//jXNx2c=;
 b=IDLpMoJnKPNUJRJk5h+yyWj8GpoJmeD8HanXYYBMQgsnz2jkmPGH9cALZk/cVxC2TrHJqGkSN73g7dBq2MVcXAlEbdBYb22Ud3W4fYVNmHdBtr/ITke5tu6IhJzrbRWXNxAiQeTziVW5c0DsdRjPaMz8W+MAfkRZZuFiz2WJWgo=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 13:48:47 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:48:47 +0000
Message-ID: <34dd6053-5c59-4127-9e66-590a0fdfa610@oracle.com>
Date: Mon, 3 Feb 2025 19:18:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free
 of block device file in __btrfs_free_extra_devids()
To: Shubham Pushpkar <spushpka@cisco.com>, stable@vger.kernel.org
Cc: Zhihao Cheng <chengzhihao1@huawei.com>, David Sterba <dsterba@suse.com>
References: <20250203123719.52811-1-spushpka@cisco.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250203123719.52811-1-spushpka@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f821a8-ed4c-4ddd-e05e-08dd44597b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0txVnJ1cEozNU9SNXZqVmFxRjc4SEVDbzlha1ErYlc0RnN2WTNheWtLQjh3?=
 =?utf-8?B?TVBiYkJEYmQ5NHErOElJc081SHl6OSt1K1BVR0t2dkhudU9Yd09pM3NYbVpG?=
 =?utf-8?B?N2hYK3FDRjhKZDNOcnQzejJwbnhGWFVDd2wrWXVRekxwR1ZGY0JkdU1NY2Jj?=
 =?utf-8?B?NjZINlpPalM2aE1keldGVHpXT2xiSlVIWmhlNnZPdUl1T0NqOEVrR0pzNmYz?=
 =?utf-8?B?WXpQS2ZpV3RzZjZDcEd3QzA3S1ZHcTJEYmtqYlljZFcyZTBITFBFOHBKd0lF?=
 =?utf-8?B?N2F6WVA2Z05QZ0JXdWFabzMwUjFOZEdvZDVyZkgxaXZIYk5BekNKZGt4Snhj?=
 =?utf-8?B?RjV6TVlFbW9yckFrZllwRW5IaGl1dWJuVWJxbWdDQ1BLR3NaSEZPWHE5Y3Ft?=
 =?utf-8?B?a2xHaDdCR2MzL25pdktWQ1Fhd25GZjBpMzFhZ3NSUEJWZm5kand5OG8xWFgy?=
 =?utf-8?B?OEFyaHRVeFpaSEo5cnNray9mVlVJU09mV2ZyU2pjR0JkSC9NTjJrbzFlL0xr?=
 =?utf-8?B?c2wrRWhkbVU4VDl2Zk5MVVAxc2tmNnhpSi9oOVFLbG9TUC92eFR6OWlDekh4?=
 =?utf-8?B?eEp2L0ZFT1VWc0V4VzdYTDNsZi9rV3FnWXduRWloNEptUi95dWpwS2F2NXJ6?=
 =?utf-8?B?Q1Z6TTAwdzVvZzE4Z3NwWk9QMDN3MHlYdFVuZW5qcDNSdFI3K3p2QUNqd2w0?=
 =?utf-8?B?ODg0VitsanhDT3FJS1NLZHVFbUxFcXE1QzhRQklrdkxIY202RGdBVzZkdHJw?=
 =?utf-8?B?S2NjTm5GVEM1SWdpS3hGRCszZlZ3dTZXb2d0Y2VSSFQ3QXJvZXZOczB5TXdt?=
 =?utf-8?B?UzJhd2FRNzI3R29wSXZHaW5kVjJjVGdZVjdKd1pKMUkrb1ZFWTNMVEJFNGQx?=
 =?utf-8?B?UUVobVlYcU9BOWlmTkZpUEo3MTlENXRrZmo3RUM2MFI5Z3hzb2kzWjZCYUtM?=
 =?utf-8?B?MmJwbCtJSkxNQktZR2lFYTBMSzBUUHNxQzhabmF4WTRuZ3d3cERKS09VL2oy?=
 =?utf-8?B?Z3U3Vi9mbkRka2dZVERDK3VDTDlJWDNVWm90MzN1WWR5RUwzUEdMczcwSkJK?=
 =?utf-8?B?SDRMVWtoazBtcmR0WXIzcGhrNGU0V2xIckFWNEZvdktQcUNuc1E2ZTFmRXlZ?=
 =?utf-8?B?L29FQ3pVSHgvNmlJazdjZy9UUkJMWUlOOHNNK01uT1A1NHpFV2h5ZnFDdHJl?=
 =?utf-8?B?U05td0hEaytKbVVVNzh5MkxLTlpId1ZPVFVsMHFPY0hhRnliQ1l1RUtxMWlj?=
 =?utf-8?B?RlBjSHZQaEZuUlJBR3lCL0puV1pjYkNlZXlwdysvZkVjN2x3Yy9mK2xMa2s0?=
 =?utf-8?B?UG12MTgxLzliNGswUU42MGFmdTJRaTdSS3NKaTRTS1VKaHAzbkhURUZMVVRC?=
 =?utf-8?B?UjNJTlpnaXZxSE9FbktiSGI0TVk0NTVTUFpyaEMvNndKU0dTNGcyVFdNOHlW?=
 =?utf-8?B?cTZlUUpLbFI0ZStrSm1WUXJ6SGtLK0N5UGtTa21TNE5hQVVxdnpDTkZuMFlY?=
 =?utf-8?B?akdXQzNSRzdjSUM5QytESW9FeGIxcVF0dXNiK3RoTkRNRGNvbmNNWUxLdENn?=
 =?utf-8?B?aldkckI5Z05XYUowdytZT1hGYXk2djNXOGRtY3MrczJEOXNtK0d5OWdYL2p0?=
 =?utf-8?B?Uk9QOVJYaWczRkkzZWJUMW14RFRNWXJYVzRCa1NQQ3NRQ1BHdUZiUXMzQVk0?=
 =?utf-8?B?SVhwSk5qMzYxNTMyZnpjUmplTGRFYlFCRmhKWlhOK0I2VGMvR2xQdzlhN2Zx?=
 =?utf-8?B?bUhhOWNZbDRNb1FnV1NUcGhYT2h4dE9TYnhsUjJUR1NWNERaK1EyaldiUW1R?=
 =?utf-8?B?NjB0Y3B0cjBKL2ljSTBsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhNZlY5TmVlY3dmZW1RZzZJbTRuZWczdFdRTjlRanZkY2wrQ20wbTdBNmtj?=
 =?utf-8?B?dlNoRUtEQldyUHpEYUliOUE4elFWaHB4VHB1SW11azJEMWxkMHpZaXlScDVz?=
 =?utf-8?B?OXB5elJPdERrNmhIV1ZGcUlmUlA4Smc3U2tIdmxnZTJxYjgrSVhZV3FiOTBT?=
 =?utf-8?B?WlphY21XdzVXWWNVZTJhMDlUcUh5QjVrbDFsUHc0b3VCdWlEOUVha3hzWXJF?=
 =?utf-8?B?bVJOdlBEZDZ5UTBGcnYwSlhqcWR5MUU5SWdIQVpMbnRUY1NoY084aFpDSlht?=
 =?utf-8?B?TGpNNWNVa0NKYW1uSUpEZHBwUDVVYnhsWTBwVkdIY3g5K2FoN0tYTlBsYUZx?=
 =?utf-8?B?QlU4UllGRnN3TWh6dHdzRGVLN2ptdkVRZnpqalRLNDBhbVJ0U2RjSlVUSGpI?=
 =?utf-8?B?UG1VNjhMU1cvVGRkR1k2ZnJsV3c3OTEvRkNhbXJHL2RrMVFzbnVPZ04wMzdJ?=
 =?utf-8?B?d3FCVUZMYnFMQVBZdHV5U0dyM3Btc29tWXBwRHNoeks3THdvZk9Gd05tYjlh?=
 =?utf-8?B?WnIwbFdyTGJTdUpmUlJuYnc0YUxybitYZ0lZWU80bUt3YTM0eEFqNm0rL2Fm?=
 =?utf-8?B?UDBDTTkwVTVTZzZaOUdGcGg4Mk1KditvcWpUaTAxWk1aWVVjZWNWbEdRVjYv?=
 =?utf-8?B?bVlKaUgvSE0rWGR3dzlWWnVONjRybXRhS3pERFo2R1RzQ0RSNjBxUHBkYW5J?=
 =?utf-8?B?dFlNNlNLcFVRVXY1cGEvY0xzWkE0cmh0UDZpREt4ZWxKb2ROTlIrYVZEaW5V?=
 =?utf-8?B?cGg3aUFyN3cxdTdoZEFnU1hEc2VNUUpwcFBsUlpzb1pwNi9CNTZ1TTcxYWc5?=
 =?utf-8?B?bWw0YUNtZmZaays4Rld4ZlJSUDdBSEswMVpPNVZHc0NUNjRtNytNY1B4eU5m?=
 =?utf-8?B?UVNFcGc0SzQ0YUkzMHpFRWZGQkdub05Vd1AvWXZvVTVzUkZveXRiUS9Xa21G?=
 =?utf-8?B?R0tuZllXWXd0WDB3Ym1Uc0QxbFZhSnVJT2hCeUtwRU1jTDBhZWt4MnRRWEpr?=
 =?utf-8?B?S1hzd1UzOFVURnRqb1gydS9Uc0hueTJrVHlMUlh6VW1IM2tDYis4RG9TSXJp?=
 =?utf-8?B?aVpUT3pnc1YrandnUUxDUGpjMGU4NmxtNUFwOVVXRHA4MGxQL0JTUG1TR0Z4?=
 =?utf-8?B?Q0diSDVtRUVUNXh1T2hTc2FiMVg5MGVGWFFDUEs5U3BXNHdvVVNhMVJSa0o2?=
 =?utf-8?B?VHg4QmY1bTR5ZUJHTnBLdUlLV3M0azZKZk1FV3BwN291andEby8zUU9WSnYx?=
 =?utf-8?B?UkVXV05XamhCQjlCSEJ2ZWdtQ2IxZzMzU2tPdlorOXVNeTFia0NZU0l3TkFO?=
 =?utf-8?B?U0VFV3RQQjd5R3hpRUZQeG1TU2NUK0xBRkJkQWpib0FXS3V1bHFYR0c1eVRj?=
 =?utf-8?B?UEJTMVN5aE5ZcXVtSG0zRW5Cb2JOSkZKN0l3RjF1UTV3bUJpdm01NHYvM1Y3?=
 =?utf-8?B?RkpmUTZkbDc0RmFZNkRKeGNMTExVZlVvZXIxU0dzTVBiOEM2UnVCcXUrOHJW?=
 =?utf-8?B?QWFvT3dvd2xPSXhkTkVXaFB5K1Q5WVpsMDZNeS8wWEhVOU1uTkI2c3ZPOFEy?=
 =?utf-8?B?NDZtVENyT1NMeHVDMGdER3dXR1JyRnZQTDRoWW5IaW9PUklzR1l5empYR244?=
 =?utf-8?B?TWJUdEJQeG82YXlPaDNJOVBUZU1yMjJtQkltQUp0b1VxWUtkV1BKZ0NmWW5Y?=
 =?utf-8?B?OU9yYUtNRnhyOW5Za3BXWEJZb1NZSjBjNnF1V1dtcjFONnoxZjBoNzNMQThv?=
 =?utf-8?B?aUg4WVdsLyt5cHZWeWtpbS9xOEFHMUJZYmk3amd6NnR6RHh5UUVseHRmNVhD?=
 =?utf-8?B?NTkydFZvTWh4QlZmZVpzY2NYRitQTnphSkdnVUZYaVlwcHZFVnRUdWt4QXg2?=
 =?utf-8?B?TkxaZjdBRG9qT2xEdFlDalptNzQ4SjJDTmpUK3pERmgxUy8wUzhWN0gvVUND?=
 =?utf-8?B?WElxRGZVSG1NVHF4L0VIZGZFQ3RUdzZSeHZ1akF2T1V2UVB2Vklha1luUW4y?=
 =?utf-8?B?enRmOWw1cnhERml3UmxxbFFwWCtuZk1iUDIvcXJLZFo5OFBkVzZ2MXlFNXhZ?=
 =?utf-8?B?bnl4RXVKcUpmR2d0Q2NRZEdVOURuRlhCY2xWRHNFZXZCUC90Qk9WUDhEbW1Y?=
 =?utf-8?B?cDdDQWRiNHIzUTY2QVk1eW9QUGc0M1NER1J6QWxzTkhDa0ZteVNuaUtDVTAr?=
 =?utf-8?Q?4DqleUtXhiNZjnHwnQelviw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OAeukrJdevQGnGPijTuXWFQe8nERuX1IN7iPY4TrHHjmOlF1yOxv8wyBHgnDV5yPobPfOj3ABGFoTPEf7AuBMdF+JM5jMytXMznDXLNXb4wQ8lKWe1+JV72j1ftTgIh0H0nUbxEGtP4y0RZ/M4/XdV6QOwoqgvUbfK0cTsIfDqDb/6k/KvbT6WDQ1mBdRZJjR1V/dVShB9li5FMmPJyItyVMiGGhkTA97iZ4g/daltN/IjFxenUUQ/4KlQ320g1MtQZnyheOyQQXDoqukKbVNvduLEH7MgIasweEuv8hTkhfaSGXDa7S5AICW5Vy4leThXPfelnZMEJmBjVA4PFLmJFSHcI2pfonls3v6oi0dRjutM/P+VdFJPBErUpoHEiowAfAcRPIOBbgvybGwa1aBhlactj+UOAvfUMSU06HMChoitvizLhsoQ34vFUKOD7mnFsI8685wvOv+nxTsZDnNHzlfUBGcksvfrA4z+0dTGxK9ZUWvqDYbrCa5/lDfCrL4Vl9KGJSJe2oMr2qmR5UKJUk9dR03Dq4cFwSfwGoMLTQ60v94lfiJvx7GRiFMX1dCs7y60imY1p/2diET/qAWvKLrQA6T7RtDCyXXwCa/MI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f821a8-ed4c-4ddd-e05e-08dd44597b4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 13:48:47.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW8jUj7zNKkJqYPAB+rWhMp45houIjTSBtTWuV723Elq+zODeieux86gt7camE16+UhOCwX3ROmeEmK0yYbDs+s5lbiYyQZX18SVXU0eah84YtObQAyL+JUI6tdZYDHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030102
X-Proofpoint-ORIG-GUID: KdIenhAcwqm9QnWUAvmllSjBJAuaIIVz
X-Proofpoint-GUID: KdIenhAcwqm9QnWUAvmllSjBJAuaIIVz

Hi Shubham,

On 03/02/25 18:07, Shubham Pushpkar wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> commit aec8e6bf839101784f3ef037dcdb9432c3f32343 ("btrfs:
> fix use-after-free of block device file in __btrfs_free_extra_devids()")
> 
> Mounting btrfs from two images (which have the same one fsid and two
> different dev_uuids) in certain executing order may trigger an UAF for
> variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
> following are the details:
> 
> 1. Attach image_1 to loop0, attach image_2 to loop1, and scan btrfs
>     devices by ioctl(BTRFS_IOC_SCAN_DEV):
> 
>               /  btrfs_device_1 → loop0
>     fs_device
>               \  btrfs_device_2 → loop1
> 2. mount /dev/loop0 /mnt
>     btrfs_open_devices
>      btrfs_device_1->bdev_file = btrfs_get_bdev_and_sb(loop0)
>      btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
>     btrfs_fill_super
>      open_ctree
>       fail: btrfs_close_devices // -ENOMEM
> 	    btrfs_close_bdev(btrfs_device_1)
>               fput(btrfs_device_1->bdev_file)
> 	      // btrfs_device_1->bdev_file is freed
> 	    btrfs_close_bdev(btrfs_device_2)
>               fput(btrfs_device_2->bdev_file)
> 
> 3. mount /dev/loop1 /mnt
>     btrfs_open_devices
>      btrfs_get_bdev_and_sb(&bdev_file)
>       // EIO, btrfs_device_1->bdev_file is not assigned,
>       // which points to a freed memory area
>      btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
>     btrfs_fill_super
>      open_ctree
>       btrfs_free_extra_devids
>        if (btrfs_device_1->bdev_file)
>         fput(btrfs_device_1->bdev_file) // UAF !
> 
> Fix it by setting 'device->bdev_file' as 'NULL' after closing the
> btrfs_device in btrfs_close_one_device().
> 
> Fixes: 142388194191 ("btrfs: do not background blkdev_put()")
> CC: stable@vger.kernel.org # 4.19+
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219408
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> (cherry picked from commit aec8e6bf839101784f3ef037dcdb9432c3f32343)
> Signed-off-by: Shubham Pushpkar <spushpka@cisco.com>
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b9a0b26d08e1..ab2412542ce5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1176,6 +1176,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>   	if (device->bdev) {
>   		fs_devices->open_devices--;
>   		device->bdev = NULL;
> +		device->bdev_file = NULL;

Looks bad.

"bdev_file" is not a member of struct btrfs_device in 6.6.y. It is added 
only in commit: 9ae061cf2a46 ("btrfs: port device access to file") which 
is not in 6.6.y

Hint: This has CC:stable and Fixes tag and a clean cherry-pick so there 
should be a reason why this didn't get into stable easily.(reason in 
this case in build failure)

Thanks,
Harshit
>   	}
>   	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>   	btrfs_destroy_dev_zone_info(device);


