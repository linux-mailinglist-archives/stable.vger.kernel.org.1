Return-Path: <stable+bounces-88108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3A9AEDD9
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32AD1C23380
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5E1FAEEB;
	Thu, 24 Oct 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZrDECuX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639461F80CC
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790586; cv=fail; b=qsZ6oHLbA4VnlgI3MnhIOHhRLZCkIp9272AagDrSWZmZAcc3MkERuJkpYrMWEqXPfgtjbv98GZ6MbmY1bZl0QGN3XCmnkWRXJ/Wx9XAYsryogZB8CjLL8sa6YN3Rh+Jb3WvOq+YjruvQAscG4FQTVJ9kKqCusUfSRNpqJhWQcVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790586; c=relaxed/simple;
	bh=p17slaHwnZ/3sZVHe5lk/6fJzXpNerLaSoTtVnUxH8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FuAf8Y918viNkxawr88uuu/6uEYpWEjDN2v9qzMJvHIv0fLszVDJsAyYXAXPxCc1fdIMIEXkJp+0t4LAynvZfoxR938kzwnpOx8+120Yqmd/pdmwV/KkAYdhIIGPE8TeAwmQPXvaa8qbJ291K+Kv7cD6Z7S1yCxaxAI3XyOfiZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZrDECuX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729790583; x=1761326583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p17slaHwnZ/3sZVHe5lk/6fJzXpNerLaSoTtVnUxH8c=;
  b=YZrDECuX8L5m/s8TxPpYidcRQY/WVN5ttkycSYhcNDIsWhfcRtnwgu/w
   6eow60s00NvqlblygHeRsskZ6be+m2i0F+Mv+Sxl6Y3FHIxc5F6HYTXQq
   rsKSBm7owdgltkOoyZshcuoMNtNkD+8pSQB4as+GS7Us/mJvaxCvjquGC
   o1z/AIGnCf6ByhWmlZ947K0Xsd3IjVvhRCx79dAPM02Gh7laiuv4Qo0Ki
   T55jRPjVzKnuQusgxJbZ9WoOyaPNokze5guF8V/NjJk3kl0IYlEHdzsvB
   4cxOKegCYhlYHiYrwHnMS0bLupU+3UCb6M+ZIsmGf33Hq1geJNfJ0Ro3Q
   Q==;
X-CSE-ConnectionGUID: vO0SolcDSymzooMfExIWSg==
X-CSE-MsgGUID: dnqjVrKGSo+8acJykOjb0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46922005"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="46922005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:23:03 -0700
X-CSE-ConnectionGUID: f7/l92LLSeqLUctIn31RKA==
X-CSE-MsgGUID: 4LmTUUk4T/mJFTB0uo7ycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80564884"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 10:23:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 10:23:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 10:23:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 10:23:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8ohyEIFGi9wyxL5LoTd/RUqTr5uz82ZW+0EtcpdO22eXLdXpbQZBvF2Wn8rkbpSw/juUDtCljvTjMaoeHFBkZAfaoX/2gC/9Pg+8y4kUcJefQD/HQYPRAsTPazHcB4/UnFEt7Aqh7xmAJ49ztQCWI+vQXXMsKsy38hOphx/uF28xsBpVnbfTkLyGhBojGX97HLYTB5V3kuM8nRcA9d4rdVpsqW+dkXEs3WsUtYaTwpSSMbPX94sUZl23S6I/8lBeIZX4VSVVJZBBtAljGpK4FLpVR0tUDze1WUAxBE+A138O8zc+xG96X9kadO0OOBgWGDM7+q9UGbfbTWhQWIJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHaluV/PnalyG2R3friZGrk9YyINHK2VxDGttCUkRso=;
 b=hQihk9LUNrC/GaKokQ9eXyc9eg1G8zUe09oyPlGIobERccjbH6UfwJn/RK9VLhpABxYxNike/Am6Q5aQq89IiACmHL+BeEq7zzTTPaK7V8/asulbL6BBPF1GqA0yzWdtGKCn5C7P6xFGF+b5SMSI/1pngPM24ja4UL1ZycDhQCCHFtZkuuW7OtSfXDuA4TrjdWbxHMipbHtsUwgjjsCRQiw+0dJ1JrFkeOnAj39B19D1efPTAMhrYCLlzfhzywFD8NRrqtRViJNV2w2Eu5jXAqqHyzRQhLp0QPxfW3BEJcQmUm0wCAw2acm+uBtzOubHS8zCZofB4q7/m2khOZA4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7750.namprd11.prod.outlook.com (2603:10b6:208:442::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:22:58 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:22:58 +0000
Date: Thu, 24 Oct 2024 17:22:37 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: John Harrison <john.c.harrison@intel.com>
CC: Nirmoy Das <nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>,
	"Badal Nilawar" <badal.nilawar@intel.com>, Jani Nikula
	<jani.nikula@intel.com>, Matthew Auld <matthew.auld@intel.com>, Himal Prasad
 Ghimiray <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
Message-ID: <ZxqCXUp+0EWLVX7u@DUT025-TGLU.fm.intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <ed863a65-5238-4bb9-9173-d297ed953d1f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed863a65-5238-4bb9-9173-d297ed953d1f@intel.com>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 15de79d4-f427-4f3f-d971-08dcf4508164
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FqktwIDuPfYmWlIBg1mliP0l1rejuOCBJbRZJWLb1E+aohM8DqL+czRoBKOg?=
 =?us-ascii?Q?eHGEQSf2Auq4OAJ1jSq/cmkWrftWHtENX7QzJSIDmIGLQhikziQyLTZFuIOZ?=
 =?us-ascii?Q?pO8N9qZwJaE9VwZYMLkYt8GvxzCEF+Z9bfzTY13CPdSX3sS0laWHZlZNJ3aR?=
 =?us-ascii?Q?Dysxv76mAgkB9fH5qPqbJeUa2lmoxelYQqU36c2xnFKB4S5a/x6opCrAiEXL?=
 =?us-ascii?Q?FS5B01cRyydn9zKO6aKuGNWiuN2DPoFi+csbzYyiF81g2khJZmSeJwkUv8qn?=
 =?us-ascii?Q?8Pn28qDbGRkSBWmDgO5k9aoEsORa1RGnjN6V4HonGs3h7HDyL9iQ3SW/zhmk?=
 =?us-ascii?Q?W3Y3tiRAyPr4fUD6qpdm5fuYj7cNkR1SuFEmMT2TpnVXdhJBuBs0vIvOH3jg?=
 =?us-ascii?Q?FuW5x7cqgvxuspZ9XwwCScp+2kaomcUSSlTGZo9kG9DmLFH7wAYuYUZCY8YJ?=
 =?us-ascii?Q?yf9b+AJDZwD+wGNixIXjUAouvb+VhaonVRQy6iccHICgWZEVChH143EWjj1X?=
 =?us-ascii?Q?KHGb1y4fGtdLU58dPCHCxtub/7U5EFmxu/iKk0NfNsASGLBtCIDUc1JAemr2?=
 =?us-ascii?Q?WXwB0N1FUzzCT+ddRTpHHSTeTC4oZoUwKghxxKW4mOerYhRQ65tFd0O1gy3m?=
 =?us-ascii?Q?KFeWikPEnMOFwWy+cr/5smpKyR6TqNpLCi1CH1Nru6mjB04aUVBGYuIozkBQ?=
 =?us-ascii?Q?EeF4MYe64c5B9jD6K0iIlwHrzB0N2kXbZl/EKdFt8vwzj9wmgoN/vMKsrDA9?=
 =?us-ascii?Q?hp3jss76srXE1hkDiE+Gol2Tb9TWfLcAEY3YwQoj37p0ZWchcxFnTwHHq2Ve?=
 =?us-ascii?Q?FEGrg6VivSL0Tvx3gFgz/f9555bZ2WnFLazruCTXHTJ+VO63gYo72mSA4YAG?=
 =?us-ascii?Q?XZ4ed1AmkFQ2smj9wixadyDDbkB2jVIbWTyOt6LrP2R3P1WLotTU7dAKQBtv?=
 =?us-ascii?Q?DzfGP9JAuukogm3WpLF/wid2b+Qu4n6Zdo/zuVmGyjyu7ZlQUwphfpEeBwnG?=
 =?us-ascii?Q?YUwjxSCowBUS/ixqEvjIU8G/0nZUam0Pbt8o/sDsUe/bsgJC4an9sG0qFk7K?=
 =?us-ascii?Q?xti06L9r8W18nuGc5j2wA8kquntohO+aCnUIGJ7u7QqcCb7UfYXk2zHkjWgq?=
 =?us-ascii?Q?momZmeadpTf9m2d+fdmltL491fe1zmoJLRAIPofpWuHgBm8+Q4rMseXRZmde?=
 =?us-ascii?Q?yC+FyxTXbDCQfKHqP4uQ2fDlvkxbwnp1y+cR6rOUDotJFf8x6qgYj4ERGgfk?=
 =?us-ascii?Q?k6l/+6iNTREyF/CsAW8j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YzovV+6Ru/A0P+ae4LnegFT0UuDupVnC50ICoSDqQH9UFWkfTeoDgze9+khF?=
 =?us-ascii?Q?/2TRWQH78QGFAhfoo0LpbS9eZwcqC+m/Uermdsu9/HqWqwc3jgn5kNVRvBt6?=
 =?us-ascii?Q?/c1yiIoEY+WFMQ0mq+Rdm8nMOZNleZ7UBVwJ4z15iviHINZjY6J31sAfaAsg?=
 =?us-ascii?Q?0bAE2T7+nP3oDZZpIiwpqk9mZFjXvnLtMKR4GCqOQv8Xbr+3d3O4ft7YMl+e?=
 =?us-ascii?Q?eT2HVjI6od2AVDcc6VYiQDzEWQDCrNuPux5CbGjTTeTj6ZmgrHs+uyUeZtv3?=
 =?us-ascii?Q?Xyid+kbtPGFoPkuqyHlCxGWVM7ck3VXc+S2fbwxP3ebIqDI5FI9vYSNxJT5h?=
 =?us-ascii?Q?NSgzpiOJnm8E+mkESx5I1o4SLUxDv7sjYZrOI+4SDpJer7pZ8wy9tgPS6Esh?=
 =?us-ascii?Q?iHLN/LdVTOb0HXGKc8FFixWeiRsSdD712DpQ1viBMY1XaTDut5SKsMWuvfA+?=
 =?us-ascii?Q?am1kQmwzZaXoU0tV7uAG14s0ErraEzLIbqG7SAg8i1ms7N/MijITRpMaTh0j?=
 =?us-ascii?Q?MZu8Ap18EAWH0D6CDI96zD+5kyMTn+UHGv8Mu2+/SQe7Fyr1JmIWdjhk1n4q?=
 =?us-ascii?Q?h1SqqsD/KLla6W/xRPI9+Y8PSBD5mRQVbv6C4874mdbuIHG2TKH5ZPtfJK3d?=
 =?us-ascii?Q?JzU8GcSCYV5VDA9kOuDj1JsNuK43yUuLa6lWVPYzA025SFP7OpDu1CK596J3?=
 =?us-ascii?Q?51nzWufHEKiYQ3+ZeFqwTX0ZRzKPfSWGbwpv+iNGKiT9gCvjjPjEgWhqUD4D?=
 =?us-ascii?Q?RxAqzhGSk4CD9r+jrExerGK5GVLzFXbRkyNaUv4rOqLcStBZxPAehMqIdhui?=
 =?us-ascii?Q?rgg83FMnnfFAHcvx7GIdzjFZBZqDq+3ikNUb/Z/SiQmZn8RNbg+ZgdqR3UyL?=
 =?us-ascii?Q?Z26WHnkER01FYgeW0/p82p+8EYZF9M/5TPzw5e5U2rL2zuCpG1YbjcpAhz3f?=
 =?us-ascii?Q?D8FDP2Upnjr/JoBALxGRTJvjaSbBpeIuuMenS52baUnZvSaJO5OJa63GQIIg?=
 =?us-ascii?Q?iFsffauDCgF+b/k0UzejyTPemS8HdsO1UzKnSNJ+liUvcfK+o8c1xi0NIA5C?=
 =?us-ascii?Q?UDmAbn5dJylKsGZP3mg28W4lkWJDDffHyyO9Xq/w/W8b2nmnzXIn0fThlKaG?=
 =?us-ascii?Q?ZwBN+seiQOX8isHta1bQWHe6k76Dm5JAaGtnHD2daOD2itmsEufG7V4N18cB?=
 =?us-ascii?Q?d94TYEbdDcu7MrOnB4fldC8AgblYnZi8zRcflQ9ihaAulFZbc812R1G1/oDC?=
 =?us-ascii?Q?4Y9C7HeBSlX8oSff3r1fUnm/rnc14F1VTpSFpelKDVb0sosHQidTQnUN3QZK?=
 =?us-ascii?Q?8wFynw9aeVkDRFMSgBZBbg+eJw0fVRetLU5CIJrm+mQyIosJD/2FHYJUlEcN?=
 =?us-ascii?Q?rdglNSRdlBG57xd1OUBVFd9H6dbI40QkVwGn1eSNH35MzV5vlJ3YlohJ+yRz?=
 =?us-ascii?Q?HtRKvUPJBwpKJmxNEwasyYdwdkOfpwITRbi5UA7prT1dn2U91GNGWcK20Dq+?=
 =?us-ascii?Q?fpYDBe8t6UAgqAbUBuNCiXxsOF+OyHuPAuNGrE/X2bmyJpG2/DS/rgzw4Nor?=
 =?us-ascii?Q?nEPAWUQTlAI8U79OoKk38WX8NejlH2/ri7bvBf0989CNeCEFVrm+c2lBHAwF?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de79d4-f427-4f3f-d971-08dcf4508164
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:22:58.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUHGZy+bhjLbC6+ZPqSFgzCg1T/wEkuA8ij3BqUbtpJ0OP8uw9qq6qkBI4RCnpFbh/9pJeXgzpeolhBGhx31/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7750
X-OriginatorOrg: intel.com

On Thu, Oct 24, 2024 at 10:14:21AM -0700, John Harrison wrote:
> On 10/24/2024 08:18, Nirmoy Das wrote:
> > Flush xe ordered_wq in case of ufence timeout which is observed
> > on LNL and that points to the recent scheduling issue with E-cores.
> > 
> > This is similar to the recent fix:
> > commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> > response timeout") and should be removed once there is E core
> > scheduling fix.
> > 
> > v2: Add platform check(Himal)
> >      s/__flush_workqueue/flush_workqueue(Jani)
> > 
> > Cc: Badal Nilawar <badal.nilawar@intel.com>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: John Harrison <John.C.Harrison@Intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > index f5deb81eba01..78a0ad3c78fe 100644
> > --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > @@ -13,6 +13,7 @@
> >   #include "xe_device.h"
> >   #include "xe_gt.h"
> >   #include "xe_macros.h"
> > +#include "compat-i915-headers/i915_drv.h"
> >   #include "xe_exec_queue.h"
> >   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
> > @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
> >   		}
> >   		if (!timeout) {
> > +			if (IS_LUNARLAKE(xe)) {
> > +				/*
> > +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
> > +				 * worker in case of g2h response timeout")
> > +				 *
> > +				 * TODO: Drop this change once workqueue scheduling delay issue is
> > +				 * fixed on LNL Hybrid CPU.
> > +				 */
> > +				flush_workqueue(xe->ordered_wq);
> If we are having multiple instances of this workaround, can we wrap them up
> in as 'LNL_FLUSH_WORKQUEUE(q)' or some such? Put the IS_LNL check inside the
> macro and make it pretty obvious exactly where all the instances are by
> having a single macro name to search for.
> 

+1, I think Lucas is suggesting something similar to this on the chat to
make sure we don't lose track of removing these W/A when this gets
fixed.

Matt

> John.
> 
> > +				err = do_compare(addr, args->value, args->mask, args->op);
> > +				if (err <= 0)
> > +					break;
> > +			}
> >   			err = -ETIME;
> >   			break;
> >   		}
> 

