Return-Path: <stable+bounces-230991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kzFdFB7hyWkR3QUAu9opvQ
	(envelope-from <stable+bounces-230991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1160354D1B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3880300E262
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FE392C34;
	Mon, 30 Mar 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWcOde/d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B61CF8B;
	Mon, 30 Mar 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837976; cv=fail; b=NO9zV4RcPrDJ3CyqTGKM2SSEwO5pzgn1Ynn/RLlX16+ah2bvpRYrwCrPk8qpmxk4TSNi1VM7rArAczFpdMtihIuuflLjCehsGJztw707jWLxReE+8pst5lJnoTfXb06MMWclgrlR8ndj5YTlYLjqWHVG0Cls6942TQl6mXkywdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837976; c=relaxed/simple;
	bh=0zFW25tCGcSc7dCdFJMGCWgw4q/UvTkS3BeeLvdTPTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHOIf0P4k6Qijxa7a/S5q/xwwl5tX5CdUMWaE6/REe1PXORzDcSLLZVt4D0xEcGzlcWiLmVBQikTiy2BrB+zF5dTK3iqf3r7UkyTHAbSfXKBPu3pX5d5vOqImfc18B0dDGPrUKg4HYQpLRlalDC4/5pm99rQqGSz1GM1OIWzPiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWcOde/d; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774837974; x=1806373974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0zFW25tCGcSc7dCdFJMGCWgw4q/UvTkS3BeeLvdTPTc=;
  b=YWcOde/dz6uAzBHCE0aODtIYtGjaCqYBVXArLNQgdSWEUWzMfLi8CFf4
   eJ3QC8sTXsEI8PLs4FjCVQNp8VgZiBI8oYbGD9tapoLHsnu9i0ZmVo2M/
   KI2uz18zisIIEaJSu3i3hHnFRBgUBl3tcBxXi0AYezvA9vX9tKorMg1kR
   ycmI/vM59+oaHiZGDV81/OkkPdTLoU5B9jUMOtDp6cO6zpVjy6PT11WLe
   Lt8a/TiVcXsPKWuFRpmeQxXU6Dkjn0/F5NRt5/uKJssDScUSNkI9/xxdN
   m6hLilvq80w38WiirHU5g6q2ojvYUSjU5tPXtMW+Yn5NXu0HomJbyKo7h
   Q==;
X-CSE-ConnectionGUID: Cg6DewkZQEOYDnOduZ5Dow==
X-CSE-MsgGUID: Lg3+KyX1SPCsTaV/FfKDJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63375762"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="63375762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 19:32:52 -0700
X-CSE-ConnectionGUID: wO92hzY7SAi3tKjG9Z1ksQ==
X-CSE-MsgGUID: t0VthLjWS26eWnFZwV8UDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="223053018"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 19:32:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 19:32:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 19:32:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 19:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDqnRFklY/y3PfzqNd6b131EClJPGNlNFKKsUrHoNWbk7SbiYd66KpTSsA3SPYagXsht18HsctF5YOoGp2VrNAdCKnU985zzw1BD9iyOJMD16/LG8D8TDjvm99hEmQdNp0C61nGeKsYyn5DFj0iYq6d/AqHWDV/KpJudY98UIyJmr4+KR2fledGwlXXwNF3KB16zG85WrJSDPGuAolqJUAOBw3TJetNOfAroE3jXn1Kix7swMg5Zv9sslZZD/yYuv6AlowOt47eVXDJ4tXMJdom4mlnUIzvIclmY2bWVEBCBCR1C0IHxV7PvHnDG89FOO91f4y0abyhG5O2ISSWMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibU0MM8DRRo306ssOTZrC5xshQHdZb9jUFeNrA6TyRM=;
 b=UKaJe/dnkFoGsI5qIeVhFEPb8EGjm25tCKIioMI0z6ZQ7LstC4MrdX6JxnRSWmhN6IL7S/xnm+USQwq0ccfaDpoJ2JNYe9lpZZPtb4EEFkKrthINZ2WndRsOH9vv1dOr0rvhneFeR1fXyA4T5M8E0bzUycT+ioSJ/qUkEJlkI4QtCC1iCCMpXSNsSnRW1gYZgm4PBWmRcyvKxEGKGaMktHNZEVv8EQBllqZ0umP29aIBmBn6eJHt7K1W6v4aDZ+vfa5iGQgnQ1DiASEQHnb5QcgnCrNRC7Y+RAL4E2KqFZCQ5zqlMSV1LB9w2IL3aWe3hUwMq6Udz9aWalKOtSyjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by DM4PR11MB6042.namprd11.prod.outlook.com (2603:10b6:8:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:32:46 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 02:32:45 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Paul Olaru <paul.olaru@oss.nxp.com>, "Laurentiu
 Mihalcea" <laurentiu.mihalcea@nxp.com>,
	"sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
Thread-Topic: [PATCH] ASoC: SOF: Don't allow pointer operations on
 unconfigured streams
Thread-Index: AQHcvTBfv5wVFO9Vh0quufpw8d9N+rXBorvQgAD11QCAA8e+EA==
Date: Mon, 30 Mar 2026 02:32:45 +0000
Message-ID: <SJ2PR11MB84249C2BDB45CF5BCDDA2245FF52A@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <SJ2PR11MB8424B402A94D8CB8A178BF14FF57A@SJ2PR11MB8424.namprd11.prod.outlook.com>
 <aca0wNJokCY1ImEk@sirena.co.uk>
In-Reply-To: <aca0wNJokCY1ImEk@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|DM4PR11MB6042:EE_
x-ms-office365-filtering-correlation-id: c84092b6-9692-43ea-a44a-08de8e04a088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: OHBdM+oSn5UqSbawckEOCaJtXkr/TTF30OMuyArBsX5N3UoMnkJ3LSZufJRnKcFEru9BKp6XcrrSGdp7czXBFdkqffNW6QUmbeLOiec5xKv6nq5nCmjUkyzR95FlEEtDdo+HLNCDfnnDfc0CZL7F1O5Ad+BDi4zl5D3wNdKPGzqFB194g9+nuSuGhNNbzcnEKrS/a2gSeWc8cP4p4IHfPKJuviL6A0fOgI0b9plEPcN/l54KCOuDumosgRqAWqM73dtlmitUVy9Q75VypTz1GQRDt/Vpf6SZef/yTBQxCVfbwDuEZt3/dyzAZ5KkN+Bdxre+e8DzGORuw1D4HCzDtkEXcAtLh7OvjREbEGdmxiQgyDmc2mTCs0kKZ3WR5cN9U/1HZTfTQZE+UwE0k2Es61/LCVbXn+lEiqQsu5jNRSo9FuDWGrklpVAKZQ1ySBG1rJofDnYsFcovCnLxEa497QVavKF3tDSQ+LUQDm4DiLxy8mjDo+VZCbezSiTuFfrptCPErObg7exNCwp1FlgSDs+C63AZ7x6BU3mbnvNSb08SvMxP0QlzbOuJ1db64PH2gtT0+YONa97fYxtjMuxN5855STRc0Q61F2xWP4p6YoO9HPuvcJNbZ/VLA59uiBKQwX0QeKQsYwkiKWGU0oTd/JCAzA1t9n7lAhHlGQyKOxOGpohlwOlEYip5Y+7otFuSOB7+VyT24H64E3BmkzRY+2CbgNl3mDrKwESc2w6JVEwazi6OmQthwFK+F7rOlrFjOhhaFeNflEy39rtOLaj9LmKbqhio0wpuaSgLOjWfAOk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jmGNA5FDb+d2AkotWoZn5QjVH/2AAzAyMCh8cQ8qaDnHIhi8mv3rClK8z9YL?=
 =?us-ascii?Q?Sf5hiQkYyQ9ba2zB9wYLrucKI2k8k11lRzhWVyLSV6pwt6x7aejjJz843ZiQ?=
 =?us-ascii?Q?/79rENyyltc+OaqoNpGJJUxa0zvDaN8LbRVzgcQ7uP00t8htphtk+5FZBBAZ?=
 =?us-ascii?Q?keDb7Sn3P9Sg/x3ZYJWZbM43mnoEZGPbjWSAQvWj5tVC3ue4XGbpouLlbgnZ?=
 =?us-ascii?Q?a+rLcMs26jdvxq/G5Wonu+KREsHIZxGWX7Mm3iXxjW9aeGEDNq3mmlvAeRvS?=
 =?us-ascii?Q?3TCcIszbotaJ/pN0q+ewoIxK4WtBYAQ/4w2X01DNzr4nEmYza8WCwBuxgVJ0?=
 =?us-ascii?Q?Ob2s2WS9J58VLQdtjlD9iP7NLYTtn9Jd+0DN5PQvs8KRc8hI++9FNaruxdX6?=
 =?us-ascii?Q?pu1dF1b3uGk5q09WG22ZcinKHuohcxot+B54rrksy0N2YgBiPnkrdsan+UHL?=
 =?us-ascii?Q?43dLkq7k7RAP98IBQX5aaBFkeDqb53InI4OcIJHxykvhl15dOljBJhe7ohDd?=
 =?us-ascii?Q?JKrGi2dhVFj/0Q3SkKssb3hi/qRbaCoe92lshQoBbqnvLYsjFgpEQo0qJojv?=
 =?us-ascii?Q?mq4Bxs4ZOwOKkvRI57d2kJWThxchdkUbBbPCkg8d6PHeDLuI6afbBYhzKUAz?=
 =?us-ascii?Q?4LdkYG7/cGI6KPmtwPV6RZsakvEp8CRP2aHGPP5W8XKThXGf3fZuVkUd8TU0?=
 =?us-ascii?Q?cHFvDu3IfzN022BttoDTRSYwz9Cv3qldeqDt4B6frDMAx7zjas2+XNId2PgW?=
 =?us-ascii?Q?f2Fm4LVYeuqij1gs+HkVpugSE3JqHaHDjmbR+WJhY47k8dMiIsJFLXA2Z1fP?=
 =?us-ascii?Q?1EalktSESBUtPqED2gCuBE90qS7htIc+lNb63MpVqi0ioWVNC8ndob4ftjuj?=
 =?us-ascii?Q?hbWoozB7oJeaZRHYomGTx91u99MVBqNFl3k7mbIBg4n7dpboWDMUkdI1YzeG?=
 =?us-ascii?Q?OeS+zljFTrduh+p/KZj+KaAZFEUorZCtnSfyoCyYlGanVmXrpX8CkyIyp0DB?=
 =?us-ascii?Q?sZvAvlKha2G/Op+mVNUCAO+rELmLcsrGRernFRtGS4DXVQnPhnHIE63BhSYC?=
 =?us-ascii?Q?3UrXxXoqnPsYrHveZl90zNAg5gYp9bQrdhWeDQMClviQVss4/VTJYYoKBRps?=
 =?us-ascii?Q?Jey5RdGZ0ZDelzk04SLVbXP0GvM8hs3st5JcMEqjl+hleEkYaLfEoK9OeTk1?=
 =?us-ascii?Q?FZwZD3MW8V+fQzpmPzKkaplYiWlSbBs0+QFEKcwj9j9SrbK/cB2NPULYx7nY?=
 =?us-ascii?Q?Cpje3yKE6CCxfZv6TbE83zN/d0FJ7QAOQ39KYgKHs1eF/PrFpySgr6pmGoHI?=
 =?us-ascii?Q?gm8OuIvP0BcgI1mvNy/nY7rekRvn/7FiMSKFfOwPAw3yNXmZNDzfopjHgSlO?=
 =?us-ascii?Q?PtHigUbQ9N2HJSB2lL19EkjJbe6KOmBDZ06ZsJaNhjBHfzeSr5x3xidZJtS/?=
 =?us-ascii?Q?i8+K6N04LNv3MzLbc2tXgqQf9tddLgqPtMLL7P0SjzwxRJCnkJSrRhLvUF7s?=
 =?us-ascii?Q?PEc+U6jn4Xmurph1+YFyzrBd3TAV/EHByrFATsQ37gTo0bCwO9S3XuSP53xX?=
 =?us-ascii?Q?nI1xvbIqUtCE6lK45KzHyWGvESIfpp3HpaaNfnIBJo2jCzOrzxuh6fyjSANy?=
 =?us-ascii?Q?uB6kSAjgHPITldELFtY9mie0PBRMgaO3IOSVWscHJHGuQugKIJAOxQOZnjL6?=
 =?us-ascii?Q?iXWbT6O4bv6xeDs7MzonyIuChCeG3Mi4XgdVomRFwAydqv4a+c3SlrnVlys/?=
 =?us-ascii?Q?L+509EuF+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FPtbdufHPBbJYNRXnZUSoT/4YUtODgIldPrtguOhRo4ubZuh/hKUGUW5shOuMkhLIDOV+NNFVHrnFX9Gpij4ZhVvjDXPhlriVYY+Rh9o3Hd/12WvM5vHSn+oBdwmn55uedTHk5ShvwpHRtdBsxJIv0Y8tb2hixLBmCl81PXX0fCfz3DGcXFc465ONHnzhufwbysYUX3UNDoTcI8pDtdTDLLc37Jns34LoJgDxacimV0ktDUx7pjZ0OXw8gdGESlUCsHRiD89B8yFvMVUN7GfY8eawTfJsU17qmT4wkVO7gQwjZA0ALtlogGVLZrp6xuhh4qOGhxwn2Wth0ykcmDxdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84092b6-9692-43ea-a44a-08de8e04a088
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 02:32:45.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlcoT4QuVP3/3id9yA5zZWZP1cHFFwtXo02oCbNYGmvY1730wsghqNdbtLlf/4o//m90ZBpNvNzFLxiPzfLB9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6042
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com,alsa-project.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230991-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bard.liao@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A1160354D1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Saturday, March 28, 2026 12:48 AM
> To: Liao, Bard <bard.liao@intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Peter Ujfalusi
> <peter.ujfalusi@linux.intel.com>; Bard Liao <yung-
> chuan.liao@linux.intel.com>; Ranjani Sridharan
> <ranjani.sridharan@linux.intel.com>; Daniel Baluta <daniel.baluta@nxp.com=
>;
> Kai Vehmanen <kai.vehmanen@linux.intel.com>; Pierre-Louis Bossart <pierre=
-
> louis.bossart@linux.dev>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> <tiwai@suse.com>; Paul Olaru <paul.olaru@oss.nxp.com>; Laurentiu Mihalcea
> <laurentiu.mihalcea@nxp.com>; sound-open-firmware@alsa-project.org;
> linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on
> unconfigured streams
>=20
> On Fri, Mar 27, 2026 at 02:09:40AM +0000, Liao, Bard wrote:
>=20
> > > +	if (!sstream->channels || !sstream->sample_container_bytes)
> > > +		return -EBUSY;
>=20
> > Sorry, but why it is BUSY in this case?
>=20
> -EBUSY is often "wrong state".  Could also be -EINVAL, it doesn't super
> make a difference I think - nobody should actually be doing this.

Thanks Mark for the explanation, it makes sense.

