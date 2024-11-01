Return-Path: <stable+bounces-89506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79A9B95A5
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857511C22047
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8041C2456;
	Fri,  1 Nov 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkNha2Y9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58F1798C
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479292; cv=fail; b=sDTyA/MuIe7rkxohbFQVTdXv3NRP0BZQ67tUefT4bctg10kS6DC5PromxRvFzDqTcy1Tx2E5amHWfLqC+/DtknubqySLcS7Ey2oJGanIIgnXlYMBFimtg1QoeYMFymvyAzJv4FqmqI4CUFI/Ub6mV/4f1LCzSv5+oBtyLc1jE4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479292; c=relaxed/simple;
	bh=dJYN/V2MDqiZj44Cejg49FjR02F5GlN3SehDJVv+V/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZROL72TXdaDUCg9SiWxbfXM3bHB/2QeXw3DyLkXzeySssAz/rvgcuzQp7TAgebz1+DySOrxHNxoN0/EuwEMre/twOFugJ5q4OeRmZL97XbycXX/n3H9wY5PPt0QHDfJ0yi4aKMOa4lOstFlqp2I54zIUkEP/rfdBzn8vaRw0aMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkNha2Y9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730479290; x=1762015290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dJYN/V2MDqiZj44Cejg49FjR02F5GlN3SehDJVv+V/s=;
  b=nkNha2Y9hMKWNX63FNaMKdYJ02iH7OPilNV5AaMrW08/9KSYF8/M0qpB
   1uKArssFRUAO65kzB9d0r+Ox35xcqOoFsE7vZ6+tMl6Q0NuaCeEL0PX+3
   iA7hb2KEvyM3WpHttKW54H0Z91DOlE86KSvTpWWzQUMa54PoyIsfSEdmB
   4WnuwEo60hiNgrSmKAZbaYbkcfrW8yNjN4tMat2hWoSB32mr8dkrqQguU
   PO/eateewZxVLiE5g49Fb8nbgppwMF1ng1TEwVKtunOM7Bow8Ddkl0abu
   7AFkG4CNw1jYMl2OZG6mBeowtkWKQsjLFQFDkJ6LxvxmEFBpE8SZI5le/
   Q==;
X-CSE-ConnectionGUID: Zq8Vs/9uSOO5IV4BtbKIRQ==
X-CSE-MsgGUID: OuSxrFyYRfaih7wJHhThrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30363193"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30363193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:41:29 -0700
X-CSE-ConnectionGUID: gg03+RcpQiOhfQbQBpWwMw==
X-CSE-MsgGUID: gH369GRHTyCvmGK3aBPJww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83450462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 09:41:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 09:41:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 09:41:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 09:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLQwerAxwqB6x0LOO8/U1SsDjYHQkonzv0ss5f2tiKvCNyRzDTkny5QxgvzXzl83nQBI4Z+BtyCwQeQ6sy3XsHZfhsSNqLyVjt8H98zSBE9FMdE3JnIJ/1w9DJO5AlrUym52IT1yxDHu3n56erm8W0TVOp7zmoX25UgkjXA3NWxXr5mGuoRalEM0W7/UNVNROgv57vAUXx/fhPAgkiDFfvQigL5GcmY6wIWPIZrIeDge2HVQmkMnF06N7LfIrCWHKslbo8lqlYeWuyNMi8gO/8Dnjr2Wf9ZQJaL+iuYPgZ67tFpm8T10Oj7b3geM1cfGx+SdMHjXoaCfMN4UDgLpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlZgIJqusaMb7BCzkzdzX4i1PNh3F7hHqt3YjkAcdr4=;
 b=qHX/p77ABCIPb7ufsQaEdOdbuwEZVeD0OVEUioH1MvPsrAFNne4Vg3mr70aAxm4AvUuAkP1Nq+XoE+Y/ke6qoEXfjeLwzOjZUXUE+w4wBnN5VH/Cgt/ZY6yDAP0y4OJnkWiu1xcCnkwCXQY2V/EOU9VkXaZuuVagJ3Rf2GBAqiAXCaXt9UqcxHFSKX+mHacei1QenhHuvoRYp09Wt8l0DM1WLbsav8JwBEI8r3wCLV67fwSm9kkBX3Zd3kDLBVmoZJbJ+jOUSbE4OQ7/Z7zSzuBo8cF4QI3ODox0vQWulCcMb0OZKZ1gbI2SqL/rZ+vo/GOwAdIrrbb5ZTSjXvJA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 16:41:26 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 16:41:26 +0000
Date: Fri, 1 Nov 2024 09:41:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/xe: improve hibernation on igpu
Message-ID: <ZyUE07ZAVtgGvxqS@lstrano-desk.jf.intel.com>
References: <20241101154724.203525-3-matthew.auld@intel.com>
 <20241101154724.203525-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241101154724.203525-4-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a5f65-ae2e-4583-ad13-08dcfa9406e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jZ8AkDdsxQhDs8sToFi3lriaNhfdSa/fEdVmlFJOKFuv1G83WdFg9IcZLMe/?=
 =?us-ascii?Q?75UmJeIFICPmI+jAGG+M0qQG9aLKMHmOiA5l8Suztow+nuRQwhBX1XfCpc5l?=
 =?us-ascii?Q?XKGcfVhBfsVTwhdArfFIUUHpF3jL15981iluZujhvDPbiJU67NoRDRV7C1/R?=
 =?us-ascii?Q?x75aC8wu01uzegZv0ThK3p31lVDS8wKTK+EzoJfZ2vtbJd5KW4Fs56ByOwHo?=
 =?us-ascii?Q?gc2hCmTwCqVbfovKJCYbG2gPVFqdYkuWJoH48JQZ6eaiUAtgUDCdu30o1EZ5?=
 =?us-ascii?Q?tWnaC7IfGeUmghiPqFFbpXT6KMEmXdSXI3S2tGCQa/2eWJFsxRNJOWNUVmyN?=
 =?us-ascii?Q?cJ9LEZ+PZg1H8z5o37N1lf61V/z8ZrENhXBRh1VWHP/dzBg3uKUsFxOWUaja?=
 =?us-ascii?Q?zpAfMMp5e6JdCV4OhZkJN2n8LPjTt+zyJn1PbP+EjOeqedAJN/50MAN3vt7I?=
 =?us-ascii?Q?OUg9HLo2q+xVzETXBT8SVvyKGZO6O/hTGs5rTahSPmAbdBpfwfwet7b8j5Ij?=
 =?us-ascii?Q?Nc8IDWW4rSjFp7J/UXB4hxEQsH9UcOnp9WITZ+SfQ0nrHQiG18FhZIZwgc+V?=
 =?us-ascii?Q?Zy9GFiOGyU5TA88Aa5EYpp4U9ykQrCd8/XDQ5bZUZG6qJSoyx8gYgRkJF9W9?=
 =?us-ascii?Q?ygD46POUJFERBY5yLzyYn2qV7vIsmHH3WOhgD5nGamvkmFe8HPoXMtqBguRU?=
 =?us-ascii?Q?hmEDfAsgoM2o+7mcYyGeKyqSDBRT/uC9/GzhCl/V+QiThhQhPYURN3D4vtkd?=
 =?us-ascii?Q?dNj18o68FQ+i3TsvseF0YwjD6Ki/ECBBq2YTfRVpaL8gn2VgrcM9NABiz808?=
 =?us-ascii?Q?I2gOa0pMVxj7mzpOTHoYtMyBgfJMrVS4E9gBK/VU6JwZ68iAxcZJbneujcFe?=
 =?us-ascii?Q?sCmVQs/dcHxtw8m8XrzZY0j+HmZBs1y8iZWF8Lm9XGIUCXdGRmbP+S+NdiAq?=
 =?us-ascii?Q?MKq2xOMC70NAtHQbuNQ2aezHtDYHL/4gBKNB+8WHjfUcky4GHCqZXa0beTjm?=
 =?us-ascii?Q?di4wZo0l0VteGwAD/TTOHGyPwX6JWOQCMJBOJVuXlHphxRnQGdTTgDciAUTP?=
 =?us-ascii?Q?xSg6q7uyw/XfoMzO5MQd3VrfC+ydsRcuSfuwDakYHUwq6UeP654cvrdAVg1e?=
 =?us-ascii?Q?+OLUJCIxTGHc4uTI5EJbtt5yRMyhHRKsAwRoIgfiwFp+2iVgc6gG5GAHFWu7?=
 =?us-ascii?Q?YThj3WizPlacXAqJgnObOComg8dGuUKKzU6BV1HcLuoPrZwkVG0n3qAlQbB+?=
 =?us-ascii?Q?nPEFaOdqNu3Y5ML2ZOeW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Z0xcoBv6jKg4yenu0V0SCNI+zuQo0/XKlaC2pK/V05sZ2FyPq1aJb95TOed?=
 =?us-ascii?Q?KEBAQFpQonRtml5Ss7d9yeiy+RbNFij5TqK0i2fwZ/HRSrqkZB10Z+F42JnC?=
 =?us-ascii?Q?VRGHeyJEcPafeQAfcNk68kJa62jPROXhrM+Ru70zjJp9S3HWZW/Z9z8g5qI9?=
 =?us-ascii?Q?das378GxynbpV+77zxb3qY+jvPJDGbq6vqrIPmcS7JcrsXE86LYF4JPA68xX?=
 =?us-ascii?Q?W4n5kRs/GmYs7AMNQoc/cRcRhWksEgIRqs3ip75CVq3+3xklvwUWH5lW5553?=
 =?us-ascii?Q?Mq48nfZ53f0HSHUR50jHi9suRlyVeagJ0yC02Vc+Ibxn9jU1/oZIwdtIEGNb?=
 =?us-ascii?Q?wBzAElMdCUzJQ/ArPcqMcbh+o33k2oODk7mGY7zQ9c2YmK4+yTmSJ8ANHPkQ?=
 =?us-ascii?Q?xzxtsd5FuGdR0h5K9KR/A4wJAuwHHPsN7eqCbcWhpakPdMzU6gWacqxITo90?=
 =?us-ascii?Q?+SacOJvjHiGU/el0c3ldR+POLvgWUH2TQbhhP9yF9bkDNmVRy23wq3dBuD4T?=
 =?us-ascii?Q?RRyKd2afM2HHcIsCYFWunjn6L4ZW1N59X4NJ1yNPVjCDMkvwUDEW2xBtS8Pi?=
 =?us-ascii?Q?sGIY1SjU9+Ys8qNYb7agcvSVjGXHjeZACne3zWdyA6olwx1RGYvQCkEozYc0?=
 =?us-ascii?Q?GgD+bekYEMB1U9oM2aKpabjNiGSpsyiN3gnlWkUEfV2LIrx82VV/5KTi7/jF?=
 =?us-ascii?Q?HmvXbGztY5hc+u1WwGAaBLI0k2zblVcUXCBlxnI7annz9+O+FKLFUEBruOe/?=
 =?us-ascii?Q?FXFgUqC+NXTwuuxKhSETOdxoiHedo5hPPQQSa0oA4ZhzQSMdV9I7QKiuGWr+?=
 =?us-ascii?Q?zQQZ2ehTJ8TtGStm3OPUxat10dz3owXcioWAU4CdRtWv+mBpne8BUA+6yg9i?=
 =?us-ascii?Q?Its4zbhCiZ4XoEs4HncJ98BNcBGKpmdi88sdGntUxvwnVUNIM9809BqeNNtU?=
 =?us-ascii?Q?9uL2eNnV7NiQyP7LM0oIStVRGxasrZeHyvfHmh/FQ5hLt/ojPn8Ts00T3RlK?=
 =?us-ascii?Q?dkAqHXnmYdyjvl4qizUy9VGISz+PZ2DV0fgyETINKJIAsHxMnutWbziCI9y3?=
 =?us-ascii?Q?T6uWrvpTOQtti/J5/q+oS1S70v7VB2UJTtPBW14Tp7sj5G7WkEBgsjgZ4Nk8?=
 =?us-ascii?Q?+U9jHKPEL0GEUvBTBaHJ3PUxEV4wVde1FelhIdRNYgbnJTI0a5/rj+CIo5RF?=
 =?us-ascii?Q?uqdedjlezQ5++ZAQAK4I4XM84QQuQpOIkAhNh2t0aupZjyLkQazOQ2eKPG0Q?=
 =?us-ascii?Q?3zHhR0+H9z2JyrucdLKdRSI7cAMJ2iRjjBlfbBmX3rRWYd5s4d/LHOWEdXWF?=
 =?us-ascii?Q?GeOLNY0uMmXOQRLAahW04l45FeFuixUc6Rh1WqfY+2dYr/xZZ4hPbJlD/TCy?=
 =?us-ascii?Q?EtvD+8MqMx1KGfXKutP6KkRVP56FvFi1lKF1FBeNF+hXmKIJRMIe/1XQqR0t?=
 =?us-ascii?Q?cWVlpkUFQPjn/AUHZ7VYhtH4JfOAA+jwPG1prLq9PMKdC7PS9nu3yWxwYQlS?=
 =?us-ascii?Q?92Jm0yNaFwiQsQdFwr0i21wgN2GpApyESJ/+MVGOzZMFJrM6tFUlv78SPxmd?=
 =?us-ascii?Q?5m7eAxf7HSdCjKWjftbj21fl2VJmuzrQ+ly3xCcfcSYTMC5eGS7gBXFCiahz?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a5f65-ae2e-4583-ad13-08dcfa9406e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:41:25.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKwAJlcNFrnAlqOe2FQ/E2RxINySZkBgihHSugMMjcOxdRONYq5CADQueRvkLgCa7HQOYr/hFhJKT1Kv7jf6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com

On Fri, Nov 01, 2024 at 03:47:26PM +0000, Matthew Auld wrote:
> The GGTT looks to be stored inside stolen memory on igpu which is not
> treated as normal RAM.  The core kernel skips this memory range when
> creating the hibernation image, therefore when coming back from
> hibernation the GGTT programming is lost. This seems to cause issues
> with broken resume where GuC FW fails to load:
> 
> [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> [drm] *ERROR* GT0: firmware signature verification failed
> [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> 
> Current GGTT users are kernel internal and tracked as pinned, so it
> should be possible to hook into the existing save/restore logic that we
> use for dgpu, where the actual evict is skipped but on restore we
> importantly restore the GGTT programming.  This has been confirmed to
> fix hibernation on at least ADL and MTL, though likely all igpu
> platforms are affected.
> 
> This also means we have a hole in our testing, where the existing s4
> tests only really test the driver hooks, and don't go as far as actually
> rebooting and restoring from the hibernation image and in turn powering
> down RAM (and therefore losing the contents of stolen).
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_bo.c       | 36 ++++++++++++++------------------
>  drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>  2 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index d79d8ef5c7d5..0ae5c8f7bab8 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -950,7 +950,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>  	if (WARN_ON(!xe_bo_is_pinned(bo)))
>  		return -EINVAL;
>  
> -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> +	if (WARN_ON(xe_bo_is_vram(bo)))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>  		return -EINVAL;
>  
>  	if (!mem_type_is_vram(place->mem_type))
> @@ -1770,6 +1773,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>  
>  int xe_bo_pin(struct xe_bo *bo)
>  {
> +	struct ttm_place *place = &(bo->placements[0]);

Checkpatch will complain about this (extra parentheses).

>  	struct xe_device *xe = xe_bo_device(bo);
>  	int err;
>  
> @@ -1800,7 +1804,6 @@ int xe_bo_pin(struct xe_bo *bo)
>  	 */
>  	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>  	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> -		struct ttm_place *place = &(bo->placements[0]);
>  

I think you have an extra line.

>  		if (mem_type_is_vram(place->mem_type)) {
>  			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
> @@ -1809,13 +1812,12 @@ int xe_bo_pin(struct xe_bo *bo)
>  				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>  			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>  		}
> +	}
>  
> -		if (mem_type_is_vram(place->mem_type) ||
> -		    bo->flags & XE_BO_FLAG_GGTT) {
> -			spin_lock(&xe->pinned.lock);
> -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> -			spin_unlock(&xe->pinned.lock);
> -		}
> +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> +		spin_lock(&xe->pinned.lock);
> +		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> +		spin_unlock(&xe->pinned.lock);
>  	}
>  
>  	ttm_bo_pin(&bo->ttm);
> @@ -1863,24 +1865,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>  
>  void xe_bo_unpin(struct xe_bo *bo)
>  {
> +	struct ttm_place *place = &(bo->placements[0]);

Same here.

>  	struct xe_device *xe = xe_bo_device(bo);
>  
>  	xe_assert(xe, !bo->ttm.base.import_attach);
>  	xe_assert(xe, xe_bo_is_pinned(bo));
>  
> -	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> -	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> -		struct ttm_place *place = &(bo->placements[0]);
> -
> -		if (mem_type_is_vram(place->mem_type) ||
> -		    bo->flags & XE_BO_FLAG_GGTT) {
> -			spin_lock(&xe->pinned.lock);
> -			xe_assert(xe, !list_empty(&bo->pinned_link));
> -			list_del_init(&bo->pinned_link);
> -			spin_unlock(&xe->pinned.lock);
> -		}
> +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> +		spin_lock(&xe->pinned.lock);
> +		xe_assert(xe, !list_empty(&bo->pinned_link));
> +		list_del_init(&bo->pinned_link);
> +		spin_unlock(&xe->pinned.lock);
>  	}
> -
>  	ttm_bo_unpin(&bo->ttm);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 32043e1e5a86..b01bc20eb90b 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
>  	u8 id;
>  	int ret;
>  
> -	if (!IS_DGFX(xe))
> -		return 0;
> -
>  	/* User memory */
>  	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
>  		struct ttm_resource_manager *man =
> @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
>  	struct xe_bo *bo;
>  	int ret;
>  
> -	if (!IS_DGFX(xe))
> -		return 0;
> -

Aside from the NITs, LGTM.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

>  	spin_lock(&xe->pinned.lock);
>  	for (;;) {
>  		bo = list_first_entry_or_null(&xe->pinned.evicted,
> -- 
> 2.47.0
> 

