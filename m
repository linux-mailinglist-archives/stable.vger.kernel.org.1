Return-Path: <stable+bounces-194431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E582C4B727
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 05:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E83A4E66EB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 04:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDA1A3BD7;
	Tue, 11 Nov 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oK1bn8rt"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0189476;
	Tue, 11 Nov 2025 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834638; cv=fail; b=CuAffd3XrjQO0hZO9t/sUezBYl8pt7Rvf7Ev9h9s1JZruU5nEmu83GbxR9pk+0JfYxTLgItfS05AoitywGT+zYCRQT3P5CTnpK/V/noQ/hKwwU7cfcqW4+Ca13XVoTdoSY8Gj1LVpumHoeO81bIB8i2pBEu+chfAg11Qc/34Rd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834638; c=relaxed/simple;
	bh=wiYUKG7UsalowhuNz1Nr/9U6JyGeguzEixakDDLtVYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oCQRslON0KDHIynbW6AMxAp8SaBmTO17US0BI5EI46TaxLKrDkj0RTnGbhAcdhEWOh2aGv7Kq40kFup2IMGmpzchaoKiJt0vgtKwEqTF0mGeKaSVVyR6iyd3uXXBxtxe9QlLKMcnGFOIWJA9WxjS4Emm+GguAIdbEoVlsLejmA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oK1bn8rt; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD5mC3ub0J8pTt+ix+MfxjfAyLRDPDqbMteQCxThFHHcjq1+2F2nEJxEc+yjMOa2oUjaC9xBLgLkfrxP2wp9/2rQoO8u29aylC1wxloVMCprzqNLTPX7JK38LfrUu4xiYz68PN9V4e3vtEPChee81O808NbUktTls/MH1JMLvNBPD8nM8pwehnEvGh0SBz8uWY8+Mk/hJBWNpGTJX4Hhbb77yXsm3VvZOJ3fNIfDaFPr9ijGsXnAzHs6wYkPFg2gOMMg8Mb4MMjZr2Pv0KUUfz4Rrl488Da2jasIoGsd9FwwWzMRHk275LWkoIapslsCurx+4yz7/42nLdH6jornXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0w6SIBsDOLcLp1zttN/cIX1aPszBMk5WQtYOOZLVIE=;
 b=JzcF+4PiJRc/77BPKeZZs7IrC0CNzQagQPgUAYvaO6xUcgtezuLLAT8guwIXQPn/wB3gNvxxhOUqaZdJwJToKKAKROd50AZSjas/Woi+E+qwd2dsXSyBvqWQGK70F5sClhjeH4069FQ4BzXTS2XDrEbc8iFvkpw++YzslGWIBL3UshsD36dBebuhjqm9Tnko57GmsRLyxJ8yMUDMbzyEVeyJVEzC2QtMPQQL2VPvMoRTuJBh0kwrY1FOcM1+R5LxGdnme2qeSP8+BJANZpcMDzadQkEjaLZhBI0r6ei7laeirslzuUkkHmCqcaQmQ1lUtxNeEcq71Ek7ocAh/DkyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0w6SIBsDOLcLp1zttN/cIX1aPszBMk5WQtYOOZLVIE=;
 b=oK1bn8rtN4u8W/oNV5PCgsyoN0/WCVBsggB+MIMEiyOgJKhN4rthuQvuBDplX9qYHyJj1xoq6fVnInbX7rveIRLebxp/PX1wthD6c/Qfu8AXb9XEvQojzo2c8o2D64JEgFjKE9hS4Qb5/i/h3ELOQsSunxfIebuf09JusKEmcK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL1PR01MB7674.prod.exchangelabs.com (2603:10b6:208:395::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 04:17:07 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 04:17:06 +0000
Message-ID: <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
Date: Mon, 10 Nov 2025 20:17:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL1PR01MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e8d3c5-41ff-47dc-ae54-08de20d92c8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmxVSUZ1UjBGSGxiSTc5cDI4SnJYbzU0Y3AyMjFSbWRmbTgvSnhJZkR5OVZ6?=
 =?utf-8?B?Y0UzMFkrdm13d3JsWGJpOVhyMXFJN0NOWDdUQmpuSUhQNHV1Q3A3ZTE3TWtm?=
 =?utf-8?B?YjlTUjF3a0N0NFFrMXFWc0dVcmhOdXM5K2hmWmVmd1ZSTm9pVTZCTDhLeFR6?=
 =?utf-8?B?dVM1RzlScklrM3dJM0tUT1hIWmFIUUI0bDRsZ0xrYklzeng1a1hLY1BrTTFZ?=
 =?utf-8?B?OWcrUCs3L1VSTkkvTjErTlJnRm5qWUxZQlpxQXFVc3NtRDJSK2VpS3o5VUww?=
 =?utf-8?B?S3MyY2MyZFRrR0tZWndyeTZLNi8vQWZMejZXdXRSbE9ZOUFGc0JWZHlOVkpo?=
 =?utf-8?B?eXBENnBCZ251VW1pOXdEMEVrTjN6TEtTdnd5N1NXbUhiVG1DVE9ZSWU5emRH?=
 =?utf-8?B?Mmp2dE9FSlFPTS9XM1A2UnJBaThYYmx3SzNneU9ITWM4SFVDcmdTVVpzN1FM?=
 =?utf-8?B?VzZzZ3J6c3VvYk1OS2o4VEowSjBnZlNycnQ0V0NlMm9LWjd4ZEJvaXM4UkxN?=
 =?utf-8?B?anIxTUJSaGlqV0xONFFaZ3VCdXk3Ny9jRGhIdlFMWWRxU21yakRMYkZxVG5X?=
 =?utf-8?B?aU1UMHBlY2JscFk0OFUyaldJZFlqWDFrZ1poWDVsY3JGdlBTbGM3OFltRzd2?=
 =?utf-8?B?TjhoaTF4b1I1Vko2RmtkdWZEOExqVWVqM1d1NWJEb0VOTk53dERNQm82ZGdL?=
 =?utf-8?B?c3pURDc0cTVrZjdmOGhiSjl4WDlBbUdOWnQ0bjVqMkZNanBFMGFxRiswUm41?=
 =?utf-8?B?N083VWVxajJUZXU1OUdxSUdESytKNjA4VFFWS082N1p1S2J0TjJDQ2hzRnRo?=
 =?utf-8?B?WUh3NC85K0c3VGpwSllDbzh3QVBpZjAvbmRIMjBpVWtTQ1liWUNLWi9KTVBv?=
 =?utf-8?B?Y2ljSWE1cDdkV0syME1EdkZWbjE4NkEvWm53bVlnQjFRYS9ia21Fc25Fb0di?=
 =?utf-8?B?NGJIenh6akxYd29mNlhEK3RNMEZYNzZlVEp2VTVjbkhmNkVwYjAxU3lMRUJr?=
 =?utf-8?B?NnhVSEkvcldDd2pxQUFOR0t2WFpxcGNkWUMvRkM5Uk1VSGNBS1RXNTdoZE9w?=
 =?utf-8?B?TlF5MmExSnB4RUd3UWdWR2dNTVNkMjZlYjduVE0rdHR0dzVRWVZ0OVhBekZs?=
 =?utf-8?B?OWlSL0N1Qk1VYldyVXBNL1VjVUNmdzhteWVqK21wWi8wQ3hkbHFEQUFnS2c0?=
 =?utf-8?B?UWRMQ0M4SC9reWtTOXBialZucHpSWGs5Q0srblNSeW5nV05GK3orVXcrMTVr?=
 =?utf-8?B?NkprcmtKYXBoUzZhbDZPSGM3WnVqMVJxOEJ5THZrWjhEZlZPckNZRWV1VVhF?=
 =?utf-8?B?V0FOTzFQVWR4SEVCODRYemNvTUppb01HN0FjY3ozOE1DQnlpMkdYVFY0M0pa?=
 =?utf-8?B?Wkk4LzlLemFwc3M0MmUzaGNlU1hoNHRrVVo3TkpmQ3JuRy8zOEhpNFYwN0VF?=
 =?utf-8?B?UWFWS1I0a0xkQmJJaU1LTzg5QWhSdmhDWnoxcExUVGkvdUZaa3lJcTAzY0lp?=
 =?utf-8?B?WTlKWXhYTi9oOTlWM0Riai9HajRNc0R1TFhKZTNUSFh2UWRvekZpLy9yN1ZO?=
 =?utf-8?B?a0x6dFRBeEVIc2EwQnVCU3YvRG84M2dXcDhrcTJiZHBMeTZpNHZDb0Z6Q2dV?=
 =?utf-8?B?TWNva3BSZy9PSEhQZldrWnFnN0NWSFphbEU4V215bFQwZTg3SEkrd0NxZVVK?=
 =?utf-8?B?bXd2REVxcWRkNkpzd0FobWdJTlRkRlRpK09WZGVWVkhyekVheVFZRURXWEVQ?=
 =?utf-8?B?a1pIcW1qWTNlNCtSYjNwKzFqSGlnS0xOK0hiVVBsL2NVME5IWkpmQi9na25m?=
 =?utf-8?B?SEw5OC9YRGhXS0QxdHJWR0lIaURJN0djRkMwUjY1ZVpuYi90YVdSYmNzWlR3?=
 =?utf-8?B?L2tvSm8rY3lqYmhOaVBDbFJlTGFEWUdmUFRYUGRGUXdORHUzQWt5bklmWkpM?=
 =?utf-8?Q?pQSnalCec0793Nv94JTGwF2JdtomU6GY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFyaUs5SWIwZldOWXVGcys0Y1BjbWs3cStOa2RKeDVZMjUzNDJYU0xuWDJZ?=
 =?utf-8?B?ZnpVa1F4K1FBTUEvU0trdjJrbzFZRnAwUlYyeEQ2Y0tYN000NzZUWDV6VmVp?=
 =?utf-8?B?UjhVRi9zNVF6NG9YcVBQUXZLd0pFTkFycFFZK3hvclJRQ0dzVW4zeFRsZmw3?=
 =?utf-8?B?ZDB3Q1kvUG12alNBSlhheGlzbEJQU3R1bmwvbEIyMHI4WWF2aC9XTmJmcmFY?=
 =?utf-8?B?d1VscEE5dWRPUmFnMFc5V2F0WHlxWlU3Q1M0YkVVS3QzdjZ2eE1MWmxhNWE5?=
 =?utf-8?B?NGN2bHEweXkxWStGc29ZTi9sQmNIbHlPeFJackdhQ0lUSDA3UStITVY4K2xJ?=
 =?utf-8?B?cWswK3hjdnlzM3FHdDNFcHJmN1RSdlJDd2ZxdHhIcFBuZFZFUVRxcHZLNjVx?=
 =?utf-8?B?a2dMb0JGazh5bHBVNW5iZzJMejFUMjhsR0lHQWpmcGZRekhIVG1pcUhsUnl1?=
 =?utf-8?B?SndJRmRaYllNZ0QzZFZRNDFWVnozWUY5U0lrK2lpeldRblJVR0NZSkt5U2sv?=
 =?utf-8?B?Y3J2SnlVb1RwK3IxclF2UFpQNngwUldaSS9aQlhPS0lHMXhtM1JYd2p5cm5k?=
 =?utf-8?B?ZERjSjFUeXFhWFh5U3VKdlFTYmQrSDZGN3ZjN2F4c0w1eVNVZnpUNHpVT2kx?=
 =?utf-8?B?MGhVT0pPUXpZdTZpdUxWV2ZWak1iSXNJZ3hobDZqNWRLdGNDeEtNeXVqTFQ5?=
 =?utf-8?B?Zk9ZYXIxek0xLzUzUDNMVFo1UEpvVFFzV0E0dDYyNGU4bTVwVElDMWozbTcz?=
 =?utf-8?B?YkxCdE1iSC9yRVZKSldVVjBYTW93QnJsWDBONnJPWTV4UlhjSDlKSlhaVldy?=
 =?utf-8?B?YS96bVhzNFJwaHRNZmFCSWtEbDFSR1dSUkxpV3VhTC9ML3kvSS8yTTVtYmhq?=
 =?utf-8?B?Y3p3V21Ea05ONWFYdStTS20vampEalMvcGNTTnIwejNsMDY1QmhEbThxM2xw?=
 =?utf-8?B?NzRKeUVmcTVHd3N2djdQK3VKdmp3dXR0U0pQeVJxcmk1MzNBSjA3MHRuZnRD?=
 =?utf-8?B?cVZKc2YzaTJCVStuR3FOSzU1ZEdMRzkwYldFNmd0QXlObitlZ3dyU1RPY0hs?=
 =?utf-8?B?YXNWTC9NSHo2S2VGUEk5ODdQa2t5Nk82ZDhVZm81LzBDQ00xdWNiUjlOVjlE?=
 =?utf-8?B?MUFvUkFXUlZCOFpGUTBBSlU2V1U0QXMxVzhFTXhKWXhLcDE3bFJ1WGRtdVYw?=
 =?utf-8?B?RFNtYWFRTXdNYS9Hc0N2dS9SKzR0dWNrNmFJOG9FZ25kd1VUcHE1MkZTaldu?=
 =?utf-8?B?VVZabTVubFN2UHdaZVBIeFZRZ0FwUDZISThZTjlQT0pleGxld2trNEdOTXVv?=
 =?utf-8?B?TURmOHdOS3VTOUdBZG0vZUFyamRtVGZvVU1sSC9DeXZyWUNBTmdtTitsemJG?=
 =?utf-8?B?NlZiWjVNSEQwVmt2Y2RwMEtadlZ1RTdZemtpS2pvK1JReXpVVWRrWlRLT1po?=
 =?utf-8?B?VlU3c1VaSXVibk56ZGk2UVNJaGMzaVFRMEhSV242b0hSQjFmVTRJYkRuWGxp?=
 =?utf-8?B?Z1VFT2VURWhkSWI1U2VuMHNvU25MU1JCWFRQRE8zQ2djc3Z4Q0wvbmhLazRP?=
 =?utf-8?B?a3FkMFVySGk4ZmpTeURIbFpQK00xL01XNlFqRStVZlFuYVpUdXBzTzh3OTd2?=
 =?utf-8?B?SjlaWWI3SnV5SWwvbW5aeVQxSG52WlhPYUVSSWlBeTE5TGxRaU5rKzdGdmlv?=
 =?utf-8?B?aE1hTkxhQ2x1SXdydmZSYjViUUZMLzR2UHpLakJ6NzJRckpMQnczQ3Fyck1k?=
 =?utf-8?B?WTRBR2RHYTdBZEI4Q1Z6Q1dqRGNidGlxTGdPNFVhV2lNQzVpMHV4dmcwNkVm?=
 =?utf-8?B?WWxpa0FXcU1MeWZ4MHhGbkZPajhiN3hwaEgvWlM5TFVQbnA4bUNnMWE2clhr?=
 =?utf-8?B?VnBuZ00rdzRldGRJQzVtTUR6a3dEa1lvMjBUWDJSdHNUbmtRQ0I5R0xCVmtN?=
 =?utf-8?B?K0x2alRFWDB1aWlqS2c2N0c1Q1BDdGw2emdvZ0ExNVRSc1Z4aFg0bkkrRkNK?=
 =?utf-8?B?aUtHMkxyTkN3bEtISlVlalRVMUk4dW1aeVhVOVIwMTd3Yi91RjRKUHFob1ZS?=
 =?utf-8?B?VXJvazhsdUJUdVg2VXJuSUx0NVo5bEdRQ0pCeUFKN0ljdW1EVUZJU24wS3pu?=
 =?utf-8?B?clVHbGs0RTI2S1JXK1VLZVVnZG0xT0F1enBzaHR1d1M1Qy9CeVRrV0wrMWRL?=
 =?utf-8?Q?5YOyCmAgpaETiiAzZLVe8HE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e8d3c5-41ff-47dc-ae54-08de20d92c8c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 04:17:06.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGYiZ8+7V1IZOHaeFEfTh13ME7clCMv9NrW39lH9sS1ibnn8qNBWfngiF4NJFGBI3jfKaUFdrYzPJzTHWkcgXRj/Ph5N99N6lq+Ew10VIT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7674



On 11/10/25 7:39 PM, Dev Jain wrote:
>
> On 05/11/25 9:27 am, Dev Jain wrote:
>>
>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when
>>>>>>> rodata=full"),
>>>>>>> __change_memory_common has a real chance of failing due to split
>>>>>>> failure.
>>>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>>>> still having
>>>>>>> a chance of failing if it needs to allocate pagetable memory in
>>>>>>> apply_to_page_range, although that has never been observed to be 
>>>>>>> true.
>>>>>>> In general, we should always propagate the return value to the 
>>>>>>> caller.
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>> areas to its linear alias as well")
>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>> ---
>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>
>>>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>> long addr, int numpages,
>>>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>>>        unsigned long end = start + size;
>>>>>>>        struct vm_struct *area;
>>>>>>> +    int ret;
>>>>>>>        int i;
>>>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>>>> long addr, int numpages,
>>>>>>>        if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>> +            ret =
>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>                               PAGE_SIZE, set_mask, clear_mask);
>>>>>>> +            if (ret)
>>>>>>> +                return ret;
>>>>>> Hmm, this means we can return failure half-way through the 
>>>>>> operation. Is
>>>>>> that something callers are expecting to handle? If so, how can 
>>>>>> they tell
>>>>>> how far we got?
>>>>> IIUC the callers don't have to know whether it is half-way or not
>>>>> because the callers will change the permission back (e.g. to RW) 
>>>>> for the
>>>>> whole range when freeing memory.
>>>> Yes, it is the caller's responsibility to set VM_FLUSH_RESET_PERMS 
>>>> flag.
>>>> Upon vfree(), it will change the direct map permissions back to RW.
>>> Ok, but vfree() ends up using update_range_prot() to do that and if we
>>> need to worry about that failing (as per your commit message), then
>>> we're in trouble because the calls to set_area_direct_map() are 
>>> unchecked.
>>>
>>> In other words, this patch is either not necessary or it is incomplete.
>>
>> Here is the relevant email, in the discussion between Ryan and Yang:
>>
>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com/ 
>>
>>
>> We had concluded that all callers of set_memory_ro() or 
>> set_memory_rox() (which require the
>> linear map perm change back to default, upon vfree() ) will call it 
>> for the entire region (vm_struct).
>> So, when we do the set_direct_map_invalid_noflush, it is guaranteed 
>> that the region has already
>> been split. So this call cannot fail.
>>
>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com/ 
>>
>>
>> This email notes that there is some code doing set_memory_rw() and 
>> unnecessarily setting the VM_FLUSH_RESET_PERMS
>> flag, but in that case we don't care about the 
>> set_direct_map_invalid_noflush call failing because the protections
>> are already RW.
>>
>> Although we had also observed that all of this is fragile and depends 
>> on the caller doing the
>> correct thing. The real solution should be somehow getting rid of the 
>> BBM style invalidation.
>> Ryan had proposed some methods in that email thread.
>>
>> One solution which I had thought of, is that, observe that we are 
>> doing an overkill by
>> setting the linear map to invalid and then default, for the *entire* 
>> region. What we
>> can do is iterate over the linear map alias of the vm_struct *area 
>> and only change permission
>> back to RW for the pages which are *not* RW. And, those relevant 
>> mappings are guaranteed to
>> be split because they were changed from RW to not RW.
>
> @Yang and Ryan,
>
> I saw Yang's patch here:
> https://lore.kernel.org/all/20251023204428.477531-1-yang@os.amperecomputing.com/ 
>
> and realized that currently we are splitting away the linear map alias 
> of the *entire* region.
>
> Shouldn't this then imply that set_direct_map_invalid_noflush will 
> never fail, since even
>
> a set_memory_rox() call on a single page will split the linear map for 
> the entire region,
>
> and thus there is no fragility here which we were discussing about? I 
> may be forgetting
>
> something, this linear map stuff is confusing enough already.

It still may fail due to page table allocation failure when doing split. 
But it is still fine. We may run into 3 cases:

1. set_memory_rox succeed to split the whole range, then 
set_direct_map_invalid_noflush() will succeed too
2. set_memory_rox fails to split, for example, just change partial range 
permission due to page table allocation failure, then 
set_direct_map_invalid_noflush() may
    a. successfully change the permission back to default till where 
set_memory_rox fails at since that range has been successfully split. It 
is ok since the remaining range is actually not changed to ro by 
set_memory_rox at all
    b. successfully change the permission back to default for the whole 
range (for example, memory pressure is mitigated when 
set_direct_map_invalid_noflush() is called). It is definitely fine as well

Hopefully I don't miss anything.

Thanks,
Yang


>
>
>>
>>>
>>> Will
>>


