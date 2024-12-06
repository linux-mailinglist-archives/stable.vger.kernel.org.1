Return-Path: <stable+bounces-98938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AA9E6808
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6296163FD0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5521DB37A;
	Fri,  6 Dec 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NKeAqybW"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240B32C8B;
	Fri,  6 Dec 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470702; cv=fail; b=pvJKCCS5wUVnK636GQXNFGEa3Hl3fSLQgUaj5Nrk9aJZLnMrg192iDFJd5GiN2UdvGO1qPFfXz8mRqHSv1/pH2JKpzDzqBealmvznrZCanOOZWgwGhmB3df9bLRg9r4ca2X2030MwXQG/Y1DPdASjSpXSAI/JoMH8gBiaadKotU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470702; c=relaxed/simple;
	bh=hPO9Xt25DaVC3W6MYp0fg6mFmmUBsJ0dNCzfNw2+8KA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl5/raWzz6egfMdgINNzNfKcx8uTNrXUZD+FJ0GFpAY8G5ZfhiXkklygF2acb4tNf415VWQiS5TEb+4WY39T+xEnraUGHIJOSZ5JULpE8LQEcE5Ip+I+DMrZB4UBBCSD0eGy9lmB9cNWKq2nqIkHq1eBal3mhIvW1nMFUwF/FTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKeAqybW; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwXfZcjP8KAD+2yPY28zfYOl7rW4J9ww7BTPy/mIDd3OOf4otGFKstGailCL1GIC3i25lSXyMQ5OKHSE38mvQTRPDvrrbux8UaagwtN2nBAIUof9F2VECA7fK8spOdm31XmO8uUqjGFjpToiTOa11/I3RJBnnXrem/lRFkhmxs4vVkTZoE45YL/vXWUzxYG64TNKs6SnJWbp4lnR4K7O4ZFuKTanBEYqCeMmfbLms0D4UqoIY2B3JnuzlHiQAsYEzo05xSRrBlx5wMEclGLbX63eWgQz9+/SmQ4DWkwyuou7gEwQOjEuVNwuzKTRmBBNjDi2u1Y++g2I7WxH19/IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD2O9sbCKU1XLjLTtECr4R4Q/C/XAmysJH7tHE8jEd8=;
 b=wRJGtRdpB0J1uW6jjV8dao6F8mr0nNyU1+85T5OsXESOJWBx/0apYLafTs5UdknC/Wcx15fJDrXwBLe/VNqu8AtSsP/cGCqTf3pTwhREWbBh2SzgISzejohi/3qSXULIWC53r0gPlQ6j/kfpCXJ3Abca5jlilqk5dMqWc9Qa+T8yu0kBKgfLmMmkM4hymkIArLtH3zWCvG89tOaGgcRwj/e3n879hTxmQdNkAjU+pcIlTogyFg/kLb3SKBUvcaty7briBeSOsQvYWG8GyFmhSx6fpZirjN3kohLa1W/R6xA5QCCvc6fbFCP7qv8T9lSUOLb68K2v1PCg1SgYfEQOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD2O9sbCKU1XLjLTtECr4R4Q/C/XAmysJH7tHE8jEd8=;
 b=NKeAqybW8VGh06+hoTOimANZiGnyvENT5MKZjRZkSw3//En2C5NuQsfZw0VzQmW4E4/kRIBJMPNRB61xzZxVMsWpkT7S05e35L1q2ZgYVFEJDuxtijX8L0IqjY3Kka4hw6HGrTX56s/7ljbdB4A4Lsxw5QWs9Tm+Z2o1j14zOsTPX9kofYN8YK7mHY8fYELzgEnSYk09W++/gBjYu74wZdldMnYV0N0o2W9ufUwFO1r/EgxCuSazeG2xB9fkWT2LE7GXQ5rLvexPpxIQha6e0RghcadFMRHUXDn+Y27oSGlwsN1uWPOOMZbsP/SpxYcUSvZ3ldUnBV0AuILYZsTuVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 07:38:17 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 07:38:17 +0000
Message-ID: <a895a50a-af0d-4554-8be6-7ae0f48296a7@nvidia.com>
Date: Fri, 6 Dec 2024 15:38:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: core: Disable LPM only for non-suspended ports
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org
References: <20241205091215.41348-1-kaihengf@nvidia.com>
 <a9f767eb-2196-4273-ba1a-19b07ccdafd8@rowland.harvard.edu>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <a9f767eb-2196-4273-ba1a-19b07ccdafd8@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf2c8a7-4135-4d3c-9832-08dd15c8f2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cklSdENkRHByMVJoMGJtVVRYMnl5ckE3TFR1ZFhzMFlWeTE1aWpHK25BRmto?=
 =?utf-8?B?ZjNBclJGUVpOa1ZFVitaRUE0TjJCNXFIK2ZnSDZhMVhaSXVDaVdPSk9WL3lV?=
 =?utf-8?B?N1owUGFGcWw1d2pGM0JIZTBiRHVadkxPYjZtdUM1UDZNQmRoZU1pQlVQV04z?=
 =?utf-8?B?cThEWDI5bzZSN2R6QmVSMlU0WkdHa1RMa0N0MjJLTmVlckgxa0dWM0NOSmJz?=
 =?utf-8?B?SE13S0V4eXErUFlMTlRPYnB6c1BZYVl6TG1jYlNsL29ob1VueEtCNUZmTW1V?=
 =?utf-8?B?cU5iR292L3NQVGRjVGZ4VlVsNGlwU0ZRV0xQZ1Q2a1BabVNxZWFWQ1ZzcWJV?=
 =?utf-8?B?RTVVdHZzZldYc3hXT0VLeE52T3c5SWc0UVowMXRHQVVJbWpJY0ovMmJQc2VQ?=
 =?utf-8?B?Z1JHeWdHcjVRdEtXNlg1NDVpblJrWlNhcnNaL0N1eWlNV1RyQTc4UUVxSkx6?=
 =?utf-8?B?V21vK1Z0bGdOT01zdXhuV0REbHBuRTJXenpIZWdJd2N0Nmc2RmR6RkRhQ05l?=
 =?utf-8?B?TXdRcUtoQTJaVnVkZFoyWmN1Um1wZytSS1JhUy9Zc0xpZHV2YkkvSCs5MFpz?=
 =?utf-8?B?YXlRbzU4VkdXVHlmQlIyRzhzZEFrdE1way9qbTIxZHhUdU0wU1hPWXZZV0hQ?=
 =?utf-8?B?UTR1RVdQUnBNM1NuNjJZOGRIeG11Ukl0R3k1eityVFMrQkttTjJaRzlONWhq?=
 =?utf-8?B?RUxOWlgwR3dKYmlSdEsrbmg2TmkrYThPejZ1UGZ1UWp5WUo2cVMwVkcySExU?=
 =?utf-8?B?bkllbStCbU1pRWp1OGhvd1ozNGNOc3VjUnBRRytSZ1hsNnV3VDV1UmEwT2lQ?=
 =?utf-8?B?a08zanRhMnZlNVdjaFlUZGtuODVSTWdmRXlWa3JhTnAyUXUzWE5tbmhoZUIx?=
 =?utf-8?B?ak5NeG5YQk43bVJ5YmtCeTBub0ROM25TamMzZ2Q2c0lERXo3MGVHcmZBeDRj?=
 =?utf-8?B?WFpDQ0RzbkhiTWhmVmlCci9qczF4VW1jQmRYUDBKeUkxNVpSdUlkMDlabXEr?=
 =?utf-8?B?MkRsdnhIWklIU3pSY2NvODlCalpnZDFBQmx2L3pIenYveGdVYkJ2YngyaERk?=
 =?utf-8?B?ZjJsK1BlWk5pL21DTGpRWEoxc2ZmZUxrOThnZ2RPaDhkVy9DdCtvTVh0Sksy?=
 =?utf-8?B?TVk3KzBsamtpMkoxKzB0cUVOT1k1eUo4ZVlmNWptWlNuYTJPdmdxUG5qR0tQ?=
 =?utf-8?B?SkhtUzZpa3kyUUUwVk0xWUdCTVoyd1RxN2lsM29XeHZ0RTdtc1JMSmM4QnVm?=
 =?utf-8?B?M09LalJxL3FtcG5tYkczY3FkZHJyQXpyZG9raUFOR25FRk5IeGZmK2xlMmZt?=
 =?utf-8?B?YWpkWHFmV3Y3K1lJdXF6cmVPTGJ1Q0pOVWZ6SW8yYWx0OUl4WlB1d0Znb01H?=
 =?utf-8?B?MStqVERGbjJjTERSQ2ZtZFFIWjBVRGI2N3puajhVdVF0WkNudXNvMXY2NlRx?=
 =?utf-8?B?cGxlZ3dZQXcwQWNwUEtxS0J6a0RhdExDZDNCS1pvb1c2ZHluMmNPb0dQbVpz?=
 =?utf-8?B?dVhSdmhpdHB5aVROa0JVd0JsbHBieDFFWHRxRUVETXJ5enVabG9RaE1RbHly?=
 =?utf-8?B?YTlEOWhtY0F3Z2tIRG9iSzdnNVVNandCQmRZNFZrMGQvY3dtY1BEVkRrbHBw?=
 =?utf-8?B?V1c5aldrakhqaFNlREtBQVZDZnlld3VhYXVnNnZ1ZURTdXNPejF6SVdxdzRr?=
 =?utf-8?B?WkRFa2ZKVmhSOUNIRG5HcWQrdGNUMkExbVRGNDB2U0VVTGkxNzZnVW9RemFq?=
 =?utf-8?B?d1haNTBKSlp3eXErY3djNVhLeWdTbWdNZDI1T1JCbCtnQnV4elNkQWJZR1pE?=
 =?utf-8?B?ZnhMZUlOOCsyZTdhVFhYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2pKOHIxdFRIYnFldElzVkRzaWh0akVUd3I4UnpTNzkrS0dzZERvV3lPaHVD?=
 =?utf-8?B?dTg4UmdaelNUbUZOenI5ckg2OTNnRHhDd2p6ZWgvcmVqdzJiTmlXek11SkhO?=
 =?utf-8?B?clBDYldRTS91T25ZMm0zdVkzVjVka0VKWCtHdFdpdXhrVDB6c1Qxc1VELzFY?=
 =?utf-8?B?TXh3UmVpTk5SOUtoUGhPcFpERmFGdUg2TDU2TE85allNS00xQm04c1UzWTVt?=
 =?utf-8?B?TEduWW9YaTRLOUdlU0lIc2dMV2x4a24vOERQSlFNUHZ3cFcyRG1uM1hjV0dw?=
 =?utf-8?B?T3RLNGVPVHhIb2NQdmVmUllvTEpvSXNGQ0FHZzZGSm1GZEVKQWdscUdlV3dp?=
 =?utf-8?B?MVQ0TEgrUVBIUnhCN0N1bEJWM1dHMEJHbGZmak9VK3BEaFo5clJpNVlHb2ta?=
 =?utf-8?B?cVhWTmRLd0dYU1lXdnBRTHpqT3JoRU9oSm51RjI4R1NSelRFM0t1MVdubGxJ?=
 =?utf-8?B?Q1prRUxvcSt5b3Q0UUdERG9ITk9PLzlDd3ExV1VDWEFJVnlyRXhqREZEU1Fp?=
 =?utf-8?B?WXRTRGNWd1RxSHFqRHM1N0dUN3ZNbEJGUVJrL1M1V3liM2dtOTQvMmQ4R01J?=
 =?utf-8?B?UlkyRm9GMkxlbDhWSlAxUnZSS0x5NHJnMjJzM3JTZnpvUXNsV3ZGVDZOdllN?=
 =?utf-8?B?SllmWDZyUVdWMDduL2JiOS9WOTZaN0JrRHkvc0FNc2FISllpcVRBQUp4REN0?=
 =?utf-8?B?UGhjNmhrQVpydmF0K1JVMjVsR2orenArcEd6aDg1QWkvT05iWEtrOHU2elR5?=
 =?utf-8?B?bzZBY2xrQ0MvRzZpK29Kb3U4KzRGTnlrRkdPT2NBZTZ1Tks2dEJrdmhSU2N5?=
 =?utf-8?B?Rkk5VWtoY2FmZnRMTTNjY0FzanJXZjNQS3ZJUXlFdVVUOEVKVUFabm4rU1du?=
 =?utf-8?B?T2lkZ1prbUIrblpBMklUZ2NzNTJicy96SzBvYkZxcEpxZ2I4VWNrVjdWQnlZ?=
 =?utf-8?B?UXdWa3hBVElPT3NBRllEUHk0MllIYityK1A5S20va2ltd092S3p6UXZBT2N1?=
 =?utf-8?B?L2w3cy96cWxrMGN1VFI5OTVSY3d1TGJTMnovVUw3NWtSWjlxemZ4b2VkZTNw?=
 =?utf-8?B?R09OUzc1RWZwZ2xhL3lta0pKOENyRjBBOGxOWHU0NGxKWmhLazc1ejJMbTVF?=
 =?utf-8?B?dzVSNnhWTTBMTmNLcXpiMG03WXF6N1g3THFLdWFSYlhFbzEzOHN0b2RqTTI1?=
 =?utf-8?B?K2Y2eU0zUHc1a1Z5a1pwQ084RVNPK1QvdmxOemlDbmdKM0hoM2o0YWVudXl2?=
 =?utf-8?B?cmJJY3VwVkR3UVlSNytlTDNxaGtJVlRSMnpKYjBZY0trNmliSktlb29HWDhK?=
 =?utf-8?B?Uys2bkZUWDUyTGhkUHNNRlRZeHcvSUdtVFNLdXlkWUVwQWgybUdoWTJMMGNw?=
 =?utf-8?B?SHgyamc2ZVFVL2VVQzRmWkJUNERHZXVVQnhWTUx0SnRCSlZ4c0xVWVRuVGMz?=
 =?utf-8?B?dFJyRFlhMjhCTDF4dWltaDBYS216UW1hb29jRi9CUkFoUnZ5VUFiRUVhbXFq?=
 =?utf-8?B?RG5CTVFpQXhxV0lhVy9pRktMc1JTQk1hWTZCbHgvWjZxY2VhRDg3MXZrMVJ0?=
 =?utf-8?B?OVFWd3VkOXVQVXFXcXlHeXZoczEvQkpOWkNtbko1NGd1UGU2LzdiS21OVWZu?=
 =?utf-8?B?K1BRWG9ONVNnNWJHZGpqS0NlRmxGa1htUTZNeHhpRk5pKy9Kdld3OXhNRW5y?=
 =?utf-8?B?T29TL1R1bFpsRStBOEwxSGpISkRKNFBmVEIrcnBNRi8yeWkxcDlRQnowTHVx?=
 =?utf-8?B?SzFEUDIreTk1SC9DbVJVaGhzZG44TE1BVElkMmZHY2R3WlJSWENhQXp2UFJX?=
 =?utf-8?B?ZmJqK0l6aWpNVDkwalpQWis3dHBuRFFKRStXSWJhR2lZUjVJNkVXRVcwL1F4?=
 =?utf-8?B?OHFiTGs3b0xDVWR1K0hjU3kreGNETWxYOVFETk5mcnhjVFh4QnI4VXhzdW5u?=
 =?utf-8?B?ODNBQVRiRFpHT29qVmgvV2hSMUg5NG9vVERtMlZURWx6MWNjQWRmbzQ4elha?=
 =?utf-8?B?U1duY1dTS1I0cGVmZXBPMjBMdlVDaW1Ud3MxcWh3a3A2QTNzdjJZU1RoNXJt?=
 =?utf-8?B?NDBBNE1WWW0wWTRxY3ptang4R2s1TnArQmozTTA4YlhqOVJWek1LUGJnUktt?=
 =?utf-8?Q?HHUWTugR3IZ22gUEXIPbSFYw2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf2c8a7-4135-4d3c-9832-08dd15c8f2ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 07:38:17.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sam+7+2OUEzuZEK0rFnokemo+DAp431kYBXI1av9BzpsUo+oyX5TpM56PmdOSsXd8iMls2rZH3Rtk5EF//e+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012



On 2024/12/5 11:06 PM, Alan Stern wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Dec 05, 2024 at 05:12:15PM +0800, Kai-Heng Feng wrote:
>> There's USB error when tegra board is shutting down:
>> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
>> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
>> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
>> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
>> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
>> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command
>>
>> The issue is caused by disabling LPM on already suspended ports.
>>
>> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
>> LPM, port won't transit to U1/U2 when it's already suspended in U3,
>> hence disabling LPM is only needed for ports that are not suspended.
>>
>> Cc: Wayne Chang <waynec@nvidia.com>
>> Cc: stable@vger.kernel.org
>> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>> v2:
>>   Add "Cc: stable@vger.kernel.org"
>>
>>   drivers/usb/core/port.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index e7da2fca11a4..d50b9e004e76 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
>>   static void usb_port_shutdown(struct device *dev)
>>   {
>>        struct usb_port *port_dev = to_usb_port(dev);
>> +     struct usb_device *udev = port_dev->child;
>>
>> -     if (port_dev->child) {
>> -             usb_disable_usb2_hardware_lpm(port_dev->child);
>> -             usb_unlocked_disable_lpm(port_dev->child);
>> +     if (udev && !pm_runtime_suspended(&udev->dev)) {
> 
> Instead of testing !pm_runtime_suspended(&udev->dev), it would be better
> to test udev->port_is_suspended.  This field records the actual status
> of the device's upstream port, whereas in some circumstances
> pm_runtime_suspended() will return true when the port is in U0.

Thanks for the tip. This indeed is a better approach. Will send another revision.

Kai-Heng


> 
> Alan Stern
> 
>> +             usb_disable_usb2_hardware_lpm(udev);
>> +             usb_unlocked_disable_lpm(udev);
>>        }
>>   }
>>
>> --
>> 2.47.0


