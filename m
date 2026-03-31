Return-Path: <stable+bounces-231346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ILJJL51y2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:20:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F74365030
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94CD9302DBBD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D33947A2;
	Tue, 31 Mar 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA0ifgdD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143933A3E61;
	Tue, 31 Mar 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941562; cv=fail; b=d8ky7JwOQ/14bP3vEYA9BLnr155BJj8lhCBPLdTPJzUrOSGZL1KDQhWSYXKTERI5XoMvT22PcxtFM54onnw1gUDXmIdbsCjgXcrAoqRAOmprC+VwangshnX0Ngg22iwD7TZhrwm8paw1t1DE7IdxK0NltuKxc8WVoFD4HLFBJwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941562; c=relaxed/simple;
	bh=I5VwrE6dU1b7hxTztyLWONnfqAS0hs1GX/yFy7Jd3Eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XqtirxIbaXR/ZXrn04mMOOZiWceeBKfNwa5mxEL96b13axw4C8qOAO4QjBCpndw9P1U2wkmF7iHeNWOdcY7khtawQ8bHBQW98cCE/qCDWyNV2dOOjgmgLA5AVu8OHo3MqVudzZKE9JUS01sA1vzLHhiqP/b7R0j7Wo4Q+G0dwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA0ifgdD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941561; x=1806477561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5VwrE6dU1b7hxTztyLWONnfqAS0hs1GX/yFy7Jd3Eg=;
  b=WA0ifgdDzymkpkMeJ7t0SW0ikFfI0bnhL7u+26augSpk0ZGqImiJPaTJ
   j3H7RrzjOsccnvEg06UWbpU0sxywS+YQkVWEsiAYB8eTvHubiNQJTpPfM
   QUNGMI8E/sQmkqhg+Vuay8Mx2xnsxwcm8QlMECaT78ZpYQHMTmzi3KajJ
   nIcdpug3Nq1IwMtUj6Gs7gAOxvg8zFo6kzbvxWuKxUwZjxYGSIBk2WMPK
   4iehHmRK3upcqYXfNK1hK3w8dxa0iI0C/8BtKR9ppwGG78Nr0rmiTIKga
   NxxKNHtsnMqeqmRb5aLaO+lVRwAvQZa6AvsUiPku7FsNfGc2bZJh+worS
   Q==;
X-CSE-ConnectionGUID: w92H3Z+dSG2iwYsgQlxhpw==
X-CSE-MsgGUID: PBH7aS7dTYS1Vmz8/k0zbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78537970"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78537970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:14 -0700
X-CSE-ConnectionGUID: UJrWaR2WR2GqdYGFhE3eqg==
X-CSE-MsgGUID: XZAREZqWSmGpveUU7Vl5hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225454063"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:19:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQkV5kbbMnSr6g7n10V8oB3BtcXFrFARo5RyZp3wpRm501Z6QPVM/OzHKtVTnuwE8iCw+qlppMWO9bWoEd7bOvXg98Mfu5KGWDZ6QYIFXNp5OhuvZ3JJ8+gA8MuQuKZrTnGzCCJ4X2zXASH6kiDUiUEUY0LbWGGZ1OEpyqLt9XpUXyWTA3WRkrXtDxYd+BY8+m0TiB2fQ5Z/Kr1NgeyTEiH5JTapmj2+69lj5soEkfwIG+vl2KqF5lYC2pGpYn+E3bbIaS6iljzWIf2rrCbjOuSyy+m3Y0LIuEI2T16Mtj7+1pIYHyQ2l94b5sqJKvIUUsfZ8/BVDFa42bzoHOX4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5VwrE6dU1b7hxTztyLWONnfqAS0hs1GX/yFy7Jd3Eg=;
 b=kpEGt3HIvZ6f6rdjtw42iEPU/drBONX/hWXhvpXyHfjVdvMVbSLfnl3OGiLukZJbw8alVM5gZq+wc2suRfCGT9TizSHnCkz57pNZN5OGTSd48qYIo2nQSFX/rXRv2eh66WuCAdeBtLqMnqC7qrYqMOemyj8EAYN9+4OEr3BhNqXG/Q+mdoSkOztEUunHFeb5BoJCFSgtZ3v7PrW92+XkFLT07hU5PccNTIA/uiNPGJOI1Cps2KKIs1nz2MzSIjMa1f1K0SjHm5NwzceiZp8c01KF5a126Wym6B4XGpqYoXIaf/jk0HVRO+9f1xPJDSc3RPHoW2kFccy5M53Gq9rpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:19:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:19:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Joao
 Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
 domain with dirty tracking
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
 domain with dirty tracking
Thread-Index: AQHcwC2UQg9f9Rw1S0eBHmFAfjfRSrXIPMaA
Date: Tue, 31 Mar 2026 07:19:05 +0000
Message-ID: <BN9PR11MB52766AFB3734BBDDC5E615F68C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-2-zhenzhong.duan@intel.com>
In-Reply-To: <20260330101108.12594-2-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: d1c3f43d-0315-403b-d2c9-08de8ef5caf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: XJZblAlG2mbyJIjkWNgI91ul1+VOMmrozre3LLv22t3RnDbzGXiwVx39GTOObCn5WXVTIWdNTrrHBU1LoZmteJz2bvIJI6uinAjM+xyzX0H1st9mzrrRbxlXCnWcxskmISe89iMsqDz2YtzCiG37+XmfXhZG6l4T/+6mOc8T+CrOhNclKXI5aml+BUZLw0R0T1JN6r6xHGSxJ/7bNmp2G+rENiGz+KlsGyqQIQEA6NgRhyz4t/mb0pxCT3tcddyGa9gggStNc0uuDCgjh2sKb/O5hgQSQa0oM1MT5Sud6Aqeru+u5OIauuU0xe8MGvL2vtZpyCSOBmUJhZVzvtUjBd+Px5Yr11pTSdlk44rkFS93k88qEuEkiofAlnGd4Z+3rlaVCFRXV7Oy67nsSqW2n8FWO30l7uXFFQ2MyDDD3h9WqLcLQ+JeEodJuDrxo0KiXNExN+0DnQcCwkmFzgiaamPfTczBUVXr/d0QdEbHYAq/r0uc2DFdxOl45s6qx9ep2kcMn+wBtYI5y+cAOtHTjU3DO0Rrv2D4Gy21m2lQSJt/OSvjNX8AUZ5vc5XecQ5715mGWcvp3HzZ6Fhm2hs+IsxmcqQ2Ic+1nWIseLHDM/7jLp5A7rZLJjw/JRiXuO4Ba8ETpk6kOjDDLmZus8Psggs1lMxhFU6tfjSp3Ctv0MFlAA7KqHYGrkER5+3exOjTRlOGf5SP4uC1kkaIwUC0kZMXAqKGHPxOK+aeXjUvzwvPHVvRBnNmZUZmlnAVLykmYOLSOKVKtqf9Rviu9/4qrcrsgMIpcP2gjzNwA0oyc50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRzgH84FN1tHRSzf9GhswNrV0eScRYJLrBZIFg8u/QYgOm+oXs9f3vRbF3UG?=
 =?us-ascii?Q?N9niDHS1KInS4KhME4Rp+bE+EX1XzeyguQ/ugORG9iG+pDRrdDt9bsv/2BmK?=
 =?us-ascii?Q?7exuAoxZK7tq0YppQmrGb5O9t0hX9K3LWbO3j87Hx1moUKB7hMdomDetiqYE?=
 =?us-ascii?Q?HbpwbUuZgsEtzMM43Ld85HAxs+zNX1ErQpZcJunvGlTVspkUBxLN5y7dbaUp?=
 =?us-ascii?Q?qmemFSfmCXz7zlq+n7dTwPWz2Scx/+FjEFyOoCNvEWdft+4yP9MpZ3XYFdBp?=
 =?us-ascii?Q?7RJAxpkkickDUBL/5uTlK75+PQHLJypZlZaaMk31jBggtt0VOmg9enRTo0Sg?=
 =?us-ascii?Q?rdDMM+0mGWB8J8TWeDaMZoDQFVqzfuZ0/CCS0fZcD2Sv7Cz45kSnBe8BJJ/Q?=
 =?us-ascii?Q?GcSglBUvUqGB6SHoQoRk38k77NGMHu4jdMwFxy0dyZvMxRbZW0d3s+50BAll?=
 =?us-ascii?Q?lbdFO+k3HGRGRSXGSztS8D0pybBLhm5bvL9ATqYxaE63VWvBIJ6g/+RWjZKX?=
 =?us-ascii?Q?AhqXCwxklPsRpIwtmS/TxMRfWhCWUmnLd9LA7WdcUxfrbEfd4Kffnw8KP+Rj?=
 =?us-ascii?Q?f39PwAzbrTfBNOXIYjqN6IyxFmxqEgK3fhAntGO5F48qMTILtIUwgxyqWDxS?=
 =?us-ascii?Q?4NrY6kuPLz0LaKtLaFrbrxsCuCFmNDa6jol3EITXhSUrtupKf/T5Zl+4R1K1?=
 =?us-ascii?Q?IDOt9wQZjX/KJRw47/HwTwbHpYRD34xYciCdPq5Pgt4C99VZyPN1/cD34iNO?=
 =?us-ascii?Q?ZTH4TRinKKkQGTMOAwF5ckUKHgTmWne7R2Nxu9nyZqZ+ogt9NmsOFOYEmVRW?=
 =?us-ascii?Q?qdzLq9ctYF/R2o87UFdMhUi5hL3/AxK0zU0+0hNosZ2OH2hTecZqh7qOMNUz?=
 =?us-ascii?Q?2dJJCULMNVjKA57rM/PakE4PgfEApnk8tvaVlMon5gpwbKmyQy2BrChACwoV?=
 =?us-ascii?Q?d8fDgOflSglDhgto/KtYywOekThvohdX6z0RKQJxQlqOOH6emaMoruCZ9Dd6?=
 =?us-ascii?Q?GlehGpfuWbPwsZbtc7+GhzphoSbO+87HxBZ/bfU1qwaFvCff4Dg1EFC8x4qv?=
 =?us-ascii?Q?GoQp5mn2yCbjqrgTAlCfQD9owc7U5M3UoxP2f4293XAJ4GOB5ayxD3/vxnwi?=
 =?us-ascii?Q?FtplFtCwB89tiPwtdTl3V60JI129IijOkLx+rBppTCiSiohOP+cc30PHJ2X4?=
 =?us-ascii?Q?5Bbp3Ds/+ekVpsCSuhVooxqSZAo61KG1nXE2FLdbHOGSLC5BS/YynXNOA66x?=
 =?us-ascii?Q?yo7QCutR8FgthdJZoYdr7NYpWCSpMQ8xOt7xCqDMgYTb/F219MOweC8BVRpH?=
 =?us-ascii?Q?TQzjQlSWu6gy716gsbAgeID3cZ/nVwdP1x4EGBp0Z7ddsr2sHQqkYNTPMzoW?=
 =?us-ascii?Q?I2mix2Dg6poPyQ8mZkqPQJZuF7A34qmL56EvLTkGsJZ4kM9XmqVzPADU5deN?=
 =?us-ascii?Q?4dhJSa/5mEATdLAQR6YxN6NQ6/mplQ0uV5wU5Ab6odiqQ2lq+crrhaAv8FP3?=
 =?us-ascii?Q?ODmYELDWo0b+XgehKoY6XxGmIdK1A9WnHv6CvJMrb5zD1HgwjM4pHiqfyx0G?=
 =?us-ascii?Q?q0iQFYrSnbW9+PH3zdgnUVxkkY1zo3uY2n+85NREKIBsIkD1tjlkMSH4qi2q?=
 =?us-ascii?Q?edQcWbRh/kgTi7oJxrf2dhhPeB0btSNKT+x34JecWW5ZIIzC87j0AbHA9slN?=
 =?us-ascii?Q?gdtr2Kmx1X9/22KQ1Zw05mR3aKphO42cmmOj5Rd3luvUyj0U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nHQFKG0Gls0yL+KbkKtDbgJydL2GsABVpya1uQWVwH9k/mSjoBPLw1dB3xI/W/Znmot+5Ngq2JOUx0lRUcxE+2z8lxdCptZCFxNykVkg/DcvsLtaj1YQzifs4BB4iiMWTEJ2e9P89ilNo6yQb6YDl1hGa7Vu7PckjR3FyJwR73WVgHZttPhViPw/pnh+zuDmalyJyacSMm6MbWQdGlPtv0iTQJN9chlT2DFOBQpy4C/fnpZ3T4FCjkOWuDxSKG1MZdJpcHF2Cf0lRKpkZ6ho6e1Wo56EXlKHFQnH2ZXuoBj95E6gfEtlEmJg/c/IuE3PByK1kDFoQpjFHb28+RdMoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3f43d-0315-403b-d2c9-08de8ef5caf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:19:05.6073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yQBpaokE4bo1emKQSrwdYKxIXwgAfUcgd8zVJRYQKkCMb/5rV4MVOtVI9OssNABb5d1Umkrh1s+NvYkvfbM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231346-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 43F74365030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, March 30, 2026 6:11 PM
>=20
> Kernel lacks dirty tracking support on nested domain attached to PASID,
> fails the attachment early if nesting parent domain is dirty tracking
> configured, otherwise dirty pages would be lost.
>=20
> Cc: stable@vger.kernel.org
> Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains=
")
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

