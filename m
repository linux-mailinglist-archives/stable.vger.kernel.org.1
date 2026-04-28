Return-Path: <stable+bounces-241496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKg3GVRw8Gn9TQEAu9opvQ
	(envelope-from <stable+bounces-241496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:31:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADBB480207
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49AC30C8EC1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613F3CFF44;
	Tue, 28 Apr 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6RLJSI8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C33D3304;
	Tue, 28 Apr 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364725; cv=fail; b=RwdQOpy73T5G6R3bWozxtkSFcCv2kWYtZhGXWSaxoWoGqq7WqvIGdPwQ48dD1V7etHA+YvLMQ5LH/0ayFWz9b7vThE46em78jN5QJ0jEij75fKQDk0P2va4qxhDWmJdvtc08y94UBLumK1RzL9b82Z9Ww7mba4gB+ieyYEH4ahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364725; c=relaxed/simple;
	bh=R4jDjm17xwUpn46/1jmkCOshlRcKc20ohR6P0/EHlPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uq7b3LfPjfbCO7IZ7DYq0bDPERWnV4MwqK19pk/JIOw003yxpoMC4cIdK60BHDIzmztefgYsu7AxV9mjdUwfWvzT8eZneHlu77DIcH3q9ayej9eNA40gPPwp5ud5OT7togrvIX4oBCw2cCtudgPq8ej4QpKJoTyVARPbwtjDTDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6RLJSI8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364724; x=1808900724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R4jDjm17xwUpn46/1jmkCOshlRcKc20ohR6P0/EHlPY=;
  b=T6RLJSI8wBRVJrGQnbjYlv8uJ+6EPXW1P69mqi9eW61FXiD7+8AyHXa0
   9TB6X9v0sX6pgT9g5y0g1ZaNaKeEojVo9uz9DgAKeKjMC+INsVqJ3YOIR
   I+72FdRVw53V72iuroizdvgQjILwIbVqIJEU4nC85E1Y4Vw3pJzFoPvv6
   WMZ0X17Em+QzYQO8mLC5ijVkQoqufgOKWHlqa6UFK0HiGwK6MBSUgkPRg
   5CUbkzUCH99W58SIkvQI8sPEHeLMlGS07cdjwu3jDRvUb9mX5kRzAZSiU
   UbaONj4ET+I77B5fmBTg++vYi3PTTxMUe14py2hIPzH/BC4gwz74H22B+
   Q==;
X-CSE-ConnectionGUID: NCG/OFZLS8iR5nimYu3E3g==
X-CSE-MsgGUID: 3wEPE6siQbCrhufrnDda5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65796321"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65796321"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:25:23 -0700
X-CSE-ConnectionGUID: 8TF9d8zOQsyoOzhHJF6tlw==
X-CSE-MsgGUID: ixcMRfFyRQmsVj2HJPajCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229326421"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:25:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:25:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:25:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLZ0tdQIz0709Um5dcaV6cnk9pkqHXaNgZ29Tl+CKxl6uNx6m4Wiu2veTUZ+sujrbBQhQNgSHoJ78gPvnHs1Kpnyfy5cYSEjmrUcI9siRAHcLiYHf6US2a4JQmz3Os0tyeNm4L6e38R+ul4jY3evcEHaK/NMA6yRB2vKUm34UXo535+Ks6XQTX7iKW5xSR/3qCQjST4QW+dgF0PSB+wZU0k9s/7QCxxHkjasL32OHwUiwEOisZL82+Z0pbp+vJwL2FbdAySLFombTyG1/0Kaet7J6f+8OMK5J7ZWYN8DSG0i9kZBBpCIDf0hj5eXq+geMQN/4u02oWnJZytWfdLP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztO0hl+qO6EfdKiSedm8LpLrAODM2AK6jyJVQYso3Yk=;
 b=PE3RZj0PaFD6RiMFeYRx3+0QRCgV5btccGOQ3JZxKjxQ4FRZglKqwXN9kz9zkYYbUYicqU6koInq7VchfJK9nbWoeftXRUB7t1nfEBiO2iEhhhaurD5xgAXA1eNCIu1b1wO+KNjb+IDr09tpup3MIWaAYDB+cqp/aplOQhvygNI4AbbhhhQhtppQD5Yl5sKAwQayGkP5l4o3geE4jqr0UY2mI9R1yHDXVCPnhNmd+IuwURpr9PdVTQVRUw8kRpwWHojN9VazTJp/5ay5fvIrUpcXtB5aIen3/Uowh6J0P+YrTx2cxYT0nN50s+f1hO/FF0woWN21n8+mJy9ETNmrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 08:25:19 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:25:19 +0000
Message-ID: <d028fbd3-d6d2-4228-896c-eb1e2f2eb0ea@intel.com>
Date: Tue, 28 Apr 2026 10:25:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede
	<hansg@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, =?UTF-8?Q?C=C3=A1ssio_Gabriel?=
	<cassiogabrielcontato@gmail.com>
References: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
 <CAHp75VdMEXag0oeRd620YJn5TpgqGy4YProDcR7EZE__cwwC2g@mail.gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VdMEXag0oeRd620YJn5TpgqGy4YProDcR7EZE__cwwC2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::36) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a27450-3844-42f4-c943-08dea4ffaef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ea5u2Jz4dbSY0XHrp4md+V6CTu6t/TRPkgvNugpFu1O3FAKu/T0QFMTt95xc90A/A6z5yYAuv3sZgHC6h8hBWZgS+YeWUCWrYBXPysWD0SBUBXR6gf6V2gYCTZrjnkZwjGG85CvNuSh6GGNAINdXimF7tg64EJFV5q49y7zYO/EVUOcvf6qMkMV6D9DDTWqhCCxEScyCyBohMGx11JIroprtj7LATAWFLNklmN4XgoNjbISgqcCGuUmAHKPAmXUywXcRgSMcW4B/rFA3Xh+OYgRJWlHUUm/Oozq+FZayA3dZc1q6290zSKlH04KPcmsiV/d3IUWeyJnEJrXyL+Nex5z3tqMBUe1YGZh5f3z2vMY8h8ZVGoUPoWaNxthlHY/RzOwkVRp1IyoU3imwIgIygW07Mn97/0KTnTBo21E+TgIMHSWJxZvok8lCjbQTUTFjXSz/VHM9GzCDcg9QOFtsJOOTOOp+xL/pOWFAaCvpg02iZumXIppqdVFRo28BtRBM1LyuruqIwi4F1BiGrsUrBOhb6VcwsdJQz1DJmzPxc/5UxM1bosPNqi4gp6HhTfVi+nqV1aezIeadOME4M99FtrYNTxQbUiqcWYXItPajwqV9daHXZI0zGXXu+HACJBBLXs6hKGz/ewPMjSFIUokbOcWkvmKMLwp/GlYFYwMOe2yVezUmi2BF/Xh9S2Njd4Xz7BsAxSVrnXGOFeWhcJQtUVduuElobkg+C20cZWMJlJmn8Gfb+CqhN3SlHRiig8c/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTB4c0gwdnh0Z1VhVGdmQVdWWjZYZEhCWkpWOHFPaTdxS0pncDVmSEZFbjlw?=
 =?utf-8?B?czJKUWZoNGtkUUJ2UjhGOUZqVi9uRTJPL1NtdTZydm41NTZTR1BOY290L1Uv?=
 =?utf-8?B?R09LOEVUOHhNaHJuMjZ1M3NhaWFiRGw2elQwZ0NtdzJzZGJjRGwvb3doWnlm?=
 =?utf-8?B?ancxZWIrZ1pIUTRyQzJIMklQaHh5dnYrWkhXdmppR3Q5SE1FakxhdU1wbTYr?=
 =?utf-8?B?NnNyM3hENVB3dVR4cnBqNzFuVzh3NGdaSkxkcmtMdGJXLy81SjAxVGQrVlF3?=
 =?utf-8?B?UVdFb2x1SGFSMXlUdFJMWmVzZlBtT0xjNTVwclJpZEdETUZ4WmljMFFvdlRh?=
 =?utf-8?B?NXRkQ3FVYklPNFNGSitUczE4emk3TnBPNVRmZ09zWklHczhQRlBhdmkzb3lo?=
 =?utf-8?B?T0VRVXp2VWV5RkF0U05wMEhra0lUMnpxdCtmVGR0dEYwOUlhOU14YTcxZG1i?=
 =?utf-8?B?RW5HSGtIOVpKSWJzalNCS0xTaUQ2STIrU05iL2xHODRhQ1pna3IvcEZqN09z?=
 =?utf-8?B?M1BucCtFb0lULzZoeXI2MzIvSnlma3dlUWdFNHJUSG5xVTJUTlZhRHRaTGxq?=
 =?utf-8?B?KzRtU1dvZy9aNEVMaFQrdWtNRk5COUN0OFIwVndZSmRPQkxwMzVOa1hYT3Ry?=
 =?utf-8?B?V0JCOVFxam01NUovVG12Wmp2d2MyRFRWNUhZUkV2a2Y4azA2NDdCVVVEZTdu?=
 =?utf-8?B?cW9XNGgyQ3BpUDlqU0ttK05zR2xTcjVpdmV1MHQxSG5Sby9PT09GWFk2ZXdT?=
 =?utf-8?B?TUNlWlB2SEJYRkpQMStwNGorZUNsUjhwMTlHSHFRQS90L2RsajlNaWFWU0Rr?=
 =?utf-8?B?bk4vMWNiQXpUVUprcEdxU09YREVSMUZpQU1mRklZcm9sbUE3WXExemQ2dnMx?=
 =?utf-8?B?NkdWZjVuNVUwU0JkM1hOQXpZNWJaRlNuTHRoWGg0eWxEWVJrRWdtR2xrcXVv?=
 =?utf-8?B?Vk9Xc0l4TjZVR3Bnckt6anhZbjdCeVdlMDhjcDVVSHJXemt3T1lDYWRlNUZj?=
 =?utf-8?B?YjY0eDR3MFhGN2lnQXd2dHJJV0wvRExZbURuTTdIMUYwQ0srejU0eFJRaGh5?=
 =?utf-8?B?T2NiYlREOGZFNFFobW81V3RHQ3RIN0V2cmxRcEdEc0w3UENPVEV6enpCTTRF?=
 =?utf-8?B?VVhrczBUMk9IZDhiSEVQb210bWY1NXpzcmtsRnRlb0sycDFyTVN2WWU2bjVr?=
 =?utf-8?B?R1hPQ0ZpRUJJUzREbE5iRXgySzd2RkY2OUJpQ0Q3RzRjWXpXUkw2YkFVaVli?=
 =?utf-8?B?UzN1enFVRjNPOTVuaXh0ZVFQbmF0UzdIOVNHeERnYThacHF3WDIwRDc4TWpT?=
 =?utf-8?B?ZkZVbTRhL3gxbGFJODlIU3NyaFNLMFJwS3kyZSs4V2MweDFiN2VyOVFXK24x?=
 =?utf-8?B?bm01UGVsdmRXM3IvSVlXREZ4Q1VKaWtUYW1NQWRwMWRIb014Z2Q1SXAyOVlD?=
 =?utf-8?B?V3M1dC90cThPYitIbjFORnNmMzF3Ukl2d1JpVGNkSGJWRVNTQ1BPY1ZtQXZo?=
 =?utf-8?B?WURJUlNYL1NtVkUrVW4xazdsQ0s1bStyT25IdG8wSjRtbkN4ZkVwSDd5cDI5?=
 =?utf-8?B?Z0ptWktFT0N4TjJkdnkwTEFqS01vVTMrQXlocVA3ZUhLcE0rNWZPa1ZFb1px?=
 =?utf-8?B?VDE0ak92T2JDUHg2bGN3dW15UVNHcmdvZ2x3VWFFMWpQZ283aUxhWnNZb2lw?=
 =?utf-8?B?azFRcEowZUw0ME9Rb0xnR251bjQvWFNlbktrclY1cENBQk0rcGV6NGxlZHNr?=
 =?utf-8?B?SjZrOGp3NHFQdHUrVjNGRmpETG4xeUFzZUtvNFlhb3FRRjJoKzBORW1qZlUv?=
 =?utf-8?B?L2Z6OE51N1NnOW9QNGVpNFFRYmNzYUVObzR0WldHN0IzeEZIMG1QSVFBaGxU?=
 =?utf-8?B?cnRheEcrdXZHQWJBSlJDTExjbTFZQ01BOWxuOFFHbHNQYjNPZDJhTFRYcHV5?=
 =?utf-8?B?N3hUNmVQUmVDVGVoQVl2cmFpTUloL0grbnVrL0V5eExWYVlzUDl6U0swSm14?=
 =?utf-8?B?a2EvaWZIVll0LzdlMVptSW9FRmlRV0JwVC9JZngxc2NRZm1nNTd1Rm9vSktE?=
 =?utf-8?B?K0dVbFoyRkdHYzBTcmc0K2NXNEpRQVRnU1hrT1V3bFVIUHlJME1JZkcwNC9v?=
 =?utf-8?B?VEU2Y3MyTlRlbXJaRDFYNFdSd1BvcVFyVUJ5QTZBa1dRem0zSThvR1U2RlQ0?=
 =?utf-8?B?azMzUC9xK1M3VDZJOFFUWklEN1pXSEdOY1dWVS91Q2dKVFcyYWRlWHh4WGFN?=
 =?utf-8?B?MWlyb2NYU0VmZWpNa1JlZXBSVUtUSTRHVGZ5K0ZFUWZNUE93SmM2bEFtYTNn?=
 =?utf-8?B?eCtDd0UzRU1qcjljeTVGemo1dVdzUDVLQVhNaG5qaXFRQ1ozUzl6czV5czhC?=
 =?utf-8?Q?zLkVQ55go32hG+WI=3D?=
X-Exchange-RoutingPolicyChecked: DSCI9fHFIyfsiRybkYcdlXUK+J2EF5YdnGtcB75U6DUnSJh4q8r4P8N5pcHR28F3PnuAR+aA9Qy5FeWrE/7TOP4QyZ08BhYtWRyTIyrgPqKC5gA5ikIC3T1Nc6N8Cx2gDoLw46VWqk6IJpbASbIJQUsVlwwwk9YcI50RWzkSqosrchNIMDwO+lleVrWaRRaUIMM7tHvT6SLVqWkVLorSUF365dHQwGAnPm+ad0qF/kEu4x+XcihduVCgP3xE4yyiBmMMFbaim7OBFUWylEoghEdjgA6vOpjfGqpXJZzJQcnMYLjeC9w8pu9BcYuDFvzsrxJu5ywTBfV3tlAPHvuEzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a27450-3844-42f4-c943-08dea4ffaef3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:25:19.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhOWfLQivvtaL6Sp+9qRdhPIpvLBMUpOfns9CPY6kpTAyh95bGNr0amHdcuaqX+Y1shM3cM2ljo48nXVxut1QaJONWXypm4dYnek6s0sVHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DADBB480207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241496-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,linux.dev,kernel.org,perex.cz,suse.com,opensource.cirrus.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cezary.rojewski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 2026-04-28 8:55 AM, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 5:38 AM Cássio Gabriel
> <cassiogabrielcontato@gmail.com> wrote:
>>
>> If byt_wm5102_prepare_and_enable_pll1() fails in the
>> SND_SOC_DAPM_EVENT_ON() path, platform_clock_control() returns after
>> clk_prepare_enable(priv->mclk) without disabling the clock again.
>>
>> This leaks an MCLK enable reference on failed power-up attempts. Add the
>> missing clk_disable_unprepare() on the error path, matching the unwind
>> used by the other Intel platform_clock_control() implementations.
> 
> There are 6 drivers that do the same, why is only this one special?
> Have you checked the flow on the error path of the caller of this
> `platform_clock_control()`? Maybe there it calls with the opposite
> event to shut the clock down?
> 
> ...
> 
> TL;DR: If it's a real issue, it has to be fixed for all affected drivers.


There have been multiple reports regarding similar problem for all three 
ATOM-based generations I believe.  One of the more recent being "ASoC: 
Intel: Fix MCLK leaks and clean up error" [1].  Does not look like there 
is a single owner of that subject.


[1]: 
https://lore.kernel.org/linux-sound/20260401220507.23557-1-aravindanilraj0702@gmail.com/

Kind regards,
Czarek

