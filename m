Return-Path: <stable+bounces-109502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8835DA1688B
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 09:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B71888BFF
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC6198A1A;
	Mon, 20 Jan 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltTDBi/m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD711925AF;
	Mon, 20 Jan 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363556; cv=fail; b=Q2mdc9/7OOoUziuueGETIL5Yo95VjkQ/RhQqSVQ0UbZxmXEy8SOank/osm/CMW6RTjJrGXs9hnT0a4P2dmyAeai6ghdeZSVcTI2TrpygYLanp818SjBOce7zx5IPZaZDt9t5wgn+zIEt2t5XSGAv8RrEPfCVv63O9lzks5DyHg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363556; c=relaxed/simple;
	bh=HbvXKltaAR0zNfMR3TBYHbCYatHdNuFIO8ZpOuqrlDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE1lYn2RxTzXZ2iHZfqoqb0oPCCmf9cDCltKrxyEbBdlsdWr7jvovTFhqQlwfRf2gsLvwkQlespK/pxr7wuGfF2aGEeuj9uoWAKspSiu62BLb8De0qrCGOCtJNFKmnVRJNg90xwPuyVkbaKlvS4o1igDJPRyCsYuocHpMf9u3EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltTDBi/m; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737363555; x=1768899555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HbvXKltaAR0zNfMR3TBYHbCYatHdNuFIO8ZpOuqrlDc=;
  b=ltTDBi/mo8ygs72fYpz1F45AO6XbFF4WTaR5QZKME6wd8HqQ9CiK38PW
   eu7+P+h5CNVsCjQ/O44ihrCDHT5KTed/xMkdEqGMbA8DKjwrzoYzfzo00
   11ca27plNemmHB1W71IAskOAnnZ0HmdEmixeGLCdpwzY92vwjQ3j++i9h
   VkPb4FV41DgwJul9O+LEEcOeEe37x3xcNmm5YFBgQXZjw3ZJHTjgSjDtv
   h/S5+CBxCVHc+m5qhyuPKJDvz8UDpPUQwFslfFgz8IrpRwQoSnSchQqxO
   g7sYmEr3gf1m5sBbzbXpH7rZqCaNwRdjqv1L7ze541/PBRyi1KGzTNe8u
   w==;
X-CSE-ConnectionGUID: aIb9YJz4TRaq9dxAioMYEw==
X-CSE-MsgGUID: ZGftMx60S7Cbq66AiI/eQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="48402772"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="48402772"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 00:59:14 -0800
X-CSE-ConnectionGUID: vOm6VWZSQGyBJB/FapQAkw==
X-CSE-MsgGUID: 84L3OyjUQHOMsEwurYWz+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106873925"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 00:59:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 00:59:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 00:59:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 00:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC7OaVPXlEOTHin62iJFs8oYT8JVyAqPRGwr582KF/bXLXd7TYUiguvO2nySOg+C+qUZ0o5w5EmTf6UjdsKDWYFCyQ4cS/g5nD5bdG7yBqN+C6Aipm9EC7qvmG8NBV/HveSaw9d2r/agx3d8qtr5+Oh1S6lKh/M/9pU89dOU0WB/ntrifpgP2RQaC0/U5BroUuK+Trs7l0Dv/xrrVnAs2lGkZjt26ipX7N1MDqMHH4jJ/IUSwvi1BwZNBi/9MEyIgwG+N3lQOfwQ6mjfQGb52pgC1GxOdA2uiNvWeWdLpFd9vZAlxUwguoTZM7/v/FCbZmvPlEJO8sjtPRDvQQjZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbvXKltaAR0zNfMR3TBYHbCYatHdNuFIO8ZpOuqrlDc=;
 b=QYvSQqwIvk4vUt6zUV8BgpgiMy3gtGCt432MEo9E+/7uxYMmPEiMqHozXKvgokn5B6PWHKauLyEfy+m6UjKjHjOYR91OT+u+J5Svr5/o1MG2XpHxYJJjF4uhsKmutzi+fskme8WnRNHce+nfLo3N3v/wjxEYiW5B4ZzEDH23CYt30iVvj6ZflgwBL1if5sGdJtjwkk5ZKnCVIQT8yX5HhzPQtv6UWg47ccY1CDM/KYwsGOc8AQKkhO+xi/R4imBxxDpl8oj/9uh+DW/esaSOeP2WX+tmPnwzhq5KgzuntHBCG+hTJhGNQucPshqGaPoxje9IrRHPzb9pTO41kS0iCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 08:59:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 08:59:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover
 faults for RID
Thread-Topic: [PATCH 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover
 faults for RID
Thread-Index: AQHbaxGTh2pAwh/jgkuk7k6RbQSA8rMfWANA
Date: Mon, 20 Jan 2025 08:59:10 +0000
Message-ID: <BN9PR11MB5276D7D8A236F32247E9390B8CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250120080144.810455-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250120080144.810455-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5293:EE_
x-ms-office365-filtering-correlation-id: d248d971-1159-4bc2-6a8b-08dd3930b4c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XKVdKABJet3PAN8UR7xRqkzLhUhWQnQWbnncP8AIJ0ssuQ0uhQrMy23xENwz?=
 =?us-ascii?Q?kYwibaMwf67/2LHvPyaUStKLss3Uvmy1V+0IfBDNsDM50WxRi5RZDNk1k8ra?=
 =?us-ascii?Q?K09fUKTJKHnKxhi5yJq/YzBh9T/qM2YMqGXxneKmkCMjClqohW4v0p3VDBdh?=
 =?us-ascii?Q?jeU0Xkvav0a2wCErGCraXDwPe8NJKwW8xO7ksibwlgx1QQboSJkMCFNZ/iVp?=
 =?us-ascii?Q?9Luhuem2kcbMq2WhCB8mJ9wECLCHiYjCklOZzyRlUSotmCzW9ia0QD0Bzxhv?=
 =?us-ascii?Q?qvtidQjJoum7swHiVPAksRvphqammz+wohzUGekMZBX7G6+rXDPvRwjTgeur?=
 =?us-ascii?Q?bURN2p8b9zeSGZpEHFqd8sPG38wIhrGxRjDSYyVDpnhIUTc2WXSBOPgA5lXt?=
 =?us-ascii?Q?7wO54hDLLHR96v/YFkeFRN8ziKxoZttMThooxZyxjgMx4Wx/5QJsLkis3+N3?=
 =?us-ascii?Q?MtihcmMEjGfo/0u5tkbUs7hYP4wv5CzgIn8+MYcbszz85cCEtQRBG61kn9aK?=
 =?us-ascii?Q?wBnrNyK3oJF8x0SDHamn9OPEyK/h8xSFocgK8UeH9k+/Ays2281G0l0DNTS6?=
 =?us-ascii?Q?whTQAWrfQ7psua9Cjf8BVN+gLk/nAvxh82xt8sYQDI/wX7N4m2GD3PPHL2lB?=
 =?us-ascii?Q?aPjD6REkdgGS77ilGNQ/ykkf0eZys384LsPozUUOzSoR6OPKzuQkv9y/UfUH?=
 =?us-ascii?Q?WdfYgdhp1TS0NtD5yXh5p9FK+ylcRnGrc9HBdUYNt3R2uKEopIOByFdmbRpJ?=
 =?us-ascii?Q?gHvJ4dt921xdAn6IBUlgI0aK7WJ2w5XfpM8dU6jQYXKzua0tJTGpwHlyxwxE?=
 =?us-ascii?Q?oc8jjRg5vMIcGq8cel3CAPb8k6dW7EfYezpfpLuqafJFcCCc4HTy0hMzxT8U?=
 =?us-ascii?Q?n64CQRkeAEne8lmERfABn885OQIvGqs3CcPc2AOKY2pogDg82510VBYlz9Qi?=
 =?us-ascii?Q?UOcdPpL8Z+MLni5zL1kNT/7LrregMAk6uyapSJUwQhWi3e0ZEnf4PeIJuwkj?=
 =?us-ascii?Q?UhK1cViHVU/M0ppSRvsmYaf+8A82Pwn9e9qZS6CqqudpHt8LwD/tGvygGzU/?=
 =?us-ascii?Q?uToh173Z2ehLDglVmO/52k0/hwudGhyGBNhOcMMi5LPyejIbjhc1ju3/QEpC?=
 =?us-ascii?Q?TApCgcJv3BvCVIDsp86RxRgmtcWKI+sBLBWSU9di8CAjRzCOU3pKfxsrSJtm?=
 =?us-ascii?Q?a54tFzfysegMBmID08PQiwEUdy2fjemBYG/sS4g4torqyPrD9NotyXDPLhdl?=
 =?us-ascii?Q?RjXjPyVdDKuhm70P6oy2Jr8IbVMmy1uLr2dYhZcMnn/w3GxXhD5aRyVwzsi/?=
 =?us-ascii?Q?ctJ25GsJmWcomqHOm5ec47Zpj5upY1FUTcbULoVTqb15Zx1as6F2JnhbWIbm?=
 =?us-ascii?Q?fHKJvsJWFfygc0HoTFCtNqFoxBHwD7l/CPFCYicinafMEBSWg8HTJlx0olcq?=
 =?us-ascii?Q?sTQaBFnluRtEV5HlIAWWRWXIqxBj2h7K?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?girI+TCOCz6s4M7wYoYXndhkO1DT+z94BnRypabjAygrY2iAfkGJN//8uNPc?=
 =?us-ascii?Q?dZHlK8pH1KFTA88MZkM9QjMduAU19tWvDjCEVkM3IkqNBI4+rKjGCX38o7df?=
 =?us-ascii?Q?LvAWmOOihapcV+pHmVGf27MJ+mtp35SDkjVDYOwul+YTjGdytfp+JrNc/UnM?=
 =?us-ascii?Q?kgBGA/qaD9JAe4ZJE2F9X8Ib4ri3lASVxdKpFVJXJdVTKu2FFxDGpLQysyh4?=
 =?us-ascii?Q?tj4qE2YbHHQzGvvpVeABrLdDOQIijnqjBOvaxONYFTGC7gXREjmKGozkkc76?=
 =?us-ascii?Q?urCVbZAJ95ikxGWaH3J5Dg9iIgzyCcRoGUsgZPavk0wxqN506W32LaVtT+s/?=
 =?us-ascii?Q?sMhPTLSkmLgNwAjs8NDgdwUq6KRyYp0vWVjpDrNjgyVw4MV8T910Ed3FyTsR?=
 =?us-ascii?Q?YUc+ZPSyX2g9AbuZ85/WN08bzmBEw/PtGR5kiOzTRWmZbC3scYH5wE+TPjpV?=
 =?us-ascii?Q?CRHfFT2Lhc4AW6pj/7GHsN1DXplc9MNmw4Bg5s3PEZGnkFTXG/E2Cnviwwfh?=
 =?us-ascii?Q?gILDCPOKtagZoO56mCk4s0fq/HvLMKg9FcVILI7faioV4ggL8usP16FsW/eg?=
 =?us-ascii?Q?gcVmzqPOUebB7nCWN220CBfDs8jwymCLhpZW8zgfFmUDxglBCAAwBiKXvj2L?=
 =?us-ascii?Q?V2MA3UzankyA67eVMTohE4D75JAJRCV8ozM2XFcdBUuKp7JPAdW60wtt+As4?=
 =?us-ascii?Q?oxAjRwtUDenSiXfn4tVy1gWQEIYCb50Pqve2pRGojk+Eyh6ws567AgPT5O3J?=
 =?us-ascii?Q?RX9oa6UWMjqvEytR32zprDRLamhV5nIOgo29SDIMyHpE40P7EFEYpmK8JDRy?=
 =?us-ascii?Q?iKNjbqZUIH0QDP+aQYJG015/9QvqRCEZpU2iEttOoDxwtTL9353wZje3/9ij?=
 =?us-ascii?Q?w/GpzMFPE5moGmmKrkhMqkn3zq9NxCHtOQZbB9qjJic4wyVlrKetM7c9yNoJ?=
 =?us-ascii?Q?exWNKh7FPo+9/bNHPj5wotsCNe+NXKn0L/LCJhaMAXzl42E0R/DZquW/99eF?=
 =?us-ascii?Q?4OctWqskenyfFFgzaiZT4DLGPkyE//9zysbhGtEWOwIC/0RhEjn0Spj/msE9?=
 =?us-ascii?Q?/dtqpcxZQ1tL14nSy+fSvR30CWaK3SJFXLR+d3qeD/8MgKqHsNJbSemQ832U?=
 =?us-ascii?Q?grUWM0N4JWpYfGkf2ytOCRz2luU2HCJqJUPePs8AvEy1EEsO/OA9c0CnLGNl?=
 =?us-ascii?Q?MR0RJc1uosea4juXcygvVGxefeYiH02T6mPLAdIUTK5Z2AMpNvWTdmfljCRW?=
 =?us-ascii?Q?hlaymlOuvAUQbTM6fNK85BJPzqQmzFov0LQywgkFULyZ1JloUzVv14tiEYQP?=
 =?us-ascii?Q?2PmqJHXSqm9pbCzGl4ZKL3BWHTbM0vHl4lCfYzHUAynIvpuJA+/V/8XVvHLr?=
 =?us-ascii?Q?EMHfLZuNkBaCIHkI5BfrDio56XvXI7VxyAMrJTBWQBc24418v9eoCF1hxgZm?=
 =?us-ascii?Q?TnfZOgq1igKXwfHVFf1f8hA3Vl5jupqdMG3Nwr7o7J6mQ+Sed/O1GN/J2wr8?=
 =?us-ascii?Q?5IwKLZCGNgQq2JQLr2kPi1ppCF/gu3m5ZgkpqD9vAbP68Zlg7fxVXOFEOcEe?=
 =?us-ascii?Q?ApcVbnkfb3w/viNrwNLATAGPHKNxKrYPxoR7SC85?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d248d971-1159-4bc2-6a8b-08dd3930b4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 08:59:11.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3mB60MX8q7eatrvqMDlVILQNHm6OHpoBV+YPLs92O9BjDoms7aZZyuRNWJCVYjbtfs5VO0Gnk4PezlwNhVXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 20, 2025 4:02 PM
>=20
> This driver supports page faults on PCI RID since commit <9f831c16c69e>
> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
> allowing the reporting of page faults with the pasid_present field cleare=
d
> to the upper layer for further handling. The fundamental assumption here
> is that the detach or replace operations act as a fence for page faults.
> This implies that all pending page faults associated with a specific RID
> or PASID are flushed when a domain is detached or replaced from a device
> RID or PASID.
>=20
> However, the intel_iommu_drain_pasid_prq() helper does not correctly
> handle faults for RID. This leads to faults potentially remaining pending
> in the iommu hardware queue even after the domain is detached, thereby
> violating the aforementioned assumption.
>=20
> Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
> for RID.
>=20
> Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in
> prq_event_thread")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

