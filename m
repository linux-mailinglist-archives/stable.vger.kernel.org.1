Return-Path: <stable+bounces-235569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLZPM/+W2GkgfggAu9opvQ
	(envelope-from <stable+bounces-235569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:21:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D773D2B42
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B41973012E47
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09B35B63B;
	Fri, 10 Apr 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcEe0YMn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177A2F9C37;
	Fri, 10 Apr 2026 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802109; cv=fail; b=Q51+bmefXOGYwjQUeZX4lJafTXWCLxXj53QxYJMy84AOgaM4dwMjpay5rDxnRuIOgt+2p8CSYpcHAs5MszhFrn1S2oxKQyX3+W3SKm489fjuP6v4nvN/IL8fpmqhnEQn+A+OH1sRHhPmh7Fu98y0+JZQzo7dp4i7Bjw+2HyNclo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802109; c=relaxed/simple;
	bh=ACi1PjbPmVaxohhSrkdiO1+Ue4u16wI9QCRuqULvglE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4Y7JDMCdezcGabr14K7X+Zw7Ko/YsEnm9s46VyAoAKFOZrCkpw/+3zWm4YJp2QzExd3C7CN+LmtEE43eCoj8RUngHCslv2wa6XFo2L2RH+OzE2QNEB0kEuvtWfi+6Vddw8vc4CgIglnwL+OcTiWusACBQ+AOTpDqzTxzvnUM4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcEe0YMn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775802107; x=1807338107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACi1PjbPmVaxohhSrkdiO1+Ue4u16wI9QCRuqULvglE=;
  b=fcEe0YMnQW2Wn8nGV7HqOwZ/Wn58rXFV7VvzGmAOUZX7qRTN8ZJOjlVW
   YP2F1yFl05XY3hBn1jy5kbF+mkSfLMaR+QUhL7/YVHTFy1ybSOlaYmPzs
   FaPCNywg/BlKfLRBE21qutS2H5eFbnF0eDkuWyi99FRlw6/xag9Dsp/Mt
   6jjq6HBUStT0T1lma5OY/CnDVV77AhVt8GDA/OcKhKKxIRy8x1UIhdlpD
   U70Y0L+EAeI/KAwN74JEvg/0UH8Me+ca9NOWfPEZ6EHa1MpTN2jINIFs2
   cV0KH3Y7hYyiW/w042Pq3q/HXy7IfYI9IyUIyhDr7GdgwDNiwmT4kOCPG
   g==;
X-CSE-ConnectionGUID: FIk8ghYqTq+cRVHR/AR7WQ==
X-CSE-MsgGUID: 68c23YlVQH2i+8AgC1KqAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="99448338"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="99448338"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 23:21:47 -0700
X-CSE-ConnectionGUID: T56ifS0GSp+8gxpbVVR7vw==
X-CSE-MsgGUID: 1gnJAAD9RdWw8olYrYw2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="259467421"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 23:21:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 23:21:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 23:21:46 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 23:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqAm4yukeSmO2Z0GrDusQsv5SVuzjtqAMaXGrJZ9ndVzMU/golc9wFa5i4I70PI9VFwwJRxDRjXZfYrqvLKPA8QSQ19QZ0Xfn0baVr5d8WDnOFIYs7W3aE99BL7TuYDJWmIxyrYoG5IXXQz6IAbr6Ck/1T17SGahnl0AXu15ZPPFYrTOIuAyskbJc7xKvw7w/HwKzx6Sow0d27WrdwKyaYer2iHrB1G+aUDf85Yiu1yS4qaq5cpxTlB3z3+sHo7iiAVzNqGn7De9sCVBJRVEywK8tSuUrUKHHFTpA1tvqw2p4IbDMoSV+FLZhvANQENifpYFsZQ2HyOJuDWRvldAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qvbQ9p0Q+Wt6udN3azpWG6jzgGLkdcJDro9CfrxzyY=;
 b=m19a8vi+ws4+YHMBNrkYLvBSh/UG5QnRbx9bq37x8JPyC0hzMpYG8lBU+2lQ+WuS0f8m4pv1/9K27QjykAbge90CNm6Py91b3kHdwvOVdEtGdeebKG78yuAOh+gaGch0m47Nhc7CSDZQp5wc+pzQ0OPYWjj+BivL4CEq+Y59ANoBAsuPn4hzAZhzyqrnsROjtHul/OyqP5CygQoaoEdqLLRC8GeGdX71Jyg4gWQOGEksVA8Lp1nSTnNpEjSJQ64UKacSzhNdOhBIVRIFZ2bpInKdqqgwGwuvCay8CnIEPIqXx+0sJ2mdi7fcJvpnhW3qvV7FWyYprzEvq3VXLVNlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB8814.namprd11.prod.outlook.com (2603:10b6:610:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 06:21:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 06:21:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "jamien@nvidia.com" <jamien@nvidia.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "smostafa@google.com"
	<smostafa@google.com>, "miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Retain SMMUEN during kdump
 device reset
Thread-Topic: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Retain SMMUEN during kdump
 device reset
Thread-Index: AQHcyFm5eLnC7m0EKUmoliIG7zFQg7XX016w
Date: Fri, 10 Apr 2026 06:21:43 +0000
Message-ID: <BN9PR11MB527631CAE6281C630FB148B88C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1775763475.git.nicolinc@nvidia.com>
 <c116eba01bcd88ba3b8ba47dc08132c4546e91f5.1775763475.git.nicolinc@nvidia.com>
In-Reply-To: <c116eba01bcd88ba3b8ba47dc08132c4546e91f5.1775763475.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH2PR11MB8814:EE_
x-ms-office365-filtering-correlation-id: bebc9ffd-b4d7-4b9c-843a-08de96c96f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: FQRrUS42aQ9dBVKRAY+9P0UdDbC1WFbrPSrSrSIW/PkBNxliaVpQUKYgwahD94CinOdZIQiBiLrhDb6xHYAyEaeXhY2kPpgWnlmCZZfGtE3SirhXmVEB2KuDAdL+sjlLq/kWqhO4JehxVkE1VNuvpekOUKwcbWtuonANEeNzAPVD8ofewMiuy4/2JYHclAjPHEy3xaOhhi037xQVidWzm7ir0Gpsg1ut7x0pX/VsOvtPjw+EHRAOh85l4ZKd7QFbT2j75ds6dA+lXTRxlwePtpoAa+s+U/pdO4MkOzmFl6nMu1HuMKwuD25PU7UhGxdH9+i/T9i8UDnlKvscPBUHY2e9BLAGBiiVK94ciIcGE2efKxsUfpYIL6m/VS5HUzcZByf/EazipdUiuTFNilngkiKj0/JFeRZiP/uNaeIMn8YSa1dGzA9tnCaBYq1FHWPRAX3b9+VxygwqbpJ4Ehks0vLsdZdfCNJfuF/2ZETLZv5ztgSb4BX94FlQEaTHJ5yUOMRXfhNImE7i4esQpYqhtLNSku0y3YSpzQkGJDJTvVsn7stcGL7fGeMcd9rqerTd0wfnSgqHelzrwL6JZEwBFB2y+426mcRltuB9XyNLmwAe+3El6SbpYSWNLju7Ak8WhY8bMUml4FQWPlW1yGeMktODqU5TNfWjNm5XY2g/e7Wk2qoeFhVb/FtSsp2vQB1FrpXrb7apZZyZG5hSwmP2r0UDr48d0NPkrLO0086ucqQ4uHnunmUHHepyuG0lhOpNL7RHt738Bx4Nj075p8lM/WArK8RDDmwDU8nlRudbiEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DjYvnfSEWDjX2MoUKPvNdXOpjwm/3sIpSa+xk86kCBpZlsg14re4Tj5Z1hMK?=
 =?us-ascii?Q?pjppgpS9QdFbO3fydtpqrqhRZ+qouOfMqbsYUQCalgBKeb97Cyxh65fuCkz9?=
 =?us-ascii?Q?kPzTivCzuK0Aodt5roqIYSIB/DvwnGbKIsEY5pYMZMwd4YBaJk0tBVQOpS9C?=
 =?us-ascii?Q?r5s8bLreRRTOLqH3JutrpWxP8nIYMlTUl7zNU7jliRHJV3vDOLQiAR/SWEeW?=
 =?us-ascii?Q?zM0QY/U8zHQP+5+v+mm5PsetfpOnlINMHSXSm519YD1HSvlF9rOV6ZkY9Ifm?=
 =?us-ascii?Q?wxPgix55nlaKabwOqfIqXfrWYNA5/jcB1T50I4XhOk/woYeMnWJ4OUprWHfo?=
 =?us-ascii?Q?PU/oSc1ggpQ957Zgnt7/Jx+2njd9uG7ndkimUepFzHZIVi5beOghA6yE+eFI?=
 =?us-ascii?Q?mqCxH+qdS+EhJmnZWD2477cIYRyhwaJRF+CtM35yZozTKDlN5cXcI6BRI+Hw?=
 =?us-ascii?Q?bvEavF3Kj+1E3l31aVgsUG5is08+ZBNklGUFZTvulFrRMVZ03mWrmHfNx4Dw?=
 =?us-ascii?Q?2mxS1ND+oBkDfatsO4RytsjuoREXpsYBveR4pFxkMMQ/Fvo/5B7ZosTntWts?=
 =?us-ascii?Q?zsMXIl8YK22goWgaIo80mEAc0qP5r4m3GTKX8URlCcgblLIqJlQ8Fkfpotsb?=
 =?us-ascii?Q?z2B3lY4zGjsxuGnDTz2ALh3kf1yb4VJDF0NtsqRkoV8E8uiWnvKWS6jBVZTb?=
 =?us-ascii?Q?EdskTUEHzkirOQYZ6/7H1T7IdetG0AbgkOeJReM9w1tBaKUscBXZq/R51xa5?=
 =?us-ascii?Q?8AYNv+4RSLPgia40QnUJbxEdp9X8FutK6XbR+wz6a4lcZuAVIh+uwo/jChPr?=
 =?us-ascii?Q?yxDVxI/OoMlIl1Oi9O5lukzIUvMdSb2g6vOrvK8d13RevLcyX+/ARO45AK3s?=
 =?us-ascii?Q?x6kwnkvi/LiYxV6UWiMiGplIl6lmNcyRZ44kFqPmVXOzDMQtz1Guv23kqa7t?=
 =?us-ascii?Q?TrlfcRke9qUcjhWWNtIMAf4Z1QzClUMNLUukhoPZWZUBq9oywZe0WE88QK3A?=
 =?us-ascii?Q?oLrK0/ijdsSEk0mOYMTv3LmaiHG8DjByxGbg5+3FvkEzMZW7GJTDtmBe1Xa7?=
 =?us-ascii?Q?sgZNU9Xjr+Yn/8cLUMDwnTcshSVh1Q7Ff08hgJd+YBvJrBdSNLcRSE9tTxsa?=
 =?us-ascii?Q?SslZBMfd7m6qkIgLyaOWhNI1zsO2PnV5SnFG5m0TIOOg3UA/s0aqkfkt7RZ9?=
 =?us-ascii?Q?m7gNtSoG/kwtY2+ovdP5AJPebpZn1sQGZO5XGc1ta0sd/jXZVaVRj610V6ze?=
 =?us-ascii?Q?QTyv9caqtsnrj0FPd7F7Wm1hPKxQgUqakmt9JfaQntfzeNBxePSHlwc65wo2?=
 =?us-ascii?Q?3r6crfs11uFR1JTsxyqbEWGVt8CUzMxxxFmIpZQ0EbXC2DfIbCCl3Nwtkbf/?=
 =?us-ascii?Q?oB6o3WbugudIC7B/jQMUAiDCCV/aRjTY+Zl93wybc4RKyMZpo6UXshEy9eAu?=
 =?us-ascii?Q?YXt2G/peOWAgKFtktPYQJCGTlTX+eQrMXSnLcOoboCCwnrgkW1TixPVZpUAM?=
 =?us-ascii?Q?OOw+wl+l0Vl5eAaUU1DsaJcJxf1QLRCRelUyZ99E9hq5xi8zrFX6FHQiXEYK?=
 =?us-ascii?Q?xU3GD9C4pUBT+X/yIBpjl1yCILsWuL53SzVl8eaI99QJFVNF0zAK6PjfmmBB?=
 =?us-ascii?Q?6GK8GX6FAwoB03SE/75NT6oZgHb5LkNZMj0gJVqYWC9OKl+j89FOImjrZ1nG?=
 =?us-ascii?Q?EOGsmxvaUX/wz1h+IXxIlji3IkajFbh0LQPxUYNDfIR10QcIJx0fLCHa5GvP?=
 =?us-ascii?Q?k7LQh7GLlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rjlEhtaueCOwI5wtz4fwRniunoy2+XA3k2bAJAv6EcPimI8+UpeczviFe7rPdORtb98RAI57lFfkboVGyPyHLjJEH3Y9WdkYDJgevtUhAOjF5G+NzAXGa4WozGM2/FkFl6FOrdSKgJ22bX123FVBlQqiccXlTo5gsb3HHHasnUdGP2k6I5EndTK/yjfqtomcY6zRUJUfDjZtVuE6BlJG/lHR3dtU9Yfl9NLUH0Wv83truxQtkUs6QPLzjXZpsvvmAw213llGaiVox3rPRQqR8IqktxH/U3sbwmT431tfOAMwbmBsY+CmNqGzm00u4GQ1fBc7c7cHXjmm44Vc0PMb5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebc9ffd-b4d7-4b9c-843a-08de96c96f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 06:21:43.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y85H/FZ30ZaSTc8qAULaqIxbPX8dHFsxubGgrBcEOoCSwj4n3OM9uZuYRJFIQ5MBCOiWW99E2qQ+Q8scTDKTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8814
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235569-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 70D773D2B42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, April 10, 2026 3:47 AM
>=20
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg =3D readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN) {
>  		dev_warn(smmu->dev, "SMMU currently enabled!
> Resetting...\n");

move to after the check of kdump kernel

> @@ -5038,6 +5064,11 @@ static int arm_smmu_device_reset(struct
> arm_smmu_device *smmu)
>  		return ret;
>  	}
>=20
> +	/*
> +	 * Disable EVTQ and PRIQ in kdump kernel. The old kernel's CDs and
> page
> +	 * tables may be corrupted, which could trigger event spamming.
> PRIQ is
> +	 * also useless since we cannot service page requests during kdump.
> +	 */
>  	if (is_kdump_kernel())
>  		enables &=3D ~(CR0_EVTQEN | CR0_PRIQEN);
>=20

then just don't enable them in earlier lines?

