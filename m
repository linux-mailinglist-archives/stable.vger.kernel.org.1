Return-Path: <stable+bounces-232633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP4SNGZrzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:48:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDC37347F
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5C88300BC56
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BAC1A3172;
	Wed,  1 Apr 2026 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks5w8V2H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5D13B584;
	Wed,  1 Apr 2026 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004510; cv=fail; b=pZWGg1PLXbF2NTcvzEavlpi9eDk5IdyaOEbSdFm49mZ2Gnd/Y+YTdhn+SzeCk3QyPxIFAqmduXab4tuaI0ZwQUterkOqLD0sryIJjGzTjm15aNWAzh/U9fQzIKqOKwzIsFwCt9xyo399J7dKGmGxj05vMQX7FbzMuGbFm+jSVjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004510; c=relaxed/simple;
	bh=W1iPVO4N9yslpMdyBIkL8A7UekOwbVAiM6qjL83Hks4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gZH/+XnXmHWWCCLtX2VftanQJePacfzBscHec0NXmvejX8JJS1TpkRVF78Jb8RLxzYvJOl1Ps3LOeuA1yHYeoDYP3JP6tT9b2UD2CHE7eMSLBaUe2C8LIAPvEab6WQcKMwuGXHfYnEdWVVU2U50o7UjTw7f2ukMHRbCCYh+HtpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks5w8V2H; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775004509; x=1806540509;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W1iPVO4N9yslpMdyBIkL8A7UekOwbVAiM6qjL83Hks4=;
  b=ks5w8V2H+/7g8DK5l/cyLTX/zWGn3t/E/sfSUwmnsmr8oKAS81aQB8Y6
   akct4BASmkLJGIQCS6M7kIuwtjS7SB6IbHQM+RlBWoiVl6TcifiA4SiN6
   kZV8TGTfatpY/0vpqQ+8Y1wXnojv+VY9k4FRifKfYLTDlMeeOtLx1hH6r
   Jh5vOK/9hnnHkmSfCuoKzE2SLzMLr6uNRzTozSyPo5DB/aRjJSjl8KgZE
   2mYkEsNtx+u2P2CnvWpzavw2/RMrZqMx9wUTED1hjbtEo64Rf45ChTd28
   NuRbQ1Z063oavSqseSbx/YzX1xRxcnCOkgR3HdKQeVyjJ6tC76BxQXT3v
   A==;
X-CSE-ConnectionGUID: Xb6CBBOxRHOHObR6nkoLag==
X-CSE-MsgGUID: a73hxzSPSTeaPqEiNe8ChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75925606"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75925606"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:48:29 -0700
X-CSE-ConnectionGUID: GMHWnZf9Tuq15tFB6ppR1Q==
X-CSE-MsgGUID: GPp23hPeSqiqFGMHGblJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231322439"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:48:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:48:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 17:48:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL7d1/Ona9M53Bn4OE/j6neK9cBYYIOPGMfVZYEHnVA9G2myM4qFPBJPtOJw+97sGm7iIbyarqbiv94kn0QsGrUl/EIKG/bFdUK2ox4hTB6XoF8IaHqBTqeXpRM7hUVZnDJRjwjEcyJoLAjWTqfKvlhjGOXgJCJCgNekEf9X+WLr2iQs8UVxA7nYZICo8RjhCk1ga6Fbl47rTUlvWeOtdi011J/APjsaiMfmh4VPKX/Tn/IAg3Mfem2rOr+eeOVBIQDHabDIKprp2kYJS36nPv8Mmp1dxq9pWsbNkF5d6BrYeCaQOLQwvLQUmU7L2QRONs/OQQ1ww0PLNmoUzHYd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qghe0Ka02eXeqWtsjyzVyyLD+ckNhQdoD0Vh2xk/PI=;
 b=aDirv237rR7vc67fZmNKh9xcg7zNzgQCPmMa0Pr+rcmCxiaApzeqK/EpYtfJVZbLoE180potU7AK66MwislgK3TcuJrXMJbLTGAH4pdtWFzw0/aXjEJiyLFkvaPsFE1Dwuvti2qvAGuBW3ZX4K0myt03XwBhS09xBe4d5xOitB1DFbACJd4WRDOQm4tlnrCQmPCtFi1zMG7ZrZiwYJy9F9AIZa0yubxcH7y96qoBoNQd2fCFQ0EsTcj5Oo4ix15e0hAJFx+GMrF3TGcGn3cRx5UwEby0S2sc20OVdApP8Ohi7X+RJjcKky72HYVPPT3s633oitVG1A/Fnp3yDMiGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 00:48:21 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 00:48:21 +0000
Date: Tue, 31 Mar 2026 17:48:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Carlos Santa <carlos.santa@intel.com>, "Ryan
 Neph" <ryanneph@google.com>, <stable@vger.kernel.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Message-ID: <acxrUi9tFriniWy2@gsse-cloud1.jf.intel.com>
References: <20260331221839.1033423-1-matthew.brost@intel.com>
 <acxhVZK_zlv1orIX@slm.duckdns.org>
 <acxlMHWd/Vri7to6@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acxlMHWd/Vri7to6@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS7PR11MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 34858af0-b11b-4547-21e8-08de8f885f73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UD1iHyYOwqaBWv+nbrHC0eZh8ekf5sr9VTSZ8BArY9c+/kZhRqp/PADdh8LojUNvYGfBrYV0wOzv6fzBksXX1YJNiN1kCKra896Si3h2Wv8NSBY+F5BGAEBgqsmTpIu3Gtca00EFyjTzNwO2swapwSJK9uYts4fw6F3/rfshaPXit3pbyimY46GcE7NzSa4ia/qHIZa6pBHAie8wowq3d09lMBWTyJvjuEmkvOdc4FHUy06sG+HU+Xrxp9E7IvS/bxsPFw2dB9wrTziimZp9G3BUp561TVC1MmleY64AC7Sq7km81vwU1ZB71uG7R7fcRSRBo8wE/O/H4hdhtjlrUQx4tMIIlS0gaZSwfqpXLOtw31L3qfhERSGOijZjnJE5R1wjiAOLL4xOgWBCtPEdsPXhqrttYvdPQb7cSNFzHIvD/BsjfEtJJY1D7uQ4DjUhUwBUibyvOIpTUfu1iNIe/u4pOt/Pe95v5DSf5kjPELf3oEj0mlIzRXGYcLN5wBgt7RZGdzMc/w7Fb9wIO78YfVv10fFr/O9zFg4tePbKvmB0nk1cNp1nRGAVeJAjyZbLF+MZanExcOWaaeBoCFDFZbZZvh/dstipBsxcNSTu8B1vlvD+iwO/jRLe/OkmJYteBirzgQhkGy9WRAeNGWmM1MCMHfncGW1JO6hY4uF4KsJ0ZC9LbxXPmMlDkjhYc/TUUp5/2OjkamO3IOGq3yFUCMSh4xgkm05fZzm6+vwwsZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citBdGdtS3VrSEJXZ0c5cmhoTUFEQVM1T1hSd1pXN0RsY1pOTHJSOURmd0hF?=
 =?utf-8?B?WENodXJYK3NKbUpsOC9xV0lvaDBEQTRqdllMR2Y5cGN6ekxkcnZlUnpQZXFC?=
 =?utf-8?B?UFgvTlBWVWpIWGNXb3QxMkd2WWEyZXg4SDEreFR1VGRhN2dDZDNHQjZwek9K?=
 =?utf-8?B?YnNuaEF1K1lUZklsTkpxV2h2WW1lSEhJR2ZCOE9ydTF5V1NwUHZWczZ1aGY2?=
 =?utf-8?B?a3NWU2lCYjhkVFN2eEVxTThSUVNCNGlreWNyK0xtejVLYzJRaVlHM1YzOHI4?=
 =?utf-8?B?OGRLT1BzQTBkTC9vTC96L2pTL1V1bDhNR0g1ZjZTOFJ4UFdBMTdGVVJMQjh3?=
 =?utf-8?B?eFJaRXIzV1kvVjd4dk9odi8xVzRSd1J5OG9yOHVtUEU2bEwycDlKVkU3N0tk?=
 =?utf-8?B?NWpUM0hJWmVmNy9zbkkrNlFxNGkzUDRSSnZaT1JhbFNCSFBOTk5kR1N1T2xy?=
 =?utf-8?B?d3ZZYlQydHJHaUlJRnk1c3VWZnV5QnRJN3hPaDhNZVBlV01kTDdra3FLZnNY?=
 =?utf-8?B?ZmRQalBiUTRsWjhiMkVTMHNOVytJbXhiaGVzcUlGRjBNcDJxM29LRlJpTkYw?=
 =?utf-8?B?OVgxcENCN0kzNVoyYzNmcjVYaEFUYmtTQXJ3L0dkWUdIOE9CdEhYNlY1cEpQ?=
 =?utf-8?B?cTVDVWtXODFiR1hWM2RvR3VFWWwrRTFGMlZwSEtCY0lxdkVXVUhNUmRCZ1ZI?=
 =?utf-8?B?b0JJVE9ld2lTOGg5QUxCVnRaQkc2cHRaNGZld3NNT1FyT2FrWkRpcjdhclBZ?=
 =?utf-8?B?bWVrQTVUYlJoMmtWT1NBV0g5aDVaNWhLSkFVSE5QQjZOYzAzcjFLdndFT2li?=
 =?utf-8?B?TnI3RFovd0lpakMxRitXcnR6U0FEbkxyY2MxUTN5RjJSZU45UCtWQ01oY29x?=
 =?utf-8?B?U2RzVGZqVzlVUUlGMzRuYXlqU0tmZFpJNVdPQmJaWVhBcDZBVHpTL20wL3ll?=
 =?utf-8?B?eU8vdmZ5SnZNbFNnM1pWVkxmRm1LUVU0VW55Nm94S2YzNzFuakNyYklnR3Rq?=
 =?utf-8?B?eTdMcUtkTW8xWENsdEZyOTNhVUJidWZxbDhEVDN3Q3F0am1kT1NRWGlSMy83?=
 =?utf-8?B?dm1UMlFIM29PcW9pc1J1NE15WDMrNWFlMFFHeWs3TWpFNkRYQytiSVVOSnhW?=
 =?utf-8?B?OVhRUmRiQVpJQXg4cldFRzVHTHA1UXBCUGwwUkhDTi94V0h3WVBrVlk4WkRP?=
 =?utf-8?B?MHZJb2NYUXVMRW9jUmlrbEpCRjFoSERScVdVN3VmNVJ3NUF5aFovQm9La2hK?=
 =?utf-8?B?cTJLWU4wQys1UlUySlpIR29BZWVrUlJMc1l1Wis2b3p0bmJMQnVvOUdXYUly?=
 =?utf-8?B?czh4K2lzd0RUZC9iUEdDZzArR0ZmYVpyN1pJK0dleU9VUlVnSi9VOC8wMTNh?=
 =?utf-8?B?ajVjeUZ3OFB2bEtBbmFwdVVnc01IeFlVaEduUHQvY2lpY1M3M1VLcithK2U2?=
 =?utf-8?B?ZGtUYmpEVEFsS0xYWGpLMVY4T3kvazJudW1GVTRxUzVybDBCRHhwS2RzOEd1?=
 =?utf-8?B?RTJPK0lLYmorczkzQTZncUlhMjVncSsyWkdxdFE0a1RMQTVVRFZ1blJTVHN2?=
 =?utf-8?B?cWZMeGZUcytQTTlNKzI1UTR0c0JreTFIU2xTRDR5alp6UzBTU3E0d3ZOc1Vr?=
 =?utf-8?B?YjlLazdUOTZMQktiQkdJd0dwcytQUmdnRXpWS3U0bG1oZnJsNWRUZUdhZEs2?=
 =?utf-8?B?WDVjVWdiNEQrWmhDUFZVa2ErczNjOFJkb3NGMWIzb0oveXpaSExDOVZRQWxK?=
 =?utf-8?B?R1dRaVB0MG9aL1ZjOFY1U1hYbVVQVEFFWmoyZEVNR0tpN3BTak50ZGk3UUs3?=
 =?utf-8?B?RjR3ZjRJNllEM3NTZVIxUHloTVFLdUtvSDcxMUI5L3VhSWNZcG9yYVU4RkIx?=
 =?utf-8?B?cjA0RGhCZVZ2RWQ2OEZpTHlMRnNLVkJ3L21BSDZFOWtQdy8zVmpkY3BlSUxX?=
 =?utf-8?B?aXV6TExVc3ZjMFBqSnNBRElVWVowZ1loQ3E4a0NxSXc0M0RMWk5ZZzNpOUhZ?=
 =?utf-8?B?dXNBUUNVOGV0eUM4WjBMSzNHMTNzbmNKQzFRMk8vNzR0UUllWE1BaXVTOWVu?=
 =?utf-8?B?dEU3czVQdHoyL0JIK2pRZ3RUbk83clpQZUFsYWg5cjhxamw0QSs1NXNvdVZL?=
 =?utf-8?B?Zm9iVXVVa2NydVEreWRMVlJXeDA1MDZyWFFSalFmbkpiVGZjU2RPeWdJaDR2?=
 =?utf-8?B?cFZWekpxdndzeXlEUlVVVHdMMERlNnlPdERZRzJYYXhaYXJUOE5LRXRYY1Vk?=
 =?utf-8?B?Q1ltbkhoc3hpQjZLNU1xRDZLazcxSE5LV0JDZENkQmdBc0p5Zm13NXFZZkxK?=
 =?utf-8?B?aGszOURqNUhpN1hyWXpiand2dDRUcllteHEvTDFCOE1BZmhYVk1tcVJ5UHVM?=
 =?utf-8?Q?86Z/3S6TkAJEPvjA=3D?=
X-Exchange-RoutingPolicyChecked: A3bdZTl05hOewcfZHppRad5AM98VTAInwJr9cmArGlMsvLwC8XYJiHBCCj4cX3NrgPW0kVEdb55OP9oqUoKlRh8PUYUQmlo2pz+uS8ocT4OjNf8CeRO14tQfLTgvCVuFSSebI44KE/EVqo08oqZh4mQ2s4bButfIEBClkRBYNeEBND26iItmXgCphtbzPsPz6XbCrewTwAw8U1Bz/KLIxApqgMbTZp2ozZ27v+KvLaQ6DPiLpQGlVszWkVaKkzT+JyYKQpb+R3Y86ejtTSs5AfgarvWAURCKcKOPP3onXRMV2Bn8WNGkW2wOHK+62pjAEYKOTZfTGP2vGZ+4eYuK8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34858af0-b11b-4547-21e8-08de8f885f73
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 00:48:21.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lniYaOpnKkE7tEm8xY9uNygOgtJoIY3yH53mfWs7a8IWA6fyIOp0LyYZpCh/fiZ8q5elGPohPru8jGxR0qFFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,google.com,gmail.com,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,gsse-cloud1.jf.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-232633-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D9DDC37347F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:22:08PM -0700, Matthew Brost wrote:
> On Tue, Mar 31, 2026 at 02:05:41PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Mar 31, 2026 at 03:18:39PM -0700, Matthew Brost wrote:
> > > @@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
> > >  	raw_spin_lock_irq(&pwq->pool->lock);
> > >  	if (pwq->plugged) {
> > >  		pwq->plugged = false;
> > > -		if (pwq_activate_first_inactive(pwq, true))
> > > +		if (pwq_activate_first_inactive(pwq, true)) {
> > > +			if (!list_empty(&pwq->inactive_works)) {
> > > +				struct worker_pool *pool = pwq->pool;
> > > +				struct wq_node_nr_active *nna =
> > > +					wq_node_nr_active(wq, pool->node);
> > > +
> > > +				raw_spin_lock(&nna->lock);
> > > +				if (list_empty(&pwq->pending_node))
> > > +					list_add_tail(&pwq->pending_node,
> > > +						      &nna->pending_pwqs);
> > > +				raw_spin_unlock(&nna->lock);
> > > +			}
> > 
> > It's a bit gnarly to open code locking and list operation. Would just
> > calling pwq_activate_first_inactive(pwq, false) one more time work here?
> > That'd trigger tryinc_node_nr_active() failure in pwq_tryinc_nr_active() and
> > the addition to the pending list. As this is quite subtle, it'd be nice to
> > have some comment - it's compensating for the missed pwq_tryinc_nr_active()
> > call due to plugging, right?

Sorry - missed a question.

It is compensating for early bail in pwq_tryinc_nr_active() due to plugging here:

1726 static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
...
1741         if (unlikely(pwq->plugged))
1742                 return false;
...
	     /* Add to &nna->pending_pwqs */

This far from my domain, so if there is different idea to fix this let
me know - takes 5-10 minutes on my end to test out.

The pwq_activate_first_inactive(pwq, false) suggestion works, so will
post that shortly unless you have another idea.

Matt

> 
> Yeah, I think that will work. Let me verify with my reproducer and
> adjust the patch accordingly.
> 
> +1 on the comment as well—very subtle. Took a few days of
> reverse-engineering work queues to track down.
> 
> Matt
> 
> > 
> > Thanks.
> > 
> > -- 
> > tejun

