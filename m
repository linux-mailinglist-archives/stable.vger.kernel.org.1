Return-Path: <stable+bounces-121224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F407DA54A40
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC116A5D6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BFD20AF9C;
	Thu,  6 Mar 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SDwDatux"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB920B215;
	Thu,  6 Mar 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262638; cv=fail; b=SLvZEJuzjF10vUNO1HlS2Ho+4WPOJv830OOoHN+E/j7WbWwKg8q8PwhiykHPWlXTFgA9F3vMBkVAyJzRNXTUwPevc9Q9qL6gABkswEi+FuT2KWCtEQEbz06X/A9wiIFzIR2AImFNg73wYSop3e0Wbc7bnY1m1Im7IAglKVaRLrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262638; c=relaxed/simple;
	bh=pxyCbhoKUJLElR3zkWROhVl9dF3g1Fn1EziFe6wsKUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8UC/+WQYtyrWFS6I3yFO6G4U8KuMXNFZkBW2YU0JmpE/DQR4mihuHla6Zd/ws86oXzaCj7v/AaXZHGFKX/gJD9vPH10ZEd/jjHjxchM6wfj/DwG14jyphAV1zGLlJ9kI8uyWbKWgCUcvYkXFo2ilNqdQ9paF7Ju3ZqFUNabfG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SDwDatux; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIFPWvfjrCtGiqorSNjMZgj0IPgEcwTAkkVb+nUpHEBl8xQ/Lip1+ddEYRw6HbUTX6v02Z0ylah9HN18L9OFjU5dM9CcRsZ+dk2Am3za6FVSvJEc0ewfpJJgS9vp+s62oJ8CFtArM09aByOe/aJUXbhiFX08t6eVojzJ2K6esmvzwXrzc7S202c3CB5PR0bxn6+r+79TXiPsMeLilMPNuNKiKOMy/lQRspxmWF+l9D8W8DU677DfKKidnStwgskt5dY53e2hP/Sfsm2GYPe/NX6DeeTUuGXdUKqzmD0DkY7LJ6CRwBVnKs5zZjqLrhuSN9Go8TuemfSnKyLKl4ON0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SGqeOzkUwLlievBI2VyRMiYnCXyeXUr4Ny0oACDe5c=;
 b=XLuWNXttU2gKU/AFdmnhBdnftiRNh7cZyr3jUD50dJ8A/PmWM7N8wnLkyUgCzYxim+TargwKh1WBKjITU75ycRa6cDlVVC7/GfZ6h2bJMWVIHIDFIMxDmlsjM3+eBs+Hehi3Y2EAukbiS0QJXL7r4/ivAgrS47WLt+Td49vnGsM9OfTsoTRVe8UL5SpAcKDovLAEvBS/iAJb7YTvVbYBbnD7OVI7R5WyxwFOU1FV2jfIvfs6dFBVgPatO8gf5iPQ2gU9X3p6dYdT1apWYxFm0SyxDKZeccRtmPTiZRsZWZamyncGODMEZlF2p0rK17Z+0+YjsONnFv5WadRkzWi2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SGqeOzkUwLlievBI2VyRMiYnCXyeXUr4Ny0oACDe5c=;
 b=SDwDatuxG4+hlV7QL8ht+Omzy0ksSdOEQhV6EtoTuHReTGZaeW0UyWvgfphwOEFmIAJL+MIhrc3+vht57GdoBHtYS5GoDkxhNfF8NFpebi1vWOYAixMxAXbRf/zmJt+f344F4gRd/bOuON7aV8sidbLdIT4AIB/QV5kgBbKyaBMiUPsU16ZwD6qvQWUvwq9buWKK3nxPi7cB8vDnmlgc+Gors/WZsg9x8TYFtp3Ih/CV+FQ3Sh9wikLS9D5L03KD94v+Y98AFtEwDbexxwzyw2NLzsTk0JXpb/QYBUA0f+slIY75aHZ7Q+MZqO1Xm5z/I88/q6HvVA+asqviJAh2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by DU6PR04MB11136.eurprd04.prod.outlook.com (2603:10a6:10:5c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 12:03:50 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 12:03:50 +0000
Message-ID: <f37c7159-528d-4c58-b531-8d66757d2c16@oss.nxp.com>
Date: Thu, 6 Mar 2025 14:03:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY
 configuration errata
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, stable@vger.kernel.org
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
 <20250304160619.181046-2-andrei.botila@oss.nxp.com>
 <7c14179c-0262-47e5-a13e-a53c2061da9b@redhat.com>
Content-Language: en-US
From: Andrei Botila <andrei.botila@oss.nxp.com>
In-Reply-To: <7c14179c-0262-47e5-a13e-a53c2061da9b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::29) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|DU6PR04MB11136:EE_
X-MS-Office365-Filtering-Correlation-Id: abd513ff-525a-4e7f-af61-08dd5ca6f4b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmprclRoZVpBVkVkWlRVTTF0bmNQVVlEbldwTDI1aTVJNnFYZXhEN0hUaElC?=
 =?utf-8?B?NGs5UnN4UDUzZlBpa1ZjNW9MVG94dCtrUHBnR0JZOS8rWHhGSkJVSEJzeWc2?=
 =?utf-8?B?bHAwelRLTHdVTERKQ3RDRmR6cGxpYVFzM2NicU53NVdKQ0QwVzIyUnN4UVhn?=
 =?utf-8?B?dmUzNHk2VmlSaGJ6YkpKUGNBellDUHU5dk92Nk9pNmZka0s3OWRzZHlPdU5z?=
 =?utf-8?B?YzRYVVhrdzQxUXNROTFNWGs3aGMxM2IwVnJOV3p2akJnYmhPTjVkWFlFb1A1?=
 =?utf-8?B?ZWVicWRLYzI5MjFYN0ovdUdScHBGKzVhcnVnMlVndDNVck9kcjllYmw5dUFw?=
 =?utf-8?B?aFZBOXZ3TVhGM1QrS2NlaEs4SFZvRW1OY1hNUmluaUFteTRpczhNUmJBUlFh?=
 =?utf-8?B?cnBPWVZSbnEwVTB4MTRGdG13YnU4WUJMbUZXVlFQUVJ5cDBKMkhUd3ZJZEZD?=
 =?utf-8?B?ZFAzeGNjbUYrWWt6NXdIYzRxb25ZSlJKMWNaS0wxaVhIcVVLcXdGbTZBR2RK?=
 =?utf-8?B?UkF6cSsxWkplVDlaczg2TG11L1pML0RsR3plbkNOYU5iSm9mTjFnUkJXdXB3?=
 =?utf-8?B?Zk9INGlMcW1GOFFsN1lrbEMyTDc0SEg5K2ZTTFB2WWVPZjloanRqYW8zYlVq?=
 =?utf-8?B?aHBXM29KeE9tcUxlRlBiZmd6L2RCYkVDYmNGUGJ0eDBHL1BRanJ1b1p0MmxX?=
 =?utf-8?B?dXBaTk84TWJLNFp1YXBkYzFvalZEaUVSQ0YveTJLSS9VM25xZGtHeHlrUTZo?=
 =?utf-8?B?NmFhU1ZUaUZpRW9sdnFkQ2tNV2ovRmgzN2ViZjBzcjB6cFNwU2VDSGlDbnAz?=
 =?utf-8?B?R1VVWjBFNW9TU1NXYlVzUFZHTHBLUk9BcEZ0ekg3WmwzTHUrUlA5THZrbEw4?=
 =?utf-8?B?eVRxUGc5YTY5aktZZ1crRGhGVHl3UVZTMXVvNjZJa3dseXo5aE9MS1g2Nzhq?=
 =?utf-8?B?ZHBHNWZMMXRsNTl4Rml5UUVZaGFiQ2JhT1Z0VjNRWEswbFFaMVhnYTZCZ2dX?=
 =?utf-8?B?eFFrQjd5YUF6TElRK1N5cW9OVjNuaHkxbE5UTGlGSXZMemcwcTk5dmVrcVBs?=
 =?utf-8?B?QXdrbEp5N2FMRUxsWjJoVnJ1OVdPY1dsQ004OGpqMkh6b2ZiWjJ4SFFpb0t2?=
 =?utf-8?B?QVlUNnF1OVdSWEJSOU95VldlbExUdkNETkxaZWJ6UEdzSTlrdjhMbTArVk9R?=
 =?utf-8?B?TCtEL3RndG9iSFpKeTV3TWZYZytXM1N2dlkzTml4dHNXZWtyek1KY0k0ZkhK?=
 =?utf-8?B?ZDhsYkxEMTJ2a3ZMMys0Ni9pUWZiMEdZTWRLVm1kSURrK1dJcWRTYW12ODI3?=
 =?utf-8?B?TEdweUswQVVXbUcxeVgvLzhFMS9hb3gxK3dsWFRMaDA1dXh6ZjdTd2Q4ZzEx?=
 =?utf-8?B?Nk5hbGVlTXVnMDNUVEw5ZGtTSDAyMFdJOWRJZ0lrbk4ycTc5RDNwWFU1d3JQ?=
 =?utf-8?B?S0ZKWndIZ1lKRWdLdUhrYjRDN3Z4bU1hZ1hHT3U5ZGZJT1ZZOGp0SFM5QVhG?=
 =?utf-8?B?cXgyTW5GcXNwcmNsSVErU3lrV1k5NTlkYWt6U3V4aEY2WGNGdloybklGTFdp?=
 =?utf-8?B?UGhmY0NyVkMyWldtVEE2d3JONHl1UXFnWHFNTXNNeXNYalcvK0srWGZGRmFN?=
 =?utf-8?B?NERPQjQ1QkQ1M2VUemZvVEVQLy96NkZjZ3RCZVJma1pkVXU5SGdCRHNGVlIv?=
 =?utf-8?B?QU5kU1ZWUWZ2OUdtRHFXM1cyUzNYR0VyYW82Q2hhWWwvZWtFWnNyVFlFeVZz?=
 =?utf-8?B?N0l0UHBQZWJpbWFnY2tEcWhOdlVYM3NBRE5ITHhMOUdRazF5UnJyZWRuSUlW?=
 =?utf-8?B?SXB6VnhRT1FiUEROdlU3MXBNRUxib0F5S3lVOTNSVys2L0RCNys4b29RcS9R?=
 =?utf-8?Q?uUAJhzvl1JLli?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Slc3MFFISjZyL3JTU3dQaXhCWjdWSW56TjZYc1RvZ0xJN29LNVpLdFptdU5K?=
 =?utf-8?B?Ti9vWDNDWHZoc0VUMHRyUDZZSVBzVE1TamNsTE5uYW5sb1RGQU81T0JyMXc0?=
 =?utf-8?B?dlA0dEhaaUl3NzVtbW5zUGY4Ym9rT0pqMi9ETGNneFg4T0lWVDQrRXk5R1FB?=
 =?utf-8?B?cjZxK2hSVnZBc2VjYjUySTdUcFNXMDVEK0dmQk4vdHQ5and5N1dmcTRGZUNl?=
 =?utf-8?B?ZVAzNXo1djBFR3BWQzNvVktBRDQyQnBMMFBaaGJHTFdTQlByeFpkTllNM1JO?=
 =?utf-8?B?K3hyN1ROY1pFeDZVUDFRdnhrOXMzV1VSbkJ3V2s4S0x5MnVqdkR4a2xuQTUx?=
 =?utf-8?B?TE5ZelRLY3Y1TnM3Y2cxNlhJQS9lTkx1eXZaNElvSTB0ZjhlKzRTdVdzSGRx?=
 =?utf-8?B?UlNkYVVCSWZBNEk3ekVEY3dTSk12eHR1UWE5bjg3K1JycTEra2t4bXNlWTRh?=
 =?utf-8?B?L0lVclZEdFQzQmpVWEo1YjRRQVZSaHpsMFRXc1FOVU4vZVVWTnNpbDdyWjRL?=
 =?utf-8?B?ak5kcnFNQ2dnUVp4cU5NbExtUFIzSWREOGNpR2JLWHdVbGFJMmRVdStjU0sw?=
 =?utf-8?B?d3lMRXNLQkdRWXJkTmxkcFRvRzMyVWloemxtdVlRZ1hZVmNCVVRoU25oYzBH?=
 =?utf-8?B?YW5qb0lnajJjd1lrelhhblRLU0VnOWV6ZU9yV2hiRGlhcFRkL0ZYcWJVaXNU?=
 =?utf-8?B?RW9wQVpOWWlrSzFWc2pMRFM2UTg5bHBsbUlhMGxNR1JCTVpORFJLNEpkWW83?=
 =?utf-8?B?d1IyN3R5SjBBWTVHRHVmcjRwd2pQYUlNQ0JoaldMVUVsbHJRN1FqamZqOTZL?=
 =?utf-8?B?MjlYN2paYkNCZ3NXNXN1NTNsT2hwMXNhRzJRTlJNc1Y4bXhmUHdlSWQ1bjlG?=
 =?utf-8?B?ZElBb3haLzU5a2Q0QjNxbXIxNlkrQ1F0RkxNMUdaWXRnT1FRWHlsOWhnRlRN?=
 =?utf-8?B?OVh5cEI1bkdZVWg4Zm9aVmRoZndod1NKVjZrUlpiZElrbXVDMFJ0V25TQ2RK?=
 =?utf-8?B?YlRsZGhNY0xjdHZ5ZjdxVWxKaGVPWlBuSDVXR0cyRVZreXpDMmVBZ1dqd1BE?=
 =?utf-8?B?ZlB0QzVnd1RCTDZJdU1tcEdickJ4elJzTmdBclh4S2FoMThYQmZabFo3UjFH?=
 =?utf-8?B?bFR4MTgvcDI1Z0QzWWVWNjAzS05WRXZ5RHQ2UlhsSEJZWm42end6ek9LdzV3?=
 =?utf-8?B?azdGc2FkOHVxU2dGWm0rRlMzaGYwWktjYXNjTkpHYSt6NStrWGE2QUtFL1M1?=
 =?utf-8?B?aFdTWkpyYzFlbnNoM3NNSlVyeDMra3NUT2E2YmszNGpCMWFWZDFNRytYaEtS?=
 =?utf-8?B?b20xd2FTY2dvWGFkZ3VtczRhaHhQVmU5RC9CbFBwbHB4S1k1ZDNvY0xqRDBQ?=
 =?utf-8?B?cjFYRHVDYzV3Q3gwa0g1Tis1NWRYTTZiZGk2WkpqYStyVCtWb0N0cUN3M1l0?=
 =?utf-8?B?eXhLZUhnZWJVcGM5R29BeUJ5SThPeTFXYTk0ajlxWkZpZ1RIZDlTZ1JGNU85?=
 =?utf-8?B?V2JGVm8yamQxMjRxMkNQM1A0Mis2RVgwMUU4L2hwZzNlTDZHRFF5TDVZTVV5?=
 =?utf-8?B?TVNFYm15cHlRNzhid0d4R1pwYURGSEZDcjBNZy9WWnQ2NUFRblZqWHlla3dz?=
 =?utf-8?B?ZGVwNEpvN2o5ZENhY09YalVNUW1xKzJpWTluMTNWRFBzanFWWXBBOExWZGJ0?=
 =?utf-8?B?ZC96MUtxYzNyandnWm5oSmw1WWx3L1pnRjRmbVVwMElKbG5PU3dyTEkzSllG?=
 =?utf-8?B?ZE9xbW9TYVdGbWgxVUZ1NXd5SCtGRXR0Ny9lN2p5dit5NElLMi9kUmFRQkhk?=
 =?utf-8?B?d3ByVHF0QmtMcnBtVEZITU1kdWd1cE1tV3lCdndwTjdETTM5VGNrN1RTdmw0?=
 =?utf-8?B?MmRBVkxuZldaQkFuZHdHZmtVN0lJMWtMcjlNRlNsVDlmM2ZzZWNRT1dVdVcw?=
 =?utf-8?B?Zm5aaFNjZFAzcEIrUzNTdXhDTm1IbW1ISTl4U3dsV2RxbE5NT3FRRXJOTThN?=
 =?utf-8?B?UVhnNlNLRDlwZDFIMW11SWRUUHNKOTA2ZWZWS1c4RDJQSlJiVURlbHdaLzFO?=
 =?utf-8?B?Q2pUQkVIMU5WelFoTnB6eXBMditRR1FGRFYzQTBHa3BPZVlsWkpHNDI2SFlR?=
 =?utf-8?B?SmVjQnBNSzR0VlF5Wm5RbDNKUy9uWUdJMnNyV2JOYStENEc5K1g2eFEwSjdR?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd513ff-525a-4e7f-af61-08dd5ca6f4b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 12:03:50.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCcXmr/e3F4P55b98Isk6FN/FlAW69q1wYlglKIz7EwQrsOGKrmqIqWUSLTXkUQ43pFLhitd5FywDXajOQAJ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11136

On 3/6/2025 11:43 AM, Paolo Abeni wrote:
> On 3/4/25 5:06 PM, Andrei Botila wrote:
>> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
>> index 34231b5b9175..709d6c9f7cba 100644
>> --- a/drivers/net/phy/nxp-c45-tja11xx.c
>> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
>> @@ -22,6 +22,11 @@
>>  #define PHY_ID_TJA_1103			0x001BB010
>>  #define PHY_ID_TJA_1120			0x001BB031
>>  
>> +#define VEND1_DEVICE_ID3		0x0004
>> +#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
>> +#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
>> +#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
>> +
>>  #define VEND1_DEVICE_CONTROL		0x0040
>>  #define DEVICE_CONTROL_RESET		BIT(15)
>>  #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
>> @@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
>>  	return 0;
>>  }
>>  
>> +/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
>> +static void nxp_c45_tja1120_errata(struct phy_device *phydev)
>> +{
>> +	int silicon_version, sample_type;
>> +	bool macsec_ability;
>> +	int phy_abilities;
>> +	int ret = 0;
>> +
>> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
>> +	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
>> +		return;
>> +
>> +	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
>> +
>> +	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
>> +				     VEND1_PORT_ABILITIES);
>> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
>> +	if ((!macsec_ability && silicon_version == 2) ||
>> +	    (macsec_ability && silicon_version == 1)) {
>> +		/* TJA1120/TJA1121 PHY configuration errata workaround.
>> +		 * Apply PHY writes sequence before link up.
>> +		 */
>> +		if (!macsec_ability) {
>> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
>> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
>> +		} else {
>> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
>> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
>> +		}
>> +
>> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
>> +
>> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
>> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
>> +
>> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
>> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
> 
> Please add macro with meaningful names for all the magic numbers used
> above, thanks!
> 
> Paolo
> 

Hello, these registers are not documented in the datasheet or errata sheet.
The access sequence comes 1-to-1 from the errata so I couldn't use macros.

Regards, Andrei B.


