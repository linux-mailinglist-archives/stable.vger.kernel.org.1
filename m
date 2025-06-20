Return-Path: <stable+bounces-154971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0075AE152B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2867AF5F2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EA227E87;
	Fri, 20 Jun 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0TWjNJl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19617583;
	Fri, 20 Jun 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405360; cv=fail; b=MmGx6hklKxiIQ5rng9OS5v1xLCaVPm6K0gEHB4QsFm2JPojnCm9bQMlj9wiTzRQzuLqkSLFfj/BPywadngGIiZDExtwGl2oi51TR6BZgrWd/VN2jnwsmc7wVWYgVHRXxBeiFYdXXg2b05FiwEJUXxrxf4HnwI1WbFWRIZbn/eIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405360; c=relaxed/simple;
	bh=TjV0i6XqDLNM3KFhG7HxarSlFU6Q3U13u/lJlCoKuY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZtfpkZzQ4sJU8rYt0fwgxPrdCyM4g6YkVHEQfwi6nnBT5uDllrcMkimhiQXvaMmWIN0CEBnF8MwsNjHdAXhNpfNNoZZayHGDcflb9+WKfn0EJqQLLmRE89F/4Ayw6jdERCwjjUT2kbnpGC7VoXVFPelJzVfy67oLvRl9Lx+frs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0TWjNJl; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750405359; x=1781941359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TjV0i6XqDLNM3KFhG7HxarSlFU6Q3U13u/lJlCoKuY8=;
  b=c0TWjNJlk8x1AcBwoxVVAzOiAQ/MGtQZFAspazI8w8AM4WpZIJ/+IjJD
   cHTvp31IHZFjtxwTsiDvVw5eZmDLSnmAqq7CyP02SoiXiaHhdCRxVDkeJ
   b3wduS5Gkkdsi5EoVilkeGtbjlyC95aFfixkWX95FTsyb/GVa9DEj4kM1
   JhetVWugdGrwF3a/6o/MZnOFWGcwtJcO74OvKCflaKKb3TcXxYdJZZmHA
   xP28rVV7a3t/XItbxL9Ihco35QDg5LgDBr5fQ4Lc1xR23JROvln0ZRn4V
   i/zh8g9xAzzzkrGSRq7/+3RyR5hHkcf+dprXG1YN9YoUdlTE85qgL+xAL
   Q==;
X-CSE-ConnectionGUID: igItOJfXSIeRAEC7YYJiOA==
X-CSE-MsgGUID: STyE0KB0QJKQaz1E6x8Y7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="62927200"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="62927200"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:42:39 -0700
X-CSE-ConnectionGUID: vhX+mdrPRR64IELbdnIhjQ==
X-CSE-MsgGUID: KnnM81T1TumevfN1dsNiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="150272376"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:42:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 00:42:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 00:42:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 00:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dumrSnF9ekstpdu8RthzGXlHL1Rjamf5sqjG4ZhWfJH4XHI/aJ5uJTJhnyaMGPj8daKZIq2OW/cFXywnkO+vocMhM6wBl01EQ6xvkDlrPzSQTv5iVrCBJAI1ZN42DpWCQ3sPI+ofGEYxfsBGQ3Aq9oOqx8ktS1az1dcEP3clyqb3e739LOBt+d2QvPhwLeNIxVf/NYzn+uAr88OslpDAKBLIW2zK26/GTFUHtgUFh9D43jVvxuyuxNzSm0M34wq+dzUUJcvYkzJyTwuDZzSnaS3/k/2e55SXPX9GdUUwbe1qF7epxI+dmp851mtYfCwEeqMf68IAs72KVwatVEmHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjV0i6XqDLNM3KFhG7HxarSlFU6Q3U13u/lJlCoKuY8=;
 b=rzmtqCaFX1IRVli+NRjDu5BKfUCOlDQLT4bTio4cwNj3Q58+LdZ73n+A1zIZrPm2CuHevMgWGpngb8PKsdpFrSW60S4AEWOfcJ/KkzMxIZ9ZqHseK5IYiAgKDhXTPuoFv0Maz14XPuqUnG4YY5621DVUol6VNRCZF3mqxN7I6rxIwKio7JOiGBI9GrreYEC5GK/u4V5AV0hyeScaZLK896ZKlC7jv5/yjfgT4vkGX39FY6JJKorGrQWuBlhHxmkVIrW2p4+RMS06lIp8KghQEawSMaJtpDe5QURBEnJf0RLJlZnmqH9wqaPFDAG/dBTz80xxWWaCDrR1H7JYUFq5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 20 Jun
 2025 07:42:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Fri, 20 Jun 2025
 07:42:08 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, "Luck,
 Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
Subject: RE: Patch "EDAC/igen6: Skip absent memory controllers" has been added
 to the 6.15-stable tree
Thread-Topic: Patch "EDAC/igen6: Skip absent memory controllers" has been
 added to the 6.15-stable tree
Thread-Index: AQHb4YrDB4ktiVA54kCIJzftFfs8a7QLgidQgAAKiICAAB20kA==
Date: Fri, 20 Jun 2025 07:42:08 +0000
Message-ID: <CY8PR11MB7134A1CB68B986B7CF692B59897CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250620022630.2600530-1-sashal@kernel.org>
 <CY8PR11MB7134D06F062C1706175E0C13897CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250620055511.GAaFT3vwJHM3HIlwkS@fat_crate.local>
In-Reply-To: <20250620055511.GAaFT3vwJHM3HIlwkS@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA4PR11MB9060:EE_
x-ms-office365-filtering-correlation-id: e986b43f-e12f-4b81-eb3f-08ddafcdf5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QzM1UlZKeTJ1dzkrZS9YMTFtRTdMVXFpckZzY0JuVmZPNHVvTUM1WVVmMW1H?=
 =?utf-8?B?RFdMNEt5SnBvbXVxZCsxdDQ5YlUxbG9ZMDhOR0pUVGYvdkxvbGIzUTVGd1hi?=
 =?utf-8?B?cWRNcDRuUGwvOEhxSkQzU0RJR3E0N0lSTndtd1k5Wkxvbkt5K2F2Z09tV2JZ?=
 =?utf-8?B?eHFKRktYZVRMR0JqLzgzTS9aL3BBdmxWb1VzTFVuWm9RTS9SWXE4UjRZUERz?=
 =?utf-8?B?MG9CYUx0cGw4YzhiWTg0US9xNnR4L2plb0VHZDVDZEI1cHBrd215RG1OOG1p?=
 =?utf-8?B?WlZXa21RZ0pCbm95aGlWSjFuWW44SGVBeTNpNWpkandnWnNKY1Y3Yzh1L1ll?=
 =?utf-8?B?TWRnbmNCZTdZaGFmd0JDS0hNZ3FYUDRMR3ZMWTIwU3JkWkNwWExjR0dMc3ZJ?=
 =?utf-8?B?VGVEb0VibVRDOXkySlhLUVR6M1FmZ256QWpwdTgrZTNienJtSkNONEdDQjZi?=
 =?utf-8?B?dldrUDlmWE1Ma2FRV1krWFBXTjJuSTVRdXB6dm1BVmpMaGlTWnp6OVFjOUoz?=
 =?utf-8?B?KzhKMzlqWWMzeTNoNk1JTlFMNzJ3R1VXNXhJK3gzUzZYVlNtZWZMSk1WVHRJ?=
 =?utf-8?B?ZWFBcVRyZXZQTGFzKzlQYmg4UUdaVWJmSWNGMWUydUIvL1R6cUJtUDVlUHJB?=
 =?utf-8?B?YTZhVkxISml5NmpMMHNzVWdXVHFXc0lZd1AxdTM1YTJPZ3QzNEVkZ2FyNFhY?=
 =?utf-8?B?TWxSQVY2aDFRWkNxVXJvYU1qZHh3YW1hNU53MFkvVTNTdGhHajFJZVFBaWVr?=
 =?utf-8?B?bWV5dmJsOGxVazd4S3NjMHdNdldSYnU4TjVzbDBMenE4L04vSi9RVXdkU293?=
 =?utf-8?B?V05aQlJCM1J0ZlhFWGFMc2VxcXE1cUthS3hycVNWdk56N1VnQVRGS1dYSkgy?=
 =?utf-8?B?NWg4QXNHbUtJaWlvMnFhUktEaU56d3UxUndHckpCZGZvWGpzN25WZzlKOVow?=
 =?utf-8?B?eHpaQzhSclI4MlBwd25EQVgrYUFwdEtoSVduSFEvd3NxSk1WdnljVStEbTBS?=
 =?utf-8?B?M2VJNDZFdHgzMUFrZlBDcjFvOEhBMXJVSjEwT0xUL1ozcktlZ24rUTJmSkd6?=
 =?utf-8?B?ZzZ6dFF5Tk1vTnlpc1k2YmhKY3VPWmhlVkh0N0RHVDYvc1N5VThycC9OOVpj?=
 =?utf-8?B?TUMyUW1oVng4M0kvM1gwVmVINVEvNGVyY3JITy85Tk5ONDl5WmJXUUdScFJ2?=
 =?utf-8?B?cnlWNkZVVHVqVFZYa0lndjZYdi8vYTlIVVVvRStvRWF3Y2NZRlRZQ01TSnY2?=
 =?utf-8?B?UStRVjVrTHRnK0dkcnNwNjJqd1grRmZzcFhQdDhZNFlsditDMmc1bnNqajhK?=
 =?utf-8?B?UFZXVUthd2tlZUtzY1NRclM5QSswWlBCdTRlelY0UDBVRlE2T0RyQ2pERnJP?=
 =?utf-8?B?VVRpTC9Zc2c2dTFoSDlZWUpRejJQeHQ0YkloT0Q5QXA5UTlPaUozQlJzV0lV?=
 =?utf-8?B?bVRJcmNIVFJaRFdvRWhtQWFSSHRvZ1I1bDdWYkcxa0REa0Z3a2Z5VzliU1F4?=
 =?utf-8?B?VW1rRk9nRlVadnFOaUtDb09sVWRRcmpxOHFEMEMyVTZOZ0g0aVUzeFNkMVhG?=
 =?utf-8?B?SERtZGJPaVh3MkpHdkhnOERzVnR3T201QkdFQW4zTlA0T2lqSndsR0dMSGpW?=
 =?utf-8?B?MkdTRzRjd2lDVnVFbE1mdFpUUGJsZ3NxUFRzcGhxT1NEdmhPR0tMNFB5TE9Z?=
 =?utf-8?B?NTNyRXhmTmhlT2N3RkJHN2x4dzZFdVVMek9Ud28rdDJITG8ycUFYUWdzZ0lX?=
 =?utf-8?B?QUlaMU8wTVIxdFhqMlNhRmUvR010U1RGYnFXTG5tc3BFWG4wZmRqVjhlSmtC?=
 =?utf-8?B?VC83SEtmRS90WDZZWkxVRk4wNWkzSTdWNHZmZlRDYzdxVkVzVnZoaTNxUXU2?=
 =?utf-8?B?NFppTE8wS2FPVDl3S3hSWGdaZ1VmVGtNc0ZZalFlcmtJZ3d0cHNNd0puVFJs?=
 =?utf-8?B?OUwzNlluRXdpRytESUg0SktlbkdxSDFWOXhkNWhmMjBOelJUeWNUTFp0dzR6?=
 =?utf-8?B?ck0wNzgwalN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklrcHlGVFhtYUVRcVNaa3lJNXJQczNKdEd3K3NQT09kUXV2a1NNZWZFM0dW?=
 =?utf-8?B?eEZnRXpHZk9OQW13c0luUm9EZG1hR3lNZm1iVVM2cFViYWFCUTR2TmMzYjV4?=
 =?utf-8?B?RmsvcE5RRkZ2YXhweE02UUVwKzlXY1RLd1FlR2dOQllIUStSRGNDREJTMldz?=
 =?utf-8?B?QW5GWlpPc3k0THNreW96VS9zREJzM29URjdlZnlqZTVHdERlSjAzd0dUVE9Q?=
 =?utf-8?B?b0tZRW1NVk83Qi9HRHZBWnpUTDI3TEhZVUVzQlBUb2xEM3dRV3d4Vy8wbi82?=
 =?utf-8?B?YXZ0YmttRStlMm5ZUWtkMEw1My9Ecjd5QWNvM0xkUTV2T2h0Rk5kNVpkNVN3?=
 =?utf-8?B?SnF6OUdqTmNDdXBhUHFLbG5XS0hSWEs1QTQ4cmFIcjM3NmtOamw4cEE0ZGZp?=
 =?utf-8?B?cEU5S1NZcXZBSXRGNWorNC9BN3diU3VDYWJ1alVzSFNOUlZqZXpvRENzaXd0?=
 =?utf-8?B?bjhLWEh6d1phSGgvbnRmVUgvbkJkVnViVU9kRVVMVmRHajF6SE42OEdFTmMr?=
 =?utf-8?B?Vi9WTFViMHNYYTRoS0pMVytXeWpNVk0vazRCNGNmT0Z5bHYvT3lDYjkwWlB2?=
 =?utf-8?B?NzJHZUdFdisvem51MDR6b0NSb0JPUGRDQmhhV2ZxbzNpL3VTVGE2Z2x6ckEy?=
 =?utf-8?B?QzZXNE1FYkdMbG1RUzR2ckdXZ1pMS1BJSFZiM3NwYjlhcnJtWG9QbTVZSTdx?=
 =?utf-8?B?WTdaN09STmVzOSswT0RBbHdNdXFDQmVvODRoSHYyUDgxTjBtMThNam9GelNV?=
 =?utf-8?B?eTBDWGZZanZYT3hNLzVVYmdTWEFBUzhYdWlwMHNzeUpST2ttcStpNi9MNTV5?=
 =?utf-8?B?cThQNVptbHQ1OE9YRU4wM20vSVR1ODRBeWZYNDBEZmxtd0d1blQ1dHRnYmwz?=
 =?utf-8?B?VGNtMzF2ZS9nVnRJRlpxYzVjd3Y1WS80ZFhhYUVVVCt1M3ZRN2JXZnhrbHFj?=
 =?utf-8?B?VXU5Qzc5R3BkWEIxaS9taHI0QW00SENzbzVYNXNWNEI2V1ZMa2ZoelFEVXAw?=
 =?utf-8?B?Y2VlN0VtYkJaQ0xGL0dRWEl0UDVKNVJQYTRpRitneEwvTEVLQ3NtMlc0RUZv?=
 =?utf-8?B?QWlMVzEwNXFSakVkWHM4a3BRRWc4cm52T1k1dU9nNjIrOUpFMENRd0xEWTly?=
 =?utf-8?B?dnRhaGkwSVoxL2ZhMU0zT1padmZTZ2EwOHdHSTJoSE5CbVkwRFM2ZnhtTTls?=
 =?utf-8?B?djMyMG82VGVoY0RDSkh0dVBqeURNWXJrVGJlZUIvVlFKYThvYUVmdDJ4TnZK?=
 =?utf-8?B?SkpkckxJQ0VJSngzTzZJbjZMc2I5MzVlUTNMN3RGOHNMYktxRkxrcWRXcG9q?=
 =?utf-8?B?KzVTN2JJUHJOZE9pWkFPSWIrSnVOYVo0REFZV0lQeUxCSTRLQU1UTGRaRlBT?=
 =?utf-8?B?UjlxUjlVQTJqeDZ1aW5wekNJNi9FU2NOOUc1aUtIQkZFMHFuYTVSbVRLR09Z?=
 =?utf-8?B?ZENYM2lWeVJZRndSVkhMVi9yRGpxT2hPalR2SGNrLzJsaVhWVEdJaUdpRUN0?=
 =?utf-8?B?djN6eFJmb1JnekJxYVFOclE0RUNpTjJXNjBGVVQyKy9rY1JpRUJGVUNxUWVl?=
 =?utf-8?B?S0ZzNk5mbWVKa1UvNWU3L285VjROaityeXJ0SUtnbFlKYTV5Y3dhV2FGZ0NY?=
 =?utf-8?B?RUQ0L0w2d0x4NkNqSnBEaXlQSnpGVlpodmFwV2M5YUxFRFNQQThJakgyMHBs?=
 =?utf-8?B?L3hOM0NoQm1qenAzK0pkMWNKRmNFeWhoejFBaG1udnBGc2tZRjVueDRpaER3?=
 =?utf-8?B?RkFvOXJzM0F6TXhnUGJ2MHFzdzVudE94TnAxYnZDMTJtUWE3eGV5NCtUOG5I?=
 =?utf-8?B?L01Xb2ZzQUwwZGY4TXpvUmRNeGtXWHBpejFOS0dHYkFnWjdmTnpoZ0RNVGNo?=
 =?utf-8?B?bEwrVm9RSGFqak1IdDhuS05uSnd2ZlFTUkQrUUEyK2FXWHZ2NjJ6QklwVUFK?=
 =?utf-8?B?L1dYbXZyUVl4bUgxRXFxZDdPT3pETU9nK2tUbnpXT2o4QThwN1krV015UnRh?=
 =?utf-8?B?dlN0RzByTU9XWWZiK2pDVE1Ca1QrdFpCSGZEQWdYU3pIc1NEQzZ4Y3FIQWdO?=
 =?utf-8?B?SXVJQU9aRDQreG9XSm5BR2VRbERvNUIycHZ1UmE4Q2RKVC92Y2EwOTdTVXVG?=
 =?utf-8?Q?KgXgTj3GuCYbd0iasBZwTo6eu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e986b43f-e12f-4b81-eb3f-08ddafcdf5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 07:42:08.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp7PJl1QB1h94Te05zwfDwz7IMRSS0MGEmBe892NV9oJKxbn93bpjl/yd3gyHn7Mvo02IKE9NAod2oAJ9M727A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gT24gRnJp
LCBKdW4gMjAsIDIwMjUgYXQgMDU6MzA6MjZBTSArMDAwMCwgWmh1bywgUWl1eHUgd3JvdGU6DQo+
ID4gU28sIHBsZWFzZSBlaXRoZXIgZG8gbm90IGJhY2twb3J0IHRoaXMgcGF0Y2ggb3IgYmFja3Bv
cnQgaXQgdG9nZXRoZXINCj4gPiB3aXRoIHRoZSBwYXRjaCBbMV0sIHdoaWNoIGhhcyBiZWVuIHF1
ZXVlZCBpbiB0aGUgUkFTIGVkYWMtZHJpdmVycyBicmFuY2guDQo+IA0KPiBUaGlzIG9uZSB3aWxs
IGdvIHRvIExpbnVzIHRoaXMgd2Vlay4NCg0KVGhhbmtzIEJvcmlzLg0KDQotUWl1eHUNCg==

