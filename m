Return-Path: <stable+bounces-217598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBQLEvLFmGnyLwMAu9opvQ
	(envelope-from <stable+bounces-217598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 21:37:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6816AAF8
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 21:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78153011797
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F62FD7BC;
	Fri, 20 Feb 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqSNVIWv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00C264617
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619823; cv=fail; b=CHgZ5HJGG74u1sdJ7XZ2+PkR4rn6MPLCXNGrz6aUPK727mJa0kCqF27gtDHY70zSL0pqqrXUPlHA/OWvmLSboljk1/YtZUU+S6EWCfgCmEhYE9FIdKwMNIgaqb/X+p7qZG89bVkucjE9iDlKLHLBlT1vFiPnyYf0NadW2gP8yn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619823; c=relaxed/simple;
	bh=ELFp5hSW87QrO/H9M7Xxh+xL4r6vmoNZePRgdkCMrIg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mreyZSavtnUPJ3nRZ0JttyEyuXiJBOETHGylRFLueNbk5rYR9P1pNMOZLOeZndZitPaYt7C8+i398890QE8V+7/mSZ2XXdjzLZ/RVvJHQ/MxLnKLLDNYikdZtI7ybmzXQ1MRs5kEWhEQtBTr8kaw6l7DFmDAYq2Vx0BPP2O5IU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqSNVIWv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771619822; x=1803155822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELFp5hSW87QrO/H9M7Xxh+xL4r6vmoNZePRgdkCMrIg=;
  b=BqSNVIWvpMCMF7Rlmriu4dxhFUFvRMq4czIf2bDtnmFWhGUJnEqWlP7w
   6+BQ5yO8v0X2lkLxWuOSDow1PinBM2MNIlNlVYzZY1WAMqFUFMkuRzhmp
   6iK1GjmSz44jGmSBv2MbBpEP5PqV5UJ03y+akWncOtlSVRBKrO8CIsmfo
   SdPrkTl9R12DpN8j3sMHfRSUQUGZjm2Fj7Vyd9qiPZsmdtyAuAeIkjIsA
   j7bEC0aB4kVQnlq3NaiqclhuoBRiUHXJoJVshZs9nX0K6fvETE1uSjRnO
   SlNUpwjDzwOEKxex/Cb42+ZCH8NCX++E4Yf8PKV2idJ56kQ+yRFzRCF2B
   g==;
X-CSE-ConnectionGUID: hVUaKSHKTKeBangWq9fnNA==
X-CSE-MsgGUID: ouCvciIeQJuIXRndwXLcSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72780633"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72780633"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 12:37:01 -0800
X-CSE-ConnectionGUID: r0O2J4vASEGlqOApJhQncg==
X-CSE-MsgGUID: rzBmQA5iRGiySLm2QF80gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213035219"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 12:37:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 12:37:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 12:37:00 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 12:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc/lbJ+AzI6U9M5lVT02LFJTzVGyD7fDHAjIbl75cMYDHnICw+MrRSDzFEY0O/udei+S8EsSh3ox9S2erEczu/snGACW+R6FhePBmzIyM1/zPfEGfqnTRXBTJz71cEy0KEnu0osxd4DjCR49dxEJVpNrTc/6YQ3ydFUuvSwSST/iSvCd3BbJW83KFXk2uknAyvqNW1wnc6Ty75W5RrXLnjFxVca6TAfzg8HiUoO5guFVtop1/PouXsrzT8d1FY2ifVBtBfImrYq82U7A1sZn3skLLL5ETl2ncaPHUdFHQ+Kl7Q1iUJy1/uKOQ2g96/GLUiXThhB6OKUuGHmfcZWuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kMO30PRgBbCDWAaJkOGC7V3jb/z3t/+37EU1G2O6pk=;
 b=LY0DcJh337QWt+X26oWc91V7ZI9zpZ68Tc+syXd5zGg81+4idI9dyZ6NrYvT8Zq0PW1qYqzzvPAQNY4+XKDEGSwkIzNxlPR7wFFr6nxp9fwLx2l6mUcO0+RMjIR4dsem3rbqG3plR09n6KydQ9YkZaxO+OhhYpyrmrOIHkUbmtehB5Eti4SyVfsFG0nqbo9KO5A8AuCpRCUwT2iYSWRn+KfnLyu97Xfj969ZjtmRT8Uzw5CDR7FXILTE95Zm6FHCbRJFBFVH8niKGkdgpalK43EUZJBp85aiZFsyDBHsoGEcC0NBI/odiN3j4XsSA7ZoB+evVkAOLXN/C+gBSyVCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:36:58 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 20:36:58 +0000
Message-ID: <e71666b1-c006-4084-afbf-bea40aa4c425@intel.com>
Date: Fri, 20 Feb 2026 21:36:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] drm/xe: Forcefully tear down exec queues in GuC
 submit fini
To: Zhanjun Dong <zhanjun.dong@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
 <20260219180701.2418453-3-zhanjun.dong@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260219180701.2418453-3-zhanjun.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0199.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::20) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: e501d709-9205-4c94-e464-08de70bfcaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dldkTEVXcEhpdHdnZUhEL3pYbWxTN1FxMUF3eDhXWGkrTDNickcrV1dNVDlH?=
 =?utf-8?B?M0pOdENCNm05bE5pMGNIR01lRzRFMFhKaW1aZ3lSZnJzcnZKaEFOVkVQR25v?=
 =?utf-8?B?Q1c4OXB2RndFeUp1ck5Rd2l1WHcvRlJwR2lkblpsVkc5OUlNLzQwdlB2WDNz?=
 =?utf-8?B?VXE1TWZMTkVYUjZxOWQ5bG9kUHUzRnRaQ0M1cjk4SEl6MHZOdkx1MGlIVEh0?=
 =?utf-8?B?aHY1NTA2enVLaWtJbWdQa2x6WTRlVWJYSXB1ckJoMDZDU01OZTVmRExEMHds?=
 =?utf-8?B?THE0TjhQcXpLOXYvbDJpbG5zY2dXd2tQNjJITGF6b0tOeDFlMWlwbmh0cnEr?=
 =?utf-8?B?RDk5Ymg1b1FKeUFsbEJpdHdJSzJpYkMxeVdxd3VKbzdCemJKWlZBZjZhc00y?=
 =?utf-8?B?UzRYNlhkY1hEZjFvbzZKZzl3d0ltR2RjOHhMWGZJTi9WR3dxVHhWU2hxcjM2?=
 =?utf-8?B?WGpZaElueFduM2RNblZrL052WUdHVUNZZ3htenJMNXp3a1lYcGs0T0V5S1lQ?=
 =?utf-8?B?NENBeXBIZ3AyZ1JNZUNSQjRIZEMvaitCdHB3NmtjYVBOVW1reHVxR2l1YUFa?=
 =?utf-8?B?VW5sQ3lRMks0UnJlbTAyb0NaVzd4SG82a1hHZzNzMU9sNndqSmVwR0JhUzlh?=
 =?utf-8?B?S0FwLzFJTzJXc0t6ZnV2MmRTQWFyd3QwU0RtaC9BOXBCWEkxNHlUcENKQWdL?=
 =?utf-8?B?dmdabWMyNVo5QWg2VThGUE83bWpIcHlHWnlHS0p3M3lIMkNSUitqd0t4dmVo?=
 =?utf-8?B?Y3A4S1NnYVRKc0FBWllrRmN4a0VlU0VYMHl1aFlDZzl3a3YxS0ZZMm1VSTE2?=
 =?utf-8?B?K1B3WGpDcG1sak42RC92dTQzWm13dEJhUkE4UUNwQXJqVjJqT004ZEhGMkNs?=
 =?utf-8?B?SUtnU3pCU0ZNRmxUTkw1ajhqWFRJS3JiSnNUaGJPQ0VGb1UxcXl5S1RZWFdi?=
 =?utf-8?B?UVExenVDekJwZnlad1l5K0xCeWQ3WEV0bjJhdGtQckp3Sk8yYzN4NUt1UnNF?=
 =?utf-8?B?MnlLSm5IMGxFVURZYlZOVVB1S3pESmRqUGdIU2hCaU5BaGdmRHVqWFpxVEJx?=
 =?utf-8?B?dHJ3UzJhdTN1eEtzK05CNjZKN0ZVdmxnc1d4TGpna1JLQ01vVUVaamhmTkQ1?=
 =?utf-8?B?K2lsTVp2YUIwT2R2SG53cHJYbklzZkhnWmxjS3d6d3hJOEtQQ01EQ2h2bk9t?=
 =?utf-8?B?Y0J4Q3h6SUV4RkpKRmZQRDZ2MVp5blgySGF2RXpZQ1U2RDZWdngrRkRCWUg3?=
 =?utf-8?B?bTJDNm1lZWJ4Y3M0NVVrSWlTanJiYzhVUU9wanc2NXB1K2RkSlBuMkRqZkpR?=
 =?utf-8?B?ODlTMHFHb1hnNCswWDV0L2o4c0V6LzE2NXMxY0tnSUc0YnZSSVFDOVFQN1Bu?=
 =?utf-8?B?dlRBdUx2MjFEaUxUZUYxWTB3YWF5a2hwN3U2K2VJQTB6L0kvUWN6eHdFUjdN?=
 =?utf-8?B?Z1RnR1UzY1NoTlVqekl4NkxRVzVNMkRwWWdYYkw0N0JLeE5leUd0bkEyc1VU?=
 =?utf-8?B?VStOOTVYR1oyYVN2ZDR6WEQ3U1I5Q3lBdFJWOE1QSG9mMGlJT2ZXdzdvMW1v?=
 =?utf-8?B?R3dLUzJ5S3kyaFRaT0pDVFpyRTNxRnJYU1phT25vTWJ6ZlgzNmIxVCt3Zktu?=
 =?utf-8?B?SEQvNzNkRFhlSFBWMmJTNjJpU2RtK1lpeE5XN3JTOEZlSjJ6RDJzanUwNUNH?=
 =?utf-8?B?Tzd6TkhKQ2lBL3NuNkdnZzFDRzJ2SDJGV1dwL0ZTNDI3c1ZzQm9TWVc2bVpS?=
 =?utf-8?B?cmtaOXdFUDZmSzB5d0hZTWQzbWIzK2NKdSsrZWFaMkpaNS8zNkRtUlFjNTFZ?=
 =?utf-8?B?Um9lN2x6RUtrVVRrSXBNaU9KZlRoM0xTUTBZRUdZUStmbHB0ZXVEQnBDeDJ1?=
 =?utf-8?B?cFgwT2p5eG91aTR1QmU1L05oNDQ4TUFabE1xU0Ntbi9yWml6cnlZYVpaWVY5?=
 =?utf-8?B?aUR3cFVtbWFXKzAvMWdPNWZaUDdaR1NlekhQWHduOTBFY1owTWE4YnZicXJ0?=
 =?utf-8?B?OTU3a2wrYU5qZXYrb0x3ZElaQmRQWmRFaWJUMlJzdWh3aldEbnp6N1VsWjlT?=
 =?utf-8?B?RlVDZ1RsT0p6QjJINUhRWE5CWTBDMW14OHhXZkNxeEdWdUdmZFUwNmFldHJk?=
 =?utf-8?Q?QRw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZXbzRsRFNQRmF5dytTeGhPUmVWZ2d1UmtTN3U5QmtBL0VsaGdaS2hBeTA1?=
 =?utf-8?B?VW95alhNK1Z6a3FtL3V4Q0JkSGRzaUZFRXg3RHZWOTFLS1piS0U3S2ZhUUlF?=
 =?utf-8?B?VUgvNEQxcTFEL3pCZEdySFpodWV2TGRrMHFEci9LM0gzMEU2Q1diVzBzSFRo?=
 =?utf-8?B?ZW1Xd3cvNkhaQjZHVE0wQkprSk1Pb20vNFpMTUE5SGxNUHljU3lLN3FtSmFh?=
 =?utf-8?B?UGNZTUVBQVJBc2pkQ0pYN1E0WDZkbWNwY25tU0xwUVJPYzR1LytBRDdKQlMv?=
 =?utf-8?B?SlNJUWJoWUVnRWpZSWNtU0JmTVN2YTQ2bHo0aFF5cklKNHg0WFA5Vzh0RDlO?=
 =?utf-8?B?dkhFWnk0YnFkdUtLb1ZOMVhHTTVIaXBRZURZUStHa1VPbU1Sc0VoOVBIK25K?=
 =?utf-8?B?MDdzWVVoSWZqblRxbTE2OTd1TVY0c3lmNlMwQ0JKeUpVZkxEU2sxUTRzNEdV?=
 =?utf-8?B?ZTBBdmNXclk3S1F0SGJ0TzhwbWsxajFld2RWOFNjNUpNYndKSFY5cnVVUHFh?=
 =?utf-8?B?UjBiUEpTWDVXQlE4T1grektiL3BMajVMUHRZRkcyQ3BNclFBVFpSNCtTdzBV?=
 =?utf-8?B?YjFLSGtBclVPanI3TGFZU3RMMitLWjFiWTZMMlAxL3lmdnpTTDRibVpNbCty?=
 =?utf-8?B?QTZsRHh2RU9MKzdXeG9ORktQMmYyODBmNlpON3JMMjI0cTFTQTNMYzRNYmR2?=
 =?utf-8?B?ZEloZ1ErU0JHaWR2WkxIL21teU9xWUxSeXJpR1JHWUVVV2tqU1FlWjlHRzVy?=
 =?utf-8?B?VzhPQnpHMlJRZExDVUFwV3RydlEwdXRuWnQ2dEJkbU90YytYZmZPZkE3VEVG?=
 =?utf-8?B?c0NUTGpScSt4UmliMVh5aE1RaCtKczV2RGlQUXBQMHhBc0xaNDhYMnVzcmhN?=
 =?utf-8?B?QkZHcXNWa3lBTU5hTE9jOFdGdlFIbGxYc3JzQ1gwQTdXRjdvUTFxNkFibDJE?=
 =?utf-8?B?ZEFlSGRtQWR2NnBzRUQ5TEFITTJhZm1DWCtDbXl3N0djNE1WMTFNazlQZkI4?=
 =?utf-8?B?Q3A3NmRlbXorOTYxbTNuRW12OVpta3RzQ1VPWGhVV2lHaDlURUtBbDl3QjBl?=
 =?utf-8?B?dktDeTdKK0dONDVOSVFCODlXb0MxaFFUOTdLSyt6cTJqUmVueVhFclVVL1RQ?=
 =?utf-8?B?emVWMWg5T052Uk1TcStZbDhQT1dXeXZpOER3STFoSFhCbXF0RURta1ZJV09K?=
 =?utf-8?B?NnZla096VnF1Zm1oZXh5UCtEVU8zT1J6WWxyYmgzYnRXS3ZQWitZcjI2eUl2?=
 =?utf-8?B?TzE0UUlnSDlyRzN5L0RsVEI2dWQ3N1MxeHBKZEt1WWVlUHFObFdYZm5oei9Z?=
 =?utf-8?B?bmxHRHlpTmRLZ09SdlBaK3RGcUwva2tiVXVNRGxMQUNZN0x4eDkyaXd6WWU3?=
 =?utf-8?B?Zy9PSm1uT0N1NnBIQndDdjF0Y3N5N3U3aXovS3hXaE9kS1lmY1NIVkRGbzIr?=
 =?utf-8?B?TkhEWGlUZC9PSWV3a0NuT1FPY1U4Ly8weEFqSmVoTnRiYWQ3WTczdFFEa0JO?=
 =?utf-8?B?RnJweGRxYWN4S0VaemJrWHlabGFmK0VPQjdaOTJTN2NQYXBDSDZWckZaZlRq?=
 =?utf-8?B?c3NkbmVYOWpqcTZ4dW4zQWRidHJsQlhEQllWWmgwaE8vbGoxRFR1eGtjenVS?=
 =?utf-8?B?aEJySDVOaFRqOVpBZERLNXFWTzdyb3lTREdINHJraGRJNExtN2hnMG5jMTlX?=
 =?utf-8?B?QS8xcWFFM29qMkFTY24yTDNocnYyYkl1ZUk3dFZNZC9BbVZiSWIwWXlQcSs2?=
 =?utf-8?B?ZHpDcnFTNkZjVW5XNnRwSFlweVJZNTR6ZzIwcHp6QjJ2SjVDKzZta3dVTEEr?=
 =?utf-8?B?WGlsdGJkMWRPZHc3dzhObTU3SFJDQ3pVQnJyRHA3dkdxbzdwTG0xVnNBM25S?=
 =?utf-8?B?RXhYQ0tCU3V6K3ZDUGFMeXNpcmNHVFBhSHdJRStPQWF6MEs5YUhzWkJaOUNQ?=
 =?utf-8?B?SysrNVRqNzBRak9nWEYxTk5xQnYydlo4ajM1ZWlBZEtSQy9mcUxUV1I4NTIv?=
 =?utf-8?B?Q29BY0pIR29JQ0E2eTY1M1drSnovUVdyZm9xVlVNcGJnc1hzRXdURDdZNTRa?=
 =?utf-8?B?bkVJQkx0VHNMYU1CSjhPbkVJMm8zUjI5bmorWTlmVjRkMkswR3dWQ3pHYzJI?=
 =?utf-8?B?dWFTT3RESjRreDI3NE9vTDVlUEU3MllmTlZYS3c0VnBsd29QQkFRRFNiWG16?=
 =?utf-8?B?TE5mY0padlhYVndjVXdHblE2ZVAxMjYxL244REo0aS9WaHliSzNubDhLby8z?=
 =?utf-8?B?RHA0cElFMlBvdTVvQk5jWjQ4c3VQaEVNam1hUEFqdzZROU9PaWpWMGxpSm9Z?=
 =?utf-8?B?Q1l4Rnk3WXBTSzZHeEdBOEwwaVhUN2h4ZnJYV3NqWDdoUi9qYXFyVml6S0d2?=
 =?utf-8?Q?/teSInINtuU0K/p4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e501d709-9205-4c94-e464-08de70bfcaf0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:36:58.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4ANMsYaWdGJAg2S/OxKI5QihCmcIFlrLx592EDS9QVQQts1w+yOoPxlGFbNDl5ekZUGwgtC6TL5TqMM3oJoONi+6s66JddxsGzYrasUc/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217598-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.wajdeczko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B3E6816AAF8
X-Rspamd-Action: no action



On 2/19/2026 7:06 PM, Zhanjun Dong wrote:
> In GuC submit fini, forcefully tear down any exec queues by disabling
> CTs, stopping the scheduler (which cleans up lost G2H), killing all
> remaining queues, and resuming scheduling to allow any remaining cleanup
> actions to complete and signal any remaining fences.
> 
> Split guc_submit_fini into device related and software only part. Using
> device-managed and drm-managed action guarantees the correct ordering of
> cleanup.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> history:
> v4:
>  - Split guc_submit_fini into 2 parts, device related by devm and software
>    only part by drmm
> v3:
>  - Add page fault fix
> v2:
>  - Fix VF failure (CI)
> ---
>  drivers/gpu/drm/xe/xe_guc.c        | 18 +++++++++--
>  drivers/gpu/drm/xe/xe_guc.h        |  1 +
>  drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
>  3 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index cbbb4d665b8f..f59ae602b8ed 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -1402,15 +1402,29 @@ int xe_guc_enable_communication(struct xe_guc *guc)
>  	return 0;
>  }
>  
> -int xe_guc_suspend(struct xe_guc *guc)

can you add kernel-doc for this new function?

> +int xe_guc_softreset(struct xe_guc *guc)
>  {
> -	struct xe_gt *gt = guc_to_gt(guc);
>  	u32 action[] = {
>  		XE_GUC_ACTION_CLIENT_SOFT_RESET,
>  	};
>  	int ret;
>  
> +	if (!xe_uc_fw_is_running(&guc->fw))
> +		return 0;
> +
>  	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int xe_guc_suspend(struct xe_guc *guc)
> +{
> +	struct xe_gt *gt = guc_to_gt(guc);
> +	int ret;
> +
> +	ret = xe_guc_softreset(guc);
>  	if (ret) {
>  		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
>  		return ret;
> diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> index 66e7edc70ed9..02514914f404 100644
> --- a/drivers/gpu/drm/xe/xe_guc.h
> +++ b/drivers/gpu/drm/xe/xe_guc.h
> @@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
>  void xe_guc_runtime_suspend(struct xe_guc *guc);
>  void xe_guc_runtime_resume(struct xe_guc *guc);
>  int xe_guc_suspend(struct xe_guc *guc);
> +int xe_guc_softreset(struct xe_guc *guc);
>  void xe_guc_notify(struct xe_guc *guc);
>  int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
>  int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 42712acf2ec2..bfb176c201c7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -47,6 +47,8 @@
>  
>  #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
>  
> +static int __xe_guc_submit_reset_prepare(struct xe_guc *guc);
> +
>  static struct xe_guc *
>  exec_queue_to_guc(struct xe_exec_queue *q)
>  {
> @@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
>  		 EXEC_QUEUE_STATE_BANNED));
>  }
>  
> -static void guc_submit_fini(struct drm_device *drm, void *arg)
> +static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
>  {
>  	struct xe_guc *guc = arg;
>  	struct xe_device *xe = guc_to_xe(guc);
> @@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
>  	xa_destroy(&guc->submission_state.exec_queue_lookup);
>  }
>  
> +static void guc_submit_fini(void *arg)
> +{
> +	struct xe_guc *guc = arg;
> +
> +	/* Forcefully kill any remaining exec queues */
> +	xe_guc_ct_stop(&guc->ct);

it still looks weird that this GuC sub-component touches other GuC sub-components in its own unwind

maybe all this should be done in devm action added in the xe_guc_init_post_hwconfig() ?

> +	__xe_guc_submit_reset_prepare(guc);
> +	xe_guc_softreset(guc);
> +	xe_guc_submit_stop(guc);
> +	xe_uc_fw_sanitize(&guc->fw);
> +	xe_guc_submit_pause_abort(guc);
> +}
> +
>  static void guc_submit_wedged_fini(void *arg)
>  {
>  	struct xe_guc *guc = arg;
> @@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
>  
>  	guc->submission_state.initialized = true;
>  
> -	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
> +	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
>  }
>  
>  /*
> @@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
>  static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>  {
>  	struct xe_gpu_scheduler *sched = &q->guc->sched;
> +	bool do_destroy = false;
>  
>  	/* Stop scheduling + flush any DRM scheduler operations */
>  	xe_sched_submission_stop(sched);
> @@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>  	/* Clean up lost G2H + reset engine state */
>  	if (exec_queue_registered(q)) {
>  		if (exec_queue_destroyed(q))
> -			__guc_exec_queue_destroy(guc, q);
> +			do_destroy = true;
>  	}
>  	if (q->guc->suspend_pending) {
>  		set_exec_queue_suspended(q);
> @@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>  			xe_guc_exec_queue_trigger_cleanup(q);
>  		}
>  	}
> +
> +	if (do_destroy)
> +		__guc_exec_queue_destroy(guc, q);
>  }
>  
> -int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> +static int __xe_guc_submit_reset_prepare(struct xe_guc *guc)

as this function is now static, it doesn't need to have xe_ prefix, let it be:

   static int guc_submit_reset_prepare(struct xe_guc *guc)

>  {
>  	int ret;
>  
> -	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> -		return 0;
> -
> -	if (!guc->submission_state.initialized)
> -		return 0;
> -
>  	/*
>  	 * Using an atomic here rather than submission_state.lock as this
>  	 * function can be called while holding the CT lock (engine reset
> @@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
>  	return ret;
>  }
>  
> +int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> +{
> +	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> +		return 0;
> +
> +	if (!guc->submission_state.initialized)
> +		return 0;
> +
> +	return __xe_guc_submit_reset_prepare(guc);
> +}
> +
>  void xe_guc_submit_reset_wait(struct xe_guc *guc)
>  {
>  	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||


