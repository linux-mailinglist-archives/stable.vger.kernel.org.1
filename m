Return-Path: <stable+bounces-69758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56890958FE6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F298285C5D
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB41C68B8;
	Tue, 20 Aug 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hjw5hUpS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5C18E377;
	Tue, 20 Aug 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190398; cv=fail; b=EuTAb7SDcctZTk3d9b6TL5hrKsJ/QH8gE7GApCBPqQR6/nv+fqVGaOddLobJtYgBXhSH/ZLIPhT5qt4RXsA6jz5QvC/imBvtZoHbthaOrsGPTNZQS51ssMAhhwcuyu7quLFpq3tRc7n7o9kgpnIJrw1b20ToUVdWl8JQeClysLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190398; c=relaxed/simple;
	bh=HW8Gim9B4w2QqYX1e5ujfOZ+qJBYrPvf3kFFoTFThNI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rpZJOuxX9PZG/T7SSUPJGCY78LHT6iSfK+ZuHIiUl1GMmArTp8I3U0sENkPbqtwCnvfX0NaixGfKKuV8xpkUdr8FW0e9JOMvJ41utP4FyMNWB5OkprXrR+Idn29MCW7vv7Womi0iwLmw3iS+z0/a32ljurn5sRuW11YFlBcvu9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hjw5hUpS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190396; x=1755726396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HW8Gim9B4w2QqYX1e5ujfOZ+qJBYrPvf3kFFoTFThNI=;
  b=Hjw5hUpSIsVy4AqA3W7p9e1EFmVjLHy/A0Hjv9xuDK625Galg6RW47AF
   h2UU7eXP3FEM3MAuV6e6p6WNobL8ykyh+mjaAvDi+deNmODeYYaeEXK6K
   qh5ADB/QJ3M5evEZt8yNqRsZGhN0nOHGbZZFBqv2jffiahi3sumZLtZvj
   jI+1/Sboso/6OI3fWXKHbmGoPp+GngBPefAetPpE6S6RO8P9J/ozt2wBv
   zdFnwQyNFxnFvztW8OqplIolgSOOEWR0UV4ZDNbMbFsjQ0xQDUpKESq17
   8hs/UKfE+xqbud4/8Z/vQ2w9IfshVGLLrz8yfh/0omDsFI4hZO0Aqjq9v
   w==;
X-CSE-ConnectionGUID: 1+00SrO8QumyJ+ejPDd+3A==
X-CSE-MsgGUID: FIA0ARpXRgC+lFxG+QbIgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="45045331"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="45045331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:46:35 -0700
X-CSE-ConnectionGUID: Io5HqugiTfibi89djHEMpQ==
X-CSE-MsgGUID: sk7pqhx6SOa18fXYPAladA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60724587"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:46:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:46:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:46:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8UfXcXO001imZNwzxU2gTtk9AhXR04BjXRODTagC178Q3c0zUauZnEwf+bUqbRfWwJwsJH4kL1ocMmJlbpN69TsP6ts6dyK/8hXXoqqPT3DfSHgBkMdoUAxGxUPhNZknzQ6Doz2BRJISy6iqaeo5OUk7EIPc6GnquUtxATIjlucXSslhMKNkAbSj3AHWXm8nU3V7+r65XywaTgY7ya66dD6i6K4R8jmWUpaXVULtSQzz1R2tQsDaC/KLqaFKgiTaqbZBfISuT+RX5ZPu4XYdCAMJBw4g4XcRJq0ApwEhAz2ACagFO8AQTG/pXKHRtolmCCAKsqmLhx8zU+Us9lFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUvrP1RjdZVGOxbkwozDZneudS4Mp4uJlpN2AhucUHc=;
 b=G3HdYPhiNC9NeFvnJr3bfSYq7hbbREKwx0hdBOHesMKs+BtJrJsFapCeZsFkQUJ7BAjCkLrhr+5VmdYFzsBweEXgbuCVTP7T8h07NoE/vB+7diM7G5u/34YSk7SQQsJv7wF/lp3WOkKtO/VsUjW3tvHav/XP77xIaymwhki8moTlFsAnmKeqtxwOLmwTZ1+SU1+2EH7BfMVLAyY1AV2E4pRC7evNDhiSGhrdRG4eX1cQu00loLcvV7mFHGA31UOheZdYbue3mlyDs1UGgApfTBwlbMOyZ/eHgHA+0rmaPbsf0oB9YLFMa90ipl+xtWHF1SgWgixzBwSTrb/pxUdKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:46:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:46:31 +0000
Message-ID: <fb874804-e0d7-4846-9434-64fa1a382076@intel.com>
Date: Tue, 20 Aug 2024 14:46:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ngbe: Fix phy mode set to external phy
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <przemyslaw.kitszel@intel.com>,
	<andrew@lunn.ch>, <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>,
	<stable@vger.kernel.org>
References: <E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: f4414eea-6ca0-4be5-5558-08dcc1618dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTlEVFYwUWJsZ0QxR09ZenY1eU9nemhiZ3hROUYvME80UVU5a0pYVThySmR6?=
 =?utf-8?B?TkRPa3V3eG9PU1VVcXMvUmNFK2NpVXRlVFJoN1dzUm9hS2p5TS9CVlFIZ2gz?=
 =?utf-8?B?b3NvNzhFMGJ1dlVyaHBXd2kycTJNanlndENUUXdFRk5IV1VaVWJtVFZBMGh2?=
 =?utf-8?B?YTVIZDFEYXBsSXI3WXgwMzdYdEpvcVJPNlIxU3BwVHhoQ0JvUDlnd1pIZFFS?=
 =?utf-8?B?RGt1ZlNtREs2bStHem15THRsQ04zeXVjZFRNckZCSVJ5WVlQdFpVYUh4eEhH?=
 =?utf-8?B?Vk5vNWZPMXJHdDlQU2VSekw2ekZsdGdWb09uVnRldTdQZFpwVWxiRlQyY1Nx?=
 =?utf-8?B?RkJjUVdhL0RjaXJ2VHRnVlFIemJqY3FtWDVJclJsQjBzeXhOR2R3eThxK0tn?=
 =?utf-8?B?SFdZdXdRYzMwY1lBT1JyQ0FnUmJjREJkRlMvRXhlbHc4T1RaS24vN3B2Uldp?=
 =?utf-8?B?UXV5WUE1OE5NT1ZzVWtNMGEyT0N1QysyRnV6RXgyOCtTK0U1b1hlejVtYjlm?=
 =?utf-8?B?YWVDQ284cG5lVE52ekxmMGM1SU4yVk1SaWFUcXdWeWFzcVpscXNJNUt4YzFl?=
 =?utf-8?B?UGwySDhQbUM4UmRTQkpTQWo5dW13SjU2UUJLcnd2QjdPZzg2eE5tRDJOZjho?=
 =?utf-8?B?aFQyNmRCQldqcWV3TXdrZ24vUElxUyt1eTBFOWg3K3lBT1NqUmZ0MmsxcWl1?=
 =?utf-8?B?NFlib0ovTG5oZ3o2bHZBVzhKUDBPbnl4MmFOM2NKTzRaVGVQWXBHbHVRNW01?=
 =?utf-8?B?ZUlBa1ZNRUMxcnNwbHVGVitoZXB0TnJsSWVRNnJqVTYwMWNzTWUwTEI0eWVB?=
 =?utf-8?B?ZEp6V0lPby9mQnp0dnljS09IY2YxWVlJTkprUm1zZzh1Y0ZOOWkwc0ZHVDZa?=
 =?utf-8?B?bHZ1cCt4SWtzTjRqdlhFRE1ZTS9vcGYvQmpTMFgzaVR0ZURYTUErK0hmd005?=
 =?utf-8?B?TnJrSlBDQUI4eXFyRFVKNE0weGM4dHNxYmRNbi9JdEpPOFlXWHV1eHJOTXJJ?=
 =?utf-8?B?VWswOHRhdWtBSC9VYnBBcC9yTTdkMkd5bCtmQ2NtKzAxVHNUM2V5NDRCbUxj?=
 =?utf-8?B?c0EwdnF5em92LzYzNHRneUpJVWVzOWhKTkR2VGtKOGNlSmI2WENhZzNqOVlJ?=
 =?utf-8?B?T2dmNUVkRVRlTG9iR1VET3haalQ0V1IrTGdTaFV5MmNxNVBRV3JqcitBUHFh?=
 =?utf-8?B?MXlPMlE4b3RPVE8vYlBEUkFsanM5ZW9GWHRYdUNVdUoyb1QxZFJRQW83RFpZ?=
 =?utf-8?B?SkdVRk5mcTZDVDhxeExhNFB3cFUwNmN1a2FxeGlGbzg3V0pzWHE2bjBtNmxX?=
 =?utf-8?B?YytOMjdJU0VOSzhuS3hNMENnaTNQcGNMS0F0M1dCM2V4OCtkRjFod1dzNHpR?=
 =?utf-8?B?c2k0YThBd3BtUW5GTkxhdUhudGx2V0MwUkhBU1RCOXRtMjNjVFVDTWpnTXor?=
 =?utf-8?B?ZUgyRXhTYkw5V3NybUYydFRFd0FEL1RTem81UDFKNktmWXhrOGRiRWx5cDBi?=
 =?utf-8?B?RjZDejJIYUtDOE1jSG1PMUIrNjFWTmEwR3FpQkpaanNiZUtTeFlkL0ZaM3A4?=
 =?utf-8?B?NnBMZmYwMG9sOGhWRjBWMXdkVXRxY1ZvR2o4eFBVSU9PV0VKV2hrZnV4TWJs?=
 =?utf-8?B?UkI1Q2VocWFIbGRNaTdVcGdoK0lRTzAyM0N0VDhhcnEyalA1bzU5cGMrVjd5?=
 =?utf-8?B?TjdqKzB4TndhNUxieGRwY0M2SUhtVzEwSEl0SysrWk5zZFBXQVN3YXdUeVRR?=
 =?utf-8?B?NXdKNFJubEU2aXprdnl5cXViT1l6Zjc3aGYwZ3ZkSS9qd0d1dVpsenpjeStq?=
 =?utf-8?Q?kDz5po2jBX4LTSoz7KK8hhJRKRM3zASkONLFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBxTkJJRGR5UjltRVM5eVVvTU51MFM4TkZQZWdmMFJqRWEraHVUL0VBUGUw?=
 =?utf-8?B?Z2Y2QVlma1VtY0RTdlhYMVhqNHhzOE5mcGFaaUh6SFhJQ2NUanl4RHJxc1pw?=
 =?utf-8?B?eVkzaVpwbnM2eUZNV2lGYmdkdTNnbm9ZZk9POFo1QldzdGdwaWZ0Vy90cGx4?=
 =?utf-8?B?aWxDSEJnbEdIYnlsNkwwMzFFSEgvdUFTNU9YM1ZJSVdUMkcyK0x5RU83V1Vz?=
 =?utf-8?B?NnNkZ0UvZUpKdHFEeXlhL1dEenhuS2ExUGRzeTRZM2d1N2Fscnd3aXhtWmU2?=
 =?utf-8?B?aDN0aFp4RDJ2ZFVvc205cytnVGM4dGZCbDVkei9KYlZHTUdTVWdFN05OdC8z?=
 =?utf-8?B?TzhjbzhWcVV3NlQxcGZPRCtrd2NyQ1cxOGk3QUF5YVhGM29qR0FyRW5JMXZY?=
 =?utf-8?B?QUFCRkx3dVdDQkFtOGdqTmxPNVU3NksyNS9uU0xBbWl2ZTY5L296akc5SDhO?=
 =?utf-8?B?Ynd5RjJFTlpRVVhxZll6SVFUbGVlanR1QU5ONW14dlZGbUtiOEtoMDBrbXpR?=
 =?utf-8?B?MytXVTRIR3pSck1ZTVIwaitlQ2ZwU29rdjlGSVNVVUppOVJxZ01RbVkvOWww?=
 =?utf-8?B?RFljTHdvdVh1SjIvTFRUYVl5MDNZSVVlc2dDVVc0NzkzTzQvaDZZekVxdFMw?=
 =?utf-8?B?WnhDMjFubmdzMCtwWDR5ekE3bmRScm1Pbm9QdTJ2Vit4WFN2dXRLWVliNE9N?=
 =?utf-8?B?b2VmSnVKeGhEVldZakl5a2NKc2FvQ0J5OGJaeVQ1YnBzTjE2MnRwVzQyZ3BY?=
 =?utf-8?B?WGxtSE03VktWbXZ3cGpQQjV4eEhkL1p6MTd1RDc2MmVXVFRNRUlBODgxSGFK?=
 =?utf-8?B?S0MzM1B6KzJlR1dZRTZtbUdKWmJ0SDFvUjgwck16d0tJWEpza3AyQkFiSWxZ?=
 =?utf-8?B?SHUyanllRWJVU0hHNVFJYjAzNkw1ZHFCelU1cmEwK05uekRvclJ5eVVjSDBV?=
 =?utf-8?B?d0tBeXBVaklIWjl3Qm55ZCtWU1Q2MmdLeDA1UFlkMkRuMWJDSzRhVXNMMHFp?=
 =?utf-8?B?VnZMSGQyd29TMzBhMkIwVEJUR0NZckNvWWZkdVhUYXVNL09wY1UvYzdqQ01W?=
 =?utf-8?B?amZ6cnZsOFdkMjNLOWxsVExrL2pSQWc4ZjNSczB1ZlZEcm9sK2hzbSt1Q2xs?=
 =?utf-8?B?YkZSYnYydDAwTEZ2OHBBUU1WTG5YbUREbzgvYUkrUGV0LzJVZDlnZGtkSG04?=
 =?utf-8?B?UnNSWWw1M3ErbW0wdnM3cFNPL09qZUN1dDB6aWUvMWJiZzIwUW9nb0Q2QkhV?=
 =?utf-8?B?R282UHVyTDhhbE10TC9lN2dWcnVGOHNzeGV0cGZ3V2REMlBtSkt0dm8xTldC?=
 =?utf-8?B?QVRZQm0xd3ArZ1NlR1ZhY3VZcTBtNTFzU29nK2NhYjdVM3hSZkw2bUVoQ3FS?=
 =?utf-8?B?L0ZCV1NmWmFtcXQ2SG1mS1BWT1g2QlRkdWo2RGRDelJkRVNVbE9nemVsMEJk?=
 =?utf-8?B?RGhJaTFsWkxrWlhYNEh3bUNaTHhLOWJINUVjMTBnYlJQRmg5Y2pPSmVLRm9r?=
 =?utf-8?B?d2FQUkdrdjlZUVNsWjBPaHZxMHY4aXRFQmcyMmlNTjBrQWZXVDdyRHd1Nm5l?=
 =?utf-8?B?UzlHdUlIS1k5WUFvbVVHK0UwaCtjWVdLT21EREtXaVp5T3NFd09jL21PVjlk?=
 =?utf-8?B?OFVtY1NLajh1RkdQZDFOOUI4YnF1Q2Y3Wld5b29FMWRlS0Q3M1pRclVnUFVv?=
 =?utf-8?B?ZmtRbTM3cW5sUHVRL2F0dDM2ZVladHhLekFGWUcxTHhmYmZsWEg0TEN6Q2Ju?=
 =?utf-8?B?dG1vRkhFaWZ6eWdjVkIzbjRZKzc2VlB6R2JBVnMrdDVaZC9admZaOGpLdGIv?=
 =?utf-8?B?TExJZXJvVjZwN00wSCs5T0ZhREllM1BlSzlqUXFncjhhNkV1akxGdVpuNExP?=
 =?utf-8?B?REI5NlJDbXdOYmFUbGl3dHVlRkJmMVRLUXZCdnlMTHhDS1huYm5nZzhDOVRl?=
 =?utf-8?B?Q3EyNFB5eU51U1llTWxKYTE0dUJuSkdyRFY5Q0FhbzJxQks1TVpQMDFZSlJs?=
 =?utf-8?B?dTNFcEFPeUZWSlhoUUNXbmdsZk1IQnNWU1hHUmhOM3FzS0hTREVhV2RzTEZ0?=
 =?utf-8?B?ZVdJdXhUdUdPU0xKLzl4SEh6KzU3VzZQZ0grN3Y2a0IzVnV4SXplMUVvTWl5?=
 =?utf-8?B?eHVoUmtHMENRYzRxVHpsT01CbWk4b3NXN0ZyQWVjMGt0QVBKUEdZUmYzT2Iz?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4414eea-6ca0-4be5-5558-08dcc1618dab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:46:31.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvjxjrRjZ3F71kZlyEW7lPUzcMAo/qngTKLcasKBwIrHd8izouvHHMgP57s6Qb6jwGIysS14ijP2qe0prlGyO93OtwvZ8xXORA6Tvkmn0wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com



On 8/19/2024 8:04 PM, Mengyuan Lou wrote:
> The MAC only has add the TX delay and it can not be modified.
> MAC and PHY are both set the TX delay cause transmission problems.
> So just disable TX delay in PHY, when use rgmii to attach to
> external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> And it is does not matter to internal phy.
> 
> Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> Cc: stable@vger.kernel.org # 6.3+
> ---
> v3:
> -Rebase the fix commit for net.
> v2:
> -Add a comment for the code modification.
> -Add the problem in commit messages.
> https://lore.kernel.org/netdev/E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com/
> v1:
> https://lore.kernel.org/netdev/C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com/
> 
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> index ec54b18c5fe7..a5e9b779c44d 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> @@ -124,8 +124,12 @@ static int ngbe_phylink_init(struct wx *wx)
>  				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>  	config->mac_managed_pm = true;
>  
> -	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
> -	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
> +	/* The MAC only has add the Tx delay and it can not be modified.
> +	 * So just disable TX delay in PHY, and it is does not matter to
> +	 * internal phy.
> +	 */

The language of the comment seems a bit weird to me. It makes more sense
if it read "as it does not matter to the internal PHY".

That being said, its a bit of a nit. With our without changing the comment:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> +	phy_mode = PHY_INTERFACE_MODE_RGMII_RXID;
> +	__set_bit(PHY_INTERFACE_MODE_RGMII_RXID, config->supported_interfaces);
>  
>  	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
>  	if (IS_ERR(phylink))

