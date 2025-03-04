Return-Path: <stable+bounces-120211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADDA4D5F4
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C25E17162F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742E1FAC3E;
	Tue,  4 Mar 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kw1uRvpT"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB251F7580;
	Tue,  4 Mar 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076071; cv=fail; b=UPOEl31L5Btkd3MfMEnbCEva1bgNRohgoeHiO+k0tbBGrq/nyoNbqSQ/LJ8kcwAIz4pR0RG+T1AzirmOhoGrNnlcietvgjw9nHk1kQe56FqF6n/N/hBzETOanAa6+42TLHGe1FWIlGJRVCh3wldhQSP2NTxuty507cqsvPilhcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076071; c=relaxed/simple;
	bh=exZZJmVR0xImHnlf5xWWUQylk/dSZi+0B/GuUZLdhQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+PR2gxTACEsoYWTocsUB1BV5qjrfo4+u8Ss47HJbxyJbWO/FpHKVyO5yRORLLPwSNLAzN8ch3MJUGhxLfF1dFokTuv1EdIZuY61Kl6zl5rQ8krdCaIBBYLQMuSLXEEfuoVFYbvePRASbsY8yZYsgvYDgMz3sy12naKjIhJKyp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kw1uRvpT; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O71Z8PLmUmr3tC5aAts1X7PF+LbC6FCC0+Q1fUAsuu1xk4l189CurQm2Q0vi0KVZyGx8VJjM0aPYmUafPzEPN/cn+xJHxg2qJ1vAwh0mTDiDcal8SS+TL0Qv5iAKRCEOR8Ch+AoUiaRhKyFeUQM32U0pJor/cbRIcqZ29hiWEqiLXlQN8SKnETLACcYlaSZ0F2JC4CURL5qFJ1RS/YCq8IgluItpd38NJtRNpyl/hTYy8jpJEVGNwzrioLWmTs/tipuuDr4zNorKgmJ0wkPSJhzAqXOkAhBB4uqUFI0XbUjLJjuRNHn9/g94FPG7nl+fLunwPvvvhe3DY22vUhUlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYogC463JXn/Fnc/RGqpDbPhZQzFi5+UnQDoNGmT7vY=;
 b=lTNAiiPCTk5sLCF8NKxgfu+4jOHOj0UaXT8J3r8QnxnP3NQTe5f97fD32hLZUwQESmnPIwcMHMLwrtyML2rrqal5xEXSGG+/o0+Wrs0igpMICXYOa1knRbj9CXp3eIM+/HAJi6Y8Eg/jrgs8hzTIGSnNy40M8XHdMocg+yQiWCEd92dJZOvHMxW81Vi5udwB1/iJWi/eSLBpmc5YDE+A7A71Id9eo/umVQUrDzJZJ/FWLw1tP037AzwsLI11twnKiEu+Wltec5k9LuepSqyxKxB68vBL/Q3tykViOHttBQU98FXjQf+6HJ+SdQLcbSx1Hw9Ws6sQKlXagocbbGqYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYogC463JXn/Fnc/RGqpDbPhZQzFi5+UnQDoNGmT7vY=;
 b=Kw1uRvpTS0580444HdEJ2j1w/Qqv37+cpD9cw9DuLLTkQKcaurusrO+S7K3DyJVHsSloQQxA7HaGEnL/pUirzUwSr/kF392NGQq0Z2gku+h9MiDtE66ipkKpT3uXWhL2AdxJg1ZmzggQ1eWuy7xVJF7YBOaCuILnFtS4tCdHduYFN7HSBfvRDdGNn4wV1tdjVuAhCe3MrGOPsWsk/Rk/weA1kodLi3ISNIUfMRPjqmSRQETuRj6I45O+4MG6I3lpV/3dl5RU8kQe4l/OovLOOWrlWoLsVasQMY0GhbVN9q/ZPu2oh1pq1RV6IwjeVgqU+ZUMQJrJVoGAueKBBCMdQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 08:14:25 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 08:14:25 +0000
Message-ID: <ae27ffe7-2a0d-4543-9e71-a3a4a1ffdc29@oss.nxp.com>
Date: Tue, 4 Mar 2025 10:14:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY
 configuration errata
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, stable@vger.kernel.org
References: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
 <20250304001629.4094176-2-andrei.botila@oss.nxp.com>
Content-Language: en-US
From: Andrei Botila <andrei.botila@oss.nxp.com>
In-Reply-To: <20250304001629.4094176-2-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7f004c-07c9-4874-dc9d-08dd5af4936a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0RSM2NuZ0ZOUi9HWE5ENnc0d0dqamw3b053V1pWOXcvMmVQSUpQQUJybERw?=
 =?utf-8?B?UGMyMG5VTk90VFFEMWVRdngwaDc3MFl1cVVPYUsrWUx1OXNhb1BuZ1NEcVhs?=
 =?utf-8?B?Q1RxTUVuUEF1b3VZRUYyQm1Bd1I0enFVb0JEZFg1QXdPRlB1R2p4L1NUOG5U?=
 =?utf-8?B?N0NOQ2JISENad3hzUW1tRWhLc0cxR2hPcmtQS3dHdWhvc3QwcmgzZVdzVWx6?=
 =?utf-8?B?aDNiQkV0a2E1OGpTbUdrUXFWeHY5ZWE2T2R1V2ZaRTQ4WEMyTk51QkhueDFB?=
 =?utf-8?B?RFpVaEZ1enpvT1F3TTNDV3dJSjBSTFEreXQzeng3T3FYbXhQVTlNT1orcHlP?=
 =?utf-8?B?bnI1Y3RjdWsxck8xT3B0MHNOdytaOVQycndhSjUzS00rZTltQTFZRW84RWY5?=
 =?utf-8?B?Q1p4dDRUKzcxbXlmUUlSMVlxSkY5bEJsTTJXOGJIazhVMStVbHduM0J3SWds?=
 =?utf-8?B?TVh1bnhML0NiZFVzWTRPY1JwN0VwL1JlUFUwL012dURlN0U2dGZOb1VWU3l6?=
 =?utf-8?B?aytnVzdaTzFaTnM2TVBrRXV2STQybmtvRnNqNlpsdCs4YmNFZHVMdTVGMmFD?=
 =?utf-8?B?cS9FLzFNQzBzQmxUM1BCQm9IcEppUkRzM2pET1BpNVB6ZDJCMEpMRXpmNXJo?=
 =?utf-8?B?QU54QnBhV3BrTm96enNaRWlIM25hVFo0c1A3bHVHOGpHbGpMKzdzSyttZWE4?=
 =?utf-8?B?bU9HVDBkQ0hMdXhmV3prSkY4L1BaSllBZjhWQXJSK2pRYStZdVRJdjRiVGFr?=
 =?utf-8?B?Ylk3TEppU2FzT3BhSzhTTWszUktoeUM4V3NuRjgwZ3dFRmlqZEpZcHVoUk5z?=
 =?utf-8?B?N0JBRHRBcE1IZDl4QXlpUjMzODdmM0VrMy8yR1NOUnZ5ek9JT2haUkR5Qnly?=
 =?utf-8?B?ZmVSKzNyZzByZkpNQnFScENYZ1dlOHAwQThyNEF4UWtiaWUraGlVeDl3Sk9p?=
 =?utf-8?B?WXBibVQrcTFHWS9EY2VDaTZzZEdSN2pVRU1QT3UvWDg1Z1ZVN3QyOVJwemp0?=
 =?utf-8?B?SXZRNlExcWlQODhidW9rQUV0VXhaYmdpdk0rdUx6TkdGdDB0TEhmQXlNS29O?=
 =?utf-8?B?T1NOQmQxbFdta20wWDQ5dFEwYUZZZkxIL2VlMmlQUHNjelo5cHRvZWdXbi8v?=
 =?utf-8?B?bFk3ek1rNWRtdFhPTGExU2ZjRmtBMzNnSFJsTm1Kb0xrRzhtb2NCQlJVdVNy?=
 =?utf-8?B?QUgyYzZCVmRYaWpBekZQcVJKM3Rid0JmTW1yWmJ4VEtxaXBwaHYzRVJtSHM4?=
 =?utf-8?B?TUJDZGY3ZmtVNjI4ZHdLeFNUVzZQL2FzZVlTcnFxNTZ1Lzgxc2lCN2txZW9U?=
 =?utf-8?B?N1BxK3JWWVZPLy9GYUErYWdrVkRPWHFYS2hDN05Eb2p5bS9ka3RaNFhTUTBi?=
 =?utf-8?B?bDRWdXM5Q25kNWRBTGhuNzRBNEJ2bGppTjZtL3crSFdtQmRRSjQ2dllHcWtx?=
 =?utf-8?B?RjV6clJvbUFiTTBiRUU2RlJuRW5WK1ZMY2pRcHphQlJIS2NtQzN4N2diSFdO?=
 =?utf-8?B?SnduZlZueW9GRGo0TkFNdWxZRGxIb1MzSi9LcWFkWkR0bE9VQ3FKVyt2OTk3?=
 =?utf-8?B?VFVNWXRPbmozeTJycFRiMmw0ekw1S2I4WjhHb0RHTmszT0JicElnTEl5N0Zi?=
 =?utf-8?B?cGlpSTBaL1l3cURZYU8vbXZnN01POFZDbHl6M0V5NTkvcVl0aUY2SlpvVm9a?=
 =?utf-8?B?bmZCandNM2VuWkgyOEZGeXZBT1BpcmJJR3I0dTVCNmVkWHpBL3RIQ2FMcStB?=
 =?utf-8?B?eXFPOFBENFlXUXN5bUVVZEZPMW5jQWM1QUhXeVQ3SERBU1hXVWFoNG1OMFQz?=
 =?utf-8?B?LzRaamsrTkprQVhSa0c2WFgxZGRSM1cyY0k1cVVIN2JGYlFJamxRM3dWOW1C?=
 =?utf-8?Q?FFuEwOtYTG9PA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hwQ3ByRkFIZTNISzIxYVpzejdjVXR1Zkxwc3I1M0hOWnNVa212UkJYVTJJ?=
 =?utf-8?B?QUN2SHhYQ0RlS3RxTnB4QjA5emsrYTNRNDN6T1JHcUw2VEx3MktnNzJPTk1H?=
 =?utf-8?B?UGVrbGpONlE4UXhBYjAxK3YvaHFMMjRxcUw0ODl3am83TlMrR1crN0NnbGVv?=
 =?utf-8?B?N2YvdVJBWFFFMlMvYTN5bWxFMUNwSnlqa3liRmxvNy96ZFE0aC8zRjQxNGlz?=
 =?utf-8?B?bUw3Z3N1K1hSTVY0T0ZLUmxqVllrM2VTY1FMM1pWZWo4Y0NIZzNuTWdCTGxH?=
 =?utf-8?B?cXNjWU9Pc1JUV3lFRDJ5SDBDZjdDSkFYUnNmRTJOaDJrd3hmMkpHdkQxWlFI?=
 =?utf-8?B?ZzQwU21PR2RwZlkvenlJRkVZTUx5U2xRb28wWDlpTEcySUU4YjVCdnpyVVlw?=
 =?utf-8?B?bzM1YU5OWFNTNXNoa3VBenVqcFJua0tnbm1Zd1VxMHliU3RqMmsvQUNCQi9O?=
 =?utf-8?B?K2lxTVpzUUU4b0h5M2ZGcUdOVkJ2ZmwxOVZFQ3VOVHlQTmpHQXpFYmdMdzNZ?=
 =?utf-8?B?WktRc3JXUUV1NUk4OGN4U1V3ZkNVZTExNThVWlVzbmJUc240OTZIeTVDUC9m?=
 =?utf-8?B?U2FiQ3NxRlZWYzluUlNOYTI2RHpiNThjenFPZ09DQlhBb2dFVFF4SWxsZ1o1?=
 =?utf-8?B?cG1aQ2REWDAvRFhqck43SG5jakJLS2x3ZFUzYWlneUlieXdrV2ZCV2RwY3Va?=
 =?utf-8?B?dS9KTkhiSjI4bStnSThhdEJ5dk95TFZna0xBR1ErWWZMMW9uZTVmc2g3ODIx?=
 =?utf-8?B?NW5QVkRHK3hxWmlVMHVEY202S0twMHpZckZrcVhPSzk3NVNTN0U2ZGVkWXBp?=
 =?utf-8?B?a3hwaEtaRXRlYnJMOGg5ZVRQNHhkbG5FbDlRTzVUZ3dPNXI5S2RLcWl5UVh3?=
 =?utf-8?B?T0NIWW1XZVlLVlRYM1hLbDA1dGlNbnFER2E4MUF1eW8rS1hNTkc2NFphT24v?=
 =?utf-8?B?RTJzOTczVnZPZTM5VXdIMFBZejJhaHNqVDhld2VmR2s1UktETnI3OUNMZTRl?=
 =?utf-8?B?a1o5bEs1VlBORzdvaHE0YTBwYVRoaGpvM3BFVEZKbEZ0Y0xzaEdBQ051Sk5B?=
 =?utf-8?B?STRRM2ZVNDhzdXQ0QlEvZUdvcWhrdWtUOHpjcVpkV2c2YTY4MXlsMGpTODN6?=
 =?utf-8?B?SE10dnFWa2pWajF4WFAzajF6eHc4cFkrbTlRSFhsNGxkZWhuRkYvcnlVSVpi?=
 =?utf-8?B?QXk5MWU2Y1lMKzNQR28xTC9Dc0NJbWx6RnRWOUFGM3lZQzNLdE1DUW1JMGRn?=
 =?utf-8?B?R1RKZUpmaTgyRlZ2VWVQS3VLSmNZb1crK280Wm1Nc2hFUHNyVURTSzJScGRk?=
 =?utf-8?B?MDY2SksvYlBuci9wcXlNOStXTFFrOWwzUVBsOUFCdTFVaDFROWtyR2twQlY4?=
 =?utf-8?B?N0NwZEFXYzFWekt1bVd4VHBaQ1dNdmxGQXJwY2VzVzB5SUxtU25ickZmL0lq?=
 =?utf-8?B?L1JNYmRKanpqMmZicG5Wa1g1NVZONkJpT1VqRHE2TTR5bWIycDZqZUt5YWda?=
 =?utf-8?B?V3h2YngyUll4a3JnODFMYjdYYWtoRFlEa21qOWdhUWYzY2Q1SVpnd09sVW5k?=
 =?utf-8?B?QjFnR0YxN0pQWGZtRnkrK3JKUzg1VnBZY1Yvamg5eVU4MXNtUmdoV1JHNGlT?=
 =?utf-8?B?OHBIM1V4RGNGbENIeHRXNjI1V2tTSnk1SkdDMkpaK0xRL0ZvcG1xL0NPWHpS?=
 =?utf-8?B?MzlrdEVYaGVBaVRJOXNwS2RBcHdyNkZIczR2WG1VU1dmOVlLdWVxU1pBNmQz?=
 =?utf-8?B?MmdVeVlHRFRIUFhOS3Y0K2JUTTg2ekY5Wnd0S2JTY29hTllERTgzNWVRVDZQ?=
 =?utf-8?B?K3JFd0x0NmdEUEtsTDMzMFU5M05SckJiOEQ0NXYrMmpFTHk1b3BjNGdOWkR5?=
 =?utf-8?B?NWwvZks4NWxuSzJkMlFGQUVTVjNkQU4xTmIxTHhlZW85V2ZBMXpIdmplSTVD?=
 =?utf-8?B?aTM3SXp2TFBva2t3RWxvRmE4V2RRYVNrTzVyZVhkV0VaMnBxanpHWjFUVDBD?=
 =?utf-8?B?T1lwTHVXT3kxUTZsYlViQ2xzeXlOZ2p5cnpGZXJqYkkvSkhXd3M0ejdNYzZG?=
 =?utf-8?B?SER4bWdwUkNZNWpFdExXeVNNb1BFc3U5eTVLLzUwbDBUR3gyRTJTT2hmdER1?=
 =?utf-8?B?KzNJeGo4eGgyZTdvaHlERmNPVkRMNVd6c2tMUlZUb3ZFNHJweC9BWnVoWnhW?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7f004c-07c9-4874-dc9d-08dd5af4936a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:14:25.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cck5UXH2BEqLvAjrCj7O9VAugS/h3trDzVwB0sr8VNXA2twh0O5ooeoaIPbWf0y8JICcfJi2LcG2AXzHc4hC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

On 3/4/2025 2:16 AM, Andrei Botila wrote:
> The most recent sillicon versions of TJA1120 and TJA1121 can achieve
> full silicon performance by putting the PHY in managed mode.
> 
> It is necessary to apply these PHY writes before link gets established.
> Application of this fix is required after restart of device and wakeup
> from sleep.
> 
> Cc: stable@vger.kernel.org
> Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
> Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 34231b5b9175..e083b1a714fd 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -22,6 +22,11 @@
>  #define PHY_ID_TJA_1103			0x001BB010
>  #define PHY_ID_TJA_1120			0x001BB031
>  
> +#define VEND1_DEVICE_ID3		0x0004
> +#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
> +#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
> +#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
> +
>  #define VEND1_DEVICE_CONTROL		0x0040
>  #define DEVICE_CONTROL_RESET		BIT(15)
>  #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
> @@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
> +static void nxp_c45_tja1120_errata(struct phy_device *phydev)
> +{
> +	int silicon_version, sample_type;
> +	bool macsec_ability;
> +	int phy_abilities;
> +	int ret = 0;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
> +	if (ret < 0)
> +		return;
> +
> +	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
> +	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
> +		return;
> +
> +	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
> +
> +	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +				     VEND1_PORT_ABILITIES);
> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
> +	if ((!macsec_ability && silicon_version == 2) ||
> +	    (macsec_ability && silicon_version == 1)) {
> +		/* TJA1120/TJA1121 PHY configuration errata workaround.
> +		 * Apply PHY writes sequence before link up.
> +		 */
> +		if (!macsec_ability) {
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
> +		} else {
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
> +		}
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
> +
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
> +	}
> +}
> +
>  static int nxp_c45_config_init(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
>  	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
>  	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
>  
> +	if (phydev->drv->phy_id == PHY_ID_TJA_1120)

Will send a v2 because the PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120) needed for setting 
phy_id used in this check is removed in the changes from
https://lore.kernel.org/netdev/20250228154320.2979000-3-andrei.botila@oss.nxp.com/ .
I will use a phy_id_compare() for this check.

> +		nxp_c45_tja1120_errata(phydev);
> +
>  	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
>  			 PHY_CONFIG_AUTO);
>  


