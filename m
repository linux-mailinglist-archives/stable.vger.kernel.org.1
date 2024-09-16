Return-Path: <stable+bounces-76533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4F97A807
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 22:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D60B1C24DC0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167215D5A1;
	Mon, 16 Sep 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjFas919"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EE15DBDD
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516812; cv=fail; b=cKf2NaM78Q+sFnK8ArqH6PxfoQSdx7Bu3rf/WzlOYy+7+Wc/+c6u4aq34zljbHicjDAbivuM2q5hIxrWuzbBAxOnuSoQXCxFKE4ttdhBYbyl9LnkCT0SmKGPp+nfvDuE3slAZ4BpxIvkq9KNj+IBrugeS3D7fXL0SofbgxEtcIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516812; c=relaxed/simple;
	bh=GI1e34wq85gSDz4pa9HCzpzcq8rkyYRDKPEyxdDchhc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PMOuQCojjEkjwuDNDuHZlmGCDAIk7FwEbCpepNxy/xB5RHN58KrINvpMOI4kk83EUbccHXpJiN4sJePoi6hKJdGZaRxynEwQKsoPrTRCYreiF7C2m+9MGCUtEWr3uqAY6zcVvH9/pFwuL+1QZWRgqdECYtJMOD6o0GJud/zuXn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjFas919; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726516810; x=1758052810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GI1e34wq85gSDz4pa9HCzpzcq8rkyYRDKPEyxdDchhc=;
  b=gjFas919sKajfr98PHlVyGwG/ILXxHcl75/MRHOb6Un5jb5lomt+gLH6
   3LcGrmh6UizN5adP5RrBsFFnkWiCdpWY856fP5kQCA9Ou02TnTYomI+xm
   vA06KY3UPhJfJ3hnM6CWFyHxUS/Bfev32n6vy2ReFqEYJ12GprwkVRY51
   kH/XT1xIq80mNiTmiNbzTKoPz8p+PXDpEX7byeh1QUKGqWmSmx56ms9ib
   fe7084XX6E0wS0QpV14I44/lXl9RgN18T1pKWXLeyhyZkjeonQFnfHuNo
   WAt/gdiumiNCWZOwc/OTyDbRiHLxKnxmMpl2w2rCCLPG2QPWIISmvdfG9
   Q==;
X-CSE-ConnectionGUID: vj9Td0q3QVufg+7EUGKoVw==
X-CSE-MsgGUID: qeb91BrJT6C6Brq18fvJgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="29143459"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="29143459"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 13:00:09 -0700
X-CSE-ConnectionGUID: 6MfWX47wRumM2btr122Lig==
X-CSE-MsgGUID: 4E9zNbMgQM2348wmzpG/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68635211"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 13:00:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 13:00:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 13:00:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 13:00:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDGfYX+704UX6PvBRsVK2t9CXx7aXE2CYDUdoWJ96f7VP3exMuRYQFIXayc+ObOuK5jHvK7tshCyNqvD/XWD9N+wWEhR7l4f2+x2kYrDsHTdbMvdu5fefObvAY5eputyB6zxVbkFM3dqzfLl5lxeB1zDfp4FdVCqvQXl/UG2vsVjVuO3mh6mmIS0qMQWkj3si6OfP395sljBqF9S3jD8Ns13hFetCZc75tQ24TWOw5T/jvy/S70V6Cv/ocb8OLx++59ch9vSmi6eD2aftPcMj0snGRVE3Z7hstTcPJ3CG6eqTCtj8ZEDMi2/6Y46EVjNv3hz7d6JjwqN0OYf3CLHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI1e34wq85gSDz4pa9HCzpzcq8rkyYRDKPEyxdDchhc=;
 b=v92ce8g5xd5G8g7ZFChPJwuxANK2WJlv7OayIdR0oktOngeIl97yoi0f6ysXvzeXMpEWJJ9CMyTRYcxZXDGMibjv82tFzGQ+Ia5YvOkAWwb9CG4Sr+84/DA4mn3EIft45kZ4nwERUsvE+mLRtixjgOw3O33IsHVruIMtNHc2XrYJ4QoOSt0XnfwOIGa2Fqpi3wmshTrjJQwR4YpzBtO7F7G7qfknSoqC7IWKIVXmnEN5G5l0S1mTuPtjZYgZYGxmT4lUxkKW3c0501OGdhNZZgH++YlDQMrnEN+y8jl+PXOjrl1D01lTg8YdhkPnSDr5aarbdj650OYE/P4Sv0SSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 20:00:04 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 20:00:03 +0000
Date: Mon, 16 Sep 2024 14:59:59 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Akshata Jahagirdar
	<akshata.jahagirdar@intel.com>, Shuicheng Lin <shuicheng.lin@intel.com>, Matt
 Roper <matthew.d.roper@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/vram: fix ccs offset calculation
Message-ID: <h575mzqssxddih7u4rfj5ubgovtooy35dgqi3olqubzlhhzazu@iciv2e2a5dmb>
References: <20240916084911.13119-2-matthew.auld@intel.com>
 <wu65ts2byg2fm7np3yhodad4bq4y272a5xwtcom6zakquwpsb6@e2rqj7bpighi>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <wu65ts2byg2fm7np3yhodad4bq4y272a5xwtcom6zakquwpsb6@e2rqj7bpighi>
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae216d-92b8-4b56-bb80-08dcd68a2724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pOieyU5xWWh8nTLjpLMuexCVRKYwWG0gNbA0ecUGo93OB1JwKjxvO5QX019/?=
 =?us-ascii?Q?ef2hoKcaqO98maRmlNOSFNfA/DJVQ5Jd4FunO0i/RKcSwXwabvp7ANrFPytw?=
 =?us-ascii?Q?WKXovp+Ro+igBX/MN5cbhF52Ss5faCNGGxkPmDgC4F68LZ5CshY2pKKhxb7e?=
 =?us-ascii?Q?BVcPI0JDTDl5vz26Rqxyw+HjG6Si2iKUp2bF773T/zZ6/lKUXHfzxs8OOBix?=
 =?us-ascii?Q?AlL+GuJGvWDzwJHKy6PBYTnKp+O/BZ88YmneY9DfnjlgkDHvJnjQpYgDL+xm?=
 =?us-ascii?Q?SKiqIU90t8F4pp8+3BnqXpdWfp2hqXMGozlEad0IbVaLh1jwc5P/TxkXsp95?=
 =?us-ascii?Q?kKE75k/9bgr12Z2KZrVl8s1mXf47AKj2dpG+gn4CZOvQuyFlatK/qRkyCcYC?=
 =?us-ascii?Q?8TVQiSIRbq06DIf19bJTcIUnYc7QyL0FSDpOzHvvtwQXL//nd4AuqnR1N6hr?=
 =?us-ascii?Q?jsZxg7UvuCClHJ/3Pe8PAn2ixnYM7R6UY7GBil6Xh+HHYtggRl9MPS3xCtkN?=
 =?us-ascii?Q?sIGJH7w2FTT/2qSQKO96UgFC6/59ySFsE1UOsqwjkHGKs1rUGKy3z5kfxaGH?=
 =?us-ascii?Q?TJ2TaIrVvzGHg25vKUCOKUyoKASitYc4xuvHcvKtcK6az20D9wK3NTKvFfUo?=
 =?us-ascii?Q?Pz1V2yE9Bq4DCaXKLCB+FQirkuKgrqdfeH7cdDgsdZCxM1ek4ZkLkfsBJh3o?=
 =?us-ascii?Q?lnfeDwn0Ejx4IZ2L1n9NdA7whoo2M8m0I1+Kf053Zef5Szq2X+EExUiipqly?=
 =?us-ascii?Q?gvDXFFCJUR5cXPPHfzqpcLlrz/aGoehb+DrDyMdfT3hvbObO3H3d51FlYhET?=
 =?us-ascii?Q?FxcabIp+Qs+Z5n62UVt5/jrt4MBBxQ/D6/lyoobAIp+cL65P7a3HU0ExzeAC?=
 =?us-ascii?Q?VaJH2siexK5nbPIgF5gQraYofIWAY2dYR1t5MbiwnT0iErU4cKY9A4j0m4Ar?=
 =?us-ascii?Q?IVz3rd8GJ9MS6pvkF7Lg4nO5IHjdYMoMITfid9C7DwlHGEVQwsQkMpBgRNyu?=
 =?us-ascii?Q?GZLZgTY107bIeaI796WdJWH91eD4/KF3NKZnDw95xIcQ81jXJI4JNhC3r8fx?=
 =?us-ascii?Q?UxglaAZKIhuWiA5QQWUZbs5OSeH/H7uqDqZ53Ho12ZqcRzdfeqMHA9oiQALG?=
 =?us-ascii?Q?4i01nrfjhO2Y9WniakChJxild0XIlQvgx/BGha5mK7Pz69BNx8+cIDoabXXQ?=
 =?us-ascii?Q?a/iOfCrJNwH90HRirroElDdd8TZ2aM/MznRf83QkjVpSyjqDlGuG3HYqXkke?=
 =?us-ascii?Q?oVfNYYWaE/Lxrgyp0CPycompx9P/MwHZll2qORor8W5LtI1OGkQzUL/kAHb4?=
 =?us-ascii?Q?5LHzwq+DyKfOx8/uSniEcBF+Jw9XCQk9QWZ/VYue8fzsbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETSVKDcMZxZ1Wwnh4+uIwF3rqx/Vw8daQ7IOYEQUIIc2YCxKLFIrjiY0L9aU?=
 =?us-ascii?Q?/Tuu8Hi0IGt1wU3aW+NPCiakPy792mywRk4L+9MgL+Bjp3fdA7UdKPvrC+JG?=
 =?us-ascii?Q?Bug5v2cuDAG29jvJsT9UIaoj6Kfm8DVz/30Muvbwdz5H3PS/OOxLql5raVg7?=
 =?us-ascii?Q?f3oZJO723gt72WXSklZy4auYQBYS6daVQQe+7N2xaYjjHc1GDUbQHYDTWL3H?=
 =?us-ascii?Q?A+Zbktih+9QCYu0rwYuZoxkReMwYphKsx9HjeToEsaOw2sHbIGrtuKqX9NVA?=
 =?us-ascii?Q?Rua12e9+f2D180mL/s3bL3YWQFOFztPAbBJuvbZVQB0+Y6fvUJPAx8f+B7+a?=
 =?us-ascii?Q?AgHd8pTwMjFu+c0UoUYWdYbdfDlMcoUcgekXZz9pIbiW83ldd1beg9UEFtl2?=
 =?us-ascii?Q?os5oarIv0JBbHCgARAht2VsqDV2d+dWMhSF4GnrtWT4fUYNRn5PY7PvrozNS?=
 =?us-ascii?Q?t/2pHFWewHEWYfiU+NBStdW8p3UvDVjaAC65plBM70Ced+xrH9O7KVKd1mGl?=
 =?us-ascii?Q?ahv57Ginxq2KA5yU7afUz7jvu1jVW5bhRRSAjMBnHN6Sns/zGdabd7tHdgah?=
 =?us-ascii?Q?3XcqIKvvrRxNHKJSogfzG/S0QelFjiQyE9FXTTnzF8OJ9OdslhpdBWkdzOH4?=
 =?us-ascii?Q?mZvkaz1gd7Ce6i7fojRJg8g3Y+7IyX+3A0TapNCj+xOygvfp2N8wEsNtJqzd?=
 =?us-ascii?Q?mIPCKGdRkUu/y0HAB3CyfA/isehPN15fhkkd6sLPSkm2qhTHKB3J2qprWMvj?=
 =?us-ascii?Q?DiyDUPD3z/1rIJeru6qwlpRSnzOCmmrr9m+7+lxUHd2MEC1TDUXvqAviIEQ8?=
 =?us-ascii?Q?YURh6mzy7qcY6jdynxINT4dhYy3cq6wphEIyxPgOvHbeFARWaqlkDbTn6XYN?=
 =?us-ascii?Q?HtsDEdkoc1/tKudKGWe6E5bBfn4He/bu2vfkRCs1w4C1fER2Tto58K/1qcOt?=
 =?us-ascii?Q?2bX8sLxh7Rs0keE1xdKnnxQ13w9PVCNZMQhY7ALOzhpJMoT4ESAdyK1Z0xYA?=
 =?us-ascii?Q?SVV/jS4jiTuRBUYxHuDAnxtaa9rL6AWVD2CSJTHSa7GvrQsyU621IbdHUEQC?=
 =?us-ascii?Q?Ti6XU6ymnjNyp14RoeokdqboDnmeb4naDjQVVfHDA/efE+YS6a+tOtHEcOf+?=
 =?us-ascii?Q?Q4aB8qLI3wjZ3W6loD18oVx1ph9mnRONpUxgJwLWoQFP/YWPpbvpurXbvLzI?=
 =?us-ascii?Q?xarQ/GvX+T7bkVThJQx+6Q9sq2+Hevu0HXVQTgD9UgmNrHAVXuwqyVPf0q4+?=
 =?us-ascii?Q?U4zUVpmfpm2+W7YNGdgSyfihzi5gEkHLVHKXXOsYwWtyKK4HdQqtDrZg0UYD?=
 =?us-ascii?Q?9qUsXRsw65A2xUuj/PMg4IPx/lRq7rMVag90ezmhyVlAjYwz8iEna+6IwvW4?=
 =?us-ascii?Q?O6tp0NiqKJQpQKF0Mfd9pEDFPiLJVJ6+yCQvG2WkdjLfytwMmzvkdGPnzPDV?=
 =?us-ascii?Q?Q7uSGRpmtOjJFsTHaEOUccDgUwdC7KS6XnzJrR98CNJLoiHmyZTGz18kFvqP?=
 =?us-ascii?Q?ly/JvAa4MNcmPyuF5w+eJxhUj91fzHTqix9jyK72N5W+f5xOHvAJ7yI95UeU?=
 =?us-ascii?Q?dtHYg66a3P/hzlchWnsP0Pz2ONTKxjVrXH4qs00i3uAMuiq1RQPc0O9wbNOb?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae216d-92b8-4b56-bb80-08dcd68a2724
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:00:03.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT/2kSpig7YcuzawbEOUc9zIsqtXJ4b7fTUNC/SxlSswGe3sGIwbU6yVT4fxUkkEn/Q4onR65dv68/6KsP+mwr9dpDPxurfBBc2Bqa64hoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

On Mon, Sep 16, 2024 at 10:00:02AM GMT, Lucas De Marchi wrote:
>On Mon, Sep 16, 2024 at 09:49:12AM GMT, Matthew Auld wrote:
>>Spec says SW is expected to round up to the nearest 128K, if not already
>>aligned for the CC unit view of CCS. We are seeing the assert sometimes
>>pop on BMG to tell us that there is a hole between GSM and CCS, as well
>>as popping other asserts with having a vram size with strange alignment,
>>which is likely caused by misaligned offset here.
>>
>>v2 (Shuicheng):
>>- Do the round_up() on final SW address.
>>
>>BSpec: 68023
>>Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
>>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>>Cc: Matt Roper <matthew.d.roper@intel.com>
>>Cc: <stable@vger.kernel.org> # v6.10+
>>Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
>
>This version now works for the random BMG I was using.
>
>Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

and applied to drm-xe-next, thanks.

Lucas De Marchi

>
>thanks
>Lucas De Marchi

