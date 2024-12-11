Return-Path: <stable+bounces-100597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A919EC90E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1BA188389C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE1236F99;
	Wed, 11 Dec 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyU9nN3a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA130236F8E;
	Wed, 11 Dec 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909310; cv=fail; b=ta+P8rZjUiDZmxV07LtoBvHqsgr57TwqqC/s/7wBkmoDTiRzyD+e2FzUYnXSVeCRBgV4mVpsa68iijtJyJ/uBqIpp1vqFv8dtbwXPe3dMAyYapJt61AC/L2WQBNVV/10Fygc7GNfvV8HZbEz4zukMCYazQKiwWhwurizIxV8lRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909310; c=relaxed/simple;
	bh=eVzqz4htYOkTSbxfa922kgc9Kn1YnKRK86iMhzFMP7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckkOWpHYv8/4EvcqZyZwzWfSaOf+Iy2LtJaMT3akct/XuXcZa3tk26S4Nt3h0CHg6rFZJkv38XqCdUFxKP9Zuc2hqrhA4bWhCaEKvY09IrI2MkXAut1B3sk7/qb1Bs8jefH3cuQDKSFBvConGFZerjbBKfQ8HlD4jN3nuKxt42s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyU9nN3a; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733909309; x=1765445309;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVzqz4htYOkTSbxfa922kgc9Kn1YnKRK86iMhzFMP7A=;
  b=CyU9nN3aq1PlF4L5SWMMtSda4oQoS4q+eS4+u9Mz8OKDOU6u3g6VemeK
   FSNr3oYvKegYO+nbthW2mYTNM/XMvyHOHu2hokk3I/Y8Oeyg0quYYdFc7
   z5HMuo2xg/LMrsuW5zT8ACfZYa2WU7oL54BpNOKz9Y0gd0y2pePhlgboC
   OUG4Zlue4JecoZwRvWki/YJv/S1bSHnJa0Sf4juXYbLMdi03R+FciapdR
   eM0L6krpLZnt04RJS068LADNg67OsJ9ZITaGp3iBUSrBpkILPxGG6cArf
   6XYja4pxdFhJSWUcNNrbkO895I0MInBdGhhAVP6s/yTQUYG12nvUXBJNI
   w==;
X-CSE-ConnectionGUID: aDvyLkN3SlC8gOp7EduNOA==
X-CSE-MsgGUID: u3bRrNBJQ42CMt3oKgBt8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45685932"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45685932"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:28:28 -0800
X-CSE-ConnectionGUID: EGBPS3n8QlKmTuuBH59PKg==
X-CSE-MsgGUID: AldZc1cFQ4auLbkpZVRNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100678115"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 01:28:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 01:28:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 01:28:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 01:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAarRa94V3UT0GqJMOHTWZfjJtN35CwTO9mtVfaLeWGZuxjZVr3TppjVqe/Z+fyvaeKIhImt/fuXKZeXwPaaBADFRBdVxNPLWvz2beBBRbFDLOJ47eeJqcX8gDq49xWpcyBBnKZ8RnwcBjBc7kNhwIwG3FGMJS6RONELB31u6v5lrOPlU7mN+ZfMeXB5193+T+A464ss2sc9FAOuzjZGjurhCeeUt4EMGKYTf2o4sdkqR5m7cg1M7ttgR5cuZr/ztFAjteiVmFYAn2kxc5Tq9P1KvpUOZZT90Pl0gahuPuLtHVfNRTBic0XYjV9z5tUzcKNhX8gU3evWMl8vvT4gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9zuyKYVM2hyEIiTbOscInLNzXw6kDfmXf5jTUel+1A=;
 b=Kl9ebNfLdoS7TV+T7K4jjxMYej5sgx9Tz6VEe1kykkpp3J2sOnQbNAQ74enMMz7wghRIuotMYX/Xvd5/m7jins1tgrT1MWLKBUv91qHwP/wAIrGsLgyTNVsFigPB74OAwdlj8mMTK3oT3KF0UemPmJ4lr9nFQcATuANFprYI90nPlUVhWuCNrb53eKQ1ntBq67GnfM0u1+z6A6my6F0s1x9qR8xRJG0hXB3NuD6hyFHfc4Uh0MQED5T1s/mE2secr+H4yZhj7/x+lTv/p0b9mXOmjNDKYFF6YWWeFKKDVGso54ljQ3iiJYHTydqTgWs9uO4WWJGv5J1XSRqZ4qwsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 09:28:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:28:18 +0000
Message-ID: <cb9e64fa-f47e-4e6b-9f98-8832e5acbf73@intel.com>
Date: Wed, 11 Dec 2024 10:28:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: fix NULL dereference in nixge_recv()
To: Ma Ke <make_ruc2021@163.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<shannon.nelson@amd.com>, <sd@queasysnail.net>,
	<u.kleine-koenig@baylibre.com>, <mdf@kernel.org>
References: <20241211083424.2580563-1-make_ruc2021@163.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241211083424.2580563-1-make_ruc2021@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0153.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::37) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 374fd22d-2efd-42e5-e685-08dd19c625b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEZqcWdiQkZsb2VmdnYvTytQN05KYkFyaUp3eis2WkNpTzBNOW9tRnM2c0k4?=
 =?utf-8?B?dlVIc3p1ZkFUalpJVzJ4K25nRlQ0M01MUENEL1QxUklCdDJCU0VHUitrR2J1?=
 =?utf-8?B?UVFUWjR5bmR4UUpjS1NkZzZNN24vKzlzb2ZST09ZdWxzMENYM2pZa1FNTUNk?=
 =?utf-8?B?c1ZTUEtyU3p4Tm5QT3BPNnFWMDAxdzlYQ2hTWnpDMFpwTGNHTjNWK3V2eko3?=
 =?utf-8?B?UjhWcGNNRDVXSWcxMVpTaElEblJRbm9ZcVV3ZmJ0c21tUmVTUWxYcTVOOWVs?=
 =?utf-8?B?Rm91SkNuMzVvSURpOVJqbXRlb3lTeC9ZeWFRNk15SG9BQ2VxS3dpbzl3K2RZ?=
 =?utf-8?B?ZGgvRkIyNDB5WXFnZ3ZIbG1IY0tuYjNYeHkrUWpidCs2a1Nld1ArQTFLZGdK?=
 =?utf-8?B?cDlWd0ZqU2tRUlJQTHYrZ2hSM25GTWFyQTREMjd6TzB0UHNEV2Y0YUJDeDhJ?=
 =?utf-8?B?dnNxT093c3kvdy9Ec0tOVEdzWjNNTE80TjBEN1c2YklyTEhvZFFKbGtzYjZu?=
 =?utf-8?B?MEZkaDNVYTFuKzc5TGxVMlYzb3pJblFzU1UrZGRSOWg3dmdLc2dzQWlyeTZY?=
 =?utf-8?B?eWNxTTJVWWU3UHNyT0FYWTV6YkxNblJ4cS9FMDJxWVd2cFlXMkRtVlhYYlJQ?=
 =?utf-8?B?bXVBQ1JkNk1VQitzSkZYd0Z2QlNuN1JKTmxzMzIzd1MxMkhmNEM1YTRjWVU2?=
 =?utf-8?B?QzBkTFZwN2pQZ1d2SUlFM3VPV253bmQ5aXBnVmxNUzN1YW9RQ3ZXSkZwKzBF?=
 =?utf-8?B?bW1pNG5TSDJVcytXTXJkaFI3UWRDZDA0ZE82c2FGdmNCL3NIY0hKQUJNUkxI?=
 =?utf-8?B?WjZCS21Sa2ZSbk9XdXlXY0hnT3VYRHpicVl2U24wM1hYVlY0aUF2SnRoSVBM?=
 =?utf-8?B?cTF5NkNPSGhnam96V1hoZzIrQmtwU2d5THlHc3ExMHFqTGtSUzk4OHMvanRl?=
 =?utf-8?B?alM2NDBHZVpFeUhmaWQ5cWhlei8zRllBL2Z0TVNEMVk3ckxGcHdYMU93TXRE?=
 =?utf-8?B?V0RuL1djQWlLT3NrUmljanJGNDhTclFZRVBtZTJscDNiOHMvcThqdHBNYW91?=
 =?utf-8?B?aWdKdzF5c3RtV21LM2d1anBCaC9DV2phbklRc3A2ZTNMTUZpbUcrSXAvaXZT?=
 =?utf-8?B?ODQ3dlpEcnpUS2RzMldmV0ZINDJIcGJsTXhYNEJBcXVZSWhqR0NJdXE4TmMz?=
 =?utf-8?B?eXpzWlkrOEIyb0tyVWRFa2hOeExGclFrY0VtdmVCREQ1VDd3U1JBZmkwYm1x?=
 =?utf-8?B?QXNrVEpGaDBKdWMwdjlwWDhpRllFb1BycjRCcU04cElMWmNlUDRVYm5ZbXFo?=
 =?utf-8?B?QUtROVR1K1lvK0FpeE9JZHBtQ1NyaGlMbS9meTM3VFd2bFFjQndvK0pwSGxa?=
 =?utf-8?B?ZGNRZHdaQVptTDJ1VTJzTkxzUTBLdTNzeHVybXpJSFhnRmlicEZzUzhINTZy?=
 =?utf-8?B?YVRVUC9veHpMYzd5WG4rdkFicVpGRzZiVnZjaC9YRmpMd0o3Nzk1MmhWczN3?=
 =?utf-8?B?b3VUakdMQU03aHlrMXFiRGFnMFNCSGZic0pxTkhkNjZORlZrNzZmdzZJVmZI?=
 =?utf-8?B?U3NFQ1NOclU2Qkd1bmtZeWdTOHNRUWJtclVxZVl1VGhnS3IwZGFudmM5M0Jy?=
 =?utf-8?B?RC9VK0h2VFVBdmlPeUxwdDhmUU01NHB6NWxtdlFub2pzUGNOUVdWZ0hRalZp?=
 =?utf-8?B?MWFLMUpNek4vUXArT3NwNzgyM2d3dmNNWGtPK2J2cElNd0ZEeCt1Z3RrNHBj?=
 =?utf-8?B?WTAzTTJWV3Qwb1lac2YwcmgxeGRSZERjS01PZmJZWi80Um45MTFMT3VUSkd4?=
 =?utf-8?B?REQ4Q1JqNG1Nd0xBSGJIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhCNEwxd0xoOWdXcmpPSHdEenlZOUpwdzNhalVLeGRoYjQ5WjhpeEJybWtt?=
 =?utf-8?B?Q1ZTOHRRMnBVNTk1VFJEak5iOEl2cXJVQVJOdytFbEw4d0NEV25WZXlYVzZq?=
 =?utf-8?B?T1NNbGJaODRxUENOdXQ3QTVSNG8vdXJwdUJicFMzdUE1MTZZekdBWVByL0NS?=
 =?utf-8?B?TWhMU3ExeDBMZzF2QnNsOWxOTDgrYUhZRTVHTExoNFRWWWljSVpaYkdWaFdv?=
 =?utf-8?B?NkVlTHppeUgzVEdvL1NZSExXalFVN3dLUWRLWTB3VUQzYlQ3LytUT09tVVFo?=
 =?utf-8?B?c0U2alYwKzVVaHV5MVZocFBsOUVjanJyMkVndlVydWU3ZUgyZ3F4Skt4UzRK?=
 =?utf-8?B?WG9vNGxwcEdtUjJvMkN2czQ1LzFuWFo4SjBtRXIyYTMwa1VsczMrWThTWkgx?=
 =?utf-8?B?ak9BaGJMU0hFajc3bU1xNEd6RGttUUlpeHE0UjZqMnRTaTVZb21hQzR4WUlE?=
 =?utf-8?B?K2tXODVzampScFVkZnhaYVhxNXRJM1dwd2pzZDh1OTRocTZPb3lNMFhEd250?=
 =?utf-8?B?MndjUDQya1I3dTcvMExzR2tNdVpuT2dEZmZxWUtORGxwVmlZY28vdjZocGFl?=
 =?utf-8?B?M09oOHcwWThRN3hoaXFVdmlEUmN1UnN5K21JSmc4b2M1VHFNaHIxL0x3bXZv?=
 =?utf-8?B?WWFwYjVIazRUd0NXbGgwMmRoakROeVRscDVDSk9wNWduRGk2cXNnVmRhNXgz?=
 =?utf-8?B?cUh0cjF4RnVqU2srMitiS01nNThETmh6WUN4VEVleTBCRmlESk9BdlU0aGlU?=
 =?utf-8?B?dlRuZHlZU09zMFpqRHpvL0NQcTh5a290UUptTFZENVhZREFNdWhDNml2Q1d4?=
 =?utf-8?B?V1ZUQlora3U5VXc0b3Q4ekVPaHNkU0JTL1VkMnltYTBZV0ZzemwrdkN3ZDZU?=
 =?utf-8?B?bTFnVXE3MnZ3ZGV1RmhzSk1QSThTRU41V3BmR1NuSTlyV3Ywd3l5dXd5V3lN?=
 =?utf-8?B?c2dnY2VUWHFSTms2a1JZaVR4Yys4azlBQmJudVVnWjJPVTRUL2t2cytheCs0?=
 =?utf-8?B?VW54ZWxCeGcyT3BvYk5SN3BmN0RvL2xORFdDUVdUSHQ0ZWlDY0d0WTBlYnJB?=
 =?utf-8?B?Vk9wOXhGblVrVlMxTy9oMjVhdWRFNmlnSVErZSt5c3dSc3RyTlpjaFozRWJq?=
 =?utf-8?B?OHQ5YWk4YjR6NVMySWVOajdramdaY1QyOHV1VXN5QXNJa2tIblcreW4vSm1P?=
 =?utf-8?B?eGR3TTd3M1ZLa2NyTS9pQmxLeXJaa1ZNeEVobnJpUkFkTk1qc0FqVTdCdDMz?=
 =?utf-8?B?b2l1ZnlZbXR2bDR0SjdVRTJLbEdBNVJhcWV5TVZ2OVB5UG8wZFFKdGNkVGRO?=
 =?utf-8?B?dWZmV3I2SWZrTTYxZVFzWTFSblF5aGJLQ05XZndlTjUrc1NtU3VGU081YlZG?=
 =?utf-8?B?Y1lzN2VIaW1JVy96NUFTN1gyazdZQW5YaUk1eHJXUzgzQi9hdmhDMElBZHkv?=
 =?utf-8?B?cXowQWVhYjZCUzBKY2RBdmFSUkJNaWZLaUxKbzM3ZGFzNnZ5M3RRNjg4U0RX?=
 =?utf-8?B?SmFCUUNEbXNORnl2NFFFdmRiZ2ZBbmg0Ykx6SCtCUGdjNUVvL1VzN2krck1P?=
 =?utf-8?B?VG1zNWhWb3ZqWVhpblUyS3BMY2hic2tlTkQwRncxYUlLeFVtS1E5R040L0cz?=
 =?utf-8?B?ckZuU094Y01WbzY3V2dSNXc2YTIrR1ZRSGpxa2RFMEhrZVYxZXE4OHUyK3cx?=
 =?utf-8?B?K2ltVlplbzRUcVVWWDJLOE1OREx6aWFJa2hhU0dXcjNVUC9nZTUrUEg3MjNl?=
 =?utf-8?B?bHp2SU9iMGd4dmVRanNFeWdZcExqNHp3Smwvb2MwMnRFK21mdlgrN0pQZGdZ?=
 =?utf-8?B?QW1wUmhRdUpuRlgrVjJBakNWWXJQNG1QdmJIMXd4YjVGK0JPbXQ5MS9PQmpE?=
 =?utf-8?B?SDZhS1lrSUlOVTJORU55c3hqVTRwVWYrNysvSGpPdHU3OTdZZHlqNVhzVS83?=
 =?utf-8?B?RFZMVzVTekxNWmVGYVU0c1UzbXNoS0g2MkVrSEdndWRIblAzV1BOWVBOOU9y?=
 =?utf-8?B?K2ZLRGp1Qmt5RTBuYkJuZytrcDc4MXNyM1BTdm9NbVhNakU4bjI1d3VJS3Ux?=
 =?utf-8?B?a0FBdHRJQzJSWEhiOHdsY3RsRS9xYlRzazJtNmVQVVBnMDdJdzYvVGxiZHkv?=
 =?utf-8?B?ZUJZcFJvSWwveEtJcmdjTDlwV2VSOVFpalB6V1Q5NE10M012TWZhRjhuaUhj?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 374fd22d-2efd-42e5-e685-08dd19c625b6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:28:18.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOst7Lc8jQec+kj5h9VS/D4hQvX4LZGm7rCzrk/MMDzTyW5ILcFDK1tzyOsYPFQnZhyBfltpYFBHLiCqnMz3WhILas4tlly3fJ4vodzRzvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

On 12/11/24 09:34, Ma Ke wrote:
> In function nixge_recv() dereference of NULL pointer priv->rx_bd_v is
> possible for the case of its allocation failure in netdev_priv(ndev).

please be more precise about the case, rx_bd_v is not set during
netdev(w/priv) allocation

the embedded priv part is allocated together with the netdev, in the
.probe()

> 
> Move while() loop with priv->rx_bd_v dereference under the check for
> its validity.

this style has some benefits, but in the kernel we prefer the early
return:
	if (!priv->rx_bd_v)
		return 0;

instead of touching a whole function

> 
> Cc: stable@vger.kernel.org
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   drivers/net/ethernet/ni/nixge.c | 86 ++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 43 deletions(-)

