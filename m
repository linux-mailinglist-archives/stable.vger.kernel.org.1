Return-Path: <stable+bounces-239991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qoWMAHqB5mkIxgEAu9opvQ
	(envelope-from <stable+bounces-239991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:41:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62843366D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB1A300AC85
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB83C9438;
	Mon, 20 Apr 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktQ3apqc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053F279798;
	Mon, 20 Apr 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714102; cv=fail; b=gY36UvXer2xGv0yuhIctgmfb3anyXVzVbA5I2PS5Pol8700FwCvv6F5Fh1bl6Ua9rlAR5vlWbIO17H3SoJ498dzX5REnfrO6h21kZEkb8KMuwrbcihIsCx+qbdFM5EpUKMX3aSCn75Cu4Pg4mS8VO4rSebNGKCVU4WKdXNgm364=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714102; c=relaxed/simple;
	bh=6nvNkvieYrZr8wgfnH9xzJVHjaJi0fcwXamsdzvETPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dboUCnzvBQNGwKXu9Ecd8ylaQ0UHuZnEdSi22cdWjn6pytivhotw52caQAVMurdTJQpK9f6LG+fsaIA8zlvPFRIAKjDrMMhRnwcFDQdaMxFFFpmEvTJAgi5fras+xQZsuLwFI+iUPRGrCv0Zb6bKZVf5zQWPrMzVBRJ3xP8xWwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktQ3apqc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776714102; x=1808250102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6nvNkvieYrZr8wgfnH9xzJVHjaJi0fcwXamsdzvETPk=;
  b=ktQ3apqcPmSAwIkmJuRJcRKBOUWBZMk86AyFcbxwAP16cC0WG8qG7Roz
   gj8Gbn3b9uIwwD9Tq9BzBYWAIagEgF81UmiUD4H/uJebES9twHWhW7jnJ
   l29F2Tlrr5T/UaMEI2Yr5IYLRh/Q33IaFwfhXys67KB5jSSOxRkUQyhMs
   5Ko2MXzWBWzu4UE/6LUYUkVuCTxFik2dt/DIN76olhhpcowllqY0SAnM2
   brn39z7YXn04zyVvxmQR9UzFJMm7ZeR9/CAE3vuHOgn+pV3kfctTbLGuj
   BXgR38VOOODcq9WlrefcK3X0jAge4hkuxfDDtaUVPMvssoaO+lRS7lGwn
   w==;
X-CSE-ConnectionGUID: CmHXbakQQOCPHqCKP6ikRw==
X-CSE-MsgGUID: pNkfrGp4QauTezBvXLqueA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89109687"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="89109687"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 12:41:41 -0700
X-CSE-ConnectionGUID: Z3pAIluaQHOaTMR/bIrXiQ==
X-CSE-MsgGUID: sF99clViSRKw0fMxhzPuEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="255070644"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 12:41:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:41:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 12:41:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJkQ2PfIzzQKMjUOZ4YQevlOBhKUM0ANbtPOhK9AZ2nv1NUegl+LallV99ubzS+8usgbZSNE3doBfwUmLxmK3gjug76hi512s3LBrUe2xwDEg1QiUo25n9xXBzccCUC3V0Ox+mKgEglb1Aab+r5n2Q6wUyo/4aysdf9GBO4gz6R95ynN8DOw+PRDqKk0ooOGTTksHvEzGgAx4fPsRy68kzl+PsDI+uAEfAzu/IxRApwNWOF9AFVccmQDYCcV5Vv2RilDEnDF7+57OrcYNIv1Eu9SnaONfnzH8Nv3wskzsGEVis6raGDtNlvZ0tHmO8sOx9EVie9BL/g0rxKOo3KUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1kJNKus0xb2RQQ9Qs+5EgtQQw0q217mfOWw4r/sJIY=;
 b=EbVrcXzWd+I9gSYrEhkWtw9Ol0l6mzBX2rPwP7zfHx34hBFE05rHTtCfGWNyj1aCBDt/KyINQpHIkNIpWhgohG0rmLbJ9l0v/9mqRshWfiOuNQ1yaIljcLk4VS2Tpbe9z+lPhNh823PSrBBnTDZi4yUOtVrrf9ukz4wFvn75zeehl5KX7aEhfWX1d9ge2o1/8YljJdm69plA3T2k87lmO3AWZ+sm1RSSxymXh4teAcFxOJxt+8H4kv+KmeprjJBvopdYjX2s/tWZkTOTl6hA8FTUgq1195HRlzkCj5JtqwoZJdKy8/ginoJri6J3N0DTtmNuX0PzTe6MPPpft1r4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS7PR11MB9499.namprd11.prod.outlook.com (2603:10b6:8:268::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.12; Mon, 20 Apr 2026 19:41:35 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:41:35 +0000
Message-ID: <3626058b-1fe2-4472-99e6-b5fced88fcfe@intel.com>
Date: Mon, 20 Apr 2026 12:41:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 11/12] idpf: fix xdp crash in soft reset error path
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<stable@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<patryk.holda@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-11-686c33c9828d@intel.com>
 <20260418190019.194263-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260418190019.194263-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS7PR11MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 327bfb18-cdda-4658-f819-08de9f14d499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: NqFDo4WSo5IAv/+MOE3dd4IutkcaoE4HDfVGD09VTHaD65eYRizTWCTZKD/sXDyqvnpl9eaYq0oQGQxmwSYSJqozYO5jg4WrAWo5/mArekUr0RtXIyx95/dFVTjYlYnYa9/GxAPmKj8GrZHkJVVjB9iMMwJqV/kCXhO427cUYCniV6KuAmYByixiKRonl8F/QhZsVC9WFg3SlbarXzD0oB812IK0FmICiIU6ZwqmEzo2FvsTfm+09bNhpDfhirLggVC1D4dm8214bE44AAXTfwFpz1+E92uFiAX/Sidvb9AlCI1oDT1U130YhZuLy0JEAVMmv/8/ygsuqjPFqCU6gtQkASMXdu7RBkOYGYnVG9PD5N/NWHEXg0xoZPSSHUBtLRwDDuGc6DF2rAHV0pckLI/SXCNrjiGnR2lU7n9da01l+5EosymuGPR8Fr9TsCIGIczC46uLcfPLLSAa+guO1ohwr7W+ZyllCgRTR/MWD3J9cqXtb4gIH7HGL2VKrvYsxW8h1UvBawJXSY2pti1r1YMsnix/E0MaQKkFLJJ73qkao/u5C8zS1Mag/6Fy9WKTowLqwv3frJLCTTPtsmeoDmKPKa/v16K8wq7+2tSrJt9K//XGlevH7Bikjy6iqQm9LTEFKYFQMDIJgMDKq1HbGV4uIo2fDZrhAN4mf+iO8PcYruzva0Q1q4CDNEhEnVgQUwbB0guuXYi+EkgKsvhWrGu7iFzWT3Vc6y4fhuWykD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC81dkgwaUJETVV2bzU4NXJqZzRJZW1xNDJSV29SOWdPNE1GTWFrMUJGUzV5?=
 =?utf-8?B?eVRFZGJWY0NPT3hXT0tBKzE5OVJBVUJCYUhlOXpKQjFST2dzYkVWbjJPWFdK?=
 =?utf-8?B?NUNYWktub2s4ZC9udkc2d0ZEc2Y5STZFNThKL3ZyS0NEQVJMY3YxMHJGTTIy?=
 =?utf-8?B?M3lpSGhIdldkTUJodys1TExVeWwzWkpDM2h2M3VLZERiZGlsMzdEQTZSUDc3?=
 =?utf-8?B?ZVhtOWcyYUlNdWErckN3TEIvblI5RUhIVSthWkQvdWRMeGxlMjhHVXN1Nkpq?=
 =?utf-8?B?M1A4Yks5dFVXMFFVRWZveHRlWG52anVzY3QzQjUrT3BFVkFYdkdxQ3ZzMFpl?=
 =?utf-8?B?SkFEWUR6Y1pKbHdFRWxsMHBmVGZUWkFtZHVRbVFJRE1IRExGeE1RME02RGpM?=
 =?utf-8?B?TEJuQUlpbTl1Mmw5M3BSWDU5UFcxMlJYdTZkOWFIQ0YxcUcxNEJ4WTRqNUR4?=
 =?utf-8?B?UkhQNVNUMjlSUlk0OVJLeUNZS2xFZ2FWeUNNTVJuMDFBSGpuY2s5cE55MmhQ?=
 =?utf-8?B?aVZDNjFwQmpFNXFIekp5TjRaV2FYWVZaQTRIWnpZQmJDV09TQmY3OXZBeVJ3?=
 =?utf-8?B?WCtQeW02YTQzVVNXTmhTN0dyTGp1QXNqemFQekNYTG5KNlBkcXZIbzlhZER0?=
 =?utf-8?B?RWNVTlBVQlExRVpPa0RIMjYydlpObkl1ZmRhdlpCamFxMTBkdVlZSmVJNm9j?=
 =?utf-8?B?TzM1amVJWmkrWVA5eThmVGFLNHZsaHVjQmFlVU5wNm9JOHRaSjdHMGlOOWo2?=
 =?utf-8?B?bnYrOWhoak1kVnpMSU5TdVhsbjJYK2FLd0NPczBrWExWSzh3VFRPRi9hNitv?=
 =?utf-8?B?RmJhdjZYeW5ZQStFWUIwUGpFZXgweWpTcTlTeTZpMUhzVkk3b1RsUjJjUWtu?=
 =?utf-8?B?WXdqQWlDS1A3akJrcllhZmNnd3JKQSt3bno0L1R4NGVFY0ZYdHN0bDlqOHFv?=
 =?utf-8?B?SUhNb0JtYk1WQmJwRjhRVk00MzA0dGFqVy9YNnhwMENrd20rT1FIL2NRTCtC?=
 =?utf-8?B?TndXWnFlZEJqMlNJSU5EcHdxRkpxei85NUk5RWRlZ1FQYlhtOVVXTlAxbFZ2?=
 =?utf-8?B?ZVQzUS9CZ3JWMTdjcW1sYlpsbDUzZXlCQkI1NlRneHNYRk1nRHR6dFZxalBZ?=
 =?utf-8?B?bjh2YUpMQktOVVg0MW9DeEpmWFZEYTQ2U0FhKzdhanNTOElBQXR1VzEwb0N1?=
 =?utf-8?B?WjFJZXdoZU9CTWZ2bE1HQnNocENaQmpHWTVWOGtrN2pCRVFXRkFMcExKMkYw?=
 =?utf-8?B?akFRbkxBRUFWRXNhVkNvL2FRbUdBbG5wbDNTZ1IzM1JheEFjdStpNDlNc0Rn?=
 =?utf-8?B?WVpQWU9vUmM5d2Y1bVZtZ0R4NjRSNUNRNzFLbnlUbGxibVVxTWVyR084RnFH?=
 =?utf-8?B?cGs4RlNDUkw1T21xWHJYT0F6KzRPSDhCTVFzMXl0eWpNRExsWW9CNlpPTjJh?=
 =?utf-8?B?T2lZR1puRGxpVWFLcU9TdVk0ZFQrVDFKdFVsS2lNaG40ZVBpdzB5VW56TUQ3?=
 =?utf-8?B?cFlPS0pNT0MzNzNIWE5aUmg3RVNMVnllbjR0ekw1UXBWK1QzcUFqUXFYTW95?=
 =?utf-8?B?NFVhbFBCRDFvWlpQR1NuSGtEcEEyVmVJN0ljekhodFdDYkZVb2VBSktCMEhv?=
 =?utf-8?B?VGtId05yQWVxVFg3Q0paU2NrMHg2REcxemVQa1JnZkFUYW9LbjY1WTlYd2pu?=
 =?utf-8?B?SjNPRDU4VGIrMnh3UnhYdWR4N2NjZEg3ZlVUbGlPZkVMRXA1WG02VzNoRHFE?=
 =?utf-8?B?S014T3g4bnNRcFRlRHUxQUZjNWtvRFhLWWx2cEkzcXJDU2VXc3dOakI4UE9V?=
 =?utf-8?B?Mnd3dXhoMmFhOGU4SGxOS3pWd1k0eW5lMGRUOEZoQkFUeFU4WUpVWWYzdW4r?=
 =?utf-8?B?dG1QVFZON2Q1MW5rQmV4bHBML2w4SW1JSWs3NVVqS0R3UTBqNjdVMzBHN3ZH?=
 =?utf-8?B?SHVuc295NkNTdi9Ec2VvUzA2TDBNR2ZqTGdabjhZUnNudkpkQXV3M2k0T2xV?=
 =?utf-8?B?MWtZczNtangzUDQ3dStKODM5RDl0VDN6dFREakVXUWdrNEVMaGswcm5EVDZQ?=
 =?utf-8?B?RCs0N09jTkU2RzlHNm1lV3lINFM3eWtZQUVFWXZsNmh5cDlSMGVYaU80TGpI?=
 =?utf-8?B?L2Q2dG9wVnBuYXpjK2c4bUJ5cVZSdWpYckZLa0F5ZlgzVG1yZ2FzSmVVZTBT?=
 =?utf-8?B?VTA5eXo2T0lVY3V6S0VZOEVoRmNHVjIvdkQwKy9MamlMbFhmTGhzWi9KYlJG?=
 =?utf-8?B?SGZtY2RkcHpwK2loN0VwMjlPcVArSnZyNDlIM2lIdVlkeDF4dmh0NzdOaWJL?=
 =?utf-8?B?R1cwOFRDUm9iMmZ2ZFNJYUp3U3BaVlF6OXNkY1dRb3FzdTBIUWdvZz09?=
X-Exchange-RoutingPolicyChecked: KwYbbzNW5f+yLJiSaiGju66TuSCLqCLyqLSWESvrNL9011utX7C03XL0NW8H+Bgx5EiF06DKIFNdKYdakK+7vMgEC+jKmQ0/gS53BuSnBsk0Ni85E+iItZEmGlERlGSGYgs+QOQEuzK6cNE/Cmf45oB5UtifBhr1cNrNmkb91CgdU0XDbrMeOaYAgvNHsnkviFMqVVvVa6cCBTi+caDTDa6Ip5vaw/9Xjc1+ib4NbPqMq6Mtg9d9AmhUSLYDJ2auJxmRLjpDaZpQXf1RDqSytkYt0d7QKhJD+TjUOYUHL8V0IGj/4xip688I87FU5IE+lSfKHlicNbOPERPnIyiDhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 327bfb18-cdda-4658-f819-08de9f14d499
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:41:35.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+3ownEeMiNvQUe2ZenC88XI8DSvueCPGB8TlMSKNsgJ4Bb2onT1ytzPPFI+6IiNKRLHt3D8TdO6IuvHkNGyFbrKDYJ/Ikt9evEcd68HtLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9499
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239991-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7F62843366D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/2026 12:00 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> Jakub: I'll drop this patch and apply the rest.

Thanks. Emil is on vacation, so I don't know if we'll get any response
for this fix for a bit. I'll forward this to others on the team and see
what they think.

Regards,
Jake

