Return-Path: <stable+bounces-179163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF2B50E91
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA353BF156
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6A302CBA;
	Wed, 10 Sep 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaswTyjc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639C19D89E;
	Wed, 10 Sep 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487386; cv=fail; b=bgTfOPp7Y10T9YoFbEFTkKGCogB8sMJWWMQGbKkNTbXTswsTy+eUnYKzzA1ehyH5PPbHB9KVkzOaE/cA72Zn+1BakWOQCZRUKQx73QvsY4ftrCFEzF05CiY92avz44tDtb78FCTZZev8OXHuYrGpiGuTOG2Ug+bqOcwaim15Moc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487386; c=relaxed/simple;
	bh=IqiUPWoNKsAQXAsYRu4lw+BlBrq5VEadSK1BataA8Yg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5rTnIAcHWj0yUzqhvfnaF+yi59BZ7cxVtjIjazDzkfeqoYoJtn7Kw/eC8wBhRLGQGz+C/WFJa3SwEvX0VHoVArDMwV0iNY5Xd9zyTjJnIBNScgQcRwOX+16bDcVL+iNlji+eUGlv552cgumvLSNYzQKSqCdOoURx+T95x3ouMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaswTyjc; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757487384; x=1789023384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IqiUPWoNKsAQXAsYRu4lw+BlBrq5VEadSK1BataA8Yg=;
  b=PaswTyjctASTI3NwG1+pJKQRF6tZ9CZetoOXvJNhY2ofMkhoTQYuqTyL
   8IMQQbYm8hFgDAW6mQXgT7yKFh6Bej1xJEPy+tzljf+TCcXOQU3qPmnXj
   vsF1KH2W6B0AeJR8canRbR1VnUAMEi+9NRzohJFWc3DTBnjsLQLcZJnUC
   OzfZm2rYp0kfpC2LAQV1uSXxzeguT/RAmnbT+SCpMu02lH9IxHvFLnGJj
   zP+lU853Nzwfs1s40UtMKd84bEsG3Wf+wUB3FEKchJZ47WeNrPDankwCu
   /hSPc1LRRwtTGGcyeigjPCuUlVhZC/pT1aoSo3e+idJs/hrkjjMB3yS5N
   Q==;
X-CSE-ConnectionGUID: UBBzEwTDTsSGxAGAk35ekQ==
X-CSE-MsgGUID: fNyF0IzeRzCr2fvmeQRCQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58828281"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="58828281"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:56:23 -0700
X-CSE-ConnectionGUID: DN3UbdygT/a1QZLaauNqwg==
X-CSE-MsgGUID: sQJ++VM4TQCCIB7cHSx8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="177639526"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:56:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 23:56:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 23:56:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.63)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 23:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c56rnbZ6MoaekuoCZTXGhqL1UeGY6bcZJJPVPQziX3D+QNjdW+Y92Lg789Y/FhbcIdlTRkKWDrsPFkC3XEuKNLn6L1AOyrHDnrIPs2oVEWyvL301H7WZ6hTp0pxYFVZ7rsGrsiwxT1GW2IfE1bD4l+Y8lRtoJlb771Aan95E+TIU/ldksf7QkDgQmMyekGLZP5u1w6FMZhlAjnIvGSqVM8ZwLqt3EMBWA5+lbCwEweBB2jTClWjrfjci/IbL8LY/75zkhxcw6dIIkjVDJ2JuYs59T028bZifELr8hXaDCAE3jR3vX4Q516As6L8r7eqYcBI63GbBm31ppec+CwKzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBWKsV3a/23LeVN2WZq8RBkA42hmavMCN1VuIVqYYyY=;
 b=hhpqLvTHlaEMhNsqru8vpXT65PtIPb5rcwl7qup/4sLUIBFiIkArC7erAew4s8UcXqNT0VInmk4A+eiHJZHipdB4A0d8QlNRsRvbdrwRdeN2TfH/JM9nWB4rQatd3PEZaUQRYJ2YWKbfe985bHCWwfRXnceXWZ1LvAXlWnEb1rQ8nm+/yhiyFtgQCmbdN5802R9br3GsEv34AwBOvFXLNo5xVbvymR1dUszLmcW1ItpU97uRT1xonRdrEomHrC/dwtDKiDF3KKbNs3a+uB+X9GTRmbONk2ChFupYWsoAuaiNKv9dPy4wI+od+6EnQEGj3YHae6BZFyXcGxnB+58aFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH3PPFA3FE8A23F.namprd11.prod.outlook.com (2603:10b6:518:1::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:56:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 06:56:19 +0000
Message-ID: <9000ff37-66a6-4e61-84fa-dadd2d187801@intel.com>
Date: Wed, 10 Sep 2025 09:56:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
 <eb3ac2d225b169f72a0ad33fd1754cabf254335a.1757056421.git.benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <eb3ac2d225b169f72a0ad33fd1754cabf254335a.1757056421.git.benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH3PPFA3FE8A23F:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8caa25-14c4-42f6-240c-08ddf03724cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWU0SmFvbm00eEVqeXU4b2FFWmU2S0tTVFZLT2VRdFo5L3NXenNnQUFGS2Fo?=
 =?utf-8?B?YjNJdW05L1p0dUJXUVZsUUdvQkRnd0t0aTBGbW45eUNvUjBYbWhrbXIybWc5?=
 =?utf-8?B?R09yc1liU2JhaUM2em1HNUppb1hFNzFFRE4yT2dFLzdVQk1CRWZ1MFE1UDZx?=
 =?utf-8?B?NkNaMUpiQk1ESXlLWlUzNEZoSEtYNkFteEQrNXExQnkxWWRHWWo4enJlbzJa?=
 =?utf-8?B?QlJWN2JUSlJXTmxseWVseXdFUWNmaWhiQVI0SHljR1ZrMm5vNVhoNTV1RXBU?=
 =?utf-8?B?elkybXpxU1dOa2NTL29XSGY5V1FPWmNhbnkveW51RkdDUldLN3hDSytsaU1O?=
 =?utf-8?B?TGZnTWd1bllPck4rTjgwRWtEekFZTVIxejFKU04rcXcwU0Q5Wk9WT25OcFl6?=
 =?utf-8?B?QWVYTFJpZWt1N1FVQWVhT3owS0tjMXdZVkdUc0dhejh6K0ZwMmJvcHhaQmFV?=
 =?utf-8?B?akxlNlVkem9od1pWMWdJOTlkMHVqOGtLajJwaU55cC9xTC9OMWs5cTNrcGZn?=
 =?utf-8?B?ZDUvT3ZMMGFBdVdtTXYvUlFia2ZyYlZYUEFOU2VJOEUxcDU0dTlGK1pXQnhN?=
 =?utf-8?B?ZWsrVkdSNkFuQUNaaitSbzJwL1Z5SHJwUG1PTFViUDQ5OTFCSFp0NEsvQU0z?=
 =?utf-8?B?SERDcW4ydnpYS2dlZTQyR3VnRUtmU2t4VlB0MDlSZVJhRjgzMUE2Y25YblJL?=
 =?utf-8?B?NWhhUXJQVDZaSnJrTXNjcDkyVGZFZ0dNOHFOYzEvaXdXbDBwcWJQN3Q0dUJR?=
 =?utf-8?B?WWlabUlUbVZESXRYdHRGVHdCUjRjNFVxRDE4OStWVHk2WFg1K1RXY3o4cVR6?=
 =?utf-8?B?VWRXc3ZsaFA5V3llZTlveDVwU3RXakd6WnRTWUdUQjNudEo4OEQ1TlY0QUNT?=
 =?utf-8?B?bVBKbTk0aXFrYzRNblM4M1hESXphTUJuelZkOHhXU2Jza0o2UmROR3BMQ25r?=
 =?utf-8?B?aTBmQk16bEV4ZkNqS0g0dGtYSkpXOEs4S2lkcHBjSlIrQlhDYmZPTm9iSXlR?=
 =?utf-8?B?OGVpMWdnU1ZPS3pqSkRHQUdicFVyRVJzZjByUW1QNkF4cDllc0Z6Y1FscmVy?=
 =?utf-8?B?c1Fjc2UyYTRVQTFXUWZ3V0lacm5sODhzdUxJSGRta1ZHelVvQnpRK3FZTkdU?=
 =?utf-8?B?NE9rZGROdVRyOE9nREFsd1hEUXk1UGtJKzZvSDhFUjA2ZHZ2bVlzbmFBOTVN?=
 =?utf-8?B?RXVENDZvMUxQZ0pzY0JXRUNEVWhsQ2lVNUg5WTZ6T0QyS0xSUEpWVXJ3VDI3?=
 =?utf-8?B?MWw5bFNVbGZGdURQOHVhbXpIbUVzZ1AzNjR5dUpMRTY3SFhmNU50TVlmenFs?=
 =?utf-8?B?c0E2NXNya2xrWkppZzh1RjdxeFhZVFBhOGtvc2pneC9UNWdtYjlmYlpsN25j?=
 =?utf-8?B?cHBENG05bXBLMEhISDArTHJZRDNDYmliZFpGdm1DOUJaSVJYYVBhM2I2YkZ3?=
 =?utf-8?B?QnYwMk41ajMvUE5qRDJCVU44NGFReVMvV3VUVHF4TG51Zi9hclYxZFR6bkZz?=
 =?utf-8?B?djBQMWo3MGZDYWtLUTFucEtoN2VNV1ViUGw5Q0grWG5ta3FVQm0xdk1VK1Uy?=
 =?utf-8?B?RGxtMU40TlFzUUQ2NkprK1RHR1VOTzJ3L2o5UWZsSG5yWEIvdm9aVDR0UGM5?=
 =?utf-8?B?Y2lCWkkxRG1Ya3p0MlcyeDg3QnVFQWJhSHlPS0xJZmVZNmo0djRSWVdxaitl?=
 =?utf-8?B?S0JhUzRKZUJEdE5VdDlBajBUc1l4WkU1ckJSRGxUZVhRSDkvMDZYUEJPOU5N?=
 =?utf-8?B?a2tERVVMOGxsbnFOWDdnUTVuM3JYVFoweUFRMWVCcjhlM09qaEdEUEI3Zmx2?=
 =?utf-8?B?UUxvNW1IOHppK3pXTlh0Q00ySGloTHJWNFJYSU5wTC9tOFlBTlJhRTZLOThr?=
 =?utf-8?B?T2tXOXd2ZHdML1hlQzdYa04ySExlaWJ0OXZHZnViZUdNMlM2UDBEcjFLaFhh?=
 =?utf-8?Q?y/wUAgaQmVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkF6WldERHpQZGlPaXI0K3hOaUt1OU4rdDAxZncrczVtbmcwQk50SVhrSTZP?=
 =?utf-8?B?amRHa3VvN1Rla0xmRHExekJzZjBWbkNOSTJCeFJMRWlnenN5aFJUUzIzaHIy?=
 =?utf-8?B?K0FDNWZIdmJ6Q1FsZU1sa0ZTa2J5dnlpUko0bnJwb2NqQzBoZThzcVRJU1o1?=
 =?utf-8?B?Z2o2TzlVK2xEVjhDamJhU0huaW9OYUV2UjZRdjVueVcrYWNFNUFxZFl1ZytE?=
 =?utf-8?B?Z3FqSWZNNE1QeGpTT3RPMzBpRkhVY1BKWmtrUkwxNytnQmVQZkVKdE9uQkZC?=
 =?utf-8?B?blFvdURFWDdDcmJYMXRSNzk2cmhTRUJWT2hEZ0ZGY0lCUUxCWFBzUUZXZEVv?=
 =?utf-8?B?ak1qcXFpaThrYm41b0NaZFV6VXJOeTNPTTBtRFROVHF2MjFqWGRMQTFvbDNr?=
 =?utf-8?B?RGVBQ2k5OFZ5bW5vOGlBcE03NmV4M3I5NFVZL281ZnZYeml4UGJVeUZJZ0pU?=
 =?utf-8?B?WDdnZVV1MmZucGh3TVZ3WFE3d2RBeFJFc2VWYkZOdXJHSmNLNExyVXBqWmly?=
 =?utf-8?B?TmxxZnlUQ2oyWUhmR2RtdjR5NjYzRnpaaUV6cUs0YkE1eElTQllzSVBtUHRT?=
 =?utf-8?B?VnRJQ2dzbXlaZ2ZlZUEyRktOOHpVci9oNGEyekgrVUMwdDNLTXcydFNrbGVU?=
 =?utf-8?B?cXVNYnZxd0xMcDhPeHI4RjVTdG94V1RTZTdCSHFRTHRMM3haTkw3V04wZU90?=
 =?utf-8?B?V3BWZkNkY3dVQ0Qvb2VrU211aHNaZmlhOERvdW9aYVZ0dDE0c0tEdnR1ZE1j?=
 =?utf-8?B?akRVSlZIR3JEZTd3eXhDaVozSUV6NFduYy9UTi9lSGplY1YwN3JZdlR5M2pS?=
 =?utf-8?B?SEJXSHlESTB3YWdXZWxNODNFWGl4NnZuNG5qUjgzamdSQXZ0SWEzNENSTGJJ?=
 =?utf-8?B?NFIzZjVnOUs4SVU2ZXh4RXhBakhwQTJqS3NlNW1ocUlrRmhFQ1VUd1dNcHR2?=
 =?utf-8?B?WmJITVZ1QkVJS29vVUswZk0yc3VzWEFCb2lETWJqVjFVdWxGN3AxY0FQZFFF?=
 =?utf-8?B?S1lqK3JmNmFkQmxXVUp0NlZTUGYrdzE1eHFCRnc3WCtxZlNtRHM0ZkRKS21p?=
 =?utf-8?B?TmJReGRmdWxweFMxREJ2NFoxK3o4aDdWcTI2MTBuV3JFYlRIQXFXaC95a1h3?=
 =?utf-8?B?OTdOUm1JZU1YZ2xXamJicUd1VHNSd0p0YllsRVVPZnhja0E1QXcySXdEdy9Y?=
 =?utf-8?B?bExjSEtoSXNJVEJNallUNytiSXdaSDhnbmswTnphUUNwcWtSN1RvWVVKalRO?=
 =?utf-8?B?enhwc1d5M0tGYWU3SkY0dEdxNDR3UEREWjdaYkc5dm9ldDAzTE1NVmNJQkU1?=
 =?utf-8?B?WnlpamhKU3dmR0o5OVRZU1Z0Q1FzZGc4WVNIaHhBd3l4TTl0N1AzRmhYN21u?=
 =?utf-8?B?dGlkYnRZRzRwaE9VZ1MrTnM5L3RpTzJRUkY4UlRIODZNODU4RHptRFdUc1Vw?=
 =?utf-8?B?ZVNEU3pQTW1obWpTMzFSaWdtV0hLcStyL3JPbFJ1czIzRTIwYlhlZTFvdHZw?=
 =?utf-8?B?WEpka3BjbXFuR2VRUHB5MWt2a2k2cWgydllPZXdCTk5KbktqeWR4SkZVRU5w?=
 =?utf-8?B?SjlOdUpCa1JzYmZGWXhlLzc3NkZFalV5dEUya3NIeUFiRDdqRTZVSFNmOUQ5?=
 =?utf-8?B?ZjViWFY1R2VtMUtiY0cyWHYzYUduWHY1TXE2UjNHU1pVU2Z6L1NRSFJxK2dq?=
 =?utf-8?B?LzJMUEt5OGtTdmJKRkFId0M2aDI3Q2dMMitTMklGam9xVUJBbDJ5aFk0UFVF?=
 =?utf-8?B?bWZLRmVtaEZTdkk0L1VROGluNk9BVUdad0VQMVFQUDYraUdWT0VwYWQ3Zk12?=
 =?utf-8?B?b1YvWmFid0V5WnFlRlFnZFRLUWk4WS8yWlJHTHVEcFY4UTNScmR6VG1Fb1gy?=
 =?utf-8?B?aUIrUzVKTWwrRmpjQjQ1Y2ljV2JCekd5Z1JxbWRTL01QbGNhbHdvOHBXR20v?=
 =?utf-8?B?dlZjNlRqNWEzcElBb1BtaHdjdStLMnhqUnZWN2JlM1gyNEJqbmVTVW0vK1hV?=
 =?utf-8?B?ZGFmVTVweEZLS1lRUG9BVjNHUy9XRVVFYUtLK0NHZHkxRXo1c2E5YmU0TXJC?=
 =?utf-8?B?eFFoWVMxMnBPd0NOa2hud3N1bGE4cy80VFdRRlBIeHBmV3lxb0lvTmlhNi8w?=
 =?utf-8?B?UEJQaGVjcytsUlN0ellkUmdnOG42Wkl2SDkrTXNhcTB1V1cvSWR1M2EzTjkr?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8caa25-14c4-42f6-240c-08ddf03724cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:56:19.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbQBv/7qXXuNJgbexYFeLLUG+JDesjOuZMLiRxcxmjYr18s2Welq4mdg9meuiYgFI0ar4ZHA/rSGkCbJUligxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3FE8A23F
X-OriginatorOrg: intel.com

On 05/09/2025 11:00, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> According to the power structure of IC hardware design for UHS-II
> interface, reset control and timing must be added to the initialization
> process of powering on the UHS-II interface.
> 
> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2:
>  * use sdhci_gl9767_uhs2_phy_reset() instead of
>    sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_deassert()
>  * add comments for set/clean PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN and
>    PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN_VALUE
>  * use usleep_range() instead of mdelay()
> 
> v1:
>  * https://lore.kernel.org/all/20250901094224.3920-1-benchuanggli@gmail.com/
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 68 +++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 3a1de477e9af..b0f91cc9e40e 100644
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
> @@ -1179,6 +1181,65 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
>  	gl9767_vhs_read(pdev);
>  }
>  
> +static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value, set, clr;
> +
> +	if (assert) {
> +		/* Assert reset, set RESETN and clean RESETN_VALUE */
> +		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> +		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> +	} else {
> +		/* De-assert reset, clean RESETN and set RESETN_VALUE */
> +		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> +		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> +	}
> +
> +	gl9767_vhs_write(pdev);
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> +	value |= set;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	value &= ~clr;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +	gl9767_vhs_read(pdev);
> +}
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
> +		usleep_range(5000, 6250);
> +
> +		/* Assert reset */
> +		sdhci_gl9767_uhs2_phy_reset(host, true);
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		usleep_range(5000, 6250);
> +	}
> +}
> +
>  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -1205,6 +1266,11 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  
>  	sdhci_enable_clk(host, clk);
> +
> +	if (mmc_card_uhs2(host->mmc))
> +		/* De-assert reset */
> +		sdhci_gl9767_uhs2_phy_reset(host, false);
> +
>  	gl9767_set_low_power_negotiation(pdev, true);
>  }
>  
> @@ -1476,7 +1542,7 @@ static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,
>  		gl9767_vhs_read(pdev);
>  
>  		sdhci_gli_overcurrent_event_enable(host, false);
> -		sdhci_uhs2_set_power(host, mode, vdd);
> +		__gl9767_uhs2_set_power(host, mode, vdd);
>  		sdhci_gli_overcurrent_event_enable(host, true);
>  	} else {
>  		gl9767_vhs_write(pdev);


