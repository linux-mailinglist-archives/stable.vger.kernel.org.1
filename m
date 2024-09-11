Return-Path: <stable+bounces-75789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC829749E4
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F72C1F22606
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8442052;
	Wed, 11 Sep 2024 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo9OjKkA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371A22066
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726033192; cv=fail; b=MGO6TZITIRnOwugpD+KLVnYaMb1gnCVTcURgnUhkLAV1/qdz9zvjVg53dCFgOeg8iu5d1M9wGy49Wr0N2hTHSpUeTWPJJcLYidyO5CL+CbQFXgu8zh9e/fw7mYJuawNPEQT8/zfnM6Wd3aV7aI75o3/PKup6EWMk5hDtR9ok0N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726033192; c=relaxed/simple;
	bh=RbHdUbdPIkaek5vyQQTrVcaxRuytXYTGUILamRs/Edc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+r3x5xxd120v2g7G2ggdCqmqlfoHcLlG5wgdiZpP57iyCWKbPEjZlU6+FIZTtmOfnEszOIjSuaix11LTbo6xsHL6p0ZISjO04QMq5jKQZJi7aw3exaAGScIW021eqwk9OT53PYZkzGRvv0yfc7kf3lBM/rpS+5mQmkkFxXvBeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo9OjKkA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726033190; x=1757569190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RbHdUbdPIkaek5vyQQTrVcaxRuytXYTGUILamRs/Edc=;
  b=Jo9OjKkA6vWtfJKHoh/78OQ/Ea+0fRb6p/r8+cIIgpUpEOibDyIiRWiE
   AnyplXeIuEbCa3uDMCBaDMLtIHx7ox6sDVXV7Ypx830FoD9QYR92Lg1sS
   ahwtZ5XMsbKm3+oIhq0YvUMocLpYTD2pSHSXGel1JaJ/K5LYTMD6x8RGx
   z80tLk9GdlyRzBTi1I1nvSH559iFB+7e51MR/2ptclxG0IynQmM9YntRY
   2pzkD3E+j15YcQSTGB1TBpZSkoTg0ddf9wBE+ZyVqpWptM6NMIQErOdht
   1fGY4xZvhVnp9rVm1XyFLYpnbBgO5JPq3F+42vcPRdI91NJQndMoTFso0
   A==;
X-CSE-ConnectionGUID: C/twuUU0T4qCuHr1W2x1fA==
X-CSE-MsgGUID: X+VtKMOzR2K/6lnf9Vdvkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42332783"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="42332783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:39:50 -0700
X-CSE-ConnectionGUID: kMmla4K1SViYIfF5XWIHwg==
X-CSE-MsgGUID: 0Uckxl88Rey/6G/s4WbvAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67102048"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 22:39:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 22:39:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 22:39:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 22:39:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3dTBFOpSaeYrNb9whaE9OW791WvTfrpsmVk4vHvnRxzhZMjPwYef9ZO0srtHCaTn6Vcg0NRH9GGMG8JNQMUIgIUVoXws0IO7xSCq/f4bhO4MnCZ2a2U1orihmboB7T75rLZNuVD3IXSDa2iE3jfHPBuRcNxsxu19ryugJdc8JvRZuxg7QGvvyHYtlPk5ZYVw2nn8L6fzMk3lsxFR8xundNSo8v8joQA5Q/y+QrHNHaphvzLIUK9sFmzWQ5qabaaTEHs14HcW23e7IXeJQTzStUhbxPxNuZCQHGvYwOiJcARc4i5ElqKPhdOJ3bv+z5B8oYEW7O/Y7xIFf/1ndGmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbHdUbdPIkaek5vyQQTrVcaxRuytXYTGUILamRs/Edc=;
 b=myszK56EmOGR3cnvjYz4uk7fa6/+N/TwL5TKHIO8+r5rOpG4zfXzrINd2NZ26x07iHrxeNjap703w7oSn7c3DEjYOVR1xceyI+gFnO4cAp+bXz2+3wlnKC4bSY1ALaCrG3W8uV5dFCQ6seqp9qOdYmUXBV0/nIwwakPpR2mvoa+qMk2geYwZ82IWTfp7UyVoQkddud5wutlaCKSNxj4trBh5i6djCyiq8NLh9lljQ5tZ95cdWdmsvcnP854G7Zww7M6LPRoBSJnX+KEp4dxmaVNmFH8SsuC/Wj5+t9ri4ApA9yFAFnAHueBffntuDp8NSygMkey/T2EOU6ggh1Qp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 05:39:46 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 05:39:46 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
Thread-Topic: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
Thread-Index: AQHbA4Ma5WxJu+ZgYk20Vw3/sruJrLJSEnYg
Date: Wed, 11 Sep 2024 05:39:46 +0000
Message-ID: <SJ1PR11MB620426C360C56AE7A55D6DA7819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
 <20240910131145.136984-6-matthew.auld@intel.com>
In-Reply-To: <20240910131145.136984-6-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|BL1PR11MB5269:EE_
x-ms-office365-filtering-correlation-id: 5b056b94-6ba2-4f51-2cc7-08dcd224250c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OVhxTlNuejBmSWdqV0tJUUdkRTQyUGZNeXJhOXF6UUozWlB4UnJyQ2VPdFdj?=
 =?utf-8?B?K3pEdWhuTUhCYnlwd0YxYWlMeEZ0ckFUcEd5N0k0UG9xSU5kWDlyMkJ5SzYy?=
 =?utf-8?B?Y0QyejQyMjE3MlU3SkJRdDMzVlVCeUtxRzBTN3NFT1d6b3FOa2l5N25YdGh2?=
 =?utf-8?B?YW5CUjN2VlB0RTBHT1hEVTZFM3NPSVRGTWNvdzdUVHhIZUZUZW1kdTEzVWJC?=
 =?utf-8?B?NEh2MENBRDF1c2dmV1ZiUlRKSk9PcVU0NEQyRXVSREJoZW1aTlZMb0ZHTXcy?=
 =?utf-8?B?NHFZNFdDVWNQMllhT0dTREhHdTFRMzJBN09HY2ttL1J1WFlZUkxPSGRVWkZV?=
 =?utf-8?B?eWRNeEQ5VWNzWmt4NDlkN2RqQU5VTHplMGlObkoxbWVsb1BsWjBzeVI1ZjlO?=
 =?utf-8?B?V004VDhPK2FUbnM0dkRuMC9adXhuU2lmbzdyaEpzUGQ0dkQ4aTUxTTRjcjVn?=
 =?utf-8?B?NkUyK1prbnBTSDRFNUtiQjhiQlovbkw2M3BIeU0rSWVUcDU0YUZwbjlTcVhB?=
 =?utf-8?B?a2Zua0NYNFUzcjQ5aVlNUGVJWGY2cEpyaElKbGZxSDZUVnF3alhreUNoOEpC?=
 =?utf-8?B?R2VmcCtOY25QSWVOU05TWStXbGVkRDhzdXJaZEZrd2pVTDFCVnNXWUZGNHl3?=
 =?utf-8?B?eFdqVTRyL09DaFFqcWF3ejhmSXBUYmVnZjhkQm9Gc1hXczBjcnJxWGR2NTBE?=
 =?utf-8?B?V3FjaVZCd3l4SGIwaEVUSklFbHhod3BNSlhnSDZyT0JTRXFNSjE1MThHeURy?=
 =?utf-8?B?aGZwNW02Sm5CeFNZQ1NsSFY2OHlHUHZ1eW5GYnI0QkJFNlMwYUZKTGhNQWw3?=
 =?utf-8?B?VUt3b3VyZVRybHpmaGxlTEFJQmRZZjVEOTNZckJBRFpIRXFENGR2TkhVUEhR?=
 =?utf-8?B?TmxaVXFTMjgxNEtsNlJlM2VZczV6OUxJdlNYNVk2OUVjcUZCcGRGS2FIbnMr?=
 =?utf-8?B?UWxVNDhyNHFwVlhVeEU1WXNrdVArRGZMOWhjRGE2cGlZTkxvNklGbU41V0Nz?=
 =?utf-8?B?Q3M0bTd4ODB2Vy9nZEhpSnJoRGFKdTB1Q3lqdHJqc0ZVL2tnZE5BTVJMMnkr?=
 =?utf-8?B?blFTbjJSaGFOR1lsTXhYM1NqZWRhSWhKcm5ZYUtWQWpTZ045T2pnZmJVR2l4?=
 =?utf-8?B?RldiSUFXcU9GUlBtLzRBanJ3bm4yQWpWRzhzOURmUzE0cXp6MVdkS09JdGNr?=
 =?utf-8?B?dUxUZzlEb1JsRlo3enB4RzhyazJ3UnpHNkRPaEI5UEQ3YXFkVUdheHBqYzN1?=
 =?utf-8?B?L2hlWHoxSmJLY2FCNENhMzcxWDlYNzNnQzJlcTJiMTRTbEJERHBnbG8yYUZp?=
 =?utf-8?B?cGFZb3U0cFpueVJnZkdUSi9jN2tML2ptdDI3dVA4Ykxwd1IwMk5MTjQ5elpN?=
 =?utf-8?B?YWlXZ3g4RXVEcStjN2pTcUE3Qjg2MWQ3ZjFmSlpkTmp5OEw4R3Bqd215bHIv?=
 =?utf-8?B?cWFTZXJkOUhKbW1ITEwxdXB6YW9YaGxCT1d1N3p4K1BETGg3ZXUyTGR4bml6?=
 =?utf-8?B?cmROTVowb2puRE1LekFwTUdRKzFLUHpZenVDNTJTbjRBaWlWZ0swSVFLZmtz?=
 =?utf-8?B?cEJzYzRQcWJTa1EybnJkNHk3VCtsUGN4MkJiUGJGd0JWa3dvNDYxYmJSdkNE?=
 =?utf-8?B?LzlaN1BKd2R5blV4M1Vlalp6aXN4dEI0TEk0WFppMWtNNmswdFpveUprd1VR?=
 =?utf-8?B?MEx6OVppYy9Yc3llVmNrbUxTYzFWdkgzUGpHSStXd3orME1jejNzeVNRTzZC?=
 =?utf-8?B?b3hyd3dwdkJWdHVtS1F1YTdBM3JEK2wvVW9mb2dxeWtTZWRLZXdNUXA1bDla?=
 =?utf-8?B?cWdwd29QRkMwTEZWV2krVFVpOVUrQ0V1WWo0OHpkeXRYdExUT2IwNmM5MkJD?=
 =?utf-8?B?dWFXUmR5Q0JHSWs1VXlrdlVEZ1Z1Rk4wTWtwZzkrWGhIUVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRsVm50RXIrWmgzWmFGd1ZJL2dwQ0NBY2JKUGExNTBWeEtndzlHY0hZQVUr?=
 =?utf-8?B?b2lMblpDN3ErZDJyQ3RJdmtLUjFYdFFaR3lOU29nWEhENUdwZEtRSUJYRlh6?=
 =?utf-8?B?VXZkbEVpcE8yWEdTU0wyb2pqb2xCVFBDOWlzS0xaRUI5dmYrKzh5K1hoeDZu?=
 =?utf-8?B?NUhiTGhJMWNlNXdHWHQxWER3MytOM245K1VrcjRFZ0UveW45RFlsc3JmVXVi?=
 =?utf-8?B?ZzkrSnFMVjBTWnJRM25VenFxWXhSVzdzVitiekx0NW9hNTdlT0pnZVFWeWhi?=
 =?utf-8?B?TXBITi81bnZqcVhzN211dEUySUtLVXFyYXJSYkU2TW1oemVxVzEzbVNacXRz?=
 =?utf-8?B?T080dU5SdjFDM2s3cnlVNkJTS3Yrclg4NG5od1l0V2ZEQVFGQnBqaHN6akdW?=
 =?utf-8?B?QmRWTEd0MlJVTkhoMHpBeGl1eTlxYnBHZFlWOGVHWEhhSWJ6SFRWMXZZQWFH?=
 =?utf-8?B?eHRtT2lUUlMrNXhXM2M3T0lGS2djM2ZGdDJUclJuOEhkL3EyZ0gvNHlMMXhV?=
 =?utf-8?B?d09pSWpuZXBYTkEvU0VTQktsalI3U00rVjBvL3RMaWNWcEZQbXQ5anFUTktk?=
 =?utf-8?B?YWpIWlUyWkdBZXBnK1hIWFNUV1Z2Yi9ZbVlmSXhJdGRGcCtMZi94dmlJVWxM?=
 =?utf-8?B?SGhVaElaRUdUYWJmYlhiNzVEWUxIbHU2VUNsaG56ZDY3UHZmVktBQlUreWlV?=
 =?utf-8?B?RW9ITmY5dGxpSnZyY29OVWZJb2h0SUt2MjlUeDNSQmNmWGp1aGxFZXA1NUky?=
 =?utf-8?B?SEdtNG4xbUlkRWhob2VINHN2NVEzL01oelVpKzN0Y2M2VjlBbVplbExMTytB?=
 =?utf-8?B?N0UrYjFUMmJKK3B6NFNXTWRySHBuZkU2T2V5ZktubEZCL0hKVXFLL3RjT1pX?=
 =?utf-8?B?OVJxdHkveUlUNFE0eXlqRlNvWTF6MER1MjllQ0srVGpFSXcwK2EzWjJkSnhS?=
 =?utf-8?B?U2xHa0FTVTdUbEdXNDhsYlM0U2VCUHVodmpGRHdaWVhOOWtzZERLWWtKM1Za?=
 =?utf-8?B?eWpYN3huMERVYWNUbXczdVBhZlY5aElRRjcvRTVlVVphUTQ1MGJlc2hSNlA2?=
 =?utf-8?B?Vk9FNmJ4QmpoeDU1b0FYUUtOcWVHMGhCVXRLdGZDTTJaRFowMmZDQU5BQ3NY?=
 =?utf-8?B?aWZ2VFZRT1Z6TVlhSDNPYW9KTnp5L1QxV1hvbDJaTGIvRW4wUFJMay9yZmJH?=
 =?utf-8?B?anRSSDMxdDI5UC83ZVJvQUhuN21vOHJHNzQraGFLaVBCVDM1VWtNL2xLcStQ?=
 =?utf-8?B?STc3R09VQUNxblQrSmpWYXduaU41dFNvZU9RRjk1ZENlOUFpbDg4L1VHZmUv?=
 =?utf-8?B?dW9zUWdndGo2d015VjU4aFZUNmtqaHkrR29TUnVTYk50elVHQWJaSUlJb0sr?=
 =?utf-8?B?V3VHQVorOThhNUxpTkoydlZuMnh6aFN6Q3FDc0R3dEkxb2RtMmZQU3FhTzd6?=
 =?utf-8?B?SncvUWlFaWJ6VTUvTVpYSHpJeURxL0had1B0L2M4bkhUYzREbXdFU2NGWFRI?=
 =?utf-8?B?Q1dQT21GckpaUW5UK2dOeG9vdTNGMmR5SS9TMUZ0SFUzZkpsMFBrS2RQZzhy?=
 =?utf-8?B?NStwTm9ldDZid2M3dzA2OSsvUFpXNEJuOEZhZzRHV0pyZFk2RjRYVmg0YXNT?=
 =?utf-8?B?MnFpOGVQK1hlZmptbjJITmljNzlacTRQakFkcWg4cTlUbTlKek0vTzdRK3pn?=
 =?utf-8?B?YXV3Z1BqSG00NVhRM3lOTCswRmIrd0MvbUIvd014QlJMblpSRTZUSENjdmVF?=
 =?utf-8?B?RDBGaUlwblpnbVdPRCthMi8zYzgvK3h1OEVYMnZoVWtRZk1xa0JLTlFwN2dK?=
 =?utf-8?B?VzlFKzU4TjlVWmtmZDZydVByYUZzMzR3Vkk1Yi9LZ3gvTm00THlaN05jcTBT?=
 =?utf-8?B?dEhTZU5NVGtVOXMxSUFaV25wY25GR1AzZUFnc3FBUzlzS1hlVmZrOEs0VUVt?=
 =?utf-8?B?Um91bkZ2NkdUdmdzSFJ3RlA0NnlwMjI3STBZREo1MkRXaHhmZytlQkVyYTQ0?=
 =?utf-8?B?MkQwK1hONUEySUpDS1FUTnp3NkE1RXJaRjIzZk5Db1ZEU0wrZHNQMVVFbkJM?=
 =?utf-8?B?b0RVWUhDUVp2QmJLckpSRWVMbFg0UXdDQVlyQWpQOUN2N2t5Wm5PeW5vaWlY?=
 =?utf-8?Q?LbOJt0MXsx+f6TzK+S8k/u93i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b056b94-6ba2-4f51-2cc7-08dcd224250c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 05:39:46.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBteoxXUkim8JKyVk84Y/IN0JGGnwK1L6Cb3cFWniGNrXZBPJ3dSRniHFhT4sa7gXbZnpem/Sd5oWq75mop9l2KAevab0LpI/Fj0eE+TALw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEwLCAy
MDI0IDY6NDIgUE0NCj4gVG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
R2hpbWlyYXksIEhpbWFsIFByYXNhZCA8aGltYWwucHJhc2FkLmdoaW1pcmF5QGludGVsLmNvbT47
IFVwYWRoeWF5LA0KPiBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgVGhvbWFzIEhl
bGxzdHLDtm0NCj4gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMi80XSBkcm0veGUvY2xpZW50OiBhZGQg
bWlzc2luZyBibyBsb2NraW5nIGluDQo+IHNob3dfbWVtaW5mbygpDQo+IA0KPiBib19tZW1pbmZv
KCkgd2FudHMgdG8gaW5zcGVjdCBibyBzdGF0ZSBsaWtlIHR0IGFuZCB0aGUgdHRtIHJlc291cmNl
LCBob3dldmVyDQo+IHRoaXMgc3RhdGUgY2FuIGNoYW5nZSBhdCBhbnkgcG9pbnQgbGVhZGluZyB0
byBzdHVmZiBsaWtlIE5QRCBhbmQgVUFGLCBpZiB0aGUgYm8NCj4gbG9jayBpcyBub3QgaGVsZC4g
R3JhYiB0aGUgYm8gbG9jayB3aGVuIGNhbGxpbmcgYm9fbWVtaW5mbygpLCBlbnN1cmluZyB3ZQ0K
PiBkcm9wIGFueSBzcGlubG9ja3MgZmlyc3QuIEluIHRoZSBjYXNlIG9mIG9iamVjdF9pZHIgd2Ug
bm93IGFsc28gbmVlZCB0byBob2xkIGENCj4gcmVmLg0KPiANCj4gRml4ZXM6IDA4NDUyMzMzODhm
OCAoImRybS94ZTogSW1wbGVtZW50IGZkaW5mbyBtZW1vcnkgc3RhdHMgcHJpbnRpbmciKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+IENj
OiBIaW1hbCBQcmFzYWQgR2hpbWlyYXkgPGhpbWFsLnByYXNhZC5naGltaXJheUBpbnRlbC5jb20+
DQo+IENjOiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPg0KPiBDYzog
IlRob21hcyBIZWxsc3Ryw7ZtIiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+
IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni44Kw0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS94ZS94ZV9kcm1fY2xpZW50LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kcm1fY2xpZW50LmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2NsaWVudC5jDQo+IGluZGV4IGJhZGZhMDQ1
ZWFkOC4uM2NjYTc0MWM1MDBjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVf
ZHJtX2NsaWVudC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kcm1fY2xpZW50LmMN
Cj4gQEAgLTEwLDYgKzEwLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4NCj4gDQo+ICsjaW5jbHVkZSAieGVfYXNzZXJ0LmgiDQo+ICAj
aW5jbHVkZSAieGVfYm8uaCINCj4gICNpbmNsdWRlICJ4ZV9ib190eXBlcy5oIg0KPiAgI2luY2x1
ZGUgInhlX2RldmljZV90eXBlcy5oIg0KPiBAQCAtMTUxLDEwICsxNTIsMTMgQEAgdm9pZCB4ZV9k
cm1fY2xpZW50X2FkZF9ibyhzdHJ1Y3QgeGVfZHJtX2NsaWVudA0KPiAqY2xpZW50LA0KPiAgICov
DQo+ICB2b2lkIHhlX2RybV9jbGllbnRfcmVtb3ZlX2JvKHN0cnVjdCB4ZV9ibyAqYm8pICB7DQo+
ICsJc3RydWN0IHhlX2RldmljZSAqeGUgPSB0dG1fdG9feGVfZGV2aWNlKGJvLT50dG0uYmRldik7
DQo+ICAJc3RydWN0IHhlX2RybV9jbGllbnQgKmNsaWVudCA9IGJvLT5jbGllbnQ7DQo+IA0KPiAr
CXhlX2Fzc2VydCh4ZSwgIWtyZWZfcmVhZCgmYm8tPnR0bS5iYXNlLnJlZmNvdW50KSk7DQo+ICsN
Cj4gIAlzcGluX2xvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiAtCWxpc3RfZGVsKCZiby0+Y2xp
ZW50X2xpbmspOw0KPiArCWxpc3RfZGVsX2luaXQoJmJvLT5jbGllbnRfbGluayk7DQo+ICAJc3Bp
bl91bmxvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiANCj4gIAl4ZV9kcm1fY2xpZW50X3B1dChj
bGllbnQpOw0KPiBAQCAtMjA3LDcgKzIxMSwyMCBAQCBzdGF0aWMgdm9pZCBzaG93X21lbWluZm8o
c3RydWN0IGRybV9wcmludGVyICpwLA0KPiBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGUpDQo+ICAJaWRy
X2Zvcl9lYWNoX2VudHJ5KCZmaWxlLT5vYmplY3RfaWRyLCBvYmosIGlkKSB7DQo+ICAJCXN0cnVj
dCB4ZV9ibyAqYm8gPSBnZW1fdG9feGVfYm8ob2JqKTsNCj4gDQo+IC0JCWJvX21lbWluZm8oYm8s
IHN0YXRzKTsNCj4gKwkJaWYgKGRtYV9yZXN2X3RyeWxvY2soYm8tPnR0bS5iYXNlLnJlc3YpKSB7
DQo+ICsJCQlib19tZW1pbmZvKGJvLCBzdGF0cyk7DQo+ICsJCQl4ZV9ib191bmxvY2soYm8pOw0K
PiArCQl9IGVsc2Ugew0KPiArCQkJeGVfYm9fZ2V0KGJvKTsNCj4gKwkJCXNwaW5fdW5sb2NrKCZm
aWxlLT50YWJsZV9sb2NrKTsNCj4gKw0KPiArCQkJeGVfYm9fbG9jayhibywgZmFsc2UpOw0KPiAr
CQkJYm9fbWVtaW5mbyhibywgc3RhdHMpOw0KPiArCQkJeGVfYm9fdW5sb2NrKGJvKTsNCj4gKw0K
PiArCQkJeGVfYm9fcHV0KGJvKTsNCj4gKwkJCXNwaW5fbG9jaygmZmlsZS0+dGFibGVfbG9jayk7
DQo+ICsJCX0NCj4gIAl9DQo+ICAJc3Bpbl91bmxvY2soJmZpbGUtPnRhYmxlX2xvY2spOw0KPiAN
Cj4gQEAgLTIxNyw3ICsyMzQsMjEgQEAgc3RhdGljIHZvaWQgc2hvd19tZW1pbmZvKHN0cnVjdCBk
cm1fcHJpbnRlciAqcCwNCj4gc3RydWN0IGRybV9maWxlICpmaWxlKQ0KPiAgCQlpZiAoIWtyZWZf
Z2V0X3VubGVzc196ZXJvKCZiby0+dHRtLmJhc2UucmVmY291bnQpKQ0KPiAgCQkJY29udGludWU7
DQo+IA0KDQpXaGlsZSB3ZSBoYXZlIHJlZiB0byBCTywgd2h5IHdvdWxkIGl0IG5lZWQgbG9jayBo
ZXJlLCBjYW4geW91IHBsZWFzZSBleHBsYWluIGlmIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuIEkg
dGhvdWdoIEJPIGNhbnQgYmUgZGVsZXRlZCB0aWxsIHdpbGwgaG9sZCByZWY/DQoNClRoYW5rcywN
ClRlamFzDQo+IC0JCWJvX21lbWluZm8oYm8sIHN0YXRzKTsNCj4gKwkJaWYgKGRtYV9yZXN2X3Ry
eWxvY2soYm8tPnR0bS5iYXNlLnJlc3YpKSB7DQo+ICsJCQlib19tZW1pbmZvKGJvLCBzdGF0cyk7
DQo+ICsJCQl4ZV9ib191bmxvY2soYm8pOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJc3Bpbl91bmxv
Y2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiArDQo+ICsJCQl4ZV9ib19sb2NrKGJvLCBmYWxzZSk7
DQo+ICsJCQlib19tZW1pbmZvKGJvLCBzdGF0cyk7DQo+ICsJCQl4ZV9ib191bmxvY2soYm8pOw0K
PiArDQo+ICsJCQlzcGluX2xvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiArCQkJLyogVGhlIGJv
IHJlZiB3aWxsIHByZXZlbnQgdGhpcyBibyBmcm9tIGJlaW5nIHJlbW92ZWQNCj4gZnJvbSB0aGUg
bGlzdCAqLw0KPiArCQkJeGVfYXNzZXJ0KHhlZi0+eGUsICFsaXN0X2VtcHR5KCZiby0+Y2xpZW50
X2xpbmspKTsNCj4gKwkJfQ0KPiArDQo+ICAJCXhlX2JvX3B1dF9kZWZlcnJlZChibywgJmRlZmVy
cmVkKTsNCj4gIAl9DQo+ICAJc3Bpbl91bmxvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiAtLQ0K
PiAyLjQ2LjANCg0K

