Return-Path: <stable+bounces-58959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8692C7CA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 03:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ACA283ABA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1184C85;
	Wed, 10 Jul 2024 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+PQcAth"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284210A09;
	Wed, 10 Jul 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573709; cv=fail; b=YSf2PyuL0EryBbuv/as4Z+FzOH44AgJEDg5YDzV6aAO6vveGm+qk/JagO14ZBAKiBDDRe0f4b90vSwnvoqmy8oGlgpIK/vGP9hSh5HM+t/wDV4CbC/RsBbDirsjIQa0d+yc8P1m8Z8qvWnhNTxM90RaJkNb9hoGM2194Gcafljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573709; c=relaxed/simple;
	bh=ordxL+BBxhlHFfrx1LXFA7ZGuQP0oi4eYRWu4M/C5lw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVB7QNYPBULk8K02FbLWbJ4bxI0jdWviVY63kr99QUGb20AR+r+od10rIvtMM/c3HY30rFUtIRbSQS+49c8aCVEFEBhqVFKRPjaRch91i7aNmBUVMBRpsC9sOM4USzzSd3pdEzv9w8zP6Lkahgyt27RTwbzO2t4dGMED5X0X6BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+PQcAth; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720573706; x=1752109706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ordxL+BBxhlHFfrx1LXFA7ZGuQP0oi4eYRWu4M/C5lw=;
  b=g+PQcAthHB36t0PUjDzR+3F0wexlCmVjpV+k6y+XaofDK1B4Wnrq3K2h
   z6R77ssMmVdHx0wpAy0YBbt+8RtWPDXIyOTjqJ67TNUB1zyF75mRVnKtd
   TA0LJ0e6wQIxOCgfqoMhQx6avvImQWX4N7RaWOFC7zsGe0M3TqgWikae8
   2/jCVOAefyi75nwLgvyhurb6SwxiWclwfbxcuRUbaQkhv7TBa21IdOKfC
   0KEHXzBaghmfpH9Zp4+AleR4M2flFcS1JRhNLyJPQS/tzTA+DhMuY6mN7
   ScF5A9FlkbH8lRJ+H8K409QIjIcjE9fu+ATHDKp/AtQGrfuccC401Dvqk
   Q==;
X-CSE-ConnectionGUID: 7/bjjbrfRceIpMMmXg+TCA==
X-CSE-MsgGUID: JsPVk0rfQhG/JyMkS3WTNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="12463876"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="12463876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 18:08:26 -0700
X-CSE-ConnectionGUID: k9+CRfwdSFe+OWv47AQIPA==
X-CSE-MsgGUID: 7zvptOl/Qcm/ynEx/ufpFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="71265605"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 18:08:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 18:08:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 18:08:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 18:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUQD71fPBLsbjRhNXKhuyznSYAnw/EdLWZa47YhY1w7eULsV8FqN8ky0hjYz8M5pvOkBjWxghqT6/H02sbZ6c5IRzPj0ksPqqwHwVU0xN81g7b8vLmOGygcLNa/d5WA59ziQ1iMhbw0URVXOIz3vyi8N6o0J7ExBjH5e5R7Id5MelVMl+Qzo4uE8f6q+u9z+2iR7FcZdK/KlgPx9tktWnMf7rb6XxsHYcsu4r6OvtOf4B886AGtpjjwLUe5tg1FLxr+vw1z2w3FzZrbOAZbV4Cp85nHWoL1GoQCYh/UjzXd/41/QyNxEjkyGPIZ0qVOqR/fbuiNPJ6d6po7iVzfUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1/mHo8bT7a3EJxtlr1HcqoHu7fCZ89Vkpnue26iDLU=;
 b=fqFGUiUytGkEU8zQSSalHFb6Fm22gYC/os9GewGnPmsE8qztt2ED9I4qfmU+ZR62eP+pYmzWHs5RNKsqquSJAhgw9TySh+COTITlzvqhMjsbx7TfzL//og3x+0r+IjvBQSBp8L2S1jGFE23FjAFKH9GWE4aPVa4TBT2/O/6AQhxCNQMy9J6s/+e+N9dKdzxpFhJBaTn7nvjJHqu6humaW4FfTVWBc2hbhpycnHBksxdfKeAiLfJMH8pmiMwcM12OBohcPv/0E7Vc0ZxGSBlJ5kJd43Xz7MHFoH6R5VshuCntpFy9OQPiNf7VIaOE7osLRvJ+UDg4elO9jD1uBABQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:08:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:08:22 +0000
Message-ID: <d1ea4228-9ee0-41de-9119-e9a8a577ca51@intel.com>
Date: Wed, 10 Jul 2024 09:08:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix PTE_AF handling in fault path on architectures
 with HW AF support
To: Ram Tummala <rtummala@nvidia.com>, <akpm@linux-foundation.org>
CC: <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <apopple@nvidia.com>,
	<stable@vger.kernel.org>
References: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
Disposition-Notification-To: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 914eea06-cb83-4d75-e9ea-08dca07ccaf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHYxaFpWaTlZUUdXbHA5WVRuU2VzWjhwZjY2MnZHdlNTNzBoTTlHdm5iVnk0?=
 =?utf-8?B?aUY5aDgxVzA4RWVPYXlra0J5UUJxTy9DYitlRjRwa2lOM241SFVpUVR5V0VY?=
 =?utf-8?B?ZGVFTVhrZ0JTSUN2TFN1eW0wTHcySlJPSjIwb3ZvY0k4RTFlUnQwaVZBcHdV?=
 =?utf-8?B?cHBxcTU4T3lqUEFzQjFsWnNQL0NFbWFPZUk3VDI1YjRrR3hXZjFqMFN5R0gr?=
 =?utf-8?B?T2NvYnlBSndwWGxlUjhCNnQvQ1hZMnlFNGRoUzNYa0ErZTViU2xwWThYU1FM?=
 =?utf-8?B?ZXRjWWt1eWlkd05DQXBDM3BzVTJaNC9WT2pvRWcwejZudGNsSVdTMXlZTkFi?=
 =?utf-8?B?R3cwYlIxK2hzbXVzaHVVL0ZTc0kvSlFRQzU4bWp4R0hyUXJpNW5MR2JHVnhQ?=
 =?utf-8?B?b0xia0F0QWxYanJIWURJdXltbVJUR1h3bElhQmU5WCt2K3AxTUluVWRtRFUv?=
 =?utf-8?B?cmhCamE1R04vWUR6MEtmMHh1NFQwMXV6amhlODJXR3Rpdi8xUHJVWC9VdW9R?=
 =?utf-8?B?czBuY1RTS2M5bW10SnJqZUJMRjcrNjJ1bmV5NVp5MmJKM3g4cFVLS0F6RUxN?=
 =?utf-8?B?ZmIxbWUwUlA0NXluZmJBWEYrQkxidWIvWXFCbmN2ZndibDh4NmloWnZhMHVn?=
 =?utf-8?B?bjFWdnNMaXlkSGpxM2RFL0xHbmhmK0M0MlMyZEdRc1hYU24vNXhXZytPY1pK?=
 =?utf-8?B?UUFEdmJ6UHVnblRyaWxRb0hHSmgyM1BxaUJZTVM5ZmZlZS85UkR3RG4vUU92?=
 =?utf-8?B?NytiZkxZRmhXRmI4SnE0S3o2SWxtcUJ0RHVpYkdGUklqd01DUlk0N2xoMkdZ?=
 =?utf-8?B?SmYvNGhGYnByeEN0Ykgrb3VzaDZIQldkMi9Rcy9GWFpWVFVEbXpIU3JkMERp?=
 =?utf-8?B?V0RPanhEMHFrdEh0YWZKdjhrbXNCS256bFAva0pJbi9mV2lNNFBPVE5rVktO?=
 =?utf-8?B?TWpvRzluVzlGL1o1MnFDNkdPVCtOaUJ5UjdsTkphWVJSYkR0Y1AzNzVRTkhB?=
 =?utf-8?B?UVU1Y2VnZUhhUTRLUnRPS2FXQ1IrSGNubEhBNk9PQmxpLzUrMEFXckRhblZJ?=
 =?utf-8?B?VXd4T2lVTUlGeGI1MTVEdTFuTm5WVWJHRW9Cejc3Y0F0dzBJS2ZtTkZkMVhT?=
 =?utf-8?B?MytKUXo1b3lPWFo0eWhCZy9WK1J2UGJ3UDdpZXN2Y1Y0THhSRjVrMzN4bWNC?=
 =?utf-8?B?TkNENnh0KzZydjdYTHZCRXdYMW9ROVhlRFFNTW1DdkdnSyt6aFY3Si9rOW1z?=
 =?utf-8?B?NW4xQ1RDR2UvR3hKanlNWGJpQnBQaHRvaEwyQU0zTHVjWStYZXlJVkh4ZTdM?=
 =?utf-8?B?VFh1dkp4Vnc3ckdaTjhWYXlDenNFYmFBWGlETHlraHI3SUNFc3c1eXFnRUdR?=
 =?utf-8?B?OENhZ3liSXhhRCtxVEhXa3F0biswMElxTlA2MXlKS2RaSnluUDFqMXNqWi9p?=
 =?utf-8?B?OTJLUEt2TVpjdlR0NWJWcWVmbm1QdmJDS0JyN2dKelRvRFVESU5KR1VmVzJi?=
 =?utf-8?B?eWJpOTNNamkvdzlCVjNNTnRITlRzOFVHWmQ3ajdxaXprRHF5L0pJTW1HcDZJ?=
 =?utf-8?B?SFBVZHltOEJKYW01ejFSbE1pcHNrRTRHOWtRQnYyKzF2a2x6ZmdhRVN0N28w?=
 =?utf-8?B?VjA1NnRwNXZleThtNUVxTWxodFJnSlI5cmJRSkUzMEpPS0RkaW5TUUtiaFVm?=
 =?utf-8?B?T0lpMmhXZmI0MklvdTlPNjJTYTV6UUZVbk9JMFJxT1JOczNKR21iMUJiOCtC?=
 =?utf-8?B?VWE4RXg4c3I4eUI5SzJXdHNYMGJTMkRwMWZvb2s0cGZCZisyZ2kydHBQRmdR?=
 =?utf-8?B?TWM5Nnkvekx5a1BHaXk3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ull1VDNtaWtYbEZZczdveFpYWVFjenBzR01peFFHRXdTMy92MnNFOXBZLzJs?=
 =?utf-8?B?M3Z5UWhWUCtIYWNIVmxHTkdyZnVDS3F3YUNXNFc3UnZXSWRhQVFHbmR3NWRZ?=
 =?utf-8?B?WS9uWUZwdE1lTE9xT2lHVThUclpZbWJZZS9pQ2hSUnF5WFVuY1pUZHJOd3kr?=
 =?utf-8?B?UXc5YXBNU2xHMllJNFYwODY2dlkwUkwwUEZOQkgvUVd3ZFd3eUllNnpZVDY1?=
 =?utf-8?B?UWliYVBPczkrUFJnZEJMci9sL1AwUCtaTUh2NHlXbjVDcDBWMmg0RkxlWlBt?=
 =?utf-8?B?U1NFQUJoanFrUVJkVFM1RzVxL2paU1JhNnozdFBHVWJlY08yNTVZTHlsQkRN?=
 =?utf-8?B?SFhaaW1kbm4rOS9yYVRDa1pBek5xT1JqMnFQNkIzNlhwNUluM2lObjFzTnVv?=
 =?utf-8?B?YU42Q3BUYTZqVEJaU3ppcFA3MmxqVnBQS3ZmWXlTSVE4OVNsSXZmSDVENkRl?=
 =?utf-8?B?NElqRjZMQnZUWUpVV0NVdzhSUHB0NWdNMWRuYnZ1UjUyZGFmYjN3MnRtbXFI?=
 =?utf-8?B?OUwrY0VYempzU3hvYjc3S014MDJwYktDaHlkY2x3MHBsS0h1YWJEYjQwd2Vk?=
 =?utf-8?B?d21FS1c5TWlpVHh2U0NGRWNBcHZ3S0RtZU9pY1ZKMkRoRWN1RVlGdFdSYUoz?=
 =?utf-8?B?QUcvemlKVk5KUnRBeS9FOG1GM0JnREJXcU9VWjFDamZHeXJoMjJYUWY1a2JQ?=
 =?utf-8?B?aE5LVXJKR1c5UEtzOTR0bnF3MDFyMC90bWJKZXI4OGZNdWxxYUJ3Q0JBcmFo?=
 =?utf-8?B?aDI1clZDOVlQMUdUYUxCS3FGbzVlZW9lVU95bjNTaUtmWFZJTExRNld6RGJF?=
 =?utf-8?B?TW5QeVpaRFFwUWlQckdVWGNCR0FDeVNQWklnc0FGU2FyK2h1VXV6ckZFaWRh?=
 =?utf-8?B?Mi9kTzBFcFRSRVdKTGVycjlYb054Nm1RT3dmKzluOTFON2RvK09PalpTcm9l?=
 =?utf-8?B?VVRNWSt1YStuaDl4d1dhcVRzeEdGdUhIVUhWcUx2VnhQOHljRmdQUnBmR2Vh?=
 =?utf-8?B?c2REUjJ0L1ZzRmRsMG5XOExaSm8zc3gxSW1yNEtNRklDNXRTVWJqMXJJR2lh?=
 =?utf-8?B?ZUp2ZzdodFdNMlZvaFhpbUVHbFhqdThTWlV6cEdHQVFoTVI4TFZBMkp6UmlS?=
 =?utf-8?B?TDFqNStIWnk1OGZCdmpWTnljV05lMXM4MHYxWm9OdjdPeEk0eFgvN0Z2SnFi?=
 =?utf-8?B?em0yaG1xSW4wNnRBVGlzQ1QvaW1aZzJRQkRjUHRmZ0FXQXRadmNWODBLS1pl?=
 =?utf-8?B?R1Q2S0R0NVdMUVkxTmNGRUJhdEJseGJMODRnZm9XcXdsWUZTdHhjc3plSm5X?=
 =?utf-8?B?eE5tc2lvUmlYdnhpbElBTDlML3BqZVdhMS9mR3NzL2tPdVV1QTdqbWwvZnl4?=
 =?utf-8?B?WldYS0dBdzNhdFB2djhXU0NCcFIrNTE5bnFwQlJndUhZRmk0QjFuUVh3NVV3?=
 =?utf-8?B?aDVlNGlvWEJDODJsb2dyM0hKUDd1am5DSVY1UjlEb21JSW00NGoyM3VCZ2xE?=
 =?utf-8?B?T2ttL3RrL0NUVTFXb1hSTzFleCtEaEgvdUU2dHVIaEs2bi95MklPRXJHQklT?=
 =?utf-8?B?RjhsUUVwRlhSck9tbWxMUmJ3MUd2YnRlb3FNWWVaMm5UeThCbGU5b0ZUNXNG?=
 =?utf-8?B?REJ3enVIU2FxUUJQUzdPSVl1M1ViL2tnSGtOZzlDSzliVXBURmlWaWE0MFha?=
 =?utf-8?B?VUN3MFNrNGpXWWEyZUdaVlRBaThmWjZ6ZUZJRFZ1TnF5VTFLekptcXBEVHJw?=
 =?utf-8?B?RHhzc29sQ1pyUVhCZVNYRmUxNVFoY0NELzVseVY2WXJHVW9UR0xJWUR5TW5J?=
 =?utf-8?B?dFpLL0xvQmQvdU8zamZtby9OUkxQUCtnNzdWUVBiWHpFN21UK3ZOL2dVMi9G?=
 =?utf-8?B?TjZ5Y3ZsM0FNY2VLNzBlMGFHVWU3QUQvWXVEOXlEMHNraGt6OHlQT3FmVDNO?=
 =?utf-8?B?S3lCd0ZoaUR1VklkWlk3MGFabTB2aEFiVjNRY2JnTlB0bkorZEtRZE5wczV4?=
 =?utf-8?B?TllhRlAxZXlqTWovVjlDUGpRUnJGMWFXdjY0dVFXVzY0S2ZlZlk3V2FlS1Jq?=
 =?utf-8?B?eExpWEZsZzNNZyt2dnNDOTB6Rm5WK3hrUUFzUnAzeXpoOGFNNnNyOEFLeTBK?=
 =?utf-8?B?SWQxQlRNV2pVL3ZhNXB1VXhBdUVvaWFINDM5bHNXcEUxZnZlWno2V3ZrSStq?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 914eea06-cb83-4d75-e9ea-08dca07ccaf3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:08:22.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpoHDmnt9+2oZeTxScZTk74az6v3IcfOM3/6bU+1W3zv2qEnLH10dOspQjwoeFcNVeJrQQsOhgr9zaajIlmR1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com



On 7/10/2024 8:09 AM, Ram Tummala wrote:
> The polarity of prefault calculation is incorrect. This leads to prefault
> being incorrectly set for the faulting address. The following if check will
> incorrectly clear the PTE_AF bit instead of setting it and the access will
> fault again on the same address due to the missing PTE_AF bit.
> 
>      if (prefault && arch_wants_old_prefaulted_pte())
>          entry = pte_mkold(entry);

I have same confusion as Matthew about the PTE_AF.

But I think this is a good catch as old code is like:
         bool prefault = vmf->address != addr;

Sorry for the issue by me. And

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

