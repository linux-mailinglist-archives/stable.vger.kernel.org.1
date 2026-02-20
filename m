Return-Path: <stable+bounces-217605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG/HDTTwmGl1OQMAu9opvQ
	(envelope-from <stable+bounces-217605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:37:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8A16B68E
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05EBC3006955
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05599234984;
	Fri, 20 Feb 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWTJAxQa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3921A5B9E
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630609; cv=fail; b=m/PezAOjeG8z00rW2Rj0pTwXNOSlFq4w31mgAZ8GwbyB23B6ZoYWEdASMHPNYW02wrppbJTQRAVCSOHxddzDKxg8FLCqxtYxiWbZb5xY54BRJpB1fBXV9kFplWqqbTqZ5SS5SGCUevAXc+B4k3gNvVicrKrUgVFiNlibQwMj+N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630609; c=relaxed/simple;
	bh=sE5mq7Rw1n0C/D1//SGYzFxLXQXjgu480wRoZro4jOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSLqw1eivWKXxx5lo1w02EPX8jSTlTs9Lm7+/hy948nTqvsbNuS/yyJcFjVdO38Z/DIjBcCxp7syY0QmPoqWOeVnJyKvLNp5Oa3KTs2uYZhWVFZu0oM4n8WpeoCHlH1V5JGBrz64YXYoHnkQSDaLwLWmW+mbbjf+R7xwPAXwil8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWTJAxQa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771630607; x=1803166607;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sE5mq7Rw1n0C/D1//SGYzFxLXQXjgu480wRoZro4jOU=;
  b=jWTJAxQaxHbZNJrJCtzrfkPBWaugjYauyvvCCZJx7gbgyradqbn3JB9P
   cxiXAjcLwNPZYWsS5fVWhoQxMdtq2xzs1Wf5HTxSwEgTE4lXyqd0NxUz6
   uAXFef8A8K7EfeSFJ8kj6Z58Znzfm88Rsft0urJf/ho1g5T9anHGNeO0j
   28XhPto+qYXHY4DaAwv4Mdgg6su1k/a2BFLYcst1R75v30IlnOp7zlwR+
   e54uaNuUaGl9CEseaJC+yURMK3TrWMRMOFOk4XN3+hW8gwYmP5jzF+86n
   /arIzVhJA3UmlvRqBdxcWKKdaUADoe4Z6xPCuJntbAL/e93qWi4XtN61I
   w==;
X-CSE-ConnectionGUID: 7hiSv7DSSQGIhVFMfr4a+Q==
X-CSE-MsgGUID: gPEZWaoATeq8vIbtO8XPUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83351143"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83351143"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 15:36:46 -0800
X-CSE-ConnectionGUID: q03RVWKKRgWjMOsEqIcIDA==
X-CSE-MsgGUID: Lngfy6BARSyX1k5nUbfyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219492856"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 15:36:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 15:36:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 15:36:45 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 15:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdxOzO30d9Uhs+vfKMXpBYFuDqvEV1El9IU/vJ5Xf4YlT4LCvEtghcDCd91MWwBzxZOOoWkCh0G6xoRSR9xZ4dLoI9vxVAtRnmI0NHkk873gCXzFB4KexSmsT7uarVLJXdQMqqeoU/BlGC8kz/NdacGZ1BaA3T7hjEum1g5KRVV9HI7D5qbtT4BMZs0j8DfYUejQq1mPveQgwJYIK5UNgFGfngpikYqnFsPEo6F2IFJm7sp79OasUZN9GuuaqJ4NE1b4fgmB8Lk9pr9TWSfJxaT25eJ2aQLbbTCsWSmHl8/9u7xUNvL1k71i6WwV5vZGsVJ+olFdqn3Uiv7uhVtqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gnrPxqHARLgNFPpyFbIpN4ZtaWOPfx2/UXQ5kDVbis=;
 b=x3KslzZ5D39y1yGRjjEub384hilZLgCn4+VsdbyS5G6KWGUYENCVr7sfNrNzpjFIL0Hee4yH8XxN394HfXk45KTbBvh32wjJVCCdHDzH0JA9m5ZktKAU+TcpSHX8Hm55sYPNouj+xAco5xIG8xifWEoLrB/3k6epjxWllq4eF2g+TFoCa+LgYFmBY/zPRsgTpz1eA6ss87CwyhCg2JuOiq2yqsgP86kk1GLJM1vNApemXzN3ZY+GuZf5sEKn1/zNeNqKm+FNaIvXG6a2Wivm8vFJ10l8/NOUCePSJ7R39/bipw70dX3HrYoVSyz7DXeG25xcEWOc+ZhlwV96WfpmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 23:36:38 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 23:36:38 +0000
Date: Fri, 20 Feb 2026 15:36:35 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: Zhanjun Dong <zhanjun.dong@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v7 2/7] drm/xe: Forcefully tear down exec queues in GuC
 submit fini
Message-ID: <aZjwA/02hMVASfpn@lstrano-desk.jf.intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
 <20260219180701.2418453-3-zhanjun.dong@intel.com>
 <e71666b1-c006-4084-afbf-bea40aa4c425@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e71666b1-c006-4084-afbf-bea40aa4c425@intel.com>
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 67426b63-ea4c-42cd-f66c-08de70d8e44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVQ0eUJZWWNGK1UyRHFzaTJoMjZOVGs2S3pac25pZTRoQTE3Smx4RWpCUmt1?=
 =?utf-8?B?bys5N1ZpM0R5Ty82UzNxdkhNRDMvTkVOZnV3SGRmNjluL1N0VWcwSER1dS9u?=
 =?utf-8?B?TDB5djBQc2dTeHhCa0ozTTlveVV5N2RNSm4xcURNbEJlMkxISVFlS3pRamdN?=
 =?utf-8?B?MTdvUHhpUVFxRkNVYmo4NzhPeVc2b2Y0MWRWWldFeHpnZXRqUjl6V0k0dU9Z?=
 =?utf-8?B?ZzV5RmwwNUNibTgvMVVjdXNpVVZNb0lkQWRudFd0cTh1cmNJd0tIMW5kWW5r?=
 =?utf-8?B?UDVwOEFxOXQ3em0vRzRsVE1La2U0YWlxcDZyQmZKY01Od3NVVUx2bExrQTk1?=
 =?utf-8?B?Z1YvT1Z1TE5xeURNQ1dyTFhvMDB4MkNlVjRaeHl0bkRIeklxaFAwZGRMd0lP?=
 =?utf-8?B?UlM3VWpDNlBiWlZ4OGRDYk51RDRTblYxenh1c0k3WXlJQ0lST1RzRUtacVlv?=
 =?utf-8?B?UERHa2h0QWwrZDZJVjRDa0llS0c1dGNvZzZkTkJrVThnUDkzMGRwQjJNMGcw?=
 =?utf-8?B?WXR2SHJJYVZJMFFRQzN3OEpGTkhsQmh2MVhGNTN4WVptaStJZGt2WkxZRlFz?=
 =?utf-8?B?b2xlSllMazVhdkVzcnkwQ0EvdWZEZGthM1NPWGhjaHY3azdZa0dYRlhSemRh?=
 =?utf-8?B?OFo4a0hlam9raUVVM1ZSbUJpcTV3cml2WDUySTRPeFJXcE43ZmUvS3BuOE0r?=
 =?utf-8?B?alJTaFM3MkxLTmc4UmdKU2o4S2JYbjdQQStCYUNGeURYRWcvNEhQZUZreTRz?=
 =?utf-8?B?MjJyaUd1VkZKblkzZ1M3ZXJlaFgvdWY5S1VGTi9sMXRoaXZkb3lZQWFsVGVk?=
 =?utf-8?B?SFdncHozTTcyeUdRSzJ4MzhZNGc0VWpxY2tkTjJUek84QUkyU2N4MjY0N09O?=
 =?utf-8?B?ZjRRcU5xTGwwanFmQjYyWktheHMvNU0wVHh5TjhHUWx6c3hwcWh0SlNqRytU?=
 =?utf-8?B?enk3Sk9oN2tONmZHckZvWUF3UmRRZGZ4YnRiY2dBdnoyQVNHRjBwL0o4ZjlF?=
 =?utf-8?B?YmNJTG9ZOWJBTHk5TG1aZ1lTSEdQTVcyMXFmeTlDYmxiSHBTblJtNTRCZW9G?=
 =?utf-8?B?Q1FzUzg5dGZZM0JWQzI1Sk4vVU43VWhIc1JCNFZjNkZBTk1mVnZXQTJZV25O?=
 =?utf-8?B?N0tQdWpDa0F1SjhSem9IdkFGRnBPSmdDUzdERHp2UUJjMTF5bEp2cld3UTMw?=
 =?utf-8?B?SnJwWnNweFp3NDJQbTMyRU94YU90ZlhDdk9OSGRHVVJSQy9IZ3dRMy9vTTdt?=
 =?utf-8?B?dnJ4NCtwWmVBdHdjWUhZUmE5QXJqTnJVVEJMeUE3K0ZwUW94Zy9jNWV1aGor?=
 =?utf-8?B?MExVQVl5dUt0cnMzUUY3eGtvNVVmVno3SHlCeUtUSGY2SGJhWU13VE81MEty?=
 =?utf-8?B?UWZLVlhHUnQvcWhvNUlQeThXYnplYytVa1d5ajFCZEtBZW51akU2TUJWR1dk?=
 =?utf-8?B?RkkxVGlXb3lVeXd6NEp6dTJzWnRjZ2QwYytNQkRuN21FOG00UzZaNld0aDh6?=
 =?utf-8?B?RFVBTmlxSUJPaWgxWmE5Wk8xaGFPemI5R2RjSWNSUndrVHIyZUNJa256bjJJ?=
 =?utf-8?B?L3ZjMzdMZlpQL0dSQ2VJYjdzZGhHeENlcnpmY25Db210blBhMVVvM3I0UzA4?=
 =?utf-8?B?VEV2U09HUDdvd2ZrSWdWclFxYjhmTHZJbVhab3c3NVZLWXViMlRwL2hibDV0?=
 =?utf-8?B?cHZwQ05yczBDQ2NkWkg0bWJ0K1RtQmVaci9yY3F3ekZIQ29EZHBmdVNubHB6?=
 =?utf-8?B?TWloQnBPcnpaeDBxRDFDMFFlRkszdytGcUlUM0RBeVVxVkg4WTB6eWJPVFg0?=
 =?utf-8?B?SlVKVnM5Y29Md3NXNWtaWFpsV2RiejNoS2I2dmxBM0lmSW1jM1RUWnRPVGNJ?=
 =?utf-8?B?ZHkzM1FGT1NCYlVKSUVseFVHLzNNZHBwVmVCYXpRNkY2QWhsOEt2RE1WUmFV?=
 =?utf-8?B?UFFNRmxwaTB3RGJjOGZkR0U3ZEtueUJzamZabldSQVdzODNOa042K0RWeGJk?=
 =?utf-8?B?SHdYelZtaUlMMW43azU2aERFZnl1NU5WbjVmNHNrTUFNdDJmMlFxdTZFZHE2?=
 =?utf-8?B?dVEwdVYwLzRJQ1lyZUZmRTZDR3R4a09NY21yL3IrdWIwNTloTGtsUnFwQmxW?=
 =?utf-8?Q?g0wc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2s3NWJFQWM1c0M0WFE1TVpSWmwwTDhiUWl3M3pYcEFRdEJPSEdXV0hDMUhR?=
 =?utf-8?B?N3RPeWhkTzhzQkNIRUs1cVhXVVRFaDVEWXdOc0drUklwTUp0clRhQ25QUnFp?=
 =?utf-8?B?UDgvL2d6bVd4UVh0V0RPUE9jZHpuMHF1SG13YzUyd2Z5aE13aVhWTTlmdDhX?=
 =?utf-8?B?VVZmd1JPWGUwTVFjWEpIbGVOY3Z5TGZjQ0VXZTV3V3ZsbXVBMEtnR2RHeVVJ?=
 =?utf-8?B?RUZ5Uit1dTQvaGkxTk5PbkV2My9rZ1crYjZqaVdHakJmNTUzQTh1Zno4Q2N2?=
 =?utf-8?B?eURTVUtHQ0JIMFl4K2hTRmJFRlpXTmZDWGM1Rjdycm5VUHJqZkR6RU9MNTk0?=
 =?utf-8?B?QVZ2R3VEOWxwL2IwUjUxTit1aGVOVU1HTnA2VHFmYnhFQlppeE9ETnl5RkZB?=
 =?utf-8?B?WjRvb0owTUwrNjREWDQ0cllkOWhRWkFSUmx2QzRZbTZLUW9CY0dqV1Jtdm5q?=
 =?utf-8?B?STFjMUgzN1ZYZEw0dEMyQ3hTdzF6a1VzMjdsZEFpa1QySlNXOFlJTE0veVV6?=
 =?utf-8?B?YU9Eb0FqVlREbjNMUVp0OGhwSUVhQVlMUmVCWldhOTR4L2lsRUZFbXFGeXNt?=
 =?utf-8?B?eGNZdlpDRCtXMTJyY1BRMVZnWjdxQ1BYcFZ4ZkVIUy9WVUpvV0V2NVJFVmNk?=
 =?utf-8?B?OUJKTlQvZllDRmRJdGtFOTR1aWdvT0paRmMyZHh3RDBkdXVRVUsvTlcrWC83?=
 =?utf-8?B?UkN2L1V6YVFlbGFQOElmZ050NW83YllReU85dDdnM3gxZVhCSnZWS2w2NEdo?=
 =?utf-8?B?dlJvTUh2bTVCdzBITFlFT29PZ0ZKdVB0WnUxM1Q2UnpSUHZ2d1E1VG5VTlk5?=
 =?utf-8?B?NTZ3RlNsOHpaVGt5RkFWTjJzTllhVGEyNE1MSjQyTHhXTWdMK1dLbk5jRG1v?=
 =?utf-8?B?dlpYUElSSU5IOGtEa0pDdnBIcGYvQUJmSlNmcEJvSEV4WlY0Y0NqakF3RTNQ?=
 =?utf-8?B?UjZNbUxIQ1VocDdVNkNQSFZFc01uUVVRREN1WXdoVlVuVFZpdGVHZmlSNUx0?=
 =?utf-8?B?NlRBeVMrRWR1QWF5NXU4Y1VlWXd3bnZ4TGNRelVObWFHaXo4R3dyL1FNTHpr?=
 =?utf-8?B?QzBVNjYraTF3d0dBV2h5enRObjFnaEV3Zmh6aVQ2dVpVazdWYzJ0MUVaQk14?=
 =?utf-8?B?bThZUTlFcEhUR2VleEpzbytHYVhRMU9QWGVaNUk3UStSWjJTWXJOZThTWnpl?=
 =?utf-8?B?QmRTZCtPTGJQQ096YSt3c1U3Qm1iTk10akJVZEthSWVwUGRTb3ZuK0swMVkz?=
 =?utf-8?B?VlR4d0NTSHU2MFVuaHFWaWo3QUVCVzA3dzZ2a3NJTDYzTUV6UXgxeG5sc3Zi?=
 =?utf-8?B?OVFFczJUT0RzQ2h1UkhVOU8zU1ZRKy9wTlo1bGYySjUrZDUxN3Q1SEZ2aE9O?=
 =?utf-8?B?cE45LzJCTW9SalpWRnB0VFRodFRMSVV2cldQcDdFL3doamFzczJNOE5ydUND?=
 =?utf-8?B?L2RWemU4a2t5NjN5TjVhbzhpSHdpb0k0Z0tQeENCbnk0aDlhaE00T2Ixc3NZ?=
 =?utf-8?B?aGp0V3FJcWFwek5pT0I5ek5KNEN4ZDJBNHFocjRtaHkrNXR1UHpyZmNYYVhz?=
 =?utf-8?B?QU5wNGlnalA4WWRlV0hRMSs5UDh3RWE0THNNOWIvbjhPY2YyZGNjUmlnZHRQ?=
 =?utf-8?B?bEI1QXhuaHkyaWp0aW0xdDNmNHJvVkZsYzU2Nm9DSk5IN1MvamZEcXh6enpu?=
 =?utf-8?B?eld2TGRsQTB2bUhTQWdBemtXTFp2dWZkK21Oamo5UXZyMjlsdEdMRVY5UDk4?=
 =?utf-8?B?U2JmV2hEOFp6SDIyM25oYlNGNndXdktqR1lDTHhSc0QxbFdXbTlKanpZb0hn?=
 =?utf-8?B?NEFRN2ZSdnhxb2UvOXdQWEZzZUllSnZZVEdsNVhCenJoNVZyKzRvaG9BNUlh?=
 =?utf-8?B?cm42eGF2a1gveVF3eko2OWgxdnhSb1F1bHlFU3BjT1pzZVZuckdLNTZOQmZp?=
 =?utf-8?B?dHkwM09Pa1dsd0VjYVc0b0Z1K25nZUhjMm4xelprWHJRNC9WeVVXTTJpWGEr?=
 =?utf-8?B?eHoyUlpSbFVVVVk5YS9GbENMOHFFRzVjL0VmbkZuK2V0OGZQekhzalgrNW9q?=
 =?utf-8?B?SlJ5TTI0L3E0dktQSEoyL1g2U3oxckIzVU5WaHFPVFhzRVVLcUt6RXVqSG5Q?=
 =?utf-8?B?TzNVRVZjSkJjd0hPQlZvZ2J4Ni9oY1hpdnZCejkxZ2pyMkg0SDNJSVNKZUUw?=
 =?utf-8?B?SGlYMTNyZnFQZW4yWlV3a1pwVEtxcTU2SUlSM1lUTUIvOE9ob0JWSGMrdW56?=
 =?utf-8?B?Zzd3U1psRVlkclhpNmNWb2Fpa2Nqc0FYcGtlbFNqcjh3RmZKeEo5d1hVejY1?=
 =?utf-8?B?dDVIdnJ0VElKNVd6ek9hTFAxNFRnRmlUZFd4VG9qM01LNmpJKzRtTVJSQXho?=
 =?utf-8?Q?azSZcBhRA6gerLyc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67426b63-ea4c-42cd-f66c-08de70d8e44c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 23:36:37.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSG0LiKv4JFJECCHkxflhm5rdTe/wuuaBScGK9hFFt9+AOalCUfZEPYGbEJEPDk9XA0zoSImaVqDCz4FpSHwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217605-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,lstrano-desk.jf.intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8CD8A16B68E
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:36:52PM +0100, Michal Wajdeczko wrote:
> 
> 
> On 2/19/2026 7:06 PM, Zhanjun Dong wrote:
> > In GuC submit fini, forcefully tear down any exec queues by disabling
> > CTs, stopping the scheduler (which cleans up lost G2H), killing all
> > remaining queues, and resuming scheduling to allow any remaining cleanup
> > actions to complete and signal any remaining fences.
> > 
> > Split guc_submit_fini into device related and software only part. Using
> > device-managed and drm-managed action guarantees the correct ordering of
> > cleanup.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > history:
> > v4:
> >  - Split guc_submit_fini into 2 parts, device related by devm and software
> >    only part by drmm
> > v3:
> >  - Add page fault fix
> > v2:
> >  - Fix VF failure (CI)
> > ---
> >  drivers/gpu/drm/xe/xe_guc.c        | 18 +++++++++--
> >  drivers/gpu/drm/xe/xe_guc.h        |  1 +
> >  drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
> >  3 files changed, 55 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > index cbbb4d665b8f..f59ae602b8ed 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > @@ -1402,15 +1402,29 @@ int xe_guc_enable_communication(struct xe_guc *guc)
> >  	return 0;
> >  }
> >  
> > -int xe_guc_suspend(struct xe_guc *guc)
> 
> can you add kernel-doc for this new function?
> 
> > +int xe_guc_softreset(struct xe_guc *guc)
> >  {
> > -	struct xe_gt *gt = guc_to_gt(guc);
> >  	u32 action[] = {
> >  		XE_GUC_ACTION_CLIENT_SOFT_RESET,
> >  	};
> >  	int ret;
> >  
> > +	if (!xe_uc_fw_is_running(&guc->fw))
> > +		return 0;
> > +
> >  	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +int xe_guc_suspend(struct xe_guc *guc)
> > +{
> > +	struct xe_gt *gt = guc_to_gt(guc);
> > +	int ret;
> > +
> > +	ret = xe_guc_softreset(guc);
> >  	if (ret) {
> >  		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
> >  		return ret;
> > diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> > index 66e7edc70ed9..02514914f404 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.h
> > +++ b/drivers/gpu/drm/xe/xe_guc.h
> > @@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
> >  void xe_guc_runtime_suspend(struct xe_guc *guc);
> >  void xe_guc_runtime_resume(struct xe_guc *guc);
> >  int xe_guc_suspend(struct xe_guc *guc);
> > +int xe_guc_softreset(struct xe_guc *guc);
> >  void xe_guc_notify(struct xe_guc *guc);
> >  int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
> >  int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index 42712acf2ec2..bfb176c201c7 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -47,6 +47,8 @@
> >  
> >  #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
> >  
> > +static int __xe_guc_submit_reset_prepare(struct xe_guc *guc);
> > +
> >  static struct xe_guc *
> >  exec_queue_to_guc(struct xe_exec_queue *q)
> >  {
> > @@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
> >  		 EXEC_QUEUE_STATE_BANNED));
> >  }
> >  
> > -static void guc_submit_fini(struct drm_device *drm, void *arg)
> > +static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
> >  {
> >  	struct xe_guc *guc = arg;
> >  	struct xe_device *xe = guc_to_xe(guc);
> > @@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
> >  	xa_destroy(&guc->submission_state.exec_queue_lookup);
> >  }
> >  
> > +static void guc_submit_fini(void *arg)
> > +{
> > +	struct xe_guc *guc = arg;
> > +
> > +	/* Forcefully kill any remaining exec queues */
> > +	xe_guc_ct_stop(&guc->ct);
> 
> it still looks weird that this GuC sub-component touches other GuC sub-components in its own unwind
> 

I'll admit this is pretty terrible. A lot of the GuC init, reset, and
teardown flows were copied from i915, and we haven’t invested in
cleaning up any of it. I’m unsure whether a Fixes patch is the right
time or place to debate this, though.

We need someone to step up and commit to refactoring all of this and
cleaning it up, as it’s currently held together by duct tape. I’d say
start by getting this stable — in particular, the wedge fix in this
patch is critical, because if our device wedges it can take down the OS.
This needs to go into any OEM tree for PTL, and then we should find an
owner to clean this up properly.

> maybe all this should be done in devm action added in the xe_guc_init_post_hwconfig() ?
> 

That doesn't seem right either, as it exposes us to submission not
tearing itself down if a later step of xe_guc_init_post_hwconfig()
fails. That’s probably fine for now, but a subtle change in the future
could break it.

Matt

> > +	__xe_guc_submit_reset_prepare(guc);
> > +	xe_guc_softreset(guc);
> > +	xe_guc_submit_stop(guc);
> > +	xe_uc_fw_sanitize(&guc->fw);
> > +	xe_guc_submit_pause_abort(guc);
> > +}
> > +
> >  static void guc_submit_wedged_fini(void *arg)
> >  {
> >  	struct xe_guc *guc = arg;
> > @@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
> >  
> >  	guc->submission_state.initialized = true;
> >  
> > -	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
> > +	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
> >  }
> >  
> >  /*
> > @@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
> >  static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >  {
> >  	struct xe_gpu_scheduler *sched = &q->guc->sched;
> > +	bool do_destroy = false;
> >  
> >  	/* Stop scheduling + flush any DRM scheduler operations */
> >  	xe_sched_submission_stop(sched);
> > @@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >  	/* Clean up lost G2H + reset engine state */
> >  	if (exec_queue_registered(q)) {
> >  		if (exec_queue_destroyed(q))
> > -			__guc_exec_queue_destroy(guc, q);
> > +			do_destroy = true;
> >  	}
> >  	if (q->guc->suspend_pending) {
> >  		set_exec_queue_suspended(q);
> > @@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >  			xe_guc_exec_queue_trigger_cleanup(q);
> >  		}
> >  	}
> > +
> > +	if (do_destroy)
> > +		__guc_exec_queue_destroy(guc, q);
> >  }
> >  
> > -int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> > +static int __xe_guc_submit_reset_prepare(struct xe_guc *guc)
> 
> as this function is now static, it doesn't need to have xe_ prefix, let it be:
> 
>    static int guc_submit_reset_prepare(struct xe_guc *guc)
> 
> >  {
> >  	int ret;
> >  
> > -	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> > -		return 0;
> > -
> > -	if (!guc->submission_state.initialized)
> > -		return 0;
> > -
> >  	/*
> >  	 * Using an atomic here rather than submission_state.lock as this
> >  	 * function can be called while holding the CT lock (engine reset
> > @@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> >  	return ret;
> >  }
> >  
> > +int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> > +{
> > +	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> > +		return 0;
> > +
> > +	if (!guc->submission_state.initialized)
> > +		return 0;
> > +
> > +	return __xe_guc_submit_reset_prepare(guc);
> > +}
> > +
> >  void xe_guc_submit_reset_wait(struct xe_guc *guc)
> >  {
> >  	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
> 

