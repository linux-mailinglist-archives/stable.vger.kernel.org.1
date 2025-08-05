Return-Path: <stable+bounces-166535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFBB1AF66
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 09:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3F7AA8B1
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DB21FF3F;
	Tue,  5 Aug 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5DpVoF8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200B219A95
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379446; cv=fail; b=klySdq/LeUdO06u+J9WAsiwcRFjhf4VFfPC0hJUDlh48zPlYiw8/AaH7B1g4NngQZXaZIV6vBma1zWOtDkCh8XakiMQNNfor3z6ou75Sg5Pl7Ohc9CbyyJXWZ02AnWofZhAHmMsupY41XdSwVDqKC5xIVtBZv6dP6UGh6klMgMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379446; c=relaxed/simple;
	bh=UVM7Kq2JnfXK6Cz28QIxFXf7nnOaflxiLKJ0Al9BZXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTGdH7VrWlZ9BwJuV1QA5U33u5R51iu3YJ7Rp691S9RfIdTgQUH4YLPYHsbLVYsuiWox9PH++fSq72nXrpvt2nd4hocdt+6nOh7ElDwiG8X28zHLU9yLt5bsHo5hqrwqZZwjfdoB2luwRvkrtr4zs9x5xJsIp0UGC33iWC2L0Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5DpVoF8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754379444; x=1785915444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UVM7Kq2JnfXK6Cz28QIxFXf7nnOaflxiLKJ0Al9BZXY=;
  b=L5DpVoF8jaHxedj7WRclxc/nlZORDYi+YDnyRNmGMue1lfIvZEMZwg4e
   4cFYtg2jC6JDeVMpWdhnj1r4naajlQCJ9K1W9+wpbaFUaYWQgTKRxcx6f
   oYkAFUzyLaIl6OKXXMaXZYLi3hExTmKtYguI9Mx12dI7XI95Wx8eisldz
   8W6CWKK/a1X5Fgk8GmXMQr3U6+yHSdQ1A0+oisC8jolV3wmp++gpNsdSN
   7q3vCjQpl0bmAPlOtlfWuBjY6V3AppiH1BioVNP3C7HZAQl2uZLYGgLsa
   O819fauMwUMtuJFocWS844S5FZgqJI9WPqKgq+P2YdOYjSOOTKfGF//3s
   Q==;
X-CSE-ConnectionGUID: BPLIxUCfT6aIL4ZjyWwQ2g==
X-CSE-MsgGUID: lJN1+V3cSDaqpyjQxKCCEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60493192"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60493192"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:37:20 -0700
X-CSE-ConnectionGUID: CLWcGSquQsm1/TrOx8SkIQ==
X-CSE-MsgGUID: GyaCtNcbQAeJfPLYirg7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="163657869"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:37:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 00:37:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 00:37:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.84)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 00:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9+ykxdDZTBQcbs4GHwEL1edJzKT2Am/z9bxWR1SDud3mzTmyBZnLUb56ws+TD8buLMuXODSDeagfKt+0QS8VFZR+CMVZ+T1WLff88enqTpgE1LnZZd0mebWsTy+QIoHOPNZUX7DrlFRDRcOJQfx7EwYHzxOYjbyr16RBTGHlNoFG36KKJhNRtSxc8G6nrjpdbVRU5RdNrBZgpfi8SO3iSIYlFDJuioyeu02J9MNJs7nB1x0eg0NVywSBpG58+/3IHDQoy4tpbOBLFvsmvD6I2u9yWO8z9MHBY3b/vE2EiO1WvXR4K9rsZQ6nyPZ6TJfXrSGReRD9Ryrv7q+kKzgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubmiSGsh8IonfsczBIL4P/vNbnxwUicZFnG3eb+kzU8=;
 b=WZ9y0xqvaPdOzxNAG/lDOWJp1buOcWks0885lysMYCFz+Ka5BoUD5Szu0wSXQ8lr6z0gkfHK7Wc0CuuzS021zv21Gg0/18FLs+/WDyyKR+7ELjP75wxVZCZEg0zdiGPpcDc8OwxLYafNlfBV5Q2/NCdIvP/GXCBvGqh2vo8/6/q+kUvembLJmfWb40xKQg1S+6wJHehLs+WMUdVnO58YKDqnJO2ubMseBP8A2qh2O5S8DJ1/Zpd+Vm0aiTPMojG/d2lssRF6zd2h33J3SKltnGCC5FQu9t11CdjXsyIcEF8lrAqUTeQgQa6vFxTzpaaQW2QXKmJuEj7SxIt55urMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 07:37:18 +0000
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f]) by SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 07:37:17 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Charlton Lin <charlton.lin@intel.com>, "Khaled
 Almahallawy" <khaled.almahallawy@intel.com>
Subject: [PATCH 05/19] drm/i915/icl+/tc: Convert AUX powered WARN to a debug message
Date: Tue, 5 Aug 2025 10:36:46 +0300
Message-ID: <20250805073700.642107-6-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250805073700.642107-1-imre.deak@intel.com>
References: <20250805073700.642107-1-imre.deak@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZP191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::21) To SJ0PR11MB4845.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4845:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 66104741-1d5e-4853-9f25-08ddd3f2e745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HaS+pukbzTGLuR31vEOVc06OViuvDxwOXHKVhemvJJmKL5/Q0IkfLHLjUuOA?=
 =?us-ascii?Q?gD6KObTmQ9ez354CyfXLfPOMwB4BGgmYuDhtO2kb3ORHT+P2gCrTxtc+HOhr?=
 =?us-ascii?Q?kjuInTrcrmwTIIvrGN7cpnxvzrzzpC6ivvbtCfBXypFKl0XnxIzjy3C0yY8I?=
 =?us-ascii?Q?tu6ZHE7EFhTI/QT98LTDiY5HYvAUnFmqBSvsFFNgEUnvhqZOzgbXN4f9H54H?=
 =?us-ascii?Q?m0TR6b4DgW+BTnUfBYX/d0sXGwLXMaSkPcGJ+SMmts/2O+PI2pzNAJgzioBn?=
 =?us-ascii?Q?NBJ5vkpMF3enR6fWYPvAFaRxGoPxR6VZx3oxDrA85RfJTvPw+FN8GhExN7qo?=
 =?us-ascii?Q?zgzUI5h3jmD6G8ELjSaObbwzyIpC7A4044TPUo+tSizeNi0SiJEcyTebOAM7?=
 =?us-ascii?Q?vvCCgluqVrn1S9Q37yFTEjYWfpoOQeb/w+CWQv8Utr1G03IgAYK3dZL7F6jF?=
 =?us-ascii?Q?jz4bJ63nzzxdBt/LpRuHoHgCPh6DSipqWnqFOJxpSJjL7K9sUhakicSOUE7J?=
 =?us-ascii?Q?HSaeQZWoykNHPDFEKVjY2PY2GDSYLfRv9t0iPLZa0TjRRt5GFxNVp8KW72Lg?=
 =?us-ascii?Q?Q5aGxXxPbgcoVmpl9e77STn8QDKXbpxXvWAwu/8kPfgrlq/sJmf/hhkbzsYw?=
 =?us-ascii?Q?Erx7310C6awDfA1nQH59NQHo0I1D4/cz9LUAbkCPzcujCH3zyLRerbvWk6hz?=
 =?us-ascii?Q?7OL0z7TK/+UOOF2sQ6VhlTy3Yb3PXJce+lYgmL6SQn9eblAfPqceWiUa42mG?=
 =?us-ascii?Q?Krwbxqt0NoCoUVMlng75RiKwazjNa/lSbFTQiNpCYNLP6JUmxadsDbCPCLo9?=
 =?us-ascii?Q?798RdmAN/N4vOBQj4nZQ+D0+RzZVQchH/ArGdEesUObbVvZOEYLVw3rjhbJP?=
 =?us-ascii?Q?emLN6aKpgvh6jrIQpuDTNYgrxpN1wzTGVrl3AX064xcBz90rbpUkneq/5t0i?=
 =?us-ascii?Q?F32i2hOdCYyJYo4cZ3Yz785rtuygik6FMJ5oKXW2ArxoeZH5l35TfwszsL/d?=
 =?us-ascii?Q?XasKsWYNU+AywdyDUKuI2HvK6hkXZ4da9G2iVyib0rfVqwIjoSlKz3y+EJq4?=
 =?us-ascii?Q?+CrqRosW5RLPixRkY59aodWNin2wsOfMFcpZ5rm6+I1BPJg0Yqm49f2+bflT?=
 =?us-ascii?Q?v01gK+zKV7rtm85InR0pWprDbgIaOREM+nX6CAZdDdkioM+xF+KYekQVw1TN?=
 =?us-ascii?Q?2oEu4njvLWOgkmZjSRCj61as0WhwRgbrGOc8+zD0B2F2GuA2LQpdon3oD3eJ?=
 =?us-ascii?Q?x9rbGzaKhOuHaDqJ+i/NpQ4ZTfqN4tcgT132JMyM/bIbABESSr+NBMgUeAPS?=
 =?us-ascii?Q?YQQk4zjUbWyPwUgiUMHJBNXtYE8IDMtd7GYztjtx4c8I4rg9iff9jzqaH90q?=
 =?us-ascii?Q?7hgrGUikPrW8C1dcnptaQqGwKXGur5qET7/L+d2pKtBZtYgXdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4845.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEqcDDfNKnxi6iS2ZxlGl6ozlVJ/AAjSF/6DjiOctYJfHjpGyKZ3mJUtaDJ+?=
 =?us-ascii?Q?aRw8dMAD0PUglUTvYAdd89gbMMXeOb/LTxcKomNVCo1XMFI/EsMGtiV9QJvY?=
 =?us-ascii?Q?ObQWLjUkd7gzG6bl6utYhq0vJSTMNo8DIoDdks2nM0/hYM/JDXisfhdBNNnj?=
 =?us-ascii?Q?M0DzOd8D71Tmhv9pcigBO1gGhOciOIq4T8X0fQfh/HAhX5ifRqpdmX2qb1wB?=
 =?us-ascii?Q?jHs8Zi/yzjSm8eexEI0uj2H9fp8zSfCGUh0GX1+ZAt2P9GBbke7yfsu0FClr?=
 =?us-ascii?Q?R+hly9F00o9hmB+omSabZFgVqwFtHPeMixftfJJ0uNuP2AlO3Ak/b2pFqkx0?=
 =?us-ascii?Q?aAMBabPAWD3U/G/Heyn/lf5NiY5nl7uzkxMm0I1xPwyWvHlNKGrNnsG59H26?=
 =?us-ascii?Q?Yj42LhjjvnsEWH33zd5pl9uhzMO0Q38gXJsLC0VKaQoz35cARG2E3UZ+JHSr?=
 =?us-ascii?Q?c3AsDDcy3I91pZJIo8Ng8NGwKRAV6xLtCmKoWYKdFh3QtaeR6XA7UXe1Jmwx?=
 =?us-ascii?Q?E4iHXA5Sl/nkjK5SE4kTp/aYqDdi8WBp+LIs6Z9fD1ei+v0ZYbDaXS0jm46I?=
 =?us-ascii?Q?agNvQT2Ijnm5lMoX/itOwP7DRH5n5DSebtIVldhfjheio3N3ctdk7udhO+Mr?=
 =?us-ascii?Q?bI6+DeUuQYWdtk2qrT6O0qd36dKTnA6aMSgK8dz3XMn33w1+OwFIUzpLF0IZ?=
 =?us-ascii?Q?U7Bv3GJOCqjL6bh3D3RUOfEu3iS6lSjlFPbEqfri8pl6uTcVBEhEFAgm3buH?=
 =?us-ascii?Q?9MNwDjkXJhnM+rjHTWGWkqWyJ5D+5dZy6B0S1lQmkhDTbF4i1Gzoz1BvO2qS?=
 =?us-ascii?Q?zGsio737IOVjqyOMdrfPJWpsIzvYmagirbKtbaDk5I8qWmabpyAkraDS4zPM?=
 =?us-ascii?Q?lgvzH82RD8Cv++Nfm/4MInPxo8BhRHF8ucuZybZjZg0XuUtZWdqSc50NbwZ8?=
 =?us-ascii?Q?cE4kfnRsjw17ExgrV7SR7OPMdsAB3M4Fx3UFhjeB7ZTxgdne+AsvWm7Ki7iH?=
 =?us-ascii?Q?7qZQEWUE1hbHsxAuOimKdphA3F0pR5wnnMo1dR6lK4yklTCirrGHWoWkMEKU?=
 =?us-ascii?Q?VjbyJZ+37Kn2TjUn9H/0Ma0Ljlgl1pf6LRqdiSqTRiA6OUKOt5j+rw7a50ui?=
 =?us-ascii?Q?Ddlr8rZ0zxNfs5TeJJWX0Vb20b5JRQde5pV4TLIx4laAm0X8FkVjclcCmuQC?=
 =?us-ascii?Q?isSfl8G7ABtqxOr+qrm/GG82zjw3ZTafchRP+hjX31xal7a9LfpFb5Yqflpc?=
 =?us-ascii?Q?bF+GrAPhbaUrT/yW8GSHgti9AEYECzNEHZ9C0rhdU+OTo/E5yypcmA5VeZW7?=
 =?us-ascii?Q?hekXb9K8Rm1wHvzBBN+W7t0NTcorMrQsdz/+hWxsEZw7Hc/NDT4zOKBCCNBi?=
 =?us-ascii?Q?NZado8lRvKxGYpa3ZAA9sTmrl4rGasyZLSY1MUlbiQrJBD7jD5GgL+AbX6bZ?=
 =?us-ascii?Q?d6GCCtLPuH0zAJQWVH69dCv5sbonr35OPB2wGBb3h6C3TevlLHbciRpl1Qna?=
 =?us-ascii?Q?i/jslyD/IfxI4FxtZOk0jyaQ3VAeHfZmFr7I0B2fc5+EYRX4e5Kh3Is69SmH?=
 =?us-ascii?Q?X50xwO5h1Ti4V4DP3R49I83GTzPc0eFMdHfYHD6b905ZD+M+Aw7hLX5LFz9H?=
 =?us-ascii?Q?RZRGgqDpJgo2fE3mhj3JH41XZp5Rknd3VO9hy5RmSr0U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66104741-1d5e-4853-9f25-08ddd3f2e745
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 07:37:17.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw/cTOXkVs/KpErrKW3htLdtImNV5truTMoMPq786KuCAergVI3Uy6H7oF71QkAIdN+/r+cdzAQDJxBSdNOq4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com

The BIOS can leave the AUX power well enabled on an output, even if this
isn't required (on platforms where the AUX power is only needed for an
AUX access). This was observed at least on PTL. To avoid the WARN which
would be triggered by this during the HW readout, convert the WARN to a
debug message.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 14042a64375e1..dec54cb0c8c63 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1494,11 +1494,11 @@ static void intel_tc_port_reset_mode(struct intel_tc_port *tc,
 	intel_display_power_flush_work(display);
 	if (!intel_tc_cold_requires_aux_pw(dig_port)) {
 		enum intel_display_power_domain aux_domain;
-		bool aux_powered;
 
 		aux_domain = intel_aux_power_domain(dig_port);
-		aux_powered = intel_display_power_is_enabled(display, aux_domain);
-		drm_WARN_ON(display->drm, aux_powered);
+		if (intel_display_power_is_enabled(display, aux_domain))
+			drm_dbg_kms(display->drm, "Port %s: AUX unexpectedly powered\n",
+				    tc->port_name);
 	}
 
 	tc_phy_disconnect(tc);
-- 
2.49.1


