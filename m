Return-Path: <stable+bounces-215589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA5RKbCYimkvMQAAu9opvQ
	(envelope-from <stable+bounces-215589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:32:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 280421164C8
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C67C3028C3C
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31726CE17;
	Tue, 10 Feb 2026 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmHunqU1"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CD1EB9E1;
	Tue, 10 Feb 2026 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690730; cv=fail; b=T79P/A+tWmaz/GazMCzQ6ZsD4E+090t167RvZe7DW8vYAMnwHkik8OXHdgyy2BZOZLNH4SLVvNQ1p2S0NtSEUH0cN9iW7qw8oQ1QpoiTXLjRv34klbavKtQ2KFQ7UJ+4dPLVCg+BlP7EW6k0nFA7gZRHqghvAJHldaEwwwSs784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690730; c=relaxed/simple;
	bh=1iS0YiXnRBEDbdZ9indZX5LM7N/m2VOsKpGJk7cmZPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTJYKOdVa60NeHevIioGe4wq01GkqOGHBTJaDPfUoJQN0eGUCwNblarUiN+hpbIl4a+/D+KkZbGgi+CUtSKHR/oUW3Z3Oi/+UCUP/MADxzMkM/UhtkW4QO6nQ3qmFlD4UVR6L+CZAhJ0tUm/ZffR/ecInCi/dZBNlrgni8cQ8FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmHunqU1; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZJXQ0jSWLEBycVslwiveknG247WE1c0fs6V6G0NliKfGBxZvc25R7fbj/8C2AOr2eXydYcZoqz4ms1eSf3seQ3XfD1YDayfY9ienFdnGmFgZXH7h0f5dlFQMINpHQqQRimJ1kqsmw5/7S1zxwtKYy/b3Hx1aFHCiR0E8KK+sughqAW07hr1HAGrdscJuUhmxR3U5L7qECwK1FzbJlg5yG2HCZOHbEDo7NdPrMcmsKcvDP9XgPcVOz4DfuvjHK0OzI6UDnKymk1RSp96bdobHWMKfJP+TZlRBaGm0APxVAB2txgLjtEWEJf3slZAFTgkyvoN4w7yNkTeaGlWicZr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INY26cD+R+naI7N4XMbmp1knUGYP2KF/uVwKo7vpE+Q=;
 b=iiClQKKP1ZXQQOX0WkKDItePnh0OTLVlkvvTknHXy9XsB/he4i2dcFrv1rrQrOpewGpsflAwKnwpFlr+PLzu6qKk+hm/cgypEFWydsJOdeEiDT44BEv1Nsovm6S87F/whnEOUJ00B6arnnD7j/GVnn8AaCPyrjnvdf38ZhQE0EeoVtp0j2ktPTzBG7LmybE01VqWBdWg0B1o+KKFNPMnhZvaRY4rhtr/zpcx89lTXcwEzqd55JLPmadRngPcXAjz/5cuqqdqYWq5wKZiyODdhuQ1IxjobEMRxLrggzKWbc8ckn80mnlMiGeChvLClFFZtEsBJAvd2bwiqm2jcoXgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INY26cD+R+naI7N4XMbmp1knUGYP2KF/uVwKo7vpE+Q=;
 b=fmHunqU1eQj8GjrJtkAe/2IizBbMJahBy4prafmOgAwEPEJ5p1hDMOkUt08BMjfLkRFCq1CiF/AhAm57IjOTq59vE8Ctnw7NSx+ZS7NnMSmGB6M24X8X5MBRb/ypc0ROcyyGLgwhgoWMCLiD7lg+QMnjXN+kCbHdXiVIYqP6Fo1Q/2Q7l5PnCyEjHqa5+4Liqiy+CG+V8xHa9BWPB3s974oMmMs86tLPCuFk+UBym/RS1cOQIS4os64CM9g4fZJr4GY2ZNOLn8S0qUptlVWd67Ei4Yfq2FNVVzagjYN0cld6eqyqMglqUZh/Pt9JKS0PQE6zwnPH4CxEkq/ZTu+qgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 02:32:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:32:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hughd@google.com,
 chrisl@kernel.org, ryncsn@gmail.com, stable@vger.kernel.org,
 willy@infradead.org
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
Date: Mon, 09 Feb 2026 21:32:00 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <92E87FB0-4C98-4E03-A2CF-AE365237D29A@nvidia.com>
In-Reply-To: <42cc23b4-4fd9-4286-8090-371cee180687@linux.alibaba.com>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <0BC1D792-80CA-4E60-AEA0-187F73BD4723@nvidia.com>
 <bc0b6d03-4309-463d-a112-aae57cee335d@kernel.org>
 <22431471-b569-4ade-9881-387debada00b@kernel.org>
 <91F2E741-5473-4D34-ADA1-C9E6EDCBF5E0@nvidia.com>
 <546b200d-5b70-4db4-99f1-f50f6a343c10@kernel.org>
 <3E055DAD-647A-456B-9230-4DD2574D4E8E@nvidia.com>
 <4a759288-baf9-4fe6-9d16-034edf6615f0@kernel.org>
 <72534BCC-2581-4BFA-B3BC-2CC6FF1B1E7A@nvidia.com>
 <e69270cf-dac1-448c-ace8-3f789e5cdc6e@linux.alibaba.com>
 <71370B54-A462-4F72-AF82-8E076AF112FC@nvidia.com>
 <42cc23b4-4fd9-4286-8090-371cee180687@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd9abd1-6fad-41b5-ff33-08de684c93aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWplWkJEMVV0WFpPdERpL2VVVzFSb1dmaUVLNTR3SlpZSnZLOHpTVlpxRkNL?=
 =?utf-8?B?NExEV0cxa1FkSUU3aVRGZ1UxdFQ2aVhkY2tlc1ptTzR0NmowbGdPNG42SUt3?=
 =?utf-8?B?SlhNcE9zSThqYjc3bm94NFVXOXE3cmg1UlZvNUVMTVQ0dXNlamxZS0xMcGtx?=
 =?utf-8?B?eWkvMS9pRXAxVU9OYTd0Z2VqZXBRTmlMc213Qm1XWW1iOFE4NTRLaW5NelY5?=
 =?utf-8?B?VjdMY2R1SEdQRjRZcHh4T1ZmSGRTYXFGVElYMzVaZDdLMlhZM2VuTW0vMk5R?=
 =?utf-8?B?ak9YNkMxNUU2WnRXSEx6SXJJc2tDSG1lNUpyUnRIbkJHS2N4b1R5QnBFWXhx?=
 =?utf-8?B?SFZyam1hTGYyTlcvMW4zcUkyR3VXMnRhYUpqZ0dPS21YRG1kRG1UekZ1V0hD?=
 =?utf-8?B?Q2FMVG9nUVFuTTJ6eFpSVmxtSE5za0R1enpKYjJPbnBkSHBFQjhqUHpCWWVV?=
 =?utf-8?B?cHlmZnlxYUhDYnprN1FPZGlzWnhWU2p4V3NTY0VoeVRtSFMwMm9TenNhOXBD?=
 =?utf-8?B?bHBQa1NIeWx1bTFUQ3MycWV6WitxNVgwNWJ0ZCtYRmZSVWlsM24yc0NOSXZZ?=
 =?utf-8?B?ZGUvMVVkSXJ1OGJ0ZDdyM3h2MUlGaFV1Q0x0NGprZWpkLy9KNC9kZ2F5YWdB?=
 =?utf-8?B?bXR1UkZNWWRtZU5mTm05TVJCME1DN2ZtQnJrZmlWSU9yYWxhbG40OVd2aWhS?=
 =?utf-8?B?eGw1aXVPYTRnMGUrVzVLTU1xcFVQR3lLTjlVUlJhdGxlSDdqQnRFZHZRNmtK?=
 =?utf-8?B?M2wyZFpvckcxNnFRWXdvK2JQS1IzaWdCdWVwK1dzRFpMNGE0M2tiLzJ0bmRa?=
 =?utf-8?B?Zk01eFpkSUxsUVc1TElManFuL1M3dzZ3WWFPUmtLY04zc3pTTEhCUlNtUWNu?=
 =?utf-8?B?WjFzTUk5RFVVeThndFBtNHF5WVB4eE9WOFA0S2lVM3pucGZZK0lzb3UyTUtN?=
 =?utf-8?B?VGhFcDU1RDFpTm51UG9DQlpuQTYvK2d6ZjZOazVWOEhndWNFaWpydkZybGx5?=
 =?utf-8?B?RjhJNW5TZGlOSFRBTWFhbjR2NzBDdy9GN1FQUmdTK20vTTJqNjFHSzBIRmtP?=
 =?utf-8?B?QTVSS0FzUkRqejU5WWhwY2U2YTZ2amFHOWJZc0M2ZXNzQjY3REtHUHhWaU1y?=
 =?utf-8?B?MVVLbXhXV2NXRjBmdm5VdzBBbVlSMEZNbEdUdHJ4a2VhV1pQL05iNGFCOVhx?=
 =?utf-8?B?WTIrMDJUQndRZDBTZG9MV0xkM2NobHU3c3U3MzV3TUZtalNIcmw2a0ZTNkl2?=
 =?utf-8?B?allDUkJQMEVKaDNNSkZGalBnWVhNUkU0S0h0VkxJZFpMY3RlMmJUaE0wYXVn?=
 =?utf-8?B?TEJtSnJVVDYvbEdqMWk1bCszMEk3RE44QmpLWFJPdzI4RHByR1NjSjU4RmZp?=
 =?utf-8?B?NjhWdnY1UUVZNjZTN0M4OEtWZVZMN0ZvNDdkcXJ6cmtuN1AyallQd3hXMElL?=
 =?utf-8?B?bUkySFhyY1BVTVFYbVlGbW9hZlluaFd3dXF5N1JkYmY2QWlkL29jdlpYWkNi?=
 =?utf-8?B?UlZubjBOVEkreE1ESGVMeFNLd2ZBSlN0aFBIK0dzMXBOWkFQNUF6UnJYaG9M?=
 =?utf-8?B?emd5YWx2dU1Oa0s3UStNNU1zUWZENmFXaXF2NFk3QnNiaVhYcWNiYkExNnBD?=
 =?utf-8?B?d29LbkI3ZE5pN2NTMmt5Y2RiQW1VYklqN285cWlpZXpBcHpJZjVoQ051eW1Z?=
 =?utf-8?B?SVFoMkV6MGpkb2lpRnlZbFk2eE1SNFhKa3JtY0E0aGdPdGxydmlXL2t0dUd6?=
 =?utf-8?B?UVd0WVVBUjE0MlYrbEYzSzU2MGJ3ZkhYREhBUG0zVDdoU1NMQ3ltaE5zZUFE?=
 =?utf-8?B?UGJmMDMvU2NsWEhFK1V6WVQ1V002b25vY1U5ZDV4Z01Gd1dlRzRuRkwxaHE2?=
 =?utf-8?B?akM4SnlzWk0xUGlaZitOTWYrZGxDV0xzNXhaeGVyNDYwamRHT2dUTld2MzhT?=
 =?utf-8?B?NXc4cFFDczBCSjMxMHJhUEdsNzdxajB6MHNuMVpaUXNCOEFQa3hjaEgvY1hC?=
 =?utf-8?B?MnRnNm1NQTluQ01mV1FLVHBLRTkwdWpoYXhZMzdqY0JMTkZ2MW1YbVJZaGxm?=
 =?utf-8?B?bEwwVmQ2dDNpMklDaHkwM0lDdDBudVNrK1dPb1JwUEtvSUM3UDdHZ2RXMHdz?=
 =?utf-8?Q?fvSA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ozbFBxUHV3M1Jvb3VBZ0R3Q2pSWFFMa0R6TE1SWE53SVNtdS85c3c0Q1FV?=
 =?utf-8?B?MFRtR0MrT1lzYzRhUll1VHNqbWc1Q2ZqWXRSN3Nod3RRMFoxbkFFMENmQTRk?=
 =?utf-8?B?TUVOa3JPNW9xdUFGNExUWkJlOXNvL0tyRm0wNGdFSjZpR285ckdyUlMwUFdz?=
 =?utf-8?B?VGRxSVRKajhlazNMTzFtNExFTDdLOHlaMUFjTGJYcVBGczNSK0VKcS9mZDV3?=
 =?utf-8?B?SG5sL01ldm83RURTaDBPeGlFNDd4ZVNEMzdtZHZPQm1xMlVWV1dzZHRmYXJC?=
 =?utf-8?B?bFNndEMyZjYyV3R3UzBLTnMybHhXdTZ6R3cyeU1BMHZEUExyZ2hZY0YvUHRs?=
 =?utf-8?B?WTdKZUg4LzFQc3l1OHhQTXFOOW9TcVU5U2JGS1pPeFdEMU9wMFJoc29yckxM?=
 =?utf-8?B?T2VOc3BJZjBRVDJrSGdReEpGRGhMOFNsK25JcFZPWkxLNk5jZ0J5QjdLM3lD?=
 =?utf-8?B?MkNrVE1vNWJiaFkzVWRmWGNLamxValZHZVBOT2xwenVMb1VnVWljNi8rMkE2?=
 =?utf-8?B?QjRtYytjNTdwWHFhcDdzUERsdVR6eFh5eWJzbXc4a21DWmNVWEFrMGFia09S?=
 =?utf-8?B?NW1iU1RKRmQwNWdzR1VreVJ1L0NMMTlXcmNlQTVkcm9lcWMzVjFPTCtRejla?=
 =?utf-8?B?RG8ySC9Ldkxyd3pleDE2QmRKMGJoeGRxQWJQWnA1YUJvZDlDdldobWlSWUJp?=
 =?utf-8?B?aG1mWkhOd0oxQkUvYXJISFMzb0pJcjFQbzQrUzdOODQrR1Axc1lYM0Q4Wk5Q?=
 =?utf-8?B?L3NvT2N3R1grRU5LTkk1WTRXaHc1QkRVNVpMejRLU2RWa2huYjkzRXoySFNZ?=
 =?utf-8?B?WkkwZ0tDZmlDeHBUVVFpNjgrdmlLSlVkakgrTXR6dFR3cUVOUXRUbGEvTFRO?=
 =?utf-8?B?eFRCQ0wxR3lxNzVqL3Jzc29kWFZDZXpvOHFucWVGN1ZwMTRiTmtyOWFFQUIw?=
 =?utf-8?B?SFY4cG12S1o5T2NPbnNCcU9sM05aTDhFTm1iWXJPdEEyNlYwblpPL2Y0MDRk?=
 =?utf-8?B?TGJrYXVsZnR5UDdMYVQyL3J1dnNlREx3YVlBUSszQTE1RDIxUkpCQk8wYmdK?=
 =?utf-8?B?aHorWkRLSUtkOGtFYWhXSWgyTjlYdHpZc0ZKeHNHYU5vZHlLRXZiTUpFdlAy?=
 =?utf-8?B?RE5kYzVtZlZsSnVWNjlzQlZKYUZGaUNFVHBnbTVoQUZkMk5SQ2ZGS2NWZkZE?=
 =?utf-8?B?cW5NZE9tUW5ubHVNc01NaUpuVkdNbFNaREIvTTNWNXExUlF3aWlqRXRvRVp0?=
 =?utf-8?B?WGlyMWlxRkdMclRjWTZNUStNV2lsRkRXd2s1aE1jWWwzbnFXK2o4ZHRiUFg4?=
 =?utf-8?B?TGEyRDMveVp4Y2syR1IvbHRRKytnOU1uS3J0d3VuY0dETEtTdkMzeW0xU2hS?=
 =?utf-8?B?ZlBVUnJuUGpUM0h1cDB1NWRQLzdVeGhwYW82NFcxWW5aVmhnN0tSeEZFUUd5?=
 =?utf-8?B?UUozSFloUGJVb3MwdTF2bllOVXVkMGFFaGlvNVl5L0xBd3hEMjIvK09zaVFn?=
 =?utf-8?B?eFoxYlhJcmRVZjlxTTdYTXhITXZqUEFrUklKSWx3MDM1djNXbE04ZEUwTFh3?=
 =?utf-8?B?R1JqbHhjYkZkcmpjTVpVNmoyWWxtMkNoWVJKWmk2d1pDUHQ3YktCcE13K1Z5?=
 =?utf-8?B?RXNIbWwyc1hGMUZLNnFmeWxSa2o0cHRYc1BDelhHa215dUJKOEQ4R3k5ZGwr?=
 =?utf-8?B?cmdnLzVqenVKd3pXSksrUkQ4NTRralVJd1RxczNHZUFKV1lSZkpWQ29FdW9l?=
 =?utf-8?B?MzQ0QVRSOVF0a1lGb09UTDFWbjFOeU1yd0Frb3hKdnRiOW56RnJnYTJmV0dY?=
 =?utf-8?B?WDROWGNFTTRqVk8zZXZhbjRWT0ZheFZYZmRvQWx1ajlVMW1Yanp0RW9rbitH?=
 =?utf-8?B?MzFXcGNwQStXdWh0cEgwR09KMDdqd3FJRnBBNGliTjlIbUlPZURVWXMwekg0?=
 =?utf-8?B?eHhJb1Naa3M5aWtvMUJjeUtJa0tHZWpaRnVOQVVNQ0hOZ29kNXZYT2Vaa0Y5?=
 =?utf-8?B?U3BsKzcvdGtQaHp5UEhzTWZnb2FyS3FIUktMT3lyaEZabzJnMjBseTBUSEwz?=
 =?utf-8?B?RUR4TFdWOVpKbFJpNDIycHlXQjRjVWs0dkpCSmNBdVFSQ2J2M1RET2VnOHJF?=
 =?utf-8?B?ZGZDQXVvTmJxNXI1eHFWakE4cXAxUVU0d1FQRld5ZDhNbGYraExCa3hHZ2g2?=
 =?utf-8?B?ZjJvLzFDVElLYnpMV0FQdUJ5Q0U2UDJrNzM2Ymw1dVZjc1BWbVpITnNOSS9y?=
 =?utf-8?B?ZDA5cW9HUFVTUjlwZm16cUY4eVNwaVBXK3FMMENaOUM5TGQvaUZEUW01Wlpl?=
 =?utf-8?B?ckhSSU1ra3oyRmRVOGVtWlZnOEZGRDA1RFFFMHM1Mi9pSWRMWDI4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd9abd1-6fad-41b5-ff33-08de684c93aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 02:32:03.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UABxb7LSi97ZmlbDDtOldazDLyET2n8i7CLwxeX5E25W3labalUYbJxeluksu/wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215589-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kvack.org,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 280421164C8
X-Rspamd-Action: no action

On 9 Feb 2026, at 21:25, Baolin Wang wrote:

> On 2/10/26 10:12 AM, Zi Yan wrote:
>> On 9 Feb 2026, at 20:20, Baolin Wang wrote:
>>
>>> On 2/10/26 3:42 AM, Zi Yan wrote:
>>>> On 9 Feb 2026, at 14:39, David Hildenbrand (Arm) wrote:
>>>>
>>>>> On 2/9/26 18:44, Zi Yan wrote:
>>>>>> On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:
>>>>>>
>>>>>>> On 2/9/26 17:33, Zi Yan wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> I agree. Silently fixing non zero ->private just moves the work/re=
sponsibility
>>>>>>>> from users to core mm. They could do better. :)
>>>>>>>>
>>>>>>>> We can have a patch or multiple patches to fix users do not zero -=
>private
>>>>>>>> when freeing a page and add the patch below.
>>>>>>>
>>>>>>> Do we know roughly which ones don't zero it out?
>>>>>>
>>>>>> So far based on [1], I found:
>>>>>>
>>>>>> 1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (over=
lapping
>>>>>> with private);
>>>
>>> After Kairui=E2=80=99s series [1], the shmem part looks good to me. As =
we no longer skip the swapcache now, we shouldn=E2=80=99t clear the ->swap.=
val of a swapcache folio if failed to swap-in.
>>
>> What do you mean by "after Kairui's series[1]"? Can you elaborate a litt=
le bit more?
>
> Sure. This patch [2] in Kairui's series will never skip the swapcache, wh=
ich means the shmem folio we=E2=80=99re trying to swap-in must be in the sw=
apcache.
>
> [2] https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/T=
/#me242d9f77d2caa126124afd5a7731113e8f0346e
>
>> For the diff below, does the "folio_put(folio)" have different outcomes =
based on
>> skip_swapcache? Only if skip_swapcache is true, "folio_put(folio)" frees=
 the folio?
>
> Please check the latest mm-stable branch. The skip_swapcache related logi=
c has been removed by Kairui=E2=80=99s series [1].
>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index ec6c01378e9d..546e193ef993 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>>   failed_nolock:
>>          if (skip_swapcache)
>>                  swapcache_clear(si, folio->swap, folio_nr_pages(folio))=
;
>> -       if (folio)
>> +       if (folio) {
>> +               folio->swap.val =3D 0;
>>                  folio_put(folio);
>> +       }
>>          put_swap_device(si);
>>
>>          return error;
>
> Without Kairui's series, this change is incorrect. Yes, only if skip_swap=
cache is true, the "folio_put(folio)" frees the folio. Otherwise the folio =
is in the swapcache, and we will not free it.

Got it. Thanks. I just realized that the above diff is on top of v6.19-rc7.
The fix to mm-new/mm-stable for shmem should be:

diff --git a/mm/shmem.c b/mm/shmem.c
index eaaeca8f6c39..a52eca656ade 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2447,8 +2447,10 @@ static int shmem_swapin_folio(struct inode *inode, p=
goff_t index,
 	if (folio)
 		folio_unlock(folio);
 failed_nolock:
-	if (folio)
+	if (folio) {
+		folio->swap.val =3D 0;
 		folio_put(folio);
+	}
 	put_swap_device(si);

 	return error;

Thank you for the explanation.

>
>>> [1]https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/=
T/#mcba8a32e1021dc28ce1e824c9d042dca316a30d7


--
Best Regards,
Yan, Zi

