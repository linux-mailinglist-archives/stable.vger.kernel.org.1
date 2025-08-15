Return-Path: <stable+bounces-169713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD8FB27D72
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4925E5E3F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23E27979A;
	Fri, 15 Aug 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjJPBZ5g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B161D8DE1;
	Fri, 15 Aug 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251213; cv=fail; b=fifFOq4syASf3fHSqPNx3TZY72QZNWf4hi0id+p90GKdujyZsvX47ZNjFzQBFnxCLcLgRJy5YKJa4DaHBRzJdrAol+5zpPXMpWCSbQfXONYFBzywaqDE9UaophiI+ti7QG1HqA5T16iOeKIG6vdbbRITpDSjqeCfDpZXvVPBU20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251213; c=relaxed/simple;
	bh=T3iRYYWJukB5T1Pf811qHCUAh+y+wLXMQqYdgP41FSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Da+9aYYyZq+x4AOVg14zAW52C3S5gHFE8JAJzBOHkgoEA4o2+n79K2o780Iyr9hoVDt89QQhTuCH+GwuSGrrghmcpNzwpOZZR5xeXnojJpt2WPEUiUCS3AZon5shVEy7Jqcz3B6adrW6ALGtV40761R+JAuAGinybG8Ad+SbFa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjJPBZ5g; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755251212; x=1786787212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3iRYYWJukB5T1Pf811qHCUAh+y+wLXMQqYdgP41FSg=;
  b=QjJPBZ5gEKT3UGiJ3s95OHRCtOeDowAH9Bw3Maq29EDlQsY4jjEogovs
   BhlzQEcsemkuaPmSmimagSzhKidYI6dGG83eXJLVAvgkYYV3zDwTRJrvi
   QlZ1E2jpgvYj1bxEs7bOONOFr3xysTT6HCCp1TDD2FGWg6VK09NoNcCH/
   UxviVgwewG83kT8Axo0xhE6PqWWlcGvG7rI8tIvEdGiQNQ1HA9xro/6HV
   ywVL3OY1TlYjqoloLTfgvLNotDnl+OT/Bpo/4RQ56YFpPmLLYkZB5AkHm
   qGHL0ZfkZxH9+gZZq71owf2ZACT1VayF3dVnK8rCCpxEfwGV8hXgGkcrd
   A==;
X-CSE-ConnectionGUID: qHix9Ma2T0qPjhmeKL6qJw==
X-CSE-MsgGUID: qIGjhmOmTtWZgqU1MyGxVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56783005"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56783005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:46:51 -0700
X-CSE-ConnectionGUID: GYvuR1f3SVi8pUra2CFsjg==
X-CSE-MsgGUID: yX18vA3ORY2HmNfv5iGMTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166472558"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:46:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:46:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 02:46:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.44)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIYna2XQBLHlY31HJD5LyA2HYOZkVpo/MA1MKud/GQ6qnTO7S9SmyCb4+c+AqEcZesI8LdbCS1vXct4oDeqSdGD1ne76nldW9vLsoiCiF0LFD+eZrNlq+031pVUYqCdjdTCqr2VO4SXFVxmuXsSM12Zurh2fi2KGHEU11wT6aLdobUqrcjERdqlz1jNQoQtzCZE4lvZ9ttg/CD+Ozk0igfS9+s+gau4MJK3PC3jfdOKlvXERBuMmKsoJ4HnWhUenaBIVBW5g+Af3eDsog3P2prugSxY31ey+dQeu8ZInLZn1RO9LmIIqjMIzElhD8jd45I3EUGRLRRozg/sggwLT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3iRYYWJukB5T1Pf811qHCUAh+y+wLXMQqYdgP41FSg=;
 b=QQbRgJWF7xe1/+1nUlKBDbgAtkGGTGkJo9H9tSayzS2xoXblNRlrrTPRBF4DRU8ffC/WkpFYr9CkynEhgE2QrsOSuwIc+xifXIWa62ZGi6XqbwTHoN67IBO2bR4iOptLiHStqW/Erk1W7/xY0jB1OFnE+Yr9Cpguo0KfPC8cF11eGCcjkuPr78L24Mo68p908mmYDK7XWfHZf45ouXuzH56PEl9FQcCqb7wQiRPbgO/9vc9CFEJi7bc0QWUWWCmvOQ2tg08eniJcvP8G23W5OCYxrABeX779BDfSPR6nQW+DIHGLhAxYlvrd4A/D6yRW1U08Rb5mown/33T074fG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8725.namprd11.prod.outlook.com (2603:10b6:408:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 09:46:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:46:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki
	<urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHcBpLRgrfnVjVEu0GV5qP87jgc6rRVuXIAgAANmoCAAANigIAAAUgAgAAHBQCAAXKbgIAAVvcAgABvkhCAC3GPAIAAAoeQ
Date: Fri, 15 Aug 2025 09:46:47 +0000
Message-ID: <BN9PR11MB52760702D919B524849F08F28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f7a0524-75e1-447f-bdf5-db3f088a0ca9@linux.intel.com>
In-Reply-To: <3f7a0524-75e1-447f-bdf5-db3f088a0ca9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8725:EE_
x-ms-office365-filtering-correlation-id: 7123e98b-0022-4250-dfce-08dddbe0a6d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGpQMnljS2pwdDVMbXRoQk9IcmV0Rk9taXkxUjgxRTh6MTgrcFBFUGZSS0Fj?=
 =?utf-8?B?UU42bzZzb2dWbjlEd0pneTV6bE1vMkFMOWIrZDZqV0QvV2x6YWY0U2tGT1lB?=
 =?utf-8?B?UDlJZnRjQU04ZlU4RzRBbFRuZ3gyNHdJUWlpOS9YdFVQV0pkMnYxNGEvaGND?=
 =?utf-8?B?U1V4SGVxTmFySy82WDJaWjE5N014T3ErVEdLbkROVXROWkVvbE1MSWFmc21q?=
 =?utf-8?B?bmVnYnkvbGF5MUt5WWtTSnlUbWtlZ1o3V1FWNTZHTXNmRzIxMzF5QjhFMmZq?=
 =?utf-8?B?Ujk3TGR4a3FIb1Q3MUFUSUtjVDZ5WUpqYk9Rek9ocGZCMHl2b0dBNU9SSUU0?=
 =?utf-8?B?Tm1GckNpWjJ1bTQyQzl2SmJlYXpXT2cveVI5QUdVUGFkd0JTVW80UmQ1Mlhx?=
 =?utf-8?B?VkU4TFZQeDh1bFA0NlNyYzUxK0lqM0s0MHZxTjVRMUZwV01QZjNwU1Q4R09n?=
 =?utf-8?B?WTQraklxUW9BR0JIK2o2NWl4UkhSR251cGlOb0xIMWFmWUVrSG1KNnJXTG1t?=
 =?utf-8?B?OFBBemxxT2IvbFFvM2QzcVFMKzJpU20vTTlGYjBOS2g1QThaR0FGWVlCdUdx?=
 =?utf-8?B?ZjZsNnFrTFZkWThrSXBwMlVydFgxL2swWjFLOWc3Y3lvUVhXMjR4dXhCdEJ0?=
 =?utf-8?B?R2J2ZzA3SVYyWnBqZ2JqWUFOUGVFcXpPcmdLczExV0d6eXpCSWlZN0RmVEQ3?=
 =?utf-8?B?dHA1aVBicm8yeXZTUHV0ZXZkeC9CU1pKNkxibVJlenllUjVyZ3hlUkFkNnhJ?=
 =?utf-8?B?TG1YaStWekw2R3dMaVFZMXhjM28vK0FOK1RseXRKdTlCWlBBTXV4NEZ3aWY2?=
 =?utf-8?B?MXVucjFEelhCQi9HdmlLeDhQS3NNTDdwdVQ1RWVWeTNLM1d6aUxUdXBmUU5v?=
 =?utf-8?B?QXVTV3RoWG5QdmdVUG1uaG9NcTFXRXQrRkswS3FPVmwrTmxONHZFSVdKZ2pQ?=
 =?utf-8?B?b0RmaUovOE1rc0lBSFpQYmhzazBvcTRzb3I2MVFaT1N1ZlRRMU8wVDZUZUI2?=
 =?utf-8?B?Yi8rOWpydnRXdU5YNUNnMW14a3BuU1A0M1JiZU55L2g2TnNSVTFqWDZ6bnVQ?=
 =?utf-8?B?ZjIwbjNaU2tQcE5VTUQ1RlJ6aHhjNXlQdnZyZFVFOU1nRGxZTVZlZzNOQnVw?=
 =?utf-8?B?WHB4RWI1M3U2NVBkb1I3YncyUFJYNnhBK2hacVNBMnRjSjRGSmxiVG8vZGFH?=
 =?utf-8?B?ZUN4Yk92cTN6R3o4dWxiVy9GdlpLWTExOFR2bk1QYW11TFpad3ZvWXVWak9L?=
 =?utf-8?B?cWhmU0lRUHJhbW9xK1pRMnNEWXdjd0JzRllTSjUzTHVSaEpaY1dLOEJQZlYr?=
 =?utf-8?B?clY2RUpEbGlwUCtjanROQ3VrQTJJRkRoVk5FRXE4ZnF6VUhnV21xSDc2ZXJv?=
 =?utf-8?B?T2UrbjhHWVNYV0hiZzRMR01xcjdhbEpxR2ExQ0FtbGd6Ly9ocDR2b2puak8x?=
 =?utf-8?B?c0ZQbHY2SVFwNEc1Tlo1ajNodXlPVUNSL1pOZUw5bmNPLzBKbHRZUXVTaUc0?=
 =?utf-8?B?WXduL2tzNkQxbUxoWnRzUzFSQ0djcFpVOS9ZN1NLRjdYdUw0SXc2TE01VUNY?=
 =?utf-8?B?Q2EydkpiNkFYVDhLcmFoVStrbHRzc3VUZVVtY21QckI2Mi85RTA0YjJZL3Z4?=
 =?utf-8?B?YVhNVStZdFFUS3Z3WTNsQWJzbmtmMnN2RWZVM3dNY2oyd3dha084MWo4MmNv?=
 =?utf-8?B?bW5SQmxtVHdWN1hVTzhwVGVQQ2xTNktKdWFYWUJGSE1zZ0FiWnFIMlFxWGRB?=
 =?utf-8?B?SDRRZ3FtbnZDc083SlYwVjV0WlVKZXh0SzBNY0EvSzNleDhqcUk1N3VhcFY4?=
 =?utf-8?B?cURFSmQ5a0JyTkV1cnBwc0J4SnhGTzR3WVNlbWVwOWVZMWJXc2R6VGhNZjQ0?=
 =?utf-8?B?c09RK0wyYUYzbmxBb1NMNDdBNDFhQ0VVZnk1TFY2QTd2SEpJL0UvNmNJNEMy?=
 =?utf-8?B?QVl6c1BUMFdwbzZNUll6OHN3UjFReWRrZUpsV1RZc3k0ekxDRi96UEpUS3p3?=
 =?utf-8?B?QTJTV0hYRGJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFptYVF0MlR2Yjc0ak1DUTA0R2xLTWxISmp6Z1g1TGQ5OEtab2ZyUmRhcmRL?=
 =?utf-8?B?Y1l4d2dCZDEzei9zR1RicVZHWUdGbmZtVC9LYksrOUtQQVVxOVFSc1A1WHRr?=
 =?utf-8?B?V2VSVjVYc2JRUitrUzdvdkg5TGFvTkNqUVlHTzd5L29mWW5FTms5QzdqdklE?=
 =?utf-8?B?QWVicHdLNEFxRW5DVjhZNXZkMHRqaWRxZkx5Y1l0MlZ3SlNwQUJyaFVVbk5z?=
 =?utf-8?B?UlhRTzZNNkZvUGVDeHlPalExUDcvTURYY1FXOXR3Zzg2Y3FtNXdXV3BXbTJt?=
 =?utf-8?B?a2lJcGZ5MWdhZ2xYdE1ZL0NPcllmc2VqRFNKQTZiYVkrK1FrNmVsYzkwOXVR?=
 =?utf-8?B?b3dHOS9pbVUyc0hLQ2FNaEtsMFUrYW9EdEZOb0gvamh2VFl6S21GcEQxdjB5?=
 =?utf-8?B?a3R1WWlxeGZBMlBWMXYzM05jaTI1QUYrRGcrc2wxZTNkc0lLYnFleFA2RFll?=
 =?utf-8?B?SjlCZTBxS0ViVGNVVVVBUmJYYUl6eHhqQ2JKcWJZcHBEOTZ6L1JCbms4Z2tU?=
 =?utf-8?B?WEplaU5KR0g2ai9BeDM2eTNtNUtRSFJHRVlNbHVzSnY5YjFId2JUYms5ZHM2?=
 =?utf-8?B?akhubzhpTFAvNHFBZVViYlZvaFFwUEJ4a01MZXV0VGlZdzRTeE5Ob2p0U1RJ?=
 =?utf-8?B?QUdYS2ZpaXBpQTQ3Sm90VzlBS3h3RTlxSk5xaWFYQXJ4bW82NW9BM1NROUpu?=
 =?utf-8?B?WVNOU3NkQUI5MnpvSGYzRlJYanBDMGZwMUxTZWwxb2hROXg2eG4zeEJCNUpQ?=
 =?utf-8?B?WGQ2QUpnUWxTMStMZkx3TmVPS0hmS3JSMFNiZHZuZEZFam80TFZ3d3U5cC9O?=
 =?utf-8?B?bGEvQmNUeGt1djhMeDA4aVY1dE9NMVhPc2pRK0w0NDJ3eUtQZ2drbHJLcitt?=
 =?utf-8?B?UzlFdTdEMnN3SUZLY3BkdnpXVENrVjVhYXBjTm53c09pQ1A0RTZmcUpPZkhx?=
 =?utf-8?B?bHpzSG5ZY3ZRY3dHNWVmSXNsZkNFZ2puQS90N3ZOQnpKY2w1cGxwWnQ1TnhG?=
 =?utf-8?B?eXZlTTJxdys2WjNiQW9mYnRFZ29EMUNyTE0yeDNGWDRvOWRBQTBRWWk5Qmw3?=
 =?utf-8?B?L0xvKyszWjJkYVhYbCtzUGRVOGYxeXpyLzlpMDJzSDRkQXltTDZiQm9nT3hI?=
 =?utf-8?B?MlVMa3EwYWJMZS9hTDU3amJ1U2dUa21sRmY2cXNVV29mdS8reHozcFVaUjBN?=
 =?utf-8?B?K05mSnpDcGxCZzJOMUJ5K2FYTzgxOU9pMVRUTmt1MVRqN210MnhhcTh6UkdE?=
 =?utf-8?B?a0I5QlNtdXNJb0N4YzFBWmtGMTZVczRrTGV5Tno0OHc5MGVNTlBJU0h6STVF?=
 =?utf-8?B?Sldabmd6MHJoOG5RZUtaMWlEeElZOGh3OGlHNk5JQ3B5UUxUaUVUMjNOU3lB?=
 =?utf-8?B?RG4xZE9ZSEw1RE5wd3RkektpWE42cC9GMkxIRys4Z3RRYVlva2YrTVNZakpo?=
 =?utf-8?B?MlZjMDFIa3NMTDdNMXN5YXpRd0tQajlxRFNlZ3p2T1lMSjJIam9Fa3F4S3U0?=
 =?utf-8?B?b1JpWWJ3MU9rVWFhT3RWL2hacTNiZFdaU2JtK2VhSEg3cWJ5SllDbnFjeURy?=
 =?utf-8?B?a3JpOUNzNTJaWmZsTlRhQlJ2TVcrVDJVOUtoTC8wSWkxaThMZEpSTWVrUTM1?=
 =?utf-8?B?QnRtVG9tcjZqZ2VNZm5yQzdzc0MvQnI1YXhDSE9hZENaUVdDOHRmVG9aUFRq?=
 =?utf-8?B?cE1sK05pY0xleHFJZ2dnTXlLU05tT0NtRWVhckk0cklpeFFDbE5VcUl2Q0FQ?=
 =?utf-8?B?cWIrQzJpRWN1YnN2N1ZvRkltcjNwVEljYUx0NFg0QmxHYlVoVGdxdEJVWXRa?=
 =?utf-8?B?N3QreTk3OS9hZ1Q5Y1A0V0VXWU1Nb2JicmJHa2dlYTQ3LzhJblhFOVk1Wmky?=
 =?utf-8?B?cDM0enZqWWJIT25pbERWSjUrenlOOEFNZlYwaGovWDBWSis4NUxIZzlHSDdq?=
 =?utf-8?B?L3ByL3dzbU0xRERaQWErZk81aDVFYnNjNmtjWis4MWltQTlVbXNMdGM0bzVs?=
 =?utf-8?B?Zk14OW03Y09CYnEvb2srVEx6YzJiNzFLV0lJSkEyblhKNVErV0NHQm9jK09i?=
 =?utf-8?B?RGhpcVFmVW9hekRJemxySEpBOHg2dXlUUnJITU11bkpQL0kwTllpT3ptbUZu?=
 =?utf-8?Q?rm4rz2940IPyOVtBwZ8T+3xGl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7123e98b-0022-4250-dfce-08dddbe0a6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 09:46:47.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FhcgcZZOjRamODL3FaKMnGHRMfLlW0DQG4oPu0Rfutj+nN6cFYKcv4lEEecNSPjU786sXqEHUuG6OQ2tcq6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8725
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCAxNSwgMjAyNSA1OjE3IFBNDQo+IA0KPiBPbiA4LzgvMjAyNSAxMDo1NyBBTSwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDgsIDIwMjUgMzo1MiBBTQ0KPiA+Pg0K
PiA+PiBPbiBUaHUsIEF1ZyAwNywgMjAyNSBhdCAxMDo0MDozOVBNICswODAwLCBCYW9sdSBMdSB3
cm90ZToNCj4gPj4+ICtzdGF0aWMgdm9pZCBrZXJuZWxfcHRlX3dvcmtfZnVuYyhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+ID4+PiArew0KPiA+Pj4gKwlzdHJ1Y3QgcGFnZSAqcGFnZSwgKm5l
eHQ7DQo+ID4+PiArDQo+ID4+PiArCWlvbW11X3N2YV9pbnZhbGlkYXRlX2t2YV9yYW5nZSgwLCBU
TEJfRkxVU0hfQUxMKTsNCj4gPj4+ICsNCj4gPj4+ICsJZ3VhcmQoc3BpbmxvY2spKCZrZXJuZWxf
cHRlX3dvcmsubG9jayk7DQo+ID4+PiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwYWdlLCBu
ZXh0LCAma2VybmVsX3B0ZV93b3JrLmxpc3QsIGxydSkgew0KPiA+Pj4gKwkJbGlzdF9kZWxfaW5p
dCgmcGFnZS0+bHJ1KTsNCj4gPj4NCj4gPj4gUGxlYXNlIGRvbid0IGFkZCBuZXcgdXNhZ2VzIG9m
IGxydSwgd2UgYXJlIHRyeWluZyB0byBnZXQgcmlkIG9mIHRoaXMuIDooDQo+ID4+DQo+ID4+IEkg
dGhpbmsgdGhlIG1lbW9yeSBzaG91bGQgYmUgc3RydWN0IHB0ZGVzYywgdXNlIHRoYXQuLg0KPiA+
Pg0KPiA+DQo+ID4gYnR3IHdpdGggdGhpcyBjaGFuZ2Ugd2Ugc2hvdWxkIGFsc28gZGVmZXIgZnJl
ZSBvZiB0aGUgcG1kIHBhZ2U6DQo+ID4NCj4gPiBwdWRfZnJlZV9wbWRfcGFnZSgpDQo+ID4gCS4u
Lg0KPiA+IAlmb3IgKGkgPSAwOyBpIDwgUFRSU19QRVJfUE1EOyBpKyspIHsNCj4gPiAJCWlmICgh
cG1kX25vbmUocG1kX3N2W2ldKSkgew0KPiA+IAkJCXB0ZSA9IChwdGVfdCAqKXBtZF9wYWdlX3Zh
ZGRyKHBtZF9zdltpXSk7DQo+ID4gCQkJcHRlX2ZyZWVfa2VybmVsKCZpbml0X21tLCBwdGUpOw0K
PiA+IAkJfQ0KPiA+IAl9DQo+ID4NCj4gPiAJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBtZF9z
dik7DQo+ID4NCj4gPiBPdGhlcndpc2UgdGhlIHJpc2sgc3RpbGwgZXhpc3RzIGlmIHRoZSBwbWQg
cGFnZSBpcyByZXB1cnBvc2VkIGJlZm9yZSB0aGUNCj4gPiBwdGUgd29yayBpcyBzY2hlZHVsZWQu
DQo+IA0KPiBZb3UncmUgcmlnaHQgdGhhdCBmcmVlaW5nIGhpZ2gtbGV2ZWwgcGFnZSB0YWJsZSBw
YWdlcyBhbHNvIHJlcXVpcmVzIGFuDQo+IElPVExCIGZsdXNoIGJlZm9yZSB0aGUgcGFnZXMgYXJl
IGZyZWVkLiBCdXQgSSBxdWVzdGlvbiB0aGUgcHJhY3RpY2FsDQo+IHJpc2sgb2YgdGhlIHJhY2Ug
Z2l2ZW4gdGhlIGV4dHJlbWVseSBzbWFsbCB0aW1lIHdpbmRvdy4gSWYgdGhpcyBpcyBhDQoNCkl0
J3MgYWxyZWFkeSBleHRyZW1lbHkgZGlmZmljdWx0IHRvIGNvbmR1Y3QgYSByZWFsIGF0dGFjayBl
dmVuIHcvbyB0aGlzDQpmaXguIEknbSBub3Qgc3VyZSB0aGUgY3JpdGVyaWEgaG93IHNtYWxsIHdl
IGNvbnNpZGVyIGFjY2VwdGFibGUgaW4gdGhpcw0Kc3BlY2lmaWMgY2FzZS4gYnV0IGxlYXZpbmcg
YW4gaW5jb21wbGV0ZSBmaXggaW4gY29kZSBkb2Vzbid0IHNvdW5kIGNsZWFuLi4uDQoNCj4gcmVh
bCBjb25jZXJuLCBhIHBvdGVudGlhbCBtaXRpZ2F0aW9uIHdvdWxkIGJlIHRvIGNsZWFyIHRoZSBV
L1MgYml0cyBpbg0KPiBhbGwgcGFnZSB0YWJsZSBlbnRyaWVzIGZvciBrZXJuZWwgYWRkcmVzcyBz
cGFjZT8gQnV0IEkgYW0gbm90IGNvbmZpZGVudA0KPiBpbiBtYWtpbmcgdGhhdCBjaGFuZ2UgYXQg
dGhpcyB0aW1lIGFzIEkgYW0gdW5zdXJlIG9mIHRoZSBzaWRlIGVmZmVjdHMgaXQNCj4gbWlnaHQg
Y2F1c2UuDQoNCkkgdGhpbmsgdGhlcmUgd2FzIGFscmVhZHkgY29uc2Vuc3VzIHRoYXQgY2xlYXJp
bmcgVS9TIGJpdHMgaW4gYWxsIGVudHJpZXMNCmRvZXNuJ3QgcHJldmVudCB0aGUgSU9NTVUgY2Fj
aGluZyB0aGVtIGFuZCBzZXR0aW5nIEEvRCBiaXRzIG9uDQp0aGUgZnJlZWQgcGFnZXRhYmxlLg0K
DQo+IA0KPiA+DQo+ID4gYW5vdGhlciBvYnNlcnZhdGlvbiAtIHB0ZV9mcmVlX2tlcm5lbCBpcyBu
b3QgdXNlZCBpbiByZW1vdmVfcGFnZXRhYmxlICgpDQo+ID4gYW5kIF9fY2hhbmdlX3BhZ2VfYXR0
cigpLiBJcyBpdCBzdHJhaWdodGZvcndhcmQgdG8gcHV0IGl0IGluIHRob3NlIHBhdGhzDQo+ID4g
b3IgZG8gd2UgbmVlZCBkdXBsaWNhdGUgc29tZSBkZWZlcnJpbmcgbG9naWMgdGhlcmU/DQo+IA0K
PiBUaGUgcmVtb3ZlX3BhZ2V0YWJsZSgpIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiB0aGUgcGF0aCB3
aGVyZSBtZW1vcnkgaXMNCj4gaG90LXJlbW92ZWQgZnJvbSB0aGUgc3lzdGVtLCByaWdodD8gSWYg
c28sIHRoZXJlIHNob3VsZCBiZSBubyBpc3N1ZSwgYXMNCj4gdGhlIHRocmVhdCBtb2RlbCBoZXJl
IGlzIGEgcGFnZSB0YWJsZSBwYWdlIGJlaW5nIGZyZWVkIGFuZCByZXB1cnBvc2VkDQo+IHdoaWxl
IGl0J3Mgc3RpbGwgY2FjaGVkIGluIHRoZSBJT1RMQi4gSW4gdGhlIGhvdC1yZW1vdmUgY2FzZSwg
dGhlIG1lbW9yeQ0KPiBpcyByZW1vdmVkIGFuZCB3aWxsIG5vdCBiZSByZXVzZWQsIHNvIHRoYXQn
cyBmaW5lIGFzIGZhciBhcyBJIGNhbiBzZWUuDQoNCndoYXQgYWJvdXQgdGhlIHBhZ2UgaXMgaG90
LWFkZGVkIGJhY2sgd2hpbGUgdGhlIHN0YWxlIGVudHJ5IHBvaW50aW5nIHRvDQppdCBpcyBzdGls
bCB2YWxpZCBpbiB0aGUgSU9NTVUsIHRoZW9yZXRpY2FsbHk/IPCfmIoNCg0KPiANCj4gVGhlIHNh
bWUgdG8gX19jaGFuZ2VfcGFnZV9hdHRyKCksIHdoaWNoIG9ubHkgY2hhbmdlcyB0aGUgYXR0cmli
dXRlcyBvZiBhDQo+IHBhZ2UgdGFibGUgZW50cnkgd2hpbGUgdGhlIHVuZGVybHlpbmcgcGFnZSBy
ZW1haW5zIGluIHVzZS4NCj4gDQoNCml0IG1heSBsZWFkIHRvIGNwYV9jb2xsYXBzZV9sYXJnZV9w
YWdlcygpIGlmIGNoYW5naW5nIGF0dHJpYnV0ZSBsZWFkcyB0bw0KYWxsIGFkamFjZW50IDRrIHBh
Z2VzIGluIDJNIHJhbmdlIGFyZSB3aXRoIHNhbWUgYXR0cmlidXRlLiBUaGVuIHBhZ2UNCnRhYmxl
IG1pZ2h0IGJlIGZyZWVkOg0KDQpjcGFfY29sbGFwc2VfbGFyZ2VfcGFnZXMoKToNCiAgICAgICAg
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHB0ZGVzYywgdG1wLCAmcGd0YWJsZXMsIHB0X2xpc3Qp
IHsNCiAgICAgICAgICAgICAgICBsaXN0X2RlbCgmcHRkZXNjLT5wdF9saXN0KTsNCiAgICAgICAg
ICAgICAgICBfX2ZyZWVfcGFnZShwdGRlc2NfcGFnZShwdGRlc2MpKTsNCiAgICAgICAgfQ0K

