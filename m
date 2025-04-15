Return-Path: <stable+bounces-132760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B0A8A37E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858933B6807
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3151FDA9B;
	Tue, 15 Apr 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGL5E8x4"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75BEAF9;
	Tue, 15 Apr 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732684; cv=fail; b=gpqY1+DbbhJaFtwk9Q5syxCjsQOFRPpmYfXb0Prre59aJHaZ3TulhjsWArhxYDjbHNGvHFbDDBBH3vP54dt0+dCGbwme89cU5pjstjFpAjxtGFNb2t87bSvMc8AFLkJN00VxnyH/lAJkTIy6/GC+balHWCEYR2AJYp9NXWuoHIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732684; c=relaxed/simple;
	bh=sTzHMUXg9raO78/hOMWHcwShZSDaJQoTAWQeVuJgQ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkklLc3aiji8SP4PjnnzzmkmiP6YpeYfN8nRsxSW7vgk2+yCGmubWUpbkt2V7xYv6y1WQaucgFUmAaroTWMfPUVw805uBn+1Yhuy80vLoGeV7+Yd6AAEbk32Kfqy+6ZSevFoCy6JLam8UlWCQRybz9hEEnEiS2w86hxgnLOsTZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGL5E8x4; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3ISoCaT9blX2yLDmtF4sq+3EgSepZxf2AD8D583Z+vjcbuvYeMsCXBOqhzZkh1QYTGwOkkWxxgUJ7EBrrf/l2NunTXBLtmlldV/OQ0PfOJgP1ThmXUIceeR1ES/aSvaDsArSxgal71thA0RCB2m/DH7hg+mEU51sqEe2hn0kkncP8gFoGeRqjqnTtlxbYhQ6VgNLm4GVmi49edmxc0vCgdvQyF3JjReT0kGeqDJYN1Ge/PtdDDJTDI/bMzS7NMxObU4ufR8Uk0GcVKwPvdxgWfsynWWA+LyKK66e3mKl3i3mHdZMYtU+Si1LB6EWo3IKSZehpINXJPKIrzFLwe7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ntvbFgd9ezksVa6G8nawBI6wsOyuBLmeTnu6R4KNw=;
 b=yD4fj20a5Z+mWcrrgrLfFsVLWxM4RxFFETCLpMM+GQpB6I86tGcukWx/pv/hnpsLU1IDVOLyS+0PgYKg7IehxSf6D971RWxtmlYLkHo5BhijOI5L4Qc0Yl893JK2OjLArlDjYnESGrFCiDo1oepfuu0pGhhJpkS9nnnf/uP80Rd0+y8e1hYHn5eyZH0aNoS9HjcpZuoCaqTRN5cPVknzYUKixLYsoKeG41FGbO2gDDL9IBZTPjZNpW29yUqUSURWhO01YmtCkn4coCMIu5uF247ASB1FJsvhPGfr63menwLsor5utHGdHUPDo73Xy9k7Iehi8q8KNE9js7hvmv71/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ntvbFgd9ezksVa6G8nawBI6wsOyuBLmeTnu6R4KNw=;
 b=fGL5E8x4oTLiTtVi2w170Kx3AVKAZUaKu/J45FEbbCCmLA9o8+oRfJq1Sxou1hjjrt97ea+me1PGCp1f2bTiW6qZyNou2Z1DBB6nOsC718e9RLznFsQJv3RqHQX4Zvjbs4LIJRzFwnFBSvg1BUSG7goQYyShMEN+IHrIAwwxxfJCmbFaYQrJtQh32iMtkHkDd4NS9iWh+w5hjL8+y1hl1Myvg01YKYtD5udKXpqR7t5X+AuZmIvA6bZMGPq+hG0BUmYod7rsVObIP8P911BW6bBFNRh3trxmqa0mtLBULLwqj2MWNYqs2sDciXEOtSTZg8Mm7h7e9zjZLWCTflXBtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 15:57:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 15:57:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 linmiaohe@huawei.com, hughd@google.com, revest@google.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
Date: Tue, 15 Apr 2025 11:57:53 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <C055C822-0CE9-4455-9849-7242F31515EB@nvidia.com>
In-Reply-To: <83629774-981b-44cb-a106-d549f1a43db9@igalia.com>
References: <20250414072737.1698513-1-gavinguo@igalia.com>
 <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
 <83629774-981b-44cb-a106-d549f1a43db9@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::48) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e097ef-f5a3-4659-9e8b-08dd7c364aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWVOWGsyaENCOXBZOUYwQk1rWFNQS1Fadk1nQ091Y2pqblg2cXphdlgyY1ow?=
 =?utf-8?B?azBVN1JSelBReDZTdk0zSmtnTnNpUUdvdzhWUXhMd2thY2dtTHFwZkJRaWh1?=
 =?utf-8?B?QkxJaTNScUlqQ2h5MGZTR1VPTEFGdGlYS29sY1pmRVhSM0tNRmw0ZkVKTDZX?=
 =?utf-8?B?RWFKOEtGeTZLZDlxeTVCUUw4T1g2Q2ZDeHc3VFBDckZQY3puSWdTNDVaNFMw?=
 =?utf-8?B?ZzdxZjNleHp1ZXdZekRlUlVQaDB1bnl3QjVuZlZHOUVQYVB4N3crY2xmeWgv?=
 =?utf-8?B?SEFhZDlrbEpqZjhuYlE0R2lRZWJLYjJGMnB1bGFURUFFbkt6ZUh3WUxQVy93?=
 =?utf-8?B?RklwL0ZEWDAxcXorcjdYZ0tlRDByaTkxSW8rTVFqZS93OXdYSkdlMStUN2Fq?=
 =?utf-8?B?NWVReHZwc3U2ZWNxbnpOek4zNDN2N3I4QnlUZ0RLSUlOSHh3eXJ3UVhTWFZP?=
 =?utf-8?B?N0cvY0pFaVhtc0Fjb0laRXhJZzNtU2ZsT3o0TVlQQ3FLY05vSG9sanpZVGNQ?=
 =?utf-8?B?TlpwK3h6azd4cUlSNHE3dlE3T04rd3M1WVcwMUNwY0dqZ1JUaHNjRkpsNmto?=
 =?utf-8?B?MlZSeVpHQUxZRlAvL20yWEhBZFNxLzNDbmpBYi9KVG5ENzVyUytjRmNUSEQz?=
 =?utf-8?B?am1WRUhIeHRTVm8rM3o0ejREV0lPMkQ2aTZCYUhFTTZtWEpWR01RK0pVUm9n?=
 =?utf-8?B?R3JWYlVxZVFuZm50dGlQQnBDRDF1bTRDT05jODZhOG1ISHpxaUxhL1VNQjFu?=
 =?utf-8?B?eVBBSlA3dkdZU25Jei9LVThSSFp4QXFSVDR1aGU2bTByUkpDR3YvS1pEOFJu?=
 =?utf-8?B?V1F4UVRRQ3N1SlM3RS95a1dlaG1qekFRWDV2M2dxcHBPNjJrRnVvNHFIY2Y3?=
 =?utf-8?B?aUxPRE9iOEJBbVhGWHV5Q3dWQTB1WnlLMWl5R0VTS1F5QlorQlIxb2xCdHJH?=
 =?utf-8?B?T1lwaGtVRkllOHV3NEhzMVRIVEZIT0M1ME5aV2d1dDlBWXZKOVUrenRrRzR3?=
 =?utf-8?B?cG12ZjdUUFY4QzRsenVTWEM2bGlLTVZXWTJxSGpzMXpIQzRaZWw0dUwzTFMy?=
 =?utf-8?B?R245em5DRGhGaG12R2hqb1p6MUtONGxwbWJ0azFyN0tET0d3aUVnMnh6MnJo?=
 =?utf-8?B?RWxGV3RVcHQ5SXlRUExlb2hQVGg1a3pjU0xSV0VlWjVYZzRQVG91S0MzOTQ0?=
 =?utf-8?B?eUxlUzRQa3hjTUIwMTJneXBibHdWcFgycDdtMk5aZkVHNG5veGRIeTBUaU5C?=
 =?utf-8?B?WUNRd2dXQlJJNmVrbURGUE5veHM1eXNzeS8wM1cvTHVNbFU4dVNOS01zenI1?=
 =?utf-8?B?VTlVWm84YW1vQTN2UHo2WDljU0lRdHhpbnNJS0dwZlJmdE5JY1hhRHJsYzE5?=
 =?utf-8?B?SUxzOG84VHFvR1Z3dmJCUzVtWnZqZ3RWeHlpeWF5MGlZZWpSV0d3WTRKM3RK?=
 =?utf-8?B?Q2Jtb1hYL3dnaEVYbFcrTVluVDlTOUdRZ0hLWVFqWHZYL2UvT2FiQ1FGWEJo?=
 =?utf-8?B?UG9hOWxac0RoK04wR0VDMG53blNLbWJBb01CdkRCZWZuUXFYeHpFcjdDblRH?=
 =?utf-8?B?UDBqelVVRmhzV1J4VGE4TWc3K0NuZmtpVjkxOXFGZ2hzaE5zL0N1QUlQelhS?=
 =?utf-8?B?VVZmeW93anFIQ0JoUzdtQm5VQ1hhVEk0MTliMkhTTE9hNEZ5SG0zZnNnRnQ0?=
 =?utf-8?B?N3V6R0NVYmgxRml1ZDJSZy9XaGM2YU9Zb3JYekJtQ0M1aDdydXhLL2JpWHRJ?=
 =?utf-8?B?RkhHTEVyNzE2Mm1ldXQ2WVYyTlNsYlp4cTlIWFh3bmkwNk5iY2cwN1hQelFm?=
 =?utf-8?B?em85V252SzJtU2Q0R3ZSNWlPOGFPV0hJYlU5NVRaVTVoODhDRFd6aXBBYzJu?=
 =?utf-8?B?ZVUxMGc4MTY1d0pJejZLYXhEcWRzZjlzUUhZQXZ3LzMwbUNZYnB0WTdLR0pu?=
 =?utf-8?Q?C6cUDo3jlE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFJvTjE5MU9zS0hkWUF1Rm1PcENGZlg1V0JFdE1IOW1mS0NBeElZbkMwMUU1?=
 =?utf-8?B?dkxaekN6UnZMZGMzKytKUDBuUFEzWlVzNHhIQ2d5YTZuWmZZSXZGNVpDZXgy?=
 =?utf-8?B?RkZYaU5jTHM0MTFOQThQd3dzQys5R1JhdE1Cc1YwaEwzbmt6Q0N2MmdjcUN2?=
 =?utf-8?B?R3ViR2JwVndRUXZPKzRuUU1uK1NXNExjRERIdGRhYVNpaUI4TUY2WGxEc0pN?=
 =?utf-8?B?UkFERkcrMU5YV3F0c2srYzZYVDJkdUJ6YkJoTTN0eXBMWlBRR1VxUy80bStH?=
 =?utf-8?B?QnNXak9zWDZLbzAwWXo3L05yNXVJZzZ5cWg5OWxaY2ZiNEkxNXZMem1uOVl5?=
 =?utf-8?B?eCt2MWhjeFNnd3hQWkFuLzRBMXpxbnNuZ1lDNU5EY25IaDVUaEpuTE1WY2tK?=
 =?utf-8?B?a0N1UkFiek5KWFdvSXhzRTFvbGJFNnl0UHh6ajdRa2NwM0dFK0tabWg4MElF?=
 =?utf-8?B?VXR3anJ6SFJ6QXBVQ1hoeFl3WW03Q1dHWVpheFpkUkhqaU4waDJiK1d4cnk1?=
 =?utf-8?B?NVczK2lyYkRjSWhTenFtUU5ocTRKMFp5bkN3M1NCWmR4djduUFhIdGlRQjcx?=
 =?utf-8?B?bG9RMlNqZ1FwRDFlMVFwQ1dyQmV5Z09LZ1VlNkN6OFhaRkgxRlJqUXhpenRj?=
 =?utf-8?B?clVUM0dGVGdwNytUWDIvbTR1U1A0b0lLLytPZVFYS1FtZFJSaXNwOVd2QWlY?=
 =?utf-8?B?TUhTTTI1UUZvdjlsVXNrcUppTER0QWw3UnlBLzAxQVR2M2dvSVd5M0VJZS9B?=
 =?utf-8?B?NmlyYzQ4TzhJNStST2VxaTNiSlVYOG4wMk5HS2VjVE5yenpReHpPKzlJMzFt?=
 =?utf-8?B?UmpRT1R5VGJ0bmNOVWJSRXhoK3Nmc3VyVXdiMEZ6V2VmOHNJekd1MjdlUkQ3?=
 =?utf-8?B?Tml1Mm9nbTlidWVVbWdmYytWOXRwUDBsV3M2Uy9ZNGNKY25GdklQVng0ejdT?=
 =?utf-8?B?RzJEZWVIaEowSnJUOE1xSElqTFJ5UDR5c0ZnWE1UZ0xGNE5LNzNyZ245NkFs?=
 =?utf-8?B?WHVVYWwrcG81RVZCeVhLaWZ6MHZPaDBBb2tkc1JiWjF2Qzh5WkpkcEZLcWJX?=
 =?utf-8?B?OC9DV0ltNmlSbmRackc2K0pJeDJOemxxZXRRQ2xmb0EyV3FjekZZK0NvQk5p?=
 =?utf-8?B?K0VEbWRkN3hjbmp2TGxNVm13N0tIMTFqV1YzM2N6eTRqd1YrQ2JwQTdkSGJh?=
 =?utf-8?B?c29TamVHcjJXVU1MZy9TQjFHckxjT0RFZUJSWXFoWWVtZjR2OXdxRE9taklo?=
 =?utf-8?B?S2Q4elAxK0JNMUVlK3ZHa1dHaHhqQWRNOHBYaFRSdytOZ1cxRHduWlE2TGNU?=
 =?utf-8?B?SGswbjhQSzJXTzZoTTF3UU5lT1JnUnFTMHdnWnA2UzRnUHFwdVV5WVV1SjBY?=
 =?utf-8?B?eTduVVdtUFNUeHd6bXZYeTVtekd2V3FMN2hjWERIYWc4VFVLYzlaM0VxUjJF?=
 =?utf-8?B?UXJsMFAra1N3WjNiRnVDdENmNExwbE5RV2xyV0pCRi9Lb0FRWUR1Q245UnJD?=
 =?utf-8?B?SlRocG9NRHFEd3BWVUZjS0d2SHUxNW10ZHlxdklPdEdiZ1JESHJpZ21FTHYy?=
 =?utf-8?B?WndaclV0ODYvT1BEcFRCVEgvVGJhclRyVG5EQi95eUFLakNnNXZHbVFGRThp?=
 =?utf-8?B?MDhyRXRoV1hyV0xxN2lpcEc5VHFzdHg2R2h0c2J4VFFOaUp2RHYyNzdMOFRS?=
 =?utf-8?B?YVlGbENqb2pURjNNNXl2Q2Njd2J0VklrSUlLcUNObEFGTG0vMjlpOWw3UGZj?=
 =?utf-8?B?M3JaTU0vbW00aUdOSmo4VFNMVERZdlRTU1kxYzBaMGp3Y2pZb2FyMWZYU2dM?=
 =?utf-8?B?OWp3MHNIZ0RYMXlDempPd2VRV3FJengzZkNXamwvMHAwVS8ybkluWXFEdzFw?=
 =?utf-8?B?em9qa2FEdDlaQTBtNkRiNmduUkhPdFVabWJ5aURjVzZCRjRxc0thaDl6cWFr?=
 =?utf-8?B?T0ltaWJaR3F3akthWjJLcmkva3BoOEtiVzgzdXpwRUJaSDZ6bzNpRmNGNHRV?=
 =?utf-8?B?cERrQWt4RXg5VUFmenUzY2VXUGhEbWdWa2Q4NWZDTjRZc3JGOG80cE1VWUx1?=
 =?utf-8?B?T0I5NmhRRWUxOGl4dDdFWWMzVmxLUndUWTVaSzl0WS9kTUxiWENRa0l2aWZi?=
 =?utf-8?Q?8VXnF/6a/ofCGwesPVvw8sh2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e097ef-f5a3-4659-9e8b-08dd7c364aaf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:57:58.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRbJN4GGHUKbOeAV7K5pdLkOQUmhkfseOMHyJjLvbsnJbQxFcCt5tIoHrmlC1ZON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

On 15 Apr 2025, at 6:07, Gavin Guo wrote:

> Hi Zi-Yan,
>
> Thank you for the comment!
>
> On 4/15/25 00:50, Zi Yan wrote:
>> On 14 Apr 2025, at 3:27, Gavin Guo wrote:
>>
>>> When migrating a THP, concurrent access to the PMD migration entry
>>> during a deferred split scan can lead to a page fault, as illustrated
>>
>> It is an access violation, right? Because pmd_folio(*pmd_migration_entry=
)
>> does not return a folio address. Page fault made this sounded like not
>> a big issue.
>
> Right, pmd_folio(*pmd_migration_entry) is defined with the following
> macro:
>
> #define pmd_folio(pmd) page_folio(pmd_page(pmd))
>
> page_folio will eventually access compound_head:
>
> static __always_inline unsigned long _compound_head(const struct page *pa=
ge)
> {
>         unsigned long head =3D READ_ONCE(page->compound_head);
>         ...
> }
>
> However, given the invalid access address starting with 0xffffea
> (ffffea60001db008) which is the base address of the struct page. It
> indicates that the page address calculated from pmd_page is invalid
> during the THP migration where the pmd migration entry has been set up
> in set_pmd_migration_entry, for example:

Exactly. Maybe I was not clear. I just want you to update your git commit
log to say =E2=80=9C=E2=80=A6 can lead to an invalid address access=E2=80=
=9D instead of =E2=80=9Cpage fault=E2=80=9D.

>
> do_mbind
>   migrate_pages
>     migrate_pages_sync
>       migration_pages_batch
>         migrate_folio_unmap
>           try_to_migrate
>             try_to_migrate_one
>               rmap_walk_anon
>                 set_pmd_migration_entry
>                   set_pmd_at
>
>>
>>> below. To prevent this page fault, it is necessary to check the PMD
>>> migration entry and return early. In this context, there is no need to
>>> use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
>>> of the target folio. Since the PMD migration entry is locked, it cannot
>>> be served as the target.
>>
>> You mean split_huge_pmd_address() locks the PMD page table, so that
>> page migration cannot proceed, or the THP is locked by migration,
>> so that it cannot be split? The sentence is a little confusing to me.
>
> During the THP migration, the THP folio is locked (folio_trylock). When
> this THP folio is identified as partially-mapped and inserted into the
> deferred split queue, the system then scans the queue and attempts to
> split the folio when memory is under pressure or through the sysfs debug
> interface. Since the migrated folio remained locked, during the
> deferred_split_scan, the folio_trylock fails with the migrated folio. As

Wait. If folio_trylock() failed, how could split_folio() is called in
deferred_split_scan()? Your call trace has split_folio(),
which means the folio is locked by deferred_split_scan() already, not migra=
tion.
What am I missing?

> a result, the folio passed to split_huge_pmd_locked ends up being
> unequal to the folio referenced by the pmd migration entry, indicating
> the pmd migration folio cannot be the target for splitting and needs to
> return.
>
> An alternative approach is similar to the following:
>
> +       swp_entry_t entry;
> +       struct folio *dst;
>         if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>             is_pmd_migration_entry(*pmd)) {
> -               if (folio && folio !=3D pmd_folio(*pmd))
> -                       return;
> +               if (folio) {
> +                       if (is_pmd_migration_entry(*pmd)) {
> +                               entry =3D pmd_to_swp_entry(*pmd);
> +                               dst =3D pfn_swap_entry_folio(entry);
> +                       } else
> +                               dst =3D pmd_folio(*pmd);
> +
> +                       if (folio !=3D dst)
> +                               return
> +               }
>                 __split_huge_pmd_locked(vma, pmd, address, freeze);
>
> However, this extra effort to translate the pmd migration folio is
> unnecessary. Any ideas of exceptions?

I get this part. Your assumption is that split_huge_pmd_address()
with folio passed in is only called by THP split. It will be better
to state your assumption explicitly in the comment. It is unclear
to people why =E2=80=9Cfolio lock guarantees =E2=80=A6 wrong folio=E2=80=9D=
.

>
>>
>>>
>>> BUG: unable to handle page fault for address: ffffea60001db008
>>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
>>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>>> Call Trace:
>>> <TASK>
>>> try_to_migrate_one+0x28c/0x3730
>>> rmap_walk_anon+0x4f6/0x770
>>> unmap_folio+0x196/0x1f0
>>> split_huge_page_to_list_to_order+0x9f6/0x1560
>>> deferred_split_scan+0xac5/0x12a0
>>> shrinker_debugfs_scan_write+0x376/0x470
>>> full_proxy_write+0x15c/0x220
>>> vfs_write+0x2fc/0xcb0
>>> ksys_write+0x146/0x250
>>> do_syscall_64+0x6a/0x120
>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> The bug is found by syzkaller on an internal kernel, then confirmed on
>>> upstream.
>>>
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path=
")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>>> ---
>>>   mm/huge_memory.c | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2a47682d1ab7..0cb9547dcff2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
>>>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long =
address,
>>>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>>>   {
>>> +	bool pmd_migration =3D is_pmd_migration_entry(*pmd);
>>> +
>>>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struc=
t *vma, unsigned long address,
>>>   	 * require a folio to check the PMD against. Otherwise, there
>>>   	 * is a risk of replacing the wrong folio.
>>>   	 */
>>> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> -	    is_pmd_migration_entry(*pmd)) {
>>> -		if (folio && folio !=3D pmd_folio(*pmd))
>>> -			return;
>>> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>>> +		if (folio) {
>>> +			/*
>>> +			 * Do not apply pmd_folio() to a migration entry; and
>>> +			 * folio lock guarantees that it must be of the wrong
>>> +			 * folio anyway.
>>
>> Why does the folio lock imply it is a wrong folio?
>
> As explained above.
>
>>
>>> +			 */
>>> +			if (pmd_migration)
>>> +				return;
>>> +			if (folio !=3D pmd_folio(*pmd))
>>> +				return;
>>> +		}
>>
>> Why not just
>>
>> if (folio && pmd_migration)
>> 	return;
>>
>> if (pmd_trans_huge() =E2=80=A6) {
>> 	=E2=80=A6
>> }
>> ?
>
> Do you mean to implement as follows?
>
> if (folio && pmd_migration)
>         return;
>
> if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
>         if (folio && folio !=3D pmd_folio(*pmd))
>                 return;
> }
>
> if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration)
>         __split_huge_pmd_locked(vma, pmd, address, freeze);

Yes.

>
> To match the current upstream logic, when folio is null, no matter the
> condition is either pmd_trans_huge, pmd_devmap, or pmd_migration, the
> __split_huge_pmd_locked must be always executed. Given that, the
> __split_huge_pmd_locked cannot be put inside if condition for trans_huge
> and devmap. Likewise, the __split_huge_pmd_locked cannot be called
> directly without wrapping the if condition checks. What happens if this
> is not a pmd entry? This will be invoked unconditionally.
>
> The original implementation consolidates all the logic into one large if
> statement with nested if condition check. However, it's more robust and
> clear. The second one simplifies the structure and can rule out the
> pmd_migration earlier and doesn't have the big if condition. However,
> it's trickier and needs extra care and maintenance.

IMHO, fewer indentation is always better. But I have no strong opinion
on it.

Anyway, we need to figure out why both THP migration and deferred_split_sca=
n()
hold the THP lock first, which sounds impossible to me. Or some other execu=
tion
interleaving is happening.

Thanks.

Best Regards,
Yan, Zi

