Return-Path: <stable+bounces-128821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE5A7F51F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8E1893669
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9725F969;
	Tue,  8 Apr 2025 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xEPfJ/N9"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F925F78F;
	Tue,  8 Apr 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094390; cv=fail; b=ZxXFAhm04CEFU4bWyOalS1sjUUtnXwTIXvqW1MKYn6zC37WATfppa6M3L6XkPQiMvKd2eUvNtVF8YC5Zl6eUg9QhvaC1Sb9lPSlKlxAhcIYv/L+XwuMneyU0FndX/dbtVEBmr7GrDheoTUSzPqltRtmvlkFnXjamVyBt6jWuo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094390; c=relaxed/simple;
	bh=cmlLM/HJTbP5uwElDJ4ig+n/E+t4LSGoapuwWSaps9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibSJCBFhORz6L3n+Ho6BTeAdzUYis/arYkm3JZTzzIpeBKSInZxFM1nwUz6RCJGFZmZNYT1Uv03UEPNluNQn8pPWEdzBXj8d+NWFyu2bBUJxjvpjIZg/Di3oV/WKb/dhmWvoQ21XtOWq9U9ypixrraVtANUCfzQloPruVK8XNeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xEPfJ/N9; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5O176tbLB4u4v06Ng/veZaKNj3dG7K34vQwi4YqzC0RFnFUyGQ2cCbAxU+zvry0lRJhP0zCyZv38CCPcrYm2V/Iuoh9RPdxtTwKhneiWyxYNnhb0m2WfcyPFb75rgjA/DtclXKCqma1BbOnyU5cJ7OSrOXbtzxUJhPkim4jv0z6kjjQIcyB34OyHE5oyWVpDcgShVk7t0os1oWFEf5vv70AsE6R5IOgmmU2aKMNNGvFZv7ZWageZ+AiJibxyUPHu6o1EkaRVS/CyoBJAKZsKNTzHV0eL8WN8SIy2bsjKGendvx059CAV4VkAYJUB0VD2gbn8jYheOPMxpnP98qAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPZHVo+7vgxDL6MIF9DZKvN83bA9ngAUx5V2WATL5K0=;
 b=p/EdHC8MAc2LZ4RVXhnwAJ6VZUAr4aJ1q1Zqww7xYHguyOSXSjD1Zk77hUY2bcAejYHnejNgJzABQArcMY7VyPGe1XLrkFmOZniams/vdkChy8dkvi2aVPMTSLm88LTSyZ3HSVhTPkvLkBa0OuDqhLRVPKFSl02JQvLHQ+MYfVJ54PZW0Uqeih5dhrcYkDNtWLf6vgClkACzEahHY81sZ9nRprOuXG1WjW+wdwaRlLCWyliEttWb0EwP3ZXH5+pa9my6+QQSE2ncuJmUZhXVrp42uUxqYXkt16D9Qt0iKuiR4vhRNMCkkHXAutqE4Qx7jAU9Cbb3UA2Yk60sKGO3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPZHVo+7vgxDL6MIF9DZKvN83bA9ngAUx5V2WATL5K0=;
 b=xEPfJ/N9vwU1vIeIxDmxbW2GUdb0Aw5IYF40R4DK1F9d49LrfKeTw10ndnJio70rAIVKHDn7OZyuXvLz8AUtuv+XJ0+gs1MSkr7b+eJoVa6yBJVzff/javQcM3i25IAlE8nSqmfXedsH3bugL60qKWWwTisrv3ehqDlS2mUSmXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:39:46 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:39:45 +0000
Message-ID: <04163fd5-30f9-4415-8bdf-1b480dac650c@amd.com>
Date: Tue, 8 Apr 2025 12:09:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: amd: pmf: Fix STT limits
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: Yijun Shen <Yijun.Shen@dell.com>, stable@vger.kernel.org,
 Yijun Shen <Yijun_Shen@Dell.com>, platform-driver-x86@vger.kernel.org
References: <20250407181915.1482450-1-superm1@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250407181915.1482450-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::14) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0baf60ea-0b9c-4a63-044a-08dd766826ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZvZFl6VFBHTEJzTXJwRHFZdE5nc1F0UGIzajBRQi9zcGc1K3I1dFNRSXls?=
 =?utf-8?B?WUJIeVMrVnhvbEhMMU1uazRCeFJVR1JhNWFSSTU1eTNsdnV2blFadUlLc1hs?=
 =?utf-8?B?QVhKQ09GdDNYcm1iYndZTHV0R2w3UEJZR0FQVUVXNGpzTXBXQzB0bTVFZHNG?=
 =?utf-8?B?ZlZWWG1KRGl2TkpRenRKOWhvOVZRZzhkZ2JtQzFrM0Y2Z2ZUR0Q2ZUNyWkw2?=
 =?utf-8?B?WUdzbWFza3RkWWpBUjJQeU83ci9TRlZCa1hDZVUvVXF2WjhTRUg1S3FQYWln?=
 =?utf-8?B?QUs2UXB3ZG44NEMraERnS29IcUxtcEpqbGdtWHp0MVlMd3hBckVzYjZTWHR0?=
 =?utf-8?B?bGxQeU0zaXkxQzNuSXAzcTN4WERaSWZ1M1JSVjdzZ2RacnVwU1E1aFcxNEFH?=
 =?utf-8?B?RE1MOStmcitkblVnYXc2SlV6eHpjZjRsa1Yvb1RuSVBUZUgxVkxYNi92bjVO?=
 =?utf-8?B?eGtmUklrR3lsemFaMkRObTVIWFYzRW56cCt4QVBzczdZNTc4R2V4TXJ0Z3pn?=
 =?utf-8?B?QVl1eTAxZFhjUENGdU9QRkdhY2x3K1hLM3hGTjBEbkFlbkRTaXRGK2pITXg3?=
 =?utf-8?B?Ymd3cDlkVTd0RnRJZnNiL21UcStrSHhhSjkxWXZZYytnRXl3M0tORTQ2MkFw?=
 =?utf-8?B?bC85b2JWemtPNnJqNTB1NnFvY1d1TW1aeXd3enJCdjBkYjM3VFNCdkw1SFVC?=
 =?utf-8?B?ZHpkZTBWd1FkYlpQUlZkMVNMbG50eDMzblQ2clZKTks4OG5ONkhFYVhNMVJT?=
 =?utf-8?B?Z3JXR2tRNnA5QytuK1Bpc1RqMFhyZnlscEdDZUdRYVlkSm5QdDVndER0alZo?=
 =?utf-8?B?cVpMVkhBMFNabUM5Qmh5Skd2dGFvQjRFNm05SGVvZ1NVdUVraU1NeXR2cndv?=
 =?utf-8?B?RHJ0SStsR25xM0o3cGJGUWxHMmZWbkx3YkRMcGZRQTMwZXFxUnY3d1A2czJw?=
 =?utf-8?B?dkxPS1g1Z0Nzclk4UW9PNG1sRmRjNnYyV2lmcmdNTHFweUx2SzgyWHFsa1Zh?=
 =?utf-8?B?S2p3d0ZGbE9BQ0x6alZMWEIzSEs0RU1ZZE9DOEVPRDFPZUJ4ejAxN1c0QXBt?=
 =?utf-8?B?WTNzZEZsZ1ltbUd4N1VORHkvMFo1bVg4TkRYVVpycUdVTHBwbElLcEJlT1hm?=
 =?utf-8?B?dm1keTdUUkZHTFNPWVBlS0xDTVlpeFRETlNsYTc4bVdML0FtNEs1V1NrTG1W?=
 =?utf-8?B?bENldWpSTDlqT3pHbWhUcXY2NG9NcHdnUUhLSW9Va0o2VWxIUk4zQ3FraGVi?=
 =?utf-8?B?Y3I4aTVsMXQ3VjcrcVlSbWpXbExSa2VYRHFsTjRPUW1OKzViR0VVSEZkZzFL?=
 =?utf-8?B?TnAwb2lQR3h6TGFuSUVUQndKNW1ZMG5wUkRSS2NhdlY2QUtlcEgweWpwenJQ?=
 =?utf-8?B?dDJlemxqQ3RrWHpzeW1NMG9zSGxTWkowakUzaGtpV0taZGxMMDZrd0M5RE5X?=
 =?utf-8?B?bWhxZkdZcGp3dzMxQXVyT3h1azNhbEIwNVJXMHl2N3ptUHphK3lZcFZ1M2do?=
 =?utf-8?B?UW9LbnE0VjdLVU5GdVVjdEJrLzFsT2N4bmdXSE5JbnB2VE1GSnBvbGlvMmZp?=
 =?utf-8?B?czEzU0N5WDVUZVpFVEYvWHE1ckM1U0dYQ2d4RkEyTDFoU0RFU3FwT0ZSdEV1?=
 =?utf-8?B?VE9mamRoeVhHZWpQZkpHZm16M2F6ekdsamZKejM5L3ZVVUxYdWZWNXYxTUJJ?=
 =?utf-8?B?R2N2QUZqQlpWUlBVVXNiZVRyWDVpTmpzQ2k5TENiN09Sa1hZUGhYUVRkNUdS?=
 =?utf-8?B?THV1MXRaSVZHaFdDZ1EyTHRYc1BVWFpGNnNGbXNiNDAxOVIrYnY3dFVPNHFT?=
 =?utf-8?B?RVk4WGdneVJOTStHazZPdHlhc0NnWVZQaDJjbDlTQTNVMkFFVzRJeXpiQmZD?=
 =?utf-8?Q?7mefGFugSgCHo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjEvUUFOMWt3Q25zUVlnSEZvMHVyWjhhbGdVbTZmMXp3cHZDdVE3RVdkLzkr?=
 =?utf-8?B?YnpyYkFJdWh2OGg1SXBpTDJPcng4eE5ieGc4NEphKzI0TkF0d2VGdE9IYXEw?=
 =?utf-8?B?K1FlelFwaHllcHVaTjVTRmNVeFlKMXpqbXJKMmFoSmJwSmpMMmRtZk5iYjRC?=
 =?utf-8?B?QTRIZGREZGE0cjAwOVVQNno0elNSUm5teXFWNEtsVGFpMUIvNUgvZFFLampp?=
 =?utf-8?B?Y3RCRStxYTdlTGk3SHhXVDJOSVB3WG1CREZsU3hkVWlpN2NPTlU0U0NFYXds?=
 =?utf-8?B?QkRRT1BDL0N1T1VnS1ZvL3pSMU5SSmQ5UjM3Q1FjVUJEN2ZYOWtHR2NuczF3?=
 =?utf-8?B?V0NNdjBrc2xpUzV6eDY2TysySXFNZXdqeDQyQmdiTk1ockdwZUh0RnBLSDJt?=
 =?utf-8?B?Ti9Sd2Z5ZE5idndJTXRPOHJqN1BMZmhHamFQVUFabHFDUnpJWnVsM1Z0RVhv?=
 =?utf-8?B?SmRsUU01RnNFSVYvUDhuUVlZWGh2TFF1Q0ptNTJOcjMvRHRaUytCSmNTMHh6?=
 =?utf-8?B?eFVNUkFwT085WVg1bnJ4dEc2Z2xLa3MrUVl2S0Y4WmZhVFhXOVRFdHphMnpi?=
 =?utf-8?B?MUNFWmRmMkJPZ3ZDdjJuK1BBYlRpbEppU3dkb1R4YzBTUEp1YnU0WnpqOERL?=
 =?utf-8?B?VHJXVWw4WmltY1VZeFc5dFV6cUY4b1UyWmI0Mnc2YjZvS2xLUERzLzhBL1kz?=
 =?utf-8?B?eHRCMDN0UGJ2TXRYaDBIcTZLUHIvVk96K0s1SnNvWldRajllMENEQ3hmTytF?=
 =?utf-8?B?ZjNHTko1aHRCOEZLZW1melFXZ0wzV2MwY1JPcStya0NNSUtKN01NalVLTlBF?=
 =?utf-8?B?K2ZhMUJCZ0N6T21kK244ekVaSTJzWW04cm9OVzROZGtwb3BvVHM0YWxaQ2hZ?=
 =?utf-8?B?aHdjTDNKS0ZxQjByQ2lXOHR6TzlOeHdBcDBiNFRucEtmUGpEVlpEb21maHJy?=
 =?utf-8?B?ZzZCV3lqTlc0VlYxYjQ0WU14cGd1WHU1dmQxWnVQclBqTzJtc2pZZk5PTEFt?=
 =?utf-8?B?TitYZ040ZGZyVm80U2M4VmVPYXdQQ0lLVENWSysrSGU4b3dMSHZZbGoyYnkv?=
 =?utf-8?B?VmJFTG54ODRkVUdUdVgvdisxbjFQUlM2NDlicHhGbldCL3JIWFVhYTZPM0dQ?=
 =?utf-8?B?UlVsc1VHZWNOTDZBeHdaVnRyUWY2dTR4OWpCbzBHRnZiTU1qWFBhOGVVNXhS?=
 =?utf-8?B?T3hxRXdENXBMamEwWmE5TDNybXlhaUNzeW9MOU9WRGl3b3pVem5kODVsUFJT?=
 =?utf-8?B?SFp1TVhDdmM3WU5GdUtKbzRERHlSMC9FMmFDNnc5K2krTjJ6aS9Xc0Y3cEV5?=
 =?utf-8?B?ZG9SWE5aNno2YUduR09kejBYckt4S0E0N2w5L2hXMG1iS000Y2JXQTFaV0ly?=
 =?utf-8?B?SVEzcDJadWtLU0lsTndMcjRQTHRaNWRFN3lOcHZ6ZEkxajNHWSsyRTV0L3FP?=
 =?utf-8?B?ZEs0QVlteXgwNmZrek05ZlZ2cFA2bzBZWWpkc1hCWWwvOFRQN3NzRzhNRWx4?=
 =?utf-8?B?aUJRQnNhSGxob1JMWVFSVjlmaDRkUndxcDRRVWFPblp3ZlB6aW9uQlhYdXVO?=
 =?utf-8?B?dnlrMmNVTHhudW9ZelhXL0lWdW00QWVIalg3a2h3a0VVMWdxOTNjRlZ1TjlS?=
 =?utf-8?B?QWMrUldSc04raFBtblJHemlCaUttamE2KzVsRGRwRCtCMlRCVlVKMFFBSmgz?=
 =?utf-8?B?dUxFWUhVekd6MHV2TmtFYnI2ZWdkRnVRSThmb3J2MTJKSXo0NDBaMXBiMUhH?=
 =?utf-8?B?QjhqQ2RPYndYSmZvRGlXMjgwYjcxYVFKeVVFWE1IQ2R0VlNwTGltTGZJd0Jh?=
 =?utf-8?B?UURnQ2VPeTZUcFVtYTNrdGNwMklVVDFjWkdZZWtPajZhVmtZOGN0QnhUQkVF?=
 =?utf-8?B?djE0d2dLc013Vk5Jajlnbmw5Z0ZKdGppMzdQWmMzMlRieWJ5ait5elZwZHdi?=
 =?utf-8?B?YUh6emR3ZWlXUTNPZlJvQnFEMU9TNy9mRUdRK21yQzlRRHVNMWc3RXdBbXhC?=
 =?utf-8?B?aWgvYVN4NURGQmUycEdYZ0JRRzA2VHJuS2xLaU01dFNOKzFpWW5BV0pGTlFl?=
 =?utf-8?B?ZFByTFNHM25WTTM4RExsNnMvTGswZXhEd2daZDI0b1B2UThGM3R3TTdyZFZQ?=
 =?utf-8?Q?5yanc2atrh8H70WRiR6x1zkYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baf60ea-0b9c-4a63-044a-08dd766826ca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:39:45.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRbRuToDhHKQopGUQsKKGtl1Iyz1m+fB5UsA+yzSV1k6y7llZX17RrV6v0zS/q1QEYOtn3VT3COPR0pXdPOYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824



On 4/7/2025 23:48, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On some platforms it has been observed that STT limits are not being
> applied properly causing poor performance as power limits are set too low.
> 
> STT limits that are sent to the platform are supposed to be in Q8.8
> format.  Convert them before sending.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
> Cc: stable@vger.kernel.org
> Tested-by: Yijun Shen <Yijun_Shen@Dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam


