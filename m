Return-Path: <stable+bounces-200170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48CCA802B
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 15:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 172D1301B7FB
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAF224B28;
	Fri,  5 Dec 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mrkDLQiO"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BA2E6116
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946006; cv=fail; b=d+KzHJHWV2ZlzUrJzUxy9U4U+fQJTwHe44Os2S/mw8X7dl7W4DKVvfOVmqdvu2NXFVmFFuBajsGvesGkNVXUzcTazKjhK/rfGCHWG36top32F64QwdVdnl7RcTpsbbON3EsoMHViFxb2j9JvTNMKjROyT/kzUKaHeehGaB3uWLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946006; c=relaxed/simple;
	bh=szhzdSDrc0rD7qHqWOE/z2w1kf7aHJ0/jeGbyKa3Gbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0eTGX51LKDwt+hQ1S0cHQ55COBaaUxa8iLiK9c5wElGzKpzHx0NerAHAn6m40yYHPA/cjWtyRe4+liYALhxyd2WhzcpyoJlDPVsG0wbAYNPacz3MEudgzv6r63KFksQRqsvfFn/mbxhDZ8IcWxwvhZhOegx0XQ84RdQmYAbiYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mrkDLQiO; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOtuR6kHkvXREpATZVJte/HFQQfaXBDYn/bXg91Zb/zDKbKur1yLYrCXl4OzT/F/RV6S4jEwcAFU4sQTMDjjtdtJrRFYQ8owcioCjsdG4OueJd17NxwHBKMxDkZSjxDPhzw1zd0BsW2d0OUHiNB9YeYubxzewJPxI0kSzQvVZQPjwHbrehFZXgZbG/sG7wassuq12lQFTqFmAQFLK/RJChIflAslPEpP5ur3//qoigpJYHbVGgi47rDRPqHs29JPt290nkBEY2fgEMlxCobsJ3nMe5Kwidz1fMhKivRTguioOsGYjeeMBbpOpJUZyN+XQrsbN/qaKjCr+er0NULdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ejAFd5SeIxbh+0hVs7le6TA1gHFhBEFlNuEkwvmxP0=;
 b=NDiJSscRQuvNhoMXW7RagQz/ZCuRXLek3wFQZWqV875JdYreAGrbMwMg7WBtnCl17WSM77bx2aG+xCzM2AQxtjRvJ1qKe7iBwOQVxP2M+Ix57F7oViIKb+85OqDLJ5kknE7YbrGNGg/psU7YyTsxvOZnUA/QBP1DiHIke3owEtsoHuFQzQvZRFh7xhmjjcfgdDmdC3gSWk06cECM1SarlpTlaD3jYjIkCqKGDNd59HqcvaTl2hIEN/gJcesf7CG+uhdU5NKpmoelje5UAc5dvhKy38Be0BWW2Y49kv4st+5gPWz8TapVowgHSW+kYXkm7aFtqoFKT1mokSwkvB7FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ejAFd5SeIxbh+0hVs7le6TA1gHFhBEFlNuEkwvmxP0=;
 b=mrkDLQiOqp0NgCsoFv6Te8zBILJnwbEaIEYD2RfnsAEySDSoqxVQr7GQAMuIMvo39w+4hy4SuiJHifMI6kzSrh3HCkTezIyCLE8Zs3X1NxRHEATJrAe/n0fKqrFE6R3ZOOi74d8Gb8jPUUsEbqLI0CztqTfMIotTmVdVD+WuEG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 14:46:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 14:46:39 +0000
Message-ID: <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
Date: Fri, 5 Dec 2025 15:46:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: fc52c25b-096d-468b-a3eb-08de340d18b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1pHZUtTc3I5ZG53R0NCVmk5bjhKeEk5V3luYW9INjBJOTZjcU9acjNzMmFa?=
 =?utf-8?B?ZFlndzRDT3pDSzRBdkUweUREbmErZHpDbTVnUjRVRjhjcklxdlJsY2lJeWVL?=
 =?utf-8?B?UW1SdGY2RWZKeHRGbk1WQmU5ZXhBQVZNZUlmeC9jb0I5Z09LKzNyajNNZi9x?=
 =?utf-8?B?MFp6TFZOU2R2NThGcXg0ejhweFpoMHRLTThoQkQ4TjVmTGcyR2J0bW5xdWp2?=
 =?utf-8?B?QWd6Rit5RFVzejlFTHovWngyeUtDZkcrTk9MTVlHTEtyVkJKN3U5YmdCU0cz?=
 =?utf-8?B?OFJUMW53UWFRdlJCZDAwaXJ3Rmp1dmh3WXZVenQ1QUhzbGF0azVWckkweE1m?=
 =?utf-8?B?d0xONHRrTjM5RlZ2ckVLaDZ4RkgzaStMeUluclJYaENvdU4zKzZQZ205OEpF?=
 =?utf-8?B?SWh2SmFKN1dhZERJSVFzb3Z5VGVucDd0Q1gzRDVUbjZPMUx1Q0VqY1d1dmhm?=
 =?utf-8?B?bWFKZHB5cGFZZ1Y2aXRodzVnYmlZSHhWV3hDZXRzR2dQWGoxc3lxcTUzVmJC?=
 =?utf-8?B?ajM2RUxLSms3M3d1TlZmUU56ZHVEUzc4WHNIZ3dWak0vUTQzalAxNG5PUDly?=
 =?utf-8?B?THVKVVIvWW5qaFB2N2dSYi96dVdJanpoVytJaGVEMVlBaURJOGhUQVNINVJa?=
 =?utf-8?B?emtXeTRxbkdQK3pKcEtZS1FvbDI0QS8vVjBlbVpLQUhaQnQyYUROSlQ0OUZk?=
 =?utf-8?B?SDE4emlnQ0xEbFR3d1hwNjk0cXhvRW9VOHl3Y0UybVM3TFlSWEN4QXh1cHEz?=
 =?utf-8?B?REhMQkE1Tld2WU5iNit3ckx2WVZRa3MyWThaT1dOWlFmWFN4MDRWMHFPR1du?=
 =?utf-8?B?ZUtzUlJ3OVVrWk4zNmNzVDVOVDcreFpEWlR5VXlqY2ZoTS9VeVU4UGZDOXpN?=
 =?utf-8?B?OXFTN3h3Y0Y1RGcwczJiYVhRVi9ZRmVGdTVrazFVaHkvTU4xWGRTTjhBdkdY?=
 =?utf-8?B?YWFHUWt5MXAweEhwOXNnMGhkcUp1RjNlTjlvSkhWS2NPU1RTaTArT2Zaam1o?=
 =?utf-8?B?SzFvYk5zbEZud25PdVBxRElOL0ZtaG5mSVlONGRkZG5MSkh5YTVqQVpzNEM2?=
 =?utf-8?B?eGluV2VPVGhDSGp2VWp0WTJVQTJVU2IyMVBrRlRFODgwLzZUWFU5UDJxTk9O?=
 =?utf-8?B?eWVDbFNtbktMOEpGWC8xQ2R4cWJuck1oOGdxZzNNSlVCTmhMT0JHb215c2to?=
 =?utf-8?B?b1dqNEhEbkZSTGNqcm10N3VpbFdNYU8zSVpqNmUxcm9HS2U4RTB0cmZ6Mmwx?=
 =?utf-8?B?ZzUxdHYyVmY3K1dJa3VWNVRFMUZuVDdmUzlyZTllQUlGbjBvMyt1RzZZYWNV?=
 =?utf-8?B?TE1FMk00a2tUaGpUY1Nta2ljU09tRzNhbVd1eUFqNFROdjlYRjhJOGdZaWRG?=
 =?utf-8?B?VDhWU3dQSnhDaWsyRVpuMldpc01WMnhTVVpUc1ZXeTBLUVEzVGtJZWVna0dF?=
 =?utf-8?B?TTEySlczQVBvMGtQR3AvSk4yaGJhandYSHh0ZXkwcW1KSzFrN1ZsdEZjcEdn?=
 =?utf-8?B?L2FZT20vNThwQUVKM0l4K2JRdndaRVFxMzA4QTFNclIwZXZaK2VJeTN5NzdH?=
 =?utf-8?B?WjlqTk9IQU44REZzb3Q4aURXSmdjLzB0V3dHTERzNzg1UGdKbEhuQWpPQXI0?=
 =?utf-8?B?VXJrV1EvT2xJWnovRDFyRXdXM3VqNXRwTGwybEhPcVRsdDUzRVpPZkhqSDZD?=
 =?utf-8?B?eTdEM1k0L3lDSWxGMFV5Y2phMVpuZXJ3NS80bWl0ZjQvVWdxcGZlS3ZZZDFL?=
 =?utf-8?B?R0ttSE00dVQ5OXArYlhSTVFQRnJaMGo5NlVBcFlYeTQrWUhUdFdKNHFHVE00?=
 =?utf-8?B?N3NiQnorNFQ1ekRHZzBrdkV5TTB6eUJIVVhnaWZMTjA3Ti9wcVcwSEJ2Qi9n?=
 =?utf-8?B?SGNWcjVzZ04vTFdGTEx1M1M2bkpEMjk3ZnM5emowcGo1M3JacU5odTJ1N3JB?=
 =?utf-8?Q?CuFlNq0pagDp0i8psAt4IdByHT9AmhGx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWM4TlJiRzFVc014Zytlamtod2JTV2pDblBZVnRTTCtUMVhWdm9ISTVLbXBV?=
 =?utf-8?B?cE1UVjhoSm5odHJaVjFzN1JSUUdiMDQzc0hzMkkxa0lFaUkzM1daVUdQNjN6?=
 =?utf-8?B?ZTJ1UnBBWjQwUEJBUXRxRHA4bnNuNnZuWDllYkdCTldyUUlPZnhVdkNzM01H?=
 =?utf-8?B?dGIzaGQyRi8vTGRGa1BqTlRxRkhodG05azRXSktjV2gwdmVrQ1dtK1JBVkwz?=
 =?utf-8?B?YXpDVHNOOGJyelZpUkxOanltbHJPcXRQOE5NZStBSGhQZGlHNGhvcy8zemRR?=
 =?utf-8?B?WGppdWhCYW04QmI5Tm1xWURYZzJTcmorU2cxdUNRMGhtcGg1eXV6RUp3MUMx?=
 =?utf-8?B?TWVudWFnd2NBQlloZmhsYkxqV1FzbmtCMVJMVlRRNXFudVdVcGlJS1JZSWV5?=
 =?utf-8?B?Zk9sOFVzTmVzOFZ1N1Jnbit3TkdUQ0FMZGZBTlRCMXRyTW1ZMENMLzNYeHVM?=
 =?utf-8?B?OEozeUdMVldzZmpiVllhWnB0M2VpOEpxUXNlcnBJM2tGUkpSM1BTWHM5NjFn?=
 =?utf-8?B?ZS9CYmQrdUVyOHpFdElFRlBMYkQ5SlJxbUVlZHhWaDYwODFjeFQ1MTlTZDdm?=
 =?utf-8?B?Z2tvYkJTWnp1ZGJ0UzBpK2VBY21IRldJZUNlY2tza2hLU2RKUkFZYTZqbGZD?=
 =?utf-8?B?QytpcGlOSDRUaWVGSm1oVmhISzhtUEVvMlhEUnNWQVd4UWQ0UFFmRFROdmtE?=
 =?utf-8?B?TkRiQmlBQUsyMjJVTkM4M3pUdERTR2tuZXhoRndsdUk3OGhpR2FzM1kxdzVv?=
 =?utf-8?B?V3Y2SkdoYkRQWEhqRzIzRVcwUXJ0MTdhdnB1aGlybDV1dHUwZzlnSDV5b3Vo?=
 =?utf-8?B?di9kZXZXSDBkckNCMTZ2M3VzS0RtYWRTb1c2Tmd6aldXZXQ4d3FKelcrdXdC?=
 =?utf-8?B?VS9PTUltaHJJbW5Ra0YzdFlTNElHTjVDRUZpUEFjZm10YUU2VDEvcDJmQU5D?=
 =?utf-8?B?M0hmVFZBSjZYd2F5OURYR0k0SGdoWEs4b1Eram8xWjJnUC9mWE0rWndSbmpJ?=
 =?utf-8?B?dTBpRjNrblRlNUEvVmo5L0xETi84bjd3bFBBOVpUV2M1dkNoZERiT3c2b09Z?=
 =?utf-8?B?aFl6QTNVOUwxV25HTytLTXNSaWFTQy9tNnhkQWhNVzhOclVqM0xBeXB2T0lY?=
 =?utf-8?B?WTRVekVpV01qUHBTZG9VZnY4bzNGclE2UkF2RVZobUk0NHYrdFdJamJCRWR0?=
 =?utf-8?B?cmZJdVhqQVNUcXBENytHY2gxYVg1YXQ3RjV5RG05RXgyR1VYNTgzRjloN25s?=
 =?utf-8?B?S2l5djlKMWZTZWp5SS9sVXFDY3FWL1lRMXd4Qmc2am54clI3bkYwcXNBL2VW?=
 =?utf-8?B?d0JrUHVhT3haZGNxNFAvbTgzL2JEWXRSYzBzNEdWQjFJNjl2V3hScStHdlM2?=
 =?utf-8?B?T05zZVVlRmdpajByamE5M3ozSEYrQ3IrTU8yUU1DOHQxMElPNDdWWFg1ZmJm?=
 =?utf-8?B?blJXQXJLSDZ6ZTcwWjYzT0pQUmR1V3dNdGt5a21pd01GTDArc2NRUHY2Tm1a?=
 =?utf-8?B?eExiVlhvY3RTUGlKL2RZdWNveWNEMG1mZmlNeUE3ZDN4Ly9NWGZ2UVp3SDcy?=
 =?utf-8?B?OC8vRmp0Qzc2UXRWZUZPclJCK3YxeGVOcnh2dGtBMURoaFg5MlNORlRQTHpN?=
 =?utf-8?B?TU54dzI1amtJWmJjcUN2blFUZHpHUENhUDdLcFpaUlFaN0xEemc3ZFJPeHNN?=
 =?utf-8?B?MG5xcDZXaTJQVHJuNFE5OVlSNGVBWjVCdGVKZ3FFQ0VsSVpOQTVnQmVsOUgx?=
 =?utf-8?B?UUZJdmEzUHRrWnZqUUxjZkU2QktWaCtxaEVMbmQzbkYvRUN1WXJlZlBRNE82?=
 =?utf-8?B?YVlweGI0MEFHckh0NlBVNlVzNytpZXYrUVNXb3JpMGIwcVkrOFRPOUE0SDJs?=
 =?utf-8?B?QjBaS3hWUHN1L0NPV2pWUGQzbTRlbStVTDRGMUgvbUtTSVh6SllQMmJ4eEF2?=
 =?utf-8?B?Y21aTXNIYVNwUHUvb0hRbThXdHJSV0FmcFBxNTVMRDNsYnp0dktlanFMNS9W?=
 =?utf-8?B?Mkt1U2l1U2hDT2pUV0JBY01vbXRRam1Va2xldE1pZ2VsTU1pTS9jVVJHbzJI?=
 =?utf-8?B?TWNNRlJRMm84Zm8ybVA3cERoQlhNZlBjVDVlQXIwVjI5c29kZWNNMG9iZDhD?=
 =?utf-8?Q?hVtVsX5dCM2yOQ6T/jut7B9Wf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52c25b-096d-468b-a3eb-08de340d18b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 14:46:38.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9J3T3OXL5HRsOLHR5gODMRgKANzSZLMsYKYJ8VdcJYA4tJ2RI5Zxwcaod/nqlp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705

On 12/5/25 14:40, Tvrtko Ursulin wrote:
> Drop reference to syncobj and timeline fence when aborting the ioctl due
> output array being too small.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: <stable@vger.kernel.org> # v6.16+

I need to double check the code when I have time, but of hand looks legitimate to me.

Where are patches #3-#12 from this series?

Regards,
Christian. 

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index eba9fb359047..13c5d4462be6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  				dma_fence_unwrap_for_each(f, &iter, fence) {
>  					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>  						r = -EINVAL;
> +						dma_fence_put(fence);
>  						goto free_fences;
>  					}
>  
> @@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  
>  			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>  				r = -EINVAL;
> +				dma_fence_put(fence);
>  				goto free_fences;
>  			}
>  


