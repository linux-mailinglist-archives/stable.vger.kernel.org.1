Return-Path: <stable+bounces-88981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D39B2C28
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638392828F0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A04186E59;
	Mon, 28 Oct 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkL/Y3bW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A11CC88B
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109519; cv=fail; b=lSUrfDsFgPCA876Jg4no7xukeIAKQAex9oEGA/JpLYydiU36FYWO7NrhcMADQ0O5yIWBCgZ8QrCKFZIKCUwP2txZxxzMSajKaCHeQA9fXdi//x6ITTMPEZQds9VWPZs2ghZx8SEKG+KOXisbLc4vKoFuEs7PVonbqrz66CLMS0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109519; c=relaxed/simple;
	bh=JLMRTAmplu3NGXAURv8qTyNrMEFrFMfKxe8a/G57IFQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQb3izyNSEFZBPZBcgqUSGzzYVdp3BCw7YJNzbiH50NQVPqNNmPOHqY+9pn9WDGeSAibUNode90o/3JwTpPWNWicfELfC5zgBgiYWD8B4FqivHz+T6T3eKT0gW8BvQzmCVblvBKatJYc05nRDTbsNfM8ZqDQpuSSq5NaFNsYayM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkL/Y3bW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109518; x=1761645518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JLMRTAmplu3NGXAURv8qTyNrMEFrFMfKxe8a/G57IFQ=;
  b=OkL/Y3bW8/yEwx/sOzqqLhjSuaNXIXWmqbJaVhl4db3Egs2PDKOEGFa2
   dpLYjTjDSqWyoc1f4ff5a4/KsDFyAusuGVkNnmT6uMGNrJC2dA90W1YFh
   HsWB7spug9u00USKKxev4A7ZQNsG7rmxm99jv/5ttzP+nqZDRIa7GbNxH
   6QM7rJ2mhs3mdcAt703laPwLImkJrRy4Q4t0KQFWfr7LthKRhb1SAwn7d
   5Rx8JnVSI1l4MorB8uPzqRsLzmNWrMLoaaN4xi8Ifn1/u9b7I7FIzFAyH
   6k2/4aE2isupDtVuLkM8ZZC5/T2g28bGGgyAxGnqLrQKA02xxAo5YCgtx
   Q==;
X-CSE-ConnectionGUID: 3lnK/Y8+Q/etqyuxMu4uoA==
X-CSE-MsgGUID: dMCWFqodRMa5NTl0ItY63Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29473335"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29473335"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:58:37 -0700
X-CSE-ConnectionGUID: LxIfXu0hRmCBM2BpaHosnQ==
X-CSE-MsgGUID: ozs8CGvhTJSUKv+WQ427KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86707635"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 02:58:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 02:58:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 02:58:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 02:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzV2WKyL02Nm22EJdia0CgTj/2sX/YfiqeSV7vvX3paQEaWA5YTHFuU6KGccoihpPysB4YBaqp2GylK9tbgNBizr0LkjWasLRLLiUnqXl9p3QtFZupOQj2QtViOXGpb7YVXgUwFBJq+TetBhFIpA3jJ+UmOXrmX1cQ6cdmdkGq6qvFZvw+KNnuQAPfVfyhCR8iVguXhMY6Mv6SdWT8iN8G28eAtt2fvoPxPfeXpJ5fLwoK8XFjlZc7ktolXBFrJCrc6ggDta0+8AAZk6NnkYqVYKY+qnUyFG1u/oZUIcZbOqOpFg8qE9my+D/SyASDaUgq62z9oQ30rMDjk3blRcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLMRTAmplu3NGXAURv8qTyNrMEFrFMfKxe8a/G57IFQ=;
 b=I8YFxVVh5vhlDJo9raACgnqirHyrejINFV+kkH/UDzCfOmVbwPz2ptAwFRGw3bhAVej7HihaQsSW3lBqgJ9hWONvApSPMaeX4Xn8uGVkzwJBUqQaadxMvsJaQM1aYQZ06JbSanvAvegnUBpb2p357NLHguCJCkbY/TGnI43dS8lV2AU/gzBLmnIuihjHVp6CSU7LWfW9wpI6jACFIwQRlOe+oJ8xO2Ldqtyl7m4DZJWdtU5g4lGfY1b9yGANrz4JCqjiYjEMU1e5cztX+o5b5YXZ67HhvKIROtQycU5YE3sIAo4ORVMOKysxHpJVJMtumljNHnN8+ESkW75e4D3kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:58:31 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 09:58:31 +0000
Message-ID: <f63baa52-07c3-45e7-9367-19dac2a762f0@intel.com>
Date: Mon, 28 Oct 2024 10:58:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, John Harrison
	<john.c.harrison@intel.com>, Nirmoy Das <nirmoy.das@linux.intel.com>, "Jani
 Nikula" <jani.nikula@intel.com>, <intel-xe@lists.freedesktop.org>, "Badal
 Nilawar" <badal.nilawar@intel.com>, Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	<stable@vger.kernel.org>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
 <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
 <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
 <ZxvknjgW+3hQx6nM@DUT025-TGLU.fm.intel.com>
 <82debae5-4eea-4302-bb55-593c1791d3e6@intel.com>
 <vs2dhzwnddd3cmwan2t5lw67nbd6f7xc6hbv7syxpa7ptmkbp5@ejopbbo4npno>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <vs2dhzwnddd3cmwan2t5lw67nbd6f7xc6hbv7syxpa7ptmkbp5@ejopbbo4npno>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To DS0PR11MB6541.namprd11.prod.outlook.com
 (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d98f9f8-90d4-451a-8208-08dcf7371416
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N05ZdDY5N3RIRTE4YzgrQ2Z6M3V4UzJRc1lUY2VBVGRheVk4NWorODROaTR2?=
 =?utf-8?B?Q0MrQ0JteVJyUmgwR2RXRHdVbUhPaVdjQ0paZ3k3MXFReFMvOGFSM0Z2WTJT?=
 =?utf-8?B?UStTRDFaVDRBQmFHazY2N2F6aVBkRWowcXc3d0NCcFBoV0h3NU1Pd25MZC9B?=
 =?utf-8?B?YWs3dG9ZZ3Zkb2lTVlNmS2k4MEZwK0pQLy9MWCtFb0hvOE9DQXNXalFXajBx?=
 =?utf-8?B?aFpQNnY4b1RFT3gxd2VCeklNOFI5MzEvVnlqYllVQ0NseExHUUpGK0N0RWJR?=
 =?utf-8?B?M2EzSHhGUFB5K1B2b3FDdDQwNGFOenRnRU1pRU5OQ2NDd3dXeUlVOE81THg3?=
 =?utf-8?B?UU5adldmU1phRUVTbkdSSHFVK0h4K2JQS1d6eVJlZHJ5N3NzV1B6ZFk0aC9q?=
 =?utf-8?B?cHJITVBhSlpTMjRjY1N6ZE9rZk83R1VCTk9xYUpQYlNFUUNhMTB3WXJCL0hK?=
 =?utf-8?B?TTZQTEd3QmQvNm1KWHNsZndLMTJMMG4rcEpMbW52OWM3UXRxOWlJUkd0VXov?=
 =?utf-8?B?Z2JRTjZ6MDU0enZiNU04RTdRekdxNjh4SUxOVkNUNTMyYzJocVJhZUhjTjdz?=
 =?utf-8?B?NUhLamRTbEQrdmtvQzNxY2k5bEEwNDdHRnQrSlIvWGdjL2ZFZHhPa0xkSlEr?=
 =?utf-8?B?NEEyQzh5eCt2Ym0xb3ZxdnBYUnNjS3psMHg3VXRlb0xJYmtsNlZWcW44TlJZ?=
 =?utf-8?B?clBvNHYyM3NHNW5RcHVxT25aMlZ6T0RsZGhyYXpWR2NzS3diVkpaNDZhNS9h?=
 =?utf-8?B?bWhGUEszVDFPS3pZb0JJSjNSZkVDY25CQ0paK3BFMTZnSWFSYmRaRis4b0Vx?=
 =?utf-8?B?NGRWaDZjUEJIYkJKS01RanBhblNYbnNhTnQ2TXFTdVgrNnQxZkRzbit6Yy9F?=
 =?utf-8?B?VXBqWkJja29uaVY5QVdxMUV5alI3Uk54dWg3QVhRbDVHN3hEcjRSVG5vK2xk?=
 =?utf-8?B?R0R5Wk9ZRnIrTmo1M0JsUG1sZnp0TGNOeVVhUmpsbVVXdmZZUlk5eXk3SUxj?=
 =?utf-8?B?alphaWNsMzRPTHN4MjdOODI1TWVXYlVTUWpyY0tvTWxNZjg1SjVHQldJckM5?=
 =?utf-8?B?TWJuT29va2MzaFc3NXBjangvUlMraUxtNWNLN0FaQlNocXE2VkpxQU5KRDds?=
 =?utf-8?B?MVdWaHhGMEw3dmdvSUgwN0FuWElSc3JWV3JrUDl3a2pQR1daTTI1NjQ4MldL?=
 =?utf-8?B?amUyZ0MzOFJhK282Z1I1WUovaEhwOVAvKzFDZUFyeExxd3pLREYvRDVBL2NH?=
 =?utf-8?B?VzA3clVDZVZNMDBvRFh3ZlBNRitCQUY4dDJ5Q1gyNitPMjA2RWc0TUxUeDJZ?=
 =?utf-8?B?N0RzaTdlaHR5TTk2c1ZBaWxtK2d0NFAyWUd5anVUZzhZTGpKNlplSFVHbkRO?=
 =?utf-8?B?UWxvZmZVeUxFMmtBRk1JMHNGTkMvTThXN21seFlvV3hUeEQ4eXNKaUNUdnFV?=
 =?utf-8?B?U09JdU9ZdU9SeGFsYld4UFNCTDRqdWt2d2NWTVFMcXVtamwyMllwWGloSlBu?=
 =?utf-8?B?R3VGTjI4eHFSWG9obHVQRGVjZXZ0eHlyb1crZEZEbXNrRXE1aWZOV0JwSDFW?=
 =?utf-8?B?MFArRnVpa2hMOHRUUDZIMXU0VTRrdzB4dmpEVnpyQ1hneDk3emdyMFJJR0FF?=
 =?utf-8?B?UFJQNWh6dmpWL1UzbWtZOHc1dFNNaU1laGhoS0FYSDJoMVBrNTU0V0NrMmRs?=
 =?utf-8?Q?rL8pdJBUaPAV47FCnRJu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpIMFBIV1VZT09KS0N1eDRUZmhyQklzYjFFYk5lM3g1R29hR2xQdmtZWnpz?=
 =?utf-8?B?WW85NXlkQ0tvY1dqbzRLMUIrVm03VW0zN21OaWhpQU5ZMks1SG9PQldPSTl2?=
 =?utf-8?B?NDZDWFFhKzBJSkNGK0g0N0pzZ2dvVWZSQ2xWY1N3YVhGcDZHZVhUUDdQSzJm?=
 =?utf-8?B?WWJTTlJ1aVV4K0RNbW13aWtDN0J3VWhLcWJGckdnNGY4YW1NS2gwRW5OendV?=
 =?utf-8?B?d0plWmd6TWdlRjhkUzZBK3h2NDRJVExJSXpJZ0dPb0RUQmFWMjBQV1hqaTUx?=
 =?utf-8?B?OWJyR3RxUlhrSG4xZjRsM3FGQXlXZGtvZGovRHM5TnJPTFp4eDBtU3lwVWpF?=
 =?utf-8?B?eUVlRWMvSUtMVTc3UklIUXV2L0NrRXNNcEdvZFozRjNJZHJDbkRHMTNNTzlP?=
 =?utf-8?B?YnRNcTd3VnRORWplSDlIT0JFUDhGK2JwdW5wTzdBQ09MbnVIaTRhQ0FEY3JE?=
 =?utf-8?B?QzFGZEpoM3poR3RvSUlKajAxcWxmZTBtTkJ2S3R6SVEwYUh0aFdsandnaXZs?=
 =?utf-8?B?ZU5mR3VaL3UxTzJOQUNUdkk2Qit5a2NVRTZXVFJPb2dISlpQRDRIMWlFUzA2?=
 =?utf-8?B?azZjVWkxSlZwT2g0UFA5ZHljTHQzcVhjWXV4bGszMDdwdFVkUSswNHpvMXk0?=
 =?utf-8?B?emViSnZkYVlkQWJCY05wZnFpTjN5SXpsSHBuNGk2ZTFIZVFPZE5wenJZMkhO?=
 =?utf-8?B?ZU5TRS9nVWF6OGdGTkdrc2xqeHNvSGI2YVlrOG9aNnh6akI1TWFCeFBCTzFZ?=
 =?utf-8?B?OXova21QQ0ZSaHdNajBvTG9DaXoyUmdwMCswZXlSdGJkTUFzU1VsQjhJSklK?=
 =?utf-8?B?Rjg5dEVJZ1NPTm1ReWdia3RXL05uT2NablpoRitPTSt4OE1obWxMQWZsclho?=
 =?utf-8?B?UXMrclRJOXh3QURGc3lYNVhTZ1NIYnRFQjF5ZUxLUFhCZUttNWRmN0lwR2NW?=
 =?utf-8?B?ZXpwL0grQUJFeEJCMHhKTVNiakNTY3F6TUZzWmhHR0tRc0RLVHowYlg2cDJz?=
 =?utf-8?B?emgxNVhhbUtwZTRUMnFTM1FIcGtFcFhwYTlhelN6R0dVdjdvVVlCK3dYcjJJ?=
 =?utf-8?B?RU54bVp3eUVMbE1mWGxlbnFldjRVN2tsMFpONFNObENuandwdlhmVm85MmRO?=
 =?utf-8?B?TTk4Y1VDMmFoWW9rb1JaMUdxekIwb0V2VnJ4a2ZHNEFEdXE1ckVrMVovdmYv?=
 =?utf-8?B?Uk80UmRVbGdJTWlEZGJwRThZcnh4MmhhSk56bTFBcFBDTGMzazNuME53d2R2?=
 =?utf-8?B?WjR2S1FINlQ0eSttVHUzRFBLUy9xZTBOUHovS0dJRC9wbnhhNnNmZ3hPczhC?=
 =?utf-8?B?MXdvMG5UeENyS0Ezc3JIdHljdi93UUErLzNDeVBXQ0JIR2xuZTJmOHZxNHVk?=
 =?utf-8?B?WnoxNGc1aFZMSE9nSTRhSUtQQllOenZwQ3pKR3pmTUVlWnVqNEd5bmdGRmdm?=
 =?utf-8?B?aEMwcVdpNjhHT3Mwc2F0K0xFREdPMGEyWndhekhaZkJOQWN2R1VVbXlUK3NW?=
 =?utf-8?B?U2FPYi9QMmtDQTRSZ0dkTVh1T1RoaksxMU5VTkN0cENDeXUzSTdvVGhTS2pM?=
 =?utf-8?B?eUU5L3BEUldsSFk2QlBrZUdoQWNEallCY1pla00yR0svalF0dVg0KzA0cHI1?=
 =?utf-8?B?OExaN2ZkQ21BRHkvNEtYcmduR3VRSDBqZlZDWlJ2eHh6azRGNGpwclJ2aDh4?=
 =?utf-8?B?MVdlN2pjWXVBRTN3M1FES3A1R29mM1RLMGJjWDdlaVZxUkhCK0FoUEFmazhn?=
 =?utf-8?B?ekY4UVlUbytvZDVrMzRIejhBUm1IRDY1T0o5V0daTHdObkF3bE9FUGd5cGhB?=
 =?utf-8?B?WDE3MjZESFpPL29XL1ZJdjdYRTJDd1BMWnMrTmZpSjl5QTRPbytJS05rTkNB?=
 =?utf-8?B?SkZxSHFwTjlrSVFpMXZFWC96d0YwQVRMR1VuOUh0b2lOWmRrb0tyTlRKRWI1?=
 =?utf-8?B?b01ROG43d05DN1RubkxXZzVoM3FJSDhMM2pkb0UvU1UreFpnb1A2M1IxRWFG?=
 =?utf-8?B?UlVJYmFaQnpVTjFxZnYwc3ROOXR4TGxqdWdKQW1yTXZ3cUcxYjJBNWM1ZEN3?=
 =?utf-8?B?RkIyaUhlbkU1RkN1Q2IzRnNqbEdEMGJqalBHemN0SDZKdDJYYktqWEVZcCt3?=
 =?utf-8?Q?Xe5pN/EZ9IH07QWdEW6mXV1NA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d98f9f8-90d4-451a-8208-08dcf7371416
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:58:31.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuEs75FemJV36jWj3nvmu8LahdzAQ+kWUSRSEdnpSK6rYPTr3XjLVp+hSduY8UMBw+nM1t/ot2hA2ZTLjks/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
X-OriginatorOrg: intel.com


On 10/25/2024 9:56 PM, Lucas De Marchi wrote:
> On Fri, Oct 25, 2024 at 09:33:39PM +0200, Nirmoy Das wrote:
>>
>> On 10/25/2024 8:34 PM, Matthew Brost wrote:
>>> On Fri, Oct 25, 2024 at 11:27:55AM -0700, John Harrison wrote:
>>>> On 10/25/2024 09:03, Nirmoy Das wrote:
>>>>> On 10/24/2024 6:32 PM, Jani Nikula wrote:
>>>>>> On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
>>>>>>> Flush xe ordered_wq in case of ufence timeout which is observed
>>>>>>> on LNL and that points to the recent scheduling issue with E-cores.
>>>>>>>
>>>>>>> This is similar to the recent fix:
>>>>>>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>>>>>>> response timeout") and should be removed once there is E core
>>>>>>> scheduling fix.
>>>>>>>
>>>>>>> v2: Add platform check(Himal)
>>>>>>>      s/__flush_workqueue/flush_workqueue(Jani)
>>>>>>>
>>>>>>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>>>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>>>> Cc: <stable@vger.kernel.org> # v6.11+
>>>>>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>>>>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>>>>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>>>>>>>   1 file changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>>> index f5deb81eba01..78a0ad3c78fe 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>>>> @@ -13,6 +13,7 @@
>>>>>>>   #include "xe_device.h"
>>>>>>>   #include "xe_gt.h"
>>>>>>>   #include "xe_macros.h"
>>>>>>> +#include "compat-i915-headers/i915_drv.h"
>>>>>> Sorry, you just can't use this in xe core. At all. Not even a little
>>>>>> bit. It's purely for i915 display compat code.
>>>>>>
>>>>>> If you need it for the LNL platform check, you need to use:
>>>>>>
>>>>>>     xe->info.platform == XE_LUNARLAKE
>>>>> Will do that. That macro looked odd but I didn't know a better way.
>>>>>
>>>>>> Although platform checks in xe code are generally discouraged.
>>>>> This issue unfortunately depending on platform instead of graphics IP.
>>>> But isn't this issue dependent upon the CPU platform not the graphics
>>>> platform? As in, a DG2 card plugged in to a LNL host will also have this
>>>> issue. So testing any graphics related value is technically incorrect.
>>
>>
>> Haven't thought about. LNL only has x8 PCIe lanes shared between NVME and other IOs but thunderbolt based eGPU should be easily doable.
>>
>> I think I could do "if (boot_cpu_data.x86_vfm == INTEL_LUNARLAKE_M)" instead.
>>
>>>>
>>> This is a good point, maybe for now we blindly do this regardless of
>>> platform. It is basically harmless to do this after a timeout... Also a
>>> warning message if we can detect this fixed the timeout for CI purposes.
>>
>> I am open to this as well. Please let me know which one should be a better solution here.
>
> if it's a cheap thing without side-effects, go for the version without
> the platform check and document it in commit message / source comment


That would be the previous rev. I will add the missing stable Cc and resend.



Thanks,

Nirmoy

>
> Lucas De Marchi

