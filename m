Return-Path: <stable+bounces-182056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F7BAC2BF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1672217D562
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FE248881;
	Tue, 30 Sep 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esl2oCKM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72014244665
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223101; cv=fail; b=pvvXDxEgjFhnIR+raS+eeTIQ9QsyrjxF5xdgq2of8gFAbdymKPRhOZa1NGrQmZwWEqle9XWoWeJ/SJngFVJPRLpGC9M45PPM9tBrMASfe94iCAh642peVHv1gd05jeTtZZTF30YqUxPSV8FUf3o0t1zglqA2qQCtNplpTwCOzmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223101; c=relaxed/simple;
	bh=4M01BfqNiw8LOZElVByNxxEsTh0lL3cN0Df06qVKssk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=skfdkW0NBgGznQhnr9RiTnyhIijhEy1nx33DEflVUbSy53ehBiIfY0GTjz600Kc1IRxuMFrXXU9Ci1+ov0F/iO8qqbyiq8htsoK2kXPaMrE8N0qyGFU3tZvjQffsRvJ4PD4G0dAmLZFVflvR4Ia/blMm0Lphd4yi+dg9lm87AlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esl2oCKM; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759223099; x=1790759099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4M01BfqNiw8LOZElVByNxxEsTh0lL3cN0Df06qVKssk=;
  b=esl2oCKMaPLLX7gnYgKkVdA29zBYeN2NO+f6OR2lcJNepxmsu+5ix7Qx
   nVplL4a/sgW9Vt7mjSjhkyAOmBU6eBrFBhYt82pyQY84LgPM5Q6DdddpS
   mI5FEQ9CxchLu8BWMPlPp7cqYdUjxpCI+/DO682mjq+qBZPO3I8LXCSta
   BVxgDEw1VK4VzX3aqS2tbKfqbK5NeAKDV+UNrzPEYKQFASi/e7LInfNOF
   2uXhqIMNbmeLEbS2v7qw02dXqD6ktmCph0bnXA1908QaTb2QttuOA3jq0
   BeuGWfKI2qvoiAV9n/1TcOKKgbHeSqOWKKGBWF2y4seoQwO+YdtwRpbYL
   Q==;
X-CSE-ConnectionGUID: LUTTC+HVSiuYqIs5oyo3zQ==
X-CSE-MsgGUID: frjbcZg8Sdm+V9/OFyuexg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60512066"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="60512066"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:04:58 -0700
X-CSE-ConnectionGUID: JNUp6Q61RHmokGHPa4VtUA==
X-CSE-MsgGUID: CPOrCU0kSUmXJ3dkKW+DGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182892759"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:04:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:04:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 02:04:48 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OclqvGIvTN9yknzk1dcvsWU4JdXh2a08bmVUsJP/VCcRt/BIiBwEtfVrmAkQUsJxtA6R3U6XmsR7U+7+sqtc8zcK5SzvfwB1eDwIOpOp84+8Qpk/WvO4Ls7l/goxAfByZogtJhP4fXejiog/cMBTfdHVXgb9eKk41Yg1aRMc1jHxho4XIptabrPDJjtqb1oTAGQM3MLSDlORZZDHXUcE5B4ZSPIxnGcrhIiAvCsdSa1Zui2cglchjbPZFU0aozrhPKZmsn76nqsS4U4jpo932l4QSkORhLWlxuzpK6VpwIJ9kAyBJSaDqqqhRwM4DdmL4Kl0q591gMO70i+LTgocYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmMutJJ/VnZCRk47XH0jfkez1siY/uUcKhRal80w4Vc=;
 b=M00R40475r+Wgxm6MRGgSrNErFSe6r3cwfj7FzKSvWpRTmd4u1l1WYFt0BQtyLPC1BXZ2MiYGUP89Emmf/6okf3K8LV4bfziYcwyL0Vkaq6HCqW+tLfb0gawJ1J6+XDjfPecX5PxIwtXVw7DjokskHdsTBB6BDnXRuZWyqity9yaOkLPR9ySPWKphYEESEEqfaryiTLxmow6ycq0S1WBIp3TkZ3q1rIy7tU4RwZfb5vsVRDJ9LzKNHTBNdvdaGB90NJ2cU2ZpclYIAKg0r5KqSxI7peDZ3qEFdYObeJ3rCKSkvqIxBG7M/fFw/bMNzvGD2TD3QrHVFahqmTFvyXcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:04:46 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::48d7:f2a6:b18:1b87]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::48d7:f2a6:b18:1b87%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 09:04:46 +0000
Message-ID: <a6055d09-62e4-4c56-abcf-0fb2fedf42a3@intel.com>
Date: Tue, 30 Sep 2025 02:04:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
To: Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?=
	<me@iyanmv.com>
CC: Thorsten Leemhuis <regressions@leemhuis.info>, <stable@vger.kernel.org>,
	<regressions@lists.linux.dev>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
 <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
 <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
 <afd60150-7371-49f4-a95d-d9147e067757@iyanmv.com> <aNlW7ekiC0dNPxU3@laps>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <aNlW7ekiC0dNPxU3@laps>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To PH7PR11MB7605.namprd11.prod.outlook.com
 (2603:10b6:510:277::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7605:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 65803665-2844-4e1c-6c58-08de000066ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTZDUGFEd3hZa3hVdXhhUlpCWTlZWWZ3bytnMUJ3cmFOcHFrSDlrQURTUDgv?=
 =?utf-8?B?bkp5RHRkSHArd2JDM2tMdEpYKzNQSUhxa0pWREkxdVRTN3Y5UUhFVk8wNWZZ?=
 =?utf-8?B?Ukt5SHp5eU1iUTRzNnY5VVJqbzAwWlR0YUt3bFBsSDFxYkwwd2U4UzhzckJI?=
 =?utf-8?B?ODdjSnVnclpsa3czL1l6cExSVWlQOURlQUk3c0lKYjVQdU90TmVIdStTU1pN?=
 =?utf-8?B?T0ZPMnllN3pQZ0lBZFhSaTg1Q1NhbGI3YUdpOHQwTkNwajVyNUg5bHlNUmM2?=
 =?utf-8?B?V1o3UmpTWkV2OWxIVS9lajZQWmg2ZjhaWEFUUVRvelRGQXA2dUZxdDhXSHUr?=
 =?utf-8?B?V0lEVmszZkhxVzlFU1pScDl1TlRtT09Qb3V2RzlrRDdoNTRBRmNJWmlQd2dp?=
 =?utf-8?B?NWJzNXZ4aEVFalRkRXJQZ0tFUE5yUXZuWjVVQ0NvVG5nTmk5UkxFaVpzVDU2?=
 =?utf-8?B?VWFmMENUYzN0eVFLbXlSVjBXU2dQZDAzK1paU3hYU2diSFhGMStscnRsQmQz?=
 =?utf-8?B?aE9WeVFNS3pQVW1iRHphWk9TZFJaNlF4SmI1Qkg1aXpQenhrTTI2UkQ0UCt1?=
 =?utf-8?B?ZVFkWkhWTW9iYVZPbXJsZ1ZOSCtsdzF0NG03eTd0T1drVjYxcUVyU0ViWldo?=
 =?utf-8?B?ZTJWZDlRNllTdk9FM2FBTHN0RFRsWTgvWnVHLzI3VFAvMU1HUHpDTWxwZldM?=
 =?utf-8?B?TUhaNEFSTzBHeERRem5SL2hyYlE2WjVCWjBQSENKRUUvUlRmSEgvSEJYUFdx?=
 =?utf-8?B?anBSaEJTZUducXF3V0JuWDBVaUdqRnhSa0FsUFFBNE93NXh4UmttNCt5YVRP?=
 =?utf-8?B?YmpNcVBUb0VveWY5SmVKRTduN0k1YnZZREZXdHp6Tzk5N0VSdE9NcFZ3czVx?=
 =?utf-8?B?WDNrRG5ITDhpM0hucFhpRFB4Uk55UU4wOGJtOWIrai9SWGEvVFdKVFplMDFV?=
 =?utf-8?B?cytaTmYwWFU3SzRuYlJSdTBwWjBaUmlSa0NqdnZlRjJKblNXTTJkZ3F5bVRI?=
 =?utf-8?B?b3diNlNoV2l1eHNhTUpCeW5uWDhmWkQ3aUpGZk1QYmVnK1p1UnhiQU8xaE4r?=
 =?utf-8?B?VEU0NHVZZlNXTHphak5CU29FcHVWT0hJcFJaRTYxZUJiTUd3d2J5MDVqQSsr?=
 =?utf-8?B?NGdJWEdiNm9nR0syRzVMSDJ4dEJjajRMaDU4cHhiSVcrN0ZrTkROQ1k5UldV?=
 =?utf-8?B?a0NRQXhZQzBqZ2k0dDdQSU9yK0RDVksvRUN0aXhiaHBaMTl3L2lOb1JxZjly?=
 =?utf-8?B?QzZzU1ZPeUFTb1dOU2NBL0VtanlPczBEZ0ZKelc5WWc0UTVRaGxtaElJT3JC?=
 =?utf-8?B?UnNFTjU4bVlyeGpXaDFuTnhmbjQ5QmhtbkJoaktpalBrUDJLU2YxaUZRWVUz?=
 =?utf-8?B?RklVZlFFTG1FcWZVUEZ0NHlVc3puZi8rM0MwUzI4M1BaaHZLaW5QRTRkSXB1?=
 =?utf-8?B?aXdWQjZXQnVmekliMS9EUzJYTkI4dkppTjN5cklYTWxRTmhUQ2NDL3BnSytF?=
 =?utf-8?B?a2J4azVyU1luNVVrWlJCLzVnMlUrYW5ndEVUZkZabXZCYWw2QTVsVFE3ejVB?=
 =?utf-8?B?SlVITlN1VEs0WnJYVVJEQlJpaWNNUGVUbFdYclRhR0Z2eWwxQ1ZXR2M4SGtL?=
 =?utf-8?B?SzNmTS9rS0lsNXlXR3Jqdzlxcjl4c3ZucVMyekNQaG1VT2lLOXljTUhXQU1n?=
 =?utf-8?B?Y2NkWXhiZkYwMFYrRkVoTjhJZkZaOFA4WDNGMTVqcExiT2RTUC80czJ2Zjds?=
 =?utf-8?B?S3NKNUFPdzJyd0thaFUwb0M3SG83SzYyOE1sSDNkcjBEMndWRWx3MXgxdWtK?=
 =?utf-8?B?STUwUDRvTlBRN0pTeW5aZE1TeUI5RlhjS1ROWVo5ZGU0R3V2VUgwZHRCUDRM?=
 =?utf-8?B?ZnhMVC9Va09va3FBWlp0b1BDbXI5T0oxSGRqWmR3Q00vUHZGMS9HWFJZa1Ix?=
 =?utf-8?Q?cSUUQ9A5QwLEgR66jpCZ6+PqtvOV8kMT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3liL2ZwWEpBMnNQUWtzTU4xYXBTYUlBQlNRWFk4SElZU0RzdE5KVTdEQWgr?=
 =?utf-8?B?a243OHdxa3A2dTAzQmxoMnh1QXZoNHpJS1BGcG1DenA3OHBIZWkyYjRZWW0v?=
 =?utf-8?B?WFlZaFVOWmNRTEd4TDl2SG1yYnR3VllDWVNyeFFRaGQwbXJheHk4YmQ4YTNO?=
 =?utf-8?B?NzNNMW9NenhHNEJPU1B6UlRGcmI2Vk84WnJCTUd6SnlPSm5ZbWx0QVNSVnZI?=
 =?utf-8?B?Q1YyclA1Sk1GK1FZU1JBYjgwbTBtZmV3SSs1ZnFycjhpekRSSDZTRkE3b2Ur?=
 =?utf-8?B?TFhFdWQvTUlJNlhDMkdJLzg4ZDNTbFlleDZUamZ6TDNLS3R6YnV4YUg0QkNI?=
 =?utf-8?B?RkorNSsvMjBETDlTNGwzVzNuekNLV3VYMXhPTDQrbW9OaERIY1dGcHhKbDUv?=
 =?utf-8?B?bko5N01TYTR4U2ZtUllMWk04Kzc2UnBVSG05ZXF3YkJwcERRTFhGejFkZXpZ?=
 =?utf-8?B?Y1JKTHhYVjBrdCsrZloybS9nZFM2WG5PcnQ2MzZDTGlGZ252eER0UkhtRm53?=
 =?utf-8?B?L1RMTGdNYmYvYXlZU045RnVsTDYrTW1KaTMrclUwREo0eXNPcWpCUkQxTFRE?=
 =?utf-8?B?L2NFL05ramErRURaZnFKK2dycTJ2UDkrTGxkYVhvalRZRnhVN0tTbHN3Smw5?=
 =?utf-8?B?WXcwUWhBSUIyRGJpaTBCeEtpbThLZTJ5ZWl1QUJxOHhRL3NqOGZPVmVCUllr?=
 =?utf-8?B?OWFTYmljc3oweFRXcSs5RVNVVFo2NmRqekw3Z05zSWFCQS9Cc01wZWtkQmVJ?=
 =?utf-8?B?bVBoWXNESk5WWEFHbmwxdmk4QlVVM0w2bDlFaHhjbHgzR29vT2NocDJoTStB?=
 =?utf-8?B?ZFlpM256V1dBYnJ2VUsxYWRwZEErZ1g4NkMwbktjL2VyWlRhMFF0engvejBF?=
 =?utf-8?B?Ukd1OGxKRi80T1IvbWJvQktGZVJaS2h5ejlGVE1qNWNBSytVcVdMb2VMWkxn?=
 =?utf-8?B?dkpDYTg2Mnk5QktRSk9jaUJab1lLL2Zpa3Y4aDVMMUw2WXVKNFNyamtoMXRO?=
 =?utf-8?B?a3NYb0lXdUpqNElnaFJVWjdOdG9GN0JFM3FKUm11MWxTNzZrMTZmMENTTlhj?=
 =?utf-8?B?RThjUVc1L005RnVKcDd5a2RtcWZqbXoyaU9iSXhLQ0N3ckNCaWNyUkN3Z1FE?=
 =?utf-8?B?UXhhNDRudWhvckRza1dyTERXMXFOYlFaUWJReWJRZUFHczd2ejFNNi9jaGZa?=
 =?utf-8?B?YVVvYytDVDlKeDA2RlJidFhxWkYyY3NlZFE5bHh4MlpUQ1V0SEN0MWo2Y0VQ?=
 =?utf-8?B?SWs5TXlOMnZSdDk3RWN0Y29nOEVhSWR6U3QwYWsyNHduR1FVb3V6YlhPSEp1?=
 =?utf-8?B?RHNPVVNib3RnWWgzRUJobjc1NVlwa2ZaUHQ5bXlkYU40UVVHQnAzcnVMVkNB?=
 =?utf-8?B?TlpubHFnL0ptNlpIbXRYdGhNNm1hSU1CeEpaNlJFYTRzMzgwQjNESUl6cVZt?=
 =?utf-8?B?SWVDbElOWm5BRnBTL1J3R2pJTGlNTzZ2VTNSaUl4eHBCdVBid2VNeE1TVXJI?=
 =?utf-8?B?MitNY1dnRnFYZGFQVzNqYVlaOCtGLzBOWFZLc3NVVUxXUFFteFZ3SThvM0hk?=
 =?utf-8?B?ZmNBYXJNMG9OUG4va2JlS0E0S1cxTFhIYWR5bUhxNStiM0hscG40ZURndW9j?=
 =?utf-8?B?RG52VFl1WUhVMmNydFRwd2pwM3laVzIxQ2xQc3lFbldTUzlqSW5YTFllTGwv?=
 =?utf-8?B?YmZ2WWROZXBvYkJldzdaQ3VlYUFIaityL0NHY2U3SE5tUjdiNmpGd0FmTDRm?=
 =?utf-8?B?eDEydThyRGtxcVk5clJiNTAzbXEvbGVMenphSFE0cTFLZjAzRkJaNC9FNU9T?=
 =?utf-8?B?QmJBRUZTeHhOTG0zZEQzWVJGRVRwQ0J2dnJ1Sm4zTVNDeWN3RTlFTGlTSkpI?=
 =?utf-8?B?c1g3dTJMYjk2SmtQRGh1bUZrNHo4SUpUMFBmV3JvSWU2TGw0UXFKT0ozOWts?=
 =?utf-8?B?QVZOYVp0dnVuL29mUWdQTW1NcXRlZFlYVGRER3JVSC9nNzN3aU5OMW5yUGR4?=
 =?utf-8?B?eFA3NDFSMzVYNjJ2L28wYVFRT3dqUGxiODdxV3JvWURDY3ZmdUx1dWVXMXRF?=
 =?utf-8?B?dkoyV1ZPdWIzL1kvTnkvaDFYRFozamU4Z0w4ZzV2bXlES25qWHRsTGY1aC9u?=
 =?utf-8?B?bDVnRnkwRHNZekpEa0xZTHNsZzFKSTNEMlJ4TkpIY0tQUituYWUrbTBLUmd5?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65803665-2844-4e1c-6c58-08de000066ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:04:46.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjHbUz2dzf6TP4u1DLs6W+vBLuFwFDwd09qMRBzcw58k9fTm99F2RxEWzAPOWskIIvAYVZhSBk2yuUeJDfBem067aa3K/UuevyRqWsVNOL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com



On 9/28/2025 8:40 AM, Sasha Levin wrote:
> On Sun, Sep 28, 2025 at 01:16:34PM +0200, Iyán Méndez Veiga wrote:
>> On 27/09/2025 16:31, Thorsten Leemhuis wrote:
>>> Thx. Could you also try if reverting the patch from 6.16.y helps? Note,
>>> you might need to revert "drm/xe/guc: Set RCS/CCS yield policy" as 
>>> well,
>>> which apparently depends on the patch that causes your problems.
>>
>> Yes, reverting both dd1a415dcfd5 "drm/xe/guc: Set RCS/CCS yield 
>> policy" and 97207a4fed53 "drm/xe/guc: Enable extended CAT error 
>> reporting" from 6.16.y fixes the issue for me.
>
> Thanks for the report and investigation!
>
> I'll revert these two.
>

Hi,

Thanks for the bisect and the quick turnaround on this (and sorry for 
not replying earlier, I just came back from vacation :) ).
Just wanted to add a quick comment as the author of both patches. I have 
no idea why these patches would cause issues on 6.16 but not on 6.17, 
nothing significant should be different between the two releases in the 
impacted area. However, no one has actually ever reported hitting the 
starvation issue mitigated by the RCS/CCS patch (which has been there 
since 6.13), likely because it can only be reproduced if the GPU is 
heavily overloaded by multiple apps; therefore, given that 6.16 is not 
an LTS, I'm not going to attempt to reproduce and debug this and re-send 
the patches for that kernel version.
Please let me know if there are any concerns with this approach or if 
the issue pops up on 6.17.

Thanks
Daniele


