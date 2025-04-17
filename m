Return-Path: <stable+bounces-134492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A558A92B95
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE4A1B62DA6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791C1F584E;
	Thu, 17 Apr 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfX3SNyl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D3A926;
	Thu, 17 Apr 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917354; cv=fail; b=exVKjP8GSdEXzhesf9sUpjOO3BWGMbAS45VWLiytzLbqgtSOKSki+sU9I5FKfBpZyUSWisgRayAsd9Ll7Nuk6EaY3OKNfYSSyH9EruV6Ki+yNSiO9Je9CQ+TKFLV8AUmKBKnNfIwKXO9U6ifEKlNIdrVP7/IBuJxRmUShNjIotA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917354; c=relaxed/simple;
	bh=y/JAbX1DfrwmZpr4Kz0TNpAxA3kr7IYVAS3RQhsAqB4=;
	h=Subject:From:To:CC:Date:Message-ID:Content-Type:MIME-Version; b=QITl+/tod/3BK+iKTQ3PL83w58b4cW+c9NgbXMOxyd/5PmJATk9TTkNsUrc6uIAMHU4fz3ZN9hdlymiFiV6axUd5KojVNf27lbGcYx83TGCK+pO0B2X9hRj1u16l9j9ah3DegmoAE4YBuyO7RmhhwiccyzRk/AWjmFjQrqhk380=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfX3SNyl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744917353; x=1776453353;
  h=subject:from:to:cc:date:message-id:
   content-transfer-encoding:mime-version;
  bh=y/JAbX1DfrwmZpr4Kz0TNpAxA3kr7IYVAS3RQhsAqB4=;
  b=TfX3SNylzYZtSyrfpBrq9I7Gc03/3p/3mISPVwAnY66qpzNdXnmnXPg2
   V9Rv8HqUDUowMy8tHUyPrUwVGHlvD9pnS/ww+8Wd3VhsnPXB5iyiptLRU
   jNOYd+5piZ0PVYRZXAgc9pUj1829ocUdn2j2ZZpixv7QoTbwMF0YAOtMF
   YYnr0hMTGafX7u1+cazEl+DC1Dj9jH2J/ik3enXOWFSriEXi7p9gFchPj
   BEiwiR9fJpCK1YY5jwgsBfUoRRB7RcKOf5BdXpbARs8moBcp5Yiw+539J
   zN9kPi4cOjjoA9WK1KSu8NdDVBOxbzKxDz/OgQQ0ONCtITxrfhLIm7QCx
   A==;
X-CSE-ConnectionGUID: uRJ1LqCESIy0CzDGcpAIog==
X-CSE-MsgGUID: 8KxnhZnfTTS1TE0QttxANg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50194750"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="50194750"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:12:00 -0700
X-CSE-ConnectionGUID: P8CyzoLGQOWy7cZ5nj8row==
X-CSE-MsgGUID: syi/cLE/S4yGqq20Q3Q0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="168100695"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:12:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 12:11:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 12:11:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 12:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUfACKcOrXX8BfnQ9hN2dFjiNde+3FigMlojW2sV9ikNGLTGY2iVQk4GLPffZ07aY34Yq2p+mQdKg5dviI78WgiC5ZpQton7zOMxLG4sYCbhlcGF0PfgutstWJQDXp/TApjEnjhkdZPCdJNCHGn5+r76VnvjYL4nrk9E13OuzJJBaMGaYfUaFSIyw0AfCBm6A2utuomND9iqqq0VJ9sJIw6oQ3cZSUdjbmKhplFVvgfE/Znu/w1DPzf4+K8mo0EaaVrICkzRhzQ0E8MDmlxkbVDEQjzlmhOwNxZRMB2XBkLXwUGBNxTMCrxrFOYJzwtwo3tPJ2LhiCUv0hq1lkUYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLvR0q+nMekejTuDQysx3hlW4kzY40HKMw7K93SsWso=;
 b=bCHfg8caVmGdoKVCel6mess1NiIUcOx2WQyjzkCGR7BXYmW4eT399CKMhaFao98WEa8XOjiyGFjIkmcgwqpR0AnMZB6hAXJaKuJ3onKAfu30fzZ9Wqbtf/DLbSoKg3gsdVgZil/02UE0BzjxSx53mKnL08Qto3xePkBXSA8m6PWZlCpqH6LJjWepg4XJeDw4mrQSdJs2sHXFBo4tAdrDlyeOsd0Ajn7kHXjs4BM4Yr8Jj+QFnnMU0FqHYjBDq4VgzfG0guG6OEjvD8ra9Kiot47EgFVZTYOreTvR05myDO4PkGFs0wi9os756Ihaov5meEDphVwHPYiFW/eJlncD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 19:11:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 19:11:55 +0000
Subject: [PATCH v3 0/2] Restrict devmem for confidential VMs
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Vishal Annapurve
	<vannapurve@google.com>, Kees Cook <kees@kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>, Nikolay Borisov
	<nik.borisov@suse.com>, Naveen N Rao <naveen@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Date: Thu, 17 Apr 2025 12:11:52 -0700
Message-ID: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: e202de39-a334-4c36-5c59-08dd7de3b7e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm9paUh5MVRXL0Q3dVIyYS9ldS90ekNUdnR3M0k4emw4VnV1VnlscHFZRHov?=
 =?utf-8?B?ZG00WEFyYWNRTmprdkgwelNBMk94R1N0ZjRrSTJtaUNUOXlYV0JhcEx3WGZR?=
 =?utf-8?B?cEFnU3EwSnNidGlRbzhnd2hxWUYwOG11RHZNYWxOODVyVDY3WmtZRmg2R0tt?=
 =?utf-8?B?UGpneTQrQ3dvS3ZScmJ4TXBsYUhzR1lyVGdEWjlESytaclV2Lzd2RTgwcjgr?=
 =?utf-8?B?OXY4UDQxQzlyZ0J2K1poTlo2NUl6OWNjYllpekw0NHlNS3d1OUVmYmFHU1g2?=
 =?utf-8?B?NkVqQ3BQSTh0b05wRjVCc0ZqcFpudkpBTmNRSENqRVBPdnN6RkM0bVo3STBP?=
 =?utf-8?B?RXBwcWQ5NytpMEJKN1A2di9iRmFXYS8vQ1plNjQvWDAySHNuaDdLYS8yMXBt?=
 =?utf-8?B?ekF5aXU1REs3eVo2Mk16aFRsQ29Va21ZOVBhOGVKWEJreG9oZnNueno1bHJG?=
 =?utf-8?B?bGoxdnFVY1FId3pJMEQ3YTlxdXByU3JzRitPaWd3RFJONG9nRWdsYlM2Q1pG?=
 =?utf-8?B?NnlXeDgweGlUemY3c3lmZldLYWY2dzJ3U1ZPM0Jram5WVU4rSUtsek5EdE14?=
 =?utf-8?B?S1BHYW9WSDJ4aDJrZ2xmdktQN2NacmhjV3RscXNFK2RkZmc4dW5YNU1wUGx4?=
 =?utf-8?B?YXVYRXpQQzZtcThMVGRVQ0JFaTNDV3EyK3pwOXE0eDhSdWNQV3VISXk0ZE1W?=
 =?utf-8?B?blNEZEVyV0NjTWk5OWZjMkNiRDNsTTVXZHhZYXpleVBzSWU2SjJtVHB2b1Fi?=
 =?utf-8?B?eGNOVUJBMGpQb1VVZVhSRTNNTW5NN0VTbVJxeTFZK0d4OUFPSlh6dHFOL1dP?=
 =?utf-8?B?NDYzVXFiK1N3dGtVV3luR0RvMytJOUpiUGtCMWVvaDd4OUN2emtDeGtYZzJS?=
 =?utf-8?B?OWk5MnBCTndQWWFlVURZaFNTWEVFN3BiZE8yR0tBdE4wVTVseitSYVVkZ1pk?=
 =?utf-8?B?SmNtTEJaUUpZU1BtWG0xSE9nQUxlbTBwbi9iU3ZwMjh1ZnlJUFQrUUsxQlB5?=
 =?utf-8?B?dGFGUmV6UjVYb3Exdnk4ZWJ1cFI0Rkk2YWtDYlB3K3U2SnhFV25hazZ1ZzV0?=
 =?utf-8?B?YXFFZ1RXdENjcitaNjdkLzNQaWxEUE9EZnVVTVo4Mi9QWWQ3citQbDNJQlVK?=
 =?utf-8?B?MnBUZDJJc3VtT21DMkpIOVF5QW92UDdiQUwvN3hhNm1QUHl0Z3BDNGVnY2lp?=
 =?utf-8?B?aUNZbjV0SWtyem9JVWJLQkc0RlVYSXU1bFlvV3RiV1VsUzF0d2lGTVBNbEwz?=
 =?utf-8?B?eTN3c1BJaG5uQkVKRnVsN0ltV3BhSC8ycEw0THFGcWFaM2lqOEV6YlZvdTkx?=
 =?utf-8?B?OUJIZzU4QWlrQUZMNUUzbjcxUUhsQWxaenZiNzZ4RHRxOGFrYmFvQVFaWjhK?=
 =?utf-8?B?c0p2QVJ0TE45anZqck9ENDQyWitEUG9aVWJOcGR3UU1iZlEzZEFtS2xENllq?=
 =?utf-8?B?ZjFSa2oxc1ZOaWh1eDB5a3N6MTRWY1FTVXY2djFiY2RJVGQwQ1JBNWxLS3M0?=
 =?utf-8?B?THU3cStpZy9nTTg1M25ZSW1QVVQ5dXQ1eHFGUUJmd0YrdHQybWs1c3Nvb0Qz?=
 =?utf-8?B?bEs2TEtWVTQ2aXVFQTFCYUhPYlM1T2J0RlhYYnRHM1U3dGMvMWJHTDJET0Nu?=
 =?utf-8?B?K1phYkhOVVdwbzJXck9BSUtxVG1EcFN5R0NXb3hQSjdQemxmN2cwNW5YejQ4?=
 =?utf-8?B?OGh5eHV3eURhbjJGNU1BcGlUR2NJK2Vwc2tGR3VoMTdiMFBMTlJjd2x3Y1c4?=
 =?utf-8?B?bmJrSkQyaHpacWdsU3JBay8vZGpjeGJXWkVRQTMycG0xUjEvbVJtejYxNlZT?=
 =?utf-8?B?Nm5EM1VkTFRURTh2K3o1dVp5bWFPcjZZZGtQSmhwcE1GK0JiSDI3QmI2d29y?=
 =?utf-8?B?eVJIeFV6VmlPQlpUYmU3cGNsa2w4TWZOcVkxV0o3dllEZ2REREJ2bWEyRVZs?=
 =?utf-8?Q?fujwlEEeLUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHUydWVlSEwvUldNa2dpZWlzYUFLNkVCU1NaZ2crd25nK0EwSzJ5SzMrdkZU?=
 =?utf-8?B?dXE1WDQvQ2VlRVpnLzRIVUpSYkZhT09wTWpOVm9LeFVLUm45N25EUGVOeW5i?=
 =?utf-8?B?K29wTC9FNzhGQi9pd2NNdVhIWGhjdEM2NjQ3MzdhVVpidVdZUnZDZFcwc0tB?=
 =?utf-8?B?b2VQcVVxRG9wSjJuRFJUamZ4Q3QyTnF5RGdrekNaSGdQditabHJMUHlQTFdY?=
 =?utf-8?B?WUgzT3hsc0Q4akhWT0NKQ1IydXVhdW5VTUt1MnVLeGt3ajJ5YmpXd2gvbWxV?=
 =?utf-8?B?V29pQVhiclpFUEg0bmx5TENYVFVJYU9LL0lIRjkwYUJHVTl0dDB3ckNaMTVC?=
 =?utf-8?B?ODhOV2dxYllOYU1ISFUrc2ZCaEovMWZYTit2RUoyQXlRcCswbWVwd3k3NTlG?=
 =?utf-8?B?dlMwWkc1SERyZXFIRTRORXlkVUF6RzAyQTM4UmUweE81RnlDT3YwVGlQZ1l3?=
 =?utf-8?B?MStabzluYi9iM01pdGtXTEtJam9CVFJzL1JWOTJOa1dCTTlnZEswWEJicFUx?=
 =?utf-8?B?ZXRBdEovMUNoTHpWMGNnK1h6SmphUFlzWnh1N05vMFpWalZZZ1ZVdlpEWlV1?=
 =?utf-8?B?ckxGamJpY0xHb2p6S0xBSXFuQmFZNVhNcHZnSTl5cXlCTmZWUkZYTFpxUElZ?=
 =?utf-8?B?NHVuTmwxTDlwcnl3aWJReUljVnh6dFZyZjk5UzVURS94YVYyTXNzdjR4NHhG?=
 =?utf-8?B?cTAwVlJwc013K2N2USs1Kys1dVY0Y1hPRTkzZWNiaHhnNVRBZUY4QlcyNU8y?=
 =?utf-8?B?YXpNU01KY016MWZWZDhNV0ZkNEVQTVRtbkVSbmJCdjVGQlErSTB1Y1IrbXdC?=
 =?utf-8?B?SjdveXA2YVpvc1FXTm1vMnZ2clpxMFVyclNUcFBndW1vU1JReVZlSXFjRjhC?=
 =?utf-8?B?QW43MlY4M2FkNWl4RGhUNkN3WktUajRKcDVNMkJKTFBQOFFWYjZFbXdYRGRR?=
 =?utf-8?B?NE1ZTVZVZDBldnJPU1UzcEg0RjAxUXN6UkZhQWJBa005VmxMOXJrTWxDVHpv?=
 =?utf-8?B?OWZsblVYdDZHV1h6YVRlZnJOaEg5MmVnYzVJL3VFUGowR1N4em5samZlREpD?=
 =?utf-8?B?Ti9NOEt2R01KeHNrNDRidjFiaGxFMVRydDd2WmUyVmJMMWcyM2xRVzVJb3Jq?=
 =?utf-8?B?Qk9yRW5qc0RUNFpNTXdHYXoybzhOVW83UGNwWGdqU2ExdThnUWtVNGZWeUJr?=
 =?utf-8?B?ZUdYeXprTERiNy94dW1wSTZNRzh0VmVPcEV2UGw4OFN5RmV3RUNvZjhJcHFq?=
 =?utf-8?B?WkVWQ09iNTJTM2ZWZU5MYTFXMCt4TGgvQ01xbm43OVJ1V1Flc2Z1MUp4QVJC?=
 =?utf-8?B?SklHY1l5RmYyQm5RZWhUN3BwL2RUS2R5ZTBtMmVWM1dXOXB4cjhkMHZwUHc2?=
 =?utf-8?B?eDQ0MVV5M0hSemtSOUpwRWduZzZSZVJNRWtxWmt1aGxYTDRWZ2NISEYwN2FL?=
 =?utf-8?B?UG5xV1d4T3B6QXdIOW43dnRQNlVsVm1kck8xSWhWTTVldlpCMzJ5VURud2dG?=
 =?utf-8?B?UVVxU3V2MWFac3V0TDU2UlVLNmpESG1kZE1wOTE5NDdMS3ZlMDFBeUJMUldZ?=
 =?utf-8?B?V0pvZkpWcmcvVEF3RnFVTFVEZ3gxUWpkYy9RNnppeHptVWVRSHlYNWFJc0Ju?=
 =?utf-8?B?RDNNN0o0V2l3eXliMkFqSjArZXdLb0RzRS9pWTgwK1hWSUFWV29SNlR6UGM2?=
 =?utf-8?B?bTk0bHM0R2pabWt1V0N0RnB0Z200cXVSbXpNSXJ1Z3FKUUVhWnVNdWcvdVh1?=
 =?utf-8?B?bmVHdGtXY0graitlMlJiOHRZRDVsLzNob2gzWUNQeHFjNlFGL0RrWGxZMW94?=
 =?utf-8?B?bGNSMFNKQlJlR1FrbmVxV0MxYyttcGJOWnFxWkhibDhLalNPOFN3TlJIMVVq?=
 =?utf-8?B?elQzMm5kbElEOXN0eEdCa1kwYVk5dU9wbm1Ub3oxQ1l4ZTIzN0xZbDQ1ei9v?=
 =?utf-8?B?bVNkYURmeTNkMWZhbEFOTHpTaG1TYmoyaG92YTg4SUliUU5tYk9NWnVoZXBi?=
 =?utf-8?B?cFZnTXBFMVJlM1FUZTFHSVMxeUxyaFVDeHlIWkl4czdzdnFWYzFONUVLaDZX?=
 =?utf-8?B?dWc2R0xjN1NjU2ZUeDk5amQ4TXg1QmVKSERMRXlYak5BVVRoeWhwWmF3ZVRF?=
 =?utf-8?B?RDBCNzF0OGRHdTNrNzMzL0crQis3R3dNZmUrdTlsQWZVU1ZaQU14SzNiRjda?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e202de39-a334-4c36-5c59-08dd7de3b7e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 19:11:55.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDYlBIOOqXOoTG9pWmL7bqoVHw4P6VHklcvg48L25JYXO5f5nqZwfPtnpmPJYtIN6oWfENqsr4ezlTN1hNxtZiMNGbD2dRzNq/GHO55uWqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Changes since v2 [1]:
* Drop the new x86_platform_op and just use
  cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) directly where needed
  (Naveen)
* Make the restriction identical to lockdown and stop playing games with
  devmem_is_allowed()
* Ensure that CONFIG_IO_STRICT_DEVMEM is enabled to avoid conflicting
  mappings for userspace mappings of PCI MMIO.

The original response to Nikolay's report of an SEPT violation triggered
by /dev/mem access to private memory was "let's just turn off /dev/mem".

After some machinations of x86_platform_ops to block a subset of
problematic access, spelunking the history of devmem_is_allowed()
returning "2" to enable some compatibility benefits while blocking
access, and discovering that userspace depends buggy kernel behavior for
mmap(2) of the first 1MB of memory on x86, the proposal has circled back
to "disable /dev/mem".

Require both STRICT_DEVMEM and IO_STRICT_DEVMEM for x86 confidential
guests to close /dev/mem hole while still allowing for userspace
mapping of PCI MMIO as long as the kernel and userspace are not mapping
the range at the same time.

The range_is_allowed() cleanup is not strictly necessary, but might as
well close a 17 year-old "TODO".

---

Dan Williams (2):
      x86/devmem: Remove duplicate range_is_allowed() definition
      x86/devmem: Drop /dev/mem access for confidential guests


 arch/x86/Kconfig          |    4 ++++
 arch/x86/mm/pat/memtype.c |   31 ++++---------------------------
 drivers/char/mem.c        |   27 +++++++++------------------
 include/linux/io.h        |   21 +++++++++++++++++++++
 4 files changed, 38 insertions(+), 45 deletions(-)

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8

