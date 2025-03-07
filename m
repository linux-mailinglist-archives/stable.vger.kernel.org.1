Return-Path: <stable+bounces-121394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C54A56A64
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C741777BF
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F6A218E91;
	Fri,  7 Mar 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3uTacqB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uTDbNuwg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AA18DF65;
	Fri,  7 Mar 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357849; cv=fail; b=O2wP4qbtpG3XdobQcCZPpP2BhUXzXLtp/aLBz2fiolDcbxy6CzizxLkqIVJ3YhmVbyzQe80+yUHXAoc+jkBCtolKZfZ4UhMU5+2uQNAUseaEof1E2Jo3VpzP/3aJLtkapOlK36hb7faRnOLSKQKB6U2chcdbZvPj5YaQK0ILprY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357849; c=relaxed/simple;
	bh=+PONZq+zCfKKOIuA0q2mp60hjV0xs9boYBYNSkW4EX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IH9C8+kTi3CvmeyG6eIv0bAZfn/LnAu5RIbGE5wlavB8p9Gi+VU2U36eo566QBiycAdyLSi8JoXUb44h01M1zTUUYP+nWMEk+V0HlV6l/FhRv/Pw0ziCPmvIAedwX02bjx0sBYdD46bwdb5bgd8E+PzSlsAZEXU/FAYYHtfLX9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a3uTacqB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uTDbNuwg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EOGe1032764;
	Fri, 7 Mar 2025 14:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fr/f8NUr6bqmrKems5JueKWXDLnTuLinSTs4VJVhyZ8=; b=
	a3uTacqBMf1PSKk/vODl2Om39x9WymtA2DQzAx+QRlzaMZVVv1Cc0NqmROwolvWT
	dH78qDC3tzjQVtNbKANHbhfvE6wEIhJP5bEO7OAI8oFd6Xu2OQHD2ZFp1lheiyKY
	YRkQsqu49cf3Q/q+6MUb6VxjIHc5PNBCGhPFO/5hG7TtzHaNPcDWzjo3lQ4xyO90
	xaecmakifzvJ/QqDQEoqD0BGCL3RJ0ijm1VIQGlH8a1JHjCn0aELXJgxO8A9Pxm1
	xgLEJwLbQPK3h+yW9+B2QZQRNZjC/UwQlio0Ulurd4hbI6bw6MDTCxH0vTiqoeX0
	AR9naXnfhonfUWIxVNmm9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86v9dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 14:30:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527Cwdrp040412;
	Fri, 7 Mar 2025 14:30:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpkv9dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTrwbNd7q4BT1e3EhVHCtoUTVEISCek9Xvsc6VWnshYdrB2d2LFkIfIWZLXx3fTnNRPb1lheZTCVEmV58/KnuP4mBplVYpz69Hpdl0gHSh3t9nQ/NnpM4SgOZnaSlBXpj/t8nH/69OLpiIOb5Qw7/CmxC3GJjzZ2jkiOb8OsGMXLErCHJWzRKhYUB0Akl9Z46YvilhohKdlyBntYLqryTyYNhFvieJ0OPFXHBfMBJc+lYRf+U/kXQ2bgIvav7BGlmfN3llFVtboeE6qGfT0FBLoTerqkgpFv0gyMSpswR9qMwQ2FoRyy79Cg2uPvUhxHPrsy+eETKeebVy2Yrue+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr/f8NUr6bqmrKems5JueKWXDLnTuLinSTs4VJVhyZ8=;
 b=tDlohkZE4/kKFL4yiHdi00ZGLHQOrucdGZMFNNAOylzvmaVZts3wIBiVBXotkBP6TE2W8VU3phhjV4m9R+dS1eJjOr/L+qi3sNFwVq8dTAxE/oUXEOE+YHta4iqpSXtzMjnBm+aKTY92+fo6w4mZrR/AZqsz0iJNQaohDzOEXDWNRs1lCOAC4ZZ4T0rLNQF8IoNxCMsRqGDUnLVVOJLq8WqpHL4Nx7izk9qKYQVfHPydiUpVm6gq9BRe54DOX1jpx5KLGYVpMRaXEbQZmMptNq97L5Ui+lQnbJ0D5b0bwSkuSSNW1BG00Wo7f7T4VCpsUFzKlRvXPEDtlaPgMDYYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr/f8NUr6bqmrKems5JueKWXDLnTuLinSTs4VJVhyZ8=;
 b=uTDbNuwgRw3dvZSRDpgswnS39wbdOrBt6XG1yd2MXlmS0jsVKnlNrIj4SoKvT4GkbCPPO+qnKpRA0IcJg3zPR83phRzqqVugx0xwzWT4LaoP/+ZPPjpo3VklPkZ4xIP2xtF3ZsbjgUkhgRH2zhzbfj3+7ZfSpwOKIjWIomDm858=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6263.namprd10.prod.outlook.com (2603:10b6:930:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 14:30:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:30:33 +0000
Message-ID: <54ccf1f1-52d9-4444-ad23-fb74a8d64cf1@oracle.com>
Date: Fri, 7 Mar 2025 09:30:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
 <2025020722-joyfully-viewless-4b03@gregkh>
 <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
 <b3ce27d9-4b94-4e75-92fe-a42d6c97834e@oracle.com>
 <2025030703-translate-sterling-19d7@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025030703-translate-sterling-19d7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:610:74::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd3e6a8-b5b4-4cce-4229-08dd5d849e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlAwYS9UbnM1UzlBRzR3dXBsa3RwQ2dJdWY1anJjVUdFUDRKVHkyQmpkMUxI?=
 =?utf-8?B?VWZubFVGRVJWL0ducWtoMzNWemxqdTB3UmV6Zm56MmFPZkV1Mm90TGN3SmJE?=
 =?utf-8?B?V3MrbnY2aE9XWUt5MElNYnFueWVqR3hWSXJubVJLekp3OWVuQWE2bXYrSVB3?=
 =?utf-8?B?M09WbnEwQjNLS3lyRFZqeFhOczVFOW1EdStkRVJtMVJnWE9tQ29DTjFYOEhR?=
 =?utf-8?B?djc3Zk1obHJQQ2pTOEEvSWtrRnMvNEpITXo3OXRoVDZnM3Y3cXlLblVBcVcr?=
 =?utf-8?B?STJlQkxSWVI1dU5jNHFoVXRTQ0VqVGtYNTI3VWsycGFPcHIwZHFDZ1dTYkV0?=
 =?utf-8?B?TjVtTWNPSXRhL1pnT3ZiU0d6cjY5ZEFWQ0c3dTFIRGhENVlSN3ZqaDM5ZHY2?=
 =?utf-8?B?LzdMN1o1RlRyQ0M4ZXJvVmtmelRoOGgyTEpZeHpTU3c1Q0VOczlhQm85R0s3?=
 =?utf-8?B?R09zZDdMQUZqcml3cmNzRkxyWU1jS3kxcngxc1R0S1lOU0hpK0o2WlZqUCtt?=
 =?utf-8?B?dmtxSVVRSnNZRDdaNXBrenVOWS9yYkNKMEpvM1BwNC9xUzBhY2NnMmxYMzN3?=
 =?utf-8?B?dURoSTFXZVJaQUxuTUtkZDg2VmxKWUV2SFVQbEdXN1U4T2IrL2RlZ3VTVC9x?=
 =?utf-8?B?VjFLMk8zWDNwNmp2dDFTV094ZWtlcUY0SVlMMFRjTDdXanlNaDlwaGRjWWh6?=
 =?utf-8?B?NzM0MlhkVmV2RWM2UXF3VlJzaDUvSlJKU1ZBYkZqaE1BK2pXdEhEOVpXR0pU?=
 =?utf-8?B?MHdDTmV6NVU2Q1dZd2puZXlGU1F3ck80WGthM0Yzcy95dkQralRoSFA1TUJ0?=
 =?utf-8?B?UjVoNVRtL0V5M2JSZUgydGxPdzM3MThDaEJ5bkQwcUVLbjhKYlNrbEtiTElp?=
 =?utf-8?B?V3RId24zWVBPL1l0NDFta2ZWNHlraWQ4YjdoOWZMWmQ0STNZVG5GUXVPODZM?=
 =?utf-8?B?dHdXb2pjT05qdTl1THRMWHFlaXpPZWx0aERBaUJ2QUpGdkYxTmtQMmxpMDBp?=
 =?utf-8?B?YU0xV0Y4enIvQjZzZmYvdjkrWWNoWmNiME1KdTRNVmxqZzc1VDQvUEM0QytD?=
 =?utf-8?B?djlXTU5pdDZzUmt5OVpTUDFCWTRtNWVqSTFJc2VtblE5NU1OTGJoUHlyY2JD?=
 =?utf-8?B?TkF4R2w1U2llRkVweVhUMUk5SDJCZWRXTWFqaXRTVGV0VHFqb0hYNEFsb3U2?=
 =?utf-8?B?clpUbWxSQlFOUytDSEF6SXF1R1Uwb0pFZDVMLzF1YTdZdHhoZnJ1Ukt6THhq?=
 =?utf-8?B?OWVlSlIzL3U5aEFES0JWZ3hIaTYzcDgxTWdPOUtrL2VtejV5NHd0N0VQOW1D?=
 =?utf-8?B?eTkxR3Y1SlBBQVllU0RneldHaSsxRGJ4bDIwMWpPUzQzdUN1d3RwNWl1bFhO?=
 =?utf-8?B?bDB6Qkd4cjVvRHJOS3R4NnBQWUF4STFWUVprTlY3b3VEdE1Cd1M5RlU1N0cv?=
 =?utf-8?B?bXd3RUs3UWwwSFh6Y0kzVEpwL2Z0bFBQRzhkYzZjcWw1Q3hKZmRjZENqVE9z?=
 =?utf-8?B?ekwrZ2xXUjFueFd2MXNOb3QvaU8yY3BGUFM5eUlpc3Q3SzFXRWo2c05Cdk1S?=
 =?utf-8?B?ZDY2R3Q0V0ZGNitDM2ptT1FDbUN4NGFlS3FVaTY4NlVvMlFXZDRmZzAwdzJx?=
 =?utf-8?B?RWJhbW9TakpmelFEd25HVSthMDJWb1FEc2U2TW5CT0RuNnZCYTJLa1ZOa2kx?=
 =?utf-8?B?ODZhNWdxYmlyelZZbnhzbklGbThpQ1JHZWpzcTF5ZHhvTU1iNUtSOFFxMVB3?=
 =?utf-8?B?Ky8xa25WUFRQbk5UMzVlTndWbFhFSUJPdFlKV3h3WTBCbmk1UEN0cVk2L3dx?=
 =?utf-8?B?ZG5Kd2dHNHZPVHFjWVM3Ukt1aWFHbTg1TVBqVW1naW91VVVZR0RQcTZrak1Y?=
 =?utf-8?Q?S4/RY3lNhZfP5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDM4d045UFk3TTBVU3JQM0VoSzhhck5aZ3dDZzlQeDlSQXRWblFhN3lpVVJY?=
 =?utf-8?B?c2ZuS2g0MlpmZXE1bDhvbXhCZGNMSzcvakxNYTRCNlF4a3J1VjVFMmJSVEI1?=
 =?utf-8?B?K092cTFQeUN0Uk9abWRHL2JwcDVSNWkrbU1aOUNxYU1HaE1KWlJaZ3N6ZU0r?=
 =?utf-8?B?cEVVajlGUWx3QlU0cmRNUElGcjZBa0pGNkZKKzByRWNvd2dTWkJCemY0SFZR?=
 =?utf-8?B?b0Jzblc5cGFRTUFrSkFULzJjNTROQ3ZlWHhlRDJxY3JDMGFrN2xTUGNReEdw?=
 =?utf-8?B?aTN4MjllUEV5N205T2tDTEtLSks5aVBZaGt0a2h0S05OL2VPRWtwQ2puNjN0?=
 =?utf-8?B?Q1NLU3drWUlMY3VuenloY0xmN0dXNWpMSk05VnBDU3R1WHdQbXV3bnhSYkJJ?=
 =?utf-8?B?UHdyTTFyWTgxcHlkZ0tNM1l6U2xxSzBodnVMSXZPMUpnM0E1YlNPcXJLLzRV?=
 =?utf-8?B?azZhNHFzUlRGMHNmMlQ1aWhYUDRaM3oxL2R6Q0xZVGRWS2ZyeHd5Z3o0SXdW?=
 =?utf-8?B?Z1RtbGY0dGJ6aVZnQzFaTllGZFVtRnpWUVd6blNvVGJ0eWJncWc4eTFvSUFv?=
 =?utf-8?B?UGRrUU11SmhNZTM4OVJXd2VLUVZzRGxvTk1ta0Y1MjNtSlBnVGtZbHdPZ29Z?=
 =?utf-8?B?VHBTZ1FJaTZSVW1rbzNIRzFGUDFNL21BTDlDRjFuSGJkM0FMVnZDMnVLSUxx?=
 =?utf-8?B?NGNRRjdJNGxid3RaODh3NkVPL0ptR3NoWjJqUk9IY1ZKeFdJK1FYVlhsRkVv?=
 =?utf-8?B?WEMvTEpZVnhUQUN3bVBQWnJCSlcyeWlyRmRsRjZpWlV1ODlWTlZsSlN6czFq?=
 =?utf-8?B?UGN5V0V1Ym5GSWR1Z1lLYzFvZmhMVERSQXNya2d1bEljVEtVTG16QnM4T05X?=
 =?utf-8?B?SlBIMUpGcmErZWx4VWV3NFVlQ1B0elljOUM2OWtiK2RlWjFGYVF3MDFyL3hp?=
 =?utf-8?B?ZC9oTVlZR0tFSzl5Sk1rdWI4QUY3NlpBOWNkRzdsZ0h4YVFZTHV6cHZHNTgr?=
 =?utf-8?B?NDZubHpUaUFWaUY3QzJBbHhtKzcvT3NqL0lIU2VYUnpxVlRubG8wbjl5aFlP?=
 =?utf-8?B?bm5TSjhya25qbXRGaU5JQ0NqY0M3N21velNTUm4vajlNWUJZTzdXdWVWUVlH?=
 =?utf-8?B?ZHBtV3ZHUVhacVhwUnhaS3JYZkhoUjZ5RXJYSkUrNkIzRzF3ZnhyOFZyeTUx?=
 =?utf-8?B?VCtIQzBuYWFqK3cyNFUvSys5dDMycWw1T0tqNC9XalBxS2tNNTA1TkVUWGZD?=
 =?utf-8?B?ci9IeXYwSmxOWlNEUFpsbWNlNGlpYmRnYjd2dDNHS1JqSXAzMEljaTR6TjlY?=
 =?utf-8?B?L1ZQdFlSMkdVOEFKNVQrMkUwTVpBSDVDcmJTYmJZaFErMlNiTWlnMW1qUHp5?=
 =?utf-8?B?ZGJvMHJZMUdYNE9kc1p0K2s3b3pJVGNqMEZwOWo5R2VIcDk1QnBXWmluSTZR?=
 =?utf-8?B?VDVvKzVRbGhEVXdFNGRncWV6SHJhUHBxS0N1N0ZGak9xS3Iyb0dtcnlGNi95?=
 =?utf-8?B?eXUxYlhtcFE4M3l6ek45ZHVJcVphT05pQmxjcUN3eUZXYlhQdG1CeTdJdGs5?=
 =?utf-8?B?WmFJazUzY2RacGp3aXpjcFBkeEVsVnRiQXVnU2xlbHB2OEFSUjRUcTNFRW1D?=
 =?utf-8?B?NHBVVHdiVkJGckpucy9wRk9HZ3dwbGdKSHVoRjBJQzYrQmExQ3JKTTFaSUI1?=
 =?utf-8?B?VFllRkh1TlRRQWVPNStkUmxEcVBzRXYrSzQ1ZnliWVdrODllK0ZrRWszTTJx?=
 =?utf-8?B?VzdGT0l5MWJvdy9OR1k3b3VXU0pqdTI5eE9WdnQ5WjErcll2WS8xazVqdkFP?=
 =?utf-8?B?Rk85bkRTOUxNblFBS0RnZ1RPL3RsQ3dXOU5Qc0tSRGFSK2toOUV2dS8zbXVo?=
 =?utf-8?B?WGQ5NzdCTWRJZTY3SFBPU3M1OGhia2FSaENIL3UycCszYXQ0QXFnSzJJSGJm?=
 =?utf-8?B?OWhMdXV0d0o0aitZMHNWVmgxNmZweFd2eVZsUWZtKzEvb0M1czRuY001d3B4?=
 =?utf-8?B?Uzk0MXVSYzhNbktyMll1ZDIrSWdoY1N5R0J3dU11SkhrR0lza2xLdzBtTysv?=
 =?utf-8?B?SVM3cnoyQk1VZW44RkhDZEVwQlZXamNHYzNTV2E2WkJ5NjVZMW5KK3lZS2lB?=
 =?utf-8?Q?2WRVIt3s9e+NpRF5Lk+DmvR8C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WGLW188Epn10x3g8TkvuEn9PUeYa0lpV/sBw1tNepHZcvAT6twQ4ZIVqeuLMECtEyIm5dNDjVp9cj4DU+nH6O1k/s8kMijq5QvfBZo+19dsBufNb4otNfcw4mdN/7idk4Aq0XNFiOCbQ2ZCTv74tfx4qgc11pd7iAlIsjbG1gzay7Zt13SiFTMo6f8NyUqs+uhVl0oiVGKdsXH3IVuaKKL6wDLJS/GaDvhtpLD0E7+CZ75ubL9qJ1lqBFVrxXTUMC2rR1QgrqfwCFSbGZzvVGYUJrygklM+rMRUrR5/Cboqxh4SZX6Tys0izdRv1QcR68OzRTiYo07tnzje14EKps25y4zvlSQFn6/d10VoWfdV4MlxYIidIyMN6Is3Vi03MAea98fWhHAJXZ4GFqevD9bn9FcNxo0+0q+6+Szg6x5s+qFRkS8QRKdo+FhPXzNuR14MSUU3l7OFk2/95YE+eqag8zBhhTbIgjuW4WSn9QsmPCezZxfESM3h9a63s3Q11HHofbdO5u8ip7dCSaWWa6N8RIDEqUa9gaGhSfeJm1qhcktspglYOQtQlAZouqxcb2JY6wF4zp74oQ5ah+MLIuHGiD8Hv9CtpJwUYfahy+cU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd3e6a8-b5b4-4cce-4229-08dd5d849e75
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:30:33.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeuwhLhtXy2wqA4wM9HzmVKW6BfKzSvpSr8RQ5BoMFDtefuVJN6jTz9GdQN1O/DTtQ5PXKyfrVcKDDFFgUO72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070107
X-Proofpoint-ORIG-GUID: h-425U7L6n0dGrV-0auyMdpI14XmPlxS
X-Proofpoint-GUID: h-425U7L6n0dGrV-0auyMdpI14XmPlxS

On 3/7/25 9:29 AM, Greg KH wrote:
> On Fri, Mar 07, 2025 at 08:55:55AM -0500, Chuck Lever wrote:
>> On 2/9/25 10:57 AM, Chuck Lever wrote:
>>> On 2/7/25 10:10 AM, Greg KH wrote:
>>>> On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
>>>>> Hi -
>>>>>
>>>>> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
>>>>> looked into it today, and the test guest fails to reboot because it
>>>>> panics during a reboot shutdown:
>>>>>
>>>>> [  146.793087] BUG: unable to handle page fault for address:
>>>>> ffffffffffffffe8
>>>>> [  146.793918] #PF: supervisor read access in kernel mode
>>>>> [  146.794544] #PF: error_code(0x0000) - not-present page
>>>>> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
>>>>> [  146.795865] Oops: 0000 [#1] SMP NOPTI
>>>>> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
>>>>> 5.10.234-g99349f441fe1 #1
>>>>> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>>> 1.16.3-2.fc40 04/01/2014
>>>>> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
>>>>> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
>>>>> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
>>>>> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
>>>>> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
>>>>> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
>>>>> 0000000000000000
>>>>> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
>>>>> ff4f0637469df410
>>>>> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
>>>>> ffffffffb2c5c698
>>>>> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
>>>>> ff4f0637469df410
>>>>> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
>>>>> 0000000000000000
>>>>> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
>>>>> knlGS:0000000000000000
>>>>> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
>>>>> 0000000000771ee0
>>>>> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>>> 0000000000000000
>>>>> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>>> 0000000000000400
>>>>> [  146.810109] PKRU: 55555554
>>>>> [  146.810460] Call Trace:
>>>>> [  146.810791]  ? __die_body.cold+0x1a/0x1f
>>>>> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
>>>>> [  146.811854]  ? exc_page_fault+0xc5/0x150
>>>>> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
>>>>> [  146.812862]  ? platform_shutdown+0x9/0x20
>>>>> [  146.813362]  device_shutdown+0x158/0x1c0
>>>>> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
>>>>> [  146.814370]  ? vfs_writev+0x9b/0x110
>>>>> [  146.814824]  ? do_writev+0x57/0xf0
>>>>> [  146.815254]  do_syscall_64+0x30/0x40
>>>>> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>>>>
>>>>> Let me know how to further assist.
>>>>
>>>> Bisect?
>>>
>>> First bad commit:
>>>
>>> commit a06b4817f3d20721ae729d8b353457ff9fe6ff9c
>>> Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> AuthorDate: Thu Nov 19 13:46:11 2020 +0100
>>> Commit:     Sasha Levin <sashal@kernel.org>
>>> CommitDate: Tue Feb 4 13:04:31 2025 -0500
>>>
>>>     driver core: platform: use bus_type functions
>>>
>>>     [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
>>>
>>>     This works towards the goal mentioned in 2006 in commit 594c8281f905
>>>     ("[PATCH] Add bus_type probe, remove, shutdown methods.").
>>>
>>>     The functions are moved to where the other bus_type functions are
>>>     defined and renamed to match the already established naming scheme.
>>>
>>>     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>     Link:
>>> https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>     Stable-dep-of: bf5821909eb9 ("mtd: hyperbus: hbmc-am654: fix an OF
>>> node reference leak")
>>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>
>>
>> Hi Greg, I still see crashes on shutdown 100% of the time on queue/5.10
>> kernels. Is there a plan to revert this commit?
> 
> Yes, I haven't had the cycles to get to looking at the 5.10 queue in a
> while, which is why I haven't pushed out new 5.10-rc kernels.
> 
> I'll get to it "soon".  Hopefully.  Ugh.

Understood. Thanks!


-- 
Chuck Lever

