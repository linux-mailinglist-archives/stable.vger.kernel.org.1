Return-Path: <stable+bounces-39314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C3C8A3028
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3292838E6
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B185639;
	Fri, 12 Apr 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWSFaxSO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A350241
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930869; cv=fail; b=g0f8dYyU70W/4bIGGIrORIw+UsuWGoKgNIslaPpw98Gfc8qUgehRQ3S9RURWt2ey+c87urTmUX3M0n+KNKW/5WzJDbUNTTs6zh87eXTpxSA2Jvneokiz+euWi//M1IyH44nvzlfjUIijnBZNs1PyKk1CwjC5C1RWq0Sf0jk8nd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930869; c=relaxed/simple;
	bh=TsIEZ3uyZa0gtHkatN96Qxx+VeAZhogFUNMrcGeABFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMmk+IirpXRlyeUi/Sni2rxUGmaPK41iLVl92n8y9cCeN2dXkvORDvfalowq4eM5UQ3gS4NZlZrdByUZR0WN8O9nygvInBdFTQq7I4Jf7U1nEP2RpKUFOVN+gQ/hSuX+AfqXOiRtUiwtJICZ8HK1nAZQNSnnSgw62HHUNtutXjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWSFaxSO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712930866; x=1744466866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TsIEZ3uyZa0gtHkatN96Qxx+VeAZhogFUNMrcGeABFA=;
  b=GWSFaxSObNi6nABpfWvKCiAWBRdmGOutYvIlyUWWFin8defbtD30N/Yd
   9NIYV4DMZ1S356K9OE3stYUd3YBefhDbOBtBfdHglSSQliayy8DMag9xX
   kpGPiGSx08mr7RrwJiMigWC7/ipAvznxkxvnS0g/ZhktlpouOiWLVUY0n
   rGVJ+wfs9kJpsAzJN19FrRFfvzIbBATKvghrC+LNK1w70nmIp6sJI2ak4
   5MkRk6JAf/ry92t0wuV6Wsloy0y8saKi36i6rWolmTR62Ld878suchI8Q
   pturgvYgP2hSm3aJ9a6oakShXSVfDQB9WTZOvqSeDhidq1b1mzn+eGIaV
   g==;
X-CSE-ConnectionGUID: OILX9m7JQJyAU36Olx+NdQ==
X-CSE-MsgGUID: XzCwg4V7RZqewPSN5eaHdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="33780624"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="33780624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:06:32 -0700
X-CSE-ConnectionGUID: 8aXJB6GoRnGwLcgNCyxC6w==
X-CSE-MsgGUID: Baww64NDRZ+CMtOICLZWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52206362"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 07:06:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 07:06:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 07:06:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 07:06:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 07:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pifx3+ADQwQEXxd1QH0Bf38/trgsKCJ5RAAg+HuXk0oNLEKacrAMtkTkyfb9kpGEezl/bbDSsTXCpJEP9wIJ6iRTXpShVkMbx2P2xYpYJ6izupSxFixHhvTAJWBAk1Lfp3PJeA26Fq0zQ2fl5ZYBnarOeI8OWkMQTlZk2V7NVq+ZEHW1F6Xrh20ajaki2FLndiaVtrOQeVrkeujir9amhTiVwSeD1If+55x1sB/olcF6RZv34hYcQHA2673KrqaRbw1iNkP9gRvEzwJFxLt5CVHmNVvEE1RYXkQzgGHezrTgRXKxX1cEvgyLqAMPen2GlijgpD/17aoAvK8SsnI9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUh8PVCrQEGWTWwRzfoLxGJvsnS6QHj6gR0/z00htBs=;
 b=mwigGHh2cIDK2bZE5RpD1O6Y3zP8vy0l+7GRAynjp6kFnTEMQ8qHw+BzZvZX+H1rF+X6665msHz9Hge13R2lar6iFrcdcl3fxllrZTMa/Q2S0HnnMPwkrWq6q1yZY3qXpcJd9MHg4/N8nbqeTreDGtNzzDnPBJ8LL/kzwqWi4OQvJOehurW+ic/wukxbXiuVB0RxkRf5ezzMBAOF+gOZby/ep+irxIKH+upEgB1FTi3OSV/dTer6QBNbDeMRmTqSWu9rGIln7BhhIcXHZftmCEJ9kyvKcMonNCRXYQvw7YN15DLU5TnpQDXxsCF9grSpUhHFB2jgR+9lyhZOTxjOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB7194.namprd11.prod.outlook.com (2603:10b6:930:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Fri, 12 Apr
 2024 14:06:28 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 14:06:27 +0000
Date: Fri, 12 Apr 2024 09:06:25 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/xe/vm: prevent UAF with asid based lookup
Message-ID: <sm2cs4zyl7yhnumfefky5kg4yatnfhbkoombgcupih6z6v2yos@ckz475ikjc5b>
References: <20240412113144.259426-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240412113144.259426-4-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 908101b5-e9e7-4ef7-b77d-08dc5af9bef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLuDHWYeQZCpb+u8vDaXd4kwGyeqwJuheEGAhQaVpTqT+8VH8napnT6ifBdmI5EfiZEISE4MsSSoePuVOAQqyVB3iRlmZn+z7zGg0Tus3spcxSYNAa3q6cfxgFw+BqGFqEzXvS+2x6ZNZMuvCvanPOGs5R8hgkAGDJotkm6QDXxOfyDpE3VgVXs+3XV5Lm2BjnzXGnZo/kqmdH4V4C3RXk2CL8XWgWNiUC18QcCIQTdT2R3Hb90ebbH42gBmjkGi7dCY8zPHbkxMyhjgJSv8QaJz/oGa6VIhFPGeHaW86rEyXQPvJSsNZSVXaNar1HvclQfvDX1iSV9dx6UNXqgcQigBiTH/GMj6bVzgdhClVbAMaV9ns0FJwBQgyGtwHoz7J38OzrFNmGEAs9aLq2cgKdSWUKvfeRa1uk7M2z4XWxYnjS0f4/jhqJO3Y5sG6R+wBob/w+JVoJN/1Zop3zwkNX4Bqbx8+PF6YfenuNRhXY+1c7y3ipuBnI3eiQ4+pfhgWvw40ES4qu6a3WAKqL6vgauMv8iWqh1zeNJ7lpHR9gLr3RTzFKW7LWhhjcPqEj8mK6CY4dGSny0nQfDK28kGTTEXXqQKUd65wqushDo0wkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uj0BhIa1HGM+KWLbTPTjfB4gHZ7k0LBzAHMz6zI97Pq2J2mz+H0LOadhJOwN?=
 =?us-ascii?Q?o7Bupy2wZVfx7cDi0IQ4KEL7Z0qIgVO2q/F1F3U5rnGaUWReikMdOJu4SVTD?=
 =?us-ascii?Q?/7kL99l4ld+Qe8BaMTpBGMeSJKoHkP8Q0KZIgK98SyxgZXfhrF3ZcrGyrnzj?=
 =?us-ascii?Q?k6O9gayvEvNx48Ih0azkgzsVbO7hRNlJ9zrS9vj7CNw3omcdhY+hufkb3OT/?=
 =?us-ascii?Q?Kx+ODrnwgCncXtu1n2nEsqfKaGlxj0DG9TwBIOFZB/4xqj4+YhTDJUat5DXu?=
 =?us-ascii?Q?VpMfOH88E3xMFWTpz7BALULKEL1hNZg0zVcMWgS53KjzOjDNA7TMP59I7HSX?=
 =?us-ascii?Q?7+Csr/QU4MVx6ACJviyLlRSdIjkOtjKRyQUGGpVn8DUuA+nMwxPh75O+u55u?=
 =?us-ascii?Q?AqTH23kNBs7BsSVGOahKaOBsd2woZHVyi59gTa/m3xOeJTy99VwCivAV0sqQ?=
 =?us-ascii?Q?XSvSGYmgHLzzNmg/pbfeQD60PHQD9kDOXJb3fImIDYznQij0yR4rbnX120yC?=
 =?us-ascii?Q?LNQnOr+ZzjiLe3eH6gSf2OWTMeqptn+jWkA7UJovaJ74GnqsZbXqoodgp4/R?=
 =?us-ascii?Q?CiOWxM45dSRwJIukBLO+FbreYD8N5lK1BOyGv9zITLohR6RvdS7ovKyFNTlW?=
 =?us-ascii?Q?RHPoDvqAl/zagB8D8xSojq1r5oCzbHUFWxidgas9VZbsHb+gSOa19XI5V2mI?=
 =?us-ascii?Q?eQSZh308evPEpkALI+lUGCSfJ6ZJc/4aocoUK/YTE5GV8wBzjyUYJyMox/WC?=
 =?us-ascii?Q?2i6sckdUoKZlJrdEkFtUEGZrW/kN9RNjDhM81QyfB/t/67CGSShAK43n1QlE?=
 =?us-ascii?Q?X3lJxo5030R+dCcCgKhbcx49R8F8k/YuE3CksrOcqB3RZhx8hep6kdqydfot?=
 =?us-ascii?Q?oNtlX3yTSW27gk216mug6j1eJzvXx6lRWu21qy4CUj6rDCugy7AMp1lHzsc+?=
 =?us-ascii?Q?29IlfsUaSjgDWi823EWOUVY9iOagOVRwSZNrHDYl+ki/XHTc4qKeftqEI3oI?=
 =?us-ascii?Q?RZMrH4zRa0DCku2LAD57HxVB66O8WGxh9k4VsoM7KUjaEmt+LmYRneqgwgGf?=
 =?us-ascii?Q?tlVtlZBYiYSTMitBkDyM1M9loQm4DCgD4A3H/JyFpOH8Ykpu4197maXDFOZM?=
 =?us-ascii?Q?iVtdyTYMrRM0ikri7ihqo+Ej5zM3fCQCrr/pggbBYv5vuW/+rvJifjHk7Vgl?=
 =?us-ascii?Q?+qaZ22ql8nxuRdGsXMdO4VzZ6eq6QAIWLQGH86UznCT3n1XMrLgkMwXARGtF?=
 =?us-ascii?Q?BdTWfycpb5x+wWzCMhrSwtkKvJRS+lyEp9FlX1Qct/TenYuVLCOIt08lOY7m?=
 =?us-ascii?Q?JTmwyKOF2yNvS0WYuNNUfrAzKTd0r9jQD3etinzjZrGN/PfYykZZXZ2ucfOD?=
 =?us-ascii?Q?gK+5ohixUZ4EpZ0TJ1/6eJpXMHYKMqYY+7yYXnE64k3iqKODr8FwQgYKugcm?=
 =?us-ascii?Q?ifCfoIUtXQGIKNbFtS56tE8fcCP1KuNaZNF3JLirYFm3+HD0ogoYBcjnYhow?=
 =?us-ascii?Q?1Ixci+VIwwHRz9/fN3pXN0AVBJm2m5UuX5/qePmHjsKPJ2v2kwKh+FN3b10N?=
 =?us-ascii?Q?d9zZg8ih9UWR3+EDblII0JR7Jgegp44KiccPs+9lcelMkMaD3u/wsAy+zXTT?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 908101b5-e9e7-4ef7-b77d-08dc5af9bef7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:06:27.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/tkRSXSV9kvhtMpZRi/EJ/T2Ug7YzPIiOGf7SFOaDSR5zBYZD1tFeq+UQUiUK11B7L2YxOz5NLxy56m/t1maVNpUWCPRghuWtyE+tDZE+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7194
X-OriginatorOrg: intel.com

On Fri, Apr 12, 2024 at 12:31:45PM +0100, Matthew Auld wrote:
>The asid is only erased from the xarray when the vm refcount reaches
>zero, however this leads to potential UAF since the xe_vm_get() only

I'm not sure I understand the call chain an where xe_vm_get() is coming
into play here.


>works on a vm with refcount != 0. Since the asid is allocated in the vm
>create ioctl, rather erase it when closing the vm, prior to dropping the
>potential last ref. This should also work when user closes driver fd
>without explicit vm destroy.

what seems weird is that you are moving it earlier in the call stack
rather than later, outside of the worker, to prevent the UAF.

what exactly was the UAF on?

Lucas De Marchi

>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+
>---
> drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++++----------
> 1 file changed, 11 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>index a196dbe65252..c5c26b3d1b76 100644
>--- a/drivers/gpu/drm/xe/xe_vm.c
>+++ b/drivers/gpu/drm/xe/xe_vm.c
>@@ -1581,6 +1581,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> 		xe->usm.num_vm_in_fault_mode--;
> 	else if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> 		xe->usm.num_vm_in_non_fault_mode--;
>+
>+	if (vm->usm.asid) {
>+		void *lookup;
>+
>+		xe_assert(xe, xe->info.has_asid);
>+		xe_assert(xe, !(vm->flags & XE_VM_FLAG_MIGRATION));
>+
>+		lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>+		xe_assert(xe, lookup == vm);
>+	}
> 	mutex_unlock(&xe->usm.lock);
>
> 	for_each_tile(tile, xe, id)
>@@ -1596,24 +1606,15 @@ static void vm_destroy_work_func(struct work_struct *w)
> 	struct xe_device *xe = vm->xe;
> 	struct xe_tile *tile;
> 	u8 id;
>-	void *lookup;
>
> 	/* xe_vm_close_and_put was not called? */
> 	xe_assert(xe, !vm->size);
>
> 	mutex_destroy(&vm->snap_mutex);
>
>-	if (!(vm->flags & XE_VM_FLAG_MIGRATION)) {
>+	if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> 		xe_device_mem_access_put(xe);
>
>-		if (xe->info.has_asid && vm->usm.asid) {
>-			mutex_lock(&xe->usm.lock);
>-			lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>-			xe_assert(xe, lookup == vm);
>-			mutex_unlock(&xe->usm.lock);
>-		}
>-	}
>-
> 	for_each_tile(tile, xe, id)
> 		XE_WARN_ON(vm->pt_root[id]);
>
>-- 
>2.44.0
>

