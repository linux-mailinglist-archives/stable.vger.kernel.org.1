Return-Path: <stable+bounces-105415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFC9F9069
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 11:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1B168F38
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E01C4614;
	Fri, 20 Dec 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a744nF8Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DE19C56D;
	Fri, 20 Dec 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691304; cv=fail; b=etflBKvIwrEnXdmAgWHnaUNs3vOiu/wysJruJNh1fjHkWYe0QQJahAYNytYOcnp948BSegrOX8zKcKVMYPa3dTaK9srKpcfxsgMjEssMeVlcJcVCoujceXTXHaVC7KpD8OElLZnnbpTuweXJx2Q5bU0U5Q5BfVyL97J7WETnf8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691304; c=relaxed/simple;
	bh=AIMPxJTU89wk5rnak2awuWi8uSe2ToTz2LmDIXtkjjs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh4Orf8J70BF8dd5NNPHAFbRaygzcuuvuGRVbcf7uaSQxHWkuI0hvn57UdrCYzJG8niWld0AzgHYy2b1LX72QVNu8DzTj76lBAerJK+ENXXNdhnM4xeCalE0264Nwcqvx5F43U69BQDtjlA2qGWTRCVJ0ESIHRMoh/XjkhFBWD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a744nF8Z; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734691302; x=1766227302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AIMPxJTU89wk5rnak2awuWi8uSe2ToTz2LmDIXtkjjs=;
  b=a744nF8ZlKtWP5T3uhICZwqe0T7OzVSoPH4TfzfOcPjLLbe4L0xrkomw
   dQIRwvkl+d+MV9H9psa4A/1qYdTJAVyNNSAs25vOU00r/M9rJM0lzYSgL
   LL4yzBMS48PsI4eKH+FhI526SiRm/FLdN2lvpN/2YCwoFirQDuD/7TJav
   ciAFsIIDW8FtHu8vp2JI4FwBTKEehK8cGg3j99vxhvcrPiZ3leBCK2/yK
   4Nb6mGoR/CaflVrRt7p0N75mI2uwB0y+XLQzciPwvrwrGS1T40ugRULqn
   jhLz27QAzYuyFhDOB/jyWJhWZ6z54jIhaW/gX32tJEorchO3KHnr5JpU7
   Q==;
X-CSE-ConnectionGUID: bDiac97UR1CHkUO+W7BMjg==
X-CSE-MsgGUID: KL5E6wF0Tc28XwTjS6czVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="52761709"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="52761709"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 02:41:41 -0800
X-CSE-ConnectionGUID: RrB/VK+IRWq29ajxKz3lKQ==
X-CSE-MsgGUID: 3oJDRXt6Q36s9wOuU2q1+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="98268254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 02:41:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 02:41:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 02:41:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 02:41:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bfcb/q2Xti1bqqVJINAS2sX3xMiMNkt5PoJh7YEw+41xueP/TdZ3r3wtr8bvBtrO7BwknJShaBv10gekF04onNwwRk5v0i3MhzcdSNGgOeVtg2lRcfjIHePOdKQSVV+rsypV+dfhjV3FzZXKOgfahDQDJYmpLkZ4MBIZXRbB0fjpmrtdo9dlwyKmJ3/ZCNrc1wYuefZthulOLRUUobzDSuNYMnU+UGb9u2nRNtQkcDKgTdY+ZeRVAZRb0OlpaBUuF+KPpp0FJdzJ6kc/KPx+xUeXS0geBDAH6kOrv+ZlBbaxrVQZEXRl7WByDC1/OVnxKJvVWRVftPFnCvIblui72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLxHg24MqYTok8yjvuu0hfP3XePeFoQ8r2eonz/VlBc=;
 b=KBUPlN3Wv+k4tRMqnDe+LgSsRjLdVP4dv9h5Att+XGvyHFsT6sBylTXmeiINRoe4ntvWHhQGbY3djIVlyCo9zunsHkrf+Rb8uCdQG9RO898QVklUaa+5tDhGIVeLg0DGDeK5L0qskFe+rWbUJQcI4eDjCtwcd61LVlsuQwrx3Breyg+tVLmHOxnbEPs+sfVQeD59eBqvS0MtOqOckyN6P91Rct6ZHcGdY9gvijB/r1F+0/PbRtVsMO9k3mQV5uDVy5jueqbNytLDLFfjH5HyQpVoXyqzHnticSY2BrRy/YOhNoSosbs8lYQSpLsFJ99dmo7tjI7Nxdy6WdANJT3D6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 10:41:33 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:41:33 +0000
Message-ID: <eb573f51-4363-4cd7-ab1b-0d7304820d85@intel.com>
Date: Fri, 20 Dec 2024 11:41:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: default to round-robin
 for host port receive
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rogerq@kernel.org>, <horms@kernel.org>,
	<dan.carpenter@linaro.org>, <c-vankar@ti.com>, <jpanis@baylibre.com>,
	<npitre@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
	<vigneshr@ti.com>, <srk@ti.com>
References: <20241220075618.228202-1-s-vadapalli@ti.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220075618.228202-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0307.eurprd07.prod.outlook.com
 (2603:10a6:800:130::35) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 144e5923-5604-4813-0902-08dd20e2df17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkgvVjlkMGRhM2NzdTg3N0ljcS9oSlBOdW5IeXBKOHMxeVFrUWJYeTNuSjln?=
 =?utf-8?B?Vnk3R3ZzeTA4VG14c0ZzaDB6K0JEcVRUdnVTWTBpcVpFZ2NiOXRHbW1hNjhO?=
 =?utf-8?B?blBZWFlHL094WWlBdUUwNmNTK09HeFJVVWVyTGpCMTJSd1lsNU84dU9XOGdS?=
 =?utf-8?B?ZkVvSXFpTytja0xrMGVBcjBhR0xOUXJIRmpFdkZsc1cyWldra1dMNCtVM085?=
 =?utf-8?B?eW1ZRlRGdHpFVEhKWnA3aW9TSHh1OGxKaUFUTGlvUGpSUHQyQ25helR2ZlAr?=
 =?utf-8?B?R2MvcXh6Z1I1NFdOb1R6Uit0OUpXM0h1Y040SnFSTTBxNTI2cy9rbDRjUU9k?=
 =?utf-8?B?ZGk0ejVIYXAxRGg3S3V4dnBzTjhaL2YzQ210bWI4YlpMMXRDYWhvYnBnSlMv?=
 =?utf-8?B?cHV2ZkN4aE90UGlVQ3dmeUNCR3V6ZTNJN3U0Yk4yaW1mQmd3eTY4SEhhZElZ?=
 =?utf-8?B?L2FLbFRzMnh2d2JFVzQ1RkhRYzhBK3JZMWt2VStSWE1PZURoNFd4SXB4ODMv?=
 =?utf-8?B?aFV0QXFwTHJtN2xkd1QvdkUwNWlVbHFPalJ1YXE2MHFwNmRqZ1o2UXcvREZU?=
 =?utf-8?B?d0l2WUVBaWhaQjRFN0ZtcFJ1TXRMdHY0ZmxsTWwrZmhHUFNwUTJQRUVLV0E1?=
 =?utf-8?B?V2pIdURZNkEzdjZZT0daVnhLOFphQ3JwSnpQQzB6MXZaR2J4K0x0ZTZSRlN3?=
 =?utf-8?B?ai96eWVzc0RlTnhSVjFhZlJxS2NCVXNBMTNDaS9yOFdTbURTMXIxK2dKY1M2?=
 =?utf-8?B?dTNTUnI0MEJQdzEvK2JnZGh3VnBIcmhsbEZKTHRGcFhUN3JmUGNRbGtNU3BR?=
 =?utf-8?B?elU4bUVHVUE0WnhCNFcvOURoL2QvQlFxNHFMM1lod3Buc01WcGR6cmZySVNZ?=
 =?utf-8?B?YzZvVitFT2ZlN2pKMFZRSm1HczEyamFoMmxzcVlpMlJUdGpGSGd5Mk1XL3Ex?=
 =?utf-8?B?ZHArVnd0MHlVQ3hBcC9YM2FRUzVTNGoxUHZ4Zy85Zzkza2xYMk1KRmpMT3BM?=
 =?utf-8?B?MTBLR1k0SDZmU0YybEhuYzlhQmtxQ3BIbzd6cHQ0VEM2SmVZM21CSHE2NnRC?=
 =?utf-8?B?ZGxhK29EZlZTUEF2YkRXSGxKOXNzN3h6dzE3N29VWjR2U2poUGRXdG9idlI5?=
 =?utf-8?B?RXZ1TUtJOVJaM09kVG0zcjRMSWRrTnl6UkloVzRzQzUvN2JIU1lDRzlDUit3?=
 =?utf-8?B?R3RFcEN5ZzlJMXRsNkg3alFuK09GNndRakR5L2VOdkJicVM3bFliZEEwUGl5?=
 =?utf-8?B?dk53MnExY1B2OGQwQlZjZmxReFF2WHRBbEh0cHZsb0tYV2wveXJZVTA0NjFx?=
 =?utf-8?B?VEp1d3Jrajc2SDhlZjUrbFdZRndJWWZWakJ5ZCtMejR5VWJDYWhudGxRNW11?=
 =?utf-8?B?eG5PMW5QeWNpVkRwNGovNUNoUkJYZkFjcUVlVlYxcGg1cXRDV2NDMzF6U2xx?=
 =?utf-8?B?dS9STm90WlpXSWlrRmxpRkpNWVFOejRGOHpRUWtaV3lPQXdFNEJZNlVnOU4x?=
 =?utf-8?B?Y1ZkQXg3dUFENWxNeFBFRFlHUmYzLy9iMVBycmw4cXFnaURGbVlpYlViejRL?=
 =?utf-8?B?aTdMVnpyU3Rtejdqd0xiNjhZcFp2K09aNzAwZGFDdE9MQ3ZhYzhqZEZLbGJv?=
 =?utf-8?B?QWxVNUpLdEdZS2dxTkVRMWxKZndXOU0wS3BLUCtvdXZsNDJDN1huaU1hakxZ?=
 =?utf-8?B?b2I2aXJSTUh4MW02ZVRoNlFuQVBJSG1wQXdMT0ROajg4dXgyQXBsRmlhMEFl?=
 =?utf-8?B?RTRtejZ2VTY3MnNQRWJmQlZrbDhEYy9Cd0RBamNYaUFPWVVWTkIwY2wxN2l4?=
 =?utf-8?B?d0U3eGMrcWViNGRGa2hIVkQwYno4QU1waGJRaVpteG0wUkJVUzF4Vzd4d0s3?=
 =?utf-8?Q?wkDMilnVpDi+j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZUSDg5WVBNOEcwcWh0UHcyNHFCcHNDT2FIN0h1ODJLV1pEU0J1OUtSZmYv?=
 =?utf-8?B?YkdVUkJHTy9ybTdQQ2M1djdYcmZMK3Fic0pFVUxDMDc3bnJnMCtYOTBRTXNw?=
 =?utf-8?B?QXk2c25KSXpzczB1aXZWZGFDN29BSkc5TEhQUWUwT2hYTXoxR1M2M3JCMVA5?=
 =?utf-8?B?WERNWG9yZ2lkWGhUSGlrVTZDdWcxWitnTytCNzQybXMyWW9HWlRBWGRVOUoz?=
 =?utf-8?B?MklpYk56TTY3UFhvc3h5T255elVyWUVGSUwvQ3NVMTdtUVZObndaenZKcVFi?=
 =?utf-8?B?bVpMdFdHU1NnLzhWcjNlNTAzR2VqTVA3NGRzdFFEOThRM2F1RXM5OFdmSk5J?=
 =?utf-8?B?Y0dWbVp2OGpUa1N2dHpXYStHbEpLcGR4SDVRTy9OcUF1UHpUcDVLT0pKN3pD?=
 =?utf-8?B?aUM2anFseXo3K2Qzc0FTWVozajBrWGlRSXFkSzBWMG5EV0xBNldqRk9zSjVN?=
 =?utf-8?B?SmxDRmJ2eHJHUEJ0SkR5MDhKRU1DZVRtS0JUb0puak1iNlRPTnRmQ2VDd2o2?=
 =?utf-8?B?Vm9tWExYNElNQmQvY0FSUEMvbFBJaXdOWFV5N2kxSkp3RXZKU1hhSFhqWHpO?=
 =?utf-8?B?OHdjNGthSlQ4dmFYYk8zcTZ5WnNiNFlIK3lndEZVbVVtcG5nMU9hNE1vMi9l?=
 =?utf-8?B?ZzU0K2dVdTdsTjN5NGk0T2lybnpramtXMVpMU3poc1lTUGlOc0FRZHpBQVhJ?=
 =?utf-8?B?VkJtUFkyOHBkam84ZkVCOGphOWFuMENNYnpoaW9xTDNmZy9RcUhqdExXZ0hh?=
 =?utf-8?B?OTFKOEZKcnJyeGpyblJnTUd1V0crb1JmVVJNMFRoRUlMRCtsOTVPb0ZlcHV0?=
 =?utf-8?B?UlJLRysydVlHRk1XYTZ6aUhmWitTMm9pUWdvQjNKcHByK05sK0E5KytQeW1Y?=
 =?utf-8?B?V05QTCt2eW5pd2JPcG5lWURnYTEzZTFmTVJKQ25za3hXU2E3ajVlSEhWT3dG?=
 =?utf-8?B?U1FORmFTZ1MwSTZ3WFEzUFdISmx4cFpTaUI2WWx3dG9YNWNBOC8zcFVtT2No?=
 =?utf-8?B?eDA1d2V1MWV0bTFrbTVVUElBak4wTDZOWnhJMzRnZXRxZVNYY2FxNWM1UW1Z?=
 =?utf-8?B?c0pqL1Nrd3JKODg2N0poRzBzUENHdllvYVhaQUhKdWo4R1JjVTVQLzFYNkhz?=
 =?utf-8?B?MkY5S0I2WFN3bEdmNzJaTzlJREtSTUxLbnJ0RERMWVZhenRraG1tWXZPMkZo?=
 =?utf-8?B?V2NsTDduUG1XSXhCYjc3NXkxNVgzdHFoMmk4UGtkVm1SSmo2VUVpb1Z4a0lZ?=
 =?utf-8?B?bENtaGZQbzdIUytKVFJBNzZGYTlxNzRmdUUvUkVjcys2ZDN6Rll1NTkzdWZo?=
 =?utf-8?B?UGs4VWhVczV4R3RoQmg4YXVZMm96ZEVaQlgrOUREOGJpaUNHcUlad0lPdHVl?=
 =?utf-8?B?WmczclUxeVVzVDJPUzBzcGNNWmplK1hPSDRvZ3JuZnNGcnYwRHRyWUlMellm?=
 =?utf-8?B?UkNJaGc5WFlyRGh2eUFGY2xBNU1XZXNsNzBTNXhQeldMSFdGR1Q4K2gzaVlQ?=
 =?utf-8?B?RWtIVlowUmtCdWVFRzcrdzYvNGJEVUN1bElpcWdLMjBZaHZjZDREdndGNS95?=
 =?utf-8?B?U1dMNUw5bmtpdlJXNEVneUpSVzFzNjN6VDR1TkltTkNSM0RxWkwrRGZqUWE2?=
 =?utf-8?B?ZzR2dnZpN1JoWHNFTWRxZ1VHUzFPMGFLZ21xd3VybUV0NjFld09LODY1aHZz?=
 =?utf-8?B?UDdyQmRlSW0xam9WVVZlQnVHNTc3VGRuUURkRktJaWhIZkljdEZyVGxHU0lX?=
 =?utf-8?B?c1duK3ZUUWU5dmlEak9iVjBYb2I5WndlUmx4UnRPbk9OWkI1VWJaUGg3eUl1?=
 =?utf-8?B?bzVGSm03RVBseGV1ZXIwNGVBSDhJblUwUTlXcWI0WXo2VlQwQVpEelRxazRY?=
 =?utf-8?B?UGlsNEJuRzI3bXhTbUU1Rzl2NFBXQXFLbncya09tZDhjNUp5eDl3L0hwZ3RJ?=
 =?utf-8?B?TGZhb2UvbjhyOXlGNjgrNmM5aThxeVdrMUNSamcrcFE3MjVmZ2dUY2J3K2hq?=
 =?utf-8?B?VjdWeFhMdDhqazNzUzcxd0RtRUtyTS9vd0xkclBSZTFFaXZDTmNvajkvOGcy?=
 =?utf-8?B?VHpiUk5mNHhpNEhybGwzazY2MzZhUEtjbm95VVJjcFV5TDNiVzBWWFo4RmVV?=
 =?utf-8?B?U1FhUFpqeTl5NUcxTkpaeGZ1NEJJMks2ZHZ3a3BpbzV3QXVPV1ZCblVxejVG?=
 =?utf-8?Q?YQ1hB730deWM04qHQAADpt4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 144e5923-5604-4813-0902-08dd20e2df17
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:41:33.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOU3hKbnmxGr64UTSjHXuRwjgrvSUJT9aM9ktm+ia5Ev7snz52AognvkQIwGPXuaT29kV1Rw2kv1kLBo/qiMgCJz3wpoRCXuX9GgSLXVPbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com

On 12/20/24 08:56, Siddharth Vadapalli wrote:
> The Host Port (i.e. CPU facing port) of CPSW receives traffic from Linux
> via TX DMA Channels which are Hardware Queues consisting of traffic
> categorized according to their priority. The Host Port is configured to
> dequeue traffic from these Hardware Queues on the basis of priority i.e.
> as long as traffic exists on a Hardware Queue of a higher priority, the
> traffic on Hardware Queues of lower priority isn't dequeued. An alternate
> operation is also supported wherein traffic can be dequeued by the Host
> Port in a Round-Robin manner.
> 
> Until [0], the am65-cpsw driver enabled a single TX DMA Channel, due to
> which, unless modified by user via "ethtool", all traffic from Linux is
> transmitted on DMA Channel 0. Therefore, configuring the Host Port for
> priority based dequeuing or Round-Robin operation is identical since
> there is a single DMA Channel.
> 
> Since [0], all 8 TX DMA Channels are enabled by default. Additionally,
> the default "tc mapping" doesn't take into account the possibility of
> different traffic profiles which various users might have. This results
> in traffic starvation at the Host Port due to the priority based dequeuing
> which has been enabled by default since the inception of the driver. The
> traffic starvation triggers NETDEV WATCHDOG timeout for all TX DMA Channels
> that haven't been serviced due to the presence of traffic on the higher
> priority TX DMA Channels.

I get it right that the starving is caused by HW/DMA (not SW)

> 
> Fix this by defaulting to Round-Robin dequeuing at the Host Port, which
> shall ensure that traffic is dequeued from all TX DMA Channels irrespective
> of the traffic profile. This will address the NETDEV WATCHDOG timeouts.
> At the same time, users can still switch from Round-Robin to Priority
> based dequeuing at the Host Port with the help of the "p0-rx-ptype-rrobin"

why the flag has rx in the name?

> private flag of "ethtool". Users are expected to setup an appropriate
> "tc mapping" that suits their traffic profile when switching to priority
> based dequeuing at the Host Port.
> 
> [0] commit be397ea3473d ("net: ethernet: am65-cpsw: Set default TX channels to maximum")
> Fixes: be397ea3473d ("net: ethernet: am65-cpsw: Set default TX channels to maximum")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 8faabc041a00 Merge tag 'net-6.13-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 14e1df721f2e..5465bf872734 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -3551,7 +3551,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>   	init_completion(&common->tdown_complete);
>   	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
>   	common->rx_ch_num_flows = AM65_CPSW_DEFAULT_RX_CHN_FLOWS;
> -	common->pf_p0_rx_ptype_rrobin = false;
> +	common->pf_p0_rx_ptype_rrobin = true;
>   	common->default_vlan = 1;
>   
>   	common->ports = devm_kcalloc(dev, common->port_num,


