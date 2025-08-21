Return-Path: <stable+bounces-171949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A1B2EF12
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686581BC356C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D32765E6;
	Thu, 21 Aug 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLYT4F79"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F72820B2;
	Thu, 21 Aug 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759928; cv=fail; b=kQfTmbffF07Qj3bJmrPfxNBtrYxcIe+ia5gRkerqytY8sTnalM9LRGMfAPJO4+WcTGtSlGg1AlfEErJYZjpKKHHLpHEkaq3VQVY+ga7rFeMmujq93EjcSM67A0miov4Q+2NThJrZ9EBlvefiMUKf2TdVvST/7KMuUPaeSh3P3GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759928; c=relaxed/simple;
	bh=05MNFH21fE1qlU5qJNdNUzQw3n9tLhFU/hVf5KZ8Qw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxiuqcfX9dlg26Jmk80Gt8u7JUrjk4wVZTI6KYq56mPwtiK2ONdkU7Imssg8OZbn17NMWuwY8VJo/lox+eQA7UD60rUvCYhvvicxJ1I1Rj1upafFtR7d0vHnjS3FU9dZw30SKHakIJG5Uzy2T42A5Vgp4SiPuHMsVaxelDUwuvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLYT4F79; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755759925; x=1787295925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=05MNFH21fE1qlU5qJNdNUzQw3n9tLhFU/hVf5KZ8Qw8=;
  b=OLYT4F79UqXHlLV9MWchKX08Tb8gWtbolgwAjVKwpsiPShsJz00jRXM7
   KZnRVAlTB0O1Njv3e/3VMejt0dh0ZZv2Bmqslg/sgfWOhkMS2rZnys+jx
   rOx6sLrsjCnZ67y11J4cfDCfTpgvUMxEYO9/5RznZURZroZfy+6uMQq1x
   zXUGXFpdwJvcwlCMZVJrOAqZwFLr4xgOwmCgoz26ojHvzEPUFgJ/nrba/
   Yu3HEfysLnS6P1CetaCMG+HpzdHGs5qfUY9E3JUtV+bn1CPfuUEFUqIoS
   8K9Cj55rCfGMn1ZlR56cBAs+NTDXHY9pd79Tqg653i1/CGoj9qmZlMH6f
   g==;
X-CSE-ConnectionGUID: 1FyIL9C1TwGlkgJGTV1wJw==
X-CSE-MsgGUID: wMV3iFHSQY6ToePpfkAhog==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83459590"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="83459590"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:05:25 -0700
X-CSE-ConnectionGUID: 632jWvRiSL21V+jlpaC4oQ==
X-CSE-MsgGUID: lPiTHGrtSey05A8tMZTZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199316212"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:05:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 00:05:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 00:05:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 00:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1B8lpoIfYwaE+8KDtmLkR87bwZMqhEtBy/bOSWrjfW8rrSAZDXJaN2Gx4wEIrFlAZiy1SJ4JmVGl0vFXdkuaSa65tUi6FxNVq3/XZWoe3qNVUUsSgd1h87dJPGhq3MGlZTbcN9Hd/3YNwuAz6lCpPRrLpjxND7wmgPWz/bIVAKs+G6jpHuR3+fzu1tOflu+i4SkgtKxJzEgo5whsGIG5fq1hE7Upr1SKVKSSLwxzJhPdZIkUWf1y9ThXw0gyNGP9qYAfBNYdC2GV6/3LkeAlaKV7uL3Ik9qEOJ4QSuYMDLhk7/5HBAA7w2ScgGQ+dSJakA7SBuQ0omeEnjoLCNU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05MNFH21fE1qlU5qJNdNUzQw3n9tLhFU/hVf5KZ8Qw8=;
 b=hTpZIRvW5Etp5qXwXBeYeZyL/kjlNZJJJMaYcoLw4NXtJT5840JADDMfeQcOuZdLkfaSSq869RHwnOjvJKnv7cqEMNZB2JeOV3FYwIj2Q1XtKZS0d8a1j7W5YpVYQtG5/d67jYfSx1xcK08pBGyjyT4QyoUgR5UknHQfLkojfr8M9SwfrOIvx7Joip/MzWbhXuMHkARVk+hvMgq43i83mD7J6mLkBXHNH0sCZiL+PB1OdTBwLWpbdDHVsiV6LAnzGcEARva8jHb7J+G9dPyOsauGkQIeph8+sdDBfyamIwS3gNtSqISFMGUYO4vCv2TwMCp5RRT6zdo3iz5+fv5t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 07:05:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 07:05:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki
	<urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHcBpLRgrfnVjVEu0GV5qP87jgc6rRVuXIAgAANmoCAAANigIAAAUgAgAAHBQCAAXKbgIAAVvcAgABvkhCAD/fEgIAEtghg
Date: Thu, 21 Aug 2025 07:05:21 +0000
Message-ID: <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
In-Reply-To: <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5199:EE_
x-ms-office365-filtering-correlation-id: 39590c2c-0fc9-472b-02eb-08dde08117d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cStaTWVMa0dmaFNua3lqbDg4MmFFWkZGV3EvYjVPMTkwbEZRaytMMGFLYVI1?=
 =?utf-8?B?RW1Iak1QYlpYc1lncS9pK04yNlpPU0RQN2NoVmN6VXRYeW81OGxWZ09MME5x?=
 =?utf-8?B?Z3JSTXd0LzNqeWJycnlOcGxyMUl3bFd3WEVYSGhNQW9JbTIwKzI0ZzdzcmJV?=
 =?utf-8?B?MGZxUFEwYVVNVnRBMXhhM20zWTJCWWU3czRhcWVlMHZZTXAwS3E4d0hnRms3?=
 =?utf-8?B?MEdZc3RRT0sxeXoxMk5iOUl5bmMxTXJlTW5mWi96cjNqK1ljU1FCUFFzc1Vr?=
 =?utf-8?B?QzdmMytBQzNYZ0xoRTRhT1FWN3BWVUxnQTIvVGxyREZ3NFhqaGtVUDJEcXBk?=
 =?utf-8?B?WHFUY3VXSWxzc0l0allqRkFpUGp6MmVURDdVeHRtM2tnOFpIUWJqbmhKdTRM?=
 =?utf-8?B?ZExhcUx2Q0FpUFdNdEE0cHVFTmVabEcwMHhmQmVDa0M0LzZQcVFBYlVyR3Nz?=
 =?utf-8?B?ZnExNXBXZUlxbi9pK1lxbXRPbUV2K1RUalZXbWd6UUlaMUk3RVhUbUVkUXVN?=
 =?utf-8?B?b2pBMzA3cTk1N0hLTEcrd0xNOEd2bFR2SmZ5NnhQRWJSREZrVmFtbWdRWFM1?=
 =?utf-8?B?a2owNXJQLzdVSjNQQ1NCWjdtNDBHdmxMZG9jNEw0WGdvWnVRRmRNQkdsK2d4?=
 =?utf-8?B?MlgxQWtqQitxQ0ZqRVZPNFQvVGlTQjdvSVZYU1E1UDJhYnA5WlFVY0sxUmd4?=
 =?utf-8?B?aWtrelV1ZFNOL1Q4K0N0ME82NGU3dEJ4ZUhCZm5LcUhMdE1HYklRenBJTzAv?=
 =?utf-8?B?M1BGUG45S0lpVlJQeHZvRFVHKzgzYUN6VndtSHZFUVcrRjRaRk5sdHJOUkVU?=
 =?utf-8?B?SWplbUVJNEdNSVVEVElRWTFpVzlXV1N4cGNrZVh1OFZHVVpKcDhGbWdtV2Zs?=
 =?utf-8?B?cndVV3IrcENrNDdEUTJBQ3hPVDNNNkZsSFhYdUZzY3cyWlZVWGc5TFd6NUll?=
 =?utf-8?B?YlJGKy9TL2NqMjJJa2lCNVc3TFNLMzhLQkxKUVkwcmpFMjNidFFzZE1lUXlk?=
 =?utf-8?B?YWczRUVQeFd0YnJJZVNGMm1pRVBhTWQybUNoTncrR2xqZkJVdHNxR1RPYzRK?=
 =?utf-8?B?SGVSQ0dTZlNieENFaGFwS0paeUZWNzRYZVdFSEttMytNSzF0WlhROTRzNER5?=
 =?utf-8?B?L2tuRStaQVdFdnBoMERXSjJ6d0JUa1crcEx6ODZEVnZZKzdsR3djU0FNdUFv?=
 =?utf-8?B?MWx0QmlmcmdPZTZzVDNJRjZ5ZHg4SkJFTzlTNG02VFRjd0pXaEdpcVZOc3ox?=
 =?utf-8?B?RmxvWVBXWFBySmNRbC93aTNKUVlBaW1UZXNIbEIyTmRkZlkwL0piRDJEZWlD?=
 =?utf-8?B?RHNCQzVqY2pEdjNCTWx3RldxTGU1bzVHMWhqdERWLzR6Lzh5WFZOSjVFdXI2?=
 =?utf-8?B?bHIrQXVRZmJlQTBqd0h2SHRZeUlCYm9VSStLY2crckhydmJDVWJ4NGR0enFi?=
 =?utf-8?B?Y2RNZGFJY1R5dlNaSXJxR2txUEF1T0ZXYmtmRlV0a2JmSnhaa2ZiTWxLVVg5?=
 =?utf-8?B?dWtQU0FuVlRpNWx6VnRBU1h0T2RmWEFRbG42YUNoT0x1S3pkYVFhb3BiUXhD?=
 =?utf-8?B?OW5PL1FlQktHQ2lpSkdlbTdIRHNHY3NMMG1QdmV3VlNaa1dVcEdTUkpwb3dk?=
 =?utf-8?B?MjFqblVzTEExRnpNeTE3Z1NkNWlYVU1XQTJJaW1COGpkZno0eHZ1T3JZVVoz?=
 =?utf-8?B?OGI2R292VWlVbUJWcXdVZkhLQ1FWUUl2ME9ZVEpHM3R4d2tlNHcvSnhuTGtO?=
 =?utf-8?B?Nm51OWdhZ1J2WUZ3SDVHNkNlVVBrRjFWYThEc0lEa2UvSVh1Vkh5bDVPeTQv?=
 =?utf-8?B?eXA2d2V6UTdVcXpsNUNwWHdPeFhQWUZSeWNrT1ozUXAzbTlzbHFHQjlYZXUx?=
 =?utf-8?B?VzV2aVBIOGg3emZXdkVGcHIva1FkTnVjVk9UaGZYVzc4ak9DdU1VcTd1Y1Er?=
 =?utf-8?B?a3VmdmgwcjFwOGxHaU9tNkE1ZHhJS1VBRFFKT0dBZGxoT3k3bjN3dFRHUnNT?=
 =?utf-8?B?NnVXVlRVc1VBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFyRVdhV0ZPVGFiYWZPYy9BeVY5K2xQdjNGSVpDUS90MXZpeUpxQUVZOXZM?=
 =?utf-8?B?YmVkdlJGYW9MK0g0cW1nYkdxTG5qNHZ1UTdSUW0wL292OVpKSUg1SGFqaVY5?=
 =?utf-8?B?ZGdmOHd6QWVZZjU3UnNqK2ZaQ0xkdkF6V25Mbm95Z1pMeGpmbUVRUEhMTlRz?=
 =?utf-8?B?aW5nNkhIQ2FZam84SUxmOWR3RUUxSVFuTTdQbnJzdjlwMkIvTkw4R29sSnNH?=
 =?utf-8?B?OGkwVnRPclU2U3F0QjJ6YUVRYzhKVko4eksySTNxdmVzMjVVUzZHUzhEQUgx?=
 =?utf-8?B?elJhWXRFRlRDVjVuVGQ2L1ZJZVViTjgzcldFMkh5VEJrVWlCaC9RTkQvNHk4?=
 =?utf-8?B?TDVlbytmZlFZdlFEN0E0ZC84c2JMdVExQ25nZG1NY1hWYTFZU0JXMUgyQkVr?=
 =?utf-8?B?Y1NTaEhRTGFOVklzU3FOT0FDaFRVZy9sRHNpTFdlbVFPMFdMOE10ZW9ESzhG?=
 =?utf-8?B?blZ2bWZxUTdwVkdrUFUydVpqOFdOc3dPeXF6bmMvWE4yeHp5VU1DVktTZkNt?=
 =?utf-8?B?bEJvVTMxTG0rdVVwYXVUNFVQOGpLVGRNd3BPTHFiUjNEVy92OXEwMlp0VnBW?=
 =?utf-8?B?cVBTZ1R1NllCL0FuYXRTcUMvdGlhM3NSV3pNYmgxMVpIYkNjZlhoUGxqN3h3?=
 =?utf-8?B?QnY3YjE1elhPOHNwTFRhdEJEeHBzRUw2cXpvcURDU2Jzd25CQlpoMnlYZVJl?=
 =?utf-8?B?UXVQcm15dWZ4bUxUM3pYV1lVckhhVlpNTTBIMzRRNUJsVW9GdkNoYjdtRFNP?=
 =?utf-8?B?T0FhL1dzSmVGMVlsTFA4aXVQbzdEcW1wRmVjd2R1VTVld28xdDA0UWxWdHFG?=
 =?utf-8?B?NmRFSm81eGhIVEFnN0liaXFxdUJGbVhIMDlQWUdTVks3UldoMUVYVVNJT1hr?=
 =?utf-8?B?VnpHZHhmWXR0YVV4WDNpcm4yNHdtT2VPNG1xUnhVbmwvWEVuakdhSUp6eGdp?=
 =?utf-8?B?RERXZ2ZITXVONlZDcG9FTHVkRzVHN0hNRkQwYmlidE4rWEdvM21uRWc1aGR3?=
 =?utf-8?B?VkpUMVFZU1h3eThaeG0weHUyclpuSHh2WnNCa1I2VENRZHJkNkp0L25keWw4?=
 =?utf-8?B?NFJqRWRxYllDRFpqWlpVdHY4dTluUFVRM1dBRmFRMVkySElRMFBYYjMyUy9m?=
 =?utf-8?B?RUVDZUFXZCtGb1NRSkdMM2orZWZ2SHJrSnRONFViZ2pTOE4vL0d0WGtsdDFl?=
 =?utf-8?B?bTBnNFZPYjJQREVQTGdIMDN0cDIvUXN0aXVCSGtxTTFDendId0pYTFQybWp0?=
 =?utf-8?B?dHpnZlplODQ2QkdLSFB0UEI1N2pKZE5CbjdHYjVZeWF0aytad3J4TkZlTWMr?=
 =?utf-8?B?RnhyZ29zbDlvU3dNM29sdUdjTXEzMTYxM0hMQlZ0eHdpUUJ2a3pUZEJUZ2do?=
 =?utf-8?B?dTRqdHJUT0w2a3dpWFd1SEp4SXp6N1NKTDEyUGM1Y3hRVjAxb0hQR3RCUnhE?=
 =?utf-8?B?emR6Z2plUnIrclN4dDNDbjF5TkF0Zk54U3NldnRjeXJaQ1N6U2V5Ulp1bzNS?=
 =?utf-8?B?OWpZa1hzUTJtRXZCYndodGhSMXZkOWRhbk1RQnNaNzBtYTJVNmtoQ3BDQnFo?=
 =?utf-8?B?eHZJd2dhM1IxcU5QbGVpa3pOeVRzcm5YYThaQklUUDdhU2g4aVlKdFpQR0Rv?=
 =?utf-8?B?QmhEWlc5MENLY3l5ZzJmb3MwalYvS0RnVjkyS1N6VEdyY1lEcXROMmhIN1hy?=
 =?utf-8?B?RnRUTWhQZ0pIVkNXRGdmWkJEblFML2l6dDN6OWtZK29IVXYvMzJsY2pqaTBL?=
 =?utf-8?B?OFZrYmRLSnowbjY2QWh3ekNWQ01rcjRVU2RyK1hvcmdoSW5kQ2ZobGZyZHNK?=
 =?utf-8?B?V2tsbzh6RDN3eWlWUE81dytxVFhNWlJPYXlIbXJwOGUvTXZHUEJtdENZSEt5?=
 =?utf-8?B?bUN4eHYweEZmVHhYVi95aW9xdXhJWGVzUmZNKzQ2OHJhb3VuQUNyOG1lQkps?=
 =?utf-8?B?QXp6ZFRFb3NYZHpNV1RoQnFZVk1LVC9GdlRNWHZTZEZ0bWpNaVVRNDBOdFJq?=
 =?utf-8?B?MWczVFZndjNaZ2Y1WHZFTFhlMnZDRURsbXdtcTA5NkZKeHBDcGFFQlpwVCtV?=
 =?utf-8?B?ZGc4Ym52RVp0K2dlbVZpNGt5MktNWkducHlWVVEybEh2cldrTVNoSVFBKy9B?=
 =?utf-8?Q?FrUkMpOpU6grDh1Wk+cyNYTBg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39590c2c-0fc9-472b-02eb-08dde08117d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 07:05:21.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y9Or+IGrOgbDlBk5L6HnrMknac3DhfEoLpXcU5Dp7EVBumA/3UK+hAR5pEZDNb4ZgCzZKD4YPewZq/JwOOV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAxOCwgMjAyNSAyOjIyIFBNDQo+IA0KPiBPbiA4LzgvMjUgMTA6NTcsIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
Pg0KPiA+PiBTZW50OiBGcmlkYXksIEF1Z3VzdCA4LCAyMDI1IDM6NTIgQU0NCj4gPj4NCj4gPj4g
T24gVGh1LCBBdWcgMDcsIDIwMjUgYXQgMTA6NDA6MzlQTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6
DQo+ID4+PiArc3RhdGljIHZvaWQga2VybmVsX3B0ZV93b3JrX2Z1bmMoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQ0KPiA+Pj4gK3sNCj4gPj4+ICsJc3RydWN0IHBhZ2UgKnBhZ2UsICpuZXh0Ow0K
PiA+Pj4gKw0KPiA+Pj4gKwlpb21tdV9zdmFfaW52YWxpZGF0ZV9rdmFfcmFuZ2UoMCwgVExCX0ZM
VVNIX0FMTCk7DQo+ID4+PiArDQo+ID4+PiArCWd1YXJkKHNwaW5sb2NrKSgma2VybmVsX3B0ZV93
b3JrLmxvY2spOw0KPiA+Pj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocGFnZSwgbmV4dCwg
Jmtlcm5lbF9wdGVfd29yay5saXN0LCBscnUpIHsNCj4gPj4+ICsJCWxpc3RfZGVsX2luaXQoJnBh
Z2UtPmxydSk7DQo+ID4+DQo+ID4+IFBsZWFzZSBkb24ndCBhZGQgbmV3IHVzYWdlcyBvZiBscnUs
IHdlIGFyZSB0cnlpbmcgdG8gZ2V0IHJpZCBvZiB0aGlzLiA6KA0KPiA+Pg0KPiA+PiBJIHRoaW5r
IHRoZSBtZW1vcnkgc2hvdWxkIGJlIHN0cnVjdCBwdGRlc2MsIHVzZSB0aGF0Li4NCj4gPj4NCj4g
Pg0KPiA+IGJ0dyB3aXRoIHRoaXMgY2hhbmdlIHdlIHNob3VsZCBhbHNvIGRlZmVyIGZyZWUgb2Yg
dGhlIHBtZCBwYWdlOg0KPiA+DQo+ID4gcHVkX2ZyZWVfcG1kX3BhZ2UoKQ0KPiA+IAkuLi4NCj4g
PiAJZm9yIChpID0gMDsgaSA8IFBUUlNfUEVSX1BNRDsgaSsrKSB7DQo+ID4gCQlpZiAoIXBtZF9u
b25lKHBtZF9zdltpXSkpIHsNCj4gPiAJCQlwdGUgPSAocHRlX3QgKilwbWRfcGFnZV92YWRkcihw
bWRfc3ZbaV0pOw0KPiA+IAkJCXB0ZV9mcmVlX2tlcm5lbCgmaW5pdF9tbSwgcHRlKTsNCj4gPiAJ
CX0NCj4gPiAJfQ0KPiA+DQo+ID4gCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwbWRfc3YpOw0K
PiA+DQo+ID4gT3RoZXJ3aXNlIHRoZSByaXNrIHN0aWxsIGV4aXN0cyBpZiB0aGUgcG1kIHBhZ2Ug
aXMgcmVwdXJwb3NlZCBiZWZvcmUgdGhlDQo+ID4gcHRlIHdvcmsgaXMgc2NoZWR1bGVkLg0KPiAN
Cj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB5b3Ugd2VyZSB0YWxraW5nIGFib3V0IHBt
ZF9mcmVlKCksIGNvcnJlY3Q/IEl0DQoNCnllcw0KDQo+IGFwcGVhcnMgdGhhdCBib3RoIHBtZF9m
cmVlKCkgYW5kIHB0ZV9mcmVlX2tlcm5lbCgpIGNhbGwNCj4gcGFnZXRhYmxlX2R0b3JfZnJlZSgp
LiBJZiBzbywgaG93IGFib3V0IHRoZSBmb2xsb3dpbmcgY2hhbmdlPw0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGdhbGxvYy5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9w
Z2FsbG9jLmgNCj4gaW5kZXggZGJkZGFjZGNhMmNlLi4wNGY2YjViYzIxMmMgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGdhbGxvYy5oDQo+ICsrKyBiL2luY2x1ZGUvYXNtLWdl
bmVyaWMvcGdhbGxvYy5oDQo+IEBAIC0xNzIsMTAgKzE3Miw4IEBAIHN0YXRpYyBpbmxpbmUgcG1k
X3QgKnBtZF9hbGxvY19vbmVfbm9wcm9mKHN0cnVjdA0KPiBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25l
ZCBsb25nIGFkDQo+ICAgI2lmbmRlZiBfX0hBVkVfQVJDSF9QTURfRlJFRQ0KPiAgIHN0YXRpYyBp
bmxpbmUgdm9pZCBwbWRfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcG1kX3QgKnBtZCkNCj4g
ICB7DQo+IC0gICAgICAgc3RydWN0IHB0ZGVzYyAqcHRkZXNjID0gdmlydF90b19wdGRlc2MocG1k
KTsNCj4gLQ0KPiAgICAgICAgICBCVUdfT04oKHVuc2lnbmVkIGxvbmcpcG1kICYgKFBBR0VfU0la
RS0xKSk7DQo+IC0gICAgICAgcGFnZXRhYmxlX2R0b3JfZnJlZShwdGRlc2MpOw0KPiArICAgICAg
IHB0ZV9mcmVlX2tlcm5lbChtbSwgKHB0ZV90ICopcG1kKTsNCj4gICB9DQoNCmJldHRlciB0byBy
ZW5hbWUgcHRlX2ZyZWVfa2VybmVsX2FzeW5jKCkgdG8gcGFnZXRhYmxlX2ZyZWVfa2VybmVsX2Fz
eW5jKCkNCmFuZCBjYWxsIGl0IGRpcmVjdGx5IGhlcmUgbGlrZSB5b3UgZGlkIGluIHB0ZV9mcmVl
X2tlcm5lbCgpLiBvdGhlcndpc2UgaXQncw0KYSBiaXQgd2VpcmQgdG8gY2FsbCBhIHB0ZSBoZWxw
ZXIgZm9yIHBtZC4NCg0KYWNjb3JkaW5nbHkgZG8gd2UgbmVlZCBhIG5ldyBoZWxwZXIgcG1kX2Zy
ZWVfa2VybmVsKCk/IE5vdyB0aGVyZSBpcw0Kbm8gcmVzdHJpY3Rpb24gdGhhdCBwbWRfZnJlZSgp
IGNhbiBvbmx5IGJlIGNhbGxlZCBvbiBrZXJuZWwgZW50cmllcy4gZS5nLg0KbW9wX3VwX29uZV9w
bWQoKSAob25seSBpbiBQQUUgYW5kIEtQVEkpLCBkZXN0cm95X2FyZ3MoKSBpZiANCkNPTkZJR19E
RUJVR19WTV9QR1RBQkxFLCBldGMuDQoNCj4gDQo+ID4NCj4gPiBhbm90aGVyIG9ic2VydmF0aW9u
IC0gcHRlX2ZyZWVfa2VybmVsIGlzIG5vdCB1c2VkIGluIHJlbW92ZV9wYWdldGFibGUgKCkNCj4g
PiBhbmQgX19jaGFuZ2VfcGFnZV9hdHRyKCkuIElzIGl0IHN0cmFpZ2h0Zm9yd2FyZCB0byBwdXQg
aXQgaW4gdGhvc2UgcGF0aHMNCj4gPiBvciBkbyB3ZSBuZWVkIGR1cGxpY2F0ZSBzb21lIGRlZmVy
cmluZyBsb2dpYyB0aGVyZT8NCj4gPg0KPiANCj4gSW4gYm90aCBvZiB0aGVzZSBjYXNlcywgcGFn
ZXMgaW4gYW4gYXJyYXkgb3IgbGlzdCByZXF1aXJlIGRlZmVycmVkDQo+IGZyZWVpbmcuIEkgZG9u
J3QgYmVsaWV2ZSB0aGUgcHJldmlvdXMgYXBwcm9hY2gsIHdoaWNoIGNhbGxzDQo+IHBhZ2V0YWJs
ZV9kdG9yX2ZyZWUoKSwgd2lsbCBzdGlsbCB3b3JrIGhlcmUuIFBlcmhhcHMgYSBzZXBhcmF0ZSBs
aXN0IGlzDQoNCnRoaXMgaXMgdGhlIHBhcnQgd2hpY2ggSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5k
LiBJcyB0aGVyZSBndWFyYW50ZWUgdGhhdA0KcGFnZSB0YWJsZXMgcmVtb3ZlZCBpbiB0aG9zZSBw
YXRoIGFyZSBub3QgYWxsb2NhdGVkIHdpdGggYW55DQpwYWdldGFibGVfY3RvciBoZWxwZXJzPyBP
dGhlcndpc2Ugc29tZSBzdGF0ZSBtaWdodCBiZSBicm9rZW4gdy9vDQpwcm9wZXIgcGFnZXRhYmxl
X2R0b3IoKS4NCg0KS25vd2luZyBsaXR0bGUgaGVyZSwgc28gbGlrZWx5IEkgbWlzc2VkIHNvbWUg
YmFzaWMgY29udGV4dC4NCg0KPiBuZWVkZWQ/IFdoYXQgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhl
IGZvbGxvd2luZz8NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9pbml0XzY0LmMgYi9h
cmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gaW5kZXggNzZlMzNiZDdjNTU2Li4yZTg4NzQ2M2MxNjUg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL2luaXRfNjQuYw0KPiArKysgYi9hcmNoL3g4Ni9t
bS9pbml0XzY0LmMNCj4gQEAgLTEwMTMsNyArMTAxMywxMCBAQCBzdGF0aWMgdm9pZCBfX21lbWlu
aXQgZnJlZV9wYWdldGFibGUoc3RydWN0IHBhZ2UNCj4gKnBhZ2UsIGludCBvcmRlcikNCj4gICAg
ICAgICAgICAgICAgICBmcmVlX3Jlc2VydmVkX3BhZ2VzKHBhZ2UsIG5yX3BhZ2VzKTsNCj4gICAj
ZW5kaWYNCj4gICAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAgIGZyZWVfcGFnZXMo
KHVuc2lnbmVkIGxvbmcpcGFnZV9hZGRyZXNzKHBhZ2UpLCBvcmRlcik7DQo+ICsgICAgICAgICAg
ICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVNZTkNfUEdUQUJMRV9GUkVFKSkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAga2VybmVsX3BndGFibGVfZnJlZV9wYWdlc19hc3luYyhwYWdlLCBv
cmRlcik7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpcGFnZV9hZGRyZXNzKHBhZ2UpLA0KPiBvcmRlcik7
DQo+ICAgICAgICAgIH0NCj4gICB9DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGF0
L3NldF9tZW1vcnkuYw0KPiBiL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4gaW5kZXgg
ODgzNGM3NmY5MWM5Li43ZTU2N2JkZmRkY2UgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL3Bh
dC9zZXRfbWVtb3J5LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPiBA
QCAtNDM2LDkgKzQzNiwxMyBAQCBzdGF0aWMgdm9pZCBjcGFfY29sbGFwc2VfbGFyZ2VfcGFnZXMo
c3RydWN0DQo+IGNwYV9kYXRhICpjcGEpDQo+IA0KPiAgICAgICAgICBmbHVzaF90bGJfYWxsKCk7
DQo+IA0KPiAtICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwdGRlc2MsIHRtcCwgJnBn
dGFibGVzLCBwdF9saXN0KSB7DQo+IC0gICAgICAgICAgICAgICBsaXN0X2RlbCgmcHRkZXNjLT5w
dF9saXN0KTsNCj4gLSAgICAgICAgICAgICAgIF9fZnJlZV9wYWdlKHB0ZGVzY19wYWdlKHB0ZGVz
YykpOw0KPiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BU1lOQ19QR1RBQkxFX0ZSRUUp
KSB7DQo+ICsgICAgICAgICAgICAgICBrZXJuZWxfcGd0YWJsZV9mcmVlX2xpc3RfYXN5bmMoJnBn
dGFibGVzKTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKHB0ZGVzYywgdG1wLCAmcGd0YWJsZXMsIHB0X2xpc3QpIHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnB0ZGVzYy0+cHRfbGlzdCk7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnJlZV9wYWdlKHB0ZGVzY19wYWdlKHB0ZGVzYykpOw0KPiAr
ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+ICAgfQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvYXNtLWdlbmVyaWMvcGdhbGxvYy5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ2Fs
bG9jLmgNCj4gaW5kZXggNDkzOGVmZjViNDgyLi4xM2JiZTE1ODg4NzIgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvYXNtLWdlbmVyaWMvcGdhbGxvYy5oDQo+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVy
aWMvcGdhbGxvYy5oDQo+IEBAIC00OCw4ICs0OCwxMiBAQCBzdGF0aWMgaW5saW5lIHB0ZV90DQo+
ICpwdGVfYWxsb2Nfb25lX2tlcm5lbF9ub3Byb2Yoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+IA0K
PiAgICNpZmRlZiBDT05GSUdfQVNZTkNfUEdUQUJMRV9GUkVFDQo+ICAgdm9pZCBwdGVfZnJlZV9r
ZXJuZWxfYXN5bmMoc3RydWN0IHB0ZGVzYyAqcHRkZXNjKTsNCj4gK3ZvaWQga2VybmVsX3BndGFi
bGVfZnJlZV9saXN0X2FzeW5jKHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpOw0KPiArdm9pZCBrZXJu
ZWxfcGd0YWJsZV9mcmVlX3BhZ2VzX2FzeW5jKHN0cnVjdCBwYWdlICpwYWdlcywgaW50IG9yZGVy
KTsNCj4gICAjZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBwdGVfZnJlZV9rZXJuZWxfYXN5
bmMoc3RydWN0IHB0ZGVzYyAqcHRkZXNjKSB7fQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGtlcm5l
bF9wZ3RhYmxlX2ZyZWVfbGlzdF9hc3luYyhzdHJ1Y3QgbGlzdF9oZWFkDQo+ICpsaXN0KSB7fQ0K
PiArdm9pZCBrZXJuZWxfcGd0YWJsZV9mcmVlX3BhZ2VzX2FzeW5jKHN0cnVjdCBwYWdlICpwYWdl
cywgaW50IG9yZGVyKSB7fQ0KPiAgICNlbmRpZg0KPiANCj4gICAvKioNCj4gZGlmZiAtLWdpdCBh
L21tL3BndGFibGUtZ2VuZXJpYy5jIGIvbW0vcGd0YWJsZS1nZW5lcmljLmMNCj4gaW5kZXggYjlh
Nzg1ZGQ2YjhkLi5kMWQxOTEzMmJiZTggMTAwNjQ0DQo+IC0tLSBhL21tL3BndGFibGUtZ2VuZXJp
Yy5jDQo+ICsrKyBiL21tL3BndGFibGUtZ2VuZXJpYy5jDQo+IEBAIC00MTMsNiArNDEzLDcgQEAg
c3RhdGljIHZvaWQga2VybmVsX3B0ZV93b3JrX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3
b3JrKTsNCj4gDQo+ICAgc3RydWN0IHsNCj4gICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCBsaXN0
Ow0KPiArICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgcGFnZXM7DQoNCnRoZSByZWFsIGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGUgdHdvIGxpc3RzIGlzIGFib3V0IHdoZXRoZXIgdG8gdXNlIA0KcGFnZXRh
YmxlX2R0b3JfZnJlZSgpIG9yIF9fZnJlZV9wYWdlKCkuIFRoZW4gY2xlYXJlciB0byBjYWxsIHRo
ZW0NCidwYWdlc19kdG9yJyBhbmQgJ3BhZ2VzJz8NCg0KPiAgICAgICAgICBzcGlubG9ja190IGxv
Y2s7DQo+ICAgICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCB3b3JrOw0KPiAgIH0ga2VybmVsX3B0
ZV93b3JrID0gew0KPiBAQCAtNDI1LDE3ICs0MjYsMjQgQEAgc3RhdGljIHZvaWQga2VybmVsX3B0
ZV93b3JrX2Z1bmMoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgIHsNCj4gICAgICAg
ICAgc3RydWN0IHB0ZGVzYyAqcHRkZXNjLCAqbmV4dDsNCj4gICAgICAgICAgTElTVF9IRUFEKGZy
ZWVfbGlzdCk7DQo+ICsgICAgICAgTElTVF9IRUFEKHBhZ2VzX2xpc3QpOw0KPiANCj4gICAgICAg
ICAgaW9tbXVfc3ZhX2ludmFsaWRhdGVfa3ZhX3JhbmdlKDAsIFRMQl9GTFVTSF9BTEwpOw0KPiAN
Cj4gICAgICAgICAgc3Bpbl9sb2NrKCZrZXJuZWxfcHRlX3dvcmsubG9jayk7DQo+ICAgICAgICAg
IGxpc3RfbW92ZSgma2VybmVsX3B0ZV93b3JrLmxpc3QsICZmcmVlX2xpc3QpOw0KPiArICAgICAg
IGxpc3RfbW92ZSgma2VybmVsX3B0ZV93b3JrLnBhZ2VzLCAmcGFnZXNfbGlzdCk7DQo+ICAgICAg
ICAgIHNwaW5fdW5sb2NrKCZrZXJuZWxfcHRlX3dvcmsubG9jayk7DQo+IA0KPiAgICAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocHRkZXNjLCBuZXh0LCAmZnJlZV9saXN0LCBwdF9saXN0
KSB7DQo+ICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnB0ZGVzYy0+cHRfbGlzdCk7DQo+ICAg
ICAgICAgICAgICAgICAgcGFnZXRhYmxlX2R0b3JfZnJlZShwdGRlc2MpOw0KPiAgICAgICAgICB9
DQo+ICsNCj4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocHRkZXNjLCBuZXh0LCAm
cGFnZXNfbGlzdCwgcHRfbGlzdCkgew0KPiArICAgICAgICAgICAgICAgbGlzdF9kZWwoJnB0ZGVz
Yy0+cHRfbGlzdCk7DQo+ICsgICAgICAgICAgICAgICBfX2ZyZWVfcGFnZShwdGRlc2NfcGFnZShw
dGRlc2MpKTsNCj4gKyAgICAgICB9DQo+ICAgfQ0KPiANCj4gICB2b2lkIHB0ZV9mcmVlX2tlcm5l
bF9hc3luYyhzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpDQo+IEBAIC00NDQsNCArNDUyLDI1IEBAIHZv
aWQgcHRlX2ZyZWVfa2VybmVsX2FzeW5jKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykNCj4gICAgICAg
ICAgbGlzdF9hZGQoJnB0ZGVzYy0+cHRfbGlzdCwgJmtlcm5lbF9wdGVfd29yay5saXN0KTsNCj4g
ICAgICAgICAgc2NoZWR1bGVfd29yaygma2VybmVsX3B0ZV93b3JrLndvcmspOw0KPiAgIH0NCj4g
Kw0KPiArdm9pZCBrZXJuZWxfcGd0YWJsZV9mcmVlX2xpc3RfYXN5bmMoc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCkNCj4gK3sNCj4gKyAgICAgICBndWFyZChzcGlubG9jaykoJmtlcm5lbF9wdGVfd29y
ay5sb2NrKTsNCj4gKyAgICAgICBsaXN0X3NwbGljZV90YWlsKGxpc3QsICZrZXJuZWxfcHRlX3dv
cmsucGFnZXMpOw0KPiArICAgICAgIHNjaGVkdWxlX3dvcmsoJmtlcm5lbF9wdGVfd29yay53b3Jr
KTsNCj4gK30NCj4gKw0KPiArdm9pZCBrZXJuZWxfcGd0YWJsZV9mcmVlX3BhZ2VzX2FzeW5jKHN0
cnVjdCBwYWdlICpwYWdlcywgaW50IG9yZGVyKQ0KPiArew0KPiArICAgICAgIHVuc2lnbmVkIGxv
bmcgbnJfcGFnZXMgPSAxIDw8IG9yZGVyOw0KPiArICAgICAgIHN0cnVjdCBwdGRlc2MgKnB0ZGVz
YzsNCj4gKyAgICAgICBpbnQgaTsNCj4gKw0KPiArICAgICAgIGd1YXJkKHNwaW5sb2NrKSgma2Vy
bmVsX3B0ZV93b3JrLmxvY2spOw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsg
aSsrKSB7DQo+ICsgICAgICAgICAgICAgICBwdGRlc2MgPSBwYWdlX3B0ZGVzYygmcGFnZXNbaV0p
Ow0KPiArICAgICAgICAgICAgICAgbGlzdF9hZGQoJnB0ZGVzYy0+cHRfbGlzdCwgJmtlcm5lbF9w
dGVfd29yay5wYWdlcyk7DQo+ICsgICAgICAgfQ0KDQp0aGVyZSBpcyBhIHNpZGUtZWZmZWN0IGhl
cmUuIE5vdyBhIGNvbnRpZ3VvdXMgcmFuZ2Ugb2YgcGFnZXMgKG9yZGVyPU4pDQphcmUgZnJlZWQg
b25lLWJ5LW9uZSwgc28gdGhleSBhcmUgZmlyc3QgZmVkIGJhY2sgdG8gdGhlIG9yZGVyPTAgZnJl
ZSBsaXN0DQp3aXRoIHBvc3NpYmlsaXR5IG9mIGdldHRpbmcgc3BsaXQgZHVlIHRvIHNtYWxsIG9y
ZGVyIGFsbG9jYXRpb25zIGJlZm9yZQ0KaGF2aW5nIGNoYW5jZSB0byBsaWZ0IGJhY2sgdG8gdGhl
IG9yZGVyPU4gbGlzdC4gdGhlbiB0aGUgbnVtYmVyIG9mDQphdmFpbGFibGUgaHVnZSBwYWdlcyBp
cyB1bm5lY2Vzc2FyaWx5IHJlZHVjZWQuDQoNCmJ1dCBsb29rIGF0IHRoZSBjb2RlIHByb2JhYmx5
IHdlIGRvbid0IG5lZWQgdG8gaGFuZGxlIHRoZSBvcmRlcj4wIGNhc2U/DQoNCm5vdyBvbmx5IGZy
ZWVfaHVnZXBhZ2VfdGFibGUoKSBtYXkgZnJlZSBhIGh1Z2UgcGFnZSwgY2FsbGVkIGZyb20NCnJl
bW92ZV9wbWRfdGFibGUoKSB3aGVuIGEgcG1kIGlzIGEgKmxlYWYqIGVudHJ5IHBvaW50aW5nIHRv
IGENCnZtZW1tYXAgaHVnZSBwYWdlLiBTbyBpdCdzIG5vdCBhIHJlYWwgcGFnZSB0YWJsZS4gSSdt
IG5vdCBzdXJlIHdoeQ0KaXQncyBwaWdneWJhY2tlZCBpbiBhIHBhZ2V0YWJsZSBoZWxwZXIsIGJ1
dCBzb3VuZHMgbGlrZSBhIGNhc2Ugd2UNCmNhbiBpZ25vcmUgaW4gdGhpcyBtaXRpZ2F0aW9uLi4u
DQoNCj4gKyAgICAgICBzY2hlZHVsZV93b3JrKCZrZXJuZWxfcHRlX3dvcmsud29yayk7DQo+ICt9
DQo+ICAgI2VuZGlmDQo+IA0KPiANCg==

