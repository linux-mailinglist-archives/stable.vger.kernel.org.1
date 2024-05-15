Return-Path: <stable+bounces-45235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D178C6DAA
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4601C21E38
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469DD15B12C;
	Wed, 15 May 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDxtLu/+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDF2F877
	for <stable@vger.kernel.org>; Wed, 15 May 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807814; cv=fail; b=Oub30Dd583MbOnzRfP6HuWUeNBPCjbQFqnnri86ahYZUv/3/ULK2jyQWUH9qzcZ0G4i5KfGbbFk8pA+chmWrTc8GIZwpSule+AmQxC05LD7wQioMgo9EXOARA3E8dEPtRisLnt4PHrZJIQ/AKITiweJcZ6m7xYhd6XGTVULN9pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807814; c=relaxed/simple;
	bh=ol0A8mRbQmWLEcqSEg2TVDDU47u6TJT2BGKKvd353H0=;
	h=Message-ID:Date:From:Subject:CC:To:Content-Type:MIME-Version; b=DYNsHEbgbTZJgp4Txq0cRsnUpgrpkPLhEiPakjSGsdA1WNyyxNlRG3vEYlMFTbVXTBZgziW4ThNsUuTvzj/2h4Kc7tEgAOkeFZBh8afJc+wgVRCsdrqzuZAOFPJNP4pYXtThOE7AvR9JbibWamc+HB82gKWZpX0CLHt9XkhCAkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDxtLu/+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715807812; x=1747343812;
  h=message-id:date:from:subject:cc:to:
   content-transfer-encoding:mime-version;
  bh=ol0A8mRbQmWLEcqSEg2TVDDU47u6TJT2BGKKvd353H0=;
  b=EDxtLu/+E1o4RJGxrzObAO1qVGXh8R0E+L8ahLGEZC8L8nST+vWT6Us0
   ddfR75HDJsTDIk8E0j+7F16kWV+WOOCLwIuYwzPhaN6nQhDV06pmk5UyS
   v5N1ss8yWDvYcNOi/lxhkM5V8Pq2Ey23jGsB99xm5TXOc8pHXWRp5XQQV
   hYDfMBZm+srLyZ6gLRBvobcyO63jLvLrZBumtbIkHOqHN2SPYUFlZlB8u
   XFHSxIVDDK5jq7g7z3BcRPQVGoLB6I2wtOsdPl/mpw8pTFPzy/DaZOh/p
   wMZ0Hotk7coufpCQAfj8X50Sqya+ts0+Q3+uq5xTLmLZP7C/iap4ZpiAl
   g==;
X-CSE-ConnectionGUID: 2UVlmb8yQx+Aw1ni8qChVA==
X-CSE-MsgGUID: AF6REfumT8CfFF1G0VVqPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="34396682"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="34396682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 14:16:52 -0700
X-CSE-ConnectionGUID: t2GLrDFoQ6u+0G0JJ+3p7A==
X-CSE-MsgGUID: aVJrLoYeRpqpa7cT7/N+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31768805"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 14:16:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 14:16:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 May 2024 14:16:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 14:16:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 14:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nvu8wEK0JgcBE0fDBBG8O3lcE1NngsSaPLIA6A1JDq1uBulYcVjzBom2xtGuPhIWVfGMBd7GonyxRtEUYhHGbDktPy4GeOSj1MSzrhWz00x2kTdxotj5f5cotO7RRp8l2MvsEHq5ti/1LMtevIYwUMc5VDrMiqrwyP9iw3dCtPiUjWmvFl74AR/dC4V046xrfZkLBZKUbOOjEWaxlUUZQTRiS69tqESbSumgP26IIj2EO3fbPVbuZ9n9l8uL95/ZMRBMME3C6yoZS1njeHC7WdXrAr72+QIv0cIQlfrTbYZrFYZBgkzUp9sTSsAW5Bo6+WJXWE63d4VKoXSYgZj3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h8a5rGZh9sAZSwb5qADndRLqe/u83xeoBOZsiLzBvo=;
 b=oDgdWXBNkELLWRfnn12cF/yFdVXKzMidrSHLRmQ0fSV1cqGzuZqHX5/XRB6vGcchZEof+mJKKCYIrNrikOb9tvNsWUYwoovaxz3AB+faADE7Il4pXAUI3enmt9AfzPdpGISflyjpe1ahomrSYH4+20c5L57D/BmKnod0oJbaB61vjEPkxXU4epi6fdhVZ5cHvAmXA4yJbRqVJrkxVVPzRSC9KjQ9jY2guBHYitjpcx32J77XgS3SYYQ7yOUkaV8CMqpyZvkdH9SHBxksWqVxwePFpXYqRQ8ZMonMFu1sTURctC5QpG3sIJZCEDKFl+Hee+D3FD55azAm3xWqO/XzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 21:16:48 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 21:16:48 +0000
Message-ID: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
Date: Wed, 15 May 2024 15:16:39 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Fix Intel's ice driver in stable
CC: Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:303:6b::21) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: c6123729-10ff-4f18-c6dd-08dc752454a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0R4ZTNlMGl0YjFEZTcrZzA5dzNhak1rWUNzWE8zYWFIUk9mcks2amxYWWpN?=
 =?utf-8?B?RjNRQjZneC8xcXowQ2YyUkVPZ2xKa2ZkR3M4OUpQZFRFdXJud0szMVBoQ01J?=
 =?utf-8?B?M1E5dGh5Z0xyYmJXYXlXMzd0cHU2VXM5dmFnRVRxNVNSUnVIc0p4QXowbnAr?=
 =?utf-8?B?ay8wT1JTQTM5VEJOOU1sV2Q3alNXaFlkd0p5NFY5NTRHdmJmN1h2SENPVkFL?=
 =?utf-8?B?bml4QkVLbFc3ZXVMQ2h5eE8raHd6VnVwVHp2V0hJTjl0ay82Z3NjNTA0MkMz?=
 =?utf-8?B?V04vOWFrWGtsVkxjSFM1b1VYbjhONndDUzdIUW9TOTdoUnM3bzdJcTB1TFdx?=
 =?utf-8?B?NlNuN3BaLzNnMUU0UW80Qy9XS3lyRDNCT3BuYmIvbDI1dzZhdGdrK2NaZ0xE?=
 =?utf-8?B?em83VlVxZ1FoT3ppWHJselJ1cENncFFKTzFGOEp0aWdNTjMzNTRKcHVUdFdF?=
 =?utf-8?B?anVHN1hlU3d2YTIxL09IUm9JRnAxUnQ1VXkrRXZ3ZTZKZmlRb3MyQnhDSkFh?=
 =?utf-8?B?ZEo3UENhQlVwS3NReGl4WXczNW94TU5YNVc0bHhCdi9EYndTOXVyYkEwUzQv?=
 =?utf-8?B?SEQ3cmFERURLYjFQbFdQU0JZM1loM3R6NUQxaTRNSlE0VW1aeUljN3ptbDlL?=
 =?utf-8?B?ZFg4dllQVU80Nzl2dkNtVk9sWmhGZmdXTnJubVNWRmkyMGFySkNBVGhlSlRv?=
 =?utf-8?B?ZWF1d2pvamwvZlI1OEFDT2UvaGtBTHRLK1M5dGEzaG92dlR6VktTL2hYVWpr?=
 =?utf-8?B?amdqNkk2N1JKNFgyV2F3U1crSFg1MUZ0YkZTK25IOEN3UktjdmtRdFNFODZz?=
 =?utf-8?B?VDdheXRvc0xObklJbXRJZml1VTRtOTVOOTl4VFhXTkJoaFpHeVl1VkNpWFBw?=
 =?utf-8?B?bHVpUXkwLzNRU1RPS0lqMXNxbHBweG9OR3kydno5L05nZlZ3ZWdEMU5lTTRV?=
 =?utf-8?B?U0lrdVkrUE5IeUVxTDgwZlpISlY3SE5MSWd2TXRzNnRrOTRtUzBJSHdOeDdT?=
 =?utf-8?B?OXdGckxBOW5EZ3ArT3d1S0l4c2RBTHhRNUovNzV3NGZma3M4Q1FZYVJjcGgw?=
 =?utf-8?B?clQrNmo2Y2s3WEFaVExPWE0vZGpseitQL1JiNy9FVE1kNGNMRHV2eVpjM3ZJ?=
 =?utf-8?B?VlBhelAva0RTY3lnRkJmOUl1Sm5nMVYrK1p4V21wZCtMM1gyTUNBbG02Qzhw?=
 =?utf-8?B?QkVlZTVCcHBYeThDUWhQNUE2UU9icmpQQ2tuY3c0L2Z3NEFlSGVwb21SdGUx?=
 =?utf-8?B?R1RIay9kRzBtNTgrWE1yUTRNanVVWUNhZW1WOXNZQWs0RHA3emU0VGlWYStm?=
 =?utf-8?B?VkNRZEtaRlhMbUVadVBCL2FUdlNHVDFsaFo3M2YrUndRbnJBc3FnamVySzdI?=
 =?utf-8?B?bjFRelRTTnhhaHU4ODdvT2lKZ0ZiMnlKeFhFMHRrYkhmVWRKd3BCWjR4a0tv?=
 =?utf-8?B?WDFDZ2xFWmFHSURBQVRpNUxPZVpYVGZlY0dndHJvLzRxRGZCalhtUVYybXlG?=
 =?utf-8?B?QlJSYmJyajgvemZQL29xWTBqODVRbDh1c2JjbGZzUWR5TFdWZk1pdU9Rakha?=
 =?utf-8?B?Q0FMY0NhYldEM1N1WjVJNG1MaE1VUDZCYzFLY3kyQXd0Q000UlFwTXZod0pa?=
 =?utf-8?B?Zi8xUThyNEU4KzR1VTE5Ky9ydm1ld3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRYRHkzMlZYN3VaczJ0dW5tUEtSVlBDMHA1eDAvVGx4Q0pGVWt2TnIzdzQw?=
 =?utf-8?B?SWI3cFJQZFM5b053TFFhbkJ2anJ5Rm0raWpJL290Mzl5YW9yZUE2eXI2RkJP?=
 =?utf-8?B?YmFGd1NMdkFlR0l6cW1HaURvZmJjeUJLcnNhRWR0em04aHF2RHZFWVZ5TFpi?=
 =?utf-8?B?eVg2UDNFN0Evb0dvd3NwbS9nSGwvb1NUamlIL3ZhVTdIdWFwaFN2cUxyZFlW?=
 =?utf-8?B?Zlh3RUdOTU56OHR4bFNLQzlYT0pDaTFyOVZhS2llSThLcUhWYWRNRnU5MmJy?=
 =?utf-8?B?cXBMcnVTNldpOUZtNjBNTk9DOU1YZ0g5QkpzSzRlNHE1Y2VueWFibGlDWC9w?=
 =?utf-8?B?dWllWVRxUklEcEJFMUJWSTNWN3gvcEZmT1Njb1hyeFIxUVZ4amozYlRZN0xU?=
 =?utf-8?B?RUs1RkhoUThRalA2L0dqUlhHVVFVaHJLdm5mdFhvZFFvRDVOSTg3TnF5UUI0?=
 =?utf-8?B?TEdwNzF3QXcvdGNodStvRmVPZ0hDZnNGUXBubnRWTDBMdmdibEMzZzRuMTdy?=
 =?utf-8?B?N1ZRNldYNnlxK0N6UXZFemVtSlVnRlozL1I4elRiNlFocDJDZDltYnpuRkQ3?=
 =?utf-8?B?dmZKR3RoeVczb0JjazFOeTlQaFVML1pFUzMyRi9Qa3lFOU9MVHYydERheE1P?=
 =?utf-8?B?SWRSeit0eUV2cUFneU8zZTE4TEVYaG1helNKbHNMaXkzbEVLbit6eDlRaXJJ?=
 =?utf-8?B?ODkzSThoaHFzR3VyUHJuUXFlOWsvNzRLLytBMWs4L3cwSGZVelhOWWJUL3gv?=
 =?utf-8?B?eTJTRUZ6RVQrT3pvSm9wRURXWTk0T2xhdzA2TTZxRFhOQmFlTFlhUnJ3dmRG?=
 =?utf-8?B?M3JxWGhWNi81WWtndDN1bkQwRlFPYXFoS0VaaWRLdk1Uai8rOEdScWZPOGl6?=
 =?utf-8?B?MEE5S1J0dFZQWlM1TW9MTDNLTGtwcVZ6UW5XTmJxa0ZWN1h4T291ZzNEWitO?=
 =?utf-8?B?MjY1WVJTZElhVTBWSUI2Uk9kbS9ya1BDVHdJV3FIa3hwMHp4OE44a0xXYnZ0?=
 =?utf-8?B?WFF6L244QS9LN0tTaENDM1dBa2txdXBObUNYTFhCUEM4NGFHTktjbjk1VXds?=
 =?utf-8?B?L3Q0dExDMVhZQjZyaDMzVng3ZXJ5RVN6aFpXRThiUEFXYndnMGNQSi92ZWE3?=
 =?utf-8?B?OHZsS3R6NitaSEV0U2VsME1WQ2h2ZTFqQU5mbmQ0TVhDVXhGdHhUS1pIUGh2?=
 =?utf-8?B?dHJqRnphTVdHVWlaa1BsMm9oUUtXamFQOUVmNjZzMGZZY2tReUR4UkNrWUdM?=
 =?utf-8?B?T01GcUozVzVpTUpVdEVpTzBaekNFc0NodEtXU2cxZzdBQU5WaEtKaDhSZG11?=
 =?utf-8?B?VnZZWnBuNHA3ZjAyWXh5VU5hUE1peFozK1JtT3U1Q3ZUdzg2ZlFaOG9PUkt3?=
 =?utf-8?B?djhySEZRMWkycWRPU3h1TEpnSzBqUFV2eE1nbHB1UTQ1VlV6NXFSbFhkY0xL?=
 =?utf-8?B?UVR1UkVrTm1oa3hKeDR2a1RzUjE1eERCS2UzY3FMMFRvN3BTMkVtMXNPU29a?=
 =?utf-8?B?YWtrYU9ObXdpM1NVbkJhaDZnMHkwenhGZTI0ek9ZVWcyVjc3NUpiSG00UEl1?=
 =?utf-8?B?TTRJUllSdGp3MS9JYTZQaGgyRTRleGxQUjl5NGZRU00zcDlHZEgrU3ZranU3?=
 =?utf-8?B?bHBLRCtuMnZJdlgyZ2FTS1pkVllTMklvQlZwdFNhYTFTVUI5Qkp4YU1CL3hB?=
 =?utf-8?B?NWN4elFNRktYY2llME5sVjFBYWpzSVFYWWhTMTlMbWRJdXQwcGxDS0YwQzhY?=
 =?utf-8?B?Yi9KVG4wdTNNUTNMM2JVWk42blhpVFBXc09vT1REZXRmeHkvVS9BZ3NmWWxm?=
 =?utf-8?B?bTcvSDB3K05QMS9LS0NqYkpIZFRBRlNTQ1JPc1Zmd1FwWm5ZYStubmMrM2Rj?=
 =?utf-8?B?Wm9aZm5XdzBmWDhZVHZLMnc5M24rWVFZTktwcERUM2w1T0RpM2EzTWdGT2ph?=
 =?utf-8?B?blloT09rb0F6VklkR08vZUEyRUErdldscHdjU3pzajJLVlNHVk9ySjBIZ2FQ?=
 =?utf-8?B?cjltc2pHV2dYa3hPUkpDc2drblZqWkR4Q0NSRkVNaytiNWRsa2UxWUNJbUJ0?=
 =?utf-8?B?ZjdXUlZMb004bHBvcXF2dVBwZmFJaDhBVnB3cTNwK1BIakNBTEkwV3p3MG1k?=
 =?utf-8?Q?J45OBnIwH1pyeWsO5pdeDQLhT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6123729-10ff-4f18-c6dd-08dc752454a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 21:16:48.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea878mDDBrsGJ9Lasc2hHg4nrsRbDap1X9MzS9QghGwSje9I8vK/xlcjHL5+KMeRtOujg+IiuoKSS3YaAXBV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com

Hello,

Upstream commit 11fbb1bfb5bc8c98b2d7db9da332b5e568f4aaab ("ice: use 
relative VSI index for VFs VSIs") was applied to stable 6.1, 6.6 and 6.8:

6.1: 5693dd6d3d01f0eea24401f815c98b64cb315b67
6.6: c926393dc3442c38fdcab17d040837cf4acad1c3
6.8: d3da0d4d9fb472ad7dccb784f3d9de40d0c2f6a9

However, it was a part of a series submitted to net-next [1]. Applying 
this one patch on its own broke the VF devices created with the ice as a PF:

   # [  307.688237] iavf: Intel(R) Ethernet Adaptive Virtual Function 
Network Driver
   # [  307.688241] Copyright (c) 2013 - 2018 Intel Corporation.
   # [  307.688424] iavf 0000:af:01.0: enabling device (0000 -> 0002)
   # [  307.758860] iavf 0000:af:01.0: Invalid MAC address 
00:00:00:00:00:00, using random
   # [  307.759628] iavf 0000:af:01.0: Multiqueue Enabled: Queue pair 
count = 16
   # [  307.759683] iavf 0000:af:01.0: MAC address: 6a:46:83:88:c2:26
   # [  307.759688] iavf 0000:af:01.0: GRO is enabled
   # [  307.790937] iavf 0000:af:01.0 ens802f0v0: renamed from eth0
   # [  307.896041] iavf 0000:af:01.0: PF returned error -5 
(IAVF_ERR_PARAM) to our request 6
   # [  307.916967] iavf 0000:af:01.0: PF returned error -5 
(IAVF_ERR_PARAM) to our request 8


The VF initialization fails and the VF device is completely unusable.

This can be fixed either by:
1 - Reverting the above mentioned commit (upstream 
11fbb1bfb5bc8c98b2d7db9da332b5e568f4aaab)

Or,

2 - applying the following upstream commits (part of the series):
  a) a21605993dd5dfd15edfa7f06705ede17b519026 ("ice: pass VSI pointer 
into ice_vc_isvalid_q_id")
  b) 363f689600dd010703ce6391bcfc729a97d21840 ("ice: remove unnecessary 
duplicate checks for VF VSI ID")


Thanks,
Ahmed

[1]: https://www.spinics.net/lists/netdev/msg979289.html

