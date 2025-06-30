Return-Path: <stable+bounces-158957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBBAEDF66
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06651777CE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F928B3F6;
	Mon, 30 Jun 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0WI3OkR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756C28A738;
	Mon, 30 Jun 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290927; cv=fail; b=sAz5P2i5k2bP0NHm4JNyKj9x4+20wXC+VyuqDQ9FC1+5o/06m1vw8NhnuqOFUlbF+t9tIdTxuodCTTeCYMFNYdGVboCGMxhGW7O3n3HcQj4NcQ3MB8lm6OKxHKkLVTNFDTvi1Fjmvhc7qK2jYmSFN5YzIXtl4htBwCiYRf5z8zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290927; c=relaxed/simple;
	bh=ieTq5YUNeX3BRqyOnqPlWflsFKHTGyQozdCiZlxC1NY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFjWqcOzPTRav5XC3XvwBficvh8omLPQAlaAiMpAwVh0huEx0jrRk2X1MpZ8fxxGwMGV3QYnta3cx9GWtEjpCrOk0wFURXL4WmBu4OHZdSQ4J6qHvS0NNWPq/OQZDh+J4ocTS357wRxrDS05ivH+wei6iepMfQAHsKQdhzyz8EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0WI3OkR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751290926; x=1782826926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ieTq5YUNeX3BRqyOnqPlWflsFKHTGyQozdCiZlxC1NY=;
  b=F0WI3OkR+c6fys7d7qfJ0r0MmxTzDRaJFZTCagnGnRCeRgQHZ2FnlEoE
   GhMIJUULvdbyz95faNOC9DKFL9r48HvN6X5cFeVHrrjYqJDT3qnpiB1kW
   FMdKjWfA6xrXGK8ZP94tZZZUwNBJnYpLQ5xpZ6my68iF8HnEYT69COiMn
   IPEOQaMNTK39JabKzC5w2G01KAYySQvLZBWrTvE8uYaG7IsnBkFz16xvf
   U1Lmoyl1sohqib0gllZ5sETt045+WHcwMULVdWBxnkRjYSfpaz/iGv75k
   72c1ELuzQk66lZ4jGAHXA9PbXEMwH/ePyoc2HK4gOYDg781sY9OxJxLoP
   w==;
X-CSE-ConnectionGUID: j7J8zO4AQ+Sxv29LvqK11Q==
X-CSE-MsgGUID: bOaRETeeTGCQ5Q38rpiDpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="52746409"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52746409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:42:02 -0700
X-CSE-ConnectionGUID: LVtUEwDGT/6IBZdSSAK1Dg==
X-CSE-MsgGUID: 739+LvLaQwCDaGGCoFlsTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="184388203"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:41:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:41:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 06:41:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.88) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4RIuZ48KSDVPQI3EHRBdewg7aA6Vjir0VTV49ciR1boa9RDo7mFx7bjyNi9fvRPgHMPan4kAvI7514REjV2CQrQtsf+UxEDtMR47CgRstPA7u4IFkaEwVMMeqZt0SkyEZjvpxyDMGMpBEu1SbOCNtUJ5f3DXs1SuZFJb4CdyEUNP0HtSdVp7y0/VVIDflCLyh+TXEWI14YPA/XmVPLd02sRn8UgTXNkwUmQEGcPR6EGZ8rwe5RTUGw0vXQ0VU1ghVsz/QmIwKeyMgnL7U7JyksQ33TGmI0lcfPp+dzncuSKbVcqdxXTeZ5xNtoh6EGDX/e8RgH1pzdh61dkbspMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgQzYjJgW5mUtpMQnCs22tDZVSrGc9cl6qKZriEm9Zw=;
 b=wGYfuUd00I1otAA5aUxs4EFEPyaK7BFBfEXKHwy7LiUabxjTydwzSpWTR7NcuIyGYEHvk+YITtiiL+ntiKyFIU0+VMK7EpfCbxiaWW/K6rTjvYkGJ90eUImKF5x/nMl4PfjX20SjHuJ5z83NLEKhM7M+HgGTVpn9gZQC6PjghecEnZlHWbFwodnaCnoM/aKz+va95S73L8JHM2grPlsMOVNwMjJqnr5HJTi6O0ryHtK/O9q6tPURLXLUO/bBtR5UeKJfnlNuYWglVnCzYNqEAmHUBgD+wkn6gJmZuNb+XCjSBSp7+f7MQ9NqL7jC0DGGemZ1xD3Hx6wxdVYW5o1aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 13:41:19 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 13:41:19 +0000
Date: Mon, 30 Jun 2025 15:41:06 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v3 2/3] net: wangxun: revert the adjustment of the
 IRQ vector sequence
Message-ID: <aGKT8gP2D6A5fHy-@soc-5CG4396X81.clients.intel.com>
References: <20250626084804.21044-1-jiawenwu@trustnetic.com>
 <20250626084804.21044-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626084804.21044-3-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a978f0-986e-4daf-9ae2-08ddb7dbcb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6NqpMURbTxzhFs8UvUaaTkPSz6LtBxYmSBco1vS8w1roTQ4oppa4E4UDDX4d?=
 =?us-ascii?Q?GTd57fcQlWRLE9JW1SP+V1gFaJMYf9wTuRADOb2c/MWomnT7S5zJrdz9+8SN?=
 =?us-ascii?Q?cRC4rZmwU5Iipxqyy0lZTHDRoqyRZ5pTxWR8DSfBcSRIf7hRV3wPv1eyyg7T?=
 =?us-ascii?Q?Y71N8sCa5Jv53khMoenL3/VL7RxvtzDfAVBY4PzonGsAi+P4TQL6X37r5qFU?=
 =?us-ascii?Q?VYSnnjAo1jG2ObZn0UUWa6zsJc+TDUMZgS6FenHw/T7/yuqyWwXoKXWizyMl?=
 =?us-ascii?Q?fJQruPw9cf6v/BydiyUDpb0Ze5Sog8jmu3yriz84Iv8nZYbOPD1oIvT/T2Cx?=
 =?us-ascii?Q?/Puw6CTzYX+w/4m6RfohK21gnHqVLqe1fuTGQL0wuxj2vYQgG3hm9bYtu318?=
 =?us-ascii?Q?ESbyH+HKOlNWbnVVnq3fPvLRKJH1jL00ZQbw/+v81M9vwf/45PITE9OXdEim?=
 =?us-ascii?Q?aIX4Wtm2ZgzoDdl82n/2eq9uSKDaP0bvo15H+I15tmJqAlv0RljsEA4116Bd?=
 =?us-ascii?Q?+BTIsPVIGIfCeR9qni1pc3uY8PT6QheBPkRULxPhFEQ48FOxS6DWcV6EPE6B?=
 =?us-ascii?Q?t0qG/qMWd/ARlAaU/VSB4LRe+kf+q2ONT7GeXjcNikIt9Ckh1MWhySgJicTv?=
 =?us-ascii?Q?B5ocYVyO/LXiXkeKNjdNbnwScm8X5KGtS5aVJxKQ1oNRU+5ArM6USJZhDctm?=
 =?us-ascii?Q?/F4o5Yw0XQTtUNu0ANgU0LhXP118cg6TClt/5NaiZUbItx6DQiWDik1TOA/u?=
 =?us-ascii?Q?ChyWo/CcVxD/OZz85PI+xv0K4ZPLQ2jBQyFn6usyiKs0/s3FBxXYh5uKSRbG?=
 =?us-ascii?Q?ViiFyeT51oeK9I2XHdOWR9Q8RgF+wWvhWM9jydyBUdssnBbld0F6uatByoTR?=
 =?us-ascii?Q?tGyyGYHVIm4gMzD9tdB020OHFZrbuk2hRwKXCRb0EalDvJoJ3pO/TiZwDmYW?=
 =?us-ascii?Q?SfJwQ6SRo98fofO8CsIuQ+1qU7vN3as5xSdcsFK4d/9oLKkcJFTLuVXCWUHZ?=
 =?us-ascii?Q?Q53fbXwMfQgli8Rh1RdYTBOpCYt3m2Rpm15+nynpJgSvbKc7k05PD8eid/eQ?=
 =?us-ascii?Q?YhYKAgPa649Y8C5QZNxJVSLa/4dqqdeja6b7ALkRel1RffTaH6JUJqnlGCn9?=
 =?us-ascii?Q?jZy36en4MQeNiFtnZleMixryaQHIAeXXtVUwBIe+y4MBk1/gBD0/1N1nVtre?=
 =?us-ascii?Q?i0tMdvY+ei6m0ndfqWUHNHOt6oQltbzsEhDjkhoutUhNj/e2OAiY3+eOXFCJ?=
 =?us-ascii?Q?5PjOTwca80dhRvR/CyDU/tOYxyVquzHqdMkxYgusGaNb+byA0pnan/h1q0BL?=
 =?us-ascii?Q?VjxA8Jpu7M6EwBUEfpYP5WvyIEwDPNyz86GiqhQtIe8/b0oK6qYWpmNToqUW?=
 =?us-ascii?Q?KatbZPgfTnGOgfhZLVpzq4Ft5WTa/+c4Eae4YX7foFzt3VdO87IermZIAx3p?=
 =?us-ascii?Q?X4ZfISpQL8E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5FIDcb9q0u6bUrnAgNk8HsmjhC7r+2iZdDucuBid6EdWX6TH7Ug1tLLD7fZ?=
 =?us-ascii?Q?y0UTg4CxyOGess5GjDfWnEKAh5NSieuIN6VPjttltd+v3FTo+cT8+yz5mgVn?=
 =?us-ascii?Q?E2i+c8rWCl7rU553lKfu2T4iP6dDxvx7GaOGTJLXtyW9dPZ8glcZnkrKNsQh?=
 =?us-ascii?Q?Qo+ssuY7TBm+eDmgtrObWYpsJc2HAArZX4i5NglO/j+awTXzJTTN8t+KN2tB?=
 =?us-ascii?Q?CxDjXIs/t2OF9+ajbBPcobLVam1/0OOxpemyCrnA7nxa5t0bfgxZDnRiGKKT?=
 =?us-ascii?Q?GwdbV5CfYZQpnPTimHsOdNj/ge9y5BqjrGgGsB4iUP5BcJZedyAM57Jga5oH?=
 =?us-ascii?Q?s3S74YQWXvIL0Zi7P+AM4OyXIp3aeHrrV4gs/4jMbyeGBrLxzi9xyuhj/gBh?=
 =?us-ascii?Q?TKkeT/pmlAEUYqYvqPVtt50/zdGqfyNJ+0ifyJPN4Z/OiMYsrlIWuqNVk3KZ?=
 =?us-ascii?Q?oCImecKIv29fIXtY7PIZtw8n0x3Q1LZLiQ6hg4GVUsqQhwYO53qr+2P9920H?=
 =?us-ascii?Q?0KX4zcokIpQ/dFS8ni/s0t6ISw59K8rtsfVZWUfZl6Q5iIkBph2Cl9rmSszV?=
 =?us-ascii?Q?FpoEK8/dfAJDD8uas2d9E7Gr0X0TaypY6RtioLa1FHLDBKkOFoMnhQEMEA1K?=
 =?us-ascii?Q?AWm0Yv3G1USdvUcUy+4Sf8zcGcI8oW/vZopTYyWkfbZs99QJQtvBxyhMPPlp?=
 =?us-ascii?Q?l1bGEbIBD9y+GbPnN2WxXdTJ7TmUpNTxCedtkz3/zST76HVmZtHuCsRL38lb?=
 =?us-ascii?Q?dfxIWYQMI1Vck6fk23VBIQQz8qU8SctMpUfnTiHNEB5TO2taVeR97t26FndY?=
 =?us-ascii?Q?Www4wjIBRLmOYmjRN+LGG2+F/MOIJNuoTfJHqT5CsQRFtM6x+l0c9zeEr8/B?=
 =?us-ascii?Q?P5Rn6Hfi/fH4sJhDQkUelq3b2+xuPdVC+rqYNhb73jiHtE138tO/9e+FH81T?=
 =?us-ascii?Q?E3nJcmkGUUejL20OCE4liJXhH3v1Im6YXFqOATVp49GrsjUEjZtILIl5B1Pm?=
 =?us-ascii?Q?xKT5wCeLW65v6jPw9ebcxmHdyanZcLnHU59opdfL2tZmI6Ivd3tWX09Qb0YP?=
 =?us-ascii?Q?ruOrmhJkBk1K5eYfuokijV14A7StppfJt1CasMpPZF/QOFXI6fKCE1mwlHgi?=
 =?us-ascii?Q?aBR8TYc0RWGB36mVuSlEYrm+O+3SSmRA6kCkbTrIEFDxOu+w6LMwH2uZYYzO?=
 =?us-ascii?Q?WwhYXZO6RPhrqkniaV7wBzxe5yM7d7u3QK9XBM5B8Tvj6cTEkmD6jC1nRnYf?=
 =?us-ascii?Q?ptwt9gRqIgnkIGmg97sT7Tv/RplbyoBRp1Kc7jtcdjwI7I8prwsniM0t3QZv?=
 =?us-ascii?Q?++Q5w8YJfmbf2KNuty0r3qRhL+h/8I0FvWuMF1yskLraQ1LMeoMkn7x9U9XZ?=
 =?us-ascii?Q?33i+p/TO4djHA53Gr6cfquOpIDwDMG0ptGAZ9/t1pR4mbkEEVGmD+QeWIsED?=
 =?us-ascii?Q?uVwVSzoFLfeaEyBfNVO2POHERKCpSphfmFxyTTGlMWEIlOqTB4XlSwBbr7Su?=
 =?us-ascii?Q?nfL6QYlROgydR/5bU3u8ganBx+bSFGEFIxOM0R13ELcZxI/81RpUgKzTCKgd?=
 =?us-ascii?Q?3JxlsK3R1a6UXPe654CW1B0KgPZ6+NPthOMh3cP37OuIJpF811CF1o+xMXiE?=
 =?us-ascii?Q?PErwnczLLbNFI4HZ5Wz/hRPIn5+XV9iuEHHGhSINoK5ouSvilQHrX8kDgJvj?=
 =?us-ascii?Q?5r6pSg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a978f0-986e-4daf-9ae2-08ddb7dbcb07
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:41:19.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14H2x30US03RB9BCzvaG/fot08gBX0RaD0jJDlPLRhH9bD0AC91HbsMmmmWo9noWA6wkxP43furFrvQaGdCyf2paTlftQFPAlH4HW4Mq6WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com

On Thu, Jun 26, 2025 at 04:48:03PM +0800, Jiawen Wu wrote:
> Due to hardware limitations of NGBE, queue IRQs can only be requested
> on vector 0 to 7. When the number of queues is set to the maximum 8,
> the PCI IRQ vectors are allocated from 0 to 8. The vector 0 is used by
> MISC interrupt, and althrough the vector 8 is used by queue interrupt,
> it is unable to receive packets. This will cause some packets to be
> dropped when RSS is enabled and they are assigned to queue 8.
> 
> So revert the adjustment of the MISC IRQ location, to make it be the
> last one in IRQ vectors.
> 
> Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 17 ++++++++---------
>  drivers/net/ethernet/wangxun/libwx/wx_type.h    |  2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   |  2 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c  |  6 +++---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  4 ++--
>  6 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 7f2e6cddfeb1..66eaf5446115 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1746,7 +1746,7 @@ static void wx_set_num_queues(struct wx *wx)
>   */
>  static int wx_acquire_msix_vectors(struct wx *wx)
>  {
> -	struct irq_affinity affd = { .pre_vectors = 1 };
> +	struct irq_affinity affd = { .post_vectors = 1 };
>  	int nvecs, i;
>  
>  	/* We start by asking for one vector per queue pair */
> @@ -1783,16 +1783,17 @@ static int wx_acquire_msix_vectors(struct wx *wx)
>  		return nvecs;
>  	}
>  
> -	wx->msix_entry->entry = 0;
> -	wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
>  	nvecs -= 1;
>  	for (i = 0; i < nvecs; i++) {
>  		wx->msix_q_entries[i].entry = i;
> -		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
> +		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i);
>  	}
>  
>  	wx->num_q_vectors = nvecs;
>  
> +	wx->msix_entry->entry = nvecs;
> +	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
> +
>  	return 0;
>  }
>  
> @@ -2299,8 +2300,6 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
>  		wr32(wx, WX_PX_MISC_IVAR, ivar);
>  	} else {
>  		/* tx or rx causes */
> -		if (!(wx->mac.type == wx_mac_em && wx->num_vfs == 7))
> -			msix_vector += 1; /* offset for queue vectors */
>  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
>  		index = ((16 * (queue & 1)) + (8 * direction));
>  		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
> @@ -2339,7 +2338,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
>  
>  	itr_reg |= WX_PX_ITR_CNT_WDIS;
>  
> -	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
> +	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
>  }
>  
>  /**
> @@ -2392,9 +2391,9 @@ void wx_configure_vectors(struct wx *wx)
>  		wx_write_eitr(q_vector);
>  	}
>  
> -	wx_set_ivar(wx, -1, 0, 0);
> +	wx_set_ivar(wx, -1, 0, v_idx);
>  	if (pdev->msix_enabled)
> -		wr32(wx, WX_PX_ITR(0), 1950);
> +		wr32(wx, WX_PX_ITR(v_idx), 1950);
>  }
>  EXPORT_SYMBOL(wx_configure_vectors);
>  
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 7730c9fc3e02..d392394791b3 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1343,7 +1343,7 @@ struct wx {
>  };
>  
>  #define WX_INTR_ALL (~0ULL)
> -#define WX_INTR_Q(i) BIT((i) + 1)
> +#define WX_INTR_Q(i) BIT((i))
>  
>  /* register operations */
>  #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index b5022c49dc5e..68415a7ef12f 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -161,7 +161,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
>  	if (queues)
>  		wx_intr_enable(wx, NGBE_INTR_ALL);
>  	else
> -		wx_intr_enable(wx, NGBE_INTR_MISC);
> +		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index bb74263f0498..6eca6de475f7 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -87,7 +87,7 @@
>  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
>  
>  #define NGBE_INTR_ALL				0x1FF
> -#define NGBE_INTR_MISC				BIT(0)
> +#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
>  
>  #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
>  #define NGBE_CFG_LAN_SPEED			0x14440
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index dc468053bdf8..3885283681ec 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -31,7 +31,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
>  	wr32(wx, WX_PX_MISC_IEN, misc_ien);
>  
>  	/* unmask interrupt */
> -	wx_intr_enable(wx, TXGBE_INTR_MISC);
> +	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
>  	if (queues)
>  		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
>  }
> @@ -131,7 +131,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
>  		txgbe->eicr = eicr;
>  		if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
>  			wx_msg_task(txgbe->wx);
> -			wx_intr_enable(wx, TXGBE_INTR_MISC);
> +			wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
>  		}
>  		return IRQ_WAKE_THREAD;
>  	}
> @@ -183,7 +183,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
>  		nhandled++;
>  	}
>  
> -	wx_intr_enable(wx, TXGBE_INTR_MISC);
> +	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
>  	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
>  }
>  
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 42ec815159e8..41915d7dd372 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -302,8 +302,8 @@ struct txgbe_fdir_filter {
>  #define TXGBE_DEFAULT_RX_WORK           128
>  #endif
>  
> -#define TXGBE_INTR_MISC       BIT(0)
> -#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
> +#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
> +#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
>  
>  #define TXGBE_MAX_EITR        GENMASK(11, 3)
>  
> -- 
> 2.48.1
> 
> 

