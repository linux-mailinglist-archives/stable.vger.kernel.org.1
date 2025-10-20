Return-Path: <stable+bounces-188155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC723BF2315
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A7364F73F0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3672737F8;
	Mon, 20 Oct 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL2WKUJj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AE2472A8;
	Mon, 20 Oct 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975156; cv=fail; b=j6Ml2w6ZY4Uj6HzG2wcqXZvteRXjzivN2T80s1i5TCiBX7e9liwnOLJMuhLsVFNLsVV1miYAYpTMJzK2ZdZHMNoy9Lj0K5FbBZhDaC6Nv1kLogQnihvNrAekwkWoTPnvuSkgcuHpFIiCGTaKQTeJ+kNmHLSMQBVb6rGFK4oykMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975156; c=relaxed/simple;
	bh=x3Sy4ri3NKKRIeHg6KpGls9AuZQij0YFmhzFxbj3Fig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uHoncNmvOHW1vQGH99T3vrqoJXxfSib2gjaWQGMrZLV8D4ma4It99gvklTlnI7iUwC6rb/3RbOFrCSNEuQLcEBwlRsjVi0aLSKbWXCVxoOWZIEi1W4cigJI7Wqv81m5ZVGQwNY77BRqWI0jLkaL6F5a+aL40l0wxXtRPkNEMOq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL2WKUJj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760975155; x=1792511155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3Sy4ri3NKKRIeHg6KpGls9AuZQij0YFmhzFxbj3Fig=;
  b=bL2WKUJjGO/EzDoSpGZn+MobPKC96Jf5zCHyghvwaWzBhtsqcmaQg5UX
   Bi6LpOOpQGs1pjyLfhn5GWi6Rq8cxcmNKiC391WFbLlTI8/TRjNy3GCnH
   oCZEuCNuTEG3lpMOTF6BXga+A0fDhMW/ROYJ3LbdPN9s1BD4wCj3c5hov
   zCEkPSUhlVP308UPCI0QKicZ6HQLtiFJ8heIQPOtbS/+PKkFw2V0pakJ4
   qo6mTNbfxvqqyEwiRaL/PI8Ul2fpZRpHODZYBV9/jwnR0mzvtX/Y4WV/W
   3AjP+YEUdL8B9eCKKOFtI8U+NRd775ggkjCvZxQsc3kl2W2D6F5BlARu+
   g==;
X-CSE-ConnectionGUID: pr2HQlrOQXOwTyB2MXTgwQ==
X-CSE-MsgGUID: TGmPy+ewTbGG+IY907e/iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88559422"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="88559422"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:45:54 -0700
X-CSE-ConnectionGUID: aDJGDgdqT4OBP/B487Ajyw==
X-CSE-MsgGUID: 3HK/tbomQm6uFo7nBCCthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="207039019"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:45:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:45:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 08:45:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7T79tFljOQexZjyFnqU3UfjqlwWKCOxtXjYW0wmDAeiqFMeB2i67cqRMqvJzlTtAldqTEJlQSdtLq/wLJZ9LUhZbasYazJvB+r4x9YoO4Ax7pgXNeCJnKODfjeafDxbB03gj8uYwV5mYnlA/lQDi8wZShMxvBrTd/SUjr+p250k9+lwiS9YoKKlmWLqQ7jhYS/TPXvLpsZF8pGjhhQsl0rzlQ2TgDJwEtS1dXtzjbTxDnCg0p8jglU70+sZWgGZ0RnaBjCV2PDSimsC/JXEW/j12Tvm8ZSx7U6bheJ+0JJhw5XNglHZSd5NWBz8CO2jSc5GUfrsxXT4gLcxO2YG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TAHsnZo5LQNK3nCNcG/hfEx7bJWtMjIGpHkJsU2hZg=;
 b=LBhQsJ9JdvoTQD083farF3ApeKbw4lY2s/IkWF81+35eGQa5TLdZywC0Ughwj51a12DkP6GDAJJs0gkQ/Mtm/9jHgZLxgcZDvtmw56v6bJuYo9TkJN83TP6WJNSEUHJ6iCqD+J7kvBzfZmXamF8/BrxCAZpVvwVhukYWvM9bS7/cHKXyAxGb8GfD5MQlZ1agdpcEGUs1+VW20VBR80ORFPC0RjD39PX2q7hvKEornAbeFmWTutM/wanIN6M1e1t4W8O6aS69u21WqPX59Wfu9h0Zl7pMTHOveveiBjUZot3Taz/9MbkWez0HEIrcfGTlGk+irJAUPIzqnCTIvRZHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:45:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:45:47 +0000
Message-ID: <7cf5475d-b257-4595-b306-53952c8a63b7@intel.com>
Date: Mon, 20 Oct 2025 17:45:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
To: Bo Sun <bo@mboxify.com>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
	<lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
	<hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20251020143112.357819-1-bo@mboxify.com>
 <20251020143112.357819-2-bo@mboxify.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251020143112.357819-2-bo@mboxify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ba7c43-552f-416d-969e-08de0fefbc72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktFcCtNdEN0OVp4aVd0RllkZFZ6STJocm15eWFVMTFMWEhFNHRKVkJNdTdD?=
 =?utf-8?B?L01iQ3ZJOEY4MkxvejV2ZnRXdGhCZFJsdzlZbTJyNG8xUzdJYVRVM3VuckVs?=
 =?utf-8?B?a2tmbFE0aUlJQnBxL1hTRm9nb2E2bDZUMG1HajlCczdRL0JuZGtWL0ZYcU8x?=
 =?utf-8?B?TEVnZUxSemtRMzdKUGVvS3VUWlpyNU9Xdkh5STJRL2J0QmFkeG1VOUV3N2JJ?=
 =?utf-8?B?VXcwOHBIMVBkaWxCb0F1eCtzRlpIMDZZQVNTWExFb0VZVTQxODh4K1drenFZ?=
 =?utf-8?B?MS9BOG1WWWRvTFVGb1czY0xvdW5nSGFkbW5heFc2WTI5K1IveHRpVXRMMmRM?=
 =?utf-8?B?eVhLYitqRTZSdkRrSTQ0VHVhTjRxdmV3RGxhS1N4dTQxOUFibVN3NkVIamZN?=
 =?utf-8?B?SXJaL0F3ZGxVajdYUFI1L1k5Q3VxTmdGN2xJWjhJTVBrNXdKSk0wYXU1c2Zx?=
 =?utf-8?B?VDFrS1F6WGlub1RZbkFxYlNCOGQrU05jTGV2TFVERWluelBVQzNVcUJER0ZU?=
 =?utf-8?B?OFVIeUp0a0pOam5XeSs1UjBRaWJHSFB1cDRNV2c2K2Q2N3hIeXU0R0YxNGlO?=
 =?utf-8?B?OHd0MEd2bHoyY3JDa1NSMjA0ZUtJblFPaHVac3l5cU84Y2dFNlNVTUliNjVu?=
 =?utf-8?B?Q0g0ckc4Wnlramp2UXBTaFFoNWlSbzhVNW1wU1ByYURrMThPa1ZTcjdYRnNx?=
 =?utf-8?B?TXJRTUtBMVJEbys4VkVrZyt4UG5JM3RVazlQS21taXFOU29sRGZpUDdTdjMz?=
 =?utf-8?B?UVJtVDdNN2FjMCtDTFJDZXpsNnJXWndITWNka2FsRXBKOFk1WHVUZm1palBp?=
 =?utf-8?B?bk85Z054aWQxWUtjWnNsM3VsWVdTdGRYSG43U3BmMmlxdk5RNUdWZlluc29H?=
 =?utf-8?B?eVRnY28yekhiYktIZ3VocHFuQWVzdWNWdEhQL21EbTAvYjZwb013cTBpTHdy?=
 =?utf-8?B?aUNBa2xXUTY5WjZzUGl6Kzd3OWo2OE9lVXI4U0hEbHd6bmROWDlKYTdTSGE0?=
 =?utf-8?B?cW92djZ6UVZSMDdPdWNVQ28wMXFIZksvNUYzTUFHT3ZUdCtDbktWVnVESXlF?=
 =?utf-8?B?TkdhRFFYaTRRYUYzeSs2M1d6OUpJQ2hFaXA2SmtIV2RjcnJiSVArb2Q0NlI2?=
 =?utf-8?B?b2NyRGtVYzRjRlhFb2kzb1pBb2xQTSttcngzclJPam9LNTFmNnl3Ty9tOVJY?=
 =?utf-8?B?c2pWUVVrRkhHVkFiMVBoM25IVGZ1VW9QWksvcEk4WU53dGNXZUp3bklyaUR6?=
 =?utf-8?B?eVlJejFVa2J0bWg3VFRtaWhYTUl3dG5xaFhUVmZXVFRHZnJMMWV2RXJVZ0tT?=
 =?utf-8?B?NGM3Y2JsNkNJd0dPM2ltSTVGNGVjRTAreTUrdEtka1BHMWpoUlBCQm5KQ3RR?=
 =?utf-8?B?NXdNWXEwQkdiYXpmeFUzMDZVb281M292TStrQUFiNzFHVFNqalhPeW1UZWY1?=
 =?utf-8?B?QTdPVlhpbUJVTTMxZVBBUXhxK244Z09zSy9Ha2NmaGNkbm5vR0Vyb0hTQ0pu?=
 =?utf-8?B?Q044elFJTlE3dVZkYmVPK3ptTmhrcUk0TFpMaTVUSTF3QzZpbHMrZmVzZHkr?=
 =?utf-8?B?RUtJWE5jUDlUYXY4ZnNWMTVyajBFcjNQSHpDOUc0WVZoamw5c05wbG0zKzNh?=
 =?utf-8?B?NlFmNERqVmJjSlBwR0dtUTk1RWRkSTBNcStSQU1jUEZUWUg0MHdTTDUzcndy?=
 =?utf-8?B?TnRJYUJnK1ZVZ3Zncno3ZFJuVlhXSHQ5WmpmZlJuZEVnT1kyVC9ZNTY2c0Jo?=
 =?utf-8?B?QzJ3SWxBd1RldnFzVG9CS0M3cXVkRjlYVWZPSkRWQ01SaStFdkJ0cWZHSkFl?=
 =?utf-8?B?UGRhTStWaS9mN3ZxY2t4YzU0cmpEZWJERkhvcGRHYmxDQUV2Yk9SLy9tai9Z?=
 =?utf-8?B?YVhCa3NYVlhhS3h2WXQ3ZnBhUTJ4UmpvMWR5dGtjRlBtZmlEelVTUGtabGlR?=
 =?utf-8?Q?IIduadq+VhUoyFf1CYPaLqEtQv3yjwOa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJVL1h6b0gvT1ppS3U1RWxLWEFCcmttRmkxUHI0ZkJOa1U1Mk50bmlXSy9u?=
 =?utf-8?B?TGtwcE5RMnpNY0psaHZteVZMUDVUODFoM3VhYyt4WHZJT2lZeEJSNzdXZ3h3?=
 =?utf-8?B?ZGdvemFVQ1g3a2p3N3MrQStDd2VCZmZVNFF1eHlBaEtkVUtmb3dhR3ljbFpX?=
 =?utf-8?B?YSs1a29ybnc5d2g2K2dsRGNLVkFEbWNaeE9MUWNLeVJDTDVwUWQ4czlmZHdK?=
 =?utf-8?B?M1g2b3lxZkdmaTRrVEtlWEFmaTQvUUhuMG5ZYjZPRENxM3dvV3pxRVhOL1FY?=
 =?utf-8?B?OUJFOWliWTRQQVVSUUZzcHl3Sld3bGFOaWREb0Q1dmFXTXdPRTJSLzBLbzdo?=
 =?utf-8?B?WHhkUnQwdHVDcS9JRXVFVHNEWTBSRS8wVUhwMUJ3NGk1QUprS1VTWUQzTnRZ?=
 =?utf-8?B?MEpFVFA2RVBINFhwa3NqVEVnYUZjOEFtVzMrV0V5RFFZVno0REJNK3d0eExo?=
 =?utf-8?B?NmpBZ1FES0FrcVRSMU1xWE52a01rY0I4SHhDWi9PL3RWcnlMU3BzdjI4VytE?=
 =?utf-8?B?VEpqSndaNlovbWxrcEcvaTNrNGJuWWE4NU5VZnZJUE52WWhEVnlBOEVlZ1dZ?=
 =?utf-8?B?TGlZUXRDZWdBVEtETTNQNFNscGJ3RDh0SEdrKzVDSllBNzk3YXh1cFNvWkhB?=
 =?utf-8?B?THFLME5VWCtURmdSS3UwN0I5ZTJQQS9abmRPTVhNQjVkWTlNVjJDS1QyVVJR?=
 =?utf-8?B?TDlXMk5pU2hnVi9RMGdVRlpPQ3Rkb1g1TXJpQUkySzBHbXExNnlDR2o0Yk5j?=
 =?utf-8?B?R0JqZ3lrS0ZtRFdPSThtOUlpazNjcG9XOFNDaVdyUlVIK2I1MmF5RHhpS2RX?=
 =?utf-8?B?OTRucWpSNkx6NmpKNklDYmY3VzZOeS8rZG90MzJISlJHL3k5ak53bWpUcmwx?=
 =?utf-8?B?THFTZlBteTNqOE1BV3Qvd2JzSkxKZTQ0T3lBUzhGT0pzUHlrUXhZZU43M0lU?=
 =?utf-8?B?dG05ZTE4QUcvSmVkcDR5TXNOS0Q0MFVUYWMrUEZseVN0c2J5bGFBaVQ3ajc3?=
 =?utf-8?B?bkMrTmFhbksybE04djJKenZwSXJFdTJhYW5WeGJ4K0xkeWpjblZiRXFFeFBt?=
 =?utf-8?B?bXd2K2tVcUZNSkdqd0Y2YlBTUVl1ZUF2dkYrME42cEIwOXArREhmMTlPVWJm?=
 =?utf-8?B?UExHcDNpSWRWU3kvVzVBc3NNTEtWWDFYOHdxa1lodUZwalovZEY4Qms2WFl3?=
 =?utf-8?B?OGlBTkJET0lkVnRHWHdER05KWTgxNm15UFM0WGgvUXd6RU9YdzhCdk5VQ3FK?=
 =?utf-8?B?SGQ5UVBZSGNYOWhNMEdNc3NJdVd1V3hlMWpTYm1EK3ZLbUMxR1FXVTBFdUZ1?=
 =?utf-8?B?cDMxUkMyelVQd0pXQmZ5QnJJeVpDaTIyWkl5ckthai8xS2RQbXBLSkpwaUtK?=
 =?utf-8?B?ODdtTjRjUWc5by9jbXU0VkRpTVdqcy9lWGE0UWZGNkREb2RlVkliWGh5TWVF?=
 =?utf-8?B?WkNjWnA4bldFNmVFNDg5eVNmbDNqZTBxM1ZmdE1TMWYwOG05SFF1N2dMZEVu?=
 =?utf-8?B?ZWVsN0kwTFh6LzUvNnU4V0dnM0hvN1dSZnI1V3h5eWI1UDhXM1dYbXpibnBW?=
 =?utf-8?B?TTZVNG5Jczd5ei9Lc3NDRFlqcDVHdG05Q3pMb2Uvak4zUVJqbm5jZE1yelRE?=
 =?utf-8?B?YmVsTHlaTFptenNjOVUwYmJpUkZLdW9LSWpPMG5qZzdZZ0RNbFBuczdWWndS?=
 =?utf-8?B?MndidVkvZ1d3cWpUWHNEOVNsbEZXVWpxbFdpV213TE1CbVF0ZUlZcWZLUzIx?=
 =?utf-8?B?eHc4ZTJaZVNxeDFDS1pVNGhzNWRoeEFVb2t6RGhxd1o5RTl5cWlDSTZxcHFV?=
 =?utf-8?B?Vysza1QzTWNJSVNKaGtOU0Y2Nm51dFJPRUpTa2NYdFR2bkdPZ2R4Ty95TWtS?=
 =?utf-8?B?bFRkdXVIR2MwaFFVbnJvbm1HZEhDVW5MR2hyZDN5NXR3a0VJbE83QzRSS0N1?=
 =?utf-8?B?ZlYyL29ZZURaK2pWN01saEV4ZGVTRnhudDJqelh2SXk2MkNsQzRTcGgvajVl?=
 =?utf-8?B?bTl0YTczVVUxMW90RTgwSjZ4eWNBQnZHWkxnTU1FZkc0Q2lRVzBjTmpFVlVI?=
 =?utf-8?B?d0JGSHEzN3lKWlIxS04wWHZGVTZLMjZzU2Q0QUwycU9nV1VreVlBVlBWK1ZZ?=
 =?utf-8?B?MlI0YlpQRlBhSXBzbHZoR1pHM1lZZXUxa256NzlCTGkxNWJ0UWZUd2k1RkRZ?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ba7c43-552f-416d-969e-08de0fefbc72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:45:46.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKyW8bewkCtpbwhtgbrPMSdqUvIrhFpNetimmOf/90o4Z5vFnvumkwTYwaXNVBYq/1nFZAsV803tcfbVZ6oNNGDoioCGvYTjbVmHMg5ofro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-OriginatorOrg: intel.com

From: Bo Sun <bo@mboxify.com>
Date: Mon, 20 Oct 2025 22:31:12 +0800

> The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
> are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
> Unbinding and rebinding the driver therefore triggers kmemleak:
> 
>     unreferenced object (size 16):
>         backtrace:
>           rvu_alloc_bitmap
>           cgx_probe
> 
> Free both bitmaps during teardown.
> 
> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Sun <bo@mboxify.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index ec0e11c77cbf..f56e6782c4de 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
>  		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>  		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
>  		kfree(lmac->mac_to_index_bmap.bmap);
> +		kfree(lmac->rx_fc_pfvf_bmap.bmap);
> +		kfree(lmac->tx_fc_pfvf_bmap.bmap);
>  		kfree(lmac->name);
>  		kfree(lmac);
>  	}

Thanks,
Olek

