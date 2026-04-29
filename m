Return-Path: <stable+bounces-241920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHn4ILc88mlypAEAu9opvQ
	(envelope-from <stable+bounces-241920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:15:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6244949813B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58F403009E2E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11324410D19;
	Wed, 29 Apr 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwQtUA3x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A33FF89E;
	Wed, 29 Apr 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482929; cv=fail; b=iVq0/a9mAVIveQZHby++IS8PtqfaTBi/q+FXo2lDfCS5wmITvUqXAWr5KjbWNqEjlaESxRkIsDm/hBvBtzRjnm3g7/ZYQ+3+cqum7671Nmj58l1t/g2l1HoZFD4yNko/sTeebjmgvG5gUYipCz/ovxlDF3SEItBrJ7NzzEMosmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482929; c=relaxed/simple;
	bh=jCQTeq7wH2GTlDEXqkEUDZm/xIOMqByEsN0rv5IPvZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqF/Kt5ovZnbHfTh+r45d11TpzsVvpelHzsnniVZJHnfMj6f0KeqvHsRHszg5iWOvBn3jXjZcLGdXfm6vXTKDfP9jwL52+9jcANAMnz3CvoCdQzsKmmFqZnvOi6GWIeXZjq/POEY1FsypRPGrhEqj5EPjsob0gaYYNev+JE3foo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwQtUA3x; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777482928; x=1809018928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jCQTeq7wH2GTlDEXqkEUDZm/xIOMqByEsN0rv5IPvZE=;
  b=FwQtUA3x+Po7WsvAE4NPjw2QXMUgN8IX3CKseEg+gEMMejhiKz1wXG1y
   MVw7bhZ60R7+BmV4kbQ4COAvq5m+FfT95sRiFoNagq9v7/R1u1m0CkePh
   OPLMjJP1AEIwFx4s67Il8cq5KUVleXmc/P/9h8TPzKxqvLqeJBu+A5yKr
   gR+KcTWG33uKMwuYYCZ3RlugQroNnRecxFs+BpfT9bj890WWKKwvzs+TR
   1W9lhxVdXWU4f2KEXEoubj+sg+PgDa3Y5psXaqYyowd5eG2tu5Cq3gbGt
   iMuxBG/JcPVeIUayARryy7mIWtcBZPxFHrFDQDlD17sm/OM06YjV1iSUo
   A==;
X-CSE-ConnectionGUID: nCjBwWGzQmWlwrQed+KYeQ==
X-CSE-MsgGUID: JEcE4GbjRV2bvyrWW12oIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82277120"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="82277120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:15:25 -0700
X-CSE-ConnectionGUID: hm50nINQSuG4d2amadqLsg==
X-CSE-MsgGUID: GYrEZxoNR5+nLpA1u+ARiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="231695075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:15:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 10:15:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 10:15:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 10:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxEoftnf2tb/4OCLOcwIjk+gBUqiY4MCiQ4XYPhn5mCS9a96k47rn4o92hkYKgwdiRXaEghZmnlDVb85yA5eZvbIM6HsgCkLS3palYUHuV8+w+hY5/Eyg8u8vssgyVclzOT3qgGlvabqpRBUbfw5dtK/TYY9o0Ug/217tkmqJZEsNRNjILwCDqjOJNhnSJdl3kRqYofPF3NLbSCtkRK3nGEEae/uwXjZwPaO6aHsLNeM7/FyPlpB8UYhGIpkm9LniXJnEtmcARGCRxqybf/NSmN1NtWxUvNRJXRXQFfMb8w825Jt30dQ187qBfM6MP64FJPsZfIWFKJ9AcXUB7ajmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kold0Dem8Z7NIuF2nOPR7/2WdvpMKKjs9dxGsI2B8fg=;
 b=GdQmjR5MNAtKFd2ilJjAxax22AQdflcV5UZbbTcgQT/LWaSANvSZS6VXpK1wdlgdle1GDB/mPnH6WD6TVqvibI/TkkEELynPK8qdoNEfGaQfb7DAwuYDprmYKlUaFqAnyjuGyDJrEFlpgF9D65eoL2j3KcKMgXoUT+qnSl3FXCgzdH3nezEX9iA5mMh77kdvJPMS/ZP4xiTfJDfxtlNKHEb+IT2PdYjBTHHiY6RiLT8jRQr7XzL2zacen+m8MCJaVKsiWmPBbpS20XZXjizbng03m0+czIK6lcBOkH4ruqpIWwtkkd7HI/PcmCc/hFwW/dcb1pyGJoBNX0WfRw2CoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 17:15:21 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:15:21 +0000
Message-ID: <3ef742fe-9761-4714-84d9-e72fabc5def1@intel.com>
Date: Wed, 29 Apr 2026 10:15:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@gmail.com>
CC: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<criu@lists.linux.dev>, <x86@kernel.org>, <stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
 <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To IA1PR11MB7917.namprd11.prod.outlook.com
 (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|MN6PR11MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f84fcad-b5ca-4759-ee15-08dea612e4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fp0AesFs3oddeuX7CKTMF5Dq2a4E7IjFhbpUFYVGwT8hm3tsEhNE6tTSFkLLkR1V0bFjR8XyHWZ9N5UHW8f5la0GpeongTW9A5Qa2/h10BQ0+CvBAU8ww5kN2EFh1ENQGX/RAcQl1I7DKsfxBIXVOPH+BFV+MgsTRXUrWcYINuqyQjMmUnXxvfdzFgloxNAjkcy9N40LTKIg6z15Vo9NnM71niVSYKlHS2rsAi7cjy50FtE4fHrWylmwV6NCBT0OpGA2AYgjGB3VetEnZHPQOZ6m3K1QpNKMP/hQIchTpnEZKTgrm+Ej91Ff1Zjn1/K98dJcxZ/2ZK1+TQwjrUnvEPHtRnAQtzCxPVrHas0lJ70dCm+WJ7BplZMmqz0z3JRxgZ2FIKcee7MQBjwuhbbCvx/3t5Fb0r5ie1Qqda0rfvZy2ly3zyIV49CNNQeY0/HXJI2gCir18unnYb4umFx/DPbetv5ZW5AXoC+h84uvI2CHN916rLMpGaJYptxxpQOMh+4p0F9GLJwhtkMDg70krvo76+JUKP06wpIqZfNXgE7NbuhfuUQfDgmlA606bZ5tEtIdxkqy70FrQxZURjC02GDRffZqggfzSbITFcsIttCJ/3XtEoNbx12xOvdE6BLOPTjy6zzh3+i2y7ZLsacbqZah8qNDlMkbaN6K97YJMzVUSSf4xX9S1SaDg+tx4VyYtloZEDa1C51ZQpSjyYnYCGSejdWYh1aKATToKuboees=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9BWjh2WVUrRnNxTEZ0MFRiVFpEckFxSGNUakRtRnRoaS9mY3BnT0lkWXZr?=
 =?utf-8?B?MFJhbzl1d1hCYjN2dzVkdWtvM1lOTFoyaUVGTWFIVGhKRXFXTUtnL09YLzRU?=
 =?utf-8?B?TnFoT3lVeG5mc0xYeHBJSStpZzl4WWZOU2dLYThCK2M3YmhYdCtvb3pBOW41?=
 =?utf-8?B?WEdRai9xaHB4OXhYT3hiLzBwd203Tk03UDdxaUw4MkZoN1dxZ2dWa1d6UFhP?=
 =?utf-8?B?dGg2d3ZxdTMxenM4cW9RbVI4ODcwUjI4NTUwM3pKNXM3WmFsNHEvWWF5K2hJ?=
 =?utf-8?B?dlVQSzFoQlA1UnBFWjdtZGlBWW5CaVFubjBQL3hhVjI5V0NUYU9POW5EcUU3?=
 =?utf-8?B?bXdrcXovWk5qVmQ5VG9EUndsWnJyTVk4U0xYcGZEdlNDb1NGZjZLSmZ5UGho?=
 =?utf-8?B?bE9BZ2EzMm80cXpTUTcwbEdscW1HWkFpcVFXNWJUZXBaZ3BUTmo3eHdQeWVl?=
 =?utf-8?B?dTQ3dU1CbzJsbFFYbG5STHV2SUszWklQbk1ibWliV2MyTnVGc1JRQXVzd3V3?=
 =?utf-8?B?Rm5BUWt5OXlWUmpUZEFqdksvT3JjUk54VFBCY1B2eFhTUUZyeWVzVGFpbm82?=
 =?utf-8?B?VzRaMzlGaG5QQTdDM0dCUm9RbzZ2YUdlOUVBVnp0aU5ZcGFPQlo3emQrK25n?=
 =?utf-8?B?YUhOeGxzWXlpOEdUMlpYdkx6SWlkMFd0Yy8wa3dYRk82T2lFWDR4ZHBpdGYw?=
 =?utf-8?B?Y3hqZUJLRGNIc0F6MHNCQkxwTEQ0Sk5SemVkcFYybllSL1FHSm9YdWVvOXJh?=
 =?utf-8?B?ZHpPTlVmb2hEa09WVU1sK3ljZXlpTEFmb2wvV0drVXlONURORnNFN0ZrbGNW?=
 =?utf-8?B?dysyTzdSVWJPenZyY2ZpTFJKdzZNblhpZU43Y0d6eTJyUWx5SE5SVDVrREZM?=
 =?utf-8?B?bUpvblB4MG15V0h4TUJmNlZYcnNHZzlNUXExUWFZa0IrSTFDQW01TFU3QWZP?=
 =?utf-8?B?T1RGRy9yZEorTFkvek4wblZ5ZG13cGdIUmMxM0kvWGV1SW9DUVFDeXk4dkdE?=
 =?utf-8?B?bEFSYzc3TW45WmNybWNnZjNOemdsZ0o1dTVlQ2tDMW43MkJWRWtBQjNjYlln?=
 =?utf-8?B?VENLWlVtRTB2V0UyalJuZVl2UVBZY1lQd3JCTlFBSzlSWVV3Ukc1Q1pEZ3ZU?=
 =?utf-8?B?MC9nZmxnT2t2Y25rNzIrb1RxeU5aUnJERk4rM25iODlPeWhOWUVUbko5eU9y?=
 =?utf-8?B?dlB3dHNSVXNBMkJyK0UrNVlmdVNtN0d4eEhMdlN2NjBiblM2eGRjdHRwQ1F4?=
 =?utf-8?B?UGtLUmlJdUpyNFp2V01pOEFXOFZ2MUZJMXZqQVRkMklYL1IwODF2bHZuRzRh?=
 =?utf-8?B?dUk1YjR0NUVjb3dzcTFycWxxYmtvYkxWR0w4cmZPeW5TQ1dkYVBmd0FLNW9O?=
 =?utf-8?B?bXphTzk3WXVFekYyVkR3YWdMQUphVjRtZ1VoQzJ0UmxGNkZsRjNEcjA0ZTFO?=
 =?utf-8?B?V2xsRG5tMWFtZVZ1ZWxnMmFxVjM3NGcxNXN2Wlp4U3B6WVFReXkwbW1Cai9O?=
 =?utf-8?B?ZTgwRVVTanFaWm15cXR3dWpHcnVPNGdycXA2UWNNZDhsdFBHRFhQZUh3ekNX?=
 =?utf-8?B?YWhiNlh3bnJETk0yVE9nT2hqblRaaGxTSFdlUFNCd29QS1VLSDBYS21ocmhC?=
 =?utf-8?B?MFZqRkNkSk5seVNicDQwYWtRNDhJdDlLTGpaeUNQdmUrVjQxOXpQL3hmdkFr?=
 =?utf-8?B?OUNGeGY4VDFGZmxKZE11MmJkSmt3ejFxNEpKSHFRUU9UeVlrUlVGd3pvbmc4?=
 =?utf-8?B?TXdiYVR6ZVgxNWc2WnJmNVdSL2NmTng0anF3WFpOUWJRU1l2eU12czB0dFNS?=
 =?utf-8?B?QkJnTTdhdUp0NDdHdHZVSzZqemc1LzJBQUZDcko0U1ZGRmZjUjJEOWRqZ090?=
 =?utf-8?B?YVFLS2htREVLYno2cDh2aGVwMERWOENoTTNXOUNMdlZWeHVvbmNoNjdKRUxt?=
 =?utf-8?B?M0lxT3lmQUwxK0s0ZTRwTXpyNkpKRE9tWFl5WklJNUowbUNheU5ic2RLdXRw?=
 =?utf-8?B?Wng0R0Z4aG9henA5elRYanlHTGNhRkFsOHZYaHFpM2F3VGU1azNKWHZPRERL?=
 =?utf-8?B?SFJTMGdVUW92UmRJbGg3ZjNCTDYyQ0xMamNBVE9MNTh0cG1OV0tjOFIyK011?=
 =?utf-8?B?NkhLejRnUTA2NFBIWTFQdWFhVDlTWE1NTEppeTNqaXpJajVVUXhaWWhBMmd2?=
 =?utf-8?B?cFE2ZFowUjV0ZVNveWpBSDlLNzJQNFpCamlHUktSZnNvdU9zUVozWDZhZ2xU?=
 =?utf-8?B?SEwveUo0WFJ5ZnRuUzRtNjNuQ2EzM2wrUTRuRDBqQlZIN1BxS0JjTEx5emVh?=
 =?utf-8?B?OTdjYnN3ODlJZGNNcjR5ZUUvbmZ1dTBXMnhwK3AxNXlzcnc2dE1DNnRrWWVq?=
 =?utf-8?Q?lHgL05Znzqcm2RW4=3D?=
X-Exchange-RoutingPolicyChecked: LKRgJ5FmsOWpKvAGSYZgqQqGohVZ9sG07VnbK8lyVmZDzkn8QKDKp/Jg6FopP7h4w70fMjrgOPtdOj0YN4i5xMMSfyNapP6DxH1fLAKMw1D4OJrBeHBm2B7zaiZdgT3k70l5RO0PdY3f3IrZJvAROJZQv6S4zjl3XYZNnARy1EdvEmbvJuucI3a+Nk/RMzT/QHDHK5E/nvzSFRXoT29tI2dL/6ZTlEBE/12RyJQLo5PaIK4MVku2ZwMuje6p44Wv9S/6GD8m492jsH61vmahiBlCTTn/BkI4I+mWz7fjXWJVJG1umKRiEFEhb1xew4mgTIVTmA7PhNlLsj+m0ANxdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f84fcad-b5ca-4759-ee15-08dea612e4d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:15:21.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDqS2J7itd0RC9fYpWDIh4atF22JTwhAIAVIdsoJGfRqLxZVniTw99c5qkJmvy09UnP6AtuwQk/oj19Ncg9NayEYFPBQPWswi6qCdKwA7Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6244949813B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241920-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/29/2026 9:44 AM, Andrei Vagin wrote:
> 
> First of all, the reverted change broke backward compatibility for
> user-space. 

The ABI itself is still intact. Do you mean that the kernel cannot 
strengthen its sanity check logic? The change does not alter the ABI, 
but enforces stricter validation of the existing format.

> As for layout compatibility, in most cases CPU A (older) and CPU B
> (newer) have compatible XSAVE layouts in terms of saving states on A
> and restoring them on B. CPU B may feature new extended hardware
> states, but the layout for previously supported components remains
> the same.
I don't think this assumption holds. For example, with APX, the state is 
placed at the offset previously used by MPX. So the layout is not 
strictly append-only, and offsets are not guaranteed to remain stable 
across different CPU generations.

> Even if CRIU were somehow able to locate these frames, extending
> them would be impossible. The target application stack is not
> under our control, and other user stack data or local variables
> reside immediately after the frame.
I’m confused by this point. If the frame cannot be adjusted, in the 
first place, how does migration work across systems with differing 
feature sets?

Features can be introduced or deprecated over time, and a snapshot taken 
on one machine cannot be expected to run unmodified on an random machine 
with a different XSTATE set. Some form of translation is inevitable for 
any cross-machine restore mechanism.

Thanks,
Chang

