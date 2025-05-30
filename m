Return-Path: <stable+bounces-148162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4938AC8DB2
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D291C025C6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A322CBFA;
	Fri, 30 May 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ST+nda5r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA121CC55;
	Fri, 30 May 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608107; cv=fail; b=cG4i+jepUVnkbqYX1IdktrKtGdx8WjEB6K2eoCXWxlqL38FOLwLhiNJ+RM2LUkQAd9CTkGiJNbuzftZsXKSoSe/HJniycNsImvKknYU44v76jwm92dvAolWC7FvNFKElunHO2+yi7eB7iCNynOb1D7mgMYk6o0Rbg5/goMeMZdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608107; c=relaxed/simple;
	bh=MIXcAcH1j16OdHpBWSfd8Al1S2sFG9xcEzxnWG1x/N0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sCByw/h+oQFbN0apHq7vMhb2+gpsAuvBTuBqzAL7tLe15c3CzX7kdGeW62e/ryh+XsJOJQt1bjp+WqGnpzGoHMd+lbAp+EgD51o0oA4oKTyKlxQ80ekyZbk3Azwl2qO3q4o/8agrNwXAnbOs8yDGXJFS4hzjhqxs9br1LFAW1zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ST+nda5r; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748608106; x=1780144106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MIXcAcH1j16OdHpBWSfd8Al1S2sFG9xcEzxnWG1x/N0=;
  b=ST+nda5r0bZBlIhiL39rBqW+v1PEs4kraQQlwHDrj6watZcCd3C8wW6g
   fVjkpL3WpUfSSUKTCkeZhxy7lWhBBz9lQ6mvar6HkcvDFI6EV2twuAZya
   X7j4VdeZA9+tQ+gjtel85lT+Fy6p9ZOeyBaH0WaT86yCmRzxtkgpETFAj
   qa3SoaJdMTtyY7KzKv6R4KVOyrpBeJn9/1zFoX4R16G7xh+olv5lS50bN
   CkMnbqU6S6LXOxIfB1LLdcy3JoSb/AM7n5fSp+49iCP4xGsFeHVHG29sw
   a2+DopMAjEkUT8BHj166NZFcz9Aub24dLI5g2cSwTi2bMHMwoQcLVp1mo
   A==;
X-CSE-ConnectionGUID: Iz/JHPMCTM6zlE4kRqUD/w==
X-CSE-MsgGUID: arNCqhNlSl6rmtJALcFZWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50849174"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50849174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 05:28:25 -0700
X-CSE-ConnectionGUID: kBERC6noT3mEW28R03Gf6g==
X-CSE-MsgGUID: LGxb0lkzSsygeUwKbornAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="144845326"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 05:28:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 05:28:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 05:28:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.89)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 05:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrM5vzIMDB5MB+pXhFhVVSGRdj8/MXHNHhGd8S3RQ+uNdq7qHgirbAJAbEUPRKwQ0mLlZC/ojgrj8k+UQX1QblZF7NIWHpGP3aVllO2bnM3sMnRTsZegh1TE613p722/gjtBgW3tBvxgfFtT0LDFIV2hB8ZTiP2bitLxsqN+wzQETLBgeWh6zUuC3DdSDkmKUsUG4XZor31tnjEfIjFOMsDuiunaLKapMHR2qUQcaZsSB3IvtAxfsERBcN5Mn4Bp4Hl4w+hdBX1h90tMSJL2lPfCd2ouPLRNFTb3lcF3Gn7lCKm83yzadxuN5f2xJh4nomA66tEymBmEsbtLGS82SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWCpvCKIYwGrcumQH2MQxeDqZhqD0lryv06oLPatcGI=;
 b=KpFh4bd5lmY0tF7mTUW/sSvZiY2Ydr7QK/VfEB9bbypd7ioiAaCO946Xzqr9In7z9kPAhu619f3rSLk3Lv83Cjx/HRZAzJllcG+RnUxbdhp80yKEUwWhy9n7bglXpywkhrlLRpXnaeijtgYaq47bdYijt0iRgj2fkDH5are+fYaVwdgYFaZ2OU7p9Mfl7vV5dI9btqAE1vHUk1yBhvAEQwblxhDhVc3PZC44+yaEn3VIkSahHLp3iG8jQJnP4BNatMQ3JdB/iCLo2hxcTwD5UG7QeWKJsP4Omq6gr2QTZpvrbk0J02FvS9ZUMKu8KA0XBURGozER7kKA9qCh/SFvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 12:28:16 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 12:28:16 +0000
Message-ID: <cdc100af-cca9-4a70-86ce-a2bf673e5263@intel.com>
Date: Fri, 30 May 2025 15:28:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-omap: Add error handling for
 sdhci_runtime_suspend_host()
To: Wentao Liang <vulab@iscas.ac.cn>, <vigneshr@ti.com>,
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250521083846.718-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250521083846.718-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0321.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::20) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0c920a-f72f-400c-97af-08dd9f7573f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3JLTFhFbU9VZ0tOb2UyajhrMmk4SXYwZzMxWFN4K2gvLzVLcjhZbDBGQ1lJ?=
 =?utf-8?B?SnN2djdOMDRiQzhsYXJMZGJ5RmZ0RUUrM0wwMThIdkdseDJQMElpV2ZzaEVL?=
 =?utf-8?B?Y2JzaDdxSHZuTUVBY3JsSDF1WG5ac04wOVY4WFdjMks2WGFqNmFrdFpDZkJR?=
 =?utf-8?B?dW96Ti9HN1lPbWJ4OGhWc0x2RHlmeTE3dTN2d3J2OUMydnNaZnFkSWwwTWxh?=
 =?utf-8?B?aE1iQ1Q4VzgvTE9aWDVyRDdMa0ZqL2VXYmhHbGx4UnAwVFJWR1N0MzZJSGZa?=
 =?utf-8?B?Rmw4L1BuenF1SkNCV1JYbFlBWlJrbVU0N3R1T0JJTkNMbzExSElQeTZpWHU1?=
 =?utf-8?B?bXNrYTVvQ1JBbU9PRXJLQnIyNlhTVXVrbXY4cFVxUWQzYVM2elJjbjY1d0pz?=
 =?utf-8?B?WXpiVWRLcFJsSDQ0WmpabHV2bVErUmxWc2V2SVdZUEhYUi9ablNTQ2R5WXRj?=
 =?utf-8?B?T0YrK0hnZDJhTzVYVzlQY2N2c3p2R0U2WUdSanZjYklPSDFoRVJKYmlUYkhE?=
 =?utf-8?B?Y3JWZlk2cTdYWFBMZVNhcEc4ZGYvQzJOZ2cybGRrWGZhbGtQMlVlTlMxdzNa?=
 =?utf-8?B?dzdNdXEvaEpGcHh4L1pQNnVRZ0g2TWtXMTJPb0F2Ulg2TFMxVW9xOTNnSEhi?=
 =?utf-8?B?TVJPK3BPUkVMYTRFcCt5R1hkNWNIUzM3ZkhiVUQ1YTZnWGNsV3ZHY3ZQNGJ1?=
 =?utf-8?B?Wk1mNkxqNWRTOGpGdllTakNsY2I4S0lqMkRqTCtIanRISjNhL3gvUXZYQlBZ?=
 =?utf-8?B?Z2NvL0x0ZDFNL0g1Y3NXS0FTSWdlSnZVNTBCaGRrcC9JWlB5MmFLejhkZCtq?=
 =?utf-8?B?SHUvS25YOXJhMHVLb2ZNa2JPOTdvd1RrUGdVaXJTQTQ2TGRGeC9xcmtLQ05N?=
 =?utf-8?B?RG9waUIyb2dRMWxvWHRRTlk3YnNjS2l1eHVncElDd1FuT0xGNjIzQTRTNWxl?=
 =?utf-8?B?cVI3YmJiMHI4RTZHTzdKTG9sSU5FU0EwV2E0VFZQVDRWWGtzQzNscFJrbG5z?=
 =?utf-8?B?SjRzZy94M2ZWaTNpdno5dTdxSXBZek9wU3FtZlZVSE0wRUhzY2xkYTBCUkdB?=
 =?utf-8?B?YUZPMVdsNU83U2hiNUVkcWh0OU96elRXUVpiZVpVd25JRHg2Qkh5bGN0c2M4?=
 =?utf-8?B?ZkhhMUdoUWRNRkJqS2V5aGtkb1FBTk55MFdVRm13ZGxyaWpsNEpMdG9meXhq?=
 =?utf-8?B?N0l5NGdhalZZU2YxWHVQTHEvY1U1ZEEwTkphaExCSnBReU1paUMvd1R6TitE?=
 =?utf-8?B?RmM0NEcrUko4WCtRMnNSWk9VTmZHbnlHbFBzVFVjNHdPOHM5ZTVoMUdubnQ2?=
 =?utf-8?B?dVEwTUF2Y2NhQnlPdStKTWlqYjc0S1pZWnFSdGthNnlZbnh6V0xOeWNwVmpo?=
 =?utf-8?B?MC9UeW9RcVQ4Y3Q2a0Y2M2dBaThoZUlOQ3FzanJWZWo0SG0rN3JRUU1aTnhV?=
 =?utf-8?B?RFIvbG0yUWY5SmpYZXczR3FzVTdpYXFpWjgralp0eWtkUVpSZ3BPM0s0djJz?=
 =?utf-8?B?YVJOdXl6SjVwK05rRUZENFRiaThFanZGTmhOR3JERngzbklmYytwNEZPOTZU?=
 =?utf-8?B?bDViZ0lrM1AzRnFteXJ1YWV4WjQrbFYwcEhJL2EvWFROaHhFN3ROa2ZEU3hs?=
 =?utf-8?B?ZlpINjJGNnAwR2IrMEU5dnRneEV5VnZJYlo3RTJGRTBtcU1meU9nMFg4WkZz?=
 =?utf-8?B?alg5d2VUTStYYksxMmM0UzN2dUlvWCtUbmlVcFU3bGI4N3AxOFNqSDNhclNk?=
 =?utf-8?B?SU5qQXlwUmxsYzUyMHV3UlpMa1UzeTl4bkliWld4aXhjVWdrUnVtZzlFYitS?=
 =?utf-8?B?ZUNpKzBiK2c1UWd4VzN1NkRKTVVpMXA1c3RmVUJiNk5yZDNFU0R3M0YrQWZ4?=
 =?utf-8?Q?VkzLU5g+Iek93?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJkbGgvcnlJYU1ISHBMK3F6YlFqKzRPT0E1QmxoZEcwYTIrRHBUdGR3VkdM?=
 =?utf-8?B?ZFBiS1hKRHgzWVU1S0lLU0l5OEg4bE52REZOdXRIZ0srVThhbjZUOTY3OXlw?=
 =?utf-8?B?Snd5RDA4US9rSkkxZ1h5ZmJiWW4rekhSU0JDc2lra09GR291cEJxZHdSdEYy?=
 =?utf-8?B?WU1Xa2Z2eWFibjNrdkIxV0oxZ1Nyalhzc25OR3ZaRU5hMWk4U3YxazYzeERv?=
 =?utf-8?B?aDNUelU2WGMzak03YnE1RHhGamtBT3VxcDFGbU11TDdMeTdwL2RlM1NjVGkz?=
 =?utf-8?B?amFpMCtrUUNwWU45YlM0UE5SbXBZUDh4N01uTUtaU2tvOC90N1dmTHF0UTBZ?=
 =?utf-8?B?WnZCREJ3RFpISWpKcllJRnROTUFsUkNBS3JWQ0dhcUpNK2oybXExT0g3N3dI?=
 =?utf-8?B?ZkRlT0R1Q1RGU0tNNjNNeFR2RjVzUXFWdW1jRzJ4V1Zqd09ab0RYQmxrOUV4?=
 =?utf-8?B?VEYwdUVtSEpyai8zY3VhcytRaTA3UkJYT0YrZkdQem1tb3RUZDFIbzNtL0Fx?=
 =?utf-8?B?aVBxQkREb1dLOWtPbmNvMWtibVE3b1JyclBSdXlsajlGcDgxWEVobXNTWno3?=
 =?utf-8?B?Tm9HWktlcnBVcnMvR2M4RHNTajZQbS9PTHI3UHN3ZDc0b05vUWNNYnBtTnEx?=
 =?utf-8?B?MW5vRk9hYllEUDBUR1ZNMlRLZU9jM3I2cGNNeE9yaWVnSi9nL1UvODZscTRU?=
 =?utf-8?B?MzhGck9penF0OVY5TGxnVlk3ZUZ0NStaQVk1OERtVk5DdGFiK0tyWC9oVjgz?=
 =?utf-8?B?aWZXTFhteGVZVEVtV1U1MnRtNGo5blRUeUs0TkpQRXVHaXBCQzJOY2FVQmRX?=
 =?utf-8?B?MERJTEo3NC9XaFk0UzRSc3JLSk5NL3RTUldyMVRCdXhqR1k1VFlTbzN2dUNz?=
 =?utf-8?B?SVlmTWFFbmlrTjVxTi9pWC92NVlXY2ZoYm5nRWViVGN1MzE0R0w4T3UxR2Ry?=
 =?utf-8?B?VlFvaGRWUHI3OUVjbjRtRC9wU1RCeWtNL3V3NTd0cUorVExCWnFpYUtVSGxV?=
 =?utf-8?B?Um44d3E2MDlsdmdId1E5bk44U0lhSTVWb3ZoelFMbmh5RGIyMFd3S3lISlc2?=
 =?utf-8?B?SzNrNlVlZnZRQk5uWE1BbzBiKzFGMmtrb3lObjFzTm4xeDBBdDN0Z0RzQUVv?=
 =?utf-8?B?TnpVbHZLUXgxanMxdzMzMVEvZ3lQN0JrV0UvWmxUUjJEQWR2bG56RUxZVWNU?=
 =?utf-8?B?L3lKWm9WYy9BdWROd3ZvaEh4THB6bWE3TDAvQUNXNERwUUhBZ0ZBRG81RndN?=
 =?utf-8?B?ckRYcGoydHJ3NUNJdlpYVk8wN0ZudGE5eWlQZ2o3dVZPM3dvL0kyTGpqWkJL?=
 =?utf-8?B?cllSemhrN2tyeGNmRlR4MUJOeStFbWVPNDZUMWxtTlJ0ZlNhSjZwQ1VabjFn?=
 =?utf-8?B?M28ydURDd3NCUktySlBEQXVmS2lnSER5NytVY0dlM3JRUWdvYjFpYzA4YW1X?=
 =?utf-8?B?elJFbGtVU2FSc1JlWDh6dzFac3dNSFV4U2dsSkVneGlIMUN1Q2FRVWM5U3Ri?=
 =?utf-8?B?NWZHSXBzQkF3eEE0dmZFc2NTR2hEbldrUUdVdkVNL1VuVFdhNVlWM0xoRUJI?=
 =?utf-8?B?TFpFL0RybmRMOEdwL3B3RERNdDdtbkdDNWR6cExseW1BZ1ZUWTVqRlIrWnFm?=
 =?utf-8?B?Ylh0K1U2bWFoZW1jWWhWTDBqZ1JBZ0tzQVBEK21VWEk0bVlYNDZNTXQvRUw1?=
 =?utf-8?B?UjFJNDU4d1lOTnY5Wmc4U2Z4MHFFdjNWOFdtT2tyQ1FVQUdUeDJRQ29rTVNW?=
 =?utf-8?B?NVdHTHBjbXZ0ZzdPWTJyRnVxZVUyWUpvb09VdjM5OFJvSFNuNEZnRW5RQUxJ?=
 =?utf-8?B?SWU2b0htUlUzYit6UWZnclV0akcvemhXYjdjSmx3VzQwOTZRcjBqNkdRN05v?=
 =?utf-8?B?UlFxYUdjblN1ZFJHdlNyMm8xNG1heXJNVjB6eDRmM2M1dlY2dU1aWTgrbENO?=
 =?utf-8?B?RWsyNUt4MkUwN2pVaUtOOVZscC9iRkpuWi9aSjg3bStGck9NTFdPMzRCRW5B?=
 =?utf-8?B?V3NERkswdEllb1V2R0lTUjkrVFdROG1Jd2VQeld4bFF4Ty9wVmVrZjgzSWtr?=
 =?utf-8?B?bmF3eGVVTUZ1NkVJUVU3WVR6RmhMejZIY3ZkZS9qR1MrUmVyZFBHQ29Xa3ov?=
 =?utf-8?B?QTBxZ3E5TEtCd1lRdmFWRHZ1KzZJVmZmT1dzSEM1Zy9XSitBd0FjVCtRVk9j?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0c920a-f72f-400c-97af-08dd9f7573f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 12:28:16.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp6qLpJlIlqNIExEq5tZDnbcPLwIhaZLHxKPDaNbKUVGVzBGQ9R8gPPYA1yjrR6LtNIq2hNPAGFby1DTbgWuEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com

On 21/05/2025 11:38, Wentao Liang wrote:
> The sdhci_omap_runtime_suspend() calls sdhci_runtime_suspend_host() but
> does not handle the return value. A proper implementation can be found
> in sdhci_am654_runtime_suspend().
> 
> Add error handling for sdhci_runtime_suspend_host(). Return the error
> code if the suspend fails.

I think it's better to remove the return value instead:

	https://lore.kernel.org/linux-mmc/20250530122018.37250-1-adrian.hunter@intel.com/T/#u

> 
> Fixes: 51189eb9ddc8 ("mmc: sdhci-omap: Fix a lockdep warning for PM runtime init")
> Cc: stable@vger.kernel.org # 5.19
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Fix code error.
> 
>  drivers/mmc/host/sdhci-omap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 54d795205fb4..f09f78cf244d 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1438,12 +1438,16 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>  
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	if (omap_host->con != -EINVAL)
> -		sdhci_runtime_suspend_host(host);
> +	if (omap_host->con != -EINVAL) {
> +		ret = sdhci_runtime_suspend_host(host);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	sdhci_omap_context_save(omap_host);
>  


