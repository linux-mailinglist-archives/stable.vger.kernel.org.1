Return-Path: <stable+bounces-136508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B1A9A043
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B03B4489
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 04:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A721B4139;
	Thu, 24 Apr 2025 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5H5ruz9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C194F510;
	Thu, 24 Apr 2025 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745470439; cv=fail; b=GBQYblOcDPPa7qyCLkCE0GKuqa5CFPDDm+dGo9xk/cebPdhc/CrQOhO1MT3YhoQnskLCKVE6lCLwkYfRcFGLmxt7elOUWL90UYP+2RKeSU/H/UMHfgM+TBLHF5xTVaksc7FWZ/ngj9ZkPQOB8q2MiJ219Xq25/iMlvhK4Ul2Khg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745470439; c=relaxed/simple;
	bh=1cD+5T3hSsMBXra1p7gNf8BEOafixbT+GpZ8ed2/Gj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEuFNB2e8Y27DYt4E4kq9ZXCXHpMeagbDQd8TeZ8yL+FAXtBsbSAneyYeDbyRrXnaKDnMrVApsiz95IId+6fH7VRkXP+T3YJ8/u9Ngu+FVRTPcn4PP5CpXzguuwNVQP6XpgktP54SP2sqWEFmtHTxobzsJSssFwpb06YvOhqNaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5H5ruz9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745470438; x=1777006438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1cD+5T3hSsMBXra1p7gNf8BEOafixbT+GpZ8ed2/Gj4=;
  b=E5H5ruz98LWCM5k+UER/hcg05xdZIurag0VutdkwNfIKE0rfHLlAIlsd
   J7ztlI8YtX2DgNqMirtXnWDwvUCsYO1lFW2qj2CXieZkYkJZ25JfKB87Y
   JHaA773mm7j6w+uaBPBIjiHyXTN/8DFjGn89F21Zi+7xeHJ+2woqXAQA0
   z6R4qAOdmI5W2ytLwywOxrCVkB4CsPEU03hrEoQjIiYELHvfcoy48hp95
   MVBHmNeO1FcbGYaOBnmSIX/rx+bGQgUr0LLTr/nPRdNsZnJ+fM3FGgMTD
   M9FIlZsgDu5fnRloTheLtsUvjekUkNtLzNFNezbkdxUpaCRzYQMFe7lZ/
   Q==;
X-CSE-ConnectionGUID: nZzzkG09SBur4I9PnjXMAQ==
X-CSE-MsgGUID: BmoOGU76QB6ih+4X7E4cAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47261301"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47261301"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:53:57 -0700
X-CSE-ConnectionGUID: YqRq89FkSc+bYm7bIOWiag==
X-CSE-MsgGUID: wsoPa8FhR8SA3zOuresLaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="133405525"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:53:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 21:53:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 21:53:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 21:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxPN3kv2IB6479U2L1YRjpQ0C2qRLFRnYrH45Ll/zE6M1U7IlRYVGgIrAir7nBC/Juw/kFh4q6AoMXps6BCdiVvIw8ReDDP3VVI4YvD7rt3h5+JwurziPsm7h2AZWow5AN2RzdgXfoJQ1WcMe6ir4e2Ga5uH965ucPeHa/ebMW1HhoYffKg8F3XxVY0cLjzONHI+Hafze17AD9pbhIecnfHrG2dERs39od5V0uNjytk/dJX/QAjw38IjEodLuUjxm8WYmiSOJweqRr5185VJsBTT+36CvfeGaPUj952Bny/ut9429Gyv68192VPH2fCPOJMrhzlb3E9LgXUXoNPFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtyBgKrbLKZ8rPGt/h8+2yOprdyfMo0U2pA4it7M/pg=;
 b=dFS0ss6HO6XBay45RO1PQdO/bdk2OjKM4geumrsBPPr2M5ShCArv6HJo8H9g+kjb1nM23DYXed1TIRMyPPrSO8MohJLA4w6toV0qdjpG6pSMilFiB4Bf05XAyLAA03wb/c0dOU6HSC1iO02B2+XgFN28vxDXBQkZvfSye94s5KPZUfGai7TV2V4uxemAqptdduSrUfj8+SqIvDqlQqfqkHpbsJuI2iOVs3wTJqRwH7220ypTDjQdiaDg6rCgxPR1/C+cwa1tqlYaP2Dk7AFknHiVtXUawAJ/RqMTOSRcSK2OjPr0uYt2avdSRrBwvAUVzqNsB348HKp86BcLMUM4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB8866.namprd11.prod.outlook.com (2603:10b6:610:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 04:52:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 04:52:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "shang, song" <shangsong2@lenovo.com>, "Jiang,
 Dave" <dave.jiang@intel.com>
CC: "jack.vogel@oracle.com" <jack.vogel@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
Thread-Topic: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
Thread-Index: AQHbtMq0VtXqvF6ksECJ/WYy+jcqerOyP5Eg
Date: Thu, 24 Apr 2025 04:52:21 +0000
Message-ID: <BN9PR11MB5276681A81536939B358A85C8C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH2PR11MB8866:EE_
x-ms-office365-filtering-correlation-id: ff6b7890-0bda-4345-d49c-08dd82ebcc64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MW0zqnALCuDEIYeb0hVUTet7tkWucRel5sw3Qs/N2frFAA/1uj9Tk8r4AI2o?=
 =?us-ascii?Q?1DUad85qpoHpwlxrEvKkejo2jX9NsH9FHadbXs9i60KxbWYalYRILeqbZN35?=
 =?us-ascii?Q?6LerMLNfBRRNcDbqg2qQjVaOEMclJJhm7VOOMTOgWV1ERJTJhvosKbrwIJ4X?=
 =?us-ascii?Q?Hwxbr8ZhEncHz0lRAE01ahT9YPUQTnj+kAdiR5wqvwqWX3ZifopEFCX0ioPO?=
 =?us-ascii?Q?hdkKudhSKukxcZbXEzy4lJViOMJXu0Wz+yz7Mv1k2TfoYIbUygnjha4gw+NH?=
 =?us-ascii?Q?xOxw+Z2NduEv2B/1Fboja/uATNXe8cCPZID2I/4+Q37GBb3HabtqdAgUDeMp?=
 =?us-ascii?Q?7GJ0gv5AuBETJWP5qpwyXw3uk5iA1VmdMpCcpRLR6Dcv5eANgPyQ17gyj/3y?=
 =?us-ascii?Q?RN18c1amx95d+2w6bL2m8zQ2Mhl3jwm624nAoore+jN5Nr0q+RgnVQsxLT+2?=
 =?us-ascii?Q?o2Ee/Rd138dzWL9MfzsdLm8Ejneo0j6IIOT4Hb12bz5x7SNk2TJhLW7OPPmk?=
 =?us-ascii?Q?3X+21eCDmqPpwF/wuRtj5oo0kzpvHeL/7a43gHJy4k7t+emyh++nAclTwRUE?=
 =?us-ascii?Q?9mWC/8pp4ltYkbyUxQiFZ/cEOLz37i7UBPc6eKCapz7nTuZZgK5zyJt1vVKV?=
 =?us-ascii?Q?KP6okU8355yrSgW2avR0OfwTST4dZjv7t/vO2aG5R3n0nKhGM81QxYLXL/Hp?=
 =?us-ascii?Q?5BRe7dAXLZO4dhkoVLpOEpwMcYkPDkMYXvdoOxS0VMLu/5GKv+nEmc0Vgecw?=
 =?us-ascii?Q?EA+GfFx9llJpE+N4K39zQxHp/m9fHgjl+LAvlc2uBeB7RM841nwTJG+Za4F3?=
 =?us-ascii?Q?G7idWFoRzT72yy5eqG97LgQpXHNegK1zIOP7+rWiPdf8iEsaFEddA4OyZQ5W?=
 =?us-ascii?Q?6FuZ8nbviTO3vp4SgHbNyes2bSp+prjmJ+cY8/JYfzWo4JXMtEYGckH1YCNk?=
 =?us-ascii?Q?APMmSukcA/oXC9HcYlWwqONyrqE2mHSUb9pMC6JNLPSxnzg9rHi+ahPlE70B?=
 =?us-ascii?Q?vw98b7bBUSOZ2gXSt/O/QeX5XhupjIJfm2sx+6UDZTVMB3CJTEiSXi3QMtlM?=
 =?us-ascii?Q?AusX9JFEzX5BowhRTGtMszcHn1x1XeZymenv7Z4sFedXfxJqmv9PLg7enlzC?=
 =?us-ascii?Q?mwadXinrEl1RB/T5r9wU6vExIVBG89IF+Q8d0nFq+MbG51cFbsLR0tJkIL4W?=
 =?us-ascii?Q?xIeIkMq6WWuNVR5zaPV4gvViWCfcvwNYNMGXaFXtZYLetYB8C7BLGDAt8EiY?=
 =?us-ascii?Q?1dO2MeUL5AKxUB0D+eq5q1BrekcPPFD9AWZXjPdnjzPkrit5YhqRqlrH/DQZ?=
 =?us-ascii?Q?s3tme49hTfIyoRo/QnD3Aczuf8GPWYiw4ylBuB5p7e4q/Rb/cyc7novRL22W?=
 =?us-ascii?Q?KpgwmyUBXyfPsQeLtiXYC42VNTljcGPx4fS5FHAPKu0FGhF587C6YdUvTu0j?=
 =?us-ascii?Q?ei1W+k33mzMN7+Vuy3+l0RAg7bv1iA7gulKjbIaSSjbsZlbKV5wsNwm+b0pE?=
 =?us-ascii?Q?oghOHSrg718c8r4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gNDD+8tHOB46NRRqRNYT9AtwQui+y/8IAQGOFUd2dW4AkbPDdi7+d9bKTyL/?=
 =?us-ascii?Q?edtU//rDT23n5b2Xq6tMEfsUwA+P0r/+gH+8qiiVNyelJLI9v3Kd0KoZBI6v?=
 =?us-ascii?Q?vnSw96ySB7j1Y45uvCdpmKn6SNFnLX5f8Y7XuksNLR5C62pwMEj0e3wj1gxx?=
 =?us-ascii?Q?EnpGjVlm5Bf1FwdsQEGN6fl2yO26c6k3k203G//JTMWA1DRcAMB/XSoUAL5Q?=
 =?us-ascii?Q?25CLjFrKsBcxPmr6AT//khOn8wGAEtFwo51IZPhe+w6+s7nwHqNpLwuMUK7t?=
 =?us-ascii?Q?3UaAkReG1EhgSz01YU+gjU06/G4iRe4xH7HhnhUE7NRd0PSXZJIAmI+NcRWr?=
 =?us-ascii?Q?peHkAW4ejjB3qphTkv9XGTu4NquoV2srjG+f+HGjjcXTRdHZv9JNntc92zOQ?=
 =?us-ascii?Q?tqLpzPolgZ4TFHjKbF48DPfdFdo7UfMugEcP6pyMFjUw0gVDE/DNOfTRzOVQ?=
 =?us-ascii?Q?m3W0MCW5I/bp/96ZwxX/VW2y/ftBIfG0cuSNVyXCaiPNk4vnpXR1kcvJ1vf/?=
 =?us-ascii?Q?uhu6imJE8HvpI0EPGSoC13+0LxBWdy64M+IZ+u+nxmN1fGxcdPL/cyujZAX9?=
 =?us-ascii?Q?7T9fPdkVied9qJmtGDOeMwFY2INrvZ4jJhJTxR/4Ng+QqXy4cPyLkaLcy95U?=
 =?us-ascii?Q?QU9lYgW50kP/kRtMySBUu/Wgyd1GSZIE9Iqf33GCfP5s29Pr40hFGpvBG85q?=
 =?us-ascii?Q?1BSonevAFpGEisFRQSkFl2kb1qWApHmcJYPyO+G3qiVNk9EO8GTDOeM9EHgY?=
 =?us-ascii?Q?koCcmXCTzdA+2tiqfmVDjiK0oVW6i+6SB/eTYgLjDx8dBNrq5GZ5+dO+XkN0?=
 =?us-ascii?Q?uj6gkTP2b3B1PTLXIgpTlTh7Z1J7KwEVta7BU51l/MaOxQDNGR0/Pz03IBTX?=
 =?us-ascii?Q?DClvtCWMQ9UEGin8xpJFIJh2ROHbp6On8O1WNnY1AEew2yLjUYbuTQH5aE3k?=
 =?us-ascii?Q?5tTGYn6Rh44yqDg+oIz4I5cUYvhp4xBkMM6b0qoIbE2RhkSt7VzGc55gwktp?=
 =?us-ascii?Q?ve9BsMNLedczpirkMAl+4lrp6axz4rPK3A9frdRs7rLsj0k5KpsVjj+3IVSO?=
 =?us-ascii?Q?g2CQJ49A886CmjVfiy7WWcxaAtfzfXVHJIjsW//NJqM5gfkQjSzLCEkUoSUw?=
 =?us-ascii?Q?xu7x5Wq8QwpQ672klHTNMyB5OAM40cVyvY/myeEr6+qDVkOj5PBBJxM1VKfJ?=
 =?us-ascii?Q?d+5jKaHFpnsS2mGPZCbgWB4MMfP12evp4VXJKmiLXGvftwf1GcIZarEsBeGb?=
 =?us-ascii?Q?Kr+3USwv3LmDCk1m43zQGXcSgAftUaa4XnVrLC9Skh/kphZ23bgiIBQZB2UL?=
 =?us-ascii?Q?uOwznpZ0nNK9jENuXbY2fekyTS7btrQO/pI2z2hbaZvm5suKmI0+rESVluoz?=
 =?us-ascii?Q?2ykUN78vSjpJ7Ar8mO40TRM1tBf+efQ4MNTLxgEyy9qvUoByH9Cz+WZF+d1L?=
 =?us-ascii?Q?Ni9d8uOe1mdUXTAsvMz8x8k7FVv6DbKpx5LcugtrRUGCcIZgvp4VRryca3ak?=
 =?us-ascii?Q?++tIZyvb/ncxuOpT4U46Y34S5hyyx8H7kvBkkfGcuSkHzAW8sD9mvt2wTo7A?=
 =?us-ascii?Q?Vzb9e9Zs3QJnATk7ftdiKJOv5cmxN4FKpxAGT91Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b7890-0bda-4345-d49c-08dd82ebcc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 04:52:21.4366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLJXwhuxYp3QZgi5iavIRVF+9UBoKc2/GQQIToWLyVh49PxmLt3xFCB4oE689bgzEOt7LYuQRq5zMy+9dxthow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8866
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, April 24, 2025 11:41 AM
>=20
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
>=20
>         if (ops !=3D domain->owner || pasid =3D=3D IOMMU_NO_PASID)
>                 return -EINVAL;
>=20
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
>=20
> Generally the owner field of static domains are not set because they are
> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
> that checks if a domain is compatible with the device's iommu ops. This
> helper explicitly allows the static blocked and identity domains associat=
ed
> with the device's iommu_ops to be considered compatible.
>=20
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain"=
)
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220031
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-
> iommu/20250422191554.GC1213339@ziepe.ca/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

