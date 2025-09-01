Return-Path: <stable+bounces-176892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0876B3ECDA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE251B2112E
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EC30F800;
	Mon,  1 Sep 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+CnUrBE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E61E1E16;
	Mon,  1 Sep 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746135; cv=fail; b=VX4zZPebpUPo6rJNzfer9W2sznGlN/SzHvZaxSw6wi1tVMHbUUiVmssRgkMIKmtAmM4n64mKUjMlslyRdEp50PACR4p3lZD2Jg2AIQh0FwiQvheHWR5hf0C69SC1TkPW6ckw+4BdHMp48kkYvkAW2ZxUe/oyfEhylbCeXT65iiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746135; c=relaxed/simple;
	bh=ruFuNUk+xtwRvAUuonf5KQRO/vaCENqLupPXzYsNPPs=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipYKETcRtROOAONqqjJIFj48jLJ1zYlFjVOZERAt7Alq2/jAhXv2zsGlpCMbfQmF7fjhvFHteUlZvlWFuFEzqdDQ/zAqSAIg6TlvMDCRCOVivIbeanx8ic7o29v4FlB5ULOcBxPl3Hcu3TLFEfevA9eAveP0rkJmX8S/5mQOpow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+CnUrBE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756746133; x=1788282133;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ruFuNUk+xtwRvAUuonf5KQRO/vaCENqLupPXzYsNPPs=;
  b=E+CnUrBEjsalJ1pM8z7D8cw8BiwZ5ggWkYOPjFvX+HJd7t4XjD6L6Fx/
   a5IaFqti0Rs4S/hx41v6UWAotqdtl5LcGUPZxKyt3iqltQJTTCxYhExEK
   I34DYeNpp1HsFJ2HglKPy0cUnEBbUd2Wags6SwsstbbOnVxwPZydMdC54
   oq/lHKNOYgfJ7WMlKnZev1jj4ltq2FOseDATPzEhK/oSlcZW5JVZFCVP5
   U07DFEJH8zGoX3Wltkgx4fmVnJRczpWr7rc0H6/6ZF8jGE5J0w3zq8wI0
   /zYLMjwZalSG85pvt3EF5yjvo8WNnE2il0fi4KOTShRw1VhW3HLOk74Vu
   w==;
X-CSE-ConnectionGUID: drmhsME/T2qXEJdxgvoW1g==
X-CSE-MsgGUID: jjxh43YHSMybHgxoPgEtxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62842206"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62842206"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 10:02:12 -0700
X-CSE-ConnectionGUID: YQrEZIq1RMqaeBi8HYf9mA==
X-CSE-MsgGUID: zlROMWE4RYaVsFmAfaSHTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171511936"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 10:02:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 10:02:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 10:02:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 10:02:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBVt/LuGINBKIIxWMDdqZU3S3UmTCX/dtTUNIr+2f/sj1ZJorBvu+1WDmbstO0SunztQK7+bNuNZmFqMVbFJFkhfHYWnnGCdvHTVrQ3BpKMIxTIMw4+CIRR2ZFuGxuYRUNoWOoRhDQ4f5f2jc4d29Y79JJ5mzYBGCzhFX4a97opgCWxHAgns000CevNYiCOuAoDG5L/GuYF67I4D70SubAf6HGb7XEw5E0tn6ED+jaUfFBLVRfYc2ADpuKG7cgW4JWP4yk9rt3XAeKXj3fUCF6vcSsf1hLWHoomZqBl/tOks9dxGYhYITpwXuX+H7LEboqQzzf2R1UY6xgFLCacoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOQu8GriSFX5btBw4av8ObYxpJsFnu+mSCmPi8koOAc=;
 b=Yvu91YLtZOc8T1uSI6CTMWyz4P3gcPq8M6bW3vXBjFPucVzSFB9y3twXCBR1HjiAqlzxMRG3k0ipiE08hujR57SmkmKWHvP+ReoWjTOd/Z4hO9gi8rIGMnUdzIVcdEXqNEFOTqcSjtTgOqs8NsCde1kz+4cC3v+rzSzuh5cyAPdDpa3jjckqIjJejNY14DAMaPpcqPHzc2xLB9I/f93w8ZLn9oOuQ/J6DVZjtZTUmMPbeql1tlFNbVfmjTbm2jtpzfBlb5YvjQL21sFAek1mW/coHJWOcBqhdqrDzI8tGJMreoghNHM+0SgZAYz5kNZ/cP9SRRqsrro5us7ZEbLTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 17:02:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 17:02:02 +0000
Message-ID: <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
Date: Mon, 1 Sep 2025 20:01:57 +0300
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250901094224.3920-1-benchuanggli@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250901094224.3920-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0304.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: d88d691e-2b29-4115-5c68-08dde9794563
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGJnOVNlaC9pQlVWelY3cTIzbEF6anU1dXVkRzQ3VDVOdno0VzJwSnk4SE1Z?=
 =?utf-8?B?aWlWQW9HRlE2MGsxQi9vODZDWVhRQm9yNWVHK2J3K1RoNSt4enowWkZIYlRs?=
 =?utf-8?B?TGN2ZGhDQzZrbEF1TWVtUk1ISmVodGpTNGJOandJeElUVUo5VDE1QVdZQlEw?=
 =?utf-8?B?N1h5anJUTml6SVBDSmdqNmhQVlNDTWdzcDFPMEswcUxQOWk2Z2Z1cHljKzlQ?=
 =?utf-8?B?NUVENkNKc0R6YTMvWGEwekpYRWhwMm5Uc3VGbnRta2J6VzNpejhJUWpSanVW?=
 =?utf-8?B?ZkxIbDZSK3VSeCtsTktpaUllVUo4NWVnMlBrb25QRHBEOTRHNUl2c1pKTk0v?=
 =?utf-8?B?b05XbjVCcXpaVmkxb1hLNTNudWtPeTlYMSsyazJ1ZUFGN25jZEllbG9JODhF?=
 =?utf-8?B?b3lGUTJuaXZxY3ZqRi9IakF6M0VOank1aVZHdzVxNklveHZWdnhwa0RtaUpn?=
 =?utf-8?B?MTFWZGV0Wjk1ZjgwYXAwcVBEalFjL2dXUnNNdm8rdzNTc1kvcWk2TEt0QmpK?=
 =?utf-8?B?ejZzUFZ3MGZUM1RZZ1BSSmJmallRRk42TWhvcW8xck9QeE5xbzFMeG8wUXhG?=
 =?utf-8?B?RlJSRE1iWXNmejhrMHhod0ZBTHJFRERzeFphdldyQlkxckJIVEIrK2NuRmpn?=
 =?utf-8?B?dW85TUcrSXdjSk1yL2UwZjM4d1VGcWhPaUJYOTVLRzY5T1UxR2UvemsxSHZh?=
 =?utf-8?B?Y2FIb3I5dE1JWGRid1JPWUhNL1pwQ3JyYlM1aEtyOEMyUDkxei82b2RpTlhU?=
 =?utf-8?B?OW1zS0U5bGxjODl4dGRjc2hZZkcwVzRrS2JTY1E1Uzc5alBWOXYrekFyMjNt?=
 =?utf-8?B?Q2tlaWI1Vy9WWlpWTXJPd1pJeFpEd2xBS3QwbmZFZHlFLzB6OHFJUlVMcjQ4?=
 =?utf-8?B?d0lZVFJiU3FUaXVzWWNGL3JUNXNsLzFyd1JpNzNsVEorM2l5UWYzSTZaOXdT?=
 =?utf-8?B?Yk9SYkZHekRDQ1VtVUdSTDhra0RHOUhyT3c0TlJkOGFMRk0rbVI3YS9oM0pT?=
 =?utf-8?B?RTlzRjNyNWVkL29ucGFoc3lnTWpNNlJSeFhvYzZURTJJSHVHRnBsR0VWcDZa?=
 =?utf-8?B?NThwb3lzRkRhMWE3em9oK09WRXZoWkFWTld6ZW5HK2xIUGdjRGw1YUw3cmNn?=
 =?utf-8?B?N24wdHB5cDg4VGRKeWY1bUl6MUlqMS9UK1VDRVdWQjdQaTlROVFMbUZYYXF6?=
 =?utf-8?B?cGxWeDQ4eW5yS1BhRS9ITXNQL29oMmorMGRtOFcwV2FvMEU4bE5uWjRzZjFF?=
 =?utf-8?B?SFJKZEtoelFVcjdqcVQwaUlJWms0aU9GZ2YxNWVYN1JBNHE0SGM1UkRPYVNZ?=
 =?utf-8?B?WEIwRGhyVTROOFF1Z1kzUFNJdWZMeFU3alNBOVZlazRIdVlqd3F1ZUp6cjFV?=
 =?utf-8?B?YUxwRStPM0xMZE9WSWpHejQwS294bDJwOE1HOUZ5OU5NbW9ESUVPZStBVGsw?=
 =?utf-8?B?OEp0eDE2UVhuVkVicjdJOEVESmNuV2JWTDlzdXZLTmdlVDJSTWtkcFUwS01v?=
 =?utf-8?B?YVNFbThhUzZiNWVaZUR1MnRxK3RTbTVPNk5mbjZKcXJmR1A4eWJBREtPcUZt?=
 =?utf-8?B?TmpGdHp6VTZtOWVqZWZ6ZDY2WlNpVjlTUk83TTFDTXNPMDgwVFJiY1NNWmUy?=
 =?utf-8?B?SFZLa0ZUQ084clJHZmQ1bmo4ZFIrenk0dXRmZHNuaFRBVHU1TllnTnhVR254?=
 =?utf-8?B?M1J0YXV5T3V0WjcrSmNkOUQ0aWxCVjJQMTV4aWd3RVJlVFF2aEdTdjJkRm9k?=
 =?utf-8?B?QXhxWk40SXBUYkRSdEowNWpLTUVpWHNqZFlSVXpGZ1o4Snc4NDdvVlZGZFB2?=
 =?utf-8?B?NGZIZjQyTGdQSnVxdEt5Y0NHRFBSOUpEeHNPY3R3QmhwYmI5ZldUYlBGUFZx?=
 =?utf-8?B?a3UwejFYRFlNWHphZzVNdWlROHV0clh0SHdiTFJsQWt3VkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBDWXJJNWo1Z1VKM0lPVFVtRjVGTlV4UVlsZXJZaytrcVpxVWU0WDJMT2ow?=
 =?utf-8?B?TW5IY2JscjhLVlptRTVqOVprRjR3dXlDNFVUWE1iTDlqY0x1WjF6T2ZkOEhL?=
 =?utf-8?B?bVQ0OGVNdGh2UHM5cUFrckhRbmN2N3RQWUE2eU9wVVd1c3hKUmIrUlVzbFA4?=
 =?utf-8?B?MWs0SUtYTlMvMzF6dnhkcUdOODFpamdyOFJveDl3T3FrbU9jVktZTzNSZXhH?=
 =?utf-8?B?SVJXWUM3SE9YV0txZW03K1lQOGJLUWIvd0JpZ2JNUnhycmY1OSt1ZVBUZHlX?=
 =?utf-8?B?SkRrcGpDaUlUUFZXc1FhWHY0VEVpQVBqZDFjOXoreEV0MzJZY2JjSmpVbW9F?=
 =?utf-8?B?TG1yeEtUTUtMTU01TXU1SUFmaFRwZ2Y2ZVRJNDVZNDlNSzVpczZzMVlTSlkx?=
 =?utf-8?B?cnNHY1JnZ3MyeWdlMVY0eHppVWd0SkRnZUhDbDF3eE44TTZDTmlnaWFDT3lF?=
 =?utf-8?B?Sit1UUFjc2hoUjhyZUNYTDY0YmNqZVB6eTZBN29nYTBMVkRQMmgzSVpEbWtV?=
 =?utf-8?B?dkUxMDV3Z0JwaEN6cDRhZGc0dk1oczl4aS8wR3piZTh6KzhyUlNtTVh3dUdx?=
 =?utf-8?B?WDUrZzJMSTl0TlZ2OEhobDVSWnNHa09CVWlVNmRJbXJKQmovV3FYWHNWdEM4?=
 =?utf-8?B?amJTL0JLWXZtTStSdFNoZms5MlZMRUxnNWtkbjZsMDAwd1lRYVlLVTZMK1hT?=
 =?utf-8?B?VEVEcGxuK0NFYUdFQ250MDFDNzB5ek9FekxVQzVRV01ETHdYa252Qms3OTJw?=
 =?utf-8?B?bjd1TnR5Mld3aEllZlpYM283RXpGUFQ3QVpWa2U4REJ5RjRZNTI0VnJJSFpK?=
 =?utf-8?B?WSs0c0JNZTN0M2xid09aK0E5RXcyaXlBdWh5OFo3NFBmOHR5MytBdndhdzdr?=
 =?utf-8?B?Y3F3MDl3ODl6emtiUktBZXBwaEwwTG55ZUZBV1crQmhHeGlkN0Nqci9UUm80?=
 =?utf-8?B?OHNZamZMSHl0ZGFpVkhBV2xybXZidDErNGhUem9qbTRORFBwNThNWDQzQlI1?=
 =?utf-8?B?Zm9xN00xVm1BWTI0RHNLTnU1V0o1elF0WDV4cjNuQng3ckVQTXZOSC9vd0to?=
 =?utf-8?B?aW4xOXFWQzltN0hyU3dhZWVyTVhkakVaNW1YZXZSVFBOWE1oZnJFWlBwWnk2?=
 =?utf-8?B?TGhhakJCOUtoblQ5aSt4Z3V4cVBjQ2xjNlJjMGhUTnRVS0NiZ0xhY1JPMW40?=
 =?utf-8?B?OXZGWGUxYVlVUXJLb3B4c1QrQWUxY2Y1dWdraWd4akFucnNWYkQvbWRzV2Uw?=
 =?utf-8?B?R0hQK3BDWGVlRXdSclg5Mnc5MmI5VmZPYVAxcG5mV1h1dkhUNzI3WnZyK0U4?=
 =?utf-8?B?RlJqNmNyemtibWdUbXI2QXdENDYzc1VjQThIQ0ttWWlCSWRoN3BWYkhQUVlW?=
 =?utf-8?B?L3F5NE5GQzNPa2pTTy9ETTdvTUJsWVRzS2ZwQlRidXZVMW40Q25sUityQWJk?=
 =?utf-8?B?S1oySUkrSndvMkppS1hXK3JGY1M5cGt0OHBwL0pFbjZTTk1pVVEyK3dxYmlM?=
 =?utf-8?B?RWl1VktEZjJPTHJhejdTV0xmS0ttYXNBaXhCZGdrQmZpRjdaZHY4TUhhUVFV?=
 =?utf-8?B?WFFaYVhTckREeitqaWNnODVXWEF0NGIwTjgyYTMwdzBmYU4vbklrbVVLaVE5?=
 =?utf-8?B?KzAwMnNuY1JBd1ZXRWhLL01leEs0RVFZcjJmVDZrS0Nza2RLSnhVcDNBVTcy?=
 =?utf-8?B?SWRsRzI0VWRFNDFhNnZqSjk2T0oxb0tZMzdya243Y0pBK3dkRzhoRENOVXF4?=
 =?utf-8?B?T01HazN0dnIyVy9sVGpaemlIVGhuZ3pHMytOOHA0QkF3QUlibVNJQ2hNVWpk?=
 =?utf-8?B?Z0tUeWVudENGSE51ZmVia0EyZHBCbW5TS1FEUjdoellHd0pvNEdydFhZejhw?=
 =?utf-8?B?RVlhOVhma3JUWDlwTEw1QjhmbTJsSGxwcnNocHFOczFuQkdtWXU3d1cwS1F3?=
 =?utf-8?B?Y25RSUU1TkI1eVVkUWQ2MlFjem1vNnNYWENycHkweXB3ZFFaWXUvcHRlc0xh?=
 =?utf-8?B?N0hnTHBWcThlYW1TWmtzaDRBdndDTUVad1FicEdQZXY3VDJKYnhrTEdBZUNX?=
 =?utf-8?B?VUFQS1NZTk00d3RZdElaTi9oSytjc2JqSFNuZmRyd25FRmFGbE1CbVgxTVFX?=
 =?utf-8?B?bWFWSjVES3dsY1ZJM2E3V0k1amNwUjdFY0M1MjhHNVVaL1JZN3poMEhBcFNK?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d691e-2b29-4115-5c68-08dde9794563
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 17:02:02.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OShNklBi31JzwTsK8E0UBRIMMZXT4oWJbaRUuTGZIfobqjSYdecaUuebMlPyh89k30dfxZ2euyvH4xDo/qGOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

On 01/09/2025 12:42, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> According to the power structure of IC hardware design for UHS-II
> interface, reset control and timing must be added to the initialization
> process of powering on the UHS-II interface.
> 
> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 71 +++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 3a1de477e9af..85d0d7e6169c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -283,6 +283,8 @@
>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN	BIT(13)
> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE	BIT(14)
>  
>  #define GLI_MAX_TUNING_LOOP 40
>  
> @@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
>  	gl9767_vhs_read(pdev);
>  }
>  
> +static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	gl9767_vhs_write(pdev);
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> +	value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	gl9767_vhs_write(pdev);
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> +	value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;

Maybe add a small comment about PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE
and PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN being updated separately.

> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	gl9767_vhs_read(pdev);
> +}

sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_deassert()
are fairly similar.  Maybe consider:

static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
{
	struct sdhci_pci_slot *slot = sdhci_priv(host);
	struct pci_dev *pdev = slot->chip->pdev;
	u32 value, set, clr;

	if (assert) {
		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
	} else {
		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
	}

	gl9767_vhs_write(pdev);
	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
	value |= set;
	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
	value &= ~clr;
	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
	gl9767_vhs_read(pdev);
}


> +
> +static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
> +{
> +	u8 pwr = 0;
> +
> +	if (mode != MMC_POWER_OFF) {
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr)
> +			WARN(1, "%s: Invalid vdd %#x\n",
> +			     mmc_hostname(host->mmc), vdd);
> +		pwr |= SDHCI_VDD2_POWER_180;
> +	}
> +
> +	if (host->pwr == pwr)
> +		return;
> +
> +	host->pwr = pwr;
> +
> +	if (pwr == 0) {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +	} else {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		pwr |= SDHCI_POWER_ON;
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);

Can be mmc_delay(5)

> +
> +		sdhci_gl9767_uhs2_phy_reset_assert(host);
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);

Can be mmc_delay(5)

> +	}
> +}
> +
>  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -1205,6 +1270,10 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  
>  	sdhci_enable_clk(host, clk);
> +
> +	if (mmc_card_uhs2(host->mmc))
> +		sdhci_gl9767_uhs2_phy_reset_deassert(host);
> +
>  	gl9767_set_low_power_negotiation(pdev, true);
>  }
>  
> @@ -1476,7 +1545,7 @@ static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,
>  		gl9767_vhs_read(pdev);
>  
>  		sdhci_gli_overcurrent_event_enable(host, false);
> -		sdhci_uhs2_set_power(host, mode, vdd);
> +		__gl9767_uhs2_set_power(host, mode, vdd);
>  		sdhci_gli_overcurrent_event_enable(host, true);
>  	} else {
>  		gl9767_vhs_write(pdev);


