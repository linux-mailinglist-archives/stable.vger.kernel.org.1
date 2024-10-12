Return-Path: <stable+bounces-83512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60C99B148
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74870284531
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694212CD89;
	Sat, 12 Oct 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1q4caMr"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27C4C83;
	Sat, 12 Oct 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714681; cv=fail; b=En+BZcntkJgXQbK5aKacWdRAuY2BhyDPyI382z6YGBRrMNvMC+x62ACLs74dSwk6c3VVxBR76GdCh0HGmwONdxaBJZugaBN+r+Qb3rrFiTphNGXaag0dU//1Hi8Dj5C9hY2aEQF7xcOSXFiiEAQ/GIp3azTYzE2GS/BW54MNhYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714681; c=relaxed/simple;
	bh=TV35u2qpug2Tybx7aC6pgt8rTu0flvEgH4qHcAhQZdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=McI7Df5znO6JTqGb/IK/WEi34IawYMz4bym/VH+C3v3JGOBoLErqD0o7r1Q505rM0lDdVKYxdhAoXmfm89xdaxJKw3Rzm7PBLig7EtWmdgakqygXsyjiCpjmeTsZfx0U2ZVM+ilbJUDGxQNVINTEjMvLI2ynjVaJcsM4bOsSk38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1q4caMr; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfmfPMTBHHjiMiUwT0zToNfHSuZBAJTxoGoTIZBzrnfJlGNF8PH+Qn6U64R8zPf9IkSlj3lOqtkHCjaRDMYnqXuHx8J2k3UGbMMiq7ngC7Ypw4KSsu/XVBeoMM9CLnartSgPl9Y8dQXqyz77J+PkEtQHHrKcQWw2gqlrdnH61MrUGdV3yZlz2cfejZFNxuXH4XT/hH9ED0KH5A3jD9VHoFYphWZaBuzMpsbUGjFCd6AAtxGzuNPHmvplOH8doufC6hn1fn2X/4PchTNrMFpXhAQ3tPTO8Xbjt9uO3vAGuAWJQuvj6olpFHjWTwOTE9W3QiwASoLT0ndIpTu75u8o7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haDkHbOgvtPbsN5Gd+EsElqaJ20zM4LSNBAGswl2Nl4=;
 b=x0c+GkZhK/iIuU/BrOG82b3PYYGRN9/t+v1KgeoBM3/9VhEcrQn1Sb27oHyv0iMWZbpUY95/UNm4/O977GdxcWUfAO9LQ8LdUstQTEsPVcixDMz43xeMhuQIkMUVVF7fYGPhFeIJbs44V8Ox7zmxZ7go6vQcKAR/GNsmP74/nF/ib5VWc551Qw7tpOl4MxpC+EYe+hwx/wY/sKjsqyvidkQ2v92V6XAUCxoFRhjKt5/mfR0Ci/5IUQZLvkx94AzIiFvyihaoCVG/aV1UeL2sLNMK2OfIM4RgYGsjcH+uRD5n/oQO9Bgkb44UhntXDlhZQt+CtdFKIuYtpc7YLPGRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haDkHbOgvtPbsN5Gd+EsElqaJ20zM4LSNBAGswl2Nl4=;
 b=k1q4caMraOWrpCmJdl5AZMf8Fd9jiWVi1PNcp74Mx4hvJdhJBAEzeSKv3N3h95V8AixVs+cK2YoOALS8DTUEUF198kwnUVt68pqYaiprkbcMJJ9V11cOQQ8tvoB2XHiRLBVoX9lflqaeWo1FwOBDT42n8arn4jcaj0d5lXBzPUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sat, 12 Oct
 2024 06:31:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 06:31:16 +0000
Message-ID: <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
Date: Sat, 12 Oct 2024 07:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a062dd3-d642-4e31-c9cc-08dcea87799b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNkdVR0Z2w1elZkTHVySDJjRUI2SWZrclJSQ2J2aExGNGhYenVrdlBlRGhQ?=
 =?utf-8?B?NGtmMUI5V1B4bFhEanArTTJyTmk1RXJWY2NyYWszMHQ4dmdzN0Y0bzZIOCtD?=
 =?utf-8?B?aTVIaEk1QVhGL2wxYjk2QlZEWURxb2VBcUtoc1JheFVoMFRvL0F4cTJqUFk5?=
 =?utf-8?B?Q0ZHWUZJVHdnbmNyY1NEOUlrOC91cVVYUGk2K1ZqOXNMZ2llWGIzUXpNdmxs?=
 =?utf-8?B?aS8ydTE5cGdkV0FmeWR3alBYR01EbUU0clNoWGtVdGFIUmFwZFNNdXNwT2dr?=
 =?utf-8?B?K0Z5MXlxSWlWVkNoR3VWQ0ZTYU1QWURNckUwTWp4TUVCMmJScnVyODB5ZnR1?=
 =?utf-8?B?bitianV5OXE0R0RqY1JybHNKYmkrTXRIZXYvSEFMTXpOK1g0aHpmbm9mVy9D?=
 =?utf-8?B?QS92L2RuS2V1Yk5ZQjlOelhjcWIvSHNaVU55Z1hsSlc3Ti91QWIxVmJTNHJ1?=
 =?utf-8?B?THM3YjJic3crWXpLbjg1bUdIQmtZNTdEbmtzcGQ1cldHQzJMSnVvdEpDRjk3?=
 =?utf-8?B?WUVXejVyKzFxeGtvYndaVUpqOHZGb2wzL0t0YXROV2FVQzZYZEtUTjRxZnRG?=
 =?utf-8?B?UDM3RVppQ3NCaUxqWXU5NmYxN2U1RTVXbXdkcm1SazRZbm1Dd0M0ai9LZUVN?=
 =?utf-8?B?VXlIQU5oV0V2eG93QmdxVlNjNGpPNUJyeGlnOXhzbFJPbTZZd1ExcWRRbXBO?=
 =?utf-8?B?a3FxZkNLMm5mSWZTTCtJU3ZjM3lrOUpDWGRTQ0o0cG5naHVWcHRUdTRFU282?=
 =?utf-8?B?N2xpdkloVmk4d2FBeTAyeU1JT2xPeHhvVVFicDhBVlpVUzhLekpkeGhueTdM?=
 =?utf-8?B?cGxTMTMvMkFjUGpUQ1I0WXd0ZWdXMnBTQjhTK01DMlUvTEJnOXRiRlBqdE9i?=
 =?utf-8?B?YUpLRE9NejE0dzQ4VzYvMC85cW12TGpzVDNodFBZWExBWVZvVDExQVQ0d2VM?=
 =?utf-8?B?cjFGVE0xNzBwYlZXUXFvampIUUNmMjFDUmUyMkdGRk45c2h1RFBvSWRJczFQ?=
 =?utf-8?B?UVFQcDFDZCt6a0d1NklVYzI5aFhVUVplRTlPMXY5cmYyeWdRRDhZWWpRTlVB?=
 =?utf-8?B?aGlLeEVUQ3VwZ3R4d1BWT2M5M3JpaW1jUHZFMi82cUdMZ1crWkxuWjA2bTZV?=
 =?utf-8?B?NS8rdTBMZ1IwSlVjMEVDdHYvU3BvYmxESFNCZDdpT3I4K25hWUZ6TWs1SUxz?=
 =?utf-8?B?b285ZHMvSXM1VlB3a1orQ1dtNEZOMnkrZ3ZyMTd3SFJoVW45dXpPd3dLU0Nl?=
 =?utf-8?B?VFh2WFg4ZDFmc3IzK1hOMmZWczJ2a25iUDM2bytzc2JlZ1pPNEdEWjBEWHY2?=
 =?utf-8?B?MUMxUWR2MEJmY2J3ZUd3aTFycmZsNFhtNFVNZ3lTTE5nR2RoQkJHLzlRQUdC?=
 =?utf-8?B?S1c5bTVaeVJQekRoU1dMYlF0VGU5NlVUaUMrN0VaK296bXNnSlM0NVJnZjNY?=
 =?utf-8?B?WituRUpKNWlURUQ1ZjZxYWJMMkRScEdxcVJNUzVYTHhKWWhXS3p5VXpXd3J1?=
 =?utf-8?B?dXBTMm51VE5WZmxqRjZIR2xYbU9FVHFDT3Mxb2FNK1RZQyt0MkdyT1dWMm92?=
 =?utf-8?B?Zk0yN0t3c21hbWhNUmp4U1lIUnE0NkU3Mm5TajNtU2pNMzdEOHlyVVlnYldD?=
 =?utf-8?B?clNabmJVRWVCN3hmVTV1dWtVUThHUjNSTnlkQ3pjZytBbnZEcFArcytTeHRU?=
 =?utf-8?B?WHZ5bnlTa3ZsMkp2bnFUWGN1VVRJN2xiTElCaGJtR0U3cXI1VzNzWWdCMlZm?=
 =?utf-8?Q?NTxL7neM7cpYICKJ68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDNkVjVuOUdkSFN5dytBSmdobGRtdi9lZmdrMUtzOUR3RWtza2xKRDlTZzht?=
 =?utf-8?B?aDNvdmxQOVNpN0xVRldtb1RpL2F0MDhudGF6dUtUWGk3MlhybkZlQXpUa1Bh?=
 =?utf-8?B?MmcwRHNTZ0JIMjNQTTgzbkJMcnU0Wlh5VjRwS0ZuUjZBYmNMR2o2L1M2QXV6?=
 =?utf-8?B?bEtlb1AvMkdMaGVUckFlSTJZcnNCLzJMcU9aMHNERjlHdWRMMzZRaVVlYVJK?=
 =?utf-8?B?citvejNLb2ZpdXVSTHpzYyt6cXovZ25HbFJ2Zk96bjNoSjhUbFRsZkJ5YUxS?=
 =?utf-8?B?a1NVcXBjTEQyd1JDR1ZxR3pReEE3ZkdYcDVydGRFK3doa0FIZzRSWHNuVVdx?=
 =?utf-8?B?Zkg0amNUUkNWcUZlMGVvSmppenptQWZHaWNIZUJmUjhWd21QZCtDaE5uVWJi?=
 =?utf-8?B?aGxLVlRHRWNKUC9nY1UyOU5STHYwdkxnNlVDNEFCcFBVUWE2bUY3aU8wbjZo?=
 =?utf-8?B?S2tLZENwSFduZ2tmUmk1UDBpZnFWalkyNzkzVVoyRkMrTWZ3TGVmME9JSEtG?=
 =?utf-8?B?TFUyNlh5ODRHbjVqbzRVdHhlaDZQQ1ZlaWtReUVqKzBxV3lUWFBSaGpHZ2V2?=
 =?utf-8?B?ditCNFMvQjc2Ulp0aGNnNGlUSko1bGxBWkVFZWNFOUlKZDFaVE9MWlpNdCtm?=
 =?utf-8?B?ajVqekpkVER3a1VRY3NpUzhEMUVQVWRoUTB2NHRJS0VqTExUSStCSTVLbjJH?=
 =?utf-8?B?K1phMzdmRzRnZDJYcDFpYS9xakY4WVppRERwU2lsYndDQUtXNGQwOEROUmdN?=
 =?utf-8?B?dUlnbFFVMklNb2poRmxDTDdLTDJmd1VBNHFjd0RNanNweDE1V3JFeW95SUhG?=
 =?utf-8?B?NU1TQURmUG1yaGpUWUp6Vy94cnUwZGE3SEFuNVZYNVRNcTFxZGR0TnRTNG9H?=
 =?utf-8?B?eDYyaDg5Q29paEJNdjk2QnZhT0FRUWFnTFpOYk5FV01nYU1xU0ZmVlFOSUda?=
 =?utf-8?B?Y1ZZckM4bFpxbjNTd05yODhYOHdaaU43ZVBOdmRrY1pmRUhFQkxUL0hCTDdM?=
 =?utf-8?B?NmpzSi9hVVphWkowN0JxRkJQdjU2NG1ZQ1kxU3VocW9sczJVVDZhVnE4WkFy?=
 =?utf-8?B?U1czUUJielRIeS96akJqR2ludGhCcVUzUXgwZHVkN2RwakNHdFFkN1gwWXlt?=
 =?utf-8?B?NDExWUJjYzBtYjk5UnR5cDJrZW4vMTdoajJzOGhDTnRjZVRUd214d1NVVFJo?=
 =?utf-8?B?cTNUaUJESXovRVExQnppNExIOFYya3cxSjJGbVh4eEU4NlIzOFQxRHZhb2wx?=
 =?utf-8?B?YWZ2a3hBSCtvakd4VEtodHhMdW85eWJ0d09qMzBWdk1ZelJ3ZGtrYUwyQ3h3?=
 =?utf-8?B?OGRoa0MyMWJzR1RaVUZTdXpWMStaVVlRN2U2VmtySDVnalBFamFqOE1EOWEw?=
 =?utf-8?B?d1R6cUVTeFpKckRTOWhab1hrV1RscnUwNkE1K3NRU0gxL0EwTnpuK3FyV1Ji?=
 =?utf-8?B?d0IwcGU1TTBmTDRxWjI0amFqOVJqMlFiaEpPeDRSaWl6WEc2YWlPMFlkSzFH?=
 =?utf-8?B?Mmx4NHV5S08wd0NWL242UG05djN3MlAyMlNMcm5JbVpLN3NRaFJhREVvcTFm?=
 =?utf-8?B?VG05R1p3d2d5QktNSW43UFdCZXhkWWVGWitoV1JXVDluN0drdnVnb3oweWJH?=
 =?utf-8?B?RFMwN1ZwN3UzSndsTXNHZktSeGlKcXdTZk95bzVTRWZLR0hVdjNTVnh6WDBP?=
 =?utf-8?B?a2p3b1FFWHc2NVhibTdVMzVqRXJjb1BDLzBVZ0NWaTlFcHU1T1VJNkM1TTZn?=
 =?utf-8?B?b3hJb0t3TktNUVpyd1N5eFBTTTFUWjVNMVlDTjRvcEJ1SnJiK0ZtNWduU2xL?=
 =?utf-8?B?TlV5NnFOWm01em9UWVZaY1lLcWpocmd0UnhjUWhZMHRGVDRQaWc5TVpUand2?=
 =?utf-8?B?ajVGK0tHSnhwUUVRTHJrU1lzMmlsYncvYUkrQ3pJc2I4MVpHamp2dlMzQ0Yr?=
 =?utf-8?B?UW80cmNRQ2tOMk1GNnFZMlNyNFN0UndIK3VWWk43d2xoYTVidnovUzZ3UG1D?=
 =?utf-8?B?UFRRZm1RM2I3MXZ6U3Mza05VOS96QjAxeE0yQzJTRWk4ZW8zTjJaQWt5dHJp?=
 =?utf-8?B?MGV3RmFaNEVlZEJpajJtLzJmMWYrcjhDSjBOOUtGZU9raVdkS014WE9ERnJV?=
 =?utf-8?Q?sHwaYdQzPhkUjI/9z1b8gzZV1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a062dd3-d642-4e31-c9cc-08dcea87799b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 06:31:16.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZRnnueVEWqEnUajOPsqYU4yeaKVL+LxRAqAgAkrF1BTCpbBw5y3fbtLxlKopCDx1CbWtBY60M5TemXBkkIh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646


On 10/11/24 18:38, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> Hi Dan,
>>
>>
>> I think this is the same issue one of the patches in type2 support tries
>> to deal with:
>>
>>
>> https://lore.kernel.org/linux-cxl/20240907081836.5801-1-alejandro.lucero-palau@amd.com/T/#m9357a559c1a3cc7869ecce44a1801d51518d106e
>>
>>
>> If this fixes that situation, I guess I can drop that one from v4 which
>> is ready to be sent.
>>
>>
>> The other problem I try to fix in that patch, the endpoint not being
>> there when that code tries to use it, it is likely not needed either,
>> although I have a trivial fix for it now instead of that ugly loop with
>> delays. The solution is to add PROBE_FORCE_SYNCHRONOUS as probe_type for
>> the cxl_mem_driver which implies the device_add will only return when
>> the device is really created. Maybe that is worth it for other potential
>> situations suffering the delayed creation.
> I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
> device-readiness bug. Some other assumption is violated if that is
> required.


But that problem is not about device readiness but just how the device 
model works. In this case the memdev creation is adding devices, no real 
ones but those abstractions we use from the device model, and that 
device creation is done asynchronously. When the code creating the 
memdev, a Type2 driver in my case, is going to work with such a device 
abstraction just after the memdev creation, it is not there yet. It is 
true that clx_mem_probe will interact with the real device, but the fact 
is such a function is not invoked by the device model synchronously, so 
the code using such a device abstraction needs to wait until it is 
there. With this flag the waiting is implicit to device creation. 
Without that flag other "nasty dancing" with delays and checks needs to 
be done as the code in v3 did.


> For the type-2 case I did have an EPROBE_DEFER in my initial RFC on the
> assumption that an accelerator driver might want to wait until CXL is
> initialized before the base accelerator proceeds. However, if
> accelerator drivers behave the same as the cxl_pci driver and are ok
> with asynchronus arrival of CXL functionality then no deferral is
> needed.


I think deferring the accel driver makes sense. In the sfc driver case, 
it could work without CXL and then change to use it once the CXL kernel 
support is fully initialised, but I guess other accel drivers will rely 
on CXL with no other option, and even with the sfc driver, supporting 
such a change will make the code far more complex.

>
> Otherwise, the only motivation for synchronous probing I can think of
> would be to have more predictable naming of kernel objects. So yes, I
> would be curious to understand what scenarios probe deferral is still
> needed.


OK. I will keep that patch with the last change in the v4. Let's discuss 
this further with that patch as a reference.


Thanks.


