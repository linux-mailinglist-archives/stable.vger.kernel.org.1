Return-Path: <stable+bounces-217816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N3zCEcGbnGmhJgQAu9opvQ
	(envelope-from <stable+bounces-217816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:26:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1A17B774
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EBF3028031
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9133F36E;
	Mon, 23 Feb 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nan0tcX1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CB33EB07;
	Mon, 23 Feb 2026 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871164; cv=fail; b=Gtp0l1nQFeu2rySBhkuBQMm/4SAXU1IOFSqC5R2aNUluStIoYV8bGM+AMFTi2exL2i6a4+YcCoRcRe3s8Lyp3Dc115lo7BD4Y7Nea5e3TCp+7Ub8pZ17mU6ETPnAlldzDF2WwOyEViHZrQmXnzF5Xs/PokXYYcN/njiv3eqjFRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871164; c=relaxed/simple;
	bh=6ouL70/OhIuxWq0wjfOOJ+6QVXaF7KmxHgnIgZOhu64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ou313Fl1qKvGFiu/vuJNoDNV0Q8BUPVYKne/3U0YsZC5lSXqT9FyLRqvAnsMx5mItNByUyiVqVnC7lnNtSMoR5UEKtiym/Byx33ZAHpfJwe/TTJPwQ7MLQEegRBLD1HuIH2ULLzSoOUR7WbM/R6bvw6q+tCe2wa8qghZymPl8U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nan0tcX1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771871161; x=1803407161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ouL70/OhIuxWq0wjfOOJ+6QVXaF7KmxHgnIgZOhu64=;
  b=Nan0tcX158nAQhTo0I/QZ4fhe0uUcDOhCVV2fNF3WXaXATc4U48W20hP
   LXw+pok5LrDi/f8h4cByLMuiUEHn+8ATsJYTZAZf2stnYql/1aX4T/+ZL
   q20hzb0+nJWs7Fp1MVO53J9hKj/vNBOWGKsBuPNAWL5gAeUEhp1Ux9L0H
   3Q+/kjfvo0Oine7Lkdt3GasWY4rG6A/Kwwlcp4+16KjoBKZoD5URy1b4g
   iJ1Okxcappoj6aE1aDkUh619or8CkyEuxSw3G8UQ3WZytBO4W52rMA9S2
   3qP8jVKNXIxwlfhdESzYW4jL/QwLYeHtLpRcHih1BBpdbwb5oRscq6E2K
   Q==;
X-CSE-ConnectionGUID: smRLggMoSzO3R5N4QOqcpQ==
X-CSE-MsgGUID: UyJbcM8dQ/ewRP4SOxoQJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72084977"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72084977"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 10:26:01 -0800
X-CSE-ConnectionGUID: +cqHzb/oRwavHAmTBgWBng==
X-CSE-MsgGUID: 1ThMubr5Rtu8N7X2V/7q3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="219181102"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 10:25:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 10:25:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 10:25:58 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 10:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjBpgSqGRFujhcAi/OR51ixdCS2hNoWGk9Q3hxsWViBP51AxVZBBpemB/BKYBDBLDu/pjte086zhlMUB+uHvplNVGx+GPqWCY4RtB0rls3BNK88ZPoM7VHbJ+N7KrEsBzacMk/UIaFl/k1yslCMdgYzIIveizP6B6rq4/I6eBDspk+UfV+FUcoHrERsUymCj8vzrfBJ6ef2SPpQiWi6AmFNFTHRwDvc7ROXzncZOjviR328/C3kgm75yU4wepBGVEQ6BcEj1wsUCRm/3KWbyi/wSN4mH6XzmnzIlBAF4wp/VfEnTKxPF4RvADPDffWlpP9nRioivncqRXmz6PWDgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l664INqVphJ6SnFYWRyli8aIZ8VVq9hTQXMGedW6IZk=;
 b=gerDTCAr0Bs2ATQ9T2ZgvUNNDkzCEycBTV1Ocv7enIwedgk/2m5IxKwk2KzCmihozyBCjFC7X3XuxO8qWpI4WFML5VsKaC0ZQ5u+Cq4XpFR/KHo/moywMmIUcc08r5UCF/K/rnDh5j4Mbrng8Py41ZPdkS8VEEmeo5mEmhhPEJFkEM0+kLKBWUC4rq6HE9EUfkMShg/UQee0TBRMKw/mfmuSWC5BYx6YNS58/a9Dbrt0uBo2Mkp1mLy8qxdW89YNF98D5J7QsWLKw26QoMTfMBRF83YI26jzF3/G2uTWHuxKwLDEJsxekIwSweiL+siRfhNWU+qmiFcR52m15wPH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by BL4PR11MB8872.namprd11.prod.outlook.com
 (2603:10b6:208:5a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:25:56 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:25:55 +0000
Message-ID: <a8199969-39ac-4882-b509-fce04b76c8fa@intel.com>
Date: Mon, 23 Feb 2026 19:25:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ACPI: button: Convert the driver to a platform one" has
 been added to the 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260222233852.1322850-1-sashal@kernel.org>
 <50c2aed5-2ca6-4a64-97c4-ab87c23ea863@intel.com> <aZyUWn-r-jNy-4Gm@laps>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <aZyUWn-r-jNy-4Gm@laps>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIYP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::17) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|BL4PR11MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3bceea-cd33-4f4b-6388-08de7308fbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWx3VTBvejlJT2FIZDBLRWJobVRpNjU4Q1JSOFQ5aWhpM2RzQzhrNXZQT2VN?=
 =?utf-8?B?VUlkQnl5b0JiWXM3T2dPOHNWOUtIS2FCSVg5c25zZzdQQkVQOHFzK2NmcWFk?=
 =?utf-8?B?NkQyYlhwT1BvcXVUekJBK1d5amZiRmJqQ3dBRHhnNFBPNEFNLzlhWEoyN21X?=
 =?utf-8?B?RTNtY1Fmc1diOUtGOUpsR1FGc09nbDBmUVZOcU5DbEdJclhKRFppenpxd1FK?=
 =?utf-8?B?WU1HdW51VGFWUkVGRFlETGVEUmxJUTEvcHVqQTBoemJ5ckpCU0pYdlc4Szkz?=
 =?utf-8?B?YUhqZjRzSm9VRExBQ0twQmw5cVVQd0JGRDFLZkRoc3p3RmllRHRabDYvd1RH?=
 =?utf-8?B?SlpKNngrNThEcmZPRkNKQ1hwcXhZdG9MRWlDNWY5aEtIdDJ6V1Ewc2VHVDZ4?=
 =?utf-8?B?RUYyTDlQQnNhTkRHUFJPUVk5ZU0wdHZ3ODgzWittM1BPNjJuUG9YN256dnlF?=
 =?utf-8?B?WXpQQjYzTTNYUDRwZDhONmtDVWpZZE5uTUxqbnhXSTNWUWl1aC9tbXlUSlVq?=
 =?utf-8?B?TldHVVFXNUxlTmQrK3FTVFI5ZjFud1FYWCt4RVJRMS8vUVk5NW1VZ1Q2QmZn?=
 =?utf-8?B?S3ZtOEVnUXphZFZrdlhOc2JLWmRWbThpTDBkMHd5UUJBNVpncWpGVngwSzZ1?=
 =?utf-8?B?MWgwa1dsTFl3OWNJdlBIWWR3WnFrUExHMkQwRnVjVUxwS3ZhR1U0WExybzdJ?=
 =?utf-8?B?ZGxJbUhJOWVGKy91WDFSdkRnaFV5UUNUa3UwNUJXL3JwK2Nnc3NrTitVY2Zq?=
 =?utf-8?B?QmxWbDBJMUlXWjB5RXZQOVZseWlFNjFUSDV3UkkrZmVObFBXK1JHMzh4Rlcw?=
 =?utf-8?B?cldKbDlFSHZHNkFCbUFIb1hLUDlXUGVKQTNRLzdhYXUrU3dmY0kvZTRvYm5M?=
 =?utf-8?B?ajVsQkpmN1haOXRDYTdoMWpscWZjRUxmOWxMWmVuVEhwZWc3a0p4OFFtTGxP?=
 =?utf-8?B?NWVERE9CUkp2UmtCOCtNNmVmOXMyNi9ZWDJwa2t3c3V0MEV6U0dpQTdaODQ3?=
 =?utf-8?B?dDd4WDg4TmJTODFFZ3hobFZKVDE2MGkzSTFGQ211RExtTmRJeHhON2tEa2o5?=
 =?utf-8?B?WnhkRGQ0aVBjTmNjM2FvR1hiaXlQVHBBUXlFZWN4emNzY1Fyd3hrZUlGVVQr?=
 =?utf-8?B?SGtvQXdMV29BcmhMYzlsWjFyWmhCRmpwUDZWQWd3bXdxcVVhM05aQyswdEVU?=
 =?utf-8?B?aXFPVGlwSXVOK3FxdTkwVmtSeFFyeXBIMXpwMGxJeVc5ZW5ncDFVMDlTVEdS?=
 =?utf-8?B?UzRJT2JoUjJPdllkTmFIOGhwelN3cEw2SjJqUW1vNjF6ell4TGpZMHg3YitV?=
 =?utf-8?B?V09QUUVYL2M1aHRDUTg4dStXOC9qcHZvZFRTN3h2OG10RXZwaWFESSt2VXZZ?=
 =?utf-8?B?M3NweG9HYWdHRXEyTkRjcnlCZm11R2JRMmtjYUR3cHRldVh3WVhDNDRNZTFn?=
 =?utf-8?B?d0RiZUErUzhYMHdXUzFvOVJZQ0NmSUxFTXZFd1g0aFJyQUt0QlZHbnpYeHdy?=
 =?utf-8?B?L3VHd1I5K3JBbXJISHdURGxQOVpMdXhyenl4U1I0c1h1RVJQN2hBNWF4eld5?=
 =?utf-8?B?WE5jcGFZcWQ2QlBjT256djhybGZSV2o1emcraEpuS3ZQWk9KL3JkbHU3MFRZ?=
 =?utf-8?B?bU1RUU5BNVFZSkRmU29LL1pycXJ1VDE4Z3JQQnRhWktZUFo4WlF6V2lKeEd6?=
 =?utf-8?B?M0dPNkJmVzFTVzNjbElreVhSSWYyVzZFNFBmUERSUWFaNDVYYm1TQWRxK1hy?=
 =?utf-8?B?c0xETmFVOHZxOUdLdWNORXZmaFlneHhGejdUbE5seGcwbXZqbEJaY1JyWkVk?=
 =?utf-8?B?M1B5RmFSUTBlYXA0MnA2c3Y5TCtXWkEwNTlqc3hRWXJTUzZyN2tHU1RVRWZG?=
 =?utf-8?B?Y1c4UThvN3ZWZCs3OXBjL3NSZE9JbllZMXB6MnRDU0J0K2k4cWJiMm9NWUV5?=
 =?utf-8?B?VURSOWpPcnd4S1pNOUxiRU9WSlRyNGRvcXJXeTFaL3BVbEdGakdwbGhRODZz?=
 =?utf-8?B?TVJyMGJtcUs3NlJnejBlSHNmV1dkWXhrS2lsZm11a2k0MzQzc2tRSnpyU1Uy?=
 =?utf-8?B?WWNHUTAvbFcyZ1p2cU9LQjhXcHNwcklFaUxzdGQ5aVRzN3d2RkxFTmwvK0Fr?=
 =?utf-8?Q?jO44=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDQ2WVZPdnpKejZkWHlBVFQyRGlvb1BTQnozYXM3QzVSOXVhRTNaVlZja2dY?=
 =?utf-8?B?a1pSMlpVVzgzMGk4ci9UbjVZZmh4SENFdUMwMW56cmNUV3dlNmtKZU04SnBH?=
 =?utf-8?B?Z3h6R2xva0ZObWErdUJDZklndXRiZmlOOW04WGFtZ1RFalBpM0dhTGxVNmNU?=
 =?utf-8?B?MmszU3VRREN5UXJITVpSU0NOQTg1M0RUUEQ2ZUxWdm03YXRIcUdpMjltRTFN?=
 =?utf-8?B?UDdOdXIvZ2Q2anYwSTk5aUlabGNyR3pEajI5RDl3dGlrUXAwdGNKdVRKeHY1?=
 =?utf-8?B?K21BaVZWRHdyZWtyV2VyYUVLR2w5Uzg2TmtKdS9VUGJWZitxMnp5R3lndVJ2?=
 =?utf-8?B?Vm9vUHh3cHovcjZzNW9LTll3NS82WUZzclRnSm45K001SDZOTTRwL1Y2WUhn?=
 =?utf-8?B?R3AyS3dWdHRnbkhQSEQ0OGxVMS9Dc0Zzdk1QdVlaSndnQjN6RDZtcHhSaEg3?=
 =?utf-8?B?dElvWS9VUXJmdlczYWJ3UVAyd2tTbTJjTHY2WDEveUdwbGhEQ0c2S0ZYZjMr?=
 =?utf-8?B?UHQ2YUx2Y0Y0S09RZVNWM3dENTRLWjFQZ1JMWU1na0p3bmUxMkhBM1ROOG13?=
 =?utf-8?B?SlZ6VmtRemtzREdpU29XWHBrSlRlMkxJcWtVWnNuYkJBMFpqaFhVZUhZRWFp?=
 =?utf-8?B?dnpudlZUQWFpVExFRnM4c3RzMHhVbHJCd0Z6SVU1UG9mWTZhbHJFTGRzeEFV?=
 =?utf-8?B?WEVZOXFqYlFyeTJMWEszNkZiVDBORXJsTHZueHdTZmRRQytmY0c3N3I3RGpZ?=
 =?utf-8?B?TVY0VUlLdFUxZkV2bmtlNVZlVldXeEExa1laeGM4S0k2ZUh0WVlUWXNZS1p3?=
 =?utf-8?B?VEpLakZSRVRlSDdqKzJtd1pQZktwT3hSYjl0VnV0RWpyUWEwNWtsMlFoN0or?=
 =?utf-8?B?dEtVdjJ6Y1BjTGhhM2hWRTB4U28yamxvZWpnR2FCMkdSMHdPSkErelZLYVFp?=
 =?utf-8?B?eEdieStpeW93S2hWSmEwUUdsWWFsdEIxOXdqL3hndmZIU0pxUnVEdnJtMGFH?=
 =?utf-8?B?QmE1OWV4U2d1ejJuWVVGUmtTR0lsOHg5SkFDL0svb3BYQ3ZZV3VPY0FpRHhB?=
 =?utf-8?B?S3pnQzhTbmtKR3JaU3Y2dzZ3dmMrUTJDbnU1a1RXeGVYRHFYemZWazhQb3Rm?=
 =?utf-8?B?U3ZzUXVDb0xGT1FXdnJVSVBUOGxuRVZEdWFMYm05L0dUaWNjS1Rjb3duVjhF?=
 =?utf-8?B?eE1FOGdJemZCN2d4K0d0K1l3ZytROFgyc1VUa0VVVGxYUlYyY1J6cENlc2JK?=
 =?utf-8?B?ODU3cmV6RXdlM25zNTF5RDlwOHRTM1ViNkQ1KzFYTDBHVWl1Y0dHWXd3aFdL?=
 =?utf-8?B?T20zamNYUFZMMUpnUGtHQlB3SThkbm44RHNiTmV1dmIyM25FR0ppdTdpM042?=
 =?utf-8?B?aGZpVlJLdGdHa2pJdnNkQkordFJiUEsxWE1GaEl0RDlRRnBOS1pNNXEzemx5?=
 =?utf-8?B?Z1FRTzFBUHlucm9BelkwMFkwWEtxZ0RVVUwrL2diMGlhOGkwZ1VNMm03djdR?=
 =?utf-8?B?UUtZZU9VSVorZ0FzMVQ2L0l5SURiaUhNSWtCSmYxTTZwZWw5L2xYTzFBZktP?=
 =?utf-8?B?dEdEUWFLSURSRm5xdlo5VnVTNDVtQ2ZaSzFiYTlKdEtDYi9qK21tRTVIeW5r?=
 =?utf-8?B?QVBJaStCZVcxYW9FY3FuaEZ4eStlNUJKWG1uaFc2U3dWbDg4WnVKczRrbjgx?=
 =?utf-8?B?YXJ5djNJY1pNNGZUVUQ5MW42bEJ4ZmwzSERVTG5NakdIazA2cVVIV0VZSTBy?=
 =?utf-8?B?emc2MTRiQThSQWl1WTVQUitDTTFvZ2E3OTNaWDRydU5Ic0w2TUQzelI1OTVG?=
 =?utf-8?B?SjdFZG5JekFQYU9Ba2xKWi9sVktUSm1DZWZIbDRxUXZKVlptbDhQMXZtVjlC?=
 =?utf-8?B?V3QybldPK2VFTW56QUdUOXM0K3lvYnhyUXdqQ1NPRmFVS2k2bEk4U2RpS3Fu?=
 =?utf-8?B?cUNvRk9wN2htN21xWFo2cFJUam9penJ5UmM2bG8rWnpVYnFsL0E0REZVL1V1?=
 =?utf-8?B?TXJzZSt0NmpYZTVpcW9NZGtFUmZRTkd0QlVQczhEZjViWW5sVEszSTVGSS9H?=
 =?utf-8?B?eTlYSlBPQ1ZGK245RUFuUDg3MElHQm92aGZSRWZVQnh1MnVRVDc2amUrWS95?=
 =?utf-8?B?NzAzTFdXQmhTVE5jaDBBczNXbTR3Ty9qUlZFYkpGbkd6UXpuTUh3a3hsMmtF?=
 =?utf-8?B?aHlZODZ3K0JBRS9jNkc4RFVCQUdtZG5uNmV3UTN0bk9kN3lQc2tkYldxVnk3?=
 =?utf-8?B?REtVRTVkTHdXS0pJQ1l2RExDU0poa0c0QmgxRHpOdFMxRll3a1VVZmRndUpu?=
 =?utf-8?B?Qk5jR0lRcy9aUXY2cXNxTHV3Ny9MNW9hOEFtMDRuMFlDMTRNazBmQlIzT1ZC?=
 =?utf-8?Q?VMuJ5r9hATkhF/n8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3bceea-cd33-4f4b-6388-08de7308fbfe
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:25:55.8853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n975Az6SDkdgwvf0HIQAK4PieDWrfkvkWjrVVAg4TJPKGDBFx8mBnXNHw034QOehxgyoDRGsqIlMP6eEtlzFZhlocc8WdsUIBiWz7iPabc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8872
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217816-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rafael.j.wysocki@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8FC1A17B774
X-Rspamd-Action: no action


On 2/23/2026 6:54 PM, Sasha Levin wrote:
> On Mon, Feb 23, 2026 at 05:58:56PM +0100, Wysocki, Rafael J wrote:
>> On 2/23/2026 12:38 AM, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     ACPI: button: Convert the driver to a platform one
>>>
>>> to the 6.18-stable tree which can be found at:
>>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      acpi-button-convert-the-driver-to-a-platform-one.patch
>>> and it can be found in the queue-6.18 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable 
>>> tree,
>>> please let <stable@vger.kernel.org> know about it.
>>>
>> Is a driver conversion really "stable" material?  I wouldn't think so.
>>
>> Same for the "Adjust event notification routine" patch.
>
> It's not :) They were brought for:
>
>>>     Stable-dep-of: e91f8c5305b9 ("ACPI: button: Call 
>>> device_init_wakeup() earlier during probe")
>
>> Please drop those.
>
> I'll drop those two, but I'll also need to drop e91f8c5305b9.
>
That's fine.



