Return-Path: <stable+bounces-176941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08DB3F6F2
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A51A7A38A8
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E72E62C6;
	Tue,  2 Sep 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Od3DwmKe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716932F758;
	Tue,  2 Sep 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799274; cv=fail; b=qA/emLQzX9iSVZJVznDQO49arz+ToqDNAWef+dqIXQ9L4GG+B/aoWnH5XPcOBmZD/XtMA1IgWvxvS+igOoe7B+ljYhf8kaZAfChDJqtcWe8JpYDfbBM4JxBReXFAOOVdULCdUOq9XfdW456JsLuU6kfwLa2ahsVBfPPWzZSp0YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799274; c=relaxed/simple;
	bh=eNVAoRuFTX1zigpDZwhBeIr3BYYNTH6qnQ0KMFt/jRU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PtTtOmuOaf7fauekf1FJeA05UFdoZMqWO9MqYHuOhhs4rYoMVUcPALMKRFrW/1UIPVL/iAAPpLwN+kXNntFFBRq51CGGaUd0+Gdn3UVNMY+lOqwpAE9bdXaVDHsES2OMLplQbuy4dUHwTNJNYXUAxhqRSyf6kWVrzYQsW8jhZSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Od3DwmKe; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756799273; x=1788335273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eNVAoRuFTX1zigpDZwhBeIr3BYYNTH6qnQ0KMFt/jRU=;
  b=Od3DwmKeFV4N9mnTSivgKzK+qoIEG24a3dZkyxeJLJ0tk1+U7Qx9tyKY
   0tNCgzErYNmju+Etux9qVP2KOg3anwxPulZ/Up3JrBnwa6lN0nkeQo25A
   DpkAg8kSD9OIftf/kx/DMiKQqNiP5bqnBHvSglQliwirEsgKxEh71M88x
   G1NuYJQJiDMinoN77dKa46Iserb9VPiuV1UC8AHnobt+4/L8xa6PkuLQi
   cdBNuGujFywOBVuTSb8DlGQ0UxEu2E2k6Kv5U3YaXL8jzAXhGvpVG5s9t
   CURE5JFvuaCMoa9LXt4YEJmoxiHw7Jpqd25nWPiF6qjlJ2u6tJnr1WDM4
   g==;
X-CSE-ConnectionGUID: YS3hnBZLS8qiNt9Tre3cvQ==
X-CSE-MsgGUID: b9d0A4/uS6yjzSPIetUn+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70488428"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70488428"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:47:53 -0700
X-CSE-ConnectionGUID: WBYcnYLGRaCDbuIC+LHcqg==
X-CSE-MsgGUID: 4NgNHlO7S5my23Bi68iSFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170463241"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:47:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 00:47:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 00:47:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 00:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZGkZXJMIzO0jPsQKwE9E8PCxkpUpm7NINgcqXo2psDJDOau63pCRsH4S918ewvmdFbUQPVP2zD8SEbxreV4V5tJ2VvxREc7NA2VlwwZpZgrnp5mNyuUTBfkvtQ6dYTIfT+cuOgPyWVxmo0Em17TWEzedOj8xWg92qZOS7sAXEgijh6ecmBwSdXt+GBnhxuLDb07iwdKiHPyQw38yfjKO1Ub7Wm9WyKtfOoq8IfoDR3hOnVBY3TvbKdP7YQAfO64xAc+ArAR66TvVEqA1or+WMjfoD3CZSgPz+I+J16J39T8rjGJpevXN4s+hqSeyUpsgk7GlJXn0a5IleKUjzMiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t51edcp23tjNnHltHxoSP3lK9gdblhlVtQ1197wVQs8=;
 b=Sfgb26ZylhotOMNsMosScyOID/ssG5nIkW7X3oDxRs7nnJrarkZUquciMF4ULottJJtTarQ4UIf2J6oFNcgMBoXSDrQMZboQFCuKJV0n0PoKtRcETgSO3SqAEFxKeBfoUyKAsvz+7iPzpY5sHGlgyyJbgw3J99p5LVoKR+x21jHz3U2MwriXKzN4h0ZyxU4gtvOqlgGKj8niUl7x+CUjQ8xe+ykSPLoIrqrN8izuGwjjaZkvYKwlHhXUeFEtatmLGd89Tjbuc+y3sgRWBFbY+xeq/lIA0qr7G6MavEbWJfiJT2wXdtx+XkjNTBAl6gjPHIR2qWoT4MubmpBIA/ohpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:47:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:47:48 +0000
Message-ID: <6113c4e9-9141-49bf-9672-0203c5cdbf88@intel.com>
Date: Tue, 2 Sep 2025 10:47:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Ben Chuang <benchuanggli@gmail.com>
CC: <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
	<ben.chuang@genesyslogic.com.tw>, <HL.Liu@genesyslogic.com.tw>,
	<SeanHY.Chen@genesyslogic.com.tw>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250901094224.3920-1-benchuanggli@gmail.com>
 <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
 <CACT4zj9n9E45E2T84ciLTEZgUAbcOzH5+ZgTYq8=m=Pusy37iA@mail.gmail.com>
 <CACT4zj-_NHV0td1RULmww4tvw3beJZASNv3+e5TG8wE318wvGg@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CACT4zj-_NHV0td1RULmww4tvw3beJZASNv3+e5TG8wE318wvGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 476b4425-44de-4d41-6ece-08dde9f50238
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk5sOXAxbWRWK2VnRkhPdVVRWUJDVEo3ZXpVSXVCVDFLVmYrN2UrQnNiL0l1?=
 =?utf-8?B?RVRvbTc3Z3c1a09hQjBxYnJWdDZUdkhuVWhtR1IybmRQS3BuSFhKOSt0NTA3?=
 =?utf-8?B?NmY4c2c1OVp5ZjFHbWZ1RXNib1NpcmJ2TVFsVk9KM2NadUU2Sk9rZWFHcm1V?=
 =?utf-8?B?K1FGSlg5TDhhSDlpRlcvZDZJR3V0YVBERUVXZmhMaElVcG43OFJpSXF5NExl?=
 =?utf-8?B?NTE2b01WZVYzMTh3ZmkvbGt0bEkzbmlmY0FYeWRyVmNyYkY3Q0p1L0l6eVEr?=
 =?utf-8?B?MEdIRkR4TTVYdS9ITFRkakpJTjhNLzRJWjJsTnVVRStNMTA4bENyaXk2WlhR?=
 =?utf-8?B?NHZDYmtoU1FrMTlXTzJlTlRzZ1hLNHduUU0xRysvcGlEaXBibldIeVNrQjFJ?=
 =?utf-8?B?YXM1NXJNN0R0MXNFWW50N0lPN3FFa1p4ZEtjOHNZbUlKTktiODM2YU5EN2t5?=
 =?utf-8?B?UHRaUmRXT1VRSEF2eWtWNWttaVUrTElkODVoem9zTzcvM0t1eDZFbU1LdGFo?=
 =?utf-8?B?bWdCTlBZMUtZUzVBbVlWeTVoWFFNQmJWK2JtMXZvTk9xNHEzVzdWUEp1TGt3?=
 =?utf-8?B?NGtjOTJpaGJKc1ZSMW9NYWJTUDRMYkJRL3pLV2EyNVY2VEVYeTNKekxrQXJs?=
 =?utf-8?B?OUdmWVprcWNkR2lhV2xtVlpXV0J2QWJ5UjZGYTdtOEZ5Y253aW5QMytqbENH?=
 =?utf-8?B?eUQ3K2h5L1hTQ0tMcjBNanVXMWYxeEYvaW5VckEzbW05MHBHTFpUdkhNSDMw?=
 =?utf-8?B?N0RPa2dlMEtkUVBRWE5WN0pUa2RqTWJYQ1ZVKzhKK1VsSUJSM0syZzNjK2Uw?=
 =?utf-8?B?RnBGdCtZanlZMnJORTZXQjB1TTNoTDFZM3JkcjNlOW9LL2s0M1FNOWZNeVhU?=
 =?utf-8?B?UGlCWDdIU21sWXdCb1E5NTFWbzlmS0VYOWQwM21WZHlkSnVKQk8vZWFMRHZy?=
 =?utf-8?B?aTJGWUZLMGZ3WThGZlMwZ0JYd0FUL1piWDZ3T20xaG5JWndHL0tyL2ZCMnp4?=
 =?utf-8?B?NFcvNmZza2ttb0hJWVkzamljMUJ6dDF5ZVh6cFA2TGNZMmQxY2l6UVE5YWRr?=
 =?utf-8?B?Vm9lUXpRSUE5eFM2Zkd5aGw1NnhNM2VHODhYRkR4eVQ2ZmZuMGdyVjIvaFJw?=
 =?utf-8?B?b3RiK1VKSVU0ZlBDSGRJbW55bnNxQ1EwVk9SdThsZGt0U0p6QmF2SDZseWRX?=
 =?utf-8?B?ditrOTVQRUNXNkdtcDZJWFdjUlhQclB0aTZZMHhFUlZmN21PaGNoS3M4MFNa?=
 =?utf-8?B?Z1JRQ01CTlFkemJYZ1MrRmJhaFVFRVFOSDFFRWMvS2UzYkM4TXphbjAycFI0?=
 =?utf-8?B?RE5uVTUza29NZW9kcEpmNkwydGx5UEtVMHcyUWtmOWp4WFBOZzBRWm0rQi84?=
 =?utf-8?B?ZERZR1VQeDRZdm5NVTdYci9VWFd4bFV5TSsvWCtkOW9lRnoxaWlKRC8wWjVM?=
 =?utf-8?B?RU5YNllIWVNnTjNWN2N5T21OMHozdGJMUFkvNnM4c2lmRGhSNVB2VGRubk1Y?=
 =?utf-8?B?SEdlckhHTEVqU2IweXZrQ0JEVmgrbzAyVDhSb3Y3MEY3SkJWUmh5Q2QzU0Mx?=
 =?utf-8?B?UDUvbVp5bWI5ejdiS01ZaW1kcDNiWXdhVjlPWVVEaHNIVjFmMlU4U3kwYnlo?=
 =?utf-8?B?MWh2QzlPalUvZ2lyQUl5UkVKRTlNc1VGSjRVM242NFBIZU81UDVaejdwSUxl?=
 =?utf-8?B?dHMyZmNGWWFTcFczNVBlWk5JRnpPTm9IaFZnQUJWVGd6L3FqVTNwTmVKWXlT?=
 =?utf-8?B?ekhWMjh6UU5LT0VJZGtpZmJHVjJTVEk0V2txMzNwUGVmNEZ5NVdBQk1QUmJ4?=
 =?utf-8?B?WDVRU0pBUEEzUkxmYzFDSWxnOGMvdFRUTEhLNUNpY2REWW8vTUhpT0xTOW9U?=
 =?utf-8?B?K2xiT2RSYjVhUzFuZnlmM1ZZVFNsZ1V3YVUvbGZrZWptWnEwR3RWYWZvWDF2?=
 =?utf-8?Q?Kh5L8g8VmdA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU8welZhN3J1QUNnMFpUeFJyUGhXN1lDQk5nNFEzU0NmL0RGbTRuU1g5MzEz?=
 =?utf-8?B?MnVUdWNvcGNIekJ5ODVYTHBmeGY1cndyWm1sTHdvbmtGa04rNEUraVV2Yllu?=
 =?utf-8?B?cDR3UjRJUHdqQTFubyt0RnBTOFBzckcwbSt3SU5xOW1MaVdBVjVJdkRIaFg5?=
 =?utf-8?B?akNjWnN5WkxrV2pxQXdVWDNiTE5XeTd3cys1b0thTE5LNUZUeFJpMFpFMXBV?=
 =?utf-8?B?Z1p3MWNkWmZHSWRjWVRXcmJraS8reVh3TVkvcDhkT05FaFZkNEV4QlNER2pq?=
 =?utf-8?B?dGFRV1pqUE9SRCtnWiswZUtOdWdiR0d3OC90djNIb1RzZHBBVTNnN2FjNm9Q?=
 =?utf-8?B?cXRLRVhOejV0SWI4VXdrN09BSGVkbUpVeDNob3djVkhjdjJTYm1zaHEwRTFp?=
 =?utf-8?B?V1pNMGNRcU54SGRGQ0V6VUdzS1RsNi81dXJMWXBEWmZ4b0thclcrSVRSREdY?=
 =?utf-8?B?OGF4MVhyM2Z6M2szWGdBR2szUVJtcWw4U1U5R0FuZk0zZ3hyWkJWSCsyMHZx?=
 =?utf-8?B?aU1DMm1YTCtxSERRdEdhUWRNSVU0dmpvb2dYazc0RDlldFAyWUFqdkgyWHhH?=
 =?utf-8?B?U0NDSEx1Unl0RE5RSURydkJUUC9QYnVEZUNEWlRHUWpKeTg3YXZnQXpTZ2F1?=
 =?utf-8?B?ejRBamJ3OS8zZDZuZDdvYkV3RFMvWjkrZi9vU3BqSGptTnhNZVJURzVwdXo1?=
 =?utf-8?B?TzFZeDZLbEhjR2p3NHMwVm53VkRiOXNTNW1rTkd6OEhHT0ZEVnJQY2lVbHdK?=
 =?utf-8?B?ZlF3YThqYUw5dVVKc3hQZ1NkbVdza1VlaTNMSHVLWkNiQnN0aGRNVnJZSzJK?=
 =?utf-8?B?NHlIcHVWSGE2YmJkK2ZRL1M3OGw1dDdSakdOTTZOVGw5Tk10Z2VPR043dUlk?=
 =?utf-8?B?TzE4L2RqbGJ5bUVCT1ZsbTJZelh4QUY5SFF3eERuYWQ4S3o0NUFIdklra29O?=
 =?utf-8?B?T1FGSzlDN2cxNnZYNkpwLzczZDlCaWgycCtRSUZBMHJzVEJzc0pQZXZIbnc3?=
 =?utf-8?B?Ym1Ba2xXWllOMmdwdExDWnJWZVZEdGZ6eXdoYWZEd3JSYlVsNUJ0NnljUG5x?=
 =?utf-8?B?YWJCWjk2eDk1SzE2S2cvbFlmOVhGczhjRWd3RVE1dkIxOWxrMGVHdWFuMjNq?=
 =?utf-8?B?MXRPL2xaVGFpYjRObGZZVjM2Mk5HN3owVUd4cm90aGxIV2ZKV1lpVkhhL0t2?=
 =?utf-8?B?RHdrT0lndFRWckdnTWVCTHRFUkxxeG5wdHNMOFBNSm8wZkd3anJObGlhb2Qr?=
 =?utf-8?B?RGZQZ2ExSVpRbW9yOWlNVFV6ZlY3ZUgwUDYxSW9TRGtzY3RvNmxHa0wwR2pZ?=
 =?utf-8?B?enpIaTRydEhXTlh0KzhSNEZaSEdQQUQybjJCMG1oVnN1ZTQyOG1uSkkwY3oz?=
 =?utf-8?B?c1pCd3VsOG1xcnNqcVA5ZTAraEFJeDh3TGNMTlpaMlNMQkh6ODkvVTZSaHBX?=
 =?utf-8?B?U1RWcFRpdFcwVllwRXN0RWJVMHZkaGNxVDI5RkZvRWNYNWJ6OVFuRGJZZ0xm?=
 =?utf-8?B?TzF1aWJTMXVyK3JFM0xaMUhwcE5XbEY0R0xCY1ltKzFJUjhETTJqMjdOVitn?=
 =?utf-8?B?Q3dCMkI5T3B0UDcwQXRTaTVjb0RUUFoyQjRjVVEvY0gxUEhZRHhKV1d5d0JB?=
 =?utf-8?B?RHZaMFNTWWoyZHB1ajRNS1M3ZHRha25CbldBQmwwL2gxTTVWZ2xMTHRvUjFL?=
 =?utf-8?B?NXZGc2FnY3VxdlMvM1dxcWp6ZDhSNjlCVWMyb3B4K0VsLzB2bVpma1hxdEZ1?=
 =?utf-8?B?Qk5kK3ozL3pLcnZwVzNSUGdpOVpxdmdhc1VCaTVlaXZYbWhydWI2WlBrVjJh?=
 =?utf-8?B?MWNBbjZIbWtKZnpVTVdNOVZINlQyM042Tjl4aTB4M2VtWnpOZFZQUTVyUUgz?=
 =?utf-8?B?TUlRYzJmZVphZWdHTDR6bm93QUdQMVBhb1VzMDVEWmdLMUFwa0FtYlRGL0Zo?=
 =?utf-8?B?RzgrSXIraHJkQ3E3Q2xHaDdDbXJmWlB0ZTg5S0ZuTGlLOEdTWHUvV1I4Y3Bh?=
 =?utf-8?B?NWNMSjQ3SlFIdGJNcXRTTXFVb1B1SkxUNXVMR0tUN3F1QTZDV0JxeGZra2Y3?=
 =?utf-8?B?TTg5dGp4dnVBaCtJUW9IcE4rWUNVU25ZVGJucklBWk9HaGwycmdrOXo2VElM?=
 =?utf-8?B?WTI3dHo1ekQyWS9DdzZZbTVQeFJoemZmd1Y4ZVVTYlBnL1FKaFNjdm1lOU5T?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b4425-44de-4d41-6ece-08dde9f50238
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:47:48.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6laWCHOyJj7RAML8+Q/sJwgSOC6Qretcjm87hTD0pw1FKmrKbdP4uS7ndUUMNNznxqQF/c/hD+6WaPgAsjWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com

On 02/09/2025 10:12, Ben Chuang wrote:
> On Tue, Sep 2, 2025 at 2:33 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>
>> On Tue, Sep 2, 2025 at 1:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 01/09/2025 12:42, Ben Chuang wrote:
>>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>
>>>> According to the power structure of IC hardware design for UHS-II
>>>> interface, reset control and timing must be added to the initialization
>>>> process of powering on the UHS-II interface.
>>>>
>>>> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
>>>> Cc: stable@vger.kernel.org # v6.13+
>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>> ---
>>>>  drivers/mmc/host/sdhci-pci-gli.c | 71 +++++++++++++++++++++++++++++++-
>>>>  1 file changed, 70 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>>>> index 3a1de477e9af..85d0d7e6169c 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>>>> @@ -283,6 +283,8 @@
>>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE     0xb
>>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL       BIT(6)
>>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE         0x1
>>>> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN   BIT(13)
>>>> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE BIT(14)
>>>>
>>>>  #define GLI_MAX_TUNING_LOOP 40
>>>>
>>>> @@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
>>>>       gl9767_vhs_read(pdev);
>>>>  }
>>>>
>>>> +static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *host)
>>>> +{
>>>> +     struct sdhci_pci_slot *slot = sdhci_priv(host);
>>>> +     struct pci_dev *pdev = slot->chip->pdev;
>>>> +     u32 value;
>>>> +
>>>> +     gl9767_vhs_write(pdev);
>>>> +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
>>>> +     value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>> +     value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>> +     gl9767_vhs_read(pdev);
>>>> +}
>>>> +
>>>> +static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host *host)
>>>> +{
>>>> +     struct sdhci_pci_slot *slot = sdhci_priv(host);
>>>> +     struct pci_dev *pdev = slot->chip->pdev;
>>>> +     u32 value;
>>>> +
>>>> +     gl9767_vhs_write(pdev);
>>>> +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
>>>> +     value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>>>
>>> Maybe add a small comment about PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE
>>> and PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN being updated separately.
>>>
>>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>> +     value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>> +     gl9767_vhs_read(pdev);
>>>> +}
>>>
>>> sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_deassert()
>>> are fairly similar.  Maybe consider:
>>>
>>> static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
>>> {
>>>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>>>         struct pci_dev *pdev = slot->chip->pdev;
>>>         u32 value, set, clr;
>>>
>>>         if (assert) {
>>>                 set = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>>>                 clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>>>         } else {
>>>                 set = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>>>                 clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>>>         }
>>>
>>>         gl9767_vhs_write(pdev);
>>>         pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
>>>         value |= set;
>>>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>         value &= ~clr;
>>>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>>>         gl9767_vhs_read(pdev);
>>> }
>>>
>>
>> OK, I will update it. Thank you.
>>
>>>
>>>> +
>>>> +static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
>>>> +{
>>>> +     u8 pwr = 0;
>>>> +
>>>> +     if (mode != MMC_POWER_OFF) {
>>>> +             pwr = sdhci_get_vdd_value(vdd);
>>>> +             if (!pwr)
>>>> +                     WARN(1, "%s: Invalid vdd %#x\n",
>>>> +                          mmc_hostname(host->mmc), vdd);
>>>> +             pwr |= SDHCI_VDD2_POWER_180;
>>>> +     }
>>>> +
>>>> +     if (host->pwr == pwr)
>>>> +             return;
>>>> +
>>>> +     host->pwr = pwr;
>>>> +
>>>> +     if (pwr == 0) {
>>>> +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>> +     } else {
>>>> +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>> +
>>>> +             pwr |= SDHCI_POWER_ON;
>>>> +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
>>>> +             mdelay(5);
>>>
>>> Can be mmc_delay(5)
>>>
>>>> +
>>>> +             sdhci_gl9767_uhs2_phy_reset_assert(host);
>>>> +             pwr |= SDHCI_VDD2_POWER_ON;
>>>> +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>>>> +             mdelay(5);
>>>
>>> Can be mmc_delay(5)
>>
>> I may not modify it now.
>> mmc_delay() is in "drivers/mmc/core/core.h".
>> If sdhci-pci-gli.c only includes "../core/core.h", the compiler will
>> report some errors.
> 
> Ah, just add another headersand it will build.
> 
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -14,6 +14,8 @@
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/iopoll.h>
> +#include <linux/mmc/host.h>
> +#include "../core/core.h"
>  #include "sdhci.h"
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pci.h"
> @@ -968,10 +970,10 @@ static void gl9755_set_power(struct sdhci_host
> *host, unsigned char mode,
> 
>                 sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
>                 /* wait stable */
> -               mdelay(5);
> +               mmc_delay(5);
>                 sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>                 /* wait stable */
> -               mdelay(5);
> +               mmc_delay(5);
>                 sdhci_gli_overcurrent_event_enable(host, true);
>         }

It seems mmc_delay() is for core mmc code only, not host drivers.
But the issue with mdelay is that it does not sleep.  Other options
are msleep() or usleep_range().


