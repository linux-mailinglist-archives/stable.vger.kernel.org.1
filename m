Return-Path: <stable+bounces-224720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEzHMkqasWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:37:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78270267747
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669E830A3057
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5EC36402A;
	Wed, 11 Mar 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7jPfYHt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB931F99A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246846; cv=fail; b=PUNlfRVkjmJA0yzEQOVMUll6VPPUx+Be2d1sDaz5442+y1sWxrTqJ33WX850bUgQFx7eYj4EiV9yxYiO/oNguwtu6NegBbVduU9mGYqfQ5IAmeQX5qH1L71g9z/t31whVa5TcXkYgUtrh/Oo55k+2DrvcaprqiJAlR9JwxZnrwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246846; c=relaxed/simple;
	bh=ohXkBE+Ik/W4veNmxGDf1l8/h1bFGzEG4RzC4KSs1ng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZheX9W4bE2pKMl6I91EmlPKggIjMAoEN/bOrdKi/Wz0tZ5h9JIK4z7Rs22TV37D33K0OdHaGXM3M882cGC1eVXvK6rPAFTatpPQnjxSLoDwp50G1u5S2akeQ1IKc3XUIpWD3XyCJBkYG0HmG8gnIL800vb8CGKJ+Wr1UdLOccs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7jPfYHt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773246845; x=1804782845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ohXkBE+Ik/W4veNmxGDf1l8/h1bFGzEG4RzC4KSs1ng=;
  b=k7jPfYHtlc5RV79lHQ1CF8/WatKwaBeQfrAPAARNyi9VdbpaWQkQMvb3
   Pdic6JsPd82cZGM113v3wL1QipxoxY5JV8GbrrgQRgRw0zdTNQm0fRfrT
   sJslGgNG9VFH6M36WABbVEe6U7KOg9XVIulNnLS3lbE1HcPCTV/EUmy1n
   9eKZIdw3sIL0bZbDDDSPR2clNix5Pi/Zb529tKDE2+RYhM2ghT0laE3ag
   QvigUCwrj4JQ59UM5ATaTjV8SI24Spu7Q7Z55GQSQOe+aG1ZEEUG02YXy
   i/vT33nOoi9/QKqKPUtIqYWpTNiHnaIU0K3W33XFGdQcNPbLxrNAthvNc
   w==;
X-CSE-ConnectionGUID: X90fbBgUQ+eqERCw4NyAgg==
X-CSE-MsgGUID: 7cfgjz86QPOTvZe82nxwfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74292470"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74292470"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:34:03 -0700
X-CSE-ConnectionGUID: MYl2d2usTBiwJgNmR9DaBw==
X-CSE-MsgGUID: UP65KZXpSXKwsbVOMXFCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225226175"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:34:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:34:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 09:34:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+ar33yH7A8NbVfk+ePCOyqIVTjVFHPhtcrMDQT33z1Fhh26LARsCbsKzX8capZMjBc4p/bSr/D6SliDFsKz/YYAkYmFcc3Ih1PH65n3lSws1lizY31ssMhNHz+o6CIgjvb+js5oR8wTPaT1zUzUdV9sq7aGul6MBeuc9uSIfJmSdigFUujV4tplfrTiyF5p38sRapamLeRxgEblKfBnNlk7LWoFAEyo6yISz1Xuo60ulQogBbnnyjn9SWYy+B3XIsLu0CB9zQhyvdBlkoLzC9DRxMW0HOVznfV5WqBqp2hLg/hFfzWJgLiVQOqTYUwmB9dhBFytbZAcutJWf9GuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL0x0ITvPlBqJIep1bD44CnSBsLqw8qukP1k0ClnDAI=;
 b=bvPcTXtFFc1nQkkI5sxsYV+G0/I4CYieH85Ba7KJeY2UQiuMCrq9G8LlOf7v3W3kFs0UCDfggk43k47FPkgFm0BIvtwjy3V6BIezUTCZrG2BEIk4o1OxM488EBY085IHnjuEoEOVfYqARsfYmSkDPTtIzhS08VO83VOppHCWatvcuEfP2y+WYe5xEENrrom53MJxPbN51itdYbpSi9JSXYNwjzeHKgJY7PtgZ+0a0hzZvR82lOEsZ7wYUuV+stFdkj3iu33mSOPKtV1w691BOP8qj9/tTfR95cyVUlnIQ19Xfdwl0xA53T1TI+lec92BXbm2m5B5Rg2LxfI6ywH23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 16:33:57 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:33:57 +0000
Message-ID: <e9979dfc-eaab-413e-963f-a50985018e18@intel.com>
Date: Wed, 11 Mar 2026 12:33:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] drm/xe: Trigger queue cleanup if not in wedged
 mode 2
To: <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
 <20260310225039.1320161-4-zhanjun.dong@intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <20260310225039.1320161-4-zhanjun.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2debc372-04a4-4671-f494-08de7f8bfdfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ydWcC0qaowMxhNGACjcevaPzy1dQM79xQ2j+lOk4A4+iBiLVNpy9/xXn4gMRWozTM89hITy/VKGML4gUBWe63kO/+GD0hLGybcRPYvkT6J0QKECI25evFpI/ssPU9H9QxbEAho8kAjGWlvN40AObwOKeeWAI3JXVAUgYGfXUPFRUv7XD0nxWnNNzea9IRbmWuhCAsJMSb8+ibNcXM0xd1b2G3xUMK73x94eO+NSoicvM8fJHE7kueG99k1+MKSdj8ewgVIiaDI5NBIUocAGSaeFxHUpVotQGHKGa+T5uus9NAXtzqbScdwNLQQPJ6UxBqnI0h3AfALSE4HTjfyBHNw1xR+HgNHnxnOC6QbS9xCKzpAAws39t9mXQU3QqKnEyuO6gem3os1xNPSG6KWhUsljtUNz2PAHGl0+JpH8vOT0HPDcO2E5/huRVs4NeYpIKNpQ6YGh3uJLL7P0bQ8YnWJMHl/8IkQHGFtdfR4sJ0Jdz4Bhn86YqxzVvGuFwlbe0bIf27v/zTsuwRp4Jq4SvHzk83cUqCW/1InG8aKp9/387/h9CNhuTkAbUiogoLYSg1pjKiuhETrn6d2FWwgWc30QiLxkQXJtiWiV+EH49BiRHAiI/RbJNpE2V55fqNlZ5jXcZSL2sgk4c5m48CGq9gkhXZ0SimOyW48liO02cJKBdL09FzsRq40CHjQlZWrbiY6rKu4TNWNpyuc4ZkL1C3QLrTXTbyUIE4JSB/AFu6wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktYZHBoNG5NMkhsT3FiTWdYdXpndllIMDRheURpTkdGY1FpcWsxOUJXTXJp?=
 =?utf-8?B?Q0tJVTZ5bC9Cb3pwdkJrY21nV2JxWlZRU2tCMVpLMjNEOFltNjFDLzVhK0Ni?=
 =?utf-8?B?MDAvRWI3M3AzS3M0RmxWR0NjdDJxR0U5QjhNclkranNqYXdJMVNBK0hxMGhT?=
 =?utf-8?B?Y08wMkxTNDRveVlqVTd3bHc5Wmk4VmdOVmVRdVpVMTJscldvT2ZXcjVQU3Bu?=
 =?utf-8?B?YWVJVDNXckRla3VabnE1aXlwZDBLODZNT0lHNlZsWXdpbWIycXJpM1Rod1F1?=
 =?utf-8?B?K1d2TU04WWoxNjVMd3JCLzZITEVzNnY3SzB0RHh3cElwbENJOTIrQ2lSWWJV?=
 =?utf-8?B?YktHdkJCQzZKT1RQQ090cGxuNUZOejhRdlVOWTJqeituUEUwVTdCTlBlT21w?=
 =?utf-8?B?TjU1TUlLUkNwQ0t6bFdHVCt3d0hMUXNPNGRUOVRuZ2pEbmhoVHRUTE42dXph?=
 =?utf-8?B?a250VGV6aExtTmoxUE1Rdm00TFBUakN0OUxzNnd4bUFSVDlkanJmU25NQnZD?=
 =?utf-8?B?b2thT1VaOWJrZjFYTjI0eFJtQ3RNRW9IQXN6a0JKV2RneDVSMWhtcVVZYlRS?=
 =?utf-8?B?blNmY2U2a1FhOXJOalZnckhCVmcvSVFsZkZUTGNIdk1vcGxDM3BWYW56M2pj?=
 =?utf-8?B?SW9wVk1jcWNhelRUQnMzOWR0cHVGZ0xOT2hwV3AzdlZ0T3JaMVJtT0tObDdm?=
 =?utf-8?B?QWlaZ3dTK0h5dXZReUY5TG5VV0FHNTlRQVBpY1k0UGxESHgzR0JiYlFFUGNW?=
 =?utf-8?B?Q3hGV2ljbDJXa05BS3B4NURwV0RXUU9BY2J1WVJvdlFLK3dBdmdycXQzRk1s?=
 =?utf-8?B?Qm1iV2U5SEVsQ0Z1YlpHNDdsTmZCRUxqNDA2c0lRV0JlTEFvOWlYNzQxUVBE?=
 =?utf-8?B?K0UzbnF5b2Q2OEN2UEQydXI1NURrWGllOXNWRlk0WS9rOUVSQzducWQ0eS83?=
 =?utf-8?B?eE5tcGFnajlwQmlFSlJpT2dQZ1U3RFg4aUVuMWU0SFZSTWdCMmhxSzVUdFpF?=
 =?utf-8?B?dFdzSTFMQTdGbnRoRFM2b2RZdVJtT0k1Ym9LNXFaaElmdUo1RzVEaWwxY1o4?=
 =?utf-8?B?TmZYK0xqN04wWnhzbHoyaCtUOWRVZUJ0S3pIUmdqNyt1L0QxWmVCVklGUlpk?=
 =?utf-8?B?MGRWNWJxMDIxSjNoWERnSHdtdjdrMXZqSGRkZDRicXB5cGlHNEYwL21JVVNj?=
 =?utf-8?B?OXdsbTdGbWpObW1zM1ZXaGJ3ZldOVllYTlVkY2tyMWFpLzlMZ0Z2eFhmRkxB?=
 =?utf-8?B?VTB2KytqNmNMM3BSNHJGMDNRK1lTbi9IM0tOdXZMc0grZG5hUVA4WHI1ckd1?=
 =?utf-8?B?YXZMaWhEUllYQk5lRXFoNk1TbTVFRzJYa3dwNytNK0FIYTc0U3EydG53UFBv?=
 =?utf-8?B?M0pwK013TC96MytXelQ0VE1PSTBhU2RFWWZQZCtMVHc1RmhuSHdDeUFNalZl?=
 =?utf-8?B?Z1dUdm0vdUhLK3Y2TFMwR2ZweDd3Y2djYlliNjd2UVpMS2dwWDErb1pzaEdD?=
 =?utf-8?B?N0R5L0YwRVpRUDZiVktZZHRPVXB4Y3hjR2h5VUhTWE1UdUkzMFJTSzZud3g0?=
 =?utf-8?B?M3NIWGpOVUs0MmZ2K3d0cncyMEZQTXp4Qnc2bGQ0d1N4RGxsS1U3M3gydExP?=
 =?utf-8?B?UCtmWUgxMDFGZmRFa0VQK1gzekJ6NVpOeXMxTDVzTTd3cDMvZ3IxWk9Ndi9r?=
 =?utf-8?B?ZTg5MmU0NGRJWWxDdWRiNlJPbDJJSUlDRk1YOHM0ZGpUbnYrLzhhZHJvYUVK?=
 =?utf-8?B?UVFJbElqcHpOSWdaMnFndHo0eUx3ZG1NYnBpT1NBNStJbGdZTDFEL3NsVjV2?=
 =?utf-8?B?dXpKcTg0c2EwdlJTSkh3cDcvbkp5UTlzMVhkblhSMXJtZWU1S0JSaUxsY3kr?=
 =?utf-8?B?dXN3dVM5UHZlU0JlT0dDbWw4VDJIUUQ3cUQ4bDg3WkRnajYyTjdXMnFLVlor?=
 =?utf-8?B?d3hLUlFOSkwxNTlsMHE1L0lUSXVndVREbHhrL3ozRnBXUHcyRi9YSDZjcHV2?=
 =?utf-8?B?VzduSllFSys2bTZOSXJmNjRQR3FBVHNQaHhiTGtOY3B0bUE0TlQzZnZOOXRo?=
 =?utf-8?B?VnUzUEdZUFh0MXNuTmY4c2hsYkkvb1JucmZXUzgrYVRlZlE5Y2RHenI1MWpi?=
 =?utf-8?B?SGJZREYzVVduazQyek1EWmpyaU5TbGpEekJUSVNhbGRLSlVyQjY5SkFUTG45?=
 =?utf-8?B?TysxUUtYQ2ovaUV2Y2k4VXBjb05UTUVDZFV2VkhZZ2dmV09MSTYrL1hkSmw4?=
 =?utf-8?B?dzh2LzhvL3E1UEtOWURpcjZ4SGFVRVRlbTlVdDRFZFVOL0kwelhwVUpGMVUy?=
 =?utf-8?B?Q05DYStPOXNnVmRFdEdPK1lkeVQ2cEJFUTh6UUtXYzMvUnJnVElOUlBCU3VT?=
 =?utf-8?Q?5cF3xORh4FiMJsrs=3D?=
X-Exchange-RoutingPolicyChecked: G2okRrzFp2Xqw0jlC0eoF3M5QNg8l4AjBJXZ+CaIBxXQ99nZbTOjm4K59UFC3T0msJw+NNkNhTygMipizvbFviTgxpy79Tpuxuz7BPPtzVeKplPJjAHSd+h24tZ7adwp69gHOT9IQ3a+1vmU8VUUTwliuC55TglISx/gKcih0nVdvyi631iw4+znfBKdFAe+NZqVrgOss1N4z+8pa0VVo8ZWVF/mY9rPx6cMM2sIY0VvDwCT7kpAdiPd9UdxL+L/F5RxY5S+HwUQoeqcRJiddRxnSCFt+j8OG1IbcDWrGgAi8hO3Aju60ObHGTRSeQth+YfVuFMSLaxci3KZbMNmpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2debc372-04a4-4671-f494-08de7f8bfdfc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:33:57.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJkttYPiOf7800OBbV0E/mPBU8sgeHsND2ifM7voPvd4cYUv1/h+YZ7lrHykUmv2zzmydpbnp8wVhnZo/pB3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224720-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 78270267747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-03-10 6:50 p.m., Zhanjun Dong wrote:
> The intent of wedging a device is to allow queues to continue running
> only in wedged mode 2. In other modes, queues should initiate cleanup
> and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
> clean up queues when wedge mode != 2.
> 
> Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc_submit.c | 35 +++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 8afd424b27fb..cb32053d57ec 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1319,6 +1319,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
>    */
>   void xe_guc_submit_wedge(struct xe_guc *guc)
>   {
> +	struct xe_device *xe = guc_to_xe(guc);
>   	struct xe_gt *gt = guc_to_gt(guc);
>   	struct xe_exec_queue *q;
>   	unsigned long index;
> @@ -1333,20 +1334,28 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
>   	if (!guc->submission_state.initialized)
>   		return;
>   
> -	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> -				       guc_submit_wedged_fini, guc);
> -	if (err) {
> -		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
> -			  "Although device is wedged.\n",
> -			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
> -		return;
> -	}
> +	if (xe->wedged.mode == 2) {
> +		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> +					       guc_submit_wedged_fini, guc);
> +		if (err) {
> +			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
> +				  "Although device is wedged.\n");
> +			return;
> +		}
>   
> -	mutex_lock(&guc->submission_state.lock);
> -	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> -		if (xe_exec_queue_get_unless_zero(q))
> -			set_exec_queue_wedged(q);
> -	mutex_unlock(&guc->submission_state.lock);
> +		mutex_lock(&guc->submission_state.lock);
> +		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> +			if (xe_exec_queue_get_unless_zero(q))
> +				set_exec_queue_wedged(q);
> +		mutex_unlock(&guc->submission_state.lock);
> +	} else {
> +		/* Forcefully kill any remaining exec queues, signal fences */
Q: Shall we do VF bypass here?

Regards,
Zhanjun Dong
> +		guc_submit_reset_prepare(guc);
> +		xe_guc_submit_stop(guc);
> +		xe_guc_softreset(guc);
> +		xe_uc_fw_sanitize(&guc->fw);
> +		xe_guc_submit_pause_abort(guc);
> +	}
>   }
>   
>   static bool guc_submit_hint_wedged(struct xe_guc *guc)


