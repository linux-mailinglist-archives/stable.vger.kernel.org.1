Return-Path: <stable+bounces-135125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A336A96C09
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1012E189E741
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479628135C;
	Tue, 22 Apr 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnOegJQ0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE218CBE1;
	Tue, 22 Apr 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327301; cv=fail; b=r7ADRyOS6QeDTpZ+4aRp9Wt3+r69Ow/ORXj1BdE+il7Z+85fpOtT6G/eLxyJLMQDsvjmQjLb293QtbIqo4vNM/5UlckAbOq9OnT/QmDXQEta/oFStnrtSRsY5TEcMKHZn2zLxfFf21fJrtvI9EFvGgo7MuwmZYACWx0GthP0Qa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327301; c=relaxed/simple;
	bh=DSJrnVFYmxyNMWyoowaXJ4Jcea5PQ69m9+d+zbJngnE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpyGpM83MaJ/XEtxzJnUVLwHr6Q4oentLBLBt+f71Iy9aKyezX+AEtIeXx7d7piR/v0EJbbnALOzhUZ5QNjMA3ekoUVOnmxxlaPf799I8C9t1zkD1/w10oLWtwM0WIpPGKT/8LMCrfQPmKpD2Z2a2mp25JhGLmktyqSWC6ujDDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnOegJQ0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745327299; x=1776863299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DSJrnVFYmxyNMWyoowaXJ4Jcea5PQ69m9+d+zbJngnE=;
  b=CnOegJQ0NIxM/7SyHRV8+guyN3D6YFj9GMoIQSF7DE2vJfg6uuudgsdJ
   rYRlgky1s50Ft6g/a5tArX5g2KR8TpyoxrEJ5uRtVlTcOxBILtv4EFhoe
   fXVK9w6hNxCKYmPeGz7a146aVRhw8XwzdevWyk0y7N8uORSMvHdNa8joM
   OzJEWxEU0Ir6yAgwhJuBFQ2rm8TDfmMwUZ27cWEZQoctEPa5iJnImVELo
   qH0mtwOXcubZ2tsLsa+6FqDecGHcVkrnsdYoPGrEEtjsoKuGGTm+bpnnt
   fyKo0Mic3BeW8Y7b0zyJQxMT7VPrbrnmfMF2JmenNtd82vKD/1E9g5o0D
   w==;
X-CSE-ConnectionGUID: mrpAw9N3RBaycsPKO4PViQ==
X-CSE-MsgGUID: OwC6Rxa8TTGtaK23cJlgtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="72275638"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="72275638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:08:18 -0700
X-CSE-ConnectionGUID: k+eU7p5cTs66urAN8jsnVw==
X-CSE-MsgGUID: TQFQenG/RoulVPPYWEyh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="163060671"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:08:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 06:08:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 06:08:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 06:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4vxJyGMExmn+HdUEKAeCSTIwRt5SGtTw95/dVOzl2Ydb5DZ9iOZ1vK8prPXfatv4lNiisG8U5RcevTlujYO7fNMFFDFJnWnkKtiQHIZGQeHW/T7t9NPCS7wNwGIPKJ61PYSHqz2f0B86LcepqcTXiX1PGzGlPzZwvmSA0q1TmuY9eZMZv/VKW6ClTI5DjsWLxBHEFpTUyDXoAq9SzPxeSdmjXJE7+vY85en/gb9gbb4yrXq21GBO8v5dWdADJzN+DjGVLrPljaqWEMeC1Vh1xokaBohKJYBjNfj7TveKh00CpvjwRikm3TCn1Yt4K4ZJIEqCe/hlXrQptGoSLIA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i48ZhSFhfuNRA3QZFxPtv7wnyMk7sYbhx8Hi02Y4eM0=;
 b=Vb/OyheGRvLcyUeGfFea0pa7+X2WmS8K+p2hTq1IXbDBRmxCK0DAj1CabiW+ig0uSL6G+lpjuyA3VLBODw2sXYm7RzKGMirBIogdV23WON6n7e8W2e9/a50pzeBBvJxXGtYff8kWcgsrgFINbzGPZ17BU39hHqff3Usu6jIPyA+euz5b5Go1R2rvoJKewVRdtDLNR9B7TJO6MwL846QwcWziVr1GUnapgdtB8/ZmvnRtf2p1Bc8lPKZbPX8uMedEYhfN+AVQnmNTm8eUWkyRCywMgUGoKRCRurAXUor980Ekic+I+Vo+e6ifhNPs/rSRxCjTWdyXtaZSdY0El144Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 13:08:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 13:08:09 +0000
Message-ID: <2c1e4c0f-ab98-4f74-9084-1ce1db984f2d@intel.com>
Date: Tue, 22 Apr 2025 15:08:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gve: Add adminq lock for creating and destroying
 multiple queues
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: <jeroendb@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<pkaligineedi@google.com>, <willemb@google.com>, <ziweixiao@google.com>,
	<shailend@google.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250417204323.3902669-1-hramamurthy@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250417204323.3902669-1-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ea7421-2a50-4803-87e1-08dd819eba87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmxobUdvVjYzNGpmcHlwSE45bTg4QW5RemNseENUbVVmd2Rkd002cm1QR2Jk?=
 =?utf-8?B?V2JqaHFJVjFxTWY1M0h4aVRvNm5XVng5NUMzYi84ckxlZWNzRE1aTjduNGxi?=
 =?utf-8?B?Tk9RS0MzV3hDRENUSS9vNGlKT01IMlhKdk1tUUJIU3pBNFYwcUhlZ2RFdWor?=
 =?utf-8?B?bG9CUzQ4ZEo5VUVhRDIydHpZS0FHMWovY0xsMmVQOFJ3czVRR0Zrc0Q0ZS85?=
 =?utf-8?B?ZXNCQ09qd3MzSkdqZlVseHRqSnRhTTFmWFNYcmNaV2xtUmIxTTJoWG9DYUto?=
 =?utf-8?B?NlBMQnBNZE9GZmJnSzhTZzcra0xDSTN2V0RBT2dZNG1JM21hQkNvTjZnNnFv?=
 =?utf-8?B?Zlh5TkZDdEVINjlESWxYUXV5UUFkRldIbUtBVk9Za0NWekhWdGxUSTVuVUtO?=
 =?utf-8?B?Mk8rYlBHa3QxYjNiSTlxT2ZkZThuWEpKSXRuTTlMelZkUVZqb3JqM01GZDlt?=
 =?utf-8?B?NjM4UzVCZmg1dU1PVGZ4cjg5bUh3Y0FBdTVRY1ZMT29qUTR4WHZxUGtiVHFp?=
 =?utf-8?B?YXExaVlDaHpBbXB5cmxHcGpFQ1oxWURVYXJFQlYwV1JWSHh5MlNHSjEyRDAr?=
 =?utf-8?B?M2JvWnhOTWhZWlkwdUp5SjdpNmZZUmFVWTlXajIvQUhTU1hvSGdXbHRveUFK?=
 =?utf-8?B?ZlUrWmhoUWlLaVczTXNlQTJSQWVRRUVVajlHV0lKYy9Vbk1UTGRLQlRMMVgy?=
 =?utf-8?B?UisySUlXVTNIb2pvTGFReGlJcmZ4enFrd0RFajdYUHkzL29VQWMyeFhCK1Y3?=
 =?utf-8?B?T0doQ05NeXkxQkdTQzFIM2RsWkNBeUcrMWZvNFFlVGVTTU1QM2JDRlFnSEFz?=
 =?utf-8?B?WUZ4UFhZQnMvVGRSWEU0MUI1NW5BY2RTRXlEWDVaWmRCeWxjUzhCT1BkSHYy?=
 =?utf-8?B?TVppZDNrKzIwVW93UWgza3FMQ1BwVk1teWtxN1JjNTZMYVhiWW1DY2hSYXF5?=
 =?utf-8?B?YmJ6Qkx0ejVyR1NsL0ZCN3RKYVNaWE5FK1BaSXY2UHI0OTdJVFl6dnB4cVll?=
 =?utf-8?B?QkhDdWVwSUxBWkhjN3Vnd2l5dE9yOEZGcmhjY256NXNyai8xbGRFc1hEOUM0?=
 =?utf-8?B?UW15MkgzT0hCSHRUYW9EcjRRdTUzaEdoallhaiszUlVTcndCYWZ0WHA4bVdQ?=
 =?utf-8?B?QkVjVnExMDNBOEZsZVdoR3B6WXVnWExqaFlQeHJyODlldnJMOGRObHRzUHNn?=
 =?utf-8?B?WVlwVTVUKzY1RUJlZFRwVHNpdWd3RytEMTdDcTZpdThTbWx1WFJxbzBTcGNm?=
 =?utf-8?B?Nm5Nb3ZodmRHSnFQUnpiNnZ0c2U0QUNhZk1rOWVTUGVBTk83K1A4eFFjcHNM?=
 =?utf-8?B?SDZmMUljZHI2UkdMbm5VOS94T3dXMjBPRGpOUk1CSU9kVDRnVy8zSWZKUjZv?=
 =?utf-8?B?dmYzZERtQVl4NTN0MzZnM016T3lZMVVkUG5mWFRLTkMvOFFkaTQvSCtRMHAv?=
 =?utf-8?B?SVBvTFFVbGViaFBibGZTQ055TmVyZGF1c2w5ZmEvdzlDeUJ0WmZTTEoweXRQ?=
 =?utf-8?B?amNFNkNHVkJXUWRTdXgzcjRlb1dLanY0ZkNhalNmWFA2WFhWY1FSQjFJYVBL?=
 =?utf-8?B?SmtuZnFUY3JwWTVFM3QvRWdXQjlFRklGVU5KQlpkZktBRzh2Z0ZPWW9lbkJu?=
 =?utf-8?B?c3dOb1ZCS2ovSmY3aGNCU3JjdHNHL3BSb3Zpaittb3ZZdUdKZ3M2TTNXdTZ0?=
 =?utf-8?B?c0V4cVJUeGhHVThUWm0zTGtBRmtGNDlLR0d1YlVJbW91eXoxUnJBc3A4TG5l?=
 =?utf-8?B?cWxSSUphb2J6bWl2QjZtSFdoMWV4UnlKaDNMTmpRekVYczk0NFIyaGtNSzAv?=
 =?utf-8?B?K2tnUXlmemdxSXhGUnhiSzFISkRPejBCWjhZQnY3Qm96aWxYdXV3M1V6bHNr?=
 =?utf-8?B?QTRlMGloWjJuV1hLQVYzZVNkWlNqYnUrUjUwc3Q3U3pLNGVvUWZxSXJhYnBJ?=
 =?utf-8?Q?znfMoPVL3kc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NEblNnMDNxb2ZxZ1NBMERtaXdrbHQ2Q3hoenE0Z2kwbnB4STUvdHcyWTUr?=
 =?utf-8?B?dTdGTE9ab3NwU25Ka1VZNVpVNTFjNG1nMHBnY1RhRkFPNEsxWnFsR2JDRmFJ?=
 =?utf-8?B?YjMxZ2M0R1VmSVB2TSsxWlJtMHV0d01PVzcvcUh3cGM5NUVKVnFpZDI4cVMr?=
 =?utf-8?B?dlZRNW9rSkxqUE5id3E0c0RhWUFudXpEaHBXOXFUTVMwK2NWbzVVamt6eWww?=
 =?utf-8?B?TVpJZUV6cFZmZFlrenlJVWlVOWFzVmR5SWdwYlhMYVpKZy9GMlpNeTYzcXcx?=
 =?utf-8?B?U1loWlVwdjQ1L2pVcE4yKzQrMjRpbTgzbnc1dXZTYUVpOXMwWi9qa3ZTWmI3?=
 =?utf-8?B?QzEwSm9YaDZRYVdEdnFWQnlmdEJtbDdBaFgzLzZoT2gzUzRHa2h1VUFSMzUx?=
 =?utf-8?B?L2VQS3pSbVYzOUtielpmVUdHVzIwcVlFQ2daUEcwakVDejQrV3lOcktNRXM1?=
 =?utf-8?B?Mm9ybURuZWprUmNYeVJQU0VQbjRLdmFWWEpGOGtSUDAvbHBXUXJZSEh3U0NC?=
 =?utf-8?B?VldVcFNPU3VXd2Z1eEVLSXJKcnNtQm5rT0MyWkVCVjY5WVhtakpQb0djOC9J?=
 =?utf-8?B?akhkbmIzOW1hL2JFS3Y5MjRCRTNxK3JReml1K3FDajd6czluNWlCdG9aa2RE?=
 =?utf-8?B?Skh0c0xMbWNiZGpSNkNhYi9pWkJKUTZYUXNmSjlxcTd3UFRFZkZHTkhHRHIr?=
 =?utf-8?B?QkpRblozTml4b1dHMStuWnpackdIVnBoeVQrbDI0Q1dqWmswWUdqb1JyK29X?=
 =?utf-8?B?VXBuc05tZE94a0FrWHZMbGJUTmFSWWZPdEp0bXQ3Q3MwY0JoeS9JVWI4L20r?=
 =?utf-8?B?NHh1QXhndjhqRDVRMFlRNnVaTTA4dEtPMzN2cE96dForZElSbGZRRml5SWQx?=
 =?utf-8?B?N0lDQjNtZXloeVYzNncrWTlqR0hOVm1UZVBuQzJFTjhoYytMUUNrbXNSWnRT?=
 =?utf-8?B?bjZJeks5WU1ObGtuQWk3cGFxSTkvNGhheGNQTnNPendTSDRvaHkyR1hIeURz?=
 =?utf-8?B?NTVPaVVGeEYra05nblZlTGg1TGQrY09nUUhDM0lBV3c4ODFpeTR4T0dmL1hv?=
 =?utf-8?B?eFZXM0FlUU1yaDBBL3pOV0R1Zkx3cDlsTzlrRytDRGY4TkExYlhRaUQ5TlJ2?=
 =?utf-8?B?YjlpSmJicXNyNXo5ZEZaZmREMHVueCtQVS9BeHRQRHlTSW1MTUw5enpxZ3dM?=
 =?utf-8?B?VTZNd001ZHRFdm9ZSUZuUkZVZTFLMGFJL2F4QmZFTDY1MnZHT3VIUzV4aU5X?=
 =?utf-8?B?MkdDL05RaHVpejV3bjJTR0xwZjVqZlZSa292amZja0t5VzVYa05hMmp5RjB4?=
 =?utf-8?B?MDNrNnY3Sk5IbytvNlBYWkJWcm9ualpZcGh5Nnc2UnhaZjlacFRaZzNPTTNP?=
 =?utf-8?B?enJESkNDVm5QaW0yZFRrb0U3dDN4cUtpaWZ4cXhPMWJBU3JzRHY3bDRTMU5l?=
 =?utf-8?B?SFdQUVVLYklla3ZwR2t6VU4wVEJ6SVJFQkJneG0zRUNvc3FPYnpzSVI5Um96?=
 =?utf-8?B?MWRtdU1rNWZzUVNHN1VETFBqamVrRE9iQzM0eE5PZ2l3aENjWmtvanlsMldn?=
 =?utf-8?B?eHZlUFF5a2FWZnl1RThRblZtdEp5WDk3VFlvaC9iK2J6dzJqNnd0cmNNYlE5?=
 =?utf-8?B?MnNLRWtyNUpnSks2QkhoeVN3bHhKKzIxQzNicUlua1dObVRRc2Z2OGZrRXRV?=
 =?utf-8?B?RnoxMmorbG1aby9SWEY4djdHQmgzU2VIU3RybjBZc251N2xTZEFrUlFneGVW?=
 =?utf-8?B?UStpSFlTR0prMklHRU85bWZzTnNsK1VtV2lFTHRUdFl3TjlKaE9IMzhSY2Er?=
 =?utf-8?B?bjdkNjVkdm95eWt4dmhLOW9OMXcxeVFwM0o0eWxyZ2prUlg3dEV2OWdLWHRN?=
 =?utf-8?B?WVUrSk1GMHJ0RUtobHA1TDdCZ2NETDg3c242eFkwK3NsZGJuQzVqQ3dYeTdP?=
 =?utf-8?B?aEFTRWlUL3JkOVBkeHp1UnhZV0g3SzVvUGpuaG81eERsM0dSUi82TXVPNWVw?=
 =?utf-8?B?Szh1MHM2aXdSWmdrQkZPeURFdWhyVGFYc3dPVy80TmxlbHErYk9kOUh2STg5?=
 =?utf-8?B?WEt0U2NRbGVyc1pvTzdOSzNsNThUbk0wRFhPNDNqK3NqTUwybDlvb3Rkakwy?=
 =?utf-8?B?eUF1OVg0YXhFTTBnZUo2d0lvV2svRG1ZdWZDajhEWklmbzZZd1BucFl6RDVT?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea7421-2a50-4803-87e1-08dd819eba87
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:08:09.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 223kx4s9Y94TlxSzuaYLmfKxJD6qIuuq6ajjXMUSH/uUfr+gjs9p3DlD8rslHy/a3Jb174ocJ8Psv7NBPim404StKoGv9jMXyzXlR4gBwcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com

On 4/17/25 22:43, Harshitha Ramamurthy wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> The original adminq lock is only protecting the gve_adminq_execute_cmd
> which is aimed for sending out single adminq command. However, there are
> other callers of gve_adminq_kick_and_wait and gve_adminq_issue_cmd that
> need to take the mutex lock for mutual exclusion between them, which are
> creating and destroying rx/tx queues. Add the adminq lock for those
> unprotected callers.
> 
> Also this patch cleans up the error handling code of
> gve_adminq_destroy_tx_queue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1108566ca509 ("gve: Add adminq mutex lock")

This looks like a correct fix, it is also nice that you have added
lockdep annotations.
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>   drivers/net/ethernet/google/gve/gve_adminq.c | 54 ++++++++++++++------
>   1 file changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 3e8fc33cc11f..659460812276 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -442,6 +442,8 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
>   	int tail, head;
>   	int i;
>   
> +	lockdep_assert_held(&priv->adminq_lock);
> +
>   	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
>   	head = priv->adminq_prod_cnt;
>   
> @@ -467,9 +469,6 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
>   	return 0;
>   }
>   
> -/* This function is not threadsafe - the caller is responsible for any
> - * necessary locks.
> - */
>   static int gve_adminq_issue_cmd(struct gve_priv *priv,
>   				union gve_adminq_command *cmd_orig)
>   {
> @@ -477,6 +476,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
>   	u32 opcode;
>   	u32 tail;
>   
> +	lockdep_assert_held(&priv->adminq_lock);
> +
>   	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
>   
>   	// Check if next command will overflow the buffer.
> @@ -709,13 +710,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_que
>   	int err;
>   	int i;
>   
> +	mutex_lock(&priv->adminq_lock);
> +
>   	for (i = start_id; i < start_id + num_queues; i++) {
>   		err = gve_adminq_create_tx_queue(priv, i);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
> -	return gve_adminq_kick_and_wait(priv);
> +	err = gve_adminq_kick_and_wait(priv);
> +
> +out:
> +	mutex_unlock(&priv->adminq_lock);
> +	return err;
>   }
>   
>   static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
> @@ -788,19 +795,24 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
>   	int err;
>   	int i;
>   
> +	mutex_lock(&priv->adminq_lock);
> +
>   	for (i = 0; i < num_queues; i++) {
>   		err = gve_adminq_create_rx_queue(priv, i);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
> -	return gve_adminq_kick_and_wait(priv);
> +	err = gve_adminq_kick_and_wait(priv);
> +
> +out:
> +	mutex_unlock(&priv->adminq_lock);
> +	return err;
>   }
>   
>   static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
>   {
>   	union gve_adminq_command cmd;
> -	int err;
>   
>   	memset(&cmd, 0, sizeof(cmd));
>   	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_TX_QUEUE);
> @@ -808,11 +820,7 @@ static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
>   		.queue_id = cpu_to_be32(queue_index),
>   	};
>   
> -	err = gve_adminq_issue_cmd(priv, &cmd);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return gve_adminq_issue_cmd(priv, &cmd);
>   }
>   
>   int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues)
> @@ -820,13 +828,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
>   	int err;
>   	int i;
>   
> +	mutex_lock(&priv->adminq_lock);
> +
>   	for (i = start_id; i < start_id + num_queues; i++) {
>   		err = gve_adminq_destroy_tx_queue(priv, i);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
> -	return gve_adminq_kick_and_wait(priv);
> +	err = gve_adminq_kick_and_wait(priv);
> +
> +out:
> +	mutex_unlock(&priv->adminq_lock);
> +	return err;
>   }
>   
>   static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
> @@ -861,13 +875,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
>   	int err;
>   	int i;
>   
> +	mutex_lock(&priv->adminq_lock);
> +
>   	for (i = 0; i < num_queues; i++) {
>   		err = gve_adminq_destroy_rx_queue(priv, i);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
> -	return gve_adminq_kick_and_wait(priv);
> +	err = gve_adminq_kick_and_wait(priv);
> +
> +out:
> +	mutex_unlock(&priv->adminq_lock);
> +	return err;
>   }
>   
>   static void gve_set_default_desc_cnt(struct gve_priv *priv,


