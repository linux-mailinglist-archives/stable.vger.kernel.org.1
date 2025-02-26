Return-Path: <stable+bounces-119727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0596A46805
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFE13A871D
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23341224896;
	Wed, 26 Feb 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWKMRlY9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60D21E096
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590890; cv=fail; b=QtNaA9zqfe6gj+nHGCcQVTfs/VcR1hHDy8bXJ90UHIFrlUwiYJX6g3GkzFXfhx/A3vLpK4H9UuqfUf/Dy658fQCqQWxSlsnJAqfTvmuNsD4xTksxRaRaSHtLqiatqtg1rWxK2EIV1lrVs3AbNJ6zsEU2sz/a09lGrBLG8sm9hb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590890; c=relaxed/simple;
	bh=Zjq9SoFomzQoBFbMM4BKx5gdufK2sgevRE9s/4acgRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoMZTPWfV7OwPqVZ6QPkFTQLuIlvDqQpFxycge+s0Yo46CHEPx6eVxvaJrYfGc44gG4hwPrM7TdBz5J4x3IOFofzzZbZvziMTTaGyPnX+KwpzgbgN/HMhRLN6yL1L7wrP3trD/Eo/p5t1n09z+uSkxIkSsOHh5KFMkPb4Xy0agY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWKMRlY9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740590889; x=1772126889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zjq9SoFomzQoBFbMM4BKx5gdufK2sgevRE9s/4acgRE=;
  b=UWKMRlY9hJBiy5UI0OBvtRi2hV32MDo+2qwK3nRojgOrKdEXvWbgza4l
   l4ZdgP1xXjO32iHO8jV0MyG8zJs87tAE4Htb++hSMAW5obcDWz3uLEcBj
   /g/5rqAo9EjRCvOJ8n/0/OMHqMUmmO3Xu3HJWmnGMzDloJzBSuQVUeMGY
   tLNrMvK44EkIyShg8nTNzj+2Wme2CbHUl59mVTrDk9dNJ1Yh5uua84VKB
   4nzk1aOADHEnhz0fF6oUwDBkW/uV05KLTw38V0+k8Fc4eEZVlCq+zbkwv
   2b6DWi2lY+AhYUBxZcGy+zgi9rJpma4NisnOCkXH2E+k/1ikto+Wpotcy
   A==;
X-CSE-ConnectionGUID: vO+8LE8gTgKCGDGA4dvRhg==
X-CSE-MsgGUID: rAPsqy9qT+C0kTUpN2IKTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58870163"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="58870163"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:28:09 -0800
X-CSE-ConnectionGUID: uW3VUrWST2CKMqCrrh3RLQ==
X-CSE-MsgGUID: QEMvNnNXToqmbLdEtukjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121768792"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:28:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 09:28:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 09:28:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 09:28:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+lzDtYlMbtvfbVLDVeBd8KguIyhPWRoua8jlN5L/b/Yxop5OcbsworRDGr2LyYDmnja8ZwuvdX44zyW2rsO53FB3stpV/NyVYLjJm3j7c14hvEzGXf4gs4hXvCRJg10clI9XTcOZUGA0DCFaSIc1zZDVip11zVBbdW8N/OzWmVLmypN28d5/zrtdL+0txqQ4+ibXUnF7NG97kSMZA2yQEaM4fYzzKGNz1JLKq4yrXbPrq2GaAiA1zyikA0eZMXjXtTlZKNHm53HBTVLTgJ6BMvTh4cGEGdn4u2lV/KgZIzTqxvomd4TvUjUtUo/pkbdAuh7/gXueuIGZ9nG1jkA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjq9SoFomzQoBFbMM4BKx5gdufK2sgevRE9s/4acgRE=;
 b=tWW1MwTE7TmfD8DJW6R0qCG6Oied9Vz9mIrEFin+omsiqaVaWUODHv4sW3mDIgP43A1OH4brHvur1EBJnktudhhFo9p2ZvRX2DxFieU5K/Gy6bREu+kRMdFxmvvRnqLBtKW4BSMr+EuLdUM+IIcwYaaRvq+hJgeP1GHoceb2bTWdrtAlPxzDPZ/mQDU++vvAh9h3r2ib+YZBgj2s57mLy2sHfiHN1HqL3cAhtjC85kJAC9dFA0ECVR6PlPLoj5kgHoLpRTNgkGXavU5AsHxtrIxuanLNPOdBRbAcAvu7zZdo5esIQhP3EGy4Hs3XOSOrjMKXEbPyJHN8Ve+NoBB2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) by
 CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 17:27:21 +0000
Received: from DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c]) by DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:27:21 +0000
From: "Hellstrom, Thomas" <thomas.hellstrom@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld,
 Matthew" <matthew.auld@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Topic: [PATCH] drm/xe/userptr: properly setup pfn_flags_mask
Thread-Index: AQHbiHJU9UovyVA6REa5W0f7ZIsAr7NZ1nkA
Date: Wed, 26 Feb 2025 17:27:21 +0000
Message-ID: <0e7b306641b7c0fe2d683869a0b89452144cadc7.camel@intel.com>
References: <20250226171707.280978-2-matthew.auld@intel.com>
In-Reply-To: <20250226171707.280978-2-matthew.auld@intel.com>
Accept-Language: en-SE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7733:EE_|CY5PR11MB6089:EE_
x-ms-office365-filtering-correlation-id: f4424440-b8e6-4f91-c454-08dd568ad3d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmhVVjltY2t5djlpUGJNYXhFUWpwMzkvbkVWYUVUUlQ3OTV4aU5ad3JyWXBw?=
 =?utf-8?B?RVFhb0FxQ2twd2NrUmRIb0hRa1VpNTlSQmZvQllyUnJuTExPYXUvMzdLaHk0?=
 =?utf-8?B?MjZuYzV4WkUrUHcwVENkRFNER2lTSmxyYTloMlBVemt4TXpyQ2Z0U3lNSlBR?=
 =?utf-8?B?VW4yTGdZY2RmVWxpbHoxOVFDcGZPNzY4Q2ljQko5SFprM1MyM3J2TDUvQTlY?=
 =?utf-8?B?S2h1S2x3b3hMVFo0WWxrOGw1M2ZrUWtPNml1a0ZnUmpVYlEyelVhSkVrUEhL?=
 =?utf-8?B?UllGTkg0RjB0UmJyb3RSY0ZOdHViS1dZY0Z4ZmlpWlI3Q2NxOXpwUUtPeDFx?=
 =?utf-8?B?alBxNm94WWRkTDR5ckZOSXUwY3FIMDRvTjYwSVVsRTBISkRsTnp4MkhJNHVp?=
 =?utf-8?B?bFd2aW9yVWVOcWU5WDB4dmUxMDlMTG9EZjlkWjkzNllubXNoZ3c0bXNPdTVC?=
 =?utf-8?B?Y3lJNzI1ME9Fc29MTENDTlBIZXNEdTlSYjBIaHYrMEFCNHJNOVRrS3QvVzI4?=
 =?utf-8?B?cnJOZ3JzdXV1U2NhUzB2QmpRVGF2RFVsM0FKbkNSU0pxWU5lRkxxMjU0Mm5o?=
 =?utf-8?B?V0xRLzA3NHhKak1iakJod3NKYnBIZ1NvSVFvV09VL2ZFWmM2dmZPMTdoZlhT?=
 =?utf-8?B?d1VqRXNxS0R4ZVlvWVNHS3FIYk5CQVpFQVZFZUVqVFlDa3JvZTNWSGJ5b0Fa?=
 =?utf-8?B?dm9ST2RDblkxSXhkSHNyRnF2NEVMQW56cUdLMlV4b3IrQmFiekR4U2hGUGtt?=
 =?utf-8?B?TzJ3cm1WVFMzK2tVVFpMOE4rMVVITVhYcGNVN3ozQkE1RG1WK081eWc2TUZo?=
 =?utf-8?B?ajM0U0hsSDlsV2xrYUJ6dDFvc1NSWTI2V1FNR1pZT2pQT010TDV1M0xCSUlC?=
 =?utf-8?B?QzN3L29aUkZXTlo4TE4rS3kzeTk0RjFuaTJNdjNnVlpvbi9JSktldjNVZnA4?=
 =?utf-8?B?SGFzYktiRHJrSUlpQko2SkpwUWFZL0JpNlVOUGtZMXdvZG1ZeHkwVnEzTjJ0?=
 =?utf-8?B?TUVqZ0x3NzBjbmVjS0tvRjEvOGx4TERVRXgxc0ZGYnVsRkpjSmRVdnhwTUZ4?=
 =?utf-8?B?VitOTTVPbE1naGxRdEhUVVkwemR2ZW1OdzdqMmZ1dHJsZ0pNSm1tZTh5Nzda?=
 =?utf-8?B?SE14bllIN0NwQ1RCT1ZyT3N0Zzl0cnk1UXBqcmJ5bGpWcHJLVVE3UHlqdU5m?=
 =?utf-8?B?TjJHZWF0aW0rWUY5WGYwbExpYnkrNncrTk1pZmtidTFPV3FTS0VkWitmR0xj?=
 =?utf-8?B?b29PZmNwc0lEdjZ6QUJXMUpIaElydzBHaU1ZUUtvajFJbXBZeDNMN045UWlJ?=
 =?utf-8?B?M2tRR2kycGtoSmhQalkwL3hteFVPUC85V3FvNkJRWmJWTExmc0ZFMEVVcjg4?=
 =?utf-8?B?STVraVkrWUdVai9jQ3NxdDU5RUJSK3RsUDJaQzdGakI2WVl4RlZuYWpQNzQ4?=
 =?utf-8?B?S3JLZVJtaGx6RW9jeng1SEdJdUdBL1BQQ3htY1VhdnhhbHlUWVJmRzJyZWNX?=
 =?utf-8?B?T3BmdnJ5eUZNUUZZVU9CVmlLaEE4SDAwdzF0bzc0QVhNa0lWVTNwOWZPcWw5?=
 =?utf-8?B?QVpKWS9DejRWL3RDWWRmNzE2VVF4RHNMbS9NOEhlb3JrQmE2MExOclhZdE5Z?=
 =?utf-8?B?bVQvdC9VMVVMc3g0Y05yVUZ2NGk2OUFBa0d5dk5NaDNVYUxNVVcwQzgzKzlk?=
 =?utf-8?B?b3hqTUFKUk80N0NqekRGKzduT05HeVdvd0toTld1TUwzWmFrbzh0NGVWNzVv?=
 =?utf-8?B?Z211ZjdtTCtJUk11UGphb1lwTHZFclFjVWw0MXlBdFZ4MDZnTHFQalNaUWRp?=
 =?utf-8?B?ZktyeEorcW04QzM2cnQvVWY1bjZxTjVSb1d6QWthRWV0RDM2R0RxNUdGMGJw?=
 =?utf-8?B?bmlBaVhWbDRMM0tBTEJ3OGVwVmpSM3ZEdDFCK3cyUlN6d2lqcEQrODJITTlP?=
 =?utf-8?Q?dypzC6sltLkzSrTJznLEAaEO5gtHn7WX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anM3OTZ0YnNZSVkvT050ZkZkbHd2djhIZm9DSnJrbEtXSzBrckwvR1p4OUp6?=
 =?utf-8?B?M0ZhQXRvYzhyMDJMbXc4QkR0MVVqRkIwS3NOZTY5TlMxWlJFcldBMFVvSHNV?=
 =?utf-8?B?aUNnM3ZLUFRQRFlIWFBiVE5vWHQ5bU9MK1dJam9aMGx5ajlMdVJJUkxXcFlr?=
 =?utf-8?B?TDFDOWQxRkc0R0tXUkMzRWZJMUhreGtDOFVnR3pHclprRnRJVUxFM0lkcGFT?=
 =?utf-8?B?TXBCT1BPb1ZVL1Bzb3Jrc1phVHVjb2xTUVl0MktoSlVuak1OMjI0YzhlN0Mv?=
 =?utf-8?B?WEpvM1ZCRDN0ZjBKYzNBUkZQK1MzOWJMcGtTZXM1NDk0cmZmUkordkl0ZHJi?=
 =?utf-8?B?amZoK2FuZlVWWk04R1FHbFpxaVZySkl5cllLZFJqdG5MMVp3SkxpL1A1K0d1?=
 =?utf-8?B?cTdyeWdUT3JKOWdhSFAzK2pFWDVlMXRHMG1YMUh3bnJFVGp2Q0lXV3hkZlNJ?=
 =?utf-8?B?RHZHd2l2anhEaUxTcnhIeDRKSFp2U3ROd3crYlpwVVJ2M3hjMnpQTWd2VmdV?=
 =?utf-8?B?L1d1UUN1UWdpdXBDc21VNUkvVExsYm96VkRlM1VYK1RobktWVFc3T0tHUmFm?=
 =?utf-8?B?NDFGQzB0eEJLcjkwanVYR0ZPeGhQSGhIWFNoM1FTUzdxMUpCektYakg5QjRa?=
 =?utf-8?B?ckpVdFdJYlNXNmszcGNYQi9hTzRCakQvcUIrOFR1N0dQSVBsRUZMS1BqdHBr?=
 =?utf-8?B?Ung4UEl1NlRseW03aUFnSFMzc0M3ZVZoUnhkL0lMR0ZRS2ZKK3NEMS93R1Bv?=
 =?utf-8?B?WTZWUm1oM2JqK2xtYldpSERDVER2Uzg0TVVBeDBQakdQdHR0WitRenF3NXpv?=
 =?utf-8?B?MEtPYTNDWnFOckZKbmVsWDBvKytpbUVrSnF2WHV0UW55OVpWMU5Da0o0WjZK?=
 =?utf-8?B?VTY1SzlWeVBIaVNwUXRDNFRLYXl4MGZFZjh6UUd2WG1Kd1JZVFprQTFOQ3pN?=
 =?utf-8?B?Q1Q0ZkZLOUxsd2pwY0UyelBnYVFwcWRjbEZ0K3d5dWp6QXVYeUdOaVZrT1JD?=
 =?utf-8?B?ZFoycTU0WUdDNTJnU0dURGpoNTRibXhScks4THdGblArQWdMR2lRTEFKWm5K?=
 =?utf-8?B?VTlQdGl4SHV3T0pOaUxMZ3VLNVk2NmNuSXRzMENZSHdNbFhaVkgzWVNCMk1j?=
 =?utf-8?B?TkZ1bE5Md0hkck03UXZmMDRLOEJBODhSSmZNZmNRd3VmNVkyMTNYU2VlUTlV?=
 =?utf-8?B?OWlQbEF3UWxBRDgvSjlHQ1dGK2wvM1A5eWhiRXBZeGdhbitmVHQzTEJrNndV?=
 =?utf-8?B?S3dQMTAvaWExQ1gyOFFqR0tEaGVYTzM0Mm5UV3U4TTM0SDQ5Zms2elY3bDJ3?=
 =?utf-8?B?NHF0NGpxWE5jK1N4VVNiR2xUeE5oR0tZODAyOGN3cHJDVlZhYVMrcnFsWmZa?=
 =?utf-8?B?c3F6dXdtamUyWnFvdE9MZmtvbVppSnhxNlRIb0k5Qkt5a3QxYXRnZFBXQ1lq?=
 =?utf-8?B?WU8vU2oxZkJiQWR6MWlpbkF6Q05ZS09zSmV5VFk1clZHZXFvTm90MitLemd3?=
 =?utf-8?B?SkRRM21qTkljYXYwR3NQc2JJSWhuU3Y4WnhObzlxSjVMaFEzdFZHSG5sY1g0?=
 =?utf-8?B?Sit1RTY1TXJTMTB1azV1dWx3YTRFVStLaGprV1dHeGpaSUw1ZnBlU0xlMzMz?=
 =?utf-8?B?Y2dSY1lQZXA5LzRha1hKMi9IckFtdFpTRnQ5d1RGV3hJRXBacXdWcFM4dFRC?=
 =?utf-8?B?Yjk2RVpMbE0xbjJDTmN0Q0JRZ01vQkVtOHEweUVqOWhWVEZiZXZVZExzdnVL?=
 =?utf-8?B?TlBXZ2xiVVhiZWFzUU4zemExeVI4ejdUY2Q0VWl6dTJjYUl1aXREekx4VXJN?=
 =?utf-8?B?YUF6dTVFMnk2RFUzbXdzSWZZZjFrOHM2YXcvUmt6RVFJaEYyMVFrOW00bWNw?=
 =?utf-8?B?UzQvY2ZrTk43bGRzRW5sVDBqTEozOUp5ZVVFZTFTSm41MGtyOFJ6ais1T3RG?=
 =?utf-8?B?WVVsNW5sUTY2bnEwOTAvaXpLTjA4T1YzL3o1WnJjbnBsWXNCdDlmNGovaTI3?=
 =?utf-8?B?MGVTc2MwVmQzUE5ncmY3dXRWNWRNSzFYaDBTTEFHM2dNSVhwUzBiNHVETkNz?=
 =?utf-8?B?MkljdTVxblMzZTBQMFY3QkkwMDVNS1dHNEV0bFlWQ2NHSzY0V1FhZlE3TWNu?=
 =?utf-8?B?eGYrTDVDZGMwWDdpRDM4b0RYN0dBeG0zaEhoZFN2UnJvNVUwbCtadWc4dmZx?=
 =?utf-8?Q?zOoku/GcGbNs91nWuPuUakfAnEMqoptq3Y7ouhsfOIAs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43414D306978674DA33E5EEDCE53CE1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4424440-b8e6-4f91-c454-08dd568ad3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:27:21.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmA6jFMV/hnS35VQEVgvu1EspSgTXbkByJM4efLK5gchZxXFU0if8bmUmhHkubII/jB/szw2T22+YpAteGOJKmauv8X/Izgy5e+1huPzU9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6089
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDE3OjE3ICswMDAwLCBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+
IEN1cnJlbnRseSB3ZSBqdXN0IGxlYXZlIGl0IHVuaW5pdGlhbGlzZWQsIHdoaWNoIGF0IGZpcnN0
IGxvb2tzDQo+IGhhcm1sZXNzLA0KPiBob3dldmVyIHdlIGFsc28gZG9uJ3QgemVybyBvdXQgdGhl
IHBmbiBhcnJheSwgYW5kIHdpdGggcGZuX2ZsYWdzX21hc2sNCj4gdGhlIGlkZWEgaXMgdG8gYmUg
YWJsZSBzZXQgaW5kaXZpZHVhbCBmbGFncyBmb3IgYSBnaXZlbiByYW5nZSBvZiBwZm4NCj4gb3IN
Cj4gY29tcGxldGVseSBpZ25vcmUgdGhlbSwgb3V0c2lkZSBvZiBkZWZhdWx0X2ZsYWdzLiBTbyBo
ZXJlIHdlIGVuZCB1cA0KPiB3aXRoDQo+IHBmbltpXSAmIHBmbl9mbGFnc19tYXNrLCBhbmQgaWYg
Ym90aCBhcmUgdW5pbml0aWFsaXNlZCB3ZSBtaWdodCBnZXQNCj4gYmFjaw0KPiBhbiB1bmV4cGVj
dGVkIGZsYWdzIHZhbHVlLCBsaWtlIGFza2luZyBmb3IgcmVhZCBvbmx5IHdpdGgNCj4gZGVmYXVs
dF9mbGFncywNCj4gYnV0IGdldHRpbmcgYmFjayB3cml0ZSBvbiB0b3AsIGxlYWRpbmcgdG8gcG90
ZW50aWFsbHkgYm9ndXMNCj4gYmVoYXZpb3VyLg0KPiANCj4gVG8gZml4IHRoaXMgZW5zdXJlIHdl
IHplcm8gdGhlIHBmbl9mbGFnc19tYXNrLCBzdWNoIHRoYXQgaG1tIG9ubHkNCj4gY29uc2lkZXJz
IHRoZSBkZWZhdWx0X2ZsYWdzIGFuZCBub3QgYWxzbyB0aGUgaW5pdGlhbCBwZm5baV0gdmFsdWUu
DQo+IA0KPiBGaXhlczogODFlMDU4YTNlN2ZkICgiZHJtL3hlOiBJbnRyb2R1Y2UgaGVscGVyIHRv
IHBvcHVsYXRlIHVzZXJwdHIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRo
ZXcuYXVsZEBpbnRlbC5jb20+DQo+IENjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGlu
dGVsLmNvbT4NCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGludGVs
LmNvbT4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjEwKw0KPiAtLS0NCj4g
wqBkcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVf
aG1tLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMNCj4gaW5kZXggMDg5ODM0NDY3
ODgwLi44YzNjZDY1ZmE0YjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9o
bW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMNCj4gQEAgLTIwNiw2ICsy
MDYsNyBAQCBpbnQgeGVfaG1tX3VzZXJwdHJfcG9wdWxhdGVfcmFuZ2Uoc3RydWN0DQo+IHhlX3Vz
ZXJwdHJfdm1hICp1dm1hLA0KPiDCoAkJZ290byBmcmVlX3BmbnM7DQo+IMKgCX0NCj4gwqANCj4g
KwlobW1fcmFuZ2UucGZuX2ZsYWdzX21hc2sgPSAwOw0KPiDCoAlobW1fcmFuZ2UuZGVmYXVsdF9m
bGFncyA9IGZsYWdzOw0KPiDCoAlobW1fcmFuZ2UuaG1tX3BmbnMgPSBwZm5zOw0KPiDCoAlobW1f
cmFuZ2Uubm90aWZpZXIgPSAmdXNlcnB0ci0+bm90aWZpZXI7DQoNCklzIHRoZXJlIGEgY2hhbmNl
IHdlIGNhbiBtb2RpZnkgdGhlIGZ1bmN0aW9uIHRvIGhhdmUgYW4gaW5pdGlhbGl6ZXIgZm9yDQpo
bW1fcmFuZ2UNCg0Kc3RydWN0IGhtbV9yYW5nZSBobW1fcmFuZ2UgPSB7Li4uDQoNClRoYXQnZCBh
bHNvIG1ha2UgYWRkaW5nIGZpZWxkcyB0byBzdHJ1Y3QgaG1tX3JhbmdlIGxlc3MgZnJhZ2lsZS4N
Cg0KRWl0aGVyIHdheSwNClJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhl
bGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQoNCg0KDQo=

