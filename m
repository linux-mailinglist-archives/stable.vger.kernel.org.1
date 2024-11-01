Return-Path: <stable+bounces-89508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9319B96A6
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C421C216CD
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95001CC178;
	Fri,  1 Nov 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPbPbrVb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA01AC884
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482710; cv=fail; b=P3ji/imhRyb4bba4quhFfy47q+rrk9OTYCKxmIwd1de96ClfyX/xpmuV5KJkAtFtyBrzLtDopJzN6gvWMJ76qUcFud1ljGaJm4Z/JjLSkgxcrrcO35KrfJUxdueu0t++2XwPQfhwLvR6VCZ8y2visps3ipi9i6L5SfD0HHrN7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482710; c=relaxed/simple;
	bh=sK1/uPAFEMgnbopdhHt1QyCPPMHZQWpyxa9lelXoHe4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrpnEoS0pXWPn+ZlgJplQgMxIOtZO6BdYceVJrUQSj3p5l1kNJFFdqmhsKYYSF1q50cpCjMJDpAC7TOTl7nVotPY5v6q0YDnf+vUHb/tS0xHb84zAH0sbYBggjSYkMlViFvSBAFkrm8hqP6589TrvpTrmQplGESay1liKeTW8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPbPbrVb; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730482708; x=1762018708;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sK1/uPAFEMgnbopdhHt1QyCPPMHZQWpyxa9lelXoHe4=;
  b=JPbPbrVbu7uHaOkClHuBexFyuq9a6SILfbzrlmtgzB274V6DeTwAKdqI
   DYPAlQIvgUUrIK84HCNbt5LNllwvl3S7E15+6Qf/JshQtoj41EF7tziRE
   OVmd7mYI0H6uZUhcVcpe/LxYyRE8j2bXckSS3Fz5QkgFLLDdxbNPDZKFW
   N+Kkhrk04LaGJrf1N4TGQKnD3RhT9rY20yeeI1bXcH0yfwQOutqUSndr7
   ZxnRSlqV8GeF/TaJiAAQHUJf6zt+QslYFMpGU9p/zrWMFbuJeTUSKH9bl
   MSaZgx6FU0y2wNa4gytdMsvVfqpRIB+2y6Ys9GqzyWrsAKSxIhySVo5tD
   w==;
X-CSE-ConnectionGUID: cfOlXEDORuKAy5VEni6HBw==
X-CSE-MsgGUID: ZTAeQl3eTx+7VARpUR8f9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30212025"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30212025"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:38:27 -0700
X-CSE-ConnectionGUID: UvbJJlJEQSuTlHM+OIm1tQ==
X-CSE-MsgGUID: qmY3SiosSXy+fMt4jIwTEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83846417"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 10:38:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 10:38:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 10:38:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iltQr4ff245A7EKlz89//asPRhciY4jM3ML9Lvqhv3j/q6BPX65sUqaek472hl7xWF/PwGghCu1Cwt/f/uijiVw5QM5eLhWWCtq79vXAFTt4je0lnsxeYnq/8AR+oT8LTmupeOiTyIdiFgm/2jXRVNyrl5OZib7lLJ56El+PFaFCNHe4LG2X1RrZMZW+WcxkD1hmfbpxGUrFzAGZQBGJMdscdATFBXVJEgR466ssxmo0gKUyhO4XbFgDh/K9qKQuY+QTWmGSzc6OeyrUYyg+F+DvtyWgb15Ab9NE2X+R5Tj0k3HvXwAi1jTuPmYLFRp74EY9G+xjjpa/4r7W267qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLrAvZEwclf/sPHFh2LOCtqhlcaecZpaI9hp62X+dmQ=;
 b=BJ2LRog/bM0h33Xtn+uu8NsznZxd2NqUwURnjMCxO1Y3HAnV9U1SxCxyTULmIHsJRF8RmIEN49eIhbtmmGBsbF+nhEFASmilh4fqS/6qAAm3IkxVBzV/IY6XB3p9m4SakMj+Bm83KdiDTz4B2JD1WoefnuIPl8BwTCtriZIHwc5AaXhnlNzvlpjB3lqRrGGHF3VYN8gSbWLSeYdM1FL/wSjO9/Wx4AlLmSTjOxKRZXuxrk5Z503XurjrLLmtYjs6z9NHulo7JaVZm1ZjmdFjwfZdMSM/WZDnnPd3TEYkHIjdyr9cDKhkX+ntEdOIZYJJsfUB3FtxxYxz41kCqAK3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 17:38:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 17:38:23 +0000
Date: Fri, 1 Nov 2024 12:38:19 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
References: <20241101170156.213490-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241101170156.213490-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ba1ff8-afa4-4bb8-b99f-08dcfa9bfb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7AWFE4YMkyMm772ivRDfhl4Us6h2eWzdnZ38gh6Mdhr5GOlNOW4gdMMSguG3?=
 =?us-ascii?Q?GYfqbFavpSoaJR8Ox3jeUsOpm2RK8FzrvbPAnt8Ime2wayiiIHt+rRPmZXov?=
 =?us-ascii?Q?ZiyK/fvrGt4xSNDXkW7gRFi4GqqjJzpvXUBu0vmtgg/W1PTv/JATLUU7jfiF?=
 =?us-ascii?Q?GE1Q8MoatLvulA1RRfGNHhbsAti+TcuT/vsapmBK9i7W+1FpE0CCKfKySezf?=
 =?us-ascii?Q?sCujutEB46jCsGdbWGAmbQzbzNz7JlPAEg+y3Q/UGioUYtygOKJDBI8pAgWx?=
 =?us-ascii?Q?yOYN8wMQZHfC9+mGcVkRzcA2glP6cpw8xdJcmX8wUTcZ8T648AjsULyoxAAe?=
 =?us-ascii?Q?hxfTcTAMCQ0jFRp//ipsuHCyngP1MGdYGGxWBZpZ72aQqIuq/5Gfa1Xw3BNn?=
 =?us-ascii?Q?BzQ1OfpwM+1hNbSoH3tcnAATa7H1Hszu6wcGbnwG87jkhDnhY9ou0AcWLTG1?=
 =?us-ascii?Q?ZT1BiaFm5odatwyhu1kAddfRAPcDyLtVeqA2CYoH2QvX27M8uWclOhAAHnt5?=
 =?us-ascii?Q?g6PBV9vFgm7hY41AuTBmIkxlHREJyu8WWFeRg62Zi1mVkPCOLvXovPabYwIi?=
 =?us-ascii?Q?BmcHrHhz9rXqq+FNgg5Kfzwqz5BQ5AQe4uUUJBiDSL1BvtUgaEj7r0Z/Zlkn?=
 =?us-ascii?Q?vMrbKAtFCNw/f/cf3k97RTwRzex3/IUMDoCCENgpA3nUliGwtSGqKuAPZPG+?=
 =?us-ascii?Q?PPeu3Ld0YS4nF7/Y5Lmkpro3jbHm6/Y3f09pArBjLGPKWA51UXIyxwNTtDjU?=
 =?us-ascii?Q?q0YzsmtvQy2ze3IrZ1adlRY5ohYX9bdR1fDuES0kUfDFUJ5WkvI3c6aBcn6b?=
 =?us-ascii?Q?QHzfZakpPtdME0SfyqrpFWOK+w3IzY2tRdq+OXvPiWx1L+3KB4MyOXHTfsY7?=
 =?us-ascii?Q?RNMH12QofN07eHEEqiI6UTYh0gLfMVJJWQtcJ5nOiKN6Yf92QuUzwvlPYFJu?=
 =?us-ascii?Q?RVn9d4hiFT/W68j3+FSUIPLuRGiVE+hJVoTa+q59v6w40ODF85BHuDHEySWQ?=
 =?us-ascii?Q?yXA6CntMx1qnkY0f/SQ5OD2S5QYALEssIWh+beAp44Zc3NoMHEIiQMsJjnfg?=
 =?us-ascii?Q?RAJGkJ3pGN3dEOzNK6tT8lvUh6UugMSNz5ApnH/BFZX8Iabzbc/vFDHL/Pod?=
 =?us-ascii?Q?naPBaWcfd4N3QW6sbLNaEiegTMPRKlP/cVoruhFwA44D6nDH3IadzXMvFSGa?=
 =?us-ascii?Q?eHiy1TrGAVNWxwEIWSMyOPSLxvpyr7p/IAASwgWMTXd3+UQrc8wzhowePEBX?=
 =?us-ascii?Q?ERNkY+rjUpdcha8ldQsO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S8FqLk5izKrbZC4yhcAkbklUVntwuFQQp4EShoRGQS5VUx5Y6+5s5YGH73pD?=
 =?us-ascii?Q?WWOdBS/GbwkpR9NZQvA5Axyn3mhySH5Rogq5oX2VPhrHB72lcxbZBtMOx8+9?=
 =?us-ascii?Q?y1saR0/ARG4KnIhiOnhGil02WcBxcYcySYurjgLVOV8mfimy+hbOoNuvIxPK?=
 =?us-ascii?Q?rMAdopLxScJxjz2101scm/T/ZDRYxnEhMjTZmjzNNIwS9ckmnSDAxj1NoH8N?=
 =?us-ascii?Q?6pl3lI9O89PBMJWhK0G71G///S1IUuuMLUAtEtup2TJmpF5utzjatKSsuCdf?=
 =?us-ascii?Q?KqgYqQybtmhQbS/Xv11CSfO7HE7lvPDOS1Dw6zRtpZHNZEwAcd8cm6N1xqNx?=
 =?us-ascii?Q?+IIjxQmlPdV+ltvOom6TfaIWQVX9Y+D8hOSszCEQAaJUPZUsBHFSfKiZvdPz?=
 =?us-ascii?Q?n7Gkk8bVytGa8/fQd2SZDqQpG9CR0ijhFJ0wGi2su7irBP4V276BAa7vzY5U?=
 =?us-ascii?Q?MEayx4XDAB56QLjafZIH/79GWh3W04Wr/mXVM6L2sbSpfF9/H3MllN2gevOF?=
 =?us-ascii?Q?dbL3WRvdZY4z7e4WMATpMuMP3/iCv3WAnS1sc1fA0cx7VQ06HG+yhTMl7qyg?=
 =?us-ascii?Q?cjUY/bo4Z8PANDmauRZVUphtX5YNZrqm1MXzhA6jwc9vaRuP1Zulee0roN1I?=
 =?us-ascii?Q?MLrA9W2QMInTwltZcoYOyq8BOPYBEK7P2QriJb3sLPZNmVUJ/91I2vqj3Scs?=
 =?us-ascii?Q?YNGTdXzJVrUCKzcx51MnEYcEGB5nZKm+gSTwpWN1MPlsqW9GMNKqcYFf7Iga?=
 =?us-ascii?Q?bjvPa876VzHXQ6kMTkLUR76eG/dGf5AGK7b4Y2DKjuy5EncG3oJkK9l/OPpe?=
 =?us-ascii?Q?VqvWt2vK2LhZBpWMzGotReCLmjUDgiGBvFpYCOFjIdUrm56e1lkvc1dL4HOu?=
 =?us-ascii?Q?scZgeC1S9YbAHsUyvuhgqcu3ogyuVHuaSNfgdr8BcefzCm7bGLDvLboeqCtz?=
 =?us-ascii?Q?FiOnSRPA+qqRmE8hONNqL49MM3NhuT5A2+FBNkveep9M6ph9v+bQXxI0w1di?=
 =?us-ascii?Q?JEvltMtHBnqPZI5Zkot94miq4dLnazyT8JLSJn69v8n/KczFm8Ue1yA6rNXg?=
 =?us-ascii?Q?nxClLP7E9YFUxAspW2F9wp7m33eC/QXoog49IbDq5DtgdDE2BrmnMFaldHqq?=
 =?us-ascii?Q?kfG3zvslEkTkSonYb9RgFeZhGhOYB/P7ARMGvaQJNlDD/VZVRoweYPMaotzA?=
 =?us-ascii?Q?ozgmPTrF8h4KoVA2dKGsdrGUksK2efIsyFNVh9pavFlhlCn0kezrKDJO5c+8?=
 =?us-ascii?Q?MYJSaqs3L2KWboYEhNi6ImEKEhKC6HHTtMNa8nZ8I5NaRgUVpquS1zLV+gB8?=
 =?us-ascii?Q?8J9aY2OEAd/urD/MdobkANmI0ZaYLrmorUzfsYrSSvSJz3d1wyhKApX/pJHc?=
 =?us-ascii?Q?5FNhe963nunqT2Wz/ZtPRGDZDQaleVPFZuzDv4GGjWUGPNONCQ+FTiQNy1Wz?=
 =?us-ascii?Q?c8l7u2Z1lxze1LKx3eI41OtAqRPVCGof25hGq/ZzCyKCZLE7HtiOieFjQeDi?=
 =?us-ascii?Q?kbLpm9JTOibzdx2jO4Ga2IpedJFGGsdZOG+1mdO0JlEolr65I2npyWKLw9jK?=
 =?us-ascii?Q?pWjxCj1Z17VauOMMKYXpaCL04KkpuOUz/6vgSUm0AWfd5rtsCPTAf4XkTeFl?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ba1ff8-afa4-4bb8-b99f-08dcfa9bfb93
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 17:38:22.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bZl1gfIfZNMxoIpKICvJaVuQGPoMB8335yc5e9yzw/V6+zYcnekF0Mmspd66N3w4bxl36KbPlDT8DR0tTVFYL2+zUsyhB3Bk+o+J1YPqfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
X-OriginatorOrg: intel.com

On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
>The GGTT looks to be stored inside stolen memory on igpu which is not
>treated as normal RAM.  The core kernel skips this memory range when
>creating the hibernation image, therefore when coming back from

can you add the log for e820 mapping to confirm?

>hibernation the GGTT programming is lost. This seems to cause issues
>with broken resume where GuC FW fails to load:
>
>[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
>[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>[drm] *ERROR* GT0: firmware signature verification failed
>[drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.

it seems the message above is cut short. Just above these lines don't
you have a log with __xe_guc_upload? Which means: we actually upload the
firmware again to stolen and it doesn't matter that we lost it when
hibernating.

It'd be good to know the size of the rsa key in the failing scenarios.

Also it seems this is also reproduced in DG2 and I wonder if it's the
same issue or something different:

	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
	[drm] *ERROR* GT0: firmware signature verification failed

Cc Ulisses.

>
>Current GGTT users are kernel internal and tracked as pinned, so it
>should be possible to hook into the existing save/restore logic that we
>use for dgpu, where the actual evict is skipped but on restore we
>importantly restore the GGTT programming.  This has been confirmed to
>fix hibernation on at least ADL and MTL, though likely all igpu
>platforms are affected.
>
>This also means we have a hole in our testing, where the existing s4
>tests only really test the driver hooks, and don't go as far as actually
>rebooting and restoring from the hibernation image and in turn powering
>down RAM (and therefore losing the contents of stolen).

yeah, the problem is that enabling it to go through the entire sequence
we reproduce all kind of issues in other parts of the kernel and userspace
env leading to flaky tests that are usually red in CI. The most annoying
one is the network not coming back so we mark the test as failure
(actually abort. since we stop running everything).


>
>v2 (Brost)
> - Remove extra newline and drop unnecessary parentheses.
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+
>Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
> drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
> 2 files changed, 16 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 8286cbc23721..549866da5cd1 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
> 	if (WARN_ON(!xe_bo_is_pinned(bo)))
> 		return -EINVAL;
>
>-	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
>+	if (WARN_ON(xe_bo_is_vram(bo)))
>+		return -EINVAL;
>+
>+	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
> 		return -EINVAL;
>
> 	if (!mem_type_is_vram(place->mem_type))
>@@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>
> int xe_bo_pin(struct xe_bo *bo)
> {
>+	struct ttm_place *place = &bo->placements[0];
> 	struct xe_device *xe = xe_bo_device(bo);
> 	int err;
>
>@@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
> 	 */
> 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>-		struct ttm_place *place = &(bo->placements[0]);
>-
> 		if (mem_type_is_vram(place->mem_type)) {
> 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>
>@@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
> 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
> 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
> 		}
>+	}
>
>-		if (mem_type_is_vram(place->mem_type) ||
>-		    bo->flags & XE_BO_FLAG_GGTT) {
>-			spin_lock(&xe->pinned.lock);
>-			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>-			spin_unlock(&xe->pinned.lock);
>-		}
>+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {

should this test for devmem so we restore everything rather than just
ggtt?

Lucas De Marchi

>+		spin_lock(&xe->pinned.lock);
>+		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>+		spin_unlock(&xe->pinned.lock);
> 	}
>
> 	ttm_bo_pin(&bo->ttm);
>@@ -1867,24 +1868,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>
> void xe_bo_unpin(struct xe_bo *bo)
> {
>+	struct ttm_place *place = &bo->placements[0];
> 	struct xe_device *xe = xe_bo_device(bo);
>
> 	xe_assert(xe, !bo->ttm.base.import_attach);
> 	xe_assert(xe, xe_bo_is_pinned(bo));
>
>-	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>-	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>-		struct ttm_place *place = &(bo->placements[0]);
>-
>-		if (mem_type_is_vram(place->mem_type) ||
>-		    bo->flags & XE_BO_FLAG_GGTT) {
>-			spin_lock(&xe->pinned.lock);
>-			xe_assert(xe, !list_empty(&bo->pinned_link));
>-			list_del_init(&bo->pinned_link);
>-			spin_unlock(&xe->pinned.lock);
>-		}
>+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
>+		spin_lock(&xe->pinned.lock);
>+		xe_assert(xe, !list_empty(&bo->pinned_link));
>+		list_del_init(&bo->pinned_link);
>+		spin_unlock(&xe->pinned.lock);
> 	}
>-
> 	ttm_bo_unpin(&bo->ttm);
> }
>
>diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
>index 32043e1e5a86..b01bc20eb90b 100644
>--- a/drivers/gpu/drm/xe/xe_bo_evict.c
>+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
>@@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
> 	u8 id;
> 	int ret;
>
>-	if (!IS_DGFX(xe))
>-		return 0;
>-
> 	/* User memory */
> 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
> 		struct ttm_resource_manager *man =
>@@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
> 	struct xe_bo *bo;
> 	int ret;
>
>-	if (!IS_DGFX(xe))
>-		return 0;
>-
> 	spin_lock(&xe->pinned.lock);
> 	for (;;) {
> 		bo = list_first_entry_or_null(&xe->pinned.evicted,
>-- 
>2.47.0
>

