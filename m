Return-Path: <stable+bounces-235911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALq3Bm+Q3GkmTAkAu9opvQ
	(envelope-from <stable+bounces-235911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E60E3E7DA6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C632B3013A73
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B16E1CEADB;
	Mon, 13 Apr 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsxFzSRf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5837F8D1;
	Mon, 13 Apr 2026 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062556; cv=fail; b=gRtL7vUIRZuTEg8K1hWhqOKyxsoNebVrZgVRtrN+pnBjl3EgSG3kdYrYD1Af+/ofLc63wlaUviPzTOqPkVQh4TpQr1YEM0CIXfLylHEm9p3+z/eSAN9OtP03T4Dwt4YvHOsmYj3SXGi2jTErF+kLvB8rjIRTWUFYmsBOpY6gk0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062556; c=relaxed/simple;
	bh=3S3SiQXrwxl6FNKU3mO8arIIcZvMGbvx2gQUzYabLwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIKj0zlb+d8dxPAt1rfa/ZtGxXl/2gQIYzGphe6mSPWKEULgcmFRiS5o8AxFZdT5fyqRdfiV2sTXC9axEchKS27crLNNopKnIsCq+cD5qBT5yGi87SLnbhfbcpPbHZUWF2a5QfQ7Pw2pdDzo5QV2qaH0ikn66OrW6OMgaAcQypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsxFzSRf; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776062555; x=1807598555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3S3SiQXrwxl6FNKU3mO8arIIcZvMGbvx2gQUzYabLwc=;
  b=SsxFzSRfnDCYYii1J5WkdmklhVROqz8Dy/H3ER8CYOMpPbOloMZ9uAnJ
   k1AvxyT968Xfd5QtVrPowqvV7pO2PJmHKdAJ5r3cm/ZoonSVc9HprCmaZ
   1DrpYt67wLgMs0K91gbIcQubUcrD8hBJDHeGXbHJ2SXYQsxiYiOkzGOnU
   2X5g0i/eX88zXJSQKZs5su1o7845XdJ0cX5QrMr0GLi/HUeFFp13qY0Wg
   ce1IbzQM1PKe0ZxMpj8bhQ0u16rq5S/uqrQjGbsr4lpVkwtUhzM7wbD5X
   oJEzv4eDQYb5yPj+z8QGzMgq1jPll/70hxVYy7BSJtycUTczrc5onRSw9
   w==;
X-CSE-ConnectionGUID: EnDOdINwT3+cMiH8FgcGfw==
X-CSE-MsgGUID: +I0XldmeR1uF1dYSRZgB2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="99633756"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="99633756"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:42:34 -0700
X-CSE-ConnectionGUID: zlZLxsJmRra2ghoyjHxi9g==
X-CSE-MsgGUID: FoSVOkvqT2qW+e5eKHYspQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="224967767"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:42:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:42:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 23:42:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM+PsubkockcaydxrEem8d58s5vavdqPYcTAzFKgmkcoYqWjOOuQUZUqOsLg3880B3vnoQESzW5fks9SPzci0PZos4ZP5Ar2IeWYIv4OweIbFFvnlnFrrefcI443Ap475lGlkukY/nNVbfrjXHSGBTd382/SUeis7Mc9bIhHGmNs+AIbOH9I6oAu7/JMRUTL3gA88bMVsrLPxu+MMExLAi+PBolqHNSF/S7W/hlqFe2vvR11nyOrw39keUbvbXGY4fA4AF4kT+WQPn5vbh8p4ZPs9lWK4Ga7n1NzwV0P2IFC0DGGwhfN91fWicSxhgeAe0dEOP8/hd018Ec9UzuQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S3SiQXrwxl6FNKU3mO8arIIcZvMGbvx2gQUzYabLwc=;
 b=JpFPNcrmWSQemnbr8oYCIOJXwlEVVZyjydPOdT/J9nyH8/rIDYaAljWMTKYPgW6s8MWJ+vshFJYZBVWCGhAfb3jdZqWNhgYb+K/RbGGmmFW1qJDwevkqZB8oQ6G0bwLbuuVvjMve0Vht7mlnYun0vxCiAT0CEcMxcr124EvazIEnRC9UtqJtQzSVN8m2dGcVd7rRIi0lnvlQc+C+SR/g4RVPqPefRruXwS0+tHgpzjsYDXGHZHjHZizipJjCvO2xWQCJhLps1WQy5YXeAmewYDfKh4njb8GvnH3lT8hOm2VqauMucMvXrvs7n3r++ugGyDV+KJMUsUh1/+vVQ2a69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA4PR11MB8889.namprd11.prod.outlook.com (2603:10b6:208:565::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 13 Apr
 2026 06:42:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:42:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Winiarski, Michal" <michal.winiarski@intel.com>, Alex Williamson
	<alex@shazbot.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] vfio/xe: Reorganize the init to decouple migration
 from reset
Thread-Topic: [PATCH v2 1/2] vfio/xe: Reorganize the init to decouple
 migration from reset
Thread-Index: AQHcyTx4uluqdsFOYEqGKDyP96DrFrXcjrjg
Date: Mon, 13 Apr 2026 06:42:21 +0000
Message-ID: <BN9PR11MB52761CABB57D566F983BA21E8C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260410224948.900550-1-michal.winiarski@intel.com>
In-Reply-To: <20260410224948.900550-1-michal.winiarski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA4PR11MB8889:EE_
x-ms-office365-filtering-correlation-id: 00152285-52ab-4c2d-a6bc-08de9927d0bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LFfb+QMudE9otI0KuSo1npkRcD0Irz75FoRMrCIJuZvKgZBLj2IhdZRBG9riTNPfEQCeStEH7TVzzXuzNUdyEzuyvLsuKwifGXx/YFp5QQArdj+76tQIZKBhliQsqQU5WYjxNaAHNo4nQHvu5BGaG7efpWPfjPSWyExOhdwsbAJLvO2Q4zHBjGGZ6BTgHgTobOTRoEhHR7KQurTgZuGeNapEKUQ+xNFWF3nLn3agYf6L8vPbV3r37u2R/5dXmhX2CvsqMZFHYtHS0CIoydjiStLO+9kotfcrKTuTAAhCTfMGx4Rup6qoAFo33yPfSM7ELZrkISxbr1IbZkpbVfkkxmsDe6omSUZlantd9e4Dv0vAZNB8Twp8Sd49KrxCs9YZMG6WVSQD5e2q17IjwhWGY9+r5mBAWy3sbS3NPt3iurSO34Puphuqz0wXX2a6D5DAIja2AAi9nRwqXHQmO2+WEnFWDZXIODpDaoeoNh6IOhymxbAfGUegxXkKDQgPwXNgWVTrQXjfux7xT8hAjH/N1bWTwwfj1jISEBpHoCTmD62KOUqqoOxClmNi38AEoVoLopGeLL+M/U58NW8lZnFSMFNz9uQZxam/r+sA0maKNJW2j8j0UEJliEEsJHVKKeBCF6LbsYLBgfNKSHkLTBYvuPg5WroCXZIVIwsigyoNgCw3DHBvm2FvIHXWjvaaT/bklxAPx9k9pYwQrkqszGNgSJmtnHwBv6kGeHPebvRr/61Mz4V5tc8JohWGlX49DLh0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFlWFhNMDI5U2k3bGc2L09nNGVLK2lhblJzVlNxSkZBRHp1NCs5aExHaUFU?=
 =?utf-8?B?S25vTmtOOVlHN2E4ZDk0S0lBWUZJYm91VGUyTXpJeVQ5OE5mcitUQ2ljeU5w?=
 =?utf-8?B?bnhPdFE4a1dOUjFzRDR0L2NVQytYeUhFOU05Z2tQajBySGMyZk9EbndpaGtC?=
 =?utf-8?B?S25XWUlwMHdkdXp0MnFIZjJYeFVmSkJHeUVLbDI4Tm83Q0F1UjFkRXJsWUZR?=
 =?utf-8?B?VHNNL1FXZVowNmFUbUt1dXdWbCtZd0pjbzI3ZFdPRDF1S3NpZnAyWkl3Z0pF?=
 =?utf-8?B?L2RYUUpQUC9JL3RjU3ZpZzJvY0JFVkRqZzRtWlhrREFJTUx0Z1RRejZPVkky?=
 =?utf-8?B?VTdZb2VYRVJJanYwQ0NBU0FLbUtld0VncWZRR1pCV2pqazJ6UjFOTWkxRmMw?=
 =?utf-8?B?RUNhMnNqT1NpZFkzQmVqdDZKelEvcTgyUkxXaGRPMG15S0wzaDRWclgyVSs0?=
 =?utf-8?B?bXFZNHJaMDd6cEFSMHl3ZktKNlpQcHJrTlZrb25IbVZ2MXI0bU8yWUZpWWhK?=
 =?utf-8?B?T1FCUDNuaXBsMGFxK3pzcE5ZZnIrcnVhcHQ2MlhTOUdzUExOb01WM2ZkMFdZ?=
 =?utf-8?B?L1Y4TE5uYllEbHJZSXBoT3U4NHp2RS84TjdXeENlNHJaNE5pbXVXLzNDMGVM?=
 =?utf-8?B?MFZRMk1POWZ2UUc4Zi9aY2IxVWlTSkhGekhGNEFmUHZldHh1eHFrRlZWcHVM?=
 =?utf-8?B?WFdqcXF3a1JuUlRKM2xmaDVIV0xTejlIT3NrQVFNM3pWcnBlTlgvVXJlam5E?=
 =?utf-8?B?dlVGb1JiMHAvTUYyMkpSa2VlOG5yV3Z0dEs4K2Rpb2pFNk5oMzdIS0hJSVJn?=
 =?utf-8?B?ZEdrK0Y0encyQ2syQ1FZV2I5R2hPMVhmOERrUGVPWmltM0RCVC92NW56Slox?=
 =?utf-8?B?WERPY1gwSlFSU3g0OWpEWGQ2YUNnL3ZmNENFNVNkVDJvWUxFYzhWR2hPNVlu?=
 =?utf-8?B?M1g2dERybExWZElBODBVYVpsQXQvZmhvNGpFRmxGUno1dDZhRHIxSnZJNkZ6?=
 =?utf-8?B?TFNjU0M0TFkyWDNlR1J5UUE5eC9EWkZUU1hUWlFyNC9jeDhVSW1QajEwSWdB?=
 =?utf-8?B?cG5qb2J5cWU5ZGNJcFFZRnhyMVFiU1VzM0t6dU4vdnh4U2NPODBEWVpCVUlU?=
 =?utf-8?B?QnljWlYyY2w1OEFObk5ObktkRklJRzVyN1BOV1owc0dhSnZmZDljdmhFVG9J?=
 =?utf-8?B?eFkrMDE0NlZubkFhbU1ycUI3ZGozQVpYNHNoUWs1RUc2SkNyejBBUEVGdEto?=
 =?utf-8?B?WVljclNsUVZyTXJOaTdhTWt1V3R5cFoxaVBON3o4MEJ2WjU3RGdubi80NVFF?=
 =?utf-8?B?RXNidXlkSkNGd3hQbkt5SmQ0Sjg0b2lJOVZJc3JnTzZZNHgzcUt0ZjFJaTBO?=
 =?utf-8?B?R1JicEp2SUQxbml4MWlQTHJjb3cxR242Y1Z6VzhWMVBBWXBkZXpsUTArQVVI?=
 =?utf-8?B?a2dnV1lpUjVSbGE0b0o3ajNJa1VZTDdLY1VtbTVwUkViSElTdkJuZ29hZXRI?=
 =?utf-8?B?VGs5bFRRem9EODFPZGZha3REWVY0a1hlc2p2ZVF6aWx6c2dPSjFVcnJBKy82?=
 =?utf-8?B?S3NZeGVnL1gzUzBMQ3h3VGtBc21xSEVLUzY3bGVyUGZMTHBvVUIyR1ZGRDRZ?=
 =?utf-8?B?MHpCZ0dvbW93UVVacTFOajFkbWdwQ3pLWFl6bHFYalFSTUNLVWhhL2ExTm5I?=
 =?utf-8?B?OFBiT2VvMzgzQlZzWTJQL2RGMkNPbmU2TUZyMzF4QklTZ1A3cCtrM080MmZL?=
 =?utf-8?B?eWgxOGJCSjl2NG1MamxYcXFTNnJjT0FEdFhUbXlUU2ZmSkY3czVpakZaN2o4?=
 =?utf-8?B?LzBrNHNuVGY4NXFDc0NGM3VHQXhTK2RvVU96SEFsaUdUMnFyd3ZobTFIb1U5?=
 =?utf-8?B?dE94UytFSTlQL0VxamMyRFFTM1JKUWlKY01VZVNPUFU0SXk5YVdqdjF0Nmg2?=
 =?utf-8?B?Q0YyTi9BNWVVRkpJRXFrd0xPa0VhRmNvR2VXM0lPeTVLZWdlcnFIRWhINEh4?=
 =?utf-8?B?Z0cxR3VOVjhrdVFQd2psTGtxcU9pK2tPd05Ba1E0Y0dzYjlJa09aR1Y4SFhR?=
 =?utf-8?B?QlN3aVBRM1FMdE4xMUpkZ0lKelhRcHFQc1N4ejZjMnVSREpLL3JlL2dTc3Ev?=
 =?utf-8?B?WTJmNFBrMmtubi9DOEd0TkhJTnJZSzNwUUNQaVhhd240eFk4K3FwODZaQ3M5?=
 =?utf-8?B?Znc4dHFrTUF0UXdnSUlVZDlmcTcxNHg4Z2duYTB1ZFhGWWZFZ0ZlTFVQQnE1?=
 =?utf-8?B?elZNMkU3SnVJUnl1V2drbmdsSFU1aHVDZmNRSVZ4M2hvM2UxKzRwb1NiV0tH?=
 =?utf-8?Q?aQdTyfTUKVhAFFu3Qv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mBbz1yndwNGDLiiEcao4Oy8JaOGbpzO9t0fYg0d30HLkXNQ4fi47LuV2sH3FNjN6gp4Q9WYJrFEMzNp5Jonblk8+8ItJNyCoctKiwrl6RlmE1jkh0xQVPjvR4t3a/sf3rLp0dF3/1D+LbzAUrWtq9IN6t9lumqm3zcgkjyj6VtDmS55Rzldu4JNCfssNO3TgUOzkDyRfHP0VzDxrhWE1lGvMO1YdMm6WbGW+ZFgM3fO3LxtZETi/FII6IxFfszE+XCRYhmBz9mFcXURf13d12F7075SX2dd4uqvYwolxlHAiE1v+OFNa9xLHQqbiMlId5fco4Ap/aIty4gPBfH1RoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00152285-52ab-4c2d-a6bc-08de9927d0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:42:21.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbe5i+sVqZU5xFgfvJdVpOJk8W5JBhLn4xWwTDqTVwsqzYvLr6eeWWYID3SmXBF95eC95zLwV2q6pawFW/AX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8889
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BN9PR11MB5276.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,gitlab.freedesktop.org:url];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7E60E3E7DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBGcm9tOiBXaW5pYXJza2ksIE1pY2hhbCA8bWljaGFsLndpbmlhcnNraUBpbnRlbC5jb20+DQo+
IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxMSwgMjAyNiA2OjUwIEFNDQo+IA0KPiBBdHRlbXB0aW5n
IHRvIGlzc3VlIHJlc2V0IG9uIFZGIGRldmljZXMgdGhhdCBkb24ndCBzdXBwb3J0IG1pZ3JhdGlv
bg0KPiBsZWFkcyB0byB0aGUgZm9sbG93aW5nOg0KPiANCj4gICBCVUc6IHVuYWJsZSB0byBoYW5k
bGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzczogMDAwMDAwMDAwMDAwMTFmOA0KPiAgICNQRjogc3Vw
ZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiAgICNQRjogZXJyb3JfY29kZSgw
eDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiAgIFBHRCAwIFA0RCAwDQo+ICAgT29wczogT29w
czogMDAwMCBbIzFdIFNNUCBOT1BUSQ0KPiAgIENQVTogMiBVSUQ6IDAgUElEOiA3NDQzIENvbW06
IHhlX3NyaW92X2ZsciBUYWludGVkOiBHIFMgICBVICAgICAgICAgICAgICA3LjAuMC1yYzEtDQo+
IGxnY2kteGUteGUtNDU4OC1jZWM0M2Q1YzI2OTZhZjIxOS1ub2RlYnVnKyAjMSBQUkVFTVBUKGxh
enkpDQo+ICAgVGFpbnRlZDogW1NdPUNQVV9PVVRfT0ZfU1BFQywgW1VdPVVTRVINCj4gICBIYXJk
d2FyZSBuYW1lOiBJbnRlbCBDb3Jwb3JhdGlvbiBBbGRlciBMYWtlIENsaWVudCBQbGF0Zm9ybS9B
bGRlckxha2UtUA0KPiBERFI0IFJWUCwgQklPUyBSUExQRldJMS5SMDAuNDAzNS5BMDAuMjMwMTIw
MDcyMyAwMS8yMC8yMDIzDQo+ICAgUklQOiAwMDEwOnhlX3NyaW92X3ZmaW9fd2FpdF9mbHJfZG9u
ZSsweGMvMHg4MCBbeGVdDQo+ICAgQ29kZTogZmYgYzMgY2MgY2MgY2MgY2MgMGYgMWYgODQgMDAg
MDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTANCj4gOTAgOTAgOTAg
OTAgOTAgMGYgMWYgNDQgMDAgMDAgNTUgNDggODkgZTUgNDEgNTQgNTMgPDgzPiBiZiBmOCAxMSAw
MCAwMCAwMiA3NSA2MQ0KPiA0MSA4OSBmNCA4NSBmNiA3NCA1MiA0OCA4YiA0NyAwOCA0OCA4OQ0K
PiAgIFJTUDogMDAxODpmZmZmYzkwMDBmN2MzOWI4IEVGTEFHUzogMDAwMTAyMDINCj4gICBSQVg6
IGZmZmZmZmZmYTA0ZDg2NjAgUkJYOiBmZmZmODg4MTNlM2U0MDAwIFJDWDogMDAwMDAwMDAwMDAw
MDAwMA0KPiAgIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJ
OiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgUkJQOiBmZmZmYzkwMDBmN2MzOWM4IFIwODogMDAwMDAw
MDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANCj4gICBSMTA6IDAwMDAwMDAwMDAwMDAw
MDAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjg4ODEwMWE0ODgwMA0KPiAgIFIxMzog
ZmZmZjg4ODEzZTNlNDE1MCBSMTQ6IGZmZmY4ODgxMzBkMGQwMDggUjE1OiBmZmZmODg4MTNlM2U0
MGQwDQo+ICAgRlM6ICAwMDAwNzg3N2QzZDBkOTQwKDAwMDApIEdTOmZmZmY4ODg5MGI2ZDMwMDAo
MDAwMCkNCj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiAgIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gICBDUjI6IDAwMDAwMDAwMDAwMDExZjgg
Q1IzOiAwMDAwMDAwMTVhNzYyMDAwIENSNDogMDAwMDAwMDAwMGY1MmVmMA0KPiAgIFBLUlU6IDU1
NTU1NTU0DQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgPFRBU0s+DQo+ICAgIHhlX3ZmaW9fcGNpX3Jl
c2V0X2RvbmUrMHg0OS8weDEyMCBbeGVfdmZpb19wY2ldDQo+ICAgIHBjaV9kZXZfcmVzdG9yZSsw
eDNiLzB4ODANCj4gICAgcGNpX3Jlc2V0X2Z1bmN0aW9uKzB4MTA5LzB4MTQwDQo+ICAgIHJlc2V0
X3N0b3JlKzB4NWMvMHhiMA0KPiAgICBkZXZfYXR0cl9zdG9yZSsweDE3LzB4NDANCj4gICAgc3lz
ZnNfa2Zfd3JpdGUrMHg3Mi8weDkwDQo+ICAgIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDE2MS8w
eDFmMA0KPiAgICB2ZnNfd3JpdGUrMHgyNjEvMHg0NDANCj4gICAga3N5c193cml0ZSsweDY5LzB4
ZjANCj4gICAgX194NjRfc3lzX3dyaXRlKzB4MTkvMHgzMA0KPiAgICB4NjRfc3lzX2NhbGwrMHgy
NTkvMHgyNmUwDQo+ICAgIGRvX3N5c2NhbGxfNjQrMHhjYi8weDE1MDANCj4gICAgPyBfX2ZwdXQr
MHgxYTIvMHgyZDANCj4gICAgPyBmcHV0X2Nsb3NlX3N5bmMrMHgzZC8weGEwDQo+ICAgID8gX194
NjRfc3lzX2Nsb3NlKzB4M2UvMHg5MA0KPiAgICA/IHg2NF9zeXNfY2FsbCsweDFiN2MvMHgyNmUw
DQo+ICAgID8gZG9fc3lzY2FsbF82NCsweDEwOS8weDE1MDANCj4gICAgPyBfX3Rhc2tfcGlkX25y
X25zKzB4NjgvMHgxMDANCj4gICAgPyBfX2RvX3N5c19nZXRwaWQrMHgxZC8weDMwDQo+ICAgID8g
eDY0X3N5c19jYWxsKzB4MTBiNS8weDI2ZTANCj4gICAgPyBkb19zeXNjYWxsXzY0KzB4MTA5LzB4
MTUwMA0KPiAgICA/IHB1dG5hbWUrMHg0MS8weDkwDQo+ICAgID8gZG9fZmFjY2Vzc2F0KzB4MWU4
LzB4MzAwDQo+ICAgID8gX194NjRfc3lzX2FjY2VzcysweDFjLzB4MzANCj4gICAgPyB4NjRfc3lz
X2NhbGwrMHgxODIyLzB4MjZlMA0KPiAgICA/IGRvX3N5c2NhbGxfNjQrMHgxMDkvMHgxNTAwDQo+
ICAgID8gdGlja19wcm9ncmFtX2V2ZW50KzB4NDMvMHhhMA0KPiAgICA/IGhydGltZXJfaW50ZXJy
dXB0KzB4MTI2LzB4MjYwDQo+ICAgID8gaXJxZW50cnlfZXhpdCsweGIyLzB4NzEwDQo+ICAgIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gICBSSVA6IDAwMzM6MHg3
ODc3ZDVmMWM1YTQNCj4gICBDb2RlOiBjNyAwMCAxNiAwMCAwMCAwMCBiOCBmZiBmZiBmZiBmZiBj
MyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBmMyAwZiAxZQ0KPiBmYSA4MCAzZCBhNSBl
YSAwZSAwMCAwMCA3NCAxMyBiOCAwMSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAwIGYwIGZmIGZm
IDc3IDU0IGMzDQo+IDBmIDFmIDAwIDU1IDQ4IDg5IGU1IDQ4IDgzIGVjIDIwIDQ4IDg5DQo+ICAg
UlNQOiAwMDJiOjAwMDA3ZmZmNDhlNWY5MDggRUZMQUdTOiAwMDAwMDIwMiBPUklHX1JBWDoNCj4g
MDAwMDAwMDAwMDAwMDAwMQ0KPiAgIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAw
MDAwMDAwMDAgUkNYOiAwMDAwNzg3N2Q1ZjFjNWE0DQo+ICAgUkRYOiAwMDAwMDAwMDAwMDAwMDAx
IFJTSTogMDAwMDc4NzdkNjIxYjBjOSBSREk6IDAwMDAwMDAwMDAwMDAwMDkNCj4gICBSQlA6IDAw
MDAwMDAwMDAwMDAwMDEgUjA4OiAwMDAwNWZiNDkxMTNiMDEwIFIwOTogMDAwMDAwMDAwMDAwMDAw
Nw0KPiAgIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyMDIgUjEyOiAw
MDAwNzg3N2Q2MjFiMGM5DQo+ICAgUjEzOiAwMDAwMDAwMDAwMDAwMDA5IFIxNDogMDAwMDdmZmY0
OGU1ZmFjMCBSMTU6IDAwMDA3ZmZmNDhlNWZhYzANCj4gICAgPC9UQVNLPg0KPiANCj4gVGhpcyBp
cyBjYXVzZWQgYnkgdGhlIGZhY3QgdGhhdCBzb21lIG9mIHRoZSB4ZV92ZmlvX3BjaV9jb3JlX2Rl
dmljZQ0KPiBtZW1iZXJzIG5lZWRlZCBmb3IgaGFuZGxpbmcgcmVzZXQgYXJlIG9ubHkgaW5pdGlh
bGl6ZWQgYXMgcGFydCBvZg0KPiBtaWdyYXRpb24gaW5pdC4NCj4gDQo+IEZpeCB0aGUgcHJvYmxl
bSBieSByZW9yZ2FuaXppbmcgdGhlIGNvZGUgdG8gZGVjb3VwbGUgVkYgaW5pdCBmcm9tDQo+IG1p
Z3JhdGlvbiBpbml0Lg0KPiANCj4gRml4ZXM6IDFmNTU1NmVjOGI5ZWYgKCJ2ZmlvL3hlOiBBZGQg
ZGV2aWNlIHNwZWNpZmljIHZmaW9fcGNpIGRyaXZlciB2YXJpYW50IGZvcg0KPiBJbnRlbCBncmFw
aGljcyIpDQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9r
ZXJuZWwvLS93b3JrX2l0ZW1zLzczNTINCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogTWljaGHFgiBXaW5pYXJza2kgPG1pY2hhbC53aW5pYXJza2lAaW50ZWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=

