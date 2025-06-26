Return-Path: <stable+bounces-158687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A2AE9D2C
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3177B5200
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B8C147;
	Thu, 26 Jun 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDSL7iVS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15ED4C81;
	Thu, 26 Jun 2025 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939479; cv=fail; b=S+DdXxp+mOwWrzkpMypqDFdLg9Q75ec1ehD+EUjOjQ5A61SwM3vZMfHP2cwWV5/VQizmXFV9ldUu2SDqUUJ6AKS5WuYnK24hdqV0mfZnPfFdb0/m5z3tDT8pMk1dHRoF3zqahBb2T5x0aS8I6zot+uyvJgnbdBjaFnSOQLhxFpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939479; c=relaxed/simple;
	bh=/2GPWCIZ85lPCv+QqtSaWXEpMrNBC2vtj7ax+D6jHFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ro2yqZ9cc5iz4ENkpJ3Z2oIm3Dkt5AcmLr2GHrWZqemu1h3ilJjOjplskgNAdsZI2B0fWGfZqNwdD8SqTqhVvq9p5AUoAtD9ZOBBDKJ18pFvk8NH8Iik6b4SXab355XcxEFEeoNhjcRLjemyYucZEl9mKni/RrILaLTKk/GXrlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDSL7iVS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750939477; x=1782475477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2GPWCIZ85lPCv+QqtSaWXEpMrNBC2vtj7ax+D6jHFY=;
  b=fDSL7iVSGaSdGIUWhfTNhDMu1VsolZ7fhv4mrYzryqQA5lwlTlinlHMU
   wqzIukEYGGfFtfFxLsK/dNcSVMfYmUQ/9R9lPiJx9OvhdkQElswyEXE4G
   Zfxo+ZgomohJwG0gImdYb/XNKr1Ud7k9gKDHwGkJ4P/YaKeBv7Hi39t3Z
   hSTnYU0B14p5ps2scerkxwGcSrZJGjnOZhzUHPVtwbeAgB9iotgFi+X0k
   bPAllkj0u6F5UDFQdwDjJ2S0SkXLQ1E3QwS13UXPvbXWojF+z/2Jb48+P
   ilD8WSisk4JQLwSQcdCrWtweWfD088I/9a3mbh77Vp1NalC2xrgOfd7s1
   Q==;
X-CSE-ConnectionGUID: trhCsbJVTm2wWPwWu+XWjg==
X-CSE-MsgGUID: RGlkLrMTTBacFfK6lfIagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52460072"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="52460072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:04:36 -0700
X-CSE-ConnectionGUID: QwkoSd4ZQXukRuri0ZJvHw==
X-CSE-MsgGUID: tCuH/Sj9TG6S6PDDlcFGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152665694"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:04:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 05:04:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 05:04:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.82) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 05:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snjkJKFU132t3OAoVCPGpFgP79IERHGxf9Rc+qF/BVw2npd8xBz5Gn5vuGLLt8zW7jGZV1SWSTRIpjV03OBMS8qQHfLiQix0/ACJU4VT9LRD1opm8svZGlCid1gpZZWzPSiHh3vb7uNHFxRvIoM7ve8rGSgsVF3qijTKMhfOGzz0R57G+UjhcnzqbUzIHhvReYTH1FCwKnMC+gJeHcKPAQNBx/LT4FtbH0ql3e3c39byctgzRWaCUIL/WgnjU1efdjXxKRxMmOo6UVjejSrcEV0pNeplmAty1BrF8VlJtXFwXT6qE3KZwGgNHP0mxOR8ehHP/WT0HtqA2RZ3E+RCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk6iqnqTrPBmmk/aa/qm7usAHp2/O1z4QQQTEhAuLsM=;
 b=IFZ5ifjjByLwIAmod1s3ILcGMA9psNBq5S+2WmDy3VvkZLLZNZCyjIm87fr1vwZUsD/IYZp7obM1BVldxELGtRlelS/x1okO8tl3XDoGfndKWpn0uv8F/GEyl4uzzhjV4N3t+rgMby9E1M4aIkgVDvkMbfMthcPjiJymsoergyi7BRiNFfWecsQJ9RNJMQLV2ymEuf9Zvj90kcdNg3EfrvsDt8pTJU31P6YMUE0VsxbAy1RrKXcPwtfZ/YlThBCquBFhySa1ywNmm2cr58jzKDjj+Hv5JE3xCGdO5KNNd5ioIcl5RBrApLrMnK019gCheXgwLQq1YbQ0BaxunBvXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by CY8PR11MB6867.namprd11.prod.outlook.com (2603:10b6:930:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 26 Jun
 2025 12:04:19 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3%4]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 12:04:19 +0000
Message-ID: <83f82177-8349-427e-b670-ef0a9ff94c9e@intel.com>
Date: Thu, 26 Jun 2025 21:04:09 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] x86/fpu: Delay instruction pointer fixup until after
 warning
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
	<mingo@kernel.org>, <chao.gao@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Eric Biggers <ebiggers@google.com>, "Rik van
 Riel" <riel@redhat.com>, <stable@vger.kernel.org>
References: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To IA1PR11MB7917.namprd11.prod.outlook.com
 (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|CY8PR11MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc5f9cd-4152-4e97-0f8c-08ddb4a99472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZyTndtdGhXQjVlQ0lyM3JWZ29oeXhWU3lsWHZYMGNwRjhwWlJvaUZGK0Y5?=
 =?utf-8?B?bzFhdDZiY01KOXB6b3RBdTdad09BWE5Xbzk5b0xlbWRJUkFXQjc0bGViZGw0?=
 =?utf-8?B?QnJpMjA1U1ZRL1VPeGQyZ1d4QVhJaXU2ZXNrMFpFR1lWRnlneDdVWmw0cTky?=
 =?utf-8?B?R1FHUnFoL2tHOU5MaU5RTUNzSUs3TTVTYmFuOUk4YTExalFXYzl3a2k1RjBY?=
 =?utf-8?B?bm9EVmZBVkNJclVSY0Z4dFNiczd4SUVZUTliRWZaN1BZY0FReG5wVDJQS1dk?=
 =?utf-8?B?Y2VPV1Z1UlVFTlRnQmJ5alBCRDdjeHRFdDBKWEZxMnl4cWFYRy9EU3AxQ1B0?=
 =?utf-8?B?WmdocllWOE1tNkxQTWxpVk54eEF4Tjl2bnU2TzVrVDdyd25JV3JwZ0gvZkg1?=
 =?utf-8?B?dDlwelNzNHptMURZOXlSVE5tUURsQ3NqTzFHMzJqM1lPc2NBR1NIVFh2NGFG?=
 =?utf-8?B?TGZKMHZrcmVDeFBSbGFhdWdIZ29BMC9VZlVNcU4zaXlzL1dEeE9jVytIVU5l?=
 =?utf-8?B?WEM1UCt2MlhQWlRoQ1dEV0dac3I1MXpSS29FYlZkbnYvbVN5UWFSdGVrTU1r?=
 =?utf-8?B?M1c0ak12YjdldzMxbEtnVFFSL1Q5cmV5SmpRMUNuZWp5dVdDZ2dPRjkzaTlw?=
 =?utf-8?B?Qzd5Q01KeFByMFZhcW5yTVdNQWZ6ZUF0YmdIb1VocVpvbTgzV0pyVWl5R2Nk?=
 =?utf-8?B?UEE3cWpjaHZzTXhRcVlDNkFqbTFDUEpjYnJjV0J2ZmFVUmZ4Z2txRCtBWkVq?=
 =?utf-8?B?ZVE3U1Z1QytnWkl6Qlc3V3lKN0FzSkQzNlA3NUwvMkJkYmo1a0dub1V0LzdB?=
 =?utf-8?B?OGpIMXdnMlRlajBwdU9yd1dLdWNzelN3Y2tOZHJnZ29oRkxsdjJKQVZIMStN?=
 =?utf-8?B?cFpYN0hkMXpJeUM5SG8rTkh3YVR4RHdTVEp4S2xqSHFLWVJiSGs5L1MwRXcr?=
 =?utf-8?B?TWg1OVZ2cjZ3a050OFl5aTZCalhLL1RCWDQrOHRjWjU3ZmRaNU00OEhUSHY2?=
 =?utf-8?B?V3RxelJLblNhUG05enRiL2NEUndSZlpxblFRcjZmdWFFMFc5d0wyc2NCNDhS?=
 =?utf-8?B?VGZJNExBbE5nOGsvclJYZFZ4c1pHWVdpeEpZZmVNNTczZHl0QmhUOGpBSWNK?=
 =?utf-8?B?dDE2SjVRd21malJZb3g3d2dDSTNwYUpacDUyR3hmVTdVWHdzVDNkWWxlMEhx?=
 =?utf-8?B?NktZTW1sMWpCelJqVmkvWFRCL1hkVFBqd0lIc25zYlRZNE5EaWo0QlhFR2tj?=
 =?utf-8?B?UERsZVdTeXhDbFNxK1p0WVVRaXA2a1BOVkVtZDdWTWVRYmJ2OEh3bjlSVExm?=
 =?utf-8?B?eW52MFN0TFNPaW5jYXk2U1dHWTVvR0VKalE4WjhhZ2xpNXVOMGdvVFExQ29h?=
 =?utf-8?B?aWFPbkc5UlhzZVhnRStHOGVsenF6TVZoZmI3NjlBY3hVZk5ybUdGOENxNzFk?=
 =?utf-8?B?d1ZCY1RJdHdqYlhTby9CaTJkV3VCN3VEVXhvNHR1RHp1RHlYT3E5dlVGb3pD?=
 =?utf-8?B?TmJRYXBWa0JkMXVYZzE1bm02eU1rd0lFZm5icFlhZUd2OGlIMWVpYW5uQzRT?=
 =?utf-8?B?MEZabWwvb1V5b3RNa2dkU0Y1UVd0bnUwSHVUTlpkSzk2KzhKeXppYmxJdVRK?=
 =?utf-8?B?SGhXSUtPako1UWFMcnRkV2FJRStNQUpmQ1JkVjZoV0JVTVNvMnN4d1lBNGdv?=
 =?utf-8?B?QzE0Q1BuUXZKRjVCb1VlVHdpQmsrM2NISEFRRWxSaElMQ21yWGlCc0djQW13?=
 =?utf-8?B?eEhkRjJtbHp2VnVrQVJ4YUlPYlNpMG5iUmUrcHpFOThQcFZQYkx1TjQ1QjND?=
 =?utf-8?B?YWRhdU5qb2tlakxIZnhzWW5hdTUrUUs0cjR2QTROY3RyUFBydmhXeGliUXpr?=
 =?utf-8?B?Wk9tWEIvL0QrVFJzSUIrcDFpMnVWNFhHNU5pTC9FY0pLVVI2ODUxcFM1MUpY?=
 =?utf-8?Q?Q/CDAlA94l4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hXcERQVHdDRWVBUmxKWWFIbVJ1czUvSm5obys2TGJzcHBBR3R2Rmo4SVdx?=
 =?utf-8?B?UVBjN3NOekdoeURFK1pHSmt4RWRBTVNpYzNJWGRSU0tEa1RvME1HaWlkRlRV?=
 =?utf-8?B?bmllK0ZQbG5JMUQrRG1oazA1N3hyNVNHakE3dGM5d252Ky9TNGcyRTlMKzdL?=
 =?utf-8?B?d3l2R2xYVVJHZjFkakJ4SVN3MklSU25PRU9YVEdhQXkzWTN6NEhPV3dzb2tH?=
 =?utf-8?B?SUtVOFBBdndKTk9sOVVLM2hqT3AyUUhlRGRYd0VHS095citIYzJFeTJybkRt?=
 =?utf-8?B?bDBFT3Zia0o5YWZ2Q3RlTGhTWkxmcm1ORmphdHlyVGlsemJGdGhqS2RlQWlS?=
 =?utf-8?B?UzZzZ2FpcnFRR0JJaTN6K2Y4bEJNWGZFWVQyVm9uRlcyeUVJdkJoNTVjM2dH?=
 =?utf-8?B?VzN6OWwyL1dTV2Nsc1lGVTMzT0FqLy9zanpPYjZyNjlKUmxCRENyOGFjcFJj?=
 =?utf-8?B?ZzY0bXk0Yno4aUVGSHZFd3hLaVlwOXlhU3BwS2Y3Z1NMM0QvcHdjMi90N1py?=
 =?utf-8?B?Y0V0WFhVQm41TStDdHZRa1F0eUJETi91TGZjdllYSWdKK01sNU9ZT0c4Z1RW?=
 =?utf-8?B?eW5wbjhnZmhJQk1jdm9LRmVPVkpGYk0rWEpVOWduVVFwSjFBdUZMU0tTa3Ji?=
 =?utf-8?B?aXZEOHF2Q3NBZUI5M1hDbWQ2NDFFSnUwdy9Mc2ZHbXpQMnVEL3dKN0dyWlp5?=
 =?utf-8?B?aHNZY1d2a3JxUXY1UnNrQUEzeEZncDhvVWtnODBMcnQzR0l6bHVLbjFuTkQz?=
 =?utf-8?B?OEowa0R1UGRmNUttWlUzRThRcmJ2QjNzQmFWSTYxeUVUUnhqWW01bTlOUXBz?=
 =?utf-8?B?aXBDTkJGU0tvUzFxcm5vMFl5M3BiR0NKWkdLd2k5S2tjL29RNFZHSXdRckhK?=
 =?utf-8?B?ejdPa3pCNi82SEZ1a3RhZjFEUUhXQUFvaFJ6VXg1dEtrY2pOSUc3Zzk2TWRr?=
 =?utf-8?B?VlBpT284UlRrNHJQamdPY2tnbXN5elg4UmhsbTFNWUNjZHNpeitnTFM3TFdU?=
 =?utf-8?B?SjFkNXZGMThveWxZNjJJRWVhRXlKYkpsUEMwWHJxZmV5Uk55UzZSTE1OWk5p?=
 =?utf-8?B?NlRjVHN2YlU1b21qRjV0U3JBellyK2Y5YTBHbGV4c3JjTnJsQTBkUEdmYUlB?=
 =?utf-8?B?eEJ3bVpXeDdsZmZxMWJFNHdGS1BSdnBkclRURXlJdHhlMXAvRndFZFRtcFNM?=
 =?utf-8?B?bitDVmdQcFAwNDZYQ2JjS3ZpM1JCaWMzbzlSMDhjaEZwdzhLcEcweWlDYVZZ?=
 =?utf-8?B?M2JKTWNhUEdrdVRRUDFsZzAwNEt3TFJOdHdkRVdyMEN6aDRJb3BLSXJtakRN?=
 =?utf-8?B?LzBzbkVheWh6V0xydUJiQjJWMVF4ckJPWEdXNWFiOHZBbFZ3L3hHT0ZCVG16?=
 =?utf-8?B?RjFzZWpjWEgyTXVzbmRCait5OVdlQUlOT3VpYVpmaDV4TmVleWZJUVRBY2hO?=
 =?utf-8?B?ekJHWFMzeFJrcjVOUnpUdVIycG9KRG9QODlrWlE0bnN4Zk1tTDFmb0xMYlNU?=
 =?utf-8?B?ZFpVMmRQTmYwTVhXOUtZckd4MkdDTXhHMHI1VHB6Uk9yTml4ZGJRVjFNTk44?=
 =?utf-8?B?cit1UCttaEFnUXRLQU93R0ZSREtsU3AvMUl1dE12STRWV01VZk5TU01YNW5o?=
 =?utf-8?B?T3p1R2lnU09IMjFmbUpZVkh2QmFtZGdGZzNrYm9rTk5yM1ExTFpyV3IyY3Vx?=
 =?utf-8?B?aW83Ymtqekd6UDRKUCtjVUJwUHFYekxVWW94NTA4TE1vaWFxTERaM29oeWRo?=
 =?utf-8?B?cjNmTmdDWkFncnE4ZGJtSjZ3c1JJNzRjU3NLMWVZZ3Vwak9EOFkxbDEzQzc3?=
 =?utf-8?B?N21rVGxWKyszSk5ZNGhGMG10Y2ZmN2lwaEliSVlkckYyV3ZQaWxWSHFseXA0?=
 =?utf-8?B?OWtpY2Rubit3eEpkQmFXS0duM1BQWDFKaGRYaXlKbmhiMlNZQ2RDc2pvV2Rz?=
 =?utf-8?B?dTVnNnVaczBXSkJ6OEo3aHFZU3M4NzYyd2ZBM1FGSnlTZndrbWNVR1JtOUth?=
 =?utf-8?B?bXp2aEIvVkNZOEJEL214Z3gyNmVTUUxSQ3h0bU5oUkhZc2daUzRGa3NTTXcz?=
 =?utf-8?B?K3NhTUNOM05JNEVlSVBVa0ZobUU5OEt4cUgyK1pKRmwyUE5UakJobnk2N1Zp?=
 =?utf-8?B?eVM3VUJZNlNUSERyZzFrdEkzWHA0WXlSQVpnVmFOYnlKVjFxOENpNVlrWU5V?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc5f9cd-4152-4e97-0f8c-08ddb4a99472
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:04:19.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3Ra2qT6RqCO6LALT5MczyhsCytaN8e0bo0lccdW0XNg4Ym1GXZvG0YKp1lIjTo7HMLlRcsyyA2oz3ociSE2U1L35U/VgPlOERjFmWuC4os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6867
X-OriginatorOrg: intel.com

On 6/25/2025 6:01 AM, Dave Hansen wrote:
> 
> Right now, if XRSTOR fails a console message like this is be printed:
> 
> 	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.
> 
> However, the text location (...+0x9a in this case) is the instruction
> *AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
> also points one instruction late.
> 
> The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
> keep on running after returning from the #GP handler. But it does this
> fixup before warning.
> 
> The resulting warning output is nonsensical because it looks like the
> non-FPU-related instruction is #GP'ing.
> 
> Do not fix up RIP until after printing the warning. Do this by using> the more generic and standard ex_handler_default().

Indeed, the fix looks obvious and correct.

Also, the trick you previously shared for reproducing the fault is very 
useful for testing cases like this.

I would be happy to provide my tag:
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

Thanks,
Chang

