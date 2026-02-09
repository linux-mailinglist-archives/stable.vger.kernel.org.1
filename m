Return-Path: <stable+bounces-215515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLELFroEimluFQAAu9opvQ
	(envelope-from <stable+bounces-215515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:00:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7711245B
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F6C33015D3F
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3283806A1;
	Mon,  9 Feb 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0nxqloO"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BA3803FB;
	Mon,  9 Feb 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652812; cv=fail; b=iOU7WJjvFa+GM0pqCLMYPRPc7xVNwvkA6+RSKIcIWGOZEbtcvKxJfIQy1Dk3KtSN6u/uI6lBXhoGQp+adq1aoeNHzGHF30fBeKjwNVOBe3Hz1IZOReyLLltBcrtgnQleE8WDZjrGf8Q2oHRSLt/OgFlBQ86gLxz/JqNNb3HK3EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652812; c=relaxed/simple;
	bh=ACe4XYyo/yXAku3eB2TVCIu/Ou9DVM6i9hVhnetYIYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ct5STNPKJZmu4PsoWHFsyF45kiqn+QmsJ6HFyUqLhj8NhmAAMfwB55B9r5HzK4nTsiQblascknu0Pich7eTdkruAOf6AKbVrivnR4fpnUknhQOKFYpvjW7r98bcyosMBikPw632/tWBCFQVXJHUADHqUoYgaketNOopLh6KRGnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0nxqloO; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmEqsG2tSX9shCa2X4obHuLgVtKJbtyBjUm9xM8Jn3oH3rEAgB9o7Wx9WcWDcGP4YuaoGBrTNscvbfMUs1S/weSFxwCDF/Mzhut7Qb/pKoAIRi5bmZ7UwMiu7UgZfNaeToFQa94MKg6W3OZ8uZRadGa29l98YFF2py7gQbKhd2iYvByil9e4GNaCt7Zsf1iEITaPklyfOncPRSPWWGaO4/uNpZcP3pnHxZpcucHtkmX6WAWkTFSFb3HaiHUtHIQ5BmCXqv+LaKnd33sklhh5ig8jP52XBc/OwC1OdBvXkr77ccR6B84lgv34YFsOrYNJ8f9r8GwTzLuPthlSl56Dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACe4XYyo/yXAku3eB2TVCIu/Ou9DVM6i9hVhnetYIYQ=;
 b=zQGoeBYj3ux1c2IjAGilmU9u5xk+ENTNIG6RmhqdKwwiroXR9ShcgnRRZ0cVL6sPeRZLRXP0yZSmd/aEeDVFO8r1e4i0+06+7plxNVPXquLLpxdVT17mGs8avH1UPO7qGsu8+Qt6ZUgsGNEXEyEyMX5hM18GaEkQAg/R+9OcSw3VYqncT5I0k9SY53sKYm059jUhnA+5wdnyFkT75d8m1EkZ/QkauGe3kZQDmfk30lxbDCyAm0FZ5zxtadi592GmFtAv7QjkstbhB/bH5hl90tcND2QZAKT+R6W/m6u/N5/p8nTSiYoGxkWZ06rGzr2GxvEi0p5TcL12v5NmHyH2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACe4XYyo/yXAku3eB2TVCIu/Ou9DVM6i9hVhnetYIYQ=;
 b=E0nxqloOHiKVkg27rNRdBf1Vi1/WL49+u7p2/+BH1Lj2RstIiOeyMRvF5TPpTTC3yFbPL6u5bE3XoXW1aeoatxVDofXUrA/U34HiKwse64Hagi6JscLghn1amsEoeZDX7So1JAIgBK0km/gV5k42lEVdWP1ICta6k5yNQDVMq9D9JYmcsIlIq28DYLxuBilt3SVl5/VIhDm5bxkEhxtJIhY4FmM9/Zt8bk6Yvtw2aw5dCW5/DjnQJIZLwaTcWufNKWFkHhvDVmsDldzOiHQjSruFKjT1t21BuMI7HOy9SDQ+nYPhzpcAUegRMJnLdalPhMsdF5BokgVwoQVC8jK0hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 16:00:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:00:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hughd@google.com,
 chrisl@kernel.org, ryncsn@gmail.com, stable@vger.kernel.org,
 willy@infradead.org
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
Date: Mon, 09 Feb 2026 11:00:00 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <FD637A2F-909C-4039-BEE2-B60F85FEC7E8@nvidia.com>
In-Reply-To: <c0b93b3f-bc4f-42f6-8287-72d015a0a79b@kernel.org>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <51f96b31-fb59-4cda-9d33-e3cebc45686b@kernel.org>
 <a38fb457-c0e8-4089-a31a-ac59d06a796f@suse.cz>
 <c0b93b3f-bc4f-42f6-8287-72d015a0a79b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: f323c48e-69a5-4a83-b718-08de67f44b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXpucmVlY2RqSWVnZ3BEWnV4b0ZXQTFDb0I5akpRVWkvQUkyUzdaSURCVHQx?=
 =?utf-8?B?cFlaRGpBN1FucEU2bm1JcCtQOVJOUzJyZFRHR1dBYnRrV1JHNUh0SG9rTmdR?=
 =?utf-8?B?Y3lHVU1pMEpobGJCNnhjdlZ3WjAwbFJ0M3NZNlpLSUM3WTB1MTI3cjVReEVZ?=
 =?utf-8?B?YlRKakFRNElESnR2Nm5EdkczUDdoUkZJLzF3d1NEVEMyOUlabDNwYTdvZ3ky?=
 =?utf-8?B?bHk4d1VFcE51aytEMVZPTit0a25jVERuV1pDQ29hSktUaWtkYUtWVHVzUWVF?=
 =?utf-8?B?NzNDWUQ2dW9ZV0JOb000a3VnaEdlZlBCSGhBVlhmVGJRcWVBUzgxdHg4blhB?=
 =?utf-8?B?aFBsenhKdENjcHZVVlIyaHI5V1k5Q2kxSTd4anZ1OEJHYTRqWGJtVm5zaGUr?=
 =?utf-8?B?SnRhaG44eTlaa1hSaU55K05UNmJwMVBIb2F5SUorWkMxOCtjcGUxaWRQVTIr?=
 =?utf-8?B?ZUVOemE3L0Zlb2pSeTR2dHppazdCQkZRSVEvVFdMVXd4VEVQMmpKUHZ4NVBB?=
 =?utf-8?B?Mm9mQ2NvTXpNcGFieHZUM3NlWVduUW9adnFBZ1R3Tks5cWh1dnpFQVg1Q3dp?=
 =?utf-8?B?SGRkRE55cjdqQkp5YVROcms1d05iY3c5N3I1WFNoTnVJWlNnd1U1ODE0dEJq?=
 =?utf-8?B?b0MxZUJzSnFycDRuNWJjSGZXYzhRcC9HZWpQZlpjWXhtVFhwS1RpdGdxK29M?=
 =?utf-8?B?dndTTk40dXAzdGdOZGx5NFJTZzBhYlYxeUxUMXhPS096SUNXSnFnWE5aeG1R?=
 =?utf-8?B?WnlmSmV6ZzVFQ01iNEphaEJLeE1HeUlnU2VsWXdHTXNhaytJTzJYTTZPNFMz?=
 =?utf-8?B?VGt4OXVLd0tHTHIvN3dyYU9FRWVMODBNN29LUGNmdk5JSEpkTjE3T2Nhblk0?=
 =?utf-8?B?eWVFNFJMclBJOUhMSkVCMUxCMkJLMWRLMTF6Z0dZMFNQT2xqWjBnY1JyTmhH?=
 =?utf-8?B?enFwdmV1WCt4WVRJakg5UldUMzlka0wyK2pZczBRQmVCQjF0S1kyOWhoTE9T?=
 =?utf-8?B?Z3Z6YjhWOHhlR2orQUhxbDhKVHlZQURyWVdnKys4TEJQMGZvd1hoeng3a0t4?=
 =?utf-8?B?bjN3WTdUeGpvcXZHcTFaODN5dTFkb1pZUks4QXBJMERRejk0NUJGNmpUYjN0?=
 =?utf-8?B?dGk0cjZROVZ1SjBTSldabFd0VmFHb1ZIRFhoZXN4Q0YwNGtlKzhVbHJRSjR3?=
 =?utf-8?B?Zk5CNTlzWTBxUmI0czRGS1pjUnUzVnVqeXNGVThwOXZVb0h3SGRISHhKNENp?=
 =?utf-8?B?Wnh6bFlrQ3c3eUFKRk9rS2Qxc0kwRUVUdE0zWFhibjR1RWlJM2ZIV1BISy9K?=
 =?utf-8?B?Ni9GYjlQNzhtZFZWKy9rYW9HcHpobDF1WVg2THd6QVlqanE1bkJEU3V2eW5t?=
 =?utf-8?B?dkFkVys0MWY1bU14eHgvMlh6MCt0K1lVMk5Wd1dZanorQjRGb1FsSUtia2xV?=
 =?utf-8?B?dGw5TkRLaE42Q2N4bmI4Tm9PRnFqODFicGgrbDlxQm90V2o0WnpmeGJ6NTR0?=
 =?utf-8?B?cWgzazh2Z05IeUZBcjZmVk1GZG4zemNrSWx0OERvdXl2cW9LMjhoUW1uWTVn?=
 =?utf-8?B?bVZpUmZ0UHNJWXZJR29RWHlGc1dsRWRJSXppdDFwUEtJTzROZ2JST3BzTDJ5?=
 =?utf-8?B?ZnllbkZ1ME9IRWtHdXJzRkdZbEJ2bFhnNC85OFhPNUZoRXQwT21tSnBaU2R4?=
 =?utf-8?B?V2VOYWF5bXIwQlQxaUlZb0xPVm5KbkdsYy9YQ3UzMXQ4QktmcjNxamFWaU5u?=
 =?utf-8?B?ZGxQYy9ad2kydThzelFlUjhadlhrM1NSNWw0NzdQSzZwQ2ZPTDNFcWVramZu?=
 =?utf-8?B?SzN6Q1pEbld0US9XSWYyTTIvL0FVaVBKblNyekt5MG5ZNkR6NndBT1kzdWl1?=
 =?utf-8?B?VHg1SnZnWUtXL210eHV6QjBXdDhmbjE5RlhKMjZyeFdpd2l6dEE4TDNMNFFt?=
 =?utf-8?B?dFNjaXBma0swdTNXdGh1L2RwSGowbjN0RU5vV0ptVm51Q3N2eXYwejExa3ds?=
 =?utf-8?B?cjZyM3BYV3ZhQVdUaDY2Z2JOV3pZR3pxSXVSYlFhN2dtYldwSFd4V1hibjEy?=
 =?utf-8?B?U29nKzdySTU1WXowOGt0UnFwTWxibXBESHdCVVNNbnY3QTdnaWE5RGY5T2NY?=
 =?utf-8?Q?qM6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGc5bFdNdDFyQmV1VVRrcVVGOXFJUUhTMWkySmxxSEVPUmhCYlFBNlZHQmxL?=
 =?utf-8?B?TlgxK2ZQUUNFLzMyamNZT3oyanFrOUtpbEZ6M2YrRXIxNUNodTlLZENycHdo?=
 =?utf-8?B?VVZTK29JY1VhNzJjNHdVWStkS1RDM0g0UllJc3lwWlBJalpLaGNMblRzNGE2?=
 =?utf-8?B?allBWE04WEd4b3VTZGp5QmgwSnlkaDR2QldOaGp4bVBMU2tOZDlZOFQxZVpW?=
 =?utf-8?B?a05KdEF1Q29rRVJaZ3RVNWtNRGhOVGs0aHZVaTJZTjlHZ09hM0xucDFaS1lt?=
 =?utf-8?B?Wmk0QjlKaDZtRWlkaVFMOEtMYm9UdkM5bnpBRzJNVEluSXNKUThnQWdpb25J?=
 =?utf-8?B?WFpGdEcrNTlCTHpIMW5VaGp0VXRTWnY5Q0ZsclRQbUFFMm5vMkVrSHFmWGpQ?=
 =?utf-8?B?VkFORkFVYm5rWkhXZ05CSytyRVY0NHRSb3J6U3FaOU0zMmgrSWZGd251djJx?=
 =?utf-8?B?RFdzZUJ3UHM4bVQvSC9ZK0xscHNXUDE4UC9SblFDNzRPMk9JS3poaUpXWXhs?=
 =?utf-8?B?MDBtdGZtRVB5LzUwWUNBNUMzN3NiTlZzdndSVlFRZjkyNFBPYkpNUHZydkxo?=
 =?utf-8?B?QW1iS0pYOUNBKy9jck5UM29hRGhPcnM3M0Vmd2hhZSt1Ni9YNkRENUNZYUg4?=
 =?utf-8?B?cEo4WVU0aGpFblNQRVQwZ0FhOFM3WThHZGxNOWo5ZnJpRlkwRmVPOHNTMU9O?=
 =?utf-8?B?V1VEUlc4eHQxTm9CcHF0cnJDUTFZQXZieXF1Qm5Jdnkzb3poNEZGc0V1US9v?=
 =?utf-8?B?YkJlMTZoc29SSjlLVWpld045Tnc5bkt6bG1QQU4xZGQ2clc1SXZIcjBBcm8v?=
 =?utf-8?B?VERmS1M0T0k1Z1VWSlUvazY0V3JDU2xrdUFiQmM0OFkxWHlMdldNZ3QxWjI4?=
 =?utf-8?B?aUdnY0xFOHJ6RllhVFplcGs0Zy9UbEZSdDd4ZC9EYkhsMnJKQ09Bb2F6R3p0?=
 =?utf-8?B?c2pSYXgrckF1bjVHVkZIcXUzdDVRTlljUkhEanpTN2Y4SjAyLzkvMThhNHJr?=
 =?utf-8?B?THNDVnJjWVo3bThQUWVDaDdLOHd0Y0JycXV4MitOQ2taQzByTXJYM0JCNVpP?=
 =?utf-8?B?a2FETENKeVAwSllzZ3BYV3E2c0NiOGQzOXR0eTFnVE1PVmtvd2lPVmxrNy82?=
 =?utf-8?B?QThmcGFqLzc0YjZyU2UvR0w2Z3h1MXNyaEZadVhlTS9oakxzb3Y0RSs3Tjdp?=
 =?utf-8?B?YktWamtIaSszSWRqT1ppeWxYRERpMWtmQzlxTUsyNmszNW9VdVgrb3FaVFlC?=
 =?utf-8?B?S3l3TlRnWjBBNlNrWTBqQ24wM2RXa3U5T2tacUczSDZ3VHBTWDdUdDJmNzdO?=
 =?utf-8?B?VFErMWxsa1F6TlY4SjlHelBVZzNNYTVLbExTQURMdG95TFYvWVNuQnQrRFFK?=
 =?utf-8?B?c2VBaGhNQzFVd1NjMTdQeFdxdmdjYjAwSVJBeTdwcjFacy9xVFVVZ0doVjlL?=
 =?utf-8?B?ZmhKeWlwR2hiNTJLTW5ST2JRN0xtTjJObXMrWEVhcDBodlI3L0VRUlVTbi9T?=
 =?utf-8?B?NXFqSzZ0Q3V6TnRzRDV6Z0Z6d3phZWxnRExrSExZS1JpaDMxL3M3QzdWQ2Mv?=
 =?utf-8?B?TERkNUdkbUs0QUlPaDNuSlRUQWQyR3VYM3N0MEpjYllTSmpyQ3V3WTg5dW12?=
 =?utf-8?B?VjZUckY4SW5LWkZ4Qys0YjNPaE0wOVp1Q3BydmRBZjR0KzRlNzZ0ekozYlpX?=
 =?utf-8?B?RStDVkVGNnM5bzV0OGFTVkZ1azNTVGowSnFLMFRqSmFObFJKMDZpVS9lM1Vu?=
 =?utf-8?B?dDN1NHl0SE14RHZWTFltN2kxdWV2UU5TRkZMeUZhejJzMHYzMGMrc2NqZnV3?=
 =?utf-8?B?azNaczEvZHFYWFEwbms3dEJ2OXZEbzY0VkxoMWRKYXdGS1NsdTI3elpVWUl5?=
 =?utf-8?B?RjFRcHFCaUM3N0Nqa2pSUG4rRlY4a0dhWkZtZngvNGpPTklWWWYvVkpsYzdS?=
 =?utf-8?B?SXdSNnozSWJHVzB4ODBDVnZseStMQzhiQ2VNbEgxVGxJOWE0VnpkTG9MNkFm?=
 =?utf-8?B?RTJrV2JYNFBGWkdUS0tnRStHRmVDbnpBbWRuUW1obi9CQ3dUTDZxRnIxTlk5?=
 =?utf-8?B?eWRCcTFzU3YrNGZpa3N6NzZjaldEcDI3VFNKTC96ZFhDLzg4NXN0U2MxSmFS?=
 =?utf-8?B?d0tQZ3Q5TnNPNVpKQ0J6NkNNcVRQVFlqbS8veUFtMDArK2NmMFVtdGczUFdN?=
 =?utf-8?B?aVRIaVlMUHhmbDNTSmhUdGlwclZMT01Sc091UVZ2d0NUTTI0aFZwNUxxYkF6?=
 =?utf-8?B?V3RnamlmUzROSDBvN09lR0FvNXR1QzFEMkNlT1NMZVFtRTAyUFIva3ExdHJz?=
 =?utf-8?Q?mJB+UusmNOPs7c/MFG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f323c48e-69a5-4a83-b718-08de67f44b0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:00:06.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uZaoYTuc9R9GlXUZ9Ycpxte8fXt1CfWDPV+mHgTqW1OfJLRt6jNQZaJjTqN+R+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215515-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[Nvidia.com:query timed out];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kvack.org,linux-foundation.org,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0AF7711245B
X-Rspamd-Action: no action

T24gOSBGZWIgMjAyNiwgYXQgMTA6NDYsIERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIHdyb3RlOgoK
PiBPbiAyLzkvMjYgMTI6MTcsIFZsYXN0aW1pbCBCYWJrYSB3cm90ZToKPj4gT24gMi83LzI2IDIz
OjA4LCBEYXZpZCBIaWxkZW5icmFuZCAoQXJtKSB3cm90ZToKPj4+Pgo+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIHBhZ2UtPnByaXZhdGUgc2hvdWxkIG5vdCBiZSBzZXQgaW4gdGFpbCBwYWdlcy4gRml4IHVw
Cj4+Pj4gYW5kIHdhcm4gb25jZQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBpZiBwcml2YXRlIGlzIHVuZXhwZWN0ZWRseSBzZXQuCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqLwo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh1
bmxpa2VseShuZXdfZm9saW8tPnByaXZhdGUpKSB7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZNX1dBUk5fT05fT05DRV9QQUdFKHRydWUsIG5ld19o
ZWFkKTsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bmV3X2ZvbGlvLT5wcml2YXRlID0gTlVMTDsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4+Pgo+Pj4gQlRXLCBJIHdvbmRlciB3aGV0aGVyIHdlIHNob3VsZCBicmluZyB0aGF0
IGNoZWNrIGJhY2sgZm9yIG5vbi1kZXZpY2UgZm9saW9zLgo+Pgo+PiBJZiB0aGUgcnVsZSBpcyBu
b3cgdGhhdCB3aGVuIHVwb24gZnJlZWluZyBpbiBmcmVlX3BhZ2VzX3ByZXBhcmUoKSB3ZSBjbGVh
cgo+PiBwcml2YXRlIGluIHRoZSBoZWFkIHBhZ2UgYW5kIG5vdCB0YWlsIHBhZ2VzICh3aGVyZSB3
ZSBleHBlY3QgdGhlIG93bmVyIG9mCj4+IHRoZSBwYWdlIHRvIGRvIGl0KSwgbWF5YmUgdGhhdCBj
aGVjayBmb3IgdGFpbCBwYWdlcyBzaG91bGQgYmUgZG9uZSBpbiB0aGUKPj4gaXNfY2hlY2tfcGFn
ZXNfZW5hYmxlZCgpIHBhcnQgb2YgZnJlZV9wYWdlc19wcmVwYXJlKCkuCj4+Cj4+IE9yIHNob3Vs
ZCB0aGUgY2hlY2sgYmUgYWxzbyBpbiB0aGUgc3BsaXQgcGF0aCBiZWNhdXNlIHNvbWVib2R5IGNh
biBzZXQgYQo+PiB0YWlsIHByaXZhdGUgYmV0d2VlbiBhbGxvY2F0aW9uIGFuZCBzcGxpdD8gKGFu
ZCBub3QganVzdCBpbmhlcml0IGl0IGZyb20gYQo+PiBwcmV2aW91cyBhbGxvY2F0aW9uIHRoYXQg
ZGlkbid0IGNsZWFyIGl0PykuCj4KPiBXZSByYW4gaW50byB0aGF0IGNoZWNrIGluIHRoZSBwYXN0
LCB3aGVuIGZvbGlvLT5YIG92ZXJsYXllZCBwYWdlLT5wcml2YXRlIGluIGEgdGFpbCwgYW5kIHdv
dWxkIGFjdHVhbGx5IGhhdmUgdG8gYmUgemVyb2VkIG91dC4KCkN1cnJlbnRseSwgX21tX2lkIChf
bW1faWRzKSBvdmVybGFwcyB3aXRoIHBhZ2UtPnByaXZhdGUuIEF0IHNwbGl0IHRpbWUsCml0IHNo
b3VsZCBiZSBNTV9JRF9EVU1NWSAoMCksIHNvIHBhZ2UtPnByaXZhdGUgc2hvdWxkIGJlIDAgYWxs
IHRpbWUuCgo+Cj4gU28gaXQgc2hvdWxkIGJlIHBhcnQgb2YgdGhpcyBzcGxpdHRpbmcgY29kZSBJ
IHRoaW5rLgoKSXQgaXMgc3RpbGwgYmV0dGVyIHRvIGhhdmUgdGhlIGNoZWNrIGFuZCBmaXggaW4g
cGxhY2UuIFdoeSBkbyB3ZSB3YW50IHRvCnNraXAgZGV2aWNlIHByaXZhdGUgZm9saW8/CgoKQmVz
dCBSZWdhcmRzLApZYW4sIFppCg==

