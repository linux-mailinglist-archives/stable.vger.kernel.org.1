Return-Path: <stable+bounces-244689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KECXKMGU/WmXgAAAu9opvQ
	(envelope-from <stable+bounces-244689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:46:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 657094F33BA
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52653305BF0D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CC32E6BD;
	Fri,  8 May 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QePii7KI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73014372EE9;
	Fri,  8 May 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225977; cv=fail; b=ELVgCENmVINZdjFER8DGsHjHSaMpGArEngVlevlxOoPRP/XOUQ8mv97jKkOPUiQNCbuJXOnkMUx2FVvjajT7hpqghPJqMeQ3tyGb14c4NB7PALrEz8iL7c6WoSX7QP3YjnwsHMU68ddG4aFQOrc6wp7ChigG0o6OXOMwozuBAV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225977; c=relaxed/simple;
	bh=KnmCijtMoOxHQBvXRhQl3oiewOF8UI+qZbHGCO6ebX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LiHt2juEq1O9Rcx7cqsakdCduf6g9pR6YCitVOkFXGMEsglh/9e6eT2FLMErXGexoNkx5Xh/L5uPNPXCXRsMuvTX10KVGn9Qkj36pmbyUlRaMoD4q6IuTagAQKO6nAXmum41hTmXIDSgZV2OkcnBYdLWbH66RAiLt9ajkFOP1RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QePii7KI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778225976; x=1809761976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KnmCijtMoOxHQBvXRhQl3oiewOF8UI+qZbHGCO6ebX0=;
  b=QePii7KI3xua2rS/yZ8FhNdP1n61bkqUrMBDy26jHK5dJDvW2cufToe9
   h05J4KUuB1B1PGlTtUJ5dUtZY/NUb9lZxV9UZEOw/1hKBjdoj2QdFsqj2
   +ttI8U6QGwo1/KJFP7fmeq8O3ULvcMKwkQ1eunhnjhqk6nwJSiuxbckhY
   RdurRm5zRMs8jCKoFMmBJVT7u6uDgSfK2VnflPmDqXr52QRYtYA8Y6MMw
   Pj0xkgQFeOC6oRwXVzzHCr57FHYJhh7KCwmU3PNW3vBviSs9e6e+R3Ttz
   4vjRRCw2UjzZZVZB/O3CRxnHmcvFupGRzasKfvSGeMbfpwWXnJggq0ota
   g==;
X-CSE-ConnectionGUID: CivD3MOATPuTaZ/NW7c+Gg==
X-CSE-MsgGUID: d3RyFvS3SSKH+u6pOY/RWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96757555"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96757555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:39:34 -0700
X-CSE-ConnectionGUID: T13434ARTj2rviyoqkpwsw==
X-CSE-MsgGUID: HpjZ+8LZSTqD8cirGZxzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="274814866"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:39:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:39:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 00:39:32 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWFuK8xzYP4EkFcnyxfYs3oOuH5FZVD8UbEavwVHvdFoRkfEZqO6DX3Nnx5gD8q3VNblU/aSKJJLuUlUjhOIQ7F+rRv9/78PrLmYRBYSy6GnfISCN0fiEL+ACM1b5PkjnrsnV3qc5SZMpVMBL8VBayio/6WOOnyQRxuaCygMhvurY4tinfFpHzvUdIET/kl2QI8F+gISkcAS+5sf5SCffmgp3iU3n/VxUAd/FKd3wvY2/WCosdsjKl3RHU17Vvs5PQivdJw9BHTZk1m0D5JejvW8ErZHclHY9vUO3HSOIaDnX5mDsZUbYKaxvM5e3o+3oAkzZf/cOLN3fULsjMnL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnmCijtMoOxHQBvXRhQl3oiewOF8UI+qZbHGCO6ebX0=;
 b=ndqFOPlrntgF4EpkLmE+5Xgnc2JI3xvDpOUInCMSmolT/EbSx7DzxRnjILA5/rRtm3C9HZNzsxh04fKT14glnhG5fdc6jKpR5GGXLgBvuGPw76havioATUgXd4HqaP7MbrfgK/woS0RyUDC2q7ZFC4UukYmvdW5a1+FRiGonbX6LBI4Z8N4rQ6myzr4Xi74i2LQT9jWd8bp1UwRYTzfoZdRbJp4c4QANwHce4x7WN5o7tyoDRqe+3Ly9TbT60aKo9ELwKDK9GONHxri0WuMZVfQC3UEciZibsvz3fM7yuijE7OPHQUadEIbwu/LH5MeUR0Vhzo1qDS8vDqgZsoY4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 07:39:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:39:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "kees@kernel.org" <kees@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: RE: [PATCH rc v4 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Thread-Topic: [PATCH rc v4 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Thread-Index: AQHc16jre7DdRuDRSkaTPjNNxQZudLYDzC+w
Date: Fri, 8 May 2026 07:39:28 +0000
Message-ID: <BN9PR11MB5276B9A2CF099ADAB16F41C48C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <1d339a2353e9793c46853192a93d28fd7caac4a1.1777446969.git.nicolinc@nvidia.com>
In-Reply-To: <1d339a2353e9793c46853192a93d28fd7caac4a1.1777446969.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6803:EE_
x-ms-office365-filtering-correlation-id: 9e98b9c5-9e95-40f6-0145-08deacd4f01d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: NPmru5Z8h796EB8RF4BKYJ2HctxiZIqa5hguSaPjTK9WPjX+Mmgsuk/aWEKQ49fDTmhn2bIGw+/RKeUYurxp7E6V90EePposCTmQZeJQTXUNmxXx/1O4WpeFhOY536rUMUgd9UhunzigZ6k6eOqCViUkmeQ8rR+nD4fFaHE8XdfpwNu+q4hYmjALdcC4OHxWI2jhWuIRxpPMEuSuggzahlxI0XwLQvROhgj9q3/Chcz3Ms+dpy0UiNLUizB3ln8MlEoglVO9BEcWMKObB3BAIr6tZd8y5P/BMe8H4ddoT7vA/NWtV9wlmKuK4qTsS8nCHF8qXAT2HJhhz9613vUnHSXz3RERWG+sUqZls/trK5bZks7uYaxOpvmlaa65Ng/2AEGEQ6zJvkrOL9CD/wFPBEBrwS6NC5SROIXY6q6Fu30OnnGKKaZdO4GHFWNAAuyCj+2ICNH+lmHMFJFz8UJNoQx+nRhTKWMgp/wIZMHzJhsQIEzIPTH5gmcwt2A5C/jTxj50fuWOaBBBRSXMimjSId9E7MkxX1NRjcfqTriDzxxyxU8g4CG6CXX+Z1ePKuFMPurKvYUUrbxoKNiY5GtdTIYR0CnBllk9V/CkoCwreB+q3v3AeQP9yNfssBdnHud8h56/WZ0Xmhp83FkejIYNgwABxcOFr0MTezmMPatxuhYydP+6Z4EQx0qvlB0lM1IzdHnyOcZG0C6VNxVHaLSO+znX+q2X2CvyIBu19k3cxoR5CX+3govAX7h+0iohjJVH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bCYAhMg2NWxFHYCjKik9ElekDv/zX4IyH0YAmBaWcpT7/ZdNf9Ok9V93OZyq?=
 =?us-ascii?Q?RwssfO+6FC0hH/WRYtUM5GnqcLGxOFCNXS0hK25qa+TRkXzHj78bs28PpiO8?=
 =?us-ascii?Q?H1q6qRGyaQIDoOsdY3QtMmR+d1LVLD/o3mZUi6y4OrXhJTj/Dg6jMYOtb6ju?=
 =?us-ascii?Q?SKUxAKxvbo+bgYhlT0q7jQ8RNnSjp7THlH9dmAGSpSirJbghztjS0j+ELRyx?=
 =?us-ascii?Q?alszglVIQ/nnlm5M0D4QRIA4nMw1VabEIgm9OmgomFDBHKq7DGfAA0hJy/y7?=
 =?us-ascii?Q?mhjfTDiuJ+5GmfZyMER7yHXJzFJf2fMbBIrxJXaMw+6D/oJziZKRURf9LZw5?=
 =?us-ascii?Q?Vf/ViPRdkdV5WbPxWMCzuiYyEEJxMaCtdA/Yt8MEEHtDe+rPUrfB+d1A7fiq?=
 =?us-ascii?Q?uGhP3pwvNE3xpgoZZ91xNzOqpp7l664CClz+MHGacifGyPnp8mFrep9y/FvN?=
 =?us-ascii?Q?PG64QlanG0F4r2LYmoePujyPS5P+81UgD3XI+hXO/6Nb9BXS++laXb8pKOkL?=
 =?us-ascii?Q?4yjXSj49+AqNcwrRjok0IPUsLrfbu/ZYIf1GcT4aq2RYU+ETokC+7v5CBoFU?=
 =?us-ascii?Q?1VxzNWv9jr9bj16eWFE2lv3c2Uxluf7Zw55cEd1l9WDRUlvrvfoHBv2TG/c2?=
 =?us-ascii?Q?te/Uk3svwx8bIM5vglQg3h2AS5YWdVe1+wnyDdntKctemX31mRVrMllKfN+f?=
 =?us-ascii?Q?ABURo0on68CbXSB+lFKkAPVa9QZtsPHRY+pc5zt7mvJplw8KTlJDbHWwc8Pg?=
 =?us-ascii?Q?KcFriSPnYw75VZ++lAtpjntXvnLNnXDC4XTDFzDQ+1lubFqgfuuQ4HyFnsKE?=
 =?us-ascii?Q?Oa3E0e3QF7xOW4FYtE4EWopOjTnfQHSNCGx/jBfWrhFdD3YiVVV8cpqSC8Oj?=
 =?us-ascii?Q?sxIBWpc+tY8fTJ7+AOi3yRTAGB/ReLpmFVks2tpJ0eebrFIYpcP10ScnW6u1?=
 =?us-ascii?Q?iUPPn+RnN+lEROdRoqHfeO4zQoWyVh/SkMI/TXvpcQKb58kOgkYrQOPE+4cQ?=
 =?us-ascii?Q?toMDOgCRC28S+RlANtopVONN1bksboSdkq+0/bOrwur37mWFz0ewBnfIx7aV?=
 =?us-ascii?Q?qSQWLMP0FPRS3OXRiuRcYU4LuwCpCXCY2RyjTgpsmWryrrTxXqJh4KpqttMm?=
 =?us-ascii?Q?eW1Lo5NUvIraLRh1GlcXnZ5mphXXpCBPz5Q4mRNFCgXXOAwW73T45DiXqnGf?=
 =?us-ascii?Q?4erVrj9pva/54G4WE73ktW4WXEm0g/HVYat7BUytmU43jIuP/W5alD49evtz?=
 =?us-ascii?Q?Vv80OOHn9u5guKy3MXudcgGSkHrVJRquHCJOjrklMTkRQfyXnOByZzk3/1RG?=
 =?us-ascii?Q?ddNNhCUgECQkpAyXRsSE2nULJywjVrLA8JWg4VvEMnuSmweM81lyI42bwni1?=
 =?us-ascii?Q?PH/3L9Xzb7FNT6kPQGilUwMne49LU+yv/3VA8LDCxM4Gfzu+4vEa6XdgAq8r?=
 =?us-ascii?Q?WfShPhPRJY+8oa/sBjQqbbh/MUAGUy3eMYNmpDjsWZfDvE2vQbg6zb+DHC18?=
 =?us-ascii?Q?qIk13IbdYCF69X04fLsFB3QH0k0rhiq/Kfu+YjT26dvh/3//r11gi2Sy4nHA?=
 =?us-ascii?Q?43xfAMUsBkL0sV4NcZrUGIQ8CMYvTOuJoaRpctaiRIVVYE5beevTzGiOB+D/?=
 =?us-ascii?Q?GzfEth+Mn/jEo9m82xv/2uGNcr97w1TPIL7mmcIi8NU7U1wvAlo6c/fX28kP?=
 =?us-ascii?Q?mq4x9IMpZxEHcuLnUYWRFWSenE/hQrxgTkbJKzkTtc6iqarvTtQJ9T+cwxv3?=
 =?us-ascii?Q?IeP+iodtPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OZLlp8xy8087MsnhDaGGP8ZqIS/JAJp015Hef1XHCipnmM2KTYfDBaDKOxkWMSEXVVY/T+uF3ChEIP1MoOuxlnxtVEI0xu5mpWmWM6Mkiu0JDdVJEASw6IBnzVvvjHtoOpEHFJSNKuiBV6c1t+c9rNsY0meQGdVMx1Vn/MFf5m2MclHZDhDCN5Jf03f7hC5DF9pW94LbMt0f2VsV+otGfIdAvCSRCf++OsJs25CMqnwd12wSzQPpxlG0sv7myoQtuismORYG8j17MJLrRMiMC2umCQsbXs8BXj67E8KahKPah83zQHDJbQCKIlgzX0lMHo0A4fOr85eS3X49n8hG+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98b9c5-9e95-40f6-0145-08deacd4f01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:39:29.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcLuLSEd/dFjdFQkku/uTDl+FxxswDbMg41lyRBmyCabkbnkKZFkY6cEfG7z/kkij9fvzTeSBgvQu30Hh1xmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 657094F33BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244689-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BN9PR11MB5276.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
X-Rspamd-Action: no action

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 29, 2026 3:21 PM
>=20
> Though the kdump kernel adopts the crashed kernel's stream table, the
> iommu
> core will still try to attach each probed device to a default domain, whi=
ch
> overwrites the adopted STE and breaks in-flight DMA from that device.
>=20
> Implement an is_attach_deferred() callback to prevent this. For each devi=
ce
> that has STE.V=3D1 and STE.Cfg!=3DAbort in the adopted table, defer the d=
efault
> domain attachment, until the device driver explicitly requests it.
>=20
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU
> is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

