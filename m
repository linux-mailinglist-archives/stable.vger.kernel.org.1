Return-Path: <stable+bounces-83509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A237599B001
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 04:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5D8B227B3
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 02:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB9D528;
	Sat, 12 Oct 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPaDpE0v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107FDDAB
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698965; cv=fail; b=uFVIbNmiA845eHBKBDzboLgrDjFeM7Kwt+cAeIeh6Sq8ws+nnUDi32BQTfaLrh65gc2167UBJpgFM+D8hlQSZs9yEy+7sf1vgcJ5HlpyO470Ioc3q2jnx8lTK5y6o9fiLHE9YE4JtQSyMaMyxNhce12t6RrzXodlmuGrFxWnM2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698965; c=relaxed/simple;
	bh=rWkB2+F4R8nf904I16I5LMI/QriJwvMMd+mytL75Sjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eDBM3Q0WJwtSHskf76YuoEuZu7G3Rtm+YJYWwMInPIwXYdpwI02RgAelX67FV5OsOGwfX0KyUK9wYTvRbQyrLWPt8sAdt+MkaJuzm73+gtS85aO+04g1WIUe9ov/wKKA8GEGVakWnyiAabn/o26XW9zuGqQpayST40jDxXAcAII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPaDpE0v; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728698963; x=1760234963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rWkB2+F4R8nf904I16I5LMI/QriJwvMMd+mytL75Sjw=;
  b=QPaDpE0vnPHx0qyBfVcltjhqH/vNDdI8HgCuuOR6f7T9O695dPVMcB8X
   XanZNboKod8Ar1qHv9jQbnwe16uMHoPWSxVPX8Px9KPZOGY49tPHsTKVj
   7kEMJnC95aTm7Ha/vlw0I/rXVRmbTA1Xtosnew51ZxGRuurzmmaLYu7D6
   B3Pu/1ymyu331IIALiJeJXYxKuERIfOHr9Dy9eYd6lRMGUfGZgtb4/iKk
   LDvJivEACozLujU5paQrRls54FOizv61358o4KHi2HUK2obRzoZVQ+9pq
   rltLxGtV6N6mJL5j+vz0c/Y2GJqB3Q2MnDhwnAnGWcr3oCyxsl8+2MLBp
   g==;
X-CSE-ConnectionGUID: IHtWvAUcQkKUIU2SSIqlBg==
X-CSE-MsgGUID: BpqdvME+TWa2KWTuA7woGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27589752"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="27589752"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 19:09:22 -0700
X-CSE-ConnectionGUID: QhV6rTrnS4eXwrCnQq1shg==
X-CSE-MsgGUID: IGSmDEgLRzKRcxzh5qVpkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="77380174"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 19:09:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 19:09:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 19:09:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 19:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNaDSrC3kFKfXGxrKmWP8iCF0ZPTDfzo2i6nrnhSe1KGHXzs241mHi6f630qZiRM2Vc/tjOAEkRIjy2pYJBcRaWSke+jQf7t55/37TxtoRbBnAjVIK30uOTkIbbC0stsys/5s4dHsc4fxYVGeJtlQhMavP79URSkEdMlBAhGvHwtfigr7cmkORum0wTO7wJK3mqUc/qgXqmS4BvLv+VnPZUb7M3b30xViYPz0DPZmD5+PI9HD06gs/aHkEJmGipKm8U4LoXSO0ZTytwImTp1c3fkPTHKV6Am8t1fYfG45OfCzFsTMzEsY0kxsmzcirTyL/7f4tIB3V2rm/KlH1JOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oakxg2YVlTrc5ZoUUm+BJ8WyK/3GvrhnMBUlXR7DICc=;
 b=ORZyc29bQMN8LA4MYjMy6vk0u4aPEogBo4odA9sM2eszgaVLI4zg4Q5ScgJxAMKfLgyFfKBlZfechoFNpSlRYubxPc8YlAoxXVslamA1NJUtGUulz/c+erUHoFvlWGcg1yum4VkafkGnDF4EemsBMQqn6IZMqIq3daRkcpENbMDKbcgdodL+OzjP6ha9qEUfTVKrUKrJ1zKAfwoj8Fx6ElHkbG5HFl3l96rqpV30HohINPdM6Sdu5+Oi7EEjD5ASzO223RchGRcC2cYpcbTpFTXUN1uoybqdd2xinTmrdshnsxE5fbhp2R4YHPEc2dtrdNaCQ3eJJsrjE/7FSxfrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 02:09:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 02:09:19 +0000
Date: Sat, 12 Oct 2024 02:08:55 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Mika Kuoppala
	<mika.kuoppala@linux.intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/xe_sync: initialise ufence.signalled
Message-ID: <ZwnaN2zrvtEwPgzR@DUT025-TGLU.fm.intel.com>
References: <20241011133633.388008-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011133633.388008-2-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb09e9a-3cf2-4065-5a39-08dcea62e1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I4E/at2n4Qv+EE+JL0Q6qk9s6PXRJDvxp080qzfvMzqq2IG5mTXIB2xrq/mt?=
 =?us-ascii?Q?mtSNrgpY0ATlkxEQX/kTUebHqmITVn/W606px7sg8iInvN1MH5uuiv2G/TWX?=
 =?us-ascii?Q?RjgaTvAnxgs/HV2HHB8bwQfZMa0mlzNiCMVdoGj12sb1f6uFoU0iQNNwD1n8?=
 =?us-ascii?Q?HdRZEqZfPbesNG1nTPq1F9y/f2UL8mYlTSi8wlETUQfsZnVe+ETOLED8eH85?=
 =?us-ascii?Q?X3cwMYYqqPNYYiBID0v1oALEMpUTTGVG5i13+jsioEJVKc0A1uO3LGCqWQ1x?=
 =?us-ascii?Q?jMghcDBEB0sNGEEfCRlyEsaoUmeqmQItjT2DggR0TlLVH/PHSeW/2Xc+ym2I?=
 =?us-ascii?Q?pfL2RKqW/UFZHjORwRU5fNE/lqL2mVJgOanvp5LXC7pKUXjZpndBVjcwg5bI?=
 =?us-ascii?Q?6LZfJmTAHxLOIK5Ww/IS2oqft0ZFpUraO3svKI4Ka54k06DGEFaKAEjME6UV?=
 =?us-ascii?Q?RjyN3HbQjqfu8BCPhWhZROKTredThoNfUuYJ5cFlFjLeJWLkzZyr4VqcApPF?=
 =?us-ascii?Q?bdpv0/tVzvtC/xhbWPQyQPpO/eXWdpSQTt1r6tjeWy5HFjDo88CVquCTrvwY?=
 =?us-ascii?Q?IOqh/pV6jsKjP8CAsa6qsgxMc/1XhqtQ6l8bidqB4/+Sgb9+/quFB0ZxixOt?=
 =?us-ascii?Q?mExK4hVnANNzQwyNhuEEH1+g7cPtQI3oTdr6YMlQjqi0d0o2xpKBfo6pMKeF?=
 =?us-ascii?Q?5p4GWQ4ChCkDmhcOqNpYt8ASoY6jnIU1tlBh89fEe95L0ZH4EGtgWdq7zXSP?=
 =?us-ascii?Q?8f9OGFl06h1grJg75DOjUgF3GKATEUIz87crDJ5iQBtj8ywe3DIY01PsqPEo?=
 =?us-ascii?Q?yJ4H1UEtds9z+SnUFRk6kaUiMfDbloY1oWbexXAFg2QMGeR4SwSTznk+Zl3Q?=
 =?us-ascii?Q?MK+3GmPnHcIPa+lFFsBUAnPrFxznbYYFfna9GuDxEcr7a+oAt6Xen7a9EPaB?=
 =?us-ascii?Q?ZLZgvZ8CHeEF2plRhRgwdHK8GOG2FMPkHN+NApD/XiBQVgf3+PC1ZF3ru3r/?=
 =?us-ascii?Q?z4+DEn9riU7iac1X/Qsa/LlIdKWge8j6I4lBQhi0EsMqTtj8r7zUGtZ0jzhm?=
 =?us-ascii?Q?t/VNEZyhky5LQv+9QffJkOq3UeMDOP8mgFBnj+l/fDtgUlKDIFF4AzRyrYNE?=
 =?us-ascii?Q?+8ndehNm/SvX5Ig3mq0Ym9xPXeCb3P9I5bfCI85kTYB6m4Iz2121AjD+rRyD?=
 =?us-ascii?Q?DelGb0SRJPa2Tu+UsBNR34wCaG0mSGluCl3lC3bdvVHBbdeLKn7+Q5YUrtHC?=
 =?us-ascii?Q?06TByqjTVXMtOb7Ulw8s5E0eCJ9+KaY3gIU5i2Lbag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+VJfu2iBvy+3265acuLB+vhGxCbus52sZ6za/iXi9GxMz0zE7eUVeZ3lntG?=
 =?us-ascii?Q?+UaUKIyjZbhbBnC/NUfAfpvT8unMdEP0Ln5rOvE2i1xES1MAjanne6ZlQjLG?=
 =?us-ascii?Q?pwnz/TbCe8rqRSiNoPehk49ES+WtnBA1fCaB+lMrZVVL0sazbDdbPmcsCfoT?=
 =?us-ascii?Q?bOonoz+dpCCWSkEvQnLsVCiT/zQBY6u2S/G4WhDGAjW1bz6Qjq3DmE2pMkMt?=
 =?us-ascii?Q?WNj/MB12GQHLhOu0bavqAJFZ+wsXONXyiC3JsdUPnPWhlldoowmvLnQQ7jvb?=
 =?us-ascii?Q?F0kTThhRiSFiDEBOx94/TK5UrbGK82e5+Ix85NJDjjlMdFMbFL7Shr8S1j85?=
 =?us-ascii?Q?XMlIylW832OQZeQyhL4Xyb7FCkd7NkjDaaFUieo9AWRjbVSiKHoK81KiO+F+?=
 =?us-ascii?Q?I6AREejXq95U5R2Yx6UDS2bf7pR/Kz09exqA/QrBw+5GX3oyXoL560hSZYsR?=
 =?us-ascii?Q?joyPxSHe06xtc6UMMEobFy18vdyj/uMNxR1Ess+7ESY8PyDaUjVZWB56yt+o?=
 =?us-ascii?Q?x2KpxmNfwOgCcyr4QL8b/D1NWQcgdbodd/jntkVVoDpRhgHfwZHWcCDyVFWr?=
 =?us-ascii?Q?MryL6oNoHonnwIyiAVYkZkrpJABqGazZyc6f7LNkJN4/hfy35UeoLGnGO/ID?=
 =?us-ascii?Q?IgpodJYl3zXJZR4f3Nmxchb9PVv+kVqHTK1chDM6YDjvsaIHlYxZLaxJ2NgT?=
 =?us-ascii?Q?EoxeXrAnYwI5s9gl+CyLdDDOOXr6v1MbSC3cT6aSr5aWps/HzGiXJBQhi6jJ?=
 =?us-ascii?Q?IPPW4ONSu6ebXprxbFzwS0ggh6205NnEin1R2Ti8m8+FVhVA5i2ENXxBxiHI?=
 =?us-ascii?Q?271W9Jzs5vGSN5B78z7ZJFAj4i+TvZDm98q1CFxYU08tB6q2u8MxiuqOqnk5?=
 =?us-ascii?Q?8qMil1YjSqvVVN19YYVI95fsGYDpmR2jeCr437pIfP2ovVW+I3Ch0nrF5pqC?=
 =?us-ascii?Q?NCdmlw6VogGGwxZMH0vydI9x+FN+2NoOlM2mFvtbrVE0AiPiJAA8YQy+doRs?=
 =?us-ascii?Q?3Gc4Ia5Nia+AkGdA6RgxTGPictJuLIKHg625JKUMYtowjzkAM/5bWX0jae7C?=
 =?us-ascii?Q?8bzfTpTaPF2hj7CrFDXi+yrHiJST/DZIbzS5X1hJCCYwjgGHn/Ytyi7GdrAO?=
 =?us-ascii?Q?+Z83OMqxl8H4HyaVcWXq6sAhjIxqCamL3xVs6vhL1NW3Wlv+VqYg99UJrDIb?=
 =?us-ascii?Q?lDNNx3sy1lHyeGae3izip4T9uc93YY0C0NcUQtTCm+aepZcAyuyB0lXXKjl1?=
 =?us-ascii?Q?7fu3GaHOQzvJOjVm0GMKVAg+j+OzOlU4xDuM+GrBe2oLkKokZqOUldguMbTA?=
 =?us-ascii?Q?RzvLWispbu+TWkU6GRY7qs25FqYb/XCQOZWfGifQFos26Bycz8FM0RNNcoTj?=
 =?us-ascii?Q?45FmSh/llOaYX4oNI00xIiqK69S+4FBc1bNVmgJZw0TynTcIJW56ChOiNddb?=
 =?us-ascii?Q?yBVWUNl9W5aWHV4z0yI+Z9sEB7rclHPq+xKdM3f3stZGpEXzruXzm76EmUSW?=
 =?us-ascii?Q?ntfFhNLXIfAT1j+0r248pFIG8ZEBuwMcRw7+3Hmn0jne7bJZ27qoxp7ebNJV?=
 =?us-ascii?Q?DR0Lwoie8pgbVWQ8X4+ud1hqTcfIqgIdTEOXrspOPeQj7yfVzK7+x1zuwBtW?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb09e9a-3cf2-4065-5a39-08dcea62e1a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:09:19.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ygAyMcPwOfbVgc9yA8YXcIFzj3eJpBbD6PtELrU0gQeJuPRKRos7xJBGOXntUY2rIcNCqBbfipvREf9i6gpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

On Fri, Oct 11, 2024 at 02:36:34PM +0100, Matthew Auld wrote:
> We can incorrectly think that the fence has signalled, if we get a
> non-zero value here from the kmalloc, which is quite plausible. Just use
> kzalloc to prevent stuff like this.
> 
> Fixes: 977e5b82e090 ("drm/xe: Expose user fence from xe_sync_entry")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/xe/xe_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index bb3c2a830362..c6cf227ead40 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -58,7 +58,7 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  	if (!access_ok(ptr, sizeof(*ptr)))
>  		return ERR_PTR(-EFAULT);
>  
> -	ufence = kmalloc(sizeof(*ufence), GFP_KERNEL);
> +	ufence = kzalloc(sizeof(*ufence), GFP_KERNEL);
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.46.2
> 

