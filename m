Return-Path: <stable+bounces-179162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3427B50E8D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 08:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A791B214A0
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB44306B3A;
	Wed, 10 Sep 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dudj/jtR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DC19D89E;
	Wed, 10 Sep 2025 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487312; cv=fail; b=iGd2TgKvvHeTEpajEey54fR6jde8M/XI1AWFCe+SWmUoD1qTlIYtVuR3cW/MCsZjxWv7rcaTx0O9toovl+s+LJWIwogfZYR9fDF8xy6DXpggTPrTpLas5IAknkrcaMeB7xqOny3eF0RqPn7LWeFQdFFUAJPeud7v3JGsRzxm+0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487312; c=relaxed/simple;
	bh=2ATs4y0ryxk+lSyaEu4spTuk3Z7Pr4qmCpxjJIF2Rdg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MuUwQ06JbUTHWQaZMc6617EJDiqPKbfAUpnXTelcDq/s43nVCCYStSnLEqK3TGcbFr9tK4rb3MfGsV3ciFcnidkDb1n47Jl+xSmFsNfrOReME089sDpJqyLZfr/X6mUWWEqfh4T5cLLGhuhKI4bYCNqhloRO+OH0uUxcTp9riZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dudj/jtR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757487309; x=1789023309;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ATs4y0ryxk+lSyaEu4spTuk3Z7Pr4qmCpxjJIF2Rdg=;
  b=dudj/jtRLIZwTia4oRpQSQRMPWsBoLjgVbirX391emdidyPgcfRW7S6T
   tR+2Hi0U/DA/nnVlgFW/Tyz5TZm6hlF5Ty6VaqMStxYP5fznkmJ2d3Iht
   JqM/EdCz7aR+YDePtdDzYyW2lEQx7MPvYNjXitHFYz2mpcWoSfceiTlc0
   saI7l8iU38/3GMCtwRi708o6YNT9coKm80W3yBjJW+9tcXI9wElfse9uE
   nFetRZAXKTWxge2kiiaMpB9JMZIQUTDPDsx1acke7r0tuUajJIs3yMlH8
   L7HnJSwreDGRAVY7jBC7iLo7VyFskNlo7bv4zQDqgk3IUASjAArExAzzG
   g==;
X-CSE-ConnectionGUID: 242AaNfBTPCUYfWgIb+/eg==
X-CSE-MsgGUID: AkAQqlTTS/6JEjbaLT9W+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58828053"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="58828053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:55:04 -0700
X-CSE-ConnectionGUID: IGg4XV+LS/KDTpcz7hibXw==
X-CSE-MsgGUID: E5dECi1CQkK3EXGdqG5hzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="177639210"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:55:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 23:55:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 23:55:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 23:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSAI4JvEP2KUUPchtvYSf+yZeL7Z1/Dq8QM6eVbkeGcnqGIyz4OlT9ZxrHEVY31Q3JsmgkCDL3pIguWExHmKJUaFxE6GqOaoFp4SxnozpF5Db3WjJry5HN15YQzKn7UiToYNH9i6fYYNPTNNcnV4Od8rWJ+CLY5XPNLTPYFU4ZjLycKb8E5fgAViF8ydDKAxm1XmZUHDqGfkJAztjDOZPn5vi89ek4JoDXYAcMWIscDsibQsAdIoKS5HTbKM3zuYlWGxpiCPILLxWQUSU5nb4F11j5szzbqDbTJe20pUff+rdDokKNwdiReM9SqzmUSSypK+jtrmFe8+16OJSjWUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU4O5fR+ZjKv4M/nq5hHJaLtKHWaMtBzEmKlgD4zXbs=;
 b=EC7Ngqvk0kqgwmpG0kbys0Sai5Z42SGkaMFq7E/ZXvFQulV5mtGL4oaaXpNa478r7DJwsO+EsOrcMXgCdzvYscbElBtK4Y9/x36skEGYUW1fvdvIG/GMDPEb9rqCsPGcMZoJ85frmsvSAEskFsTZy8QxvPiPFmG3JMThLr+OIganpi6yeu3mxEO5HhXAlyOGtv7m6J+YNDuyVO5wK4zU69U3TsADJfXWBsdIxzA4xDgrqyVQ86XvQ8oogUWNPhWQHFcKNy9HJo7HlFK9d/3Es8wup2SPpSWB/FFT/nUf9PRyyzrigId6ykG9rMYV5vOrh+RZHg00wx+EdI1WYICtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Wed, 10 Sep
 2025 06:55:00 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 06:54:59 +0000
Message-ID: <76616ed2-ae07-4e1a-a275-e43e43fd65f6@intel.com>
Date: Wed, 10 Sep 2025 09:54:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Ben Chuang <benchuanggli@gmail.com>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<ulf.hansson@linaro.org>
References: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
 <a9fdc8f66a2d928cf83a3a050e5bdb7aff4d40db.1757056421.git.benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <a9fdc8f66a2d928cf83a3a050e5bdb7aff4d40db.1757056421.git.benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e1378e-c2a4-45a3-94d8-08ddf036f58c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3YyYXhxQnNra1JJcDMxTSt1OWtvdXpzWnJSRlowNVRNL2tPb01ia29hanJP?=
 =?utf-8?B?TktMcENFUEZVVXFvU2ZkcDhXa0Q0eThvbUUyMGZuenBMZ0hSVXNmRDR0QVg5?=
 =?utf-8?B?bHQ5UjlXZWVuckNQVzFQa3o1cU44Q1JBZlBSQldGd1YvZHV4SjFiOS9hZlJT?=
 =?utf-8?B?cHk3YW10Qk5mZjE4dXBDbGgySHh6SzVUUGZVQ1BzbS9Wa05ibkp1NmRrcnN2?=
 =?utf-8?B?THhTYlp4NXJsM3ZjVmZuWEhvZk5BSmg2M2N5dncxaFlDcUN5OFVZK0NFTUVp?=
 =?utf-8?B?ZWxiT0loNHFzT0RESFRXd1NyM1ZwL1krMEFpWWhPTWZvd2NJdmFKVVFPR0Z1?=
 =?utf-8?B?VkNmVEhMbTZvSzdYVVEwbUQyaFU5Um5zclFHa1JzT2k5enZ4Smh6ZHZ1eDl1?=
 =?utf-8?B?aUY0SGk4KzV6bEp1eGRlV2F6Y2FXMU1wK0NRdjBZc3FoeGQ4QkNoSmdoeUJV?=
 =?utf-8?B?NmpXNGk3SlIwY2xLMjBvV2FlVWdyYnVpeUVrcnpWL1QzQy9Oc2VNOHo0YkRy?=
 =?utf-8?B?UnAyQkJzYnNSaHhpeUEzQzl0Rkk4Q3pVQmdRbzk2VnBjSk1GblZYd1JFbjBh?=
 =?utf-8?B?TmhJaVgxM1U5R2tMWTZkR2l6WHJEZ0JmZHRmc0YzZ3hNL3A2UFBLVFFXMjAw?=
 =?utf-8?B?RUlvUlZwbUdnb0x0NWhkcFBNTFpoTk1NYUIzbFJpdjRPQUdIRTVvVjdWQ0Rk?=
 =?utf-8?B?VU9FeDFKQk43Nkk4eDZMSWVvUmJiSmQvU0xwQTNpZnZjS3hxZ0RFMTJVZDN0?=
 =?utf-8?B?ZDREOGlpeWdUN1dHWG03YUNtL0NwdTdvNFV0QjJLaW5CRFFlSitkY1VXb2JD?=
 =?utf-8?B?SEN5SDZRWmlLcWEyaVg1YzNvbHJBRDZDaGVwK0labHJaSkJxNW9ic1A0VGxl?=
 =?utf-8?B?cVRZSlhjVXJUUzVqNGJhWTFoQU1vVjhUa1J2a3Q0dzUybms1UTA2UDl0WStY?=
 =?utf-8?B?OERrZjFXdlBUTUl5aHhtcHltbjFjeE5wcFZrK1hUZks2cVBESUthMkxJMkRh?=
 =?utf-8?B?T3ZKYlhtQVVjVVBDZ1ZqdUdla1AyVzZ1R1FQZ3phU05GdlRMVWpUVzFwSlBC?=
 =?utf-8?B?REdtcGJKTTE5TFRaVHI3YlVSc2NCSVNuZ1pJSnU4c0paSlM4S3pJZmt5TXpS?=
 =?utf-8?B?WHpteWFEZXJoNGpnNUUyWFRyMitHQU9zU1F1NDFOYUU2QmRoc1M3RG1hK1Zj?=
 =?utf-8?B?YnhVQTZXWEpkdlZBRlFRa01ZVkZiblMxWUU3alUwUUJQQzR3OG5XRjJqT3Nh?=
 =?utf-8?B?a1lxc1pUMllTVkFnaElOK0lqUzM3UWRESUg2amNVbjdQazlCMStjQU11SHph?=
 =?utf-8?B?Y2JaMWJNN1VWSTdRV3lMVm0ySCtkZGp4R2dmazBqR1N5c1pHczdNZkhsd21U?=
 =?utf-8?B?a0p0S0w5bTZuWUovSkUyY0U1WjdhTTRGTUtNUFVQZURvdUhFcllTWDFoK3R3?=
 =?utf-8?B?Slp5Qkgrek44K0NjeUVManIvK0Vac2RrQ2t4TEdhekJVRFZmRXhxTzlnbWhP?=
 =?utf-8?B?SlRlQi9jdkNPS3pqMStxcFNrdkZYUVVKL2JNajl2NUVNNXZBK3Zaemd1bEs2?=
 =?utf-8?B?WmdoVVFxeUpsSVZOZVVCZEJRdExIMVRnUGNRWVZ4S3p0aFdMN0x4aVI5ZFBp?=
 =?utf-8?B?eUVXU3ZaSS9wd2FsSUhRdU9NV1VJRTRWZlB6UzM5UG90KzJWREpZMkVzTGJD?=
 =?utf-8?B?S0NpZERWbHdvQ2pINDE3ME9rM0RLRDRVQ0MrK2dSeXFIU3FCZm9maEZIaVBy?=
 =?utf-8?B?cmtMV3J5dWtVMnZIa1pXTTAxWTRNTEJxTEFqQk5XYjJDSWhoeU9QZjA2UytF?=
 =?utf-8?B?STBJMjE4bkhHTGtnL0dzd2EzMmFpR2o0ZGJoNWx5bE9nbjBQaVkrekF0RFdw?=
 =?utf-8?B?ZklScGR3M0VZU2hzMjJKdnoyT1E1VXIrWjZXcmY1bjZ3MDVibWt0cnNNcWdV?=
 =?utf-8?Q?Hrv8B/sCuLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG5yRmRlMGZESW5jREpScFJMakJmWUFmbm5xRGphSEdFU0srNk1XRW11cVVN?=
 =?utf-8?B?ejltbG9QR3g4VXhqZkphZ0NDQmFnUit1Rjh4V1Q5VjVpMktLSmd0dmJEZUIr?=
 =?utf-8?B?Mld2UFEzQm04c1pKZUxodE84TFZVR2x2bUx1L3EydUNITWRwajUxeU96S3BV?=
 =?utf-8?B?OFlTTXRXNC9wNXdFRDhQSFRydmdGZlRJTTBFSnFNVUl2dkZmUXRFNHgwdUJj?=
 =?utf-8?B?S2pieTFiYmovdTZmVVNjK1UxSTYzUDljanQxbWF0ay83cmJUbW5QT3dlTnQ1?=
 =?utf-8?B?L2NWRk1UY1lpcjJCNThJZTRBbFVoVGl1T1ZUOWVoVlVFSjhLMFczSExhRmJv?=
 =?utf-8?B?SzdQWlR3RnpYTlFTemRENGxMVFplRUw0WXM4NU9xbno0cjl0YmpJelcrcGZk?=
 =?utf-8?B?OWVhSE56bmZiMVZEcmJabHJvZzRpVC9VM3lUR0szc3VFUXN3dzF3QXdIOWFu?=
 =?utf-8?B?enI1TURPRmNLaU84bWxyenpuanJ0U05QSytEV3pqZ3F5TFprQkhkVlB5dkxS?=
 =?utf-8?B?ZnhUN25VOVlQeHFNVGt5YlJMalU4OUU3RFRYaUQ0VUhYZEtRN2hRbFpxTDND?=
 =?utf-8?B?dEIydFdBSWF0MlkyUHNlb21FTlJBUklZM3hjZy9POUdCVkY3VUk2ZTJhaUJW?=
 =?utf-8?B?bGhBZlJWOGE5d0hRSkdQRk5WMXdXbDF2ckxnTEY1c29wUU83RGJTRG5XQXFR?=
 =?utf-8?B?UXVRVUF1MU95WjlScGFVZmNLYXhBSXY3NVBGTzdsWTNsZlREaE1uamxFWkFM?=
 =?utf-8?B?MmdBWjlIZkZ5citDMGk0WFNqNVlpZFh4OU10ZWlVVXhNZmVCa1Jjc3FDWWhN?=
 =?utf-8?B?b2lBd1VXUWFIT0FUd2MrV3RhQUJia1VUd2pxd0RhQTZVWWFvNm44Z3FNV3ZK?=
 =?utf-8?B?NUxDOHZ6OG1TZjJQbHpkdzV3c05obFRHWG96enNoTjBJWEt4YXZ6K0tVS2Jy?=
 =?utf-8?B?d0hZZlV3R2FpSENIMkd2ZTRIVlE2cHZWU0NDNmVzVkJ2eWlpWEIva2x3TERY?=
 =?utf-8?B?cHdUcE5uVHQ4dkhCTjhEWDdjSnRSRytBeXIwck9zdEl6T1hFVjNRYllaV2M1?=
 =?utf-8?B?R2JrWVhvTnJPYit6TFhIM0llMHVzbWwwTWl1S0NuTk1Mc2dZZkMzNC80M3Fr?=
 =?utf-8?B?dWtEZGo4UjVYalNCSkcxVjMrNGZuMWRJTVByWDNQQ2NaWExkMFlZeDJzeG1V?=
 =?utf-8?B?VXdCQW5nb3lVcklOUWI5L2duLzZJTXZWZUUvWUJYQmx0a2drMTVZaDBhU0lu?=
 =?utf-8?B?Q09kZVdYYzBwdHlMZmFlOVlQR3J4Q2RpNWhtK1lCNDVRR3FScTFWMEdCb2ta?=
 =?utf-8?B?cHhpTTJOSExtSXVzZ2toandmVC9sVDhSeW13VWI0a2hIbGxmWDcxeTF1NHFp?=
 =?utf-8?B?aGc1bGZNT09vUUpmb3QxVjQ2a0l2dmlXbnpGUDZDZVNpRUY3QUdyTCtFeUJP?=
 =?utf-8?B?YmVnSTB4ZW9SanRRaFdwbkR2THdtSzhlRndHY0pQZFJCY09UNHFMU2tUN2Mv?=
 =?utf-8?B?UmU5cm8zRWQwL2tZNExwd04zMUQyai9va0hvdjRqQ0NBcC9ManVBY2xPamdl?=
 =?utf-8?B?N0E4M3BKUDZNNThPNWNTcXg4Uy9TMG04REFXWHlYSHl3K3JyN3hqRXM0NzJU?=
 =?utf-8?B?V0RaSFhMN3Y3bExkaGlnSEEzQkpwQjJQakFRbS8yck5KZU1NQ0JUQTEycG0y?=
 =?utf-8?B?U3JEcVZWUExQa04zL3hDcXlma1UxdjYzUmk2eGQvTjBtSE1IODROU09Dd0Q2?=
 =?utf-8?B?Vng0bUZsbGltVElyOXJrQU5IRVhwSUgxSDM0ZWxENS83VFNWMVl3dUpXVW5S?=
 =?utf-8?B?MG01cDhwTXg4NlZIZHBzZWx4b1ZJdklSNjZrTFRUVThYTzNSd3ZDTmF4VHF3?=
 =?utf-8?B?L01jeFZjKy9iTFl3cldjcnViTk5OK2RRdThVQ0FqSmpVVE9QOVZkclorSzlO?=
 =?utf-8?B?VytWeVh5aTFUK3BLVVA0eWxqNFdBdGxQSUV0VHdDNWF3VC9MNTNzbXorbUN5?=
 =?utf-8?B?UWVyVzUzQkJnVFd0RWl4SXNURjlKdnJwMzJGc3gyck1yRmpCRSs4N1MvNmFQ?=
 =?utf-8?B?Y0JIK1ExbmRyVlZOMzcwTmVHTlFaUHdpVUd4SDZ4cUJDNE5pNDJsQWJnSFdm?=
 =?utf-8?B?S2UyRThSL0tqRXZnVzBtUEFoT244dFFXTk9vUXBJUk9KZkhWMmJYdURia1h1?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e1378e-c2a4-45a3-94d8-08ddf036f58c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:54:59.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxZmIs8Co0uIzY+o5wYDZHApPte4lxhCcvYMCofZbDpSr2VC4gEkUhdqQuG1qzGz0f94hIKWlrWCQLfVINnYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

On 05/09/2025 11:00, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
> vendor defines its own sdhci_set_clock().
> 
> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
> v2:
>  * remove the "if (host->ops->set_clock)" statement
>  * add "host->clock = ios->clock;"
> 
> v1:
>  * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0efeb9d0c376..c459a08d01da 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>  
> -	sdhci_set_clock(host, host->clock);
> +	host->ops->set_clock(host, ios->clock);
> +	host->clock = ios->clock;

The change that host->clock has not yet been
set to ios->clock needs to be part of patch 1.
i.e. put the following in patch 1

-	sdhci_set_clock(host, host->clock);
+	sdhci_set_clock(host, ios->clock);
+	host->clock = ios->clock;


