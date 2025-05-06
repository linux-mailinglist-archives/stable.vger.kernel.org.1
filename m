Return-Path: <stable+bounces-141938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA8AAD0B9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FA61C41413
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4D21A440;
	Tue,  6 May 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uF9lnMym"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA21A434
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569041; cv=fail; b=ou3kflpYR6+UrDV94bnirxK04/5HCpmtNgCOa/xsSo9nYHo2jr51NpkfP6CHg0In2ZzKtscPTS7lClOtbDFcWUdkY76MIdpqDOVOZH8TIOJut6cW0wicQBngKKcDWW0t9DGkl1AhvPdAsTVtiydZ1IilMtuVOvYkRLrVyLGpxEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569041; c=relaxed/simple;
	bh=6vO1u0hWWKP60zd+UJB0Dw5Cxo6VDbJbAUKs2rOOCYI=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=fEQSwZbacHYbKee2sTIgopwI428TEaxNuRKhzAPXmrkHM98mMaZwAGciUI9u/SonhiA+7XiRrjW888s3rAd5uHVHoB08WgYLpmuw6nPm7K406IRfiK6WRC4s8OYfroTnSRFGBnv0ibswxqjz1qpumfd4BT7caEoQmW+cq+zvQV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uF9lnMym; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAvQC3sl+SS7frPMR+ZqlStNFfdLpVJHzZubYr1hBROlLayJYVWK2DYoTW3Gt11KT1+ugzpnZ85rMfHDRV3z0jQyegzEPmzIcaRfQDli0Xe70hnnetVOkKE7+LqJ75Yd+auMtGKdd/ThntvjfoI1AxD1LdxhZALxbqnAwAruZmmRq+ST5mybDfs+zj5NdV1rS4lcgvNRfIy47Wkz0gnWVKrgA6xC5EhDRqN1LIWxcLvVoQmusS0Uk3oQYkIzGcojQXESuZIjNR4Z2S+NjZxoG1XVQqcyTzjQRihx3of55MmzQqG88GSkUtbltMy3lPkJUDYqdjmfoyz89ppG+OlJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToYHkaqlBH3vCzgextXRrFdqzvDFmSpTjXar1HiGxUY=;
 b=ZkAE/SMcy7p6odwVxeq9F/M/sOndLqB7Wvvtw4HvIeUykcPil5+Qcr9Wf1Z0x6oxw1nwULiH2KWcScRjUCYuviQ2b9zmb/MONNBZGFb2JlmObqMBTfJ5oKcd5Eh9uv03YG4UM5UE17XseMAP/eZcZPPMc8CwmjTjiWOeB8pyAGFZ9yhbzieP1uLU1OBNUZeBLbfOo459NAUN90ddt3SvubeQzdq0h4KsdgxP75FAwIT2GoDU6YQ10hVXJbLGTC/F852e6+swYFkiu4VE0veuzfIzFsBWhqOHPuTo3gCcDRsZe8sp7k08JRNBpOuI7hDmx7r39eti5SoWSoTqs3VVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToYHkaqlBH3vCzgextXRrFdqzvDFmSpTjXar1HiGxUY=;
 b=uF9lnMymwLI4nqaf/tiJVmrn0ATZDyZmBlS3OZlogzPJT6zTlJmAuctJTQjjBqi84j16fZsdlEyK8tNjRKvYxjULrPrB065qWTlvlXLO4YFQeNtrfcp6kr7vo3ZYNjQoZyayoGABqYuvQVNIOhtmPn8JVJfCR5vcD92qutXnLcK4okYGC8xpcphEswDefVA/+xZr603/LJN83cJxTjFcQj4AaR34vFe+23JmQPdAz4LIsauU/NuuiF97MRll250A4Po18zneE4JLda+5Q3rbsJIhRlXq3t+JHUViSNZgoSF21DZIoU1updh6EVD3pBzDe3jY+ER8KdhD6IKmSol0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:03:51 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:03:51 +0000
Message-ID: <14b9dd6f-7467-47f5-8db0-61e6cefc3fec@nvidia.com>
Date: Wed, 7 May 2025 01:03:45 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 5/7] ublk: remove __ublk_quiesce_dev()
References: <20250506215511.4126251-6-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-6-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: c76b9a48-bd35-4a50-54b0-08dd8ce9e240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHcrc3Q1OTQ3K1k0U1FRVzZ4VnV2a0VlOEo1TWpJZk9KeHk0dnVwbHhmcEcr?=
 =?utf-8?B?R09IU1g1dy9STmFjTm5hanFCV1dhWlFLUzRmS1I4M09JcXhMYml1Z2FtbS83?=
 =?utf-8?B?c1JIOGxad2J6bHc5dW84ZVhnK0UrYTRraHJVYitwUDNOZW1TendxKzE5WDNy?=
 =?utf-8?B?Y2hRTy9vRXFKdkUzVHJWYlQ3MUVCM0lUK3Z3TWs2SS9Wc1JpY1lqS25sNVVO?=
 =?utf-8?B?ZDhqRU5iS1E0UktCN0JONHVBcGVlSXB1YVBlOFdpcERGVUhpZkc0Rncvck1x?=
 =?utf-8?B?ekFISTZ2N0FkYks1b0ZxcWR6cHZRUmUrMXAzYlpHRFFZcUZUVE8xTy9remdr?=
 =?utf-8?B?RnA1WW55Uk1qdkR5b0lGZEVhOTBRNVRlYnk1amtxbW1ZcnV6bjdjK0ZkMEdK?=
 =?utf-8?B?NXNZNTBSSHNVaTk0VFdyQlhkSjU2ZXFjckg2WW1iVTZlQkpuNkRWc1VsN0Nz?=
 =?utf-8?B?dGxKeEluOFdsQU1BYng2Y2w2RGF2VjNxWHByWUJ2S1VJNFBVVHdBQjZZK3Bm?=
 =?utf-8?B?c21XcmIzY3FDMFlxNE5sd01ZdlNpRFpQTEpJUFJSY2tIb0szMUFhK05WTG1n?=
 =?utf-8?B?eHliemQxYWZLREVZWnJxSVc4dEpEZmFKd2F1ZndDck5JZi9FVyt5K25pbW5r?=
 =?utf-8?B?U0VYNkh1QjFZbytJUHJmRFIwSG1iVGJoMzdtaGx4eStmSGQ3a0hxNFVFWGlW?=
 =?utf-8?B?dU5qZ1RJbUREU0Z1UTNxbldZanZSdXUxaWlkU2tWbG4zdDZXdHgxdTd1aWJW?=
 =?utf-8?B?L2QycjRpWU1pcWxRRCs1TGJ0eTVGc05ZSDBaVnI4aXJqcUNOSkdDa2RraWZi?=
 =?utf-8?B?QU1xdkFKVUJjc21vQjBVdkFjT1FaRU5TVXR2M21DbEx5S0t0eHdsS3FHMzRy?=
 =?utf-8?B?MEJoeFNHclBpSm9CcTNLenFJNFVUdHVuaFM0K3lZZWpwVmdIRE5KVERubFkr?=
 =?utf-8?B?bW9LNW91dFdMN3NNSTY1MytrU2c0dm1BUjdKZHFaUjc2aW5XcDVrUzJIRUJs?=
 =?utf-8?B?VUVBOGZXQlNUc2NaQ0ViUXZ3MjUybFR2WTRiank2RWN3dW9UZ2l3WlpqZUZX?=
 =?utf-8?B?WEUwWWFXM2g3d1pnc2d0UFNjeU5ZV1RyeHNRNjBvWjg4Q01xbnAyeDllQUdl?=
 =?utf-8?B?VjA2WCtxcWNhSmorTSthMDNFRm9DTHZrbUtSZlNjMnlOU0RMamxZTXdIUXVX?=
 =?utf-8?B?YmVqQlEwK1ZHRHo5aXZsZzk0UU55eFp4TlBxWUhVVmVQeVhrS3VyRXR6c1RO?=
 =?utf-8?B?bGNjaTF1dUFzYk9tNEZFSVBpYXRCVDE4QVRCZlM1M3B6OEVLNlU4S3VSNGw5?=
 =?utf-8?B?bkZhK3NwelJiRzFaL29vV3VVSnZGZWJ5WjBvOUM3Rk4vY3BKd0dUSWFkaDdn?=
 =?utf-8?B?S0pmV3pWdWlWNFR5S3VwaG1zMFprUlRaQ1Q1aEF4dk1kbGJva2lDMU9XWU5B?=
 =?utf-8?B?OENUcmM2clhuM1F5T1drMm80UTJ1bVZSL05nbzl1TGFVd3krN0VQSU9HdEJv?=
 =?utf-8?B?djNFUDBlbW1JVXp3dmV2U1lKY3NNQkhtNzF3cEFHcHU4cms5VjlKR0dYVUtT?=
 =?utf-8?B?Rldjb3A5QzNjWlVLdnZaa1RYRTh2ZU9oNGhRL0g3QjMzZ01TTXlFVndUOXRa?=
 =?utf-8?B?Rkx3K25nQ3ZSR3JseEQxcXdUMnQ1dmJhTVRvYnkvcWV6bjBRd3R5bS9QMlJy?=
 =?utf-8?B?L1NYbTRSTlMzSWNJR1B1MkVHek5QbXdkSTlSdFQ3eU1ISVhxcUdhSCticEhH?=
 =?utf-8?B?TmkvbjB3bUV1MWF2YVU4cytFbnJrSUJtZEwyemF0MWNVRzcraThaTUtYeEdx?=
 =?utf-8?B?anFnSlo0a0NsTXFmeWt0YnhtTlNzZVVNdGEzS0FHY2xieEJTdXZCSE93czIy?=
 =?utf-8?B?emJTMGJ2VlVqQldYSHpPcllsc0lXZnJvL2FTQU9nZnVucVJ0dEQ0cmEyM3Ax?=
 =?utf-8?Q?BW9cug28Sog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXk2elRZcDJkRGIrSUlBeDE0ZzZoL2lZeUZVOU1vNis1aGMrSCtwZXArdnlx?=
 =?utf-8?B?ODVHV3hrdmI2c0RtRWRzcStWcjBHQ3RKUkVldEhFakFyRW1yNVlyTzR5bGVX?=
 =?utf-8?B?UGV5eTNMY0hHSmtpMGxvNFBpUzloRVAzMng1bXlTZHh3YkRXd0ZCakhJTVlq?=
 =?utf-8?B?UitCcEhCUm5DbEFKdy9ydkM1bTJmWmZLSEh0MzROLzZ4d2RlNDRtdFR4Vlk3?=
 =?utf-8?B?aEF0bHhYZmFwQTlPLzcvKzUxVFJSL0o3dFJ6MnhLZ3ZqUi92cFlNUlFvdXEw?=
 =?utf-8?B?aWI2QW9Bd2poMU1HNkFxRmRvejMzRU1XTVM3UDNWM3dhM09VL0x1SFcxdTlU?=
 =?utf-8?B?MnlneXNlV0pwM0ZNRnNRR0VvMDNIVmN4ajk0VUl4ZEc3N3lOQVJSQ1ZmRGVR?=
 =?utf-8?B?Vy8yTjQxSlo1YmRxcFJvQmVERzZscDd0YkdGZXRJY25YbjM1ZktxejBGNzBY?=
 =?utf-8?B?STE5cWdraXUxajBJQ0ZWS1liSnV3VlgwZHBpeGVmcm5VTEdHTGRRQjR3L1Vs?=
 =?utf-8?B?VjAwTTBJU0ZxMVNTYUY0aEo1S3VWdS9VRGM3clA2RmoyRlpzWksrWDhsSmRp?=
 =?utf-8?B?ZS92MXdCcG9OV1FpK0t5eGVzZWR4SDVTZHZtcW9OdDJWNkFSclFGT2VUZ0JF?=
 =?utf-8?B?czFGVlY4TTV2UUREWGkvdmhlWGNoSzJEOFBNWEI4aDlFdEZLdmJGMW1LOU9W?=
 =?utf-8?B?czJ1em90UXFkMW04ekM1QUlKUlBBNmZjd2pEN3A4MGpDcTUrTytJbjBBbXMv?=
 =?utf-8?B?aEM0YzEydTljMGVCWE1UR2RDc1NLQkNpU2RYSHhndW0xdXhDaCs0VU1EWTI3?=
 =?utf-8?B?TUVsVDV3L2Iza1hzdzJYK2J5d0Y4akxvdnNhNXlrWUxBZVBLbGExM3FpRVlz?=
 =?utf-8?B?L0NBMUhWNURrTUdBUGZjUE8rZXo0ZXlReXlXa2xDYTlaOVNmOTIrN1NQRi9h?=
 =?utf-8?B?ZmUzdkZ5K2NmWjlFN3lyN2V1NmJ0RGVkenJpTG00bWltK3FreWc3R1JZRGth?=
 =?utf-8?B?d2d6d0JtSUd2WlQ3NEJMV3FGSVpEV1ZrTkpXOTlPZlJsRnJlZGQyckFvMXFJ?=
 =?utf-8?B?a1I3ZklBSHRqbTlSNWJtOTNLVzROZE04UkZSVDVoR3ZNaGc2VTJtc1JDczIz?=
 =?utf-8?B?NlBhc0ZPWW91QUhxbFgyK1lMZUNFK2lPUGYwOU9HWFRYYVNWT0dDT3EveUtt?=
 =?utf-8?B?OWlzeGo2WXhLMVAzS1Mvazg4VVA5dzJ6NGJDTVpRK1lraGh1TUlFVzFMU2Y3?=
 =?utf-8?B?VVYweEVxOVpoY1BpUHY3ZllNU2Uwc3lVMzkzdjB2T0dRY29Xb1ZyMDlBMVhK?=
 =?utf-8?B?eXJ2K2F4ajZFYzZFcnNKMUlIWW0wVlVIKzZlbHBsZ1BpYlg5Ri9LK0tZUkhx?=
 =?utf-8?B?M01IQ2RRSDEwR3hhZlRyaVlYWVdCdlN0b29POE9VbWhQajU5M0pGbDk4VUFx?=
 =?utf-8?B?dkVkQ0JXeDhCMkxHbSs5T1gzbmlVQm1Ebml3S2w5aSt3a1Z1RDZLc1JLdyt0?=
 =?utf-8?B?ZkFENUZVekRnM0xzM2hkUTF5MCtvL0Y3UWQzSjNXVXZDdFltTzBONVhtbzdh?=
 =?utf-8?B?OFB2SzNQK3Y1RGc3TjN0M1NyL291bTZtQVRJYlcxZXVFeElzYWgyMkM3bU81?=
 =?utf-8?B?YmFQdkd0VTRySjBjemJQT2kyancvQVJvT01KazdYbnJYazV0WkhVUEVCZ3pK?=
 =?utf-8?B?cnNROEQ1MTk5L2V0aWh6UGlPbW1mMmhZV254SXFCVW5GZlFCVjM1Ni9rcFp0?=
 =?utf-8?B?ZTVmTEk4bkF3MlVlOVRJQzFUTUF6eVlJNHJpMVN2MVl4b2dtZnBCdXdwcTJ0?=
 =?utf-8?B?MFlqVEt3dUxMdTd5eDJETHNxMDhFVk9aSFl0eWoyMXhhT3FuK2lsTWV0MUJV?=
 =?utf-8?B?NEFvV3YwbWNxTFVhS2p1d3owNk5aTTNHdzB5anBXY0hvOXdWZjdQeTMvRmFI?=
 =?utf-8?B?YVRuSFFRUkh5K1dtRk5Ebjc1amc3OHV4aTlhR1NpRU5CNGZFV0NleVBsZVVY?=
 =?utf-8?B?ZHpZWEZrS2F3eXFRMUdETkhSOWozVVI4UlZSYndYMXpHS2hlZEJuekVaUSsv?=
 =?utf-8?B?UGhVTVZMS2VjL0lZMUpVaHdjZ3o2WjJFQmxsSWRKVUZUV3pFZGpsSFRUY0hq?=
 =?utf-8?B?U1ZZZ3BlNmp4MXl4ZEVvaWhNZDBwaWNpVkJoMThIKzBETWhPZkJLUjF4Q1J0?=
 =?utf-8?Q?429x1dDQI9XliP386eWrIZgPAeMtSnggfLYRp2o8Lagg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b9a48-bd35-4a50-54b0-08dd8ce9e240
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:03:51.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImMSZdVQzsX5S2TGbvib1NfV2yus36bdXWUZRCH1NhxWljcdQxE5OKFOWTPRlUb4+hsB4ca+r3C2lBl3mch57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Ming Lei <ming.lei@redhat.com>

Remove __ublk_quiesce_dev() and open code for updating device state as
QUIESCED.

We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
because all inflight requests are aborted in ublk char device release
handler.

Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
because it is done unconditionally now in ublk_ch_release().

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-7-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 652742db0396..c3f576a9dbf2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -205,7 +205,6 @@ struct ublk_params_header {
 
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
-static void __ublk_quiesce_dev(struct ublk_device *ub);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -1558,7 +1557,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		ublk_stop_dev_unlocked(ub);
 	} else {
 		if (ublk_nosrv_dev_should_queue_io(ub)) {
-			__ublk_quiesce_dev(ub);
+			/* ->canceling is set and all requests are aborted */
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
@@ -1804,21 +1804,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
-static void __ublk_quiesce_dev(struct ublk_device *ub)
-{
-	int i;
-
-	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
-			__func__, ub->dev_info.dev_id,
-			ub->dev_info.state == UBLK_S_DEV_LIVE ?
-			"LIVE" : "QUIESCED");
-	/* mark every queue as canceling */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
-	ublk_wait_tagset_rqs_idle(ub);
-	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-}
-
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
-- 
2.43.0


