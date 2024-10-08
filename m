Return-Path: <stable+bounces-83045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9B9951C1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08241C25A77
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189D1DFDBF;
	Tue,  8 Oct 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TY3NExBJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132011DFDA1
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397884; cv=fail; b=YzICPCuH91AGiVGd4jj3zxrDQMUEfM3fT5K0ZVy1GHNxulE55GnDB4oWJrS9/xnFIsc8+/re+y9rWCDj4MRgkkZjlSxrH36zOxcXbdNuNGKbiIuute2i/a9zj57GJqqQOte3DfkChqLtcsP9mjTXlPOmvo74q/hIayAr8ClQJbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397884; c=relaxed/simple;
	bh=nm5iAl3PB92RHwlf8IPcFtDTv39UFkDDtXz7iTrwu1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JESbXs//d5zjrMdC8XSGWguyG40bhxqueG3VmkvXPhQNPtOmzzek8uEvj/yquW/HhoIDlMS6QwH72f/fCQ/39XvxEvLkCaD4xIt/1fWIF1c01unZhMyMqBPRi34XisIFlfXnGwhwlYuXmVjzZYl6MEFif4mHJ8andf51+EZLI0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TY3NExBJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728397883; x=1759933883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nm5iAl3PB92RHwlf8IPcFtDTv39UFkDDtXz7iTrwu1Q=;
  b=TY3NExBJ2P9T5+BP0FBbcWJNPlKR4FXtXZIvNlo7KM2zzuj9D6OtYIZy
   5uSfkjZ4lHkAzK+5Qu8bFf26wT6UNqwTejLLDFIrsGAagZouXZq61e60N
   l7PdgJ3+EYUDhQXba+ZrPnS6/RLGzO2YNXaEESSS0hCO9R8PNnBlUxXBe
   ZD7mmKgq9xL+/8X+7yAp+yc6oV66PrUZAGp34VumANC4Qtgdbnw/C7zBE
   IWqdOeu5W5KllhtzJA+6ZsWM0ABwsppCzN7qXAxFZtV48rNz1NARHjTDY
   qhj9lPVnhg7D1U+KN/asIK9VNmbVWlXdpAtgtIT3EawopE6Zx6tChLGw9
   A==;
X-CSE-ConnectionGUID: GtmI2IKCSRWByVdhEExJhw==
X-CSE-MsgGUID: BGZNe/nHTtmT3hZQCRYd1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27055362"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27055362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 07:29:58 -0700
X-CSE-ConnectionGUID: w/EStsDpQXOkJr+EH3JwrQ==
X-CSE-MsgGUID: LM2yhXS/T6Snx+12DffP1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76118665"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 07:29:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 07:29:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 07:29:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 07:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZMBdeFvzwg04yEIX7c+ryYvtujqQoi/q7LYk6VFXbOf1O35qIAbc6mLiefxNC2a901oz0GW/9mitOxRnA+DBqrguiAo1tEbmkxdB6aPWvTXrDvzmDSeFjTlka6BuKyIOyFUfWNyP0bVUZkYWX07BxIB1OUuTWV+FydQfcthsJaXRJPnX4Eb3TqHVMfh87H/NFqoxocTS/mi884OFnoukiO14PDy/ZzPifdy++LptwB7g2UddTz6oi/zKzdEpZ2GyFeOFFipCVP7K7NIrTcrvz09rYLEGWj19G2Yg1ogz36dziiqf56GI4ZIJ6bbhVxd61oi28I1hJl64JIx/4nUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5GvFyl4cVHwFpf4xPuf1Vs2CzlRk0Ft32W5MHG2pBk=;
 b=rvC6Nr8Mvh+VJN9RAIeQFeog870+/kM2KgOI6PrPswCDugLcxr1gKI1x8+C0XzkH86edEr13z4Cou5Tkd9Tl6DsZqKRW+R1usRdt6sJi7qr6cYf28R6c+6kQzt/LAhXyZbNQA8zvNdVSt87lHYEa7+Op6vl6V+vDFxWdo7EmZPFs3f5gT5F+Ewz2Xafs4a1aEbR8ImF+pG8f5c4+X2+Ig+IE90EzyfpUzu0ml0nnyVR1DzsV8qBOs3q8QshsN/RaQE9CuhXhW2fGdTm2S6at+G83t0SwjZCkFttM/xNqAU/waojwbrPmXqc7n8g38NyPXSVCQofuYLXbOkP7523cwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 14:29:52 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:29:52 +0000
Date: Tue, 8 Oct 2024 09:29:49 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <gregkh@linuxfoundation.org>
CC: <matthew.auld@intel.com>, <matthew.brost@intel.com>,
	<nirmoy.das@intel.com>, <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/xe/vm: move xa_alloc to prevent UAF"
 failed to apply to 6.11-stable tree
Message-ID: <au2yg6xpydfomljjfmll6j6h6mwpzm73kojc5zjck3im6grson@e3ajgznra66s>
References: <2024100727-compacted-armored-bbce@gregkh>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <2024100727-compacted-armored-bbce@gregkh>
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: f7611ef7-47f2-42ae-865c-08dce7a5ac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+FT60qva83T7U4qmkCSYUyfzav1Z9A2coECU160WebiNM+Rm1IDLsi+RENlF?=
 =?us-ascii?Q?xdz421MGEbfv0oiI9W73LOWjT7kTVyZvoLPApKwlovBltx9wgl35yxUVWyW3?=
 =?us-ascii?Q?mYztBsYGYHiL0h3m3V7PfIWgcvdHCT5Oj3ivbyAz9K4uubHF20ziwmscbjyk?=
 =?us-ascii?Q?rG8+YffiKFbSgufocsbfX7/EqxGffqLlAs4uPiujGq1iXgflEyQsBs/Snojv?=
 =?us-ascii?Q?3z1TASvtWjLT7pgfZxBOR3h9hHrrbCL5cz1Uw9U1aiOv4GLrDUFlhRvdL1dw?=
 =?us-ascii?Q?lG00s0Y/gPj8mmvLPBJf31vGVVqGkpY1i+a5DZLKOdsjhQsajvA6YViEo3qN?=
 =?us-ascii?Q?DICliL5Dwfx5548sxplqG+SKnGn5m7k6DKfjFysQK6BToGGhbjnKUKOvzkVS?=
 =?us-ascii?Q?EXWy3bgZC70FnL3jGYk8vq1vnLR5ILgy23+iPrlOz+jD73USRtBL450D+Vax?=
 =?us-ascii?Q?MZkwHwfbRAa4Ap1SHYXih5KF9MhqWqrJ3h5kPAICwqs/jAMA/2/dOrxhJI3a?=
 =?us-ascii?Q?HBaVhiuWFb/utAXcyf1a/XqX1dazWAtQBaNmrX7U9yIfJ/oaWBFQx9yHofO0?=
 =?us-ascii?Q?4RkGsxgi3EcdhVnbzIDx5y8vkWfVwtb8xpnq1WUAiuiR1FNFq3Fopimhrggi?=
 =?us-ascii?Q?98JHhFcK1QPfXcOQPLIk4cyiUbdHpRKTrbNjzTtWzRN4uNhzlXbyolfcDjBa?=
 =?us-ascii?Q?4eUSFqQdCGjZKY9stm9LCju48YdBt8UBl2aR0YG7RYwjBVhkpJZ7OMGzOjqR?=
 =?us-ascii?Q?OPhySXAFUqxnEJbDCywkgTnVfyN9C9eta20YOjXbno5bPOODIS5p/f3Iu92j?=
 =?us-ascii?Q?3YaB7m1Q7CvlwNJi+OxZlbyYdx8kOvnebM/deby5XB1x4SZitjaUdi+2lBdr?=
 =?us-ascii?Q?SdML7/HR3NzOoBjH0a73kykRiJ4HJnIEpzTAU7y3Vqo6pc8MlJHZmVKgCaRH?=
 =?us-ascii?Q?gBfhDOdJEpg1TesR0AMR4OihdhkJnlWeFapiYB9vmlXPIr+1oHmmmuFaRFo9?=
 =?us-ascii?Q?uii4Ee4hBA50GU8I/1tkk+ybsCUWqvqJtC6tR6XYJo/qGRBCbFv79YUS1+OO?=
 =?us-ascii?Q?YO55LSuA4oaq1KGE0JXfJB5tWHcISlHGc3iOP53G8wBXgj2FNGrOvonPTGNu?=
 =?us-ascii?Q?Yc+SIMBIfjosHvd7RCNb9B/7GlgdpETbdxvhZ3hBCQCZyWevfbAbTQluE+Ku?=
 =?us-ascii?Q?U6eeY8FZ3txW2bWT9WJsSjvZlGDxsCUSYYR9SuMlUiJ0kWFo8EMUwUv3/cqd?=
 =?us-ascii?Q?Nr5M3YBF5vUkdIDTcLgmCNHULDVJTZozIpGh7BsGEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9106d4CcR4+qHMOLF7BGXHeCMj+vcOb2PP7o3gKISkjQYzdiUKdfRnlaEvB?=
 =?us-ascii?Q?8i3+r0Gkj5ogvZ7C6dknDAcwzGiiWjJBgQTtxX2L+i1doIltKumwi/WvmtBG?=
 =?us-ascii?Q?OC0fThZihSI/2zxaYArtot35ogA638q1mfxRaHY5YNwI1GV/0Gk5tK5COQKM?=
 =?us-ascii?Q?8VhwUMh9WASO8Q6r0exdUqmF6+eqgRF4v27sHtMRjbF4zjpH4owEh8altkis?=
 =?us-ascii?Q?yY5OeL5CKZf0HNgYduS36n3LpnAztAHWIDV1ykEZ4U98aGzZtIuVER30fbEq?=
 =?us-ascii?Q?VAUjccFJnVIdbLzbMiAzITCBQVGVTJe3fpPoD+SjGtjJO9umvYT9lFmvhun7?=
 =?us-ascii?Q?zAqlLSdzqAnZshwEqSE3dKSlqTafk1EAWNjWnD+NuZfSHPdn5J0w9kk6j3s8?=
 =?us-ascii?Q?OXvgW4BTm5E6R6/diwpIsGtJCllcVSaJnzyPlz8cAVj2B+GdqvbC/NgkzrSZ?=
 =?us-ascii?Q?sf6jLq3LC81frqUCm5Oj02k+lVTcMn4SvdUvhuH+pQb3h06g1KqwGuYYy4+G?=
 =?us-ascii?Q?mq0Ee9wQdNqo9/f8xeqWcdn1kwEA9WixOrbMR9TtWgL0uZP99zruNhMdK2Qm?=
 =?us-ascii?Q?nDZuwcA9OOLiPUrJ34+VmopYzrxtv7JWecBwmq1UVUfA8wdwN+B/nn9AXgzu?=
 =?us-ascii?Q?xylBl2g2WpzS/oTM3uX7S5NYZhtVukexj/MeYu4N0t87FXa5TOW1CT55vkiz?=
 =?us-ascii?Q?8XXVKwQrHZ7Z0KBg1UpkzeA1df08HL4OKJuHKtlyRIjEF8IGus8FP6QLtJ/A?=
 =?us-ascii?Q?BfznxS3L9p4lZdFVf9Z9A/62pM8HlGzQPEJyriW/isadKEWhysK3CXmisOPL?=
 =?us-ascii?Q?eYCtBLTSSR40PI4Dx1q2t/aDiMpCvwx6AEY6pSs1RBWVIpCF50XWvHtiKl+k?=
 =?us-ascii?Q?pyM8CvaCCEBh8z8g+8/ZHNaG5U4RyYjdClSEmIG5OudTWbPBo7vM2n1tpnHn?=
 =?us-ascii?Q?Odsh50dimV6VvREt5dt2DdkPXlo2y76FmLec+44MEOcQfwbBKmnU6DY20opt?=
 =?us-ascii?Q?NHQ9/1/ekflBCntGzQNQWk1AadMWZ56XkFTOQudYZjrNsZibIs5ojX+c4MGs?=
 =?us-ascii?Q?6KhG+3fbVAcV4uRCOS+/d451cphEekc7y98eDaQ+atGIHVt5vZlj0BK8RoTp?=
 =?us-ascii?Q?JIjbnldwqA2tXukrDEJoaH6uhsyej4Hdmdscqi8s4iJcGA0HpKYdlL1eFmak?=
 =?us-ascii?Q?ViyQlIoRh7tIwetcMTooTaVRRZK6HaBR1KswHB5DV2dpsBjrGDfN+2RXp22O?=
 =?us-ascii?Q?9HKsGWOovGi/ZgeLLNZXA0z1Y6J2FAUl3Wz6SPiqKc5xT74gNCasqK4DQDxH?=
 =?us-ascii?Q?LFnfayYfrwcFYMJZwcXJcXPpC1Kxs0f2fYi4eFxGmiaKzPO6ivhPtQ1DHzRY?=
 =?us-ascii?Q?n3twyETssX/l8p9noFvXOxhYMnRXDAkWXGYWopIiuy7dwkWLaVjkTlurXLdW?=
 =?us-ascii?Q?uoeuF6V7b1Exlmu3FKL7OqXEHx7fV0xWkfNmwrRU4hvM0HOMiHIl36q7pC/T?=
 =?us-ascii?Q?PWDAeN5Q8w8rT8/5fLSWzgyiUbq+p6iWb06abZN524OmTzw45WBS/Kr/17Tg?=
 =?us-ascii?Q?02geo4S9/AhPW4U0e4k5x1XdnvhE4O9G29vykO08PlU+FXS5G356lruyxp4e?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7611ef7-47f2-42ae-865c-08dce7a5ac17
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 14:29:52.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEM74ABGHj0pAnxJsRm2Gx/kMVBHqIvlY3paJhZR4TnYsiGU66MvvzSzGE8hh3NfMEt0PBK8/xMSmD4JvZh+6c3d1+CHIHnWKKT4Bc0fbRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
X-OriginatorOrg: intel.com

On Mon, Oct 07, 2024 at 07:45:27PM +0200, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.11-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>
>To reproduce the conflict and resubmit, you may use the following commands:
>
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
>git checkout FETCH_HEAD
>git cherry-pick -x 74231870cf4976f69e83aa24f48edb16619f652f

did this change for sending patches to stable?  Is this an alternative
only for using --in-reply-to to a failed patch or can
`git cherry-pick -x` be used as alternative to the
"commit 74231870cf4976f69e83aa24f48edb16619f652f upstream." in the body?

thanks
Lucas De Marchi

