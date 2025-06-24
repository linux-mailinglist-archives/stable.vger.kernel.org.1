Return-Path: <stable+bounces-158444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FEAE6DD6
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC337A7D81
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB727AC3E;
	Tue, 24 Jun 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyZXxAJ+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE0126C05
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787302; cv=fail; b=AZGm5WTM6UI3UWsODNphkf4HTwKUEgCJ3LyMCMqIUmdzqLg4q+BgtgFgbXAnJR1vUp/yJwybhs4Av/8Y4IWiDzJMJr3zHLIbMKQ5K21BzwkfRLzVc23dDGEED+YqagpdydsVGYgrPo5P8X7490dz9XHmPwJQfp9lsop5Xo/RKVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787302; c=relaxed/simple;
	bh=dBJ6AY/PExN5kFAFvIIAmtsOomsgsWVXZ+PFaauGv8U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nTLfMRJt8Gz3g2qtrDRXxjjx6p1BE2/zoeeIk35HHXhlIo5MWWiEh1Evhfp9Ew01/FXlbrAoIoPm7uA4MIIxd4cWszeE/IKKbJm+uLI4jFKW1XamEJsSXHMLi0//J6buJXr3RxPnYxcyKvKe1y6yvdlWTRP8NlDQBwGJx08scNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyZXxAJ+; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750787301; x=1782323301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dBJ6AY/PExN5kFAFvIIAmtsOomsgsWVXZ+PFaauGv8U=;
  b=WyZXxAJ+CsmLid6CzMJOHHGO40Nm4CvHc82u7CgIksVi3oHnwlg3H55l
   WEwC6lGZaVq+pciIAaUHbPSQbq/FEfm3lFACdxwpGbKqghET4qfi3r3zL
   vSmZcs3ZyuvEaWnyzHCb3R/oj1fQXLgXQ6vj7q7OPfemHIVzkPgJvZE43
   IlzdbNBZnOCloidIiaLgS9EkYrXaElDP1Ng4PbPhAYtTNaU1nfQ3bia0A
   h0AgSfCZ2tn1EYK9L6IsPWJ0+08ShvfLQTqqyyY+go6yfdr9XW6WoMaF7
   1NXEFeOEJiCLU2GcPKjGLqyaIoLc2nh39ORvE3p0HOZ54rORH9RoAbd4N
   w==;
X-CSE-ConnectionGUID: hvQG8smMQJe/jPPM0eKoxQ==
X-CSE-MsgGUID: WH5Pv5kMRRyZzHqh5yH5Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63731976"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="63731976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 10:48:20 -0700
X-CSE-ConnectionGUID: IPxw2+24S2idLocgj9D33A==
X-CSE-MsgGUID: voVyOR3XSGSegNLmyH5uJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="156555441"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 10:48:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 10:48:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 10:48:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 10:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt0MEOeI9cDgK7CQ2KpMG8V2lznLkMNqLG+jWBtOSNOvk9QcAse9XywB8DqVvHue5MCXLCYj7BWWo5eKPlefBdlyZQ4Wdb2U82USxBrJwMiz5TBGLEgoXcAe209OXzJ6YJTUwSAnKVvrgzo4YfNdEu4IT2TqwI3yolAPGpboTupe0WWC/DuR4i/5bM+nPIEbU00lYMY5XpaTL11wAy6dNXySj4o04aqCQvIKnmdG0RLfLUNrLCLvlQXtCziwSy8vNZmS8hPxM0tqvLd/wWA7Ek4JSdxxqoUNjA+qtTs+88dx9GVIiKh4+cU7Cl9ymnWY2qdPXhfhp59+KjJXEmUv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEPBQHfrX12Bq+ANyCNx5hTl8cWVhpan2Sikhuj2xzI=;
 b=rY3XzhCjb0wyvpoTf0m1+33s0R0L3w4NG4j2MI3TDu27ZtElFX0KT6AthnhofSIsKZhqJmMt1QOtCl9of9zzflswVUkzrP3zVIgCeHiEpKd9KbXSylq+K8FZpFi+p/dJbUD6qKThM9L7TgO03tCr0z+ly6+dOC8PlQ7AheOjnDpDg6TFsdJ8x+NU+DOy7mxAvAS+4D8shhFhpwYRPnuRjAYF/te7u9tq5vppvIQkXx1buEwuFDSDm4RN121EI89FcmSc5bROxLKPsUszf0FLUj4mAlQEqxmH4RRkzPIoypNbPkiSOaVT50Dq0Qsw472IInyjimoEipZbeJJAGk6EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 17:47:58 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 17:47:58 +0000
Date: Tue, 24 Jun 2025 12:47:53 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe: Move DSB l2 flush to a more sensible place
Message-ID: <jxdnjj4oxkncs3b2g44y43p5mvckgzolaqgnxn44klvygvtybp@in7kev22zlfo>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
 <mmey6jwpnnwamwrj2trxzpre7j4jswrhjsisuqvx6d6knjbuv4@ddc6co4xn7ec>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <mmey6jwpnnwamwrj2trxzpre7j4jswrhjsisuqvx6d6knjbuv4@ddc6co4xn7ec>
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0e5d67-2bea-41cc-33c0-08ddb34741ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtOp8BEDkXk/3cbvzVCFZQP/opfbrKkbE923gY8UfSBdvIqEDdRS7dZaElmQ?=
 =?us-ascii?Q?GqFAru58o6IhNPEPzCUdyGk2SbxZJvkJbpEsoL79r8cRD+S41QBRy4Qh3erM?=
 =?us-ascii?Q?00n1dFhqEwMg4MBPQpJZKLyaz0mZDgYZkWgJPzK+kVdAuBdSs5APcvbKwsEo?=
 =?us-ascii?Q?JOwrdoKDBLyWXtDgUeRD7rYPEjTmjjbvIUuHNJWjYGgNJNX5dHVPrqqhJW1B?=
 =?us-ascii?Q?H4rD7A6Pg0qQ4vYQbPS838J4jwpWtpZ+lbTt+L9ZHPAUuZpTSBugIJRhpOSt?=
 =?us-ascii?Q?v4h7AOOMlkYAEEwEOefAfH6G1wq9pHuuUJOTxydaMRU/uCDqOGA3G8204FxO?=
 =?us-ascii?Q?3Q5KKAQFrC+UarJuHSq8c+g9IglQjoQpLwtWR3+yTlJJV6RsnsoyrfcdmX0a?=
 =?us-ascii?Q?n9oDUZtYiV902SOoYoEH7TGQUw2x5Omz2iAeY+JPeP8yCEDa7jN29xXVZ0F4?=
 =?us-ascii?Q?QLGYy/2r2bW/iVCzt4svmJbVInlKGrZPbgbTx/Z8Ij/fcJ/eiofORlCLnhJb?=
 =?us-ascii?Q?RzFd/fhBKgsvPTlT4EBOTaC12Idbee3UVM6cLYVk5rVLzyZHI22jV+afNCoj?=
 =?us-ascii?Q?QUx8wX9SP1pyURjCmdMcEh+QlyhL13k4dEFfcuKia/rYlOXjCddJQBSWCsL3?=
 =?us-ascii?Q?D15bFEX3MZxOu2BYAoSjsjbhiF18LiDYBJuzT7M1Pzs9PLkeWmz6iv8sMCad?=
 =?us-ascii?Q?75McsCg3TY2BqI06CB+f3D/ZlCQ9CoJSgO8meJVLtzywpQkG9Fp3Spd0WqgJ?=
 =?us-ascii?Q?ReanM1CE6QN1IpkBrdOhbtAuOUUk8C8xKzG91FY4BHv15FOozzW+3/f68CBQ?=
 =?us-ascii?Q?vzGokK9nbwibedfk0Z+LIskgUdfJUmBlI9CgapswhNioDY9j4Y2lxVeE63Hq?=
 =?us-ascii?Q?08XRBRa/Iib/OlKSLCL0y+9X4rPGsSeyMbdSuOZeFlxvEXAQO9HM6I+dkuaj?=
 =?us-ascii?Q?+JbN5MEcsrAtImtiCpWmCVGUv18o+CNsB0aDhmmwN97Nt3myCzGoPlZob3I+?=
 =?us-ascii?Q?qlYrVCFCSiEuUV6sa9T0+dQhTCmyBn5MFvt2UotaXh+iUJ9e+NSooNeBbigF?=
 =?us-ascii?Q?rBU9Xq0gMvexqN1pXPkayH1qzH4cAbi8wlLUohrmj1CKjYtJqD0XbyMxcvIl?=
 =?us-ascii?Q?WJV1eGmU+6BpghYKM1NIxuWpGYvyysPU6t7NskJXy7MYAjyuQ+hGAxP4d6TQ?=
 =?us-ascii?Q?cRvy889VG7ExXngYWk3gYRCA0hXfm3a7mkRsvv5Con4j3xvmjThZZAsdecBC?=
 =?us-ascii?Q?Jetbi+ll5687knbma3pv4NGFYWyFLHHHkhIe34LAOE2omG3KN9zTjWB29txF?=
 =?us-ascii?Q?yRoEmRTK0uBAKhf0oDgrjCe0BG6Pj+cm1D1yDRnV+UJi7zJRIFS2JLRWZRaH?=
 =?us-ascii?Q?6p6YNiz9OLgUGIjey1+LgAZsqV1R8axMW8IkTXzHQJPxlEWSCurHBZcg3kG0?=
 =?us-ascii?Q?6kiql9BrPB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ip6CgIVpkTtQD2IdRjc51KKSpEixxz3qywQEHnp+l72AlUu1yk6BLMrlQNNp?=
 =?us-ascii?Q?nvcNjoLNWA05LWBEfRboWaRzfrzqC1gnM7ovczi+e2HTFE9Ht+jDyOMofvLK?=
 =?us-ascii?Q?4qmi+TsbOEjn6UQAo50MPHNcjZ4CIAAcRG+QH5yrf0YAcLWN+deagji2wvsC?=
 =?us-ascii?Q?t0c5kACLCqNztsmOWtDzjJC2qGRvIoafFl19cQ9XsLKp0k4i/AgU3/0HJeOZ?=
 =?us-ascii?Q?54dtesBYgubHciuTC9ifEYVJPqpdyAEz+datLjMyCfNEAdvjNwe184bZYzmp?=
 =?us-ascii?Q?jX35L2KutTKS/sDSH7R1raGQR4cOA5XgSgCE1L4BP2E4uEU4v3S4D7dKr+pe?=
 =?us-ascii?Q?T62uSXH8CKW296BndV+Vw/tBpoNiGEF4mW8tAlTupuFLJwVZhLlkG8dAwHA9?=
 =?us-ascii?Q?68cWgK9i7DXXOOgUA1pVxW33PbbuMVCLKumpcpqOnfrp+h6ucAxsPIFrS2I4?=
 =?us-ascii?Q?Zzroc7zDbrkAxrAYdWc7JGsNxZzi22mbvBkWJQ9MbXfUUMW0FVUD5LRhTz68?=
 =?us-ascii?Q?r8/yqJF6gNlxr6j4WUR2WkMe3L/yXdjqVRv1Rhl1THpWGkXtIPN1sDljAu0p?=
 =?us-ascii?Q?qWDV7Mco7TTjxh17QYVy0OBHXaMdZ78db2HqnlH0hulADT/pgf2VK3BeixYh?=
 =?us-ascii?Q?fCGQ3uJ3K6WzMXWEYBUyfhv72WfVrCJB/1DQXOTRcxT/M2nXAQBDTN/1j1Kx?=
 =?us-ascii?Q?qqCCL0skQts0rMrFCWfd50IQV8hDjVigbVJI2tscoOnraFrxEkT5Drz+ZkmM?=
 =?us-ascii?Q?k06RFW6mITWuYNUq/q10bSpj4/qoq3NGiR3iulZEjbylGBdRWQUX8xjMXgeW?=
 =?us-ascii?Q?jYA86AwBB2hiamyl/WVDRAZW0MNCjg+4zHqUWLP1igRb33LLqZLX8vM9pjbE?=
 =?us-ascii?Q?RfGSdIeMv9/aPAe9ZEyRu98ZsP16/aIeChVhTfq4eYhatdn/vhnys/SKzYuy?=
 =?us-ascii?Q?D7ko+aL0HXAAZRcYZKk56TMLWbqltwajbB0WnDR+EYUv7lcf1k8MNbENot8I?=
 =?us-ascii?Q?WMFaSI/M9jaPTAzqpz4WucTzSxh9TPLPKB2hsQV1qodfBP9fvBojE5077635?=
 =?us-ascii?Q?7HlGilTytYekaFs8tE+oBsXFvGraY0dK1V1cK4fT0tatoncyyaixR5F2/FQ5?=
 =?us-ascii?Q?RXoqdtpSlGcjtvJt5YqjstFq3HPUKcYhmLDugNr5pPoN1lKxhP1VdSz8TpLZ?=
 =?us-ascii?Q?3+VpuT12vx3UH/HBsY8lgsfrmMfmXCYxG00q67AQQCfri4aEdGYyhqq82rsM?=
 =?us-ascii?Q?JXUvgLiyoMzKgS1EJ6uQA5FknXlLo/OjNsUUKqbYOwT9ezmf4f/mNXvcHmFI?=
 =?us-ascii?Q?eqQhhiFroIUBBWsxCT/FiBXFG5YUjmeFv18AE/hHKY6OaL6VaWCPTjxurWSM?=
 =?us-ascii?Q?l8gAllW7d4waflIAnkH90BFGG2nA/G+9xoTiaydjIJx55DD6oRb7BUOjSReh?=
 =?us-ascii?Q?oIoQwnhmMAW1eM5ZfAmSS07Au0nBiTL+NXi9tJL8O7LRoge3jpIyKib0nz23?=
 =?us-ascii?Q?k2k1OLbkflBN0qNCjN5iEoSUue6Ho18mMjZ0y+7/rc/xW7swOCAM4PzVxUk2?=
 =?us-ascii?Q?ZlcGYLB+wourQeNRX+CYrbDtwtKO2lriorHQrXU6u0tCJrIGK4Nva28PPhdm?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0e5d67-2bea-41cc-33c0-08ddb34741ad
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 17:47:58.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nioMxyi+cyEJNuQef0ImS6FmnxjpWPvisiPApN4Hil4qvW4ASrCB71gZzFt56mkoIMsIEdZBqSG/dX7As+P+cIMV3fGH1ejAqZblMBMQ1Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 02:06:39PM -0500, Lucas De Marchi wrote:
>On Fri, Jun 06, 2025 at 11:45:47AM +0100, Matthew Auld wrote:
>>From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>
>>Flushing l2 is only needed after all data has been written.
>>
>>Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
>>Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>Cc: Matthew Auld <matthew.auld@intel.com>
>>Cc: <stable@vger.kernel.org> # v6.12+
>>Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>---
>>drivers/gpu/drm/xe/display/xe_dsb_buffer.c | 11 ++++-------
>>1 file changed, 4 insertions(+), 7 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>>index f95375451e2f..9f941fc2e36b 100644
>>--- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>>+++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>>@@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
>>
>>void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
>>{
>>-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
>>-
>>	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
>>-	xe_device_l2_flush(xe);
>>}
>>
>>u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>>@@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>>
>>void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
>>{
>>-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
>>-
>>	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
>>
>>	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
>>-	xe_device_l2_flush(xe);
>>}
>>
>>bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
>>@@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
>>
>>void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
>
>assuming the calls to this function are already in the right place,
>
>Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
>... but it seems quite fragile as we are exposing the other the
>functions writing to it. Not something introduced here though.

applied both patches to drm-xe-next. Thanks.

Lucas De Marchi

