Return-Path: <stable+bounces-154576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7313ADDD2A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BDD3BDDAE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3025BEFB;
	Tue, 17 Jun 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhiIHD2p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApymCF9t"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABC2EFDB5;
	Tue, 17 Jun 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191866; cv=fail; b=m+Qkk1QkwFzt3AIl2XlhxsWkdE3i/CyEkrlndaSSD1djh07PWJRgMU/6tRD50vAe9p+PNMCHvhv8rTwjiwnCw2xqqJqL3H6oOOW0ViP7Lr/n1Gikp9Twy4/SsbXgY8tNjdspuZLmmaFqUJIVawaipOQb7ClV1eIUU54nyE4kX6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191866; c=relaxed/simple;
	bh=nGE8W/WVrltt/QBGvuDyTmP/68YwXWc9s9j025ClSfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvCPQcoh7QON/GLvX+Yb4hS2S8gHqXpDTw10DQ3EI4aZ86+G63tMICW17Izc8YGrvzqN5CSpTIy+xAlUjwJFG8db+DKIn/piy4tUckcQ3TtuQjk07UhW9oApaPTPWXhkCNnUL9SR0OqLZg8k/o4DTpXSNiBqugmMXk+Tb0zjNek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhiIHD2p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApymCF9t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HHtlj0001519;
	Tue, 17 Jun 2025 20:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c3D4zJzuyEx1OmlkIicISjilkToOx07LXPM2H3OTHkA=; b=
	fhiIHD2pE2TkVyn8/cmJ3xuZbSNOMUfBeH/lEiN6ZWqBRhQt9YSPIxlD+g1HTh2z
	ygVYexYro/v9El6ewke0bEBdUTcAayk1oC4GYMAcJlVC6OeCdZLl8z8waxhNgIjD
	woezEvqZpGlm92svMjfbRLzSBx5w45NwKSC9qJO//D0AsPcTFLVFieRZeF0nF6ZN
	vwS05tTf/uute+uS5bIa0+yoPCOBIq6AHci5mS/wohGTCDI8wX31AZtSOBzaxwyc
	bh6kFV197Boe12Izhgng8k6PTERN7d/Epb7xKzMM9FBj0ezBTjftHy2h2vYwgAUp
	Mphe/m7CwU82od7Xnm+vjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914epb7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 20:24:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HJ0Kkb036427;
	Tue, 17 Jun 2025 20:24:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhg8ewn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 20:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2tkMyL6WcUlGXfzyFnxG+qNtBg42u0dDsuGV6cDE/IEh+iHuPF2QcIF2uog45dd5j+COoYwVTM3S6vVYrtYJ0Y/1554aTmUGK6EYHHYoqypH/ILIPQbI4elKITsx+b/v2IaAcKgFP4MDzbZQTd/gTCwevKeKWe/6ld1mVZ64hA6yKDCyD9IktL96+wgZ/2Q8r2apVPkPSuRgHDLemKorDQkTjr+qv3eliJtQ3QbtAmLGvCMCgsM3Mj+p3SjcioFElCfe8PW2a77UZql6ezxrwr1mEVS2eS75V2nZRYNJKcEkm9KdoSkcG95BOU4bW8l6iNmMGRLBugjemIDR5VpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3D4zJzuyEx1OmlkIicISjilkToOx07LXPM2H3OTHkA=;
 b=rr0NiAGTLLDxyiPGuM5zFc70uYnl57k+Muj/wRR9AnUyGkfYeVpgxk3Ujs1v9wxaFGPvRZxrCLkycdEtlh2M6CO04Tud5MJBRdB23vFCzagDS/Vz+h4F2OjI3tZ5dseUYRrS12u2ifG49AxooMR/3K32WJw2G1n0bkAM7qriOVHasB1g58Ghq8gmcBFESAkWc1+JXjXmWQ80g0SrasTWN+hb4BXvLCZNlw+CT6dBWvVu0nfyokiWjX6x8htkVTuQuFRHz+l/YOYKoXZFjk8WpJnvX4pa4QVH0XGuOOaesbBrIvrZ+kBObPv4k4EuXR5I5Ks2cB1VgKVCeD8WEGfLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3D4zJzuyEx1OmlkIicISjilkToOx07LXPM2H3OTHkA=;
 b=ApymCF9t5ycXApFVQEDDAwAzNTcvdlOU9NzUqMFDDkUudV2AGDCDqOrGVDR6RlbcUyWphwQexXhgi5imNw7dgwZODp9LXL8wwD4kOTdW45OkVdJZAzjuBPIhMnYGAb9CV7QI1KZALXh/fcMCHQgLq2EAtnekmplWnvX4kXXKDAs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 20:24:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 20:24:14 +0000
Message-ID: <5633c993-2c18-45cb-8826-f3ed52dc7ad9@oracle.com>
Date: Tue, 17 Jun 2025 16:24:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Request for backport of 358de8b4f201 to LTS kernels
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <612fbc1f-ab02-4048-b210-425c93bbbc53@oracle.com>
 <2025061709-remedy-unfreeze-0a29@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025061709-remedy-unfreeze-0a29@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:610:119::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b3bcf7-8850-4290-4269-08ddaddcecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzlGbkxWZUpBZnFJeUhsbUY0RU1lNGw5S29tVDJhUGF4NVVyRnZjbSszdWQ1?=
 =?utf-8?B?UjNvcGttSHZHY0M3bkIwdWEra0VvU3l1cktxU0pzeGVKMm5DYmx2aUJYUFpF?=
 =?utf-8?B?bnZCa08yMnY4K21VRjZwRmkrR2xnQmcreVkrVGRhQ291THZ3cmNkc1MxSDBW?=
 =?utf-8?B?M210MThYMm0wT09WdWRzejI3ZnU4b21JT0U4ODA1Q1hlTGZkM3E4OXRtRGtH?=
 =?utf-8?B?VXZJM2JoT3NrenNGODlkQ2FQSEpyeXQ1c21MR0cwUjd3YzY4cFlENU9ER2Ji?=
 =?utf-8?B?VzU2bko0Z1hOS2lzdTd2ZnBsTjVtMytqL29xVHZxT2dlZlZkRjdsNXl1dVZ6?=
 =?utf-8?B?MnVKTWFnSjVkcXc5Sm9vT0ViaWd1UVhzMHppYkFjNFp5KzZQYU1qYmFNeTR1?=
 =?utf-8?B?VG84R09wZ3R5dmZMVjRWTExnTHdCaGI3dWhFb3FiN0duczRMMmNjUDVIU242?=
 =?utf-8?B?QUVWbzk5dXViWTk4aFgvcFBNWW41OGNCM3F3MElPWEk2citTSkxhbVVIZVZi?=
 =?utf-8?B?Tjhpb0pabHYxbXFCSlZXRnNyN1Z1QlMwcm1sUUw0aWlBR1pYVGtBeDNMb25L?=
 =?utf-8?B?eWNGUTcxbmRmQ1dBV2lRNkhtdmxqbnJrcStQNWJVdVlpa0xhSHdsOW1oNDVT?=
 =?utf-8?B?MFFoWnZ2ZmJuZ0U5UklCWGpIODAwQjJDd3F4M29qQVV0TFRLS0t5cFUxZlZv?=
 =?utf-8?B?QXBNMXVKL1Iwbit5aDFSNjRrR1dPaFhpZU1CREpoSVUrSUFvN3d3am05Zjk3?=
 =?utf-8?B?Vy9XRnJRVmZDZWd5U2VSTWNlSGVIVmEvc3FmaElCd1VydFd6VUFzVG9pZU1S?=
 =?utf-8?B?c1YzVEx2UDExbkU1aXdmcTNPZDNJNDJ2cm1MMnBWWmFpYzM1cGlkZ3UvVExJ?=
 =?utf-8?B?QkRsSVFjTjNpeUZYdTg1VW5xZWhPdU9KQjZ3dDJ4NUFoZUZIOTRjWnlYeitS?=
 =?utf-8?B?endaQ0hkamxMVXhLR2M4cnlGeGh2MFZxcW1BbnhZOW5aR1ZJeWlaZ3hzS3dl?=
 =?utf-8?B?UkVkK1I3Sk9QbVVwTFQ5UzBHZjZMRG5SVFBSTVVmZUlXWUV1dE5MY3VxU0Vq?=
 =?utf-8?B?dmRoRVdzWUhlVnJFN3JJSWl2L0JlSDhkd3RnODV3dUxsNWxkc2xwekxPSEUw?=
 =?utf-8?B?R1l0QldxMnZKQWdHN3g4V3YwaGNGck5ZSXlJcXl3RkYwRWtXREtnZElSekI2?=
 =?utf-8?B?RzZvN0hwVzJSbTRoM0xXZnhOSEROUXg5SDRhNEMrblY5Zm13dUx2QmpmOWFm?=
 =?utf-8?B?dk5NaW80WHR2Rk5hL2hqSXZKclg3eVN2UU8wZTVEa2gxcmcyamtEMmlWWS9o?=
 =?utf-8?B?WENFYm5XNisvc005NEoyZko1STcrMDE5c3c5SHBjZmh3eitZbVAvcFlKcGdI?=
 =?utf-8?B?VGFWWnJJdmwzU2dKTU0rTmxjRVNIdWIva3pMeC9saVF4eFhSZkRsNGMyNEJx?=
 =?utf-8?B?Q1lIR1lXL0VjTE9ySnVCcUdWTHRPcUVJNmdvU3VEc2hyQXd5QWpEQnVSL3VD?=
 =?utf-8?B?V3U2ak10c0xuTWVZZjBsUWJLYjlZOENwRDNWVGJUdTBFWXlqbHYrNW8zVW1m?=
 =?utf-8?B?ZlRWNTZtNlRVdUxEK2ZxSThWUzB1SUc1ZWFlZDNUMStBL0I1SS9tczRsSHR2?=
 =?utf-8?B?QmxEQ01VdE50QjRVZURJQlN3OFRQUUg5RWRKRmNRTVRrQWs3V0g3QmJqRWVn?=
 =?utf-8?B?UmI0Z25NcHpiUjFmZjJDOEVSS1dwRk5JTDR5TGVtRC9uSU5yV1R1RGx5Mm1W?=
 =?utf-8?B?L3kwcFNQazJpVjJFSjZmK2RTeW1HVEhjZk1haE9Id3lXOUowR2V1RCtDODUz?=
 =?utf-8?B?bWdHWUdTYnZOcjA4bjFONVhoSU80SFYwQkdnSUFOb1ZlSDg0QS9qVjhGMmRy?=
 =?utf-8?B?OWx5Z3phTloveEczMDJGS01KeXh4V3VpNC9nK3ZIM3FrMDQySFo3RUg5VnRs?=
 =?utf-8?Q?KTPJVC4AsZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STZCSFlVUHR4anpsWU5EWC9mN04xMEE4aVZUMktpL0lNdmxBUkt1bFM0V0xs?=
 =?utf-8?B?Rnh5ZmdRUlJIanAweTYyd2tzYnVuc01tT2lWdmtaS3EycTlLTEw5WFF0aE9L?=
 =?utf-8?B?OHQ5bWc4a2VnTU9vb0puSEdvU1hPK3dTVUVkS3dyZTU3OStVejFXYk5JOUMr?=
 =?utf-8?B?VVYyVGt1VCs2NEhsc0xydmdzMzBDNjJoQUpZZVNiRkRYOExZOTFINnU2V3RV?=
 =?utf-8?B?eDcwa0xpTFdKM3JZY2FZMUU4OThsaW9ZbEl6N0Z6dnlvT2FDM21aOXRvcFZQ?=
 =?utf-8?B?cWJIRk9yeWsrRDIyYjQ0empZM0FQekROYWZTakVxS1RESmdJNXMzWDJDRnhG?=
 =?utf-8?B?bTZVWmhOTVB4bVdGZmlNUGdXUTNBQTZIUTIzRkVraGVnOEszRWR3eVFNeDRY?=
 =?utf-8?B?MTkvcHduVXFDYXpQbnFFUlhhdkVCb2YrdFFFQzVCb2dHMzRLVHkrV2lKa3VN?=
 =?utf-8?B?alowRVdVSTgzcldITzdmamZQR1M1RE56Z3duYjFzL2pQRTR2SE5aY2l3eXVm?=
 =?utf-8?B?ZDF4SDhONTdiTjV5SHNzTllRMDY1YXl4SEg2V1NmOWFiWXdEYkV4ZytYRHdS?=
 =?utf-8?B?cTNmWW1lZFhQVi8wenBrVlZWNGlYdU1qQk5zeXBic29XTi9GeHBZdnVVUHBN?=
 =?utf-8?B?NTlHbEN5Y3hMeWxSeTZVakd3WmRZZGhwMWdraDQ3R0ZMcEZQR3RnSHJEakNh?=
 =?utf-8?B?SjZSRFNUUlZMNUlqeW10alpJSVhBNjAxdUhRYXRTV1RKbU9wYzN1bVc3UUxy?=
 =?utf-8?B?bFJOOHBCVDZlWlNZRjVJMlJvU2dGQzNSN2JRQklzbDdJSkowNlFNVzFIKzFQ?=
 =?utf-8?B?UU9BU05sZXlzazBNSnlFaWdKM1JmMXN2Z1NaRGpsTWpQeUxnNFRQVStxZ3px?=
 =?utf-8?B?SEFtU3R1ODBNcW9BdGpkQm8xLzI5SjZvR0pYeFFrN3lLYk55VXJVWHM4UFhD?=
 =?utf-8?B?Q2o3OVg1Ykx6ejR0eldoVWdCSEtIWkhOaTZ4bHpJM0lPSWZKNGJPTDZVMEhR?=
 =?utf-8?B?bTNUdUswVU1hQVVFTnFTZGtJeDMvSURwbCsxOEMwYmQ1dnFEalN6MUFoeVZz?=
 =?utf-8?B?Ym4zSHh2c09QaDN4Ry92Y1VKaTRMK0lXeWNxamNLbWlQejhGamt3OWsvYUN0?=
 =?utf-8?B?OTJrZk9YZ3FpYnp4aW9lTVV0SHQyWEVkWTlDdENEbkNwaG1sa01FVk14UDBF?=
 =?utf-8?B?d25sdUlaeXFRZEMvSkZuSGR4SWNZaDhyZkJIZUpaa01GK2ZOYVRzWGRYWWV1?=
 =?utf-8?B?QXFYYWF3ck13NjFQdzBIRDJucVYzU0RnUWJTZXVBOHlQRFd6U2NYK2xoamVC?=
 =?utf-8?B?VXFQamJHTThRMmhuOXk3VFNOUElXM3BCVXovMUlHTHA4bkpjYU0xRTM1QSto?=
 =?utf-8?B?RTlPMWhScXNGNkFoRGJOa0R4a2RkbjJ3T3VZQUN2ck5qbWVicm5ZR2dMYUhM?=
 =?utf-8?B?amkyRlZEUnNQNGxnY0Fpek1Sem5sOWxiN0RCREdhRnMrNHBHcGJtL3NRMVZB?=
 =?utf-8?B?aXNvVk5VV3FnQ1ppa1VRSFRYQVBiZktVRFc3Zjd1Rnhob0hVdG05dW9WYkg0?=
 =?utf-8?B?RnlwWEVYUHpaM2ZDNWZFUWJ1OFNGVnNpK0hjUG1QcGN5ck52ME0xL05FcFM2?=
 =?utf-8?B?eWZnVVVwRWxDTXZ2cXgrVjdGbitNeUpmd3MxTVQ2Sm1Rb294UFlhSFRDSEZq?=
 =?utf-8?B?RGdtejJUR3d3RjRsQllnbGpWaVY2RTNvY0hwUGVJRVdUOGU1K2szeGc0TCtH?=
 =?utf-8?B?ZkhqbXIxV3FqVlhCMFBMOXNtTjh2QkZSWkgyQkdVb045T0lKUmVDZncvOTVB?=
 =?utf-8?B?eGRqTUVzRkFzOUNTNDZsaDUxNXFOaVc2YmFyNURsOXJWcFhGZkpXQ1ZSbjds?=
 =?utf-8?B?WTAyY3lyKzFaSUJ6cENvVnRzSGo3cWIwMjBoT1NTTEh5RlNDdmVySFF4OThB?=
 =?utf-8?B?MEREOXc4dW9lNWVmb2x0cDZ5OFUrSW0xSi94QllVaWxiRzFJUUVBV25QZFg5?=
 =?utf-8?B?b3dhQnZBWEE2QmYvSlBCZCtpWW9vOE53UzRTRG50M1pXZ3VLMTNMU0hyN1dS?=
 =?utf-8?B?UGZ4c1ZMcG5oU2xtQUpNc2lVem12cHlGdDBVRkJ6OXJhTGxhd0crTFZSZXpx?=
 =?utf-8?B?NGxKWlNRTCtiUXp2MUkrWE9OZCtmQVRBaEFKU0NwbDdzYVA2ZzFGTi9FMWJH?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nPQ16Bo+6xpm/07frIRcXhVbGdNRh+nB0Vk2vGTuCH+m0ZVgX53CUA1AQWZDzM2BuhbvwU4d4RfxXgx6gXPgVKW4B7DSQMzZdOMCbnN+XqkFLNureSJm+19RQ5IrSqQOwtmRL936FBtci4bCjLyuNmTL2RSrQ4mDNfCm6IlP9hIOy5DSg4aPqQ6S3AgAq4WovYWHFxHyhhBi5ULgTJODimRDKwXqcndqyEwo6Azjz16WtWn1kLH6o7+lJodXIvUOUCobOI530BN4KDdKvjH+HcD4AG62/Ajz8tJZAgiaBOfnhG7KExABsU3UxaCDPmXmT8zR6LU38FuchVN8ob+d1c0M7mODRPCchKu9Ie8SEuodYSJRukwvCyhuw5lOIgpXGcgEFY6HMjqvh3sY54E1YTnPupj7nsovZdYMD0jyS1oZMvBog5b12EgwfvhtBu/sX4JG5tsJl1WK5LQY020cAHycFdYzzXtJZq/WKxro34fRlV0KMUNcuCc2r/KzX4A7Tj2TeJw4YTsbzMAsp7T/bFiYhvHkhMWbCX4UqbQHUSCaPVC71bL2UhbM6aPILuZd3zjw9E5gkgeLt7S25ca8XyfIEEyy9C2q3duw1u4Jv38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b3bcf7-8850-4290-4269-08ddaddcecfb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 20:24:14.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb86uc4A0RY+S+eQXX7JCravbIc/a1tkpRKB/k/Y5EEIKN+WJYuBoNzUbspjxOnr6Oo1CnP9/GhjJnEUNXC1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE2NCBTYWx0ZWRfX87+++9V87Pkt X5xBCT0QL0TF5oXxlauWcta0GCOmj0RPA0LGhNtNTGDlzCwPBe2ZmrrHz2DYYzLOx3qEgevs0gX lsChTkFDYsFW4aAiNY9rgfPMkRX7nf9b55b8bT+H5fs2f78EWtgoi0xBcTEAw3LTVvmsOpVr4r+
 SRl+kNxEqGIj83l/QOPprLjf26Vu7jIvM5zlZA/0gEcKdeRZ0jMGjHNmX35nZs6I1o/31PEU2SW A7VtrGRwXB3TseLLKACtgzdx8TbBH1yiiPLWNx5bPjANXU5WNYpuxo1KpoQuQs9rlZiDiizRNh3 +NTXnaFy2auuWawPhbps5W5PK0SVLreuBMttZXOEtxcmt/ISs8YWRYvt8E1uRegGSr6bFADEhCX
 EJC9QHyeHcCRhej0X1clmWJUI6fcFuQJ6aU6bFpo3h9piPSyp+6Nmg6ZbHySi0jKyrxHk5/3
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=6851cef1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=RNPlAYa_zYLoUUo3PTkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: Sephw2Ybt0tPXLLCru-4VN6g40ICyD3X
X-Proofpoint-ORIG-GUID: Sephw2Ybt0tPXLLCru-4VN6g40ICyD3X

On 6/17/25 9:51 AM, Greg KH wrote:
> On Mon, Jun 09, 2025 at 04:30:19PM -0400, Chuck Lever wrote:
>> Hi Greg & Sasha !
>>
>> I ran into some trouble in my nightly CI systems that test v6.6.y and
>> v6.1.y. Using "make binrpm-pkg" followed by "rpm -iv ..." results in the
>> test systems being unbootable because the vmlinuz file is never copied
>> to /boot. The test systems are imaged with Fedora 39.
>>
>> I found a related Fedora bug:
>>
>>   https://bugzilla.redhat.com/show_bug.cgi?id=2239008
>>
>> It appears there is a missing fix in LTS kernels. I bisected the kernel
>> fix to:
>>
>>   358de8b4f201 ("kbuild: rpm-pkg: simplify installkernel %post")
>>
>> which includes a "Cc: stable" tag but does not appear in
>> origin/linux-6.6.y, origin/linux-6.1.y, or origin/5.15.y (I did not look
>> further back than that).
>>
>> Would it be appropriate to apply 358de8b4f201 to LTS kernels?
> 
> Perhaps, if someone actually backported it to apply there, did you try
> it?  :)
> 
> At the time, this was reported:
> 	https://lore.kernel.org/all/2024021932-lavish-expel-58e5@gregkh/
> 	https://lore.kernel.org/r/2024021934-spree-discard-c389@gregkh
> 	https://lore.kernel.org/r/2024021930-prozac-outfield-8653@gregkh
> but no one did anything about it.

I've posted a clean and tested backport to v6.6 LTS.

However, the number of patches that need to be applied to v6.1 is much
larger than the provided possible dependency list. Hence my original
question "Would it be appropriate ..." I think therefore that the answer
is "It would not be appropriate to apply 358de8b4f201 to LTS kernels
prior to origin/linux-6.6.y".

And perhaps the solution for me is to ensure my v6.1.y test runners use
Fedora 37 instead of Fedora 39.


-- 
Chuck Lever

