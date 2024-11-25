Return-Path: <stable+bounces-95453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13089D8F3F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 00:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CEFB24051
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9388194A66;
	Mon, 25 Nov 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMmYfl4s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5B189F20
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578127; cv=fail; b=UcFhMhmM/F5IfDbTvMDZKPGQBYP0BRnPIesv9GLjn0286mrwI9+jjh606qRzG9V/btW/KpvOastrORLLgPWulmx1ksAGOQsR0NTVhKXWd1qzl1IYBgnsuPeQLu6+yMarFJ8ydvqXP1z2qkiIa7mzB6pyJYGsU63UOaxzFNNZmks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578127; c=relaxed/simple;
	bh=2NelDZzo1wXfQUlCCzNva1fV0EZb60qAcpcLj1foYHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqhD95N+LSVP8tQo/JtLdCNtzI8impaYvEkR/BwGY535xfIFDZ8MQqlMtNNbq1jNuciFKw5LDFwDMzhb8FdKzpzKQ6nuarXd+zMRFbL0f5x8bp/AlWAlD4KCdMkQiFE0MkiJy7/Bz+7u5yZfQ8ztn5wdhF/3zkfCS28cnyoKy30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMmYfl4s; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732578125; x=1764114125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2NelDZzo1wXfQUlCCzNva1fV0EZb60qAcpcLj1foYHU=;
  b=YMmYfl4sZMVnmIFDZoR1BGZpdQXqFLd4i/RxnMceY3vHpIGdaMI25MpG
   3MhTR2rrEWIih9a3XpEMOg8Hvps13q9zheottVLlbxg2dEcjIYduH8G4m
   1lqbBb5Yl42SnYhlN8DUaQV5gPyiTiEQWRKyYCC1Nx5ML909E0eeughgz
   hu98z0GwQOVLId0ASouk5j52dehV22UuuKwbT0xqlyHp+E+EBfPSv7gvI
   xBT2WgE11RZl+DXCmbGXUxJ+UYHFLc25DM6JHuzEg/MeVdd6G7ryh6HvN
   +fNJl+4hm1Ey3mK0XQqbjZM3nb7uuXeuusIz4kH3SuMdfCMqMqWWDRlPM
   Q==;
X-CSE-ConnectionGUID: CRojlAbESYyWAzEImai/xg==
X-CSE-MsgGUID: KoqYKobGSQOhknMoH06VKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32651803"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="32651803"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 15:42:04 -0800
X-CSE-ConnectionGUID: 7647LZ5aQnmoNEtAqWXoyg==
X-CSE-MsgGUID: oTAyYPVlSbmKjEQzS7d1+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="91049472"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 15:42:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 15:42:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 15:42:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 15:42:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljbu5wOLrDmTVYxKkx7UwCC9YbT2E99OoQLwfC+6/dq3msK3nBPXyEr9iT1F7i0Jle8P11MVAvccAcSDmCZ0d4X5hud3HU5FfBvvfmhsjSz+7XGzglTRpqjq01WUIu1rFszIFpW1SD2JYxuw+wVcS+mzzXt54gcnkXRh/EMUNrkZhNXOnIN67Ds4YdyTIpACdeLDYBJ3dQoDz+W3YZ9wbnJ51O04UuV9PhbgRbiYUCzYGFMgY34cqmKoFhVeBC1CZBKNgQUjBWQH5dG+tngS0K0zj1B6VvwQR362H5KXWiRmZt8Volhe+PQQAPWAtImXliMPpx1MYrGVj5vox39uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEzkZauTjyChN47uh9nPHqCpYEePnsXQnEm1RRyDrhY=;
 b=YODatrbPCvrQV1Xvn7CEedXOuwMrL8UWKi7TgDo2lputpGQSExno6P8JEyYfIjXggR0B0cPNTAe5nzjcZxJhnO9diNK7nMKUyYJWRt4wcw3QkQQGgrm9avtzJuFEtWgIi+ZZwE69VlYXbrhJH2uPwytyYVmSddN2b7ecJQtRQOXRWfK5e306zij8BtJ/r1DtTeIhYPQLevKrsSTWTGhaiCWJIeN5jcTAXz3WhX4lwKFok+z0z8SYTnOtpZUMKjlyIZZshvqX2xcD51drf0ySl2e7xuSbhuG7GS69aQDII7MqpMkJ00N+vERnKb6qmD3n5HDnHKTF2ma9JwuU1XEwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 23:42:00 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 23:42:00 +0000
Date: Mon, 25 Nov 2024 15:42:37 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/xe/guc_submit: fix race around suspend_pending
Message-ID: <Z0ULbWZVWcZraWZ/@lstrano-desk.jf.intel.com>
References: <20241122161914.321263-4-matthew.auld@intel.com>
 <20241122161914.321263-6-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122161914.321263-6-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN0PR11MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db3e61a-971c-4d86-8897-08dd0daac16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RIGGNkzuWxnjO+431axd5rOFENFJ2KPATR8WFDb+Oh/JyPZGT68ZbwWbMNro?=
 =?us-ascii?Q?Dy4TNgdzg50E/YigZcUT/mliJP8Ft8UbR0/Vstcfwf8tZSQFm/VunhDL4OsQ?=
 =?us-ascii?Q?pjjo9xv0FiZfoOdKf1tLLUIZmWMUMwok9DkkDGBpOm26bDYvjcrXtkLDO+XX?=
 =?us-ascii?Q?x9oOt/icHMGBDa72mSvTrFjV0jtSfQ4xsMseRJbkPThTfi93s9ObPMAsXrLz?=
 =?us-ascii?Q?xvCzohTD/Sk3ugsZWddgRU10bdvcWMiBZoRoV8PfLdyi+ab2OEVocf7O/R4V?=
 =?us-ascii?Q?I1kia8Yzqr92ksjT1OcGJHUfVbw75KXR6oPRnlMI0ES0RQ8pCD4fthN9jpnZ?=
 =?us-ascii?Q?XZNvEA8PB+zN6aWNJtxU/OyAYFa+eKN9EV00uk/xM9zWVpOzs2uRZSZ25u+D?=
 =?us-ascii?Q?AwREqU9ydPS+B7j8Q9kK/ynLyoBw6tcW/utTAeGMwszmf+0Y8p7E3Dep63Ty?=
 =?us-ascii?Q?GBjlaMn+HNay+je3RxkLuPhkg8XPOlOhN+nrMLwu4qlBvgsbbbtofUTqueDu?=
 =?us-ascii?Q?mS3N9ALxEsG+4SR7JrDJDguLxnhbg0E6y5m93IPhAdjQ3e5uOlojX2WZe7Z0?=
 =?us-ascii?Q?ZBb7+5ANbTX4MhFxbjLOw+42fhTvWouGJR/Oe2hq7jkWwcHsLaGGlmgEVPjl?=
 =?us-ascii?Q?oNXK1RZqgrsyOyUHmJxkAe3SAiswt/E6izsYPLZQxa4Pb+q/URNRf3jR7VC8?=
 =?us-ascii?Q?RaHj4dvsr/+7IAbXCqTcH8sM7xaWzRppvyyYI2ef8Bk7391RSkbRiEQ5/9mq?=
 =?us-ascii?Q?TcO+cuklNQnoj+TdtVAx1AJqDoR1v+u4t5+2dDNZ5sXNh8Kgs+gOXOiSmoHW?=
 =?us-ascii?Q?3nQJaSE+LIb+Sk6MgduOwKbV+bx7OQygU2bY2Utgk9DY7dAEjJe6asUBvl9q?=
 =?us-ascii?Q?UMXltpzgoaNBfNeaVIHrl1BP2eHYci2sshSjvu2WPiX8+H2Q/4bp+na5LKzS?=
 =?us-ascii?Q?9peSepYlNrJh77JssQiiEKEKHuFfRtBKl8faUANiBT3fF4T/0sV1ZkZvFa3t?=
 =?us-ascii?Q?Po3D713ZDX8n6E6ThewWkmxSN3r9jZ2zfoFikBjSSgxAFQzWHmATb0AaW+Ia?=
 =?us-ascii?Q?GQhwAqluALPEIWOAIsTSih0WTWbwUBJ1w8Mweq629S/SR86EmBeySsseu0hS?=
 =?us-ascii?Q?km5fWJihrV5N/nvhnLEeoD7eWu3Krix7/cQTPsJbHqfioAIGmkpXtkT37Y86?=
 =?us-ascii?Q?E92AAd7PzCIQtStgyafH4UGEB4CNdkZyFhZEpN/V7APnx+D6qN69o+9CXC4y?=
 =?us-ascii?Q?7aF1tqXCyQAmGDAS7dEosIHtmulzcoBe5Viu+gIA+1z2fr/JZnTVpc1inXeE?=
 =?us-ascii?Q?xMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybyY7I5qxEJMx927mb+Hu5qjusRdCMyWybO5ByiF5JLMsJYJJPq855rMx5ar?=
 =?us-ascii?Q?aXj18v8Mnvu9VxS9XACW88i86WOFBIRXGBMMxwoEOQPyxK5q+kPF4AoFuoER?=
 =?us-ascii?Q?E3i55CQ3Eo3ujItujaAgYpDtiUClsC7iNrsVaVZ7SNFVbtZ2ya2wvQ3+f9SC?=
 =?us-ascii?Q?mU91v5AUZ3hpoUkenzmUggMijqpNxIkvk3Q6SuMFykH4VGkpL01mvz3u8+D8?=
 =?us-ascii?Q?Qq5Xa99aoVY6w0kXKwQXM1woTJXR6sVeiK57ohZPbwhz6VUFp25aHxL6e1PI?=
 =?us-ascii?Q?1PzYG6r878Bsp1MewS9hQGE+Dxgwyxi6dKjO2zz1ma5KxwbeXb/2TCWGjTLd?=
 =?us-ascii?Q?1FVG0FS3s0C5P2ojQXa2Lp+i0S4x+4A1W63QulR9vl5RKy34FKu/BINGw8kk?=
 =?us-ascii?Q?ZpHkuTNvnaGf5CAfAzREFf9t+zOYqXVlfYEeuJAuY7eaiQRClDvtOZzMZqwR?=
 =?us-ascii?Q?gdYP+UcPu7AuSezhy+EicsRTTC5bVMaZyCILjgP9Sy+2NV/axSxRJ1BLDkla?=
 =?us-ascii?Q?6xGfeS7p0Omifrp/isMt5oUq35p2geE3m8nE6njwI4T1bs1AijQ3+Sdjfxuf?=
 =?us-ascii?Q?xtD+AONZHgn2L2Ep1EGTvfI6kTVYxjILexN/qWop6LEGMJbOsbGsIcraLpTm?=
 =?us-ascii?Q?io8Q6BNQg/fpvlyz+4w79MpWp7kd+/hETzSsTN1NRbffo7GkJZ9OcXwBJ5GM?=
 =?us-ascii?Q?XMlH66agRryzmrkZVTYejA2mZvvRkq2M2BMNBUIowH1gk6UbOoQZLmwdWuLY?=
 =?us-ascii?Q?3WOG9h5eG+tzNvJ/AL2ARJ2Sd+haKzKu65BRs55lYyrd+Z8aCmNzs88KoMGN?=
 =?us-ascii?Q?I/z8F4+YvyKWt83x+M/XyV1A6FoV7LwxbibKWP1NlkUuXzhvJbc+lE9ndCX8?=
 =?us-ascii?Q?V2663CNmA5T4hLgsuPviAyP6dTe7qFcB6v0gh/joxPeV14tuEYYD56xXkU5m?=
 =?us-ascii?Q?X5IqAogGeVzCI/4kL5KMROkkCdDH4fJ/rP7+zok3zJEE7dzgdll2poHxVDYB?=
 =?us-ascii?Q?5sRHPpwbyCiOdNK9d8c3I7nX+E2+m7E2H/MTDBsnaRLt6LnfiX6cePFQg7EV?=
 =?us-ascii?Q?ij5IXUtQGSXcbYINRlMKD2nDBhWmnOmQ/FiMOLiZ833zrE6OnnCSAseWHCb7?=
 =?us-ascii?Q?sr5/LFTYaVNbPGk+FPX1orjZSJy6MbPJm5R3fqhGDScHGhnX6ZNkoxWgF7s/?=
 =?us-ascii?Q?NktfoMdA5YE0EEKF2rqJ+nNbjgRgNmvcjxFXkJOOnz+0TsTmAiEeY7NJoZQV?=
 =?us-ascii?Q?aCd8Y4rG3O0jOIiGdRq/NVczrxJFD386b3NOvR9Du5BaX0MIUAgGPWGQIJOZ?=
 =?us-ascii?Q?4GbIVwNA9GzC7D1YIIu7cWclxbAjF3LACV7VKGz50g5AydQYXuzOEnPxujXc?=
 =?us-ascii?Q?/H2iV71Y+jNcETLEYKv3PJiRWXj68Sse/HSYfB18Ju7ZhWhlRvCeoMZO2JS+?=
 =?us-ascii?Q?tSw32jR70l68ADrA/3CBksYKtH6/x36OQYE329/wU/VltBVCRWiYgBjfOStg?=
 =?us-ascii?Q?l2eKwlAtpgNcIf/Tspp2d+9LbiBUfl25GDcvh7S5708kHYAYdoYBDUI0HYRo?=
 =?us-ascii?Q?+ybjh+wg2hwlBiuRzLzE7ZQjNjVyPPCJFvmQjFkOxXs/xTXlM37cyu2MN3N+?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db3e61a-971c-4d86-8897-08dd0daac16e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 23:41:59.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qH67amDU6d6tN2zoH7CLQI2SnQ0is8qcQ81hbO+6f47bqhFZ43gz4GncP+ntQpZ1gy2TG0A9CT+mms9O3DZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
X-OriginatorOrg: intel.com

On Fri, Nov 22, 2024 at 04:19:17PM +0000, Matthew Auld wrote:
> Currently in some testcases we can trigger:
> 
> xe 0000:03:00.0: [drm] Assertion `exec_queue_destroyed(q)` failed!
> ....
> WARNING: CPU: 18 PID: 2640 at drivers/gpu/drm/xe/xe_guc_submit.c:1826 xe_guc_sched_done_handler+0xa54/0xef0 [xe]
> xe 0000:03:00.0: [drm] *ERROR* GT1: DEREGISTER_DONE: Unexpected engine state 0x00a1, guc_id=57
> 
> Looking at a snippet of corresponding ftrace for this GuC id we can see:
> 
> 162.673311: xe_sched_msg_add:     dev=0000:03:00.0, gt=1 guc_id=57, opcode=3
> 162.673317: xe_sched_msg_recv:    dev=0000:03:00.0, gt=1 guc_id=57, opcode=3
> 162.673319: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0x29, flags=0x0
> 162.674089: xe_exec_queue_kill:   dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0x29, flags=0x0
> 162.674108: xe_exec_queue_close:  dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa9, flags=0x0
> 162.674488: xe_exec_queue_scheduling_done: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa9, flags=0x0
> 162.678452: xe_exec_queue_deregister: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa1, flags=0x0
> 
> It looks like we try to suspend the queue (opcode=3), setting
> suspend_pending and triggering a disable_scheduling. The user then
> closes the queue. However closing the queue seems to forcefully signal
> the fence after killing the queue, however when the G2H response for
> disable_scheduling comes back we have now cleared suspend_pending when
> signalling the suspend fence, so the disable_scheduling now incorrectly
> tries to also deregister the queue, leading to warnings since the queue
> has yet to even be marked for destruction. We also seem to trigger
> errors later with trying to double unregister the same queue.
> 
> To fix this tweak the ordering when handling the response to ensure we
> don't race with a disable_scheduling that doesn't actually intend to
> actually unregister.  The destruction path should now also correctly
> wait for any pending_disable before marking as destroyed.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3371
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Also spotted this one when working on UMD submission. Same comment as
previous patch, this looks correct but mayb longterm a bit more cleanup
in GuC backend would be a good idea.

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index f3c22b101916..f82f286fd431 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1867,16 +1867,30 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
>  		xe_gt_assert(guc_to_gt(guc), runnable_state == 0);
>  		xe_gt_assert(guc_to_gt(guc), exec_queue_pending_disable(q));
>  
> -		clear_exec_queue_pending_disable(q);
>  		if (q->guc->suspend_pending) {
>  			suspend_fence_signal(q);
> +			clear_exec_queue_pending_disable(q);
>  		} else {
>  			if (exec_queue_banned(q) || check_timeout) {
>  				smp_wmb();
>  				wake_up_all(&guc->ct.wq);
>  			}
> -			if (!check_timeout)
> +			if (!check_timeout && exec_queue_destroyed(q)) {
> +				/*
> +				 * Make sure we clear the pending_disable only
> +				 * after the sampling the destroyed state. We
> +				 * want to ensure we don't trigger the
> +				 * unregister too early with something only
> +				 * intending to only disable scheduling. The
> +				 * caller doing the destroy must wait for an
> +				 * ongoing pending_destroy before marking as
> +				 * destroyed.
> +				 */
> +				clear_exec_queue_pending_disable(q);
>  				deregister_exec_queue(guc, q);
> +			} else {
> +				clear_exec_queue_pending_disable(q);
> +			}
>  		}
>  	}
>  }
> -- 
> 2.47.0
> 

