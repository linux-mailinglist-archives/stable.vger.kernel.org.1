Return-Path: <stable+bounces-244698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IaELbWc/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:20:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D14F39CE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CBC300EF41
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714C36403A;
	Fri,  8 May 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6P2SGwW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0138372662
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228340; cv=fail; b=NhbXAEF6IluNBn1fdg6PIEfonjfDGsPBPjnHtUwswDgOloZvrV9HKY8CAyjTzblrjbEVj4F3VR+phYpakoE/9NMcRCYodfUKzRK3U5JdPt7Z/Do+bOy26yjnynL93TR5nqISIgeFJLiUhQSkbBZUih10URUzpaE/GuT5Wzrf6u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228340; c=relaxed/simple;
	bh=eNHqZdbxMslzAp623x00jl6+xf2YZnuDNGWA4g8CSdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1ED0LCwgZvUFOG2GFfVMbDAjF3QXtqBqtHjSzMrrnzksGv916/sZUi9oOdphH4P6DOxuOgtcHcI+GG0HuWgwq1NC2SyHJXzueBNPNLyw84biQrH+USs9xEexDvkVUWZbeGipVi9XPhVwo48gntTGaPv/ek0mbP0L4iJegY930I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6P2SGwW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228338; x=1809764338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eNHqZdbxMslzAp623x00jl6+xf2YZnuDNGWA4g8CSdU=;
  b=X6P2SGwWGInD7Xh0C2jQHjCo1QlkhXwE3DF75oxQzewHGme29VnpJxHJ
   meQ+chIR1dWsBq9lWgVdW1w6glmenP0OdwKPjJfenUli7aR79L6qUjCH4
   r5Y5XzIG3CpQNpOiP8d+X8YtM7OWx+Pgs4VVUfuEUYon5iz4qSjkhxzYu
   aGAkcEY/fB5m0fvC6QPRR1tl0WmwZE8Dfpefqu78Q/BD5xbfuncb0mltF
   ijqdPHM/B9knQtHsWVGK9E2bER1gKsoVA3MxP2nFP2K5QLQNqNjf0rwAU
   5HEEz4wUtZhhGICM8lC80x/AHrQEayjWPeVZO8uqXMM4p+quAah37M4sv
   w==;
X-CSE-ConnectionGUID: jr2PgvkbR8qODNeJ/5NzOg==
X-CSE-MsgGUID: mYgGccQWSymN0elydKFI1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83063333"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83063333"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:18:58 -0700
X-CSE-ConnectionGUID: RiQIlDXiSm6sRHUCe9lr/g==
X-CSE-MsgGUID: ogXB+CELQdy4dFals1GP/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232174020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:18:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:18:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 01:18:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRPxvyqL1m3eu3YUx+J/kcDDss2shr5GBjXAmx3ZjxPS+XlTHdIw8njoAX1khaVHXXOHXLcmmfHD4712bIch6jLypSB79K6s0DskcXQjPkEmZwi1KwzIFOFEyUQLh/FcYOWBzEfXxXrYqwm6Ocx5fYSIqsIOxmjaqI+BXXwy3A3vq1TT14HO7XkN8PM7n5U74pMcwJv4rbUKXR2yrDX89V4c/G27Dhg+kQHqMpYPSRmyF797Do2iBy4g+2e2IobtrMiXhGFQSdsb312ts/PhbdVetIMENE8x1uQqlJircPiUGy2zLLIFWtJkoRyk5a3MsX1y+AxpD7zuTc8u9WQ+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNHqZdbxMslzAp623x00jl6+xf2YZnuDNGWA4g8CSdU=;
 b=VmDL94xGvvzAHk4Bh7XeWk9G6QXyNVSP4lUC7vfqCuumaf5bqmAhgRilazYDxsxsBYxffsgDBOZHVilG/134ty2X1z8yyHvExVAIqxGYbPe/TNBXdgXQdL3jShNMHFWYMACBJPGKq1Vjr7jbR5v8cEQl1wRFsXQoKV4ULWpI2my4zU27p5KZJ+zaKuk1JC/InmMaJEcXgoAUlU6bFtCaLhWTXf89kABID7rAFK2Kj+dzcx7gQLVppKL8d3h7YwjCoLRIPWdKPZlM+t5S/Ur9fjrEuBfkTj88j5tnGcEB2hT2wnpkMQQo782B7iz5ZMNQ1M3GUVO3Ini1IAS9VqK0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 08:18:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 08:18:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@nvidia.com>, "alex@shazbot.org"
	<alex@shazbot.org>, "kvm@vkger.kernel.org" <kvm@vkger.kernel.org>
CC: Leon Romanovsky <leon@kernel.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>, =?utf-8?B?Q2FybG9zIEzDs3Bleg==?=
	<clopez@suse.de>, Matt Evans <mattev@meta.com>, Jason Gunthorpe
	<jgg@nvidia.com>, =?utf-8?B?Sm9vbmFzIEt5bG3DpGzDpA==?=
	<joonas.kylmala@netum.fi>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] vfio/pci: fix dma-buf kref underflow after revoke
Thread-Topic: [PATCH] vfio/pci: fix dma-buf kref underflow after revoke
Thread-Index: AQHc3i7gofJ5LWfSRUC5jiNaYxaCOrYDygvA
Date: Fri, 8 May 2026 08:18:48 +0000
Message-ID: <BN9PR11MB527656348E15FDB96FCAD5B48C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260507143548.1018405-1-alex.williamson@nvidia.com>
In-Reply-To: <20260507143548.1018405-1-alex.williamson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7040:EE_
x-ms-office365-filtering-correlation-id: 144b5ded-0a3b-4e24-f2fa-08deacda6e4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Swym8aP3cet/QMXnEwsCyPC+T/XgHes07r80GXYofXsDEavWuzd5C949ockutiiPpM8454JiDvYWWK8cx6OAEurcSRmrF4v83Sl21iz/JkBcqbR4+UYMJKwpi/MfhjvC+1rVS9n5YEZKY8IBltKNs8PWnUW0HcIKg7id+jzF05NI49TH7yZbnfDj2zMIp3aRQ0Ohc8UCVrRp/elrS39+XRljzOSyf60xzZQqjPRV4S1XEKln9Jr2KcxysLDzajIJDxCF4OtsNx3PSiIAlsLFJP/aKD1x/CSXNMZPZmczgimkCXT2paBFwqBdR7n1YdAPq/rTRNz/bUp6Kmp7NgybC+FdFbeLbdH65dDLJrV2wr3ajxBmVGoau05vnT7UKtrwVkYij1shDvkgnPA5H6677IjC5iiuWZeb4agCRRFxeMgVauphqiMp0muSegD0OKGIQ64/q4D+dUwrp5xeItMDFUGZ7PzNVXol0JriuR9cTc0st0YU19W8i54HovgLU+trqFUT3etmtvMvirC6zBOMAu6585eFVWuGmv04aoZ5QoZ0b19qkmCG9MWwhKF7W0FaX/CkKOjlKsc5w+fooMAbdP4vIqp2NFEpBiJyO6pYR89MoSRAO3ddmTawqZOsdUd9GHrO7sByWf3DLaDcwTFUaxTLG3QU9Xbd/vHA/4ysyB/kNXs949nchx4N2okZ/ekOrEyuDTmUHJ1I87T66bNxCpL/7Dvk7c8Ar3vwSA0AzwbzjWThV2FK+KhqxWBgJbLp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk8vYjg5YmE3OVpxM1NGTFFGNSs1QUxGbEVmK0hhcmwwQzBxb1hFWkc0amtX?=
 =?utf-8?B?eVp6Zi8wbGZKN1p0QmM0dWIvM1JkR09EZjNnbUhYZE5VU2RwVFdSZzlZbjNL?=
 =?utf-8?B?RDlZcDh5N2RZMldJTnlQR0Y0NnBMWjVSdElFVVpNeEZRdlh3Nnh2eTI3RFEz?=
 =?utf-8?B?dm5HUnZ1bHdNZVEwcXFMV0J1ZitvZUFPbVU2UWJnTW1ubEVoSWcwU0dESlky?=
 =?utf-8?B?QWt5TUFKZFBLYk12d3JlZ0RIMzh6NFpnQnhFOGNpOXVhQWlKTThLMUZLR2sz?=
 =?utf-8?B?T1psSThEQUIyWUNkRE5leGZDWUtSUXpsR0ZhRnIzQ3JyK3FjTlNsVmxlQW1W?=
 =?utf-8?B?SFJIcngxU0wxT3VyR1Fvb21SNmNnZFhwOUJRR05JRW82ckFkYlhVMW9VUEpo?=
 =?utf-8?B?U2Q3N1Z5ejNibHFSQnU4Y1E2R3ZDazhCdTdTRmF4clo3cFZhSWZvL28rcENF?=
 =?utf-8?B?WXdlU2lyazZ2aWJLZkFtZDZ3SkFsZ2ZpcnhtZWY1eDdNUFZvZUEydEMxTzQ3?=
 =?utf-8?B?amFHY3BrS3ZLRldwUUtkdGFDUTFVdENNRVUwK0NqdmNJU21RVGdSQUUvTDd4?=
 =?utf-8?B?MUZiZ1dOYnNlNDlEanl2M3VnZE1qQ1JITXZlRUJVOE4va29LS2NlaWZJdlM5?=
 =?utf-8?B?cnBUdVorMUtNZm9JYkQ0WE9LbXloM1V0UXNRY2lKQnNZZXZub3lpcG83UGNP?=
 =?utf-8?B?VC9yQzhCd0JFb1lKZC9HaURIM2FjaDR3Y3diQVVudGtSMnEzMGtmeGxXRUsy?=
 =?utf-8?B?UWwyZWVuNU12ZXJDV2tkNW0xcHpqZFM0OGNZNFM3ZGN4OTlTbXZFZVlDK2lW?=
 =?utf-8?B?a09ERy9YMU5KSUVXYm9ZOEtvVWh5S0xIMFlsaXk5ODN2QXYzVDRZVitYOFMr?=
 =?utf-8?B?dEFpcmdrNCt1SGtXSU9NcUZWc1hMSjBTYThFdXl4UE5vRlNQWDF2RlVVbXFu?=
 =?utf-8?B?QXhBUzZtWGdoR1Q1UkNYa1RadmlQNVc5ZXhZQ2d6ZHcyUFY2c3drNWZvcTJJ?=
 =?utf-8?B?cy9Va0FyckVtSDBNclJzNUNQY0ZzeDZmb3pNSlJjaTBBU2xCUjRzL0xaVjJ6?=
 =?utf-8?B?T1pGTzZVa3p6aDU2enR6ejZlYkR4Sm5iYzk5TlRVbDhFcWpzV1h6QlhKNCto?=
 =?utf-8?B?b3dmZmVSU2FQTFlkeXNrL1BnRysyYXhGaElHUlEzSGNFSmpJaXowUm9yaXcx?=
 =?utf-8?B?TmlOOU5MMGo1L0hxNEpBcjZWY2tIbDdoVGh0YzJKWjVIbURPTVlwTmFrdFVk?=
 =?utf-8?B?SGRPcDV2dG80ckpsWDVNQXdReE9HK3g2bXhIQjVUcU9NWit1UW9INE16R01J?=
 =?utf-8?B?bkRXRnNIMVdsTW9IZWdQRFhjSjNDZFljdGh0bEpmeXF1RDF3cEJaQWZOYnVk?=
 =?utf-8?B?aHJLcW5iWVZhUkxQdTZmak1zdGhDNVdEMlFVZXFNQk9xNVMzYUNrUmlhQ1ZN?=
 =?utf-8?B?cEMvaE1DbTk4RHpPeE8xNG5xdWRQbUFuMHZ1TEc5WUdWN0xpMGxPcE95bGV2?=
 =?utf-8?B?bExGaTRnTVQxeFpBUDVCRDZrVTZzbC91NVhEbkJBazdaSThQSklWM0tuZFFU?=
 =?utf-8?B?TEVPZTNjai9vai92UWpPak5leXUyLzMyZ2h4Z0o1Mm1hWWk0OFFGOVJKbjBP?=
 =?utf-8?B?OUZQN1Z4a3VleTQ2M29ZU1FZVFIvR3g0a05qK0JZYVJST3JVWm14WTd0WDRI?=
 =?utf-8?B?Q25SZ3VYOXhlSnJlWEtVc2wvRDBOSVRJRWY5ZzVtc2F3YWpRaUVLdmdFQ2xO?=
 =?utf-8?B?ZG9JZGJqNGJDM2dOTkl3c3ovc3JDOVpvam9pZGd0c2hvZ2FhcHFCSm40TmdC?=
 =?utf-8?B?T2dPV0VZR3kvZ1NzWHR5eXdZK1ljNDJuTmppbUZScW0yTEtRR213YmFmZHdK?=
 =?utf-8?B?MjNObmRGSHg0c2VtTmNmd1d2Mi80ZUVlYmh6bEMxNXBnQWNSdlQ3Sm5SMUlz?=
 =?utf-8?B?bVVZcHFsWXFuWGx1Z3pZOUN6cG5sd0lRMGZPYkhNZTV4L2l5d1FId0FkR2s2?=
 =?utf-8?B?Zkh2a3dSRzRQeWdTaVg1RzZMUXh3dWpwVHFTcnNkYUtZdC92N1lCYXhpSVds?=
 =?utf-8?B?bDBya09RVkVwa0JUdFpxTEJMNG03SVJzT0dBaG1QT3hDY09XTFoxYjdTdU93?=
 =?utf-8?B?alV6SXRNYWxEc29BTzJQYkkvUFRBVUpRUjY3NlBNbkp5V2lDb015Z2JjNWtR?=
 =?utf-8?B?bVYzTWh6RHdXTDViN1E5eGozRjNtU3ZKaURnUWxrbFB6Q28wOTFLdXc0OEhW?=
 =?utf-8?B?d0ZuTEhVT0lBcVVMc0J3aXJiZE1NS1ZQT2lkVkhCeElsa09IaHZUMmVneHRh?=
 =?utf-8?B?Um9OSUpSVkdCSS9UeXkvbUhPaHd1Q3N5cFRNTnhBZzFaMFNFSXp4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qVraX3WKublAFdfapXdGhx0WG657WfUCH8iotmlzidxh7cI19zYHveSZksJzBniJvO0DncX0JFs8a4ccJMmRXZKsox+wMTd0IjwtGJ+HwJ43W/YWUSHKqJCzQilrNiFEKAOZc2pezGYkZnw0gOkotIpJITc8g3UyihttgZTtelZu9m6zvwuujHe/oOi4g28F98FmGeW0RyO/8FnuoFM+tYCxeCjCa0C95TAUg9tsmyLTxAW0BX8Ml6avMYdL3lfHmY6tcLsqIjPCrsRI4Gc+K+FNhMzhIj1jdhJhnKNLVqxh39stNXKq2LmW55ZiRhKl71tnRpSb3ficdBgCT4MA2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144b5ded-0a3b-4e24-f2fa-08deacda6e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 08:18:48.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uFtzMXqIc7qugf/YPFL6fhV+dZAwH0HweHC6M5RZN3/pWamQ+bazPVN4F5IDPKby5Iim8lHVT28bdgBxM8nJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 141D14F39CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,netum.fi:email,BN9PR11MB5276.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkBudmlkaWEuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgMTA6MzYgUE0NCj4gDQo+IHZmaW9fcGNpX2RtYV9i
dWZfbW92ZShyZXZva2VkPXRydWUpIGFuZCB2ZmlvX3BjaV9kbWFfYnVmX2NsZWFudXAoKQ0KPiBy
YW4gdGhlIHNhbWUgZHJhaW4gc2VxdWVuY2U6IHNldCBwcml2LT5yZXZva2VkLCBpbnZhbGlkYXRl
IG1hcHBpbmdzLA0KPiB3YWl0IGZvciBmZW5jZXMsIGRyb3AgdGhlIHJlZ2lzdGVyZWQga3JlZiwg
d2FpdCBmb3IgY29tcGxldGlvbi4NCj4gV2hlbiB0aGUgVkZJTyBkZXZpY2UgZmQgd2FzIGNsb3Nl
ZCBhZnRlciBQQ0lfQ09NTUFORF9NRU1PUlkgaGFkDQo+IGJlZW4NCj4gY2xlYXJlZCwgYm90aCBy
YW4gaW4gdHVybiAtLSB0aGUgc2Vjb25kIGtyZWZfcHV0IHVuZGVyZmxvd2VkIGFuZCB0aGUNCj4g
c3Vic2VxdWVudCB3YWl0X2Zvcl9jb21wbGV0aW9uKCkgYmxvY2tlZCBvbiBhIGNvbXBsZXRpb24g
dGhhdCB0aGUNCj4gZmlyc3QgcnVuIGhhZCBhbHJlYWR5IGNvbnN1bWVkOg0KPiANCj4gICByZWZj
b3VudF90OiB1bmRlcmZsb3c7IHVzZS1hZnRlci1mcmVlLg0KPiAgIFdBUk5JTkc6IGxpYi9yZWZj
b3VudC5jOjI4IGF0IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHg1OS8weDkwDQo+ICAgQ2FsbCBU
cmFjZToNCj4gICAgdmZpb19wY2lfZG1hX2J1Zl9jbGVhbnVwKzB4MTYzLzB4MTY4IFt2ZmlvX3Bj
aV9jb3JlXQ0KPiAgICB2ZmlvX3BjaV9jb3JlX2Nsb3NlX2RldmljZSsweDY3LzB4ZTAgW3ZmaW9f
cGNpX2NvcmVdDQo+ICAgIHZmaW9fZGZfY2xvc2UrMHg0Yy8weDgwIFt2ZmlvXQ0KPiAgICB2Zmlv
X2RmX2dyb3VwX2Nsb3NlKzB4MzYvMHg4MCBbdmZpb10NCj4gICAgdmZpb19kZXZpY2VfZm9wc19y
ZWxlYXNlKzB4MjEvMHg0MCBbdmZpb10NCj4gICAgX19mcHV0KzB4ZTYvMHgyYjANCj4gICAgX194
NjRfc3lzX2Nsb3NlKzB4M2QvMHg4MA0KPiANCj4gQ29sbGFwc2UgdGhlIGR1cGxpY2F0aW9uOiB2
ZmlvX3BjaV9kbWFfYnVmX2NsZWFudXAoKSBub3cgZGVsZWdhdGVzDQo+IHRoZSBkcmFpbiB0byB2
ZmlvX3BjaV9kbWFfYnVmX21vdmUodHJ1ZSksIHdoaWNoIGlzIGlkZW1wb3RlbnQgZm9yDQo+IGFs
cmVhZHktcmV2b2tlZCBkbWEtYnVmcy4gIGNsZWFudXAgcmV0YWlucyBvbmx5IGxpc3QgcmVtb3Zh
bCBhbmQNCj4gdGhlIGRldmljZSByZWdpc3RyYXRpb24gZHJvcDsgdGhlIGRtYV9yZXN2X2xvY2sg
dGhhdCBicmFja2V0ZWQNCj4gdGhvc2UgaXMgZHJvcHBlZCBhbG9uZyB3aXRoIHRoZSBpbi1saW5l
IGRyYWluIHRoYXQgcmVxdWlyZWQgaXQsDQo+IG1lbW9yeV9sb2NrIGNvbnRpbnVlcyB0byBwcm90
ZWN0IHRoZW0uDQo+IA0KPiBSZS1hcm0gdGhlIGtyZWYgYW5kIHRoZSBjb21wbGV0aW9uIGF0IHRo
ZSBlbmQgb2YgbW92ZSgpJ3MgcmV2b2tlDQo+IGJyYW5jaCBzbyBwb3N0LXJldm9rZSBzdGF0ZSBt
YXRjaGVzIHBvc3QtY3JlYXRpb24gKGtyZWYgPT0gMSwNCj4gY29tcGxldGlvbiByZWFkeSkuICBU
aGlzIGtlZXBzIGNsZWFudXAncyBjYWxsIGludG8gbW92ZSgpIGEgbm8tb3ANCj4gd2hlbiByZXZv
a2UgYWxyZWFkeSByYW4sIGFuZCByZXBsYWNlcyB0aGUgZXhwbGljaXQga3JlZl9pbml0KCkgdGhh
dA0KPiB0aGUgdW4tcmV2b2tlIGJyYW5jaCB1c2VkIHRvIHBlcmZvcm0gZm9yIHRoZSB1bi1yZXZv
a2UgLT4gcmVtYXANCj4gcGF0aC4NCj4gDQo+IEZpeGVzOiAxYThhNTIyN2YyMjkgKCJ2ZmlvOiBX
YWl0IGZvciBkbWEtYnVmIGludmFsaWRhdGlvbiB0byBjb21wbGV0ZSIpDQo+IFJlcG9ydGVkLWJ5
OiBKb29uYXMgS3lsbcOkbMOkIDxqb29uYXMua3lsbWFsYUBuZXR1bS5maT4NCj4gQ2xvc2VzOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvR1ZYUFIwMk1CMTIwMTlBQTYwMTRGMjdFRjVE
NzczRTg5QkZCMzcyDQo+IEBHVlhQUjAyTUIxMjAxOS5ldXJwcmQwMi5wcm9kLm91dGxvb2suY29t
Lw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTQtNw0KPiBSZXZpZXdlZC1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5l
bC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29u
QG52aWRpYS5jb20+DQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVs
LmNvbT4NCg==

