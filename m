Return-Path: <stable+bounces-161931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B6B04CA9
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010231AA0027
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8728F4;
	Tue, 15 Jul 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQ9g5cd1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D6632;
	Tue, 15 Jul 2025 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537945; cv=fail; b=on3OG34YRWlW14UDH9R1rykxMpK5GIGd4Ky+DwNcxRGN5iv4nA7GPcP9ELn72QDW+fJ3HcCPhCjFlVujr0w3fQW3cYflTHMSHtdVTV3uxZ4nEGvffFza3sFNq+i67ld0++bx4QkETArxYZAIn1DDfFwVODBEA+RDtwPu4uNLuAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537945; c=relaxed/simple;
	bh=gyVtt+OPXn5YsiSsD0XOjsRhtndg+ZE6G3/zP3B+HOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2otoBJeyAsAmsisfrKM/W3zE6//FzyBX6eaRoXrNJqByftXb4oG8CvafC5qHZ7l96yYgE1UsfvzCkVHRFrvVsFTEkjFEmJwHxmk6YZWqhPgTTbfBqPdR6BVHDPUoyYvgpMM2awsm3yOwL1BtL0OQ6k1DZHW4OJ0IByxDQFIoms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQ9g5cd1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752537944; x=1784073944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyVtt+OPXn5YsiSsD0XOjsRhtndg+ZE6G3/zP3B+HOI=;
  b=nQ9g5cd1h1XtGlYcTQUI1zmNsfUDfTRZY0WaRGrZoJqRPVtpcq2NnLeG
   0wrXpnxlXqO7JxQ3QEd64gpoIZPFtdd5lqzGTvMCiTpEp6KaSkSnULadh
   6WzH/E7jxE9ebknSrwu6IFAxAESeGTS2J2u3ydMG3Y2il7YY18A7SrE5M
   S0iCCOO7Ksj03W+42Pvagyg4tHZZQLhMzOCvLEtGhiS3LEIdPLjih0HKc
   T0LGFNO0sO5qlvf3BaOjCAqWsjvcWHX06o2BtvabCz1uU6KBryw39OAfE
   TJHegrRyCpP008gi7EBwwvbK+/W6kBLVRXs4e82lnF+w5i4xtesrk+Dse
   Q==;
X-CSE-ConnectionGUID: MQwftKAmRzGCYj+hIJAvJA==
X-CSE-MsgGUID: eBkJBxD3S86Rr2RxTcQ4PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57353433"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="57353433"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 17:05:42 -0700
X-CSE-ConnectionGUID: YVHVWXp+Q7yuetL+C82a2w==
X-CSE-MsgGUID: +BDSwtdPS7CMT6W4l+ujYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="162729594"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 17:05:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 17:05:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 17:05:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 17:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0JMiK2l8dCCXTcqAc8eUEC/26hn/nZYiCjyeedCmskxTQWzkA62c+1hJnlHUia1bOfAMUqGNtlyHxdMRQFaimNhMdiRal8hACVHIBPsg6ESBBCAo0ttlD1Q+7VUwuK2oYtjBPN5GjQYWOGzJcxCS0lbckrX1DonOqJb/RU0R+L6Je1jDKzfdXo0A7zfpLKXsRLyoGSxRJeey5kml3GZ4+6Qp6nEwpQNwwDaq66fmTJtGyIZg8Xl5yVOhgxziUH41L3RkBXBV8Cyq4W3KoKaIBEBGeFJ8tUoabr2mZ2Q09naFEsqArk4SRcr2H9fitW6DvRF1/wwXy9u1Whxi4pwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slomev6Tg6TBv3qiXVBvilj+mzumQAoECuPWINdag0s=;
 b=C1+YMB2xHFB0gQM8Wc+s89fv/itPoGxcUcq5+HCZOOgnHYS3XiqA3DgKgvWMqxVB2xhaDgQR6mlJjEwVjxz54pP2ry0nhaIT0DTD5BJQQRA7+LO1WQJtdG0L++KktKP0evxmyxy+YP+PULBEdSC71n7+icPZwjjNhx8zZ6h69/JIFc78mKYjKlzDIGCgUP8XAyv7VtOM0YxeULWALmSteNEWgIDGVM0ZN226+Ew+pmVBKMslt/u7MdJ9fjddPNYO+gglqj0PCft6E+iBK1m+WrD5Y9vagyWSQTQuLnHpsqCk/HmJ5Dpl3upkRG7l6sNxNONUODP1BhpRn6kOHKpuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 00:05:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 00:05:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Mike Rapoport <rppt@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
CC: David Laight <david.laight.linux@gmail.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Thread-Topic: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Thread-Index: AQHb7Og7tyiLlC5BakaJRVDSXOOkwbQp+P0AgAAJ5gCAAB4wgIAAAf0AgAd7wwCAAAspgIAAGWOAgACanLA=
Date: Tue, 15 Jul 2025 00:05:37 +0000
Message-ID: <BN9PR11MB52764F098F7123D95233200D8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250714133920.55fde0f5@pumpkin> <aHUD1cklhydR-gE5@pc636>
 <aHUZIVbLV9KAoZ3H@kernel.org>
In-Reply-To: <aHUZIVbLV9KAoZ3H@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8203:EE_
x-ms-office365-filtering-correlation-id: 11c01317-af10-4f30-36cb-08ddc33353f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YBQ64iRXy/eXosC+A+yeusI/5TdEurVyBRto7V3dxekDJmTbBug8Di263fvw?=
 =?us-ascii?Q?Rr6GbDByfjzMka97piGy9pnrnyc0CWeQzDiV9k2PFFXtODiY3PCc3ph6MDKq?=
 =?us-ascii?Q?RO2RVx88SEnKdncXXxZVDY9mzhyBFTS9Lm5iG7x6pGACL1T6yRp7DnmtHj8k?=
 =?us-ascii?Q?Y+LNix9nfPObct+G5xVujhUnOw7VO5XFBeXSwwNs+c+vDu7iPb7j5IXY7QQP?=
 =?us-ascii?Q?Q4NNEFEaPXoBjOc6+5GUCq85KWX3pe6Zt5ef5Y6pwyRsp8IqcW68jwx3yg5j?=
 =?us-ascii?Q?to3ld+o9siUAYqx/AeeDf8Cs+z6Wanx9mPgE98W/OmZBc5IgTFf0jlYRyxnE?=
 =?us-ascii?Q?5eGq7uVeSTvwwU4rb54S5z2FQmJvNDGNHRnMEitlf1dLMSvQljjAGwUvI3DC?=
 =?us-ascii?Q?tzn1SmIWQyGZbw3bEYJaRk+IRwGLHuECKkebNEDiG/TMz98GZP+uSoPYgL7Y?=
 =?us-ascii?Q?voHWiyK0niH85Ob3iERSTspJZFlFN4cQv2qsTXX+eaVAngv8iXPPX1p8tCJQ?=
 =?us-ascii?Q?2kjpN0YXVITNXwL1t2SaP8ZS5CiqdeXuUd2JKe/ql3wZtuobz1WhLkpEp/on?=
 =?us-ascii?Q?9mUe9oGKrBMTlVNPDtgZWg6J1jNTkk05eNQe+oytmpBCn9YUy8YdGtQwrgSv?=
 =?us-ascii?Q?BqW7BI+1z4EdTVcMK76olMnrWaEsetUs5ley9dl6UEWwgSpQPJFno3Y4O7jV?=
 =?us-ascii?Q?AonP1MBHrfgo+5ovgzTqQPu6IJh6xpoRc/YfLpEHgEpbo/tX7kPAoYUv090K?=
 =?us-ascii?Q?xwbjj7nffzdEMtxzl6vuaaAOsb5NDM4+wxvt7Y8cd0RlPgf2Jocaj4Rb+Lb7?=
 =?us-ascii?Q?dZqyjtHd0LR2roNT/F/Sz/r/rvSErko+I7matYLTwX6ET8U5LcjMmlssYFEA?=
 =?us-ascii?Q?SZLixgOI2jf3fhe7PynMgn7HoLRzQStbjFDMjgVjsAuwx7SY7YEebZR8ny1/?=
 =?us-ascii?Q?aQ3CELhJ4EBBtCzZTs2CxDkkVlaCM7AITpyji3rCoj94HVMczNUm8/Dq4s+W?=
 =?us-ascii?Q?bkyYF9fQnK7CUtwumOK6fqo6F8fCY5dqGqztBIfNfa0udEGOVkiUEj1r4dew?=
 =?us-ascii?Q?QurMsWpQrgM7ATvnLe/KSCWlk6VjjK8ZNlmB5lQy2t5sdVvziyhdtWmO9wYH?=
 =?us-ascii?Q?PsieQ64SZGE1PViDLFUz5kx1jhQYnz465Sz4W6gVJ/UtmJxns0DgHPHEvCCA?=
 =?us-ascii?Q?MOeiWyimhcWL5VKdjX/ku0+ArDzLtuWet8wIEinZLdTq7L2zmJazZRS4n/6K?=
 =?us-ascii?Q?c5N+CDzqtyWM5ZFl9Z5kBy0IisWzqJYbp5e+m7xg3pOliowKro18mkbw7l+s?=
 =?us-ascii?Q?ZtujHiA3XOQ+1SsA0QtVzssKmONYWEhqW4tsvl0hGa7NS135/U3z2F8zhf30?=
 =?us-ascii?Q?mxrkBpi6kmnOn/Up9mq6KnRIdojje5ANLH6Ahub6irvF+CTMwmCI//I+kAE6?=
 =?us-ascii?Q?hCTx//huYLH+0FNSZCj6YfoFNYNHZ9LsD2vkdB2P/UfE9uaFvjFAkpLJf9dH?=
 =?us-ascii?Q?NYZpXkTm/dqD2RU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dMNDG5NjCBmvdZYzPM66T4HUcAG2yg7kL/y5kRwMAcrzADd/ynlYAJg6zsEz?=
 =?us-ascii?Q?n/ZMhTuN9rYvEPUsS+k7+hmxpq5T6C6TZ1YciDCdh4CABphCYffgoOxqH0s6?=
 =?us-ascii?Q?oYpqUOkF/59k8Febwqui9OfHHwnKYkT/DWRZArTgn1L3PUz/3QIJbB2L7+mz?=
 =?us-ascii?Q?hvOoRDjbq+DZ/JSaZQvu6TTAcEJHOLLmZALKJP5PIfo93O1PuCKw7mJ+aIG9?=
 =?us-ascii?Q?s4qcCeOxu22QLgz81uPGY04holA+S9DKz+Wmyh5e6l7eQ48SfzdZsgURqi5V?=
 =?us-ascii?Q?gv5MvfrF9gK3ytmwujNgk9V8SwYeEUQVcEBDJIxtuTc5yPwaghLkVDmLYsYz?=
 =?us-ascii?Q?gK4FtHQGBcrmQWc8jAaHKSGW7FTdd4zW1H0oeFD+PB5AKYLct49C2SX52YIm?=
 =?us-ascii?Q?S+b0pFC5mApYfnsn1l8gestyAlJ51CQvLcJ2nt911oHSrPAGHY9REclG+qFy?=
 =?us-ascii?Q?F7gp+SkQ4LwkLXzm4vmDAnELdcz/VoxKkY/HEgmzGo5KDYa0oMs01NFkU+Kw?=
 =?us-ascii?Q?gWLVyD7/KOv9JVOo8FlJuapbCh2nlMqaugSVZVnJjZDzdf7CNddwiTjwcVRg?=
 =?us-ascii?Q?jSU1PKnx6ohCCywWoLfv4nbfaH0oh8tpwJZjy7hSsIE3gGOLDjo3ry2MtbzC?=
 =?us-ascii?Q?J7dMfBYR3TGROiMD+EV8FIgl4WUeUysOGNpYkpX2N3B2oY/cqze7ZKM76GFu?=
 =?us-ascii?Q?li8QcWBxBPW0iYxDNyJosTxHFW0LuR7o8uof2+poXYi1ChVRNSLLMSVZyEjA?=
 =?us-ascii?Q?lRrpKeGi4TxU3TSaNXmyA6O0VPp3xXsVQpGrDu3Pbc+Q8fPPrBD9cEVVAL3D?=
 =?us-ascii?Q?QZW6HOudCSbKz22ihNJF0su6NrZu3CBw+MAlPEg2F4QR3SL/EPBjZkOQvbR9?=
 =?us-ascii?Q?/NrprB6xRTfuRmEot8hwxfDDhs6IOTB/zeOX9sDwLUpPwwn0kZkCa8PU6l8u?=
 =?us-ascii?Q?XP7WSrz+/qkde3Y5yhNUjCVWoPnmy0QvjE6M4JPzje/0vudbMa6ZpgelYRDI?=
 =?us-ascii?Q?WPV4+F2lR8Enffy9lyvDy0QktU6eHolXn0g7kBJ0wu5r6Ll510wIIBUkFKCU?=
 =?us-ascii?Q?aNMCzDHEw1eBmPelkszp9awTmYmcNhlRtWncDxYKGH/y2wkFgBT7ZaGO1LqU?=
 =?us-ascii?Q?bi+kwhcLbHugUmcW4yijw7CO4FWvBWXNYNtbEjI9X96gL4xN21qBi10jJJQW?=
 =?us-ascii?Q?Rbh9hmxDJ5vbKrlOGq+JbHhiPPHqrIB9aOuZ2x2rQVoBnLTL3gMPyZqipYJz?=
 =?us-ascii?Q?1UNabTYZtCa/J424TPyt20E2djtDPQZB9LBcZIRkRbliLzuKgbLmvbqHl0KB?=
 =?us-ascii?Q?A2L7uXLKfKUhuWxRk+P1t6pE7qC6oX5aTmb2N1anAwtQ28YVvt8agokD4eMT?=
 =?us-ascii?Q?LzeRkP3A5GC+hEmOtZzyksyqdXx2fa9aOti/Zxz5uerkeQ0xt/m8Ixb2/n0w?=
 =?us-ascii?Q?AdUMVFGXbfPcU05kfuO4mS+sQG5pxJBGyEy4upybmBrPqvnJAaTWPa5B/O/5?=
 =?us-ascii?Q?oDcIKIgkr0OONi4nRDAhV79FGbheNFEEkMgHzl9jMDwSBlP72IlCcfVs8pOS?=
 =?us-ascii?Q?6GiB1CgVb388DFAy9PjrTv9XBj55t27bIpikFul3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c01317-af10-4f30-36cb-08ddc33353f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 00:05:37.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dly9D+4BDDqNZn0sMkXPGq/4h74g0iKvJw2aahqM8Dtv28TFct+QPuIFDPIIzrSljj/igusoriP6i9XJI1g7RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

> From: Mike Rapoport <rppt@kernel.org>
> Sent: Monday, July 14, 2025 10:50 PM
>=20
> On Mon, Jul 14, 2025 at 03:19:17PM +0200, Uladzislau Rezki wrote:
> > On Mon, Jul 14, 2025 at 01:39:20PM +0100, David Laight wrote:
> > > On Wed, 9 Jul 2025 11:22:34 -0700
> > > Dave Hansen <dave.hansen@intel.com> wrote:
> > >
> > > > On 7/9/25 11:15, Jacob Pan wrote:
> > > > >>> Is there a use case where a SVA user can access kernel memory i=
n
> the
> > > > >>> first place?
> > > > >> No. It should be fully blocked.
> > > > >>
> > > > > Then I don't understand what is the "vulnerability condition" bei=
ng
> > > > > addressed here. We are talking about KVA range here.
> > > >
> > > > SVA users can't access kernel memory, but they can compel walks of
> > > > kernel page tables, which the IOMMU caches. The trouble starts if t=
he
> > > > kernel happens to free that page table page and the IOMMU is using
> the
> > > > cache after the page is freed.
> > > >
> > > > That was covered in the changelog, but I guess it could be made a b=
it
> > > > more succinct.
>=20
> But does this really mean that every flush_tlb_kernel_range() should flus=
h
> the IOMMU page tables as well? AFAIU, set_memory flushes TLB even when
> bits
> in pte change and it seems like an overkill...
>=20
> > > Is it worth just never freeing the page tables used for vmalloc() mem=
ory?
> > > After all they are likely to be reallocated again.
> > >
> > >
> > Do we free? Maybe on some arches? According to my tests(AMD x86-64) i
> did
> > once upon a time, the PTE entries were not freed after vfree(). It coul=
d be
> > expensive if we did it, due to a global "page_table_lock" lock.
> >
> > I see one place though, it is in the vmap_try_huge_pud()
> >
> > 	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
> > 		return 0;
> >
> > it is when replace a pud by a huge-page.
>=20
> There's also a place that replaces a pmd by a smaller huge page, but othe=
r
> than that vmalloc does not free page tables.
>=20

Dave spotted two other places where page tables might be freed:

https://lore.kernel.org/all/62580eab-3e68-4132-981a-84167d130d9f@intel.com/

