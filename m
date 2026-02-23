Return-Path: <stable+bounces-217794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMCKDbWInGlWJQQAu9opvQ
	(envelope-from <stable+bounces-217794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A917A4C9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8A0305F3C8
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912331AAAA;
	Mon, 23 Feb 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYFz7/3l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98131AF09;
	Mon, 23 Feb 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865968; cv=fail; b=fTqHsqjwqDrLk6tG0hu+zEmwUegAmcgYhcQ8fHwLeLLcFO+1kFc0dbNXYOQzaKWqYgenVYvqz/MAGRWSSE+yJECJASXGgOPCp3IAxl7HEipUy6x0FzbzKbkQL5hsRZE60b2q8/m8HK5tqTtOAxHC/zMYQVzjSwYetWak80KYvkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865968; c=relaxed/simple;
	bh=r9GeR/JsK3PlSlybZzGqxSV4kxpRvNL8kPPURFpz5ts=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GIqQvNgU6KIrClk7+YRTDvyXOBiAuIaxwnaPv/J6VUKUKHPRUhcZ1pOchaQMoO5ILD/YWlGkudJVH+Zsolqeoy2ZTDGtVR1SKM/L01EkI8o02aBQGGjRxmNbSp+tptHHH7FP3gOLgB9klCk14JSFU5Sy7f9w+uqW33CvD/tl4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYFz7/3l; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771865966; x=1803401966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9GeR/JsK3PlSlybZzGqxSV4kxpRvNL8kPPURFpz5ts=;
  b=EYFz7/3l2bSTFpiOuzcI6T7CXt15dpm4PVbL2vzgh3BQI974CirzxiBb
   1FWlDyNovHgiDCPRUSKNsaYStkJQI33QSZm4iyw4KBOcB+6Bq9TbcAgI8
   dchVknw/7S6c3ChSMnehU9WVGpuj994pydXzAKRT9+XWyiSyuLkpJAfvP
   vPeJ/zjblDvO5YQA+I/7bi8bqw59gkJBg6TupaagxTik4PTL4iwpmEOUh
   TAwH/OeIkwigpv4r6yRKuKmr7OxZI4a37Bbfhe/zzkrfzYQrzZWgLdm1u
   DcRfRGmpij9i8P7Nn09L5+LwJzzG3CvChAdJjmtItuH7CFaqTzTT0Bh1C
   Q==;
X-CSE-ConnectionGUID: IRI87ggcRcKKaTIy56tY2w==
X-CSE-MsgGUID: 2yTRCuuYQRW1b9fstvVWxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90450162"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="90450162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:59:06 -0800
X-CSE-ConnectionGUID: jidBwxXSTeODLxyW4ugoeg==
X-CSE-MsgGUID: V+K3ZisjT/Whsv7XxrGIgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215463933"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:59:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:59:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 08:59:03 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:59:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjLGgN4kQ9vt9Mf1u5gMiXMFO9FbK+R7hbTSRRcTq+Ynr9h8m4TITVG4DXMVJkEGq4IGHqvIZB0qQle6QO3jkbdzN1rvQAL/yCdDMzelWPawZR9YXEAR181ioyf6WWiUaAMkgnN2ORu56trkCocnkZOQQEd3+R0JrRxw0ofyggryUIcDYWe+8m4QSvTiB8M6P/jf3XMJ7Z+Vm13dbGdwFJveqVuBlCknEaI6+MS1lcsb/x/bBBHXzO4uM8Bv9SHy1DsJw0Ngqqx16CDkqAilFSaRjwsRom2DGXieGfrFfqVHVrMu/Aedqq1gTtgsI+M1y53gxao1NzB2FqOE07tVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbEY/wm52+zgt4NDhkMcc6uMrdYxg3c1faYX07XW0Fc=;
 b=zIzuzVi4E2nTElgSlVkzmiW8RLfJTkygiUetYDn8afPFH++2jjXd9AGdGtM/QYn3tEiDqjnxFsOEuXb+7o1QFRmlTcsghBh2kgigjW4hm7gFerwnzXTBG/YUuBCGkuxjZydpNjE9FnyH5tV/OWlwL1tVoNDAZHh8N0Zg+VNiXDep636LBk4WaZGZYDXwuqsIzdeVaq6yUux2XMCRI2tYcpWXnRQJJ8ZeGDJOmzIrLNRk2LgoP7yijLlx3gLogwcMdZPf5mEDp9bmegnPEN7EdKVmucOoAFrYSZdkeppNMKgGIem9cwhuw/qtk2xXFb+mJ73ocurdhmhVNuOW0rrSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA2PR11MB4971.namprd11.prod.outlook.com
 (2603:10b6:806:118::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 23 Feb
 2026 16:59:01 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 16:59:01 +0000
Message-ID: <50c2aed5-2ca6-4a64-97c4-ab87c23ea863@intel.com>
Date: Mon, 23 Feb 2026 17:58:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ACPI: button: Convert the driver to a platform one" has
 been added to the 6.18-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Sasha
 Levin" <sashal@kernel.org>
References: <20260222233852.1322850-1-sashal@kernel.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20260222233852.1322850-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e790ee-2e93-4433-e642-08de72fcd7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWYwN3hnb3Q2QWVOcmUvb0wwdFM5c3BLdGtORzNOVWo4TzNVNWhHMjhBRG1M?=
 =?utf-8?B?VGR3OG5NQ3U2QlNMYk84SDg4dDEybko5eXQ1WFVGOWgzUUlUSlBkOGVHWmJq?=
 =?utf-8?B?MzNaQTZoWmpndjg3WjBMa1pOYmozK2dVdTBSS1R3anlhOWFXNy9RYXRMci9D?=
 =?utf-8?B?cyszL3kzTGVJZWhJdHVjd0xjYXpwZlk3ZndZcWdUZUdIUVd5SFFUT2p1T3NX?=
 =?utf-8?B?ajA0T09GV2hOczFHL0tsVTczdkNQbEx1TW41b1JFUUYwK0Z5eWY2a1ZrSGZJ?=
 =?utf-8?B?MzFBZlNRa2gwY3ZLSHBYdjAxOWRnR3c1Uk40bnNxU2htcDU3d0dVV3FvVS9I?=
 =?utf-8?B?akcxU01tOUM0Rkk2TjJLU2h6WC9LZ2pSaXF3akMwQ05GM3lCY3JobGdscEZa?=
 =?utf-8?B?cjBPaTJhVnYwUGpyNW5FT2R6Q2VBaXRRaWk5cStJRHFpK2R4RXZHQWwxZkUx?=
 =?utf-8?B?RFVPeFEydmUzb3NLUjBBejNwR2tBTGNuNW1pUTBnWExTdFNnZEFhVlRuVUlr?=
 =?utf-8?B?N09QaVZ6YncxbGVxemtUS1BaazZ2NjRGM2VTa3hYUjVqeThiUGUrMllMN2c1?=
 =?utf-8?B?NStxdENvcDN0MlViMERrTGRadVNyM1gxb2tTK0tlUUJqb0NUV1JOUERIYTk0?=
 =?utf-8?B?eXlxaGVYSGdxcjNseTJTa1IzTmFkc3kybWNNQnc0SlNFa3dMdkx1YVljS2ZT?=
 =?utf-8?B?YjZQUDdmRkRScXdQbU96dXB0TWxkdTJ5ZUd6MFhIbmRldDdvQ1MyZWt1K2Vv?=
 =?utf-8?B?NFNqcFRRS0dscHBGalJRS2dFSHNKR2tvaXFxZVNNYjBaVXMrcUlNWmIrR2Vs?=
 =?utf-8?B?QzVLaWJSNTl2OGtnbmlnQVpaLzZFa1d4elFCMjQxZ1VwdTQwaHJ3UWQ0WVov?=
 =?utf-8?B?M0x5QlFxd0NnODBFRmpFaFJ5eTQ1K1kxRkZTWVExdDRxZGpHaGVUNDZpTXVT?=
 =?utf-8?B?cGt4N1VwdFBSOWNZWHQ2RVVCekFJUmNVa2wycHVRMC9VWnh4OWEzOHQ1ejRX?=
 =?utf-8?B?NTM3MEo3K0djemVjV3p6cStXR0ZhSjZwWWVtcmRBYlFLSDhEcUxwOElsU1JZ?=
 =?utf-8?B?and0ZWkvSk9sQm1HZ28yZWEyMm9VNHZOK3RpUzRIN2RqSjNNNTQ3ZjFiN0lT?=
 =?utf-8?B?V0tkQXhUZWdMQVRZbGRRSnM0c3N4VnJsSkNiK3NYbFJxVHJlTFlqenB2aThs?=
 =?utf-8?B?N2JOMzFDaHBxbjY4VThpbExSR2FrU0hQU3NvZWVSZTRJdEdnZFpiQWo3WDE4?=
 =?utf-8?B?Q3M1cU8vbElHQnFvTng0bldqTm96YzNXbERDK05NRVZhK3hJRzBBVEh1aE4z?=
 =?utf-8?B?MzBlWG9JZEhkRHVEUnNXeDFGYWoralBEamtjT09jUElHQmNJUWx6OFRxcUNM?=
 =?utf-8?B?dCtMTlBrR0dWbEZVSGpqU2RKN1kvQWVaQWIzSXhYcDhMWC9WV0pvZHZWTUp2?=
 =?utf-8?B?T0hwd1dRTkYyQzNCQ1Z4UEE5d1A4WWhwZG1vb09rWVJNWEJ2OGpjREF4R2Q0?=
 =?utf-8?B?UlQ0Ny9vTFl3QkZkYk5NN1AxM0hUVFN0eitYOWY2d1p2TXE5d0pEUmlMVDhm?=
 =?utf-8?B?Ri93UllrQThNMnNzMSt4WXVTRm1tblpXd2YzUnBwUFFTWjBBVzBNZFFjN2J1?=
 =?utf-8?B?YlFza05MM1RZanBmcGoyMk0rN24wOUVxcERQcDgzbUZmZHNqWWNXN1JFYWkz?=
 =?utf-8?B?R1UwZWk0ams4K2RWOFFTeStKak11QmVqcmNxc0ZJa1FVWDFyNUluenZ4NEJ5?=
 =?utf-8?B?YVJKL1dNeWpGMVFVMDBOK0QvZFFWVlk5U2RkTlJUbkRHUmZuRE1VTTRVMzc2?=
 =?utf-8?B?bEZONTg5SWdLOHFydlVlTVpIVVRkaHkwMzU1WWg2bEt2bjd0U3VlVEtaalVF?=
 =?utf-8?B?djhLWFpiRmJCREdKMWtIQ2VoOUFxeWkxZURqaGZ1SnJCaEIvZS9pZTlDbU1P?=
 =?utf-8?B?eTExaEVhc21XZFFsaTR5cTVxZzY3REFjdWxtbWlZdTRKZW9kOXlvOGFudkFn?=
 =?utf-8?B?OG16MnBnR2lQdURFWS82UGdMYTVnbzZVZGhZUDlOeXAxZEpNNU9kMkcvb2hF?=
 =?utf-8?Q?9NgvwC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFA4NnMyd1pucXo2Y2VYMGEyY1pMeko4R0VoYlN4MnM3a0pqbkQwQVk1dUF4?=
 =?utf-8?B?ZUZ5dkNTTUozR3NoUXVSNUM3bHVkbEZIYitVR2YxNTVqanBiL00wamVaL3RS?=
 =?utf-8?B?WkRqN0ZSbTRxRnhSbU5wV0tNK3JFODY2VGtqR2VtUDNlb0t5U1Z6UjVGNHFw?=
 =?utf-8?B?MmdFV2I3Tm96bDBaWStjczQyTndHSnlic0pwYk5ML0dKZ0YyWEtocTNwTzc1?=
 =?utf-8?B?Y0xnQ2E3SVVyK3M2RWsvQ05QbjNxQmVMVEZES3ZsMVhOc3ZWTCs4dWtyQURm?=
 =?utf-8?B?Qm1zclRENWZDc1VvSTJ4WUVHNnBxVjNydzk3eHlvQ2JaNUx0TGd1VWRZeFZw?=
 =?utf-8?B?dnRrMDhKRnllMW5idjNRWHZERHk5OFhnc1hCdkZuS3pRSEUrT2RrMUpuVUtx?=
 =?utf-8?B?V3pOVHNwQmJVM0xEN1JCVHpBeVd1Zjl0VFkxTGJhMm5aalVGRmdCUHBLMGw1?=
 =?utf-8?B?QUF0T2cwRjZBNmR5QXc4dGY2SFh6T1RNc2lDbC9MM21PcTM5QTRhVVMrajVD?=
 =?utf-8?B?eFVxdUpUVHJ3dEVTd1pRL25WaThmT0pEMUs5akZ2cU15bGo2aFNKRWtxd0lk?=
 =?utf-8?B?cDVFSjRHQ2dWQ2tDeU93M1NLYTVpQ09vR1I1Z0d2N2pza256N04rYVdqTGVa?=
 =?utf-8?B?a3l2NXVWN2lrazhsM2lrU2F1TzlkR2ttbU9qS3FUekJab0wyUzNsQ1JEZE1W?=
 =?utf-8?B?MUZwQjZpNlZvdVhvU0t4ald1MlpkeTZJbDFOM0FjVkdIaEJFeVhIcXl4QlY1?=
 =?utf-8?B?em1PNU42MmNDbFkxeGljUERwcWsvbFFTVU5sbmdZakNHbUVvZ2lOT1hVS29F?=
 =?utf-8?B?NThvUktzb2g0QnlIY1EyNlpJMnQ4ZlV1VmxXS2NWd1lIUGJicy9UTisrRzBC?=
 =?utf-8?B?MG4yekx2Q1VzbjlDMnBqOU1uUFFmeGwwN2xwUzVEK3d4RGJVV0o1ZlpETHYv?=
 =?utf-8?B?UUUxSVFpMlRpSy8zL2J1QzkxYW1jUlB2LzZaSUcyNWpObWxMTDVKbE94QTh5?=
 =?utf-8?B?WERvMlM4d1pMd2hUMEUvTlpjc0JMVm9rYVl1SEJ0L0tEY0VSRTV0dG9sN3Ux?=
 =?utf-8?B?cjc2UnlhdXpiN3FtbGZEWEFsc0lqc2NHOEhBNEdWMXhzbWhQc0tvWGd2ME9m?=
 =?utf-8?B?UU03M2Nab1IzM002UUZBNzJ3dnVhTE9sMzFRSm82ZUUza3dWdXJENUFDcTFn?=
 =?utf-8?B?dTZDT2h2WllFME0xWUd1ckQrTlhJS011aGI2bmFnTjFiWm5KRVZuNG96L0Jp?=
 =?utf-8?B?ald5bGovam5pME54cktMbFJkTy9IUXlMekxkSGZPZkFRaDBlQy9NUEhkditN?=
 =?utf-8?B?V2hVNG1yL0l1aC84UGlpOHRweHpWL0g2S1hQMXJpVUJ2WGhrTXZjUVdPcTlT?=
 =?utf-8?B?ay8rWUR0d3NsRkxTb3FLTkpLaDg3QkhMRG5lTm50TXBwRk1OREVIV1p3bmJo?=
 =?utf-8?B?OFVzeVZFRzVlaklLLzFCZkhmbmFKQkozOWJxNVRnMDR3SldqclhnZGZoQUtu?=
 =?utf-8?B?Y2F2U05NbU90bEVFalZ2R0hlS09zQzlaVStWQWtzMEN3ekpOVjNMZHZZNFFJ?=
 =?utf-8?B?dnhBSEZUTGdGaUZrQkZ2bFFOYUlySjFqTmt0TjZJdjhlSUZsMm8wSzZOZzZL?=
 =?utf-8?B?TTJkMU5NTEx0VUZmN3hBWDNLUkJrZm9pUHEwLzh1NXlkWFBiQ1lURGlOdUxC?=
 =?utf-8?B?WE5JN1dUQmJuZG5jWUd0VkhxTnVqdGg2aWRlWFpJd2lyN1JlQVVXbEtEbGpm?=
 =?utf-8?B?UjAzcW5lWnluZUNIYlFpcWlOMnVKeUc3NlBIRjd5bmdPN1hQMS9LNnJHakFV?=
 =?utf-8?B?WE9MQ3hpV3lHMEphWS9LVW5SaVBYM3JaMzN3N0pZaGtpSndGdXhzVGViQjZx?=
 =?utf-8?B?V3M5TW9JZEcxcFVtcUozbzYvWFloU05rY1VxM01nQThlMUFvNHRiTEwxb1dB?=
 =?utf-8?B?cTdZZ1ZRa2ZYQldyYU5rQm1KMk9NTzdKYzhCdlJEMHQvbmFPclVKTVNZaE8v?=
 =?utf-8?B?eGUrclJHZnZGR1A5cExhTDdreHN2L1JjUW9oSVkyYk00SVVkQmgwWGlUb0hW?=
 =?utf-8?B?bjVqRUN1SXFnNzQxUjV2Vm5ROGNyeURLdi9lSDQzUGNTa0RmMTQ4K3Ruclly?=
 =?utf-8?B?UDg0VHRQYmlXN1BBRmpMMWJUSWo1dGhRa09rdExDc0tvN05lb0srQjNLaFJu?=
 =?utf-8?B?eGJMTTlBVWJaeTNqYkRXZVZHWWQ5THFLNTNieGlRUlFSdm9tN2dnSDdzZjlr?=
 =?utf-8?B?UGFIdFBDaUduNVl6Slp6eXlsZkZzc2xKNTJMNTRPa0JMVEZ4MHdiU2ZsZWp4?=
 =?utf-8?B?TDBGZFh2Y3QxdmVjQlFuVDYzSWduR1k2TGZQbXluNXM3enhQbzZlUFQ5dEE2?=
 =?utf-8?Q?nuCCSWHYm3JL/hxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e790ee-2e93-4433-e642-08de72fcd7e0
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 16:59:01.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDyrIicfQlA/3KEKBzMlBrrBe6bBXAl+fc9R6wvkNFCwxR/iAHgHt8fAnptlOne08VrtJe4adjKXYjDvkGPhm+XaI5g8BhP5xLn32R3ujZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[rafael.j.wysocki@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6D0A917A4C9
X-Rspamd-Action: no action

On 2/23/2026 12:38 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      ACPI: button: Convert the driver to a platform one
>
> to the 6.18-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       acpi-button-convert-the-driver-to-a-platform-one.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
Is a driver conversion really "stable" material?  I wouldn't think so.

Same for the "Adjust event notification routine" patch.

Please drop those.


>
> commit 04681d258c4a7119c6f042f3e3ff1eb4ed356615
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Dec 15 14:57:57 2025 +0100
>
>      ACPI: button: Convert the driver to a platform one
>      
>      [ Upstream commit 52d86401963666423cb9a56d117136c846093db0 ]
>      
>      While binding drivers directly to struct acpi_device objects allows
>      basic functionality to be provided, at least in the majority of cases,
>      there are some problems with it, related to general consistency, sysfs
>      layout, power management operation ordering, and code cleanliness.
>      
>      Overall, it is better to bind drivers to platform devices than to their
>      ACPI companions, so convert the ACPI button driver to a platform one.
>      
>      While this is not expected to alter functionality, it changes sysfs
>      layout and so it will be visible to user space.
>      
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>      Link: https://patch.msgid.link/2461734.NG923GbCHz@rafael.j.wysocki
>      Stable-dep-of: e91f8c5305b9 ("ACPI: button: Call device_init_wakeup() earlier during probe")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 09a6e4ffe9f20..b899b8745fedd 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -19,6 +19,7 @@
>   #include <linux/slab.h>
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
> +#include <linux/platform_device.h>
>   #include <acpi/button.h>
>   
>   #define ACPI_BUTTON_CLASS		"button"
> @@ -145,8 +146,8 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>   	{}
>   };
>   
> -static int acpi_button_add(struct acpi_device *device);
> -static void acpi_button_remove(struct acpi_device *device);
> +static int acpi_button_probe(struct platform_device *pdev);
> +static void acpi_button_remove(struct platform_device *pdev);
>   
>   #ifdef CONFIG_PM_SLEEP
>   static int acpi_button_suspend(struct device *dev);
> @@ -157,19 +158,19 @@ static int acpi_button_resume(struct device *dev);
>   #endif
>   static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
>   
> -static struct acpi_driver acpi_button_driver = {
> -	.name = "button",
> -	.class = ACPI_BUTTON_CLASS,
> -	.ids = button_device_ids,
> -	.ops = {
> -		.add = acpi_button_add,
> -		.remove = acpi_button_remove,
> +static struct platform_driver acpi_button_driver = {
> +	.probe = acpi_button_probe,
> +	.remove = acpi_button_remove,
> +	.driver = {
> +		.name = "acpi-button",
> +		.acpi_match_table = button_device_ids,
> +		.pm = &acpi_button_pm,
>   	},
> -	.drv.pm = &acpi_button_pm,
>   };
>   
>   struct acpi_button {
>   	struct acpi_device *adev;
> +	struct platform_device *pdev;
>   	unsigned int type;
>   	struct input_dev *input;
>   	char phys[32];			/* for input device */
> @@ -397,7 +398,7 @@ static int acpi_lid_update_state(struct acpi_button *button,
>   		return state;
>   
>   	if (state && signal_wakeup)
> -		acpi_pm_wakeup_event(&device->dev);
> +		acpi_pm_wakeup_event(&button->pdev->dev);
>   
>   	return acpi_lid_notify_state(button, state);
>   }
> @@ -454,7 +455,7 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>   		return;
>   	}
>   
> -	acpi_pm_wakeup_event(&device->dev);
> +	acpi_pm_wakeup_event(&button->pdev->dev);
>   
>   	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
>   		return;
> @@ -486,8 +487,7 @@ static u32 acpi_button_event(void *data)
>   #ifdef CONFIG_PM_SLEEP
>   static int acpi_button_suspend(struct device *dev)
>   {
> -	struct acpi_device *device = to_acpi_device(dev);
> -	struct acpi_button *button = acpi_driver_data(device);
> +	struct acpi_button *button = dev_get_drvdata(dev);
>   
>   	button->suspended = true;
>   	return 0;
> @@ -495,9 +495,9 @@ static int acpi_button_suspend(struct device *dev)
>   
>   static int acpi_button_resume(struct device *dev)
>   {
> +	struct acpi_button *button = dev_get_drvdata(dev);
> +	struct acpi_device *device = ACPI_COMPANION(dev);
>   	struct input_dev *input;
> -	struct acpi_device *device = to_acpi_device(dev);
> -	struct acpi_button *button = acpi_driver_data(device);
>   
>   	button->suspended = false;
>   	if (button->type == ACPI_BUTTON_TYPE_LID) {
> @@ -529,8 +529,9 @@ static int acpi_lid_input_open(struct input_dev *input)
>   	return 0;
>   }
>   
> -static int acpi_button_add(struct acpi_device *device)
> +static int acpi_button_probe(struct platform_device *pdev)
>   {
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>   	acpi_notify_handler handler;
>   	struct acpi_button *button;
>   	struct input_dev *input;
> @@ -547,8 +548,9 @@ static int acpi_button_add(struct acpi_device *device)
>   	if (!button)
>   		return -ENOMEM;
>   
> -	device->driver_data = button;
> +	platform_set_drvdata(pdev, button);
>   
> +	button->pdev = pdev;
>   	button->adev = device;
>   	button->input = input = input_allocate_device();
>   	if (!input) {
> @@ -599,7 +601,7 @@ static int acpi_button_add(struct acpi_device *device)
>   	input->phys = button->phys;
>   	input->id.bustype = BUS_HOST;
>   	input->id.product = button->type;
> -	input->dev.parent = &device->dev;
> +	input->dev.parent = &pdev->dev;
>   
>   	switch (button->type) {
>   	case ACPI_BUTTON_TYPE_POWER:
> @@ -653,7 +655,7 @@ static int acpi_button_add(struct acpi_device *device)
>   		lid_device = device;
>   	}
>   
> -	device_init_wakeup(&device->dev, true);
> +	device_init_wakeup(&pdev->dev, true);
>   	pr_info("%s [%s]\n", name, acpi_device_bid(device));
>   	return 0;
>   
> @@ -666,9 +668,10 @@ static int acpi_button_add(struct acpi_device *device)
>   	return error;
>   }
>   
> -static void acpi_button_remove(struct acpi_device *device)
> +static void acpi_button_remove(struct platform_device *pdev)
>   {
> -	struct acpi_button *button = acpi_driver_data(device);
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_button *button = platform_get_drvdata(pdev);
>   
>   	switch (device->device_type) {
>   	case ACPI_BUS_TYPE_POWER_BUTTON:
> @@ -727,7 +730,7 @@ module_param_call(lid_init_state,
>   		  NULL, 0644);
>   MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
>   
> -static int acpi_button_register_driver(struct acpi_driver *driver)
> +static int __init acpi_button_init(void)
>   {
>   	const struct dmi_system_id *dmi_id;
>   
> @@ -743,20 +746,20 @@ static int acpi_button_register_driver(struct acpi_driver *driver)
>   	 * Modules such as nouveau.ko and i915.ko have a link time dependency
>   	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
>   	 * capable kernels booted in non-ACPI mode if the return value of
> -	 * acpi_bus_register_driver() is returned from here with ACPI disabled
> +	 * platform_driver_register() is returned from here with ACPI disabled
>   	 * when this driver is built as a module.
>   	 */
>   	if (acpi_disabled)
>   		return 0;
>   
> -	return acpi_bus_register_driver(driver);
> +	return platform_driver_register(&acpi_button_driver);
>   }
>   
> -static void acpi_button_unregister_driver(struct acpi_driver *driver)
> +static void __exit acpi_button_exit(void)
>   {
>   	if (!acpi_disabled)
> -		acpi_bus_unregister_driver(driver);
> +		platform_driver_unregister(&acpi_button_driver);
>   }
>   
> -module_driver(acpi_button_driver, acpi_button_register_driver,
> -	       acpi_button_unregister_driver);
> +module_init(acpi_button_init);
> +module_exit(acpi_button_exit);

