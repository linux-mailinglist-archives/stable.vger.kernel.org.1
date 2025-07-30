Return-Path: <stable+bounces-165538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65631B163F7
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B53BA32C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79A2DC35B;
	Wed, 30 Jul 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyjfQCVn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51AC2C9;
	Wed, 30 Jul 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890898; cv=fail; b=SLKuM9ixMk5jKkpb70gEUy/GU49W2ZcQhOXHsMVALo2etbSIkPy3pcSLio0Wk/dzVJDQxWAPH1d6HcmxkkIXhjeEe8CgY3Na2yYSCrk7Jphqfx5BHY3VcGDvkmLTV4zl2jA5wyv9iTEMhbFtNxAurN7c0lpkBk3ZY1HEDuel7+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890898; c=relaxed/simple;
	bh=c5FGo1ZvcZEHMRAkIdEaW+x6uUpD2EaeP8do6vqrMe0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0kwsHD6YBE3BOzervJNH8mXLt5fxqU6fMMeVDJxCdfTvgRVnnMukJXSstdde3QbGojWjPQqtFs6hvYq0NxPRY4LrVZB6D5jt97JUskeguDUvARPYwR2SyjHa4aquV/w2m1Ur/CtMPIy2hCEO3rSOdnjbUadudllqaDHOGUVG7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyjfQCVn; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753890896; x=1785426896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c5FGo1ZvcZEHMRAkIdEaW+x6uUpD2EaeP8do6vqrMe0=;
  b=DyjfQCVnb0QGaxhjFub52jr4Myeb8z9Op/9w5Rvlw0vSQwWgi7gPPcbr
   zjyrJj7vCySdK3+ZncsvFujs8gCtnlr6BXzZ86mFiZN6C58BaHDYt0X/d
   wC0xFLbu+q6AEC9nuBC4+FVmKr/iBgVpvdjMIUF5wRyHDSbBV1OENHzia
   tNFMCOk4KzrtVQaefgz/rKwr7+B40gmmG2C02FYLtY/hLhTGa7A+Uzqs+
   5t8f5TCoJ+1r3o0R3NpSbrTPwLMN7+BR6DEFmrsCUsMJqDiCA5RfqoTVO
   9SX89i1SyvAA++fsCWb2vpCcj2ZkhdXntGOso0Tqp4nMj5tOE5/QsODce
   w==;
X-CSE-ConnectionGUID: Y7scC8nET5etO9G8lBJ65A==
X-CSE-MsgGUID: iVr/9tKqSsuzAS4kYF0JBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56276368"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56276368"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:31 -0700
X-CSE-ConnectionGUID: fpGY2HI4QmCUjVXnAzrMiw==
X-CSE-MsgGUID: puuie5A1ShSoDal7wrDrNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163048231"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:54:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 08:54:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5aNvOU2fkdsdHzmBD6FaHJxhFRoGXGs6B94oluhx0KsTUnZH+x2fpzMHtAhoezWbGz25iVLu+IBil3mOpPp5o2H9ZPHTCMckT/DyomuQWU5svRrmTaQZXrqXveja0qrQKatiICYAN5EY95wMm2XwErVhlBDc7QZmLITlmIgG+76MQzTo76Q6XMPNWB0vQK33cFbCs8EMtrY8OzaT1teXNjBbhKB9hQZdPNUXl4Dj6SCKjvgPAA0W58g5Es9wZ8hJF24fMt1jUfzxDLJ8hx6UH6LSbn40KmyUqzhlqc1T0a0K0RnKIrw57nrCo8JHGtIzJbkhCJ1YEhbuXGJcl81Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEzQTowvQymY1m7ZHx6XEkryb4k10cKWFoKxUI4Xu1U=;
 b=yc/acngOv82wIf0qxRnrmpt+7g0olQNNQ93vxub6My5vWSydvM3msTcSUynR1BD+3jUtOLlP9gHukcU6Hl+k2CbbedQda6kAfBD0Z4l+qtKVJdDy9NI8YpaRLYPGBeip7j4ipUSCGPzlo3pMnduKo83QW9PUwki5yuDTRHF3yrNMonM+h1n10MuSr6/FtcYx+23Bz+/oU8wLliuPt7k95NvlOCuBr+7DT5HMHx+HaC0xif26LGDqb+Ssf1D00rJvNflLDe2n4Zym0SQO/uOvXhgQo/IE3uq+vgjLoibvnsR3cbk0NhDMB73VAhjLER2t6NU3K+/Zh3o25MEla2z2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 15:54:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 15:54:04 +0000
Message-ID: <a7ba16c8-e6ab-4ca2-bf7e-8719c469f59a@intel.com>
Date: Wed, 30 Jul 2025 18:54:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] mmc: sdhci-pci-gli: GL9763e: Rename the
 gli_set_gl9763e() for consistency
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<stable@vger.kernel.org>
References: <20250729065806.423902-1-victorshihgli@gmail.com>
 <20250729065806.423902-3-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250729065806.423902-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: d84bcce3-05db-4c4c-a22c-08ddcf814efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1ZOTXFnVnBOMDlPMkVJamNZaTVLc0FsYSs0LzdOV3JNa0I4MjNNVVo2YVZN?=
 =?utf-8?B?bmpFREFjMFZLdzlCb052Mm4wcFZLUmRkL2wraG84bXNZSTB5aHhYQ0U2SXF1?=
 =?utf-8?B?bDA1UFN0Qmdkdk95eGxpYWZBK0tRV2lEaUZXT0ZqWDRPL3g3WHVjQ2RmKzE3?=
 =?utf-8?B?aWRrZXdKa2luNTN1QTBQZGxHK1pRcy9aVkFSNmxzcStObzRNV3AxVW56K2F4?=
 =?utf-8?B?MDlsSjN3U1ZYbWRYTE8vRFM1cDJTdzhod3U2UXhIWjJpd1c0bTQ4dmM0Q1Fz?=
 =?utf-8?B?eHl6dlpsb0k0QWJvM1V4aEFOR2JBMHE5K0pncUtUdW00Zmt1TVNROVNiUHlV?=
 =?utf-8?B?Qy9Xd2h6dDZZZEh1TmxyVjZnOUFYTjZTNW5oQXhYb3NTZHVmNlkrK0J6SE1B?=
 =?utf-8?B?RGJEWVVaOU1RT2NMcmdiQ1h3MU5hNzBRRU9hSVljWVY1R1RpeHQxOVRoQWJS?=
 =?utf-8?B?RnRTY1RINkNoYnk4TzRuT2xkdG5FdVgxcVRYb2Z5WnJ2UW95b2JMTXJsTjFa?=
 =?utf-8?B?V0dIVy9SZDNMTTcvOVVVUmx5S3o2Q0xiaTJwNTdaaGl5ZFB1YUhab3R6d2h1?=
 =?utf-8?B?dTFaazNMVmFzaHF3YjltVlFUc09kTzNYM25wUUJzYXlQSDRMa1hzTjNrU0V3?=
 =?utf-8?B?ZTFhSXBhTFgyU1hxWmZweGJaTHJlYnp5YVFWRGJjUThPSkxsVTczbEtmTkRY?=
 =?utf-8?B?cStJQXFPRnhRRVdOUWphZmlkVG4rNzYrbGh5Wk1kUjlmdnU4eEJGT2tXTlB3?=
 =?utf-8?B?eVRvZmdya2dabG1xN3A4UUpZK1N4WDQ4bGpIa2V3RS8zWkx5R2VXVmpqa08z?=
 =?utf-8?B?Q1VuSDFZWnd5dXpIR2Jtby9Hb2hIWmVXZUI2b24wanczSmxoV0E1Q1NXcWlu?=
 =?utf-8?B?V3NwQUlSNnE1T3piSzZyZzhsMWxDNnlqRm5NWGh4WGtERDk5Y1NKK2Z6citS?=
 =?utf-8?B?R1N0TGNxRVplcFJnUnRTVWo4N2QwZGk4QWtoZldDU3IxY2l1WGt5dGRLalp5?=
 =?utf-8?B?ZjhxdXB5YVByMW5iWnhsWFlNdDMveHNsTnNyT0l6QnBlT2Nwb0YxdGN6TWdV?=
 =?utf-8?B?T0Q2M3ZPOEVSSm9ockNGbUZxWHJ0UFVjKzlvTk9DRTRFdm5QSUtmS0lMRUov?=
 =?utf-8?B?NXV5MllEQVJIb2N4dFpTRzlBcWFXc3g5MXlscGUwV241VXBiNEpLOWQ0eWZr?=
 =?utf-8?B?b1NQcnpTTytSdG5BNkhFUjFXWkh5SWJDZEVEdDJBckVaRnlUMWZUMkV1MGlZ?=
 =?utf-8?B?RncvMkJGV2ZYejNienArUERnMHQvaXljd2MybmlNNzZ5NVAwQ085Yksvb3lt?=
 =?utf-8?B?NmhaMXl3ZHEvNHpha1hxMnFpc3V6WHM5ZVNmSXlRNFI4UzBXTzJ4VTBuWVRy?=
 =?utf-8?B?RWZFRFQrV2NjbURBSytQc0FERzdxQXhmeWRYSlQvd2xhTmFKb0l5TG5iYWZ5?=
 =?utf-8?B?TVEvU0xTdHNtTmsxMSt4M251MzF3cUs4a3RNVVVrNEpZQXNFK0c5YVkzcVVB?=
 =?utf-8?B?S0d1YkRrNGZINWtPbS82VWZmeEtaN0pwSVdkdnpydGVzMDMxejVlRnNPNG9i?=
 =?utf-8?B?Uko2d3M4bDlodFU5YzZZUWM5dThRcWxIRXQzY0JlUG85cHJwNUR2YVBFOEZR?=
 =?utf-8?B?MUx2VHVwN0tRbGc3Sk1QOStDdjJEQXdBeXp2RWlxQ3NreTBoSjRvWVJoVXQ4?=
 =?utf-8?B?L3c5YmRuVURmbkpwY05EVVhDcm14VTZMNVlKYWJySUlVZ3EyLzE4M3MyVmN2?=
 =?utf-8?B?MHFXRVVNU3d6RTNzcGE5YmJ2NnZ3RWJiS1FiVkVHRlAxVFdVeGVZMXhWNnl3?=
 =?utf-8?B?NlVKd1Y0akZneVJOeXFDK2RseVY3QXF0alJQVkd3N2JUaTEwcHVCSkpNbHIz?=
 =?utf-8?B?M0JIUzRPRjlEcHA4c2hrUERIandZOC9Yamt3d1VxRFBDNG80V2MxQk9pTnhU?=
 =?utf-8?Q?thkZgnsGx8o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkN0REttbnRDTlJOemtpR2cvcmRaOTJUNVA1ek83S0d4U3g3ZjFjSjFpV1J0?=
 =?utf-8?B?Vmo1UWFGelQwV0JEYnNQdDNIdDcwRmxGMTMxUjk2dnhoUktVWWZPTnl0Z2xQ?=
 =?utf-8?B?ZmFvNk1QdE5DZ3hUak4vYjNKTlZWVHN3b2tyY0tVUWQ2c0VWTjNydlhRbWI2?=
 =?utf-8?B?SDZxSHQ5RFAwVjE2M3RhT1IzRDdLSytRbVg3ZXhpaURaZVVINHI1SFNRRTBh?=
 =?utf-8?B?QzhSdjdENEEwLzQ2d3R1NU9MUFBndlBOMWVlM2tJcVcyY2pNeGUrN0FRSVpt?=
 =?utf-8?B?a0lScll6QnY3K3haVXVXamxmUkM2dTUxVDQwRmpXZGxQQnR4RkZVbURoMGN4?=
 =?utf-8?B?QjFidldoRm9FaFRPcnJHdGJFR2paeFZoMTlIaUxmcUY4TFlTQ2N6OGF4ODdB?=
 =?utf-8?B?RmlCdktMSXcxalAwczNOdEZwTXB2cG8ycGZPc1QwdzhBWDJPYWpTMUdHMWhs?=
 =?utf-8?B?cDlFYTZGUCtxc2IwRGsxaHc5Wksrbmk3ZTFqdi9XejJONzNnV2ZuTWhPdGFE?=
 =?utf-8?B?cHVtSlMrTG5yTmlQdmgzK0NEd2UyeU9CcStkcHpMNVBmVWd5SG1EaXdYYnhp?=
 =?utf-8?B?V05PY25zNUh4OFBjTlVnWG1mc1VjTjZVSlRNZjZPSkJ5VGorQlA0SXBmbnpo?=
 =?utf-8?B?YW16cmI3ZkRINlVDcG10cVcxYlZteURBY05YUnBLT2pTZTcwdGxYVnJPVXRw?=
 =?utf-8?B?YWdMUnVya3pQZ2FIaFhuVFNwd1hLOXArNGpNQUVXNVNhQWJKbTFSSnhwU0x2?=
 =?utf-8?B?Nzd3SXh3U2RVY2d4WGNWTmIzVHBHTWJFYzk2TzdyVHNHWU9WS1NvZnBjM1du?=
 =?utf-8?B?QVRpMjlSaFk1bVIwWTNrOTNEdHhWeWduMU1nblV5eEJENlR0YU4rNk9DZFZU?=
 =?utf-8?B?S2pjZG1hQzROUmlEM0dNVkJDVmc3cXAxRHlBZVJUZFJ6OEpmVExmZXRNYlJM?=
 =?utf-8?B?TE5Ybjk1b1lxZVBoc1NqM2tveUlkR2trakdBbmpiVUdnR2x3S290SmF1d1pU?=
 =?utf-8?B?MTh3dUN4UXRwVml4eWhYc3JQYTdYQzNzWHo5UkZmWlVqYzlsZUwrcmV1UFhV?=
 =?utf-8?B?YkM5Y2FzNXh3bDhiK0laeE16RWhKMk55b1NXSmpReEU5SHhrZFVoZFViOVRO?=
 =?utf-8?B?VjBES2pzZlhYUTVzcTF0TFdPdFFvYUJrVVNtbm0vZ0dsaDFQNVlqS0Ywa1Ey?=
 =?utf-8?B?VUpXa29JVjcxZkhtMEhZOXJiWEkxWEMyTG90eVZTZFh4U2xkUks1U2dxdWVh?=
 =?utf-8?B?OVlEOGVKOWhCQis2V0hGaFQ4cklKcjFId05XNzVOZlQ2SHVaNlNrWjVBSWFy?=
 =?utf-8?B?Z083SDlacDJxR093K3JSVnIrRnZHWXJTRTBidmZsaUQyZzZ5QnR2UDdaUDhv?=
 =?utf-8?B?NFJFdzB6T05NcGhRMmpGNmJzWFlucWl1bjg1T0FXWFRqS1BDQVpJMjNOWHBQ?=
 =?utf-8?B?NGlJUHFGNGlGS2x4eGRmdzJLMjFxMmM3amxiQlBtbWJsVzg4ajVTTk54MkVa?=
 =?utf-8?B?OExUV2t1TTRvRTVhRWNTNTgxRnRoQ2tYUmsyTE8vMkVZcmxFM3l4NWNSakoz?=
 =?utf-8?B?T2FjaWZFV1JRdWgwY1YyNVlNVitKL0tFV1FWUTJqcmFCUnl5emxzMTdsc1JB?=
 =?utf-8?B?R2dEeTFnTDd6ZEJPaVVlZFE2bHA4ekxFWE1vMWtRcm1PbS9WWXd3QWZneHVV?=
 =?utf-8?B?citQVXpmbnJVN1IwWHpYSGVSaGZzYUY0bDVWaHoweGQ0K2tGTlVhYVhkOHlo?=
 =?utf-8?B?OUkyTDFvZ2Z5eGpqMW9SL3orUWdPRWV5bEc0dkNKcm1PejMwaWcvS2h0Mkdm?=
 =?utf-8?B?TjB6bGV4YWVtZlZFN3ZhMlR5cHVQWGRwVG5NS0tvcldWbVVCR2RSRTZaalBl?=
 =?utf-8?B?alBEWHJaZDFNNmxITUZEQnE2eTRrR0tvdFFPa2RGd0ZPMTZSSHB2cXgrdXFJ?=
 =?utf-8?B?elZSRE1QdFZhZ1g0SnpaWEdRL2ZLeHc1MXpZMTE4dEF1RXVMckRkQkxkUlRO?=
 =?utf-8?B?b3BQcG1Xb1A1S3grMnR1WXp6d2U2UWMxcFNrdTYxbkhwc3EvenVMTFlzTVBp?=
 =?utf-8?B?VGtKVkRkNzNOODExMDB1WmltOVcxSlBJSzRTWnVvc3NrWWo4T2wreUp5cHpw?=
 =?utf-8?B?eWxmdlJFMmppRVhyVXJKaCs5VVA0SVJDc1N1aFpiTXZybGwvKzRUdVBDMHdQ?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d84bcce3-05db-4c4c-a22c-08ddcf814efd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:54:04.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/R7aoxZ6b4BPBcgQiYyUmtISpNV/MW6+LUAGyJDWPUh6gcYqHklbSwxhFZsI6qLsYDfmC8BZjicxpW+9dOIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7489
X-OriginatorOrg: intel.com

On 29/07/2025 09:58, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 

Also needs to explain in the commit message, why it has a stable tag, say:

	In preparation to fix replay timer timeout, rename the gli_set_gl9763e() to
	gl9763e_hw_setting() for consistency.

With that:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> Rename the gli_set_gl9763e() to gl9763e_hw_setting() for consistency.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index f678c91f8d3e..436f0460222f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  	return ret;
>  }
>  
> -static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> +static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
>  	u32 value;
> @@ -1925,7 +1925,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  	gli_pcie_enable_msi(slot);
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  					gl9763e_hs400_enhanced_strobe;
> -	gli_set_gl9763e(slot);
> +	gl9763e_hw_setting(slot);
>  	sdhci_enable_v4_mode(host);
>  
>  	return 0;


