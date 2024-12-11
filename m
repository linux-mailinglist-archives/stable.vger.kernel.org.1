Return-Path: <stable+bounces-100539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6149EC57D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED76C1889FE6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AEF1C5F0C;
	Wed, 11 Dec 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PO5GgNcU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C31C54B9;
	Wed, 11 Dec 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901702; cv=fail; b=JQf/l0DqrWU3IGd7+ofthW/YwSGYlXAf6yKqalbRjFr9abn1FtZEv+oxCZ2syWa4962zOMh1QiMnDlqCDQf0Mx3McosZhiqSomZoo/mKoLZml8nOBF7vqm/0P2P6n67bT+LUVKpfRMyWEP1bua6bwi+kOs754eTsQW3QrAqMh1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901702; c=relaxed/simple;
	bh=PUt/GRIf4hqRwunrNp3jSg+J4tZjch+4PCeIIQ6YVXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMY+VMby7tBxBYDp5YFw9fJBe9ATp1aluytphO2hvp+ZZLSo07eHHAr3Bz8r9igjVeCUaN7vxlBn1b/Rf+/lTnEHYm04AlZ1P9h/JtBuogEvAow8yhSzXZQ+6d6mw8Vd3KK4ThWCaS6abaZQQ6hVINz9PLQhN+2v4n5A5MdXWdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PO5GgNcU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733901700; x=1765437700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUt/GRIf4hqRwunrNp3jSg+J4tZjch+4PCeIIQ6YVXI=;
  b=PO5GgNcU0qG+Z0dUwqGXtLvWZodGbHYg96n3XmR5FXkrKp5HDzCh6QCY
   h4+aF+FnSRnBZisGyeK0ZtP99cE6GWHBwGJIj6N6HkMMMmQigMEGXcuPk
   qRSY1t8m4GMn5izszab6ECEZ2virXvyDEfcv0WKy2ctvSjQgufTydWqMH
   0VbXSdWqDM8ATsGWUabwnnviq2JQ7nKIvjN7QLn8T0b3T8vRmV+YrtqB4
   r4jT+6k7YN8ZG2ux2LC7wrTLTMN/KZGArwhQJbhMyjY458Hvmc91X/Ga/
   +2ZYF9uUnFQJGhos/v2K5hasoubSM80cxGiq57Qdn1o9pl+K2XNS0RjKt
   g==;
X-CSE-ConnectionGUID: hgMz1QspRHay11Uued57JA==
X-CSE-MsgGUID: X/08XE/LRaeXS325QL/tpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38199432"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38199432"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:21:39 -0800
X-CSE-ConnectionGUID: qcPvFzMvQPyyhRWhPvdZEA==
X-CSE-MsgGUID: IH/gOpgRRr2gAkOYxiN4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96172674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:21:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:21:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:21:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB58Z5VHv95i0sqYj6mns3zrSLibG38JVxZ/i1VcbaetPqyRNABB8B/Bos/LD1fOsrlhQxrqn/cNLUvuR14TqDUogPPOr8jDYbr2sN1Rpkw3Y24VhvSE1ZmA253c+QCMrOJnPdDndmtusvE0LMluTOa+QmTl+IrXwoMObjgxAtPqImjcIj6hHRvgbtosEzhxCfIdTvywi9HyLxF539u1Oh47AGcOEVDoJ4Bu2k9tUrT/ScRZlXG/i3srxAJl/70z+iPilA+DiNf4Dh+Ff8qge2licUKGDbrPz1j+BF3iqFq8q7je/xRdgE1G/Hw0uFU2TsMkybVDvtuaejp60gifeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiIuD2WZ5SE7piV8dEWuGr5172UeidWW2hZsooPc04A=;
 b=B13xSQvU041nXb3nGOAvsfdzSKarUAy/SkF9Dz/2OPGNZaoYSjyKAHaru0w7eWubXdI5lC9hUZ8DFNiX7WkG+noDPrQbavN1/sQkv8Vv+KWR1wEWJ3UP4Ta1+dy0MXeL2m48f2iP1nI4xwokiZPmP0SY1jCeOXxWXhNpAMdVwdMLi1Eg6Ibkk5PqKH5Iwi1qRNCoGdUarB3isioLMPv9JsNiF1f1HDyXjXur/bDc5rMgcAUQGZYCeNlTjSjO9BTPM/F3FbBlWtF5bJOriY6Tur9z7OtnanxQ4De/QSkEUbbo72KcgFzFfrdYPN+wyQCcT44hvESFW22ojvaH3zEzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 07:21:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:21:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
Thread-Topic: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
Thread-Index: AQHbQgNTcXtiehtWr0+Kz5LMkuaPH7LgtcIg
Date: Wed, 11 Dec 2024 07:21:36 +0000
Message-ID: <BN9PR11MB52766D13B14053E5B6CFE7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241129020506.576413-1-baolu.lu@linux.intel.com>
In-Reply-To: <20241129020506.576413-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6396:EE_
x-ms-office365-filtering-correlation-id: c550c4c4-94fe-4028-17db-08dd19b472b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?136gvZX1ytwzpfxV7isnw+pcpLi0wC4FtjPyRAz2FbK+xmfHguGT7ghVmVzr?=
 =?us-ascii?Q?e/v2UsI6kxievR+/gLxzRLLFu6VabRehLowWC/5q030ZxEVgT9ZgazOc5Gpn?=
 =?us-ascii?Q?1YiTlJq3VZqaPpe4fzbPMx8rwE4l2/Oz8P0d5BGQSgMy3ovdOqBUJ4ej1c5z?=
 =?us-ascii?Q?jJppA/M31BqZ5aFdScksOv7HjAEr4lsUAIT/D+wTIIB6kbudHYxb6BgbdX7L?=
 =?us-ascii?Q?ZFnm47o+sUOnfuu6FJGTgyuIRbUk2A5Ozq+d/PHG0ooSyiCKZ+sJo4dI3HgO?=
 =?us-ascii?Q?ek1Caoj72/XSuUIqxfPO176Gh5+FVrjwOuf86U550656zqc58GDuTPmWQZ/1?=
 =?us-ascii?Q?ra9R80C+58WiuP5JxLemCt5IxPHi5fl3eqq35+U+Vi2c5HbLFGjoIqkfWcEy?=
 =?us-ascii?Q?Kj/8NlbLdTmyEZKgcozKGzkJmZZIDS5KsOfRsTfBavO4oZAGqo1Uu5NYLR9r?=
 =?us-ascii?Q?gwqOvneqwPhCpUTIbYvKyzKj1QJ46NCnLkPiY5CC6zZcQf8+0l4enzayV5tG?=
 =?us-ascii?Q?wsVw4FniETq2TkxrudGSORBFXKK4YegOEd9ZGpFzdEiJ825J+RxYwnb8Xou5?=
 =?us-ascii?Q?jtfvcRDWcT+B4c8j4z4UD/LgiA4AhJIF9c0/FcebpfEhI2GF8c9sTjgInvzr?=
 =?us-ascii?Q?Szb6UOTE+Tm7J2JOfXLTG2NWwDcUbZ8N2CsgWUw5k7Fz7Iveh8S+j7teRwUL?=
 =?us-ascii?Q?e0BAmsnil59Y70wHg0g02L4m6vtNTVisleIr+TQg775Q87Z69bk1Sx/rNC19?=
 =?us-ascii?Q?hdJt2UaLxB2Yiim344yNDqYgGj35vUbXiL+xXzoSRKXQMO+cxnS/ZU4t9goO?=
 =?us-ascii?Q?M8RbGPO7WRu0JP9oYYZTUWF8i2TSVrpG58drYGeCiVENxj3O2ulhhA1QZObG?=
 =?us-ascii?Q?bpVsYu/Y8UzcxvWoxBtz4wAHukFwpNfFv9V4OrA8UVKKBv8xW4wb6eRQFj5c?=
 =?us-ascii?Q?hrtvfubO9jmjjVRQXrwZ3UKWiZaLD/COro0vG929NMIKbLTFzSUq+jxHVAG9?=
 =?us-ascii?Q?I6ljJhK5zHZ8qqg0GKEw6JY957GSlxOebA9Hf8ZF4cWI9+TslBTZqec6HoaJ?=
 =?us-ascii?Q?Tmt8FVEwe5MfAp+ppN2gpE61M5wdxZiebtsY8m+QUbSs6SRgB3SsNtnyV/cf?=
 =?us-ascii?Q?BFXmaOxk6pUyj/8E/5ZTfaxP+MBUIR7cKKfijuY1t6RhKR29ludfClXNktGf?=
 =?us-ascii?Q?3JDBXGO6T/S/piK4YjFncbGjgQqCcRJbtqeZPDGKIVYFCT1fphmCD+wCbfEK?=
 =?us-ascii?Q?RB4BS/UfLiJI9jHBAArvPDWLc8CQYN/y8izYSTUlxMhYfIz7q8ZFCNBcEGtY?=
 =?us-ascii?Q?v8K6B0sWpidCih9sPXhTiFt08BSiA2oqHks26VH9ytLSynB17V3WFXro4W8F?=
 =?us-ascii?Q?jooPUlKwuUQM8MWdXwZ5mV+DgYQjAj6wrZu8vqMs4KalgwNSMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXaMCYEnfEorubd7wNCi4gwm0BtIEr1ht3dIn2qWyWdQWx5E7+4tYuv0ob1f?=
 =?us-ascii?Q?VqG7ejOTKyyjCunKBKSjfmG/99q5uPiKO263GJknHfwjNws7QQD4SZutZlMd?=
 =?us-ascii?Q?rKZPAyKsEQVTbKqxX20pByQlQhD4U/OGQEOxC3Hyo9ThNTly0l6SYZcuMrQV?=
 =?us-ascii?Q?f2jP3fWHowScynn1l7Hjo14Bi0loRz+3HNyd/Siz+nmkKUtqXeC71RrKmCP/?=
 =?us-ascii?Q?qqUzsrQsAE9N8AW93A20W1mpgxS+8QtTDa600EKmrJr5z+ylXZkPjmnII0fY?=
 =?us-ascii?Q?MXYyx91A3mH6jxPkHP6wU4GnPAa7F56wyLBixz9TER6Ey2mHG3PETC2Be7KL?=
 =?us-ascii?Q?WjTM/aIc/dT0xakICvgCtUcMI3wW6FpTHeNH7s671LUILbj7QUk2GGf0VbnD?=
 =?us-ascii?Q?iW154Hsc9RUVUUW2mox07UiYlFpaeZKC7fyGsq+hkfdEBJqXS3kanaedg8UN?=
 =?us-ascii?Q?qfa8IgH8hSa9Jhhtg8ObTAF5N3ztrH+7L+HTe04+Sr2fk9/Mnzh3s26tB3XL?=
 =?us-ascii?Q?Q2cBHOzcIm+fWXQRUohLnfHXPGWfnN/CRse2p5rK5PudkczELZl4sKYmp0LH?=
 =?us-ascii?Q?7roVcGBos2K0UwcY2z5yJbWJ5moWdRIXW0P5jpMMHGlTrlOhsNVjDRJ8T9V0?=
 =?us-ascii?Q?KTXttQeuuNgpKT/tpPn/N5ZuUIxcCEorVmH5BDy0w3aP1Bsixyjp9WzwhMSq?=
 =?us-ascii?Q?VmBWaANHNoAU3hEctD47375BPicUvb+0ifGjEQNVU/FJi7/w8AHT1EFLLd7R?=
 =?us-ascii?Q?iiEpVlJdg6jMDtp4oF0dn6UJQHS0A8fp5tx1MT7eCw5mUiwnq6K+ZVZ1FErM?=
 =?us-ascii?Q?/GaY3k71KfW6TvcGs93ohYPx5s0mE4elnDNzXSfZ62GEj3NXUx4ZlK/FpelG?=
 =?us-ascii?Q?pXjjOHVIYNrSWlY09C/e/4d4gtRdHtWs+bAUxVRN+Yb+O4bVbOoDntx60mJS?=
 =?us-ascii?Q?TWar4MKCHNJu533nYs3NCc0hSThqqN4EowLECrFVSy+WMn2NCPOEofjQpFPF?=
 =?us-ascii?Q?DOVdVW0j+Qy+rlqqnny/7lxsBwr/iUPiDFaQxs7AHvVuhHY2IPFXS7WEZDJy?=
 =?us-ascii?Q?ZW3ezIJtzVRoXfde28neb4X8Cfuz6G2clZlqpoFY7Tfz494MqPMuLgmxLIKs?=
 =?us-ascii?Q?H/Yb7c1JFbR3fx9xHIfBdKI9Gz1PDd9SEM04jAPJV8yHjAP4BQ6C76TgN5l6?=
 =?us-ascii?Q?rgQNYFR+QTyyxixoFTEEaWIhAe/PuGqWVEyLAySL3oyrynBK1LgwAxoJbU0s?=
 =?us-ascii?Q?dl6kFHEUoS/bNk4l43sxvQAcSzQVjPdUA/lBsMLejHQMfJuxGNkTI59Oms/K?=
 =?us-ascii?Q?2arb6xDmdOLnVW9/ebwiTsJNVJuLGSJ4SGmPxy9eoI82gG5PFR7pLjNa6G4+?=
 =?us-ascii?Q?4kQ0stp5zbjhU0/XVHdprWefqhOwF1AzmVgXmbAgNXpuG1t6yYMKETCPgFDw?=
 =?us-ascii?Q?+sMYj7OI7PPSRGcr7bfXKer6D4BwGEDnwJDw52NXyMwmXc5i5LzNjNcpbtX9?=
 =?us-ascii?Q?SFTfzAF8TrC+Dcm25T+WKkLUzVFIP6vEw4TGylmDCsOdZ9oiUPCG96S76lpl?=
 =?us-ascii?Q?WV+uFTLoKeCTCqvz8Z9ItRSuICa7ZuVOgXNXq1Ec?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c550c4c4-94fe-4028-17db-08dd19b472b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:21:36.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEsFRzMV3P4HWDbOz8xf+G2CrVqy2QVl9dUVmf+xnN+iqSwKJm5E4Ai2R4CaJcClfp/x9tKTHAGa3UDSXKYGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, November 29, 2024 10:05 AM
>=20
> The current implementation removes cache tags after disabling ATS,
> leading to potential memory leaks and kernel crashes. Specifically,
> CACHE_TAG_DEVTLB type cache tags may still remain in the list even
> after the domain is freed, causing a use-after-free condition.
>=20
> This issue really shows up when multiple VFs from different PFs
> passed through to a single user-space process via vfio-pci. In such
> cases, the kernel may crash with kernel messages like:

Is "multiple VFs from different PFs" the key to trigger the problem?

what about multiple VFs from the same PF or just assigning multiple
devices to a single process/vm?

My understanding from the below fix is that this issue will be triggered
as long as the domain is still being actively used after one device with
ATS is detached from it, i.e. sounds like a problem in multi-device
assignment scenario.

>=20
>  BUG: kernel NULL pointer dereference, address: 0000000000000014
>  PGD 19036a067 P4D 1940a3067 PUD 136c9b067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 74 UID: 0 PID: 3183 Comm: testCli Not tainted 6.11.9 #2
>  RIP: 0010:cache_tag_flush_range+0x9b/0x250
>  Call Trace:
>   <TASK>
>   ? __die+0x1f/0x60
>   ? page_fault_oops+0x163/0x590
>   ? exc_page_fault+0x72/0x190
>   ? asm_exc_page_fault+0x22/0x30
>   ? cache_tag_flush_range+0x9b/0x250
>   ? cache_tag_flush_range+0x5d/0x250
>   intel_iommu_tlb_sync+0x29/0x40
>   intel_iommu_unmap_pages+0xfe/0x160
>   __iommu_unmap+0xd8/0x1a0
>   vfio_unmap_unpin+0x182/0x340 [vfio_iommu_type1]
>   vfio_remove_dma+0x2a/0xb0 [vfio_iommu_type1]
>   vfio_iommu_type1_ioctl+0xafa/0x18e0 [vfio_iommu_type1]
>=20
> Move cache_tag_unassign_domain() before iommu_disable_pci_caps() to fix
> it.
>=20
> Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

