Return-Path: <stable+bounces-132655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFADA88A0C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 19:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F218417C346
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EA28B4E5;
	Mon, 14 Apr 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IP7hZ2qG"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43512820BB;
	Mon, 14 Apr 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652462; cv=fail; b=gPKnhx2lbDsp63KgGCDaq1ymXKcbSa/7WYUo2YwPEsBM+4Hwo1IMTogwf71B1oKC03F2FIi2vAzxM1OdEyLP3tdrehecj18YyLGmBF6g8ENuYE3NG/mC6zUjF6k9UXVOHO8I8KDExj0ipqPGHtm3RqJEZzNF4epqVSP7+QeKRX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652462; c=relaxed/simple;
	bh=75Xkac6LCia9DqigPXnr4RAy782mfypAs7JBhsLLcVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rutn25dIn3RTTVMcif92CPadyDaEKz+CIrSi/8HvITf3Bn3jZKxtJCEHY1bRfF9csWpjoh86OKMEPLQpYvWVFVi+5RJXK6IYx8KPiLbSwQv02eOMYUPCz9VI8+CJYb983c09z+GcuCXNPD7rSZDe/xrQDmI7Qt98LxeZXsecGxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IP7hZ2qG; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWxhafUw8rdQ0V2jaq8mBp/uhAwSFYhiDEqhduZEfeKjsTGasJ4pPYFiDLTv1oXlXWLcSEMxRnnE88XyqmQQOS9ag8zBtau7vbcqe3D1CouSjl4YqPDY0QSLke96LQzNGLi4MPCK+aVLvHBtsBC9prOs6/l13WD/AmLn4zLQ0CORv2JCiVHfrjYVzqFzrf6J484+h+kDI+xdndtSFVGTTwwRQW9raCJhGo0Ls1XEGyeSAUlmPkhY96YE1dCByp2E2f55oSNO6Fyk6LApvYvPKteKEBZ2n0RP7ErmwDxrFPGLGNN89NIWV1p+R54xfHp50lZKRIYvU/q5eqa/wy0HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWtUSeFTAIaYLyJnWw5yI7ARkpHr5KY/AMPoO3Qsgi8=;
 b=lViXLkGQkT4YesVpBoVvveI97Y7UEIGOLAccfYuTRvB61rcMqEWf3a6Mtsf+Qjv/13p4YudvnTMASFI87HCD00K65TJ+BcNjh8sgdYxtyuGPlRjOc3rvfXLeisBNgj65fSEngLYhV9tCzChTNMr2DqmN0p3VW8XKiJDf3tDOvvtq4Z6ZBNpHyr5fUnsAY7aeeOL2wfTmLK5+HMKpmygYiRG3Ma6xVnFE1/R4//vzIOpoFfXieige9lNrasXWMae6mBMtX2wK204GEw0a1J7xEcqZCsNL9beV7V1aowYUkHs5agBhYAeqpc6vN0h6bl8118pr2vRCbfkNiMHeTVOVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWtUSeFTAIaYLyJnWw5yI7ARkpHr5KY/AMPoO3Qsgi8=;
 b=IP7hZ2qGTMp54D32TZgIVkS5apXSfckeX9eaZmNNzCdAy6SEYFPd/T6lfOtdZjvaI4WT9jrFkzC5hoqDbkittccVA74QWXDlb5PIXBVomtqMlyJOv6hrMNPCVxOlO8stYYwQ533vvodgmsMVXVI/NU3V8L/y0RlZiynmNZwC2As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 17:40:57 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:40:57 +0000
Message-ID: <70dfa642-4c97-4aaf-aa79-70127974f03e@amd.com>
Date: Mon, 14 Apr 2025 23:10:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: pmc: Require at least 2.5 seconds
 between HW sleep cycles
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250414162446.3853194-1-superm1@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250414162446.3853194-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::8) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 137b7efc-767c-42f3-b682-08dd7b7b8326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW9KL1lUSzVvSCtxYzd1UmNXQkhHMUEra3d4NVM5Y2dNcGEyWFBjNHFrSEl2?=
 =?utf-8?B?c29TR3hHTDJFekkvWnN4cU4wQytnVys3OVdsdG5lQ1hZMWZaY2tQb2pxc2Jt?=
 =?utf-8?B?aHl0QzM3Y3Y0blRsWkdxQVdJZmpVUGFrdnFhaWM1UkYyVFpnZnlDZHJMK1do?=
 =?utf-8?B?MUZRa2RZRFdQeFlEV1puU3dZMVgzdzI3dm1yK1Q3YXJJYUE3T3FrY3B0NjRs?=
 =?utf-8?B?Zkt0K3NMUmNsN1dsSDh4MjlXbjBRcTl1U08yZGprU3p2aVJwVms3MW5VbzN1?=
 =?utf-8?B?M0UvWUFUYzB1cllMeHdiUGFlOTVhYUdWVnlLN1BSbXBjd1VzdWRzSGNteTkx?=
 =?utf-8?B?SXgwVEw0ZG1CS3VVYm5VV00wRnFFK3VGVVZIVVVwYjJRc3BjMWdjOTFxZXNR?=
 =?utf-8?B?UEVuM3RTMFlCMlFTd0xZVXpvcjhxVDNKNHMxVG1wUnZ5SkFMYVVuT3NYRS9Y?=
 =?utf-8?B?RnFkSUl4bWQwNi9hUU02M3dPTHpJRG1HdzRCaG5pOEM0MW9aNWpHS01uVjFL?=
 =?utf-8?B?bXFDalF5a1lTd2sySzd1bVhrVW0zNGhuZTBTTXVGV3RnWms1WG9IOXBLRXAy?=
 =?utf-8?B?b0ZZZXc3ZjQzYmJvNDFEMDFRYkZ5NGhyajhEZGVBZnIyNW1RM3lEZzBoME1J?=
 =?utf-8?B?a20wbEpQbUdmY2lsazc0MmRQNExremJLODBwbEkzKytPaU9lZ1QvR0pWVkhu?=
 =?utf-8?B?OHg4cWtrNGh0U3pqUTk1czhXQWZ5cmo1aHNvWkt5TURVcmdRSFhpNzMxTUlC?=
 =?utf-8?B?d04vaUJXZjFDbm9IelNlTHViYmhUeEd2N0F5TUQ4TTlScE5EK1dPcFUyTmR3?=
 =?utf-8?B?UTArUGg4MjJleG1Ua0pCMVZvNittRVdhdlFZeXdHZjBZYUFQZlR4WUhYNHA3?=
 =?utf-8?B?SDhNcVFBdHpka3lZUTNZeWY5V3FlYmpHeXYvUFZCdVR2cE9EY0dMS3dEM016?=
 =?utf-8?B?VlpObC9QNktXVlBYWHJQVUYzUGtHSi9PeUcyVVRvbzJPcUQ5MHFuQm1JU2F4?=
 =?utf-8?B?NkNXUkdaMVdLNThydFU1UlB4R1RJUDNSc0RhY0JoelEydzU1TGttNi9nS0VQ?=
 =?utf-8?B?aVM4SGNmLzVKY1pMc3hpVmdEUHFHOWR5WElJeUk2WlRSYVdxbldSSXkzcFI3?=
 =?utf-8?B?d0FnSmtXRFd2RGQ5SXE3VVhFamo0NmVhUlRmb1ZrUjZqbkM3NSszVHgrWG1D?=
 =?utf-8?B?aHFhbDd0OWpiUHB3eFYxRmdJTDhOM1Q4YmRjWlF5MFBJVHlzV1RidGVqOGNZ?=
 =?utf-8?B?VjYya0dsdzRGNGduZzRCRlczeHE4UmxrV2JJRFlldjEyVXpJMysvMkx0Mzl4?=
 =?utf-8?B?dkxFZTMxNWZiVHFILzd0aytOZ09JcGxwcE5DT1FuS2RTNTZmbi9jQ1U5Q3dC?=
 =?utf-8?B?Uk9TNVBhQlF1MEZzV1lyS2tCRXQwVEIxQjZ1NzQwTWhHOFNhTXFMRkV4c3Jq?=
 =?utf-8?B?VXZrRmlQYmpyY2xtYklVUDEwdmhLeFJId3hYcnk4RnF1ZFdDLzVqekMydzNT?=
 =?utf-8?B?UzVFQktMTnU1Tk45d21WUWxBT24vdzh2Qll0UVlyWnFpb3lxWFB4Q2FCNDRF?=
 =?utf-8?B?VlZLVEpCQWtMQVd5RUxxSXVpOU0yd1ZlWjlQRzU0eWtleTl1Z3YrNGx0LzBY?=
 =?utf-8?B?OGVqOGdtR2UzNldDM0s1dXdiVWFjMDJQSnQ3aGVLbEJManVjb3dKLzRHUTRn?=
 =?utf-8?B?ekhHK21pWkN1cTh5M2NhU1Z4dlhRRmR5K1pOZ2p3M211ZTBZVThhSWxqcXBp?=
 =?utf-8?B?Z0tCeW94UGpwQXp1Nkg2R21xT0lkODN6clR6bnhrMHpScGtaa2lwVFNWUk5I?=
 =?utf-8?B?Y1lWb3hVQnplL055MVBXOS8ySkllWVFVc0Exd3FyMitGVGlZSGFLRmc5b0ov?=
 =?utf-8?B?MEd1WDdmWnhxb0YxRG5XSlNzUlJmT2tWckMzWDFmaU9hUnpRWmx4Q2Q2bmdp?=
 =?utf-8?Q?Aux90t/s6mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpIdDgyUlhIN0tjQUhZUjczOUJnVVExendOYU40VytudGdGU0Exd3UxMjd2?=
 =?utf-8?B?dXMwdEltaGVRVWd3M3lNYnp1M3N0UTNsc3NVNGFKcjNKZHY0VWJmOCtneWNY?=
 =?utf-8?B?enhPelIyV1BWY0JwM25QNzdlTFlNaTN6QVhmUkNjZUUwREtwcEg2b21UUTFE?=
 =?utf-8?B?NVdzZzVjVS81ZXpXbUwrdk5tL2k5VExTMXpzR2lzYTBDU21Bem0zMmhSMUpO?=
 =?utf-8?B?NFo5UWFMMExwTFpXRzR6L0RFY1FtUmNlSDNWWXloRGR5Z0poVy9VMHgxdEZ4?=
 =?utf-8?B?T0gzTFJqR3ZRc0FiYmhwcDdZODhVVEFFMm1pamRtRzEvM0o0aDhlQ0RVbm5y?=
 =?utf-8?B?VDRialBIRUY2R2Y3eHJVNGhBUVBZaXdqYWZDY0NlRUkrUkFKemxxVldjek85?=
 =?utf-8?B?OE1odHkyK2JudG55d1R6dDZRdC94YytzaFZNM05sdjF3MHpSVUFDWVJPTE5V?=
 =?utf-8?B?UG5YT2NyMVlrRitMSTlNTUpYVGZIdnlYOGZ2UEVudkU5aHNiTE5WcitZYzh0?=
 =?utf-8?B?b0Q1SHI3NEhHeE1Nd1ZqV2lwODdCeDNyMGhGakp6QkZjZG4rbFhNZit4clZK?=
 =?utf-8?B?ejE0S3FFWmpwMk1zVG0rdjFhbmI3M2I2bTZBamprM1VrY1R1bkxRMmdtN2lY?=
 =?utf-8?B?eXk1c0VSR1R6MmNYRG5EWDRpcXR6Q3RPWWoxbHNsOFQyalc2QjA5akcwdEJs?=
 =?utf-8?B?RmJ6OTRKUFpTV0MzaSsxMDdxWGdsT2V0Nkk3V3pOTTRIQ1FtY0VqUDhMRWdo?=
 =?utf-8?B?aHJoZHlxU1hwdzVKT3BCTXhjdTRXS1ZQaWxXdUlGaEZROUhFRlNKWEthTDZX?=
 =?utf-8?B?OERSRXNEWVEzaThFWCtpdlVXdmx5WStXT3hvYjltMUFkaldSWFB0Y2UxU1Bi?=
 =?utf-8?B?U2NOSFJCZHVKWjNZdVRlOG5RSmNmTUJPL3JyNUdZdU9vakNlRTk4UnVQMzNy?=
 =?utf-8?B?eDk3c1B3K0IzMTlZaHJGcm96RnVucktCVkpPbFdiYjMzWW1CdGpNcFdmMU8r?=
 =?utf-8?B?YmZBWTBPODFEZXVkOWppaUpab04rVCtnc1I1QjNVeGZtZk00ampOYUVyL3N6?=
 =?utf-8?B?OWhmYkJCUzA1ZlBCZ1kySEp3S3g0REY0VEpieC9McHc0R0duOGJYbFNzTVRx?=
 =?utf-8?B?S0ZHSW0vNDgxRzRXNjJEclBuMXJ2ekdFelB2eTNramJsL0duV0dRdDdzb2xa?=
 =?utf-8?B?KzRwcktqYzdETGJJWGtUUkxFRmFuVlRBVDdRS0s0SGF6MXhBeUpLMUhZR0NO?=
 =?utf-8?B?M0VNd3NMYk12WmJLQjgyeVNtRW9XN1I5S3IwQys2a0V5RXgzVTVueWRoM3hO?=
 =?utf-8?B?U2V3K2NWRXh2UWhtTFZQdW9aNkFFdDgvT051Y2R5a1A2ZUhxY1pSK0x3RTV0?=
 =?utf-8?B?T1FFUzBiYk9xWk0vQXhBMGhQNk5ONjdGVlNab0xUcUs0dS9VZnV1amI5bFJO?=
 =?utf-8?B?aWdyamxBN2puZWFieWpXZlZsa0tDN1VzTUY1ZW52ZmhhS2FHTWRFMmFwV0k3?=
 =?utf-8?B?bzhpQkRNQUZOM1BubHdQUGlGNUw2aGNNeWx4ajh6cmYrU3VMc1lEYjljSXJT?=
 =?utf-8?B?VXYyVmpSSFdvbTdVT25XdmptYjM2bUo4bWhCR0NFd2lUcHhXdXZGR0FpNXhV?=
 =?utf-8?B?T0VNZi9vUVdnMXNQVnBHVVF2bHhLcFlZSzVScm9wQVorYjM5MHI5Z1VVMnNF?=
 =?utf-8?B?QlJTaVRrTlNtcWxFdlB6U3plZXpSemwrWDluUTlIWE9HWjljbzdqMUpxd0FY?=
 =?utf-8?B?eCt3bnFnaVplMVBOaXE4eC82d282L0xwWFRGN0t4aEdMWXZ0ZGh3RWsybmFH?=
 =?utf-8?B?cUs5VkVhdkNuNUZWR0N2Rm9SSFN3cGRtelBWcU5ScUxSbEMyaWhQUGZEZlR2?=
 =?utf-8?B?Z05ZUHdOeDAxaURXRWpSek5UVmtwNVFkamFUL2tZV0huNEcyUXV3RDZZc0N3?=
 =?utf-8?B?RDNzSVE4SGh1SzZxY042cUNMOVJkWmFSSXVwUDUvUVd3V1V1TWJIY0U4dFNO?=
 =?utf-8?B?c3hrb0JBWDUzeXgydHJiaTZkWXZEMjBMeVBLb3kyUjlRZDltVkkyemVzUE9y?=
 =?utf-8?B?TzFTN3JBbmh5VFVFR0V1YVpNOWFwV0ZUeWk3aTNsS2JIempIb0JRaGtLeEZM?=
 =?utf-8?Q?kaG5Z51al0SgjXpNgUU6UTlIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137b7efc-767c-42f3-b682-08dd7b7b8326
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:40:57.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibEELc8UADT1TdzoFAYvMFVG9URodLvTImEYO+AHURZbHREdneuBRSUXZYkAhPK/Px4Pzy1LzSUOL29ECZsN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997



On 4/14/2025 21:54, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When an APU exits HW sleep with no active wake sources the Linux kernel will
> rapidly assert that the APU can enter back into HW sleep. This happens in a
> few ms. Contrasting this to Windows, Windows can take 10s of seconds to
> enter back into the resiliency phase for Modern Standby.
> 
> For some situations this can be problematic because it can cause leakage
> from VDDCR_SOC to VDD_MISC and force VDD_MISC outside of the electrical
> design guide specifications. On some designs this will trip the over
> voltage protection feature (OVP) of the voltage regulator module, but it
> could cause APU damage as well.
> 
> To prevent this risk, add an explicit sleep call so that future attempts
> to enter into HW sleep will have enough time to settle. This will occur
> while the screen is dark and only on cases that the APU should enter HW
> sleep again, so it shouldn't be noticeable to any user.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index d789d6cab7948..0329fafe14ebc 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -644,10 +644,9 @@ static void amd_pmc_s2idle_check(void)
>  	struct smu_metrics table;
>  	int rc;
>  
> -	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
> -	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
> -	    table.s0i3_last_entry_status)
> -		usleep_range(10000, 20000);
> +	/* Avoid triggering OVP */
> +	if (!get_metrics_table(pdev, &table) && table.s0i3_last_entry_status)
> +		msleep(2500);
>  
>  	/* Dump the IdleMask before we add to the STB */
>  	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);


