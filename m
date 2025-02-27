Return-Path: <stable+bounces-119797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DEA47523
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C69016E28F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3DC1EB5E9;
	Thu, 27 Feb 2025 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoHjB7hs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0831E521C;
	Thu, 27 Feb 2025 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633679; cv=fail; b=m420JsuRdaZkgFwbcAZDEWcegGneNnjcNurRjRY5KvIWUM+/ok99GD2HSyAQ/BH+hdRECNRFGi2wXOIv1t8t0jnfqZfkOTY0nrDpZdcy82SPN6pLRIV4h9yGoUHHnJxlQZcHgD/9UgbFQT1wLZISjn7N5vwhBIrWgN46j0tG2Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633679; c=relaxed/simple;
	bh=Wk+CO0eRnVaXN3ypnYPtmxHiKKhC+Wii52qRVgayhjA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uE1tMEbXeOKRiqZLzcCPfE4TWaF9OWIbpyRsvRvTpZ7lKxjqbgS8LwN+aro+jFWwTbxL+NDi0uADDqLdOtPETp75U748ax7K0t3YbZXc6XvSzMwAnmuuKo/u/6VB8RZ9tQDQKd/uLhEoVBCKVzaHWh1uvXQ3hTWnIFNZTsSW0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoHjB7hs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740633678; x=1772169678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wk+CO0eRnVaXN3ypnYPtmxHiKKhC+Wii52qRVgayhjA=;
  b=MoHjB7hsq5LUG+hnfIGxAoy6Iurtz3fRGcGWVm6WWQDE4PCk6tgn/7XY
   IaiEuhfSsxdj8uXtpJwctu43cMB9vVt/No3fihYDS8Soa6wIGW8I+z4ui
   sqJWI9U7iKfJTgHixiIjyjva/JRBAeOWsCYO5UXLrsOr/H1fSzCGRrfjD
   Q+a/yS//B8qEx7NVXFJuAG9mv+WBkWA1OzvH4aD7+lTiDn2yod5rbzoMt
   TBQ7hcDUIHYCV0FkY0ag/fMV4DqdTQ1fvTjpIwBo0d6O/SSP7v4ZbL2jy
   hrWeLzvs4KczZ+LM2mqC+6Iw2hu8o6F2DI7/T9uDdnQqZdtLzgO5Y4uBD
   Q==;
X-CSE-ConnectionGUID: mlzZrt62TGutKZzqKRi86Q==
X-CSE-MsgGUID: /wQ9qSC3TtWTgQolDL4g2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41708184"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41708184"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:21:18 -0800
X-CSE-ConnectionGUID: Q+j9Aj2KQXWnPdxiipsNDA==
X-CSE-MsgGUID: OTOGV0F9QiKiu/EUuLjwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121512283"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 21:21:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 21:21:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:21:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ontEDn9qxg1KkVHruXgo7vAqTz/sx4RSaxRDxYlQ62tqghoDbexJkrl4Zq/XU8eWJNnc1yGaVAFTcufjAawb1bfCRNMHzo2kwlCTnStGpfAYsiGgxYWLiUR9FiyRCYnGWbummJgDYsUcBwCJBhNHmdLxY1g1DGk1vao97ADArK45tp6nDetr9LItdVwjKFcmRB5nsFAF8TtIjkXgjau8cNxdeEY1tjR+QesAW/tso7KCTBy7ecObMNDbqRJvLZMLsAnvW0Jo6iEie425NTkTxSGfnpkZJ/xHyInZlKJeoe5oJvT4rdjjUAp9+wZebusbICIObYeMGNpP9/l0C7vrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st51FtFEcikr3eifA/IkNGDvbIoxUm6kAsZc4MYZlUA=;
 b=vJhxTFpspIaldqhgz4W1+z3viOnxsc8pnCo8TUEr5fKlJF2g3+3jR0MWuXWAT+A/FmippFKYUYYvc8Z9GEcVRnF3u2ZAQsApfXHNde5aqz32J4TNAiVlbJNCLyKwDAKJcrzFWx1aGgmr6V2b8ZI0/0xEb2OmZQKOaBGekgjTSMTLjvn3QW6YBfkERiEm8SFaKEIpunaflnRi2TUTI7ROghKzDH+J1bvwK3wOd+pywg1ZfGfuAL4uT/6txJNYnw4qm3aPHL4469xG9fsSUzA9rwD2/c3NCMWFTbMbEwh2cW6xYJFxOTGcQaL//+JjM+rROUAzzaOqKPkbXdhmRkJL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 05:21:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:21:13 +0000
Message-ID: <34b2c92f-e879-4a9e-beb6-c6786bd59c9d@intel.com>
Date: Thu, 27 Feb 2025 06:21:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] dpll: Add an assertion to check
 freq_supported_num
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <jan.glaza@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>
References: <74xcws6rns5hrmkf4hsfuittgzsddsc3hnqj6jbfsfu3o2vvol@gy32jyg75gmd>
 <20250226193715.23898-1-jiashengjiangcool@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250226193715.23898-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0061.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: c2534f93-6565-490a-d4fc-08dd56ee8d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZC9TRWhxN1pwY3gwbkRtbXk0K2NQVFZwd04wOWdnQytNL2ZJYldwR0xVdTFz?=
 =?utf-8?B?czZMWXdmL2x2U2QrTXN6a1pUWU5ZdlNISmxSTmQ1dUtCc3EweTN4UGZCSFRj?=
 =?utf-8?B?dGJJWnlHWW9CN29mUDVKQkJlaUlXbEVlTW9Qc2pOc0R4OW01aG0xMEVKTE1q?=
 =?utf-8?B?azB6LzlJbmpDZzRLSEFhWDBYM0JWZHFUU1h0MTJVdXJPdDNxdVlZbkF6OXBF?=
 =?utf-8?B?WXFGWHJEVE1KZUo5TkJMb1JGT1huTjBPVUpNK0FQQlptMkxjNmtQdGJZczRM?=
 =?utf-8?B?NHN5ZnRZWUwwaitTWXdYYXprNHZvZXdtdVQvUFF1eEJocjNZczdWT3B6YzZD?=
 =?utf-8?B?UzJpeUhJRUhqeTFDWXRmcEFvN1BxT2ZpQkl0RHRUUFlVUmpXN0dCQ0N3M3dI?=
 =?utf-8?B?UzVmdFhXQmtVUFVHQ0t3WmQrSXBmcTFQMVpOU25GMC9tYVJiRTMvNEM0bnd0?=
 =?utf-8?B?NkgzUDdHOHI0aW9wZjJQZDJrSXVocWdMcFF5azBIR2J5aVJRcUJ5OHZtUmdC?=
 =?utf-8?B?bmQrUUk0UVdNV3FYVVplVExtQmF0QjJlRTdBZmUyK1FjVW5NY05iRCttZ29Y?=
 =?utf-8?B?cW5HRm0wdWYzVlhtbWhlcG1qMGszK2ZCeWRFcmRDV2laNXBldGdrVERLWlBE?=
 =?utf-8?B?U0txMklZNlhaTFgzMzAxM3NUd2p4L3VoaWs1VXIvSi9FSklDSU5QSVZ3QS9Y?=
 =?utf-8?B?NUpidmFRR3M2c2h6M0pFTU1seFNmTGlkd1BxRzRQMnRyZFRQc3ZjZGorNDE1?=
 =?utf-8?B?QS9KTVdRVU5lZ1podXVQY3N0QS9JV2FDUHUzUmRkb0xrWVVGMlluS3V4NXBS?=
 =?utf-8?B?L1hpT3Vzb0ZhNlpScmlXQkdacUNZZ1hxOE1Cb2hNdnFYZXdvejlhTUpxdmdK?=
 =?utf-8?B?MXJGbWM3SERtRlF4UTdjNGQ3d01jVncyVW95czRoUmhxcWo1eVRwMDhLenlP?=
 =?utf-8?B?L0NKVG9iazFkc1JNalZMVGlYRmtqTlFtOUtpQzFXUEJFemYzYzAxUDZHU0Ux?=
 =?utf-8?B?SytYZnFlT1lQMmVXZERBbzdSalpHV1JGWmE2RFBKS2hoc3prK1lyRVhOYkxM?=
 =?utf-8?B?YTFBVHQ4eVBScTNacnROVjF4QTV4cTkvVVVlK05OMnJtdDQ0Wno2MnB6WVFq?=
 =?utf-8?B?bHg1c0JDUkg5Mmo2VnFRRmZrSW8rRDdDYUZ4YlFRbzUvVHNjS1gwU0loR0Na?=
 =?utf-8?B?cnRzdTRUZVJYK2Y0ZHU3Nld4V0cza3pxUmtsSTdoSlY2NStKZ2tRZ24wdVJE?=
 =?utf-8?B?aGc0Yy9MZmFFaFRFa0xWcUxDcVF4S3htcmpxUE5DUDJNSjNkUXFnd0UrUk5R?=
 =?utf-8?B?TmJYemxpOHFyUUlXMWFxa2ZNMll1Y3RCOTFDcE11YzR4M0I1SDVsWWY5aXJp?=
 =?utf-8?B?cE80SVhuRE1CNzF4ZHZoSkc2azZTMzlJTU4rMEhBVnplVFFDWmlBbkpKOEFP?=
 =?utf-8?B?eXZvc2JNMDZmUHFzV00vcWFJU2dJZVA2VnZBdWhsdzJ6RTZZSkdYTmtTemcv?=
 =?utf-8?B?VWxOTDZPaWpiQXcxbzNaNWRhdXJRMXk0S3NLeWJDNndpdEF5ZFFaTFpncGhG?=
 =?utf-8?B?YmFLOU9aRjdqandCSlhZOVlYcXpnTXEvTzBnNUlkVHo1cE8zWnZNcnJYdnMz?=
 =?utf-8?B?WGZqRURUanBQUnhUbGc0OUcvSjZrTTVQS0xvazJ1ZXphNlI0TXNRS0c4WEgx?=
 =?utf-8?B?TVZiSGpob3FCOHBxVzk4WEpjTWErMk5WYW15N0ZHNlpFRzlGOFB5QlhmSDZL?=
 =?utf-8?B?dDByaE5JcXNrc0VvSkpXUWRHaXhlYUQvSDl6WXJsZjdtdndybTdXUmQ3dG5l?=
 =?utf-8?B?TG51blBDS3RCaGpneng1UzNOdFA2NFVncHEyQkp1bXZIUHRwUURqOVRjR0ds?=
 =?utf-8?Q?h3KnAIc8xzyGo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJGK2l5ZkNMVm8ybWQwZ0xCaGduZ1g4SDhublVSSHR2NEZxMkc2RXBZQzlV?=
 =?utf-8?B?N3VFNHJCWERnQmxzeEdhWTNTMWpCMU12Mkd4Qld0eXRVdnhCS1Q2ZmliU3Fl?=
 =?utf-8?B?T0tQc3g2VUNJTlBUa2h1K0haeUZtRXBVcEprTDRqcExUaC9HYUhtbXBha3lz?=
 =?utf-8?B?RC9xSE56RTNOcWNSSk9GaVArNFVzNmpGZ0FWR2t0VWFiQ1prZTFYb1hCZE1a?=
 =?utf-8?B?R24xQ21wMVB5Z3RMbHVySksybjY0VDIydzN2c1RJblNLV0U0bSsvYUhIcmxL?=
 =?utf-8?B?b202ZFRLMmM5VlkvN0J0TjFoWlNmZmxrUzRveXhvL2VUTWxCN1BxbzRqcmNJ?=
 =?utf-8?B?T25ZUTFOZ3phbUtocTkzSjBVWGFKQTB6djQzZjB3M29DQ3p6RmY0S1k3WUcz?=
 =?utf-8?B?cDNzSGVNbUloQWhvcDVBaVhOWWV4Qzh5NEViRlBPeTZlRDNkMWRla3NRRWxy?=
 =?utf-8?B?aWZ0aXgySHVKSU9GWkkzWXBvRWlCMmFJbUZVY1FYN1h4YWxPZ3BmRlM2SGkv?=
 =?utf-8?B?T0c2QXkrdzZXS2NYZHVLYmlxWURzNUs5T1FLQnc2OXE3WTlpT29EOTRXV29U?=
 =?utf-8?B?U0hFVUhCbk9zUjZYT2FtdERQeUU5K09sSUNMUjZLQUJaeGZOOENERGJOb0gx?=
 =?utf-8?B?UXBKVjdzV3o2RWxKcDlnZ0oxTFYvSVlZa3hUd082WlZQSS9ka3djeDVxTlIw?=
 =?utf-8?B?Q2xhWFg4L1diRmI0YlI2ZXNmbHlVT1YyWWw4UGlIeGsrZk0vUmVBQjZQd2da?=
 =?utf-8?B?UG0xZThxU3FGSGU4OXJhN1ZobFFKMm1yL1c5MXRWZ21wYnFkTDkvWGZ0U0Zm?=
 =?utf-8?B?bnU2Zi9ZVnVadytqRDdZMFVvaXpKUHBIaWJLc1hCQzNXdEdiWjhJYWFicFZG?=
 =?utf-8?B?SmpUWHhPYjVQMEhjeDdjQ1pQanA1ZDF4NjlOeTRRdXlYdVZ3L0xQazRWbFZk?=
 =?utf-8?B?L2loUExTZWppdlZaT0VtUVI5SmU4YldIck9UcTVVbWx2M2lYdWNub3FrT25Z?=
 =?utf-8?B?ZnBuMkd1K3YyN3V0R0k2RWdzTk1EazlZQXlTK1BhNXBaSUtqeXRlS1NBeEdD?=
 =?utf-8?B?VnRFTDcvRmZSVFJ2WG1xUzJmQzB4SVZmOTRCZmNTb3huOUltU3lMd2Y1RkRa?=
 =?utf-8?B?Tys5OHdJVTB2M3d1ejVyT1ZrOGFXQkQvS2dubk1HVDdaeUUxYVBkSERwa2lB?=
 =?utf-8?B?dUVUbTRmRG5yVisrREJmVDdzTFkrT0s3UU9tMlRmanhPSkV5VXoydVZTVEIz?=
 =?utf-8?B?V0ZqcVJSUkZGdk9hQVZGVzF3T3BiWisvdkZ5dHNpaEorMzl4ODIvUXNYSkYv?=
 =?utf-8?B?V0VMdnFGbjdFZGErcDUvNERYUFRhSGNCVTdvOU85aFZnUzN0a1huUTdUaG5N?=
 =?utf-8?B?dkNoRXBabERuRzNjdjZaTzd6T1puTDUvdXJaZWIzRGJMVStNcmRFcEIrWXBr?=
 =?utf-8?B?eGJFdFNETEFrc1FtUmlnaXBGYVhpY2x5NzdkdTVYY2VIc3dBSlQreHppOVVO?=
 =?utf-8?B?NFRYdUVnVExDQ01oYmpWNHRla1ozOHlQZUNzS3ZBbTN6SUhtNzQvN1R6QkJI?=
 =?utf-8?B?Q0JTMnNrekU5NTcwSDlCRGNrcDIrd25pOW1SSnJHckpmVHlIaGVWS0tZbXZJ?=
 =?utf-8?B?bkRuMTV2RzFnQ0RsbHVqdFQ5WEUvR1BWdUZWS05KTjB0YXR0Wk5iWmVlZm1Z?=
 =?utf-8?B?K3FtL1I0dkwyZEUvaVN5Vm1ZMlhPNXZnUVJwNWNHZjFqQWxMTzg2clBNeDVG?=
 =?utf-8?B?S0wzZW9ieXhvbG1GZjd0cU54cG9zN0FJS1grWStlNkFWZjNjVnZPOEhTOHRU?=
 =?utf-8?B?ckxaWVhzck54VlBjaTJoMjh1elM2d3pEdGFJT3QzZStWTmlhdGsrQmRZRkxq?=
 =?utf-8?B?TlF5VVhUaG9vWmRVajZZZU9yN0E1VGl6ZmRtY1YzaHJFV0pmWVdOSW4yQWkr?=
 =?utf-8?B?amhWQzBvM05jMllCNWczMi8vd3hLb0VnaG1UZVU1VHZOODlvWDBGVndHMmtq?=
 =?utf-8?B?dEtYM2Z4Y0MzM1RqZ21UdnVvL3dDVXlhQ0NldU81T0o0eTZjdWJsNW9iTHI3?=
 =?utf-8?B?S3dGb2p6R2hFY2RqY2krbGhaQVpiZ05iRXNRdmY4Y0paNFROQzd5V2NqS2Vz?=
 =?utf-8?B?bENlS2pXYk00VjNKZUtJejgxQWdibFl1ZDNIKy9BcTh2WFQzN2xZVExISkk1?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2534f93-6565-490a-d4fc-08dd56ee8d8e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:21:13.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT62l5ULmiD1vZ8gmnVMrZGPjS8bIitsfpt5fYUuc7HG6TBXXcuPGdfyg29ptsUSfWJqVYBclREQSI1cmg7FOgFhDhzqzD43ctpGPcgr83Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com

On 2/26/25 20:37, Jiasheng Jiang wrote:
> Since the driver is broken in the case that src->freq_supported is not
> NULL but src->freq_supported_num is 0, add an assertion for it.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v2 -> v3:

please post next revision as a separate thread instead of
in-reply-to the previous one

please also do wait a minimum of 24h prior to submitting a new
revision

> 
> 1. Add "net-next" to the subject.
> 2. Remove the "Fixes" tag and "Cc: stable".
> 3. Replace BUG_ON with WARN_ON.
> 
> v1 -> v2:
> 
> 1. Replace the check with an assertion.
> ---
>   drivers/dpll/dpll_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 32019dc33cca..0927eddbd417 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -443,8 +443,9 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
>   static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
>   			     struct dpll_pin_properties *dst)
>   {
> +	WARN_ON(src->freq_supported && !src->freq_supported_num);

Jiri has asked for an early return too

>   	memcpy(dst, src, sizeof(*dst));
> -	if (src->freq_supported && src->freq_supported_num) {
> +	if (src->freq_supported) {
>   		size_t freq_size = src->freq_supported_num *
>   				   sizeof(*src->freq_supported);
>   		dst->freq_supported = kmemdup(src->freq_supported,


