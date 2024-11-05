Return-Path: <stable+bounces-89918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F49BD5D3
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA921C20E92
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D031E9073;
	Tue,  5 Nov 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg+VYsyz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAF1DD0D0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834794; cv=fail; b=mve2ByEDvUqg8mdd0DkMTgU/CDcQxP0i/JterWvr0XzkWvqm7uk8p3Ro3WifbFV07jsiuC+PbT12PJ61Dml9I+GZOi5JMcoPTKVMY8/Rx3Nto2as3UZV9PzNhuidtsajeUGva34hez1BvmqlzhKPVLyA3UW2bu3Aj0MIJcUHDxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834794; c=relaxed/simple;
	bh=N6CvKBsQE24wa1LvjNd65PFs/SlQZWqHoBHOhW2yAP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qHJB0uNQuNAFoxAutWwwIStXItt7xRedAk6Jjmxx7s4jpeQkjsMbj2NYC62TZ4dAnS0eSvkmQmcl3CKmwmO7qRPNaW6FURjg6gpE2LxTpFJP1cOLPr4J1MQaO36kiXL+ymZrlBzVVr9w1EUkHbpOg94Mt4iVuqxZfkHIMcbx3lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg+VYsyz; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730834793; x=1762370793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N6CvKBsQE24wa1LvjNd65PFs/SlQZWqHoBHOhW2yAP4=;
  b=Rg+VYsyz3gUGrD5YS0VKtJtQy0CanIsh7s7MNVMOnd/VEfUmoWh3Db1H
   byKIJHW/WPHnfk7CT02HrU6QwGklIl1/6RAPiWIhCstgJOTkGK3QGHdiH
   YH9PjYfp98hn6ylrhm8CLJKnmjvQ2EVJU0c0ajQyY6xuzK4pvbIa3gU3k
   D+hHcv6RMjWWkDsbmTKsHgPUry+bs44LPd/6/2TTrOMsoAipnadOMBPCZ
   PqGGqxAAzYTxodGWDkchfvL0Hmjk4oY1gAf46PR9srVYU3+vAfJP+DRQu
   kTJ82+iSDR/wD9lRfM1YDuzZMhAvft0ji1tMXZIQPEON2OJDyybSM5gls
   Q==;
X-CSE-ConnectionGUID: 5Ol7kMm1S+q6ktGHq3YT6A==
X-CSE-MsgGUID: 65qnDmRSQ6OABYa06sjI4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30777356"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30777356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:26:32 -0800
X-CSE-ConnectionGUID: C6kKJCJFROCVxfxMPEStEQ==
X-CSE-MsgGUID: 50G75PPqS6eJRKdRtTYfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88088909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 11:26:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 11:26:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 11:26:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 11:26:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T18R5C9VBdTbcf9ZQ7/aJV4uuW9Omf1bzVdzGAM97RrduiDog1sxvCKpkaHrifgOmAnNU6SNw9JwD2S7FKREyfFgXnNSEHt64O0/hElO89z8sOYrBQY9AXkSmyGHvVfrPq/yE79bFET0TeYEqjX4FXZjhYX++LoCeJbLRRcK6uAB+QbElC+EKDeD9UdsoPZZjlfJDgDqplt6A5g46Fk6xOhN6fL0SC3uAJVZzU5h8Rjje8/2+w5PimctqWidSxX16D6qG8rn0cerKEIlyUdAQCx0RBA05T2KGTxxuORCONrC6wWlD7Iv9AV20uGn9zITF2IbeJtwRWsFaKDtu4m/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XvuiPg2x1pIvUlQPjjNrzGPSbDWdwDyQj9PYs0ZmH0=;
 b=FidrKi7hN+d9dC585OOOkiFZ57puQeToDdOZBBiv9pXGVdzkecac+Tq0/L8S7PpaDOYjYNkR/Mon7Y9CGuenM0uvsltx0ZuyAEO9kALaSd8zyKBamN9ol6YXI3ubpl6z/UxsGEsXgNO1kxpfspnOEC0G82MZqfwJ7Y+mxqSlQMRghp7EmPk9nINBr71HPE/1KY1fqrAh4aICHCd2JC9rcS4hmZ5m8FlBEOszTZKRpjrMyKm6XUFni+I1l5QHmdr0VjmoXrUBlps9+Qo6ymu0hds8kRafmRUYzpS9bOxSBB5NE4vlxK6SurQITw1supCdvckaC8zVF9jyP45AMFcdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:26:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:26:19 +0000
Date: Tue, 5 Nov 2024 11:26:50 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <ZypxenMNvxL17mau@lstrano-desk.jf.intel.com>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
 <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
 <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c254f7-73ec-423a-a900-08dcfdcfb987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lt3QGz7BazM5QfjF2YnKrmFfNDKHJcdre4O9K0gbaRlHkLxbjvyTJCUrDU9X?=
 =?us-ascii?Q?oXDS8q3WtbsIIt+bpd2PvJUHOIYp6LgYuWA6F1j1M6G5aRj9Fq7YiQZ4iqUo?=
 =?us-ascii?Q?YP70anlAS27Vpkl57yQJR0Y6crSmgUfYCkPuR7oQ4YsMCVBf+lBvIFpZGWKp?=
 =?us-ascii?Q?5gioaw9Il//ea+EKogRYhxZZoOUDKTPxhdOGaumv0v5WDZjVDADm26fpQKWO?=
 =?us-ascii?Q?120VATQT1Viq4WDeCNndsHBWOA/sOAQY5pNSUsfsFEJFo8VmivWYLsmnXsB6?=
 =?us-ascii?Q?VNxcn7wNjCYN/3isyuCZiFNTiNj3c8+L5xiH3r6utkZ5LiqSMmYpul0Y/U5O?=
 =?us-ascii?Q?oNvsP0ryCRa0PVx4NbUDFQGxcRVjqvieI8Xy525HYyXgwXqDP4+dnkcvgBo1?=
 =?us-ascii?Q?Cv/2L8V7kyambuZKWNgqGaUExUCGIGwL3dD1XnaRJ7svIHoNYxoIY7hvaS3O?=
 =?us-ascii?Q?NWclU+jgzi/jIXExSNUu3uMvX6tiUSJGOD/GNKBAyrN2ZvTxI9GBtUa1r9B8?=
 =?us-ascii?Q?GuaA6bp90hQQHj7olbM8DJlXdFnh5bGQ18DUKcOK0MocQ5n/4AvtPt5bSnUz?=
 =?us-ascii?Q?n3E4qsc7rPKN2nO2u3ZCjO9MwwDa1j5/Tv+VSgA3TzEK50oEPhJpV9655swK?=
 =?us-ascii?Q?jShT/v2w4w1OxwKSATOcNR1EcFas/HXtvWbK7MS0gTzQMJxnV9VljzQC5G3U?=
 =?us-ascii?Q?M+45HY7AaK6LIEh7N0OjNg0qdyieWwsniJguW6k4qCEMbQPA3BCcvWGwIVVT?=
 =?us-ascii?Q?lgIp5gUf8cbKxgWxigN0HYBMHix4RdyzSGNkf1UUWH7LwT9hNfASYTceCfVB?=
 =?us-ascii?Q?u9zo2K357cCjUdVVG54P0/yBWEPkJyFhp0Ej07KD9oFfYvoHfzNwOyQKawTb?=
 =?us-ascii?Q?uF2TSaIM4ajBR30zIxPICtPEu1OVbnwjxcoaKohQF8sDRfDna3RzGtSj/z+F?=
 =?us-ascii?Q?0uIm8tFHDh5UwRxOm8QeSn9ELp42rzQ5qycse/UcjqcDArRSWn5hEz2uca5g?=
 =?us-ascii?Q?Ot3YBjSMdHlOY0QocJ0u/I3nrsljn0QowgAgfrP+L9qJ9IOD53dsMWSWPkSt?=
 =?us-ascii?Q?8cULb28RZZqNY7v9MPFranXruOR/e9nSgXHNPkE8IMm6I31VaEB6pRxjuk/3?=
 =?us-ascii?Q?ZmejGdpgqNLrHTynVtcGJcsZcPYl5N3Z0Slgw1g38r4WUyuOKQK+px/73ZDG?=
 =?us-ascii?Q?rnk1YtII/ngqMS0t+RBEm1Gzw9BHvGMg1ZFz3R7DnRWKp6cPrgeBzqWMaylP?=
 =?us-ascii?Q?dV4OCMgozvcw1tLhFsA5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQWPFD5L2iMamawtL+vMIoN9O6Ch5UF8dGrtqjX17D2XYZO0LNF1sde6Z89K?=
 =?us-ascii?Q?Kmu72coSDo8RHCWeSiHu+icWrgHyf9SpuvvZP/23JcwCD7hmxWVVGSKCfTay?=
 =?us-ascii?Q?iaRCRTiqk+gb6Ma0GbGl1SnrlTArtcBVTrE6GbQirz70VFQEviTMl/luS+BP?=
 =?us-ascii?Q?oDOreLFoGUxJ8EB7CQnk+jRsGZwwQWIsYIYiRUJUTUbqAAid3gSlDnWPg07W?=
 =?us-ascii?Q?ZBHlS/JOhfy8eH8KRdwdkc8fe7Y5/9TgYAdKxljEApeo84uaFBFitsTd5Z2I?=
 =?us-ascii?Q?6wALCiWVonyB3pHb6h4MkCsggZTcqNAll3gFZkh+NmsbQluUp6cywouFqcx+?=
 =?us-ascii?Q?mIdm0SVOZQrbDg7KNAwljuTR5Hu1VpGKjin0Wh9ESDpoTkgqHDS2DJtWNWo8?=
 =?us-ascii?Q?mcrRCZmwVsjlbDuyvMsw7UC3TH2jkk/wfmd/O41of16OiHs9nr/7uhQtlVSP?=
 =?us-ascii?Q?Yn25M7+Th6XEcQ9rKoDHKTsqRpU9AfmF8WAHrV/YD172RAp4WDVV/rPJpfAq?=
 =?us-ascii?Q?v53CSpI5+8WSQrtgHThCEpO5hB+nZ1TZ4eTmCWiDSK0TKQ0u/r+uH+9lVrGk?=
 =?us-ascii?Q?kR5Rc5CwhJ0VueAh1xsTnVd9SzaGxGkcvnOVFFy3p2vogP6wqxLQAKG/zuHP?=
 =?us-ascii?Q?v9DpMv08X+aM5GdDzo6/lDMVNtRLFGoRED51BoUmUIm4zYJs+oyAvv/frl83?=
 =?us-ascii?Q?ANwYovKkAJZEdvzBPoTzSv1e1MEk1IJ1jeeS9n+j9GN6hgPqdVtG/GwufSGF?=
 =?us-ascii?Q?75j8M98lo9lO5W8MnKPP8Dua6zasL2lRpRrw0TOuDd82pGd6+yFACZKLEyDB?=
 =?us-ascii?Q?Ns13xowbNLAKwZ88jLfDsltdwxjjWgfELHOMXz/P30Xj5a9bJm5ykrhiLa9q?=
 =?us-ascii?Q?cLOtWXNdNIZcG4gHzeE8aT6kwB6976jONza/12EZTFLHDQUsfhqDKmwGJADB?=
 =?us-ascii?Q?73/yhB+1nlkoTqMk5bKgRaVffd2pewwrlFJ4h4jA3orAFiXRJtyqipGbnAY7?=
 =?us-ascii?Q?AWh1JTPIN0wA+Ep4CrwOhL4/HAyo0G4GEYLJpevjQTWKrezWT5yB2uC9BFU+?=
 =?us-ascii?Q?V1qfNnoU5SkNS2x6uKhNivqRHYrc0lA3C1xyrb2CJkOKU4WWCcx4pOQsXDB8?=
 =?us-ascii?Q?xzj9TUALo5XTpqEW9AHABPvzLrQL3dH0pLyiz6nC38M46F3cJcsbHLw0QEFY?=
 =?us-ascii?Q?HUEras4T9oZ4NOaD/V058e+O+GwCoxOWscvbPTKxwnmiQ8MzBGJw3TBc8irY?=
 =?us-ascii?Q?6cjzMn/HDu1BSO720PAYOT6pwZ3cyhsnU760d49atDHZCPpwmO8gyhV2/Cbd?=
 =?us-ascii?Q?FMmLQeXuenvhMLsmcTHD4YDwU4W+QNorvNoC4oBHwUxK86Wg5XR8U4OyUH9t?=
 =?us-ascii?Q?1rrKTrkcxtMwA3WLEdejlEVkiG/0pQ7BJ5igMiNYpcSL43QtDEjAhOagAHPf?=
 =?us-ascii?Q?HNA3vSNnqdt3VyCOKqXgWBqJPE/Y4WkLfSJKgz6M+grZxszjPgwLe5dxViGC?=
 =?us-ascii?Q?Ctga8er43BicSQUBVmWJMu0dNK+VOEVRM9gvMnPpwRxlXPypOzURthQ7I9CU?=
 =?us-ascii?Q?jM0ImqOLcUWEx6A5Grd/g/Yuk52Af3WpyUHr0w2L/NvWUr8c7d9gsDPWwsSE?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c254f7-73ec-423a-a900-08dcfdcfb987
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:26:19.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 286ckjlJXkLRQgkhaHdCGzH5Eaom8YEQ196ErokBHLLSd1eLHMUJd6tLAK3hIwECrm0nCsEymwTkzJB4xufM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

On Tue, Nov 05, 2024 at 01:18:27PM -0600, Lucas De Marchi wrote:
> On Tue, Nov 05, 2024 at 10:12:24AM -0800, Matthew Brost wrote:
> > On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
> > > On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
> > > > On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
> > > > > On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
> > > > > > The GGTT looks to be stored inside stolen memory on igpu which is not
> > > > > > treated as normal RAM.  The core kernel skips this memory range when
> > > > > > creating the hibernation image, therefore when coming back from
> > > > >
> > > > > can you add the log for e820 mapping to confirm?
> > > > >
> > > > > > hibernation the GGTT programming is lost. This seems to cause issues
> > > > > > with broken resume where GuC FW fails to load:
> > > > > >
> > > > > > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> > > > > > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > > > > [drm] *ERROR* GT0: firmware signature verification failed
> > > > > > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> > > > >
> > > > > it seems the message above is cut short. Just above these lines don't
> > > > > you have a log with __xe_guc_upload? Which means: we actually upload the
> > > > > firmware again to stolen and it doesn't matter that we lost it when
> > > > > hibernating.
> > > > >
> > > >
> > > > The image is always uploaded. The upload logic uses a GGTT address to
> > > > find firmware image in SRAM...
> > > >
> > > > See snippet from uc_fw_xfer:
> > > >
> > > > 821         /* Set the source address for the uCode */
> > > > 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
> > > > 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
> > > > 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
> > > > 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
> > > >
> > > > If the GGTT mappings are in stolen and not restored we will not be
> > > > uploading the correct data for the image.
> > > >
> > > > See the gitlab issue, this has been confirmed to fix a real problem from
> > > > a customer.
> > > 
> > > I don't doubt it fixes it, but the justification here is not making much
> > > sense.  AFAICS it doesn't really correspond to what the patch is doing.
> > > 
> > > >
> > > > Matt
> > > >
> > > > > It'd be good to know the size of the rsa key in the failing scenarios.
> > > > >
> > > > > Also it seems this is also reproduced in DG2 and I wonder if it's the
> > > > > same issue or something different:
> > > > >
> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
> > > > > 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
> > > > > 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > > > 	[drm] *ERROR* GT0: firmware signature verification failed
> > > > >
> > > > > Cc Ulisses.
> > > > >
> > > > > >
> > > > > > Current GGTT users are kernel internal and tracked as pinned, so it
> > > > > > should be possible to hook into the existing save/restore logic that we
> > > > > > use for dgpu, where the actual evict is skipped but on restore we
> > > > > > importantly restore the GGTT programming.  This has been confirmed to
> > > > > > fix hibernation on at least ADL and MTL, though likely all igpu
> > > > > > platforms are affected.
> > > > > >
> > > > > > This also means we have a hole in our testing, where the existing s4
> > > > > > tests only really test the driver hooks, and don't go as far as actually
> > > > > > rebooting and restoring from the hibernation image and in turn powering
> > > > > > down RAM (and therefore losing the contents of stolen).
> > > > >
> > > > > yeah, the problem is that enabling it to go through the entire sequence
> > > > > we reproduce all kind of issues in other parts of the kernel and userspace
> > > > > env leading to flaky tests that are usually red in CI. The most annoying
> > > > > one is the network not coming back so we mark the test as failure
> > > > > (actually abort. since we stop running everything).
> > > > >
> > > > >
> > > > > >
> > > > > > v2 (Brost)
> > > > > > - Remove extra newline and drop unnecessary parentheses.
> > > > > >
> > > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> > > > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > > > > > ---
> > > > > > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
> > > > > > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
> > > > > > 2 files changed, 16 insertions(+), 27 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > index 8286cbc23721..549866da5cd1 100644
> > > > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
> > > > > > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
> > > > > > 		return -EINVAL;
> > > > > >
> > > > > > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> > > > > > +	if (WARN_ON(xe_bo_is_vram(bo)))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
> > > > > > 		return -EINVAL;
> > > > > >
> > > > > > 	if (!mem_type_is_vram(place->mem_type))
> > > > > > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
> > > > > >
> > > > > > int xe_bo_pin(struct xe_bo *bo)
> > > > > > {
> > > > > > +	struct ttm_place *place = &bo->placements[0];
> > > > > > 	struct xe_device *xe = xe_bo_device(bo);
> > > > > > 	int err;
> > > > > >
> > > > > > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > > > 	 */
> > > > > > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > > > > > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > > > > > -		struct ttm_place *place = &(bo->placements[0]);
> > > > > > -
> > > > > > 		if (mem_type_is_vram(place->mem_type)) {
> > > > > > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
> > > > > >
> > > > > > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > > > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
> > > > > > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
> > > > > > 		}
> > > > > > +	}
> > > > > >
> > > > > > -		if (mem_type_is_vram(place->mem_type) ||
> > > > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > > > > > -			spin_lock(&xe->pinned.lock);
> > > > > > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > > > > > -			spin_unlock(&xe->pinned.lock);
> > > > > > -		}
> > > > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> > > 
> > > 
> > > again... why do you say we are restoring the GGTT itself? this seems
> > > rather to allow pinning and then restoring anything that has
> > > the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
> > > 
> > 
> > I think what you are sayings is right - the patch restores every BOs
> > GGTT mappings rather than restoring the entire contents of the GGTT.
> > 
> > This might be a larger problem then as I think the scratch GGTT entries
> > will not be restored - this is problem for both igpu and dgfx devices.
> > 
> > This patch should help but is not complete.
> > 
> > I think we need a follow up to either...
> > 
> > 1. Setup all scratch pages in the GGTT prior to calling
> > xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.
> 
> yes, but for BOs already in system memory we don't need this flow - we
> only need them to be mapped again.
> 

Right. xe_bo_restore_pinned short circuits on a BO not being in VRAM. We could
move that check out into xe_bo_restore_kernel though to avoid grabbing a system
BOs dma-resv lock though. In either VRAM or system case xe_ggtt_map_bo is
called.

Matt 

> > 
> > 2. Drop restoring of individual BOs GGTTs entirely and save / restore
> > the GGTTs contents.
> 
> ... if we don't risk adding entries to discarded BOs. As long as the
> save happens after invalidating the entries, I think it could work.
> 
> > 
> > Does this make sense?
> 
> yep, thanks.
> 
> Lucas De Marchi

