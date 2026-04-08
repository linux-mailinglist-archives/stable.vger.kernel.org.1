Return-Path: <stable+bounces-233956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4APgCVqS1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:37:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F1E3BFAC1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 048E03051941
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024C3D6462;
	Wed,  8 Apr 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XucC2aAP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B643D9054
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669678; cv=fail; b=dvoERjh9nKk5WeIezP4V+e+9qlnq4xqM6by1tFKf2sF9pJgNhxG8jUYW+6MEByqCNRmamW06ZmPIFjBe0/FhlpmdaNyuxxFfL/y/LZ/CtbE8gCOARztzgmJB6wPJC7kzamzpkgeTASlPJvsV1NWTgT71YDEbJHvGpT7uIEgxB38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669678; c=relaxed/simple;
	bh=jSfaazvq7KpLAXgHs5XeiXVBCdvGUlWOOTq08D4hYME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZ53Pq2vz2Di9CuiiSFqlC1NBbvYXmNYCR+IVVPC6Ke9OQ+KS8Id6AnRJCEkLwq8c7w0UKA97LiXpJ8RZAYDiWVu5Ym2DQv8LnDgQGEnRXhvROiU/BjDyZ+lgIOhgyoi5bgWJP718xt5vTlpr7jnORBqtSo68E7NJFOJOhiEZ84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XucC2aAP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775669676; x=1807205676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jSfaazvq7KpLAXgHs5XeiXVBCdvGUlWOOTq08D4hYME=;
  b=XucC2aAPReRe0I44m8z+b9BQrxaLDYNFDyL8eeFgw7EMS9ecjNKJXyZh
   vfedW+IQqNWyB5yO3/1r3omgdz0FPg5QmxPp+AoO2dDer7/FPG9GrcO4Q
   MfWCD3KM+YxWROrH1tL+hF3OKWpc18NkgzgZhB0HXOVHI9IGtwX7gWkaI
   xeUfz2MwCcdayu2Ow86u5Vz8QYPundWhANtHUFCIqXZ69W7yEoyAw6/QG
   y/52aT6nkopo/HqQsDiyOQeezLVc5WibDJF3o4+tvfYQ7NUPrhldSZe0E
   d4TxXJUpJ+wPHcFEgNgPzaHBq3BNtoGFtLgRVUpRtL4JiLF8yPPYD+65C
   g==;
X-CSE-ConnectionGUID: CSioXKbTT+2SluYM2clIqw==
X-CSE-MsgGUID: BOqBJFdIQ96yTUptwaI8lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87738539"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87738539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:34:35 -0700
X-CSE-ConnectionGUID: 8wbY+QfTR2yECP82+czx3Q==
X-CSE-MsgGUID: 5qTI5YtVS8q3qVqqEBWIiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228467601"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:34:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:34:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 10:34:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeD4LtIghGAcNMr5xkqq4cpPDFVkNFaeFWOBYxzhTzE1s5WMKmm5WL0QjVHaBJVwGstQnr97EMh4P/vNHh+mRVOfmM53r6ZtxZqGpxgbntn7uMlWbSLxoaXW0ynDIAal1/HgXNvDOqrZTiP5nfRiLXiiJXnlnCGsgleii3xPj6CWvt4wCN60L0rhIoQSHLKgXph1NpHYYpM2KzI5xtuXUZMaTvAv7uzLW5tVgQt5pkvuQtxFVDqPTEwHE5IlsqwRWEweiEFNCRXJSfcqmn9jXzdinNmLkNZbzd4Pz8xug08lI/kg75+Wo05M73vJUIRh917foR7Y5ZnAaTt4LxDXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sIFTRrlJzsdCOQRnfjC9ous03kw57kOkXHTRAmwYeo=;
 b=ErYQKwWfMFGU2QAnOG1diP5EFaQxHo/vNdQbshr4URcXFdipHRE5Qg8xW9t2w8iWSa7O/Z0NKh7Zwlq3bUMwAfwk3Bnyjdt4lpW7IFRLyPAu6Joq0HLfffLEnzN0FE/Yzqc0c5DaHUZVPg84mM9hp8qH08eDNIRjHqujs+D/cLl5IF1om4N6+PIXuswMou8s9DmuE/gvGoAT6kCwmY6I2OxKbTFWdefJlclx1afqmZsdNQGMxKyBsjvI9+9gxDEwCNBzZYXWICj6Adm1+BI4EkF6D39PdxRE8nHOqx7oaxYb955UYF2FuRfYeURIgdZ10lYNVn+gQMHHZKf3ns6j3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 17:34:28 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 17:34:28 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 4/4] drm/xe: Fix dma-buf attachment leak in
 xe_gem_prime_import()
Thread-Topic: [PATCH 4/4] drm/xe: Fix dma-buf attachment leak in
 xe_gem_prime_import()
Thread-Index: AQHcxswFXBkYjSPn8UeDOLB0BTaZK7XUnNUAgADP0QA=
Date: Wed, 8 Apr 2026 17:34:28 +0000
Message-ID: <DM4PR11MB5456628E393BC1D7A9BFA59CEA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-5-shuicheng.lin@intel.com>
 <adXh7FdAxseknVxX@gsse-cloud1.jf.intel.com>
In-Reply-To: <adXh7FdAxseknVxX@gsse-cloud1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 07369ab6-dfe2-4de1-64c3-08de959515bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: W+Q0Xey6W8YjCEWECUFj03Lex9N5O63j3GWP5XL8DBprbPGv2+pXfTfwRIDu6CuTabW1sgcAhSZSUEbhxp8V3T9MGP1pjr51Qtwhz/RMFgWizraTki/It+MsJDMcyAKGcV+PsWuJ8Y3H8bcyT3c+SX+JlnUcVWOclpVYVlSjMyTnGYk03neav7647mqOgIkDuWpDZjheGbnMK3DqdfheUxK1VE7CZgDm3mcX5nU3Q8+zwpwvE/8+65o2Niwp7gH37gaABQIxiG5bdb24UFADEzdKgdfzZ3Iwt2hnzwhaKIYdpgBkSGARBYrXp5esGR37Sy9UjYmvqeF6aP+FoI4t/rngBzXJ2SxxJe6YicGFYquStZelkvp1yir2ZE7F/68uKolUPIH4j5SWRa7sG+E/IyeXIuXfovedAQPkVMxoH0u13/aVKydbgsFlioDpiY8nV3iWsMQz1UK8AL4d18ASXWBvdHFwtzk1rV3/UJpsT2fE7S+IAMq8x22zmUQZ2+Hxd0ZgceRRHbR3SHvXnaDmWoRAwGex3l1sE5p5hsF+XkqAywle3fFGFQDWkL4Ioql3Ni1GDxk83SGrT5TwE4pJbfMbT8akZnwLEQsfQA3phJGrZv38h/HiQqDJAC7yCuuRdAT84Y/cLCJK9Nh/Kkze/GDWVKPWPuFhdzIBraV5PfvoBYqN1YiiAqxMIJGtpAb1fZN69MF3lCvpGuMQknHiiCMX9LalYpC2TP07/XpwZc8pYgmdVzbqSD/1rPQrD+6Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g7KXjxRz92LXPNG9EOkEXEoQGwjVpsxGtRdGs6LXaVFBIg6xrdBtOcxRk1X8?=
 =?us-ascii?Q?prF/ewhpEahcGR7Uotj9dcDb28WSqKU+cGDvT0Kb0TeDsLheCO04CE82Ozp8?=
 =?us-ascii?Q?S9DtfD2gx/81gFIXPCoCU3q0duou/dQUE+QeYVdzV+VUPKTbEFImM3mJOjjW?=
 =?us-ascii?Q?EolqjmDtdAi80B47jsQPzXF98E67/0Y2mCmc4qpQWeBvetmrx5ctbAIR1Va+?=
 =?us-ascii?Q?6IdrJABqAh11de0AHmgeGXx5Wi2dxkZJPpt/ZgokWW8FxLrO3CUH/bRho/da?=
 =?us-ascii?Q?nlFNWV8eFrQpfuNDHDgClBnoGTZyu7WmtT8koWemp1eHMo/iZxaKnA7x+zJh?=
 =?us-ascii?Q?vohE83wfiw4QT/gFOXInMpzrfadGCPbXhL15llNcZsoOG5iZumPjf5c2veYz?=
 =?us-ascii?Q?T1V0WKdnwHCRFDIiFT3zMqxWzoswebENyHZ6/P6dLwIjufR3g+bwVBJ0giXl?=
 =?us-ascii?Q?KF+kM2ImJ5+nNJxQE1ApwpnKM4k/qs8Ygev3Fwj+F3Umn5GYC64QwDEHkvmv?=
 =?us-ascii?Q?85CG+man6JMXptkKkNp918G+B0T84uzdXYQc/ChFeu6xz6tHveKBan1NpkJB?=
 =?us-ascii?Q?ijIc8ybNTf7rGyaKVZ4dzWsRZrzbIH1Z/p/YUsh3HhINzaMHoxZzFcPG/9bA?=
 =?us-ascii?Q?s9CrWWzvIBYDnE+SiEe0TcuvjG/lycvP0DONORPm/QYD3K6xwSN6wRLx8ncI?=
 =?us-ascii?Q?VHkZIltf7zkdCXIyBzEWbswLzgD7AbPDucvl6fHzp03je8MoS1OgpX1hyEfS?=
 =?us-ascii?Q?6PzL2g6CwmdGfJK/s0l+1z0qO70oMlgAdyy6IjJ+/uen9WauPyTI4t69RSY0?=
 =?us-ascii?Q?b4HhNI9Ef+V2TIRZbYzawkeJhzeaP3ozwfpGYha7Cr0FmuzJYfZjRAQmBVcu?=
 =?us-ascii?Q?Uzo2WdteRjKFVndrQkwmRaol4O/x6sXyd3VxKr3/lQDp9s5HxhkDsnScYaDt?=
 =?us-ascii?Q?ABuenhGMmoILMWdfLNiq7HkIgXScz+qpBm+buHr2mOUoVs5gVAz2oNom17rj?=
 =?us-ascii?Q?4ivJZyfw0Ak6i8OI7B5dHD61kjzwKHFxQE7UqTCZAk1hS17K7rUWt9o7cSP0?=
 =?us-ascii?Q?RYV4GSXDRO6LFJaL60YvN3PcJP1lhVviaRyidIV++XaMrDXJ2wUHa81mXqLf?=
 =?us-ascii?Q?ES7HQ4VKVzQfJelq0/Cu19EmJ9XBW5MwovlmxlnpAB+5CVVaV5jYOxrl27EV?=
 =?us-ascii?Q?kYos0M8suYP5BRXeeAMMJ3rEKN65be/o5g6gKBY1CtGa82wWqwfGlnkCFdJD?=
 =?us-ascii?Q?TBwDB5GnVGf+FUQgCnAE5VYDpAuEHOPH+DZEsPTHoqq1BJm5TkuX41AKS9mK?=
 =?us-ascii?Q?9HoDcDx1rlx2EKHeMj/Z4y7+GXoLFxF37QfHSoGWZe3AWYcVwxP9WNt9hehT?=
 =?us-ascii?Q?nDuGw1vycNo0DEju1QKKh64bfesW95uXYW3pQIOXQuAG0YoSdY7/84l25TXL?=
 =?us-ascii?Q?4olBHh8/YLZ6Kna3H6Q3XZhvP6vqdd0xatFafZSngnqEC8Wv4XLLrBUqLoLz?=
 =?us-ascii?Q?P0I5+9BIdFdGljbqPdlD/PyHuVLsB0ERGQ5FPm01MES2YvayhXJ9TUBfqYjb?=
 =?us-ascii?Q?2CA9/Rahf0DSJ/yXZdtcsRBfLPCmbORAxWQoJkSyydxyLyeP4v9312nw9fJ4?=
 =?us-ascii?Q?X6OZig9Hssre6DyBox3r5JDOwwVgAYMLDE+y82z94uvO0WXhTGlkFUZrmm04?=
 =?us-ascii?Q?rBBI6ZbNFf+m9+lvm5tPr6/kMOlemorHv3ANyBz1EXsGE4oQboi//htef7ir?=
 =?us-ascii?Q?4w9fVQ6BjV5ClO9o0X6FZuEUBfG1tyLqY/vJVH2JASOwGzJUIwgRCdedGZ05?=
x-ms-exchange-antispam-messagedata-1: 45I0VOfUIROw7g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BMJS+UL5ud/XBsbO6ij+606kG0iCw68DxZpXCA+VV9kc/UIGVLFHRbuAL9Z6umtcY3vsE69xYVFClqY/nbAFfg60rmHd6IB1ePh0TqGTG/7ucMuJ6umhrWvgYk6a67AvnVDWk0eVjmoxAkQyNGnH8qoVzg4Nh5OPzvr3tQFlW2Y0N9WSR4Xg9fKZZx9NmZW4v56MAXVU9UiKx+UvheB+agCy9TYMU2xADFF36j7rVwysESNLPBAksXSVW1fP/wp9omVICSP4rhAM3KH3pmVZoX1i2C2z96E9dsXPx8lw9PpnpUqn8ksdxtSVQh2j6xWJv4Q7dxAnsIzZwcjWKRtF+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07369ab6-dfe2-4de1-64c3-08de959515bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 17:34:28.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9y+RXJpgjKKk7u9y69sR3kY7aRqE30zXKzEGoKBeKog3Rwc6nn82KddRq2WafRX5uQ5UNQqqmt3D37XYXF4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A4F1E3BFAC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 10:05 PM Matthew Brost wrote:
> On Tue, Apr 07, 2026 at 08:15:42PM +0000, Shuicheng Lin wrote:
> > When xe_dma_buf_init_obj() fails, the attachment from
> > dma_buf_dynamic_attach() is not detached. Add dma_buf_detach() before
> > returning the error. Note: we cannot use goto out_err here because
> > xe_dma_buf_init_obj() already frees bo on failure, and out_err would
> > double-free it.
> >
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_dma_buf.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > b/drivers/gpu/drm/xe/xe_dma_buf.c index 24d9d82426b9..7702a6bdaae5
> > 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -370,12 +370,15 @@ struct drm_gem_object
> *xe_gem_prime_import(struct drm_device *dev,
> >  		goto out_err;
> >  	}
> >
> > -	/* Errors here will take care of freeing the bo. */
> > +	/*
> > +	 * xe_dma_buf_init_obj() takes ownership of bo on both success
> > +	 * and failure, so we must not touch bo after this call.
> > +	 */
> >  	obj =3D xe_dma_buf_init_obj(dev, bo, dma_buf);
> > -	if (IS_ERR(obj))
> > +	if (IS_ERR(obj)) {
> > +		dma_buf_detach(dma_buf, attach);
>=20
> Based on my feedback from the previous patch [1], I think we also want...
>=20
> 		xe_bo_free(bo);
>=20
> Also unseen in this diff is this code:
>=20
> 365         attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev, attach_o=
ps,
> &bo->ttm.base);
> 366         if (IS_ERR(attach)) {
> 367                 obj =3D ERR_CAST(attach);
> 368                 goto out_err;
> 369         }
>=20
> We also need a xe_bo_free(bo) in this failures if statement.
>=20
> Matt
>=20
> [1]
> https://patchwork.freedesktop.org/patch/716820/?series=3D164476&rev=3D1#c
> omment_1319810
>=20

As discussed in another email, could you please help me	review this patch a=
gain?
Thanks.

Shuicheng

> >  		return obj;
> > -
> > -
> > +	}
> >  	get_dma_buf(dma_buf);
> >  	obj->import_attach =3D attach;
> >  	return obj;
> > --
> > 2.43.0
> >

