Return-Path: <stable+bounces-164883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3AB13522
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666AF3A5F56
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 06:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574F221FBD;
	Mon, 28 Jul 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad5iiP//"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F02C18A;
	Mon, 28 Jul 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685731; cv=fail; b=OettZ/vfEZpIrFRENyi7hYydnju+6QufoiznPYzRRmtsDGT/jFpG0dlJiuECaWUvzkbMbmntcFID8YcsnfSxV52Vj6mleQsBEzy8GI/14A2zCyomOmWHun/TQjP9qsYbnxS89koR6Y/XD9DI8JiljXCU8GqYYB8VwEz70r2LIg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685731; c=relaxed/simple;
	bh=SVFtvKvmeW7eM5r5g0kzQojRzdbXLHCp5RbqNm1C55g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhXKd8nT9EJb69hPsGKtNzHlHelDt7Dtl0Tq3OJPZA8HDUuBlot+KEum1y3CyRUt0NCi1D3NVR8j1j8mX/pKDimhSxx21Qp1sowrnPfrNFpnZDDpXOM9rjpQPAOXrUdVjiCHndeYVPHSOR7GsImNROTEaIDsBA2xuG3IKVx4NRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad5iiP//; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753685730; x=1785221730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SVFtvKvmeW7eM5r5g0kzQojRzdbXLHCp5RbqNm1C55g=;
  b=Ad5iiP//glOy5dsnl2+Pj6xQema1KDJ8Nof1HWu7aT+9MqwNlbsyVILh
   7jfKnYvgkSRxVbutFxRRntii9tfpIhZAIrTBfLEh4GiZyxNU8SNzhNhD5
   FI3aCTd9KdV4i+BLPIKBfRh4Gk2p9PSxScmPihjgwJbV6yz/H4Rwlw5mN
   2CFQgV00Hx5EEctT1Yje+JePrdcpwojZ049TW53du+6mEMtcbIH+p1TaT
   7363BYCYeem7Lnc5ZBcVthDXRmLcCJcVU/0DVTA8IZYk+OF0JEjZhEis5
   kBl2QfA9cX6JvR6TPpFiquMkLM4fzww1tYWhr66yF+PVUiqhQWzUvtv+I
   w==;
X-CSE-ConnectionGUID: Og0jEfEjQCuBOt4548aQ9w==
X-CSE-MsgGUID: r6sc2u9ZRWOBBWOo1TIJ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="67277017"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67277017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 23:55:25 -0700
X-CSE-ConnectionGUID: R0HWB/DnReyFewVe/WjWPQ==
X-CSE-MsgGUID: 2eVZvGj7Q9imcqvDPD4y4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162211100"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 23:55:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 23:55:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 23:55:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 23:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM98Hs7pXq7zHyNIWzN4uCtB1poT7bEPkcmR6phFDBQXI2gHrA+hDDMlU4f0Uk8VCoS0p+eBTo0oupd8UIuf8xj2YH6HiOHmWLt+lCUfVsvtZ9U2gQhYWy1u1mbGGf/LoP6mn4v9q2hzqeNlVEfvt9r7Dv9dcUrfcBTq22iG356I2wUb1fF2HvAWDTmlbpkZBqNWBCVqZMCaoB0JbCAOWC49SuseMjxS4HebjbCZIjD78ORJuYhU9QGk0MNrZqMj/4WR2lEgW7Of3GPHrL7MVF6ChtXadVnwaK8dKp4BObjS2ja5RnqVL5K8Od2qfyLg2b+nfeUsRKyTeFs7wuU6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8F4obGTNgbUO8ihgb6MSUVlA4X33pgaV/aemLN8IiQ=;
 b=ROiqtfZh4lZYxFKCkrNyA47pgZrZ0IRa2P3Bqy/sEjSSyIhoqxAkt3USR4QXY0RclpldUZrMH4iQDTyWYkLYR6IAYVyDy/UB7Tx6Gv+Wgd6LUHBtEm/MLpxZGoPEABtSaHHDlHX1Rx5ZBWhhipROupUPz2YegtaGp9v0ypveHR7zjcjkxnPTXDzet4Q1tQHhpnX9g/+zSWwGhvjqiTbOAfA/y6THm7Id7nSVPpyVUYxU2/H7IdAeA4bXKxxGqwkw6R0YWBI5qKBdLzbsh/PtA6Mo97A9091idF9lQDMnr7YkX1yRgrxm+SnSIIp5YwvNtd2ag5gXR3HFHAV9BD1lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:55:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:55:19 +0000
Message-ID: <900a4f9d-a995-4142-afa0-b06012854ca3@intel.com>
Date: Mon, 28 Jul 2025 09:55:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] mmc: sdhci-pci-gli: Add a new function to simplify
 the code
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<stable@vger.kernel.org>
References: <20250725105257.59145-1-victorshihgli@gmail.com>
 <20250725105257.59145-2-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250725105257.59145-2-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 41295e7d-f3fa-4e74-bc71-08ddcda3b6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVhrNlg3cmltamJYSmVkUW1lZ3Z2SWRndmNITnhZSmpVWkxMUExlem9xZ0dO?=
 =?utf-8?B?b0pSVjJwblRHbmJRbGpjcStkcVpxZThPS3lRVTVQV05zeVdtRlFlU2Fnc1RR?=
 =?utf-8?B?L0lLYzVJQzMzTFNldnVQeTE5VXNNaW9XVEN6NXpWNjJwaUpZSjVhM3NGaXcx?=
 =?utf-8?B?MUcvSGM2aWRsQzJSc01wbC9FclFzR2hyOGxDWDZIUlVFaVdZVmw0bXhUcTlp?=
 =?utf-8?B?eXFEMktTbnB0cGdlZE1DcVpFbndoZDVEUE1Da1E4UGhDUDMwVGx6ZlhrQXJy?=
 =?utf-8?B?SlQ2UVY0Wko0Q2lDYk90aitES3VWcnp4U21mNjhvcmVwcXlVek5mekVoZ1Vi?=
 =?utf-8?B?RmZXS0FMQXZEQjNCOE0yNGgxbHlyU0YyS3pxUXMweklvMUd1L01laXRUOEtC?=
 =?utf-8?B?ak5LR2wxMU9TMk1HbWF3dkZ1c2pLSW5JTllQVDRhVnRtSVg1VmJnUEorbG5H?=
 =?utf-8?B?NFJFcmVZMXZKTzAxREhqcnFRbGhWMnJhcXVtdVBxZUVRQkFwY3ZmczUvbFZa?=
 =?utf-8?B?amdqYlRrYmhPUXRyT0R4WWw3eHYrZkpERjQyaVFud0RBd3RMLytxY05RdERj?=
 =?utf-8?B?VDRZRStTVm15eGVlVTRxV1QrcUxVaUdMUkd6am5ia3hLZFNISVhZYTZUZkNB?=
 =?utf-8?B?MWp5UXN6OFQ1cE53Z09CUnordyt3RHl2TTQrRGl2YmVYMUJpbGRGQ2RZdXow?=
 =?utf-8?B?c3hXV2ZoUUNUVjhuUTdqY3o0ME9nK1ppb1ViQXBCVkFaMHFEamlaOU55QVdV?=
 =?utf-8?B?ZllCYm84QUxDYzZCa0pYYUZJdFRuTnRzYWZOOTAzUFQxUmNGQ0prQ2VTb1Jl?=
 =?utf-8?B?dmZiM1ZObGZrTzJPeDRIbzluVld1cDhtYzlkbDBLS2xpZXBzeTJscXowbFZG?=
 =?utf-8?B?ejlVeUM5WkkzeUQ4cFFOb3F2NDhqV2FhbjdtZ3gyTEFCSTN2VXZPVU44VEla?=
 =?utf-8?B?MlVjUUVucExZTzFielUwTStmR2xjdmxab2UvRVhueDNLdEl4M3loQXI4Tklk?=
 =?utf-8?B?SFg1QjNKK3pONDZIcjExZHdiQzhsZWVYaDRibzJsYmNjZVR4NHAxclpYb1I4?=
 =?utf-8?B?MGFkWEx6TENBT3IyOE56a0ZheC9PWUpPcmlDQWc2OHlwLzBrbGdaU0RiU1gy?=
 =?utf-8?B?eWN1OERoN0w5a3R1WEo4ODliSndmYkVSSlFJbWtJbFhqRmNsRk9KVlhMcTN4?=
 =?utf-8?B?eWJRb1RsbXhlMXpJeEVyZThNMDRtSklERFdNK0VtNWRta2YzOFFrYUZPWlNW?=
 =?utf-8?B?UmJ1cGRjZkRzV2VWUUN5NzZ0TFJOU1o2aU9wZllqRlVwY2tENGM0bmg3UGdX?=
 =?utf-8?B?Si9qbDl6NEV1SkQrd0JIWG01TGtRb1I3ZU12eWc1dDlOdjV4cEJCMnB5OVd1?=
 =?utf-8?B?UHFyR08xcURseElPRXo0YkMzTUVPOXVSZlF2OVdnZkVyb09oSFFRTlJWOXl4?=
 =?utf-8?B?bDNDY1lDK0RIRWFsaGc1OHdSSDQreWpwVDRQUjk0WlRkL0pJZHdJYjZyZitN?=
 =?utf-8?B?NWVaSEhxWlFPSXFQd0dNb3Mra3h5bVo2bnVVOExtR25TUXdWU2FQU0xYY29O?=
 =?utf-8?B?Z0tBUGsyVXZxZUFEQ0lacTg0NTE5R1VybTY3RDdQMDE2Q0lrWmhkcXdHbjZw?=
 =?utf-8?B?ajVTTnFJc0U1SGpOR3NzZXptbnV2U0VuUU5qZ1BCS3BrbWVCcjlsdXU0MFp3?=
 =?utf-8?B?VWFZejZEM2NVV2NCdjhtWnpwTEp4Zytpa1FZSEZ5U2dGcGtwSGNiM00wOWtu?=
 =?utf-8?B?VTdVb3JhanoyYkdsdmFHekhsVFM2OFBDeE9DSDlJS2FrQ1MwODF3OGN3QXQr?=
 =?utf-8?B?ZitUY2xQRmh1SU1iMmMxOUJDYUo2SzR1QVdDQmlIUzIvREZ6bVN3VUJkVm8w?=
 =?utf-8?B?NHM1R09SL0d4WEx3MWJzZHJUNFFrNDR5UlNHZE9qOW9LcGVGU2duYzh2NHlS?=
 =?utf-8?Q?Cu0ofhIs0rY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anoyWm1sY0hrZHpWTUxuSXAzaWVNRUpGYUM0aTBxUTRJVkdheWNrQlI1Zzl0?=
 =?utf-8?B?ZC9DUFp5SElpd3EzMUxyRDRHWjc1U3J0UHNHYzVHK1ZkZkRBeENKdDRkWU1T?=
 =?utf-8?B?WDlTTHNSODNQdHVHRGlDcDljMnJSTWdUNXk0M1BpczV3TitKWnIwdmZCUzhi?=
 =?utf-8?B?SGZyS2pSNmNsbVVEK2xOZnBORmVvQVQrR3pQdlpzRTJZbmlSL1hOemJvY0Rl?=
 =?utf-8?B?TEdmOW1BMXVCZExLditQUFRvOXdXQytLSTFVdGRWcVNkV05sOXB1MVFCTXRU?=
 =?utf-8?B?a3FhdFBPWkoxenZ5ODluOUVVcDZSREtWVm1jUUJSWVhjYWI4Mm1Wd2h0VURh?=
 =?utf-8?B?WGI2K2t2d3hyYWc5RUpMZ3g0VFVLMVl6RWl0dkdpQVJaM0d2aWdJbDBDZ1FP?=
 =?utf-8?B?MVRKdDluRmdpR3VXL2NnaXR2MFNJbVozcHArbHJEdktDVVRrK2VNWDNCSktJ?=
 =?utf-8?B?OU1Qc25tMkc4VUNFc0lEeGNsMmNEc2FkUHV2MmFnNC9iaEJtSWcweG1nS0hu?=
 =?utf-8?B?RmJwY0g4bHRlSUNOUFlIK1MxT2xWVTdmeVlhajlEb21Dc3V2eWc4OEdyelV3?=
 =?utf-8?B?SmFSekU5SjdrTWw2ZzdrQjZqdEFIbHI4ZjZmSVRvRDA5d3RheDhldUZnNnRK?=
 =?utf-8?B?cDgvY2d5ZnJrWjNtZlhTY0lmbVJlek5uS3IrL1F4RTBjZENFR1RWVkxxSWhY?=
 =?utf-8?B?TTAyaWZTbzZrSnhnejJyd21sY3FydUEweWVPT0ZtNy9CSGxYT1lyenpXZ0Ev?=
 =?utf-8?B?b2dvMWdjMmh4a0g2UFN4MmxFYjM4bFRVODNqNnh6MmJCMTNGN3RyUUZLVE5W?=
 =?utf-8?B?K3doeG5aUm45dUxKelptRERCUlJ4d1Y4OUpocFJZTWljbHVHM3p6bGN2Tjkx?=
 =?utf-8?B?VllMZXIwVngrRU96MEZ5REJnMzJzUE5yb1FSTTJxR25ZQ3QyRGl3WkgxUFhH?=
 =?utf-8?B?cHV2WHBGaUk4RGlKcW1uNVhuVklubkNVUGVUUS9jcTdhV0Z6QTAxQXBxSVdv?=
 =?utf-8?B?eDJDOVkzczE1L2JaelZIN0xLM0tPeG5pUklidTJIa1JvQmM1cDdqQ2oyd0dv?=
 =?utf-8?B?M1JKaHZZalFEdDF6Z2dpRWJYUk1EZFAyUFhjS1FFZW03NVN4eDE5UFFkWTJ5?=
 =?utf-8?B?S1AzNjUxZ1owUjUzWHVSbzBUTFhOUFk5ZVk2ZEc3cGREdmw0R0pWY0hFekFq?=
 =?utf-8?B?TXFMK0ZDVWlqY1doSVlPUzFXT2RtL1R4Vi9ML2szY1lQZHdjN3dLUndGS3JN?=
 =?utf-8?B?OFZXSXpPZU1oYXMrU2pKZ0pmUGF3TjRCVEs1RjllYmhTTXpGb0JMR2VHQStX?=
 =?utf-8?B?bTM0MGhzcmNaeWNMc3ZwSmdDRE5vTFdRUy9KQ0VSaXJHRjZTbFkvbDh0NUpi?=
 =?utf-8?B?eExHRndxMllCQWZLSkpKZkZTaVJEVCs5bHBHTzRvczQ5cXVrQkZOQ0Y5NEd5?=
 =?utf-8?B?d3R3MUZBN1VydmQ3ZGI4cVc1dHQzMUpxQ3diV1pzaVk5anVjaktoQ3NUY05z?=
 =?utf-8?B?bnhCVk5BcTViSEdtV01yd3Z3NFRaY1dRNGMwdnIrSEJ5UmxlVEhWckJEeFVj?=
 =?utf-8?B?c3NHL1BFaTMySFl1c3Q3dWdYQUhhb2JnZnB3YW5BU1hoelM0RGsvbFhzZUZa?=
 =?utf-8?B?VDk0Nk5adUxuMUIyZWt5MzRPeTZ1QXA4eTV5aGdYT3o5U203cDNMV1VnaE15?=
 =?utf-8?B?K2xnRE8rVWdPYi9GQnF6VkxlRmlkOVZBTzE4ODJQeUF3R294YXBMQVlvUGlq?=
 =?utf-8?B?bzd4RWRHVVAwcElEOUkxZG9mYkZKaUR3bUIyUVZTUEgwNm55d2ZGaU84Q3k5?=
 =?utf-8?B?Tit5ZTZYc3VucUVoNlhWUnhEalhNUEQ5dnVkV1haVVVPV3puZFJUWnFPREFN?=
 =?utf-8?B?WXNOVmFFSEhMekdyc2FMSWdVTy9wZTcwZ0t1K1BsWXFVYkh4QktGdGJQRmVQ?=
 =?utf-8?B?MFM1V2tZaS9qK1VudHlKTGRveVhjN2U5ZEJNYUN3WFFBa1FvaE9XbHpGVSta?=
 =?utf-8?B?YW1RV2hxblA0ZksyQU9UTmQvSExRRVJtbytaRkFoSGtCMERyV0dxVXJWcXg5?=
 =?utf-8?B?SEZhUkJuZnZtRDQ2K2pGUldiWGthc2ZuVW1SRFN2SmJ2T3ltNEl6QWlIVFRI?=
 =?utf-8?B?eDlBY1Zka2dPOHhBOGt1K2xzdzNjWlFTa1ZYa0p5SkFtSnd4R3ErRGtKU1Rt?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41295e7d-f3fa-4e74-bc71-08ddcda3b6eb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:55:19.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv845DHl48AQLFDAw+RwpmZR7QXt0g4T7sP5fm2EfmgfEmTQo6fBu5KEB58A3TdBq/lmbw9gYVmViDurNW8OHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-OriginatorOrg: intel.com

On 25/07/2025 13:52, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 

Need to explain in the commit message, why it has a stable tag, say:

	In preparation to fix replay timer timeout, add
	sdhci_gli_mask_replay_timer_timeout() to simplify some of the code, allowing
	it to be re-used.

> Add a sdhci_gli_mask_replay_timer_timeout() function
> to simplify some of the code, allowing it to be re-used.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

It is preferred to have a fixes tag as well.  What about

Fixes: 1ae1d2d6e555e ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")

> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4c2ae71770f7..98ee3191b02f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -287,6 +287,20 @@
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> +static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *dev)

dev -> pdev

> +{
> +	int aer;
> +	u32 value;
> +
> +	/* mask the replay timer timeout of AER */
> +	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> +	if (aer) {
> +		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> +		value |= PCI_ERR_COR_REP_TIMER;
> +		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> +	}
> +}
> +
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
>  	u32 wt_value;
> @@ -607,7 +621,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>  	struct pci_dev *pdev;
> -	int aer;
>  	u32 value;
>  
>  	pdev = slot->chip->pdev;
> @@ -626,12 +639,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  	pci_set_power_state(pdev, PCI_D0);
>  
>  	/* mask the replay timer timeout of AER */
> -	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer) {
> -		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> -		value |= PCI_ERR_COR_REP_TIMER;
> -		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> -	}
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
>  
>  	gl9750_wt_off(host);
>  }
> @@ -806,7 +814,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>  static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> -	int aer;
>  	u32 value;
>  
>  	gl9755_wt_on(pdev);
> @@ -841,12 +848,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  	pci_set_power_state(pdev, PCI_D0);
>  
>  	/* mask the replay timer timeout of AER */
> -	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer) {
> -		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> -		value |= PCI_ERR_COR_REP_TIMER;
> -		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> -	}
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
>  
>  	gl9755_wt_off(pdev);
>  }


