Return-Path: <stable+bounces-76949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F8983B5E
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869391C21C97
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143511CAF;
	Tue, 24 Sep 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYb2ewIa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14611CA0;
	Tue, 24 Sep 2024 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146500; cv=fail; b=sJKB97Dl+NMxGsOfnhI2mB4ZkO/yrfVKRex6CRicI/K4lJt0J9OyPJZQ5ngPY2tjq3eq4ttOI0nDZFq2TbJqg50KG+nnzz/ZNWVDX4P7M+w5HKJXrudCt3CaDK62v7N0iMlFF2waDHUWgVaZk2QiQRODMIK9wXOGjB+HKxWvRZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146500; c=relaxed/simple;
	bh=3CmzkxWYRsDntQnxBpBQXg8UibtyewA8J0K+z67Kyy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAPfS0giBIBYjrqyCQUf7sngwrpLTTTuMHO9u6YPlIgBbVZsbG78Uf0t3td49ET0iVBD3Tf5ODoznkI02KdrencCqwfK3YLajmw+Jx5yc/XYWqdVWIO/UTU5FBlf/kni/odxaNyodQXuYtL8Wm0Y55HDz+XlhzBHiZCcCb2Ga1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYb2ewIa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727146499; x=1758682499;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3CmzkxWYRsDntQnxBpBQXg8UibtyewA8J0K+z67Kyy4=;
  b=XYb2ewIaRACCMGdHfxHQsNdNzd8jlQekYBYxp/CTlifSEwBrzTLMfnrB
   ISjamCCjyYcPrUijMJ523RNoVvDHrR1OWKimiFhPk82Rxk8dFcfIVZbgT
   IBzRbEC6fYnAv5p3K+4PucVwC867qr5qTQKY3lKvxwxC8S95tvEGYs2/o
   u38zyL2BdxjkFPRrSxO/DdAIT5VMpHhOqqb4trnvY7wVV2hWplnmFfKl/
   Hqv60gSPFzCXpSDZSRHyJRp4IY+Gw9MbXrdQSZA3drsRAAhPK46SOOjS6
   j66sPX7sB95mfhSag2CKoQ8bjok7GJE3V6s1UajH5yU0LXujztFUykT4I
   Q==;
X-CSE-ConnectionGUID: Q8gGm4VXRYykY5vPRSq5lA==
X-CSE-MsgGUID: h+jsNXdIRPaUws1MktNoAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43639121"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="43639121"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:54:58 -0700
X-CSE-ConnectionGUID: 7idiAD2SQLOAYP/E7mAniw==
X-CSE-MsgGUID: GoDZKKaAS5iaAE8OCszYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71317248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 19:54:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 19:54:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 19:54:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 19:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv5q0GebjZ5Iktb6kqWclQbZ0PJgTszwMYl2h+PNedNq5fOvLnsa5il/HcPcoGklK13t/H7gGm9wdLUGB1ukMXGto0kGtIKo3tUH4qiKDzKUdoyrWuNby7pVZrHTElyMc5hdDK+MeKvfeL+gwbF/QaqMngylzi0dYt4SUmfghms9NtjJ6uuLWKV3f0ckeqSFzVroVKLt15kknn/yrqNe3Ydxvg4o4hdwhFGVkX1bRY6XrnRRIwjaNf9C8kvCYYPaVe5NLzQ/FxtCT9kEA5zZxZTeRmf5iiW5INFjPLtAY/6ziimTKaD8owcpn3HugrZ0+zG5FBMe9MZMsKQ7OInfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6+cstIban+OM3KYI7aJyekmYgpWEru9RFMq8S5A2Ek=;
 b=rIGU4r1kHpFngovJrc4ym5aey5q7Jh5QlpM0orS4LA26PTSHlrMv2MwqBaj8+th28wLndrn/WKF+L9E6hlu/HptdB29lCFQpgNBb+eou3HdY1p6aBfX6BkYAugjqQDbv0/AcKt3eRc4juhl2Xg5pab/2d8iOO8NdusNqiSUtNFAVsoGQafpYkjUV44GxVPnefGJGED+o8ZMqr/miL+uH4Pb8tu47bGtS41OCV4h+YQc/VTspb5sdSxQYlK5vbJwlj6jjt4O5lZPMU6E4/eAgPcJpIZZbHOQ4EnYdqa8xlt9ZDwc/swsB1BTykykAUhwkGJtsSDc3owfDxcg5J/HOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 02:54:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 02:54:54 +0000
Date: Mon, 23 Sep 2024 19:54:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>
CC: Dan Williams <dan.j.williams@intel.com>, LKML
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [regression] frozen usb mouse pointer at boot
Message-ID: <66f229fc4daa9_2a86294ec@dwillia2-xfh.jf.intel.com.notmuch>
References: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
 <2024091128-imperial-purchase-f5e7@gregkh>
 <66ef853de5f16_10a0a2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66ef853de5f16_10a0a2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: c5aaf483-2bee-422a-4a4f-08dcdc444460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dv2/z7tZErzxyEF/OfqS58QktUomXMwpMOSmE38K4GpPpMDNb0oQgWlVdmRi?=
 =?us-ascii?Q?JFUmcW/UuIslwrSYlY7l+vPfcyaXASS1gCyA2B5xpuo73XP7KL25h8GYBuBM?=
 =?us-ascii?Q?1dwhYGeBpCl1AKa+xyaqadDOMX6eBVj6BUMvs8Diz6kvAO3HBLJ8lktdDGla?=
 =?us-ascii?Q?uJskQNxFSXfb//7cx97mdc+Ta9CpcLZsUTa2oRFaK2GsbNw7GuMNI4a5pIo1?=
 =?us-ascii?Q?9paSRtL0FkQIF8VTx9A3I8Rjy8vHmHyIEaT6rtm+yApvJ9sW3BN2B/7JEGKN?=
 =?us-ascii?Q?tLLRc597A7XN2EPT1YMnwmdOlUNh0aGPR82ikLRdWCnkf9QzId1kKU2QjZeT?=
 =?us-ascii?Q?Z6OEBF/5EWk9ZUP5eY0LQmpv/O7kfamioX0ABT8HHo2ooNHwvc/XrqPCQb8F?=
 =?us-ascii?Q?vvIzfWHnmtGQFXFFZAm6u+YsXw7aGHNfBb5oZGu9C7HFaiw50qYgdJZ06+A4?=
 =?us-ascii?Q?c7TM/D7xuMRjtV9GBHC136Nryp1JKXXSpWKxW+WtZJMl7Yuk305Z59NCZZ+a?=
 =?us-ascii?Q?JDn2eo04OTyEKT0ZbjSjeyKkJumTxplGShbBkg3R5PxN0wbmW8U975kyK2ck?=
 =?us-ascii?Q?9EeifEuf7ySv2Dkvu1FWEqo+l6gO14ROB/xxcD/z4zTBahJvuK328wc9MKPo?=
 =?us-ascii?Q?yVZCGBebtkxCVs7IN54Gtp7D/2QdIdtCpTrkRZI7Hddvl2geuIFq2wdt6FRX?=
 =?us-ascii?Q?kvnSl40c1dbolt43ssmLAFEHdX0/x0twISMn6ut/NZx+sBVuxJb0wqlPUaXR?=
 =?us-ascii?Q?0AcuxrQ1srIf8WL/RUwvxm92DjKq6PkIrIvFOH1YwXUFfOYjS48vmyRAeJVw?=
 =?us-ascii?Q?XVnkmUx6M6RlnndbXfdcaBvgntDL+hvkJ9jQyStpcuCN6hML9NXvSjJkUR8f?=
 =?us-ascii?Q?XJmUELHmIc3xnqoDNyA7RfT91SSBjjSZD1uyOhIpEDyzzxggV+BjaE7Zn4Rd?=
 =?us-ascii?Q?B1hcBrUC1CUL89kW9Z2IFMkaaBpGvUrCytqnpyqYv6/+A8GHsBYUGwjj7WcJ?=
 =?us-ascii?Q?I8xEzRwIjUChfkr/bImHlGCO33WfcPRvpGVXt0tV7XLqdTteX0M+oYFtzczm?=
 =?us-ascii?Q?1AhKp9MXMJXrr1Kdn3Fv7SYtUenfoFgrNu5ctKOxLHj0A34Ct5UAvcNZnsfI?=
 =?us-ascii?Q?Jaw2QJzkwjPvICHkYhzl7Tc2Hl1QaRCwyIhgVYxc0Cb7Gw7zTU3F+gAauRDX?=
 =?us-ascii?Q?ibq6L4cM+4QbfGin8r4ZDHACZq3wkRyrhoB8uMyjINR2WueoUvb7iw29oHRl?=
 =?us-ascii?Q?n23q1Gf4+qRlj8341gfwFiW66uTarOdCpzoDeZZ50w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOKfIAPz0WIbB8bma0f0HqGX8h9+1TQhcs+HdSxirbRrTsQ0hmPr/aEyJKBF?=
 =?us-ascii?Q?yjZZGKmtBfAEZItviJhvX5OAMD7F6kaR/AjPy5PDrCL69J1BfKDzNZRw32tt?=
 =?us-ascii?Q?lbriSWdp2TDNqbRva7uaLOt4bRX6h/mTxnvz0SNR0UnwivG26XQ14B5gyxmv?=
 =?us-ascii?Q?DVIQZPDms//p69fsBxbo/k38JHEvNnnLudLcFYbqcchWHT0NejOZwKWwAdHm?=
 =?us-ascii?Q?feZPbhIbazZGhtGwURcGGFV94pRtGKVOlh3IRrpLnwXokYk2QYlL64JfUveV?=
 =?us-ascii?Q?uWCKQUt0ARJiOkXswdaCDYWbh4DbaQ4ri53w2AipjtKAbbLeRv+a4+gmhdYf?=
 =?us-ascii?Q?k5i3QGtsD++Sa9V37GY/4dH7CiaD4jmohqag9rCeLkinJ1KEoGhLxrdWzEwc?=
 =?us-ascii?Q?do0xz6RheH55LrzI91YbTomh0E9NsiVeVS9uoBpcmX+kaR/IAzhq66fMjI3e?=
 =?us-ascii?Q?QmzrMi22iGbsNG1ODT6rmHGfEzQP2f+JsYyEJX34hnDi0n/LiknGpLWH8mQA?=
 =?us-ascii?Q?68qvraE0Wg/F+1QUqXckqbCkcVLI+A32JCeCwSIunScVKegD66U6gTQq71iG?=
 =?us-ascii?Q?vI533qGRI56SyNrosLqV0/dvP0pM373djwj411vYok92THk+RM16Izy1edvj?=
 =?us-ascii?Q?kMKcEr86f5uEh9m92eK3vMRxOihFfdY/9oelVIhTVC5u10b3olRwbTSKvYgF?=
 =?us-ascii?Q?1iWAm6hZx+u69vgaU6UJNPRBVpPPJ6zpT7OEKuFOjGGMrbzWBhYv8C3i7lXw?=
 =?us-ascii?Q?QeTeoB/twIoxio/HfJ4XKP+o28QVittQzPzREQJZtlxIrUYB2fmUeVuLSRSq?=
 =?us-ascii?Q?14JZJBJJpJm07W96vQA4r51kIDR24y3HGB4B5VFnC0F1Q1COj+Q9qnXSVxp9?=
 =?us-ascii?Q?fLiqRLZYk+caqBJfFRuvWR1DD9/qOkTR94IxthPehjNZqmVG03WxOnDozivV?=
 =?us-ascii?Q?XZ/NQTsJs1ybPiBg54KZFJ+VuLP/k55LT/WINbDdZ3mDJfrYEzvSgSYd2Q6/?=
 =?us-ascii?Q?h1xV1fFMRI/tkMGj5sFFZAfK86jHtKeGQyhc2wlzw7eUo0EdFuCwum2+5BGT?=
 =?us-ascii?Q?k3koI03QQDnmvtNGefcFc/vU8pBhSvI6VY9EDFo9JPGd82EuH45nvjRdmI7Z?=
 =?us-ascii?Q?X9szqZ6nDgnqR1BuqcXCEfCMtB66yEO9ezAG/Znwcik7upo4VdmQFCWyxtNa?=
 =?us-ascii?Q?G0w7DaiIMEPSLIQV+zkBN2l2tdzcrNjmFLoGfietbAszNyTk9OJlimbT25M3?=
 =?us-ascii?Q?y8yRXxMWAo5Ak3gve1q5fx2HZHUVqcdo2yrgIuca/pzwmiMilA7wpBtin+uL?=
 =?us-ascii?Q?mPOF0Tbjk2ExVB7K1xG5GS+u9udUWA7Li2fif0Aqhj8YChqm3SWHu+Wfs7G6?=
 =?us-ascii?Q?itOCspfVXzgxRhsZvkHungjZJr9CHvSPxskSVPePM7FURwXfzLTqseL104+U?=
 =?us-ascii?Q?PViZggMzGdEPB2ZQ4tKqQcY/jLV2C/1d9XAWSZkVgR0fjVpkXZmF2KfK5qQ3?=
 =?us-ascii?Q?HxpCXrw3GerRIvWFms9nUf86XB4Cpe0HvK7MTmg/U1LFkzYHQhcgq4aPCZlj?=
 =?us-ascii?Q?z4W4IEAbPeEbimwTrcvXXg2/PKls+YqJU63Ky7QBI1y2qrQonh17sNrvNX4Z?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aaf483-2bee-422a-4a4f-08dcdc444460
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 02:54:54.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCMm5pwx39A+ZPU0romKeAWkjQsT9P84XSoOiB3kiMbjYfrn2Y3FNCpaSty0VsoG66e33nSZirvYGdsa7Cvqo8dD03uVcafoWi7/75Zri6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Greg Kroah-Hartman wrote:
> [..]
> > 
> > This is odd.
> > 
> > Does the latest 6.10.y release also show this problem?
> > 
> > I can't duplicate this here, and it's the first I've heard of it (given
> > that USB mice are pretty popular, I would suspect others would have hit
> > it as well...)
> 
> Sorry for missing this earlier. One thought is that userspace has a
> dependency on uevent_show() flushing device probing. In other words the
> side effect of taking the device_lock() in uevent_show() is that udev
> might enjoy some occasions where the reading the uevent flushes probing
> before the udev rule runs. With this change, uevent_show() no longer
> waits for any inflight probes to complete.
> 
> One idea to fix this problem is to create a special case sysfs attribute
> type that takes the device_lock() before kernfs_get_active() to avoid
> the deadlock on attribute teardown.
> 
> I'll take a look. Thanks for forwarding the report Thorsten!

Ok, the following boots and passes the CXL unit tests, would appreciate
if the reporter can give this a try:

-- >8 --
Subject: driver core: Fix userspace expectations of uevent_show() as a probe barrier

From: Dan Williams <dan.j.williams@intel.com>

Commit "driver core: Fix uevent_show() vs driver detach race" [1]
attempted to fix a lockdep report in uevent_show() by making the lookup
of driver information for a given device lockless. It turns out that
userspace likely depends on the side-effect of uevent_show() flushing
device probing.

Introduce a new "locked" type for sysfs attributes that arranges for the
attribute to be called under the device-lock, but without setting up a
reverse locking order dependency with the kernfs_get_active() lock.

This new facility holds a reference on a device while any locked-sysfs
attribute of that device is open. It then takes the lock around sysfs
read/write operations in the following order:

    of->mutex
    of->op_mutex <= device_lock()
    kernfs_get_active()
    <operation>

Compare that to problematic locking order of:

    of->mutex
    kernfs_get_active()
    <operation>
        device_lock()

...which causes potential deadlocks with kernfs_drain() that may be
called while the device_lock() is held.

Fixes: 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race") [1]
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219244
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |    2 +-
 fs/kernfs/file.c       |   24 +++++++++++++++++++-----
 fs/sysfs/file.c        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/group.c       |    4 ++--
 include/linux/device.h |    3 +++
 include/linux/kernfs.h |    1 +
 include/linux/sysfs.h  |   10 ++++++++++
 7 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..1fd5a18cbb62 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2772,7 +2772,7 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR_RW(uevent);
+static DEVICE_ATTR_LOCKED_RW(uevent);
 
 static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..eb5c2167beb9 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -142,6 +142,20 @@ static void kernfs_seq_stop_active(struct seq_file *sf, void *v)
 	kernfs_put_active(of->kn);
 }
 
+static void kernfs_open_file_lock(struct kernfs_open_file *of)
+{
+	mutex_lock(&of->mutex);
+	if (of->op_mutex)
+		mutex_lock(of->op_mutex);
+}
+
+static void kernfs_open_file_unlock(struct kernfs_open_file *of)
+{
+	if (of->op_mutex)
+		mutex_unlock(of->op_mutex);
+	mutex_unlock(&of->mutex);
+}
+
 static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 {
 	struct kernfs_open_file *of = sf->private;
@@ -151,7 +165,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 	 * @of->mutex nests outside active ref and is primarily to ensure that
 	 * the ops aren't called concurrently for the same open file.
 	 */
-	mutex_lock(&of->mutex);
+	kernfs_open_file_lock(of);
 	if (!kernfs_get_active(of->kn))
 		return ERR_PTR(-ENODEV);
 
@@ -193,7 +207,7 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 
 	if (v != ERR_PTR(-ENODEV))
 		kernfs_seq_stop_active(sf, v);
-	mutex_unlock(&of->mutex);
+	kernfs_open_file_unlock(of);
 }
 
 static int kernfs_seq_show(struct seq_file *sf, void *v)
@@ -322,9 +336,9 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * @of->mutex nests outside active ref and is used both to ensure that
 	 * the ops aren't called concurrently for the same open file.
 	 */
-	mutex_lock(&of->mutex);
+	kernfs_open_file_lock(of);
 	if (!kernfs_get_active(of->kn)) {
-		mutex_unlock(&of->mutex);
+		kernfs_open_file_unlock(of);
 		len = -ENODEV;
 		goto out_free;
 	}
@@ -336,7 +350,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		len = -EINVAL;
 
 	kernfs_put_active(of->kn);
-	mutex_unlock(&of->mutex);
+	kernfs_open_file_unlock(of);
 
 	if (len > 0)
 		iocb->ki_pos += len;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c94..1bb878efcf00 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <linux/mm.h>
 
 #include "sysfs.h"
@@ -189,6 +190,26 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 	return 0;
 }
 
+/* locked attributes are always device attributes */
+static int sysfs_kf_setup_lock(struct kernfs_open_file *of)
+{
+	struct kobject *kobj = of->kn->parent->priv;
+	struct device *dev = kobj_to_dev(kobj);
+
+	get_device(dev);
+	of->op_mutex = &dev->mutex;
+
+	return 0;
+}
+
+static void sysfs_kf_free_lock(struct kernfs_open_file *of)
+{
+	struct kobject *kobj = of->kn->parent->priv;
+	struct device *dev = kobj_to_dev(kobj);
+
+	put_device(dev);
+}
+
 void sysfs_notify(struct kobject *kobj, const char *dir, const char *attr)
 {
 	struct kernfs_node *kn = kobj->sd, *tmp;
@@ -227,6 +248,25 @@ static const struct kernfs_ops sysfs_file_kfops_rw = {
 	.write		= sysfs_kf_write,
 };
 
+static const struct kernfs_ops sysfs_locked_kfops_ro = {
+	.seq_show	= sysfs_kf_seq_show,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
+static const struct kernfs_ops sysfs_locked_kfops_wo = {
+	.write		= sysfs_kf_write,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
+static const struct kernfs_ops sysfs_locked_kfops_rw = {
+	.seq_show	= sysfs_kf_seq_show,
+	.write		= sysfs_kf_write,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
 static const struct kernfs_ops sysfs_prealloc_kfops_ro = {
 	.read		= sysfs_kf_read,
 	.prealloc	= true,
@@ -287,6 +327,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_LOCKED) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_locked_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_locked_kfops_ro;
+		else if (sysfs_ops->store)
+			ops = &sysfs_locked_kfops_wo;
 	} else {
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_file_kfops_rw;
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f32..0158367866be 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -68,11 +68,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 					continue;
 			}
 
-			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			WARN(mode & ~(SYSFS_PREALLOC | SYSFS_LOCKED | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*attr)->name, mode);
 
-			mode &= SYSFS_PREALLOC | 0664;
+			mode &= SYSFS_PREALLOC | SYSFS_LOCKED | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
 						       gid, NULL);
 			if (unlikely(error))
diff --git a/include/linux/device.h b/include/linux/device.h
index 34eb20f5966f..c38c33bed333 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -180,6 +180,9 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
 
+#define DEVICE_ATTR_LOCKED_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_LOCKED_RW(_name)
+
 /**
  * DEVICE_ATTR_ADMIN_RW - Define an admin-only read-write device attribute.
  * @_name: Attribute name.
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d..df6828a7cd3e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -257,6 +257,7 @@ struct kernfs_open_file {
 
 	/* private fields, do not use outside kernfs proper */
 	struct mutex		mutex;
+	struct mutex		*op_mutex;
 	struct mutex		prealloc_mutex;
 	int			event;
 	struct list_head	list;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c4e64dc11206..981588c9c673 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -103,6 +103,7 @@ struct attribute_group {
 
 #define SYSFS_PREALLOC		010000
 #define SYSFS_GROUP_INVISIBLE	020000
+#define SYSFS_LOCKED		040000
 
 /*
  * DEFINE_SYSFS_GROUP_VISIBLE(name):
@@ -230,6 +231,13 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
+#define __ATTR_LOCKED(_name, _mode, _show, _store) {			\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = SYSFS_LOCKED | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
 #define __ATTR_RO(_name) {						\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
 	.show	= _name##_show,						\
@@ -255,6 +263,8 @@ struct attribute_group {
 
 #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
 
+#define __ATTR_LOCKED_RW(_name) __ATTR_LOCKED(_name, 0644, _name##_show, _name##_store)
+
 #define __ATTR_NULL { .attr = { .name = NULL } }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

