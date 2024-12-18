Return-Path: <stable+bounces-105246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA69F7041
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BEE18842D9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C331A238B;
	Wed, 18 Dec 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZXKmbH6N"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B245005;
	Wed, 18 Dec 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562034; cv=fail; b=RQp2QlsEU4mN1FK8kgkjcjCymaTfgw37HaOvWEp7S+1Y3TVKUNL5NaIl1sAhWXA4zhrnMO9af2Ylx22joaIWMz0cfrlJc18v6stol5ZxFS9pPQnhEZXMplGKlbTj++WGBIZF2b5iCxRzV3sySnNNUH0zHWUVr4PMLJYYHGRcwfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562034; c=relaxed/simple;
	bh=mXgV50vpoW+xmAIcDlS5RqMcIW3vqnc20kHSrMWNhsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgQH3T0XWJ60IgjT4nZttcIvTwcL4rrTw0RrGotqhfqK/FzkcU15p/RjWI6DH5iAZX+Hd/0CyjuI3GdQbOPqbt/yjOPit4xWLG8NSvBfAErMzABP2Cp5fIEHa9PQiK2z6i6LPqLU3yMgykXRAFVfdgV68qpmuY7Y9uYHmfd/kcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZXKmbH6N; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJs9BiveQ1Gz8k/QstyxwQ+vLcU+ZApdHFcesUFmpHVBblX3gpb3sz3xZS9gw267XiN3Sdcxd0hKcxxHAItjZrTRy149yXP5rJdghtGmyx2iOMaOQDveoxORfMx7jR7u5NxEzyxZNM8ye+NEm+NpVWGf19cj7N+NIQ8M6tc04037ba/2Z0umMl0KhkBgntCAmixsv2hbLhJCrEF5HPf2IspEvw6WD1U5nnjt50oLIgELTZ7M+aqTf4acvzMs/kq/QKsj1f8Q1BdRDpugxkxr62Gf7TchgzJEnKeQ+OJqbaStF9kpD5LwqmwsVt9pR+z67co10hVjVajcFl6Yzgwzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yjXUelPPAmUs0uyC/xg2XHrzpGn8n67loqzg+jGC90=;
 b=AMiyJUM8VE3zfw/D+2j112iecdQNWE8L3c+Q1eRkRB0G/C53LmJ8OjJ7PybbAwNPoiY5zlMD9Es8mHiKsTnVz7p8iJg4PCs0ry20YxdNPKhzNGYO8zaJXm2j9Flbf+zivMM/9dIbaxaRqImieyEv6ghb41r5AWQ250VcK8YW1BwWXK/uZ94ymWrj19iOmbxXfAr2v3qG+SO/cH5NZEzeJI3FWvr25VqyK0xAdqKpwm+EvJ4AtAel8FrVT9eyBbHLhS+efxtgKEZJJUra6iZHWn2Jxurx0cUafeAd+0vEpQ8DN+j1ZNcSPzX/sy/phNZ1OQW+Nwcv47En36LBViVYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yjXUelPPAmUs0uyC/xg2XHrzpGn8n67loqzg+jGC90=;
 b=ZXKmbH6NSobz9yG/PWxJQDZAGbGyuaD47M6oWyv8bkGNanyGuWju3AyiW9V+2wP5VGEu8DdUq1XyCGYInxb7gabPfmkgiRJbpsmfhgcWS6xWIYMUub7QVYK0H++cm3a/weXS1okikUcVEY6XNyASCajB3DsaPazHc/CLSPreasJh2Q7RDXJ30c9mb84FVHGY9nBqF2gTSldZQyt+D5X8Us9k5kcF+BH7LJ4vlLULeDv4vo2p1IUSMraSv1CUKEpc5N0Yb/6r7Gn8iLf+zd1X6HDWwbM1k26kQJXcUqRDtQ7U50ZyvVce/elK62EbmzMz97G1wj9U9u8RUFdaC06vCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 22:47:09 +0000
Received: from DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6]) by DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 22:47:09 +0000
Message-ID: <e042f758-7def-47b6-b783-23e20500cc2d@nvidia.com>
Date: Wed, 18 Dec 2024 14:47:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: tegra: disable Tegra234 sce-fabric node
To: Ivy Huang <yijuh@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
Cc: Sumit Gupta <sumitg@nvidia.com>, stable@vger.kernel.org
References: <20241218000737.1789569-1-yijuh@nvidia.com>
 <20241218000737.1789569-3-yijuh@nvidia.com>
Content-Language: en-US
From: Brad Griffis <bgriffis@nvidia.com>
In-Reply-To: <20241218000737.1789569-3-yijuh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:610:57::13) To DS7PR12MB6237.namprd12.prod.outlook.com
 (2603:10b6:8:97::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6237:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: e89cbd25-e0c4-4dc5-dc34-08dd1fb5e7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RllPSXJvOHUxY2VTTzBoeTIvT1pJWCswRm5CTzE1bysyNlhxL2FXVGFCL0J6?=
 =?utf-8?B?UmJkL0EvYkI5d0l5NzN4WXZYT2ZWR1NndFpMcWpiNFpEUnQ4UWllZDJSSHhF?=
 =?utf-8?B?b2ZWdzljRkoxMEVGVHRSMWt6QlM5N2dpZUdpSXgrQjR4KzE0OFFlVW92bnZB?=
 =?utf-8?B?ampDVGhXNzVRTG5XdTdrejJVbUc4OE9LaDZ6N3pxRWZQVFRHY0ovWWVIcTdU?=
 =?utf-8?B?eDYrMmM1MmJNd0hMSnEyYkdHd0V3TW16d2JlbE1BczIycE5YQ2lhZFFtOTlS?=
 =?utf-8?B?TkJOZjYzR3Z0UGRjZCtrbi9IUVNhc1YzbHhYSG9EOXhUUzBCZmVXemNtSWVn?=
 =?utf-8?B?ditBb09RaWI5UWxvTnpvdmQ0MGZlUk01WDFMajlaNzZKUnJIemdKTFdTdWQw?=
 =?utf-8?B?QU5STE4vUm45Um4zUnNJTkp0emNvYi9IeEkvVXdvRitTdndvN1pSTjlsREc1?=
 =?utf-8?B?MW9vc3JkMWpodzhkelorZ1dHU0p5aWJkMTFZVG1tNWg0Z2FEMXl2VU9TWUw2?=
 =?utf-8?B?bUR5QWVuTGFQeVNidWFDSjkramNJczZZdjkrTUsrRzhrWHJ3ZSszZ1NQODZr?=
 =?utf-8?B?Ykt6cHlOZkRmQTJpWTIrbHFPMEFDdDdxajdPUVhKTG1QbThFdkdiWHlRRXhk?=
 =?utf-8?B?ZW1Idm5GemdBak1HaG9Tc3BaR09zUTl1YWNxWWZlSy95Z29HaVhMZ2R6ZU5p?=
 =?utf-8?B?UXRpYzQrcHVPR0hBNllqeURWMTJPbitHZEI5alZNTUh1TnQ2c3doSGlDQU1v?=
 =?utf-8?B?c2NYakJmejlSS3dqaGxNMUJrYml5ckpHVExibUpidVN4Z21rVmpleWNLejVa?=
 =?utf-8?B?SzhLeVpQNWFxQVN0V0prcjNmb0NzcW1SM3F4dCtpRmRNM0NWRUx5VG52VWU5?=
 =?utf-8?B?VFdXTmVNeGUveTRIY3kwUEsyQ05ZRUNqUnVTY0xjUUNxUFB0eFFNdTBPbXBq?=
 =?utf-8?B?WVlld045NEU5SmhYaFdGelpuODdsZkpoNXY0dUREMWJWVGwxNUNkTU95YlBk?=
 =?utf-8?B?R3lCamU0Q1J5UU5ZUjVaRWVTcEMyZzJqc1RLeFBwbU1nWkxMbHhwZnArNnRC?=
 =?utf-8?B?a1AzSGthdUZ0Y1dCaTYvMWExRU56T3l0TXNWc0F4OU9UdjBZYTN1NXdpSlFa?=
 =?utf-8?B?V1A5THlXaVByWlJwNUdITndjY3h3c1U4QUFjN0h6NnRyVmt1bThUNXFLL2s3?=
 =?utf-8?B?bFNUU0pIVXlqa1UxL1JrVUdMWnFEdWtSdFVwZlFGL1hkdDN2ZDJJVkZCNXpJ?=
 =?utf-8?B?emYraTArZHl4OTg2QklUOHNXaVlCd1hvTlVTYkk0N2daU01VUi82dlJWOEJY?=
 =?utf-8?B?VWI0dW96eklNTUJyUHlXMWFxbTFpNWowQ3g3eWxXaytLcXA5ZUg2RkJuV2sr?=
 =?utf-8?B?dnRHYUF5YjN4OU41RnUvOXlzb1RWdzE1NVNzRlhYdkV3dHN2ZmdaS1M1eXNI?=
 =?utf-8?B?SGJSYlpaY2s4UUxCODdTUnMvNmxjdjIycGxNS3ROYlhiaytlVE5ZaTNxYWdu?=
 =?utf-8?B?NTdPeURyeVRJTHNnZmpjQUtBMEhDSnhiaHN4bjFKVEdVbjQwQ1ZvM001OXlk?=
 =?utf-8?B?VEF2YXVqaHE1eFJQYXdLdWdiMU40MkxJSHNwMWZwc25EWWwvQ1NKWlF2M2w2?=
 =?utf-8?B?UWtyejBaVTNtcmxNTXFLdFZUak1MdXhaNlJqK0RPTldra2N6M25oaW9uYjNi?=
 =?utf-8?B?WDRSbWZ0SEJEQjIrMnZQWVd1VkRENFBDdDRNbithbGYyeXQxSG9JQ284ZTUx?=
 =?utf-8?B?L2RBUUlLSmp5ZXpVV25WaVdPdWFmaXpTWHUwTmJIL1RYalphV0pxdWtVcHU2?=
 =?utf-8?B?M0FKTDZteGRrY3N4cjA3ZW8vNkhCaTdXZTZBRTljdFY0YW1UZWU0azRNYUVE?=
 =?utf-8?Q?wjLC+ju7J/htl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6237.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZxeHRadUs2NlZxK1J2cU9ZekJob2RqWVZMUldFS1JaWE55bEVVNHk5TjYw?=
 =?utf-8?B?WTNSd24ydXZ2QW5BNkxubHJ2RkFOY3RCYW5EMm1CTkJuRWRhMjRyd3dtM25m?=
 =?utf-8?B?R3BiT3pKR2J6U1lxV2JvSFZrWDBlUVZHYzJCMEJqVGdKU0lvMlJWQm13NTM4?=
 =?utf-8?B?Ky9xdStlU0d5RUE3Y2hMR1d2S2psNXBQR2FjWWlpR2FnOHdDTWpBVUIxR1Bi?=
 =?utf-8?B?V3VaR3RVamsyczR3NDBCSm1MbkdnYnVKUUpzcDlMRzIrVHdzSk1NWk5hbkFm?=
 =?utf-8?B?NUxWWjA2WUo2dGRsc1E5cXB2V20zYmdVQnZNTGlMeVlyZzk4OERqcjZic2x2?=
 =?utf-8?B?WDNQMlc1dUxlMTExYU1hOFlDRytsbEdjelArR05oNEU5ZEV3cEVVRW4wRlhz?=
 =?utf-8?B?QlJLM3RBS3c0MUdJdllPMTd1Z3ZFVy9IbkZ5NDBabmYvOEhYOExKNG9jaUo3?=
 =?utf-8?B?UzJNc0VHalpIVGdqRkEvWFBwNGV0Z0grWDdOL1huZlR5RVpNdXkrcSsvaGs2?=
 =?utf-8?B?bjI3SDQxSzNWTjVEclRKV2VwZER1dUZWRnBkVFdRak9jcG9LSmFNSnZuZXE4?=
 =?utf-8?B?L0w2UG5vdU9jMFBZc1lkTCtiMVA0eUR2ZHpZSFRKSU1UaGV0MEpwMTJLczZ4?=
 =?utf-8?B?eDdyb3JHWmRuUE1sUDlUQ0hXQmxpRXRkYUVwbkgxLzk1T2NrbUVPaHovWE9T?=
 =?utf-8?B?ZlBHdXRIRmROZ3JCenpQMUl0cjZ4dURmMjZGWkQwd1RKZnJJc3IzOFJKTnNB?=
 =?utf-8?B?ZTl5UjNjTHJBaFJoc29aNW1IS3RRNWx5SHBXbmZsVitDVStpR1p2bGcvUWU5?=
 =?utf-8?B?NmhGN1dLdVRqN2E2WTVkdXJkS3FPci93MGN5K2hhdmtBRWdCZGxEQTZPZVNz?=
 =?utf-8?B?U2R0NGNKYjYreHIwUitUNFY2YUYxRVNWWHBpSkIxcEdxcEdMcTRFcjFrTXRI?=
 =?utf-8?B?Y294QkpUYWxoKzZtWGJOVkdHdGhMaWc3QjZ3WFFsZUk3UUJTcUFyNmJxSlpD?=
 =?utf-8?B?NnhBQlhhNWlueE1neXpxYWdsbDkycDhrNlNPTUhnV2tnQ041NDZLS2s2cmk5?=
 =?utf-8?B?MnQ2RE0rWk5ta1lNc3o0eWU5STJtMVVXcVlLQ2dkUzcvSDEwSzVrTXY2bHU0?=
 =?utf-8?B?bDRqMDF2Y1VlSUxJcTEyZlRDbnRjQXBpTXZZNmo1Sm4zLzh4SmZFNGpyYURJ?=
 =?utf-8?B?RFozaUZEQTU2TXBaVHJ1NFdDN3k1cGFQRGcxNmJoN2RRSE94NEtnQXUwbEI3?=
 =?utf-8?B?TFBydUFYdG5vSFdCNGloOC9RZjdkaG1CZTVRQnJYSEdrb2JDY3h3ZHpwdFBu?=
 =?utf-8?B?WG5kWjd6S2g2b3laanRpQ29VNkdRem5MWWFLdmNkTWVWb3podGRuOUEwNUQy?=
 =?utf-8?B?MVhXdTBMWGc2dkhSSFhIMGY0UnRnZG42eFBmZVhUd1c4L09DYWZnTDJSV0s0?=
 =?utf-8?B?ZHBBM3FJWFNpVEJJRjhMaUFRVTdDWE1yOW5NUnBUTjFoY3VnaC82NjgvRnpP?=
 =?utf-8?B?ZmtWRSsrQzllcFhrMlpoaHJLaFk2Q09LWklWb2xicjkxeC95anMwRkhCZm1y?=
 =?utf-8?B?a0liQ0pnS1k4MytuWjQ5czBOUDhhTmMyUFJZNzUwOUdIWkNsRE55V1NzK3hG?=
 =?utf-8?B?MEJZdW5vUnM5UmJQQzA2ZHErQmRKWDN5dG5tM0dmNU5zMFF5VmVKbE1HMXlo?=
 =?utf-8?B?TGhYNUl0VEFVTnQyNldaWWlNL0czcUFHNnJPS2tOcFBaWStCYk5yUFVhdkxF?=
 =?utf-8?B?UzB1SnAxTHpRWmQ5SGhtSFRsWEx6dGY1K2NFQ3I4UnBOdWlveExvdVhRd3hk?=
 =?utf-8?B?dGFXRWZxbEFWM3dZWUUyNkpVYmd0YWplekJwOHZsZGl6WWhoSDJUbG1aYTVz?=
 =?utf-8?B?VFh2RENMaHpRV3JRbk1SQU5zWFVNaGRpZGk1U0Z1TC9YNzVMSlZqb09mV2RE?=
 =?utf-8?B?WnRPNkx6SEhadlpwbzZoak1LTEwyVG52eG51amNObS9BSXQvTWxXWVRuM2cz?=
 =?utf-8?B?aTJTWmkxVGovaTRNVXhpVGZwV2FMaUJvWkllUVVtSmtpcHpTUnJlcmNDV1BJ?=
 =?utf-8?B?ZDhvSzFScno5ZWtxSTdOVUp1QzJ0UFRiTDhyUlFwVnVsMzFCaCs3WEkrUEho?=
 =?utf-8?Q?Q5fD97UWkWVzzKawmUaBNbRjc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89cbd25-e0c4-4dc5-dc34-08dd1fb5e7e4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:47:09.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJXA+2xVZU582UXLaPgO6AtVKMO6aBsu/lvPSwy8S96z+x2lJVc7IOR4jVwaeNPBlyzL0KLu0KLJdCsvJtcx+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On 12/17/24 16:07, Ivy Huang wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> Access to safety cluster engine (SCE) fabric registers was blocked
> by firewall after the introduction of Functional Safety Island in
> Tegra234. After that, any access by software to SCE registers is
> correctly resulting in the internal bus error. However, when CPUs
> try accessing the SCE-fabric registers to print error info,
> another firewall error occurs as the fabric registers are also
> firewall protected. This results in a second error to be printed.
> Disable the SCE fabric node to avoid printing the misleading error.
> The first error info will be printed by the interrupt from the
> fabric causing the actual access.
> 
> Cc: stable@vger.kernel.org
> Fixes: 302e154000ec ("arm64: tegra: Add node for CBB 2.0 on Tegra234")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Ivy Huang <yijuh@nvidia.com>

I think disabling this block is the right thing to do. No need to remove 
it entirely. While at the moment I do not expect it to be used, I don't 
think anyone could say with certainty that it will never be used again.

Reviewed-by: Brad Griffis <bgriffis@nvidia.com>

