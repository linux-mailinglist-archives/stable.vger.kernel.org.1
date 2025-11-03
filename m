Return-Path: <stable+bounces-192186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63ADC2B6D7
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 12:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F5C189786C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6A302CD0;
	Mon,  3 Nov 2025 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VNmzVTWe"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDB30274D;
	Mon,  3 Nov 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169391; cv=fail; b=QFpzZ3C7f15aNymSZMUc8j3AJhYXX0oLQm7+PwhjYUKKnHr9nFxgTA91MCTASA4Ri0M1ILsYfs7WxVK9KOVkF75M1QwR+8NWSCOM9lyytV3poNzg7tvCD2+IPEJr9CMTy003PW2hDvDX/0DBjqbFJDS7VZHuUfFeSGU9gUD9ITw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169391; c=relaxed/simple;
	bh=xquu4XXa5WRBzkS9/L/q7P5Bh4kAfhySYzPqy62YzNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U9KyC6UkTgDpo8ZCy+S8d9CQTFPJezeoqPOPc2spkrsIzTILLM9vogNE+O70U88jR5b4yblzw3Ybv3zbHS3TnI9ybB0PwUs1ef9GEcMvSfsNX3PO/kSnNr/8rsatR6C/V9qBT6c3JATmp8wlwmFKfAk48zma9gqRYou8LsitPLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VNmzVTWe; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGNKxIpv6eleUi0SgEOZDur+negxlJt6SdLkr/lu5D0fa7AB9o5oP9bvCCiGfByxxUm8qSBS/blKVkqNBAKikl7nbSWc+6kQ3sj0TtJIlM3g6NQnf7J7N6dvreaQjoY8ffFuDEfxQuZq2s/CXIqbYZCApr7cwN5qVHgVj0SlJUYjfbansxI8Adirb3cfBKMQDO6dOe52lI4hk/HvsmsPKbQfBcfUbqSOUBB0uaDFkj5fpgCKvipP7Z/4mHRHrZtKUS0bjBg/OuaIdw+Phf/VGjb+WDz0YvrOdcHwrSRwpoevKNiTpEpJ+ZSA3wKlammbo6mUxtRL+WoJ5t9IQMf/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqkduFg6mgUgf511iXmBO8BSG+40Qi1HeXkBWna9Zyw=;
 b=EntKVcQCB8tkDuEsiWOuecvoN6z9u5mBvOv5Ka0Uh7tq7jS8HM4qlc0ud0pXjdCnqG9aNRKYX6swdrf0SF0/LgfPxgr85IagC+Wu35EdNUXv5jhr/nVt6uryWC2pBbdWKRb8wXTryJPRk/yWHm3M7iSO6iZRJOzfKyZOZ52Zx+mGc6furVB+wCCKLAmo2JjhPHxV6gJ/zZXxa5psjYnGhgqG6zba92EO9EUCkSQMJ0JeFS642srb7NxqcrW/DemZRI13xlFHwrDEICTdQ3DuHWdK+HNcUQ24TfeZ+DVJfryDAzZxp2PoJtQtTcNUEDBN5gIXWPu7szk8mHCqQ3Lt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkduFg6mgUgf511iXmBO8BSG+40Qi1HeXkBWna9Zyw=;
 b=VNmzVTWeVrFBBI2uaGenXPVwzENg98HJXm9rnpX4lLjHfATZP34QaFgUp67ZELkFo9aejehKWphLt2zOSQrhCY1FxNaSOwcmPtZ4ngciXRNJYt/IIrEMVOOADLDkSf0Ec8LNsmR2b0POSbz97nZfsHag2mKOx2/pj7r2HRCwK7awy+t9KSnjoDJkPAa8LIcRiTPdBF4NzsEFGI219heo6R6OIklEirJYGC5lnnyDYE7CYMP0TH2wOlEZvy5Ooe35jRaiVfhtgSFRJIGDY6RKNGD0ieyKa04ABGgfs22h3C9VAK/fiLFW32Mgve4uNTWnSZcOc4S6gSNpy1wlEHm/Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:29:47 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 11:29:47 +0000
Message-ID: <2998fd1e-98ed-438d-a21a-c3595a6bfc21@nvidia.com>
Date: Mon, 3 Nov 2025 11:29:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Fix error handling in tegra_xusb_pad_init
To: Ma Ke <make24@iscas.ac.cn>, jckuo@nvidia.com, vkoul@kernel.org,
 kishon@kernel.org, thierry.reding@gmail.com, mchehab@kernel.org,
 wentong.wu@intel.com, sakari.ailus@linux.intel.com
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20251103103038.8193-1-make24@iscas.ac.cn>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251103103038.8193-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0243.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f067eb-d850-46c3-f28d-08de1acc4b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVFaS2hockg5M2l1OUZ1YzUrVnBJblVkK0oxZ2lReEorNTRwK3MwbzhHK01x?=
 =?utf-8?B?aDVQNUsxcHNaWXBzQTFFUWhsWlMwdkRxdms5MmovVkdIWEZCVGFoNys5WnlE?=
 =?utf-8?B?QXF3a0Jna1N1MzA2SndnVWpvZXdGbVZYMnFwQ3BYdWdSTTQ4NXVPSUIxUXlz?=
 =?utf-8?B?M2FNM2NCUTVwbmRyRnJDeVdZYTYrVTNqbWVBMFNaRXZyVjZDRXpvbmJOaWVo?=
 =?utf-8?B?cVBHOEtoem9NVXg2S2J6NnZlS2cyeG5UVGtxNWR4cmVvYkVzRkI5djY4NjVs?=
 =?utf-8?B?SzlpQ1BrWE9Pc2xiV1VFQTBjN3IwYUNrVHRqd0lWY2dmQmE5QThNVTU3OFgx?=
 =?utf-8?B?bTB2b0thWWRQSkFEWDQ2SVRGN0k0eUxPU1U2bG8ycCtYZEs4L01JRnh3ZWdF?=
 =?utf-8?B?MnMwVnZxTXpDWkVOVFhuaFBnSjdYMWNLUGM1OW1Sbm44RXZnRjV5TTdYWDVV?=
 =?utf-8?B?ellVM3poRUVjWlp5SnFRVVU1aHVKM0dnRWtHaWhMVlVyY2F2dGtxYXdteXdh?=
 =?utf-8?B?L0ducE4zbnVxck41TlY4Vyt1RytzQXZwUU1ZWFNidEYyb1EvZnI5bWFFWHRs?=
 =?utf-8?B?YUlVSmNib3E3Q3UydjhVZGJmRlIvbFU0WDRRSHZIQmtLTTJYVTFseTNxMTRR?=
 =?utf-8?B?NmxubkNZckNlMDM5SVIrZ2hSMkpld3BBK0ZWdWlBT3FiT0VYMnNVTEhwZ2Y4?=
 =?utf-8?B?dVYyRGl4eERWMktpTWxEa0tHMDRFaGRUVlcxYmVWNEhjd3JtNUxSMGtpbzhW?=
 =?utf-8?B?WUdoZ2ZpOGVBMjBnSXhyVjdrZEMvYXNCRnA4aGU0MDRucExNdHBCNVVtK1FP?=
 =?utf-8?B?cytnNGN6RHJaYWFSTGpUSGhMYzg1dVRkKytFSk9Ebnh5eEd4MTJXZEpTZTkx?=
 =?utf-8?B?bkNKR1pWRkt1Z3hCV1p5RDNLT0ZGWW54U0FvYlVlVnZXVTh5c0FrUkEyMDM4?=
 =?utf-8?B?SnEvQ1JwRkQ1RGdrOFAyRGo3YUJnUVl6aWhkNURuMGxzaVArSjQ2V1R1SEMw?=
 =?utf-8?B?T0dDNkVhQkd1WE1LOXlIVzBWQkJzVGVNZnJjRmIvQUM1anJiUDRKREtpOXpz?=
 =?utf-8?B?UjladDhYYllVeEovOExJRmdlMEM4TTZNSzdsd2xONEpwV2xLZkxtVDFEZTJD?=
 =?utf-8?B?cjBIVnp6cUJkYkNIK3NsMXRxR2I0ZU1YcXVZYXNVczBncGtla1F6dEczZlIz?=
 =?utf-8?B?TGxnYkRmMDRrQ3pvcFE5bmxSTGRMOTEySzFlUTlSbGsyanBNcjlUWE1Nd1Ax?=
 =?utf-8?B?dHc0Q2RpbVVXVmMrMC9YMmo3VWZuVmJicjVCRjRZMTJzYzlPRGJWMmlDRzhJ?=
 =?utf-8?B?dnNYRHFUY0grL2NqZE5yTk1mbmQ3K21NcGRmMXlIZXJBbnFhaTVNYTluZVZ5?=
 =?utf-8?B?ZGVwTUpXeUNMNUc2eDdpcFNoeG1PdCthKy9ra0JyVzlwZ0pNVlRRMnZmd29r?=
 =?utf-8?B?MER0OWlNak9VSFZDNFdHRk90RDlrdzZBdjJGMkQ3a3NBYVgvdXhLZVVVZUVL?=
 =?utf-8?B?SG1ZVmttQVFvOVZSbGZmZ0RnNXVnYzBuNjd6emF6VUE0d2dWdlE1RFJDYVUx?=
 =?utf-8?B?SVpBSktEdUduRmRybFFyNjhrcnVJaGp0TTFtMk9LWHhENTlnbGlZbzFMTU13?=
 =?utf-8?B?Z0xNSmNZRkpjUGxoTkQ3QnNnUDdYODludVloV2Z5ZVI3enlZUWxMY1RzODlz?=
 =?utf-8?B?RTl1c2Q1MyszeWc2RU81SGtQUUNuZE43RndBTHRmd1hjVlpZaDI0VG4vamR5?=
 =?utf-8?B?TjExL3k3dVI3aXFTeGlMSHNuRnhDbW10TGovbExIMFFIT1FONTV4c3ZjMHpN?=
 =?utf-8?B?dmFyd2ZPT2VONnNhRUUyTkUwSGZlR2RtSnQrc3RFS3lFLzQ5QktOMTFuaVhX?=
 =?utf-8?B?cG5WUkpLTnR5aG14dWRsd3JPNGN3b0diYTRiN2FGVWpJSlhzMVZyalF6S3Rs?=
 =?utf-8?Q?FdNI6vWmqvhVOtGsmT19Eyz1ZlFBCPjo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1hZXJSYVEzM1pLQXE2UTdpdVVzc2RkOWgwTlIzUTI4NWJpeHRETVErSzJ2?=
 =?utf-8?B?a1hYbE1xTDRob0pvUG5UcDhOdmIrMDhqYzlQRjZ0clJYam9zMXVKd3I4VGN0?=
 =?utf-8?B?MGFvT0dOU1IxdEVjaFBNUW9hNG5xc2hUcDJESFo3KytQMlZKd0h6TUlaYTZK?=
 =?utf-8?B?SWpMVFhNRTl2eDM4Q290ejc2cUFsWStTTENrN1o3K2piZXRqVVBGV0tNaEwy?=
 =?utf-8?B?aFQ1aTIxTFB5b1JWVUQ1NThhM3B6N0ZTK2ZoT0Vjdlp6Z1VSRU9tVkJ2TXNP?=
 =?utf-8?B?R3dMZW1HTnhYSzh5RmNzeGRXekhzc2hsVWtlYXNLWStLKzFnWXB6dy9FL2F1?=
 =?utf-8?B?MTUrQ3Bwc2ZyV0JLMVNERktiVDNodVpHQlRBTnMyUXYxN1h2SllJdTRRb3A1?=
 =?utf-8?B?WWdOVVZtNVhWcVBWemJWVDBsckVMNTByd3RDL1phSUtyZXZ1YWJSbTd1NkVJ?=
 =?utf-8?B?KzdRK2F3Sm9CSThIb1dxSEIxRVdGUWJwR2FabVhlRHRMS29ZVVMydGRiRDBB?=
 =?utf-8?B?NkZsaUl3SzNWS3YxWFFmN3VBY09nZ2RMRjRRMUJDNXVJdEp3OWVvenI4Rlgr?=
 =?utf-8?B?R0NaNVRnY0duL0tCTFpsMjlYOGNJRXh2NGgzQnJmVGtlNGE2UGNnam1vTzNQ?=
 =?utf-8?B?eE0zajVkMDNKRlJvc0VOSjBkdmMyOGIrdm5LeXZ4QUovK2xkWlVxaE5rRWgx?=
 =?utf-8?B?bVhVSGt0YUJ1L3pReGV5NDJpU2lBaHZBZDJvZUxSRGtUUDBhTFhFNFN5L0Rp?=
 =?utf-8?B?UDRac2c2MERFdUhPRElaVTNvZ0o5L0FndGt0SG5SSytFL3JSRnZ2aUxlS2Fv?=
 =?utf-8?B?SDBGNmhXZkJDOFkwU2NsaE45RDJNaUNNN09DUWxaRWF0V2dISU1KNEhpVXNa?=
 =?utf-8?B?QTl2eUdJK0dLeHJYUGo2cjRWdU9zZFlFZG1KeEoxNGU4V0d5ZVZ4MHFDN2J0?=
 =?utf-8?B?dUJNY015MHc5MEhMNTIrMGxiODM5MDdNc3pBcURjbVk1UHl5Mm0wRk9BUllJ?=
 =?utf-8?B?a2F4UUpjbXZ6ZE52QklzR0tIS1hyNFlyeVdlOG9zQU5mVUt5MGJBeXRiRkNO?=
 =?utf-8?B?TytiSWd0dGxndko1QnNnL1dicWFZT0p5Umt6MDF3MDFYcmJmWTF6MVZNZTBQ?=
 =?utf-8?B?UDVkcE9DdEJ0dU4vbStLWlQ5UXF4UE5DYVcwalpGNnE0bmg5akxqNHpCbnZu?=
 =?utf-8?B?NUVkdGo4Q0M4ZWxUQlEwOVFyM2JzSi8rajFWR3o2QnprZmhvRWFDZEVWK1ll?=
 =?utf-8?B?Ui9meE1HSTQyOXJOZXY1VmtGaDhzUlRhV1Bxdnk0eVlDR0NSREFDRmhaVmRt?=
 =?utf-8?B?MkVtVmc0TnZXWEVTQisvU2lGYWw4S3Y1YVowUTBiNCtYYWd2aGJWUkVaeDls?=
 =?utf-8?B?TUt3VUZvZTA4VW9DRkpPeWU4L3FiRHp6aG1Tcy9wN3lYVC8za25ZdktPYUo0?=
 =?utf-8?B?UzlRZTY4STBQWitZVVhsTmpIYy9BQ3RKSGVEYmROQVNrazM1eGVZbUxKcFdY?=
 =?utf-8?B?R0lFU251WjNKcWFmSXlmOFhqN0U2MHd0aEVVZzZhalRVcS9mVXluNSs3Ui8z?=
 =?utf-8?B?blcxdXIra243L0U1dTBvbWNHWG9Rd3V1NXJ0ZDlwKzE0MWdjdjBTRkJ5Tlpk?=
 =?utf-8?B?L0s1YytMdTRlNDNPai9Gbm1DNnRvdnpFS2lLaTI5ZFN4MUhTUWlHamczdzZ3?=
 =?utf-8?B?WXY3TTZnVVRDaVBTbm9XMEdtNFR6NFpiK2YvQzdIaTQwZjE3UGdENmJCMjEz?=
 =?utf-8?B?ZEVuQmN6SFg5ai8valp5MUlnemtiaHVjME4rZkRwNU0vcGpRaVZ0ZTBhS2Zo?=
 =?utf-8?B?RmdLN2tiM3JITEsyU2VVRVc5c3dvenN4ZGIvY09ENTVlK3IrY0VNaSsvYk9U?=
 =?utf-8?B?am1wWWNzTmwyNitSb290Q25jK0tZZEhzWVdUQ1ZiZ3FvVWZ1RVpwRE14aGxN?=
 =?utf-8?B?T1JJMyt6eWtNdFlxNTg1M05zQWVKaDM3S21NMDR0VWo5bkxvVy9icDgrQ2Ns?=
 =?utf-8?B?bE9iNW9HNW01WGNFcUtvTWpFNkVUdi9aYVYySnNXM1Z2WW92amJzMHkzVlNJ?=
 =?utf-8?B?TVpNT0pmYUhLSXRtbnBEN3loWjhTbWJvUTl5eTRlZ2kzY1lPUHg1TTdwR3Bk?=
 =?utf-8?B?R1hLY3czcndHSktsMkJlRHNTOW82OURSZ3dIbXB0alNNc2F1UzA2T1RVL0J2?=
 =?utf-8?Q?39LrSMy0BTIZkf9TLPnja2T7MMpPD5fdoK+9Yk1nWBaW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f067eb-d850-46c3-f28d-08de1acc4b27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:29:47.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWXMvSww0wPE88catDAGnkubnAILATVVNnsiXUmDE86m4hxIYtqsp3fhkoOzXCi7YqKwiAtJ4wQok2qO01fGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144


On 03/11/2025 10:30, Ma Ke wrote:
> If device_add() fails, do not use device_unregister() for error
> handling. device_unregister() consists two functions: device_del() and
> put_device(). device_unregister() should only be called after
> device_add() succeeded because device_del() undoes what device_add()
> does if successful. Change device_unregister() to put_device() call
> before returning from the function.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 78876f71b3e9 ("media: pci: intel: ivsc: Add ACE submodule")

Fixes tag is incorrect.

> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/phy/tegra/xusb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index c89df95aa6ca..d89493d68699 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -171,16 +171,16 @@ int tegra_xusb_pad_init(struct tegra_xusb_pad *pad,
>   
>   	err = dev_set_name(&pad->dev, "%s", pad->soc->name);
>   	if (err < 0)
> -		goto unregister;
> +		goto put_device;

No mention in the commit message why we call put_device() here, but this 
does appear to be correct.

>   
>   	err = device_add(&pad->dev);
>   	if (err < 0)
> -		goto unregister;
> +		goto put_device;
>   
>   	return 0;
>   
> -unregister:
> -	device_unregister(&pad->dev);
> +put_device:
> +	put_device(&pad->dev);
>   	return err;
>   }
>   

-- 
nvpublic


