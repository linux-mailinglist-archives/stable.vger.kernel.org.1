Return-Path: <stable+bounces-176839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B58B3E23F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596E77AA31E
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23232267387;
	Mon,  1 Sep 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS+wgIIC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71E25EFBF;
	Mon,  1 Sep 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728465; cv=fail; b=iidMW4CtNmMV4v+gkoTqQkMm4NI+MIg7daNl0q2hvs8X/DY4MnoqfFi+E2aCaydXbnY86LoWHs+Pe7PE3e8YhJr9qEgqGPt8XcJszY65QJ5U0nId7OpBija8xNXnvn1Evb+cbEAiTXI8WrBeTOim7GmWWHoomwqiavvFXTu2Ixg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728465; c=relaxed/simple;
	bh=eNXcftaHOfPJZ3Z/OK2Lbsy56MLODAUi9581a5yd70s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSM+jpmnNe9isOgYBp9KZ+bC5iNSzva0uuLvLsyuGqKjvX6uZhj4hndz/dNw1QM2BIOcA8W/tWQoeWuaAh3+Yp3sC6lvgeUp1GbM2ANono7yFl+cKxZgqpsgzm9D6i81d0aODIyoHXbU7vll8ix7XYLem2ZRQWJUsHoQ/zvqC80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CS+wgIIC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756728463; x=1788264463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eNXcftaHOfPJZ3Z/OK2Lbsy56MLODAUi9581a5yd70s=;
  b=CS+wgIICJNxVmn6Pz5hB+VoVeZdtAMVA858AeuAWJEfdgwLXDT9Tyw/H
   b4LZ3g+RZyt4+fOUnUx8MLNxqIs7CXXeFh5UeF30EtgAPkxt4ddofB4m9
   /zdnpDvlSvHEINV2TI4rATYHQ6vUs6ZWpmYbyojyoKioL0xYEWo/CJANF
   9cESad/dfOcUSDzRgSDh78olzrGQww+yJ2ZKHzVmiiB7W2GhEgQedEngh
   FdIR0CxUSabCRVCF5h5eip/YnNWRA+RacIvC2NshAcNZ6slAggrMomNJb
   qymU9/TYBuP0xGhw3WT2JL2qlKNCOm9m0qdjWpz5ItDdnVZ96ukv2Yvyz
   A==;
X-CSE-ConnectionGUID: 5eFhWtwgQPS12vbpselHxw==
X-CSE-MsgGUID: FHYxE+kESLynOvgL0o4tYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81569146"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81569146"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:07:43 -0700
X-CSE-ConnectionGUID: J8q/Dh5+S9iU+eow/Xh/dA==
X-CSE-MsgGUID: LZrLA7/9TdK+X41rItEOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170555430"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:07:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 05:07:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 05:07:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 05:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meIn4caxFz5xmUy9YmhA3oNrAn0Z/8WUjaslkbE/Zm6ShCyN4MhYCrYnLW98kFZyYaxIrSy7MfbHK+zWS7ZW1nSliW1y0gLyJwBs0QpvfhCYJzhAIPpPAcIYAEdy/t4GGEq9M+UvPM3ZciEkgu7htMVBue8Lq4pKvlp89BXdbzgclj2ZlIzr/Gz64lUPkMYlkcSUvJSj0bDjeSFgOdnPdItiyUQR7RBBrOlr+77QDMCusUKuViI/f8cP/3yrJD/V3KLi+F9bpKm4+K34Ca1Rb69XSpxjhwq8XP05y64A3Xa6nM2qGj29fWRUaOtsB9DNVuurDw45+zqPun5G39D8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEfHAzgZ30nU4IHGukFxyxnkisTWVrSioD04O2+uDjk=;
 b=uu6G6gEEN7qz1G8S4noemI8zQyleCygKAblsLAYSHEQ3eZPIYd3AnK4LvaV4k4aXL/FJjxtoNTy8pHGeGU9jJ4ZFFvmrXUHqL/c9kUi6h1Nh25PtfRV83lRXfVbwfW7IXoEUkIOWLCXZbRDElOUAcnpttKUDXq8kwpLpI3f+gncfbm579OOMqxTfUCZ0YV18RglMMHVRb4/uSsM7Artxsu1DZDB1mA7D5FTfYdKfk9vtDVrFkm0UiInUnkqZAHcs61zeFGEgm6MavLMT83IW+iVw9UFZSzZp29YVRdrkm1CSgIADFAvvo+G1O1jgOGgHcdhTBxtCcRa+pulz2FafZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 12:07:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 12:07:37 +0000
Message-ID: <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
Date: Mon, 1 Sep 2025 15:07:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250901094046.3903-1-benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250901094046.3903-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM4PR11MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f95b32f-0d62-4de8-47b3-08dde9502474
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0Z4UHFqUnF3T09mNVF2bUsza2xxVlMySkNhcnpNVW1ZSkh1aXR0K0VwMTQx?=
 =?utf-8?B?MzNaa1lvSEtOQVNGWkxNNkFQcWFpSFp6TzFNSkVvWk1sM3lBeW8rV1NJbW9t?=
 =?utf-8?B?VUV2VXVsK1ErczYzWFhWVUFtOUZwS3JzSUZwVXo4Z29hOWVqYnNUV2kxeUNp?=
 =?utf-8?B?eXRXU0MwMkphTTA0QzVGQStBVzZkRyt4SnZSQTg4YVA2b0puMVphbHova3l4?=
 =?utf-8?B?aDdOV0ZJZFZOMDNEWjJYNVlyc1p2WG94Y2hhKzlOZTRxdm9ES1M1TWIwQlRD?=
 =?utf-8?B?SlpONUQraFdnWjlRL0VRK0NPYnI2QllPdWw2RU5kenk5ZEFRcXRUR2xiV0FW?=
 =?utf-8?B?K1Vsd2pCc0tvV3JmVGJIaVBIQVNiUFAxSHpSekM4T0EvMS9vVGlxZ0I0TDRJ?=
 =?utf-8?B?NmxhaUZHMlc3RXpQaTdnajlwNTdGc3RYNnpCblZPamtMeHVRYzBRejZkOGdz?=
 =?utf-8?B?UjFuNTFLS3RVeEdjaEdmQUQ1eUFWOXhTVE9nYytNUTZOQmlTdUpMR1ZTYXlt?=
 =?utf-8?B?dnMrWk1uMCsrdGV5RTFmaW5xUTkvbXdUbG4wUUk0R3VqODg5cmNHNmZKSmVS?=
 =?utf-8?B?ODhnVTMrL1ZoOWdRcTh0TjIyclBWeDJFUytjZFN0Q1BnVm5NcGNXc2QwNE1U?=
 =?utf-8?B?SGdxL3F6WFJ6RTk3UFBrODZSenhuSm9lNFVscFJqZEdsSVpBNExFRkttUDdj?=
 =?utf-8?B?QjZqTlBIeExXVWFCRWx3NzZqOFRENERmYjdkeVRueENuY2E0YnZrSXdxM05F?=
 =?utf-8?B?c0s2TWtBWit4YjhSZk9CbnR5YVcwWDdSaHdXWmhORklHdXhCQlBlOG9hMEZL?=
 =?utf-8?B?VnZPdXlvOC9aMDFEUkJhRG0vZG9rZEtCcEU5UTJvcE9PRHdHcE45aTZMaGls?=
 =?utf-8?B?UHBBeW4xNHNCTjEyL2VNZHRCWTlVRTZCbkd4Ulp6WVdnZEJWUGZ2anUvMVI5?=
 =?utf-8?B?ZkxRL3VOTnBHZkQ2YTh0NWMzSXBSSExhVEdtQllzYzArVUFVQ2JpUzZQaEZX?=
 =?utf-8?B?bWl4MzBFeEoxdmJ6YkRHSWQ2SmlpUXB1UVppaTUyV1pmUVYyQ1JjMkloZFhZ?=
 =?utf-8?B?ZVJBUXdEbmNwQVdxN01JdGZ6djRqOUFCVVNkMVNtZXdVZ3NVUkxKcHRvelZm?=
 =?utf-8?B?VFgzRmdWNUQ4RmRXaDVlRzJpNWtwekFiWkU3SEVKS2FpQythcUtyKzBpQUJv?=
 =?utf-8?B?Y0pJTUFEQmdZLzdNNmxTeWVJbW40TlFKeHhXR2NzT1dTY29KT3JqYkFGeGx6?=
 =?utf-8?B?c2NrdmtsbEVhRzY2MG5YaGtaL0czY3FwSjI5VkkwRVBmbHV6cEtLNVBLN1RP?=
 =?utf-8?B?R1RGQTU3azNIdFZVOGVEeG50U0hwNGlRZVRIU21HYnVHY2pWTXgvREFwNXFM?=
 =?utf-8?B?TUxkcmNYQVppNkp2d2RQcHpyUEdndkgreG5kUVJIM3dxSVoxUVRzT1cvbHdF?=
 =?utf-8?B?b2NYNmsyc3haUEFNcndsQklEaldLL2FvWlRxTEhUOTM4bktxUGZIR2R2bkNq?=
 =?utf-8?B?eWthUUl3YmYxRkRxZ05oY3kxdW9DcUR3MTVTMm5CWjhnRXZ4UGRDOTBCMXI0?=
 =?utf-8?B?ZTREZTZ5VVlmSHNZRWJUOGFOL3FoSHBOSk9OZjJpNkpEa0Jzazd5ZExMK2FV?=
 =?utf-8?B?UTRFT1pRM3UzMkh1cjJrMXdzQVJlTU9TVFJ5YVRYQlVKZ2ZseEZkT0RuNlBw?=
 =?utf-8?B?VUVjamRaS0VlRzBZWFYzc0V4NmVjWUVJbmRuWDg3L2lnVnlsbVNjYWlDZmh6?=
 =?utf-8?B?cng2K0k2NHFlbm9tRE9yMngzMmw3SDZCMm5Yak9nYnJaSWNzZ3RLMm1sYkhw?=
 =?utf-8?B?aFRydExWRVMyazNkditVQy83cFhUSkJQOUVqZnJYREJyVmlkRXdLV1dTcnYy?=
 =?utf-8?B?OExQUlRxUXZlaWhvbXRaYWNJSzEwV2dYK0Q3aXdDMUxiOHdKK1pTYWx3Wmpi?=
 =?utf-8?Q?Q1RbgmYv+wY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3lGSDhEREFvS3gxM09xZFVlT3pONnRacld2TlEwanBkVUFNMnJSMDRnc0kx?=
 =?utf-8?B?SmszSjhHcmN4WXhBdERWOU5kbVVWaXVJU2YxOEhnWDVyK3BQUXUxem8xcjN0?=
 =?utf-8?B?TGFsWHJpNGRmUWdTTlBUSFVaSEVYMWUzK2xFYjgxd0w5N2xCaVAyb3dKeHVT?=
 =?utf-8?B?QzhZVnFmbkZ4Qm1VbVg0S3EyRnpoRFUzYmpPSFNNejRjWHpaUlM3OFRaNmIw?=
 =?utf-8?B?MWJybEhLOGl3eWR3Y0NPK3lwQlQ2R2dPWWRSSXVIaU1LNys1K3UrT21UcmZG?=
 =?utf-8?B?cWZXK0lHelJ2VG11ZS95eE1rb2w5Y3hnUzRuajEwN2FCRmxxamJFRk1DWWdy?=
 =?utf-8?B?S0dtenJnM0tlOElJYW1FRXpnVDZudno5ait2QnpHZXZnN0tZWUxMMVgxNERH?=
 =?utf-8?B?QTNGL215Sm9EaSs2T0FnaFhQVmpIdlQ4NXE2SUdRbFp6NEJFeE82b3FwZ3lV?=
 =?utf-8?B?eTRUenMvczhrcnFQWUdMTWRhSm9Ia0Y2Qm5MeDI0aXkvS2xnOFFyTVdlNGly?=
 =?utf-8?B?N2JCZDZVREFuOHFqS25pMXdTZFRjSkUrOHNnM254a09scE5JYVpzbVBwaHpo?=
 =?utf-8?B?RDY2L0pwVnEyQ3RBVUhIN3JEamFia0UxVnRsMjc3ZHZoUFZJMjAyTmJxQnJD?=
 =?utf-8?B?Tlo3RWtjQ1JqenFselJyeTUwZ0RFekQ2S21idEUramUvUWEwYU9BVDR3NGJP?=
 =?utf-8?B?bHRmY0ZxSkowZlFaNkdrd0hJWGJOSG5PMXlXY0MwZVNMdUs2SjNVWVdUcVRK?=
 =?utf-8?B?WDYwcVdUV3FjS3FGRTlsdnJ2TDBneDlIb0lSWEdLeDhWemM3S0ptV04rRDdO?=
 =?utf-8?B?dHJSaFR5SXZkRldpcmJkYUIxam1YS2JVQU53N1FsSEFNUW1vUGVCTkllS1ZO?=
 =?utf-8?B?ZDMwWlpDS0NEd3FCbEZtbW5YYXVHQjA0dExFOTg5cVNRSWUybHNXQ2lOVkVS?=
 =?utf-8?B?MTVGSzI5bkZWL1FLMkJJQmhQdXBGQ3VLd2I3eVlNZlFwa0o1UksrbnNBNjNq?=
 =?utf-8?B?MEJNNGhyVEpSanRhUUdBZ0ltUWV4RG9ybzgvSHBQd3V0dVhDbEZjR3BhN3Z2?=
 =?utf-8?B?SFl5NjdsUDh5cFQzUlc2WHlQRytrMVdMbFo0MVErTklpU3BwTHB1MkRya0Fu?=
 =?utf-8?B?bEwwZnlNUjdLVGtpNTVqNVZXWVJUajdmOGd1MFNkTGpHK3BjeTg1WURVZk1E?=
 =?utf-8?B?aEZaRFlGcEhKSjBqcE0yMTMrc2JWZjFvWFRxeGxuTFhUY1lVWXg2RCtsNE5F?=
 =?utf-8?B?WU94WFlYSnhJci9wM1Q0MG5RSmR5Snd6d2hnREtBcUovS0xsUkgraDNhZXR6?=
 =?utf-8?B?Ujc2a2EwVFRRV1oyQVhEanAwWGtTdHFRQnhUNk9Pcmx5OTJUdkNEUVRJUTBz?=
 =?utf-8?B?WEIzeTZUVHhWYUJCWUZ1cElic05DUFplWjRocy9OQVB1dExuL1hnM2wwWEFS?=
 =?utf-8?B?QmhkSWZmbERnKzlHVFdkeDdkVmZLem44WHdtZDg5VGNJak1uK0Z2S0NESURn?=
 =?utf-8?B?KzRGOVZZdnk4WUY0Z1gxbGFhbE1zcEFsU0txdjR4Tm0yc08vZFdXbnAvU0lY?=
 =?utf-8?B?UHY4WnJzcFhkVERJWWhxbHpvY0drbEVGc2FkZmlUM2wvY2xuOHZQeXhvK1pI?=
 =?utf-8?B?cW1lV0I4S0FCUTV4L1YrWGxBcTFLeHQ4Ti9zZ2ovNHQrWnFxTFVER25nKzhO?=
 =?utf-8?B?MDBkTDc1Y24wTzFqSVppRk5ML3JncDRGREZKbjlBRk9MaGhwWU1mdkdvSkRn?=
 =?utf-8?B?VjNreEpReXBZRm5WSnJxMVorRm5kTzhSQ3J3ZjJya3ZHZWlhMEJyUk5XNHBp?=
 =?utf-8?B?R2ZIWU0xU2xGWWl0cEc5NEJtVVg4U291UXhRaHdXNm4rdlRkWWpIN2ZzQXVk?=
 =?utf-8?B?YndTbGc0VHpQS2tRZExpWFAzMlovdU5ubXFiMS9SaXNhdm5aT3VQakMxVzcx?=
 =?utf-8?B?SGpaMUY5anU1eW55RW9zdmFKcVlQOHJneXBBWjlmZHJLMVFEK1VyYmR1Z1JX?=
 =?utf-8?B?N3BvSnU2VXJXdytFTXNWL3VGSmd1YVdiT1c0V0g5NUtBN1I5U3NDRFRQYlFk?=
 =?utf-8?B?M0J5a3pmcTlJSTFUMnltaW4rZGY0YVdsWjlkbGloVlhlVHljQkVla1AxQ01y?=
 =?utf-8?B?ZGtiRnBvdWFKZzQ0TkJSUWhJT0ZDMmw2RWtWUHZNc3JGQldOMDFweUlQZVRY?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95b32f-0d62-4de8-47b3-08dde9502474
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 12:07:37.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92BJmXxZ4/xlGzXh3bWZD3WJAKvfw4ZDn5hkAnbdDcTIbG7Dom64oOiFQ12PyuyExor3o4e7ve7XS1rikMoDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
X-OriginatorOrg: intel.com

On 01/09/2025 12:40, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
> vendor defines its own sdhci_set_clock().
> 
> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0efeb9d0c376..704fdc946ac3 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>  
> -	sdhci_set_clock(host, host->clock);
> +	if (host->ops->set_clock)
> +		host->ops->set_clock(host, host->clock);
> +	else
> +		sdhci_set_clock(host, host->clock);

host->ops->set_clock is not optional.  So this should just be:

	host->ops->set_clock(host, host->clock);

>  }
>  
>  static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)


