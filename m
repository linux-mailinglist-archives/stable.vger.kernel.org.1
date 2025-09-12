Return-Path: <stable+bounces-179400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009DAB5587B
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518F93BA7FC
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83402798F5;
	Fri, 12 Sep 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PrE8y7jf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqjr1NhM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAD2765D2
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713017; cv=fail; b=YSqlwFE8VrQkR3bejiP+Y/2ThfZ3jGYksNSsCONriVd77Eadi2JqmJ6EpPImCE1eK+6EUDVC8faD6ahTRErTVavykXa70nv8UZIMrdJCYac8EGzofViZ8QK7cEw2dcvhzpOqAL13oXQgWlroGQYmNpGt+XLqHE3CtPWNlmw6A5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713017; c=relaxed/simple;
	bh=x/3BXkr/slcegDwFVUoE81SwjxgslUwOH/pagcQX1Yw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZo3Jr9Fq04I3+pUHB/H0qvQ8h1nTFdCsDazP+L8FOwoitBQVjsSQfGf0JRxVYoQZ5m45itHDwqjefiSAk7U3+bCH56z60KDBdDoq6SAAeIg/w9F2ZkvqGD/k+jIF8el4QQbrn53s/+nfDhO7vinkVifh0IsGzpzNx+WnlHBW30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PrE8y7jf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqjr1NhM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLBrDt020082;
	Fri, 12 Sep 2025 21:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05KGJSrUCJjsiI1yHZ8Ww7t3zJYpE3jq6ZMg6RmvUGw=; b=
	PrE8y7jfyws3opWD4JWh/Vcldu/JUQJgac0gBbPcHevDQh9Atynn5jYJHR8JUOYD
	mcupAE9F6Ab+rZG9JovLwEQN2oNO0fGiFru++vYwMwfE8OuAHT5qBpYfWU8xMOtZ
	yRnmPp4NNh05jwiG+cIQXNQP+4lk+XgZQnaQ0y39rx2sKcJCeWEM1ekVkSeZ6spE
	mIuO+HN2GNcyAs6Fa0KsHzLk6uYn8CJ/9rTdy66O98aJZkiWevbw2TMiyZ3QLAS6
	cE4IKUFn2YBONYnAKBuf19bmXIVe+5MDPzeMTS1Phm/ihbktlZkH6l4BMUIkFw25
	0L+lNE2eovjsfAf7zCwumQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 492296929k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:36:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CJXNmo013632;
	Fri, 12 Sep 2025 21:36:41 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdek68w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaqNH4VqbZfffSxVLGKcS0T5EEJmMj+3mdroTtyPyrpz9h040oY5qG1ccx21kAJLre+ILzPf09Lf3mm8hPuZGGVbThWiOhEWGCKRcJ5D4iMFCwfBZpmCoHzBozLbMUvDs5vg1vwgJAdzddCTbVI5w6QbyebVl+W8BfT8pFKbRw36Op3K4XEklpZ5Z2hrWQgvbY8ZPD6sb8TQ/Hi07wCNJFeNLoWygSZLix5wI0dDxsASzBEaG6fJarO2uPcwZ4RPCJ9h6IoPVyn++D6lmBTblkFOWy2ZnsY+CJv+urtzDvJnDD9dEIvGZn3lR+CVi/Vr8Ohm83sqtscC9vBOPVVBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05KGJSrUCJjsiI1yHZ8Ww7t3zJYpE3jq6ZMg6RmvUGw=;
 b=ASAC3PF1fTmRT/eIVuTbhB5B2cGdzmnlZ2W0dqrv+W37s06rU/ZttCRZ6QT+OE48SAt3wWtdMRKWLQFFiL6bOptEu+XdKePQkwmaSREYfc/7PxeN2z4K3PM07VbRorNfL3uEISxIPNpVIL+tvz8cm0K5Hk9AHjJCsfXbM47DKZm/g8Ezs/WOUG6zOiMLTHtshADGAx3q3R5eeX6v801gEnhMj20j1hZ+ba41nyTXFdnPU/Wgw+iAHYWr/+PZBD7VTMPYbDLO7269b+UoaWCtR55WEGDvXIHERte6X3iuKqlaCC/SpcR5SvUOGVU7As94ZnyXz2WuUJpnqKvwWqwRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05KGJSrUCJjsiI1yHZ8Ww7t3zJYpE3jq6ZMg6RmvUGw=;
 b=bqjr1NhM06x2XokiLTI507n0hRtjGMAT1sMrW+JpzOdL+vRJwv6vBBDWpWiiQEunIt4/iwbI8QSTumMHwBVoYw6lc7iVshnVdI2CmX2k3Z3B3ZfHaa9EtBE7rbQAigANDFr2zglForyiVpDQlbf4g6Br1GlZYfjjm4hZj7FHzb8=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 21:36:38 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e%6]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 21:36:38 +0000
Message-ID: <1ca08c81-0d2d-4035-a12d-8ecb03f1b12b@oracle.com>
Date: Fri, 12 Sep 2025 17:36:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5.15.y 1/3] KVM: x86: Move open-coded CPUID leaf
 0x80000021 EAX bit propagation code
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
References: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
 <20250910002826.3010884-2-boris.ostrovsky@oracle.com>
 <2025091158-cloak-murky-d3bd@gregkh>
 <ddbba881-5c51-464f-a41d-2ea39e0183b3@oracle.com>
Content-Language: en-US
In-Reply-To: <ddbba881-5c51-464f-a41d-2ea39e0183b3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d4883b-f10e-4a00-9ef4-08ddf244744a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0prQVpXSGw4UEJZYlAxVU5pMHFRYWRRejlxOWtiUXpYZ0w5eHRlMUJaeStO?=
 =?utf-8?B?SW92ZGgwR1NDT1VaYjk2NVEvOXVIcy9DRU5MWXJaczVQMzNxM0pKUEg5WWhB?=
 =?utf-8?B?MXk0elBTaEE3VjZwVTVoczkxRHk3eTJVK2FMWTczOVlGMWRkWnh6WFdveEVJ?=
 =?utf-8?B?cVBIb1Y1YUVCVnpnRVNraHZ1R1JVQnJ2ZUpZcWNPbWZSTEZRRDhqN3puZ1JC?=
 =?utf-8?B?alo4cW9LVzlzUEpoeGgvdVFpNlE2cmk4WU1FeXdObkxxcExxWnluT1RrWHFl?=
 =?utf-8?B?WVRlR3ZjbmlzNDBwV2xaQjd0eEZGYkdUZFpNY25YS1NOV3FydXd1d1RMalBG?=
 =?utf-8?B?UEFtK21yZFhhZUdRMmNvVWoxQkRZelp5d2kxZWxrTnVpL1FVVHFneWFHT1A1?=
 =?utf-8?B?UjAxYklQQTFMb2U2K3A3eHFTSVQ2UzF3TVpNUzRqOGY2VnV5dDNYOFZ4NVkw?=
 =?utf-8?B?TGIxKzF5bEFQZFRUa2RmZERaUWhXY2tBa3M0c3o3UmdyZzVpcmRYTDk0ZlQv?=
 =?utf-8?B?QUFuZ3JwYzd6bzR5K01tSWozc1hoaFZrKzZHcWpNL2UrRjZqSjl0eGNKU0U4?=
 =?utf-8?B?SWxqYVhTdm9DMUlKRXlGUG1iYVdLTVpyN1ZGYUlsTlI0ejcwMnJBekdleFFq?=
 =?utf-8?B?NitBRVJEbWpUdm42ZW9WSUIwYTMwYzNFS09hbjJMbjhmaWF3SzhvRC9vMXNH?=
 =?utf-8?B?VUo3cVlQTFBZRm5EYWVSNDBDSjJNSFFJTitNWTdNY25vekQwT3FoeEU1QzdJ?=
 =?utf-8?B?TStrU0U0R0tBa3Z4aG53b3NBQXpMWENQSjAwWlFaVlQyaEo3Qms4NWVJMGlC?=
 =?utf-8?B?NHppSDdvWnRJeGRpalg3QW5IcEM1SnZrU2lRVWpONktoZ2gvNmJyM1A2RjNu?=
 =?utf-8?B?bVcvdUhOWUdQS3VWU2o2cjBFRzk2dExjUW9UZG5oejBmdXpLMnl1SUp3V0Nk?=
 =?utf-8?B?dS9zcGlDL1VZWjFBQXZhMmVZZ0hjRUFxODJGN1RTTkxFcFZ1eW5zUzdmOXQv?=
 =?utf-8?B?Y3RGbXlKWi9VUVB3UklsMGJVSFpURU1iM1lxMmVPU1N5bHk3ejljSU81RjJR?=
 =?utf-8?B?cjgvdGFCQzh3SXBYeTlWVHdZZ2JzdGZzdkpBcGhHbnlCK1lLNXRySEZQc2Mv?=
 =?utf-8?B?UzJoUVBRdDJycDNsSTlXN1UvL29JOU1WbzlnTlRwRGVxVzVxZ2Y5eGlCUWsx?=
 =?utf-8?B?QTh1ZkJVNjBFKzdiSlNsQUZ2ZmJyQlJtK2JWYkFrazlpR2s0L2ZDTmRneEwz?=
 =?utf-8?B?WVFlajBkMjFDME04czc3NUF6NlNabk0zcGdLaHpaOGFhdTVUd1J1TVFFUzE0?=
 =?utf-8?B?NVVCV1cyQit0SFcrQnhXbEJEVTJsU2h6NHVPeWJmRS9LS3F4L2VGTU9tNDBl?=
 =?utf-8?B?SzN1NzFFNmZtQ0RtbmxtcVpzR05ZbTVwVXR1WHB2Y2FGMzBhWm5XTUhPZndl?=
 =?utf-8?B?VWFveWJpVzlOcG9yMzVETlF6T0VNaEowRXRlRnhadUF5Nk04V1ZpYnljWVdr?=
 =?utf-8?B?Wmd2b01oakluRzhSdVhPUHZYZWJjZkc4bTBUSXRFVndha2hDbUt1WFBwTGN6?=
 =?utf-8?B?S2RndFNQSkxMb1MzSEI1UTZIRFRzUUptcDBrcmMwS1lCMy9aT1JzUjROTU9a?=
 =?utf-8?B?MVN3OVVLVmVhdFZ5bHAvR0o4alJEREtvMEtMdmR5Nk5UeDhTQjFmR2M2UWFE?=
 =?utf-8?B?VzZJaDdNMmszaC94K24xamQyYStwNmxJUVZJUFE5Mk53ajNCdDFQNjB4Y2tV?=
 =?utf-8?B?cU9LZElCY0hSMUkwbDBYT2xjTG05SUhHYnA4Ry82YW15OG81S01vSklCT0xx?=
 =?utf-8?B?ejhWK1JZMk0zakZtQ1MvSSs3NXVIckRWMVFnYVB5WnJ5T1kxSFNkYWhFVWJD?=
 =?utf-8?B?MVh1RXVGMWpCaXZuUC9tbzl1V0tYajI3Zzc3NU9wQVh2U20vTTZXd2hsdXJS?=
 =?utf-8?Q?1IF7YsykIwA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmpncVkxdEo0UzNDOHUzTFpjWnQxbnRMK0ZKZ0JwU0w5RHlNRWlubGVNY2hz?=
 =?utf-8?B?OWJvMUdGWDJXMkJGdzd6VlRuL3UwdHc5N25Xb09EM0VWU3hmS2tGVHc3TEw5?=
 =?utf-8?B?QlB3Nk9NSEpOd1g1elgwSmhUV01pUGVHS0dtTWJxVVdEUlFJR3VtZ3JBSnFH?=
 =?utf-8?B?WFRMSE1GTlFmWnhWK0grV2lrd3NTU0U5dzZDVTU4a01WSCtGV1cweUUxRFg0?=
 =?utf-8?B?MlgvckdrcnIzTURnNnNrMHU0N3Y1elVLNnhnQ3Vnem96NUpqV2h1U0svZFhE?=
 =?utf-8?B?YzhsM2FOUmUzeXNsZEhFdDlqallGL0ZzQ1pTTkozbVRCU3NaRUV2UnphSTdv?=
 =?utf-8?B?azBZT0NKU3pHUENYTVVpeFNqNnVQZ0xNSVhTVzFkRUR2aC9HazFqYUh6Q0dz?=
 =?utf-8?B?N3c3UGpxQW40c2dlV0F6dHAweC9ZTmVVNzZHN25wYWxqOU5hcWYzbVlhZHNR?=
 =?utf-8?B?YW9hSHQwN29HQ0tzTEdibDhRVnhQZmczZXExSHZJcFI5MVQ5NkZTZDBnNUFE?=
 =?utf-8?B?N05uNk1hdytvTjY2QUpzQXJJVk5SWHRRcStrR2MvZ1luUmxndUVTVTAvZmJE?=
 =?utf-8?B?R2p1STlUTFQ1dkM5aUFJMm5qUzlyUzc4M1AzN1BTWlZtSGI0ajhCclZVank4?=
 =?utf-8?B?bnJpdGtucEJWVThrQWZYdzZISnE0VjFqWnUzbHJxUFZYZlZ5eUI3Y1Q4czV1?=
 =?utf-8?B?VkRyb1VXOUltNWZzUVVDK28xK2tQVGlmaTFEbzBCamRETVlpdWVodU9ZbGR3?=
 =?utf-8?B?MHFPNkppWjZsbThiWXZwRm5pdXRaUDNOOFYxeVVXVTJTMTByczV2NHpRUFNy?=
 =?utf-8?B?RGdCazROMG15UUFCenp0SXVsRDBwaHFMdVhEU213YTRJTEFWOUJxRTBHQS9r?=
 =?utf-8?B?SmhScDFybko2cTFnTjREajY3c0ZYajdMb3lYU2h5c1VqYjhtanN3VWx1VnQ4?=
 =?utf-8?B?YVVBNWZZNUdwUnliRHViRFROcW5nN29RNHEyZ0FNSG9UYWprT3dCYjJTaGhq?=
 =?utf-8?B?TldtOEEwcFpJc1d0UjFuVjZ3Um5SSGhTYWZQTXhoZDZYMEQxVmNsd09ydENP?=
 =?utf-8?B?SzBNNDQ2ckwyUzcvSHdmemFRemFjbzBsM0VnZlVSNmN5ZWFtcXNUeFcrSkZa?=
 =?utf-8?B?MlliMFlNZVBIZEkraWRVT1Q4WDhjd0k2V1p4RWpSUjN6Rjl5c0VZTFp0OVFw?=
 =?utf-8?B?SmxuanE3OGNHZFJTay85VU4renhWcGRPSUE0cHpmWm12dG03M2JEU2pIUEps?=
 =?utf-8?B?UW9CbWY5ZXJPQlNwUWR1bEU4WW5kMEV2R3hmMDZwYkg4eE5ZZnNFeDB2TUUz?=
 =?utf-8?B?cmlJZHVVa25lNXlxMHN3VjA5UVdLWnBQR0Vva0VTZDVsdHZGVldLcU9KcmQv?=
 =?utf-8?B?a2lMeXpCNHhXVEFoZGZncWMwRFRqanFHdWx0L2h1REpEdXRlajhsWHdIb0Rh?=
 =?utf-8?B?ZHAzV3g1WGUrUWZkbThjRVdXV1BPUXpjUzNJNXpKWE5CdDR2cWRmZDZkM29s?=
 =?utf-8?B?UmhKWVBieFFpcFJXZFU1ZWhWWjkzVkFqVGVFNVhwZGNxOTYvdjJ4ckxRenJY?=
 =?utf-8?B?UXN5a1E1YiszZnY5SzBsbkRNNUMzNGZXSDBjOUJuMFZWQ2I3VUg5WFlzbFU3?=
 =?utf-8?B?RE5tK1pKUEtET0FHN3R4VHljZEhCcTh0d0pnelpGbjF5MUhEOTBsakhFRjg2?=
 =?utf-8?B?dm9rY3FEWXhIZ0l4Q3pUaWV2NmtMdmdiZXhiendjOVJJdWpCQ2QrTzc1UUdp?=
 =?utf-8?B?OHBlMVZFcldYT2VIdW9jVENzamQ3WSs2bndhMnljNXJjQTkzeDBGV0lJdlpU?=
 =?utf-8?B?NXVZWDFhVXhvRGFhL1VkcUFIcFNiU0FxczdmTFJLZS9DdTl1Z3llYXh5REJ3?=
 =?utf-8?B?SS9aaGZlM2tMMDcrWHhhNi9IZUlNdEtuaVhyeE9nOXVNamt4MTFFSTNRb1dU?=
 =?utf-8?B?ZElhOG9VaHJkWlFGUDR4SEJUVWxkSHZXTjVRaWNuNWJDcVp5MTZTUlJ0T05K?=
 =?utf-8?B?WXJoNGpPbDM5dWt4MUVhc0xPQUhuUEtBQ1k3S3JneGFJSlRhb0dRZ0xucU5I?=
 =?utf-8?B?SitWUlIwcDJhYlFLMWRTb0ZEUXB2am5FWUdTYUJ2TWFoRnpQejJqS3h2WktY?=
 =?utf-8?B?eTJjKzNlQmJHSzZDdmxoR0o3azRQK2VFVWZhZkZVNGNxTVJpZ1RCcnQvTC9X?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YqrVlsKKc0ATulaFShFMXJXeG66XbBM1W6QaEvn3MZoQA8sC2NK1//QelkK3a1cU2O4lZQ09Efj5RRw2x4IvILb9mCywlqYOeBMgeuP4vyWhjQlwy1B/g0/+ArUW0vrywavrRk6ke0YA5fo956EKFzLeUNKS8XxlFQGSreb1vPrV/AluE9/gJu8T1L+s5oPvujtuB3QH+73/fKgQWmnF+tQvvXsDTh4416Hq5kWSQcUwwf/j3blJst9rpPU+Sqw0vjNOE8fo9uVY19BQvlNE1A4PLfxYgjOp5Kld0347tTSlBK6ToYqa0/0NSUdatqNT9mlTtWiUYPzG4ukUqqhzN0Ul4EuYxtAw2U5rXdOYTKmdVv2x717N5jB1WXRn2GqOCTJJqdACZ9yn/wWWeMAThFlY+KEBnUQsnU/QtbByMotEHpv55Rda6yFjLMP22j36lN2dwq4zRfu+BQEtCgwJI47TQU3iN6gDtZnwUrh3cSFRr84vVXiPU9kDfzXxrzaUBqybx9WSPtMRNtlWH2of2bnE9O494Z3t7JU6OXKx8AcSAzpy9xvzkkeMpvsMlH3O+JnsbqhVVw380b3ujZSrdvOeVU54wfPZjNH/jnwTQ68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d4883b-f10e-4a00-9ef4-08ddf244744a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:36:38.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO67S42MA+Dea6wqrvbA7HlHK+PyztcFLRzuJfOND80CA3eRfS0KzgXOZwuI3wyLHMMP7B62R5qfmfOurD2XLbsA/vEDRzDnJBTYHz01rw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120198
X-Proofpoint-GUID: rRdo8nUpaxONiZX2MtEDY0qBoZtvA9ZW
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c49269 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=48o65U_rxvI6s2ezsWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX2ItHK82diu6G
 UqAfhFZAxAXbh1IwPYNEG+St54LYwC7z8kgE8a/JnihzTJu0wV2ypduDoo1O3wza9IjFIrw+YQd
 v4uCuMksgTG2wWSO7mnwMJn70HwoIatFepzjpj9/ygnQWF3QjM5Ht/DdI0v472WP2fUI7pKwAe6
 gOyqH157YR4Aed6KVivP3OCZ+dk3Jn1bgLi2qXNddsRCUHio4hOVux+85WPrPHhez4sx6z8dOFJ
 QUTb16S8Ziq0CDH87gR41dYfAVa/UUHy01qL2mdF9UIZWH0UiT8T0vl+NiDuHLjRgnZOacaD2xl
 +zLljVxUcVYZFkWSj1ECxzFFa1wg0219VLorPzTdM0Qg5NBqz2CklYatxab269ziEKy2GE9kq5U
 FkBb/GlY
X-Proofpoint-ORIG-GUID: rRdo8nUpaxONiZX2MtEDY0qBoZtvA9ZW



On 9/11/25 11:40 AM, Boris Ostrovsky wrote:
> 
> 
> On 9/11/25 8:33 AM, Greg KH wrote:
>> On Tue, Sep 09, 2025 at 08:28:24PM -0400, Boris Ostrovsky wrote:
>>> From: Kim Phillips <kim.phillips@amd.com>
>>>
>>> Commit c35ac8c4bf600ee23bacb20f863aa7830efb23fb upstream
>>
>> This isn't in 6.1.y, so backporting it only to 5.15.y feels "odd" and
>> will trigger our scripts trying to figure out why.
>>
>> Why is only needed here?  Things were fixed differently in 6.1.y, or is
>> 6.1.y not affected here?
> 
> Hmmm... I think 6.1.y is broken as well, including the need for 
> f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 from 6.2.y.
> 
> I'll test it.

Yes it is broken. The patches are pretty much the same as what we do 
here for 5.15.y with a small conflict in the first one. Since I already 
have it in my tree I'll send them to save you time resolving it.

6.6.y is also broken but only needs the last patch, I'll send it as well.


-boris

