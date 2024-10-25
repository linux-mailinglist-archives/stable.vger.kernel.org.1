Return-Path: <stable+bounces-88196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3A9B0F21
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 21:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1876B1F235A8
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336481AF0BC;
	Fri, 25 Oct 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZeDqXPr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499381FB8BC
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884859; cv=fail; b=QsDISJNhiXyKdjxAJnVrhofZVpTD46RWL8figY+WA1bhs2lFelD5ouEzXfInPI2hYIDvPC+aKLRUnSmZJ9yc90yTb82pz5kPQvvRYErRJwzcelJvCPlCQLvf4yByRi9+iYOuFXFiLSQPk3OlRRaMkPkotRO+T52DvUCpUF46+fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884859; c=relaxed/simple;
	bh=SM0VOl7oKgQP5d+vIlc0UaRSTO5gYt2VrnKG9hyLW+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBsbjtlBYHvM2GpE8UKbKRwpCpol6sNx0IZYa7/G60x5jsdJgbTZJnoTkO6LcZSh7Hsqv2YEbJw/LbevKUO8qBXNZPguhfBaDojWcj2XXzCdzlLiVA7a+8w4GVBdUCOESodehGH0mC30WCGNsFrk7tISJQC0YIV6FkF6SLoN17Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZeDqXPr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729884856; x=1761420856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SM0VOl7oKgQP5d+vIlc0UaRSTO5gYt2VrnKG9hyLW+Y=;
  b=eZeDqXPrdWUVATvzkDfuhAqTubQ3qdv1QCdkhcxlueex20eobD8x/I8d
   BcrSrTnn8R7SEvu5vSBUJiLxdfzCVIjCkNEq8ALz9sZjtRegXk4vmejpB
   qbCRQNHc5XRVyqOMtAz3VpJz0Y/Ec+sgldgr7AeyWcd0UHPnHxXTnGAak
   Leg0y5KuE1xcPfhSrrPrcw5del8nwCvPBAwYP6w+z1G5NZ9HYEpDRgouW
   GLu4oJyBL0OuOu7juEyUxHhl7C8YNlsSvGc42uatvuUmG8Au7Jq/fImDl
   44BKNU/9GZOB4RL2Z5gFHIiKUvUil7krNE1RRk2fd3eg9xpQr2sefII1B
   Q==;
X-CSE-ConnectionGUID: S7Lxz+THRfiGbYj2VM78tQ==
X-CSE-MsgGUID: HQerdBC4STiVd9KPtV8qjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="17198089"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="17198089"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:33:54 -0700
X-CSE-ConnectionGUID: 3FXZBh/vSReb7gywJmFn9Q==
X-CSE-MsgGUID: f23nI6QyQpCcqdrrJwtHNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80916357"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 12:33:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:33:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 12:33:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 12:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl03IKD+y9BEhI+0h7tSZCztRifV6rgOXk8ifDHV44gHQVZ/B15g95YGJ008XX7TyeGZ1UDHujub+2uy4PoynFE0vfWcYBEqkavqHZ0CDrWUqfOVwSJW/UWJT7Ssh7qsi+Kkp/tSfOLaa4JbHxlMiAqJ+y0+WM3W1UOaACN36+QQyvOQHKiKyl0a53vXxK34PjKYHUINfNqcSX3ATp5iGZvyelkHHNuSe8pb3zfjYthdNn/jbyncQLTV46/Sk26djoLNwWra7YbAntwTu8rV7TVf30pVLZGK/jyUMJZXyaJTg/jeWq4DUjRRld6UqfZM6vDN1bOjKhcO3k7Sd85gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGpQuxHFE6FSEUS7w2khPlJ1xdAVRIGIgBTH4PpyXMk=;
 b=RDMk/1m+WpkcEGmRbcH4UiMSFX/J7V+GfrsjtW9A3OC11LaHIp+Uh01rmiLGAADZ3AqLKjJANoUi3nU6O7lG1Z2MYJoFat0V5Z2oJ916zFKC+yb0d0fNJMlPtCUh0WmtpPhEtkwKo780SYlOw+GMjyrDi3x03EbjHi8zkkaZwC3QBgJCQ4LuOhIyKk3EyA6AH1UjHqgSLlZLgBi722DuCkfpG+GjNbFCbdeOJYxa6i1M3rw7BxPz/yBXpkn6xEqT21h4xgWzG3EkGvzoojdiHh/wPlwJhzm2xAwx9XdimY2tAj78Z69Oru/WlrpkYLROUOga9FlFTEEju7neJCNkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 19:33:46 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 19:33:46 +0000
Message-ID: <82debae5-4eea-4302-bb55-593c1791d3e6@intel.com>
Date: Fri, 25 Oct 2024 21:33:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Matthew Brost <matthew.brost@intel.com>, John Harrison
	<john.c.harrison@intel.com>
CC: Nirmoy Das <nirmoy.das@linux.intel.com>, Jani Nikula
	<jani.nikula@intel.com>, <intel-xe@lists.freedesktop.org>, Badal Nilawar
	<badal.nilawar@intel.com>, Matthew Auld <matthew.auld@intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
 <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
 <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
 <ZxvknjgW+3hQx6nM@DUT025-TGLU.fm.intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <ZxvknjgW+3hQx6nM@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbfc24d-fa6f-4161-0ac9-08dcf52bf147
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUx2ZVBpTi9nd2V0ekd1QUx0dmJ1SDZZY3ZnMGdZelMyTmpRUk41ajJ1bDA5?=
 =?utf-8?B?KytSMmdoQS96NXIwUVBQd1VkdVpJTlFTYzR3SXhWMWdsMVJmRHJZWXBFNjNC?=
 =?utf-8?B?MEF2d0E0QzNsZGdKUTlZMDlDSW5SbExjR2RQNzNRMjFnS1NxM2xZci9ZZWtW?=
 =?utf-8?B?a0M2dVIyaEErdEtVOXUzeEwrVjBuVldxOTFNTGpRcHVKam9KcDU5TXVXKzho?=
 =?utf-8?B?akNaSTM0bzl0ZUtVY3ZOdTU3bW1ZT2hWa2lkeXA5cWlKSHdHcmpDSmNtM2J1?=
 =?utf-8?B?SEkwUHA1a2xRZk8yRjgya3FSN1Y0YWJiSzFiRTJGeC9ROXFwaVVDcFY1b1VK?=
 =?utf-8?B?eE5oNWQzeGJ3MWpvRWFMbU1ETGlzaDQwL1pObXRXQk9RMHk0WGFmOWhqV3A0?=
 =?utf-8?B?QWlxbG94K21aNTZtYUlqeWY0TWNwclhDWFZWS3pId000cHpnS1lXUmUxQUlk?=
 =?utf-8?B?RWpuU0tvZVdRNEs2YWhvRThBL0ZNRldDWTVLVExOQkt3YXI3UWhVSFczQml2?=
 =?utf-8?B?Q3VKWSs1enNKelZMaVh6UlB1cS9rNnFsS2lWMlNKS1BvakJwWE1hOWdHczQy?=
 =?utf-8?B?RVNNakJhVFFUZUNJWWp4QzBtcHAxcndNUmVOUHJNLytvay8vdXFaRUQxa0Er?=
 =?utf-8?B?dE1kdWFBUzN3MFI2MDhnVE1XbFFsSHp0NGNKWC9CT0ZONldTWVo2TTdvZXU4?=
 =?utf-8?B?WjErY0xGQjlMSk4xTGVpTkZ0TDFuZzh1RjQvYkVXY21Xdi9EeGo3Y3Mzd3oz?=
 =?utf-8?B?VlMrdkpXN2ZvZHJ4amF6Z3c3Q0JwVjJmM0RySFFGUTB4MFlmZEQ2ckkyT01P?=
 =?utf-8?B?cXNVUXFsL3Y2Uy9tQkdxN0ZqbHR3SWR0aEM1dVVhdk1MOTBQZHNNK0haZ2JF?=
 =?utf-8?B?NE5keVNzalhneHVGVnNLSTVYZHpLNVFhRlUzRWpaUUFKc2lxVys0b0FnajVi?=
 =?utf-8?B?aUtTY2JNbWtXSzJLK211SjB1ZjJDMUFNZFRwMnVSMEZGNHdFbWQ1UG1MQ1pk?=
 =?utf-8?B?cnBVR05XNGg3dkpCT3FXQ2d5d0xTMVRkSUR1d1NqUjExbUdTQkRZbCtFVDFr?=
 =?utf-8?B?U2pVT0ZQT2x3ZUczd1VhSlRWS0F5RlNKWHVPbW5RS1RkRG1wSFNZdHRkMzFa?=
 =?utf-8?B?WUdMK0pvZitPN0puWWNwRk9YdDBnZ2ZuMmVvR0NIZExqTy81ODM4VFArcUow?=
 =?utf-8?B?Y1YyamJzdUttL0Ixcy92Nm5wc2g3YXNqU0VwbFJpWnBhODIwNGJyY1Z3eDI4?=
 =?utf-8?B?NzFhZUhFSzJQZFIxMG4vTVNaZ3BaQi93VCtCd1pCTW5ZY2g4OTR6dzlkR0dz?=
 =?utf-8?B?V3FDU1kyRlNXY2VHcEdBbExpZ3dtUGQrRWFOZXZvQnhJeTdjcFNia0JHMkhp?=
 =?utf-8?B?Z0YzUWZJQ1QxOUZVdkxESkl6aWxyNXl2WGFzZi9oZjk1QUN5ODZncldPcXJr?=
 =?utf-8?B?YllGZUljRm1MVHpGK1FmY1J4YTZUTDhoRG0xM2sxNDBrMFd3WGQvSjA3Zml0?=
 =?utf-8?B?NEYwN2w3WDVVTUwwTGdlZVVCN0sxMUpERmtQVUNsUXdoMmRUUzQzZzQ3YXp6?=
 =?utf-8?B?UlEwMnRmU1M0K1EvbjhuYnRkVVhzSkM4NDJwbmo4N0ZkazdTZW5tcXowQXB0?=
 =?utf-8?B?bCsySi81MjRkMm0vTUcrQmxJWU5yS1ozbXpXK1FxUVUzNW5uQTNFamN5a2ho?=
 =?utf-8?Q?eWb8QQMQvhWnioj398ko?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBuNWhXK25LcHVDOU1xVVdkV0o4QlpoYXJ6REpnSGM4VjAvTXpZTlhiWE1x?=
 =?utf-8?B?ZVpJT0FMcysxaXVWVE0xdm1jM1ZBZEcwZkFPbHg1QVN0YzB6L1ltZWkvZlR4?=
 =?utf-8?B?RmNhVlA5Mm0raGpsRkZRWmdlRXNoQ0tkcEs1bGhCMVNiZkhCaE9wN0RxdDRt?=
 =?utf-8?B?ckdGRFVhdkM4L2cvdld1MXRpd0RBakNvV1hvaVVTZFpQNy94ZGhpdTcyRzNI?=
 =?utf-8?B?N0lJdmRYK05IRm0xdm9NRWlUK0hkSktwczgyVFlQbVFhVlAza3RoYWcxL3Np?=
 =?utf-8?B?KzBGWWJWQjk5SkIxSlVCWmRRSTVJMjQ4cWZQYzVwN2QvUHIxRTFWbUovNXhG?=
 =?utf-8?B?dzBNd0JBdHJnOENhbHBLbTRVRVBzZjNaRnRoWDBLYjBpemZtdnlLU0ErNzU0?=
 =?utf-8?B?UHZYY0xPME9WODE0TEhiRW1uUFlpQnJHWUtJUytXSE13ZTlkN1JkNjhHODdF?=
 =?utf-8?B?cUFaZDNUVE1vT3IxMkIvM3BxZ0F0bklNUXJZNDRIZlJzWTZUdWtKUzBzSllS?=
 =?utf-8?B?RXpsSkJzdGUrNi9vb29xazV2RFA0TDdGSlVCK3FZbjRQcUlDemFnOVdOdVlO?=
 =?utf-8?B?ZTZDc2NLa28zVXlOTXc4TkVlalZxM3l5aFRYbWNzUHlEdFJFV2J0R2N5VWMv?=
 =?utf-8?B?UFk2b0VyMlVCUU8wU2tsZnpObTd5TllpbzYzVkVDS3QwTGQ2RSszSWkrU0k5?=
 =?utf-8?B?ZDJmUkkwU0UzRXpzUjhHQUdLZXJVZXFmczFCeGJvcTl4eGNJVmNUaVlxWEVh?=
 =?utf-8?B?OGpVUHRHSkZvS3M2OTlHa09tQnlRRlRYZDdTWlllaTdhOGlvS2cyc29xbDQr?=
 =?utf-8?B?UjdQZXUza2grZ0pwL3lWYnNyMGRzOVRqTW91ZjFDSURtdFUvd05rNE5LOWdY?=
 =?utf-8?B?RDRtSTdYb1d5M21UYWlManVuemZyYUJzRC8velRyTGN6VGVTR2svTGx6ZUFr?=
 =?utf-8?B?MURjV2JHczYrcTZPbmFyL0kvdWJuZXlvUVpuNCtLV2cxeTRHYnBIQjU2R2E5?=
 =?utf-8?B?VW1Vbm1NMktWOGdOMlNpSXhTRTdTdHZ4Q2dOa0xhQTlLRDBRTVZ0b0dzMnFo?=
 =?utf-8?B?aTZ0c0U3TUg3U2lDQW9HbVg4dHRVNDhqbzZQdEhuUU5xTmdUVWgwNmRVOXB4?=
 =?utf-8?B?ZVJZSGRmUHVzUlJGdkcvWmFqL1drTXNNQjNOVDJ3K3R2QWkyc1Q3Snc4SUg1?=
 =?utf-8?B?YXE2ZW9UeUltWGhCbVd2WkNlNmJEaFZPR1E5S1NqZUdmNUVUdVNIV240a2k4?=
 =?utf-8?B?SkNlSmd5UThEN2JPWjRhamlqNzVwbk8yU3dvNENjeXAydWhZT2tLWDdJU1NK?=
 =?utf-8?B?YjdWLzh0K2xYVGdjV3FtS0lCZExKUjlLVzZESW9la3JRdUhCTSs4V3ZzS1Y1?=
 =?utf-8?B?OXYzenNUc25lVHNhWGR3cUdvTy93VFNUdndHc0cybXYvdEZveWxHejVESlJ2?=
 =?utf-8?B?Q0ZVVEdpbTl4MFU0dXlQaUhXQ292UHFzYTJwd1VreU1kc1hXREwycklVU3pG?=
 =?utf-8?B?Zk9PVWFFNHY4cWVJT2dWblFncTBDc2tHZmsyeUhzajdwdW4yNUd2NVBKOVlU?=
 =?utf-8?B?ai9MS1MxYlZCVUFWSm9RT0xmRFFYMzdRNXZkOUJvcHMrR0hINWpNaU1JTWEx?=
 =?utf-8?B?QlBzTGVRUW9rSVZLdGpiZDVhSllRdHlXNjYxbk1GTENBUVNtRGk1RTVpbFND?=
 =?utf-8?B?Zi9TbTQ1M1hXUGdQdG1Gc3dzRSszRUhYZTV6eEFkMG9kRUttSUlRS3Mzc28z?=
 =?utf-8?B?Z1N2ZGhJR0RvNE5pUzBzdmwxZ3FzTFNDaXJ5aHZoZDVtbno5cG5tQ1dDRDFS?=
 =?utf-8?B?U2pBa2l2dWdtMGpITVR6NDU1WHl0eTFHdVRaalg0VG5NeWkvUjZpdVViRUFj?=
 =?utf-8?B?RVBzaWoxNmxLaC9Zb29oMHJzeVFPb1gzN0hoV3NoNmMrUHp0N3A1SWVGNkti?=
 =?utf-8?B?QmRDbzFBbWtXWnY1Y2psNWIrMGhhcVBPSU9mWUhrVTRrRDI4VERnSks5bVBF?=
 =?utf-8?B?VVhTVFhhb0lSb2xlTzY3UUdlalBNc3NIdm9QdTlQSVNGL1ZIMk9GWWtQamdy?=
 =?utf-8?B?eFpJSWVvNXF4U2hqWldpaDVBVjZJTmFiUWVyWktDMHNTOTdjY2U5di9aWnZh?=
 =?utf-8?Q?wPp7Mbb7mgH7jMGYrgWtKpXvY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbfc24d-fa6f-4161-0ac9-08dcf52bf147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:33:46.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EYSJ0DICcQHjgGh2lHbu/fMmiuGya/rOLhghaztPueaiYMKjeYvLjkNJN7Foch7cKA6u1HzWwMnwpjHL2emOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com


On 10/25/2024 8:34 PM, Matthew Brost wrote:
> On Fri, Oct 25, 2024 at 11:27:55AM -0700, John Harrison wrote:
>> On 10/25/2024 09:03, Nirmoy Das wrote:
>>> On 10/24/2024 6:32 PM, Jani Nikula wrote:
>>>> On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
>>>>> Flush xe ordered_wq in case of ufence timeout which is observed
>>>>> on LNL and that points to the recent scheduling issue with E-cores.
>>>>>
>>>>> This is similar to the recent fix:
>>>>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>>>>> response timeout") and should be removed once there is E core
>>>>> scheduling fix.
>>>>>
>>>>> v2: Add platform check(Himal)
>>>>>      s/__flush_workqueue/flush_workqueue(Jani)
>>>>>
>>>>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>> Cc: <stable@vger.kernel.org> # v6.11+
>>>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>> ---
>>>>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>>>>>   1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>> index f5deb81eba01..78a0ad3c78fe 100644
>>>>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>>>> @@ -13,6 +13,7 @@
>>>>>   #include "xe_device.h"
>>>>>   #include "xe_gt.h"
>>>>>   #include "xe_macros.h"
>>>>> +#include "compat-i915-headers/i915_drv.h"
>>>> Sorry, you just can't use this in xe core. At all. Not even a little
>>>> bit. It's purely for i915 display compat code.
>>>>
>>>> If you need it for the LNL platform check, you need to use:
>>>>
>>>> 	xe->info.platform == XE_LUNARLAKE
>>> Will do that. That macro looked odd but I didn't know a better way.
>>>
>>>> Although platform checks in xe code are generally discouraged.
>>> This issue unfortunately depending on platform instead of graphics IP.
>> But isn't this issue dependent upon the CPU platform not the graphics
>> platform? As in, a DG2 card plugged in to a LNL host will also have this
>> issue. So testing any graphics related value is technically incorrect.


Haven't thought about. LNL only has x8 PCIe lanes shared between NVME and other IOs but thunderbolt based eGPU should be easily doable.

I think I could do "if (boot_cpu_data.x86_vfm == INTEL_LUNARLAKE_M)" instead.

>>
> This is a good point, maybe for now we blindly do this regardless of
> platform. It is basically harmless to do this after a timeout... Also a
> warning message if we can detect this fixed the timeout for CI purposes.

I am open to this as well. Please let me know which one should be a better solution here.


Regards,

Nirmoy

>
> Matt
>
>> John.
>>
>>>
>>> Thanks,
>>>
>>> Nirmoy
>>>
>>>> BR,
>>>> Jani.
>>>>
>>>>
>>>>
>>>>>   #include "xe_exec_queue.h"
>>>>>   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
>>>>> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>>>>>   		}
>>>>>   		if (!timeout) {
>>>>> +			if (IS_LUNARLAKE(xe)) {
>>>>> +				/*
>>>>> +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
>>>>> +				 * worker in case of g2h response timeout")
>>>>> +				 *
>>>>> +				 * TODO: Drop this change once workqueue scheduling delay issue is
>>>>> +				 * fixed on LNL Hybrid CPU.
>>>>> +				 */
>>>>> +				flush_workqueue(xe->ordered_wq);
>>>>> +				err = do_compare(addr, args->value, args->mask, args->op);
>>>>> +				if (err <= 0)
>>>>> +					break;
>>>>> +			}
>>>>>   			err = -ETIME;
>>>>>   			break;
>>>>>   		}

