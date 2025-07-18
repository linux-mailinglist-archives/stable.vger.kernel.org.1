Return-Path: <stable+bounces-163326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6FB09BCA
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 08:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FA35A0256
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 06:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D22045B6;
	Fri, 18 Jul 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcYV5BlT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5A191F91
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821695; cv=fail; b=f6Fh33OvSd/JTm+To3GkUHe77MDDfsZDAflGyhAYmqe7IrqVJb3csnqRold9MVYVx9BfgZTXLvbhxgNHJOaudF7Cwmbr+rL1lgzMMWNgRj1iaHK9D5M7peAAQ7GXJGcIH2Dh7Rv+vnOClABwroh6OYrwadAQrEFyhE2T9P8h6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821695; c=relaxed/simple;
	bh=YJfsDnH5ywnnwQNLoJKs33rBim8X04Wh4z8Dlry/TrM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZ3HmR/jcPYVPXpxzMfsE8iPlr5vTEAQh5RTsv4J2VKmYs28GedLxYCBWdX9x/tB7ImPJfQN3zjU2b57HfQWOcs/RjEQRmS5+W6HJGFBbZXRUBjAYPI7ZHBTEoRZwczlczKzlPp4VqkaSTO5u1S4/omUWSjnK/iftSDslQ4h5UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcYV5BlT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752821695; x=1784357695;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YJfsDnH5ywnnwQNLoJKs33rBim8X04Wh4z8Dlry/TrM=;
  b=NcYV5BlTb/T84BrIWebBbfubyayDcVrEd0aUB7AvX56YBtTnk4cmGuFq
   ogXP7JKr6g7zBF1i2mEHQX0iL+9wvTIVmDXV5VuYGzwNf7ZUZIfFYhtR5
   PvwoIJhqKfX9FcwS4uVK3mxLi5hUq3uroshyaj5F1QleaupeByEl7unwR
   VBGcYKwLba3wJSaJXDq8/HH7tSW6M22GB5ESiSQ2XXurvlN5UTYOo2ZF/
   N20oiswwXoKsUvmCNmoIUjaXrM3kWfh9caeLaJnZ7y6pbaFIYtyRN/L65
   QYzlnW3kB77E+op0p0WEBS9qU1Fs9+sS4vM4kJVfyj4k6/2tHtz2SwbWJ
   g==;
X-CSE-ConnectionGUID: Kb1BJ48ZRU63DKeXT1o5XA==
X-CSE-MsgGUID: Kre6r0o2Sm+pTKJ9oR86dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72561527"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="72561527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:54:54 -0700
X-CSE-ConnectionGUID: wy6b79/PT2S1fdF8sDfXIw==
X-CSE-MsgGUID: 0ExUAo0LRs6bLzxKR+Ki3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="158100951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:54:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:54:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 23:54:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYTMsVap1uJ7yaU/FLU46wfpkH5R0OFZeYfLBTCQWV0GnQ/xN45iPwnyLvrd6aHSfhCGvclH3SHx/u3pTm7wFpK2daJCNamlbF46PLb+pS/AE1cCuae17Wyj3xjqRpEwSdrLIg30+IOzPQoTSYS4Tx4lcHYCzKA9bZCF+dcUg9+f8+83CgUtiz0ZzVxiOw3CMNULISl2WiACFrpq0Tt3qpG5ArBlOdmMX86GXbBG6PMfagXeTvXJB2VSIfo2u71X4SNJHkBa0y0T5nK9Ufpyw0qSC7c+NQDjFV41G0Zfg3wn/gaqywsJ9AsS7xbRjugDtASoekffxavwG2Nkbe96ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq8E6cM6h0JbO2DFA17el2t/QKtmuyU5TUjesFRnpZs=;
 b=aCkQDgWq2jLCeo8uhH89BhpupXu6yhimEPd9hF9mCjlZGyuHs4vt+MaDWZVzMbkxApszILvVMAwm8e56v13+tdQ4Bjy9TvIZsMCjxbtdm/FIuBIpt5xFlAX1REpoVEB1ls7cpzmFWPOEfmGfk4kE3uylcdCgJQAkbwH5W8wSsR9Eia9ctw1firs6OScvZqtkwnM9cnKbgdXUjkyh90lVOIWN3eTswC241HuF3aNgMZMWIBH74hQiIFzTHJ2BxJ1tWAvbdW1jv6d3tc2SljRUH1sKNjqousT8fnj9KMrOuINfwkgZb9/6jesHBHcaw3pJvbCN0Tz6WUpWAsPRbwZ6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 06:54:44 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 06:54:44 +0000
Date: Fri, 18 Jul 2025 07:54:35 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <aHnvq5RvK/UC7h15@gcabiddu-mobl.ger.corp.intel.com>
References: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
 <1752795908-8533c229@stable.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752795908-8533c229@stable.kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: cb798d9f-30fb-4f8c-a0ba-08ddc5c7fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk1udjBJdHQ3VER6Q1gzVmZMZDM0L05PaHJkUnVOblIyaksxRFdMS3pYNkNu?=
 =?utf-8?B?VEtLWG5UdjArSDAySjN5Y3dVRnV1OGVXakhBQ1NYTU1sbDB3TDgvTDllNGl0?=
 =?utf-8?B?L2tpSm9VbEZ2TnJVYjdaSDI0RDZ2SnE5THp5Vm1TcEJ6OFlRbmlCQlVleitP?=
 =?utf-8?B?bGN0dGpYdTFMRkhOZkpIdmF6cCttcHcvUTI4b0lNQlNOOElPcExiVW92aXpO?=
 =?utf-8?B?TVprcjlOWlQ1aW9Mc1hjZktnZ1Mxb0piUG1uOWZVM0wvS2xXbCs5N1JlY0lx?=
 =?utf-8?B?TzhHQmMzMTZGWm80a0MzdkhJL2dMdVNFTnRTbEd0RS9BTGt1K0hpMG9IUGty?=
 =?utf-8?B?bm9IRGI2eWlmRTJrOFl1QUFhN2NrTHo3NElsWjlGa3JEVU5oVWxXRmZvSVlV?=
 =?utf-8?B?bkJsSTJMeURKRjV3cEUwN3FPMExGUXhqdzJOV2FOR21aYm9VbHBQZURXdnJq?=
 =?utf-8?B?a1I1TDhBQmhMWHVrMGx2UERtU2RWVFhTWWNjOTVwVUxBcSs3Rm14djVuczE1?=
 =?utf-8?B?SWJpUkNqelFnc0Yweko3REd6RExySXc0cVRPbnpPN2JBQ3BoMU9VdEZ2cjlt?=
 =?utf-8?B?OHZKcml4eFM3RkFTTVJrMWpPYWtMRHBFd1h1RUVGM3RMb01iQVdrb013VitR?=
 =?utf-8?B?eGx4WjhReWwrZGRzSWxtWlpJMkgxNDl5aW1DQmVoa01ocFNSWUJJNzhUNWJT?=
 =?utf-8?B?UlRTSElCZEk4L0lHWFRlQytDVEdwQkxsZ1JpYTlEQjFJSXBzakVGbFlBR1FQ?=
 =?utf-8?B?cm5WM2FXNlprYTEvYk1tU0ZkNFR5Q2d4MEhUMlRRZ1craU5YMXBaemhjVEZo?=
 =?utf-8?B?SlBHdUNSaDZjQkxSYXIvRjA5QVZpSk9xSDVnUUliRjdnQlExanZsZEo5SG5S?=
 =?utf-8?B?SUdyenhkQUtZZFJLL2RpT1V2a0svdXd4RXFhczhZQW5pU0FRL2wyOTRsNE5l?=
 =?utf-8?B?MjQ0NitZc1RKNHRjMWJ4YWtiTTJiV0xmY2VvencvNWJlNEl2RWVrb01IWHI5?=
 =?utf-8?B?bVJoWkd5WHVVcnUrbWtLdHF3aUVMSkhUSE5UdmZvSUptL2Myd0UyL3piSy9w?=
 =?utf-8?B?ZytDeFFQc1Fha3lwZ3Q2S1R0eU1sWi9WUlQyS05oRkxRdEZFNW9GQTVhMXdj?=
 =?utf-8?B?NEdaNHVJVjFXOHhzVzJVZncxdllyU2dGWm8rcUNiMlRWQXlTZ3FhUXBXUFNU?=
 =?utf-8?B?NnF0NmI2dFBoRWpVT2NILzgzS0szeHlKeDZoREllb2tZRElpYjVpb2FpVHox?=
 =?utf-8?B?KzFkUmhtaG1hYmFUK251OFNCbW4vM29xMUE4SVVPMzdockJFMk9sOG0vVkFP?=
 =?utf-8?B?TFBuQnFQNUNMeWpmRlZLWlhFd014aGhpU2E2eklUaHVReHJFOFRreWF4QVZJ?=
 =?utf-8?B?cFQ5U2lMdmRVa3hWd0JGSnNhQTE4WnExUThUeitaeVJ4OUljT2FQU2tsRHhL?=
 =?utf-8?B?bCtHY1pDWmlaRjVpdGhGMEdrd0JmSU40bWQreENPVE9YT05WVVk1VTNMeDNF?=
 =?utf-8?B?WXROaGhvT0c1a05wY2hlVEhxMjhPWjFBbU5nTmtmZk40NUhyS0xFNzh0ajlu?=
 =?utf-8?B?UzNLZVZsQW9OUjRPZTlhZDZZUUJvZjB0bTUxOGw3bTQ2TEVxSHp6SzZVOHlM?=
 =?utf-8?B?d3d3OXlYUEgrSUU2NUxXWmpKZ3huQkhKUFM0dFU0eWt5ZHhnM09zYVhtcmEv?=
 =?utf-8?B?YzkwS1o5QmFaeTJQL0ZITkJvcnladlczbFFuTzNmSTNnd01abTRWcHByazdX?=
 =?utf-8?B?MGdFK3IrVnRFNnNUTHR4YXhSeEU4cW9mT0grSjJUcllrVlZtZjJEeVRCZ2hq?=
 =?utf-8?B?cElNNHI0Vlo3NjBnSHM1QWRydFZiYktQN0xVSWw0TFZEV2I3VGhFOHZTUkpj?=
 =?utf-8?B?QlMzaFRnOEhCK2tKckZiNXhqQzJHekMyUWFOY0hmOWNWVWhQTmRQOFFMd3pC?=
 =?utf-8?Q?UIkrM4IIglA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE53TS9TYUFvZXgwNHd0VWF4dXRLTDkrbGtYc2o3bzc2bnhMd0QrTWUxdkJr?=
 =?utf-8?B?V2xmZGhkcE5valQ0TE1WQUpFaVlOdGE4dlhCajM2VytPYm1tTEhiSndSbmtK?=
 =?utf-8?B?bDEvUkN3eUEwL2I0bmg4U09JY21YdDExQlRnRHYrUEZlRlRNNXFlRE1HNjNp?=
 =?utf-8?B?ZEVLSldUaU5DRkk4dy9mVnQvM1ZjM2U3TjhmZnhvZUlRb0dtdTFocS9Uc2Yv?=
 =?utf-8?B?NGhEVGlhWGtabHdKeGNBRFN6ZEF5Q1NCTE02bW9ydjhmVGMzQU45UDE5bGp2?=
 =?utf-8?B?Ynd4aSsxODl0RUlhelJpZjNGQzdYclExZDYrMDhiczRhMnl3cDlrQWkrOWNN?=
 =?utf-8?B?ZkhXTlJLZ3pZcUNiSjdaUElyRHc4L1VKNitHTUpxTDBCelpYczFhMTAvQUIz?=
 =?utf-8?B?ZmJwZmdOMDlwMVg0Nnl4NUt4dGpHaUtOSCtxdGQzOFFrRmt2VkZsSHJaVCt6?=
 =?utf-8?B?YlJkV0hMdTBkZWJ3WEMyajVnRjhzM1czWi8vMUtTbUI1V1FqQWpYUHFPZW9h?=
 =?utf-8?B?eU9ia0xFVjhYV3MwSmNmdlUzWkIxNGl2L1FobEtiNUlEek1mK2h2QW5iYkY1?=
 =?utf-8?B?UEFFOE9leFYwNnRmSnBFellEelZTN0c5dE9xZ3dCZnd0a2tsTlV4ZDV2b0JL?=
 =?utf-8?B?UzVJc3FhSENSbWFWdlRycGhKKzhtTVZUSHltYUlKTHJsdnhYRWNPVTJBcnRI?=
 =?utf-8?B?d05JaVdmaFRrVUxPN01rWHdCTnVYaW1GL0tNQ0pCcFJlNmdzT3o2MW4rVi9C?=
 =?utf-8?B?Vk5zbXVNUUtlanQrdlZONm95cTluUjBPSkJ1b3RXT1l3MDNZKy9EWVYrV1N2?=
 =?utf-8?B?dlhyNndvb1diNHZ3NmZwcEUzUVA2dm1peUVBcFM3SUx4ZWRSK0NpeHJ3RFcy?=
 =?utf-8?B?THZMYlg3Q1VObmFqMTNtUWp1V1lSYVRXc2k5bVpSMnpWTjkxS0VhQ2Q0cVhk?=
 =?utf-8?B?NGw2YzVZVlU3K0VIT3kyVURxMHpVUSsyS0FzZ1NPN3N6eVRSVk5wL0ltZWYx?=
 =?utf-8?B?MS9HNk03S0JudWdseGRRSXZoNjBGTWJCWExlWU5Qb3oxYXh6VmM3ZGdWNVFJ?=
 =?utf-8?B?TjNRb0JNV0N1MEdQc2NBcW5JR3RrMU14NWRRUkxFUWFqQ21mSzYzNndFNk1V?=
 =?utf-8?B?eGJWTGtWK2U5NEZRQWlSN2laZzR2azU0UTFDeGVOVjBna1JlSy9UT3haWmNa?=
 =?utf-8?B?WmVkTm9QVkZpV2xqcDdPV3hNdVUrRG5BS1BmYkMyVDNlVjAra0JTbTZ0cEFW?=
 =?utf-8?B?eHN2OGpOZXJpTmRuRXpkbDhWcjRJS0plVVE1c1RkdlVESE53L0orM2t0SmFa?=
 =?utf-8?B?Q05HQlA1TUh0endmTzNvZ0tBamo2Y09IbXlKTE9BOWVqdk9DaW9uU2JQWE5v?=
 =?utf-8?B?bENCK21mN3A2TjBUOHNORFJFbW1mMmE0KzZiTkxaOXF4NFJkMnRmemNqcDFT?=
 =?utf-8?B?T3k3M0xEdzkreU1RckVtZW5JU2ZHYjh6R0tCa1JXV3N4YWJ6dDJkMVk4Y0oy?=
 =?utf-8?B?L2dabGMwYytrZElSb29haGd3bnVzbTA1TFNBZmV6TEp6L1ZYMWY3T0JUQ0Z0?=
 =?utf-8?B?QUk5VDFBeFY5YmV2QnJwaWFONWFmN3AxYWR3SzVGU0o2cTBtVFBTZE5PWGUv?=
 =?utf-8?B?RTk3aGNpRVV0VG9XQkhBTUVQbS8reURPbUsxRzVRSkFxVnNXV05GWXBINUZM?=
 =?utf-8?B?THlMaURzM2c3Nk5zM1Ira3VVRzJWK1lBL3B1aCtwbXRFZnkwWlFEVU9lMW1T?=
 =?utf-8?B?dm00NUZHVmEyeHk1WXRHaEZPTUU3cXdEUHgrMXhCb3NwdEJ0cEI3NUNyekVO?=
 =?utf-8?B?M29PRHE1cG5CeTQ5bmRmbTNGRzBTTjV6KzE5YXRvZUthTDBJM1cxWitZVzVn?=
 =?utf-8?B?cEFkVDd5VnhWWitHelhXYzRBVXEwN1hKZWJMeW5vVG13N3NVdmwrcUl1WHZm?=
 =?utf-8?B?bVdVRzdvNE0rL3RYYVBxaVpUMTVtejgyMHZET0tHQ25iRzU3QXBrc0EwYnI3?=
 =?utf-8?B?VjMxOFhnUTZCc2JudFhTRG9TWVd6eFRBSnZpRGFhTlNyMExGT0ZMTGhBRDZY?=
 =?utf-8?B?OG54ZkRxNmxSUFZaaXFVYUhNQTI0OGY3Rnd6M1lIRkdjKzI5aUt5MC93UWRs?=
 =?utf-8?B?K2NsVUtQajJ4cXR6d1JZRGZBNHBMdEN5QXhOejlSc0tvZGwrOVc5SnBHNTRI?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb798d9f-30fb-4f8c-a0ba-08ddc5c7fa02
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:54:44.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuuhIyj/lNiOyMpkKOdCS/b5Iz0cOOL1yi/G40MSDTkcnBf4pXtJq6y658EGfyhJrrvu/s9VECWIK7MvEVBPJ0tJdS972z4NFB9JYD7Mk8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com

Hi Sasha,

On Thu, Jul 17, 2025 at 09:34:36PM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found follow-up fixes in mainline
> 
> The upstream commit SHA1 provided is correct: a238487f7965d102794ed9f8aff0b667cd2ae886
> 
> Status in newer kernel trees:
> 6.15.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: 82e4aa18bb6d)

This patch applies only to the v6.1.y kernel, as it is already present
in the other long-term stable branches.

> 
> Found fixes commits:
> df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx

Regarding the follow-up fix:

  df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx

Not sending this to stable is intentional.

The QAT driver in v6.1 does not support the DCC (data compression
chaining) service, which was introduced later in kernel v6.7 with commit
37b14f2dfa79 crypto: qat - enable dc chaining service.

The original fix (a238487f7965 crypto: qat - fix ring to service map for
QAT GEN4) was supposed to address the problem also for DCC (as it landed
after the introduction of that service), but did not. Therefore the
follow-up fix df018f82002a was merged in kernel v6.9.

Hope this clarifies.

> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  a238487f7965 < -:  ------------ crypto: qat - fix ring to service map for QAT GEN4
> -:  ------------ > 1:  1c3a13c46a06 crypto: qat - fix ring to service map for QAT GEN4
> 
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | origin/linux-6.1.y        | Success     | Success    |

Regards,

-- 
Giovanni

