Return-Path: <stable+bounces-195201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01485C710F6
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 21:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EE7B428E23
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C481F2C45;
	Wed, 19 Nov 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+yXMYkV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF51DE4CD
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585136; cv=fail; b=BW3reBsJGHFhDwARHT/L90OGVVMibM5/qJAH5S3Ma0BJIt8LAV0ZcpgRMPnbgY5CM4UOgGzMxH+TXEclH06LH9gQmq3GflFqf977WTfZE9sEnjM/SyAxyJUL1RE6BlGWhINnLUVDpRqjLdrDFjl3zNPe9vSLWFwUAU27swh7ZDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585136; c=relaxed/simple;
	bh=hCaOgftKbi+leUPNQPHGGM/vVN9BF8hbjbMQpBpfm1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2Iu97JSt5XyekU+KHDlDglzYEjrmjKdK9nE6gl5GfLggS+Th2c4W7+5BUFi+vJD6DU5zzOr7J5H1sdFujXScpXNffcJmqZSvQ0SVil1b3JIF7MONQxZzwlc2fJ7sgvZ1ATlAcotkt8yhi8I+m0anfWvaRszbx8ezesHaSgn3x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+yXMYkV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763585135; x=1795121135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hCaOgftKbi+leUPNQPHGGM/vVN9BF8hbjbMQpBpfm1g=;
  b=n+yXMYkVVoRkzCZ/+1Fd48TeJba4TO2RzxiUa8AYPYVsLTHHXrWYUrm0
   ffzWWjcZAvCi/8P4O1paouTo2K+518+LB4IEWGUugjpKXU5U6p4LQqNhP
   2heP3Xe6jGdS/uxRFcV0IkO2MWlYCw6UvXt2BNtzC9LkUvA+VwSJEd0VU
   s+uTUzpwdOYgW414XS5BukZRzZEVLWgneVKhiW0za7qLaYWA3j/e5Rds7
   TTNd8DSvKep1/2wW9jCj2KVTBhyN84Ugs1CLeUTVOgQ4QHe+V2J5Y7RRz
   W0sDwdx6Vw5sS1mRsJkCHVg10w7bev7V+ebWGF4nTb21G/P0dssA2bMxH
   Q==;
X-CSE-ConnectionGUID: aujfO+H0St+JE5bZovqUoA==
X-CSE-MsgGUID: ZCCae8NjQXyOsA+ggn8oQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83264995"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="83264995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:45:34 -0800
X-CSE-ConnectionGUID: DsLESqzQQCmPza1iMW2LrQ==
X-CSE-MsgGUID: +0m5qnbTTTuVCbKn3H/8iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191600449"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:45:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 12:45:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 12:45:33 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 12:45:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNd+BJer+nSktxrsaEGZIeElcGIoFPReZzmI4Bm8ZhKqxR+u4oxcSKozmUfG2fOwK292duNNJsgj5AN2JdssZ6YXVnQqPkJoWxIPvc9uhJX4BIP85Ybh0hBQ5WDG8sWgiXd6BNTKvtgEqdAqB4q89rRX4NAncCW4G8/Gc2hGl59ggsQUa6gztF/CuOzkWo63ApgrZpt/V1dqo5E1Q/cc2ndY8e+pS8Kf2fdAsUlDRNNFvz75IewQOXbLlnPwxf00KtMcckerrVRgcJW8Fy9/vg75HQyYYwe6hFHUieWJDGLh11+N7aAdUZpr1vkm/JihJVWPzmWmrEfpz5NGQ3Zg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCaOgftKbi+leUPNQPHGGM/vVN9BF8hbjbMQpBpfm1g=;
 b=ndyOWxeYD2lMF07IsvSaoHek57biqIZqG2tQdNcYCGcRyrXj6vZTzMP7hv33msYzTHBHHtxKFElrQ1jaL0JwvUpDzO6yDNhHwakmYDQ0dy6aWnKqTSNKfdDA0dAjzUt0IKFXB6j0UCH+hZyO/CwQ4shP+AdZWinJR7JeezSgs21gN11eYuy6kwOOeqYjk3cXwbDmmNx2Sf5tXeHNUg7MKGlW0KEIaJF5cb2z0xCj/skh33Gnsn8wtVgZgtGMIpgP5LjfvFtERVdZD10Q9buW3n/niOb3OzQVydT9+zHF4T2nQCQ+5Q2X0Px9Yp+EzPgYWSZj0ldGNMsLWJhise48VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by DS4PPFA424F92C2.namprd11.prod.outlook.com (2603:10b6:f:fc02::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 20:45:32 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 20:45:30 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld,
 Matthew" <matthew.auld@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Zhang, Carl" <carl.zhang@intel.com>,
	"thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
	"Mrozek, Michal" <michal.mrozek@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Topic: [PATCH 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Index: AQHcWZONECaMcWpgAUu17Awm3H6DtbT6d3eA
Date: Wed, 19 Nov 2025 20:45:30 +0000
Message-ID: <735887bbf59393f6d36b9fe3bc1163776dcc6f39.camel@intel.com>
References: <20251119203031.267625-4-matthew.auld@intel.com>
	 <20251119203031.267625-5-matthew.auld@intel.com>
In-Reply-To: <20251119203031.267625-5-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|DS4PPFA424F92C2:EE_
x-ms-office365-filtering-correlation-id: 0cc412c4-ada5-4dbe-26ee-08de27ac93ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dUN1ZFRiMDZLRW5qQzF5M2JjdUlzdDhyaThGYndBUDQ3K3hkOE9BQVhzUUFC?=
 =?utf-8?B?b0VwRlR2YVoyZ21pclVrWTMwRDJlS1NxZW1VQjE1OXhOTERZQ1BXOEloVFlu?=
 =?utf-8?B?SEZwU3hZcktWUzRsSGtQRFdhSnlXRkVELzNDcktINVU2cmh4WnJjUzRic2Uw?=
 =?utf-8?B?M1BjYVRIZEJ2K1F4ckpiRDIrTGlxUVozdWNXYUM2dkJ1K2UyZHlmTERrVUZQ?=
 =?utf-8?B?SmQ1YytsMFFiT21TNmhVdFBIeEJZYTVEWERjcC9XbXpOVThiWU5Ya0tObEsy?=
 =?utf-8?B?ZGI1L0wvODcwVEszeDlvL29jSWhVZm5PTmNReFhzU0xvczBuUzc5YzRWRVUv?=
 =?utf-8?B?ckhnQjIzVmtUYXBYWVg5cnFWWTZXZmo2L0UwS1Nyc0xEOUxYVG5Rb1psY1Js?=
 =?utf-8?B?L2dKSUd5ZWMyT29Mc0t5TTJVdWxPQjVnemh1c1ZQTytqalJleG9BY0MrWHpV?=
 =?utf-8?B?bFlxekE1TENGQzVqY2ppTDJOcGY2REVPN1d2RGxyYnMxVFE2azNvTkNTd1l4?=
 =?utf-8?B?dFVmU1dQQTIxcXZXSVNNS1QxRGRiUGdseTZLNFpuSjBKS2YzQ1JsZGVROE1E?=
 =?utf-8?B?Y1RQVDN5VE1zKytONnJVb0NxSERyU094T3R6MXNjM0dsclMwRUhqbUduMXRx?=
 =?utf-8?B?MWI5SDNMOTlHcHV3L3VYeWViRmxHekJueE52R3M2cHJsOWs5anQzSWdndFVo?=
 =?utf-8?B?V2JmWnExTFFLZW1Sa2UyKzNYd0VXb1hLemErM21KMlVFUnpFcmFYUnFaOElT?=
 =?utf-8?B?SjVPVWh0eS9KMG1JRGFMc3pUMEs0K2hiMHJCWXVkTktpR1JIUHRNbEx5WDVz?=
 =?utf-8?B?TC9vYnJZTkRWQlhIUWZHKzNNcXdxUDVMaG5PS05jSEtNazFZQ2FRK0ZhaThh?=
 =?utf-8?B?M1lXTDBlVTZTNUVmMlpuTzJWR0J6M1pEMXdMNy9PTzlOL0l3bkZFVzZMMHNO?=
 =?utf-8?B?MVoxSkZMMmlhRUZmU0UrdWp5VUpBK3hFQktVVisvcmR1SGNKQndQY0M1ZHdQ?=
 =?utf-8?B?Z1c2QmNFUlNvWkMzd043bEhIc1pMUDk3T1oxMWk3Ym5wZ3hrZlB2UzNCK0Ev?=
 =?utf-8?B?VEdCalR4a0EzMXhjcURaN0lGazA5eVNsVjJYTFZBMTVoaytpZWMvUytnd29p?=
 =?utf-8?B?WFBiREZLRE5RTm1IQ1k5L0FKK1Rid1JkS05RYnU2dlA1cElGWUsxQk9NenRz?=
 =?utf-8?B?QSt4dDYwK2g5ZHBqYmkvZ0VKZVdqU2o4VmIrc0dIVUlZVDl4SHZBZmgwOWsr?=
 =?utf-8?B?REtDUWNDSWFUQzhBZlBwRTA1Ly9hWnRsMHpMbzkvTllFN2x4dTlRVWl3VHhF?=
 =?utf-8?B?dytKMTZmU01lWUNZYWI3SGhQYUNLN2svWDFwTkFzNGkxb1FUbmk0MU5xRWhP?=
 =?utf-8?B?djNTMnBGbElib0dZdERYMnZrSG1SMExFOVFJRFJXd1Y1NGJJWkpiM0x2S1VP?=
 =?utf-8?B?dmhBbTRyR3pDYjBteXF3MzlkbFJ5M2JZMDRoM1hBMDI4bHF4N1pyelNNVUVQ?=
 =?utf-8?B?THZzUmRBMkh3UUlUNzh2VzIrTUY2SGMzNWIwUUVad05jN3lORmNxVmR1Rnl2?=
 =?utf-8?B?aUlOWXBScTdBOG1MdGdabjJrY1JCMXdFUDl4eHp0UmdYRXZZRGRDaHY0Q21Q?=
 =?utf-8?B?UkJPTE5qdWxzWGI3UmM2WmVCaGJzbjhBMDllOTRLcHRrZzdMcHdpdW13M3VP?=
 =?utf-8?B?Q2lTL0hXenFQMGJ0WTJpdS9kd3BzMEl0MzU0SDJoZElxSW11VHJzVWx6VGpS?=
 =?utf-8?B?blRod0lYQU56SFduT1RxOUVidjRrQ0plV3RMOHAxQ3JRM3dNZnlNUDhrY2xI?=
 =?utf-8?B?eXgrMGRxZXhwMDViak5BSStkRC8rRXorZXp4cWtNQVZ4Rk11VmZiQWF4MFFH?=
 =?utf-8?B?T0x6MGEwdGc1T2lZRGNRM1kwSEluRUJUbDZCUWJ5RnErNkwxdVNVUFVPWm95?=
 =?utf-8?B?bG14eHJQN1NJb3RISFlhOFlQUW84L01nUk9nOS9ibitZU0k2RFhjRlBSdUZu?=
 =?utf-8?B?MEYvZDBJakhiUDMrQys0S01uMG5tS05NT2RIMWlBQlJGbnBhVzM3SkVlN09k?=
 =?utf-8?Q?4kwwlX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bituNlQyemNOMHM3eTBWN0hzSkdDdWE5QTRwN1VUcGkrVFYwZU5FRitzODl5?=
 =?utf-8?B?Q2g0ejJrZHJTYVRnbkdBdFJKbDZrVThtV1RGaHhDa0ZsdFhMWnBxNHZXQkVy?=
 =?utf-8?B?OHRRemwwcXV1NlJxWUNDVVRKTyszdno2eURUMDdNUFBnTE15NFlKVDI4N1Fn?=
 =?utf-8?B?dC9mNXpCcmhiUnJQYytiN3JnK2dhR01jSU1LRm9zaFgwMFQxYzU2Lzd0QTFN?=
 =?utf-8?B?Ny9QUjdFV0ludTI3eEJ3MzBDQWtUWm5pLzJnYVdtV1NtMzRyTHdTR0c4ZEpn?=
 =?utf-8?B?NlFLQjNyYUo3WEVDUnA4MFZyb1g2enhIYzcrTjJSMnhTd3NPSTJZK2hPUHlp?=
 =?utf-8?B?TmR1VHFCc2M3cW5CMDh0Tkk4dWpoVnppOXVNZGpDSVVjdE51MUt3RFRlZHA2?=
 =?utf-8?B?UmtCQzBFMzhFNzRPc2o3cG1aS2N2YTZEdGgwcmNrT1ZvdzlJSjBkQTAxbVEx?=
 =?utf-8?B?QXk0NXNnNGtIbWJmUkdiNitOeWN3WVNWRXpQTHphNHpaUE5SR28xNHB6by9Y?=
 =?utf-8?B?YnAyOGwzMTZoYUR4OEhFOWg2Zk5rWHRqb2VIejVRekpJbmFRdXZHK3BMNVZ6?=
 =?utf-8?B?anBWM2hYTW1KRENERkg5Qk5ZVXU5Y3JOV05NWTNmSGtPV2gxK1RpaFBSYmlT?=
 =?utf-8?B?VEhRdmgyR1BPQ0FaWU9FUmY1TERyTGx5QWh2MTl5bzFGU1p0NFc3cUNpVWJG?=
 =?utf-8?B?KzVENkxibUxGVEJ6dC90dWJpejNIYXltZzA4ZkRLTW5EZHhmYVphOXhlaFY4?=
 =?utf-8?B?UWhaUS9qWWh3SDE3Q25TZlBWQWJwbzU3WnJ0VkJNVjhCQmZWbEgzdndTaW8y?=
 =?utf-8?B?eHBMQ0lSZXFuYjJsZEZIb1ZSODVjcFRwbDJUNkVSWXp3eVR4a1JGMU9lamx1?=
 =?utf-8?B?YXUyenpnRjdGMzZUOGtzSGRrTFRObWY0bDNQdzJnR1VKZlFBbWVyYUp6VW9S?=
 =?utf-8?B?WTZiZXlTRzJUUjdjd0xQTWRvVnlBdEhuanMzSEtFTFRwdEZ0N0svQkcwblBt?=
 =?utf-8?B?YVp4Q3ozYlhFZy9uWWJ1aGlPaUhUMjlvaHFXekdMbUFlZjZWSWJoNStQazNL?=
 =?utf-8?B?eGhGUEViZllrKzdIcElqWWxPSXdrQUdxRHBLYlNoclpiOEdpd2RSWDZ0aFE3?=
 =?utf-8?B?OHdDd3ZPejVSZVRNdHlYVWVRUEhwV3NDUDlIQWV3Tko1NTlhYnovUnhkUkZE?=
 =?utf-8?B?SkxtcDhmbit3NkUxSnFaZTIxZGluOUJmZnBleElLYUxoQUZ3TEozRDd3Vnl2?=
 =?utf-8?B?aEFLaWF2bTNFWEN6UldWanJNSkxFOWhBTjBuNUV4N0FpRlVoeFM0MW1MdG14?=
 =?utf-8?B?VVVNMDBYL2xtdzhqRGtxWnZhUWJ6cjZ3d2UyTjM0UE45VmQxRzRaZWcvL0xo?=
 =?utf-8?B?WldtQ3NSUDJqWDdVaFhsSlpEd0ptL0k1Z2JLR3ErWDNqWCswaUM5b0lmbFZJ?=
 =?utf-8?B?d3RkZGVtTERZbFZOaHdvdGNTbHh5Tzl6Tkp6MmgzcEJwUHFFOTVOVFJ2YUZH?=
 =?utf-8?B?ZjA2T0F4OVhIZmo5MXFDdVNOV1NkWCtQK05Fa1E3eHN3UVhtbVY0UG0zSFBv?=
 =?utf-8?B?cy9VblVjN1Q4NXBobDBteXcyMW5wTUFNajYxTGpmYkVmb2dCbWpObUxiRmdl?=
 =?utf-8?B?UUZWaTdXWXlyMmw5RU9NbmN5UDZTZzN5OWdNd21DYlpvZ2xyWkk4TlFLS0JC?=
 =?utf-8?B?cmdHYkRqbVhMcXI1bW1EVmhHVXh1d0tRb1VsOU9wc2hzUnluTi9KaXF5SW9T?=
 =?utf-8?B?UklBaHkwVm5rRjBJMWhoNnJaN290c3lXYVc0UGZwZHRJZDh1LzQ1ODRoK0ZR?=
 =?utf-8?B?REQ3bkd4eTc4UCs5Q2F0QWZzaWc3bjNxK0VzOU4xWDZxSnRDbGQ2aDZkMWQ2?=
 =?utf-8?B?NjFHUEdoOXdQUlhDQ0lMTzV0Q3Z5Zm1PUllta2RGQjQrMjdLQXJQNmN4TWJv?=
 =?utf-8?B?bjlRbWtqY0RLVnlwdzVLNERZT1I0MXdJeUVTdndlQVArd2VNMFlwWHdEa0JV?=
 =?utf-8?B?UDhLcnJ3cDlnaFZVRUYxbStWTml4N0h4ZGtwTmdua3VnYzZmaElCeE9xMXh0?=
 =?utf-8?B?UEZ2b3NwdzJMODJFOTFoS255SWJwMGVTdll4YTJKL3hmMExxcWZEaHlGSlIv?=
 =?utf-8?Q?RzfN5QffTLsOACJFJ7MAOawha?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <257D7FA1B76BF64FBD88D497FC9858C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc412c4-ada5-4dbe-26ee-08de27ac93ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 20:45:30.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnWiec0L8QhBVg364XFcHjbcBDMAzTcYpzb56L8A72UB7DN2kkOAE72IlJm9xnAUPdWlpiyTF6060WSHEpXS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA424F92C2
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTExLTE5IGF0IDIwOjMwICswMDAwLCBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+
IEZyb206IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0KPiANCj4gQ3Vy
cmVudGx5IHRoaXMgaXMgdmVyeSBicm9rZW4gaWYgc29tZW9uZSBhdHRlbXB0cyB0byBjcmVhdGUg
YSBiaW5kDQo+IHF1ZXVlIGFuZCBzaGFyZSBpdCBhY3Jvc3MgbXVsdGlwbGUgVk1zLiBGb3IgZXhh
bXBsZSBjdXJyZW50bHkgd2UNCj4gYXNzdW1lDQo+IGl0IGlzIHNhZmUgdG8gYWNxdWlyZSB0aGUg
dXNlciBWTSBsb2NrIHRvIHByb3RlY3Qgc29tZSBvZiB0aGUgYmluZA0KPiBxdWV1ZQ0KPiBzdGF0
ZSwgYnV0IGlmIGFsbG93IHNoYXJpbmcgdGhlIGJpbmQgcXVldWUgd2l0aCBtdWx0aXBsZSBWTXMg
dGhlbg0KPiB0aGlzDQo+IHF1aWNrbHkgYnJlYWtzIGRvd24uDQo+IA0KPiBUbyBmaXggdGhpcyBy
ZWplY3QgdXNpbmcgYSBiaW5kIHF1ZXVlIHdpdGggYW55IFZNIHRoYXQgaXMgbm90IHRoZQ0KPiBz
YW1lDQo+IFZNIHRoYXQgd2FzIG9yaWdpbmFsbHkgcGFzc2VkIHdoZW4gY3JlYXRpbmcgdGhlIGJp
bmQgcXVldWUuIFRoaXMgYQ0KPiB1QVBJDQo+IGNoYW5nZSwgaG93ZXZlciB0aGlzIHdhcyBtb3Jl
IG9mIGFuIG92ZXJzaWdodCBvbiBrZXJuZWwgc2lkZSB0aGF0IHdlDQo+IGRpZG4ndCByZWplY3Qg
dGhpcywgYW5kIGV4cGVjdGF0aW9uIGlzIHRoYXQgdXNlcnNwYWNlIHNob3VsZG4ndCBiZQ0KPiB1
c2luZw0KPiBiaW5kIHF1ZXVlcyBpbiB0aGlzIHdheSwgc28gaW4gdGhlb3J5IHRoaXMgY2hhbmdl
IHNob3VsZCBnbw0KPiB1bm5vdGljZWQuDQo+IA0KDQpNZXNhIG9ubHkgdXNlcyB0aGUgYmluZCBx
dWV1ZSB0byBiaW5kIGJvcyBpbiB0aGUgdm1faWQgc2V0IGluIHRoZQ0KY3JlYXRpb24gb2YgYmlu
ZCBxdWV1ZSBzbyB0aGlzIGlzOg0KDQpBY2tlZC1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8
am9zZS5zb3V6YUBpbnRlbC5jb20NCg0KDQo+IEZpeGVzOiBkZDA4ZWJmNmMzNTIgKCJkcm0veGU6
IEludHJvZHVjZSBhIG5ldyBEUk0gZHJpdmVyIGZvciBJbnRlbA0KPiBHUFVzIikNCj4gUmVwb3J0
ZWQtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5j
b20+DQo+IENvLWRldmVsb3BlZC1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRlbC5j
b20+DQo+IENjOiBNaWNoYWwgTXJvemVrIDxtaWNoYWwubXJvemVrQGludGVsLmNvbT4NCj4gQ2M6
IEpvc2UgU291emEgPGpvc2Uuc291emFAaW50ZWwuY29tPg0KPiBDYzogQ2FybCBaaGFuZyA8Y2Fy
bC56aGFuZ0BpbnRlbC5jb20+DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni44
Kw0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZXhlY19xdWV1ZS5jwqDCoMKgwqDC
oMKgIHwgMjcNCj4gKysrKysrKysrKysrKysrKysrKysrKystDQo+IMKgZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2V4ZWNfcXVldWUuaMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+IMKgZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX2V4ZWNfcXVldWVfdHlwZXMuaCB8wqAgNiArKysrKysNCj4gwqBkcml2ZXJzL2dw
dS9kcm0veGUveGVfc3Jpb3ZfdmZfY2NzLmPCoMKgwqDCoCB8wqAgMiArLQ0KPiDCoGRyaXZlcnMv
Z3B1L2RybS94ZS94ZV92bS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysr
Ky0NCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2V4ZWNfcXVldWUuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9leGVjX3F1ZXVlLmMNCj4gaW5kZXggODcyNGY4ZGU2
N2UyLi4zMWJiMDUxY2JiNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9l
eGVjX3F1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2V4ZWNfcXVldWUuYw0K
PiBAQCAtMzI4LDYgKzMyOCw3IEBAIHN0cnVjdCB4ZV9leGVjX3F1ZXVlDQo+ICp4ZV9leGVjX3F1
ZXVlX2NyZWF0ZV9jbGFzcyhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwgc3RydWN0IHhlDQo+IMKgICog
QHhlOiBYZSBkZXZpY2UuDQo+IMKgICogQHRpbGU6IHRpbGUgd2hpY2ggYmluZCBleGVjIHF1ZXVl
IGJlbG9uZ3MgdG8uDQo+IMKgICogQGZsYWdzOiBleGVjIHF1ZXVlIGNyZWF0aW9uIGZsYWdzDQo+
ICsgKiBAdXNlcl92bTogVGhlIHVzZXIgVk0gd2hpY2ggdGhpcyBleGVjIHF1ZXVlIGJlbG9uZ3Mg
dG8NCj4gwqAgKiBAZXh0ZW5zaW9uczogZXhlYyBxdWV1ZSBjcmVhdGlvbiBleHRlbnNpb25zDQo+
IMKgICoNCj4gwqAgKiBOb3JtYWxpemUgYmluZCBleGVjIHF1ZXVlIGNyZWF0aW9uLiBCaW5kIGV4
ZWMgcXVldWUgaXMgdGllZCB0bw0KPiBtaWdyYXRpb24gVk0NCj4gQEAgLTM0MSw2ICszNDIsNyBA
QCBzdHJ1Y3QgeGVfZXhlY19xdWV1ZQ0KPiAqeGVfZXhlY19xdWV1ZV9jcmVhdGVfY2xhc3Moc3Ry
dWN0IHhlX2RldmljZSAqeGUsIHN0cnVjdCB4ZQ0KPiDCoCAqLw0KPiDCoHN0cnVjdCB4ZV9leGVj
X3F1ZXVlICp4ZV9leGVjX3F1ZXVlX2NyZWF0ZV9iaW5kKHN0cnVjdCB4ZV9kZXZpY2UNCj4gKnhl
LA0KPiDCoAkJCQkJCXN0cnVjdCB4ZV90aWxlDQo+ICp0aWxlLA0KPiArCQkJCQkJc3RydWN0IHhl
X3ZtDQo+ICp1c2VyX3ZtLA0KPiDCoAkJCQkJCXUzMiBmbGFncywgdTY0DQo+IGV4dGVuc2lvbnMp
DQo+IMKgew0KPiDCoAlzdHJ1Y3QgeGVfZ3QgKmd0ID0gdGlsZS0+cHJpbWFyeV9ndDsNCj4gQEAg
LTM3OSw2ICszODEsOSBAQCBzdHJ1Y3QgeGVfZXhlY19xdWV1ZQ0KPiAqeGVfZXhlY19xdWV1ZV9j
cmVhdGVfYmluZChzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwNCj4gwqAJCX0NCj4gwqAJfQ0KPiDCoA0K
PiArCWlmICh1c2VyX3ZtKQ0KPiArCQlxLT51c2VyX3ZtID0geGVfdm1fZ2V0KHVzZXJfdm0pOw0K
PiArDQo+IMKgCXJldHVybiBxOw0KPiDCoH0NCj4gwqBBTExPV19FUlJPUl9JTkpFQ1RJT04oeGVf
ZXhlY19xdWV1ZV9jcmVhdGVfYmluZCwgRVJSTk8pOw0KPiBAQCAtNDA3LDYgKzQxMiw4IEBAIHZv
aWQgeGVfZXhlY19xdWV1ZV9kZXN0cm95KHN0cnVjdCBrcmVmICpyZWYpDQo+IMKgCQkJeGVfZXhl
Y19xdWV1ZV9wdXQoZXEpOw0KPiDCoAl9DQo+IMKgDQo+ICsJeGVfdm1fcHV0KHEtPnVzZXJfdm0p
Ow0KPiArDQo+IMKgCXEtPm9wcy0+ZGVzdHJveShxKTsNCj4gwqB9DQo+IMKgDQo+IEBAIC03NDIs
NiArNzQ5LDIzIEBAIGludCB4ZV9leGVjX3F1ZXVlX2NyZWF0ZV9pb2N0bChzdHJ1Y3QgZHJtX2Rl
dmljZQ0KPiAqZGV2LCB2b2lkICpkYXRhLA0KPiDCoAkJwqDCoMKgIFhFX0lPQ1RMX0RCRyh4ZSwg
ZWNpWzBdLmVuZ2luZV9pbnN0YW5jZSAhPSAwKSkNCj4gwqAJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
wqANCj4gKwkJdm0gPSB4ZV92bV9sb29rdXAoeGVmLCBhcmdzLT52bV9pZCk7DQo+ICsJCWlmIChY
RV9JT0NUTF9EQkcoeGUsICF2bSkpDQo+ICsJCQlyZXR1cm4gLUVOT0VOVDsNCj4gKw0KPiArCQll
cnIgPSBkb3duX3JlYWRfaW50ZXJydXB0aWJsZSgmdm0tPmxvY2spOw0KPiArCQlpZiAoZXJyKSB7
DQo+ICsJCQl4ZV92bV9wdXQodm0pOw0KPiArCQkJcmV0dXJuIGVycjsNCj4gKwkJfQ0KPiArDQo+
ICsJCWlmIChYRV9JT0NUTF9EQkcoeGUsIHhlX3ZtX2lzX2Nsb3NlZF9vcl9iYW5uZWQodm0pKSkN
Cj4gew0KPiArCQkJdXBfcmVhZCgmdm0tPmxvY2spOw0KPiArCQkJeGVfdm1fcHV0KHZtKTsNCj4g
KwkJCXJldHVybiAtRU5PRU5UOw0KPiArCQl9DQo+ICsJCXVwX3JlYWQoJnZtLT5sb2NrKTsNCj4g
Kw0KPiDCoAkJZm9yX2VhY2hfdGlsZSh0aWxlLCB4ZSwgaWQpIHsNCj4gwqAJCQlzdHJ1Y3QgeGVf
ZXhlY19xdWV1ZSAqbmV3Ow0KPiDCoA0KPiBAQCAtNzQ5LDcgKzc3Myw3IEBAIGludCB4ZV9leGVj
X3F1ZXVlX2NyZWF0ZV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZGV2LCB2b2lkICpkYXRh
LA0KPiDCoAkJCWlmIChpZCkNCj4gwqAJCQkJZmxhZ3MgfD0NCj4gRVhFQ19RVUVVRV9GTEFHX0JJ
TkRfRU5HSU5FX0NISUxEOw0KPiDCoA0KPiAtCQkJbmV3ID0geGVfZXhlY19xdWV1ZV9jcmVhdGVf
YmluZCh4ZSwgdGlsZSwNCj4gZmxhZ3MsDQo+ICsJCQluZXcgPSB4ZV9leGVjX3F1ZXVlX2NyZWF0
ZV9iaW5kKHhlLCB0aWxlLA0KPiB2bSwgZmxhZ3MsDQo+IMKgCQkJCQkJCWFyZ3MtDQo+ID5leHRl
bnNpb25zKTsNCj4gwqAJCQlpZiAoSVNfRVJSKG5ldykpIHsNCj4gwqAJCQkJZXJyID0gUFRSX0VS
UihuZXcpOw0KPiBAQCAtNzYzLDYgKzc4Nyw3IEBAIGludCB4ZV9leGVjX3F1ZXVlX2NyZWF0ZV9p
b2N0bChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZGV2LCB2b2lkICpkYXRhLA0KPiDCoAkJCQlsaXN0
X2FkZF90YWlsKCZuZXctPm11bHRpX2d0X2xpc3QsDQo+IMKgCQkJCQnCoMKgwqDCoMKgICZxLT5t
dWx0aV9ndF9saW5rKTsNCj4gwqAJCX0NCj4gKwkJeGVfdm1fcHV0KHZtKTsNCj4gwqAJfSBlbHNl
IHsNCj4gwqAJCWxvZ2ljYWxfbWFzayA9IGNhbGNfdmFsaWRhdGVfbG9naWNhbF9tYXNrKHhlLCBl
Y2ksDQo+IMKgCQkJCQkJCcKgIGFyZ3MtDQo+ID53aWR0aCwNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS94ZS94ZV9leGVjX3F1ZXVlLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVf
ZXhlY19xdWV1ZS5oDQo+IGluZGV4IGZkYTRkNGY5YmRhOC4uMzdhOWRhMjJmNDIwIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZXhlY19xdWV1ZS5oDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS94ZS94ZV9leGVjX3F1ZXVlLmgNCj4gQEAgLTI4LDYgKzI4LDcgQEAgc3RydWN0
IHhlX2V4ZWNfcXVldWUNCj4gKnhlX2V4ZWNfcXVldWVfY3JlYXRlX2NsYXNzKHN0cnVjdCB4ZV9k
ZXZpY2UgKnhlLCBzdHJ1Y3QgeGUNCj4gwqAJCQkJCQkgdTMyIGZsYWdzLCB1NjQNCj4gZXh0ZW5z
aW9ucyk7DQo+IMKgc3RydWN0IHhlX2V4ZWNfcXVldWUgKnhlX2V4ZWNfcXVldWVfY3JlYXRlX2Jp
bmQoc3RydWN0IHhlX2RldmljZQ0KPiAqeGUsDQo+IMKgCQkJCQkJc3RydWN0IHhlX3RpbGUNCj4g
KnRpbGUsDQo+ICsJCQkJCQlzdHJ1Y3QgeGVfdm0NCj4gKnVzZXJfdm0sDQo+IMKgCQkJCQkJdTMy
IGZsYWdzLCB1NjQNCj4gZXh0ZW5zaW9ucyk7DQo+IMKgDQo+IMKgdm9pZCB4ZV9leGVjX3F1ZXVl
X2Zpbmkoc3RydWN0IHhlX2V4ZWNfcXVldWUgKnEpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX2V4ZWNfcXVldWVfdHlwZXMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV9leGVjX3F1ZXVlX3R5cGVzLmgNCj4gaW5kZXggNzcxZmZlMzVjZDBjLi4zYTQyNjNjOTJiM2Qg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9leGVjX3F1ZXVlX3R5cGVzLmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2V4ZWNfcXVldWVfdHlwZXMuaA0KPiBAQCAt
NTQsNiArNTQsMTIgQEAgc3RydWN0IHhlX2V4ZWNfcXVldWUgew0KPiDCoAlzdHJ1Y3Qga3JlZiBy
ZWZjb3VudDsNCj4gwqAJLyoqIEB2bTogVk0gKGFkZHJlc3Mgc3BhY2UpIGZvciB0aGlzIGV4ZWMg
cXVldWUgKi8NCj4gwqAJc3RydWN0IHhlX3ZtICp2bTsNCj4gKwkvKioNCj4gKwkgKiBAdXNlcl92
bTogVXNlciBWTSAoYWRkcmVzcyBzcGFjZSkgZm9yIHRoaXMgZXhlYyBxdWV1ZQ0KPiAoYmluZCBx
dWV1ZXMNCj4gKwkgKiBvbmx5KQ0KPiArCSAqLw0KPiArCXN0cnVjdCB4ZV92bSAqdXNlcl92bTsN
Cj4gKw0KPiDCoAkvKiogQGNsYXNzOiBjbGFzcyBvZiB0aGlzIGV4ZWMgcXVldWUgKi8NCj4gwqAJ
ZW51bSB4ZV9lbmdpbmVfY2xhc3MgY2xhc3M7DQo+IMKgCS8qKg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3hlL3hlX3NyaW92X3ZmX2Njcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX3NyaW92X3ZmX2Njcy5jDQo+IGluZGV4IDMzZjQyMzg2MDRlMS4uZjdiN2M0NGNmMmY2IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfc3Jpb3ZfdmZfY2NzLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3NyaW92X3ZmX2Njcy5jDQo+IEBAIC0zNTAsNyArMzUw
LDcgQEAgaW50IHhlX3NyaW92X3ZmX2Njc19pbml0KHN0cnVjdCB4ZV9kZXZpY2UgKnhlKQ0KPiDC
oAkJZmxhZ3MgPSBFWEVDX1FVRVVFX0ZMQUdfS0VSTkVMIHwNCj4gwqAJCQlFWEVDX1FVRVVFX0ZM
QUdfUEVSTUFORU5UIHwNCj4gwqAJCQlFWEVDX1FVRVVFX0ZMQUdfTUlHUkFURTsNCj4gLQkJcSA9
IHhlX2V4ZWNfcXVldWVfY3JlYXRlX2JpbmQoeGUsIHRpbGUsIGZsYWdzLCAwKTsNCj4gKwkJcSA9
IHhlX2V4ZWNfcXVldWVfY3JlYXRlX2JpbmQoeGUsIHRpbGUsIE5VTEwsIGZsYWdzLA0KPiAwKTsN
Cj4gwqAJCWlmIChJU19FUlIocSkpIHsNCj4gwqAJCQllcnIgPSBQVFJfRVJSKHEpOw0KPiDCoAkJ
CWdvdG8gZXJyX3JldDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5j
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmMNCj4gaW5kZXggZjk5ODlhN2E3MTBjLi43OTcz
ZDY1NDU0MGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5jDQo+IEBAIC0xNjE0LDcgKzE2MTQsNyBAQCBz
dHJ1Y3QgeGVfdm0gKnhlX3ZtX2NyZWF0ZShzdHJ1Y3QgeGVfZGV2aWNlDQo+ICp4ZSwgdTMyIGZs
YWdzLCBzdHJ1Y3QgeGVfZmlsZSAqeGVmKQ0KPiDCoAkJCWlmICghdm0tPnB0X3Jvb3RbaWRdKQ0K
PiDCoAkJCQljb250aW51ZTsNCj4gwqANCj4gLQkJCXEgPSB4ZV9leGVjX3F1ZXVlX2NyZWF0ZV9i
aW5kKHhlLCB0aWxlLA0KPiBjcmVhdGVfZmxhZ3MsIDApOw0KPiArCQkJcSA9IHhlX2V4ZWNfcXVl
dWVfY3JlYXRlX2JpbmQoeGUsIHRpbGUsIHZtLA0KPiBjcmVhdGVfZmxhZ3MsIDApOw0KPiDCoAkJ
CWlmIChJU19FUlIocSkpIHsNCj4gwqAJCQkJZXJyID0gUFRSX0VSUihxKTsNCj4gwqAJCQkJZ290
byBlcnJfY2xvc2U7DQo+IEBAIC0zNTcxLDYgKzM1NzEsMTEgQEAgaW50IHhlX3ZtX2JpbmRfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxl
ICpmaWxlKQ0KPiDCoAkJfQ0KPiDCoAl9DQo+IMKgDQo+ICsJaWYgKFhFX0lPQ1RMX0RCRyh4ZSwg
cSAmJiB2bSAhPSBxLT51c2VyX3ZtKSkgew0KPiArCQllcnIgPSAtRUlOVkFMOw0KPiArCQlnb3Rv
IHB1dF9leGVjX3F1ZXVlOw0KPiArCX0NCj4gKw0KPiDCoAkvKiBFbnN1cmUgYWxsIFVOTUFQcyB2
aXNpYmxlICovDQo+IMKgCXhlX3N2bV9mbHVzaCh2bSk7DQo+IMKgDQo=

