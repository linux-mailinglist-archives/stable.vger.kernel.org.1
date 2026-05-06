Return-Path: <stable+bounces-244437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHPJFvKC+2mEbwMAu9opvQ
	(envelope-from <stable+bounces-244437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:05:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E504DF229
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A203009523
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC93148BD58;
	Wed,  6 May 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLMuX/cx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3830ACF6;
	Wed,  6 May 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090733; cv=fail; b=FEOIGw/cvI6Tyh4HZfuStL1lWnyjjmfWAcfWnlTwmfinwGQs+WAR10IXkR/uNV9Xdp1WajhvrxiBq+OI7QrBfG9yRaRPgKqz7XPusPRLMDkNoVXcHy9W2xTZ2y0o78afYUiF9VuzYQnqTbj6hjjYHtS1uuSUrmlmYiiWhaR7ijk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090733; c=relaxed/simple;
	bh=8I25gPBxEh7xcYQ1y9mXqzoQ+M7T54SF/lf/mmPTJDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RaSq+RTCYDF5Gab86LXfaLtye4cX8tgZ9Q0+UCEUB/VSK3sGWlv6/mzvSwNB4iLDtEHGx32zQHPmkROe4citEv2HkqIiTjWgxlrBIKVuBdF6cs4S2erjQqLJarZtckKfd8D4Z7I7xfBLPTzejOgo489qNg7mHkDOo9Wdtbbh4u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLMuX/cx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778090728; x=1809626728;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8I25gPBxEh7xcYQ1y9mXqzoQ+M7T54SF/lf/mmPTJDQ=;
  b=RLMuX/cxcRuUyiRHS5Yj+vdBnSVookhvc3wmfESGx7NSh6qBnT5n03D8
   iQaE4oxpNg3zXermJD01kLSYHQHZl2SYS4qHDC9HyAI0OhmrpZ13amoVe
   ZLnIOWjS1BNuFNpZOigtL5SmRCMkB5T7sjU0GWuCHSziwpMjM4BcMf7oW
   MrJjc45S2uLdrzIlb3sC7G0ojFMwXzkh+hjgWPryrmojqiDQkZXLTpV0Z
   WOgmJRux3Wv6WSNTC5HKL3EVIShp12zemftYd5T6Rz5jFy05f6Kcza8ae
   ujmpp+OFe8MA8W+0VTXZEBKuz2pkY4+m9mfsCpDcBEVLMjDhhfXU6fFqf
   w==;
X-CSE-ConnectionGUID: PzFaypiZRuuvpzfQhN8mqg==
X-CSE-MsgGUID: BLR88nVrS9+/O/p5pLZ28w==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89619368"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89619368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:05:26 -0700
X-CSE-ConnectionGUID: sSNMdAAKQBum5oRaXFhe4Q==
X-CSE-MsgGUID: zM/VEvHuTgmO3wJoKz9I6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="235206621"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:05:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:05:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:05:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb7ExXJ97yipi6xMA/KcOzMz/AqlCLC2zsdIVNJeIy3nPSH3KsOMjvZelq2K+PiUNLxr/1dfFt28zv0YtdIEN7E/fL1CXZgvUJz1nhEOBtLEnaR1kFGP/eV/r/Pfb3iqP203vX8kpZ9UrkdSGv/hhLIaVIjNAdLOqESYEdjvY5oA52KOs3n9muScfC9KG8wpi998N7+Otm+/P4HK4w4xiJpm5F8S/0LN5i8Bj3GQFuFm+Vemj79u3NeK0w6OEp6rSDI5zCDKZS8+kK0lYNdP15cgXJUAze7NTEqWzhTzK6tIacO4zQ0P2Iklyu64G4vflQD7lKDbOKWEcetWG25neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqjpMiWiL7yUfz+LVKQejnx3tlq/kuM76jhFi+R0QyQ=;
 b=LOg2vlhby2gxWm4h46FYp88ikSo4rN5ISYdfenG6wtxoc0pnb4l7AhWkCfkxNjfMXf5woHyd7Qe4QQYc+gjaYjPDbIwd6wMGmSq4ZoJb3eTVztMArHwbcAPNZPEKjWw3+//BN3DuqpBGoXW8qKNsChHLG9ma73FrEEH0U2j9lfSP1BZwPCggQ8nf0a4Ga9Syyja3GIksgDPm2q7nrt9tsNz++PCo9BlN03neR12F/WB3HVWpNgGpZ8L+sQFBo2Z6xCnmZPA3u1G0bEz/9cSW9kl4AlsKoQV8PLOaUp1Ve7oRCZKn/yqKBbnTxXLb9FOfrSSd7zKZmAU+jx7TVy13Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 18:05:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 18:05:22 +0000
Date: Wed, 6 May 2026 11:05:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] drm/ttm/pool: back up at native page order
Message-ID: <afuC3/k5Ly2nzaib@gsse-cloud1.jf.intel.com>
References: <20260505200443.3300962-1-matthew.brost@intel.com>
 <20260505200443.3300962-3-matthew.brost@intel.com>
 <47256c5547c75296af32ca87161188588cacf727.camel@linux.intel.com>
 <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
 <906de072af1f6744aed1eb914ff196f0f5e00016.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906de072af1f6744aed1eb914ff196f0f5e00016.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 509bf3d8-9344-4840-e0f2-08deab9a0a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info: 4X7AWHq8npuZCMtUDku0c7R9TuRPz9nUjRDxse4bR+vWA6P5+Ey8iF2kK8IAzY/0VvoMy/KZ2dQUM2pYfVROhrvBTurg/AdO93PKZgYnd6SO9asSJsczst7N7tBl2r8ddRmYxqCoJrPf/oyfS5/JPBnrppjlMY9sbsN455QVHsSgYXBQ8n6Gjf5St1U61quCXunr4FBmZA7LgO883bNuPaKY+Qj4p3gDaErDz/+l939ETRz8Jw0r8FulCqxhWFuudh4wavOeJLnVBK5gg0E+1v6mxYgll2ZdJy3kcjZyuYVrAR8hde/LxUDsXFLJDti+h/9dOOWsr0+v5WYOyJ4+afHJY1xPXCOsAl438n6dv7Ko/g0EaXSNEG5/yQMUoE6p8fVS+ZGpt0OKkORAfwgss4QGoYBNz8sfq+57Uwb6WPCQY/hVDLoOaKAA4BFWAN1A4lspTyN+5GS8BWnZU7Tf125hZGcWebmSNUeBX3+9T95NIphqyw/geKFB3KnjK80wnJP+huQglOif3HsJz6uorE7C3U+XvznFtzyEuOtuTM8wWZH2EL5aqjl3ML3BAflmZHhx5zwDbMiEUyQuo0Wp0Ttymksv9P4S+1zLIj4CWm2l44i2ONof7Dhv0fgsIdAb9HKLM7vGEJiINy6DkN9/XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RGQ2JJL2t0VXZ1VzRNZHF0K0FnTnhMbmU3STVjMmw3eHVxVEhmSFFqZVha?=
 =?utf-8?B?QUc4Zm92NFhiNVA1UXFYRjE3T3luWUJ0bDZxWHVkNzVudHdGTjJheFhtemVw?=
 =?utf-8?B?MVcvaGhJUkYxRmpFSjdPQk1ud2h4elZ1dnppS280VUFhNjlzdStyaHZZTVFx?=
 =?utf-8?B?ZmhUb1lySTVOakV5WXJyUnd4WGNaM2d0ZzdiV1UwTzAyVGRKWHh1L0ppanl4?=
 =?utf-8?B?ZTdHSzlONmZmcHRCZWFUemd6RUF2RElZWnZGb1QrZlB1dHRUcC9nU252VVdM?=
 =?utf-8?B?Z2tpblBoYkRsWVFOZTBROEVEbjcrc0dSay84a2wvV3BMZDBFSHQzR1lWTDJC?=
 =?utf-8?B?Ulo5bTJsNElnenMyMWhZd0Fpa2FCT1RGM0lmdEFLVkN0S0EyV0ZYUzFMSFdX?=
 =?utf-8?B?blp4WlVvOVovNXpsYVVacnpjcWZNMHpaUUhWd29KSW8rOG12aWMzNE81Y1N3?=
 =?utf-8?B?Z3kxQS9ZZlNZd0tYaTFiczBnNE1iRDVoRkJlR2JKMW9sdzJsUUl5WDM4Y20w?=
 =?utf-8?B?aEliWjBqZG96ZTRRMklBWlpNTjZMd1ZkVVUzdzB2ZjYxK0pJSUZMNU41dTZC?=
 =?utf-8?B?blc1QjRXVWUwblc5aHVtcTc3SnljQ2t1Zy96cm9IN01EbVlQL1ptRm00Wmd5?=
 =?utf-8?B?dW9Id0VZT2FyVVVyakRnYTJ5ZFo2NGZUM0dmb2x6bVpWbUhkMEZvVndOWmFL?=
 =?utf-8?B?UVovSWdxNW85MXdyTnJWUCtCNGhSeXRLM3Mvcit1bGEyc05MdW9mUDhYMEhW?=
 =?utf-8?B?cXVJTE1WemZDOExoRHRlS1dYK1MrcEhVbHhicUNKQTYzMkVzZ0ZXVnZoaTNw?=
 =?utf-8?B?SFV5R0Fmbm96VzRzU2U4a25PTTVqTUFnWGtsc2hIY2FVWlUxeUtJOFUwdkpm?=
 =?utf-8?B?Yk9iWVZ1VXNFeWMxMlB6YzY2ODk4RDh3Tm1XbGFkZXhOL01WMzlGcUZCakhW?=
 =?utf-8?B?a2VSVGRKUmhUS284WTB3Y3ZZZmJiSmE0dUNla3ZCQ2xQaUtsUTd0cDQ1NkFZ?=
 =?utf-8?B?ck9vM2RrbFkwSDJQZzhySzhIcFc0SURuNVFDSlVOc2ZNZXFJQW9mcjZtbGFL?=
 =?utf-8?B?VWFSeWFQbldDVUx2aWRLRzdudThhZFA0ajdpTWpmUjZkdWswWGRMc3hCVXcr?=
 =?utf-8?B?RW5yZHh1Lyt6UnJYNDNtMW55YUtmSFdaOFAzdnc3WkZ2SzFKUzJpc0dlVE4r?=
 =?utf-8?B?ckgxQ3VBNmFLcS9LeDRKTzV1RHVtcVBZMkF3QXRLTytmUkZaditzVlhUQng4?=
 =?utf-8?B?QXM3aEVsWHhrZjZwQ1pQSGFCT2VHcjJRbDBma2I2VUJGSHcrOXVhR3ZzTm5p?=
 =?utf-8?B?Q3g5UjFUdytXMEVSSHFibVZ2emNkK0QyODkwaE0zcGpLU003NElCYmt0RUR2?=
 =?utf-8?B?djU2YVZSUTZ1VFZ6TDU2NW9oSFpxSDlBQjBlMm5ZR1ZKYXpSdmZoYTNpY0k1?=
 =?utf-8?B?eURMck5WWTU5TER1eEI0cmdMN21aT054cEY5dlprbTVjTWlmaURnQy9SMUYz?=
 =?utf-8?B?OW1TS3VVVS9ERWkrWHZ3VG0xREpHRm9EZzMwUW10czRYZ0NkUGhIdkxxdXVC?=
 =?utf-8?B?U1gvTDJNcDJqelZjai9pVjR4OG82MEEyVjcveU9Fek1QTzhud3loZ09sLzJl?=
 =?utf-8?B?ZkE2OUVxZFRZS0VXR1VIZnlIdzkrWlAyWFZIS1pVY3JBa3hEN1BlY2k5MlBL?=
 =?utf-8?B?SitMNThhZFdxSUZVc0RneVZHY3MrK0VpTUJ4SjBDYWRtZWtXSlh2WnBPMWV5?=
 =?utf-8?B?bGVKclZUWnhORlBCMkUvTU9vRXFwMjdLOHhhT1RpS3dqZVRjNDdsRGdmUTRm?=
 =?utf-8?B?NGwreCtzMDFKMldRTG5zcUhtaXIxTmMyY3ZLSjNzVjZ3QkZxWm9rdnlKbEpW?=
 =?utf-8?B?Nm8zVHQySmZwdlZpVWxvc2t1OTNjYWE2YVRFempqcmlLa1JFdjlRRzdpRWF1?=
 =?utf-8?B?TkVnNEtWblRvbnFBREsrV1ZTVWdVQnFuOUZJdzZBYWZJNG1zbmtwZjhNU0xU?=
 =?utf-8?B?QXZxbkZUblYzY3V2N28wNE9pOXBEdFJFZnhKRHdXSmhrZnd3OElHYWdjcngw?=
 =?utf-8?B?MDNSdUpWYlJueTNORksxNUdjYk00SHp4dmxMUnM5QWJSd2VKQldxVWdQcXZW?=
 =?utf-8?B?a0dXRklRUFBCa2NVQUo2YUkvaG9oZ3FpUDJpTXB6VnEvVXg1K1F5SDExZFVx?=
 =?utf-8?B?UHpiSzhjSkVQaGhDZU9MQlBaNDZSR2JGc1piNVE0eVMwdnprUloxNUlEVEtT?=
 =?utf-8?B?YVFvTlNtMVYva3doWWNQb2I5UTFSQVNReWp3V05VeU9WcHVZUE1KM2NZanJp?=
 =?utf-8?B?OVhRNmRLMklyVjQzRktzTzliUWxHTFJaKzlOb3lHQ09WdXBUVWx4SEhMeGF5?=
 =?utf-8?Q?SoWaS1jfeO8jEliU=3D?=
X-Exchange-RoutingPolicyChecked: cmmX7Qfv/YmwqZv0Kal6h5iAkCsasdNEwcuRMro69NwXuJUmROzpdpPjEWxN5bbB4b2m8dzTaV6gpCTjE3zGHDSL3a0xK3XXlsL0M5qI5Zqns3dhocKMisLNST7RwmvS+K4Eb1fB96aOut9YEsLPedw6BgOUxXs8WXnR8X7GVypCgUHdfPC+bqsnQj7BvmRJdTYZmVznVU/gY7JmCEMWVSIsALQIHGh55hP2oK7Vbpeffm3IAf+2HKlq7+WgbmotEBA78Qk37+AUTvkx/9brK3Ab4mj3JPU2NguVyFG//t7YtSXAOgf3NWdv5KWGqWGIdr62brUMIoLpFEvh2lnOnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 509bf3d8-9344-4840-e0f2-08deab9a0a8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 18:05:22.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K11CmNFS9ydNvGniBMmZQS8w+s/lf8O+5f8jGYGXj2gJ1BTwgbuP9d8DM3FVjw5VkkYvX4tG3Pv+fzmVXZtfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A6E504DF229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244437-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Wed, May 06, 2026 at 06:26:43PM +0200, Thomas Hellström wrote:
> On Wed, 2026-05-06 at 09:14 -0700, Matthew Brost wrote:
> > On Wed, May 06, 2026 at 04:23:29PM +0200, Thomas Hellström wrote:
> > > Hi, Matt
> > > 
> > > On Tue, 2026-05-05 at 13:04 -0700, Matthew Brost wrote:
> > > > ttm_pool_split_for_swap() splits high-order pool pages into
> > > > order-0
> > > > pages during backup so each 4K page can be released to the system
> > > > as
> > > > soon as it has been written to shmem. While this minimizes the
> > > > allocator's working set during reclaim, it actively fragments
> > > > memory:
> > > > every TTM-backed compound page that the shrinker touches is
> > > > shattered
> > > > into order-0 pages, even when the rest of the system would prefer
> > > > that
> > > > the high-order block stay intact. Under sustained kswapd pressure
> > > > this
> > > > is enough to drive other parts of MM into recovery loops from
> > > > which
> > > > they cannot easily escape, because the memory TTM just freed is
> > > > no
> > > > longer contiguous.
> > > > 
> > > > Stop unconditionally splitting on the backup path and back up
> > > > each
> > > > compound at its native order in ttm_pool_backup():
> > > > 
> > > >   - For each non-handle slot, read the order from the head page
> > > > and
> > > >     back up all 1<<order subpages to consecutive shmem indices,
> > > >     writing the resulting handles into tt->pages[] as we go.
> > > >   - On success, the compound is freed once at its native order.
> > > > No
> > > >     split_page(), no per-4K refcount juggling, no fragmentation
> > > >     introduced from this path.
> > > >   - Slots that already hold a backup handle from a previous
> > > > partial
> > > >     attempt are skipped. A compound that would extend past a
> > > >     fault-injection-truncated num_pages is skipped rather than
> > > > split.
> > > > 
> > > > A per-subpage backup failure cannot be made fully atomic: backing
> > > > up
> > > > a
> > > > subpage allocates a shmem folio before the source page can be
> > > > released,
> > > > so under true OOM any subpage in a compound (not just the first)
> > > > may
> > > > fail to be backed up with the rest of the source compound still
> > > > live
> > > > and contiguous. To make forward progress in that case, fall back
> > > > to
> > > > splitting the source compound and backing up its remaining
> > > > subpages
> > > > individually:
> > > > 
> > > >   - On the first per-subpage failure for a compound (and only if
> > > >     order > 0), call ttm_pool_split_for_swap() to split the
> > > > source
> > > >     compound, release the subpages whose contents already live in
> > > >     shmem (their handles in tt->pages stay valid), and retry the
> > > >     failing subpage at order 0.
> > > >   - Subsequent successful subpage backups in the now-split
> > > > compound
> > > >     free their source page individually as soon as the handle is
> > > >     written.
> > > >   - A second failure after splitting terminates the loop with
> > > > partial
> > > >     progress; the remaining order-0 subpages stay in tt->pages as
> > > >     plain page pointers and are cleaned up by the normal
> > > >     ttm_pool_drop_backed_up() / ttm_pool_free_range() paths.
> > > > 
> > > > This restores the original split-on-OOM fallback behavior while
> > > > keeping the common, non-OOM case fragmentation-free. It also
> > > > preserves the "partial backup is allowed" contract: shrunken is
> > > > incremented per backed-up subpage so the caller still sees
> > > > forward
> > > > progress when a compound only partially succeeds.
> > > > 
> > > > The restore-side leftover-page branch in
> > > > ttm_pool_restore_commit() is
> > > > left as-is for now: that path can still split a previously-
> > > > retained
> > > > compound, but in practice it is unreachable under realistic
> > > > workloads
> > > > (per profiling we have not been able to trigger it), so it is not
> > > > worth complicating the restore state machine to avoid the split
> > > > there.
> > > > If it ever becomes a problem in practice it can be addressed
> > > > independently.
> > > > 
> > > > ttm_pool_split_for_swap() itself is retained both for the OOM
> > > > fallback above and for the restore path's remaining caller. The
> > > > DMA-mapped pre-backup unmap loop, the purge path,
> > > > ttm_pool_free_*,
> > > > and ttm_pool_unmap_and_free() already operate at native order and
> > > > are unchanged.
> > > > 
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper
> > > > to
> > > > shrink pages")
> > > > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: Claude:claude-opus-4.6
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > 
> > > > ---
> > > > 
> > > > A follow-up should attempt writeback to shmem at folio order as
> > > > well,
> > > > but the API for doing so is unclear and may be incomplete.
> > > > 
> > > > This patch is related to the pending series [1] and significantly
> > > > reduces the likelihood of Xe entering a kswapd loop under
> > > > fragmentation.
> > > > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > > > exercised; however, with this change the backup path no longer
> > > > worsens
> > > > fragmentation, which previously amplified reclaim pressure and
> > > > reinforced the kswapd loop.
> > > > 
> > > > Nonetheless, the pathological case that [1] aims to address still
> > > > exists
> > > > and requires a proper solution. Even with this patch, a kswapd
> > > > loop
> > > > due
> > > > to severe fragmentation can still be triggered, although it is
> > > > now
> > > > substantially harder to reproduce.
> > > > 
> > > > v2:
> > > >  - Split pages and free immediately if backup fails are higher
> > > > order
> > > >    (Thomas)
> > > > v3:
> > > >  - Skip handles in purge path (sashiko)
> > > > v5:
> > > >  - Refactor into ttm_pool_backup_folio (Thomas)
> > > > 
> > > > [1] https://patchwork.freedesktop.org/series/165330/
> > > > ---
> > > >  drivers/gpu/drm/ttm/ttm_pool.c | 110
> > > > ++++++++++++++++++++++++++++---
> > > > --
> > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index d380a3c7fe40..78efc8524133 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -1019,6 +1019,70 @@ void ttm_pool_drop_backed_up(struct ttm_tt
> > > > *tt)
> > > >  	ttm_pool_free_range(NULL, tt, ttm_cached, start_page,
> > > > tt-
> > > > > num_pages);
> > > >  }
> > > >  
> > > > +static int ttm_pool_backup_folio(struct ttm_pool *pool, struct
> > > > ttm_tt *tt,
> > > > +				 struct file *backup, struct
> > > > folio
> > > > *folio,
> > > > +				 unsigned int order, bool
> > > > writeback,
> > > > +				 pgoff_t idx, gfp_t page_gfp,
> > > > gfp_t
> > > > alloc_gfp)
> > > 
> > > I don't really understand why we can't end up with a
> > > ttm_backup_backup_folio(), which I believe is the proper layering,
> > > already at this point? Please see a suggestion at 
> > > 
> > > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/ttm_swapout?ref_type=heads
> > > 
> > > Here the splitting logic is kept in the ttm_pool, but ttm_backup
> > > supports handing large folios to it.
> > > 
> > > Although the cumulative diffstat becomes larger, the end code
> > > becomes
> > > smaller and IMO easier to read, and we don't need to introduce code
> > > that we immediately have to refactor.
> > 
> > That version looks fine too. If that is preference no issue.
> 
> Cool. Note that there is a bug in that we don't pass the folio order
> into ttm_backup_backup_folio(). I'm force-pushing a fix for that.
> 
> 
> > 
> > My goal with this series is get something than can reasonably be
> > backported to LTS kernels so the desktop doesn't frequently enter
> > kswapd
> > because of fragmentation. We now have at least 3 reports of this
> > being
> > an issue.
> > 
> > This is larger fix [1] which works in tandem but seemly unlikely to
> > backportable given it add new concepts to the core MM [1].
> > 
> > [1] https://patchwork.freedesktop.org/series/165329/
> > 
> > > 
> > > But I'm starting to question the general approach: Even if the
> > > *shrinker* can recover from a total kernel memory reserve
> > > depletion, it
> > > can't really be considered a reasonable practice, since if we
> > > frequently deplete the reserves, *other* important allocations in
> > > the
> > > system like GFP_ATOMIC, PF_MEMALLOC may spuriously start to fail
> > > and
> > > people will have a hard time finding out why.
> > > 
> > 
> > Wouldn’t GFP_ATOMIC enter direct reclaim, hit our shrinker, and
> > eventually make progress—i.e., take the split path if needed? I’m not
> > 100% sure, but my initial reaction is that this concern may not be
> > valid; however, MM is hard to reason about.
> 
> No, GFP_ATOMIC just uses what's available without any reclaim at all.
> It's more aggressive than GFP_NOWAIT in that it allows dipping into the
> kernel reserves.
> 

Right - wrote this before I had my coffee.

> > 
> > Again, FWIW, I’ve tried a lot of things to trigger OOM—for example,
> > running WebGL tabs and then kicking off various very memory-intensive
> > workloads from the CLI—and I still haven’t hit OOM or seen memory
> > allocation failures or warnings.
> > 
> > > So I actually don't think we can be avoiding the splitting without
> > > direct insertion. FWIW, up until recently when shmem started
> > > supporting
> > 
> > I agree direct insertion is better solution. Do you think this
> > something
> > we could reasonably get working and backport? I haven't done any
> > research on direct insertion yet, thus why I'm asking.
> 
> Yes I think so. The problem would be to get it accepted. Looking into
> that now, but hitting various kinds of subtle issues.
> 

Ok, I'm pretty unlikely to get the shrinker work to the finish line
before I go - fine with whatever lands in either part:

- Shrinking THP should not make fragmentation worse (this patch), a
  version of this should get Xe reasonably stable, hopefully this fix
  can be backported.

- Avoid evicting working sets under fragmentation ([1] above)

Matt

> Thanks,
> Thomas
> 
> 
> > 
> > > huge page swapping, other GPU drivers basically also split pages at
> > > swapout.
> > 
> > I wonder if other drivers have the same issue? The deadly combo is
> > allow
> > GPUs to subscribe all of system memory, allocate THP pages (or higher
> > order pages), and split them in the shrinker. Xe might be the only
> > driver with right combo to hit this but not 100% sure without a deep
> > dive.
> > 
> > > 
> > > Another idea for improving on the compaction loop, perhaps worth
> > > trying
> > > is this change, shamelessly stolen from i915:
> > > 
> > > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/shrinker_batch?ref_type=heads
> > > 
> > 
> > I'd have to give this a try - I'm quickly running out of time before
> > I
> > leave for month though.
> > 
> > Matt
> > 
> > > /Thomas
> > > 
> > > 
> > > > +{
> > > > +	struct page *page = folio_page(folio, 0);
> > > > +	int shrunken = 0, npages = 1UL << order, ret = 0, i;
> > > > +	bool folio_has_been_split = false;
> > > > +
> > > > +	for (i = 0; i < npages; ++i) {
> > > > +		s64 shandle;
> > > > +
> > > > +try_again_after_split:
> > > > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > > +		    should_fail(&backup_fault_inject, 1))
> > > > +			shandle = -ENOMEM;
> > > > +		else
> > > > +			shandle = ttm_backup_backup_page(backup,
> > > > page + i,
> > > > +							
> > > > writeback,
> > > > idx + i,
> > > > +							
> > > > page_gfp,
> > > > alloc_gfp);
> > > > +
> > > > +		if (shandle < 0 && !folio_has_been_split &&
> > > > order) {
> > > > +			pgoff_t j;
> > > > +
> > > > +			/*
> > > > +			 * True OOM: could not allocate a shmem
> > > > folio
> > > > +			 * for the next subpage. Fall back to
> > > > splitting
> > > > +			 * the source compound and backing up
> > > > subpages
> > > > +			 * individually. Release the already-
> > > > backed-
> > > > up
> > > > +			 * subpages whose contents now live in
> > > > shmem;
> > > > +			 * any further failure terminates the
> > > > loop
> > > > with
> > > > +			 * partial progress (handled by the
> > > > caller).
> > > > +			 */
> > > > +			folio_has_been_split = true;
> > > > +			ttm_pool_split_for_swap(pool, page);
> > > > +
> > > > +			for (j = 0; j < i; ++j) {
> > > > +				__free_pages_gpu_account(page +
> > > > j,
> > > > 0, false);
> > > > +				shrunken++;
> > > > +			}
> > > > +
> > > > +			goto try_again_after_split;
> > > > +		} else if (shandle < 0) {
> > > > +			ret = shandle;
> > > > +			goto out;
> > > > +		} else if (folio_has_been_split) {
> > > > +			__free_pages_gpu_account(page + i, 0,
> > > > false);
> > > > +			shrunken++;
> > > > +		}
> > > > +
> > > > +		tt->pages[idx + i] =
> > > > ttm_backup_handle_to_page_ptr(shandle);
> > > > +	}
> > > > +
> > > > +	if (!folio_has_been_split) {
> > > > +		/* Compound fully backed up; free at native
> > > > order.
> > > > */
> > > > +		page->private = 0;
> > > > +		__free_pages_gpu_account(page, order, false);
> > > > +		shrunken += npages;
> > > > +	}
> > > > +
> > > > +out:
> > > > +	return shrunken ? shrunken : ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * ttm_pool_backup() - Back up or purge a struct ttm_tt
> > > >   * @pool: The pool used when allocating the struct ttm_tt.
> > > > @@ -1045,12 +1109,11 @@ long ttm_pool_backup(struct ttm_pool
> > > > *pool,
> > > > struct ttm_tt *tt,
> > > >  {
> > > >  	struct file *backup = tt->backup;
> > > >  	struct page *page;
> > > > -	unsigned long handle;
> > > >  	gfp_t alloc_gfp;
> > > >  	gfp_t gfp;
> > > >  	int ret = 0;
> > > >  	pgoff_t shrunken = 0;
> > > > -	pgoff_t i, num_pages;
> > > > +	pgoff_t i, num_pages, npages;
> > > >  
> > > >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > >  		return -EINVAL;
> > > > @@ -1070,7 +1133,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > > > struct ttm_tt *tt,
> > > >  			unsigned int order;
> > > >  
> > > >  			page = tt->pages[i];
> > > > -			if (unlikely(!page)) {
> > > > +			if (unlikely(!page ||
> > > > +				    
> > > > ttm_backup_page_ptr_is_handle(page))) {
> > > >  				num_pages = 1;
> > > >  				continue;
> > > >  			}
> > > > @@ -1106,26 +1170,40 @@ long ttm_pool_backup(struct ttm_pool
> > > > *pool,
> > > > struct ttm_tt *tt,
> > > >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > > should_fail(&backup_fault_inject, 1))
> > > >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> > > >  
> > > > -	for (i = 0; i < num_pages; ++i) {
> > > > -		s64 shandle;
> > > > +	for (i = 0; i < num_pages; i += npages) {
> > > > +		unsigned int order;
> > > >  
> > > > +		npages = 1;
> > > >  		page = tt->pages[i];
> > > >  		if (unlikely(!page))
> > > >  			continue;
> > > >  
> > > > -		ttm_pool_split_for_swap(pool, page);
> > > > +		/* Already-handled entry from a previous
> > > > attempt. */
> > > > +		if
> > > > (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > > +			continue;
> > > >  
> > > > -		shandle = ttm_backup_backup_page(backup, page,
> > > > flags->writeback, i,
> > > > -						 gfp,
> > > > alloc_gfp);
> > > > -		if (shandle < 0) {
> > > > -			/* We allow partially shrunken tts */
> > > > -			ret = shandle;
> > > > +		order = ttm_pool_page_order(pool, page);
> > > > +		npages = 1UL << order;
> > > > +
> > > > +		/*
> > > > +		 * Back up the compound atomically at its native
> > > > order. If
> > > > +		 * fault injection truncated num_pages mid-
> > > > compound,
> > > > skip
> > > > +		 * the partial tail rather than splitting.
> > > > +		 */
> > > > +		if (unlikely(i + npages > num_pages))
> > > > +			break;
> > > > +
> > > > +		ret = ttm_pool_backup_folio(pool, tt, backup,
> > > > page_folio(page),
> > > > +					    order, flags-
> > > > >writeback,
> > > > i, gfp,
> > > > +					    alloc_gfp);
> > > > +		if (unlikely(ret < 0))
> > > > +			break;
> > > > +
> > > > +		shrunken += ret;
> > > > +
> > > > +		/* partial backup */
> > > > +		if (unlikely(ret != npages))
> > > >  			break;
> > > > -		}
> > > > -		handle = shandle;
> > > > -		tt->pages[i] =
> > > > ttm_backup_handle_to_page_ptr(handle);
> > > > -		__free_pages_gpu_account(page, 0, false);
> > > > -		shrunken++;
> > > >  	}
> > > >  
> > > >  	return shrunken ? shrunken : ret;

