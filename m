Return-Path: <stable+bounces-233238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJW2L/0w0Gke4gYAu9opvQ
	(envelope-from <stable+bounces-233238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:28:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116D3986F3
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F5AF3007BBA
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E253D47C4;
	Fri,  3 Apr 2026 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsnAlNj0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCA1D5AD4;
	Fri,  3 Apr 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251704; cv=fail; b=kuT2J74349jjoQrlBbn60ZOzvWr6/jNdMhofmMisMZUeAgRgw8NkR5zX7TYk7B2huomMwJP0bw9B+LFQ0+rTH6TASxNoi2TIEk6iLnEYcMO7oxCELjWW3VI429L0p1/qHXbHm9R/oLoTcxBQKzCkeOkuwFnMWl4wGeRNnV0+CvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251704; c=relaxed/simple;
	bh=eR6r2SGtFmt6akbPcKoUx0mkyC/aJD5gifSj2KGaCE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQhkt4Et83I/rqeNIHUD6DmJAnEPSg3c/GVpCYTh9G0Pd2JonEPG8hoYKyds7CRNrzMsXRycaCGnBck6vIZ4BpgP/88KsH4yBlcHd1Bqwi4uVle35kxc6d6k7t8sEVy0AD5d0q8iEeJ1dnQLslLmuFB4hx3zDFI4IsgW+wicYXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsnAlNj0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775251703; x=1806787703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eR6r2SGtFmt6akbPcKoUx0mkyC/aJD5gifSj2KGaCE8=;
  b=ZsnAlNj02W05TbmfMGVTYmGyBPRGjD1VseYd/+sUhwX0dXitaWo8GY9W
   S36XQYq8lm1bxFYkiLJ4sRDy3E+NgjPYx4Zo/ziBtXvqze45fuRv4xeeO
   l7UHwysZslDCKEP//7f0L1rJIyj7mPVE8ibK/gmwIUcKLjiI4sZRavunw
   YTcGIpIL44Qz0HUfplUp7u31JT2gayz9rDy7Z+TJ7L4NxgmPcHU9RIKcy
   avKDPU1OwV17Yx7N3jf9zRH4ydjTBPa3PDSwTEQtJfxGtPdS3UJuWAnLP
   MyiOEgOrRHXQLjmOM+tEYK1V+utIUlQfXuaGiN9gFCTUwZWkVjpbkR4QJ
   A==;
X-CSE-ConnectionGUID: R2rskhmpRJCEPxexUKb6sg==
X-CSE-MsgGUID: WtjiQS9jS8mD0npun7eAmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87702759"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87702759"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:28:22 -0700
X-CSE-ConnectionGUID: C1ermfr+RW+1ckaKE14uZA==
X-CSE-MsgGUID: mvyh1KB1SF2ZNCt2TKXouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="228977061"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:28:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:28:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 14:28:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emybBes4y/L0bSqaTU9v8E3wTtSdq/KMrKnCJRHtJaZ015hOR2sisAIaxdybBI4+MKALBY1xXFpu5znQDrcwtWUatPEbrBeKJOCjOLMzdLgS3eI+BpUg7OhmNzLtuutcuq6lGneA2oxuaY44YGfLnT3KI23RZ1llfLQBtwc6QhiJarbL7D7qxpYqu3/H5qFIxbd87vWFMGGiZ1la2CmI5I20s+BrQ3jY++BP+1txGiXgavJS4zKeuxuSQZeREF1bhVP3H/n1lmb0UzQQv59SMN4IRekDpoWHUy5Y80j3yxefiOtwJ38uyQnhR2sClMiOJU12N/7ZxsvC/73HjIijGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvJtboxWvskA5rNZCqqybhZsyQPmD7MhvJ7Lu+7M5lg=;
 b=Xb8GDrF2SXUBdpZEBjMN970fH1/zyhb1a/2v+q0xDjpmWoS7rgIij0mZVfiZf07GRAP2F0KoeAlnJunnHbId9gGnh++wRz1AOe2OlQ+MbnUF1SpSg/M4nQ2sGr8kj4Pa4QrqFUJ3tGOZlolFINYeWcexUayodhEct2eRGwAY+ClmScGoEbPuyjEZtXwCqVoz8juap6UPU0/lA3Q9iPr9MmmMniqY710vUTJDR1EETbWKbRhH36tiL0JmeBlLlCuSQmbkJnCFhKDlMms5j1DoNriSmNmPeT6FGq6lXRpm3S9TeMRuuvyJVczz7hi//+6XTHTRMIGsMEVSAayVBTbvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by IA1PR11MB9496.namprd11.prod.outlook.com (2603:10b6:208:5b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 21:28:19 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9769.015; Fri, 3 Apr 2026
 21:28:19 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	Eric Dumazet <edumazet@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix PTP timestamping
 broken by SyncE code on E825C
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix PTP timestamping
 broken by SyncE code on E825C
Thread-Index: AQHcvb3+6ZRlHGhhXEmAwzIFhvFohrXN5HHw
Date: Fri, 3 Apr 2026 21:28:18 +0000
Message-ID: <PH0PR11MB752296C0598EA04D4DED65A6A05EA@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260327074658.2963328-1-poros@redhat.com>
In-Reply-To: <20260327074658.2963328-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|IA1PR11MB9496:EE_
x-ms-office365-filtering-correlation-id: a8d16efe-55ff-48b2-dcbb-08de91c7ecc6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: FFW+oy/UDypqrMzUHSfaeC4DKeom1tq3aLHatwKGMVyk/t3y3Pl4c21X2/87Ou2sBTyZqq7dPLbGWUANJ7CcsXd/AMe25WGEVJGAhtTD/C/hJLPHW5CKhDsSZ2F7NM7sdcvw/SnL+5Bbs3iE9LEUJjaenQwCDpfhC/+r4RiYiUg+xEzGKvL6Snwsdh6Mc1Gs3gAdLcjRW4pf2y86lIetyrl/c62YZhyK/nckvI6rkfrvJXMhrL7b1PfagTzqUhvcnls8O4rArIT4EKrPktXKqBmANRoXa8r85jnLQKlmdQoc3hnlfGQdmNE2QV2UPVxmtgs5T6A8SSgWfgAdqj0bSaIVZ45CVFkPTAJOpRaaBaMsDSFgSnUTzhkw5y24LvfHu61M2EU4MuJ1i8YDGb11ORvjsUSQE8iKTC6/5sW1pfUeXW8yHFpCSCkz/NpXVBnwtx4sK4KuwFveSJKp4UHUnku8ke5iEukrTpPpPgG1vvRolhKN2rpbDfqS9R6FnSTwlGQKjU5uXxwuuKXPwZ5MQBrloVS0KDDW7jZtYmMDQwS1F8cYS6I1QGr1Iakywq2wJJo1ZeSoPpcr2VfWRrAcCTFAE5I2OeEbKVK82li4IfyEirtaGQO/+7fufvkmG0eJE32lB29PE4Nfn4d8ifEJCxMZ7XoCkkx2PvH7b6XNjpFAn8L+H/fvbK/J84rpoDkgPuOypgtxc3E0KtbkduwpFHiYT80k3KiBb2f/QjE+VQkmEPIGc2jyate818mALF5ajVcqYdgRyOXnh66vfZ5FNaL7/3SBul1csy9sLPvNfaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?btkOy0i0EMgUxgvimyOpVR9NDMiXQTv/lO/bxM7+v5GJZaZ6yWBISIsHk3KE?=
 =?us-ascii?Q?A3PGFw2nRGs54nsyz+FEHDfQsBdM6Nry/3DOxb1my30M3KDFLnbOM5rv+xr6?=
 =?us-ascii?Q?x5L8OTdu8IqMIP4lkxuSmZMFzYbMc5F9/59bc+OklqpuYPP1JjYohV+an0S6?=
 =?us-ascii?Q?be6K5AGXRyzQJ3dMpRELIdqvOsS5oZvYv84zEIstqL5fFR8kQdB+ztokpNWK?=
 =?us-ascii?Q?sa0R/yDpSflIWgsseAb8yGdD7yvz1dR0W3lFMyvPx5f4PR7De3qfbp/0cDwH?=
 =?us-ascii?Q?16Xa+AA99Tca1vw/AwgMZJ9EArhpRM9qCcUFaOvxMvljXzu1W0ipBf1Xv4yV?=
 =?us-ascii?Q?sEI/Gad9Hx0gHBD8Z+tiYLmrOrYy7NHmnq0yQP8K5LmQWl8i6ivG/T0RebcH?=
 =?us-ascii?Q?1vRpN/koGCe+kzDltM6CZAScvg2+38LdhqhP62ZwrilrfAOK5FjGYb9AzLvZ?=
 =?us-ascii?Q?goP9h3snnQg79iDAx8g1y3A+vuE3LEUQ5Fj3uKXI5IzPXKFe295U6Q5n1D7a?=
 =?us-ascii?Q?zDJ0+6RHp5h8wuF9adNbSY9NOdu68PRhKmTYOkJq9PIk5XxKD7GDv8dS0l9P?=
 =?us-ascii?Q?wAazrdBqCCPNpvNmx88nKXPH21i16J1OH/4xhI9fGnEfjX7KJFvRugfivyxF?=
 =?us-ascii?Q?1hhiXmerpELlDX0v6tqlh07jwkMZ4+Yv9FfvzNfWaDFY8hQBNnYkoqWJ97KN?=
 =?us-ascii?Q?wkwq+2BrDviIhMprQ1SwoYoiFY0FaOQgh2TSoWditIVmGtXlLYObSxVc/CMC?=
 =?us-ascii?Q?3Gr/a1UbzAhWsdt+Uxj/q+dpeDOzl3YDElNTX6kuymVj3Y/dQqDUL8cFFT1G?=
 =?us-ascii?Q?vD2rFV6BBGsWm8JNokVzZPFrU3pbz4uscPsh575KDY9N6aGCp+YS+FK6wTZz?=
 =?us-ascii?Q?w5A0KVeSa8l/SdP2oiQukkfPDt+MOXp0hgazREwbuEo0JS4SfV0pkm+Rs2xs?=
 =?us-ascii?Q?RgkBT7lNz+Mp1XIRNgs4lqvHakMNrsvGkjxuU0YLfGvIlSokANgur45NDh/h?=
 =?us-ascii?Q?AECvFGFRg0cz01jOFga6aRR5sEZDkQ1wBwumQSAAxDCKzs3FcIQT8QeVIwMo?=
 =?us-ascii?Q?iQV0ui1/8du2KxCbwXQc8bli4Aq392IlhPQg4Tf4OP3Si8XmpWCP3k0Xt/3Y?=
 =?us-ascii?Q?HoZEO6ZT5AvaLARG/SfAjIevTQRCgW+RP6LzpPUvA59yAhoMb7VwCoA6esiQ?=
 =?us-ascii?Q?cgDyKXhmsN1HBEHcTVh/XcfV7J7EdmEDWgQ5DMyFCi6Z8kf/u7HfFXZKKxv9?=
 =?us-ascii?Q?qa4CjrZslXO8VlpFo3xgqY3dxjOmDNsEKcWOTQmVtTuBn+hVzGH5/Tc9iRqX?=
 =?us-ascii?Q?SOzXc2aVECcV7jNyinXHaTRMiG11qKcJpAzUj3Hj2jIAlaUlbjjxfMJhNAbI?=
 =?us-ascii?Q?I62v1HMcjha5bbkdev8UFL+QDsDFRU+Y7mwd/J4IlRo4oGHqXMJJXE4QuazQ?=
 =?us-ascii?Q?onqa8uzGBMMZo9fBoTib7x3/uJLyq3kpPe4z7rPWgjnZRxzfoGIFteaXM6zL?=
 =?us-ascii?Q?HdsslGJOrEcOUYhL1RLmmFjBwJUyR9W1lrD4z3u6CRZAMwqfYzBmh9CRS3U5?=
 =?us-ascii?Q?kaeTSfvJu+lxP18bXzUMUd+uH8ZNN2vegC/S9m2jSpXn+JXSeJguOktoJdeH?=
 =?us-ascii?Q?oeX3iMaXlBMODGDsLK40lAnnoEo0wL6WV0nh30oAkF0v/X/F+eTvmGVp/zch?=
 =?us-ascii?Q?RhXiFjezf4/8UndRHgVPRufdY1iecemIsTKY1JKJkwHjqkQSvsKyakfzQTAg?=
 =?us-ascii?Q?0co8a3StNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fvO5x6bndBnPP4nWhtW6FlJAJ+TkmpE+QpsAM5F47OPFo0IriusTOTJgvPJuipYucZW7b4TBeR2oGlBpPNpsVO4hahKkpYOxE+kxN2HMgdzS7cxtpqgtkY79B7dH/lB/3k/7Hj7vaYs6Fm/8n6tj6rD5NcN2sG/U2lwONOg+q/OOtD5CCEtnzOdHUF+YfsmB8qUkOZzTkK6dzfJBYp/UwVjAtjBGpzJgLFcf0l3BlCI49keyy7yGDtM7N1mKoYI9XR1UbivBCPPqHF+c/7Y3xTuRoD1UhU5f3OhkCzrf8W4FA2KyjwkT/UGHkUiegEDRGKT1mlGmsDo88tMCKNkuAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d16efe-55ff-48b2-dcbb-08de91c7ecc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 21:28:19.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im/zlkY9kGoPdmE50g4/6vaM4W3u72nySZH0+D9eZsEytk+bEGrKKhZlWR3WunDrXGAGRgpeeUkUbDjGFHql1X+aWTv61zEGD7Hs4ADiLRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9496
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233238-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,gmail.com,google.com,vger.kernel.org,lunn.ch,lists.osuosl.org,kernel.org,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB7522.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6116D3986F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Friday, March 27, 2026 12:47 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Kitszel, Przemyslaw <przemyslaw.ki=
tszel@intel.com>; Richard Cochran <richardcochran@gmail.com>; Eric Dumazet =
<edumazet@google.com>; > stable@vger.kernel.org; Kubalewski, Arkadiusz <ark=
adiusz.kubalewski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@int=
el.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.=
nguyen@intel.com>; intel-wired-lan@lists.osuosl.org; Jakub Kicinski <kuba@k=
ernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemlo=
ft.net>; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix PTP timestamping brok=
en by SyncE code on E825C
>
> The E825C SyncE support added in commit ad1df4f2d591 ("ice: dpll:
> Support E825-C SyncE and dynamic pin discovery") introduced a SyncE
> reconfiguration block in ice_ptp_link_change() that prevents
> ice_ptp_port_phy_restart() from being called in several error paths.
> Without the PHY restart, PTP timestamps stop working after any link
> change event.
>
> There are three ways the PHY restart gets blocked:=20
>
> 1. When DPLL initialization fails (e.g. missing ACPI firmware node
>    properties), ICE_FLAG_DPLL is not set and the function returns early
 >   before reaching the PHY restart.
>
> 2. When ice_tspll_bypass_mux_active_e825c() fails to read the CGU
>   register, WARN_ON_ONCE fires and the function returns early.
>
>3. When ice_tspll_cfg_synce_ethdiv_e825c() fails to configure the
>   clock divider for an active pin, same early return.
>
>SyncE and PTP are independent features. SyncE reconfiguration failures
>must not prevent the PTP PHY restart that is essential for timestamp
>recovery after link changes.
>
>Fix by making the entire SyncE block conditional on ICE_FLAG_DPLL
>without an early return, and replacing the WARN_ON_ONCE + return error
>handling inside the loop with dev_err_once + break. The function always
>proceeds to ice_ptp_port_phy_restart() regardless of SyncE errors.
>
>Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin disc=
overy")
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_ptp.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

