Return-Path: <stable+bounces-106005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9C9FB364
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6D61884317
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0D482ED;
	Mon, 23 Dec 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zh7W8zyl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F213FEE
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973469; cv=fail; b=Knz1znxDhPybBjpSkY1WqKLLKTBPo0B85k87RrNsy7DZ8RVR4FSgatqx9YVRGIqe9rIt5V9oUDq2+9sl0hoe52PEKcyIhi2O5777aErd9D/+HZa+RKyo8h5FCaB1eyr91+JACl1+DWTUwzxRWuiindYjptrAFsOOuyotlh4Q6qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973469; c=relaxed/simple;
	bh=iJtKw68jOp9HhyOnCTIVWtTDi+wA6UWj4wET3V7swpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMuyvA8Fp8izDubjyf86EDOL3Gp3HDz8lAHgg2cAcNua/LleBTOfzIFoWh+3Gmqx3cv4C+iIgUGWrsENx2G6b8Ld/gw8WMKnxdqVD3plmHaaKsXexpN4WxLxqBdKZCgbQNKYgyWBFN3LJWm5Jin9qUH5FxKoFJT4pz/pRMtHgVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zh7W8zyl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734973467; x=1766509467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iJtKw68jOp9HhyOnCTIVWtTDi+wA6UWj4wET3V7swpI=;
  b=Zh7W8zyl1bwTWYdx4VcartDVsE7vrYZHw/OLLWm7nlAL9TiBzAVsUWyS
   /B+zDCsmZsatSjEU04U7d/anbgRAEJZG4X2ZTMOeOi8CLhn/paGJLCYOa
   Pbu0PCeWImK7c5aXT7oesHRTO+m94OQ/wl+ICW+UzUN8E2WDCPs/9PXC2
   Loj3eyhnNrBP5LUsCu/UY7WhxHuafgBJCEBniiMSrR9B+C6Nq0+73Xwdj
   +22BJtm5qYNMGdZLTynkUWbeY6EUZImWRw184Q5q088HoJ/43vHQE8LNc
   uBmp9YMXLQAH79Az7IB/mFnPsaTVOhk2ckNW31sIEhHLRSG80XEy1EShp
   Q==;
X-CSE-ConnectionGUID: OR5fFqyoSCGcgiT7+Vbg8A==
X-CSE-MsgGUID: rqs2N412QiuMhwbvVkPa7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52975057"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="52975057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:04:23 -0800
X-CSE-ConnectionGUID: PXkoSeXRSnSmWPJBKVVy/A==
X-CSE-MsgGUID: Cqs5Q4ytTNWPz7ySoqS2eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99618950"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 09:04:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 09:04:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 09:04:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 09:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArnRIXbPYEOA6j0umgqcwiEO7nVMFmXaNdWfDuF7/sZ3O+KR3pBPVvqj8OWpetNOgrxcJUvRQWYet11pxl5EpHnrx9RcxsBZKN4Xs0nfrlixxAAOvKJN5MeMalR5OrAgh9jwhMEE1d2JT9LJSJuhU+lVCrlGYd9xUavIR+SR+yg2pAkoYw2ps23miy5UQP7D8B8ks5KD+KzcPpmFz+34fIhweoGFRgWsLtGKoJtOON6T167vK6tfNyGzQDN05YhVfyEytESQxIxSapvEGxY2H2/KQOCyu0Fi961ZNMcDAwm78lgRb9ffMbrQkvwg7y54y1lfal9Kbfgv+omfNAQl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJtKw68jOp9HhyOnCTIVWtTDi+wA6UWj4wET3V7swpI=;
 b=Hz/9nI4+DO0x2LwtGSEpoF0KdWe/bSgiOqJ2owlEBlVwqXouslwSTk1vfDaIe7ig7uyvN8v4Z+nhYHhHsWUNRpv7biwSnjSP3TVyMR+JMxp/G0oLqHBOnjQH3X7VJhxpgDwAybRbyzgZt2nM3I7QDhbNlUyWNwChp4+Rbfk/B7VCA6mdW0zv0eYmZvdhMSodHbQcTvcAugUusEbpdN5WhcYdUhxE4y94ANw/bMKKWBb2+3+pTQKQbhMUX8yO5/flvFMdlng/GNhkwlpDqjjxkDuhNxIS+0xveoI7Vn6SSh1M3rN4g6yRpMIVPGvC+g9tsvY5WBjwXycaRtn/gYbVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by SA1PR11MB8376.namprd11.prod.outlook.com (2603:10b6:806:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 17:04:14 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:04:14 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Sousa, Gustavo" <gustavo.sousa@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, Radhakrishna Sripada
	<radhakrishna.sripada@intel.com>, "Roper, Matthew D"
	<matthew.d.roper@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: RE: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Thread-Topic: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Thread-Index: AQHbVUCsgs+ZYtk5+UGoWikD9+c/G7Lz9ltwgAAFpQCAABKAcA==
Date: Mon, 23 Dec 2024 17:04:14 +0000
Message-ID: <CH0PR11MB54442E6C87C856BFC904880FE5022@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
	 <CH0PR11MB544474672DC3D24C193A12B5E5022@CH0PR11MB5444.namprd11.prod.outlook.com>
 <0110c37448ee997bbede63911ab1d498d33a4a2f.camel@linux.intel.com>
In-Reply-To: <0110c37448ee997bbede63911ab1d498d33a4a2f.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|SA1PR11MB8376:EE_
x-ms-office365-filtering-correlation-id: 3f05529c-1390-4af2-cacd-08dd2373d402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXdMcHQ1ZUFNZHgrc0ZtS05CYnhzMCs4Ni91Q0tNWWZOSjk1NkVtd3d6czF2?=
 =?utf-8?B?UEpFdkFRVFhnRXVLUkhlZGVrbStSU2ZJd1luRnJsYlNteGlLREM0SEM2b1F0?=
 =?utf-8?B?M2ZQTEswL0dLcFBFdlFaU2NXS2F1bExHQ1owbllYalViS0Y3eXVzbUljb2or?=
 =?utf-8?B?RDZnM3dKYy9WZUg1MjV4RlFaeUNtME9yWWRRZFJDT29nR294NVdQY2F5clF4?=
 =?utf-8?B?NVhqRXQyNGFNQVJQU1hJc3ZndHpzZlJHbVNjRFNvTXVEeWszQVpDTk8vZVJz?=
 =?utf-8?B?Z2VoYjg1RTlYczZaWGdPcW9KcFlEdGhoa1BDS1BYV0t5ZWxOdjhxUHFHVHVo?=
 =?utf-8?B?ZVN3YUxkVkY1SUJnTlhNdzZIZGkzZmtydERuYVYyWnVFT0x0a3dxM0FxS05x?=
 =?utf-8?B?ZFZMRGdVMEx2eFZaZEF4bWk0eUVaMzVYbEI1cFkzRHRIdkhrcTcyYTVhalpn?=
 =?utf-8?B?eVNQakkzTTZ5YnF3WGhBUTdGdEdoUUJNRTZIWDVnaXFONWhsY2F3cC9aV3NQ?=
 =?utf-8?B?clpWMUhTNEJkenZNS09QcndkL1FCZWlWTllBVGZNU2htSS9aY0h5NEtFMmNi?=
 =?utf-8?B?d0pPb1hKZmZJaHloKzVqRzVwQkx1OFU2Z0k4ME03cVRsL0NYYkQ2ZU9nbW9v?=
 =?utf-8?B?NWVlL1JOMnhIWlRoaVhYaEFRT2c1WVI1QXd1WVdBZnF6MUpGdUkwSzV1SzIv?=
 =?utf-8?B?QWVQcTd1U2tCQTkwNFB2S0M2YWFWcmJ1STlHM3NINmMzWS9BTWs0WEQ4WG4v?=
 =?utf-8?B?UkpZOUwxcTlvUE9VTHZnTlNVeXllcWZkRmk3ZW93UTU4bVc0aENWR0hHQzNV?=
 =?utf-8?B?TFhySkRSKyttditjT0VzRmhOVXZycTl6UkR2b3dhNnVBM2JDU3JvME1taWll?=
 =?utf-8?B?MWtVMjhuVlFnZDNpTkxMRUdhYWhCMVl1UHJtVzFPek0vNEtvMnBRWmFadmFa?=
 =?utf-8?B?dFk5VnVsc1dnNDZYS2V6MXpMZGxPaTF1YmRSNWhkcjhKMDZxZko1dGthRXdF?=
 =?utf-8?B?QWhHK0NpSk5SdjhOMU5mVDBibWk3OHB1UlhZamtSTlBiWmp1QWNQQnlUdmhN?=
 =?utf-8?B?dFpyOHZHZG03TXZLNXI5RmxiWVpOZ3R0emtOWjRQNlhhVjBBM0NSaU1MUkN4?=
 =?utf-8?B?YnRrSWVrWklRTCtHbnp4cEs4WmRHTi90ZzNqRHVxNFpqRmlvdWdpQ1NNd1E5?=
 =?utf-8?B?NjdMM2dQaFVRR2w4N1JsOWNwOUxLTmdPcTVMNk9JRWU4OUNRejBXdWJGaGZp?=
 =?utf-8?B?VjRNekJFYmF3dDVqRWRTV3M0R3V4ZXdyUDQyemFpZTc3ek8yd3NmOE9KNmdv?=
 =?utf-8?B?TDZZOGJqSExxUzJwYnRsVCtKWnl2NEdxQWVGZndTQzBtUytYRTJUQzd0dzhu?=
 =?utf-8?B?bWtCcE51NDVpZTN1aUdvUEJVZnNpWW5wbTUrWnNQME9xeUNqOXFZcFNJTTFF?=
 =?utf-8?B?Qzd0VlF2TGg3N3J1WFdFUGYvSTFLalZ5T0EvZ3RESkJwYmtLMEhST1IyOE1v?=
 =?utf-8?B?RXZUbUJEUDV3UGkxa0Q5bE1lMlJaMXlMVURVSGxmMXpJVmttK1hzcEtBMjY0?=
 =?utf-8?B?UnNFVjVEN25WVzFHVWF1UGFROUtXMjcwRGFySmxOWHArQ2R0NDdMUURld2Fy?=
 =?utf-8?B?NCtEUzVNVUtMS2ZWV0dReHQxS0VnaTA3ZGd5cVY2c2I0RVJJUHlxNmtsYVpl?=
 =?utf-8?B?TytoS2RPRmNWZ1JzQk9LZXZsVERqdDRKSFJyc1hwYWRXdFpuQVE0b2d5T0o4?=
 =?utf-8?B?OXhHZlJBZmU4Q3lZWjRHUmtMVHExVEhJZUpsbC8wSjRnNTI4dEU5SGJnekdB?=
 =?utf-8?B?WVJCSXVVcWd5SHZQeTJHZW9SbnlXL3RJYTR6N2R4SWpMYnRzU1NOVUhUaEJY?=
 =?utf-8?B?MUo4QmpmRlNKTUtETEdVcnRRcG82eThEeG9hK2M4SFR6M3dCQjBNMnZQWUNv?=
 =?utf-8?Q?VVfaY1/J4G/WWdXx2pW0dnhT75V2LjQD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hEai9aT210Y0FyUGh5VU5rT0JYRHNqWGlRWDBtMDR2Yml3czE4Y21SaTFN?=
 =?utf-8?B?OHZsTG5ZVmFyOFhYVGZXcjlFZU95SWlKYnhQWWFzYzVtYUdqR1RERXAwWTNt?=
 =?utf-8?B?N1ZpVzgyVzFrdVhwK0N0Y3IwWFUwS1VUMXZpNHNKWGRvOWlwMi8xZEFNZDQx?=
 =?utf-8?B?WVpJdUdzZUpnVnRSaUZ1QTVLUDhpSnRuSCttUU9FeDhSaitVTXVaOXFaYTN3?=
 =?utf-8?B?aXNJTmhLcVBPNi8vdXBFclRNN3c3TFFoUVcwc1J2dURPNWltWkNtandOWlE2?=
 =?utf-8?B?MGtlTXVOM3NxdTV5aStLaXNOSUJXamtFb2s3NFYrRkxiY1VhTXpsV2pyNVBv?=
 =?utf-8?B?cFhzWHNFYll4eUxlWG42R3BxdU51VXMrNmxGQkhNaWZjbjZjS2pIaldLb0VL?=
 =?utf-8?B?TkJ3MFd0SlA1U2ZrMTBTNm9pdUcrQVVHWmVsQ3VUOFMxdCtRQnQ3RUlvOE5W?=
 =?utf-8?B?eWg0RWY1TWZKdTU4Zk51WWp5dS9uVjE2aEY2dkd3OWpETzl0cFAzY3AyU0dp?=
 =?utf-8?B?L2oxVXlFbkZkWE5Yb0ZnM3Y2NGtSNURub3RmNmZOcTMrQnJVcks0dWUxYk1i?=
 =?utf-8?B?V1NzenZzblZqU3luVGRrQ2IvalRRckFTRkE4QXJVazBqY1A4a25YYW1OZFFa?=
 =?utf-8?B?ek5aVzBkT0tlYW9LMXJzdDhNNXovRDJ4ZnkrbVdIODArcXdndVZ6aCtHYWQv?=
 =?utf-8?B?cHFWc1MwcGRRbDdKdUJtbFhvSTgyOVNRaFpOWDYrdTRaN20ySGFMcVBOU0NL?=
 =?utf-8?B?OUVhd0xuVlpIakl6VFRFQURkUU5sUjYvQ3g3a1pnaXZEVVY0WTNHVldwdWdG?=
 =?utf-8?B?Tk8vdFpySVAwK3ZXM0pVUXBaWW5SN3Z4QTJpa2Y2NlZoSzVyRE9HdEZyZFNp?=
 =?utf-8?B?SlRBMEhhTlREOHRhZzQ0WUZSOXZKT0RKN21GS3lOR3g1Skd5aTlSdHdhVk1H?=
 =?utf-8?B?OU9MYXhLTG1pUnhmVytXZVIreVN1NnZVYW5HRzFGUkNxNkxMeHhYUGc4Q0M1?=
 =?utf-8?B?OU5MZWN3cTUxNlNrbGF3NmxVQkkvbmtZMk5HQ2tIVFhVcUpLK3k5VU0xWCtS?=
 =?utf-8?B?a3psWWhaMWdieUVIV0hFSHBCNjI0QlVjL3RRSC9xZE9Vb2Y2ZHZvbWRTS3Mz?=
 =?utf-8?B?OXJmeTV4ZStRSUs1c1FaRXd1NFd2T1JtNUdHN2c4YVhqSDZCQ2xoWEdzK3Ni?=
 =?utf-8?B?YWNEd0JaMC9lUkdPdlJJY0Fod0lYN1B3V1ZVb1BzdnlpWFhIa3V0M1cybnpD?=
 =?utf-8?B?U29ZTnZRZks2Y0FGK1hHeDBkd0RUUmhuS2gydHBNOVhxZ2JrVDNSWnZ6aFVa?=
 =?utf-8?B?R1hxYjZtM042T2pSVkE3SnRmdDNMZFB3S1hkTjdKalJlRC9DTW5hd1hBa0RC?=
 =?utf-8?B?OHBRY0QwQzQ5UDd2Z04rWmRObjc3RlZvbEtkSlVtdm1WL0lZd1RKKzNVaW56?=
 =?utf-8?B?N1BpWjRsdHdPVFY3MjU0czZxN0NaZm02OHV5VGF6am5Xb0V2MzJzNzJXY1Y3?=
 =?utf-8?B?ZXlocWNQM3d2Y2lGTDdCajFRRm1vUFNvSk41cS9FdnhwUytrUTN1REw1NGF4?=
 =?utf-8?B?MFlaRS9UVlh5ekRML1NMZEdXS0NTemFkanowOHQvQVpBc2dBWnArSWpySVQv?=
 =?utf-8?B?L3FCejZZVmRrYkpuUFdMTVJVVU9INEh0blprQ1hYN0pweXNsUUNRZDFHYVl0?=
 =?utf-8?B?dFdaVWp5bVJrQzFIU3hFWjVNbHRLTFF1NENTbktITHlqWDdaQUJSdkszeWM4?=
 =?utf-8?B?djJpUmlyN0ZMSTlrN2RqZEM2aHBneVIyazZyRWZsRFd4MEd5TFZNU3dlZXZO?=
 =?utf-8?B?RzdxL3hvUVVabGliMjVhVTBBTUF3RHBnTjBxNFVaZ25BUXJML29STmtQVXFG?=
 =?utf-8?B?eVlaVjFyWkRXb3BvdUpOU2pGNEJPTGJ2bW4wUzJ3SmU0Y0V4OHFEamNhU2VS?=
 =?utf-8?B?bE91RHZOUEU1MDIyY1RJbW1LWnhQWmgvQXFFQm5YUkF3ei9vYTFvUWI1a1hl?=
 =?utf-8?B?V0xQelV2UVNsZjcvbTI4anVLbkZudnBWUVVVaXlGRmxrSk5wU2syUFN4ejRw?=
 =?utf-8?B?ajduWFYvSE1aOXI3RG9MRUwvYWhOcE4zdm5vK0JZeTVsV0J4TEc4anl1MXBJ?=
 =?utf-8?Q?RUcDXLAG+KOop1p5ssOI9KQ/D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f05529c-1390-4af2-cacd-08dd2373d402
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 17:04:14.1259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qI69blPS3VXjfMEbtUCrlAu60/s/z2K3BtryWxuzqlLcS9GMAavxOBrfL3lHRNk8nCGjv2U6DjkSuD+TM+ZnYl0rIlfBP1guswhfbq5Ejt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8376
X-OriginatorOrg: intel.com

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9t
YXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4gDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDIz
LCAyMDI0IDc6NTcgQU0NClRvOiBDYXZpdHQsIEpvbmF0aGFuIDxqb25hdGhhbi5jYXZpdHRAaW50
ZWwuY29tPjsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogU291c2EsIEd1c3Rh
dm8gPGd1c3Rhdm8uc291c2FAaW50ZWwuY29tPjsgRGUgTWFyY2hpLCBMdWNhcyA8bHVjYXMuZGVt
YXJjaGlAaW50ZWwuY29tPjsgUmFkaGFrcmlzaG5hIFNyaXBhZGEgPHJhZGhha3Jpc2huYS5zcmlw
YWRhQGludGVsLmNvbT47IFJvcGVyLCBNYXR0aGV3IEQgPG1hdHRoZXcuZC5yb3BlckBpbnRlbC5j
b20+OyBWaXZpLCBSb2RyaWdvIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPjsgc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL3hlL3RyYWNpbmc6IEZpeCBhIHBv
dGVudGlhbCBUUF9wcmludGsgVUFGDQo+IA0KPiBPbiBNb24sIDIwMjQtMTItMjMgYXQgMTU6NDQg
KzAwMDAsIENhdml0dCwgSm9uYXRoYW4gd3JvdGU6DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiA+IFRob21hcyBIZWxsc3Ryw7ZtDQo+ID4gU2VudDog
TW9uZGF5LCBEZWNlbWJlciAyMywgMjAyNCA1OjQzIEFNDQo+ID4gVG86IGludGVsLXhlQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiA+IENjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxz
dHJvbUBsaW51eC5pbnRlbC5jb20+OyBTb3VzYSwNCj4gPiBHdXN0YXZvIDxndXN0YXZvLnNvdXNh
QGludGVsLmNvbT47IERlIE1hcmNoaSwgTHVjYXMNCj4gPiA8bHVjYXMuZGVtYXJjaGlAaW50ZWwu
Y29tPjsgUmFkaGFrcmlzaG5hIFNyaXBhZGENCj4gPiA8cmFkaGFrcmlzaG5hLnNyaXBhZGFAaW50
ZWwuY29tPjsgUm9wZXIsIE1hdHRoZXcgRA0KPiA+IDxtYXR0aGV3LmQucm9wZXJAaW50ZWwuY29t
PjsgVml2aSwgUm9kcmlnbyA8cm9kcmlnby52aXZpQGludGVsLmNvbT47DQo+ID4gc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL3hlL3RyYWNpbmc6IEZpeCBh
IHBvdGVudGlhbCBUUF9wcmludGsgVUFGDQo+ID4gPiANCj4gPiA+IFRoZSBjb21taXQNCj4gPiA+
IGFmZDI2MjdmNzI3YiAoInRyYWNpbmc6IENoZWNrICIlcyIgZGVyZWZlcmVuY2UgdmlhIHRoZSBm
aWVsZCBhbmQNCj4gPiA+IG5vdCB0aGUgVFBfcHJpbnRrIGZvcm1hdCIpDQo+ID4gPiBleHBvc2Vz
IHBvdGVudGlhbCBVQUZzIGluIHRoZSB4ZV9ib19tb3ZlIHRyYWNlIGV2ZW50Lg0KPiA+ID4gDQo+
ID4gPiBGaXggdGhvc2UgYnkgYXZvaWRpbmcgZGVyZWZlcmVuY2luZyB0aGUNCj4gPiA+IHhlX21l
bV90eXBlX3RvX25hbWVbXSBhcnJheSBhdCBUUF9wcmludGsgdGltZS4NCj4gPiA+IA0KPiA+ID4g
U2luY2Ugc29tZSBjb2RlIHJlZmFjdG9yaW5nIGhhcyB0YWtlbiBwbGFjZSwgZXhwbGljaXQgYmFj
a3BvcnRpbmcNCj4gPiA+IG1heQ0KPiA+ID4gYmUgbmVlZGVkIGZvciBrZXJuZWxzIG9sZGVyIHRo
YW4gNi4xMC4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGU0NmQzZjgxM2FiZCAoImRybS94ZS90cmFj
ZTogRXh0cmFjdCBibywgdm0sIHZtYSB0cmFjZXMiKQ0KPiA+ID4gQ2M6IEd1c3Rhdm8gU291c2Eg
PGd1c3Rhdm8uc291c2FAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IEx1Y2FzIERlIE1hcmNoaSA8bHVj
YXMuZGVtYXJjaGlAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IFJhZGhha3Jpc2huYSBTcmlwYWRhIDxy
YWRoYWtyaXNobmEuc3JpcGFkYUBpbnRlbC5jb20+DQo+ID4gPiBDYzogTWF0dCBSb3BlciA8bWF0
dGhldy5kLnJvcGVyQGludGVsLmNvbT4NCj4gPiA+IENjOiAiVGhvbWFzIEhlbGxzdHLDtm0iIDx0
aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IENjOiBSb2RyaWdvIFZpdmkg
PHJvZHJpZ28udml2aUBpbnRlbC5jb20+DQo+ID4gPiBDYzogaW50ZWwteGVAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+ID4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTErDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBs
aW51eC5pbnRlbC5jb20+DQo+ID4gDQo+ID4gSSB0YWtlIGl0IHdlJ3JlIGhpdHRpbmcgdGhlIFdB
Uk5fT05DRSBpbiBpZ25vcmVfZXZlbnQgZHVlIHRvIGENCj4gPiB0ZXN0X3NhZmVfc3RyIGZhaWx1
cmU/DQo+IA0KPiBBY3R1YWxseSBpdCdzIHRoZSBXQVJOX09OQ0UgaW4gdGVzdF9ldmVudF9wcmlu
dGsoKQ0KPiANCj4gaWYgKFdBUk5fT05fT05DRShkZXJlZmVyZW5jZV9mbGFncykpIHsNCg0KQWgs
IEkgc2VlLg0KDQpUaGVyZSdzIGEgY29tbWVudCBhYm92ZSB0aGF0IFdBUk5fT05fT05DRSBhcyB3
ZWxsLCBhbmQgaXQNCm1vcmUgb3IgbGVzcyByZWNvbW1lbmRzIHRoZSBzYW1lIGFjdGlvbnMsIGFs
YmVpdCB3aXRoIGxlc3MNCnNwZWNpZmljaXR5LiAgTXkgUkIgc3RpbGwgc3RhbmRzLg0KLUpvbmF0
aGFuIENhdml0dA0KDQo+IA0KPiANCj4gPiBJIGRvbid0IGtub3cgYWJvdXQgdXMgaGl0dGluZyBh
IFVBRiBoZXJlLCBidXQgdGhpcyBmaXggaXMgZXhhY3RseQ0KPiA+IHdoYXQgd2FzIHJlY29tbWVu
ZGVkDQo+ID4gaW4gdGhlIGNvbW1lbnQgaW1tZWRpYXRlbHkgYWJvdmUgdGhlIFdBUk5fT05DRSB0
aGF0IHdlIHNob3VsZG4ndCBiZQ0KPiA+IGhpdHRpbmcsIHNvDQo+ID4gdGhpcyBpcyBwcm9iYWJs
eSBjb3JyZWN0IGlmIHRoYXQncyB3aGF0IHdlJ3JlIHRyeWluZyB0byBhdm9pZC4NCj4gDQo+IEkn
bGwgZG91YmxlLWNoZWNrIHRvIHNlZSBpZiBJIGNhbiBlYXNpbHkgdHJpZ2dlciB0aGUgVUFGLg0K
PiANCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhdml0dCA8am9uYXRoYW4uY2F2aXR0
QGludGVsLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gVGhvbWFzDQo+IA0KPiANCj4gPiAtSm9uYXRo
YW4gQ2F2aXR0DQo+ID4gDQo+ID4gPiAtLS0NCj4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3RyYWNlX2JvLmggfCAxMiArKysrKystLS0tLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV90cmFjZV9iby5oDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV90cmFjZV9iby5oDQo+ID4gPiBpbmRleCAxNzYyZGQzMGJhNmQuLmVhNTBmZWU1MGM3
ZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV90cmFjZV9iby5oDQo+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfdHJhY2VfYm8uaA0KPiA+ID4gQEAgLTYw
LDggKzYwLDggQEAgVFJBQ0VfRVZFTlQoeGVfYm9fbW92ZSwNCj4gPiA+IMKgCcKgwqDCoCBUUF9T
VFJVQ1RfX2VudHJ5KA0KPiA+ID4gwqAJCcKgwqDCoMKgIF9fZmllbGQoc3RydWN0IHhlX2JvICos
IGJvKQ0KPiA+ID4gwqAJCcKgwqDCoMKgIF9fZmllbGQoc2l6ZV90LCBzaXplKQ0KPiA+ID4gLQkJ
wqDCoMKgwqAgX19maWVsZCh1MzIsIG5ld19wbGFjZW1lbnQpDQo+ID4gPiAtCQnCoMKgwqDCoCBf
X2ZpZWxkKHUzMiwgb2xkX3BsYWNlbWVudCkNCj4gPiA+ICsJCcKgwqDCoMKgIF9fc3RyaW5nKG5l
d19wbGFjZW1lbnRfbmFtZSwNCj4gPiA+IHhlX21lbV90eXBlX3RvX25hbWVbbmV3X3BsYWNlbWVu
dF0pDQo+ID4gPiArCQnCoMKgwqDCoCBfX3N0cmluZyhvbGRfcGxhY2VtZW50X25hbWUsDQo+ID4g
PiB4ZV9tZW1fdHlwZV90b19uYW1lW29sZF9wbGFjZW1lbnRdKQ0KPiA+ID4gwqAJCcKgwqDCoMKg
IF9fc3RyaW5nKGRldmljZV9pZCwgX19kZXZfbmFtZV9ibyhibykpDQo+ID4gPiDCoAkJwqDCoMKg
wqAgX19maWVsZChib29sLCBtb3ZlX2xhY2tzX3NvdXJjZSkNCj4gPiA+IMKgCQkJKSwNCj4gPiA+
IEBAIC02OSwxNSArNjksMTUgQEAgVFJBQ0VfRVZFTlQoeGVfYm9fbW92ZSwNCj4gPiA+IMKgCcKg
wqDCoCBUUF9mYXN0X2Fzc2lnbigNCj4gPiA+IMKgCQnCoMKgIF9fZW50cnktPmJvwqDCoMKgwqDC
oCA9IGJvOw0KPiA+ID4gwqAJCcKgwqAgX19lbnRyeS0+c2l6ZSA9IGJvLT5zaXplOw0KPiA+ID4g
LQkJwqDCoCBfX2VudHJ5LT5uZXdfcGxhY2VtZW50ID0gbmV3X3BsYWNlbWVudDsNCj4gPiA+IC0J
CcKgwqAgX19lbnRyeS0+b2xkX3BsYWNlbWVudCA9IG9sZF9wbGFjZW1lbnQ7DQo+ID4gPiArCQnC
oMKgIF9fYXNzaWduX3N0cihuZXdfcGxhY2VtZW50X25hbWUpOw0KPiA+ID4gKwkJwqDCoCBfX2Fz
c2lnbl9zdHIob2xkX3BsYWNlbWVudF9uYW1lKTsNCj4gPiA+IMKgCQnCoMKgIF9fYXNzaWduX3N0
cihkZXZpY2VfaWQpOw0KPiA+ID4gwqAJCcKgwqAgX19lbnRyeS0+bW92ZV9sYWNrc19zb3VyY2Ug
PSBtb3ZlX2xhY2tzX3NvdXJjZTsNCj4gPiA+IMKgCQnCoMKgICksDQo+ID4gPiDCoAnCoMKgwqAg
VFBfcHJpbnRrKCJtb3ZlX2xhY2tzX3NvdXJjZTolcywgbWlncmF0ZSBvYmplY3QgJXANCj4gPiA+
IFtzaXplICV6dV0gZnJvbSAlcyB0byAlcyBkZXZpY2VfaWQ6JXMiLA0KPiA+ID4gwqAJCcKgwqDC
oMKgwqAgX19lbnRyeS0+bW92ZV9sYWNrc19zb3VyY2UgPyAieWVzIiA6ICJubyIsDQo+ID4gPiBf
X2VudHJ5LT5ibywgX19lbnRyeS0+c2l6ZSwNCj4gPiA+IC0JCcKgwqDCoMKgwqAgeGVfbWVtX3R5
cGVfdG9fbmFtZVtfX2VudHJ5LT5vbGRfcGxhY2VtZW50XSwNCj4gPiA+IC0JCcKgwqDCoMKgwqAg
eGVfbWVtX3R5cGVfdG9fbmFtZVtfX2VudHJ5LT5uZXdfcGxhY2VtZW50XSwNCj4gPiA+IF9fZ2V0
X3N0cihkZXZpY2VfaWQpKQ0KPiA+ID4gKwkJwqDCoMKgwqDCoCBfX2dldF9zdHIob2xkX3BsYWNl
bWVudF9uYW1lKSwNCj4gPiA+ICsJCcKgwqDCoMKgwqAgX19nZXRfc3RyKG5ld19wbGFjZW1lbnRf
bmFtZSksDQo+ID4gPiBfX2dldF9zdHIoZGV2aWNlX2lkKSkNCj4gPiA+IMKgKTsNCj4gPiA+IMKg
DQo+ID4gPiDCoERFQ0xBUkVfRVZFTlRfQ0xBU1MoeGVfdm1hLA0KPiA+ID4gLS0gDQo+ID4gPiAy
LjQ3LjENCj4gPiA+IA0KPiA+ID4gDQo+IA0KPiANCg==

