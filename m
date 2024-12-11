Return-Path: <stable+bounces-100561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752969EC6F8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1B1169BEC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E11D63D6;
	Wed, 11 Dec 2024 08:21:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FB2451C5
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905281; cv=fail; b=JUNz01YKUjgH9DdKaG2OzYh8NeE0KzXPf+dnq7zae4jgVDkIpB7oCFabgxiR8aVf5jy11fJ8/fyTsYV/57cnqT7NJ2gJ6JnS+vEnsXpXlt2TKk0o57XQ2/Z+v63MhbpWGJmUjKQU01UC7byD1lkRHAC/IA6TR++sT+OVFQi6a+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905281; c=relaxed/simple;
	bh=CJDqlF0IoOBLD4KFpuPjDHY60Z5Mk6ZgpSnoPauFH4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4U1UCvQ2aQvyTqcymC8ujijWlp9FsDJqGWqXujWO/ITSHn8CUL7wx3dPwxNtNhJIUUDMsF/+FvCtwlgGB4fYktQ1l6ZdxAqpwqCY/N41MjCtSCMMENYFQFf1TpxIm5nJK6SbN3H1ZlugwIPiTJfU4uhXre4yaRT3hvjjK1okOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB77GCg002260;
	Wed, 11 Dec 2024 00:21:16 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1uxjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 00:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIUi9ixmi/Gz+I8/yB5EdHfU1rPguBDbd7s480UB3ic3Qj4CaFp/BBDnuphWLhjwfadcXhXP73w4QBn954OaU6GAygoGRNGvVbY0fo1eyWyTkYhB/mFe0zjl0D1PJkZIEdGANXcGFM81VjTFBav0wGLoWWVBNA82vsXJDloDhwA8DnyVo3KG71dsRrZAdsdbsXyNpftdu+9Z+RYaCchWb46EVaybIOi/+Z8QUGrsHjyT0aJFQOIHs4T+jKDNrQ3O8I2pBkbDuxrVylPL5YtdoivFIX68gcp+pC9LaH/26q1pmfOsyYOvNM25U9WDgNMqzlFBB6bVC1mpeTjGMBS5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJDqlF0IoOBLD4KFpuPjDHY60Z5Mk6ZgpSnoPauFH4g=;
 b=FnSuMmce8ZTWJQ9z7n3ICDHR/WafROjeZmHMgXnpzUOR5CExo2/MpJpDGk4EU1aMN7ZK6pXa6rjkLDAJhSnPAfRCaBduF1DGpL9ifI7yBMT80l6B6g9izrH96S1Y9wGiUvUIpeFd/QH+JD2Y1CAgT7E/7qHoFSXzbe5jvigEHdCkD3sG1j2lJkJwvAe66UemgTBb7hBUu1/6nlXlt6wVcW+tt0vo56/Pi8nJCCSzSndu9hRL9kiA6cZBINmcri4C7x6rIcC4z9+FlDkpWmO6qwan8VCK0u6LCZinnW9if+APez0lL6UHGKu4EveWs+b+b10Id5rnXDL3xJTobSCDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:21:12 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 08:21:12 +0000
Message-ID: <84d56ea4-d239-4eef-8808-2f4260dc0f0d@windriver.com>
Date: Wed, 11 Dec 2024 16:21:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder
 vsi
To: Greg KH <gregkh@linuxfoundation.org>, bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, irui.wang@mediatek.com
References: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
 <2024121140-valium-strongbox-04f6@gregkh>
Content-Language: en-US
From: Bin Lan <Bin.Lan.CN@windriver.com>
In-Reply-To: <2024121140-valium-strongbox-04f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9e2cc1-53a9-4413-661d-08dd19bcc5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NThzWnRkMUNJeUo0R1ZNOHNQRVd4bzVkdFYwcFE0bFpQbE5TOXArY2kzeXZO?=
 =?utf-8?B?OFNFMW1NSkVPQjZlNDJrYmhQOW9nOUUzclhYQ3RUQVFNNVNjM21rNjRtOWx2?=
 =?utf-8?B?SzRJYnhITENqTFhwWlhPTXA3Y1V5Ym1lVm5HZzBQWmROR08rdmdzeVdwRW5j?=
 =?utf-8?B?VTJrVXhubE5SUmh3T1NXTFJnODB5WU00Y0ZRRDZhU0RSUVFoK1JPZlArb3hq?=
 =?utf-8?B?RnVKY2RNT3VsQUh1Kyt0TzNSOWM5aElocEQxTm5uVzNibmRFZkkrdFFzYkZi?=
 =?utf-8?B?M1dzNldHZUV6NjJQdEJmVWdVV3h6TEhNQmlzaFBvQkNXeVphYTJnVHQxODJn?=
 =?utf-8?B?V0drRnZYRkxxNFczSG8vZ1FDcnJ1L254eGhVTjVaRm1HOE5xQVBRUUwvQi9E?=
 =?utf-8?B?SWRXUEFsdzlLVXNEdTM2RDQrRDUyb0g3cm1lSEkzUUJ4SUFQenhsckFIeDRo?=
 =?utf-8?B?K0paSHZBQUxkSW1UaEdlOStMSzN6eXRScG5vKzdMeVUyaUIyaXpRb3d6eGZN?=
 =?utf-8?B?WG9Yd1dQdUwrdnc3Uk1Za21leEVvckk3Y2RGTVd2UDNmUzdwTVBPNEsrd3RM?=
 =?utf-8?B?aXZod2xseHN4cXExbHAxZnVQejFwVVBzaEtZWHlZcm0yZ2x1WGc3aThGaGRB?=
 =?utf-8?B?L3FhcFR3QkZmdm82Rm4zSU1pQldtcTllSTUxUjlFMnJIclF2ZU5rbzB2eThs?=
 =?utf-8?B?S0lFZ0JJMW9LcnZpQi9RZHNDYXo2M2RteTdObWdvNUduSmVYSFoyWWswMW0w?=
 =?utf-8?B?K0lWOWZSTVExd25IVVlNNXM4eG9jN2dTcWVma0FWclJSamVZS3czK0tEa2hQ?=
 =?utf-8?B?cmVTVVpKalcwWlRpaHYwUnhiMkp1VHZYRmFKSmErRnN4UmhzQVZ3Qk9kUjNi?=
 =?utf-8?B?UGQvZ1MxME1aZjFFTXkrQkxTMU9Dc0dScTZHV29QNkU4QzBhNGdtamp2dUkx?=
 =?utf-8?B?eEdBRVA3ems1cnZiamdLM2JwZXFuREJXZ2QzSmY0TnJsVktoMElWVFBzaDFH?=
 =?utf-8?B?RkpGTEpYNDA2bGs2WTZtblZhYmZqeWw2T3A5RmdQMHQwekpJQWpCY0toYitW?=
 =?utf-8?B?QUVrRkdyanZGcEtWRkxhaDQ2TmZOVmJmK1Fqb3IwT2pIMGFrOHJrUGIwSmhz?=
 =?utf-8?B?YmN0d29HcndocDZPNDhwTTdIWWtHWUx1VjNBOG02VVJPblhJWEF4NmVCOGFC?=
 =?utf-8?B?bTJlcTlhblQ3L3dHTHJ6SlpLVnZZRU1oK0VNNm9jVWZxYjFDQTcwdk1hTnB2?=
 =?utf-8?B?aVdWVVBVM1JDWHc3TXpzSlA0b28zS1hPWUkwOUFLTmNWdTlQRVQ3NWpFdldW?=
 =?utf-8?B?ZTVub1FldkNYM3A0RFgxVUlCNHk0ek9sbEU1UHUzZU56QmxVNXJlRU5lVldH?=
 =?utf-8?B?MThTanVPcXFCaVBwVG16cXh2UU1Lc1Q0bGdlcHpiYkdYcnh6RUkyaE8zNzgr?=
 =?utf-8?B?OG1xbU9saXRzVEMzVTVSaUxWVS9IVE42bC9mRXhZdDNMSTdNQkxYV1BKLzZr?=
 =?utf-8?B?VUxJRWFuQ0R1aEFJMWNONEp0UVczYjQ1aytoUElmSWg2MDVuanFSbkNZTlVL?=
 =?utf-8?B?NzVLSEtLU2p6MFFuTmZiaW9QTkFHYTJsaWlsQU90MC9hZVM2ODRWcThZOFVz?=
 =?utf-8?B?bitEbTZJek9kNHV2d011Q0EwZ0JXb1I1Mi9OZU8wVnhRMkE4TFlqQnlzbUc2?=
 =?utf-8?B?SzcwNHBqK0U0ZjFFS3Yrcy8vZDRVaTArNUk0SjA5NWVCOGtZWTNZRFdYWkZw?=
 =?utf-8?B?Vy9JUkJyeTltMXoxL3lTYzQ5NjFTSVV5Vjk3QnhYdy9RdjZzODhtS0Y2ZGpw?=
 =?utf-8?B?VThFL0tzRHBFbTR6Y2NlZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdTR1p3TUE3RFQ2Qkg4d29YWXZqWVpraGdlY2ZTanFsdzNhbEIwdkxXVDRM?=
 =?utf-8?B?YnBlZGhnQ1VwMnJ3MUsxYzMveDhEcHRIem9GaVNUL2NqSExOcTQ1eE0ydWxl?=
 =?utf-8?B?c0lsUkpFUjdYRFFWZnJ3Sk0zNENwQVZkQzBibUpRbnNVYmw0QmdJR3pjM3BX?=
 =?utf-8?B?MlZWU2xzbGFQRGwrY3lMcW1LQ052SGo3YmdxRVR3Y05IVjRzUGxYUzZ0anFX?=
 =?utf-8?B?MlllOWpzSTRoVSt6T2VqOVd4Z2ZjYVV6WUJidzNSNFFNa2VOTkVqaENqNGNM?=
 =?utf-8?B?dUt5Q2xSaUZmcGtCUVJLZWYyZlB5RXZCRDB2NXNWZ3dDZmlJTTIrays5QVZs?=
 =?utf-8?B?TjkrSm1wY0c3cDZkNVpoWHVXNTdjM3hCWnpzSm1xL0RES1UwVkFYZWJocWM3?=
 =?utf-8?B?T0F5eDVCR09GYW9zMW9zQzZ0b2xvdjlBb2VoR09sdGltSkdjVXFFY0N5Zlg0?=
 =?utf-8?B?RkZoQXFKR25jdWVLMnFuVXgzbFJKdml1ZHVWZlZ4L2ErcEtkaDRmZjNiRVFa?=
 =?utf-8?B?ZVR6OTJLK2xCUTZtR1FQOStvNENFR1RlRjhaOE50NTJpMHg3azFvdEd2TmZ3?=
 =?utf-8?B?OTdSOUJiQTNPNUw2aWpHSEIrOXI2WE9Tb09JOVNRWWxZWnVTenVRQ1NzTTVQ?=
 =?utf-8?B?V2xGRmpibU1aZ2szNFBTSVpXMkJNT0NUWi9DKzRvQ1BEbG9QZFhRNElxTlNz?=
 =?utf-8?B?RVBWZDdYb3c3TWR5b3RncHhzVDMxNkE3cmlKaktEMi81SVdvZ2ZobTRmcXNJ?=
 =?utf-8?B?b1V2K2hSaU1QRGl6c1hBK2MwWHpaL3ZXOHJSZlVZMFc5TXR0VHBmL29kM0F3?=
 =?utf-8?B?ai9vOUxvSXI2eEN6THVkWnNxSExMSUwrUFJPdkIyMFFJTDhoNzFHa3lwMHRv?=
 =?utf-8?B?ZU5heFUyWGNlS2hEcmlhejlCUE4zS0pVdHRkQ3BBcnF0Z0d6YSsvV0pOUnFU?=
 =?utf-8?B?MXVHWkFtVU9QZWVJOGJYMlUzS0loNUU4TVAvOTQ1cUErcVFmbXFUQ1ZpR3Rz?=
 =?utf-8?B?c1NnYmN4WWxSNnNDREFxNk5EclFPRG00WjBpSEZyaTd2YlptbzRPZnNNR0JM?=
 =?utf-8?B?UGt0bDRBMVJjeXRlN3QxRi8zSlpjZlZxQVdlemR6TVVtSlVySzY0ZnlMbmpD?=
 =?utf-8?B?NkVUMmZ1TndpUDgzN1Z5NFcyS0Vndm9FZmRlckpOMXh5a3QwMXVUejMvNWU4?=
 =?utf-8?B?OTJMK1JueWRnT2tmaWo0Y3dldU5UdCtxSjdkbGQ0MlljYmxSK1RUcXlyWWhR?=
 =?utf-8?B?Mng2TW5qTkNGVGVYSEIvWlNVUG9sODFaalIwMVlLeUdnSDNmN3RDZlpTREZ0?=
 =?utf-8?B?UDJxR2J4NDNoSC8xQi84c0t3V2FhdHYvYi9ZMnRmVlNTMTNSVFZYakg3OEFa?=
 =?utf-8?B?clM4VmdRY0hTa2dpRjYyVXJwbXNlYUxISWUrWTFNUW81Z29zVDl3TitjaWdu?=
 =?utf-8?B?a2hNWDRJRVFPRmlSSWNIWnZKQ1M2eU12endCUXB3NHZ3UnpqaTRhd3ROT3dM?=
 =?utf-8?B?MTFWNGdvczhPSVBuQjNMOG1jQ0FjWTgvSWMweVkzS0drZG9Sd2FhNGNKWlg1?=
 =?utf-8?B?TTBOWkpMYWo2K1Z6dG9lNDZEN1cvK0xod3g0bWd0OGwrZUhxTG5xUFcyUUxh?=
 =?utf-8?B?ZHhONm9TZEl3d0g0ZjJxUEhRMFNtUmtMSTZBdVI3ZVJMVVo2dVFRWkVzSXlq?=
 =?utf-8?B?RVBaSXZVWjVjRjdETGhwS2tlNENUenBwUEhiMzRZNEJQZVR6ZlpXMzZrb24v?=
 =?utf-8?B?bWVUZUVmVHcyTmlDaFdTdHZ4dThZSXJBQ3RVWlRvZlBJbWxkVzZJSElXc0tj?=
 =?utf-8?B?UEJtcEQ5MnNmZ1J0Q3RoY051Qm00d0F2eVE3VEV2RG92WnFRYUJ5bjkvUVp1?=
 =?utf-8?B?Q040TjdnbEJ3Y2paKzZkbjV2eW9ZdE9VSmk1My8xKzltdkpsUFR3cG1xZ2J5?=
 =?utf-8?B?OWMwRnArT3ppSERkK1E0YWNZaE9wWTRlL3dDK1IwelBOamI3WE5HSGtoWTd2?=
 =?utf-8?B?K0lBeEJxc1NaYkxwQ3g3bElVcUVoR2RVbXRKQjlMWDhlNnFQNHlURlNqakRV?=
 =?utf-8?B?dFpldzBHbEZtRGd1SlBCcG5URDArT21uYk5JVUU1ekpNQzhrdnJ2MkpmMFRj?=
 =?utf-8?B?Ym9PV0R0cTZMaFhXVmF1MW5sZFVncTBuZ0tMUlZYSWJHclpsWGVCck41Z0RI?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9e2cc1-53a9-4413-661d-08dd19bcc5a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:21:12.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjaSNMxyfMQ2vfvVVSUmE01Ax+56BxZBA1gEHn7BQeHmnMMd9fZxAQGoExdthEIPXwvJS+jEB5gIbd9V+rJbqvJFoQylHzs92lOjXfmm1PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-Proofpoint-ORIG-GUID: jey0bnU0oHBwFPW-glwR2Z-XRGa2TDqz
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67594b7c cx=c_pps a=mbHLYBybxRkByWxHAZWYkg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=YKb-T52o9k0JLfAW_rQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jey0bnU0oHBwFPW-glwR2Z-XRGa2TDqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=608 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110062

V2: Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1

On 12/11/24 16:13, Greg KH wrote:
> Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1

