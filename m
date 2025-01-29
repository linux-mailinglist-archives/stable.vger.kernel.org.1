Return-Path: <stable+bounces-111092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE4A2197C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E9C3A3A0D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143B194147;
	Wed, 29 Jan 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw5wXsJE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED87DA73;
	Wed, 29 Jan 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141249; cv=fail; b=HeuLoT//w0u6u8CGJr4UByvwmHv82xFH+z9oQnN60NLdKq7P7RsPpM7L3F85RHotY9oVvNnx4c4W2Ky521pTGMlnlVSZaW6/5fyh8qBb+iPM5z4XpkshAC7xdJpWpQQ2dRQutRVr1CsBdZwBjUBGbs2y90PxWZCnfhsXdjKazeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141249; c=relaxed/simple;
	bh=Q9atCY8bMtRJvbbpeAUcH5OkmMTG5iWil/EYnjuxOug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOYavRrvW+LPTs8+W7qRxP7sWT+5CVn6Brm51Bf0r4nZDC4bQIMyDSCNQSYmWJqFetQO9eqkPTcA/pTW6ChQ4WjvZfJEOd6kKfN6TJKeQl9ZKuYxI6lBUPOHCH7RHwvZS+jMZ8lbdUT4OJVo6ZNzMtpBfUgUVjacCRRniOzKii8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw5wXsJE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738141246; x=1769677246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9atCY8bMtRJvbbpeAUcH5OkmMTG5iWil/EYnjuxOug=;
  b=kw5wXsJEcNeavVajdfJwyQPI4CyIUTNZd6pTs7n3PoJfrynN19NjNi43
   9mENLqsOH1d12HB5vF0lu76RSKLqk8ss88r77P314YQEUMnzVX03ya0jH
   T0hSYvQbykeR6XkYsTb/kObwoBfm2GQQtjcDPo3zl1A0DXI5HyD5Ngkqe
   Yybi88O6MCtJCSopCZ6EuGEezsKky9gVA0+Ea+btRw92ypi837+8F0fwb
   CONnQs+CwGe93m8QNyrE4pnEXu+mQH+HYg40ej4m8SyTG75UHSbR4Ofn9
   bc4pf9hkbFwCo82+UZR7VMkzyksC/Okt0jnDZjZiTeQWNLA3QY0BHJVqW
   g==;
X-CSE-ConnectionGUID: 8MuixsOZSCqG0W8Oksqmow==
X-CSE-MsgGUID: RqWvL9/aSDas6M5OW9FHwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="42302169"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="42302169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:59:26 -0800
X-CSE-ConnectionGUID: 7gh5pXkdR3CH+osUUTYfOQ==
X-CSE-MsgGUID: B0dxHreNTjuqUL2oVX40sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109886755"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 00:59:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 00:59:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 00:59:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 00:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXcvvUK4NRUgbgE9dNDv8C2xYfmNsH20GvA6QJW9n96s8u6Wrti1tfR6ArkYifJEcrN3vfKMfmVE66ENWSi95b68i5nM4H3bETluXoK4TfHk/CaFtomsAjqI9GPK1tXmgjtxNDr7mGKSEK//1P/vGGgvHAGvEAMf+C+Arv5bU4jDKv2Rx+V2WLb81XO1TwNjFiDXJ2cZS+Tz1fB4xVQI2PgOpw1x5tCtA5/AJsDU1j2EMMA2SD1+P+rtQSeRccStQ5PCaozWse2AIx/UpugeflI1ynRPOkdxQ76uoY4a4kEaEdHu6fQDWxQh5oOAkdcOckRbYWCiX7VSEQMDkkUS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9atCY8bMtRJvbbpeAUcH5OkmMTG5iWil/EYnjuxOug=;
 b=ZbLk++zX3CzCKpgyPgS9tzSaKvChbOZdT4VoOj4UcgFby/eRx7W4cyyh7ICJObQQ0nlYALJfYj0aPYIzG4p7wi+HG5sYx76qsjvjfMS0DH9qKpu2ofTXqO59Zl7A1TjP8/1Btb86TF6/pf3xaXsg90p/0XwIwq/aTF517QQLQLroZckNZfHokxM0hDN8xHzbVbagsVhgJ21i68E71IfeY9r1XfY4ILRm4lZxOlIRvJPDRbf/I5mA0ov0N46rvr19sAA++Nb/v92k8qHax9XMFIpFQFXwXL1TYtm0qoVqkN5uAhRhhit0UKj9w08/mwFTQwWz46QzRGQgZpaRztxR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:58:56 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 08:58:56 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux@treblig.org" <linux@treblig.org>, Shen Lichuan
	<shenlichuan@vivo.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] mtd: rawnand: cadence: fix incorrect dev context
 in dma_unmap_single
Thread-Topic: [PATCH v2 3/3] mtd: rawnand: cadence: fix incorrect dev context
 in dma_unmap_single
Thread-Index: AQHbZ8ZV54NjqKr2okmLe+RdIvTQZrMhBZQtgAyBXpA=
Date: Wed, 29 Jan 2025 08:58:56 +0000
Message-ID: <BL3PR11MB653275BDFAB8FAA2EC499666A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-4-niravkumar.l.rabara@intel.com>
 <875xm8pk4n.fsf@bootlin.com>
In-Reply-To: <875xm8pk4n.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|PH0PR11MB5031:EE_
x-ms-office365-filtering-correlation-id: c4fa3b8d-34e7-4d96-303f-08dd404329c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmwrVi90T0lrczd5aSs5TFF5WDdsWkYrVkcxZ0hNTk1ndThod0pubkFzZVkv?=
 =?utf-8?B?dnp0M3hlMnVIRmJ5V3o1NE93aGVEYkZmbUdkL2VmTmR1Zmw4YzlTYzNNNFVl?=
 =?utf-8?B?Q1FqT2FFNjlIakhzb2RYQW1xZkxESGFIZXczMTdLUTlGWkRiOHh4Y042ZHV1?=
 =?utf-8?B?WnFuaEdiRTN6bzkybEFkOWhra0Y0bWx0V2E0M2NDUllYN216REVoVGZVb1E0?=
 =?utf-8?B?S1hwOTRNSHRLaCt4VU0zMWJoRkZGTHV5UEdmVjJDOXpCV0lzOVFHK0JoUWNX?=
 =?utf-8?B?SDAxditycWpRK2RhdExIN3V5THluNGVjNmJWZVMwd3o5aHVlUFBsYktYUzg4?=
 =?utf-8?B?YUFyMnI3cWozY2FMVjJ1YzV4MlVKZzhObTQ1NFhEdzQwVlQwQWM2bGw3V3pw?=
 =?utf-8?B?aUVzak5CYXNSekNDbW1wTlVRL2FVeEFtVXNXOS8zTEZEalhYNFdQdE5GTmFL?=
 =?utf-8?B?TVdOejY2czVmbW9pMVFtTlhiRWFhYXdqN2dadTZ3eW9jWTZHT1hvNkJ2a0pS?=
 =?utf-8?B?dGFrNGEvUHppbHFGSCtwenY5cGhlcERTRmJQSFBrNEQyeEVIT2s5ZTRzb1Er?=
 =?utf-8?B?OUJyN0tnMnY5dnpjUW5wYkIxZGtLVnZpK0dlRExQcDU4cW1ZSlZ2Mm9zSmJl?=
 =?utf-8?B?ekQybnNITDN3aXRrc2duSUxzZFh3d25BMWNkVkJQZHBWSEk3Yjc1U1lWTkVD?=
 =?utf-8?B?SnIvN3VwNEp3TytWOGxoL3E1a2I5QlNxekdRWVVZeG9JS1ZOajAydmErbXpR?=
 =?utf-8?B?SmpvTm9mN3dNbzNXbk9lNWgwOUkwaVVyZjNtc3M5cUcrTHJicWIzek9kNlFB?=
 =?utf-8?B?dzhsZXlQYUFKUXNwTmJsUGJDTE43c2lqQkdWdCthQ3o4RkdOaGRsSXpneGdF?=
 =?utf-8?B?Q3JsNzlLeXhIdjFDWTM2dG12d3h4WGRIS0N4M2JTa1N6MVJ1Rnh2MlB2WmI3?=
 =?utf-8?B?Y2Fad0JqTmNtZXVobWpXQzJXd0hDRmRRVW1oZmpya1o2cE9WeVNleHRGZXVx?=
 =?utf-8?B?UUhUY1FMN01IM2tvdnNrTWpLcXJGQWVXcUtXVllYWjZFOEd0UFdXWWRNNWRo?=
 =?utf-8?B?dCt2azY1YmZJVEk1c2lzVTRvbHI5WEtxeU95T3ZXclZoRm1WeU5DaDRQSm1v?=
 =?utf-8?B?eWJISEFrRGpVUkxVVVR6Zy9BRzBQQnpDeXNiM3poVWZZdk5RWnduQk9QYzQ1?=
 =?utf-8?B?TkF5cGdXeVR3RVBqZlJjRkdDUUZiMXY2TWlDN0k2Y0FpSWtZVjc1c21MTk54?=
 =?utf-8?B?UUozZm53L1p4VXJDdHV4ZXdiVTNGUzZCTlo0MjFRTW04RHJ5VSsyZFVMc01C?=
 =?utf-8?B?ZkgxcVZ1TmZ4Q2lnY0ZlVE5KVCtkU09xQVVKMlVYVHRVZnFhRzNXNDZBUWl2?=
 =?utf-8?B?UmVKY1ZMWHJiZlpVR3IzdUdvR0NJL1RjV1BvYnl5OCttQW45VWp1L1Vnamg3?=
 =?utf-8?B?b3I2VjBXb29NK1VqRitTZWx2bCs3U2sxSWREeXhUdVJ5TXUvekpGenVFcUdt?=
 =?utf-8?B?TG5LWS9hVHJkcGlQQkNoMEM5WEF6THNGcjJzcThPcUhnRUJhbjMvaFdOZTc5?=
 =?utf-8?B?UTV1U0ZFRTRSMVlLcE8wWkY2VHNwVHlRRzdTd3dkZDNSRGx3cXpWV091SExW?=
 =?utf-8?B?RFJWOUE1K0hzYWVBVHBpbnF6MkNFVDJVNHExME9KUk1wR2hmUkFuRUgwYi92?=
 =?utf-8?B?RG85MCsyd0RoY2tSdGNvdGxMWWNpWG5BdkJCRmM5eU9ibFA0TFdxTHZFeHVt?=
 =?utf-8?B?SzZVUUJnQU5NSTZDWnN0NDk0UTdObzRlSm1jN3VVeDBDb3RIMHdKU3RBVFJq?=
 =?utf-8?B?Si8xREF4WVNib0lkbm5iZVF5aHJ4c0NNbGhRVDhQajRyU0NobHRWc01Ca1I1?=
 =?utf-8?B?SHpLeTJjOGJSeHkxaVFIKzJSM0ZQc1lmcHdZdWFJbG1ONkZRYXdwdmpiNnZr?=
 =?utf-8?Q?TyMofWHALmZPn940bI0s7FAAXf/aWuIT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZ5cjl5TUJPeHJ5Z01Ndm9DR2VBMWdmMjh1N2pZd1hCeEsrbzhJbVNTcXY1?=
 =?utf-8?B?ZFh6dnRCb0dhaEhmbU8yNkNZUXdHUGdwb0JaaDFBT29zQllhZ3RDendlTTBH?=
 =?utf-8?B?L2gyYzdsOXFycjVUQlV4U3VFK2s4NDA4VFV3eGR6cUY0RDJVazIveURvYWMv?=
 =?utf-8?B?N0tjNDNyV2RPd3lQUm5DQUtNaDFMY1UxMzJLakZua0w4ZytWem9NZ0s4WE9s?=
 =?utf-8?B?djUrUUpXZk1BM2FDSzdrekx1eitVK2VBT2taSWZkV1oyTzZqRlZpdklRSWpZ?=
 =?utf-8?B?NTErbWdrV3BKOExDZjBNdVd0YmQvNHpiUmh4c2ZTMG10NTBSODY0a3RtUTht?=
 =?utf-8?B?Q2NRMDBWSS9RSzlRSzU0a2VnNjhvV1hMaTIzY0dMQTlocFRRRWloWVpSS1Vl?=
 =?utf-8?B?UmM3a0JyY2FkYVFmdWJHSU91UGQrdlNhR3lhdmx5b0RkVXRHODZFOUxKUmZx?=
 =?utf-8?B?b2FRT2VaZy9GZWEycko3WGF6dzZ5U1NVeFlFT1BXOEVKeHdtek5OMm1tbGkv?=
 =?utf-8?B?eDcvY092YnBMWnpZZFZTOW56Tmt3SW1qcEVZRHh2YS96TzNaOUVTTEVnNUk3?=
 =?utf-8?B?ZGtxWXVDMFI4YVJxaEVFK2tVSVJMNndManY5TlgzRHZDWWU4OURBdmUzTHEv?=
 =?utf-8?B?TmJMYWtwb214UkpOL1FJS2xub0s0R3pOYUNtbzFscWNuRUMvWmtLZlpSeDhp?=
 =?utf-8?B?MENla2REaEgvZk5RcmZua0kzV1haemVOT3E4bHN2eG5QMXVEUzRLU2ZBVERP?=
 =?utf-8?B?OS81REtITXdZN0RPWEJoelQ0K3BDMHpiSlpaejVlUWtDdTdaNklTNjlvZy8w?=
 =?utf-8?B?VlJKZC9pQ3JkYjNKMEFjTjZTSmhRWTFtRzVxOXpTb0dtVlA1U0duZ3Y0eFF6?=
 =?utf-8?B?dHFxNkl1U3c3UUkvSzZiS203V2I3Qkh3TUdmMTZITityQWpTczVTbWNKZkU1?=
 =?utf-8?B?YVVoblpsM29vZUxoaDZZdDM5MzE2STJQS0hPZlNDc21HOVA3ai94bzVWNXdB?=
 =?utf-8?B?Y1NvTWpPN0F6NjBjZXh6ckk2ZnEyWDg2cDlEdFI4V1YzaWNyT2NCWFJ4UGl5?=
 =?utf-8?B?MndJSzBjRWdkc0wyelMxeURnYTBBZzJVRVI2UWNpSktvRk0wSDlmL0xKK0hz?=
 =?utf-8?B?LzVIZ3h5YlJmcU1pYVVyeitjUWh2K0F6SGdLWi9Kei90SDc5dFZZYUhpT3l5?=
 =?utf-8?B?dzl6RnpSaEtEdyt4Ty9mWjRieElqanhiU2RwRWxIeHJ0UlJuV0xCV0l4VThp?=
 =?utf-8?B?dzA0WktzamFFZnMrVzNuYnRueHlFRnU5ZUpXUmFsQitzK0ZEN2pteU5NWDhm?=
 =?utf-8?B?VHRJQmFzbHNyY3ZDTTFDK0FIeVlSeGV4eTI2Z2p5cTc4RUVRNUNVdERKdEJy?=
 =?utf-8?B?RmdST2xIL2pTQjdGRHh2bWxSOFNkRUlIcWJFKzl6SDhyRmd6ZzdkdHlnOS9i?=
 =?utf-8?B?WFJ4aGFtbVFDS0M3NUNLSFQyS0k0YWNqbnFnNGgzMVZxdDFLUUI0MFZzejI3?=
 =?utf-8?B?VUI1ZW1pWmpZOXM4R0xpTTlrYXdPazFSeERXdDlhMlJSWWVvcFNaclhFa01Y?=
 =?utf-8?B?REtPWHBQNENlSktwME16Rjk4QVE0aEI5T1pxeVBGN0dQdGZHdGVnOXdObWhR?=
 =?utf-8?B?aTVrRXhwL0tLVDRhU2JMdVZPY3Rzcm9oZDg0TEZCS1REU1RVb3JHeTVzc3FV?=
 =?utf-8?B?NmczeWloS1FuK0psN3hhaVN5aHBsSzFVU2ttQ2lVRkI5Z3krelRkVDdudVEx?=
 =?utf-8?B?aW5NdlIxMFlmdkh4REh6U0hjc0FNbCsyMFV1UXFSNnpqQVlTU3o3RUxCZG9q?=
 =?utf-8?B?OGNQQS8vTWU4NFBDVjFsbm1KWTFrbk5jZ0RtTGVmN2JsbC91RjF3N282QzIr?=
 =?utf-8?B?bUFIZ0RuS2tCZ09QOVQ3MndXTTI3YnlTNVpBSXVrSjhxSDJLdktiVHRBdnBJ?=
 =?utf-8?B?cVYwcW0zMmErYS9PcHg1cUZaUUI5WWU4YTBuRjlKeWttSnRsR09JdHdrRWtM?=
 =?utf-8?B?dXR2UEdXQ3U4RDFhNUV3MmZIOGI0R1hTaHRrRDlKSXpMVzJGNDNieHdSaUNa?=
 =?utf-8?B?RTlHdEc4UHBNSXRhdDMzL1laWXFVNTFCVGhyOTRmWkVVNUtCQjhXeTVCODhm?=
 =?utf-8?B?UlNBV0g2dElzV1E0WmZEbHkxQUpUR24reXIyZEhPelZvL2xlTEFseVVCMGN2?=
 =?utf-8?B?RWJrenNpYmF2RldTSlZ4VmF0L0I0Zjg2bVlaY21FYURKdkI1bFVzTUpkT0pL?=
 =?utf-8?B?SXVCVTVGT3V3SmNTSDJtQlJLdGhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fa3b8d-34e7-4d96-303f-08dd404329c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 08:58:56.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyhRfrrOQ4ZjuAdB2cYQPfgmZu9X++eTG80T4h2LFPNKzrXkYP9mrgKSOHJp+3Fj6FZJ8h+0iJlqMtKSZU4x4rM8OKTIqAxRFDNeGVqBoh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDIx
IEphbnVhcnksIDIwMjUgNTo1NSBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2
a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IGxp
bnV4QHRyZWJsaWcub3JnOyBTaGVuIExpY2h1YW4NCj4gPHNoZW5saWNodWFuQHZpdm8uY29tPjsg
SmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IHUua2xlaW5lLQ0KPiBrb2VuaWdA
YmF5bGlicmUuY29tOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAzLzNdIG10ZDogcmF3bmFuZDogY2FkZW5jZTogZml4IGluY29ycmVjdCBk
ZXYgY29udGV4dA0KPiBpbiBkbWFfdW5tYXBfc2luZ2xlDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9u
IDE2LzAxLzIwMjUgYXQgMTE6MjE6NTQgKzA4LCBuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNv
bSB3cm90ZToNCj4gDQo+ID4gRnJvbTogTmlyYXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1hci5s
LnJhYmFyYUBpbnRlbC5jb20+DQo+ID4NCj4gPiBkbWFfbWFwX3NpbmdsZSBpcyB1c2luZyBkbWFf
ZGV2LT5kZXYsIGhvd2V2ZXIgZG1hX3VubWFwX3NpbmdsZSBpcw0KPiA+IHVzaW5nIGNkbnNfY3Ry
bC0+ZGV2LCB3aGljaCBpcyBpbmNvcnJlY3QuDQo+ID4gVXNlZCB0aGUgY29ycmVjdCBkZXZpY2Ug
Y29udGV4dCBkbWFfZGV2LT5kZXYgZm9yIGRtYV91bm1hcF9zaW5nbGUuDQo+IA0KPiBJIGd1ZXNz
IG9uIGlzIHRoZSBwaHlzaWNhbC9idXMgZGV2aWNlIGFuZCB0aGUgb3RoZXIgdGhlIGZyYW1ld29y
ayBkZXZpY2U/IEl0DQo+IHdvdWxkIGJlIG5pY2UgdG8gY2xhcmlmeSB0aGlzIGluIHRoZSBjb21t
aXQgbG9nLg0KPiANCg0KTm90ZWQuIElzIHRoZSBjb21taXQgbWVzc2FnZSBiZWxvdyBhY2NlcHRh
YmxlPyANCg0KZG1hX21hcF9zaW5nbGUgaXMgdXNpbmcgcGh5c2ljYWwvYnVzIGRldmljZSAoRE1B
KSBidXQgZG1hX3VubWFwX3NpbmdsZQ0KaXMgdXNpbmcgZnJhbWV3b3JrIGRldmljZShOQU5EIGNv
bnRyb2xsZXIpLCB3aGljaCBpcyBpbmNvcnJlY3QuDQpGaXhlZCBkbWFfdW5tYXBfc2luZ2xlIHRv
IHVzZSBjb3JyZWN0IHBoeXNpY2FsL2J1cyBkZXZpY2UuDQoNClRoYW5rcywNCk5pcmF2DQo=

