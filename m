Return-Path: <stable+bounces-110222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC72A1993A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF3A854B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425821639E;
	Wed, 22 Jan 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgDfsOHs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C7216397;
	Wed, 22 Jan 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574772; cv=fail; b=hcGQH/2ufq6vrSYUwMZ4pH46rTJsod3m2e66nYgpFpAJZwtWnknCx9EPsXEnTG+mRGDcHEhGDItHD5YXTHVSeWDeEeFruDnO7OFLMT2yIlln+JmZax+mMo/Rhk4RAw0Cyxciou7HuCDUG8JiMnO74JrrlwPRyjQqKwNMrmHo5dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574772; c=relaxed/simple;
	bh=v7w6ITFSzNYC+00n5GNVYPAUhkC4jUbQBLrechS45k8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJyG6lDZODhT+PYx545jQLM/zF4fPoVr5lMIX3zeHIXOyiMjez0g3RhVqZTc9LcA8JPcb/gFqWgjs4q/bgA/DKWipwC3er2ZRWSOjTaukUC/Bkig0gDMNlU/2SmcLvKjL0EtjkxW7ji1FmVmGUFkik997jK1l/DNUhO0aaOSjp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgDfsOHs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737574770; x=1769110770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v7w6ITFSzNYC+00n5GNVYPAUhkC4jUbQBLrechS45k8=;
  b=LgDfsOHsE23KT7vy0Ynmve9rB9Be0X1L3HL+1ueJQd5KSsxgcRbL4JJU
   MmX+ZMPFbVTzbrFLpKhTGsh6OdGTZJWIXPvfaXHwbml1ND4NcCwJbgu63
   pzkD5BvfqYHRie1najqU+ut3RV/Y7WQex+5U87KRHJTBbdSgF+8sfBIh1
   o5iUgGnGsxwZbFXiKsWvgAVq6g+o1/lIBfuIE2o5i7T4gr4zFpuDsdSPV
   VbB7YZu2n357AzCWf8cE/Uv1UojZ5m0myfaGZl2Z28KEGPvK1pW6w1g6Y
   c3dE7rdMRb2neOKL0cRQ/rj/JjKsdVTwgUxudrPwqSle4zO44Q6IqKBcX
   g==;
X-CSE-ConnectionGUID: wldGy0tMS8WMnbxNpB3vUg==
X-CSE-MsgGUID: y8Q6jC7yRwuzDK8ZF/FCFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37750645"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="37750645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 11:39:29 -0800
X-CSE-ConnectionGUID: SiwJ/meDR/my3+o6RxzhEA==
X-CSE-MsgGUID: 4lAQtGwcSv6osOqWginixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="107783045"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 11:39:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 11:39:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 11:39:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 11:39:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp+JUtQ/yzl0Wx3Bo799GaUuqecpITNnWqDfpQR9+n4XKIo2jS7OndHnxAFpgFUFMxMPv+pa6ENFv3CmuCbx3nV72j8e3r7VxVVMk8nGXicXTGJejDqJy7sD2bPoo9G7VNz/KwM1RZyAwTRq6QlZcFt/1Mu9URyUhg9+fkMMNfb8XXmO2bVzt8F3I1KupUOqG9Z4lyMQia1+sTeVY0reSLXo7cr/jCVC+SiVYEmx7+IbPqfOHq0sLf4VRPe5gn2uq/Rd1+FhUO3RtPNN76toFfFXmG7NAW82Y/WmymNkegble0t6/IW3L58rUves8Cs0O7Fvwa8viyl4fb3nv6Uaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc7c+9fyfV0vQIzIWcZ8yEPoBDllsCWdY42LRC6d03E=;
 b=S7Z2yW67dnd4eFucr+mKcYTAxlcpo+Ja5SFIQHiS3cK5/GjmUB4gqHUYHO4fGo33JS37qvQWFsglYKF5K9yeWtOQIUpYKs6qF1n6nGGH9vp1X+lVwyLuw7lWQvUZ82jdxpyQk++nqCOIaPTYj23dXQI7cryUx2v0hVd3Yhrev/FR4qOrXH4xMZu21I3ZedeiRFPPjoTA/AhrfaBreKv3v5nyhFjB9js7IXglv86kx6REs8ncKyCSUM1WXXrmKd82nsk69U9dnmMIaXINP11UPBjGb52kc8hzu9wA+jgIwRTJc5akU400Pgz6eDfdpihI+HO/OMHB/REYcrCI+i4V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 19:38:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:38:59 +0000
Message-ID: <69e38457-1b84-4310-a4a7-6bae996384ba@intel.com>
Date: Wed, 22 Jan 2025 11:38:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] ibmvnic: Add tx check to prevent skb leak
To: Denis Arefev <arefev@swemel.ru>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Nick Child <nnac123@linux.ibm.com>, Dany Madden <drt@linux.ibm.com>,
	"Lijun Pan" <ljp@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
	"Michael Ellerman" <mpe@ellerman.id.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250120124611.51436-1-arefev@swemel.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250120124611.51436-1-arefev@swemel.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d64065-b3fa-4375-2ec7-08dd3b1c6aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVlrS01yZGpsZ1NLZEZSNjhVUDNZNTRoRko1S0x6ZDNQS0tQZmZvaW9Pb0FD?=
 =?utf-8?B?TjlJSkF2eVFmdmZrRldoRW9BUlJ1by9TUmZITnF4aXZHOFBBaUxBODlXSkZX?=
 =?utf-8?B?Unl6REowUmJ4L3RnczVmc3JJNEdraXRqamtzY2tHTXplR3krMkV5ZUordTkr?=
 =?utf-8?B?a2d4SlBqNFJYL0swbmlpNWN1SU4xZSt4TXJ5Ukx6Z2l3emhxOE9pOTlseVRu?=
 =?utf-8?B?Rmk1Sm54djdRRXVVMjBnRGpPa3lNb0diV0t2ZmpUWllqRmplTGRWR3BMZGpP?=
 =?utf-8?B?NFU0amYzSFhMM1B0T3d4L2VEQldlSDB5MW1sLy84MVRJWVc5RUYxTzh2TEZ0?=
 =?utf-8?B?SFVmK2x3cnJNNjMzWDJkZGlIYyt4S2h1Uk9VTDdvQWFOem5VUDViQU41aEZq?=
 =?utf-8?B?am5hYlh3SE90NldGVmFEakxtWjlqcUlzUXdjZUpkbkVjN2s0RXVFSG03UGtk?=
 =?utf-8?B?VjFrSHJjQi90YVpWeHg5ZlRaWUdXNFFEVzY1MytIR3RmVFJpczJqd0RpNUR1?=
 =?utf-8?B?UlExM2trRjdOaFV4Ulc3S3NsWXBnSnV5MUk0ZHBFMVVVQm9VRnFjNmxBVFZY?=
 =?utf-8?B?Q1VIcDRMMmtEVDJleXFBU3pqa1BSajNjZVF0c0Z5WlFLaFZMMk4zaXBvOU1i?=
 =?utf-8?B?eHlsT0dSUHFzTndGUmt6c3RvOTQwOU5xQjNSaGFhT3ljQ2tINnMrcU5PcUhy?=
 =?utf-8?B?ZE84Vm55WFYwTzllRDdjWmM0K3F2UEwwQWNFeGZsV0xkT0RrczBzaE8rZjFh?=
 =?utf-8?B?dFA2Zko4YVhWa05FN0dWWFE1c3UvT3Y1ZTBuVW9vWTNpUzZrcXZJaExndGd5?=
 =?utf-8?B?VFcwdnRKYTZVVjFlaGdpWnNGME1kVlZLMUlMa0NaaXRzQnhVdmpXSWxZbjBo?=
 =?utf-8?B?VjRkR0k0Y3VsOExXQkdiNzNKSW5pK3dLYzBiQkNMNk1kQVBXUk9SSnhrak9G?=
 =?utf-8?B?RCt2eHowOWJ4R2IzWUNQMUxHSUNKcFZybzB5N1g4cG5LR3ZwZjl0SE53U05w?=
 =?utf-8?B?V3lXYkE5TFRFcWhVbmVQZFp2aVhpQWFhMENIN0crdERGaG9wVnRPTXk2bkt5?=
 =?utf-8?B?NG9nc2ZvdVYxQlFpZzFramlzcFVoNFZVK05FOUthRTBHbERvOWhIZUF3ODQ5?=
 =?utf-8?B?RCsycU5xU01zeGdUbG5OVWpvc1JHWkZrQUt1cWo5emRJcnZHYy9ZWk50OGQ1?=
 =?utf-8?B?N2hEL1dPUExlZUpqdks5VFluVGdWMUI0RW9BcDRCNzVROUZ2VHpuTkV2Y2N2?=
 =?utf-8?B?NjVpdXEwMGFtSjFVc2VVUFJFclBxcHMrVW9DZFdWbnEyMWJyMWRDVGhMNXRw?=
 =?utf-8?B?SW9URE8vTjl0dEJtV20rektkSExydjIydXR0T2V1MHIrWTN0Zk9BTFNBSXRo?=
 =?utf-8?B?blhIc013WW1JZWxDamdjeVlNY0JGazd0VmxZZGlkODFOMVNBbXJoYStWaTlo?=
 =?utf-8?B?L0h0d3R0cDZmVUdNdUVDMC9OcG42ZndUSCt3K0RVVEVEZFdvODVNdG1HbFpN?=
 =?utf-8?B?azZia2VtR3ptckJPQ2g3SmdNVXJaU21WTzkvOFY4eVAxN1FzL2hGQ0dIVXVz?=
 =?utf-8?B?SWU0MFlNVFBZNE0xWjlrRE03LzhEazBCa1BWL1E3dXJiY292bTA0ZXFKeWR5?=
 =?utf-8?B?UmRnTUdLaUdpRnY3cFllVUJKZ1ZyVUFmNUhYbFE0UnVtbUJYRm51QXM2RkdR?=
 =?utf-8?B?WHFtUnVUbVk4OTkzN3NzNkQxNXl4VS9RVGZiMmJZUFRVbXlzWlNXV2lUTUtW?=
 =?utf-8?B?cnhNQlRHalNxVzJ6a1krR0VvR0pGd2ZqZTlOQ1JKRGNlMHhGWk5kaENEL3o0?=
 =?utf-8?B?ZDVlMis5QnhPTnVDTyt1Q0R6VEJwa1dONGp2VEp6S1Fzd2xEMFlWTlJTRnp1?=
 =?utf-8?Q?Nant5Tu/T3WIj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpBbFdXVEJiMnJGS2o2OTUvWkFjV1dzSldET2wzd0JTa3BoVkwrOXBTQ2Qy?=
 =?utf-8?B?TVJJb1Z5QWoxWVFMOC9wZE5iV2ZnUkdQSUo4QW5Gc3R6RnFhbTJxOXhENHdQ?=
 =?utf-8?B?R2lmWFprUzhzVlVFeXhWMHBOSENTc290ZnZSb3dqSE1Ga1BwLzc5WFZ1Umxr?=
 =?utf-8?B?bHhFZVdYQ21OVUVHbmhISGYvNjBCSXBpemxTbUlzampRNjdPK3d6MUgyeEdC?=
 =?utf-8?B?eW84VFhlNk1DSnVJY3kvdi9WVzdFUWt2RDBySWdyQnpZNkFXTDliaklwQko5?=
 =?utf-8?B?dlh6VDBKeUV6VWpvSk9EcjBYS1RXTUNJTm9NMWVpUVhkeVhTOTV1UHdCUXNY?=
 =?utf-8?B?cWhnd0JHVkEvZE1mUFBlRzM2OUk2Q05wQnE1S2l0cjlxQUR5ajdJVmVyemtJ?=
 =?utf-8?B?UFluY2JuN3VCQTE4ZWJtTlpOYlZ6L2lLU21oZ0wzNVhaUElMN0RQMlZIVC9L?=
 =?utf-8?B?ZlpOTC8vSkp1c25ua3REVkhGdXM1b0JWS0lVYVhoVEVaaVZVRCtXWDFpUi9h?=
 =?utf-8?B?dkFLVkpUZHJ0Vk1STHZlZXJ5cHN4bXRsYVljWVZ6UU1XV29kV3Q4MW9ENlQ3?=
 =?utf-8?B?dG5vbjVGaTNCck5udDg3emRUSGpybnZsdGxvd2dIZHExTXZ6ZVZLT255dCsr?=
 =?utf-8?B?NmZiVjdacENmVnZQeHN6QStzNDd6MDNtekk5ZHpsZ0N4eGE2ODFmNWZmMm1Q?=
 =?utf-8?B?dWRJUXNaZzVqb212NW03TVJ5bXZyMFc2WGNMRHEwcm1Qa2cyaEkxNWV5VGY4?=
 =?utf-8?B?NmZScHRQMjRlTk14UDUxbTRwUDB3YmtpZnBBUFFMR1BxdEVhak5TdHhWOGNa?=
 =?utf-8?B?M1NsbFB5aTFrV1RJWDFiVUhFeEwyNHkzTnJEVE5pSmRJV2FaYTJmaUZxVDlK?=
 =?utf-8?B?b08vTzhRaG5RTTFjYkVuWkhudXpFYStWaGsxdks3OTVhRzBkUmtVQTRZaUNp?=
 =?utf-8?B?K1JrcEQ5K0c4YkJKYTd2WGZWS1RQdDhTVFhkaW9YbHJ6cUt1akZrRU1Bdjha?=
 =?utf-8?B?WlIwRDJRVHZyRDJsd0dBMkt0enBkQmZkWEhoemV4ODFHQ2s3VW5Udkh2STFo?=
 =?utf-8?B?TkoyOVNaZ1NQUU9TWkZIck0xTHV1K3IxSU51UjhyYmQ2a3dkZlZUaUFoSkw5?=
 =?utf-8?B?T3VsMGVNWjRXbmRIaXpkZkFIVVBIOGNqM2diZTlKT1VYYVU0a281QmE1My9y?=
 =?utf-8?B?YlQyb29xeEJCVUlkVGdpWnBwckNRSlF3WmYrcnlQU0xnWWtFKyszbWFJeVFS?=
 =?utf-8?B?aUFDMkJ6QTNIbjlOejJkOHVybW96RGdWK3dYT0pzS3VDMUVwTTdRUnJ2THZK?=
 =?utf-8?B?MDRGbE85WXdLRktkVzRaKzFBS090YWs4dG5NeTllV2FlSU4vWThtS1BVZm5k?=
 =?utf-8?B?L0F6Y1EyRFhWT1p3MXg1Wm9FaHNMbm94cnVzVEZEWTd5WXBUL3hWTzRpVDYz?=
 =?utf-8?B?Vml5OGhjUFFncUpnYnB6QlR4UDZUZ2FWWVJzVm5iZUFlMllLNHU1TlgxTHZu?=
 =?utf-8?B?U0trbG9xY2lqNG9nWk15QjkvLzdNZXNidC80Rk11QktJV2hsbmM3cUlOWU1i?=
 =?utf-8?B?bGFnbFBSWVVpZHhnOHA0U210Y1J5T0NyV3lYa0JpbiszZWVXYi9WNFZPaity?=
 =?utf-8?B?NTBoRy90NU5TOS8vWXZ0RnhBaFkrcUM5TllpaDB4QTltUUpRaEp1VzlxNHIv?=
 =?utf-8?B?VFd1c3hBaVJSSmNSMmVabnkyNXJoRjBGd0dYamV0MHRzeFJQS2p1KzQ0K2xN?=
 =?utf-8?B?RGR2M0ErZWlFcmpLY002KzNXd2k2S2ljL1NCRzJEVEVENU5ZMkZudldITEZm?=
 =?utf-8?B?TlZxbXJpZmNhSjlsU29GQ1YzbGR5QlBVZU14Q25SUjFsRGkvMW8wZ2g1aFVS?=
 =?utf-8?B?WllUSEM2dmptYXcyRUJCc09UZFVkOWhxZjRCbVdSUEp0RmlVSHVwZWNBZlMr?=
 =?utf-8?B?M05uOVRlRElIQWFNdzd2QUVyb2tia3FnTVFNZWYvc3FnOTZDMFZNcTBCWmp6?=
 =?utf-8?B?OThkd3FlU2tkSkNXQ3c4dDU1emRZOElkcUc5c2pCUW9DYmFMK2MvMzlydDFm?=
 =?utf-8?B?U0U0UG04ZlU3ZnZMZko4amV4RlhzQVA0c1F2b25kRlg0bXVaK0NSZW1DMFh2?=
 =?utf-8?Q?Rr7XHgdlXPQnVlXf7vMSY2wyz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d64065-b3fa-4375-2ec7-08dd3b1c6aa2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:38:59.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okbzCztgKPC6nMF3O3xmz9Wm6FdJ/mrXxjkmtu+Gjp33Jukt11qFZH77gJ4C1EpajWau2T1+CEFy8KXuuGPf2w2cKq20Ai4/wDkhMb3J7no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com



On 1/20/2025 4:46 AM, Denis Arefev wrote:
> From: Nick Child <nnac123@linux.ibm.com>
> 
> From: Nick Child <nnac123@linux.ibm.com>
> 
> commit 0983d288caf984de0202c66641577b739caad561 upstream.
> 
> Below is a summary of how the driver stores a reference to an skb during
> transmit:
>     tx_buff[free_map[consumer_index]]->skb = new_skb;
>     free_map[consumer_index] = IBMVNIC_INVALID_MAP;
>     consumer_index ++;
> Where variable data looks like this:
>     free_map == [4, IBMVNIC_INVALID_MAP, IBMVNIC_INVALID_MAP, 0, 3]
>                                                	consumer_index^
>     tx_buff == [skb=null, skb=<ptr>, skb=<ptr>, skb=null, skb=null]
> 
> The driver has checks to ensure that free_map[consumer_index] pointed to
> a valid index but there was no check to ensure that this index pointed
> to an unused/null skb address. So, if, by some chance, our free_map and
> tx_buff lists become out of sync then we were previously risking an
> skb memory leak. This could then cause tcp congestion control to stop
> sending packets, eventually leading to ETIMEDOUT.
> 
> Therefore, add a conditional to ensure that the skb address is null. If
> not then warn the user (because this is still a bug that should be
> patched) and free the old pointer to prevent memleak/tcp problems.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [Denis: minor fix to resolve merge conflict.]
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---

I thought the process asked to have the stable tag, i.e.

Cc: <stable@vger.kernel.org> # 5.10.x

Anyways, this looks good to me, and seems like a good candidate for
backporting.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

> Backport fix for CVE-2024-41066
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-41066
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 84da6ccaf339..439796975cbf 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1625,6 +1625,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
>  
>  	tx_buff = &tx_pool->tx_buff[index];
> +
> +	/* Sanity checks on our free map to make sure it points to an index
> +	 * that is not being occupied by another skb. If skb memory is
> +	 * not freed then we see congestion control kick in and halt tx.
> +	 */
> +	if (unlikely(tx_buff->skb)) {
> +		dev_warn_ratelimited(dev, "TX free map points to untracked skb (%s %d idx=%d)\n",
> +				     skb_is_gso(skb) ? "tso_pool" : "tx_pool",
> +				     queue_num, bufidx);
> +		dev_kfree_skb_any(tx_buff->skb);
> +	}
> +
>  	tx_buff->skb = skb;
>  	tx_buff->data_dma[0] = data_dma_addr;
>  	tx_buff->data_len[0] = skb->len;


