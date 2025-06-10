Return-Path: <stable+bounces-152296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EEAD39D2
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B113A73C3
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29932C0320;
	Tue, 10 Jun 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAhqPT6z"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288152BF3D3;
	Tue, 10 Jun 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563168; cv=fail; b=nwtvMCUBDlbp9Bi+XIx3+s8qTfZz4Cw0GwMFHYp2NyZQR2QtRvTfpD5S2XOVn5WO3EMpgh8JwCyzp6FL2u4j+pQCTMNQgyDz+ZoYu7pM84UDl/5m4798zORMC4+UDR3+vyYSzKQJPqJN7J7OEr2YN0NT/nwvB0taL7C9kTpomr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563168; c=relaxed/simple;
	bh=qEi1gApZlJ236kLjoe1BM+T9BiQaQCeVOhwTmQkAe6o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PnHaw7Ww2VjFxiOShRHS8zaM78DC0EGPIx9e6vpYbcMXq2K8lpJ3fIFDKQzXJhl1LIL/oxIlOC3saJtWIWIjsOqLOkcniQ0VZmBEgorCZhuswbvlU5T0TamGjDANkGi6Bd8F37NQjWVEWEaRnwog/v0UBqdS200f61QLO2V1uck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAhqPT6z; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnw54mnXPECjANV/TQJ2G40CHlsJRSrIk4bSLYT4LnBM+vUUURIcQZqsl3bNo6tFDbLINdBzHytOu2ApaIHmi9rieJWHQnQEgz2MI/gUm9seIeZ4EYBlS6h2Hx9UEVlVtvuS+1wR/0v6VB0A/ta0ZT8Eac5ElAnlQT9jiHnpEHeYiOw0kUNka/x0rQFk25i/cOc36o4qZ4KL8rdtR05Gk1w6tRp8TxIGVBCCiK+NGSCwbY1sYf9cBptvNNHgYRtsj4mZ/Rcf2ocUmqXUbSyvuSdTphZjy0EEPcd7go3V3SDephffZlm+zdLJFBb8ndeiBTe++UdH/Hy5WlEvbnOxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxnCifcUdzV9Cdq5sQKlBhTfhON72k4s7QYuc0BxNxw=;
 b=CsUCFsghIS/oTLVj++7alqWPdDzeASvj+GqZ8dyWAv/PQboNj5zMMnBspeA+OEHfDjgHA4JfhiRW2uUdxM9OEMZ0cwJ3ycoi03cPEfYSHA34ZTMkEifO+Gx/JY6Zgb96egaE4Fpv3fV3a3Jo21KAR4w1poE2xM8vdf7KKcuyD5xtt+L08xvc62UR1BCoRbprC3Bh7w2Ca0LwCTjOytCLm5n0zASEYdsrEqttXfnTv5ZBdnUcefc6YRKx68OOCz1qCddej7SFkqOvQiXU0tshFuvJHHu8yvKFnz2fUOETrjZWtySU8Gjsc2RRS1tbIKN5T+GzrBUwFPPwaWFVbaa6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxnCifcUdzV9Cdq5sQKlBhTfhON72k4s7QYuc0BxNxw=;
 b=iAhqPT6zmsyDVdgSiavNTfPGqI341CT1KKv8OIus8g1rOTFk6VUPlCuNq0BtbHKxjBSE0n8s1jdpmBzxHLRAVbsCvqEx3MoVN3xdSDeMIhUoTTzHZCBIJGQmZsVaCTRYZQSxApo4KyEfoM6cITeOXe7V4cADbdbzt8dJOvafWc1nl+mkjhcVSRVEQRmFb9bL3Xm2lbK94qVH0k99tERE4arEHApVjdzoggRjDXs4jDSg0nqXXYidx/67HIkuvSj/DmjlIaarUgsACtmMHUu5ovUTUYORfP+wezEtiPsoMPO2mCB6de7jUJjGGCsVL2XS/meXBdOHf1TZ5eXAeqR6Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 13:46:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8792.036; Tue, 10 Jun 2025
 13:46:01 +0000
Message-ID: <31989da4-0242-470c-b77f-2b0506cdb8cd@nvidia.com>
Date: Tue, 10 Jun 2025 14:45:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Fix unbalanced regulator disable in
 UTMI PHY mode
From: Jon Hunter <jonathanh@nvidia.com>
To: Wayne Chang <waynec@nvidia.com>, jckuo@nvidia.com, vkoul@kernel.org,
 kishon@kernel.org, thierry.reding@gmail.com
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250502092606.2275682-1-waynec@nvidia.com>
 <b761ca95-906f-40f6-a51e-b9a1da379a3d@nvidia.com>
Content-Language: en-US
In-Reply-To: <b761ca95-906f-40f6-a51e-b9a1da379a3d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c824d5e-98b1-4c2b-9f23-08dda825234a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3kremptZ3dmVEhtQXllMHJYR0JmSDg0LzN6K1lHbkRJUnVTOHIrRWZIUW0z?=
 =?utf-8?B?MHFFa1pmZS9lV1RJLytWcDRBQW90ZDE1TVNFZ3hMQTBVeDdZOG5HZnUyVGEw?=
 =?utf-8?B?SHArcmhURjJWVzVUVTFRTXM0dTZ2d1hUdFpGRVVnUkFRZW1XZWtYVGJyRlph?=
 =?utf-8?B?Z2ZVTmIrQWlvUEtMcVB3Ymg4S3RSOWlKMHJyYkZ0TDZrc2dZdTR1S1IxQXdU?=
 =?utf-8?B?ejUrc2doNnFUUUtGcDdjYnZVeW5DeHFvbjVRWUlaMys3V3RlRUluSkFRU21J?=
 =?utf-8?B?a2tBKytDQXFmcDVMOEVIYXpLMDVmTitQcEcvUEFMeHZTaVk1bHk4Z0JuOS9j?=
 =?utf-8?B?bldvZFBFUzNMU3hWMnlBRURVeHZKcnhQMFVUcHJkT1YzbTMySjI5Uk02ZXB6?=
 =?utf-8?B?bks0TDFOL09kZm51WDQxVG9MN1Z6R1U3ZUZxbnJIWVZVV0JkSGNNL3o5cEEx?=
 =?utf-8?B?NnpwSjc5eEp6TzdIczlLTnZPTUFaSnRKdnNxTW5HY1ZFN3FFMnJ1Z0NTMzJs?=
 =?utf-8?B?dUczVFcxaFBzc1QzVjI4Sm5XWGZLV2podzhuZVdJNXAvd0xFbWRTNDBienhp?=
 =?utf-8?B?R2M4eG1vTFc0OXY2bUZmV3U5aXZCSDR4eGFYRnFLSjNUVXpMN1BLWmxmU2Ix?=
 =?utf-8?B?VlgwMk1wZjNEZkFjZjlNSUhpSHg3MDUwNnF1bkkzOXcrMlRibnBqVUQ3NzlV?=
 =?utf-8?B?aHdPMTZIM2ZFMEkzT01nMmV6eGVkT0thUVJwdTNxb2ZaOHZCUG45VC9FYjhv?=
 =?utf-8?B?OUlKcEFCeGRxYU9rR0U0b0NyVHluaUFSY0VkanlSemgweW9tMDduWllIZjhB?=
 =?utf-8?B?VTRVWW03YXlzZzdicDYvMDdXaTdOVjdWMWsvV3NhZHIvTjBUSHc1UEJvRWdE?=
 =?utf-8?B?WTdHWGd4Z243ODNUbDFoUWJING9FYm5ST1U0b21XZTNNblYzRmlseS9Sc016?=
 =?utf-8?B?U2kyOFZ0WFp4R29NMlBxZ0xvem82ZU45ZHQ5L25ORGg2ZGJKb1FMdUsxYkJy?=
 =?utf-8?B?RDJmeDZSbXNFOTNIWTBieEhaNU1WaHdoSG1MZTNVbVNjUEpmRHhxMU1QZ0xx?=
 =?utf-8?B?R2hocjRCYnBCd0hiZ1FVMnloT1F1cmFCeVEwSHBBMWs4SUw2Tis2bTRjR0pu?=
 =?utf-8?B?aVRTYlVOZFc2bjlwZnAzNmlkUWJLbHFXUmI2cEV4V2l5WVJhZXlNUmJJSHBD?=
 =?utf-8?B?Vnc4b0RrWTF2eWJGaFpUVE5vYnF3enBXd0tVbThwak03akxHVUZWQ2cxSEps?=
 =?utf-8?B?NHpoVnpzWnVuazhobVBVQ0lSVWUrT1VCQ3IyUS9ISXJUY3JnSUlyQURYNExn?=
 =?utf-8?B?OHlMS09tNndHTmV1bVgyNC9TY1B1T2VTNXFKMGJDOUdGd3RDL2JxK256VXdW?=
 =?utf-8?B?Vm5OVnEzSXQ0QW9PaGwwTEtQa2hIWExaUit3aERIL2d5eW4rbkMxaW5UNDlZ?=
 =?utf-8?B?SDg5UGVCQlN4VGRENVZmZ3lOM3dmR01DUHk3ajZEbXJ0b0lleUo2cjY0Q1Y4?=
 =?utf-8?B?b2RzUWNuYlpQMzFEVXdwVWFYT1VqQlhjb2FxdHhzQzdQUjYzWnY2QlVHZlJT?=
 =?utf-8?B?aFIvaGNDdG1ybWowc3lkcHVaaERzNHhhbnBnWmJVT0dEckJJeGVKY3FmVnp0?=
 =?utf-8?B?b1U0ZEtpeDlRamJkdWRQZUJzdjR1WmM1VDJvVUx0RFFSWEVVeno1Z0VxTDhZ?=
 =?utf-8?B?OHhkRlJlMGM2YWozSG5TdWNPN0x1QXJibGxzU1lXVCsyT1J3OUUvQW1tQ2Vx?=
 =?utf-8?B?M2pVWWlHRlFaY2ZRV3NqWnhEa29CSkJxN0VmNFlVSTBvbC9kNG15VytBSmhR?=
 =?utf-8?B?S2xLUDJiSGVjK0tSZEhqZ01oUWk4V0lnZS9scHVJZnFiaUx2aFdRcm9rakw4?=
 =?utf-8?B?NGNqb0l4MURqcUdobzZsNVI5U0R0ODVDOXEwZzBMVVZvWEtURTRwTnRyNU1q?=
 =?utf-8?Q?EqcOw53tLz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzB6S0NvV29ER0ExREVYTFZTbUJKUmpvVzZiNnZ1eitYSmhINnZEMkJ0cGty?=
 =?utf-8?B?Y3ZEbFJLU2lBbjlwWmpkNXVWNDkwcGdzZVBUTmt5T3orODRXVGJqdEdHejJP?=
 =?utf-8?B?TjYwUTAxQ0FrZi9nREYwYWluRWhrVndidEx1S3hvUzBOclRCZDJqK1dFQjln?=
 =?utf-8?B?SlZxNGpMaTlETGlBUFFWdVMyVmdVTEEremxOYW9LRjN3ZDB1dHA2UzZXQVdH?=
 =?utf-8?B?VnpxSEFaeElYLzhYeW9mKzBQb2hydzh5Z0lDVUhhSkNKVG5HNWxIQUVKSTRo?=
 =?utf-8?B?UE1jQ1llSkVudVR2QzdHbGs2T3JYYkI0cUZLQnR5OVM1WXU0czZQNk0rZ3RF?=
 =?utf-8?B?b1ZzNHZXM29zVzlaNWpOTkN0ano1dStPM2FMQUdUL0hrSVI3aUlTOFdwSndW?=
 =?utf-8?B?Q1ppL1R4ZTVrdG55ZVZ4WndkcjU1NlczcU5DUFRtdkxBTlo2MTdXa1JLUGsx?=
 =?utf-8?B?SVhjNnFKN1lXd1lTc3BObTNWQVFaZ0VwdjZNZzJudGxZbHYrenUvNWVPc2Ez?=
 =?utf-8?B?R1A0ODQweUdRSUVqUWdMTFNLSitYc1BEazZwYnFRVkM0WU95ZlU5aGprWXN3?=
 =?utf-8?B?VTd3c1JEWWdjbUJ6U1ZzMm9qQmZ0TzgzR1ZnLzA1ZXl2dWIzUTg3MW8zMDZi?=
 =?utf-8?B?bGJaVGRQRzZOZVJjQjVCM0tTZ1F2V0FGaC9wVmRiN1lzejJhVjQ4M3BzY3By?=
 =?utf-8?B?bVlGcTNyd213RHlMU0NlYi9CYWlQZkxsb3E4RG4xMkZqYWY5K2t0UHlrc0s3?=
 =?utf-8?B?dG9INHR3cUY2elhUaXhCckJzdERQeS8rSjFwRzNSdzVHbjVNeklTOGFHVFEx?=
 =?utf-8?B?TXdRQmVwWEJxN3VlQUpCUFZrdHhVcXlCL2xPNW9MTDJ1Sjd0dU9pcXA0RE9N?=
 =?utf-8?B?UUV0d1RPOWZmanZOcmUxbGlvL0VscjFNQnVvRGpuM3JCNnVjYzR1Y0hzNTJE?=
 =?utf-8?B?cUtmS2RBMFBKQ212cTVVUzd1UkErbnMvL0NNOU5LV2U5dWhHYnVvL3dQd3ZP?=
 =?utf-8?B?bmtzaGtBb2NWeHpiQ1U1Z1RpZDhrQ3lmWlllQlFhdjlEWllqRDB1ajdaakVT?=
 =?utf-8?B?U0hsK1RwbXo5WHo1RnViZGIzckNZV0xuZnk0bWQ4ZWRKRzRILzFBM3lDblhL?=
 =?utf-8?B?dDkxd3pCNDF5WTZsR3VtUlZGTWJkM2R5Wlova2RhM3ZFRUxLeVV1dUQrMDAx?=
 =?utf-8?B?TlYvcXQvT29Id0JNbGo4aG9JMUVFYklPNEFwRkE1MzJWVlRhSVdlRXBwUG5I?=
 =?utf-8?B?ZVFBWFhYcllIMnZ0OXVmc3BnVnA0QUJFRFZBcVdDUHQ3L1k5bStqN3lGU2RK?=
 =?utf-8?B?QkJXUkNnVnNOT21yVWhOaExReGUxRWcyZ2xUS1lwVUtEWnpRUzFOMDlmTm9W?=
 =?utf-8?B?aXpTNm9GTW9YVUF6S3BQNEdNbXhNZmw3WmozWDJpTkk0aURuTW9iZ2MzNWRj?=
 =?utf-8?B?NzVUVWZXMHQzOElGRFYzMEJtWGw5Vml1Y0lwQk5RcUJJSVQxcCtSeHNlZVJN?=
 =?utf-8?B?emZySnUrNHZJWjZYVU1JNm5URE16UTg1TW1adUx0by82bi9XdnRXTGNaZWU0?=
 =?utf-8?B?N3lNY0dQNWVlUFZNdGh0L0dPdTI2V1U2TW9ZcStyLzc1ODQ1Ti9keUl6Tzhk?=
 =?utf-8?B?aFV4VEV2Y2t0dnMwclF2NVN2QTgwSkJoNVQ5bWFkNlFBTTN6MUNzQ0pvdGxV?=
 =?utf-8?B?U2Uxd1JQMFR5VStlQ0ZSSXhWdDBkWDI0alVQNG5nempaUE1CdVFrSFh3YXhD?=
 =?utf-8?B?UC85aWtQV3FiQVBSU1ZISXlwQTBqdFJxRTVLNHdwUHpuMGhCY1I2ajlqamY4?=
 =?utf-8?B?d2x6SFFlSHFCRHZoTC95MzdJaS9McW4yb3RMVmxGY1RuMTFHOE5WaEdIMjUv?=
 =?utf-8?B?RCtyV20yNVdxODR4eHFIUHhYcWFoY3c1TzBPRDdQTUsrMGJrWisyUlE1d2Z5?=
 =?utf-8?B?RE80VU5yWjM5N3l0V1VObTVDRmVMUW01TWlQZ01TdDJmVHBpWWlldEZ0TUtj?=
 =?utf-8?B?N3NqTVhINmh6eVc0a1c1UHJ3Mk90cENLa1lQdnBJWkExUE5mcW5GTzM2Nlow?=
 =?utf-8?B?L2cyWmVrMkxzMTVDdGFhMUhxT2IrUjlWQlJQc01NQlZ4RTkwclVaWmZpWWg3?=
 =?utf-8?B?WElyRkNrQTVrZGpXdkJQakFYejlWUWN1ZEVYVHpIMGtzVGp3Y1d0SW96b2tt?=
 =?utf-8?Q?mJ2rnYO1gQ6Bs56P8cpPSPdontn+A/p4uMXcApRJtb3Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c824d5e-98b1-4c2b-9f23-08dda825234a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:46:01.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhf++c99Y5mQXLYzL4X5xUtpqCNzODQSfEwso979KpEGu3h2xGhz5qzNRTwJU19tSztKME/XQN+yXKuRhB2IEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312

Hi Vinod,

On 15/05/2025 12:03, Jon Hunter wrote:
> 
> On 02/05/2025 10:26, Wayne Chang wrote:
>> When transitioning from USB_ROLE_DEVICE to USB_ROLE_NONE, the code
>> assumed that the regulator should be disabled. However, if the regulator
>> is marked as always-on, regulator_is_enabled() continues to return true,
>> leading to an incorrect attempt to disable a regulator which is not
>> enabled.
>>
>> This can result in warnings such as:
>>
>> [  250.155624] WARNING: CPU: 1 PID: 7326 at drivers/regulator/core.c:3004
>> _regulator_disable+0xe4/0x1a0
>> [  250.155652] unbalanced disables for VIN_SYS_5V0
>>
>> To fix this, we move the regulator control logic into
>> tegra186_xusb_padctl_id_override() function since it's directly related
>> to the ID override state. The regulator is now only disabled when the 
>> role
>> transitions from USB_ROLE_HOST to USB_ROLE_NONE, by checking the VBUS_ID
>> register. This ensures that regulator enable/disable operations are
>> properly balanced and only occur when actually transitioning to/from host
>> mode.
>>
>> Fixes: 49d46e3c7e59 ("phy: tegra: xusb: Add set_mode support for UTMI 
>> phy on Tegra186")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>
>> ---
>>   drivers/phy/tegra/xusb-tegra186.c | 59 +++++++++++++++++++------------
>>   1 file changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/ 
>> xusb-tegra186.c
>> index fae6242aa730..1b35d50821f7 100644
>> --- a/drivers/phy/tegra/xusb-tegra186.c
>> +++ b/drivers/phy/tegra/xusb-tegra186.c
>> @@ -774,13 +774,15 @@ static int 
>> tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
>>   }
>>   static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl 
>> *padctl,
>> -                        bool status)
>> +                        struct tegra_xusb_usb2_port *port, bool status)
>>   {
>> -    u32 value;
>> +    u32 value, id_override;
>> +    int err = 0;
>>       dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
>>       value = padctl_readl(padctl, USB2_VBUS_ID);
>> +    id_override = value & ID_OVERRIDE(~0);
>>       if (status) {
>>           if (value & VBUS_OVERRIDE) {
>> @@ -791,15 +793,35 @@ static int 
>> tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
>>               value = padctl_readl(padctl, USB2_VBUS_ID);
>>           }
>> -        value &= ~ID_OVERRIDE(~0);
>> -        value |= ID_OVERRIDE_GROUNDED;
>> +        if (id_override != ID_OVERRIDE_GROUNDED) {
>> +            value &= ~ID_OVERRIDE(~0);
>> +            value |= ID_OVERRIDE_GROUNDED;
>> +            padctl_writel(padctl, value, USB2_VBUS_ID);
>> +
>> +            err = regulator_enable(port->supply);
>> +            if (err) {
>> +                dev_err(padctl->dev, "Failed to enable regulator: 
>> %d\n", err);
>> +                return err;
>> +            }
>> +        }
>>       } else {
>> -        value &= ~ID_OVERRIDE(~0);
>> -        value |= ID_OVERRIDE_FLOATING;
>> +        if (id_override == ID_OVERRIDE_GROUNDED) {
>> +            /*
>> +             * The regulator is disabled only when the role transitions
>> +             * from USB_ROLE_HOST to USB_ROLE_NONE.
>> +             */
>> +            err = regulator_disable(port->supply);
>> +            if (err) {
>> +                dev_err(padctl->dev, "Failed to disable regulator: 
>> %d\n", err);
>> +                return err;
>> +            }
>> +
>> +            value &= ~ID_OVERRIDE(~0);
>> +            value |= ID_OVERRIDE_FLOATING;
>> +            padctl_writel(padctl, value, USB2_VBUS_ID);
>> +        }
>>       }
>> -    padctl_writel(padctl, value, USB2_VBUS_ID);
>> -
>>       return 0;
>>   }
>> @@ -818,27 +840,20 @@ static int tegra186_utmi_phy_set_mode(struct phy 
>> *phy, enum phy_mode mode,
>>       if (mode == PHY_MODE_USB_OTG) {
>>           if (submode == USB_ROLE_HOST) {
>> -            tegra186_xusb_padctl_id_override(padctl, true);
>> -
>> -            err = regulator_enable(port->supply);
>> +            err = tegra186_xusb_padctl_id_override(padctl, port, true);
>> +            if (err)
>> +                goto out;
>>           } else if (submode == USB_ROLE_DEVICE) {
>>               tegra186_xusb_padctl_vbus_override(padctl, true);
>>           } else if (submode == USB_ROLE_NONE) {
>> -            /*
>> -             * When port is peripheral only or role transitions to
>> -             * USB_ROLE_NONE from USB_ROLE_DEVICE, regulator is not
>> -             * enabled.
>> -             */
>> -            if (regulator_is_enabled(port->supply))
>> -                regulator_disable(port->supply);
>> -
>> -            tegra186_xusb_padctl_id_override(padctl, false);
>> +            err = tegra186_xusb_padctl_id_override(padctl, port, false);
>> +            if (err)
>> +                goto out;
>>               tegra186_xusb_padctl_vbus_override(padctl, false);
>>           }
>>       }
>> -
>> +out:
>>       mutex_unlock(&padctl->lock);
>> -
>>       return err;
>>   }
> 
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thanks for fixing this!

Can we get this into -next now?

Thanks!

Jon

-- 
nvpublic


