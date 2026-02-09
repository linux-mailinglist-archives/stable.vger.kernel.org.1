Return-Path: <stable+bounces-215533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQqIqYeimmtHAAAu9opvQ
	(envelope-from <stable+bounces-215533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 18:51:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441F113397
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 917CF305854C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD547385EDA;
	Mon,  9 Feb 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xh0vw81o"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665993815FE;
	Mon,  9 Feb 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659075; cv=fail; b=gbZ8B+o7v/8nLDMUjcTxxJzEuf5H7LVlHm3DChp59rgbL6ha6bySrLsq1PVUiYQk//92JtHGtMcJfBZ7wNwuIg0mkl6D6qgARCSPkO9sTsdzeXBmKBy/cQ5WNaXMQuvmK90umGy0mlIUjU1vbAF7HgmxTG+HlheWLawQDu46sDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659075; c=relaxed/simple;
	bh=4NGsaHWtQG6uq8w2/V3fXmvYtlgS3Yo4GiPhKy7PpJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSO++l+mNq/pDio0eB+r6wjF2KZqx+6nltXCTQvOr1CoyOqYIZ0GLiDSN8GBW37Z1lL/sBAZJ1/ZCd9dbZDa6+/SsduRwij44Kws5m1LsDGntlvJ+xhUN86hhVNOD04owEbJ3KCJVo0mpQ0QFdPlzxjaD4jJ07fJESPPma3Pm34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xh0vw81o; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFfHfF41v5wlAlVikI+vWDJH11CLhYnpjstvI91/iyb5CQUH6QX5+vpChL4DM4NQCiS+KY7F0Je+Fb3q/ANv1hnPCghyMnWhlUDf3JOrNj7YJr/dS+BbI3RZdVRWRJrSaRoa5HFS44iVIto8mlMS0o9H0Uyf76B9VEK7Zxe8vBojwq0KT6ospgDApzuaXpSPsMcN5qq9eSc8WUB3VjkMfNXaPpwgCfRqauGeaw1Sdf3aAfTwiBMla7t17jBbDiWBD4qPPeUth+9yUQiki9eVZrXh7HkgzEo3fM4+KSSRELRjp7OO+51As8Ox3FgcmzIc3FhovCY4FCT3vztTQkh9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+StWSfo3q8LT48k/si2IwWvgHy0Yk23+v4Kls3pjmTM=;
 b=lW0gD9NcRhryfw+Cmcrr7AUcnCrUIznshuJA86DX0+NnG/BuM4vdZ5FrMcHutm819+6oCveSLt/YSFkJzWRzPZONXNSIdE1ArDvg3m2VScwnPAJEK47wDkWLamP4z1v0N1lfK/ClaK/K+Y2tplQs5ElQ+AQmOR47tM3JNuP4WqwPKmKNUnQoGRg5hGff6n7BfvuXLCSdykJqC4XDVjCr8JEPEfdRfChjcl8dVCNw4hyVi549qQuAbrXbor1ShC9qk/kiTZIflxeiVdqnO6TxGczRcF7fDwKL3zeRj0x5BoBjvP3ugGYghpiNlj6XOr5SJGFnKUHjtsV15UlNyzJ/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+StWSfo3q8LT48k/si2IwWvgHy0Yk23+v4Kls3pjmTM=;
 b=Xh0vw81od7w3W9VZvR3s7s8ivsvTtjXmHYP/Vj3yNYn2CL6hDq3pzwOyZDJUYXrika97tUKj+OtH+puhBn6C9Eet0JdgyvWP0yh4BCngSU3fhznYQUCYjGtamLqZcttau7KVO0R+o2CuGJSdGRiJKLIc6shMMo/Jr5tmpEU8vM9VDx/rOFQJLjnjlPr0Egj4vOuiZkIohQ7tdRCz6VkokaLcWV6OhJM5LMu2vRNObczRrDI/DhFCxtOOkfptya6Vq7IXEqzQca5bPWEYRgEImpNtRUdYfeLvEnD+lezWvAmvM3vON5XvlxcLOM56S0dZJYo674aJfGpCvbuoGNTDJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 17:44:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:44:31 +0000
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
Date: Mon, 09 Feb 2026 12:44:26 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <3E055DAD-647A-456B-9230-4DD2574D4E8E@nvidia.com>
In-Reply-To: <546b200d-5b70-4db4-99f1-f50f6a343c10@kernel.org>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <0BC1D792-80CA-4E60-AEA0-187F73BD4723@nvidia.com>
 <bc0b6d03-4309-463d-a112-aae57cee335d@kernel.org>
 <22431471-b569-4ade-9881-387debada00b@kernel.org>
 <91F2E741-5473-4D34-ADA1-C9E6EDCBF5E0@nvidia.com>
 <546b200d-5b70-4db4-99f1-f50f6a343c10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 3249f04f-825d-44fe-d54f-08de6802e132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elhWRDR1Z1FPR1hNWllFeHdIOHBVbDVTcjNNR3R0L01RQU95OWhlbkdWMS9v?=
 =?utf-8?B?TlRBeTlsZURFUDBaYjB4dzFJSWdDY0ZkbTF1ejB6WTV6aFI0d0liUWQ5UVFW?=
 =?utf-8?B?YzZad01hRXdKYzBZR056YW40a1RQSjUrTTh6dDVIaW1OZVI2VmpjSXdIMms3?=
 =?utf-8?B?VnZKanA4TVJNU2RUdkgrMk10TWhwUEloUnNSWE55bmlSTy9mME9IM082WDN3?=
 =?utf-8?B?eFRYbFNQMDJJOFVyVlBuL25ZTVZJNTlOeitGOERCZUVQRTgrQUZYTjdnNE12?=
 =?utf-8?B?eHEyNFcwRCtRSFlTbUlycWJhR0EvOXIyTmlvU09KWU9KYVFUQ0N4N0kvUkt6?=
 =?utf-8?B?K2dvMmxqam5pNmNrOVFDUzFRb1pScW5ZSG5MaEZNU0hheWQwL0k2eUQxMjBV?=
 =?utf-8?B?eDhEcFdMVEJ4MmJoY25FQ2E2cVluRDYrWHJXcThCSUYxQVUrQnJCeVordkRB?=
 =?utf-8?B?WTVxcUZMVjdnWUM3L1RKQTA1NXE2VkF3ZHNmTHJBYzRRN08wQk0wajI5dWds?=
 =?utf-8?B?R2orWEhFZnpScGFBcm1rNXpzNXoxaHAwcGl3SkMrM0ZRR1g3alpGK1Q1RGN1?=
 =?utf-8?B?RXV2QktDazQvS2tMUCt0aWNjem44TVlORW8zaEc0SFRtZVdhWktDQ3FVK1A4?=
 =?utf-8?B?ODJLdTZaUHpnenFZUFk2dDd2eWNlSkhPb3VZbFZMWi9GUVZEVkRDSDY3ZDk5?=
 =?utf-8?B?WFBxb3dyWDZjc3RTNlRRellFUldEam0vK0hsbXBjdFJuWjQ5WUJOR2dpZFRW?=
 =?utf-8?B?NmpCRXVrZlQrTFh2ZmJHSkxLRFZQOVc2dHVFVm90cS9aN3AyblFIQ2pJcGhj?=
 =?utf-8?B?cDJKMWZKRkJCdEFvRmJsdm41Z2ZydTRqSmUwZzVNT2gydHpqUnplZkhOekVZ?=
 =?utf-8?B?NUdkeGlQT3h1SnVKSHdSanp4cUNZYmsvWTVHaE56cEwzSjBFTjlXdHRVMWNp?=
 =?utf-8?B?TkhqeC8wRTdweWg0ZFJuZ2ZwdjlnMmpEbjNhNDdFYzZ3QmYrZW5UMFJLZm5Y?=
 =?utf-8?B?eVNsbGt4eFpwZDFlSXFONlgva2lTM2dTWVhGOFQ3d09DL3ZVUFZ1YVFZWitV?=
 =?utf-8?B?SnNzS3VDTW1SSmhsemwzUzFkQWcxKzF4UFBKV1N3WlkwS0FPd0xnVFdwb0ZU?=
 =?utf-8?B?SmRENURzUkRhY1phY2ZHekVuVWVwQ0RUUkZiSUE0aXdlTmkxTUFQODcrWHk3?=
 =?utf-8?B?U1V2TVc3ekIycW5qU3Q2dzlOOEhmV2lWalNJeThWVEpUTGszN1cvSUdaVXdq?=
 =?utf-8?B?YWZpRG03OWJBREJlVmZzUXhGbm9GWGV5VHI2eXYzZy9uYlRLZHNrWXVxZGcy?=
 =?utf-8?B?ajNzMm1nTWtIeitZcGl0NUNkOHJudVRhTlovSWNkOGNENTNvWjNwU1hrMUtW?=
 =?utf-8?B?OGlRUXJ0RnZMS2NFVEhRd2tlTkhaMzFlTEtaK3FkaE9rUDFBTGR3alRVdE9h?=
 =?utf-8?B?cjJMc0hNMHlzdHVZNENYL2tVWXNKRXd3ZktBMXlFZitsblUzMmdXOUdVaEo1?=
 =?utf-8?B?Q3FvMjI5eTNIaFpvUFdDNWo3Qm9jS2MwUFpWQjA4c28wTlJvVkVIbjdmUUhl?=
 =?utf-8?B?MUNqcTVGcjQvTUV4dkFDM0d4VndPVEx6bkFBR0JpQXI1NGVUMjh0V2NaSi8v?=
 =?utf-8?B?UUZjRGh1M2F4dnI2M0NSZWNSdzhZRHkzTmRlQ2p2STdlbjRvc2RVWjBOUFV5?=
 =?utf-8?B?SlpkcHFGRmZwYzZuRk5rcFNvVFBBUC9DV2cxYVpoclVLd0hrRHkvS0lwSE94?=
 =?utf-8?B?cEd2MG1IV3kra3JuWldPSStzaFBkQXB1TnkvYmY1cUtnQ1pVNGxoeVFzcjZa?=
 =?utf-8?B?S2RqNTRDK2lIQzZyVU90dXplVWFnQlJsZ2RTQzM1TlBjd2tWZVdwRitVTWJp?=
 =?utf-8?B?UHhsQi9QbEhpbzJkc2hmOXFaVkNKZDFPbUNqZWoyT2loWFFrZGMweTdXbFVr?=
 =?utf-8?B?UjFyeGUrR0Qrank0MG1IK2pobjA3Ykdiei9NOGJRMGREYkxBZXZxQWRxTTRv?=
 =?utf-8?B?ME9SY3NGZTJsWHB5dVZBMHQwaTZ2R3FmUjhwaDhFYzZoRTNHcnpSMnFib0t6?=
 =?utf-8?B?NnB5VUk1NG0va3pIdElqbmJKd09UL0dFTkpoM2NrejV4Wm5HbjZMTlpCTVdw?=
 =?utf-8?Q?AU/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJJVjc4Y0FBdUVkaURFQjdEc1lzYkpOd0pCd1FxV2NFV1Mvb04vMlRXL0Jw?=
 =?utf-8?B?S1RINmpreFFaTXc1dXo1UjdQa0QwUzYwdVFxUFNiSjJDV2F2dlZ6elpLYzdn?=
 =?utf-8?B?R1BDUVNBNno1SThsZHRZeDdlZ2J6b0hpaVJzWTNtSklta1BsWkpLeXgvMWVU?=
 =?utf-8?B?ckFoSjdlUE1pWGt2T2FzNytwV0YwN0czMHRxRXlzUnNDOUU2TUt5RWVSTllt?=
 =?utf-8?B?SUxQM3lDN0xLQno0NWVjZDhkUXhteFA1NEZEb0U5MG01UldGQkhzZUJGeHI5?=
 =?utf-8?B?R3puckg2V0xCZG1FNnZNdm5Cdy9CQ2tvYnROc0pUcHhLVUZrYUVOV01OalRS?=
 =?utf-8?B?bnd0d0p6U1dGejNGeHU3T0huR3pHV21ESDRhTGI4SDNLcTlwYnFBUHNLaXpG?=
 =?utf-8?B?RHhpK1NPa1ZXWE5La0dUeWhrSmVRRHFOdUtBTkVFbjM4L0VTT1dhNGsxL2wv?=
 =?utf-8?B?WnZJRkI5QTcrZ1FqMFdxNUVJeGNNZ0NEZEhCWTFtNmxhcDlVTDFDbEJSOGhL?=
 =?utf-8?B?cDMySjFxa015dHhnUVh2cHlVUm11Wjd0dXRlcURmeTJoY1k1aFV1bldZUXBU?=
 =?utf-8?B?VWdrS3czMW8xa25lbFVVcWhzemJxNDdmeEFsRXlOYnpIenZwZTU5MjRDTVVm?=
 =?utf-8?B?V0ZrQW9STUJ3N2djd1dLMWVSMFFORmh3V2UwZTAyZW1NanpEVGpOZ3loUWFE?=
 =?utf-8?B?bzZrSzM4Z0lqWXdZQm5xYnRFZytBS1R5ZUtqTGszdHFBbmdIZXpmd2R4eVZO?=
 =?utf-8?B?SnlmRzQxd3Ztei9TQ3gvU2hhdzNhVUJIZ3lmbVQ0ZmVucVlEcTA1TktXYVU1?=
 =?utf-8?B?Y0NxWGVjYUJPWjh4VlViaCtrRElCZFZBWGExTXNPRlJ6RnhSTTlNYjFvNzMv?=
 =?utf-8?B?N0t5U3VHbXVUTEd6ZEZsRFh0N3M0cVRmZmlYeU54U3FxNWpHQ1dVdVVzS0Jo?=
 =?utf-8?B?Y0pXYjZIMVk0aUJqWkpNTnZGS3pYazN1Mm4zMEIvbEZaVnYxZ2lzUkdtR1d6?=
 =?utf-8?B?WG1QVi9tL2NyNk13WTllU0VDdTYxZTJPYWFhYmU3TlplNDZjZWVzOWxQNTFI?=
 =?utf-8?B?RzdJQTJxajFpQUxELytPQzlWb3duSTRCQTB5by9SeHBKNjdMUjdqSUZMVW5D?=
 =?utf-8?B?ZlEyWDdmR2R5aTFQb1l4UDRWWXZiNCtjc0tkUFg3MjIxYmlJK01BKzk0MXJJ?=
 =?utf-8?B?U3h6MEVPY2tHL0pMMmUyYUdRRnNIYzlTZTU1eTZqdG1La25QN013Ry9udXFz?=
 =?utf-8?B?OU1vbms1U3NxVzRwNFcyZGdacVhXMWxuNlZNbU9DM0VFVFJJYXh6ekRHZmd1?=
 =?utf-8?B?clZSTjV1VWEyRExKTnRKR2xKa0xiSWJlNDU5MWJBeVBtZnRnaUdNcVVFQitp?=
 =?utf-8?B?WjRBejJES2tQSHI1cU9aem4rSGFyaEtpNTcweTNUVzNla1U4UWxtcmxLVjEw?=
 =?utf-8?B?c29BejF6UlFWOE9CbldhQnNEMEFxeXZEdjVkekJ1N1RxNjAwUXJhcGU0ejFL?=
 =?utf-8?B?SGtDa2pKWE5meVJmTmg1cFJiVHlVb091SVhVbVFyZ3lGZnQ5U202c045MG5n?=
 =?utf-8?B?SzFFNU8ySGlXVEs4MjQ4VGU4aHR0K3ZZQlF1YksrUmlWbVpoUE1BTU1CL3Uv?=
 =?utf-8?B?SXBOcmQxckhWektIVUNBMmVXQnA5cjNMeDVXTnVQbG1keGZYbnFrbmhnbzJs?=
 =?utf-8?B?THhvS21aZy9RWmVHTWczV29KNm9UUUJ1NjBNUXU4RmNvMHliRDhhWUdwUlFQ?=
 =?utf-8?B?aUt4M3JpZ1l3T0RKSmVINDl5b2ZrWFVRb3hBWUo2Z1FjN1NNNy94Q29Td0hG?=
 =?utf-8?B?QllsNEFPNWloOEZKRFV0NUM2L2RuQzlRQVVnc0VGVXZWVlF3aUh6cVFjQXlE?=
 =?utf-8?B?ZWhGeE1qUlkrcnlBL1Ayc3Qwa2hlZ0hFemVDU1JrM3FvT2haWmh6Q3hZUGI2?=
 =?utf-8?B?Mnp3SHBtcnNPVnEzazZPOTY4YVhic1RTZFdmalowMUxJYVh4K1pnZTBnaGxL?=
 =?utf-8?B?dEwzbk1FZW1YSWo5TWdkMnQ1Zm1zTzQ2VWtmN0J3V0c5Yzk5Um5NSGhXdW9h?=
 =?utf-8?B?dTZnNEFIZEYrb3A4cm9rbU9kdy9nZWIzSXM3SjZhSlRJOFVNYXJzQlBBcjFT?=
 =?utf-8?B?aFAxYWVSTE1USGNuZ1FkYks4Zy9lanFLR3E4UktiNWhlNXVMcXlZUFhVWkNu?=
 =?utf-8?B?azl4QlJ1VG9WYVgxNFJNQ3hVSlZmbHBkSnltZGNvYVZYdWcyd001T0NSM2JC?=
 =?utf-8?B?SDAwWXpGNDh0VHFYcCtjQm5LY2lYTnltaWtHYkZLbzlkWnV0VlUxQjJhU2lw?=
 =?utf-8?Q?HtrbOxjCm25tJbwLyu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3249f04f-825d-44fe-d54f-08de6802e132
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:44:31.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnK4O+H/ipfVTu+/VHBR+ptcHv7XDIwI2Tp+GqD8hk2DzNQUmVlEsV6owNXiftci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215533-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 2441F113397
X-Rspamd-Action: no action

On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:

> On 2/9/26 17:33, Zi Yan wrote:
>> On 9 Feb 2026, at 11:20, David Hildenbrand (Arm) wrote:
>>
>>> On 2/9/26 17:16, David Hildenbrand (Arm) wrote:
>>>>
>>>> Right. Or someone could use page->private on tail pages and free non- =
zero ->private that way.
>>>>
>>>> [...]
>>>>
>>>>
>>>> Thanks.
>>>>
>>>>
>>>> Right.
>>>>
>>>>
>>>> Right. And whether it is okay to have any tail->private be non-zero.
>>>>
>>>>
>>>> Ideally, I guess, we would minimize the clearing of the ->private fiel=
ds.
>>>>
>>>> If we could guarantee that *any* pages in the buddy have ->private cle=
ar, maybe
>>>> prep_compound_tail() could stop clearing it (and check instead).
>>>>
>>>> So similar to what Vlasta said, maybe we want to (not check but actual=
ly clear):
>>>>
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index e4104973e22f..4960a36145fe 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1410,6 +1410,7 @@ __always_inline bool free_pages_prepare(struct p=
age *page,
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (p=
age + i)->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_pr=
ivate(page + i, 0);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> Thinking again, maybe it is indeed better to rework the code to not all=
ow freeing pages with ->private on any page. Then, we only have to zero it =
out where we actually used it and could check here that all
>>> ->private is 0.
>>>
>>> I guess that's a bit more work, and any temporary fix would likely just=
 do.
>>
>> I agree. Silently fixing non zero ->private just moves the work/responsi=
bility
>> from users to core mm. They could do better. :)
>>
>> We can have a patch or multiple patches to fix users do not zero ->priva=
te
>> when freeing a page and add the patch below.
>
> Do we know roughly which ones don't zero it out?

So far based on [1], I found:

1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (overlapping
with private);
2. __free_slab() in mm/slub.c does not zero ->inuse, ->objects, ->frozen
(overlapping with private).

Mikhail found ttm_pool_unmap_and_free() in drivers/gpu/drm/ttm/ttm_pool.c
does not zero ->private, which stores page order.


[1] https://lore.kernel.org/all/CABXGCsNyt6DB=3DSX9JWD=3D-WK_BiHhbXaCPNV-GO=
M8GskKJVAn_A@mail.gmail.com/

>
>> The hassle would be that
>> catching all, especially non mm users might not be easy, but we could me=
rge
>> the patch below (and obviously fixes) after next merge window is closed =
and
>> let rc tests tell us the remaining one. WDYT?
>
> LGTM, then we can look into stopping to zero for compound pages.
>
>>
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 24ac34199f95..0c5d117a251e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1411,6 +1411,7 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>>   				}
>>   			}
>>   			(page + i)->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +			VM_WARN_ON_ONCE((page + i)->private);
>>   		}
>>   	}
>>   	if (folio_test_anon(folio)) {
>> @@ -1430,6 +1431,7 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>>
>>   	page_cpupid_reset_last(page);
>>   	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +	VM_WARN_ON_ONCE(page->private);
>>   	page->private =3D 0;
>>   	reset_page_owner(page, order);
>>   	page_table_check_free(page, order);
>>
>>
>> Best Regards,
>> Yan, Zi
>
>
> --=20
> Cheers,
>
> David


Best Regards,
Yan, Zi

