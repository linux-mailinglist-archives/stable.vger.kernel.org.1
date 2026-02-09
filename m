Return-Path: <stable+bounces-215526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPi6FrAMimkQGAAAu9opvQ
	(envelope-from <stable+bounces-215526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DF112888
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD4F30086CE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475626B0B3;
	Mon,  9 Feb 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rr1YRSBl"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBF2AD2C;
	Mon,  9 Feb 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654821; cv=fail; b=ie7q46NhFxwgTg+UR9cvXAFHHvL0PdaMMBgVsLb3BmzPZojZltjvntjuC42sgC9+33TxYdW3Ko3IPTae0uPnUlcmHOXVovkxgAVLUChyMa34qpbQgcH2YWd0+hHeffuPDMEbe0ldb2FPXWQ4M6VGz10Abwo1iBnIUP/EgyTHwik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654821; c=relaxed/simple;
	bh=On07QbjFPwS7J7YkNZVnsEZxCRNK1UKWk+EsT/3oMvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nzcgl2HOOn1YUwq0GCpwkc+eeM06PoDeTKnVjIfW6phi2Jrf6qkSN8TxuL1i+7nPfVYihTpRM8j8e3oeR33KvY7X/T89HX5QZlbna0OLZo13HDTfpFj09OQ6ksJX5Ba+slEqWJTAqHx6D4NEEh4wbIME/EZIcCJcurhIiiVtvqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rr1YRSBl; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOycfaAAwcXmqDPmIqqhdtRUEP8kDBF78HAGWwaLEeBniDKMEKeexh8hJ38TLiI+s8rHeJ51GGM3QvubW4XkwAJaRGew4nTmcPfwzjzFz+SE3Jn0N8jq4pAXaJnTFOc/qVRS3iv9OsJ3Dz6CybQMA4Vf8bgTc5kEZ4GPEe2enacVWJUXyMFjGiHypqJ6qZUacUkcEhDreq6FfiAAbSrmItu2sJqjcDW/AM58XUnbnjksIFyW6MwS26tWUVyO5R2NHbzYlHN27CiMlV8sU8e0nJfhtJBZIbKUxviCKDGBTLHEWvbHSCiVsPUiGti4kThuK1hcClmRRv9qQ1AZlZy+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjwDVjWRSqS+pi3wfM37do9f4abgU8pD/3vcNwrUy00=;
 b=qpk7Cb5CEJxwmqQTp301sYW+p8l0qms56/KX182y7E2UHI7a9ql9ASMBHFz3hevr//oImDuTyHIttc8doDUyCmb0JK6OeiJgxutwxyGePhmoy7BR9o1Oh5GcnT61D5Xn8Vczz/To2V5lJFOUJF2FCnGeNshVx/duR8CYaWVxRiQ0hiWo26wvuWE3vBVuI2JYCfoeBxUR35nV915dT2fKpUFyXxiqI6dPHzGcdTau6ImxevfkdLNjENNfvEp+bLcX4oy0IgOgS8KOBhp0rguMRw0J7ODtAkqKvt7n3vPrkFsI/jr//zryVWsu4qsH5vkJI+IYr2vWr6XX43WwAm4MWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjwDVjWRSqS+pi3wfM37do9f4abgU8pD/3vcNwrUy00=;
 b=Rr1YRSBlIyqqlmHZKqOcuB3KXVGNZDZdZOcPUNog/QleUJjpjNNOcKT4vNzqRP0KbMVhiH63EkawPUIpW2U5Lud0KAX76ZUG9EHKp/hXe1he7VrTLxZ6vosiKRztmQaBzgbtqgmrQrMg8LI0MnggFMQuPE4L7J7tPGLZF4JdBpdKrisiU0QaibZcLg1MOUuMbXDk44Q5JNSroAxAscJvAVFxj4FOV++XYn4n0p8A6772t7G4/LY8sJejJ/DfBXAaEj1W3yPlZ5iwY8YcPcyDHyXw+KAnrP7gsF7P9NRZj/8ii/KYS8OCI3uomYqerxiQvtyS0eQsrFUCT24fYtULPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 16:33:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:33:28 +0000
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
Date: Mon, 09 Feb 2026 11:33:23 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <91F2E741-5473-4D34-ADA1-C9E6EDCBF5E0@nvidia.com>
In-Reply-To: <22431471-b569-4ade-9881-387debada00b@kernel.org>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <0BC1D792-80CA-4E60-AEA0-187F73BD4723@nvidia.com>
 <bc0b6d03-4309-463d-a112-aae57cee335d@kernel.org>
 <22431471-b569-4ade-9881-387debada00b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: bd340457-0a48-499b-9ded-08de67f8f443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmpqY0lGN01BR05XcWd2cWFsbjVvOElEenFkREhldks0NnhXTklKeXZHdTJh?=
 =?utf-8?B?ZEJFdDQrNHR5RmF2L1ZTUlh6d0p2ekdSR0sxd09xT1FZWmVCc2JrTEJiOTVI?=
 =?utf-8?B?dE5MTkFadFpsRFY3L1hXdGRudDJ5cFo4KzFYNThYdmVsZDZ6WXVyME1pL1c1?=
 =?utf-8?B?UDQ0OHFJaS9LY2N1NHNacFo5VlRxeWU2MmlUVWx0b2lUS2JEZXhzNkpDVG52?=
 =?utf-8?B?OGF3MGQ2Z1Nxa0VRU3JYVkRGUVNlcGQ4ZllEdytpRFBuUmo2U3R5SmNHZTFS?=
 =?utf-8?B?RCtLUVJGbENwZyt1Rm4velFoY2JBSm1TWHY3dkU2SDNra3Jjb2FHRHRTMVc2?=
 =?utf-8?B?dmVDRWMzUnhieXlVWkxqd2gvSWhHUk9aTjRUV092SjBORThlTXlNZWtFUkw4?=
 =?utf-8?B?UWFqU1A4ZHIvMURzVXBlMU5ZdkZJQTVXRjhRTXBHbUQyaU1nSGR0N1JIeDdQ?=
 =?utf-8?B?WjVXZHZyUmZJZWlCVU01QlA0dnI5TkNsQ2ppenF5K2JYcVdoa1BRWFk0WkR0?=
 =?utf-8?B?YkJTbGRGaWRkVHZ6NnRnS1dtZ2NRWDVaVDFSaEVzcWVZV1BQcjNSS2piMnFs?=
 =?utf-8?B?VUJONWZmYmxmRmgwRXRzVmVEL2hpUGM2aHlSSTVKUWlWSjdjVmhwSE1XNW1U?=
 =?utf-8?B?SXk2N1NMbXlZd2lsWDFuM3p0RVlFZjRjdHA2WlM4LzNGR1BwSzgvN2lEaGgz?=
 =?utf-8?B?YVJMYjd6aU5MTHhKVVdJSHAzbjVqamh1cGlmZklnT2l4Nk80cGMya0J1T0xq?=
 =?utf-8?B?SCtxU3p2aTFBS2RleE52eEFZaVRhWFpGRE5McUMwSTRLL3N2YlhjamtMdG91?=
 =?utf-8?B?SFZZYUk1dmhQNDh0cGpUVnpNajFuZGY5V2x1VU1iZjgrcXdBTkdpNXdjWUZ1?=
 =?utf-8?B?d28xeHN4VkVpakhHV1FhcFlNczdvdFphL0o2WURTT3RLbUVHQU5KVzdIb3Ir?=
 =?utf-8?B?bEhkYWRLSmxNRXFHWktIZmxwdmdNTndHaW1VUmNmbkxmM0VTbWFaMlhIK2ZP?=
 =?utf-8?B?QXgxY05jQXA1U1gyMDBEVTEvbEZwYmljV1dQSFhHV2Zmak9uWmlBK0xoanVU?=
 =?utf-8?B?ZU5yNGkrYXNjL3R5U0RqK2dORGdvMzhraVdNNlY0NzlFYzd4bllrVmphdjhn?=
 =?utf-8?B?Sy96aFAwTnBtd2lhbVF2ZmlRZWgyREpTYnlvdFJCVFAxaW1ua3JkN1JWVWhV?=
 =?utf-8?B?NXNmd2Jub0RjWTBQK2sxaXNTSk1TQmp3RmJoamIvOTV5MlpvVnB6eWMwcEQ5?=
 =?utf-8?B?Mmo3dmduaHJNYXRCUUhBT3dxUzVhSit1TFoySmQrMVJGUFNMSWRNUE5CZlJs?=
 =?utf-8?B?WFdMSHRBakszN3lhTWJqQzFZR0NDdFFpdWJxUWtKb2JrdkF2TXNaQnR0RkFp?=
 =?utf-8?B?c1FTc3A2cjFsM2hsTUZVcDRsSk5vbXU4d0NQMWxROHg4Q1BmbndqTVAvYWpQ?=
 =?utf-8?B?am5RR1I5WjJSVEpRZS9IOVVqM201VHk5Ulo2RjBVTytYWHZ5OFI0aW5iWVo2?=
 =?utf-8?B?VmIwaGlpMkdNN1UyN2czbFhlL1RldmF5Wm1CUkR0S0lIY0RWMWRiekJPUDh0?=
 =?utf-8?B?d3puZExHc0FqbUFxMUFvN3kvZmZ2Q1Q1cXJOVHh6aTFITUVENnp1bEx3ckNS?=
 =?utf-8?B?SDNNYWMrazFIaC85Vy9JWDJubnFUWmRSSE80TitoN0piTnJSNzIva2tGZDNC?=
 =?utf-8?B?ZHk3RHFFRjh0Q1NaREppb2k4Q2xvUWZHZXRod2hVMEdndlRlbGxjdjdlVHRE?=
 =?utf-8?B?N0F3TitOMnQ4S0gwWGdLWGRRNjJuS2s5K2ZRSzlNUUNyOHZyandYSTF1SnVs?=
 =?utf-8?B?RnJHaHhDcHcxTTBKU2JQYjBMaGxnZXRNNW5YbUN2SjIyZ1NadjZxQkltQ3pK?=
 =?utf-8?B?ai9DREVOSGZqOExQSTM4WlZCYTN1NVMzNCtyRExFUUZ0cnc2OUJ1SHgwOVpZ?=
 =?utf-8?B?ODA2QVFtTXBwUzVxa09PYTVPVXBIQy9TVnVLQmdzbkNnSVRENWkzSlJsR21r?=
 =?utf-8?B?Qy9EWUlTQ0tVVFdqck1vWGpJU1ErZHduQ0NYdWcyUFdZK1FEaSsvYkZLRFpi?=
 =?utf-8?B?Wmx5Y0taOWtBT2JFMk5ENnJ5TUNZNUhKcVdZUWFKNERWRXFQQU12S1lOWGdi?=
 =?utf-8?Q?0KKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEFnTFdYcmRubUhzNnc1OFZsZXBSeDduU0gzTWR2Z08rRlVOYXFqdU1Jb1N3?=
 =?utf-8?B?a285cHFDdFJwWHdkUUZPVUV1K2pyTUVNeWxUTjlTY0RyTVRuQWVuYUp0QmI2?=
 =?utf-8?B?NTJDSjEwVDVvbDNLSGh2MnVqRExMTEx0QVRlQ0ZaVG1uNGFRclpVZ1BGdnZu?=
 =?utf-8?B?ZnpoWVdHN3RLdW5sbVpsV1NaczBxZXNBSkIzaDhrMzI0MDlFSlBZcmVMVXI0?=
 =?utf-8?B?TTNnYjlpNk45cHR6MklHbDVTS01RejduTUNkL3duZzhNUG56R0MwbFMzR3BP?=
 =?utf-8?B?OVdXWU9UOUYxL3VEK2ZCTjBuUGNGZlliV2hiMXZzWWVWdEJtV0t6ajVTdmJU?=
 =?utf-8?B?OHZTUkdEUUlvRUhQNGNyN3A1RCtOM1hZRm1sc1pJN2dNSWFkT3d6TzZzT1VT?=
 =?utf-8?B?ek1FWjZRTzQ0OVZRaEhQeFlUSGprWmlNZnZnMDczK2V1WEZySDVINnhBR0FX?=
 =?utf-8?B?U0g3ZXRnTXBZcW82b0o4VlE3dG9DK29ycncxRnZlME9IZ1dkQ2NXNkc0RzQx?=
 =?utf-8?B?QjB4ai9oUmFYam5YR3lMcUYvRFo1Z0I1TlNUdEFESEtsTDJzcDFYZjVpUVM0?=
 =?utf-8?B?U1d1TE5aS3FhM0plSld5dEdFWmFKbXpweVR4U01hb2d5eWNCU0Z1Y0NhbGx3?=
 =?utf-8?B?UzJjcU1BWnMvTXB0NmVIb0dwMTVsT2pWR0l4TCtrZ2l6TDh4UFFqZ2d4MFVk?=
 =?utf-8?B?WkQ3YnJ4b0ZrMGhFcVNmMWR2Q0NvV2lrd2x2ZTVLcDczOTdJdzVOUldIcWdq?=
 =?utf-8?B?bG5DRUdNRlFQem40cUpjTUw4a2dxaFF4cWU3ZktNVU96UVJmUFJGM0twa2hL?=
 =?utf-8?B?UUdJODRreUZMY2NjWDRkUWp2cENzelNGQXQ2ZnhURkI5YzVxckVQcHN6TDBG?=
 =?utf-8?B?aWFNZlcxT2N4RUkyZHE1WklpbEZ4Mk1LTjQ3TlY2c055Q1Y3UkxDR1FYWnh3?=
 =?utf-8?B?bVBURi9nMmVHTDJSU3lBc3NPU1prSFh5TGVLQzd0VjA3cXRVbHY3S3U1cXJ3?=
 =?utf-8?B?bUFqMGJSdUtodnExR25HMFJxQThDeTlIcENmQk1RRm1NaE5KRlM5YllYMFFJ?=
 =?utf-8?B?RW1qU0U1QUoyRDl3NE1TL09Ecm1xeFhvbE52ZE5KL2FKaXBFalp5VDdVMWdq?=
 =?utf-8?B?SFFWeFIrU29pR1R0aG1VMnNRR1dwckU3b1JXUHZTYlg2QTcvdWF1Z1dxL1o0?=
 =?utf-8?B?REd5ZUpGTTFlZnQyOU5YWlhjV2tyNVU3M0s4dzhrck1HSGpKWHlUYWduOWt3?=
 =?utf-8?B?K2hleFoxaERuZ3VZdzI4c3BSZHZkUzFLUGlJaUtnTVpxZXozVEVudWk5OTIz?=
 =?utf-8?B?blk3L3JOclFkOTlpRnhvYlJhSkRFdWdpekZrV2d2MUJsVW5ucmpkR3ZMZFUv?=
 =?utf-8?B?TEk1c29LT0hrU0JVR1pWdGc5MFRLMThwVWRVUk9GYzgvYkMwb09TRXJ4VHVl?=
 =?utf-8?B?NEQ0MUlvbG5PWW01dDZrQkFsZmlXZXlmcmRvRjhiRlB1OGFaWTdPK2lzbnQr?=
 =?utf-8?B?Rzg5ZklVQlhVMnJ2Ty92WnVRemhmNTNSMXZqQ1pTL016eHV0NVFYbTNleUY4?=
 =?utf-8?B?WjhJWkRFdytaNTc3WkpBMTB4OXZUWm0vRThaRkYyNnNraW8vMUFkek1IOUtC?=
 =?utf-8?B?L0dXVUh5aTZXS2xVK1RpcGl4VDdFV2E3dThXcDBPV2hIZENjRUN5aG1xekNG?=
 =?utf-8?B?eTFObWJIZzVXVFVRQ2E3eUxiSTlHTEx4ZUhaQklOakxWcFQ2Y2JlaVpnUFJN?=
 =?utf-8?B?d2lUbzYzSTVaSkt2RlhxeTZBZ2ZXREZMV1hoUm8xMS9BZ0RvaG82clZ6VUpJ?=
 =?utf-8?B?RXRWTHJnUnN6bVo4aXV6WXQvaURZUjJHM0Ezb0NSdlZLY3hOaHlsRGpienR5?=
 =?utf-8?B?VVJIRlBCbjFrMzg4dUdBT2FxbGxNRmZXci9mOWhRK2VNQWMzWThkTFk4dHox?=
 =?utf-8?B?dVcxU3dWSTFZVkl5aUhWK1JrOUlwYlJJR0QxU1hYcUJoZmdKNTRneGI0Wnpu?=
 =?utf-8?B?QUtIZ2FNM0xkSm40THlNclpZczdRQ2MyN2lPc2lXN2VvaHpvcTdZWlR0TUNr?=
 =?utf-8?B?aDEzY0t1ZUIvWWpuZGFoQjFNYXN6T0tqN2pNM2NWVlVOK1Y2MHA0M1ZUbmEr?=
 =?utf-8?B?blhhM04wYm5kMytMbC9yalB3d3dwQlQzT2J6K25aSVE4dDdWRCt4bmY2WURl?=
 =?utf-8?B?R1Q3eWFzYmFIdWV2Tmc2KzFLcGY0enRjeHI3YnlRcm9mbDhXQkIycGVKdWhW?=
 =?utf-8?B?Qm9LbklHMGpOaFdrTnVCQm41MDk1OHNqbGJLdjdjZWRaamZqUm1GQmxIVFd5?=
 =?utf-8?B?ZDJxRDJOai9wWWFSREdKQitaekxqamtPbnpIczR2dlRnQVRDMUg1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd340457-0a48-499b-9ded-08de67f8f443
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:33:28.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QECiEpLWBwkgw9nljdzytLRF1tTnJMNo5jRXOhRvEXS6tdGDzlmdPH3UfkYTzcwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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
	TAGGED_FROM(0.00)[bounces-215526-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: BC6DF112888
X-Rspamd-Action: no action

On 9 Feb 2026, at 11:20, David Hildenbrand (Arm) wrote:

> On 2/9/26 17:16, David Hildenbrand (Arm) wrote:
>>>> I recall that freeing pages with page->private set was allowed. Althou=
gh
>>>> I once wondered whether we should actually change that.
>>>
>>> But if that is allowed, we can end up with tail page's private non zero=
,
>>> because that free page can merge with a lower PFN buddy and its ->priva=
te
>>> is not reset. See __free_one_page().
>>
>> Right. Or someone could use page->private on tail pages and free non- ze=
ro ->private that way.
>>
>> [...]
>>
>>>
>>> For the issue reported by Mikhail[2], the page comes from vmalloc(), so=
 it will not be split.
>>> For other cases, a page/folio needs to be compound to be splittable and=
 prep_compound_tail()
>>> sets all tail page's private to 0. So that check is not that useful.
>>
>> Thanks.
>>
>>>
>>> And the issue we are handling here is non compound high order page allo=
cation. No one is
>>> clearing ->private for all pages right now.
>>
>> Right.
>>
>>>
>>> OK, I think we want to decide whether it is OK to have a page with set =
->private at
>>> page free time.
>>
>> Right. And whether it is okay to have any tail->private be non-zero.
>>
>>> If no, we can get this patch in and add a VM_WARN_ON_ONCE(page->private=
)
>>> to catch all violators. If yes, we can use Mikhail's original patch, ze=
roing ->private
>>> in split_page() and add a comment on ->private:
>>>
>>> 1. for compound page allocation, prep_compound_tail() is responsible fo=
r resetting ->private;
>>> 2. for non compound high order page allocation, split_page() is respons=
ible for resetting ->private.
>>
>> Ideally, I guess, we would minimize the clearing of the ->private fields=
.
>>
>> If we could guarantee that *any* pages in the buddy have ->private clear=
, maybe
>> prep_compound_tail() could stop clearing it (and check instead).
>>
>> So similar to what Vlasta said, maybe we want to (not check but actually=
 clear):
>>
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e4104973e22f..4960a36145fe 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1410,6 +1410,7 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (page=
 + i)->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_pr=
ivate(page + i, 0);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Thinking again, maybe it is indeed better to rework the code to not allow=
 freeing pages with ->private on any page. Then, we only have to zero it ou=
t where we actually used it and could check here that all
> ->private is 0.
>
> I guess that's a bit more work, and any temporary fix would likely just d=
o.

I agree. Silently fixing non zero ->private just moves the work/responsibil=
ity
from users to core mm. They could do better. :)

We can have a patch or multiple patches to fix users do not zero ->private
when freeing a page and add the patch below. The hassle would be that
catching all, especially non mm users might not be easy, but we could merge
the patch below (and obviously fixes) after next merge window is closed and
let rc tests tell us the remaining one. WDYT?


diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 24ac34199f95..0c5d117a251e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1411,6 +1411,7 @@ __always_inline bool free_pages_prepare(struct page *=
page,
 				}
 			}
 			(page + i)->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+			VM_WARN_ON_ONCE((page + i)->private);
 		}
 	}
 	if (folio_test_anon(folio)) {
@@ -1430,6 +1431,7 @@ __always_inline bool free_pages_prepare(struct page *=
page,

 	page_cpupid_reset_last(page);
 	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+	VM_WARN_ON_ONCE(page->private);
 	page->private =3D 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);


Best Regards,
Yan, Zi

