Return-Path: <stable+bounces-179235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E40B5288D
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B54566A74
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583525484D;
	Thu, 11 Sep 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJGfXefT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD0238C04;
	Thu, 11 Sep 2025 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571267; cv=fail; b=J6BJsNv0ZOTzvg7f40BkuxBPbG/Tl3e6qw9chDZhXtN7zix0Pqy+RBFc1Z6erji3Nw/1MKYWq0Bc6WMe7FhgzTaLItfOJ6E+yvqnBmencGcDo7YWlmklP6RUartTtRL0kwG/LvV5Fsh34Vtpck7la0ggMwaX0h5UDiQxmpE63OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571267; c=relaxed/simple;
	bh=jXZ/qwiZNCDDhzSPl5k1vUYebRF7RU2PEhPPMuqi9RM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OIYTuC0xNzF/Lnp0McYslhFe41eVzzF3Xj20KvxymG0eCmpqX3aSzXS43bK/0B6dXxtJhJU+ny7DTS59ct7pA7hjbYDX+T9Qmd0cDj0Es0xJW0BFrly2fFuVdyQoJ/flLaiksqO6q38DM/50TCCgv8T4fpEclnF/TaNUFDpbd8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJGfXefT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757571265; x=1789107265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jXZ/qwiZNCDDhzSPl5k1vUYebRF7RU2PEhPPMuqi9RM=;
  b=WJGfXefTC3Jr/F5cCDe+0CXObdInLIcy0cEXNV74ZF1vVrwOOgL65f/4
   OXxBw2rhBCU3AhFRVdsYtayoJQIrRQWsAT4je1IVVyAynVkCCbphNh7jk
   Dz/RW+Ls8xe+yAcdKiMdyH+KKSK40EW/2pAayMSREVG/1ueyWTV4KxZuP
   EtxiVpjuZKK0Hb28eWq5lgZ4Wb9+ORqC3Dl5et9ulavw48EIb1PaAPKdD
   Zj0yvUKamMyzY+7jg1rpXnr/jPOa1fC2aAo8U5+DZ6yhlxLzLDo6HLH/T
   sufnP8r823tyj1bEPWvZHxkopWr0PPlFR/j8WmJGzwFZzPt0O3TBWiUNc
   g==;
X-CSE-ConnectionGUID: Mj57jrncTUGUuNGWczhupQ==
X-CSE-MsgGUID: ypRQv5xsQ0Wy/YIMCLbtOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63527669"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="63527669"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:14:24 -0700
X-CSE-ConnectionGUID: 7gM/WzK8Q+6Yqnb3Kpm0sw==
X-CSE-MsgGUID: Yqi4z/DoQ/OGAROOtHLSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="177936097"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:14:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:14:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 23:14:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpKMpDpPtsqehlUruVYz7G6IA/8v4pSIQ1oqQ0k8tuUBeKRJ2c4Tjt2BQijTidvR4v6D4P4s++SoFjjJg+jQa/3aL0qTEB/ascYxPsGhDPyu6olzOCdmyr87eGjaCKqM+VF63HBj2Zhs8JrplBlibKgVpyafoBE8bS0XvS9ikd+lb3rHAueuPaGMXvLwvk2gpxVu38rFmrKUgvd7Cri5KHFlJ3wUAJfdUZa0yphDxYUUZz3+nLK5jQ54a1nyNpBPVTBteHe5soYVlHwwiiMR1KOYqgW4kX1USkp18o8t4kxzAAfy3WWrTSCtGJFpZyKNWHXc7QU7LB+3HWpXx4LcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CajWkOpF0jTbik0R9fnRAkEEQiSuO7nTX7M2NnMDRPg=;
 b=m8ct1PWVr6uyeX/gdcSv5WYSHI+kbRJUVvZhweZfSMULvgDGOtzfbAttH0NG/xK9UfgwIAoUNFaqRH2byd+GhNJUlKxn9eY43kkP1NKCKKHWPxwC6Q66/qLa/wJ1CzQClNtFn3kbI7A1Ipoo4ObIUvUAXDGGzFwR3WMf+1hFMsM8EsBrGmlrDVwsg3l2o6MpgtQP+IGk3ZvpnVWpamLGUWuT7IwlSd+cIovQbnyTUjzdShRsdsjcB7Wzv0Xn+akmuY1PThvF2wNIPXc0ok4CfNhWTSUIxz5auVZyFRq6ayjk1UAVd2jZkxm/RCwY/rtJin+PN+PuMbforxZVdmwgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:14:20 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:14:19 +0000
Message-ID: <a2c0eb35-9899-4d23-a429-2b50a555beb8@intel.com>
Date: Thu, 11 Sep 2025 09:14:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Move the code related to setting the
 clock from sdhci_set_ios_common() into sdhci_set_ios()
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 805cda5c-7262-44c0-7350-08ddf0fa719e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDRscENDSE1aOFpWYnNnTVBnWTVmU0xsSnFSbldTRGprcmVoWHZVR1g0aGtQ?=
 =?utf-8?B?M0t4aUE0NkRmTFlyYWVISkNraGtxNDUrL0tNa3pjZCtYaE5PS093ZWRncTg1?=
 =?utf-8?B?dWNlWmJUV2ROZ1ViaDNwQXFLdEYrZHBZWkF0ZmNjeG1mVkJwQ1VXMFNYbDdh?=
 =?utf-8?B?VytFZEx1VFJXQWJ4NEVyWit0b0FIZFNVQzk3bkRDc2FxV3B0MWZXVDRYVFEr?=
 =?utf-8?B?dC9GUlFHTGlLd0U3amlrUkJKeEtXcnVpOVdTQ2I1ZWtTMHFzMm96ZitpUjZP?=
 =?utf-8?B?eVo2SEdqM0o2SWVOMnRjUmZYSjdUTC9MbHVjUzdnSnhxN01oZ0RNVnBYOG9t?=
 =?utf-8?B?MUJQckllTmhOUzRvQmFlYUhjUEtSSkZKUitiNyt3MGNTRkNkY3AxamNIc1NN?=
 =?utf-8?B?NTZ5MUR0akcydzRLTmk0QmRVNHIxWWVlVm5TQ2lsdm4zZDgwcnNCcXhteThs?=
 =?utf-8?B?UkZFNVdUZFZHZ1VUZ0VUa2xlR3hWVmVqZUZNZEN2Q2d2ODZCaEgxL1FaaHBF?=
 =?utf-8?B?VXgyZkY2QXAzcmNzMnJRSVhNVGlEK2NXSHpiY3ZWb01teWQ3OHhtR2JwVGpB?=
 =?utf-8?B?T29XazNRNVhzTTBoaHhQL0Jzck1uNTVIM1hiQjdNZ0w1VGhhOEZ0TExEbXQ1?=
 =?utf-8?B?YVFUZURoZXVxaDZJUmFVdkc4eVRrK2pnS2tScTlFalZ5M01CRkowdk1zM2pZ?=
 =?utf-8?B?ckxYSitvQzVJa1UvRTdaZ0xhbW1kUVcxNDI5MTVLaHhzcVBQcklsYnBIV2w1?=
 =?utf-8?B?VzJFNjBmYVd5UkhyTTBHbFhlMGlHVm1BQzNHRGFwNFR4WFJjV212S29XR1RY?=
 =?utf-8?B?SzE1WFpNOTJUd0g5dHY2MDRNR3VXRE1zcHpRTEROZFdMejBhQ0kvdHZwbVFK?=
 =?utf-8?B?UDhNSW5nN2g1a3Y2U2ZpNGhEMENpMU1oVUw5L0d3bU5NZDEvWktNSGVaZ2FY?=
 =?utf-8?B?L3dqV05IaHdGTSs0d0VwR1MzQWM5elh1Nk9ZREZSSVdQOTVsSVRNK01VQ2wv?=
 =?utf-8?B?SThTTzl1K0t3TkNaOSs2NFZnL2o1M0VwVHl1YlpCSGxIK3ROQ3I3Rkg0UkZI?=
 =?utf-8?B?MWtPUm4rUVhyRWsyZkVJYjlXTld1Y09GekVrYUFsQnAxNGlzWnFlT0NvSUNV?=
 =?utf-8?B?bUh3dEhtTXFTMWxhaFNDRytra3FibWNOelpHVmRQNXZLUUR3d0ppeXBETER1?=
 =?utf-8?B?OE14OGV5Z1lNTmFodVdobFBxZmZWRGVvQ0ZFZ2V5dS8xcmh0WW84MlRpemk5?=
 =?utf-8?B?M2lOeEpUVjZRK0hPanhWYnJCTStkdGluR2RPVW54cFRFMnN1ZVg5UmhGWGIy?=
 =?utf-8?B?WXRDeURBckkyQWZoazlDSkU5UFhuSHBoRE43K0p4WkhUVk1WR09JbkxLekJI?=
 =?utf-8?B?UEtrdGxHWmhKTlViNDI3NHlmOFUxdmR4YzZyb3l1U0l1aXRDRVlNWHduVmgy?=
 =?utf-8?B?VWJsdnpqcGN2dStKNE9LV1h0OEJ1RENFWC95UkxNaUlaZkJ3ZGVTeDhoc1hp?=
 =?utf-8?B?dlpKWnAwSHIwNXBRdDMzUjFsN0t0aklVeDFFbVFwYWtPUDFnbzVUY3RudG1K?=
 =?utf-8?B?ZzhVb09UcG9pU0FsYkxPQ0RCSWs4ZUFMQjhRU2pDaEQ5d01hQkNWejRBVUZu?=
 =?utf-8?B?ZE5EWjU3d0JmZzgzS1hNWms2bGQvZ09UbFJ3TmZoNEVmc2gvZnZUaHNhbXZX?=
 =?utf-8?B?ZWQ3aEl2cVVESUt3a08xS1J4cXpUS3BPSjV0bDAzenJoMk9zM281ekwrVVor?=
 =?utf-8?B?dnlqbWhVdW1zY1ZKYkFKMWFMRG4yRFRUU0M2WVJEaFlBMHhuTldtR1RWNlha?=
 =?utf-8?B?aWsrRndiQlJZckUzV0pvbi9EVHhqQkhGVXRVNEZvNjBRV1h5QXV4NW9pczRk?=
 =?utf-8?B?ci9saGRkcHJRR05nbEVlSXAyZ0lZc2ExbmpYdVlkb05YYTBBcUNUUG1yWDc4?=
 =?utf-8?Q?MALvqP3ZN/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elQ0Q1ZjU0w2a2UwcW9QUTF4ZkoyalZ3WGpDNUdCYXJCTVlIMk1hTGl4bEJR?=
 =?utf-8?B?UE1Xb0sxSXpyOGR0OXlIK2hjUTk0OXBUcWtSZTVlclM4a1R5OVQvTTVvaHI0?=
 =?utf-8?B?OUtHbHB3SlFqRzFrbXJqNERZNXVNb2VjdXBpQVA3WGY3QVpudnpuOTkrbGVO?=
 =?utf-8?B?azd3QnVlQUtoTGt3Z2NPTmZNcHcwN214U3c0L2loS1BuOXU3RGtWWVZ2V2h6?=
 =?utf-8?B?V1Zmd2xnRXBqZ2VocUJOTFFTWG1EY25Bb1VYbEI1MDZmeDh1WU4ySVdRSUIx?=
 =?utf-8?B?Z2tQTStJZW5iRENZenVkNmRzQ1ZtcGtXQTFZOUxTTE1LakdFdjRJTnJwSWxp?=
 =?utf-8?B?ZkF0d1NNZXBCZlVpclRXV2F1K2tJVlFxM2lvQzlOdkxVNjExMjBFSldpdnl3?=
 =?utf-8?B?S3hGMjQ0UmIwSzVGWTllbGN0OVVqanh0Y0hZdnlQc09FNWpoVENhamNSdExn?=
 =?utf-8?B?bEE2cmxYeUorcXBjeklWWGRUZ29hWXlRN21iYzljUmdsK3J3Yk9PWWNHb2xq?=
 =?utf-8?B?ZUJKdGdVSzFKT0wxRTFDbi9mYXlFajJxS2sydHd6SFh2ZjVHbFY3Z21na0Va?=
 =?utf-8?B?UHdndUFocjA5cWxNNHQ1aWo2WHdVdWIrOTZOMDQrU25vdlRGNlpwYkNFTjlj?=
 =?utf-8?B?SmlVdzZnR2hLTVJYSDZ5MEVPYllVemNiQmFoaElSWm5xTEFvbzZpWTBQL2Ft?=
 =?utf-8?B?U3lTN2FoQnovaWd0MFBaR0RqQzk5eGwyNXhkU3pqcDhGV2c2Y1NReXJreC94?=
 =?utf-8?B?ZmdUNjZqbGZqVXJZeHRVOUROWlB4NExqNWlncy85ZWF3N0FlR2tZOWY0ck1N?=
 =?utf-8?B?WWVDd044L3dZT0NrcjdEdDZQWng0UGUrMW9jbm1iTlkxM04xci9tUzhsNmJi?=
 =?utf-8?B?Z2ZvSzJqTi9RQVQ1dmpXU3ZJOEx5NmhjRkJES0psRkhBRlBkVWxmeUtZckMz?=
 =?utf-8?B?MTh6TWNYNC9lUUdSWm9yMnhYbS9GVHNnUjd6cWorUjFHamg2S3ZkbXVCN3Y3?=
 =?utf-8?B?SEk0U0d6dGg1TUNrRG9XdDRCRkZnaUExWnNWZ2dXTU4xT1hyMFU3c0RWS2JJ?=
 =?utf-8?B?QWhVMjlqOE94UENZZnJsNTV0emZMR1ZVN0lqZHU4SUFReWZ3cm5Fb01MdmJ1?=
 =?utf-8?B?aUViQTdjUXJCYy9vemQ5RGVtMHhtTFdTRmpBV0pzb2ppMUxTM21hZ3Z1cjJH?=
 =?utf-8?B?YlQyWXU5cldVS3R4VURPdms4VjVneHlIb0FBQlU3amZPL2ZYUFo0aWRMU3Zz?=
 =?utf-8?B?VTdneW9hVFdEYkhDVXU0eXEwbmEvdnRHM2E4L3hyMFowVm4xWklCVDNuU3hG?=
 =?utf-8?B?TUcvSEJqTGo4R0YrWlFQZm80d2xMNnFWcDFjL1VhQTI2Wm9pMmoxWjV6VnY3?=
 =?utf-8?B?Q21WZ1YwWkpORGVpcG94ZnowNU5Ia3Z2U2x5cHJ4QXB4d3dhZWs4QkMxa0ZE?=
 =?utf-8?B?UzlEcXpxMy9wUHBCb0drNGNFU0FnRjNBMmNjZVRmOUw4ZFVYcHJmbVlRdWdj?=
 =?utf-8?B?RHBJNzdBTXNCNUVNQXRMSVVJRUdleStxN0ladnVaNE8yaXh3U2pTZXJ5a3JD?=
 =?utf-8?B?VmhGQkpaMXVQa01SMjQrNTQrbXI5QTV5clA2VEtHRUpjMmVHWmpoUDg3REVU?=
 =?utf-8?B?S1NCMTByVTIvSmh6eVdkRlF0ZktCaEdIRE1BR1A0cVVyMWpSTHVWa3JmZkxW?=
 =?utf-8?B?VENOUmp6S2tBdTBEdWVyTHo1S0JrbXNCUUMreTl1VVhXWkpneU5scVBMZ1FQ?=
 =?utf-8?B?d1dXVmlqMG5UQnVSWnBIS2E3endXSlpxNnh0eWljaExFSnFUSWdwcDh4SGgx?=
 =?utf-8?B?RVE0NVA1OElTZ2R1d3lkMytMeTVrd0hRNFBrWEVtWHFNQlk1NmRRZnJkTzE2?=
 =?utf-8?B?aHA1Q3JLM0hhT0NhK1hNMGV5YzJocXlJck00ZFp6Y2JnYkVwclpHb1VpZHhC?=
 =?utf-8?B?UURranRrM1JSdGpoYjlBSUc0S21TdEdyeVllb1lMKzNVaFcxc3kyNi9SUVlG?=
 =?utf-8?B?Y3ZpZXUvRGxIc3hLNmZPVDBmUit3MG5KczNaMTB3YjNwd2JuL2lpRWwxNEx0?=
 =?utf-8?B?ZVAyakxNUjBpWi9CQzgxeEZxNU94TzVmblUwNXlNYlkwcVBFVjF2Um5zU3Vw?=
 =?utf-8?B?TGtqeEVvd1JHemc4dGM0SDU0ay9CM0JkNmJ6MlVEek9yT05CcnZNWmlsWXNt?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 805cda5c-7262-44c0-7350-08ddf0fa719e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:14:19.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5M7Dw044zzg6rjUVVqOHP6cnG4+Tq19DpInzxquSlIVMtX2riQOoMrdLU0qALFAaLFORs17Gpemx5A3mXCmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com

On 11/09/2025 05:40, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> The sdhci_set_clock() is called in sdhci_set_ios_common() and
> __sdhci_uhs2_set_ios(). According to Section 3.13.2 "Card Interface
> Detection Sequence" of the SD Host Controller Standard Specification
> Version 7.00, the SD clock is supplied after power is supplied, so we only
> need one in __sdhci_uhs2_set_ios(). Let's move the code related to setting
> the clock from sdhci_set_ios_common() into sdhci_set_ios() and modify
> the parameters passed to sdhci_set_clock() in __sdhci_uhs2_set_ios().
> 
> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v3:
>  * use ios->clock instead of host->clock as the parameter of
>     sdhci_set_clcok() in __sdhci_uhs2_set_ios().
>  * set ios->clock to host->clock after calling sdhci_set_clock() in
>    __sdhci_uhs2_set_ios().
> 
> v2: add this patch
> v1: None
> ---
>  drivers/mmc/host/sdhci-uhs2.c |  3 ++-
>  drivers/mmc/host/sdhci.c      | 34 +++++++++++++++++-----------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0efeb9d0c376..18fb6ee5b96a 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>  
> -	sdhci_set_clock(host, host->clock);
> +	sdhci_set_clock(host, ios->clock);
> +	host->clock = ios->clock;
>  }
>  
>  static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3a17821efa5c..ac7e11f37af7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2367,23 +2367,6 @@ void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>  		(ios->power_mode == MMC_POWER_UP) &&
>  		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
>  		sdhci_enable_preset_value(host, false);
> -
> -	if (!ios->clock || ios->clock != host->clock) {
> -		host->ops->set_clock(host, ios->clock);
> -		host->clock = ios->clock;
> -
> -		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> -		    host->clock) {
> -			host->timeout_clk = mmc->actual_clock ?
> -						mmc->actual_clock / 1000 :
> -						host->clock / 1000;
> -			mmc->max_busy_timeout =
> -				host->ops->get_max_timeout_count ?
> -				host->ops->get_max_timeout_count(host) :
> -				1 << 27;
> -			mmc->max_busy_timeout /= host->timeout_clk;
> -		}
> -	}
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
>  
> @@ -2410,6 +2393,23 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	sdhci_set_ios_common(mmc, ios);
>  
> +	if (!ios->clock || ios->clock != host->clock) {
> +		host->ops->set_clock(host, ios->clock);
> +		host->clock = ios->clock;
> +
> +		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> +		    host->clock) {
> +			host->timeout_clk = mmc->actual_clock ?
> +						mmc->actual_clock / 1000 :
> +						host->clock / 1000;
> +			mmc->max_busy_timeout =
> +				host->ops->get_max_timeout_count ?
> +				host->ops->get_max_timeout_count(host) :
> +				1 << 27;
> +			mmc->max_busy_timeout /= host->timeout_clk;
> +		}
> +	}
> +
>  	if (host->ops->set_power)
>  		host->ops->set_power(host, ios->power_mode, ios->vdd);
>  	else


