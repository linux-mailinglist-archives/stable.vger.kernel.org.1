Return-Path: <stable+bounces-39346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152F8A388B
	for <lists+stable@lfdr.de>; Sat, 13 Apr 2024 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6147B21C05
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6E1514F6;
	Fri, 12 Apr 2024 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo1nJLjq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FF147C9A
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960872; cv=fail; b=d8ssU4y2B5MzphUxRUr1T+P8PGvopCFoAQmwpXc02lWUp/Zlnf0CuogOLB0T3Hra/MRedk54RLvhlLf4uCFBUCbcq3XWs/eS+sfAmfQDne76GY20PiC9HIPff0ye0ngsK53ATGku8hKEV/Ctty7ijOzYh/S/daMr603I1xD2Jgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960872; c=relaxed/simple;
	bh=3iApwbVb99BOYBgxe2/deJYoiHT90hlcw796GBcu6Xc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+SMIDwivGcSEqNrpKWE9s1zjug03RFBOZHIDgLffuKEDE9dRdAJGdx8+TROGj3V7FoslSEU/O5hZZESsPUTpM3WPVK6NLnVUqNIkCkf/m3XYSvTEVf38R0EPwewSrpjPjWVMwK358sOscEbUv2udNgqLxkkkZ0lvocCQsk+8uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo1nJLjq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712960870; x=1744496870;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3iApwbVb99BOYBgxe2/deJYoiHT90hlcw796GBcu6Xc=;
  b=lo1nJLjqr7q+ZvkIn3JE+V3j3k9ZGrFkuaSAqB3ktVcNoUKmaEhWPWS4
   tCyjXSq1/6ssn1MPGngW1UiPiBwYJaHjE8ExrqJLrRTE99T1/tJL2R9bi
   0MwjLioLYcrbURvmqnT7yeDga1O1dHoFdNhbmmTcS3gck6XVkXL8HYIV2
   NDkCp+/7r4DhNxeleiN9GPKpw/F1d0tYPENGZn4ZOV6RBqmlj+xS4Xvam
   G2lpJy5U7Xke9OCjgmJYum5VdfMUT9BOSnoEg9dgxNy9ct1WbNG+itw/L
   R0NNLkblC2PuYIGPeEQVK+H4r9utg/TExIMRloB8XAvfcj0JMScfBEN+H
   A==;
X-CSE-ConnectionGUID: JyLqnl+pSZ+n42g81rf/4Q==
X-CSE-MsgGUID: XvNr3YVjQ5q2ScEsLY/wiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8352339"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8352339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:27:49 -0700
X-CSE-ConnectionGUID: D53sdDSbSAyGcVsMa7+Pgg==
X-CSE-MsgGUID: SSgv79pCQqeau5Xm4HAXvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="26147818"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 15:27:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 15:27:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 15:27:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 15:27:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAbn2eTluyIwcNc0SLbjmdubV7v1zL7Qb0g7e9Sk0t532yz6VjNrimQwBvSE14HYnFcVscLBqLUb7aYyZy0n2CgKRazrtVRN28y5A4TCBHRTvueIlzSYW7QrVlqzy4uPqpqNZSLrd140w8RI0ZqVAy0gC0y5XWul2yJkPkqGCe6RAXfgqMvqRPqPqHCfLrgTLz4rHpEUTVCBNBuwh5G0nr5Y2cSUxbuCYHwnjuqHhGg/5NbeLQ7IAQwYZP/DdAbeT3L9SzwjhfOvE4wTOmoOz366d/dV5R1IHhS+LoIgDHBOzsMpg8Y11k6Ix4SbpR30RLceB13EKz4jiZNBGqPcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvRNdBNhvAe1B0oK3lUGHDHbLh8Y7vE70Y/6vsWqkiI=;
 b=cugYCH+Gf73r/au4qJRzMGShUG5Qv45JgX0jacbibdQ64kmTWl/7MRjRjLp+iJlNOqPEwSsqFl8LF5UNSQnZG+JZSmxrj7Yb8toDh3hcmf3xYi4QJWevz/Kn4YHd/tu/9jEMSJXsA20t8sHpG5X+FO209Zm1m1y18yH62MY7ZIWIgHicOr3wL+nWk88HTKV1ZgIByZvDapWb2HDDtI9/mE5uQQW/V0FvQvni0Hc3lD2AwXLeFySAScOmX+ghIAEWikc5gPA1rh+LXdzK2Xk+d7u+KB7O1J2BDzQZzYT00TjKaozLckpIdCeOadTbfBDvgDgnHprYwJNC/spiT9WnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Fri, 12 Apr
 2024 22:27:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 22:27:42 +0000
Date: Fri, 12 Apr 2024 22:26:27 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/xe/vm: prevent UAF with asid based lookup
Message-ID: <Zhm1Ez3dSVYcKeHf@DUT025-TGLU.fm.intel.com>
References: <20240412113144.259426-4-matthew.auld@intel.com>
 <sm2cs4zyl7yhnumfefky5kg4yatnfhbkoombgcupih6z6v2yos@ckz475ikjc5b>
 <14259171-58af-4c64-8ed8-e210400d643e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14259171-58af-4c64-8ed8-e210400d643e@intel.com>
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW5PR11MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 5768d4bf-b15b-47c4-f3bf-08dc5b3fc495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/FHP4E/C410IT8LeKNGYE79Ds0k29D3T7P+7een1WCSiugBZFbcL73APSu61jVav8tXyucQuvO0xx9bL6uHLqG8afgqbrwKngaC+j1eVEqxkEd6dVDtB1hRhZdFQBmRHlLcX0QmMf5+EAwupIZiIaNduMqiIUkjY/UmiiiPqh2a7HMvz6Mgn11YW+X4llV4pMeQQ1FBgz1NAvZPFWpQByRfAUOmOQUfPgKUs/omlOF9jJvaREocDC4dwH/FvyDj9TzYaD+CNIWHwpyuK/F1P9alFBQAWvVZ1M6FSqZBn+kPq+LoqjwaIw9SrzWoP32UPkyEdVXc1B5CuWmdKyAUwIe33AtfZsD5nQWbeRxV0aRLZh5hwWKYpfYucvuycIxWo3aBiE9gPi8VKeMKP9SH6Jt+NL2LZk6Ay82AXSOL9sxkZOzDeFK005ri8A31dNNZPBvc6//O6vLHwqhhXcqdMpaU/R+jGTcbl41alpZ6wANXUkGU3DAFxqj2VNeL55INpyy8Tt5PIAy182Y7nhF4vPzJl20pmIEoYyKY5yVPeDDxSpvt17WDAEFBiLz1wwIB9hcqeqaBwaNn22fU2kwHyXWvjnZ9cf8fR/JMqQ/y7co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KstZoG6ZnfcWxAnVbWHcFph4dzqE5O0Pnf7AiydHNZ0WVoJ187Hty9R8Hw?=
 =?iso-8859-1?Q?4J/fRpsoLrC9HX/UKEuAMgsEsxM0XfMadipB4n4VXvWeKiwV4oAAcSI5pP?=
 =?iso-8859-1?Q?+SzVnNqfvdED1o5HQs0IMWCWxNaMisqMLcJqBUk0SAOEGI0brGtcLiLHA8?=
 =?iso-8859-1?Q?AS+wcdniKbNKFyFw5//kCvoOj4ZzeceqAXJHNtciiAeOTZDycS4geZgSCc?=
 =?iso-8859-1?Q?BeDaZ2pd9S9FOlzqJG4ESjBH4Oc4Uk9r3BCeYVzvtOp6+K+G6demY2i09N?=
 =?iso-8859-1?Q?KIpFCv1l7KFHkD5BDDqr0SUGfAMWEx1k1inOIvKm227yl3MP85AItmm3Wg?=
 =?iso-8859-1?Q?XsHJTcbqJ8Gv5fuqEpIx/zmEZXgmzCGWIZdJWq5/fJHr/wQf2utPOtIyOg?=
 =?iso-8859-1?Q?pCkrPZ2oHef0O48YU3yxfIb3ut8x6qLXYNE6MIiJ2ClNZHfGDPlE6nlalF?=
 =?iso-8859-1?Q?ksX4YmYn6ZbCK47W6sEorZx3pGcv2ruD8LGLnp9fAISxYbsH+kWGylS/7h?=
 =?iso-8859-1?Q?i8zTy6K7K/0HdopUlXwq9nTsGrzI8CicWL/smtLcyATm9x20+HpCy3mUET?=
 =?iso-8859-1?Q?JOHJ2Ky1P8dvP5gB67P9ddgK8TfNS5rcyMjLA/frGT+0jBJHlOF5WUWM1/?=
 =?iso-8859-1?Q?ltwoxZUlasT7PMrHxM8frEVD5zkqv8wrcRGq0/mTEER093aMyT8QtTb4xZ?=
 =?iso-8859-1?Q?m30nequ5COuElxDPe2uBAvnC6YNWm+LA7uHFf63gnqyUqWEBTJiX0qLq9s?=
 =?iso-8859-1?Q?9lo8wzMFndVVsDwaBlNQNnLOPn4J9F5Y9vL47Laqb2SLuLcUK707sHm+s/?=
 =?iso-8859-1?Q?NAJsw4fRCqduKVXTOXRvVmrIRniNhQHxTg4LLU5Kf1wcino2Vay9s3b+Bc?=
 =?iso-8859-1?Q?WQwNLliWZxBytIjIPvFnAmWanCOwB0EKwGxYb5iY+ocdhcyRYe378FTVgn?=
 =?iso-8859-1?Q?LtYA41xuHkZouwzY/dJ4B6iic2auq8BCQgRvS0hetFtHbTUFMA5phjVHzI?=
 =?iso-8859-1?Q?pt8Gl7EQ2Ba9GxjnoRyrlf2A5rxZ49ZM5eMH3SOCgeE0HaIPPxM6LHDnJ6?=
 =?iso-8859-1?Q?YWAnZxI+mxsaBL2BF+YilwtdCPj1Zjgqz+AMbNg0RnVDVxno3mD9QBhBiJ?=
 =?iso-8859-1?Q?0MWlr6rg2otTT0l3dnRt0czANr3O4IMavsz5EthZulyYIgx5ROoZc/1xW7?=
 =?iso-8859-1?Q?ZK8Cd0KhK7QxyBFhdvbsRMexEBBVXJ+VFtXVyXcXrAK1hYzeLgFcHV6iq1?=
 =?iso-8859-1?Q?ooDu0r3Z3bOVE7hFEoAlmZuljJ7FUPZlpGeT1M7lhd7Na0ew/idAmTgPzA?=
 =?iso-8859-1?Q?uLLKdov8op8wPWfjBnQscO0O8RRRqbH+PU5MDMh6LO/G8A0CFs59N5KHzu?=
 =?iso-8859-1?Q?PnWxw/3bnG07j+MfiNLgg7juqx24aT82IwLvy6bDe4eZY11/7djlpySq0G?=
 =?iso-8859-1?Q?eb9jtrF0LlwTIUYMt1b+VF15yXWZVOo7MJjOlRi4EcXmAKZHoqICUEBbhX?=
 =?iso-8859-1?Q?OTQnHkaD6ZH53Rgd0GadWyLZW8v9dEAT4GOOsJ2x2mer0cl3dz+JnQskin?=
 =?iso-8859-1?Q?03N0qLOdA/oQmJ5Yl1kOoS69eeXGjFfEHz+2DQ0daM7zqJrRaQy69gnwhS?=
 =?iso-8859-1?Q?IT2uIY+/1fQzNEe5u1Ed6HJxEP7XYaKorEaHm+eTWtJWePb5CZ16sZ1w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5768d4bf-b15b-47c4-f3bf-08dc5b3fc495
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 22:27:42.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDD+sZo3PGJ1tpE8C7azOqPWK49MyVutdMn1liwIbOmUtiUi1Bn97q8/N+0eKzKaIkRBdryyeGKtqFwggpmGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com

On Fri, Apr 12, 2024 at 03:42:00PM +0100, Matthew Auld wrote:
> On 12/04/2024 15:06, Lucas De Marchi wrote:
> > On Fri, Apr 12, 2024 at 12:31:45PM +0100, Matthew Auld wrote:
> > > The asid is only erased from the xarray when the vm refcount reaches
> > > zero, however this leads to potential UAF since the xe_vm_get() only
> > 
> > I'm not sure I understand the call chain an where xe_vm_get() is coming
> > into play here.
> > 
> > 
> > > works on a vm with refcount != 0. Since the asid is allocated in the vm
> > > create ioctl, rather erase it when closing the vm, prior to dropping the
> > > potential last ref. This should also work when user closes driver fd
> > > without explicit vm destroy.
> > 
> > what seems weird is that you are moving it earlier in the call stack
> > rather than later, outside of the worker, to prevent the UAF.
> > 
> > what exactly was the UAF on?
> 
> UAF on the vm object. From the bug report it's when servicing some GPU
> fault, so inside handle_pagefault(). At this stage it just has some asid
> which is meant to map to some vm AFAICT. The lookup dance relies on calling
> xe_vm_get() after getting back the vm pointer from the xarray. Currently the
> asid is only erased from the xarray in vm_destroy_work_func() which is long
> after the refcount reaches zero and we are about to free the memory for the
> vm.
> 
> However xe_vm_get() is only meant to be called if you are already holding a
> ref, so if the vm refcount is already zero it just throws an error and
> continues on, and the caller has no idea. If that happens then as soon as we
> drop the usm lock the memory can be freed and it's game over. This looks to
> be what happens with the vm refcount reaching zero, and the
> handle_pagefault() still being able to reach the soon-to-be-freed vm via the
> xarray. With this patch we now erase from the xarray before we drop what is
> potentially the final ref. That way if you can reach the vm via the xarray
> you should always be able get a valid ref.
> 

This explaination makes sense to me. Thanks for the fix.

Reviewed-by: Matthew.brost@intel.com>

> > 
> > Lucas De Marchi
> > 
> > > 
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > ---
> > > drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++++----------
> > > 1 file changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index a196dbe65252..c5c26b3d1b76 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -1581,6 +1581,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> > >         xe->usm.num_vm_in_fault_mode--;
> > >     else if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> > >         xe->usm.num_vm_in_non_fault_mode--;
> > > +
> > > +    if (vm->usm.asid) {
> > > +        void *lookup;
> > > +
> > > +        xe_assert(xe, xe->info.has_asid);
> > > +        xe_assert(xe, !(vm->flags & XE_VM_FLAG_MIGRATION));
> > > +
> > > +        lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
> > > +        xe_assert(xe, lookup == vm);
> > > +    }
> > >     mutex_unlock(&xe->usm.lock);
> > > 
> > >     for_each_tile(tile, xe, id)
> > > @@ -1596,24 +1606,15 @@ static void vm_destroy_work_func(struct
> > > work_struct *w)
> > >     struct xe_device *xe = vm->xe;
> > >     struct xe_tile *tile;
> > >     u8 id;
> > > -    void *lookup;
> > > 
> > >     /* xe_vm_close_and_put was not called? */
> > >     xe_assert(xe, !vm->size);
> > > 
> > >     mutex_destroy(&vm->snap_mutex);
> > > 
> > > -    if (!(vm->flags & XE_VM_FLAG_MIGRATION)) {
> > > +    if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> > >         xe_device_mem_access_put(xe);
> > > 
> > > -        if (xe->info.has_asid && vm->usm.asid) {
> > > -            mutex_lock(&xe->usm.lock);
> > > -            lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
> > > -            xe_assert(xe, lookup == vm);
> > > -            mutex_unlock(&xe->usm.lock);
> > > -        }
> > > -    }
> > > -
> > >     for_each_tile(tile, xe, id)
> > >         XE_WARN_ON(vm->pt_root[id]);
> > > 
> > > -- 
> > > 2.44.0
> > > 

