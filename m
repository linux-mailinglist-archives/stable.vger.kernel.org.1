Return-Path: <stable+bounces-134491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF02A92B87
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A744B3B2B40
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA31E5213;
	Thu, 17 Apr 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5dj/eZi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3731D6AA;
	Thu, 17 Apr 2025 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917137; cv=fail; b=XbRZh6Iqlv2no76/p9dOpiNPpqMdd6F+05pLF2l3gb9zcML6qlurhuL7t0a0GJUkvTCurJV4qQ6g1MNw7Y0wP/kKHMCCBVDZpM5ODutyB4xuEbTbhGYR8KLacWULh64IGbYNxY9tteTXwzN+6NMyuibLBcwuKXqr1fks4ymtJNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917137; c=relaxed/simple;
	bh=9PKMYQXKKe6CfhaQ5M7NRprpfpYLsfFjPsHaioNvVTQ=;
	h=Subject:From:To:CC:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzAc5O6vHqW1ZPkat6YFeY+FO32S9NnGJd56PF9P7KSSZ0Gt/lXXDO1xlH3M63BbpH7a/goTnNP0I8suYSie4kT4XJVGefwnglVpI7+U3dgXxxI9Ivmo/Ek3ZN+kzuKZN9pYRVIUKUKGEegMeyrFcURBmjR/ghYrazr7j1c/Fmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5dj/eZi; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744917136; x=1776453136;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9PKMYQXKKe6CfhaQ5M7NRprpfpYLsfFjPsHaioNvVTQ=;
  b=U5dj/eZi5dg8YmY7y+63V1xfetFpUNpoitfTPkfp+RRcTLAD1AJltPWG
   YrQNqHc9w2wlAjxMY+cTak8+AlXifb4FPuZEZi7O0vggfsB+6YooF+JGS
   RoyUTo0No8thUAyrKGz1cmU6j4xZAupmio1ETsbtR4m9TBwlsMSJl32tm
   e/l+9GwadZd82IagSevz3+NFnpKhWLtkMGlKD8KkMMX+R3SP/H7272lcy
   +tnV3trRkYgJe5hD+L7nAE3aHr8TKEWUUb1PsvgLDCtw7rnlBzEUGexdI
   2soUhzwIXwuDTGWBdX2DyCVAQYiNGLdvpFFm2EX/CLhE6EQzCfztcNEg+
   A==;
X-CSE-ConnectionGUID: eEqitwHMQmyrkMjDOaJxdw==
X-CSE-MsgGUID: iLDzDXbrRmS9+Zkm+4xCjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46420317"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46420317"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:12:16 -0700
X-CSE-ConnectionGUID: /NTtH7gzQ1KEv1SjcVKtlg==
X-CSE-MsgGUID: shmN10EFR3i8AI2wYYNytQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131884538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:12:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 12:12:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 12:12:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 12:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScRoLv763Hz6MZCgSIBqlTwz/wroRAR+P384ZZWfFxSpldNPAW1wHMSw8rueu8afofQWlg1kZNPkekcM7v311/YlSP/eac/ZBxP/rQbbSkUvmwwXlPoUCBOeRofaWRAhEzNrt5sP4P7Rg6hoESHeeZZYmE6koObbZSozB/SMsO27wz6vpj3cNSrSTcC8XR/e7YkwqqybPN+UVwvNHa0/UcsMtRszF5Q7AHfMRnHzEb0HRw1AOcWC8nK1PIKBs8pqf8tixwzd1J0wfI9zEhUkmrW9nDmC6e/UMYut9nmdAxL3jXM2jp3R7QQUrc3aIiP4m3PdeCgnknsz57VIKv40Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs8zyNx1KJQ9wdy4jOWLyzrKsqn9Fj5nwloI2TE+vhw=;
 b=szJnyMx5FLp0rXtT9NAGtuo7B1qXBXYr9WeBvHyba047EONhL+MymCYqR0WvNv33JSYjYTELBYyKfhKuSunA63nSmbdiPXz8OOikZMhmSPzxqTMS2/J4qEMCrXEYG9dWl4SqgRZ772f2YqlOOCXdZMI343v+809D+IUXXo1IBWY2kSX2STwaRSM9bZzNAo1yRtZxAkTTPjLrCE90YbVKh7YMF5SKxvvHl8Ou0VSZ6Exndi9EnAKOZOFMh/k/IHZSxVOlcD1r3pwqDK/apKh7FAYiIypzkE+dpVAwZbdHduXwpY55fevZtX0dnUxz893LQYHq4EMeDXkAMYPCXngDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 19:12:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 19:12:11 +0000
Subject: [PATCH v3 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, Kees Cook <kees@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Naveen N Rao <naveen@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
Date: Thu, 17 Apr 2025 12:12:08 -0700
Message-ID: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
References: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 39269533-08fc-4888-a911-08dd7de3c128
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elVEeDZncE5QY2cycGFJV1pJMlFzdXVSdjA3bWVuR3d6QU11MVNXQkVaNlJQ?=
 =?utf-8?B?aUlld21pSDIzbU1wdGxhSUpBeHIyTFZoT1pERTAvWmpXaWtPQ0laTDBRZUcx?=
 =?utf-8?B?RjkzSm5MeGxNTVNaNDhCZTRrcEQzMXp6SkpoWVRtSVhUQnV5eEhrekptUEps?=
 =?utf-8?B?WVpuMW0yQStyZXZpZnAzRUxRdmVWSkFZVW05a0xNNC9raWUxUDBVNllOcExz?=
 =?utf-8?B?WFdyRWZ0RFJ4VTU4SDNMcUljd1UzYWQrUmVYQVI0YU93VkJGdExUeHJBczJq?=
 =?utf-8?B?cCtTUjlqaG5JMHZSWmQ4REJEdEhaT2djNU5Pbm9BZEN3bzRRRjdsTnVrR3hq?=
 =?utf-8?B?enBoWHdRYyt6SURYa0drOXpmcG9xSy9aUFlUZHplSkR3a1VrclE2eWE5ZGQ1?=
 =?utf-8?B?d2lLNkhLZGgrRkxwSmpPOHF2cTRkaVpKaFdYaTBMV0d3OW9WdlZja004UVdx?=
 =?utf-8?B?TDZXQms4aDREc2QyVWpiaFRhL2ZUYndFaEpPeTFHWjRqVG1pTWsyUWtWL0ZE?=
 =?utf-8?B?L2dQZ2JiN294U0xXZGs4WWlMU01pbjN2TjhsSHJ6eGxWUFlyWHg0ajM1ODRr?=
 =?utf-8?B?UEdLaHJlVFFWQ0c0UHRnaXY2d3dSQnVmZmMvTFJveUl0Yk1KWFpCZVRwcTN2?=
 =?utf-8?B?K1dPZi9pNmFBNFUzRHJlRzNHcmF6QStHM0JMRDJybER0c0NBTnBYNzE3SVRi?=
 =?utf-8?B?MG5WN0dDMlJIWHlVZHh3SitpUjhkVkt2R0o1L0VINXhuRUNNWmkzQ3BsVllY?=
 =?utf-8?B?L1RVeUd2T0FvcUpsaFNwSm5KSkRJaEVnUU9TS1NERVF3bFJ4RVM5WXR5SExn?=
 =?utf-8?B?eGhKOHNPeFZDRTR6ZW9uMW9IZmN1QjdSRFNFK3dEVWFYeDRPWWRoalJZcy9l?=
 =?utf-8?B?VzVOVjFyWGkwK3BsaW9BMFdJa1F3a2F2TzRCNkkreWlMc3hGV0d3dGxSNE8z?=
 =?utf-8?B?T1pYcEx4eVlOc3pqeW9KQWtjc2dhZC9yZzY1U0Flbm5zeDlycFB2N3VLSktv?=
 =?utf-8?B?WjRzNC9xbVV1YWp0UkZaR2hpcFlmTW5Ub29mTmU3Z2swK1o4VzFwT2pJc0VN?=
 =?utf-8?B?N0lYUGhybzFLZUtlOEU4UDE4NkVvVkhPMUI1RnFnMVFOb3ZPc2pRMWx6RjZH?=
 =?utf-8?B?akpyR0pVSzd1ejBKUjYwNlVlajR5by9iYS9zNTQ0b0JnRXluOHN0V0locGFX?=
 =?utf-8?B?MWYxVmE4RXltOXVGQUt4RHJHVjlwZzNNL0E2T1hqRFAvSHd4OGRCdGYwdVJj?=
 =?utf-8?B?a0VrZEJrdFU4RTFRVWhlRDJhcDI1SGE4dWdCU0ozSTR1UzdwSkZOMWIwOTJs?=
 =?utf-8?B?UC8xQlZzdGZKanJWbWZaRWU0M05oVGw5OFR2SFdNS3ovRzM4VmdWNTJIcnY5?=
 =?utf-8?B?L2NkRkFydGF5MjcvOUxkTlp4N2FFVjJIbStjNHNUcVhEUUpWMk01U29QV3BT?=
 =?utf-8?B?c3c3UnhRMHFUL0ttUTRWYWcwNUc4U2Z6NWpndGduRkxVZEdOenhxYjdyRVhP?=
 =?utf-8?B?RDhlSk1TLzg5ZTRsQ0dscklLK0U1Mms5WVJBM1pJWU9FV1VGZmpCNG1jYVl5?=
 =?utf-8?B?TkFxT1FxczlkTDM1RVJBcE1pd04veWJUN0tiRmYwYkJkUldmbEdKcHM5VFNP?=
 =?utf-8?B?TnNrTzF2V1NhTmVrZ0xGcXNoR3BsbUFoeDRwZGdLZDBaYU04VWM3Qy8rVndW?=
 =?utf-8?B?NnVhQ1gxNSttV1Q3cGRtRzAxR1VFdW5yQzRlTlBFdG9pVEVGbFVDbzZ3WkxZ?=
 =?utf-8?B?bFM2eHNZdjFIRjRKQm92bnloeVNDbE9uRzdEWEdtdDlyVjdwOU5Qb2NwaXJS?=
 =?utf-8?Q?xCUh+ZnrjSKL7eV3adqxuDUEM8ZAWd6pdk1zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJLdmdCUnN0bEswVmFyQmcwQ1ZKdXJRU0xWQktFMTlzWFROZE1LcDNJelMw?=
 =?utf-8?B?THBhc3RsbTROUmVDYjgrNmtnbjNnN283Y0l0RXJldEpjNVlUMm1lLzdSN2xs?=
 =?utf-8?B?ek5wUlRUblk1cVlTV3dYZkpDREVRU3gvd1hMNHV2dzIyV0FQcjBqMHgzc0Rp?=
 =?utf-8?B?WTdYbkhHVGRBd3JIeTA0eXlsaXcxRFFSRW9xVVluZGFxUS9kdXZpVjByOVBt?=
 =?utf-8?B?TTRUdXVFZ1ZBZzVqdjVWVmdzNFBxNDZHUkNyZ3FubTVnNGZYdk1HUzBnYkhz?=
 =?utf-8?B?WXZWTVI1N2NPTnYrQWt3MTRKeUo0dzRORCtWQWxoM1NFR2ZQcE9XSHoyV3U2?=
 =?utf-8?B?RFQxRHhLTWNPNy9qbGIvQmhFbTgyZTNYNmN3cTFiWkJwZ2pBME5RbW5IaEVM?=
 =?utf-8?B?d3lEUlNHektYWVpPMlBoZy9hVk5sNmpRd3dUdzUwR25QRjdoVk51T2E1T1Q0?=
 =?utf-8?B?WS85OGFaMHZXTXQwd3RhL3hqZGREYWtOSFlLaFE5N1FTcjJhK1RlWS8zdkJJ?=
 =?utf-8?B?allGa2k4WjB2cGxFSDI2bWFtdURtUlBIQ2hhQXh6Ty93RG8vaVA2bzBPelZ4?=
 =?utf-8?B?YTlkZmZkZTJmSDhMQkFENXlyOEpHN01WY09SV0hYbjVWV0Z4QjFGaktxTm52?=
 =?utf-8?B?QWQ2RGd1ditRU3lSOXJ4NW1sczdpTFdnUG1PRjhpU3BXY3dyWkZ6TktBZ2RD?=
 =?utf-8?B?QktWMXdwWnEyS3VremhmSGQrUHJ2OERRajB6bU0wWDJENWZWSk8vaktZelFW?=
 =?utf-8?B?Wjl2aXBRK0dzc2VmT3lKYnRDdnQrT2lhQUNUanJ4c2JvTkszK0RrNzNTUk1C?=
 =?utf-8?B?QzFpQzVONFdrRkgxeUc2bXNEUHVUSnNGYTlNclozZUdFZE1GejF5TGdidlJ1?=
 =?utf-8?B?WXRQMUZ1THRkWEVRMnRjZWpUdDNZOFJoMUVYZ0Rlekp2Y1FIYjJ0MXlKcHMy?=
 =?utf-8?B?bzdYS3RwTmdNdmpHWXFtMklYbUhaMTBOL3pOTTliZm15N2hKN3U2ajZQY1Vv?=
 =?utf-8?B?VzNSdnQ3eElyTWR1WlBWOWJtNU85VWtrckZ0ZEhRNUpsT2NDY2FsajhxOG1T?=
 =?utf-8?B?c3FIUncyMFBFVUtXU1ppR0MyK2VyZjlOWFVhemx3RjlXbUVpS0dQQjBvR0Fx?=
 =?utf-8?B?cG44WVc1b3lsa2ZURHpSeDh2SVhSOXlJNkVubEFzbnV6YjFPRmdPMHVqOTVp?=
 =?utf-8?B?cnJnRlAyN1V5b3ZqQmpXREI3NmNORjg5L1VkM1RrK3ZNRldrcWVBUjhmSVhq?=
 =?utf-8?B?VnJFMDdsYXNnL05OLzJ1WFdNb0ZYMEs3em9DSW5HRG5YMmFVMkxNZkNVQTQw?=
 =?utf-8?B?WHhHWmpVMG5VaTE4M2NqWEx3aHVxMEZlWTFySm44aTdPc3o1UE8vYXNrN1NE?=
 =?utf-8?B?LzRVNnlHUEFVdy9CYkZScCs5YzBVdUdFeHBPWWtPNktpdFljMVpvc2wrMFJF?=
 =?utf-8?B?T3N4NzlhK0U4NFBjeTBZcDRnK0VkQ1lkNE1iQVdSV2kwUVdPaVEyY1RDd01T?=
 =?utf-8?B?eUlISUlweGxyTnhNaVh2NXFWMXB6clVZNEdPdlhWODNodXUvVVg1Q1hTRzRa?=
 =?utf-8?B?T2o5Tzk5clRjdW5sUGUreVIyeElQOHQ0b1NNQVJpMVEvVEd3aW9GSmFBaC9D?=
 =?utf-8?B?VS93b1dxRWJoTWdVRGROZm9pSEdKY2tIOE1UZk1TU1Nnc0Rhc21kOUtVTW15?=
 =?utf-8?B?LzBtcUlMbElZMDNob05DcGhoc0d6RHVDd1RvNHlDUHlWbURyWGR2MUkwVXNM?=
 =?utf-8?B?VHpJNHdNVVRGT0xKUStRa25jTjdpOEN1QzNxWDBQYlVUVTI4QnA5WWZMTGlo?=
 =?utf-8?B?Rk5ZWWt2MWFjOTAwaU9wb0lOdjR2c0xlV1lCZXZkWHdVZnhuK0tTNEZtcno2?=
 =?utf-8?B?a0xoeFVHanpxeEhQRDI5aDFwRXZxamFtQVVtUVBreU1zT1JqZmh2RjNNNWE5?=
 =?utf-8?B?R0hZM3kzTHltK1BRaGhZT0NHWWZ4UXo5Y1VUWlMzQUxCZzBmR00zSjNlR3cz?=
 =?utf-8?B?SDRPTGlHM2hSNUNhdW1LZ2t5OEtwUVlqVGFDUnhPRmVOdlJCdmJBRi9jMXF5?=
 =?utf-8?B?MXVWVFBCWS9TMi9uYzh2bXVxRmtMYk1PU1NBNCtTcysyOHFLcmRFSzZTcWFr?=
 =?utf-8?B?amRHajUzdWl0TExwU3E3TnhzbVk0cldkZlA2OGhNRXozR29hWGIxMWVTOGVy?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39269533-08fc-4888-a911-08dd7de3c128
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 19:12:10.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WupfPgQK8H2ovlX0KUeQD8k94ePQZdEHzKI2ZRG9ZziAksee7t57ryQ/yoCXlDMmSU/0MsNU1HHR0bDIu++gQYLiIdEf6rSCI38TmNN2Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in an SEPT violation.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
unencrypted mapping where the kernel had established an encrypted
mapping previously.

Linux traps read(2) access to the BIOS data area, and returns zero.
However, it turns out the kernel fails to enforce the same via mmap(2).
This is a hole, and unfortunately userspace has learned to exploit it
[2].

This means the kernel either needs a mechanism to ensure consistent
"encrypted" mappings of this /dev/mem mmap() hole, close the hole by
mapping the zero page in the mmap(2) path, block only BIOS data access
and let typical STRICT_DEVMEM protect the rest, or disable /dev/mem
altogether.

The simplest option for now is arrange for /dev/mem to always behave as
if lockdown is enabled for confidential guests. Require confidential
guest userspace to jettison legacy dependencies on /dev/mem similar to
how other legacy mechanisms are jettisoned for confidential operation.
Recall that modern methods for BIOS data access are available like
/sys/firmware/dmi/tables.

Cc: <x86@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Naveen N Rao" <naveen@kernel.org>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig   |    4 ++++
 drivers/char/mem.c |    9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..bf4528d9fd0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	depends on EFI_STUB
 	depends on PARAVIRT
+	depends on STRICT_DEVMEM
+	depends on IO_STRICT_DEVMEM
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
@@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	depends on EFI_STUB
+	depends on STRICT_DEVMEM
+	depends on IO_STRICT_DEVMEM
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..f394f941b113 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -595,6 +595,15 @@ static int open_port(struct inode *inode, struct file *filp)
 	if (rc)
 		return rc;
 
+	/*
+	 * Enforce encrypted mapping consistency and avoid unaccepted
+	 * memory conflicts, "lockdown" /dev/mem for confidential
+	 * guests.
+	 */
+	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return -EPERM;
+
 	if (iminor(inode) != DEVMEM_MINOR)
 		return 0;
 


