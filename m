Return-Path: <stable+bounces-126898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60BA74101
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037147A3EA7
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216621B043C;
	Thu, 27 Mar 2025 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLkOD+XW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E90125B2
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115205; cv=fail; b=rGKwvcTgc1KQ+qa/S6pSgNwPdKyP3/BlgQZNCpBGYak39V+zfX7a2vmniUmZ+lvdYPofJZM1VkFJCAvs1dblolP6XQtjF0296lUYQ2Bkj50vXtqXwr9W3/t84x7OTiXbCfYtSFW4WUNkX5oNKhcut4YSljOByUWxguCp9mBd/0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115205; c=relaxed/simple;
	bh=COR0b3kKadC3VsofIEDPNSQAqk21Dxz7x13YAW2fuhU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VB5bCG6MXaCrEBxHHzh6GncJotA8E/X46RlyIoY9aoEY8i08VStjQCXNpWMPRpfO3huieHRVDOQmACB4Z0CaEigLqV6bWScBVz00bgZYPYkxAicIYqWxGGKxyv+SnDetMeZRTPv1lH0NVpLojTGHrh65i1HEUM7c1RBKhM2ZaYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLkOD+XW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743115204; x=1774651204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=COR0b3kKadC3VsofIEDPNSQAqk21Dxz7x13YAW2fuhU=;
  b=BLkOD+XWk4zgu8dcaEre8xNmgaIsIOfR3pBFJ/UBWgmKNneQGG4QxKtL
   ICeyuJ1ILpWDloqgzKMWiEps2NFCBEm29V7Vrd7tMCPvQor74sq1nw7Wz
   xOZqFmV/UgixGZfp8rnIeU8bK9pPk9vpNwK+ebSiPQKTdni5jx0JIfuzt
   7Gw3ntvzPlDfetEsKPz7G24rK5u8wKdDmdS9VRHrGzrprrXLEtVBIYptI
   lr169R5FXv4jGYdvMBVb6+yh3lKk2zwXj903th9m5I3Kvi/KaZYJ5xkkE
   aCJ3zVblEHJriLxE+MSBvWS01xyQTHsMzVbe/xejeUxnAN1DNj8WyHT89
   g==;
X-CSE-ConnectionGUID: NAtYJFCxR72P92ZlmGmIJA==
X-CSE-MsgGUID: cL+DxqDJQSCsWS1xJEfZsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48342376"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="48342376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 15:40:02 -0700
X-CSE-ConnectionGUID: 0iIFKJPAT0KyCRwawoZEwg==
X-CSE-MsgGUID: TFVDZoQoQY+1U9XeXauMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="156267005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 15:40:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 15:40:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 15:40:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 15:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mztgDd1Nq49VezVkWLRYgnjOtjcgz5naXMb1++pG4Vt25qAUDJjWHUf354yLEpVqNEme6NzPsoNX2FuwLqRUkU6bLaUMPTCYGh6UxGAaS/VZ38ZrZ+LaYW99dhJNFtySCxtEHeGUCO55iyrNgv3Ssc7kkRIotV6smXshZtn2Tw26TipPYh445p1EeolcqU0v/FsyQxOMM9+XP5JNFK9tr+fINnhSP72nYZiZWgSPfmMXYMGwa0imjApJGwYZu3KwR8kTp3vXijdB+KReozchRf5FFVz+HqqPY9pZr0R3YvgVqlrPi/Inv34s4E21S7SEt3E4ubREJ7RCrr5yBZBi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUEQjpqEWwTa7KdISZwPUJ6efNMjHbkX7vBdYmeypjk=;
 b=kutDMGDim9VZwm56i2JpBJmW/f0lrtPldhM0Gau04cOMFnznFf8d5PrtarPc1izK+fNMlArpUHoZFtC+qqQdASHXlerJdFvGCv5y8OpNWGrJrAgSDa1L7Em2ogCqUrE+MSuqKbGQwhOOCi0hbzre8IHeL1Sv6msBZwvaDRoRrlZLLYQpC80dlytIPFUiUmtiOjlz1VCsPn6wHZfGvQEyVwLdLQIHl21qbihoxKI+kaocrYpNy3NGPOiGXwR7qoDDDHRwqX5+ID6ULQEUuKKnbNktuKqi7VJkFaExdFqKvqm0DglVD24NNXakNWO150FlaoA7lxS0f/wti5HtWBgAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 22:39:12 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 22:39:12 +0000
Message-ID: <ceceb5ec-68ec-4d61-a94e-ffd3d2e869c0@intel.com>
Date: Thu, 27 Mar 2025 18:39:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Invalidate L3 read-only cachelines for geometry
 streams too
To: Kenneth Graunke <kenneth@whitecape.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20250320101212.7624-1-kenneth@whitecape.org>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <20250320101212.7624-1-kenneth@whitecape.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DM6PR11MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f45aa8-21f9-43bf-f3b5-08dd6d80320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHdIK0NjcnMyRnhEWTB5NGdNUVlpaGx3VFBxVzlTUnFEQm1HbWFlM3FINnB4?=
 =?utf-8?B?ZHord3I1eW9tczJMbkwvREpGVDFtWVJyV1dlcXNBOUNNN1BRSXlUL0s5VlVU?=
 =?utf-8?B?eXQwcVZxLzRpNnh6KyszSzN1aFl6WjNuVU44b0h4S0dPWmtRZVo2M1pyMFBv?=
 =?utf-8?B?NTQ3QVg3a1RYSDNzN1Yvb1FLaERUaHh2LzVYSWtVTFFhSjVzUWNhTk9aWDhn?=
 =?utf-8?B?MlZ0d3l5OTBmdTdMclljT1hjcUlrdEY4SWlRMllib3ZPM0FBdnNSZElDakRL?=
 =?utf-8?B?anRYeDBtUS84L3pFMTM4OVlFNTVSejZpa2cwVHhEMXMxMkFNaE1xWkRzNm1w?=
 =?utf-8?B?SVBRWm1MVWE0UDFpUmRHOUlpTTl6NDlkZjYyQkZwV1B5eXBNQnZ3QmJhMHlQ?=
 =?utf-8?B?WTEyOGpUT081NTZYaFhEcFZBa2hqSHZLdUw5aU0zSlJvVkNIb0lobmRqd0tF?=
 =?utf-8?B?V0NxTmlwY3oxbUk2R3hwaFlobjdScVgzTTBIMWkySmVjN1pDbmdyVjdzKzVT?=
 =?utf-8?B?KzRKaUNNM3paaGJtKzAzSSt4dnhuVERHdDFqTFN3TXdlS3V1dXduTmplYk9E?=
 =?utf-8?B?QlJacjBQR29BZk9IM2UvM0g5Qm1wZkF0TzhoWWJGTEpybkIzK0VPTjVKVVYr?=
 =?utf-8?B?Rk5iOWt4NENpL0pvQ2lqdDQrdEg3RE80SVZMSTBlK0RSYWxGMnNqY0w0aTRL?=
 =?utf-8?B?dGlGM1NCKzdnQXFldVMydjFvNHNsdG16bWR4am55TlY3QUYzdjBRVTJJM0hv?=
 =?utf-8?B?ZUUwYlA0NzVEWmJIN0w4VkUzYy9RMDhpMnM2a0JPOXUvcklDY2k3NUVEKzhC?=
 =?utf-8?B?MGVaVGZJOXBWUk5vMmtvUzRzcUwyNmxmSUNkRXZJUm9hdmYxRmgwZzRLMXNn?=
 =?utf-8?B?WVJDb0RPLzFzY2h1VjVXdDBicEx4ZHJ2d09vZ2ZlZm1wU0orYVZocUx2dU1D?=
 =?utf-8?B?SVhCYW9xaktXdG9RR3RrM3lrU3FIZjYvMEtjZXkrSU5rbkZyMDdBNjNOeHJv?=
 =?utf-8?B?cVlYM1VBWUhUcTFOdDlzQ1dzd2oyVDFqWlFjdkFMc0VYYnpBa3ZiYXBGN05W?=
 =?utf-8?B?TUxPcVF3YjNzY093Uk8vQXlkWjZhczY1aEtWd0dpdjhETTNEbWI3d2NzWVNa?=
 =?utf-8?B?VStoWjdCb1kzSFR1SW9nVlFqMnQ2YU5ZYjBVdGtjUTVUd0I5RGEvNWlyKzZP?=
 =?utf-8?B?RG0rNHNSVDRXTmJ4MDM3OWFTcHI0cGZkMElxSDN2cFRnQ093Rnk2cnQ1ZTI1?=
 =?utf-8?B?YkU5c0tJSVdZVkN0T2Y1QWtEazBMVmNETmZ4aE80WFEyTzJ6QjFEdGVmMWVL?=
 =?utf-8?B?eXB1T3BaYk9TRldNdnFMc2tDdzVVeUxhOGk4dXE5TThleUhpWFhaNlZxWXly?=
 =?utf-8?B?YTZyUEpaVG9XRHJNVWwyMmoxS3ZwbmFCUmNUSy9xemNRTDNmcXAvMUVjTkVZ?=
 =?utf-8?B?bHh6QUxiVnNjczJkclRndTZhcHhSVU0xMS8xcG5UTndTSThNRjBDM1IrS1g1?=
 =?utf-8?B?RGtFcisrSHNyQSswVXRzTlBwVFlIWSt4ekNkamRwL2Fqc0x5dFBSMDR4SnBY?=
 =?utf-8?B?c1RxcGt2TCtKSU5CZzZKUWtkNEM0N2JiYmZFM3diTmFibDlqYmdlVFVIalhT?=
 =?utf-8?B?eTlJa2RodjJnMUlWb3BlSS9XQnJxZGExUnZTQU9OeFFVcDloS05Fd3MybGE2?=
 =?utf-8?B?M0V4RnltSmZ2L2FJTHNna0FZUE9XRTl3YmVvMjFJT1g4QkVJVWRqYURDNExt?=
 =?utf-8?B?QjRObzJBTDdnSGYrWldYS3FWekpzd0dOc1BrNnFPeXBPdXByeis3UVdpY2pH?=
 =?utf-8?Q?ABPe/ctN3xG26kVHMKwx0xNZ8SI/TZmC7Pg/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHF1dDhWMVl6NUdSTkZha2EycTlGNW9KVDB3NVg4WCtsWlFKOHl6UVgrdE1C?=
 =?utf-8?B?RzRQa0lUM2Q1UU1wOU5WUVcySm41Rmc5UVN5V205TEd4SzBpc2Z4Y0R2aFox?=
 =?utf-8?B?T2FkbFd5UDNXTmljZHJYQnhWNE5TOG5iR3RqSCtDSjRvVnBPV1kwNERrNkND?=
 =?utf-8?B?aWtsd3RVMWVnb2VqUlEwOWJoMlp3YmZFellBV2dpT3I2Q29MaDVKRHJaYzZJ?=
 =?utf-8?B?T0hMSHdYZUNrRVphZ2RBS2ZBRVVGU3hwQVUyYmI2Q2pQaHFobk03RWNMUGg0?=
 =?utf-8?B?bGE1RmFzV3RLbjhqeEY4VnF4QnlCL0ErcXk4aVpZMk83S09la0lQcHM5L2RQ?=
 =?utf-8?B?bnVrTWtQTW9ad090NVdpeGhRVkdkanZRYmpoQVlqN0E0Z3p2MWp4V2RnZVlX?=
 =?utf-8?B?cmcrT3FjeitGd0kwMFBMbVJSRWVWMTJQdXRqdWc0U1NYUExBdzFONEI0R1E1?=
 =?utf-8?B?TnYrMjhKVHlXQWNVS3dXMUVCc3ZOb24yNHhNalgrNlg1RXhkM1ZmN1JIc0RX?=
 =?utf-8?B?OGlESFRZRitIS3pKcTZ5OW1rdkkrQ1phK1YyQUl4bjJDTzFKYnhHSmhndUM0?=
 =?utf-8?B?NXUyM3VPeDJBVDF5dmpDVHBMN0FhMUwvNVY0Qmw3TnA1L016c001dDBJejVE?=
 =?utf-8?B?WEJQdnFmYXRLM3BwN1NlQ1FjQVVvTE8wM1hYRUZCQ2lVZmxVUmhKMWRwV2Q4?=
 =?utf-8?B?blk2N1JiRkczWnNLZUVRc2xzYzJnSTJMc3owcEhDT0c3Y0pZNkJLQXZVUi9J?=
 =?utf-8?B?bVhacWZrMTJjdHJuU2JrYnNxUk9WSU83N2hVZmZtSE9GaG12eXNodzNPblMy?=
 =?utf-8?B?T1kweTkvQmpnWUxxUGRsdEs1RFFSOWZRUmFTandjOXAwbTRMVHhzM0orZGlY?=
 =?utf-8?B?N1F3K3lZZHVGTVlFam9WK0k1aEVabURrY1dQRGcvd1ByVnJMZ0QvREppdGNI?=
 =?utf-8?B?c0tVb21HRWpuRnpEcURpSFEybkZNZXl0VEg3NitnMXI0UkNrdFNWQXkvVUdJ?=
 =?utf-8?B?ZUNQZVFWdFRoYmhTbGJhbzJSQkt1bzlpeitQMWNuOThzTnZnYWZudzlSTXhB?=
 =?utf-8?B?Mk93YUdJOVdLazhQay9PRWxsWnlhRFdtMEowSHJycHhsbGlLR1JHb3VFNmZU?=
 =?utf-8?B?MmNSRHoxU0JROGdadjBmdUdTQkZmSzFVSXlMQ0ZGUG5FbkZXWGg4UEh5OHZm?=
 =?utf-8?B?WTVja3hYR3NCLzhxL0dwZ3h3RFhNdHI0aEV0aXNGVXk1TlExMkV3dlU5bTlW?=
 =?utf-8?B?QkFFYW9QYnVGWmM4Mzg4Z2dDTDY4WWQvV1NraUc1cjJvQkFPS2t3bXZZY0Fi?=
 =?utf-8?B?S0NWM0lFd2FxaUtmOUhJMFR5YmRmellYazQ5OFRia2t0RGhiU2RRZ3JRZ096?=
 =?utf-8?B?VHE3ZVdNVTlQOGh3WGltcXh4bXVXUDY3YmZoYllsWkp1MmwyelBVa0tIWDM1?=
 =?utf-8?B?ci9HSFhSdHlhZ2VsRlNOczJBNjAvbEdERktvUGh6T1FEQ1o4MVRqKzBiWnNO?=
 =?utf-8?B?R1haRllhRlJaQ01vYjUrZVAzWkZVWkNPSGNtaE1odW1ZakVJczM0QnJ0L09r?=
 =?utf-8?B?QjlnT0JMeWFmZGdpOGYxZ0tDVjlHOUZjMGhRSjJOWFhEWUdFN2daVzJMQzk1?=
 =?utf-8?B?dWVZV21WL3Bnb2NBZ3pLMkdiUytrZDNWaEkzZ090RmZUQjZ4LzVydU1oeHhO?=
 =?utf-8?B?S1VuTDlNMHNiaDZNZU9Pa1pJOExLbG5JTUMvTnk4aTdvc3U1NnBjdVRMei9x?=
 =?utf-8?B?c3M3cFZhMk9sS3V0Uy9BYlVrajVTUkNXZXY0bUhNUTNESlZHRDRZRXZaTWtC?=
 =?utf-8?B?bTBxL0x1ajQwMkRiR2dYRlNUendUZnVUT1JLa1I2UEJhSDZ3eURMNkd3V0xH?=
 =?utf-8?B?dTFLTGJRRFBVUVZ6VHcwalQ2RmtwcFVEV29qKzIrKytWTGpwVkY5NmQ1WlY5?=
 =?utf-8?B?SzdqS0pJczhVajFHTy9SMnZaeWl3ajcyaUJicHNId3EwUlFpYk1iME1tWVRQ?=
 =?utf-8?B?LzUxbGd0WHZYTEp3NmhtNEVCMjJ3dGtoN1k4WitxT2tWWVNINXovdVFPVWNR?=
 =?utf-8?B?YVYwVlBkeTFmUHFHcmdscWtNNTBVQ3lmWHpvT3ZyMjZKOWppNWtVcUZKekc4?=
 =?utf-8?B?S0FvL2hhd2dYa0ZXbkNFQnhMTWNQdyt1TXJVTWU3ZEtaT3BiRTB4a0lXQzdB?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f45aa8-21f9-43bf-f3b5-08dd6d80320c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 22:39:12.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn6o4ovt0YmKrT8fgJPQugbz5L6niLhEUKSKR6pNieWM/EDYAE6hn7Jp8wy3VLxOzIEGSbW4ehr0rrgR5lWCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-OriginatorOrg: intel.com


On 2025-03-20 6:11 a.m., Kenneth Graunke wrote:
> Historically, the Vertex Fetcher unit has not been an L3 client.  That
> meant that, when a buffer containing vertex data was written to, it was
> necessary to issue a PIPE_CONTROL::VF Cache Invalidate to invalidate any
> VF L2 cachelines associated with that buffer, so the new value would be
> properly read from memory.
> 
> Since Tigerlake and later, VERTEX_BUFFER_STATE and 3DSTATE_INDEX_BUFFER
> have included an "L3 Bypass Enable" bit which userspace drivers can set
> to request that the vertex fetcher unit snoop L3.  However, unlike most
> true L3 clients, the "VF Cache Invalidate" bit continues to only
> invalidate the VF L2 cache - and not any associated L3 lines.
> 
> To handle that, PIPE_CONTROL has a new "L3 Read Only Cache Invalidation
> Bit", which according to the docs, "controls the invalidation of the
> Geometry streams cached in L3 cache at the top of the pipe."  In other
> words, the vertex and index buffer data that gets cached in L3 when
> "L3 Bypass Disable" is set.
> 
> Mesa always sets L3 Bypass Disable so that the VF unit snoops L3, and
> whenever it issues a VF Cache Invalidate, it also issues a L3 Read Only
> Cache Invalidate so that both L2 and L3 vertex data is invalidated.
> 
> xe is issuing VF cache invalidates too (which handles cases like CPU
> writes to a buffer between GPU batches).  Because userspace may enable
> L3 snooping, it needs to issue an L3 Read Only Cache Invalidate as well.
> 
> Fixes significant flickering in Firefox on Meteorlake, which was writing
> to vertex buffers via the CPU between batches; the missing L3 Read Only
> invalidates were causing the vertex fetcher to read stale data from L3.
> 
> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4460
> Cc: stable@vger.kernel.org # v6.13+
> ---
>   drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
>   drivers/gpu/drm/xe/xe_ring_ops.c                  | 13 +++++++++----
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> index a255946b6f77e..8cfcd3360896c 100644
> --- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> +++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
> @@ -41,6 +41,7 @@
>   
>   #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
>   
> +#define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)	/* gen12 */
>   #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
>   
>   #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
> diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
> index 0c230ee53bba5..9d8901a33205a 100644
> --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> @@ -141,7 +141,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, u32 bit_group_1, u32 offset,
>   static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
>   				int i)
>   {
> -	u32 flags = PIPE_CONTROL_CS_STALL |
> +	u32 flags0 = 0;
> +	u32 flags1 = PIPE_CONTROL_CS_STALL |
>   		PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
>   		PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
>   		PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
> @@ -152,11 +153,15 @@ static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
>   		PIPE_CONTROL_STORE_DATA_INDEX;
>   
>   	if (invalidate_tlb)
> -		flags |= PIPE_CONTROL_TLB_INVALIDATE;
> +		flags1 |= PIPE_CONTROL_TLB_INVALIDATE;
>   
> -	flags &= ~mask_flags;
> +	flags1 &= ~mask_flags;
>   
> -	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
> +	if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
> +		flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
> +
> +	return emit_pipe_control(dw, i, flags0, flags1,
> +				 LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
New PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	defined as spec documented.
New flags0/1 handling looks good to me.

For some reason this patch did not triggers automatic CI run:

Address 'kenneth@whitecape.org' is not on the allowlist!
Exception occurred during validation, bailing out!

Let me check what we can do. CI run result is required before moving 
forward.

>   }
>   
>   static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,


