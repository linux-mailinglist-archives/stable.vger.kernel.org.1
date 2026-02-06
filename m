Return-Path: <stable+bounces-214728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG/WJPZHhmkhLgQAu9opvQ
	(envelope-from <stable+bounces-214728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:58:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E253A102F0B
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D765300BDA7
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC932313555;
	Fri,  6 Feb 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXbG88E0"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC82848B2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407923; cv=fail; b=mZ9u4JeEb9JB8VI2Q0av2ZZ0NqGZOKCH3W3eCRliRJgKVNIJ+F345lz7zJiU09gfto9p6XM1lLOlhFSTDhrR3vOYZHIXyiiYtYkLlE7720YQ5yec5PHcWrAQv4+0evEixkmlK2og+7lhV6UYK6Mjaijm97b0XfmeAVsQfmnj9FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407923; c=relaxed/simple;
	bh=vJfW1ATqFWsgeKRYayKGw2z5clAcY9FCM+bsCAC4PcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoSYNHSP9IfI3MICHI1mptO0D7+0SnbqTynWNkTnSnYFN+bKVhyAj2vZPpDwBFQ6V9I89MYFSSdJWcmzu0+zRQ9BDnF+nl7gKeMD3Y8LSO+gvuCQkIzH7adli4Ef7oa1uOg3uQlNhZBujWDsSlokSWbGvAPcHAV2gx1Swz9WaB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXbG88E0; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJv+SMXogC4MVxn6rlAp6ZVmx/xG51L/wdG+LeXpNoQAaTc5ZJkQK7iYeJAF/J48kh+DWgsWUjjpIyvBa3pHC89b9vXC/am2V7QZGC9F8fP+MCur0Ht81a4RkUF2Rnr16ME16yqqBLKs4uY9wXN+Vn7r+o8VKqtuSQxA6kL2MKFSDWCM8+7d7KkuTCn9bfl8LAueOUlOP/L/yodmbaa/KTNNMfpfzM3H45PEajsZfX56Du0+DBZspqjLLE3brufm2zBeQyRBwjhkexeLNy49Uv+HnMe0dWbyNc95eJAHKZ/SfTZsce4zr3RinfinW7jqyubCIKRF0KB7dm7P8LV9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJfW1ATqFWsgeKRYayKGw2z5clAcY9FCM+bsCAC4PcI=;
 b=tJrDR47BhXrAS8Gy2KdCQN23ug/tBOhy4pMB3b6CN+FCBohES07EQSII6690ftSLkF5yZM4j7q1mMPk8anXnM0JMvUeI/s3BlmlCJK/NX21Y5zmLk36NyGlfrcawcjQk/CCv7LMf6ga0dfFNGKELqemMVp+bOzZGxYrjfp8CVZjZ+MROYe+pfi6em8MuNvb9RTaSuofswyJmnL8AtQp2UjJeIlLNv8NqJbrgHs8rBskMhV5+ZkuPE61xi9mgAnVsjlClwXnMfQV0k1t0aiKsiZJk9lZ1GfImlaeiUbHzmFYOoRTCvkKRyJZ2nasULsjfuhoKvzOHSZVR13TOopXlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJfW1ATqFWsgeKRYayKGw2z5clAcY9FCM+bsCAC4PcI=;
 b=eXbG88E0Z/ji3vnA02UyDXDnmf6pTvKPd7/b4TT8qBM1SpVfLTArtfWWKwp4ogzuoreKkwnB8XeAsG/G/ji1aw0E7dt6e/W9P4alZQ4hstJebU3aSa/ebDSze2a99oK4NqzRSmCgN8+pszY82doleqU99xo8FQaULii0cjgrj+4VChbK7supQsLmnIgHArQyZTqqcvbKz8N0wD9Uz9x3NqyjmlBNzxhDmnmnbOyTmUY3ICH/HX9xaecNN8scDl37K4kW81UvnKpalid1bT/iPNwXjJSyK8zxVEZ70mngDQ9pL/CQo3hJTbgiuBTLCoZzB9j2vjzIbLTF7idnsQoX7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 19:58:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 19:58:39 +0000
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
Date: Fri, 06 Feb 2026 14:58:34 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
In-Reply-To: <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
 <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com>
 <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: d163db25-884d-4adf-9824-08de65ba1f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2hGUVFscEJleWhTc1BPYUdTdks5SC9pd0tTUExJRDNwbVhRU09la0NNYUpG?=
 =?utf-8?B?a1d6VHpWU1pEZUZoZEJ0N0xrZjhUUVJqZzZYWnVnMitGOER6citpTUNjbWlZ?=
 =?utf-8?B?ZEptaUJ6YTNlMHE5eFBJWkhrY2QyekpMTUJnTEU0ekx4Nk1NcldacGVuU29o?=
 =?utf-8?B?eDJVekxQYXFKamg1SWxCeXNTRTlIT3RPcS9yT0ZzME94OGJYa3l6UllSa1NU?=
 =?utf-8?B?ZGtGMGN1MExjVS9ZZ2NJQzR0c3B3MTdaTnBzVkgzVElzcGlmTGtqYTM3MGJu?=
 =?utf-8?B?djN5VDJnWEhlMlovQ3hxRUR0R1dBQk42eWlTTDFsYVhNakx1N3lkdlZVendT?=
 =?utf-8?B?NW9EK2lOd2o2MTJaaGVmdjZtZlErdlNXVUVLcFhGbVByUE1qSGJhSXJMaG1N?=
 =?utf-8?B?SS9SYllkVzFPNldpWEozVnNvbkYxeUYxWlkyYkdUNWtUZHdqbElrVU9oOGo2?=
 =?utf-8?B?Y1BYeW8wRDc1Y1craGE1Vk9CdUZKb3c2azY2NjIzdENkWERQM0loYlJaeGky?=
 =?utf-8?B?SVRHM1NGMW5mamhwYVdvZkFlSnRkUmJQRUh6UHlidnJ1K3pEWkZYdit5Tnpk?=
 =?utf-8?B?bk5NdmxJa2ZPdlVmY0QxNXlKZk5wYUladXVzMDVnMU9yNkwzNkNicjJuL1Ev?=
 =?utf-8?B?eFRUc1ZxcXZCTnRDS1l4VnprYUhINjhDd29JajY3dnhqVTA1am5hL1RUWjBJ?=
 =?utf-8?B?VVlOYUhrQldHam9nL20yREFLSTdyWDJ0T051RXMzZE0yamV6M0NaUUV5QVhL?=
 =?utf-8?B?S2RxVDhmT3Z2ZldhUjhsU3VwTW9OM0Fsc3BKY1Jrdk45VS9BWmVwVVM5a3k2?=
 =?utf-8?B?eUU5OWxieFVtU0VHK0NnZjlMQ040N2ptVm1SODI4eEdjdk1zS2dnNTgwdE94?=
 =?utf-8?B?cVVIRzNHSURGQ1kvRGYwMldVdGRwMlFUbGI4NVVkUXM3a3ljQlM0S09JeVVQ?=
 =?utf-8?B?QXVXMkl6VzRBWnc0U0g4azNNK1EzUUViZDg0bzNJc1AxclZVU2o2Um92Qjln?=
 =?utf-8?B?cDI0T3BFellZcUo1QkVXYktIeUV5Z3IxVVV2TUpiUmszZ2J6N1NOVDY2cG1G?=
 =?utf-8?B?OEoyemI5VkhmR0NQTDFhSUFaU29CRzhmeXVhcE5HVm1EMGxhaDZQMk5yQzI0?=
 =?utf-8?B?UjlmdkZVSEFWSzZkZlFjRXhaVkUreHlIbFMzUGdLZnQwNmFoTUtERHJHOEVZ?=
 =?utf-8?B?dGdoWUJRcThCRktBN2hZc3dQZkpOck9nMUxqQXpvZDJLdkFJSklsT3BtSVFr?=
 =?utf-8?B?UE5kUHBSVkZQVVlWT0hpRFZmU0kvZFdRL2t5bEZaem4zRUV4QVVKdUFSaUFY?=
 =?utf-8?B?NjJrbXB0QkJQSjh0U09tWThiRlRjSy9BM2dIZDczeCtlTmtCV2NnNWx4bmta?=
 =?utf-8?B?bGhBR1EzODZhU3lJdS8rWFhhUTdHZ0VxMndWZHBtY251Tk05cWNmL3ZYdVJa?=
 =?utf-8?B?ZE9tTGlPaE4zU3FlMURPY1R4UkpwaEVUb3YwVlRRY2ViRDhnSkpFTkxTOEh0?=
 =?utf-8?B?Uzd4VG0wTmtDdzArdm5iWWxiRW5XMmlVc216YVdmRkZUbXkvelduUWU3WlRn?=
 =?utf-8?B?NUxOTzFXOGZUQ3pXL09aZVdpT3pHdllKWFdLRVhjT0YzL0kzUis1Ymd3L2hQ?=
 =?utf-8?B?NzdBaEZ0RDVPcSt1YUE1dm1FVk9sWnVnM1dhTzRyZHFuQXoxTDNSck8yb01E?=
 =?utf-8?B?VUttR3VMU1crWnlWYk9FSlk3SHcwNndXMHZwQlpsNUlLUHFqTW5VZlI4OEZn?=
 =?utf-8?B?WmxzNzhJT3FsN09kMHRTS0Zwb0ZwNGNsTVVFdnFyeW1YRjRmUHVQRkkza1FI?=
 =?utf-8?B?Y2pyVnVkTmFxSDRGQ3cycjFpREVpdGpwaW5DY0pzbXE4NXVuN0UwT1ZyUEhP?=
 =?utf-8?B?TmZvNzVDamQwSkNwV0VacFE5b0k4SFZBU2s1SEM5RnJMM1hYNVplT2R6aTVD?=
 =?utf-8?B?L2tjSTRPUjc0MjZZZ0pUNTBqUWE3ZnMxWEJpNXFlLzdPZE1jOHJFeSsrT0dt?=
 =?utf-8?B?WnNTV2lwa0dNWnpEQjBFenRtY3VFajRyaEtOTmZSaWlLNk5GVzBQTTEzR0o5?=
 =?utf-8?B?dDZHNUZBQlQyUzNYYUxxcUNqUVkrb2F0YnZZUStOdWI5REVZYmh5c2xFN3hL?=
 =?utf-8?Q?CRxFgD0CAKgQflqOW125mimc6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEtwNk1USWt1aHVjOEM4RlhXdmRSb0ZGbVAvK2RGWFNUbnpZaEowNnUwclVy?=
 =?utf-8?B?TzhkVDFpaDVhK3RUNU1OUlhRZk9OakxweCtRTWlIRWdhajZVUXpKZ3lsM2th?=
 =?utf-8?B?R1hHMEpBNFp3VGVLdm1ablA5Q3N0T1RuSHFZdGFIOXpsSkhScEJLblp6VTBt?=
 =?utf-8?B?Zi8rS0loeDk1dDhuamltTVREVTRUb2ZaMzZLUzVOb2RyMU1WczNjRlk4MWM2?=
 =?utf-8?B?VlFtb0luZXhPYkxSUTVobkluUWxHWEtxeVNJZ1FCWkM5YnVVUlZxVk9HR0xt?=
 =?utf-8?B?V3p6d2lNZXFQOCsrOW96N1dwOGF2eUJQU25OZDBCbS9JUUlMNTlmNjlkaGpR?=
 =?utf-8?B?bHljcEJJL0NsVUhXTmV1eGVoNU4vQTlqWDhEa3gzNWtWT2VxbWZNUVEvaFl2?=
 =?utf-8?B?MlQyblZYc3ZMZStzN3NxVWdYaVhVeUNOZ0F2TUUwT0VlK2tFc1pqOW5ueTda?=
 =?utf-8?B?Z0FGYVdBWnBhL3Q1Wm1saVV5bytCMWhVci96ZUtCWkhTZ0c0dWNzVDNJUVlL?=
 =?utf-8?B?UE1kK0tWTUo3bGtEb1RkNTZqWGhxbUkwY1RuWGloOWNaNVFHM3Q0ck40Tkli?=
 =?utf-8?B?MUpkMEV4dDBrOEhvMXY2bG9VVEFnT1JCdjNtUFI4RnB5SHhSTHhzaEdnSVVo?=
 =?utf-8?B?YWVqMmxTSDVvUE1kK0x0M2xoWndCWk9EY0YwUlpFRmZFN29vLzNQUUx0Qjh6?=
 =?utf-8?B?U0UyM1E3S0ZUc0xCZjgwem9wUExUZnlnc21LV1ZMekZ0S0Z1dHZsdEhibEUx?=
 =?utf-8?B?SUpCeUp1QktEdUs4R245bmIvMmE0V3pqNUxvK3JGOHA5VEVHdEtveXBaRGI1?=
 =?utf-8?B?WlR5aVhUSU1NNFdaVnZwUUZ5c1NWeGxDczBxTmJQT0FWNDFDZENZZXBCM1NI?=
 =?utf-8?B?WXlRL0gvZEdIaUVlUnJ1SFNNV0IrSnk5TXNIT0dkanhIeDVOZHpTQ2tENjBa?=
 =?utf-8?B?cmVQZHdqNlRpU0J5Ukx0VEpVSGh5Ym5uL3Z1aFlOKzNxd0dKWnZtRWRYazhm?=
 =?utf-8?B?MWRXWUl1TElKUWRvN3ZjWHZPbzJ6K2sxQ3VZMmlDTUZaWklvRTZQSG5OLzdo?=
 =?utf-8?B?OVVTQTVCWkNXNXcrMFRLbm50aFRSbmdaanE2NDR2ZFZpZVU3Zzh3N0kvQWta?=
 =?utf-8?B?KysraUdvSUFkdStsbW1FNHhRWk1DcENUWkVZTXNibzBlN2dGODNyend6a1BV?=
 =?utf-8?B?cmVaN2UwSlFtbUc1TmlTY3diemlndnRYNjFYU1JZUjhWTmUwTG8rWUJxM2tS?=
 =?utf-8?B?Ylc1VEt3akRXdUZkYW56VkxJaXBSU1VZcnZWVVNpNnQ0MjFXQ3NJOTlVbHRX?=
 =?utf-8?B?aUR0TzZ1cnJTNGdLS3hETXJLMTVJUURYZEFZVnlUVjd2aTQyNFhMQmVoUHZC?=
 =?utf-8?B?VXNVMDBKbUphbktVdFF0YWlGSTdDZUNnWG52Z2pxaDdidDVlRW9USXVJQ0FI?=
 =?utf-8?B?SDF4YkJOYVVwcWJFcTk5cnpZT3JPRFNTV2dxZWl5MzJtalpXTmlqUmZmZUw3?=
 =?utf-8?B?UVJDcHRURHA4VE9DVFQ2QXhRUVhKUFpBZzNsaU4zc294OFoycUtCSTFyaHZv?=
 =?utf-8?B?K3UyRDdxVHN3VXg0Y1JnY0ZvYUszWUk3MTJ5cXZqVGF0OVpqTnlRMmZwMFM0?=
 =?utf-8?B?UTlVQjVHT3N6Y2V4MWx4aTVHbitYOE5vVHVGeXgxeVI3Z0hvU3lKamxSTG1a?=
 =?utf-8?B?VEFud1FhcFUzZTRRRDZ6cUx6b0tsMXhIZFJzbGJucUp1cVNxaXZFWHBBMUpa?=
 =?utf-8?B?OURZRlR3UHhDaVZvWXpGeXRMMlhFT0gyaHcySGd2NHFXYm44aktYUHNrdTY4?=
 =?utf-8?B?OWtXb0tqTjE2NlRNcHYzamxjanVuVlJJcGUvRXBEMFhyMHJBS2RHRENIYm1D?=
 =?utf-8?B?VklpeUVmNy9vVUduZGlyLzI1KzN3bm9CbkduQlJWNitlOFluSlp3Zm9yd1Bt?=
 =?utf-8?B?cDRqYW5kaU9IQnNEMlkxVTRvWkExQnNvcERUZjBjTVBMbURoUEp0M043MzVD?=
 =?utf-8?B?QVpwNGVzVHFvTlM3TEdNQVdwUHprejFvSHplYWlodk5vcGpUK0hKaEg2OVRY?=
 =?utf-8?B?cnE4NFVHa2xKNmhzMlkzdHB4aHFVSWVZd1hReDZ1WFh6UzdjZFBROXpnSWpD?=
 =?utf-8?B?eGFUS3BqNURmRWdPWWlqWkNQTHpRc1A1YVJreGMzR0VPV3JlMzc1OVEzM21F?=
 =?utf-8?B?S0R4UWQrWW5UL3lrV0k0K0d4dEhRdWpvOVJLNCsyd0FHN0s4VGUrN0hwSlAx?=
 =?utf-8?B?WklneXI5RmNwZXRwR1FMK1YrWWNuL0JvTnprUWFPcU1UVlJZTU11VjluWGhV?=
 =?utf-8?Q?IK5eMRZBUmUWubueLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d163db25-884d-4adf-9824-08de65ba1f3c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:58:39.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyWDPKeV4jCk4QLAedqmYJtKEyjcDVf4uRQ02m8YRR7AD9AmHQiBAyyOw2mIO18H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214728-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E253A102F0B
X-Rspamd-Action: no action

On 6 Feb 2026, at 13:33, Zi Yan wrote:

> Hit send too soon, sorry about that.
>
> On 6 Feb 2026, at 13:29, Zi Yan wrote:
>
>> On 6 Feb 2026, at 13:21, Mikhail Gavrilov wrote:
>>
>>> Hi, Yan
>>>
>>> On Fri, Feb 6, 2026 at 11:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> Do you have a reproducer for this issue?
>>>
>>> Yes, I have a stress test that reliably reproduces the crash.
>>> It cycles swapon/swapoff on 8GB zram under memory pressure:
>>> https://gist.github.com/NTMan/4ed363793ebd36bd702a39283f06cee1
>
> Got it.
>
> Merging replies from Kairui from another email:
>
> This patch is from previous discussion:
> https://lore.kernel.org/linux-mm/CABXGCsO3XcXt5GDae7d74ynC6P6G2gLw3ZrwAYv=
SQ3PwP0mGXA@mail.gmail.com/
>
> It looks odd to me too. That bug starts with vmalloc dropping
> __GFP_COMP in commit 3b8000ae185c, because with __GFP_COMP, the
> allocator does clean the ->private of tail pages on allocation with
> prep_compound_page. Without __GFP_COMP, these ->private fields are
> left as it is.
>
>>>
>>>> Last time I checked page->private usage, I find users clears ->private=
 before free a page.
>>>> I wonder which one I was missing.
>>>
>>> The issue is not about freeing - it's about allocation.
>
> I assume everyone zeros used ->private, head or tail, so PageBuddy has
> all zeroed ->private.
>
>>> When buddy allocator merges/splits pages, it uses page->private to stor=
e order.
>>> When a high-order page is later allocated and split via split_page(),
>>> tail pages still have their old page->private values.
>
> No, in __free_one_page(), if a free page is merged to a higher order,
> it is deleted from free list and its ->private is zeroed. There should no=
t
> be any non zero private.
>
>>> The path is:
>>> 1. Page freed =E2=86=92 free_pages_prepare() does NOT clear page->priva=
te
>
> Right. The code assume page->private is zero for all pages, head or tail
> if it is compound.
>
>>> 2. Page goes to buddy allocator =E2=86=92 buddy uses page->private for =
order
>>> 3. Page allocated as high-order =E2=86=92 post_alloc_hook() only clears=
 head
>>> page's private
>>> 4. split_page() called =E2=86=92 tail pages keep stale page->private
>>>
>>>> Clearing ->private in split_page() looks like a hack instead of a fix.
>>>
>>> I discussed this with Kairui Song earlier in the thread. We considered:
>>>
>>> 1. Fix in post_alloc_hook() - would need to clear all pages, not just h=
ead
>>> 2. Fix in swapfile.c - doesn't work because stale value could
>>> accidentally equal SWP_CONTINUED
>>> 3. Fix in split_page() - ensures pages are properly initialized for
>>> independent use
>>>
>>> The comment in vmalloc.c says split pages should be usable
>>> independently ("some use page->mapping, page->lru, etc."), so
>>> split_page() initializing the pages seems appropriate.
>>>
>>> But I agree post_alloc_hook() might be a cleaner place. Would you
>>> prefer a patch there instead?
>
> I think it is better to find out which code causes non zero ->private
> at page free time.

Hi Mikhail,

Do you mind sharing the kernel config? I am trying to reproduce it locally
but have no luck (Iteration 111 and going) so far.

Thanks.

Best Regards,
Yan, Zi

