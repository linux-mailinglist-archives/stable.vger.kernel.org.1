Return-Path: <stable+bounces-194663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D7C565E7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30BDD354EAA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC52DBF76;
	Thu, 13 Nov 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UD5fTyi9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29279274B37;
	Thu, 13 Nov 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023592; cv=fail; b=PbaB9ORruTPBwkcmFOm2T3lFCSMxS2/GFfzwrPBhVcoNpRyq9gWL+6ZkRDckEwmDx3ZiRNoEHQKhCIziGrrr+N4bqTC8OBtfPb+rP1zFALdRSbLylYDUo+R+OPymKa2tvlB9J0sH/1cgycS3klHlzGHZSP/IE0ZZwbTGzrW8umU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023592; c=relaxed/simple;
	bh=NmNrVIlfFeG+0l6rcqzAd+5vOUVfN94YNjJqztp60II=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j3SHJ5Nt81zSglzSamoGfzEfqfldRXgANHG4NwMk17VKPqfyaWjiWJjzkOMl9A5YgWGvvBXrKNgpoyRGDMJziaNwBevh+3/z0pdOqG820mk4yYSdYPEN+eCzhe03cow3DUtgCnY54Qz9UPRfUHyqTT2M9wqBEMOg5v+2O0c69cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UD5fTyi9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763023590; x=1794559590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NmNrVIlfFeG+0l6rcqzAd+5vOUVfN94YNjJqztp60II=;
  b=UD5fTyi9MUxItEeoM4v8uqDiaE1lRGN8Uz62pDq0XyMiyOUW1X/K6zC2
   z6jr+A330+UiAWQQxUdWjI+rp9kSoqx0lxyK+u5DPjeK81pn9ZfZHfDqz
   rhQijMTIRfJoL0Bs7CUgZ/BzwJzetOlrU22ZXAfvMBPDeiHs7hJEnMDkf
   HgWkVUj+DpJ81eNXC+6Fme6+qylGxcAQ85Ol6Bq0H9bqT6UJIVzRD+gzC
   Vp9guf6+lEoubUwjO6z4WdtNQsA7BRyfwhZwt+mHf9+p4Vs2FZiKqV+ji
   TYb/g0r22cmKOrlqPTYj3t2mZuF/ur+rg3zONGkd9ezWLJRzGKV96mYlj
   Q==;
X-CSE-ConnectionGUID: Ze1Mx15xQyCiG3z3FM9iag==
X-CSE-MsgGUID: YIOYqjPrRzmxkvSfI1jHTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52661921"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="52661921"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:46:29 -0800
X-CSE-ConnectionGUID: 2CmnBRKsSmicwY8Xhp8CiQ==
X-CSE-MsgGUID: ZKVduqbsRsWXYEPFkBU8kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189714730"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:46:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:46:28 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:46:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:46:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bINJn2xUUNn89LKnqd+EuFsaUWaeRfecXjf54IMmZLWOudPWZuM3KAHgyZ7ZbB5ghPZK2P8p+Hhjdxe4dDxm/FwKkRWccsvZM6Kcnn2Lt+O5XH1wJTZ08ZAnMEFEL0Nuef7/W/Xzn3TghD7RnrNqkwws9YWjPVr4ir0+pT0kw+7+8+jYVY6QAobR7lfYfoWP6Lr6cdx4sUnIT5sjELT/XkZd/Yh0QClKejJ1Anl/4TYWfYlX8N3AZIxSLPb4CztcxZL4gv7uf9nr8oEz+Qw92EAwq2pTQZ8nvSGv6O2S9JtRuKS8X8H95PUyhcwvUkZGWFoMOFUGcWVGq/IizBx9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx+iRUA5GT5d8bFgNPtPME5UWcwNJ2OMDxvS4ksq9QI=;
 b=JPfZxP07PXbm5wZlMn1XYjfltnqdRf/V+ilsGM6Q22dFCjLNw9dHnmb2bHTfU18GT6iOddsxFJZKc0kX4YIJaaU1W3fVBqnTH/p7KLGwEEO06ThftDxoOOBONJ66FWfGv0oBdjWG9w79CsXArs/O2p9b3QrFoWbVzJ89qGs5gE8Z4R2IWEysLABWnfUBMlTj79R+N3ZgiSWGOaG3+h6zeskg7jTB7OSrOk+PdU8KZHho7955t+dmyAq/kiarO/bTCEhGn7kILHUfpkL39qnn97d7z5nqpkbxTxWszVcyQNE9QcamROR1yajNjH+HKv3dhR9agO4yWYlsfyJ95tGv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:46:20 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:46:20 +0000
Message-ID: <bc479d42-af01-466f-b066-1da9a99b29bb@intel.com>
Date: Thu, 13 Nov 2025 09:46:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by
 snprintf()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<amadeuszx.slawinski@linux.intel.com>, <sakari.ailus@linux.intel.com>,
	<khalid@kernel.org>, <shuah@kernel.org>, <david.hunter.linux@gmail.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <hariconscious@gmail.com>
References: <20251112181851.13450-1-hariconscious@gmail.com>
 <2025111239-sturdily-entire-d281@gregkh>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <2025111239-sturdily-entire-d281@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9a29bb-970f-4459-a569-08de22911e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmNlaHkzNG9aWEJXRVM2czZJSnR4UkpSOW5WaFlxZUFEajM4azcxcXpmZTdr?=
 =?utf-8?B?dFlnZGh3MWhhTDVEMFZLRksxK0MraS9SZWZhWVMrZGJ1dXJXVE9GbGQ2KzBU?=
 =?utf-8?B?TkRrQUFsU0hMaHA0T0IwWE1ZNkVYeGp1TVdRbnNjNUtRK3drY3NMUGFpSSsy?=
 =?utf-8?B?ak5leEIvSlNxbWFZR1ZWQWZ6SUVMWUVQeERPTCt3SFBsZWtRVmcrL3lwSGpZ?=
 =?utf-8?B?L296SlhucmxkZWxRMWRHVWRtbjBTQ3NtQmZXQUMySlkwM3JKUEJ2RkpaZHpS?=
 =?utf-8?B?MmtNYysrTjJ6T3lnL05qdmx4cGJ4WC9KNTVzUG5Ea3d4NDBvZFB0UG5DTjd0?=
 =?utf-8?B?cXo3RXh3dmFZMWt1aXNsQ1hYN1cyYTkxN0xZSHRpNkpobFFGd3ZGTHlRUlp3?=
 =?utf-8?B?R0pvVERIamVGNEtPUHc0L0NNMm54ckVGYUswbjRQc2pNZWdjUGxqdnpjakx0?=
 =?utf-8?B?clB0dDJPWHZRelYwcXhFaDZtdmhLa0Nzb0h4YUVvMnpkTjUveGRCcm9vZVZB?=
 =?utf-8?B?a2R4cmRNTDJVWjVZVUNaVXVkYzhRLzJ1amZ5U3dVbDlueG5IdFdETFZqVmVl?=
 =?utf-8?B?eW1tQ29xSk9UYjN0Mnc3VFM1RnA4TzFXSC9OeW1HbWp3SG83UXlkWWRjUDhm?=
 =?utf-8?B?WUFjSndZeDFiN1NGTDByendrbFBhQWh3a3hTcCt0WWhkNUd3WVFycXZDeldy?=
 =?utf-8?B?bVQ3b3VTY3RVbnpQeHhrSWpPeWpvcDNVVHROWVRrUHZYbEkxanpWY0FRTHFG?=
 =?utf-8?B?VzkwOFdOVSt4a0tGcGl5a2xHV2JpRU1CcUZ6Sm12Qmt0ZEc4NlMxVWd0Zkl4?=
 =?utf-8?B?M0ViOUZWa0lQMDJua042aGdRQzFyYVVPaERIQWFLVm5vVnFrcytJZDMrTko5?=
 =?utf-8?B?dEZlQ0JRWE50WWxhSHZ6djFJVExvWkFkQi9qM2xYZGdYOU9WaE1tYUR1MFZQ?=
 =?utf-8?B?bkNlYjh0R1ZKdDZZZlBEelREcGJsNzBucU03ZGxuM1ZCVW1SN3R1TlRWWFk1?=
 =?utf-8?B?OWMyaW5GQXdneGRMd1d5OUUyQmFCVmJSUjhJTFpWdVlFS1lZYTB0U0E3b2Ew?=
 =?utf-8?B?Zm1tV1BRRzRqZzNsQ2t0N1l2blZQRkpQem5Ub3NxcGVuaFZpNjdyeXVXdi9k?=
 =?utf-8?B?OWE3R05VN2d2RXZxTjQ5QTBvTlBHT1pJdGg3T1hkRFg0VGtwZjdCWHA0cGxx?=
 =?utf-8?B?STkvQy94YzNLamhMMUdicXJDOENqbjdna1krSlZrRTRZVXphODNqUVpsNXJR?=
 =?utf-8?B?M0tRZ2R2dFdtWGEzZkpIQVpzZXk5YVhTV2JhVkw0U1NIS0wwU1V0NkE2NnZR?=
 =?utf-8?B?VEJuUjZEMHFZS3lXMkg3OVdLZUtoKzdUNG1FaHNJQkN2VUtRNW5VUUY4d3dG?=
 =?utf-8?B?VFJRMThFcEF0a3NMR0JrU04zQXZPVTlYWWwxSUtncUVlQ2RpdlZFZll0VG12?=
 =?utf-8?B?WXFmMkp5a2FMalZ0RGZ5TmNKZEtuN09VVE5LTmF2d1RWaTJIWFVlcVY0WTIx?=
 =?utf-8?B?SUtnMVdRN2t2WWl5RllFSklKS3BMNGJKQ2NKR3U4UjcvRFcrUU9Gd3VZaHlt?=
 =?utf-8?B?NVowQmFaZnkyanZxT2oyK3h0Rml5ZEUzNWQ2enFTNGR2c3dkN2kwL2UvNDdh?=
 =?utf-8?B?MmdScTkzQkRzZ2YxcWJzRi9vUUc3UnlRd3hYbVYyV0h4OXJoQ0xGU1Q5QXY3?=
 =?utf-8?B?cklLenNSWXRHUUpOWHJtU2h4ZnpuYWhpcVRBbm1kdi9DYkhmdWVPd2tKNmhY?=
 =?utf-8?B?R1NQaGpUMkRpdy9uWjFWUTVIMTc2ME1wQ1p0UUNjeTY0eHgwNWVVNDhqWk9k?=
 =?utf-8?B?a3FQWmR1YkN0SFFyZzN0ZUZVcDU3ZXVVN0NneEdPbGdnK1NVbkJMTnpvNEpB?=
 =?utf-8?B?M1ErQnA5UXVHcHdJaHUrdXJicVNOQjRUd3FkS3l6NkV5RjVBc1VxNXZzYmtk?=
 =?utf-8?B?Q2JKQ3lEcmxTSURUN3FibVRQVFZOU2VsMEJtVDdoNHA5U0Q3RWtZdURIbE80?=
 =?utf-8?B?ak92b3cwZGRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlhRR2U4dUJVOWd1UDZQSzYwSUovaitlWEtaWWk2ajlTRm1xSFRnUEZPcjNU?=
 =?utf-8?B?ZDU1TUlSaXBRVjl1ajh4Tmtza2lYVEppd1NqVDRZYk11RDhBMlZTWk9Iajhs?=
 =?utf-8?B?cUZ1WGNHNGI0TC8wOTdNejBJYVBQM2UyQkllVGZnNEJ0TWVOYmNBZnZ1Ky9w?=
 =?utf-8?B?VTVOTTkwc0JocFJNWTZ0aDlsVklqL094RG1EaUl1a0VrMUF0UFJ1TlVGMnBt?=
 =?utf-8?B?dEgyQkxOQ0p5SmJnY1A3WkkycXRTSk01V0dPMlhFZjVMNkFXUmhoK3hTU0pv?=
 =?utf-8?B?UWIxUS9SMEhNVVN3T0VUUDJDWkFvTkF0RUhCczRuOHRVYUFJTk50VVIyRGxi?=
 =?utf-8?B?VEZ3ekdKbS9NZ0ZkNGxsckJ0Tis0aUFJY3BoVEgxaXBEMkhncTBCN0NQdHg2?=
 =?utf-8?B?VVdlUDF1ekRKNDArNlUvbCt6UHFyQjF5ZFhKQW5EdW9TTFAwSVlmVTNOQ25v?=
 =?utf-8?B?OFJOaTZQY2UyUkZVd3B6U2ZWUmJIWXcyc0N0ZktmZ3dwckZTQmRpbFJSQTJP?=
 =?utf-8?B?Q3BhTXNKR0VsTVJybERmSk5nMnUrZVZHN2NJSm4vWTl1bUFWVlNDdXBmeWxj?=
 =?utf-8?B?dGtuR0ZGaWNmTEl0V1pVR2UrZHdoaXg4K3hDV1VtZ1d6M2V0OWFScnNYdVYw?=
 =?utf-8?B?VllnOHprdW9MOGs0Tlg1UGxkME1qYjdUc3RYdVJJaXpyVmZpVHk0UnFVK3Zq?=
 =?utf-8?B?V0xrejVvblhYN2pYN0lVRk9UcHpCNzN6U3FFNVlkSC9YeDBaVVMzdU8yUDhQ?=
 =?utf-8?B?SFNZMlhpSjY3VlBpSWVYUDZIbTdqT3dHd1ErdlhGV2ZKSk1pOXRHdEh2WFVJ?=
 =?utf-8?B?em50MEJhTkd3bUgraHlJbmpIOCs5cFJTSUVqNTk1TW56OGhONTFuTlNLKzVB?=
 =?utf-8?B?VldUcVV5alFvTFA2a04vaFVZUGtON05ta0xDZUx2K3o0a3RaRWx1czV3NzRn?=
 =?utf-8?B?MTBTZjk2aUNTeklGU2FIeGMyc2Y4cGJuV2xlM0FXM29icGNuU2w3cjNwTTlC?=
 =?utf-8?B?QzVUV3N6d3VxNTVCYlE2aVRoZnA3QjhIQ1I1NXR4ZGN2a1drTFVHNzZRZmVp?=
 =?utf-8?B?WktBUnpJd08xR294N1llSExUTTJwTzh5eGJLbTljSk42MGdRWERKRm5HUGZL?=
 =?utf-8?B?cWo0YUkyVG1sWFVaQ3pqRENDQlZlMmpIYXN5WHN1Rm5kZytOMEJTY0FONWRr?=
 =?utf-8?B?OEIxcXJpVDNsdGFwQm94dUVCMEgvam8rM0dpdmYzeXRSUGlhTDQvb0xmQ3lC?=
 =?utf-8?B?SHduYlN0d3JRZTdNS0QzSXplZHpNcEg3ekdxZjNZQ0JyMlNJTzA2MTh2RFJF?=
 =?utf-8?B?L0Q1RTF0MllPMDFqSVNlNnNtZ2JTNU1ISEhtWTBuTzJMVWlYQVpGUnhiaDBr?=
 =?utf-8?B?NG0wRzhrSlpSRXFNWnRrcStweWlHTWV1MDZjK3FHbEdkTFRHem5hTmJmdWxB?=
 =?utf-8?B?Snp5OWZWcTRycWk5K25uMXl0c1A2UnFoN05NcTVwQjdsSm02WlF6NXhVL0RC?=
 =?utf-8?B?SWNEUUxEdXVoS004eklTeC9mR2lCdjlaY2kveTFyQm9FbHJBTzZDMjdJVUFa?=
 =?utf-8?B?M2czQ20zTG5QOUpVMW43cnZMMlBGQ1MySWYrTWRKRW1IVVZLWlNQLzdRc0NL?=
 =?utf-8?B?TmhOL1htT2pwNG9tOFZhRUdheEtuR0xMcnlqRHYyNldKR255ekFhdUx3UG9k?=
 =?utf-8?B?U04rQmp5YXF2ZE5JaDZtYkdPL0dLUXRoREhVZ25wZmJZV1daTktwRjNWbks0?=
 =?utf-8?B?ZlZiWFBpc3lCdUVJbWNGMytDZGRNdU5Ea1FvR3kzR0I4c0pGR0MzSEpiTmlL?=
 =?utf-8?B?Qlo2SXJ2NWNKYVhES095djQ4aDNRYyt1dlFpcXNiOU9TR2VNOVNhVGtLVURM?=
 =?utf-8?B?L3NDdEN5NHRUd1pqK2tHY2k0bllxWktyc3lZQnJGblNhbTFhYkVzcFZaSFVY?=
 =?utf-8?B?Yms4L05XKzZHSVRQaXZCMXZmTG1lN0RLQVdVSXZZWVF2cElDVGhqNC9hUW1z?=
 =?utf-8?B?UUFYWVNJZStnaVZ2L09QK3pGN0F1YlJic3NYdWRkTzZlT0puSEVUMDYyemMx?=
 =?utf-8?B?M3VUTDIxMDVycjM1dFh6czFqYjNlUkRGeGZrQjRHRHlzbzE5WVJMYWxsZmdZ?=
 =?utf-8?B?UkdNcTBTUlVtejQzSmhLdVhuZVNXc2hBaTVPa0xmUGdOSERNRlpOWnV0SmEy?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9a29bb-970f-4459-a569-08de22911e03
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:46:20.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y2BX6CIzjBBHGqNxGlDkK+difc6qy5Vh3ztzLPRcmpUH+llmjrwd0R4cBYEnLbqsrVjMS99MwrM7uPpA/UGtli9TuMWNJsVshVO2ZVKCYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

On 2025-11-12 8:20 PM, Greg KH wrote:
> On Wed, Nov 12, 2025 at 11:48:51PM +0530, hariconscious@gmail.com wrote:
>> From: HariKrishna Sagala <hariconscious@gmail.com>
>>
>> snprintf() returns the would-be-filled size when the string overflows
>> the given buffer size, hence using this value may result in a buffer
>> overflow (although it's unrealistic).
> 
> unrealistic == impossible
> 
> So why make this change at all?

The problem will never occur in production-scenario given the AudioDSP 
firmware limitation - max ~10 probe-point entries so, the built string 
will be far away from 4K_SZ bytes.

If the verdict is: ignore the recommendation as the problem is 
unrealistic, I'm OK with that. Typically though I'd prefer to stick to 
the recommendations.

> 
>> This patch replaces it with a safer version, scnprintf() for papering
>> over such a potential issue.
> 
> Don't "paper over", actually fix real things.
> 
> 
>> Link: https://github.com/KSPP/linux/issues/105
>> 'Fixes: 5a565ba23abe ("ASoC: Intel: avs: Probing and firmware tracing
>> over debugfs")'
> 
> No, this is not a "fix".

The patch isn't worded well, that's clear.
While the patch is an outcome of static-analysis, isn't it good to have 
'Fixes:' to point out the offending commit regardless?

