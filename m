Return-Path: <stable+bounces-160249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9FAF9F46
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529163BB790
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771523D2B6;
	Sat,  5 Jul 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GTtf3iVj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1B2063F0;
	Sat,  5 Jul 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751706381; cv=fail; b=U5hng+vYO70SUcTFnDMV12tCee/d8OctJa5YLSDlctOBpbGgryv2uU223pjVPp0XkBPLfMCS3QBUJiES/cJYB45cJldh7fEUl8wm9o24X2lZi1Kv9oMDL6htPkgkDvy34cQKoFPdMtVoz72GzGcpZwloRSvQZ9oqOo6ay5AKDO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751706381; c=relaxed/simple;
	bh=6mw1jfWCXz8hW9EDtM9YtmXYjl5X+NGakDvcYzgIuS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVC4sJacMNJV3V8LQ24Rp71rozsHCucr/v0UYAxifgiaG8uXPhLeQPWYQ2aVAI9QkrbalLc94tutuu3MY+rR49Zv7BqRLZ7m5FbFR5XIHim50GHgn7fLg4rUDdXoCJYHjrfufFZuVynBkBLgSm6jGrWQleXh/+JKTmHBl0rVFNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GTtf3iVj; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSnq4RADwAzQVStxJAsDAtQlKvAlPu8UWuZUEXEgvMFzfZfRxvK2tppJ4lZnaSlnM7NCDfzMPB+/w7u9t9GPCKh49G6nBkwFcKdXxBMGRf6H20/YIlXXRAmqSjPMKcNtuAVKTtxT5KOJupONmDwyROxiz+grEJOaxqXURNLg0iGhkVbCMw5dqLImCMmeamut+Ju6waPOcb+I9nH7THnYkzV9pCBUZSGu480REIM8b8+9reCqE+8YvQyoepWvRQ1Ki7JGfL3SDF/TGLfvZiBIWwmLyHeJYEUKrk69TZq9GLlbqF0NNcDJok5bycAYSTR0TpN0//WwVvcCRtO2CVOpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHg8xw0kawiSmabA2SHwL7MEATC/Q9Bi736cnVmlc/Q=;
 b=hLNK3ccRjHH0fH+pOfIUtB4DAew/xxapOD7G4pBSrDAgUjj5kmB6d1Zs5DujYSq7lzm9IywXDfUDcK3SrEHYsZ61eqZ/j446nqh5mrrRHThWz7GMOEQLe5SlwY14gtcYreD3fY2NV3Vn6qlTRoYJ2HnbStivNqVEZWpC3KVoVyyzSwol9j/bCFa6+1plRp+zmv1iNYHZWtI53lyScFwv+qGF2kpsC3mX8WUrpflwe/K5ar6EQO21EvNxTea2BocI/o44gqu2adsgogRDZUeVmnSOucDaMQdZ7L7t6icjwQf08N49kJ8Y9eetEHkZj2SZpysHk6Mf+YKwfemb7pm3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHg8xw0kawiSmabA2SHwL7MEATC/Q9Bi736cnVmlc/Q=;
 b=GTtf3iVjOAOBplH2R6Xn+ZIRwC0UaMyVj/k2o/JtfXX4IluawpzVOSSzk6SEAr9H54GvRdmJVvGIEbQeBx4yzGq+k40rid3wYRk67vjfc1ZXuC9pViQKlzSq0CrZVV6I5puKbH1RiPwKF4r46LcJ/883aWoC/XNL3BzvRYPhhD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Sat, 5 Jul
 2025 09:06:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 09:06:14 +0000
Message-ID: <2899b993-af9c-41df-b36f-c6a5235089e2@amd.com>
Date: Sat, 5 Jul 2025 14:36:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aa5f2a-41da-4176-609e-08ddbba3317a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWtndXZLeGU3TGhYRm1HZ3JaRjVVaU5pUTRkZEFKb2lRSEpxcTBJRVhNYXgy?=
 =?utf-8?B?ZlFIbEYyeHZPSUNQb21Pd0l0Tjdtbmh2Q1c1OURjYSt6UnlRa0dhOWRZVDJK?=
 =?utf-8?B?R1F4STc2NWpUNVJQSEsxMENjZWJQSCt0bUlhbkkvWHJBRWRXcko5ZG5ueFRt?=
 =?utf-8?B?WEZQL2pTOWFPN1E1ZlpjampoUnAvRUtXNWd5ZzZraThIWXVBRVg2R3VRc05O?=
 =?utf-8?B?VVo1b0YwZzlJdzF3RUZRSlhyZHNJMjkxZ0k2WXRRL1VBQ1BLdW4yREQ3ZS9q?=
 =?utf-8?B?RENYVXBCcTRtRlBkWGFXRVloNnloRjJOaVBBeFFzMDJaaitVblV1RjlZaHhH?=
 =?utf-8?B?aUtwMWs2K2lKOUZDV1ZzQS9EamVtN2JIRzhjZkZKM1hWVERZSlQ2eTAxNVFR?=
 =?utf-8?B?dmg5dGVNMWJVMXZRVW11TGh6TEsxai9Pd3NpRFExR3Fhb0QrMVdqVlpLODJC?=
 =?utf-8?B?NUZqZks5ZEpscGphT2liYXlqdDlHMzhTOVl5b2YwL0lnUDNBUW5UaFB2SGZq?=
 =?utf-8?B?L0RYeWdUNC9tVTNRcFQySThTNGVnTlgvZEdYRy9Fd2lnYTFhWEMyTWE2a0hV?=
 =?utf-8?B?ZjFibGMwMmU5b3A0QTlOQzlFdkVMKytNV09rVlFoaVkzODlGcWlTUktaMlJ1?=
 =?utf-8?B?V3pLRzMvMGVpT3N1c1VDbkNqaElqM2JDekFhWVFsL0VmLzJQdlZLZ0dpU1E4?=
 =?utf-8?B?MTczam5iYVVNRnJibHhaZ1ZXTHBYbTJKRmt3b2JCdUFNMWpRd1BhK2ticzJY?=
 =?utf-8?B?M0dYS0hSVENjcFQvbU5aQVZHaWIwdlk5djZ4OWJCLzFTeVdDN09KbEt6WU4w?=
 =?utf-8?B?WnJaUk5aaGFuSU1lRmpKTGp2T1BwWk1ucytKenZoUU1XQys3REQrWklLU1JK?=
 =?utf-8?B?c05IN1o4RjdNYkJidG8yVXJublpCdU5qTWNPY045NGdtT2FWU25lTDB4aEgz?=
 =?utf-8?B?MGNMVHN0SlcyeGwwMzFPN2lLTTkxRW9VQVBpVEVqVmZyc2doaGlMNVYwd3Zq?=
 =?utf-8?B?OVE0U3E5YkFGUjFxd2NEdGhVYnlCN0RtclczY2ZZOHBNMldXcCthdlhjdmZK?=
 =?utf-8?B?eEpjK0srVEZ5T0RWaUwwaUZUcHArZzdvaXhpSUIrQnNxN2VXQ0xtcExJYzFI?=
 =?utf-8?B?UW1jQ05QaXlhaUxFa25wbTgrQy9zOW4rNlJoL3BGcDVQTDBnZ09MRW1oVGNY?=
 =?utf-8?B?SmZQazZUUmFuOHZQNVNkamFrQ3BaVWY4K1Z5S1BZbDgyMjRIWnUvOXB4aVIw?=
 =?utf-8?B?MmF4MmFHckpyNkdsOFZ5ZGVzbWZONXNTbEtzWVl5UlBuaHRVaXFtY3pmZytD?=
 =?utf-8?B?TmJaa3FmWlBJT2U1MC9BbGV5ZkpQWGtGazJXN3BncHE4UWU3VnBSSkNFK0cy?=
 =?utf-8?B?eSs1Z3ZZdHNkUmZJOUorcE4xWndhbU5zUTZyRXBQSmV3OFpEcUZQc2VUUTV0?=
 =?utf-8?B?SjQrTnJnMjJjR1F0R2hZWHFldkt6cStLVlYwamt3L0puczFhOExpcEZKUndJ?=
 =?utf-8?B?cGN2ODZVcU5WMExRQ05KVnlDRUh2VXYrOTA5V0t5akVvR05qUUhpUmRjTTYw?=
 =?utf-8?B?VWZCK21LdkJZdC9hdG44cURsSUJMTTd2OHMzNkx2NldiaE9tbkdDTm1kYjlQ?=
 =?utf-8?B?dEhaSDFoVmIxSHhnRTZINUFOemdOUCtLSm5hUTRJK2cwZ1ZYRzdqUVZrdU03?=
 =?utf-8?B?aDcwWkNGUUdwalF0bWg0YW0vZjFCMWFQTHNGOC9UNUdWNUtVZU56YlRjNjUx?=
 =?utf-8?B?dHhPRUlWUXp3Y3UrVW95THJxY3lIWktvUUZ5bjVtUXVLSUFxajJONE12a2tV?=
 =?utf-8?B?djhIWHpJZ1A2eVZYMlljaElVUXdCNUt0SWtaOHZzWHBpRStCMWtyOGQveXdO?=
 =?utf-8?B?M1J4bHZxOTQwelVUNWxPTitnRGQ4OEp1VFE3TThUS2doa25pRDBMMjhIbjR3?=
 =?utf-8?B?NmFmeTFOQkcrQVNjWGwyWHRSMHA3N2o3SE5VRGFVdHp2STBFWndZQjlvMGc3?=
 =?utf-8?B?eHZad3Y5UHp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lQZ3ZYMGRadDdpVTR1WUpOeUNabnNZS0xXWmR3bFNPSnpjSDFtUmViM2h5?=
 =?utf-8?B?bmM1VU9TM0Z5YjcrK2NPZU8xQ0JpZU9mMXBISElpdUFGQW5qR2tqNlFaTkha?=
 =?utf-8?B?anRxMDNTcFdOWW9XM3FrSWpuNzJmeUNOMHdwVGZmZ2o0L3hGSkdtWTdleDFV?=
 =?utf-8?B?NUsvNVZEaDNBOU5id0RGL3BJL1BTSkxoZWt2S3F1YXBLME90anNrYzNhSGNp?=
 =?utf-8?B?ZXJBZkI1WDFINmJTNUhhZm5XUTBGVEdTSVhkcTNab0thWTdUaVlTNkNZdW1K?=
 =?utf-8?B?RzBBcVJ6TzZkQXlIQW4rVjcwWXN3ZzAxTjNUbUtlYU5VZUlHNWRWaTA1TWF2?=
 =?utf-8?B?Q2M1QjFhYW4zOGF5WXQxMURhSWtoNms5cm53dFUrT0J1c2s4M2xrYVRDUDJD?=
 =?utf-8?B?YnhCVUdvQ3d2d0FxMTVzRzlvdEMwUnJNRytDSDU0WTUrWVpia3QwaGgrQ3Vq?=
 =?utf-8?B?YnNVREQxd2FZbVJJc3JoN0ZSako2eVE4QklXc1hGbmNwaTFIbE9Bb1dSZkFU?=
 =?utf-8?B?YkpacGlXdGM4Zy9xNk9xYVlJL1BiWExFbjYweGRTWmtCOURNU2lXcit6TzVy?=
 =?utf-8?B?QUhOaFY3LzA4b3NNd3hLVkRobUhITVZ4NXljVWpvY0tiSnJWYnk3YkNubTg4?=
 =?utf-8?B?SFpBZnhDTDZmdHdQWHphcU5ZbGdpOU9GTDFiSjBXdVFETGlZcWRac2xkOEdv?=
 =?utf-8?B?WkFielg5OCt6WFZNcDBDUE1XYmFwVkJyT3U3V3hKVm9JRExOT29tNnhJa21S?=
 =?utf-8?B?NnFWSnNINnN1Qkg0TmRMT0ZEMkQyMWNHTjQxblJEc3hPZ1oyS0J6WnZtNTA0?=
 =?utf-8?B?Y3ZrUWxUYTJhTWF2VWxrbE1BajhveVVHRDVYMVdVYnIzSDNKUHRDS0ljMmI3?=
 =?utf-8?B?M016bU14QStpaXU3Y3Rhc3V3TUM4a2FMTFdaeXppbHN4WE51Y1dBdGpZaWR1?=
 =?utf-8?B?UzlzRXpwTVZMVzc0QUN5OTlpMk1xWnZWM2dHeFFHb3daRzVsMGlyT01Hbmhh?=
 =?utf-8?B?RHF6RGtGQ1F5OTFvb0tiZmg2dDJWSmxaaEtSdzJ2WHJBWlBBYlorMUh0Y3ZF?=
 =?utf-8?B?RitHQWJNSVRBOVY5cW9aaU1FeVQ4TWt3MVBXc3NOQ25TcjA1VEkxZ3hMQ0J1?=
 =?utf-8?B?OER2c0RtM0VFdDUvVWU0THlHWlF4L1pHcDl5QkNnS0dnby9FWlpvSndrd0N2?=
 =?utf-8?B?ZHFGUTIvMUQxTVVENk1GK1RnMEV1czZQRHVBMVIrZ1M0anhmd2NLQjBuU1hV?=
 =?utf-8?B?MmhJWGdqZXhTVVM2TEhXZkJuTmZRTHJRcnBFZUMvTkVXM3F5SysyS2xDYTdR?=
 =?utf-8?B?bUhuSTNWNklqc1c1ODFCRUtmMjQ5WlM0em9OVnhUOXRJUWdmcFZmckYrWGl5?=
 =?utf-8?B?SkZ1VlRYdXhxRzk1NU5FMW1GSDhjcWJoWGg5K1d2T0pJTnFLOGVMVG5aMnFX?=
 =?utf-8?B?bTVib1ZrUlQxcW1DUVR2dnpWclRmY0M2T1c5MEtrMzhYdDhvcGtrU1B0a3Qy?=
 =?utf-8?B?U0lybk11U2E1U1NjZUVtUm5IUFhuUFNyUmFiY01uaTJhTHJkUmMxeFNORjQ4?=
 =?utf-8?B?KzNNdmRaakRQNDE3RWNwQXhFemZGSXNjQ3FzS3FxaUtpa29Hd3p5ZDB0Qisx?=
 =?utf-8?B?b1VxekpEZitMNzU5Qm1RNDNGQ29UNDQvbXVyMlRrcVZKRUtUVnVJdFlSNG1H?=
 =?utf-8?B?cTg3MDB3UllzemptY0pSdVpEVEJHdVh0UCtyckJ5bFJCbFlhcTFxZ0k4SDZ6?=
 =?utf-8?B?cS90cjBra0QzSnhjSjc0NndZdDJGeGt6amx1K2pjcm1qRzNDUEVpU1BpVHZh?=
 =?utf-8?B?bzRhT202bitSSytBdUE2a1kvSWRjb3BtYXFNWHJNRlV1ZXVSK2hTcUpIajhr?=
 =?utf-8?B?dldZZm9Rc2tCRVNraWtWTDd6S1BKTW9iYWUvK2kvZGl6WmVRNXh4dUNWeGUv?=
 =?utf-8?B?Y1g1bnFHbXQzK016Y2p3b2tQOGNZemd6MXRYNUJ2a2p5ZUhlL0ErKzNCYzVw?=
 =?utf-8?B?MmVpdkFsZkFtUVVYUU9Nbld4MDhRdkFaR3F4YWpjYm4xNEdHczJ2VVhGQ0lP?=
 =?utf-8?B?emhWc3Q2eEVmMTRSc1lHU281MWZPd25BTHJyNStNK09VZkk5amVSY25KcmhM?=
 =?utf-8?Q?m7LhdnzMThApy/e8T7lMI4k68?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aa5f2a-41da-4176-609e-08ddbba3317a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 09:06:14.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt8zuRWAATCiTP2jt3A+RuIH9v6tndTaOQNUl4EdmzKPfKJgdMIW4pEy4McYDiUlDyr/mCa6NgrZIDWEFc/dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684



On 7/4/2025 7:00 PM, Lu Baolu wrote:
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
> 
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the
> IOMMU to access the kernel portion of these tables.
> 
> Modern IOMMUs often cache page table entries to optimize walk performance,
> even for intermediate page table levels. If kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potentially
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for getting this patch. Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  arch/x86/mm/tlb.c         |  2 ++
>  drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/iommu.h     |  4 ++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..a41499dfdc3f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -12,6 +12,7 @@
>  #include <linux/task_work.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/mmu_context.h>
> +#include <linux/iommu.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  		kernel_tlb_flush_range(info);
>  
>  	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>  }
>  
>  /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..154384eab8a3 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>  #include "iommu-priv.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
> +static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
> +static LIST_HEAD(iommu_sva_mms);
>  static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  						   struct mm_struct *mm);
>  
> @@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>  		return ERR_PTR(-ENOSPC);
>  	}
>  	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>  	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>  	/*
>  	 * Make sure the write to mm->iommu_mm is not reordered in front of
> @@ -132,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>  
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_enable(&iommu_sva_present);
> +		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>  out:
>  	refcount_set(&handle->users, 1);
>  	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		list_del(&iommu_mm->mm_list_elm);
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_disable(&iommu_sva_present);
> +	}
> +
>  	mutex_unlock(&iommu_sva_lock);
>  	kfree(handle);
>  }
> @@ -312,3 +327,18 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  
>  	return domain;
>  }
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	might_sleep();
> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 156732807994..31330c12b8ee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1090,7 +1090,9 @@ struct iommu_sva {
>  
>  struct iommu_mm_data {
>  	u32			pasid;
> +	struct mm_struct	*mm;
>  	struct list_head	sva_domains;
> +	struct list_head	mm_list_elm;
>  };
>  
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
> @@ -1571,6 +1573,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
>  #else
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1595,6 +1598,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>  }
>  
>  static inline void mm_pasid_drop(struct mm_struct *mm) {}
> +static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
>  #endif /* CONFIG_IOMMU_SVA */
>  
>  #ifdef CONFIG_IOMMU_IOPF


