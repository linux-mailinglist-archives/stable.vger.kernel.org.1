Return-Path: <stable+bounces-75787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95B9749AE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA71F25F2D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 05:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B404AEF7;
	Wed, 11 Sep 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVHqXb6t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901D4AEF4
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032004; cv=fail; b=Zu6DxnatLBjlqrpj5UW9xSUoh75kDPHnJLuNkwsk57JoDAg+J9TpJrwsuVRV+tDwLQSunJ7IpObDZppkw4g251PJuCiZc32ZzOkHQ7hvqSo6xHsPh6IrSuawi2iG6+d5B7bBL8Ra9JLrMZ9cWJjiOeWYK5pGFpwNQr+oK8SVX1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032004; c=relaxed/simple;
	bh=g8TCwZPPuJ3f8osj/Ft7MmmGYgVMxSl/UrZF4+QTJD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SPYo3e/l9k3xAgWGA+OXVh/QYDIIr8FQnlLgL5FuTxoymW/whtIuYxByZHIecZrBeMruzU/4rTBGrwTATHTx+Qy8Cax1xsp/vSl6cBmvmsFoDhdPNya4w5rbbchTjau4bregLbJfTp1zfh2VcRUGBdFTvYruU0tKMsbjz9mvuEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVHqXb6t; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726032003; x=1757568003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g8TCwZPPuJ3f8osj/Ft7MmmGYgVMxSl/UrZF4+QTJD8=;
  b=nVHqXb6tPg2g7yPcIdsr9bEYHKr8OWmR6LZqzE8HsXDFYan9oqfGacWK
   f4sr1KgwT0Ec9TuoLoaKcVy4tbddffFQ8RhLpvdYGf7TKI0DidvikqqKv
   RkvwoB6q0GS0smjsZp6XYAyCV6dhLwlf/Z+yzwo3hgrfLxr5AB1kKh1s+
   R+cTi02A7IySEyi4eofLUAm9X1ZyDC2Xg5NeRsxKUPct4A9jqJoBF8glk
   M2aSCZl2UpveaXF7wSPeqVBqUYuJE2YCu1iwI7DoqtMRiX1iFsBvLCYi1
   OeWKX3itTOWv3XcG5Sz/dDlLzsFePyAaD3JoYkCHR/t1nMwG7jKunSoU3
   w==;
X-CSE-ConnectionGUID: LLar3sdJQQWMgbXhpD0rog==
X-CSE-MsgGUID: PQUg2atcRPC3rFLbkkmVOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24632486"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24632486"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:20:01 -0700
X-CSE-ConnectionGUID: w/x62Wf8QnyF1E/9sIW9ug==
X-CSE-MsgGUID: 60dz3/xbTxm+w18ghJDCGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="71864560"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 22:20:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 22:20:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 22:20:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 22:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuT41h1JSGF7YVUiZEQ9jnMkCD0bv+zqrhE/GAJ5z3va7oD+0oDrcyr8DMthquFYVdtUUp8Bj5SMKwcWoki1uYopodM/ZOLNcPF69CbA5W0vj/I8KKRLmycv/yL3MyN3OkfoV+A39Sztgw7IiUXp7CCNw/tnTkMcYgY0zq+pVl80COkq6sfIglUxZM64b4I8sIrbA944G1sjaU+b8IOqXO6P3BBZnw6A0Gzf8e4P+AxoPKi+ml2cRZva1r1utvGRIPvrvJk0oJEMVr0I22sfzUr09PjYD1HlgqO7BzB7p9tZFStlpzlYZCfUxJbCq44WNDdNU+FbxhMtENP3ph2kPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8TCwZPPuJ3f8osj/Ft7MmmGYgVMxSl/UrZF4+QTJD8=;
 b=jNiagqLK36mk3ylQMWRg/AGVCtWx+/I+/vYRtZ50k43lNpujiutKF+mDaqcQ8YyLKJTLackkpaQ9SbaVEho1V+bcv0x17Eyhws3wC+peno6uHWEGEa8puvZtAZtnJhBuWeT2napNjg9cuukyixwOY4eyAqEbIZcPkxcFwIFbzf5FQAdfvfNkLGVJrkRbc7EIcSNRzkg7QU3dLLR3DCGfJ15jTplmKXTgP3LUFcHX7tIn6cSreXcP4G/WQluNqy2jfO4TZjf2VkJnbH6WNtKG7SpV46w+EXfEV7TABoPLAR2/Pr04SulJ7UASg3yOoi3sWyX5V0s5PcHeveXQPCCg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 05:19:52 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 05:19:52 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/4] drm/xe/client: fix deadlock in show_meminfo()
Thread-Topic: [PATCH 1/4] drm/xe/client: fix deadlock in show_meminfo()
Thread-Index: AQHbA4MZcRkmP4/LC0yeHHBKxOxejbJSDStg
Date: Wed, 11 Sep 2024 05:19:52 +0000
Message-ID: <SJ1PR11MB62046D2BB255365FF08AD25C819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
In-Reply-To: <20240910131145.136984-5-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|MW6PR11MB8438:EE_
x-ms-office365-filtering-correlation-id: c2d401cc-9208-4f91-b626-08dcd2215dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SG5ON0lmYS9jcFhPaHJhUjlWZXREcXI3ZXRLVmhRNjBUOWlsNVMxNDQyR2Nq?=
 =?utf-8?B?b1d1d2V2M2FqaG0xc0R1cDlvcHFLNExaYjhRSnMwRUFpNkYwMFBsZDNqZThm?=
 =?utf-8?B?Ymdzbm5zTUdMa3dDM2c0RndlaDJ2U1hGTmczV3pNZFlHMzYxMitzV2FJREZn?=
 =?utf-8?B?eXRVdVNiU3F4d1B0b1p3Z3NQV3FyMXAveTdBSzM2bHI5aDVYc3hIYnMrQzNz?=
 =?utf-8?B?ZlNEeTFzczRlWUxDYmJNQysybzNXcDBGeE83ZHdzNGxzV1R2d1RqOStRUmtI?=
 =?utf-8?B?NzEwc3phQnBtU0ZEKzQxNlZLZEorQ2lJZnRrcVdwb2dzT3FlL05JSFdrSWdS?=
 =?utf-8?B?OHN5S3BFc09Cd1MzSVhNMlNTY0FsTVp6cHFqUDRQODdpNWh0c2ZiUVdSNjhm?=
 =?utf-8?B?ZVF2MzRHOG1zWm9uVCtEL3c0cytzOUdhVG5GMGI1U3hFMGxoV0RhNGhVbDl3?=
 =?utf-8?B?TmhGeVc1ZEdlWVFLaUwyK3QyNW9YZWQySS9sNGpoekNxWStwcG1YMVE2WUNw?=
 =?utf-8?B?dmNzSEVzNlg3Y0hiUENFTll2RENCNithK3IwNmhBU3lkU2M0Y2VZK0tlbnk0?=
 =?utf-8?B?bUtnTHNBdzRDVEtsSUljTmIrdDFCVVUzQWNpS3ZXaTd1YmZObENpd0RMclZq?=
 =?utf-8?B?REt3R1dTWWowOFVzaXRkZWFlckc4T3hlMlFFSlQ2WEdBK1g4YkQvV0UxUTBM?=
 =?utf-8?B?MS82NmthTlJMSUEyVTZ0amx6Y3ViYmF2ditYTUJmZ1lhS1VBRERIL2VOQ3FZ?=
 =?utf-8?B?WEpCdHBEaUlubGxNc1puWVJOWlZvRWxQeE45UDV0V1k0aHppdFVIMEthUmZI?=
 =?utf-8?B?VXBMN0J0bGY1TFZ1a2ZuRHdJMHdvd1JpWW1xY2RmMHJTdkJaTDhYbVdHNkxv?=
 =?utf-8?B?VzVjckpCMlZJOVhNU2xoRWRtZ0N0ZW4vZGZHRjgzc2dmam1yVjdKSFNkb2RM?=
 =?utf-8?B?eGtBbWx5MlR2aDdoOS9laGhkak1Md3BESmM1dUhFNHphNTlpdTlLWUExcE1w?=
 =?utf-8?B?ZmtMQ3o2RlR0anF1SDRORnZyNS9TREN2K0t5Vi9kcHBRcUdkOXVkSFRiSDdp?=
 =?utf-8?B?WFc4cGE5cHgrM2Joa1k2NG5IMmFabEdoZ09sdWVyckpYUldDM25FZ0hxSnVm?=
 =?utf-8?B?dTdlRVc0K1pRSVdkQzVJRGgyM0czbStwdzVudC9qTWR2OVJIcC9qWjNzYXpY?=
 =?utf-8?B?azAvMHBIS25zMVhzZVRDSXl0YjJmQUZDZlRXaTlYczVrd1hJb3VnZUl5cVdF?=
 =?utf-8?B?ZEJNRlVOWE1OY016K1hPdlZlVXhmTXpnaGhUVGtMZXBDdHJ3aHdxMUwyWWZB?=
 =?utf-8?B?dk4wNUo1eDFDMjk4bU82Z1ZhUGd1Ymw2Zk56KzdwdVd4OFo4M3dXdU9nejdD?=
 =?utf-8?B?ZVR3MFRkQzA4VTJUcnhBSXBBVFlteFZpWGpFbm10TW94MytFczRLaHFSQW9V?=
 =?utf-8?B?b1o1MGF0azNBaUlqdytLR25iQWVEQXdtQm5FWGpPRyt4bDFEZVlmSTVZKzg3?=
 =?utf-8?B?VVBnOUxRMlBzY2k4YVM3YXFvSndBQThPeTBIei9TM2JRVnBkZU0vZXVJK0FS?=
 =?utf-8?B?RmQxeXNQQnBHMXhmeHlQNWhIQ0dENnZDZHJlcSsraktHMnVTL0pyeVJocWFt?=
 =?utf-8?B?T0dZR29GdXVEYWdsQllVZEw2SVRUaENiTjRkMTVWNjlsTU1LRjdMRStvS3dV?=
 =?utf-8?B?UC9RZ05DczVRUjBKOStFeDBEdGdEZUx0SDdUa0tUcEw1M0g2cUpsK01qRHBn?=
 =?utf-8?B?TmR5S0tWRkNIZTdpbVN3dy81MkxiRnFxMi9CQTRXVE9OT01VdWFnRnVvckNz?=
 =?utf-8?Q?r/QOloc5kUnqqBpzc/eqVYuUq8W91yLWSIDqo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmIrMUJMdE45ekMxc0M3V0NZejZMbjNOUlN2ZlJ3b1N2amFUU2xNanhrWUgv?=
 =?utf-8?B?T0xsM0VIYTVEbis3OVhJcThJdk91YWtFR3ZKM0dvT012WHJBZ2dlb2tEYWpE?=
 =?utf-8?B?QlBQbGoxUWRhMEQ0eVZZcEVHcFlkbHlJdXRLbGE3b3E4S2FFQjN0SkhFUzE0?=
 =?utf-8?B?R2FjV2s4eG5PWGZKQ3cwVERaOExHUWVRNUE3UzNhdDQyWVM2WDZFSi9WT2Nw?=
 =?utf-8?B?aTBXTVV0My9PZlc4UWF2c3phbytNaVMzakZvamxDWkI2Tk5tbVUyZ0JqSSt5?=
 =?utf-8?B?THlNdVlvYXF1Tm1KeFVqaFVHMG1JV1hQUG9uUjduWGpFUVVsT2JsajBSSGtR?=
 =?utf-8?B?Um5JUEJxNU9RQkpDTUhjWVpaamhWd2grMytTTFRwcFBOVVQvbHN2L1cvK29I?=
 =?utf-8?B?L2g5c2FoNXE3RERJaG5DWmVaaW1PRTRZNi9McXlsM2ZQdVZ5LzRkNDhSZno0?=
 =?utf-8?B?TUdxVW83REJGRk9oRXNQNDJWR0xQVVl0UEtMbnB3WmVHcURFeUhJeWNyMkxt?=
 =?utf-8?B?RjZtRjkxVTZsZy91NVBpSjB0UXdIdklRTnp6REtWQzErc0ZIeUpDcDdScWE3?=
 =?utf-8?B?WkFVeFNRRzU5Y0ZXNUMxbjQ4RDlBOUVRM3hpZWo0aFpRdUJNb0dLVTg3TXIy?=
 =?utf-8?B?eGlHaWE5L09MVHQ1eGlwek03Q2pOOWt3NDhPS21qb0xjWWI5aC9VM1NFM00v?=
 =?utf-8?B?bnErZ2Q0QzVmNlBwRU16SDZCMnk4Z0I1eWdKR3IxWERNand3OSttR0FSbE4v?=
 =?utf-8?B?ZjdWdng1aXRoZ3o5OUxjVVhBT1RhaVZsSVh1SXNlYXA2RzkzV2xFWktSRnNp?=
 =?utf-8?B?azAxTm1IYWF2Z3pFYll1Y25GYkVSSUxvMENFeE1DQzFmV3lxb0VPbVR1VHVR?=
 =?utf-8?B?VHRmNGt1d3VRZDAwNTBmTFJSUFIvRUVwcUw1SUdrc2ErWEh6UHFQQTdPeExv?=
 =?utf-8?B?YVpsSlJsOUxET01OZGdGRGc4MjJMNit3NVNuM0M1YUxqYjYvUWhjTytydWZx?=
 =?utf-8?B?RHBEc0lUZGxpTHVwSTVFdC83MWw0eGZaK3VzUlY5Sm9DNmlzZlltME45dEI1?=
 =?utf-8?B?MDZHbnA0bjlLRFNWRGljN24yL0cwaExkR01DTE1kUEpHN0xVVmhOazdqQzN6?=
 =?utf-8?B?YWNqVld4QW5SM09hYjhGUjFhaEIvOXdnOUFhYkhTUjlIMHhpNWpobi94QlF0?=
 =?utf-8?B?NHNXOEk5eWgvSkVxMVV6d2dSbjNnczVKa2diblFvU3VDR05Jd1NvNVpYbzJX?=
 =?utf-8?B?dEdHbTdXV2JxWGthYkxFV2hnbW5sa3FIeld1K0NWeENUdHZkSFJ1ZStqZWcx?=
 =?utf-8?B?YUpKc2pkc2RacHdiSXdkZUd6K2FmU2dheXNzVEE0UWR0MWNpdk1EVVA2SWc2?=
 =?utf-8?B?aDJyUzZmYk1EUUtiQ2YvVW1tdFA0YkwvdVVMUTl3SXM5S2tCS3RxbHBPYlZl?=
 =?utf-8?B?S2ZVQlJacUVZVlJmR2Fac0IzaGRMay9hVmlQVkt4TjQzV0U2QWdiQWswSUsv?=
 =?utf-8?B?aGtORjIvTGJlNnB2TTBQZVBzTElvM0hObVBDTDBFQ3hPSjZlNUR3WUdRYmF2?=
 =?utf-8?B?T3N6c2V0SkVtekVxN3BqZ1pNd05yMEhZUXgycmM2Umg3TnREVXYyUU5iYjl2?=
 =?utf-8?B?YUh2anZPMnNRMlFpSVNMY0M5NXFDS1E3UHROOHNyUTZMdVlncndoYW9lWFMr?=
 =?utf-8?B?eHMvSVFuTDIwM3lHbXBSV2J2cTNXb0hHQWkwMXFpalF6Q09vY28rN1RmVndl?=
 =?utf-8?B?OGQwM1BIcDlmbjM5RFYvNEtWWFBQbWtzcUd0MVVKS3RIdVVuSldZNEUrNFFh?=
 =?utf-8?B?V3NBZk8zZGEyWjhINi9DMmdzWFgwRGRkbUVrd2ZQcC9aeCtkc2oyOVpSek16?=
 =?utf-8?B?MFZxS2hYT0FGUEFta2RpS3FnNURhUVJFQUpiREFTdzM5UGkwOUtQT25MOUpL?=
 =?utf-8?B?MGdMWWFQWGdjUFZVOEdLYzBPZUFYQkE0ZzFVcUY5V3I1K2pRRXVnS05pa3Zh?=
 =?utf-8?B?NENpd3VEdExWOEhoZHFrdjl0KzJhaXlKcEo2eWR1VzFBTTAzWEhDSXQveXk2?=
 =?utf-8?B?aG9scnl4b3ZLN205RGx4eCtObUlRUFFVcVFFNC9oV0Nza21oR2tyM095YWlq?=
 =?utf-8?Q?PNtuSypO39MxhjAfYs6nNKH6S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d401cc-9208-4f91-b626-08dcd2215dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 05:19:52.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krE6+Q4LFPeMweMdt7VI0xwxZzOz5vI2e7V6cJWaWfuYHMn+J/LMnlzkToHagFx9iAxFnG96YKCDFi5YYhmKJ3MJxIID5V66Sm2QDJL/dqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEwLCAy
MDI0IDY6NDIgUE0NCj4gVG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
R2hpbWlyYXksIEhpbWFsIFByYXNhZCA8aGltYWwucHJhc2FkLmdoaW1pcmF5QGludGVsLmNvbT47
IFVwYWRoeWF5LA0KPiBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgVGhvbWFzIEhl
bGxzdHLDtm0NCj4gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMS80XSBkcm0veGUvY2xpZW50OiBmaXgg
ZGVhZGxvY2sgaW4gc2hvd19tZW1pbmZvKCkNCj4gDQo+IFRoZXJlIGlzIGEgcmVhbCBkZWFkbG9j
ayBhcyB3ZWxsIGFzIHNsZWVwaW5nIGluIGF0b21pYygpIGJ1ZyBpbiBoZXJlLCBpZiB0aGUgYm8N
Cj4gcHV0IGhhcHBlbnMgdG8gYmUgdGhlIGxhc3QgcmVmLCBzaW5jZSBibyBkZXN0cnVjdGlvbiB3
YW50cyB0byBncmFiIHRoZSBzYW1lDQo+IHNwaW5sb2NrIGFuZCBzbGVlcGluZyBsb2Nrcy4gIEZp
eCB0aGF0IGJ5IGRyb3BwaW5nIHRoZSByZWYgdXNpbmcNCj4geGVfYm9fcHV0X2RlZmVycmVkKCks
IGFuZCBtb3ZpbmcgdGhlIGZpbmFsIGNvbW1pdCBvdXRzaWRlIG9mIHRoZSBsb2NrLg0KPiBEcm9w
cGluZyB0aGUgbG9jayBhcm91bmQgdGhlIHB1dCBpcyB0cmlja3kgc2luY2UgdGhlIGJvIGNhbiBn
byBvdXQgb2Ygc2NvcGUNCj4gYW5kIGRlbGV0ZSBpdHNlbGYgZnJvbSB0aGUgbGlzdCwgbWFraW5n
IGl0IGRpZmZpY3VsdCB0byBuYXZpZ2F0ZSB0byB0aGUgbmV4dCBsaXN0DQo+IGVudHJ5Lg0KPiAN
Cj4gRml4ZXM6IDA4NDUyMzMzODhmOCAoImRybS94ZTogSW1wbGVtZW50IGZkaW5mbyBtZW1vcnkg
c3RhdHMgcHJpbnRpbmciKQ0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0veGUva2VybmVsLy0vaXNzdWVzLzI3MjcNCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBB
dWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBDYzogSGltYWwgUHJhc2FkIEdoaW1pcmF5
IDxoaW1hbC5wcmFzYWQuZ2hpbWlyYXlAaW50ZWwuY29tPg0KPiBDYzogVGVqYXMgVXBhZGh5YXkg
PHRlamFzLnVwYWRoeWF5QGludGVsLmNvbT4NCj4gQ2M6ICJUaG9tYXMgSGVsbHN0csO2bSIgPHRo
b21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+ICMgdjYuOCsNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2NsaWVu
dC5jIHwgNiArKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2Ns
aWVudC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RybV9jbGllbnQuYw0KPiBpbmRleCBl
NjRmNGI2NDVlMmUuLmJhZGZhMDQ1ZWFkOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2RybV9jbGllbnQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2Ns
aWVudC5jDQo+IEBAIC0xOTYsNiArMTk2LDcgQEAgc3RhdGljIHZvaWQgc2hvd19tZW1pbmZvKHN0
cnVjdCBkcm1fcHJpbnRlciAqcCwNCj4gc3RydWN0IGRybV9maWxlICpmaWxlKQ0KPiAgCXN0cnVj
dCB4ZV9kcm1fY2xpZW50ICpjbGllbnQ7DQo+ICAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7
DQo+ICAJc3RydWN0IHhlX2JvICpibzsNCj4gKwlMTElTVF9IRUFEKGRlZmVycmVkKTsNCj4gIAl1
bnNpZ25lZCBpbnQgaWQ7DQo+ICAJdTMyIG1lbV90eXBlOw0KPiANCj4gQEAgLTIxNSwxMSArMjE2
LDE0IEBAIHN0YXRpYyB2b2lkIHNob3dfbWVtaW5mbyhzdHJ1Y3QgZHJtX3ByaW50ZXIgKnAsDQo+
IHN0cnVjdCBkcm1fZmlsZSAqZmlsZSkNCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJvLCAmY2xp
ZW50LT5ib3NfbGlzdCwgY2xpZW50X2xpbmspIHsNCj4gIAkJaWYgKCFrcmVmX2dldF91bmxlc3Nf
emVybygmYm8tPnR0bS5iYXNlLnJlZmNvdW50KSkNCj4gIAkJCWNvbnRpbnVlOw0KPiArDQo+ICAJ
CWJvX21lbWluZm8oYm8sIHN0YXRzKTsNCj4gLQkJeGVfYm9fcHV0KGJvKTsNCj4gKwkJeGVfYm9f
cHV0X2RlZmVycmVkKGJvLCAmZGVmZXJyZWQpOw0KPiAgCX0NCj4gIAlzcGluX3VubG9jaygmY2xp
ZW50LT5ib3NfbG9jayk7DQo+IA0KPiArCXhlX2JvX3B1dF9jb21taXQoJmRlZmVycmVkKTsNCj4g
Kw0KDQpSZXZpZXdlZC1ieTogVGVqYXMgVXBhZGh5YXkgPHRlamFzLnVwYWRoeWF5QGludGVsLmNv
bT4NCg0KVGhhbmtzLA0KVGVqYXMNCj4gIAlmb3IgKG1lbV90eXBlID0gWEVfUExfU1lTVEVNOyBt
ZW1fdHlwZSA8DQo+IFRUTV9OVU1fTUVNX1RZUEVTOyArK21lbV90eXBlKSB7DQo+ICAJCWlmICgh
eGVfbWVtX3R5cGVfdG9fbmFtZVttZW1fdHlwZV0pDQo+ICAJCQljb250aW51ZTsNCj4gLS0NCj4g
Mi40Ni4wDQoNCg==

