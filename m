Return-Path: <stable+bounces-201101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFCCBFAD1
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B337430572C2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD32E11AA;
	Mon, 15 Dec 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AzQrGyWA"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C42BEC41;
	Mon, 15 Dec 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829001; cv=fail; b=cBHQO9AC8wgLooLKf90nMzdxBeJ3mXLNuMS99H62VI3/mywD4J1mvOKmtiSMlt+W2T0ixoWLpd/x12su/NJoVdqCSQ2QkP5XCllkS8I4hG3zXkjtLbADpe046mfXqnwsACymmg0IcyBCzAHqeBcxKftNv5DhRPKwJg/nWp/8VX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829001; c=relaxed/simple;
	bh=EwZVshl3dRQqxnaQKHrXgGiiMmZHGH7bUivD8FqmnJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6+pwui5DenW1F6lnRHBn0H4fwJ8uc1oXT8W4o0h6dh6zEIvfMlnnMcEH3qjkVcEyTz0Z1xOFaZpGX5D331v4/ibZqzPxZz88PZhQsSLFkkiw6nOJfvKTDN5A7zdBiUZIN8gSY+p2IATyDusTiauHl15IISBGbwwymmNm1/djT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AzQrGyWA; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ki00t5QePSJ4D9EI7STuaCETcWaVxmB9zTKvc/XqTdZ34KLnBL66emcCQkBT37RmL500vVd3BfjV7d0woh0cDQPLcFjO3yL/BOOAzU9ha1F/nNXN1MRKhXLsapTCGFBG3tcTsTPXr6s04QgFR+YyVKRW2LACzt6nSJNQyr2yiXUGBaYc5hD+GnyVSAWzUAQMTPVyXMUpj7dU5Wd0TY3DAAp95Cdq+Yeab3nKVbsGIS731zbqLgLqr0/FNfrUEgkDWpGm3c8Q784QIgFFE+RLeodC0zMwFhS81oBQtDwkoVNl46iCGvNteh0D8YYJnX2uuCS9O1e3h6YPuDYULAPGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7KSEX7U7NnIO2daCi7CaoyWIyRMKHemmUP+Qo9svhA=;
 b=RWJcPW8HLGLTF7azmj7NYY3hiXO0p3qnZ8wvI33qfUX2j27twypmA8Yd8WWUm2/paL6vuTuB3DeH1J7vxu3ZggpoQjyHkMI4rlQzWH1JdVbVcFHfrJLuWJLBZEvnarlcEXDxpWQSe7ZC3dKY6IopDgLEDF+1qIpQ5R9ehpDb+BJ6nwXEoYdmqQ/vpJ+suLFM/G+41EjA1pZsiYqq86GsqL2cNrmMXAqFQtFva0Dx87aZNh0Gf9fo40RpnXOIGCS0Q5SRFusbRpGszeZn/9TWPZZZ/95LY3c25j/bVVzQqTJXcwV1FMg6SYD/HVwjuWaRYeUJvaBEyVUrrxMKG8pedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7KSEX7U7NnIO2daCi7CaoyWIyRMKHemmUP+Qo9svhA=;
 b=AzQrGyWAr6F+AAhaLm0cmalfqexBfNpAh1uVyWxRMlQrzSG1QH37kS9PZ91nseNoVmZwUSvlSSL1AKVbAroHncl/hmJGWGqYPb2fA7s4RWp0+snhr5ZueiVCjsws1LT/YgB4/VSVhPITHcrQGlBSs+ImGsdPobzgUsmC5VoAPgzsE3+I3uc3dkb7ZcbfnKx95ZNBoIXHoff82OGLsKG8srLy6TTdWLYGHSXtLd06axYNExfk1RJQDIbDxzt3VOfP6FDzcp01taAHKqWsz6Mv/6YV3L/UmPaVBv01gIT6DZP1BjMMN628IXRna1tzFuU40GHhuTlsbkWkCHZisOxsNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 20:03:15 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 20:03:15 +0000
Message-ID: <64761b5c-1dc4-43da-a348-3db994ca5e87@nvidia.com>
Date: Mon, 15 Dec 2025 20:03:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] ARM: tegra: fix device leak on tegra ahb lookup
To: Ma Ke <make24@iscas.ac.cn>, linux@armlinux.org.uk,
 thierry.reding@gmail.com, johan@kernel.org, hdoyu@nvidia.com,
 swarren@nvidia.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251214125317.2086-1-make24@iscas.ac.cn>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251214125317.2086-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c225a6e-0255-4cd5-cee4-08de3c14fb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3ZSQUZvSEhuMlJlb0psK0p2UUdzNzZRVXl0MlpId2RSMThVL1E1dmJadTVl?=
 =?utf-8?B?amlIUUNUcEFSU3Y2NXZXaDRMeTVUNUJBcjdPQ25tOGpobk1mKytoa3QyeHRL?=
 =?utf-8?B?d0Vya29aNGxGSnpMb0JLZklRTHlheGxLaytnTGZrUHJzUTRZOWMrc2xtcVBt?=
 =?utf-8?B?eDcwSjVRTGpVRzBGd0lPTXJaR1djZzA3M3JsV2QrNHh5RDBvblp2eFR3RHV6?=
 =?utf-8?B?c2hnV0Q3Qks2QWdtaGtSbDdTK2w5UGlUdmpacWRJUFprQktQaTUydjNnTmd2?=
 =?utf-8?B?amMyay9sTWRWTW5zbXlvNkxYOHZMM1JwalhVeEs3YzV4eVlMS3R3NGVEYXpL?=
 =?utf-8?B?S2hjQ2hsMHA0ejBKZGduOUp0UEdrR0VqeTFIRmppcHRNTkN6NTJQRjJSdmtq?=
 =?utf-8?B?UFlFYjl0UGhRTFZNSkZidUdlekZhTWlUSDNzMHBrdXA1OHkvcWc2MXdUSnpM?=
 =?utf-8?B?d1ZTdmM3MFplMmx3Qzk0Z1JZMjNGYnRMU1Y2am85QXdIQ2tBVVUxS2J0aHdV?=
 =?utf-8?B?Y0dPditWV3lPbERUQkpnZG9FY3dIZ3BLYytaWmJ5ZTN3bGRtZEE2K0tuZ245?=
 =?utf-8?B?dlBNc1RDVkptcmlhUk5xaXc4R0k4YUFzc1JsU0JWM0tnUStxUWp4SXIxajNi?=
 =?utf-8?B?UlExckpTeUR1WlNoSDljd2R3QU1iT3lLUEN6UVk1T3R6d0F6UVdzRkloeTZa?=
 =?utf-8?B?dWFWM1N3OXhxcjlldmZmV1JEVlk3dllxS1FBS0xzUGJibmMrbU9qR0xCWGFx?=
 =?utf-8?B?U2dsWFdqWkhSbWQvZHRRSVRSWnovbGd6djRsamhyVlpueWE3UWp6djRCeHg3?=
 =?utf-8?B?UGpiYXplbUozWnlZcDRxdlVrL1VlZCtPdlQvcm1XV0VNMnFXeS9vektNZ3RL?=
 =?utf-8?B?MkZFL3RxbldvY0J0N1VBb0F2a0NxV3lNTlp2VFpBVUlmOEY0QkNSaGsvOHdI?=
 =?utf-8?B?bEUxelVLMzJ3WXp2MjhQaE9CcEczL2JQMkpvWTMvTkIzamdLem00U25aUzdX?=
 =?utf-8?B?NVNvSndOM3J1TWRNZitqMiswbFlxVUZoZDliUjdWUy9Qa0taNmFOL1l5Q3ds?=
 =?utf-8?B?aW8vKzZnTHIxWUN3UzlYdlYvRHNGeWZIL1NCa0FXVXlEek02Z2xjbVVadS9D?=
 =?utf-8?B?K3VibWJLLzA5RzQyL2YyQlR4ZFUyRzB0U2wyNjhyZUsxM1Jsd0pqWFFYN0dt?=
 =?utf-8?B?bzlqdjJHRzUrUWJWUGUvdzViRG1BVGtxR1gwT2NNSDJFTlRNRktwaXJ6SWJS?=
 =?utf-8?B?RXAwOUNNTHlya1VKQmRia3NKNTJoOU8remFuQUFvMi9pVk5Iem5EaTl0cmhm?=
 =?utf-8?B?LzJUOUtJWlZTNUZwZE5YRFVVeGNtNkMySXpZdE5MMVpVNWFWMmdjVkhIM2Jr?=
 =?utf-8?B?ZWlKOU1pcTUrcG9QVXJycUJKTENPb1YvYmoxbDJwV3lPVW4rbzhJMnJORUUw?=
 =?utf-8?B?VjBjNUNwUWhmb1pucG5zVC81b0Vsd3VJT1E3TFJuWURiV3ZIWGxiMHhmNmtO?=
 =?utf-8?B?REdkTkpxaVU5bzZtK2ZOWWw2U1FGV1BBYUZoY0xqaG9zejM3VUdTckZnbmI4?=
 =?utf-8?B?S3FQRWc0VTd1ZDRLSjVuZit4K05ZbFN3STkycjY2UVM4aUU2UlN5NzBjZ2kx?=
 =?utf-8?B?ZEJJQ3FzK2NXc3ZEcndYZG9WU2h5QU1Eek1NdkoxR0ZTcmkzM01YVFBzVlRQ?=
 =?utf-8?B?Ti91OGE4ZS80cFRsMytxSldWRjBaS2RKWExZRkpTc1hxVXpsK1RqYTJpWjFr?=
 =?utf-8?B?V0ZlWWFnOE5pK3VqOWxzRmVhcExic01YdE41YUJxY0pEdjlxeUdhZ0pFODNV?=
 =?utf-8?B?OTU0MnNGWkV3VzhFUktVNitiVzdXUmJRRUFnTGV4YjdVTnQ5MkhIeEh3R3lU?=
 =?utf-8?B?dnVSbFBCbFJ3NnVyS3dWM281VHhMRncrVzJzbGtaeDgzREcwSjJONXp0TGcr?=
 =?utf-8?Q?aNfJVaOUkvJwNkmH2Cin+UZB9IN11eB/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVzenEzUjhhNWdIZHBpck1LSzhacFpNUXFOWkFQTkl3eEtYeStmNytHb1lK?=
 =?utf-8?B?dTRwS0FUUk1vcmRhK1Jod1YrR3ZyK0VGMUU1UklHY3IzSWdUdlNRWnJKNWp1?=
 =?utf-8?B?NndOcm9ubUxqVTFZN3hLaS9RY0ZQWmFpcTZXY1ZZSVhFUkhIRzJxRnZienR5?=
 =?utf-8?B?YlBSczVxZG04MnRTdlBhdUhmZjBwTmRIa2E0cm8wa28vZE1zWWtoNHdFQnlI?=
 =?utf-8?B?bEZoUlRvQVkranRKNG5LSkl5Wkh0dC92bXg3NWlQcHdONjZSWmZVOFBsRS9B?=
 =?utf-8?B?YjdOOUZaR21qYjBGN3FZWGc4NXRwNFIyQlkwL0E3YWdESjJtTXdoaC9XTlIr?=
 =?utf-8?B?b0ZNY0hCOThqb1Uyd2Nqb0lCU1JBdGJQYXh6a0ZrNEJhUXl2aVFoWFNhZ0Rl?=
 =?utf-8?B?T3l0WjhMWDJKUmdKMk1PTnJvbjZmWVd5VVNFaTJBRXhYUkZ2djBpaTk2aXZV?=
 =?utf-8?B?WmVEYXhjYkMzVzFrU1M0TDJGUW5YWFd4RHdhbkFMaXZBYkpwM2JoUDN1YzBp?=
 =?utf-8?B?eUpTZmsyZFR4R0thTVlkVEZneFFBV1RpamdMZURiK1pDYlZTWmdzR3NpcG9r?=
 =?utf-8?B?SFVZVlFJU2doMW9haGtRd1BRODJldm82QjR6L1NZd0tQb3JJOWp4bHlueEsr?=
 =?utf-8?B?ZEVhY3lzbkhRN3pMenliSkpKck5UYlZENXIvNDB0UnlrcnRVd2xmR1A2RWtY?=
 =?utf-8?B?WWhpdzRFU0QvWk1yRmtBODRNMnZncFZXckJiS09lVTNjbkN0RVJ2TEkzMEFp?=
 =?utf-8?B?K3hrZ3FqZGNMR1RYSGEyOU02NGljd3FsOHFDMllSYWswYjYwWnp2RU5PSXA3?=
 =?utf-8?B?UlpIS0htVUxJQk4zaUFUYytBbUp0RE9GMmd5dFJ5U3NQYnR0a2Q2VjI3Yk4y?=
 =?utf-8?B?MWxjU1J1VTlQSGRlQnZJb3RUN3hIOXJ5bVJieEpPQ25kaTk1U3Qyd0xta2o3?=
 =?utf-8?B?YlVPK3lieUZjU2ZGNE5BdEJCWE1tWllyNmlsZE5Dd1NESVZaeHA1TFFJdFZn?=
 =?utf-8?B?OWIzbmdDektTT1FzVFZpZnAxZ1BnZ2hzZWZpdHoybUVzQk94NE4rQ3hJazFl?=
 =?utf-8?B?VFF4VGFDV2loaUE4MFVaUUJEZk9mRUhkN0I0ejZqRmlOVzhtVmFjRGlLeWJL?=
 =?utf-8?B?UkNzK1FuM2ZscTRGRUNnTmN5dGRoWEE5MG05SldyQWt3ZGNTNVVZb3JUSkhE?=
 =?utf-8?B?Nkg3K3psbFZ0YnR0K0tYeFdIMXJ2YXQ3OFBHRGlrNGtpN012UTdDdlllVld3?=
 =?utf-8?B?NS91MXZOY2pNMTh0RzFLQm4vUVVUa291cTU4cy82bkNWdi9HMEg1ZHJnUkt3?=
 =?utf-8?B?aElsTXlEYXhLNEo3eFhkZ1ZYTGZ2a0FveFRHK2l6RndxOVBtck4rQ0xIS1dt?=
 =?utf-8?B?VytLdjdHWGRYWXhBTFF5b08zZGVhRUc0eHRpSDBqb1hrZXVLbjhXa1E5OHNG?=
 =?utf-8?B?SnRsV2wxNnlMODRpT0k1VzVITXE3dlU1OUtYM1pzdVh2S0ZOcEJ5dGUyWTRn?=
 =?utf-8?B?dnoxUWV4K0ZZWnU2dndSWlRPNFlVTkJWR294YVVWTFJaQm82QjRTVjRMeU5S?=
 =?utf-8?B?azFkbDJMcXdXdHQ0OHYvSVAybFJLandyQUEwODBTak1UM2g5aFNQN1d6TEZ4?=
 =?utf-8?B?Ly9lVmVNWENzcWdicG5hZUM4eFBpT1NyZHNtS0JOK2dIdU4zU3owdFUyeGR6?=
 =?utf-8?B?Y1VjaWxEMmNZQlo2YVg5Rzd5Tnd3QmVFRWw1d0owS0J4aWRwdld5Rnk0OTY4?=
 =?utf-8?B?ODBFbzY1VG1Xa0plMGRhNjBRem1BTXc1SW5nTkhJSURDWDArU3NFWTU5UFlv?=
 =?utf-8?B?RzhZTzgwRGNNWE1rUkxRaXM1d3NOWUR1R20xcGZyWDdaOVZFYlNGRGY4WXY2?=
 =?utf-8?B?dmp6V3I5aUFGeGpPQnJTaDEzNWZ6RGNzVUNVV0ZLZ3E3d2VnNHQwZWZyV091?=
 =?utf-8?B?SDBBVUVtTkdEWG9iRDcycTVSbTdqYTg1NWtGbW0vM2o4WEh1Mk9HQ0xwRlM4?=
 =?utf-8?B?bXlDRy9GdlBoM3pqa29acGptalRTNjN6TU9SR1ZHR2ZURlUvMTY0TjNYcEE2?=
 =?utf-8?B?STh1US9KWElZSXJPa0F2ZnBCdEROZUozN3pxTk9lMnFmSUZIN0Q5dEJOczNT?=
 =?utf-8?B?T05MZjNZWmJVNEd0ZzlSU0F6MlFCZ2REK2p0czYvMlA1bDVXWGJnZXU4bTZ2?=
 =?utf-8?Q?7xjqPQ94vtRspECscEi85QOb/IqVvvTMm6DUVDhLpdN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c225a6e-0255-4cd5-cee4-08de3c14fb7c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 20:03:15.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux3ebMDxt9QaBUOivG8mMd3huPqa6GujHnHcU+kKZCYYp4lEbuxHtVSUVfEezQgGQVLoSBbtR64Vt/A4uYAsnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689


On 14/12/2025 12:53, Ma Ke wrote:
> tegra_ahb_enable_smmu() utilizes driver_find_device_by_of_node() which
> internally calls driver_find_device() to locate the matching device.
> driver_find_device() increments the ref count of the found device by
> calling get_device(), but tegra_ahb_enable_smmu() fails to call
> put_device() to decrement the reference count before returning. This
> results in a reference count leak of the device, which may prevent the
> device from being properly released and cause a memory leak.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/amba/tegra-ahb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
> index f23c3ed01810..3ed5cef34806 100644
> --- a/drivers/amba/tegra-ahb.c
> +++ b/drivers/amba/tegra-ahb.c
> @@ -148,6 +148,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
>   	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
>   	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
>   	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
> +	put_device(dev);
>   	return 0;
>   }
>   EXPORT_SYMBOL(tegra_ahb_enable_smmu);


This has already been fixed and so this change is not needed.

-- 
nvpublic


