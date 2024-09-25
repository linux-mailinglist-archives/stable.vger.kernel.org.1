Return-Path: <stable+bounces-77717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA49864EC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2571F26229
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973543154;
	Wed, 25 Sep 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntGqkhX6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CD3A1BA
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282169; cv=fail; b=uzWbAzPYdktdA9y/Ll13rOCrMjYIfJrIhb8XtSChEnD3k8JovcxjVYENUUF9uq3Mc3d6bJXbKfYfSTUfIC9zH1MD5AQxhpUdfcO33NeYSnWKtftc+PSla6QGe7bl6Zq1aLpNQA9yg0Gg+NLE2W1RUT9sx/oMIX29H3nosfwNTJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282169; c=relaxed/simple;
	bh=kMLT/Y+QYCKr8chTTd7S7AwZPivicgXsNgNhajYNw0A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nkvshZF0n4X1hQeHCmJ3oERZOKogGHa1v7LMFAJHhfPjec7O7dCdlNRyi0tSYhiGwZ0aCBJXDtngM0u4E7CiFIKDdk66g4gUJKGlug5b/NgV9ZVAy0mid+77ip6+1lWENEqcL7gguLmPzm12USq9Hh0lP/lyBrt2TvfKX3JJI0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntGqkhX6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727282168; x=1758818168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kMLT/Y+QYCKr8chTTd7S7AwZPivicgXsNgNhajYNw0A=;
  b=ntGqkhX68S1AWhk5+77JsvGlGcFcJ0UWQEVew+der8VQaRvVxIQ8Amdi
   kR35dOIziIy7CCJ9QtCTamPyqlwOwCfTqttzfNaqk/mHo2gByVa4fpn4f
   xcOT05lWAy7B4tIFchXCM1JYWln2dI7Ke/GUdep/it2Ma+LonAHo/9V/1
   XjL0hgw2nppEp/u+VsA3mdao0mODcqXj7UEZ03cv5CxDd8NThI+oiJYJP
   ms1adWyNWXsHU3lCWhqzR0/cEjF938brgfYcvSZKckRNb6Ad4le8s0f3q
   CblE8ROB+b6o9ZBLTw0OrVtLvDYLyJ2IMQt3rYu1epx2rZkYX/5nFN7Rg
   A==;
X-CSE-ConnectionGUID: YN93eR3LS0S+ersFZgl1sQ==
X-CSE-MsgGUID: pQpItcivTXWHHWS76a4c9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26216622"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26216622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 09:36:07 -0700
X-CSE-ConnectionGUID: /TuIHTpPQjyo8BseSl4wkg==
X-CSE-MsgGUID: bFkhRcd7Sky5hqLa7KX9Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="76763011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 09:36:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 09:36:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 09:36:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbVOgTdlnUNa/1tkkjEXApYFvSVPBjrTiBMvZLrlb4eaq88GZKSsEjMXHbC1fm8B0MGSa2D8OUNCkr2kFge5Wgup5PQvS8vtZtRmKkzIIxGasu03gYkAtfaq/BpglI6o5NeYXs+U4Psf6Z4xnlpW7FW31EDJVoDEhC7lgmg1QB0B9IkYx0JaZlzGwhndKSRUrHWPKRRZXjdLZq/idx8L2i1QBFqzK/UbJg1fSAMeJH5qEi6o5/ghhw5UAQWRjQhEmgXMeRdQtnArSNXcYYLsD3HAGLNL9sp+g701dKSZBS2dGlBmqQx5OJloGCVAwv4Tz9Hxu3E4IBRHpP/Jpz8LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71jxrCmdVwGbOmk9oV860gxNo+ylWf10hjk6FOb99do=;
 b=yQg37rilmV9x8G62K6acRYHfYupuCzjPkoq0Y1M1vwzvLTfNZPnSHupyt1ckY+PCAmfBcM49cnRcUm4gtOlrR1yJ6AWySGLDRpJ12gVLeubd+1gzFbs7jxNtKRTDxnVwNyQg8rsF4UZKfr+KqgiRGXdrX3tVBUyYSTuvdOV/CWHiVSRenYys9h3+oCGRoM5XB55E3DZPxOjKWjuu6yEpSTu7C7/1IcCBSExRh488f/UoFEXS5fJcpsLTu9rYjYXg8M1+32Nt1QN9r6Lh7aXZ3ktuzEclVEqzuRiJntyLcc5rRZ96cf1kWyat+2bQlDz2AwQnuO4w4ebOhnou4b5Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 16:36:02 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:36:02 +0000
Date: Wed, 25 Sep 2024 16:33:58 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm/xe/vm: move xa_alloc to prevent UAF
Message-ID: <ZvQ7doZ1OdK4e4Ax@DUT025-TGLU.fm.intel.com>
References: <20240925071426.144015-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240925071426.144015-3-matthew.auld@intel.com>
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9f9337-cb84-4aa7-5fc4-08dcdd8024db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/jHNcfEbqBAXT5Yp7pCVvbdNa65q1wk5vxingyBtU6CoxUhgT0VFHpxDiq+?=
 =?us-ascii?Q?/Fq8TvS3KQzGfAOR3Y4d+FKX7GrIWZtSGD4v9TT/PohKOqGbwHTtXeugIEPN?=
 =?us-ascii?Q?rYcsqe4p2QWANT8Zmo3exj2RzMb6uxLibr/te1T9uYnfHwc23VWs0UJ825g/?=
 =?us-ascii?Q?We2k3Cm92kHqzvoqOFRqoeKVGEYQdl6gSiZnkKXFCwOxtwOz9zXwl5Q+4LSZ?=
 =?us-ascii?Q?TDr33XtA8XgDboIhTBKqbUAUXzDc5WXlRMDT85By00z7Nog4tZUYkdLNu7lh?=
 =?us-ascii?Q?sHLlyuML7GuL2w2w9O/c55GTjSRZE2fEEoqYO/5sIVaoiK7J7U1RkAdBp8wW?=
 =?us-ascii?Q?my225si/bDAUGq9JgTD7VNgtOHTgayGEX2oPo/alHsfBoyt6bjlgkQNjOGBO?=
 =?us-ascii?Q?EgC4jgxISx9jNT8shTfoz1tUCZ3C9cZbC8vAOQAvED0fEb2Q6vE9D02b14fH?=
 =?us-ascii?Q?EpcHk98Bf8q93Je7A5YrFMAN6GwYYOBX5GHgD0p4Sm+Ml4RlEu18rT+4jPzo?=
 =?us-ascii?Q?J9qH+Sgt3NAg+RccQFEnESzQIaVpdMy44996mu9T9x/DzSgtm8WRx7lkedJ2?=
 =?us-ascii?Q?c2I7Io7n+ejspCAnfeu+KM453CcFqR3mU6x3q9C49Zj7K1DtJcLUuowy18cW?=
 =?us-ascii?Q?fns0n8yCgHP7Nuqw0t/5I6Qvv7xmGalSl42ifivtrq2ew4ed3q2NnKymxKwE?=
 =?us-ascii?Q?v8NdSdRF03PzbeLUz6KY3rPbFeN44thyVhuIhXRrtMfSqT3VKpaiATZH5E+H?=
 =?us-ascii?Q?rIl85u7L8twiTCXmWm0kbb2+srNQXOcZof/trkcYwPMpROOXigw4vIs03OD7?=
 =?us-ascii?Q?jgM6xggb8i9+9/GORKgA9YLUFhPWCtSFyMkvwOuf549R6SSR1R55p1W2+KpW?=
 =?us-ascii?Q?piy6WCm9OIyYKLgfPcghrofGqp2Y71R19u9Jm2pdYrzAqMyC7CEfZ87k+TmK?=
 =?us-ascii?Q?xxHSPOX2pH/+j03uNPiKd3tvWPQAtzSKbnTEQQburnhCtp1xbGg5mWj1WCvI?=
 =?us-ascii?Q?FBmC8qHtfvpNykn0HERNEn7cd+lxfSYuE+ZRjp40OwsUUIXwXKBmRbJoNn0B?=
 =?us-ascii?Q?DqH86zAcrn0Mdat7mmHjwgdh/FHMiCWBMWtcTO+p1uAq7PQoiU1alWAC0j+i?=
 =?us-ascii?Q?QPp2yeIN0g/3mmuIxbDboGorcVP6cWUHFc5iYy8WwAH5YlQAZWYTF51PJIGJ?=
 =?us-ascii?Q?/dtVO5SZDzsbAhoIO3pe7r5Q/kMcFzJIpF+YWUip/sRzHqgHHeYBsKh+Gl6J?=
 =?us-ascii?Q?6SkAQyyafFT6mR3VrQk6hMEhRnlO6zBfO8iasaz9UG1O9G2kSZj6uMdbCwGJ?=
 =?us-ascii?Q?rt9xHzn2n0Y2c7BdQmCWPmAIjmDuOQ6NAZuCFv0AmnP6/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQj81PJ2/VyQ2CK35hlZQ9iyX2zLjkflf7JsKIzTKPXTCd/Opb+ZMDtj6vns?=
 =?us-ascii?Q?idJcFZ1Q9qIT0rEp9zYegqR6+CRaCBQZo8PtqPbLRVY+raMntYSjxW7lHsu2?=
 =?us-ascii?Q?GU09cySRmpAGxbV/Dvc/4303zqCvfj3MLS/A5mfB9etuQ2vLHdHQ4OPJTdkI?=
 =?us-ascii?Q?jxqu80q+Avo1Atim9zNFagOn3+HT2TnyH9X55KSsgQToU+fzD8OiRW0PRC2O?=
 =?us-ascii?Q?JI/6lN8sqRkJ2FvhGBeP9GBMdMHuh8o6KVaDlVU12yghaChwrvkgLoy6UIOI?=
 =?us-ascii?Q?1JgwlX1+3QJorNu7xNpu8cLRQEsI8j4xDXrY2mntp7aAKtuvlcwAJkrlLnab?=
 =?us-ascii?Q?swYvji6iOTmEQscUy1O/YplgS9jMSEBhlufAPop6lvn6bqG3m3gw++25Ytqv?=
 =?us-ascii?Q?AGrlbz5d30iqUkTyaTKVFAlqb7pLoY5zl6PDF5myFPi/VSDAGAdkDEu3kXH6?=
 =?us-ascii?Q?Rx6yyhRR3K6Dkzm2/yJfruoy82LPUdR086S560vbsHWgLJ5dmQpRUGJfHVvm?=
 =?us-ascii?Q?YYz+TDJu4PqEiptFpAc4OKaREWKB90Z09Wmgz14XjNZ1MhCtHYlrTYshHBiJ?=
 =?us-ascii?Q?6Szz8KY4Z0AIRgdvgew6NDTk0VNzg/nGj3b2dm45sp2Vx+f3N+EZ1nGBWx6t?=
 =?us-ascii?Q?JuUf/BJ6k+EI7z1BbAZRk4/jOY//+O7d2CIQSsVDuK+2Uz2K14Jk5Z7lW5dW?=
 =?us-ascii?Q?pgtriOpVZpTnG37Fk06cSMAGK2GeDxMroyir7tihqs3xWdCo3MkG821PwQa9?=
 =?us-ascii?Q?ll+TG0sjOaLVvlxXxUA3AKRz9KSoi+b+OQfxo2iXkH/msvHnYurnZooVL/+A?=
 =?us-ascii?Q?5XEPT8v+/y2WOAy1FukFaZIe+4J9k98mpi+wL/cUTIeRzzJYqrUakV59HntC?=
 =?us-ascii?Q?ghJxb5rERuxCcicu9m0U9Oh0c9p2kxOr0ewqs6SHrUHVbJC+g+9mm9UNzKqM?=
 =?us-ascii?Q?9sZhtyn+5YLJPjDJyv+UzGh73nUBzpTKdVwHMQ2shOqBqWZWRrFH0tzgxojB?=
 =?us-ascii?Q?VZgsE7Oo6exRj2AP/wXdk5db+PGcKVzV2es1+98U0d5YVIGXLXqZgkoC9uA1?=
 =?us-ascii?Q?C6Rerrr+T1/s0xVPcb99+/H/6pEDLK+f9TnwfAsqKEdN+/9EFnKgxdE0D3Gs?=
 =?us-ascii?Q?5eQaWoNhTwGON2BWkROKCatvKEcwwsbWMdESa9/utn8XZPhQATw9tH7deZHO?=
 =?us-ascii?Q?iGliQiFSAYl5AM+9GoqD4NPrDP1D0zEd/tAG5ZT634/wP4o7J1tiksSJAya7?=
 =?us-ascii?Q?Jmtk1MdLjcq78K7bx0QJOR8JKNT9jzmrSGiOZbwsV7hqO4HUMOvmg8Xu4sEG?=
 =?us-ascii?Q?uO0nWtt39qWg9vx0GowFexb446dLZL+r+JXf9ijml1x16iXYhcmJ+6EzFpYq?=
 =?us-ascii?Q?FkXeFlKvSAnpAb4J7KVdX7mkMXwT9qKwmcU5AV0VEespK2jgKfSCmXKVgpFS?=
 =?us-ascii?Q?oSFo2Yb+1mqzV+5gge6rnMTt7fFUjRrlO908Lkz718IHXO5gjS7bTJ8Lyf0u?=
 =?us-ascii?Q?ldPmVWcaO5k6B+UQE2ueLFwOaAdbZe0Y6PvLYftfXdA7QnJXze9RzZzEVre6?=
 =?us-ascii?Q?ULrJPD3bWrcQfxyK+t2pzFu/jnd53ZKhKOR4ApEAcXES51bykzS+ofvvpp77?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9f9337-cb84-4aa7-5fc4-08dcdd8024db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 16:36:02.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pZsad92UabeMaUDBfIy+gkHedJkEl/VCMdQCF0O1qe1QD38We1hOlEgd2A7DNaRFCz6ToajKKB7pxSkq5NyDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com

On Wed, Sep 25, 2024 at 08:14:27AM +0100, Matthew Auld wrote:
> Evil user can guess the next id of the vm before the ioctl completes and
> then call vm destroy ioctl to trigger UAF since create ioctl is still
> referencing the same vm. Move the xa_alloc all the way to the end to
> prevent this.
> 
> v2:
>  - Rebase
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 31fe31db3fdc..ce9dca4d4e87 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1765,10 +1765,6 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	if (IS_ERR(vm))
>  		return PTR_ERR(vm);
>  
> -	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
> -	if (err)
> -		goto err_close_and_put;
> -
>  	if (xe->info.has_asid) {
>  		down_write(&xe->usm.lock);
>  		err = xa_alloc_cyclic(&xe->usm.asid_to_vm, &asid, vm,
> @@ -1776,12 +1772,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  				      &xe->usm.next_asid, GFP_KERNEL);
>  		up_write(&xe->usm.lock);
>  		if (err < 0)
> -			goto err_free_id;
> +			goto err_close_and_put;
>  
>  		vm->usm.asid = asid;
>  	}
>  
> -	args->vm_id = id;
>  	vm->xef = xe_file_get(xef);
>  
>  	/* Record BO memory for VM pagetable created against client */
> @@ -1794,10 +1789,15 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
>  #endif
>  
> +	/* user id alloc must always be last in ioctl to prevent UAF */
> +	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
> +	if (err)
> +		goto err_close_and_put;
> +
> +	args->vm_id = id;
> +
>  	return 0;
>  
> -err_free_id:
> -	xa_erase(&xef->vm.xa, id);
>  err_close_and_put:
>  	xe_vm_close_and_put(vm);
>  
> -- 
> 2.46.1
> 

