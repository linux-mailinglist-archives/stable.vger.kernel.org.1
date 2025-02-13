Return-Path: <stable+bounces-116341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F597A350A8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217F916D72B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BA269816;
	Thu, 13 Feb 2025 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1Zy1jUN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3WNNHQA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E01714B7
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483256; cv=fail; b=LCpdHaq+Q6/P6HTdfdK/6+Sj+gnWVtjRbhAqREDhiEq+RM9WR/QfAxrdwkI/uICo1efvTkSJSm1GftCFUTBJkRbTGKEs6tG9PZrhQArZd2VSxnlwsY64Ktwxq4ONic1fzP7c8YA6kVRMPMzyOhww2+EGz7mpu/yzRSXxKqe+Qho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483256; c=relaxed/simple;
	bh=KuEoXwQ+KxJ09sDWrmA4YjUnMn4Yoiz03ov3z03XdiQ=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Y2+16Izv1hBglo6DzHY/+cOOo3TXEnNVz0E/zZI+u+3RgMqcTSY6v1MrPjScsJrh+5WhzUNuYTFvVwXYPVbABvsy5FLEfnBSN+KyMvgu6TOrjCRACy32eDtt0/e/ARw6UvtSytx8mqdLPKtXDhelOCRMk/PAoU9RLLzh9Tw0Csc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1Zy1jUN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3WNNHQA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGffBd015258
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=KuEoXwQ+KxJ09sDW
	rmA4YjUnMn4Yoiz03ov3z03XdiQ=; b=b1Zy1jUNkkw5gNEjKsETB2kZOoyyGAiM
	8K09BYyGvtUWX0kqhbiV2JQ5+0pgTE57NL4glqwctNNGCbKBe0s346jeERGNIAtt
	LRfTeFQkZq/sq/DVwe78CjpOEXuAzoYCU9NHDVT3qhqokxVtHhlcvUD9mmt4/4Y1
	HPnDZmY/ABJfl6cEbqHXFsoNRS9B+/GlbA9xZLDnZ/VJ7t+dcTgjNXz+UdnJMMtt
	DVH1LjhZkyj/HyTv0y7rZJW8nU+bH1AlNETte0kd3UQ5cVEE+Zge1TS9EvDZXt/W
	aoRvSEIvt3SKbCsGIhXgJ8zusAc+lXK9Uz7gPPvc4dyS66pO04unYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4aghq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:47:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKO2Cm001112
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:47:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p632s6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6G0DgX5nODQl98lJeUOvyNtRuBLFwgUcA9PiJ3dbq14B6f4QjF2iMJIG1ZPEAI3oWbtU+yHdBzIPy7CU3wrGulHEA0S3NNxzxOWrj4pUiNh3oKf9NsxcwPja/icjOZv64POPR+CajYVjPo2k4A79dMznCjPOcVmdhg59SBFAqv8RTi4NBBcssrbhMJ6wkj99VKHyBEoI/iqW3xRkk3KYVtz2pqEvfKM0YO7K398Af/2CfUs0bOTPjYR+yLZqwCYRwrGdGKZuHZz8pH5U4qRfY6Wwh+RlJXOhR7kAflRpNQGsEsJ1Ym6EqWS+Aa7/9XtUqAHkfvM5aKfT+QNqcMYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuEoXwQ+KxJ09sDWrmA4YjUnMn4Yoiz03ov3z03XdiQ=;
 b=L61rWI8QTUoWcY4xr6R+nRkBLJOYw5MWc2sPjoDH0BubKtrKYf9gvQFjsIa6o9HdvaIYnSKiruRWQYIDroK+lpGAPYRSIL/1d8g8iDyphU0Gc+c25H3bMbO6VurNyNRXwUkOWe7hfGxQ2lxGa/8Rk/OF9WvAJySgAMj4BBsdD/0BzJhl6nLhGfSeW4xq2AlElGx27RkzTaU6OBnxjqL+aEpMV4Z3ZW9/tHcsyH788PS/XgjLaPQ9ZURDdcaP5O4tAiv2B611e9ay4V/YHNNz67t8ZpNpvFl6SqOHUMAOZcfPlw+dcWDZVZNhS5GAsfshHMZsmyG1EY/IKDTwO++QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuEoXwQ+KxJ09sDWrmA4YjUnMn4Yoiz03ov3z03XdiQ=;
 b=z3WNNHQAmfK5mLiu6BNwtY63kH3aMHHTb4Rk0wxj+zo9x+NMDCHiWKp3NjAOfbO9HLRveX410Be3Le9tBECfkYB8SG+I61MvQ03Vc8tjUQkkZIOR8bs40yIMliczUWt1h9yBTeadiJUiUCflarZTGnwC+3ItnYYoi9B80RlgMFg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 21:47:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 21:47:10 +0000
Message-ID: <72bd9b02-ba1c-41d5-878c-331f0b93bf28@oracle.com>
Date: Thu, 13 Feb 2025 21:47:10 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: stable@vger.kernel.org
From: Alan Maguire <alan.maguire@oracle.com>
Subject: 6.12.y stable backport request for bpf selftests fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: f459fbd2-fa0d-4101-cac7-08dd4c77f842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1FkNzEza3NGSGhNcmdnOExvZzVPZTlYc2haQzZ5T1Q4b05DZHhYSm1TcGcr?=
 =?utf-8?B?cEJXZmM4cUNFUnM5OHZxNHVxL0pWZWJodGpTVUg1U1pqR3hRVGJrSVVnQWVu?=
 =?utf-8?B?QXg4VHhpSlpySkxEUEpJNDl5b3ZqNzZTMHNWdTJzVllGN0dERWQvMWxXWG9K?=
 =?utf-8?B?ZFY3NWhKVEJkalB0cTdWcDNOaFV4V3Jnd1BXdDc5VUlqR3MyL3ZIdW1vTERB?=
 =?utf-8?B?V0JRMERydC9TRHFYY2dBVXRSeTRwUVIrQVlMTUtqencwK0lVcURiTS9jbkJ0?=
 =?utf-8?B?NWFYazJoem5IRFlVWkx3WW1ad202VW4ydEd3dDFsdStUTlJjMkdaa0FuZTR5?=
 =?utf-8?B?NExmdkVNTXZ4bytxNWJ0T2JIbU5kbWY0TFN1eitzSXpKY25MQnYwQW5hTld5?=
 =?utf-8?B?aERValNISTAxejRPci9lY3UvY01ZbjNpOG1IMHJHNVpVUmJNN25McXN1bEV2?=
 =?utf-8?B?VE10aDVLL0EzUDZxNU5GMmVyNGNFLzNJS2VxakFyQTMxQkhDVVIxOFVrSnNT?=
 =?utf-8?B?c09zaG8xaitaNHdRUEJIOVRoMWZuMzZIZndZTHdvSm9WQU51NEhMcnFoMlRG?=
 =?utf-8?B?R2w3cEpTbHBLa3lnUXR2Rko4TjdjNW5vT1BhcjdNUWVEeGYvdDhmVDM3cmpy?=
 =?utf-8?B?L0c5bTNJMllaeFhGbjBJc1ZzT0Q4MzI1TlFsR1FmNm9FNnpRdHV5ZEdpZENZ?=
 =?utf-8?B?VTZvU1ZXV1UzYktaZytCNThDcWZXbW5Dc1NUcWdsVGFKSG4zVnJ5NUM0clAw?=
 =?utf-8?B?dkZxV2FBdkpNV0QzbFFQcVM0dGhTV3VscUpNbFZtSFlNazJHaW1uZElXL2w0?=
 =?utf-8?B?SWYyb3h2SVVVV25zWXZoMUVFZUZJY29oUmRPL2NzRnVnQWo1b0dWaDJJZEhI?=
 =?utf-8?B?RjZud25wUkc1MHRtWGlaOTAyMWhRaVJJeWFUK3pEaG5meWdMQXJxQjRHUDJa?=
 =?utf-8?B?Q0o2U0VYRVZiTjFuUFI0OGUycTVKSm9jQjBhMkNvR1QzZ0FDUzF6TENBVW5q?=
 =?utf-8?B?R3hMSUJiRy9KRXBwdks2NmU4QWM5cHZFQ3ZpNG9JVXp4c09vZlFUNmd2eG9w?=
 =?utf-8?B?ZjlwUVJ3NkdlWHN4WkxsZHFXN25vRlZLWjRIVWhGV05RdzY3emdnZzltdmta?=
 =?utf-8?B?U3pBaHJiRnJzcnVxKzl4ZWlGWUlUeGF3b24yQnJCcWEveW9FUG9HM2JoelJ1?=
 =?utf-8?B?TURtQWFHRlVTUmQ4VHFQYUVLbDdxQXVmZjFWM2V4OTBTQmlvem5WbnFQbDlx?=
 =?utf-8?B?RkwrWGhWUmZLN0R1K2dXcm0xY0hnOEp3ZGViRXJUb05aM2xZNmt0ekxBcTJt?=
 =?utf-8?B?NEJuN1pYVndiMFFoZERUNjhUdjFYaWFtUDdoY1pMZENxaWROb29GVCszbUJT?=
 =?utf-8?B?UlFmR0pTRkNTM2NxWEsyK3ErT2NPcnZlMUdpbkx4akFEMUNuaTNXV3kvNFl6?=
 =?utf-8?B?MUgzOEc1Z0lRS1QzMS93bEV1bnZ3VkxTSERtU3JGZENEUVFKTUExRzVUNm0z?=
 =?utf-8?B?S0EvQWpEQWU0M3ZTUEphNjNwKzcwQ3R4MW1RQVdlSXR1MVYxc2dDMWpicWFO?=
 =?utf-8?B?T3JYN2JtMlQ3dTVqVis5Zlp1dmNITWZvc2R0Q0NqZ0g0QllMbXA3Vzg1K01t?=
 =?utf-8?B?dEV1dThRV0pZaEFZOE1KTnN3Sm5BMWViQWxNWDIyZzQ4VWNNNGRhUm81L0hE?=
 =?utf-8?B?VTh0ZlJDVGNIOFBlblUwWXNqWnd6UzhwOGUybnE0T2ZNVzZlalUxRU5CQW9S?=
 =?utf-8?B?dnBMWUpEOVI5L1RkRXN1T3FTWlhRQ3RTeU11ODVFNzlhdU4zSDZ0bEtRYWJa?=
 =?utf-8?B?RXc1RU9TOFlkV3hFWHUva3Z3U3FYTkVnbE94UnVZQnc1NFgzY0dkb2VwZlZT?=
 =?utf-8?Q?l8dWRjGe86GrP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhCRE03d0o2aVc3bkdzazRXSTFSd3pPL0xTeGptZ2pESFJUYVI2TG1hVlpI?=
 =?utf-8?B?MThEWUZIU0xNWStDQlN3K1JzK2RGd0Vra3l5YkNhSWVlRzBQQVBRMFRDUFRx?=
 =?utf-8?B?ZkIvZmRCa0R3QWUxR1RRNWdGSFVtZlI0SmVxL09BZkM3STQ2U2YzRDltU2ZQ?=
 =?utf-8?B?U1N2b2FWZTRnQ043ZzdhcjVmZUNDYWoreXFySW4wVzFRTVd1Y2p2UWpaQ1Ew?=
 =?utf-8?B?RlNzVXFydzB5VnpSQUh1bG43NDM4dGVzV2VsRHJNeGY5NXVEdmIwSmRkYUpi?=
 =?utf-8?B?Qk5YQ0pKc2hkR2kvemRMUkloSmxvclNleEhoZkJTN290VyszSWdtUFdkKzZZ?=
 =?utf-8?B?MFc0QjVxVnZycStUQUVHQm5rTVJDeTFmVVc3ZytQQldWbjdLaGtvL2FHYnJL?=
 =?utf-8?B?N1NOWU5nVlpIS1QrWWQvSGpCQ0NGekdNWWE3S1RNd2o4aWpYYUdPV3QrY2dN?=
 =?utf-8?B?YXAxMzd1SldTVHpvVUVWTUxXOW1VbitOTGgvenFKYkYwR1ZTSEQwWlczTlZ4?=
 =?utf-8?B?d1ZhR3FvRk1TaGVCSHBaV052dS93NzVlRTdXUWZDVm00dlp2SWhmTlJWL2Mr?=
 =?utf-8?B?ZkVTOWVLVlUzb0ZRc1hzbVd1QmtDN0JNaUswVkRCZVgvV0dQQjE4TDJpNlVY?=
 =?utf-8?B?RjhaWGtkNnUwdXNCVHpEZWdTU1F2RjdLaFFsNEhXekk3eTNtZ0krWngxTWEv?=
 =?utf-8?B?cGpGeDJCdS9Mb05tS2hHcUdxaWM0T2tPZnJIeXBudW5kVjliOFlZUlA5ZFJC?=
 =?utf-8?B?U3JjYVVuOXBtV2g3cTR0MElPcVNvUVhteXRvRHQ3WllobEtvbndrKzc5WkE1?=
 =?utf-8?B?Q280cUhQTjEvdTNOMWRPbTQ4UDdyai9ITzNxK2pUMW1iRU5Oa3ZaL1NZOU5i?=
 =?utf-8?B?YTVRRHlVUlNpdWQxVE5DalVoU2FlRlYyN2VHVTFTaU1tQlBtN0hUa1VzODUx?=
 =?utf-8?B?Ny9yUk92WlU1WlhtaHNLbDVYZ2hRN00vSjBhek8yYmpOZi9XZWhqYXcrdzRs?=
 =?utf-8?B?bGRlUEhlcHExcFIxTHVITWw2dFdEL1hxSUgzTHBvQnJ6K3BXd3pXT3JTV2pY?=
 =?utf-8?B?WkFQaWpjai8zblIweDVScm5hdm8zSGo5Q0MxcUNZU3Q4N2tEUHhrNjVvZmEw?=
 =?utf-8?B?NVdGVlBpUVA5OHl0ZTd1eldieW9MQy8rNTEwaFZ2VjRhS0tkVXdYeWFycStK?=
 =?utf-8?B?eDY4L1ZPdVZyWUpUdEcyV2xQVHdZUHR2T0VNTXVrU1NzVHlJVC8vK2FOSGJm?=
 =?utf-8?B?dTdwQzMrWkVST2dhL3pxU3kyY0Rsak83L1NsMjVoWnYwdnJXNFFqV2tTaENQ?=
 =?utf-8?B?MXJ0eGJLVVdmbElaQnNlelhhU1lBcGVJcExRNHEzdGYvVG0yTWZobkJiVHQ1?=
 =?utf-8?B?RXMrU01YMFpTcTVveG1zOW84Q25hTVdiOWRDazkwbW9TRFR1bU50RnVoU3ZG?=
 =?utf-8?B?emVNS0k3MGVHY1dabm5iR3VQekNwMGREVGl6cGZ3eFN1QjNzQlJkYS9rWFR5?=
 =?utf-8?B?NWpYeDZZckJXbFo0N0tSUjMvMDJOS2F2U1JXdWZDSklHN1c2LzRGUnhFdGJG?=
 =?utf-8?B?TTRGSWhZWDNIUDU3ckhZQTNGNUxlRW5EQnVOdWJYM3hhdjR0WUk3L3BjWURG?=
 =?utf-8?B?cDYvUHFoSjhFcC9lMHB5ajJ2R2ZCV0dsWVpzWlptb0VPeU9tNytzRTNmMmV0?=
 =?utf-8?B?UlV5N3ZJd28wVmlKUS8vOXFJbUhDTk05L3RZQWlmVzdEdlJFY0VMYUZxaHBP?=
 =?utf-8?B?TEQ4RWtkYXRhaU84U2hSSUVJN0V1cVdneGVWTTJnazVtWjNmUjZKQVdBSm5T?=
 =?utf-8?B?VEhuZkt6Z2FuV0lDcDBtUzE3VHVEVU5XdmY1d2N6b0ZxVDF2V0dOUjRoY1Jr?=
 =?utf-8?B?ZEQzM3JXc2lrcmtLam40UXpVc24zNTNKa3FaZ0MrTmkxaHpBcTh5VmVQTE5I?=
 =?utf-8?B?d1BTV3gxRVZTaFg0bEJZRlN0dHd1WDF4ZmQ3RitydW9mTTl6TlZMdXBTbUov?=
 =?utf-8?B?RDZLTC9weXUwd2tpNzBJWWI1Wnp5QlhLVEREUlRuSlBERTY4dFJDUENXL1RB?=
 =?utf-8?B?QUJvMDRRaVdvVkNlbXFGWndsYzljVVFyTjBYZDdETVZ4SlcvUVBOUVBQdlgr?=
 =?utf-8?B?bXp5cnVKNHJCKzJmL3F4Z0xNWEtibWxORWNRYmkwYWdWbklWTE5iYWRmWks0?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fp9y/sqZvilJDUmYF18cxMopp+yEupFFTnPIqxc2Mc4IW67vMPMEMPUCKbdmyLYUlhOr4efiOkIQGjt1wUquiG88G7s+ImXE7qMOkz43L3P1vZoNi/Cp2xOASShVyiTlYJxLTUbe+Pt6oQoIkvOffad9Hi7H4svLjJcQYVcbmuyNAxmsdqNhBMsrG0g+L/Ahae5TXxrCIYHuNqg+tpMPkfPI4tEgmq66S/xWaRWsfbqFR9ZwhDU9kAlw7+umvt0DO78ObCNO+NqunKKReqaVVW7Qwm4L6Wru8udsuXgTobTStnSB7HtMuJvj7c/x33lRMRlOSU3EGIa6tsfd56C9/cr0JXNqzPxuSjY/mEcHxP5xMg+uGhAbrFyxP5RNI75DnBRix4X5zt8z5WDuZ/TzxK2mC0pU9U+YiXpOxaBiA1djyY6OZJz1FWKSwD0HANHmKLnZ455zMZrTg8d4w+cwhdMz9XT7qyWgkbV3LN3xdeeR46b4zcRk4T5WLwDbfmET81jcAy+S8d2224/JygDZ5bKVqGO8HAxT7QyewepbLKakMVOxYZuO077Hoeh24ut5E7Oumr2ImqWeCjS5PEeFI7yvVaRGPKj+ktbGRrhRb1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f459fbd2-fa0d-4101-cac7-08dd4c77f842
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:47:10.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/rIjWyqfZ4W1KcVCkIdbkMJAM+z3vy8JJbTJVIt2LYjQX9BcQxOxTbNpdKMXvF2iKPAC+aYFGdiqHhXUKSs8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=607 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130153
X-Proofpoint-ORIG-GUID: v3t3muTiF9hf5vxUN3Mt2tb7xqn_Vw8S
X-Proofpoint-GUID: v3t3muTiF9hf5vxUN3Mt2tb7xqn_Vw8S

Please backport

42602e3a06f8e5b9a059344e305c9bee2dcc87c8
bpf: handle implicit declaration of function gettid in bpf_iter.c

and

4b7c05598a644782b8451e415bb56f31e5c9d3ee
selftests/bpf: Fix uprobe consumer test

to 6.12.y to fix BPF selftest-related issues (compilation failure and
test failure respectively). Both apply to linux-6.12.y cleanly.

Thank you!

Alan

