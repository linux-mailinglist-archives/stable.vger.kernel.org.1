Return-Path: <stable+bounces-192389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C51C31499
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6CE188BBEC
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5D2C11D1;
	Tue,  4 Nov 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LPSWmB3y"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012782F617D;
	Tue,  4 Nov 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264011; cv=fail; b=J1/dFkBnV+EKPXjTa4tZxs8Q4LkIrK2L+LbBgq5G/s4UMOJhtggBBPdOFRFvAJfF2OabWJXt3y8c614SxKQNEJovuZIHnGsz/e5Fn0OmDVzienJXORpYJipSICoTwJEk2e4WBpm1go2mBF3SKiUw0K1I6anh3lineJnIQ9ac4yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264011; c=relaxed/simple;
	bh=XcGtdTPxu+scuIyTRFwY2jWYsSyu8N6IPPlaG+HfHTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2DUMpyVMxoS5V0tJFizsquNMzYHiJAlI0P9EKqrakLQc+Zmf1fA8W9mGLNRhcqtAVi9TvGIcGyWvUiS2v85v4Sa40KPaMjNjzin/bVqU78X6HWtIEAwFxfX1qlYEV0+JbobayQzq5DL7J5vNq5hjzNffnq8tOx/dB2haDlUWbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LPSWmB3y; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSGToMDztyfuqN8+fv/+Btw9yxqJrFirume/o/2HN6c8T21QcORv+umdCdpMT021taPL6jOBsFWoQlfYEAmkxyS27uEGJQ917z7+vNr1iKTSO3BT1kj7jUdFVOLtf1lcw9IjXVp7CjZew0pS1q4+pc5VbOMmGl84bOTmvDFYfNVQFuZn8z4HOq1JPyxvwVSGhZGcpSvGLZn+XYzE3QSGCSMqnXFJDiaJoTyVfktpQUabo/ReFJgFzZTLjWm4QsCU2zjkK0Z01v/tHKkzW08wDY2GmRWrmB3RiU31QGDxe5qk9AnnbCcI9qpkhcq6VdhzuddElrswGIZuVo8Aww976Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EibRRfvwj2+mb3CbsEDKTmy5FpyYyEL74YtFCB+dKA=;
 b=rgMPnm/yyBWwOn4zSPzERB2nH+nEBF6nGEcwpdmtxIX38NlWuHCYRWT2V91QApN2qQsDp7bhQKjLyZsKT5gSPfFiSqU3d789nWFxaCzwVj81Hv85upH5Oz7SmFDqS0gzewfA5PuB9CSrL5tZRbqOycjEPNkDB4Fz19DUFXicfcXCMxaSDo4HPLwbjcgrSxPaun9KV/5jgOfrEL/GRWcoj8SLoNOXyfJ66YpkmC2DEnfQ9O6odvzFz4V3jWKnl7zL+8nYKgFxyK23vYF7Xm5fzD1dw3nbXhEURpJd2TKYsJ+DEU9TpBkv0K34NGgUq7Rti9fN7TCzwPy1TiuBRCYcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EibRRfvwj2+mb3CbsEDKTmy5FpyYyEL74YtFCB+dKA=;
 b=LPSWmB3yq7zatLsPFhJhz60zgVP1HixE1xcHUrvW56pIIx6srdn09DN2lAyxOP7xt6NoC2QHKL3UwTHTF2l5DEF8ueqGCtREb9fuqOhwyamf1HMFgrYka+A6MDaIHhWl26Xq+7havDowatp3emuZMXd9GSapviLLlpLFkkPd2ihdBEDM98yON2OjHpvihvi8DQkxUvF+HtgkwNzyTc86iVbkoX+NuPgooyU2/HcTQTVG6QAtBsSZ/6peq7tjnJpnRjjyHuQUgXcxErIB8Y4rGrfSrC689ikUxwFcfA2l75sp+6WFlLm87/sChnfrcAvvP9D43jv0RJ4wcCcrKRLTgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:46:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:46:41 +0000
Message-ID: <337a36a1-4b59-4e21-ad97-8154eb3ae8a6@nvidia.com>
Date: Tue, 4 Nov 2025 13:46:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: Fix error handling in tegra_xusb_pad_init
To: Ma Ke <make24@iscas.ac.cn>, jckuo@nvidia.com, vkoul@kernel.org,
 kishon@kernel.org, thierry.reding@gmail.com
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20251104012820.35336-1-make24@iscas.ac.cn>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251104012820.35336-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 30407011-14c1-4a1e-7cb5-08de1ba8958e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzhsZlBsUm5BbTZpUHNjRFhXK202cDk3Z1dGSlZXUjBjTkNGa0NqZVpFNGpq?=
 =?utf-8?B?ZklzMkFTektwTHRZaFVqOVM1V0V5Z3hrbGwyQ3dmdDgxNXpKaFRySlN6R0Vk?=
 =?utf-8?B?ZkZLcEJNUCswZ1h1MjVIL05uV2tnMkVRb1BBYjdmdnhVU2djTWYwNWZ5ZWI1?=
 =?utf-8?B?Ykg1OHZtZWFCUnUya3o2Y2NYeFpJZnhSMW9TQnpGeEY4OVI1ZzdBNkczU1Ev?=
 =?utf-8?B?V0QrVTJxRzNCQzhUdStqU25aUWpFSXVJa05pa2FTOXZBQjljVVo4bzZqZW94?=
 =?utf-8?B?WG9VODlIQm9UbDQ0WmxjZjZuVVgxVEJwSFZJK0s2VE15SXRDQ1RST25mU1Uv?=
 =?utf-8?B?cGovVTZhemVuelIydjFlTE9reEx0M0ovd1EvdzZxbEJrdE1QanRUYXZwZmRC?=
 =?utf-8?B?OEt3Slcvcm0zU1FLaHpnWkdHUjMzd2RRakRjUTVMaWxBUmZVZzNlblVxOHM3?=
 =?utf-8?B?NTlzWjgxc3NhL3llaFpBeHUvNG1uYVpxYmtiTFVNZFBNMFJlRDlMVWxkdStM?=
 =?utf-8?B?ZWxMb2dYUk9aaldSY01TQlNwTmtXV2g5Z2tDZUlWdjhuU1RKdmFKTWZmU3FQ?=
 =?utf-8?B?M0xhdDY5U0wwWlFTdE5zZnFudDBYUHFCZit2Nll5UmZ5U1FzK0l3VlR1T2sx?=
 =?utf-8?B?MklINzZDNm1NV1JIZXdYODBWNG9NL2p0MXIwOVJHSEFDM1VVa1lhOFpyY2t3?=
 =?utf-8?B?UFpTYVZkdy9jeTN4ZXVqczMzeXZiU0lTQ3VETFN2dmRTYWpJVzVRTVNCeEkz?=
 =?utf-8?B?ZmlRcjN4cUcxSmthTmh3N2NjOEdGVit1YU9sS2Y4WUk0TEhQVWwwSnErRkRx?=
 =?utf-8?B?U2lpRVN0eWszOVRDdGlNRmdxdXBqNWEreSt4aWxCUGo0WFNoTGd3ckU3YUpq?=
 =?utf-8?B?ZTN3V3NFcTFzc1h5cEJkUGRUdmFGWDYxYUcyZnROdjNkVnBxN2NIYjU4a0Nu?=
 =?utf-8?B?ZXUvb0lhdGJ3b0ZuMUhQT3VFSzRCd2JWUU1tOE5hMlFDTmk4Rk5nMFkwTXFt?=
 =?utf-8?B?cVpRamxTSVk0YVJKUzJpM3hXdGVFNXVkbWJVSVZXMDBkbnk2ZzhxZFF2T1Jj?=
 =?utf-8?B?S3pEWjYyVW5SVi9yNFVOaE1OcXBGdTJpVkYvcGE5ZFVwdVFXR0dTR2J5dmVu?=
 =?utf-8?B?QnpzaDRXZEhEMkRlY0wzRUpwak1Zbk01NTMwL0lhRGVReFQvdjk4VUF6Y0J3?=
 =?utf-8?B?MCtjVU4yNEFBMkZuZGNzOGIzUXJwMUxocHR4R1owS1FwQTAvSUZidGJMdmdo?=
 =?utf-8?B?RTNTT1lHdzRDMFBpclU0aTJYaXE5WTQ4elkvYVRwZVdhRXpkVG1CZFFhWkZH?=
 =?utf-8?B?RjJOeXk5WVJadjlRSVBMUUh2VGdYVk9TZkdYc1BibXgzcEM5U3gwOUI2SlUx?=
 =?utf-8?B?bzNHa1hGMkplMXo2S04wdFZZazMySXNXZHNxN1Z0aEc5ZVB0UWNkZU5mbTkx?=
 =?utf-8?B?TXk1Zng1aUJZYVFoTUF6cC95bmxSZWY4YVlMclFmZ2t4dEZFQWFsRERtRzR5?=
 =?utf-8?B?bmRXMUhKTDRMbW5HT21Rem5raGp1SEUwZThSZ2dieG1EN1g4QStCY3FsTjRH?=
 =?utf-8?B?RENJd2NlMWFTVnd6cUY4TFhzYW1WVlJram5HUjEwWC85a3hybGpRT001emh4?=
 =?utf-8?B?Ky9SZHA0NW1kTExMem5VQkFaVHVLTk9yemZMMmNrdnJwdSsvcHNJUDZiMXV2?=
 =?utf-8?B?R3FlMi9YeFNXckZ4NlVlUW1uay9weHd0MmwzT0RpSmgrNThOV2NodkFrYmZs?=
 =?utf-8?B?U0VkM0ZJUDlRZDVhOHNlYjJrNUwvWVdUc0NsYi9MaFRmOFRCUURMZnRob3ZH?=
 =?utf-8?B?MWlGanZRbjZDTTI5WjN0UEhXaTZoeFZyUVQ5Mlh3YVB5NHBJTXRONVYvQUpG?=
 =?utf-8?B?VGVLT01HVUc3djNtUCtiTllXMHBmZ3E0c3EyWnVKV25XU1IyaWZMYVZTUE5y?=
 =?utf-8?Q?ycIPywBLuwVXmip/dJKy/ythnO77xV8h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODJTYXVFSHpvUk95Nk9zcHZHMUZMYlU0TGNScTRuZXhTSi9RSDJSK0M0cnZw?=
 =?utf-8?B?a2FickcxSFRmWHlPUWVjaFhBUXJTdkMrOVdUOWZsL3hQeTRMcERocmF6bGFE?=
 =?utf-8?B?WFpnTjVCWTBTTU5LZnJmZW1Wcmp1cGRTVnFoaGRNT0Joc3orSS9kNm1nd0Ev?=
 =?utf-8?B?V0ZUOXZzZUY2eDhEREVJUDVTbjFnaGc1RGN1NDNHL3E5SnJtWTVZVFhrV3RE?=
 =?utf-8?B?aThXT2c1SDBHQlpSUktjQktPWGVsK1NNYmhjc01YcEhJR2RvUFdEUURiYXpx?=
 =?utf-8?B?UjhibHRwYzIrclk5b2lyb1NWa3ZONjltb0VNS21zNER5UFNnYTNuWGdPSXBt?=
 =?utf-8?B?Sm1XS2lsUDJOYWlyd2h3cVM1QUQwcXRlOUZjL2NFaUoxb3V3cnNiVEtyYnJR?=
 =?utf-8?B?QXk2Sjl2QWpFSEZ6eFVTTXlYalRERGowZHRZQjM4dDhvS0wraFR3VDlJWGdI?=
 =?utf-8?B?ZzBXdzdDc2dLVXFNM2I0aE0yR3dncWJnTjJaYWlpR2RsK0NkL0J2UUpqNXB5?=
 =?utf-8?B?N3FUYi9XRzJOM2MycGx0VVRGTkdidmJCWldOSWp0YkdXU0pzdExnVXJuaXAr?=
 =?utf-8?B?Y0tqYk55ZXpNdUVHai9iOW84bEdlSHRUUm83UWFxSkM1V2hET1JGc3k1TW9n?=
 =?utf-8?B?UHF4dUFrREVLZWNsN0pIeXl6QS9WV2xyOGZCUEFvdmlvRVJndERFVnBPQmtD?=
 =?utf-8?B?c284YzlPNDdaV1QzN244V3VFc25PL3FBa2JqS205WEVUSGtDeForanpjcTBa?=
 =?utf-8?B?OGV2TTJIY2FaZkJ4L09BdjJITWh5WHY2OTRCQUlEdjhUZjVYVDVqUzhvNlpk?=
 =?utf-8?B?a0tPcWlhV1NZeUVyV0VrM1p3dlplVjFheERIWk1ubnRxbC9RU2JRMDRBWDhV?=
 =?utf-8?B?d2NDd3VrUC9JY2huTjdXdExFNkgwejQ2MzN1d1RNdzFLNTZLTG9iSjNtS0w4?=
 =?utf-8?B?SFFYRnkzNmxBeGEwVFlMSC9ySFRGaDdGVlBJcHpXcjV2dlMxcFpaY1hxQ1do?=
 =?utf-8?B?MHFVb09zbENHVUVSTUM2Qi9QYzB6c0JBclp5QlNBL1d0SHhSc1dBSEJWSlZ3?=
 =?utf-8?B?TWkyaUZNZ3poemN3T3k0T1VkY25WazZRUldjOXR5NzBTWkc5eXdLVm9IV0kw?=
 =?utf-8?B?cC92RUROYmlHYWkwTjVsaFdUbllIUnVUWFNjcktJV3NsL2VtNjNFakFnVmJ1?=
 =?utf-8?B?NHdTR0ZadHQ1enFQVDlyVmpQSmVwUWF1NzYxRlZZOE1RUGVIdE5mVXRZMndE?=
 =?utf-8?B?OWRsenpJVG5vV3RDUkY3dlNvMGkyQ2NiMUFLcWxiMmZLenpCclRpbHVFNXFh?=
 =?utf-8?B?aWc4OXRIL1JHcHJ1RXJaTVRKTlNHYkprMEQ2Ylc5YWtGMU1saFA5ckViNTUv?=
 =?utf-8?B?eURtT2x4SWhBNG5RUXFNK1N2WHFDYjd1TTZYY1o0dm1PSkZObGRPSWY5Z2cz?=
 =?utf-8?B?R2xlWmJ0dUUvQkFLbjkrTnRKVExINTJkVHUyN1FpZmJ2WlpjME80b1FqeHAz?=
 =?utf-8?B?K2lyeVZKaEFXQzZlcDFqU3lRMFI1Yjdlb2I2MThxd3VjcTBEQTBVQ01sR21I?=
 =?utf-8?B?ODJDeFFOSFFsL2o1SVpFdi9JZE44SzVuSFNjcGxZYUJBVGRQOHVjOWhuWkQx?=
 =?utf-8?B?ZGhUN28vV1k0UzJ6WDN0OFQ3bS9MZ3VKODhMSUxFZFNER25FdzFjUHpyUUZj?=
 =?utf-8?B?RGdLNWV1WTFLbHc5QVVzUEF0QjN0My93cW5CN2Ezcmx1UWQ4aHNPUWZIYUhO?=
 =?utf-8?B?QXo3YWxmRk1xallCVWdWV1pWMUpaUUFrOERQd3hXMnZadnRDWUxwWGpBWnEx?=
 =?utf-8?B?YzBJbUtUb1lkSnFLaTZ0RkorSmloRThIL2FUUHdMYWV1V3FxbUY2MERJUmg1?=
 =?utf-8?B?d1pyaUhCVHZsSjFXczh4clkrUEh6RE5nSzR6YytmYmNvZjZ1eGRCeGdncHBi?=
 =?utf-8?B?bExWUkhha1YrMHp6Rk5rTDZIZ1FBM21mcGc2NE9hRjhWS0tSMlFxdHJrRi9P?=
 =?utf-8?B?cmxoZC9xdGpKMERnb3pVY3MzNDlMN2tjRytscHNHVWtEb3B1cGJnQ3pIZ1BP?=
 =?utf-8?B?cFI5MzRTQ2NYWWxyY2RmZmJ1Y1NBOTI4eXM4cUMyM1N1ODNyTGJIdUhNRnox?=
 =?utf-8?B?OFdwclVER1M3bUN5Wm1Odlh1YmMrWXNrMGMvQmI2WmRJSEEwSjhEclVVWDRw?=
 =?utf-8?B?S0xBMmwxeEFHaDFLeEdqY0lpU1lpYTJDS29VS05HQngyMGpnbFhySHVZK21T?=
 =?utf-8?B?ejBxYVB3TGd5VzdqVTZRc2g0SXpnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30407011-14c1-4a1e-7cb5-08de1ba8958e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:46:41.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGoHQvAOHnGCbjvB2cqZKkhl4AS3BCq0YlwSdPbHEyv/NyywcDkeQm+wcigsFPWQuxlKEDhslssiw5vex/DlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478


On 04/11/2025 01:28, Ma Ke wrote:
> If device_add() fails, do not use device_unregister() for error
> handling. device_unregister() consists two functions: device_del() and
> put_device(). device_unregister() should only be called after
> device_add() succeeded because device_del() undoes what device_add()
> does if successful.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> In tegra_xusb_pad_init(), both dev_set_name() and device_add() may
> fail. In either case, we should only use put_device(). After
> device_initialize(), the device has a reference count of 1. If
> dev_set_name() fails, device_add() has not been called. If
> device_add() fails, it has already cleaned up after itself.
> device_unregister() would incorrectly call device_del() when
> device_add() was never successful. Therefore, change both error paths
> to use put_device() instead of device_unregister().

Ideally, we would make all of the above a bit more concise/simple. 
However, this does look correct to me ...
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the Fixes tag;
> - modified the patch description.
> ---
>   drivers/phy/tegra/xusb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index c89df95aa6ca..d89493d68699 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -171,16 +171,16 @@ int tegra_xusb_pad_init(struct tegra_xusb_pad *pad,
>   
>   	err = dev_set_name(&pad->dev, "%s", pad->soc->name);
>   	if (err < 0)
> -		goto unregister;
> +		goto put_device;
>   
>   	err = device_add(&pad->dev);
>   	if (err < 0)
> -		goto unregister;
> +		goto put_device;
>   
>   	return 0;
>   
> -unregister:
> -	device_unregister(&pad->dev);
> +put_device:
> +	put_device(&pad->dev);
>   	return err;
>   }
>   
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


