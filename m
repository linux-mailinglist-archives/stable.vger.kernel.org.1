Return-Path: <stable+bounces-128444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B48A7D3F2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFBC3AB79E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DAD224B0F;
	Mon,  7 Apr 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oPMAx/vW"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240115E5C2;
	Mon,  7 Apr 2025 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007102; cv=fail; b=cZj7vddCnpKozLOoidKQYH8MVg49bYZPRcI1y+bKyGGuV6A8C84BfHEe/nd4uTNt2Cx1n1KY3wmcj6jJV2IJ4sk5RQOT11OEFBCJShA1mfxRKQXdbQRDxLO5wcc3m0lwpNSMWjD4k4fJfEQxjwEGIEbj1CQKoSYJjX8XHX0dB7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007102; c=relaxed/simple;
	bh=afbXTWdSaeJbk4N8TD+F/Nat3n4BuoKp0dUuwALJvVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOXb2VLL2hBW3baqekDm0qH7HnI/v1ssekJUGUl76T4ou58xJx8MVR5Za087cUmryQmH0KCZsBF+eyTD6ABb6watZITR5uYcPYbBeJmdhTog6Jbc/x5zTx1H3IB1uHyJI85+7OSZipMIT/q8cR23YB9AfKFL7NghXfTA3Kfn+sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oPMAx/vW; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp0v2dNonZ4exoWDr0Qqpq2GMXr1gYWQ2Dn9xKCVINgEy8CVxh0SsHM/k08fOCTohPPT5P4y8bOgYqgNekysBAIrQjrcUdBEHtNLNi1CGlhO+RwZUDz+5ik5pMnEp+NPwMmjStsfGWsqM7XzumCVsy2NiGUFlA6RsDLg+HQhJILk17Lg4MfbKJarVT1akTuUlfVzE9nisZ2bCj8Goyja5pPVQ7BuumosWD8vnyAIvCb7Hy7hvRMTZMnSJ+UJB0R4TVuYOSA7hw/jGUxsxbJftUdcRiiNjWa8q9QueqqiezcQfCDHA+bVD+wauX67m8QqIStDprCdQdtIEIlw3B/C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmP5yYCx0YUV+QfsRqTXFxB+u8nvU+H78hG1hBFB8JU=;
 b=Jr6Mb3XcwK+mKQoanlYLtohSLdLvYKTPjBXHCpxEHnIp9qojSSs8neiOQbCoswaJ2Y/JucuW+xx0pWPmZexsKmcj5a7RDqqiGCW8PWD213nf5kvIjOw2tfHd5934oOZDcVkaQ8nsU7YiN9R85RCR7bVX/SAMATwgO8zFZeh7ztEchRMTAdjhTuzRLSsuONZ9edHNZiIbtZohcFXdxXzqBPQJBKRhWi0L+1NND4izyICm1IAWu9MYrU7oZndwC21wwjVtbR9U7Kya/qtH1+wtODOGyrGYaQjTd3DlYJSK5LELy209ZHVxMBH5CXqHHMKFQ9LSycO499m3EAMil2301A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmP5yYCx0YUV+QfsRqTXFxB+u8nvU+H78hG1hBFB8JU=;
 b=oPMAx/vWeR4xvZZTmNQMk2YV2u94L53ZmmSBPuWKM6LABiVsGd3iJJ0MhzQXyUZ063xFuJfTcEt8qBJGJ6Xj4BNSnUViY1xk3UUON/JVyJA22dzxJuW9+I0L1cwGwfSLGWEn8QWNkxXhGcRgH5j0eXl9qcGZs8geFZA+ydyp7Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 06:24:56 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 06:24:56 +0000
Message-ID: <cc87bf39-967f-4b2b-b4fd-9d9c450e2457@amd.com>
Date: Mon, 7 Apr 2025 11:54:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: pmf: Fix STT limits
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: Yijun Shen <Yijun.Shen@dell.com>, stable@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250403031106.1266090-1-superm1@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250403031106.1266090-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 425df250-a6d0-461e-ec62-08dd759cea01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a09WS3dSd0N1M2RybUdPV2NFNjVFWUhFWWF3cnN3VElicXVCaDJ6MVIvaFZL?=
 =?utf-8?B?NzJwenRhNHhhNmp3enUwc3kvT1RQdGY1KzREMmxGaWpmVS9oeXVhYnpzUGFB?=
 =?utf-8?B?RncwanMxaS9pZm1DMW1PYWQ4SDkrK3puOERGQ2xXU1hCM2lRNXlpY0psc1Z0?=
 =?utf-8?B?WENQSlBKWThUZUZxOVlkVkxSaXEreFNqS3MxOThWVnpySFQrczM0STdRRzZF?=
 =?utf-8?B?S2o3aS95SmN3enB3SVNvMFVSMktiemxaVXBVWHprWTZvQ2ptUHliUzByUFMy?=
 =?utf-8?B?NU10T2VJdTkyWE51NUFVc3NUdnhrZmtqbG5yTnB2SWFSUTlPaDVuektkZXFv?=
 =?utf-8?B?S1dHM3IxTTQyYWZhQ1czcWVrVU1KY01UWjZodFdZTktXQ2NiN3g3SWhVZ3VP?=
 =?utf-8?B?dmpUZHpRODVMckNoR1JDWFBlYzZEYjkvTVhUbHc0MXJHbjdWdURLQ2xGZmp5?=
 =?utf-8?B?SjhTdS9rQ1pUaU15WEY1cWZYUm1QeG9rK204RjJmWitVd0hCbHlJRFJNcllP?=
 =?utf-8?B?UDN6bDRMNytWUnpZdHdrNncxQUtsN3VFR2NwUTRjODg4Y3pmZGNQdmtNSVo3?=
 =?utf-8?B?NWlPTTZWSmU3ZEF3eDljaXhoVFlaVEk0QStybTZQWm5nZ244MzBiNXNoTGxX?=
 =?utf-8?B?T0ZYZSttc0drU1YrUmlDTHBQNHpJVjNRU2lpL0xDZHUrZ0tZTFVEWnBtRFZ6?=
 =?utf-8?B?cXZNM0pkZTJ3aktkcFplcEJBWGlqKzlLUGtSVmRjQWdMUkQvWk1OQWZyYWxN?=
 =?utf-8?B?QlpBWUQwb1duYVVTNktXbC9sdXpFbnlZaTg1SkFkaTA2ZmcvbzV1eWVKR2xr?=
 =?utf-8?B?eThmbFVpY2tqVHp1UTZscy9JYUFEdWg3c1NRNzlwWkpOeU40MGFidkRKWHkx?=
 =?utf-8?B?NGlVeHZIK1ZaS1JvdUhVQ1dHa1hoVllINHd3NHl2RnpHc2VwNDRwUTJreldw?=
 =?utf-8?B?M3RVaG1ZVUJFVjVzR2NwZTlqYzJPdzZmU3BQaEtaT1F6SEF0UlE4eGhaUHR5?=
 =?utf-8?B?WEFuVjI4a3BjR2lzK1lkRS9TM0FuMUU3TEZwanNxcml4WnozMFFHT1B0SmR3?=
 =?utf-8?B?ajFtd0ZIVDNSbmZiS09mblYzWE5kbTEyWEU2WVJtNzRLZ1lsWjVnNnQ2WDg4?=
 =?utf-8?B?b29XMTNZVmI1K0dlSXFLbDJjZllwQlpWZXdDY0FWRFZXdkMvZERzOVRyWnYy?=
 =?utf-8?B?bUNGZVFFM0FPYkN3TmJOYnlad21iRGNVbEJnb0tLL1hEdmN4SkZHcWJXUGV1?=
 =?utf-8?B?bmk1NnplSENUd2c1NGRlS1NsRllHNFJxVy9WSTM5cmVlNkd5dDRPU2hIdC9D?=
 =?utf-8?B?d1BXaXhldFBvbldReS9tNldPcUxyVDNzZDYxQXhrYmtJdUNtbzZEU1M0SGh4?=
 =?utf-8?B?NjZuZVZBN0VkR2hUZE1UNmxjckt2dzZjQ0Z2Wk1KUFdJWUc5Qm9VTXNuaFRO?=
 =?utf-8?B?dkhROEhoMEhxckorVTc4emQ5cjRWcTJkTE5XdnNwMFI2cDdTN3oxQUpzcjNt?=
 =?utf-8?B?SWk4V1g2QmcrdVhlZERzZTlad2F0MmNFSnVWTisvVDlUQ3VndGQzL014a1JK?=
 =?utf-8?B?QlArc3kxb1V4MXZoZzhDeDFvdnROb1AyNTZ4K0xGdkZtdEl5Vzc5VS9TTlI4?=
 =?utf-8?B?aVo5clF4elFqL3pqTFNndUc4S0pYdHBrNmZUVXV4N1VQSjJRQVUvRFYwL1h0?=
 =?utf-8?B?NjFBQWJTZnc4WDJBTWNmdHAvTHJYUngwNTZDUHlMTFJ4T2p0VzNWOUJTaVBT?=
 =?utf-8?B?T0R4K3hNUWE5cE1zajVxMWhBWTEwM2FKalN2MWZMcHcweEthZUowem1OZVZZ?=
 =?utf-8?B?azc0S0pBSkM2SnBOVmNSK1B3aE5aUVZLcDEvQ05XUnpybFYxWEVNWERXUGVK?=
 =?utf-8?Q?IIOv9WozfMiO1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmw2SXk1c0g1V3dYZjdNdFc3eTRlU3VZRzlCWENrZGM5UUZxWnBtK2ZQNld3?=
 =?utf-8?B?Q0tXQjBlK1dwOFVXVkJBcmwwOGIzRGZrTHBuV0p3WUQ1VU9jbjRkcml4YjR3?=
 =?utf-8?B?TU5jWXdGWnQxTVF6N0dPdHBVR0tLNk11QzJvVlNKMnhOWjBNc0JzYVFheEFm?=
 =?utf-8?B?LzdxOExaN0hvY2ZYZ28vRVNqSzdoNVVmcnF4dUcxMmRMalIxalRvRkR0eTNt?=
 =?utf-8?B?U3Mxa1FsZzFGYmJXRXRQZ1V3VXhTN2VpMlJraGRzcUdGeTJUZ2h0Z0dEQ01z?=
 =?utf-8?B?TDJGWmNaRUI0UVNkMGFFMSs1OWNpcHVNVEpTV1piL1E2U2tBdFpucnNGck9j?=
 =?utf-8?B?dStjVmgzeUZST2s5S1BvdEkzTTlBSjBUMmx5OW5WaGpXZVZ5NUNiM3V0b1BR?=
 =?utf-8?B?YzI2MzBjdVFpWFNGL1lNZVVnSWtLeWVxNy96WTJRdktTVktrVVB0UjBqWW9R?=
 =?utf-8?B?N3hQYnpVZUhKYTZHN2JEZ3QvNWVHeERxL3VwVW1qQWRFM1FXQ21HbmU3VzNF?=
 =?utf-8?B?WGlHT1o1WUcwdHQ1T20xMmUwSnZRbzVneGxmaFJFeCtYL1J2dG0vSzZxTWtp?=
 =?utf-8?B?OG9ldmZGYjVweDViWGg5YWpFSE1RRy95ZmswTUJvRElxMWJRR3ZUS1JyZlQ3?=
 =?utf-8?B?YTVFVnUwNTdCalhuT2FPWFlXejlwRVlVbE1hUjFhYytuOEY2RFBlSk1oeUhw?=
 =?utf-8?B?U1BObXFkZ1BZdnA2bDQwdUNMZTVQSlNYQmlBcmFWVnlUSld6WW03bTdYLzli?=
 =?utf-8?B?QzF4N3habitRS01oM3R6TWhlbEExcXdSOThoWnJnbnQ5S0Q5eXczYkRVWFVn?=
 =?utf-8?B?UWo2bmhCSFcvN0pSbUIvVGlyZS9nek00aUE2SjdZTzRxMzdmM05wRFRpU013?=
 =?utf-8?B?MlpzL1hzblFsY3ExZWxCWmRORHAwNzk1SlJQQzdNRmkycTlkeVIvZ0sySmM4?=
 =?utf-8?B?V1dJYjZZZHRxa0FZNVcyTkVRSGl2VUdqU1FibUo3NkJFaTY0Qnk3N1lXbm9p?=
 =?utf-8?B?YzRKWkZZTS8yeWU0eENBUEQyUTM4R29saWw3VjdlZTR2VzBSVzZhU3lidVV4?=
 =?utf-8?B?cGF1eVdXTjh1WHIyRXVHNDIyM01WTm5YVmY5R2F0aGlLODRIOFBjNmN4VHZ6?=
 =?utf-8?B?ZWRRYVBtRm1Yd1hNUk1CNndUTHh2R21nVDNUUGlIVXY3WUoraWU0bGFCenJs?=
 =?utf-8?B?U3lic1FiMVdxM0xZUTJ4Wm1hUEtsZHRoWGpiUEtTSDY2ZEthaGZXOGdlNzdo?=
 =?utf-8?B?enQ0Q05CdkNuVU1FdStVNHBpa29JcEtYMlBTdXh1YnBZYTNnL094UXIxS2tH?=
 =?utf-8?B?WDFCd3YyenVBSXVEaUwzVkMzZFpEak9wcUR5R05lNklrWUN2TEVIYVAxVlJm?=
 =?utf-8?B?dG1JSFB2WmZEcmdzU0d4ZEpNK0p4d2ZtWXowcGo4bmczN0s3YWRJWWp4Zksz?=
 =?utf-8?B?RXhmVmxCK2F6Z3ladWJYTXhhTTVBUHloVzJhejVpa3RrSkZGM0FUUENNMXZ2?=
 =?utf-8?B?VWcrZ1kzQlFtWGxwbDBubkZPcmtMdSs3cUs0MDNNQ2JwZVVOV1IvQkw3eWNw?=
 =?utf-8?B?U0xlMUJQR1B2UDRMVmszQmhDNTkyS3R3dGVpRGFXemhlc1BTcnFCNW9GL1pu?=
 =?utf-8?B?cDc0U3dOMTR0ajJIK1M4eG9maGtyOSttTEhPZEFYSnZNUUc2TXRIeHNBSGhM?=
 =?utf-8?B?eHJUeDZ2R0pEamZJNzg2VElTa25KMVRGMEpZeUFULzBYVXZQSmxyVHorWGdM?=
 =?utf-8?B?MjZOeVJVS3BmZVdYZFdwT3dFQkJtRi8zaEtMd3lvVlpibFVDa2FQcmZxUnBx?=
 =?utf-8?B?V3ZlaDFoZ0EvZkRPWUluU2NMQk53YWxmK2J5U2YvRUY2OElDTElldTZFRE1h?=
 =?utf-8?B?T2RsRFJucjkwSkJpVVA4cVNISzNCWm5telpnRVpZUXgxWUVQelF0NkNpcjI5?=
 =?utf-8?B?dUJ6THAzTW1NNHZ1bzdkTld4V3ZSc0hxbWhEeW4xSDRaQnFmT2g0eUU4V2Z4?=
 =?utf-8?B?UFUwSUY3Ny9FMFlwWFh4UHhyb3Z3TkFYWEJ4blZ3Rk9mVlZRWXlTWEo5R1Fy?=
 =?utf-8?B?ZVllYVNCc2krbU9GT0JSbWw2QmxPcWRTZzZrZGFkcWZtQWVpTWhkN1hVNCsx?=
 =?utf-8?Q?0U8fwkQIjG9sNFRQaJRqx/vX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425df250-a6d0-461e-ec62-08dd759cea01
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 06:24:56.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD0czVe+mEeqTB/NMz7ViVFsey1dUlehR5RaIlPg8wVMUI1dQNtxQue+c8VzuHxu+oByHz3XCWc2CWTCmgKixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719



On 4/3/2025 08:41, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On some platforms it has been observed that STT limits are not being applied
> properly causing poor performance as power limits are set too low.
> 
> STT limits that are sent to the platform are supposed to be in Q8.8
> format.  Convert them before sending.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 5d513161d7302..9a51258df0564 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -123,7 +123,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_APU:
>  			if (dev->prev_data->stt_skintemp_apu != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val << 8, NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
>  				dev->prev_data->stt_skintemp_apu = val;
>  			}
> @@ -131,7 +131,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_HS2:
>  			if (dev->prev_data->stt_skintemp_hs2 != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val << 8, NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
>  				dev->prev_data->stt_skintemp_hs2 = val;
>  			}

Thanks! can you please amend this across all other places like:
amd_pmf_set_automode(), amd_pmf_set_cnqf(),
amd_pmf_update_slider_v2(), amd_pmf_update_slider()

Thanks,
Shyam



