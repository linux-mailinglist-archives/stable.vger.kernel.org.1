Return-Path: <stable+bounces-109503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3AA16980
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF651885A46
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB81B85F8;
	Mon, 20 Jan 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYcir2R1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80351B425D;
	Mon, 20 Jan 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365197; cv=fail; b=DsawAk2tMY0b5J4vrU3cjA+IEm5UgtfnX5xZvCEz4aslCw1xPvOQFfIveO2GrpHg47rraPDnEC89ug7kIqRq3NPBbq2HdFOzqW48iARTGuptza9tR4P49qCVOvDPWATcn77T/KVyteWBeDcVQ27DT5PdYVnTrwyg+XUYP6o1MDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365197; c=relaxed/simple;
	bh=mO+Ck8flfDKEHC3TIoMshroDW8I2UD5aHn8zgYHY8ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUeQlaZSg5qBAaSfMfosIGR46XCETfEXNvbGIDB0hnYcUTeWYm2QPx4JemJjwrsTy00QAboKI55L8MAeuIo0LG3PpAe0Hp4yXNrQ4vLk0nK8nlcnXUQMp9I2iomy4esNoPoCPy9X8ssiCCJOcS3y8Df8tpp4gUGvosUF9gUkhq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYcir2R1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737365195; x=1768901195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mO+Ck8flfDKEHC3TIoMshroDW8I2UD5aHn8zgYHY8ks=;
  b=VYcir2R1/MavjWOmNQfEvy3P23xVSJfKO+SUuH+fwXznjJZrbBJ854Lq
   CeM1xIcmin+xe3GvVKKjVwWsZOasQfcELRh/jd4Lir4s/mXV/2sibUMlz
   91+FQxQvfPGcuKg1idXjJ2bVngMF3uWPu6xi+t/XQAdNH42zjuuVzhC6W
   ZsnNfnpWK2vee6CcknEX/DjUQGQndS9BVvHsBNKrCwfb05ko0A1KJTFgN
   nJYpJOt08hvJ1lGoL7x/MrEvgmI5BkC4MCNqLScusyLdDJ4KM8FHEJ4fM
   BTKukEf8fC8vwUGE6S0xq4MyzjNNeOO70O9PGQm/CDcbimInscYz8Oc71
   A==;
X-CSE-ConnectionGUID: rIKDMX3uRYiGG4jRvwAQ5A==
X-CSE-MsgGUID: AWV5JoT4S/mrikDOAQgMNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37764733"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37764733"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 01:26:34 -0800
X-CSE-ConnectionGUID: TgcRl0qWTrqxWgcyymhk/g==
X-CSE-MsgGUID: 3xA0yy7wTVSHK00RO7DOgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="111418041"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 01:26:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 01:26:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 01:26:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 01:26:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAYfXfd5WnVwz9TXWvgZtRMuWn05BskbrQoRuf9eH+/p/OxFUEI08nupGEAqf0pqtOyt7NKNunodEmsLzDVc+dJVkNc6FKE4XgqEi8M2A2H6ZDJKiq6pcTv8V7gW4wn193fk4rTejvlOYN+TL1IRvP9zE6OlqFh6DhVMkSvek8g1awZujdEny8wqmEnnFX20lAJGmI+54XB0OrlMiWfhH114lCbQ5szohEjnlDFdCalyMxFYfL0Hof6dr3gX9N/usd+hhNKMVodQw56Wv3gawvxm6eq8Onlb/wrOwyUxzhIfnHG79PWQ119bMvO5JB7AWTXTyj1wTZrSVc85cRwtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMYl1ff7oxExI6GR5iJdwKiWg616YMaCWVuIyoLKp5Q=;
 b=r4Avv/L2NYER3B1V3/7+cDlbQ1n3iHGqrBJhKfeVcyom33Hfci7pKClSAHOBuOyjT85lW6DPnylwKeuO45Tn6Q9Q+6Nj61ckmY8c8LO97rl3JM/Fy1iHIsO2skz7NdrIs6W2Y15mYyIJVSX6/X31I1JcPFzeSRAi3DLB1Z3KEhY+Wa6V64eg5hSb6e1eWJsj5QZnVCHzkJ/WH66+JzxHOFokA+LhwWwT+FOh9rbuy1AipBwZF5ZzII/GK2oCsZZE+wki3GYW7zL9lm6jGGREpPuFugZrWhZDYivw1o+UhGUPaW364xH5BjIkoeOaqtj1+X9OQSaCXdRJn2uhe06Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 09:26:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 09:26:30 +0000
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
Thread-Index: AQHbaxGTh2pAwh/jgkuk7k6RbQSA8rMfY7ug
Date: Mon, 20 Jan 2025 09:26:30 +0000
Message-ID: <BN9PR11MB5276B3F78599A00476AA2CDC8CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250120080144.810455-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250120080144.810455-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: e0f9b5f4-2e95-471b-aa96-08dd393485f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?prBfG11DBDjaC8pNVf3OspiKKSWom9YfLLa38/8q0N81Dz/oOac58IXJqCIk?=
 =?us-ascii?Q?Tv/Y4ofwoRGqJrwlVL2jKFnvvCIoHJQi/+C1+KkEMWLprSwU+0XqC9La9sPn?=
 =?us-ascii?Q?mH64uFgco2qkcZt7qMRgsIHwFsKRVFa59PkgH1WcdXDF3s3tl+JqfFeLnpXv?=
 =?us-ascii?Q?ZART6KjNVeFABd8h/aVyNGwQ+7HCnWqHOhgqznoOiAyRZroYeCdAi+52L9ud?=
 =?us-ascii?Q?18cAyNji7mW3g602+0nXInW+ea49nIx98sNyELDTjsn4+0P3qoRis90WciKF?=
 =?us-ascii?Q?KOwLv0251QV7m4uvlTtzFw05nalWdMtVAwPPUCoXGT04ago93Xb4/FdttgYt?=
 =?us-ascii?Q?MJq4KWdNZdLYD5/X3z3aYYXXnFEWSdV3Q2+xOwZP4OW2PEzYRizC/21HRbx0?=
 =?us-ascii?Q?kdN5Cd45w6IZetpCuk0BTmSRDHrUFt8oamGBA2jpUFDb8ji6C1xbAlvJp/1x?=
 =?us-ascii?Q?D02LYVNm6urhezwtSeWbn5VmBYvU7udqCKHI/ylsk21D/s9dW+a1J80va+au?=
 =?us-ascii?Q?4kzm52vV3yYr/3t4xMIFmRtgtdBStk0uravpHcm99xMdIpeSwBPK38VIw52f?=
 =?us-ascii?Q?3Jhx2ihnM/D09HDGXJqyzQgdpjlR0Epfzh8iehb7s4TmcREDcJW5M1H7jtkU?=
 =?us-ascii?Q?kqYXUcSSWr5N6hnDT+oz/Uw238zhM8C4TdM8vajNZzDBNLa7ETJgLB4i7izm?=
 =?us-ascii?Q?qzV39diyuHYsbFYFby5f5BGm6jcX2AhIZFco9Hsr54REhYC1pXR1cJ3TOtGE?=
 =?us-ascii?Q?XkpPQGZAdjEvE4/rd/W9Swojsry8w0aIFwWwVZgZELW5x79z2qfRa0WcOmYq?=
 =?us-ascii?Q?+ymLwyyE+e6YvEZqsT5JVP0ZruwhirVk1mIrWft2L5Jy/qMatc94AE4GZCVA?=
 =?us-ascii?Q?zIPxBgcsQExpGlaS2UPULMWyU95/RX7MM4ZbL1wjWiBIJzp/L7B4cu//rW8E?=
 =?us-ascii?Q?1Z4YzO5wt77O/G0z3J5inAjQCHmzJviUhFkDFKWiWkhpcn4tpdgdRI9JvNvN?=
 =?us-ascii?Q?F4xgYO6p7ElYOGr15bwjTbgkSTHEiVjTH3vh8zAAT7UpCktq0fttXVVU6oyI?=
 =?us-ascii?Q?tpSq/jzP8YgkJovU/xJ3CmTNq0GBjdAPmSToVu5A04KriRVh2HvbpDPU+GAg?=
 =?us-ascii?Q?XTyql6uqN1f3s8Cwh7pt3VuEgTRiWWD5/6jYjJbOO14eDRUBJrhU/jR7SNxo?=
 =?us-ascii?Q?B64voVfZ3t/0ga6OrDayw9Hronsab+l45KQrdqjGdtBzfuCK4BVbucs+sNHp?=
 =?us-ascii?Q?91oqzdGWdsAtN+YT9W9D/RjJNbYj1m0L6lhhbhW84w8kvZy20bpy7f2xh3jd?=
 =?us-ascii?Q?Em5KVJwbUcEEynCbH3PX2JCHkGR0+CZipRPkcRm978paL5wc1ZaD4IQeCKyP?=
 =?us-ascii?Q?sYgbo6xG5e9subA1PysNehOcnUUut0NvBDu1BAxjmptmsQb6zmvrAvFl1uL8?=
 =?us-ascii?Q?MewnmMPaSBSOBCJJBktntbVNeO4Han05?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YyH+VoYJWbxGki69ynhPE/WwcyQDmTxMjMZDJotxAb6QFmTNjGiAyqhgTOix?=
 =?us-ascii?Q?l8Wp88Co3vnOdS2SZFdIzFuWLRndeMXhs10UcG6H3XwjeCvLh8qPZZlP1cYi?=
 =?us-ascii?Q?w8LagqmSVO1Nqi2dkpOM+O/VXRy7hXenbHdeG5ulFhgLCaIvsevkpZMQ27qM?=
 =?us-ascii?Q?tFz2NMCdd7s6wrbklfOxhUJzowRlzwS064VfL4Xgta/lTMuOUF7LZBjwPGW3?=
 =?us-ascii?Q?43BX+wvmBhPoEmCAYT7U03hlJV2zvMg9EN2lGSXWzxht4oCcanmrVfYNrKLb?=
 =?us-ascii?Q?m8wOg9cAJuUrdksoQwFNkT4YjPdLxEfAN5zZTWVQFbJdBVXQXR/95SRqVSfj?=
 =?us-ascii?Q?Rp3VSA9skjP7L5th1w/z9iT5IMl/vjh6LGUr3lbFBD//mv85Y+5e67DM6/FL?=
 =?us-ascii?Q?ez11/QcKV59THSCAe+hmsUuCC3Bmr02+WZMPsrSbeM/ljimvvfY2XHzzaRM0?=
 =?us-ascii?Q?UBYrSOehJI6w3aLQ2Vpj8/6kUIpwrKrptqNRsquJ6jAny5nwEZyOsa8gQywP?=
 =?us-ascii?Q?gD1YwkSQGbasiCH+D5JSLauruXRDhLXNM0j2LgYVa4Cq/kYp7A0TQyh1u3Qf?=
 =?us-ascii?Q?CVfQjCyG4IGgJ25pTOkkHlGDOEcsnsorexiHfNInQXNA/QYlEBhXhUo2K3oe?=
 =?us-ascii?Q?VuxzQ3yClH5hzcaeamC4N7OGG0513Y8kC2GDrl/FztOkl5glVaCuZhge2t/H?=
 =?us-ascii?Q?pKVbdoD1WUxHAW9CxSo0hC/JOsKLP0PugZCACHNo1waKbgCZGmUd9+SvyjhD?=
 =?us-ascii?Q?dTTNJxEzOE2PcR51Gbjc6v3MrTTZI2jg4NqYErOCHWqMVDP+fxf0EwbB5FgL?=
 =?us-ascii?Q?F6+CSwIjFLYj52977m/QaBAdCs8bHEM09ey4bfjs7VvqK/ejVitl93dpbhGE?=
 =?us-ascii?Q?B4qeFwGS8hAQ6ci+ynPRY6hCb/JtJCGhUs3iRpA2A6MxDU9vVLRkEKetBDLm?=
 =?us-ascii?Q?BeZNY+RXofNhbXRKaw/lqnh2nbHUejgPCvOIz79oxM9qjjt0JWaW+i0sfDG4?=
 =?us-ascii?Q?k8pPa4QtH27qm/bNQqnompt28tFN7ubmqcP2xVWL+ix1icGXcj0Zd8oHTAUI?=
 =?us-ascii?Q?YOoAHduhhVsm9HvcqeEuZufx3PAYu0mbFqayWZFEVdFDklwzcVJnw2rudsFU?=
 =?us-ascii?Q?owBuXmTpyQQDs5m/7tfzQR0sag5CGaIValqCDt+jPOo6s/JhTbCUDCY3h0Qj?=
 =?us-ascii?Q?ELMw/QA6s+NKvS4oIzQ7WXHNhdR9MjI/YwV8iJvoEIvRkMEaaSVZsKujBJNI?=
 =?us-ascii?Q?htd/VnkaGV48QvgqdGtvZHyGmDItNZLgfFPnu6y5S0ejF/itJcC0FyRh7W7h?=
 =?us-ascii?Q?qtx0jzBH9Z+i+W3SDSH8o/cYRsNoU296s9+71Khrj6OAxKz5yIozVd5qltki?=
 =?us-ascii?Q?/YRfRAbzgZWfFnTlaFfXD+1B0HutTtO6LT0Y1SPU81HYaYYfNMuE3nIdnPp4?=
 =?us-ascii?Q?LMlZcUSMJKnOha/gJz7qVA8eaGYC8SgUhtXbL1HH02Y2QRPcoOk8FNM68hjk?=
 =?us-ascii?Q?yX3sqgWRys9Dr4G5PWe7xsVDvXP7ptGMFhPSZplrQSOrLrMKkLx9yQTltLQL?=
 =?us-ascii?Q?YDf0sG6Fh/Rir45jGluVwXBy3XFkvpYLrjET9THc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f9b5f4-2e95-471b-aa96-08dd393485f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 09:26:30.4765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeOTwvMCDl6smmME6KwuPx8dmv3XfvsEDwPcshuH9AZC2XgYYMgLH4fJ9n6aX8lq/KFosGP5DOpdqwPdgqzZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
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
> ---
>  drivers/iommu/intel/prq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index c2d792db52c3..043f02d7b460 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -87,7 +87,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev,
> u32 pasid)
>  		struct page_req_dsc *req;
>=20
>  		req =3D &iommu->prq[head / sizeof(*req)];
> -		if (!req->pasid_present || req->pasid !=3D pasid) {
> +		if (req->rid !=3D sid ||
> +		    (req->pasid_present && req->pasid !=3D pasid)) {
>  			head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  			continue;
>  		}

Ah you'd also want to skip (!req->pasid_present &&
pasid !=3D IOMMU_NO_PASID)

