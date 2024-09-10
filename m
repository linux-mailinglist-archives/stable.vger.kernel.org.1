Return-Path: <stable+bounces-75653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DBE97392C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BDB1C24EF8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF3188CB1;
	Tue, 10 Sep 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQ3pvvpt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C718E11
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976670; cv=fail; b=fb/zF1lpae4ysdAc8RNsvI+qcw4tmRPwiXYkF57Y2wWbb0JfYstH1ZVRCG4/M50eS4Blhb2h7LIBrk72fPmQV4HNtYZfOXVC9Y2Ff4elJV0O2eVGfFt93aDlbr8CY6o3ZT1+rjvw1ehG5/YYQvFTDvcZ9+TkK+RXdlvrXvF23no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976670; c=relaxed/simple;
	bh=VKQIqwcnjETrlvkpi4zqClpuUUnlFCR+ewNqK91bF6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0ngK6rNix5zzcf4Q80fdd48xkHlZNptC7kubDBKGm/q7tzDo/9CQ9wr7t2B12qEYb3X0+M7ODthv9HlgABJhDX5q+h/6nuXqexRIwm6ZMU2FgYpxZx0zO+wktYhMckJ4JECQetCujqwnQVVhKbEXKFW/gumdLJxengeCeia26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQ3pvvpt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725976669; x=1757512669;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VKQIqwcnjETrlvkpi4zqClpuUUnlFCR+ewNqK91bF6k=;
  b=GQ3pvvptn8c8oZ57cnFctGkNLt646hQK3vuLRmViS2a3GxpAHnmqlRF3
   JRfKwO618qYa/uclDzI/F1b90SkDdO9WYmq8+EIRSI1nanyaBt+NrwbkX
   /9nZS4l1THxLnc68dWxiQsJvBQo2Hb9ry3Uj1o+ftt8aUnAKq/bs1pkmA
   3oIiZZXUrw5rnkPX+4WT5sztth0E/m8lDlFyvJEvXH1BaoUQpaQVXnRjL
   bygpwdQPiXD/eB3XNw2Wz+GOofY1soYc+MZ7ljLeqwupTEYYNjuxpflb8
   E9uqQWvE25AW1Fo/0+TjmwBvboMHvcB3HZHBLC9IZllI5ll0GCjftRjP+
   Q==;
X-CSE-ConnectionGUID: o00BZoqUSxy7DXWNB5YCfw==
X-CSE-MsgGUID: WGqPFSOMR9GU4U8cIPKpOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28614263"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28614263"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:57:40 -0700
X-CSE-ConnectionGUID: imPcdRo/SVKLTVH2d++Z0g==
X-CSE-MsgGUID: qBMe9sYdR4qU44/rdTo/Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66997437"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 06:57:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 06:57:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 06:57:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 06:57:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 06:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/TWuG9ATSV420tYHWj7MOpFwD6L1SckbIEAvF6P9/0eKsKYkzrtJCcLSc52Qjzg97F13Nj2fIxAI/BImvr5QG03z/9XamIvCPnDd7EyvUP2gt6l1zBMQZvYsjVHymQpmQZhSnADtjfkwcmy26QQk/Q2ZE62wM/QKjQvJA6vHNDQTiwmC2AIWyJ6fNQlHLwtDlWTMvIsBt+I4jqr56F9CU/Pb+gL0v5Wz7RRIkJQIOyb7PKPna/W5kr4hT0HDPniEqKZvu888DWmaVB71RAdH9Q7VLJF3ZOpYyMo9cK31/bB5d75gq7sNFJkPTV2/9hFQOVyg4SKbyrpG2kQucMwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot5TdroTuqSUtif89QP2o+AkKyn3OwtIM32xwUgaeKs=;
 b=FmBpBpwbljf3SBMCxq6sEayH9GX+h8FgUeavA4tU9XKOMsFIr1qAJ9ZJVhqP3og4MuTsKZITpL13HMzHQ8C60j+Nt9v2BZIcDP+6rcsYPp34VL+8Gats8sbeVUCUvaHjrQkumeZsvVp4YOpyNZ2CQ18uzVdpacVgCdazJ8qzGapCRGhTjO5nG/BTCm068CUC2+P0n7phIAcJfzGba+z+hwq2+QZsGHjYOfXIb1mC2hUD8dj11p2wPDbZF0ThTSK8FCbzv137DvajfKBTxNWbxkYk939WfWcRkftSCVy2QSLZmNpGeypdIlVU/pS/JwxihI0nfM0bY44ObICRFNcyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 13:57:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:57:33 +0000
Date: Tue, 10 Sep 2024 13:55:18 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/xe/client: fix deadlock in show_meminfo()
Message-ID: <ZuBPxoop0H9BuTUl@DUT025-TGLU.fm.intel.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910131145.136984-5-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dc386b-a56a-4fbb-3b15-08dcd1a084f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kqNA+j3HLfHqz31/JDs+u111gJHDNv3WZDm1jLJgHKOugj65rGiPoj8Qtr?=
 =?iso-8859-1?Q?81ZKdYd+rTyUR6RLHSKLZFdHNJLQJsMAv8CnahuX3pQ9MqeLUNZesaIQiX?=
 =?iso-8859-1?Q?OI4bXKR3HbKfotpN7wAVRcuHeKtPtHW8agKllcBQaFO/alub+54BEQVRrd?=
 =?iso-8859-1?Q?/tS0SEHDhcd9az55l1HiKTjRx46DWZmrMNuEwCVHFOXxncU7e2KdTKqy9N?=
 =?iso-8859-1?Q?z7emwefU3QuCXDUWfD1cBG/aCsXbWps25t+XWfMIC0IvMKdG5UcGrzfXq6?=
 =?iso-8859-1?Q?hiZ60ag+GLBJE9hf9FMDJRA9fLeFE91vDaafpFBAxvNc5IYKOwJ1zZWEGc?=
 =?iso-8859-1?Q?/5IUoA4qeM7QJdXIaKXxa4QS10OXqg1HCXyI1nvqUEW5mK0Nj+JR9F3CJ6?=
 =?iso-8859-1?Q?BozAdYnaxK9gR3ZcI0txrJ6BYZ3XW+MKXNLUKqepF+9yLnp1Ney2E6apS9?=
 =?iso-8859-1?Q?VMHFikXYkf7ITBpIJoIOG50VW59GZ/T75m5l3lZ2uo7Kce6NSC2d+XFU2z?=
 =?iso-8859-1?Q?c5cxZ2oFy35ca4KBzY8mM4rDm3CQ1ImurkjghayteClNq9sVNBFxFO2qPR?=
 =?iso-8859-1?Q?ztXTc5gR0b9wWt18SisKdHZHy4VyfbwjA34xUK97jiXXTrW2vzKq2TxZg2?=
 =?iso-8859-1?Q?/985dvPdcH9Dlu45/k7GKJjNH9UQBMFTYSiaUAWnhxVhyHtVjiONmViJZI?=
 =?iso-8859-1?Q?MP31pp3wcMPceCxFT3g+Cr2R+drPYmVAgGXeiSaZtADO8EHN1FR+4hRXjj?=
 =?iso-8859-1?Q?2TweHghv4cnABZWAoLz9kUoDRaoQHct8Y8VMb4xdERL614Af97eh8lYwhB?=
 =?iso-8859-1?Q?mxmpP7Z/ib9Cejgp8NP0r9tAT2uwjF+IPETlCse08jswb6ljovAKVwhi0p?=
 =?iso-8859-1?Q?fOTNBSSNPWZByukAa/w9UgFcXG3GgMh7LCqkTLFxJsRf4pMtD+OJAoa4VO?=
 =?iso-8859-1?Q?IEU2J+J2oZuLWgM21o92eCcFsSt5x4qb/wDS4RZKP7UYhD/vDwu5orWDHm?=
 =?iso-8859-1?Q?cRcq5zpJm3tJf8Vpe25tzOEyJVDYviZJzMpF5+Qml1h+PrHtpAtx898XKy?=
 =?iso-8859-1?Q?DYy97jCikiitzMphdn88TF/4MBQ59TETYeMd0j+PgmlAXfHD78dqKphCAf?=
 =?iso-8859-1?Q?/mo8d14BTSilDTGLuCWvx3Iy9nN51yeZ8zuFBS2qXLBeOAD5b2PFxu2H2d?=
 =?iso-8859-1?Q?T/pILo8/V743XsDUTBuvY4gaWeWWOdmRYvDcRAzjYfrJdnc4MCuiACams4?=
 =?iso-8859-1?Q?/eVAphJJ8315v5Cw9+Wfkg+l5TrG7NrLTgw2O+8qbh87obB1Irg8/hzONi?=
 =?iso-8859-1?Q?M9/ztHvHFUrGmrbyDpyBDPQ13pj2Jw8+JUE8zuBVV43PX4Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HefrLTeJUoRPFNJ2IJvg3NxKdrNHIaonu8yjqZUSLRSJAhuQaD89up4gKO?=
 =?iso-8859-1?Q?9rRJq3HoTDxuMCd9JqiGWLUNBMf2hn6zQUpnUyJHniVisx6BUbvASIvKx2?=
 =?iso-8859-1?Q?afRWyl+yLycBUXkjwOk5ylA1fpQKVI8lthQBb0xRT4qASHUjnq1gcNo7EW?=
 =?iso-8859-1?Q?UKif6+AaFmFT3YCT9yfoQ7YqVF4dSaLPkC8dnC+T2XflOhuRkBJxksdGjT?=
 =?iso-8859-1?Q?ADnrY53zqOuQlix0Qh9KhW8WeYDuKeziXAxfyVPCQz4L5gbPZ0echxxgnF?=
 =?iso-8859-1?Q?rrJJ0KvJpAhmTC0nBB9D8TuUYtttEbllPm/f+wrY+CwqilqApXA+IqUXOC?=
 =?iso-8859-1?Q?AbumYaojjwvJyUXDC68DVx4dTcRKufogKx6aixVUMl2Wt3BH09cfgTpp0j?=
 =?iso-8859-1?Q?PhrE6I8zfh3hMMPZ6LBpaVU5691GzWdrmvX9/goVswkC4YrXT6Nl3jBWYu?=
 =?iso-8859-1?Q?q51XjLuWcnKdY8QCPd6PcxAVTYrquDJ3nLSkbqTkeN4s2BzrrfrWRg8CDt?=
 =?iso-8859-1?Q?65AsUYX4xH+EIT4mjqZtLI9zTsEyvHptGJF8t6W1+MP/UvbC9XEMZqrzgw?=
 =?iso-8859-1?Q?RkWUABEQrqEmq3C+FUPI+EMJETWjCOFBXVT2tnzfuQt2R6+dYmmnxved8E?=
 =?iso-8859-1?Q?hfjRzG3wDgoleOxn8tFpcmGxLAmcBOQQ0a4acAum3mSBSNqtGnkQ1QgmjX?=
 =?iso-8859-1?Q?vEEbKuRwLaDq4mNEWzPvtiShDHQXYR5HVeVxRCIJWA6bQryDPgO7UnyIRr?=
 =?iso-8859-1?Q?j6SdxNjdI4aL2OJNgy8T/UrJERW8GFBGDIiEBhSA7Za3cfwAqt+vLSYD4/?=
 =?iso-8859-1?Q?SBWJLdZuBrByOg2RPnDjkqeR/wmLUnOWIYaZ1boRM6rJ8LY4tIB3N1CNLD?=
 =?iso-8859-1?Q?j8SOtkVS1FLZJE4f/ueodn5gB53hD2d5FucC09ENnUQg7RpJthhmEjts0H?=
 =?iso-8859-1?Q?mpCd1UXnuQv+y3EMqA9ECf6OETZLEaorFQnFBNMVoEcN0HAyec14NqQvZd?=
 =?iso-8859-1?Q?vIX8Kg+4nN3YD/3FWGyvhBBLcRZkjSaQNa8aCYNFnq+McAyO5Da+vsHPzb?=
 =?iso-8859-1?Q?6JWL7qUE2vI1Tl8r1xEFqPeX6lZV3Nl93c1heFZEIiWN8XSkU+/8Dpu9+S?=
 =?iso-8859-1?Q?65aeDrRzHsiM6o/OOiAZIODvf6LtoSDO8Y+IAn14RBF3wqWe+pFlpKXCCU?=
 =?iso-8859-1?Q?lWvydeJrBjnbNpMmrQURLdygtnLGFhKIrwrFUnng1BbSOjKPCq5r72Nwme?=
 =?iso-8859-1?Q?0H00osKEBWZ4ZHNclvOIWfXyIajXny3X6fVisOEjT1AJy3Vnn6seJHMS/D?=
 =?iso-8859-1?Q?oqVi95ZGdDQN80laAM1ON9vvTJu4l6YkHA83iEsOGcRNwcaSlKCY47q5Tz?=
 =?iso-8859-1?Q?FTvZKkHiMbHljSXWFTIa/XrhlhOtUoFrj29rAQZM5H2JE2AEMdU3GQrlj0?=
 =?iso-8859-1?Q?sxTThtHsJU/IedWW7L991k9KPX4bnxcu8W0R5+UPV6gtOOGBwZHoxpT5OB?=
 =?iso-8859-1?Q?WS7LgjqY71RVzOECEgV3QB0I2Vc24JksNQfBwOajIuwCOfJNnW/3TbyFFW?=
 =?iso-8859-1?Q?Hr5Swf/o17c4F4cVBl1bE0bppoE04IToSsUJ2w7WpzUIlcJWg0FtJkMBim?=
 =?iso-8859-1?Q?bHuOmGHU4NQH/dl0JDrmlMjuDDucqTy7BZ5NCLSf7odo3w4g5bJ029dg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dc386b-a56a-4fbb-3b15-08dcd1a084f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:57:33.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx1+tUAOpJhZXBkn9QFnc2HpUZQKvOpCsblXaLMHsxz8RH8ZaVM+kyjaLQFymoITo5+nFxBir7wZ7PCgbqe8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 02:11:46PM +0100, Matthew Auld wrote:
> There is a real deadlock as well as sleeping in atomic() bug in here, if
> the bo put happens to be the last ref, since bo destruction wants to
> grab the same spinlock and sleeping locks.  Fix that by dropping the ref
> using xe_bo_put_deferred(), and moving the final commit outside of the
> lock. Dropping the lock around the put is tricky since the bo can go
> out of scope and delete itself from the list, making it difficult to
> navigate to the next list entry.
> 
> Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2727
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_drm_client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
> index e64f4b645e2e..badfa045ead8 100644
> --- a/drivers/gpu/drm/xe/xe_drm_client.c
> +++ b/drivers/gpu/drm/xe/xe_drm_client.c
> @@ -196,6 +196,7 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
>  	struct xe_drm_client *client;
>  	struct drm_gem_object *obj;
>  	struct xe_bo *bo;
> +	LLIST_HEAD(deferred);
>  	unsigned int id;
>  	u32 mem_type;
>  
> @@ -215,11 +216,14 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
>  	list_for_each_entry(bo, &client->bos_list, client_link) {
>  		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
>  			continue;
> +
>  		bo_meminfo(bo, stats);
> -		xe_bo_put(bo);
> +		xe_bo_put_deferred(bo, &deferred);
>  	}
>  	spin_unlock(&client->bos_lock);
>  
> +	xe_bo_put_commit(&deferred);
> +
>  	for (mem_type = XE_PL_SYSTEM; mem_type < TTM_NUM_MEM_TYPES; ++mem_type) {
>  		if (!xe_mem_type_to_name[mem_type])
>  			continue;
> -- 
> 2.46.0
> 

