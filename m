Return-Path: <stable+bounces-76116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E354978B71
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B7A287DAF
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F714B965;
	Fri, 13 Sep 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG4+zaGB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F69154C04
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267000; cv=fail; b=loEDBrjsJ2OuFNDSYwd8YBD6caighQ9TwZj+YBUWKuho0+6YNjmh6xH2TkQFJwYAVPuj4X00lKAriF/d8SLkP7PHPwBt9BpYXv8h0vh6x1ECqdNlnQYeYFv42DxjwsaQ4MGqlxk8sQHxvUe3WH/P29OWy29wpN3kA2wDAFZ8y+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267000; c=relaxed/simple;
	bh=tYBloBESC2e6r53dx6NQvpLOI4m9rcHAIEvSXCbM/48=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PKA3hWu6xeHEk5FI2oTdXOymVE9JuGY1UlK6AZcBqXi5rlgNHZxcipx2S9GpGGAyhUuiAQ8AeTwWctXOiYQKLRY5IA0bg7P9TDvDpn8gMWJ1FCBnjEhKdgGvGGOq/rohZ/orcZMwyJIVHnTSLuHD/fnxsw2tiRhfQW6AZp324To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG4+zaGB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726266999; x=1757802999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tYBloBESC2e6r53dx6NQvpLOI4m9rcHAIEvSXCbM/48=;
  b=QG4+zaGBqYfvfZfoU30kodp8hQuWJI8lsH+rcT0HPgsLLGOHSKQo9gFH
   ZmGCNrCPgWR8v4Qb+lgsuKD36RgbMysrXt4KN8shkz4a2eEun9r59Sspc
   8xy93cQF7OjBYDy4KylXH9kzcqeR5mLjhjLDPcVew1RpuA+q5Ky7IHrM9
   KiFaHydhvSmS2mxc+6g+1aPBHIp2D17QNjk1g4Blb+vIPgxmjzDk1pQFK
   26HrVRIonHVDA1k6Q5nsCES1htmOwIZ4PE5OghE8usR7NaZWYYTVukoSQ
   GgWAgZsCElJP4P/lr8Dg2VTgaqpzmsm41ygXNlJp0sORBe47c6cIsVjam
   Q==;
X-CSE-ConnectionGUID: APOz+k0HRpC33+I625RWPw==
X-CSE-MsgGUID: VhLck0nFTPOcmBjOUjoSQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28968339"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28968339"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:36:37 -0700
X-CSE-ConnectionGUID: twGRCgGSQTurMRnHYaDnEA==
X-CSE-MsgGUID: NWeK14bfR9WNZef5nzka1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72818368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 15:36:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 15:36:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 15:36:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdpUsIGdIqIJQ6fNgpoHVCwQHu/j8Jn6k052iHU1GhOhp8Uh7ln26GtnpHKIL7Q0J6lmUW4NnmtIC9olVHZ7gQpBMe1dsxbspT3NW3BpC3cSvLnwNxXcidDwnHqMZ2BhydO3djY+Fguou+Gqumb2NsF8wLTpSfZF9+ZzLi5WK1ORi0UUj/MSbrVUZJ06m2AFTwRpIVDZYhje2pF5qBvTm/Ba17mdWFZxQKNCIx5pCXJroKH02L21x9Ku24+v6yovZ6hhn+afNrJsf5B/BgjiYSh9EQb1J6keLnTlSMq5nXxsTsfknEN+cSw6vYLIKSlSa4bGsIF82e57qV/WExsshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udMLEmJZzkx2ZUbA3zRnoOWiEJnpwqJ31McUDjmCtKs=;
 b=Tp9LGIS/+N/wW95RtMX445s6gf2LoVjSYqcoBjMpMc7BAkWBdWa7a9s79HzGYNdVB5r/nmu3bmbY56+kSL7te6mwwN7V7DIUWM0su5H2e/RzdMIuMmubQ5EVgciUGQ5kOAmt0XMQ6NLIRuwyodGfOg7tSxBnd1y6AfSYvsSMkmNo7NUHCOS7DS/mTL0ACwt/8SScY4sODjzz1rAy+8CX81Jcyq4InkPJLx+Vho1qhoVgmANI/9JNWodcJsq3fSYO1h67mhi8H6/NflqX5gc+mkSwPSAMxGhIYPdI1ByffVIZ7/vf4rHuXF7nsO/wVC3XCtzY+x7yGz+s9cdQCpACiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 22:36:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 22:36:27 +0000
Date: Fri, 13 Sep 2024 17:36:23 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Akshata Jahagirdar
	<akshata.jahagirdar@intel.com>, Shuicheng Lin <shuicheng.lin@intel.com>,
	"Matt Roper" <matthew.d.roper@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
Message-ID: <gxnl6ekfxrmyg3slr6x6c5ad26a2ldqokbcuzddgts7z3sqt6c@34dpem3njjde>
References: <20240913120023.310565-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240913120023.310565-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA3PR11MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a0cb4b-e3dd-483d-c696-08dcd4448132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m4L/yG1HWYWj88UX6AFxczO+m2MDEoxe8vWx8WxSwy9PWiSuuUHcByoslbQF?=
 =?us-ascii?Q?8/7iBJp1JTT39kvlrO0zG5khQnq8PLAv3/NllaREsQbfN9tvAHJ0HPBg36Sl?=
 =?us-ascii?Q?B7pEdpObL6iAf6BKjJhWY1zgrWMkjYoooIhF04bAGJ2KkRRYEw4pUxsuuuep?=
 =?us-ascii?Q?ykjRUtbmuGm1lNEgVLw4htpqGGcsgo6gs/7VpoF4rjETKqJwawlUpjb2/zIb?=
 =?us-ascii?Q?5u/hM7V4OEV010K7EIx4K44Rl5SVNAyYl+wszu/6lTyQnOvgSVMWxHc9IyVv?=
 =?us-ascii?Q?ncyId23UrwE/380m59eabgv4CNpH5CO6gpjo9nhE4Wm1YbfFolsZrofNkUNJ?=
 =?us-ascii?Q?18b2U3nM7q4YZ5mL1y4ICV2+RNWOKWcg2LlPEqkKyH9n4MMPeNFUPQSPDi/s?=
 =?us-ascii?Q?HIQ+wKMi034M+bKqzT7JV+NlitG07zz4Iw/+6n2uWan9/Ud82mGKoKC1eRuN?=
 =?us-ascii?Q?8wZ58Ja9s7UPqDRkkQK2DBaJ5vzP4PNawWsQ8cLDI8PFKNzAYsPOVzXBFuYy?=
 =?us-ascii?Q?odctP1VQ1dJvWfrSqtbLKR/ww32dfzkxE5F3+ulspUNAw5koSJ28g7L9XATt?=
 =?us-ascii?Q?VCwH1O/p5wd9z3bTk0ps2VY64EKlt87RclsQ+olnDYZOhR9JDnVZHjaPNhVd?=
 =?us-ascii?Q?H3LfnxFp+MOuFkgLoPRDXvVgnnWgZ6xogQrHhWPvVL2eR3rIU3he+7Ip/Egu?=
 =?us-ascii?Q?dYWst/89WmlpyqzHcFN2I7ceAE4BDgmW9f0h5iRaplVE6CRndnhbUg1iqVHb?=
 =?us-ascii?Q?op8RjjnCpzfiyT3P5ozx+T2GhBKJYixeMWKs+Yu48lfUf5OL/MoccYTqi59k?=
 =?us-ascii?Q?Of4Xw9ZTm6mqMdVTwQLjOa+Y6aRDuMxN0kMxBf5e+ZWPyY5tbRYi7n68UlQs?=
 =?us-ascii?Q?m3yjjpHfh6Hu+2MERGASF5fRf/DQRTrqTQ3TMqqEAd+kcPYgjORPIUSb57Ij?=
 =?us-ascii?Q?n2SLzt5O2wfCJGQyQTyEd03E5e8TyLh3160NuDaI2eJF50x8qiUDxyy45s1K?=
 =?us-ascii?Q?4X6l/XMSncy+Q9ZjTZUq6f4W8Xzhq9cM/STEtFBLCaqe8/mD1gK2Ik0efddr?=
 =?us-ascii?Q?K/k1rs7sKE/hztuWkIi8t3U9mX/2YFSF5zgFOH7phAVvReYnp+8Ax/DBKYTV?=
 =?us-ascii?Q?oIFFpi8P+Wwq1BCo7L1GIopyDs/8KUN+3fQaVNTQkBZDDFyVVkyWxg1rEEi5?=
 =?us-ascii?Q?eLTxt/IPiE9lOL2B4ViyWNPNCoaW2Ox0fpjjb3dnHOk91KmbLL/v/GFoqN7U?=
 =?us-ascii?Q?GJSMcuAwjbXdlOcIXxNZOfbaXcou63lhDirjOSYqroa1zb3FcpJ5xrxgmZk6?=
 =?us-ascii?Q?R6li96p0eCvB7ATnjQ2gt32J7MDfQ7/WWR/z90+w4jcq/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J88vBvDhY8Pl7D3ZpbTJzzqVU66KDojlYMTIWZOZM5zn8fzJYM49n0LU7tT9?=
 =?us-ascii?Q?mSUkkJa2NaOhfLIPufxsZNPU3HustZeiQzU99mbNIu9z+XA888yN9CoLowTc?=
 =?us-ascii?Q?xpmh/E4CSiN989oQF3qJbzMJqRIsGvumGD+QqMSKlCD3kDxRa0I/zNf/rMr2?=
 =?us-ascii?Q?VAjzBUQN3ABqhef31+vpfMFhUaCJeBIw3ea/gw5SudEr5mMJjq9/32YZX0Nc?=
 =?us-ascii?Q?iZ/zikdGTU47nqiqCX+PmOyRxK/iw/DZXL075bag+jtCiFSJvu6cWiUK37eo?=
 =?us-ascii?Q?0Zy3qzw+xqGi/+3wtIXStud42cUIM7gsuIvUPZqviRe9+gu/KRMsNRN9cVic?=
 =?us-ascii?Q?wco7NQFmXY2WgfMYjrsdvqPZ7cCQ09wyYJ7NVD/PW8agT/PtuuSfZUp8mdra?=
 =?us-ascii?Q?TOy49lsKvayA6h9C7qjdvmT3hcX3y3HBNnROB0KyzBIwfE64xahM/vzrcebN?=
 =?us-ascii?Q?pABJuU0ULnfBwu2T7tVqyl6wsxDOs3Wbp8vg/1Gd9oul334L07fKaa+iygnR?=
 =?us-ascii?Q?JviSuVs4bwb6urMIs4mUvikqV5jC4/QL1LsDvMwRHh3khcms+0LMS+qYCtZl?=
 =?us-ascii?Q?XJ10b/jsmo2vUiOa0xxWL0LY6L/5ds9SAhNLMKKab/RhEtVxAQq2IAtOuMwT?=
 =?us-ascii?Q?hUmgot21c7IqoPxVaSzyDnSfUBRnrZ0G6iG3HZ6BDvSqJKcdQv1TXatLre2s?=
 =?us-ascii?Q?4T3oIPITlgADOoyk6JZkFftQBhOZkaBoAVzMnoIn2bADHS1FQ4ffm2GolP38?=
 =?us-ascii?Q?wpLtGDv8BvIO5OK4UO+SxJUeXfJTlxJoHYA8Flv4z8c1zB2Ey2tDApBDdz80?=
 =?us-ascii?Q?2zGzeoskHfa/ZhGyrKG5kUtd/uEEK4OaodrpXRU2+YxSUMXzLxoy2bj8ne8v?=
 =?us-ascii?Q?/Zr7gV9eHH1Q6MfS5oWBqQrrCaJNacxVKBV60dZu5yV07H9lEXQMiqBcpBu5?=
 =?us-ascii?Q?bubM9gsHchz0Cv7hcP14Pq/rHx9monOMlS0KxRdpU8WzgRuScqCCfhNgqrUF?=
 =?us-ascii?Q?qtI16UYRo7whHSIBaWTXDR5MlmVwSZCXoMwJaucHhWltXTuCS80/wjWyUzd5?=
 =?us-ascii?Q?cNQ9JqjziTpfX6gxEPW1BDapLJ6W77JUQLUYuyfWPL0gr55mbMshcNdgTH+e?=
 =?us-ascii?Q?Eugqg8TOwBacO4gph92VLa5OenzwsEAOHJ3Sthk3bZgedvZmSASTPdDSyZLJ?=
 =?us-ascii?Q?K3CywoXWiMkrfXYg3KuOgRS3PmUM+iVpQVuVNhSzihfUTLaTzfhMJEhiovFe?=
 =?us-ascii?Q?O2SjCEYzH7RQttHkUcMZ65yp5sQ8P1B7JqUG3HFLZqP983J+rW7eT3R73kTJ?=
 =?us-ascii?Q?1MjNKBMwKXarp9krv1L71Vz1uF24bwS0NQTVkHLwl+0wX8thmfLkqZarbDoT?=
 =?us-ascii?Q?ceToDhDLhCmvTOnCUc7w9swFIoBrDFYkIWyBgngFuRydPIWrdXrujOoLofhv?=
 =?us-ascii?Q?+T90vtEUHR0QtvbAwp7SEgsBces6p2Bixs7fW6qMQqj2d7WBC5Xw714dT0lC?=
 =?us-ascii?Q?hiu6qtTE8Vtb6EKbFPX4wjlgAgLkDPHAdfuCsWqXg3t9NEO/+mLZ9CtEdbTQ?=
 =?us-ascii?Q?enDi2Ey6f1tSYTSE+j8Qv8cGOciOIfpMJnAjd9MYdZGeTZ/wxJCWrw0uDo/C?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a0cb4b-e3dd-483d-c696-08dcd4448132
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 22:36:27.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtGBd3kgz6870uGKWw1AXX+QBaLnmnGbzRkrjNcFoQi5Bwr5N8b3U70yy4K+XAHGqlePpl7pvRhhPY/h6Kw4DY4L2BAwk/trIO5UZT33wQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
X-OriginatorOrg: intel.com

On Fri, Sep 13, 2024 at 01:00:24PM GMT, Matthew Auld wrote:
>Spec says SW is expected to round up to the nearest 128K, if not already
>aligned for the CC unit view of CCS. We are seeing the assert sometimes
>pop on BMG to tell us that there is a hole between GSM and CCS, as well

may you paste the waning here? Just got a random BMG from the pile and
have some may-be-related warnings showing up. And this patch didn't
help:

[ 1109.275389] ------------[ cut here ]------------
[ 1109.275392] xe 0000:03:00.0: [drm] Assertion `offset == (xe_mmio_read64_2x32(&_Generic(gt, const struct xe_gt * : (const struct xe_tile *)((gt)->tile), struct xe_gt * : (gt)->tile)->mmio, ((const struct xe_reg){ .addr = 0x108100, })) - ccs_size)` failed!
                platform: BATTLEMAGE subplatform: 1
                graphics: Xe2_LPG / Xe2_HPG 20.01 step A0
                media: Xe2_LPM / Xe2_HPM 13.01 step A1
                Hole between CCS and GSM.
[ 1109.275415] WARNING: CPU: 6 PID: 3377 at drivers/gpu/drm/xe/xe_vram.c:188 tile_vram_size+0x26d/0x500 [xe]
[ 1109.275540] Modules linked in: xe(+) snd_hda_intel mei_gsc_proxy mei_gsc drm_gpuvm i2c_algo_bit drm_ttm_helper ttm gpu_sched drm_suballoc_helper drm_exec drm_display_helper drm_kunit_helpers drm_kms_helper kunit drm_buddy xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bridge stp llc overla
y sunrpc binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_sof_pci_intel_tgl x86_pkg_temp_thermal snd_sof_pci_intel_cnl intel_powerclamp snd_sof_intel_hda_generic snd_sof_pci snd_sof_xtensa_dsp snd_sof_intel_hda_common coretemp snd_soc_hdac_hda cmdlinepart snd_sof_intel_hda snd_sof spi_nor kvm_intel snd_sof_utils mtd snd_soc_acpi_intel_match snd_soc_acpi kvm snd_intel_d
spcfg snd_hda_codec snd_hwdep snd_sof_intel_hda_mlink rapl wmi_bmof snd_hda_ext_core intel_cstate snd_hda_core snd_soc_core snd_compress snd_pcm snd_timer nls_iso8859_1 snd i2c_i801
[ 1109.275604]  spi_intel_pci idma64 soundcore i2c_smbus spi_intel mei_pxp mei_hdcp intel_pmc_core input_leds video intel_vsec joydev pmt_telemetry wmi pmt_class acpi_tad acpi_pad mac_hid mei_me mei sch_fq_codel msr drm efi_pstore dm_multipath nfnetlink ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 hid_generic usbhid hid crct10dif_pclmul crc32_pclmul poly
val_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 r8169 realtek pinctrl_alderlake aesni_intel crypto_simd cryptd [last unloaded: xe]
[ 1109.275651] CPU: 6 UID: 0 PID: 3377 Comm: xe_module_load Kdump: loaded Tainted: G        W          6.11.0-rc7-xe+ #1
[ 1109.275654] Tainted: [W]=WARN
[ 1109.275656] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
[ 1109.275657] RIP: 0010:tile_vram_size+0x26d/0x500 [xe]
[ 1109.275753] Code: 55 b0 41 52 8b 4d a8 51 8b 45 b8 48 c7 c1 a0 dc 1d a1 50 4c 8b 5d a0 41 53 44 8b 4d 9c 4c 8b 45 90 48 8b 55 88 e8 83 19 17 e0 <0f> 0b 48 83 c4 40 eb 11 49 8d 7d 20 be 00 81 10 00 e8 ed d0 fc ff
[ 1109.275755] RSP: 0018:ffffc90001a0b418 EFLAGS: 00010282
[ 1109.275757] RAX: 0000000000000000 RBX: ffffc90001a0b538 RCX: 0000000000000027
[ 1109.275759] RDX: ffff88885f321a08 RSI: 0000000000000001 RDI: ffff88885f321a00
[ 1109.275760] RBP: ffffc90001a0b4e0 R08: 0000000000000000 R09: 0000000000000003
[ 1109.275761] R10: ffffc90001a0b270 R11: ffff88885ebfffe8 R12: 0000000000000001
[ 1109.275763] R13: 000000027bc40000 R14: ffffffffa1219868 R15: ffff888161660078
[ 1109.275764] FS:  00007f02bcb28c40(0000) GS:ffff88885f300000(0000) knlGS:0000000000000000
[ 1109.275766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1109.275767] CR2: 00005606882c0f00 CR3: 00000001307ee000 CR4: 0000000000750ef0
[ 1109.275769] PKRU: 55555554
[ 1109.275770] Call Trace:
[ 1109.275771]  <TASK>
[ 1109.275773]  ? show_regs+0x64/0x70
[ 1109.275778]  ? __warn+0x8e/0x1a0
[ 1109.275783]  ? tile_vram_size+0x26d/0x500 [xe]
[ 1109.275867]  ? report_bug+0x171/0x1a0
[ 1109.275872]  ? handle_bug+0x44/0x90
[ 1109.275876]  ? exc_invalid_op+0x18/0x70
[ 1109.275879]  ? asm_exc_invalid_op+0x1b/0x20
[ 1109.275886]  ? tile_vram_size+0x26d/0x500 [xe]
[ 1109.275965]  ? tile_vram_size+0x26d/0x500 [xe]
[ 1109.276046]  xe_vram_probe+0xa1/0x860 [xe]


Is this the one you're talking about? I don't really remember seeing
this warning before. So maybe we let a regression in?

Lucas De Marchi

>as popping other asserts with having a vram size with strange alignment,
>which is likely caused by misaligned offset here.
>
>BSpec: 68023
>Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>Cc: Matt Roper <matthew.d.roper@intel.com>
>Cc: <stable@vger.kernel.org> # v6.10+
>---
> drivers/gpu/drm/xe/xe_vram.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
>index 7e765b1499b1..8e65cb4cc477 100644
>--- a/drivers/gpu/drm/xe/xe_vram.c
>+++ b/drivers/gpu/drm/xe/xe_vram.c
>@@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
>
> 		offset = offset_hi << 32; /* HW view bits 39:32 */
> 		offset |= offset_lo << 6; /* HW view bits 31:6 */
>+		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
> 		offset *= num_enabled; /* convert to SW view */
>
> 		/* We don't expect any holes */
>-- 
>2.46.0
>

