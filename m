Return-Path: <stable+bounces-125673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DDA6AACB
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE57A16F78F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CB1E883A;
	Thu, 20 Mar 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDev4dpz"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE41E3DC4;
	Thu, 20 Mar 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487055; cv=fail; b=BlwvzUp8fX0LrumcqvEq5sxKXJW8F/Xji2LfzfsL6yvQmpAGvep1zrb2/0fkZ1UG2eUL6TjBb2dAJceIfpq8XiOY++ySSUqQN9nBb7i9JAHBwPDFfPeCGpSbHqHbL0veXnQCy89By8a7IYTTROTS+IcPWfri/r5Ts0pUSkvIL3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487055; c=relaxed/simple;
	bh=gUZS9MqK7QBeBO240Re9tCGHI+kQp5rlVhbfR9LDrGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRP+laj/WvqhpsOrFBDV+T0/LRxDtWZriSsobNfnQLkfcIpTCEklMTdJSkVijyZxdD4LRFYVTt028+MDwywVqWktMgYv7mI9Fe5WOMn7VXsXgIgpvQW2UnqojB+Rl7WwhG1wYU5eCf5rDzouWaf38gTs7PBWegJO7ESwxqkt86I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDev4dpz; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLnBBnmECDzZP0lUhIe6Nd0qaXBnTCTv/LS0eKv8ajSPh1uY7h0QS0an/IAYb0Lzo6iZALxkk7jI9n9mNFMDJkZK6OIkKqywm7oN94KEP+g+BJHkz8CrW9tyPQG8JjQ3eg73bFqOA5YYoB3iffEDczYeFDJe/8OUF5RHfidyHLuCPCvg5y/BSrADAw0vXuQjKrCJXvBnl6XbkQ9CtGCiFSF45i099J+TsZCTsXEoGc/q6j7YYJxH/rtuu39XvqDjQi/wVYmxtjNdwAOrLEuiZ1vP6JQ7XvwdEd4K+NYh8SYqQng1u0iTfu6mRRNo1xBZmK8bDYvQLkx28tQTWWlMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q6/c1f9SAeWML5Jl14E0zFX/6aruu8NAFrMm8UNiX0=;
 b=KCaS7mUJ/uOFnP7ExJK/F4o0zdRy6sM7KFQBku0TX9+Qdb/Xrmc2AsEYuIqRWV6MYl+/iZ9wijg01HXzNGlbpbiwsfmHG4XBdkxzRT6GW2RCdvdl8K/FmJs50eaUIRj5d8kMxcya6EeomAC4zJwPsNK9KCDwowBEkP5E4ULSQ4B7KcgHxzq9bZTPqphVDH5Z8NpFBFWwZlQn5DznIdSo2WPxomRzCVy9pweco9yVmCJBeqTGb1qDmlkylzUJtAVObV/vFo2Otia3OUBSd3JEt2pRDvd1jzJX+PSZ3vD349DoCiuuFtVo3KU/nuxmIBBrsrWwf0J7sWoqgi5rhwcuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q6/c1f9SAeWML5Jl14E0zFX/6aruu8NAFrMm8UNiX0=;
 b=NDev4dpz71TNKq2atkQLy56E1ToK4sjw9PdIXJ3DVzA+3716HbeUwH0EZydeW44X6R9OYV79oN6r4Wu87/DgtL61Pg7KSC5Hqnej8W1gzrwl3AE2ls5lB6gufnp6lZbziXbjpKr1qpiy3YXoglpkikEudm6vqcWxX+aL9cHHogciUsdZN5YodU7+b3jsFcMDASA1u0VE4B9+Q/oqU0OAllulPHvbdES7ALPsjhUnpp6TXROcpqPAZee9Brbn/F1cHQQRp4TyOHCZC+vEt3BFvW4YyKBA+OlcF/nAVKkq0W7z/M4o0bU5HX533+zr67ORvTZtqjuCMzRf9JkX8Sw/Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 16:10:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:10:50 +0000
Message-ID: <052cdca4-4fc0-4ea2-ad77-e8a0209833e7@nvidia.com>
Date: Thu, 20 Mar 2025 09:10:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
To: Wayne Chang <waynec@nvidia.com>, thierry.reding@gmail.com,
 jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250314073348.3705373-1-waynec@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250314073348.3705373-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: b43dfd69-7098-4cb1-64a4-08dd67c9c81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFh1NWFYNlU2ZnNWWFRoenhkZk9XaUs4azJNdHBERHhzVWhWVjRiSlRUajFa?=
 =?utf-8?B?LzR2MVIxd1d6bFU5SGpvQUxERkx0amNSSTgyOXJSSzNWUFBHK3BaVThSc05Z?=
 =?utf-8?B?aEtmQ1BwV0VGSFFHRGVWMzRoN1ZvYTQ0aHRDamZmMWdWMUFkUlE3QmJNcFBt?=
 =?utf-8?B?RGlBalRUUFlNcnVhUTRuT3hSOUEvMWQ0Wk15clZzN3p3TnlibE9objQ5RkJ1?=
 =?utf-8?B?TlFUMlBzQS9EYVRCK2d6YzBHbitmNHBHWVE2blFJSG5UUFQrL2tSVTJzT3Fm?=
 =?utf-8?B?WDdSV3FTRGhwNGpCdlVROTNiWXpMcTNEN2d6cDlrYlZmM0NZSnhjVzIrVXV6?=
 =?utf-8?B?TmU0NXVwL0dZMEJDc1hnOFV1ZWNESEtPTnA1SCttNkpjWEc0ZHUxZ3JyUXh2?=
 =?utf-8?B?L0pNdVNBWFIzbTBOOWY1dW5oY0YrMzRtUEhNY3JIZUp6ZEhmYUlDL0FtanZ3?=
 =?utf-8?B?NWNFZUdKZXE4aUFhSTNGMGJVR0pMSElibW9WWTZ5U0ZXOUFialB5aGdRbHdC?=
 =?utf-8?B?TnpUQ3piOEJiQkYxUklLQlZWTmIwdGlGTUluRExDVnJtYkdxcW5OVVFLSWhC?=
 =?utf-8?B?TG1oWVFuWjdXaVFJMHZMREhXL0VXb1Vnb2Z3Q1N0YktTNkQ1UWphNXNLYktG?=
 =?utf-8?B?cU1TTkt6OVZ2WGk0YUJScTl3b2ZpNlE2M1FYN0tTa0dMakkvNWJBeEUwbjRl?=
 =?utf-8?B?bkx2UU9IbU10cERvNDl4ZHk3RHpqOXVMRUplQWM1YmtoK2R0L29VVXlob2Iy?=
 =?utf-8?B?YnhaTUFaSzhXdGhveGNES0xJN2JVZ24wV0ZpeGo0VjBJRURKbFZaN0FaQ0l6?=
 =?utf-8?B?WVYyTkVSQmUzSzdJZGdkNW52SVBXaSszdUwzTjN0cFdKZW5hcWxIM0VqZEhQ?=
 =?utf-8?B?RzRpcHhTY3B5SjRQRFJFd3NQZ1dPckplUFJZdkVadjk3U2J2aTB1RDROcHVa?=
 =?utf-8?B?bjlnZXVybGlsanB3TUZpQk9LL2ppaWVXQmk4eXFWWEtGS2RiS0c3YmlnMWxo?=
 =?utf-8?B?R3UzR1JPdWRkcVdDU2VzM3BKSHRabmZMSVQ4aXIvQzJmcGkrcWVzRmNVQ3Vw?=
 =?utf-8?B?TTRTbGJiYWZRTVU3NVkrRGtnVVRIY3hYWEswMGYrdHdBRVRRY3FIeWdYQVdw?=
 =?utf-8?B?Z2t2OG1USHZpRDRESEUxMTZjRi9rSXp3UWhud0NDUmE0OGVhQ0owbkFGOW5C?=
 =?utf-8?B?OHd4Y2tmaE83R3pBSGFoTDVRTlFlbEV6VnA0MUgrTHdiQnRURnoybXpNRHQ4?=
 =?utf-8?B?V0pGdVcxclJyRzlGUVJuZ2ZTc1VHWVY4WjdtL3M2a0kxTUZaanh0S05Ndncz?=
 =?utf-8?B?SVlpb2VQb0JOR091NzlTTlpGUDI3aCs0bzZ4c3pFNHJjWGtvdW4rQTFQd0ZJ?=
 =?utf-8?B?RU5rV3kzTUVFN2hJMWRSRGU1Nm93SjZ6bU53ZkltVjI3OTFTeTJqR0YxeFZm?=
 =?utf-8?B?RmNWbGpFRjl2NEc0YTZvcDNWRVZlSUltQmxUUmRUajlmQ0NNVWh5d3FCdVNH?=
 =?utf-8?B?S0c1dHBINm9KTlIzd3R6QmYzRzNaT0NoYWhyTjVoNEFsYktrWDBBMTBPeGhR?=
 =?utf-8?B?eW9kUFo2aEFnUzRDSnVzNVl4Q2NVRnA5cXU2ZHcwQ3hWWkovY29jSnV2dGZ6?=
 =?utf-8?B?eTZOU0h3bzMrVWRtaDFHVFptaHdMY2tFWENBV3lzQW1TbEFWQldJTUZmZUp3?=
 =?utf-8?B?VzIwODRNUDgrejc0MVJjZ3h0SDhsSDJ6WkwwM2prZGpPWWdDbEVwY1JmSFdI?=
 =?utf-8?B?ZHNYUENLR0VjZ2RXU0dvL1ova3luajc3bTRNK3JqenE1N1NaZmcxRUNxcmNp?=
 =?utf-8?B?MDkreHJRWUxybXlVblJXYjZGck16eUpHTnl4dkpyY2RTZVh6WDBSbnlySlVK?=
 =?utf-8?Q?SdSFzv3kDk8zY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blk3S0FyZEEwQ3FoVDNXTEJqNzlVbUR5ejFXSkNXNEV6L2FhdzU3bm12Q1Bu?=
 =?utf-8?B?a0VkMlFNVllxMDYrdTNCMWtncG9PTG00SXFoOHNkZmVsSFJack9wTnZiWDlh?=
 =?utf-8?B?Z3lzTi9KSjV3MWRMRmFCSzJlTFBvdDkrTlBEbytod3N5VDZFdGdWRmRqMVFX?=
 =?utf-8?B?QTdGQXQ3OElRb0JSNWlTL21icWtEc0VFaHNVMmt5L0l0WGRSbHJNaTFtTjhz?=
 =?utf-8?B?amtuVmRyMDN3THloN2lxMlJ4UjZiTlBhaDRkNG5GQWdjSTFFam1nc0tQbmRt?=
 =?utf-8?B?ekRSMEw1eWZ6YzA1UzU1dytxdVU5TGtHeHY3ZW1ycEE3VTdKWE1nV3Y2U2p4?=
 =?utf-8?B?bkNkUGc2bUdqelgvSXpLTWVmTW5NbzVYVjFCWUl5NzY0VVFtQ1RaSUVnQVN1?=
 =?utf-8?B?MnZRdEtWWVRCWTFoSzltVjJGTlFtUHF2Tldra1J6SmphL3BjdStqTkt4TTJx?=
 =?utf-8?B?d2lhZlhZT0RUNHhRc013bk9naElkcGI5Rkd1MVhManJtbk5DS2FScnk4K1RJ?=
 =?utf-8?B?ejZpaUVzc2k3cE4vL0RGbTFxdkhPSk9SUENDd254ZkdIZHNzbmNqZE5pRkIv?=
 =?utf-8?B?bVpjbUowWWJpS051ODVLRko5aHh4TTgyTm9hZ05NMFpNTTVtc0tYUHV5bWlh?=
 =?utf-8?B?UkZEdkdMZldXa0JvK3MvdDgycnlMUDBwU0hsL0NyY0J4b2RQMGNrejBMbUVp?=
 =?utf-8?B?cFRWTUJVVGRiQ1VPdnJBbUdIWXpvN2tyd3NHZ1hucmtTZUlEN3FPTmI1Nlhr?=
 =?utf-8?B?YVJjd1paVHYrcTBNazRoK09TMEpUdVZTdUlhd3o4WXpCSTUyUHZESkEzQmFB?=
 =?utf-8?B?MzIzMmx2MC8zWXlCNWs5VDFxYTBhTHVGSnJTWjhVVy9GajNkUXFHc3hwN1Bo?=
 =?utf-8?B?STVqdC93dlZ5K1N5SlA5R1pTWVNFaytzWUxXQmFidHl0ZDRMVkVxdmhrbUxO?=
 =?utf-8?B?N3lVaWxmcGJvM05FOTlVNklELzFmMkJGNUZGcXduTFFWTE5zWk1aeU5XYnQx?=
 =?utf-8?B?VjlIa3dITXBhSlVUQjd4OXl6ZG13MjFqTXJ0UXkyQTBGVGpHSlpEZTB4YmZu?=
 =?utf-8?B?Qm1oWjdwN3M2aS8vbWVHemU2Z0ZuR2dNRHJHaDd1LzdtWlVmZkxURDNnM3R3?=
 =?utf-8?B?c25JZ2JRVlI3V2dER3oyaEdDNGErT1M0Slk1bWtHeHpYZ2xUa0RBNUQ3RkxP?=
 =?utf-8?B?dmZwYS9NdDJPNVpGUHhUTWRLZGF6TU16TzJvSG9pd0FId1h0ZDhlYnNJMExu?=
 =?utf-8?B?MlkzMWJtdDhwd0I5YnY5R0hrcmdNZ3NoNk80MjQyeUVFM1VSR3dQMng2Q3JT?=
 =?utf-8?B?dkVPVTU2R2cwcmdlSEs2NHdEODJraHh3TkIrTmUzN1RENUt2OUo3UVhVVDlq?=
 =?utf-8?B?Qnl3eHZ5K25zdkFrRHRDT1c5RHVIRUxTT1BhakpXVC93NVJ3TkdxYk9iaWNP?=
 =?utf-8?B?WXZud3Rxb3VVbExMZHlOTWp5OFA3SUY4ZEE4Uk9PYzhqRFNvREJDSDgyeU8x?=
 =?utf-8?B?QkY2SnhjRTdFRmNPZU92S01iSjVFczFlcW1BcVlnbTk1N3RDSWVvQ016Tldi?=
 =?utf-8?B?QWx5ZE92bHpHN0NaOUlYSEh6aUoybVRsandTOFlGdnNEMld2dlVvNCtlenVs?=
 =?utf-8?B?RmluV1NLNlFNeXFCRW45UXVDVFp3M2J1a1c1bjA4UGIvNE5XTjZ2eGJFd29J?=
 =?utf-8?B?dGh0L3M0RnZVeXdBaTBES3JMK0dXdlZEMUovSytJd2JwRFdHTEtLWTZtN3Js?=
 =?utf-8?B?WVhqTk0vSmdqQzNqMG4xNmpHMmZZL0UrZm4wNWJGRWE5M1JDeXFXeC93Rk5z?=
 =?utf-8?B?MW9nM0NaM0ZHcXhnTDBDUGd4a1d5NTBhcTlOTWZlc0dndTQ3ZXRMWERwVzBS?=
 =?utf-8?B?eVFRWS9qZ29jaDBjdExBSHFuNDh2ZytWT0F5blVJOXg0a0VIdHAvL1lDL0tF?=
 =?utf-8?B?bnlZTTh6eEZjSGE0VzBrUVlYRGVqNTF2WGtSVkk1VmE0THV3ZjkzK2pYL0pL?=
 =?utf-8?B?ZnRTWjY5WTExL1ZjeHhraFo0eXErOEFqU05wNnZoK2pSdDdGMmNXL3kyY1d3?=
 =?utf-8?B?U3ZKdGEyM3FEbk9FRmh1WGJvNXhJbUtWSlRXc0NYRE90cXgwQ3FOZ0lZaXcr?=
 =?utf-8?Q?wV9AnCQ7fbdqMoubwlC2ZMAPs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43dfd69-7098-4cb1-64a4-08dd67c9c81c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:10:50.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtLgGSC6yZCnBYrKvX4aXDbTwS05wDP/ht03W7qtB2U3tIgY/GG/8AA+n1IDS8P4SqaZR2aSloz6bMhONOIBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963


On 14/03/2025 07:33, Wayne Chang wrote:
> The current implementation uses bias_pad_enable as a reference count to
> manage the shared bias pad for all UTMI PHYs. However, during system
> suspension with connected USB devices, multiple power-down requests for
> the UTMI pad result in a mismatch in the reference count, which in turn
> produces warnings such as:
> 
> [  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763103] Call trace:
> [  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
> [  237.763110]  phy_power_off+0x48/0x100
> [  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
> [  237.763119]  tegra_xusb_suspend+0x48/0x140
> [  237.763122]  platform_pm_suspend+0x2c/0xb0
> [  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
> [  237.763127]  __device_suspend+0x118/0x330
> [  237.763129]  dpm_suspend+0x10c/0x1f0
> [  237.763130]  dpm_suspend_start+0x88/0xb0
> [  237.763132]  suspend_devices_and_enter+0x120/0x500
> [  237.763135]  pm_suspend+0x1ec/0x270
> 
> The root cause was traced back to the dynamic power-down changes
> introduced in commit a30951d31b25 ("xhci: tegra: USB2 pad power controls"),
> where the UTMI pad was being powered down without verifying its current
> state. This unbalanced behavior led to discrepancies in the reference
> count.
> 
> To rectify this issue, this patch replaces the single reference counter
> with a bitmask, renamed to utmi_pad_enabled. Each bit in the mask
> corresponds to one of the four USB2 PHYs, allowing us to track each pad's
> enablement status individually.
> 
> With this change:
>    - The bias pad is powered on only when the mask is clear.
>    - Each UTMI pad is powered on or down based on its corresponding bit
>      in the mask, preventing redundant operations.
>    - The overall power state of the shared bias pad is maintained
>      correctly during suspend/resume cycles.
> 
> Cc: stable@vger.kernel.org
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>   drivers/phy/tegra/xusb-tegra186.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index fae6242aa730..77bb27a34738 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -237,6 +237,8 @@
>   #define   DATA0_VAL_PD				BIT(1)
>   #define   USE_XUSB_AO				BIT(4)
>   
> +#define TEGRA_UTMI_PAD_MAX 4
> +
>   #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
>   	{								\
>   		.name = _name,						\
> @@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
>   
>   	/* UTMI bias and tracking */
>   	struct clk *usb2_trk_clk;
> -	unsigned int bias_pad_enable;
> +	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
>   
>   	/* padctl context */
>   	struct tegra186_xusb_padctl_context context;
> @@ -605,7 +607,7 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
>   
>   	mutex_lock(&padctl->lock);
>   
> -	if (priv->bias_pad_enable++ > 0) {
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
>   		mutex_unlock(&padctl->lock);
>   		return;
>   	}
> @@ -669,12 +671,7 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>   
>   	mutex_lock(&padctl->lock);
>   
> -	if (WARN_ON(priv->bias_pad_enable == 0)) {
> -		mutex_unlock(&padctl->lock);
> -		return;
> -	}
> -
> -	if (--priv->bias_pad_enable > 0) {
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
>   		mutex_unlock(&padctl->lock);
>   		return;
>   	}
> @@ -697,6 +694,7 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	struct tegra_xusb_usb2_port *port;
>   	struct device *dev = padctl->dev;
>   	unsigned int index = lane->index;
> @@ -705,6 +703,9 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	if (!phy)
>   		return;
>   
> +	if (test_bit(index, priv->utmi_pad_enabled))
> +		return;
> +
>   	port = tegra_xusb_find_usb2_port(padctl, index);
>   	if (!port) {
>   		dev_err(dev, "no port found for USB2 lane %u\n", index);
> @@ -724,18 +725,24 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>   	value &= ~USB2_OTG_PD_DR;
>   	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> +
> +	set_bit(index, priv->utmi_pad_enabled);
>   }
>   
>   static void tegra186_utmi_pad_power_down(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	unsigned int index = lane->index;
>   	u32 value;
>   
>   	if (!phy)
>   		return;
>   
> +	if (!test_bit(index, priv->utmi_pad_enabled))
> +		return;
> +
>   	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
>   
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> @@ -748,6 +755,8 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
>   
>   	udelay(2);
>   
> +	clear_bit(index, priv->utmi_pad_enabled);
> +
>   	tegra186_utmi_bias_pad_power_off(padctl);
>   }
>   


Looks good to me!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for fixing!

Jon

-- 
nvpublic


