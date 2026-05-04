Return-Path: <stable+bounces-243842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLKRA66v+GkPzAIAu9opvQ
	(envelope-from <stable+bounces-243842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729924BFD63
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 900003126C99
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95C3DFC60;
	Mon,  4 May 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQEYyck0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1880202963;
	Mon,  4 May 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905043; cv=fail; b=IEAUCbOOpENPLzcxsRGh7LT9TgioSqKBLLVUP1Z2UxC99K71cnFMA80c14ifQ2jzcRDQfUvrKgPRxxIwtPiG5u0A+fUUdlyR9s2DcAwodLSU1GPqZ/iOYTWBgo6Hh4Da/308icefojTa9FGvFunqo2qphf1mfstTugakmSC+r5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905043; c=relaxed/simple;
	bh=ehddM9z9mtvwqj/Mjyl7dl9whFBvGrQcL2Eq1mqDn4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BLMZ+hsWgyCGziUGZ4js/fWEmhEWG8LOj3Cl/q01/CbzuKs0yFkk2P/QqZNh4I7KYusXak4TtZvaUHkzGLMtEly2SzwpQ9FKfVZm+gEGWCYexfZ0KCwDSSganKNQKs6k3DpE+cRBPG2HKzD/X66DBy1qMFetNfm/NCz6WnZo+4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQEYyck0; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777905041; x=1809441041;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ehddM9z9mtvwqj/Mjyl7dl9whFBvGrQcL2Eq1mqDn4U=;
  b=TQEYyck0fjAkgSDTylM+8tRCJlQled1ctTJq76GEFoL3f8nQtA/3R6Xu
   IruwL7viFgEBJTcU6h5GN31hROKK474YScPPbllLfaZzVk2f8dMpGBedB
   P9PfGzpsefwSeThZ9L1T+cDmpiI1nA+G31SIk14uWyJ8ElpGkiWER62Pj
   XIwbQ2Z2pfZqkKkpnM4l/Vlkgqg3KedzecTXoPG2RXvzEzb3R/xCIiB7q
   FW4HQYJDM20Q6ygXa8L9Lcs06yvYqBIEPahy1Sdqedynfiije8aPDms5Q
   XDmVjxV1Qc/1qqni9cWSZOfpVFmgUcB8Ognj4UbE+qeSzBbMhuCJT883v
   g==;
X-CSE-ConnectionGUID: hQvo7VO6Rsi8yTUcoZrwAA==
X-CSE-MsgGUID: MMc13yp0R9SVgNfEVJR4jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78752791"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78752791"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:30:40 -0700
X-CSE-ConnectionGUID: Jb8SodncR4yn+EY/GLjSTA==
X-CSE-MsgGUID: g1wfy6CSSCGWyoSWCSsgUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265880309"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:30:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 07:30:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 07:30:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 07:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8QtjWQW0BK3CmqfLR3//mesb9FGVNUqVUGggwtOLyyf7u5rDfF8cN99Rh0FYBLrOI0hFKefFnBbx3rg1SvmYrLxF+YPu3N2ve/uhuS8qptzR9JLEOLBj7AdqfjWCrrkzcCBsXCIDBtJsKhbpc1B1txIHjv7OXxPmNlpFmNtN2h1aTDgQWpjeLWrO9IbTeiZNqKQBHq/YJ5iFY/mvR7MgOxpq9XJvY4HYlhW/2sGqIr9TiQTlbzEy1jsnprBRWFvg8DfaFPUTEdC0eYYLE2MdG9GY6HyyKNo/0wNb4nYAIVWYeEbLUXstmfQTFrdqs4aXOIS2diNioU4bo+4vo1YrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP7ExP1P4yH4A2rvabi+HqNE6N6h8kPQEhcfOy0oCf8=;
 b=ifCI3o2HBFgD69M4J1Vfp4XMqkwvDFLlGrjLn1OvazRNRQbpg4fki5PoPMCgKww5H7ymKk/rc0mhU4jEhdx9RTV+0nfcb7zi5Wt7+vRfmeWIXxbC93zMO0Z6jLKaIQ46ZGnGKXKmbMPoRMIpR2CROSlUGHa2guWlCXodNZLE+QzlgjjL4NBQJBO092puYSzif53TnYwSALSt/31TR4ubPET3knslAWPycEH3bWTbdTKCRY207IHh72vquxCtapCB06IQizRLhuH7N7hQlpCQjwJWYGmUDyXn00emSLkiH4iA2YhwN0na4SSxQH8iUTWJDmc2sMj39B3SvGYuwZ+T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPFC222DF22F.namprd11.prod.outlook.com (2603:10b6:f:fc02::4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:30:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:30:32 +0000
Date: Mon, 4 May 2026 07:30:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm/pool: back up at native page order
Message-ID: <afitheEYRoy7VoPu@gsse-cloud1.jf.intel.com>
References: <20260504042619.2896273-1-matthew.brost@intel.com>
 <58ea6837e2aa808bf9f3ba304395058a2d08b8d0.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58ea6837e2aa808bf9f3ba304395058a2d08b8d0.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPFC222DF22F:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f5171a-0090-4607-3742-08dea9e9b236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|20046099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PJaMJ9+mWbRnx+JdpuKTQLRcag0ZF4T55xqZu7mopYHY6Dtcjyxz0cTv6HQRDPkSlm5LKIndogcJecEZaBL4p8mlrsufm91XHfr6KW2gzp7tv/eNbgAZSbryZ+nHhQ2LTytCmnyyqeCjBxrtO8Mwug3PvggCFLipRS/HMeBT+pWZ654fQzLQSf1MCy7fkHldydI9Pyk9zxzCbrzaYYnyR5IqDTJW5qTCteeTPQg8Ps2oLJC5DYodoSO5UD8pAM+BT4nUrWdOL7TMcyc0CsJS3n7gfZdL/pn2XJcPO/6IvAohGXCqIO4hmSCeDhDn9xv5jVpEdeEn3Njn79mArOn8Dz0DmKZ6dwOj8FgnS/NrPZb7eHcymxflBpjeCvY9CKYof4JfRV+czNfrM5d6e5S6KQZzOL7CdMXqa9kVwaTDz9DPhV30jsSPdQaK+DN4upfppqy8MQymePnNRzzx5g8SUtS1tTm+GZOk75FmOBuLKyWvy4DE4UDXeKS1PK4hjsxCJpzLyUPr0tXJ5/bA4WPTEhhwr0L1WTqDJVr8StVMAu2cMLWls3dDML8TmHrEdaaCKhpRp2R0n5xDDAH6H3oAwrwEpT+6d4eVVKAaJMmAZh5HGqRLgqeN4geK20Vfc6a+B/ij4svL1X8DE5wK4EAXZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(20046099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBYbTV2QXk1VUJ2TURNL2I0aE1OVlYrcTgrT3h5ZytMTlYrb05JZnRFbjBj?=
 =?utf-8?B?UlY0NmFIKyswMCtUZzlZaWlFWXlwUWs1bm5jbm1TOGNOK1VxS0hPajM5eHd5?=
 =?utf-8?B?Zk84ejlPMHQ0ZzlsV1BXcjF6cFdzNmpOODU5SFlsR2ZzS29VVk56TldaT2d2?=
 =?utf-8?B?QWg3VlQ2S2dmMTVzWGtNMU9GVEVhd28ySk1wSU5rS2hsRmp4bVhjUm5jdXZ3?=
 =?utf-8?B?NTIvS01adFNrQjF3ajYwR2pCRVlWdjY1RXBxa2E1T2szeWNoYnIrWVlJU0Y2?=
 =?utf-8?B?MGZkNDg5TFhPUU8rbEV5aFF4aCs4R085aEswZGxpZHQrYjNOUmxzNUl2VndE?=
 =?utf-8?B?a3VJbTZPWTBTNTZma25OSkU5RlJ5R2hKNDBJajMyOVc3ditQSUxqSkkrMEU3?=
 =?utf-8?B?UnVuc3dSRk14ZVZSN3dJUGJ6UkNuOFBJM3JaTDREek1mVVpIUXB3TEhnK1F4?=
 =?utf-8?B?RitRTXN0Zk56MUhlWDFpUmZGRUV5bWxVb2NQREE3ZzdMYkxlalQ1OXNnQW1G?=
 =?utf-8?B?bVdEdHJTU0poNERyR0VTMnpNU2JUVVJTMWE2VjJyeE9iMnBxamRvZWsyblRH?=
 =?utf-8?B?aDZJNjVLTDFEM0w1U1R1bVB5eDlxVXZQYVMwTXcyR29QU3lvNGlLYy93anNs?=
 =?utf-8?B?eG9QRzFtSXpxM0RnaHpDb3BnQ2RsL09tWGwxUUZWVEN3RWQzTVltdEdMd1F0?=
 =?utf-8?B?MTZHS3VIYkFhUlFRNUFtWjVxYkwvL1JNT0w1bzdFSkkzOGllUG00NWRBbTYx?=
 =?utf-8?B?R01iaE1hVHY2SEQrT0lwb0M2NE5xUlhydTVxRU5pNGNsc0VaU1Fpa0RCK2Zq?=
 =?utf-8?B?akJIdmZ0dnRtZjJGYk1mcFc4UUFhcmhWbTVFcHV6VFQyVVNVQ0wwWXQ5b0tI?=
 =?utf-8?B?RWhVaUJrWXA5R212QW9tZVdZSHlGRER5Y1dZTEdaOTYvaFM3bW1RYm96TVA0?=
 =?utf-8?B?L29yN1ZSMVJpV0xMVTRBUGt4TVg4c2NiN1RlTkFXbHJ2a0phem9HYWRpcHN1?=
 =?utf-8?B?WCtmajFLV2FXdTJESHFEaXh6bWs5SXFRblg4blBidGs1TmNvS1lxUWtTUm1D?=
 =?utf-8?B?eHEzYmJrNWN6Y094cnJCOVJPWjlOUDlXRlQxd0RxMERnMXd5bVJNbHdTcDBS?=
 =?utf-8?B?Y1ZpZC9mcit6RkJkMllVbEZKR2hoZEtkNXp6SnFDa093S2tWZlFwQ01RSG9L?=
 =?utf-8?B?WVRjMGZmdi9FaDhxejYvTkV2SysyNU8wd1paUTZjS2tpbGFuQmdkMDRFejBK?=
 =?utf-8?B?dEttVHA1SUpTRWtQQ05sZnNObjI2NzRoVHhxaUViSnFPb3puVm5DZXRLbVQ2?=
 =?utf-8?B?Q0JpYXJnd1ZhbFJRM2E4SHQ0ODB3OGJaNVRGc25KL21NV1hxUFdlZ1lsbnB1?=
 =?utf-8?B?ZURUcVhOSFJVWXJJZnNZbmdLc3YxMk9aQzVsZEtjc2lFbFRGRmZsdEgzSjh2?=
 =?utf-8?B?cnpyV3pSTlBJcmFmSDcrL0czdFdkQ1RYREZkZ2ZOUTNoZklrZTVvMG9YSTA4?=
 =?utf-8?B?K2QrTHRoSTllQktSMUhDbHJWLzN6dlg3ejRFV05XQ2prWFRlRlFqb0NxS2U3?=
 =?utf-8?B?b3lNNnhtbWtCRjJCVnZEVkg5MVptaWxBUkxqa0tTQ2gzSTJkWXBuNmd6U0pM?=
 =?utf-8?B?OWlQOGZNSENBYjZBSXY5SWd1TjZrY0JzSmNONnYxZVVGUkZleEp6eHBlSHBY?=
 =?utf-8?B?VzdCNnBWaURxRFZCNFFraG0vQTZtU04rZDM2bnFtWENSSTAyNDMvckd4bHJL?=
 =?utf-8?B?ZWZ6K2dCQ2k3V0N6Um5mQWNabVRYNjE5QXJRRjJENU5GRWxoT1EyeGtNM20z?=
 =?utf-8?B?L3ZCMVBNd3dwb05jc0l1REhSYVh1MkpNeUpaOHIxYnp2NVN5a045ZnMrN3g1?=
 =?utf-8?B?aXRycVZxV1dWem9rN2h0WkM4U21LV21obEN1SUdrNi96Mm5FOEJ2ZUpXTkhJ?=
 =?utf-8?B?ekRCcVNsM0JNc1RJNHp0QUlSL2k2REZmRWhpVTVKQkxRYWNHNGFrd1pRaWpI?=
 =?utf-8?B?Wm1WQTJzZ3ZBY3VtZ2R2dHlUY29BSFpwdGVQZzZqYTdwN1BHL3hUcFNKOTVl?=
 =?utf-8?B?UVR4QTNEMzRGYURHdTQwVmlFN1FLa1BHWnpSR1dZMnJidkN1NFh0aE9CaW05?=
 =?utf-8?B?YjZlaThON2pNOTBSRkp4bGdTcWlyTHBTWndUQmR0L1oxOFQ3LzF2UG9pdWdX?=
 =?utf-8?B?aU4rT0NScXZ6Q29BUGp1b2NYMitjOHNlMEwvOHhHenZsMlpiWk9pSlV6R1Fv?=
 =?utf-8?B?ekZRaVJXeHhoVkdsck4xTS85WGlwZnEwRnNzTFQrdk1TdnRHSzNoTnJJc3hH?=
 =?utf-8?B?WHJOQkVoMDZQdXVBL2tDV0VPbk5oczVVaGxtQzhEVlFrVjNXS2hRQT09?=
X-Exchange-RoutingPolicyChecked: W+j+df7IMi0xU8RldDRgyKAUaAWtqivSw4Z/Re/lZmMxJnepeFx6ncxmpsgSAw/pwAlU2T8kjXvYncNEuLbWiYBmg56ERszu0pc+ucUDGepzdJJ8ObDekTlhQ3ABNG1hnoUjrWu1/dkqmB5aEQoqSLoqRedhIixdZVoGnUsMmMUcU3CWvXVc0CB49fBtcvVdZ6pZMl3ze9dcDrCEf0MHBnLwVa4eNLNDZFFuV6GJt087gCo/Qqg+QK+9cK50qr5jZNy0TxbyUQRDvumaI4gfwKs/RwJqP7m9RmmfrYmRmMFOKV6cgTMre4pTld16pTspZ1xOA+bzCoZ7Vr6OCnF0gw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f5171a-0090-4607-3742-08dea9e9b236
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 14:30:31.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SlPnLCi6RQrBppx9aOVTbTqGAmh/A2hCrJC8RdaNJIMEmy81l565WC9WxG/69iB+65kCTRZxe3usdeV0eHcYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC222DF22F
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 729924BFD63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243842-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Mon, May 04, 2026 at 10:35:23AM +0200, Thomas Hellström wrote:
> Hi, Matt,
> 
> On Sun, 2026-05-03 at 21:26 -0700, Matthew Brost wrote:
> > ttm_pool_split_for_swap() splits high-order pool pages into order-0
> > pages during backup so each 4K page can be released to the system as
> > soon as it has been written to shmem. While this minimizes the
> > allocator's working set during reclaim, it actively fragments memory:
> > every TTM-backed compound page that the shrinker touches is shattered
> > into order-0 pages, even when the rest of the system would prefer
> > that
> > the high-order block stay intact. Under sustained kswapd pressure
> > this
> > is enough to drive other parts of MM into recovery loops from which
> > they cannot easily escape, because the memory TTM just freed is no
> > longer contiguous.
> > 
> > Stop splitting on the backup path and back up each compound
> > atomically
> > at its native order in ttm_pool_backup():
> > 
> >   - For each non-handle slot, read the order from the head page and
> >     back up all 1<<order subpages to consecutive shmem indices,
> >     writing the resulting handles into tt->pages[] as we go.
> >   - On any per-subpage backup failure, drop the handles we just wrote
> >     for this compound and restore the original page pointers, so the
> >     compound is left fully intact and may be retried later. shrunken
> >     is only incremented once the whole compound succeeds.
> >   - On success, the compound is freed once at its native order. No
> >     split_page(), no per-4K refcount juggling, no fragmentation
> >     introduced from this path.
> >   - Slots that already hold a backup handle from a previous partial
> >     attempt are skipped. A compound that would extend past a
> >     fault-injection-truncated num_pages is skipped rather than split.
> > 
> > The restore-side leftover-page branch in ttm_pool_restore_commit() is
> > left as-is for now: that path can still split a previously-retained
> > compound, but in practice it is unreachable under realistic workloads
> > (per profiling we have not been able to trigger it), so it is not
> > worth complicating the restore state machine to avoid the split
> > there.
> > If it ever becomes a problem in practice it can be addressed
> > independently.
> > 
> > ttm_pool_split_for_swap() itself is retained for the restore path's
> > sole remaining caller. The DMA-mapped pre-backup unmap loop, the
> > purge path, ttm_pool_free_*, and ttm_pool_unmap_and_free() already
> > operate at native order and are unchanged.
> 
> This split is intentional in that without it, we'd need to first
> allocate 1 << order pages from the kernel's *reserves* in order to
> later free 2 << order pages, making the shrinker much more likely to
> fail in true OOM situations. (I believe this was one of the reasons the
> initial shrinker attempts from AMD didn't work as expected).
> 

So where exactly is allocation done—shmem_read_folio_gfp or
shmem_writeout? I did notice and called out, in the commit message, that
those interfaces are a bit confusing with respect to whether they
actually work with higher-order allocations.

Also, FWIW, this patch by itself seems to greatly help with
fragmentation, and I haven’t seen the OOM killer kick in. I’ve done
things like running WebGL in a bunch of Chrome tabs, then running
bonnie++ (which basically uses all memory), or running IGTs, which also
use all available memory. Based on that, I’m leaning toward this patch
alone working as designed.

> 
> I believe the solution here is in the ttm_backup layer, We should
> introduce a ttm_backup_backup_folio function and either insert the page

I think something like ttm_backup_backup_folio() makes sense, again I
called out in commit message.

> directly into the shmem object (zero-copy) or even directly into the
> swap cache. Then we should completely restrict xe page allocations to
> only allow THP and PAGE_SIZE (Possibly 64K pages, but they'd either
> need a split or perhaps they are small enough to be backed-up using

Yes, I did raise something like with Christian too [1]. IMO the driver
should be able dictate to TTM the orders it likely to allocate at.

[1] https://patchwork.freedesktop.org/patch/716362/?series=164338&rev=1

> one-go copy, similar to this patch, but in the backup layer). FWIW at
> the time the shrinker was put together, AFAIU SHMEM split large pages
> on swapping anyway, but since that appears to have changed, we need to
> catch up.
> 
> Inserting directly into the swap-cache WIP is here, rebased on a recent
> kernel (This is an old idea that has actually been out on RFC once).
> This needs a core mm bugfix (also in the branch), but I'm not sure the
> swap cache is the right place to do this, at least not if we don't
> immediately schedule a write to disc, it looks like current users don't
> want to keep pages in swap-cache for very long (related to that bug)
> https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/thp_swapping2
> 
> Inserting directly into shmem (A fairly recent idea that is mostly
> untested)
> https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/insert_shmem?ref_type=heads
> Since SHMEM schedules writeout immediately when pages are moved to the
> swap-cache, it's not as susceptible to the above bug, since swap-cache
> entries are not typically held for folios for which we haven't
> scheduled writeout.
> 

Let me take a look at these branches today.

> We should try to solicit feedback from mm people on these two
> approaches.

+1, but I think we should stop here if this patch, as‑is, is OK to go
in—ideally as a fix—since, based on my testing, it seems to help quite a
bit and current upstream shrinker is badly broken.

Matt

> 
> /Thomas
> 
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > shrink pages")
> > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > A follow-up should attempt writeback to shmem at folio order as well,
> > but the API for doing so is unclear and may be incomplete.
> > 
> > This patch is related to the pending series [1] and significantly
> > reduces the likelihood of Xe entering a kswapd loop under
> > fragmentation.
> > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > exercised; however, with this change the backup path no longer
> > worsens
> > fragmentation, which previously amplified reclaim pressure and
> > reinforced the kswapd loop.
> > 
> > Nonetheless, the pathological case that [1] aims to address still
> > exists
> > and requires a proper solution. Even with this patch, a kswapd loop
> > due
> > to severe fragmentation can still be triggered, although it is now
> > substantially harder to reproduce.
> > 
> > [1] https://patchwork.freedesktop.org/series/165330/
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 71 +++++++++++++++++++++++++++-----
> > --
> >  1 file changed, 57 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 278bbe7a11ad..5ead0aba4bb7 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1036,12 +1036,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  {
> >  	struct file *backup = tt->backup;
> >  	struct page *page;
> > -	unsigned long handle;
> >  	gfp_t alloc_gfp;
> >  	gfp_t gfp;
> >  	int ret = 0;
> >  	pgoff_t shrunken = 0;
> > -	pgoff_t i, num_pages;
> > +	pgoff_t i, num_pages, npages;
> >  
> >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> >  		return -EINVAL;
> > @@ -1097,28 +1096,72 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > should_fail(&backup_fault_inject, 1))
> >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> >  
> > -	for (i = 0; i < num_pages; ++i) {
> > -		s64 shandle;
> > +	for (i = 0; i < num_pages; i += npages) {
> > +		unsigned int order;
> > +		pgoff_t j;
> >  
> > +		npages = 1;
> >  		page = tt->pages[i];
> >  		if (unlikely(!page))
> >  			continue;
> >  
> > -		ttm_pool_split_for_swap(pool, page);
> > +		/* Already-handled entry from a previous attempt. */
> > +		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > +			continue;
> >  
> > -		shandle = ttm_backup_backup_page(backup, page,
> > flags->writeback, i,
> > -						 gfp, alloc_gfp);
> > -		if (shandle < 0) {
> > -			/* We allow partially shrunken tts */
> > -			ret = shandle;
> > +		order = ttm_pool_page_order(pool, page);
> > +		npages = 1UL << order;
> > +
> > +		/*
> > +		 * Back up the compound atomically at its native
> > order. If
> > +		 * fault injection truncated num_pages mid-compound,
> > skip
> > +		 * the partial tail rather than splitting.
> > +		 */
> > +		if (unlikely(i + npages > num_pages))
> >  			break;
> > +
> > +		for (j = 0; j < npages; ++j) {
> > +			unsigned long handle;
> > +			s64 shandle;
> > +
> > +			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > +			    should_fail(&backup_fault_inject, 1))
> > +				shandle = -1;
> > +			else
> > +				shandle =
> > ttm_backup_backup_page(backup, page + j,
> > +								
> > flags->writeback,
> > +								 i +
> > j, gfp,
> > +								
> > alloc_gfp);
> > +
> > +			if (unlikely(shandle < 0)) {
> > +				pgoff_t k;
> > +
> > +				ret = shandle;
> > +				/*
> > +				 * Roll back: drop the handles we
> > just wrote
> > +				 * and restore the original page
> > pointers so
> > +				 * the compound remains intact and
> > may be
> > +				 * retried later.
> > +				 */
> > +				for (k = 0; k < j; ++k) {
> > +					handle =
> > ttm_backup_page_ptr_to_handle(tt->pages[i + k]);
> > +					ttm_backup_drop(backup,
> > handle);
> > +					tt->pages[i + k] = page + k;
> > +				}
> > +
> > +				goto out;
> > +			}
> > +			handle = shandle;
> > +			tt->pages[i + j] =
> > ttm_backup_handle_to_page_ptr(shandle);
> >  		}
> > -		handle = shandle;
> > -		tt->pages[i] =
> > ttm_backup_handle_to_page_ptr(handle);
> > -		__free_pages_gpu_account(page, 0, false);
> > -		shrunken++;
> > +
> > +		/* Compound fully backed up; free at native order.
> > */
> > +		page->private = 0;
> > +		__free_pages_gpu_account(page, order, false);
> > +		shrunken += npages;
> >  	}
> >  
> > +out:
> >  	return shrunken ? shrunken : ret;
> >  }
> >  

