Return-Path: <stable+bounces-132449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBCA88092
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23E3A5772
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA32BEC43;
	Mon, 14 Apr 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kY+IxQVO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2002BE7CA;
	Mon, 14 Apr 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634349; cv=fail; b=GTp40Pz/A7Yxm7DiiXoU2I5Tz6pVWa3Q+I9fT4zyGmB39tHTRJ8zSBuX2kMbBHWP8dbRT8+jK3/p9U9eUaN54/WOclhYVWU4oSNkykCwjwsNTm1uib4T/Si9o31GkaEdLdblz6SR0AbTB6Sed/pAgPyFzXbfYBl8FvmvI+efmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634349; c=relaxed/simple;
	bh=P2CJhZT/fzeKvbVCjF2kFK3zafLtAz1QcxeSa1882Gk=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=mxARnuf2nMLA4Dw1f+ydsQMpe60Vkrg5PzjRmrcDInY1Yp1gQ0g1FJaeqdt3suYJpcyUBBYXg+1uPhORki9RK7sE0eqKMyh0AZSHmhkv+v8WDoi5/jUncvD7uFr08q0PI2BbOh1PD6t2oAehrYy8uqZf46bEDpQRdo45P/IwYsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kY+IxQVO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744634345; x=1776170345;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2CJhZT/fzeKvbVCjF2kFK3zafLtAz1QcxeSa1882Gk=;
  b=kY+IxQVOlt9UHxrb3tD9lTBrBQRm4KBlIRxFE8QzcNOs7BT8MBgL+mMU
   oa7RYPcNy1P4VX/dykvInJ0+Js9bOPGAHgLLqUgukM4f1uOYfeEV0jl5u
   FoVeLF2Aaem8WvDjW/MdKZjlJ7Y5X/3pXWNY/a9f2pZBqkwFHMO8imKHL
   sCwRcSRgpnwUN+zG8Dj0zhpjdX0G/5glGtICcTwrJcUGpEIGvZiSqwkF1
   cgw8twjrM5dTKD7MTdtYVSblESgiGqNfTtUi7NpsBNV5lQ2yJO1t9qas/
   qo5OHEx6JiWlRo9wDn7Vpp4Gd6ZUZWTJgXJtcVmvSV8rrmHIBzR0VwSSD
   Q==;
X-CSE-ConnectionGUID: SQ/Z6VTHQjeT+6u/j6mxZA==
X-CSE-MsgGUID: rz+ZXRiqRZ2nMxCWeyo0tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57488448"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57488448"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 05:39:04 -0700
X-CSE-ConnectionGUID: YG2NgpZySCOsyEgDMhrtTQ==
X-CSE-MsgGUID: k2MWepAmST6eAwyhMWkd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130664885"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 05:39:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 05:39:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 05:39:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 05:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT06v4PneI6e1XHaKnmRe5e+0FUIjD/sodHnwyIm1XLMxWIlpTz+FuhyozMeeaPGDCDZV4IMIza6kTwMI2r868Y/HYcCzkoZVVpcYToEDezoOgAXip+xEUbVBsViHAyYr106sG6DRg+lggGRxEFkgrxcAM07uC8kNDb4HB7V79mle1FbgZBRvt37MFX6qnn5oHZYSKpyiiacLja1x9RlFN711OfyITT8vyWinCK+uvp1pX5O8Nn9K3xdsC9zeR8Pp4cRmHojf/vf4JOZLB4TY1QSLEvNZJyOST4+kXGTk2l1GzqT5WWWs9ZYrU1g36j0/v2WNd3pXsQX/n/10SqiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmiYNnzif8Ye25V/tsKZ/8sZYPflcVrFlg2iKnmvy7A=;
 b=FLoZj3Xe6vnhXkG9iFleoNhxxAEYyAYDEBkMheGS7W6HAwVY+0vvXlw5EllocjcpIsf+GJfPaOskx2GK+ys10jubZvz8zUnWNlx68e6io+aLjR7r0+pAsD1OILb+BoacMtGV51UJyI1Q7EUPXG1qqpMcAwnOWgVrCj1qBahaGhHCVBQCRZVVEpHKESNA4FyIBUSdok1v1Olv9xBTbd5DChJjTNEXEczzKfhcd5PHi0ohVjIYfOBRF1o9d6rgO9P84XxeVfkO/xdYfrQSKlUnQpIx10VXCTyD0y0mL3OvDS9ggjVdLAI5CMCFRgpcGbglhTOAfm44GVNcm1+VFXIB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Mon, 14 Apr 2025 12:38:45 +0000
Received: from MW4PR11MB5934.namprd11.prod.outlook.com
 ([fe80::96ae:ce0:2a38:7408]) by MW4PR11MB5934.namprd11.prod.outlook.com
 ([fe80::96ae:ce0:2a38:7408%5]) with mapi id 15.20.8606.033; Mon, 14 Apr 2025
 12:38:45 +0000
Subject: Re: [REGRESSION] e1000e heavy packet loss on Meteor Lake - 6.14.2
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
	<marmarek@invisiblethingslab.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
CC: <regressions@lists.linux.dev>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
Date: Mon, 14 Apr 2025 15:38:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <Z_z9EjcKtwHCQcZR@mail-itl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5934:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd5f246-5551-44b5-17ce-08dd7b514bee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXBXT0x4UGlJU2R3TlV3dXNEcUZXRHMrbTZISzRRdXozVVZJOUUyUDRSRFZy?=
 =?utf-8?B?RmlDM0NRT2w0V25ZKzRDT0tRK09lclpQQkNPSTExWlgyNDE4T2lreXNYY1NG?=
 =?utf-8?B?Z1NTWkJMYnozM0cyZUdQVGpzcldSQytVUGl1YUt2M1JjQ0pYU2srQnZzNHJs?=
 =?utf-8?B?Y0d5VTRudmR2VmE4RHdsSHhmaXl0VWdvRzBGVGNsQXlnalBkTGw5VDdDMUNo?=
 =?utf-8?B?bmltUUY5N1ZaYlVSdTJ1Zm4wZWsrdWdNenRqdmFLUlZzTnJhVXZ1cTB0empI?=
 =?utf-8?B?cjlJMzlXVVJ4Kzk3UG5yemM3RlNtSFNFdlBsbzhZVFgvWGkzMTMrejdWYTFK?=
 =?utf-8?B?S0VkUGdYTHZsaFFJYzJLT1Q4UjlZbVdtZjBJc29tUVB4ZWJsZFlLNk9YYi9S?=
 =?utf-8?B?YVo2RjNKbGJGN1kwM1ZsYXlvaWtmY2VEQml5R2ROU0dSeDBpK0xHbGV4eFpq?=
 =?utf-8?B?dmdtcW9TaFlHN3ZuZTlpdzNnUTlPR0VUWDhIelRNbFJOU0JwU2NRcVl1RkU1?=
 =?utf-8?B?UXRyZDJKUGJTSzVrZ2VNQUpNUk9VUTZQTWdIZHBFME9UMTl0Zmhpay9WdVJm?=
 =?utf-8?B?NjRsMmY2N3RTeGsyYkFqK0YvRDYvRytkOW04ZGVhb2IyUFl0eTFhVHc5YmFj?=
 =?utf-8?B?enFLMzlVS1o4cUpWUDJDRWN5b0xyaVIxWlhDbmU3dXdwS0g1TDAwbDRMT0VS?=
 =?utf-8?B?ZWVHeUppQ3pHcjkyRDNQUmx4RzNYU2pLdjhJMjYxVDRUYWdrcXM5bVFSL3hZ?=
 =?utf-8?B?THBwUk5sQThKZDBlSWhjQ283Wk1OVVVoYnFsbWg1dzRRS1hOdWliY09IVjNY?=
 =?utf-8?B?MDhoZVRHYlRrTXdhZmJCMW9aMjAxRmVLYmhwRk9kb2E4amJudFZrR29SeER1?=
 =?utf-8?B?am9ENkNCQUltTmU4VFN4REtURmdZM01DL3I1dXNkNm1BaVF1THY4WGZnV3hU?=
 =?utf-8?B?OFBhMlArOXE4V21OYnViMFVZcUZjWlpSMGNILzhpMHVpcWl2QlZRNnhLaVFm?=
 =?utf-8?B?N2lYZkk1Y1hscStJbGZhTlBmS1IvRVBQUVlIcmlNREF5Rit6NzBXQ1FBemNo?=
 =?utf-8?B?UUUybTIyQkpnSFBuSnN4N3FueEZsK0lFN0NOMklKYUVJMjBFSS9FeFY4a3VD?=
 =?utf-8?B?b2hSMGkweVBIcWNOVDJUOW9sS3FBZDFzaUR2dTh1TlpxT2N2YWhpRkIrY0RH?=
 =?utf-8?B?bUNDWXgvRFZLZmVwTER1OEJ6N0wzeFRNdUlHNkhtejBieFR4SXlUQit0MHBx?=
 =?utf-8?B?djhTNHlGK3I4STlVTzVWVjM2VmZKbThpa3B0Y1o5c0JkVHdPN2RpTGo5d2Vp?=
 =?utf-8?B?d2hQMjhJbXkyclZjZVhTZXZDODVtOXlBN0gyUlFXUERSS2d2MFA1enlLNWhx?=
 =?utf-8?B?SGFPMDZ2c2dWNnVuektMV2h4MVJrbTNBRnJ6SmhGbGIzazAyRlBoUGRpTm5w?=
 =?utf-8?B?eXhFN2M2dVBUdldabmVhb1ZrNS9NT1BYckhydXUrN2lkR3dQenlCb285ZHJM?=
 =?utf-8?B?eW5EZUhNZldSc2I5cXo0QnBtOENjdkswb05oZGVCTFEvcmJNdEh1aFlINlpB?=
 =?utf-8?B?SzRlM0IxOTh5dUdXNEZ4YTdoc084Nkw4Y3h2dWphNWgzOXlQUWlSS3orZmRS?=
 =?utf-8?B?RnRHSW93bUYwbzRqdmM3c3NiNG5GVjVyeGJmdktuSG1ySHduUkljZEpNWjhr?=
 =?utf-8?B?dFRzTTlkV2Z6ZFRrTkh0cEc3QWdDa0FCWFVNVHpiUWVzYXJGY1ZiSkxRTEZ2?=
 =?utf-8?B?dktxSEN5ejVnTTJoMk5JUTU3RFhLemZMdkp5enJyU3ZkQTlrN0hBa3Z6RVV6?=
 =?utf-8?B?eWhsRERGZ25xc1E5SkJ3TmlIYTdMOUVlWjRtYUhyejJuOGwwSkJycDFKZHVy?=
 =?utf-8?B?cEswbGMxdE9oQ1hybzV3TEhURGZYOWl6dUMzb29hOEp2N2VEZ3ZuRjFoaVMx?=
 =?utf-8?Q?FYVq7IkKkVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHU3VWg1QnBCdEhVQ09kZm4rQjZiVmM1blNyN1lsOTJaZWRLNEpyZlZPdVk0?=
 =?utf-8?B?REExTldzdGRFQ09ZZVN4MU5NSzY5bE51VDQ3YnV4Q2ZSakxDekxCME5QVEJl?=
 =?utf-8?B?UTdvd24vaGJnL1RETDRhWHc3TE9qZlpoeWZTdDZ3YXdwc3k3MVNZZDNzclI2?=
 =?utf-8?B?c2FOR2oxdG1BbnVYVStPWlhTU3FJYUFpR3JtNGtXQVdPRDRRRFdEUTFaY2U0?=
 =?utf-8?B?UUtWczRQR0VyaGFjcStLWEtkL1Bub2tiUjd2RGg0WEdKZk4zSVlHbzdVc2tZ?=
 =?utf-8?B?UisrQ0lhRldLM28xNE92dGpkeHBMZ2pVNDA3S3lYK0xUUytYdlJyVWsycU9K?=
 =?utf-8?B?OUVyNmRDcW9xS3pkY0VmdTZrWjZJVjFleG5wQmNqYkNqcUpMREZSVm5zZ2tV?=
 =?utf-8?B?dS9vekpGek5VTFdnL05JMkJudzd1WWN2ZnhZd0tLMHFwVDVES0cyY0VaUDUz?=
 =?utf-8?B?V295NC9vUXJ5SHcwaTBJQ2psU3JUNk5GYzA5WGRRTFd2YkY0cDFDK3pNYkJt?=
 =?utf-8?B?UHRyeTZlVTFWT2NpUzNrK1BaRmhsRlBvK2o1RFZ2dEpRSitTanpucmZtNk9S?=
 =?utf-8?B?RWlmLytXdlBvYnhadVVmOHFYVWRpYXQ4Slk1S21EYk5jelZaVjNVSzZIeGRH?=
 =?utf-8?B?NTVjWjVxckprTWp0end3NCs0K3lsZzBrZlpybGlCSHBoN1RTczhJU1VZRTZl?=
 =?utf-8?B?d1pRa1VHQVN6SVJvSVZnQjZTT3pRYVpKN0lyaThWMmRzR0o5TnphMW9JRWQ4?=
 =?utf-8?B?QjNWTEJFSjVOSjJnS2ozckt0OS9yQUJKM3NObllMeWNiY0cwMEhGbTRSaTZX?=
 =?utf-8?B?WFNnai9HbndyRDlWZUlxMkJ3c2I5cmhGbzJqdVVBMVdiRk5GYUVDUVQwYk8r?=
 =?utf-8?B?aHB6OVpXQXROQWlWSnpRaUVCSEtCdnBzdUpIRmxrTnFkTDMrY28xc1RYTE41?=
 =?utf-8?B?TVZIVHJiTzVmcERoNkF5aE5ZbC84dUtPdzlxVzl6TmpmemhnaS9FZjVISDR1?=
 =?utf-8?B?cUVvV1JPMUd3NFJGUUtZV3Fock5VeVJRWTJQcG8zVVM2dmd4VEV5SXMramx6?=
 =?utf-8?B?R0xTeEFnVXViNXNSbDQzdjF6RmNXcmJzUjkzRDk1MFM1SEY4K1VNQzlsNHV1?=
 =?utf-8?B?ZXgwb3lPU0svWVB0bmZrcXRQd2xqbzJjWU1waEVHVHV6bDJoenpBdnQ4emtk?=
 =?utf-8?B?bW5qalplTFovUGFEQWM5SXdaOXNqUEhkRjlkUWwra1FIeUJiNGNRUU0vVE1a?=
 =?utf-8?B?ekJWbU5HUDBjcGhHcHRJajVNeGplSjVEWUwzV1BTUmpjUmh2bElLZDNSSDVS?=
 =?utf-8?B?SzhvbTNTRjErcGxPSEgvb2FwQzN1cnBSdmM0RDdKbmJOMlpKRnpoK2ExWG5Q?=
 =?utf-8?B?NkY0Q0tHRXZkOGM1LzhWRGRhRjNnLzRyZFVtdDZLTThEZUxZR2k1ZkVKUmcw?=
 =?utf-8?B?VjJDSktXNmpHWkJ2aTMvTUxUNWpJQkpzMFNJWkZmVjdQZXpnbDdPZnpTMytS?=
 =?utf-8?B?TmQzUlZJYmdqZFFsbXBqbVFjeHpGcTNoYXo0aldJZGF1Y3lVRldvS3VvQ0pJ?=
 =?utf-8?B?NjZoYXphNldNTEZaNVRvRXp4a3JHOVFjOXlVWmNraGJDTW9GZTFKVFRRMUs4?=
 =?utf-8?B?S25LU0l4RzhmMXBZeDBjclNtKzdEOEFJWmtEL3FDQ0o1T1k0MHptR2E2Q1Zk?=
 =?utf-8?B?blF3RnJUeXd3cGpoWmpYYWpsYmxNbFZJckpGL2RhWkhKWW51RzJwdGlDbk5U?=
 =?utf-8?B?UEVGRVpGYW5CNktBZ0ovNDQ5blpSZW13cmNVWFRwNGk2c0hKYW1MZlgyUGdJ?=
 =?utf-8?B?cWNSV2I2Qm5FSTlUbDl1eG11VUVPaXVreHRScVUzTWFHaTM4RXdTdEliYi9O?=
 =?utf-8?B?UXVSYXJuYWFMMlBsUDNWRURNYlMxM3JQN3VmQnVUbjdoRFVFZ2k0OU5yMXdN?=
 =?utf-8?B?dnBPdWtUcXBEN2RBUS9yMUMwQ25hNkJPTzRCWWJCS05iV3AyUEVLL3NZSnAr?=
 =?utf-8?B?TDFiMUMzcDFoVlQwWXYxMHA2ZEdDa3VBQitEQVkvZmx2Y1BJUGZaRXE1NFBj?=
 =?utf-8?B?cWpkV3dqd25MbExCbzRhZS9kVFkvd25FRy9Ob29RUnZXWkhwNmM3dlJ6TW1X?=
 =?utf-8?B?ODAyUStHb2JFWHRZUGtUbXlyd0hNUWVrTUhqclBRMjNuanlyVmVQQlNsdXJo?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd5f246-5551-44b5-17ce-08dd7b514bee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:38:45.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEgy+2KNISqJAcWOCd499PBJR1h6q7FM2P/zjqP6EuZEMUDoPlh8+xWGkG+MqPdQSHpt1GXklbqRYZ/WHlDxj8c4XP99432PTDh7o0si9OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
X-OriginatorOrg: intel.com



On 4/14/2025 3:18 PM, Marek Marczykowski-Górecki wrote:
> Hi,
> 
> After updating to 6.14.2, the ethernet adapter is almost unusable, I get
> over 30% packet loss.
> Bisect says it's this commit:
> 
>      commit 85f6414167da39e0da30bf370f1ecda5a58c6f7b
>      Author: Vitaly Lifshits <vitaly.lifshits@intel.com>
>      Date:   Thu Mar 13 16:05:56 2025 +0200
> 
>          e1000e: change k1 configuration on MTP and later platforms
> 
> My system is Novacustom V540TU laptop with Intel Core Ultra 5 125H. And
> the e1000e driver is running in a Xen HVM (with PCI passthrough).
> Interestingly, I have also another one with Intel Core Ultra 7 155H
> where the issue does not happen. I don't see what is different about
> network adapter there, they look identical on lspci (but there are
> differences about other devices)...
> 
> I see the commit above was already backported to other stable branches
> too...
> 
> #regzbot introduced: 85f6414167da39e0da30bf370f1ecda5a58c6f7b
> 

Thank you for this report.

Do you see the high packet loss without the virtualization?
Can you please share the lspci output?
Does your switch/link partner support flow control? if it is 
configurable can you try to enable it?
Do you see any errors in dmesg related to the e1000e driver?

