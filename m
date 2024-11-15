Return-Path: <stable+bounces-93596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27879CF538
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AE31F29F3A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77F1E231C;
	Fri, 15 Nov 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP5EOj7Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE261E103B;
	Fri, 15 Nov 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700104; cv=fail; b=lXGYMoKhtqUkP/YqbYRO32EqMoPnSaxX+8jB7BeRQ5HhgZiczW2zm4C9u8bM6mc6dSGb/fb3nlxyXXMpLHAFnQTexWFsz2wUSy4eXTHCa7KCAMGUwKtqFAGxJRcc/OsBzQn2Jj3SGlP9D2642GKfpyqGC68upX1zAXj2QD8PyyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700104; c=relaxed/simple;
	bh=VW086kpW1Tca9e3a2ELef6UaBpO4zKC3FhrsmBx3b6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C5OIaXwEGHd28S4AqiQIa6ItKXF1NcCIpv/euYgAOnuttp6ceCqX5iyGp6mfFOyh1MopYf/guPognMElC7jIylZOo9LuTiSE8WlSBbFTcIB4DyR4A60TnvNAlzQpls+brleVX3eK+cps6efeCIc2U3xpmK8OaVNokImh1Db++eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP5EOj7Y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731700103; x=1763236103;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VW086kpW1Tca9e3a2ELef6UaBpO4zKC3FhrsmBx3b6Q=;
  b=bP5EOj7YUQptJRe04QnLpNhpq/WnTFHjB8OKFQXGh3cYgogpmNo6/O9S
   +7BJ2nMOFVdTYOvP2P2uJAJ5UqNeSOLkhK1Wku42/npCRLlqZFEFLRuYs
   YX3XkJNuSJQHufECuYYvhi5HSfVfVZtbEkdi6YbUsNIeZTxlUvHb8zXK0
   mivJ+/YGabkKYyETYvDmCW6y2x0759xXXixg1ZLcyCpRoOpQS7MoHbuMf
   JMt1jp4fe5QNv7B3foYm/G8Elksr2tBzNUhd7i26kHpLplomXUKhiUxOY
   MwYn0ug69Lcj3cvRf45VuZN7QxTrfGBfoRCSrK+xzfpt/dPuk7CxyUvvg
   w==;
X-CSE-ConnectionGUID: +dBh5LllQc+ZRuv8RZJnCg==
X-CSE-MsgGUID: ZGth6Sv7TNe63FxQ36khfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="42353562"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="42353562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 11:48:21 -0800
X-CSE-ConnectionGUID: SedDR47qRCmeu4sOzqXQwA==
X-CSE-MsgGUID: JBmlNDYRR9uHFm8Sfgl1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="93740982"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 11:48:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 11:48:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 11:48:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 11:48:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLv9Lk2mMAWIHEPU4lVyYvdfGbmtrLrW/WQyJH5dyzmgzfEYFIh991OkgNplwDPMnKyhjrezKNlWeipEjO/driHndqgLdpjEknLSIUnqye4pgbJrJr0dNj31gqpq+NW/L4n0cBNTdB2xndbRBVPg5oH5+g4+ihHsVVMAxuVWNuQn5Xozj+uk9OTaYtWhnbKqpiubSx+vO+TzSAjD6fzeVwLHlgppYOazlT7b985JiUySr9Dgf9QTG6L4PjDsQCWJZsBmlHBMfTVHQ756xv4BTPXclSxQgRPZPZuS6hHn/pOHq4+ar3Nnuu2q1mklooEfixF1HdlwkSiD3T1kHbDQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiyWOU7yaLjUlcdWh8tL0HNKlUFNbkklQNz/7kQcHwg=;
 b=LEMAgb4B9xSLS1JU+RoU3D1xb67qgkn56PcB76Mh4yVJGf3T2jpXkmrZ1Ye9tL2ViSFJwZu0owRvvnC/UEUENrYapPyCbah8loFV2cCjFI3/iphXQxJOC1qV7VFK+bgWPBu4pcWP1eaV1XUlXHjeF2FFFBgNXaMsg6enO9zPZZxQ/IalDmWoBBUli6+8zrk1oX/1dY0FebXiaLeKY37eVNH/bKYljkUrtSErbLzl3PG6zNk/lHgzR41WgKJusDGdZAdy483ioISS7G7BjzNGcxIFKHAPxShomSglmZaUM+/258Rf5SXDV6RL9szhlciyp7o5jWNTqdiIO0SKqxy1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 19:48:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:48:17 +0000
Date: Fri, 15 Nov 2024 13:48:09 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Robert Richter
	<rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Ben Widawsky
	<bwidawsk@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Sasha Levin
	<sashal@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Yanfei Xu <yanfei.xu@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-cxl@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH stable 6.1.y] cxl/pci: fix error code in
 __cxl_hdm_decode_init()
Message-ID: <6737a579e0bd8_29946a294c5@iweiny-mobl.notmuch>
References: <380871e1-e048-459a-adc5-cfbb6e5d5b94@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <380871e1-e048-459a-adc5-cfbb6e5d5b94@stanley.mountain>
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: a07ab778-9e91-4113-c69e-08dd05ae7177
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Tj8DzlwdRV5jgXxv6M5InCiTsdWTqOj8pT2VrKsxzjWpT7F4XmcZGPAz95F?=
 =?us-ascii?Q?JaUXjh2f5n43LFdiRloHPhwH/FoWiuK0yS7KNFnKUmQpvZV1eFDbZhe7iWMV?=
 =?us-ascii?Q?8Pk2s3WokDLdIhFZdeanMX5u+9I+qdz0qI2NHBO9NpNZaoQomXern4lL+Ka5?=
 =?us-ascii?Q?oHfm4kneDWC2JayQ42eXDalzkbOhPLpE0KVRnMwIMdLiUURYmL5Bzz7Zrnsq?=
 =?us-ascii?Q?CCYlMG6rNTaFMIZBcsUYRaJbypIulVOJoFq74Xrhaj+uBgUxn24oqJeJXjJN?=
 =?us-ascii?Q?HZBoH+DQEl5GBHxIca22eQRQugCkXUmEznG0vL1IGV95z7mTu53kwz7PG4XK?=
 =?us-ascii?Q?vVz1wKM6hopvk8pTfsKpsGMFfuXDOfhI+RAyePRBLhWZOv0z4o13f+WDt5oC?=
 =?us-ascii?Q?dXy+xGai3YjJ35I79n1+Vt3Qygz8ZXLGoFoJtVePzF6okRI7XMY6AHTjTR8D?=
 =?us-ascii?Q?mtplJUiLAFBufZbGbmpJrWlCIZHVZ1ltnIipwgoQ3eTLTFhaqerAys9Hu9VM?=
 =?us-ascii?Q?xMbxDHgxCODgxte4JJtY2JLSJV8Sg0qtcAqYy9wL2+Nuw7aeiURFueNCCgG7?=
 =?us-ascii?Q?3BqTU0k6eSsvRQPWwugPw0SbtcccF0xrgtFjaemkKH1OIUin1BfRKvo0RNM3?=
 =?us-ascii?Q?W9dNn03rLjR9qr5iCiLD5/unUgj5iiJn7wjSZh69zfzJ6+mfzVWFXjxdKVta?=
 =?us-ascii?Q?YeA2xKwt1rmga1eoSrLA9GcfIbmmtQFpW8/WjlRsEci6/9vxID8htLqQqwZC?=
 =?us-ascii?Q?/7nzv4CaoxZOS0oaVZN/r9YW4iDX2lcLcdvnAa91icVYyJZLKH01nq8stGgg?=
 =?us-ascii?Q?DDhxRLTSGzcZkKSvFImwgHO1Z34DdEyUQnyR/brTN3PQ++iqy0Dqp0H8Q8j0?=
 =?us-ascii?Q?MoujiGpx5DMfaTz8Xsc/THgnRnCf7xru1Xb4+9NpAJ3Lqa4aaJPjbVn0PG6S?=
 =?us-ascii?Q?77AtJY4E3F4e4QBHcOlGhii2UnI27gypENU879Tuc8NWLNOJNcNwSYGHNaVa?=
 =?us-ascii?Q?GGuCezYw1uWBRJ1QEinDm/yNoBYdruZV7UqXIPWMddePs2aRi0rXUsflJXGT?=
 =?us-ascii?Q?HxBJWU4JYmNCE7HlstzB8ucchzWWqMWF7cFeHo7SvJ6sRy8XUca6Vm7M1+XP?=
 =?us-ascii?Q?0yzZkvGR997IHzWlcT7QKvwOVX+a5OdWTy0f/ZxEEOK1P6oJ+RhXkoP5V5oZ?=
 =?us-ascii?Q?6RKVJrLlZ1+uC3JI+t190YCGXmxtmqh3tz8yPv+OU1Yec4zYhIKR4qX+dvum?=
 =?us-ascii?Q?Ud1BdsYDUPOsY1un5me0KgYnZazvmQq0WfdboqMJSbd1rMIrfRmT1yMVhNNF?=
 =?us-ascii?Q?1y4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFbjGMQbclyAKK0YlFovX/4F5WkjBS63+wrSUCgUw7PaxhbTSzxEZLowQbZT?=
 =?us-ascii?Q?oJuzVwXwdoMgInV0GmCXYiMlOQyw5fmvPT/zBkdpWIWM0JSpLx264A1OYXo/?=
 =?us-ascii?Q?i7Le+J/r0caOk9SfHEL6bo26NaU3nf66DBNxeMmC2zfdoKCfJfExDu99m2uU?=
 =?us-ascii?Q?tjSvveTrqvynjjAARmuRAVaHwh5G+y9/W7dplpz9hiu/2zODmDdaKlShEoJH?=
 =?us-ascii?Q?+JqOoHEwl0kqj9XgKMMRjm9qVLj2EBXd+cRxBCFZRzIZusfWb3Wkbp5DmuNd?=
 =?us-ascii?Q?HOJlPqZfSbz4AeiQXR40B8ogvjvYSyLl+oYVosx5atmJNC5gG4Z7dHER/wgN?=
 =?us-ascii?Q?+LUgmbr7he+oak6vcV4VJMwxsExXV5MR9O9tCn1f18o/oKUnkE9sbQ38VX8D?=
 =?us-ascii?Q?Gb93PJuapedAXz6xH2o6/JWFP2LGiqzN2pcpvDXmxbQhXjr9fSG5Q8bJC09G?=
 =?us-ascii?Q?JRMC4GEZKvdXXGcGz3SSc6JTTPVuVlBmp8bIdH/iuC3DzVIthYOUm1b5GNPk?=
 =?us-ascii?Q?b6X4UuvZ8XC8P6Xg7+lFKDlheU/Xv3ygKv4RW/HkIqYMv+Mda73D62N8C31h?=
 =?us-ascii?Q?sLR8SKp6N4PmuclVrlrkerVUxGsDS7ZA8KB8hUd8G2YkLbbwB23MY9EwcXQQ?=
 =?us-ascii?Q?9AyBminDKv+c82H977+9Sl5YPey5mKxqfKsDXGpj3RgBaqBGKq1eYx8C29E8?=
 =?us-ascii?Q?Cred5RPb7I2yQW9uN3B2xUWi8dyQnqeOCS7bAIdv0DG//d5rOWYxTE8TiGMi?=
 =?us-ascii?Q?nYaYLLZTg6eaz0KuTzo7VSjzoovyDr4l10Cg0qv0qlY5yHyA3mqN8fjv/jwY?=
 =?us-ascii?Q?W4469cyGnqY43+d7rgZJ6+XMsTeIy8i2/ZeEN9TVq73idmmFWsgGxljVU9N0?=
 =?us-ascii?Q?KTySHQ/B9fvTmJUIQoHHHz7zWUcwxv0kvHNFMcB3yHFnoQyMrOVMv/z3qOEX?=
 =?us-ascii?Q?83B10AXa4ObJazbk47fQrfh3hxsS1prmSP/w5Ujfihm5B3S0hMatHfnfz9CJ?=
 =?us-ascii?Q?IKxumq2y1NQ/FbVvozBBW5fw99YyP65jjdbYrtC7E4OzM9+xru3ZwIEip2pB?=
 =?us-ascii?Q?OJHK+VsK1DAFx7MuOVvXsWAS0I8D+dVBqmU4OfI0yKk+a3PTHe0j0ZNb9Qvv?=
 =?us-ascii?Q?X9VaGEGoRTP0zcRbBX+k5Kjbvpc/v1KYldlp5q0LI5ZAhoaHdzLfXCJ+H1SP?=
 =?us-ascii?Q?7Uv+cqVROzO3IYoRrE2wBG1PwlaQuAPo6C8FRXdqmRGqAOSVXk48BgG+owLq?=
 =?us-ascii?Q?A3lsvWLrhaAlMeKE8ykBR6PWRX1iUNmWvPM5tWATuLKFDbbaniISXmNGcmJm?=
 =?us-ascii?Q?TDxiZlsYDaEvLd/NnyaGzpSfQ2x3Q2dfZj+7EbdAuHmR05/13FpDue+COePg?=
 =?us-ascii?Q?5dgwqdWAZ7/HvEgQrSZe1nZlURc+77zM7BwYz8y2EKn1N0cQp8P19hXAEWo4?=
 =?us-ascii?Q?w4zM53OHXSBVRH/Nmz32U2ELvxeeI1aSRmQYjc+GT6uurnR1oI+iWOB9/dEE?=
 =?us-ascii?Q?CgzhPatDfXyx42sG+IQbuTsMcCTQGsxhpsYKxuMij1f3ntUjB9zva0ftSMSW?=
 =?us-ascii?Q?xR3vbhVPpIERiAkzT7Mfy3gxA2b4+TbM3e6PmDHn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a07ab778-9e91-4113-c69e-08dd05ae7177
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:48:17.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsJ0Gxcc1d1VwsrgUrC3QkAi3/ZOsEBwFF1/zd+mx+LV8Fyq3p9MTQeV/Z6X1Tv6b1Q7f7Yl+4GmyZc//nK/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> When commit 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL
> Range does not match a CFMWS window") was backported, this chunk moved
> from the cxl_hdm_decode_init() function which returns negative error
> codes to the __cxl_hdm_decode_init() function which returns false on
> error.  So the error code needs to be modified from -ENXIO to false.
> 
> This issue only exits in the 6.1.y kernels.  In later kernels negative
> error codes are correct and the driver didn't exist in earlier kernels.
> 
> Fixes: 031217128990 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8d92a24fd73d..97adf9a7ea89 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -377,7 +377,7 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  
>  	if (!allowed && info->mem_enabled) {
>  		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> -		return -ENXIO;
> +		return false;
>  	}
>  
>  	/*
> -- 
> 2.45.2
> 

