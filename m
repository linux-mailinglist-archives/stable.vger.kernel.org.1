Return-Path: <stable+bounces-158341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52397AE5F4E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5027B398B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6F25BEE8;
	Tue, 24 Jun 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZNaIocE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624B25B66D;
	Tue, 24 Jun 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753796; cv=fail; b=ZUDIL3MZP4D6jh9xOycI8HLBxf+P9nCbEDTw0B8q7ncU6l1uP+ifTy6K59D/c+0b6RCwAIOYhH4twCnor0ZS626b4ecO0FjIXu+14A4cQxsX3xQJJaMevPGPtWIEptTYnS7AxxB9xTqvgovh/NyqX1H3v8dEWESwkMT+t9kV33I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753796; c=relaxed/simple;
	bh=XT9GQcyNMzhi4r5PfVwqe0DPo7TsPLtqwucMrcD5bPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mhGWT81YS+2+uGhVP+YUsrs4or3xsjeOisMlH3y4M/J/OQgDAcGZCUtyqX9sINIFNaIBaBSn1lRfMguOGPSTdI1bjU23IYEs3twX9CF7oh438Ky4iK8rW35XWcPgZ3jETpQd7HfRWgrVI30A/f1B1iRVibVDhRU4EteNBbgRuy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZNaIocE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750753795; x=1782289795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XT9GQcyNMzhi4r5PfVwqe0DPo7TsPLtqwucMrcD5bPg=;
  b=IZNaIocE+S7aKApD4nRwy4it04Ioej+IfKjUQ9FEidjIyAgHRuxkqSJX
   9IdFZqtdAOBjMhSl9cy3eO4B0T1hi/r9HxznAsirHKktorsiIIcu8g9LV
   ue94VXbmi14IyozJehq876mA6CNy3e/jfY5NOL8fCiIg5GqRArFf2nMuV
   X01QyfETJHFNypuui8EKdnPMZDv5lnkw0WAJjfrrj294unylEZUyiYbs+
   G5BPikxiap3Rnoqzn4NqSQuUWUrR0Q1NF6GZaoEHmVOifuFZSV5d9uE2n
   uBs5zQSY8y5gaxIIOYRLVkTARj/ryVMmBdIAhihG+EguiQroYdCoocblB
   A==;
X-CSE-ConnectionGUID: Nlwg9CB5Q8OxHoY7w9ydKw==
X-CSE-MsgGUID: U34uN0JQQM6thT3XDHl3Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64342871"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64342871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:27:16 -0700
X-CSE-ConnectionGUID: Ch54h3gdSe2wmGSJygsW1w==
X-CSE-MsgGUID: PB8YdOhZRDu4Smgbgj8Wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151330117"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:27:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:27:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:27:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np6t1Cb5B8RZcBbdkX9TS1l3dtQIpOsH+CCqEqk4xG4HocI6yRS6vonIEHvKaN2Y4m8ftEQ16h6kZge2cqrxsI891SqBYUr+o7HCAq0kHu8mKvRuCh6BrjFLh7dEJ2hqhbIiZX2r1ItUHJ2lTPZcCGI29xjFlIMtYbWTqdo6jSflsEZqWe6hF8WgkiZOKuAxJQAxS07bkwBx5Qnt/8MYKP1NMjdkOb2LzgemOaI+U+UzReBTXWQJXQA3zSOqAKPYGkL+6j81SYt+I4bwDzmGZ0JSkaAzUBVei5TSp1hgfHZ445/ZnOPhiBiutFNOCYBeudMDHLJULcGDTi0C6X1g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IWrk0JTzISXgz7t/y6LBDYy5NQgO04DfCL8cyGCNHQ=;
 b=RaujH45TR2mh/ODfm7/nVmwAwdU47vj8fCzj+YMLTPj8yLWyG9XPBso7OnXWbtCVvVECm6NaGO6BMRXWA0C0JK9gt953co02UVDzHdnE+9Z+FFMFtjGxIh3P1q0AZ/kxdRv0DvpJyEdfCKBNxBahwzpBtiH6Fm60jVOKQZVy+d8NpGXsW0WC7FJO5DXIyQAimpCpWpScAxbYTabpoEwoZA5gIGmT2o5VHgth+ILIPYUTYftvi+6BncW88XfX+zozDXv5V2tOQy10W+QSPXdtbPR7ScgM2FL0uHCv5MxWRpdZefoSxnxo04J2pLrnUxoPdztswcbmP0Duejlh2NrYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 08:26:53 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:26:52 +0000
Message-ID: <65400f7d-0bfc-4b0c-8edc-c00d3527c12b@intel.com>
Date: Tue, 24 Jun 2025 11:26:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
To: Shawn Lin <shawn.lin@rock-chips.com>, Salvatore Bonaccorso
	<carnil@debian.org>, <regressions@lists.linux.dev>, Jeremy Lincicome
	<w0jrl1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <1108065@bugs.debian.org>,
	<stable@vger.kernel.org>, <net147@gmail.com>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0278.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::13) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: ce07c6f8-0a9e-45fc-f46f-08ddb2f8def1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1BidDRlb01OUXFsZW5pQVhlVVB5eHluVGtqcmRtNmVXRkRkUUZ1TXZFZEhn?=
 =?utf-8?B?K1FlR3dDSWZiODVySTJzcXVDTnk1THdwK0JNMkYyd0xXN0xtUm93R1ZGZ0tG?=
 =?utf-8?B?NXA1c2dJOU1HM0xuRFJoUjdqSUZxL2pnTlJ2YXlVUTJ6NTkxczYvTXZPSDFv?=
 =?utf-8?B?MUVyTTdZL2tlNjhZTjlXVVpDbDhjVnFrMU14K2tsazNJblFtdEtoaUVXTW90?=
 =?utf-8?B?N0ZFN2R5UUdBdXZSWWR0YytLZHF0bmhTOGxGZGs1L2ZQLzZKZHVIQXd1VUZv?=
 =?utf-8?B?TzlneFZBMlJHL2VSSFAxZm8yaHlYODFCbHo3ZDRTdGxwalVOVzA2Qnc5ZWRM?=
 =?utf-8?B?YzBDYXhCVHQyaWdzcDBISmo3UCs1VzQ4U3pPVGxQY1EvNFZpbXY1QkJCcWlG?=
 =?utf-8?B?MDRJWWtoZG02VllFVlhGTkZEZ3hXbFVSbDdmcXRtTWV5S1hXM1FSbHZwLzg3?=
 =?utf-8?B?VEZST0h1MG5YVm9iQW8zVmt6QW5lQ1lVYXgzU0ZpRmFSdGlYMVZXQjRNNmNp?=
 =?utf-8?B?YmNjQytzY2dwVmN3SVVZSXZhZ2FDeUpGcmdQL1MzNGYrNUE5WkF2V0ZvU0JO?=
 =?utf-8?B?VUw0MFVkdkRkUlBsOGxQWUxmMmh4TndMTDRUbjFaeWtaTGhHZ09OdVVjTUhr?=
 =?utf-8?B?eG5NVWdhaDBwdEt6ZmsyNXpycXZEQU0yaWFsblQ2RmxHeHF1NnNTcjBsekFw?=
 =?utf-8?B?Sm44Q3V5em9sZDRZRi9PUjRtVGtScXNEaHdCdHBXMklxdnBDaWVmV2k3dDVO?=
 =?utf-8?B?TE9RcVUyTWlFeVU2L0tXTHA4Ly9WTGh5U2ZCR1IrblFkbGJja0tnWllGdUFu?=
 =?utf-8?B?NWdHenRsd1ZlSnROS21aZGh5Vkc5dllzaWtlNWszUGl4MmlHbHFUL043Q2o2?=
 =?utf-8?B?cTQ2S0dmdENkcG9ySGFQajBEMnk4OUdwL1hyQTh1dW5RQlduNjBIL3VSUzVR?=
 =?utf-8?B?c3B5ODBvNWdvMEJmNE10Zmkxd0hyWk5MT2dKUTEwcW9ibHVlRlJqNUZsS3Zy?=
 =?utf-8?B?SVhSMDIrUTU3ZkdaMktyY2YxNVNCUmY4V3Jyc1ZxS2ZrMmg3VUwzZWsrZGIv?=
 =?utf-8?B?d1NEbitlVmQ1WWNVUkladEZTTmZCaUMxa2VpS3lzdVE3cWNjYTN6S1lSVlBJ?=
 =?utf-8?B?SXdjUE9QbWFmUStBRlhFSllRVkV6dnU4cG4yT1VKZmFoeGs5Skx2TnArK1BZ?=
 =?utf-8?B?ZzhOVGZ5c3ZsUUlreXkwUXVPOTNFS1dKTmQ2SlU2TVNrMndpUVNDdmtMKzh1?=
 =?utf-8?B?Vk0yL0dBekVXQnlaa2xFNThpU3pIOGZ6RmFlR3hEd0czWG9hcW1hS05IY3Br?=
 =?utf-8?B?cllLZGx3N3VLVjhHT1FCbE1RREdYVmlxTXRPSWNVREkrdTNDZHlNNFpLQVlO?=
 =?utf-8?B?ZUNNWWFzRnIxYm9wRUNJZG1uMWV1bTE0NUZITkM4VlBXYU1oOTRISUx3YU5l?=
 =?utf-8?B?RTJxc2hDbmhTeFF6Rjh2WDRPWktKNE5wT0VSdjFpVEVsQmFEZjA4NTN2dmNo?=
 =?utf-8?B?TVpJdzczZWlTSHdwSmR4cDNVNXRXc3dnNTV3NTQyRlo3R09XT2VlQWZRVFVI?=
 =?utf-8?B?YldoTm1qMFV3TjFjNk5JdFkxa2hWN0RUN3NxWlZaRUlzUjl0NHlocm9NSlI4?=
 =?utf-8?B?cGNycVhPaU9VUFVqQVkzM1N1dFQvdUtkbU02KzFaeDdwQ3lhYzBEUTJLY0g2?=
 =?utf-8?B?UzRkemVOVTBEOEVSc2tGbVZ4VXduZUxYNWozVzVoVTN6VjNtb0RMNFZTREY3?=
 =?utf-8?B?Z1BuYnRjVUdldkdxT3ZnQ0RpeTloWVlsMWF4dkQyMUR0dHN5UVdVcjh2L2lv?=
 =?utf-8?Q?2co6tVJ3Usv1+xI3pNVHCrgdl0/cV5LFNDCO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNIWmJiYnlWQnBOcTBCM0dWWW1GcWF6bytKV2ZzZnVJTVdMUWVEVWFrVnNN?=
 =?utf-8?B?WUN2QSswWWZtbGpvR2tVVFNHWnJPeEhrU0pyR1ZuRXV4eHdFQXNXNnM4S0Fy?=
 =?utf-8?B?eUZZT1VNZjRZZ2dDMmIzbnIwSDk5SFF6QkE2RFZmMkkwTzdDcndOclhNbS9z?=
 =?utf-8?B?WC9hUmhTWkZzQmFEaVo3R0taQ2pHd3E3QmswM1hhRzR0NTlaV0VMTmVpVlRp?=
 =?utf-8?B?b0ZSQVliVjVoWXFqVUlJWXlOYm9wZ21jNTJKT1NOeFdnTnIwWWpYcG04dDEx?=
 =?utf-8?B?bDFETHk0M1VvaHJSby9TcUQyellXcHFPZTUyNXRHK1BuRndaZGNicUUrckhC?=
 =?utf-8?B?cHI4ZWJDRjh2WkhZOGFQRTFqMkNMRUNvZ0xUV1ZQVzYwTTNNRHdUR3dPczN2?=
 =?utf-8?B?VUhSUmgvZU1kaGN4QUNrOCt1T0dXQmRPb2gwanRtNE1wdTB0Y04rK1hrenF2?=
 =?utf-8?B?bGZHRnBiaFlBSE44SUVFTGc3Sm5HUUhYNTdEeWFMb3RzUWtsZ0ZRVVVpai9w?=
 =?utf-8?B?N3d6N2dDaVBOaFhmYzNnWUwzSTgyM0RUZmZrdFFWRTFIeTNUNEZaWmxicmU0?=
 =?utf-8?B?bnZxTzhlSEwvOEl3TlJLMkNGYW1vbk1VWi8yS0ErVHdOdjdiUjc0RHIxQ0Zq?=
 =?utf-8?B?V3pKSkJUK3gxSy9jV2dHUTJyVndORjZXQjB6SHN2ZTdOSzZWeHdDenRJcjlB?=
 =?utf-8?B?aDQyVS90WlJnMVl0VW9rbHFwby9HVXJLZ09oSGNjdFFiSklmejZYQU9OUU4y?=
 =?utf-8?B?UXRuNFgreWd2SmRDL0s0YnlGZ2JMZ21wdzhTWjdpMERYTE9XM0dSMnh0cStw?=
 =?utf-8?B?b3BBN2V2MUk2cFd1ekVTM00weUQwRHBydEVVLzBpVWw4Vk9qUHJrZjRackdN?=
 =?utf-8?B?cVZCbStoNnlZeEJEWHNUV01oZ0JxUnZnRUw5bW5zNmdwWVV0R2ozTEpaRjZV?=
 =?utf-8?B?UUFYVTJ3NW5rQVowWUZQSmYrb0xZRElGenJTK2RrRWlJNld1R0hCQjc2QzJZ?=
 =?utf-8?B?WWlmVm9NbUNDVk5Jb3Eya0FiWGFMSGpweEtXSHN4L0pkS3ZPZ2Uxd2tCVDFT?=
 =?utf-8?B?Nmpta0taV2taMTZzajFyTzFNTmh1eU9sc2w5UVpCeGxQaERhcUtHYnRnNlVG?=
 =?utf-8?B?QmdqMjBBanF1S1BuN3Z4Z3FuSUZNU212d3BWY0ZReFE1TGlvYnJFVUNOQXgr?=
 =?utf-8?B?dE5HdDhUb3FPSkFveDlIcDYyN3E2cG9PN29kWDdBYkVRSExHMUlDckRPUjBN?=
 =?utf-8?B?UFNCM05mUUZESmlrSUwyQU1HbVRtT0UrT1dKTFFjU1dPM0lCRlJnNGJ0RTBl?=
 =?utf-8?B?cTQyaUo5and2VmM4WjdIMk03K2FadnV6RHJQYU1aUlNpdWNQRWZOQ25NQlNw?=
 =?utf-8?B?dm5tRkRzNS9hR0hsTWtZZlgwbGhDRGw4aXFuTlc2RllENDNsemJYbXQyclZU?=
 =?utf-8?B?OWdUMGNoUTI3K1N1R2ZBSjNxT1Q3TFdySEdoUGxadnlLNVRHK1ZLUmFNR3V0?=
 =?utf-8?B?dkJDOGxka1RlZHpkdGZ1WTNMNzZhVkNQbnp6Q1k3d0piZ0RBeUg3ZEp5TzFG?=
 =?utf-8?B?YXd2c3lRUHZDVVd1QXBiQ0FTN3dpOWdIV0RlSWtQV3NxSUdGcHZSbTVPcFlJ?=
 =?utf-8?B?RnRWcEdQV3Z1M2NJdjhvcFVPd09JTkU2M0VNV0pacU1oOVFxYUpzVG0xTnhV?=
 =?utf-8?B?UGhGV1VIZzZGcHFaSnN2b0tnSXBidkhSSndjdkJuc2JyWFNlMGQ0OG9DRGwv?=
 =?utf-8?B?VWxLVVZSNFNNQ09YeVFiMURjV0JzVDhwN08rMGxZeHpFTW91K01VMjc5Vzh5?=
 =?utf-8?B?dUtaQUFVSk14N1FJRjM2Tm1RanAvVGlGU1dzOFdaakFoUXpjOU9nNlJ2MW91?=
 =?utf-8?B?aTA3UG1XTFZsdThjMTNJUlhCb21zRVQxaGY5T1JETEhqQWMrNzlZME15c1Zz?=
 =?utf-8?B?Ymt0YlJNbGlTSEZDUDNjalpXRW8vYTVlTmx3UFQ4Z0QwQUdUNzFBZnpzeVln?=
 =?utf-8?B?d1pKZ25RZ1NqVGZYRGQ0YWlhQThBY3BjRk9ORkdoOE9KcDU4djE5VDMvUU15?=
 =?utf-8?B?U1k1NTNKZ0tWaG5ubkRsd2FQcjRrUFg5N0toSE5idVA2MU9UZ3BrSkNHS3FX?=
 =?utf-8?B?VFhmeml4bUlCQ3BtZnJSekRRb2tIbWU0clJocVovOEpXSzlvL1VPdjdDY3Bu?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce07c6f8-0a9e-45fc-f46f-08ddb2f8def1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:26:52.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOC4S4VjtT1BDxmF5MZCJ9Ai+V3LJl6BFuC/J+RSSxVWFSv5SE1cB+DQCwyaIUVTDyRfGA6zyhQ5q7nybD7bHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com

On 23/06/2025 12:13, Shawn Lin wrote:
> + Jonathan Liu
> 
> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
>> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
>>> Hi
>>>
>>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>>> 15ADA7 dropping finally into the initramfs shell after updating from
>>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>>> shell:
>>>
>>> mmc1: mmc_select_hs400 failed, error -110
>>> mmc1: error -110 whilst initialising MMC card
>>>
>>> The original report is at https://bugs.debian.org/1107979 and the
>>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
>>>
>>> Another similar report landed with after the same version update as
>>> https://bugs.debian.org/1107979 .
>>>
>>> I only see three commits touching drivers/mmc between
>>> 6.12.30..6.12.32:
>>>
>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
>>>
>>> I have found a potential similar issue reported in ArchLinux at
>>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>>
>>> I have asked if we can get more information out of the boot, but maybe
>>> this regression report already rings  bell for you?
> 
> Jonathan reported a similar failure regarding to hs400 on RK3399
> platform.
> https://lkml.org/lkml/2025/6/19/145
> 
> Maybe you could try to revert :
> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")

Given the number of other reports, probably best to revert
anyway.

> 
>>>
>>> #regzbot introduced v6.12.30..v6.12.32
>>> #regzbot link: https://bugs.debian.org/1107979
>>> #regzbot link: https://bbs.archlinux.org/viewtopic.php?id=306024
>>
>> *sigh* apologies for the "mess", the actual right report is
>> https://bugs.debian.org/1108065 (where #1107979 at least has
>> similarities or might have the same root cause).
>>
>> #regzbot link: https://bugs.debian.org/1108065
>>
>> Regards,
>> Salvatore
>>
>>
> 


