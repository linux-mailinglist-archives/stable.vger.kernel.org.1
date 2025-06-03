Return-Path: <stable+bounces-150665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F43ACC26D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1341171F1C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E228137A;
	Tue,  3 Jun 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3lPyZFd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5428136C;
	Tue,  3 Jun 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940589; cv=fail; b=S/cy9B26CcIyLXua/9UQ9xB4b11oqOch60oHc8eox8BCcw7ENNqmASBOGquQ+WUQIbaZTJhb2YZGqvI6cMvJ/FVE/PM+kjHxs4nNtNAZY0P0tzegRQ6n5RQtX43xYu8ahBjEgd0UAQ0opDj2Hq+8MDKqdb4Uu0LI5I8F9gQLqVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940589; c=relaxed/simple;
	bh=8yQ2xEyLXJ9axipR94sbxTX+1k17kYQviTgQ6i4hoU8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdrt+V/Jb/t8dq8f03sJXdPPLQeBriKGg0nmpWc66qWQb4Y5U41l6vm2hocWBtMA94c9xKj8Y8B1gKNLBclvIMDWMwhgSn/rIM1pwpSju7msXRFWqJaui2qRACDfVxzYTe4qPSsfBva/zu7ediqrfOaLE9Q5vWQl+436vHrQ3wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3lPyZFd; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748940586; x=1780476586;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8yQ2xEyLXJ9axipR94sbxTX+1k17kYQviTgQ6i4hoU8=;
  b=A3lPyZFdYvF3rHGBSzOsD8En1PBYZbjfWYA30KxLJIZaCXNJQK6KkFPr
   ghEasxwnA/nteca8ds4XLFqX/uc8nW3TUcDr3sb/JH6GzKgWLKUfy242a
   2H+NSZx7wgbwjhEc06WQxmPPbVEXJwW3Fy6mERRePpDtKnu2pKK3q/P0v
   YsgQlZxE+Wd4iiptF4ZTvZcz1oDyj5gikKJHN7OT9El0OaE+5r0CxXP1n
   81MwO0JTMhvYNWovqcJLCJLhDd1bmEqEd2qma5JIjLUJkj0uu46FaQGe3
   1U75hxlSI+vU0p3j1fyMSpkrczgqK2prHShYdFcvikUS2JaEEjnZhV1P/
   Q==;
X-CSE-ConnectionGUID: wC2I1gS7ScK8h5tsgGpCxQ==
X-CSE-MsgGUID: Ouc00iRwRXCy0ktpz8X0fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50887828"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50887828"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:49:45 -0700
X-CSE-ConnectionGUID: fh/GDzceSuuTRQY9nVk7zw==
X-CSE-MsgGUID: XStTYvXuSwikZGJ4vdeq6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="149953612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:49:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 01:49:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 01:49:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.66) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 01:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcM/byRa1AKQ41XKhZNgihC/kkA9A9b2czDOj5dGn8+MjlQHUCoPvCjew5gLIakSgB2wdvGFldbPX1oKqbSmkBwxcM7XcPmOcggDYPZZMcyyGukqtzWzeHt2hUPsbcRGQSWem66mA/Gj1tqfA0tpUqE2vQ9HGt2uBgirtLx5ViHTLdVIbU30Q1uFCpMs8T6dpyQgFBszxXAf9KOd/QuAnlQT6pHXSew6dXpAoibg5lWNPw0sUUlLMSHyxCq/KpQu10NK0letNwx+/mtvPSeyc2VCtiS5dxiLzKtNJkkdFIe4+JYAxblv+vsoyrJk/z51W73+T0OKwp9Yr4454Jqjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtQXrtx4UDDM3utZ09OD3o6RqMvj2wVW6x1lYscWqCs=;
 b=GdLz6VWpp4RMvSMnF+bHKXz8M/UgnRkAys4Fxvk/GNB6K5aMBnDcwTDsoks5HYJ4v2bqrkFlPEZ6C3HhtRHkL7m8b/DbYk4A6Nr8RA7WIJtEJSgzWjpt3mGXz1x21y4agG88tL6F7XZT4qWq4zTcUY28QnxIl9ZRlhT0YXPf+3ZXxunVnhG/o934E1MkEs89PBGW/Pizvp2vqLEgakAMmDQ7IY3EVATHYG0LikStR+UEWqufBgS9FAkV53PsnjDNj/9APmV6NJxGB2N0S7LCkxGSM+05jh9J4810V3Qz+QtnM1BEiU6gvLXgRphzuDVpEHUiPq0BxcPJu86UDJcQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 08:49:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 08:49:42 +0000
Date: Tue, 3 Jun 2025 16:49:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Staudt <max@enpas.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Johan Hovold
	<johan@kernel.org>, Max Staudt <max@enpas.org>, <stable@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] tty: Fix race against tty_open() in
 tty_register_device_attr()
Message-ID: <202506031638.a5c78088-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528132816.11433-2-max@enpas.org>
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc07f26-f95b-4a2f-ad50-08dda27b94ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWdB97SkIJlsq0YlYUxFeP/2r78VhrxQi4P4/ou+5RzOFzIyB8iCbztrrqru?=
 =?us-ascii?Q?NrSNAngdMSM2Ecnyh6d602SbI35AQg+ofsJaJkXpEWUmGmEs0ok8Iui5bcYN?=
 =?us-ascii?Q?DRXPVfrbCVpj+UMK8zPWUszKM6PdXB5kBM7nzQet0zmhUHzfgKudYWtS9IUn?=
 =?us-ascii?Q?eKPLAXXFoECh6+yXIQHOg0n7GFcih89F+iFaobie7QZzzxNpgyNrnqEsCa3I?=
 =?us-ascii?Q?MuI2blIP+6LR+lamKsDqlYM0IvOx4xDNY2LmCAWba9Nc9EwPg4gFoi+SoNgN?=
 =?us-ascii?Q?dV5OR0vvKw/d5KYCEDUvcRnTbI0wgOFvkuSdg6wc28esipnLocRQ230E8oZo?=
 =?us-ascii?Q?eEfBSysG9elvYDzzni3JV+BbzzvALEQL/qMzJOz2loCHW+3/cWeaNUVjqpB6?=
 =?us-ascii?Q?OOCVkR7Ie2Z8ny9Dooe/0/333sf+x3IVDHp0ppI2nBEGk+mg4KpR43sP/KFH?=
 =?us-ascii?Q?0e4tyP8JH+PwHJq7iOP89QHUL3QfJ7btttwtecXv1bkkiu1PziQ8zhDpwbae?=
 =?us-ascii?Q?uF8JdAsVPD72HjcnrImGXQXWzgN0Y7cbma9bDHBL1op/yvl4zsU7fl5CbT8C?=
 =?us-ascii?Q?u/nO9pVOjBBV2GIGGUpmEssalyL3wyIJq6fWnsUeWcmIj3Lv8iXJyCBN58BL?=
 =?us-ascii?Q?9FSsmy5vNRV/WYvMq1gFpsFZDWcsXIOXP+2ljdPEQuEF4KRNvyWbkM9mHCiZ?=
 =?us-ascii?Q?clvQJwUd7t68EWTgpo1XUStakUL/VjfuknFvgP9ackpvv29iGmzuD7Uj54LG?=
 =?us-ascii?Q?tQAW5zWAzl32DuXumYsAUbRhtrLFxI4lUm+c02b58gsAinhYujBcA80EeB3m?=
 =?us-ascii?Q?y/Tgf3fYZUsi3ZPCqYDr/mzeMXn2Cn3xbtn++qj2tJkxCWjjXSh9zbZ6r6IF?=
 =?us-ascii?Q?Y+9DXSdYfzFkfcBNkeRmKKN3PWJu8SRtqxgK+HNJVgn7SYUXCAXR0ILqGqo8?=
 =?us-ascii?Q?6PkLqg6iqROH5fjod6yKD/A0y37wrbWQQJDKgTMWyFHuKXETWx9a+qDCskAL?=
 =?us-ascii?Q?d8kGh2pEq0BeuPQOvlqSgUENiBCmp+SvTYzkqINRXHkCVDuQpwPXUNjGFajn?=
 =?us-ascii?Q?l7jiMzObncoI3PHQiEqnxg5EM1Lo0uaz3zs8E2zTFsvl6afoHih5AvoOncrT?=
 =?us-ascii?Q?FIvjhd/+tNa93vR6TB6eccmvmRtJqjuQo6I+qEsp89xba/kIlevDy2Ho2W+L?=
 =?us-ascii?Q?epiDarD4HbYtWEUF3mnS2+2j+9T9NuguxYtH99ovxD+6xcDtJasG9wu7pg1P?=
 =?us-ascii?Q?i5T7d5aBCP/pyFX1aThkrNeH/zDnu+WCB1Ia0LmwPJiyAvgxkifUALvqwCJJ?=
 =?us-ascii?Q?l32/2FKplBNQAOuWxJhcn2WlY29Q/opBE80YJzsChkfGn8N96BaOCtbwa1HJ?=
 =?us-ascii?Q?xqrBoWzWvLrikpE62AqJ9dqqG5Ve?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dh4yz0xbfuCt/4nM8VYFQmRH/wfz3djBqmfLMNUXxMorwH0rBTWCs0aPMs+u?=
 =?us-ascii?Q?1ag1KiAzs0zMb+D/Gz31eZ+WqtPOi1GODgjJzfLnPzNwodop2R79XVrOBLme?=
 =?us-ascii?Q?dpJ740RxAjR4IZ3qikFPuyjGraAQu6+hwwnkA0kXBVZU3z+Dz8+uOhL4cJuu?=
 =?us-ascii?Q?SJu6mWXwOCVf1kCVuTdvC4D7+HhM9f030bNPxLUoE5vuJEh1FfpoJ1FJSER8?=
 =?us-ascii?Q?k2QrfW1v8dWt/9LA1hZCiv3kGeMWrqg325B179WcTcXuJjFjhrb86YrbUHWV?=
 =?us-ascii?Q?2qvwAirxkn/IZsGz7/ssBOIjflSrKB6O83V71EFtY6lej23xRdR3VDu3anNf?=
 =?us-ascii?Q?vd1IE6uV/cmaADI5RqOpa/o+ABWKtENtcjQL2l8RWYgGJukeeDxt1TfY8aP9?=
 =?us-ascii?Q?u3n4gqiJKG2vnqZcY4xr3K6vBeVAmt/7SSHMLu04q8v13glCAXsxLmwofXZw?=
 =?us-ascii?Q?c2bzvCvgUA3KjhNKdDE9jXhTS9VAniK9lpD9NFBw8LZN+EKKm/Xc8xekbvKK?=
 =?us-ascii?Q?ovTk6km4SRpW51Y0g3BC9UEGVBcQ8v+C0EByPuhhjov/HcgCzRpg8Ev/g4Dp?=
 =?us-ascii?Q?oJblcI8pz22tYju9RXORreTzWb5UBiQvCz1ueShG2cSKw3oAIMKv7SgAP2oS?=
 =?us-ascii?Q?EZacMTi4sy7hrSn+gL7uTYHz5pwAnogOGB/jmTZVHL+ic0arhcAnpfOb6uFG?=
 =?us-ascii?Q?ESUalPSYRR+IZRH49rWV5TeA2PR0j0/RYF7YYTy/oFTUaYMnyRFWfbhXePev?=
 =?us-ascii?Q?2B7CkS1Sa/XREcNFp9haYFE/HopPmfUPfAj8fcCVUHrMO9iEZjwP+dCQJU/u?=
 =?us-ascii?Q?HPgkovBLFjmXC+cIbqVTkOWiQMpWy9aw7b3nYkF0DluHVuRpuWRDeDg0sJVr?=
 =?us-ascii?Q?uL8YzNMMgwUh3MjTTfPb6Rk4GVwWYos1nRUfmwISW2EkdXdxUhHYhili45sZ?=
 =?us-ascii?Q?/wMUPqjEdc92nPicotVD9zv9ArPt5ys8uq2GrhcXOw05Od+sXIQKiDfG91rw?=
 =?us-ascii?Q?UfmJMTbyAPlPFDKEacU5UpewFMsT+GAvGzlLCiRmCfdqCqaXNib97XZ9Aw4H?=
 =?us-ascii?Q?pNy/314ifxlYDVwRyhvBhYc9kW/vgITP8lDu5ve76gpe13uiHbjuqv5Qj6NG?=
 =?us-ascii?Q?pq9aBx3v2NMiDdVgQ/tKX+ycQs8FvZZ+VCrjas9AUOLqbMdVbE2XiQJPGW+T?=
 =?us-ascii?Q?odIvNjD2m3v/CdxAvhaKMa8fIUVfpLev2uDU3b7ohlxfDf1pxsvwDDJr2hlR?=
 =?us-ascii?Q?R+vQKloq8Mz/AOfLme+Y4xew9SmjfmosxLXR/QfO0Q8QZfzCku5QRkM10zOW?=
 =?us-ascii?Q?DC7d34OoLq9bDmPGdfJTIUrJenxRoTCggtCfpLjB9GVTN7sH2WQ5OjEA4NK+?=
 =?us-ascii?Q?T3d/7pSok+8LPaWPNJfbl6UP8q52ymW2Vwh8J8o/2MZXuB/o3X5+HyIr1KzU?=
 =?us-ascii?Q?/3jwTYqNcKFUryO4+kQOASrkIjgJFqdG3roWaiVOlE1EItOgflLDN3wP5JvN?=
 =?us-ascii?Q?wb3PvVDwRqaiCHBax05dMbgLuGcmR/It137SecvJzI+zvhS/tyhwEzWMHNbX?=
 =?us-ascii?Q?6/A8EvgSw7p5lnooyvTZYbyGws4bL+zd7PVjTgMd2QzxK98RYYDYHMgLqIus?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc07f26-f95b-4a2f-ad50-08dda27b94ee
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:49:42.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B28fUghQHRf4Cg1KLnS4a1gvoFYTZsnMyptKhjX4Swj4aM4zWz3DDiW5TAcJJXZlgoJKbBKk7EK1KVNhvidl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: c3184e841ee2a1585b89e4bbd90cacb41063871f ("[PATCH v2 2/2] tty: Fix race against tty_open() in tty_register_device_attr()")
url: https://github.com/intel-lab-lkp/linux/commits/Max-Staudt/tty-Fix-race-against-tty_open-in-tty_register_device_attr/20250528-213024
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
patch link: https://lore.kernel.org/all/20250528132816.11433-2-max@enpas.org/
patch subject: [PATCH v2 2/2] tty: Fix race against tty_open() in tty_register_device_attr()

in testcase: boot

config: x86_64-randconfig-001-20250530
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
|                                                                                                                                                       | 44db64e370 | c3184e841e |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
| WARNING:possible_circular_locking_dependency_detected                                                                                                 | 0          | 6          |
| WARNING:possible_circular_locking_dependency_detected_swapper_is_trying_to_acquire_lock:at:tty_port_open_but_task_is_already_holding_lock:at:tty_lock | 0          | 6          |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506031638.a5c78088-lkp@intel.com


[   22.678060][    T1] WARNING: possible circular locking dependency detected
[   22.678860][    T1] 6.15.0-rc4-00108-gc3184e841ee2 #1 Tainted: G                T
[   22.679596][    T1] ------------------------------------------------------
[   22.680280][    T1] swapper/1 is trying to acquire lock:
[ 22.680750][ T1] ffff888101cf02d0 (&port->mutex){+.+.}-{4:4}, at: tty_port_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_port.c:761) 
[   22.681597][    T1]
[   22.681597][    T1] but task is already holding lock:
[ 22.682232][ T1] ffff8881084f91e0 (&tty->legacy_mutex){+.+.}-{4:4}, at: tty_lock (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_mutex.c:19) 
[   22.683067][    T1]
[   22.683067][    T1] which lock already depends on the new lock.
[   22.683067][    T1]
[   22.683981][    T1]
[   22.683981][    T1] the existing dependency chain (in reverse order) is:
[   22.684732][    T1]
[   22.684732][    T1] -> #2 (&tty->legacy_mutex){+.+.}-{4:4}:
[ 22.685465][ T1] validate_chain (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3909) 
[ 22.685990][ T1] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5235) 
[ 22.688240][ T1] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5823) 
[ 22.688677][ T1] __mutex_lock (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:603 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:746) 
[ 22.689128][ T1] mutex_lock_nested (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:799) 
[ 22.689636][ T1] tty_lock (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_mutex.c:19) 
[ 22.690065][ T1] tty_init_dev (kbuild/obj/consumer/x86_64-randconfig-001-20250530/include/linux/module.h:730) 
[ 22.690553][ T1] tty_init_dev (kbuild/obj/consumer/x86_64-randconfig-001-20250530/include/linux/module.h:730) 
[ 22.691065][ T1] tty_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_io.c:2073 kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_io.c:2120) 
[ 22.691582][ T1] chrdev_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/char_dev.c:414) 
[ 22.692010][ T1] do_dentry_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:956) 
[ 22.692506][ T1] vfs_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1087) 
[ 22.692910][ T1] do_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:3881) 
[ 22.693344][ T1] path_openat (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:4039) 
[ 22.693796][ T1] do_filp_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:4067) 
[ 22.694218][ T1] file_open_name (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1374) 
[ 22.694669][ T1] filp_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1394) 
[ 22.695063][ T1] console_on_rootfs (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1528) 
[ 22.695624][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1578) 
[ 22.696135][ T1] kernel_init (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1459) 
[ 22.696554][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/kernel/process.c:159) 
[ 22.697060][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/entry/entry_64.S:258) 
[   22.697516][    T1]
[   22.697516][    T1] -> #1 (tty_mutex){+.+.}-{4:4}:
[ 22.698166][ T1] validate_chain (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3909) 
[ 22.698652][ T1] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5235) 
[ 22.699158][ T1] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5823) 
[ 22.699577][ T1] __mutex_lock (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:603 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:746) 
[ 22.700113][ T1] mutex_lock_nested (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:799) 
[ 22.700564][ T1] tty_register_device_attr (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_io.c:3250) 
[ 22.701135][ T1] tty_port_register_device_attr_serdev (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_port.c:199) 
[ 22.701722][ T1] serial_core_add_one_port (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/serial_core.c:3184) 
[ 22.702255][ T1] serial_core_register_port (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/serial_core.c:3388) 
[ 22.702868][ T1] serial_ctrl_register_port (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/serial_ctrl.c:42) 
[ 22.703443][ T1] uart_add_one_port (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/serial_port.c:144) 
[ 22.703888][ T1] serial8250_register_8250_port (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/8250/8250_core.c:822) 
[ 22.704473][ T1] serial_pnp_probe (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/8250/8250_pnp.c:480) 
[ 22.704935][ T1] pnp_device_probe (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/pnp/driver.c:113) 
[ 22.705438][ T1] really_probe (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:579 kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:657) 
[ 22.705882][ T1] __driver_probe_device (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:799) 
[ 22.706388][ T1] driver_probe_device (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:829) 
[ 22.706886][ T1] __driver_attach (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:1216 kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:1155) 
[ 22.707345][ T1] bus_for_each_dev (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/bus.c:369) 
[ 22.707854][ T1] driver_attach (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/dd.c:1234) 
[ 22.708343][ T1] bus_add_driver (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/bus.c:678) 
[ 22.708788][ T1] driver_register (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/base/driver.c:249) 
[ 22.709313][ T1] pnp_register_driver (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/pnp/driver.c:281) 
[ 22.709779][ T1] serial8250_pnp_init (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/8250/8250_pnp.c:531) 
[ 22.710314][ T1] serial8250_init (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/8250/8250_platform.c:315) 
[ 22.710850][ T1] do_one_initcall (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1257) 
[ 22.711331][ T1] do_initcalls (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1318 kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1335) 
[ 22.711819][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1569) 
[ 22.712320][ T1] kernel_init (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1459) 
[ 22.712739][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/kernel/process.c:159) 
[ 22.713196][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/entry/entry_64.S:258) 
[   22.713650][    T1]
[   22.713650][    T1] -> #0 (&port->mutex){+.+.}-{4:4}:
[ 22.714356][ T1] check_noncircular (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:2215) 
[ 22.714826][ T1] check_prev_add (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3167) 
[ 22.715274][ T1] validate_chain (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:3909) 
[ 22.715793][ T1] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5235) 
[ 22.716237][ T1] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/lockdep.c:5823) 
[ 22.716741][ T1] __mutex_lock (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:603 kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:746) 
[ 22.717172][ T1] mutex_lock_nested (kbuild/obj/consumer/x86_64-randconfig-001-20250530/kernel/locking/mutex.c:799) 
[ 22.717631][ T1] tty_port_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_port.c:761) 
[ 22.718106][ T1] uart_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/serial/serial_core.c:1974) 
[ 22.718642][ T1] tty_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/drivers/tty/tty_io.c:2140) 
[ 22.719094][ T1] chrdev_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/char_dev.c:414) 
[ 22.719514][ T1] do_dentry_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:956) 
[ 22.719966][ T1] vfs_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1087) 
[ 22.720411][ T1] do_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:3881) 
[ 22.720873][ T1] path_openat (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:4039) 
[ 22.721298][ T1] do_filp_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/namei.c:4067) 
[ 22.721848][ T1] file_open_name (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1374) 
[ 22.722280][ T1] filp_open (kbuild/obj/consumer/x86_64-randconfig-001-20250530/fs/open.c:1394) 
[ 22.722739][ T1] console_on_rootfs (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1528) 
[ 22.723194][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1578) 
[ 22.723695][ T1] kernel_init (kbuild/obj/consumer/x86_64-randconfig-001-20250530/init/main.c:1459) 
[ 22.724200][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/kernel/process.c:159) 
[ 22.724709][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-001-20250530/arch/x86/entry/entry_64.S:258) 
[   22.725164][    T1]
[   22.725164][    T1] other info that might help us debug this:
[   22.725164][    T1]
[   22.726026][    T1] Chain exists of:
[   22.726026][    T1]   &port->mutex --> tty_mutex --> &tty->legacy_mutex
[   22.726026][    T1]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250603/202506031638.a5c78088-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


