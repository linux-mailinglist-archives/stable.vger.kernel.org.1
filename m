Return-Path: <stable+bounces-176574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDEB396A0
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C986C188E4ED
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2C287250;
	Thu, 28 Aug 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXEgu6pW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4E283C90;
	Thu, 28 Aug 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369043; cv=fail; b=svRBi0NIIQYsTHtIjfc7dDbXEUmDysuHn7yvqUJRGLAlQc4V78RoUukGAhAbOIFE/4FDiQasdp+TtwWqo3Ysc7TXEHBWgl5FyU7z4xbmoeE4OTG2FeEM9FQ1FeXYo+b7B1zXNnETx6MW8Ez2vRv33CqdJxkJzeYsBHtJDSSuR6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369043; c=relaxed/simple;
	bh=Hc8Tf9acx+6Ycx+B7R+zY5mMLFXv/+ttMpbH3LFWw0g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPmZb+K9I2tjkSgy6nKjCT0qX0PtLG29eXb8lPk3TV9Whf827wfHKOn4sIjziWfbdHYTWnUFocT6Az+0AnVtUvm38zzYeOJGUL1u6W0rLVwNfDI1k0GUQLWKOo56fZfW207O8xhHKSYP4QVloleC1P8V1DLAvcq7Q9w7cwjNBA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXEgu6pW; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369041; x=1787905041;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Hc8Tf9acx+6Ycx+B7R+zY5mMLFXv/+ttMpbH3LFWw0g=;
  b=AXEgu6pWh3X1ud1RCrsKApb5M0D5bu4+rbKaLX1+1VgfzxlFKS0Es4ZK
   g14iCJiVeEM58LcgmtFrwOfAO5HXgqr3yu13rpTDAm0OTfYUz0PlybzTT
   HAcqY5hq8AqRvhxRSWfOWBKl928d7xwgZ3VdJCgqGS+/+ZxjJdrXxQUOO
   1RbF/Gg0XK3PA7LUV6p5fE+PQFxVFnoNpklM4o35s4IA/hej6YQUHUeJV
   Htqdn5cTRn4P58Au2jnC0LQK2BrNfa8POv3AQ/wa++073uCKLpkzA2yn0
   WenvJUfby82g0fH6+yS/4gCEk/TJpU1LpEoV352fFbHGCTNMYsHZJ2Z4C
   A==;
X-CSE-ConnectionGUID: /wB7Z7t7QnmHCdPAzRtkTg==
X-CSE-MsgGUID: eqVYMsNPRNGLwuR3/zyaFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76230245"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76230245"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:17:20 -0700
X-CSE-ConnectionGUID: JjV63VM+RpKnyQCbrjoFTA==
X-CSE-MsgGUID: InSPa+81S3i5gPNJbxe3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169969665"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:17:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:17:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 01:17:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIJxAH30kzribucd1OigC557VHprvwKYRMbemrlTHLUpxPWSZScVvB7bkH9r/RElGQCNbEaHxj50WbBVvVEi1LwQBYJkE7nJ2rps5PKYJfZDjGXQg2jus2mRsx4I2At4Zr0Ij7nBRY37kfLUZNGpHArEULR7cc6W8wXYxCiBjAy0+WjQ7oymRnCZehAoQ+QsEDo8xSexNWzOsbVlYrZ92Pw/O5oPwVcB/C+Vpi++gfOfmkoHJnadUch9zLUaE/m76FM7f16Gsmyetrfwt29peWVVHudF4rBg/MJVueZnrIxCy2ZgJMcF0LS2TjZQwA1uyPk96hDGRp1F1/7ZztVf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/RRHX6aNW2/Z6MEooyJX14y9xdhKDJ7TQFaxIEci34=;
 b=eIFxvVhzRSqxlven3jNAuqEuopG60EZ65sPyz2OWug/aAyAw8+2DpaG1H251sK4zQtekLFVFd5aEewrkZGS01lan9S27EMAUCVlg/4Ic+Q7/cPFUxNOwnnGW6qJNhX/0DVTaiU7RKksqnQMSuCBDwrMYVrpp8NGz3WP86pqU44oUnnABiFYnjzl+28Pig73U+Ozr3E1j/51Lnx18tQCBwHtEAqXwKxcyZDzIEi7mIebRs1dJPUzCL2e9jsyxucMgsaGZj8ckbDYL8pL1kJgucVmfz7Ql9PGSNNweOMAOYRigW21YKTEB4+ZRzxPd/JxyVUMSr3kvUNlaWq4S+uRIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 08:17:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:17:17 +0000
Date: Thu, 28 Aug 2025 16:17:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Brett A C Sheffield <bacs@librecast.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<regressions@lists.linux.dev>, Brett A C Sheffield <bacs@librecast.net>,
	<stable@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<oscmaes92@gmail.com>, <kuba@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <202508281637.f1c00f73-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822165231.4353-4-bacs@librecast.net>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4c8511-5e02-45fa-7f07-08dde60b4d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B6ii476CepfzoZzbkUkkaC4gqAcSrdbJT1m0gyozww8Jkv+AB07NpktJuRfs?=
 =?us-ascii?Q?3oEcX9mXlNrWZ4p+Sx3T9ei0HbMZrU4SvdMrYN6iE7wxD+5fUl2rbpCex0OU?=
 =?us-ascii?Q?BGYRDyFOlQ3MTDNuK4POYnQXxOSm4EnKnV4VWvOIDSaqMldTMHxne29uA8uG?=
 =?us-ascii?Q?UMyiSV48PjD6la5i55+7UOBp912wZjcixQMTgY1rmSUDDvCvVhziyBLZHZC7?=
 =?us-ascii?Q?9NSEcMY3KT5NFdi+zbzVCwzS0Xo0xcjqT0py8kz3JklX4WeGsS0J273lp9Ed?=
 =?us-ascii?Q?f0xE2xcPxmGpiDjaGaFFveumq8baCvpM8Kg8EjrmvKUcEDT7vWnuyXX5w0IP?=
 =?us-ascii?Q?90pfGS/wzRV823E1vGj2U4rj8HIaM8/q/amqh4+9yHMbFNE8ZLKnjAA7Ry9l?=
 =?us-ascii?Q?M/BACLU6gPBwQw+PwebrYNVwZB6SlSay2m9WLcFyBb+cY3kcKhmlMqH8iQbg?=
 =?us-ascii?Q?15I+Xorwd2eWf/mMmehhtkHBHOmIAsDQNtR94ArDzNu/OFbwXEr9kwq7b4m9?=
 =?us-ascii?Q?mkMwOH5Dvj/6DJ9VzxYS3g9CZEAnshuxZsYfFIQcuXVaqwReBdx3D/x9BdMt?=
 =?us-ascii?Q?W+G/UXrTXZ4XBuiLEjlsfwYndi4AtKC/Vk9FTk6iaS0XsUeSLTHfftaxbWzz?=
 =?us-ascii?Q?1KORfoRe6WUzez9+5bTDzDrdhuWTbChg+Pb0G66s7UaSz3DjPfVKYXn0n9P/?=
 =?us-ascii?Q?aGS8FKsQPYkeH7Z/ggaX9U3dY3AgP2/VB6JzUOouWesqSLg8iR4ZIHIvjNfv?=
 =?us-ascii?Q?kShAlqZwOizN1pAL9kWQ2bm6oP59oLSeguC2tmQtO0D2Bcn7P1CLhJR7mO/g?=
 =?us-ascii?Q?w64p9yuLH1Tznyxl+7VZAO8qDrt9ozrY0QqfjHfDxrqyXdhKaIG9BXidXM8O?=
 =?us-ascii?Q?wooPMklQ4SAvthkdvlB2RZbiNi7wrODRrCaV5B7+Gb4bnfqCcebu6qVvdJrk?=
 =?us-ascii?Q?T/eEwEBGuzwzDnmWGjonpARqXBNNh6qImt24/Y8o/y4Fk8vuJe2AOoY57XF2?=
 =?us-ascii?Q?QetxjfjfdMD/8gy0CFi9i6kn9f7ARFH7w6TPhC9iu5Vx30FDQ8k22hfWzUDZ?=
 =?us-ascii?Q?Kb1aNgBZSF4iCZ9bjsgmxafC+w7QNEr1T8WnmiL91AMLss4YT/QhgR0NgDeu?=
 =?us-ascii?Q?7Wqev8KCSjfqZTpUMiHhYloRfEd9J1pxWCg+kzMFxyVG5ApKuS7j+M/fzmZv?=
 =?us-ascii?Q?UtnODsRR5meO4c4SK0uHyqwSO2QiicFC9HYTmz3Tqh4tWqfQ4ckiTSB2SD28?=
 =?us-ascii?Q?Q8AG40Lw/lcQ9RSpqqBJl352VqyMIXRiHn6CqJbATAnHQ0nSO+OZTnppw2BL?=
 =?us-ascii?Q?/F1FzcWgpDngHel6S3t9dQPDQdwPJ44X/7vTReZzAUvYXK0ulcnWl4DkfXHy?=
 =?us-ascii?Q?3HljOlL3Jp9A/Lb6PE/CknqH4fwO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AEQabvcZYtyjgRgPckOxVz+/t0zKHlnVej5P4wA8y/XlzpIPk4ajpzNFgrqA?=
 =?us-ascii?Q?ULrYB5yhvGGajrqULTZG0G0QlF9WENvPnhiecQYDJvG/7uBTAIPk7Q4qFdta?=
 =?us-ascii?Q?q3B+Kr7OBAOaV4PHKwvu7qhnjRcDBWlaG2RBE2kYMTlGowxYAVsbTI/xP9zI?=
 =?us-ascii?Q?T7HdiyKjhAdzVGi3TfhFk1c3dVipELcwz1KHwumkTQrRvQ3CQkN2IiFzjzxX?=
 =?us-ascii?Q?bQm+C3Sg5cqgy/mVUMPZk9xtQL8uCT9oe5Hm/RhVlCKRY33SxOGoRap50ueT?=
 =?us-ascii?Q?K8EbbO74yTtdN5ux5Se7O+LFte7Qdh8EE05F1tpPtZu9dEuhWcX8h6jfWVGo?=
 =?us-ascii?Q?jwsF6vgF0vFbIn1ETZBF9Ivaobag4YSmnyDYPFvp9DgUWwMR3dmihQ2Twpgu?=
 =?us-ascii?Q?rmWipt9/C4fUQR1DJWMTaewsiwpQnYuJonuhPVTev+99Wd7X/gmTlUtWft4K?=
 =?us-ascii?Q?nSO/TFmKrG/9KeRNlgP4bk9qMulxXpaAh8yjUk8rYwjOeioW24S+gpaT6nTv?=
 =?us-ascii?Q?rHnJEeJpn1Ty/h9gC+TU8jyZJqjynfxDWC1yo97y+W7Kd0aQ9TNPGDzUquwh?=
 =?us-ascii?Q?ghh+n/uKYLMiHVOX2R3bLpvQ5adsg73TgxZCb+OIFLlQ/5cTv6Waoomvjm/2?=
 =?us-ascii?Q?39Z9Gu+PftpzN9cJCl+Xzgwr54s0Fxh9AF6IN4HExMsv9Rz6+zbFYTyQFAHj?=
 =?us-ascii?Q?iNRQ2PFkdG9lwUQQlPKHCieUT/1G7smOPZpYew78+97q0ZJ0etXTl6HIjHzj?=
 =?us-ascii?Q?uHJMGIQMtjWaz/d0ATicldh8d1GGVBmaaPfXyP7oeQuX9fZNdeyx0sSmUo+6?=
 =?us-ascii?Q?i6CNsuJL36ESviPJjsf/5aXjtEKPtL8ldcBDM7aorvIKiUoHm8x5IQo2BVYu?=
 =?us-ascii?Q?wmKPN1fSJYI1cbN3o/n9151FM2OPXFz6OEOnDDWtc8/WvoEgTbRfr6zxU9za?=
 =?us-ascii?Q?+ZaSbGBb38XvT0YqIakeXAMzh6u8eQGKeCTx+dZFod1ziSoNq2NPTcP9HkGA?=
 =?us-ascii?Q?8L3Wc+w2jsF5BFJkQF/wTd/51Bf5lzc+AvFvGQWJiHkN73LYUAPKVJf68Yuz?=
 =?us-ascii?Q?gNvYz6ep+ELMMuR21pTazC2knLmRM4oaGOahJBXZ4lsDCQ7M7rHZsMY/tiGC?=
 =?us-ascii?Q?gs2gU4aDJVZyLh43mG0Wp04vgSzUKQYUM3fgQWaT9USxlQAFYOSV52pfwHnJ?=
 =?us-ascii?Q?wFKJuOn0YAFJkcm4/vjxEzubbk772TrD7A0zO5FEbb5xGPJ9UUmBcqIW5m9q?=
 =?us-ascii?Q?2ekbTa8YxbNqX0IFX/1YByPJGQb0lydck6664aa7X12d7MHkwlmh7URW3wgT?=
 =?us-ascii?Q?81hAefyNTK4uGxyWWhMJd36w692qS0oOqx9KcRtxQC6UHg+tH55fXHG0xh9G?=
 =?us-ascii?Q?KSy9EZ8MITom8rVYAF28N21JzfdL2mTRL0sk1H7pq5gF9Bm6N3oA74hbSFuq?=
 =?us-ascii?Q?8JTXlHB93Rv6pdtv0AbIuNAca/nkjKaQnzuUEXFv3vQEW0wfaUWMt06yZ5zi?=
 =?us-ascii?Q?3PrLy7sjK0bElfPadpDtPWd2sy30WzcwtZJir9sic9XAKuFsLGDvNUwkCoHF?=
 =?us-ascii?Q?VXDG1OWeOOyKVprdrJTV1EuFJuzRUpBoR8beaRYN0xeRRyVZRQSrsnxk6ipL?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c8511-5e02-45fa-7f07-08dde60b4d58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:17:17.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7+RwQP/Q9U0Xu5O2IbnldXS5OwKxCnjMk8y7T+A2T2Ac6gLJ2/RORwQvZzXv8Au2iq1+iRa5p1ceJuG3VJAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:

commit: a1b445e1dcd6ee9682d77347faf3545b53354d71 ("[REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes")
url: https://github.com/intel-lab-lkp/linux/commits/Brett-A-C-Sheffield/net-ipv4-fix-regression-in-broadcast-routes/20250825-181407
patch link: https://lore.kernel.org/all/20250822165231.4353-4-bacs@librecast.net/
patch subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



config: x86_64-randconfig-104-20250826
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508281637.f1c00f73-lkp@intel.com


[  344.224405][  T239]
[  346.380232][  T239] [main] 270958 iterations. [F:200215 S:70364 HI:20538]
[  346.380362][  T239]
[  348.540466][  T239] [main] 282649 iterations. [F:208752 S:73502 HI:20538]
[  348.540488][  T239]
[  352.276620][ T4267] Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN PTI
[  352.278585][ T4267] KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
[  352.279982][ T4267] CPU: 0 UID: 65534 PID: 4267 Comm: trinity-c0 Not tainted 6.17.0-rc2-00174-ga1b445e1dcd6 #1 PREEMPT(none)
[  352.281748][ T4267] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 352.283361][ T4267] RIP: 0010:ip_route_output_key_hash_rcu (kbuild/src/consumer/net/ipv4/route.c:2663) 
[ 352.284480][ T4267] Code: 3c 10 00 48 8b 5c 24 60 74 12 48 89 df e8 d7 d5 f3 fc 48 ba 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 58 48 89 d8 48 c1 e8 03 <80> 3c 10 00 74 12 48 89 df e8 b1 d5 f3 fc 48 ba 00 00 00 00 00 fc
All code
========
   0:	3c 10                	cmp    $0x10,%al
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	5c                   	pop    %rsp
   6:	24 60                	and    $0x60,%al
   8:	74 12                	je     0x1c
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 d7 d5 f3 fc       	call   0xfffffffffcf3d5e9
  12:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  19:	fc ff df 
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 58          	add    $0x58,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)		<-- trapping instruction
  2e:	74 12                	je     0x42
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 b1 d5 f3 fc       	call   0xfffffffffcf3d5e9
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah

Code starting with the faulting instruction
===========================================
   0:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
   4:	74 12                	je     0x18
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 b1 d5 f3 fc       	call   0xfffffffffcf3d5bf
   e:	48                   	rex.W
   f:	ba 00 00 00 00       	mov    $0x0,%edx
  14:	00 fc                	add    %bh,%ah
[  352.287420][ T4267] RSP: 0018:ffffc900037cf7e0 EFLAGS: 00010202
[  352.288406][ T4267] RAX: 000000000000000b RBX: 0000000000000058 RCX: 0000000000000000
[  352.289715][ T4267] RDX: dffffc0000000000 RSI: 0000000090000000 RDI: ffff888155e8a0a8
[  352.291007][ T4267] RBP: ffff88815a690640 R08: ffff88815a6906d8 R09: 0000000000000002
[  352.292287][ T4267] R10: ffff88815a6906d2 R11: ffffed102b4d20dc R12: ffff888118e51701
[  352.293502][ T4267] R13: 1ffff1102b4d20ce R14: ffff88815a6906d4 R15: 0000000090000000
[  352.294417][ T4267] FS:  00007fa824b10740(0000) GS:ffff8884259dd000(0000) knlGS:0000000000000000
[  352.295629][ T4267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  352.296648][ T4267] CR2: 0000000000000008 CR3: 00000001284fc000 CR4: 00000000000406f0
[  352.297771][ T4267] Call Trace:
[  352.298404][ T4267]  <TASK>
[ 352.298958][ T4267] ? ip_route_output_key_hash (kbuild/src/consumer/include/linux/rcupdate.h:331 kbuild/src/consumer/include/linux/rcupdate.h:841 kbuild/src/consumer/net/ipv4/route.c:2700) 
[ 352.299842][ T4267] ip_route_output_key_hash (kbuild/src/consumer/net/ipv4/route.c:2701) 
[ 352.300711][ T4267] ip_route_output_flow (kbuild/src/consumer/include/linux/err.h:70 kbuild/src/consumer/net/ipv4/route.c:2930) 
[ 352.301444][ T4267] __ip4_datagram_connect (kbuild/src/consumer/include/net/route.h:355) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250828/202508281637.f1c00f73-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


