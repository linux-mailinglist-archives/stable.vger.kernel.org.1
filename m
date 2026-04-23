Return-Path: <stable+bounces-240521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHQ3A2tZ6mmgyQIAu9opvQ
	(envelope-from <stable+bounces-240521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:39:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1B455A13
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16269300B11A
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6C3A75B2;
	Thu, 23 Apr 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLXUkWoW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943D3033DF;
	Thu, 23 Apr 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965953; cv=fail; b=ujLtLL9knSn5+rz8DwZmeDkrOFG8yTP9WUjUrgGJUJVG3pfib8vLNnKduz0PJppt7CZLZTjepQ9ePFvCQbqJm6Ecqh42qsyUuc45SFhs4sxYikJuCHSAlWfq6URjyZYGCLprf/6NSs4MT8g92imEIFfP+UYIyGEYLqAx43WkHsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965953; c=relaxed/simple;
	bh=NnWtyQipXeosPYGbaQkyhKn+kt8SV0o1W+WJYpdwLbA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cju5r+da3KoPXuN7CFK8u5l7xBqNzvdIUyTKe6cwLgpe3bEmpTljDEJiiiyjcAQFny3FxYwhcf9rZY/kwfSKakTteZHdIN4fylIDpHmNCGftgIkKzLPdz5Q1qRFZxpQExv+QxmoAAGLMoGtDpB/mbjvDsD0cNIaP1btmy6vPjYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLXUkWoW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776965951; x=1808501951;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NnWtyQipXeosPYGbaQkyhKn+kt8SV0o1W+WJYpdwLbA=;
  b=HLXUkWoWqM4zMOiy/P5C4KRC4SOyhvv5v7qPoQgg+9mXx05DYfr7bx+C
   xJ1sS8Il1GsLVNFU+nsYDtGot6AfCtE4dzBdm8rGYnzjIT/jYst6jROos
   BDCZ4fyuG80yKdzrk0I4mUT3K78FwvtkpOw4FDif67ix49Poh7uRjoMQl
   LCKkLo2boNomcfn/58sPnFsXpecOOrP9A57OAfO/y4nCV9bxMJAmtBFY0
   0WwUzG55YY6w4styyMIcpZRwNRnPUGjaU65HdB/+8pE/1ayYiIh+mdrHV
   07TXqrgVK2O3chd0PJnzJMJ0Ngfzd/t6S+unh39LJXtGuMDbpun3oo+kK
   Q==;
X-CSE-ConnectionGUID: UvfWZqNsRK2hp841LJJ79w==
X-CSE-MsgGUID: DNLcLeAqRXykbFEnpxCnHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="80527713"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="80527713"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:39:10 -0700
X-CSE-ConnectionGUID: RRR174o3SCyUVaoM3Fr0Zg==
X-CSE-MsgGUID: g65eILtnRfiGqfYOy11yrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="256225444"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:39:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 10:39:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 10:39:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 10:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvcCsLKH+jS3KjVWnocM+uSu8UsIoAmJznAYM9raBLUUy4bX5pgQujL4QnPtHF86aoqfZ6mNLV0pAsCBPaqN5pJ9gNn8smqYp6GVJKptysKC4WmoUzPiXxfWSYU3zfaUxUHDt7ohxXxydhThummlt/Flm8MVo+w7jBeQYYIexBeJH18i57wOHaJakjwrtWiWffaMn235DrorcCTEujsqlUv4MKsl7fGa84FVw/QIcwLI1eC3n/r8dWDmZFzzb979XJJSTOteUJt6Id5jYDKXttUctHDq/ole0xFFEGFPqxRDHxeRg0E+URTXZD1+lvDHDi0E28wObRPitUP5ObY+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3igVvXdPkCE0+K9mC0k2/F1VjMjO11dOv3d/eJZTiQ=;
 b=Qd1g7lu4WfkP4Zi0jRFyZ3YccNMZ8M/lKCEKCvP+scuWuWp6TT7LQUXW3B3xn0QS/5PuntaAd7122POaHhvtDpZfEP/SssOWLXOZxl+tRbUj8yuURPoYb9wocYSps/i5bac2DVy6r0pHBIP1RNU26ZsQh16q/vF7Ef/O1VGWWHJyslbRWgF+OqENHpx0u8gqyjTFf00CpUe5QLy/PntBCF15CF1T6+ve1q1I2rMQcnDOfoJ9YQ0tarNb+b4b+q0+6rC1hU4ezam220HNVTdfqW7TFqmzILbiaSYRmL/hyaIFHufKfgg4lY3psHa9mk+wD31JmB0aM3bgH9RUwu4HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 17:39:01 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 17:39:01 +0000
Message-ID: <e256413a-531e-462e-8d8b-ab42f3fc4d18@intel.com>
Date: Thu, 23 Apr 2026 10:38:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] i40e: Fix preempt count leak in napi poll
 tracepoint
To: <charles_xu@189.cn>, <tglx@kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <joe@dama.to>, <aleksandr.loktionov@intel.com>,
	<stable@vger.kernel.org>
References: <20260421071838.3878-1-charles_xu@189.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260421071838.3878-1-charles_xu@189.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc30c2a-cce7-4352-98e0-08dea15f34d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qR24aEk+B1pw0oyJ48ueVie1jiz245eob2LmB6sCQVB4isKwlQMZsF0aURWM0nLdXgSulA07M/CAqDa+mV0Cnw4ulevy9hJRuoWlPZzWDJR44f/g1h8Zbc9EMfX58LVVC8o/amztGc0f3XOjpZG5IxVGRcmbTenp7BLHhpvQBaJcbB7TaguKaFI/0l7Yv78Aip8XEIEaVevma77rEC+AWF8TMz4ZgSXb/6NnufuVjViZEUX2FL8jGvvt20/gW3Jf9bGgwRGvAAAlfoFGdzeLxGkqVRliTI8bAC4HeiRaIWGmsaGNYcpCbMUAlGXHxup5N3qTeKD3f7JCb1D8C5HpFkdynnjXM1Tu7GjahBBCYbj0xki5meqzdV+coJDbsLbgxap2MzUa/Gj2o8lt7gwJNgwGRCjeihpTiAmC5OL/97uMlm2J389jAvtlVLvrtAMeB4msNUccVcQlREzTy78UGsqa8g5kIxu45xDiSgXTzMRgl9v+2r/005toQfCf7dFUBvswhhbFVqL5caIdQwMhgxNlkJG5e85XoSMv3ahzEx8yC26C7P2QsMR7EFOI9/W96eGU4zsXYHdT5pKKQFEaX+Kwp6e0eRfAGzveoSHIEppkhYxfR5sgiUHv0vLKMvbb8Ln3wuS8LISL/P2lKbw+SQ/QsXHn1zXIlcn79lYugOgWdpTxaFYrDSfMbanPPoRf0tWdTXW0StSYwc53kG96AowJm4gHp38UC3IkET5Ch1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFGRkNPcXViN3Jib3BEMkhKQmZHRmptK0NFUUpad2l4d2YybDJ6ZTA5a2JH?=
 =?utf-8?B?elV1TElkRWd1ZFlRWHRHRVZtTVVGZUVyL1FwMXhhUDJ2OVlMQTFrQTR6cmRN?=
 =?utf-8?B?UmJ2TklYdnhaL05hckluTDU3Q1VOek9zWi9OQUxsRkV4cFc4c0c4cGorb2s5?=
 =?utf-8?B?aHBWVjUybElJRzFiWm4zSmpwTVZsTjVBa3JacEVNdnZGeGE3VEwwN0dzVjl6?=
 =?utf-8?B?ZlhSdTdaWGZTYU04aDljNCs4ZWNXcHdpK0Q2aUd5S3NJUXJCNWloMmRTYitZ?=
 =?utf-8?B?TFdzcGkrbW41MnFyOFprK1VDU2xTNjl6SHpEN2Z2Q283azI0dE16RzYrUXkw?=
 =?utf-8?B?TWVEOWptT3VzaGtGVDA1R0VVYklBcmNKRW9Yemp6WGt6aVRLQ3VmdElsQThS?=
 =?utf-8?B?MmhQNkwrMFlqY1VLRmZYckJIWjRLUFB6Zi9acThNK21kZWNPUHEzb0ZzLzQy?=
 =?utf-8?B?bEUyL01IaEdnaWJ6QmpKNWg4aXRzVDEyVGc2YkpyTEpteGp3NWdkcHRKV2JN?=
 =?utf-8?B?dFpDTG9RTHloVkhIQmg1ZkZmY3VEVnQzUHJRb2pHcW5hZWp5VW94WFNRZlBV?=
 =?utf-8?B?cksrVDFDTEJSb3IxNkVwWHpqZndFSHAvc3pOYTF3eWhJV3pPS2IvUUpaZEpW?=
 =?utf-8?B?Y2RmMVNRdVFyRGFPdTV1V3V2NU9oY0ZQR0dIS3dQNUNEMUFRODhZc3l2YTNt?=
 =?utf-8?B?UWx4MlhNb3R6UXNhQTBCTFlzbHZTaGV3NTVpb2xnYi9reVIwOGVadnZyTThD?=
 =?utf-8?B?MldDZ0ttNTM3T011T1Fmcmx3eVkyekJkcjdlY09QR3BZQ0dSZG43ZXpCSytu?=
 =?utf-8?B?ZitKcXZkVVNsNHBDb0VXZ29sT0pic0xhKzlYY3htUk9BSzZDVFJINElUM3pI?=
 =?utf-8?B?aUdjMlB0THNQZmdzamRHSUZ6eEdES2RDTlR1U3N5TklGTE1yNTVSZ0g1R3ow?=
 =?utf-8?B?bjJKU1ZyOFhhNExvTWtpdWxPV0Q2bWdTdUt3bVlKOVdHUTVjM3JEUUJES25X?=
 =?utf-8?B?RDV1VEdXS2NyKzRIdlFRdG5NWjl4UFBRdXRZcGFBTHhhSEtrWnRnNTBnNnFy?=
 =?utf-8?B?UWtPMWlJQjdjVEM5dmx6K1BSak9iVlpySU9LRlluNm5PcnBlWFVwRHdEaVNZ?=
 =?utf-8?B?cklUajF5V1JrazZrS2ZreStScDBLVGgzT1djUUhIaDR4MDduUEkxUkNEMlow?=
 =?utf-8?B?YmtJcUs2dWRiWmdlbHEvWlNmNytzRmF2M01kYVpUM2ExS0JZU0FPY1UzeVRz?=
 =?utf-8?B?QWIrR1I3a2xPbzZVOE5JbmgxL0NETHFhajVVaEh0d1dJMVlxZlR4OFV2cmxF?=
 =?utf-8?B?T0wyVm52US85dWxjM0Q4U2xoUXU1emcwcmR3WlV0ejJPWXM0N1hlNjdnemF2?=
 =?utf-8?B?T2djT3IzV1UxNG0yMzlJcjhvUExTU1RvQ0FOeVNLbUZFNW5TMFFnNnh3MzJT?=
 =?utf-8?B?S1JCdVBLRmxkVXcyWmYrTHJ3L1pGMmxhRW5tTkprUkxZNFpzeGIyWDJ3bGtD?=
 =?utf-8?B?bjJjZkRvUkRvM2xYTGVBMlpPdXdjRDlHd3FnQk9CdE1jQUI4cGcxQVNpblRS?=
 =?utf-8?B?ZzBRdEhTK0Z5bnhPU0hDQXhmQXdoSyttU1BKM1gyUzN4dm5pem5TcHM0L0gx?=
 =?utf-8?B?Z1lOV2NqYUk0enRkbldOZ0NQdWVGUGdTaWJjUGtOUHh5V2E1NDJjamxZMmpH?=
 =?utf-8?B?ek84LzYwQXlWUGlFN3Vmdzh3Uy94NkFhV2JVTU0zdHB4Z0hTVEhHUzBaemw1?=
 =?utf-8?B?Nk1KUENjQ2E1WXA5UXc0b05BcEEwS2p1WFVYTWREWk9qdmpVY25ST3NyRTlN?=
 =?utf-8?B?Q1RhOW9TcDU4dkxRMXlzRGc4S2J2Wm5iSzA2LzFGeUlGb21TeHIxa1lqcDVN?=
 =?utf-8?B?WFhzKy9jQjFvVzdBWEJzbFdqS210bjFJcGxwbGRpZ1F3K29DNFFkMmNkYi9C?=
 =?utf-8?B?OXYxYTY3TC9DWU5lQ2RqUUkveVM2NEVhNWZGenhsMFdxV3FKMW1Ma3FoMW5M?=
 =?utf-8?B?eWt1eXpSeGZYUG5UbU5NQU92cHd1cTJRekZKRm5EcEVFT0F0UmcrVGpzN081?=
 =?utf-8?B?K1JPUWZMUmRRcGdtVHBIWlpJanVoVXBmNFE1c2ErSkxoNGRZbTZxbnpXUkl5?=
 =?utf-8?B?MGVVQkxXWG1KM2swSFhhcjlUYWQvUmRlM2pHMnJRblRPMDlOeUU0ZGZPZ0RF?=
 =?utf-8?B?bWVHM0FrSzNjVGxnOExQcUlkanNFWWw0eGZWQmRKOWliUjJIYnR3eVNzWTJz?=
 =?utf-8?B?S0lCZmRuWnFraW9TanRiRUlSbzBUUkRDTndXcXBzL2J1NzZLS2E0dDFMdEVh?=
 =?utf-8?B?S2dBMFRMdGlLWEpGeERFTWNYYm0zb3FpSno1czFHTkRhZ3ZzY3RNcDk1WE5P?=
 =?utf-8?Q?Iyryw7ZUWKuiAuKw=3D?=
X-Exchange-RoutingPolicyChecked: KqwsTxNelbjDlY8+Nm0N08bt1w68cxjlk89mFCS7fvlmu68e4/igU6klXhQ4GZlbIqMLWXiIUmeWOZGLoaJmFBJg9i4PFF6g+/6Y7E6daHptkvnXCt6yyOcVfe86hKYSMX5NKq3v49zEPQeSRI9ahZpTa4OULbvFt7jZgtVx0RXMl/XzIJWSGMxm5v/XaOH+GJCZyWN/WmPSsRscTJQ4Or/sDOWCGi90J0kbn7JQNfpAxKSrTVbvCVk4jX1JMvoHYUV6HbToziZRtHppLQzoIUPwc41mxiooKfSORo/jcHMwywRRIMvW9pwS47+A4IvNjaxNii7P64gTqnfSQv0Dmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc30c2a-cce7-4352-98e0-08dea15f34d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:39:01.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orqBUQIlvXXovVSHskakz8rLo6jQjzSNW6I3GZxMxZo7Jdy1QS5BGvm7fmAHdk5fYUYpjnUyaamg20SIjmo04zglGh0+SzcjfpYKAO4ICWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[189.cn,kernel.org,intel.com,lists.osuosl.org,vger.kernel.org,dama.to];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240521-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,osuosl.org:email];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A5C1B455A13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 12:18 AM, charles_xu@189.cn wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> [ Upstream commit 4b3d54a85bd37ebf2d9836f0d0de775c0ff21af9 ]
> 
> Using get_cpu() in the tracepoint assignment causes an obvious preempt
> count leak because nothing invokes put_cpu() to undo it:
> 
>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
> 
> This clearly has seen a lot of testing in the last 3+ years...
> 
> Use smp_processor_id() instead.
> 
> Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Reviewed-by: Joe Damato <joe@dama.to>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Charles Xu <charles_xu@189.cn>
> ---

This was already backported 6.12, but wasn't in v6.6. The v6.6 tree does
have the i40e_napi_poll tracepoint, so it makes sense to backport this
there as well.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

