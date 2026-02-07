Return-Path: <stable+bounces-214749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGklD06xhmk0QAQAu9opvQ
	(envelope-from <stable+bounces-214749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 04:28:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CD104C85
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 04:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D49D4300B451
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013F33D6C5;
	Sat,  7 Feb 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CSeuDJex"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1C5FDA7
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770434890; cv=fail; b=OqqcXfRI1IraPNnfpx+1Lbe8sW+oLZNOWRLkvoFP++/u5TSybOOeNFD88F7gR36Vksa4iPUHSlOqKuRljqqGQSX3HMkNIBm6eirEonbD0qUmjb+vJxCPNBPSyTP9xLQXF/++xHzcXr12bMe78G8NtlRc0urKQiL/tudBl1zYGHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770434890; c=relaxed/simple;
	bh=5LOnNSw+7U54s1yDoQEQDAUgiO5+N4OYCKc9h9CqK8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZntNYyh/0/mGrAR2bMIAZJ+bY7Yc6JdhLPF0+keZGukDEBpqOawfcdAc3+HyTma5INGJBqMNfkh7kNoqeFHY/4LkilISmvathSMJGLA6yqIfSoxzKPUQTeclLft4Tz2hQzZ0hsEs/D8tkQxUDLVYE+gQSlmZPsx0VXawTeff9o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CSeuDJex; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqyEaTTKiJ7K5AAdn8tbdOOF+MueZ0RtNlDL460Ei2b+Kfksr2XC0YH2w9I4ZAvW+CDO/dypta03QEVCk0e+0j+juamo5inQuYN9Nn5dKzpr+zZlwkOk1/OG8iC9i9CeXgkJrKegwiQ8tSPexsg2WR1kpYyEOeaaSubRPrYmy5fgHNb66eI6IB9Fwf/h3KWT8MurrdX3MuqQ/YkRnk5sEkss7lD7Fae5uM4gmJ7bN+spdDEjbjGHTzM5Vp3+HyONhjvMKLa7gJMpoDKfm+jaa2OqF6ylu74y1t/DkrQUuiMEpYmFhzwAK7V1sy4IN7LCRqmCNEExzAI6UylRONi1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr/KjBg2+EKuSXshHlbDEg/fyRh2QPa2OLOqGx0OiB0=;
 b=tOxXkJG9ys2VbF0NzqzxsHsGfC3f9m56+RkhZyslCWoEevIi1R1VjHfxBfU2QgatEBssDri0kG3PKs7qb4NjRiUWhLv1cD0nNu2cQdNksdhQdddBFQDZ6SeuQi+8/LFe2kUibxxbAMMGAbwpuCUbjPNAfQ6x15dsA8NGC+evA+0Mc2d1vjvHF1OU9Je87X256ulzayFmu3GrNDg5zA5UEbg3ZAiVZDx/magZ2avSVQGqyaMrGluKIs6KaJS/BynbuHXNuRHVACbqybWcY2RH8dRv1+rE67g8Z9mUQlfS7hf2rxPt7zkjwyipFwjYMHdinzeG/R/MFL0aZ7nQioN1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr/KjBg2+EKuSXshHlbDEg/fyRh2QPa2OLOqGx0OiB0=;
 b=CSeuDJexglIshgQC/+cZa1fTPjodbFS0f/HD7UGOUIkgJ25fEoKNBFD6bKCxj/DQ0ujYQiTK9ka53AjVRa2fOXMQagm+sRfoUyibVaGryH/1Y57UUGDtWhiSRfZ+lyVIRlfd9ascal6o1P7+4QU9zWdPQebyupO5IaTbGbujthRyck2QiuBWqpGRz2HaL1gI8xfZjr8uvwzPZ9aW+jcSg7wuUjgLDq0RY6VjloYo93DzQLRpe1PaulvcFA05IBToPYw8aw+CDAcyCh5SY/46rXhPN21RZ+zHlH614L+d3deteR+s2fPLuKJtwV9l6n6cycvGROJ+Kdm11HwvN60bgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Sat, 7 Feb
 2026 03:28:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.016; Sat, 7 Feb 2026
 03:28:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, chrisl@kernel.org,
 kasong@tencent.com, hughd@google.com, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, surenb@google.com,
 Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org,
 jackmanb@google.com, vbabka@suse.cz, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
Date: Fri, 06 Feb 2026 22:28:05 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
In-Reply-To: <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
 <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com>
 <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
 <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
 <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
 <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: b43f8587-2634-4bd2-cd31-08de65f8e917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clR4aEJtZnJCQnRKdXZPQmpSUXNUdER5dUZ0SlhmMS9qNWxLM2R5bE0xcGE3?=
 =?utf-8?B?UVd0TFlEQ3JJaUMyaktvWkxITjBwR3ZmUmJGdTZ6OGNQc05Hbi9wMHEyNHBz?=
 =?utf-8?B?TDBHUW1mYjdQMll1eEs5VVQ3Tm85UWFsRVFPNlNIZ1RDTlgxZFNiWVNZbk15?=
 =?utf-8?B?LytoVTRKSHRycnllQVpQa2p2eXRkd29tNU9RYmZHbWJraXdaRWNYa2IwbXNt?=
 =?utf-8?B?NEpPd0w2a1ZTdStob0gxajB6M3BuS09GTzdoVGIxQUNBRUpXeWZWS3VQN3l0?=
 =?utf-8?B?RjhiKy9YSFIydkFmS2Z0R1Q5MkhJbHVWRmJUNjhQRktheWlJQXVHalRURjZa?=
 =?utf-8?B?SjNXS1VnYVRwYTlPN21wZk9YTitlcUFVWjN2NXhWc2tUL2g4RGZBVjdaMWxP?=
 =?utf-8?B?QjV1NlZud1l0MlhkWjNRQlB6VFhJNU1jTzc1WW5QVVRYRGMwdzVPb2tzeE1v?=
 =?utf-8?B?VFkzYktIUlgvOE9jUmc0andCa3h5bm1WN2g0VkxZZUN5UzUzc1d5TklSazdr?=
 =?utf-8?B?NjlsSkY5RzNieXFRRnYwek1PcEQxRXJCMDU0MWlTVHpBb0ZPNTNCSVRORkNN?=
 =?utf-8?B?eUl5REQvSlMrNmZpSGF4SzB1cG9OS2x3OHE2VW9wZW1uTk1DcnROYVMrMWRj?=
 =?utf-8?B?QlZnRWYvK1Y1NGYyZkZ6aUgvSnR0SUdZaWYvbWZZSzJta3J1bkRtUzBTVTZi?=
 =?utf-8?B?bjh5L1hiWkNxK1NqR0RzcFQ1b09wNlFTQitYNTBzTVVDdUpFV2tQV3dkMVRK?=
 =?utf-8?B?N3lEdm5selJMMTJmUjR3QWI2VU9sSXFnVXBNdWhEaktLNGNuTkVaaGg1L0x5?=
 =?utf-8?B?a21OekI3U1l4VDRsTFE4dWZIMUxyYzhqRmlmWVFjaWtGemROUkM0TWxFeVI2?=
 =?utf-8?B?Q1lwTnhKa3h3VWxUK3NLWllvZUVZUnE1R0JleDV4bU9DdC9CSHBLcG9pRUZ1?=
 =?utf-8?B?UnRqM2kvNDdmYkkzclM4OVJmVVVJUStGaEcyZmtCMkhxR2JEREtwM3BMdjBY?=
 =?utf-8?B?SmVsRVM5aS9TeGhmYlA5Z0ZrUW1mc05pWHNsaVVQY1Q4eEo4RjJlTmJQRmJm?=
 =?utf-8?B?NWtGTlp6eThnRUdib21OT250Ym1sOWVCM3Fja3NlclA4T0pTSEljUkFoY2N4?=
 =?utf-8?B?SlpuRVcrYTYvOFVhck44MHVCQjUzL2JmSmh2VFREVHhxWk40SUZJN3FrMTFq?=
 =?utf-8?B?R0dLenJRZDdrMGZZSlJoL2Fpa0p6ZTlCQjB2UWJYcDJNVzU2UlpvZWc0Tjgw?=
 =?utf-8?B?Qmo3RUNnVm9oTFpYYldzTVdCU0Z1TFk2WmtZcC90dHlBUzQ0cko4YUljR1RU?=
 =?utf-8?B?Q09mSnFTeFIxZHlrWTVUSkM5eVRDWmpMRVFTUHlNVVhGUkRqMWZqOG1BcWEy?=
 =?utf-8?B?NFF1MEptWmRwOTBqeFY3aC9KZ3JyS0VCME1UVHRXYXhTS3dLd093VTdwTVh6?=
 =?utf-8?B?ay8zNDNpS3hkdVZQeVFCVFd5aE9FaU94QW1iZUtoMjY1YnpDb2k4akZTUjBQ?=
 =?utf-8?B?TGNUR1h0eWhiRWFRWUdTUjRrQ0lSMk5zelE5aTgwN2VEYUJUMUxBUUo0eVg2?=
 =?utf-8?B?eGs3ejZ5SmM3UmZKM28vUld2YzNlaU96Wk03bjNuNG05YzJESjdGc3hxeEpW?=
 =?utf-8?B?cTdseWJ5SmdDQTZOL24yT1EraTdXdVJ0QVl5eklTZ0NzK1VFb2tJMC9LSlI2?=
 =?utf-8?B?YUVkZXpLVXg5elV5aDBxT0RybXpmb05VaE8zaWdIbXNIS2pIREVCaThBSWVD?=
 =?utf-8?B?dFNrV0UrSFp2OVFNQ0dFSjYwUlFKWWowNjBubEVvTmcxMXRHT1A4TXBQR2FS?=
 =?utf-8?B?dGM3VHVDU09nSzRJOXlMY3VZNFZaWWJuZSsyUEtMVWh0dnhhNDN6KzQ0bTM4?=
 =?utf-8?B?RFE3ZWlTRmQ5YWswc1d2QW1RT3BpdXIrdTRSVzVOLzdLZlQ3S0dGQmpCWWtM?=
 =?utf-8?B?cmNmMDRDV1ZJVDdtalJvREQxZVVsVVd0UWpsREQ1aEx2U1dCZ2pvV3VUNlNS?=
 =?utf-8?B?SVd6My84Nnh2Uzk4c05QTjBNNzdoWUFWU3dCc1J5TWZXcEs0ZHhqNmxSR0Nj?=
 =?utf-8?B?SGpodzNvcXo0ekQxdUhadk0yY3dWNkJRK2orZjZ1RHNQV0pVRTYxbmtWOGxF?=
 =?utf-8?Q?gvRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUR0RTRsM3IzamhGMnJiblBoNzFiRmYvWUpwZWtONzhxOWpCTHBwd2ovY3di?=
 =?utf-8?B?NTVlY09lbUp0eitJdVlwMlMyS0NKYWJNdSsvclBPOG1na2lNY2dYdWluZ2J4?=
 =?utf-8?B?WVBCWWI2SExhWkdlKzI4bGR6ekYwclNpWGhxSk5pR3dkQVNva0laZ0pGbEQx?=
 =?utf-8?B?dUE1eitzTHhCMldnd3V0TU15RmVZVU5iZFNOSHEwR3NaMWxEU0ZMaTRVTVBm?=
 =?utf-8?B?YTBwSFlvRytmb1JzNEpoRHJac0FzbXlZbkxxZCs4MnJEL3pHWGlRMStUODNU?=
 =?utf-8?B?QVAxd21hMDhVYUpYcXA5d0RoTkV1WWJRbU85MTlYOXJoMnlYbjkvTnJEZHN1?=
 =?utf-8?B?YUQrYmFrSDJ1T0c0K3VWdFM0NjZzd0I1Y0lGSDZ5V2c0dVJxaUlJeGdNQlZ4?=
 =?utf-8?B?ZHRDeGZaZTNuT1J5OW10R1czUzF2bER1bm81dFdLYytwOE8xcWJpYytqMjZJ?=
 =?utf-8?B?Y2pBWG92Snk3YkYrdlppbUtTbzF4RFYyKzJ4S29PV1hmYThySnQyaTlnRlNE?=
 =?utf-8?B?ZUN1ejdVZFROTG1qS21oakxsOEI4dVpBWWtnckVycFpndUl2SytBalQ2RzR2?=
 =?utf-8?B?RXl0VlZKTmJuSmt0U0tRcjFmZTdWbEJUTEE1Q3paU0RSYVVPZE45R2E3WCtY?=
 =?utf-8?B?dEhBRzN6bUtkUW42VkxCb09YSmpTeGhLWXM0VmpLRHhPbzlLYlRQb3llL012?=
 =?utf-8?B?a2J4YTJHZ2t2eWZCNG0vSFAzRktGcmNsUmdFL3R3bGJGM1pSL3NLM2NkVFRH?=
 =?utf-8?B?L09sd21uclNvbzdmK0FZNTZYMUtVZ050ajJ6V2hQWGJUdUk4SUZvMEhneDB4?=
 =?utf-8?B?S3FkckgvOVhHeWpPWTZHak93SFFPZUxITGYvY1pOdmtSZmVqRlhyY3kranNr?=
 =?utf-8?B?YWZwbFNudTJoaEJWSG0wRWV5NlhpYVRiOVM4UW5sajY4OVNOLzdVb1QwM2N1?=
 =?utf-8?B?NG13YlFYS3dtREw4QnBwWVdFMVhSenZSc3lPaUFjRDYvclM0azUzNWtCWk5I?=
 =?utf-8?B?OWhDaGlwdFlRTXFlT0RRT1FEdWF6OXJWcVJjemhaZ1JDQzg3QlJreThPcUNz?=
 =?utf-8?B?UnUyb2lCNGQvMXNGazhRNndxeTlMbGdGR0IzaDlNUHJmMytWNjFnUmxkQ2c4?=
 =?utf-8?B?SXpIMWZOaGNiZXlOL2xwOEVYSFA3TVFOUFJoU2hsYkIzeWkveWVTQlAwUXpG?=
 =?utf-8?B?RHVZRTZIK0VrR2RrbHF4b1ZLQlVlZmtQVXlEYXVMVUdoZWlDYTMvckVZcGRs?=
 =?utf-8?B?Nkg4YmlDb2lhVW1IQ2gvS1FzR2JNRmxZY1NKQ1dPWXBVSEJZYXh2UGh6d0gx?=
 =?utf-8?B?QWJKNC9EcCswUFJQUHk2M3F6QkkzTi9RNDlub3c0TkRDM1A4cHpjSUZuRlpn?=
 =?utf-8?B?a2RIQWt0bm14VDJwWlY3UXNIRHNRUmYzSWUyQVdXTGNORUo0QThNclN0MGE1?=
 =?utf-8?B?cUsveFpUODkrMVBmMzY1MTFTMml4cUtpc3hWaHNXODl6WWFrcXhIbGNDSkJI?=
 =?utf-8?B?aU1tRmtWMEpaRHptNzNlTWlGS1F6K2ExM2ZPRGFna1B2RE1mSkpMWm84dVJV?=
 =?utf-8?B?RmpFNjc4UXNxeWRMNGhseXVsVFIwdEQ5cEJpWGtvek5EQkNiYnJjaUtnUi8z?=
 =?utf-8?B?Unp1aTFiOEhuWHkzcFRabkJlTFZYLzRWTkpxY3c1M0VjTHdyZFV6bXpOUzRT?=
 =?utf-8?B?allySGJRa2YvcUY4c0djZ3kvNmVzV081ZVdVL3FYYmxpcVAwaUUxcTEvaklQ?=
 =?utf-8?B?V2FORFU2NUoyN2ZIS3NSNU01TXBaK2pWMit6amt2MTZLQlFITG8ydk5OZXA1?=
 =?utf-8?B?MlQ1ZDB1NFgwTzdYQ2ZHUTVZb0FMYjE3L2RxUzZlTi9DRlM5V0R1QnRWcUcr?=
 =?utf-8?B?RVVSeWxtL1AyQnZib09LMVhTaGpsK3lURm9Kblk0RXhtVFZOVEs0UzVVVlk3?=
 =?utf-8?B?eWdmUDNrVXZhelcyTUVuR01WY2xaWWJsVnIxaGhEVFNDVTlXUVpqY3V5VENl?=
 =?utf-8?B?WDZCK2ZBYzRCaHozU0VaUytJWGhlWFhSZG8yMDBPWWo3NDZxaVlkaTlHdDVs?=
 =?utf-8?B?czlSa1M4bVFKcUVnZ2huNXNmaWtWSXRHT29VK0U4bXdITEV2YTJRY3R4V1hn?=
 =?utf-8?B?V2k1VGhPMEs5Q2htOUI2M05GaXBKb2lFU0hWVlErOG9kaURlK2JZd2JURjN2?=
 =?utf-8?B?Wnc3cWljM0Rtb2I2emMwRFc4RFNlNnZHZEo2bnJWTlJZMzIyYkE3cHlJSTMy?=
 =?utf-8?B?VVpVVWh6WkRHMG01WVpTalVGQ3FZdVdRbStQTTNoVEdiZzIxYTRDSng3TXJF?=
 =?utf-8?Q?/QlXWNihFhLnVGccwn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43f8587-2634-4bd2-cd31-08de65f8e917
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 03:28:07.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqM+fDHz0y2md7SbL10rXR9mvQBU1ahrl/XvuCmvtEbAakvl53ofeUIU17m7/s0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094
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
	TAGGED_FROM(0.00)[bounces-214749-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 613CD104C85
X-Rspamd-Action: no action

On 6 Feb 2026, at 18:06, Zi Yan wrote:

> On 6 Feb 2026, at 17:37, Mikhail Gavrilov wrote:
>
>> On Sat, Feb 7, 2026 at 3:16=E2=80=AFAM Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>
>>> Hi Zi,
>>> Thanks for the deep investigation!
>>> So the actual culprit is KASAN's kasan_save_stack() leaving non-zero
>>> page->private.
>>> That explains why it only reproduces with KASAN enabled.
>>> Looking at the code, kasan_save_stack() doesn't seem to use
>>> page->private directly - it goes through stack_depot. Is stack_depot
>>> the actual culprit?
>>> Happy to help investigate further if needed.
>>> Regarding the fix location - even if we fix KASAN/stack_depot,
>>> split_page() clearing page->private still seems like the right
>>> defensive fix.
>>> The contract for split_page() is that it produces independent usable
>>> pages, and page->private being clean is part of that.
>>> Other code could potentially leave stale values too.
>>> I can share my .config if still needed, but it sounds like you've
>>> already reproduced it.
>>>
>>
>> I think I found it. Looking at mm/internal.h:811, prep_compound_tail()
>> clears page->private for tail pages,
>> but it's only called for compound pages (__GFP_COMP).
>> Before commit 3b8000ae185c, vmalloc used __GFP_COMP, so tail pages got
>> their page->private cleared via prep_compound_tail().
>> After that commit dropped __GFP_COMP, tail pages keep stale values
>> from buddy allocator (which uses page->private for order).
>> So the stale value comes from buddy allocator's set_buddy_order() at
>> mm/page_alloc.c:755,
>> and __del_page_from_free_list() at line 898 only clears the head page's =
private.
>
> set_buddy_order() also only set head page=E2=80=99s private. And at each =
buddy
> page merge, any buddy found in free list gets its head page=E2=80=99s pri=
vate
> cleared in __del_page_from_free_list(). The final merged free page
> gets its private set by set_buddy_order() at done_merging. There should
> not be any stale values in any page=E2=80=99s private, if I read the code=
 correctly.
>
> If it is the problem of buddy allocator leaving stale private values,
> the problem would be reproducible with and without KASAN.
>

OK, it seems that both slub and shmem do not reset ->private when freeing
pages/folios. And tail page's private is not zero, because when a page
with non zero private is freed and gets merged with a lower buddy, its
private is not set to 0 in the code path.

The patch below seems to fix the issue, since I am at Iteration 104 and cou=
nting.
I also put a VM_BUG_ON(page->private) in free_pages_prepare() and it is not
triggered either.


diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d..546e193ef993 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode, p=
goff_t index,
 failed_nolock:
 	if (skip_swapcache)
 		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
-	if (folio)
+	if (folio) {
+		folio->swap.val =3D 0;
 		folio_put(folio);
+	}
 	put_swap_device(si);

 	return error;
diff --git a/mm/slub.c b/mm/slub.c
index f77b7407c51b..2cdab6d66e1a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3311,6 +3311,7 @@ static void __free_slab(struct kmem_cache *s, struct =
slab *slab)

 	__slab_clear_pfmemalloc(slab);
 	page->mapping =3D NULL;
+	page->private =3D 0;
 	__ClearPageSlab(page);
 	mm_account_reclaimed_pages(pages);
 	unaccount_slab(slab, order, s);



But I am not sure if that is all. Maybe the patch below on top is needed to=
 find all violators
and still keep the system running. I also would like to hear from others on=
 whether page->private
should be reset or not before free_pages_prepare().

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..9058f94b0667 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1430,6 +1430,8 @@ __always_inline bool free_pages_prepare(struct page *=
page,

 	page_cpupid_reset_last(page);
 	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+	VM_WARN_ON_ONCE(page->private);
+	page->private =3D 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);


--
Best Regards,
Yan, Zi

