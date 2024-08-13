Return-Path: <stable+bounces-67531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E4950B91
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE873B21973
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655A1A08C6;
	Tue, 13 Aug 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILAdIH+S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E919D06C
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570896; cv=fail; b=IaE5KvvG45ei9at3zeJQ2noCCLkEwPZXTCeFSxZVT2khxt+jnEZ0KW0Iv1IOfQghoSvvhY64rWKtUBwv15JtSqaZr0fblUwjsZNjzvZU8COp896NsrdxyVaGsxMWD81IBvXLg9XO7r6l41J/nE54rHsvmqJGMHGWtMTo39h9Fh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570896; c=relaxed/simple;
	bh=VueyMZB7LNP06YDkjQ+y/XWZsuXFHz64kTne3dx1lJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teT8McpVUFMKC0Xx9k5yL4aV5WtBlgq5P9scdd/82MtmEVFNWOOyUtTsKraH2O2ic5GL9UUWD0xBMG+ShWPA6yUNJqubSaYXR2yuZT1Kgn8SF39SlQJGFI+QNvxOgWH/YlopUu663XssZQBExY2feAB6QjDRsoSV2Cwsiskl9vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILAdIH+S; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723570894; x=1755106894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VueyMZB7LNP06YDkjQ+y/XWZsuXFHz64kTne3dx1lJ8=;
  b=ILAdIH+SYmt2r24BA5OUcW9yrRfUhThlteW/Etu2ljG/4cRm4OLFBWLZ
   OcAM6WDhihtg5JXBGrs7fQLzNzfUaOvpjsB4YGHNVjE1/2ySh+33D+zAR
   0NqaP/8NwxQyuxPYSoBtDmcKT9DsJOOAfE9qaUeJ4/P+Lv+Y/OuPuu7zG
   NGX6YTnRH4L00VXYT1tGPgC96ZM1VDd1Se0UG1nRfbcJebSfE4cu6VIg+
   VKTLBilRaQz88nwQNc6E09YCDRwjNYGi4BYGd5968e73IaTYvF8r+RgwP
   Q4r1KPrv8N8OhMgHrl/BVLQBwd3/y5JcFrqLnyV05kBTsoxsQ696b9vgZ
   A==;
X-CSE-ConnectionGUID: 9R/xCjHqRdWJVtzOphmQ3g==
X-CSE-MsgGUID: crGmsjWNSyqibf+b+jgzAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21566611"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21566611"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:41:33 -0700
X-CSE-ConnectionGUID: iU0681O9TgWwESnaOakT9g==
X-CSE-MsgGUID: GdjX2GJ4TZCm8B6S+MBSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63405023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 10:41:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:41:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:41:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 10:41:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 10:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np7Jn6MzXzputWxYuCZGGu+l90gNqPSxtwOzXU38nVISKRl3y20zUaC8tm4E3yHjG/rVj5xD0+9Aao9WAnDpPSIoOvjMgSy9Nihafu+/whTw6bZrtZP0ik4j7KDvc0z9uHxH5FXBcNIPOLPTFWi/cP+gV7+/63h63oiFCCnqnPIKojJ2H6R7EoXp5MFfIix8U+TwDj3k2tsKyx5ls+w+6S9pPdYBda4BfaXrZIkvmZZ5kF5v37S9pDIR6Tv81/KLaNiWyCNt5/JB2Duzep7aIMlc0sl0pT13ute8oK2IWIwoY0SkbU1txefHb6XhcEMYTkhR2GgG3sN+YUyIfSSwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhPQLhb7x/NwwydVoUM20YL5K3VHSaGgv2rs1J2Rdg4=;
 b=hS9fNYTTmTEZ7NP9KaLx+v0+D4QZkBN6Nw1DCduPCcZnE7ycty65ssyCiJVynDhjAC9UMnzZOaFQ8Tz1KCsL41FF/0c7lXcw+lKthJ8/2AKMqqFczX9voHRtO3lHm/bZS0JlGl4MoHG75rprgpSDfBd9M+lfQI7hihA/xqhMBXkbPxxyx2TO4y582PV/1/mv70R9FBm34t743V9UA5ohGfU6k2rqd0OFEGz8R8YTehM0DLyqFERHLrFynN7LuhaIMyCfPP0MNa5mgiSa4z0VYTAnih8F+gx2NNrqGkYGb5H1Kn9AckKIyz9ux8dmAQzHYRvj8UjWCbv4+yMOwA4BQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.32; Tue, 13 Aug 2024 17:41:31 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::8648:3a6b:af5c:b6e6]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::8648:3a6b:af5c:b6e6%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 17:41:31 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drm/xe/display: Make display suspend/resume work
 on discrete
Thread-Topic: [PATCH v2 2/2] drm/xe/display: Make display suspend/resume work
 on discrete
Thread-Index: AQHa5+6PbbU13coEik2rh2ibmwaVO7Ilf8Kw
Date: Tue, 13 Aug 2024 17:41:30 +0000
Message-ID: <DM4PR11MB6360C1CA33780904DEF70398F4862@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20240806105044.596842-1-maarten.lankhorst@linux.intel.com>
 <20240806105044.596842-3-maarten.lankhorst@linux.intel.com>
In-Reply-To: <20240806105044.596842-3-maarten.lankhorst@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|SA0PR11MB4624:EE_
x-ms-office365-filtering-correlation-id: 6b9c3a62-d7ec-40b8-8f96-08dcbbbf2aba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bI3pU9pVLfUQ/B3+qCEuJUBMeYfDeRQSE+pWhObkK5ucT7TljpvbHLpDxth3?=
 =?us-ascii?Q?Pl3kkpltNU823OUCKXD2/MsyMDW3EZag3k51XXRKfrrNTd5UY3WqS17IHrQu?=
 =?us-ascii?Q?LQzkksuVf9MDG0NywkYHdOx8Zz8cHoOBzoZz8FaeBMlprvnPllkopqjEU/qL?=
 =?us-ascii?Q?ZFcrqp/3pjcrAdb5N0d0AIHCnvo2GhcIQRAjIlknlf74uaw3ocbKdSjvNwa2?=
 =?us-ascii?Q?KvBVYd8Z6Dr/IDPRZf4gbG4Ge8ByvTdGvymHhJkRF1fu8i6pKotV0hLq8tVv?=
 =?us-ascii?Q?YYXNWHkBiJKEJ39yF+IaA/VZXweKRXrWKNoXmpGr1G/Rpfb5qdcpeAk/o0uD?=
 =?us-ascii?Q?SVseEBIdQ92J2lNk7uGgBPGwLJv9vzf7SnfKvF1lO9gpZUmSVrm2jFjfWZak?=
 =?us-ascii?Q?xr0YBQi5V/vz7/dH3Gc6EOS+CmXCcLKNUq1fePyMJSqDUKtN/xqxdQYYS/nn?=
 =?us-ascii?Q?QFxj1jjytXRIMbJ0K9WLZkX0unVGhCHikFYapwrlgB/rSiM2OVyI/HQnlBnz?=
 =?us-ascii?Q?PmRfMqBZ1fTxnHWCuwxRN4guoYWwPNyUyRegqI25gCVKiIIOQiCq8peAWrHC?=
 =?us-ascii?Q?Y87q1cmBJw6K5sZi0qrUeBIA0sSa7GstMk0go1XYD3nZ9ig1LVD1SLj/ODel?=
 =?us-ascii?Q?XFlZKAljQ/VoyQqGgAlfWIr4lWL88QSh9AAQLY5Az4Fm0dc7gBylVrmLiDBt?=
 =?us-ascii?Q?OgCQK7sOkLAK/wJ+ZbGWfEVYi3cdMWiB/JDCN0yilIFI+ZeNsh+epcDKaxGh?=
 =?us-ascii?Q?aFJaUqV4frN8b41b9hH8uhdJwX+AwlgE/AYX3Vwmrcj0+u7Bl9kDs7EQ9vuA?=
 =?us-ascii?Q?fiDNCkgFDhFrkDEVpOfrKM/22BdKVUz/JRUh71ToEZsrp6WS5PbENCb9EnM+?=
 =?us-ascii?Q?dolmjZcDvCvA/a8D0FlLDFaaEJ8fzzB4hj275em/FcsT/wGBw+prZp2aBr+a?=
 =?us-ascii?Q?INf019ahzf6xpXB0rO13hmXNuB0qW4hS5LFAaAidBhAj7YL8XcGAZ4fvfVWz?=
 =?us-ascii?Q?JLRWpVZgK1CZSXDZkWx2upInFlnZuW93uuIeozlMpFAFoNq3zGq/50tmyE9X?=
 =?us-ascii?Q?iNFqmjLYVFE0qDmIv7RER6mHU4VbbomTfgMFa+dMVdmTfLPl+sNdfVuCp27R?=
 =?us-ascii?Q?MxTbeGdSmt5F7FyUCJqTVhaCB3yTpO5p4rWPm4Ej+c9Tx9ZZchbjlAZeiK3q?=
 =?us-ascii?Q?Q4BhM03Oh5ogYtQjhebxT366IaNSJ4Faroo2x/yrLd6vRQ7f2jUSgyuNs/TC?=
 =?us-ascii?Q?jMRHcQ63/uUF5fXk87rmJ9XkYTYhqbMl+m13rA5GSYzOjOOrdvqRikygMkAS?=
 =?us-ascii?Q?EsWuNO1P1UloSUex3IewoulzwhPxXFp+Wh8LFVbKHdycR08OOf91LTbgvWnM?=
 =?us-ascii?Q?Z59eG+tEH5QDQQAeFSocT9xx8+ucpk7mOcm7TWjhgMoTswLnxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jcwI41eFuA4yEFn+4uifivT6Aic1oJuhzodzNXhSLMo1oU4/Vje9zynFHkxN?=
 =?us-ascii?Q?GrzA9vRdjCYC4wSYFGWXTFzFt2vRZQDbkoJFoDGcxPy2YuOifGMMC2z2eMyf?=
 =?us-ascii?Q?kdNVxf//xTslJlrojfDQESIxSk9j8yiPAqGLRYfwEeHlZbzG9v1SpmsrbVi0?=
 =?us-ascii?Q?jeY4LjRSfcSxRe639gS7lu7LuTc/08nX/FPCaj0Afhbq2EwZQWg4uS/+mU23?=
 =?us-ascii?Q?UzKR83sFho3Xo9rz+Q1QlHmmwEtlzMc0I7dKft3p78mF90sXYF9HijTFgfVw?=
 =?us-ascii?Q?lEsxSDXwJti3ureXJ4QJxso9SLNBIX7nMh4k3d1hTkv/RYwNCM8N6xf6R5jr?=
 =?us-ascii?Q?DMyUc5fMrkWPQD7kHRJd1BagqB9dwRsoSnHbDAv4BUZHVxxdmg90UtZfRRUn?=
 =?us-ascii?Q?LjMMVnu8y0sJjve9pDGu3XSs+K+xnKAJfGcPvGY2tTXpCkyHyh4KH6J/s28Z?=
 =?us-ascii?Q?kVk0TbN4ExMmFFfqNK6lg41VSn6WZoM5OZFDz3pPVxKjiM6SE8X1C9HYdJXF?=
 =?us-ascii?Q?mk9+dmS9snrKQ4Tyo5AEMHePuVSDq/r+vryzgPKpsSDsda73a5Fy4SC6Taak?=
 =?us-ascii?Q?9pSE0JpUGs2i75k7z6GXvyBG0QILUWgJkrm7ZCau9mrXDZkJD1G4E9c9zbcf?=
 =?us-ascii?Q?lNlaHrxgCaAdCvCQ9a5eSqQKGRfkg0bMEDT4sGlEadyRzrDFVufq8niwhJYU?=
 =?us-ascii?Q?B2HV8d/gKH+SpdYIy58XCfQPM7H05vW+HrgIs8MzXOHT3Q5rnnpd3rMUoDoQ?=
 =?us-ascii?Q?1rpEjKhubMNN9sC+2rz2HmZjo+Evxej6/FlKq1mqDF2e4cicSqC5ufLEtLx+?=
 =?us-ascii?Q?V6FQPCY5rzoLkL+cRSj0t+a5JZevScbA3WYurvr2nY+GapdCivaPuplCXxWh?=
 =?us-ascii?Q?HTSHm2De1Jg12GW6V4kUno3LpjlH4wwKTaz0B3yRSE+TW0eBLttnm30SlvxX?=
 =?us-ascii?Q?cniV4i/9HAcsnZZCS1taj13ehPTz9vC/ZatEtVkjzKoBN6WtrosYXWUNPwvK?=
 =?us-ascii?Q?Pb4JBwIdCFKgkMOJ4L7xoX60lrlBImtu4AOtnhyf9znfVdbwcYOeTwzkKtTg?=
 =?us-ascii?Q?rq/GSgkplNFTz0IDDD5qJxDTzkI1DnnKNhwaYAvFcVTNkqw2wUhCo4YfDQKU?=
 =?us-ascii?Q?PEQvkIgvTWjUay7ogofapJ4R0+RLJxqhGLcInMa5eR1SXoWezjeb5/65gBfm?=
 =?us-ascii?Q?l/V7V1d52s68KFPnkoCH9wjTpl5KKYQeNBxzAGuLROfqCHbEIiN/FL483Nid?=
 =?us-ascii?Q?n/lnEHGwNnMJWRlklY44EBm641TDTBYCrz80T9lfhmNoruirFLmZkPqaN5UT?=
 =?us-ascii?Q?ek9fAIvWeRdgddx9h/sV/SI/QAtQZhhMx3iZ/uWIq2uSfVRKScgE7cQ2ku6Y?=
 =?us-ascii?Q?TfU59hmKxVxchEcasz4sQkNlImLkQveOjiiUngDdQTg3SkcWyeCflbzJEbSp?=
 =?us-ascii?Q?dwbqhsDnVzykUNhKEIeGCQLJ3exAPiwLkpg9MnQyUavOHa8m9ErvaN4OTGsO?=
 =?us-ascii?Q?nacJYUKApA8zhDLsAF6mvgN2wumzRC5FM9jr7qdk5Taaob1HtmyVG9W96ESJ?=
 =?us-ascii?Q?wcZdr+l04eW2CZeXauUNPiptoxAUlszKlXSLxoCe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9c3a62-d7ec-40b8-8f96-08dcbbbf2aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 17:41:30.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iv9tQ2MddffwUKPuGNoBp0Ul/5QFn2Zy/WwUFI7ZYcjDpP2GwvsXwZXS9y4HfXRvgfKYAFmnYSileVYeD44eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Maar=
ten
> Lankhorst
> Sent: Tuesday, August 6, 2024 4:21 PM
> To: intel-xe@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>;
> stable@vger.kernel.org
> Subject: [PATCH v2 2/2] drm/xe/display: Make display suspend/resume work =
on
> discrete
>=20
> We should unpin before evicting all memory, and repin after GT resume.
> This way, we preserve the contents of the framebuffers, and won't hang on
> resume due to migration engine not being restored yet.

Looks Good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/display/xe_display.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_pm.c              | 11 ++++++-----
>  2 files changed, 29 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/display/xe_display.c
> b/drivers/gpu/drm/xe/display/xe_display.c
> index d544d18ad1ecc..4b9ce1f34f4c7 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -283,6 +283,27 @@ static bool suspend_to_idle(void)
>  	return false;
>  }
>=20
> +static void xe_display_flush_cleanup_work(struct xe_device *xe) {
> +	struct intel_crtc *crtc;
> +
> +	for_each_intel_crtc(&xe->drm, crtc) {
> +		struct drm_crtc_commit *commit;
> +
> +		spin_lock(&crtc->base.commit_lock);
> +		commit =3D list_first_entry_or_null(&crtc->base.commit_list,
> +						  struct drm_crtc_commit,
> commit_entry);
> +		if (commit)
> +			drm_crtc_commit_get(commit);
> +		spin_unlock(&crtc->base.commit_lock);
> +
> +		if (commit) {
> +			wait_for_completion(&commit->cleanup_done);
> +			drm_crtc_commit_put(commit);
> +		}
> +	}
> +}
> +
>  void xe_display_pm_suspend(struct xe_device *xe, bool runtime)  {
>  	bool s2idle =3D suspend_to_idle();
> @@ -303,6 +324,8 @@ void xe_display_pm_suspend(struct xe_device *xe, bool
> runtime)
>  	if (!runtime)
>  		intel_display_driver_suspend(xe);
>=20
> +	xe_display_flush_cleanup_work(xe);
> +
>  	intel_dp_mst_suspend(xe);
>=20
>  	intel_hpd_cancel_work(xe);
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c inde=
x
> 9f3c14fd9f337..fcfb49af8c891 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -93,13 +93,13 @@ int xe_pm_suspend(struct xe_device *xe)
>  	for_each_gt(gt, xe, id)
>  		xe_gt_suspend_prepare(gt);
>=20
> +	xe_display_pm_suspend(xe, false);
> +
>  	/* FIXME: Super racey... */
>  	err =3D xe_bo_evict_all(xe);
>  	if (err)
>  		goto err;
>=20
> -	xe_display_pm_suspend(xe, false);
> -
>  	for_each_gt(gt, xe, id) {
>  		err =3D xe_gt_suspend(gt);
>  		if (err) {
> @@ -154,11 +154,11 @@ int xe_pm_resume(struct xe_device *xe)
>=20
>  	xe_irq_resume(xe);
>=20
> -	xe_display_pm_resume(xe, false);
> -
>  	for_each_gt(gt, xe, id)
>  		xe_gt_resume(gt);
>=20
> +	xe_display_pm_resume(xe, false);
> +
>  	err =3D xe_bo_restore_user(xe);
>  	if (err)
>  		goto err;
> @@ -367,10 +367,11 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>  	mutex_unlock(&xe->mem_access.vram_userfault.lock);
>=20
>  	if (xe->d3cold.allowed) {
> +		xe_display_pm_suspend(xe, true);
> +
>  		err =3D xe_bo_evict_all(xe);
>  		if (err)
>  			goto out;
> -		xe_display_pm_suspend(xe, true);
>  	}
>=20
>  	for_each_gt(gt, xe, id) {
> --
> 2.45.2


