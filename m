Return-Path: <stable+bounces-215585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INfBHhiUimlvMAAAu9opvQ
	(envelope-from <stable+bounces-215585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:12:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B8116309
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B2743007B37
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AA2C1589;
	Tue, 10 Feb 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoigNpcA"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C932405ED;
	Tue, 10 Feb 2026 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689554; cv=fail; b=W5+hkdbMiBZ8+mscqBIse9qKkvY09DY199IHPnyPoDKAGWQbgTBjI5hmDbJ/gQXQHEin/J6/ojCxI7/2uoOnC1+kB/7k59UBfIzZDqsVv0s1Y0CQWl3ta2OP/tO3LrhCzXrDR5x+OW0vmS8Z2ZRqoaAMcFFXPL6yYBuPM4ylOGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689554; c=relaxed/simple;
	bh=A7Fyf/F7oIQ6W6YozKUd7ZkZ00tRhoHSl9Gbi2vki+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kgqkt6D7dV/NFek5O7XEDqDeJcCONV0WhidThvJ/c5kzgEWODL7I90A9W4R+MtlDlHrBxrIZCTy51FwfVTWDHWTCeyqsAqo52vVd5ToHI+IVgNaNqA8JwlAtQ4IrOfo0LM5y0WZoAc6eFAHpBplijhswv//qpLpyq+gJDFqTmsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoigNpcA; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXXBRGxi07xLbXXDU4CqcHcVxQ9L2iUkDCTJJireeIhCKOvrsTVWFJ6Qaayg8LaSOj+5Qas2QA0tOJhZIhZSuR7jf52Pd4SY82cR2bBL5runQrrtVsUT4n/f/bOjYxISoXVxbWFz7adR5L5/bMnt7dkxFDi60BcsmNPYzadTjks0rYf4deHJ5JkNemmYcdYly9D4OaUj0HG8l0P1wLCn6ZZhG3ZpWCoGB2pBXzxSmznLo8S9VVgM74c30crRxMY/xRQbVlbM04xwtX2MhpQwLc8e7g/oOY/YlA4Jj4Om5J8Ry8NUJMFMpxIS5ELpn5m/aVdzVkYRBDr+L3vB1KbiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtgV9pQo7Rp/QAcOy5d2lbjUZaDce1z+4k0dDKnRRg8=;
 b=O2cuO0Oj9O4Y1+tU9skDNPhGtHcYSvnG/SJgMOT5wpWmKzWeNaaBZAUGl43PsFjsYTHOooePb6TLZ75IhnxL2j6+E35D6q/N9juDysEuus36KlO8agTVocCn64ZZdZMPQtcm6LbEryXKfFa3qvoOqn3kP01L1B4m35oRuP0lVrx33sSCsNIl2thxj0jNai7V60nUL48mar3uC69ACS+QvBL2BGxhURDqrPP0WshqWkWxL6vXIspW6TzPcE1G40SBjWzoOBbMHU4Gl/TSHJShluQF/0mbL8iWL0FXDLDnoi+YEHAqi3g11am1FuZSfrvs0HZKXSWvOVMja5UwWkjbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtgV9pQo7Rp/QAcOy5d2lbjUZaDce1z+4k0dDKnRRg8=;
 b=uoigNpcA3z7teKntvMfDIbVTrQAsF8Dc6TpKqgidKu8AtOpl5tC2SVlXwwQOY/mPk7nDyxgv2RpbGmj8u3mF13h8brBF4VFKW2xISvFaJ/vcGmIc/jLpcvGQBiNeOcVV0iDuYnMY2Vr4DaW43TNZJG+h5HktLXTn146aNnMNPyyZYqrgk9psJ/V42kXJ16KZcHyBby8Y6OAUdsGTH7D8Nx1GasOggaQd8sGmmhl3WLaLLn9ZKfdItd3pQB4g1a9GFcu0AX+DSe1e1tAg1b95cILRcGpyG0+OFC642lm87JOGg6bab/re4jyw9iQ4aUqEr5bFRxuHxb6zknv05EWxKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 02:12:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:12:28 +0000
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
Date: Mon, 09 Feb 2026 21:12:25 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <71370B54-A462-4F72-AF82-8E076AF112FC@nvidia.com>
In-Reply-To: <e69270cf-dac1-448c-ace8-3f789e5cdc6e@linux.alibaba.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f9e956-fc37-48f4-04ce-08de6849d6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1dPR2dxOTMxUy90QU1NOUxlWm9BVk1FT0ttMFJJNG5sVHk4djFnaHdqTTUw?=
 =?utf-8?B?alNTSXJmTFdrOEVtNFA2bGpmMDYrcFdLUmZIY0xUcG1GQkREYmQzVFFOVU13?=
 =?utf-8?B?akRDbHNkN09BN0c0VGZYV21BSXlrSjhDZmlaMy9RaSsrODd4Sm1rUnR4cVR5?=
 =?utf-8?B?dGVnanNvYW9hMklmWmwwTkRVWVV2YzQvaEM2VUZxc2pobGpPaDRhNm1VU2pU?=
 =?utf-8?B?Z1M4SHRTSzZMMVlIcEJFOVdqRmZseHJGeVV5MGYvMXpRUXk2NnR3VkQ4d1lt?=
 =?utf-8?B?d3RxUWRhNUpJdE1yYldxU3JRMW43R1d1eHk2dUFHT1JyWGVqQVJubDFMa0VC?=
 =?utf-8?B?cFVlOUh1Vlo3eVdmdGQrc3JaN1JCSkg1bjBpd1pFOWhPNitKVVdJZjdyOFA2?=
 =?utf-8?B?aTVCT2Mzb2x0Mk4vQlB1dlhDMmJSWnJtWERWUlVUQ0VtZERxMUxycWtxdksv?=
 =?utf-8?B?TUpLLzI4RGpDVnBxT010WVNNdi9GTEsxRXFaNitJS1g0VjJJaVdLMmtOL210?=
 =?utf-8?B?VGZJcWltM1V2YlVQMWlzY0ZISHkzalkyejhwb3FGcWpsUUhOSVlmSFhVc2pw?=
 =?utf-8?B?eHRqcUl2UFlzdG1PTCs3SXRvVHh1eldUaTZPekN0OVN1VWhwNnVMYzdSMUxj?=
 =?utf-8?B?NHNFK1cwaG1sRUZoY1YzU3lBLzI3YTB2RlNyMnErLzdCWFNTOFVMZjE1b0VG?=
 =?utf-8?B?RWZZcVpSY3pnRGNRb1JJKytjSUJTSnQ0RUl0TzJVYVgzcXFPSnlHdUlyYW1u?=
 =?utf-8?B?cGgrSDBHaWQxWUVxa3VkREdtRU9FdDgvbmR6V3MvL1JmOWZxdFlTWjlhQjJk?=
 =?utf-8?B?SytweDVtWVpWWHhnL0dYVVdySTd0MHltbmlDNmJiWU9odkYzU01tRmtlSUtG?=
 =?utf-8?B?RitTY2JML2ZMUHNCVmIycS9xMSs0M2hWaU1zemdiV2k3elY0Q1E2LzRRUCtt?=
 =?utf-8?B?TlF5bG02Mm51TGtjdXZoVVE5UFoyTzdtVGwyMmVpVEE5cVFhSmxsbTRkWGh6?=
 =?utf-8?B?SjFnSVR2VmVQODhubld6REEySGVZYytrUjYvaFg4QkFDZURtemhTSGszSEdC?=
 =?utf-8?B?d1ZCbmgwcGhPNTNVNmE0aTU3RzZDamJuVS9ScFV0Rk43SU5temV5MEZ1dFBl?=
 =?utf-8?B?OWZxUVZBM1lvNkduMW1Vc2xheTl4bmJsVU4xWTk2eERsOVlpckc0UWI3K0tH?=
 =?utf-8?B?MkdGQVZLbG52eDFhZmtBdGppbnBlSGdlV1BKUjBnOWwrVlk1ZmNOd20vYWs2?=
 =?utf-8?B?WkEvQ3gwNjBieGo5ekdkQ2ZlL0wxZXloRXpkWjNLKy9wL1pWMk0yMWNSRWlX?=
 =?utf-8?B?aEpMdGRpY0piWHFwREEwV0NJRllSTnZCeWoxaTdHSmZ1aEdraEhmSDh5ZFgv?=
 =?utf-8?B?eDcxN01oRWc2eHh0TXUxZTk1ODlkRTk2dHJrRXZsa1drWWw5WERwZTVyWHBF?=
 =?utf-8?B?OTlKY1ZVblYzQUZma2xEMDJjUjZlOGx2TXI0L0d4YUNzM01IR2hDQVZCVkk4?=
 =?utf-8?B?TVh1RTF5Y1NSY2JwSitkclRVR1RiVUx2dE43ekVnMzh6YjA2KzhLbWliUWNK?=
 =?utf-8?B?Nm9DamxoNmpLRGtRZlNEdzN4ZG5OLzdtdEV5SlBQbHNsYjQrU0g2TWRwMWF3?=
 =?utf-8?B?UlYxZUVGOGhuOGduK2RQVHlhaXBxT2x3S0pTZVQzM0kzYXE3RVdOeVFlTWpC?=
 =?utf-8?B?YWNXZ2lSWTRrY1ZHbWVPVzBJZ25YcTdlcmx1Q0YwbTJVYVJyMlBIaktSTHly?=
 =?utf-8?B?bllvWGdaVzFxRlJCaUoyK3JDUDRyVVEzLzk3UEhJd01CN0x3NEsyMmRCRkpr?=
 =?utf-8?B?WXJqZDlWMkxod3M0cFlDOEdVeURtOGU0ZkFmT0R3eDhoZ3pnTVRvaUJaRk5x?=
 =?utf-8?B?OUpxbmlpYU82VXdHay81UEhrVlovQVVOM0F3dGFlYjdpQkJzMnd5THVIdEVM?=
 =?utf-8?B?TlNzSVJGRmN3MTVqL3pLTVhtWHlZVFc0RHBPcjd4MHBBQ2lSbWlyY3h3aGlJ?=
 =?utf-8?B?TWpCOGZCOGpvU0N1NFNETEczVGlNSDNJZGhSL2lhMlFNd1p6Y0M5R3hWOEZN?=
 =?utf-8?B?KzdzdnlLNFdBWStLSzdwWHJxOEFFVUpPNUcrTngxWmNZWlJvNWI0QmIyK2Vm?=
 =?utf-8?Q?4zTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZzNlZEVk43dERPenBhem43ak8rRkpVK2JnYjhRVG9qYXUvR3hxN240Y1NE?=
 =?utf-8?B?UENDUnNzNERYTHlGdElpTHVlakFkYUZqa0haa08zYXB3QlNqSFhPRkU3V2o0?=
 =?utf-8?B?SUp5SEFKUmtoUkJteWJYb0poSFZ2QmllRXVFVHZTSWk1Q1d1VkE3NFltd1Bt?=
 =?utf-8?B?UnB1RTE4aDQ2b2luWEZjOUs4L2tLb0h5ZHp1Wm5JRUllUXdVUzFjakg0ZEl1?=
 =?utf-8?B?a1lnVC96SWxza2xscFJmVjNSa2dRYzBlR0RtUWlJK1o0M0cvcEdvcWFDQmhP?=
 =?utf-8?B?WXpLbk9GeDNpbmJMSDBGS2t4dGEwRjBSMzZIQjlRSjBScHN1Wks0RlBhVk52?=
 =?utf-8?B?a3dESjFtSDNQb3NUbjFnRTM2ZnZEamZOenBRUWtyYTdyVkdSR3lLazdKQUVX?=
 =?utf-8?B?a21GYjR5THViQ2ttQmZ6RlBiSk5sNjA2WEpkSW4wVkVnaUVwUVh4eHhEeHov?=
 =?utf-8?B?cVgxeTRoajYwQXJFSTI2djNNVTdZYzYzVERiNmErNGtGV2hpc21MWEtMTFQx?=
 =?utf-8?B?NC96Z25WQ0d2TStISzRKZGdFczBiTm9TVnNJRklpQ3ZDTFk2QVM4ZTdsYmhs?=
 =?utf-8?B?ODJjUVdPSHNZdGJzSkpvTEMzWitnbldNbTNFdlllYTlNMUMyTDBXbmVRYU1N?=
 =?utf-8?B?akxmWmg2YzlpWjduUXY0cEMvc2E0R0pGRkl4OXZZNEFTTGc4RFFVMzJ3S2JE?=
 =?utf-8?B?TzVBYVpUVFpSdkdRSEJWTE1MemdFWVZpQWdROC8yRVY0bVVFaUJHc1BhZy96?=
 =?utf-8?B?OUNJSFhFYUs5RlBZNFFKc2hQcDN0Sm8yek5ETGlSaXNRSFk2V0FNeTN0MjRy?=
 =?utf-8?B?a3RCWDlBeHA2RkxEbjRmdzhLOE84R2lseDVQb3JRdGJQT3I2WkpBSmk4SU90?=
 =?utf-8?B?M010R3ZIMTVqZE5VdVJqL0VJbGVDUzN3akZKQTA5V2FsMGc0aVBvWVJIbDVS?=
 =?utf-8?B?SVBGTEE2cy9PRjFBWmdjNGw3TWZsKzZ6UHNhNnU2N3lKSVl6UjFqNWpNbTJq?=
 =?utf-8?B?SDF5RHg5c1lObmo5RDNGb3NXZzBDaE5WcGIrMEpjSjl3ZkNHN0lNSmExVG9Y?=
 =?utf-8?B?R0pZSUZ5a0lQZUkwYUlhVXFONG5zY1dwTFYyTXUzdWphSDBqbHc1SkUvTDlZ?=
 =?utf-8?B?YnNhNWdYbWIxMTcrdGx2aTUwNEpPdjFHRkRoZWVGR2lXeGwvYWR0ZWZVc2g3?=
 =?utf-8?B?OXVackJwNm13TEt6Q2NqUmxMYXlZcVBHNk9VTEM4SndHRmtuSHNJSlVRVkYx?=
 =?utf-8?B?OS9rUFNBTlAxQXBvYkd3Vk54ekZaMnBWeWpKZUZqZnorV2xoNEpONmNoUm9m?=
 =?utf-8?B?Q0hYZlJHQVNhSG5DWlY2WlFoTHBpWnBvelNHcTVseVFEUFVrZmlBeDJkRm1x?=
 =?utf-8?B?RWc5VWs5eUFQNjdJSExFWVFsTFFEeEdrSHhWRXMyOWdCdFc0cTdQWWk1QkdM?=
 =?utf-8?B?cEcxWFpSZDBNWks3WFQwVUdFVHdkZTdEWnhiMm1hd2xKQ3ZPTDZtRXBRZFc1?=
 =?utf-8?B?WFBLOVZmSnlTWTRCNjkrekh2L25IWitMeWJ3ckx0c01LM0pSZHA4bDZ1YTVn?=
 =?utf-8?B?a3ZMM3Z6dVpJYmhlc2pZNE1YTUZXZXVrMUI4Vk45MEdDclJocUlmaFRxRDVX?=
 =?utf-8?B?TkJETUVFL3FrdnFrK08yS3UzOGdsVWtpUHpQckRLemZkV0FCSDdMY2NER215?=
 =?utf-8?B?bjVLMFZsdUg0YnVxM2drQlQ5YzJUQWpFNkJraXlXV05RNlNmOVFhL2hSYjM3?=
 =?utf-8?B?T2xkMDZGVVI5S3BnNklYZE1INkl1ZU9wSU9tWkRjNTJtcGdLTmJHZzlZZXQ1?=
 =?utf-8?B?dUFHMDN5eU9PQmN2bWcvcmF1MVhxTTdhWGpRa2hBd05qRG5sQ0RraUEvVjZt?=
 =?utf-8?B?TlJEbHhrTXRxb1hTaFJQR201NlNtbTJobGo0VG5PWC9tK3c5Z2dqS3cvTEsw?=
 =?utf-8?B?bW1ySHNLU2dMbS9ZMWd1aDNqTUdicThCeEU1RFBsVjYyNGRaSFNKZHh0bWhT?=
 =?utf-8?B?WnZxemJkeUkwM0t5bnUxY2I5dkN4U1dRcEpLMEdoalNCVVpXZ0c3bjRocVR3?=
 =?utf-8?B?Z0FVcElMZk9tZ0VUdDZma3ZjTTFlNjlLdVFFR1pHQlRTTlhpRGtWNE9hdVR3?=
 =?utf-8?B?cG1vb1VMc0dBVjk1VHVMczMvbzdFZnBnaE41WmVmMmx2d0tMUW5hMFpaUW51?=
 =?utf-8?B?Vm9XWWc3RFZEYXlocjlsMEMrNHRlVS9KcEphZVVsMXhYUE0zZTYzNE41RzNB?=
 =?utf-8?B?MDFRNzZuU1UvV0JLdmFERkxNYjJVVVpkOXJpZmE0SzdBRGpSRmtXNjhCbm9p?=
 =?utf-8?Q?gngucnczqt7Or1LCLh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f9e956-fc37-48f4-04ce-08de6849d6c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 02:12:27.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1vJvcy5uKRnYaR6zQjp2eeJuSRcnnFW1WaAtE0GXblPAWEkMbclXVRsHxKfyzi4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215585-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: A47B8116309
X-Rspamd-Action: no action

On 9 Feb 2026, at 20:20, Baolin Wang wrote:

> On 2/10/26 3:42 AM, Zi Yan wrote:
>> On 9 Feb 2026, at 14:39, David Hildenbrand (Arm) wrote:
>>
>>> On 2/9/26 18:44, Zi Yan wrote:
>>>> On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:
>>>>
>>>>> On 2/9/26 17:33, Zi Yan wrote:
>>>>>>
>>>>>>
>>>>>> I agree. Silently fixing non zero ->private just moves the work/resp=
onsibility
>>>>>> from users to core mm. They could do better. :)
>>>>>>
>>>>>> We can have a patch or multiple patches to fix users do not zero ->p=
rivate
>>>>>> when freeing a page and add the patch below.
>>>>>
>>>>> Do we know roughly which ones don't zero it out?
>>>>
>>>> So far based on [1], I found:
>>>>
>>>> 1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (overla=
pping
>>>> with private);
>
> After Kairui=E2=80=99s series [1], the shmem part looks good to me. As we=
 no longer skip the swapcache now, we shouldn=E2=80=99t clear the ->swap.va=
l of a swapcache folio if failed to swap-in.

What do you mean by "after Kairui's series[1]"? Can you elaborate a little =
bit more?

For the diff below, does the "folio_put(folio)" have different outcomes bas=
ed on
skip_swapcache? Only if skip_swapcache is true, "folio_put(folio)" frees th=
e folio?

Thanks.

diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d..546e193ef993 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode, p=
goff_t index,
 failed_nolock:
        if (skip_swapcache)
                swapcache_clear(si, folio->swap, folio_nr_pages(folio));
-       if (folio)
+       if (folio) {
+               folio->swap.val =3D 0;
                folio_put(folio);
+       }
        put_swap_device(si);

        return error;

>
> [1]https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/T/=
#mcba8a32e1021dc28ce1e824c9d042dca316a30d7
>
>>>> 2. __free_slab() in mm/slub.c does not zero ->inuse, ->objects, ->froz=
en
>>>> (overlapping with private).
>>>>
>>>> Mikhail found ttm_pool_unmap_and_free() in drivers/gpu/drm/ttm/ttm_poo=
l.c
>>>> does not zero ->private, which stores page order.


--
Best Regards,
Yan, Zi

