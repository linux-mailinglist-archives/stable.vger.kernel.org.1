Return-Path: <stable+bounces-88197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CE9B0F73
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 21:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01D0B21945
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687620EA55;
	Fri, 25 Oct 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/CP2BI+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0E18F2C3
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886177; cv=fail; b=FavX5o80O8sVJeiUQOO+zk6L3pODTvKMNb4YLMWeWGRbC9IcbalGrZXQe/X8O+uXPYNvfe+e064f2OoFum9S6WAt0IMhYvB6eYrehZN53ggdI8xL26WscCBze08Icj4AFsR6ems8Qr7yqMChw5v0LweINC8HxXVufHUjt+JLH8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886177; c=relaxed/simple;
	bh=beF+lIxKopqwnoYHBor7t7Bxkuty/18sll5VJ6ZKnRY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XBH7wEJ3tz4B/RVxf9cC4XBkZDpJyvjqQyzLQw1qNZlJy8fIOs7r58Tx0JJhqiZ7jKQ+dby6c8KYi0jhd1U6ht927+bBL0aeh7+RqQ8minaZ3HjmkQmiII82Sk13cBEjj4HzI5gxzZugrBD6j0Ci35zZLFXvrFs42z9Cqu8/FwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/CP2BI+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729886176; x=1761422176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=beF+lIxKopqwnoYHBor7t7Bxkuty/18sll5VJ6ZKnRY=;
  b=L/CP2BI+caXA7cCjYQu5DDANiDH8MGKbARq9tPp8vHGn6HRIXaGtY5lX
   7ejPZtc96YXnBwtsCZ/AfzEM+iRwzCRPtgPF5wWxLbGEIIEZuq9W8IFxe
   APUJOLod/GT7aJY0Rirgds9FRytbavH64zb/F9hlgMMUh4cUWJfbzLasy
   USCZ5u02eDDxkenAqEFtKYH/rI0bXVGuUfIbFBW9V0mvbsfHxY2F5MSn4
   ZQ7+1vvrQq6WKg3JXRsBxw74t0yhC1h2c/2gtpiufwcP/OwYpzcMQI2Y+
   PsmD9CRxdhP1ZQJn63iKLDDVGay24XEfPgixcpDinpfxg7+xesKbzFhfk
   w==;
X-CSE-ConnectionGUID: 1NmPVwmVQDy28HVYtPYHgw==
X-CSE-MsgGUID: T7zrOxAbTpiMFa5zSnGIew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29697371"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29697371"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:56:13 -0700
X-CSE-ConnectionGUID: EZTYVgO5SEamFlMijwzMNQ==
X-CSE-MsgGUID: GEr/vkV2RFCcCTVjlDYEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80601354"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 12:56:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:56:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 12:56:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 12:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiTvs3CsW7j3Da2zTvD9+78JpCDwvR/89BxL3WT+/+Ut7TDVDMKGYAfLRuoDtjidJkMu/s9JL10Jwm7bqITra8bTgw9pgd/fbxnfVovFVtthqNoPm27czzSl/AJ6dKA2cSjaTjquBovLZpbA92HUk7JrC2HFe0o92DEzYok5YDs6TD6TnCcbbCaKpHDQTIBwmzV5AgG1Th0REtaZrmE1tHNqcZlJoPU+1HzPOYF0pvXvXF4PwUkbiDiUH908bhgYbFAeffsIhoN9KhNLeE5Kf3LQ3k1kH8OAdt24E4rdurA4nY7NoJUi1VDjRa4FdAOux1vmnJuHsBfGETxt+MupUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBpbiZz1V1DmbqoaVBmyJOyzF3WnEIiH9C0vgJNjJvY=;
 b=cBE08jKVVuYt2EkFX7iMjb7NknBMfYx6/R+P6he9q1Z8EBVHxBpftLDhSCFm2Ig2qwVchgNYVIO+4sUaguPrXbUTQlDy83n9Sel3zo/QDwxkkFRNuND1mR6a65CQfGnzEYRmxnBj50u3bCY0oydLsUHs10X/Nr/fW/vIXFMpFlCGdncUtimD+TMwABkJHFgWJVizTHT/VIRL5MZ3kAtSpxU2Erb+aRsvODtlyOqKd+N5YL3sQikTxUhp+BS9TSsP9H/5VR6OPN6lrzk1FRuCwNxHfefPmf91UDfgI3SRczzKBlHPcn7JbJ+WNBo7n34KrKkheCyOybLvgw8wdlX2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 19:56:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 19:56:07 +0000
Date: Fri, 25 Oct 2024 14:56:04 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nirmoy Das <nirmoy.das@intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, John Harrison
	<john.c.harrison@intel.com>, Nirmoy Das <nirmoy.das@linux.intel.com>, "Jani
 Nikula" <jani.nikula@intel.com>, <intel-xe@lists.freedesktop.org>, "Badal
 Nilawar" <badal.nilawar@intel.com>, Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
Message-ID: <vs2dhzwnddd3cmwan2t5lw67nbd6f7xc6hbv7syxpa7ptmkbp5@ejopbbo4npno>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
 <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
 <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
 <ZxvknjgW+3hQx6nM@DUT025-TGLU.fm.intel.com>
 <82debae5-4eea-4302-bb55-593c1791d3e6@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <82debae5-4eea-4302-bb55-593c1791d3e6@intel.com>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN2PR11MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb20ddc-6f6d-462b-8e40-08dcf52f10c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGkE5U561vbN34trGZ/V5UGglvg1GxRq4r+p/m3FvyobCfKFlz5M6Gky5ceD?=
 =?us-ascii?Q?WFQ8p49CRcCL6IGaWWut+W5bDiu3WC8hJQJHqC1IPoxglDgG3X10o2Y7VQoH?=
 =?us-ascii?Q?1VJzgCQ/3u47qLcvozpJ5VPsJncX6dVLWylfhXIw1r8ONh0ckec9gKSzSiUE?=
 =?us-ascii?Q?pkoK8jrdk01K6uSN9zFXmwJ+ncopcuAewRCO6cObmHbYFLtNKCj51nfVEQJ/?=
 =?us-ascii?Q?1ON9VoPz2Q56QF9qlTG5fkgRpKrU4VqN6LQdq572yJIFIH9nKKRoYEI5AhO1?=
 =?us-ascii?Q?tyrJHImhdTQMJAjABghNTXObstA+VbWCrakUAK70cwnrhcGcXzdIPmgWiLFV?=
 =?us-ascii?Q?ZWiJQS+erThaZ17ivSkohbH7VY23Lg+KeSJAJfExhARIlH2f6A5YsSC/iyN9?=
 =?us-ascii?Q?4Hhk67oeKv/F6XBeHchRHtHBwmOsKe9qv/hDEpejH0QkCLif1H8akLNYd9F1?=
 =?us-ascii?Q?mU2gWkXzLNjo+JskfXjageIuOx196eGxeM75U9FGPzQs410SocRQyShrFArI?=
 =?us-ascii?Q?ihBoe4/eL/HpUdGOdtdJm5sDiNZhDaBc3Yil4EEG3IRQ7A1XuLLlDTcch65O?=
 =?us-ascii?Q?YLn6KUeokCsQiniMqLRVQCsb86Gv33cco9fOqfc9yUfwreY5XnwYUwxOdKBu?=
 =?us-ascii?Q?Ym9MwipPcR2GUa8K1vkDqrbj217/9JF9v5FkG91LNRpRhxYyax7vETH8JQ+E?=
 =?us-ascii?Q?/XKq2i0fA//Zb6GwNGh15sPu+8/tU2KOUWMTUIO+iuqEzqqv3oyrxAUnk/Et?=
 =?us-ascii?Q?rX2ALZnv+/f54uFDp5pDaXx3eL/hPRgaA0QiHVCcKb2hAcRBhTB0yHoU3XzF?=
 =?us-ascii?Q?WDM4FuapxVwuns5PNlLa97JsbpAAIj5QrtXVFJHAZJDDVmaYn0zIkF5Cunm+?=
 =?us-ascii?Q?Tx1DAjed51/k89jAd0r094NUEPiFc5FE+78EJXbMaGtB7UdmsUBd0YL3iVyI?=
 =?us-ascii?Q?A/26g23vSKVVsXHdaRpF8LOyaoku9NRWWhqviW3aRj+cJtDio9UKSsuIWsix?=
 =?us-ascii?Q?eX6kHE7h1CttxdulSpbBusb+F37/ejzTJgjjwTHJRV3rA3LPES8s0E4z+ILu?=
 =?us-ascii?Q?BNzpGHV6phvKCD43Kyf0ZQGuQK22yuqTQPE7xnavTp38XNT5BQknqmgBofb+?=
 =?us-ascii?Q?3Ma0jXbIepkS07mqxezmXR5bpX1LXtggu58L4azsLDmR5HD1LbqRoKHrKd7t?=
 =?us-ascii?Q?CsWTPkG4lwd0gxMmxh7wTnOtRqBBK7lhUOlA/nALTgebkLso7G/UB7NMJ6K0?=
 =?us-ascii?Q?bUNmqJbIr4D+9RpaJTGV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NF7vE/Bhd0wmKjd+bbYzFwtKx3ZboaGCoUwO2O77/5mfYeg+kNSVeQMr5uQ?=
 =?us-ascii?Q?GAJRYUPOnLu9lPFq/c7LFWtIcZ4dirvn7R6TENR/bxD00fK+XZPUkeX90yqh?=
 =?us-ascii?Q?bkLGlMtc9hGIbBsV4KHBJ/dQ32dENm8aefdhCCz70CY896laO+VKEv6EI3Mk?=
 =?us-ascii?Q?2aP9ADq9BeMlHrVv7LXdpJK8h9QYZRwH9f+GBE6uLehjIciejps3vc5IbPYv?=
 =?us-ascii?Q?ZrZqxMtUUNWeudnYuD4zxMl9kongbuAnRhNsyTgpEsuf1U4adR/62c4gxa6U?=
 =?us-ascii?Q?AbVEqkAEtmgeeIauAv7sm4FGjT22M49jRcz2OFRCwvsNEv2EuW56LUBFHq0g?=
 =?us-ascii?Q?5pUFrIsC/VuUCRD9IlFKwaCaErPmV6wEgFQzC/H9PgN7JRAxknhtOF1qAw1Q?=
 =?us-ascii?Q?Pt2eklyHw2wrt2iyAhaqT4WOLQIA7F8jHxL4BaV1wC7AwkFrXyWOBjgBZjKi?=
 =?us-ascii?Q?St/TBD9YvhniwqXhLjJLySH6wORD0cnBEvob9ZJQTMfLNsGIaZnJeYGBmxoc?=
 =?us-ascii?Q?gJ8+v/iIvTlSEHzNDNvbjN+t3zZ4RfUwdZPll4baQgoMYVJJczgspWJHxvl8?=
 =?us-ascii?Q?VhdzNot1w9/BfueiAKqvC+k73ldMuNnadv4sGhSDjapI7RveVeQuFMCEw1H1?=
 =?us-ascii?Q?E7BKa1+QT7Vl9tgQ2v24CKD6uG3WG64tdhBXA6fcXe/6+Z1HMJvhMOJF9bAP?=
 =?us-ascii?Q?IlJb9Vg5H2UG2cZJiF3elOnIRR9e/brVGz8kEAIPZJY5NP8IRfxd+T3UtVCE?=
 =?us-ascii?Q?eiHntWmHKJ7syqjZBKAUrHIcvqzlvv90cbSFgOkZr5ViZ8jviBZOEepiYNrB?=
 =?us-ascii?Q?uHz8lupjRiDFm6zzOXoP8fjKbs2g+rZBz1iNVMpC4N+6djo7cGPC1K7/AQ3c?=
 =?us-ascii?Q?2H5s1N0UNKuLypPAXpWTYB7WbPrBhJSKNnEFrIKFEIAYn335rUA3fzwkm0OK?=
 =?us-ascii?Q?PFrLPfjrhjYxtwEpOFDUBVfkRJiEx91VRL4KtJa602FKZX9UyokzLKjbk/Pf?=
 =?us-ascii?Q?z4JfzKJ/2Cg6X0sb9SQlpyGbE8KuEC8bUJ9KXoJ5GwIycqJc76dGzvTjlUiG?=
 =?us-ascii?Q?PvrI7tyOFLMzaaFcdgAN9zB9ZTBCcbwhrs7JhLRDVmB3IFWimFaymNNW9WIL?=
 =?us-ascii?Q?2UhZR24Ct3anQuyA3A3zFO+BwvMMWDu5u1RLWXYOpFhFrl7P1zkEnV/FLe4r?=
 =?us-ascii?Q?K5blnEQHAriQ7QFtXBQXz6o/adWaEsh9xHaOGmjjK60i8Y27ngI/sztKVHvp?=
 =?us-ascii?Q?zzYPG4hBwgW4AqVfaHKeyzaqZXdbsw1e2gE7asUxOYwwSamkQJx6ZEdpOfCg?=
 =?us-ascii?Q?LM5CMXQKXBADh6KJC9fnkayjeqZ3GyV0dk8ucKLfiXw3xYX44FPBi5m44LfS?=
 =?us-ascii?Q?SN28PRwyaNchzZd3OVBjth7Rat9Yvzu3ACXfYpuiQsswavVzmhhhNLRu2I6t?=
 =?us-ascii?Q?/AzrPC1XeOWxH8arcB3eKWlJApBEDw5rdoJpDYWzaZ5SnpgdlIMtVI+tJJLm?=
 =?us-ascii?Q?urP5X1VLikui4+sUBGB7Q67x4IUC2TfDQWZ3uTiS7NTtLkVYOTo9PrVLv2FP?=
 =?us-ascii?Q?WZZKrxpJf8KVn6mgokP0iKV+s6FACb31TyK3+z6C4PyRQP0oZl/paROus0vU?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb20ddc-6f6d-462b-8e40-08dcf52f10c6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:56:07.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtlA38VYlNFvKyXv0ZFIskWb0aRMy3/v/Btv2O5qk8gZpPk19gAs5e8PhxCbkq7jFe0eDSUpR5XY7MbuJTUAzECClClpJDPs2Xqyxz+OfrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com

On Fri, Oct 25, 2024 at 09:33:39PM +0200, Nirmoy Das wrote:
>
>On 10/25/2024 8:34 PM, Matthew Brost wrote:
>> On Fri, Oct 25, 2024 at 11:27:55AM -0700, John Harrison wrote:
>>> On 10/25/2024 09:03, Nirmoy Das wrote:
>>>> On 10/24/2024 6:32 PM, Jani Nikula wrote:
>>>>> On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
>>>>>> Flush xe ordered_wq in case of ufence timeout which is observed
>>>>>> on LNL and that points to the recent scheduling issue with E-cores.
>>>>>>
>>>>>> This is similar to the recent fix:
>>>>>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>>>>>> response timeout") and should be removed once there is E core
>>>>>> scheduling fix.
>>>>>>
>>>>>> v2: Add platform check(Himal)
>>>>>>      s/__flush_workqueue/flush_workqueue(Jani)
>>>>>>
>>>>>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>>> Cc: <stable@vger.kernel.org> # v6.11+
>>>>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>>>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>>>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>>>>>>   1 file changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>> index f5deb81eba01..78a0ad3c78fe 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>   #include "xe_device.h"
>>>>>>   #include "xe_gt.h"
>>>>>>   #include "xe_macros.h"
>>>>>> +#include "compat-i915-headers/i915_drv.h"
>>>>> Sorry, you just can't use this in xe core. At all. Not even a little
>>>>> bit. It's purely for i915 display compat code.
>>>>>
>>>>> If you need it for the LNL platform check, you need to use:
>>>>>
>>>>> 	xe->info.platform == XE_LUNARLAKE
>>>> Will do that. That macro looked odd but I didn't know a better way.
>>>>
>>>>> Although platform checks in xe code are generally discouraged.
>>>> This issue unfortunately depending on platform instead of graphics IP.
>>> But isn't this issue dependent upon the CPU platform not the graphics
>>> platform? As in, a DG2 card plugged in to a LNL host will also have this
>>> issue. So testing any graphics related value is technically incorrect.
>
>
>Haven't thought about. LNL only has x8 PCIe lanes shared between NVME and other IOs but thunderbolt based eGPU should be easily doable.
>
>I think I could do "if (boot_cpu_data.x86_vfm == INTEL_LUNARLAKE_M)" instead.
>
>>>
>> This is a good point, maybe for now we blindly do this regardless of
>> platform. It is basically harmless to do this after a timeout... Also a
>> warning message if we can detect this fixed the timeout for CI purposes.
>
>I am open to this as well. Please let me know which one should be a better solution here.

if it's a cheap thing without side-effects, go for the version without
the platform check and document it in commit message / source comment

Lucas De Marchi

