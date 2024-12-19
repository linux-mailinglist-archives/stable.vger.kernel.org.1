Return-Path: <stable+bounces-105364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B19F864A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0CA16E449
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE91BEF67;
	Thu, 19 Dec 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPfKVo9Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99B1C32FF
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641381; cv=fail; b=Zxsn8epy1gOIm7oQXMEsE0y/TYCmy46ij5p9VIOYjI+GdYkgzqS9FeApT52lENHOg3eJSh1qEMSJ9MsNUEcSctdolKz48iD894v2c7v4nXIjXyJ5dt6aICVUPaaFHyEv2OJv/tAWOCCB0nU2rFdrAcf+oBybB8XzL6QBII4vwA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641381; c=relaxed/simple;
	bh=iBEbrE69psKfEsf9NGF799RQ0Av4JR+cxTfi7LzRJdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fsJPnM92/8PjV8oap7vyR2yNfSMEJ92CakxdIPtiHNnPcAjPmSBVyU8EAzoit0kUhzrm//fj1vUuYXpnNDSlm0LkacekiTe/tV6HPToFtpEJiXO1UY73Ts4yK1azC/irfyXgTfdiaRklgnNf4VfJmGKl5JXGsnPdLWd1LMJOMww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPfKVo9Z; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734641379; x=1766177379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iBEbrE69psKfEsf9NGF799RQ0Av4JR+cxTfi7LzRJdc=;
  b=IPfKVo9Zuwv7d061S7EcfdgL7ttiudgp4W4FCddQvsBOJwoE8fmlN6mg
   +WHfM8TP4CLlFU3ZQRHBPPTSobcxjKtETxfdyjh/rFbVL0J3gBKdgbzyc
   u7gjWpiWjaTGKtq8AUJiF2UnP5UZ6peJKjifI+yxjCSXyEQIaJmY25SrT
   k/lEI5017o34Pmz8lcgQO4Ksb7rZHAvzzWHOCZ9Eaw3VbokpsUAdtMmEJ
   WWR3x9YKAyr9NK80Z7OlBZ0O67eRVuu/UK4Q/4fvTShV7Ee2JtnDe3DIa
   /Bjtzi4AoE7/3jo1CNy9ZWQipYWUwvIv8xWhHMz81uDb+81E1Oshnntmq
   A==;
X-CSE-ConnectionGUID: mlJU5b31TvG3Fc7/4WuxsQ==
X-CSE-MsgGUID: BC1UxZ4AQSKWaFGJck8U7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35340552"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35340552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 12:49:39 -0800
X-CSE-ConnectionGUID: SFsjJG3yRpqgy9kRu7xoCg==
X-CSE-MsgGUID: ugGSZ22PSP65Hq2tfZ+fQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98207422"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 12:49:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 12:49:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 12:49:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 12:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUe2EZszqTW/cJLVW/V6f82g8O3LrxNAJTXvUNWISUoasDdekW74vD3mnXNSSoOpaV6yNnQGShrvDYX4xlctjxlyDFKBgprcz3SepqJCeM3p+a0iRIIqyasEKE90i+8Zb+LQiTSrmjRkl6DTult9qJ2Z7K3xavqV4Zyu/8Knxw8Yz3081QUNZ8gNqQljrtLx43MzyPQU/oZVGu+neaFkZwQAGd19Ne9vA7UIl69ipeB6locqjFr6rLJK8rfJaExj3BaLJchPP1Va3O5vjY0rrLcLFPui3HVjJtISNpaVrq5JJM0LWHb9SDmW9OaD2dCE39uU2MtRShDJMZTmBxLmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv9EYiMDR/7yfmiVi0ZT3UQtxbUR1tMZcPBYuBli3l0=;
 b=jtr8O8Py3p/5gVYYs4ojnjT+uzgbPYNRQHo0iqan0OkjBUN2VmNYwaOFCx1X60FivO4IgfZSIPWHM7TNyiUt8SJQiLZolV82Y7/qnL1/7XOeyzI39ThInc4FhUWOaJGeYHP7UNakRKbrRsRJK/BWaXmbJCRxTXFaPWaY/ilrl3pqGudZkjEbH1GT4Il3GAkxsasicm48PFQ+P8mMVCySN9Ux+xo2Kk5n5jsGf2gxzLvkebzX7GffFD4MCSyIKOB39bKEsqwKXcCY+ehN/yq63i3dewCvF1Rh8hWK8c3szF1LWtRhYjXXMYk/vdaspapzdTYrjOG2a1eqT33xtyugBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 20:49:22 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:49:22 +0000
Date: Thu, 19 Dec 2024 12:49:16 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z2SGzHYsJ+CRoF9p@orsosgc001>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241212173432.1244440-1-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|SA1PR11MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d235632-31b5-4aa7-74de-08dd206e9d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW1MRUVmb3lqTm1aeVdtalFuS2FBUlpBTFZYanNHQkZjY3VCditCdkxQVk1x?=
 =?utf-8?B?U2UwblRXZ0VQUjhINmN6cTJjZ2lmN1M0eDRtdjF4TEtKMlhtVG5xTHZ0MG13?=
 =?utf-8?B?Y2l1WUdKWFRYOGdGYW1LV0k2VXRaeVNwYkk5cnlGdEprVHVGeFovTk9ITVAw?=
 =?utf-8?B?V2xLSE1PNWlTR0dPVE9EVjRYRXA3K2FJWU1uZTdwOXhnYmRoQjRvRi93eXR4?=
 =?utf-8?B?RzIwSDlZUjVNN21zSXI3Y09mMmh5dnRhbGJscXBTYUEzL2krcHY4K1FyaktK?=
 =?utf-8?B?cVBXWndObG92aFh4VU9mT08yNHU3SHRTdWx6NW1sNFR6SGVMUWxpekgrUmo3?=
 =?utf-8?B?WDNCQTg4czlpVUtESVVLOUMycDRiakRsOEswS0swZlpTNUxzbVhZdjhhZGtx?=
 =?utf-8?B?UjFoR2JLTG5DTnUrY3N2cU9Ccm1SZUlubmZ0a2Zna0VUS2hsNmRWTnBPQU9M?=
 =?utf-8?B?SmdHQ210RzMydzB4S0FTV3RqampUcTFpbnU4RUxWY0VNV20vV2luWTVYVkNs?=
 =?utf-8?B?b1ZFQ0ZWUHlvTWU5bjZuSzRUMGNTa2pLUjVFQitiNFcvV0RUalBaRGNQZllP?=
 =?utf-8?B?bDdjOU9za3lxT0ZLRkl1QWZJUGYvbmNFQnRWcjlXNzc5ZmJMRHNYY1NhSXN1?=
 =?utf-8?B?TjhqQ1VqeXhNTEU3NzdjUXRLNGRldkpLV0NZVFl6M0FXb0c0LzdXQzA4YXF5?=
 =?utf-8?B?dUVoMWpmWGg0ajJmNm5wNXRRLzVvRXh1Uk5BNm1kbWNPd1IzSEVHQndwdXhj?=
 =?utf-8?B?VEh5czVuZStYaVNTaHNLelVWemtGUzdZSVc2TEpibzFMbW5YeEdvejVlaWht?=
 =?utf-8?B?MkJ1MVVuNEdXTzdzeDdyNCtyVjFTbnlObVIvSWlBQ1I3UlIzV2dFMHpHWHVk?=
 =?utf-8?B?dDFMaUpkKzRRYVd3Y0NaTklRN3lXelZrNW1GUi93S1B5dktrSC9BTFIra2R0?=
 =?utf-8?B?Y3NaSCt2S3VlMHNiU3VyZEFCUXFHUzYyVWlQZGRGQnJqcHRzOHlXaGkzbmE2?=
 =?utf-8?B?MEVwbERBSWNnRVFuZnZKVDRDT0YvRng3SzlXWkdSN1cyb3lvdlZkL1RzYU9G?=
 =?utf-8?B?ZmZ1YVI4eVl2OU0xWTM4alp3bjFjMVVrdGkyWnRza3pJSmxHWWRXbEdZMk03?=
 =?utf-8?B?RTUzUlZXN2htUHFCaktqUUluVENWZUtlditTMW1wT3FYK3lKOTZUV3hwc0Uy?=
 =?utf-8?B?OUxFZEdiMVVNS0RrNjhtSTArVVcwRk1NcEpQSWZKb2RabDRlT2ZwZjh4UHQy?=
 =?utf-8?B?V0syakhDMTRnNUhjMWp0QXRpOGNoWTYvTzBZZ0liMjVUUG96eWQ3Q1p0bEpX?=
 =?utf-8?B?bzdvT2R3VEZDUTBrUkRrdm9vS0JMRTQwQ3loSzFFOUVkcEZpM0RIMXIvZjZN?=
 =?utf-8?B?WVNFUjJxSDlCRVFqZi9UWlFUbmtKTlRSdWhNZDRKYjkrbWV2cWFxblFLenN3?=
 =?utf-8?B?U0c4cEVEcEoyczhwTWxVaHFjd3FFQm5DNXR0bzA0WDJhczVXRWdtNTBCdGN5?=
 =?utf-8?B?RFpqU1YybnoyRklRSDZIdE5QRUlWYm9vL2dMWWE4bGZ6bTV1bzIyYnlETnhH?=
 =?utf-8?B?ZEszcHFmSlJ6ZFBaNTY4VldXeFZ5NFBkR0lIMWNBUUx5bGVvZHBjeUtOT0tN?=
 =?utf-8?B?bmR2Y05qWlFwWVNscUpnT3NycmwydHE1eEdCekpjQmU0TlJBOCtDa1E5OXNy?=
 =?utf-8?B?QjRDM29mRkhYOFA0UmszUlVwZHgyc1NLWDFxRi9JWW15bnV1bW9neTcvcThk?=
 =?utf-8?B?ZW9rNkg1RkxiVTUwTmV3MWpiQU03SGR4OGNsOWlFUlRVamRWSHBvYTRDOWRC?=
 =?utf-8?B?U1pMSW9zNG9HeXhwR3NJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0pKWE5UNnN4M05xVEVqTi9xUnp3RCtuQ3loUXJZb2J5Q1ZWczVKRFVIRHp2?=
 =?utf-8?B?dHh1anlmMkYvRzBsazRLQTM0SkhpU3p1akFpR2oyczYyWWNRUHAxTmRuME9B?=
 =?utf-8?B?YU02VklQcHZTOUkrdVJFN0tacnNjemx2M2hOZy82bno1dlBwZ2dvU09kRUx1?=
 =?utf-8?B?MFJVL2JYMFI5SGJxd0o0a3pZMnBzTmJCbTBGa1pCcEppQ01KZmVLbjc5c0NJ?=
 =?utf-8?B?OGtGY0NWNWpLUTJxUElqemp2VDlEMnVHdHd2U2lnRlVMYUpua0x5dVVRc3ZG?=
 =?utf-8?B?dzFrbmpQSzFVRlk5MEhJMnBCNURGcnRySE00Rm1Va3RVaElKMENURkIyQ0Nq?=
 =?utf-8?B?QytMVHVKTmJxNC9aUC9DczlIY29PZ1M0YWhmR0ZGd0hwK3hEazk0NFZSazRn?=
 =?utf-8?B?ZWYrY2svUm9EcXBCT3ZRV0ltVkJQZDRrVURVTi9WS2hjV3QrRFk3MEptVGRL?=
 =?utf-8?B?NnQ0K2lzcEc4MFB4VGV5eW0xaTZnQm5MM1JBSkdlTGx0cUxBVzcyVUowcVUw?=
 =?utf-8?B?ejZtNzZDYnRBeWM0ckkvU1FEczl6T3pwbXNYRm43QnFqU09qc1dCd0dXR1h0?=
 =?utf-8?B?bUNxQUp5VmNSNEN1cVZHWHVlSmViY1FweXhiVG1Sb09lVGd1clVhOEZHWGRr?=
 =?utf-8?B?K2ZYTlVCbVpIbENUQnB5SjJhaW05WkpQUHM1d1o0aWdLZHZXV25KKzNMQlJ4?=
 =?utf-8?B?TzJWeHA0dE54SEtwUEo0RlRUZEM0Y2VDdHB5blVTcmVkWjU2bXVKWjFKb3lZ?=
 =?utf-8?B?T3luZlQrY0pMZUszN3NJVWxFRkZGTWdBTE5qS3dBQ0FicXFxQ1Myc1FUQ2xo?=
 =?utf-8?B?aXFlRGNRbVNQaE5RTmFxUVBlVGU5MENGR3pVc0dtNE1MNjlZOHo2ejE5MTl3?=
 =?utf-8?B?a1JyZXhIYUlyKzlmVVVQc1ZrMjc2SzZ6bHhBVHlYay9tQVRSR3ZZcjRYS2Nt?=
 =?utf-8?B?clpiamZIRkgyekZ0OUFzM1NjSGVDMENvMmZuYTJQc0pVeVZWNWhQdk9KaFA3?=
 =?utf-8?B?djRLbUJuakxJS1lTSzAvbmpTOUViSEx1VFh4WCtIQ0xGNHloeVUzSWl6cU82?=
 =?utf-8?B?WGNMM3gycHNXYk5YNnNzc0pOaGprKzhiVjJmUHZXK1NUSEU3cytWemhNcE9m?=
 =?utf-8?B?Q3dGcStZVnJGTlVqcW5FVkNBZTQ2c25RWHdiRVY0UnkrdVNMUnJRTVNpREtC?=
 =?utf-8?B?K0lUVzZmdlNBUzhxMk94cm9DWUdRTk1SdlcvSW80N0pjc0ppOXVOaEVGRnJ2?=
 =?utf-8?B?dmkvVXg1OERkYkJnVHFSN3Q1cFF3T1NGNEdxM3lwYkpKNnZyUDMwUHVYZktP?=
 =?utf-8?B?RTNHMVVqTUlmQjBTYmg0NHN4K0VvV2xtTG5PMmJsbHJpOHJlQ2doeDJiSitE?=
 =?utf-8?B?TVNNYXdYU3gzRXlWSG9hbmhqRlNZb0xHRUF1UUZselpMcmVBblhpOEFaVkVl?=
 =?utf-8?B?YUYxL1NoUDZEZWR0WFpVcUlhMnVqSGZVQlA3Y1VnbHRXRWxmM1BMSzZ0enlj?=
 =?utf-8?B?b0VsUTBqNG5weDZwRmsvRlBIYW9yQllyMGkzaHNjSnVJWDJWYWozZTRQMWE4?=
 =?utf-8?B?Q0NTbHJhNjRZcnNiWnRoeG5ReEdLamI4NXBBOTNOblFrLzhXSnlWMDJ3OWdM?=
 =?utf-8?B?WWF3WStFWFljRGlocitqV0tBWmVHd09XcTdZaVpUTnlJR3R4SGk2L3c4STh3?=
 =?utf-8?B?K2hmMTY3czNiR3g3M2RtR0wyWXk1UWNKVGVXeFJjcU5SQ2paWTlkaUdhMHFG?=
 =?utf-8?B?c0IvaGl3VXZ2MWovYVJkSFdDeDJSQlpjZ0xCRU0rVlhYSWV2NWgzazQxdmJ6?=
 =?utf-8?B?WUROejRjdHkzS2JBc2lpYTZMcC9nSDFDVlJCQ1ZmNzNIK2hhWnZEUFZybXND?=
 =?utf-8?B?dDZiMG04QWtYN05Ed3JXUm85YWg1U0ErbHozbUNSME9QVWV2Qm5oTHFteHJw?=
 =?utf-8?B?SXAvWmxGUnRUQnpWby9Vejh6OWs3R0ZtdzZZM005UFBhRFVOTFhJeksrRmc0?=
 =?utf-8?B?SjhvRXRpSVJyYjVLY0dHTUFBUW5sbURJUnc5NU96RWo4STdqQ0JYeHFkL2Qr?=
 =?utf-8?B?emhkeFlGWmNISjdtNUdKWDVPMmdaN1ZudlFYSkxDbUM4S2ZKWkxmZzFRZUZw?=
 =?utf-8?B?b0tIclROQ3g3NnhTM3dwWitRbUdwWUs0cWRveU5TZ3ZPSjRIeDd5bFY0Vkk5?=
 =?utf-8?Q?EtLGKysxOPpVG90DkGQaapk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d235632-31b5-4aa7-74de-08dd206e9d9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:49:22.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RmFgKxUgqi4bGJi/gOgieVkBgOsr8UY6KaTUBPpkZieOHR12nrvIjeYwptNJSZOYMtPKjEfrAILnJ6QeK09eI9tI9hSlY32rrJttzTgC1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
X-OriginatorOrg: intel.com

On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>queue file lock usage."). While it's desired to have the mutex to
>protect only the reference to the exec queue, getting and dropping each
>mutex and then later getting the GPU timestamp, doesn't produce a
>correct result: it introduces multiple opportunities for the task to be
>scheduled out and thus wrecking havoc the deltas reported to userspace.
>
>Also, to better correlate the timestamp from the exec queues with the
>GPU, disable preemption so they can be updated without allowing the task
>to be scheduled out. We leave interrupts enabled as that shouldn't be
>enough disturbance for the deltas to matter to userspace.

Like I said in the past, this is not trivial to solve and I would hate 
to add anything in the KMD to do so.

For IGT, why not just take 4 samples for the measurement (separate out 
the 2 counters)

1. get gt timestamp in the first sample
2. get run ticks in the second sample
3. get run ticks in the third sample
4. get gt timestamp in the fourth sample

Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for run ticks 
delta.

A user can always sample them together, but rather than focus on few 
values, they should just normalize the utilization over a longer period 
of time to get smoother stats.

Thanks,
Umesh

>
>Test scenario:
>
>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>	* Platform: LNL, where CI occasionally reports failures
>	* `stress -c $(nproc)` running in parallel to disturb the
>	  system
>
>This brings a first failure from "after ~150 executions" to "never
>occurs after 1000 attempts".
>
>Cc: stable@vger.kernel.org # v6.11+
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>index 298a587da7f17..e307b4d6bab5a 100644
>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>
> 	/* Accumulate all the exec queues from this client */
> 	mutex_lock(&xef->exec_queue.lock);
>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>-		xe_exec_queue_get(q);
>-		mutex_unlock(&xef->exec_queue.lock);
>+	preempt_disable();
>
>+	xa_for_each(&xef->exec_queue.xa, i, q)
> 		xe_exec_queue_update_run_ticks(q);
>
>-		mutex_lock(&xef->exec_queue.lock);
>-		xe_exec_queue_put(q);
>-	}
>+	preempt_enable();
> 	mutex_unlock(&xef->exec_queue.lock);
>
> 	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>-- 
>2.47.0
>

