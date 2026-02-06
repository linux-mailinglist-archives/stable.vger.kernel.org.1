Return-Path: <stable+bounces-214732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK/iEhRUhmlzMAQAu9opvQ
	(envelope-from <stable+bounces-214732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 21:50:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C106E1033E8
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 21:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C889B3050413
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85473054C7;
	Fri,  6 Feb 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUteLoVN"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36E286D5C
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410994; cv=fail; b=Ngs2KmjGwu3iQjX7h3Q2BXUeiC0bA/x7gBvqvI4TIMNAK2zj6Mt6w11lsiZXZvWM1J2Ho+Mszgt/1RrsplfrLbbOLaN0lGFOwVlUuCVD2pql1DXeuGKDkwLYHqvXLwBA36WXmhz+wTc9xXzFKvmlxgd+UmLM0U0pOqWUs5LvCyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410994; c=relaxed/simple;
	bh=JShJJj7J5/uEEFiNsksOt7mkTsuZ/ezCaUD4gck4UBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKwy2FJ+my32+S53esuNfTzwG5SlL/ZpKw+JAHmFSQbMeBNPVnLDHU07s6bek9Xr9+GracBdoZ+0TQSJaZFKfI/gI4Jby/fVgvJqDgjXT1yNLtlXxNPME/r4Glr7TwTsuc6WfyaEyYYpNV1mPYV3Pv7DPARsDz4ajFRRo/CQaA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUteLoVN; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRB60VgnBnn4TllSoq8iA7MZvLNsyMzqavSs0QhBVnrx5UBT8HArD0J96Odxt7aPWODny03b6jieVFX/C09MYmT3w5Hqa8sxrIa9ttTOlWg/FFOIecMwbpQ4WJS3ky5M/V65STgN3v+Dvv8kXvk3cKVwUllxVChlblnPtbWariZ+YhrSmTr9CzqQsMgiM0zDm6IhhkaisVlI2/4FSZ3IkGpUOlCANVH9WVktOKW4vygbIaUe9UgIPSFsD3NJ5x1o3mF1FSLPGgR+Po+Dvd/BVsKr+4bV9AAnhC9DhTlr6PWIjOCxi39fd+tsBurbenNvTnLJYABEvCc5lZg6GOHu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJjs0ngZQXTtIPP+Zy1MQD0q602T6EyGML7OGTPDgwk=;
 b=vXPxwMWirkG4sgDO7mQW+XT86HBNM6QPqIT7OvZME0LjALHTp2FScYbEfBMYnELnb2Bfuz9/1tbyCsEiWYOkIOUURW7cjxn74uUErQvrmqx43d0sJpKiOf2plCs/CdaCzxSxBETcEjRnJn0616YGNdcWK1U8t0XzlRfo+PG7iT1wYA2AP5nmNkP6MIJ6b9G/LwDJcL6obl5g/fcm/YjV1SOA0jsKcQul4lPjWyWjzTF38V1ZvIw8tXMavJaCVeZdUrRKxEC2SIOBPQw2lsLAfBd8LSFweHhP+ZZOEHNkHteZz7fY9se5xg5YtJGfoxsAmkNlMfdjGOD9vn/baN0kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJjs0ngZQXTtIPP+Zy1MQD0q602T6EyGML7OGTPDgwk=;
 b=rUteLoVN12mh7dDegBNywMWfr6uvF9Sz9ExDGM7qxcBoI09DDr8UkEvcD1xzI9uXd+E2RkZ9x6uyAYf4DePM0kGz3bNiqYoZwnu8Sm1ECnlutzyeaC0bFDfB3UVNbKYhtiiyyAJNqcSEDuAqvLUBokuJBN/N3qqFRiWmMdlRqxwPHo4pdgeF+rCGNqFFXAmKdbPXCZWhTA92B8qrBjG1ji/4vMOyhnL30KrLe9kQWID6r9vZ5clVjaLakf7tquKtT5boRnd9ORzLXm3viPnIqetoT1FEsVhZ2xyOu5qA8NzWconc5U2gW+oEkm/LyF3ETk2K7XuY9Fzc0oiCfrGKbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 20:49:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 20:49:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: <linux-mm@kvack.org>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
 <chrisl@kernel.org>, <kasong@tencent.com>, <hughd@google.com>,
 <ryncsn@gmail.com>, <stable@vger.kernel.org>,
 David Hildenbrand <david@kernel.org>, <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>, <mhocko@suse.com>,
 <hannes@cmpxchg.org>, <jackmanb@google.com>, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
Date: Fri, 06 Feb 2026 15:49:37 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
In-Reply-To: <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
 <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com>
 <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3108ce6c-e3ac-4655-5605-08de65c1429b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTZTbS8xRzR5MXJKSDlHVzRZSkZkOXZhcVcyWVhpaGg4UjJzeEN5S1Mxb1NY?=
 =?utf-8?B?ejhUNGc4V3ZBRXJzd3VQOUd0S0pSSHZBZW5HSFNQWDMvbWcrYnl4aHAyem9D?=
 =?utf-8?B?ZzlKRDhYc3U1ZDg2c2NnTHFVOWVLVEtLNE9mTnBWUjJabWRrMkxKSkI0cENT?=
 =?utf-8?B?ODErVG9icVhCQmd3MzROVjFnV0VBVUF5bWVvdEhoaEVSTE8zOHE3Sk9sRElR?=
 =?utf-8?B?SSsxMlZjdlhqSkRudE1lbXNZVUxpWTdCTFhNSURkT1pYK2ZQSjJIYlg0R0ZY?=
 =?utf-8?B?cElWM1NBSWw2RVBZL013Unh0OWFrRjAzdG51TWpyMVF4bHFsOCtndWYzbWF4?=
 =?utf-8?B?YkRaS3poSWhEUjlmZElwZU9Pd3dpdlcvdlEvQU1COGliVGVOc1JsRHVic2hD?=
 =?utf-8?B?TVNzdFA3bS9TUjR1ZXgrUyt2MGVhcjFkTVZiY1RJRFByMng3Z1ZzdG1uTGUz?=
 =?utf-8?B?RUNmQisxOFNLWlc2cWJVeFBnOFJYTG1KWWJ0VitldEtTRndTUm5jNkU4S1Bl?=
 =?utf-8?B?NXk0aG5oNzB0OWtUcm9HNk1KeVlNQ0ZJTFlQQlVmMkR3MDl5cjUxRzFiYUJn?=
 =?utf-8?B?aXAraHRudjNuakp1QUNCRmF6cHdLaVJYZ2ZNblVVYUlGRWVsNi9kRlMwK1h4?=
 =?utf-8?B?NXRneExrTUhhVjk3bU9uSHpWbHIwMUdzUkJ4dmU0V0hFMkpXOWxyYWtvRUNn?=
 =?utf-8?B?Z2x3RGJ6d1lsSndCV0NHK3p2cFZ5TDVrK2NIMnU4OEhSaU9pUmk3RWdXbW5n?=
 =?utf-8?B?M0k1MHk4WHRGT2N3TDFCZnpONHhuYXJ6WFp6UFVhTGdndTBRMFptMW5QQW5P?=
 =?utf-8?B?Q3JiZWFVRkVaaldLZ051S1l2UlJZOFZ0RVVndWxjUHdUWm1tV2VLbk5sa1Ey?=
 =?utf-8?B?Rm5mUEVoLzd5cjQxQStsMit3ZHQyZEdUbjd4dzRoLzJvYnpUaVdJNWhZVzNs?=
 =?utf-8?B?bk1kWHoySXVSa3pLMWNVQVpQVGova2hETmplOWFBcjIyQTJETnB1d3VGOURr?=
 =?utf-8?B?MUFkelk4OWRTUnhRRXUzd2ttTmhDejdJTlpGbUg3VXIwb2VOUXZ0T09MYzlw?=
 =?utf-8?B?Z1ltT2FWZVU3WVkrUEFzaHR5OHBFcmhBZlVFSlZMNzZUZHBVOHU3UVduWktu?=
 =?utf-8?B?VW9FU2xTNG41ZmdMeHNjeWo1NWZJVkg4b3hYYUNmeGJDOWNFK2lTR1JuSzZP?=
 =?utf-8?B?QjNlWmVIdkM3alVlUS9CMklWeFlJTWw1ZGNxK3dGY2JqNWpoSkNkVG5GeFJK?=
 =?utf-8?B?OStJQ2dyWFd6LzhUSjh5VFVFbjg5YitLekJNbFpmdkxpdlAra2RLanJ0WDVy?=
 =?utf-8?B?V2txbVV3YXpTaWl1T243Vm5NRUI0cjRDVU5rdWtUVVJ4a2RHYVdrMENML0Qx?=
 =?utf-8?B?U3RBaXAxeHdKU0JhRFpHWVZFaC9sbDRxN2VSL0ZLMGFKa0ptNzZpNUhpYURl?=
 =?utf-8?B?ZGE0MU5iTzRZd2k1WGMwVXArNk5vYXlnUXZubFlMbFEvYm1hSEU5SFFTZ3Bi?=
 =?utf-8?B?UFdIWVhtNW5iLzR3TDg5Y0pKRytqVGtFRkpVbktaS1NyQjdHQkJkUVRlRDF1?=
 =?utf-8?B?d0VIVzBXMzhIRWZVRklsZEpsOEF6amRTcWFobnA2cERkMmM4K3lnQ3F4QXBL?=
 =?utf-8?B?WTJmV1V2MERBdWNHZ0g1a2VyeThUU0ppNTNMcWM3WFc1QjN3emxqZmJlYlVK?=
 =?utf-8?B?c0NKOVNUUUhnTjFEWXRuRnFGQ05JOS9LSUdTbHVZd0pOOHF1eUlDSWF6cHJI?=
 =?utf-8?B?UXc2NVI5ZEF3bXpJWUtObmk3ekphZENTQ0ZsM29BeVNWOGgrL1BFWjgycG5m?=
 =?utf-8?B?eG5yY0VZT3JpWEd3aCs1RlRPbER4ejVUSFJzMmtZV09tL1RWUVFKSzhINTRF?=
 =?utf-8?B?dktPVVBUVHBaMDBHYzh6dm9xLzUvM3IvNHZEUENQQzZHSEx0dEgwRHFRZWlF?=
 =?utf-8?B?SkZKbjBrS2FuWXFOR01KTHM5V0p4TGtZZnU5RW5hSUM2eTlDSEFMS1dneXZ3?=
 =?utf-8?B?QlliRjJ6MmwzNUR4Sjk3WUdKUEVYT0JVMlUvWS9odVhrbW56QmZGSGJYZDha?=
 =?utf-8?B?OWpVWnBweUNWOTI1QTI0YVJkc1c3bHZNRUpPMjlUQWNyYWNobFVYaEZmUUdl?=
 =?utf-8?Q?RPK0V91o/ceOj2yhjyr3LDlbj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElFS29nTmRjWEJpcmJDaUpTSnMrRFVVc2N6WnpQRWVDWlFqM3AxdDhtSTh2?=
 =?utf-8?B?ZmJVdEFFUUo1azF4U0pjSmNaY0cxMm02NmM5MTBrcjRrdTFwTDVzQmE5UU9W?=
 =?utf-8?B?YU9pZmRGQ29LeHBjc1RjaDNDQ005bmltMWkvanlBcWh0TVdQU3BaS1J5WFdB?=
 =?utf-8?B?WmhYN0pXcmpLQTFGem1RRFZaUUhyN2xWSytSQWZOOVB5enZta1pmbVRhRGNz?=
 =?utf-8?B?T3l5ZWpneWNnK296S3FnOHRBdHR5TGVqV0tZUUJNN1c4OGJQNGt0cVJubUl0?=
 =?utf-8?B?VDhNclE5Y0tFRExPcFg5ZGRWY3lDRmdza2cyTFVjSzZsL2JWN0tha1RvZTJD?=
 =?utf-8?B?L0VnSGppUGJ5SzY3YS9tOXRuZ0dkSVY0L1ZkZ0pIM0FOTUthV3BVbEl3b2dK?=
 =?utf-8?B?Y0J5dXZYUGdKRjQ0OW5rWkZNUlFEdnJvSWk4a2xWdHA2enhoVmFCZ1RyeG1q?=
 =?utf-8?B?Qk5wMHExK2RKYWFuRUtwY0ZWMUNzRHY0anUrNjFwbUY0NWl2VVRrTy8vd3lO?=
 =?utf-8?B?dnNhQVJLZWx2bWJQTTV3RDlKaEpueVJsUUJuVVB5YzVoRDI5STA3Ujl3bXNz?=
 =?utf-8?B?U095MCtuOENlVzJlOHdNNWtvL1FlVzAwTkNRanVDM2Fyd1dEVSt6WlJJRXp1?=
 =?utf-8?B?L3d6VFBERFJiMmJjN0M3VzJkaVVVZzNVb0dRNkJaOGJpb2gzUHgwSDc5c1FX?=
 =?utf-8?B?TFFMWDhxZXB2bk13RGcwSnlxdVc3UTdOM0xWeitvSEFkSkZjUVFWWUJ1SXhV?=
 =?utf-8?B?M0RPbFB0VEUyOC9yVGVOeU1pUU14algrSEJub3pqNnZ6UXBaS1pOOGtCQUxi?=
 =?utf-8?B?SVRmenp6bldFVGNLOHp6YndzTkNNMUdKQUJvY3gzTWpyUUZ5QnhUSVdUWnhG?=
 =?utf-8?B?dS9uMkZydEM0RWpKTm16L0R5THR0b1VXc2p0aU50ZEFtRktBTy83RDN3anNB?=
 =?utf-8?B?Mk9BSXMvMlB6dG93TVlTbk1hQWt1bVpIakVnZ0NWYk9NR1VmczNObWJ1RDY3?=
 =?utf-8?B?RXh3K2xDaHZxeU8vbUZFL3ZpVXpHeW41SkU1V050VkRwMTY2OGlQazJuVXFq?=
 =?utf-8?B?OUREU01GdFBXN204NXpGVjlDQ3RsajZheC81RFhXUTdjNUl3RWFneEgxS0h6?=
 =?utf-8?B?UjZSbTkxaCtTd3U0U0F2VHRGVTF3bytoWDdUWlFMSzZ0TVc3c3FqTU9xNGxa?=
 =?utf-8?B?RDZaWjhUYjJYUmd5M1pTYmVTY1hZQmw0OUhHS2w3dG5jWjhWcDIrL2R2TG5J?=
 =?utf-8?B?WjlRc25vbzFGK3YzeTRYc0VscWtlMit4aWhLZlo4OVB1emlZTUpFS0ZxeDRJ?=
 =?utf-8?B?em9XWGJPaGNYMHljd04xWWxRSmx2SkIzTkQ2Sy9PN0VNL3lieTNvOXdNYWtJ?=
 =?utf-8?B?VUJnRjhwaXdyNjVDc3dqbzJGWW5JK2RpSTZtNWNtMVpTZ2pmT2VwOXJ1M0dP?=
 =?utf-8?B?anFCR0VpSldPWDJxS3pmNE5jejQ1cEhTd3hOaEhENGl5dXpBQkVuaE1tbm8z?=
 =?utf-8?B?RUNZV2QvYVJaQ2oyZk5vcGt2RUUxU2tia294MkNRK2xoN3NmMmUzL09iUVg3?=
 =?utf-8?B?K0VGVTBzazYrb3V5QzNnOFpZd2liT1ZpQ2dXK05Qb3lrR1VVVEx2VHhlZEVI?=
 =?utf-8?B?RGlZeXU5M2JKaFNnczJERit2YlZwVXJpT3htZmZHT2V4RFdQR09YenhqUzF3?=
 =?utf-8?B?b3dDWHJHcy9UTitXZU5iQmJ5OWVTdWRMWWdpQVdQWjd2YXJIVDVuUXBCOGdV?=
 =?utf-8?B?d2NhQm1XYU5Pc1BiRnZXYnVWbUs2QkFPRndTajV4aFZSakxUNG1lU2FZWEJl?=
 =?utf-8?B?MGozWG4ydEd1VFowNUl0ZnFOd2tmbEJSVjU1L0haZVV2NEJMMVJ0WEh6OHBt?=
 =?utf-8?B?T2dNL25BTUhIUDcvOEpkTDBEYVF1MzZIazBwMUVENkFSQmNzdDAxL1RvazlE?=
 =?utf-8?B?cW5vdzNKSXE2L2VTVnZhLzFrR25JWDN3WjhnbW55UmhnMmY0YW04dmV5RTU4?=
 =?utf-8?B?enhnd3BTaGx0Y3RxYXU1TEgwTXAvbmVBRXFsby9GS0VuUEZpcHVkOTZDano4?=
 =?utf-8?B?ZU1UVG4xbUY0dEJYdE02RU55WHYzZXd5RVNMK2pFUXdHb29lZy9tRS9KalA0?=
 =?utf-8?B?RUpNMVVJU3Z2RkhGYllJUzJKNXdPRUNjcTJmWFZjOW95Q3BmTmlIUGZGMkQ2?=
 =?utf-8?B?b3RsTFozUjRubkgyTll4TFR4UkMxL2tEZTVIb1RiYmMxdUh2WmtYUlFpRiti?=
 =?utf-8?B?eWJwcXV6Mkx2NEg2UXV6UlM0dVZQaHU1NEFuS2ZISHg2Q3NySDFYL0tvbDlN?=
 =?utf-8?Q?CcJCCYskIc4hVaoOeE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3108ce6c-e3ac-4655-5605-08de65c1429b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 20:49:45.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzwxCazNmTUxzDKnz0cvha4mZ7LaNTCTke3LYHtqT/W5Xx8LI1dT9b6nvi4AyoHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
	TAGGED_FROM(0.00)[bounces-214732-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,gmail.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C106E1033E8
X-Rspamd-Action: no action

On 6 Feb 2026, at 14:58, Zi Yan wrote:

> On 6 Feb 2026, at 13:33, Zi Yan wrote:
>
>> Hit send too soon, sorry about that.
>>
>> On 6 Feb 2026, at 13:29, Zi Yan wrote:
>>
>>> On 6 Feb 2026, at 13:21, Mikhail Gavrilov wrote:
>>>
>>>> Hi, Yan
>>>>
>>>> On Fri, Feb 6, 2026 at 11:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>>
>>>>> Do you have a reproducer for this issue?
>>>>
>>>> Yes, I have a stress test that reliably reproduces the crash.
>>>> It cycles swapon/swapoff on 8GB zram under memory pressure:
>>>> https://gist.github.com/NTMan/4ed363793ebd36bd702a39283f06cee1
>>
>> Got it.
>>
>> Merging replies from Kairui from another email:
>>
>> This patch is from previous discussion:
>> https://lore.kernel.org/linux-mm/CABXGCsO3XcXt5GDae7d74ynC6P6G2gLw3ZrwAY=
vSQ3PwP0mGXA@mail.gmail.com/
>>
>> It looks odd to me too. That bug starts with vmalloc dropping
>> __GFP_COMP in commit 3b8000ae185c, because with __GFP_COMP, the
>> allocator does clean the ->private of tail pages on allocation with
>> prep_compound_page. Without __GFP_COMP, these ->private fields are
>> left as it is.
>>
>>>>
>>>>> Last time I checked page->private usage, I find users clears ->privat=
e before free a page.
>>>>> I wonder which one I was missing.
>>>>
>>>> The issue is not about freeing - it's about allocation.
>>
>> I assume everyone zeros used ->private, head or tail, so PageBuddy has
>> all zeroed ->private.
>>
>>>> When buddy allocator merges/splits pages, it uses page->private to sto=
re order.
>>>> When a high-order page is later allocated and split via split_page(),
>>>> tail pages still have their old page->private values.
>>
>> No, in __free_one_page(), if a free page is merged to a higher order,
>> it is deleted from free list and its ->private is zeroed. There should n=
ot
>> be any non zero private.
>>
>>>> The path is:
>>>> 1. Page freed =E2=86=92 free_pages_prepare() does NOT clear page->priv=
ate
>>
>> Right. The code assume page->private is zero for all pages, head or tail
>> if it is compound.
>>
>>>> 2. Page goes to buddy allocator =E2=86=92 buddy uses page->private for=
 order
>>>> 3. Page allocated as high-order =E2=86=92 post_alloc_hook() only clear=
s head
>>>> page's private
>>>> 4. split_page() called =E2=86=92 tail pages keep stale page->private
>>>>
>>>>> Clearing ->private in split_page() looks like a hack instead of a fix=
.
>>>>
>>>> I discussed this with Kairui Song earlier in the thread. We considered=
:
>>>>
>>>> 1. Fix in post_alloc_hook() - would need to clear all pages, not just =
head
>>>> 2. Fix in swapfile.c - doesn't work because stale value could
>>>> accidentally equal SWP_CONTINUED
>>>> 3. Fix in split_page() - ensures pages are properly initialized for
>>>> independent use
>>>>
>>>> The comment in vmalloc.c says split pages should be usable
>>>> independently ("some use page->mapping, page->lru, etc."), so
>>>> split_page() initializing the pages seems appropriate.
>>>>
>>>> But I agree post_alloc_hook() might be a cleaner place. Would you
>>>> prefer a patch there instead?
>>
>> I think it is better to find out which code causes non zero ->private
>> at page free time.
>
> Hi Mikhail,
>
> Do you mind sharing the kernel config? I am trying to reproduce it locall=
y
> but have no luck (Iteration 111 and going) so far.
>

It seems that I reproduced it locally after enabling KASAN. And page owner
seems to tell that it is KASAN code causing the issue. I added the patch
below to dump_page() and dump_stack() when a freeing page=E2=80=99s private
is not zero. It is on top of 6.19-rc7.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..2151c847c35d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1402,6 +1402,10 @@ __always_inline bool free_pages_prepare(struct page =
*page,
 #endif
                }
                for (i =3D 1; i < (1 << order); i++) {
+                       if ((page + i)->private) {
+                               dump_page(page + i, "non zero private");
+                               dump_stack();
+                       }
                        if (compound)
                                bad +=3D free_tail_page_prepare(page, page =
+ i);
                        if (is_check_pages_enabled()) {

Kernel dump below says the page with non zero private was allocated
in kasan_save_stack() and freed in kasan_save_stack().

So fix kasan instead? ;)

qemu-vm login: [   59.753874] zram: Added device: zram0
[   61.112878] zram0: detected capacity change from 0 to 16777216
[   61.131201] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 =
across:8388604k SS
[   71.001984] zram0: detected capacity change from 16777216 to 0
[   71.089084] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
xffff888131a9da00 pfn:0x131a9d
[   71.090751] flags: 0x100000000000000(node=3D0|zone=3D2)
[   71.091643] raw: 0100000000000000 dead000000000100 dead000000000122 0000=
000000000000
[   71.092913] raw: ffff888131a9da00 0000000000100000 00000000ffffffff 0000=
000000000000
[   71.094336] page dumped because: non zero private
[   71.095000] page_owner tracks the page as allocated
[   71.095871] page last allocated via order 2, migratetype Unmovable, gfp_=
mask 0x92cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC), pid 8=
34, tgid 834 (rmmod), ts 71089064250, free_ts 67872485904
[   71.099315]  get_page_from_freelist+0x79b/0x3fa0
[   71.100216]  __alloc_frozen_pages_noprof+0x245/0x2160
[   71.101177]  alloc_pages_mpol+0x14c/0x360
[   71.101704]  alloc_pages_noprof+0xfa/0x320
[   71.102497]  stack_depot_save_flags+0x81c/0x8e0
[   71.103100]  kasan_save_stack+0x3f/0x50
[   71.103624]  kasan_save_track+0x17/0x60
[   71.104168]  __kasan_slab_alloc+0x63/0x80
[   71.104694]  kmem_cache_alloc_lru_noprof+0x143/0x550
[   71.105385]  __d_alloc+0x2f/0x850
[   71.105831]  d_alloc_parallel+0xcd/0xc50
[   71.106395]  __lookup_slow+0xec/0x320
[   71.106880]  lookup_slow+0x4f/0x80
[   71.107463]  lookup_noperm_positive_unlocked+0x7d/0xb0
[   71.108173]  debugfs_lookup+0x74/0xe0
[   71.108660]  debugfs_lookup_and_remove+0xa/0x70
[   71.109363] page last free pid 808 tgid 808 stack trace:
[   71.110058]  register_dummy_stack+0x6d/0xb0
[   71.110749]  init_page_owner+0x2e/0x680
[   71.111296]  page_ext_init+0x485/0x4b0
[   71.111902]  mm_core_init+0x157/0x170
[   71.112422] CPU: 1 UID: 0 PID: 834 Comm: rmmod Not tainted 6.19.0-rc7-di=
rty #201 PREEMPT(voluntary)
[   71.112427] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.17.0-debian-1.17.0-1 04/01/2014
[   71.112431] Call Trace:
[   71.112434]  <TASK>
[   71.112436]  dump_stack_lvl+0x4d/0x70
[   71.112441]  __free_frozen_pages+0xef3/0x1100
[   71.112444]  stack_depot_save_flags+0x4d6/0x8e0
[   71.112447]  ? __d_alloc+0x2f/0x850
[   71.112450]  kasan_save_stack+0x3f/0x50
[   71.112454]  ? kasan_save_stack+0x30/0x50
[   71.112458]  ? kasan_save_track+0x17/0x60
[   71.112461]  ? __kasan_slab_alloc+0x63/0x80
[   71.112464]  ? kmem_cache_alloc_lru_noprof+0x143/0x550
[   71.112469]  ? __d_alloc+0x2f/0x850
[   71.112473]  ? d_alloc_parallel+0xcd/0xc50
[   71.112477]  ? __lookup_slow+0xec/0x320
[   71.112480]  ? lookup_slow+0x4f/0x80
[   71.112484]  ? lookup_noperm_positive_unlocked+0x7d/0xb0
[   71.112488]  ? debugfs_lookup+0x74/0xe0
[   71.112492]  ? debugfs_lookup_and_remove+0xa/0x70
[   71.112495]  ? kmem_cache_destroy+0xbe/0x1a0
[   71.112500]  ? zs_destroy_pool+0x145/0x200 [zsmalloc]
[   71.112506]  ? zram_reset_device+0x210/0x5e0 [zram]
[   71.112514]  ? zram_remove.part.0.cold+0x8f/0x37f [zram]
[   71.112522]  ? idr_for_each+0x10b/0x200
[   71.112526]  ? destroy_devices+0x21/0x57 [zram]
[   71.112533]  ? __do_sys_delete_module+0x33f/0x500
[   71.112537]  ? do_syscall_64+0xa4/0xf80
[   71.112541]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   71.112548]  kasan_save_track+0x17/0x60
[   71.112551]  __kasan_slab_alloc+0x63/0x80
[   71.112556]  kmem_cache_alloc_lru_noprof+0x143/0x550
[   71.112560]  ? kernfs_put.part.0+0x14d/0x340
[   71.112564]  __d_alloc+0x2f/0x850
[   71.112568]  ? destroy_devices+0x21/0x57 [zram]
[   71.112575]  ? __do_sys_delete_module+0x33f/0x500
[   71.112579]  d_alloc_parallel+0xcd/0xc50
[   71.112583]  ? __pfx_d_alloc_parallel+0x10/0x10
[   71.112586]  __lookup_slow+0xec/0x320
[   71.112590]  ? __pfx___lookup_slow+0x10/0x10
[   71.112594]  ? down_read+0x132/0x240
[   71.112598]  ? __pfx_down_read+0x10/0x10
[   71.112601]  ? __d_lookup+0x17b/0x1e0
[   71.112605]  lookup_slow+0x4f/0x80
[   71.112610]  lookup_noperm_positive_unlocked+0x7d/0xb0
[   71.112614]  debugfs_lookup+0x74/0xe0
[   71.112618]  debugfs_lookup_and_remove+0xa/0x70
[   71.112623]  kmem_cache_destroy+0xbe/0x1a0
[   71.112626]  zs_destroy_pool+0x145/0x200 [zsmalloc]
[   71.112631]  ? __pfx_zram_remove_cb+0x10/0x10 [zram]
[   71.112638]  zram_reset_device+0x210/0x5e0 [zram]
[   71.112645]  ? __pfx_zram_remove_cb+0x10/0x10 [zram]
[   71.112651]  ? __pfx_zram_remove_cb+0x10/0x10 [zram]
[   71.112658]  zram_remove.part.0.cold+0x8f/0x37f [zram]
[   71.112665]  ? __pfx_zram_remove_cb+0x10/0x10 [zram]
[   71.112671]  idr_for_each+0x10b/0x200
[   71.112675]  ? kasan_save_track+0x25/0x60
[   71.112678]  ? __pfx_idr_for_each+0x10/0x10
[   71.112681]  ? kfree+0x16e/0x490
[   71.112685]  destroy_devices+0x21/0x57 [zram]
[   71.112692]  __do_sys_delete_module+0x33f/0x500
[   71.112696]  ? __pfx___do_sys_delete_module+0x10/0x10
[   71.112702]  do_syscall_64+0xa4/0xf80
[   71.112706]  entry_SYSCALL_64_after_hwframe+0x77/0x7f



Best Regards,
Yan, Zi

