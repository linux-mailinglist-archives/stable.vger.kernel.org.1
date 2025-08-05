Return-Path: <stable+bounces-166634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2601B1B6E3
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A3F17D507
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD12798ED;
	Tue,  5 Aug 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLHH56Mz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3F279787
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405477; cv=fail; b=C5gK4Q11/ChFCMVTZoCiEtWFJx7hsx4RDrwTsORp7ncGC8hQRVtwymyiJV05DIltBKPpbfIXXYjtujlB5yF1GGqE5QjiMD/EuMs/1DmiXnq04b0ffHmHzLk8z8PmiDQBjNSbmyjc8FWgy92QjlLCZoFxYfYzqeHKRL4OYeWvE/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405477; c=relaxed/simple;
	bh=rdf/LQvPFXSGBx49nuuhzIeCqqmRHBaRGzjvXCg/ze8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dgfg0MEEwy0699L+yuZAijWeKtCHj4gaZSTVlej572CFLPYPCMFmjKcM8mnhiigy/iRziqpQeNZes62jg39opHaczYQu04ms2x5CxTmrYlYNSZRZQ0jxMtZ/SV58Y511hrVUFR1Z/wQ81sdI1xq4K7Gp9VkKGPDocHeyp7xK+WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLHH56Mz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754405475; x=1785941475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rdf/LQvPFXSGBx49nuuhzIeCqqmRHBaRGzjvXCg/ze8=;
  b=dLHH56MzfoucsTSPX1Ba+omAL2plDmkM93Rpcj/dAxO9gSEKo2hLRrkG
   VR4u1rsVXfRzvR76r06dHTfEIwUgKGpekQqMrsarK528EbHE9IMTytMu6
   zsOLfq4Nks04h4yLS/loRRAKmiETwAuK/fMj5YyrsOefuJq2lyoHI+7AI
   uNSaiMcy5vXMJKmcs5aCNLUwcjiFFDrTitYUA2xSqL1busJHulJft9jqJ
   ImTBjENKW8O0rXAn/M+7u4B9s27urmVwTCWihnk7xg/IuQyLtmRta/zi5
   xJfMrySXx67PfzFqGqb/OVJ74HaffMxhMRPRtXssRn82zR+c63JR0RPNK
   A==;
X-CSE-ConnectionGUID: +sZhz23XTiaZ/Yzl/KMYDA==
X-CSE-MsgGUID: BFjYNep1RsSQh61KAMjfmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60341436"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60341436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 07:51:13 -0700
X-CSE-ConnectionGUID: lrOlOAA7Q+yZxehWO3qU9Q==
X-CSE-MsgGUID: 8uXYIdROQimugj4i4h1lpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="164033623"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 07:51:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 07:51:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 07:51:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 07:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQtL64djQZDuFcvmEngC5Xw1+meXUG3vFIhyfDvFcRn3Pt3PU0AyT+HDLCaI/I2iZo3H/LzBSeKOamqLtspJJ+9OnEMkTe/1yl34EOQiiX8WUXiAs3CEZ4Xic6Ah6BtLCwccGwYYUXDnIAMVysfQjW/sVo7ZScEqll+Dz2apwwXaftjh8m9UxLopBjenOPzD9GWAnZSdlggqHueuKs9C8vScPa5qQX9nwRXpvJBydbD/17LjwXrgx0qfzLyvB8QOOswzDx/4TVegGjlBUi1hrCqv2nJHGlBJIlZU+ZaUnEKbnQoOLMe6gK2DAYzqDs6bwh+WvbBK3Noyj8WFeu3YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdf/LQvPFXSGBx49nuuhzIeCqqmRHBaRGzjvXCg/ze8=;
 b=R3DHav1OzerP1rUdusxlgFeMxr9iaFcj6WGOlWntZpYNeSunCGBhP6xMbvus8W7rW9XYKYX2LvGbiFXhKSK7vHJOMcaw03oVkuE1C0eCNLIFdIrRxZ69XQApFtUdKy9qcs8T4Fzr/rQ9n2Ot1+DYWeKpXvHP2+rhcStDDOsm9/85NVTgcRIN/L4iGQbOMroSQVNzXevP5u3SCu+fJawLapypmhY8YwyWiHJPWHH/jr9RSss6N3xGH7fsjdi53mYNnBG/9W1L4EfrohL10S6cFbV3KwBbvdAFV4GLQvXb57URT2HmMIXCOWpw+rjLAHfz7wOwmCmEhEDgaN56jkaswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 14:50:52 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::3f64:5280:3eb4:775b]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::3f64:5280:3eb4:775b%3]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:50:52 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "melvyn2@dnsense.pub"
	<melvyn2@dnsense.pub>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: Re: [PATCH v2] drm/xe: Defer buffer object shrinker write-backs and
 GPU waits
Thread-Topic: [PATCH v2] drm/xe: Defer buffer object shrinker write-backs and
 GPU waits
Thread-Index: AQHcBd119+tAtAoupEKEA1tjl2s2y7RUJO+A
Date: Tue, 5 Aug 2025 14:50:52 +0000
Message-ID: <4bb385f0f5ff5d40337cafb28dbd7d489758c586.camel@intel.com>
References: <20250805074842.11359-1-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20250805074842.11359-1-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|IA4PR11MB9277:EE_
x-ms-office365-filtering-correlation-id: 568163b3-1fe2-4ed8-c4a7-08ddd42f796f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qm5LVGtCZ1VBSGhuc1ZWanlKMzBwZ3FWV1NLRWRJM1pYclRwRm5PdDdsNWxL?=
 =?utf-8?B?RUVJOXlXOEdHbEhWSE15ajB6eW1waFMxdjVhb0Yyek9HTEh4Sm9IRlNsQ3lP?=
 =?utf-8?B?TWpwMmUySkpISVovS3VrbFRwWHlBVVgyeXFBWjBJSm03UlE5ZmROMUZJMy9V?=
 =?utf-8?B?NmlUd3FVNjhGam8vNmpLSzBXU1RFd01DSFNQeXZ2OE1aUHdLNWd2T2FrNjVJ?=
 =?utf-8?B?MVcydi8ybUw2VlRmZ3F1UGwwVHU1UkE5Qk1TL0dzRjhGdERHcmZhcFdXVGhl?=
 =?utf-8?B?aVdxWlZzU2RCcWh3L1hFREJBWVEyR2NvM21idjA2ZFFXTmtOdCtLOEFQQllI?=
 =?utf-8?B?SVIrYWU0RGU5TzBtTzdJWkRIaWFXWmFhcGxLR2lXcjJDTStCSmozeUx2U0N4?=
 =?utf-8?B?a3hsOGpaS2Foa2xLaDJEeHM5UmMrQUdOWFlHakVJSmFUTDBJcWVxL1pybTNT?=
 =?utf-8?B?ZmFObTNEaVJDaldjS1cvVGdJdTlyUGRKMVUzdlZySlRBM2Z5cENvYmhhSXdi?=
 =?utf-8?B?VUhZSUlva2lyQk1wUXMxeUJVUmdBSXRqNGluZVdaOXRXQXlWMThpMUh0SzJC?=
 =?utf-8?B?R3RYdnFrczBXZVY4MUlRZDRQY0JzS1ZyeGZCQ1JqUWlMcC9XYXZXUzVMUHhu?=
 =?utf-8?B?OVF4eWc5KytQSXIvVmNtK1ZKZ3lFUVNSTU1Pa25wa0VLRmUyL2srM2RLV3Mr?=
 =?utf-8?B?MkF4eGRTY3drR0daK0FJV2NRL0c2Q3NjSE02WFA4ZGFuRnVqQ1EvL2hJZkR0?=
 =?utf-8?B?UUxneHlZK3duVXNBK09kQVhWNWNYZnQzSlh5WnZFV3VyazNPMzhQSE9CeWJB?=
 =?utf-8?B?MnRxU0k0R01jcVVxSmVsWnN0WHV6Mzd0R0VFNndkZTVwRC9EaDF5RFh5YW1L?=
 =?utf-8?B?eGtmd0Zva095VzY1TUNJeW5XZnVweDVyd1RrQkhwM2YrN2JhN1FJbStrNDB3?=
 =?utf-8?B?dGJzOVVCaEJkdFpsZVV4U3g0RGszaFdNZHBSbWFrQXhKMUxHZVVDVnBaZ3ND?=
 =?utf-8?B?R05TWXRpTVJFK20rNUpVNi9wYnByQS9iNitSRmN2dExKOGRaRjU3a1Y1MVBV?=
 =?utf-8?B?MUErTnlIclVxcTBXQjRROTZXSUxhdVhYaXV1NmpTNUZDQTRKQ1Q2NDZHWjlW?=
 =?utf-8?B?Nkk3bERiU3N2NFI4dW10OGtOZ2NaQzVhOENTeWFFY3lrSUw5QTBDNW5NeU9x?=
 =?utf-8?B?Y0RLRlN4blh4cUFOS2N2ZGVZSm9HN25ZOUhmQ3dkTXNtS3hpTWJtRCtIUjBM?=
 =?utf-8?B?Z2MxR0lNUHN4ZHZ3MVRDL1NVS2xrVmlHNDhGdUVpaXUwUWFxajVtNHRwb2lx?=
 =?utf-8?B?N29QT0hPNXJxbWRjZDZnV2ZQUWtvM21GeXFCT29mc1dTUGdHUjVRUVNDQ05H?=
 =?utf-8?B?SXFqczREbzMxZXhtUmVONTh6VGRlZGIrSXcwQXZqSC9vcXpWa002NktodmVt?=
 =?utf-8?B?d05GcHN2MnUxbWxkSWYwNmxKNU9WelFnanhJQ0ZlRkNCcm56UDhBc3FMMS9O?=
 =?utf-8?B?K1E5dkFsT1kvTnN5L005cE02SHZDdkRlRXdVeW1sOTVReGtiYlo2dFhqWW9i?=
 =?utf-8?B?bDFxZXk2MFlYL3RWMk1BbzJXMWcyUWdEaDFQNUlNUkJ5dHk4M2hYTk1xaHF3?=
 =?utf-8?B?dnhOTTN0QWdVSkgzU21lS2UwVmpRMnRFcEl2Q1RGSktEaWxtQllQNG1OZmJv?=
 =?utf-8?B?NElhczZMUnVTNFFHWkdNSG1XVkNsSnR5Y2NMTnVBNVlZVUF4UFFTMFpuUWx1?=
 =?utf-8?B?V0d0ZzBaUkdHNk1STHA2Q2JUdXI2OHpiWE1kSlBQTTc5RFF3OG5zK0ZmbWFW?=
 =?utf-8?B?QjVzRVZaK3ZyWE9ncWVuNTlaSDRGbFhVemlsZkV4a1h4akQ0aFl4cVVVZElB?=
 =?utf-8?B?ZjZ0NWN3OEpEYS9GS292YXUrL01kTmdzYndUQVREZC9KN3dXZythMSt1Qy9F?=
 =?utf-8?Q?HGx25nALafQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDNiVjRHSk0xd3Q0WTZqVFBHdnIyQ3F4MzRpVDFJd1FSRGM1Y3kzMEJWN0U3?=
 =?utf-8?B?RVRwb2diNDJIRlduZldPK3kxRTFVT2xrOWhhUkQrRUZ1VEpYMnZpOGtJc1hD?=
 =?utf-8?B?TkhmWGJ0U2NINUFqNlI0MjR0cXpiSVF0ZnFoSXJwVWRxVExFSmVISlhDKzdq?=
 =?utf-8?B?NFhyKzdqbWh2citYNzZTRUN4MVAvelVGT1k2bDRvdjIvTW5VeVljMCtzT3BB?=
 =?utf-8?B?V3RTS2NJWXFHMzJjK0VRek01cC9sYks3MTVLVzBGa09IWXE0Sm5DUTVhQUNT?=
 =?utf-8?B?MWVEOGZNaHowNXlJVjVsdFZnd295UnVjSjBRNGVyVzVpdUhtdSt1RlRrVzFo?=
 =?utf-8?B?Zm45YmR1UnpFaXA0MjRHRE5UL1dqejlMZlBZVDB6MkgwMXY0WEF4Vm16eStY?=
 =?utf-8?B?UElJTC9aWmxCK25RRllKVXFSQk5Yd05YR1ArMnFWM0x3ZnRhRU5EM09yNS9q?=
 =?utf-8?B?RzJGZ3BVNVkwZXB4eHQrcFpEeE5NSklDY2dzVDNIbDl3a2gvenJWdlgrWGRS?=
 =?utf-8?B?MlNuUnBMeUR5a0Z5VUowV2Z5aS90Qmp2L2FTbVVxaXB4YlkxOFpXbEd2RWk3?=
 =?utf-8?B?d0Z3TUxrbGpaU3dSZGdzMHlQL0l6VW1QSU1kM1dMaUJDT0VQOTNpNkZpWGUw?=
 =?utf-8?B?bnV0WXJQNEdHNjVvTjUwb1pPN1B2akdSbG10dU8vdnI2N1ZzNkF6UFZBTk9X?=
 =?utf-8?B?dGlXaVIzazVRSXJZRm5JbkRZcWV2QmtwTk8rYjRKeGJscFB4UVRYVEFUNXQ0?=
 =?utf-8?B?NnpYMmZsMGg5M25MVllYZDNCQ3ByUW1YUHcwWWZHVVRpQWxZTVdUNnE3cWZr?=
 =?utf-8?B?NUdCL0RFdXhxaWFlUVp2bm95cGxsR1VwK3EraS9taVNpNnc2UGJyUkhNYUpO?=
 =?utf-8?B?L0JpaUc4N3FaT3RteEdNN1FIM3JJbzhyaHF3QU10cmRNd01wTkk2WTRZKzBq?=
 =?utf-8?B?dk5FUk5McnZzd28xSkE4a2tFTnpYWEcvWUtFeFhIalZwcjBIQTliUFpMNmZL?=
 =?utf-8?B?MEhUUTRNaXJGU3lZRTI5Mlk4K2ZuR0JjdEsrcTR0U0dERFVScUd2cHg0dWMr?=
 =?utf-8?B?aDF5N3F3L3dVZldZM1V2TVhoVDlwdmZPaC9uOTM2dmV5aDlzZVpJRy9NQTdF?=
 =?utf-8?B?Z0FyaVlYaGdkUUt6R0x2WWNhQzNaaUFMOXRUcThBYkV1Mk9veG9SczhQUkNy?=
 =?utf-8?B?dk14UGFMRllQM3NUdEJ5TnJ4UWNjMUZ5Wis4Zm1FbWc1SnBubndSRG5Wc0N5?=
 =?utf-8?B?UWFIRjZNSzRUdk5GbWZIMkdHMlpDZW1zejZwKzNhM2RBelBXVUk4Y2JGQVR4?=
 =?utf-8?B?K2gzYW55ZjJXR0ZXSWtTYjJ4WmdXcFZ6azluNVFLZHZIOWRadVMzYkZkc3Uz?=
 =?utf-8?B?VFE5cVpRcExwaE1pZURwdHRVdGcwajB1U0I2KzJkMnNHSTRqU2hSV0QyRzRR?=
 =?utf-8?B?VU9pSDhoN2tuNzl6T1Qxa1g0NW5xZEFkdWx0R2V2WVpZU1RtYVlBdERWU3RX?=
 =?utf-8?B?M1ZsaVpXcnNxdisyQ1BlS0x6eXRxbUNCSDNhMVk2dCtHdnh4RWxjU2F0SzJu?=
 =?utf-8?B?dDlkVWdnQlVKSnBwZmhEWHE4aUJLR0VoVERpZTB0NW9tNTRCU1ZDKzJWZ2ZK?=
 =?utf-8?B?ZWsrOENnZHNOdHI1UWZkVkg5SFRQcEdNeEV3aFVleDIxdmo5Ui9tSXNiYWhp?=
 =?utf-8?B?bUVCK0NHNlNiUzVBNXN1N0UxMEpPWnlyYy9nOVAxOXEwc1BhVmhsWnVxQjFL?=
 =?utf-8?B?RlZsNGc0S3ZCa1VFOXZnMW03RnpZTndvdnNlblRYbHdMRFl0eEthMENFeW9a?=
 =?utf-8?B?elEyM2RUdVRlMW52VDdWejA0WjMxVmVDa3BzdlF0TUF4RWg4NkI1K3NhSTBh?=
 =?utf-8?B?QjN4ZU5na21IN2hLSUF0ZEtIdEM4MkJ1S0xxYmpoK2pLMlZoZnNnamY0bllU?=
 =?utf-8?B?bVloR28xbEZxL2syTFJzWUlRSnloT0haVlVnZTcxaFA4OGY2TnhtUnZQWWZs?=
 =?utf-8?B?WjlJYkE4TXY1RTlQdXBFV05Xb05LV2llWk1ZVzJITTRPYUhUemkrcnNpY3Bu?=
 =?utf-8?B?RE5jdHY3dGVUeS90V1VUcloyYUhhTjdIVFUxUU13a0RjZGlPNHlsSEZlcDNL?=
 =?utf-8?B?eVNBbk1Fd0VRcmt4YnZRNVJERkR0bEhRdEdKUGlWVWpwZFBtNHNBNittU1Zh?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1F7D83E7A36FB4984243C0296D4D0C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568163b3-1fe2-4ed8-c4a7-08ddd42f796f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 14:50:52.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCjn9L129kukCfHza22IUT79yFublyfdiu/9yvQzPHkXgHmsmVV7jOTecHj5WpKWSF454UMXdBaZ2c2reKFxcL3DmO5ckz2P5jtcYhn5MtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA4LTA1IGF0IDA5OjQ4ICswMjAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToKPiBXaGVuIHRoZSB4ZSBidWZmZXItb2JqZWN0IHNocmlua2VyIGFsbG93cyBHUFUgd2FpdHMg
YW5kIHdyaXRlLWJhY2ssCj4gKHR5cGljYWxseSBmcm9tIGtzd2FwZCksIHBlcmZvcm0gbXVsdGlw
bGUgcGFzc2VzLCBza2lwcGluZwo+IHN1YnNlcXVlbnQgcGFzc2VzIGlmIHRoZSBzaHJpbmtlciBu
dW1iZXIgb2Ygc2Nhbm5lZCBvYmplY3RzIHRhcmdldAo+IGlzIHJlYWNoZWQuCj4gCj4gMSkgV2l0
aG91dCBHUFUgd2FpdHMgYW5kIHdyaXRlLWJhY2sKPiAyKSBXaXRob3V0IHdyaXRlLWJhY2sKPiAz
KSBXaXRoIGJvdGggR1BVLXdhaXRzIGFuZCB3cml0ZS1iYWNrCj4gCj4gVGhpcyBpcyB0byBhdm9p
ZCBzdGFsbHMgYW5kIGNvc3RseSB3cml0ZS0gYW5kIHJlYWRiYWNrcyB1bmxlc3MgdGhleQo+IGFy
ZSByZWFsbHkgbmVjZXNzYXJ5Lgo+IAo+IHYyOgo+IC0gRG9uJ3QgdGVzdCBmb3Igc2NhbiBjb21w
bGV0aW9uIHR3aWNlLiAoU3R1YXJ0IFN1bW1lcnMpCj4gLSBVcGRhdGUgdGFncy4KPiAKPiBSZXBv
cnRlZC1ieTogbWVsdnluIDxtZWx2eW4yQGRuc2Vuc2UucHViPgo+IENsb3NlczogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS9pc3N1ZXMvNTU1Nwo+IENjOiBT
dW1tZXJzIFN0dWFydCA8c3R1YXJ0LnN1bW1lcnNAaW50ZWwuY29tPgo+IEZpeGVzOiAwMGM4ZWZj
MzE4MGYgKCJkcm0veGU6IEFkZCBhIHNocmlua2VyIGZvciB4ZSBib3MiKQo+IENjOiA8c3RhYmxl
QHZnZXIua2VybmVsLm9yZz4gIyB2Ni4xNSsKPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0
csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+CgpDaGFuZ2VzIGxvb2sgZ29v
ZCB0byBtZSwgdGhhbmtzIFRob21hcy4gQmVmb3JlIG1lcmdpbmcsIHBsZWFzZSBhZGRyZXNzCnRo
ZSBmZWVkYmFjayBmcm9tIE1hdHQgYXMgd2VsbC4KUmV2aWV3ZWQtYnk6IFN0dWFydCBTdW1tZXJz
IDxzdHVhcnQuc3VtbWVyc0BpbnRlbC5jb20+CgpUaGFua3MsClN0dWFydAoKPiAtLS0KPiDCoGRy
aXZlcnMvZ3B1L2RybS94ZS94ZV9zaHJpbmtlci5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfc2hyaW5r
ZXIuYwo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3Nocmlua2VyLmMKPiBpbmRleCAxYzNjMDRk
NTJmNTUuLjkwMjQ0ZmU1OWI1OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVf
c2hyaW5rZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9zaHJpbmtlci5jCj4gQEAg
LTU0LDEwICs1NCwxMCBAQCB4ZV9zaHJpbmtlcl9tb2RfcGFnZXMoc3RydWN0IHhlX3Nocmlua2Vy
Cj4gKnNocmlua2VyLCBsb25nIHNocmlua2FibGUsIGxvbmcgcHVyZ2VhCj4gwqDCoMKgwqDCoMKg
wqDCoHdyaXRlX3VubG9jaygmc2hyaW5rZXItPmxvY2spOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyBz
NjQgeGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX29wZXJh
dGlvbl9jdHggKmN0eCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgeGVfYm9fc2hyaW5rX2ZsYWdzIGZsYWdzLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQgbG9uZwo+ICpzY2FubmVkKQo+ICtzdGF0aWMgczY0
IF9feGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHR0bV9v
cGVyYXRpb25fY3R4ICpjdHgsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB4ZV9ib19zaHJpbmtfZmxhZ3MgZmxh
Z3MsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQgbG9uZwo+ICpzY2FubmVkKQo+
IMKgewo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgbWVtX3R5cGU7Cj4gwqDCoMKgwqDC
oMKgwqDCoHM2NCBmcmVlZCA9IDAsIGxyZXQ7Cj4gQEAgLTkzLDYgKzkzLDQ4IEBAIHN0YXRpYyBz
NjQgeGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGZyZWVkOwo+IMKgfQo+IMKgCj4gKy8qCj4gKyAqIFRyeSBzaHJpbmtpbmcgaWRs
ZSBvYmplY3RzIHdpdGhvdXQgd3JpdGViYWNrIGZpcnN0LCB0aGVuIGlmIG5vdAo+IHN1ZmZpY2ll
bnQsCj4gKyAqIHRyeSBhbHNvIG5vbi1pZGxlIG9iamVjdHMgYW5kIGZpbmFsbHkgaWYgdGhhdCdz
IG5vdCBzdWZmaWNpZW50Cj4gZWl0aGVyLAo+ICsgKiBhZGQgd3JpdGViYWNrLiBUaGlzIGF2b2lk
cyBzdGFsbHMgYW5kIGV4cGxpY2l0IHdyaXRlYmFja3Mgd2l0aAo+IGxpZ2h0IG9yCj4gKyAqIG1v
ZGVyYXRlIG1lbW9yeSBwcmVzc3VyZS4KPiArICovCj4gK3N0YXRpYyBzNjQgeGVfc2hyaW5rZXJf
d2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0eCwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCBzdHJ1Y3QgeGVfYm9fc2hyaW5rX2ZsYWdzIGZsYWdzLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9fc2Nh
biwgdW5zaWduZWQgbG9uZwo+ICpzY2FubmVkKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBu
b193YWl0X2dwdSA9IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHhlX2JvX3Nocmlua19m
bGFncyBzYXZlX2ZsYWdzID0gZmxhZ3M7Cj4gK8KgwqDCoMKgwqDCoMKgczY0IGxyZXQsIGZyZWVk
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBzd2FwKG5vX3dhaXRfZ3B1LCBjdHgtPm5vX3dhaXRfZ3B1
KTsKPiArwqDCoMKgwqDCoMKgwqBzYXZlX2ZsYWdzLndyaXRlYmFjayA9IGZhbHNlOwo+ICvCoMKg
wqDCoMKgwqDCoGxyZXQgPSBfX3hlX3Nocmlua2VyX3dhbGsoeGUsIGN0eCwgc2F2ZV9mbGFncywg
dG9fc2NhbiwKPiBzY2FubmVkKTsKPiArwqDCoMKgwqDCoMKgwqBzd2FwKG5vX3dhaXRfZ3B1LCBj
dHgtPm5vX3dhaXRfZ3B1KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAobHJldCA8IDAgfHwgKnNjYW5u
ZWQgPj0gdG9fc2NhbikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGxy
ZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGZyZWVkID0gbHJldDsKPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIWN0eC0+bm9fd2FpdF9ncHUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bHJldCA9IF9feGVfc2hyaW5rZXJfd2Fsayh4ZSwgY3R4LCBzYXZlX2ZsYWdzLAo+IHRvX3NjYW4s
IHNjYW5uZWQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobHJldCA8IDAp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
bHJldDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZWQgKz0gbHJldDsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCpzY2FubmVkID49IHRvX3NjYW4pCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZnJl
ZWQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZmxhZ3Mud3Jp
dGViYWNrKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxyZXQgPSBfX3hlX3No
cmlua2VyX3dhbGsoeGUsIGN0eCwgZmxhZ3MsIHRvX3NjYW4sCj4gc2Nhbm5lZCk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChscmV0IDwgMCkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBscmV0Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVlZCArPSBscmV0Owo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGZyZWVkOwo+ICt9Cj4gKwo+IMKgc3RhdGljIHVuc2ln
bmVkIGxvbmcKPiDCoHhlX3Nocmlua2VyX2NvdW50KHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLCBz
dHJ1Y3Qgc2hyaW5rX2NvbnRyb2wKPiAqc2MpCj4gwqB7Cj4gQEAgLTE5OSw2ICsyNDEsNyBAQCBz
dGF0aWMgdW5zaWduZWQgbG9uZyB4ZV9zaHJpbmtlcl9zY2FuKHN0cnVjdAo+IHNocmlua2VyICpz
aHJpbmssIHN0cnVjdCBzaHJpbmtfY29uCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBydW50aW1lX3BtID0geGVfc2hyaW5rZXJfcnVudGltZV9wbV9nZXQoc2hyaW5rZXIsCj4gdHJ1
ZSwgMCwgY2FuX2JhY2t1cCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgc2hyaW5rX2ZsYWdzLnB1
cmdlID0gZmFsc2U7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBscmV0ID0geGVfc2hyaW5rZXJfd2Fs
ayhzaHJpbmtlci0+eGUsICZjdHgsIHNocmlua19mbGFncywKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnJfdG9fc2Nhbiwg
Jm5yX3NjYW5uZWQpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobHJldCA+PSAwKQoK

