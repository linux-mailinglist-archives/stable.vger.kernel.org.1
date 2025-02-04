Return-Path: <stable+bounces-112119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1DA26CD1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B43188938A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249552054F2;
	Tue,  4 Feb 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYID8OkX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DB18B494;
	Tue,  4 Feb 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655343; cv=fail; b=tcjUeIULtuVO8GbthiHNy5rN9uSmdas083Nhyyeahwf+vHZsZNdsVZ2QW11M998GiyWMCCCrUef00VlM9Z54SpX2ugaVSZvPKFWMkomWmypDGZRq5dXOAWquIiWNLgXbkZh081y1k3KC32pdL5qMK7lXPrgLhbYTT5BQD/WjdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655343; c=relaxed/simple;
	bh=85VEgmnvLiqDPPyx3VW7PalKJysu34v4ogjhdhl8Bsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBc5dzPFe16tMBPC674bAk/lnQ6xRiAPT5ctUIIcBjMDouqB3E147xldOaC6b7oNjJ78HMeY232dWQ6yf5Sh8c5hvAt1rK9E1rAtJ+WmCRzdC4/VKmdDVLQKnp+u/ozgmkRtp1ZozrT42SA6pZOeluvIIcEi49HNsMJmnVs/gCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYID8OkX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738655341; x=1770191341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85VEgmnvLiqDPPyx3VW7PalKJysu34v4ogjhdhl8Bsk=;
  b=SYID8OkXTJmHxAaVMpW/hhbGFN84KgC5loeYELWU0UabRDURFft8f/FK
   u+4bktfajZ8gXcmldar3O41kLKMsovunuOI9lgCGjfs7C+sZes8zu4VRw
   ehUuThvjbAQVIW240QzIvHOw/VXF3URc2oQ6bFSgdINrYw70G3KHf/BD8
   s9ElvHqt1aMuQt4P24RdH7paFuXjVWX7RNyjVGnZy0pDsGaBNdz1wrr2n
   pygzBcFkL+yehzYVgeYvHVNOOve4WFudEponZf4S4Fj6sYV34C7dxjAS6
   Ew7sVhG3fXlhdeuPV1GIDhvbUwbhV83F+aF2Oiw+4XdCPt6HWvM0bgBX5
   A==;
X-CSE-ConnectionGUID: Nr2XlayqQa2BZcUAiydlSA==
X-CSE-MsgGUID: OwlOiv4MQHulBZ81mLd+fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50588512"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50588512"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:49:00 -0800
X-CSE-ConnectionGUID: mJ4rc7OtQUSpyADLf+Cdvw==
X-CSE-MsgGUID: T66QE29VSVG7uUUZExn86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="111103692"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 23:49:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 23:48:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 23:48:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 23:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as5da2e6We4MKTXOv6G9ijKqq2i5dXH6SQvjyDWIngyPNutoyQBIKYfeoxz7tII1hP0P/eX0UNE9wpIjrCb13s8YtAyx4pYR/u+L4HAMTw9OP5rhHGqc01PxxWXmjfrICb5fyBtYdH35Q8ruOJbrmzJjXXNRJJ2QOCapfvfhD0NddduaReVDN0kl0adPj8NM5JMuS/zfYuhO6ABQTIZighfGp6HGg3OSiDjM2PS48AB4V/30tg27RNKtEEDp9Tt+X22E6Pt4zCECwXA4xXKh77Fdl+Bl514LyPsdMuyV/xrna/jJ6JRa7RBHW7XgLpp6s/ztAtkf0e8DvdBdSNua5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85VEgmnvLiqDPPyx3VW7PalKJysu34v4ogjhdhl8Bsk=;
 b=cyHT62kk27r7PZHy6iQ7F1P/XPf+PhmbBq5F53pKWIMrGYP9l0QrNEP/xmuhPsmjxm02gKagOeZ+Oh0VpXct/dMRXYG8Sz+OMe9CauEeWvh4YYSFWtWwyB4kdrE8Iou4Sds1rujeqUKVzOvZRcvOlwkmOKRxzmBYFmuIliB1USpgKWxrM1sOOEIkC7OXBxL4jJllMbdl6Q9A9iXrQAzLUfDMbfHK2hdFxirf1ATiUyWqJ/tFbuH54qkV5txefxArv2IZWNAXP3y1bY+NmhNSXCNsMpZiyTyT/ixMhjVKTXY7ytSCoeJWNi27U48vmeWnyZDmYBNtRYaSdPwHE0EwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by SN7PR11MB8110.namprd11.prod.outlook.com (2603:10b6:806:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 07:48:57 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 07:48:57 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux@treblig.org" <linux@treblig.org>, Shen Lichuan
	<shenlichuan@vivo.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Topic: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQCAA0UcDoAA++LggADu3AKAB1OZ0A==
Date: Tue, 4 Feb 2025 07:48:57 +0000
Message-ID: <BL3PR11MB6532451B44E7C5D82F5EC4AFA2F42@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	<874j1i0wfq.fsf@bootlin.com>
	<BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
 <87msf8z5uu.fsf@bootlin.com>
In-Reply-To: <87msf8z5uu.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|SN7PR11MB8110:EE_
x-ms-office365-filtering-correlation-id: 234e5f45-58af-47f8-7893-08dd44f0613a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c05HSHdKYjc2dTVIeVY0ZXY3WFdiN0pobFFkdmJKbHdlRlFMSlZZWEg1R1Ux?=
 =?utf-8?B?akZZODlnK2V1bmZWSmI0amJnbE96U1VkaGd1WWU3TGtkNDRpTUh0RHlJTkF2?=
 =?utf-8?B?NjZUMk1MSHRPclBpbG5pQWlSbU1sVXkrdXhYeE9OOWkzUlQwYXZ1Q252MDJ3?=
 =?utf-8?B?aTg3QkZzcWlheFFwL2MwUm5YcWRVbzhQNXBTSWZvS1F1dG5xYVdZRkwwVmU0?=
 =?utf-8?B?OEZEaS92ZjA0M3RmejhRL0JINjVnSjI3Rm00VVVBcmFCTkZJOGpUK3ZoeXJY?=
 =?utf-8?B?RFl1ankrMkVwUmIvM3Azc09BL0xXM3BSVk1QY2ZIamFvNkJlaGlmaVBiMUFX?=
 =?utf-8?B?RlJLQ01QQU9HdkI5a0c0ZGx2eXdRUHBTaHVZcm51SnB6dEJZNGF5cGM5elFk?=
 =?utf-8?B?bDhNeE1pMGJzRjdxMnZUcWdEeHNVZmhTN1NVS2hxWEI4dlcvRmlqZ2gyVGRq?=
 =?utf-8?B?amc3WUFzeEh5K1BPT3N0RXJmRS9seU9Xc1hZTkorRlBaOGtzcGdkMk5WMjdY?=
 =?utf-8?B?SEFOOUVGaDd3VkdIeUxjMFk3bnJiM3Z4cExIQ1pQRjNrTHd0clQrdXNacGU0?=
 =?utf-8?B?NndQWXdRblZQVU5aQ24zUThWbCtjbmxadlVaNEtMSkJoTjhvSFZWR2QxZ1A1?=
 =?utf-8?B?cEhIVTJ4ZVNrYTVvNC9rTEoyUGpISUF1V2k2OEd0Tmg2elF3ajRva2tuSEFp?=
 =?utf-8?B?OENETmJMTlhZcllvVVdvczdNUDNWSmlpTngwRmpldkZWTzdTd2V6YVRkemcz?=
 =?utf-8?B?QUJlYy8ycGhwWUpVRmYra0tTRjBwRDhqa2pHaVpZL2x6UHY2Unk5RlJ2UURt?=
 =?utf-8?B?RzdWRnVnVGdsWEZYYVRrMDFNTUhyaThFbnhXRFdjZWhnd25VdStnU25DNjVJ?=
 =?utf-8?B?NU9tUVdReXIwbUZ6eGQ4VC9hUUtjMk9uZzRIRkVDZTRnN3UxcVpyNzI5aVJ2?=
 =?utf-8?B?T0lhZVRHSzlFak0wb1dJeDhteHV1M3lPeHppdkFxOTdnVDcrVVE0UTVWQnhm?=
 =?utf-8?B?WTV5OG1NNXRPWlFHMFR0U2xIWG1iSTEwWEFrSTZYYTFpRHAybnl6TEs3Nnhw?=
 =?utf-8?B?M045ZmJZazBCRitnRTBrblJQQjY2OGowRTkrcUtIbGdMZm1FRmZpSXhVMGxm?=
 =?utf-8?B?MlR1aWxJODFDNnVuT3kvdndIZ21vRzBKcFhFWFFMb0RoclkrWTlDNTFabUE3?=
 =?utf-8?B?SndJWjNKUVBpN3FsS05RWU9lT3gzeXl0bHdqZ0I1b0Q2V3FCR2Fwc0ZjVTBL?=
 =?utf-8?B?Z2pYYTJoWXlXUVVGRHptZk9Vc2RnZ1RSbXFpbE9naUhYVFNQVkhsSUdwZUQ1?=
 =?utf-8?B?ZlVJUDVFU0hEQmdrMzZrcXJreXpUZWRFRmtZUjFWOUZQS1dMY3BtWnArYS9n?=
 =?utf-8?B?b2kyNExIRlNvVHJmRkZHNlN2TTErR3dleHNiZWdNZ3dPZUQrRlpkTFJvTjRS?=
 =?utf-8?B?bE01YTVNNTBVWEZ2MFJDOTB5cWVTVngxK1RTcjI2QXJzWUZSQk41eFBDakpz?=
 =?utf-8?B?T1k4NTVLaWhmekZkelo0emRqdldramo2WnJ2N2tub0QyQ0U2OS9IdDRNYnF0?=
 =?utf-8?B?bFllTURVcXhMMXZpcEF6MkJaVTdZMkVHY3Q1eXoyYlgwd1JUNkRYaVpjajJZ?=
 =?utf-8?B?aytGb004YjBrTXVVWmQrc1Y1cC93YmF1WUxMcDhzNnExd3lVZW9XS3dHT1dn?=
 =?utf-8?B?YS80UmxNQ0doM1FxRGx6Tkc5NWtIOUE1aHRoc2JlZEJ4Zy80WktlVnIwRWJU?=
 =?utf-8?B?OFZDdWJvUWxRSFI4eVhWellCK0F0aUliZGk1TlBKVFJYeFJiMWpJcnNZL1lB?=
 =?utf-8?B?b3U2aGppTFcwbkMwTjBmemRUekxQSVdDOTU2aEpabzRkVG9xTEJwN29MTGFC?=
 =?utf-8?Q?BuUsJdxCzDumb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUk4L2xNSCt3Sm13b01GeHMxNlhKWGJMRGx0ZlRsZW9FZGJKRThHSk9PbDlo?=
 =?utf-8?B?NXJDaEZiNzY2RllpTyt4bHdHNGZ4ZFl2cUMzZEFoTXY1MUdtUnRQZ01HamZl?=
 =?utf-8?B?WHJGTTZic0V4SHVaVTN2bmxhVEIyR09VMlZvSkV5b1VqZ1laL1BJV0FKaDRU?=
 =?utf-8?B?N1BZZkptWG8yK0FkZ0hFeVB3OWo4Nms4ZVhXZjhKMHNpd2F5T0psZ3JTZll6?=
 =?utf-8?B?dmFVWVJiMklES2VGN3dmUlpGM1JZSTdKaDRYekdzeDk0bWFmNkgrcW5vUnpi?=
 =?utf-8?B?blF1d1B4RlRCOWZXbTJwc0Y1K1liaCtOOTFjOXVZUWpNVy9xUWxRdW9mSDlW?=
 =?utf-8?B?L09Oc1ZhUjlSaFlrMlJobTBYamdYdHN2d2I1YytBR3hOaWVHdVRmU2xJZFVY?=
 =?utf-8?B?K1Yzc3F1RDd3SW03RUYvY0RnaGpta0lxS0xoNjM1emJpMlc3d0MxejN2OCt1?=
 =?utf-8?B?SFBwVTNFOTVrNWx1bmQ3dE1wNTFKSlF4b05yNy9rRVc2TUJrSDlCcjNwNzVJ?=
 =?utf-8?B?NjcvcWtvM1lFYVNhL0lHVEN3c3RGZjhlVzg0QXVxbEhaK2FhSnJxSm9TTVRu?=
 =?utf-8?B?YnNUS3kvdkdXQ2hZSnZCTGVwL05rVlM4Q2hxcERCZWYyYkhYcUVpSG13aSth?=
 =?utf-8?B?VWQvMVNibVB6TXRCNDlTR2dFanJlcklxWkpXL05yUUNIWU52T1E0SWNIQk96?=
 =?utf-8?B?Q3crQTRRY2pEODZDcXRtaTUyZ3RGTlB3bHlqdHFyTEU3K0EvK2prRHBhcUJP?=
 =?utf-8?B?eWVHZkxrM1I0U2FmcEIxRUFlMFowRDJkUUlJbXJSeTNXSmQxcjQ0SHZyV05V?=
 =?utf-8?B?bmxEditNY1J1Mmt4bk9XSG1IUnNVSkppRHhnTWEyTDhQMDlBVEpQRElpaC9a?=
 =?utf-8?B?ZGNIalV1KzY1bjBXRWV4dXBTVC9yU3FtNXFibUQ2TzZCWjVDOTNsc21WUjF5?=
 =?utf-8?B?NFhOMjI5OFVxRVJrSWF5eW56eGFPMCtqNUlScWdWQnAvUUNSMXdZeHVDMmZC?=
 =?utf-8?B?KytkUGpWTU5YS1JWcVVDNlYzOU9jUEtMMWhTbEdHK3h1cG8xb0Nabmc1YXlW?=
 =?utf-8?B?WjF1Mi8yZStJVFVhY3JIZ1I4b1pWSUxhRGFyZXZpeEhOaXJBcUpROWtJeGFP?=
 =?utf-8?B?eXA1Q2k2eE9ZTlFvNVVqTWthQ1hPYXdBUmdPNmtNZUFhcHh0bnlEZWo0cHVi?=
 =?utf-8?B?Y3Fka1Z1MkJUc3l4ODVId0FYOUpscU5LYWc5bEFVSHdoYllDQVFKYlkvaDY3?=
 =?utf-8?B?NDYzMlpSemZzSzh5SnVNWlRQcVhVRGUyS0NTY2gvaHZFY282Uy9mZkpjRXha?=
 =?utf-8?B?aWo3RER4aFJQTVJHMW9QNUxDOWdWQ2lEcEljcitBQzlWQmQ2UlVRUEQvQmph?=
 =?utf-8?B?eE40SWJoN0hacnowOENlMG5vMXZ5T2IvUzdYRHlWT2pmU2dJczluK09hZE51?=
 =?utf-8?B?MVY1UWY2ZUc5QTVyUVp3NGJRMERtdkRxZVBjVXArVHJhd1dSaTdGMy9zSmxW?=
 =?utf-8?B?dERYcWwxTU5OY2p1VnZNTCttMG55ZHRBNVJLS2NzNmw5ekFPNlJhQU8xUWRD?=
 =?utf-8?B?L0g0bWdnN3RLWHVsdzNjU1I1Z1kvUUJiRS8zdmlWV1psbFJuMXdYQjZzclF2?=
 =?utf-8?B?dVBwckpFaHdBZU5naDM4MGJ3OUlDZVRVdEpYODgvcXpLWFcwN1lFTVNUeUhy?=
 =?utf-8?B?akp2VmxVelFGdkh4cytXK3lZR1dLU1RzcXZXNzQ4MFZCWk9mM1VuOVYyWWR0?=
 =?utf-8?B?TGE1UWY5YjI2WW1rUjJwU2cwa3ljYit1Q1VBMEtrdFZ3Wk1CWExrOHZuTlgw?=
 =?utf-8?B?YWJTRVVqWVNpakhDUVkyN0w2bjdqL2gzaWpneDdYMXM0SUdFQ3FZdW90WHhj?=
 =?utf-8?B?b0NlNFhYUytQUVNIVnpjZFFmdkxtdUNQbExqWjN2a01Ga0twRjIwU0NBVkNp?=
 =?utf-8?B?L29laEpYQXJTRUtHeVErVGUyaUdSdDNCV280YVROSzhHSkwzNEpvd3V4Y0Y3?=
 =?utf-8?B?akdrMzUyRUtCcW1FeGJWMU9vZmhhSGU1R2dKMm93Z0NYT0h0V2pBaVYwb3pJ?=
 =?utf-8?B?cllGT1NRcER2WHd0VWJCK3NhbWU5OWYyYjJ0OXJKVXBKUmlhZGFWaEYyb05L?=
 =?utf-8?B?R2JDbENqS1hDYUJLVDRiSFRoRk1yZlkrc3JFcXBuVmxsWkI5RE5QdlhMeDdv?=
 =?utf-8?B?aGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e5f45-58af-47f8-7893-08dd44f0613a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:48:57.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UPibBYWz0uyQAhz7S4LnLaa+j14t8iwCpDXqNbRZDzzC/kvvEJvprgDZaP6X0r8aTnB5p/DwuSqOvFs+KpGk4oYNCs9k+2DutS1Bhmblvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8110
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAz
MCBKYW51YXJ5LCAyMDI1IDExOjIwIFBNDQo+IFRvOiBSYWJhcmEsIE5pcmF2a3VtYXIgTCA8bmly
YXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJp
Y2hhcmRAbm9kLmF0PjsgVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiA8dmlnbmVzaHJAdGkuY29tPjsg
bGludXhAdHJlYmxpZy5vcmc7IFNoZW4gTGljaHVhbg0KPiA8c2hlbmxpY2h1YW5Adml2by5jb20+
OyBKaW5qaWUgUnVhbiA8cnVhbmppbmppZUBodWF3ZWkuY29tPjsgdS5rbGVpbmUtDQo+IGtvZW5p
Z0BiYXlsaWJyZS5jb207IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDEvM10gbXRkOiByYXduYW5kOiBjYWRlbmNlOiBzdXBwb3J0IGRlZmVy
cmVkIHByb2INCj4gd2hlbiBETUEgaXMgbm90IHJlYWR5DQo+IA0KPiBIZWxsbywNCj4gDQo+ID4+
ID4gRHJpdmVyIHdvcmtzIHdpdGhvdXQgZXh0ZXJuYWwgRE1BIGludGVyZmFjZSBpLmUuIGhhc19k
bWE9MC4NCj4gPj4gPiBIb3dldmVyIGN1cnJlbnQgZHJpdmVyIGRvZXMgbm90IGhhdmUgYSBtZWNo
YW5pc20gdG8gY29uZmlndXJlIGl0DQo+ID4+ID4gZnJvbSBkZXZpY2UgdHJlZS4NCj4gPj4NCj4g
Pj4gV2hhdD8gV2h5IGFyZSB5b3UgcmVxdWVzdGluZyBhIERNQSBjaGFubmVsIGZyb20gYSBkbWFl
bmdpbmUgaW4gdGhpcw0KPiBjYXNlPw0KPiA+Pg0KPiA+PiBQbGVhc2UgbWFrZSB0aGUgZGlzdGlu
Y3Rpb24gYmV0d2VlbiB0aGUgT1MgaW1wbGVtZW50YXRpb24gKHRoZQ0KPiA+PiBkcml2ZXIpIGFu
ZCB0aGUgRFQgYmluZGluZyB3aGljaCBkZXNjcmliZSB0aGUgSFcgYW5kIG9ubHkgdGhlIEhXLg0K
PiA+Pg0KPiA+DQo+ID4gTGV0IG1lIGNsYXJpZnkgZnJvbSBiaW5kaW5ncyhodykgYW5kIGRyaXZl
ciBwcm9zcGVjdGl2ZS4NCj4gPg0KPiA+IEJpbmRpbmdzIDotDQo+ID4gQ2FkZW5jZSBOQU5EIGNv
bnRyb2xsZXIgSFcgaGFzIE1NSU8gcmVnaXN0ZXJzLCBzbyBjYWxsZWQgc2xhdmUgRE1BDQo+ID4g
aW50ZXJmYWNlIGZvciBwYWdlIHByb2dyYW1taW5nIG9yIHBhZ2UgcmVhZC4NCj4gPiAgICAgICAg
IHJlZyA9IDwweDEwYjgwMDAwIDB4MTAwMDA+LA0KPiA+ICAgICAgICAgICAgICAgPDB4MTA4NDAw
MDAgMHgxMDAwMD47DQo+ID4gICAgICAgICByZWctbmFtZXMgPSAicmVnIiwgInNkbWEiOyAvLyBz
ZG1hID0gIFNsYXZlIERNQSBkYXRhIHBvcnQNCj4gPiByZWdpc3RlciBzZXQNCj4gPg0KPiA+IEl0
IGFwcGVhcnMgdGhhdCBkdCBiaW5kaW5ncyBoYXMgY2FwdHVyZWQgc2RtYSBpbnRlcmZhY2UgY29y
cmVjdGx5Lg0KPiANCj4gU2xhdmUgRE1BIGlzIHZlcnkgY29uZnVzaW5nIGJlY2F1c2UgaW4gTGlu
dXggd2UgbWFrZSB0aGUgZGlzdGluY3Rpb24NCj4gYmV0d2VlbjoNCj4gMS0gZXh0ZXJuYWwgRE1B
IChnZW5lcmljIERNQSBjb250cm9sbGVyKSBkcml2ZW4NCj4gICAgdGhyb3VnaCB0aGUgZG1hZW5n
aW5lIEFQSSwgdGhyb3VnaCB3aGljaCB3ZSBpbnRlcmFjdCB1c2luZyB0aGUgc28NCj4gICAgY2Fs
bGVkIHNsYXZlIEFQSQ0KPiAyLSBwZXJpcGhlcmFsIERNQSAoRE1BIGNvbnRyb2xsZXIgZW1iZWRk
ZWQgaW4gdGhlIE5BTkQgSVApIHdoZW4gdGhlcmUgaXMNCj4gICAgbm8gImV4dGVybmFsL2dlbmVy
aWMiIGVuZ2luZS4gSW4gdGhpcyBjYXNlIHdlIGNvbnRyb2wgRE1BIHRyYW5zZmVycw0KPiAgICB1
c2luZyB0aGUgcmVnaXN0ZXJzIG9mIHRoZSBOQU5EIGNvbnRyb2xsZXIgKG9yIGEgbmVhcmJ5IHJh
bmdlLCBpbg0KPiAgICB0aGlzIGNhc2UpLCB0aGUgc2FtZSBkcml2ZXIgaGFuZGxlcyBib3RoIHRo
ZSBOQU5EIGFuZCB0aGUgRE1BIHBhcnQuDQo+IA0KPiBZb3UgdXNlZCB0aGUgd29yZGluZyBTbGF2
ZSBETUEgKCMxKSwgYnV0IGl0IGZlZWxzIGxpa2UgeW91IGFyZSB0YWxraW5nIGFib3V0DQo+IHRo
ZSBvdGhlciAoIzIpLiBDYW4geW91IHBsZWFzZSBjb25maXJtIGluIHdoaWNoIGNhc2Ugd2UgYXJl
Pw0KPg0KDQpNeSBhcG9sb2dpZXMgZm9yIHRoZSBjb25mdXNpb24uDQpTbGF2ZSBETUEgdGVybWlu
b2xvZ3kgdXNlZCBpbiBjYWRlbmNlIG5hbmQgY29udHJvbGxlciBiaW5kaW5ncyBhbmQNCmRyaXZl
ciBpcyBpbmRlZWQgY29uZnVzaW5nLiAgDQoNClRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uIGl0IGlz
LCANCjEgLSBFeHRlcm5hbCBETUEgKEdlbmVyaWMgRE1BIGNvbnRyb2xsZXIpLg0KDQpOYW5kIGNv
bnRyb2xsZXIgSVAgZG8gbm90IGhhdmUgZW1iZWRkZWQgRE1BIGNvbnRyb2xsZXIgKDIgLSBwZXJp
cGhlcmFsIERNQSkuIA0KDQpGWVIsIGhvdyBleHRlcm5hbCBETUEgaXMgdXNlZC4gDQpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMy4xL3NvdXJjZS9kcml2ZXJzL210ZC9uYW5k
L3Jhdy9jYWRlbmNlLW5hbmQtY29udHJvbGxlci5jI0wxOTYyDQoNCiANCj4gPiBMaW51eCBEcml2
ZXI6LQ0KPiA+IERyaXZlciBjYW4gcmVhZCB0aGVzZSBzZG1hIHJlZ2lzdGVycyBkaXJlY3RseSBv
ciBpdCBjYW4gdXNlIHRoZSBETUEuDQo+ID4gRXhpc3RpbmcgZHJpdmVyIGNvZGUgaGFzIGhhcmRj
b2RlZCBoYXNfZG1hIHdpdGggYW4gYXNzdW1wdGlvbiB0aGF0IGFuDQo+ID4gZXh0ZXJuYWwgRE1B
IGlzIGFsd2F5cyB1c2VkIGFuZCByZWxpZXMgb24gRE1BIEFQSSBmb3IgZGF0YSB0cmFuc2Zlci4N
Cj4gDQo+IEkgYW0gc29ycnkgYnV0IERNQSBBUEkgZG9lcyBub3QgbWVhbiBtdWNoLiBUaGVyZSBh
cmUgMyBBUElzOg0KPiAtIGRtYS1tYXBwaW5nLCBmb3IgdGhlIGJ1ZmZlcnMgYW5kIHRoZSBjb2hl
cmVuY3kNCj4gLSBkbWFlbmdpbmUsIHVzZWQgaW4gY2FzZSAjMSBvbmx5LCB0byBkcml2ZSB0aGUg
ZXh0ZXJuYWwgRE1BIGNvbnRyb2xsZXJzDQo+IC0gZG1hLWJ1ZiB0byBzaGFyZSBidWZmZXJzIGJl
dHdlZW4gYXJlYXMgaW4gdGhlIGtlcm5lbCAob3V0IG9mIHNjb3BlKQ0KPiANCj4gPiBUaGFudCBp
cyB3aHkgaXQgcmVxdWlyZXMgdG8gdXNlIERNQSBjaGFubmVsIGZyb20gZG1hZW5naW5lLg0KPiAN
Cj4gSWYgSSB1bmRlcnN0YW5kIGl0IHJpZ2h0LCBubyA6LSkNCj4gDQo+IEVpdGhlciB5b3UgaGF2
ZSBhbiBleHRlcm5hbCBETUEgY29udHJvbGxlciAoIzIpIG9yIGFuIGludGVybmFsIG9uZSAoIzEp
IGJ1dCBpbg0KPiB0aGlzIHNlY29uZCBjYXNlIHRoZXJlIGlzIG5vIERNQSBjaGFubmVsIHJlcXVl
c3Qgbm9yIGFueSBlbmdpbmUtcmVsYXRlZA0KPiBBUEkuIE9mIGNvdXJzZSB5b3UgbmVlZCB0byB1
c2UgdGhlIGRtYS1tYXBwaW5nIEFQSSBmb3IgdGhlIGJ1ZmZlcnMuDQo+IA0KPiA+IEluIG15IHBy
ZXZpb3VzIHJlcGx5LCBJIHRyaWVkIHRvIGRlc2NyaWJlIHRoaXMgZHJpdmVyIHNjZW5hcmlvIGJ1
dCBtYXliZSBJDQo+IG1peGVkIHVwLg0KPiA+IGhhc19kbWE9MCwgaS5lLiBhY2Nlc3Npbmcgc2Rt
YSByZWdpc3RlciB3aXRob3V0IHVzaW5nIGRtYWVuZ2luZSBpcw0KPiA+IGFsc28gd29ya2luZy4N
Cj4gDQo+IEJ1dCBkbyB5b3UgaGF2ZSBhbiBleHRlcm5hbCBETUEgZW5naW5lIGluIHRoZSBlbmQ/
IE9yIGlzIGl0IHNwZWNpZmljIHRvIHRoZQ0KPiBOQU5EIGNvbnRyb2xsZXI/DQo+IA0KDQpZZXMg
SSBhbSB1c2luZyBleHRlcm5hbCBETUEgZW5naW5lLiANCg0KVGhhbmtzLA0KTmlyYXYNCg==

