Return-Path: <stable+bounces-151452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88338ACE44C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228CC7A517F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BF202997;
	Wed,  4 Jun 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IokPPtEy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DA1FFC50
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061319; cv=fail; b=eA5usxCrPDvBtNp8pxU7+FuBBK1TarePguTCo1hvTuCG4v//YbVEeAwrEynooiJGsGUWJqTlu89gfhTPB++UgDn23dVG8fdLBISJrR56VP01FHJ3KKc+ubuhpaGYpsuktq/jxleLGcYyWcQIX7+QjtiwP3osMRq55JI3lYsjDLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061319; c=relaxed/simple;
	bh=uwR+6dfWdP2kXDsOAEccs4Xoj4j73g0AKD0zVb1Z1cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xv/jHkVd0+Sftg0WTC+SNm5/LecWJ/15GmSbxeVQQGhLXKNGcOhSt7NJ2lV+LN0/95QPgRfgvqcGVrc3X4YpozbwNJURSA66iE9iuh01yGW1t5rgbxhH9pnK99mLy4WNA4sqOoSXJ1K0d14XgyG9bxoYTXz2DEd1wSRcsV5KLck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IokPPtEy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749061318; x=1780597318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uwR+6dfWdP2kXDsOAEccs4Xoj4j73g0AKD0zVb1Z1cg=;
  b=IokPPtEy4AjX9r2ZaGycYA7UVbaeOkF7FwYSvmrtPK/zp/7YRJM7u7vt
   e/mKz+1OeDy4dNBsL/q4QLUrmRcdjUnJgnniZhJqXhiyQVuqFnrq79iPz
   ZvF3v7Nc8lFWcDFwgbo5AsXvM1LKCDVwXqZW2Yo26pzbhrIA/4ZlEzZOw
   TgE0v6qRwDxl1hJp5S3nmQn3pJUvBgeJHmpS3cJT260EzJR/zpAdYO1BR
   QaH7L927CJGMiVC7fkZpLh7dQ2KyZnyT8a/iovrmm6zG4b0OGvNwActMb
   Giub/TXUqxoVS9CluZ/n9bhrqsRoIg1y2sIzUvoU/MEckuu7sEbv1FYjV
   g==;
X-CSE-ConnectionGUID: XBwztyb4TMCK9jUcroCabA==
X-CSE-MsgGUID: 9c3OpOzCT5iVVzTPjTUxWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51029160"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51029160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:21:57 -0700
X-CSE-ConnectionGUID: L6UpYmDTSQCxwSxOi/Euow==
X-CSE-MsgGUID: f6nSQJ3OTzmcQZeD2jQ+mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="176231073"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:21:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 11:21:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 11:21:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 11:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y979rzVenZlfGptqk1UhaHeyaMcoXre8JCfMTgvDIn/ycpHC0KBGQ3MyU4smDhA36shK1IKiyro1KvY3e83eUtGIvqUfy0Lj9R8fQoa+/koijQt/2sk4mtMqKMIAp3KzB8tpcUGVD2FNCXjLV5erQ8OK/8psvQVFkYpZwXd5VMhrhkTDQYbnX6tXjMZrnH9YjnpsSr8r2aGzZGSpyFCGdlNQqL1xuBu9lLwd1jbhoM3p51lGKcZ0acfDiojsPYk1CFDs2YMX0gz0ZT4hvmEruY3sHurfzOBC3BJ7dEItkVRTbF4bsHC4S2llNOosQZcm25pAz3zNRK4Y+wGP1cifmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwR+6dfWdP2kXDsOAEccs4Xoj4j73g0AKD0zVb1Z1cg=;
 b=MK86/+VSbvBhPP2+qaHY+rh+ntm7+KeeybO1ZaR/LSkDYex5g2SnaUsU9KGp+RymVzJ4uOdu8IKi8/h8lYB5yAHq1TKNeQbdcGeekJo7ek+o53YGm+xgydE1nbvNYZ3+6+4AxvZ7bYGq2Mjm8WkyYgcdNFHgVvcu7FjAlBUe2rPCVw5OuGxivuPsM2OWWo5sUMhRlg3hRPe8WlSuolOUix79W0uDbGryLzTy4lewjWehZa/qnBnYQYBicfuJUR9Jp5KjDB4oUewh/lOPMkPMO+bmzMW/lR87UIuo4teUGDwntTil/0PLKSs0LSuj6hsylcPmnCJOjjk09oopL7df9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 18:21:54 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5f89:ba81:ff70:bace%4]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 18:21:54 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"Jahagirdar, Akshata" <akshata.jahagirdar@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: RE: [PATCH] drm/xe/bmg: fix compressed VRAM handling
Thread-Topic: [PATCH] drm/xe/bmg: fix compressed VRAM handling
Thread-Index: AQHb1Xy12+wi9m4QUk2b0jlNQFNUNLPzTtVg
Date: Wed, 4 Jun 2025 18:21:54 +0000
Message-ID: <CH0PR11MB5444A5B91EBE395713970E41E56CA@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20250604181511.1629551-2-matthew.auld@intel.com>
In-Reply-To: <20250604181511.1629551-2-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|MW4PR11MB5822:EE_
x-ms-office365-filtering-correlation-id: 119c8a60-3c2a-4cff-66e8-08dda394af0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OStpUTlVYVVTNXdzbVhncDkxakJqamkvKzNUc2tVeXkrajE0c2RrZ2dDWlZi?=
 =?utf-8?B?RjhQYXJtZTNIQ3pNY0drZi9rdkljQmZwTlEwWWJlb1M2Yk9pSEU3ZFdlME9V?=
 =?utf-8?B?OFJOclNMc2M2RFNwTzFKS01YQUVYQlIvTnF1cVRFWlhHTGhXZ0Z2dVprU0Mz?=
 =?utf-8?B?TWxkMUhwWXdvbGRxbk0yVlhjOENGWVg1THdGQ2pmdlJYK3pNOVNDbUNBZ3hv?=
 =?utf-8?B?bHdpT1ZzTEdta0lZUjByenhlSnRJdGpWVFJEK0p4R3doUTA0UGJkYkU4aUZX?=
 =?utf-8?B?NXpWYUVnaXJvNEd5eHJrdXpGZnR1R0RGSzFkMmRlNWJuWXMyRkNLMGszTG5K?=
 =?utf-8?B?bjBUUGJiYWVYYldBK1JwaG1mRndtNHcxTUZZODZ0bDBRVFNFVytoc3ptckUr?=
 =?utf-8?B?eGg1RVBoSW1Gd3JGQnRuVmRIQVBJaGRzOFI5Ly9CZjZPZFB1RmVJaE1EbjZJ?=
 =?utf-8?B?TkkwNTZHTGlhTm5jU1JzSE11ODZubUxqU3laY3h1enlpVzgxcWFYemFJN2xB?=
 =?utf-8?B?bTk1K1RVRWt4L3QrNVA1T3J5bUM3empsNjh5K2hIOUdVSFA1WkhyNGpobE1s?=
 =?utf-8?B?U3N5MjJSWHZBcUNKeFJ3RjR6TW05cTlQUWFHcEhIMW5EZmJtZ1hSUGdiWkJs?=
 =?utf-8?B?b25jd0c5MlJxQk5HMzhhZC9sVXBGNmp4M3RGNXFpNUJsa01Qam1iVFV0VENj?=
 =?utf-8?B?Z3lEbUk5OEFOOEJzL3M4ZTJISHd3RkRIK2FPdTdFNWl2citIMjdLMGFrK3Jh?=
 =?utf-8?B?dHJEQXcrTEdvVFNlelhtRFV4MTdtdExld0hHTWJCc0krczhuQldHakRlRkRI?=
 =?utf-8?B?Sy9EeTMrVU5VOFl3UkpNOEo5TkpERDVZOHBQNkJ1SUlOQnNpM2xqRi9BUWY5?=
 =?utf-8?B?UVBUbHJnbXY0ZEd3Ui9xWlpBaWprTFZsSlp5dW5wbXBIV2lhY1dlQlpHdlRJ?=
 =?utf-8?B?dGRva0s0NTgrZGU4eTBEc3llekx3UUJDZWxpTVovbmIycHIzc093eVFUcUpX?=
 =?utf-8?B?ZGhXbzZsUDg3ZVBsT3EzWTVBWVpjVXIwYnlBWFR3VGNMZkRMNnA4ZFdIVVZD?=
 =?utf-8?B?R3JvM0lORUgzejBUZElzY3l3M0lML1drYklyd1NtYnpxS2VFOVRXQmxVNnFI?=
 =?utf-8?B?MWo0N2c0WFFsck5RcWdGMHIrK1lPYitlVFo3L3FXZGYycHQ2eGF3YTNrQVlL?=
 =?utf-8?B?WGVMWWV5YmZuTGZOb2ZmV3VzcEdLMFJ1ZkVzdWppZ1lic0F2MUkzTzJoRkdr?=
 =?utf-8?B?akV5bnIrazVvZGZjeUk3UWNDbUZEdXNKQjVneXphQnIxbDFrSHVibnFXWUFV?=
 =?utf-8?B?aVovWkZWbG01K3ZLZnROY0h2TXdNczVkSWFGWmdjVEFIeTVTS2JTa2JZT2JH?=
 =?utf-8?B?emlMOFdvQ1RyTHVHZDR5b3VEdzBnREdYNGVjUXlYcHczM0xiOVJXWU85R2VI?=
 =?utf-8?B?RXEyWFlNZ0xhRGFncWZxQ1d4aElLU0t3QWhjRi8xQ3daelk0N1VpRkc2R2Uv?=
 =?utf-8?B?VlBpdVJkU2dGVW5jV2R0VVp0Skk0eFRFaE03a2ltUjhCaGFuckVCTHVEZEFL?=
 =?utf-8?B?a3JIcy9OdE4xQ3FCemx3N2VJbDc4WFdxdVNGMzEzekZlY01Cejd1NFg3OXlo?=
 =?utf-8?B?azczMThONUpqa2V5VlJiQXRhZ0YxRmwyS2pUUVQxUlRaamxTa0ZNRzBYYjRL?=
 =?utf-8?B?UEtGYktzSHYwcTJ3eXc4aTJydEUzQUJzQk9HREMySTNHUmdtV285UkhoL0FB?=
 =?utf-8?B?SzQvK0NaMDVGa3pQczZJam5qbDdBS1RFRVBJa2h6UXkvUWZRcTR4Z09oZ3o0?=
 =?utf-8?B?K0RRL2h4Mm16eGI3Zi9IeHRkZDhDSXV5ak54TUY4NVJld09hTlpJbWRKMWow?=
 =?utf-8?B?Tm1KNXFwUHhRZERqblVQVG1WWmIxdXUyQXc3Vm02aEdweDkrcEV2bjlWVCsx?=
 =?utf-8?Q?NqU9tk3kPuI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDFBOFQwaTdtZnpDUVpyaE5wZmVqWjBrbXo4NHRObHNxNUM1Y01NZHhRODBm?=
 =?utf-8?B?Vit6ZHpGN0g5QzQrRmxmNElFMHB5S3RvNUJ6TnJLMlRsbXR6b09kUTU4RzRK?=
 =?utf-8?B?ZU5qa2NPSnRiajNhQ0QwaFN4RUR0ZmN5OVp3OGZyN1dwSUxUSUtraHBCYmla?=
 =?utf-8?B?UVZESHZSYk5wYlorTDFuSFZ1ZE5FZnJOZGNUajFnZTROZXU3MDd6NFoyS0w3?=
 =?utf-8?B?czVEWmU4SE9iVUxUL0JzTU4waVdDeGtGeFVYdVdMUWl3SkNWNXJpQXNMV1gv?=
 =?utf-8?B?YjB1NTFmZDgwVTdxUFE3cG5qT2FoanpSYXFQNERyQUZtM3JlZXZMcG5uZTl0?=
 =?utf-8?B?Rk02YkkxbmhFbWF0NkZQZlg3U3U0bnN6dVhBaXhPU0puZGxubkFVL0JiZTIr?=
 =?utf-8?B?WU1oT04zalFYcXRPR3NKWll5YWQ0MDVLQ2RHdGJHVVQ5QmFYb3dEN2Z2dWt4?=
 =?utf-8?B?cVBQeHRST0greGI0eWI2VnJMZFdKRWc3bm9acU1LRFdjS0NDbVZzM0FObndm?=
 =?utf-8?B?YlphZThEME5WY1U2eTRJdEtFMUFTdVBoVGo2MVBoTDF2bzkyajZQVUM0bkRx?=
 =?utf-8?B?cDBDTjRmY2pKcVdReU5vcmZqVU9aTGFVMFRVK2NWVFJXQlpXbWtZbmhISTlk?=
 =?utf-8?B?VitDUmp0cDBQdGErMThkVm9PNGwzKzMvRkxTczV6b2JmVEc4d0JmaDJZSTE2?=
 =?utf-8?B?SG1UQzI4MUZNcjJHWll3NG9nSkFiaU5EUmpCcXJLOVNRUDZrS2hJcFhsamlO?=
 =?utf-8?B?QW5YQU4rcEI0am5FMjZmLzBlSDdDRUlpMXNlbkRzaXlKSkozWGxlc1hoL2kz?=
 =?utf-8?B?aFVLd01oaUtjSWpVakpOa3cvRGNERjFKdEMwM0xQQ1BkYklyRk5uc2psRnk3?=
 =?utf-8?B?NnJIcXRMQ3NJVWJVYnlHdGJvRnBieThGNHVqSmxDajY0c2JoNUsxZzBOQ2kr?=
 =?utf-8?B?UVV4bkpSR2N1aGg3SWc0Vks0WndRRUU1a0xkbVB4R2o0bkg5UVVJaGRCOGdv?=
 =?utf-8?B?UkRVUi9lUTNiZnp2NnpXcStMd0wySTlZMWpRREwzU2FSMGpaN2EwVWFuOVQx?=
 =?utf-8?B?dTJVYjNsOXYweGxnbUtsd0xOak9YSHlJK2RyL3J3K2pBd0ZoRGNnYkVhWlVI?=
 =?utf-8?B?d3dRVEV0anlHQjZ4K3JMN2x4cDV0VmlHbXE1SXhzTGh5VDJ0MllEV1FoTnlv?=
 =?utf-8?B?M05CbU83YllaUllDQmF5MTlIbU9jcWNnQmtreUFPTWJBYVNPaitsSlFoaFc3?=
 =?utf-8?B?RE5FQkNmcHBjaS9nZlBSZkdURkUxU2tsSVMzUC9uR2hLNUlZcDJhVWI3TnRV?=
 =?utf-8?B?NXpySDBwUXZZVVptU2t5RmYvbmM3RzdhNThlcERDTy9vTkZ6ZzNRbUM3amNN?=
 =?utf-8?B?b1RpYmNmaTZTV3lKNnNOYXdOT1h4Z0M2MDd1N3E1eUpvNXFBSHVuaDl2dDJv?=
 =?utf-8?B?dU5xRlFXdW1udFBHcEQ4eEl4c2hwVUZuSXMrSEdCbm45MzZ1L2k1bzV2dzh4?=
 =?utf-8?B?MWZOeG1jSG5kbks1ZDJQMCszWDMzNnV5UmZva1R5dU5xT1A1bHRaS1B3L1pX?=
 =?utf-8?B?LzlNd1E5bHZuWG11R2UvMzBtN0k4MkZyMlBvZWx0ZktWL0NVR0dCRk0rZ0k3?=
 =?utf-8?B?VXlmR1Rlb0V5M3p1VHVnUHVYZGJNUVNWRXVHbHJZZEJEWTFyT0JzUUxESUVk?=
 =?utf-8?B?OHdEY0tJMG1GQk9raWVVL3pHcU9UODBSQkxGWmxmUm5RZ1FpRlR0QWpVNnVo?=
 =?utf-8?B?TWZJU2psZTFTdjcvSi9YVytrZ1N0cFNVQ01wdHpLTnBMb3N5TmlZMDlCRXhE?=
 =?utf-8?B?NXdOK3R3OUhTSDJoVmtyNUZ5QWh1anNFN3lqeHIrMUZnbjc5eThTTkVTbHlE?=
 =?utf-8?B?ajFEQ1FhdGNPOGZEdUh4QWRSQ0hYdEtuNzNvbHI3VThGbjFFTmdYWFFDTEVr?=
 =?utf-8?B?WEhFOGE1TjN2RVQ5WUo0WUJ3UnV0NXF3eXAxWEVmbm8wOVozTzZ3eWxaYWM1?=
 =?utf-8?B?Y3E4OGJSQmhodVNVWGRZNHIxUG5Oa0NGdzFMdnpLM3BheHlBamJrREUzcHRj?=
 =?utf-8?B?bG5sRDNDNkVENStWMWx2YWJ3OHREbWxQakZTZTJZek4rMlVjakR3czdHNVRl?=
 =?utf-8?Q?sh2IMq8GWPbcHWFUBLuGzL88A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 119c8a60-3c2a-4cff-66e8-08dda394af0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 18:21:54.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UBuEmQTVreBC+bMDSJLfczE73gcCZkaz1cFngkF+00PBV3X+0sMQcRgGD7sQqEI2ht3agghS9Q0zZJTmVAz+IYEo9bIBrJt4Zr3+r9Idew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEludGVsLXhlIDxpbnRlbC14ZS1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1hdHRoZXcgQXVsZA0KU2Vu
dDogV2VkbmVzZGF5LCBKdW5lIDQsIDIwMjUgMTE6MTUgQU0NClRvOiBpbnRlbC14ZUBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCkNjOiBHaGltaXJheSwgSGltYWwgUHJhc2FkIDxoaW1hbC5wcmFzYWQu
Z2hpbWlyYXlAaW50ZWwuY29tPjsgVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21A
bGludXguaW50ZWwuY29tPjsgSmFoYWdpcmRhciwgQWtzaGF0YSA8YWtzaGF0YS5qYWhhZ2lyZGFy
QGludGVsLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSF0gZHJt
L3hlL2JtZzogZml4IGNvbXByZXNzZWQgVlJBTSBoYW5kbGluZw0KPiANCj4gVGhlcmUgbG9va3Mg
dG8gYmUgYW4gaXNzdWUgaW4gb3VyIGNvbXByZXNzaW9uIGhhbmRsaW5nIHdoZW4gdGhlIEJPIHBh
Z2VzDQo+IGFyZSB2ZXJ5IGZyYWdtZW50ZWQsIHdoZXJlIHdlIGNob29zZSB0byBza2lwIHRoZSBp
ZGVudGl0eSBtYXAgYW5kDQo+IGluc3RlYWQgZmFsbCBiYWNrIHRvIGVtaXR0aW5nIHRoZSBQVEVz
IGJ5IGhhbmQgd2hlbiBtaWdyYXRpbmcgbWVtb3J5LA0KPiBzdWNoIHRoYXQgd2UgY2FuIGhvcGVm
dWxseSBkbyBtb3JlIHdvcmsgcGVyIGJsaXQgb3BlcmF0aW9uLiBIb3dldmVyIGluDQo+IHN1Y2gg
YSBjYXNlIHdlIG5lZWQgdG8gZW5zdXJlIHRoZSBzcmMgUFRFcyBhcmUgY29ycmVjdGx5IHRhZ2dl
ZCB3aXRoIGENCj4gY29tcHJlc3Npb24gZW5hYmxlZCBQQVQgaW5kZXggb24gZGdwdSB4ZTIrLCBv
dGhlcndpc2UgdGhlIGNvcHkgd2lsbA0KPiBzaW1wbHkgdHJlYXQgdGhlIHNyYyBtZW1vcnkgYXMg
dW5jb21wcmVzc2VkLCBsZWFkaW5nIHRvIGNvcnJ1cHRpb24gaWYNCj4gdGhlIG1lbW9yeSB3YXMg
Y29tcHJlc3NlZCBieSB0aGUgdXNlci4NCj4gDQo+IFRvIGZpeCB0aGlzIGl0IGxvb2tzIGxpa2Ug
d2UgY2FuIHBhc3MgdXNlX2NvbXBfcGF0IGludG8gZW1pdF9wdGUoKSBvbg0KPiB0aGUgc3JjIHNp
ZGUuDQoNCkl0IHdvdWxkIGJlIGJldHRlciBpZiB3ZSBoYWQgbW9yZSBjb25maWRlbmNlIGhlcmUg
YmV5b25kICJpdCBsb29rcyBsaWtlIg0KKG1heWJlIGp1c3QgZHJvcCB0aGF0IHBhcnQpIGFuZCAi
VGhlcmUgbG9va3MgdG8gYmUiIChtYXliZSAiVGhlcmUgaXMiIGluc3RlYWQpLA0KYnV0IGlmIHdl
J3JlIG5vdCBjb21mb3J0YWJsZSBtYWtpbmcgZGVmaW5pdGl2ZSBzdGF0ZW1lbnRzIGFib3V0IG91
ciBjb21wcmVzc2lvbg0KaGFuZGxpbmcsIHRoZW4gSSB3b24ndCBibG9jayB0aGlzIG9uIHNvbWUg
bWlub3IgcGFzc2l2ZSB2b2ljZSBpc3N1ZXMuDQpSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2F2aXR0
IDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPg0KLUpvbmF0aGFuIENhdml0dA0KDQo+IA0KPiBU
aGVyZSBhcmUgcmVwb3J0cyBvZiBWUkFNIGNvcnJ1cHRpb24gaW4gc29tZSBoZWF2eSB1c2VyIHdv
cmtsb2Fkcywgd2hpY2gNCj4gbWlnaHQgYmUgcmVsYXRlZDogaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS9pc3N1ZXMvNDQ5NQ0KPiANCj4gRml4ZXM6IDUyM2Yx
OTFjYzBjNyAoImRybS94ZS94ZV9taWdyYXRlOiBIYW5kbGUgbWlncmF0aW9uIGxvZ2ljIGZvciB4
ZTIrIGRnZngiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBp
bnRlbC5jb20+DQo+IENjOiBIaW1hbCBQcmFzYWQgR2hpbWlyYXkgPGhpbWFsLnByYXNhZC5naGlt
aXJheUBpbnRlbC5jb20+DQo+IENjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJv
bUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBBa3NoYXRhIEphaGFnaXJkYXIgPGFrc2hhdGEuamFo
YWdpcmRhckBpbnRlbC5jb20+DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni4x
MisNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfbWlncmF0ZS5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX21pZ3JhdGUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV9taWdyYXRlLmMNCj4gaW5kZXggOGY4ZTlmZGZiMmE4Li4xNjc4OGVjZjkyNGEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9taWdyYXRlLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3hlL3hlX21pZ3JhdGUuYw0KPiBAQCAtODYzLDcgKzg2Myw3IEBAIHN0cnVj
dCBkbWFfZmVuY2UgKnhlX21pZ3JhdGVfY29weShzdHJ1Y3QgeGVfbWlncmF0ZSAqbSwNCj4gIAkJ
aWYgKHNyY19pc192cmFtICYmIHhlX21pZ3JhdGVfYWxsb3dfaWRlbnRpdHkoc3JjX0wwLCAmc3Jj
X2l0KSkNCj4gIAkJCXhlX3Jlc19uZXh0KCZzcmNfaXQsIHNyY19MMCk7DQo+ICAJCWVsc2UNCj4g
LQkJCWVtaXRfcHRlKG0sIGJiLCBzcmNfTDBfcHQsIHNyY19pc192cmFtLCBjb3B5X3N5c3RlbV9j
Y3MsDQo+ICsJCQllbWl0X3B0ZShtLCBiYiwgc3JjX0wwX3B0LCBzcmNfaXNfdnJhbSwgY29weV9z
eXN0ZW1fY2NzIHx8IHVzZV9jb21wX3BhdCwNCj4gIAkJCQkgJnNyY19pdCwgc3JjX0wwLCBzcmMp
Ow0KPiAgDQo+ICAJCWlmIChkc3RfaXNfdnJhbSAmJiB4ZV9taWdyYXRlX2FsbG93X2lkZW50aXR5
KHNyY19MMCwgJmRzdF9pdCkpDQo+IC0tIA0KPiAyLjQ5LjANCj4gDQo+IA0K

