Return-Path: <stable+bounces-139312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1CAA5F92
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB044A82D0
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29D156F5D;
	Thu,  1 May 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BP6ALAZr"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6D1A00FA;
	Thu,  1 May 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107778; cv=fail; b=jkRYiVRUEerGn3X4pylJiJp+XzXpdL5fGazKbpNeUIAidhnw3ipvGyyNaayTISiZeYvhRROKmXAdSe8f5MYjAzAQEfhqzXm8x21U78WLCl9IqujZH6GS2zhaVX2C617rR7T+SAaVOEezgD98qFPvYzU66agvc2RVIADy0RMm50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107778; c=relaxed/simple;
	bh=kfuRoXrjEIIOb5GgjQvCuz+zOuHAQmJY6XdDLA2jdZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OZeLholzYgfpIg+2sOoYWiKGow3Ij367EpNHuqb1h/fcbl9NSPAM5v8GdL3U76pp7IjSygpPGQltARZ3aciNUqulLgAFD9FImn6r5tMu5haQ0x45/HXLnp8eHLxrO9EbVlA2IOaTHec02P5LDl1aUpxTv4Fa1/s5fuPM6exwLL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BP6ALAZr; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhjP+FnF0NEMGmQRP7p1uG7zSJaPJdVmsWKMMeAguSvA7im6+jgZYkdbyqc1fvWchsBSOVumJn9KI3t/+++pLhc1nmglU53mM6tgRiXi8khV60STrJoy38kMk5CqXIr+I5pc2kRbkRZUMVMpuPPSRTxrNGCChp0CdKH3FoEm4//xOGvwkfnLkQjvLYeX50FsjK4yhT6MOc2g9Ki8TcMwzNaXuqI3BeK9+/R7ODkrh1trOwHdt20LYvFGyIuRvLJFgOC2pNYP6AhYSxiQ3XtAzvq9o8LO3rXqMqDeQTSY33/n4dQzuemLrsAuqUnUtuCg189duClyLlKYRjZ7HaHusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AKR4gVPDHOjpQuuTxzsoFzfI99o54TMi+RtCbmbPWY=;
 b=AI8PYk5LE7Pt84wL0U9Mh+kk9WXHBIfBmAJUcJEh58xMXHanfFj7Y1ih5OtrN0rvIpbTNec4sYCLZlPhYB0ak7doNZ9d1Qr5x3H6ApciB/PYUIaHGZcuNWNX0+NsKjafPTFu+FW1f3Ja8WbA7V0Vg1T8HG6AeQj1tUKnkqJ9rzplXN8n2BLvQmTb9r7tLSuKs2yI8LBF4sfmwy5ftZY4jA2iJcGCGoW8qEKz9gQzFyieBOCksJyVpQY3LR7enDR4QBQQ60Ydo+VIGLLnogVu0R8Vl1eIjOIz4bNUasgFMY6PcNJU2h0sNyymhmN/zZvDfnEAfr+/aqUsUHOJoYSrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AKR4gVPDHOjpQuuTxzsoFzfI99o54TMi+RtCbmbPWY=;
 b=BP6ALAZrGrqcT26+bL1Rf0r+Vs/LuwrIqEhpA8X54FKW3JO/HjiwDmBEpWa3nwBrIcphD74jkOSk6DQahA25xMzuU011WGWJ2ig/8K8k7rd6ul6QGnHI1tPkKFRu3pf1YS7xT4J99qtLEf2c8ZoPRc9PeJYDoXUWRXMUJpMTatw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 1 May
 2025 13:56:10 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 13:56:10 +0000
Message-ID: <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
Date: Thu, 1 May 2025 08:56:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/sev: Fix making shared pages private during kdump
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250430231738.370328-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250430231738.370328-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 245ae2e0-fe6f-4b05-00bf-08dd88b7edcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjVIRnpDenFUcUZhRFUyRDU4Zldiak41SUdqQ3NCdDVKbCtuWFR6Q2dkVDJy?=
 =?utf-8?B?RG9mSUxNY3FFTmtlc0NpYSs2S0ZKMFVrc1UvTHk2UzMvaHFhV0s2Nk9JaGxT?=
 =?utf-8?B?WnBHWGFFcW5YTmNXT0dQKytzdzlqaFpuSGk1ODhBTnBLNDhBRnI5L2FXMHgr?=
 =?utf-8?B?U3VKUDRBSXliSVQ3cm54Um9NZW84UkhSU2x6dUxaSGZtYTZ3S0NpN1NyZWM1?=
 =?utf-8?B?QVBnc2xSd1FZY3gxLzVucEliQnp0QUJlN1grNHB5RkE0aGtDRkxFKzVlUmEz?=
 =?utf-8?B?Zko2R1lpUlBKSXVWQ0t6ZXpYU2h1M3pneWhpYldPWkwvVHE5WFBlcDBiMFl2?=
 =?utf-8?B?b3F4RUJ5NlMrL1M2SFovUngrNW9xSTZLNXBPZFhkMTlqWXJhWTc0cWFTSWls?=
 =?utf-8?B?VldEbHFXK0ExL245ZkNuUmhmTGsrTGxEMzBuQVZURk9xbFhYWllLdlZhMVpt?=
 =?utf-8?B?MGxhbS82Wm5OWmpUK2JMSXp1a3NySWEyRXVkRWNrd1BRM290VnJsY3dCV2J0?=
 =?utf-8?B?UXV0ZU5WUm9xM2ZpSTB3YlpwYnNNbk9adStvZG04SmNQcmJwZzJ0OGMxeTh3?=
 =?utf-8?B?WVpPT3pBWjRldHRzcTVZeHVERVpwdlU4WlJFT1FveS85eVRXK2ZUcHZPekVM?=
 =?utf-8?B?c2tzS1ZaUk9lQnB1MEcrbnJNVCtiSTRCZ0RJYUQ0aEFLanYwMWNVZFZZNmlz?=
 =?utf-8?B?bEtnS2kzV2ZFVTZ0ajBwRkxMYmxDV1h3a1h1QjFxREQwUStlaGFLamt4WHhk?=
 =?utf-8?B?SEN1UU15SXRpZVVFSWZtYndvK1lmQVYzMDlrTk1xWktWdHZMSFRPKzh4RFBZ?=
 =?utf-8?B?YkNOZkRrYWs2UzJnbmVMOTU5Um8zZDF0VWRrV3VsL3h5R1p2Z216NWhvcjhx?=
 =?utf-8?B?d2Z2QkdjRUN2N2JqMHB2Z3VIVy9nMU1rWFVKY213YWFXenU0YUlNN1Z2TzE1?=
 =?utf-8?B?VFhLTzNkMkg1ZW13R01FajZZRk9wQkZNUkRaQ0M1T05VNzZPR3B6VnN1YnVX?=
 =?utf-8?B?bXhwelU3SXRKR0EwcGlBZC9tSGFWUVUrQ0NhRnF1SGE4K3orYlFKWUlCUFEv?=
 =?utf-8?B?QTFvTytrQ3lPUjAwL2l3UGdvN29hb20wT0lWUGNZWDFVaklKOFladHdkZGgw?=
 =?utf-8?B?VXVLV2xmYmc5SDZnSWo1TlBYY2ZkRUZhUG9mazVnK1dhVFNSM29VREZFMWpW?=
 =?utf-8?B?ZnljcjIvc2lhQXF2ZDE5TWxKQTNKOEVNOEUxK2tVcjk2ei9HR0xpRENmV3px?=
 =?utf-8?B?ZVBET0tOUkNibXZYVEdXc2dmOSswbDJVUE0ydzcxMTh0bEpqdEM1RzNKdldz?=
 =?utf-8?B?QlRlcUhyT3AwanpTN0MvNERHOGdta0I4TUFSR1VVMVphTm9BK0lSTmV0dURl?=
 =?utf-8?B?Q0FEUkt6ZEtQSGhTb25iZVFJMWNUTXRJOEJWMjZqRDdzeUhRam1ZY01tY1JG?=
 =?utf-8?B?TWpIeXJ4c0EvME0zWlQ4N3dBc1JxVCsvZHRsZzdZbk1vWmJXcThkQzZkZFFI?=
 =?utf-8?B?MUFJaEVQbnk0d0d0YU1Gb29ZM3RqVXNYZWowaUluZTFRaUF0TThubGtpSUpJ?=
 =?utf-8?B?TjJRNDNYN2pmYmhuVHZ0MlZ1MUpXUisrSDhKMmNWVjVmOTlYNFo4U3VWVTRE?=
 =?utf-8?B?R3JjVVhQT3hoTjE3NG53SEU4bk1QYVR6cS82dGEwaGdUL3BMZHkzWkJGNThj?=
 =?utf-8?B?M20vSVNjQVlEcFVVQmNWLzlEMWpYSjhyUEpjWHEvMTVzeFg5Z1czMk93SEtG?=
 =?utf-8?B?YjhDVlZ0K09ibzNSOVFYOTJnS0hWRGgzbGJyeHRCV3BUREVoLzBvYnJmcml4?=
 =?utf-8?B?OC9lckI0a1JWaHpRRElURG1IVFlIS3BMdFRkeDlKcTJUejVGTGNxWU8vaDRN?=
 =?utf-8?B?eU5KL1RQbkJ2bFVDeHdnMzRpSVd2Nk51aFg3eFUrV1hIckdEeXRUNnVpYnNk?=
 =?utf-8?Q?b/jG1iT3G+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjQ1blo4M0ZySklVSGl5cy9ZM1JKU2dyUWUweUNTdGluZ3VQUUplSU53d3Zk?=
 =?utf-8?B?QzlTSER4cnBHaVkwaFJBcjEvTW9WYXpjTU1uRGR4cDNNZVFZYXN2TWtWLzhu?=
 =?utf-8?B?YlpucmNvV1hJZmVMWmVJNGowSzkzcllpSDZhREcwVHc3dldqcnd6czRIeUVk?=
 =?utf-8?B?MWROc0psN2o2cnprRlYrSlNaYnByRzhBWENpKzRNOFUyYTVQSTJVaEVwanRv?=
 =?utf-8?B?QXpzUGpzR1gwU1hDaUlWNGk2ZytMcUZ4b0w1K00reGdhQTBwblIwQUc5dG8z?=
 =?utf-8?B?L2RtcjJWajM4YmppcjkyTVpUbDFadysrdG5mazBsWCtDbmRnQUlPNTVLVStF?=
 =?utf-8?B?Y2ttRGFPN2lFSmxNR29LZ29WMEpVTTJCeVAyRWJnTnVSeVJQcG1jOXIxTFZ3?=
 =?utf-8?B?VXQyVk5YNzFNYXZxMWVzZ1ZYRDI3SWFhVmFaOGpvZkVPM3duak9CV3llVlFN?=
 =?utf-8?B?UmRZcGhiR0JFd0xVankrcm9OYTk5ZlBva3NzYW9WWUtraXphb1ZOTW5iWVp6?=
 =?utf-8?B?U0xYS0FrRUJwbXgzaUtzVGN6ajREdVhMcnFKekJ5eU9yOVh5UFFWWEtta1VC?=
 =?utf-8?B?NzFlSkdmSlN1aVJncHNZTW54a0pMMXk1dkphTUt3eHExVzJFcGlubnRIRm5m?=
 =?utf-8?B?NlBVV0xFOVNSNjYrcXk0TFZnemNVdjJmZE93WVN5VlJ2di8vUHRRVGFTeUdo?=
 =?utf-8?B?Mk94WjhLMTRFWktZVFZRNjZYR29QdGVBcEI4ak9uZVY3bjJERE14NXpyMFNS?=
 =?utf-8?B?aXM0dEhxcmlTVEY2Q0tnak1FQ3Y5d2MzTE9rM041UktOM1BaYVRXaHBxald3?=
 =?utf-8?B?aDBOcHk0MG5IY280bHVyVi9hNVRjUUZPbDRtNHBTVC9RUWFGdXp6cTF5ZUdj?=
 =?utf-8?B?T3E3UzFuWFREQlZPY2ZkN2ZlZjgwY0IwbGxuYjg4T3VVRU9vK2Ftc2ZZT1Y3?=
 =?utf-8?B?dWgrQmZEb0t1aXY1TThERkJrU3JrdjBlWWFVUDNvOHJ0dmZmOFNtKzVyY3Zu?=
 =?utf-8?B?SE8vMVBaenhtYndSZ2lpQ3ZqazVQQ0l2TkdDbjd5YVlpK0pOekc3YVRyNm5E?=
 =?utf-8?B?bmxQRmZnU1R5cVJUZVNvY1VvYlhQdm1FRnZhRlNwOFpVc2d1VHBhYnlJckJX?=
 =?utf-8?B?TENUMjRpd3RFckRsRGpGbW1ncmN6OXRLaTQrNy95UitiWkNFTzRxRS9rVVR5?=
 =?utf-8?B?aEVxY0N3dCtpcExnUHBmN0hhc2poT0NFTkFnYlkvOTIvWVlvaGNhNGhlZTZF?=
 =?utf-8?B?bzBOTThhUU1sUFI0UElyR2ZEN2M0RU9GK0NSMFVRNzg3ZE53ajlXeGswa0Z3?=
 =?utf-8?B?RnNudS9xT1Zmb2xCcU9TMXozSGZNTjRxV1JmeVJPNmtjMkhXbXpPM3V0aWFs?=
 =?utf-8?B?a1l0K0dWMnlYSEdPeEVhNzRxVFF5Z1FhWk51QUJzY2RIeHJvR1FXNXM1czR1?=
 =?utf-8?B?SGttM0lwN290ZVBrakdhWmVPc1R2YnZOUlZUVGhhMEJpRk5EQmVLaklia1pO?=
 =?utf-8?B?R1A3aFZGNk9BVytnQ0kwRlBZaHpTTzVCdHkvcDlyaWVhS2ROZit1RHgwRlEw?=
 =?utf-8?B?K1c4SWZuQkZ6VmhLVjdSdmNSR1hvTWlTRTdrU2VBbUdqaEVtOWZ0YWZMUGRL?=
 =?utf-8?B?MFNPL3BsZGpqVjQrYkFhekUxRFlyWlg5UURUeTkxcERaMnVJUHZWRWpnZmYx?=
 =?utf-8?B?Z0RXT2hONDJZNDNqdlU2enBwb1FsUEZmbE10SlI0U3lPellCR1FsNWp2UFNG?=
 =?utf-8?B?bWp3dmFzU2FxV2VpTkkwZ3BaaHZ1WU9HN2lMR3R4bnJBOHo4UGs2WGJYRTYr?=
 =?utf-8?B?VWU1aWo2T05zdDVUekZlaWhreUdvbjlxQ2ZwSmtwVXVocU5sZFZlMGF1VHNn?=
 =?utf-8?B?RFdmNzd3UVkrN0l6YUg3NHJncmZSMXNjTWpyczJqb0dSOTBSdmZ6eXpnNEU3?=
 =?utf-8?B?ZnhEc0dGOXR5VGduY29reTdGNjRuK25CSmczVXRmbmVyK0lXTy9TdWRMZ2Fn?=
 =?utf-8?B?TU5JMVRLeWRqRnJGUk1Mb2t0all5V1hMRWwyTFF3dmRMQjQ2OFk2UFc3NnZW?=
 =?utf-8?B?ZWpBRnRVc2VTN0t2emh3U0NlSE9FVDN5b04wUHVUV1dlSFY2SjlPczZoZktp?=
 =?utf-8?Q?6F3x3GpL0vnDmqvXby+FKvgXI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ae2e0-fe6f-4b05-00bf-08dd88b7edcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:56:10.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXcxBdLsWaREDaeMxAV8v/TTzr49jQENdZXWABduo6chJvzDYY3hnVQeNCLAiYoNwQTa4UW1qiJGCNnYrFfXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

On 4/30/25 18:17, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a huge page.
> 
> While handling the case of GHCB page contained within a huge page
> any shared page just below the GHCB page gets skipped from being
> transitioned back to private during kdump preparation.

Why this was occurring is because the original check was incorrect. The
check for

 ghcb <= addr + size

can result in skipping a range that should not have been skipped because
the "addr + size" is actually the start of a page/range after the end of
the range being checked. If the ghcb address was equal to addr + size,
then it was mistakenly considered part of the range when it really wasn't.

I think the check could have just been changed to:

  if (addr <= ghcb && ghcb < addr + size) {

The new checks are a bit clearer in showing normal pages vs huge pages,
though, but you can clearly see the "ghcb < addr + size" change to do the
right thing in the huge page case.

While it is likely that a GHCB page hasn't been part of a huge page during
all the testing, the change in snp_kexec_finish() to mask the address is
the proper thing to do. It probably doesn't even need the if check as the
mask can just be applied no matter what.

Thanks,
Tom

> 
> This subsequently causes a 0x404 #VC exception when this skipped
> shared page is accessed later while dumping guest memory during
> vmcore generation via kdump.
> 
> Split the initial check for skipping the GHCB page into the page
> being skipped fully containing the GHCB and GHCB being contained 
> within a huge page. Also ensure that the skipped huge page
> containing the GHCB page is transitioned back to private later
> when changing GHCBs to private at end of kdump preparation.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index d35fec7b164a..1f53383bd1fa 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1019,7 +1019,13 @@ static void unshare_all_memory(void)
>  			data = per_cpu(runtime_data, cpu);
>  			ghcb = (unsigned long)&data->ghcb_page;
>  
> -			if (addr <= ghcb && ghcb <= addr + size) {
> +			/* Handle the case of a huge page containing the GHCB page */
> +			if (level == PG_LEVEL_4K && addr == ghcb) {
> +				skipped_addr = true;
> +				break;
> +			}
> +			if (level > PG_LEVEL_4K && addr <= ghcb &&
> +			    ghcb < addr + size) {
>  				skipped_addr = true;
>  				break;
>  			}
> @@ -1131,8 +1137,8 @@ static void shutdown_all_aps(void)
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> +	unsigned long size, mask;
>  	unsigned int level, cpu;
> -	unsigned long size;
>  	struct ghcb *ghcb;
>  	pte_t *pte;
>  
> @@ -1160,6 +1166,10 @@ void snp_kexec_finish(void)
>  		ghcb = &data->ghcb_page;
>  		pte = lookup_address((unsigned long)ghcb, &level);
>  		size = page_level_size(level);
> +		mask = page_level_mask(level);
> +		/* Handle the case of a huge page containing the GHCB page */
> +		if (level > PG_LEVEL_4K)
> +			ghcb = (struct ghcb *)((unsigned long)ghcb & mask);
>  		set_pte_enc(pte, level, (void *)ghcb);
>  		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
>  	}

