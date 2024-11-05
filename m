Return-Path: <stable+bounces-89912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9889BD43B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDA1C22C4E
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082821DD0D9;
	Tue,  5 Nov 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sgud2JUY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7104D8D0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830326; cv=fail; b=ck0oyQcmVseQQRq/1j0ZP0rAFhBpTEbJqVVx7+z9HsMiVpH4lbJJh8Usg5B3Xgc28mm9JWJEAUuGkmUtK4F0xmzVR4+1wjEbXk/U5Txq6SwTyfisbDP6dI3A2rqfiULEDrJfQ9UDivd1MU7EXnYvxzD2AzBFsFq/f6PxhwKfznM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830326; c=relaxed/simple;
	bh=tRUjEx2ntwayeGuVM5RnMqewH6n0p+HxzxOeEbuAbI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNm13Rk+ec0ls4Mf1B259V25+GI2OSxmE5EGQiWl8RalhT9ngAU4UuJ0f2j5LLC0ME/MGh+3hgjpLTFVZ8D6ph0NgYq7NAud0aWRuOLencBV6ffMBp7fVZFzbxSmiAouI8rxNzu6v9aqcQHjSGyexgh8RHB38xshNn7rExqCUsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sgud2JUY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730830325; x=1762366325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRUjEx2ntwayeGuVM5RnMqewH6n0p+HxzxOeEbuAbI8=;
  b=Sgud2JUYwyNM2FNmC7FvNdnroO7kwyKbzLr5ZX1aPL/6bYWs9tlrpZCz
   cyfoaA6wAhMFNv61+r48LYu6660Q1dFst5tzD/vbqRz9aduoCDd2DvK4/
   Tox/nOujP1n5FzKNJAphHSX5qm7HYc0ivIHKLemTiVxpv5NnPJusUc6xV
   gKwp2L5o5QhleJkRwHGpvhycsmZcqEWylNg0GwlEclD1kbf49G5qNVeFv
   DV1lrYXHA9SI24P1lGPx6u0/hAtoAbqMzV8WzzsMUxMV3/C3q2HPvQJyp
   +34qbIUNweDfxrSTWMUZcgMWLFWL14nC3oH/iKSlGTFMP/WGR45ml7VoN
   Q==;
X-CSE-ConnectionGUID: HI3MudQkRaGtlZkb63Lh9w==
X-CSE-MsgGUID: Q1SeauhvTHqwQ4IDt1/BKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30021309"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30021309"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:12:04 -0800
X-CSE-ConnectionGUID: LpHGG8I/TAW8OSLaIg9C9w==
X-CSE-MsgGUID: iRbh7dieRoCdsbSMfj6D6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88681640"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 10:12:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 10:12:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 10:12:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 10:12:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ1CmKP4hbW79J8cUEdAE2mvD6hyXJlymdemJg/aoDQTj7PDEp9U7gxbuAQ0WrtcagRuGgMW4r5ERRt11h4sVEvv6oIlUuT7Le5T+5G9ZDOgsNV/a1UGf+sDbjv23iUyPYnQdVRR/jyfTVKjzISNmHvcNSgfVZ7GrmG7ZfXJSwioR2AUAjHPie6LBN8XvlNHrN3+xBdMzVKeDGZOtkXJNVTuxQjnGhXurABdlpO91XNWFH8xTlKH5BRSRi8w42DO53MRwch3iCNnzxJ7W9j9XbOM/hKSDrT1TcxOprZXVdNO9BHi4Bd0m8RgnLXEWCf6mqf6c99fvBv3ekjWdqLu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha143x3HVDFyaD3Lj4CgQYeLRwFiuIQt2qSRlsdD/cU=;
 b=rX8Te3IE5vOtdXNOpcfJYZYb2OA8WKu+qu9un8+xh1hKcFtrKU27z9gHRZP/Z4ShHcoe/NcwU4azfyU/qny9Ni2qAXameXrYa6c6fmi64vbvw3bVR/Y3Cc/CkYVqtnfXjCw5HGhJlXbMiiHKGtgWNWgsp5Q8svQKgeMlhA2HlFK30e88XThjKARJxpEVfdL0AqmDcrS3IjGbpvOUEGEcMyPC7f4+wCbq/JhqQcCaU1ctbeOiq4/icaojlBz3iMCrOW0BbX7dqzoL4OKUUNwI0fizA0ODpADWVB7YBMU+NsR3Cr8hSYsh8vBaAJqTA4eEpDzlqhJo0SBuWzb4L8cTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Tue, 5 Nov
 2024 18:11:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 18:11:53 +0000
Date: Tue, 5 Nov 2024 10:12:24 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c584d4-efa7-472b-a631-08dcfdc55381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LYK68Y22KiN1cI9h0ugiuMiJ1z9grZXbpXpdebiIdcz6fIVSQ1MgwPWPql6U?=
 =?us-ascii?Q?edkklzeJ5WupTcu05MGGCRdNQL+mn1SI9/1s3GIS4cs8P1MHqp5vTq30t9Qf?=
 =?us-ascii?Q?M5GkglrTMdmbCMilFmN5tadEj90u4rJ69GRpb0oh686TsjK4mwOmGcw/udhV?=
 =?us-ascii?Q?siAqA+6J5PEDtEyyTBX941pt9B6OEufY/Fhz0Cy3ZAxrBdTzcRTyJPZ+1qlA?=
 =?us-ascii?Q?6wvDuMBWU8JVGKCMBtm8zDjT+ys8TUL9pva0C6OgmrFLZ3bKXAzPVhu0IEpn?=
 =?us-ascii?Q?FsjnR+O3tMKWaEWJKJlBz8xJpF+i/2rW8x+BS4O+NhhqXkXKZ3Ocn8jk9JE/?=
 =?us-ascii?Q?2+7n1zE4z/Hjx0YsdP+4dnyx0PCt+EZBf/WIw23+evF0pmPFGw1QTWCwByj0?=
 =?us-ascii?Q?bVBEKVGbF/llMNPpqJxGokPkasvtZb+vFR95aoXhhBFT7jbfvAyHwSHYejYU?=
 =?us-ascii?Q?VWTAJ2wiafrle+A87xUuHz8bIpbdmtzHNIjPdioujDoKawEVjmbrCfYpBsnc?=
 =?us-ascii?Q?Z4ZUCRCqpbxHVNmp0vb8E+vz0Opcg7MYZ9dTl4MDvcxFOz9V6r5Tla2iyT73?=
 =?us-ascii?Q?rsCkh2oc8/qYn+mc0SyKkLiaJ/zmfDWilcXlIRywf6nkzg3Mi5FS6XFwKc4x?=
 =?us-ascii?Q?UB852TkGpEsai1E6MKgqUqSXeRZ5lWoPx6rzuC1Yr+9gdYJYcW9kNnjTtJot?=
 =?us-ascii?Q?0bEPBbetR4n1rd31XH7Hfls3g6vodZyyMQxkGuXnhxMJ8PGiNu7Bn0ACn18B?=
 =?us-ascii?Q?lhlV+v4NkNdWE4FSW4Tx5EoAC26sidDKHWdoG2K/K0Hs0WSa0MnGa+sHVNIi?=
 =?us-ascii?Q?mwaUjoC9Zte97j3CFoOnsjLbwLxMlzPzOjdf9Txh5ts7/qiYW6kVLGktDgPn?=
 =?us-ascii?Q?OCMf1ZR9tYPxnXrP8K2qIyRDLwXY7Tf2iWMWwle/76rismt9VP6FVhJfK4SX?=
 =?us-ascii?Q?/vAuYuW5acVVBAQLtpJXCqh03vLJRWLCq09qFHSJownAz5g7FRjCic4iPhls?=
 =?us-ascii?Q?7Mc1fMv77UMF8OiyrK0ghSRxrq7d9ee1W/053SOgchUCCbE65DdjCfDCCnek?=
 =?us-ascii?Q?P+O0x+6ieTiZqdA64i7cf3edcIRZ0Lk9R+BINcunQsWqWrdSUfrfKwbctWqR?=
 =?us-ascii?Q?CWHtEkZugiK8pvHe5B6V4x4wbsZp57/Df1iwe9sbyvc7mGDw/wFpa+VmFiT2?=
 =?us-ascii?Q?kimnfcvwIRdOv6s5BsbYvWhRKhWJ75P82SAS4wm1plgJTrYeeQ64ACyaREUu?=
 =?us-ascii?Q?xDtjhaHaegkN/ne70JlM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoQcFIIyHOI7+nxQm4z0H0hDBKAaSYl3uBvdpDj6+Ah7tGd9/9J8CN28wMWx?=
 =?us-ascii?Q?IaC/yWqj6XblRzqCF1PJnS9fLEjTPTQ/EWo7H3QU0Uau5hQ3KAQNu5Y5Z4YA?=
 =?us-ascii?Q?6Y1m4ebz5/jt2Hk+E44klLs/GwMt5M6WSICIECJLaTU243jFsQ1LylQBxMGu?=
 =?us-ascii?Q?Foxgy3RALnU1YfV0sf9ImPgAMFF+z3Tf/7RptuiqaiDLPIWmGKOzNorSTFtU?=
 =?us-ascii?Q?5oIbQVJV9v2zGBM4ndtYnH2IUcTf00zBkmSLGOJHL0CBBiPJ/1tWHAMS5F2T?=
 =?us-ascii?Q?9pK5ksF/14eDDcd50fFKrx+js0GekksLE3grmd6/ByDNYtDANo3lUMYGdBVc?=
 =?us-ascii?Q?Fj6uHM5q31bA8XNLaDIDn62Op+ALnGyIKv7JRDYveWiqiT8R5IURL5loRrKf?=
 =?us-ascii?Q?G90NTH+vlCsZv//zQAfEYAqPGVD2g0dhcP5LYfxb+0oQ1Up5nD0KF/x3vHi9?=
 =?us-ascii?Q?F+HfQ5HD4A6fMI+IIT/jv/OdN6gxImRZL1PpVEOsm2n1S7RNskRmeuausvVa?=
 =?us-ascii?Q?JPgmyoVdLssV096OIJ3Z2HOlUCJUK4VT3itPt12L0/oge915GRwORypeZO/5?=
 =?us-ascii?Q?dtkm4dupevYjMOkd/NTcN+PNhQ4wGMZSD1V6mrAPoWRT8Lcuk++WJw3jxCAs?=
 =?us-ascii?Q?YGmIZUWp/pTNazlxo7ExYImMw6/Lrlj7tjELI9+V7kkRNEgwXtdcnH23dKco?=
 =?us-ascii?Q?sOcq1DyLemff4JfmGlOznXsIz5+6wBGQ6pEC5bl4bwmBulv0iAOmhimZJcQC?=
 =?us-ascii?Q?tpNXkvfc4+PsZXPffAAsNERA2y1HeIHU98MkOAuX4ysIkg7aQlTwgyHQ/0HQ?=
 =?us-ascii?Q?fjIVr2NE/UaXmQo1L3WPoCaWjuvkRE4mr6tWes0Yy6pQqgDKX29/AG6zNGrM?=
 =?us-ascii?Q?bKhKM4YU97g9AMqYg+6jQU3P5v9LFmGZo943ELSg3JpE6AD4nL1FhWOoPBwH?=
 =?us-ascii?Q?M+dOgZpX7tgMT75kShpel4IJisBtYxXpnyycYcc4w2EOvOEYqxVHACJNeFmO?=
 =?us-ascii?Q?+IumLJpFJFzvpfI0DM+8IxlEJFXqNRVGpyZEA4Y/3FKVKPfscjBu7ROjnj0o?=
 =?us-ascii?Q?nXdVKV6u0ws5Lf342OiiBZDiUQuxEj4PHL56g+iAQ0JgJmplkjYzxtQG0Ozh?=
 =?us-ascii?Q?o3QN0TzgakgowFiVD5LPXclJx9KWx0tsCmU2f2jvC0bb9HIvIItQ3tfl1aCu?=
 =?us-ascii?Q?CdQra6qZQxC4YbcMGbSJvz9BvDHnKfvSvJST4XY0UBSjeYdezsltvuCbRBj4?=
 =?us-ascii?Q?V5SgJdanbZXxddy20xATPlksCLaR5XSHuTCscbIL4rg1kVrlZtrgOhMAlULG?=
 =?us-ascii?Q?2wXbkkw2Sj4VTDeZDGDVbSl3TJhVVZtxl3ykey9w4a1LBInBL6i3ngx5oHS3?=
 =?us-ascii?Q?zygoE0WWVihVdBKH5mdXOJyeNuPuhI3g7Xj0RNhQK7CqA6TgrWnC9X9UGKjB?=
 =?us-ascii?Q?ExEp+L2jk04PzudwKCPl4CEgEOQka7fpX/Xf5vuGiCFeEofouy8qCDp5wZcZ?=
 =?us-ascii?Q?EipU6+2yBDVJEMwjYxiTOZBntdkLril4XQIdjhOIdx9YhIC9gXg6hWyGD3JK?=
 =?us-ascii?Q?bHIORmW06eLhMIyL7VLfcYK6zzPga3j4UR7Jn1y/vsWldVMUAKLeAFIPPixP?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c584d4-efa7-472b-a631-08dcfdc55381
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 18:11:53.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWp994PbjkqiVRbpJme85m5T7tjOjJtIMWpyXSAOAdlTNZxjXJmau4rlJsMLdxzqS+AOG3aSMRwwPzswawBl8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
> On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
> > On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
> > > On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
> > > > The GGTT looks to be stored inside stolen memory on igpu which is not
> > > > treated as normal RAM.  The core kernel skips this memory range when
> > > > creating the hibernation image, therefore when coming back from
> > > 
> > > can you add the log for e820 mapping to confirm?
> > > 
> > > > hibernation the GGTT programming is lost. This seems to cause issues
> > > > with broken resume where GuC FW fails to load:
> > > >
> > > > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> > > > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > > [drm] *ERROR* GT0: firmware signature verification failed
> > > > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> > > 
> > > it seems the message above is cut short. Just above these lines don't
> > > you have a log with __xe_guc_upload? Which means: we actually upload the
> > > firmware again to stolen and it doesn't matter that we lost it when
> > > hibernating.
> > > 
> > 
> > The image is always uploaded. The upload logic uses a GGTT address to
> > find firmware image in SRAM...
> > 
> > See snippet from uc_fw_xfer:
> > 
> > 821         /* Set the source address for the uCode */
> > 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
> > 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
> > 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
> > 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
> > 
> > If the GGTT mappings are in stolen and not restored we will not be
> > uploading the correct data for the image.
> > 
> > See the gitlab issue, this has been confirmed to fix a real problem from
> > a customer.
> 
> I don't doubt it fixes it, but the justification here is not making much
> sense.  AFAICS it doesn't really correspond to what the patch is doing.
> 
> > 
> > Matt
> > 
> > > It'd be good to know the size of the rsa key in the failing scenarios.
> > > 
> > > Also it seems this is also reproduced in DG2 and I wonder if it's the
> > > same issue or something different:
> > > 
> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
> > > 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
> > > 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > 	[drm] *ERROR* GT0: firmware signature verification failed
> > > 
> > > Cc Ulisses.
> > > 
> > > >
> > > > Current GGTT users are kernel internal and tracked as pinned, so it
> > > > should be possible to hook into the existing save/restore logic that we
> > > > use for dgpu, where the actual evict is skipped but on restore we
> > > > importantly restore the GGTT programming.  This has been confirmed to
> > > > fix hibernation on at least ADL and MTL, though likely all igpu
> > > > platforms are affected.
> > > >
> > > > This also means we have a hole in our testing, where the existing s4
> > > > tests only really test the driver hooks, and don't go as far as actually
> > > > rebooting and restoring from the hibernation image and in turn powering
> > > > down RAM (and therefore losing the contents of stolen).
> > > 
> > > yeah, the problem is that enabling it to go through the entire sequence
> > > we reproduce all kind of issues in other parts of the kernel and userspace
> > > env leading to flaky tests that are usually red in CI. The most annoying
> > > one is the network not coming back so we mark the test as failure
> > > (actually abort. since we stop running everything).
> > > 
> > > 
> > > >
> > > > v2 (Brost)
> > > > - Remove extra newline and drop unnecessary parentheses.
> > > >
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
> > > > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
> > > > 2 files changed, 16 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > > > index 8286cbc23721..549866da5cd1 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
> > > > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
> > > > 		return -EINVAL;
> > > >
> > > > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> > > > +	if (WARN_ON(xe_bo_is_vram(bo)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
> > > > 		return -EINVAL;
> > > >
> > > > 	if (!mem_type_is_vram(place->mem_type))
> > > > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
> > > >
> > > > int xe_bo_pin(struct xe_bo *bo)
> > > > {
> > > > +	struct ttm_place *place = &bo->placements[0];
> > > > 	struct xe_device *xe = xe_bo_device(bo);
> > > > 	int err;
> > > >
> > > > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > 	 */
> > > > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > > > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > > > -		struct ttm_place *place = &(bo->placements[0]);
> > > > -
> > > > 		if (mem_type_is_vram(place->mem_type)) {
> > > > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
> > > >
> > > > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
> > > > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
> > > > 		}
> > > > +	}
> > > >
> > > > -		if (mem_type_is_vram(place->mem_type) ||
> > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > > > -			spin_lock(&xe->pinned.lock);
> > > > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > > > -			spin_unlock(&xe->pinned.lock);
> > > > -		}
> > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> 
> 
> again... why do you say we are restoring the GGTT itself? this seems
> rather to allow pinning and then restoring anything that has
> the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
> 

I think what you are sayings is right - the patch restores every BOs
GGTT mappings rather than restoring the entire contents of the GGTT.

This might be a larger problem then as I think the scratch GGTT entries
will not be restored - this is problem for both igpu and dgfx devices.

This patch should help but is not complete.

I think we need a follow up to either...

1. Setup all scratch pages in the GGTT prior to calling
xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.

2. Drop restoring of individual BOs GGTTs entirely and save / restore
the GGTTs contents.

Does this make sense?

> From drivers/gpu/drm/xe/xe_uc_fw.c:
> 
> xe_uc_fw_init() {
> 	uc_fw_copy(uc_fw, fw->data, fw->size,
> 		   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT |
> 		   XE_BO_FLAG_GGTT_INVALIDATE) {
> 
> 		obj = xe_managed_bo_create_from_data(xe, tile, data, size, flags);
> 		uc_fw->bo = obj;
> 	}
> }
> 
> So what you are doing here is to
> 	a) copy each of those BOs to temporary system memory;
> 	b) restore them on resume;
> 	c) map it again on the ggtt.
> 
> Is this correct and intended? Looking at XE_BO_FLAG_GGTT there will be
> several things we are going to store to disk and afaics it will be duplicated
> on igpu. From the commit message I was not expecting this.
> 

This is how I thought the patch was intended when I RB'd this but see
above - we still have issues here.

Matt

> Lucas De Marchi
> 
> > > 
> > > should this test for devmem so we restore everything rather than just
> > > ggtt?
> > > 
> > > Lucas De Marchi
> > > 
> > > > +		spin_lock(&xe->pinned.lock);
> > > > +		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > > > +		spin_unlock(&xe->pinned.lock);
> > > > 	}
> > > >
> > > > 	ttm_bo_pin(&bo->ttm);
> > > > @@ -1867,24 +1868,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
> > > >
> > > > void xe_bo_unpin(struct xe_bo *bo)
> > > > {
> > > > +	struct ttm_place *place = &bo->placements[0];
> > > > 	struct xe_device *xe = xe_bo_device(bo);
> > > >
> > > > 	xe_assert(xe, !bo->ttm.base.import_attach);
> > > > 	xe_assert(xe, xe_bo_is_pinned(bo));
> > > >
> > > > -	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > > > -	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > > > -		struct ttm_place *place = &(bo->placements[0]);
> > > > -
> > > > -		if (mem_type_is_vram(place->mem_type) ||
> > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > > > -			spin_lock(&xe->pinned.lock);
> > > > -			xe_assert(xe, !list_empty(&bo->pinned_link));
> > > > -			list_del_init(&bo->pinned_link);
> > > > -			spin_unlock(&xe->pinned.lock);
> > > > -		}
> > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> > > > +		spin_lock(&xe->pinned.lock);
> > > > +		xe_assert(xe, !list_empty(&bo->pinned_link));
> > > > +		list_del_init(&bo->pinned_link);
> > > > +		spin_unlock(&xe->pinned.lock);
> > > > 	}
> > > > -
> > > > 	ttm_bo_unpin(&bo->ttm);
> > > > }
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> > > > index 32043e1e5a86..b01bc20eb90b 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> > > > +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> > > > @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
> > > > 	u8 id;
> > > > 	int ret;
> > > >
> > > > -	if (!IS_DGFX(xe))
> > > > -		return 0;
> > > > -
> > > > 	/* User memory */
> > > > 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
> > > > 		struct ttm_resource_manager *man =
> > > > @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
> > > > 	struct xe_bo *bo;
> > > > 	int ret;
> > > >
> > > > -	if (!IS_DGFX(xe))
> > > > -		return 0;
> > > > -
> > > > 	spin_lock(&xe->pinned.lock);
> > > > 	for (;;) {
> > > > 		bo = list_first_entry_or_null(&xe->pinned.evicted,
> > > > --
> > > > 2.47.0
> > > >

