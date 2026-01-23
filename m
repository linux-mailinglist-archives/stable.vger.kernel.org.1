Return-Path: <stable+bounces-211360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBfFArssc2mTswAAu9opvQ
	(envelope-from <stable+bounces-211360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:09:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193E723A9
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B5A304E1C5
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767313502A6;
	Fri, 23 Jan 2026 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xxc5SFv1"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5E367F5A
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155602; cv=fail; b=AWrp/m0zBc6HNKShymRzcZ21O8cubJ2/p8eb0myIg97PdZmPkSkflyN+KM12zSadwWnkUo7sxGV3TUOIMxCDFVLcsr69ISiGEzT/oGA7mN3NQcM/hNtirXrDvCng/jj2jONAAqaHhK1MHD9Z69zhrLegDDTSAUZdickuqzc6RXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155602; c=relaxed/simple;
	bh=PLgorOJh3DzrCIdA8001n/MPsOGjcL6SxFt+zi4rKzw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cBYq/aKSY3MqdZTy1n4KU6eIRnA1Q/dOr9wlZR4c3bfa4oikXZCsDy1s6AcKpoI46sFgp1hp9kU+qW7UUgmmzsm57MJEY9H1dr85SZbGWYbRF6IfM9eLi/oozr3eaZIvjtjbOnphDmyw87ixK5wxI4yVF/YSSytODVk98AJo0gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xxc5SFv1; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW8+qW0MZ1MdBkSkOkWPcrZ+bsvCu+NhncZOPpOvIG0fTtWA1pDVa+5h+KV1NLVOKGnQO2cRw8Xjm5t7AvkOcRCKdqsVG6OpVgz4oW9AcEh5ddFekEPxDZRwpRucZQS0nf8Z2qz6kGLm9SkinMFwAaJzE0Eke1k4A0Hk72n2qJByCIKXEyBJ+6z1ZUpSu+DI6j9VhnglVskKit6WL+c4Dss6B6QS9Rv3VYqziRg7mvDuC4ZwwGEwTavZ8pZBsFl7U51jkVJ4cWY648HO5afg7CnBQIjNRqCGbJfQZvlNkL7Rr4e0nh7EDShmA6aG0+0o7zzpfY1biaBF7TFCsXORiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJpQMUN5FIfeV16OamXJGhjk9301ZaMd9ltgpRWcGw0=;
 b=a8C9nTdHPwQnAzlkRatXdEfM8Tap7d8B3wT3ZiUhbX5jB3C7Z/E7ZtUnRSvI9RVzYLK6z63zOVRGYUBXEV0A4etFIOBbUvSXES8UP+SuLhdCL6G7lCFQv8wcQ2vTzsheEpSyA9PH7zZTgVaqQp/SlEeAQrENgJTENCinIdRazdru2LEzSMLBwmKsJtj3a1hxkfY2Ekyp/8X1D3qGihjwpaLrfKR1DgMdoqQIuyMf8Ft5/fWFW+rjBEp+Gx1IytpJPdrUc5sPWlGvWJIcCaEWuCos1quE+gB2LA2/KW622nbI8VwCVJRhafFxOWnYLbD2he9oLCHmBl7HUu9KSp5uTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJpQMUN5FIfeV16OamXJGhjk9301ZaMd9ltgpRWcGw0=;
 b=Xxc5SFv11V/ul5fJBV4p3jb9sU+syfLF0EYmzLyHvcTfN4Xph0fn9N7DcXWNmDtK7wbIUJ/q3LFQr4vvCn5z9hYtyGjYSYf+ehHfzAg4TWr6/ApiPhn/1SdXw+KTf5nq20S/8VZIlS+njX062AdjcbZuV90UNN7ffQFDCO1Oprk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 08:06:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 08:06:37 +0000
Message-ID: <f4351b14-45b9-4207-b661-71e72280540c@amd.com>
Date: Fri, 23 Jan 2026 13:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
 <4882409.vXUDI8C0e8@timur-hyperion>
 <d2b50d58-9488-492c-a542-3708fe070d95@amd.com>
Content-Language: en-US
In-Reply-To: <d2b50d58-9488-492c-a542-3708fe070d95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: b37a5d0c-2ca2-46f9-040c-08de5a5654b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjdOY3NRTVFmUy9ocUlBd0pQOG51ZDVZWFFuaitJT09TRlN1YUt1cGpwYXho?=
 =?utf-8?B?bVlCckpidlNEaDA0NUU3NHV3dVRjWUF1Tnl2UmRYOFduQU5pang5Rll1ajB0?=
 =?utf-8?B?dU1OdHBMM2l1VnlRQktuTnVlQTMwZTZCTU1ySWttVitoTmoxV2ZOQkVyWG5k?=
 =?utf-8?B?VVUxdjFlTXdmREc0N0dDSVArQUFhZCtYTUxVQjYxWTQwRmg3TWxiOWNYK3NT?=
 =?utf-8?B?UWlEYXdLdlFBek1tTXE0KzBDd1p1R2V0aUtLSEh6SUpDUlRjbVRCby9YK0Uv?=
 =?utf-8?B?MmpqUkV1Q1poYnVQL1lHVTBUZ0tHem15Vi9MZTJiMmFCT2VaNE1ReXRWcHUx?=
 =?utf-8?B?eExjL2RUemhnTTlFYnRuT1ZPVVArRWJjRSs3OXJiMFc3RGQxc29UOG9GclhO?=
 =?utf-8?B?WEtGdGNVUWorb0hyMDBvNUhSN2NGR3MvaGMzQTdtSWtVMGhOVk55dlNPRlJ5?=
 =?utf-8?B?SjE3YmpidzA5NHpLY0pNaHdJeHQzMnBvdUR3ZWtxNUs5anlJZ2RHSkpDQ0g0?=
 =?utf-8?B?TEQ3Mk9Rc2ZnQVE1SVVOOElzcUtUaDlNZERLS1VaVnMwTHBZMENCRkREZTRp?=
 =?utf-8?B?ODM2WVo3dCtaS3ZuTzhWOTZCZjdRbGVjN0xtTUhqWFEvdnk4UGVYY1NVdWhk?=
 =?utf-8?B?TTcwNnZFODJvRGF1U1p0cHZObnVza09NeGR6eHltVzVHTDdrRzhpazdqM3RQ?=
 =?utf-8?B?bFBKcEgrTG5RTitqV2JhSmUwWEtWQ01WWHlJclhEb2hSMTVhRVRhWHRoZ3NC?=
 =?utf-8?B?ODBITWdhdmovRWFIcVBMaFRnRG5FMXVjS3h5Kzl1bTFiN2cyMUhVQUp4UVRU?=
 =?utf-8?B?NXFuanYyNFlENnpoRVBpL056eDgzK0FCd2h4ZW5qaU9LUWpPSDB0S05CZk5Y?=
 =?utf-8?B?ZXVtQnF6UlgweEgwV2R4REFqMGlibExscW5nN1FiM0pUM3BqRlVORDR5eTlT?=
 =?utf-8?B?Y1hvaTVSVVVhSGN4dXdXdlpJUGI3SU1YT1owRVdrcmJEUzdkY21QQnBlUExN?=
 =?utf-8?B?VlIyOTRyaVhkay90Nld5M3pybllla21OeUVuSi9rUk81dUI3WDB5M1IyT3VW?=
 =?utf-8?B?NEJFL3c5cWtVUGFlMUoyekZTSjViU1o0RDRkVUJJV0xtVzdkeGRmandaZm1B?=
 =?utf-8?B?YlFmeFRobmNpTEZGUTEzREQ0NWx2MTNvZHpzNVkxeFJYTmV5cjBlSysweVd0?=
 =?utf-8?B?QUZTTGFSbWxoeksyOVY4TXhvZFA0b0J1aHFvQlczSDRxN0tIVkFyTFpDMy9E?=
 =?utf-8?B?QjJRRzV3c1N3dDNBaGJsTHh4dk5vSTNwYzUxVXR6cnE2bDh2NW9Bb3JMKzIv?=
 =?utf-8?B?MmxNUG5rOFRiZGxKUmRYZzZWVGNwa0U3NkRHdEFRY3IrZTNRNU9qdHo1SkE1?=
 =?utf-8?B?Y0N5RUF2U0EwcUFJUzh3YzRKUGRjSW5rdHNwNitTWngzVHdXNEI1OUlrT1po?=
 =?utf-8?B?QkJoQlR2ZU1UbUxsTlo3SlFhSTNNMFUwVGtIQUw4WEI1enZzYVovOVI1ZmtY?=
 =?utf-8?B?ZVV0TWw0dXhPempGbkFRV1FhbGN3a05OOTJSK0VUMHFEK1FrWm1vV0x2emhy?=
 =?utf-8?B?TW9MMUZSTUpTUmYvRXl5N2JwNW5hdTBZZTIyS2pFdElYN0x5THlNbmRaUWJx?=
 =?utf-8?B?SXlVZ0lwS2FLbHdWN0huQTYzQU56a1NtS3dhV1ZUU0Y2TXpoNmtpMVNGTFFl?=
 =?utf-8?B?S1piV2tXM1hkdi9tT1NYQ1FFNnRCek1UbFN0dUY4azJuaGNwMEVkaE1aVWRV?=
 =?utf-8?B?cjBnaFBOYW9CSlJZR1k0MHE1VTQ4Z0VyR1RkMDNlajJ5TzZqU2lLNzJnYjlJ?=
 =?utf-8?B?RGY4VUc1b0U4YkxhSDhKTTloamc0QzF6T0p5UGZUR0FVUGhBbmNCQktFSkRM?=
 =?utf-8?B?UDZ6eXlPOUEwTUVkME5JeEJhdlplTG9maVowTlgyYk1sYyt6ZE5oL09HMTB3?=
 =?utf-8?B?enhOVG85TGg2c094Q2tieUhRR1dPOWMwbEpJUm5QcmlyR0JuQ0wxenJSNDdH?=
 =?utf-8?B?emJSL2FzcXJFUUgwZWFXSlI2UXBHckVEa3Vudkxwd2RjY1JlU1pCSHF0Y0Nh?=
 =?utf-8?Q?YAhkxl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJXMk1zQ283V29oTm44WnU4ZWRQVCtRc3UraVhnOHZtZldVWlJPejJ1MlFz?=
 =?utf-8?B?anFJdUxDelNMUmNlTStweXZaTTZCUUZVWEsvQTBKc20vTFB2ZWdkcnA1UFly?=
 =?utf-8?B?MXdxVDZna2NIb2UvR3FpSllQVVNSRThPZktIdldDS2VBYlV1NjR4Mkh6K0Fv?=
 =?utf-8?B?N0FvN3h3TTZ2K1QwN3h6YUJHL1BuZVZJKytNdGwxb2w4c3NYbzhrbmxQbDJi?=
 =?utf-8?B?cmRzMHBJQk5ZUmV6eU5qdTRvdEQ3ZzB1YzNrNmRZRnQxS29jbjFGS1o1dFJ2?=
 =?utf-8?B?SlFPNHIxc3pvV0NFdlR6VWZJMkU1NTZYeDZ3c2g4OUxIN3ZpLzhWOWM4aGdm?=
 =?utf-8?B?TzMxK2c3UG5wQXExTkczKzMyc21KbFZtcHVUVTUyMkRINHd5eWxHWkZqa04x?=
 =?utf-8?B?bG43bGtWS04xdzNPV1YwcGRhakxHLzlPUTVhdGRtRzYxaS9HeS9kKzRSU2JO?=
 =?utf-8?B?OGFuZVNrN2hBSDhoNHRNaTUxVkJBNnEyUzRsSE9nVEs2NUhGanhYRXJZVEZ2?=
 =?utf-8?B?bWllTGxqMGRFQ2MyeW1wTzQ0c2NFeTJHVnBFYzdyWXVqRmF2M01LcUJ0c1dU?=
 =?utf-8?B?dytqSzdZWkV0R3hsanZjdEpCTDRNQjJ5aTMxenhBZTliQ1ZGUHpycXR3Sjh6?=
 =?utf-8?B?RldHZ1V3TjA4Q1h2VGgrSk56S2ViSXdGZWdGYnBKeVJROTRFNkt5cWJCZW9q?=
 =?utf-8?B?cTVlK0E2N09rOFNsQU10SzliNkN3ZDU0NS9rV3pwY2lmbGQwY1k2RkF5M2ox?=
 =?utf-8?B?SUd1NVlGeTNHZGNaM2d1aFd5Q0dEWGkzSHlDWVdqNmF3cFJybXNJenJ2OXhp?=
 =?utf-8?B?MWljSkc2clBJSDY5YUhaZ2hGZmxMeVozWEcvQW5OZmtpNEExdTUyeXpQUU1k?=
 =?utf-8?B?SHNNMkw1cFIxclo2QnpnVDJwNVY2N0lmK2ozUlZLQzNzdnk4NHRMMmV3TkIr?=
 =?utf-8?B?aDNwdVJGb3FPcnBhRnZaM1pMNmpLYXFFWWV3WUQzTVJacHpNUkY0Mks5Tjht?=
 =?utf-8?B?OTRJM3RCd0phd1BIVnBiRkdvSU5qTGJMQU9aWlpMMnkwdTNKOEYxeGQrVElQ?=
 =?utf-8?B?SDJ0UTEzc290WmEzZTBHRUVub21ML2ErdUQ2bTFaRmk4dWx1QWFiT0ZvTVg2?=
 =?utf-8?B?ZXRtMThYQjgzQUtueXlOMytpRnVxWXlWUFc3YlU3Y05pai93Rml4ZThWSytV?=
 =?utf-8?B?cHRvN3JydHJKUVZKUzlPSGxsZlZCWjVkNDhLT0tBdjNSeUlxYjZNOUhwbnpB?=
 =?utf-8?B?Ti84UnhrSWtwaDFLOWZFZVYxN2JJWkFEY3lDLzl5OTQrRUxjWDY2d2pMWmh4?=
 =?utf-8?B?eFpLT3NVUG9zYU1Cbzd1WEJkL0ZVRWY5NDg0WXJjMUxpbE15b3ZFNU5zTitt?=
 =?utf-8?B?bXM4Z1ZibHZyR0U3REExZHZHSloxRmtuMkwzMC9lQlJMTVdLTlhRREZvS2I5?=
 =?utf-8?B?Z0QzRVZuYjRuZDZPQTZ3ZEF0TGZXMk9CSUZ6bmtaQVJxS3dzL1FseWxyZUlJ?=
 =?utf-8?B?S1BrSXQyeDZWSE9nQmdQYW9PZ1FOaHdBZ1UzVzhOdC9hQ3ZqYkorekZMN1pD?=
 =?utf-8?B?Vlp3dVdWU3h5a253bVc5eWJwUWFSSENYT25GTW5XQy9vN3Z4aXNKeEttSGNi?=
 =?utf-8?B?WXhGa2Z0VTZ4RWNEQWwzY2k4RjQvaVBZL0lPK21RMGdMOHV2RC9LQmhhVDdX?=
 =?utf-8?B?TUduYTlxWXBrcnlGTllmY1hNN25LWEcyU1c3b0E4NVFSVGFlMjJ2SE1od0Qx?=
 =?utf-8?B?eUlFd09NUFRJY2VGOXNhOGtqeWo3WWxQZ1k5T3lON2lqcGVqQTZic0IySmxY?=
 =?utf-8?B?bG1rT2o5Nmx2NWpqd0Rja0g1L2drSG1GbWNpbTlZZ0VMdXFNQTJMMlJRamFx?=
 =?utf-8?B?OUhaSlpvbWIzMkd2RWxDclFXdGh1aWJjMkczNXFrbzZBNEdhdzd0ZUlCeFNY?=
 =?utf-8?B?WkhHYzhWN2syc2JzS0J6cENuMHlUYWdxb2hSenpDZTBkeEpWMVZaZXJTSkxl?=
 =?utf-8?B?RFVvV25WN2p1ZkJNR0xJNTFxaFpnUU1rSXlqcmFmeGJGSEtLc0JsUTNuUDdj?=
 =?utf-8?B?TFd0dFIxcmRMV1k0ck5tNmtOWC9nTWR2a1k4NUpBcks4NFJIQmE4cEI1cnNI?=
 =?utf-8?B?ckwwVVBnUm5uemtCWmtNcTRmYXVVaVp0eHFrd2RxU05TVHRzQTVCWkUwUVR4?=
 =?utf-8?B?U2htMytGOU5yd1FXK0VGWHV1cUx6UEdOcEorVlhxT0ZLZDR1VEtUYjRGN1cx?=
 =?utf-8?B?cnlZRVhNZlV0TmFZSUNQWENhRitCcmxXL0VSTVdwWXpuaHJiOTdjUzVJVHl6?=
 =?utf-8?B?SExJZkJ4dTI2LytidTVDL0dkbDdaaGFHQnJxa3IxdXBRa29Xd2JBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37a5d0c-2ca2-46f9-040c-08de5a5654b7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 08:06:37.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLLdlwziRu2WEqAcvOpS9zUfCnB1tUuxc66IY89vCJheU+DhyBNIBZJmZZarucGZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wiz.io:email,amd.com:email,amd.com:dkim,amd.com:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 8193E723A9
X-Rspamd-Action: no action



On 23-Jan-26 12:47 PM, Lazar, Lijo wrote:
> 
> 
> On 22-Jan-26 8:30 PM, Timur Kristóf wrote:
>> On Thursday, January 22, 2026 6:07:27 AM Central European Standard 
>> Time Lazar,
>> Lijo wrote:
>>> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
>>>> From: Jon Doron <jond@wiz.io>
>>>>
>>>> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
>>>> ih2 interrupt ring buffers are not initialized. This is by design, as
>>>> these secondary IH rings are only available on discrete GPUs. See
>>>> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
>>>> AMD_IS_APU is set.
>>>>
>>>> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
>>>> get the timestamp of the last interrupt entry. When retry faults are
>>>> enabled on APUs (noretry=0), this function is called from the SVM page
>>>> fault recovery path, resulting in a NULL pointer dereference when
>>>> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
>>>>
>>>> The crash manifests as:
>>>>     BUG: kernel NULL pointer dereference, address: 0000000000000004
>>>>     RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>>>>     Call Trace:
>>>>      amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>>>>      svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>>>>      amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>>>>      gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>>>>      amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>>>>      amdgpu_ih_process+0x84/0x100 [amdgpu]
>>>>
>>>> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove 
>>>> GC HW
>>>> IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
>>>> noretry=1 to noretry=0, enabling retry fault handling and thus
>>>> exercising the buggy code path.
>>>>
>>>> Fix this by adding a check for ih1.ring_size before attempting to use
>>>> it. Also restore the soft_ih support from commit dd299441654f
>>>> ("drm/amdgpu:
>>>> Rework retry fault removal").  This is needed if the hardware doesn't
>>>> support secondary HW IH rings.
>>>>
>>>> v2: additional updates (Alex)
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
>>>> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Jon Doron <jond@wiz.io>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>>> 8e65fec9f534e..243d75917458a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
>>>> amdgpu_device *adev, uint64_t addr,>
>>>>        if (adev->irq.retry_cam_enabled)
>>>>
>>>>            return;
>>>>
>>>> +    else if (adev->irq.ih1.ring_size)
>>>> +        ih = &adev->irq.ih1;
>>>> +    else if (adev->irq.ih_soft.enabled)
>>>> +        ih = &adev->irq.ih_soft;
>>>
>>> Faults are delegated to soft ring when retry_cam is enabled -
>>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm- 
>>> next/drive
>>> rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541
>>
>> Hi,
>>
>> As far as I know the retry CAM is not available on APUs.
>> Please correct me if I'm wrong.
>>
> 
> Retry CAM filter is available on APUs as well.
> 

Correction - this is no longer true for newer ones.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Thanks,
>> Timur
>>
>>>
>>> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
>>> retry fault removal").
>>>
>>> To match exactly with the logic in above commit, I think it should use
>>> soft ring only when retry cam is enabled. Presently, it's returning
>>> without doing anything.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +    else
>>>> +        return;
>>>>
>>>> -    ih = &adev->irq.ih1;
>>>>
>>>>        /* Get the WPTR of the last entry in IH ring */
>>>>        last_wptr = amdgpu_ih_get_wptr(adev, ih);
>>>>        /* Order wptr with ring data. */
>>
>>
>>
>>
> 


