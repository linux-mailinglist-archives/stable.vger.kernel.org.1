Return-Path: <stable+bounces-215992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2mzzNpxcjmmSBwEAu9opvQ
	(envelope-from <stable+bounces-215992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:05:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3356E131A27
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4873930774E8
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918592E8DE3;
	Thu, 12 Feb 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikYiDmxE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8B24113C;
	Thu, 12 Feb 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937495; cv=fail; b=HkrUKRjvwKIQppwDqSV0GIKv94pjtNdZ6RMXaN9TQBuSOQNRBLA57JkMUX+h2TbDY5TmvKSQATRXHVAYugbqfP/+dswB5nVKZmMruvNbWmkk3lpXuLFudzkvMZfh6zjXDQP0t2N67x6oALMUCZkiZ1JGM8Mn1ESmJmrjYQ3S+QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937495; c=relaxed/simple;
	bh=LTyBRPWvyWZOsIxm2x5qY0PzIAmw/AQcEznUWsiKRUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c59o1DyE+HElVLrQNcz8sa4+Uwv/uYRDAM82i64FopxMuIRGWkRwX8BmaaofYKNHn+y7muo3WvJ3qlqyFBWBLknJCfWxxgPRUBU+Jb/0KiFbebEWtvbIJk4s8kXmNjp1zbbr2oFOQXg+IQiAIr3Kx2tLE6jGPAOMA7vzPGw1fWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikYiDmxE; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770937494; x=1802473494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LTyBRPWvyWZOsIxm2x5qY0PzIAmw/AQcEznUWsiKRUc=;
  b=ikYiDmxEkNA957qBs77m7SsmtwlT/AaE5BTiSVCdvZxcfCN7fF0FyyWQ
   Q5JYAgx2FwhNFjxr7+8Em2lgbk666irJCIqEz0spPzI1W+7ZdBcwDgcym
   zGHgWvLswF5ICnBlsA4uuS1qXJbxJkV5mYdt/wPkwGmnmiq6/+353mQo+
   6koTz6hrQ84raiS8FssrluT5wq07ZUOVGln0Cgct5o/kmAeKo94fpWVG0
   agW31JErHhQ1JZlXEu/7FiXVvVgTFJLhFU9EBI0UbrDW2v5PsAV6n/g3E
   LAZzs9qo9AMSugCXMNnYpDRdifaRwpaxE+p6F/8VbmKjDJ3+8LO96JlfT
   Q==;
X-CSE-ConnectionGUID: 2S1XvSE5SvGi6kGbWzJ5eQ==
X-CSE-MsgGUID: xT7YaympRjeox1Bc7yErAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71837611"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="71837611"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:04:53 -0800
X-CSE-ConnectionGUID: QnMIN4BhQyeUak6hUPsCiQ==
X-CSE-MsgGUID: 0g/j1A13RiSF4p3LxkTXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="250427457"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:04:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 15:04:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 15:04:52 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 15:04:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Opu6AKPgHQ+BAvHji/RaeZRjfW8GGMLj9h+aVLGOJ22rZP0JFfD5LYrTrBxI+W7iUmVndULk+vzRbqDiHFABr+YaMdf7nD0yRD2dO3++uQZLS/zvNxjyPgDJwYJQsZUY4Gt5HtmWOicxkMT6HdVPh/JzI9trpnrLNPV91Q4ldNVraiG8r/D/g03U7+DV6ZfIt4oSRQLlcOep+tLi6BkeiFzP+NJ2W/wPTOvm0W2NbmCJoQNaPofi5vEBc5dQza2c+lYipKwFtvssTt9rpd8g2Bh0Dm4iFQxejpDTLYzE8juXt7euN58OnlnnakxEQICqDty3FDOyeug+1tfUNXM/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Wa+83+SVDvDxG3EyI6uNh8BJMF1peQnLoO6BrVDog=;
 b=YQYjZPqvw1Z2dcangGhyTLgmgWHZ8ylIC6oD9PKa7KWeZvbDOH12JXDyKXXt3rAujtgwH8aX/nS8oEnoMcsrURygiwKhoEUqYnEbXpy0bYPttct+cSFJSXyyWSVYuwMrnknZUCv/YRJ7EkCJX6ZuJ/31mu5XuZXq6tRMFLJKZbwQD93wJQOzjzmKthzSia3ExVTR/N3tsnCfCmeAnttOqU4tSd3v0tDJub1Lx91rsBMakAWgRzsrb40xox9qiBMKxeSPu9OmpeIgyYtpAcx/3rAUj/SKWTXS9WpWbigd8G4dEpR2CyWtfE1f2WkluAHfKA9tkpltGFlMfmcxZsv/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 23:04:48 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 23:04:47 +0000
Message-ID: <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
Date: Thu, 12 Feb 2026 15:04:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Maciej
 Wieczor-Retman" <m.wieczorretman@pm.me>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, <pawel.chmielewski@linux.intel.com>, Farrah Chen
	<farrah.chen@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
 <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
 <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
 <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
 <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 92af2a4c-6614-42a9-b4c8-08de6a8b1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjVsaHBva0NMNGZIYXRyWnAwT2d3MUpuTEZ4YnZmcE92OHEwZk5LZ28vNWI3?=
 =?utf-8?B?S2oxQWJ5ZnBYUjVaR1cwWHNFdTA3VXZhYkdxdlV0ekdzUmdQejlRYWFYM0Ev?=
 =?utf-8?B?R2ZiZytUbXVDNlh6TVhKNjdXQWpjTW0rbFlvY3JKRmE2YnVjc0JjaVR2OUVv?=
 =?utf-8?B?dXc2Smptb1ZOYm11dVU4ME5RdUhvdHVoWlVGbWtzZGg2THBtWE0rSUJTYnJ6?=
 =?utf-8?B?ZTRoNDREWlczWFdUTUlYSER2Snc5YjRCSHoxS0dyd2hBNGVSTjFIaFkzOHpo?=
 =?utf-8?B?aXd0OVBKRU5BcERzcXJDY0lJcjdkbEtXSEJvYnBFakd3Y1RVOWtiUHJXTkdG?=
 =?utf-8?B?WThKam1YelVuRlVVYXJ4Y3JYaFh3d1BKbjFNZlJDVEVBSkN4OU4zd2xLMDda?=
 =?utf-8?B?ZFJmNGlKOHBXdUNlZEdYd0FZZld3NExrSzE1VXlIaTNBYVRSd1I0OVd1eExC?=
 =?utf-8?B?SmgyeUFVNXpJaGtiTE5yMU9iRVRmUisyanZvZThMZnF1a0hXZjNidHRSRU5K?=
 =?utf-8?B?Q2JKQXY5UmVEVTFWdUhwK0Yrcjh4ckp3ajVZd3lVeGJqaklVY00zVDk2eERF?=
 =?utf-8?B?SnEwSjNHak9QRnpSeU9lM1kvUjR1S3E5S0tyRWFXNEp3NElLcEc3aHJoOTNx?=
 =?utf-8?B?d3VsMzRrU2xuV21TWjdTTGNUUDQ4NmVNd0FhMlFqemlKVEdTWS9CTTFaTFJr?=
 =?utf-8?B?ZjJ4eGlTSDJucTBldkhqMUtHUjd2RmQ1TFQ3NWZIOEtEZUVSK3VtRHNsdHhI?=
 =?utf-8?B?UEViS0pnVmZIZmd4VDRoalF2VFl5QVZ6NUF3WUFwWEN6by9LdGVPTmczaTVy?=
 =?utf-8?B?WmMyQVg2YW9yek5wbENmcGRRVjVRQ1AxUWJkOHJpNGFxUDZQUnB3TW1pTE1z?=
 =?utf-8?B?aXRUTENpTlVzZ09VblR3SjF5QzlUc0wzSjk2bHRnMDRTTmJWUUhjTDBqc2oz?=
 =?utf-8?B?RDdDNXEvd1QrdHZjb0JJSVArNC9icGhrN2dKQVRaWVVpeUZzWmhpVEFzTVJ5?=
 =?utf-8?B?cmJTN0dyN2h4SlZZNlYwY01SRlU5V2UwSWQxdXlnVmZEWkZlRDFMYm1iYklr?=
 =?utf-8?B?QURRSXM4WnNtenVLdys4UnlqTndmay82cTcySjE5Tzk4d0RlWlNiWkVQUWM3?=
 =?utf-8?B?TDZEdFFROWxXaEh5MjdpSWtoY1dhTXMrRWd1aWNhQjc2b0wvM1ZLWUlhOUNk?=
 =?utf-8?B?RWhmWUFtU0laTjFvV3EzN0t1aWdxNjMxb0dzdmRtY2o1N09qN0wzWDhQQkx3?=
 =?utf-8?B?WitRRTFDT1NHeTZOVW1zcU1EdHdqKzZSUEFESlgzRDNOUnVSenZxTTJEd2d3?=
 =?utf-8?B?RzYxSU12cGRvOThaK0FWQTZWVHZPd3JrWUsvSnVGeTRYVExHK3pDOTZOUExp?=
 =?utf-8?B?QnhIUTQ5aGpkYVpZNDFEbm1aUTh5eWJiWEZLdDlGR2tpZ21nUjZnUmxTS2hl?=
 =?utf-8?B?cEl1bUd6Rnk5T1ZJY3VSK1dJaWlGMmcyNVoxM2l4V3hDOWFaVXR1QTNNNE1H?=
 =?utf-8?B?UjUzT2pVU3lDSU90Skx3V2hIRlNEQWZ0TXBDd3ZadDAyZDNLVnFKNXZON2Y5?=
 =?utf-8?B?TkxLMXhlWkQwblJQZiswQ0lnMnR2aWVWdlM5eEwzMHA2SFNubW1Ndml6bnIr?=
 =?utf-8?B?V3FHSXp5REdWVE1rblZMenpaSlJYczNBZ2RCdnFuVWt5UGdCbFI5RkNxTE9G?=
 =?utf-8?B?NHArcjVycmdjZ0ZRcmUzU1pFWjRjRlZ2eEVXbitQTnZIVG83OW5OTFpiRGlz?=
 =?utf-8?B?em03NUo5NzFQS01GVnpxcm1xSFgrN2xrVkFJWWZSenBVYUNPbkVCOFg0UE8z?=
 =?utf-8?B?UUsrS2p4ODE4RWs2MDVTelRSZURST3N4NExNOUhOWWhWZ2FhOWtqZUtMbG81?=
 =?utf-8?B?V2xHSVdaaTMyS1k2M2ZRWTB1V0FTMmxyakgzT0RoeXVHV2tsRHlwZXI5ZW9j?=
 =?utf-8?B?ancwK2MvdHZTM2JIYVlBbzR6WWZHeUF0enFhdDRPM3hVZnFNRmNmRGVMOWdx?=
 =?utf-8?B?bXBVWFo2Nkl0aUpRZjFZdmJha2ZDOEEzcUc3cWpqZXBpaWpJWndEaFljT0Zr?=
 =?utf-8?B?VUpIWmdydCtaYmpaek9rU2hQUUdtcldkVDd3NXRYdnN6NkszVXp2OXphM3k2?=
 =?utf-8?Q?OL+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5zS2ZKeUF4bXAyTVdVamFmL2RuUDZoaEhYZGtJQVoyR0lQMTBzNm52SEtN?=
 =?utf-8?B?V3VHUi9WM25HUENNNjJWSEVSOFh2Mnh5TS8vRmQxNGhPeWtnNHFkQkxaNzlN?=
 =?utf-8?B?SXk3a1pNejZOUi8xT0RGYWJQV2JKaGh4K29OMnIyM0hDaTNYaUF0QksvZ3J1?=
 =?utf-8?B?NTJDNkdrZEJpUlBkQk13MVBibTlKcm1JaUw2a0QxOGUyUFdsSWt1a25uUXB3?=
 =?utf-8?B?RU4vNWRsSDJKYzVTb0ZkTUppRGorVGo0T0FhUWRnU0lYSjJrVXY3Y2dIZUxj?=
 =?utf-8?B?RkgwR2dzWDRMUXpqZ2RPaVN0NkFaaWl6SDNUOVdFTXZtQlZmZ1RQcytQT2U0?=
 =?utf-8?B?eDhWSERQdWZYSVdjL0RkdU4zV0txREY1OGlJZDJaaUpsNzRuV3dPS3EwOCtY?=
 =?utf-8?B?bG5DejlvcnFXSXpJblhHOHRXbGJIbGlMZ0lSSEZrcm9MaUNlQ1BWekZWbmov?=
 =?utf-8?B?LzFwYkNsNFdRWTIySHBUdFRaM0I4VVNuMVlKY29FVTZ1WnFJdm42TDV0SEVh?=
 =?utf-8?B?Zlo4U1FPazN0SVU4ZXV1YmpYMlc2RWtKSEtiTEkzb3ZTY0JyMnZMb3BGcXJK?=
 =?utf-8?B?VFBVRzlnZFNxSzNoYWxRUFUxUUV6UTBRRmp3Zmp4UkJVZmpPSk93ck5BRzBG?=
 =?utf-8?B?Ni9MK3Y1dk9NeitpcmxIa1RoYW9teXBPcENVZjNXY1AzS2FNQ3M1dytud2J0?=
 =?utf-8?B?N0JEV3NDZnk3YjFqWW5XaUVPQS8wV0Y3bGpGMTlKY1ZPcEQyYmlHdEJlVGpU?=
 =?utf-8?B?NS93TFZQNXJjanY3eVRvRVlCNC9CakpGRWZxcmVDTEU2M1pYYU5GT09IM2hV?=
 =?utf-8?B?ZGJxZ2tXbDZOWGRYa3hGdlBGVGpmU1pzOE96aDB3NmJ4WHUxakdaWjVzOGxE?=
 =?utf-8?B?bVRkVVFGZ01BajR6RzhtODd4UFRrbWNrbUhRRjJaNmJJcXhTckdCL05OY2ln?=
 =?utf-8?B?T2oxRUFKMFhpbU1JaGkyWjRhNXp6b1o1UkZjZ1RSODVoYzNDdXpsSHFvSlNt?=
 =?utf-8?B?NmxVbml2NEl4eUx5UDJHRmxvR3VhcFl1UmYraDhMWEI0dm1CQzVqMHpFTmFH?=
 =?utf-8?B?N2F1NElTbVZQNGFPT1dxV0hGaXNwNG9FazJQS0had2czYTdOWE9TanFqSVhD?=
 =?utf-8?B?dmxCaTR1Z1J4N2dmRUF0R1dZR3cyWUtUUXhTUnovVVA2S1FwU0tCem9saHV1?=
 =?utf-8?B?dVpIYjZITXF5T0cybW5RWEcxbEx0VUhQNWErejlXK0hUVmVZL05wMkZRc3ZN?=
 =?utf-8?B?b1RqTFhXR1haQ0EzeXFjSVp3dldOUXl2c1lTcU9IL1Jqcm9wMVdYMlNKZDNN?=
 =?utf-8?B?NEpkT1NDb1pGUVNQbk1JTTZFRUZVVStYQ0xJT0p2Qm9xaVdOTTJ0WEJuQlRp?=
 =?utf-8?B?NmVxc2tzYTNKWXZnVEFHYkkxUzFMSUppOENXbkwrR0NBRGowaVNuTGtSdlNF?=
 =?utf-8?B?TjNJOG5XbFdRMWJVTWZMSE5iYmMyQzQ2dlpnbGRxcm1oZGltZmg4QU5HbWRM?=
 =?utf-8?B?U2FiSGxBaTBpOXVYN0Rsa0ExQzZ2L0c4Sm83cEdiaEQ1MHlUVUxGdnlRenZq?=
 =?utf-8?B?V2ZPbVdoSkE3bEZmbzl6MHAxYzd3Rk5reUk0VWJiQ0phNkgwdEJmTDVsOG5L?=
 =?utf-8?B?Q0MyWTU3T3RMWHBiOXBCUThhNFBaTHpaTmRxNHFXcU1NNWlmZnByb25MVjRT?=
 =?utf-8?B?ZEY5L3FwMGw1YkVEWm1RVWZ5c1FXVDVFL0I4VlVUOE95elFrSlh6Q0FPbUV4?=
 =?utf-8?B?M1JaNm9uVHYzbDBXRTNUQjhzUEVnQUdLZkgvaWZHd0JXWW1weXBqV0xtZzhF?=
 =?utf-8?B?U1R3S2pmR2ZacmV5cUZsTy9ZSExRZ1pWRHBKV3d1UXFVQStkRWpZRC9RdXpV?=
 =?utf-8?B?NVlLNm5Vb1RZNkJOYzN2VUFoRGhRMmhhTWJ0cDNuRFZ2VGRyTVNPUld1Rm5T?=
 =?utf-8?B?Y3k5WVpNY0d4RXdEVEduRURZNVBJYzk5U2g3VlVHSjJvb1FjUU41YXUzU1Ny?=
 =?utf-8?B?bHYweFVLbGEra0lFandLemgyeUZUZUhER2FWdGRlY0hZV2h1Mmd2dEFzTmVU?=
 =?utf-8?B?dDF2ejZ5RCtDNk5jVEt4ck4yenpFN3ZaUUFiSVNYNVhZeXJKQWxUdkpJQmdM?=
 =?utf-8?B?b204TEJUYVpNeTZIQ2xtNU9FMER3M21xVzZpQUxsdkJzdm1zTEMvb1JncEl0?=
 =?utf-8?B?U2ZaSG9mVENBcW9vWFY3UEdUWFRNNjlKTkVXeGdFOWdZdlZyVTRjUFlYSCsw?=
 =?utf-8?B?YTZMTXdTR1RidjdmdEgrSktNNU9TS2hJMVp4aVptMldxVU5FMExTeTZ4SnM3?=
 =?utf-8?B?WnU0cG52SkQ5TVNUUUVoQ3hCNUxxUGhHVHg3ak1wMXpSeUhRbDJldz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92af2a4c-6614-42a9-b4c8-08de6a8b1e32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 23:04:47.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VIjx3v/YaO9MPbGWGB/r+znqy2HpBKLz8pUBvojCmUaG/bMQXvHXr23lffph7Xr7NEJFjPI/NMTNPwkpPfu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215992-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 3356E131A27
X-Rspamd-Action: no action

On 2/12/2026 1:51 PM, Borislav Petkov wrote:
> On February 12, 2026 9:34:31 PM UTC, "H. Peter Anvin" <hpa@zytor.com> wrote:
>> As the original author of the code I'm pretty sure that bug was always there.
> 
> So, we don't need to backport it anywhere, we change it now in 7.0 or whatever and so be it. We can backport a documentation patch if someone is really pounding on it beint precisely correct for whatever reason...
> 
> 

Can we just deprecate the "Flags" bits of /proc/cpuinfo at this point?

No production software can be using this meaningfully. We have always
said that the *absence* of the feature doesn't mean anything. The
feature could be disabled or the kernel doesn't know about it.

And now we've realized that the *presence* of the feature in
/proc/cpuinfo doesn't mean anything either.

Should we come up with a more thought-out mechanism for user space
feature detection?

