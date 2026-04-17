Return-Path: <stable+bounces-238446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN4UIlnm4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F174182DB
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69CCE30AD517
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F21366550;
	Fri, 17 Apr 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpfoOwGx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314336604B;
	Fri, 17 Apr 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412144; cv=fail; b=YeUPt1Ap4suXYkVIZ8kL8T19aKepQRYJyGHFBC0y9c0F8imFirQlOTMmNIbAo+YBQiWDnvku6cIS1nbn1ScGig/nTY8Ilx7wcJHNX7fNxYJLdfkEdiedK7qSMd98I1RTNhPvNeRuuIByOL/fpfTP/PEIzsMQtvGNFCa0aOjTXE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412144; c=relaxed/simple;
	bh=MbtHiKAP6jhUFRpSINvwmRN/OFPwwB1emiRO3ThdBj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nOPzUyKJ7vlsvFkeu0tdUuZ5HNxcFfb6FeA+vn/3pm/gNEbYQFdBSiHG60240kFewL7hiaw5Gxsl+OifcSnlYMFLzPasr3Ht532EHK+Yol/o0QVEpdF+op40/BXGf2G5rhR/UqX/6GB/OEnPnxfpL5LUtaBldhJX0wL9YRUoz7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpfoOwGx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776412139; x=1807948139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MbtHiKAP6jhUFRpSINvwmRN/OFPwwB1emiRO3ThdBj0=;
  b=LpfoOwGx0Eucq/NCake4/SCSwK/qol7U+6SEpTPEyUjAi89ptaNDOpbC
   2JwTEA3zW+pwwbodhI48jBFd3qIbZ7xKSqDBWDKv8VhueIrh/v98o51e/
   1dR7bKU80qwOLoG/KkuzljFDR3avIic/wo0WQbgcyp8LWfTb2liU/IFLV
   abDjfeOtlnGNvSlLU+u/OX2lt4UTU/yC54NvkiMW61An3ML2zU9oibdGL
   cMXSRDODQCH9K+WPqPVhf4bzcPpbiKOuWtbABOlsXSUYiqyBnP9it4OdW
   SjpfWFbEkaDXwamlsYqHXbJMVnJBL+FmefHZh+zfdwpv+px1s2Wna2Vbl
   g==;
X-CSE-ConnectionGUID: yvt1WMmTRH+9q8fTlwcawQ==
X-CSE-MsgGUID: 3cDhQLcMSg2IPmyBrMZLLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88806882"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88806882"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:48:54 -0700
X-CSE-ConnectionGUID: 8Dsj+vdvQdqvWJn5d9n9jA==
X-CSE-MsgGUID: 9rZRqAf8RKuLz9xxPNdIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226614478"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:48:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 00:48:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 00:48:53 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 00:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpYhAzFi4HlN1MJzwM36eun6/oXihEkGRsQ6S5P2LVmRKOZTa/2KbABSZxPhZwcFxi6gL3Klg0j+hgucMPDH8WQUI5L0mcPSYt212dGmP3GQICODk5fW/qaCTp+L0OPX0R2BzAKuRcweqWSLr274B5+lR2XqrQFHbNd0O/h7IXUuVv7ywuLVtkBBaFb/O0W7fw8SGUAkcdXi6tWHTgNSzhhENya1vbEvbdTKrCO6MhU2PdPm/3s+tK3BnttDz2toVACrvqn+XgHdXNbKGzQ2kcL7mX++1WYTqUv2Fl6aUyfW2a6zmQBr4r699ZYN4cWAAXYhUb2GNBhnsmBge0if9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zed2KxeqHQf/hqIIsV4OPmOshq6obcm/zwz5gfMF4I=;
 b=n8Sw2DriBDg+jfdNsYVew85tSzYGf1/MqnXm5DWOlpfHA+QQ2/yQmcwJC7bS8xQsrj38r83J0pWvXqP01uLsyA4iSRbHQFwp/9r/YgLe0W7P6tqKxOP8oVNSId610jvNgmpDBD6Dq1MwS9BMQ/qRzqRNdKN6XUtC4Xso0NNi8+mPTZvBWh6Db6Lmq9jTEZF2c1mGPu3AFS2BPvCD3wYpu/45tC67aMqKR5PGVJjeMKHtJ2trLiRBsdEipWIQ2WNFSkPzvjCSckUmx13WQffCEdlcI7/5v3qcMuVOGHJk+6Y8Uk5BW6uYVVja9iYOKQhOBpWZERwMOF9lxgHRaBGgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 07:48:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:48:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: RE: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Thread-Topic: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Thread-Index: AQHczR1sEKPCjS3ZBU6Ku3g92e0vebXh57oAgAAIk4CAAPA4cA==
Date: Fri, 17 Apr 2026 07:48:46 +0000
Message-ID: <BN9PR11MB5276A13A8014C5C6403FB4EC8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <3eaf217f-8e1e-4d64-983a-6b888886f157@arm.com>
 <20260416172005.GB761338@nvidia.com>
In-Reply-To: <20260416172005.GB761338@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8714:EE_
x-ms-office365-filtering-correlation-id: 0c476944-a06b-4d55-6e88-08de9c55c148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18096099003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: htDw75oAmD//x09Ii4ge/B4EP/3RVQ84dgtQzsa06cpdhQy8XzxhXHKt9KdvbkoVUbr94Ei5w34QGxpM/B4YYRTdqXk2FGDBr1J8b7wSqxV+1AZO7QySiR6zw9CMfvGS83fNxUYB+vi0QZ+PqiN/6FvXL/oa7sza7gK9Ufi3ePdWF83YylgxFc/BEjZhHBBmnc2ZZxif2nxaBE0NCohaJ+bD5pg63dWHkuJFBhRlwSIgTG2tlFxZ8vrwRWco+MBNSlZvXhqEvdXhQMsvF7zMU/Rx+iYik+xiEnJifr9IE8l8XSAmB+g+hw50Pot+08aH4DN9rbQG5mq1B+gISIDP72zw55OwMh+POJF8SHnckDgxWQE5I37Lv9c2THVGVybIXuQ66YFnHsgiPa4Lf76pELvJ46hrlxzLVLKJY13vG46PsTRJTOzKqelLmXw6zkHJmD+1svbpVJy7lf4qUolROfeiXTnhvFC3J7uucLU3xCQCEOzIdxh0Kdg4edLHrg7dvh687IGF+bT3w5ZeQ/Kx2gX6EtfocRWBCZ0MSnke3DxWTIOlKmVKWS6NX8gpStWN6EI0UbrS8oRBY+MxypLDotvCAVBvTltBY1E2WAtcTBZNWWadwxEXsT5mCDIZKcQjEw1iiWxzgoRtUK31gvY0MxPAp6fs7VGROC7BU5ufdriJUHLJoKrBd0A30wzcnKrmt4jqbha9CGtK4O2jN+cul5ZL1YbXpk1Zf8hTS3duawKYn+IduerkmdnpClCjlAi+aHID7gjFr31tolOUkdNNEQyJF9UkbekW5t0Wrpdycag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18096099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jHM7AzQ+0JOd9Gv8R36BKt2qtTzhfRdvzXbYn4/mKM6WiGRR1m9orMb94mx7?=
 =?us-ascii?Q?I4ynNtLBkLQrVxnhRyn0XKCXNhOeUuqGl9QLdHOr42h8sqmtHkbRbpyD8wd2?=
 =?us-ascii?Q?8hDsRmFFW5C/UkTS47/I1K5/jInHibnQmVdOrGQsVbCXfpSTm+AkrkKkcM+W?=
 =?us-ascii?Q?TtfthWTWIP/YmyXTx4otcaXMx3rwy55PvEy9eZ4EllxBroO5uSata16ujzrw?=
 =?us-ascii?Q?Rw1KwpkvJMpxFqAUpP4Zzfd7xGuGTk+ubs8G2SabyigLmOOMf3Eqt5h5MfiU?=
 =?us-ascii?Q?nH0xjzdkxeFQlauGgNMsmfHA6g+YOpmahyXczo/opKFtoUpq2+n2wEm5yr5e?=
 =?us-ascii?Q?0BN4sViD6WkMo/hLB4i5H/p0zQvmQAy9ldX9DMbjQjZmBjJJwRskaHfyCJM5?=
 =?us-ascii?Q?ydgRf/hhsh75kqVU9e49XYR0RsrDoYZjRtLG1tqBWad7BvN9DHzkhj/MmZdl?=
 =?us-ascii?Q?1WCosA/gtxG5kaP8GxaVHYbd9UftC/TEXmr+mz0oEoSUMjgOr6xrGKiP8LNd?=
 =?us-ascii?Q?alTwaQ3DR8btsP8dRNZLUQllVw4Y/8Ox8/rsGjRcl0Bf51G7lv2UQ+p07Xad?=
 =?us-ascii?Q?Dlj8Z91+C0akddUXC6S6R/3j1/MeGIowvaVhLqGlIvGRBwVEunq8nTLGbUrn?=
 =?us-ascii?Q?xUX0GAEJMFPQChIPtBvF/yp29wlHvIi/1A2MJ+EH/TUlpWJxxqEOq7RoHuS8?=
 =?us-ascii?Q?sBXhNdikwqnoiZIjJy82z8DKKGeyt7waB4AEMliGBLAV9pzLxR7hWVzdfkeS?=
 =?us-ascii?Q?DiTkah764KpVsWliw4RNmLj5tzB7D7xztN2FnoEsvbpMuJaxs5d7kQ1svPQe?=
 =?us-ascii?Q?kqE471s7mluQwWp5UXEd7A9/78FHokrbFDCWqeUUaGkHJN+Zg4Qi+j/Q5Vfq?=
 =?us-ascii?Q?lrit+El7vDBlewff2BejePoUKeZq/2iKsGLmB6vFALAZVTTH/1IbPAeZ5+MO?=
 =?us-ascii?Q?9Wf5ZzPKwbxA12CmAkJjxXgXan2mlNLZkINpkMCtuY4TwPzbqtHdDbqkS5sN?=
 =?us-ascii?Q?GKR68i2CgHL+h4ePLARJFBNyRJjBULFZxnBkhTfxIq6vrszW2YtuaKLOcKxJ?=
 =?us-ascii?Q?WbVPZhRYvTxgcpblNOaWlN1uhjCZ17ls1J9RVgR34XjmC7Eri9rvftN8uWpC?=
 =?us-ascii?Q?SxBGvl6zeYlO1o3U5+WWE0qnFVN9tLj4+PcQipjOnUJ6G1uUOilH7LZ1nl1X?=
 =?us-ascii?Q?MTZwFb/C2NrtdVD7yOVI94j4BPAjD6oEq5nY5+WzUE/1tfYuI1UxjO8bq4M5?=
 =?us-ascii?Q?TSiRMxPWPCiMBMfunRIKA+jSaZbH2BFxT38640CDozScJO2yt8foxUH76WKQ?=
 =?us-ascii?Q?G69X6yf4ErMpzALOobWiCU8Y4t3hGp8pEDUHegS7uIEXpmDZ2QDxyZnMVMDo?=
 =?us-ascii?Q?dy5SD2YR9ySjx5SN2kxij6Pqjc3i+zfr08wMLcnTh3J90jI5uLJUCCufrbMP?=
 =?us-ascii?Q?FQF+78+vfz74R+pdR5mUcr0/w0RhWHUKs+wf/he24bG7kMOjgAJXb+cwlTLD?=
 =?us-ascii?Q?1Jp5EBoe1eIiOXUwIYlCcM/zng9Vk0lzdVE6pqzj8ahkx/dVzYRqEgNoRiNZ?=
 =?us-ascii?Q?UN2sK8XlX+mZpuN0yfWaWwwUDx96UtnKm2LiTMLdmj9cXANky2CmCcvKBmkA?=
 =?us-ascii?Q?Jm41BxXDhQPnQfLBn1iZHLS6WPkJvkZTjRxkYGX6TVFBD+ip/VwsAi4b9pBB?=
 =?us-ascii?Q?iyD4mOm5/3PXNywaflpkfL0XZoVycLyG/8mpOik5Yu3z1SNO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VqWGMYXYrbzf3huA4175pDiBTkSNWQbhIiKC36r/go1Bl4QbRF2kIYKM2+rmyrjslqoM42hEuFRJirZ51iXYm1GkB/qqv4BQoLIuhV5ucdf7eLk3jXGf2yHxgoe4nxQ2rqK14wzmc8d4cIPQsgvbOgVgd8eIuY4sAkY4Q1LUZaZcM7Xgyab0rDPRBM765x6WB5kAadDJGzmvBn2DNClEXVcebXIcbZqcYJcnJIHTDFDwEpnQl8tq8BMLeI99qtBesOB7mNAOhVIIqKqdB0Bdn+waeGB3Ge0BIjLxfNlfh+kKFQKEHBFsQGPYB7+K6dyGablYKAccrO+RiL5cIBSK7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c476944-a06b-4d55-6e88-08de9c55c148
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 07:48:46.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlZgb46WkJiuJZafruJnM0T8RiMrI+c9zMeJwOu2DIzvmDheVeq5VaWRMlazSiap9KOZwRl+vStlYC/VcH8yQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8714
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,BN9PR11MB5276.namprd11.prod.outlook.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 25F174182DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 17, 2026 1:20 AM
>=20
> On Thu, Apr 16, 2026 at 05:49:24PM +0100, Robin Murphy wrote:
> > On 15/04/2026 10:17 pm, Nicolin Chen wrote:
> > > When transitioning to a kdump kernel, the primary kernel might have
> crashed
> > > while endpoint devices were actively bus-mastering DMA. Currently, th=
e
> SMMU
> > > driver aggressively resets the hardware during probe by clearing
> CR0_SMMUEN
> > > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > >
> > > In a kdump scenario, this aggressive reset is highly destructive:
> > > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating=
 fatal
> > >     PCIe AER or SErrors that may panic the kdump kernel
> > > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will
> bypass
> > >     the SMMU and corrupt the physical memory at those 1:1 mapped
> IOVAs.
> >
> > But wasn't that rather the point? Th kdump kernel doesn't know the scop=
e
> of
> > how much could have gone wrong (including potentially the SMMU
> configuration
> > itself), so it just blocks everything, resets and reenables the devices=
 it
> > cares about, and ignores whatever else might be on fire.
>=20
> The purpose of kdump is to have the maximum chance to capture a dump
> from the blown up kernel.
>=20
> Yes, on a perfect platform aborting the entire SMMU should improve the
> chance of getting that dump.
>=20
> But sadly there are so many busted up platforms where if you start
> messing with the IOMMU they will explode and blow up the kdump. x86
> and "firmware first" error handling systems are particularly notorious
> for nasty behavior like this.
>=20
> Seems like there are now ARM systems too. :(

is there any report on such systems? It might be informational to include
a link to the report so it's clear that this series fixes real issues inste=
ad of
a preparation for coming systems...

>=20
> So, the iommu drivers have been preserving the IOMMU and not
> disrupting the DMAs on x86 for a long time. This is established kdump
> practice.
>=20
> > If AER can panic a kdump kernel, that seems like a failing of the kdump
> > kernel itself more than anything else (especially given the likelihood =
that
> > additional AER events could follow from whatever initial crash/failure
> > triggered kdump to begin with).
>=20
> Probably the kdump wasn't triggered by AER. You want kdump to not
> trigger more RAS events that might blow up the kdump while it is
> trying to run.. That increases the chance of success
>=20

btw the DMA is allowed after the previous kernel is hung til the point
where smmu driver blocks it. In cases where in-fly DMAs are considered
dangerous to kdump, this series just make it worse instead of creating
a new issue. While for majority other failures not related to DMAs,=20
unblocking then increases the chance of success...

