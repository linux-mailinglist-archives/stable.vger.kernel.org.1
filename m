Return-Path: <stable+bounces-212866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COEyDFiMfGnyNgIAu9opvQ
	(envelope-from <stable+bounces-212866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:47:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F31B9826
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161F9305C8DC
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4536AB5A;
	Fri, 30 Jan 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5etd2Ux"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F7378814;
	Fri, 30 Jan 2026 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769908; cv=fail; b=bMVzz0PXxC0BEHEEgqIdYrKOYB4qWgn39rH5YX0/Yq4DvYA0fPI5Bu7eBSPS68kYA141GN3XRZ4MLjAvuaFEM2AWh6eOP1zpRIiIgyFAx6+ae0uogOFfgXpjuJZUB+ibYmrfGUv8XVznM8lqH4h+eK+Pq3M5z04WCktGUh/AaWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769908; c=relaxed/simple;
	bh=b27th9CMCPxfzAw0JxQ2QrrBsonSqp01qbPRm154bmk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MC2lf8ABX3CA3OGTkGmbmO0opBLNiKhNcqVTRNpITeHFtpMbzazI9bmYywfU9Jqef7Ku8x3cQjAT+nznonZHi5MIJazhQuDAOXpiUbMX7iZcXFIOW07e+DvCFQQ1PZ4v+G4HzT0FnvBK9vLLnRt5BTvmikw4xjY3QP6kSn+zd+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5etd2Ux; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769769904; x=1801305904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b27th9CMCPxfzAw0JxQ2QrrBsonSqp01qbPRm154bmk=;
  b=G5etd2UxN18cxqHGvqZJRjU5VgdvAzLc2IFTGeRtynNv5s4SSM5CgR2U
   A7BwIVMEWDoUUC4+e1DvQIvvSpEj3pO+H6yFJTy43570/LZoVDknj05lx
   yoaXcqKNvbri2c3MHBQRlAIRJbCW9raHSOHYg7WL+x30Q/826YcShSv15
   U9sVhMOr1QkRzD6acntYemvIS3oXLe797UgA0SVYoiuy0SG4hcl1Z0lXE
   h3NRqMdC/b29j6qA6dzZUQjSmJRSlpEZRF2L6aqiVEM4RWDU7WtZRLozL
   M8k54FUpLiXt7bBGKB5AQ5dupprjhDqI5q8nDuKvKBiJPfEWLnvrnnuya
   g==;
X-CSE-ConnectionGUID: RwO+RzQNTqq5YOZx1qApEw==
X-CSE-MsgGUID: s+dL2GDnSNyxgZQ2IVV8SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74883346"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="74883346"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:45:00 -0800
X-CSE-ConnectionGUID: x7HBv2O4QBSmyDjhwEdJsQ==
X-CSE-MsgGUID: QmMm2OoETnW7kH8oEh9/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="207951865"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:45:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:44:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 02:44:59 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:44:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz3pF30Pf13Kdh3DEt3icuexnBEVdxo/HUIvSgaoRCDkbV+upaOr7imeIpvwE5IZg0XwVvF01/Td0wqC8TfnJydsRoR3J55HJJgjRjIh1wJNgTFlucIFOt6ErldLyahSI4qxkhkgq7ViliKotfYwF1oFcwt0GuJyv2bxDe5aE+dz+aoHW2j8OzGbgkbON7lEOJIGg+OL7INDd5pb4NPe58skQ+bw5z+5lHLUHxkPkujMM8IOmUBHerCYbzpiuVRzPX5zzYyIy5G08QSaQ9aqNkm06UgWvvJqf9HbUI9+iCib6DSl3OJH1oaGhnvHqJtvfXWNAwgFP6ORHyk5tk1yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EwTVF/W1f09BA+azLXiBMSWxYrNdWGBIjT4U7ss3JA=;
 b=ipOPV2TTyFmziAn6Yak3vhmiXvFECWDiWu0eATdJLSX4M/03UjZR1grvuUtFpnZGKOV1dPBDTX9/ka52uWBwjHE+1ldLRLidyLiwDtK58x4yoEVR5ARuwu1xcMCpMMExwmu6LojUoGZjFCjW1O11kRLrDRZeQNLQLLt4HTLkZ5Jafsdkw7iJPtVLmFpJFLyrRLq7w0+wwpqmsjqebqNJu//qGbwzm3w7afj7L1wwcPxVPlOWzQf8ZiYn6jV5xBY4GCoWdWs0s1PmR4bSBJ9wMf6B95AfVVo8BlRPfLcUuldKeFgBrc+9uOzGegc2m4L6LtxDq2gZPWhSo5lCGiPmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 10:44:57 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 10:44:56 +0000
Message-ID: <2d04194d-ad91-4dbb-ba1e-4b8fb395c007@intel.com>
Date: Fri, 30 Jan 2026 12:44:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
To: Penghe Geng <pgeng@nvidia.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260115214648.168365-1-pgeng@nvidia.com>
 <39569ebb-d9a2-4f81-9abe-aec98f3c9f67@intel.com>
 <lxp6wsa6mgx3km54hpdqaeoe6gery54ad6ulc4k2futkmiod77@i5sutp3dpdjd>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <lxp6wsa6mgx3km54hpdqaeoe6gery54ad6ulc4k2futkmiod77@i5sutp3dpdjd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bc755f-70e1-4368-f875-08de5fec9bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlZYSUtqNk5iemhtSEhBVDEwdXQxUXdGTk1GWXQwRFJkMGRlL2NPUGtQRDFo?=
 =?utf-8?B?T3ZXWmRKaVMwSm5DLzNzUnJEenBwUTBsUEdsVlVKVlhyQVdOM1pFT2c4S1RM?=
 =?utf-8?B?ek5temlyMzk1YW12V2RZT2p2eGF4UHJ3bWVjNGVWOStPbHZ2YXhwbUhvMXl0?=
 =?utf-8?B?TUFEU1FTY1E4WmNXZVhsc2p3aHdxNXA3VS9RMnpoSlNseVI4Q0NINDZaQW82?=
 =?utf-8?B?RTBZN3RhVEduOGlTQ1ZjTGcrNWFiMFBnSUNjWlV4WEVHWHFBOFJONHpVMkVX?=
 =?utf-8?B?cTNUMHVlM0Z1QjcrMVg5LzNmc2RMeE1xaTZVV0t3bm1VV2M5TXVBMFdabVRG?=
 =?utf-8?B?WUFaTFlXU3dYWm81OVlENllVSGYxY1RuUjh4ejdIczY0ZkI2U2FTVWJZZmR2?=
 =?utf-8?B?TmJQUVl3RU9JbTR1dzhjNDlOa0V5VVVqMFRVWVBTYVVxRCtGOGUyaG9PUldy?=
 =?utf-8?B?ZWl2bXM1ZXdMNHFKVDVvQ0RyYmN2S1BaMDJUcldMTFhEYVdFSU11NXJWK2F4?=
 =?utf-8?B?S093L2JVV0dZdWxFQ05La0lmdURvdWxhMUVOYUxZVjJ6WnJza0FLdE93dWlY?=
 =?utf-8?B?OGZrMnBvS1RzaEJWTWVBamRaQnFUYmQweXNXM1lWblFieUR1b04xVHBvN3VR?=
 =?utf-8?B?MEhjR1hyZzdWQllxdGdGbVBPb3lZY1NsYndlZXd2aGxBSjVTeDZTVEY3THc5?=
 =?utf-8?B?c0E2Q3pmQ1VjVmlJVUlnV3ZWRUNKU3hSWnBDaDA5Y2I1U1dzSnRWNDU2MlRa?=
 =?utf-8?B?SysrdDd1RGV2ZmxpSFdpdENGTFc4eGVSVTlmcFlYaUFZVzhrZHVENzE5MTJ4?=
 =?utf-8?B?MmYrYU9zcURnSzRCUGhTaTU2YVRXTXZNdzBLdm4ydmRmSzlpOEUyOEVEcWNs?=
 =?utf-8?B?Z1RiZEdtQXp0TE1sQnZBY3pVTGpxWU9YeW9QUllVSUFndHZFSGJtVmhvOE9I?=
 =?utf-8?B?ZytUSWRTZmg2WUprMG5aMVFkZHBaNS9UNW5RTlB5akdiSmRjTVpYZVpMV3M3?=
 =?utf-8?B?a3c4YlFVQnpMVjlGakV2dDdCcUJRWXFjempMbTQvNWdOdFRZcmoyejNZZU9x?=
 =?utf-8?B?T2poMk00UUtjZGl6SHRxRXVzSGVHbFNoMVNRcmFzRERYR3JkMkwvS054UU5L?=
 =?utf-8?B?U2ROU0pEMGIxQmR1UGlQVWg3RHVnT3dBQUNVcTlXd0IwV094ZDV4NmNSanZk?=
 =?utf-8?B?Y3NWOTc2VjBMdkZ1YmhxWTNwS2Q4Q1BLdnplV3NzcWVEVFp0ejA4eUY4RHJK?=
 =?utf-8?B?cUN1Q3hzYTZBb2dnOC9QQWZhcENlRllTZ1B1Yno1MmhZR0ZDM2ZncGYzc0I3?=
 =?utf-8?B?TlR1NllpeVlZMDdIMWVFZHlPK3R0Y1VsU3J3US8xUFZkb3A0aDF2UzVEeUFO?=
 =?utf-8?B?cmRmM2RscVNJdlZnSXp2Qyt2YWhDMGFhb2c2ZmVMNGYwSENKR2tWcEZKbmha?=
 =?utf-8?B?Si9MRkZQUUZ0dWpjZ0g3QkJ1Mmhzb0JUR1FlSmZEd2RQcTNNakJ0MTRYUFcx?=
 =?utf-8?B?cjBSYjhXQVA3Q1BrUW1KdUFJLzdldUJKM1p5YnhjMS9ONVNTWVN0eEE2eThv?=
 =?utf-8?B?NjdTOWxBcEV5MFQ4ZENGZFBuWm5TMzFDYVAwM2FWcWsxbC9tUi9rS1hLYVcz?=
 =?utf-8?B?SU5nU0VuTGpCSUJkNi9hSmJTeGFYeklZOTdWRXJaem5UZTFUV3U5aytMN3FN?=
 =?utf-8?B?Zm1jZ05iajdPL1hWVy9PV0J4RjlGbTBLMmw4LzZZM014ZXAwWVJGK0JpaE1B?=
 =?utf-8?B?ZFpCTDN6Ti8rdk94VWxDR2poUXRIUEVnV3haZU5lb3R3SGd1Q3F2UDhBTE9k?=
 =?utf-8?B?K1dGa0h3ckFGWURXY2VCdnlTQnpaUkZVTlpOdjQ1NjVOaDZJQlFjVWxQekNi?=
 =?utf-8?B?SFlsUGo4RVBEakY3THRXQkhkMGhGem5OekppbnVySG5jcjZmQkE4YWczZFo2?=
 =?utf-8?B?YjU5WUNvdnVULzlVVDNJU0h2OUpQWHNsK0VKSXBDdEdjNU9Dd0xObmlpa0hD?=
 =?utf-8?B?dVBFM0ordE9SSE1jVjlkUlRPUVVyM1RPUWRNby9ZYUhWOTc2TFFDRWVmL216?=
 =?utf-8?Q?gsdPNF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlKVmhxM3cyWnFKMUlsWXdLTzhqUEFTRTlqakNNSTJHckd3U3hTS0FSeU1m?=
 =?utf-8?B?QnQrUFYwOVZsV0tNRDRISEUwOFMvLzNLKzd2YzF2THcwSnlrY212b3o5QWlH?=
 =?utf-8?B?UFhLWWtCczE1UWJ5UCsxcGtQamxnVmNKdlFDNk5rWlJmNDJYZ0xuamtWSFVU?=
 =?utf-8?B?SXJPU2VWcXRab3ZmeDVBZlVrUkRiY05JMW1MYTZHVUU5Ykc4RGI2RjhZWWVu?=
 =?utf-8?B?VENXczE0WXVmcmZLVFpSY1B2V1VYVlFBR2JGbGtKYzM0Ni8rZHdmVXdSMDAr?=
 =?utf-8?B?NkhYeUx6VEtaT2ZYb0luSlBqYjlTd0ZyeHFKTjJSL2ZWRnYwNytTalBTQmNt?=
 =?utf-8?B?ZlluNTE4bUNFTGJ1aFNZYWtQVEVHTDhwaldxUWIzK0RiTEZobEpBdWVjVndK?=
 =?utf-8?B?aFJKanZPT0xuK2JKYmJneW9Rbzg4VXpSSm1rK2lSWDNMTXliUW01M0psWG9I?=
 =?utf-8?B?SjRldmc4K1kwYWpUbzJNRk1IeTR2RU01RjhFdm9OajNxZjQ0b1V5VVNPSWNP?=
 =?utf-8?B?K0tmMDk2bDhKbk5BNVlhRnozVTZiNlRWTkwwSWE1RnVScTRFREd3RnAyYnFX?=
 =?utf-8?B?bGIvSlA0T1VucTlhbzVQdXNyNklvQzNBbUIwTS9adVY3WjBqNG0wd0pjVERx?=
 =?utf-8?B?aHZKNDUrT3MrNEQ2ZjdhK0luUmtXYXJlSDBwSGxTeDVUL2dyQm4ra1kwWmZE?=
 =?utf-8?B?bWRnbjlwY2hHaXJJTEVkU21SM1Q2V2gyUU0vT2l1alphU2RobmNkeDQ2bDd2?=
 =?utf-8?B?NzQxUzFlQzN2bUhUZkwvNG9qOVVtaWt6dHkzM0hUNTNHbWJVNDFFVjdva1l3?=
 =?utf-8?B?MmdVZ05LZWM1V0JjMlhkR09sd1FNRHNyMlhhd2ExeUVQdGIvTHkvMGUxRFBB?=
 =?utf-8?B?bjd4blJwRmdUS3cyUjcvb3pqWko5UlZyWERXT0xwMk9rTGtlNjI1d1draGIx?=
 =?utf-8?B?L0xjeFNnZWpoM3FQSE5wSytHQW83QUsralM5ajE5d3loNkNZMEF4REhRRG5D?=
 =?utf-8?B?MWZ1b1l2TXROYzFCdHRPckozWmdGdExuT0hBRllPd25tLy9qQnVkWC9EWFdR?=
 =?utf-8?B?a29oSW9Kc2dOclU0bkE5NmljcXhKcjFyelZ2UXQ2UlY4UXN1MXlPTXYxeFAx?=
 =?utf-8?B?YVF4RzFVNllha0pLZjMxREF5aG1uSmZaZlE1SUlFWURZK0ZDY3NiMm1idnFE?=
 =?utf-8?B?SDBlZ3ZuNWgzZUp5cTlzVndzdzFrZlRXRmJWVWw0L3JYYW1MUjBvczZhcW0x?=
 =?utf-8?B?OEhGeVRvM0dCVDhBYWZzMEdLVk5WQjJxbWcrUkswa0ZvZ3lKdG9nTGNQYmhF?=
 =?utf-8?B?S3ZIeEl0Q04zcERXamFnbllCZU9HbDRpQXYrTTNvS3VLUHNZMmVjVWFHOU9m?=
 =?utf-8?B?MGY5SUZUMUkwMjZxS010eW51WURhckJGTW1YbjMzcDFrNnhqK3hRNWVmaGN6?=
 =?utf-8?B?QUZGOEp0clByK1RsVW9YWlBXZVArY2ZRV2ZPZ0FiR3ZsLzQ2VTdycjFlM1Fu?=
 =?utf-8?B?dEp3MGhiVjB2bThlZUZ1bzRkVXRqUDVWbU8wLy96UDgraGh6RWtqQ215RmxG?=
 =?utf-8?B?TVR3K2lIZEs3V09ZZ0t3V3M1bjRsekVsUzA2b3ZkdTRtWGcyQllNb1pGTWRV?=
 =?utf-8?B?T0ZtbnZuNmI1cGhRRDlsRDFRNGd0MFN1WC9Qc2w2RG5MMlZUV01yblRpcTVh?=
 =?utf-8?B?Q3QyYUlidVVXdU82NnRVeEZ5V3lvc1dBbVVJQTlEbDZBK0ZKeUZqWHdRV2lw?=
 =?utf-8?B?QytyQzg1aXI1dCt3TmtZVk02QU9FNjdEQmppWjB2eFVEUHBjQ0g1Z1FIZ2Nu?=
 =?utf-8?B?MFRIYnQxdXVOVzQ2ZkRrZVFUejhkd3lZT2t6bzA0UXMzM0JITHE1RUhEZnJ5?=
 =?utf-8?B?T3VsT2FUMkFQWC81bDFvbEVvdUJNZitMbEd1dmNGYWNOMHNmUmV2ckdLaGFB?=
 =?utf-8?B?TEhxNUlRRVNkVU5lY29ZTjBjQVVxZFcxdExDUGxrVVlNN1JoZGIyZGczSW94?=
 =?utf-8?B?MjNNVURyZklwR0wwMVhISWppdW1VUTV2U1BiSUpyUFduQVBPZGRYV0FPSG5N?=
 =?utf-8?B?RlJodzRnSnMyeFhWQ3JhWHZsaVR2L21ONmdLeFNTclRUNWRhYXpNb2h6MEV5?=
 =?utf-8?B?L2d5U2NSSHdWTGJIa3BqV1RiU21uUEh3WFZlUEdFYWFFQWJLNVE2UzlnNTBv?=
 =?utf-8?B?aWVIUW9tTXpRblRRYnpKQ1UrcmVNakdCTmM1dGpnUWVsd1JxQjFaVnlhdFl2?=
 =?utf-8?B?NU0zY1k1RjNLMUd2ZUhta0xlUmxmUUdHQVlELzdhTUVpaUoyelRLa1dMbkc5?=
 =?utf-8?B?eVpxZStacm9PeTE2eHVMZm9Cc09MTWw2a1RkRldzRkRheVBJRldWdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc755f-70e1-4368-f875-08de5fec9bdf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:44:56.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv+aepRpN+SPflfiQm2u9lpFWmLAls8fIXnKTgupE/1Lv6+mb9qwGsDL67AHzi19bAbsgdjX1QU34MuxLi1LjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212866-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 54F31B9826
X-Rspamd-Action: no action

On 30/01/2026 00:47, Penghe Geng wrote:
> 
> Hi Adrian,
> 
> Thanks for the feedback. Below are the details you asked for.
> 
> Kernel versions:
> - Seen on 5.15.120.bsk.business.6‑arm64 (custom tree).
> - Also observed on 6.1.0‑11‑arm64 (Debian 6.1.38‑4).
> 
> Media: eMMC
> Controllers:
> - BlueField‑2: Synopsys DesignWare MMC (drivers/mmc/host/dw_mmc-bluefield.c)
> - BlueField‑3: Synopsys DWC MSHC (drivers/mmc/host/sdhci-of-dwcmshc.c in‑tree) and also with OOT sdhci-of-dwcmshc-bf3
> 
> CQE:
> - Not enabled at runtime. CONFIG_MMC_CQHCI=m.
> - lsmod | grep cq is empty by default.
> - modprobe cqhci loads with 0 users and no CQE/CQHCI enable
>   messages in dmesg. So CQE is not in use by the active host.
> 
> I/O errors:
> - None observed around the WARN.
> 
> Repro:
> - Intermittent, mostly during boot under stress.
> - Roughly 0.1–1% depending on distro/platform.
> 
> Example stack (BF3, in-tree sdhci-of-dwcmshc):
> ------------[ cut here ]------------
> mmcblk0boot1: mmc0:0001 Y29128 31.9 MiB
> WARNING: CPU: 8 PID: 240 at drivers/mmc/core/core.c:349 mmc_start_request+0xb4/0xc4
> Modules linked in: crc16(E) mbcache(E) jbd2(E) nvme_tcp(OE) nvme_rdma(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_core(OE) nvme_fabrics(OE) configfs(E) nls_ascii(E) nls_cp437(E) nls_cp850(E) msdos(E) efivarfs(E) nvme(OE) nvme_core(OE) virtio_net(E) net_failover(E) virtio_console(E) failover(E) mlxbf_tmfifo(OE) mlx_compat(OE) virtio(E) t10_pi(E) sbsa_gwdt(E) mlxbf_bootctl(OE) sdhci_of_dwcmshc(OE) virtio_ring(E)
> mmcblk0rpmb: mmc0:0001 Y29128 4.00 MiB, chardev (245:0)
> CPU: 8 PID: 240 Comm: kworker/8:1H Tainted: G           OE     5.15.120.bsk.business.6-arm64 #5.15.120.bsk.business.6
> Hardware name: https://www.mellanox.com BlueField-3 DPU/BlueField-3 DPU, BIOS 4.9.2.13576 Mar 18 2025
> Workqueue: kblockd blk_mq_run_work_fn
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mmc_start_request+0xb4/0xc4
> lr : mmc_start_request+0x68/0xc4
> sp : ffff80000932ba90
> x29: ffff80000932ba90 x28: ffff000081b3b308 x27: 0000000000000000
> x26: 0000000000000001 x25: 0000000000000000 x24: ffff000082aec000
> x23: ffff000082485800 x22: ffff000082aec000 x21: 0000000000000000
> x20: ffff000081b3b3d8 x19: ffff000082aec000 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffbab212913c40 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000038 x12: ffff00008f06b000
> x11: 7f7f7f7f7f7f7f7f x10: ffffbab2144acbc8 x9 : ffffbab2130ad368
> x8 : ffff000081b3b548 x7 : ffff000082aec000 x6 : 0000000000000000
> x5 : ffff000081b3b458 x4 : ffff00008a4b5e80 x3 : ffff0000824859b0
> x2 : 0000000000000000 x1 : ffff000081b3b4c8 x0 : 0000000000000020
> Call trace:
>  mmc_start_request+0xb4/0xc4
>  mmc_blk_mq_issue_rq+0x310/0x8fc
>  mmc_mq_queue_rq+0x154/0x3e0
>  blk_mq_dispatch_rq_list+0x13c/0xa44
>  blk_mq_do_dispatch_sched+0x2cc/0x33c
>  __blk_mq_sched_dispatch_requests+0x154/0x1b0
>  blk_mq_sched_dispatch_requests+0x40/0x80
>  __blk_mq_run_hw_queue+0x58/0xa0
>  blk_mq_run_work_fn+0x28/0x34
>  process_one_work+0x1f8/0x4c0
>  worker_thread+0x180/0x580
>  kthread+0x128/0x13c
>  kthread_return_to_user+0x0/0x10
> ---[ end trace fc3df73f08f7c8ee ]---

Not much to go on

> 
> I agree the bitfield usage adds complexity. I can work on a follow-up
> to convert the retune-related flags to bools if that’s the preferred
> direction.

There are 2 suspect cases that I notice:

1. host->claimed in __mmc_claim_host()

The block driver allows more than 1 request to be inflight, which means
__mmc_claim_host() could itself overwrite other bitfields in a asynchronous
context if the host has alrady been claimed for the same ctx.

int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
		     atomic_t *abort)
{
	struct task_struct *task = ctx ? NULL : current;
	DECLARE_WAITQUEUE(wait, current);
	unsigned long flags;
	int stop;
	bool pm = false;

	might_sleep();

	add_wait_queue(&host->wq, &wait);
	spin_lock_irqsave(&host->lock, flags);
	while (1) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		stop = abort ? atomic_read(abort) : 0;
		if (stop || !host->claimed || mmc_ctx_matches(host, ctx, task))
			break;
		spin_unlock_irqrestore(&host->lock, flags);
		schedule();
		spin_lock_irqsave(&host->lock, flags);
	}
	set_current_state(TASK_RUNNING);
	if (!stop) {
		host->claimed = 1;				<- overwrites other bitfields
		mmc_ctx_set_claimer(host, ctx, task);
		host->claim_cnt += 1;
		if (host->claim_cnt == 1)
			pm = true;
	} else
		wake_up(&host->wq);
	spin_unlock_irqrestore(&host->lock, flags);
	remove_wait_queue(&host->wq, &wait);

	if (pm)
		pm_runtime_get_sync(mmc_dev(host));

	return stop;
}

2. host->retune_now in mmc_mq_queue_rq()

For the same reason as 1, host->retune_now update can overwrite other
bitfields in an asynchronous context.

	if (host->cqe_enabled) {
		host->retune_now = host->need_retune && cqe_retune_ok &&
				   !host->hold_retune;
	}

I suggest changing bitfields to bool for the above 2 cases and also
in cases that are relatively difficult to fully understand:

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index e0e2c265e5d1..ba84f02c2a10 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -486,14 +486,12 @@ struct mmc_host {
 
 	struct mmc_ios		ios;		/* current io bus settings */
 
+	bool			claimed;	/* host exclusively claimed */
+
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
-	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
-	unsigned int		retune_now:1;	/* do re-tuning at next req */
-	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
@@ -508,6 +506,9 @@ struct mmc_host {
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
+	bool			can_retune;	/* re-tuning can be used */
+	bool			retune_now;	/* do re-tuning at next req */
+	bool			retune_paused;	/* re-tuning is temporarily disabled */
 	int			need_retune;	/* re-tuning is needed */
 	int			hold_retune;	/* hold off re-tuning */
 	unsigned int		retune_period;	/* re-tuning period in secs */

For which fixes tags could be:

	Fixes: 6c0cedd1ef952 "mmc: core: Introduce host claiming by context"
	Fixes: 1e8e55b67030c "mmc: block: Add CQE support"

> 
> Thanks,
> Penghe
> 
> On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 15/01/2026 23:46, Penghe Geng wrote:
>>> The host->claimed flag shares a bitfield storage word with several
>>> retune flags (retune_now, retune_paused, can_retune, doing_retune,
>>> doing_init_tune). Updating those flags without host->lock can RMW the
>>> shared word and clear claimed, triggering spurious
>>> WARN_ON(!host->claimed).
>>
>> Thanks for finding this!
>>
>> The design is that those members are protected by the host->claimed
>> lock itself.
>>
>> mmc operations are primarily single-threaded, protected by the
>> host->claimed lock, although the block driver does allow multiple
>> transfers at the same time in some cases.
>>
>> There are also other contexts like interrupt handlers.
>>
>> Can you provide some information about when WARN_ON(!host->claimed)
>> is being hit?  Including the stack dump?
>> What kernel version?
>> Is it eMMC, SDIO or SD card?
>> Is CQE being used?
>> Are there any I/O errors happening also?
>> What controller driver is it?
>>
>> In any case, the use of bit fields seems to add complexity unnecessarily,
>> so we should consider converting some or all of them to bool.
>>
>>>
>>> Serialize all retune bitfield updates with host->lock. Provide lockless
>>> __mmc_retune_* helpers so callers that already hold host->lock can
>>> avoid deadlocks while public wrappers serialize updates. Also protect
>>> doing_init_tune and the CQE retune_now assignment with host->lock.
>>>
>>> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
>>> ---
>>>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
>>>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
>>>  drivers/mmc/core/mmc.c   |  6 ++++
>>>  drivers/mmc/core/queue.c |  3 ++
>>>  include/linux/mmc/host.h |  4 +++
>>>  5 files changed, 94 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index 88c95dbfd9cf..0b6b4a31f629 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
>>>   */
>>>  void mmc_retune_enable(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->can_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>       if (host->retune_period)
>>>               mod_timer(&host->retune_timer,
>>>                         jiffies + host->retune_period * HZ);
>>> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
>>>   */
>>>  void mmc_retune_pause(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (!host->retune_paused) {
>>>               host->retune_paused = 1;
>>> -             mmc_retune_hold(host);
>>> +             __mmc_retune_hold(host);
>>>       }
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_pause);
>>>
>>>  void mmc_retune_unpause(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +     bool released;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->retune_paused) {
>>>               host->retune_paused = 0;
>>> -             mmc_retune_release(host);
>>> +             released = __mmc_retune_release(host);
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>> +             if (!released)
>>> +                     WARN_ON(1);
>>> +     } else {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>       }
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_unpause);
>>> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
>>>   */
>>>  void mmc_retune_disable(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>>       mmc_retune_unpause(host);
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->can_retune = 0;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>       timer_delete_sync(&host->retune_timer);
>>>       mmc_retune_clear(host);
>>>  }
>>> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
>>>
>>>  void mmc_retune_hold(struct mmc_host *host)
>>>  {
>>> -     if (!host->hold_retune)
>>> -             host->retune_now = 1;
>>> -     host->hold_retune += 1;
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     __mmc_retune_hold(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  void mmc_retune_release(struct mmc_host *host)
>>>  {
>>> -     if (host->hold_retune)
>>> -             host->hold_retune -= 1;
>>> -     else
>>> +     unsigned long flags;
>>> +     bool released;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     released = __mmc_retune_release(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +     if (!released)
>>>               WARN_ON(1);
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_release);
>>> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
>>>  {
>>>       bool return_to_hs400 = false;
>>>       int err;
>>> +     unsigned long flags;
>>>
>>> -     if (host->retune_now)
>>> -             host->retune_now = 0;
>>> -     else
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     if (!host->retune_now) {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>               return 0;
>>> +     }
>>> +     host->retune_now = 0;
>>>
>>> -     if (!host->need_retune || host->doing_retune || !host->card)
>>> +     if (!host->need_retune || host->doing_retune || !host->card) {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>               return 0;
>>> +     }
>>>
>>>       host->need_retune = 0;
>>> -
>>>       host->doing_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
>>>               err = mmc_hs400_to_hs200(host->card);
>>> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
>>>       if (return_to_hs400)
>>>               err = mmc_hs200_to_hs400(host->card);
>>>  out:
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->doing_retune = 0;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>       return err;
>>>  }
>>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
>>> index 5941d68ff989..07e4f427fe15 100644
>>> --- a/drivers/mmc/core/host.h
>>> +++ b/drivers/mmc/core/host.h
>>> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
>>>  void mmc_retune_pause(struct mmc_host *host);
>>>  void mmc_retune_unpause(struct mmc_host *host);
>>>
>>> -static inline void mmc_retune_clear(struct mmc_host *host)
>>> +static inline void __mmc_retune_clear(struct mmc_host *host)
>>>  {
>>>       host->retune_now = 0;
>>>       host->need_retune = 0;
>>>  }
>>>
>>> +static inline void mmc_retune_clear(struct mmc_host *host)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     __mmc_retune_clear(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +}
>>> +
>>> +static inline void __mmc_retune_hold(struct mmc_host *host)
>>> +{
>>> +     if (!host->hold_retune)
>>> +             host->retune_now = 1;
>>> +     host->hold_retune += 1;
>>> +}
>>> +
>>> +static inline bool __mmc_retune_release(struct mmc_host *host)
>>> +{
>>> +     if (host->hold_retune) {
>>> +             host->hold_retune -= 1;
>>> +             return true;
>>> +     }
>>> +     return false;
>>> +}
>>> +
>>>  static inline void mmc_retune_hold_now(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->retune_now = 0;
>>>       host->hold_retune += 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline void mmc_retune_recheck(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->hold_retune <= 1)
>>>               host->retune_now = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 7c86efb1044a..114febd15f08 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>               goto free_card;
>>>
>>>       if (mmc_card_hs200(card)) {
>>> +             unsigned long flags;
>>> +
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->doing_init_tune = 1;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>               err = mmc_hs200_tuning(card);
>>>               if (!err)
>>>                       err = mmc_select_hs400(card);
>>>
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->doing_init_tune = 0;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>               if (err)
>>>                       goto free_card;
>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>> index 284856c8f655..5e38759c87f5 100644
>>> --- a/drivers/mmc/core/queue.c
>>> +++ b/drivers/mmc/core/queue.c
>>> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>       enum mmc_issue_type issue_type;
>>>       enum mmc_issued issued;
>>>       bool get_card, cqe_retune_ok;
>>> +     unsigned long flags;
>>>       blk_status_t ret;
>>>
>>>       if (mmc_card_removed(mq->card)) {
>>> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>               mmc_get_card(card, &mq->ctx);
>>>
>>>       if (host->cqe_enabled) {
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->retune_now = host->need_retune && cqe_retune_ok &&
>>>                                  !host->hold_retune;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>       }
>>>
>>>       blk_mq_start_request(req);
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index e0e2c265e5d1..e7bddbafd1da 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
>>>
>>>  static inline void mmc_retune_needed(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->can_retune)
>>>               host->need_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline bool mmc_can_retune(struct mmc_host *host)
>>
> 
> On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 15/01/2026 23:46, Penghe Geng wrote:
>>> The host->claimed flag shares a bitfield storage word with several
>>> retune flags (retune_now, retune_paused, can_retune, doing_retune,
>>> doing_init_tune). Updating those flags without host->lock can RMW the
>>> shared word and clear claimed, triggering spurious
>>> WARN_ON(!host->claimed).
>>
>> Thanks for finding this!
>>
>> The design is that those members are protected by the host->claimed
>> lock itself.
>>
>> mmc operations are primarily single-threaded, protected by the
>> host->claimed lock, although the block driver does allow multiple
>> transfers at the same time in some cases.
>>
>> There are also other contexts like interrupt handlers.
>>
>> Can you provide some information about when WARN_ON(!host->claimed)
>> is being hit?  Including the stack dump?
>> What kernel version?
>> Is it eMMC, SDIO or SD card?
>> Is CQE being used?
>> Are there any I/O errors happening also?
>> What controller driver is it?
>>
>> In any case, the use of bit fields seems to add complexity unnecessarily,
>> so we should consider converting some or all of them to bool.
>>
>>>
>>> Serialize all retune bitfield updates with host->lock. Provide lockless
>>> __mmc_retune_* helpers so callers that already hold host->lock can
>>> avoid deadlocks while public wrappers serialize updates. Also protect
>>> doing_init_tune and the CQE retune_now assignment with host->lock.
>>>
>>> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
>>> ---
>>>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
>>>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
>>>  drivers/mmc/core/mmc.c   |  6 ++++
>>>  drivers/mmc/core/queue.c |  3 ++
>>>  include/linux/mmc/host.h |  4 +++
>>>  5 files changed, 94 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index 88c95dbfd9cf..0b6b4a31f629 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
>>>   */
>>>  void mmc_retune_enable(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->can_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>       if (host->retune_period)
>>>               mod_timer(&host->retune_timer,
>>>                         jiffies + host->retune_period * HZ);
>>> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
>>>   */
>>>  void mmc_retune_pause(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (!host->retune_paused) {
>>>               host->retune_paused = 1;
>>> -             mmc_retune_hold(host);
>>> +             __mmc_retune_hold(host);
>>>       }
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_pause);
>>>
>>>  void mmc_retune_unpause(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +     bool released;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->retune_paused) {
>>>               host->retune_paused = 0;
>>> -             mmc_retune_release(host);
>>> +             released = __mmc_retune_release(host);
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>> +             if (!released)
>>> +                     WARN_ON(1);
>>> +     } else {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>       }
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_unpause);
>>> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
>>>   */
>>>  void mmc_retune_disable(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>>       mmc_retune_unpause(host);
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->can_retune = 0;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>       timer_delete_sync(&host->retune_timer);
>>>       mmc_retune_clear(host);
>>>  }
>>> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
>>>
>>>  void mmc_retune_hold(struct mmc_host *host)
>>>  {
>>> -     if (!host->hold_retune)
>>> -             host->retune_now = 1;
>>> -     host->hold_retune += 1;
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     __mmc_retune_hold(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  void mmc_retune_release(struct mmc_host *host)
>>>  {
>>> -     if (host->hold_retune)
>>> -             host->hold_retune -= 1;
>>> -     else
>>> +     unsigned long flags;
>>> +     bool released;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     released = __mmc_retune_release(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +     if (!released)
>>>               WARN_ON(1);
>>>  }
>>>  EXPORT_SYMBOL(mmc_retune_release);
>>> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
>>>  {
>>>       bool return_to_hs400 = false;
>>>       int err;
>>> +     unsigned long flags;
>>>
>>> -     if (host->retune_now)
>>> -             host->retune_now = 0;
>>> -     else
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     if (!host->retune_now) {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>               return 0;
>>> +     }
>>> +     host->retune_now = 0;
>>>
>>> -     if (!host->need_retune || host->doing_retune || !host->card)
>>> +     if (!host->need_retune || host->doing_retune || !host->card) {
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>               return 0;
>>> +     }
>>>
>>>       host->need_retune = 0;
>>> -
>>>       host->doing_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
>>>               err = mmc_hs400_to_hs200(host->card);
>>> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
>>>       if (return_to_hs400)
>>>               err = mmc_hs200_to_hs400(host->card);
>>>  out:
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->doing_retune = 0;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>       return err;
>>>  }
>>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
>>> index 5941d68ff989..07e4f427fe15 100644
>>> --- a/drivers/mmc/core/host.h
>>> +++ b/drivers/mmc/core/host.h
>>> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
>>>  void mmc_retune_pause(struct mmc_host *host);
>>>  void mmc_retune_unpause(struct mmc_host *host);
>>>
>>> -static inline void mmc_retune_clear(struct mmc_host *host)
>>> +static inline void __mmc_retune_clear(struct mmc_host *host)
>>>  {
>>>       host->retune_now = 0;
>>>       host->need_retune = 0;
>>>  }
>>>
>>> +static inline void mmc_retune_clear(struct mmc_host *host)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     __mmc_retune_clear(host);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +}
>>> +
>>> +static inline void __mmc_retune_hold(struct mmc_host *host)
>>> +{
>>> +     if (!host->hold_retune)
>>> +             host->retune_now = 1;
>>> +     host->hold_retune += 1;
>>> +}
>>> +
>>> +static inline bool __mmc_retune_release(struct mmc_host *host)
>>> +{
>>> +     if (host->hold_retune) {
>>> +             host->hold_retune -= 1;
>>> +             return true;
>>> +     }
>>> +     return false;
>>> +}
>>> +
>>>  static inline void mmc_retune_hold_now(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       host->retune_now = 0;
>>>       host->hold_retune += 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline void mmc_retune_recheck(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->hold_retune <= 1)
>>>               host->retune_now = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 7c86efb1044a..114febd15f08 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>               goto free_card;
>>>
>>>       if (mmc_card_hs200(card)) {
>>> +             unsigned long flags;
>>> +
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->doing_init_tune = 1;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>               err = mmc_hs200_tuning(card);
>>>               if (!err)
>>>                       err = mmc_select_hs400(card);
>>>
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->doing_init_tune = 0;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>               if (err)
>>>                       goto free_card;
>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>> index 284856c8f655..5e38759c87f5 100644
>>> --- a/drivers/mmc/core/queue.c
>>> +++ b/drivers/mmc/core/queue.c
>>> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>       enum mmc_issue_type issue_type;
>>>       enum mmc_issued issued;
>>>       bool get_card, cqe_retune_ok;
>>> +     unsigned long flags;
>>>       blk_status_t ret;
>>>
>>>       if (mmc_card_removed(mq->card)) {
>>> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>               mmc_get_card(card, &mq->ctx);
>>>
>>>       if (host->cqe_enabled) {
>>> +             spin_lock_irqsave(&host->lock, flags);
>>>               host->retune_now = host->need_retune && cqe_retune_ok &&
>>>                                  !host->hold_retune;
>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>       }
>>>
>>>       blk_mq_start_request(req);
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index e0e2c265e5d1..e7bddbafd1da 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
>>>
>>>  static inline void mmc_retune_needed(struct mmc_host *host)
>>>  {
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>>       if (host->can_retune)
>>>               host->need_retune = 1;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>>  static inline bool mmc_can_retune(struct mmc_host *host)
>>


