Return-Path: <stable+bounces-94669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635D9D66D4
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 01:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BFA1611BC
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E91C32;
	Sat, 23 Nov 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0BMdivn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33776136
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732321378; cv=fail; b=lHTr18u37fhHfW9I0lWKhXA/Rs+0LE4AMkkHsjgxvQCrP/Bl7RchoFGBoDj0zWDn0Go9wAsAgYG9EhwIVQynipKMQGOfUsqpBMiEbE0tvnu6GDjoEir7HZGoPHA/AEt1fNpgvER0irSEs3pVdExcotf8tY6OBK+Te7IUZbyhbug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732321378; c=relaxed/simple;
	bh=qF7DU0ZWetpuWCJ7zJrlYcirfvv+ZTsEhmBmOidTeJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdS9YOdlnMsrhNaERViVnOUy3JZ5wWKprUYczJPsbukgERRqjEo4eHjx0vYjTwHCuHiNif/fiq5Fos6BFYRNm0jGQmAqemYOzmU+Wyg9zdVcCdQExlGa+2eXJycQsw7mgxBFk6cABEO4NhDcKDWbxgeIZfqo2kWlAZfjRoTkTr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0BMdivn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732321377; x=1763857377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qF7DU0ZWetpuWCJ7zJrlYcirfvv+ZTsEhmBmOidTeJU=;
  b=k0BMdivnYrBGsA5nyDwW/O74yr9lYClM40d9J9NY0wTfOEbGbKN3jJLy
   oI9CYO8okCRRXcOhveftEWSoHzlvjwHBBCp/bEPe5jfQFgx0YLvL43FoM
   ntxIq9Nckz1RXsyK6EXHVG1vbdrOY2+7KMM5R6DaxHATdkZj76Es4BTVX
   5DUSwCwUjJC4UEMcWTWGXPdLbQ+DI9Yb+nbdkXuu+9m8SWw4ZnSY6qiPl
   X7B1ff0N3DSCPvlFtpeIFyNAK9kL34nqmppYL+MJpm8y/HNtM7T3eaf0e
   iaXc+fyM/p2gZmAo6ifc1+c8T6nHunN9h2QUWaXV7OmDZhMRgAFaYJeOd
   w==;
X-CSE-ConnectionGUID: 06fyPJ0sStWMhZS4MJ1SWg==
X-CSE-MsgGUID: OjhBmLehQouvxh61pCuqDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49910052"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="49910052"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:22:57 -0800
X-CSE-ConnectionGUID: CWXfJ9FcShmTrJobZc4GVA==
X-CSE-MsgGUID: PiS0uIbJRLSdUuokUiDtlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90354569"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 16:22:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 16:22:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 16:22:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 16:22:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw7s98vGDs5sFj+0VZ8Hnfr1EIXDdbZak+kmeM7t6awFRopcmFT9GuGXO73pcsEm5XP82m8Y1rG7zqs8ExnRyh7B3gRL37eVAmaAY7PmnmL9LAYemUbsP+W/AGaMCcT9+7N2EovQ8uV48dwg3X33TRQCaSk0bYUYuYVUkN9LU0YiLLA+PmMKC7aHKb16bI4EaIapfd/cC2a2ZzQGxM7MOjXy3HM+0DvOvU6JiLGSlkTyb6oQGR2c00mxPeWafuwQaDGPG3DLUO/QSpEPbr1EkZPpkAYj3u2IxGOVSCQ+Fjnut4gk9MqdrL/7pRcGSMb/cU6UQsgvR1sgFa4B58jiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFNq8Fjrv7re9Pbm0Iz3maOFu3ou+PWpPekwqFr6AW8=;
 b=DiPFmHVorR2SsIEaEMTCJ0DwWhgCAu1NqHoEwiwyNthKlAqN5bK7cAFLdGzHKqTBsZCrVEr9kM65XFZtdhwQS/9Gx6Y3UBqFxDP8D2LfDqhgwcctLS1clRg/dChxmaMOQX6URzwfsaDd7toqzeV5pT84o9Yq+uB6EGhApbfGIeu3JhhiZHK3gKfJPsiSnv6aAARNHrfrycAJFIpa1gazZOvxFrjfDYLm0ILX+2jywmBPYOGc9Aose6i9cRIQi7iaf9sVdCgkpgdpS7HJy8CFuFrxUmw2x57qAK6MdgmlDhD55RseKMGe8RSZvbCM+YiwfulwcJgfxqtB2fpPADnN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Sat, 23 Nov
 2024 00:22:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8158.024; Sat, 23 Nov 2024
 00:22:51 +0000
Date: Fri, 22 Nov 2024 16:23:27 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/xe/guc_submit: fix race around pending_disable
Message-ID: <Z0Egf5/iSL1XbFxk@lstrano-desk.jf.intel.com>
References: <20241122161914.321263-4-matthew.auld@intel.com>
 <20241122161914.321263-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122161914.321263-5-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ef26e5-7f31-42e1-c08e-08dd0b54f765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rAgS6RzmYLxEOkg8E4v1VhH2aSCaYsXt7XqX66i10ImEZkgfXcIt7hQX5BPk?=
 =?us-ascii?Q?9aQ0ewrYNG7PWEODn+q5AnG72lnLsfz9eDrXLUcBvKWiG7a60YxvsXOHwi13?=
 =?us-ascii?Q?yl5NqbG23l5lqngkWT6kI/kKXQLdLPd2kUAqBw7gYmcrFSIvgQfZKXd19DJm?=
 =?us-ascii?Q?nawcI3f1SzTgi1QuIXWZWUvb+AGLgBPqg7IZgwVtXZ/dyHyt2OXvBm9225DL?=
 =?us-ascii?Q?A/TdXyeZcITHxdLO9L6aYR7DBjy9kouW/JyPwrEBFsFWkTKUEUUgLFcUdehi?=
 =?us-ascii?Q?Jj4K3xPtMx7iOv+g1uhaJGCl5BiOWCrqlfOzfq2dHssEdYaYpX8iXiO2eBmi?=
 =?us-ascii?Q?Qgdvcr79LOPWXZ+VPpCwLhYt8q6QZ5rKjNEFt4DFt3NH1kp871syOC+6bCQw?=
 =?us-ascii?Q?rYmGO3UfeagxGw5J3rDl4V9YYyt05ka6eMT44Qq5cLw+XEe2RXed/TwxGmXh?=
 =?us-ascii?Q?g4hxvBIrfaimXPak64RI6n50lmJ/pcs+Z3LXpJklOVz1vsT3RAlwhJDQ2ydX?=
 =?us-ascii?Q?TJN6tSTlqbW47kyf5g9RArxwOamu+mCKYLS3jIl5+llJOtkBXr9Xkd+vo5nF?=
 =?us-ascii?Q?87/GK7AVQubkPkf9WjOUAlckZfE7FZ3aPd6kLAVYbettdaD30in93f0965NM?=
 =?us-ascii?Q?7QrmLD90r07W7JnpeVU7VNiEhjNHUbFpqdg6wW5ZgBtbEYbbeFbOseWQChvo?=
 =?us-ascii?Q?vmBpcXLIPmXuZbYEksjVAab9zZcizMC+6iVzaZw1svdllBKw39JgxAra1+4h?=
 =?us-ascii?Q?aombMCvwLQEFk5MZKAAysSvVE2F7gds0Z5vR5OSo+vzbro6m3gtx6uIDSVn6?=
 =?us-ascii?Q?RiMd/gDeJuDHMYYedavDYWZ3AakQh48YeVVTH7E6i5iKA1w0JpyYIifVubei?=
 =?us-ascii?Q?uas2VqlmFRKAFFRMCSfT7fFJx9/AI4XvMnSZCv29ZkUQtS/u5lc/CsUihLSR?=
 =?us-ascii?Q?8+QmKty0ZwuK2L/hmVvYX29aNoa4G12Trdm33mUOlP93G82sRVOZeAmA5Txm?=
 =?us-ascii?Q?zkNkVrtb2rFWmEvgnjl2R7IDk/k7ng/htBEx7uI4lA9qWaI0Fq9Q6nZI8Jz4?=
 =?us-ascii?Q?eE4zW3NsrW2ot8WoWjlQacld3Ry7gMi1roM3yu3LO7i7+vcNJWHW4N4oO/QI?=
 =?us-ascii?Q?1QjnItK8SNWZaro03gSQJL+MeasH89K4+nnOOdgmESTdNzeLnQEAh9up7e32?=
 =?us-ascii?Q?qnS4z8LrEBGYmThhvnQ2AN3kxBqEM7Bn7pSPG7ERmBz7IxvsxpLeW2SMtvYm?=
 =?us-ascii?Q?6bgx5Ah07QQaCQz52I8rVZiQioX/VJk5hOX/9rx7Gx/pDKLkkKiga5DQmsrs?=
 =?us-ascii?Q?Jeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHWW/VoVDomTZGWh0YdbJZKNN3AcJdnhKykhyV30JgGlkMr0EE5CtOT9Q/1h?=
 =?us-ascii?Q?OViaZD3Um1no6gP0mA1sCGjAOp+qmI67MR5b78lWQvvMjyg2u+N4YUi3d6LW?=
 =?us-ascii?Q?tHnSy5EeY1RYN0N77k5EWYZ29RHov5Jo81yJ+H4krizCCXEu/BVEFejjZ1CI?=
 =?us-ascii?Q?hE1fqwVGo2fNsxFzAXYLW8SdYzDJMARJCubqMfLwtSczofy43q7qWpjqhf1l?=
 =?us-ascii?Q?qqg3GTeg6GYdZzzrGUMmJS+S0oej4kyZgcg9/X5hToFxAqFAcn/C3unWH8M1?=
 =?us-ascii?Q?Lj/l2lKZ75lmTP4fD0BMwonNkl/Fyte7MXQbVkDpXsmgbKrfwuWeUSYeu2nF?=
 =?us-ascii?Q?05YZXjcHPcYquQ1UGA/u0pST9PzJ+TeNxAzCbStsGvmRSYUBSutBPGk//knd?=
 =?us-ascii?Q?fVmv9yWCArXgjwwIaqKHMsL3TnetmUw6kH+69LGtml0LZDS6RAcngYwTuoNm?=
 =?us-ascii?Q?TpWARfx8atsV9X494jcE16vB8vtVRmMX5U0H9RZIn4abX1wXydzTR3OIAMzT?=
 =?us-ascii?Q?Ww1KDsWW0UuoDx/fyLBEZDpkHo+82rQR/smeCq1FIJ6dxO5htSLOl001J90Z?=
 =?us-ascii?Q?TeCVyr+SqlH/p5Y8kMlqUu+U8ykhFmJRqsI5VfopU5nLgvvcc7c1Vx6t68NK?=
 =?us-ascii?Q?lxwhV62elW8yov/9+aJRVuXN0HOq8PCY2ubP5p2sIq5aYJYhSgOl1+Dv9GaP?=
 =?us-ascii?Q?stoYALQtCeOInRm19h6at1NPxcHV6WA6yQhaqRoCGqo1Muvr2N0wB2OLOdXI?=
 =?us-ascii?Q?43erGMNAPz/3OedGMyto6v9bNT2nzUjf5DkqY0DkBzV2aNgWYq6ZkgAlcI1C?=
 =?us-ascii?Q?QTsTBvdURs6+yNGFMEwAuu+p0iCsS3aA7kJslVJGCx8SifyxhufigfNCOvOA?=
 =?us-ascii?Q?nQAyLDUTNOQi3oD4Wl+oO4CnMm566noasmolO7TTMUVA2WF8EXnZED2tXMid?=
 =?us-ascii?Q?f1Cqwdo1VmOwKnkZKUGF620B6GElpB0RS1JfsBzCiDPu3jj7X7uxSKreoBKZ?=
 =?us-ascii?Q?G8c54Rp+Juf4c0pNZqcDl+mxEj5UiObwD0YVM81XrK1RHJM/i8D2UDCF4PxK?=
 =?us-ascii?Q?HepSqgo/HzJP++OQ/ok+I0vJfacPPV2IFEIoqdeF0cLP/6+nhL3MGQ6z5pMi?=
 =?us-ascii?Q?kM91fRyqGY5m4kZ6md3l+wyofJhxakkix8U2jsfjFnpBKbabv5S1ka0Mvv/v?=
 =?us-ascii?Q?/jvjZQlzv5y4lRxvceksZV4OSm413uBk+aulGQupwHT8lUEy/q+KOKyiAzu5?=
 =?us-ascii?Q?veAlw1zchmvVy/2Q/wU81CpLJE5xmCybCkDkvwJ0OZReknboa99A5n2HP3BV?=
 =?us-ascii?Q?WNf/b8vFvnxG1z3JnGcwaoErkhu3t7oMm+gx5AvWb/S6tm5AmgmXEk2XbSws?=
 =?us-ascii?Q?CNs/hHBx8ScGQppnpX1T418eLVRQ+Z4z+36DY4IX9z1YysjbKKJsA3n1zT5j?=
 =?us-ascii?Q?7cIJWQP5Hei9K2DZ63ztEAwK93riJFDPnb/q0NWvAJWj+4x46QOhFQJ2NoSo?=
 =?us-ascii?Q?/Y4xbvhjp4a4uIFkqUiGltlcshPNqMbnEtqdm3H+1kGaPKPKPXOn0RVpvN4h?=
 =?us-ascii?Q?v/DD2GX+tRrAFc2HCu8gAyEcLSwCjVfw46Lmg58Po+twrAEoZQApb47toDDZ?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ef26e5-7f31-42e1-c08e-08dd0b54f765
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 00:22:51.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8yP/31ofBnbvM/vGKZ6qzEytdt2BJ3HlD7AFVKA9CI3LbwU+Ckam0VhlHz2GekzMaRLeYB0X7KVXhmbR3+oug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com

On Fri, Nov 22, 2024 at 04:19:16PM +0000, Matthew Auld wrote:
> Currently in some testcases we can trigger:
> 
> [drm] *ERROR* GT0: SCHED_DONE: Unexpected engine state 0x02b1, guc_id=8, runnable_state=0
> [drm] *ERROR* GT0: G2H action 0x1002 failed (-EPROTO) len 3 msg 02 10 00 90 08 00 00 00 00 00 00 00
> 
> Looking at a snippet of corresponding ftrace for this GuC id we can see:
> 
> 498.852891: xe_sched_msg_add:     dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
> 498.854083: xe_sched_msg_recv:    dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
> 498.855389: xe_exec_queue_kill:   dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x3, flags=0x0
> 498.855436: xe_exec_queue_lr_cleanup: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
> 498.856767: xe_exec_queue_close:  dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
> 498.862889: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0xa9, flags=0x0
> 498.863032: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
> 498.875596: xe_exec_queue_scheduling_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
> 498.875604: xe_exec_queue_deregister: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0
> 499.074483: xe_exec_queue_deregister_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0
> 
> This looks to be the two scheduling_disable racing with each other, one
> from the suspend (opcode=3) and then again during lr cleanup. While
> those two operations are serialized, the G2H portion is not, therefore
> when marking the queue as pending_disabled and then firing off the first
> request, we proceed do the same again, however the first disable
> response only fires after this which then clears the pending_disabled.
> At this point the second comes back and is processed, however the
> pending_disabled is no longer set, hence triggering the warning.
> 
> To fix this wait for pending_disabled when doing the lr cleanup and
> calling disable_scheduling_deregister. Also do the same for all other
> disable_scheduling callers.
> 

I spotted this problem the other day too while working on the UMD
submission series.

I think this is a good fix but also think longer term we may need a
larger cleanup in the GuC backend as the state machine has gotten more
complicated than I would like. This is some of first code written in Xe
and feel like with some the learnings some the complexity could be
removed.

Anyways, this LGTM as a fix:
Reviewed-by: Matthew Brost <mattheq.brost@intel.com>

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3515
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index f9ecee5364d8..f3c22b101916 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -767,12 +767,15 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
>  
>  	set_min_preemption_timeout(guc, q);
>  	smp_rmb();
> -	ret = wait_event_timeout(guc->ct.wq, !exec_queue_pending_enable(q) ||
> -				 xe_guc_read_stopped(guc), HZ * 5);
> +	ret = wait_event_timeout(guc->ct.wq,
> +				 (!exec_queue_pending_enable(q) &&
> +				  !exec_queue_pending_disable(q)) ||
> +					 xe_guc_read_stopped(guc),
> +				 HZ * 5);
>  	if (!ret) {
>  		struct xe_gpu_scheduler *sched = &q->guc->sched;
>  
> -		xe_gt_warn(q->gt, "Pending enable failed to respond\n");
> +		xe_gt_warn(q->gt, "Pending enable/disable failed to respond\n");
>  		xe_sched_submission_start(sched);
>  		xe_gt_reset_async(q->gt);
>  		xe_sched_tdr_queue_imm(sched);
> @@ -1099,7 +1102,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
>  			 * modifying state
>  			 */
>  			ret = wait_event_timeout(guc->ct.wq,
> -						 !exec_queue_pending_enable(q) ||
> +						 (!exec_queue_pending_enable(q) &&
> +						  !exec_queue_pending_disable(q)) ||
>  						 xe_guc_read_stopped(guc), HZ * 5);
>  			if (!ret || xe_guc_read_stopped(guc))
>  				goto trigger_reset;
> @@ -1329,8 +1333,8 @@ static void __guc_exec_queue_process_msg_suspend(struct xe_sched_msg *msg)
>  
>  	if (guc_exec_queue_allowed_to_change_state(q) && !exec_queue_suspended(q) &&
>  	    exec_queue_enabled(q)) {
> -		wait_event(guc->ct.wq, q->guc->resume_time != RESUME_PENDING ||
> -			   xe_guc_read_stopped(guc));
> +		wait_event(guc->ct.wq, (q->guc->resume_time != RESUME_PENDING ||
> +			   xe_guc_read_stopped(guc)) && !exec_queue_pending_disable(q));
>  
>  		if (!xe_guc_read_stopped(guc)) {
>  			s64 since_resume_ms =
> -- 
> 2.47.0
> 

