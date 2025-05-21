Return-Path: <stable+bounces-145795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56DABF069
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E867C4E436B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890E259C8A;
	Wed, 21 May 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Rji5KwVG"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2068.outbound.protection.outlook.com [40.92.58.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23F20ADF8
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820910; cv=fail; b=jljOV/WxIcEschL+UEygcXOQr/vw/uUnvIW4PS1B1HJPbgSb+a9K3ZNcdgiX4bbFNFu3FwwNUJs18MzFhuGmZQSTXuaNqO6QYqRQirOeKgpse+jTrMtDpTDd6sidOhkkMWGNXvtqL+QCrVYPyM/P1I1uJnwIp8368Z9AzsjRTJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820910; c=relaxed/simple;
	bh=mNx+OJ1oLHxK9yuU+VpemgyAm5VnDOf9cHwMDf14A4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZS3jGgYkwWePg8NalPWXHhpdjIA+KJT6fFnOO5OJUkJl9wbCMrtXgeHwGP6JgTj6dJ+wpWypN94qEZbFMD38ICqY3fwbhKG+lOHfWlR2cScod0CvUIhA+8RoG8YkxkutKK/x0vlCkODHwvoH4MXgbPNQeqqeh15KQhYAhTgwB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Rji5KwVG; arc=fail smtp.client-ip=40.92.58.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/szV0HR4P2yWhZ458Dx3WD24stmvCluu8Szs+G6vhGCIP+1/G3FSKi8yINom8Qzsk8Ms5bkkNFBdgI1ichre/jPNCaenstmXtDLPU4KEA+ZPYFRpgw+oaA9ZEQ/QHwJXH31c+QRo709p8eDN2/Jwjj2UyQ3Kk+LbQ+WgfIDvpj20Fs/gyknXsqXz4oLgTsEk/jDtmM3/P1F/1SX9G+xYhEVKBwN6tw77GHBY6/uyb5N5rA356QpwzvsoTzbzU9SBT4XJJFuA+UThCDALcD6Q7BblsiDfJQk1MjOMn3n+sqdsjqx898jHIxChBF5gywfS0m/Lq5tld2v1w4HLo5Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb67Mjtdzr+c1CfW0Hao86gL11Sra5T/CITHlCRyBDM=;
 b=H5J1OURbsvdX7W85fHaHjmxDmrHGvWSzkmXvg7279qFw0yr4X/iahGO1voXmJpLoNV6UNs2PGEl/PPdF/qMcJVec7Y/1K/ZasIeFoGPJX9US4fGnhUeJY7qjKwvM25Wc5nnIpWbzA+1KNS5EETjqtkjL42FDybObXhTE0cTVq3XLdMxQTzVoNbMU5TMKz+RPjDGmBp4+vYIi0ZbDrSGCpXjLDeNQeyv1kkU9YwsPj2+ZICVrP2arxJjR4UNNnlO6OzesSdkp2FYye6aE8WNAi9NM3sPBMWoA48c7612MChOtjooAzQgjHtGHc8tGi/dMkYpvLawd/+FCPEIpjDyacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb67Mjtdzr+c1CfW0Hao86gL11Sra5T/CITHlCRyBDM=;
 b=Rji5KwVGWznN+OJBgYj/HDqTZoeDoSvpPg8D9V7Zn4nMGx5v88F7+oiRNOFKZzVMSGylIYRJtWn0ZuZz4l4XR0QN6nDbz5fQd4sL+peVmDGXGo7K2m4SO7C1QzZGq4/MUTUJapkmLukcacW+WahBAyHzkj2XYqdGcMPP3yqbyScMghBqXq3BPWhU6JkuTBb9VOMzIg5OUaIN9urD4w+29fX+jDaUy9UlcExOdAVAQYhnp8HuLTyWFiNQvx6PBW1q7BSjyGz8nPnHct7HFgRI2E5Ku0SCPWcBc1+8S4eJ8QTNlV8kKfQz4EojibLDN18mW8BmRQZ8n06lam+ccDWd9Q==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS8P189MB2096.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:48:26 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 09:48:26 +0000
Message-ID:
 <AM7P189MB1009CE7CC28220254CB7FE8BE39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Wed, 21 May 2025 11:48:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Panic with a lis2dw12 accelerometer
To: Christian Heusel <christian@heusel.eu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linus.walleij@linaro.org
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::13) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS8P189MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9de8b9-5e7f-43cf-a3bd-08dd984ca1bf
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASIScjX/aS/OnauL17RJFM5J8dhTNfLLJNxixSIGGbcCJb9oC5WRI5fLJsXol6LoQpUYecBHSs0e3DSdPgDJgbE7nB6y/sdmq5nVh46xNJFkPRFTQuAJR0XG5xJBRppppp9FD7oFLLtXmG7qd4hGirmLCGb8TsqQ1pSy3zH+AuY4i6iYUZCR8jTB7Q1/x4gZfBE2V23qhbgl4r8gfSJuYIj+iAY2ZBsHQ3U7gblNjyxvB9p8IS7M0pWLrtr/cU53prfrTHmO0m7ZAn7Cq80mcILLYQW1VJTbYoXCGFVyBsAM84iBNYwLJJBZxETGLRAA3ybm0JogWiaMOGWO5M13JZrYclWlGn50w26CkHo0FK5hZk3bXPm+jNGWzTkUyiHBuYDsluIRAYMD7ydfxn8zvtQQbyzCEucsIaZSvAlymObu5N+r8NAp2EhiwWYKIWev9T6Qcqml1/6uNYtry2d9pGNcKuQ2PF5vwNb9SZtdHvYFA+mKsTKK6KNx/iiMDcZATCjmCoD+pk2nL4DUi+1EptCfKyujJFPSN3euyrIw9rUpX/sj+Nhc2RpVv6HKVNJKZoYStn8x3Zi9PVhD4gj8wJ1diyd7kUD/iQioQGlvfxB3H0v+CTczH2lPyp0BiVYRD6V3MJvBb3soEroimnCyTmoALv9v3VqbUKB/AC7JuQ8L5PrruhpzfksqItV9qw+NpIXIwz8GRKiXhA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|8060799009|19110799006|15080799009|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUw5d1FHdkYrVXl2NkdtYUtOakpwUzRmRW1BME9ZN3p2V0dvV0E3U3NnTVVx?=
 =?utf-8?B?aHZXeWVjTWl3QnlVOU1TSlZFd2s4SVNNUmxMcjl5V1lpaDdxMFpGT0QycDN0?=
 =?utf-8?B?ZWM1RGNaeXIzU0ZQUFQzd1lnS1JNblpUcTZpVUlWd3hja3lkYk8vQ0NEUGth?=
 =?utf-8?B?QUZZMFZna21SZnpNMk5kV0hWM2dyWklMeUp1eUg2VzdwU2NpSzJ6Qy94NGRj?=
 =?utf-8?B?RE83ZStxV21MVlNqKzRmVTMxMGgwdUVVQXNGNExyR1ZnUVdwVGRoK3hBaHNs?=
 =?utf-8?B?eDVLbjNlUnBNcFllVUJidkFseWN0VUt2cUhJT3JLdzJjUG5CZHpWakFtYW5j?=
 =?utf-8?B?cnh3YTZnMEErVXZGZ0tmbDlFOEFVVDYzalE2RDRPMmlPRkRuK3dTcC9HZWZO?=
 =?utf-8?B?VmZEMFJNYkhNSUJqT212NVBtQ2lCQVhDT0x6eCttRUhZaWtnRTY2b3pJckRq?=
 =?utf-8?B?cDZ4RmJSSEVYMDIvT2tZUEhnbzMreUVZeXNJVHE5aERsS3lCOXZLWmUwVWM5?=
 =?utf-8?B?RUkvREdOd2s1UnRVMjVDcjFvb1J3anUrVTRmeFB3akhFN3JucHBqN0ZDK1VM?=
 =?utf-8?B?ZUZCeE1SL1BaWm1scGMxSVRSWmpUci9Ib1B0bjBPdElHWlQxS3dyWFQyYTA5?=
 =?utf-8?B?RUkyUWIvaUl4WWRmT1EyWG5CcVAzdXZpb3lpbk52Z2tOZ0VnNlFxRmhRdTM3?=
 =?utf-8?B?R1hBbDFSZzFHY1dyK3hhcExTczZjeXI2NmNlK293MmQrTXBJQ21SbFVFaldw?=
 =?utf-8?B?c2RNU0E4eHk0T2R0MjZlZDA5MTFqZGpPcTJpcWlydXRlS3RkLy9aQTRIYlpv?=
 =?utf-8?B?V1FFZjdVcEtKNUxudCtRYVh3Y2hzWXNENzdPcWRnUjlOQm9rNHJ0OTBTTmwy?=
 =?utf-8?B?MWNhcEpMR2ZGUEEyQnMwZktsbnF4ejdySEsxeWxDZWwyWmJBTTk0TVBaTldR?=
 =?utf-8?B?dCtHQmV6aDJleHVVbXB6aUZhUzBvNGVyM3poTXV5N09mbFlMKzQ3YVBwcHg3?=
 =?utf-8?B?ejlsbmpXUVdqMlFvMHYwRkpYbDlTalRDR1p1Z24rYlRBREtzUHI4Z3gwMGpV?=
 =?utf-8?B?dGE2SDNnYVBPZis4MWY0dFdVOW5KRmIwUUV1RGhtVmZpMTFWRVY0My9RNXo2?=
 =?utf-8?B?NWJ4N2tFUm5mSVBDbzd0a0lLK0Excno2TWZlbTkzQWhPaC9CNXJkM21Gb3lE?=
 =?utf-8?B?U2VNRWk1bmVnd3hFUGFnWnJ4SXZoNzdrSGpjT2s0VjJiTm5XRUlLV3FwTVUv?=
 =?utf-8?B?STJBLzFTeklxakhVU2hIYzczUHo2dnNERFJGZVhEdkFRUGducHZKQXJwUVRh?=
 =?utf-8?B?cDcxaEVEKyt1YXlqcEU5WnFiQ00rVjc3SVJOdmVoWHNwS2lCRnJYeVhLMlhL?=
 =?utf-8?B?c25XOXpWcjZ6VDJETElOWWRjOGVUVUIyZmUyVDBlMGlNN3FDVndiQm5qdEQ1?=
 =?utf-8?B?K2xFN1dmMTFEM25hSHFwdURSdWFHL0xLaUNSalFGY0lnZnN4cm91QlVycktj?=
 =?utf-8?Q?zdERTE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGV1WWY4b3J1ckFvcTZGQnh0aFl0ZEZSRUNEdmFDZ1NOc21meThGUzRwWUph?=
 =?utf-8?B?aFBLV0pmVTRSNmJoaFBiMHFpMUtWZFk3VTliTDZSNGpZcWRoYm9mdXZOeE9P?=
 =?utf-8?B?bENURkJReVNnRUs0MUtYb0tJRjM2U3lwejhNQSs5NkhqU2s1dmlxVXE1QlFa?=
 =?utf-8?B?WE15aGhGRnVDMnEwS2tGUklhMU9ydFZMWG4xaWplZW5FWHZSQnpSS2h3cWw3?=
 =?utf-8?B?TG1CdTg3Y2U0UDRMQUdIejUzd3E5Vi9ZT2czMkpVVVlSUWIwMzZjM3Q1L2h4?=
 =?utf-8?B?M0N2MTZ5ankrVE5YaHBMQ3lzVkJMY0lrYi9oYXlwT0Q5Vm9DajBsa0tQZTY1?=
 =?utf-8?B?YVRXbWdJaVR1TTkyYXMwei9XY045UnFvY3o0Ri94cE01N1d0dSthUlp3Um41?=
 =?utf-8?B?RmZ4TnhURVdmUWY3N01TQVpoZE1QY3RUTzZzVExsL2xCM1hWckRET0tNVGJu?=
 =?utf-8?B?ZTNuMWw3UzhhaVF5OFhJejZNdWJPMGI4MnIyYlVCNmR3RUtSdlQ4MmV6cGN5?=
 =?utf-8?B?U1Y1a0YvTG9zSTlYbmhDR2FQSVRxcXBNdC91RWhsSGhtRXpBVThlK3JDWmJG?=
 =?utf-8?B?aEs0ZXhrUWZlV0FYUjZYQy8vNngwVjdhdngweTZLV0pYMWNQTlFSVlJFdWtu?=
 =?utf-8?B?amRPSStnQWRIM0YwNjFNbkpsQ05NeW5JYVRod2J4UTZodVNwWmt0Mk1jUDhR?=
 =?utf-8?B?cVJ1ajVuN0xaUE0yZkRHUTB3Qjg1elRiRnR0cUZoNzBKYXlEa2FXSzZqay9S?=
 =?utf-8?B?TlFNejdHaTVxTGZ3Rk8vMFRUZm9CNFdUc3A3dXR6YU1kZVhDcTBFdjdLNHM0?=
 =?utf-8?B?LzNEZHFBSGFha1J0bUNEdEJ2WXlqZ0lqUUJ3aVJodE9ldkgzV0Y3alVEK2U4?=
 =?utf-8?B?TzIxU214cWN6WDlsSTZnbHo1YUhocGtsMjB3dDNUaVhjbStpTUNYVlB5ZlpH?=
 =?utf-8?B?Mld5RFVlMjFDcHpxeUFWbmkzeUprSStVTzEvS2VQMWFQMG9DN3NBcVF4M0Er?=
 =?utf-8?B?WHZwMjlhRUxXTklSTjNRcWpGU01jN3V3RTVaOGlHSmYxVFlUenFNWklnd1lE?=
 =?utf-8?B?dnJxUXM2UTRXU3pQRmJQRldzWlJWWFdycUtqNVh6WThHQmNQLzNiRUx4K094?=
 =?utf-8?B?dHdaSU5UaDc2c2lzQXN2Tnl4R1hYemNwSnhnWHRPTEFFdEtRVzErOXFpSFc1?=
 =?utf-8?B?Vkk5ZHdyZTBjcko5QmE4QjJuajF4V3p4YXNZdDg4S1RXeGk4U0N6S0tqaUR5?=
 =?utf-8?B?cmcwdnZ2Yk1tbmI0YTd0TnlSVDJiYXRmRzZ2K2VLMG56V0dEQVZ4blZHYmpI?=
 =?utf-8?B?WU9HbDR3cnQzV0hUbHpUcWVVUzB5VVRkNzVLOHZEYXUyOVpDUWw0d0Q2N1Jv?=
 =?utf-8?B?NlhTNXZCM1diK295dzdNU01EbUZydTV3bjFjNmxCM0hrdTNiYXh3WmxRTDdi?=
 =?utf-8?B?disvanhoODdrcHYzTEZVSXJJZTB6VytCeGoxdUF1ZGdiekgyMVp2aTNNWm9Z?=
 =?utf-8?B?REFIZmJKVDI0bkxaR1hROGZOb3gyYjB0V1dsR1drOXRJem9ieFRueUdHV3F0?=
 =?utf-8?B?NktxQlNoN1BiUU1ja2M5SlRuS05sdFNWYnNYb1hWWm9WSFRtVHRlVGxSZzhK?=
 =?utf-8?B?VHluZytVWTM5Zy9neVlOSTdwOGtaNWtac3RyUzJwTW5XdGduWXVWSjNJdERv?=
 =?utf-8?B?SWNlSDdtMU81Z1dNUTlqQ1RwQjIrbFVORXlneEcyNmpJQnN4ajFocGZLZ0lU?=
 =?utf-8?Q?o58HX6pwwGv9VO2dLSa/lUxc10qXYJBmItEaqS9?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9de8b9-5e7f-43cf-a3bd-08dd984ca1bf
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:48:26.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2096

On 5/21/25 11:29, Christian Heusel wrote:
> On 25/05/21 10:53AM, Maud Spierings wrote:
>> I've just experienced an Issue that I think may be a regression.
>>
>> I'm enabling a device which incorporates a lis2dw12 accelerometer, currently
>> I am running 6.12 lts, so 6.12.29 as of typing this message.
> 
> Could you check whether the latest mainline release (at the time this is
> v6.15-rc7) is also affected? If that's not the case the bug might
> already be fixed ^_^

Unfortunately doesn't seem to be the case, still gets the panic. I also 
tried 6.12(.0), but that also has the panic, so it is definitely older 
than this lts.

> Also as you said that this is a regression, what is the last revision
> that the accelerometer worked with?

Thats a difficult one to pin down, I'm moving from the nxp vendor kernel 
to mainline, the last working one that I know sure is 5.10.72 of that 
vendor kernel.

>> This is where my ability to fix thing fizzles out and so here I am asking
>> for assistance.
>>
>> Kind regards,
>> Maud
> 
> Cheers,
> Chris


