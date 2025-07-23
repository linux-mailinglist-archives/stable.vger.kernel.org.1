Return-Path: <stable+bounces-164391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EDB0EABB
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F703A6C6A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E226E6FA;
	Wed, 23 Jul 2025 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zl4LGvvd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="spHjNfVV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8126E6E3
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252918; cv=fail; b=hwqdtVyD3u1OOl+aXKLFolakic1P5j6m/adr4Nx1F5NdsIgw43p++3HpIkPCrfW8goDN88lDaWziKMfxULQfK1VqZZvtq9NEv6bUoScBKKr2MStjSFH65XmoWg68fse9zACBY9bsuXZh9vjjS9U4GjyVeDQF5MKcsuItNiuLSZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252918; c=relaxed/simple;
	bh=x1VEJwxpmepzCWgXRPrfujQj/n4/hpikbBdgu3F0H2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e6kY1J1Uw8079zlF6x8N/OhWVh9obnrcO9c8wa6w99lNdw0QW8C8XVjsiihMfjUI2skDslFpToTASWNzLzHKuEih5kTX9LDJA1fOnbaDeneRPdt1+gTGH/ZPBC6AwMmQ4UBsXpM+vneG5LsD0aLYnazDZ2sUoaSGKGEHSk8lB+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zl4LGvvd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=spHjNfVV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQnIM023250;
	Wed, 23 Jul 2025 06:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dpHcJu//zVx1kymK7GcN6HGRBGoV7Qv+5wHxwp/Eir4=; b=
	Zl4LGvvdaBq/OmgbhKzkIjzdiR6r8IvRO1LCG9pDX194lLzo0YUHPLfBpybAbRZ2
	UpCxDSIaHhhaJ37vDSLG5byRsasHTlAXPgVLpyq1XnfdgK/fTCl3ViGFcajeHD6Z
	hsNacv++qtJZL2BvJndqAgYyFAv/sSk3GU+olGtbOwZXQ3atTaMJ5FJalq+ThAj4
	0ZYqnqhJAK0kRoJHDvdbf6+5toszIK2ylG8Ze05ppaODnQJwf9O2vp0JtUMRn+uh
	rqMA0MJTREq9cYzSieQ+S7YY23qahx1QM2Ptta3lTFEQmnQgM9dpIPvLQUYAMiig
	AWULDkn9qLo8BgU2Zl8Epw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9pw5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 06:41:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N4esvB005769;
	Wed, 23 Jul 2025 06:41:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801ta7k5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 06:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHXKaGNhpp1FNFE1I1rXxXu7zPvweae2m3a6VgZzkyzOcyvWXxzqFHeVatx/GvtSHQ3S0tV7kwS2dN7dqrSbhStRkWNulOK5nMiAB63sWPdx0LJR2JLBGQR7zcfakYiQ2Fn7Y8rA75NBQAqp3XTKSHktmQzBJoUHJ0EAOlxTT+LDQ0KDJH6F5LZeNtXlAsQhfnEklTWXRPmMM1FCtmb2m4gKLsi19BHHrQhVhPClpGLq4N7zj4CCKI1x/4UQhA+BW8WJtkz0uT/QxjIRg57zLoalvoEFRiJDFwRi9wDROmobadr6aoU1oRBwE5rjfR1aNwCpIsbKiD1cm0D9eGQNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpHcJu//zVx1kymK7GcN6HGRBGoV7Qv+5wHxwp/Eir4=;
 b=XO1ZCa0FrgzHKcKr8iZiu5PWxQvK6YKifYuEzFBRmTT0MzWLOxoqJAxhRk90Nmi9xXE0+qoFraEcf5/bsq+EH8OV1vT3Ex/2cXxALRNlPUmu4wwYxeDTJ23M4MW5gA0PvOJK4YEwGJ35vyR8mwX8GCs1AHgtFr/JDe1Cw4oLb6D/pxbIqumNhrzdnm1coTu1Bq81t6NyNXruizvVOJhAZ0QbHzITRFY7vv7hMmuVHjcHU1MGaEcLd/lcZ9XGmq4AzL91jD+HEHgc3OUv8Ms/tm37DCvwWwTL40j1Z8N9Iatc3pQs+kYw/z2CKGPV44O5YJR/Rl7PoSdSaBOwNJyV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpHcJu//zVx1kymK7GcN6HGRBGoV7Qv+5wHxwp/Eir4=;
 b=spHjNfVVg1Uj2Rdpgb0u2qkDwPQwWAmpf+dVNGLxZZMix3XB0A5E/oumLSnZUOTiYgMRn7bRnjGKIhPlcYGx9x68wssrLZeq/o0nkNmVS2Uihh6W6yJY90UFc7SAv9YRfZvrKN7nXeUjzfb3Oqj1XmUXURCNlNLWdy2zPwZWA9o=
Received: from CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17) by DS4PPFC31902354.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:41:47 +0000
Received: from CY4PR1001MB2310.namprd10.prod.outlook.com
 ([fe80::5661:9254:4b5c:3428]) by CY4PR1001MB2310.namprd10.prod.outlook.com
 ([fe80::5661:9254:4b5c:3428%5]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 06:41:47 +0000
Message-ID: <bbb2c75c-2e14-47c2-987b-aefabf298d6b@oracle.com>
Date: Wed, 23 Jul 2025 12:11:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] powercap: intel_rapl: Do not change CLAMPING bit
 if ENABLE bit cannot be changed
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <2025070818-buddhism-wikipedia-516a@gregkh>
 <20250721001504.767161-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250721001504.767161-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::6) To CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2310:EE_|DS4PPFC31902354:EE_
X-MS-Office365-Filtering-Correlation-Id: 214ca972-3358-4b2b-3e4d-08ddc9b3fec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ei9SOTE0cHNBUWtLckdadXFIaGZkZEJrMkRUNzB1Zkw1TmM0VDdhOFZ2YXEx?=
 =?utf-8?B?bFd4RkpES2pGTzRibGVmeXBIT2pYRTZ6a1JEMzlJUjBlQWJiclZwWEZXQk1m?=
 =?utf-8?B?anpMKzNzQ1dBbnY5cDZDREU1a3ZKSVJhNUNxOUNXM21IeDJXYkZYZDI1d3Qw?=
 =?utf-8?B?YWd2Wm5aclNiSTNNRWhURVRpOU85WWxZNlY2SW9xUy9aQ3RXY3Z5OVpPME1F?=
 =?utf-8?B?UXR1S0hSck55QU5Celc0S3dpOUhqR3krdnpYRXZmczM0c0ErSHVFc0M0VWk3?=
 =?utf-8?B?VzNhdjFXaWJCMFk5MDJRYWlEdUdHT2ZMVk5waWRHaVNzbjNrUit4bVRYd045?=
 =?utf-8?B?VVllNUFhQ3diSUhMZXRNczNTS1ZiK0c3OFlyZmMrNGl0L0xYRDJxT3pmeHRK?=
 =?utf-8?B?S2NKK3dmQzJ5Ukx0bFk4eGx6b21GcGp4dW5NWk5qaDBvOENCSUM1dVdIeEVQ?=
 =?utf-8?B?M2tpK3A5ODVJeTJxYjNIWHZUQjkzS0RjSEdHbm93RzA3dFVnZ0hBMitVT1lx?=
 =?utf-8?B?THp1bDZmclhkM3BFQ0g1N0pXajJia1l5M2tkcHFXUEZ6MmZrcGJkM2wveU9l?=
 =?utf-8?B?U3NwR3d2elNpL2s5NnAxdUlHd1hITmVTR2xDUjllMjcyRnJMd1NWM01Tci9s?=
 =?utf-8?B?K3JLU08rVTVTZXRudjZtR2dXakpzdlZXVm5sS0ZuVXhEZEhKeHZCRU4yUEtB?=
 =?utf-8?B?cHpNeGIwU1orYk1raFUrazFVdGl1Z1FqT0hvTkVibytKWmhZclJGNnJEUFhm?=
 =?utf-8?B?NlFsQWRzUEVZdWhZYzRjaUFQMTJsUHBqWlk4Mm5tajFqLzVRRGxyNjN6WXRh?=
 =?utf-8?B?czgrSWZpY2NsNDZOY1FiTzdpUzU2RjFMRWZqeTVEL2l2LzU1UER3cFU3ZmRm?=
 =?utf-8?B?d3FtdWFyV1F2ZEdpUTFtMzAyUHVKN0FvTmdpeU9EYjJwSGRXNzRnVFNTQWwv?=
 =?utf-8?B?T25wZlBCYlRGN3JjQWVpSURSMjR5d3ZTS1VWNVFYRWs0VTQvRExURkszaE1M?=
 =?utf-8?B?ODBNd04vZWtDNDlBaGtONnhiK2R2S1N2L3N2VlNEQ3JPSS9NeEhHREJIU29Y?=
 =?utf-8?B?aE0xSmFOMmdDK0VqeXNJQitpWVVLNWdCMXkrWHJmRlNwS0VWWk5nWFJIWnBa?=
 =?utf-8?B?bndwajcrcHBVK01ra2RONS9YcW5MNllYL25xby8xOGxVRFA3UEt6SWpVRE0z?=
 =?utf-8?B?V2xvZWJ6U01nWjVPMnA0S3B3aHhNdlNUZkZEcytLUHJzZTQ5Wi9XbXhJU0px?=
 =?utf-8?B?cmczaTkxSDQ0R2JsbnhPOWpyS2VxQkxIYTdkVi9uY01jNTF6UDEzVTEzRkFt?=
 =?utf-8?B?aGtVREEyanhjU0svVDlkV2RnalQxYUZhUlRPcDUzOHNnUFNVOWU5MGlGMW0z?=
 =?utf-8?B?dXFXOVhad3YxY21yUzNMUnJMWm5nMytuTWtwT1JWa0xVVis2VUxkeUwwanIy?=
 =?utf-8?B?aWJ0UFJVYitTZC8wUjJiaDhwbUcyNUY5UmppRWVKUytDaFljZksvREh6bTMr?=
 =?utf-8?B?czY1ZG80eGhlT3JHanh0MWs1dHY4L0FLRitFdklTNzdocWlaZThYdXFxYWJM?=
 =?utf-8?B?S1pnbGxBNWZqVzQ0c1BCY2VlMS95bzNwRXZyWlh2SzNNcFYwdEhxaFlEUzFU?=
 =?utf-8?B?aVF2dWJmanV1SW5YRU13T1hPNjdnV1d4SXVRNFpJTXpPd3RoczBJZFhzNld4?=
 =?utf-8?B?OEdENGFzeXJuVWtPRmRKZDZmYnZwT1hrNlZkVmV0bWE4dEhTYS9IWVBNTDY3?=
 =?utf-8?B?SzEreTlZTWg4MWhrMVdWSWg2elR4d0x2bHRnVThSMHp4MHZ2Njc0WXo1SWtw?=
 =?utf-8?Q?yJmeZ9BfoNEzmWGSwPS48ih212mNQy3XmrSGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVDS1BPVnZ6ZmJyVzJBTnNaVHdpNHRLTU9aVmR3YzFFcUlaQWk4anpUYStI?=
 =?utf-8?B?SnozNDJvV1VtZmVWMVI0QmU2SXhMcUlNSkN6MHRkcUE0T25ERDlMQ3lrbkZm?=
 =?utf-8?B?aUN5dmN2Sllmc3NTMFlMekh4RVo4RHprc0VhaVNEeFBnWEVMOHhVUUxCVkgz?=
 =?utf-8?B?Vm5KSklFSms2SDl6T3JXQ01yYjJLYUE0ak1JNEN5QzUwSXpPaFVJNjU0dEg4?=
 =?utf-8?B?N3d4NUF2UHA0RVUzbUtNOVNQUTlXMzVhdDY0Tk5iaUF3ZDVqRVFUaWdoMmFp?=
 =?utf-8?B?bE10eHdOUGNVWWNiMS95NStUMUh5WkRPOU5FbGZ1YzFaMkJCZ2JjVHpxUjQx?=
 =?utf-8?B?bkYxNXAzVmtTSTYxS0tzVU5IRmRBT0pneWtBTDYrbXhpWU15MkxwbEpQQTZ5?=
 =?utf-8?B?TlRxeFA5YnR4MDQ5TUk3Yi83NnhOcDJuaS9SbHMxZ2xQTGVaZWhrdHZnR1FO?=
 =?utf-8?B?b0dqeHNVY0dBbThibDdTVThyakxPUXdaYjE3MUhzYzg1eWExeFRLbHIvTndC?=
 =?utf-8?B?LzhVTmpEKzJ6akpBbUI0U0JHb2tBUFUwNFNGM2hmc0FPbjNBaXVTdk1HVVhJ?=
 =?utf-8?B?NmVDNGhvT2tYM2RPY2p0bm9neEU4WXl5WklicU8xdjlidGFHUG14b2tQcXRP?=
 =?utf-8?B?VVUzazBkQWxFeWthUmptK0g3SUJkQnFWcmI5b2NDVW4xTE9vWXROVmdNbEpt?=
 =?utf-8?B?V3hpNnBBN2pTTmUwRHdTVlU1eU9CNVNpUlBHRW5NaXB4Z0Q3NWR4U1NrZzlW?=
 =?utf-8?B?OVQwTHlQQUx5dis3eUpZaEtsNFZFMFZnaXAyOXJxc21wTnJMVVNZWjByVDNZ?=
 =?utf-8?B?R1FmTk5NcjZlTURsT1Rnbkp6alZESEt4NTZWNURRbWNRL2xnMDRkVFRwL1VI?=
 =?utf-8?B?WjV1SXBaNlZkN2VWOTAxemVTTjFWTk5aVXZpaVdaaFpYYVptYWlpR3Y5ZkFi?=
 =?utf-8?B?Y3hhQVo1bzIvelF1RXBnUlJOdEVOaEozd0p2N3VGNUVmbFh4emtuN2c3Z1RD?=
 =?utf-8?B?ZnBWNktHNW04V09WWFBiWUtVRGpwVm9xbTBQQlJiczFKaEwweFhJUm1xc2c5?=
 =?utf-8?B?S1hOdHQ4YTJZenBUUlNPRW05N1lGQzU4ODRjSGk4U1RTNkN6ZVJUb3pWVUVl?=
 =?utf-8?B?U1lTdzY1U09LWVB5a3I0ZDI4dXN2VkN1Y3pTZkNVTWtlL2QrR2VyVFYwTm0r?=
 =?utf-8?B?ZWVmaU5HZFpxMTBRRmdkSjh5Um41TGduZ0pnQ0FvQkJ1SDgvWkhQTjh1Slcy?=
 =?utf-8?B?TGJOUVBhTXAwaXJVVXZFVys3OVJqTFNYdlp4K3A0ZDR2aXdhUi8rcjlhMXI3?=
 =?utf-8?B?ZmpIdDRubGorcCtpTW0ycjViUDg0elFjYlFGUTZud2NvcWpyK1dOQk5xYm40?=
 =?utf-8?B?R213Z1ZqeURwbHpUd1VVT3JDSi9yaUVOREhMOHQ1TVd1WTVPN2w2UXp1VERR?=
 =?utf-8?B?RUJod2NIekdSbE43NjNPT3J3RnAwMDRWQ2lzcy80SnhLNjBrNzY1Ylc4Zm1Y?=
 =?utf-8?B?aHdvZ0pidGFLZDloc3hVUVlJb2x2THhDUmFIOW9ackJnU3dLLzA0RGFpUlBi?=
 =?utf-8?B?U0ZuVTRITm8vWFZTTlhpN28yNE5BWDdJRjlmUm5zRTRxUGp0OHhiUGYrQ2FE?=
 =?utf-8?B?T2xRczlxaFdLaVpWOTBINytnSDZ4ZEtIM2RxNTlob212bkgxS3d0a1VyZXVW?=
 =?utf-8?B?UUxpYUJhRVlPSWR2V2VlZllWSmhWV3hhdTl3MzJOWmtmUURPM2YvNWRoeW81?=
 =?utf-8?B?Ry9WY3F2ZmpOQkw2eVhMaFUvRDExdHB1MVNWN0diTHNmdUtMV1ZjM0VsWEZn?=
 =?utf-8?B?SDhlRHFjTnVBZ0tnc1pUUEtmdUJFMG11Zzd4d253T0xlMDJVMzdZTm5uRE16?=
 =?utf-8?B?Mk9RditMQ0NBTVZZZ0tVekg2KzV0Y3ZMQ0VEY0tVNHhKUWgwVXZwcHFSSW1l?=
 =?utf-8?B?QjF2NVQ5QkIrZkdYQ3FuMmVXQ050VkZhOUpJS0JXZlVpVU13d1BwS2ZMMUE0?=
 =?utf-8?B?MkkyZXlqSUszUjZRaTh0S05iNWVmeC93RU9kOHBaUE1Jbkp1cEQ0aUk3Q2hY?=
 =?utf-8?B?M0QrQ0tvOGw4WjV2QmRndGNPL3RQUjhxZFBHRHdPUEgvOUFJRW03OHB0ZkUy?=
 =?utf-8?B?MWNYeXc2MzRLVkJtSGhmZTZqY0JLdzhjSDhDLzNxSzNQQlRXanhqa3NoUVRR?=
 =?utf-8?Q?U/uIZIM1uasGJcyoLkdIeqA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E323CMK7YljHgwEukYGHTdrjAX1dkoddGpoBaCmru9b7a3cshl/fsAJHsFBY7DBvQBGTr8+ECoGTdskUcTSHlMIg+sJf+eI1pcxjIqVqve1syq6LERkLwX0GvULxlDjkEliYwQMCjyvMDDYcza4ekpeI1amTNlK9dGT9LbQllo2IFl95UqzarmJKhfs6V7Bo4aSP5vEDihOhf93WGwqJnX39KH5Rv/VWzpC+qbLBhaK15QtqTwtUzZ8jCc2eH4g2vzH2A769F6zB7+KFCMAi0yKqkKbMGj0L9ez31d+R9YEMw9NKuO6HnWmvVf90tpy5EIGVFugOKNCbJ6/FrR6FxIXsuJPWTSL3ZxgvSrSOHVAIfE1nEguNwocIHJugFsV+s+/omIdxKccj1qOJdFPr2zCWSBm9zlFsF59ZMGbfu0GYX7xVx7rxCmVSCjr75CsFXB8/QzSV7RTjyt6zADocnMKxROYXlynS0+VKnSMJukso+F2pe7M1OEKx6sT8/hYXkbAY8leAkNBwSw+9BVH79G2rsbjqochf0VpkjkTzWjbHrBFrttuyuyKm6Aj4seTkfzFwxhIn1JRRb8a1Qw5s5mZ72TROa3x3e01w4y+VLwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214ca972-3358-4b2b-3e4d-08ddc9b3fec7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:41:47.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpvFa5ZIiVTlgwUrtw2hlxaAGCCtn1aBgD+8KyU8A2HL2oE6hugTxxn8q0Bq07gHZ/0GxwTpePkZYhzXjeBJx+QfmnP8SykmHh/ijT2PK/0a6ePm2uXx5pE33fPMCnbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC31902354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230055
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=6880842e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=2K-rlyPadAl51WwFJg4A:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Pa7SUlfKlgRe1cv4lkQficKp4vm9s8Xa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1NSBTYWx0ZWRfX5g7FWlBD+f4J
 Tmi64jer/8i++HTDDD2NmOpQRP0ib9E6yu9+vfXyTkVYktak8xKcdSoQiKL4Xp/e83NbYfCL0R4
 IptBbCBmRIpVg6ph0W9inKTA0lqF7979fTcOAhsAwaX04gTVqyDjGNKPQyLhPGTQdbAxtuGgD5m
 1TCdcmYbqYe0zFBvnksSv6VjOduwffRp7geP+MP1f5eGZfnUiLEdI7BpF7jXjasYBcZl+ppfn04
 kp+9dO2wkaW56geTzI+lgYTggJbLWNwgubiM5jVEVnY6OvN2ZVX1Xhc1+ehRYSc35C1ny+8ZSyV
 2KuG4kOs4aeDu5+l5GgRpFJ0joLllceaj5IdoezYkl2Zsr1JtXrZbAIHh0SBsbFYj/t+VcRe4Ei
 SKRpxWvPvufe9o+32lEE1VmOsrgWYqSQDpe6rV307I2ywWyCqWcAO/Pi1MD9ukKpGafIc0Br
X-Proofpoint-ORIG-GUID: Pa7SUlfKlgRe1cv4lkQficKp4vm9s8Xa

Hi Sasha,


Question inline from a backport point of view:
On 21/07/25 05:45, Sasha Levin wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> [ Upstream commit 964209202ebe1569c858337441e87ef0f9d71416 ]
> 
> PL1 cannot be disabled on some platforms. The ENABLE bit is still set
> after software clears it. This behavior leads to a scenario where, upon
> user request to disable the Power Limit through the powercap sysfs, the
> ENABLE bit remains set while the CLAMPING bit is inadvertently cleared.
> 
> According to the Intel Software Developer's Manual, the CLAMPING bit,
> "When set, allows the processor to go below the OS requested P states in
> order to maintain the power below specified Platform Power Limit value."
> 
> Thus this means the system may operate at higher power levels than
> intended on such platforms.
> 
> Enhance the code to check ENABLE bit after writing to it, and stop
> further processing if ENABLE bit cannot be changed.
> 
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping driver")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Link: https://patch.msgid.link/20250619071340.384782-1-rui.zhang@intel.com
> [ rjw: Use str_enabled_disabled() instead of open-coded equivalent ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [ replaced rapl_write_pl_data() and rapl_read_pl_data() with rapl_write_data_raw() and rapl_read_data_raw() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/powercap/intel_rapl_common.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 9dfc053878fda..40d149d9dce85 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -212,12 +212,33 @@ static int find_nr_power_limit(struct rapl_domain *rd)
>   static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
>   {
>   	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
> +	u64 val;
> +	int ret;
>   
>   	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
>   		return -EACCES;
>   
>   	cpus_read_lock();
> -	rapl_write_data_raw(rd, PL1_ENABLE, mode);
> +	ret = rapl_write_data_raw(rd, PL1_ENABLE, mode);
> +	if (ret) {
> +		cpus_read_unlock();
> +		return ret;
> +	}
> +
> +	/* Check if the ENABLE bit was actually changed */
> +	ret = rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
> +	if (ret) {
> +		cpus_read_unlock();
> +		return ret;
> +	}

Shouldn't this be rapl_read_data_raw(rd, PL1_ENABLE, false, &val); ?


Thanks
Harshit
> +
> +	if (mode != val) {
> +		pr_debug("%s cannot be %s\n", power_zone->name,
> +			 mode ? "enabled" : "disabled");
> +		cpus_read_unlock();
> +		return 0;
> +	}
> +
>   	if (rapl_defaults->set_floor_freq)
>   		rapl_defaults->set_floor_freq(rd, mode);
>   	cpus_read_unlock();


