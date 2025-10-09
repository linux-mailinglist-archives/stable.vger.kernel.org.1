Return-Path: <stable+bounces-183707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C58BC9854
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 16:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4F3188C647
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1D18C91F;
	Thu,  9 Oct 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzpHE9aw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203D1A3029
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020396; cv=fail; b=fWf8ssgB8PgJ65GeM4C2ghK9Dotgo5fwmU63CJ0efWlbUF9k4OnQUMSAu5ABPQRiG+8Fip2+1pDh2Vh1dQwJdpnCTb0wqj9R5+7lXt+6UaSuoiecMtsHiTiIR1RjziUHeo/3x1UaJb+Q90Fgr6ecrvVEnsG1oexMw0RKdb35yOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020396; c=relaxed/simple;
	bh=tM/46ZzuzGi8Opsrt3A73nqT7kiapVcouxanAcrC2hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=debeDV4cxhjRmbWiuBUI3fB4y7uL/yiPf+89Vnk3h3B/4ChMA05oAn3V+cxWc39fmfAW46gwSI3rnSUcSQeCcHkvZZr/AMDKNPk9EW8ph1zMGfE6/NAUGtbUc4WuWX8JlzXNqy+2HtrcJOtp11bjnxjqw/Nybe/8aS4SSD39opo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzpHE9aw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760020394; x=1791556394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tM/46ZzuzGi8Opsrt3A73nqT7kiapVcouxanAcrC2hs=;
  b=nzpHE9aw6hZU8oGoUVOiPJVRPa9R/95eTu4DzXZt+jCftjhHoGPWCGdA
   lE5uFofoWm1IXJWXggHnlgxIQMn0v8h+rpMTP1rBzqAIXPANGbPm7E7cZ
   NrRcRPsbKfXWMCyCl4fqkOgBDFbYOZkU/SwKN34Y9CJMVv8EV60r+e53W
   JKOeLgzkDMJ9YkiycBvv8kAPDk6bzXs/BiDJay/AfSRK/VIKXPjOaXYJp
   UPiXyvI7S2tA4U8qbE2sLGgVCNr/Hg9uZyGFCsUTYGC5FivdgKB+0NGUf
   LFLoN74V0nBAySjA2oGBAtjxV0W8Cm7hNY/EYWiS5xkPZKDmqehltWXoT
   Q==;
X-CSE-ConnectionGUID: oVNpbmpuQAmQeTEJRzXyeA==
X-CSE-MsgGUID: 5i3ZHDaOSD6M1OwNfXe45Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="65880221"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="65880221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:33:14 -0700
X-CSE-ConnectionGUID: pMJTtN/bTZKx3z0tQ8pOlQ==
X-CSE-MsgGUID: LVnD2qOTQHyyRriOJPTeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="179965460"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:33:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:33:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:33:12 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLe7+Wf5hv0nOj22ZYiqlHYmTDywB5JRwyXzyt6Hr/SdYosQ2Tj2n62eXr9XGApO8hFnh61BpKWp7UwW5FeJ13D5gmdfhrmf75hre3DP6VAXN0Zsc/qCGv/o+G3Ph0kpaTYu8AxsXFXipkTN3oP8R6pqbsNuPRfPgCOolTa+FiqSwrWmjumdDaHOsjEOHiFbvMnaAws/F3ce9DpehDcEWfcnYDfFoie5K9pRWl8zdDkZf03gv8pWeWBj9BgVRrCeEIGdc3ZI0UrAWYonAaynLTZfv8yQO1NW/C6C10JJ1kZ9RdRNBl/nObqwwEiuUAMMi9/W0b6CJsTfj4A9BkOc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iafVSCKftyxp3GS6j5xPQznECUHVHVJQnoP1nKlfZsI=;
 b=kT49NFTxwbv04IEKEjDyb+QOQYvjfnKUjRDZDPy7mAJamtn2mThsMGtI8J/5yQypZm/PBPDN7vnTAFmiBbvxuGNxZf9WB4O05m6yuOlIqYzuQy3DHDleq4d7+SoRQzhp+FR4JPe2tOB6cBZZXTqaASLsTSK+CDSFJQQ3WymOS9ZOgNVF4ByBIZMoz8Tji9/H+RhXOxvsFFdvF4VINaRMzs+riD9M0JaexT/qIKecUtCiYW8lbCRulFss7uII9Ls3BL8JpnjmF2YAGVD0jN1JvNO49ffrpL1CrvLs1e6fh/irW5V5FLh3oSJ/70byg2ByANpdFqdTBfLXoiGSs6F85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 14:33:09 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::b23b:735f:b015:26ad]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::b23b:735f:b015:26ad%5]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:33:09 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: Kenneth Graunke <kenneth@whitecape.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Maarten Lankhorst
	<dev@lankhorst.se>, "Auld, Matthew" <matthew.auld@intel.com>, "De Marchi,
 Lucas" <lucas.demarchi@intel.com>
Subject: RE: [PATCH] drm/xe: Increase global invalidation timeout to 1000us
Thread-Topic: [PATCH] drm/xe: Increase global invalidation timeout to 1000us
Thread-Index: AQHcJDaDLDPxkQAewkOnX6B87ADEU7S6B0QQ
Date: Thu, 9 Oct 2025 14:33:09 +0000
Message-ID: <DM4PR11MB5456189485C6F8A8AD53D6C0EAEEA@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20250912223254.147940-1-kenneth@whitecape.org>
In-Reply-To: <20250912223254.147940-1-kenneth@whitecape.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|PH7PR11MB6651:EE_
x-ms-office365-filtering-correlation-id: d2ae0b7a-b568-40a6-f76e-08de0740c4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?B4LlT9O3ZGyC1SVuZe18IR4qxB9hn/e94cbaDsQas40SH4/SKQ/Hpf8OwKpd?=
 =?us-ascii?Q?TnI0tOX0SxDV0cRRzJ0ZTTkTzirc/lWy5vQYbV9G6RGbyEUOJXwkQ/ZtC/iI?=
 =?us-ascii?Q?DsadUJg57TerNllSw7lx3GzcmBP2DL8V7PBuHL/wG60R+pjRzArbDXfBrKje?=
 =?us-ascii?Q?JV3CrvCWtjFQhHrKHc6YCKgoGjdu/eittzUYh7g4geAVAd4uk+NrS+/21l7Z?=
 =?us-ascii?Q?PGfjL3SaTNkKQZI+43SSIyYfU6EumhpXbmJelBvLjVBHSJhItHAoQIfuw254?=
 =?us-ascii?Q?hBZ0O8lgJtx00ANdd/rt8+VXYniS2WaPgHOAbNNwX7WEaBJZ9L3LJF071d1g?=
 =?us-ascii?Q?n7IBQAiZ36FnMqLya+s/nfnm/Ha98vVJtLcpULtkF5/wjvBnoNgvWUWXSp6b?=
 =?us-ascii?Q?dM6QLq34tL85bkzyWdASwasZwr1+/Bw4OwSsOlt7uFZ7BlVfIzsMcnftXLQJ?=
 =?us-ascii?Q?0OxIb7bdiBwhVuiNAnUWoRPTohz4CTiZ5quY+ovRKtgptUkoMiWvJQi5fF4o?=
 =?us-ascii?Q?OgXzRBAIYooMqNIpAVukpRes80INKfY6RPfF7gNJfOSHozpUnQ/9HSY3Y3AQ?=
 =?us-ascii?Q?eHP8BBANdgqPRuupxessGL9Sh97Ov/1hBh8m5vW88Qf8ty0Mh+l89pq+tsHS?=
 =?us-ascii?Q?0aDyW6m36OxjJPyJO7cmrfRVwbmRJP8a3cpKSyjIdgx2OB/IL+mbQhltpC/g?=
 =?us-ascii?Q?GqvH/WP/cKZ417bIPiDHLicVI/i3sDCBHZF6/rT3eF83rzumitBuXytNQ6Fs?=
 =?us-ascii?Q?YsG7fBttIkrHoJ5fRqroP34LlZNfOVz+tWfYi9WXwV49Lse2MCA3t4nzeCHn?=
 =?us-ascii?Q?scJAb+3dcn7fQwRwbtsWNxLd2TAXVhqEgP6frkmI8LyDfgRfLDbGkpODuQor?=
 =?us-ascii?Q?6bM/TA3aw9524cZ14m6pmJnMyejIu5rqBIO3BoG8M46l1Fy5iq2xk7Mw0fMH?=
 =?us-ascii?Q?57bwHBmfMx2PhBgpvL3mzKl2HFfKk7mVTFMOKxnDS3R7QFNeviOJ55locUwh?=
 =?us-ascii?Q?HMW3KGH8XWQuxKqTz6QyzZx0ApGHHhSr9bhMcG5NRxhSYgDtOpep+yf9EMgw?=
 =?us-ascii?Q?O5qwbtWJii/532txQ10YG0DIU4lvnZQWVqfvLkT3MiUluYkU3FgCiRY7Nt3H?=
 =?us-ascii?Q?70t2T523GAeqLHMIohIUtbqXYQMWAUDrAlCpSuyT5DAtYUk56MIMU9G7CIvS?=
 =?us-ascii?Q?+WTYwqUEV5rO98vQrAoJsWGfWqvR3x32Wu5Til2h7waLeIzvr+JBpyCWUumL?=
 =?us-ascii?Q?8pm5KBRnyHTGeF+okn0prjXQrRFsalrkivzz6uuuTvmZOQtQce5GierHqVoi?=
 =?us-ascii?Q?TdsrMqHdt+q5GCX1xpvDXzCIwy+wtOTWvPIBAQyfwZUYXri4BrKYpKuBSHGK?=
 =?us-ascii?Q?zuJS00MUtmH+hll3DNr6YJHjD7gRYW63AdGPC7+FtL5zGaJtaxes/gKnTqA7?=
 =?us-ascii?Q?AcT6mnsna5wi8tD/2YKUzIRaciTVokpz+9oZzNRstqi5fwopABlXWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2yEm2g//XEed1Aw0lS9wONpp/RzYvojOYH6fy/2wKcoA+DxPlEse631w7Q2k?=
 =?us-ascii?Q?EDoRcjF9Qc5T2LPuGyrVC18BMQRQe2CztHWsaVH1+3nUEnhTaGUvvjgPgtat?=
 =?us-ascii?Q?4xqoxVFoZgba9qqtE/afe4GeU8gJJcqv15dmoQN1qbKLUsxepQvwb+EACU42?=
 =?us-ascii?Q?X2nWjxL3dn9o3b9QBTEpt4NXEE6kV+2fh1A3ANc9GpPkDV4XRTOB/r1olE5j?=
 =?us-ascii?Q?orT+80ajiOYo8gUwSOs7tVbmZWlgtn3oOwUqITkEPF0g/wTWVUeocQ9nWqm9?=
 =?us-ascii?Q?VxwjSi2j29Mtd12IQf1rI/LSDCOGbUCjfc7hp58c9w4DYIWZCoEJXX0C7sgR?=
 =?us-ascii?Q?b35tR/NkKzsOzH56o+enpux7ik3hMh/0zqM9CWobAKMRuqxgSQeQbFsiXDSr?=
 =?us-ascii?Q?0YRApXUbBObUxraQ66DtuhZiqddTtlMIIOsz/id18wbFdeBMuEPhSpH4QhNz?=
 =?us-ascii?Q?Fsi9iRx1WDqtVjGO5V5dpQ07X0G7lG56FaeLj1qofB79CwR2vorMQDLGKyMV?=
 =?us-ascii?Q?vLG43D/8KrygqT/cRPL5BZo3klnI755v38kzyfeSCpbEbvgNZdeTpZhNLKHg?=
 =?us-ascii?Q?Krr5fhtISChQdftliPAdFjJ/LI68ZvP+gq+ocaxf7Z/JhDZzbiic6vP8ufT3?=
 =?us-ascii?Q?1txwk07rG/L2DAPOcDjljFO9OCqhG7cCDXf3MYe+KrmlatuoexSrP5NS3bpJ?=
 =?us-ascii?Q?diUB4xqQ6UKnSA/az6Fzsga6wiuZRoATecjQowrNarCqRxuPSiKMbC/1wcPb?=
 =?us-ascii?Q?9oZu93OGn6m1C5BWqfHL2e3SDrL1dHClZl+0JLl5J01zxtbOxjBBj32l/u1C?=
 =?us-ascii?Q?q1IDVtSiP2JPo61jFCURoF7fp3A6tw5mHbZttUQH7XAeDqN1BYH73F1EgJCj?=
 =?us-ascii?Q?HcUPOPvEAHbDw5jyy62VS6tMaRQA/BKjcaiVxBZg1NTvbxnwIc4zpPbhaAHj?=
 =?us-ascii?Q?YMh40MnyqSj4TxHCJzYb1DqXAm2eMubgvQ3x+MijAUZ43j+dYTpAi2E71hlP?=
 =?us-ascii?Q?9xpPhGhPPJY4yPS79OKuTD1oJaLzr43Qmn5GDpNCp0Y92tgC5uAUEgC8+k99?=
 =?us-ascii?Q?7aKd2JsSXuApLNl9ckDaS812V55VHj0ZiVAJdehOF86JOEh8ESWMzySPvRGk?=
 =?us-ascii?Q?B4v9WjCTyLvCxVJEv5JytmpzTZf0akz+a+MHKdSn6Q+YExJwSqX0aKC0A7Jh?=
 =?us-ascii?Q?6eW25+gpaXOdYJI0vNoAD0xCQgmPYRTKQg8SBp3ZYQBOC7FjA2YsYRJbvR1x?=
 =?us-ascii?Q?sPLp+3nQafS9I6RNC1T1BY+aQ85n6xN3kuSTDYYKxW7+SwXvzHJBNaSqm0w/?=
 =?us-ascii?Q?kgx2Q1A4BSb5O1Pmy/A30BJQxWTZaLYT5M2lMPO4jeKzvg1BsqN08x6e+UQK?=
 =?us-ascii?Q?rXvWHKlgDA2EODhPIO4jgjOKmB/yyOFRzyn3DuZ+oFBnVIkAaaGL17GW3wBF?=
 =?us-ascii?Q?pC//n11DMdU9mPz5nkhCblm7GjEd2jCtqmjuhvYhlZ6bC3T++c0RmHbkzffw?=
 =?us-ascii?Q?ZzOmuTqvIIr0uWPfWPH7R/14kPeMJfoVCjfduWia9MXWkqKPJzHK93LoWEIw?=
 =?us-ascii?Q?j82O8yYDFWWSr9XeoB6Cs1Ipi9ogHSuVCg6Z/FFRzt7DAHFh3ENQeYP9STpO?=
 =?us-ascii?Q?zub35zKCvXgfacpYyhty+bo0Qo5ewsDvU6xTgm/KT9s/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae0b7a-b568-40a6-f76e-08de0740c4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 14:33:09.6850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c70mX+lJuQh7WcYyTJEUP/nGG1tS3DX8hv1GwO7zGqcWCHutSR28T6vv4LUDCm6EvNaRHBwP2EgbZ2w6XjYtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

On Fri, Sep 12, 2025 3:32 PM Kenneth Graunke wrote:
> The previous timeout of 500us seems to be too small; panning the map in t=
he
> Roll20 VTT in Firefox on a KDE/Wayland desktop reliably triggered timeout=
s
> within a few seconds of usage, causing the monitor to freeze and the foll=
owing
> to be printed to dmesg:
>=20
> [Jul30 13:44] xe 0000:03:00.0: [drm] *ERROR* GT0: Global invalidation
> timeout
> [Jul30 13:48] xe 0000:03:00.0: [drm] *ERROR* [CRTC:82:pipe A] flip_done
> timed out
>=20
> I haven't hit a single timeout since increasing it to 1000us even after s=
everal
> multi-hour testing sessions.
>=20
> Fixes: c0114fdf6d4a ("drm/xe: Move DSB l2 flush to a more sensible place"=
)
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5710
> Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
> Cc: stable@vger.kernel.org
> Cc: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/xe/xe_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> This fixes my desktop which has been broken since 6.15.  Given that
> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6097 was recently
> filed and they seem to need a timeout of 2000 (and are having somewhat
> different issues), maybe more work's needed here...but I figured I'd send=
 out
> the fix for my system and let xe folks figure out what they'd like to do.
> Thanks :)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index a4d12ee7d575..6339b8800914 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -1064,7 +1064,7 @@ void xe_device_l2_flush(struct xe_device *xe)
>  	spin_lock(&gt->global_invl_lock);
>=20
>  	xe_mmio_write32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1);
> -	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 500,
> NULL, true))
> +	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0,
> 1000, NULL,
> +true))

It should be safe to increase the timeout value, since xe_mmio_wait32() div=
ides the total wait time into several intervals and checks the MMIO registe=
r value in each iteration.
In normal cases, the actual wait duration remains unchanged, while in abnor=
mal cases, the extended timeout is necessary to handle longer delays proper=
ly.

Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>

>  		xe_gt_err_once(gt, "Global invalidation timeout\n");
>=20
>  	spin_unlock(&gt->global_invl_lock);
> --
> 2.51.0


