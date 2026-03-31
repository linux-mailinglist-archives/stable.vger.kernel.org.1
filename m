Return-Path: <stable+bounces-231347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI+9CT17y2lPIQYAu9opvQ
	(envelope-from <stable+bounces-231347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:43:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC90365669
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D17C5300D56A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CC3C9442;
	Tue, 31 Mar 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFjRxvjh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BD3BF689;
	Tue, 31 Mar 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942110; cv=fail; b=sqFmrNkzK2IncQtVLn6qYdjI7N9DgMPpAJTrl0EVCAejREa/3ttPq8KGF/5Z2OxUObyrrbLBOcxZehxsqd+NwVhXSxoES602rpcq9CULNYqV1lIoAEGzdwQmvX3h3jA9z7y1iQ+52A+UXGTqvI7lKkwtxUrx2cbBDZS7cxi6eSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942110; c=relaxed/simple;
	bh=OJuuI40P/+IEylAAZJNUkvR8rtVuwQ9kyELXP7w54Wg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H06iy2MSE8aF15CLY3lh54rp841Jih9n1+pu0hh4kUEfWBakr3Xw5zRk1mRLhPYa11kuQdBynvQ7ss5ZNd0wJfc6Vodh6qpuGuRUTW96TNSyprPtpPiMkS+hnfTmFFNsmdVke1acLqkAovsuSLAIDVpdHnGEqDyEx8+OAsZJHnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFjRxvjh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774942109; x=1806478109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OJuuI40P/+IEylAAZJNUkvR8rtVuwQ9kyELXP7w54Wg=;
  b=VFjRxvjhs/H4vaDkC8NG/qZxf0h41njFCD0tTLMu4d2haBcdP6fC3dzy
   kxh6OCWGTcpPlXQ0xT+IA8PG9Egqvq9StlPIQ+FLcm6AJUzCGDd93UVgZ
   Bky3S/AizJAREvbZ7Ibsj3fT50U1hIgcmC8kF5dw68P0xENcs2alfN45D
   TX4uHe4SQUl0PiaaM0L/gGrgCsMxW94wIAntj4Cs7fMLxVWCTvgBEUJB4
   oa038MdeELfnRhFc7tx4R2SZgePtLNhAEyPx7LOv2AyJuWAQt1AnxVkPU
   2wefQ+NFSjDKBwC1o048KcoVTMv6i6iwiyyy0xA1Xk5bmMbSv4hTv/d4B
   A==;
X-CSE-ConnectionGUID: /+hFgXdnT/mZKxJiV5YnqQ==
X-CSE-MsgGUID: TdcL0qaeTTS2Yq99Xa4NLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75963481"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75963481"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:28:29 -0700
X-CSE-ConnectionGUID: /3RDRWM7RJisYseJLlSvxw==
X-CSE-MsgGUID: dAQ8qyNBTsm+b7GPpcesuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="230744354"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:28:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:28:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:28:27 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGEROojOse0IF6tuGPz5WyPUiiNesEOsniNllJL+37yegD86bqicSGT8PdNoItXyTFCMdYJBDVn4vut72eph4o7x1X1klWBQ5ZFPbmEEsFYI9uH3sbuYDS/shK9whfv2B8J3ifEIHXf9YShrInLpocumPYBHLr4hcn3uIOzEnag9FSkzF19zzg7zGUEz40arQkqlYJB/PGs7j4Dc1dNr718JLF9AX0/zMKMd8dM8Ha1/J6wqGbh+1PFyzmOd/VwkVVsNbsd+ahOEO9p5Hzbf83cCEEfTv4Rk+aqevdwEfa+Bl+T8C9fGBPScKjD7pkijdOwenTZ3D8TpekDJ8Ia2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHawumz6/tHuVWmGWxfhxQ7XllrHiINqt4n4B7eymr8=;
 b=nwMPyz+n6WZII1BGhVcqRk62OqjxwZGQhxrc2NI7e5XndC58mfayoD+8vhZcadTo0jPVemM5ZoszcYDdsZL8WAe8RCO5RcEF6CyBpvE0U7TzvY4+ZraQJznfCaNFCWo89XKrE4PYAzJN9nZashVIp/6raP/Bhy6WiANPkMpY/+3lb+aduJygKamR+Txll90gUp3L6Xw9nTGlrK3SwQe5BhcFtpdZAN2l7m81IKzzD07iMPY2UcdhllCUmD/nUXGIhJ/7lUv2WNUbbHdez9o4WnGGbIYYO6JEfTJMJ4t8X0KWxFnF5cPTUe/zIf3SU3yFRaqJivhGXWcvL6GCKec9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:28:23 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:28:23 +0000
Message-ID: <2c664395-72b2-4436-b60a-3ba2e73eaf95@intel.com>
Date: Tue, 31 Mar 2026 15:36:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
 domain with dirty tracking
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <dwmw2@infradead.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <stable@vger.kernel.org>, Joao Martins
	<joao.m.martins@oracle.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260330101108.12594-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 572b02b4-c913-4c34-d1a1-08de8ef7172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: crH2eTVpfhoz8oKnytln15H7bA3IgqMOOhbkIfV0zu6n5uYW3MGvs8T79kXfRDBdfEgXT5+Gs9xGFRiPeKFjO/BuVins7gNioEB+8BXnhg3nqfzAcIhGdSBKD2+ih9qYupcgYLovvqqEZ9fOhYmcCChdl38UfdA+rPi43NE3tQWkOtJY2hFJaUMjBuRs77xgH7w2PUVjK5uMYed1UjSTC6YYIQvo0HA5Xah86FHtIlT6QFoxS9lPLEaVfvpwdSR1AP9/F/9lUsJtPgonp87bZwzWnzF4LMso88lDVFQ4OrW8/wT83C/UeS4lrJIaqAPp8guKRQX5S6QjBaRKuUOAIIieLYwHbsfaSM7f+4wEb2xkgTXB9vUbYzLQEV3KztdRKlnVUvQPKvgQ0MpEu9L22F7mvbxqE85gfcTGfxvCXHXK/eF3PzMcMUL0Nuk3Zep6WPmtZIYChIO7meeOX1gjKYHMgcHhnqLUlr2m6JVccwCkTUTBHCjKzCJ67wot3b5l3cdEazgHHDj0tjcwTE5PNL21Bt3CU5A16hDhsU4iYSnaqoLfvgZcNkHZ+l8/rG7he/khwQ+0tDZT8Y9lGZot0Pu2Nyc9AD4/p80kAIkYTggtKOJY3XHngNQssqlCVvBtY9rxXaCdJ9ckze3TkIVV3dxi8wKGFQWzmADJX2Vn76AUmEn30HNZaRvva3oi7eat/tzIFsj8yzEZJJCLq+wFMEI8rJCtUz4vy7/AqSROS+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0VxYkp6eU1SNzd3cVNrdTNBSVhtNmNYODdvTEtvNnFMOGdVNWNaZGJyODN6?=
 =?utf-8?B?Uk1jUUxHWXVsdzdOdkJudUR3R1ZQcGJRUVZsVDNkanlwdWhVTCsrMllzenBx?=
 =?utf-8?B?bmNmdHRObGd4VUhEWURsNUFDSGRGVXI4MUFPUHZTc0hhR2JIcVg0d3lqeGU2?=
 =?utf-8?B?VHFrZnNncU96Tjd6MWlmajFrTGRUclorb2tTTEtHVW5TQ0lJSFJEa2VQZmNy?=
 =?utf-8?B?NU5yb0lBV2RnUzRNWk5obERNN3lxeEdZRFBzMjlFNUJ1aFBaSTRWRXkzL0VY?=
 =?utf-8?B?K1dmSXhKVVNBM1JpcXVockhYSEVYRXJwYnNRSktMOUYwVW14QUYrd2Y1MG9L?=
 =?utf-8?B?UkkwcjhoaVZCTllMYW5BZlp3bEZHa2V4TTM4bFdYdFl0MWJpK2UybU92MkVI?=
 =?utf-8?B?VXMvVzJ0QzQ2RFpGMzlkOEw0eVNjek0xRzl1UWx6NnFKL1pPdFREMWQ2YmdJ?=
 =?utf-8?B?SUxlWHZ0Ylg5R29zQXU3S3BFemRHQ293eEtERjFHT05IQTMwVnFDN1lham9a?=
 =?utf-8?B?RkpnMWpKeUNjUDREUUZiQjQ4ektUYjVZdDF4YTE3ZlhLajI4aGNmcnpLdjBl?=
 =?utf-8?B?Y1J6SnFWbWp6bEdkNkcxQkZPdFRRNkM1QjhUb08yWFoxYmlHTXBYRHQxZThV?=
 =?utf-8?B?RzNCanZOM1FLdWh3YkRXY1pBSFBKanN3emJTbHZsNXUwbHJCYXdkZEUwU1Bk?=
 =?utf-8?B?QVc1RkIzQjBjdWRhaFJneCtRclptd1pvMUZOWTZySG0vb3dnZ1N5aEZ6U3p5?=
 =?utf-8?B?ZElucitjWTJjZUZ2Y0g1Y1VXejl3SkMwSk9uL2dIN3grZG9wR1N3cUM0TjZk?=
 =?utf-8?B?blJQMGplbVNJWTE1YVlmekQ0Znd2VmwvbzZtMHJnRVBZRmRsV3RFR2pxTXJu?=
 =?utf-8?B?Z2lXc3FUNEFLWHpXY0tWMnNxbjNiKzZEWGxHT0lsb3lmbVB1aUdrSzZCZlNa?=
 =?utf-8?B?Tkp4bW5oOENWK3dYZDd5RlZPVmN0QnFKcEJQRjV5ai9LWjNuK09DY3I5ZHVD?=
 =?utf-8?B?NzVXcGxVd3U5clR4ZHVUekVPTmJyLzNXM2Z3cnJDZTNmSVdwdko2bis2djc3?=
 =?utf-8?B?VG8rUDVHUm9STTA3RVlIUy83OEhZZHg2MlJHTnEvekZnSktoYVRHTmU1b2JZ?=
 =?utf-8?B?SzhxUUtCWEwxNjZreWJFODZiaWZKb2lnSGZTcjJnaDM0SlpOOVZSVnZ5eVBz?=
 =?utf-8?B?UjVOcm4yMSs5STBwQVp4bTdQU2lIVTBwOTc5U254V25qUklJSFV4azhTK1N6?=
 =?utf-8?B?VU4weVJZK0ZqdlgvYnJlWnFnc1o3V2wzN0hUb2ZDdHplVEdVMHVRdDVCZTJ2?=
 =?utf-8?B?NjJkUHkvVUFrTmxCU0pIbXJDZUh1SzU0ZE5lNWhFL1k3bG9qS25RZmxkWFVN?=
 =?utf-8?B?T3F4OHdEeUVHTSs4K0FDLy9ZMTl4TkM0eFNZRXJKR2VGUFZBQTNKMXJuNytT?=
 =?utf-8?B?dDYxWTQ3QlByb05mUXl6dkFjSDEwcWJqOHB5aTVQM25zY09qaFFtaExidEp3?=
 =?utf-8?B?UjdyWlgzNGZ2TVBDS2x4RDhQZEY2V1k1TTd6dUlhWUl1TjhtanhYVkg1VFpj?=
 =?utf-8?B?UWxoZnNZME1vT2dQMmtMVkdKV3JOTVR1OVpCODlXY0NjWUFnRUJoM2FpTGdJ?=
 =?utf-8?B?L3FldmRVS1lMNWZMQzQ5djl6aHlTUlBEYjVnREhRSnpOREVzaVV0MWpVV0R6?=
 =?utf-8?B?dGJYVEhFN3hMTHY3TW9lTVdhRHM3blVYSGpBT0NLcm5jWjBMNGlqS1RPSGJm?=
 =?utf-8?B?QzZaWUNrWjVSMFFzV25jKyt0Um9kV1hQZDk1aE9kS0pZam4rZ0tqUnpRZ2ZZ?=
 =?utf-8?B?MVN3WjFOYS9lYmR0d1hXRVY0KzJ1eTBMOVUzc1FXaldjaTdGYWVVMmt5eXJN?=
 =?utf-8?B?dml2alcyZEdvTjd0UWhkZGdIamo2ekVhK1RPVWxOeVY3MXJTcnBGaFJoNnJV?=
 =?utf-8?B?Q3cxMy9TTVltSDdtdnlyNGlzNTlUc1Fod3N2SUthc3NYcjhjQVVtdkJGMCtM?=
 =?utf-8?B?Mm01c21ZcGErS29qdE1GZ1hIZ3ByRU9SMGwrRW9yb2JJZCs4OFAycEpOU3Zi?=
 =?utf-8?B?L3ZGVE13OFp3eXNYRDBvWERMYWlQODVGaGZPZXEzdnl4dnVDeTdPUVg2Nmd3?=
 =?utf-8?B?MzZxQWQ2OVRIcmJpVUdNMXhTTUpiTk5ZcVlIMDFneVNGQUR1TTd2MDk3VTMv?=
 =?utf-8?B?ZVFFUU5zQ01wSmhGWkMwVzV3M044bTNvWitRUEhQSi9kVVJMUnBoemR3dVp2?=
 =?utf-8?B?MlFjTHJlc1kwYnNneVZoSEdyMStaaXZSaCtDRk14L3g3bGJveFBOYWFZd0Nk?=
 =?utf-8?B?SW1CamIzb1Jvd3RuSWdkUHRJeWhKakt0dW1GR0V4Z1hDZWlsd3Y0dz09?=
X-Exchange-RoutingPolicyChecked: NiJBBG+TEXlgFgClO9Sg27cMAxTD4+qf/ga8Qj6x3F6+GF6hZ201fJn2RPPeMlKsBqGeCXqMqwrNrBFQZzBryjMzvbBvDpLDNKu/XAJ0pJ7cd2r7d0vnCaMBBP90CNRi6WOB/emOthz2d/b61+6z1qgGhA9hYYi4KaJ6SwbL9XG4x5b46UxGmGvx9TDUz2JcuiTzi5Ad3lXnb+ku4F8fAChzn/sNNwlaGHW6RVezAa7KRKyByEAqIXB/SkHRf8r444gCaZdmVodV7X7q3DtZ1UBRa3rzP7gxwH0gze9eb+CZr8Hse05rWhEOQra6p4Hg/7L8RIdU8KinQZrUOoeKpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 572b02b4-c913-4c34-d1a1-08de8ef7172f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:28:23.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6FIm7gRXAE3vBwQyFZtPVF52VY2ZtlAZ0cJTzz8fEa+vTXVtgRE3DnPbUC0SNOejwg7sRfAPR6TlC/G6TfyIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231347-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.l.liu@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1AC90365669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 18:11, Zhenzhong Duan wrote:
> Kernel lacks dirty tracking support on nested domain attached to PASID,
> fails the attachment early if nesting parent domain is dirty tracking
> configured, otherwise dirty pages would be lost.
> 
> Cc: stable@vger.kernel.org
> Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/nested.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Good catch. Just one nit. I think the below fix tag is more accurate. SS
dirty was merged before PASID attachment. So this fix should be
backported since the first PASID nested domain attachment.

Fixes: 67f6f56b5912 ("iommu/vt-d: Add set_dev_pasid callback for nested 
domain")

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 2b979bec56ce..16c82ba47d30 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
>   	struct intel_iommu *iommu = info->iommu;
>   	struct dev_pasid_info *dev_pasid;
>   	int ret;
> @@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>   	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>   		return -EOPNOTSUPP;
>   
> +	if (s2_domain->dirty_ops)
> +		return -EINVAL;
> +
>   	if (context_copied(iommu, info->bus, info->devfn))
>   		return -EBUSY;
>   
> -	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
> +	ret = paging_domain_compatible(s2_domain, dev);
>   	if (ret)
>   		return ret;
>   


