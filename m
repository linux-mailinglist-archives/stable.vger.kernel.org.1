Return-Path: <stable+bounces-158568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80083AE8589
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6396A680234
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E9265284;
	Wed, 25 Jun 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MNSZiauL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA213D53B;
	Wed, 25 Jun 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860211; cv=fail; b=JWhHMZDSPAp7yBkHuUMZ8O48z66sA3I4fg3BmkuQhgMtwtAHjlPWzxCiOhEg048j7DVqZZg7CDVk9+k3jKKkroaUf5QzTjrt0Ah+6Coc8H10u9ykjKFJCHbOP4IistunZRqHgywspxMTHSPolwmAAuGsFcNlQ5Mck59iZVVVHrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860211; c=relaxed/simple;
	bh=8nb0gu4lZPozZ1XHTZiNy9T0HeAFw4xMCd4xJ/m5lVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgWgRaxd2OcTH1CeHTgS7YKNYmg/BM7BTduf9eETb40Z/Ukgu9KzcH9JFG4qcqJ9jbL7ygA2BWmJ8eK9yppGF82WujY6001UAU2OpFuYdf1F72/mDhWaBtG544Cspw1EFrq2pJdgWnHc61W22CWxjDz2FYZ3L86BmIii4JBrcYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MNSZiauL; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqfVRVe+suZMHBDIc+gbaRlQss2vLdcmkmWB2A3kWKlRE2KMUAvrNjLJ/iTQMutZhTujHyKBHJsPKO8oLZXUragpKFFdwEi/RIN6BltjEG+Z4J8u/78iBl/VzBoOpUnECbrYeGOurR2RNZ4fuBfAPpQRE6GPcvwzzqIvL+pLVn+Er12mlF3p2xRbK1qIYi+FowlyxggvkSxAmErSIewGjzqjS/SCtSUYsgrmTdQj96MudB1/HC3CkaF3ZSzvLWqP2sCGL7IEXQgdhmhoQ2i8nWQjvfiTkw4jVEIFTllbUUSPSADc+1iZgPlYfmNy6K2vqFiw+ab7k06yLi10yRhA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S4aUN/5jbpfJZPc4KFHkZBikG148uaIUtN4YsB7muc=;
 b=nPI5SADPt0kOreUHZAMFATmC3/I8KAatT9rWQ9eFQpk+DAoq+9dwHw9Rv7T3zpcrQC8dFt4aOyjAWL+BUlkH736eKMeeZPzw4lcBcvRQfAonDQjQNj0Z3QradvXX1JoZoXd3NV3it4eC/f75RlzaWmpd1UAy0dkS7pTyWFayNBfuuTnHsBoEgK+U/BcTmHbUPUSUFG2u1jDkkb4Lq1Uttn8ujFnPBWdlOkZ467gLHAJ3+DaAkwWV6I/VIiwkgi54hLSCTi3ChXxiaVrKoz4LnRKVLYLYCQ+bON3kaJVjZu4IaS8FeFh43/+kUZqz9rY1p47vQFp4OVXPdFIVKMhi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S4aUN/5jbpfJZPc4KFHkZBikG148uaIUtN4YsB7muc=;
 b=MNSZiauL1x8c64ODgo/XgSuWuq8pt48P0vpPV8k95yLikcUg/r1oSFpg7/pno+3CPgoKXenjo9i1UEZdHi2MynfzCz91UjGUM4gxpoW3ex/YFjDEJh3A7IAd5p0z2Gc0R2aSWsdG8ec0O1FskuT28ww2tRuQeuYO8NrMZyWmglU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4SPRMB0045.namprd12.prod.outlook.com (2603:10b6:8:6e::21) by
 MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 14:03:27 +0000
Received: from DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78]) by DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78%4]) with mapi id 15.20.8857.019; Wed, 25 Jun 2025
 14:03:27 +0000
Message-ID: <457b00a1-ee0e-4435-9066-8ba587484e0f@amd.com>
Date: Wed, 25 Jun 2025 19:33:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 aik@amd.com, stable@vger.kernel.org
References: <20250609080841.1394941-1-nikunj@amd.com> <858qlhhj4c.fsf@amd.com>
 <CAAH4kHZPrDRF3sZ2GxFxMeue3o9PsEL7p-j8bKL2mxgBjR0ATg@mail.gmail.com>
 <8e0807b2-eef5-4172-8c9f-3e374a818344@amd.com>
 <39c23b91-6e5a-033c-e000-c6926b1ea1e4@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <39c23b91-6e5a-033c-e000-c6926b1ea1e4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::13) To MN0PR12MB6317.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: d36d9928-f0f6-4fd7-0ef1-08ddb3f10e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0U4NFRSY244Y0g4cnRhTkZya0dGa3VramY0Q1EvL3JyMVA1SER4dVZoWkgr?=
 =?utf-8?B?TlYrUEZZTG9TbTNWbGJRTkw0d1RhY09tcldIVWRLZm15a2pyV3h0Rjl0YWFj?=
 =?utf-8?B?Mml2YnJ3WjNGTzIyelNwNVJQb0ZqUDJsd2ZaNHpPcHRoT2tBVk9kaEZwdlJq?=
 =?utf-8?B?OXh3VGZ3TWpZRWNhZktLYWpjdTlQUlErSHdUZythbUNGNThibThoZnNwQytB?=
 =?utf-8?B?R1hmelBJS1NaaytGdnJvUEJvOVlKcHdhRlRYeWhzdEwybmNPcUlFUFdJc3lX?=
 =?utf-8?B?dkNWQzdBWHdnRmhleWtnWjRmVHNDQzFGcnRaL3E4SnhYZHova1hNRFNVTDlV?=
 =?utf-8?B?ZTBjZDlSUHNQRHpzcGMwdzhkdko0WFJoTnZuRURMblVRRzlla2I2b2c3czk1?=
 =?utf-8?B?YitvMWpTS1BCTGFVRHNSV0hIWXllZkNlNE5uRTRjaloyR3I4dFdyMmg4d083?=
 =?utf-8?B?aUVUamVBRjJON3BVNFRPSFhhSVhXdDZUQlAzcnk1Sm50NEovRWQ1M0trcThY?=
 =?utf-8?B?VnJtMUJndEoxWHQxOHJsS21IMm03a2F2MXlnSG9DNXVYbzJUMjlPL3FBc00v?=
 =?utf-8?B?Q216NG1HUG1makN4Mmp5YXlaTHgzWDd5WE9nUTBsbVcySG4xcHVuV3hTRVhk?=
 =?utf-8?B?c0FxckNHNkNRck8yMk9VSHpXa0ZJN1NHZERxYkFqbWRpbDI4TzhCdWVVTnhQ?=
 =?utf-8?B?c1Zlc1lvT2FsZ1B6Vm43YkdjeW9PbXFTZy9mMVZPRkNHVWFmWjdOZzRacWNH?=
 =?utf-8?B?NlNZKzA1amV5M3hBVDBTeUNsRkFsYzgxWjVRbGtvM0NYZm0yZmZKRjNuY0JW?=
 =?utf-8?B?Q3BBTzVPNVp3ejg0cnVma3hMRWJJY1B4WHEzWlNOSytYbnAwVy9kQ2hmenBQ?=
 =?utf-8?B?c3lPbzJCUFJydk53N2w1MjB6bzduT2NseElhL05pRW9zcjc1Umc5R1pJYzk4?=
 =?utf-8?B?VWNUaTBCcHJqOWVhVnhTZXg4M1lIbDNNdHFyMFBBRlFOMmtaaEc4eUVsdFpv?=
 =?utf-8?B?MmZjNG1wWjRyc09USDZqTzdNejlpM1E4TUN2Sy9kb0N3Uk5zdEZENHA1YkFy?=
 =?utf-8?B?R3lvT1lTUkNmVm1jNDl4OXhhRW4xQ2l0VGRFc3ZhckJUYnI4bkJNeTJJc1Ar?=
 =?utf-8?B?ckFiMmlhZk42R3R2QXJUNTZGUHBVZmsrbGpoRURFN0IwLzhzUnBodGRuZmM0?=
 =?utf-8?B?VVdJV1J6Tkl2VGJCK1V2N3BPdm4zN0t2SXNUcXdvQmd0cGFzMWRhNERNS05C?=
 =?utf-8?B?ZVBoUXpiVUZKbEJoSWRKNFpzOEtOKy8vMjZZeS9kU010THYwUFBVMHpwWWpi?=
 =?utf-8?B?eERKTmZmUFJvTWUxZHFUcGxDcjU2RFkrWmJ3VlRvczhaVjZ6SXdNL1JmUEE1?=
 =?utf-8?B?NlhtRStrRTY1clhNbnZiMmcxbnVzR1NLNzR6YU0vU3MyUVN3dEl0QjdzaHJv?=
 =?utf-8?B?M3Y1OFhMUFJLcW1aNDY1ZkJXUnBGLzdLT1MzUmhlWExIMTRCNE5qZHQrWG1l?=
 =?utf-8?B?U3l2V1FhTzVVUUNxQ2VRTzlaZFBnaDZ0VUNPQzU3anFhZmpLSXY0aUg5MGVF?=
 =?utf-8?B?Qm5rN0Z3TEQ0VkhYYTZEM3BHM1JDZlZ6WlNlMXlZdFdtWUUxdk1DU2JvUkJD?=
 =?utf-8?B?OG1KR3gzWW52a3dSeURyYlZ2ZEZ3Z0p3RlJkS2krSlRqSXFkQ09Qd0kxemZY?=
 =?utf-8?B?bEhYY2w1VUROZmsyeDZETmNGSC8wREwyS3E3d3BzbnZQUlZnS2JxOHZaa3M4?=
 =?utf-8?B?S2xPR0V1a1ZQOWpNaEN4N0Irb1BpdnlEaUFBZmxYUDJJVis3czVCcG1FR0hE?=
 =?utf-8?B?RXVqbEFsbHNqMWliZWkzOGNwT2R1M3piZjYzNEpKN2JUa25hTFBWRDRVVlZt?=
 =?utf-8?B?UXllbHNMaWZUdGFBK01VbVNrSEdkYkRUbllSUGdiZVVDaThhRkUxa1hNWkIv?=
 =?utf-8?Q?hGcHwaTt3bg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZkaDcrRzFwUVoyT25NcEpSazFaejE0Q0tXOXhqMVVoSkM5RFJ4VXdkQm1o?=
 =?utf-8?B?ZmwwNXBISWsrakpybmNoWjlXTjEvbzJRbjBVbXM4bURDTkFHT3M2aTFuQytF?=
 =?utf-8?B?T0lyMURPQXRVWW4rMFluN0I3ZEZUajhYYlRrZ01ZU1lNWDdqRFoyRkszZGdt?=
 =?utf-8?B?ZVZjc2pUNC9ZVG91eDBCd3RFZ0lvMzYyekErVEFzODBaZnlhcjRtVDRxSGdF?=
 =?utf-8?B?QmZwSTBaTmRVVnVHRzhNb0NwQmtwcFBRNWZ5blhVRk13Z1JXNmlucWpob3VG?=
 =?utf-8?B?eGhHdHQzUHUrbHNNYUVpamRNTUVDNmtQNTdIZ04wRWlHRTZhQjdZWjQ4dG9R?=
 =?utf-8?B?eC94WDhCQUtOT00vNDMrQk1uc0hwbEZEYjJIV0FDalJPckVkUm5ZaHhadWJu?=
 =?utf-8?B?d2JTVjJZT1VGbWF5b1ZMUXBrZ09XM3p4eXZ3WUE1NU1iTFQ2aFFHeDN6VEQ3?=
 =?utf-8?B?VDJpREQvUEYya1FodDNGelRWbS9JVjQ3aUk1NElXNTRGeGlYMzlROThOY2NB?=
 =?utf-8?B?SmFlL09panNrVXZUYjdnell5Y0tHZjlVbGtHMlpQMnNGNXFFOXl4eExWcExP?=
 =?utf-8?B?NkpXK0VrMEZ5b3lySmEzQjNHdk1XOGlpNVpqcjlIclJDUlRGWGdEWTVPNWxv?=
 =?utf-8?B?azNXOExSOTVDOGNjd1BwSkN6TCt4SUpLUmpCRlhYRkFXeFJaK1FBeXVSQWJu?=
 =?utf-8?B?djFBYmpYbmxGS0lIYUNGaDdHaHFNUVdQNkRhS0FaTUVVZ2pMZGtqeGYyMG9G?=
 =?utf-8?B?N3hscFJFMjZXNnVKUTAxalZ6ZVhqaDNBcURUUElrbmJqUmdLTXlKRTJoUi9J?=
 =?utf-8?B?bDJhQTBMRzZMWE9sbHdsQWR6WnJYRlhFbjhaakVRSFE0U0RUTGwxcmluWi9a?=
 =?utf-8?B?RkVvSy8wbUJoUzNzYmpOdWRGem5KUStSUi9jQitzYThEQTNDMUt2cGxXdllZ?=
 =?utf-8?B?enNVRU5iL1Z3Y1VjT3llTkt5L2RDL1E1aVFDRkVEN2tkcXp5dkI2bm13Vm9P?=
 =?utf-8?B?RjBKYktDNkgweFR3QTR5QzQ4TWFjSGZMYTg0dWVlUG1lTEdDdXpTUEVocFAy?=
 =?utf-8?B?N1BUL2RUc2lCa0hjdW5wMzFDSmhKYWFvR3l4eUFtcjhuVVlTSm9hcVMwa0pB?=
 =?utf-8?B?enNJM3N3VXdSQm44SUdQdmlnWWNhNWRpSjNPQWRqMkNVOEp0SmQ4RnRCRE9R?=
 =?utf-8?B?aXhEYjkzZFRXRnc1ZVF1eUJlLzd5d0xEK0JjMHo4QW1PS2crYTNhdWU1VWFa?=
 =?utf-8?B?eEdZN3A5UVc2SC9JMUlrajhjczF6MVBacnhwbVBtbXNMYXVZdElMbU11VjNB?=
 =?utf-8?B?cWdaeVZXTlErbDVkU2I3Yzl4SDNZemMzbUFXT1Q4cXE4a2RQYjJFcW8zM25Q?=
 =?utf-8?B?NkhzSU1uclpJK2FLMVN4NVZMRjN5Y0tVUVN2K0JsU3JuallRZFFZT3Q0Q0pG?=
 =?utf-8?B?dnBRRUU4U0o1ejRMeFExNmRoNXViT0wxRDVkMzAwcTVsVnJ3cEhiTlZZQ0o4?=
 =?utf-8?B?N0dPckFJTERDaTBPM0JSMkgzVnRpNFJHY1d1eitoVTIyYUhITVhrUFpTV241?=
 =?utf-8?B?Z1FOdHFKVWMyZk91RldlWFpBNHE4ejhONW5sajVBUHFvbFN3aGdzUUNyWDI5?=
 =?utf-8?B?a1l2VnFDWXIwdS8ySEx5MGY5MjVMUlc3cnp6UkRwenRNTTNZQzlINnBNTzhV?=
 =?utf-8?B?TUV5bjMvUGFtMlh3S2JnMDVNN2xUbkFhQWUwdWtrclVjMkxGZFVpWFNOK2p4?=
 =?utf-8?B?djVLMXJNMFNJMnp5elFVZ0diTG9WaFBJcGpSLzNreU4wWXFkOW14UndIcloz?=
 =?utf-8?B?dHVaTDBMeTYrRndYeXBTajdmNW1ZZncyVHZ5RjIyWWllOXFlZmxqekEvMVBB?=
 =?utf-8?B?cjIrLytTRnd6eDhJNnBZSEdHNXdQeTFaWFE1TkRhc0N4cmQ3bjliVDJGakZm?=
 =?utf-8?B?ZE9PUmlMZzgrQmRBb0NWcUpLMXczTVRQU0tEZVBsOHBzRVZPMVQzejFvV1NR?=
 =?utf-8?B?ZmowMHdtQVdYNC9RblVLMGxiRGdmYkVaRjY5Q2hHNmJKaEJQZmNKWExCbGlv?=
 =?utf-8?B?Wnh1RmpVT0dsVExHckV1aG1vQTEvZGdGdWc0MUpPS3pJKzFsUWU5cHZ6YWgv?=
 =?utf-8?Q?ckZURsEGtZhF141RQo6Vi1r52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36d9928-f0f6-4fd7-0ef1-08ddb3f10e02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:03:27.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96cVeh+4oDJZbNsf55dzPCrmRHWKyAfaJ+eeLknbXBwKnpy3nEQOzWp6pmumgR8i10cseXEIdQwXU7vkXocxBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423



On 6/25/2025 7:01 PM, Tom Lendacky wrote:
> On 6/24/25 23:55, Nikunj A. Dadhania wrote:
>>
>> Thanks for the review.
>>
>> On 6/25/2025 12:34 AM, Dionna Amalie Glaze wrote:
>>> On Mon, Jun 23, 2025 at 9:17 PM Nikunj A Dadhania <nikunj@amd.com> wrote:
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index ffd44712cec0..9e1e8affb5a8 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -2184,19 +2184,8 @@ void __init snp_secure_tsc_init(void)
>>  
>>  	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>>  	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
>> -	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
>> -
>> -	/*
>> -	 * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
>> -	 * TSC_FACTOR as documented in the SNP Firmware ABI specification:
>> -	 *
>> -	 * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
>> -	 *
>> -	 * which is equivalent to:
>> -	 *
>> -	 * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
>> -	 */
>> -	snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
>> +	snp_tsc_freq_khz = (unsigned long) SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000,
>> +							      secrets->tsc_factor);
> 
> I would make any casts live in the macro. Although snp_tsc_freq_khz is a
> u64, right, but is always returned/used as an unsigned long? I'm wondering
> why it isn't defined as an unsigned long? Not sure how everything would look.

The unsigned long requirement came from the calibrate callbacks:

arch/x86/include/asm/x86_init.h:312:    unsigned long (*calibrate_cpu)(void);
arch/x86/include/asm/x86_init.h:313:    unsigned long (*calibrate_tsc)(void);

But as you suggested we can drop the cast here and securetsc_get_tsc_khz() should 
cast the return to unsigned long. I am trying to recall why didn't we do this in the
first place.

@@ -2162,20 +2162,32 @@ void __init snp_secure_tsc_prepare(void)

 static unsigned long securetsc_get_tsc_khz(void)
 {
-       return snp_tsc_freq_khz;
+       return (unsigned long)snp_tsc_freq_khz;
 }

And:

-       snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+       snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);


I will send an updated patch with the above changes.

Regards
Nikunj


