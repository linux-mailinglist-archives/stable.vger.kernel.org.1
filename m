Return-Path: <stable+bounces-215551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I6zHrc4imkeIgAAu9opvQ
	(envelope-from <stable+bounces-215551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:42:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4A114335
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B690F301CDAF
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B2425CE6;
	Mon,  9 Feb 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKkC9yBW"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F838946B;
	Mon,  9 Feb 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666162; cv=fail; b=oWB5x2whFSuc2hD0JGDcNnylZB6/rEFExCnZSDsnqlt9+y/8TVECYB+jNX7HXnQH91Fvq5VIX3uSJn7L9/Omx7a9EQL9pHhYXFDkebqjp+4EA5V1Bh2sD2oSEzHF4EOy6DHt0FuXyK3A0MsnA1Ax7zctvLBKMQb7uKffTGwn3no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666162; c=relaxed/simple;
	bh=/qXTg91rdsejCAH5kPCX2hk58FjkkjMiJ951b8aHQHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SV7GHRqG393z09TV8xcCkxEKTUS6FUIbAtoJ+sDqVJcSqbbMFwFXv1hATPimA7SQ7m6j/h+eckEtGnn0Ua+HWmdAmyOW/fjBlTy73rADc2F2fqg1FL1jejkFeO/ntvr46iTmQtdn6te61GHygbdzHIT5d/o3l9a6qMIpHFPAkGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKkC9yBW; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICTjjuIbVIu/ppeF++mWyCEhoX3/hsqpxasJZw4qNIdDdtaVSGlvY/piumxpV5JTbMFedmJde/s22P5XGUj/JhUeUTBmoLfjT1TElB3R6/jTJtTly5BCvcKN/6wcciHYiXTSzpvT44c5HeFJ+HwT5BRLoJPCZ9PnBR/RpgnWmlkiu3IZBv4JaWnzWeb37PkjBPCLUdn9f0jeb0DylQPea5O0QvuMIRq085Ix5qeOaDwikheBO2PIiZT2lbURph0XKHmyk8o7ZGTLGnaX1YCPn/xXdN/WfidrV190KsFAyO3RyHjf4Ss/9JpN8FOO//vW54wIiGhuIinwo48f3JUqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qXTg91rdsejCAH5kPCX2hk58FjkkjMiJ951b8aHQHU=;
 b=aRq7kmmyvBdW4vwSbxcz+Xl7k7rn694p8U/Odbqn6U0jVNzibmlB5Lgb9frEoYVmC/lhvXlwHQlcvBuq8kwkA0I0KzKB+4B2jLzEw7iMuNKWiLyK3zjiHpA/Us0eI438qKLzHr5UkGhliYh3OnFxO0Sw5WBjBoWOAuTNZJJ2bw/fI6Sce6wWdpklK38THZb4T3pxTiNAHxIkXxxYzkgKw4w9/lfMr8avtFaagD4HgG+NFzLXZ9/j6FafhKCiEVzK0pRZrhHP/DojRrMLFSmL7+gzrd+eZ2yX2Cj2FS1O1u+nqQgIJrZzEIrQDjjQN9erjfY/HxOPK2PERm6g+D6CQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qXTg91rdsejCAH5kPCX2hk58FjkkjMiJ951b8aHQHU=;
 b=hKkC9yBWvr+tTDTWRW2Wkj1zuCIn7EtcmU0HHKZ1HZvvJsJr3EtueQc5AO+bGW+/5DuwScmJHbapYBzgNljqHrLYPUAC5GLEsSbMyiRW5XqduxapxcQXC5BzTSABWzm3winHvqUyF1bMbDm1//9uHM+pDVONmo3w2T/80KBuMvCQ3Dou1DGhAjufnPLL0oAs/zXM8xO/FIQUBElqQJUQocQ5J8SL8G9p5CwGf/pfnlYKylDRD1SB3Bs28OQpc0qPPLeJWALHQ5xfowsi/gbAn9v5VK+RMa0/vOZadMTx/Ex4/TMAVnD6ZhHZmhvMxGVZlp85pJHO0A6KlFfUcG2XAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Mon, 9 Feb 2026 19:42:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:42:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hughd@google.com,
 chrisl@kernel.org, ryncsn@gmail.com, stable@vger.kernel.org,
 willy@infradead.org
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
Date: Mon, 09 Feb 2026 14:42:28 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <72534BCC-2581-4BFA-B3BC-2CC6FF1B1E7A@nvidia.com>
In-Reply-To: <4a759288-baf9-4fe6-9d16-034edf6615f0@kernel.org>
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
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: d66b8352-1121-4b44-c2ee-08de68135f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TIpqGa2Ju1FuhCVGYkiJfbTS2TTcw42piriYyVw3Dxo+/Bbr2KqeuOqRntxa?=
 =?us-ascii?Q?EPziBtifFOS70TuM9FlaPojN48ySJVHIJoB653X2hlReSIIikS7YnzGTVyGK?=
 =?us-ascii?Q?YDyjz7JsFPxGLsCw6rijlFAcxnV19YNmPgxT5PPFJlT+w6mXQenkR1RycRwM?=
 =?us-ascii?Q?7o7Mxcig1Akg1NKPInC417zB5GDyuZhtuCudRvyLTyCq4Z7FBnp8yE0sktrp?=
 =?us-ascii?Q?cGu6PgJ3xIOUpE7oFrocMSJ3Q9DOYeoAIsebGWFlz6/DpvnNDjikwkJWSrla?=
 =?us-ascii?Q?PGCPXm44fxHxtsS794MEd1Zges657jk57URR33NW28do3W3W5DDdpFH8JpqI?=
 =?us-ascii?Q?68dr6llS6W31cXWrlCKww7Qtdck5QPGOA1Q+UDHl4F1IXmZMckFQzvKGCWVP?=
 =?us-ascii?Q?Lpt5AbdCj+pSLUGZ6MClntJwWl7Xtc4h63ptbcQMeEGRo/b6fX4o6r7n+9CA?=
 =?us-ascii?Q?2IdDiv+TJJaiuklE2eNEL9fO6iqU+n/P5/Gpce99BGKzP4wMF50x5hyctOde?=
 =?us-ascii?Q?23RI+71V5JSK7EUy/F2LCvzrMjNxzQmjNFY4rTlvVascvCOdQdAsPsDwSFnB?=
 =?us-ascii?Q?lT9+ySZecLBiQkc/eJu/lfHWC7yTy6R9HekcBvTu/xWLnFblRnSjzB/FZpc1?=
 =?us-ascii?Q?Bl8K0LsK2txk1hg0AoGdQ84ct2+dk83bB/JDR1E79qvKyGjwLqdW6xuZ+nub?=
 =?us-ascii?Q?utOTKxkjyH4MOukmUOurW8GrUMTKOssisjn/EIk8HioRxIdbn7MWWzc88JnK?=
 =?us-ascii?Q?3qDejiIFqiZiF8JCrfaElU+pbrzOg0L+xbluJdnXwGcVRy8mCPeiKGVUCZ5I?=
 =?us-ascii?Q?Pcdo1vTnVPFHOViVvNX0FEGSqKgjuBD2vBB1hipeK2huzu2/2rp6zNGgnnFQ?=
 =?us-ascii?Q?vuBGI8Gfu96+tLq0qLZYkS0x3L5P1v6qRPUyxHRH7e0hpvsWZxyKmJH54W8k?=
 =?us-ascii?Q?f7qlfbhOd7Xc81ru5GX21lN8Xnt6+r8Ii4Oba9AptqG7KycVAliqsA5kyLgt?=
 =?us-ascii?Q?Q8p/YyxUpMvsQkwiHK8zIqPpvzXukvMXuyoFHwtgQreGh/kfe0Rtvz/9C/Lf?=
 =?us-ascii?Q?h7xWidTBf7qthQrRf/7nCzi/bplzajppZpEo8Z9+4KZU6zxaCZeEVzs2FoLN?=
 =?us-ascii?Q?3/u+vm+lwqmkrt+BYvUxN07WAhoSAibgRqj2V9pujDIWfTTSWt1OtCfBWdTX?=
 =?us-ascii?Q?KRGEsWzntLGhSmaNghZepSTWLsJOnn8ST95jBYTIqSZw9/y8f/YUgdAq+0YL?=
 =?us-ascii?Q?9MWIdH0z6S4MXzsVupAEht7JONMI4BqmlioBUy0iZqU/zF06ZWm5lfIHMbMd?=
 =?us-ascii?Q?9j1n5Yw9Xm7Fw+pqxalBGHaF12wTM9VOcgh3kCs9m2egLVccnyCTweKKOxG+?=
 =?us-ascii?Q?QtiERJUu5+ragOuRgSyVM+YHfkOdNg5Keze0TlGdIl9DrS9ScoybsMOANXag?=
 =?us-ascii?Q?9Jz3y/xoHZpsZpkSXrjxes8Itgwv95FC1nD2B1/ZhYEVP5o3oW76M4Lergp4?=
 =?us-ascii?Q?Ihp/hiaIyRY26zMzPyxRDKQoUGv2QEn0urXLgpoDQgpCkfH45u6zWoSfqDRB?=
 =?us-ascii?Q?KJPb1vXvwM1GZ8jZFrU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vN7XFEUEFs/Q1yW6gtsCpR98QKsgeWLieCMuUg3vRt9BL/oxHC1xG7mqJT5g?=
 =?us-ascii?Q?y/Fkxwe7Ie5h5E2UyoU7neepwV2LL5nbRnUMPre2TiSbjr98hkd9nEjWJWCR?=
 =?us-ascii?Q?XgkZ3b4n9O48sNphqVEdRtIuf8N+54N8ewIVpqp6q0oq9zkpZfXe59yiLMMV?=
 =?us-ascii?Q?RvicyEBXHYlLKwgVXGPBlfYN0x2dc1ERpcI1J4EXR2EJtob6oIMR4uuug3kh?=
 =?us-ascii?Q?G/xrm1QCR4y9aJowUiyZuS7FJTM7uhgBmQpZeXmMeq8aXCj0WRh69T1QtNqC?=
 =?us-ascii?Q?UJSeWIvqJABv/+GEW89hVLMFwardThrTkfIgcTRrYlscZ7/FmFEkqqiwOfzJ?=
 =?us-ascii?Q?qd6yADGVgWsopj3VDSgfHFucnIPMPWnKgZEL85T//jJ8x3qrao2cN0ddHTSt?=
 =?us-ascii?Q?1kwRl0FErdw6sdidbSKgzkpgae1huB+4sQ448gxWPkEBRslLlEtSVS9YJFU3?=
 =?us-ascii?Q?SOgQ5xb3aZmhGgXK7CYddg5ZL3Jt+dWsl54JWlloYjT40cgd8rnMwnoM4/Vt?=
 =?us-ascii?Q?2LPhloQj16k9C473kPiWjzxARN6Sq3s21/SX274iaY4WI1HKy9pW5tC+nAeq?=
 =?us-ascii?Q?C2I7/m+QMy55zC/aLUrh7oyxVzksG6a3Epo9NE7AukNwrWXcDHl968e7JB+e?=
 =?us-ascii?Q?SQpOmSJVaLOl2frL1TmvIEbT4ix6dzV++FI2i/cRgOg75amm9c5aiP2pUoIt?=
 =?us-ascii?Q?E+mRCsNBC+6ZY9QSLp4/YxNInsgF8E15ikrQM2b1cKHT89POYV/CcGgGo87d?=
 =?us-ascii?Q?enxcuAc69C1yjLWPgHDrcYboZE5asAAiVGCH793rxKQ7fEp3opJC4q2vEh6v?=
 =?us-ascii?Q?QHsUf9jDrEPFbivcnpLZ3HVH2Iv45fmDgmjvYwmIv7Gmk3OdJ97Cgh9BVieR?=
 =?us-ascii?Q?Rkyh/8zuoKKJT38Ui5XlrNJ/Qm4XmB+M/Gu0DKjB8lkTivilNXcxmGYEm0WU?=
 =?us-ascii?Q?W5bpbjt9sVDUEaJyulC1+lb4TdSqYswLq7CgOd+rWiYA5GgmgdXe3uU0UnFE?=
 =?us-ascii?Q?PSDVLgMxkDgDxjzx7lfs8ATHVjXQIPu/1i2/JC+BiNJFuKM28IEMq+D45Pxh?=
 =?us-ascii?Q?e2NM6V8p/NobdhULdM8j2vqZJhPkZmUzZUKYhAWijYwvQTgUWLAXqrMGydMR?=
 =?us-ascii?Q?LAiV1vOCsF7IYwYq/HqX0cNNmkkbkeIhAdn/MsG5A4H+L1PuAluJqf7eDUUP?=
 =?us-ascii?Q?CgBLzmbvHv0sFKiFxDvBksKdAb9WIGIPz3KNp0+z9gRqaikMHFURi15HTgqi?=
 =?us-ascii?Q?/33X5WCe1I0uwVZv6UP1ubgcnBJ4Xd9if7eZ3cDMV7zD7dL6cbBJaQzC8h3h?=
 =?us-ascii?Q?FkuK460rvwcQui0Tu/rhwEZVwDS08Xn3s+XsHaV6jmMOi5CGlln1aiTcZeFj?=
 =?us-ascii?Q?WFOZCirq6WG7bOH3roTdtZJnxRkwKX7RfLFbpuLB3fGd60Rw2cUTDDYGSP9r?=
 =?us-ascii?Q?DpWkZ1zxes76IfMTvG8582avW6VYx6OBQ5qGnhf218sF5TrdSh3BeC/gKvp6?=
 =?us-ascii?Q?fb5C6Tdh6QUwFZv0KKrogOTqy3fopuyWW42rVp+VPSJdqpUYwdww6emQCCHN?=
 =?us-ascii?Q?Htf0NnnI6JEBgNXWBWahZSsCcqjfewwE7C3i57fVl8TDq8QH0WFXheZoHjad?=
 =?us-ascii?Q?ZzuTpJUGtPwmRMYoxt6wZIfX0q4bpzL80OktzonX+aryhXWFGHpuVxek/HCx?=
 =?us-ascii?Q?Ogzf29kC8bKtwyxYHMsvAkk2PAzxjMYsduo421spmRYjbS6i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66b8352-1121-4b44-c2ee-08de68135f9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:42:35.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyT0Mza6ilUTiZusrpKDVDVzCAjIQI3qkXd0j9d4SsF26n8zkzhrYEr7S6hTLZm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215551-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: EFB4A114335
X-Rspamd-Action: no action

On 9 Feb 2026, at 14:39, David Hildenbrand (Arm) wrote:

> On 2/9/26 18:44, Zi Yan wrote:
>> On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:
>>
>>> On 2/9/26 17:33, Zi Yan wrote:
>>>>
>>>>
>>>> I agree. Silently fixing non zero ->private just moves the work/responsibility
>>>> from users to core mm. They could do better. :)
>>>>
>>>> We can have a patch or multiple patches to fix users do not zero ->private
>>>> when freeing a page and add the patch below.
>>>
>>> Do we know roughly which ones don't zero it out?
>>
>> So far based on [1], I found:
>>
>> 1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (overlapping
>> with private);
>> 2. __free_slab() in mm/slub.c does not zero ->inuse, ->objects, ->frozen
>> (overlapping with private).
>>
>> Mikhail found ttm_pool_unmap_and_free() in drivers/gpu/drm/ttm/ttm_pool.c
>> does not zero ->private, which stores page order.
>>
>
> Looks doable then :) Should we take v3 as a quick fix to backport then?

Sounds good to me.

Best Regards,
Yan, Zi

