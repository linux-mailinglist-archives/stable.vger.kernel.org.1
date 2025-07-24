Return-Path: <stable+bounces-164628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC7B10ECC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FE33AC838
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BC279917;
	Thu, 24 Jul 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjAB+Vyb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2101DD9AD;
	Thu, 24 Jul 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371119; cv=fail; b=CxCKIDXbeU4Omk+VDZPCb/dBn2WkCBFgolD/lSLQAiqIbLEHkE6O7w6of0Ock8jxlz+rObvWiRBSrIhCx/0wl5rKY2x2Uons5ajdL8IbE65FZl+k0FLNBsncU980Tem6pU1UNZQYL4ybDeUA6uWKexH1mX5AvXB445iQTTzzLF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371119; c=relaxed/simple;
	bh=C1fTPv0PlUz0u83HmHTCEcssWwRdDQ/hO/Hvngh6zBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1uPvIPYJXSb0r1jJY79Kc+S9JAGeEdTX1aCSn+INOQIYdJnHKPtVnJ/d0EmyqExnsncsfV1gn8CcXDRB1njbddA9mbi9h3kyzviEQ2VsBG3mAkPpBT2fE3q7ZONMtnROTTU3cMeX6yyml76IJ9EhPZE8+GlB3PdKSnBG02fWH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjAB+Vyb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753371118; x=1784907118;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=C1fTPv0PlUz0u83HmHTCEcssWwRdDQ/hO/Hvngh6zBU=;
  b=FjAB+VybZVThOBY4NTELhUb4HiCtyPwbVz4qGO0BHhEvTgYG7lVxC93C
   iyaxqWDoCxAdS8xjYOwoqdOZSLXY6ROe6lS3JTwetk8u/BaqVVK/5wwT8
   jWqyog33R/NRUmzvyUovFqxrgEBpD8rUFoeQoT8St03qKIFlE2H4WKenf
   o6oY3wFgs0Mgv0nR9lsYo7otO/wWW5JI3YsI9NxgAwKDHRoawH/2GbT+5
   QDjMIHupXAfhaKrR7XpWT2KDXInGIFmnxjH1VhZqv640OpU1FqMv8E5d0
   GUF74xiRzkJ6xzPuU4WDBCbqLdFhkuSw+ALpFHv7a4Qt+6NhOo9vSME/d
   A==;
X-CSE-ConnectionGUID: SioUnaJvTkiwv5PynF1hfA==
X-CSE-MsgGUID: aoh3ktuLSVir0cuRCVUFcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55658981"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55658981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 08:31:17 -0700
X-CSE-ConnectionGUID: fCIDWWE9SNO7p5WwgkNXaA==
X-CSE-MsgGUID: /5vJ6g5xTjWPjQH70XoJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191218018"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 08:31:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 08:31:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 08:31:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 08:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbIkQXGWMBtQWp4e5DljyzIE2jTQ9Gp9Y4p6LEg4/LyXW5E3AHiMM+7iZ6M4/aro9b3fzveG0dBLOQ6QTEkXhA4py2RXmW+9FQFMlw9VC9dAGSf91B9LG/TohxbNUG52cqP2f31CcDtfBJwjaZ7sgPc18nihk4zJ3hxEhzuL3R5+waDTIuzoaDqn4TW71X3xsLCgOWwx79er93+L7yjyNmIBR2yH9haSjv6FvHsRkh8TI4je/U6uALbktjm9IlfYo0U+PHiV3Wj5RYsPQqhjg6LBNvqaTbALvGUCsLx/be9EBxn3ulvGXZpmoQiWfbLeLM/ngkjewEnbP2mh240Btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R008xUzDUMaHbEKLZ/5jC9VNtbXOesR3xteG4iBaxWc=;
 b=fObtlbn5BPHEVR/JHfzsqltNtPP0P29ILaUR7Rzgzlm613h7mSOIajyYdR5saOTCEnczJvEkHNL3X3bg0F/t4ce9NPqJIJaoDsqoqIlhFf68ddSn3rGBCLYsJD8h2t//iz5hdw5c7Np79kuqGD6wFQxmn3KVPjThskbHa7tvAYwWIyty306NldBFEBXN0p9etnEDK3WyeUCYuEcqs36sSCfhkiiCPWDwOszGvooRVdtDKdAWtG8Uo5ID1qpvz/mjQ/UyjDZPKi+6bOb86o9nSiZlN+3g1hGDxa75OdcFrziO8vB1oqjMPdKnC+8H9MU4hLd6ubdCDN6bRMeeT9RMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 24 Jul
 2025 15:30:42 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 15:30:42 +0000
Date: Thu, 24 Jul 2025 17:30:36 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Kyung Min Park <kyung.min.park@intel.com>, Ricardo
 Neri <ricardo.neri-calderon@linux.intel.com>, Tony Luck
	<tony.luck@intel.com>, <xin3.li@intel.com>, Farrah Chen
	<farrah.chen@intel.com>, <stable@vger.kernel.org>, Borislav Petkov
	<bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <22wtxsixv54m6i5qkcp7x5xn22wg4sce7splenupcnpln4l7uw@szse2d653rxk>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
 <C723416D-E1C9-4E18-A3B2-D386B1CB2041@alien8.de>
 <bc4w3nbkjzyrwmcjodrrwg7klgg532gre5v6fiwe3jvrww5egp@zezyxzny3ux4>
 <20250724142452.GAaIJCNFO9tLS_ezVV@renoirsky.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724142452.GAaIJCNFO9tLS_ezVV@renoirsky.local>
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 77568af4-31db-4801-065a-08ddcac70cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GpEPM7yIBRMe64CT3MlsypSVIEGF+kTAmeDe0MWmGcpXBcIbqLIDMCCvzY?=
 =?iso-8859-1?Q?p9OG85LwftXnkhrSRcCJTj17WjRCCDR3Y7H2eTWBJFUFuJURXkVSLxIJ+r?=
 =?iso-8859-1?Q?CScjt0GekjxkTVNKJjAphM/4fD4+w6hUy1WasBo9V2RYUmiR6Kif/ggN5W?=
 =?iso-8859-1?Q?OL6GjzloVPoddlUKy4ZCaM+rvl3ZT8BW2txvnMzJiTmQ1BN9yAIpdyfSO7?=
 =?iso-8859-1?Q?exLrGw3RRxBh6+4q/hIwHCNGtW71PX6up+BBXYHS0CkYJ7hRKFCWkjwxo7?=
 =?iso-8859-1?Q?E1cAx1SjFoXnapbNlt/fKuGr/1gaIJHFItaIddnu3oB2Wq1PrqMM2+weIj?=
 =?iso-8859-1?Q?50bWS0KDYI6QwcbeyUZhzhMVO86ibaIUegZPIVe6KX1La1tdOpw53u5OTE?=
 =?iso-8859-1?Q?Xyo649U7nESVeC6QHWVG6HengaD64/fcwYqE7zxol+KSHBCj6AonN1WQsW?=
 =?iso-8859-1?Q?Xs2JGxHPL5aCvieOjzRPp49444iqwRw/lIUyS9gZb1RsjulcXzYp1zCFEI?=
 =?iso-8859-1?Q?up7ujtQpWSMCe3pOIluLHMZo9xwkTVidX2hkTDY75rq+eK/4hl+6Dr1wOy?=
 =?iso-8859-1?Q?SDHvYqVJXuuut0TVDgJZR93SOavwVSsJwT//UNyMbi4XRCrOToXyb4yUxE?=
 =?iso-8859-1?Q?jh43JA3hQt/bPImxdDHMkHi4HXfIwY+eyqnKUSP6CaKI+OY+efyfwe58Sb?=
 =?iso-8859-1?Q?YWxB/FBrXXGEB+NvizXLDri9b+n1YeUSSXoLxrjgGuu6BbLNlap7NU+FQ4?=
 =?iso-8859-1?Q?gIfbyER/yCtfv2qxkWZlces9D7viZG6qWVTh87/kwHh9d51G4TlXq3+BRJ?=
 =?iso-8859-1?Q?aVKaYk33iiXadOx/iS4Orv+xS1lsQfOvJI2aCkSs97qDBn1lavMrbFg2Gj?=
 =?iso-8859-1?Q?AJYvyC4igyGAMlU9Gvy997IWRVmPtV6Q6VS4HIrZo9jgz2+oMV6rZgPnQQ?=
 =?iso-8859-1?Q?dBpWM40pein6nN/S135iSUSM52QnqaJyJQRoDaI6PmOodFwhdzgq9MS+RD?=
 =?iso-8859-1?Q?qdGTqQzyk4bNALSnZePpze7FOTtCZ+kvCYc27Vh7BYc/UIuz6hI/24Nk3Y?=
 =?iso-8859-1?Q?poT9wD/u3PrtaSKQ53ssqfR4yNlaOgJBj1VMSS44z3Kq2XwA/xk4AZEjzF?=
 =?iso-8859-1?Q?vUo9qz1wiwfryJFC8nP4kuEMkFID6pHQ1z4SLI4rLFkvdKx2GW+nfKVRzh?=
 =?iso-8859-1?Q?ltRhd2S095IhkAn94EE+1Ls5Nr5bOuE7Ve03Yhza8Lr5byyNEQjXg5dXip?=
 =?iso-8859-1?Q?iIoNFHwRiJ2DtbY93y3Ts3yXyfyd+hwNiWmt2poCml4Ts+gwc+wqpwYxNF?=
 =?iso-8859-1?Q?4YEiL6dziaCqxHMNo0p43jnwObCzyWZYGt66y+/NrLmzNsAE+pEtk7ICYj?=
 =?iso-8859-1?Q?Ti+k6hYMkny+yj2txyFLdQfRBlEq/fGtQ7cG1JyrX0G8i8FHvlyfeJgS0M?=
 =?iso-8859-1?Q?RnUTdJS7CprEYvUCUCycZ/XhiTo73nchb/mIKQIlWJNPdpRPaNC6Xg4qiN?=
 =?iso-8859-1?Q?8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VZFsUlLOnPD/jV2gR5QfVs1SjZ51cjoxE77eWxwE5LcOho5S41eSpo/QK8?=
 =?iso-8859-1?Q?4Q2fse3Adz93TCbhzY3iDOxVrOlPFvokoL3mjPrPbYc++Fa32OBVb9TUCE?=
 =?iso-8859-1?Q?lHDqxZrQpRf7fdYkXJiXdq61/W46gwsX7E7HavWK4ej9OZpvIKCCEQ3R37?=
 =?iso-8859-1?Q?za72/kkS8CzzLzKqCpljx1sXfBJXc8qeAb4vzK45K4pxILS5pnj8UfrUwD?=
 =?iso-8859-1?Q?5K2S95hR6Y4u53U1vfT5/X1nRdsVgbK0JeASLTDjg3O7cHKMVQiL5E7afo?=
 =?iso-8859-1?Q?V8tToHPXfY/9PtR13sGR2HW/qTfeJkwN/IzgNworLTVFvFOYhq7iksyG+V?=
 =?iso-8859-1?Q?woWs6Hf8pCwZTt6WoY4NIhSGRD/RcHD2cCDCHBKmDEZ4keIu3ILBIaIY9l?=
 =?iso-8859-1?Q?OAJOK1qC91r5u7q6U9Xy01YtX7y//MLp5HygOoG1HUxBNyqVQ1EEsFY1iS?=
 =?iso-8859-1?Q?np68BUroV7z/51/hXktnIzpIs5Uh9bs+gkZ3r6oMvvZHgv+islgzJdSj+A?=
 =?iso-8859-1?Q?rmfjMRj/jP+7tg28TRUxBfGmYZtr0RgKpWshidlBXKqg6p2VK1xrA2VFDo?=
 =?iso-8859-1?Q?QkJdCk4ttE9Q+LVKvNhtKoezGXxTmEeZtg8vO5m5zRIwI0dKr1agnCHXbB?=
 =?iso-8859-1?Q?Adk3l9d1lurwnq0FVUVOZzAYuDhcSkLG7prbe1KX4htr/WR/LV8eF/QKvC?=
 =?iso-8859-1?Q?JaY62enWmXKtF4JjZ6xQJg1tXFsHDKYyulR3zwRZ74rAq+XesRIZuc/Oa3?=
 =?iso-8859-1?Q?V8TDL4YzAcI3lt4Hqyz3JFd2tIO0YnlKcoofwKSz+Q45YVkzzsxKGOK4RI?=
 =?iso-8859-1?Q?Iy4cUp4CVuuzeprhnT4rtoC3gDQ0f+U4P9BjURc+V8VQpd8cnJzPCFcfvP?=
 =?iso-8859-1?Q?P2Xlc1IFkyvYtnuD89vDsnrSDw+Av4SXGtQ9V7gMvelMTHeolAJOlbC2l/?=
 =?iso-8859-1?Q?bz1G4G80G8ZVpLuOwVhzydo+iVNEYrTAFJG76R9Zk3A183x6IMmVJzz6bf?=
 =?iso-8859-1?Q?6I/mV7eM/jF6tti/pq81vLk3DM1dLWfXYr8cDyeqXAbE5OIl3SDts9hqIl?=
 =?iso-8859-1?Q?V168pQBtri9rYdAArHffU59L+4Iy6vNWPG58sWRBIANox7UX9B13QYjPWe?=
 =?iso-8859-1?Q?cuxcU9m2/gMw3d28rrzqcrTw2aojuqnzGotoeZRk8dTkNXXBA7+AGh6WMk?=
 =?iso-8859-1?Q?WlEuPRVVzWGi3JTO1gwhIOXkdoLTKmgyqTiVcii5EGGDmclo0KANqlaRip?=
 =?iso-8859-1?Q?TBwaERD28M+kFIpslsKMODUqOg0+2vbkvhEA5cjuosaTHQtG8MnX5qhp3e?=
 =?iso-8859-1?Q?0vEnBfniguF53NNPUAfrOG8+He9UbHN9l529DRFRWgbUy1JIuBw7TYxtIR?=
 =?iso-8859-1?Q?PAvqUACAIDrtTGJ8P4oZihxypGh6/0iSIw+fmiXxaN2fXBxNZGXkPdpg8D?=
 =?iso-8859-1?Q?yXjzc5E/ds2ddCIVEMFVgjIqkAp0skF2BdoqNkKHBtrmctk1Pm1x7MgpXe?=
 =?iso-8859-1?Q?UPAA7JCcgiZZUEEXrmyL5VM0+4uCjHFObi/tuhcKF5QQciAsZmSKme/6v/?=
 =?iso-8859-1?Q?aEYM8ek0nlKgoI2zFzL5ct+ZycLPmTWgxgOXVg9I/j8vE++nfrOx3lPqGS?=
 =?iso-8859-1?Q?qEgbbIjM8SJdGG/+Zw5aANV/WRA5TS53E1avAsQsjwePX8ODL7W9LXs1fT?=
 =?iso-8859-1?Q?h3u97wP26o3LFRMcTWc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77568af4-31db-4801-065a-08ddcac70cd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:30:42.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoBWomjgQ/ECLthx0QmpZd4TN/C4rk6MtIlzJbvLhgQLUJfQUJu0jPibzmFIuzPX/Y029un/whHC+trTRRpUj0QuGauOJjeJZFz2y2VfKRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

On 2025-07-24 at 16:24:52 +0200, Borislav Petkov wrote:
>On Thu, Jul 24, 2025 at 12:59:47PM +0200, Maciej Wieczor-Retman wrote:
>> As I wrote in the v2 thread, based on what's in the documentation added at the
>> commit I pointed out, the behavior is a bug.
>
>That's all missing the whole idea of Fixes: tags and backports.
>
>Your patch must point to the correct faulty commit which causes this
>behavior or to none, which means backport everywhere. And I already
>explained this to you.

Okay, I guess I get it now. At first I tried to point at patches where each
feature was introduced. But that was not helpful to the stable team. In such
cases next time I'll just leave it at none and craft backports as you wrote
below.

>Pointing to a commit documenting this doesn't make the tree *before*
>that all of a sudden not affected.
>
>What I would do is, I'd go through all stable trees and check whether
>they're affected. If they are, you craft backports for all of them. You
>were already asking Greg what to do.
>
>But pointing to some innocuous commit and deciding that that is the
>culprit is not what you should do.
>
>Thx.

Thanks for explaining so thoroughly, I'll keep that in mind :)

>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

-- 
Kind regards
Maciej Wieczór-Retman

