Return-Path: <stable+bounces-200213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 044DDCA9AA6
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 00:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94305308E6DE
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373527815E;
	Fri,  5 Dec 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDBrwqMJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA293B8D42
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979086; cv=fail; b=hYMdPRV2gs9kQMLeyhefWKvzmX7H3yz/Gf/ORzb+4glngFtB2UsDmuWH/J15MALNUS+7n0BL3rx8mKMILyxQYH3zyJpdJkNkeb+HTEDnxAfZB8VgWZrii+yCaPuGKiNnw2OnoW0UgAbHyCuLUS1rya+L5GArOaiA62bBJ5o27gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979086; c=relaxed/simple;
	bh=AMRvjqD84RtYLF+QGSey2CTSM94ylrtt1gH5ZED2ztE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VfdPSNnuY2WsXmDpVimFClbfF506eCxB0jVsfH93PWV4XDRHPyb8Cutm7HogA2rdTfpVwnp2kBr2DRz6449v1qWmVBimo43jDP8a29guC9u4uRGxGIqCwupKthhuJL4tu+23UVyGt7CDDZ6L8NNfhxVtQ+5lPVVKGvEXZoMdD6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDBrwqMJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764979084; x=1796515084;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AMRvjqD84RtYLF+QGSey2CTSM94ylrtt1gH5ZED2ztE=;
  b=MDBrwqMJ/tqMkm3PvReUDDjtdy2BQyDpEIXxLgskkn/qnSswGDMYhXki
   z7P/UnF4V/4jFEjONINKX9g0GRp5MWdQjbs9oGpMEMa6E3Mhi62FyaFRe
   bp73BFVAytESoRlMLuR4W3glIjjbEugQj/CQpD6dAqxQpVPsQLkwr8zqg
   GvTUXlV9PCvUvFJDIGVfy6rn6cWQdyVU1eDnDMZMGOiinEiqpSJOciBU1
   NJ33itVwva5+xqGu7XLN8ghVy/oOGBIsFug+j3UQN30NV2O4CGo9viFfe
   9gO+z+XCtrFiytqHpdqdxq9/5dzmWf020DCt3bSGwdczGWAWbkD3yH8W+
   Q==;
X-CSE-ConnectionGUID: CkDvAgDGRX6k4Z3lvTTzvw==
X-CSE-MsgGUID: WnE2lDLPQ32R4g3Nhdw+AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77639519"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="77639519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:58:03 -0800
X-CSE-ConnectionGUID: LAUK5A+URnyYcjoTXNycWA==
X-CSE-MsgGUID: pdjSuhH1RcWixeGLIWYvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="194482709"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:58:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 15:58:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 15:58:01 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 15:58:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb1eVPiVUBjDkQNf9rL/YJMs76i6efK6nbu8/8x6zdXgfogvLPb48VX4u2DKwwaXsivdWGtmtKTtVCreK2cntzvqN/AQeJmXwDZMIbPdduiQd5CV/89GtNXq9t2bcapfxpkY8ku2tH1LC8zfY/sXFN694F1dlahZIXzaqNn6wRip44QN8oIqYnAMwZokLIGfOLJjYRrATJW5K2h6gdvw6L40Oo0FaMl2ILmeVLhP2QuNZ5dJ79QPi+PYv/HLWM2Tql7++QnTQW/vbXpPPqLXXnb/hMAiYmGfAfyWOpEeTNWVriwldlkZQArlokWTWOFS4BM2hpPy90Me333xc+qPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZVMVsVV2W59t1XeZoyVvHudfoLGZWB03elk7Nk2kMg=;
 b=OsNSVK7e7siCupIWeDSk5CIZ6jzCr/ARzdO8pWHph/BAxf/wt+7C4UNkmy3GvhhtQXZJI/ThLbNzpRS/c8+WEqXy3vUJsB1H3DA633Xfa5WQTauh9Yrvf3REy29lG2qfMVQsUxKUYyf7nNMC+lRmbI42/Il+ibGjbaM66I1yKez1IAmJfaCblSfbupnfAInf7djs+FDr23x/4sMWOe80DmgCrpYkHFDSKY61F1SpVb7XIp2ucJaCTzZi+/UPDwC6cw9L5YJzkQysnYjhNCT2X/m43eBMO39d3iLf7b/xIRA4cMJUXS255Bu2lsng9tajpbM7JXpw2Msj/ror1/JleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 23:57:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 23:57:53 +0000
Date: Fri, 5 Dec 2025 15:57:50 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>, <stable@vger.kernel.org>,
	Michal Mrozek <michal.mrozek@intel.com>, Carl Zhang <carl.zhang@intel.com>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, "Lionel
 Landwerlin" <lionel.g.landwerlin@intel.com>, Ivan Briano
	<ivan.briano@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH v3 1/2] drm/xe: Limit num_syncs to prevent oversized
 allocations
Message-ID: <aTNxfnNIiQseWdcO@lstrano-desk.jf.intel.com>
References: <20251205234715.2476561-4-shuicheng.lin@intel.com>
 <20251205234715.2476561-5-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205234715.2476561-5-shuicheng.lin@intel.com>
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cee543-80b5-4145-b52f-08de345a1adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?plf32are8t7Q+DeF1nIMtRJfSz3KhDbl+liIn04iME1r3JMWdL6ttjk20M?=
 =?iso-8859-1?Q?CAmZf5Mm2M0ZUm2XkFgL357tohGVQq5iRJvZDFp/J12cXWna5lkYboOEFB?=
 =?iso-8859-1?Q?+emFWSGRtyyfTJqQdB35JvllZ/BL4dwCvzwZb3DsBANI9TS4aOPFUZkupz?=
 =?iso-8859-1?Q?V12IAZ2dLi8Tcdfgyb2RS0YmDWSx9SAuN4BvBNeCMVGylNuFWAOnfYBmaG?=
 =?iso-8859-1?Q?/333hO/5h/q8Kpd9Avi4AXivG823bVnDob6QONkIqxlYoi+MTzIukgIABp?=
 =?iso-8859-1?Q?1fDVrmrZzPbbFNWgN+fR4BGdzLGuIORU+X2b+tJRPiYLOgdE3AgRvhXuE+?=
 =?iso-8859-1?Q?H2Xntzycmygg50HX1eQOL/44eksW5d0Af6UM1RC+8QFqqs7O1vDd2raSjY?=
 =?iso-8859-1?Q?YrstexcW6Oe2s502+po83FGhCHuBrZPWIGKR/GgY8/51QPUXb7XmUXSjHM?=
 =?iso-8859-1?Q?AV8u15Ia7mCwo1FAbcVtUMXeeXQ4P6dvquCU5Cpc74QUGwuR3IEjFdpR5c?=
 =?iso-8859-1?Q?2WscLAmJDTjm331Lfnhzz7b3CmINbLF2aulyub0BUdHn+jmbszWtUzIMdD?=
 =?iso-8859-1?Q?hmlacai9ktL/awvbuE3/KQIVAYa6/23srU0QvfxULpPbTCvtDEnP9NlsL8?=
 =?iso-8859-1?Q?nF6qnIzx1nlusZOwDXjBKgPC0kjEKZgDtMmkUuzy8iJZLbRx0mI4AmTyW8?=
 =?iso-8859-1?Q?v6nPyyQ6B9j5cEEmq4+Zov5IAhkAdzlMv67NN3qAdotHTHBUzWJN7TWQG9?=
 =?iso-8859-1?Q?9ud8L7Qht8zzQwEkOLkVT2wB7FSG+qIzr0I7uvcodCRT7d/TlF81daeQ2O?=
 =?iso-8859-1?Q?8+BeABBCAz86b32r1vlsRsV2+8i7Bz8afqyUTdGz0RVlwUyK9po3MSc9q6?=
 =?iso-8859-1?Q?G9b6M7wqSZ+g6wl8EMFPa067ePGOdi5YAtvALbWB6c3L3FTQzyWu8nrRiD?=
 =?iso-8859-1?Q?oCzNGN8YB/nEjr1LBDd7bAr2pqscQsB3D0uS0mAMNh31xcDyatN6FNW2Ks?=
 =?iso-8859-1?Q?lr4p62/38h8347khwUboTTWEkAL98xlcxfgcVLROk/ClzBjjBtU8ZTBDDM?=
 =?iso-8859-1?Q?7MIp45W47Rn10/F+fF4yty9KNWWkj5y4BPTS72n113iJ/hBb5T9mbNZxEZ?=
 =?iso-8859-1?Q?xn6VhppFsOCjZcZGhG2Qktx351VXsqkGzIw1Tmun4a/pUjahpCMFrztw/Y?=
 =?iso-8859-1?Q?z0dZvkEHXqhLhMPw/PbfHcORo7OpxYSrrXb9eu/LQd4bzEi510Ja/pflV+?=
 =?iso-8859-1?Q?7tsJGN22DlvTnrBu+5HgEMa2G7t2jcYa+/6569yeQMZ0o1XEeVsQP4P5B+?=
 =?iso-8859-1?Q?WoyRqTfiplCy9lXpAFlAcspwEIs3gqYjul3nrPji1Jj5dchJOQ0R9YgctT?=
 =?iso-8859-1?Q?Q/QCmT/oROP0D9TBdLGmwbV9IHR1b4voEAZwWWbattvZeIy3LhoW5mhj8i?=
 =?iso-8859-1?Q?ixf770ucYOs2BJR3+4YJN5Qxpj66BLGp9msvOGuL8Gvu3FhNQn8xZuaDyv?=
 =?iso-8859-1?Q?CcXkVUEPrXMN2YZVmehkZy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X+SFNZPo64a131gjl4vdH7WzvEu6TWKjqp7o6fZ8QKVy7ppaochCvpRM4g?=
 =?iso-8859-1?Q?BnpvOP9rkMEQKL1a3lhAP0dXxJDzhDOqsEXNwFBUEfheJzsa6ub55qlvM9?=
 =?iso-8859-1?Q?o387VRFD4tfeRxn2ESF2Q14rHGaR1XC5W6zp+W95c5FbMoHBBfXHWNTfEj?=
 =?iso-8859-1?Q?dzuJcwbxG+sBkSA2YD/4fRQYSl7Am5PLoCkABwkOv+9Kgz3r2RaGFfBcqE?=
 =?iso-8859-1?Q?kRYxNRsODpCbyDHLIP+lxUT7H3fciRYhsZXxk0EB3LUYHYLrnJxrq0GP7v?=
 =?iso-8859-1?Q?SD/i4C1f62FHnq9HrQpxfiw4YiieI2TNrWeQ/VmP5q7nfwa2VY0odNpeWP?=
 =?iso-8859-1?Q?G6MXMKWO56zo0h16u8gvK/zeQ6ZXZ9+6kLK/oPEPhlkiCm2WRb2TTyINwZ?=
 =?iso-8859-1?Q?RlbRaRuwAxYqdLDnpVmVf/gnFwewc7JfFeNFfN7dRVWpac8OeCNpSvj84H?=
 =?iso-8859-1?Q?bZpjtJWLBziS4PRkN4Ww7N+5l2ffhkCPwF74gwOBdAxiqJM5KZb+GQJvpP?=
 =?iso-8859-1?Q?tCmUHkELkFPSYDv8RyRpM4XhLOFkcCnVE4IZAUDf1SM/yEOT3snZwsswTg?=
 =?iso-8859-1?Q?SqHrQ0tT7hTU3HTDK5uFcJceiQ8axpZ6e+IP574mtSVfmhs39aZ4u32jF3?=
 =?iso-8859-1?Q?sMN2D7Y2ruphkdM/q8r2J7ge3lWGk+qDUtZPKZvFigVb3mJcV4itRNkY1M?=
 =?iso-8859-1?Q?8wQuisl9/aoyKVV1TSs7nl+V9/I4tzu8gss3aA0IcEvhyIvkOi9B3yfB5D?=
 =?iso-8859-1?Q?Pi5LoR3BhfJ4cnnitShaaL8GiBOXqQ4aWkQAhdNDydUXqV1Z8y4gEcZdyn?=
 =?iso-8859-1?Q?MpC8TH9Woo5wf6gEdCp5/DXVnZO5iAz1H3m47pUGKsaZbYxZZbO2S9jP5z?=
 =?iso-8859-1?Q?t4jHMmszNyRli7TXiGol4PFGdlpuhrYh4rxWtIGcgl8wiPwzps0jiseB5m?=
 =?iso-8859-1?Q?ifW4TdVFJ0PkihMGmzwgOAGnLbvPbViB8F+H3PNUEySHjBrYqlhiI8JSts?=
 =?iso-8859-1?Q?IS/RlWa1xcknDD5WNRSXW9pZABcVPcDKMQOl2JMx3RcQev+9Wa2Etqoxo0?=
 =?iso-8859-1?Q?2NozHNVO2L41bV5yI+9V74o6eUiLoFcqprpbJ2qa/gYLuf061MgyLVgi8e?=
 =?iso-8859-1?Q?BB+GCoTmx2r7L2AN3tDvUwNivzC4xiref9Zh5/2OeUWmf6l2Ccj0fPqmml?=
 =?iso-8859-1?Q?73KHtwNuSSDslSS1AXICU3y05a1k+ZDQF0VOaq86cI1Liun0JTUdE+zOJD?=
 =?iso-8859-1?Q?uRvIHD+nc/HTDcjROnZY0YMonihWoAOkcFv8f4C0NcY3/2BkZrvuMMcNMD?=
 =?iso-8859-1?Q?IjrH1syXXZD/FNtE2LVfYTy2EeZtT+rBpnc1auo8UkqSshyzqApYFlmTBQ?=
 =?iso-8859-1?Q?u4U+Xw9iJTlmZdgCNf4JdX4THUDTkwDuQG1szZewMhkRSDScPf0Gc1K/y+?=
 =?iso-8859-1?Q?66urRQ1KHyef/DtVdpVrTGnsxYl8iFHuniOq0t+si1PXQW2VdBQAz/L86w?=
 =?iso-8859-1?Q?a94I2QxZMd3blaUeeYqDekzanPtHZt0g7yP98nD0fetE8sNKixNF2mT7yT?=
 =?iso-8859-1?Q?Hz5wJBsy/UuTirJgzSqm5+nxVnl2WmszrKHynBFgiUyLgSr5CpI+hI/tEA?=
 =?iso-8859-1?Q?j4WAyb4bHesgVJqOFrrHIfijzmE6876/WjbeDhfOaxBeWIN7qLK3ig/A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cee543-80b5-4145-b52f-08de345a1adb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 23:57:53.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1oo5lwQHD3KMqLzJLJTybN72+QaatKb9NyyYQAGjymfvk7zMFZM0oTerMKwL8tRsbPOCULF48vcR1zo8pK/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com

On Fri, Dec 05, 2025 at 11:47:17PM +0000, Shuicheng Lin wrote:
> The exec and vm_bind ioctl allow userspace to specify an arbitrary
> num_syncs value. Without bounds checking, a very large num_syncs
> can force an excessively large allocation, leading to kernel warnings
> from the page allocator as below.
> 
> Introduce DRM_XE_MAX_SYNCS (set to 1024) and reject any request
> exceeding this limit.
> 
> "
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
> ...
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
>  ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
>  drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
>  drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
>  xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl fs/ioctl.c:584 [inline]
>  __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
> "
> 
> v2: Add "Reported-by" and Cc stable kernels.
> v3: Change XE_MAX_SYNCS from 64 to 1024. (Matt & Ashutosh)
> v4: s/XE_MAX_SYNCS/DRM_XE_MAX_SYNCS/ (Matt)
> v5: Do the check at the top of the exec func. (Matt)
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Koen Koning <koen.koning@intel.com>
> Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Carl Zhang <carl.zhang@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Ivan Briano <ivan.briano@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec.c | 3 ++-
>  drivers/gpu/drm/xe/xe_vm.c   | 3 +++
>  include/uapi/drm/xe_drm.h    | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 4d81210e41f5..fd9480031750 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -132,7 +132,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  
>  	if (XE_IOCTL_DBG(xe, args->extensions) ||
>  	    XE_IOCTL_DBG(xe, args->pad[0] || args->pad[1] || args->pad[2]) ||
> -	    XE_IOCTL_DBG(xe, args->reserved[0] || args->reserved[1]))
> +	    XE_IOCTL_DBG(xe, args->reserved[0] || args->reserved[1]) ||
> +	    XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS))
>  		return -EINVAL;
>  
>  	q = xe_exec_queue_lookup(xef, args->exec_queue_id);
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index c2012d20faa6..24eced1d970c 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3341,6 +3341,9 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>  	if (XE_IOCTL_DBG(xe, args->extensions))
>  		return -EINVAL;
>  
> +	if (XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS))
> +		return -EINVAL;
> +
>  	if (args->num_binds > 1) {
>  		u64 __user *bind_user =
>  			u64_to_user_ptr(args->vector_of_binds);
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 876a076fa6c0..f7f3573b8d6f 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1484,6 +1484,7 @@ struct drm_xe_exec {
>  	/** @exec_queue_id: Exec queue ID for the batch buffer */
>  	__u32 exec_queue_id;
>  
> +#define DRM_XE_MAX_SYNCS 1024
>  	/** @num_syncs: Amount of struct drm_xe_sync in array. */
>  	__u32 num_syncs;
>  
> -- 
> 2.50.1
> 

