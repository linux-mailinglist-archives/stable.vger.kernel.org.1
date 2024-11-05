Return-Path: <stable+bounces-89909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB19BD36D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6FE284026
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8ED1DD0CB;
	Tue,  5 Nov 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbN8HDTC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C01925A0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827973; cv=fail; b=sjWLtBjD4raalbNXn0zUjCDOcSM+/XWuCGFYY0pN8bef/AlDUPJLkJ5HUdQleEPZlbTVmtVZEH5VPk9WRXXqhJTw3sxfklzhif9BbZcmlZ+rpf/FDrwxXi+nUHxSRYFPzzFnuQ4nc2s2Mc91/Wlys5yyPM8NTHZwqlcuglWWnIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827973; c=relaxed/simple;
	bh=nG3dypZNW3HFQgnDKtNjJAHJNTDTslykqWXSWiw0XiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRodQMqSePJuxZy/ba/i1irATnpiHOUvjw6xT33S+DY9aWDBTEs6jeokLlWiteVKp5s+QpgA1tXWT1GZ/DuI/fcWDhGD/S6D0S5hrxXqLMmTdmJTcM8J2lf8G3iJs4TZNGhQev+w2wPTvaF6by9NGPrvtEeGpu/QdQlNb83gim0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbN8HDTC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730827971; x=1762363971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nG3dypZNW3HFQgnDKtNjJAHJNTDTslykqWXSWiw0XiY=;
  b=DbN8HDTCamAkJwCljudZPd/7Kra0V9CD/duC/qWL3JjO/zKeix8swkLm
   SO+0wKdxhpLOxyUIAFXu6YKtgqTtYb3GgGnMa4rENw2GpVm/Lxa8SnuJB
   Q3jcZHkHM3DYMvYhPP1Nia4uhPZ6E73S2fTeHEOn1biXvk9e1+u5uyy6S
   nXzr5gC/Edv6/pHmBWpYwsT3UA6Ugyuqhc5FbKcHY7ndvE2MnAggrotiz
   kFLqvjboUWiHa8HU+dNxCDdUesjucvcbEbozc2PqbpNtBpagsADG7/7w9
   ifyrAksK8kdJDSXxROP8IkX3pKzKd09cUPLfxbKqFwD5YCfsfk4fm4gbJ
   A==;
X-CSE-ConnectionGUID: xl5cx/ZPSVSxrb7DxKumqw==
X-CSE-MsgGUID: jLYMARJUR5uHpqiXG8nuOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41219092"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="41219092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:32:45 -0800
X-CSE-ConnectionGUID: 1k6LwYjzQCaB+W5FNvFkNg==
X-CSE-MsgGUID: Qu9DcvkbSkqCDgJuUf2aeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88898091"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 09:32:44 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 09:32:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 09:32:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 09:32:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgBgWbtkksVHzIYIPHp1G1c3kFqowvvvc8cIx1LprHKAgLcEaBEJsTmZ8cAyiOR7ev7faGaOg3RDnKuRP7EvhRFD5Xj0EwNbI6WXN3BFgAUL7/L0tSBKBPOj+yUnYeNW2b5fXFu9cYJDExiQf9H7HPqNQpZad1iKbipuxFsCAhZKD6pLX6xuNRHwvT8GBAxpVYJmJk/tKMXDCF9JLJ9zsR1UpJRmXUFYBcrOkM2YiO/JNLcw8ZJkpPrOzPOUMXpjsRVSSgizLCuds7iOZvXBtON8FwYid4uWuA3JxniSyO/7G1Xx2632tJMAfvPOOnY6BwmUQKYfwiUpidPQkZmuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cg+OVDgjjR4f384w0qDHSol3GMSjK3d7stxLod/Sf0=;
 b=TkOvjF3hDpHGLYMDG1OxqPhXgrf/2DP8MgVSWoKJ2XFci9KyuA4isL3Ij31mGRvzROavTyGv6d+rKQxcIhU7cCjAOA6O9Qx+uiA2RjuWwiDBJYVHd3XsD92HBKJTRG0KiJ1ekuJ15tJp7VsiaxSIZ8E0xXTi/idQcuL91YWNMvZYJ+FP56TInjS7pn06vqgB0wpZBLfNohkJcZ4Q91LuUYyL6JUrV6QowMayYOBJpaTlTug70+HIHSpu1lAw+oJV8pOgah2S3QSqOqui1WzAl/GOkMixJAs5W91rj9DI+wjlYhlOuMcpqW/ckz/H/XLLkdVfYsE1UPL9c0nCz5R/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 17:32:40 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 17:32:40 +0000
Date: Tue, 5 Nov 2024 11:32:37 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fca3512-33ca-4b32-a94b-08dcfdbfd8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dQP5hIrHyMH2uzgbwb8L99DlNQn6Il2DYtkbneC7BaI095J0uT8rLRY6BjGh?=
 =?us-ascii?Q?v6POWP6HJPuQ3V5UAQeeL7V2Wsgb+hrWgrQThmbRNwlYkwbK6ekpFjSscAxd?=
 =?us-ascii?Q?ojMpzhBdbJiRIjQ6+eoFJrbzdO0uyAi0vvhTKsZjIcdTcYU08ZFFRN5UszWV?=
 =?us-ascii?Q?kIQiI3Wu1cEnnLAVosjyzQdqeKtT4mOHVmFcAKsk/eE/p+gGYiOJOVWk9Bl1?=
 =?us-ascii?Q?I8QqYqmdZaLLX/0lVKAypx9CixD8HD9AVepkgPF+ua28Fm3eHaIfU8I073NM?=
 =?us-ascii?Q?yzZ4lZskr2X0M5UwjF1w7KWriNXlBhcZaZaT21RqUeL5QW8RXkOXOadZzHus?=
 =?us-ascii?Q?mAkNC2cxW52VKoF5uJY+auuJcrCnkt31b0WISjnLQNmPF/YgLpWnArX3Na3E?=
 =?us-ascii?Q?nsjKPTay+a/0TRc+GJsRpp8/ll8c2WwbtR9x+Zax4RIUeprZ4+13YfL9I2Fi?=
 =?us-ascii?Q?1Fg5OIl1RoY99k2Ix6/4nV4lKNtqm5MCu3OTnKH7BuJZuUbbjxfpu0zwHXtO?=
 =?us-ascii?Q?zRB+iKzDBp4TdBmzIV0T+FkjH72XWbHiewMI1l7XpiVQwwdPR/65BBblZJzG?=
 =?us-ascii?Q?1+suXskGqmU6WY4B9uJ5/cVK15teMtt1cVehEJUKrF3vRqpPCLL75rlCTTix?=
 =?us-ascii?Q?tqe8BbuQT/i9q+RH6LyemeTBcxtQiE5ntRWmsBFmGe7kFaZndrrbHv9TLYW6?=
 =?us-ascii?Q?3hdOLRBFstTFbmE9XSSbDQsewCpmITffh93CooRP0OCOYckSa49Nsgj9viBq?=
 =?us-ascii?Q?+iTLj5tMUMToWoA4piItY2YiQ5zD6tHXtlI7B++YzDo40dBPD8q753pCC+9q?=
 =?us-ascii?Q?t2YebC9j7FQWNtm6a2m5invhDTZyMb+zncui4ExV1YRGN0dVWVW3Ecs+ZK80?=
 =?us-ascii?Q?TJf0F7nn39TA8JLz69j5f3wP06OYV7j0xF0nQUZ0I9RaUk9ByTK7IZ/0ySq7?=
 =?us-ascii?Q?Mx7JdEo3eNsp3TuxMegHY+e2FtRyRMsfLuwWJ6r0YLldWddq7ykctzIGysZ3?=
 =?us-ascii?Q?LcNyq/RoVtkabun8TGcKgR4vOg91oMJw6aBrWSeE7lMiZsN9PymqeIj3PZyK?=
 =?us-ascii?Q?mSHUUFapVXy6rIKdYP39i2dUKMCtUtQxKexB/M4KKN017pp/cjDHZ7IDEN/t?=
 =?us-ascii?Q?NmQVII31K1Fl6h5F1D4wLufnMmfI/zv0G0Yd/VDcQmCBaj9UAWq50AJ7IvJJ?=
 =?us-ascii?Q?kLfl3SAPzELvPJm0SsxYRbC6PWjnif3IdCkmn+16wiM1BX82hUDXOqlNvJKk?=
 =?us-ascii?Q?Qg5EsGR9eSLv22kKpfWk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25n/ZwB2otrm2pDv8fB7spiHmih7A+wzPTOkM2fo9Ieax+waX17iN8UU+ntT?=
 =?us-ascii?Q?baSZYhEazwPQL5BJNiqYBp4YURuiEh/XbqatfJTAFNz8sxZhylTNzOYYjGHh?=
 =?us-ascii?Q?OOqRduXxMMOdgcbl0JZBja8BbnQ39pbfqpMm2rplLU4L/PPJutfdKYJGYBIm?=
 =?us-ascii?Q?KUQolCMsqAEuuYdofB1TqMkCSDVNDKQpMhJNHVJtDdjUQ/W9G0Aja6c/ht7W?=
 =?us-ascii?Q?MYWw7KD3X9Ozf+MfdblqwzW16BqhgAgL9FCPqRDmoZ1L1wPpismpl+2CSUqK?=
 =?us-ascii?Q?YdrI4RLAUcfBeVrulBv0jesvROc139s8Gd1YS7sQKVipMOn1dttWJUjgMaz6?=
 =?us-ascii?Q?fFBkP0RR8WBDy67DeoDEg0xcl1YRfpHSOIhm36ddwx582j/yNJbQxYFLkZY3?=
 =?us-ascii?Q?nRDbuuTnN6Tw1SErjPeAV3CMpLbA0UCehtZJsJ37Nyw5z0b0vNblyDyFOT9v?=
 =?us-ascii?Q?W0Gn3absUIDPIBCXC4pb1NmZMUy9MK0yfWmTrtsgPwxGsBublGaXlZF8q7mG?=
 =?us-ascii?Q?3TNgCxB3ki9XbkxZQmA36KveED8Pv/4uAIJYnfYGLKOruZyqC2cY0Rm84lsi?=
 =?us-ascii?Q?cRsc2XlCmaVWjl2FWei8b6ygGTGiqWZSnLj7Oauy64N3rw1gveLUdkq22GeL?=
 =?us-ascii?Q?thdlSHLnaebq8b5vmrf8tPUhhYGOhfE1Oftgr/HwQRRloissVpKElC9YGOmu?=
 =?us-ascii?Q?OckHNPXezqV1YOtA6i2gC669RuKUpDB0F1LgBbXbd6590Wm+FK5X30qVilmF?=
 =?us-ascii?Q?ah/rjSroyFs7J08zLTMh71b6dEl9f3TsCcMfRNeAtnvn7DPwuEbTZ7PX8jWR?=
 =?us-ascii?Q?IrFm4L02Oau3rT7smKQ6hVnrWe+uXHha6qVYfhig4u3KYsyIEWCWnLnl/aat?=
 =?us-ascii?Q?biBrZ2Aq+jR0F9W1WHVQaYUN8MlB5vHmZMoJXHmCsPiTlrcmXe9bquREiN/J?=
 =?us-ascii?Q?E9YRvd+UL+wUPwLHojvguRy+3zZu0/yG/O7WXsdVLiMuACyv34vSG6CwYkvu?=
 =?us-ascii?Q?ncqe3r4VKn+6E1U8fhm9i5K8L7Pqf6/yd4ZckRrINoOYTxPmWal8B8XA2XZT?=
 =?us-ascii?Q?X5TrrFwl5MIMqIyji4wtT2zRSkDl6P1sGEWd+LFkrm6ALn98YFKbS/bz/PF2?=
 =?us-ascii?Q?9g87Idr8lQVvQmIS1Zv4J8l9yUFyC66h3VIj/kj0uJ+tyOPh2JFd2F/uluLX?=
 =?us-ascii?Q?7dseJPOCeV+nPGG+1oZDDSjeceFMDbMY7u6H3GO6mdWxKetCoV9irIpSNFzE?=
 =?us-ascii?Q?rh368Pz9JRYx40tVV/Vpa6B4AwTCzQqsTu+BkfEDr7nev2QcHLvH9RPGKrNc?=
 =?us-ascii?Q?XvlHzQX4Fv8rfFN4/h6QGDbb6zW2pWvwjiLICPqMmdgRw079PPefpxkc+OwQ?=
 =?us-ascii?Q?bqRQCDCrMIjSdSVaUQQxnTIUEUuPiL+fbARKN1Tsa92dMSUn7DBvFOtqr6b2?=
 =?us-ascii?Q?S8Kb3TIasFVJCLb/0SdsNOweb/sREsw2CgZTBidV5R8MTzF8O2flsv01Pyf+?=
 =?us-ascii?Q?6v2xkCNh500IMTdl6wZm8ZEt5m0i/iJoNsJcvZOO6nkPcvJSW5DwUdT/hvA6?=
 =?us-ascii?Q?dvurhiQKnO+6PfjwokZVp9TSQkJ96yR74smBILmZxQ9RWBnLmNGOzO4hbDTj?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca3512-33ca-4b32-a94b-08dcfdbfd8f9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 17:32:40.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHjAmmFr1fT2OP/FBhIFja5xDtl+2bhowH1d/4Bhut+U1umiD1juMqgrC3c9CiDWVW0vou5Q8LyNHnPAM1hJxLMw8qzUneLiitAoGaZ8oBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
>On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
>> On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
>> > The GGTT looks to be stored inside stolen memory on igpu which is not
>> > treated as normal RAM.  The core kernel skips this memory range when
>> > creating the hibernation image, therefore when coming back from
>>
>> can you add the log for e820 mapping to confirm?
>>
>> > hibernation the GGTT programming is lost. This seems to cause issues
>> > with broken resume where GuC FW fails to load:
>> >
>> > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
>> > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> > [drm] *ERROR* GT0: firmware signature verification failed
>> > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
>>
>> it seems the message above is cut short. Just above these lines don't
>> you have a log with __xe_guc_upload? Which means: we actually upload the
>> firmware again to stolen and it doesn't matter that we lost it when
>> hibernating.
>>
>
>The image is always uploaded. The upload logic uses a GGTT address to
>find firmware image in SRAM...
>
>See snippet from uc_fw_xfer:
>
>821         /* Set the source address for the uCode */
>822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
>823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
>824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
>825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
>
>If the GGTT mappings are in stolen and not restored we will not be
>uploading the correct data for the image.
>
>See the gitlab issue, this has been confirmed to fix a real problem from
>a customer.

I don't doubt it fixes it, but the justification here is not making much
sense.  AFAICS it doesn't really correspond to what the patch is doing.

>
>Matt
>
>> It'd be good to know the size of the rsa key in the failing scenarios.
>>
>> Also it seems this is also reproduced in DG2 and I wonder if it's the
>> same issue or something different:
>>
>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
>> 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
>> 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> 	[drm] *ERROR* GT0: firmware signature verification failed
>>
>> Cc Ulisses.
>>
>> >
>> > Current GGTT users are kernel internal and tracked as pinned, so it
>> > should be possible to hook into the existing save/restore logic that we
>> > use for dgpu, where the actual evict is skipped but on restore we
>> > importantly restore the GGTT programming.  This has been confirmed to
>> > fix hibernation on at least ADL and MTL, though likely all igpu
>> > platforms are affected.
>> >
>> > This also means we have a hole in our testing, where the existing s4
>> > tests only really test the driver hooks, and don't go as far as actually
>> > rebooting and restoring from the hibernation image and in turn powering
>> > down RAM (and therefore losing the contents of stolen).
>>
>> yeah, the problem is that enabling it to go through the entire sequence
>> we reproduce all kind of issues in other parts of the kernel and userspace
>> env leading to flaky tests that are usually red in CI. The most annoying
>> one is the network not coming back so we mark the test as failure
>> (actually abort. since we stop running everything).
>>
>>
>> >
>> > v2 (Brost)
>> > - Remove extra newline and drop unnecessary parentheses.
>> >
>> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
>> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> > Cc: Matthew Brost <matthew.brost@intel.com>
>> > Cc: <stable@vger.kernel.org> # v6.8+
>> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> > ---
>> > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
>> > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>> > 2 files changed, 16 insertions(+), 27 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> > index 8286cbc23721..549866da5cd1 100644
>> > --- a/drivers/gpu/drm/xe/xe_bo.c
>> > +++ b/drivers/gpu/drm/xe/xe_bo.c
>> > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>> > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
>> > 		return -EINVAL;
>> >
>> > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
>> > +	if (WARN_ON(xe_bo_is_vram(bo)))
>> > +		return -EINVAL;
>> > +
>> > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>> > 		return -EINVAL;
>> >
>> > 	if (!mem_type_is_vram(place->mem_type))
>> > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>> >
>> > int xe_bo_pin(struct xe_bo *bo)
>> > {
>> > +	struct ttm_place *place = &bo->placements[0];
>> > 	struct xe_device *xe = xe_bo_device(bo);
>> > 	int err;
>> >
>> > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
>> > 	 */
>> > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>> > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>> > -		struct ttm_place *place = &(bo->placements[0]);
>> > -
>> > 		if (mem_type_is_vram(place->mem_type)) {
>> > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>> >
>> > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
>> > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>> > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>> > 		}
>> > +	}
>> >
>> > -		if (mem_type_is_vram(place->mem_type) ||
>> > -		    bo->flags & XE_BO_FLAG_GGTT) {
>> > -			spin_lock(&xe->pinned.lock);
>> > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>> > -			spin_unlock(&xe->pinned.lock);
>> > -		}
>> > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {


again... why do you say we are restoring the GGTT itself? this seems
rather to allow pinning and then restoring anything that has
the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.

 From drivers/gpu/drm/xe/xe_uc_fw.c:

xe_uc_fw_init() {
	uc_fw_copy(uc_fw, fw->data, fw->size,
		   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT |
		   XE_BO_FLAG_GGTT_INVALIDATE) {

		obj = xe_managed_bo_create_from_data(xe, tile, data, size, flags);
		uc_fw->bo = obj;
	}
}

So what you are doing here is to
	a) copy each of those BOs to temporary system memory;
	b) restore them on resume;
	c) map it again on the ggtt.

Is this correct and intended? Looking at XE_BO_FLAG_GGTT there will be
several things we are going to store to disk and afaics it will be duplicated
on igpu. From the commit message I was not expecting this.

Lucas De Marchi

>>
>> should this test for devmem so we restore everything rather than just
>> ggtt?
>>
>> Lucas De Marchi
>>
>> > +		spin_lock(&xe->pinned.lock);
>> > +		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>> > +		spin_unlock(&xe->pinned.lock);
>> > 	}
>> >
>> > 	ttm_bo_pin(&bo->ttm);
>> > @@ -1867,24 +1868,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>> >
>> > void xe_bo_unpin(struct xe_bo *bo)
>> > {
>> > +	struct ttm_place *place = &bo->placements[0];
>> > 	struct xe_device *xe = xe_bo_device(bo);
>> >
>> > 	xe_assert(xe, !bo->ttm.base.import_attach);
>> > 	xe_assert(xe, xe_bo_is_pinned(bo));
>> >
>> > -	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>> > -	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>> > -		struct ttm_place *place = &(bo->placements[0]);
>> > -
>> > -		if (mem_type_is_vram(place->mem_type) ||
>> > -		    bo->flags & XE_BO_FLAG_GGTT) {
>> > -			spin_lock(&xe->pinned.lock);
>> > -			xe_assert(xe, !list_empty(&bo->pinned_link));
>> > -			list_del_init(&bo->pinned_link);
>> > -			spin_unlock(&xe->pinned.lock);
>> > -		}
>> > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
>> > +		spin_lock(&xe->pinned.lock);
>> > +		xe_assert(xe, !list_empty(&bo->pinned_link));
>> > +		list_del_init(&bo->pinned_link);
>> > +		spin_unlock(&xe->pinned.lock);
>> > 	}
>> > -
>> > 	ttm_bo_unpin(&bo->ttm);
>> > }
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
>> > index 32043e1e5a86..b01bc20eb90b 100644
>> > --- a/drivers/gpu/drm/xe/xe_bo_evict.c
>> > +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
>> > @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
>> > 	u8 id;
>> > 	int ret;
>> >
>> > -	if (!IS_DGFX(xe))
>> > -		return 0;
>> > -
>> > 	/* User memory */
>> > 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
>> > 		struct ttm_resource_manager *man =
>> > @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
>> > 	struct xe_bo *bo;
>> > 	int ret;
>> >
>> > -	if (!IS_DGFX(xe))
>> > -		return 0;
>> > -
>> > 	spin_lock(&xe->pinned.lock);
>> > 	for (;;) {
>> > 		bo = list_first_entry_or_null(&xe->pinned.evicted,
>> > --
>> > 2.47.0
>> >

