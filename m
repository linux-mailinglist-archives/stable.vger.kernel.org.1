Return-Path: <stable+bounces-185853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124BBE095E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03DC7357897
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619F30B530;
	Wed, 15 Oct 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onway.ch header.i=@onway.ch header.b="R4PEmPeE"
X-Original-To: stable@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021114.outbound.protection.outlook.com [40.107.167.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BE3090E1
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559043; cv=fail; b=QxCweBDHUT6YC7VgzS2TZce3kmExyOsyTDOukbeYEK5Rkjfix8pobtxBBvC62cPLaTb+fSHAOrq1mgV+BP7LtO7z+0pzcAFYxKkyDPQ72m1hlCNwRlDYPbbpt6vSZ1Rpuesh2KqbS1zsTBvFzcHdm9VKgR+1T62kuTcSn/55Y/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559043; c=relaxed/simple;
	bh=NGTqNP2XXb/eNMiuqPLqDCOIuGQD/sCw7UCF+GwYqdA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=pvGJpTLKNMcecSqlp3kdE8f5hWj333MFyqRqWvg0PX2ZX1IpQ06KqHqZAqef28jBq93V/J5ZtlPacLW9YfWLBNzrk1fHvq7wDbPVI4extsgyEEJSAaLXGnuJnfPLZllImVieGNlY5R9K5FCdZmTYKDvIJPUPxCx3l7n20tzMDn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onway.ch; spf=pass smtp.mailfrom=onway.ch; dkim=pass (2048-bit key) header.d=onway.ch header.i=@onway.ch header.b=R4PEmPeE; arc=fail smtp.client-ip=40.107.167.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onway.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onway.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5+2bs/wbihZok+GZmgiCSN4hnv89+bLKwA+Q2IvXh8FbGwiQqe1IjNn9yZ9ie7SQYdAakISjP8OrsvL+ueH4HVNGPt7GfAWcOdJrSblKq2U8Yb/UDkK239ZZyK5020OGuGffi6+O6pcbeaK0fJG1jTVTgO1aUL05RwDToXQK30kQVgoYvuasQsWpcqrZq7ZKJtg70ePQOK9rY1mxNdR5T1Q0hY2jVa2cb+khr013ZALFb2WnVVyQi50aSzU13jrIKhns5h6qYSLdWEqYkjpDxNHM7QTu3/KakEHdgYu68ZQFeM4TV/qFFwcAK7EqZaAlQtXe4R6l0LnVTeI+6oQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGTqNP2XXb/eNMiuqPLqDCOIuGQD/sCw7UCF+GwYqdA=;
 b=FTwTEz2JkQXbho2THPlqvvVQEWvCbufvfUIsox12ydZODJ1Im5qbHTXCWYPnjvjnBlDuwWZvRuLtXuyQNyQrltd1qWascvOVnFhG8/NBFoKhBlHj+2KaRAwcWLczmC0Jy9Ust+XzvFLhQlTYBBuiDCqaX7igQoufFfhPx3MLUsSdTMutH8jiTxGE5fQxm5VkEEtXY1un9isCeLESgdYgf/+y2rXQGbMujLkCTdqLCLFQi+ZQEuhmtbsZvGaOMJP4rHvxUUTZTgc4kqGTYfts9YaVX4qmJfpOsfHT5jMuDCDMEFBLh5xB9j6WAN65hzk/830P3yIbTfsAaD7igFU0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onway.ch; dmarc=pass action=none header.from=onway.ch;
 dkim=pass header.d=onway.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onway.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGTqNP2XXb/eNMiuqPLqDCOIuGQD/sCw7UCF+GwYqdA=;
 b=R4PEmPeEVeit3d0MM0x6Sy4OhZBPNUfFyzXlEo1KXgKrkFSxq9Zjaw4/H0CkF0X/khD8WRPWT82U8nUtVEnqvNp5GyXrX45K+P0PLoidlpf4pd8NkEKiQC7+NTyBiz57SCuS0fry54Q7YzxxdkxlizbUbSBfu3kEFWoWsmCkcQ+CLFDuAvNwCsuxpRjSurhXCYbGUCAm2zVnKtLsN1/8OsBwm4+zXyMiCU3tXXeKZCKw3BBYN/5ayTqFVFqvk2jYfEnKiFRSPAJ+k4E8a6NYPyeH13aLVgmk8MS3F0jD5okiCcz2xkuCPUoPpWaczwNn59PBGg5kDNeGGymCX8y6Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=onway.ch;
Received: from ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:25::12)
 by ZR0P278MB1182.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 20:10:35 +0000
Received: from ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 ([fe80::34f9:58ab:6038:4efe]) by ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 ([fe80::34f9:58ab:6038:4efe%3]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 20:10:35 +0000
Message-ID: <03727147-0115-4ce9-b68d-756c6e41db94@onway.ch>
Date: Wed, 15 Oct 2025 22:10:19 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, baochen.qiang@oss.qualcomm.com
From: Andreas Tobler <andreas.tobler@onway.ch>
Subject: RE: wifi: ath10k: avoid unnecessary wait for service ready message
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms080304020100080803010307"
X-ClientProxiedBy: ZR0P278CA0221.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::29) To ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:25::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR0P278MB0202:EE_|ZR0P278MB1182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3643e458-9fcb-478e-2ee4-08de0c26e6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJ5WHBaQUYxTmIyWFNoYkt6bGFmZEFTcDZGc2hSSTYzSmpMTFBoc01qRGtN?=
 =?utf-8?B?UW1ySCtXRldvb2hReEw2ZHMrZ0lEWng1MkZFMW1UcE8xdlZzNEg5SmtuL2Zq?=
 =?utf-8?B?d1FPZmRmand1VENUcndrOHZ1WVg5cnBJSnRKVUVJanpFQ1lOK0s0OUc0YWJz?=
 =?utf-8?B?T0YvWmdTMy9lMXA3M2JieStONW8vSmUyb2FNallqOXROUFZ1SU0weGhlUEI1?=
 =?utf-8?B?STVFNFNtclJOdzRkUWJ4dmxEYjNiU1BXS1NvMG8zaFpBV3ZRNEhNQ0JlSXg3?=
 =?utf-8?B?V0hqU09hZGpGR2xwS01DT1JsSXhWUUJuZFpndHZQY3YxOUh1SmRNZElkTkZR?=
 =?utf-8?B?K084Kzk2UHV2VXptWkVEVEVucVEvb2QwNWh0Vzd1SmNtVmdyS2xnejVrU2pm?=
 =?utf-8?B?QVRSV25TVTcwbXo3cS9sbzgxbnFKYUZJY2NOOUdwNzZxVlNPOVk5elZiTnZz?=
 =?utf-8?B?VkpCQU5QcFF0WnQvWmZnZVRFcDNBOG1qdTdTdUJDMzNCb2w1N1lJbW9uYiti?=
 =?utf-8?B?WXZDRm9DQ2tOeDNId3Y3Y3lndTQ5WHNiOGRIWlRadCtPRURaUnhmMzRMUUtQ?=
 =?utf-8?B?ejZsQU14MXFLOGNvTFE0WkZGazdINmQzdHlYQ2VGZXUwOEp2ZG5YUVhUdG1a?=
 =?utf-8?B?S1dzWEFndzNaMmZvSkgyVncwY2NwVk1HbE5JM0pJanR1SkQ2VE5pUmJKRTlr?=
 =?utf-8?B?cEorQjMzOWNSeE83VWttblkxQ0I3YWZzeHU4K2pFd0NYTHA2UmYxY05UeEx0?=
 =?utf-8?B?SzRFR2cvcm9qcEhFUEVJZFp4aXNZeHBLdnJmMC9Ha0lWQkl2eS9EeGRPbmtx?=
 =?utf-8?B?NzM1SDhzMjNNeVVKa0RRNkVVT0RobjhJbVBNMGpVOWNLQ3ptQ0FkSkV2QWZr?=
 =?utf-8?B?RU1nUndJUFc3SzNTOHIrL1BxMm9mY3RPTXlsWDdCRC9SRURHaDdIWkd4UFNJ?=
 =?utf-8?B?eWdiREsxVlZ0Ukp6TEhNWUtkZ0pScElBRmptdkJvTHI2OWJJK3pzRDJOVXFP?=
 =?utf-8?B?dmE4eW1WWCtaT2JGRkZNZVNIVTJqN1ljRWFCdkRoajFIcytQbGZZM1pZdmpv?=
 =?utf-8?B?Mk9GcFpDZENnaVJ1REo5dUtJOEhyT1JkM3UrMmxCU3p1dGs4ZnpraU90UnlT?=
 =?utf-8?B?WUJxRURVcTNOREV6OVpUZHRCSXpyc1lGb0ZuSXZvekxMNEFyT2NUSTBPSWNI?=
 =?utf-8?B?MDhVV0dMRzRtODR3aUZVblJyVVlSbHNmdGhQZjNSUHEzU3M1L0JHY0N3bFIy?=
 =?utf-8?B?WXFjR3lVWW4zSGdYOG8rR3lTTzIrZFg5cWNFSTBFcWZ0Q1VVaTZJcUhPUVlU?=
 =?utf-8?B?TzJOQ1dHQnE4N2ZMcG1CZVovZ2ZWcGtYallGSUJPWGJmTmZyclViZTd6U3Vk?=
 =?utf-8?B?M2tKL001eVJwY2RFTFJwVk9OVFp1dGcvS3pvbStXMzRtbFFNQ3ZmUkpnc0tq?=
 =?utf-8?B?Vkt1Wm5Cc3VKc1EwKzVWcC9LU2NaYjE2UVlOY3gzUVpxd2lKbHd6QWRLd1FI?=
 =?utf-8?B?c3pLSHl4RGdHTzB6ZW5rMHFQbytacDcrUkpyZk9mblBCdUhudzFRNVhreHJ1?=
 =?utf-8?B?R0NRdXU1ZFY3Z3J1MzFtRjI1VFJlcElxa2FtUnBPanRqb2dEZlU5VFdzbmNj?=
 =?utf-8?B?eEYzb2FBWGU0RGUvWEZkUDduUHpuZEpCVzA5SUtLbU15RkVPZXkwWStjNDFD?=
 =?utf-8?B?YmcxMjBoNFlxRXN0UjNjOFBFeTU3blU0SkNZYWdpMU02SFhWL2ZLMlNwMyt5?=
 =?utf-8?B?M1BXOFp2WHdMMkRGM05sWVdaUGt3YSt0dFhLdDRqekRBRUxyMzNFbG5BSnUz?=
 =?utf-8?B?bWszYncwZ21rWTBFTnV6cXh3aVlVUzB6SHRwSW55OTloTEhNeUtxOGlCL1Vn?=
 =?utf-8?B?UDRhR2lZZ3ZuYnp0UmY3VnpNVnc0YjhXKzRySTdRR3o4dHRldCtIeW5oVnVJ?=
 =?utf-8?Q?i+Ke2BK3NbNhzqe1If9mQAN4GMLXy43o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9ZNXdEbFZSTUQ5d1J1RjRoNEkzM3pHbFRJRVYvNFhiYjBSNmhtK3VQRG9U?=
 =?utf-8?B?Umljb0F5b2wrUWJESStzZmRSWklKWVgzRjRuM3E3aWlFQnpmdElyTUtpVkRl?=
 =?utf-8?B?S1kxQ3JLSlJPcDVtUmZiZnlVM2VVUWxET1ViTUNNa0dDR2NqRFByR2JEVDZ0?=
 =?utf-8?B?Vm93bjFRQWZsSlVETGY4dWFpbEs5UW05T0Q5bFp6RFRjL0hMQmx5UHFPdTJi?=
 =?utf-8?B?VnpLMEdTZDhCRzU0ZEZZd3l3blVRSjM2QkNpcjhsVGdGWEdPVUtyd29ZUGxF?=
 =?utf-8?B?TjdDNjRJaENmcEVQeVA0WmlPK3hNb0JIdlpUMnNTR0pZK3ovSVZ2WU1zQklX?=
 =?utf-8?B?Zmo4djg2M2ladExhc2JSK2tia0k2UzFjdG1jNGRVeUlOUmpxZldISTBUbUJ5?=
 =?utf-8?B?bFZLc05oUTlia0VLTkR2OTFBa0MwcEVTRmdibzFNNng4N0NPTTFzdnFDWTBn?=
 =?utf-8?B?OGg0WTh2dW1YdzhnT3NQQjFYd3ljdUVhS3l1dDUvaEYzTVpzWmlXemhnbXpw?=
 =?utf-8?B?SDBQWkVQV1p4THVVclZMOWloSUZHWGhvcDJZYVhGODlTUFZlcUdpTHFCaW5s?=
 =?utf-8?B?a3BybWxqc3UxNlFtN3U0eittYWJEbFY1amhic0gvRGNuUG5oUUxzRGFwcGZp?=
 =?utf-8?B?QzhPL3VGWVhueXU0TTk3bzNYNmFKMmRvVnd3Wm1mT0FKNkh1MnNCbjBCUStC?=
 =?utf-8?B?Z2ZvSkoyakxnc054YWlOZEJWNlc4WlFqVjFITk94RGJRRGFZUXZobGpvaStp?=
 =?utf-8?B?WnpaLy9MVHJ6THRDQ0cvRHJNdlhIVWZyL0JmNFJLRmNzZSs5Rmx5cElaMy9L?=
 =?utf-8?B?SWpWd2tCNDh6WW90Szg3d3lDc3VTZnh2MnpySmVSa21vZ09BWVFWbTNCc2JT?=
 =?utf-8?B?MzlqYmxTVVU2NDFTL2ZDSGJzRXdjRkkzNEVsTHJVK0J2Zys3ZGhQVXZTTVN1?=
 =?utf-8?B?cHVFdldtRE9QSWFLcTUyRGEyNkx4ZUtxOFNUOEtPa2o1dUhyTGx2cjR5U2Fq?=
 =?utf-8?B?N29TUGpvb1g5ejlFa0V6YlczSDRONTQ2QWxnRXBtYnVNeVBla1BjektrNUVU?=
 =?utf-8?B?NHNnU3I3SVUxWERwbFBLeGVCS255UGZITnF6czMrMHFsbmZ6Tm1Eamw2WFBy?=
 =?utf-8?B?eGc5TDREN3dzdnF5OU01ZUt3ZlNlYTlOQTlWOFBRc3BrS0pSdm9rSFVOR2pS?=
 =?utf-8?B?UVdvZE1kdTY2U2RERVpLU2Q2OGdra2pyR0FXM3JpZktCUTFFb2E5VWE4M3dy?=
 =?utf-8?B?N1daVHp2KzBLTGd4NEZMZnM0YmoyVEZPL01NSTVFQjVjNTZORFBNNEJ5Vkw4?=
 =?utf-8?B?Y3VjaDVqczNXbWxQT05ieEl6UDhxY1RiYmNzUU9HZGpRZUdObkFkcGhwL0Zq?=
 =?utf-8?B?TWlXZm53YSt1a0NjMWtFdloyYllaRTlFQ0lnYVJRUGoyKzRuY05HMGlSbG9U?=
 =?utf-8?B?a0c5ZXNSWkdtWGszNnJvMGVCbE1vcU12R1FvalJDeEpTbVgzSUNCYzByRGNw?=
 =?utf-8?B?R3hUSjE3aVJxRXlEWmxoMDhGWUtLQm5DUXNRRlQwUFdkaG9GaFQycENZTmZs?=
 =?utf-8?B?MDNobmZiQnd2VnJEYjllaFNHYjJJUUxyS1JnTzJGbFZCUEQwQXBvMC9UWkpV?=
 =?utf-8?B?ZHFxMnhkb2hvZEY5VW5lU1RTdUU2M1k4VFZPUlZYMko1QmdFK3IyNWduUWM3?=
 =?utf-8?B?bExaMWJyOU45dFVGZnRFcDMvTHlkZmxibmhqNGwzcTd0OTlRck8vK3BWQ1RY?=
 =?utf-8?B?NUdxbEhUbEZFbkxVeitTeVhYMEQ2ZXdyWENjYnVzcG9KQTRDRDhVR2RYUEt6?=
 =?utf-8?B?NjJZTTJGeG5INXU4Tm92SFhJUWxOU2FLN2pGaHlNeGZPQ2xjN0R6VVEwRlRP?=
 =?utf-8?B?bEJLa1lHdTZ5cUNjZHlxWHFaS1ZDMk9kWkl2YlArY0tvVTh0OWhrTU10RXhD?=
 =?utf-8?B?TXNkM3dmeW5NT1VDK2RWUTZNUHdHckNrY1c0VzhwOGhMNitnZ1pLUVEwTklT?=
 =?utf-8?B?MEpaN2MyMlNFSitxazZzd0s4UWVQTU9tMzgvbzJaRDUvbW93aWdSZVlOS2dj?=
 =?utf-8?B?NHZiZzdLd0hVditSdFJ0bWVRaU1RRy9tZ1ZqY2hYTW5vVCttZEM3aGFJK3Ey?=
 =?utf-8?B?N2E5SmNVOTNlR0c1K0g1TldYYmc0RkxMaHAzMFEvd1N4RDZTR1orZWt5WWht?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: onway.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643e458-9fcb-478e-2ee4-08de0c26e6b7
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:10:35.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6609f251-fcb7-49e1-90a9-db1acfa508db
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMrR6rcXk4tP5dy0GxFgjGlvT2HDoaVdW9R1npGjFNC6bk1dAkvyIDXo3UmCKW5u0p94OoPvu1zs01QVnB7WOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1182

--------------ms080304020100080803010307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RGVhciBhbGwsDQoNCnRoaXMgY29tbWl0IChVcHN0cmVhbSBjb21taXQgNTFhNzNmMWIyZTU2
YjAzMjRiNGEzYmI4Y2ViYzQyMjFiNWJlNGM3KSANCm1ha2VzIG91ciBXTEU2MDAgQ29tcGV4
IHdpZmkgY2FyZHMgKHFjYTk4OHggYmFzZWQpIHVudXNhYmxlLiBSZXZlcnRpbmcgDQp0aGUg
Y29tbWl0IGJyaW5ncyB0aGUgd2lmaSBjYXJkIGJhY2suDQoNClRoaXMgd2FzIGRpc2NvdmVy
ZWQgb24gdGhlIHY2LjEyLjUzIGZyb20gdG9kYXkuDQoNCmF0aDEwayBtZXNzYWdlcyBleGNl
cnB0Og0KLS0tLS0tLS0tLS0tLS0NCk9jdCAxNSAyMjowMDoxMyBrbG9nOiBhdGgxMGtfcGNp
IDAwMDA6MDU6MDAuMDogcGNpIGlycSBtc2kgb3Blcl9pcnFfbW9kZSANCjIgaXJxX21vZGUg
MCByZXNldF9tb2RlIDANCk9jdCAxNSAyMjowMDoxMyBrbG9nOiBhdGgxMGtfcGNpIDAwMDA6
MDU6MDAuMDogcWNhOTg4eCBodzIuMCB0YXJnZXQgDQoweDQxMDAwMTZjIGNoaXBfaWQgMHgw
NDMyMjJmZiBzdWIgMDAwMDowMDAwDQpPY3QgMTUgMjI6MDA6MTMga2xvZzogYXRoMTBrX3Bj
aSAwMDAwOjA1OjAwLjA6IGtjb25maWcgZGVidWcgMCBkZWJ1Z2ZzIDAgDQp0cmFjaW5nIDAg
ZGZzIDEgdGVzdG1vZGUgMA0KT2N0IDE1IDIyOjAwOjEzIGtsb2c6IGF0aDEwa19wY2kgMDAw
MDowNTowMC4wOiBmaXJtd2FyZSB2ZXIgDQoxMC4yLjQtMS4wLTAwMDQ3IGFwaSA1IGZlYXR1
cmVzIG5vLXAycCxyYXctbW9kZSxtZnAsYWxsb3dzLW1lc2gtYmNhc3QgDQpjcmMzMiAzNWJk
OTI1OA0KT2N0IDE1IDIyOjAwOjEzIGtsb2c6IGF0aDEwa19wY2kgMDAwMDowNTowMC4wOiBi
b2FyZF9maWxlIGFwaSAxIGJtaV9pZCANCk4vQSBjcmMzMiBiZWJjN2MwOA0KT2N0IDE1IDIy
OjAwOjIwIGtsb2c6IGF0aDEwa19wY2kgMDAwMDowNTowMC4wOiB3bWkgdW5pZmllZCByZWFk
eSBldmVudCANCm5vdCByZWNlaXZlZA0KT2N0IDE1IDIyOjAwOjIxIGtsb2c6IGF0aDEwa19w
Y2kgMDAwMDowNTowMC4wOiBjb3VsZCBub3QgaW5pdCBjb3JlICgtMTEwKQ0KT2N0IDE1IDIy
OjAwOjIxIGtsb2c6IGF0aDEwa19wY2kgMDAwMDowNTowMC4wOiBjb3VsZCBub3QgcHJvYmUg
ZncgKC0xMTApDQotLS0tLS0tLS0tLS0tLQ0KDQpCZXNpZGUgcmV2ZXJ0aW5nLCBob3cgY2Fu
IHdlIGhlbHAgZml4aW5nIHRoaXM/DQpUaGFua3MgJiByZWdhcmRzLA0KQW5kcmVhcw0K

--------------ms080304020100080803010307
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
DhYwggaoMIIEkKADAgECAhB+h8MJLtdm7y8h4qjQp5j0MA0GCSqGSIb3DQEBDAUAMEwxIDAe
BgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMw
EQYDVQQDEwpHbG9iYWxTaWduMB4XDTIzMDQxOTAzNTM1M1oXDTI5MDQxOTAwMDAwMFowUjEL
MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2Jh
bFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDCMARtKQ9xLKfbpmf1W2gT/EG/NiY1bb1tbWklnuOvMrA8mb8ZqQK/LQgiA5syzH1u
kVqrfRfWQQlmctTO4TX+GVyFq1irI5FUF4eW/lXRBFJdjh9pHR0KQiFeGgaSdnY7RtQmK2Fw
3UiwQAM2LNnUAkhpaxZtDi1gRiPK0R29+THPVa1fdKO15xlH73Asku3oc1riwL/9Ap2PJ+v8
2EMLNit0jMCyyhcWeni34dwzJBOuPSukPwqQ+P3qzL1rHN6AtvO17vCBMdtYF4kanSwqDsEC
74bRGTq147XI93vlqtsK99j81pFFAeTq2YbvWCkt0HVmE/0hw1jJ5MpciB8yHa1Ur0OdcZqS
xgLKLpaKwlrU5r6mhSuhfYRJc7qjTeVXGIDXHJ8byVTOlQ1micZWtSOEbn4x1jXr/pvS4p6N
kItuC7ocs+8jKp1Nv1eoXhdZYq744wOz+tbJDri/ea9JrS17lDm1yGbib0rQ970uUgoGT+Cy
B9o4ckOniFjHjChwOvwN4Jl7l3nAIWTGgZzVyQzxmgyClRzimCRATlKHFgyYps+81E9rlgXN
sW1wWflEyvUyO7yC3wnRz53FhyjaGLt0Rbf3UorEaG/swkFxz7THcUVOeaFT7m3r4KeQoyWu
bPJqh5WvJFO86IfgWdM0e1UpRgOwIzQIsN0w2CjGCQIDAQABo4IBfjCCAXowDgYDVR0PAQH/
BAQDAgGGMEwGA1UdJQRFMEMGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYB
BAGCNwoDDAYKKwYBBAGCNwoDBAYJKwYBBAGCNxUGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFAApNp5ceroPry1QLdugI4UYsKCSMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMHsGCCsGAQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2Jh
bHNpZ24uY29tL3Jvb3RyNjA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvcm9vdC1yNi5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5n
bG9iYWxzaWduLmNvbS9yb290LXI2LmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcN
AQEMBQADggIBAJGRR2vVogNGaQ0jmPHmCBqkZROGrQpwzZ3Oky7fXiYmd7zIpVfDN8oG2psG
NtQ0w4OcGSG9lydsdRK26vb+e3W0/d57wrI2FjHO/gOQjQ1tX3ckKFeKl+xqftiN18STm8jY
Wr7ClsYAvLJYGB/Lv1giBthYBMHXny28SHlQ7ySkamNj3nG/7TvRfcVi4bJ5nIi9qjbqY3zv
YW7FHFiE0vAYcjLfw30BJrVDcFM0pKsetmeBp2h8eCUblbdMwVHXUk4Q4BQeFSCltVW+AJiA
YDp1JfTLnPuTetdXKMU6zsoFJet0k8pp2mXi+pimEfv4/jSfMFFzEkeu/kV5eVOtv52uPJc2
NlIKbN+Q64Ko+ykG4nu9pvT/2h40RGCfPpIsKMspwNdsxspxFeA2EUGXM3g5QGqJ5IFeTzTD
Y3PHXYq82PvnxZq/E6xchtfRnHCjWHe7DvkAja/yrAVZc1yU7ypbZVeirqSKFal6K68OYV9I
DBEvHDAiOBS7Mb1JpD6k6ia5oLtBMpYwjSEvRviYQ+r0aw89CrVSbCRxgUn9ngj3cNm4pxeY
oya4A1NLrDHAgTDxDkxDrL19snEYQ6A6BgvhAio1QtvkJg+e3Yt6IiISeHxS6Hy1rCpKOdHS
HsG/mriaCjcvVn1BC57FSe1YP3q3ijSrWNdYvKumA/tlye4LMIIHZjCCBU6gAwIBAgIMMDAf
RsRVYvQ6rRuIMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
MB4XDTI1MDgxNTA2MTE1NloXDTI3MDgxNjA2MTE1NlowgakxCzAJBgNVBAYTAkNIMRAwDgYD
VQQIDAdaw7xyaWNoMRAwDgYDVQQHDAdaw7xyaWNoMR4wHAYDVQRhExVWQVRDSC1DSEUtMTE0
LjY0Mi4wOTExDzANBgNVBAQTBlRvYmxlcjEQMA4GA1UEKhMHQW5kcmVhczERMA8GA1UEChMI
b253YXkgYWcxIDAeBgNVBAMMF2FuZHJlYXMudG9ibGVyQG9ud2F5LmNoMIICIjANBgkqhkiG
9w0BAQEFAAOCAg8AMIICCgKCAgEAuwiiJULkYlbYWdaku5Xgl20g5jljQhIL+WBudGHnJMDU
x9yqy3HlD/VVEKxvhhLvw4OjHdZ2HYWW60tU1O1o/FMzOZQuYwlChx25mBCOpwWqKbzNdhQK
D4kMbFqvAcwc54tnIgUHfb6ONMcz2Fq+ryOGkk1ILky6ZKDMxqQ9PKVArDQaLo/0KUVtFLeD
VwxtN2cEG826TbKWeBuSmHVhpPrsRyeRu0y/5y8rdHxqoGJoBW0im/xwN8bsy6Lqb1COlhO6
7jO5N5D0NOovZqkU5mSfcoAAOR9ZasBidrrCQq5NiDIFcgmNMBqvP9SNygu0V/0g/QEOGLQf
yamU1T4HZnJ5aA3B7IuqvdTBnG4o4fyBQd2RJiFD2MbOQ3plmSk1ThyVhY+uPe9zI9LQqDbn
AOs2zWoM8jAhEu5EfGSAbTH7JxbojHFGdiV5XfNEMCpvYDaR7DvbilhT3VP8wvCpgNBU2s4Y
IGifFC3Istsm/7tizFw9KhOdiugV/MkZYPgkXcujuAJ9SdjfFiF7FzkL8gDqliqF2Bt+Jyx5
rBfEFCfJnueyHiY4fKRJHUNrWLgn+falKN/aYlwIPwnnRdChsTzVio1rxACFD/771wChbjt3
xiKkYYffnwoilvJiy8Byzvm6+D+ggx8/0b66HfPrbgjgtYuvsIsJLudgbrLBBbsCAwEAAaOC
AeIwggHeMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKG
Omh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAy
My5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZz
bWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwIwCwYJKwYBBAGgMgEoMEIGCisGAQQB
oDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNp
Z24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEXYW5kcmVhcy50b2Js
ZXJAb253YXkuY2gwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB8GA1UdIwQYMBaA
FAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSZ4EILHB+qVi0PaWFCbqoGTTq2gTAN
BgkqhkiG9w0BAQsFAAOCAgEApy32d2+MrKNLcJDLEE4W8N44PhbEf7NV1NMsIX2x5GLw+Gsz
OyJ7p5D71Y8tjMOs9RgyEH+3abc0ANbptE5wTPvLX2Veu09SQIZj3LhMdY0YbIwLNkL0OXvh
lo3U1d+7meM/Q7d7AJNDODbW7o1+cG0UfWa64AnNWax/hfp45lC8QT299cGV2K+/6YP0/e7w
UYdC/xeKTVaos/P4WXn87c3H2zmnvOvJhlMIz/YXiUe+hKzRpxwrl7aiPWCQULCaOgApj4Bp
sk7VkFc7d0oqKcL1Dcqq7rKHYc998nd/Oufy2AaCkqQ8ivR3rXc2AZ0eouXJVvzPhG6f1GRr
fHTg2CURS5Iu9ZkN9zTRjOQbKYQpomAc94r4Diz2/AQu52h5lfORStNnrTDDCylEKJinDgHy
YwXYp+OvEsdmxLd/FeGBtckTmYjEk32LhDh0kEyLEwNqvYpG2hVMxKwn/2Vf5G8vqjl5PsOS
UQ6mtYmJOsolzIgAKwRTUV7eCgB6UQ4KwIEo1Jn5I8wq4nHhr+viDsVtVD5I9C/kNhuNUOcK
YKwXEUzwOXUumnR5uonvMY/dae2TTcmfNk5GnPFvfo8fy6M+q/uzC+DEc6QLpAqfK6xVMgib
k5rI14Nn2CKUASJw90SMnwCZsrrrL07I3JZ2NNQLiJaogaXl7SR+/wFRtIkxggVdMIIFWQIB
ATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwwMB9GxFVi9DqtG4gwDQYJYIZI
AWUDBAIDBQCgggLMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTI1MTAxNTIwMTAyMFowTwYJKoZIhvcNAQkEMUIEQMhQktyxoER+q+syWP7yrVCtfm5AF1aZ
lFcoLvunNwiHURAjT2LSWX3IP0TnZjeRbIsrovpHRTYq5eBb+TA6iYkwcQYJKwYBBAGCNxAE
MWQwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UE
AxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMMDAfRsRVYvQ6rRuIMHMGCyqG
SIb3DQEJEAILMWSgYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMMDAfRsRVYvQ6
rRuIMIIBVwYJKoZIhvcNAQkPMYIBSDCCAUQwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzANBggqhkiG9w0DAgIBBTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggq
hkiG9w0DAgIBBTAHBgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFl
AwQCAzALBglghkgBZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQME
AgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgG
BiuBBAELATAIBgYrgQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYG
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggIAh9d7pdimLWcM
B/3fonzt7SqbibfCVzgDVcN1WzRoh+nIZt21w+kmLS6ytsOES+jfjS2YRh7GURdUX6xUQ+Iu
KEWMBGYSVE/z3U7GS0QqfyZfALu9AwUm0H+nj1r76kepXJC6ASrbx0/3tVE+YoPvDtIz9nxE
OcTGC9G9FJRvhupzONexmStTnCK8R/xR1XKcjJGNsf3ZmiDOGS1nqC8jXBR42ah4lAafvqRR
X3THYTTRRQkU0C4bPJOsKOyQnGuE/WyiS2X3tmL6BXKSGjJQq+3CtfO/FJsTq4sThp4VnUZ0
+sbkW5G9R617GxR81ynaZuU1TEGDUKsGFYvGRYgKGcvEBw0ToC078oQ3pgLx/GbyVTgmiyZy
Wm+70JIVNkPogyuyk0fa2P+vVKgEQICvpget7bNkYlc6ZFxoaf/UdW74ynJiR5bO4LVjD/j4
q8QcSxSdxeYmECy8K5LcCvRNb+U4ngt3QSonoL19iv7NlNd1TSgCL7r1hgmTEHW4DnOPq8cr
q5+bxXTdl9l6pTeDc41TyoNwRSH/qcIye6o0w43GADV1E8hHDWKl9XNkC6se5pKzurNgmMy1
vuEw9tfbr0srbemwMFeZ9VawKy/FYKsfsN6OGk+nqtrKJF62Cmhq+3mYPcIWQpE2lDZj2Vl1
71jiJAY2v9pRueiuFTpmrOAAAAAAAAA=

--------------ms080304020100080803010307--

