Return-Path: <stable+bounces-224594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0DHAeesGkflQIAu9opvQ
	(envelope-from <stable+bounces-224594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:41:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA412259080
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 443DB31E3706
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C763B6C0E;
	Tue, 10 Mar 2026 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OLh0befG"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37493B27F7;
	Tue, 10 Mar 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182405; cv=fail; b=ejTiijOFY3lo5jMg3PxREQDsrKL7qkaml4r7jYtGKBbB5sivi0nmQuTVBJAdUWkyoQ57mtCk/kU9708fSVkkIxlJkVTyOVU1juSX+OP/xlo2KumqQIcNNAmjZDAhf/hQyQ2/KZS0yECZQdefXtM9WASl4kBI1n1mgRVzxDNHqLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182405; c=relaxed/simple;
	bh=HnrCLdj6RygG0EoO9wwK9H/c8JLj1gr6ZH/6MSUtKeQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHWxZ0XLcUqz4u9UHqWsPIWhHJG891X9NwQ/VoJLE0D5NrnT8ANjB8DIz0YUTM2lnHeSPgHBTWUhEfQQi29udlBJofJYYIkrKGmnjnJQCJh3LLhmLb3jc5z6VLpHYRuexxVwHkN78sP/fACnYBlb9+6+ywXESt4U2VKR/EyNHxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=OLh0befG; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6FuBQTZVkw6lglQZbZt/z1EmdG/mFVt4TKI9z33VTEjNqO5EZhTJJ9QD3G7M8u862dh2j3Nr685tmvPF4E4RSS2JIucppG/0d4AIFMrSJ1bXxTu8MQ+nbAY3qnL+sjihiZol/Zu1W9pGAcfDiyB/S6P5DLf/oXGJMrKBCsCKW55jYUk+p99gZEISD1Y7Dhqfr8eOA9igocwL8EE8rvRtTL03YW0H0zx2OQh5PBBU5AQ6CqrI1/Cq/a20F6MLQigB97YfgoqGRrcJG6nH5N2m2vSA1q6zPRRULksDQw1luEURVtT61jamdF6p3JL2d3+aYSojiMlJpbGscp4AHSWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5ya/14xemD/FSVbl/3h5BjXqa8QljYPw+uZsXlmhvw=;
 b=CeyqxuDd9d2EwajTtPP7/i2FyWwTlaa3rhz0vp9Y4Z2AuCqgoQSIHxAQgq4uH+lvh26ic0eVjrKEdBUhwYAVfLKITe9VNB2RNrOksWoYHn2QeoYCTBxqjNwea0a65Xt7GzwW1rnF0IVqqeHSfjLeeVO9IKbNBeAYTswo2o2URVkVI7fyLwxDAlGDBwK8Wy6JMa9LWJ+n7cfjolLdLqmszeOBtXfraY67/BDT0MLMxg35NfZo3zvuOtuGuI70IwTkwUGJzfhfe+UmExbpwVIlFdc56hT0UUeQLzO30YhRWls1uIzBOgLevgAIojwhlNuVMhWDuLuIHxoxxwO3qsRn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5ya/14xemD/FSVbl/3h5BjXqa8QljYPw+uZsXlmhvw=;
 b=OLh0befGjmqooOT15+f6FYL3ssxtC8tCGnpIE/bGkf3niQsZWm68QvF385ug3uFfVMNALkBovNip2OiFvErwOWvTvixRQz80wSdHmxEHDRlcnS+BUMS2g/NrdM/RZEVrU8is3v9cwnarRyg/4fIVwpsLzYj9ub6jXHDa2WeNqMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SJ0PR03MB5518.namprd03.prod.outlook.com (2603:10b6:a03:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 22:39:54 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 22:39:58 +0000
Message-ID: <89f34cfe-7b77-4f66-b3ed-8104c5b50eaf@citrix.com>
Date: Tue, 10 Mar 2026 22:39:48 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>,
 Kai Huang <kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Huth <thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Kevin Loughlin <kevinloughlin@google.com>, Zheyun Shen
 <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>,
 "Ahmed S . Darwish" <darwi@linutronix.de>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Wei Huang <wei.huang2@amd.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, wangzhou1@hisilicon.com,
 wanghuiqiang@huawei.com, liuyonglong@huawei.com, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, xen-devel@lists.xenproject.org,
 linux-acpi@vger.kernel.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_acpi_id() on non-x86
To: Bjorn Helgaas <helgaas@kernel.org>,
 Chengwen Feng <fengchengwen@huawei.com>
References: <20260310175305.GA730372@bhelgaas>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20260310175305.GA730372@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::23) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SJ0PR03MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec7f3b8-a59e-49fc-4842-08de7ef5f52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0uGaJBptse/dAAqoo9odz6TEboL6x1eofnu0U5I34ebOa2ydcGqAcURoHxeqKeO3q62Mk5AIsz1uGpcRUD51NtKqNO+im0qexd9ilZKJZwf/sVWbvl9FkuGXGlAR406DyLp52UojePLAqEJKSJJpfuOlxgOnt0mVBkxJN6z+adZXzeuwWlSNTcE2sm5+Mcbo8rlNnBVBK6m2P7UzW2lI03Yai/YAtCivMkx7lshvcpmyQU6beOumt/PhWTn9VavQB6dxRkuFDRldT2anaLSy05shimis65lY/86L7Ph65C0dcQnAikX35j9vq3YffbG+ewMZatuwAvx+VS5mkXNpysipAZE0tCOIsJzprkl2htuAgKHB26cB8Iphxp8mgqHxR/pPpGtfkwbzfEm3umXlA6fyULummSFXzgYr0RBrckPf1CMtH3ML09mhbi9mhxjQUH34bLVxRTXGehvJAOmtHAO6RfZpxctAwHNM7zamEqCkqE8aE/PJuIGvCCiPOImsLdYDetUwzZ0rJHdApQ7O06VJcFegGh3y7W+1o+C0nnQmgSL9PsHd47dg7WEAMnQnNAAWK2NFmnJSgh0YtqnNlIPSgpV3/MKdVTRjoYv+CLIJEvylvZsytoZVU1dHgXCtt+w4UbfdU4HvNSO7E6+tC4V2GQzuo7Q8QClKdx2hbNmPlsDsaLWFnXZqMhwKxEvLMBFb6gQv2PJC14pljFl2sByALSYynly2akYCUwJFGmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5PbGRvSzVOcnFMOTR0c3hjbVZuNnZ4emp0MTJXcldGRDRRc2JyN0U2R25n?=
 =?utf-8?B?RXQ0Qng2QlppaWt3N1Nhckt2WS9TRHNkWkJYMVcxQWpzeVNCV2lkanhUajVv?=
 =?utf-8?B?eWpIbEF4Y1FPMzMvVDUvZFRia0I3M2crMTlEbGplR3VLUml1Ti94aVlyY2NU?=
 =?utf-8?B?b1MvdnJ6Uzc5S05uUmZPbi9NMzlQYkRuMkpSbTRCK25kMkwzQ3A4ekFmb1ky?=
 =?utf-8?B?NGJROTNkY05lZnZETVVqOW5tMlYzVk5HWnNQc3VrUkZ2K0xaRkwyVGpmQkl6?=
 =?utf-8?B?V0RjU2NtN2svclpta3FJa1Y1WGVyN01tQVVFelgrbENrcDdad0lLaUExbnNn?=
 =?utf-8?B?cUpCUnpVN3BCQ0kvRGdUYlhXa053aFlFVWVyVk5KejR1cWp6bmxNT0h1WXRE?=
 =?utf-8?B?QjV1L0FNdGhKNlR5QWVZdEZObHliK3czeTFlMUFUbVk5eHZXLzlyZHJYbTly?=
 =?utf-8?B?UFVtbU1PUVZNU2w1RjFUY0UybjRvbVFFSHl2L1BkTlUwKzlhakoySzI5aFR4?=
 =?utf-8?B?SHNySnJTNXZ1TDNLbDU2K3hjdFFpeldidUNFaCtGRFc0RkxvMEV1M2lHbjRx?=
 =?utf-8?B?aWx6d0ZpSVNudDdNUEk5amI3blo3cy9XNzNFZ3BTU0hkK01XTUJ2MUlabk10?=
 =?utf-8?B?N2x5b0VoZUh1WHhLV3o5dW1LZ2Jtb0RvOW94a1J5a1BBODhKNWpZRnZ4S2xH?=
 =?utf-8?B?WjlvdEdteWUxRG5ZZnVnbmUvYmE1bHBEciswOW1VbFREbzFlWksvbUJZRno5?=
 =?utf-8?B?UzFBU0YrVjROdTN0NnkrSXRtUFNuSFhNSE1KOXRTbXc3VUVoNUtWeEViclNa?=
 =?utf-8?B?d0FRemNqMGhERnZVaTAvMzQ3cFozNWtlczE2UVN5Sk4xNklPZkZkYTAzL2Mw?=
 =?utf-8?B?YjVxbXNTVjdBdTZSYVprQys4U1pZeUxlVmZ5dXY4S3N3U1VaL1FBazJHZ1Zl?=
 =?utf-8?B?R0ErTi84MHdlSFh0bENQS1d4d1NMbWdaci9SSkRPcDI1NDM3QlZZc0I2b1g5?=
 =?utf-8?B?UjFxbTRKVnI5S1dIclZXNVpMdVdnVHdQTDlreXlQRTdIcDQ3NGFwL1diY1kv?=
 =?utf-8?B?eHR4eWNOd09aNldnMUdaT09BOWhIQmYzM2VYTFVsQU8rcFRQdGdsYkloZkVR?=
 =?utf-8?B?NU9qRWlCYllPSmkydXFJZTlITHdKcDBFR1VTT3VUcVovcXJ1RnlCYVlNMlJy?=
 =?utf-8?B?V1RwMXNTblltZHZ3bzFnSmhRMEF1Q2JoM0RESjhYNHoxclVXYkFYZUd6R3oz?=
 =?utf-8?B?QkQzK0FoQndBRHIyVzl0dHJBRFByWUxZTXdpdURzSVNReXlXQ1BmZTBWVW9L?=
 =?utf-8?B?WmdwcEpXaU1KektuMFR2ZUlDRVNQelBPbDMvK0xRMTFtRzNHeXA3eEhQSm4r?=
 =?utf-8?B?WFNGaHVWQktaVTBzRmpmUngvMWQ0R1hGOVlnRjJ4Uk9Qb1o3Uzd0Yk9SUjlr?=
 =?utf-8?B?VGw4QzBKelF1c05LYnMydEg3ZE1odjczR21WWllIdFJjc3p4M0ZNMEN6MFNK?=
 =?utf-8?B?N1lrVXRrK3JvVzdVRUcvSlRMWVhFVFpiZDJ3UW1Ob2dkaktvL24zeUFKME8r?=
 =?utf-8?B?aW83N0dMWmhhUlIxMHRoZWY2UzlYdGd5L0ZHajNFaGh4ckpnblBVdFhJR3VB?=
 =?utf-8?B?TGx3djJITzJlblJXM1hBRFAvYjFjZWU4VTFQNThzbXBzSjBpMzErNkdCa25Q?=
 =?utf-8?B?V2Qxc1BPRDdBQkptbGxDaG9YSktVL09DNmV0VEhCTjh5MUMzS2dxV0pFVkpI?=
 =?utf-8?B?TXJTbGc2K3Mxbm5WWFFvV1JJdU55ZHl1bVg5aVlmQWkxUTdqL29Ra3Eya1Ny?=
 =?utf-8?B?eVlZZHN2ZWxabXZsdXFkSExFcUFYK0ZqQ2w2MFZ2eW85VGk5bjJ5bWNYZWhR?=
 =?utf-8?B?Z3FFV200Y1paTm5LV00xRnc2SnVCT0IrMDRkNlYwQkNkSnRlTEZmZXNWNVBK?=
 =?utf-8?B?NFdGdDIvRlEyZWlsWXVyd3lmeG5VQ3NERDlucndkaHd0a1lQMVpaTEJ5Q1Fl?=
 =?utf-8?B?by9QUThVdG83a0dPTWdKb081c1BQczBEdlJoU3dKcmVCZFJCZnZicTB4MlJ0?=
 =?utf-8?B?cUpwU2lTaWJxaDRNVFpUVTR4NHd3TnZXZEFoM0VJaDlPaE9PdDRQR3pRcUkz?=
 =?utf-8?B?T0s1bW1pem5uSkV2SnBaZ2N1TldjU212N2Z3YW0rNGsvSVJhTVFOcHRqYmVJ?=
 =?utf-8?B?VHpZK0tZMEZFbDRYbVdKYThoVDY1aXJYTlgraXk3UkdLMVY5RnhmL2RNUXZm?=
 =?utf-8?B?endqSUs3UWhRbG5mbWQ5NUh4MVh4QzlRT1NSclNJUnRTQXNWNkVQT1hLWlJQ?=
 =?utf-8?B?ajlPN0t2R2lSVUJwbXpLQTgvVDRDMmhRMkVEa0JYanBWREpRcmNmdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec7f3b8-a59e-49fc-4842-08de7ef5f52f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 22:39:58.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1CHoC9U+cpBf9KaJCKXbaFHOUzVk/9lCW28q1CpouRGxDPSK3i9wKvtNhtfeZBolw2H3VZagHko59xaJlcwT2gvUMZSFHWjbUx6esRQymE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5518
X-Rspamd-Queue-Id: DA412259080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[citrix.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224594-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[63];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,citrix.com:dkim,citrix.com:mid]
X-Rspamd-Action: no action

On 10/03/2026 5:53 pm, Bjorn Helgaas wrote:
>   - Split the x86 part to a separate patch and maybe (a tangent, but
>     looks dubious to me) figure out whether/why xen needs xen_vcpu_id
>     to be ACPI CPU IDs

This is an unfortunate mess made decades ago with no good solution. 
It's to do with how Xen and dom0 share responsibility for the system.

Xen PV dom0 (only, but still widely in use; ring-deprivileging and
predates hardware virt) is OSPM for the whole system, seeing the real
ACPI tables but with a number of vCPUs generally less than the whole system.

This causes Linux to have a split idea of what CPUs are, held together
by hope and duct tape.

Xen PVH dom0 (hardware virt) is OSPM, but has an MADT matching it's vCPU
layout.  It still sees the system DSDT/etc, so while this is better from
Linux's point of view, it's still not great.

Regular unprivileged VMs get a fully coherent set of CPUID + ACPI tables.

~Andrew

