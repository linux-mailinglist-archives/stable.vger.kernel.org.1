Return-Path: <stable+bounces-151987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D46AD1832
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA791889842
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CBF15B54A;
	Mon,  9 Jun 2025 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jvq+hZad";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jvq+hZad"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1411F19A;
	Mon,  9 Jun 2025 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749445840; cv=fail; b=BpcHqa0UpXu/EkD8r1HIrMCIU5I0TgCNpj3TBACFryDISoUEgAEBobdoAePYwqBB4iKPlG2omOag7tFpn+tGi+934PoXy/rvWtg2WSKMowLQg2wHafoLBvuTjkNDkY9H2Gic/vhJZHtwTv6LCDcDMbgK72UMEv1Vct402ANpZHM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749445840; c=relaxed/simple;
	bh=ohGTqkUgQ7JxZSsMWD71D7pLQZKkugCXAAp5yOpq+j4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGh8qzTPskZ5KYcFbXp7/mskVSmNpJ187FB+Ia0tt/uG0ODSC9y6xSGrEOjU9Q3XbdBdsb0/kCT+LyNOyXHKZCNMItoSeqvwGa3UJdr3es28IiSJE9YGMWFBswpgWr/hIgtKN1HA433IdE8zgVhJktxUWdkA2Mk07Wxodms1Niw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jvq+hZad; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jvq+hZad; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MpUehyxsWsGhbVn+CwtpKmQQKzWj9YWvD/yQuZ9I2BwyKJRCt04hSWGeGy3HIbOQxHP6BVoSVA16SG8I0ry1cc5KPQdYbBuRzENQB5hf0BN4Rs9/+PVFfG5mfBQwSHTN7uQCo3Xph6JXfqHQG68KQ/mUtVQhR2vPK8Jdm5OzW3MeU0IIvxscvwUltvHNh7i8jAiGhHIb70Ma+jaNF62BGJw2ToDyq3MOGp9i9Z/O9rOAvOPRqy8DE13HOURc9dzsTOeHQo90cFn9c0HOlPDqgkr/N6hfuXZpHiQ6kTfgxJxpZM5PniksMUjMqbHkA7TJa3hV+M8/y71Fe+IcIWArqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohGTqkUgQ7JxZSsMWD71D7pLQZKkugCXAAp5yOpq+j4=;
 b=QjoyvQyH01+7cthDtIV4aT9guYTyO6OEpqRJ7OX0Ms57CVHzNCObH0wn9Z6nlDpmEaHfSmlqF6jY+ZzWuAIze/R5sqnt1wQbUuEXQwa6JfraDQe2VjY/OIEFLFUCJkTVyPHRhhjkaCm4rxwy6SVv1/NrsI/XdFjsgAZF6uxSjiNlayT65JvG29D5FU9QCgt4fjDoy7LENz1sQeiSsPzv1H5sNeRe5fvouBiiZGOOIiYDkdaWMjeX3wiiA+1G8sIo77cOfykuS4tmgYi/eAU2EE+Fvoke6RvS/J0extB9Gt+wBk+nAvZKyCsWYFeQin/jc3pqIYTdOr3kq8GHCKDa4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohGTqkUgQ7JxZSsMWD71D7pLQZKkugCXAAp5yOpq+j4=;
 b=jvq+hZadIytTknkOQUCWyAhWjme2DjID3Tkx/eCqy8jhCjgh6eenBZ2AzV6Rp0LTS5Kl9RTYZkprsZPtzupdssnsgF4xlSC5WN7CG45bYw5BrIh9XOrUOFzqWiMKamywPgVRZ8Vo4fXJfXO90z2bjF25bzm3vAtcbL0YIyMnHx0=
Received: from DB9PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:10:1da::18)
 by DB9PR08MB7772.eurprd08.prod.outlook.com (2603:10a6:10:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 9 Jun
 2025 05:10:33 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::43) by DB9PR05CA0013.outlook.office365.com
 (2603:10a6:10:1da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 05:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 9 Jun 2025 05:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z38zE88BrEEWqM9MUpbDAH73wT0VrYZBFAdx52R3h3x+VlswJmsnY9QV/yDXNVLGUK1YkxFj6IUprDV5dLFLA+8iFKAUAFFs0d6RzugKOZSO2+LOksHD9w2udKuY+S2mMHcBJ9xYNM9HHmfUUojU1auPTqXNMRpIytUACObV3yRp67kcyuSnbr//tq2TChvOx2Z8K7zWObpypQ3ABtV4Ew4mTJjCvgfeKLCVe7UbdQuYbYSTly45BBxHE4jDyO1ltsOYg3I8i2cZo/cRFEYQUsuZMjM98iZ2zuTB3qAkZfgeAXTbbLGFKiC6xq87dkRLlcPCd4fWp1YLnL82Og+9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohGTqkUgQ7JxZSsMWD71D7pLQZKkugCXAAp5yOpq+j4=;
 b=O7HbBYePdpVorS0BptOoBjywtOPy0ia2tWjlmK3pGpg1DTQ+oI9Pflu4OJxwoFKY+fqcJ7b9KDqxNyj2rZHEG1QW3EnRTBXIbqBE9asN4zdf8FJ8h6XlWjHK25dfafHFEeKZUhOtLAzDg3DtNbP8Ky2qAB7rGDEdcwYigCdsNC6smZ7TANkFiV22meIRC99GQBfjYwFOuQgM0u3BcASgA0+u1r/7oHpgu/83vVUK5jDbdMVLIDqoPkQ/W3SPOQkwOTJYSKPUGbyn8mfxvDKETI7UAwsQ02dpSc4ubB0HjrqymhsTP8uLUGa+q4Uqq6Gnm6kR5pBKQSin4cn8u27mMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohGTqkUgQ7JxZSsMWD71D7pLQZKkugCXAAp5yOpq+j4=;
 b=jvq+hZadIytTknkOQUCWyAhWjme2DjID3Tkx/eCqy8jhCjgh6eenBZ2AzV6Rp0LTS5Kl9RTYZkprsZPtzupdssnsgF4xlSC5WN7CG45bYw5BrIh9XOrUOFzqWiMKamywPgVRZ8Vo4fXJfXO90z2bjF25bzm3vAtcbL0YIyMnHx0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB10806.eurprd08.prod.outlook.com (2603:10a6:150:162::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 05:09:59 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 05:09:59 +0000
Message-ID: <b437b07b-bc62-421b-9a5f-5fa414fc8b5f@arm.com>
Date: Mon, 9 Jun 2025 10:39:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250609041214.285664-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::21) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB10806:EE_|DB1PEPF000509FA:EE_|DB9PR08MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: c303d118-ed4c-46a5-bf15-08dda713f61b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TXozMlhGOElRVGlQVnZQeGxIVUhjeUMxZXJ2a3BrZURycFpGM00yTWpJS2lt?=
 =?utf-8?B?dWwyVjJaVDVCUzhoS1crMXVybXNtQUt3TU1tcDlYaW1heU80TEVIaWx1R0NP?=
 =?utf-8?B?MUxGWDdsc1ZHK1R5ZitaTkxFaUVXTnJmZlRYc0diQ09Bd0Vibkt1N2lWd29U?=
 =?utf-8?B?eXpMQ1ZMR3hNbHBEczYrM2ZTMDVwRnVBZ1B5SmpaK3YvVVhXd041UEl6bkc0?=
 =?utf-8?B?YzZ5MmNxbHZuQ0dSVjlWbUliY3YrNFhMeVZ0K0JNM08yUWoyVkdXa3U2cUMv?=
 =?utf-8?B?blQ5TmErczZFOHF4WndvaWtYTnp4RVh4YkwzZDdEOU1DbWJSYjQxTk5XRXY4?=
 =?utf-8?B?THkyUTRsTFh0NHNlWHgvTkkrMndLQyt6V2VxOWtzVjRLSVBBYTh5dVhBL0Mw?=
 =?utf-8?B?ckRwU2VXUEYrV0pDTHRYR2dsMlNMVC9Hc1REWVZhMzRXN3VCTHR0K3ExZTVC?=
 =?utf-8?B?YWFuazkxUUozaitMWEovRGRJTmNGZEpPVVh1Y202VThUbHJHQWdwWERZdDRJ?=
 =?utf-8?B?cGFHbktNR2dyWkNRanlWbFdzMDNsSVZtYlJXSGxvdEtrQ2dRb1M0ZzhsNUJO?=
 =?utf-8?B?U0dlTGI1cHJ3dWY2aU5vNkhlK2pXUENnSnZWK1NmTEtvZ05ydHMrUlVLNVZJ?=
 =?utf-8?B?dzc3cStoWWpBQks2Mk53TkJTUnJwN1V0anlMZjlwZlJIVFhlR0lCRG5vNExu?=
 =?utf-8?B?NU9PaFowWnJ4V2o4WmdPN1Mvem02UHlsa0tCT1lyTjBJSUtHVEVvbUJZeWhX?=
 =?utf-8?B?YW9nWVV6SFFoanBLR3hqdGt3Nm9XYjBKSGdka2JhYVIvOTR5L3lFV0liMC9Z?=
 =?utf-8?B?dnF3VkFqTDVtQk5ENVVod1lkV04yUmZKd0VGenRtWnc0RXkzcVY3OS9wRG5N?=
 =?utf-8?B?ei9hWlpSZ1ZRWnViVFRlRTVFUzhlcVVmRDhneHJpRnFmVnNSdy8wSjRWSTJF?=
 =?utf-8?B?SW5HUlI5RE9UbDVjcmVWQnpUVm9YQUJncUNPR0NLRDBPaEtzZHRrYUJRYWZV?=
 =?utf-8?B?NjdPakFaV21lRnBuL2FRT1RDbk9hZUdSTTlOSkw5NWQwVGhrVFFJV3V1R2xY?=
 =?utf-8?B?QUJ0OTlweHNZSlJFbS92TmQvWXJ5NUNjNEQvT1BHV1o4SWNpSTJCUytIR1FN?=
 =?utf-8?B?ZUpKT0RJKzArb0VhTUtYWlZIMGg4dCtpcUoyMEZaeVQxWHVUQkRFRTg1RERC?=
 =?utf-8?B?ZGE0NVkrK2lRSEpBSGRiZUdQT3ZVM2EyWWlxSEJDNVBOQ0N0T2IzaUFWRjYw?=
 =?utf-8?B?b3Fzd0ZOMVJaaHJUa0NpTmcyaVFEMno3YVoySWpNWStHenRITC9MZEl4UEIz?=
 =?utf-8?B?QmMyYjBsbzhpOXY1SXQvMFAxRHM1SFdtbmdmcnd6c05rcjNTcDNsMzRUTEV1?=
 =?utf-8?B?T284ajMwWUd3YzF5SmEzaThSZXp6dGlERjUrWXAxb2VwblFkbFhxaGM3a3pp?=
 =?utf-8?B?YVJZSjE0RXRWaFRoSU1IM1VyeXhTSjNtSTJwZjI3QnFTZDhSaDhwU3QxTWxR?=
 =?utf-8?B?dS9qN1o2OWNTc3FaVkhIajFYRWlhN2s1WEFFZUVTRGx6N3prYkpYOU5tbjRH?=
 =?utf-8?B?Q3lLL0xBQVkrQlVQMjZjQmRLMjNUM211RHFBVEVHcWp6RDBYZXRZNUpuUTRr?=
 =?utf-8?B?VWlRaVZ3Y2hqZWszYWFvZDZBckIyVmFHcTdCbTFxQWt5aHBJUVpkRW9RWFhQ?=
 =?utf-8?B?dzlPTnA0TlFSaHNTdEJOdUNtTFlab21HK0o4WVZYUkZreFlpUU9VSDVaUjNM?=
 =?utf-8?B?RU1NVEgxWUordmlQWDhKWWtLUnZHaU1NNHhGY1NJd0xRVXllNzhvSzFZZ2tZ?=
 =?utf-8?B?cXE0ZjN3Qi9tRFdtQUVhc0JYclB6UGhXMWQrLy9OU1ZFM3BvYzA1azdXa3pX?=
 =?utf-8?B?eTFCODhQOTBvdThjYzl6aXlhb1hGUHJwbmwzTms4eUl1RWkzZHV4aG5hdVlr?=
 =?utf-8?Q?wBj+vs5uu4I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10806
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	be8e4b88-d715-424e-4460-08dda713e194
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|1800799024|36860700013|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3Bham5wQS9SNGkzUHFPTmhYeEJDSTdiZXdOZXI2ZTkzNGM5MXJ5YWsvSjFH?=
 =?utf-8?B?UitTcWVvZGh6SXZpZ0lQU2M3U1NDeFFRa3NjWitXdC9INTM2OTFHeUw5RGhO?=
 =?utf-8?B?MXdzSStXZlVQeHJYN2dhdUY1d2FDOFNhU0RDWnZwNjEvbzF5SWwyZzVNQjV6?=
 =?utf-8?B?allTWnNDSUFSSW4rWG16TkRSVSt6cHd5SHpsOEJPVzY5L0pMMWZxamhNZmto?=
 =?utf-8?B?aCtjUFdrS1g3SU4xQ2x4aUhteWw5WVJJS1dtdnY3UE9zYXRhRTAzL1BCRDg5?=
 =?utf-8?B?ZzdDQ05tQzVIYWVXTVIzcys1cERFTEtnQzZCZHoxdXhiZ2J0QnNrbklNZTla?=
 =?utf-8?B?SjJXck1zcSsyZ1loeFI1Zi9pTDJMVE5ycnIwQkpubGJyRS9NdEVCaUNQakNQ?=
 =?utf-8?B?RUNPRjliU3hScmpuVmlMeWFRTWppUVhWUmJyZVJyZVNDRlpUNDEyYjRjU24z?=
 =?utf-8?B?SzFuZEhHdERnOTVKSEoxUWVSODNGTWRiZm9VRUFWbEdWSkJHdXd1dzlQaUk1?=
 =?utf-8?B?bHdlSHRHWE8rYmgrVWJnanErM3k0SGUxZ3pRUXlIVVpDVjhxK0dtbEZzR3Nh?=
 =?utf-8?B?b3dPM1VwSDVDc3FZQXVvQjllK2pmbWJ5SDllY0Iza1pNQ0o1QzN6WmowQzRk?=
 =?utf-8?B?K2tJMW9vUGN3Q3ZWTEM1L3V2b3RnSHducG5EZE53bFZyQXdRb1FRS2VVQ1Z2?=
 =?utf-8?B?MVlOUUhwdFA2ajhhNWVoTG9vS3FFelNXb2dZcDF5VHVycVBNVnA2RlU3aXE5?=
 =?utf-8?B?aDZaMUtOKzVKYStuVjh1ZVZTeVVWaEVsY2NGaHZrSFpDaE9SMjdFZ0dkWlNn?=
 =?utf-8?B?eDFrNXNtMHJHMUpiT0NLTm5HQU1vWkowdzEwWnFsYk1Vak1nTXdTM3lleXpT?=
 =?utf-8?B?eGtPZll0ZEV3endyZ1FKOEI2aWZJUXRlWVljYXpmdWtOeTV4UlZ4dGNmNzd5?=
 =?utf-8?B?ZVAxOHd4bStpUlpleG1mU3V4NENDNVpwWjBkeitkQ2RTQVpmMythK3IxNkhx?=
 =?utf-8?B?Z2phcDdCbVd0SENXY0NsSEloRmZEQnkrWTRNOHFWb0x5a0tXOElnUEhMVVMv?=
 =?utf-8?B?eVFwR3JWTkJNNUsyL0MrcGd2NWpMU0NBdUJKbmF4WXNPL2RMcG5JQmVaeWk5?=
 =?utf-8?B?eHZCSS9oQjlDeDNScXBSVUg5OHlzM215a1NTcTZOTzk3OENYRitRQkpvUVp6?=
 =?utf-8?B?OHdpbFV4MlNnOGt1RlNEaXVrek53aTFEYmNMcHpTQ3pvWjVlbjNPaW9sNGhO?=
 =?utf-8?B?Y1ZYS254QVV4c0dlc0g2Njc4bW1QaFZyNXdaci9qUExybStWdGJJZnNJNlRn?=
 =?utf-8?B?WDliOU5nMnMwb1NGWTRDVG9teW9pUEVtZHgxeFh1YUExdU5pSnc3S0pmVDJX?=
 =?utf-8?B?VEs5cHVXMklKMVVISWlmSG1oeDFOdzdMa0orcFg0ZEt2SlFCV05KZjNVQ1ZR?=
 =?utf-8?B?bFNraEVlazNLc3VTQ2QrN3pBSUZQeDhCY2RqQjJpOGIwREg1TUkwYzlvY2Ey?=
 =?utf-8?B?T0JhYjlnU0MrcHdwLzlKS09XVTF4ZGZrUFRtamozUVVob3VGRm50V3haY0l0?=
 =?utf-8?B?UUlVZWo4aVR5anNkK3dYcFFWZnJNUmI1ZllUQVhld0NxdFNDbXNLTEVCVzlz?=
 =?utf-8?B?ZkcxU1FuaVk4VEk3WWxjdlE3MDREbERaUnFzb3pkSTgwMERSdFkrZU5XNi81?=
 =?utf-8?B?SlNqNEJGVm9ZUWxqMGRvQlh0N0pzMmxWMkIvb3R5WTZYeVBGbFFkdFExL1VL?=
 =?utf-8?B?WDZHY3VUbWxnQlMzOEw5aG5mblVadzdCdDhCeEpYeHpoQ2lTWWtmVXpFWlh4?=
 =?utf-8?B?MUlNQmI5U0xxeS9TclVvWHJOcUUyNy9iWE9xallsNEZJb0d0YXZFQ1R0ZEx3?=
 =?utf-8?B?M1ZXTXBhNEpnRXJUYXNlUjhndHdlM0RtZVUrTXA4RzdPdUphdHZWbU1RR01B?=
 =?utf-8?B?VnFpNzZxOWNjZzcrVitnVHpFWHBpTVpvMEhKUEJ1RFJ4TjNWVFZEeVAwcDdt?=
 =?utf-8?B?NTQwMFVvdmE5VllWZ1hpejhmWmQ5eElGOVYycEYweThXWXZycm9aUXF0Z0VD?=
 =?utf-8?Q?eS3HMv?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(1800799024)(36860700013)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 05:10:33.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c303d118-ed4c-46a5-bf15-08dda713f61b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7772


On 09/06/25 9:42 am, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
>
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
>
> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
> dump")' but a same was missed for ptdump_check_wx() which faced the race
> condition as well. Let's just take the memory hotplug lock while executing
> ptdump_check_wx().
>
> Cc: stable@vger.kernel.org
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


