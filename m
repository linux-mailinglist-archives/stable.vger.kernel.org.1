Return-Path: <stable+bounces-158971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3CAEE207
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA26188278F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00028C005;
	Mon, 30 Jun 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nIqZsXOs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nIqZsXOs"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DA28D8C1;
	Mon, 30 Jun 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296194; cv=fail; b=HHfKcE00fZN/XYZqinDfj2pZPiQb5NA21y27+6VFvrVnLnpMM8gxV3kfAEzI3MmAEsZKFbYZD064Ux0oPnWIviLH9y5Wwz4LU+LjlPttkSP9sEMDOFbhDVEfpr6eLjVicdzrcoZdanCEDYeDAZUsgftuYQ7YM5KfjySMFsAvu8w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296194; c=relaxed/simple;
	bh=MnzkVqgpZQPPP92tbNxQuGUuaGhXtY0rdYDmuaejR9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKkyjH2mPVz1/4byAsUa4HJOx2xPpw6+XGfRmDoGGJULerkRQgVwBhSN8p6pPC+RirYnogfnOrFQGCvSeJ3qYwBEG7/gP+JGIdr19yFJnrYNXM8WtPr85fBkj6a+1DBLJC4ss5nuJxu4iNjSmxHM+SXlTA18CEvz431kJys8g34=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nIqZsXOs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nIqZsXOs; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AX+a+TXdg3kz3oLzDWYMuLotQC+jtYb3FPsSvwvQsGKFPm8gc+d2+tarjZPKsYld0MjyW0TFFvDpqtBZwhLIiGFzteXDqynoN7EUX8MD+hgIYKmoWp595rZitVrlYE9ig+9cPAH+rwynanYbtWrJ4w4/AA/N/CxAjJPDFtNpwW+9ImiUNwb3WzJQDYcgbnDBkSMZcTdnbBL5iy51X4iD9B/xwmqdUJTPKUbIxFTxajyjORZM+SD0CIluYznWBesJ58dkMtoGa9uyYcoeu/bIsX13tqrzxhQt9axWNzH+0MoFG77ZqFrQ0/D2ya0jsDtudNUYhY3TKq9frlv4LpyCpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGOkft0Qou3+1QgLTSzTdpVuLiixiGAdWrdkvBc7Sdw=;
 b=u1lfKFw2xw1j/HaaN3ObF7UFUSjQY6ybGHIHAGvkSfr5KLUflhGC1k0xWSdrIc27+VJAf0ilNCrDzwTPCKT/xljgXTGeYODXdzKrRNKXTkdE/IMhspcw8GAbWp1GzMraDipGRE1KIfC8vZ8jpw1/1oTMlI/piHq2AAn281cGgt/SPNrvpO6dzF3wl3o3GKJckrQRcykwXBFvHP0TfTxgrQ7s+1JKB8ZIL2FfrRRoHBDkNKUCLrVw8B8qEyzpNV7upcdAcdXbBTvBGf8uUIemQ4BpJ5tola2gtls3h67ExNJmltrhsyIWGsMBCtkojAoefIA+d0OF4ZB1qMBJts+NUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGOkft0Qou3+1QgLTSzTdpVuLiixiGAdWrdkvBc7Sdw=;
 b=nIqZsXOsoMom1Xru7UA8Lwabs6zLdPi0CcMhuTExC2iGiXex9wEA0L338Z6igxodkFmiyate30nX8fzRr6tcugZt7qZK/4XuGvKQ2fcE129aYiIFVSoSSjsMMdo8Lo8aS6v0J1XB/+3W8DzU74pLfZqSEb0SAyL7PtJwwrx8qWs=
Received: from AS4P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::19)
 by DBAPR08MB5638.eurprd08.prod.outlook.com (2603:10a6:10:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 15:09:46 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::92) by AS4P190CA0029.outlook.office365.com
 (2603:10a6:20b:5d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 15:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 15:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsFIa/2dVpTmnTHDZKpf7BhRTHjAXRSECC3QA8NYduu8KsmvWxZrkHCRL5g5ePXivvYrrNB9A+uWDHOO1LI1utobLEfYre9ZPEvImMrh24A4/X1ikXfLM+1TMGmw02oENLbxoVbt/D6gBDmL8Bg4ZrLz7bUR2SorLowciWp99SZEYG7SjIyX6iimZK5MnBzRV/ijU3lb3L0AY40FKEIOBXeld9z/yQl+gBfCot8VJbLaIi/FT3b52r8RGo6TLpyxH68C9EBayGweYGOYKDovwBHsbnRVN0d9svD9eIOds0flP6mXQzIi7pEhqHMsh+o/nSWXTPZdgClWrnCAScGSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGOkft0Qou3+1QgLTSzTdpVuLiixiGAdWrdkvBc7Sdw=;
 b=xeToGzxOQ0ajzWbDnKqMqoxa7VyINLnwztEUe6cWzgGIhaaO6eBgUiF+ASb4an/+n3e9M1LNJVG+MmpcB0EsddHWSa8gV6TL6Dt+rD2gcfCZ8vdhHmI2pYmrGyLZxN8GEdwGibEzo+6/7K1Ue0JboNhN79HsDzudHwK2A5FDcRPS4biVZInlmE7/Z6dmR4sbUM5/hjCESH9G7jL+4WDHZkPrKsgWlDE02w4FcV4dSndlWKjJqheoOLf6tD3f3PqiEVQQVV/PI6ogkqLlWxYdNDFsHSavUxpORZ6HFt8m771DKQSY0jGzVT1ge/ZHj1fSQeBsAxGHdNpCr70qlipTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGOkft0Qou3+1QgLTSzTdpVuLiixiGAdWrdkvBc7Sdw=;
 b=nIqZsXOsoMom1Xru7UA8Lwabs6zLdPi0CcMhuTExC2iGiXex9wEA0L338Z6igxodkFmiyate30nX8fzRr6tcugZt7qZK/4XuGvKQ2fcE129aYiIFVSoSSjsMMdo8Lo8aS6v0J1XB/+3W8DzU74pLfZqSEb0SAyL7PtJwwrx8qWs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 15:09:13 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:09:13 +0000
Message-ID: <ff136c84-4406-4849-aaa3-46578ea444cb@arm.com>
Date: Mon, 30 Jun 2025 20:39:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>, akpm@linux-foundation.org,
 peterx@redhat.com
Cc: aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250630031958.1225651-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU2PR08MB10037:EE_|AM3PEPF0000A793:EE_|DBAPR08MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: d93cbc9f-4765-4f26-e637-08ddb7e825fa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UStxUG1NdjNuVUpiaUt6eWY4YXNmTHVZTWdlL05HbWhKcml5RlNSMTE0R21x?=
 =?utf-8?B?ei84UlZPRXVpcDNqS25KMGpMb05NeGhFZ1F6MXErZVF5M3N2QlBJT2F1TnFY?=
 =?utf-8?B?WmZCQkZhNTA2TWVrU05keE8yTjFPRWl1SEIwcHlPdFJOVlMwVDdYN2U3Yjhr?=
 =?utf-8?B?a253R1kvdDdMaStpNFZGNUlVS3R3bVFldy9uSW15SDlhcFkyY2c1aWNHMkcx?=
 =?utf-8?B?Ulc1TndZVWRsU2RGcVBVeVVwdlQ2dDVhZS9RdkYzcGdLM2lzbnZmQVVWNytK?=
 =?utf-8?B?RU14OGZRaDk2ZWhmVzAyM2g3b3BFYUhtVFMyeUVTd1l4MFh0T1gyL1RPL1d2?=
 =?utf-8?B?dG1MMFlwMjRLUlNhTU5mWXRYOUs3TWVYYUFQd3pvdTdzT0RBTVJXTnBSVDc5?=
 =?utf-8?B?MFNxejVkRmE4c2lkNDNscW5IdlZFbVZycFdDcGZLc1loNUo2alRVbmRGUmRk?=
 =?utf-8?B?L0V1RzI0NjFDN0tiSnNwTldEMjRBa2RsZGRBMGFxemFhT2U2blkrbDRZb0NW?=
 =?utf-8?B?dEhIbHVkUHAxNnVJQUlGcHZZdExObytCNERCc3R0Ymp4UldtZnZtblB6Tm9i?=
 =?utf-8?B?UWMwU1kvTzJ2ZVJZOTZOMEJUcS9tbGZIU1ZxM2pSSGMxSFIxSkpoeHI5bGJ0?=
 =?utf-8?B?UDhxYWZFdnpDMVNPa0p4aWw2YUZiWmdlbzcwbWlyRG5Wa1FGY08ySXhodnNO?=
 =?utf-8?B?czFCajFyc1Nsekl1QWo1NzUxSmJUd0ErZTFXbyt6U2pYNEpYUXJiUEY1U3Jm?=
 =?utf-8?B?VVptQ3lpbHV4aFVoVEFsL2s0ZzlBNEpFemFITXlhWHNLOXFVNXJqZDZZOUpn?=
 =?utf-8?B?RTJjelJQZjVzNm93Z2ZwNzJPdWROOGNHeEYzUm81eWxWZTFDYmx0MU5YM3JS?=
 =?utf-8?B?Qjh6Y0FHbUlTUzRQV3hDT3dLR2FuYnIvTCtXNTI2RDlnbFp4RXc2dnNlKzB0?=
 =?utf-8?B?a2ZtaW5sUDRkc0tKTmlwekVNSDM1dnZkKzBLaXlxQzFPMWQvTC9NK2UzY1E0?=
 =?utf-8?B?dmxFVG5tQmhQYVRRVzRWV21ma2hPRkhDblQxWjVhU1kvVHY2eXFCZVFOSWl1?=
 =?utf-8?B?YjVNTnRrSjA5MUt1UnYwSTNxN05ZNDlCc0ZVZWozOWF5dGVkYS85VitBOEVv?=
 =?utf-8?B?UHg5MXdHNGplRGdFUHRrQlRLYTZEQmlMSnY1YjR3UHZHQ2JUZGxudFNMNit0?=
 =?utf-8?B?Nnk3SG1ETm15dFZNQ0czSUhEek1ZSlRRdlpPSURRVUFJRmhqc0lQSWVoR0Zq?=
 =?utf-8?B?V2hxa0VrakZIS1kxRlZSQ0h3K0FZOXVuYWhqKytyRnZySUpxLzZ0VTMwRk05?=
 =?utf-8?B?N3VhYWNhRU1tSHFDeTl1L3BTK3hBQmZsbjdVQk8wQ1Rsd0FGWWNHS2xwa0l6?=
 =?utf-8?B?OFdMMzc3Q2JwY1VqektOTERrYURXUkc0c0ZUbjFrSzZKa281TnplZ1UwanJx?=
 =?utf-8?B?WFJRTFFLc0N4ZS9YNHNwN0d2ZzZvbDFWSUREM1ZzeExWK05Ia2k2UXZUcXla?=
 =?utf-8?B?cEZCeWdoaEVqaytzQUpMemJveW04eWdiR1lDeGVya2JBV2tDVk5hOUlQZjZI?=
 =?utf-8?B?UG9BMzlJd3NZRHdrUjRMa2s2ZUl1d29mNkZvYUt4OHFVcXZxUmRsc0RybFVn?=
 =?utf-8?B?eUl2dmYwdmhOVmFmaEJCVXRrcEI5OWhKR0hHNEtjZ3QyZzE3eEIzNzNRTTRB?=
 =?utf-8?B?ZTYwd2ZFcjRVSDN5YVlTNSt6Nlk3Ymg1RzFtV1BhVDVVaDFOUStFeVZKWXh0?=
 =?utf-8?B?M1ZtMXU2ekhnMEQzMWVYQ2FNTGdMZVQ5MU1seldsV2EzdmNZN0xWUTNzVXVM?=
 =?utf-8?B?VHYySFBIdHFkT0hjN25rdG9GOTFnYzdNNE1zVjVxWGZHdjA5akgzVjVkdTFs?=
 =?utf-8?B?WHNmQjR3U2FPQ2hPSWJwSzlFTWJVUUJsTEVZMWYzMVBmU0E9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10037
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	adfa325c-c0bd-4849-b4ef-08ddb7e81272
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|36860700013|376014|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUp4ZngyVmptV2NwdGJVeUdjZVB2Q252dGJjR3I4ZWpQVlVNZXhLeHJZT2pq?=
 =?utf-8?B?WUhhcFp6dlZUTHpOMVBBTGlCaTNwR2VFczRwTWhLOC9ZNStnN2Qyc3VZVEZ6?=
 =?utf-8?B?R3k2T1Y3NnZWc2tnWGxXMGM2WWZQdGY3cVFMVWtQamx0c0tyMFBRaVY5RUJz?=
 =?utf-8?B?b0JRQ3Mvb0pxMlZBOXg0a0YwY1dLcEpOM2QzN0RiaTBDUzVBYXYrelljaGg5?=
 =?utf-8?B?LzczN3VsL2NTMTFJR013eEhUS0krdkw0WlppMmt6RDVUQVZTYlJwWE84Wklv?=
 =?utf-8?B?Q2p6RGdrbHpxeHNBVW4wOTU4UmpGaDNTS0lMNXlwWGVmQVJXZmd1VFZZR0xK?=
 =?utf-8?B?UklqOHFGTi9XV2xYTGNnSUxzRk5ZM2JCdVIwcVQxdSttZHpRaWx5MGpvdXY2?=
 =?utf-8?B?L2lqNjlpNjUxeXdpeDZ6ajNycTByODluOVJiNHBvMGRqOUZrbDRYcnNjaFJu?=
 =?utf-8?B?UUNjL2dSc01yRmVFNk14clZXeGNYYU9ZdnBuMnJMNTBSRWJDb0F1NjZIeFBB?=
 =?utf-8?B?SDk3OWpGQmU2bVU2dHAxMHNNZU85Szd5WmhtK0F4L1RCdERSbktSRUNuZVhC?=
 =?utf-8?B?YVpxcU8yZXVrZVUxR1ZLNm9QZDZYcDBoUWEwMkxoZ3IrQTAzZWh6THkyTEtC?=
 =?utf-8?B?VjJYcnpyMzErV1ZqeVVDQTBwY25zU21YZXlsbWVhVkQ3VFU5WkF0eDJXdnRx?=
 =?utf-8?B?MEZES3g0Q21Wck9SOTVqOThsemFzdmJqNm1lc01tMTdpcEhxNDY4VkdLZjEr?=
 =?utf-8?B?QUdCcGUwTFlZcUlKOVZHS2Q5VzEvRkhReHFvcHJPakN5a29iOWRrdE13SUxz?=
 =?utf-8?B?WlU2aGdwNnRvNWpjQm9kdklsZXhsemhxNm1XYlBLaWJIY0ZQYldtbG0zU2Ur?=
 =?utf-8?B?OGpsWTFVc0ErRzQyY2R2NzNZbXI4RytXVm5SNHcrWDY0eXB0SHBFZ3V3b0ht?=
 =?utf-8?B?L28zbFBJUk1CR3puNHkzRjhPbU1LR3p2bXJPeTB4YzdPOWUzb3hCbnFadER3?=
 =?utf-8?B?ZHJrUE9UMzdNQ3VTNzMyWlJPNUtUVXdEc2dybnA1QVNNaHlYM0c3SWhmSVVD?=
 =?utf-8?B?YVY4Z1U0c2c3TjVBR0x1V2pWeU0vS3dmNlJFOGdKS2s3a0FvK1MwNmpKMmNB?=
 =?utf-8?B?ZE9zcmllMmJiTHRodTNrL2ZJcmp6d3JDR0JndHRBbnRmeVZ3V0Zoa0xZVU4r?=
 =?utf-8?B?ZTZGVmJ0V1crRDIxMVJYSmxjVkRDWUpsSHM4d0VPT3BsR3lFSkY5ZE5ySlNx?=
 =?utf-8?B?cnpSN2grcGQ2OW82VzhEa0xkb2IweGx0dTQrNUp3WXB3d3ZzbVFUK09pQzVV?=
 =?utf-8?B?QTlqRStPTkhVQytpaVBoeUNvUnZzM2lqZ2dDTndGMEtGclNBUXRldGZteXR4?=
 =?utf-8?B?UXBVb1NwejRtZDhYbXlyY2RuRlk3Sk9LZ21qWGlzZWRxWVhLRU90aHU0dHVR?=
 =?utf-8?B?TGk2MzUycGdjTEp1WjgvcjJXUndoUEgrcmV1Q3dNdnFiODVER1BHOEZsYXZp?=
 =?utf-8?B?RndwNkwyOWVEcGN6VTBWL1Rud3ROUzlSdTQrVmJCUHhrZy9hNkhQZjgwdzUx?=
 =?utf-8?B?MDlzOENERUU4dlF6QmpnamcvcVMwbHpjaEZadXpHSjh4M0MzZTEzcmcvWUdS?=
 =?utf-8?B?YzdGWTVnT0I0a3dmb05NdDNWNUhNUno3L2NCZUdlZTBqbXFoK1huSlloa0d3?=
 =?utf-8?B?aW91SHl0aWpocVlaNkVCOWI3LzlFUDhUQVY4MmJoc2tQQ1hxWnpHTnA4TW5U?=
 =?utf-8?B?UGFsNGJaR3pHVE93Nk5QQlJaNmZJaDVoTWdTVk44Rk1GK2VwTEU1ZDhsTmdn?=
 =?utf-8?B?Z2xrMjB6bEU1eTZwRDZDb3ZnZ0dRMXcvTlJvd0xhTUQvWGEyTmZLdm5kV2s2?=
 =?utf-8?B?UEZlblJ6enBuVHBRcWxMVDFIYURXcGV0YVVjK0RlQUdjSm5Oa1VmbzJrVU1E?=
 =?utf-8?B?NVpyWG9HMW84d29QaityRTlDdmhZMmxmbnc2VVNkMHMyK2Q4MHQrSkNzZWFI?=
 =?utf-8?B?RHRVS0UwdE85MG5Yd1I5Z2FKcW9NMjdZekljNmhGWFpVbExDK29EanpMOS85?=
 =?utf-8?Q?OzAcVv?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(36860700013)(376014)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:09:45.3021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93cbc9f-4765-4f26-e637-08ddb7e825fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5638


On 30/06/25 8:49 am, Sasha Levin wrote:
> When handling non-swap entries in move_pages_pte(), the error handling
> for entries that are NOT migration entries fails to unmap the page table
> entries before jumping to the error handling label.
>
> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
> corrupted.
>
> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>    Call trace:
>      kunmap_local_indexed from move_pages+0x964/0x19f4
>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>
> The issue was introduced with the UFFDIO_MOVE feature but became more
> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
> path more commonly executed during userfaultfd operations.
>
> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
> paths before jumping to the error handling label, not just for migration
> entries.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   mm/userfaultfd.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8253978ee0fb1..7c298e9cbc18f 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>   
>   		entry = pte_to_swp_entry(orig_src_pte);
>   		if (non_swap_entry(entry)) {
> +			pte_unmap(src_pte);
> +			pte_unmap(dst_pte);
> +			src_pte = dst_pte = NULL;
>   			if (is_migration_entry(entry)) {
> -				pte_unmap(src_pte);
> -				pte_unmap(dst_pte);
> -				src_pte = dst_pte = NULL;
>   				migration_entry_wait(mm, src_pmd, src_addr);
>   				err = -EAGAIN;
> -			} else
> +			} else {
>   				err = -EFAULT;
> +			}
>   			goto out;

Won't the out label take care of the unmapping? I think CONFIG_HIGHPTE
is involved in the explanation.

>   		}
>   

